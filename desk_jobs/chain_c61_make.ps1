# Desk 23 Oct 2026: Sonnet applies the Opus review fixes to the Codex draft PRs, Sonnet writes the C-61 + S-42 train files, then chain_c61_s42.ps1 (assembler -> finalizer -> payload for each; never installs).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c61_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'fix_round_23oct_job.txt' 'sonnet'
if (-not (Test-Path 'C:\CE_PLAN\areas\release-v3-colleagues-FIX_ROUND_23OCT_REPORT.md')) { Log 'no fix-round report: stop'; exit }
RunJob 'make_c61_s42_files_job.txt' 'sonnet'
foreach ($f in 'train_c61_assembler_job.txt', 'train_c61_finalizer_job.txt', 'payload93_c61_job.txt', 'train_s42_assembler_job.txt', 'train_s42_finalizer_job.txt', 'payload94_s42_job.txt', 'chain_c61_s42.ps1', 'scripts\desk_install_c61.ps1', 'scripts\desk_install_s42.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\chain_c61_s42.ps1"
Log 'chain_c61_s42 finished'
