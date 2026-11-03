# Desk 18 Oct 2026: runs the Codex plan in C:\Lisp Files\_CODEX_RUNNER\QUEUE_18OCT_PLAN.md.
# 1) bj32 (window builder, no AutoCAD) now; 2) waits for the desk gate (no acad/accoreconsole on two checks, ACAD_LOCK free or expired,
# no settings_guard.json, no other Codex run, no robot job); 3) then the look jobs one at a time. Stops if STOP_CODEX.flag exists.
$d = 'C:\Lisp Files\_CODEX_RUNNER'
$bash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path $bash)) { $bash = (Get-Command bash.exe -ErrorAction SilentlyContinue | Select-Object -First 1).Source }
function Log($t) { Add-Content 'C:\CE_PLAN\desk_jobs\codex_queue_18oct.log' ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function GateOk {
  if (Get-Process acad, accoreconsole -ErrorAction SilentlyContinue) { return $false }
  if (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run|evidence_job' }) { return $false }
  if (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') { return $false }
  $lock = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lock) { try { $j = Get-Content $lock -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { return $false } } catch { return $false } }
  $q = Get-Content (Join-Path $d 'queue.log') -Tail 4 -ErrorAction SilentlyContinue
  $last = ($q | Where-Object { $_ -match ' START | END ' } | Select-Object -Last 1)
  if ($last -match ' START ') { return $false }
  return $true
}
if (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag') { Log 'STOP flag: not starting'; exit }
Log 'starting bj32 (window builder)'
& $bash -lc 'cd "/c/Lisp Files/_CODEX_RUNNER" && MAXC=1 bash queue3.sh "bj32_cesettings_switch_rows_civil|C:/Lisp Files/_CODEX_RUNNER|gpt-6.1-sol|low|90|5"' *> 'C:\CE_PLAN\desk_jobs\codex_queue_bj32.out'
Log 'bj32 queue call returned'
$jobs = @(
  'lookL1_civil_sheets|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6-luna|low|90|2',
  'lookL1b_catchment_sol|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|2',
  'lookL2_structural|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|4',
  'lookL3_windows_pictures|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|5',
  'lookL4_mouse|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|5',
  'lookL5_cursor_ribbon|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|5'
)
foreach ($j in $jobs) {
  if (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag') { Log 'STOP flag: ending'; exit }
  $n = 0
  while (-not (GateOk)) { Start-Sleep 120; $n++; if ($n -gt 360) { Log ("gate never opened for " + $j.Split('|')[0]); break } }
  Start-Sleep 125
  if (-not (GateOk)) { Log ("gate closed again before " + $j.Split('|')[0] + ': waiting'); while (-not (GateOk)) { Start-Sleep 120 } }
  Log ('starting ' + $j.Split('|')[0])
  & $bash -lc ('cd "/c/Lisp Files/_CODEX_RUNNER" && MAXC=1 bash queue3.sh "' + $j + '"') *>> 'C:\CE_PLAN\desk_jobs\codex_queue_looks.out'
  Log ('finished ' + $j.Split('|')[0])
}
Log 'queue complete'
