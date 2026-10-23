# Desk 23 Oct 2026: AutoCAD janitor. Codex leaves AutoCAD running and its lock expires (the Codex lane then waits forever: X2 stuck 13:09-16:25). Every 5 minutes: if ACAD_LOCK.json is EXPIRED (or missing for 15 minutes) while acad.exe is running, no Codex exec session and no driver session (acad_driver_v3 / session-run) is alive, then copy the lock to C:\ce_rc_scratch, kill that acad.exe, remove the expired lock, and log. Never acts when the lock is live, when a settings guard holds entries (it logs and leaves it for the desk), or when anyone is using AutoCAD (a drawing with a Tim path is open is NOT checked here: test sessions use C:\ce_rc_drv and TEST_COPIES only; if a window title shows another path the janitor leaves it alone). Stop with STOP_JANITOR.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\acad_janitor.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'started'
$noLockSince = $null
while (-not (Test-Path "$d\STOP_JANITOR.flag")) {
  Start-Sleep 300
  $acad = @(Get-Process acad -ErrorAction SilentlyContinue)
  if ($acad.Count -eq 0) { $noLockSince = $null; continue }
  $lk = 'C:\ce_rc_drv\ACAD_LOCK.json'
  $expired = $false; $live = $false
  if (Test-Path $lk) { try { $j = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { $live = $true } else { $expired = $true } } catch { $live = $true } }
  else { if (-not $noLockSince) { $noLockSince = Get-Date }; if (((Get-Date) - $noLockSince).TotalMinutes -ge 15) { $expired = $true } }
  if ($live) { $noLockSince = $null; continue }
  if (-not $expired) { continue }
  $busy = @(Get-CimInstance Win32_Process | Where-Object { ($_.Name -match 'codex' -and $_.CommandLine -match ' exec ' -and $_.CommandLine -notmatch 'cx_(lf|rv)') -or ($_.Name -match 'pwsh' -and $_.CommandLine -match 'acad_driver_v3|session-run|v3_selftest|run-pack|run-case') })
  if ($busy.Count -gt 0) { continue }
  $titles = @($acad | ForEach-Object { $_.MainWindowTitle })
  if ($titles | Where-Object { $_ -match '\.dwg' -and $_ -notmatch 'ce_rc_drv|_TEST_COPIES|LOOKS|LKW|LKX|LKV|CLD|DRV' }) { Log ('AutoCAD with a non-test drawing open ("' + ($titles -join '; ') + '"): left alone'); continue }
  if (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') { Log 'settings guard present: acad not killed; desk must run settings-restore'; continue }
  if (Test-Path $lk) { Copy-Item $lk ("C:\ce_rc_scratch\ACAD_LOCK_janitor_" + (Get-Date -Format 'HHmm') + ".json") -Force }
  $acad | Stop-Process -Force -ErrorAction SilentlyContinue
  Remove-Item $lk -Force -ErrorAction SilentlyContinue
  Log ('killed stale AutoCAD pid ' + ($acad.Id -join ',') + ' (lock expired or absent, no Codex/driver session alive); lock removed')
  $noLockSince = $null
}
Log 'stopped'
