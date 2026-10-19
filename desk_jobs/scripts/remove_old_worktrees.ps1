# Remove worktree DIRECTORIES untouched since before 18 Oct 00:00 whose work is clean and pushed. Branches and PRs are never touched (Tim D6).
$root = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees'
$main = 'C:\Lisp Files\CE_ACAD_PLUGIN'
$cut = [datetime]'2026-10-19 15:00'
$before = (Get-PSDrive C).Free / 1GB
$removed = 0; $kept = 0
foreach ($d in Get-ChildItem $root -Directory | Where-Object { $_.LastWriteTime -lt $cut -and $_.Name -ne 'ce-acad-tim-desk-d44f6a' }) {
  $st = & git -C $d.FullName status --porcelain 2>&1
  if ($st) { $kept++; continue }
  $head = (& git -C $d.FullName rev-parse HEAD 2>&1)
  $remote = & git -C $d.FullName branch -r --contains $head 2>&1
  if (-not $remote -or "$remote" -match 'fatal') { $kept++; continue }
  & git -C $main worktree remove --force $d.FullName 2>&1 | Out-Null
  if (Test-Path $d.FullName) { $kept++ } else { $removed++ }
}
& git -C $main worktree prune 2>&1 | Out-Null
'removed {0} kept {1}; C: free GB before {2:N1} after {3:N1}' -f $removed, $kept, $before, ((Get-PSDrive C).Free / 1GB)
