# FIX WAVE 2, BATCH 5 OF 5: ledger top-25 fixes 21 to 25 (Fri 23 Oct 2026, Melbourne, 09:17 to 10:15)

## ANSWER FIRST

All five fixes were real and are built, each as a DRAFT PR against `claude/rel-20261022m` with a test that failed before and passes after. None is installed, none opened in AutoCAD. Nothing was marked FIXED, no PR closed, no branch deleted.

1. **#21 BUG-999 (F-196), CDRUNSOLVE.** PR #1617, head `330ee22f`. Tests: 3 new (2 red before, 3 green after). Civil net10 total 19,137 passed, 19 skipped, 1 failed (the known GE 24-115 back-test). Half done on purpose: CDRUNSOLVE now says it could not solve; feeding real flows needs Tim's word (see Skipped).
2. **#22 BUG-969 (F-159), CDNEWDWG job folder.** PR #1619, head `a47286ee`. Tests: 6 new (1 red before: the dialog guard; helper tests read real temp job folders). Civil net10 total 19,140 passed, 19 skipped, 1 failed (known). Civil net48 build 0-error.
3. **#23 BUG-947 (F-123), damaged prepared update.** PR #1621, head `b00ffe75`. Tests: 4 new (3 red before, tamper test kept and still passes). Manager net10 total 857 passed, 0 failed; Civil net10 on the same branch 19,134 passed, 19 skipped, 1 failed (known).
4. **#24 BUG-1004 (F-201), Design says "Nothing has changed".** PR #1623, head `e0397253`. Tests: 6 new (4 red before). Civil net10 total 19,140 passed, 19 skipped, 1 failed (known).
5. **#25 BUG-1019 (F-224), CDCALC levels at or below RL 0.00.** PR #1625, head `08e30026`. Tests: 7 new (3 red before). Civil net10 total 19,141 passed, 19 skipped, 1 failed (known).

**Skipped (not done):**

1. **F-195 (BUG-998)** and **F-226 (BUG-1021)** were named "do in the same pass" in the ledger. They are not in my five. BUG-1021 already has open PR #1593, so its files were not touched. BUG-998 is network redesign preview/ticket code (not in my scope); left for its own item.
2. **Feeding real flows to CDRUNSOLVE (the other half of BUG-999)** needs Tim's word, so nothing was guessed (options below).

The only red in every Civil run is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one. No other test changed.

## Per fix: what was verified, what changed

1. **BUG-999 (F-196).** *Verified:* every node in `BuildRunInputs` carries `CatchmentFlowLps: 0.0`, so `NetworkDesignService.Design` sizes every pipe at zero flow and the sizer refuses ("Design flow must be greater than zero"). `BuildRunSolvePlan` skipped each pipe with only a warning, so the plan was empty and `RunSolveCommand` printed "every invert already matches the solved design". *Changed:* `ProposalApplyService.PlanBuilders.cs`: when pipes were not solved and no change is planned, the plan carries an Error with the first reason; the command already prints "Plan could not be built - ..." for that case. A solved run that really matches still says "already matches". No switch (corrects a false message). *Tests:* `Bug999RunSolveNoFlowTests` (real BuildRunInputs, Design and BuildRunSolvePlan for a one-pipe run A to C, covers 12.0, inverts 10.6/10.0). *Not changed:* the 0.0 flow itself.
2. **BUG-969 (F-159).** *Verified:* `NewJobDrawingDialog` kept `_jobRecord` loaded for the guessed folder and `RefreshPlan` used it for the job number and title block whatever folder was typed. *Changed:* new `Rules/NewJobDrawingRecordSource.cs` hands back the record for the folder now in the box (re-read when the folder changes, blank for a folder with no record or an unusable path); the dialog uses it. No switch. *Tests:* `Bug969NewDwgJobFolderTests`.
3. **BUG-947 (F-123).** *Verified:* `CeUpdateStagingService.Stage` threw "conflicting identity evidence" whenever the final stage folder existed and anything differed, including a missing file, so the fresh verified copy was discarded every time. *Changed:* if the old copy is incomplete (unreadable receipt, bundle folder, signed release files or a listed file missing) it is moved aside to `.preparing-damaged-<guid>` (kept, not deleted, ignored by the stage scans like `.preparing-` folders) and the fresh verified copy takes its place. Present-but-different bytes still fail closed (the existing tamper test is unchanged and passes). Installed bundle never touched. No switch. *Tests:* `CeUpdateStagingServiceTests.Bug947.cs`.
4. **BUG-1004 (F-201).** *Verified:* the agreed snapshot held neither the orifice head nor the detention answer, so `Compare` could never see them. *Changed:* both recorded in the existing optional `AgreedDesignInputs` block (`orificeHeadM`, `detentionRequired`), compared when known on both sides, and listed in "could not be checked" when an older agreed design lacks them (same pattern as the runoff coefficients). Confirm setup records the window's values; During reads what the drawing and the last Save Draft hold. No switch. *Visible side effect:* an older agreed design reopens with a line saying the head and detention answer were not recorded; Confirm setup once clears it. *Tests:* `Bug1004AgreedDesignHeadAndDetentionTests`.
5. **BUG-1019 (F-224).** *Verified:* `ComputeSuggestedTwl` returned 0 when the highest invert was at or below 0, `UpdateTwlWarning` returned early for a TWL or lid at or below 0, and a blank invert (parsed as 0) could beat a real negative level in the max. *Changed:* knowledge of a level is tracked separately from its sign (`FromInvertKnown`, `ToInvertKnown`, `MaxInvertKnown`, `CoverLevelKnown`, set from whether the text parsed; rows made without that fall back to "not 0 is known" so old tests and callers behave as before). The suggestion uses the highest recorded invert (-1.000 gives -0.70 for DN300); no recorded invert keeps the old 0.00 placeholder and no lid warning is made from a water level CE did not know. Base stays `rel-20261022m`: #1538 touches none of these files. No switch. *Tests:* `Bug1019CdcalcLevelsBelowZeroTests`.

## Needs Tim's word (BUG-999, other half)

CDRUNSOLVE has no pipe flows to size with. Options:

1. **Recommended: leave it honest** (what this PR does), and decide later whether Run Solve is a levels-only tool. Real example: a drafter runs it on a 3-pipe run and is told plainly it could not solve, instead of being told the inverts match.
2. **Feed each pipe's saved design flow** (`PipeData.DesignFlowLps`) into the solver. Real example: pipes with a flow set from the Pipe Flows tool get sized; pipes without one still cannot be solved and are named. Needs Tim's confirmation that a saved flow is the right basis.
3. **Make Run Solve levels-only** (keep each pipe's size, solve only inverts for a fixed grade). A different command behaviour; needs the review gate.

## Hygiene and evidence

1. **Worktrees:** `C:\ce-fx\w5a` to `w5e`, one per fix, all removed. The main checkout `git status` is unchanged from the start (only the same untracked items).
2. **Environment:** Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net10 refs `C:\TimOS\refs\autocad\autocad-2026-ref` and `autocad-net8-ref`, net48 refs `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, a fresh CE log folder per run, build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran. Foreground only.
3. **Settings files:** not touched, nor installed bundles or ProgramData. AutoCAD, Codex and accoreconsole were not started.
4. **Honest note on a first Manager run:** two early Manager runs failed 5 and 22 tests because my first log-folder variable used forward slashes (a Bug842 temp-path guard); fixed the variable and the third run was 857 of 857. The Civil runs were unaffected.
5. **Not run:** net48 for BUG-947, BUG-1004, BUG-1019 and BUG-999 (only BUG-969's Civil net48 build ran, 0 errors); Structural; Installer.Tests; anything in AutoCAD.
6. **Four words:** built and unit-tested. Not installed. Nobody has opened any of these in AutoCAD.
7. **DESK_LOG.md and BUG_CARPARK.md were not edited.** All five bugs are still OPEN in the carpark until Tim confirms in AutoCAD.
