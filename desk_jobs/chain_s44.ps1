# Desk 25 Oct 2026: S-44 (Structural) assembler (Sonnet) -> finalizer (Opus) -> payload 101 (Sonnet) only if the finalizer says GO, strictly one job after another on the Team account. Installs NOTHING. Stop flag STOP_CHAIN.flag. Each job runs through cmd.exe with the Team config folder and the npm PATH set on the command line (same form as chain_fb_team.ps1).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_s44.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Stopped() { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $true } return $false }
function LowDisk() {
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  if ($free -lt 12) { Log "C: only $free GB: chain stops"; return $true }
  return $false
}
# Another train (a Civil or Manager chain, or the Civil fix round) may be running its own Team jobs on this PC: wait (up to 4 hours) until none of its claude jobs is running, so two heavy jobs never run together.
function WaitForOthers() {
  $waited = 0
  while ($waited -lt 240) {
    $busy = @(Get-CimInstance Win32_Process -Filter "Name = 'cmd.exe'" | Where-Object { $_.CommandLine -match 'train_c\d+_|payload\d+_c\d+|make_c\d+_|team_apply_review_fixes' }).Count
    if ($busy -eq 0) { return }
    if ($waited -eq 0) { Log 'another train job is running: waiting for it to finish' }
    Start-Sleep 60
    $waited++
    if (Test-Path "$d\STOP_CHAIN.flag") { return }
  }
  Log 'waited 4 hours for the other job: carrying on'
}
function RunJob($file, $model) {
  WaitForOthers
  if (Stopped) { return }
  $job = "$d\$file"
  $lg = "$d\" + ($file -replace '\.txt$', '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting $file ($model)"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished $file"
}
function IsGo($fin) {
  if (-not (Test-Path $fin)) { return $false }
  $txt = Get-Content $fin -Raw
  return ($txt -match '\*\*GO at `[0-9a-f]{40}`' -and $txt -notmatch 'NO-GO at')
}

if (Stopped) { exit }
if (LowDisk) { exit }
Log 'chain start: S-44 (Structural only); nothing is installed by this chain.'

$sAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S44_ASSEMBLY_REPORT_2026-10-25.md'
$sFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S44_FINALIZER_REPORT_2026-10-25.md'

RunJob 'train_s44_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $sAsm)) { Log 'no S-44 assembly report: chain stops before the finalizer'; exit }
if (LowDisk) { exit }

RunJob 'train_s44_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $sFin)) { Log 'no S-44 finalizer report: chain stops before payload 101'; exit }
if (-not (IsGo $sFin)) { Log 'S-44 finalizer verdict is not GO: no payload 101; the desk reads the report'; exit }
if (LowDisk) { exit }

Log 'S-44 finalizer verdict GO: building payload 101 (candidate s1042). Nothing is installed by this chain.'
RunJob 'payload101_s44_job.txt' 'sonnet'
Log 'chain complete'
