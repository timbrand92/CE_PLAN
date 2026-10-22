# Desk 23 Oct 2026: Codex builds for FIX_BRIEFS_9NOV_2026-10-23.md FB-01..FB-10 (the first ten, recommended for train C-62), three lanes (14-16), started only when C: has room.
$dir = 'C:\Lisp Files\_CODEX_RUNNER'
$enc = New-Object Text.UTF8Encoding($false)
$b1 = [IO.File]::ReadAllText("$dir\cx_b01_automation_ids.txt")
$pre = $b1.Substring(0, $b1.IndexOf('TASK:'))
for ($n = 1; $n -le 10; $n++) {
  $id = 'FB-{0:00}' -f $n
  $task = "TASK: implement fix brief $id from C:\CE_PLAN\areas\FIX_BRIEFS_9NOV_2026-10-23.md (Opus fix-brief factory, 23 Oct; read the whole $id section, its 'where in the code', 'what must NOT change', the unit test and the deterministic real-AutoCAD check). Verify the described cause in the code at the base FIRST: if the bug is already fixed at origin/claude/rel-20261022m (the brief file says 50 of 252 open bugs were fixed under hunt labels), say so in your report and stop without a PR. Every commit message must name each bug number in full (BUG-nnn), never a range. Branch cx/fb$('{0:00}' -f $n)-c60, DRAFT pull request against claude/rel-20261022m. Report C:\CE_PLAN\areas\CODEX_BUILD_FB$('{0:00}' -f $n)_23OCT.md (ANSWER FIRST: PR number, head, tests, totals, the exact deterministic real-AutoCAD check) pushed by name from C:\CE_PLAN."
  [IO.File]::WriteAllText("$dir\cx_fb$('{0:00}' -f $n).txt", $pre + "`n" + $task + "`n", $enc)
}
$wt = 'C:/Lisp Files/_CODEX_RUNNER'
function L($n) { "$n|$wt|gpt-6.1-sol|high|98|6" }
$lanes = @{ 14 = @(1, 4, 7, 10); 15 = @(2, 5, 8); 16 = @(3, 6, 9) }
foreach ($k in $lanes.Keys) {
  $a = ($lanes[$k] | ForEach-Object { '"' + (L ('cx_fb{0:00}' -f $_)) + '"' }) -join ' '
  $sh = "#!/usr/bin/env bash`ncd `"C:/Lisp Files/_CODEX_RUNNER`"`nMAXC=9 bash queue3.sh $a >> `"C:/CE_PLAN/desk_jobs/codex_lane$k.out`" 2>&1`n"
  [IO.File]::WriteAllText("C:\CE_PLAN\desk_jobs\codex_lane$k.sh", $sh, $enc)
}
@'
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
'@ | Set-Content C:\CE_PLAN\desk_jobs\codex_lanes_start4.ps1 -Encoding utf8
"written FB briefs and lanes 14-16"
