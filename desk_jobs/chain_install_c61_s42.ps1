# Desk 23 Oct 2026: install C-61 (Civil 3.0.71 / Manager 1.1.71, candidate c1057) and S-42 (Structural 1.0.122, candidate s1040) when AutoCAD is free. Holds the Codex AutoCAD lane (STOP_CODEX.flag: the conveyor ends after its current job), waits for no acad.exe and no live lock, installs both with their verified install scripts, then lifts the hold and restarts the conveyor. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_install_c61_s42.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$rc = Get-Content 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1057_REPORT.md' -Raw
$rs = Get-Content 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_S1040_REPORT.md' -Raw
if ($rc -notmatch 'verified 828, bad 0, extra 0' -or $rc -notmatch 'verified 75, bad 0, extra 0' -or $rs -notmatch 'verified 2007, bad 0, extra 0') { Log 'payload report not clean: stop for the desk'; exit }
Set-Content "$d\STOP_CODEX.flag" 'install hold c61 s42'
Log 'payload reports clean; Codex lane held (STOP_CODEX.flag); waiting for AutoCAD and the lock to be free'
$w = 0
while ($true) {
  $lock = $false
  $lk = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lk) { try { $j = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { $lock = $true } } catch { $lock = $true } }
  $acad = [bool](Get-Process acad, accoreconsole -ErrorAction SilentlyContinue)
  $guard = Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
  if (-not $lock -and -not $acad -and -not $guard) { Start-Sleep 90; if (-not (Get-Process acad -ErrorAction SilentlyContinue) -and -not (Test-Path $lk)) { break } }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
  Start-Sleep 60; $w++; if ($w -gt 240) { Log 'AutoCAD busy for 4 h: stop for the desk'; Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue; exit }
}
Log 'AutoCAD free: installing C-61'
$o1 = & pwsh -NoProfile -File "$d\scripts\desk_install_c61.ps1" 2>&1 | Out-String
Log ($o1.Trim().Split("`n")[-1])
if ($o1 -match 'INSTALL VERIFIED') {
  Log 'installing S-42'
  $o2 = & pwsh -NoProfile -File "$d\scripts\desk_install_s42.ps1" 2>&1 | Out-String
  Log ($o2.Trim().Split("`n")[-1])
} else { Log 'C-61 install not verified: S-42 not attempted; stop for the desk' }
Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'codex_conveyor' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch { } }
Start-Process pwsh -WindowStyle Hidden -ArgumentList "-NoProfile -File $d\codex_conveyor.ps1"
Log 'Codex hold lifted; conveyor restarted'
