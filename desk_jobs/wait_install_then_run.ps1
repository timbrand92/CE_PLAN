# CE 02 Fri 30 Oct 2026 06:35 (Rule 15, item 7): when the C-77 install lands, AutoCAD runs the area-plus-smoke set within minutes, with no check-in needed. No model tokens, not a build script.
# 1. Waits until the installed Civil DLL ProductVersion differs from the baseline (3.0.86+5888ee75...), stays the same for 3 minutes, no acad.exe/accoreconsole runs and no install/payload job is running.
# 2. Starts chain4.ps1 (shorter all-clear wait) on the spec named in C:\ce-fx\retest\C77_SPEC_TO_RUN.txt (default spec_c77_area_smoke_FINAL_DRAFT.txt), holding the Codex lane with STOP_CODEX.flag ('CE 02 chain4').
# 3. When the chain ends: removes its STOP_CODEX.flag, appends run79 and run78 to ROBOT_QUEUE.txt (from ROBOT_QUEUE_AFTER_C77.txt), runs start_lanes.ps1 so the next work starts in the same step.
$d = 'C:\CE_PLAN\desk_jobs'; $log = 'C:\ce-fx\c75regrade3\wait_install_then_run.log'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
$base = '3.0.86+5888ee757244aac89283aaaf2ba68e51470ecbb3'
L "waiting for an install (baseline $base)"
$stable = 0; $last = ''
while ($true) {
  Start-Sleep 30
  $cur = try { (Get-Item $dll).VersionInfo.ProductVersion } catch { '' }
  if (-not $cur -or $cur -eq $base) { $stable = 0; $last = ''; continue }
  if ($cur -eq $last) { $stable++ } else { $stable = 0; $last = $cur; L "installed build now reads $cur; waiting for it to stay put" }
  $busy = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count -gt 0
  $inst = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'payload1|chain_install|desk_install|payload_final|installer' -and $_.Name -match 'pwsh|cmd|powershell' -and $_.CommandLine -notmatch 'wait_install_then_run' }).Count -gt 0
  if ($stable -ge 6 -and -not $busy -and -not $inst -and -not (Test-Path "$d\HOLD_ROBOT.flag") -and -not (Test-Path "$d\TIM_AT_PC.flag")) { break }
}
L "install settled on ${last}: starting the chain"
Remove-Item "$d\ACAD_IDLE_OK.txt" -Force -ErrorAction SilentlyContinue
[IO.File]::WriteAllText("$d\STOP_CODEX.flag", "CE 02 chain4 $(Get-Date -Format 'HH:mm') Fri 30 Oct: holds the Codex lane while the C-77 area plus smoke robot set runs; wait_install_then_run.ps1 removes it when the chain ends.`n")
$spec = 'C:\ce-fx\retest\spec_c77_area_smoke_FINAL_DRAFT.txt'
if (Test-Path 'C:\ce-fx\retest\C77_SPEC_TO_RUN.txt') { $sp = (Get-Content 'C:\ce-fx\retest\C77_SPEC_TO_RUN.txt' -TotalCount 1).Trim(); if ($sp -and (Test-Path $sp)) { $spec = $sp } }
L "spec: ${spec}"
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile $spec -StopFirst '2026-10-31 05:00' -StopAll '2026-10-31 05:30'
L 'chain4 ended'
$f = "$d\STOP_CODEX.flag"
if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02 chain4')) { Remove-Item $f -Force; L 'STOP_CODEX.flag lifted' }
if (Test-Path "$d\ROBOT_QUEUE_AFTER_C77.txt") { foreach ($line in Get-Content "$d\ROBOT_QUEUE_AFTER_C77.txt") { if ($line.Trim() -and -not $line.StartsWith('#')) { Add-Content "$d\ROBOT_QUEUE.txt" $line } }; L 'run79 and run78 appended to ROBOT_QUEUE.txt' }
& pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null
L 'start_lanes run; done'