# Desk 20 Oct 2026: S-39 (Structural) assembler (Sonnet) -> finalizer (Opus) on the Team account, then stops.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_s39.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'train_s39_assembler_job.txt' 'sonnet'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$rep = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S39_ASSEMBLY_REPORT_2026-10-20.md'
if (-not (Test-Path $rep)) { Log 'no assembly report: chain stops before the finalizer'; exit }
RunJob 'train_s39_finalizer_job.txt' 'opus'
Log 'chain complete'
