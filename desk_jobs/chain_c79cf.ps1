# CE 01, Sun 1 Nov 2026 11:52: one Team job, the C-79c FINALIZER (Opus), train_c79c_finalizer_job.txt. Installs NOTHING. Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c79cf.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\c79cf\out', 'C:\CE_WORK\scratch\c79cf\tmp' | Out-Null
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
$tries = 0
while ($free -lt 27 -and $tries -lt 24) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Log "C: has $free GB free, under the 27 GB floor: waiting"; Start-Sleep -Seconds 300; $tries++
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
}
if ($free -lt 27) { Log "C: still $free GB after 2 hours: finalizer not started"; exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$job = "$d\train_c79c_finalizer_job.txt"; $lg = "$d\train_c79c_finalizer_job.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log "starting train_c79c_finalizer_job.txt (opus), C: $free GB free"
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
Log 'finished train_c79c_finalizer_job.txt'
if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your|/login')) { Log 'finalizer log ends with a login or limit line: the desk reads it'; exit }
Log 'lane finished'
