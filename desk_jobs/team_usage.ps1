# Reads the TEAM account's real usage through one tiny headless haiku call (stream-json rate_limit_event). 10 Oct 2026.
$env:CLAUDE_CONFIG_DIR = "$env:USERPROFILE\.claude-team"
Set-Location 'C:\Lisp Files\CE_ACAD_PLUGIN'
$o = & claude -p 'Reply with the single word ok.' --model haiku --output-format stream-json --verbose 2>&1 | Out-String
$l = ($o -split "`n" | Where-Object { $_ -match 'rate_limit_event' } | Select-Object -First 1)
if (-not $l) { 'Team usage: no rate_limit_event (limit hit or error)'; return }
$j = $l | ConvertFrom-Json
$w = $j.rate_limit_info.unifiedWindows
$tz = [TimeSpan]::FromHours(11)
$f = { param($s) [DateTimeOffset]::FromUnixTimeSeconds([long]$s).ToOffset($tz).ToString('ddd HH:mm') }
"Team usage: 5-hour {0:P0} (resets {1}), 7-day {2:P0} (resets {3})" -f $w.five_hour.utilization, (& $f $w.five_hour.resetsAt), $w.seven_day.utilization, (& $f $w.seven_day.resetsAt)
