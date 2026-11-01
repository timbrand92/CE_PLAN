# CE 02, Sun 1 Nov 2026 13:25: RETRY of Codex batch A inside CE 00's GO window (try 1 at 13:00 ended NOT TESTED: Explorer minimised). Original text: Codex batch A (K1, A78, S467) on the installed build, CE 00 written GO 04:40 for Sun 13:00 to 17:00 PC clock. Not a build script: it only schedules the existing launcher launch_codex_retry.ps1 and hands the PC between the robot and Codex.
# Pause by creating C:\CE_PLAN\desk_jobs\PAUSE_BATCH_A.flag (nothing new starts; a running look is left alone).
# Conditions (CE 00): no human input for 10 minutes (Tim may be at the PC: wait, never fight for the screen); copies only; the robot hands AutoCAD over (HOLD_ROBOT.flag) and takes it back at the end; STOP_CODEX goes back up when the reports are in or at 17:00; Codex meter from queue.log read before and after, stop if it would pass 50 percent.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchA2_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'
$bak = 'C:\CE_WORK\scratch\batchA2_backup'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function HumanIdle { try { ((Get-Date) - [datetime]::Parse((Get-Content 'C:\ce-fx\c75regrade3\human_last_input.txt' -Raw).Trim())).TotalSeconds } catch { 0 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
$start = (Get-Date); $end = [datetime]::Today.AddHours(17)
$watch = @(
  'C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_RecentValues.json',
  'C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_Settings.json',
  'C:\Users\TimothyBrand\AppData\Roaming\CE_STRUC_SUITE\CS_Settings.json',
  'C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\settings.json')
L 'batch A script started; waits for 13:00'
while ((Get-Date) -lt $start) { Start-Sleep 30 }
L 'it is 13:00 or later'
# 1. wait for a quiet PC (no human input for 10 minutes, no TIM_AT_PC flag)
while ($true) {
  if ((Get-Date) -ge $end) { L 'window closed before the PC was quiet: nothing started'; exit }
  if (Test-Path "$d\PAUSE_BATCH_A.flag") { Start-Sleep 30; continue }
  if ((HumanIdle) -ge 600 -and -not (Test-Path "$d\TIM_AT_PC.flag")) { break }
  Start-Sleep 30
}
# 2. hand over: stop the robot taking new work, wait for AutoCAD to end
Set-Content "$d\HOLD_ROBOT.flag" "CE 02 $(Get-Date -Format 'ddd HH:mm'): Codex batch A (CE 00 GO 04:40 Sun). The robot hands AutoCAD over; batchA_codex.ps1 removes this flag when the batch ends."
# the typed chain reads ROBOT_STOP_AT.txt (latest time a pack may END; an old time is ignored), so a rolling 'one minute from now' keeps it from starting a pack while Codex has the PC
$roller = Start-Job -ScriptBlock { while ($true) { Set-Content 'C:\CE_PLAN\desk_jobs\ROBOT_STOP_AT.txt' ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15 } }
L 'HOLD_ROBOT.flag set; waiting for the robot AutoCAD to end'
$tw = Get-Date
while (Get-Process acad -ErrorAction SilentlyContinue) { if (((Get-Date) - $tw).TotalMinutes -gt 30) { L 'AutoCAD still running after 30 minutes: batch A stopped, HOLD_ROBOT.flag removed'; Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit }; Start-Sleep 20 }
# 3. back up and fingerprint the files a look may rewrite (Tim's real settings)
New-Item -ItemType Directory -Force -Path $bak | Out-Null
$before = @{}
foreach ($f in $watch) { if (Test-Path -LiteralPath $f) { $before[$f] = @{ sha = (Sha $f); mtime = (Get-Item -LiteralPath $f).LastWriteTimeUtc; copy = (Join-Path $bak ([IO.Path]::GetFileName($f))) }; Copy-Item -LiteralPath $f -Destination $before[$f].copy -Force; L "backed up $([IO.Path]::GetFileName($f)) sha $($before[$f].sha)" } }
$u0 = Usage; L "Codex usage before: $u0 percent (queue.log last usage line)"
# 4. lift STOP_CODEX (original text kept)
$stopText = $null; if (Test-Path "$d\STOP_CODEX.flag") { $stopText = Get-Content "$d\STOP_CODEX.flag" -Raw; Remove-Item "$d\STOP_CODEX.flag" -Force; L 'STOP_CODEX.flag lifted' }
# 5. the three looks, one at a time (one AutoCAD)
$looks = @(
  @{ line = 'verifyA78_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6'; glob = 'CODEX_VERIFY_A78_*' },
  @{ line = 'verifyS467_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6'; glob = 'CODEX_VERIFY_S467_*' },
  @{ line = 'verifyK1_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6'; glob = 'CODEX_VERIFY_K1_*' })
foreach ($k in $looks) {
  $nm = $k.line.Split('|')[0]
  if ((Get-Date) -ge $end.AddMinutes(-25)) { L "not starting ${nm}: less than 25 minutes to 17:00"; continue }
  $u = Usage; if ($u -ge 0 -and $u -ge 45) { L "not starting ${nm}: Codex usage $u percent (stop line 50 with this look's cost)"; continue }
  if (Test-Path "$d\PAUSE_BATCH_A.flag") { L "paused before $nm"; while (Test-Path "$d\PAUSE_BATCH_A.flag") { Start-Sleep 30 } }
  while ((HumanIdle) -lt 600 -or (Test-Path "$d\TIM_AT_PC.flag")) { if ((Get-Date) -ge $end) { break }; Start-Sleep 30 }
  if ((Get-Date) -ge $end) { L "window closed before $nm"; break }
  L "starting $nm"
  Start-Process explorer.exe 'C:\Lisp Files\_TEST_COPIES_20260923'; Start-Sleep 5   # batch A try 1: both Explorer windows were minimised and the screen tool refused the start check
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line $k.line -ReportGlob $k.glob -Tries 2
  L "$nm launcher finished"
}
# 6. close: STOP_CODEX back up, restore Tim's remembered values, hand the PC back to the robot
$u1 = Usage; L "Codex usage after: $u1 percent"
Set-Content "$d\STOP_CODEX.flag" $(if ($stopText) { $stopText.TrimEnd() } else { 'CE 02: Codex lane held (put back after batch A).' })
L 'STOP_CODEX.flag put back'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 17:00: not restoring files, tell CE 00'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) {
  foreach ($f in $before.Keys) {
    $now = Sha $f
    if ($now -ne $before[$f].sha) {
      Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force
      (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime
      L "RESTORED $([IO.Path]::GetFileName($f)): was sha $now, back to $($before[$f].sha) and the original date"
    } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" }
  }
}
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag" -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed; the robot takes AutoCAD back. Batch A ends.'
