# Desk 24 Oct 2026 07:00: Opus review chain (chain_review_pile_d) over plan-work and fresh Team-batch PRs, to spend the Team weekly budget before its reset (Sat 14:00). Stop flag STOP_CHAIN.flag; nothing new after 13:45; stops under 12 GB free.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_review_pile_d.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 13, 15) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  if ([DateTime]::Now -ge [DateTime]'2026-10-24 13:45') { Log "past 13:45: stopping before batch $b"; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1); if ($free -lt 12) { Log "C: only $free GB: stop before batch $b"; exit }
  $job = "$d\team_review_pile_b$b.txt"; $lg = "$d\team_review_pile_b$b.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting review batch $b (opus)"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished review batch $b"
}
Log 'chain complete'