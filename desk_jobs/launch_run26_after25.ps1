# Desk 18 Oct: waits for robot pass 4 (tester_run25) to end and AutoCAD/Codex to be absent, then launches robot pass 5 (tester_run26: Q4 isolated settings profile).
$sp = 'C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-acad-tim-desk-d44f6a\d6e0ff91-5f8e-4486-a3dc-c3a8f5052d5a\scratchpad\tester_run26.txt'
function Busy { $a = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count; $r = @(Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run2|evidence_job' }).Count; $c = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'queue3|codex exec' -and $_.CommandLine -match 'queue3.*verifyW|-C\s+\W?C:.Lisp Files._TEST_COPIES' -and $_.CommandLine -notmatch 'Get-CimInstance' }).Count; return ($a + $r + $c) }
while ((Busy) -gt 0) { Start-Sleep 120 }
Start-Sleep 120; if ((Busy) -gt 0) { while ((Busy) -gt 0) { Start-Sleep 120 } }
Copy-Item $sp 'C:\CE_PLAN\desk_jobs\tester01_job_latest.txt' -Force
& 'C:\CE_PLAN\desk_jobs\launch_job.ps1' -JobFile $sp -Model sonnet
Add-Content 'C:\CE_PLAN\desk_jobs\evidence_chain.log' ("{0} launched tester_run26 after run 25" -f (Get-Date -Format 'ddd HH:mm'))
