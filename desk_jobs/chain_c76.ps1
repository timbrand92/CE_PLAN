# Desk 29 Oct 2026: C-76 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 112 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
# C-76 is a BUG-FIX TRAIN OF THREE PRs (#1834: BUG-859 double-click on a downpipe opens CE's Edit source window before AutoCAD's attribute editor; #1835: BUG-372 CDCHECK prints no raw handles or CE ids; #1836: BUG-090 the Manager About window grows to fit its rows; three switches, all ON by default), plus any LATE ADDITIONS the PR list names (BUG-1228, BUG-1229). Manager code IS changed (#1836). Plan items stay paused until Tim lifts the pause. It sits on top of the C-75 branch claude/rel-20261026z (installed on Tim's PC since 29 Oct 00:21). The jobs read their PR numbers from C:\CE_PLAN\areas\TRAIN_C76_PR_LIST_2026-10-29.md.
# Only one dotnet may run at a time on this PC, so the chain WAITS (up to 8 hours) while any other dotnet-running chain process is found (an older train chain, a fix chain, a bug chain, a fb team chain, an apply chain or a payload chain); chain_install_* chains run no dotnet and are not waited for.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c75.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used. If the Team login is expired the job dies at once with a login line in its log: the chain logs that, and the desk runs the same job text as a Max Agent instead (headless claude -p on the Max config fails OAuth).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c76.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $job = "$d\$file"
  $lg = [IO.Path]::ChangeExtension($job, '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting ${file} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished ${file}"
  if (Test-Path $lg) {
    $tail = Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue
    if ($tail -match 'hit your session limit') { Log "${file} log ends with the session-limit line: the desk relaunches it" }
    if ($tail -match 'Please run /login|Invalid API key|OAuth|authentication_error|not logged in') { Log "${file} log ends with a login line: the Team login looks expired, the desk runs this job text as a Max Agent" }
  }
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
# Any other pwsh process that runs a dotnet-using chain (never this chain itself, never an install chain).
function OtherDotnetChains() {
  return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.ProcessId -ne $PID -and $_.CommandLine -match 'chain_c(?!76)\d+\w*\.ps1|chain_bug\w+\.ps1|chain_fb_team\d*\.ps1|chain_apply_\w+\.ps1|chain_payload\w+\.ps1' })
}

if (Stopped) { exit }
Log 'chain start: C-76 (Civil + Manager, three bug-fix PRs #1834 BUG-859, #1835 BUG-372, #1836 BUG-090, plus any late additions in the PR list); nothing is installed by this chain.'

# If another dotnet-running chain is still running, wait (up to 8 hours): one dotnet at a time on this PC.
$w = 0
while ((OtherDotnetChains).Count -gt 0) {
  if ($w -eq 0) { Log 'another dotnet-running chain is still running: waiting for it to finish' }
  if (Stopped) { exit }
  Start-Sleep 60; $w++
  if ($w -gt 480) { Log 'another dotnet-running chain still running after 8 hours: chain stops for the desk'; exit }
}

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C76_ASSEMBLY_REPORT_2026-10-29.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C76_FINALIZER_REPORT_2026-10-29.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c76_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-76 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c76_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-76 finalizer report: chain stops before payload 112'; exit }
if (-not (IsGo $cFin)) { Log 'C-76 finalizer verdict is not GO: no payload 112; the desk reads the report'; exit }
# The payload needs the installed line to be Civil 3.0.85 (C-75). Wait (poll every 5 minutes, up to 8 hours) if it is not.
$w = 0
while (-not ((InstalledCivil).StartsWith('3.0.85'))) {
  if ($w -eq 0) { Log ('installed Civil reads [' + (InstalledCivil) + '], not 3.0.85: payload 112 waits for the C-75 line') }
  if (Stopped) { exit }
  Start-Sleep 300; $w++
  if ($w -gt 96) { Log 'installed Civil still not 3.0.85 after 8 hours: chain stops before payload 112; the desk decides'; exit }
}
if (-not (DiskOk 'payload 112')) { exit }
Log 'C-76 finalizer verdict GO and C-75 installed: building payload 112 (candidate c1072). Nothing is installed by this chain.'
RunJob 'payload112_c76_job.txt' 'sonnet'
Log 'chain complete'
