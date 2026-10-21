# Desk 21 Oct 2026: waits for payload 87 (C-57 candidate c1053), installs it if the report is clean, then starts robot pass 23 (tester_run45). Saves desk turns (Max). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_install_c58.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1054_REPORT.md'
$w = 0
while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 60; $w++; if ($w -gt 180) { Log 'no payload report in 3 h'; exit } }
Start-Sleep 90
while (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'payload88' }) { Start-Sleep 30 }
$txt = Get-Content $rep -Raw
if ($txt -notmatch 'verified 828, bad 0, extra 0' -or $txt -notmatch 'verified 75, bad 0, extra 0') { Log 'payload report not clean: stopping for the desk'; exit }
Log 'payload report clean: installing'
$out = & pwsh -NoProfile -File "$d\scripts\desk_install_c58.ps1" 2>&1 | Out-String
Log ($out.Trim().Split("`n")[-1])
if ($out -notmatch 'INSTALL VERIFIED') { Log 'install not verified: stopping for the desk'; exit }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
$o = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\tester_run45.txt" -Model sonnet
Log "$o"
Log 'chain complete'