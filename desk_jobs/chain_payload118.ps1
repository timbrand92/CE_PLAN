# CE 01, Tue 3 Nov 2026 11:00: C-79b2 payload pre-build (register B-174, CE 00 "b2 go" 00:55). Three Team jobs in order: A merge (Sonnet), B Opus re-read, C build (Sonnet). Installs NOTHING, no deploy flag. Disk floor 29 GB (CE 00). Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern. Start with WMI Win32_Process Create.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_payload118.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\p118_tmp', 'C:\CE_WORK\scratch\p118_logs', 'C:\CE_WORK\scratch\p118_struc' | Out-Null
function Wait-Disk($what) {
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1); $tries = 0
  while ($free -lt 29 -and $tries -lt 24) {
    if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $false }
    Log "C: has $free GB free, under the 29 GB floor: waiting before $what"; Start-Sleep -Seconds 300; $tries++
    $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  }
  if ($free -lt 29) { Log "C: still $free GB after 2 hours: $what not started"; return $false }
  return $true
}
function Run-Job($jobName, $model) {
  $job = "$d\$jobName.txt"; $lg = "$d\$jobName.log"
  $cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\p118_struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\p118_logs"&& set "TEMP=C:\CE_WORK\scratch\p118_tmp"&& set "TMP=C:\CE_WORK\scratch\p118_tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting $jobName ($model)"
  $pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
  Log "finished $jobName"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your|/login')) { Log "$jobName log ends with a login or limit line: the desk reads it"; return $false }
  return $true
}
function First-Line($f) { if (Test-Path $f) { return (Get-Content $f -TotalCount 1) } else { return '' } }

if (-not (Wait-Disk 'stage A')) { exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
Remove-Item "$d\PAYLOAD118A_MERGE_NOTE.md", "$d\PAYLOAD118B_VERDICT.md" -ErrorAction SilentlyContinue
if (-not (Run-Job 'payload118a_c79c_merge_job' 'sonnet')) { exit }
$a = First-Line "$d\PAYLOAD118A_MERGE_NOTE.md"
if ($a -notmatch 'MERGE CLEAN') { Log "stage A did not end clean ($a): the desk reads PAYLOAD118A_MERGE_NOTE.md"; exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
if (-not (Run-Job 'payload118b_c79c_reread_job' 'opus')) { exit }
$b = First-Line "$d\PAYLOAD118B_VERDICT.md"
if ($b -ne 'VERDICT: OK') { Log "stage B verdict is not OK ($b): the desk reads PAYLOAD118B_VERDICT.md"; exit }
if (-not (Wait-Disk 'stage C')) { exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
if (-not (Run-Job 'payload118c_c79c_build_job' 'sonnet')) { exit }
Log 'lane finished: read the end of payload118c_c79c_build_job.log and PAYLOAD_C1078_REPORT.md'
