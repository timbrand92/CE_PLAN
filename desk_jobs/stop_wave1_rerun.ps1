# CE 02 Sun 1 Nov 16:27: spec_wave1 was ALL DONE (14:42) and wave1_resume restarted it from the first pack at 15:40. This writes a rolling ROBOT_STOP_AT.txt so chain4 stops at its next pack boundary, waits for chain4 to end, then removes the file so the retry spec can run.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\stop_wave1_rerun.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Chain { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'chain4\.ps1' }).Count -gt 0 }
L 'started'
while (Chain) { Set-Content "$d\ROBOT_STOP_AT.txt" ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15 }
Start-Sleep 20
Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'chain4 ended; ROBOT_STOP_AT.txt removed'
