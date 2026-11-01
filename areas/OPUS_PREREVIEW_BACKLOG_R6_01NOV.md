# Opus pre-review, backlog group r4: PRs #1807, #1815, #1215, #1803 (detention tank, raingarden, design drafts)

Written Sunday 1 November 2026, 13:35 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's and CE 01's request. The file is named R6 because it is the sixth backlog group in the triage file (areas\DRAFT_BACKLOG_TRIAGE_01NOV.md, item 6, "r4").
Current Civil line checked: `claude/rel-20261112a` at ccaf0783 (C-79c finalizer, 1 Nov 11:53), read with a read-only `git fetch`.
Heads reviewed: #1807 446980a0, #1815 57f93284, #1215 86991a3b, #1803 b76db8f3. All four are DRAFT and all are Civil only. None touches Structural, CE_SHARED, the Manager, or any protected file (LinkService.Persistence.cs, ProjectDataService.Persistence.cs, RulebookEngine.cs).
This review built nothing, ran no tests, installed nothing and did not open AutoCAD. I read the diffs, the authors' reports (areas\CODEX_BUILD_BD17_26OCT.md, CODEX_BUILD_BD26_26OCT.md, CODEX_BUILD_BD10_26OCT.md), the carpark entries and the decisions folder. I ran read-only `git fetch` and `git merge-tree` only. Nothing in C:\CE_PLAN\decisions names these four bugs, so I judged against the carpark entries.

## FOR TIM

1. **#1807, CDWT keeps a typed 0 for detention (BUG-1115): KEEP-WITH-NOTE, Civil area + smoke.** Example: you pick a library tank holding 1,000 L of detention and type 0. CE now records 0 L detention (all reuse); before, it quietly put 1,000 L back. Pressing Enter alone still keeps 1,000 L. The PR calls itself "blocked" by one PDF test. That test also fails on the same starting code in #1815's run, so it is a flaky test, not this change.
2. **#1815, raingarden says "[CE] Outlet not tracked" (BUG-1107): KEEP-WITH-NOTE, Civil area + smoke.** Example: you place a raingarden with CDRG and pipe its inlet to P3. The Inspector now says "[CE] Outlet not tracked" instead of "No outlet registered" (or "Unknown" in the other panel). It changes wording only. CE still does not record P3 as the outlet. The bug entry allows that ("or change the words"), but it is the smaller of the two fixes. Two names are misleading (see detail); worth renaming before merge, not a blocker.
3. **#1215, CDDESIGN summary prints the council's own C (BUG-509): CHANGE-NEEDED: close it, do not merge.** This is already fixed on the current line by an earlier change (HUNT2-C-05, 9 October). That one prints "0.40 (the council's own figure)" through the same single chooser the calculation uses. #1215 is a second, separate copy of that logic and clashes with it in the summary code. The robot should check HUNT2-C-05 instead, and BUG-509 in the carpark should point to it.
4. **#1803, keeps a damaged Design draft as a backup before Save Draft (BUG-1143): CHANGE-NEEDED (small), then Civil area + smoke plus a Codex window look.** Example: the saved Design draft in a drawing is damaged. Save Draft now keeps the old one in the drawing as a backup and says the CE administrator can recover it. That part is right. One rare case is wrong: if the stored draft is the wrong kind of drawing object, and either the switch is OFF or a backup already exists, CE quietly throws the old entry away. Before, CE refused to save in that case. So OFF does not restore the old behaviour exactly, and something is lost silently. It needs a three-line fix (detail, #1803 item 4).
5. **Settings switches:** #1807, #1815 and #1803 each add a switch that starts ON. Each is pinned in its own tests through the strict reader only, not through the start-up reader. Both readers give ON for an older file (checked by reading the code), so this is a gap in the tests, not a fault. The assembler should add all three to the C-79 defaults test class. #1215 has no switch (it is being closed anyway).
6. **Merging:** every PR clashes with the current line in the change log (REGRESSION_LOG.md); keep both entries. #1807 and #1803 also clash with each other in the Settings list (UserSettings.cs): both add their switch at the same spot, so keep both. #1803 also clashes in one test list (SettingsWindowV3Tests.cs): keep the line's list and add one name. No program code clashes, except #1215 (which is why it should be closed). #1803 and the newer "Save Draft keeps newer fields" change (#1956, already on the line) edit different parts of the same file and merge cleanly.
7. **Nobody has opened any of the four in AutoCAD.** All are built and unit-tested only, by their authors. All four bugs stay OPEN. No test I read touched your real settings file: each uses an in-memory copy or a throwaway file in the temp or test folder.
8. **For the robot:** #1807 needs a library tank that actually holds detention (every tank we ship holds 0 L, so the change is invisible on a normal job). #1803 needs a drawing with a deliberately damaged draft record. Both have to be made as test copies first.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases.** #1807 and #1815 sit on `claude/rel-20261026u` at 270215aa (333 commits behind the current line). #1803 sits on `claude/rel-20261025r` at d8840a09 (384 behind). #1215 sits on `claude/rel-20261009w` at 1f7495c9 (1,668 behind). None is stacked on another; each is a separate branch, so there is no stack to break.
2. **Merge onto the current line (read-only `git merge-tree` against ccaf0783).**
   1. **#1807:** conflict in REGRESSION_LOG.md only. UserSettings.cs and WaterTankCommand.cs merge cleanly.
   2. **#1815:** conflict in REGRESSION_LOG.md only. UserSettings.cs and InspectorPaletteService.cs merge cleanly.
   3. **#1803:** conflicts in REGRESSION_LOG.md and in `SettingsWindowV3Tests.cs` (the one long list of tracked Settings names, around line 391 of the merged file). Keep the line's list and add `"DesignKeepsUnreadableDraftBackup"` after `"CascadeKeepsPitDrop"`. CivilProjectStartDraftStorage.cs, both Settings windows, UserSettings.cs, the Settings model and the catalogue merge cleanly. No picture conflicts.
   4. **#1215:** conflicts in REGRESSION_LOG.md and in **DesignProposalReport.cs (program code)**. The line already replaced the same "Before-development C" line with HUNT2-C-05's `PreDevCText`.
3. **Merge within the group and with the named neighbours.**
   1. **#1807 with #1803:** UserSettings.cs conflict. Both add a switch directly after `RelinkKeepsRecordedDirection` in `LinkingSettings`. Keep both properties. REGRESSION_LOG.md: keep both.
   2. **#1807 with #1815, and #1815 with #1803:** REGRESSION_LOG.md only.
   3. **#1807 with #1808 (r3, WaterTankCommand.cs):** WaterTankCommand.cs merges cleanly; REGRESSION_LOG.md keep both. The triage note to keep them in separate merges is cautious but not needed for the code.
   4. **#1215 with #1217 (r3, AutoDesignService.cs):** AutoDesignService.cs merges cleanly; REGRESSION_LOG.md only. This is moot if #1215 is closed.
4. **The flaky PDF test.** `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` failed after #1807's change and passed on its base run. On the very same base (270215aa), #1815's author recorded it FAILING in the base run (REGRESSION_LOG entry in #1815, item 6). On #1803's base it also failed before the change and passed after. It flips on unchanged code, so it is not caused by any of these PRs. That clears #1807's self-declared "BLOCKED" status.
5. **Defaults pinning (R-00 and the switch rule).** The two start-up reads are `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant` (`SettingsService.cs:771` and `:784` on the line). Each PR pins its switch through `DeserializeSettings` with an empty file and with typed false. None calls `DeserializeSettingsTolerant`. All three switches are plain `bool` properties with `= true` initialisers, and the tolerant reader starts from the same model defaults and refills missing sections from `new UserSettings()`. So an older file reads ON through both (by reading, not by test). The C-79 assembler should add `cdwtTypedZeroDetentionIsKept`, `raingardenOutletRecorded` and `designKeepsUnreadableDraftBackup` to the C-79 defaults class, through both readers.
6. **No engineering value is hard-coded in any of the four.** No new number appears in #1807, #1815 or #1803. #1215 only reads existing figures.

---

### #1807 BUG-1115: keep a typed 0 for CDWT detention

1. **What changes for the drafter.** CDWT, command-line route (AutoCAD 2022-2026), with a library tank. At `Detention volume (litres) <1000>:`:
   1. **Typed 0:** now 0 L detention, all reuse. Before, it became 1,000 L.
   2. **Enter alone:** 1,000 L, as before.
   3. **Typed 400:** 400 L, as before.
   4. **Esc:** 1,000 L and the command carries on, as before.

   The code is at `WaterTankCommand.cs` lines 498-507 (new). The question now reads the prompt's own answer status (OK versus Enter) instead of the shared `PromptPositiveDouble`, which returns "true, 0" for both Enter and typed 0 (`WaterTankCommand.cs:662`). The decision is in the new `WaterTankCommand.TypedDetention.cs` lines 8-14. This is exactly the carpark entry ("A typed 0 is an answer", test "library tank with 1,000 L detention, typed 0, result 0").
2. **Switch.** `linking.cdwtTypedZeroDetentionIsKept`, default ON (`UserSettings.cs` +1077). OFF: `ResolveTypedDetention` puts the library figure back for any value of 0 or less. That is the same as the old two lines (`PromptPositiveDouble` false gives the library figure; 0 or less gives the library figure). I traced Enter, Esc, typed 0 and typed 400 with OFF, and each gives the old answer. Pinned in `Bug1115WaterTankDetentionTests.cs` lines 32-41 (empty file, empty linking group, typed false), but through the strict reader only (group fact 5). No Settings row: the author measured 689 px against the 673 px limit and left it out under the brief's exception. So the switch can only be changed by editing the settings file. That is acceptable for a LOW bug, but say so in the train notes.
3. **No-hard-blocks.** No stop, refusal or window is added. Negative numbers were refused before by AutoCAD's own prompt and still are.
4. **AutoCAD protection and REDO.** Only the number fed into the existing capacity check changes. Tank placement, the block, the label and the drawing write are untouched, so locked-layer, Xref, REFEDIT and REDO handling stay on their existing path. No protected file.
5. **Merge.** See group facts 2.1, 3.1 and 3.3.
6. **Tests.**
   1. **Red then green, but on the helper only.** The author first extracted the OLD logic unchanged into `ResolveTypedDetention` (commit d2b87228); the typed-0 test failed there ("Expected: 0, But was: 1000"), then passed after. That is a genuine red. But the bug itself lived in how the prompt's answer was read (Enter versus typed 0), and no test drives the prompt. That part is proven only in AutoCAD.
   2. **Settings.** `TheCommandReadsTheSwitchFromCurrentSettings` uses `BeginTestScope` with a path in the test work folder that is never written. The other settings checks are in memory. No real %APPDATA% use.
7. **Not proven, and the robot scenario.**
   1. **Not proven:** the prompt wiring in real AutoCAD, and the result on the tank callout and the project record.
   2. **Robot (CE 02):** on a copy of an Example Job drawing, first add a test library tank of 5,000 L holding 1,000 L detention (none shipped holds any). CDWT, choose it, type `0` at `Detention volume (litres) <1000>:`, place it. Right: 0 L detention, 5,000 L reuse, callout `5000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE`. Repeat with Enter alone (1,000 / 4,000) and with `400` (400 / 4,600). Then set the switch OFF in a copy of the settings file before starting AutoCAD (it is read at start-up) and repeat typed 0: right is 1,000 L. U after placement must remove the tank cleanly; REDO must put it back.
   3. **Codex:** no window change, so no window look is needed.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke.** Notes: (a) the PDF "blocker" is a flaky test (group fact 4), so lift the BLOCKED wording when it is assembled; (b) add the switch to the C-79 defaults class through both readers; (c) there is no Settings row, so OFF needs a file edit.

---

### #1815 BUG-1107: show when a raingarden outlet is not tracked

1. **What changes for the drafter.** Select a CDRG raingarden whose grated inlet carries a source tag (for example GIO1), where a recorded pipe has GIO1 as its From or To end (for example GIO1 to P3).
   1. **Older raingarden panel:** now "[CE] Outlet not tracked" instead of "No outlet registered" (`InspectorPaletteService.cs` +2412).
   2. **Civil Properties item rows:** now "[CE] Outlet not tracked" instead of a blank, which the author reports as "Unknown" (`InspectorPaletteService.cs` +1054).
   3. **A raingarden with a saved outlet (spoon drain):** still shows P3.
   4. **No recorded pipe:** the old words.

   The rule is `RaingardenOutletWords` (+2348 to +2364): a saved outlet wins; otherwise it reads the inlet's tag and looks for a recorded pipe end with that name. It never takes a nearby pipe or pit as a connection, and writes nothing. The carpark entry offers two fixes: record the outlet pit, OR "change the words to 'Outlet not tracked'". This PR does the second. That is allowed, but the carpark's own "Right looks like: outlet P3" is not met, so the AutoCAD check in the carpark must be rewritten to match before anyone counts this as fixed.
2. **Switch.** `linking.raingardenOutletRecorded`, default ON (`UserSettings.cs` +726). OFF returns the caller's old empty-outlet words (blank, or "No outlet registered") without reading the inlet (+2341). Tests prove both displays return exactly (`Bug1107RaingardenOutletTests.cs` lines 318-328). Pinned through the strict reader only (lines 257-264). No Settings row (689 px against the 673 px limit, left out under the exception).
   1. **Naming note (recommend fixing before merge, not a blocker).** The key `raingardenOutletRecorded` says the opposite of what it does: nothing is recorded. A drafter or administrator reading the settings file would think ON records the outlet. A name like `raingardenSaysOutletNotTracked` is honest. It costs nothing now and is permanent once shipped.
   2. **Naming note 2.** The test `RaingardenOutlet_Bug1107_InletPipeToPitP3_RecordsOutletP3` (line 218) asserts the words "[CE] Outlet not tracked" and that NO outlet is saved. Its name says the reverse. The comment explains it was a required name from the brief, but the robot or a later reader will be misled.
3. **No-hard-blocks.** None. Read-only wording.
4. **AutoCAD protection and REDO.** `ReadRaingardenSourceTag` (+2366 to +2382) opens the inlet block ForRead inside the Inspector's existing transaction and catches AutoCAD errors, so a missing or erased inlet shows the old words. Nothing is written, so locked layers, Xrefs, REFEDIT and REDO are not involved. The older panel reuses its one existing project read; a compiled-code test guards against adding another (lines 300-316). No protected file.
5. **Merge.** See group facts 2.2 and 3.2.
6. **Tests.**
   1. **Red then green:** the tests were committed before the change (fcbc0b20). The P3 case failed with "Unknown" on the unchanged code. The test calls the real `PopulateCivilOther` by reflection and adds the new argument only if it exists (lines 199-212), so the same test ran on old and new code. That is a genuine red.
   2. **Settings:** every test runs inside `BeginTestScope` with a throwaway temp-folder path. `ThemeService.PreviewPreference` (used in the picture test) only repaints and does not write the stored theme (`ThemeService.cs:82-85`). No real %APPDATA% use.
   3. **Pictures:** 16 of the 18 committed pictures (`bug1107-settings-*.png`) show the UNCHANGED Settings window, because the row was left out. They prove nothing about this change and add repository weight. Optional: drop them.
   4. **Small test fault (no product effect):** the picture test restores the theme as "dark, else always-light" (line 146), so a run that started on "follow AutoCAD" ends on light for later tests in the same run.
7. **Not proven, and the robot scenario.**
   1. **Not proven:** the real inlet tag read in AutoCAD, both panels on screen, and how the text looks in the real palette.
   2. **Robot (CE 02):** on a copy of an Example Job drawing, CDRG a raingarden with its inlet pipe to pit P3. Select the raingarden boundary. Right: the Outlet row reads `[CE] Outlet not tracked` in both the raingarden panel and Civil Properties. Then a raingarden with no inlet pipe: the old words. Then a spoon-drain raingarden with a saved outlet: `P3`. With the switch OFF (settings file copy edited before start-up): the old words in all three cases.
   3. **Codex:** a quick look at the Inspector in both themes to check the longer words fit the value column at 100 per cent scale.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke.** Notes: (a) recommend renaming the switch key before merge; (b) rewrite the carpark "Right looks like" line to the wording route; (c) add the switch to the C-79 defaults class through both readers.

---

### #1215 BUG-509: the summary prints the before-development C the discharge really used

1. **What changes for the drafter.** The CDDESIGN calculation summary line "Before-development C (whole site)" would print the council's C (0.40 for Darebin) marked "(council's value)", instead of the office 0.35 (`DesignProposalReport.cs` +114 to +121 on its old base). That matches the carpark entry. **But the current line already does this.** HUNT2-C-05 (commit 9793b9e7, 9 October; REGRESSION_LOG line 7813 on the line) prints `0.40  (the council's own figure)` and also marks a site-case C. It reads through the one chooser the calculation itself uses (`DetentionSizingService.ChoosePreDevC`), and it leaves the office figure alone when no C was used (council-provided discharge). See `DesignProposalReport.cs` lines 162-188 on ccaf0783. HUNT2-C-05 was not in #1215's base (checked with `git merge-base --is-ancestor`): the two were written in parallel for the same bug.
2. **Switch.** None. The PR says "No new Settings value" because only the printed line changes.
3. **No-hard-blocks.** None.
4. **Design rule 1 (one code path per behaviour).** `AutoDesignService.PreDevCUsedForDischarge` (+362 to +377) is a second hand-written copy of the C priority. It also differs from the calculation in one input: it looks up the site case with `inputs.SiteAreaM2`, while the calculation uses `catchment.TotalAreaM2` (`AutoDesignService.cs:359-360`). So on a site where those differ near a council's area threshold, it could print a C the calculation did not use. That is the very bug it sets out to fix. HUNT2-C-05 has the same area input, but it shares the single chooser.
5. **Merge.** Conflicts in program code (DesignProposalReport.cs) with the current line, because HUNT2-C-05 rewrote the same line.
6. **Tests.** Three tests (`Bug509PreDevCPrintedTests.cs`). The author says they did not compile before the helper existed, so there is no behavioural red. No settings use.
7. **Not proven, and the robot scenario.** Use HUNT2-C-05 instead. On a copy of a job, CDRULEBOOK, set the council to Darebin, CDDESIGN with detention on, open the summary. Right: "Before-development C (whole site) 0.40  (the council's own figure)", and the PSD works by hand with 0.40. Change to a council with no fixed C: 0.35. Kingston commercial: the site-case wording.
8. **Verdict: CHANGE-NEEDED: close #1215 without merging, as superseded by HUNT2-C-05.** Update the BUG-509 carpark entry to say "fix on line as HUNT2-C-05 (9793b9e7); awaiting robot/Codex pass", not FIXED. Train class: none.

---

### #1803 BUG-1143: keep unreadable Design drafts before saving

1. **What changes for the drafter.** CDDESIGN on a drawing whose saved Design draft cannot be read (it already starts a blank draft and says so). On Save Draft or Confirm setup, CE now copies the old draft record, unchanged byte for byte, into a second drawing record (`CE_CVL_DESIGN_START_DRAFT_UNREADABLE_BACKUP`) and then saves. It prints `[CE] The old Design draft could not be read. It has been kept in this drawing as a backup; the CE administrator can recover it.` (`CivilProjectStartDraftStorage.cs` +295). If a backup already exists, the earlier one is kept and a different message prints (+291). The backup and the save are one drawing change, so one U undoes both. All three Design save buttons go through this one `Save` (source guard, test lines 159-177). This is what the carpark entry asks for ("copy the old record to a backup key before any save").
2. **Switch.** `linking.designKeepsUnreadableDraftBackup`, default ON (`UserSettings.cs` +1045). It has a real Settings row on the Newer tools tab in both Settings windows (`AdvancedSettingsDialog.xaml` +1377, `CivilSettingsView.xaml` +363), with load, save, reset, search and changed-mark wiring (`AdvancedSettingsViewModel.NewerTools.cs`, `AdvancedSettingsViewModel.cs`, `SettingsValueCatalog.cs` +138). Pinned through the strict reader only (test lines 139-146). **OFF does NOT fully restore the old behaviour: see item 4.**
3. **No-hard-blocks.** With the switch ON, the old refusal for a wrong-type record ("The saved Design draft has the wrong drawing type", old line 316) is replaced by keeping that object under the backup name. That is the right direction for R-27.
4. **The fault (CHANGE-NEEDED).** In `Save`, when the stored entry is NOT a drawing record of the expected kind (`record == null`):
   1. **ON, no earlier backup:** the whole object is renamed to the backup name (+329). Correct.
   2. **ON, earlier backup already present:** `ShouldKeepUnreadableBackup` returns false, then line +341 `nod.Remove(RecordKey)` takes the old object out of the drawing's dictionary with no copy. Removing an entry does not erase the object; it is left orphaned and is dropped when the drawing is saved. The message printed says only that the earlier backup "has not been replaced". It does not say this draft is being thrown away.
   3. **OFF:** the same line +341 removes it with no copy and saves. The old code refused (threw) here. So OFF is a new, silent behaviour, not the old one.

   **Fix:** when `record == null` and no backup is being made, do not remove it silently. Smallest safe form:
   1. **If the switch is OFF:** keep the old refusal exactly (throw the same "wrong drawing type" error).
   2. **If ON and a backup already exists:** keep the object under a second name (for example the backup key plus the date), or leave it in place, warn, and save the draft beside it.

   Either way, add a test for the wrong-type case with an earlier backup and with OFF. Also reword the earlier-backup message for a readable-kind record (+291) so it says plainly that this damaged draft is replaced without a copy. Today a second damaged draft is lost and the message reads as though nothing was lost. This case is rare (another program would have to write that drawing record), but it is a silent loss of the very thing the bug is about.
5. **AutoCAD protection and REDO.** Only the drawing's own named records are written, inside the existing document lock and transaction (`Save`, +306 onward). No entity, layer or Xref is touched. The message prints after `Commit` (+356), so a failed write rolls back both records and says nothing. A small extra change: the new draft's buffer is now disposed after use (+352). It runs with the switch OFF too, but it is harmless (AutoCAD copies the data). No protected file. Overlap with C-79b2 #1956 (BUG-1156, on the line): #1956 changed `Decode` (+52 to +62 on the line); #1803 changes `Save` and only calls `Decode` to test readability. Different functions, clean auto-merge, no clash of intent. One consequence to know: with #1956's switch OFF, `Decode` strips unknown fields but does not throw, so a newer-build draft still counts as readable. That is correct.
6. **Tests.**
   1. **Red then green, but against a stub.** The red was taken against a compiling stub that returned false (report BD10 item 3), not against the old `Save`. No test drives the real `Save` against an AutoCAD drawing, so the backup write, the rename and the U behaviour are proven only by reading and by a source-order guard.
   2. **Window size.** The new row was measured at 670 px against the 673 px limit on the OLD base. Since then the line has added rows to both Settings windows (for example `TidyTextAfterMove`, `BoxRefusesCommaFigure`, `UnsetMaterialUsesOfficeFigure`). The PR adds a real check (`SettingsWindowV3Tests.cs` +54 to +56: tallest tab ≤ 673 px), so the assembled train will catch it if the row no longer fits. If it fails, move the row or take the height exception. Do not squeeze the layout.
   3. **Pictures.** The 16 re-taken `settings-*.png` pictures were made on the old base, so they will be out of date on the line. Re-take them on the assembled train.
   4. **Settings.** Settings tests use `DeserializeSettings` on literal text and in-memory objects. The picture test reuses the existing render helper. No real %APPDATA% use found in the new code.
   5. **Duplicate test.** `Bug1143_DesignDraftBackupRow_RendersEveryRealTabAt1080p` simply calls the existing render test again, so the same 16 renders run twice. Harmless, slower.
7. **Not proven, and the robot scenario.**
   1. **Not proven:** the backup and rename in a real drawing, the message, U and REDO, and the Settings row on screen.
   2. **Robot (CE 02):** on a COPY of a synthetic drawing, put the text `{bad draft json` into the Design draft record (no backup present). Record its exact contents. Open CDDESIGN (it says it is starting a fresh draft), press Save Draft. Right: the backup record holds exactly the old contents, the new draft is saved, and the message above prints. Then U: both records go back to before. REDO: both return. Repeat with Confirm setup. Repeat with an earlier, different backup already present: the earlier backup is unchanged. With the switch OFF (Settings, Newer tools tab): no backup is made, as before. Save, close and reopen the drawing, and check the backup is still there.
   3. **Codex:** look at the Newer tools tab in both themes at 1080p on the assembled train to check the row fits with no scroll bar.
8. **Verdict: CHANGE-NEEDED (item 4: wrong-type entry silently removed with OFF or with an earlier backup; the earlier-backup message). Train class after the fix: Civil area + smoke, plus a Codex window look.**
