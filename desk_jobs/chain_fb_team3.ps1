# Desk 24 Oct 2026 03:55: Opus Team chain: runs fix batches 15, 14, 13, 12, 11 (carpark BUG-1035..1087 in fives, from the high end) while chain_fb_team2.ps1 works Sonnet from the low end; skips a batch whose log already exists. Spends the Team weekly budget before its reset (Sat 14:00). Stop flag STOP_CHAIN.flag; nothing new after 13:45; stops under 12 GB free.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fb_team3.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 15, 14, 13, 12, 11) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  if ([DateTime]::Now -ge [DateTime]'2026-10-24 13:45') { Log "past 13:45: stopping before batch $b"; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1); if ($free -lt 12) { Log "C: only $free GB: chain stops before batch $b"; exit }
  $job = "$d\fb_team_b$b.txt"; $lg = "$d\fb_team_b$b.log"
  if (Test-Path $lg) { Log "batch $b already started by the other chain: skipped"; continue }
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting batch $b (opus)"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished batch $b"
}
Log 'chain complete'