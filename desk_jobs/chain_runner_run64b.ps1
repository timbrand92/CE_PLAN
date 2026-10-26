# Desk 26 Oct 2026: restart the robot's Codex-asks job (tester_run64_restart) after the C-69 install package report exists. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_runner_run64b.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'waiting for PAYLOAD_C1065_REPORT.md and the C-69 install'
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1065_REPORT.md'
$w = 0; while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { exit }; Start-Sleep 60; $w++; if ($w -gt 240) { Log 'no payload report after 4 hours: starting anyway'; break } }
Start-Sleep 600
$w = 0; while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_install_c69\.ps1' -and $_.Name -match 'pwsh' }) { Start-Sleep 60; $w++; if ($w -gt 180) { break } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\tester_run64_restart.txt"; $lg = "$d\tester_run64_restart.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting tester_run64_restart'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished tester_run64_restart'