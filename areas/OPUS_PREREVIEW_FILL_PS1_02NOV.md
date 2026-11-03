# Opus pre-review FILL PS1: Pit Schedule PRs #1426, #1425, #1413, #1409, #1431 (queue filler 6)

Written Monday 2 November 2026, 04:41 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Heads reviewed: #1426 cb5e822b, #1425 e1a91fb5, #1413 8e2b711b, #1409 1be523c1, #1431 0d01029b. All five are DRAFT and OPEN on GitHub, base `claude/rel-20261018d` (70a4e24f), 0 behind it.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the code around them on the PR heads and on the current release `claude/rel-20261102a` (3fbb9da5, Civil 3.0.88), the carpark entries and the PR write-ups. I ran read-only `git fetch`, `git merge-tree`, `git merge-base` and `gh pr view/diff` only.

## FOR TIM

1. **The big fact first: all five are already in your AutoCAD.** They were merged into the release train on 19 Oct 2026 at about 2:30 am and have shipped since Civil 3.0.70. They are in 3.0.88 today. The pull requests were simply never closed, so the queue listed them as "not yet reviewed". This is a look back at code you already have, not a gate before merging.
2. **#1426, a typed cover, level or pipe size in the drawn Pit Schedule must be one clean number (BUG-792): KEEP-WITH-NOTE (was FULL).** Type "21,15" in a cover cell and CE now puts the old figure back and says why, instead of making the cover 21.00. The Undo and REDO handling is sound. One thing nobody has checked: when you MOVE a whole table, no cell should say "CE could not read".
3. **#1425, the Pit Schedule window marks a cell as overridden only when you really changed it, never the pit size (BUG-791): KEEP (Civil area + smoke).** Codex has already seen it work twice in real AutoCAD.
4. **#1413, the FROM column keeps C1 as "C1" (BUG-784): KEEP-WITH-NOTE (Civil area + smoke).** A real pit you named R1 or D1 still prints "R" or "D", because those were old source-block tags. Nobody has tested it yet: the robot's test drawing has no pit named C-something.
5. **#1409, level text never "-0.00" and halves round up; a minimum cover of 0 falls back to 600 mm (BUG-807 and BUG-809 item 3): CHANGE-NEEDED (follow-up fix, Civil area + smoke).** The headline case is NOT fixed. Cover 18.50 with outlet 18.504 still prints a DEPTH of "-0.00" on AutoCAD 2025 and later, because the depth column never got the new rounding. The fix is small: send the two depth lines through the same rounding.
6. **Your call on #1409 (engineering judgement):** if the office minimum cover in Settings is 0, CE now checks pipes against 600 mm. The Settings default is 300 mm. It only says so in the CE log, never on screen. My recommendation: fall back to 300 mm, the Settings default, and say it once on the command line.
7. **#1431, the outlet warning compares with the pit's largest inlet (BUG-808): KEEP-WITH-NOTE (Civil area + smoke).** Inlets of 300 and 375 into a 300 outlet now warn. A small slip: in the Xref view, two different drawings' pits can be pooled together by mistake and give a false warning. It is only a warning and never stops you.
8. **Nobody has opened #1426, #1413, #1409 or #1431 in AutoCAD; only #1425 has been seen by Codex.** All five bugs stay OPEN in the carpark. No test touched your real settings: the test project points Settings at a temporary folder.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Already merged and shipped.** `git merge-base --is-ancestor` shows all five heads are inside `claude/rel-20261019a` and every later train, including the current tip `claude/rel-20261102a` (3fbb9da5), `claude/rel-20261106a` and `claude/rel-20261108a`. The merge commits are a839ae74 (#1426), d71f9bb0 (#1425), e7f7fb70 (#1413), f55e9b0a (#1409) and 49353bf3 (#1431), all 19 Oct 2026, 02:29 to 02:33 Melbourne. The carpark already says "fix installed in Civil 3.0.70 via PR #…" for all six bug entries. **Action for CE 05:** close these five PRs as "merged via train C-45 (rel-20261019a)" so the queue stops listing them.
2. **The brief's premise is partly wrong.** The REGRESSION_LOG entries for #1426, #1425, #1413 and #1431 each record an earlier "Opus review PR … 19 Oct 2026" fix round. #1409 has none, so this is its first Opus review.
3. **Keep-both merge (question 5).** Read-only `git merge-tree` between every pair of the five heads: every pair conflicts only in `REGRESSION_LOG.md` (the top entry), and every pair except those with #1409 also in `UserSettings.cs` (all add a value straight after `PitLabelMaxDistanceMm` in `LinkingSettings`; #1409 adds its value lower down). No program-code clash. On the train, both were resolved as keep-both: all five Settings values are present, and all five REGRESSION_LOG headings are present (lines 4132, 4144, 4192, 4204, 4417 of the 3.0.88 log). No stack: each PR is one or two commits straight on the base.
4. **Same function touched by two PRs (question 5).**
   1. `ScheduleLinkService.TryHandleEditedCell`: #1426 (this group) and #1410 (BUG-779, a sibling job) both add a block above the `switch`. On the train the order is BUG-779's block first, then BUG-792's (3.0.88 lines 231 and 267). That order is right: a cell that still holds the stored figure is left alone before the clean-number test runs. The redo-safe baseline reads (x3) on all three lines on 3.0.88 (lines 325, 764, 1160), as #1426's log asked.
   2. `PitScheduleViewModel.Data.cs`: #1431 changes `LoadFromProjectData` (one added call after `ApplyPersistedSortOrder`), `LoadFromSelectedXrefs` (one added call), `OnRowPropertyChanged` (an added inlet-size recheck), adds `RecheckOutletWarnings` and changes `ComputeDiameterWarning` (static to instance, largest inlet). #1415 (BUG-780) changes `LoadFromProjectData` too, but different lines (the row building near lines 306 and 405), plus `AppendExternalSourceRows`. #1422 (BUG-786) changes only the local `GetSavedOrder` inside `ApplyPersistedSortOrder`. So #1431 and #1415 share one function in different places, and #1431's recheck runs after #1422's sort. All three are already merged together on the train without trouble.
5. **Defaults (question 2).** Each PR pins its default ON with `new LinkingSettings()` only. None uses the "both start-up reads" pin used elsewhere (for example `B057MismatchBoxOwnSuggestionTests.BothReads`), which also loads an older settings file without the key. All five keys are in the Settings window list test (`SettingsWindowV3Tests.cs:354` on 3.0.88), so they are visible in Settings. Note for a later tidy, not a defect: a JSON property initialiser keeps ON for a missing key.
6. **Real settings (question 6).** Production code reads `SettingsService.Current` inside `PitScheduleLevelText.Format` and `StripSourceTagNumber`, which the tests call. On 3.0.88 `SettingsService` sends a test run's settings to a temporary folder (`SettingsService.cs:46-52`, `SettingsIsolationSetup.cs`), so no test reads or writes Tim's real CD_Settings.json. I did not run the tests, so I cannot confirm the redirect was active on the authors' runs.
7. **No protected file touched.** None of the five changes LinkService.Persistence.cs, ProjectDataService.Persistence.cs or RulebookEngine.cs. Only #1426 writes to the drawing.

---

### #1426: BUG-792 numbers half, a typed figure in the drawn Pit Schedule must be one clean number

1. **What changes for the drafter.** Double-click a cover, inlet level, outlet level or pipe size cell in the drawn Pit Schedule and type something that is not one number, such as "21,15", "{\H0.7x;21.15}" or "21.15 and more". The cell goes back to CE's figure and the command line says: `CE could not read "21,15" as one number in this Pit Schedule cell (cover level), so it kept the old figure. Type just the number, for example 21.15.` (`ScheduleLinkService.cs` PR lines 228-246; wording `ScheduleTypedNumber.cs:76-78`). A size may carry mm, dia or Ø; a twin pipe "2/375" or "2 x 375" keeps 375 in a size cell and is refused in a level cell (`ScheduleTypedNumber.cs:19-26`). A level typed with more than two decimals is stored to two and the command line says "CE kept 21.155 as 21.15" (PR lines 284-285, 331-332, 373-374). This matches the carpark's "refuse anything that is not one clean number, with a message". The second half (put back text typed in Depth, Pit Size, FROM and Lid/Remarks with "edit this in PITSCHEDULE or PITEDIT") is NOT built, and the log says so. `BuildEditElsewhereLine` (`ScheduleTypedNumber.cs:80-83`) is written for it but never called.
2. **Switch.** `linking.scheduleTypedCellsMustBeClean`, ON (`UserSettings.cs`, PR line 476). OFF: `TypedCellsMustBeCleanSwitch()` false skips the new block, skips both rounding lines and the `TryReadDiameterText` branch, so `TryParseDiameter` runs exactly as before. OFF restores the old behaviour exactly. No engineering value hard-coded.
3. **No-hard-blocks.** A refusal of an unreadable entry, with the old figure put back and one command-line line. No modal window, no stop. This is the behaviour the carpark asks for. Fine under R-27.
4. **Native protection and REDO.**
   1. The handler runs from `LinkService.ApplyPendingAttachmentUpdates` (`LinkService.PipeAttachmentUpdates.cs:51`) at the end of a command. U, UNDO, REDO and MREDO suspend linking and clear the pending work (`LinkService.Reactors.cs:867-880`, `:1707`, `IsUndoCommand` at `:2145-2153`), so the new write never runs inside an Undo or REDO. The new write is the same shape as the existing put-back for copied cells (UpgradeOpen, SetEntityText, Commit in the one transaction). The baseline change to (x2), later (x3) on the train, is honest.
   2. The new block sits AFTER the existing guard for cells copied in from another drawing (`EditedCellMayChangeRecord`), so a cell from an Xref or REFEDIT'd drawing never reaches it. A cell on a locked layer cannot be typed into or moved, so it never reaches the write.
   3. **Not verified (the one real risk):** `GetEntityText` reads `MText.Contents`, which includes formatting codes (`ScheduleLinkService.cs:3709-3716` on 3.0.88). If CE itself ever draws a level or size cell with formatting (bold, colour, an alignment code), a MOVE of the table would put back plain text and print "could not read" for each such cell. On the train, #1410's block runs first and leaves a cell alone when its number equals the stored figure, which should catch a plain MOVE. I could not prove which text CE draws in those cells. The robot case below checks it.
   4. **Rounding note:** the stored figure uses `cover.ToString("0.00")` (PR line 283), which on AutoCAD 2025 and later stores 21.155 as 21.15, while #1409's rule and AutoCAD 2024 give 21.16. The rounding test passes 21.16 in by hand (`ScheduleTypedNumberTests.cs:82`), so it does not catch this. Fold into the #1409 follow-up: both `ToString("0.00")` calls in `TryHandleEditedCell` should use `PitScheduleLevelText.Format(value, 2)`.
5. **Merge.** See group facts 3 and 4.1.
6. **Tests.** `ScheduleTypedNumberTests` (30 cases), pure, plus one source guard. The log says "written with the change, not run red first". The parsing cases would fail before the change only because `ScheduleTypedNumber` did not exist; the behaviour inside the drawing (put back, message) is not driven by any test. No real %APPDATA%.
7. **Not proven, and the robot case (CE 02).** On a copy: (1) PITSCHEDULE, place the table. (2) MOVE the whole table 5 m: right result is no "CE could not read" line, every cell unchanged. (3) Double-click a cover cell, type `21,15`, Enter: the cell shows the real cover and the line names "21,15". (4) Type `21.155`: the cover becomes 21.15 or 21.16 (record which, and on which AutoCAD), and the "CE kept" line appears. (5) In an inlet size cell type `2/375`: accepted as 375. Type `375/450`: refused. (6) U after step 3: the cell and the pit's cover return to before. Then REDO: no extra line, no change to the record. No Codex window look needed.
8. **Verdict: KEEP-WITH-NOTE.** Notes: the MOVE check above, and the rounding call in the #1409 follow-up. Train class was FULL (it runs on every edit of a linked schedule cell); it has shipped.

---

### #1425: BUG-791, the Pit Schedule window marks only changed cells, never the pit size

1. **What changes.** In PITSCHEDULE, F2 then Enter without typing no longer turns the cell gold-italic (overridden). Typing a pit size (900 x 900) resizes the pit as before but never marks the size as overridden, so a later PITEDIT to 1200 x 1200 shows 1200 x 1200 and Review and Update is not blocked. A real change to Cover is marked as before (`PitScheduleDialog.xaml.cs`, PR lines 216-223; `PitScheduleOverrideMarkPolicy.cs:17-28`). This is what the carpark and BUG-193 ask for. I checked the other marking path: `TrackOverriddenField` in `PitScheduleViewModel.Data.cs:1113-1135` already leaves PitSize out, so the fix is complete.
2. **Switch.** `linking.scheduleWindowMarksOnlyChangedCells`, ON. OFF: `ShouldMark` returns true at once (`PitScheduleOverrideMarkPolicy.cs:19-20`), which is the old behaviour exactly. No engineering value.
3. **No-hard-blocks.** None added; it removes a cause of a Review and Update block.
4. **Protection and REDO.** Window only, no drawing write. Not applicable.
5. **Merge.** Only `UserSettings.cs` and `REGRESSION_LOG.md`; no shared function with this group.
6. **Tests.** 6 pure tests plus a source guard. Not red first (new class). The window itself is not driven. Known limit in the log: retyping "21.5" over a shown "21.50" still counts as changed.
7. **Not proven.** Codex W2-02 PASS SURE on 3.0.70 (23 Oct) and Codex look A2 (2 Nov) saw all four behaviours. The robot cannot read cell colours. It is not yet Codex-accepted under RULES 13.3 only because no runner case exists. Old drawings: a pit size marked by an earlier version stays marked until Stop overriding.
8. **Verdict: KEEP.** Civil area + smoke; shipped.

---

### #1413: BUG-784, the FROM column keeps a real pit's number

1. **What changes.** A pipe arriving from a pit named C1, CP3, SPS1 or an X-Civil GP4 now prints "C1", not "C", in the FROM column of the window and the drawn table. Both use `BuildInletFromDisplay` (`ScheduleLinkService.cs:2548` on the PR head), so one change covers both. Downpipes and other source blocks still lose their number ("DP"). Two pipes from C1 at one level stay two rows, not "C1s" (`PitScheduleBuilder.cs`, PR lines 212-215, 225-257, 283-287). This is what the carpark asks for.
2. **Switch.** `linking.scheduleFromKeepsPitNumber`, ON. OFF: `KeepsPitNumberInFrom` returns false and the merge rule's added condition is false, which gives the old text exactly. No engineering value; the tag-letter lists are naming conventions. The source letters come from the one list `SourceFamilies.All`. Only the old tags R, D, PD, PP and SD are typed by hand.
3. **No-hard-blocks.** None.
4. **Protection and REDO.** Text only, through the existing refresh. No new write path.
5. **Merge.** Only the two shared files.
6. **Tests.** 19 tests; `TheFromTextForAnInletFromPitC1_IsC1` would fail before (it returned "C"). Not run red first per the log.
7. **Not proven.** Codex W2-01 NOT TESTED: the fixture has no non-P pit upstream. Limits: a real pit named R1, D1, PD1 or SD1 still prints "R", "D", "PD" or "SD". The merge rule's pattern `^[A-Z]+\d+$` is upper-case only; it is safe because `StripSourceTagNumber` upper-cases first. Robot case: on a copy, rename a pit upstream of P2 to C1 with PITEDIT, add a second pipe C2 into P2 at the same invert, and a downpipe DP1. In PITSCHEDULE the FROM cells read "C1", "C2" and "DP" on separate rows, and the drawn table matches after a refresh. Switch OFF and reopen: "C" and "C" merged to "Cs".
8. **Verdict: KEEP-WITH-NOTE.** Note: R1 and D1 pits still shortened (worth one line in the carpark). Civil area + smoke; shipped.

---

### #1409: BUG-807 and BUG-809 item 3, level text rounding and a minimum cover of 0

1. **What changes.**
   1. `PitScheduleLevelText.Format` (`PitScheduleLevelText.cs:24-34` on the PR head) now rounds a half away from zero and never prints "-0.00". `BranchJunctionRules.FormatInvert` (`PipeEndClassification.cs:232-233`) calls it.
   2. **Where this rounding reaches the drawing:** the level stored when you type a cover or inlet level in the PITSCHEDULE window (3.0.88 `PitScheduleViewModel.Data.cs:1806`, `:1906`), and the IL figures in branch-junction notes (`BranchJunctionDisplay.cs:190-231`, `LinkService.NewPipeEnds.cs:76-81`).
   3. **Where it does NOT reach (the gap):** the Pit Schedule DEPTH column. On the PR head the window depth is `(cover - outlet).ToString("0.00")` (`PitScheduleViewModel.Data.cs:2118`, `:2122`, `:2126`) and the drawn depth is the same (`ScheduleLinkService.cs:2610`). On 3.0.88 the depth goes through `PitScheduleDepthRule.DepthText`, which still uses `ToString("0.00")` (`PitScheduleDepthRule.cs:56` and `:72`), plus the OFF branch in `ScheduleLinkService.BuildDepthTextFromRecord` (`:2751`). The carpark's own example (cover 18.50, outlet 18.504) is a depth, so **on AutoCAD 2025 and later it still prints "-0.00" today**. The PR's step 5 ("the depth reads 0.00") would fail there. The PR's own note 6 saw this coming ("PR for BUG-785 … should call PitScheduleLevelText.Format when both merge"), and it never happened. The drawn cover and IL cells (`FormatLevel2Dp`, `FormatLevelForInvert`) and #1426's typed-cell path also keep `ToString`; they mostly re-print an already-rounded stored figure, so they matter less.
   4. **Minimum cover:** `MinimumCoverForChecks.Choose` (`MinimumCoverForChecks.cs:24-31`) uses the assumed 600 mm when the office value is 0, negative, or not a number. It writes one line to the CE log per session (`:44-49`). It covers the Inspector summary, its pit cover row, the Civil Hub and the repair checks; CDRULES reads the rulebook separately.
2. **Worked examples of rounding, in metres** (before = AutoCAD 2024 / AutoCAD 2025+, after = where the new rule is used):
   1. **Depth 18.50 − 18.504 = −0.004 m:** before "0.00" / "-0.00". After: "0.00" in a branch note, but the Pit Schedule depth STILL "-0.00" on 2025+ (the gap above).
   2. **1.125 m (exactly on a half):** before "1.13" / "1.12" (the carpark and the PR's red-first run). After "1.13".
   3. **12.345 m (the computer stores it a hair under 12.345):** before "12.35" / "12.34" (my reading of how 2025+ prints; I did not run it). After "12.35", because the new rule first reads the figure to 15 significant digits, as 2024 did.
   4. **−1.125 m:** after "-1.13" (away from zero, as in a level below datum).
   5. **−0.005 m:** after "-0.01", not "0.00": a true half rounds away from zero even below zero. That is consistent with the rule; a reviewer should know it.
   6. **Three decimals, 12.3456 m:** after "12.346".
   So the effect is: 2025+ now prints what 2024 always printed, except in the depth column.
3. **Switch.** `linking.levelTextRoundsHalfAway`, ON (`UserSettings.cs`, PR lines 524-530). OFF: `Format` falls through to `level.ToString(pattern)`. That is the old code exactly for the window. For branch notes the old code was `ToString("F" + n)`, which prints the same as `"0.00"`. OFF is effectively exact. **The minimum-cover fallback has no switch.** The author calls it a protection. Under R-00 that is defensible, but it changes a result: a job with 0 in Settings now gets 600 mm checks.
4. **R-00 / engineering value (Tim's call).** `AssumedMm = 600` is hard-coded (`MinimumCoverForChecks.cs:18`, from BUG-521). The file's own comment says the Settings default is 300. Falling back to 600 when Tim's office typed 0 picks an engineering figure in code. It also tells the drafter only in the log. The carpark asked for "refused or falls back to the assumed value with a message". Recommendation in FOR TIM line 6.
5. **No-hard-blocks.** None; nothing refuses.
6. **Protection and REDO.** Text formatting and a check figure only. No drawing write path changed.
7. **Merge.** `UserSettings.cs` value sits lower in `LinkingSettings`, so it does not clash there; `REGRESSION_LOG.md` only.
8. **Tests.** `LevelTextRoundingTests` (13). The author reports 8 failed before and pass after. That is believable for the −0.004, the halves and the 0 cover, but they run only on net10; on net48 the halves already passed. No test covers the depth column, which is how the gap got through.
9. **Not proven, and the robot case.** On a copy, on AutoCAD 2025 or later: (1) a pit with cover 18.50 and an outlet invert of 18.504: read the DEPTH cell in PITSCHEDULE and in the drawn table. Today expect "-0.00" (the defect); after the follow-up "0.00". (2) In PITSCHEDULE type an inlet level 12.345: the stored and shown level is 12.35. (3) Settings, minimum cover 0, open the Civil Hub: the cover figure used is 600 (today) and the CE log has the one line. Repeat (1) on AutoCAD 2024 if available: "0.00" both before and after.
10. **Verdict: CHANGE-NEEDED, as a small follow-up PR** (the code has shipped, so the PR itself cannot change). Exactly: (a) in `PitScheduleDepthRule.DepthText` (both overloads, 3.0.88 lines 56 and 72) and in the OFF branch of `ScheduleLinkService.BuildDepthTextFromRecord` (line 2751), print with `PitScheduleLevelText.Format(depth, 2)` instead of `ToString("0.00")`; (b) the same in `ScheduleLinkService.TryHandleEditedCell` for the typed cover and invert (#1426's note); (c) add a test that depth for cover "18.50", outlet "18.504" reads "0.00"; (d) get Tim's word on 600 versus 300 mm and add a command-line line. Under the same switch. Civil area + smoke. CE 05: add the depth gap to BUG-807's carpark status, which today reads "fix installed via PR #1409" as if whole.

---

### #1431: BUG-808 outlet half, the outlet warning compares with the pit's largest inlet

1. **What changes.** In PITSCHEDULE's warning column, a pit with inlets of 300 (lowest) and 375 and an outlet of 300 now shows "OUTLET SMALLER THAN INLET". Detention pits are still excused. The outlet row is checked again once all rows are loaded, after Xref rows are added, and when an inlet size is edited (`PitScheduleViewModel.Data.cs`, PR lines 482, 661, 1371-1373, 2195-2212, 2224-2233; `PitScheduleOutletSizeCheck.cs`). This matches the carpark's outlet half. The CDCHECKDWG counting half is NOT done, as the PR says.
2. **Switch.** `linking.scheduleOutletVsLargestInlet`, ON. OFF: `RecheckOutletWarnings` returns at once and `ComputeDiameterWarning` skips the new block, so only the row's own inlet is compared. That is the old behaviour exactly. The recheck call in `OnRowPropertyChanged` still runs, but it does nothing when OFF. No engineering value.
3. **No-hard-blocks.** A warning only.
4. **Protection and REDO.** Window only, no drawing write.
5. **Merge.** See group fact 4.2 for the shared function with #1415 and #1422.
6. **Tests.** 6 pure tests plus 2 source guards. Not red first (new class). The window itself is not driven.
7. **The slip (not proven either way).** The pit's rows are pooled by `SourcePitHandle` and schedule set only (PR lines 2228-2232), not by drawing. In the Xref view (`LoadFromSelectedXrefs`), rows from two Xref'd drawings each carry their own drawing's handle (`SourceDrawingIdentity` is set at line 805). Two drawings started from the same template can share a handle. Then a 300 outlet in drawing A can be compared with a 375 inlet of a different pit in drawing B and show a false warning. The fix is one more condition: the same `SourceDrawingIdentity`. The detention-pit lookup (`GetPitByHandle`, line 2245) already had this weakness for Xref rows before this PR.
8. **Not proven, and the robot case.** On a copy: a pit with an outlet of 300, a low inlet of 300 and a higher inlet of 375. PITSCHEDULE: the outlet row's warning reads "OUTLET SMALLER THAN INLET". Change the 375 inlet to 300 in the window: the warning clears. Make the pit a detention pit: no warning. Switch OFF and reopen: no warning (old behaviour). A Codex look at the warning column is worthwhile, because the robot reads text but this is a coloured column.
9. **Verdict: KEEP-WITH-NOTE.** Note: add the same-drawing condition for the Xref view. Civil area + smoke; shipped.

---

### Summary of verdicts

1. **#1426:** KEEP-WITH-NOTE (check a table MOVE; rounding call folds into the #1409 follow-up). Was FULL; shipped in 3.0.70.
2. **#1425:** KEEP. Civil area + smoke; shipped.
3. **#1413:** KEEP-WITH-NOTE (R1 and D1 pits still shortened). Civil area + smoke; shipped.
4. **#1409:** CHANGE-NEEDED as a follow-up (the depth column still prints "-0.00" on 2025+; Tim's call on 600 vs 300 mm). Civil area + smoke.
5. **#1431:** KEEP-WITH-NOTE (pool by drawing in the Xref view). Civil area + smoke; shipped.
6. **Housekeeping:** close all five PRs as merged via the 19 Oct train.
