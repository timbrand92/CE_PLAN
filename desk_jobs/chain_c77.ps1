# Desk 29 Oct 2026: C-77 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 113 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag. NOT STARTED by the job that wrote it: the desk starts it after the Fri 30 Oct 06:00 cut.
# C-77 is the BACKLOG TRAIN of twelve draft PRs (#1840 B-038 docs, #1847 B-008 Tidy labels ON, #1846 B-046 pipe object for every login, #1844 B-035 colleague starting settings, #1845 B-007 raingarden label, #1838 B-005 level never flatter than the grade, #1839 B-006 Recent buttons, #1841 B-042 minimum falls, #1848 B-012 cover to the outside of the pipe, #1842 B-044 + #1843 B-045 + #1849 B-048 pit size, lid class and garages), plus any LATE ADDITIONS the PR list names (B-009, B-010, B-011, B-013, B-014, B-017, B-020, B-033, B-034). Manager code is NOT changed (1.1.87 is a re-stamp). It sits on top of the C-76 branch claude/rel-20261029a (C-76 is installed on Tim's PC the evening of 29 Oct). The jobs read their PR numbers from C:\CE_PLAN\areas\TRAIN_C77_PR_LIST_2026-10-29.md. Planned install of C-77: Fri 30 Oct evening (chain_install_c77.ps1).
# At most two top-level dotnet build or test commands run on this PC at once and a train job gets a slot first; the jobs count the slots themselves (dotnet.exe command lines only, never claude, pwsh or cmd), so the fix chains (chain_fix_*) are NOT waited for. The chain WAITS (up to 8 hours) only while another TRAIN or payload chain is found running (an older or newer chain_cNN, a bug chain, an fb team chain, an apply chain or a payload chain); chain_install_* chains run no dotnet and are not waited for.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c76.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used. If the Team login is expired the job dies at once with a login line in its log: the chain logs that, and the desk runs the same job text as a Max Agent instead (headless claude -p on the Max config fails OAuth).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c77.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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
# Read-only: the top commit message of a branch on GitHub (gh api), or an empty string when it cannot be read.
function TipMessage($branch) {
  $gh = 'C:\Program Files\GitHub CLI\gh.exe'
  if (-not (Test-Path $gh)) { return '' }
  try { $m = & $gh api ('repos/timbrand92/CE_ACAD_PLUGIN/commits/' + $branch) --jq '.commit.message' 2>$null; return (($m | Out-String).Trim()) } catch { return '' }
}
# Any other pwsh process that runs a dotnet-using TRAIN or payload chain (never this chain itself, never an install chain, never a fix chain).
function OtherDotnetChains() {
  return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.ProcessId -ne $PID -and $_.CommandLine -match 'chain_c(?!77|78)\d+\w*\.ps1|chain_bug\w+\.ps1|chain_fb_team\d*\.ps1|chain_apply_\w+\.ps1|chain_payload\w+\.ps1' })
}

if (Stopped) { exit }
Log 'chain start: C-77 (Civil + Manager, twelve backlog PRs #1840 #1847 #1846 #1844 #1845 #1838 #1839 #1841 #1848 #1842 #1843 #1849, plus any late additions in the PR list); nothing is installed by this chain.'

# If another train or payload chain is still running, wait (up to 8 hours).
$w = 0
while ((OtherDotnetChains).Count -gt 0) {
  if ($w -eq 0) { Log 'another dotnet-running train or payload chain is still running: waiting for it to finish' }
  if (Stopped) { exit }
  Start-Sleep 60; $w++
  if ($w -gt 480) { Log 'another dotnet-running chain still running after 8 hours: chain stops for the desk'; exit }
}

# The base: the C-76 branch must carry its version commit (the C-76 payload builder pushes it early). Wait (poll every 2 minutes, up to 8 hours) until the top commit says so; if gh cannot read it five times in a row, go on (the assembler checks the tip itself).
$w = 0; $empty = 0
while ($true) {
  $msg = TipMessage 'claude/rel-20261029a'
  if ($msg -match 'Version: Civil 3\.0\.86 / Manager 1\.1\.86 \(C-76\)') { break }
  if ($msg -eq '') { $empty++; if ($empty -ge 5) { Log 'cannot read the C-76 branch tip with gh: going on, the assembler checks the tip itself'; break } } else { $empty = 0 }
  if ($w -eq 0) { Log 'waiting for the C-76 version commit on claude/rel-20261029a' }
  if (Stopped) { exit }
  Start-Sleep 120; $w++
  if ($w -gt 240) { Log 'C-76 version commit not on the branch after 8 hours: chain stops for the desk'; exit }
}

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C77_ASSEMBLY_REPORT_2026-10-29.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C77_FINALIZER_REPORT_2026-10-29.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c77_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-77 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c77_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-77 finalizer report: chain stops before payload 113'; exit }
if (-not (IsGo $cFin)) { Log 'C-77 finalizer verdict is not GO: no payload 113; the desk reads the report'; exit }
# The payload needs the installed line to be Civil 3.0.86 (C-76). Wait (poll every 5 minutes, up to 8 hours) if it is not.
$w = 0
while (-not ((InstalledCivil).StartsWith('3.0.86'))) {
  if ($w -eq 0) { Log ('installed Civil reads [' + (InstalledCivil) + '], not 3.0.86: payload 113 waits for the C-76 line') }
  if (Stopped) { exit }
  Start-Sleep 300; $w++
  if ($w -gt 96) { Log 'installed Civil still not 3.0.86 after 8 hours: chain stops before payload 113; the desk decides'; exit }
}
if (-not (DiskOk 'payload 113')) { exit }
Log 'C-77 finalizer verdict GO and C-76 installed: building payload 113 (candidate c1073). Nothing is installed by this chain.'
RunJob 'payload113_c77_job.txt' 'sonnet'
Log 'chain complete'
