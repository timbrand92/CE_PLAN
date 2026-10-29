# C-76 night cases: independent design review before they run (Thu 29 Oct 2026)

Job `CE_ACAD / robot / review / 26` (CE 02 Robot and Codex Testing, Team, Opus, headless). Real clock 16:26 to about 16:45 Melbourne.
Tim's AutoCAD was open and in use and was not touched: no AutoCAD start, no run or run-pack, no driver call, no settings guard, no lock
(AutoCAD count 1 before and 1 after the one offline format check). Source read with `git show` / `git grep` only at
`origin/claude/rel-20261029a` = `5888ee75` "Version: Civil 3.0.86 / Manager 1.1.86 (C-76)" (nothing checked out).
Method: `release-v3-colleagues-OPUS_CASE_REVIEW_B8_29OCT.md` and `CODEX_CASE_REVIEW_cx_cr25.md`. N32 and N33 were reviewed by a second Opus
reviewer (read-only); I spot-checked its main claims against the files and the source.

## FOR TIM

1. **The night run can go ahead.** All 10 new checks were read line by line against the product and the robot. None is WRONG.
2. **One fix made, to the double-click checks (R09s and its two twins).**
   1. **What was wrong:** the robot listed the open windows only 3 seconds after the double-click. CE's Edit source window can take longer to open the first time in a fresh AutoCAD.
   2. **What that would cost:** a working fix reported as a failure, and one of the two passing runs lost for the night.
   3. **What I changed:** the window list is now read after the robot has waited up to 10 seconds for the Edit source window. No check was removed or loosened.
3. **Everything else is SOUND as written:** the CDCHECK words twin, the downpipe speed check and its control, and the batch-4 layer and schedule checks.
4. **Two things only the run can show.**
   1. **Downpipe speed:** the first drawing read on a fresh copy might still take more than 1.5 s, even with the fix. That would be a real product result (the fix report itself says it is not measured), not a broken check.
   2. **Double-click:** whether AutoCAD obeys CE's "stop" for its own attribute editor. That is the point of the test.
5. **What you need to do: nothing.**

---

## Detail

### 1. Verdicts per case

1. **R09s_dp1_double_click_stops_editor_first: NEEDS FIX, applied** (lines 48 and 49 swapped, so the window list is read after the dump wait; comment added at line 9). Everything else SOUND:
   1. **Log lines exist verbatim:** "TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened ..." (`Rules/DoubleClickAttributeEditorStopRule.cs` `StoppedLogLine`, written by `Serilog.Log.Information("{Line:l}", ...)` in `Services/CompoundEditModeService.cs` `OnDocumentLockModeChanged`), then "TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle". The check text "EATTEDIT stopped before AutoCAD" avoids the apostrophe. Both go to the structured log (runner key `civilx`), as R09's existing check proved on 3.0.78.
   2. **Window and control names:** title "Creative Engineering | Edit source" (`Dialogs/SourceEditDialog.xaml` line 4). `ui-dump "Edit source"` is a regex on the title and the window is on the read list through `Creative Engineering*` (the `Edit source*` entry never matches). AutomationIds `SourceEdit.Tag` (a TextBox, so it has a value), `SourceEdit.Cancel`, `SourceEdit.OK`; the runner's `control` check matches name OR id (`case_runner_lib.ps1` line 473).
   3. **The Close press:** the window uses the normal Windows title bar (BaseWindowStyle only sets a dark title bar; no custom chrome) and has no body button called Close. Past runs saw a title-bar "Close" found as a second button on About CE Suite and the Checks window ("'Close' is ambiguous (2 buttons)"), so the runner does find title-bar Close buttons; here it is the only one, so it is not ambiguous. Still DERIVED until the run: nobody has pressed it on this window.
   4. **Verbs** (`ms-count`, `ms-new`, `select`, `field`, `ent-part`, `v3 pt-dblclick`, `windows-snapshot`, `windows-new`, `ui-dump`, `ui-press`, `close-windows`, `history-tail`) all exist with these shapes; the route is R09's, which ran on 3.0.75 to 3.0.85.
   5. **Settings:** `doubleClick.sourceEditWindow`, `doubleClick.opensEditWindow` (group `doubleClick`, `Models/UserSettings.cs` line 189; keys in `Models/DoubleClickSettings.cs`). The new switch is left at its default ON on purpose (it is the shipped default being proved).
2. **R09s_new_switch_off_broken: NEEDS FIX, applied** (the same swap, lines 46 and 47; comment line 7). Otherwise SOUND:
   1. Key `doubleClick.sourceStopsAttributeEditorFirst` exact (`DoubleClickSettings.cs` line 51, default true).
   2. With it OFF the handler logs "EATTEDIT left to start: doubleClick.sourceStopsAttributeEditorFirst reads OFF" and returns; it fails on CHECKS (the "stopped" line, the window checks), every step is optional so no step can abort it. It is EXPECT-FAIL, so the runner never re-runs it.
   3. Note, not a fix: on the old path CE's own Edit source window used to open 21 to 37 s after AutoCAD's editor was closed. If it opens after the case's last close-windows, the session end clean-up closes it (title-bar Close). It runs alone in its start, so no other case is affected.
3. **R09s_compound_off_broken: NEEDS FIX, applied** (the same swap; comment line 7). Otherwise SOUND: `options.compoundBehaviorEnabled` exact (`OptionSettings`, `UserSettings.cs` line 1812); the handler returns before any drawing read when it is OFF (the C-76 finalizer lines), so it fails on checks.
4. **R22_off_broken: SOUND.** Key `checks.cdcheckLinesShowNoInternalIds` exact (`ChecksSettings`, line 3320, default ON). `SpineCheckCommand.cs` reads it once per CDCHECK and passes it to `RowText` and to the FALL-arrow and pipe-end lines (`withoutHandles: noInternalIds`); OFF prints the C-75 text, which R22 caught on 3.0.85. Check 1 ([CE] CDCHECK:) still passes, so the red is the wording.
5. **N36_dp_time_under_budget: SOUND.**
   1. **Text formats exact:** `SourceLandingSpeedRule.TimingLine` writes "[BUG-1228] <what> in <N> ms[ (<outcome>)]: ... reads each object once: on|off." with the number in invariant culture (no thousands comma, so the regex cannot be fooled by "1,500"). The callers name "Source landing index read" and "Source change read". The real CE log shows the DP line as "Command outcome: DP completed 30143 ms" (read today), and DP marks itself done (`PlacementContinuationService.ContinueAfterPlacement` calls `NoteDone`), so an Esc end reads "completed".
   2. **Regexes re-tested by me** (`C:\ce-fx\c76review\rx.ps1`, lines joined with " | " as the runner joins them): 6 of 6 timing samples right (1499 and 999 pass; 1500, 5123 refused and 15000 fail; a slow line that is not a landing read is ignored); DP 9999 passes, 10000, 30143, "(time unknown)" and "cancelled" fail.
   3. **Not vacuous:** the negative regex alone would pass on an empty log, but the four `log civil has/absent` checks fail first in that case.
   4. Route and block-name filter are N04's and N13's (accepted / run).
6. **N36_dp_time_under_budget_BROKEN: SOUND.** `linking.sourceLandingReadsEachObjectOnce` exact (`LinkingSettings`, line 648). The timing line is still written with the speed-up OFF (it prints `context.PitWalk.On`, so "off"), so the red comes from checks ("on" missing, "off" present, slow reads, DP over 10 s), while the placement checks still pass.
7. **N32_every_new_object_on_its_office_layer: SOUND** (second reviewer). Layer names from `LayerService.cs`; "Pit placed successfully." (`PitCommand.cs` line 590) and "Flow: P8 -> Open end" (`CdCommand.cs` line 808) exist; cx_cr25 amendments all present; nothing it touches changed between 3.0.85 and 3.0.86.
8. **N32_BROKEN: SOUND.** `layerNames.names.20TEXT CETWIN20TEXT` reaches CE's layer-name rule. **Desk trap:** credit the red only if line 28 (`equals $ill "20TEXT | 20TEXT"`) is the failing check and line 29 (`equals $ill "CETWIN20TEXT | CETWIN20TEXT"`) passes; if line 29 fails, CE ignored the rename and the red is for the wrong reason.
9. **N33_schedule_groups_lpd_og_p_cp_then_rest: SOUND.** `linking.pitScheduleNaturalOrder` exact (line 885, default false = Tim's value). Expected order LPD, OG, P1 to P10, CP2, CP10, C1 follows `PitIdComparer` (legacy compare). Optional comment-only wording: line 1 says it "runs in its own guarded session"; in fact N33 and N33_BROKEN share one start (same fixture, slot and SETTING), each on a fresh drawing. Not changed (comment only, no effect on the run).
10. **N33_BROKEN: SOUND.** Its presence checks (lines 70 and 71) come before the reversed-order check (line 72), so a missing pit fails visibly for the wrong reason, not silently.

### 2. The spec (`C:\ce-fx\c75regrade3\spec_c76.txt`, SHA-256 `39dd7a7257e2`, not changed)

1. **Name matching:** `-Only` takes the exact file name, or a prefix plus "_" only for a file that does not end `_broken` (`case_runner.ps1` line 429). So `R09s` picks only the main R09s file, `N36_dp_time_under_budget` does not pick its `_BROKEN` twin, and `N32_...`/`N33_...` in `b80K1` pick only the main cases.
2. **Grouping:** one AutoCAD start per fixture + slot + SETTING text (line 379). `a80D` gives three starts (N36, N36_BROKEN, R22_off_broken); `a80K1` gives three (N32; N32_BROKEN; N33 then N33_BROKEN, which share the same SETTING). No twin shares a start with its main case under a different setting.
3. **Order is safe:** each main case runs before its twin (`a80R09s` before `a80C09n`/`a80C09c`; N36 before N36_BROKEN; R22 twin in `a80D` before `a80R22`, which is harmless because settings are put back by hash at every session end and set again before each launch).
4. **Twins run:** they sit directly in the folders named, so no `-IncludeVariants` is needed. `chain3.ps1` passes `-NoRerun`, so any single re-run is the desk job's, as its job file says.
5. **The spec's SHA-256 differs from the proof plan's** (`D43DF0AB...`): the 16:10 reorder that added `a80K1`/`b80K1` is recorded in the spec's own comment line. Expected.

### 3. Edits made (backups beside each file as `<name>.case.txt.pre_review`)

1. `R09s_dp1_double_click_stops_editor_first.case.txt`: SHA-256 `f79060475067` before, `22a1f00846ea` after.
2. `R09s_new_switch_off_broken.case.txt`: `e42a64bd6c9f` before, `0dbdcd01c45f` after.
3. `R09s_compound_off_broken.case.txt`: `25c12ea46e1c` before, `5ba73d0df221` after.
4. Unchanged: N36 `98209e977450`, N36_BROKEN `27c84f954bd3`, R22_off_broken `bacb1eb2e401`, N32 `c2ad8deb2229`, N32_BROKEN `1c2329b0493f`, N33 `f013f6476293`, N33_BROKEN `2a2f034ea688`, spec `39dd7a7257e2`.
5. **The same diff in all three files** (shown for the main case; the twins differ only in line numbers 7 and 46 to 47):

```diff
@@ -6,6 +6,7 @@
 # Pointer case: moves the real mouse, so it runs FIRST and ALONE in its own AutoCAD start, only outside Tim's hours and only while nobody is using the PC.
+# Design review 29 Oct 2026 (robot/review/26): the window list (windows-new) is now read AFTER the ui-dump wait (up to 10 s), not at 3 s, so a CE window that is slow to open the first time in a fresh AutoCAD is not a false red. No check was removed or loosened; the Enhanced Attribute Editor checks now cover a longer time.
 CASE R09s
@@ -45,8 +46,8 @@
   v3 pt-dblclick "ent {$dp}" -Part "{$part}" -> $dc
   sleep 3
-  windows-new $w0 -> $opened
   ui-dump "Edit source" -Optional -TimeoutSec 10 -> $es
+  windows-new $w0 -> $opened
   ui-press "Edit source" "Close" -Optional -> $esc
```

6. **Why the twins changed too:** a twin must be the same route as its main case, or its red proves nothing about the main case. In the twins AutoCAD's editor stays open until the following close-windows, so the later window list still holds it and they still fail on checks.
7. **Offline format check** (I read `case_runner.ps1`: `validate` only calls `Read-CaseFile` and `Test-CaseFile`; the driver is loaded with `-Library`, which runs nothing, line 1154): "6 file(s) checked, 0 invalid", exit 0, the same step and check counts as before (R09s 27 steps, 14 checks; twins 28 and 14; N36 9 and 13; R22_off_broken 4 and 7). AutoCAD count 1 before, 1 after.

### 4. What I did NOT verify

1. **Nothing ran in AutoCAD.** Every verdict is from the source, the runner text and earlier run logs.
2. **DERIVED, not seen:** the title-bar Close press on the Edit source window; the tag box reading exactly "DP1"; that AutoCAD honours CE's veto of its attribute editor; that a new key such as `linking.sourceLandingTimingLog` (not in Tim's file today) is written by a SETTING line and read by CE.
3. **Whether the first landing read on a fresh copy is under 1.5 s** with the fix: the 28 Oct evidence shows about 5 s per read, and the fix report says the new time is not measured. A FAIL on that one check is product evidence, not a case fault.
4. **N32 and N33** were reviewed by the second reviewer; I re-checked the SETTING lines, the switch default, the N32_BROKEN control lines and the N33_BROKEN order of checks, not every source line it quoted.
5. **I did not re-check the allow-list pin** or the driver self-tests, and did not edit the optional N33 comment wording.

## Summary

Ten new C-76 night cases reviewed against the 3.0.86 source and the runner. Nine are sound as written. The R09s double-click family had one timing weakness: the window list was taken 3 s after the double-click, before the wait for CE's window. I fixed all three files (backups kept, hashes recorded), and the format check passes 6 of 6. N36's time patterns re-tested 11 of 11 right. N32 and N33 are sound, with one desk trap noted for N32_BROKEN. Nothing ran in AutoCAD.
