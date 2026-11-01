# CE 02 Mon 2 Nov 2026 07:00: install gate for CE 01's C-79a install (slot 11:30 to 12:30). From 10:45 the robot chain is stopped at a pack boundary (rolling ROBOT_STOP_AT); from 10:50 HOLD_ROBOT.flag stays up (text starts with 'CE 01', so the watchdog does not delete it) until CE 02 removes it after CE 01 says the install and read-back are finished. Codex batch scripts today end by 11:15. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\install_gate.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
L 'install gate waiting for 10:45'
while ((Get-Date) -lt [datetime]'2026-11-02 10:45') { Start-Sleep 30 }
L 'gate on: rolling ROBOT_STOP_AT'
$hold = $false
while ($true) {
  if (Test-Path "$d\INSTALL_GATE_RELEASED.txt") { Remove-Item "$d\ROBOT_STOP_AT.txt", "$d\HOLD_ROBOT.flag", "$d\INSTALL_GATE_RELEASED.txt" -Force -ErrorAction SilentlyContinue; L 'gate released'; break }
  Set-Content "$d\ROBOT_STOP_AT.txt" ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm'))
  if (-not $hold -and (Get-Date) -ge [datetime]'2026-11-02 10:50') { Set-Content "$d\HOLD_ROBOT.flag" "CE 01 install slot 11:30 to 12:30 (held by the CE 02 install gate; released when CE 01 says the install and read-back are finished)"; $hold = $true; L 'HOLD_ROBOT.flag up' }
  Start-Sleep 15
}
