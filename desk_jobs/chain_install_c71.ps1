# Desk 27 Oct 2026: install C-71 (Civil 3.0.81 / Manager 1.1.81, six follow-up fixes, Civil only) when its payload report is clean, C-70 is installed and AutoCAD is free. Structural is not in this train. NOT STARTED by the job that wrote it: the desk starts it after a GO.
# Waits for the payload report PAYLOAD_C1067_REPORT.md, then waits until the C-70 install chain has finished and the installed Civil line reads 3.0.80, then holds the Codex AutoCAD lane (STOP_CODEX.flag: the conveyor ends after its current job), waits until AutoCAD, the shared lock, the settings guard AND every Codex AutoCAD job (any process whose command line holds both 'codex exec' and '_TEST_COPIES') are clear, CLAIMS the shared AutoCAD lock itself the moment it is free (the test runner takes the lock back within seconds otherwise), installs with scripts\desk_install_c71.ps1, releases the lock, lifts the hold and restarts the conveyor. Lesson of 27 Oct 06:02: the install script refuses to touch the bundle while a Codex AutoCAD job runs, so the chain waits for that too before it claims the lock (as chain_install_s45b.ps1 does). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_install_c71.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1067_REPORT.md'
$w = 0
while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 120; $w++; if ($w -gt 240) { Log 'no payload report after 8 h: stop for the desk'; exit } }
Start-Sleep 30
$rc = Get-Content $rep -Raw
if ($rc -notmatch 'verified \d+, bad 0, extra 0' -or ([regex]::Matches($rc, 'verified \d+, bad 0, extra 0')).Count -lt 2) { Log 'payload report not clean: stop for the desk'; exit }
# C-71 sits on C-70: never install it before the C-70 install chain has finished (a second install would race the first on the same bundle folders).
$w = 0
while ($true) {
  $c70run = [bool](Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_install_c70\.ps1' -and $_.Name -match 'pwsh' })
  $p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Legacy\CE_CVL_SUITE.dll'
  $pv = ''
  if (Test-Path -LiteralPath $p) { $pv = (Get-Item -LiteralPath $p).VersionInfo.ProductVersion }
  if ((-not $c70run) -and $pv.StartsWith('3.0.80')) { break }
  if ($w -eq 0) { Log ('waiting for the C-70 install: installed Civil reads [' + $pv + '], C-70 install chain running ' + $c70run) }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Start-Sleep 120; $w++
  if ($w -gt 240) { Log 'C-70 not installed after 8 h: stop for the desk'; exit }
}
Set-Content "$d\STOP_CODEX.flag" 'install hold c71'
Log 'payload report clean and C-70 installed; Codex lane held (STOP_CODEX.flag); waiting for AutoCAD, the lock and every Codex AutoCAD job to be clear'
$lk = 'C:\ce_rc_drv\ACAD_LOCK.json'
$w = 0; $mine = $false
while ($true) {
  $live = $false
  if (Test-Path $lk) { try { $j = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { $live = $true } } catch { $live = $true } }
  $acad = [bool](Get-Process acad, accoreconsole -ErrorAction SilentlyContinue)
  $guard = Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
  $cl = [bool](Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match "codex exec" -and $_.CommandLine -match "_TEST_COPIES" -and $_.CommandLine -notmatch "Get-CimInstance" })
  if (-not $live -and -not $acad -and -not $guard -and -not $cl) {
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $rec = [ordered]@{ who = 'Desk-install-c71'; pid = $PID; acad_pid = 0; acad_start = 0; since = $now; since_text = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); refreshed = $now; note = 'claimed by the C-71 install chain'; expires = ($now + 900); expires_text = (Get-Date).AddMinutes(15).ToString('yyyy-MM-dd HH:mm:ss') }
    ($rec | ConvertTo-Json) | Set-Content $lk -Encoding UTF8
    Start-Sleep 20
    $chk = $null; try { $chk = Get-Content $lk -Raw | ConvertFrom-Json } catch { }
    if ($chk -and $chk.who -eq 'Desk-install-c71' -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { $mine = $true; break }
    Log 'lost the lock race: waiting again'
  }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
  Start-Sleep 10; $w++; if ($w -gt 2880) { Log 'AutoCAD busy for 8 h: stop for the desk'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
}
Log 'AutoCAD free and lock claimed: installing C-71'
$o1 = & pwsh -NoProfile -File "$d\scripts\desk_install_c71.ps1" 2>&1 | Out-String
Log ($o1.Trim().Split("`n")[-1])
if ($o1 -notmatch 'INSTALL VERIFIED') { Log 'C-71 install not verified: stop for the desk (Codex hold lifted below)' }
try { $chk = Get-Content $lk -Raw | ConvertFrom-Json; if ($chk.who -eq 'Desk-install-c71') { Remove-Item $lk -Force } } catch { }
Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'codex_conveyor' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch { } }
Log 'lock released; Codex hold lifted; the supervisor restarts the conveyor'
