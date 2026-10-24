# Desk 24 Oct 2026 11:55: replaces chain_runner_phase3b.ps1: the R01-R10 hardening job died at the Team 5-hour wall (11:00), so: wait for the running tester_run54 worker, then run the hardening job (tester_run56) again, then batch 3 (tester_run55). One AutoCAD driver job at a time. Stop flag STOP_CHAIN.flag; nothing new after 13:45 except resumption after the Team reset at 14:00 (the check below allows jobs from 14:05).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_runner_phase3c.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($name, $tag) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $job = "$d\$name.txt"; $lg = "$d\$name.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting $tag"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished $tag"
}
Log 'waiting for the running tester_run54 worker to end'
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'tester_run54' -and $_.Name -match 'cmd|claude' }) { Start-Sleep 60 }
Log 'tester_run54 worker gone'
RunJob 'tester_run56_runner_harden' 'harden R01-R10 (second try)'
RunJob 'tester_run55_runner_phase3_b3' 'phase 3 batch 3'
Log 'chain complete'