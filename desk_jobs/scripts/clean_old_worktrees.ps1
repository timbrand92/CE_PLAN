# Remove ignored build output (bin/obj) only, from worktrees untouched since before 18 Oct 00:00. Branches, PRs and tracked files are never touched (Tim D6).
$root = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees'
$cut = [datetime]'2026-10-18 00:00'
$before = (Get-PSDrive C).Free / 1GB
$n = 0
foreach ($d in Get-ChildItem $root -Directory | Where-Object { $_.LastWriteTime -lt $cut -and $_.Name -ne 'ce-acad-tim-desk-d44f6a' }) {
  & git -C $d.FullName clean -fdXq 2>&1 | Out-Null
  $n++
}
'cleaned {0} old worktrees; C: free GB before {1:N1} after {2:N1}' -f $n, $before, ((Get-PSDrive C).Free / 1GB)
