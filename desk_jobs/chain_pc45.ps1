# Desk 25 Oct 2026: Team (Sonnet) pilot-critical fix batches 4 (positions 34 to 47) and 5 (positions 48 to 60), one after another (disk: one build at a time). Stop flag STOP_CHAIN.flag; stops under 12 GB free on C:.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_pc45.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 4, 5) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  if ($free -lt 12) { Log "C: only $free GB: chain stops before batch $b"; exit }
  $job = "$d\team_pilot_critical_$b.txt"; $lg = "$d\team_pilot_critical_$b.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting batch $b"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished batch $b"
}
Log 'chain complete'