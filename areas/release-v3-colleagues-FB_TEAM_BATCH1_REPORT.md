# Fix briefs team batch 1 of 4: FB-02, FB-04, FB-05, FB-06, FB-07 (Fri 23 Oct 2026, Melbourne, 19:24 to 21:55)

Built and unit-tested only. Nobody has opened any of it in AutoCAD. No bug marked FIXED, no PR closed, no branch deleted, no bundle installed, no settings file touched, `CE_SHARED` unchanged, `DESK_LOG.md`, `QUEUE.md` and `BUG_CARPARK.md` not edited.

## ANSWER FIRST

1. **Five draft PRs opened, all against `claude/rel-20261023m` (branched from `f7f7d551`, Civil 3.0.72 / Manager 1.1.72).** Each is a real fix with a test, a `REGRESSION_LOG.md` entry and a plain "What Tim will see". The earlier Codex PRs (#1541, #1542, #1543, #1544, #1550) hold notes only; none was touched or closed.
2. **FB-02, BUG-690: PR #1659, head `62a8dea8bc01e2caaeefac30ff55e387c9f9b890`.** A pit placed on a pipe now moves the far-end decision, a downpipe on the run and a branch beyond the split to the half they sit on. Switch `linking.inlineSplitMovesDecisions`, ON, no Settings page row (see "Decisions for the desk" 1). Tests: 7 new; Civil net10 full 19,556 total, 19,533 passed, 22 skipped, 1 failed (`LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`, a timeout on a busy PC; re-run alone: passed). net48 build 0 errors.
3. **FB-04, BUG-373: PR #1663, head `636e6c48b71488ca13e42913fc93446bd798d4d6`.** Edit Pipe then Cancel writes nothing: the record catch-up before the window runs with its writes held (the BUG-290 hold), Save writes it with the edit. No switch. Tests: 4 new, 3 of them fail on the base (checked); Civil net10 full 19,552 total, 19,530 passed, 22 skipped, 0 failed. net48 build 0 errors.
4. **FB-05, BUG-817: PR #1671, head `920e8995ede2c969fdfbd158a23465346010e737`.** Both forced record writes are gone: the window's Close writes only a save really waiting for its own drawing, and PITSCHEDULE is off the always-write list. No switch. Tests: new rule and source guards; Civil net10 full 19,554 total, 19,532 passed, 22 skipped, 0 failed. net48 build 0 errors.
5. **FB-06, BUG-664: PR #1682, head `bc3e3817eb2e79090ea9ceb4dc8397fbbb817f15`.** Renaming a pit in Edit Pit renames the pipes' own notes in the same command (one U). No switch. Tests: new rule tests; Civil net10 full 19,560 total, 19,536 passed, 22 skipped, 2 failed (`LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` and `RealCivilWindowRendersEverySectionWithFixedHeaderAndFooter("Light")`, both timeouts on a busy PC; both re-run alone: passed). net48 build 0 errors.
6. **FB-07, BUG-692 and BUG-693: PR #1688, head `69451402decf98431d98a2bfce15a29a6f4830d0`.** A callout goes with the half its arrow points at; a pipe with an arc segment is left whole with one plain line. No switch. Tests: new rule tests; Civil net10 full 19,559 total, 19,537 passed, 22 skipped, 0 failed. net48 build 0 errors.
7. **Nothing skipped.** All six bugs were still present on the base; none had a real fix open.
8. **Merge note:** FB-02 and FB-07 edit neighbouring lines of `LinkService.Split.cs`; a dry merge of the two code changes is clean. All five branches add a top entry to `REGRESSION_LOG.md`, so merging them one after another will conflict on that file only: keep both sides.
9. **Not tested (all five):** nothing was run in AutoCAD, accoreconsole or Codex. net8 was not built. Test counts are the Civil net10 suite only; Manager was not touched. Structural not in scope.

## Decisions for the desk

1. **No Settings page row for the FB-02 switch.** R-00 wants one. The Settings window is at its agreed 670 px height (Opus review #1526); adding one tick box on the Newer tools tab pushed it to 689 px and made six "Settings fits" tests fail, plus the "every binding names a real value" test. I removed the row and kept the switch in the settings file, ON, like the four C-62 switches. A row needs a layout decision (a taller limit, or a scroll area).
2. **FB-04 cause is read from the code, not measured.** The driver run was on a modern pipe (DBMOD 17 to 21 with "open, type 300, Cancel"). The held-record fix covers every record save the catch-up can make, but a write from the window itself (for a modern pipe: its own read or upgrade) would not be covered. If DBMOD still moves after the AutoCAD check, the next step is the ObjectModified log probe the brief describes.
3. **FB-05 assertion differs from the brief.** The brief says DBMOD 0 after Close. Codex W2-04 saw DBMOD 21 to 21 yet one U still echoed PITSCHEDULE. The Undo step is the signal to check, not DBMOD alone. Both writers named in PR #1544 are fixed; a third writer would show as the same Undo step.
4. **Opus review is needed for FB-02, FB-04 and FB-05** (ledger write, record hold and Undo, record flush at command end). FB-06 and FB-07 need only the normal train review.
5. **FB-07 curved pipes:** a pipe with an arc is not split at all on this route (as the brief asks). Splitting an arc properly is separate work.

## Per fix

### FB-02, BUG-690 (PR #1659)

1. **Cause verified in the code:** the inline route gave the second half its own identity but never moved the decisions; the tracked route moves only the far-end decision and refuses a branch junction ("needs review").
2. **Fix:** `InlineSplitDecisionPolicy.AfterSplit` (pure) and `LinkService.MoveDecisionsToSecondHalfOfInlineSplit`, called inside the split's own transaction right after the second half gets its key. End 1 goes to the second half; a downpipe on the run beyond the split goes to the second half with its distance measured from the second half's start (14.0 m split at 8.0 m reads 6.0 m); a branch whose end touches the main beyond the split now names the second half (found by geometry; a branch that cannot be found stays). An unreadable record leaves the split as before with one log line.
3. **Tests run:** `InlineSplitDecisionTests` 7 new; narrow run with PairedPipeSplit and SettingsWindowV3: 57 of 57 passed; full run above. The new tests do not compile on the base (the rule does not exist there).
4. **Real-AutoCAD check (FX-02), for the test pack:**
   1. Fixture: P1 at 0,0 and P3 at 20000,0, a 375 pipe between them, CDCONFIRM on the P3 end, a branch pipe joined to the main at 14000,0 (or a downpipe recorded on the run at 14000).
   2. Save the Pit Schedule rows (Export) and the CDCHECK list.
   3. `PIT` at 8000,0, defaults, Esc. Save both again.
   4. Expect: the branch junction row is still there, under the second half at 6.0 m; CDCHECK shows the first half ending at the new pit, not at P3.
   5. One U gives rows identical to step 2 (0 differences); REDO puts the split back.
5. **Not tested:** `BranchSitsBeyondSplit` (geometry) has no unit test; the AutoCAD check covers it.

### FB-04, BUG-373 (PR #1663)

1. **Cause (code reading):** `EnsureDrawingDataCurrent` runs before the window opens and saves the record when it finds the record out of step with the drawing. The brief's "read that changes nothing" route would have changed what the window reads; the existing record-write hold (BUG-290) keeps the catch-up identical and holds only the writing.
2. **Fix:** hold taken after `SetDrawingPath`, before the catch-up; accepted only for Save, the older-pipe question, Move arrow and Inspect; disposed in the `finally` (Cancel, Escape, no changes and errors put the record back, write nothing).
3. **Tests run:** `PipeEditCancelWritesNothingTests` 4 new; 3 fail on the base (put the old file back and ran them), all pass after; the BUG-290 hold tests (35 with them) pass; full run above.
4. **Real-AutoCAD check (FX-04), for the test pack:**
   1. Fixture: two pits and one pipe, saved.
   2. `_.QSAVE`; `(getvar "DBMOD")` reads 0.
   3. `CDEDIT`, pick the pipe; press Cancel; read DBMOD; type `U`.
   4. Expect DBMOD 0, and U names the command before CDEDIT, not CDEDIT or PIPEEDIT.
   5. Control: change the diameter, Save: one U undoes it, REDO restores it.
   6. Repeat once on a modern (CE pipe object) pipe, typing 300 before Cancel (the driver's case).
5. **Not tested:** Edit Pit has the same catch-up and was not changed.

### FB-05, BUG-817 (PR #1671)

1. **Cause verified in the code (matches PR #1544's note):** `PitScheduleDialog.OnClosed` called `FlushPendingSave()` with no waiting save, which creates one and writes it; and `LinkService.RecordFlushCommands` listed PITSCHEDULE, so the command end flushed again.
2. **Fix:** `PitScheduleCloseFlushRule`; the window remembers the drawing it opened on and flushes only to it, only when `IsSaveWaitingFor` says a save is waiting (unknown drawing: writes as before); PITSCHEDULE removed from `RecordFlushCommands` (a waiting save is still written at command end through the existing non-trigger path).
3. **Tests run:** `PitScheduleCloseFlushRuleTests` (rule, both flush sites, the policy's waiting-save path); narrow run 53 of 53 passed; full run above.
4. **Real-AutoCAD check (FX-05), for the test pack:**
   1. Fixture: FX-04 plus a placed Pit Schedule. Draw a LINE, then `_.QSAVE` (DBMOD 0).
   2. `PITSCHEDULE`, press Close without editing; read DBMOD. Repeat with the title-bar X.
   3. Type `U` once. Expect DBMOD 0, and U removes the LINE and does not say PITSCHEDULE.
   4. Control: type a level in the schedule, Stop overriding, Close: one U restores the level, plan text, CHECK state and record; REDO re-applies them.
5. **Not tested:** whether opening the window writes anything else (no probe allowed).

### FB-06, BUG-664 (PR #1682)

1. **Cause verified in the code:** `RenamePitInPipes` rewrites only the record's From and To; the relink reads `ExplicitFromPitId` and `ExplicitToPitId` first (`RepairAudit.Linking.cs` 446 to 450).
2. **Fix:** `LinkService.RenameExplicitPitOwnership(db, tr, old, new, out leftAloneProtected)` (no transaction of its own, no relink; writes only pipes `IsSpineWritable` allows, so a locked layer, Xref or REFEDIT pipe is left alone and named in one line) and `PitRenameOwnershipRule` (capitals and spaces ignored; P50 and P15 untouched). Called from the "connected pipe names" step in a transaction opened in the same command, so one U undoes the rename. A failure is logged and the record rename still completes (warn and carry on).
3. **Tests run:** `PitRenameOwnershipTests` (rule cases plus source guards); narrow run with PitEdit tests 28 of 28 passed; full run above.
4. **Real-AutoCAD check (FX-06), for the test pack:**
   1. Fixture: P4, P5 and P6 in a row with pipes P4 to P5 and P5 to P6.
   2. Edit Pit on P5, number P9, Save.
   3. `PIT` at 60000,0 (it becomes P5). `CDREPAIR`, accept. Save the Pit Schedule rows and the CDCHECK list.
   4. Expect the pipes read P4 to P9 and P9 to P6; no pipe ends at the new P5.
   5. U back past the Edit Pit step restores the P5 names.
5. **Not tested:** the writer that changes the pipe notes needs a drawing; only the AutoCAD check covers it.

### FB-07, BUG-692 and BUG-693 (PR #1688)

1. **Cause verified in the code:** `GetEntityPosition` returns an MLeader's text point; `ReplacePolylineVertices` and `TryBuildInlineSplitPaths` work on points only, the bulge was read nowhere on this route.
2. **Fix:** `InlineSplitHalfRules` (station from the arrow when there is one; `HasCurve`; the words); the attachment loop measures a callout from `GetMLeaderAnchorPoint` (first point of its leader line); a curve is refused before the first write with `CurvedPipeWords`, and `PlanEditWordsRule.AutoSplitLine` prints "[CE] The pit was placed. The pipe under it has a curved segment, so CE did not split it. Split it by hand if needed."
3. **Tests run:** `InlineSplitCalloutHalfTests` and `InlineSplitCurvedPipeTests` (the brief's arrow-at-5 m, text-at-15 m, split-at-10 m case; bulge 0.3; the line; two source guards); narrow run 51 of 51 passed; full run above.
4. **Real-AutoCAD check (FX-07), for the test pack:**
   1. FX-07a: a CE pipe P1 at 0,0 to P3 at 20000,0 with its callout arrow at 5000,0 and the text dragged to 15000,1500. `PIT` at 10000,0, then `ERASE` the second half pipe. Expect the callout still exists (it belongs to the first half). U twice restores.
   2. FX-07b: a CE pipe whose second segment is an arc (bulge 0.3, set by the case script). `PIT` on the arc. Expect the pipe count unchanged, the bulge unchanged (DXF 42), the line above printed, the pit placed.
5. **Not tested:** the arrow measurement itself (source guard only); the first-segment arc and a closed pipe were not separately tried.

## What I did NOT test

1. Anything in AutoCAD, accoreconsole or Codex. No DBMOD or ObjectModified probe (not allowed).
2. net8, Manager, Structural, the installer. Civil net48 was built (0 errors) but its tests were not run (they do not load on this PC; see memory note).
3. The Settings window picture after FB-02 (the row was removed; the fit tests pass with it removed).
4. A base build of the five failing-test claims, except FB-04 (the old file was put back and three of the four tests failed). For FB-02, FB-05, FB-06 and FB-07 the new tests cannot compile on the base because the rule they test does not exist there.

## How it was run

1. Worktrees `C:\ce-fx\fb02`, `fb04`, `fb05`, `fb06`, `fb07`, one per fix, each removed after its PR was opened. Branches `fb/fb02-inline-split-decisions`, `fb/fb04-edit-pipe-cancel`, `fb/fb05-pit-schedule-open-no-write`, `fb/fb06-pit-rename-pipe-notes`, `fb/fb07-inline-split-callout-curve` stay.
2. Every build and test had `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the AutoCAD refs from the C-62 assembly report; net10 tests with the placeholder `CE_TRANSFORM_2027.arx` and AutoCAD 2027 on PATH; a fresh TEMP and CE log folder per run. C: free space was 14 to 21 GB before each build (guard 12 GB).
3. Commit messages name each bug in full (BUG-690, BUG-373, BUG-817, BUG-664, BUG-692 and BUG-693).

## Summary

Five draft PRs for BUG-690, BUG-373, BUG-817, BUG-664, BUG-692 and BUG-693: #1659, #1663, #1671, #1682, #1688. Each has a test, a log entry and AutoCAD check steps. Civil net10 full runs 19,552 to 19,560 tests, only machine-load timeouts failed (pass alone); net48 builds clean. Nothing was run in AutoCAD. FB-02's Settings row was left out (window at height limit). FB-04's cause is code-read only. Opus review needed on FB-02, FB-04, FB-05.
