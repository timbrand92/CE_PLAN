# BUGFIX n3 report, batch 3 (Edit Pipe batch editor and grade lock), B-117, 31 Oct 2026

## FOR TIM (read this block only)

1. **Answer: no PR.** I opened no draft. I checked all four bugs on the newest line (Civil 3.0.88, `claude/rel-20261102a`). Two are already fixed, one is mostly fixed, and what is left is a decision for you or a window job for Codex.
2. **BUG-291 (Design grade turns a pipe round): ALREADY FIXED** in C-5 (1 to 3 Oct). Design grade, "work it out from the grade" and Carry downstream now follow the recorded upstream end, not the first end you drew. 95 related tests pass, including the ones for this.
3. **BUG-297 (pit found by "within 100 mm of the insertion point"): ALREADY FIXED** in C-5. The pit is now found by its drawn outline plus a small margin. Only a pit record with no size at all still falls back to the 100 mm rule.
4. **BUG-340 (Edit Pipe batch, Carry downstream):** items 1 to 6 and 9 were fixed on 2 Oct by C-7. A pit that two ticked pipes run into now takes the LOWER arriving level (your 9.00 / 8.80 example no longer climbs 180 mm). The other items, 29 tests, all pass on this line. Left over: 7 (reminder when the Pit Schedule opens), 8, 10, 11, 12, below.
5. **BUG-343 (grade lock):** item 1 (break-pair half worked from its own length) was fixed by C-7 on 2 Oct. Item 4 (Repair Center cut-off buttons) is a window, so Codex. Items 2, 3 and 5 need your word first (questions below).
6. **A thing you should know:** when I listed your real settings folders before and after, `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` had changed (details below). The change happened at 7:30:17 pm, before my test build even started, and nothing was written during my test runs. So it was not my run, but something on your PC replaced that file with an older copy. Please check what ran at 7:30 pm.

### Questions (one line each, for CE 04 via CE 05)

1. **BUG-343 item 3:** when you have fixed the DOWNSTREAM level of a pipe (typed it), and a pit moves, should the grade lock keep that downstream level and move the UPSTREAM level (today it always keeps the higher end and moves the lower one)? Recommendation: yes, keep the end you fixed. Example: pit moves 2 m further away, pipe held 1 in 100, you typed 20.00 at the downstream pit: today the downstream level slides to 19.98 and your typed 20.00 is lost.
2. **BUG-343 item 2:** when a pipe is set flat (Pit Schedule, Inspector, IL label or CD), should CE switch its grade setting from "Minimum" to "Levels" so a repair does not treat it as flat by accident? Recommendation: yes, but only when the two levels are exactly equal.
3. **BUG-343 item 5:** should a repair command (CDFIXFLATPIPES or a new one) find labels left as "1 IN 1" or "0.01m" by the old metre fault on pipes that never went flat? It would rewrite drawn labels, so it needs a command card first.
4. **BUG-340 item 7:** a reminder, when the Pit Schedule opens, that a batch left rows "as drawn". It needs a small saved list in the drawing first (design card). Do you want it?

## Technical detail

### Method
1. Worktree from `origin/claude/rel-20261102a` (3fbb9da5) at `C:\CE_WORK\build\n3`. Read the carpark entries in full, then the code and the REGRESSION_LOG entries for each item.
2. Focused tests, net10 only, one project (`Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj`), with `--filter`, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below-normal priority, isolation variables set and printed in each run (all under `C:\CE_WORK\scratch\n3`). The first attempt found both build slots busy and waited. No Manager tests. The net48 compile was not run (nothing changed).
3. Run 1: `FullyQualifiedName~C7Batch`: **29 of 29 passed** (count not zero). Run 2: `C617SplitPipeGradeLock | C5RefreshDirection | C5MixedUnits`: **95 of 95 passed**.

### Per bug, with evidence on the 3.0.88 line
1. **BUG-291: ALREADY FIXED.** C-5. Code: `PipeEditCommand.Batch.cs` 417-451 (recorded upstream end, "BUG-291" comments), `PipeEditCommand.Batch.Cascade.cs` 765, `PipeEditCommand.Update.cs` 224-256 and 410-424 (`HeldEndMissing`, direction-aware), `CdViewModel.Inverts.cs` 560-656. REGRESSION_LOG.md line 11836 ("BUG-291 - Design grade turned a pipe drawn from its downstream end round"). Tests: `C5RefreshDirectionTests` ("BUG-291: Design grade direction", from line 324). Passed in run 2.
2. **BUG-297: ALREADY FIXED.** C-5. `PipeTruthResolverService.ResolvePitIdAtPoint` (about lines 755-790) uses the pit outline with a margin; the 100 mm reach (`PitLookupToleranceMm`, line 20) applies only to a record with no sizes. REGRESSION_LOG.md around line 11899 and 11954. Tests: `C5MixedUnitsTests` ("BUG-297: Edit Pipe's pit lookup", from line 347), passed in run 2. The carpark line number 651 is stale.
3. **BUG-340**
   1. Item 1 (lower arrival wins): fixed, `ComputeAcceptedCascadeSteps` (`Batch.cs` 175-199 area) and `PlanDesignGrade`; REGRESSION_LOG 10611 "C-7 batch review item 1"; `C7BatchCascadeConfluenceTests`.
   2. Item 2 (clash warning for two batch pipes): fixed, REGRESSION_LOG 10596; `C7BatchInBatchClashTests`.
   3. Item 3 (Simple Pipe + Design grade preview vs Apply): fixed, REGRESSION_LOG 10579; `C7BatchSimplePipeGradeTests`.
   4. Item 4 (written twice, batch refused): fixed, `BatchWriteHandles`, REGRESSION_LOG 10564; `C7BatchCarryStopsAtBatchPipesTests`.
   5. Item 5 (both halves of a broken pipe): fixed, REGRESSION_LOG 10548; `C7BatchBrokenPipeHalvesTests`.
   6. Items 6 and 9 (hand-typed levels, locked layers named): fixed, REGRESSION_LOG 10528; `C7BatchCarryObstacleTests`.
   7. Item 7 (reminder when the Pit Schedule opens): NOT done. REGRESSION_LOG 10194 says it needs a small saved list first. A design card, so skipped.
   8. Item 8 (preview cache across Inspect drawing): not built, by evidence. `BatchEditDialogHost.Show` reopens the same view model after a plain `GetString` prompt (pan and zoom only), and the pipe snapshots (`PipeEditContext`) are read once before the window opens. Clearing the cache would change no value.
   9. Item 10 (twin pipe centreline rewritten before the pipe-object upgrade can refuse; `PipeObjectUpgrade.cs`) and item 11 (native split, `CeCvlObjectsApi.cpp`): AutoCAD-only / native, cannot be proven without AutoCAD. Not touched.
   10. Item 12 (forward: mixed-units hold on the batch preview): the hold exists on this line (`DecideMixedUnitsPerPipe`, `HoldDesignGradeForMixedUnits`, C-7 builder 1). Nothing to do.
4. **BUG-343**
   1. Item 1: fixed, `ApplyGradeLockToInverts` (`LinkService.Utilities.cs` about 2070-2180) uses `GradeLockWholeLengthMm` and `MirrorGradeLockToPartnerHalf`; REGRESSION_LOG 10743; `C617SplitPipeGradeLockTests` (passed).
   2. Item 2: skipped, needs your word (question 2).
   3. Item 3: skipped, needs your word (question 1). Cause: `ComputeGradeLockLevels` (`LinkService.Utilities.cs` about 2321) always sets `bottomIsTo = fromVal >= toVal`, i.e. keeps the higher end, and never reads the record's "downToUp".
   4. Item 4 (Repair Center cut-off buttons): a window, Codex-owned. Brief for Codex: at 820 x 600 and 980 x 680 check Focus Windows, Toggle Debug and Run Triage are fully visible without a scroll bar (C-7 builder 6 already shortened the Tools status line; the other three were not shown as fixed).
   5. Item 5: skipped, needs a command card (question 3).

### Stacking and clashes seen
No code was written, so no stacking happened. Open drafts that touch the same files (`gh pr list --state open --search`): PipeEditCommand.Batch.cs: #577, #435, #437, #592, #599, #548, #507, #508. PipeEditCommand.Update.cs: #1832, #407, #473, #492, #422, #489, #835, #552, #516, #823, #839, #444, #599, #469, #508, #548, #437. PipeEditCommand.Batch.Cascade.cs: #592, #599, #548, #508. PipeTruthResolverService.cs: #491. All have old bases (`claude/rel-2026100x` and similar), so most are likely already merged into the line or abandoned; I did not check each. #1838 (B-005) and #1919/#1927 change the New Pipe window and the grade-mismatch code, not these files.

### Real-files compare (names, sizes, last-write only; contents not read)
Before: 33,515 files over `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and `logs`), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` (including `CE_Admin`) and `CE_SUITE`, taken at 7:30 pm. After: 33,516 files, taken at about 7:35 pm. The listings were `C:\CE_WORK\scratch\n3\before_listing.txt` and `after_listing.txt` (deleted at clean-up with the scratch folder). Differences, all stamped 7:30:13 to 7:30:18 pm, i.e. before my first test command started (the first test script ran after 7:31 pm):
1. `TIM_CE_CADTOOLS\CD_Settings.json`: before 15,350 bytes, last write 31 Oct 19:27:41; after 15,270 bytes, last write **4 Oct 08:22:30** (an older copy put back, dated older than the file it replaced).
2. `TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__...json`, `CE_STRUC_SUITE__...json` and `CE_Admin\sessions\CE_CVL_SUITE.json`, `CE_STRUC_SUITE.json` rewritten at 19:30:17-18.
3. `CE_CADTOOLS\CE_Admin` Manager outbox and session files rewritten at 19:30:18.
4. Logs: `CE_CVL_SUITE\logs\*` and `CE_STRUC_SUITE\logs\*`, `TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log` appended at 19:30:13-18; `runtime_snapshot.json` rewritten.
No file in these folders has a last-write after 19:30:30, so nothing was written during my two test runs (isolation variables pointed at `C:\CE_WORK\scratch\n3`). Something else started CE (all three CE products wrote sessions in the same second) at 7:30:17 pm, and `CD_Settings.json` came back as an older copy then. I do not know what did it. No AutoCAD or accoreconsole process was running at 7:35 pm (only two long-running `codex` processes from 29 Oct).

### Shared files
None touched: no `UserSettings.cs`, no `REGRESSION_LOG.md`, no CE_SHARED, no source file at all. Nothing committed or pushed in the plugin repo. No Settings switch added.

### Housekeeping
1. Worktree `C:\CE_WORK\build\n3` cleaned (`git clean -fdXq`), removed with `git worktree remove`, local branch `claude/b117-n3-base` deleted (it had no commits). A 0-byte `CE_TRANSFORM_2027.arx` placeholder was created in the worktree for the build and went with it.
2. C: free space: 31.3 GB at the start, 30.25 GB just before clean-up (the two test builds used about 1 GB), 30.66 GB after clean-up (worktree and scratch removed; the figure is moving with Tim's other jobs, so treat the difference as roughly 1 GB).
3. Finished at the time shown in the footer line.

### What I did NOT test
1. Nothing in AutoCAD, Codex or accoreconsole. Every statement that a fix works is from code, REGRESSION_LOG entries and unit tests only.
2. The net48 compile (no change made), the full suite, Manager tests and the Structural suite.
3. Whether the C-7 and C-5 fixes survived every later merge in real drawings: only their unit tests were run.

### Robot case suggestion (no new code, so a check of the old fix)
`N3_pipe_carry_lowest`: copy drawing with P1 -> P3 arriving 9.00 and P2 -> P3 arriving 8.80, P3 -> P4 downstream. CDEDIT, select P1 and P2, tick Design grade 100 and Carry downstream, Apply. Check the P3 -> P4 upstream level is the lower arrival (8.80) less the pit drop, not the 9.00-based 8.98, and the preview line and the written level match. Switch-off control: none (the C-7 behaviour has no switch).

---
Finished: Saturday 31 October 2026 7:36 PM (Melbourne). Free on C: 30.66 GB.

