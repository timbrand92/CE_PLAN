# CE 02 Tue 3 Nov 2026 06:10 (CE 00 WRITTEN GO 06:08 in DESK_LOG): Codex early window 06:20 to 08:20 on Civil 3.0.89, at most 8 looks (S3d, B1e, L1b, L2a, L2b, L3b, B1f; S4 and S7 have no brief yet), each only if it can end by 08:20 and starts no later than 07:55, Codex usage under 62 percent, C: above 26 GB. Stops the robot chain at a pack boundary, stops follow_passm.ps1 (it would start spec_passm during the window), settings originals checked before and after each look, STOP_CODEX lifted for the window only and put back, robot restarted at the end. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchN7_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'; $bak = "C:\CE_WORK\scratch\batchN7_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
function Procs($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }) }
$end = [datetime]'2026-11-03 08:20'
L 'batch N7 starts: GO CE 00 06:08'
foreach ($f in (Procs 'follow_passm')) { Stop-Process -Id $f.ProcessId -Force; L "stopped follow_passm pid $($f.ProcessId) (the window needs AutoCAD free)" }
Set-Content "$d\HOLD_ROBOT.flag" "CE 00 GO 06:08: Codex early window. batchN7_codex.ps1 removes this flag when it ends."
Set-Content "$d\ROBOT_STOP_AT.txt" ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm'))
$roller = Start-Job -ScriptBlock { while ($true) { Set-Content 'C:\CE_PLAN\desk_jobs\ROBOT_STOP_AT.txt' ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15 } }
# the chain that batchS12 restarted has the wrong cut-off and no pack under way: stop it (only a chain without a case_runner child)
Start-Sleep 5
foreach ($c in (Procs 'chain4')) { $kids = @(Get-CimInstance Win32_Process | Where-Object { $_.ParentProcessId -eq $c.ProcessId -and $_.CommandLine -match 'case_runner' }); if ($kids.Count -eq 0) { Stop-Process -Id $c.ProcessId -Force; L "stopped idle chain4 pid $($c.ProcessId)" } else { L "chain4 pid $($c.ProcessId) has a pack under way: waiting for it" } }
$tw = Get-Date; while ((Get-Process acad -ErrorAction SilentlyContinue) -or ((Procs 'chain4|case_runner').Count -gt 0)) { if (((Get-Date) - $tw).TotalMinutes -gt 60) { L 'robot or AutoCAD still busy after 60 minutes: stopped'; Stop-Job $roller; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit }; Start-Sleep 20 }
$knownW = @{ 'TIM_CE_CADTOOLS\CD_Settings.json' = 'ACD64E79A33B'; 'CE_STRUC_SUITE\CS_Settings.json' = 'D604CE689671'; 'CE_CVL_SUITE\settings.json' = 'EFE307C4FC74' }
$known = @{ 'CD_Settings.json' = 'ACD64E79A33B'; 'CS_Settings.json' = 'D604CE689671'; 'settings.json' = 'EFE307C4FC74' }
$watch = @('C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_RecentValues.json', 'C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_Settings.json', 'C:\Users\TimothyBrand\AppData\Roaming\CE_STRUC_SUITE\CS_Settings.json', 'C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\settings.json')
function WaitOriginals { $tr = Get-Date; while ($true) { $ok = -not (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'); foreach ($k in $knownW.Keys) { if ((Sha (Join-Path 'C:\Users\TimothyBrand\AppData\Roaming' $k)) -ne $knownW[$k]) { $ok = $false } }; if ($ok -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { return $true }; if (((Get-Date) - $tr).TotalMinutes -gt 5) { return $false }; Start-Sleep 5 } }
if (-not (WaitOriginals)) { L 'settings files not back to their originals after 5 minutes: continuing to the check below' }
New-Item -ItemType Directory -Force -Path $bak | Out-Null
$before = @{}; foreach ($f in $watch) { if (Test-Path -LiteralPath $f) { $before[$f] = @{ sha = (Sha $f); mtime = (Get-Item -LiteralPath $f).LastWriteTimeUtc; copy = (Join-Path $bak ([IO.Path]::GetFileName($f))) }; Copy-Item -LiteralPath $f -Destination $before[$f].copy -Force; L "backed up $([IO.Path]::GetFileName($f)) sha $($before[$f].sha)" } }
foreach ($f in @($before.Keys)) { $n = [IO.Path]::GetFileName($f); if ($known.ContainsKey($n) -and $before[$f].sha -ne $known[$n]) { L "ABORT: $n reads $($before[$f].sha), not the known original $($known[$n]): nothing started, nothing restored"; Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit } }
if (Test-Path "$d\STOP_CODEX.flag") { Remove-Item "$d\STOP_CODEX.flag" -Force; L 'STOP_CODEX.flag lifted (STOP_SUPERVISOR.flag stays up)' }
Start-Process explorer.exe 'C:\Lisp Files\_TEST_COPIES_20260923'; Start-Sleep 5
$looks = @(@('S3d', 25), @('B1e', 25), @('L1b', 32), @('L2a', 32), @('L2b', 21), @('L3b', 31), @('B1f', 18))
foreach ($lk in $looks) {
  $id = $lk[0]; $mins = $lk[1]
  if ($id -isnot [string]) { L "BAD LOOK LIST ENTRY $id"; continue }
  if ((Get-Date) -gt [datetime]'2026-11-03 07:55') { L "$id not started: after 07:55"; continue }
  if ((Get-Date).AddMinutes($mins + 5) -gt $end) { L "$id not started: it needs about $mins minutes and the window ends 08:20"; continue }
  if ((Usage) -ge 62) { L "$id not started: Codex usage $(Usage) percent is 62 or more"; continue }
  if ((Get-PSDrive C).Free / 1GB -lt 26) { L "$id not started: C: below 26 GB"; continue }
  L "Codex usage before $id : $(Usage) percent"
  L "starting verify${id}_c88"
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line "verify${id}_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|70|6" -ReportGlob "CODEX_*_${id}_*" -Tries 2
  L "verify${id}_c88 launcher finished; Codex usage after: $(Usage) percent"
  while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 15 }
  foreach ($f in $before.Keys) { $n = [IO.Path]::GetFileName($f); if ($known.ContainsKey($n)) { $now = Sha $f; L "after $id : $n sha $now (original $($known[$n]))" } }
}
Set-Content "$d\STOP_CODEX.flag" 'CE 00 HOLD: Codex lane held after the early window (put back by batchN7_codex.ps1). Only CE 00 releases it.'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 08:20: files not restored'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) { foreach ($f in $before.Keys) { $now = Sha $f; if ($now -ne $before[$f].sha -and [IO.Path]::GetFileName($f) -ne 'CD_RecentValues.json') { Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force; (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime; L "RESTORED $([IO.Path]::GetFileName($f)): was $now, back to $($before[$f].sha)" } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" } } }
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed.'
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"; $ver = (Get-Item $dll).VersionInfo.ProductVersion
$env:CE_RUNNER_TIM_AWAY = '1'
$pr = 'C:\ce-fx\c75regrade3'; $spec = $null
foreach ($sp in 'spec_passl', 'spec_passm') { $pf = Join-Path $pr "progress_$sp.txt"; $done = (Test-Path $pf) -and (@(Get-Content $pf -Tail 3) -match 'ALL DONE').Count -gt 0; if (-not $done) { $spec = $sp; break } }
if ($spec -and ((Procs 'chain4').Count -eq 0) -and (Get-Date) -lt [datetime]'2026-11-03 08:20') {
  L "restarting chain4 on $spec.txt (build $ver; finished packs are skipped)"
  Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile', '-File', 'C:\ce-fx\c75regrade3\chain4.ps1', '-SpecFile', "C:\ce-fx\retest\$spec.txt", '-ExpectBuild', $ver, '-StopFirst', '"2026-11-03 08:20"', '-StopAll', '"2026-11-03 08:30"'
} else { L "no pass restart (spec=$spec, late or all done)" }
L 'Batch N7 ends.'
