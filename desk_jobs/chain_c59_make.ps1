# Desk 22 Oct 2026: Sonnet writes the C-59 + S-41 train files, then chain_c59_s41.ps1 starts (never installs).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c59_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\make_c59_s41_files_job.txt" -Model sonnet
Log "$out"
$m = [regex]::Match("$out", 'pid (\d+)')
if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
Log 'file writer finished'
foreach ($f in 'train_c59_assembler_job.txt', 'train_c59_finalizer_job.txt', 'payload90_c59_job.txt', 'train_s41_assembler_job.txt', 'train_s41_finalizer_job.txt', 'payload91_s41_job.txt', 'chain_c59_s41.ps1', 'scripts\desk_install_c59.ps1', 'scripts\desk_install_s41.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\chain_c59_s41.ps1"
Log 'chain_c59_s41 finished'
