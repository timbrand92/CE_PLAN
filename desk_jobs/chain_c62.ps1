# Desk 23 Oct 2026: C-62 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 95 (Sonnet) if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c62.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
function IsGo($fin) {
  if (-not (Test-Path $fin)) { return $false }
  $txt = Get-Content $fin -Raw
  return ($txt -match '\*\*GO at `[0-9a-f]{40}`' -and $txt -notmatch 'NO-GO at')
}
function Stopped() { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $true } return $false }

if (Stopped) { exit }
Log 'chain start: C-62 (Civil + Manager); nothing is installed by this chain.'

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C62_ASSEMBLY_REPORT_2026-10-23.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C62_FINALIZER_REPORT_2026-10-23.md'
RunJob 'train_c62_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-62 assembly report: chain stops before the finalizer'; exit }
RunJob 'train_c62_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-62 finalizer report: chain stops before payload 95'; exit }
if (-not (IsGo $cFin)) { Log 'C-62 finalizer verdict is not GO: no payload 95; the desk reads the report'; exit }
Log 'C-62 finalizer verdict GO: building payload 95 (candidate c1058). Nothing is installed by this chain.'
RunJob 'payload95_c62_job.txt' 'sonnet'
Log 'chain complete'
