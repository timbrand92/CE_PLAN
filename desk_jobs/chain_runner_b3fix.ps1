# Desk 25 Oct 2026: run tester_run58 (fixes the hardening and batch 3 reviews asked) on Team Sonnet. One AutoCAD driver job at a time. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_runner_b3fix.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'tester_run5[5-7]' -and $_.Name -match 'cmd|claude' }) { Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\tester_run58_runner_b3_hardening_fixes.txt"; $lg = "$d\tester_run58_runner_b3_hardening_fixes.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting tester_run58'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished tester_run58'
