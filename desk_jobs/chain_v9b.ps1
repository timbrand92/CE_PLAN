# Desk 22 Oct 2026: after chain_c60_verify has finished, Sonnet writes verifyV9b_s41 (proven typed routes) and Codex runs it (4 tries). Stop flag STOP_CODEX.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_v9b.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\briefs_v9b_job.txt" -Model sonnet
Log "$out"
$m = [regex]::Match("$out", 'pid (\d+)')
if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
Log 'brief writer finished'
if (-not (Test-Path 'C:\Lisp Files\_CODEX_RUNNER\verifyV9b_s41_full.txt')) { Log 'no brief: stop'; exit }
# wait for the C-60 verification chain to finish (one AutoCAD session at a time)
$w = 0
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_c60_verify' -and $_.Name -match 'pwsh' }) { Start-Sleep 120; $w++; if ($w -gt 240) { Log 'C-60 chain still running after 8 h: stop'; exit } }
if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyV9b_s41|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6' -ReportGlob 'CODEX_VERIFY_V9B_*' -Tries 4
Log 'V9b launcher finished'
