# Opus pre-review: PRs #1984, #1985, #1986, #1987 and #1988 (B-151, B-148, B-153, B-158, B-160)

Written Sunday 1 November 2026, 23:40 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's and CE 01's request.
Heads reviewed: #1984 2c5bd044, #1985 ad5f254c, #1986 f2bd8aeb, #1987 5770235a, #1988 7d358fd2. All five are DRAFT and show MERGEABLE against their own base.
Tips checked with read-only `git fetch` and `git ls-remote`: Civil newest train claude/rel-20261112a at ccaf0783 (C-79c finalizer), C-79b1 claude/rel-20261108a at bab2dbf8, Civil base claude/rel-20261102a at 3fbb9da5, Structural base claude/rel-20261026s at 204dfad2. #1911 head 297b4197.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the five authors' reports (areas\BUGFIX_q8, q5, q10, t1 and t3 _REPORT_01NOV.md), the carpark entries, decision 176 and areas\NEXT_TRANCHE2_01NOV.md. I ran read-only `git fetch`, `git ls-remote`, `git merge-base` and `git merge-tree` only. No protected file (LinkService.Persistence.cs, ProjectDataService.Persistence.cs, RulebookEngine.cs) is edited by any of the five.

## FOR TIM

1. **#1984, the STORM note for area marked "None" (BUG-1120 part a): KEEP-WITH-NOTE, Civil area + smoke.** After CDDESIGN reads a STORM report, the line "49.38 m2 goes straight out" becomes "49.38 m2 has no water-quality treatment ("None" in the report)… check where it drains." Words only; no area or figure moves. The new sentence is the builder's own wording, not yours: glance at it. CDCALC still says "Goes straight out" in a second place, left alone on purpose.
2. **#1985, Project Review "Pipe sizes" agrees with CDRULES (BUG-1258): KEEP-WITH-NOTE, Civil area + smoke.** Example: blank out UPVC's speed limit in Settings. CDRULES already judged that pipe against your office maximum pipe velocity (6.0 m/s). Project Review said "Unknown". Now both use 6.0 m/s. One must-do when it is merged: its change-log entry needs one blank line added, or the C-79c log check goes red.
3. **#1986, BP warns when your Settings pier diameter is not on the pier block (BUG-536, BP part): KEEP, Structural area + smoke.** BP already draws 300, 450 or 600 from Settings (one block with three sizes). If Settings says, say, 500, BP now prints one line saying 450 is offered instead. Before, it said nothing. Nothing is blocked.
4. **#1987, X-Civil import reads metres and the depth column (BUG-805): KEEP-WITH-NOTE, Civil area + smoke.** "0.9 m" now reads as 900 mm, not 0.9 mm. A row "CL 8.45m 1.20m" now gives a 1,200 mm pit depth, not 8,450. A pipe row with one end blank now goes to no pipe, with a warning, instead of the wrong pipe. Only made-up rows were tested. Nobody knows yet whether real consultant tables have a "DEPTH" header.
5. **#1988, OOPS after erasing a footing line puts the outline back at once (BUG-300): KEEP-WITH-NOTE, Structural FULL.** ERASE a strip line, type OOPS: the outline and record come back straight away, not at the next footing command. It is built to sit in OOPS's own Undo step, using the same pattern CE already uses after MOVE. That pattern was measured in AutoCAD for MOVE, never for OOPS. The robot must prove that one U takes all three back and REDO restores them before this counts.
6. **Merging:** Civil: each of #1984, #1985 and #1987 clashes with the newest train and with each other only in the Settings list and the top of the change log. In every case the fix is to keep both entries. #1985's stack is sound: #1857 is already inside C-79b1, so #1985 is one commit on top. Structural: take #1911, then #1986, then #1988. Again, the only clashes are keep-both clashes.
7. **No test was run "red before, green after".** In all five, the new tests cannot even compile on the old code, so that proof does not exist. No test touched your real settings. Your real CD_Settings.json did change at 22:50:35, during the #1987 builder's run. That was 2 seconds before a robot AutoCAD started, which fits the robot setting its switches before launch. I cannot prove who wrote it.
8. **Nobody has opened any of the five in AutoCAD.** All are built and unit-tested only. All five bugs stay OPEN.

---

## DETAIL

### Group facts

1. **Bases.**
   1. #1984 and #1987 are each one commit on claude/rel-20261102a 3fbb9da5 (0 behind it). They are 111 commits behind claude/rel-20261108a, which contains 3fbb9da5, so they still merge forward.
   2. #1985 is one commit (ad5f254c) on #1857's head 718ec21c, base `fb/1788-extras-comma-and-speed`. **718ec21c is already an ancestor of claude/rel-20261108a (C-79b1)** and so of rel-20261110a and rel-20261112a. The stack is sound and #1857's content is not stale. The #1857 PR is still listed open, but its code has landed by train. #1985 can be retargeted to the current Civil train, or its one commit merged straight in. Either way only ad5f254c is new.
   3. #1986 and #1988 are each one commit on claude/rel-20261026s 204dfad2 (0 behind it). #1911 (297b4197) is not yet in rel-20261026s.
2. **`git merge-tree` results (read-only).**
   1. #1984 vs rel-20261102a: clean. #1987 vs rel-20261102a: clean.
   2. #1984 vs rel-20261112a: conflicts in `Modules/Drainage/Models/UserSettings.cs` and `REGRESSION_LOG.md`. The UserSettings clash is against `PumpAndRationalUseHardGroundC` (B-133), which sits in the same Detention group at the same insertion point. Keep both properties.
   3. #1987 vs rel-20261112a: conflicts in `UserSettings.cs` (against `ImportResultsFromWhatWasDrawn` BUG-898 and `CancelLineIsPlainEnglish` BUG-1256, at the end of XcivilImportSettings) and `REGRESSION_LOG.md`. Keep all three properties.
   4. #1985 vs rel-20261112a: conflicts in `Modules/Drainage/Models/PipeSpeedChecksSettings.cs` (against B-120's `SizingReadsMaterialTable`, at the end of the class) and `REGRESSION_LOG.md`. Keep both properties.
   5. Pairs #1984×#1985, #1984×#1987, #1985×#1987: `REGRESSION_LOG.md` only. UserSettings.cs auto-merges.
   6. Structural: #1986×#1988 conflict in `Modules/Structural/Models/UserSettings.cs` (both insert after `UnknownPadSizeIsNotInvented`). Keep both. #1986×#1911 conflict in `REGRESSION_LOG.md` only. #1988×#1911: clean. No program-code conflict anywhere.
3. **Change-log guard on the Civil line.** The C-79c finalizer (ccaf0783, `C79cFinalizerGuardsTests.TheNewestFiftyChangeLogEntries_EachStartAfterABlankLine`) fails if any of the top fifty `## ` headings is not preceded by a blank line. #1984's and #1987's entries end with a blank line. **#1985's entry does not**: its line "7. **To undo:** …" runs straight into "## B-011b …" in the diff. The assembler must add one blank line after it, or make sure one exists after the keep-both resolution.
4. **Real %APPDATA%.** All five builders say they set CE_LOG_DIR_OVERRIDE, TEMP and TMP (and CE_STRUC_SUITE_APPDATA_ROOT for Structural) to scratch folders. They took before and after listings. Every listing changed, and every builder blames a robot AutoCAD running at the same time (process ids and start times are given in each report). In the tests I read, the Civil tests pass explicit flags or flip `SettingsService.Current` in memory and restore it in TearDown (#1985). The Structural tests only deserialise strings. None of them write a settings file. The only settings-file change on record is CD_Settings.json at 22:50:35 in the t1 window, 2 s before acad.exe started at 22:50:37. I could not verify which process wrote it.

---

### PR #1984: B-151, BUG-1120 part (a), STORM "None" wording (Civil)

1. **What changes for the drafter.**
   1. `Modules/Drainage/Rules/StormReportOffer.cs` `BuildNotes` (about lines 170 to 183 at the head) changes the second half of the "Of that, … m2 goes to a tank and … m2 …" note. It was "goes straight out. Only the part that reaches the tank is detained." It is now "has no water-quality treatment ("None" in the report). That does not mean it skips detention, but CE counts only the part that reaches the tank as detained, so check where it drains."
   2. This is a CDDESIGN command-line note only. Figures, notes count and the split are unchanged (pinned by `OnAndOff_OnlyThatOneNoteDiffers…`).
   3. The carpark entry asks for "wording that says 'no water-quality treatment'". This does that. Decision 176 (council numbers) lists BUG-1120 but rules on numbers, not this sentence. The exact wording is the builder's, and q8 report item 6 says so.
2. **Settings switch.**
   1. `detention.stormNoneNoteWording` (`UserSettings.cs`, DetentionSettings, after `BoydsUsesHardGroundC`), default true, documented "Default: on.".
   2. It is pinned in `Bug1120StormNoneWordingTests` through `DeserializeSettings` and `DeserializeSettingsTolerant`, for `{}`, an empty group and a group without the key. A typed false is kept and moves nothing else.
   3. OFF returns the old sentence byte for byte (`Off_TheOldSentenceReturnsExactly`).
   4. The caller in `CivilDesignCommand.cs` (about line 500) reads `SettingsService.Current?.Detention?.StormNoneNoteWording ?? true`.
   5. There is no key in a C-NN defaults class (the builder chose not to touch the shared file). The new class holds the pin. No engineering value is involved.
3. **No hard blocks.** None. Text only.
4. **Native protection and REDO.** Nothing is written to the drawing. No protected file is touched.
5. **Merge.** See group facts 2.3 and 2.5. Keep both Detention properties.
6. **Tests.**
   1. 101 of 101 pass, net48 and net10, per the report. Two existing tests were edited:
      1. `Bug1106TwoWordCouncilTests`: the source guard now ends in `CouncilProfileIdFor,`.
      2. `StormReportOfferTests`: now asserts the new wording, and the old wording with the switch OFF.
   2. Nothing was run red before. The new tests call a 7-argument `Build` that does not exist on the base.
7. **NOT proven, and the robot case.**
   1. Not proven: the line on a real STORM report in AutoCAD.
   2. Robot case `N96_storm_none_note`, plus an OFF twin, as in the q8 report. Command-line text only, so no Codex look is needed.
   3. Follow-up for Tim: `CatchmentReportIntake.DestinationWords` ("Goes straight out") on the CDCALC catchment proposal is a second screen with the old meaning.
8. **Verdict: KEEP-WITH-NOTE. Civil area + smoke.**
   1. Note 1: Tim should see the wording (it is not his quote).
   2. Note 2: the CDCALC twin wording is unchanged and should go on the follow-up list.

### PR #1985: B-148, BUG-1258, Project Review "Pipe sizes" agrees with CDRULES (Civil, stacked on #1857)

1. **What changes for the drafter.**
   1. `Modules/Drainage/Services/PipeSizeNetworkReviewService.cs`: `ResolvedStandards` (line 143) and `MissingSizingValue` (line 185) now call `rulebook.ScourVelocityForCheck(material, UnsetMaterialTakesOfficeVelocity())`. This is the same lookup CDRULES uses at `RulebookEngine.cs` 498, and `RulebookValues.cs` 519 is unchanged.
   2. Result: a material with a blank or zero speed limit takes the office "Maximum pipe velocity" in Project Review > Proposals > Pipe sizes, instead of "Unknown: no speed limit is set in Settings for "UPVC"". The pipe then gets a Keep or Upsize answer.
   3. A material with its own speed is untouched. If the office figure is also blank, the pipe stays Unknown with the old words.
   4. This is exactly what the carpark entry BUG-1258 asks for: one rule for both screens.
   5. Worth knowing: this screen's proposals can be applied. A pipe that used to be "Unknown" (nothing offered) can now be offered an Upsize, which the drafter may apply. That is the intended effect, and it still needs the drafter's click.
2. **Settings switch.**
   1. `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial` (`PipeSpeedChecksSettings.cs`), default true, "Default: on.".
   2. The helper `UnsetMaterialTakesOfficeVelocity()` (lines 197 to 204) ANDs it with #1857's `unsetMaterialUsesOfficeFigure`, so the two screens cannot disagree. Unreadable Settings read ON.
   3. It is pinned through both start-up reads for `{}`, a group without the key and a C-77-shaped group. A typed false changes only itself (whole object compared). A typed true is kept.
   4. OFF calls `ScourVelocityForCheck(m, false)`, which returns `ScourVelocityFor(m)`: the old answer exactly.
   5. The figure comes from `DesignStandards.MaximumPipeVelocity`. No number is in code. There is no Settings window row (the report says so, and offers it as a follow-up).
3. **No hard blocks.** None. It turns an "Unknown" into an answer.
4. **Native protection and REDO.** The review reads ProjectData only and does not write to the drawing. `RulebookEngine.cs` is called, not edited.
5. **Merge and stack.**
   1. Stack sound (group fact 1.2).
   2. Against the C-79c tip: keep both in `PipeSpeedChecksSettings.cs` (B-120) and in the log.
   3. **Must-do:** add the missing blank line after the entry (group fact 3).
6. **Tests.**
   1. 13 new tests; 239 of 239 pass in the focused run on net10. net48 was compiled only (0 errors).
   2. The tests flip `SettingsService.Current.PipeSpeedChecks` in memory and restore it in TearDown, and are marked NonParallelizable. They write no file.
   3. The switch-off tests act as the broken twin. Nothing was run red on the old code.
7. **NOT proven, and the robot case.**
   1. Not proven: the Pipe sizes window in AutoCAD, and that the same 6.0 m/s shows on both screens.
   2. Robot case `N48_pr_office_speed`, with controls `C48_pr_office_speed` and a second control with #1857's switch off, as in the q5 report.
   3. **Codex look needed:** CE 02 does not know whether the Pipe sizes rows can be read by the robot (q5 report technical item 8).
8. **Verdict: KEEP-WITH-NOTE. Civil area + smoke.** Note: add the blank line after the change-log entry at assembly. Retarget, or merge the single commit, onto the current Civil train.

### PR #1986: B-153, BUG-536 BP part, BP warns about an off-block Settings diameter (Structural)

1. **What changes for the drafter.**
   1. `Modules/Structural/Services/FoundationService.cs` `ExecuteBoredPier` (lines 2075 to 2083): before the "Select pier diameter [300/450/600] <450>" question, BP prints one line when Settings `BoredPierPlan.DefaultDiameterMm` is not 300, 450 or 600. For example: "[BP] The pier diameter in Settings … is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead…".
   2. The answer offered is unchanged. The pier is still drawn.
   3. The builder found that the carpark claim "BP always uses the 450 block" is not a fault: the one block, `450DIABPV2`, already switches its visibility state from the diameter. The real fault was the silent fallback.
   4. That matches RULES 12.2 (never silent) and the carpark item 43. It does not add a block, which is right.
2. **Settings switch.**
   1. `FootingWidth.BoredPierBlockFollowsDiameter` (Structural `UserSettings.cs` after `UnknownPadSizeIsNotInvented`), default true, "Default: on.".
   2. It is pinned through `new UserSettings()` and the tolerant reader on both its paths (normal, and value-by-value after a damaged value). Structural has one start-up reader, `DeserializeSettingsTolerant`. A typed OFF is kept.
   3. OFF is silent, as before. A source guard checks the warning sits inside the switch check.
   4. Small notes:
      1. The switch name says "block follows diameter", but what it controls is the warning. It is harmless, but the name may confuse a later reader.
      2. The sizes in the warning text ("300, 450 and 600", `BoredPierDiameterChoice.cs` line 31) are typed out rather than built from the `Offered` list next to it. If the block ever gains a size, the text could drift.
      3. Neither is an engineering value under R-00. The 450 fallback is the existing `EarlierDefault`.
3. **No hard blocks.** None. Warn and carry on.
4. **Native protection and REDO.** Only one command-line message is added, inside BP's existing edit scope. There is no new write.
5. **Merge.** Take #1911 first, as the report asks (a log clash only). #1986×#1988 have a keep-both clash in Structural `UserSettings.cs`.
6. **Tests.** 28 of 28 focused tests pass; net48 compile has 0 errors. Not run red on the old code: `FallbackWarning` does not exist there.
7. **NOT proven, and the robot case.**
   1. Not proven: the real line in AutoCAD, and that the 300 and 600 visibility states display.
   2. Robot case `q10_bp_settings_dia_warn`, with an OFF control and a 600 control. The 600 control reads the block's Visibility1 value "600 DIA.". Command-line text plus one property read, so no Codex look is needed.
8. **Verdict: KEEP. Structural area + smoke.** It is small and correct. The two naming and text notes above are optional.

### PR #1987: B-158, BUG-805, X-Civil import reads metres, the depth column and half-blank pipe rows (Civil)

1. **What changes for the drafter (CDIMPORTXCIVIL).**
   1. **AI-vision route.** `XcivilVisionScheduleParser.cs` `GetDoubleField` reads a plain metre figure ("1.2 m", "0.9M", "1.2 metres") as metres and multiplies it by 1,000 once. "mm" and bare numbers use the old path. This covers pit widths, detention widths, pit depth and pipe diameter.
   2. **Drawn GN-ANNO-TABL route.** In `XcivilScheduleService.TryExtractScheduleFromPitScheduleBlock` (lines 561 to 590), the pit depth comes from:
      1. the cell under a "DEPTH" header (new `Rules/XcivilScheduleMetresRule.cs` `TryFindDepthColumn`, `ReadDepth`); or
      2. without such a header, the single "number m" in the row that is not after CL, RL, IL, TL, FL, SL or LEVEL.
      3. Two or more candidates leave the depth Unknown (0), and a WARNING line goes into `LastRowPairingLines`. The pre-flight summary already prints that list (`XcivilImportService.cs` 848, 1461).
   3. **Pipe schedule.** `ApplyPipeScheduleToImportedPipes` (lines 1230 to 1236) skips a row with exactly one blank end and adds a WARNING line. Before, that row's size went to any pipe whose same end was unresolved.
   4. All three match the carpark entry's expected behaviour, word for word.
2. **Settings switch.**
   1. `xcivilImport.scheduleReadsMetresAndDepthColumn` (`UserSettings.cs`, end of XcivilImportSettings), default true, "Default: on.".
   2. It is pinned through both start-up reads for `{}` and a group without the key. A typed false turns off only itself.
   3. OFF: the vision parser keeps the old `TrimEnd('m')` path, the drawn table keeps the first-"number m" regex, and half-blank rows match as before. ON-versus-OFF tests cover each.
   4. R-00: the existing depth bounds (more than 0.3 m and less than 15 m, `XcivilScheduleMetresRule.cs` lines 48 to 49) are copied from the old inline code, not new. There is still no Settings range for them, which is a follow-up, not a fault of this PR.
   5. The header-line tolerance (0.05 drawing units, line 79) is a reading tolerance, not an engineering value.
3. **No hard blocks.** None. Ambiguous depth means Unknown plus a warning; a half-blank row means unassigned plus a warning. The import carries on.
4. **Native protection and REDO.** Only the reading of the schedule changes. The drawing path (locked-layer handling from BUG-898 and the rest) is untouched. No protected file is touched.
5. **Merge.** Keep both in `UserSettings.cs` against BUG-898 and BUG-1256 on the C-79c tip, and in the log. The entry ends with a blank line, so the C-79c log guard is fine.
6. **Tests.**
   1. 26 new tests pass; 667 of 667 in the related focused run; net48 compile has 0 errors. The tests pass the switch as an explicit argument and read no file but source.
   2. Not run red: the new rule file does not exist on the base. The ON-versus-OFF pairs do show the old wrong answers (8,450 mm, and the half-blank row assigned).
   3. Missing: there is no test that the half-blank warning reaches the results page end to end. Only the list it is added to is checked.
7. **Points the reviewer could not settle (worth a robot or Codex look).**
   1. **Depth column found, but this row's depth cell is blank.** `ReadDepth` then falls back to every cell in the row (`XcivilScheduleMetresRule.cs` lines 99 to 104). One other non-level "number m" in that row would be taken as the depth. Low risk (pit widths are normally in mm), but it is not what "take the depth column" implies. It would be safer to leave that row Unknown when a DEPTH column exists.
   2. **A pipe size written "900mm" in a pit row** can still be read as the depth by the old mm fallback. The builder flagged this, it was there before, and it is not part of this bug.
   3. **A half-blank pipe row whose other end alone would identify one pipe** is now always left unassigned. This is conservative and matches the carpark entry ("left unassigned (Unknown)"). It means a drafter enters that size by hand.
   4. **Real consultant tables:** nobody knows whether they carry a "DEPTH" header. Without one, a row showing both an unlabelled cover level and a depth in metres now reads Unknown, with a warning, instead of the wrong 8,450.
8. **NOT proven, and the robot case.**
   1. Not proven: anything in AutoCAD, any real consultant schedule, or the results page wording.
   2. Robot case `N35_xcivil_metres`, with an OFF twin set before launch, as in the t1 report. The cheapest route is the drawn GN-ANNO-TABL table plus a vision-reply fixture.
   3. **Codex look:** the results window should show the half-blank WARNING line and the ambiguous-depth line.
9. **Verdict: KEEP-WITH-NOTE. Civil area (X-Civil import) + smoke.**
   1. Note 1: point 7.1 (the blank depth cell under a known DEPTH column) is a suggested tightening for a follow-up, not a merge blocker.
   2. Note 2: no end-to-end check that the warnings reach the results page.

### PR #1988: B-160, BUG-300, OOPS after ERASE restores the footing and outline at once (Structural; Undo/REDO-sensitive)

1. **What changes for the drafter.**
   1. `Modules/Structural/Services/FoundationMonitor.cs` `OnCommandEnded` (lines 198 to 202): when the ending command is OOPS (any spelling, `OopsRestorePolicy.IsOopsCommand`), the switch is ON and it is the outermost command end, CE calls `FoundationService.RestoreAfterOops(doc)`.
   2. That method (`FoundationService.cs` lines 1019 to 1063):
      1. does a read-only registry pass for footings "set aside" by an erase whose line is live again (`FootingsBroughtBackByOops`), and returns, writing nothing, if there are none;
      2. stops with one plain line on REFEDIT or a layout tab (`OopsPlaceIsProtected`; an unreadable variable counts as protected);
      3. stops with one plain line if the footing's drafting layer or its line's layer is locked;
      4. otherwise, under `doc.LockDocument()` and the same `BeginFoundationRefresh` scope that `ExecuteCore` uses (line 1178), runs the existing start-of-command check `SyncRegistryWithDrawingState`. That check lifts the mark, redraws, and says "PF1 is back; CE redrew its outline."
   3. This is what the carpark entry and the 31 Oct evidence note ask for: no gap between OOPS and the next footing command.
   4. The builder deliberately left U alone, although the brief said "OOPS or U". A U after ERASE already restores everything in one step (S-5). A write at the end of U would end the REDO window (BUG-861 rule). I agree with that choice.
2. **Settings switch.**
   1. `FootingWidth.OopsRestoresOutlineAtOnce`, default true, "Default: on.".
   2. It is pinned in `B160NewSwitchDefaultsTests` through `new UserSettings()` and the tolerant reader (blank file, older file without the key, a damaged value through the value-by-value path). A typed OFF is kept, and the doc line is checked.
   3. OFF: `ShouldRestoreAtCommandEnd` returns false and `RestoreAfterOops` also returns at its first line (checked twice), so behaviour is exactly as before.
   4. No engineering value.
3. **No hard blocks.** None. The protected-place and locked-layer cases print one line and do nothing.
4. **Native protection and REDO: reviewed with extra care.**
   1. **Same Undo step.** The write happens in OOPS's `CommandEnded` under the document lock. That is the pattern already used for MOVE, STRETCH and ERASE (`FoundationMonitor.cs` doc comment above `OnCommandEnded`, and `StructuralIdleWorkPlanner.ShouldRedrawAtCommandEnd`). It was measured in the AutoCAD 2027 core console for MOVE and ERASE: one U took back the edit and CE's redraw, and REDO brought both back. **It has not been measured for OOPS.** The source guard `Restore_ReusesTheExistingDrawingCheck_AndOpensNoUndoStepOfItsOwn` only proves no `BeginFoundationEdit` or undo mark was added.
   2. **REDO window.** OOPS is not in the U family, so writing at its end takes no REDO away. Any command ends REDO anyway. U, UNDO, REDO and MREDO never reach the restore (pinned by `EveryOtherCommandEnd_IsLeftAlone`).
   3. **Nesting, LISP and scripts.** These are gated by the existing `IsOutermostCommandEnd`, so an OOPS inside a LISP routine leaves the restore to the next footing command, as before.
   4. **Locked layers.**
      1. Nothing is unlocked. But the PR's own `FootingLayerIsLocked` (lines 1066 to 1081) checks only the system's drafting layer and the driver line's layer. It is a second, narrower copy of `FindLockedLayersForRedraw` (line 2727), which also covers the outline and label layers.
      2. If only the label layer (25TEXT) is locked, the pre-check passes. `SyncRegistryWithDrawingState` then lifts the mark and saves the record, and `RegenerateSystem` refuses the redraw through its own locked-layer guard (lines 2438 to 2442). The drafter sees "PF1 is back" with the not-redrawn wording, and nothing is bypassed.
      3. This is safe, but rule #1 (one code path) argues for calling `FindLockedLayersForRedraw` here. That is a follow-up, not a blocker.
   5. **Scope wider than one footing.** `SyncRegistryWithDrawingState` sweeps the whole footing record. At OOPS end it can also:
      1. follow and redraw other footings moved on another PC (the S-5 "followed-drawing" branch);
      2. mark other footings whose line is gone.
      This is the same as at the start of any footing command, and it only runs when at least one footing was brought back. The locked-layer pre-check covers only the OOPSed footings, but `RegenerateSystem`'s own guard covers the rest.
   6. **Possible double redraw.** OOPS is not in the U family, so after `RestoreAfterOops` the existing command-end redraw also runs for any footing line the watcher queued during OOPS. If AutoCAD raises ObjectModified when OOPS un-erases the line, the same system is redrawn a second time in the same step. I could not confirm whether that event fires. If it does, it is harmless (the redraw replaces the outline) but doubles the work, and the robot should count outlines.
   7. **Record held in memory.** After U of the OOPS step, the drawing's record goes back to "set aside". The in-memory registry copy must not keep the restored state. This is the same concern as for every S-5 command-end write, and S-5 passed it for MOVE. It is not checked for OOPS.
5. **Merge.**
   1. #1988×#1911: clean. #1988×#1986: keep both in Structural `UserSettings.cs`.
   2. **The change-log entry was appended at the BOTTOM of `REGRESSION_LOG.md`** (after line 26239), not at the top like every other entry. Move it to the top at assembly. The C-79c blank-line guard only checks the top fifty, so it would not catch this.
6. **Tests.**
   1. 37 of 37 new and nearby tests pass, plus 308 of 308 footing, monitor, REDO-guard and review tests, on net10. net48 compile has 0 errors.
   2. The new tests are pure policy tests plus source guards (OOPS only, outermost only, same check, no own Undo step, protection checked before the write). None drives an Undo or a REDO.
   3. Not run red: the policy class does not exist on the base, as the t3 report says.
7. **NOT proven, and the robot case.**
   1. Not proven: everything in item 4.1, 4.6 and 4.7, plus the locked-layer line and the schedule refresh after OOPS.
   2. Robot case `T3_oops_restores_outline`, with OFF twin `T3_oops_restores_outline_off`, as in the t3 report. Please add these reads:
      1. the outline entity count right after OOPS equals the count before ERASE (catches a double redraw);
      2. **one U echoes "OOPS" and removes line, record and outline together; REDO brings all three back; a second U then removes only the erased line's return** (proves the step boundary);
      3. lock 25TEXT only, ERASE, OOPS: the line is back, "not redrawn" wording appears, and nothing is unlocked;
      4. QSAVE, close, reopen after the OOPS: the record is not "set aside".
   3. The t3 report also asks CE 02 whether its gate case already found OOPS restoring the outline. If so, hold this PR.
8. **Verdict: KEEP-WITH-NOTE. Structural FULL** (it hooks every command end and touches Undo behaviour).
   1. Note 1: move the change-log entry to the top.
   2. Note 2: the robot reads in 7.2 must pass before anyone calls BUG-300 fixed.
   3. Note 3 (follow-up): reuse `FindLockedLayersForRedraw` instead of the narrower `FootingLayerIsLocked`.
