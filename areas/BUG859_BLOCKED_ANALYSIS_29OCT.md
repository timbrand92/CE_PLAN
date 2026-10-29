# BUG-859 proofs BLOCKED "AutoCAD busy" on Civil 3.0.86: why

CE_ACAD / robot / review / 30. Claude Team (Opus), read-only analysis, Thu 29 Oct 2026, 20:05 to 20:20 Melbourne time.
Nothing was started in AutoCAD; no driver, runner, case, review, ledger, desk log or carpark file was edited.

## ANSWER FIRST

**It is (c), a robot fault, not the fix.** In all four blocked runs the double-click never happened. AutoCAD was already stuck before the case's first step, because the robot's start-of-session pointer check could not bring AutoCAD to the front and left AutoCAD's ID command waiting for a point. **The fix works:** the robot's next R09s run (RUN-20261029-2000-C3.0.86-b80R09s, 20:00 to 20:15) calibrated normally and PASSED all 11 checks.

## FOR TIM

1. **The fix works on Civil 3.0.86:** at 20:14 the robot double-clicked the DP1 downpipe circle. CE's Edit source window opened with DP1 in its tag box, and AutoCAD's attribute editor never appeared, not even 10 s later. One clean pass so far; the rule needs a second pass in a new AutoCAD start before it counts as ready.
2. **Why the four runs before it said "AutoCAD busy":** before each pointer test the robot does a quick "aim check": it types ID and clicks nine spots on an empty part of the drawing. In those four runs, Windows would not let AutoCAD come to the front. The robot had already typed ID, so AutoCAD sat at "Specify point" and refused everything the robot asked after that.
3. **The double-click was never tried in those four runs:** CE's log has no double-click lines at all in them, and the downpipe was never placed.
4. **It is not CE's Edit source window, and not the new switches:** the passing run used exactly the R09s settings. The same "AutoCAD busy" also happened on 24 Oct, in a plain-line test that has nothing to do with double-clicks.
5. **One small thing to know (not tested by R09s):** after the double-click, AutoCAD's command line showed one stray line, `Unknown command "904072,2998.945877,-5729.000000"`. AutoCAD's double-click sends the click point after the editor command. CE stops the editor, so the leftover point lands on the empty command prompt. Nothing in the drawing changes; it is only noise on the command line. The desk should decide whether it goes in the carpark.
6. **Next step for the robot (no action for you):** a two-line robot change is ready to look at, on copies only. It brings AutoCAD to the front before typing ID, and tries the aim check once more if the first one fails. Nothing live was changed.
7. **R09s itself needs no change.** All its unproven control names (tag box, Cancel, OK, the title-bar Close) were read correctly in the passing run.

---

## Evidence

1. **The step that failed was step 1, a COM setvar, before any pointer action.** All four runs: `v3 setvar PICKFIRST 1` → "BUSY: AutoCAD did not accept a COM call for 60 s ... RPC_E_CALL_REJECTED". Runs: RUN-20261029-1756-C3.0.86-a80R09 (R09), RUN-20261029-1811-C3.0.86-a80R09s (R09s, 163 s), RUN-20261029-1833-C3.0.86-a80C09n (R09S_NEW_SWITCH_OFF_BROKEN), RUN-20261029-1948-C3.0.86-b80R09 (R09). Each case has exactly 1 step recorded; no assertion ran.
2. **Each of those four sessions failed calibration with the same reason, before the case began.** Session calibration `why` = "centre : the click failed: AutoCAD would not come to the front (not_foreground). Nothing was clicked." The two sessions that ran their case (a80T09 R09_OFF_BROKEN, a80C09c R09S_COMPOUND_OFF_BROKEN) both have calibration ok=True. The match is exact: calibration failed means step 1 BUSY; calibration passed means step 1 ok.
3. **How calibration leaves AutoCAD stuck** (`_ACAD_DRIVER\acad_driver_v3_session.ps1`, SHA 9A7B8D210C7F, the file the runs used). `Measure-V3PointRaw` types `_.ID` first, waits for "Specify point", and only then calls `pt-click`. `pt-click` calls `BringToFront`, which returns `not_foreground`. The driver then refuses: "AutoCAD would not come to the front ... Nothing was clicked" (acad_driver_v3.ps1 line 983). The clean-up `esc-prompt` and `esc-key` need the keyboard, so they are refused for the same reason (line 1055, "No key was sent"). So `_.ID` stays at its prompt. AutoCAD rejects outside COM calls while a command waits for a point; `Wait-V3PromptText` relies on exactly this ("a command waiting for a point shows as AutoCAD refuses COM").
4. **What "AutoCAD busy" means in the runner.** `Invoke-V3ComRetry` (acad_driver_v3.ps1, around line 452) retries a "call rejected" COM call for `$script:ComBusyMaxSec` (60 s), then throws "BUSY: ...". `Invoke-CaseStepList` (case_runner.ps1 line 88) maps any "BUSY:" message to BLOCKED "AutoCAD busy". A modal window with AutoCAD's frame disabled would have read `frame_disabled`, not `not_foreground`. Here the frame was enabled.
5. **Everything after fits a waiting ID command.** Four tidy-up Esc attempts were all ok=False. Quit attempt 2 was refused with "AutoCAD is busy (a command is active) ... no drawing has been seen yet by this driver". Quit needed `-Kill` in three of the four sessions. The CE log shows 0 new lines while the case ran.
6. **CE's own log shows nothing happened after the drawing opened** (structured log `ce_cvl_structured_20261029.log`, read with shared access). In each blocked session the last CE lines are the project-data load and the QA idle pass (18:12:05 for R09s, 17:57:28, 18:34:39, 19:49:25). Then nothing until AutoCAD is closed. There is no "double-click hit-test", no "EATTEDIT", no "TryRedirectToCdEdit", no "Command outcome: DP". In the passing sessions, "[REDO] first Inspector pick" and "Command outcome: DP completed" follow. One more sign that AutoCAD was not the active window from the start: in the blocked sessions CE's first idle pass came about 5 s after the drawing loaded, against about 1.3 s in the sessions that worked.
7. **Same fault, older build, unrelated case.** RUN-20261024-1825-C3.0.74-k1D1 (R08c_D_plainline, a plain line test, Civil 3.0.74): the session calibration failed with not_foreground, then step 1 `v3 setvar PICKFIRST 1` BUSY 61 s, then BLOCKED "AutoCAD busy". The signature is identical. `not_foreground` also appears in RUN-20261024-0522 p3b1x3a, RUN-20261024-1646 n3 and RUN-20261026-0706 b4c2.
8. **The switch link is ruled out by the run in progress.** The four blocked sessions all had `doubleClick.sourceEditWindow` ON and `options.compoundBehaviorEnabled` ON; the two that worked had one of them OFF. But the robot's current session (RUN-20261029-2000-C3.0.86-b80R09s; AutoCAD started 20:06:18) has CD_Settings.json `doubleClick` = {opensEditWindow false, sourceEditWindow true} and compound ON, the R09s settings. Its AutoCAD command-line log shows all nine `_.ID` calibration points and the corrected points answered. Also, the new code in 3.0.86 cannot take the foreground at start-up: `OnDocumentLockModeChanged` returns at its first line unless the command is the attribute editor. The command-line log shows no EATTEDIT before the case.

## The CE Edit source window (part b of the question)

1. **It is modal.** SourceTagCommand.cs line 237 at 5888ee75: `DialogService.ShowDialog(window)`. While it is open, outside COM calls will be rejected, just as with any waiting command.
2. **R09s already avoids COM while the window is up.** After `v3 pt-dblclick`, the steps are `sleep`, `ui-dump`, `windows-new`, `ui-press`, `close-windows`, `windows-snapshot`. These are UI Automation and Win32 window reads (case_runner_lib.ps1 lines 345 to 390), not COM. The assertions come later: log-file reads and the `history` read after the window is closed. The same route read AutoCAD's own modal Enhanced Attribute Editor on 3.0.84 (runs aR09 and bR09: FAIL "'Edit source' is NOT in: Enhanced Attribute Editor"). So (b) is not the cause, and no driver-side route is missing.
3. **Still unproven in R09s, from its own NOT_AUTOMATED line:** the AutomationIds `SourceEdit.Tag`, `SourceEdit.Cancel` and `SourceEdit.OK`, and whether the title-bar `Close` can be pressed. These come from the XAML and have not been seen on a run. If only those checks fail while the log and window-list checks pass, the fix works and the case text needs that one correction.

## Is the fix OK or at risk?

**It is OK on one session.** RUN-20261029-2000-C3.0.86-b80R09s: R09s PASS, 11 of 11 checks, 99 s. Calibration was ok (1.912 px raw, 0.5 px corrected), the end was clean, and the v3 session driver was the same file (9A7B8D210C7F). The CE structured log, in order:
1. 20:14:20.299 "double-click hit-test: 1 block(s) under the pointer; source tag = DP1"
2. 20:14:20.301 "EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-859, doubleClick.sourceStopsAttributeEditorFirst); source DP1"
3. 20:14:20.301 "target registered; CDEDIT scheduled at Idle"
4. 20:14:20.369 "starting CDEDIT in command context"
5. 20:14:39.332 "Command outcome: CDEDIT completed 18961 ms"

The window list held only "Creative Engineering | Edit source". `SourceEdit.Tag` read DP1, and `SourceEdit.Cancel` and `SourceEdit.OK` were present. The title-bar Close closed the window, and the command line said "[CE] Nothing was changed."

**Still needed for ACCEPTED-READY:** a second passing AutoCAD session on this build, plus the independent R09s review file. The red-before-green controls have run: R09_OFF_BROKEN (FAIL as designed, "EATTEDIT left to AutoCAD: the double-click switch reads OFF", 18:28:30) and R09S_COMPOUND_OFF_BROKEN (FAIL as designed, "EATTEDIT left to AutoCAD: the compound-behaviour setting does not let CE inspect it", 18:51:29). R09S_NEW_SWITCH_OFF_BROKEN is still owed: it was one of the four blocked by the robot fault, so it needs a re-run.

**Side effect seen, not asserted by any case:** AutoCAD's command line after the refused `_eattedit` reads `Command: 3073.904072,2998.945877,-5729.000000 Unknown command "904072,2998.945877,-5729.000000".` Then two `*Cancel*` lines, then CDEDIT. AutoCAD's double-click macro feeds the pick point after the command; with EATTEDIT refused at its lock, the point reaches the bare Command prompt. Nothing is drawn or changed. A drafter sees one red-herring line. This is for the desk to log or ignore; I did not edit BUG_CARPARK.

## The change that lets R09s PASS (copies only: `C:\ce-fx\bug859\`)

No case change. The fault is in the session start, so the change is in the robot's calibration. There are two lines in `acad_driver_v3_session.ps1`: `acad_driver_v3_session.ORIGINAL.ps1` (SHA 9A7B8D210C7F, as used by the runs), `acad_driver_v3_session.PROPOSED.ps1`, and `runner_change.diff`. The proposed copy parses with 0 errors; it has not been run.

1. **In `Measure-V3PointRaw`, before `_.ID` is typed:** bring AutoCAD to the front, with up to 3 tries 2 s apart. If it still will not come forward, throw without typing anything. AutoCAD stays idle, and the message names the process and title of the window that was in front.
2. **At session start:** if calibration failed for "come to the front", wait 20 s and calibrate once more ("second try"). Before change 1 a second try was useless, because `_.ID` was still waiting.

```diff
-        if (-not $NoCalibrate) { $cal = Invoke-V3Calibrate $ctx; $rep.calibration = $cal }
+        if (-not $NoCalibrate) { $cal = Invoke-V3Calibrate $ctx; if (-not $cal.ok -and [string]$cal.why -match 'come to the front') { Start-Sleep -Seconds 20; $cal = Invoke-V3Calibrate $ctx 'session start, second try (AutoCAD was not in front)' }; $rep.calibration = $cal }
...
     $xs = $x.ToString('F4', $inv); $ys = $y.ToString('F4', $inv)
+    $fr0 = Get-V3Frame; $fg0 = ''; for ($t0 = 0; $t0 -lt 3 -and $fg0 -ne 'ok'; $t0++) { if ($t0) { Start-Sleep -Seconds 2 }; $fg0 = [V3Native]::BringToFront([int64]$fr0.Hwnd, [int]$fr0.ProcId) }; if ($fg0 -ne 'ok') { ...; throw "$Label : AutoCAD would not come to the front ($fg0) after 3 tries; _.ID was NOT typed, AutoCAD stays idle. Window in front: ..." }
     $tid = Invoke-V2Type2 '_.ID' @('-Force')
```

R09s has already passed without this change, so the change is not needed for that one PASS. It is needed so that the next pointer session that loses the front does not burn 3 to 7 minutes and read as "AutoCAD busy".

What it buys:
1. **If the foreground loss is brief** (the likely case, since the same settings calibrated fine at 20:06), the retry lets calibration pass and the case runs its real checks.
2. **If it is not brief,** the session reads BLOCKED "not calibrated" with the real reason and the window that held the front, AutoCAD is left idle, and quit is clean (no `-Kill`). The case no longer reads a false "AutoCAD busy" as if CE caused it.

This is a driver file under the robot owner's control. It goes in only through the usual driver review and self-test (driver_v2_selftest / v3_selftest), and not while a pass is running.

## Probe still open: what took the front (run later, in a free AutoCAD window)

Which window held the front in the four blocked sessions was never recorded. The proposed change 1 records it on the next failure. Until then, there are two likely causes:
1. **Another top-level window took the front at AutoCAD start-up.** Examples: a Windows or Defender notification, an AutoCAD or Autodesk start-up pop-up, or a robot console window.
2. **Windows refused the robot's foreground request.** The foreground lock refuses it if the window in front belongs to an elevated (administrator) process; the AttachThreadInput trick cannot cross that line.

One-line probe, run straight after a session whose calibration says not_foreground (read only):
`Add-Type -Name F -Namespace P -MemberDefinition '[DllImport("user32.dll")] public static extern System.IntPtr GetForegroundWindow(); [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(System.IntPtr h, out uint p);'; $p=0; [void][P.F]::GetWindowThreadProcessId([P.F]::GetForegroundWindow(),[ref]$p); Get-Process -Id $p | Select-Object Id,ProcessName,MainWindowTitle`
1. If it names a non-AutoCAD process, the cause is 1.
2. If that process is elevated (its path cannot be read without administrator rights), the cause is 2.

## What I did NOT verify

1. **The window that held the front** in the four blocked sessions: not recorded anywhere, so unknown.
2. **The passing run's pictures and JSON:** I read its .md report (first 40 lines), the CE structured log and AutoCAD's command-line log. I did not open its JSON or pictures, and I did not judge the window's looks.
3. **The proposed driver lines were not run;** only a parse check was done. The `MainWindowHandle` lookup names only a window that is some process's main window.
4. **AutoCAD's own logs of the blocked sessions:** the robot session folders under pack_runs are empty and the old AutoCAD command-line logs are gone, so the stuck `_.ID` prompt is inferred from code and symptoms, not read from those sessions' AutoCAD logs.
5. **The fix beyond R09s's scope:** a second session, the red centre, the angled DP text, the BUG-860 green label, OK saving a changed tag, Undo after the refused EATTEDIT, and the new-switch-off control (R09S_NEW_SWITCH_OFF_BROKEN, blocked tonight).
6. **The stray "Unknown command" line:** seen once, in one run. I did not check whether it also appears with the switch off, or on other blocks.

## Summary (under 100 words)

The four BUG-859 runs on Civil 3.0.86 were BLOCKED "AutoCAD busy" by a robot fault, not by the fix. The aim check typed ID, then could not bring AutoCAD to the front, so ID sat waiting and AutoCAD refused every later robot call. No double-click happened. The next R09s run (20:00 to 20:15) calibrated normally and PASSED 11 of 11: AutoCAD's attribute editor was stopped and CE's Edit source window opened with DP1. A second session is still needed. One stray "Unknown command" line was seen. A two-line driver fix is on copies only.
