# Desk 20 Oct 2026: runs the Codex plan in C:\Lisp Files\_CODEX_RUNNER\QUEUE_20OCT_PLAN.md (week 20 to 27 Oct).
# One Codex run at a time. AutoCAD jobs (verify) wait for the full gate (no acad.exe or accoreconsole, no robot tester job,
# no settings_guard.json, no live lock, no open Codex START). Window builds (bj) need only "no open Codex START": they never
# start AutoCAD. While the AutoCAD gate is shut, a waiting build may go first; otherwise the plan's order is kept.
# Jobs marked WAIT in the plan (lookC1, lookC2) are NOT in this list. Stops if STOP_CODEX.flag exists. Written, not started.
$d = 'C:\Lisp Files\_CODEX_RUNNER'
$bash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path $bash)) { $bash = (Get-Command bash.exe -ErrorAction SilentlyContinue | Select-Object -First 1).Source }
$logFile = 'C:\CE_PLAN\desk_jobs\codex_queue_week20.log'
$outFile = 'C:\CE_PLAN\desk_jobs\codex_queue_week20.out'
$stop = 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag'
function Log($t) { Add-Content $logFile ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function CodexIdle {
  $q = Get-Content (Join-Path $d 'queue.log') -Tail 6 -ErrorAction SilentlyContinue
  $last = ($q | Where-Object { $_ -match ' START | END ' } | Select-Object -Last 1)
  if ($last -match ' START ') { return $false }
  if (@(Get-CimInstance Win32_Process -Filter "Name='node.exe'" | Where-Object { $_.CommandLine -match 'codex.js' }).Count -gt 0) { return $false }
  return $true
}
function AcadGateOk {
  if (-not (CodexIdle)) { return $false }
  if (Get-Process acad, accoreconsole -ErrorAction SilentlyContinue) { return $false }
  if (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run|evidence_job' }) { return $false }
  if (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') { return $false }
  $lock = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lock) { try { $j = Get-Content $lock -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { return $false } } catch { return $false } }
  return $true
}
function GateOk($job) { if ($job.kind -eq 'acad') { AcadGateOk } else { CodexIdle } }
function Done($name) {
  # A job whose END line is already in queue.log is not run twice (re-launch safe).
  [bool](Select-String -Path (Join-Path $d 'queue.log') -SimpleMatch (" END $name ") -Quiet -ErrorAction SilentlyContinue)
}
if (Test-Path $stop) { Log 'STOP flag: not starting'; exit }
# Plan order (by value for the 9 Nov release). Fields for queue3.sh: name|folder|model|effort|maxpct|cost.
$jobs = @(
  @{ kind = 'acad';  line = 'verifyV1_robot_gaps|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|5' },
  @{ kind = 'acad';  line = 'verifyV2_second_eyes|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|5' },
  @{ kind = 'build'; line = 'bj33_cesettings_fix_switches_schedules_civil|C:/Lisp Files/_CODEX_RUNNER|gpt-6.1-sol|low|90|5' },
  @{ kind = 'build'; line = 'bj34_cesettings_fix_switches_drafting_civil|C:/Lisp Files/_CODEX_RUNNER|gpt-6.1-sol|low|90|5' }
)
foreach ($j in $jobs) { $j.name = $j.line.Split('|')[0]; $j.done = (Done $j.name) }
Log ('queue start: ' + (($jobs | Where-Object { -not $_.done } | ForEach-Object { $_.name }) -join ', '))
$waits = 0
while ($jobs | Where-Object { -not $_.done }) {
  if (Test-Path $stop) { Log 'STOP flag: ending'; exit }
  $pending = @($jobs | Where-Object { -not $_.done })
  $first = $pending[0]
  $pick = $null
  if (GateOk $first) { $pick = $first }
  elseif ($first.kind -eq 'acad') {
    # AutoCAD busy: let the next waiting build go (bj34 only after bj33 has ended, because it stacks on bj33's branch).
    $b = $pending | Where-Object { $_.kind -eq 'build' } | Select-Object -First 1
    if ($b -and (CodexIdle)) { $pick = $b }
  }
  if (-not $pick) {
    Start-Sleep 120; $waits++
    if ($waits -gt 720) { Log ('gate never opened for ' + $first.name + ' in 24 h: ending'); exit }
    continue
  }
  # Settle and re-check (a robot pass or an AutoCAD start can begin in the gap).
  Start-Sleep 125
  if (-not (GateOk $pick)) { Log ('gate closed again before ' + $pick.name + ': waiting'); continue }
  if (Test-Path $stop) { Log 'STOP flag: ending'; exit }
  $waits = 0
  Log ('starting ' + $pick.name)
  & $bash -lc ('cd "/c/Lisp Files/_CODEX_RUNNER" && MAXC=1 bash queue3.sh "' + $pick.line + '"') *>> $outFile
  $pick.done = $true
  Log ('finished ' + $pick.name)
}
Log 'queue complete'
