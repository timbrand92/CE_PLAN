# CE 02 3 Nov: waits for chain4 on spec_passl to end, then starts chain4 on spec_passm (Rule 15: AutoCAD never idle). Not a build script.
$ver = '3.0.89+61fd6fbc72710872048a69ef5b46d0e5b55087fa'
while (Get-Process -Id 68900 -ErrorAction SilentlyContinue) { Start-Sleep 30 }
Start-Sleep 20
if ((Get-Date) -lt [datetime]'2026-11-03 07:45' -and -not (Get-Process acad -ErrorAction SilentlyContinue) -and -not (Test-Path 'C:\CE_PLAN\desk_jobs\HOLD_ROBOT.flag')) {
  Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\ce-fx\c75regrade3\chain4.ps1','-SpecFile','C:\ce-fx\retest\spec_passm.txt','-ExpectBuild',$ver,'-StopFirst','"2026-11-03 07:50"','-StopAll','"2026-11-03 08:10"'
}
