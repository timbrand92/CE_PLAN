# Testing speed steps 1 and 2: the shorter safe wait and the grouping of mouse-click cases, STAGED not live (29 Oct 2026)

Job `CE_ACAD / robot / build / 12` (CE 02 Robot and Codex Testing, Team, Opus). Written Thu 29 Oct 2026, 10:50 to about 11:10 Melbourne (PC clock). Approved by CE 00 as steps 1 and 2 of `TESTING_SPEED_OPTIONS_29OCT.md`; steps 3 and 4 are held for Tim and were not touched. Tim's AutoCAD was open the whole time (started 09:14) and was not touched. Nothing was started in AutoCAD, the runner, the driver, the settings guard or the lock. No live runner, driver or chain file was edited. All work is in `C:\ce-fx\speed\staged\`.

## ANSWER FIRST

1. **Both steps are built and sitting in a staging folder. Nothing live has changed.**
2. **Step 1 (shorter wait) is proven offline:** 25 of 25 checks passed, twice. Every unsafe situation keeps today's 3 minutes; only an all-clear gives 30 seconds.
3. **Step 2 (grouping) saves AutoCAD starts, not mouse line-ups, for tonight's list.** The 8 mouse line-ups tonight's cases need are already the fewest the robot allows. The plan cuts 44 AutoCAD starts to 37.
4. **Together, tonight's whole list drops from about 6 h 25 min to about 4 h 25 min (estimate).**
5. **Before it goes live:** two test runs on a test drawing after 5:30 pm, with your AutoCAD closed.

## FOR TIM

1. **What changes, in drawing terms.**
   - **Now:** between each test session the robot sits for 3 minutes with AutoCAD closed, every time. That is a third of its night.
   - **After:** it waits 30 seconds, but only after checking, three times over those 30 seconds, that there is no AutoCAD open, the robot's "AutoCAD in use" sign is down, your settings files are back exactly as they were, the last session closed itself properly, and no install of a new CE build is running or waiting. If any one fails, it waits the full 3 minutes as today.
   - **Grouping:** tests that need the same settings and the same kind of drawing now share one AutoCAD start where they did not before. Example: the four freeboard and tidy-label checks now run one after another in one go, instead of four separate goes with a 3-minute wait between each.

2. **Minutes saved, with an example.**
   - **Tonight's list** (the 12 leftover pit and pipe checks, the 14 edited checks and the 8 new batch-4 drafts): about 6 h 25 min today, about 4 h 25 min with both steps. About 2 hours back (estimate).
   - **A normal night:** the robot makes about 90 sessions. If every wait is short, that is up to about 3 h 45 min of dead time back (estimate). Nights with an install waiting save less, on purpose.
   - **The mouse line-up** (4 minutes each time) cannot be cut tonight: the 8 left are the minimum for these cases. In the next full re-test it can be. The four mouse checks for pit labels, the pipe label on a leader and the pit drawn until Esc can share one start instead of four. That is 6 fewer line-ups, about 24 minutes per full re-test (estimate).

3. **What could go wrong, and how the check stops it.**
   - **An install of a new CE build slips in while the robot starts AutoCAD.** Installs use the 3-minute gap. So any install or payload job that is running or waiting keeps the full 3 minutes. The install script also checks twice, 60 seconds apart, that no AutoCAD is open.
   - **AutoCAD has not finished writing its own files when it closes.** The robot reads "no AutoCAD" three times over 30 seconds. It also checks your settings files match the start of the last session, fingerprint for fingerprint.
   - **A session crashed and left your settings changed.** Any leftover settings backup, changed fingerprint or unclosed session record means the full 3 minutes. The robot's own start-up check then puts your settings back first.

4. **The one-line undo.** Copy the two `.pre` files back over the live chain files and delete the one new file. The exact command is in the detail section, step 6.

5. **What must happen before it goes live.**
   - Two test runs on a test drawing, after 5:30 pm, with your AutoCAD closed.
   - Run 1 should show "short wait (30 s)" in the robot's log.
   - Run 2 should show the full 3 minutes when a pretend install hold is set.
   - Also before tonight's grouped list: the staged edits to 14 cases must be copied live first. That apply is already planned.

6. **What you need to do:** nothing today.

---

## Technical detail

### 1. Every place the robot waits with AutoCAD closed (found by reading, 29 Oct)

1. **`C:\ce-fx\c75regrade3\chain3.ps1` line 34:** waits up to 5 min (20 x 15 s) for no acad.exe, then `Start-Sleep -Seconds 180`, no other check. It also sets `CE_RUNNER_TIM_AWAY = 1`, which turns off the runner's own in-hours stop; only the chain's `-StopFirst` / `-StopAll` times protect 8:30 am. STAGED.
2. **`C:\CE_PLAN\desk_jobs\chain_robot_standing.ps1` lines 25 to 30:** `$gap` counts 30 s polls with acad.exe absent and starts the next robot job at the sixth (about 150 to 180 s). The comment says why: "installs and payload tests use the gap". Its `Busy()` (line 4) checks `tester_run[0-9]|chain_runner_run|desk_install_[cs][0-9]` but not `chain_install_*` or payload jobs. STAGED.
3. **Older one-off chains with the same 180 s:** `c75regrade2\chain.ps1` line 34, `c75run\chain_run.ps1` line 30, `b1225_regrade\chain1.ps1` line 25, `robot_n03n04\chain2.ps1` line 14. These are finished jobs; the next regrade chain is copied from chain3, so chain3 is the template. Not staged.
4. **`case_runner.ps1`:** NO fixed gap. `Wait-CaseFree` (line 46) polls every 20 s until no acad.exe and the lock is `none` or `stale`, and returns at once when free. Between the groups of one `run-pack` call the next AutoCAD starts after this check only, with no 3 minutes. No change needed.
5. **The driver (`acad_driver_v3_session.ps1`):** NO fixed gap. `Wait-V3Free` (line 127) polls every 20 s for no acad.exe and a free or stale lock, then takes the lock. `Stop-V3Session` (line 170) sleeps 2 s and 8 s inside its own quit attempts only. At every start the session also reads the settings guard and restores it first if not clear (line 279). No change needed.
6. **Not robot gaps:** `codex_cap_watch.ps1` line 9 (`Start-Sleep 180` = reading Codex usage every 3 minutes); `team_governor.ps1` line 18 (1800 s).

**Why the gap exists, from the install chains:**
1. `chain_install_c76.ps1` (the newest) waits until there is no live lock (`expires` in the future), no acad.exe or accoreconsole.exe, no `settings_guard.json` and no Codex AutoCAD job. It then writes the lock itself without the driver's mutex, waits 20 s and checks it still holds it. It polls every 10 s, so it needs a gap of at least about 30 s to win.
2. `scripts\desk_install_c76.ps1` aborts unless acad.exe and Codex jobs are absent at two readings 60 s apart. So the real protection against "install while the robot starts AutoCAD" is inside the install script.
3. What else the 3 minutes protects: AutoCAD's own shutdown writes (profile, CE settings on quit), the settings guard restore, the lock release. All of these are checked directly by the new function instead of waited for blindly.

### 2. The function (staged as `C:\ce-fx\speed\staged\wait_safe_to_start.ps1`, live destination `C:\Lisp Files\_ACAD_DRIVER\wait_safe_to_start.ps1`, a new file)

**Rules reused, not invented:**
1. **Fingerprints:** the driver's `Get-V3SettingsHashes` rule (first 12 hex of SHA-256 of the four files keyed in `$script:SettingsExpected`, `acad_driver_v3.ps1` line 71, read with shared access, `MISSING` when absent). These are compared with `hashes_start` in the last session's `session.json`. That is the same start-against-end comparison the driver's `end.clean` makes (`hash_differences`, `acad_driver_v3_session.ps1` line 216).
2. **NOT against the runner's expected list.** That list is stale: every run since at least 3.0.84 notes `CE_STRUC_SUITE\CS_Settings.json : B3B5A004B929 (expected 2972CE70C514)`. Comparing against it would keep 180 s forever. The stale value itself is not fixed here (runner owner).
3. **Lock:** absent, or `expires` in the past = no live lock (the install chain's rule). Stricter than the driver's `stale`: a lock whose holder died but has not expired gets the full wait, because it means a session ended badly.
4. **Session record:** the newest `C:\ce_rc_scratch\v3_state\run_*` folder must hold `done.txt` (written by `Stop-V3Watchdog` after the clean-up), and the pid in `watchdog.pid` must be gone.
5. **Install detection:** extends `chain_robot_standing.ps1`'s `Busy()` to `desk_install_[cs]N`, `chain_install_[cs]N`, `patch_install`, `payloadNNN_*job` and `ctl_payloadNN`. Plus `HOLD_ROBOT.flag`, and `STOP_CODEX.flag` when it says "install". Command lines holding `Get-CimInstance` are ignored (a watcher's own query).

```powershell
#Requires -Version 7.0
<#
 wait_safe_to_start.ps1 (CE 02, 29 Oct 2026, testing speed step 1; STAGED, not live). Dot-source it, then call Wait-SafeToStart between robot sessions.
 The ONE shared wait used by the robot chains in place of their fixed 3 minutes with AutoCAD closed (chain3.ps1 Start-Sleep 180; chain_robot_standing.ps1 six 30 s polls).
 SHORT wait (30 s) only when ALL of these hold at three readings (start, +10 s, +30 s):
   1. no acad.exe and no accoreconsole.exe;
   2. no live lock: C:\ce_rc_drv\ACAD_LOCK.json absent, or its 'expires' is past (stricter than the driver's own 'stale': a lock whose holder died but has not expired still means a session ended badly, so it gets the full wait);
   3. no settings guard: neither settings_guard.json nor settings_guard.abandoned in the driver folder;
   4. the four settings fingerprints (first 12 hex of SHA-256, the driver's Get-V3SettingsHashes rule) equal the ones the last session recorded at its start (session.json hashes_start: the same comparison the driver's end.clean makes);
   5. no install, payload or patch-install job running or queued (process command lines), no HOLD_ROBOT.flag, no install hold in STOP_CODEX.flag;
   6. the driver's last session record is closed: the newest C:\ce_rc_scratch\v3_state\run_* folder holds done.txt and its watchdog process is gone;
   7. the newest runner report has no session that ended NOT clean.
 Anything else keeps today's full 180 s (polled every 30 s). Every probe can be replaced (-Probe) so the offline test runs on a fake folder and a fake process list.
 Returns: Seconds (time waited), Short (true = 30 s path), Go (AutoCAD stayed absent at every reading), Reasons (why the full wait was kept).
#>
function Get-SafeStartDefaults {
    @{
        LockFile     = 'C:\ce_rc_drv\ACAD_LOCK.json'
        GuardDir     = 'C:\Lisp Files\_ACAD_DRIVER'
        SettingsRoot = $env:APPDATA
        SettingsKeys = @('TIM_CE_CADTOOLS\CD_Settings.json', 'TIM_CE_CADTOOLS\CS_Settings.json', 'CE_CVL_SUITE\settings.json', 'CE_STRUC_SUITE\CS_Settings.json')   # the keys of $script:SettingsExpected in acad_driver_v3.ps1 line 71
        SessionRoot  = 'C:\ce_rc_scratch\v3_state'
        ReportDir    = 'C:\CE_PLAN\areas\runner-reports'
        DeskDir      = 'C:\CE_PLAN\desk_jobs'
        AcadCount    = { @(Get-Process -Name acad, accoreconsole -ErrorAction SilentlyContinue).Count }
        CommandLines = { @(Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessId -ne $PID } | ForEach-Object { [string]$_.CommandLine }) }
        LicAgentCount = { @(Get-Process -Name AdskLicensingAgent -ErrorAction SilentlyContinue).Count }
        PidAlive     = { param([int]$Id) [bool](Get-Process -Id $Id -ErrorAction SilentlyContinue) }
        UnixNow      = { [DateTimeOffset]::UtcNow.ToUnixTimeSeconds() }
        Sleep        = { param([int]$Sec) Start-Sleep -Seconds $Sec }
    }
}
# the driver's fingerprint rule (acad_driver_v3_session.ps1 Get-V3SettingsHashes + acad_driver_v3.ps1 Get-ShaFile): first 12 hex of SHA-256, read even while the file is open, MISSING when absent
function Get-SafeStartHashes($P) {
    $o = [ordered]@{}
    foreach ($k in $P.SettingsKeys) {
        $f = Join-Path $P.SettingsRoot $k
        $o[$k] = $(if (Test-Path -LiteralPath $f -PathType Leaf) {
                $fs = [IO.File]::Open($f, [IO.FileMode]::Open, [IO.FileAccess]::Read, ([IO.FileShare]::ReadWrite -bor [IO.FileShare]::Delete))
                try { ([BitConverter]::ToString([Security.Cryptography.SHA256]::Create().ComputeHash($fs)) -replace '-', '').Substring(0, 12) } finally { $fs.Dispose() }
            } else { 'MISSING' })
    }
    $o
}
# one reading of every condition; returns the list of reasons it is NOT safe (empty = all clear)
function Test-SafeToStart($P) {
    $why = [System.Collections.Generic.List[string]]::new()
    try {
        # 1. AutoCAD
        $n = [int](& $P.AcadCount); if ($n -gt 0) { $why.Add("acad.exe or accoreconsole.exe running ($n)") }
        # 2. the lock
        if (Test-Path -LiteralPath $P.LockFile) {
            $l = $null; try { $l = Get-Content -LiteralPath $P.LockFile -Raw | ConvertFrom-Json -AsHashtable } catch { }
            if (-not $l) { $why.Add('ACAD_LOCK.json present but unreadable') }
            elseif ([long]$l.expires -gt [long](& $P.UnixNow)) { $why.Add("ACAD_LOCK.json live (held by $($l.who), not expired)") }
        }
        # 3. the settings guard
        foreach ($g in 'settings_guard.json', 'settings_guard.abandoned') { if (Test-Path -LiteralPath (Join-Path $P.GuardDir $g)) { $why.Add("$g present (settings not yet put back)") } }
        # 6. the last session record (read first: its hashes_start is the baseline for 4)
        $last = Get-ChildItem -LiteralPath $P.SessionRoot -Directory -Filter 'run_*' -ErrorAction SilentlyContinue | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
        $sess = $null
        if (-not $last) { $why.Add('no driver session record found') }
        else {
            if (-not (Test-Path -LiteralPath (Join-Path $last.FullName 'done.txt'))) { $why.Add("last session record $($last.Name) has no done.txt (session not closed by the runner)") }
            $wp = Join-Path $last.FullName 'watchdog.pid'
            if (Test-Path -LiteralPath $wp) { $wid = 0; [void][int]::TryParse((Get-Content -LiteralPath $wp -Raw).Trim(), [ref]$wid); if ($wid -gt 0 -and (& $P.PidAlive $wid)) { $why.Add("watchdog $wid of $($last.Name) still running") } }
            try { $sess = Get-Content -LiteralPath (Join-Path $last.FullName 'session.json') -Raw | ConvertFrom-Json -AsHashtable } catch { $why.Add("last session record $($last.Name) has no readable session.json") }
        }
        # 4. the settings fingerprints against the last session's own start (the end.clean comparison), never against the stale expected list
        if ($sess) {
            $base = $sess.hashes_start
            if (-not $base) { $why.Add('last session.json has no hashes_start') }
            else { $now = Get-SafeStartHashes $P; foreach ($k in $P.SettingsKeys) { if ([string]$base[$k] -ne [string]$now[$k]) { $why.Add("settings fingerprint differs: $k $($base[$k]) -> $($now[$k])") } } }
        }
        # 5. installs, payloads, holds
        foreach ($cl in @(& $P.CommandLines)) {
            if ($cl -match 'Get-CimInstance') { continue }   # a watcher's own query line, never a job
            if ($cl -match '(?i)desk_install_[cs][0-9]|chain_install_[cs][0-9]|patch_install|payload[0-9]+_\w*job|ctl_payload[0-9]+') { $why.Add("install or payload job running or queued: $(if ($cl.Length -gt 90) { $cl.Substring(0, 90) } else { $cl })") }
        }
        if (Test-Path -LiteralPath (Join-Path $P.DeskDir 'HOLD_ROBOT.flag')) { $why.Add('HOLD_ROBOT.flag present') }
        $sc = Join-Path $P.DeskDir 'STOP_CODEX.flag'
        if ((Test-Path -LiteralPath $sc) -and ((Get-Content -LiteralPath $sc -Raw -ErrorAction SilentlyContinue) -match '(?i)install')) { $why.Add('STOP_CODEX.flag holds an install hold') }
        # 7. the newest runner report
        $rp = Get-ChildItem -LiteralPath $P.ReportDir -Filter 'RUN-*.json' -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
        if ($rp) {
            $j = $null; try { $j = Get-Content -LiteralPath $rp.FullName -Raw | ConvertFrom-Json } catch { $why.Add("newest runner report $($rp.Name) unreadable") }
            if ($j) { foreach ($s in @($j.sessions)) { if ($null -ne $s.clean -and -not [bool]$s.clean) { $why.Add("newest runner report $($rp.Name): session $($s.session_id) did not end clean") } } }
        }
    } catch { $why.Add("a check failed to read: $($_.Exception.Message)") }   # any doubt keeps the full wait
    , $why
}
function Wait-SafeToStart {
    param([hashtable]$Probe = @{}, [int]$ShortSec = 30, [int]$FullSec = 180, [scriptblock]$Log = $null)
    $P = Get-SafeStartDefaults; foreach ($k in $Probe.Keys) { $P[$k] = $Probe[$k] }
    $waited = 0; $go = $true; $reasons = [System.Collections.Generic.List[string]]::new()
    # short path: three all-clear readings at 0, +10 and +30 s
    foreach ($at in 0, 10, $ShortSec) {
        if ($at -gt $waited) { & $P.Sleep ($at - $waited); $waited = $at }
        $r = Test-SafeToStart $P
        if ($r.Count) { foreach ($x in $r) { $reasons.Add("at +$waited s: $x") }; break }
        if ($at -eq $ShortSec) {
            $lic = try { [int](& $P.LicAgentCount) } catch { -1 }   # recorded only, never blocks: whether Autodesk's licensing agent outlives AutoCAD is not known yet (the go-live test runs answer it)
            if ($Log) { & $Log "safe-to-start: all clear at 0, 10 and $ShortSec s: short wait ($ShortSec s); Autodesk licensing agent processes still running: $lic" }
            return [pscustomobject]@{ Seconds = $waited; Short = $true; Go = $true; Reasons = @() }
        }
    }
    # full path: today's 3 minutes, in 30 s polls; Go stays true only if AutoCAD was absent at every poll (the standing chain's old rule)
    while ($waited -lt $FullSec) {
        $step = [Math]::Min(30, $FullSec - $waited); & $P.Sleep $step; $waited += $step
        try { if ([int](& $P.AcadCount) -gt 0) { $go = $false } } catch { $go = $false }   # a reading that fails counts as "AutoCAD may be there"
    }
    if ($Log) { & $Log "safe-to-start: full wait ($waited s) because: $(@($reasons | Select-Object -First 3) -join ' | ')$(if (-not $go) { ' | AutoCAD appeared during the wait' })" }
    [pscustomobject]@{ Seconds = $waited; Short = $false; Go = $go; Reasons = @($reasons) }
}
```

### 3. The staged chain copies and their diffs

Files in `C:\ce-fx\speed\staged\`: `chain3.ps1` (+ `chain3.ps1.pre`, `chain3.ps1.diff`), `chain_robot_standing.ps1` (+ `.pre`, `.diff`), `wait_safe_to_start.ps1` (+ `.diff` against nothing: a new file). The `.pre` files equal the live files: SHA-256 first 12 `8626CEDBC878` (chain3) and `65D797474EA9` (standing chain), re-hashed at 11:03 and unchanged.

```diff
--- chain3.ps1.pre
+++ chain3.ps1
@@ -3,6 +3,7 @@
 $env:CE_RUNNER_TIM_AWAY = '1'
 $drv = 'C:\Lisp Files\_ACAD_DRIVER'
 $out = 'C:\ce-fx\c75regrade3'
+. (Join-Path $drv 'wait_safe_to_start.ps1')   # speed step 1 (29 Oct): the shared safe wait between sessions (30 s when every check is clear, else today's 180 s)
 Set-Location $drv
 $name = [IO.Path]::GetFileNameWithoutExtension($SpecFile)
 $prog = Join-Path $out "progress_$name.txt"
@@ -31,7 +32,7 @@
   if ($i -lt $jobs.Count) {
     $n = 0
     while (@(Get-Process acad -ErrorAction SilentlyContinue).Count -gt 0 -and $n -lt 20) { Start-Sleep 15; $n++ }
-    Start-Sleep -Seconds 180
+    $ws = Wait-SafeToStart -Log { param($t) "$tag gap: $t" | Out-File $prog -Append }
   }
 }
-'ALL DONE' | Out-File $prog -Append
+'ALL DONE' | Out-File $prog -Append
```
(The last pair is only a line ending at the end of the file; the text is the same.)

```diff
--- chain_robot_standing.ps1.pre
+++ chain_robot_standing.ps1
@@ -8,8 +8,8 @@
   return [bool]$p
 }
 function AcadAbsent() { return -not (Get-Process acad -ErrorAction SilentlyContinue) }
+. 'C:\Lisp Files\_ACAD_DRIVER\wait_safe_to_start.ps1'   # speed step 1 (29 Oct): the shared safe wait (30 s when every check is clear, else today's 3 minutes with AutoCAD absent at every 30 s poll)
 Log 'standing robot queue started'
-$gap = 0
 while ($true) {
   if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
   $next = $null
@@ -20,12 +20,11 @@
       if (-not (Test-Path "$l.done")) { $next = $l; break }
     }
   }
-  if (-not $next -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Busy)) { $gap = 0; Start-Sleep 60; continue }
-  if (-not (AcadAbsent)) { $gap = 0; Start-Sleep 30; continue }
-  # AutoCAD absent: it must stay absent for 3 minutes (installs and payload tests use the gap), then go
-  $gap++
-  if ($gap -lt 6) { Start-Sleep 30; continue }
-  $gap = 0
+  if (-not $next -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Busy)) { Start-Sleep 60; continue }
+  if (-not (AcadAbsent)) { Start-Sleep 30; continue }
+  # AutoCAD absent: the shared safe wait. 30 s when AutoCAD, the lock, the settings guard and fingerprints, the last session record and every install or payload job are clear; otherwise today's 3 minutes (installs and payload tests use the gap). If AutoCAD appeared during the wait, loop again.
+  $ws = Wait-SafeToStart -Log { param($t) Log $t }
+  if (-not $ws.Go -or (Test-Path "$d\HOLD_ROBOT.flag") -or (Busy) -or -not (AcadAbsent)) { continue }
   if (-not (Test-Path $next)) { Log "queue line missing file: ${next}"; Set-Content "$next.done" 'missing'; continue }
```

**Behaviour kept on purpose:** chain3 goes on to the next line after the full wait even if AutoCAD is still open, as today (the runner itself then waits up to 60 minutes). The standing chain loops back if AutoCAD appeared during the wait, as today. `case_runner.ps1` and the driver are not changed.

### 4. Offline test (`test_wait_safe_to_start_offline.ps1`)

Fake folder `C:\ce-fx\speed\staged\fake` (lock file, guard folder, four fake settings files, a session record with `session.json`, `done.txt` and `watchdog.pid`, a runner report, flag folder), deleted at the end. Fake process list, fake AutoCAD count, fake clock. `Sleep` only adds to a counter, so nothing really waits and nothing real is read. Run 1 output, quoted in full:

```
Wait-SafeToStart offline test, Thu 29 Oct 2026 11:04:09 (PC clock). Fake folder: C:\ce-fx\speed\staged\fake

--- all clear
PASS  all clear: no AutoCAD, no lock, no guard, same fingerprints, closed waited  30 s (slept  30)  short=True go=True
PASS  lock present but EXPIRED (driver: no live lock)                waited  30 s (slept  30)  short=True go=True
PASS  a watcher's own Get-CimInstance line naming desk_install       waited  30 s (slept  30)  short=True go=True
PASS  watchdog pid file names a dead process                         waited  30 s (slept  30)  short=True go=True

--- each unsafe condition alone (must keep the full 180 s)
PASS  1. acad.exe / accoreconsole.exe running                        waited 180 s (slept 180)  short=False go=False  why: at +0 s: acad.exe or accoreconsole.exe running (1)
PASS  2a. lock LIVE (not expired)                                    waited 180 s (slept 180)  short=False go=True  why: at +0 s: ACAD_LOCK.json live (held by Install-chain-c76, not expired)
PASS  2b. lock file unreadable                                       waited 180 s (slept 180)  short=False go=True  why: at +0 s: ACAD_LOCK.json present but unreadable
PASS  3a. settings_guard.json present                                waited 180 s (slept 180)  short=False go=True  why: at +0 s: settings_guard.json present (settings not yet put back)
PASS  3b. settings_guard.abandoned present                           waited 180 s (slept 180)  short=False go=True  why: at +0 s: settings_guard.abandoned present (settings not yet put back)
PASS  4a. CD_Settings.json fingerprint differs from the session start waited 180 s (slept 180)  short=False go=True  why: at +0 s: settings fingerprint differs: TIM_CE_CADTOOLS\CD_Settings.json 93E56EF0D8CD -> 25DD00C2F78C
PASS  4b. CE_STRUC_SUITE CS_Settings.json missing                    waited 180 s (slept 180)  short=False go=True  why: at +0 s: settings fingerprint differs: CE_STRUC_SUITE\CS_Settings.json 9052912DE750 -> MISSING
PASS  4c. session.json has no hashes_start                           waited 180 s (slept 180)  short=False go=True  why: at +0 s: last session.json has no hashes_start
PASS  5a. desk_install_c76.ps1 running                               waited 180 s (slept 180)  short=False go=True  why: at +0 s: install or payload job running or queued: pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\scripts\desk_install_c76.ps1
PASS  5b. chain_install_c76.ps1 queued (waiting for its payload)     waited 180 s (slept 180)  short=False go=True  why: at +0 s: install or payload job running or queued: pwsh -File C:\CE_PLAN\desk_jobs\chain_install_c76.ps1
PASS  5c. payload job running                                        waited 180 s (slept 180)  short=False go=True  why: at +0 s: install or payload job running or queued: cmd /c claude -p < "C:\CE_PLAN\desk_jobs\payload112_c76_job.txt"
PASS  5d. HOLD_ROBOT.flag present                                    waited 180 s (slept 180)  short=False go=True  why: at +0 s: HOLD_ROBOT.flag present
PASS  5e. STOP_CODEX.flag holds an install hold                      waited 180 s (slept 180)  short=False go=True  why: at +0 s: STOP_CODEX.flag holds an install hold
PASS  6a. last session record has no done.txt                        waited 180 s (slept 180)  short=False go=True  why: at +0 s: last session record run_RUN-FAKE-0001_1 has no done.txt (session not closed by the runner)
PASS  6b. last session's watchdog still running                      waited 180 s (slept 180)  short=False go=True  why: at +0 s: watchdog 4242 of run_RUN-FAKE-0001_1 still running
PASS  6c. no session record at all                                   waited 180 s (slept 180)  short=False go=True  why: at +0 s: no driver session record found
PASS  7. newest runner report: a session NOT clean                   waited 180 s (slept 180)  short=False go=True  why: at +0 s: newest runner report RUN-FAKE-0002.json: session RUN-FAKE-0002-s1 did not end clean
PASS  8. a check throws (process list cannot be read)                waited 180 s (slept 180)  short=False go=True  why: at +0 s: a check failed to read: access denied (fake)

--- conditions that turn unsafe DURING the 30 s (second and third readings)
PASS  9a. AutoCAD starts at +10 s                                    waited 180 s (slept 180)  short=False go=False  why: at +10 s: acad.exe or accoreconsole.exe running (1)
PASS  9b. install starts at +30 s (third reading)                    waited 180 s (slept 180)  short=False go=True  why: at +30 s: install or payload job running or queued: pwsh -File C:\CE_PLAN\desk_jobs\scripts\desk_install_c77.ps1
PASS  9c. a lock is claimed at +10 s                                 waited 180 s (slept 180)  short=False go=True  why: at +10 s: ACAD_LOCK.json live (held by Install-chain-c77, not expired)

RESULT: 25 passed, 0 failed, 25 checks
```

1. **Run 2** (11:04:11): `RESULT: 25 passed, 0 failed, 25 checks`. Both outputs are in `test_output_run1.txt` and `test_output_run2.txt`.
2. **The test can fail (proof):** a deliberately broken copy of the function with the live-lock check removed gave `RESULT: 23 passed, 2 failed` (2a and 9c waited 30 s). Output in `test_output_mutation.txt`. The broken copy was deleted straight after.
3. **Syntax:** all six staged scripts parse with 0 errors (PowerShell parser, nothing executed).
4. **One real read-only reading at 10:59** (no sleep, no lock, nothing written): reasons `acad.exe or accoreconsole.exe running (1)` and `HOLD_ROBOT.flag present`. So with Tim's AutoCAD open and the robot held, it would keep the full wait. The fingerprints matched the last robot session's start, even with Tim's AutoCAD open.

### 5. Step 2: the mouse line-up, measured

Script `classify_cases.ps1` (offline; loads the runner's own case reader the way `case_selftest_offline.ps1` does). Output `classify_output.txt`, tables `case_classes.tsv` (279 case files) and `sessions.tsv` (779 timed sessions from 1,404 report files).

1. **What the line-up is:** `Invoke-V3Calibrate` (`acad_driver_v3_session.ps1` line 381) proves the pixel maths on a known circle at the start of a session. `case_runner.ps1` line 231 asks for it only when a case in that session has a `v3 pt-*` step (a real mouse click, drag or hover). It is once per AutoCAD start, never reused across starts. The driver refuses a reading that belongs to another AutoCAD, and the speed options report advises against reuse.
2. **Cost, measured:** median overhead outside the cases' own time is 298 s in a calibrated session against 57 s without. So **241 s per line-up** (all 779 sessions; matches the audit's 240 s estimate).
3. **How often:** 74 of 336 sessions in the audit window (27 Oct 00:05 to 29 Oct 08:14), 22 percent. **71 of those 74 held only one mouse case.**
4. **Which cases paid it (starts in the window):** R01 9, R08 9, R08x_1_exact 8, N20 8, N05 7, R09 6, R08x_5_plain_line_first 5, R09_OFF_BROKEN 4, N25 4, R08x_diag_disableAllSelectionWork 4, N25_BROKEN 3, and five R08x controls 2 each. Over all reports, 99 of 214 calibrated starts were the R08 investigation controls (R08x, R08c). Each has its own SETTING line, so they could never share.
5. **Mouse cases (65 files):** main N05, N20, N25, R01, R08, R09; variants N25_BROKEN, R08_BROKEN, R09_OFF_BROKEN; 55 R08c and R08x controls; draft N32 (batch 4). No setup file adds a mouse step that the runner's check would miss.
6. **Grouping rule (runner, `Invoke-CasePack` line 379):** one AutoCAD start per fixture + slot + SETTING lines (text equal, in order) inside one runner call. A runner call takes one folder only. Different SETTING lines can never share a start, because CE reads its settings at start-up.
7. **Classification:** all 279 case files in `case_classes.tsv` with mouse yes/no, real Esc yes/no, SETTING signature, slot, fixture, runs and minutes. Minutes are the median measured case time, or an estimate from the step count (marked) for never-run drafts. Every case in the plan uses fixture DRV1_B1.

### 6. Step 2: the grouping plan (`C:\ce-fx\speed\staged\spec_grouped.txt`)

Checked by `check_spec_grouped.ps1`, which resolves each line with the runner's own `-Only` filter (line 425, copied word for word) over the live folders with the staged fix-up files laid on top. It then groups with the runner's key and estimates time. Output: `check_spec_output.txt`. Coverage check: all 28 main cases twice, all 10 twins and controls once, R08 and R09 twice; no warnings.

**The lines (a = first start, b = second, separate start):**
```
aK1|cases|R01,R02,R02b,R03,R04,N24,R36e
bK1|cases|R01,R02,R02b,R03,R04,N24,R36e
aK1b|cases|R32,R32b
bK1b|cases|R32,R32b
aK2|cases|R05,R07,R08,R10,R09
bK2|cases|R05,R07,R08,R10,R09
aK3|cases|R14h_both_200,R14h_dstd_200,R14h_pipekey_200,R16
bK3|cases|R14h_both_200,R14h_dstd_200,R14h_pipekey_200,R16
aK4|cases|R34,R34s,R34sn,R34so
bK4|cases|R34,R34s,R34sn,R34so
aV1|cases\variants|R33m,R36e_p2,R36e_p3,R36e_p4,R34s_off_broken,R34so_off_broken
bV1|cases\variants|R33m,R36e_p2,R36e_p3,R36e_p4
aC1|cases\controls|C32,C33m,C34,C36e
aD1|cases\drafts_opus_29oct_b4|N31,N31_hand_placed_text_kept_through_pit_move_BROKEN,N32_every_new_object_on_its_office_layer_BROKEN
bD1|cases\drafts_opus_29oct_b4|N31
aD2|cases\drafts_opus_29oct_b4|N32
bD2|cases\drafts_opus_29oct_b4|N32
aD3|cases\drafts_opus_29oct_b4|N33,N33_schedule_groups_lpd_og_p_cp_then_rest_BROKEN,N34_schedule_natural_order_p1a_sps_switch_on_BROKEN,N34
bD3|cases\drafts_opus_29oct_b4|N33,N34
```

**Each AutoCAD start, mouse count and estimated minutes (including its share of the gap at 180 s):**
1. **K1 (a and b):** N24, R01, R02, R02b, R03, R04, R36e; 1 mouse case (R01); about 24.7 min each.
2. **K1b (a and b):** R32, R32b; 0 mouse; about 15.5 min each. Split from K1 so no single start nears the driver's 45-minute session cut (`SessionMaxSec` 2700); merged, K1 was estimated at 36 min.
3. **K2 (a and b), two starts each:** R05, R07, R08, R10 (1 mouse, R08, 11.6 min) then R09 (1 mouse, its own double-click settings, 11.0 min).
4. **K3 (a and b), four starts each:** R14h_dstd_200 3.3, R14h_both_200 3.3, R16 5.3, R14h_pipekey_200 6.5 min; 0 mouse.
5. **K4 (a and b), two starts each:** R34 2.0, then R34s, R34sn, R34so 6.6 min; 0 mouse.
6. **V1:** a = R33m, R36e_p2, R36e_p3, R36e_p4 (3.6 min) then R34s_OFF_BROKEN, R34so_OFF_BROKEN (7.2 min); b = the four main cases only (6.7 min); 0 mouse.
7. **C1 (once), four starts:** C33m 1.6, C34 1.9, C36e 1.5, C32 8.8 min; 0 mouse.
8. **D1:** a = N32_BROKEN 2.2, N31_BROKEN 5.2, N31 10.3 min (three starts); b = N31 10.3 min; 0 mouse.
9. **D2 (a and b):** N32; 1 mouse; about 14.3 min each.
10. **D3:** a = N33_BROKEN, N33, N34_BROKEN (18.5 min) then N34 (9.3 min); b = N33 7.2, N34 9.3 min; 0 mouse.

**Totals (estimates from measured medians: start 33 s, quit and clean end 21 s, line-up 241 s, 8 s per case, chain overhead 16 s; draft case times estimated):**
1. **Today's specs and today's style:** 44 starts, 8 line-ups, about 383 min with the 180 s gap. That is spec3 for set (i) (14 starts, about 154 min). For sets (ii) and (iii) it is `spec_baseline_ii.txt` (18 starts, 122 min) and `spec_baseline_iii.txt` (12 starts, 107 min). Both are my reconstruction of how the desk writes such specs, because no spec exists yet for (ii) and (iii).
2. **Step 1 only (same specs, 30 s gap):** about 298 min.
3. **Step 2 only (grouped plan, 180 s gap):** 37 starts, 8 line-ups, about 312 min.
4. **Both:** about 264 min. **Saving about 119 min (31 percent) on this list.** Set (i) alone: 154 to 119 min with the short gap.

**Where step 2's saving comes from (honest):** 7 fewer AutoCAD starts and fewer chain gaps, NOT fewer line-ups.
1. N24 and R36e ride in the R01 start.
2. The four R36e cases share one start with R33m.
3. Twins and controls run once.
4. Groups with different SETTING lines go in one runner call, so they follow each other with no chain gap. Inside one call the runner never had the 3 minutes.

The 8 line-ups are the minimum here: R01 (fresh drawing), R08 (launch drawing), R09 (launch drawing with its own settings) and N32 (a draft in another folder) can never share a start under today's runner.

**Rule for the next full regrade (not a file; the cases are not in tonight's list):** the mouse cases N05, N20, N25 and R01 all use DRV1_B1, slot fresh and no SETTING line. In the 3.0.85 regrade specs they sat in four different lines (`c75run\spec_p2_1` X2, `spec_p2_2` X10, `spec_p2_3` X4 and X5), so each pass paid 4 line-ups. One line, for example `aM|cases|N05,N20,N25,R01` plus up to four non-mouse fresh cases, pays 1. That is 6 fewer line-ups, about 24 min per full regrade (estimate). This is the pit label, pipe label on a leader and pit-until-Esc example in the FOR TIM block. Possible later (needs the runner owner, not staged): let one runner call take several folders, so draft N32 could join the R01 start. That would save 2 more line-ups and 2 starts, about 11 min.

### 7. Go-live steps (for the desk, after 17:30, Tim's AutoCAD closed; not done here)

1. **Order:** the 29 Oct staged case apply first (both sets, one apply), then this.
2. **Copy:** `wait_safe_to_start.ps1` to `C:\Lisp Files\_ACAD_DRIVER\` (new file). Copy staged `chain3.ps1` into the next regrade chain folder, keeping `chain3.ps1.pre` beside it. Copy live `chain_robot_standing.ps1` to `chain_robot_standing.ps1.pre` in `desk_jobs`, then the staged copy over it. Only while the standing chain is stopped: PowerShell reads a script when it starts, so the running chain keeps the old text until restarted.
3. **Test run 1 (test drawing):** a two-line spec, for example `aT|cases|N24` and `bT|cases|N24` (short, no mouse). Expect `T gap: safe-to-start: all clear at 0, 10 and 30 s: short wait (30 s)` in the progress file, both sessions clean, fingerprints unchanged. Also note the "licensing agent processes still running" number.
4. **Test run 2:** the same, with `STOP_CODEX.flag` holding the text `install hold test`. Expect `full wait (180 s) because: ... STOP_CODEX.flag holds an install hold`. Then delete that flag (only if this job wrote it).
5. **Then:** run `spec_grouped.txt` with the staged chain3 (`-SpecFile C:\ce-fx\speed\staged\spec_grouped.txt`, StopFirst no later than 07:30 because the longest line is about 30 min).
6. **Undo (one line):** `Copy-Item C:\CE_PLAN\desk_jobs\chain_robot_standing.ps1.pre C:\CE_PLAN\desk_jobs\chain_robot_standing.ps1 -Force; Remove-Item 'C:\Lisp Files\_ACAD_DRIVER\wait_safe_to_start.ps1'` (chain3 copies are per job: use `chain3.ps1.pre`).

### 8. What I did NOT verify (RULES 5.9)

1. **Nothing ran in AutoCAD, the runner or the driver.** The 30 s short path has never been seen on the real PC; the two test runs above are what proves it.
2. **Whether 30 s is long enough for everything AutoCAD does after acad.exe exits.** `AdskLicensingAgent` (two processes) starts with AutoCAD (seen 09:14 today). Whether it outlives AutoCAD and writes anything is unknown. The function records its count at every short wait so the test runs answer it; it does not block on it.
3. **The race between the install chain's lock claim (written without the driver's mutex) and a runner taking the lock.** It already exists at the end of every 180 s gap today. It is not made wider while an install chain is running (full wait). The final guard is the install script's own two readings 60 s apart. Not tested.
4. **Process command lines** read through `Get-CimInstance Win32_Process` are assumed visible for jobs of the same Windows user; not tested on a live install.
5. **Minutes:** medians from past runs; the 8 batch-4 draft cases and R34so_OFF_BROKEN have never run, so their minutes are estimates from step counts. Real nights include stalls (four over 20 min in the audit) that no estimate covers.
6. **The baselines for sets (ii) and (iii)** are my reconstruction of today's spec style, not a spec anyone wrote.
7. **The plan assumes the two staged case sets are applied first;** the R36e ruling status was not re-checked. If R36e is still held, delete R36e and R36e_p2 to p4 from K1 and V1 and C36e from C1 (no start count changes except C1 loses one).
8. **The runner's stale expected fingerprint** for `CE_STRUC_SUITE\CS_Settings.json` (2972CE70C514 against B3B5A004B929 every run) was found, not fixed.
9. Older one-off chains (c75regrade2, c75run, b1225_regrade, robot_n03n04) were not staged.

## Summary

Steps 1 and 2 are staged in `C:\ce-fx\speed\staged\`; nothing live changed. The shared wait gives 30 seconds only when AutoCAD, the lock, the settings guard and fingerprints, the last session record and every install job are clear; otherwise today's 3 minutes. The offline test passed 25 of 25 twice, and a sabotaged copy failed as it should. Grouping cuts tonight's list from 44 to 37 AutoCAD starts. Its 8 mouse line-ups are already the minimum. Both steps: about 6 h 25 min down to about 4 h 25 min (estimate). Go-live needs two test-drawing runs after 5:30 pm.
