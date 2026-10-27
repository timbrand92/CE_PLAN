# Desk 28 Oct 2026: C-74 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 110 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
# C-74 is a SMALL BUG-FIX train of ONE PR (#1830: BUG-1225, a reopened drawing loads its own CE record, switch ON by default). Plan items stay paused until Tim lifts the pause. It sits on top of the C-73 branch (installed on Tim's PC since 27 Oct 19:40), and the previous chain (chain_c73.ps1) has ended, so it may start at once; it still waits if a chain_c73 process is found, because only one dotnet may run at a time on this PC.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c73.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c74.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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
Log 'chain start: C-74 (Civil + Manager, one bug-fix PR #1830, BUG-1225 reopened drawing loads its own record); nothing is installed by this chain.'

# The previous chain has ended; if a chain_c73 process is somehow still running, wait (up to 8 hours): one dotnet at a time on this PC.
$w = 0
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c73\.ps1' -and $_.Name -match 'pwsh' }) {
  if ($w -eq 0) { Log 'chain_c73 is still running: waiting for it to finish' }
  if (Stopped) { exit }
  Start-Sleep 60; $w++
  if ($w -gt 480) { Log 'chain_c73 still running after 8 hours: chain stops for the desk'; exit }
}

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C74_ASSEMBLY_REPORT_2026-10-28.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C74_FINALIZER_REPORT_2026-10-28.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c74_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-74 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c74_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-74 finalizer report: chain stops before payload 110'; exit }
if (-not (IsGo $cFin)) { Log 'C-74 finalizer verdict is not GO: no payload 110; the desk reads the report'; exit }
# The payload needs the installed line to be Civil 3.0.83 (C-73). Wait (poll every 5 minutes, up to 8 hours) if it is not.
$w = 0
while (-not ((InstalledCivil).StartsWith('3.0.83'))) {
  if ($w -eq 0) { Log ('installed Civil reads [' + (InstalledCivil) + '], not 3.0.83: payload 110 waits for the C-73 line') }
  if (Stopped) { exit }
  Start-Sleep 300; $w++
  if ($w -gt 96) { Log 'installed Civil still not 3.0.83 after 8 hours: chain stops before payload 110; the desk decides'; exit }
}
if (-not (DiskOk 'payload 110')) { exit }
Log 'C-74 finalizer verdict GO and C-73 installed: building payload 110 (candidate c1070). Nothing is installed by this chain.'
RunJob 'payload110_c74_job.txt' 'sonnet'
Log 'chain complete'
