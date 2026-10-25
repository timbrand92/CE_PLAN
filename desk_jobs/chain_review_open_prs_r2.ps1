# Desk 25 Oct 2026: run team_review_open_prs_r2 on Team (sonnet). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_review_open_prs_r2.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\team_review_open_prs_r2.txt"; $lg = "$d\team_review_open_prs_r2.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting team_review_open_prs_r2'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished team_review_open_prs_r2'