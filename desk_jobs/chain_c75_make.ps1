# Desk 28 Oct 2026: Team (Sonnet) writes the C-75 train job files now (files only), then chain_c75.ps1 runs (assembler -> finalizer -> payload; never installs). chain_install_c75.ps1 is started separately by the desk after a GO. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c75_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$job = "$d\make_c75_files_job.txt"; $lg = "$d\make_c75_files_job.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting make_c75_files_job'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished make_c75_files_job'
foreach ($f in 'train_c75_assembler_job.txt', 'train_c75_finalizer_job.txt', 'payload111_c75_job.txt', 'chain_c75.ps1', 'chain_install_c75.ps1', 'scripts\desk_install_c75.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop for the desk"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
Log 'job files written: starting chain_c75'
& pwsh -NoProfile -File "$d\chain_c75.ps1"
Log 'chain_c75 finished'

