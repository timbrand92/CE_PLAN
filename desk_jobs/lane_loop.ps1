# Desk helper (10 Oct 2026): keeps ONE builder lane running forever. Runs headless Team 'claude -p' jobs back to back (synchronously),
# bumps the RUN number each time, stops when C:\CE_PLAN\desk_jobs\STOP_LANES.flag or STOP_<lane>.flag exists.
# Usage (hidden, background): Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\CE_PLAN\desk_jobs\lane_loop.ps1','-Lane','04'
param([Parameter(Mandatory = $true)][ValidateSet('02', '03', '04')][string]$Lane, [string]$Model = 'sonnet', [switch]$WaitForLogDone)
$ErrorActionPreference = 'Continue'
$env:CLAUDE_CONFIG_DIR = "$env:USERPROFILE\.claude-team"
$dir = 'C:\CE_PLAN\desk_jobs'
$queueSection = @{ '02' = 'section 1'; '03' = 'section 2'; '04' = 'section 3' }[$Lane]
$common = "AUTHORITY: Tim ruled builds never wait for his answers (INT-073..081). Your BUG BURN-DOWN queue is C:\CE_PLAN\areas\release-v3-colleagues-BUG_BURNDOWN_QUEUE_2026-10-10.md (your lane's section: fix the bugs in order, HIGH first, each a DRAFT PR with a failing test first; close already-fixed ones in the log as 'fixed in <version>, needs Tim's confirmation'). Your REFILLED plan queue is in C:\CE_PLAN\areas\release-v3-colleagues-BUILD_QUEUE_V3_RUN2_2026-10-10.md (read the part for your lane first), then $queueSection of C:\CE_PLAN\areas\release-v3-colleagues-BUILD_QUEUE_V3_2026-10-10.md for anything not yet built: start at the first item not yet built and work down; items that name a Tim number: build with the recommended default as a DRAFT behind a Settings switch. Also read C:\CE_PLAN\desk_jobs\NEXT_FIXES_2026-10-08.md (newest entries first), your last TEAMLANE log entry, and REVIEWLANE_LOG.md entries newer than your last run for your PRs (fix MERGE-WITH-FIXES items first, RED test first). A run that stops after one or two items is a failed run: keep going down the queue until your context is nearly full, finishing each item with a DRAFT PR and a one-line log entry in your TEAMLANE log (commit and push the log by name). Rules unchanged: NEVER git add -A (files by name; git diff --stat before every push; no screenshots in PRs); C:\CE_PLAN only git fetch then git merge --no-edit origin/main (NEVER pull --rebase, never origin master); DRAFT PRs off the newest assembled release base (Civil: newest claude/rel-* Civil head on origin that holds 3.0.44 or newer; Structural: newest claude/rel-* Structural head that holds 1.0.113 or newer; NEVER master); behaviour behind Settings with today's number as default; R-27 no hard blocks; new Settings keys never in the Design Standards group; no blue; plain name + command; RED test first; PINNED unchanged tests; redo-safe (guardrail 8 item 17: no StartTransaction, SetCurrentView, SetSystemVariable or command can run between U and REDO); REGRESSION_LOG plain English with AutoCAD steps; comment 'needs Opus review'. Redirect dotnet build/test output to a file and print only summary lines. Builds ONE at a time, Below Normal; net10 UNIT tests may run while AutoCAD is up only with CE_LOG_DIR_OVERRIDE pointing at a scratch folder and the three settings files + live CE log folders compared before and after (stop and tell the desk if anything changed); C: above 12 GB; git clean -fdXq in your own finished worktrees. END with a one-paragraph summary."
if ($WaitForLogDone) {   # a run of this lane is already in flight: wait until its TEAMLANE log says done/ended after now
  $logf = "C:\CE_PLAN\areas\release-v3-colleagues-TEAMLANE$([int]$Lane)_LOG.md"
  if ($Lane -eq '02') { $logf = 'C:\CE_PLAN\areas\release-v3-colleagues-TEAMLANE2_LOG.md' }
  $tStart = Get-Date
  while ($true) {
    if ((Test-Path "$dir\STOP_LANES.flag") -or (Test-Path "$dir\STOP_$Lane.flag")) { exit }
    git -C C:\CE_PLAN fetch -q 2>$null; git -C C:\CE_PLAN merge --no-edit -q origin/main 2>$null | Out-Null
    $last = (Get-Content $logf -Tail 3 -ErrorAction SilentlyContinue) -join ' '
    if ((Get-Item $logf).LastWriteTime -gt $tStart -and $last -match 'run \d+ (done|ended)') { break }
    Start-Sleep -Seconds 120
  }
}
while ($true) {
  if ((Test-Path "$dir\STOP_LANES.flag") -or (Test-Path "$dir\STOP_$Lane.flag")) { break }
  $src = "$dir\build${Lane}_job_latest.txt"
  $lines = [System.Collections.Generic.List[string]](Get-Content -LiteralPath $src -Encoding UTF8)
  if ($lines[0] -match 'HEADLESS RUN (\d+)') { $n = [int]$Matches[1]; $m = $n + 1; $lines[0] = $lines[0] -replace "HEADLESS RUN $n", "HEADLESS RUN $m" } else { $m = 0 }
  $lines = [System.Collections.Generic.List[string]]($lines | Where-Object { $_ -notmatch '^RUN \d+ \(desk plan/03' })
  $lines.Insert(1, ("RUN $m (desk lane_loop, {0} PC clock; SONNET): LANE = build/$Lane. {1}" -f (Get-Date -Format 'ddd dd MMM HH:mm'), $common))
  $job = "C:\Users\TIMOTH~1\AppData\Local\Temp\claude\loop_build${Lane}_$m.txt"
  New-Item -ItemType Directory -Force (Split-Path $job) | Out-Null
  [IO.File]::WriteAllLines($job, $lines, (New-Object Text.UTF8Encoding($false)))
  Copy-Item $job $src -Force
  $log = [IO.Path]::ChangeExtension($job, '.log')
  $t0 = Get-Date
  $p = Start-Process cmd.exe -ArgumentList '/c', "claude -p --model $Model --permission-mode bypassPermissions --output-format text < `"$job`" > `"$log`" 2>&1" -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru
  try { $p.PriorityClass = 'BelowNormal' } catch {}
  $p.WaitForExit()
  $secs = ((Get-Date) - $t0).TotalSeconds
  Add-Content "$dir\lane_loop_$Lane.log" ("{0} run {1} ended after {2:N0} s" -f (Get-Date -Format 'ddd HH:mm'), $m, $secs)
  $tail = if (Test-Path $log) { Get-Content $log -Tail 5 -ErrorAction SilentlyContinue | Out-String } else { '' }
  if ($tail -match '(weekly|session) limit') {
    # Team weekly limit hit: the message says 'resets 2pm (Australia/Sydney)'. Sleep until the next 2pm Sydney plus 3 minutes.
    $hour = 14; if ($tail -match 'resets (\d{1,2})(am|pm)') { $hour = [int]$Matches[1] % 12; if ($Matches[2] -eq 'pm') { $hour += 12 } }
    $tz = [TimeZoneInfo]::FindSystemTimeZoneById('AUS Eastern Standard Time')
    $nowSyd = [TimeZoneInfo]::ConvertTime((Get-Date), $tz)
    $next = $nowSyd.Date.AddHours($hour).AddMinutes(3); if ($next -le $nowSyd) { $next = $next.AddDays(1) }
    $wait = [int](($next - $nowSyd).TotalSeconds)
    Add-Content "$dir\lane_loop_$Lane.log" ("{0} weekly limit hit: sleeping {1} min until {2} Sydney" -f (Get-Date -Format 'ddd HH:mm'), [int]($wait / 60), $next.ToString('ddd HH:mm'))
    Start-Sleep -Seconds $wait
  }
  elseif ($secs -lt 900) { Start-Sleep -Seconds 7200 } else { Start-Sleep -Seconds 60 }   # a run under 15 min = 'no new work' or a failure: wait 2 h (16 Oct: 400 empty runs per lane burned the Team week)   # instant failure (limit/error): back off 15 min
}
