# CE 02 Fri 30 Oct 2026 (Rule 17): the "go" step. Tim has left again: restore the Tim-away flags, lift the hand-back hold, restart the C-77 chain if it was interrupted, and let Rule 15 run. Usage: pwsh -NoProfile -File handback_go.ps1 [-DryRun]
param([switch]$DryRun)
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\HANDBACK.log"
function L($t) { $x = ("{0} {1}{2}" -f (Get-Date -Format 'ddd HH:mm:ss'), $(if ($DryRun) { 'DRY ' } else { '' }), $t); Add-Content $log $x; Write-Output $x }
function Act([string]$what, [scriptblock]$do) { if ($DryRun) { L "WOULD $what" } else { & $do; L $what } }
L 'GO received: Tim has left again'
foreach ($fn in 'HOLD_ROBOT.flag', 'STOP_CODEX.flag') { $f = "$d\$fn"; if ((Test-Path $f) -and ((Get-Content $f -Raw) -match '^HANDBACK')) { Act "removed $fn (hand-back's own)" { Remove-Item $f -Force } } elseif (Test-Path $f) { L "$fn is not the hand-back's: left alone" } }
Act 'removed TIM_AT_PC, HANDBACK*, ROBOT_STOP_AT files' { Remove-Item "$d\TIM_AT_PC.flag", "$d\HANDBACK.txt", "$d\HANDBACK_DONE.txt", "$d\HANDBACK_ALERT.txt", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue }
Act 'restored TIM_AWAY.flag and CODEX_AUTOSTART.flag' {
  [IO.File]::WriteAllText("$d\TIM_AWAY.flag", "CE 02 $(Get-Date -Format 'HH:mm') $(Get-Date -Format 'ddd dd MMM'): Tim away again (go message after a hand-back). While this file exists start_lanes.ps1 starts the lanes with CE_RUNNER_TIM_AWAY=1. DELETE it (or run handback.ps1) when Tim is back at the PC.`n")
  [IO.File]::WriteAllText("$d\CODEX_AUTOSTART.flag", "CE 02 $(Get-Date -Format 'HH:mm'): Tim away again; lets the Codex supervisor start inside Tim's usual hours. Delete when Tim is back.`n")
}
# restart the C-77 chain if the build is installed and the chain did not finish
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"
$cur = try { (Get-Item $dll).VersionInfo.ProductVersion } catch { '' }
$base = '3.0.86+5888ee757244aac89283aaaf2ba68e51470ecbb3'
$prog = Get-ChildItem 'C:\ce-fx\c75regrade3' -Filter 'progress_spec_c77*.txt' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime | Select-Object -Last 1
$waiterUp = @(Get-CimInstance Win32_Process -Filter "Name='pwsh.exe'" | Where-Object { $_.CommandLine -match 'wait_install_then_run' }).Count -gt 0
$incomplete = ($cur -and $cur -ne $base) -and ((-not $prog) -or -not ((Get-Content $prog.FullName -Tail 1) -match 'ALL DONE'))
L "installed build '$cur'; C-77 chain progress: $(if ($prog) { $prog.Name + ' last line: ' + (Get-Content $prog.FullName -Tail 1) } else { 'none' }); waiter running: $waiterUp; chain incomplete: $incomplete"
if ($incomplete -and -not $waiterUp) { Act 'started wait_install_then_run.ps1 (it resumes the C-77 chain; done packs are skipped)' { Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = 'pwsh.exe -NoProfile -WindowStyle Hidden -File "C:\CE_PLAN\desk_jobs\wait_install_then_run.ps1"'; CurrentDirectory = $d } | Out-Null } }
Act 'ran start_lanes.ps1 (Codex lane and watchdog)' { & pwsh -NoProfile -File "$d\start_lanes.ps1" *> $null }
L 'GO done: Rule 15 resumes'