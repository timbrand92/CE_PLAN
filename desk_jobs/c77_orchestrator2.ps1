# CE 02 Fri 30 Oct 2026 16:45: C-77 orchestrator 2 (CE 00 decision b, relayed 16:35). Replaces c77_orchestrator.ps1.
# The typed-only cases run at any time (typed chain = spec_c77_typed_all.txt). The pointer cases, the one-switch pointer diagnostic and the Codex looks run only after 5 QUIET minutes
# (no keyboard or mouse input, Windows GetLastInputInfo), one case per AutoCAD start so a person coming back costs at most one case. A BLOCKED result is never counted: it is re-queued (3 tries).
# AutoCAD is never left idle: if no pointer work can start, the typed chain (or the watchdog's typed fillers) runs. Order kept: pass a, B-055 proof + tier 1, Codex block, pass b. No model tokens.
$d = 'C:\CE_PLAN\desk_jobs'; $log = 'C:\ce-fx\c75regrade3\c77_orchestrator2.log'; $stateF = 'C:\ce-fx\c75regrade3\orch2_state.txt'
$typedSpec = 'C:\ce-fx\retest\spec_c77_typed_all.txt'; $typedProg = 'C:\ce-fx\c75regrade3\progress_spec_c77_typed_all.txt'
$queueF = 'C:\ce-fx\retest\orch2_pointer_queue.txt'; $reports = 'C:\CE_PLAN\areas\runner-reports'; $dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
$quietNeed = 300; $blockMin = 180; $maxTries = 3
Add-Type @"
using System; using System.Runtime.InteropServices;
public class LIO { [StructLayout(LayoutKind.Sequential)] public struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
 [DllImport("user32.dll")] public static extern bool GetLastInputInfo(ref LASTINPUTINFO p);
 public static double IdleSec() { var i = new LASTINPUTINFO(); i.cbSize = (uint)Marshal.SizeOf(i); GetLastInputInfo(ref i); return ((uint)Environment.TickCount - i.dwTime)/1000.0; } }
"@
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function HumanIdle { # CE 02 18:30: the robot's own keystrokes reset the Windows idle clock, so the gate would never open while the robot runs. input_watch2.ps1 writes the time of the last input that was NOT the robot's (foreground acad/console while a case runner lives = robot). Fresh file (under 30 s old) = use it; else the raw Windows clock.
  $hf = 'C:\ce-fx\c75regrade3\human_last_input.txt'
  try { if ((Test-Path $hf) -and ((Get-Date) - (Get-Item $hf).LastWriteTime).TotalSeconds -lt 30) { return ((Get-Date) - [datetime]::Parse((Get-Content $hf -Raw).Trim())).TotalSeconds } } catch { }
  return [LIO]::IdleSec() }
function Quiet { (HumanIdle) -ge $quietNeed }
function Build { (Get-Item $dll).VersionInfo.ProductVersion }
function TypedAlive { @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain4\.ps1' -and $_.CommandLine -match 'spec_c77_typed_all' -and $_.Name -match 'pwsh' }).Count -gt 0 }
function AnyChain { @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain4\.ps1|case_runner\.ps1' -and $_.Name -match 'pwsh' }).Count -gt 0 }
function TypedDone { (Test-Path $typedProg) -and ((Get-Content $typedProg -Tail 1) -match 'ALL DONE') }
function StartTyped { $cmd = 'pwsh.exe -NoProfile -WindowStyle Hidden -Command "$env:CE_RUNNER_TIM_AWAY=''1''; & ''C:\ce-fx\c75regrade3\chain4.ps1'' -SpecFile ''C:\ce-fx\retest\spec_c77_typed_all.txt'' -StopFirst ''2026-10-31 05:00'' -StopAll ''2026-10-31 05:30''"'; $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = $cmd; CurrentDirectory = 'C:\ce-fx\c75regrade3' }; L "typed chain started pid $($r.ProcessId)" }
function Hold { [IO.File]::WriteAllText("$d\STOP_CODEX.flag", "CE 02 chain4 $(Get-Date -Format 'HH:mm') Fri 30 Oct: holds the Codex lane (orchestrator 2).`n") }
function ReleaseHold { $f = "$d\STOP_CODEX.flag"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^CE 02 chain4')) { Remove-Item $f -Force } }
function Pause-Typed { # chain stops at its next pack boundary: the stop time must stay fresh (chain4 ignores one older than 1 minute), so it is rewritten every 20 s until the chain is gone
  L 'quiet PC and pointer work pending: pausing the typed chain at its next pack boundary'
  while (TypedAlive) { Set-Content "$d\ROBOT_STOP_AT.txt" ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 20; if (-not (Quiet)) { L 'input seen while waiting for the boundary: pointer work cancelled, typed chain keeps going'; Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; return $false } }
  Remove-Item "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; return $true }
# state: key|result|attempts|time
$state = @{}; if (Test-Path $stateF) { foreach ($l in (Get-Content $stateF)) { $q = $l -split '\|'; if ($q.Count -ge 3) { $state[$q[0]] = @{ r = $q[1]; n = [int]$q[2] } } } }
function Save($k, $r, $n) { $state[$k] = @{ r = $r; n = $n }; Add-Content $stateF ("{0}|{1}|{2}|{3}" -f $k, $r, $n, (Get-Date -Format 'ddd HH:mm')) }
function Finished($k) { $state.ContainsKey($k) -and ($state[$k].r -ne 'BLOCKED' -or $state[$k].n -ge $maxTries) }
$expect = Build; L "orchestrator 2 started on build $expect; quiet gate = $quietNeed s without input"
function CodexFirst { # CE 00 17:10: Codex block first in the first quiet window, not before 17:53; pointer items wait for it
  $cd = $state.ContainsKey('CODEX') -and $state['CODEX'].r -eq 'DONE'; if ($cd) { return $false }; return $true }
function Pending { $i = 0; $all = @(Get-Content $queueF | Where-Object { $_.Trim() -and $_ -notmatch '^\s*#' } | Where-Object { -not (Finished ($_.Split('|')[0])) } | ForEach-Object { $k = $_.Split('|')[0]; $n = 0; if ($state.ContainsKey($k)) { $n = $state[$k].n }; [pscustomobject]@{ L = $_; N = $n; I = $i++ } } | Sort-Object N, I | ForEach-Object { $_.L }); if (CodexFirst) { if ((Get-Date) -ge (Get-Date).Date.AddHours(17).AddMinutes(53)) { return @($all | Where-Object { $_.Split('|')[0] -eq 'CODEX' }) } else { return @() } }; return $all }
function RunItem($line) {
  $p = $line -split '\|'; $key = $p[0]; $tag = $p[1]
  if ($key -eq 'CODEX') { RunCodexBlock; return }
  $spec = "C:\ce-fx\retest\orch2_item_$key.txt"; Set-Content $spec ("{0}|{1}|{2}" -f $tag, $p[2], $p[3])
  $t0 = Get-Date; L "pointer item $key ($($p[3]), $($p[4])) starting; PC idle $([int][LIO]::IdleSec()) s"
  $env:CE_RUNNER_TIM_AWAY = '1'
  & pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile $spec -ExpectBuild $expect -StopFirst '2026-10-31 05:00' -StopAll '2026-10-31 05:30' -Fresh
  $res = 'NOREPORT'
  $rj = Get-ChildItem "$reports\RUN-*-C3.0.87-$tag.json" -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge $t0 } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if ($rj) { try { $j = Get-Content $rj.FullName -Raw | ConvertFrom-Json; $res = [string]@($j.cases)[0].result } catch { $res = 'READERR' } }
  $n = 1; if ($state.ContainsKey($key)) { $n = $state[$key].n + 1 }
  if ($res -in @('NOREPORT', 'READERR')) { $res = 'BLOCKED' }
  Save $key $res $n
  L ("pointer item $key ended: $res (try $n), idle now $([int][LIO]::IdleSec()) s" + $(if ($res -eq 'BLOCKED') { ' - NOT counted, re-queued' } else { '' }))
}
function RunCodexBlock {
  L 'Codex block starting (PC quiet)'
  ReleaseHold; & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null
  $t0 = Get-Date
  while (((Get-Date) - $t0).TotalMinutes -lt $blockMin) {
    Start-Sleep 30
    $done = @(Get-Content "$d\CONVEYOR_DONE.txt" -ErrorAction SilentlyContinue)
    $pending = @(Get-Content "$d\CONVEYOR_QUEUE.txt" | Where-Object { $_.Trim() -and $_ -notmatch '^\s*#' -and ($done -notcontains $_.Split('|')[0]) }).Count
    $lookRunning = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|codex\.js exec' -and $_.Name -match 'pwsh|node' }).Count -gt 0
    if ($pending -eq 0 -and -not $lookRunning) { L 'no Codex look pending: block ends early'; break }
    if (((Get-Date) - $t0).TotalMinutes -ge ($blockMin - 15) -and -not $lookRunning) { break }
  }
  while (@(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry|codex\.js exec' -and $_.Name -match 'pwsh|node' }).Count -gt 0) { Start-Sleep 20 }
  Hold; Get-CimInstance Win32_Process -Filter "Name='pwsh.exe'" | Where-Object { $_.CommandLine -match 'codex_conveyor\.ps1' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
  Save 'CODEX' 'DONE' 1; L 'Codex block over; the lane is held again'
}
# wait for the typed-only diagnostic (started 16:31) to finish; then go
while (@(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'diag_typed_now' -and $_.Name -match 'pwsh' }).Count -gt 0) { Start-Sleep 15 }
L 'typed-only diagnostic finished'
$lastLanes = Get-Date
while ($true) {
  if (((Get-Date) - $lastLanes).TotalMinutes -ge 10) { $lastLanes = Get-Date; & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null }   # CE 02 17:25: standing lanes died once (cause unknown); start_lanes is idempotent
  if ((Build) -ne $expect) { L "installed build changed to $(Build): orchestrator 2 stands down (the C-78 waiter takes over)"; break }
  $pend = @(Pending)
  if ((TypedDone) -and $pend.Count -eq 0) { break }
  if ($pend.Count -gt 0 -and (Quiet)) {
    if (TypedAlive) { if (-not (Pause-Typed)) { Start-Sleep 20; continue } }
    $n = 0; while (@(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count -gt 0 -and $n -lt 24) { Start-Sleep 10; $n++ }   # a watchdog filler may be running: wait for it (<= 4 min)
    if (-not (Quiet)) { continue }
    RunItem $pend[0]
    continue
  }
  if (-not (TypedDone) -and -not (AnyChain)) { if (@(Get-Process acad -ErrorAction SilentlyContinue).Count -eq 0) { StartTyped } }
  Start-Sleep 20
}
if ((Build) -eq $expect) {
  if (-not (TypedDone) -or (Pending).Count -gt 0) { L 'loop ended early without finishing' } else {
    L 'C-77 full set ALL DONE (typed chain, pointer queue, Codex block)'
    Set-Content "$d\FULL_SET_DONE.txt" ("C-77 full set ALL DONE " + (Get-Date -Format 'ddd dd HH:mm') + "; the Codex block (if any) is over; AutoCAD is free for the C-78 window (CE 01 writes CLOSED_WINDOW_NOTICE.txt).")
    ReleaseHold; & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null; L 'Codex lane released; start_lanes run; the watchdog now feeds fillers' }
}






