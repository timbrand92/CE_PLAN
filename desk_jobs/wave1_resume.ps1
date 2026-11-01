# CE 02 Sun 1 Nov 2026 08:40: keeps the wave 1 robot proofs going. The waiter's chain ends (handback stop) when batchA_codex.ps1 takes the PC at 13:00 and nobody restarts it; this loop does. It runs chain4 on spec_wave1.txt (done packs are skipped from the progress file) and then on spec_wave1_retry.txt whenever no chain4 is running, batchA_codex.ps1 is not running and there is no HOLD_ROBOT.flag, until Mon 2 Nov 08:20. Not a build script. Pause: PAUSE_WAVE1_ROBOT.flag.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\wave1_resume.log"; $dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Running($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }).Count -gt 0 }
function Prog($tag) { (Test-Path 'C:\ce-fx\c75regrade3\progress_spec_wave1.txt') -and ((Get-Content 'C:\ce-fx\c75regrade3\progress_spec_wave1.txt') -match "^$tag (done|skipped)").Count -gt 0 }
L 'wave1_resume started'
$specs = 'C:\ce-fx\retest\spec_wave1_retry.txt'   # 1 Nov 16:25: spec_wave1 is ALL DONE (14:42); a chain4 started on a finished spec starts it again from its first pack, so only the unfinished retry spec is run
$end = [datetime]'2026-11-02 08:20'
$idle = 0
while ((Get-Date) -lt $end) {
  if ((Test-Path 'C:\ce-fx\c75regrade3\progress_spec_wave1_retry.txt') -and (@(Get-Content 'C:\ce-fx\c75regrade3\progress_spec_wave1_retry.txt') -match '^ALL DONE').Count -gt 0) { L 'retry spec ALL DONE: wave1_resume ends'; break }
  Start-Sleep 60
  $near13 = ((Get-Date) -ge [datetime]::Today.AddHours(12).AddMinutes(30))
  $held = (Running 'chain4\.ps1') -or ((Running 'batchA_codex\.ps1') -and $near13) -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Test-Path "$d\PAUSE_WAVE1_ROBOT.flag") -or (Test-Path "$d\CLOSED_WINDOW_NOTICE.txt") -or (Test-Path "$d\ROBOT_STOP_AT.txt")
  if ($held) { $idle = 0; continue }
  if (Running 'c78_orchestrator\.ps1') { continue }
  # nothing holds the PC: wait for 3 quiet minutes, then run the next spec that still has packs to do
  $idle++; if ($idle -lt 3) { continue }; $idle = 0
  $ver = (Get-Item $dll).VersionInfo.ProductVersion
  foreach ($s in $specs) {
    L "starting chain4 on $s (build $ver)"
    $env:CE_RUNNER_TIM_AWAY = '1'
    & pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile $s -ExpectBuild $ver -StopFirst '2026-11-02 08:00' -StopAll '2026-11-02 08:20'
    L "chain4 on $s ended"
    if ((Test-Path "$d\HOLD_ROBOT.flag") -or (Test-Path "$d\ROBOT_STOP_AT.txt")) { break }
  }
}
L 'wave1_resume ends (Mon 08:20)'
