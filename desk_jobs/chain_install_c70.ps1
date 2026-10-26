# Desk 26 Oct 2026: install C-70 (Civil 3.0.80 / Manager 1.1.80, the BUG-861 diagnostic build) when its payload report is clean, C-69 is installed and AutoCAD is free. Structural is not in this train.
# Waits for the payload report PAYLOAD_C1066_REPORT.md, then waits until the C-69 install chain has finished and the installed Civil line reads 3.0.79, then holds the Codex AutoCAD lane (STOP_CODEX.flag: the conveyor ends after its current job), CLAIMS the shared AutoCAD lock itself the moment it is free (the test runner takes the lock back within seconds otherwise), installs with scripts\desk_install_c70.ps1, releases the lock, lifts the hold and restarts the conveyor. Stop flag STOP_CHAIN.flag. DO NOT START THIS FROM THE JOB THAT WROTE IT: the desk starts it after a GO.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_install_c70.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1066_REPORT.md'
$w = 0
while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 120; $w++; if ($w -gt 240) { Log 'no payload report after 8 h: stop for the desk'; exit } }
Start-Sleep 30
$rc = Get-Content $rep -Raw
if ($rc -notmatch 'verified \d+, bad 0, extra 0' -or ([regex]::Matches($rc, 'verified \d+, bad 0, extra 0')).Count -lt 2) { Log 'payload report not clean: stop for the desk'; exit }
# C-70 sits on C-69: never install it before the C-69 install chain has finished (a second install would race the first on the same bundle folders).
$w = 0
while ($true) {
  $c69run = [bool](Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_install_c69\.ps1' -and $_.Name -match 'pwsh' })
  $p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Legacy\CE_CVL_SUITE.dll'
  $pv = ''
  if (Test-Path -LiteralPath $p) { $pv = (Get-Item -LiteralPath $p).VersionInfo.ProductVersion }
  if ((-not $c69run) -and $pv.StartsWith('3.0.79')) { break }
  if ($w -eq 0) { Log ('waiting for the C-69 install: installed Civil reads [' + $pv + '], C-69 install chain running ' + $c69run) }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Start-Sleep 120; $w++
  if ($w -gt 240) { Log 'C-69 not installed after 8 h: stop for the desk'; exit }
}
Set-Content "$d\STOP_CODEX.flag" 'install hold c70'
Log 'payload report clean and C-69 installed; Codex lane held (STOP_CODEX.flag); waiting for AutoCAD and the lock to be free'
$lk = 'C:\ce_rc_drv\ACAD_LOCK.json'
$w = 0; $mine = $false
while ($true) {
  $live = $false
  if (Test-Path $lk) { try { $j = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { $live = $true } } catch { $live = $true } }
  $acad = [bool](Get-Process acad, accoreconsole -ErrorAction SilentlyContinue)
  $guard = Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
  if (-not $live -and -not $acad -and -not $guard) {
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $rec = [ordered]@{ who = 'Desk-install-c70'; pid = $PID; acad_pid = 0; acad_start = 0; since = $now; since_text = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); refreshed = $now; note = 'claimed by the C-70 install chain'; expires = ($now + 900); expires_text = (Get-Date).AddMinutes(15).ToString('yyyy-MM-dd HH:mm:ss') }
    ($rec | ConvertTo-Json) | Set-Content $lk -Encoding UTF8
    Start-Sleep 20
    $chk = $null; try { $chk = Get-Content $lk -Raw | ConvertFrom-Json } catch { }
    if ($chk -and $chk.who -eq 'Desk-install-c70' -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { $mine = $true; break }
    Log 'lost the lock race: waiting again'
  }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
  Start-Sleep 10; $w++; if ($w -gt 2880) { Log 'AutoCAD busy for 8 h: stop for the desk'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
}
Log 'AutoCAD free and lock claimed: installing C-70'
$o1 = & pwsh -NoProfile -File "$d\scripts\desk_install_c70.ps1" 2>&1 | Out-String
Log ($o1.Trim().Split("`n")[-1])
if ($o1 -notmatch 'INSTALL VERIFIED') { Log 'C-70 install not verified: stop for the desk (Codex hold lifted below)' }
try { $chk = Get-Content $lk -Raw | ConvertFrom-Json; if ($chk.who -eq 'Desk-install-c70') { Remove-Item $lk -Force } } catch { }
Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'codex_conveyor' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch { } }
Log 'lock released; Codex hold lifted; the supervisor restarts the conveyor'
