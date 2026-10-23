# Desk 20 Oct 2026: run ONE Codex AutoCAD job with automatic retry when Codex's native screen tools were unavailable ("NOT STARTED: Native computer APIs are disabled": seen twice, costs no usage). Usage: pwsh -File launch_codex_retry.ps1 -Line "name|folder|model|effort|maxpct|cost" [-ReportGlob "CODEX_VERIFY_V3*"] [-Tries 4]
param([Parameter(Mandatory=$true)][string]$Line, [string]$ReportGlob = 'CODEX_VERIFY_*', [int]$Tries = 4)
$d = 'C:\Lisp Files\_CODEX_RUNNER'
$bash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path $bash)) { $bash = (Get-Command bash.exe -ErrorAction SilentlyContinue | Select-Object -First 1).Source }
$name = $Line.Split('|')[0]
$logFile = "C:\CE_PLAN\desk_jobs\codex_retry_$name.log"
function Log($t) { Add-Content $logFile ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function CodexIdle { $q = Get-Content (Join-Path $d 'queue.log') -Tail 6 -ErrorAction SilentlyContinue; $last = ($q | Where-Object { $_ -match ' START | END ' } | Select-Object -Last 1); -not ($last -match ' START ') }
function Gate {
  if (-not (CodexIdle)) { return $false }
  if (Get-Process acad, accoreconsole -ErrorAction SilentlyContinue) { return $false }
  # 23 Oct 2026: job presence no longer blocks (lock, AutoCAD process and settings guard do)
  if (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') { return $false }
  $lock = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lock) { try { $j = Get-Content $lock -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { return $false } } catch { return $false } }
  return $true
}
function LockName { 'Codex-' + ($name -replace '^verify','' -replace '_.*$','') }
function TakeLock { $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds(); $rec = [ordered]@{ who = (LockName); pid = $PID; acad_pid = 0; acad_start = 0; since = $now; since_text = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); refreshed = $now; note = 'claimed by the Codex launcher gate'; expires = ($now + 1800); expires_text = (Get-Date).AddMinutes(30).ToString('yyyy-MM-dd HH:mm:ss') }; ($rec | ConvertTo-Json) | Set-Content 'C:\ce_rc_drv\ACAD_LOCK.json' -Encoding UTF8; Log ('claimed the lock as ' + (LockName)) }
function LockIsMine { try { $j = Get-Content 'C:\ce_rc_drv\ACAD_LOCK.json' -Raw | ConvertFrom-Json; ([string]$j.who -eq (LockName)) } catch { $false } }
function AttachProbe {
  # 23 Oct 2026 (corrected): Codex Computer Use is the tool mcp__node_repl__js. The earlier probe asked for a tool literally named node_repl and always said MISSING. This probe asks a throw-away session to list its tool names through its exec tool and passes only when a node_repl or sky tool is there.
  $o = (& 'C:/Program Files/Git/bin/bash.exe' 'C:/CE_PLAN/desk_jobs/codex_cu_probe.sh' 2>$null | Out-String)
  $ok = ($o -match 'CU_OK')
  $helpers = @(Get-Process codex-computer-use -ErrorAction SilentlyContinue).Count
  $lastEnd = (Get-Content (Join-Path $d 'queue.log') -Tail 40 -ErrorAction SilentlyContinue | Where-Object { $_ -match ' END ' } | Select-Object -Last 1)
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_attach_log.csv' ("{0},{1},{2},{3},{4}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $(if ($ok) { 'ATTACHED' } else { 'MISSING' }), $helpers, $name, ($lastEnd -replace ',', ' '))
  return $ok
}
for ($i = 1; $i -le $Tries; $i++) {
  if (Test-Path 'C:\CE_PLAN\desk_jobs\STOP_CODEX.flag') { Log 'STOP flag'; exit }
  $w = 0; while (-not (Gate)) { Start-Sleep 10; $w++; if ($w -gt 1440) { Log 'gate never opened'; exit } }
  # 23 Oct 2026 20:35 (desk): claim the AutoCAD lock at once under the name the brief itself uses (Codex-<id>), so the test runner cannot retake AutoCAD in the gap (X5 starved for 101 minutes and was marked done unrun). The brief's own lock acquire with the same name refreshes this record.
  TakeLock
  Start-Sleep 15
  if (-not (LockIsMine)) { Log 'lost the lock race: waiting again'; $i--; continue }
  $pw = 0; while (-not (Test-Path 'C:\CE_PLAN\desk_jobs\NO_ATTACH_PROBE.flag') -and -not (AttachProbe)) { $pw++; if ($pw -gt 33) { Log 'attach probe never ATTACHED in 25 min'; break }; Start-Sleep 45 }
  $t0 = Get-Date
  Log ("try $i starting $name")
  & $bash -lc ('cd "/c/Lisp Files/_CODEX_RUNNER" && MAXC=99 bash queue3.sh "' + $Line + '"') *>> "C:\CE_PLAN\desk_jobs\codex_retry_$name.out"
  $rep = Get-ChildItem 'C:\Lisp Files\_TEST_COPIES_20260923' -Filter "$ReportGlob.md" -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt $t0 } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $first = if ($rep) { (Get-Content $rep.FullName -TotalCount 1) } else { '' }
  Log ("try $i finished; report: " + $(if ($rep) { $rep.Name } else { 'none' }) + '; first line: ' + $first)
  if ($rep -and $first -notmatch 'NOT STARTED') { Log 'done'; exit }
  Start-Sleep 90
}
Log 'gave up after retries'