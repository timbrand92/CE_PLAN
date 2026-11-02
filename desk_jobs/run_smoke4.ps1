# CE 02 Mon 2 Nov 12:35: runs spec_c79a_smoke4.txt (the corrected area-plus-smoke) after the probe chain ends. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\run_smoke4.log"; $dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Running($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }).Count -gt 0 }
L 'started; waits for wave1_resume and chain4 to end'
while ((Running 'wave1_resume\.ps1') -or (Running 'chain4\.ps1') -or (Running 'run_passi\.ps1') -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Test-Path "$d\ROBOT_STOP_AT.txt")) { if ((Get-Date) -ge [datetime]'2026-11-03 06:00') { L 'gave up at 06:00 next day'; exit }; Start-Sleep 60 }
$ver = (Get-Item $dll).VersionInfo.ProductVersion
L "starting chain4 on spec_c79a_smoke4.txt (build $ver)"
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_c79a_smoke4.txt' -ExpectBuild $ver -StopFirst '2026-11-03 07:50' -StopAll '2026-11-03 08:10'
L 'chain4 on the probe spec ended'
