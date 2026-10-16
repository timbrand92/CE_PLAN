# Team usage governor (desk plan/03, 12 Oct 2026; Tim: "use all of the Team usage before reset").
# Every 20 minutes: read the Team 7-day and 5-hour utilisation; if the week is BEHIND the pace line that ends at ~98% at the reset,
# and the 5-hour window has room, launch the next job from governor_queue\ (first line '# MODEL: fable|sonnet').
# Stop: create desk_jobs\STOP_GOVERNOR.flag. Log: desk_jobs\team_governor.log. Max concurrent governor jobs: 3.
param([double]$EndTarget = 0.98, [int]$MaxJobs = 3, [double]$FiveHourCeil = 0.80)
$dir = 'C:\CE_PLAN\desk_jobs'
function Log($m) { Add-Content "$dir\team_governor.log" ("{0} {1}" -f (Get-Date -Format 'ddd dd HH:mm'), $m) }
Log "governor started (end target $EndTarget, max jobs $MaxJobs)"
while ($true) {
  if (Test-Path "$dir\STOP_GOVERNOR.flag") { Log 'stop flag: exiting'; break }
  try {
    $env:CLAUDE_CONFIG_DIR = "$env:USERPROFILE\.claude-team"
    Set-Location 'C:\Lisp Files\CE_ACAD_PLUGIN'
    $o = & claude -p 'Reply with the single word ok.' --model haiku --output-format stream-json --verbose 2>&1 | Out-String
    $l = ($o -split "`n" | Where-Object { $_ -match 'rate_limit_event' } | Select-Object -First 1)
    if (-not $l) {
      Log 'no rate_limit_event (limit hit?): sleeping 30 min'
      Start-Sleep -Seconds 1800; continue
    }
    $w = ($l | ConvertFrom-Json).rate_limit_info.unifiedWindows
    $u7 = [double]$w.seven_day.utilization; $u5 = [double]$w.five_hour.utilization
    $reset = [long]$w.seven_day.resetsAt
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $f = 1.0 - (($reset - $now) / 604800.0); if ($f -lt 0) { $f = 0 }; if ($f -gt 1) { $f = 1 }
    $target = $EndTarget * $f
    $running = @(Get-CimInstance Win32_Process -Filter "Name='claude.exe'" | Where-Object { $_.CommandLine -match ' -p ' }).Count
    $govRunning = @(Get-ChildItem "$dir\governor_launched" -Filter *.txt -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-3) }).Count
    Log ("7d {0:P1} vs pace {1:P1} (week {2:P0} gone); 5h {3:P0}; claude -p {4}; governor jobs in last 3h {5}" -f $u7, $target, $f, $u5, $running, $govRunning)
    if ($u7 -lt ($target - 0.02) -and $u5 -lt $FiveHourCeil -and $govRunning -lt $MaxJobs) {
      $next = Get-ChildItem "$dir\governor_queue" -Filter *.txt | Sort-Object Name | Select-Object -First 1
      if ($next) {
        $first = (Get-Content $next.FullName -TotalCount 1)
        $model = 'sonnet'; if ($first -match 'MODEL:\s*(\w+)') { $model = $Matches[1] }
        $dest = Join-Path "$dir\governor_launched" $next.Name
        Move-Item $next.FullName $dest -Force
        (Get-Item $dest).LastWriteTime = Get-Date
        & 'C:\CE_PLAN\desk_jobs\launch_job.ps1' -JobFile $dest -Model $model | ForEach-Object { Log "LAUNCHED $_" }
      } else { Log 'queue empty: desk should refill governor_queue' }
    }
  } catch { Log ("error: " + $_.Exception.Message) }
  Start-Sleep -Seconds 1200
}
