# Desk 22 Oct 2026: Codex V6 then V7 again on Civil 3.0.69 (C-59) with the corrected focus rule. Report globs match the look ids.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_codex_v67b.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($n in 6, 7) {
  if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line "verifyV${n}_c58|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6" -ReportGlob "CODEX_VERIFY_V${n}_*" -Tries 2
  Log "V${n} launcher finished"
}
