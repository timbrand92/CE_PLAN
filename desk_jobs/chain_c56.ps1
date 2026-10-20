# Desk 20 Oct 2026: C-56 assembler (Sonnet) -> C-56 finalizer (Opus) one after the other on the Team account, then stops; the desk reads the verdicts.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c56.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
# no fixer: six reviewed bug-fix PRs go straight to the assembler; the finalizer reviews it fully
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'train_c56_assembler_job.txt' 'sonnet'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$rep = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C56_ASSEMBLY_REPORT_2026-10-20.md'
if (-not (Test-Path $rep)) { Log 'no assembly report: chain stops before the finalizer'; exit }
RunJob 'train_c56_finalizer_job.txt' 'opus'
Log 'chain complete'