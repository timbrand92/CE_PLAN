# BUG-816 fix report (B-025, Fri 30 Oct 2026)

## FOR TIM

1. **Draft PR:** #1875 (branch fb/bug816-tidy-setting-row, against claude/rel-20261026z). Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-816 is NOT marked fixed.
2. **What you will see differently:** a new tick box in Settings, Drafting tab, under "After a MOVE": "After a MOVE, CE tidies labels that land on other text, and says so on the command line". It is ticked by default, so nothing changes unless you untick it. Unticked, a MOVE of a pit moves no pipe label and prints no "no clear spot among its usual positions, left where it is" line.
3. **Why it was needed:** those lines come from a tidy step that always runs after a MOVE (your 14 Sep ruling). It is not the Tidy labels command, so switching Tidy labels off never silenced it, and no setting named it.
4. **Worked example:** pit P3 is moved 2 m. Its "start invert" text now lands on the P2 label. Ticked: CE slides the text to the nearest clear spot, or prints "pipe P3 -> P2 label: no clear spot ... left where it is". Unticked: the text stays exactly where the move left it and the command line says nothing. The Tidy labels command (CDTIDYLABELS) works the same either way.
5. **My mistakes first:** (a) the job was restarted and the earlier attempt left a temporary probe file and a Settings-page-too-tall failure; I removed the probe and the row sits on the Drafting tab, which has room (the Newer tools tab did not). (b) The full suite reported 3 failures; I could not prove on the base that two of them were already failing (see below).
6. **BUG-1232 (sheet border treated as a clash):** NOT covered by this change and not built. This switch turns the whole step on or off; it does not change what counts as an obstacle. The border is already meant to be ignored by BUG-141's switch (`linking.tidyIgnoresSheetFrame`, ON in 3.0.85), yet the robot lines on 3.0.84 and 3.0.85 still named "Drawing Border". Ranked suspects, not proven: (1) the robot's test drawing border fails the size or position tests in `Rules/TidyObstacleRule.cs` `IsSheetFrame` (line 30), so it is still counted as an ordinary block; (2) the border is read at a block place `LinkService.TextClashTidyUp.cs` line ~699 only when it is in `PlainBlocks`, so a nested or dynamic border block escapes the test; (3) the run logs predate 3.0.85. A hand check on a real bordered sheet is needed first.
7. **Settings answer:** the "Default: on" row is the recommended answer in QUESTIONS_FOR_MONDAY; your word replaces it.

---

## TECHNICAL

1. **PR:** #1875, DRAFT. Commit 1c270c45. Files: `Modules/Drainage/Models/UserSettings.cs` (new `Linking.TidyTextAfterMove`, key `tidyTextAfterMove`, documented "Default: on."), `Rules/TextClashTidyUpRule.cs` (`AfterMoveEnabled`, `IsAfterMoveOn`, `SkipsAfterMove`), `Services/LinkService.TextClashTidyUp.cs` (gate at the entry and again in `TidyOnePipe` after the placed-by-hand mark), `ViewModels/AdvancedSettingsViewModel.cs`, `.DraftingFixes.cs`, `SettingsValueCatalog.cs`, `Dialogs/AdvancedSettingsDialog.xaml`, `Dialogs/CivilSettingsView.xaml`, REGRESSION_LOG.md, tests.
2. **Switch:** `tidy` convention nearest: `linking.tidyTextAfterMove`, ON. A missing file or group reads ON (R-27). OFF skips only; the CE log writes "[TidyUp] route=... skipped: Linking.TidyTextAfterMove is OFF". The Tidy labels command passes an outcome object and is never skipped.
3. **Cause (confirmed by reading):** entry is the after-MOVE tidy in `LinkService.TextClashTidyUp.cs` (always-on since D9); no setting guarded it.
4. **Tests:** new `Bug816TidyAfterMoveSwitchTests` (default ON; both `DeserializeSettings` and `DeserializeSettingsTolerant` with key absent and typed false; truth table; planner does not read the switch so ON equals today; source guards: gate in both places, mark written before the gate, command does not read the key, no write, command, regen or system variable in the rule). Existing Settings row, persistence, changed-mark and page-height tests extended for the new row.
5. **Results:** focused net10 (Bug816, Bj34, Settings window, C60 rows, Downpipe rows, C60 audit, Bug141, C75): 245 passed, 0 failed, 3 skipped. Full net10 suite: 20787 passed, 3 failed, 32 skipped, of 20822. Failures: `Diagnostic_MessagesReachTheLogFile` (passes alone, with the PDF page test, 2 of 2) and two IL-shape tests in `SourceAtomicCoordinatorDependencyTests` (`FinalLandingProducerCollapses...`, `RefusedNativeCallbackInvalidates...`), in files this PR does not touch; they also failed on an earlier run of this branch. NOT proven pre-existing on a clean base (not run: build slots). Net48 compile: 0 errors, 242 warnings.
6. **Not proven:** nothing seen in AutoCAD; no robot run; no Codex look. The Settings row's look (a window) needs a Codex look in real AutoCAD: cases needed are (a) Settings, Drafting tab at 100% and 150% showing the new row inside the page, light and dark; (b) Civil settings view showing the "AFTER A MOVE" group.
7. **Robot case proposed: N33_tidy_after_move_off (twin C33_on).** Setup: start AutoCAD with `linking.tidyTextAfterMove` false in the copy's settings file (read at launch). Type MOVE on pit P3 of the run-33 test drawing (new pit P8, 20 m pipe) by the usual typed chain. Checks: command-line text does NOT contain "no clear spot" or "label: moved"; CE log contains "[TidyUp] route=" and "skipped: Linking.TidyTextAfterMove is OFF"; the label text positions (read by the driver) are unchanged by the tidy. Control C33_on: same drawing, key absent or true: the command line still carries the "pipe P3 -> P2 label" lines as in run 33.
8. **Undo:** revert 1c270c45 or set the key to true.

---

# FOLLOW-UP (B-025b, Fri 30 Oct 2026, 19:45 Melbourne): fixing PR #1875 after the Opus pre-review

## FOR TIM

1. **Answer:** PR #1875 is still a DRAFT, now at commit 1a6c332b on the same branch. The tick box now switches off only what its words say: the tidy after MOVE, STRETCH, ROTATE, SCALE, TRIM, JOIN and grip edits (also ALIGN, EXTEND, LENGTHEN, FILLET, CHAMFER, PEDIT, which run the same step). Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-816 stays open.
2. **What you will see:** untick the box, then draw a new pipe, save Edit Pipe, change a pit size in Edit Pit or place a source that splits a pipe: the labels still slide clear and the lines still print, exactly as today. Untick it and MOVE a pit: no label slides and no "no clear spot" line.
3. **The words changed:** the row now reads "After a MOVE, STRETCH or other AutoCAD edit, CE slides its labels off other text, and says so on the command line". The tooltip lists the commands and says drawing a pipe, Edit Pipe, Edit Pit and splitting a pipe with a source always tidy.
4. **Which window:** the row is in the main Settings window, Drafting tab, under the heading KEEPING LABELS CLEAR. My earlier report said "under After a MOVE": that was wrong for this window. Only the Civil settings view has its own group for it; I renamed that group AFTER AN EDIT COMMAND.
5. **Page height:** measured by a new test. Drafting tab needs 606 px, the tallest tab (Survey) 670 px, the limit 670 px. The row did not make any tab taller than the limit. Output is below.
6. **My own mistakes first:** (a) the first version switched off far more than its words said (the Opus review caught it). (b) My old test expected Tidy labels OFF by default; your 29 Oct ruling made it ON on the C-77 and C-78 trains. On this branch's own base it is still OFF, so I did not hard-code either: the test now asks "is it the built-in default", true on both. (c) I could not update the PR description (no GitHub command on this machine); the PR text still describes the first version, and this file and the commit are the true record.
7. **The three failed tests:** gone. I ran the whole Civil suite once in Release: 20805 passed, 0 failed, 32 skipped.
8. **PRs #1871 and #1873:** I checked both branches. Neither has this test or this switch, so they do not carry the wrong Tidy labels expectation. Their own Tidy labels default tests already expect ON. Nothing edited there.
9. **What the robot must prove (not proven yet):** see the robot cases below.

---

## TECHNICAL

1. **Fix:** `Rules/TextClashTidyUpRule.cs`: new `IsNativeEditRoute(route)` (true for atomic-attachment-move, atomic-straight-pipe, established, established-after-typed-edit); `SkipsAfterMove(isTidyLabelsCommand, route, switchOn)` now also needs a native-edit route. `Services/LinkService.TextClashTidyUp.cs`: the entry works out `skipAfterEdit` once from the route and passes it to `TidyOnePipe` (new optional parameter, default false, so `TidyMainOfNewBranch` and every draw / edit-pipe / pit-boundary / split pass is never skipped). The placed-by-hand mark is still written before the skip. Draw route's BUG-197 branch-onto-main tidy is also never skipped.
2. **Words:** `AdvancedSettingsDialog.xaml` (row, tooltip, automation name), `CivilSettingsView.xaml` (same, group renamed), `SettingsValueCatalog.cs`, `UserSettings.cs` summary left as is except it still says "after a MOVE" in a doc comment (not shown to users). REGRESSION_LOG entry rewritten in place.
3. **Tests (Bug816TidyAfterMoveSwitchTests):** the four native-edit routes skipped when OFF and run when ON; draw, edit-pipe, pit-boundary, split, cdtidylabels-count, cdtidylabels-apply, "atomic" and null route never skipped when OFF; the callers use exactly those route strings (source check); the wording names the commands; truth table by route; line 62 expectation now `EqualTo(new LinkingSettings().TidyLabelsEnabled)`. Switch default through BOTH start-up reads still pinned.
4. **Honest limit:** these tests prove the rule and the route names; they do not drive `TidyTextClashesAfterNativeMove` itself (it needs a live drawing). That is what the robot cases are for.
5. **Results:** focused net10 Release (Bug816, Bj34, SettingsWindowV3, C75, TextClashTidy): 135 tests, 1 failed first run (the line-62 test on this base, fixed as above), all passed after; full Civil suite net10 Release: Passed 20805, Failed 0, Skipped 32, Total 20837 (18 m 31 s). net48 compile of the Drainage project: 0 errors, 242 warnings. A placeholder empty `CE_TRANSFORM_2027.arx` (git-ignored) was needed in the worktree to build.
6. **Drafting tab height (test `DraftingTab_WithTheTidyAfterEditRow_MeasuresUnderTheAgreedHeight`, 1920x1080, dark, 100%):**
   - tab 'Drafting' needs 606 px
   - tab 'Pipes & Pits' needs 622 px
   - tab 'Design' needs 643 px
   - tab 'Survey' needs 670 px
   - tab 'Display' needs 478 px
   - tab 'Advanced' needs 652 px
   - tab 'Newer tools' needs 668 px
   - tab 'Fixes' needs 669 px
   - Drafting tab 606 px; tallest tab 670 px; limit 670 px
   The existing 5-screen fit tests and the no-scrollbar test passed in the same run. A Codex look at the row (100% and 150%, light and dark) is still needed. The Civil settings view page is already inside a scroll area (existing state, not this change).
7. **Not proven:** anything in AutoCAD; the merged train (this branch is on the C-75 base, 3.0.85; the review wants it rebased onto claude/rel-20261102a after C-78: the only clash expected is REGRESSION_LOG.md, keep both). The PR description is stale (no gh on this PC).
8. **Robot cases (need a settings copy with `linking.tidyTextAfterMove` false before AutoCAD starts):**
   1. **N33_tidy_after_move_off (twin C33_on, run twice in two sessions):** type MOVE on pit P3 of the run-33 drawing, base 0,0, second point 0,2000. Right: no "no clear spot" and no "label: moved" line on the command line; CE log has "[TidyUp] route=" and "skipped: Linking.TidyTextAfterMove is OFF" (except on the atomic-attachment route, where only "[TidyUp] route=atomic-attachment-move pipes=N ... reports=0" appears). Labels still travel with the pit end (BUG-1252 is separate), so compare OFF with ON, not with before the MOVE. Control C33_on: key absent or true, same MOVE prints the "pipe P3 -> P2 label" lines.
   2. **N34_tidy_draw_still_on (control C34_on):** key false; draw a new pipe with CD from a pit so its start invert text lands on the pit. Right: the text still slides clear and the "[CE Civil]" line still prints; CE log has no "skipped: Linking.TidyTextAfterMove". The same drawing with the key true gives the same result: that equality is the proof.
   3. **Optional N35_tidy_stretch_off:** key false, STRETCH a pit by crossing window: no label slide, log has the "skipped" line.
9. **Undo:** revert 1a6c332b (keeps the first version) or set the key to true.
10. **BUG-1232** (sheet border counted as a clash) is not touched.
