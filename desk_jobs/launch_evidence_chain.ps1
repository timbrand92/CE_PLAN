# Desk 17 Oct: waits for AutoCAD/Codex/robot to be absent, then runs evidence job 1 then job 2 (Team, Sonnet), one at a time.
$sp = 'C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-acad-tim-desk-d44f6a\d6e0ff91-5f8e-4486-a3dc-c3a8f5052d5a\scratchpad'
function Busy { $a = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count; $r = @(Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run2|evidence_job' }).Count; $c = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'queue3|codex exec' -and $_.CommandLine -match 'queue3.*verifyW|-C\s+\W?C:.Lisp Files._TEST_COPIES' -and $_.CommandLine -notmatch 'Get-CimInstance' }).Count; return ($a + $r + $c) }
foreach ($j in 'evidence_job1.txt', 'evidence_job2.txt') {
  while ((Busy) -gt 0) { Start-Sleep 120 }
  Start-Sleep 90; if ((Busy) -gt 0) { continue }
  $out = & 'C:\CE_PLAN\desk_jobs\launch_job.ps1' -JobFile (Join-Path $sp $j) -Model sonnet
  $pidn = if ("$out" -match 'pid (\d+)') { [int]$Matches[1] } else { 0 }
  Add-Content 'C:\CE_PLAN\desk_jobs\evidence_chain.log' ("{0} started {1} pid {2}" -f (Get-Date -Format 'ddd HH:mm'), $j, $pidn)
  if ($pidn -gt 0) { Wait-Process -Id $pidn -ErrorAction SilentlyContinue }
  Add-Content 'C:\CE_PLAN\desk_jobs\evidence_chain.log' ("{0} finished {1}" -f (Get-Date -Format 'ddd HH:mm'), $j)
}
