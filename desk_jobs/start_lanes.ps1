# Desk 29 Oct 2026 (CE 02; Tim: "set this up so it automatically always opens without me every time the computer restarts").
# Starts the desk's standing lanes after a restart. IDEMPOTENT: starts only what is not already running, so running it twice (or every 30 minutes) is safe.
# Starts through WMI (Win32_Process Create) so a lane does not die with the window that started it. Never touches AutoCAD, Tim's files or any setting.
#   disk_guard.ps1          always (unless STOP_DISKGUARD.flag)
#   chain_robot_standing.ps1 always (unless STOP_CHAIN.flag). It reads HOLD_ROBOT.flag itself and starts no AutoCAD while that flag exists.
#   codex_supervisor.ps1    NEVER while any acad.exe is running or HOLD_ROBOT.flag exists (fixed 29 Oct 14:50); and only OUTSIDE Tim's AutoCAD hours (Mon-Fri 8:30-14:00 and 15:00-17:30), or when CODEX_AUTOSTART.flag exists (unless STOP_SUPERVISOR.flag or STOP_CODEX.flag).
#                           The supervisor itself starts and watches the Codex conveyor, the AutoCAD janitor and the disk guard, so none of those is started here.
# The AutoCAD janitor can close an AutoCAD that has no drawing open and no lock for 15 minutes, which is why it is left to the supervisor and never started in Tim's hours.
# Usage: pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\start_lanes.ps1 [-DryRun] [-PretendNothingRunning]   (DryRun lists what it would start and starts nothing)
param([switch]$DryRun, [switch]$PretendNothingRunning, [int]$AssumeAcad = -1, [int]$AssumeHold = -1, [int]$AssumeHours = -1, [int]$AssumeRobot = -1)   # the three Assume* switches (1 or 0) only change the DECISION in a -DryRun, for tests
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { $line = "{0} {1}" -f (Get-Date -Format 'ddd dd HH:mm'), $t; Add-Content "$d\start_lanes.log" $line; Write-Output $line }
function IsRunning([string]$name) {
  if ($PretendNothingRunning) { return $false }
  return (@(Get-CimInstance Win32_Process -Filter "Name='pwsh.exe'" | Where-Object { $_.CommandLine -match ('[\\/]' + [regex]::Escape($name) + '\.ps1') }).Count -gt 0)
}
function InTimsAutoCadHours {
  $n = Get-Date
  if ($n.DayOfWeek -eq 'Saturday' -or $n.DayOfWeek -eq 'Sunday') { return $false }
  $m = $n.Hour * 60 + $n.Minute
  return (($m -ge 510 -and $m -lt 840) -or ($m -ge 900 -and $m -lt 1050))
}
function StartLane([string]$name, [string[]]$stopFlags, [bool]$allowed, [string]$whyNot) {
  foreach ($f in $stopFlags) { if (Test-Path "$d\$f") { Log "${name}: skipped, $f exists"; return } }
  if (IsRunning $name) { Log "${name}: already running, nothing to do"; return }
  if (-not $allowed) { Log "${name}: not started ($whyNot)"; return }
  if ($DryRun) { Log "${name}: WOULD START (dry run)"; return }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "pwsh.exe -NoProfile -WindowStyle Hidden -File `"$d\$name.ps1`""; CurrentDirectory = $d }
  if ($r.ReturnValue -eq 0) { Log "${name}: started (pid $($r.ProcessId))" } else { Log "${name}: START FAILED (WMI return $($r.ReturnValue))" }
}
$hours = InTimsAutoCadHours
$acadRunning = @(Get-Process acad -ErrorAction SilentlyContinue).Count -gt 0
$holdOn = Test-Path "$d\HOLD_ROBOT.flag"
if ($DryRun) { if ($AssumeAcad -ge 0) { $acadRunning = [bool]$AssumeAcad }; if ($AssumeHold -ge 0) { $holdOn = [bool]$AssumeHold }; if ($AssumeHours -ge 0) { $hours = [bool]$AssumeHours } }
# 29 Oct 14:50 (CE 00 found it started the Codex supervisor at 14:47 while Tim's AutoCAD was open for hand checks, inside the 14:00 to 15:00 lunch window): the Codex lanes (the supervisor starts the conveyor and the janitor) are NEVER started while any acad.exe is running or HOLD_ROBOT.flag exists, whatever the hour or CODEX_AUTOSTART.flag says.
# 29 Oct 16:00 (Tim asked whether Codex tests run tonight): the robot goes first. The Codex lanes are not started while a robot job (a tester_run process) is running or while ROBOT_QUEUE.txt still has a job without its .done file, so a Codex look cannot grab AutoCAD in the 3-minute gap between two robot starts. They start when the queue is empty (or the desk deletes the .done-less lines).
function RobotBusyOrPending {
  if ($AssumeRobot -ge 0 -and $DryRun) { return [bool]$AssumeRobot }
  $running = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^(cmd|pwsh|claude)' -and $_.CommandLine -match 'tester_run[0-9]' -and $_.ProcessId -ne $PID }).Count -gt 0
  if ($running) { return $true }
  if (Test-Path "$d\ROBOT_QUEUE.txt") { foreach ($line in Get-Content "$d\ROBOT_QUEUE.txt") { $l = $line.Trim(); if ($l -eq '' -or $l.StartsWith('#')) { continue }; if (-not (Test-Path "$l.done")) { return $true } } }
  return $false
}
$robotFirst = RobotBusyOrPending
$codexOk = (-not $acadRunning) -and (-not $holdOn) -and (-not $robotFirst) -and ((-not $hours) -or (Test-Path "$d\CODEX_AUTOSTART.flag"))
$codexWhy = if ($acadRunning) { 'an AutoCAD (acad.exe) is running' } elseif ($holdOn) { 'HOLD_ROBOT.flag exists' } elseif ($robotFirst) { 'a robot job is running or still queued: the robot goes first' } else { "inside Tim's AutoCAD hours and no CODEX_AUTOSTART.flag" }
if (Test-Path "$d\HOLD_ROBOT.flag") { Log 'note: HOLD_ROBOT.flag exists, the robot lane will start but run no AutoCAD job' }
StartLane 'disk_guard' @('STOP_DISKGUARD.flag') $true ''
StartLane 'chain_robot_standing' @('STOP_CHAIN.flag') $true ''
StartLane 'codex_supervisor' @('STOP_SUPERVISOR.flag', 'STOP_CODEX.flag') $codexOk $codexWhy
