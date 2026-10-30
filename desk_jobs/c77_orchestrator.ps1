# CE 02 Fri 30 Oct 2026 14:45: C-77 orchestrator. The FULL robot set (chain4 pid 55608, started 14:35 on 3.0.87) and the Codex looks share AutoCAD by time-slice: the chain runs until about 18:00, then pauses at a pack boundary (ROBOT_STOP_AT.txt), the Codex lane gets a block of up to 90 minutes (STOP_CODEX lifted, conveyor restarted), then the chain resumes (chain4 skips packs already done on the same build). When the chain finishes, STOP_CODEX is lifted for good and start_lanes runs. No model tokens.
$d = 'C:\CE_PLAN\desk_jobs'; $log = 'C:\ce-fx\c75regrade3\c77_orchestrator.log'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
$spec = 'C:\ce-fx\retest\spec_c77_full.txt'
$prog = 'C:\ce-fx\c75regrade3\progress_spec_c77_full.txt'
function ChainAlive { @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain4\.ps1' -and $_.CommandLine -match 'spec_c77_full' -and $_.Name -match 'pwsh' }).Count -gt 0 }
function StartChain { $cmd = 'pwsh.exe -NoProfile -WindowStyle Hidden -Command "$env:CE_RUNNER_TIM_AWAY=''1''; & ''C:\ce-fx\c75regrade3\chain4.ps1'' -SpecFile ''C:\ce-fx\retest\spec_c77_full.txt'' -StopFirst ''2026-10-31 05:00'' -StopAll ''2026-10-31 05:30''"'; $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = $cmd; CurrentDirectory = 'C:\ce-fx\c75regrade3' }; L "chain4 started pid $($r.ProcessId)" }
function Done { (Test-Path $prog) -and ((Get-Content $prog -Tail 1) -match 'ALL DONE') }
function Hold { [IO.File]::WriteAllText("$d\STOP_CODEX.flag", "CE 02 chain4 $(Get-Date -Format 'HH:mm') Fri 30 Oct: holds the Codex lane while the C-77 FULL robot set runs on 3.0.87.`n") }
function Release { $f = "$d\STOP_CODEX.flag"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02 chain4')) { Remove-Item $f -Force }; & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null }
$today = (Get-Date).Date
$blockStart = $today.AddHours(18); $blockMin = 90
L 'orchestrator started; chain runs until the Codex block at 18:00'
# phase 1: chain until the block time (or until it finishes)
while ((Get-Date) -lt $blockStart -and -not (Done)) { Start-Sleep 30; if (-not (ChainAlive) -and -not (Done) -and (Get-Date) -lt $blockStart.AddMinutes(-30)) { L 'chain4 not alive and not done: restarting'; StartChain } }
if (Done) { L 'full set finished before the block'; Release; L 'released the Codex lane'; exit }
# phase 2: pause the chain at a pack boundary
Set-Content "$d\ROBOT_STOP_AT.txt" ($blockStart.ToString('yyyy-MM-dd HH:mm'))
L "ROBOT_STOP_AT written ($($blockStart.ToString('HH:mm'))): chain finishes its pack and stops"
while (ChainAlive) { Start-Sleep 20 }
Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'chain paused; Codex block starts'
$f = "$d\STOP_CODEX.flag"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02 chain4')) { Remove-Item $f -Force }
& pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null
# the conveyor runs looks; the block ends after blockMin minutes or when no look is pending
$t0 = Get-Date
while (((Get-Date) - $t0).TotalMinutes -lt $blockMin) {
  Start-Sleep 30
  $done = @(Get-Content "$d\CONVEYOR_DONE.txt" -ErrorAction SilentlyContinue)
  $pending = @(Get-Content "$d\CONVEYOR_QUEUE.txt" | Where-Object { $_.Trim() -and $_ -notmatch '^\s*#' -and ($done -notcontains $_.Split('|')[0]) }).Count
  $lookRunning = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|codex\.js exec' -and $_.Name -match 'pwsh|node' }).Count -gt 0
  if ($pending -eq 0 -and -not $lookRunning) { L 'no Codex look pending: block ends early'; break }
  if (((Get-Date) - $t0).TotalMinutes -ge ($blockMin - 15) -and -not $lookRunning) { break }   # do not start a look in the last 15 minutes
}
while (@(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|codex\.js exec' -and $_.Name -match 'pwsh|node' }).Count -gt 0) { Start-Sleep 20 }
Hold
Get-CimInstance Win32_Process -Filter "Name='pwsh.exe'" | Where-Object { $_.CommandLine -match 'codex_conveyor\.ps1' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
L 'Codex block over; chain resumes'
StartChain
while (-not (Done)) { Start-Sleep 30; if (-not (ChainAlive) -and -not (Done)) { L 'chain4 ended without ALL DONE: restarting (it resumes)'; Start-Sleep 15; StartChain } }
L 'full set ALL DONE'
Release
L 'Codex lane released; start_lanes run; the watchdog now feeds fillers'