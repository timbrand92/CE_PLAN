# Desk 22 Oct 2026: Sonnet writes the S-40 job files, then chain_s40.ps1 (assembler -> finalizer -> payload; never installs) starts.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_s40_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\make_s40_files_job.txt" -Model sonnet
Log "$out"
$m = [regex]::Match("$out", 'pid (\d+)')
if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
Log 'file writer finished'
foreach ($f in 'train_s40_assembler_job.txt', 'train_s40_finalizer_job.txt', 'chain_s40.ps1', 'payload89_s40_job.txt', 'scripts\desk_install_s40.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\chain_s40.ps1"
Log 'chain_s40 finished'
