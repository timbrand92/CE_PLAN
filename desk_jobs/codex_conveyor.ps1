function CurUsage { $x = & 'C:\Program Files\Git\bin\bash.exe' -c 'cd "/c/Lisp Files/_CODEX_RUNNER" && ./codex_usage.sh fresh-pct' 2>$null; $v = 0.0; if ([double]::TryParse(($x | Select-Object -First 1), [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$v)) { $v } else { 0.0 } }
# Desk 22 Oct 2026: Codex CONVEYOR. Runs the lines of CONVEYOR_QUEUE.txt one after another with no idle gap (each through launch_codex_retry.ps1), after the C-60 verification chain has finished. After every run it clears a left-over AutoCAD / lock (never when a settings guard holds an unrestored entry: then it stops for the desk). Stops at Codex weekly usage 90 percent, on STOP_CODEX.flag, or when the queue has no new line for 6 hours.
# Line format: name|folder|model|effort|cap|cost   (the look id is read from the name: verifyV9b_s41 -> V9B, verifyW3_c60 -> W3)
$d = 'C:\CE_PLAN\desk_jobs'
$qf = "$d\CONVEYOR_QUEUE.txt"
$done = "$d\CONVEYOR_DONE.txt"
function Log($t) { Add-Content "$d\codex_conveyor.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Usage { $q = Get-Content 'C:\Lisp Files\_CODEX_RUNNER\queue.log' -Tail 40 -ErrorAction SilentlyContinue; $m = $q | Select-String 'usage ([\d\.]+)%' -AllMatches | Select-Object -Last 1; if ($m) { [double]$m.Matches[-1].Groups[1].Value } else { 0 } }
function Cleanup {
  # 30 Oct 2026 08:00 (Rule 15): was a fixed 90 s sleep after every look (AutoCAD sat idle). Now waits only until the last look's AutoCAD has gone (at most 90 s, at least 8 s) so the next look starts within seconds.
  Start-Sleep 8; $wc = 0; while (@(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count -gt 0 -and $wc -lt 41) { Start-Sleep 2; $wc++ }
  $lk = 'C:\ce_rc_drv\ACAD_LOCK.json'; if (Test-Path $lk) { try { $lj = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$lj.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds() -and $lj.who -notmatch '^Codex') { Log ('lock held by ' + $lj.who + ': cleanup skipped'); return $true } } catch { } }
  $a = Get-Process acad -ErrorAction SilentlyContinue
  $g = 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
  if (Test-Path $g) {
    $j = Get-Content $g -Raw | ConvertFrom-Json
    $bad = @($j.entries | Where-Object { -not $_.restored_while_running -and $_.armed -ne $false })
    if ($j.armed -eq $true -or $bad.Count -gt 0) { Log 'settings guard holds an unrestored entry: conveyor STOPS for the desk'; return $false }
  }
  if ($a) { Log ("AutoCAD left running (pid " + ($a.Id -join ',') + "): killed"); $a | Stop-Process -Force; Start-Sleep 5 }
  if (Test-Path $g) { Copy-Item $g ("C:\ce_rc_scratch\settings_guard_conveyor_" + (Get-Date -Format 'HHmm') + ".json") -Force; Remove-Item $g -Force }
  $lock = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lock) { Copy-Item $lock ("C:\ce_rc_scratch\ACAD_LOCK_conveyor_" + (Get-Date -Format 'HHmm') + ".json") -Force; Remove-Item $lock -Force }
  return $true
}
# wait for the C-60 verification chain (V10) to finish
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c60_verify' -and $_.Name -match 'pwsh' }) { Start-Sleep 120 }
if (-not (Cleanup)) { exit }
Log 'conveyor started'
$idle = 0
while ($true) {
  if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
  $stopAt = 90; if (Test-Path 'C:\Lisp Files\_CODEX_RUNNER\BURN_UNTIL.txt') { $stopAt = 97 }
  if ((CurUsage) -ge $stopAt) { Log "Codex weekly usage $stopAt percent: stop"; exit }
  $pm = (Get-Content "$d\CODEX_MODE.txt" -TotalCount 1 -ErrorAction SilentlyContinue); if ($pm -eq 'HOLD') { Log 'mode HOLD: conveyor stops'; exit }
  if ($pm -eq 'PACE') { $o = & 'C:\Program Files\Git\bin\bash.exe' -c 'bash "/c/Lisp Files/_CODEX_RUNNER/daily_cap.sh"' 2>$null; $cv = 0; if ([int]::TryParse(($o | Select-Object -First 1), [ref]$cv) -and ((CurUsage) + 1) -gt $cv) { Log ("over today's cap ($cv): waiting 10 minutes"); Start-Sleep 600; continue } }
  $doneList = @(Get-Content $done -ErrorAction SilentlyContinue)
  $next = Get-Content $qf -ErrorAction SilentlyContinue | Where-Object { $_.Trim() -and $_ -notmatch '^\s*#' -and ($doneList -notcontains $_.Split('|')[0]) } | Select-Object -First 1
  if (-not $next) { Start-Sleep 300; $idle++; if ($idle -gt 72) { Log 'no new queue line for 6 h: stop'; exit }; continue }
  $idle = 0
  $name = $next.Split('|')[0]
  $m = [regex]::Match($name, '^verify([A-Za-z]+\d+[a-z]?)_')
  $id = if ($m.Success) { $m.Groups[1].Value.ToUpper() } else { $name }
  $briefOk = Test-Path ("C:\Lisp Files\_CODEX_RUNNER\" + $name + "_full.txt")
  if (-not $briefOk) { Log "brief for $name not written yet: waiting"; Start-Sleep 300; $idle++; continue }
  Log "starting $name (look id $id)"
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line $next -ReportGlob ("CODEX_VERIFY_" + $id + "_*") -Tries 3
  Add-Content $done $name
  Log "finished $name"
  if (-not (Cleanup)) { exit }
}
