# Desk 22 Oct 2026 (Tim: "we need to resolve this testing business"): Opus designs the deterministic test pack, then Sonnet builds driver v3 phase 1 (this phase opens AutoCAD, so it runs through a tester_run job name that the Codex gate respects). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_testing_rebuild.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'testing_rebuild_design_job.txt' 'opus'
if (-not (Test-Path 'C:\CE_PLAN\areas\TESTING_REBUILD_SPEC_2026-10-22.md')) { Log 'no spec: stop'; exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'tester_run48_driver_v3_phase1.txt' 'sonnet'
Log 'chain complete'
