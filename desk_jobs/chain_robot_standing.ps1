# Desk 26 Oct 2026 (Tim: the testing number must go up): the robot never idles. Reads ROBOT_QUEUE.txt (one robot job file path per line, in order; blank lines and lines starting # are ignored). When no tester_run job and no install or payload step is running, AutoCAD is closed for 3 minutes and the lock is free, it starts the next job that has no .done marker, runs it on the Team account (Sonnet), writes <job>.done when it ends, then loops. The desk only appends lines to ROBOT_QUEUE.txt. Stop flag STOP_CHAIN.flag; pause flag HOLD_ROBOT.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_robot_standing.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Busy() {
  $p = Get-CimInstance Win32_Process | Where-Object {
    ($_.Name -match 'cmd|pwsh|claude' -and $_.CommandLine -match 'tester_run[0-9]|chain_runner_run|desk_install_[cs][0-9]') -and $_.ProcessId -ne $PID
  }
  return [bool]$p
}
function AcadAbsent() { return -not (Get-Process acad -ErrorAction SilentlyContinue) }
Log 'standing robot queue started'
$gap = 0
while ($true) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $next = $null
  if (Test-Path "$d\ROBOT_QUEUE.txt") {
    foreach ($line in Get-Content "$d\ROBOT_QUEUE.txt") {
      $l = $line.Trim()
      if ($l -eq '' -or $l.StartsWith('#')) { continue }
      if (-not (Test-Path "$l.done")) { $next = $l; break }
    }
  }
  if (-not $next -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Busy)) { $gap = 0; Start-Sleep 60; continue }
  if (-not (AcadAbsent)) { $gap = 0; Start-Sleep 30; continue }
  # AutoCAD absent: it must stay absent for 3 minutes (installs and payload tests use the gap), then go
  $gap++
  # 30 Oct 12:05 (Rule 15, staged speed step 2): 3 minutes only while CE 01 has asked for a closed window (ACAD_IDLE_OK.txt) or an install/payload job runs (Busy above); otherwise 1 minute (two polls)
  $need = if (Test-Path "$d\ACAD_IDLE_OK.txt") { 6 } else { 2 }
  if ($gap -lt $need) { Start-Sleep 30; continue }
  $gap = 0
  if (-not (Test-Path $next)) { Log "queue line missing file: ${next}"; Set-Content "$next.done" 'missing'; continue }
  $lg = [IO.Path]::ChangeExtension($next, '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $next + '" > "' + $lg + '" 2>&1'
  Log "starting ${next}"
  # 27 Oct: -Wait also waits for the job's orphaned grandchildren (tail -f processes it left behind held the queue 47 minutes); wait for the job's own process only
  $sp = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru
  $sp.WaitForExit()
  Set-Content "$next.done" (Get-Date -Format 'yyyy-MM-dd HH:mm')
  Log "finished ${next}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 3 -ErrorAction SilentlyContinue) -match 'hit your session limit')) { Log "${next} log ends with the session-limit line: the desk relaunches it (delete its .done to repeat)" }
}
