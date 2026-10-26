# Desk 26 Oct 2026: S-45 (Structural only, the six round-2 PRs) assembler (Sonnet) -> finalizer (Opus) -> payload 106 (Sonnet) only if the finalizer says GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag. Log chain_s45.log.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c70.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used.
# The payload builder starts straight after a GO. After it ends the chain checks that PAYLOAD_S1043_REPORT.md exists: a chain that says complete with no report means the payload job ended early (it happened to chain_s44b), and the log says so loudly instead of saying complete.
# Restart of the payload step only (assembler and finalizer already done and GO read): pwsh -NoProfile -File chain_s45.ps1 -PayloadOnly
param([switch]$PayloadOnly)
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_s45.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  WaitForOthers
  if (Stopped) { return }
  $job = "$d\$file"
  $lg = [IO.Path]::ChangeExtension($job, '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting ${file} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished ${file}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 3 -ErrorAction SilentlyContinue) -match 'hit your session limit')) { Log "${file} log ends with the session-limit line: the desk relaunches it" }
}
function IsGo($fin) {
  if (-not (Test-Path $fin)) { return $false }
  $txt = Get-Content $fin -Raw
  return ($txt -match '\*\*GO at `[0-9a-f]{40}`' -and $txt -notmatch 'NO-GO at')
}
function Stopped() { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $true } return $false }
# Another train (a Civil or Manager chain, or a fix round) may be running its own Team jobs on this PC: wait (up to 4 hours) until none of its claude jobs is running, so two heavy jobs never run together.
function WaitForOthers() {
  $waited = 0
  while ($waited -lt 240) {
    $busy = @(Get-CimInstance Win32_Process -Filter "Name = 'cmd.exe'" | Where-Object { $_.CommandLine -match 'train_c\d+_|payload\d+_c\d+|make_c\d+_|team_apply_review_fixes|train_s4[0-4]_|payload10[0-5]_s' }).Count
    if ($busy -eq 0) { return }
    if ($waited -eq 0) { Log 'another train job is running: waiting for it to finish' }
    Start-Sleep 60
    $waited++
    if (Test-Path "$d\STOP_CHAIN.flag") { return }
  }
  Log 'waited 4 hours for the other job: carrying on'
}
# The disk stop line is 8 GB (GiB). Under it the chain WAITS (polls every 5 minutes, up to 2 hours) and never deletes anything; only after 2 hours does it stop before the next job.
function DiskOk($next) {
  $w = 0
  while ($true) {
    $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
    if ($free -ge 8) { return $true }
    if ($w -eq 0) { Log "C: only ${free} GB free: chain waits before ${next} (stop line 8 GB)" }
    if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $false }
    Start-Sleep 300; $w++
    if ($w -gt 24) { Log "C: still under 8 GB after 2 hours: chain stops before ${next}"; return $false }
  }
}

$sAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S45_ASSEMBLY_REPORT_2026-10-26.md'
$sFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S45_FINALIZER_REPORT_2026-10-26.md'
$sPay = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_S1043_REPORT.md'

if (Stopped) { exit }
if ($PayloadOnly) {
  Log 'chain restart (payload only): S-45 (Structural only); nothing is installed by this chain.'
  if (-not (Test-Path $sAsm)) { Log 'no S-45 assembly report: payload-only restart stops'; exit }
  if (-not (IsGo $sFin)) { Log 'S-45 finalizer report missing or not GO: payload-only restart stops'; exit }
} else {
  Log 'chain start: S-45 (Structural only, six round-2 PRs); nothing is installed by this chain.'
  if (-not (DiskOk 'the assembler')) { exit }
  RunJob 'train_s45_assembler_job.txt' 'sonnet'
  if (Stopped) { exit }
  if (-not (Test-Path $sAsm)) { Log 'no S-45 assembly report: chain stops before the finalizer'; exit }
  if (-not (DiskOk 'the finalizer')) { exit }
  RunJob 'train_s45_finalizer_job.txt' 'opus'
  if (Stopped) { exit }
  if (-not (Test-Path $sFin)) { Log 'no S-45 finalizer report: chain stops before payload 106'; exit }
  if (-not (IsGo $sFin)) { Log 'S-45 finalizer verdict is not GO: no payload 106; the desk reads the report'; exit }
}
if (-not (DiskOk 'payload 106')) { exit }
Log 'S-45 finalizer verdict GO: building payload 106 (candidate s1043) now. Nothing is installed by this chain.'
RunJob 'payload106_s45_job.txt' 'sonnet'
if (Stopped) { exit }
if (Test-Path $sPay) {
  Log 'payload report PAYLOAD_S1043_REPORT.md exists: chain complete (the install chain, chain_install_s45.ps1, is started by the desk)'
} else {
  Log 'PAYLOAD REPORT MISSING: the payload job ended early, no PAYLOAD_S1043_REPORT.md. Chain is NOT complete. The desk restarts the payload step only: pwsh -NoProfile -File chain_s45.ps1 -PayloadOnly'
}
