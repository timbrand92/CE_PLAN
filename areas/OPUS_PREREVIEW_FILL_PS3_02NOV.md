# Opus pre-review FILL PS3: PRs #1415 (BUG-780), #1412 (BUG-783) and #1424 (BUG-770 latent)

Written Monday 2 November 2026 (Melbourne) by an independent read-only Opus reviewer for CE 05 at CE 00's request (queue filler 6, job 615).
Heads reviewed: #1415 53de7571, #1412 28996088, #1424 920e7160. All three are DRAFT and OPEN on GitHub, base `claude/rel-20261018d`.
Newest release tip checked: `claude/rel-20261108a` at cf059dcf (2 Nov 11:02). Line numbers below are on that tip unless I say "in the PR".
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the PR text and diffs, the carpark entries, QUESTIONS_FOR_MONDAY.md and the code on the tip. I ran read-only `git fetch`, `git merge-base` and `git merge-tree` only.

## FOR TIM

1. **The big news first: all three are already in your installed plugin.** They went into Civil 3.0.70 about two weeks ago and are in every train since. The PRs only look "open" on GitHub. Nothing here needs merging. This review is a check of code you already run.
2. **#1415, Pit Schedule rows below a merged "DPs" row keep their own pipe (BUG-780): KEEP-WITH-NOTE, Civil Pit Schedule area + smoke.** Example: pit P5 with P3 at 19.40, DP1 and DP2 at 19.60, AG at 19.90. Before, the AG row read DP2's 100 mm and 19.60. Now it reads the AG pipe's own 150 mm and 19.90. The note: in an older drawing where you typed a figure on a row two or more rows below the merge, that figure can jump up one row. I recommend a new carpark bug for it (detail below).
3. **#1412, a cell cleared with Delete cell stays blank in the drawn table (BUG-783): KEEP-WITH-NOTE, Civil Pit Schedule area + smoke.** Example: you clear P3's cover. Before, the next PITEDIT wrote the word "DELETE" into the drawn cell. Now it stays blank. On a 1.2 m deep pit, clearing Remarks now prints only "With Step Irons". That is my recommendation in QUESTIONS_FOR_MONDAY section I item 1, which you have not answered yet. It is easy to change if you want blank.
4. **#1424, the "pipe flowing full" figure on the auto-design long section (BUG-770): KEEP-WITH-NOTE, Civil area smoke only.** Example: a 300 mm pipe at 1 in 100 carrying 40 L/s. Before, the row said 40 L/s. Now it says 125.7 L/s, its full capacity as a smooth plastic pipe. Nothing draws this row today, so no drawing changes. The note: it treats every pipe as plastic. A concrete 300 at 1 in 100 holds 96.7 L/s, but it would still say 125.7. That should be fixed before anything draws this row.
5. **No new stops or refusals.** None of the three adds a stop or a pop-up box. #1412 removes one cause of the CDDESIGN redesign "edited directly or out of date" refusal.
6. **No clashes with the other Pit Schedule fixes.** The only overlaps are the Settings list and the change log. In both, the fix is to keep both entries, and that is already done on the train. No two PRs here change the same part of the program.
7. **Your settings were safe.** Every test wrote to its own temporary settings file. No test touched your real CD_Settings.json.
8. **Nobody has opened these three in AutoCAD.** They are built, unit-tested and installed, but not accepted. All three bugs stay OPEN until the robot and a Codex look pass the scenarios below.

---

## DETAIL

### Group facts

1. **Already merged into the trains.** Each PR head is inside `claude/rel-20261102a`, `rel-20261108a`, `rel-20261110a` and `rel-20261112a` (`git merge-base --is-ancestor`). The train merges are d9099268 (#1415), becba02f (#1412) and e7150a92 (#1424), which matches the carpark: "fix installed in Civil 3.0.70". The sibling PRs #1431, #1422, #1426 and #1410 are also already inside `rel-20261108a`. A read-only `git merge-tree` of each head into `rel-20261108a` is clean.
2. **Earlier review.** #1415, #1412 and #1424 each already had one Opus review round on 19 Oct, and fix rounds 53de7571, 28996088 and 920e7160 answer it. This is a second, independent look.
3. **Settings switches.** All three are in `linking`, default ON:
   1. `scheduleMergedRowsKeepOwnPipe` (UserSettings.cs:987-988).
   2. `scheduleDeleteCellStaysBlank` (UserSettings.cs:921-922).
   3. `longSectionBridgeFullBoreFlowRow` (UserSettings.cs:1336-1337).
   All three now have rows in the Settings window, added later (CivilSettingsView.xaml:381, :393, :414) and are round-tripped by `Bj33SettingsPersistenceTests` (lines 17, 23, 32).
4. **Gap in the start-up-read tests (all three).** None of the three keys has the "both start-up reads" test that BUG-1031 uses (`Bug1031DeleteCellMenuTests.TheSwitch_LoadsOn_ThroughBothStartUpReads_WhenTheFileDoesNotCarryIt`, which runs `DeserializeSettings` and `DeserializeSettingsTolerant` on `{}` and `{"linking":{}}`). Each PR pins the default only with `new LinkingSettings()`.
   1. **Risk:** low. Newtonsoft keeps the default set in the code when the key is missing.
   2. **Fix:** a small follow-up adding the three keys to such a test.
5. **Protected files.** None of the three touches LinkService.Persistence.cs, ProjectDataService.Persistence.cs or RulebookEngine.cs.

---

### #1415, BUG-780: merged Pit Schedule inlet rows keep their own pipe

1. **What changes for the drafter.**
   1. **The bug.** A pit's inlets are merged when two share the same FROM and the same level, for example two downpipes become "DPs". Before, row N was simply paired with inlet N. Every row below a merge therefore read the next pipe up the list. The carpark example: P3 19.40, DP1 19.60, DP2 19.60, AG 19.90. The AG row showed DP2's size and 19.60, and an edit on the AG row wrote to DP2.
   2. **The fix.** The merge now says which pipe each row came from, the first pipe of its group. `PitScheduleBuilder.ConsolidateInletsKeepingSource` (PitScheduleBuilder.cs:282 on the tip) returns a `SourceIndex` for each row.
   3. **Who uses the new rule.** Three places use it:
      1. The window (PitScheduleViewModel.Data.cs:310-323, `LoadFromProjectData`).
      2. Xref rows (Data.cs:740-751, `AppendExternalSourceRows`).
      3. The CDDESIGN redesign review (NetworkRedesignScheduleReviewService.cs:134-154).
   4. **The old merge still works.** `ConsolidateInletsByLabelAndInvert` is kept as a thin wrapper and returns exactly what it did.
   5. **Against the carpark.** This is exactly what the carpark "Expected behaviour" asks for: "P3, DPs, then AG with its own diameter and IL 19.90". No ruling in `C:\CE_PLAN\decisions` covers it otherwise.
   6. **"Builder" in the brief.** In PitScheduleBuilder.cs only the merge helper changed. The drawn table's own refresh never calls the merge. It uses the pipe link stored in each cell (see point 7).
2. **The Settings switch.**
   1. **Default:** ON, as Tim's standing rule for bug-fix switches.
   2. **Read through:** `MergedRowsKeepOwnPipeSwitch()` (PitScheduleBuilder.cs:334-338), which falls back to ON if Settings cannot be read.
   3. **OFF gives the old pairing exactly.** OFF passes `keepOwnPipe:false`, so `SourceIndex = result.Count` at the moment the row is added, which is the row number. That is the old "row N is inlet N", and the window's old `inletIdx2 < inletPipes.Count` check is matched by `merged.SourceIndex < inletPipes.Count`. The figure-lending step only runs when the switch is ON (Data.cs:408-418).
   4. **Tests.** `SwitchOff_RowNIsInletN_AsBefore` checks OFF at the helper level only.
   5. **R-00.** No engineering value is involved.
3. **No hard blocks.** None added.
4. **Native protection and REDO.**
   1. The change only decides which pipe a window row reads. It writes nothing to the drawing.
   2. The figure-lending (`PitScheduleMergedRowOverrides.WithOldKeyRecord`) returns a copy and never changes the saved list (test `AFigureTypedOnTheRowUnderAMerge...` checks `map.ContainsKey(OwnKey) == false`).
   3. Nothing new for locked layers, Xrefs, REFEDIT, Undo or REDO.
5. **Merge and sibling PRs.**
   1. **Clashes.** `git merge-tree` of #1415 with #1412, #1431 and #1422 clashes only in UserSettings.cs and REGRESSION_LOG.md, and with #1424 only in REGRESSION_LOG.md. In every case the fix is to keep both, and the train already has both.
   2. **Same function as #1431, different lines.** Both change `LoadFromProjectData` in PitScheduleViewModel.Data.cs. #1415 changes the merge block (base lines 309-326) and the override step (base line 408). #1431 adds one line at base line 482 (the outlet warning) and also changes `LoadFromSelectedXrefs`, `OnRowPropertyChanged` and `ComputeDiameterWarning`. The lines do not overlap and the train merged them cleanly.
   3. **#1422, different function.** It changes `ApplyPersistedSortOrder` (base line 918) only, which does not overlap.
   4. **The row order now saves.** The REGRESSION_LOG note "the saved row order of those rows is still lost until #1422 is merged" is now out of date, because #1422 is on the tip.
6. **Tests.**
   1. **`PitScheduleMergedRowsKeepOwnPipeTests` (5).** These are good behaviour tests on the exact audit case. They were "written with the change, not run red first". On the old code they would not compile, because the new helper did not exist. They would not have failed as a behaviour test. The OFF test shows the old code would have given SourceIndex 2, not 3, so the logic is sound.
   2. **`PitScheduleMergedRowOverridesTests` (6).** These test the lending rule. The window wiring is checked only by a source-text test (`TheWindowLendsTheOldRecordWhenItBuildsAMergedRow`). No test drives the window with a merged pit.
   3. **Your settings.** No test touched them. The test project's `SettingsIsolationSetup` sends Settings to a new temporary folder.
7. **Note (recommend a new carpark bug): a typed figure can jump up one row in an older drawing.** The lending rule handles the row directly under the merge. It does not handle a second row further down.
   1. **Example.** P5 inlets: P3 19.40, DP1 19.60, DP2 19.60, AG 19.90, SW 20.10.
   2. **Old pairing.** The rows are P3, DPs, AG, SW. AG was paired with DP2 and SW with AG. A level typed on the SW row was saved under the AG pipe.
   3. **New pairing.** The AG row's own pipe is AG. It finds that saved record under its own pipe and shows the SW row's typed figure (Data.cs:408-418: `overrides.ContainsKey(ownKey)` is true, so nothing is lent and the record is used as it is).
   4. **SW loses its figure.** The SW row's old pipe (AG) still has a row, so nothing is lent to it and it loses its figure.
   5. **It becomes permanent.** At the next Apply the figure is saved on the AG row for good.
   6. **When it happens.** Only in drawings saved before 3.0.70 with a hand-typed figure on a row at least two below a merge, which were already showing the wrong pipe. It is rare, but silent.
   7. **Suggested fix (follow-up PR, not this one).** Lending needs to know which pairing a record was saved under. Add a "saved under the 3.0.70 pairing" mark to each record written from now on. Treat an unmarked record on a merged pit by its old position for every row, not only the first one below the merge. If that is too much, warn once per pit ("P5: a typed figure saved before 3.0.70 may sit on the wrong inlet row; check it") instead of guessing.
8. **Note: an already-placed table.** A drawn table placed before 3.0.70 still carries DP2's link in the AG row's cells. A PITEDIT or CDSYNC refresh of that old table will keep writing DP2's figures into the AG row until the table is placed again from the window. Separately, the CDDESIGN redesign review now expects the AG pipe on that row, and may list the old table as out of date. I could not prove either way without AutoCAD.
9. **What is NOT proven, and the robot scenario (CE 02).**
   1. **Not proven:** not driven in AutoCAD; net48 not built by the author; the primary row's pipe size column was not checked separately.
   2. **Robot scenario.** Use a copy only.
      1. Set up pit P5 with a 300 mm from P3 at 19.40, two 100 mm downpipes DP1 and DP2 at 19.60, a 150 mm AGI drain at 19.90 and a 100 mm SW at 20.10.
      2. Run PITSCHEDULE. Expect four inlet rows: P3 300 19.40; DPs 100 19.60; AG 150 19.90; SW 100 20.10. Read the cells out of the drawn table.
      3. Edit the AG row's IL to 19.85 and Apply. Then check through Edit Pipe that the AG pipe changed, not DP2.
      4. Run the CDDESIGN redesign review on P5 and expect the same three-plus-one rows.
      5. Set `scheduleMergedRowsKeepOwnPipe` false before launch and repeat step 2. Expect AG to read 100 and 19.60 (the old pairing).
      6. Older-drawing case: open a drawing saved on 3.0.69 or earlier with a level typed on the SW row of such a pit. Expect the figure to stay on SW. Today I expect it to move to AG (point 7).
   3. **Codex look:** the window rows for P5 against the drawn table.
10. **Verdict: KEEP-WITH-NOTE.** Raise the point 7 follow-up as a carpark bug. The train class is Civil Pit Schedule area + smoke. It changes every pit that has a merged inlet row, but only the Pit Schedule and redesign review read it.

---

### #1412, BUG-783: a Delete cell stays blank in the drawn Pit Schedule

1. **What changes for the drafter.**
   1. **The marker.** "Delete cell" in the window saves the word DELETE as a marker for "blank".
   2. **Before.** The window showed blank, but the drawn table's refresh (`ScheduleLinkService.BuildCellText`) wrote the stored text, so the cell read "DELETE" after the next PITEDIT or CDSYNC. The redesign Apply then saw a cell that did not match and refused.
   3. **Now, in the drawn table.** One rule, `ScheduleCellOverrideText.Resolve`, turns the marker into a blank. It covers pit number, pit size, FROM, cover, both diameters, both levels and depth (ScheduleLinkService.cs:2000-2045, all in `BuildCellText`), plus lid and Remarks (ScheduleLinkService.cs:2609-2610, `BuildLidRemarksTextWithOverride`).
   4. **Now, in the window.** On a deep pit the window's Remarks come from the new `CombineRemarksWithStepIrons` (PitScheduleViewModel.Filters.cs:60-66). That reads the marker as blank, so the cell is "With Step Irons" instead of "DELETE With Step Irons".
   5. **Lid cell.** A blank lid in the shadow pit gives an empty lid line (`BuildLidRemarksLayout`), so a deleted lid cell is blank and not a default lid. That is correct.
   6. **Against the carpark and Tim's decisions.** The carpark asks for "Blank (or "With Step Irons" only, as Tim intends)". The deep-pit wording is QUESTIONS_FOR_MONDAY section I item 1, and it is still unanswered (no entry in `decisions`). The code applies the recommended answer, "With Step Irons" only, and the REGRESSION_LOG says so. This is a reasonable interim choice and not a decision. It must stay listed as Tim's open question.
2. **The Settings switch.**
   1. **Default:** ON, read through `ScheduleCellOverrideText.SwitchOn()` with ON as the fallback.
   2. **OFF in the drawn table.** OFF returns the stored text, the same as the old `?? string.Empty`.
   3. **OFF in the window is not exactly the old behaviour.** `CombineRemarksWithStepIrons` also calls `Resolve`, so with the switch OFF the window shows "DELETE With Step Irons" again, as before. That part matches. But the old window code computed `compactedBase` before the detention check and used a `separator` variable. The new code gives the same string, so the result is the same.
   4. **R-00.** No engineering value is involved.
3. **No hard blocks.** None added. It removes a cause of the redesign Apply refusal.
4. **Native protection, Undo and REDO (ScheduleLinkService.cs, extra care).**
   1. **No new write path.** The change only alters the text that the existing refresh computes. It adds no new drawing write, no new transaction and no new path around a locked layer, Xref or REFEDIT. The cell write still goes through the existing `RefreshLinkedCellFromRecord` writer and its protection check, unchanged.
   2. **Undo.** A refresh that now writes "" instead of "DELETE" is one cell text change inside the same command. U should put back what was there.
   3. **REDO.** REDO should be no different from any other refresh.
   4. **Not proven:** none of this has been driven in AutoCAD.
   5. **Note: older drawings.** A drawing whose drawn cell already reads "DELETE" from an earlier refresh now holds a cell whose text does not match what CE expects (""). I could not prove whether the next refresh rewrites it to blank or treats it as hand-edited and skips it. The robot must test this.
5. **Merge and sibling PRs.**
   1. **Clashes.** `git merge-tree` against #1415, #1426 and #1410 clashes only in UserSettings.cs and REGRESSION_LOG.md, and against #1424 only in REGRESSION_LOG.md. The fix is to keep both in each case, and that is already done on the train.
   2. **Different functions in ScheduleLinkService.cs.** #1412 changes `BuildCellText` (base lines 1887-1932) and `BuildLidRemarksTextWithOverride` (base line 2496). #1426 changes `TryHandleEditedCell` (base lines 175-356). #1410 changes `TryHandleEditedCell` (base lines 226 and 355) and `TryParseLevelNumber` (base line 3284). None of them changes a function that #1412 changes.
   3. **#1426 and #1410 share a function with each other.** Both touch `TryHandleEditedCell`. That pair belongs to jobs 613 and 614.
6. **Tests.**
   1. **`ScheduleDeleteCellStaysBlankTests` (10).** The key test, `ACoverCellDeletedInTheWindow_RefreshesToBlankNotTheWordDelete`, drives the real `RefreshLinkedCellFromRecord` with a cover override of "DELETE". On the old code it would write "DELETE", so it is a genuine before/after test, though the author did not run it red first.
   2. **Remarks test.** `CombineRemarksWithStepIrons` is tested in both letter cases.
   3. **Source guard.** One test checks the program text.
   4. **Your settings.** None touched. The tests run in the temporary-folder settings scope.
7. **Small notes.**
   1. **The marker word is defined in three places:** `PitScheduleViewModel.DeleteCellToken` (PitScheduleViewModel.cs:46), `ScheduleCellOverrideText.Marker` and a literal in ProjectDataService.Mutations.cs:1939. Design rule #1 says to point the other two at `ScheduleCellOverrideText.Marker`. It is a cleanup, not a fault.
   2. **A typed "Delete".** A drafter who types the word "Delete" as a real remark would see it blanked. This is negligible.
8. **What is NOT proven, and the robot scenario (CE 02).**
   1. **Reaching the route.** On 23 Oct Codex W2-03 was BLOCKED because the right-click menu had no Delete cell item (BUG-1031). The tip now carries the BUG-1031 menu switch `pitScheduleDeleteCellMenu`, so the robot must run on a build that includes it.
   2. **Not proven:** not driven in AutoCAD; net48 not built by the author.
   3. **Robot scenario.** Use a copy only.
      1. Run PITSCHEDULE. Right-click P3 Cover, choose Delete cell, Apply, and read the cell: blank.
      2. Run PITEDIT P3, change nothing, close, and read the cell: still blank. Then run CDSYNC and read it again: still blank.
      3. On a 1.2 m deep pit, run Delete cell on Remarks and Apply. The window cell reads "With Step Irons". Read the drawn cell and record whether it also carries the lid wording. The window and the drawn table must agree; I could not prove that they do.
      4. Run the CDDESIGN redesign Apply on that network. It should not refuse because of the cleared cell.
      5. Undo the step 2 refresh with U and the cell is back as before. Then REDO.
      6. Older-drawing case: a drawing already showing "DELETE" in a drawn cell. Run PITEDIT and record whether the cell becomes blank or is skipped as hand-edited.
      7. Set `scheduleDeleteCellStaysBlank` false before launch and repeat step 2. Expect "DELETE".
   4. **Codex look:** the deep-pit Remarks cell in the window and in the drawing, side by side.
9. **Verdict: KEEP-WITH-NOTE.** Keep QUESTIONS_FOR_MONDAY section I item 1 open, and test the older-drawing case. The train class is Civil Pit Schedule area + smoke.

---

### #1424, BUG-770 latent: the auto-design long section "flowing full" row carries full-bore capacity

1. **What changes.**
   1. **The change.** `LongSectionBridge.ToNodeRows` (LongSectionBridge.cs:99-106) now fills the row labelled "pipe flowing full" with the pipe's full-bore capacity instead of the design flow. The capacity is worked out by Manning's formula with the roughness from Settings: `DesignValidationService.ComputeFullBoreVelocity` (DesignValidationService.cs:133-148) times the pipe area (`ComputeEstablishedFullFlow`, ProfileRouteEvidenceCaptureService.cs:808-814).
   2. **No drawing changes.** Nothing in AutoCAD draws this row today, so no drawing changes.
2. **Worked example (Settings roughness UPVC 0.010, RCP 0.013, from UserSettings.cs:2745-2746).**
   1. **300 mm at 1 in 100 carrying 40 L/s.**
      1. Before: 40 L/s.
      2. After: 125.7 L/s. The area is 0.0707 m². The full-bore velocity is 1/0.010 × 0.075^(2/3) × 0.1 = 1.78 m/s. 1.78 × 0.0707 = 0.1257 m³/s.
   2. **The test pit B, 300 mm at 1 in 50 carrying 8 L/s.** Before: 8.0 L/s. After: 177.8 L/s.
   3. **The test pit A, 225 mm at 1 in 60 carrying 5 L/s.** Before: 5.0 L/s. After: 75.4 L/s.
   4. **The same 300 at 1 in 100 if it were concrete (n 0.013).** The right answer is 96.7 L/s, which is the figure in the carpark entry. CE would still show 125.7 L/s, because the bridge always assumes plastic (see point 3). The REGRESSION_LOG's "about 125 L/s" and the carpark's "96.7 L/s" are both right, for two different pipe materials.
3. **The Settings switch and R-00.**
   1. **Switch.** `longSectionBridgeFullBoreFlowRow`, ON. OFF gives the design flow exactly, and the test `ToNodeRows_ASwitchedOffBridge_KeepsTheDesignFlowAsToday` really switches it OFF and checks 5 and 8 L/s.
   2. **Roughness.** It is read from Settings (fixed in the 19 Oct review round). The test `ToNodeRows_FullFlowRow_FollowsTheSettingsRoughness` failed first and now passes.
   3. **Note (R-00): the pipe material is assumed.** The bridge uses the constant `DefaultPipeMaterial = "UPVC"` (LongSectionBridge.cs:29, from the July import) for every pipe. When this PR was written the design inputs had no pipe material. The tip now has one: `NetworkLink.Material` (NetworkDesignModels.cs:37, "blank means Unknown, never an inferred material").
   4. **What the follow-up should do, before anything draws this row.** Read the link's recorded material. When it is blank, use the Settings "not recognised" roughness (`GetNotRecognisedManningsN`), not plastic. Also show that material in `OutgoingMaterial` (line 93).
   5. **Why not now.** It is latent today, so it does not block.
4. **No hard blocks.** None added.
5. **Native protection and REDO.** Not relevant. The change is a pure calculation with no drawing access.
6. **Merge.** It clashes with #1415 and #1412 only in REGRESSION_LOG.md. The UserSettings.cs entry sits in a different spot and merges cleanly. It is already on the train.
7. **Tests.**
   1. **The new behaviour test.** It failed red first (8 L/s), then passed.
   2. **Two old tests changed.** Two older assertions pinned the design flow as "full flow" (5.0 and 8.0 L/s). They pinned the bug, and changing them was correct.
   3. **Roughness and switch-OFF tests.** These change the in-memory Settings and restore them in `finally`. They run inside the temporary-folder settings scope, so your real file was never touched.
   4. **Small note.** These two tests are not marked `NonParallelizable`. They are safe only while NUnit runs this project's tests one after another, which is the default.
8. **What is NOT proven, and the robot scenario.**
   1. **Not proven:** no AutoCAD command draws this row, so there is nothing for the robot to drive; net48 not built by the author; the other half of BUG-770 (a missing cover or invert shown as 0.0) is not done.
   2. **Scenario for later.** When the auto-design long section is wired in: a 300 UPVC at 1 in 100 shows 125.7 L/s and a 300 RCP at 1 in 100 shows 96.7 L/s. The second will fail until the point 3 follow-up is done.
9. **Verdict: KEEP-WITH-NOTE.** Before anything draws the row, follow up on the assumed pipe material, and keep BUG-770 open for the 0.0-level half. The train class is Civil area smoke only.
