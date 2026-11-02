# CE 02 Mon 2 Nov 2026 12:00: stops the 3.0.89 smoke chain at the next pack boundary (rolling ROBOT_STOP_AT) so the probe chain (spec_c79a_smoke2: N91 again, PROBE-DW389, PROBE-CDSYNC-BA2) can run at once; removes the stop file when no chain4 is left. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\stop_smoke_at_boundary.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
L 'rolling stop on'
while (@(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'spec_c79a_smoke\.txt' }).Count -gt 0) {
  Set-Content "$d\ROBOT_STOP_AT.txt" ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15
}
L 'smoke chain ended; releasing the stop file'
Start-Sleep 5
Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'done'
