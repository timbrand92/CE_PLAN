# Desk 22 Oct 2026 (Tim: "yes delete"): deletes Codex session logs (rollout-*.jsonl) that were written by HEADLESS test runs (originator codex_exec) and are older than N days. Never touches Tim's own Codex chats (other originators), files in use, or anything newer. Writes a manifest first. Usage: pwsh -File clean_codex_exec_rollouts.ps1 [-Days 3] [-WhatIf]
param([int]$Days = 3, [switch]$WhatIf)
$root = 'C:\Users\TimothyBrand\.codex\sessions'
$manifest = "C:\CE_PLAN\desk_jobs\codex_rollout_clean_$(Get-Date -Format 'yyyyMMdd_HHmm').csv"
$cut = (Get-Date).AddDays(-$Days)
$rows = @(); $freed = 0; $kept = 0; $skipped = 0
foreach ($f in Get-ChildItem $root -Recurse -File -Filter 'rollout-*.jsonl') {
  if ($f.LastWriteTime -ge $cut) { $kept++; continue }
  $first = $null
  try { $fs = [IO.File]::Open($f.FullName, 'Open', 'Read', 'ReadWrite'); $sr = New-Object IO.StreamReader($fs); $first = $sr.ReadLine(); $sr.Dispose(); $fs.Dispose() } catch { $skipped++; continue }
  if ($first -notmatch '"originator":"codex_exec"') { $kept++; continue }
  $rows += [pscustomobject]@{ path = $f.FullName; bytes = $f.Length; written = $f.LastWriteTime.ToString('yyyy-MM-dd HH:mm') }
}
$rows | Export-Csv $manifest -NoTypeInformation
"candidates: $($rows.Count) files, {0:N1} GB; kept (newer or not ours): $kept; skipped (in use): $skipped; manifest $manifest" -f (($rows | Measure-Object bytes -Sum).Sum / 1GB)
if ($WhatIf) { return }
foreach ($r in $rows) {
  try { Remove-Item -LiteralPath $r.path -Force -ErrorAction Stop; $freed += $r.bytes } catch { $skipped++ }
}
"deleted {0:N1} GB; skipped $skipped" -f ($freed / 1GB)
"C: free now {0:N1} GB" -f ((Get-PSDrive C).Free / 1GB)
