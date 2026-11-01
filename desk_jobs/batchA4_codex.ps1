# CE 02 Sun 1 Nov 2026 13:57 (inside CE 00's GO, to 17:00): runs ONLY verifyA78b_c88 after batchA2_codex.ps1 has finished. Same hand-over as batchA2 (HOLD_ROBOT, backups, usage, restore). Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchA4_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'; $bak = 'C:\CE_WORK\scratch\batchA4_backup'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
function HumanIdle { try { ((Get-Date) - [datetime]::Parse((Get-Content 'C:\ce-fx\c75regrade3\human_last_input.txt' -Raw).Trim())).TotalSeconds } catch { 0 } }
$end = [datetime]::Today.AddHours(17)
L 'batch A3 started; waits for batchA3_codex.ps1 to end'
while (@(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'batchA3_codex\.ps1' }).Count -gt 0) { Start-Sleep 20 }
L 'batchA3 ended'
if ((Get-Date) -ge $end.AddMinutes(-30)) { L 'less than 30 minutes to 17:00: not started'; exit }
while ((HumanIdle) -lt 600 -or (Test-Path "$d\TIM_AT_PC.flag") -or (Test-Path "$d\PAUSE_BATCH_A.flag")) { if ((Get-Date) -ge $end) { L 'window closed'; exit }; Start-Sleep 30 }
Set-Content "$d\HOLD_ROBOT.flag" "CE 02 $(Get-Date -Format 'ddd HH:mm'): Codex batch A3 (CE 00 GO). batchA3_codex.ps1 removes this flag when it ends."
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
L 'starting verifyA78b_c88'
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyA78b_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6' -ReportGlob 'CODEX_VERIFY_A78b_*' -Tries 2
L 'verifyA78b_c88 launcher finished'
L "Codex usage after: $(Usage) percent"
Set-Content "$d\STOP_CODEX.flag" 'CE 02: Codex lane held (put back after batch A3).'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 17:00: files not restored'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) { foreach ($f in $before.Keys) { $now = Sha $f; if ($now -ne $before[$f].sha) { Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force; (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime; L "RESTORED $([IO.Path]::GetFileName($f)): was $now, back to $($before[$f].sha)" } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" } } }
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed. Batch A3 ends.'
