# CE 02 Sun 1 Nov 2026 22:15 (CE 00 written GO 21:58: A78c tonight, finished by 23:30): runs ONLY verifyA78c_c88 (A78-03 leader by clicks, A78-04e Esc into the Grade mismatch window). Stops the overnight pass at a pack boundary (ROBOT_STOP_AT), runs Codex, puts STOP_CODEX back, then restarts spec_passc at once (Rule 15). STOP_SUPERVISOR stays up. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchA5_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'; $bak = 'C:\CE_WORK\scratch\batchA5_backup'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
function HumanIdle { try { ((Get-Date) - [datetime]::Parse((Get-Content 'C:\ce-fx\c75regrade3\human_last_input.txt' -Raw).Trim())).TotalSeconds } catch { 0 } }
$end = [datetime]::Today.AddHours(23).AddMinutes(30)
if ((Get-Date) -ge $end.AddMinutes(-35)) { L 'less than 35 minutes to 23:30: not started'; exit }
if ((Usage) -ge 43) { L 'Codex usage 43 percent or more: not started'; exit }
while ((HumanIdle) -lt 600 -or (Test-Path "$d\TIM_AT_PC.flag") -or (Test-Path "$d\PAUSE_BATCH_A.flag")) { if ((Get-Date) -ge $end) { L 'window closed'; exit }; Start-Sleep 30 }
Set-Content "$d\HOLD_ROBOT.flag" "CE 00 GO $(Get-Date -Format 'ddd HH:mm'): Codex look A78c tonight (written by the batchA5 script). batchA5_codex.ps1 removes this flag when it ends."
$roller = Start-Job -ScriptBlock { while ($true) { Set-Content 'C:\CE_PLAN\desk_jobs\ROBOT_STOP_AT.txt' ((Get-Date).AddMinutes(1).ToString('yyyy-MM-dd HH:mm')); Start-Sleep 15 } }
$tw = Get-Date; while (Get-Process acad -ErrorAction SilentlyContinue) { if (((Get-Date) - $tw).TotalMinutes -gt 30) { L 'AutoCAD still running after 30 minutes: stopped'; Stop-Job $roller; Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue; exit }; Start-Sleep 20 }
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
L 'starting verifyA78c_c88'
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyA78c_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|45|6' -ReportGlob 'CODEX_VERIFY_A78c_*' -Tries 2
L 'verifyA78c_c88 launcher finished'
L "Codex usage after: $(Usage) percent"
Set-Content "$d\STOP_CODEX.flag" 'CE 00 HOLD: Codex lane held after look A78c (put back by batchA5_codex.ps1 per CE 00 GO 21:58). Only CE 00 releases it.'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 23:30: files not restored'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) { foreach ($f in $before.Keys) { $now = Sha $f; if ($now -ne $before[$f].sha) { Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force; (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime; L "RESTORED $([IO.Path]::GetFileName($f)): was $now, back to $($before[$f].sha)" } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" } } }
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed.'
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"; $ver = (Get-Item $dll).VersionInfo.ProductVersion
$env:CE_RUNNER_TIM_AWAY = '1'
L "restarting chain4 on spec_passc.txt (build $ver; finished packs are skipped)"
Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\ce-fx\c75regrade3\chain4.ps1','-SpecFile','C:\ce-fx\retest\spec_passc.txt','-ExpectBuild',$ver,'-StopFirst','2026-11-02 08:00','-StopAll','2026-11-02 08:20'
L 'Batch A5 ends.'
