# Desk 22 Oct 2026: S-40 (Structural) assembler (Sonnet) -> finalizer (Opus) -> payload 89 builder (Sonnet) if the finalizer says GO, on the Team account, then stops. Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_s40.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'train_s40_assembler_job.txt' 'sonnet'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$rep = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S40_ASSEMBLY_REPORT_2026-10-22.md'
if (-not (Test-Path $rep)) { Log 'no assembly report: chain stops before the finalizer'; exit }
RunJob 'train_s40_finalizer_job.txt' 'opus'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$fin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S40_FINALIZER_REPORT_2026-10-22.md'
if (-not (Test-Path $fin)) { Log 'no finalizer report: chain stops before the payload builder'; exit }
$txt = Get-Content $fin -Raw
if ($txt -notmatch '\*\*GO at `[0-9a-f]{40}`' -or $txt -match 'NO-GO at') { Log 'finalizer verdict is not GO: stopping for the desk'; exit }
Log 'finalizer verdict GO: building payload 89 (candidate s1038). Nothing is installed by this chain.'
RunJob 'payload89_s40_job.txt' 'sonnet'
Log 'chain complete'
