# Desk 22 Oct 2026: brief writer (Sonnet, Team) -> Codex V5, V6, V7 one after another (each with retry). Report globs match the look ids.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_codex_v5.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\codex_brief_v5_job.txt" -Model sonnet
Log "$out"
$m = [regex]::Match("$out", 'pid (\d+)')
if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
Log 'brief writer finished'
foreach ($n in 5, 6, 7) {
  if (-not (Test-Path "C:\Lisp Files\_CODEX_RUNNER\verifyV${n}_c58_full.txt")) { Log "no brief V${n} - skipped"; continue }
  if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line "verifyV${n}_c58|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6" -ReportGlob "CODEX_VERIFY_V${n}_*" -Tries 2
  Log "V${n} launcher finished"
}
