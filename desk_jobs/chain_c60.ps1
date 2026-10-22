# Desk 22 Oct 2026: C-60 (Civil ONLY) assembler (Sonnet) -> finalizer (Opus) -> payload 92 (Sonnet) if the finalizer says GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c60.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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
Log 'chain start: C-60 (Civil only). Nothing is installed by this chain.'

$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C60_ASSEMBLY_REPORT_2026-10-22.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C60_FINALIZER_REPORT_2026-10-22.md'
RunJob 'train_c60_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-60 assembly report: chain stops before the finalizer'; exit }
RunJob 'train_c60_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $cFin)) { Log 'no C-60 finalizer report: chain stops before payload 92'; exit }
if (-not (IsGo $cFin)) { Log 'C-60 finalizer verdict is not GO: no payload 92; the desk reads the report'; exit }
Log 'C-60 finalizer verdict GO: building payload 92 (candidate c1056). Nothing is installed by this chain.'
RunJob 'payload92_c60_job.txt' 'sonnet'
Log 'chain complete'
