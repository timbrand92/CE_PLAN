# CE 02 Fri 30 Oct 2026 06:30 (Tim, relayed by CE 00: "if nothing is running its completely unacceptable ... AutoCAD sits idle whilst im not working"). RULE 15 watchdog. No model tokens, not a build script.
# Every 2 minutes: is AutoCAD (acad.exe or accoreconsole.exe) running? Logs occupancy to AUTOCAD_OCCUPANCY.log. When it is NOT running and NO allowed reason holds, it (1) releases CE 02's own stale hold flags, (2) runs start_lanes.ps1 (starts the Codex lane or the robot lane if their gates allow), (3) if still idle after 6 minutes writes AUTOCAD_IDLE.txt (read by CE 02's 30-minute check).
# Allowed reasons: a gap of under 4 minutes between two starts; ACAD_IDLE_OK.txt (line 1 'until yyyy-MM-dd HH:mm', line 2 the reason: CE 01's payload final steps or install window, or a Tim request); Tim at the PC (no TIM_AWAY.flag during his weekday hours 8:30-14:00 and 15:00-17:30).
# Usage: pwsh -NoProfile -File acad_watchdog.ps1 [-Once] [-DryRun]   (Once = one pass; DryRun = decide and log, start nothing)
param([switch]$Once, [switch]$DryRun)
$d = 'C:\CE_PLAN\desk_jobs'
$log = "$d\AUTOCAD_OCCUPANCY.log"
function Log($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm'), $t) }
function TimHours { $n = Get-Date; if ($n.DayOfWeek -in 'Saturday','Sunday') { return $false }; $m = $n.Hour*60+$n.Minute; return (($m -ge 510 -and $m -lt 840) -or ($m -ge 900 -and $m -lt 1050)) }
function AllowedReason {
  if ((TimHours) -and -not (Test-Path "$d\TIM_AWAY.flag")) { return "Tim's AutoCAD hours" }
  if (Test-Path "$d\ACAD_IDLE_OK.txt") {
    $l = Get-Content "$d\ACAD_IDLE_OK.txt" -TotalCount 2
    if ($l[0] -match '^until\s+(\d{4}-\d\d-\d\d \d\d:\d\d)') { if ((Get-Date) -lt [datetime]$Matches[1]) { return ('requested idle window: ' + $l[1]) } }
  }
  return $null
}
function PendingWork {
  $w = @()
  if (Test-Path "$d\ROBOT_QUEUE.txt") { foreach ($line in Get-Content "$d\ROBOT_QUEUE.txt") { $l = $line.Trim(); if ($l -eq '' -or $l.StartsWith('#')) { continue }; if (-not (Test-Path "$l.done")) { $w += "robot:$([IO.Path]::GetFileName($l))" } } }
  $done = @(Get-Content "$d\CONVEYOR_DONE.txt" -ErrorAction SilentlyContinue)
  foreach ($line in Get-Content "$d\CONVEYOR_QUEUE.txt" -ErrorAction SilentlyContinue) { if ($line.Trim() -and $line -notmatch '^\s*#' -and ($done -notcontains $line.Split('|')[0])) { $w += "codex:$($line.Split('|')[0])" } }
  return $w
}
$idleSince = $null; $lastBusyLog = Get-Date; $idleLogged = $false; $busyMin = 0; $idleMin = 0
Log 'watchdog started'
while ($true) {
  $busy = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count -gt 0
  if ($busy) {
    if ($idleSince) { $mins = [math]::Round(((Get-Date) - $idleSince).TotalMinutes, 1); Log ("IDLE ENDED after $mins min (started " + $idleSince.ToString('HH:mm') + ")"); $idleSince = $null; $idleLogged = $false; Remove-Item "$d\AUTOCAD_IDLE.txt" -Force -ErrorAction SilentlyContinue }
    $busyMin += 2
  } else {
    if (-not $idleSince) { $idleSince = Get-Date }
    $mins = ((Get-Date) - $idleSince).TotalMinutes; $idleMin += 2
    $why = AllowedReason
    if (-not $why -and $mins -lt 4) { $why = 'gap between two starts' }
    if ($why) { if (-not $idleLogged -and $mins -ge 4) { Log ("idle, allowed: $why"); $idleLogged = $true } }
    else {
      if (-not $idleLogged) { Log ("IDLE with no allowed reason since " + $idleSince.ToString('HH:mm') + "; pending: " + ((PendingWork) -join ', ')); $idleLogged = $true }
      # 1. release CE 02's own stale holds when no CE 02 job of ours is running
      $own = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'extras_after_diag|report_after_extras|wait_then_report|chain3\.ps1|chain4\.ps1|tester_run[0-9]' -and $_.ProcessId -ne $PID }).Count
      foreach ($fn in 'HOLD_ROBOT.flag', 'STOP_CODEX.flag') { $f = "$d\$fn"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02') -and $own -eq 0) { if ($DryRun) { Log "WOULD release stale $fn" } else { Remove-Item $f -Force; Log "released stale $fn (CE 02's own, no job of ours running)" } } }
      # 2. start the lanes (idempotent)
      if ($DryRun) { Log 'WOULD run start_lanes.ps1' } else { & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null; Log 'ran start_lanes.ps1' }
      # 3. still idle after 6 minutes: say so
      if ($mins -ge 6 -and -not (Test-Path "$d\AUTOCAD_IDLE.txt")) {
        $pw = PendingWork
        $txt = "AUTOCAD IDLE since $($idleSince.ToString('ddd HH:mm')) with no allowed reason. Pending work: " + $(if ($pw.Count) { $pw -join ', ' } else { 'NONE (queues empty: top them up)' }) + ". Codex cap/mode: " + ((Get-Content "$d\CODEX_MODE.txt" -TotalCount 1 -ErrorAction SilentlyContinue)) + "."
        if (-not $DryRun) { Set-Content "$d\AUTOCAD_IDLE.txt" $txt }
        Log ("IDLE 6+ min: " + $txt)
      }
    }
  }
  if (((Get-Date) - $lastBusyLog).TotalMinutes -ge 30) { Log ("occupancy last 30 min: busy $busyMin min, idle $idleMin min"); $busyMin = 0; $idleMin = 0; $lastBusyLog = Get-Date }
  if ($Once) { break }
  Start-Sleep 120
}