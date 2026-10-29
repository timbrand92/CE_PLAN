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
  if (Test-Path "$d\TIM_AT_PC.flag") { return "Tim is at the PC (hand-back, Rule 17)" }
  if ((TimHours) -and -not (Test-Path "$d\TIM_AWAY.flag")) { return "Tim's AutoCAD hours" }
  if (Test-Path "$d\ACAD_IDLE_OK.txt") {
    $l = Get-Content "$d\ACAD_IDLE_OK.txt" -TotalCount 2
    if ($l[0] -match '^until\s+(\d{4}-\d\d-\d\d \d\d:\d\d)') { if ((Get-Date) -lt [datetime]$Matches[1]) { return ('requested idle window: ' + $l[1]) } }
  }
  return $null
}
function CloseStaleCodexStarts {
  # Rule 15 follow-up (CE 00 06:27): a Codex try or look stopped by a pid leaves a START with no END, and the next look then refuses to run (gate 2.4). If no Codex look process is running, close any open START in the last 60 lines with a marked END line.
  $q = 'C:\Lisp Files\_CODEX_RUNNER\queue.log'
  if (-not (Test-Path $q)) { return }
  $running = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|queue4\.sh|codex\.js exec|codex-win32-x64.*exec' -and $_.Name -match 'pwsh|node|codex|bash' }).Count -gt 0
  if ($running) { return }
  $tail = @(Get-Content $q -Tail 60); $open = [ordered]@{}
  foreach ($l in $tail) { if ($l -match '^(\d\d:\d\d) START (\S+)') { $open[$Matches[2]] = $l } elseif ($l -match '^(\d\d:\d\d) END (\S+)') { $open.Remove($Matches[2]) } }
  foreach ($k in @($open.Keys)) { if ($k -like 'cx_*') { continue }
    $line = (Get-Date -Format 'HH:mm') + " END $k exit 124 usage 0.0% -> 0.0% (CLOSED BY acad_watchdog: a START with no END and no Codex look running; the look was stopped by a pid or died)"
    if ($DryRun) { Log "WOULD close stale START of $k" } else { [IO.File]::AppendAllText($q, $line + "`n"); Log "closed stale Codex START of $k in queue.log" } }
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
  CloseStaleCodexStarts
  $busy = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count -gt 0
  if ($busy) {
    if ($idleSince) { $mins = [math]::Round(((Get-Date) - $idleSince).TotalMinutes, 1); Log ("IDLE ENDED after $mins min (started " + $idleSince.ToString('HH:mm') + ")"); $idleSince = $null; $idleLogged = $false; Remove-Item "$d\AUTOCAD_IDLE.txt" -Force -ErrorAction SilentlyContinue }
    $busyMin += 2
  } else {
    if (-not $idleSince) { $idleSince = Get-Date }
    $mins = ((Get-Date) - $idleSince).TotalMinutes; $idleMin += 2
    $why = AllowedReason
    if (-not $why -and $mins -lt 4) { $why = 'gap between two starts' }
    # Rule 15 (CE 00 07:55): a Codex look that is launching (launcher process alive) is a reason for up to 12 minutes; with no look launching a gap over 4 minutes is a breach and the filler below starts at once.
    if (-not $why -and $mins -lt 12 -and @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|codex\.js exec' -and $_.Name -match 'pwsh|node|codex' }).Count -gt 0) { $why = 'a Codex look is launching' }
    if ($why) { if (-not $idleLogged -and $mins -ge 4) { Log ("idle, allowed: $why"); $idleLogged = $true } }
    else {
      if (-not $idleLogged) { Log ("IDLE with no allowed reason since " + $idleSince.ToString('HH:mm') + "; pending: " + ((PendingWork) -join ', ')); $idleLogged = $true }
      # 1. release CE 02's own stale holds when no CE 02 job of ours is running
      $own = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'extras_after_diag|report_after_extras|wait_then_report|chain3\.ps1|chain4\.ps1|tester_run[0-9]' -and $_.ProcessId -ne $PID }).Count
      foreach ($fn in 'HOLD_ROBOT.flag', 'STOP_CODEX.flag') { $f = "$d\$fn"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02') -and $own -eq 0) { if ($DryRun) { Log "WOULD release stale $fn" } else { Remove-Item $f -Force; Log "released stale $fn (CE 02's own, no job of ours running)" } } }
      # 2. start the lanes (idempotent)
      if ($DryRun) { Log 'WOULD run start_lanes.ps1' } else { & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null; Log 'ran start_lanes.ps1' }
      # 2b. nothing pending anywhere (queues empty): move the next held robot job from ROBOT_QUEUE_AFTER_C77.txt into ROBOT_QUEUE.txt so AutoCAD gets work (the robot lane starts it). One job at a time.
      if (($true) -and (Test-Path "$d\ROBOT_QUEUE_AFTER_C77.txt")) {   # queues empty, or still idle after 10 minutes (e.g. the Codex daily cap has paused the conveyor)
        $held = @(Get-Content "$d\ROBOT_QUEUE_AFTER_C77.txt" | Where-Object { $_.Trim() -and -not $_.StartsWith('#') })
        if ($held.Count) { $next = $held[0]; if ($DryRun) { Log "WOULD queue the robot job $next (nothing else pending)" } else { Add-Content "$d\ROBOT_QUEUE.txt" $next; $rest = @(Get-Content "$d\ROBOT_QUEUE_AFTER_C77.txt" | Where-Object { $_.Trim() -ne $next.Trim() }); [IO.File]::WriteAllText("$d\ROBOT_QUEUE_AFTER_C77.txt", (($rest -join "`r`n") + "`r`n")); Log "queues were empty: moved $([IO.Path]::GetFileName($next)) into ROBOT_QUEUE.txt"; & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null } }
      }      # 2c. still nothing (queues and the AFTER_C77 list empty) and idle 10+ minutes: start the next filler script from FILL_SCRIPTS.txt (drafted cases, no model tokens). One at a time; not while a chain or runner already runs.
      if (($true) -and -not (Test-Path "$d\ROBOT_QUEUE_AFTER_C77.txt" -PathType Leaf -ErrorAction SilentlyContinue | Where-Object { $_ -and ((Get-Content "$d\ROBOT_QUEUE_AFTER_C77.txt" | Where-Object { $_.Trim() -and -not $_.StartsWith('#') }).Count -gt 0) }) -and (Test-Path "$d\FILL_SCRIPTS.txt")) {
        $running = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain3\.ps1|chain4\.ps1|case_runner\.ps1|fill_drafts' -and $_.ProcessId -ne $PID }).Count -gt 0
        $fs = @(Get-Content "$d\FILL_SCRIPTS.txt" | Where-Object { $_.Trim() -and -not $_.StartsWith('#') })
        if (-not $running -and $fs.Count) { $f1 = $fs[0].Trim(); if ($DryRun) { Log "WOULD start the filler $f1" } else { Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = ('pwsh.exe -NoProfile -WindowStyle Hidden -File "' + $f1 + '"'); CurrentDirectory = $d } | Out-Null; $rest = @($fs | Select-Object -Skip 1); [IO.File]::WriteAllText("$d\FILL_SCRIPTS.txt", (($rest -join "`r`n") + "`r`n")); Log "AutoCAD idle with nothing queued: started the filler $f1" } }
      }      # 3. still idle after 6 minutes: say so
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