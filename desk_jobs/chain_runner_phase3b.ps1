# Desk 24 Oct 2026 03:20: replaces chain_runner_phase3.ps1 (stopped): waits for the phase 3 batch 1 worker that is already running (tester_run53), then runs the hardening job (tester_run56), then phase 3 batches 2 and 3. One AutoCAD driver job at a time. Stop flag STOP_CHAIN.flag; nothing new after 13:45 (Team resets 14:00).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_runner_phase3b.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($name, $tag) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  if ([DateTime]::Now -ge [DateTime]'2026-10-24 13:45') { Log "past 13:45: stopping before $tag"; exit }
  $job = "$d\$name.txt"; $lg = "$d\$name.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting $tag"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished $tag"
}
Log 'waiting for the running tester_run53 worker to end'
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'tester_run53' -and $_.Name -match 'cmd|claude' }) { Start-Sleep 60 }
Log 'tester_run53 worker gone'
RunJob 'tester_run56_runner_harden' 'harden R01-R10'
RunJob 'tester_run54_runner_phase3_b2' 'phase 3 batch 2'
RunJob 'tester_run55_runner_phase3_b3' 'phase 3 batch 3'
Log 'chain complete'