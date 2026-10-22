# Desk 22 Oct 2026: Sonnet fixes #1517, Sonnet writes the C-60 train files, then chain_c60.ps1 (assembler -> finalizer -> payload; never installs).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c60_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'fix_1517_job.txt' 'sonnet'
RunJob 'make_c60_files_job.txt' 'sonnet'
foreach ($f in 'train_c60_assembler_job.txt', 'train_c60_finalizer_job.txt', 'payload92_c60_job.txt', 'chain_c60.ps1', 'scripts\desk_install_c60.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\chain_c60.ps1"
Log 'chain_c60 finished'
