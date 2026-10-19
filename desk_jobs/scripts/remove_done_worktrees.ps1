# Remove finished agent worktrees (directories only) whose work is fully pushed. Branches and PRs are never touched (Tim D6).
$root = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees'
$main = 'C:\Lisp Files\CE_ACAD_PLUGIN'
$desk = Join-Path $root 'ce-acad-tim-desk-d44f6a'
$before = (Get-PSDrive C).Free / 1GB
if (Get-Process dotnet, MSBuild, testhost -ErrorAction SilentlyContinue) { 'builds running: not removing'; exit 1 }
if (Test-Path 'C:\CE_PLAN\desk_jobs\build.lock') { 'build lock held: not removing'; exit 1 }
$removed = 0; $kept = 0
foreach ($d in Get-ChildItem $root -Directory | Where-Object { $_.Name -like 'agent-*' }) {
  if ($d.FullName -eq $desk) { continue }
  if (((Get-Date) - $d.LastWriteTime).TotalMinutes -lt 90) { "skip recent: $($d.Name)"; $kept++; continue }
  $st = & git -C $d.FullName status --porcelain 2>&1
  if ($st) { "skip dirty: $($d.Name)"; $kept++; continue }
  $head = (& git -C $d.FullName rev-parse HEAD 2>&1)
  $remote = & git -C $d.FullName branch -r --contains $head 2>&1
  if (-not $remote -or "$remote" -match 'fatal') { "skip not pushed: $($d.Name)"; $kept++; continue }
  & git -C $main worktree remove --force $d.FullName 2>&1 | Out-Null
  if (Test-Path $d.FullName) { "could not remove: $($d.Name)"; $kept++ } else { $removed++ }
}
& git -C $main worktree prune 2>&1 | Out-Null
'removed {0} kept {1}; C: free GB before {2:N1} after {3:N1}' -f $removed, $kept, $before, ((Get-PSDrive C).Free / 1GB)
