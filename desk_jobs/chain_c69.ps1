# Desk 26 Oct 2026: C-69 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 104 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_fb_team.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c69.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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

if (Stopped) { exit }
Log 'chain start: C-69 (Civil + Manager); nothing is installed by this chain.'

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C69_ASSEMBLY_REPORT_2026-10-26.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C69_FINALIZER_REPORT_2026-10-26.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c69_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-69 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c69_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-69 finalizer report: chain stops before payload 104'; exit }
if (-not (IsGo $cFin)) { Log 'C-69 finalizer verdict is not GO: no payload 104; the desk reads the report'; exit }
if (-not (DiskOk 'payload 104')) { exit }
Log 'C-69 finalizer verdict GO: building payload 104 (candidate c1065). Nothing is installed by this chain.'
RunJob 'payload104_c69_job.txt' 'sonnet'
Log 'chain complete'
