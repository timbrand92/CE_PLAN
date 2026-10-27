# Desk 27 Oct 2026: Team (Sonnet) writes the C-73 train job files now (files only), then chain_c73.ps1 runs (assembler -> finalizer -> payload; never installs) AFTER chain_c72.ps1 has ended: one dotnet at a time. chain_install_c73.ps1 is started separately by the desk after a GO. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c73_make.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$job = "$d\make_c73_files_job.txt"; $lg = "$d\make_c73_files_job.log"
$cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log 'starting make_c73_files_job'
Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
Log 'finished make_c73_files_job'
foreach ($f in 'train_c73_assembler_job.txt', 'train_c73_finalizer_job.txt', 'payload109_c73_job.txt', 'chain_c73.ps1', 'chain_install_c73.ps1', 'scripts\desk_install_c73.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop for the desk"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c72\.ps1' -and $_.Name -match 'pwsh' }) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
Log 'chain_c72 ended: starting chain_c73'
& pwsh -NoProfile -File "$d\chain_c73.ps1"
Log 'chain_c73 finished'
