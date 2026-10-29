# CE 01 Build, 29 Oct 2026: CEMEMBER window plan and picture (read-only design job, no dotnet). Sonnet. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
Add-Content "$d\chain_plan_cemember.log" ("{0} starting team_plan_cemember" -f (Get-Date -Format 'ddd HH:mm'))
$job = "$d\team_plan_cemember.txt"; $lg = "$d\team_plan_cemember.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Add-Content "$d\chain_plan_cemember.log" ("{0} finished team_plan_cemember" -f (Get-Date -Format 'ddd HH:mm'))