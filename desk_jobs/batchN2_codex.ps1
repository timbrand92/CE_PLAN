# CE 02 Mon 2 Nov 2026 17:30 (CE 00 order 17:25): takes over from batchN_codex.ps1 the moment its S3b look has finished (it stops batchN and its roller job, then runs the rest of the evening list with B1b, AUD3 and B2b put in and BWb and BWa last), each look only if it can end by 22:30 and Codex usage is under 65 percent. No setting is changed; settings originals checked before and after each look; the robot night queue is restarted at the end. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\batchN2_codex.log"; $runner = 'C:\Lisp Files\_CODEX_RUNNER'; $bak = 'C:\CE_WORK\scratch\batchB_backup'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Usage { $q = Get-Content (Join-Path $runner 'queue.log') -Tail 80 -ErrorAction SilentlyContinue | Where-Object { $_ -match 'usage .*-> *([0-9.]+)%' } | Select-Object -Last 1; if ($q -match '-> *([0-9.]+)%') { [double]$Matches[1] } else { -1 } }
function Sha($p) { if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.Substring(0, 12) } else { 'missing' } }
function Procs($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }) }
$end = [datetime]'2026-11-02 22:30'
L 'batch N2 waiting for batchN to finish S3b'
$nlog = 'C:\CE_PLAN\desk_jobs\batchN_codex.log'
while (-not ((Test-Path $nlog) -and (@(Get-Content $nlog) -match 'verifyS3b_c88 launcher finished').Count -gt 0)) { if ((Get-Date) -ge $end) { L 'window closed before S3b finished'; exit }; Start-Sleep 2 }
foreach ($n in (Procs 'batchN_codex')) { $kids = @(Get-CimInstance Win32_Process | Where-Object { $_.ParentProcessId -eq $n.ProcessId }); foreach ($k in $kids) { Stop-Process -Id $k.ProcessId -Force -ErrorAction SilentlyContinue }; Stop-Process -Id $n.ProcessId -Force -ErrorAction SilentlyContinue; L "stopped batchN pid $($n.ProcessId) and its helper after S3b" }
L 'batchN stopped after S3b; N2 takes over for the rest of the evening'
Set-Content "$d\HOLD_ROBOT.flag" "CE 00 GO $(Get-Date -Format 'ddd HH:mm'): Codex looks S3 to AUD (written by the batchB script). batchN2_codex.ps1 removes this flag when it ends."
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
$looks = @(@('B1b', 30), @('AUD3', 15), @('B2b', 22), @('S5', 34), @('L1a', 34), @('L2a', 32), @('L3a', 33), @('L2b', 21), @('L1b', 32), @('L3b', 31), @('BWb', 29), @('BWa', 22))
foreach ($lk in $looks) {
  $id = $lk[0]; $mins = $lk[1]
  if ((Get-Date).AddMinutes($mins + 5) -gt $end) { L "$id not started: it needs about $mins minutes and the window ends 10:45"; continue }
  if ((Usage) -ge 65) { L "$id not started: Codex usage $(Usage) percent is 65 or more"; continue }
  L "Codex usage before $id : $(Usage) percent"
  L "starting verify${id}_c88"
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line "verify${id}_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|70|6" -ReportGlob "CODEX_*_${id}_*" -Tries 2
  L "verify${id}_c88 launcher finished; Codex usage after: $(Usage) percent"
  while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 15 }
  foreach ($f in $before.Keys) { $n = [IO.Path]::GetFileName($f); if ($known.ContainsKey($n)) { $now = Sha $f; L "after $id : $n sha $now (original $($known[$n]))" } }
}
Set-Content "$d\STOP_CODEX.flag" 'CE 00 HOLD: Codex lane held after looks S3 to AUD (put back by batchN2_codex.ps1 per CE 00 GO 07:15). Only CE 00 releases it.'
while (Get-Process acad -ErrorAction SilentlyContinue) { Start-Sleep 20; if ((Get-Date) -ge $end.AddMinutes(30)) { L 'AutoCAD still running 30 minutes past 10:45: files not restored'; break } }
if (-not (Get-Process acad -ErrorAction SilentlyContinue)) { foreach ($f in $before.Keys) { $now = Sha $f; if ($now -ne $before[$f].sha) { Copy-Item -LiteralPath $before[$f].copy -Destination $f -Force; (Get-Item -LiteralPath $f).LastWriteTimeUtc = $before[$f].mtime; L "RESTORED $([IO.Path]::GetFileName($f)): was $now, back to $($before[$f].sha)" } else { L "unchanged $([IO.Path]::GetFileName($f)) sha $now" } } }
Stop-Job $roller -ErrorAction SilentlyContinue; Remove-Job $roller -Force -ErrorAction SilentlyContinue
Remove-Item "$d\HOLD_ROBOT.flag", "$d\ROBOT_STOP_AT.txt" -Force -ErrorAction SilentlyContinue
L 'HOLD_ROBOT.flag removed.'
$dll = "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll"; $ver = (Get-Item $dll).VersionInfo.ProductVersion
$env:CE_RUNNER_TIM_AWAY = '1'
$pr = 'C:\ce-fx\c75regrade3'; $spec = $null
foreach ($sp in 'spec_passk', 'spec_passk') { $pf = Join-Path $pr "progress_$sp.txt"; $done = (Test-Path $pf) -and (@(Get-Content $pf -Tail 3) -match 'ALL DONE').Count -gt 0; if (-not $done) { $spec = $sp; break } }
if ($spec -and ((Procs 'chain4').Count -eq 0) -and (Get-Date) -lt [datetime]'2026-11-02 23:55') {
  L "restarting chain4 on $spec.txt (build $ver; finished packs are skipped)"
  Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile', '-File', 'C:\ce-fx\c75regrade3\chain4.ps1', '-SpecFile', "C:\ce-fx\retest\$spec.txt", '-ExpectBuild', $ver, '-StopFirst', '"2026-11-03 07:50"', '-StopAll', '"2026-11-03 08:10"'
} else { L "no pass restart (spec=$spec, late or all done)" }
Set-Content 'C:\CE_PLAN\desk_jobs\CODEX_NEXT.txt' '2026-11-03T05:30 Codex early window before Tim (needs CE 00 written GO): S4, S7, reruns of lost looks, the b1 Codex looks after the b1 install; robot has AutoCAD overnight; C Wed 4 Nov 19:00'
L 'CODEX_NEXT.txt rewritten to the early window'
L 'Batch N2 ends.'
