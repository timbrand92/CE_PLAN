# CE 02 Fri 30 Oct 2026 (Rule 17, Tim: "when I give you a message to say that I'm leaving from site ... I will be back in the office in 50 minutes. Then you need to have everything done by that point"). HAND-BACK script. No model tokens, never changes a Windows setting of Tim's.
# Usage: pwsh -NoProfile -File handback.ps1 [-Word 'yyyy-MM-dd HH:mm'] [-DryRun] [-NowOverride 'yyyy-MM-dd HH:mm']   (Word = the minute CE 00 gives the word; default now. Deadline = Word + 40 minutes.)
# From the word: ROBOT_STOP_AT.txt = deadline (chain4 starts no pack whose estimate runs past it); 75 minutes before the deadline STOP_CODEX.flag (no new look; a look may take 75); CE 01 starts no closed window that cannot finish.
# AT the deadline: (1) a Codex look still running is stopped by its OWN pids, the marked END line is written, the look goes back on the queue; (2) a robot pack still running is stopped by its own pids; (3) AutoCAD that is OURS (test copy window or a CE 02/Codex lock holder) is closed (CloseMainWindow, then its pid); Tim's own session is never touched; (4) an unrestored settings guard is restored with the v2 settings-restore, loudly reported if it fails; (5) TIM_AWAY.flag and CODEX_AUTOSTART.flag removed, HOLD_ROBOT.flag and TIM_AT_PC.flag set; HANDBACK_DONE.txt summarises.
param([string]$Word = '', [switch]$DryRun, [string]$NowOverride = '')
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\HANDBACK.log"
function Now { if ($NowOverride) { [datetime]$NowOverride } else { Get-Date } }
function L($t) { $x = ("{0} {1}{2}" -f (Get-Date -Format 'ddd HH:mm:ss'), $(if ($DryRun) { 'DRY ' } else { '' }), $t); Add-Content $log $x; Write-Output $x }
function Act([string]$what, [scriptblock]$do) { if ($DryRun) { L "WOULD $what" } else { & $do; L $what } }
$word = if ($Word) { [datetime]$Word } else { Now }
$deadline = $word.AddMinutes(40)
L ("hand-back: word " + $word.ToString('HH:mm') + ", AutoCAD must be closed and the PC handed back by " + $deadline.ToString('HH:mm') + " (Tim at the office about " + $word.AddMinutes(50).ToString('HH:mm') + ")")
Act 'wrote HANDBACK.txt and ROBOT_STOP_AT.txt' { Set-Content "$d\HANDBACK.txt" ("Hand-back started " + (Get-Date -Format 'ddd HH:mm') + "; deadline " + $deadline.ToString('HH:mm')); Set-Content "$d\ROBOT_STOP_AT.txt" $deadline.ToString('yyyy-MM-dd HH:mm') }
$stopPlaced = $false
while ($true) {
  $now = Now; $rem = ($deadline - $now).TotalMinutes
  if (-not $stopPlaced -and $rem -le 75) { Act 'placed STOP_CODEX.flag (no new Codex look: it could not end before the deadline)' { [IO.File]::WriteAllText("$d\STOP_CODEX.flag", "HANDBACK (Rule 17) $(Get-Date -Format 'HH:mm'): no new Codex look until the go message.`n") }; $stopPlaced = $true }
  if ($rem -le 0) { break }
  if ($DryRun -and $NowOverride) { $NowOverride = $now.AddMinutes(15).ToString('yyyy-MM-dd HH:mm'); continue }   # dry run walks time forward
  if ($DryRun) { L ("dry run: " + [math]::Round($rem) + " min to the deadline; stopping here"); break }
  Start-Sleep 30
}
if ($DryRun -and -not $NowOverride -and ($deadline - (Get-Date)).TotalMinutes -gt 0) { L 'dry run (no time override): showing what the deadline step WOULD do'; }
L 'DEADLINE STEP'
# 1. Codex look
$cx = @(Get-CimInstance Win32_Process | Where-Object { ($_.CommandLine -match 'launch_codex_retry|queue4\.sh|codex\.js exec|codex-win32-x64.*exec') -and $_.Name -match 'pwsh|node|codex|bash' })
$q = 'C:\Lisp Files\_CODEX_RUNNER\queue.log'
$open = $null
if (Test-Path $q) { foreach ($l in (Get-Content $q -Tail 60)) { if ($l -match '^(\d\d:\d\d) START (\S+)') { $open = $Matches[2] } elseif ($l -match '^(\d\d:\d\d) END (\S+)') { if ($open -eq $Matches[2]) { $open = $null } } } }
if ($cx.Count) {
  L ("Codex look running (" + (($cx | ForEach-Object { "$($_.Name) $($_.ProcessId)" }) -join ', ') + "), open START: $open")
  Act 'stopped the Codex look by its own pids, wrote the marked END, put the look back on the queue' {
    foreach ($c in ($cx | Sort-Object CreationDate -Descending)) { Stop-Process -Id $c.ProcessId -Force -ErrorAction SilentlyContinue }
    if ($open -and $open -notlike 'cx_*') { [IO.File]::AppendAllText($q, (Get-Date -Format 'HH:mm') + " END $open exit 124 usage 0.0% -> 0.0% (STOPPED BY CE 02 hand-back, Rule 17; rerun later)`n") }
    Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'codex_conveyor\.ps1' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
    if ($open) { $df = "$d\CONVEYOR_DONE.txt"; $keep = @(Get-Content $df | Where-Object { $_.Trim() -ne $open }); [IO.File]::WriteAllText($df, (($keep -join "`r`n") + "`r`n")) }
  }
} else { L 'no Codex look running' }
# 2. robot pack
$rb = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'case_runner\.ps1.*run-(pack|case)|chain4\.ps1|chain3\.ps1' -and $_.Name -match 'pwsh' })
if ($rb.Count) { L ("robot running: " + (($rb | ForEach-Object { "$($_.ProcessId)" }) -join ', ')); Act 'stopped the robot pack and chain by their own pids' { foreach ($r in $rb) { Stop-Process -Id $r.ProcessId -Force -ErrorAction SilentlyContinue } } } else { L 'no robot pack running' }
# 3. AutoCAD that is ours
$lockWho = ''; $lockSince = [datetime]::MaxValue; try { $lj = Get-Content 'C:\ce_rc_drv\ACAD_LOCK.json' -Raw | ConvertFrom-Json; $lockWho = $lj.who; $lockSince = [DateTimeOffset]::FromUnixTimeSeconds([long]$lj.since).LocalDateTime } catch {}
foreach ($a in @(Get-Process acad -ErrorAction SilentlyContinue)) {
  $title = $a.MainWindowTitle
  # ours = the window shows a test copy, OR the lock holder is a Codex/Claude job AND this AutoCAD started after that lock was claimed (a session Tim opened earlier is older than the lock and is never touched)
  $ours = ($title -match '_TEST_COPIES|ce-fx|DRV1|CLD\d|_ACAD_DRIVER') -or (($lockWho -match '^(Codex|Claude|CE ?02)') -and ($a.StartTime -ge $lockSince.AddMinutes(-3)))
  L ("AutoCAD pid $($a.Id) title '$title' lock holder '$lockWho' ours=$ours")
  if ($ours) { Act "closed our AutoCAD pid $($a.Id) (CloseMainWindow, then its pid)" { [void]$a.CloseMainWindow(); Start-Sleep 25; if (Get-Process -Id $a.Id -ErrorAction SilentlyContinue) { Stop-Process -Id $a.Id -Force } } }
  else { L "AutoCAD pid $($a.Id) NOT touched: it does not look like a test copy (Tim's own session?)" }
}
foreach ($c in @(Get-Process accoreconsole -ErrorAction SilentlyContinue)) { L "accoreconsole pid $($c.Id) running: not killed (CE 01's payload?); reported only" }
# 4. settings guard
$g = 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
if (Test-Path $g) {
  L 'settings guard present: restoring Tim''s settings files with the v2 settings-restore'
  Act 'ran settings-restore' { Remove-Item 'C:\ce_rc_drv\ACAD_LOCK.json' -Force -ErrorAction SilentlyContinue; $o = & pwsh -NoProfile -File 'C:\Lisp Files\_ACAD_DRIVER\acad_driver_witness_v2.ps1' settings-restore -Who ($(if ($lockWho) { $lockWho } else { 'Claude-handback' })) 2>&1 | Out-String; Add-Content $log ('settings-restore output: ' + $o.Substring(0, [math]::Min(400, $o.Length))) }
  if ((Test-Path $g) -and -not $DryRun) { Set-Content "$d\HANDBACK_ALERT.txt" "Settings guard still present after settings-restore at $(Get-Date -Format 'HH:mm'): Tim's settings may be changed. Do not hand the PC back until this is resolved."; L 'ALERT: guard still present' }
}
# lock left behind by us
if ((Test-Path 'C:\ce_rc_drv\ACAD_LOCK.json') -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { Act 'removed our stale ACAD_LOCK.json (copy kept in C:\ce_rc_scratch)' { Copy-Item 'C:\ce_rc_drv\ACAD_LOCK.json' ("C:\ce_rc_scratch\ACAD_LOCK_handback_" + (Get-Date -Format 'HHmm') + '.json') -Force -ErrorAction SilentlyContinue; Remove-Item 'C:\ce_rc_drv\ACAD_LOCK.json' -Force } }
# 5. flags
Act 'flags: removed TIM_AWAY and CODEX_AUTOSTART, set HOLD_ROBOT and TIM_AT_PC' {
  Remove-Item "$d\TIM_AWAY.flag", "$d\CODEX_AUTOSTART.flag", "$d\ACAD_IDLE_OK.txt" -Force -ErrorAction SilentlyContinue
  [IO.File]::WriteAllText("$d\HOLD_ROBOT.flag", "HANDBACK (Rule 17) $(Get-Date -Format 'HH:mm'): Tim is at the PC. The robot and Codex run nothing until CE 00 sends 'go'; handback_go.ps1 undoes this.`n")
  [IO.File]::WriteAllText("$d\TIM_AT_PC.flag", "HANDBACK (Rule 17) $(Get-Date -Format 'HH:mm'): Tim at the PC; the watchdog treats idle as allowed.`n")
  if (-not (Test-Path "$d\STOP_CODEX.flag")) { [IO.File]::WriteAllText("$d\STOP_CODEX.flag", "HANDBACK (Rule 17) $(Get-Date -Format 'HH:mm'): no Codex look until the go message.`n") }
}
$left = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue | ForEach-Object { "$($_.Name) $($_.Id)" }) -join ', '
$sum = "Hand-back finished " + (Get-Date -Format 'ddd HH:mm') + ". AutoCAD/accoreconsole still running: " + $(if ($left) { $left } else { 'none' }) + ". Settings guard present: " + (Test-Path $g) + ". Flags: TIM_AWAY gone, HOLD_ROBOT and TIM_AT_PC set. Idle-window and queue state kept; handback_go.ps1 resumes."
Act 'wrote HANDBACK_DONE.txt' { Set-Content "$d\HANDBACK_DONE.txt" $sum }
L $sum