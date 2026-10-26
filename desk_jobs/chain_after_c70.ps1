# Desk 26 Oct 2026 (Tim: smaller regular updates): after chain_c70 ends, run S-45 (Structural) then the ArchUnitNET adoption, one Team job at a time (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_after_c70.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $job = "$d\$file"
  $lg = [IO.Path]::ChangeExtension($job, '.log')
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting ${file} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished ${file}"
}
Log 'waiting for the S-45 job files to be written, then for chain_c70 to end'
# 1. the S-45 job files can be written at once (files only, no build)
RunJob 'make_s45_files_job.txt' 'sonnet'
foreach ($f in 'train_s45_assembler_job.txt', 'train_s45_finalizer_job.txt', 'payload106_s45_job.txt', 'chain_s45.ps1', 'chain_install_s45.ps1', 'scripts\desk_install_s45.ps1') { if (-not (Test-Path "$d\$f")) { Log "missing ${f} - stop for the desk"; exit } }
# 2. wait for the Civil/Manager diagnostic chain (assembler, finalizer, payload) to finish
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c70\.ps1' -and $_.Name -match 'pwsh' }) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 60 }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
Log 'chain_c70 ended: starting chain_s45'
& pwsh -NoProfile -File "$d\chain_s45.ps1"
Log 'chain_s45 finished'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'team_archunit_adopt.txt' 'sonnet'
Log 'chain_after_c70 finished'
