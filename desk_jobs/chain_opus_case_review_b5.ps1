# Desk 27 Oct 2026: run team_opus_case_review_b5.txt (Team, Opus; read-only reviewer of the robot's ready cases) so the testing number can rise while Codex is at its weekly cap. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_opus_case_review_b5.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$job = "$d\team_opus_case_review_b5.txt"; $lg = "$d\team_opus_case_review_b5.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting team_opus_case_review_b5'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished team_opus_case_review_b5'
