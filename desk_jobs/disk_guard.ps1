# Desk 23 Oct 2026: disk guard for the Codex build lanes (they create worktrees at the C: root: ce-*, c*60, cx*). Every 10 minutes: if C: has less than 18 GB free, delete ONLY build output folders (bin and obj) under those worktrees that have not been written for 40 minutes, then run the dotnet temp clean. Below 14 GB: also write STOP_CODEX.flag so no new Codex AutoCAD run starts, and log loudly. Source files, git folders and evidence folders are never touched. Stop by creating STOP_DISKGUARD.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\disk_guard.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Free { [math]::Round((Get-PSDrive C).Free / 1GB, 1) }
Log "started: C: free $(Free) GB"
while (-not (Test-Path "$d\STOP_DISKGUARD.flag")) {
  $f = Free
  if ($f -lt 18) {
    $freed = 0
    $roots = Get-ChildItem 'C:\' -Directory -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^(ce-|c[a-z]+60|cx)' -and $_.Name -notmatch 'evidence|logs|out$|^ce_rc' }
    foreach ($r in $roots) {
      Get-ChildItem $r.FullName -Directory -Recurse -Force -ErrorAction SilentlyContinue -Depth 6 | Where-Object { $_.Name -in 'bin', 'obj' -and $_.LastWriteTime -lt (Get-Date).AddMinutes(-40) } | ForEach-Object {
        try { $sz = (Get-ChildItem $_.FullName -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum; Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction Stop; $freed += $sz } catch { }
      }
    }
    try { & pwsh -NoProfile -File "$d\scripts\clean_dotnet_tmp.ps1" 2>&1 | Out-Null } catch { }
    Log ("C: was {0} GB: removed idle bin/obj {1:N1} GB; now {2} GB" -f $f, ($freed / 1GB), (Free))
    if ((Free) -lt 14) { Set-Content "$d\STOP_CODEX.flag" "disk guard $(Get-Date -Format s)"; Log 'C: under 14 GB: STOP_CODEX.flag written' }
  }
  Start-Sleep 600
}
Log 'stopped'
