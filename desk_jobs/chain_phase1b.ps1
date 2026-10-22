# Desk 23 Oct 2026: after the driver v3 phase 1 job (tester_run48) has finished, run phase 1b (tester_run49: fixes from the Opus review). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_phase1b.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$w = 0
while (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run48' }) { Start-Sleep 120; $w++; if ($w -gt 120) { Log 'phase 1 still running after 4 h: stop'; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
Log 'phase 1 finished: starting phase 1b'
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\tester_run49_driver_v3_fixes.txt" -Model sonnet
Log "$out"
