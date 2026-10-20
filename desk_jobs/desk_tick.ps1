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
# Team usage (real figure, one tiny haiku call) - added 12 Oct
try { & pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\team_usage.ps1 } catch { 'Team usage: read failed' }
# Disk alarm (12 Oct): a runaway task output file filled C: for 11 hours
$freeGb = [math]::Round((Get-PSDrive C).Free / 1GB)
if ($freeGb -lt 25) {
  "DISK ALARM: C: has only $freeGb GB free. Biggest task output files:"
  Get-ChildItem 'C:\Users\TimothyBrand\AppData\Local\Temp\claude' -Recurse -Filter *.output -File -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object -First 3 | ForEach-Object { "  {0:N1} GB {1}" -f ($_.Length / 1GB), $_.FullName }
}

# 20 Oct: build jobs leave ~5.5 GB of .NET workload-manifest folders in Temp; clear them each tick (scripts\clean_dotnet_tmp.ps1).
& 'C:\CE_PLAN\desk_jobs\scripts\clean_dotnet_tmp.ps1'
