# Desk 22 Oct 2026: start Codex lanes 9 and 10 (engineering fixes) when C: has room (more than 22 GB free), one after the other.
$bash = 'C:\Program Files\Git\bin\bash.exe'
foreach ($n in 9, 10) {
  $w = 0
  while (((Get-PSDrive C).Free / 1GB) -lt 22) { Start-Sleep 300; $w++; if ($w -gt 36) { Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' "lane $n not started: C: under 22 GB for 3 h"; exit } }
  if (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag') { exit }
  Start-Process -FilePath $bash -ArgumentList "C:/CE_PLAN/desk_jobs/codex_lane$n.sh" -WindowStyle Hidden
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' ("{0} lane {1} started from codex_lane{1}.sh" -f (Get-Date -Format 'ddd HH:mm'), $n)
  Start-Sleep 600
}
