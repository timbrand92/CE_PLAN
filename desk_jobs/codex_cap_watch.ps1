# Desk 23 Oct 2026: Codex spend watcher. Tim wants Codex pushed hard until the announced reset, but a reserve is kept for the AutoCAD verification runs. Every 3 minutes: read the weekly usage; at 88 percent or more stop the Codex LANES (queue3.sh runs of cx_ jobs: the running codex jobs finish, nothing new starts) and write a loud log line; never touches the AutoCAD conveyor (verify* jobs). If the reading falls by 15 points or more between two reads, the weekly reset has happened: log RESET and stop watching (the desk returns to pace management).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\codex_cap_watch.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$bash = 'C:\Program Files\Git\bin\bash.exe'
function Usage { $o = & $bash -c 'cd "/c/Lisp Files/_CODEX_RUNNER" && ./codex_usage.sh fresh-pct' 2>$null; $v = 0.0; if ([double]::TryParse(($o | Select-Object -First 1), [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$v)) { $v } else { -1 } }
$last = Usage; Log "started: usage $last"
$stopped = $false
while (-not (Test-Path "$d\STOP_CAPWATCH.flag")) {
  Start-Sleep 180
  $u = Usage
  if ($u -lt 0) { continue }
  if ($last -ge 0 -and ($last - $u) -ge 15) { Log "RESET DETECTED: usage $last -> $u. Watcher stops; desk returns to pace management."; break }
  if ($u -ge 88 -and -not $stopped) {
    $n = 0
    Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'bash.exe' -and $_.CommandLine -match 'queue3\.sh' -and $_.CommandLine -match 'cx_' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force; $n++ } catch { } }
    Log "USAGE $u >= 88: stopped $n Codex lane runners (running codex jobs finish; AutoCAD verify runs untouched). Reserve kept for verification until the reset."
    $stopped = $true
  }
  $last = $u
}
Log 'stopped'
