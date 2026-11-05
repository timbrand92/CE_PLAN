# Rule 20 lane watcher (CE 00, 1 Nov 2026). Costs no Claude usage. Reads facts every 10 minutes and writes
# C:\CE_PLAN\desk_jobs\LANE_STATUS.txt. Any line starting ALERT means a lane is idle with no written reason.
# Team = headless claude jobs on the Team account. Codex = runner queue.log. AutoCAD = acad/accoreconsole.
param([int]$Seconds = 600, [int]$TeamIdleAlertMin = 30, [int]$CodexIdleAlertHours = 4)
$out = 'C:\CE_PLAN\desk_jobs\LANE_STATUS.txt'
$q   = 'C:\Lisp Files\_CODEX_RUNNER\queue.log'
$teamLastBusy = Get-Date
$acadLastSeen = Get-Date
$nf = 'C:\CE_PLAN\desk_jobs\CODEX_NEXT.txt'
while ($true) { try {
  $now = Get-Date
  $teamJobs = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^(claude|node)\.exe$' -and $_.CommandLine -match '(\s-p\s|--print)' }).Count
  if ($teamJobs -gt 0) { $teamLastBusy = $now }
  $teamIdle = [int]($now - $teamLastBusy).TotalMinutes
  $lastEnd = $null
  if (Test-Path $q) {
    $l = Get-Content $q -Tail 40 | Where-Object { $_ -match '^\d\d:\d\d END' } | Select-Object -Last 1
    if ($l) { $t = [datetime]::ParseExact(($l -split ' ')[0], 'HH:mm', $null); if ($t -gt $now) { $t = $t.AddDays(-1) }; $lastEnd = $t }
  }
  $codexIdleH = if ($lastEnd) { [math]::Round(($now - $lastEnd).TotalHours, 1) } else { 99 }
  $stop = (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag')
  $acad = @(Get-Process -Name acad, accoreconsole -ErrorAction SilentlyContinue).Count
  if ($acad -gt 0) { $acadLastSeen = $now }
  $acadGone = [int]($now - $acadLastSeen).TotalMinutes
  $nextTxt = if (Test-Path $nf) { (Get-Content $nf -TotalCount 1) } else { '' }
  $nextAt = $null; if ($nextTxt -match '^(\d{4}-\d\d-\d\dT\d\d:\d\d)') { $nextAt = [datetime]$Matches[1] }
  $lines = @("lane_watch $($now.ToString('ddd d MMM HH:mm')) PC clock",
             "TEAM: $teamJobs headless job(s) running; idle for $teamIdle min",
             "CODEX: last run ended $codexIdleH h ago; STOP_CODEX flag $(if($stop){'UP'}else{'down'})",
             "AUTOCAD: $acad process(es) running; not seen for $acadGone min",
             "CODEX NEXT: $nextTxt")
  if ($teamJobs -eq 0 -and $teamIdle -ge $TeamIdleAlertMin) { $lines += "ALERT TEAM idle $teamIdle min: CE 05 launch the next fix job now (one at a time, week under 30), or CE 00 write the reason." }
  if (-not $nextAt -or $nextAt -lt $now) { $lines += "ALERT CODEX has no dated next batch in CODEX_NEXT.txt (Rule 20.4): CE 02 propose one, CE 00 write it." }
  if ($codexIdleH -ge $CodexIdleAlertHours -and -not ($nextAt -and $nextAt -gt $now)) { $lines += "ALERT CODEX idle $codexIdleH h: CE 02 propose the next look batch to CE 00 now, or CE 00 write the reason (STOP_CODEX is $(if($stop){'UP'}else{'down'}))." }
  if ($acad -eq 0 -and $acadGone -ge 15) { $lines += "ALERT AUTOCAD not running: CE 02 start the next pack (Rule 15)." }
  $stopF = 'C:\CE_PLAN\desk_jobs\CHAIN_Q_STOPPED.txt'
  if (Test-Path $stopF) { $lines += "ALERT TEAM FEEDER STOPPED: " + ((Get-Content $stopF -TotalCount 2) -join ' ') }
  Set-Content -Path $out -Value $lines
  } catch { Add-Content -Path 'C:\CE_PLAN\desk_jobs\lane_watch_errors.log' -Value ("{0} {1}" -f (Get-Date -Format s), $_.Exception.Message) }
  Start-Sleep -Seconds $Seconds
}
