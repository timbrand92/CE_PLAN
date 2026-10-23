# Desk 24 Oct 2026 03:25: Team chain to use the Team weekly budget before its reset (Sat 14:00): PR pile triage (Sonnet) then three Opus review batches. Stop flag STOP_CHAIN.flag; nothing new after 13:45.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_team_triage.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($name, $model) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  if ([DateTime]::Now -ge [DateTime]'2026-10-24 13:45') { Log "past 13:45: stopping before $name"; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1); if ($free -lt 12) { Log "C: only $free GB: stop before $name"; exit }
  $job = "$d\$name.txt"; $lg = "$d\$name.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting $name ($model)"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished $name"
}
RunJob 'team_triage_job' 'sonnet'
RunJob 'team_review_pile_b1' 'opus'
RunJob 'team_review_pile_b2' 'opus'
RunJob 'team_review_pile_b3' 'opus'
Log 'chain complete'