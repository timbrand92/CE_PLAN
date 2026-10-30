# CE 01 Build, 29 Oct 2026: C-78 backlog resume lane r3 (engineering numbers, pilot-critical fixes). Starts when chain_fix_c77_l1\.ps1 has ended. Builds stay one at a time across lanes (the job texts wait while another dotnet build or test runs). Nothing is installed. Stop flag STOP_CHAIN.flag. Jobs c and h run on Opus, the rest on Sonnet.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_g61.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($k in 'b028b') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $model = 'sonnet'; if ($k -eq 'c' -or $k -eq 'h') { $model = 'opus' }
  $job = "$d\team_fix_$k.txt"; $lg = "$d\team_fix_$k.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting team_fix_${k} (${model})"
  $pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
  Log "finished team_fix_${k}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "team_fix_${k} log ends with a login or limit line: the desk reads it"; exit }
}
Log 'lane finished'