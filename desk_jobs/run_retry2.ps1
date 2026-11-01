# CE 02 Sun 1 Nov 17:30: runs spec_wave1_retry2.txt once, after the wave 1 retry spec has finished (wave1_resume ends) or at the latest Mon 2 Nov 06:00. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\run_retry2.log"; $dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Running($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }).Count -gt 0 }
L 'started; waits for wave1_resume and chain4 to end'
while ((Running 'wave1_resume\.ps1') -or (Running 'chain4\.ps1') -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Test-Path "$d\ROBOT_STOP_AT.txt")) { if ((Get-Date) -ge [datetime]'2026-11-02 06:00') { L 'gave up at 06:00'; exit }; Start-Sleep 60 }
$ver = (Get-Item $dll).VersionInfo.ProductVersion
L "starting chain4 on spec_wave1_retry2.txt (build $ver)"
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_wave1_retry2.txt' -ExpectBuild $ver -StopFirst '2026-11-02 08:00' -StopAll '2026-11-02 08:20'
L 'chain4 on the probe spec ended'
