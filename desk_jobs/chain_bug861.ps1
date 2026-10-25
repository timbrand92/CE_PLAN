# Desk 25 Oct 2026: run team_bug861_fix on Team Sonnet after the pattern 'chain_c67b?\.ps1' has ended (one build chain at a time on C:). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_bug861.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'waiting'
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c67b?\.ps1' -and $_.Name -match 'pwsh' }) { Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\team_bug861_fix.txt"; $lg = "$d\team_bug861_fix.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting team_bug861_fix'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished team_bug861_fix'