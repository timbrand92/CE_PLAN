# Desk 22 Oct 2026: Sonnet writes robot run 46 + Codex V8/V9 briefs -> robot pass 25 (tester_run46) -> Codex V8 (Civil) -> Codex V9 (Structural). One AutoCAD session at a time. Stop flags STOP_CHAIN.flag / STOP_CODEX.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_verify_22.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'briefs_v8_job.txt' 'sonnet'
foreach ($f in 'C:\CE_PLAN\desk_jobs\tester_run46.txt', 'C:\Lisp Files\_CODEX_RUNNER\verifyV8_c59_full.txt', 'C:\Lisp Files\_CODEX_RUNNER\verifyV9_s41_full.txt') { if (-not (Test-Path $f)) { Log "missing ${f} - stop"; exit } }
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
# the Structural install must be done before the robot pass: wait for the S-41 install marker
$w = 0
while (-not (Select-String -Path 'C:\ce_rc_scratch\install_s41_desk.log' -Pattern 'INSTALL VERIFIED' -Quiet -ErrorAction SilentlyContinue)) { Start-Sleep 60; $w++; if ($w -gt 120) { Log 'S-41 not installed in 2 h - robot pass skipped'; break } }
RunJob 'tester_run46.txt' 'sonnet'
Start-Sleep 60
foreach ($n in 8, 9) {
  if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
  $name = if ($n -eq 8) { 'verifyV8_c59' } else { 'verifyV9_s41' }
  & pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line "$name|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6" -ReportGlob "CODEX_VERIFY_V${n}_*" -Tries 2
  Log "V${n} launcher finished"
}
