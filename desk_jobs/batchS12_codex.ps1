# CE 02 Mon 2 Nov 2026: Codex day, looks S1 (Grade mismatch window, six looks) then S2 (Pit Schedule window, six looks) in one hand-over. Waits until NO chain4, NO case_runner and no acad.exe (up to 60 min), settings originals checked before and after, Codex meter before and after each look (S2 only if usage is under 65 and it is before 10:15), STOP_CODEX lifted for the window only, out by 10:45 (CE 01 install slot 11:30). Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchS12_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'; $bak = 'C:\CE_WORK\scratch\batchS12_backup'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
function HumanIdle { try { ((Get-Date) - [datetime]::Parse((Get-Content 'C:\ce-fx\c75regrade3\human_last_input.txt' -Raw).Trim())).TotalSeconds } catch { 0 } }
$end = [datetime]'2026-11-02 10:45'
$start = Get-Date
L 'batch A3 (Codex day) waiting for a free robot'
while ((Get-Date) -lt $start) { Start-Sleep 30 }
$inst = 'payload1|chain_install|desk_install|payload_final|installer'
L "civil bundle ProductVersion: $((Get-Item (Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll')).VersionInfo.ProductVersion)"
while (@(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match $inst -and $_.Name -match 'pwsh|cmd|powershell' -and $_.CommandLine -notmatch 'batchS12' }).Count -gt 0) { if ((Get-Date) -ge $end.AddMinutes(-40)) { L 'an install is still in progress near the end of the window: A3 not started'; exit }; Start-Sleep 30 }
L 'no install in progress; A3 may start (the build is read again below)'
if ((Get-Date) -ge $end.AddMinutes(-40)) { L 'less than 40 minutes to 10:45: not started'; exit }
if ((Usage) -ge 65) { L 'Codex usage 65 percent or more: not started'; exit }
while ((HumanIdle) -lt 600 -or (Test-Path "$d\TIM_AT_PC.flag") -or (Test-Path "$d\PAUSE_BATCH_A.flag")) { if ((Get-Date) -ge $end) { L 'window closed'; exit }; Start-Sleep 30 }
Set-Content "$d\HOLD_ROBOT.flag" "CE 00 GO $(Get-Date -Format 'ddd HH:mm'): Codex batch A3 (CE 00 GO 04:00) (written by the batchS12 script). batchS12_codex.ps1 removes this flag when it ends."
$roller = Start-Job -ScriptBlock { while ($true) { Set-Content 'C:\CE_PLAN\desk_jobs\ROBOT_STOP_AT.txt' ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15 } }
$tw = Get-Date; while ((Get-Process acad -ErrorAction SilentlyContinue) -or (@(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'chain4|case_runner' }).Count -gt 0)) { if (((Get-Date) - $tw).TotalMinutes -gt 60) { L 'robot or AutoCAD still busy after 60 minutes: stopped'; Stop-Job $roller; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit }; Start-Sleep 20 }
# the robot's settings guard restores Tim's files a few seconds AFTER its AutoCAD ends: wait (up to 5 minutes) until the guard file is gone and the three settings files read their known originals, then back up
$knownW = @{ 'TIM_CE_CADTOOLS\CD_Settings.json' = 'ACD64E79A33B'; 'CE_STRUC_SUITE\CS_Settings.json' = 'D604CE689671'; 'CE_CVL_SUITE\settings.json' = 'EFE307C4FC74' }
$tr = Get-Date
while ($true) {
  $okAll = -not (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json')
  foreach ($k in $knownW.Keys) { if ((Sha (Join-Path 'C:\Users\TimothyBrand\AppData\Roaming' $k)) -ne $knownW[$k]) { $okAll = $false } }
  if ($okAll -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { break }
  if (((Get-Date) - $tr).TotalMinutes -gt 5) { L 'settings files not back to their originals after 5 minutes: continuing to the check below'; break }
  Start-Sleep 5
}
New-Item -ItemType Directory -Force -Path $bak | Out-Null
$watch = @('C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_RecentValues.json', 'C:\Users\TimothyBrand\AppData\Roaming\TIM_CE_CADTOOLS\CD_Settings.json', 'C:\Users\TimothyBrand\AppData\Roaming\CE_STRUC_SUITE\CS_Settings.json', 'C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\settings.json')
$before = @{}; foreach ($f in $watch) { if (Test-Path -LiteralPath $f) { $before[$f] = @{ sha = (Sha $f); mtime = (Get-Item -LiteralPath $f).LastWriteTimeUtc; copy = (Join-Path $bak ([IO.Path]::GetFileName($f))) }; Copy-Item -LiteralPath $f -Destination $before[$f].copy -Force; L "backed up $([IO.Path]::GetFileName($f)) sha $($before[$f].sha)" } }
$known = @{ 'CD_Settings.json' = 'ACD64E79A33B'; 'CS_Settings.json' = 'D604CE689671'; 'settings.json' = 'EFE307C4FC74' }
foreach ($f in @($before.Keys)) { $n = [IO.Path]::GetFileName($f); if ($known.ContainsKey($n) -and $before[$f].sha -ne $known[$n]) { L "ABORT: $n reads $($before[$f].sha), not the known original $($known[$n]) (a robot settings pack may be mid-run): nothing started, nothing restored"; Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit } }
L "Codex usage before: $(Usage) percent"
if (Test-Path "$d\STOP_CODEX.flag") { Remove-Item "$d\STOP_CODEX.flag" -Force; L 'STOP_CODEX.flag lifted (STOP_SUPERVISOR.flag stays up)' }
Start-Process explorer.exe 'C:\Lisp Files\_TEST_COPIES_20260923'; Start-Sleep 5
L 'starting verifyS1_c88'
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyS1_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|70|6' -ReportGlob 'CODEX_VERIFY_S1_*' -Tries 2
L 'verifyS1_c88 launcher finished'
L "Codex usage after S1: $(Usage) percent"
if ((Get-Date) -lt [datetime]'2026-11-02 10:15' -and (Usage) -lt 65) {
  L 'starting verifyS2_c88'
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyS2_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|70|6' -ReportGlob 'CODEX_VERIFY_S2_*' -Tries 2
  L 'verifyS2_c88 launcher finished'
} else { L 'S2 not started (after 10:15 or usage 65 percent or more)' }
L "Codex usage after: $(Usage) percent"
Set-Content "$d\STOP_CODEX.flag" 'CE 00 HOLD: Codex lane held after batch A3 (put back by batchS12_codex.ps1 per CE 00 GO 22:15). Only CE 00 releases it.'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 10:45: files not restored'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) { foreach ($f in $before.Keys) { $now = Sha $f; if ($now -ne $before[$f].sha) { Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force; (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime; L "RESTORED $([IO.Path]::GetFileName($f)): was $now, back to $($before[$f].sha)" } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" } } }
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed.'
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"; $ver = (Get-Item $dll).VersionInfo.ProductVersion
$env:CE_RUNNER_TIM_AWAY = '1'
$pr = 'C:\ce-fx\c75regrade3'
$spec = $null
foreach ($sp in 'spec_passc', 'spec_passe', 'spec_passg', 'spec_passh', 'spec_passi', 'spec_passj') { $pf = Join-Path $pr "progress_$sp.txt"; $done = (Test-Path $pf) -and (@(Get-Content $pf -Tail 3) -match 'ALL DONE').Count -gt 0; if (-not $done) { $spec = $sp; break } }
if ($spec -and -not (@(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'chain4' }).Count -gt 0) -and (Get-Date) -lt [datetime]'2026-11-02 10:30') {
  L "restarting chain4 on $spec.txt (build $ver; finished packs are skipped)"
  Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\ce-fx\c75regrade3\chain4.ps1','-SpecFile',"C:\ce-fx\retest\$spec.txt",'-ExpectBuild',$ver,'-StopFirst','"2026-11-02 08:00"','-StopAll','"2026-11-02 10:45"'
} else { L "no pass restart (spec=$spec, after 07:45 or all done)" }
L 'Batch S12 ends.'
Set-Content 'C:\CE_PLAN\desk_jobs\CODEX_NEXT.txt' '2026-11-02T12:35 Codex batch B after the C-79a install and the area-plus-smoke on 3.0.89 (CE 00 written GO needed for B); C-78 SEEN groups 3 to 9 when briefs exist; C Wed 4 Nov 19:00'
L 'CODEX_NEXT.txt rewritten to batch B'
