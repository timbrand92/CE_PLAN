# Desk 24 Oct 2026 02:25: run Team fix batches 5 to 15 (carpark BUG-1035..1087) one after another (Sonnet, Team account) to spend the Team weekly budget before its reset (Sat 14:00). Stop flag STOP_CHAIN.flag; stops under 12 GB free on C:.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fb_team2.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 5..15) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  if ([DateTime]::Now -ge [DateTime]'2026-10-24 13:45') { Log 'Team resets at 14:00: stopping before batch ' + $b; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  if ($free -lt 12) { Log "C: only $free GB: chain stops before batch $b"; exit }
  $job = "$d\fb_team_b$b.txt"; $lg = "$d\fb_team_b$b.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting batch $b"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished batch $b"
}
Log 'chain complete'