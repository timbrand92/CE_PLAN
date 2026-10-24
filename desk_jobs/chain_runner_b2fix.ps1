# Desk 24 Oct 2026 18:50: after chain_runner_phase3c finishes (hardening R01-R10, then batch 3), run tester_run57 (fixes asked by the batch 2 review + re-proof on 3.0.74). One AutoCAD driver job at a time. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_runner_b2fix.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'waiting for chain_runner_phase3c to finish'
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_runner_phase3c' -and $_.Name -match 'pwsh' }) { Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\tester_run57_runner_b2_fixes.txt"; $lg = "$d\tester_run57_runner_b2_fixes.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting tester_run57'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished tester_run57'
