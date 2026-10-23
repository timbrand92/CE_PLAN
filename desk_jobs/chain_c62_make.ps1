# Desk 23 Oct 2026: Sonnet applies the Opus review fixes to the fix-wave-2 PRs, Sonnet writes the C-62 train files, then chain_c62.ps1 (assembler -> finalizer -> payload; never installs).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c62_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'fix_round_c62_job.txt' 'sonnet'
if (-not (Test-Path 'C:\CE_PLAN\areas\release-v3-colleagues-FIX_ROUND_C62_REPORT.md')) { Log 'no fix-round report: stop'; exit }
RunJob 'make_c62_files_job.txt' 'sonnet'
foreach ($f in 'train_c62_assembler_job.txt', 'train_c62_finalizer_job.txt', 'payload95_c62_job.txt', 'chain_c62.ps1', 'scripts\desk_install_c62.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\chain_c62.ps1"
Log 'chain_c62 finished'
