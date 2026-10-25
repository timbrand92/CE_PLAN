# Desk 25 Oct 2026: apply the PR 1779 fixes (Team Sonnet), then the C-68 make chain below. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Lg($t) { Add-Content "$d\chain_c68_start.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
if (Test-Path "$d\STOP_CHAIN.flag") { exit }
$job = "$d\team_pr1779_fixes.txt"; $lg = "$d\team_pr1779_fixes.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Lg 'starting team_pr1779_fixes'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Lg 'finished team_pr1779_fixes'
if (-not (Test-Path 'C:\CE_PLAN\areas\release-v3-colleagues-PR1779_FIXES_APPLIED_25OCT.md')) { Lg 'no fixes report: stop for the desk'; exit }
& pwsh -NoProfile -File "$d\chain_c68_make.ps1"
