# Desk helper (10 Oct 2026): relaunch ended builder lanes with the next RUN number and a generic 'continue' brief.
# Usage: pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\relaunch_lanes.ps1 -Lanes 02,03,04 [-Extra 'text for line 2']
param([string[]]$Lanes = @('02','03','04'), [string]$Extra = '')
$ErrorActionPreference = 'Stop'
$common = "AUTHORITY: Tim ruled builds never wait for his answers (INT-073..081). Read C:\CE_PLAN\desk_jobs\NEXT_FIXES_2026-10-08.md from 'Added Fri 9 Oct 23:20' to the end (newest entries first matter), your last TEAMLANE log entry, and REVIEWLANE_LOG.md entries newer than your last run for your PRs (fix MERGE-WITH-FIXES items first, RED test first). Then continue your lane's list: everything not done that needs no Tim number, plans cards not yet built (recommended answers as DRAFT, Settings-backed, OFF/hidden). Rules unchanged: NEVER git add -A (files by name; git diff --stat before every push; no screenshots in PRs); C:\CE_PLAN only git fetch then git merge --no-edit origin/main (NEVER pull --rebase, never origin master); DRAFT PRs off the newest assembled release base (Civil: newest claude/rel-* Civil head on origin that holds 3.0.44 or newer; Structural: newest claude/rel-* Structural head that holds 1.0.113 or newer; NEVER master); behaviour behind Settings with today's number as default; R-27 no hard blocks; new Settings keys never in the Design Standards group; no blue; plain name + command; RED test first; PINNED unchanged tests; redo-safe (guardrail 8 item 17: no StartTransaction, SetCurrentView, SetSystemVariable or command can run between U and REDO); REGRESSION_LOG plain English with AutoCAD steps; comment 'needs Opus review'. Redirect dotnet build/test output to a file and print only summary lines. Builds ONE at a time, Below Normal; unit tests only if acad.exe is not running; C: above 12 GB; git clean -fdXq in your own finished worktrees. Do as MANY items as you can, one DRAFT PR per item, then END with a one-paragraph summary."
foreach ($l in $Lanes) {
  $src = "C:\CE_PLAN\desk_jobs\build${l}_job_latest.txt"
  $lines = [System.Collections.Generic.List[string]](Get-Content -LiteralPath $src -Encoding UTF8)
  if ($lines[0] -notmatch 'HEADLESS RUN (\d+)') { Write-Output "lane ${l}: cannot find RUN number"; continue }
  $n = [int]$Matches[1]; $m = $n + 1
  $lines[0] = $lines[0] -replace "HEADLESS RUN $n", "HEADLESS RUN $m"
  # drop earlier 'RUN nn (desk' addition lines so the file does not grow forever (keep line 0 and the original body)
  $lines = [System.Collections.Generic.List[string]]($lines | Where-Object { $_ -notmatch '^RUN \d+ \(desk plan/03' -and $_ -notmatch '^RUN \d+ ADDITIONS' })
  $stamp = Get-Date -Format 'ddd dd MMM HH:mm'
  $add = "RUN $m (desk plan/03, $stamp PC clock; SONNET): LANE = build/$l. $Extra $common"
  $lines.Insert(1, $add)
  $out = "C:\Users\TIMOTH~1\AppData\Local\Temp\claude\relaunch_build${l}_$m.txt"
  New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null
  [IO.File]::WriteAllLines($out, $lines, (New-Object Text.UTF8Encoding($false)))
  Copy-Item $out $src -Force
  & 'C:\CE_PLAN\desk_jobs\launch_job.ps1' -JobFile $out -Model sonnet
}
