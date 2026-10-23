# Desk 23 Oct 2026 (Tim: "Delete the old installer archives in C:\Lisp Files\SUPERSEDED, keeping the newest 3? yes do this"): lists the folder, keeps the newest 3 items by last-write time, deletes the rest, writes a manifest first.
param([switch]$WhatIf)
$root = 'C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE'
$items = Get-ChildItem $root -Force | Sort-Object LastWriteTime -Descending
$rows = foreach ($i in $items) { $sz = if ($i.PSIsContainer) { (Get-ChildItem $i.FullName -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } else { $i.Length }; [pscustomobject]@{ name = $i.Name; dir = $i.PSIsContainer; bytes = [int64]$sz; written = $i.LastWriteTime.ToString('yyyy-MM-dd HH:mm') } }
$manifest = "C:\CE_PLAN\desk_jobs\superseded_clean_$(Get-Date -Format 'yyyyMMdd_HHmm').csv"
$rows | Export-Csv $manifest -NoTypeInformation
"found $($rows.Count) items, {0:N1} GB; keeping newest 3:" -f (($rows | Measure-Object bytes -Sum).Sum / 1GB)
$rows | Select-Object -First 3 | ForEach-Object { "  KEEP $($_.name) $($_.written) {0:N2} GB" -f ($_.bytes / 1GB) }
$del = $rows | Select-Object -Skip 3
"to delete: $($del.Count) items, {0:N1} GB (manifest $manifest)" -f (($del | Measure-Object bytes -Sum).Sum / 1GB)
if ($WhatIf) { return }
$freed = 0
foreach ($d in $del) { try { Remove-Item -LiteralPath (Join-Path $root $d.name) -Recurse -Force -ErrorAction Stop; $freed += $d.bytes } catch { "  could not delete $($d.name): $($_.Exception.Message)" } }
"deleted {0:N1} GB; C: free now {1:N1} GB" -f ($freed / 1GB), ((Get-PSDrive C).Free / 1GB)
