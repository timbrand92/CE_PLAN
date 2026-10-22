# Desk 22 Oct 2026: start Codex lanes 4 to 8 (one .sh each).
$bash = 'C:\Program Files\Git\bin\bash.exe'
foreach ($n in 4, 5, 6, 7, 8) {
  Start-Process -FilePath $bash -ArgumentList "C:/CE_PLAN/desk_jobs/codex_lane$n.sh" -WindowStyle Hidden
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' ("{0} lane {1} started from codex_lane{1}.sh" -f (Get-Date -Format 'ddd HH:mm'), $n)
  Start-Sleep 20
}
