# Desk tick (10 Oct 2026): ONE cheap compact status so the desk chat spends few tokens per check.
# Usage: pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\desk_tick.ps1
$ErrorActionPreference = 'SilentlyContinue'
git -C C:\CE_PLAN fetch -q 2>$null
git -C C:\CE_PLAN merge --no-edit -q origin/main 2>$null | Out-Null
$w = Get-CimInstance Win32_Process -Filter "Name='claude.exe'" | Where-Object { $_.CommandLine -match ' -p ' }
$acad = Get-Process acad
$free = [math]::Round((Get-PSDrive C).Free / 1GB)
"{0} | claude -p workers {1} | acad {2} | C: {3} GB" -f (Get-Date -Format 'ddd HH:mm'), @($w).Count, $(if ($acad) { 'UP' } else { 'free' }), $free
$last = (Get-Content C:\CE_PLAN\desk_jobs\.last_tick -ErrorAction SilentlyContinue)
$range = if ($last) { "$last..HEAD" } else { '-8' }
git -C C:\CE_PLAN log --oneline $range 2>$null | Select-Object -First 12
git -C C:\CE_PLAN rev-parse HEAD | Set-Content C:\CE_PLAN\desk_jobs\.last_tick
# lane liveness: the three builder lanes must each have a recent start line in the queue logs
foreach ($l in 'TEAMLANE2_LOG', 'TEAMLANE3_LOG', 'TEAMLANE4_LOG') {
  $f = "C:\CE_PLAN\areas\release-v3-colleagues-$l.md"
  if (Test-Path $f) { "{0}: {1}" -f $l, ((Get-Item $f).LastWriteTime.ToString('ddd HH:mm')) }
}
