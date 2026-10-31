# CE 01, Sun 1 Nov 2026 00:55: one Team job, the C-79b1 ASSEMBLER (Sonnet), train_c79b1_assembler_job.txt. Installs NOTHING.
# It WAITS (polls every 5 minutes, up to 8 hours) until (1) the C-79a finalizer report holds a GO line and (2) CE 05's Opus pre-reviews of #1969, #1970 and #1972 exist (CE 00, Sun 00:20), then starts. Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c79b1.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\c79b1\tmp', 'C:\CE_WORK\scratch\c79b1\logs', 'C:\CE_WORK\scratch\c79b1\struc' | Out-Null
$fin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C79A_FINALIZER_REPORT_2026-10-31.md'
$areas = 'C:\CE_PLAN\areas'
Log 'chain start: waiting for the C-79a finalizer GO and the pre-reviews of #1969, #1970, #1972'
$deadline = (Get-Date).AddHours(8); $lastNote = Get-Date '2000-01-01'; $ready = $false
while ((Get-Date) -lt $deadline) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $why = @()
  if (-not (Test-Path $fin)) { $why += 'no C-79a finalizer report' }
  else {
    $txt = Get-Content $fin -Raw
    if ($txt -match 'NO-GO at') { Log 'C-79a finalizer verdict is negative: assembler not started, the desk reads the report'; exit }
    if (-not ($txt -match '\*\*GO at `[0-9a-f]{40}`')) { $why += 'finalizer report has no GO line yet' }
  }
  $rv = Get-ChildItem $areas -Filter 'OPUS_PREREVIEW_*.md' -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt (Get-Date '2026-11-01 00:00') }
  $rtxt = ($rv | ForEach-Object { $_.Name + ' ' + (Get-Content $_.FullName -Raw) }) -join "`n"
  foreach ($n in '1969', '1970', '1972') { if ($rtxt -notmatch ('#' + $n + '([^0-9]|$)')) { $why += "no Opus pre-review for #$n" } }
  if ($why.Count -eq 0) { $ready = $true; break }
  if (((Get-Date) - $lastNote).TotalMinutes -ge 30) { Log ('waiting: ' + ($why -join '; ')); $lastNote = Get-Date }
  Start-Sleep -Seconds 300
}
if (-not $ready) { Log 'gave up after 8 hours: the desk reads why'; exit }
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
while ($free -lt 27) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Log "C: has $free GB free, under the 27 GB floor: waiting"; Start-Sleep -Seconds 600
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
}
$job = "$d\train_c79b1_assembler_job.txt"; $lg = "$d\train_c79b1_assembler_job.log"
$cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\c79b1\struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\c79b1\logs"&& set "TEMP=C:\CE_WORK\scratch\c79b1\tmp"&& set "TMP=C:\CE_WORK\scratch\c79b1\tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log "starting train_c79b1_assembler_job.txt (sonnet), C: $free GB free"
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
Log 'finished train_c79b1_assembler_job.txt'
if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your|/login')) { Log 'assembler log ends with a login or limit line: the desk reads it'; exit }
Log 'lane finished'
