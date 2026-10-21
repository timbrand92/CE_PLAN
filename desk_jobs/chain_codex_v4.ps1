# Desk 22 Oct 2026: brief writer (Sonnet, Team) -> Codex verify V4 on Civil 3.0.68 with automatic retry. Report glob matches the look id V4.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_codex_v4.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\codex_brief_v4_job.txt" -Model sonnet
Log "$out"
$m = [regex]::Match("$out", 'pid (\d+)')
if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
Log 'brief writer finished'
if (-not (Test-Path 'C:\Lisp Files\_CODEX_RUNNER\verifyV4_c58_full.txt')) { Log 'no brief: stop'; exit }
if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyV4_c58|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6' -ReportGlob 'CODEX_VERIFY_V4_*' -Tries 3
Log 'codex retry launcher finished'
