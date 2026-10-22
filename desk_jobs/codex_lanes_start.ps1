# Desk 22 Oct 2026: start the three non-AutoCAD Codex lanes (one .sh file each; passing a long quoted command to Start-Process silently does nothing).
$bash = 'C:\Program Files\Git\bin\bash.exe'
foreach ($n in 1, 2, 3) {
  Start-Process -FilePath $bash -ArgumentList "C:/CE_PLAN/desk_jobs/codex_lane$n.sh" -WindowStyle Hidden
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' ("{0} lane {1} (re)started from codex_lane{1}.sh" -f (Get-Date -Format 'ddd HH:mm'), $n)
  Start-Sleep 25
}
