# CE 05 bug pipeline, Fri 30 Oct 2026: one Team job (p3). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_g85.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($k in 's6') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $model = 'sonnet'; if ($k -eq 'c' -or $k -eq 'h') { $model = 'opus' }
  $job = "$d\team_fix_$k.txt"; $lg = "$d\team_fix_$k.log"
  $cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\ce-scratch\s6\struc"&& set "CE_LOG_DIR_OVERRIDE=C:\ce-scratch\s6\logs"&& set "TEMP=C:\ce-scratch\s6\tmp"&& set "TMP=C:\ce-scratch\s6\tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting team_fix_${k} (${model})"
  $pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
  Log "finished team_fix_${k}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "team_fix_${k} log ends with a login or limit line: the desk reads it"; exit }
}
Log 'lane finished'