# Generic Team job runner for the queue feeder (CE 05, Mon 2 Nov 2026). Same method as chain_fix_g89.ps1.
# Usage: pwsh -File chain_fix_generic.ps1 -JobFile <full path> -Key <short key>
param([Parameter(Mandatory)][string]$JobFile, [Parameter(Mandatory)][string]$Key)
$d = 'C:\CE_PLAN\desk_jobs'
foreach ($p in 'struc','logs','tmp') { New-Item -ItemType Directory -Force ("C:\CE_WORK\scratch\$Key\" + $p) | Out-Null }
function Log($t) { Add-Content "$d\team_queue.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$first = (Get-Content $JobFile -TotalCount 1)
$model = 'sonnet'; if ($first -match 'MODEL:\s*(\w+)') { $model = $Matches[1] }
$lg = "$d\team_queue_logs\$Key.log"
New-Item -ItemType Directory -Force "$d\team_queue_logs" | Out-Null
$cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\' + $Key + '\struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\' + $Key + '\logs"&& set "TEMP=C:\CE_WORK\scratch\' + $Key + '\tmp"&& set "TMP=C:\CE_WORK\scratch\' + $Key + '\tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $JobFile + '" > "' + $lg + '" 2>&1'
Log "starting $Key ($model)"
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru
try { $pj.PriorityClass = 'BelowNormal' } catch {}
$pj.WaitForExit()
Log "finished $Key"
if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "$Key log ends with a login or limit line: stop"; Set-Content "$d\CHAIN_Q_STOPPED.txt" "$(Get-Date) $Key ended on a login/limit line (see team_queue_logs\$Key.log)" }
