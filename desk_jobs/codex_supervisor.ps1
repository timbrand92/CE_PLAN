# Desk 23 Oct 2026: CODEX SUPERVISOR (Tim: "sort codex out, all these breaks and its getting stuck ... manage it so we actually get somewhere"). One loop, every 2 minutes, keeps the whole Codex machine healthy and spends the usage by plan.
# MODES (file desk_jobs\CODEX_MODE.txt): SPEND (default until the weekly reset: AutoCAD conveyor plus up to 5 parallel filler jobs (raised from 3 on 23 Oct 19:40: usage was rising only about 5 points an hour; Tim wants the week spent before the reset) from FILLER_QUEUE.txt in FAST mode, cap 97 percent) and HOLD (after the reset: no new Codex job of any kind; running jobs finish; the new week's usage is left alone). The mode flips to HOLD by itself when the usage reading drops 15 points or more between two reads (the weekly reset), or by hand (write HOLD to CODEX_MODE.txt). Back to SPEND: write SPEND.
# HEALTH DUTIES: (1) exactly one codex_conveyor.ps1 alive in SPEND (start it if missing, kill duplicates); (2) a stuck AutoCAD look: a verify* codex job running more than 75 minutes is killed with its AutoCAD (the janitor then clears the lock); a launch_codex_retry launcher older than 100 minutes that has no live codex child is killed; (3) filler jobs are started only when disk C: is above 12 GB and fewer than 3 filler codex jobs run; (4) a filler job older than 120 minutes is killed; (5) acad_janitor.ps1 and disk_guard.ps1 must be alive (started if missing); (6) everything is logged to codex_supervisor.log with a heartbeat line every 10 minutes. Stop with STOP_SUPERVISOR.flag.
$d = 'C:\CE_PLAN\desk_jobs'
$bash = 'C:\Program Files\Git\bin\bash.exe'
function Log($t) { Add-Content "$d\codex_supervisor.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Usage { $o = & $bash -c 'cd "/c/Lisp Files/_CODEX_RUNNER" && ./codex_usage.sh pct' 2>$null; $v = 0.0; if ([double]::TryParse(($o | Select-Object -First 1), [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$v)) { $v } else { -1 } }
function Mode { if (Test-Path "$d\CODEX_MODE.txt") { (Get-Content "$d\CODEX_MODE.txt" -TotalCount 1).Trim().ToUpper() } else { 'SPEND' } }
function Procs($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match $pat }) }
if (-not (Test-Path "$d\CODEX_MODE.txt")) { Set-Content "$d\CODEX_MODE.txt" 'SPEND' }
$last = Usage; $beat = Get-Date; $fillerPids = @{}
Log "started: usage $last mode $(Mode)"
while (-not (Test-Path "$d\STOP_SUPERVISOR.flag")) {
  Start-Sleep 120
  $u = Usage
  if ($u -ge 0) {
    if ($last -ge 0 -and ($last - $u) -ge 15) { Set-Content "$d\CODEX_MODE.txt" 'HOLD'; Log "WEEKLY RESET DETECTED ($last -> $u): mode HOLD. No new Codex job will start; running jobs finish; the new week is left alone." }
    $last = $u
  }
  $mode = Mode
  # janitor and disk guard alive
  if ((Procs 'acad_janitor\.ps1').Count -eq 0) { Start-Process pwsh -WindowStyle Hidden -ArgumentList "-NoProfile -File $d\acad_janitor.ps1"; Log 'janitor restarted' }
  if ((Procs 'disk_guard\.ps1').Count -eq 0) { Start-Process pwsh -WindowStyle Hidden -ArgumentList "-NoProfile -File $d\disk_guard.ps1"; Log 'disk guard restarted' }
  # stuck AutoCAD look: a verify* codex job older than 75 minutes
  foreach ($p in (Procs 'codex(\.exe)?"?\s.*exec' | Where-Object { $_.CommandLine -match 'verify[A-Z]' })) { $age = ((Get-Date) - $p.CreationDate).TotalMinutes; if ($age -gt 75) { try { Stop-Process -Id $p.ProcessId -Force; Log "killed stuck AutoCAD look (codex pid $($p.ProcessId), $([int]$age) min)" } catch { } } }
  # stuck launcher without a live codex child
  foreach ($p in (Procs 'launch_codex_retry\.ps1')) { $age = ((Get-Date) - $p.CreationDate).TotalMinutes; $kids = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'codex' -and $_.CommandLine -match ' exec ' -and $_.CommandLine -match 'verify[A-Z]' }); if ($age -gt 100 -and $kids.Count -eq 0) { try { Stop-Process -Id $p.ProcessId -Force; Log "killed idle launcher pid $($p.ProcessId) ($([int]$age) min)" } catch { } } }
  # filler jobs
  $fill = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'codex' -and $_.CommandLine -match ' exec ' -and $_.CommandLine -match 'cx_(lf|rv)' })
  foreach ($p in $fill) { if (((Get-Date) - $p.CreationDate).TotalMinutes -gt 120) { try { Stop-Process -Id $p.ProcessId -Force; Log "killed filler job older than 120 min (pid $($p.ProcessId))" } catch { } } }
  if ($mode -eq 'SPEND') {
    if ((Procs 'codex_conveyor\.ps1').Count -eq 0 -and -not (Test-Path "$d\STOP_CODEX.flag")) { Start-Process pwsh -WindowStyle Hidden -ArgumentList "-NoProfile -File $d\codex_conveyor.ps1"; Log 'conveyor was missing: started' }
    $conv = Procs 'codex_conveyor\.ps1'; if ($conv.Count -gt 1) { $conv | Sort-Object CreationDate | Select-Object -SkipLast 1 | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force; Log "duplicate conveyor killed $($_.ProcessId)" } catch { } } }
    $free = (Get-PSDrive C).Free / 1GB
    $runners = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'bash.exe' -and $_.CommandLine -match 'queue4\.sh' })
    if ($u -ge 0 -and $u -lt 97 -and $free -gt 13 -and $fill.Count -lt 5 -and $runners.Count -lt 5) {
      $doneF = @(Get-Content "$d\FILLER_DONE.txt" -ErrorAction SilentlyContinue)
      $next = Get-Content "$d\FILLER_QUEUE.txt" -ErrorAction SilentlyContinue | Where-Object { $_.Trim() -and $doneF -notcontains $_.Split('|')[0] } | Select-Object -First 1
      if ($next) {
        $name = $next.Split('|')[0]
        Add-Content "$d\FILLER_DONE.txt" $name
        $sh = "$d\filler_run_$name.sh"
        Set-Content $sh ("#!/usr/bin/env bash`ncd `"C:/Lisp Files/_CODEX_RUNNER`"`nMAXC=12 bash queue4.sh `"$next`" >> `"C:/CE_PLAN/desk_jobs/filler_$name.out`" 2>&1`n") -Encoding ascii
        Start-Process -FilePath $bash -ArgumentList "C:/CE_PLAN/desk_jobs/filler_run_$name.sh" -WindowStyle Hidden
        Log "filler started: $name (usage $u, C: $([math]::Round($free,1)) GB)"
      }
    }
  }
  if (((Get-Date) - $beat).TotalMinutes -ge 10) { $beat = Get-Date; Log ("heartbeat: mode $mode usage $u C: $([math]::Round((Get-PSDrive C).Free/1GB,1)) GB; fillers $($fill.Count); conveyor $((Procs 'codex_conveyor\.ps1').Count); acad $(@(Get-Process acad -ErrorAction SilentlyContinue).Count)") }
}
Log 'stopped'
