# CE 01, Sun 1 Nov 2026 00:15: one Team job, the C-79a FINALIZER (Opus), train_c79a_finalizer_job.txt. Installs NOTHING. Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c79af.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\c79af\out', 'C:\CE_WORK\scratch\c79af\tmp' | Out-Null
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
if ($free -lt 27) { Log "C: has $free GB free, under the 27 GB floor: finalizer not started"; exit }
$job = "$d\train_c79a_finalizer_job.txt"; $lg = "$d\train_c79a_finalizer_job.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log "starting train_c79a_finalizer_job.txt (opus), C: $free GB free"
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
Log 'finished train_c79a_finalizer_job.txt'
if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your|/login')) { Log 'finalizer log ends with a login or limit line: the desk reads it'; exit }
Log 'lane finished'
