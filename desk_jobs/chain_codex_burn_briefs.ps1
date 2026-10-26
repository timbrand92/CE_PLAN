# Desk 26 Oct 2026: runs team_codex_burn_briefs.txt (Team, Sonnet; writes briefs only) so Codex has work for the burn before its weekly reset. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_codex_burn_briefs.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$job = "$d\team_codex_burn_briefs.txt"; $lg = "$d\team_codex_burn_briefs.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting team_codex_burn_briefs'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished team_codex_burn_briefs'
