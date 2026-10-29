# CE 01 Build, 29 Oct 2026: B-046 pipe object ON for every login (one job, Sonnet). Builds follow the two-slot rule in the job text.
$d = 'C:\CE_PLAN\desk_jobs'
Add-Content "$d\chain_fix_c78_d.log" ("{0} starting team_fix_c78m" -f (Get-Date -Format 'ddd HH:mm'))
$job = "$d\team_fix_c78m.txt"; $lg = "$d\team_fix_c78m.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Add-Content "$d\chain_fix_c78_d.log" ("{0} finished team_fix_c78m" -f (Get-Date -Format 'ddd HH:mm'))