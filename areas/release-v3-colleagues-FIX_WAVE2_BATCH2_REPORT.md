# Fix wave 2, batch 2 of 5: ledger top-25 fixes 6 to 10 (Fri 23 Oct 2026, 06:23 to 07:40 Melbourne)

## ANSWER FIRST

All five fixes were real on the base and each is now a DRAFT PR against `claude/rel-20261022m`. None skipped. Built and unit-tested; nobody has opened any of them in AutoCAD. Nothing marked FIXED, nothing closed or deleted.

1. **#6 BUG-877 (F-010), import review page draws the old file:** PR #1558, head `91d8c39d`, branch `fw2/bug-877-import-choose-file`. 7 new tests. Full Civil net10: 19,161 run, 19,141 passed, 19 skipped, 1 failed (known Glen Eira back-test). Switch `xcivilImport.importReviewRefusesChangedSource`, ON.
2. **#7 BUG-874 (F-004), Esc after a CD callout drops the link:** PR #1562, head `cda22fb9`, branch `fw2/bug-874-cd-esc-callout-link`. 8 new tests plus 3 old guard tests updated (they pinned the old "discard on cancel"). Full Civil net10: 19,165 run, 19,142 passed, 1 known failure plus those 3; the 3 re-ran green with the call-graph and command-end suites (125 of 125). Switch `linking.escKeepsPlacedCalloutLinks`, ON. Needs Opus review (protected file, redo-safety baseline grows by 10 lines).
3. **#8 BUG-963 (F-152), CDPROPAGATE writes the upstream level into the only IL text:** PR #1567, head `14006793`, branch `fw2/bug-963-propagate-single-il`. 6 new tests. Full Civil net10: 19,160 run, 19,140 passed, 19 skipped, 1 known failure. Switch `linking.propagateWritesSingleIlToItsOwnEnd`, ON. Protected file.
4. **#9 BUG-965 (F-155), Refresh drops "2/" and trench grate length:** PR #1570, head `c732d63e`, branch `fw2/bug-965-refresh-twin-trench`. 7 new tests. Full Civil net10: 19,161 run, 19,141 passed, 19 skipped, 1 known failure. Switch `linking.scheduleRefreshKeepsTwinAndTrenchText`, ON.
5. **#10 BUG-971 (F-161), unreadable record replaced:** PR #1576, head `bae50a7b`, branch `fw2/bug-971-unreadable-record-kept`. 8 new tests. Full Civil net10: 19,162 run, 19,142 passed, 19 skipped, 1 known failure. Switch `linking.keepUnreadableDrawingRecord`, ON. Needs Opus review (save path, protected file).

**Skipped:** none. **Not done on purpose:** BUG-982 (F-173, rounding in CDPROPAGATE) and BUG-988 (F-179, old PC-side file beats an empty record). The ledger says "do in the same pass", but each is a separate defect with its own test; they stay open for their own change.

**Tim's word needed:** none of these five needed an engineering or design ruling.

## 1. What was checked first (verify the cause)

1. **BUG-877 verified.** `CivilImportWindowViewModel.ChooseSource` clears the reading, but `LinkCommands.ImportXcivil.cs` kept the file it had already read and `confirmProceed` returned `ContinueRequested`, so file A was drawn.
2. **BUG-874 verified.** `HandleCommandInterrupted` (cancel and failed) cleared `DeferredAttachmentRegistrations` unconditionally; only the normal command end wrote them.
3. **BUG-963 verified.** `UpdateIlAnnotationsForPipe` gave the only IL text the first end's level whichever end the text belonged to.
4. **BUG-965 verified.** Refresh used its own `FormatDiameter` and `BuildPitSizeText`; the window uses `PitScheduleBuilder` (twin prefix, trench grate, pump pit blank).
5. **BUG-971 verified.** The normal load discarded "record exists but unreadable" (`LoadFromDrawingLight`), built an empty record and the save overwrote the original.
6. **Open PRs:** `gh pr list --state open` searched the title, body and branch of 300 open PRs for each of the five bug numbers in full: none touches any of them, so no comment-only case.

## 2. Plain wording: what Tim will see

1. **BUG-877:** read file A, choose file B on the review page, click Read source: CE stops, draws nothing, names both files and says to run the command again. (It does not re-read B in the same window; that needs a read loop and is not in this fix.)
2. **BUG-874:** place a pipe with a callout in CD, Esc at the next-pipe prompt, erase the pipe: the label goes with it. One U brings both back.
3. **BUG-963:** hide the upstream IL, CDPROPAGATE 9.50 at the downstream pit: the one text left reads "IL 9.50". A single text whose end was never recorded (older drawing) is left alone and the pipe is named in the summary.
4. **BUG-965:** Refresh keeps "2/375" for twin tanks and "3000" for a trench grate, and a pump pit stays blank instead of "0 x 0".
5. **BUG-971:** a drawing whose CE record cannot be read gets one plain message on the command line, and CE does not save over the original record, so manual schedule rows and remarks stay. Drafting carries on.

## 3. What was not tested

1. Anything in AutoCAD or accoreconsole (none was started). The fixes are proved by pure rule tests and source guards, not by driving a drawing.
2. The ledger's drawing-level tests (an IL text reading "IL 9.50", a damaged PROJECT_DATA drawing, a CD placement then Esc) need a real Database: left to the AutoCAD checklists in each REGRESSION_LOG entry and PR.
3. net48, Structural, Manager and Installer tests. Only Civil net10 was run, in full, once per fix.
4. Settings window rows for the five new switches (the switches work from the settings file; a Codex window job would add the rows).

## 4. Test evidence and environment

1. **Environment:** private worktrees `C:\ce-fx\b2\f877`, `f874`, `f963`, `f965`, `f971` (one per fix), Release net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, refs from the C-57 assembly report (`autocad-2026-ref`, `autocad-net8-ref`, net48 2024 refs), AutoCAD 2027 folder on PATH, a 0-byte `CE_TRANSFORM_2027.arx` placeholder, TEMP in `C:\ce-fx\b2\tmp`. Every build and test ran in the foreground; the shared `C:\CE_PLAN\desk_jobs\build.lock` was held only while each command ran.
2. **The one red in every full run** is `BackTest_GlenEira24115_Computed_WithinTolerance` (known). No other red remained.
3. **BUG-874's three updated tests:** `CancelledCommand_DiscardsDeferredAttachmentRegistrationsWithoutProcessingThem` (now: one guarded write through the pure rule), `CancelledAndFailedCommands_KeepTheExistingInterruptOnlyPath` (the cancelled handler now passes `cancelled: true`; failed unchanged) and `EveryHookBetweenCommands_IsRedoSafe_OrReviewed` (5 new baseline lines each for `OnCommandCancelled` and `OnCommandFailed`). The Opus review should confirm a write at the cancelled event keeps REDO safe; the rule never writes at U / UNDO / REDO / MREDO, in the redo window, or at a failed command.
4. **Tests that failed before:** the new code did not exist before each fix, so the new tests could not compile on the base. BUG-965's switch-OFF test pins the old text ("375", "300 x 300").
5. **Settings files:** none touched. Installed bundles, ProgramData and Tim's settings were not read or written.

## 5. Hygiene

1. No PR closed, no branch deleted, nothing marked FIXED, `DESK_LOG.md` and `BUG_CARPARK.md` not edited, nothing installed or deployed.
2. The five private worktrees and `C:\ce-fx\b2` (logs, temp, my scripts) were removed after the last PR; the five `fw2/` branches stay on origin. Other jobs' files in `C:\ce-fx` were not touched.
3. **Four words:** built and unit-tested. Not installed. Nobody has opened any of them in AutoCAD. Not Tim-accepted.
