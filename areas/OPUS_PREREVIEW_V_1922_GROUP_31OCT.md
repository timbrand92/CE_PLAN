# Opus pre-review V: PRs #1922, #1923, #1924, #1925, #1926 (Civil fixes from job z3)

Written Saturday 31 October 2026 by an independent read-only Opus reviewer for CE 05 / CE 00.
All five are one commit each on top of `claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88); the merge base of each is that tip exactly.
Heads reviewed: #1922 7a3238a7, #1923 e3dfb957, #1924 677b7eb6, #1925 8b7ee79b, #1926 f0b98291.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code and ran read-only `git merge-tree` checks only.

## FOR TIM

1. **#1922 (test runs stop writing your real Structural logs): KEEP, train class Structural area + smoke.** Nothing changes in AutoCAD or in any drawing. Shared code (CE_SHARED) is untouched: I checked.
2. **#1923 (double-click a pit label opens Edit Pit): KEEP-WITH-NOTE, FULL class.** It only acts once the main double-click switch is turned on, which you said stays off until Codex has looked (22 Oct). So on its own it changes nothing for anyone yet. Needs the robot case and one Codex look with the main switch on.
3. **#1924 (CDCATCHMENT label finds a clear spot): KEEP-WITH-NOTE, Civil area + smoke.** The label now dodges pipe wording and other text. Gap: it does not see pit labels (P8 blocks), leaders or text inside Xrefs, so it can step off the pipe wording onto a pit label. The robot case must check that.
4. **#1925 (two Save As Xrefs read as two sources): KEEP-WITH-NOTE, Civil area + smoke.** The fix is right and uses the switch that already exists. One small side change: a read that hit the size limit is now remembered instead of retried. It makes no difference on a real job, but the PR says "OFF is exactly the old behaviour", which is not quite true. Write that down; no code change needed.
5. **#1926 (CHECK THE SCALE and the no-units note show on the import window): KEEP, Civil area + smoke.** It only changes wording on the "Pit and pipe schedule" page. The scale, the import and the Continue button are unchanged. Your 29 Oct ruling (a note, never a block) is kept.
6. **No new hard block anywhere in the five.** Nothing is unlocked, nothing is written on a locked layer, no Xref or in-place block edit is touched. Only #1924 draws anything, and it only draws the label it already drew.
7. **Merging:** the only clash inside the group is the change-log file (REGRESSION_LOG.md), where both sides are kept. #1923 does not clash at all. #1924 and #1926 both add a setting to the same settings file in different places and merge cleanly. Any order works.
8. **Not proven by anyone:** all five are built and unit-tested only. Nobody has opened any of them in AutoCAD. BUG-430, BUG-642, BUG-505 and BUG-788 all stay OPEN until the robot cases and Codex looks below pass.

---

## DETAIL

### PR #1922: B-099, Structural test runs on the Civil line write nothing into the real CE folders

1. **What changes for the drafter:** nothing. In AutoCAD the variable `CE_LOG_DIR_OVERRIDE` is never set, so every Structural log folder is built exactly as before. Each change wraps the old path in `LogFolderRedirect.Resolve(...)`, which returns the same path when the variable is not set (`Modules/Structural/Services/LogFolderRedirect.cs` 25-28). The PR wraps these: `Logger.cs` 33-38, `LoggingService.cs` 66-69 and 78, `CommandHistoryService.cs` 71-77, `XclmTxtService.cs` 2732-2737, `ExcelMTextService.cs` 2476, `StructuralCommandLogger.cs` 39-49, plus the two read-only log reads in `HealthCheckService.cs` 78-81 and `SupportBundleService.cs` 23-26. This is what Tim's decision 153 asks for ("6yes": test runs write to a separate folder, never Tim's real records).
2. **CE_SHARED untouched:** `git diff rel-20261102a..7a3238a7 -- Shared` is empty. Confirmed. The shared watch `Modules/TestSupport/RealFolderWatch.cs` is test-only and linked into the three test projects with a `Compile Include ... Link` line. It is not a shared product file.
3. **Settings switch:** none, and that is right. The variable is a test-only seam with no AutoCAD effect, which is the same reasoning as BUG-348 item 6. No engineering value is involved (R-00 not in play).
4. **No hard blocks (R-27):** none. Nothing in product code stops, refuses or opens a window.
5. **Native protection and REDO:** no drawing access at all. No write, regen, view or system variable change.
6. **Small notes (no change needed):**
   1. With the variable set, `StructuralCommandLogger` (line 41-43), `XclmTxt` and `ExcelMText` all write straight into the one override folder, not into their own sub-folders. `LogFolderRedirect.ResolveSubfolder` exists (lines 34-44) but is not used. File names differ, so nothing collides. It is just untidy.
   2. `RealFolderWatch.ForRealFolders` (lines 125-157) does not watch `CE_STRUC_SUITE\Logs\StructuralCommands` or `...\Logs\ExcelMText`. If a later change broke those two redirects, the watch would not notice. The source guard in `TestLogFolderGuardTests` ("every Structural file that builds a log folder under AppData goes through the seam") covers that instead.
   3. Known limit, stated in the PR: a failing real-folder teardown prints loudly but `dotnet test` still exits 0 unless `ZzRealFolderGuard` is in the filter.
   4. In the robot scripts under `C:\ce-fx` I found no use of `CE_LOG_DIR_OVERRIDE`. This search was limited to `.ps1`, `.py` and `.json` files, with a time limit. If the robot ever launches AutoCAD with it set, Structural logs would move with Civil's.
7. **Tests:** `TestLogFolderGuardTests` checks that every Structural logger resolves away from the real %APPDATA% while the override is on. Before the fix these fail, because `Logger`, `LoggingService` and `StructuralCommandLogger` had no seam. A real test. `RealFolderWatchControlTests.RealFolderWatch_ReportsAPlantedFile` is the positive control: it plants a file in a scratch temp folder and checks that the watch reports CREATED and CHANGED. The watch only reads names, sizes and times from the real folders and never writes them. Manager.Tests was compiled but not run (PR body).
8. **Not proven:** that a full Structural test run on this line leaves every real folder unchanged. The author's single before/after listing (33,287 files, 0 differences, AutoCAD closed) is one run, not repeated. No AutoCAD scenario is needed. The proof is a full test run in the evening window with the real-folder listing compared before and after.
9. **Verdict: KEEP. Train class: Structural area + smoke** (test projects and log paths only; Civil's Drainage.Tests and Manager.Tests also gain the shared watch).

### PR #1923: B-110, BUG-430, a double-click on a pit label stops AutoCAD's attribute editor first and opens Edit Pit

1. **What changes for the drafter:** first turn the main switch `doubleClick.opensEditWindow` ON, which is still OFF by default (Tim, 22 Oct). Then a double-click on a linked pit label (the P8 block) opens Edit Pit, and AutoCAD's Enhanced Attribute Editor never opens first. A sheet border or Xref plan around the label no longer makes CE back off. This matches the carpark entry (`BUG_CARPARK.md` BUG-430, Codex L4-01a twice) and Tim's 17 Oct ruling G2 (double-click any CE object opens its Edit window).
   1. The handler `OnDocumentLockModeChanged` (`Services/CompoundEditModeService.cs` about 994-1069) now also refuses AutoCAD's lock for EATTEDIT when the block under the pointer is a pit label proven by both sides. The label must name its pit and the pit must list the label: `TryReadLinkedPitLabel`, 815-847, using the same `LinkService.ReadRecordedOwnerForEdit` proof. The handler then registers the pit (not the label) for CDEDIT (1054-1056).
   2. The hit-test (`Services/DoubleClickHitTest.cs` 119-123) treats a linked pit label like a tagged block, so a frame strictly round it is ignored. A pit, a downpipe, another label or a block inside the label under the pointer stays "ambiguous", and CE leaves it to AutoCAD.
2. **Settings switch:** `doubleClick.pitLabelStopsAttributeEditorFirst`, default ON (`Models/DoubleClickSettings.cs` 57-70; the default sits in one constant, line 70). It is pinned through both start-up reads (`Bug430PitLabelStopsAttributeEditorTests.TheSwitch_LoadsOn_ThroughBothStartUpReads...`), and that test also pins `opensEditWindow` as still OFF.
   1. **OFF restores the old behaviour exactly.** I traced it. With `pitLabelLook` false, the gate (about 998) reduces to the old `ShouldLook` test. `TryFindBlockUnderDoubleClick` is called without the flag, so no owner proof is read and no candidate is marked. `stopTagged` equals the old `ShouldStop`, and `stopPitLabel` is false. The command-start path (319-321) is the same.
   2. There is no Settings page row. The sibling BUG-859 switch has none either. File-only.
   3. No engineering value is involved.
3. **No hard blocks (R-27):** CE refuses AutoCAD's own lock only to send the drafter to Edit Pit. That is the redirect Tim asked for, not a block on the drafter. No new stop, refusal or window.
4. **Native protection and REDO:** read only. The handler and the proof use one open-close transaction, ForRead (the test pins no ForWrite, one `StartOpenCloseTransaction`, no lock set), plus a read of REFEDITNAME, which is treated as "in REFEDIT" if it cannot be read. A label or pit on a locked layer, an Xref pit (`IsFromExternalReference` / `IsFromOverlayReference`, 833-835) and an open REFEDIT all keep AutoCAD's own answer. No new write, regen, view or system variable change. The only action is the CDEDIT that the double-click already starts.
5. **Tests:** a real fail-before, pass-after set.
   1. `ALinkedPitLabelInsideAFrame_IsTheOneBlock` and the Xref-plan case would not even compile before the fix (no `isLinkedPitLabel`), and with the flag false they return Ambiguous. `TheSameLabelNotMarkedLinked_StaysAmbiguous` pins that switch-off answer.
   2. The decision tests are pure tables.
   3. The handler order tests are source guards (text positions in the file). They prove order and read-only. They cannot prove that AutoCAD fires the lock notice before its window opens for a pit label. That is only shown for the downpipe (robot R09 on 3.0.88).
   4. No test touches %APPDATA%: settings are read from JSON strings.
6. **NOTE (why KEEP-WITH-NOTE):**
   1. The cause (b) "frame round the label" and the race (a) come from reading the code. The z3 report says plainly that the race for pit labels is inferred from downpipe runs.
   2. The main switch is OFF, so this PR proves nothing for drafters until someone runs with `doubleClick.opensEditWindow` set to true before AutoCAD starts (memory: settings are read at launch).
   3. The owner proof runs only for blocks under the pointer, so speed is fine. On a drawing with thousands of blocks the extents of every block are still read, as before.
7. **Not proven, and the AutoCAD scenario:** robot case N95_pitlabel_dblclick, set up before launch with `doubleClick.opensEditWindow: true`.
   1. Double-click the P8 pit label in model space with no frame. Pass = Edit Pit for P8 opens, the Enhanced Attribute Editor does not, and the log has the "EATTEDIT stopped ... pit label" line.
   2. Repeat with a sheet border block round the area, and again with an Xref plan attached under it.
   3. **Controls:**
      1. P8's label layer locked: the Enhanced Attribute Editor opens.
      2. Inside REFEDIT: AutoCAD's editor.
      3. `pitLabelStopsAttributeEditorFirst` false: the old behaviour (the Enhanced Attribute Editor opens).
   4. Cancel Edit Pit, then U and REDO: the drawing is unchanged and REDO is still available.
   5. **Codex look:** a single visual check that only Edit Pit appears (no flash of the attribute editor).
8. **Verdict: KEEP-WITH-NOTE.** No code change. The note: BUG-430 stays OPEN, and the main switch is flipped only after N95 and the Codex look pass. **Train class: FULL** (it changes the shared double-click handler that every double-click passes through).

### PR #1924: B-111, BUG-642, the CDCATCHMENT label looks for a clear spot

1. **What changes for the drafter:** each grated-pit catchment label now tries these spots in order: up-right (the old spot), up-left, down-right, down-left, then the same four at twice the distance. It takes the first spot where the whole label box clears existing TEXT and MTEXT in model space and the labels already placed in this run (`Services/CatchmentOverlayStyle.cs` 85-125; `Services/GratedPitCatchmentOverlayService.cs` 138-185). If none is clear, the label stays at the old spot and the command line says "[CE] P1 catchment label could not find a clear spot; check it." (`CatchmentOverlayCommand.cs` 123). This is what the z3 report asked for and what the carpark entry needs.
2. **Settings switch:** `surface.catchmentOverlayLabelAvoidsText`, ON (`Models/UserSettings.cs` 3223-3231). It is pinned through both start-up reads in `C75NewSwitchDefaultsTests` (130-149) and again in `Bug642LabelClearSpotTests.NewValues_LoadOn200...`.
   1. **OFF restores the old behaviour exactly:** no text is read (line 140), the spot is `LabelPoint` (pit + 300, + 300) and the height is 200 (`LabelHeight` returns `OldLabelHeightMm` when OFF, line 54). `Draw` now returns a list, which is empty when OFF.
   2. **R-00:** the typed-in 200 is now `surface.catchmentOverlayLabelHeightMm` (3233-3238). Odd coupling: the height setting only works while the avoid-text switch is ON. A drafter who sets 250 with the switch OFF still gets 200. Acceptable as "OFF = exactly the old", but it should be written in the setting's note. Tim may expect the height to work on its own.
   3. The estimate factor 0.9 (line 43) is a fallback only, not a drafting value.
   4. There is no Settings page row, because none of the four older catchment-overlay values have one (the f2 report says the same). File-only.
3. **No hard blocks (R-27):** none. "No clear spot" is a warning line, and a failed search leaves the label where it was (catch at 180-184).
4. **Native protection and REDO:** the only new write is moving the label CE has just created (`label.Location`, line 168), inside the same command transaction, so the label lands in the same Undo. Reading the existing text is ForRead only (pinned by a source test). No unlock, regen, view or system variable change. Text on locked layers is only read, as an obstacle, which is correct. The overlay layer handling is unchanged.
5. **NOTE, the gap that matters on a real drawing:** `ReadTextBoxes` (189-209) sees only TEXT and MTEXT objects placed directly in model space. It does not see:
   1. pit labels (the P8 blocks with an attribute);
   2. MLEADER text (TextService line 1451 makes leaders);
   3. text inside blocks or Xrefs (a surveyor's plan);
   4. dimensions.
   The pipe wording CE writes is MText or DBText, so the bug as reported is covered. But the down-right and down-left spots may move the label onto the pit's own P8 label. The robot case must check this. A follow-up can add block references to the obstacle list if it happens.
6. **Tests:** `PipeNoteOnTheOldSpot_ChooserGivesAClearSpot...` checks the old spot clashes and the chooser returns down-right (300, -500). I worked through the boxes and they are right. This fails before (there was no chooser). The every-spot-blocked, second-label and switch-off tests are real. The `Draw` wiring is covered only by a source-text guard. `ActualWidth` and `ActualHeight` on a just-added MText are not proven outside AutoCAD (the f2 report says so). No %APPDATA% access: settings come from JSON strings. The class is `internal sealed`, which NUnit 3 does discover. The author reports focused passes, but I could not check the count.
7. **Not proven, and the AutoCAD scenario:** robot case N97_catch_label_clear (z3 called it N96; check the numbering against #1926's N96).
   1. Make a copy of the two-pit 84 m² catchment drawing. Type `CDCATCHMENT`, pick the outline and P1 and P2.
   2. Read the box of each label on the overlay layer, the "225 DIA. UPVC PIPE AT 1 IN 48" text and the P1 and P2 label blocks. Pass = no label overlaps any of them, and there is no "could not find a clear spot" line.
   3. **Switch-off control:** P1's label sits at pit + (300, 300) and overlaps the pipe note.
   4. One U removes the outline work and the labels together. REDO works.
   5. **Codex look:** the labels read clearly at plot scale.
8. **Verdict: KEEP-WITH-NOTE.** No code change before the train. Add to the setting's note that the height only applies while the switch is ON, and log the pit-label and leader gap as a follow-up if N97 shows an overlap. **Train class: Civil area + smoke.**

### PR #1925: B-113, BUG-788, two Save As Xrefs are read separately

1. **What changes for the drafter:** in PITSCHEDULE > Source > Drainage XREFs, two Xrefs where one was made from the other with Save As (same internal drawing ID) are now each read from their own file. The existing Save As check (#1404) can then see that the pit data differs and list them as two sources, as it was meant to. Before, `ReadContext.ReadProjectRecord` handed the second Xref the first one's data. Now the memory is keyed on drawing ID plus the Xref's full file path (`Services/PitScheduleXrefDiscoveryService.cs` 465-522; the path is the source database's `Filename`, read at 268-298). This matches the z3 report and the carpark.
2. **Settings switch:** it reuses `linking.pitScheduleXrefSeparatesSaveAsCopies` (already ON, already on the Settings page). That is the right call: one behaviour, one switch (design rule 1). It is read once per discovery (`SeparatesSaveAsCopiesFromSettings`, a missing group or failed read gives ON). The defaults pin for that switch already exists, from #1404.
   1. **OFF is the old key exactly, with one small difference:** the old code did not remember a read that went over the size limit ("exceeded its aggregate byte limit", old lines 405-410 returned before caching). The new cache remembers whatever the read returned, including that failure (`GetOrRead` 491-495), in both switch states. On a real job the second attempt would almost certainly fail the same way, because the total only grows. So the visible result is the same, but the PR's "OFF keeps the old key exactly" is not word-for-word true. Record it; no change needed.
   2. No engineering value.
3. **No hard blocks (R-27):** none. Read only. No Xref is opened for write, reloaded or detached.
4. **Native protection and REDO:** no write, no regen, no system variable change.
5. **Tests:** the seven `Bug788XrefRecordCacheTests` drive the new memory with fake databases. `SwitchOn_TwoSaveAsCopies_AreEachReadFromTheirOwnFile` fails against the old logic: with the identity-only key, the second read returns "JSON-A". The switch-off test pins the old answer. These are real. Gaps:
   1. No test proves that `ReadContext` passes `sourcePath` into the cache; that is only seen by reading line 201.
   2. The z3 report's suggested test "feeding those probes to Discover gives two entries" was not written.
   3. There is no test for the size-limit change above.
   4. Nothing touches %APPDATA%.
6. **Not proven, and the AutoCAD scenario:** robot case N98_xref_saveas_twins, as in the z3 report section 4(4).
   1. Make A.dwg. Make B.dwg from A with SAVEAS, then change the cover to 21.00 and add pit B2.
   2. Confirm both have the same non-empty FINGERPRINTGUID.
   3. In a host drawing, `_XATTACH` both, then PITSCHEDULE > Source > Drainage XREFs > Refresh.
   4. Pass = two entries, the second with the "same internal drawing ID ... different pit data ... not offered" note.
   5. Repeat with the attach order reversed.
   6. **Control:** switch OFF gives one entry.
   7. Reach: whether the robot can read the Source list is unproven, so a Codex look may be needed.
7. **Verdict: KEEP-WITH-NOTE.** Write the size-limit difference into the REGRESSION_LOG entry or the train notes. Optionally add one source guard that `ReadProjectRecord` passes `sourcePath`. **Train class: Civil area + smoke.**

### PR #1926: B-112, BUG-505, the CHECK THE SCALE warning and the no-units note show on the X-Civil import window

1. **What changes for the drafter:** on the CDIMPORTXCIVIL window's "Pit and pipe schedule" page, the banner ("Check the schedule first", `Dialogs/CivilImportWindow.xaml` 112, wraps) now shows the units sentence first. That is either "CHECK THE SCALE ..." or "This drawing has no units set; CE read it as millimetres." If the old check also wanted attention, "Check the schedule before accepting the import." follows on the next line. The footer then reads "Check the schedule before accepting the import." (`ViewModels/CivilImportWindowViewModel.cs` 83).
   1. The sentence is carried in the new `XcivilPreflightSummary.UnitsNote` (`Services/XcivilImportPreflightService.cs` 61-63), set at `Services/XcivilImportService.cs` 858 before the window opens. The window route uses `Rules/ImportReviewStatusRule.Status` (`Commands/LinkCommands.ImportXcivil.cs` 171-176).
   2. The command line still prints it as before. This is exactly Tim's 29 Oct decision 10 ("yes": a soft note, never a block) and the V8-01 finding.
2. **Settings switch:** `xcivilImport.scaleNoteOnReviewPage`, ON (`Models/UserSettings.cs` 3636-3642). Pinned through both start-up reads in the new test class (`TheSwitch_LoadsOn_ThroughBothStartUpReads...`, and typed false changes only itself). It is not added to `C75NewSwitchDefaultsTests`, which is fine because the new class covers both reads.
   1. **OFF gives exactly the two old sentences and the old attention flag** (`ImportReviewStatusRule.cs` 21-23, pinned by `SwitchOff_GivesExactlyTheTwoOldStrings`). A missing group reads ON (`?? true`, pinned by a source test).
   2. No Settings page row. File-only, the same as its sibling `noUnitsNote`.
   3. No engineering value. The units rule and the scale guess are untouched (pinned: `XcivilSourceUnitsCheck.Evaluate(sourceToTargetScale, sourceInsunits)` is unchanged). Tim's open question (trust a set UNITS over the size guess) is rightly not built.
3. **No hard blocks (R-27):** none. Wording only. Continue and Close behave as before. The page is marked "needs attention" but nothing is refused.
4. **Native protection and REDO:** no drawing access added.
5. **Tests:** `Unitless_WithMillimetreGuess_StatusIsTheNote...` and `MillimetreSource_WithMetreGuess...` build the real sentences through the real `XcivilSourceUnitsCheck` and check the page text. These fail before, because there was no rule and the page text was the old string. Real tests. The wiring into the window is covered by source-text guards only, and the banner itself has not been seen. Nothing touches %APPDATA%.
6. **Not proven, and the AutoCAD scenario:** robot case N96_xcivil_units_page (z3's N97/C97).
   1. In a target drawing already tagged Civil, type `CDIMPORTXCIVIL`, Choose DWG on a copy of a unitless millimetre X-Civil drawing, then Read source.
   2. Pass = the "Pit and pipe schedule" banner reads "This drawing has no units set; CE read it as millimetres."
   3. Repeat with a millimetre-UNITS source that has a 200 mm stub on a pipe layer. Pass = the CHECK THE SCALE sentence is on the page.
   4. Press Close: nothing is imported.
   5. **Control:** switch false gives "Schedule read. Review the pit and pipe rows."
   6. Reach: robot run 39 was blocked at the file dialog. The v2 dialog path is not yet proven on this case.
   7. **Codex look:** the two-line banner wraps and reads cleanly.
7. **Verdict: KEEP. Train class: Civil area + smoke.**

### Merge check (read-only `git merge-tree`, all five on the same base tip 3fbb9da5)

1. **Against the base `claude/rel-20261102a`:** all five merge cleanly, because each is one commit on the current tip.
2. **Pairs inside the group:**
   1. The only conflict is `REGRESSION_LOG.md`. #1922, #1924, #1925 and #1926 each add their entry at the very top of the file, so every pair among those four conflicts there. Keep both sides, newest first.
   2. #1923 adds its entry at line 585 (after the BUG-859 block), so it clashes with nobody. The finaliser may want to move it to the top so it is not lost in the middle of the file.
   3. `Models/UserSettings.cs`: #1924 adds at line 3223 (surface group) and #1926 at 3636 (xcivilImport group). merge-tree auto-merged them with no conflict.
   4. No product file is shared by any other pair.
3. **Stacking order:** any order works. Suggested order: #1922 first (test-only), then #1925, #1926, #1924, and #1923 last, because it is the FULL-class change and the one most worth a separate smoke.
4. **Against the other open PRs on this base:** I checked each of the five against every one of the 36 other open PRs based on `claude/rel-20261102a` (fetched read-only on 31 Oct; all heads were present). No file other than `REGRESSION_LOG.md` conflicts, and that file needs keep-both every time. `UserSettings.cs` auto-merges with the others too; for example, #1924 against #1947 was checked by hand. Merge-tree does not catch two PRs that add the same setting name. I saw no duplicate key among the group's three new keys.

### What this review could not verify

1. I could not run any test or build, by the brief, so every "passes" above is the author's report, not mine.
2. I did not see the window (#1926), the label placement (#1924) or the double-click (#1923) in AutoCAD.
3. I could not check whether AutoCAD fires the document-lock notice before the Enhanced Attribute Editor opens for a pit label (#1923). This is the single biggest unknown in the group.
