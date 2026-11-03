# CE 01, Sat 31 Oct 2026 23:10: one Team job, the C-79a assembler RESUME at step 4 (train_c79a_resume_job.txt), disk floor 24 GB for this job only (CE 00). Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c79a2.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\c79a\tmp', 'C:\CE_WORK\scratch\c79a\logs', 'C:\CE_WORK\scratch\c79a\struc' | Out-Null
foreach ($k in 'resume') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $job = "$d\train_c79a_${k}_job.txt"; $lg = "$d\train_c79a_${k}_job.log"
  $cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\c79a\struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\c79a\logs"&& set "TEMP=C:\CE_WORK\scratch\c79a\tmp"&& set "TMP=C:\CE_WORK\scratch\c79a\tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting train_c79a_${k}_job.txt (sonnet)"
  $pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
  Log "finished train_c79a_${k}_job.txt"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "train_c79a_${k}_job log ends with a login or limit line: the desk reads it"; exit }
}
Log 'lane finished'
