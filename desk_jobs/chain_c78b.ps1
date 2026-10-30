# Desk 29 Oct 2026: C-78 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 114 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag. NOT STARTED by the job that wrote it: the desk starts it after it has promoted PRs in the C-78 list (cut: PR-ready by Sun 1 Nov 12:00).
# C-78 is the rest of the pilot-critical list (B-016, B-018, B-021, B-022, B-026) plus any carry-overs from C-77 (B-009, B-010, B-011, B-013, B-014, B-017, B-020, B-033, B-034, B-012 or a skipped or reverted C-77 PR), every one only if its status line in C:\CE_PLAN\areas\TRAIN_C78_PR_LIST_2026-10-29.md reads PROMOTED. At the time of writing NO PR was promoted: if none is when the assembler starts, its report says NOTHING TO ASSEMBLE and this chain stops before the finalizer. Manager code changes only if a promoted PR touches it. It sits on top of the C-77 branch claude/rel-20261030a (C-77 is installed on Tim's PC the evening of Fri 30 Oct). Planned install of C-78: Mon 2 Nov after 17:30 (chain_install_c78.ps1).
# At most two top-level dotnet build or test commands run on this PC at once and a train job gets a slot first; the jobs count the slots themselves (dotnet.exe command lines only, never claude, pwsh or cmd), so the fix chains (chain_fix_*) are NOT waited for. The chain WAITS (up to 8 hours) only while another TRAIN or payload chain is found running (an older or newer chain_cNN, a bug chain, an fb team chain, an apply chain or a payload chain); chain_install_* chains run no dotnet and are not waited for.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_c77.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used. If the Team login is expired the job dies at once with a login line in its log: the chain logs that, and the desk runs the same job text as a Max Agent instead (headless claude -p on the Max config fails OAuth).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c78.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $job = "$d\$file"
  $lg = [IO.Path]::ChangeExtension($job, '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting ${file} (${model})"
  $pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
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
  return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.ProcessId -ne $PID -and $_.CommandLine -match 'chain_c(?!78)\d+\w*\.ps1|chain_bug\w+\.ps1|chain_fb_team\d*\.ps1|chain_apply_\w+\.ps1|chain_payload\w+\.ps1' })
}

if (Stopped) { exit }
Log 'chain start: C-78 (Civil + Manager, the PRs the C-78 PR list promotes; NOTHING TO ASSEMBLE stops the chain before the finalizer); nothing is installed by this chain.'

# If another train or payload chain is still running, wait (up to 8 hours).
$w = 0
while ((OtherDotnetChains).Count -gt 0) {
  if ($w -eq 0) { Log 'another dotnet-running train or payload chain is still running: waiting for it to finish' }
  if (Stopped) { exit }
  Start-Sleep 60; $w++
  if ($w -gt 480) { Log 'another dotnet-running chain still running after 8 hours: chain stops for the desk'; exit }
}

# The base: the C-77 branch must carry its version commit (the C-77 payload builder pushes it early). Wait (poll every 2 minutes, up to 8 hours) until the top commit says so; if gh cannot read it five times in a row, go on (the assembler checks the tip itself).
$w = 0; $empty = 0
while ($true) {
  $msg = TipMessage 'claude/rel-20261030a'
  if ($msg -match 'Version: Civil 3\.0\.87 / Manager 1\.1\.87 \(C-77\)') { break }
  if ($msg -eq '') { $empty++; if ($empty -ge 5) { Log 'cannot read the C-77 branch tip with gh: going on, the assembler checks the tip itself'; break } } else { $empty = 0 }
  if ($w -eq 0) { Log 'waiting for the C-77 version commit on claude/rel-20261030a' }
  if (Stopped) { exit }
  Start-Sleep 120; $w++
  if ($w -gt 240) { Log 'C-77 version commit not on the branch after 8 hours: chain stops for the desk'; exit }
}

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C78_ASSEMBLY_REPORT_2026-10-29.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C78_FINALIZER_REPORT_2026-10-29.md'
# SECOND C-78 CHAIN (30 Oct 15:55, CE 01): CE 00 ruled that C-78 builds tonight but is NOT installed before the C-77 FULL set and the Codex block end (about 01:15 to 02:45 Sat), and CE 02's AutoCAD is busy until then, so payload 114 (whose last steps need AutoCAD closed) waits for the flag desk_jobs\C78_PAYLOAD_GO.flag, which CE 01 writes about 40 minutes before CE 02's 'full set ALL DONE and Codex block done' (or CE 00's word). chain_install_c78 is NOT armed.
if (Stopped) { exit }
Log 'chain RESUMED (second C-78 chain): waiting for the assembler job (cmd pid 4344) to end'
$w = 0
while (Get-Process -Id 4344 -ErrorAction SilentlyContinue) { if (Stopped) { exit }; Start-Sleep 30; $w++; if ($w -gt 960) { Log 'assembler still running after 8 hours: chain stops for the desk'; exit } }
Log 'finished train_c78_assembler_job.txt (seen by the second chain)'
if (-not (Test-Path $cAsm)) { Log 'no C-78 assembly report: chain stops before the finalizer'; exit }
$asmHead = (Get-Content $cAsm -TotalCount 12 -ErrorAction SilentlyContinue) -join ' '
if ($asmHead -match 'NOTHING TO ASSEMBLE') { Log 'C-78 assembly report says NOTHING TO ASSEMBLE: chain stops before the finalizer; the desk promotes PRs in the C-78 list and starts the chain again'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c78_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-78 finalizer report: chain stops before payload 114'; exit }
if (-not (IsGo $cFin)) { Log 'C-78 finalizer verdict is not GO: no payload 114; the desk reads the report'; exit }
$w = 0
while (-not (Test-Path "$d\C78_PAYLOAD_GO.flag")) { if ($w -eq 0) { Log 'C-78 finalizer GO: payload 114 waits for desk_jobs\C78_PAYLOAD_GO.flag (written by CE 01 about 40 minutes before the C-77 full set and the Codex block end; no install before then)' }; if (Stopped) { exit }; Start-Sleep 120; $w++; if ($w -gt 600) { Log 'no C78_PAYLOAD_GO.flag after 20 hours: chain stops for the desk'; exit } }
Log 'C78_PAYLOAD_GO.flag found: payload 114 may start'
# The payload needs the installed line to be Civil 3.0.87 (C-77). Wait (poll every 5 minutes, up to 8 hours) if it is not.
$w = 0
while (-not ((InstalledCivil).StartsWith('3.0.87'))) {
  if ($w -eq 0) { Log ('installed Civil reads [' + (InstalledCivil) + '], not 3.0.87: payload 114 waits for the C-77 line') }
  if (Stopped) { exit }
  Start-Sleep 300; $w++
  if ($w -gt 96) { Log 'installed Civil still not 3.0.87 after 8 hours: chain stops before payload 114; the desk decides'; exit }
}
if (-not (DiskOk 'payload 114')) { exit }
Log 'C-78 finalizer verdict GO and C-77 installed: building payload 114 (candidate c1074). Nothing is installed by this chain.'
RunJob 'payload114_c78_job.txt' 'sonnet'
Log 'chain complete'
