# Desk 23 Oct 2026: start Codex lanes 14, 15, 16 (FB-01..10 fixes) one after another when C: has more than 24 GB free.
$bash = 'C:\Program Files\Git\bin\bash.exe'
foreach ($n in 14, 15, 16) {
  $w = 0
  while (((Get-PSDrive C).Free / 1GB) -lt 24) { Start-Sleep 300; $w++; if ($w -gt 48) { Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' "lane $n not started: C: under 24 GB for 4 h"; exit } }
  if (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag') { exit }
  Start-Process -FilePath $bash -ArgumentList "C:/CE_PLAN/desk_jobs/codex_lane$n.sh" -WindowStyle Hidden
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' ("{0} lane {1} started from codex_lane{1}.sh" -f (Get-Date -Format 'ddd HH:mm'), $n)
  Start-Sleep 900
}
