# Desk 25 Oct 2026: C-67 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 102 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
# Each job is run through cmd.exe with Start-Process -Wait, using the working form of chain_fb_team.ps1: the command line sets the Team config folder and adds the npm folder to PATH itself, so claude is found and the Team account is used.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c67.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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
function DiskOk($next) {
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
  $w = 0; while ($free -lt 10) { if ($w -eq 0) { Log "C: only ${free} GB free: waiting before ${next}" }; Start-Sleep 300; $w++; $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1); if ($w -gt 24) { Log "C: still under 10 GB after 2 hours: chain stops before ${next}"; return $false } }
  return $true
}

if (Stopped) { exit }
Log 'chain start: C-67 (Civil + Manager); nothing is installed by this chain.'

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C67_ASSEMBLY_REPORT_2026-10-25.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C67_FINALIZER_REPORT_2026-10-25.md'
if (-not (DiskOk 'the assembler')) { exit }
RunJob 'train_c67_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-67 assembly report: chain stops before the finalizer'; exit }
if (-not (DiskOk 'the finalizer')) { exit }
RunJob 'train_c67_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-67 finalizer report: chain stops before payload 102'; exit }
if (-not (IsGo $cFin)) { Log 'C-67 finalizer verdict is not GO: no payload 102; the desk reads the report'; exit }
if (-not (DiskOk 'payload 102')) { exit }
Log 'C-67 finalizer verdict GO: building payload 102 (candidate c1063). Nothing is installed by this chain.'
RunJob 'payload102_c67_job.txt' 'sonnet'
Log 'chain complete'
