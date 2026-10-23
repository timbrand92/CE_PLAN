# Opus review of fix wave 2, batches 4 and 5 (23 Oct 2026)

Fri 23 Oct about 12:15 to 12:45 (real clock, Melbourne). Opus 5.5 (claude-opus-5-5), read only: git and gh reads and `git merge-tree` dry runs (objects only, no refs). No build, no test run, no AutoCAD, no Codex, no PR comment or merge. Method as `REVIEW_CODEX_PRS_A_2026-10-23.md`. I read every diff myself, not just the batch reports, plus the code around each change.

Inputs: `release-v3-colleagues-FIX_WAVE2_BATCH4_REPORT.md`, `...BATCH5_REPORT.md`, the BUG-892, 957, 987, 999, 947, 969, 1004, 1011, 1017 and 1019 entries in `BUG_CARPARK.md` (ledger F-032, F-141, F-178, F-196, F-123, F-159, F-201, F-209, F-219, F-224).

## Two corrections to the brief (checked, not assumed)

1. **The installed build is no longer 3.0.70.** I read the live bundle DLLs at 12:30: Civil `3.0.71+88bd62f7`, Manager `1.1.71+88bd62f7`. That is C-61 (`claude/rel-20261023l` @ 88bd62f7). All ten PRs sit on the older C-60 line (`claude/rel-20261022m` @ 40ee0a36, 0 commits behind it). They can only ship in **C-62**, on top of C-61.
2. **Four of the ten bugs were built twice.** Team lane build/03 (run 417, 09:22 to 12:27) built BUG-947, 969, 1004 and 1019 again, off C-61, at the same time as batch 5. The rival PRs are #1632, #1630, #1624 and #1622. Merging both of any pair breaks the train. I compared each pair and name ONE to keep below.

## ANSWER FIRST

1. **#1609 BUG-892, Inspector zero count (498f0f7a):** MERGE. 0 HIGH, 0 MEDIUM, 2 LOW.
2. **#1610 BUG-957, Enter in Settings search (78a2303f):** MERGE. 0 HIGH, 0 MEDIUM, 1 LOW.
3. **#1611 BUG-987, CDSYNC pit swap (5ca3f08f):** MERGE. 0 HIGH, 1 MEDIUM (distance still 200 drawing units: Tim's call, not a blocker), 2 LOW.
4. **#1612 BUG-1011, typed Depth (27b35e16):** MERGE-WITH-FIXES. 0 HIGH, 2 MEDIUM, 1 LOW. The promised status line is overwritten, and a row that is already waiting still loses the depth.
5. **#1613 BUG-1017, Manager buttons into a running command (f514c8ef):** MERGE. 0 HIGH, 0 MEDIUM, 2 LOW.
6. **#1617 BUG-999, CDRUNSOLVE false "already matches" (330ee22f):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM (the new message shows code words like INVALID_FLOW to every colleague), 1 LOW.
7. **#1619 BUG-969, CDNEWDWG job folder (a47286ee):** MERGE. 0 HIGH, 1 MEDIUM (duplicate #1630: close it), 1 LOW.
8. **#1621 BUG-947, damaged prepared update (b00ffe75):** REJECT in favour of #1632. 0 HIGH, 2 MEDIUM, 1 LOW. It keeps the damaged copy inside the folder the update check reads, and a changed (not missing) file still sticks forever.
9. **#1623 BUG-1004, Design head and detention (e0397253):** MERGE. 0 HIGH, 1 MEDIUM (duplicate #1624: close it), 2 LOW.
10. **#1625 BUG-1019, CDCALC levels at or below RL 0.00 (08e30026):** MERGE. 0 HIGH, 1 MEDIUM (duplicate #1622: close it), 2 LOW.
11. **Totals:** 10 PRs. 7 MERGE, 2 MERGE-WITH-FIXES, 0 HOLD, 1 REJECT. HIGH 0, MEDIUM 9, LOW 15.
12. **Keep one of each duplicate pair:** keep #1619 (close #1630), keep #1623 (close #1624), keep #1625 (close #1622), keep **#1632** (close #1621).
13. **Train:** all ten are Civil or Manager, so all go in **C-62**. Nothing here is for **S-43**: no PR touches Structural.
14. **C-62 order:** #1613, #1632, #1610, #1609, #1619, #1625, #1623, #1611, #1617 (after its fix), #1612 (after its fixes). Every step clashes only in `REGRESSION_LOG.md`: keep every entry.
15. **No new switch, no default changed, no CE_SHARED file, no Installer file.** Manager must ship in C-62 (#1613 and #1632 are Manager).
16. **For Tim's Monday list (not asked now):** BUG-999, should CDRUNSOLVE size with each pipe's saved flow, or be a levels-only tool? BUG-987, should the "same pit" distance follow the drawing's units through a Setting (default 200 mm)? Neither question is already answered in `QUESTIONS_FOR_MONDAY.md` or `decisions/` (I searched both).

---

## 1. #1609 @ 498f0f7a, BUG-892: MERGE, 0 HIGH, 0 MEDIUM, 2 LOW

1. **What it says:** clicking an Inspector count that reads 0 no longer takes a drawing lock and a transaction (the wrapper that keeps a drawing change safe). So it cannot use up your next U or lose a REDO.
2. **What the diff does (checked):** in `ShowEntitiesByHandles` the blank handles are dropped first. An empty list prints "[CE] No {label} found." and returns before `LockDocument` and `StartTransaction`. The non-empty path is unchanged apart from reading the cleaned list. All six health counts (failing grade, low cover, unconnected, disconnected, duplicate numbers, missing levels) use this one method.
3. **What Tim will see:** click "Unconnected pits: 0" in the Inspector. Before, the history could lose a step. Now the command line just says "No unconnected pits found."
4. **Defaults / Settings:** none. No switch (bug fix, always on).
5. **Redo-safe / locked layers / Xrefs:** the zero path now touches nothing. The non-zero path only reads and selects, as before. No drawing write.
6. **Tests:** 2 source-order guards. They fail on the base (there was no empty check at all), so they are real. They prove the order of the code, not what AutoCAD does with REDO. The builder says so honestly.
7. **LOW, stale counts:** a count that says 3 but whose pits were erased since still takes the lock and transaction, then says "No ... found". Same REDO cost as the bug. A one-line follow-up (read with `StartOpenCloseTransaction`, which never touches the history) would close this and the non-zero path too. Park it, do not hold this PR.
8. **LOW:** it adds a second "No {label} found." line in the same method. Harmless, but the wording now lives twice.
9. **Clashes:** code merges clean with C-61 (which also edits this file for BUG-572), with #1599 (BUG-995 zoom), #1588 (BUG-994) and #1532. Only `REGRESSION_LOG.md` conflicts.
10. **Train / order:** C-62, step 4.
11. **AutoCAD check (runner or Codex, on a test copy):**
    1. Open a copy with pits where every pit is connected (Inspector shows "Unconnected pits: 0").
    2. `LINE` 0,0 to 10,0, Enter. Type `U`.
    3. Click the "Unconnected pits" count. Expect exactly "[CE] No unconnected pits found." on the command line.
    4. Type `REDO`. Expect the line back: `(sslength (ssget "_X" '((0 . "LINE"))))` returns 1.
    5. Then click a count that is not 0. Expect those objects selected and zoomed, as on 3.0.71.

## 2. #1610 @ 78a2303f, BUG-957: MERGE, 0 HIGH, 0 MEDIUM, 1 LOW

1. **What it says:** Enter in the Settings search box never saves and closes Settings.
2. **What the diff does (checked):** the box's `PreviewKeyDown` now asks one small rule, `DecideSearchKey`. Enter with results jumps to the top result. Enter with no results is swallowed. Escape with text clears it; Escape on an empty box still reaches the window's Cancel. I checked the window: Save is both `IsDefault` and a `Return` key binding, and marking the key handled in `PreviewKeyDown` stops both. The old code already relied on this for the "results" case, so the mechanism is proven.
3. **What Tim will see:** CDS, change a value, search "zzzz", press Enter. Before, Settings saved and closed. Now it stays open and nothing is saved.
4. **Defaults / Settings:** none. No switch.
5. **Redo-safe:** Settings window only; no drawing contact.
6. **Tests:** 4 tests of the rule. Before the change they did not compile (the rule did not exist), so they fail without the fix. They do not prove the wiring (that the handler sets Handled for the new case).
7. **LOW:** add a one-line source guard that the `SwallowEnter` case sets `e.Handled = true`, so a later edit cannot quietly drop it.
8. **Clashes:** C-61 does not touch `AdvancedSettingsDialog.xaml.cs`. Held #1534 and #1528 edit the XAML, not this file. Clean.
9. **Train / order:** C-62, step 3.
10. **AutoCAD check:**
    1. Record the hash of `CD_Settings.json`.
    2. `CDS`, tick or untick one box, click in Search, type `zzzz`, press Enter. Expect the window still open (find it by its window name).
    3. Click Cancel. Expect the settings file hash unchanged.
    4. `CDS` again, search `depth`, press Enter: expect the matching tab selected. Escape clears the text; a second Escape closes Settings without saving.

## 3. #1611 @ 5ca3f08f, BUG-987: MERGE, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** CDSYNC no longer swaps two nearby pits' lid, remarks and schedule tick.
2. **What the diff does (checked):** `RestorePitUserData` now works in two passes. Pass 1 settles every pit's own saved record (by pit number or handle) and reserves it. Pass 2 lets position fill only what pass 1 left. A plain pit may still take a stronger nearby record, but only one no pit owns any more (the re-inserted-pit case the position match exists for).
3. **I checked the live path:** CDSYNC (`EnsureDrawingDataCurrent`) calls this method, `ProjectDataRecoveryGuardService.RestorePitUserData`. A second, older copy of the same pit-by-pit logic in `ProjectDataService.Recovery.cs` (its own `PitSnapshotBundle`) has no caller and no test. See LOW 1.
4. **What Tim will see:** two pits 10 m apart in a metre drawing, one Class D with "KEEP P2" and out of the schedule. Before, CDSYNC could swap them. Now each keeps its own.
5. **Defaults / Settings:** none. No switch.
6. **Redo-safe / locked layers / Xrefs:** record only, inside CDSYNC's existing command; no geometry.
7. **Tests:** 2 tests through the real snapshot and restore. I traced both through the old code: the first swaps P1 and P2, the second gives the new pit P2's Class D. So both fail without the fix.
8. **MEDIUM, distance still fixed (Tim's call, not a blocker):** "near" is still 200 drawing units: 200 mm in a millimetre drawing, 200 m in a metre one. The carpark asked for the distance to follow the drawing's units through a Setting (R-00). After this PR it matters only for a pit with no record of its own. Queue the question for Monday with a recommendation: a Setting in millimetres, default 200 mm, converted through the drawing's units.
9. **LOW 1:** delete the dead copy (`ProjectDataService.Recovery.cs`, the internal `PitSnapshotBundle` overloads) at the next touch. It still has the old swapping logic, and design rule 1 is one code path per behaviour.
10. **LOW 2 (existing, not caused here):** pit number outranks handle. Two pits with the same number (a copied pit) can still take each other's record. The Inspector already counts duplicate numbers; leave it for its own item.
11. **Clashes:** none in code (C-61 does not touch this file; #1313, #667 and #687 only mention the number in text). `REGRESSION_LOG.md` only.
12. **Train / order:** C-62, step 8.
13. **AutoCAD check (metre test copy, INSUNITS 6):**
    1. Place pit P1 at 0,0 and P2 at 10,0. PITEDIT P2: Class D lid, remark `KEEP P2`, untick "include in schedule". Leave P1 plain.
    2. `CDSYNC`.
    3. `PITSCHEDULE`. Expect P1: Class C, no remark, in the schedule. P2: Class D, KEEP P2, not in the schedule.
    4. Run `CDSYNC` twice more. Expect the same result.

## 4. #1612 @ 27b35e16, BUG-1011: MERGE-WITH-FIXES, 0 HIGH, 2 MEDIUM, 1 LOW

1. **What it says:** with Auto-calculate depth off, a depth typed in the Pit Schedule reaches the pit, and Stop overriding no longer blanks it.
2. **What the diff does (checked):** the "solve this depth into the invert" decision is now made before the cell is tracked as an override. A typed depth on an ordinary linked row is no longer tracked; `ApplyTypedDepthEdit` writes the new outlet (or inlet) invert into the row. Same cause and same cure as BUG-193 (pit size).
3. **What really happens next (I traced it):** writing that invert re-enters the same handler. The invert cell is tracked and the row becomes "waiting", like any typed invert. The drawing changes when you choose **Stop overriding**, not straight away. That matches Tim's INT-075 Set A4 ruling (typed levels wait for Stop overriding), so it is acceptable. The PR text and the REGRESSION_LOG say "the pit's invert changes", which is only true of the schedule cell until Stop overriding.
4. **MEDIUM 1, the promised status line never shows:**
   1. `ApplyTypedDepthEdit` sets "Outlet invert changes from 41.25 m to 41.20 m", then sets the invert.
   2. That makes the row waiting, and the waiting handler replaces the status with "Your typed value is waiting. Right-click the row and choose Stop overriding to write it to the drawing."
   3. The REGRESSION_LOG check expects the first sentence, so a Codex run will report DIFFERENT.
   4. **Fix:** in `ApplyTypedDepthEdit`, set the invert first, then show `plan.Message + " " + TypedValueWaitingStatus`. Assert `ScheduleStatusMessage` in the test, and correct the REGRESSION_LOG wording to "the outlet invert cell changes; Stop overriding writes it to the pit".
5. **MEDIUM 2, a row that is already waiting still loses the depth:**
   1. `ShouldSolveTypedDepthIntoPit` is false when the row is already an override (for example you typed a remark first).
   2. The depth is then tracked as before, nothing is solved, and Stop overriding still blanks it while saying your values stay. That is the original bug, on any row that already had an edit.
   3. **Fix:** drop the `!row.IsLinkedOverride` condition for the typed-depth solve. Writing the invert onto a waiting row is exactly what a typed invert does there. Add a test: a waiting row (remark typed), then Depth 1.15, then Stop overriding; expect invert 41.20 and Depth 1.15.
6. **Interaction with C-61 (checked on 88bd62f7):** C-61's pit-floor rule (#1531, `pitScheduleUsesPitFloor`, default ON) makes `ApplyTypedDepthEdit` refuse when the pit has a recorded floor: "Pit depth uses the recorded pit floor ... a typed schedule depth does not change any pipe invert." With this PR the typed depth on such a pit is then neither solved nor kept, and reverts on refresh. That is the correct reading of Tim's floor ruling, but the AutoCAD check must use a pit with **no** recorded floor, plus one pit with a floor that expects that message.
7. **Defaults / Settings:** none. No switch.
8. **Redo-safe / locked layers / Xrefs:** the drawing write is the existing Stop-overriding writer, one U. Xref rows return early (PS-01C), unchanged.
9. **Tests:** 3 new; the solve test fails on the base (invert stays 41.250).
10. **LOW:** the builder edited a test assertion after the full run and re-ran only 42 narrow tests. The full Civil suite must run once on the merged C-62, with #1531 present.
11. **Clashes:** code merges clean with C-61's edits to `PitScheduleViewModel.Data.cs` and with #1531. `REGRESSION_LOG.md` only.
12. **Train / order:** C-62, last (step 10), after both MEDIUM fixes.
13. **AutoCAD check:**
    1. Test copy, a linked pit with **no pit floor recorded**, cover 42.350, outlet IL 41.250.
    2. `PITSCHEDULE`, untick Auto-calculate depth, type `1.15` in Depth. Expect the outlet IL cell 41.20 and the status naming the change and saying it is waiting.
    3. Right-click, Stop overriding. Expect the outlet pipe's IL label reads 41.20 and the Depth cell still 1.15.
    4. `U` once: expect IL 41.25 back.
    5. On a pit **with** a recorded floor, type a depth: expect the pit-floor sentence and no IL change.

## 5. #1613 @ f514c8ef, BUG-1017: MERGE, 0 HIGH, 0 MEDIUM, 2 LOW

1. **What it says:** CE Manager buttons and the CE Blocks tiles cancel a running command first, as the ribbon does (BUG-828), so "CDREPAIR" is never typed into your TEXT.
2. **What the diff does (checked):** a new `CeManagerCommandSender` sends two cancels and then the command when `CommandInProgress` is not empty. Otherwise it sends exactly the old text. All the Manager senders now use it: Open Repair and the hub button (`SendCommand`), help, the settings fallback, Load Now (NETLOAD) and the CE Blocks tile. I grepped the branch: the only direct send left is `QUIT` in the installer (LOW 2).
3. **I checked:** the Manager window opens modeless (`ShowModelessWindow`), so `CommandInProgress` is the drafter's command, not CEMANAGER. The CE Blocks pending tool is taken when CEBLOCKINSERT starts, so a second tile click while the first insert is still running cancels the first and inserts the second. Same as the ribbon.
4. **What Tim will see:** start TEXT, click Open Repair in CE Manager. Before, "CDREPAIR" became your text. Now TEXT is cancelled and Repair opens. Clicking a CE Blocks tile during LINE starts the block insert instead of "Invalid point".
5. **Defaults / Settings:** none. No switch.
6. **Redo-safe:** it cancels the running command, the same as any ribbon click. No drawing write.
7. **CE_SHARED:** not changed. The test compares against `RibbonBuilder.BuildSendString` (test project only), so the two texts cannot drift.
8. **Tests:** 3 text tests plus 5 source guards (one per file: no direct send left). Two older guards were re-pointed, not weakened (I read both). The guards fail on the base.
9. **LOW 1:** Load Now while a command runs now cancels that command before NETLOAD. That is right, but say it in the Load Now tooltip at the next touch.
10. **LOW 2:** the installer's `QUIT` (restart to finish an update) still goes straight in. During a running command, QUIT would be typed into the prompt. Rare; park it.
11. **Clashes:** code merges clean with #1595 (BUG-948, same window file) and held #1534. `REGRESSION_LOG.md` only.
12. **Train / order:** C-62, step 1. Manager ships in C-62.
13. **AutoCAD check:**
    1. Test copy, CE Manager open beside the drawing.
    2. `-TEXT`, `0,0`, `2.5`, `0`, and at "Enter text:" click Open Repair.
    3. Expect `(ssget "_X" '((0 . "TEXT") (1 . "CDREPAIR")))` returns nil, and the Repair window opens.
    4. `LINE`, pick one point, then click a CE Blocks tile: expect the block insert prompt, no "Invalid point".

## 6. #1617 @ 330ee22f, BUG-999: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 1 LOW

1. **What it says:** CDRUNSOLVE no longer claims "every invert already matches the solved design" when it solved nothing.
2. **What the diff does (checked):** `BuildRunSolvePlan` counts pipes it could not solve. When there is at least one and no real change, the plan gets an error. `RunSolveCommand` already prints "Plan could not be built - ..." for that case and stops before the preview. A run that really solved and matches still says "already matches".
3. **The cause is real (I checked):** every node is built with zero catchment flow, so the sizer refuses every pipe. **So after this PR, CDRUNSOLVE says it could not solve on every run.** It is honest, but for colleagues on 9 Nov it is a tool that never works. The other half (real flows) needs Tim's word; see ANSWER FIRST item 16.
4. **MEDIUM, the message every colleague will see is code talk:**
   1. It reads: "[CDRUNSOLVE] Plan could not be built - CDRUNSOLVE could not solve this run: 1 pipe(s) were not solved, so nothing was checked and no level was changed. First reason: Pipe 'A' → 'C' is infeasible — INVALID_FLOW ... — excluded from the plan." The test pins `INVALID_FLOW` in it.
   2. Plain-English rule: no "infeasible", no error codes, no doubled command name.
   3. **Fix:** when the first reason is the zero-flow refusal, say "[CDRUNSOLVE] Nothing was changed. CE could not size these pipes because none of them has a design flow yet." Otherwise "CE could not solve N pipes. The first was A to C: <reason in plain words>." Update the test to pin the plain sentence.
5. **Defaults / Settings:** none. No switch.
6. **Redo-safe:** the error path writes nothing, so U has nothing to undo.
7. **Tests:** 3 new, through the real `BuildRunInputs`, `Design` and `BuildRunSolvePlan`. Two fail on the base.
8. **LOW:** the suggestion ledger still records "plan created" for an errored run (unchanged code). Park it.
9. **Clashes:** code merges clean with #1537 (pipe material, same file, a C-62 candidate). `REGRESSION_LOG.md` only.
10. **Train / order:** C-62, step 9, after the wording fix.
11. **AutoCAD check:**
    1. Test copy, pit A and pit C 30 m apart, one pipe, inverts 10.60 and 10.00, no flow set.
    2. `CDRUNSOLVE` from A.
    3. Expect the plain "could not size ... no design flow" sentence, no preview window, the pipe's IL labels unchanged and DBMOD unchanged.
    4. `U`: nothing to undo.

## 7. #1619 @ a47286ee, BUG-969: MERGE, 0 HIGH, 1 MEDIUM, 1 LOW

1. **What it says:** CDNEWDWG takes the job record of the folder you choose, so the new sheet's title block carries that job's number, client and address (HIGH bug).
2. **What the diff does (checked):** a small `NewJobDrawingRecordSource` hands back the opening record while the folder is unchanged, and re-reads the record from disk when the folder changes. A folder with no record, or text that is not a path, gives a blank record. I checked the command: the title block is written from the dialog's plan (`ChosenTitleBlockUpdates`), and the plan now uses this record, so the preview and the sheet agree. `JobRecordService.Load` only reads; it never writes.
3. **What Tim will see:** in a 26-901 sheet, CDNEWDWG, change the folder to 26-902, Create. Before, REF NO said 26-901. Now it says 26-902; a folder with no record gives a blank title block and the existing message.
4. **Defaults / Settings:** none. No switch.
5. **Redo-safe / locked layers:** a new drawing is made and opened; the current drawing is not touched.
6. **Tests:** 6, using real temporary job folders, plus a dialog source guard. The guard fails on the base.
7. **MEDIUM, duplicate #1630 (b03, off C-61):** the same fix, almost line for line, plus a new switch `linking.newDrawingReadsChosenFolderRecord` (ON) that has no CDS row. **Keep #1619, close #1630.** It is simpler, with no hidden setting to carry. Copy any extra test case from #1630 if wanted.
8. **LOW:** the record is re-read on every keystroke in the folder box (a file-exists check on a half-typed path). Fine on a local disk. If job folders are on OneDrive with online-only files it could stutter; re-read on focus-leave or Browse if Codex sees lag.
9. **Clashes:** with #1630 (same lines: do not merge both). Otherwise `REGRESSION_LOG.md` only.
10. **Train / order:** C-62, step 5.
11. **AutoCAD check:**
    1. Two test job folders 26-901 and 26-902, each with a `CE_JobRecord.json` (neutral test data only), and a sheet saved in 26-901.
    2. Open that sheet, `CDNEWDWG`, set the folder to 26-902. Expect the preview to show 26-902.
    3. Create. In the new drawing, `DWGPROPS`, Custom. Expect REF NO 26-902 and the 26-902 client.
    4. Repeat with a folder that has no record: expect a blank title block and the "No job record exists yet" message.

## 8. #1621 @ b00ffe75, BUG-947: REJECT (keep #1632 instead), 0 HIGH, 2 MEDIUM, 1 LOW

1. **What it says:** Get update ready repairs a prepared update that is missing a file, instead of failing with "conflicting identity evidence" every time.
2. **What the diff does (checked):** when the existing prepared copy is incomplete (unreadable receipt, missing bundle folder, missing signed file, or a listed file missing), it is renamed to `.preparing-damaged-<id>` in the same version folder and the fresh verified copy takes its place. If all files are present but the bytes differ, it still refuses.
3. **MEDIUM 1, the damaged copy stays where the update check looks:**
   1. The check with no version given reads every receipt under the plugin's folder, all levels down (`EnumerateFiles(..., AllDirectories)`). The `.preparing-` name only hides the folder from the version-level scan.
   2. So the damaged receipt is read on every check. It fails validation (its paths point at the old location), which sets "rejected".
   3. Once the fresh copy is installed and cleared, Manager keeps logging "A staged update receipt or its files failed exact validation" for a folder nobody will remove.
   4. #1632 puts the damaged copy under `update-staging\.damaged-staging\<plugin>\<version>\<id>`, outside every plugin folder, for exactly this reason. I checked that only `CeUpdateStagingService` reads the staging root, and only by plugin name, so that location is never scanned.
4. **MEDIUM 2, a changed file still sticks forever:** a file whose bytes changed (AV restore, a half-written copy) still gives "conflicting identity evidence" on every try. The carpark entry asks for "missing or changed". The fresh copy is already checked byte for byte against the signed approval, and the final folder's name is built from that verified content, so replacing a damaged copy with the verified one is as safe as installing it. #1632 does that.
5. **LOW:** neither PR logs a line when a copy is set aside. Add one to #1632 (one plain line in the CE log: "A damaged prepared copy of <plugin> <version> was set aside in <folder>; a fresh verified copy replaced it").
6. **What to do:** close #1621. Take **#1632** after its own Opus review: I read its code change and it looks right. It also replaced an old test that pinned the refusal, which its PR says openly.
7. **Train / order (for #1632):** C-62, step 2. Manager ships.
8. **Check (no AutoCAD needed; never on Tim's live staging folder):** the unit tests plus one Manager run against a test staging root:
   1. Prepare an update into the test root. Delete one file from the prepared bundle. Get update ready again.
   2. Expect success, the damaged copy under `.damaged-staging`, and a fresh complete copy in place.
   3. Repeat with one file's bytes changed: expect the same.
   4. Installed bundle hash unchanged throughout.

## 9. #1623 @ e0397253, BUG-1004: MERGE, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** CDDESIGN's "changed since the design was agreed" list now includes the orifice head and the detention answer.
2. **What the diff does (checked):** both are added to the optional `designInputs` block of the agreed record (`orificeHeadM`, `detentionRequired`). They are compared only when known on both sides. An older agreement that lacks them gets the existing "was not recorded when the design was agreed ... Agree the design again" line, the same pattern as the runoff coefficients. Confirm setup records the window's values; During reads the drawing and the last Save Draft. The new fields are copied wherever the block is copied.
3. **What Tim will see:** agree at 0.45 m, change to 0.60 m, Save Draft, reopen. Before, "Nothing has changed". Now "The orifice head was 0.45 m, now 0.6 m." An older agreed job shows one new line saying the head and detention answer were not recorded; Confirm setup once clears it.
4. **Defaults / Settings:** none. No switch.
5. **Redo-safe:** record and window only; no geometry.
6. **Tests:** 6 window-level tests through the real view model and the saved record. Four fail on the base.
7. **MEDIUM, duplicate #1624 (b03, off C-61):** the same idea, stored at the top of the record instead of inside `designInputs`, and silent for older agreements. **Keep #1623, close #1624.** Telling the drafter a value was not recorded follows R-27 (warn and record) and the pattern already used next to it.
8. **LOW 1:** the detention answer is a plain yes/no, so "never answered" is recorded as "no detention". A later change then reads "was no detention, now detention needed". Acceptable; make it three-state at the next Design touch.
9. **LOW 2:** if the head is blank now, the line says it "could not be read now". It was blank, not unreadable. Say "is blank now".
10. **Clashes:** code merges clean with C-61's edit to `CivilDesignWindowViewModel.cs` (#1549). `REGRESSION_LOG.md` only.
11. **Train / order:** C-62, step 7.
12. **AutoCAD check:**
    1. Test copy. `CDDESIGN`, set council and areas, orifice head 0.45, Confirm setup, close.
    2. Reopen, head 0.60, Save Draft, close, reopen. Expect During to list "orifice head was 0.45 m, now 0.6 m" and not "Nothing has changed".
    3. Untick detention, Save Draft, reopen: expect the detention line.
    4. Confirm setup again, reopen: expect "Nothing has changed".

## 10. #1625 @ 08e30026, BUG-1019: MERGE, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** CDCALC > Detention system treats real levels at or below RL 0.00 as known. It suggests a real top water level and warns when a typed water level is above a below-zero lid.
2. **What the diff does (checked):** whether a level is known is now kept apart from its sign, decided by whether the text parsed. The suggestion uses the highest **recorded** invert, so a blank end no longer counts as 0 and beats -1.000. With no invert at all it keeps the old 0.00 placeholder and never warns about a level CE invented. Rows built without the new flags fall back to "not 0 is known", so older callers behave as before. The pit storage and the baffle follow the corrected water level.
3. **What Tim will see:** DN300 pipes at -1.000 and -1.100. Before, the water level was 0.00 with a 1,100 mm baffle and extra pit storage. Now it is -0.70 and the baffle follows (400 mm to an outlet at -1.100). Type -0.40 over a -0.50 lid: the warning appears.
4. **Defaults / Settings:** none. No switch.
5. **Redo-safe:** calculation window only.
6. **Tests:** 7 through the real view model; 3 fail on the base. They include the blank-end case and the no-invert case.
7. **MEDIUM, duplicate #1622 (b03, off C-61):** a smaller fix with a switch (`detention.belowZeroLevelsAreReal`, ON, no CDS row). It still lets a blank end (read as 0) beat a real -1.000, and it treats exactly 0.00 as "not recorded", against the BUG-686 direction that 0.00 is a real level. **Keep #1625, close #1622.**
8. **LOW 1:** with no invert recorded, the 0.00 placeholder still drives the pit storage and baffle figures. That is not new; say "no water level" there at the next touch.
9. **LOW 2:** a pit's outlet invert taken from a blank pipe end still reads as 0 for pit depth (`GetPitOutletInvertFromSeeds`). Same family; park it.
10. **Clashes:** with #1622 (same lines: do not merge both); BUG-1021's #1593 is a different file. Otherwise `REGRESSION_LOG.md` only.
11. **Train / order:** C-62, step 6.
12. **AutoCAD check:**
    1. Test copy with two detention pipes DN300, inverts -1.000 and -1.100, pits with cover -0.50.
    2. `CDCALC`, Detention. Expect water level -0.70 and the baffle 400 mm when the orifice pit's outlet is -1.100.
    3. Untick "Use pit cover as TWL (suggested)", type -0.40: expect the warning naming -0.50 (100 mm over).
    4. On a normal job above RL 0.00, expect the same figures as 3.0.71.

---

## Merge order

### C-62 (Wed 28 Oct; base C-61 `claude/rel-20261023l` @ 88bd62f7)

1. **#1613** BUG-1017 (Manager).
2. **#1632** BUG-947 (Manager, b03), after its own review and the one log line. Close #1621.
3. **#1610** BUG-957.
4. **#1609** BUG-892.
5. **#1619** BUG-969. Close #1630.
6. **#1625** BUG-1019. Close #1622.
7. **#1623** BUG-1004. Close #1624.
8. **#1611** BUG-987.
9. **#1617** BUG-999, after the plain-English message.
10. **#1612** BUG-1011, after both MEDIUM fixes. Then run the full Civil suite once on the merged train.
11. **Clash note:** my dry merges of each PR onto C-61, and of each pair that shares a code file with another open PR, conflicted only in `REGRESSION_LOG.md`. The ten PRs touch different code files from each other. Keep every log entry.
12. **Manager ships in C-62.** CE_SHARED is not touched, so there is nothing to sync between Civil and Manager.

### S-43 (Structural)

1. **Nothing from batches 4 and 5.**

### Must wait for Tim (Monday list, not blockers)

1. **BUG-999 other half:** Run Solve sizing basis. Recommend option 1 now (leave it honest), then decide between saved pipe flows and levels-only.
2. **BUG-987 distance:** a Setting in millimetres, default 200 mm, through the drawing's units.

### Not checked by me

1. No build, test, AutoCAD, accoreconsole or Codex run. Every test count above is the builders', not mine.
2. My dry merges show text clashes only; they do not prove the merged train compiles.
3. I did not open any window or picture.
4. I reviewed the b03 rival PRs only enough to pick one of each pair. #1632 still needs its own full review.
5. Every bug here is built and unit-tested at most. None is installed, and nobody has opened any of them in AutoCAD. Do not mark any FIXED.

---

**Summary (under 120 words):** Ten draft PRs reviewed against their code. Seven can merge as they are. Two need small fixes first: #1612, where the typed-depth status message is overwritten and rows already waiting still lose the depth, and #1617, whose new CDRUNSOLVE message shows code words. One is rejected: #1621 leaves the damaged update copy where Manager keeps reading it; the rival #1632 does it right. A second lane built four of these bugs again: keep #1619, #1623 and #1625, close #1630, #1624 and #1622. Installed is already C-61 (3.0.71), so everything goes in C-62; nothing for S-43. No HIGH findings, no switches, no CE_SHARED changes.
