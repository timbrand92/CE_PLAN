# CE 01 Build, 29 Oct 2026: C-77 backlog lane 1 (two lanes run in parallel; each job has its own private worktree under C:\ce-fx; dotnet stays one at a time across lanes because the job texts wait while another dotnet build or test runs, so the lanes overlap in reading, thinking and editing, not in builds). Nothing is installed. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_c77_l1.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
# Lane 1 starts after job a (already running from the first chain, started 10:20): wait until no process carries team_fix_c77a.txt in its command line.
$w = 0
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'team_fix_c77a\.txt' }) { Start-Sleep 60; $w++; if ($w -gt 600) { Log 'job a still running after 10 hours: lane 1 stops'; exit } }
Log 'job a finished: lane 1 continues'
foreach ($k in 'b','c','e','d') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $model = 'sonnet'; if ($k -eq 'g') { $model = 'opus' }
  $job = "$d\team_fix_c77$k.txt"; $lg = "$d\team_fix_c77$k.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting team_fix_c77${k} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished team_fix_c77${k}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "team_fix_c77${k} log ends with a login or limit line: the desk reads it"; exit }
}
Log 'lane finished'