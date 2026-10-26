# Desk 26 Oct 2026: C-70 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 105 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
# C-70 is a small diagnostic train (one PR, #1798, the BUG-861 diagnostic switches, all OFF by default). It sits on top of the C-69 branch, so it starts only when chain_c69.ps1 has finished, and its payload step waits until C-69 is installed (the payload compares the candidate with the installed bundle, and the installed line must be Civil 3.0.79).
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c69.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c70.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
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
# Read-only: the product-version string of the installed Civil DLL (a plain property read, no assembly loading).
function InstalledCivil() {
  $p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Legacy\CE_CVL_SUITE.dll'
  if (-not (Test-Path -LiteralPath $p)) { return '' }
  return (Get-Item -LiteralPath $p).VersionInfo.ProductVersion
}

if (Stopped) { exit }
Log 'chain start: C-70 (Civil + Manager, diagnostic train); nothing is installed by this chain.'

# C-70 builds on the C-69 branch: wait (up to 8 hours) while the C-69 chain is still running.
$w = 0
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c69\.ps1' -and $_.Name -match 'pwsh' }) {
  if ($w -eq 0) { Log 'chain_c69 is still running: waiting for it to finish' }
  if (Stopped) { exit }
  Start-Sleep 60; $w++
  if ($w -gt 480) { Log 'chain_c69 still running after 8 hours: chain stops for the desk'; exit }
}

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C70_ASSEMBLY_REPORT_2026-10-26.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C70_FINALIZER_REPORT_2026-10-26.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c70_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-70 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c70_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-70 finalizer report: chain stops before payload 105'; exit }
if (-not (IsGo $cFin)) { Log 'C-70 finalizer verdict is not GO: no payload 105; the desk reads the report'; exit }
# The payload needs the installed line to be Civil 3.0.79 (C-69). Wait (poll every 5 minutes, up to 8 hours) for the C-69 install chain to finish its work.
$w = 0
while (-not ((InstalledCivil).StartsWith('3.0.79'))) {
  if ($w -eq 0) { Log ('installed Civil reads [' + (InstalledCivil) + '], not 3.0.79: payload 105 waits for the C-69 install') }
  if (Stopped) { exit }
  Start-Sleep 300; $w++
  if ($w -gt 96) { Log 'C-69 still not installed after 8 hours: chain stops before payload 105; the desk decides'; exit }
}
if (-not (DiskOk 'payload 105')) { exit }
Log 'C-70 finalizer verdict GO and C-69 installed: building payload 105 (candidate c1066). Nothing is installed by this chain.'
RunJob 'payload105_c70_job.txt' 'sonnet'
Log 'chain complete'
