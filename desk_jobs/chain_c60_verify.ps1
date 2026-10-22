# Desk 22 Oct 2026: Sonnet writes robot run 47 + Codex V10 briefs; wait for the clean C-60 payload report and an idle Codex; install C-60 (desk_install_c60.ps1); robot pass 26 (tester_run47); Codex V10. Stop flags STOP_CHAIN.flag / STOP_CODEX.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c60_verify.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
RunJob 'briefs_v10_job.txt' 'sonnet'
foreach ($f in 'C:\CE_PLAN\desk_jobs\tester_run47.txt', 'C:\Lisp Files\_CODEX_RUNNER\verifyV10_c60_full.txt') { if (-not (Test-Path $f)) { Log "missing ${f} - stop"; exit } }
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1056_REPORT.md'
$w = 0
while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 60; $w++; if ($w -gt 180) { Log 'no payload report in 3 h'; exit } }
Start-Sleep 90
while (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'payload92' }) { Start-Sleep 30 }
$txt = Get-Content $rep -Raw
if ($txt -notmatch 'verified 828, bad 0, extra 0' -or $txt -notmatch 'verified 75, bad 0, extra 0') { Log 'payload report not clean: stopping for the desk'; exit }
# wait until Codex (V9) is idle and AutoCAD is gone
$w = 0
while ($true) {
  $q = Get-Content 'C:\Lisp Files\_CODEX_RUNNER\queue.log' -Tail 6 -ErrorAction SilentlyContinue
  $last = ($q | Where-Object { $_ -match ' START | END ' } | Select-Object -Last 1)
  $codexBusy = ($last -match ' START ')
  $retry = Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'launch_codex_retry' -and $_.Name -match 'pwsh' }
  $acad = Get-Process acad -ErrorAction SilentlyContinue
  if (-not $codexBusy -and -not $retry -and -not $acad) { break }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Start-Sleep 120; $w++; if ($w -gt 180) { Log 'Codex/AutoCAD busy for 6 h: stop'; exit }
}
Log 'payload clean, Codex idle: installing C-60'
$out = & pwsh -NoProfile -File "$d\scripts\desk_install_c60.ps1" 2>&1 | Out-String
Log ($out.Trim().Split("`n")[-1])
if ($out -notmatch 'INSTALL VERIFIED') { Log 'install not verified: stopping for the desk'; exit }
RunJob 'tester_run47.txt' 'sonnet'
Start-Sleep 60
if (Test-Path "$d\STOP_CODEX.flag") { Log 'STOP flag'; exit }
& pwsh -NoProfile -File "$d\launch_codex_retry.ps1" -Line 'verifyV10_c60|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6' -ReportGlob 'CODEX_VERIFY_V10_*' -Tries 4
Log 'V10 launcher finished'
