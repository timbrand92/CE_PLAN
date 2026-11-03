# CE 01, Wed 4 Nov 2026: B-177 R16v87 bisect, one Team Opus job (read-only analysis, local fix branch only). Installs NOTHING. Start with WMI Win32_Process Create.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_bisect119.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\p119_tmp', 'C:\CE_WORK\scratch\p119_logs', 'C:\CE_WORK\scratch\p119_struc' | Out-Null
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
if ($free -lt 29) { Log "C: has $free GB free, under the 29 GB floor: not started"; exit }
$job = "$d\bisect119_r16_job.txt"; $lg = "$d\bisect119_r16_job.log"
$cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\p119_struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\p119_logs"&& set "TEMP=C:\CE_WORK\scratch\p119_tmp"&& set "TMP=C:\CE_WORK\scratch\p119_tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Remove-Item 'C:\CE_PLAN\areas\R16_BISECT_04NOV.md' -ErrorAction SilentlyContinue
Log 'starting bisect119 (opus)'
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
Log 'finished bisect119: read areas\R16_BISECT_04NOV.md and bisect119_r16_job.log'