# Desk 23 Oct 2026 evening: run fix-brief Team batches 1 to 4 one after another (Sonnet, Team account). Stop flag STOP_CHAIN.flag.
# Started through WMI, which gives cmd no user PATH, so the command line sets PATH and the Team config folder itself (same form as the working phase 2 relaunch).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fb_team.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 1..4) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  if ($free -lt 12) { Log "C: only $free GB: chain stops before batch $b"; exit }
  $job = "$d\fb_team_b$b.txt"; $lg = "$d\fb_team_b$b.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting batch $b"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished batch $b"
}
Log 'chain complete'
