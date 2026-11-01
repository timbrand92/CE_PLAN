# Opus pre-review, backlog group r7: PRs #1584, #1737, #1731, #1008 (Structural sheets, RC windows and schedule rows)

Written Monday 2 November 2026, about 00:45 Melbourne (the brief is dated Sunday 1 November), by an independent read-only Opus reviewer for CE 05 at CE 00's and CE 01's request. The group is item 7, "r7", in areas\DRAFT_BACKLOG_TRIAGE_01NOV.md.
Structural line checked: `claude/rel-20261026s` at 204dfad2 ("Version: Structural 1.0.125 (S-45)"), confirmed with `git ls-remote`. It is still the only Structural line after 26 October.
Heads reviewed: #1584 b1ea7a87, #1737 4ae66b1b, #1731 2878e6c2, #1008 d30d5a0f. All four are DRAFT and all are Structural only. None touches Civil, CE_SHARED, the Manager, the installer, or the protected files named in the brief (LinkService.Persistence.cs, ProjectDataService.Persistence.cs, RulebookEngine.cs).
This review built nothing, ran no tests, installed nothing and did not open AutoCAD. I read the diffs, the authors' reports (release-v3-colleagues-MAX_BUILD_D_REPORT.md for #1584 by the triage's word, FB_TEAM_BATCH6_REPORT.md for #1737, FB_TEAM_BATCH5_REPORT.md and MAX_BUILD_G_REPORT.md for #1731; none for #1008), the carpark entries, the earlier reviews (REVIEW_OPEN_PRS_25OCT.md item 23 for #1737, REVIEW_CX4_AND_BATCH4_24OCT.md item 15 for #1731) and the decisions folder. Nothing in C:\CE_PLAN\decisions names these four bugs. I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.

## FOR TIM

1. **#1584, Save sheet list no longer hides drawings changed since the last scan (BUG-1013): KEEP-WITH-NOTE, Structural Sheets area + smoke.** Example: a colleague adds layout S05 to a drawing. You press Save sheet list in the CE Sheets Manager. Before, the window then said the list matched the drawings and S05 stayed missing. Now it still says "changed after the last scan" until you rescan. Note: the older CE Sheets window has its own "Save" button with the same fault, and this PR does not touch it.
2. **#1737, one out-of-date drawing no longer stops every sheet title update (BUG-1041): CHANGE-NEEDED.** The idea is right, but the two fixes the 25 October review required are still not in. First, a register or shared title drawing saved after the scan is called "left out" but CE still writes to it. Second, the next update forgets the drawing was left out and writes it without a rescan. Both are confirmed on the current code. It must not go in until both are fixed.
3. **#1731, RC windows take a typed bar count, for example 14 round bars (BUG-1038): KEEP-WITH-NOTE, Structural area + smoke plus a Codex window look.** Example: in RCCIRCCOL you type 14 in Total bars and get 14N20 with 14 bar circles. Before, you could only pick from a list that jumped from 12 to 16. The fault the 24 October review found ("1 bar per face" labelled 0N20) is fixed: Bars per face now needs 2 or more. The later version simply had not been looked at again. I have now read it and it is right.
4. **#1008, STRSCHEDCREATE tables are no longer one row short (BUG-497): KEEP, Structural area + smoke.** Example: you draw one AB brace and run STRSCHEDCREATE. Before, the table had room for the title and heading only, so the brace was written past the end. That gave an AutoCAD error or a missing row. Now every table has a row for each item. It is still not fixed on the current Structural line.
5. **Settings switches:** #1737 and #1731 each add one that starts ON, as your rule asks. Neither is tested by loading an older settings file. Both switches read ON from such a file (checked by reading the code), so there is a gap in the tests, not a fault. #1584 and #1008 have no switch. Turning either off would only bring the bug back, so I think that is acceptable. It is still CE 00's call (triage item 6).
6. **Merging onto the Structural line:** every PR clashes with the line in the change log (REGRESSION_LOG.md); keep both entries. #1731 also clashes with the line in two Settings lists, because the line already added the "column bars at real size" and "timber quantity" switches at the same spot. Keep both sides. No program code clashes. #1008 and #1011 (group r6) edit the same schedule file and join cleanly.
7. **Nobody has opened any of the four in AutoCAD.** All are built and unit-tested only, by their authors. All four bugs stay OPEN. No test I read touches your real settings. The Structural test project sends every settings read and write to a temporary folder.
8. **For the robot:** #1584 and #1737 need a small test project folder with two sheet drawings and a saved scan. #1731 and #1008 run on a blank millimetre drawing.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases. None is stacked on another.**
   1. **#1584:** base `claude/rel-20261022s2` at 2c9a9694. One commit. 119 commits behind the Structural line.
   2. **#1737:** base `claude/rel-20261023s` at e6d597c0. One commit. 109 behind.
   3. **#1731:** base `claude/rel-20261023s` at e6d597c0. Two commits (115a5c19, then the review fix 2878e6c2). 109 behind.
   4. **#1008:** base `claude/rel-20261009t` at c822a8ec. One commit. 295 behind.
2. **Merge onto the line (read-only `git merge-tree` against 204dfad2).**
   1. **#1584:** conflict in REGRESSION_LOG.md only. CeSheetsManifestService.cs and CeSheetsManagerWindow.xaml.cs merge cleanly.
   2. **#1737:** conflict in REGRESSION_LOG.md only. UserSettings.cs, CeSheetsSyncService.cs and CeSharedTitleMappingService.cs merge cleanly.
   3. **#1731:** three conflicts.
      1. `Modules/Structural/Models/UserSettings.cs`, Options group, around merged line 382: the line already has `ColumnBarsAtRealSize` (BUG-1037), `HatchChangeSkipsRefusedAndChangesTheRest` (BUG-1048) and the BUG-1045 switch at the spot where #1731 adds `BarCountsTypedFreely`. Keep both sides.
      2. `Modules/Structural/Services/SettingsService.LoadRecovery.cs`, label list, around merged line 1330: the line has `Options.ColumnBarsAtRealSize` and `Options.TimberQuantityAnyNumber`, and #1731 adds `Options.BarCountsTypedFreely`. Keep all three lines.
      3. REGRESSION_LOG.md. RCMemberDialog.xaml.cs merges cleanly with #1729's and #1696's changes, which are already on the line.
   4. **#1008:** conflict in REGRESSION_LOG.md only. ScheduleService.cs merges cleanly. In the merged file no "Count + 1" sizing is left, so its source guard still holds.
3. **Within the group and with neighbours (pairwise `git merge-tree`).**
   1. **#1737 with #1731:** REGRESSION_LOG.md only. UserSettings.cs joins by itself (different settings groups: CeSheets and Options).
   2. **#1584 with #1737, #1584 with #1731, #1584 with #1008:** REGRESSION_LOG.md only.
   3. **#1008 with #1011 (r6, head ba61da8b):** REGRESSION_LOG.md only. Merge r6 first as the triage says, but nothing in the code forces that order.
   4. **#1731 with #1596 (r5, head be6e198f, shares SettingsService.LoadRecovery.cs):** REGRESSION_LOG.md only.
4. **REGRESSION_LOG.md:** the 25 October review found Structural entries landing mid-file after an automatic merge. The assembler should place all four entries at the top by hand.
5. **Real settings in tests:** on all three bases, `Modules/Structural.Tests/CeStrucTmpRootSetUp.cs` (a whole-run set-up) points `CE_STRUC_SUITE_APPDATA_ROOT` at a temporary folder (lines 20 and 32), and the settings reader honours it (`SettingsService.cs` ResolveAppDataRoot, about line 963 on the line). I could not confirm what happened on the authors' machines during their runs.

---

### #1584, BUG-1013: Save sheet list does not record a scan time (head b1ea7a87)

1. **What changes for the drafter.**
   1. **Code:** `CeSheetsManifestService.Save` gains `stampScanned = true` (CeSheetsManifestService.cs:39 on the PR); the stamp `LastScannedUtc = DateTime.UtcNow` now runs only when it is true (:50-51). The one caller changed is the Save sheet list button, `BtnSaveManifest_Click` in CeSheetsManagerWindow.xaml.cs:493, which passes `stampScanned: false`.
   2. **In AutoCAD terms:** in the CE Sheets Manager, Save sheet list keeps your edits but leaves the "last scanned" time alone. A drawing a colleague saved after the scan still shows as changed ("Project drawings changed after the last scan. Rescan to pick up new or removed layouts/DWGs."). The scan and every button that writes into drawings still record the time as before. Those buttons need the stamp, because CE's own writes make the drawings newer.
   3. **Against the carpark:** the entry asks "Saving the sheet list does not move the 'last scanned' time; only a real scan does." That is met for the button named in the finding. The entry's suggested shape ("keep a separate saved-at time") was not used. Nothing needs it, so I accept the smaller change.
   4. **Gap (the note):** the older CE Sheets window (`CeSheetsWindow.xaml.cs`, "Save + Close" button `BtnSave_Click`, about line 728 on the line, `Save(_manifest)` about line 736) saves typed edits the same way and still stamps the time. The carpark's area says "Sheets window and palette". The window may hide a colleague's change in exactly the same way. Recommendation: add the same `stampScanned: false` to that one call in this PR before merge, or carpark it as a follow-up. I did not check which ribbon or command opens that window today.
2. **Settings switch.** None. Turning it off would only bring back the false "matches" message, so there is no useful old behaviour to keep. CE 00's ruling on no-switch fixes applies (triage item 6). No engineering value is involved (R-00 not engaged).
3. **No hard blocks (R-27).** None added. It actually keeps a warning visible longer, which is the point.
4. **Native protection and REDO.** Writes only the project's sheet-list file on disk, never a drawing. No AutoCAD undo involved. The carpark marks it "Protected: yes", but none of the protected files named in the brief is touched.
5. **Merge.** See group facts: REGRESSION_LOG.md only.
6. **Tests.** `CeSheetsManifestSaveStaleTests`, 3 cases, in a temporary folder.
   1. Before the fix they do not compile (no `stampScanned` argument). The behaviour test would also fail on the old code, because after the old Save `IsStale` returns false.
   2. One of the three is a source-text check that the button passes `stampScanned: false`. That is acceptable for a click handler that needs a window.
   3. The PR says net48 was not built. The change uses only a default argument, which net48 supports.
7. **Not proven, and the robot scenario.**
   1. **Not proven:** that the Sheets Manager's health panel actually shows the stale reason after the save; nobody has looked.
   2. **Robot (CE 02):** copy a two-drawing project (S01.dwg, S02.dwg). CESHEETS, Scan Project. Open S02, add a layout "S03", save, close. In CE Sheets Manager change one sheet title and press Save sheet list. Right: status "Sheet list saved." and the health panel still says the drawings changed after the last scan. Press Rescan: S03 appears. Wrong (old): the health panel shows the list matching, and S03 is missing.
   3. **Codex look:** not needed beyond the robot's screenshot of the health panel.
8. **Verdict: KEEP-WITH-NOTE. Train: Structural Sheets area + smoke.** Note: add the same change to the CE Sheets window "Save + Close" call, or carpark it.

---

### #1737, BUG-1041: one out-of-date drawing no longer stops every sheet title update (head 4ae66b1b)

1. **What changes for the drafter.**
   1. **Code:** new `CeSyncScope` and `BuildSyncScope` (CeSharedTitleMappingService.cs, new lines 148-236 on the PR). `BuildSyncPreview` and `SyncManifest` (CeSheetsSyncService.cs:115-123 and :232-251) use the scope instead of `BuildSyncBlockers`, and drop the left-out drawings' sheets from `managedSheets`.
   2. **In AutoCAD terms:** CESHEETSCLASSIC or the Sheets palette, "Preview drawing updates". If one drawing was saved after the last scan, skipped, had no sheets, shares a sheet number, or is not on the list, CE names it ("Left out 'J1_STR_S02.dwg': it was saved after the last project scan. Its sheets are not updated this time - rescan in CE Sheets Manager to include them. The other drawings go ahead.") and updates the rest. Before: "Sync blocked" and nothing updated.
   3. **Against the carpark:** the entry asks "warn about the affected sheet only, and carry on with the sheets that are fine. Do not apply stale mappings blindly." The first half is met. The second half is not, because of required fixes 1 and 2 below.
2. **The 25 October review's fixes, re-checked on this head (the head has not changed since that review).**
   1. **Fix 1 (required), still missing:** the support-drawing loop (CeSheetsSyncService.cs:358-395 on the PR) and `SyncSharedTitleXrefs` (called at :350) never ask `scope.IsLeftOut`. A register drawing or shared title drawing saved after the scan is named "Left out" in the warning but is still written. Example: a colleague updates the drawing register sheet by hand and saves it. CE says it is left out, then writes the register rows into it anyway. Fix as written in that review: in `BuildSyncScope`, leave out only sheet drawings; any other drawing newer than the scan keeps the old whole-run block (`BuildStaleReason`).
   2. **Fix 2 (required), still missing:** `SyncManifest` ends with `CeSheetsManifestService.Save(manifest)` (:404 on the PR), and `Save` stamps `LastScannedUtc = now` (CeSheetsManifestService.cs:47 on the base and on the line). On the next update the left-out drawing is older than the new stamp, so it is no longer left out. Its pending title change is then written from the old scan without a rescan. That contradicts the PR's own warning text ("rescan ... to include them") and the carpark ("Do not apply stale mappings blindly"). Fix as written in that review: before that save, record each left-out drawing in `LastScanDiagnostics.SkippedDrawings` with `Kind = "SavedAfterScan"`. A real scan then clears it. Do NOT fix this with #1584's `stampScanned: false`: CE's own writes would then make every written drawing look newer than the scan.
   3. **Fix 3 (should), still missing:** a duplicate sheet number was a whole-run block and is now only a "left out" warning (new line 194). The Sheet No column can be typed into, so two sheets could quietly share a number. Keep it as a block, or say why not.
   4. **Fix 4 (should), still missing:** no test loads an older settings file without the new key.
3. **Settings switch.** `CeSheets.SyncSkipsOnlyAffectedDrawings`, default ON (UserSettings.cs, CeSheets group, new line 296). It is read in one place (`SyncSkipsOnlyAffectedDrawings`, new lines 169-170, `?? true`). OFF: `BuildSyncScope` returns exactly `BuildSyncBlockers`, and with no left-out drawings `managedSheets` is the full list. One small difference when OFF: the register row count in the preview now uses `allManagedSheets` (:200), which is equal to the old list when nothing is left out. So OFF restores the old all-or-nothing exactly. Pinned only by `new CeSheetsSettings()` (test `TheSwitch_ShipsOn`), not through a settings-file load. A missing key keeps the property's starting value when the file is read, so an older file reads ON; I checked that by reading, not by running it. No engineering value involved.
4. **No hard blocks (R-27).** This PR removes a hard block, which is the point. The two remaining blocks (no sheet list loaded; a shared title drawing that cannot be mapped) are whole-run faults, which is reasonable.
5. **Native protection and REDO.** The writer path is unchanged; it writes closed drawings through the existing service, which already handles a drawing open in AutoCAD. Fix 1 is a protection fault: a drawing CE promises not to touch is written. The carpark marks it "Protected: yes" (it writes into many drawings at once), but none of the protected files named in the brief is touched.
6. **Merge.** See group facts: REGRESSION_LOG.md only on the line. UserSettings.cs joins cleanly with #1731.
7. **Tests.** `Bug1041SheetsSyncScopeTests`, 8 cases, project in a temporary folder. The switch is flipped in memory on the redirected settings and restored in TearDown.
   1. Before the fix they do not compile (no `BuildSyncScope`).
   2. None covers fixes 1, 2 or 3. The one sync-writer test is a source-text check.
   3. The author ran Structural net10 in 14 chunks: 5,515 of 5,516 passed. The one failure was a build-id test that passed after a rebuild. The 11 Sbeam classes were not run.
8. **Not proven, and the robot scenario (after the fixes).**
   1. **Not proven:** any real write, the left-out drawing staying untouched, and the second run.
   2. **Robot (CE 02):** copy a project with S01 and S02 (title attributes), one drawing-register support drawing, a complete saved scan. Change S01's title OLD to NEW in the sheet list (not yet synced). Open S02, make a harmless change, save, close. CESHEETSCLASSIC, close the manager, "Preview drawing updates", apply. Right: one warning naming S02; S01's title reads NEW; S02's file date and hash are unchanged. Then run "Preview drawing updates" a second time WITHOUT a rescan. Right: S02 is still left out (this is fix 2). Then save the register drawing by hand and run again. Right: the run stops with the stale reason, and the register file is not written (this is fix 1).
   3. **Codex look:** the preview window's warning list, to check the left-out wording reads well.
9. **Verdict: CHANGE-NEEDED.** Push fixes 1 and 2 (required), and preferably 3 and 4, then a short re-review of the new head. Train after that: **Structural FULL**, because it changes which drawings a multi-drawing writer touches across a whole project.

---

### #1731, BUG-1038: RC windows take a typed bar count (head 2878e6c2)

1. **What changes for the drafter.**
   1. **Code:** new `BarCountEntryRule` (Core/Rebar/BarCountEntryRule.cs): a whole number from the smallest allowed count up to 999. With the switch on, `MakeCountCombosTypable` (RCMemberDialog.xaml.cs, new lines 164-176) makes the four count boxes typable. Every read goes through one helper, `ReadCount` (:178-186). OK runs `CheckTypedCount` (:188-198) for bottom and top bars (:396-397), bars per face with a smallest count of 2 (:456) and total bars (:486).
   2. **In AutoCAD terms:** RCBEAM, RCRECTCOL and RCCIRCCOL: type 14 in Total bars, 7 in Bars per face, or 14 in the bottom bar count. The preview follows, and Place draws that many bars with the matching label. The lists stay as suggestions.
   3. **Against the carpark:** "Any positive whole number of bars can be typed; lists are only suggestions (office-editable), unusual arrangements get a warning, never a block." Typing is met. Two parts are not done, and the PR says so plainly. The suggestion lists are still fixed in code (RCMemberDialog.xaml.cs, about lines 140-155), not office-editable. Columns have no warnings for unusual arrangements (none existed before; the author did not invent rules). Both are follow-ups, not faults in this change.
2. **The changed head, re-reviewed.** The 24 October review (REVIEW_CX4_AND_BATCH4_24OCT.md item 15) asked for one fix on 115a5c19: Bars per face must be 2 or more, because 1 drew 2 bars labelled "0N20". Commit 2878e6c2 does exactly that, in typed entry, live preview and OK. The minimum is a named value (`MinimumBarsPerFace = 2`). The message adds "Each face has its two corner bars." Beam and round-column boxes stay at 1 or more. Nothing else changed in that commit. That review's MERGE-WITH-FIXES is now satisfied.
3. **Settings switch.** `Options.BarCountsTypedFreely`, default ON (UserSettings.cs, Options group). The label is in SettingsService.LoadRecovery.cs. One reader, `BarCountsTypedFreelySetting.On()`, gives ON if the value cannot be read. OFF: the boxes stay pick-only and `ReadCount` returns the picked item, or the same fallbacks as the old code (3, 0 or 2, 2, 8). `CheckTypedCount` passes straight through. So OFF restores the old behaviour exactly. Pinned only by `new OptionsSettings()`, not through a settings-file load and not OFF. Same gap as #1737; an older file reads ON (checked by reading).
   1. **Hard-coded values (R-00):** 999 is a loop safety limit and 2 per face is a geometry fact; neither is an engineering value. The suggestion lists are office choices and belong in Settings (carpark "office-editable"); carpark that as a follow-up.
4. **No hard blocks (R-27).** OK with a blank, 0, 7.5 or letters shows a "[CE] ... must be a whole number of 1 or more (up to 999)." message box and the window stays open. That refuses text that is not a bar count, which is not an engineering block; it never turns it into a default, which is correct. The beam's existing "bars do not fit" warnings still only warn.
5. **Native protection and REDO.** Window only. The drawing loop (ColumnDetailCommands.cs) already loops to the bar count and is unchanged, inside the command's existing transaction. One U still removes the section. No locked-layer or Xref change.
6. **Merge.** See group facts: keep-both conflicts in UserSettings.cs and SettingsService.LoadRecovery.cs against the line. #1729's real-size column bars are already on the line, and the dialog joins cleanly with them.
7. **Tests.** `Bug1038BarCountEntryTests`, 23 cases after the review fix.
   1. Four run the real window on a single-threaded test thread: type 14 round, 7 per face, 14 bottom bars, and 2 per face with typed 1 not read as 1. They put text in the box and run the real result builder. On the base the box reads only a picked item, so they fail there. The other cases are the entry rule.
   2. Runs: the author's main Structural net10 run ended with 4,616 passed and 0 failed, then the test host hung on a later, unidentified test and was stopped. So it is not a clean finish. The Settings, Sheets, WindowRender and Template group passed 474 of 474 on the first head. net48 compiled with 0 errors (first head). The net48 test lane was not run.
   3. The window pictures under docs/image were not regenerated. The count boxes now look editable, so a picture-compare test may go red on assembly; regenerate them in the train.
8. **Not proven, and the robot scenario.**
   1. **Not proven:** what the editable boxes look like, and the placed drawing.
   2. **Robot (CE 02):** blank millimetre drawing, DIMSCALE 20.
      1. RCCIRCCOL: diameter 600, N20, N10 ties, cover 40, type 14 in Total bars, Place Section at 0,0. Right: label 14N20 and exactly 14 bar circles. Repeat with 18.
      2. RCRECTCOL 800 x 800, N20, type 7 in Bars per face. Right: 24 bars and label 24N20. Type 1 and press OK. Right: the message about two corner bars, the window stays open.
      3. RCBEAM: type 14 in the bottom bar count. Right: 14 kept; a "bars do not fit" warning may show and does not block.
      4. In any window clear the box and press OK. Right: a message, the window stays open, nothing drawn. Then U after a placement removes the whole section.
   3. **Codex look:** the three windows with the editable count boxes, and the round-column preview at 14 bars.
9. **Verdict: KEEP-WITH-NOTE. Train: Structural area + smoke, plus the Codex window look.** Notes: keep both sides in the two Settings files; regenerate the window pictures; carpark "suggestion lists in Settings" and "column arrangement warnings" as follow-ups.

---

### #1008, BUG-497: STRSCHEDCREATE tables sized for title, heading and every item (head d30d5a0f)

1. **What changes for the drafter.**
   1. **Code:** new `TableRowCount(items) = items + 2` (ScheduleService.cs, new line 378 on the PR). The bracing, bored pier and tie-down tables use it (:382, :420, :528) instead of `Math.Max(2, count + 1)`.
   2. **In AutoCAD terms:** after placing braces, bored piers or tie-downs, STRSCHEDCREATE makes each table with a title row, a heading row and one row per item. Before, the last item was written past the end, which by the carpark's reading is an AutoCAD error with no tables, or a missing last row.
   3. **Against the carpark:** "Smallest fix: size each table 'count + 2'." That is exactly what was done. With no items the table is still 2 rows, the same as before.
   4. **Still needed on the line:** the line (204dfad2, ScheduleService.cs:384, :422, :572) still has `count + 1`. The refresh code on the line already assumes title plus heading plus items (`table.Rows.Count - 2`, about :664 and :771). Tables made by the fixed create step and refreshed later therefore line up.
2. **Settings switch.** None. Turning it off would only bring the crash back. No engineering value. CE 00's ruling on no-switch fixes applies (triage item 6). I think it is clearly acceptable here.
3. **No hard blocks (R-27).** None added. It removes an error.
4. **Native protection and REDO.** Table creation inside the command's existing transaction is unchanged apart from the size. One U removes the tables as before. No protected file.
5. **Merge.** See group facts: REGRESSION_LOG.md only, on the line and with #1011.
6. **Tests.** `Bug497ScheduleRowCountTests`. Three cases check `TableRowCount` (0, 1 and 4 items), and one source check confirms no "Count + 1" sizing is left. Before the fix they do not compile, and the source check fails on the old text. The real table in AutoCAD is not tested (it needs AutoCAD). No author report exists; the PR says 445 schedule tests pass. I could not confirm that number, and it was against the 9 October base, not the line.
7. **Not proven, and the robot scenario.**
   1. **Not proven:** that the old code really errors in AutoCAD (the carpark itself says "my reading, not seen"), and that the new tables look right.
   2. **Robot (CE 02):** blank millimetre drawing. Place one AB brace, one bored pier and one tie-down. STRSCHEDCREATE, place the tables. Right: three tables, each with title, heading and the one item listed, and no error on the command line. Then add a second brace and run STRSCHEDREFRESH on the bracing table. Right: two brace rows. U removes the tables.
   3. **Codex look:** not needed beyond the robot's screenshot of the three tables.
8. **Verdict: KEEP. Train: Structural area + smoke** (schedules). Merge r6's #1011 first if convenient; the code joins either way.
