# Desk 25 Oct 2026: after chain_c66 (assembler, finalizer, payload) has ended, run team_apply_review_fixes_civil on Team Sonnet (disk: one build chain at a time). Stop flag STOP_CHAIN.flag; stops under 12 GB free on C:.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_apply_fixes.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'waiting for chain_c66 to end'
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c66\.ps1' -and $_.Name -match 'pwsh' }) { Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
if ($free -lt 12) { Log "C: only $free GB: waiting"; while ([math]::Round((Get-PSDrive C).Free / 1GB, 1) -lt 12) { Start-Sleep 300 } }
$job = "$d\team_apply_review_fixes_civil.txt"; $lg = "$d\team_apply_review_fixes_civil.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting team_apply_review_fixes_civil'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished team_apply_review_fixes_civil'