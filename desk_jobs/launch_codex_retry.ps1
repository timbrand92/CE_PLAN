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
  if (Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'tester_run|evidence_job' }) { return $false }
  if (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') { return $false }
  $lock = 'C:\ce_rc_drv\ACAD_LOCK.json'
  if (Test-Path $lock) { try { $j = Get-Content $lock -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { return $false } } catch { return $false } }
  return $true
}
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
  $w = 0; while (-not (Gate)) { Start-Sleep 60; $w++; if ($w -gt 240) { Log 'gate never opened'; exit } }
  Start-Sleep 125
  if (-not (Gate)) { continue }
  $pw = 0; while (-not (Test-Path 'C:\CE_PLAN\desk_jobs\NO_ATTACH_PROBE.flag') -and -not (AttachProbe)) { $pw++; if ($pw -gt 33) { Log 'attach probe never ATTACHED in 25 min'; break }; Start-Sleep 45 }
  $t0 = Get-Date
  Log ("try $i starting $name")
  & $bash -lc ('cd "/c/Lisp Files/_CODEX_RUNNER" && MAXC=1 bash queue3.sh "' + $Line + '"') *>> "C:\CE_PLAN\desk_jobs\codex_retry_$name.out"
  $rep = Get-ChildItem 'C:\Lisp Files\_TEST_COPIES_20260923' -Filter "$ReportGlob.md" -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt $t0 } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $first = if ($rep) { (Get-Content $rep.FullName -TotalCount 1) } else { '' }
  Log ("try $i finished; report: " + $(if ($rep) { $rep.Name } else { 'none' }) + '; first line: ' + $first)
  if ($rep -and $first -notmatch 'NOT STARTED') { Log 'done'; exit }
  Start-Sleep 90
}
Log 'gave up after retries'