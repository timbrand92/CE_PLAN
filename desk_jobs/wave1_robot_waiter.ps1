# CE 02 Sat 31 Oct 2026 16:00: starts the wave 1 robot proofs (spec_wave1.txt) the moment the C-78 FULL run has finished (Rule 15: AutoCAD never idle). Waits for 'ALL DONE' in c78_orchestrator.log and for the C-78 orchestrator and chain to be gone; holds the Codex lane ('CE 02 chain4' STOP_CODEX.flag), runs chain4 on 3.0.88 hidden with stops Mon 2 Nov 08:00 / 08:20 (weekday AutoCAD hours return Monday), then lifts its hold and runs start_lanes. Not a build script. Pause: PAUSE_WAVE1_ROBOT.flag.
$d = 'C:\CE_PLAN\desk_jobs'; $log = 'C:\ce-fx\c75regrade3\wave1_robot_waiter.log'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
L 'waiting for the C-78 FULL run to finish'
while ($true) {
  Start-Sleep 30
  $done = (Select-String -Path 'C:\ce-fx\c75regrade3\c78_orchestrator.log' -Pattern 'ALL DONE' -Quiet -ErrorAction SilentlyContinue)
  $orch = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'c78_orchestrator\.ps1|chain4\.ps1|case_runner\.ps1' }).Count
  if ($done -and $orch -eq 0 -and -not (Test-Path "$d\PAUSE_WAVE1_ROBOT.flag") -and -not (Test-Path "$d\CLOSED_WINDOW_NOTICE.txt")) { break }
}
$ver = (Get-Item $dll).VersionInfo.ProductVersion
L "C-78 FULL finished; build $ver; starting spec_wave1"
[IO.File]::WriteAllText("$d\STOP_CODEX.flag", "CE 02 chain4 $(Get-Date -Format 'HH:mm') Sat 31 Oct: holds the Codex lane while the wave 1 robot proofs run (wave1_robot_waiter).`n")
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_wave1.txt' -ExpectBuild $ver -StopFirst '2026-11-02 08:00' -StopAll '2026-11-02 08:20'
L 'wave 1 chain ended'
$f = "$d\STOP_CODEX.flag"
# 1 Nov 13:40 (CE 00): never delete the Codex hold at a hand-back; only when wave 1 is really over (Mon 2 Nov 08:20 or later)
if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02 chain4') -and ((Get-Date) -ge [datetime]'2026-11-02 08:20')) { Remove-Item $f -Force; L 'STOP_CODEX.flag lifted' }
& pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null
L 'start_lanes run; done'
