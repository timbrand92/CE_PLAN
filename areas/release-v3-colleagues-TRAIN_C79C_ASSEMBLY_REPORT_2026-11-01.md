# Train C-79c (Civil only) assembly report, Sun 1 Nov 2026, 10:42 to 11:35 Melbourne

Assembler: Sonnet 5.5, headless (CE 01, register B-155). Nothing was opened in AutoCAD, nothing installed or deployed, no version commit, no bug marked fixed, no PR closed, retargeted or deleted, no branch deleted.

## FOR TIM

1. **Answer first:** all 9 PRs are merged on a new branch, `claude/rel-20261112a`, head **`a98e782325eb1e08ea084a33d488140b5db61d48`**, pushed normally and read back with `git ls-remote`. It sits on the C-79b2 GO head `d4ce878e` (`claude/rel-20261110a`, which had not moved).
2. **Merged:** #1941, #1942, #1881, #1975, #1976, #1977, #1978, #1979, #1980. Nine of nine, each as its branch. None was left out, none moved its head since the lists were made.
3. **Tested by machine only:** Civil full run 22,703 tests, 22,671 passed, 32 skipped, **0 failed**, with Tim's real-settings guard in the run (it passed). Manager full run 1,152 tests, 1,150 passed, 2 skipped, 0 failed. **Nobody opened any of this in AutoCAD.**
4. **My mistakes, plainly (first):**
   1. **I kept the wrong text in my first two change-log merges.** My keep-both helper also kept git's "base" copy of the log, so the #1941 and #1881 merges came out with a stray marker line and duplicated text. I caught it on the third merge, threw away my local, unpushed merges and redid all nine with a fixed helper. Cost: about 5 minutes. Nothing wrong was pushed. The pushed log has 0 conflict-marker lines.
   2. **Two house tests failed only when these PRs were together** (each PR passed alone): one pinned the exact words of a call that #1979 changed, the other read only the first 1,000 characters of a routine that #1980 made longer. I repaired the two test texts only (no product code) and wrote that in the change log.
5. **What the train does for a drafter (from the PR texts and pre-reviews, not seen in AutoCAD):**
   1. **CDIMPORTXCIVIL results page (#1941):** lists what was really drawn; a pit skipped for a locked layer reads "Not drawn - layer is locked"; an import that drew nothing says so.
   2. **Cancelled import (#1942):** closing the schedule page prints "CDIMPORTXCIVIL cancelled. Nothing was drawn."
   3. **Pit Schedule (#1881):** a pit with a long lid and remarks note gets a row twice as tall, white strips hide the middle line. Needs its own look.
   4. **After a pit MOVE and in Tidy labels (#1975):** an invert text lying across its own pipe is slid to the nearest clear spot. **This runs after every pit MOVE for every colleague, so the Opus pre-review says the train needs the FULL run.**
   5. **#1976 to #1980:** "APPROX." kept when a label is moved or flipped; Tidy labels changes nothing if you answer No or press Esc; a crowded label no longer lands on a plain label; a pipe in a layout is checked against that layout's text; Tidy labels starts faster on big drawings.
6. **All ten new switches ship ON** (each guards a fix). Five Pit Schedule tuning figures ship at 0.75, 1.2, 50, 20 and 25. No saved value of any existing user moves. No new behaviour ships without a switch.
7. **Recommended re-test class: FULL** (see RETEST below).

---

## TECHNICAL

### Merge record

1. **Base:** `d4ce878ebfff` (`claude/rel-20261110a`; `git ls-remote` read at 10:43 and again before the push: unchanged, no "Version: Civil 3.0.91" commit yet). Branch `claude/rel-20261112a` was free (ls-remote empty). Worktree `C:\CE_WORK\build\c79c`.
2. **Heads re-read live** with `git ls-remote origin refs/pull/N/head` at 10:43 and again just before the push: #1941 9ec6f131, #1942 6733f165, #1881 72b032fa, #1975 85ed7a3a, #1976 d9f58c22, #1977 9022d0d1, #1978 4dc1b03a, #1979 995a736a, #1980 4b03038b. **Every head matches the job text; none moved.** All were DRAFT/OPEN.
3. **Pre-reviews read:** AF (#1975 KEEP-WITH-NOTE FULL; #1976, #1977, #1979 KEEP-WITH-NOTE; #1978, #1980 KEEP), AE (#1881 KEEP-WITH-NOTE), W (#1941 KEEP-WITH-NOTE, #1942 KEEP). No DROP, no CHANGE-NEEDED, so no PR was left out and the "if #1975 is out" rule did not apply.
4. **Per PR (merge-base stat read before each merge; each merged as its branch):**
   1. **#1941:** 7 files, own files only (Bug898 tests, ImportDrawnLedger.cs, LinkCommands.ImportXcivil.cs, XcivilImportLockedLayers.cs, XcivilImportService.cs, UserSettings.cs, log). Clash: top of REGRESSION_LOG.md (kept both).
   2. **#1942:** its own 6 files after #1941 (the stack is sound). No clash.
   3. **#1881:** merge-base `7c6af57b`, stat from the merge-base **exactly 10 files and 3 commits** (2179b824, 07df4f48, 72b032fa), matching AE, with no foreign commit and nothing outside the Pit Schedule, UserSettings and log. So I merged the branch (the job allowed this when the merge shows exactly the 10 files) and did not need a cherry-pick. Clash: top of the log only.
   4. **#1975:** 7 files. Clashes: log top and the `linking` group of UserSettings.cs (kept both).
   5. **#1976 to #1980:** each merged as a branch on #1975's head (the stack sound, #1975's head had not moved). #1976 no clash. #1977 to #1980: clashes only in UserSettings.cs (next to `TidyKeepsLabelsOffOwnPipeStrip`, every switch block kept) and the log top.
5. **Dropped comment openers (the C-79b2 lesson):** a keep-both merge of the `linking` group leaves the shared `/// <summary>` line above only the first block. For #1975, #1977, #1978, #1979 and #1980 I put an opener above each added block. Checked after the last merge: `<summary>` 522, `</summary>` 522 (base 507 and 507; 15 new settings and 15 pairs), no close without an opener, and a blank line between every change-log entry. No separate fix commit was needed because I never committed a missing opener.
6. **Commits on the branch above `d4ce878e` (13):** nine merge commits, then `f03bcf5b` (C79cNewSwitchDefaultsTests and my change-log entry) and `a98e7823` (the two test-pin repairs and their log line).

### New switches and figures (read from the UserSettings.cs diff)

1. **Ten switches, all ON:** `xcivilImport.importResultsFromWhatWasDrawn`, `xcivilImport.cancelLineIsPlainEnglish` (#1941, #1942); `linking.scheduleRowGrowsForLongRemark`, `linking.scheduleDoubleRowHidesDivider` (#1881); `linking.tidyKeepsLabelsOffOwnPipeStrip` (#1975); `linking.movedLabelKeepsKeptWording` (#1976); `linking.tidyLabelsWritesNothingUntilYes` (#1977); `linking.tidyLeaderOutKeepsPlainLabelsPut` (#1978); `linking.tidyScanCoversOwnSpaceAndFullReach` (#1979); `linking.tidyScanUsesWindowIndex` (#1980).
2. **Five #1881 figures:** `scheduleLongRemarkCharWidthFactor` 0.75, `scheduleLongRemarkMinLinePitch` 1.2, `scheduleRowTextMargin` 50, `scheduleDoubleRowMaskInset` 20, `scheduleDoubleRowMaskHalfHeight` 25. These sit in the settings file only; Tim's decision 126 puts them on a Switches tab that is not built yet.
3. **No hard-coded behaviour without a switch was found** in the added product lines.
4. **`C79cNewSwitchDefaultsTests`** (31 tests, new class name): pins all ten switches and five figures through both start-up reads (DeserializeSettings and DeserializeSettingsTolerant) for an empty file, a C-79b2-shaped file and a group missing the keys; each typed false changes only itself (whole settings object compared); each typed true; all ten false at once; typed figures read as typed; a fresh object saves each at its default. 31 passed on net10; the class also passes on net48.

### REDO-sensitive scan (added product lines outside tests, `git diff d4ce878e..HEAD`)

1. **Word list used:** CommandWillStart, CommandEnded, CommandCancelled, CommandFailed, DocumentActivated, DocumentToBeDestroyed, DocumentLockModeChanged, Veto, Idle, `+=`, `-=`, StartTransaction, StartOpenCloseTransaction, SetSystemVariable, GetSystemVariable, SendStringToExecute, LockDocument, File.Write, File.Copy, ForWrite, UpgradeOpen, Commit(, Abort(, REFEDIT, Regen, UpdateScreen, HttpClient, async, await, Task., ExecuteInCommandContext, yield return, IsLocked, Erase(, PointMonitor, ObjectModified, ObjectAppended, ObjectErased, SaveProjectData, WriteMessage.
2. **Hits:**
   1. **Arithmetic `+=` only** (`sumW`, `paragraphLines`, `lines`, `used` in #1881 and #1979/#1980 helpers): not event hooks.
   2. **#1881 `PitScheduleViewModel.RowGrowth.cs`:** `IsLocked`, `UpgradeOpen`, `Erase`, `ForWrite` (the draw-order table), `UpgradeOpen` on the registered-application table. These erase and redraw this schedule's own white strips (wipeouts) inside the Pit Schedule command's existing transaction. **Locked layer: an old strip on a locked layer is skipped and counted; new strips are not drawn when the strip layer is locked** (lines 210 to 224 of that file). The schedule is drawn in the open drawing; no line writes to an Xref or a REFEDIT object.
   3. **`WriteMessage`:** only inside the drafter's own commands (Tidy labels count and Apply lines in `TidyLabelsCommand.cs`; import results). No event hook.
   4. **No new event subscription, no new transaction, no system variable, no SendStringToExecute, no LockDocument, no File.Write, no async or iterator method.** `StartTransaction` appears at old lines of `LinkService.TextClashTidyUp.cs` (129, 50, 677 are existing); the diff adds none.
3. **#1975's entry point, said plainly:** `LinkService.TidyTextClashesAfterNativeMove(...)` in `LinkService.TextClashTidyUp.cs` (line 108). It is the EXISTING tidy step. It is called by the existing command-ended handling after an AutoCAD edit command (MOVE and so on) in `LinkService.Reactors.cs` (lines 734, 749, 1294, 1384), by `LinkService.PitMoves.cs`, `PipeEditCommand.cs`, `PipeCreationService.cs` and Tidy labels. **It takes one transaction (existing, line 129) and DOES write the drawing:** it moves CE's own label text for records marked "Update". #1975 adds no new call site and no new transaction; it changes which spots count as a clash (the label's own pipe strip) and the spot choice. The strip is measured on a non-database copy that is disposed at once. A text on a locked layer or placed by hand is never moved (it is listed, not forced).
4. **Baseline file `RedoSafeReviewedHooks.baseline.txt`: not changed** (`git diff` empty). The compiler-renumbering trap did not recur (no async or iterator added). `RedoSafeCallGraphTests` 25 passed, 2 not run (as on every earlier train), including `EveryHookBetweenCommands_IsRedoSafe_OrReviewed`.

### Protected objects (locked layers, Xrefs, REFEDIT), from the diff

1. **#1941, #1942:** draw the import as before (existing locked-layer skip in `XcivilImportLockedLayers.cs`, which #1941 only reports on); words and a results list. No write to an Xref, a locked layer or a REFEDIT object added.
2. **#1881:** see REDO hit 2: locked-layer strips are skipped; no Xref or REFEDIT write.
3. **#1975, #1976, #1977, #1978, #1979, #1980:** move or keep CE label text through the existing tidy writer (locked layer, hand-placed and non-"Update" records are never moved). #1977 removes a start-up write. #1979 reads a layout's own space. #1980 only reads. **No added line writes to an Xref, a locked layer or a REFEDIT object.** Tidy labels is still refused while a reference is being edited (existing line).

### Build and tests

All with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, BelowNormal, fresh TEMP, TMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT under `C:\CE_WORK\scratch\c79c\t_<step>`; one top-level dotnet command at a time; C: free 50 GB at every start (floor 27).

1. **Placeholder:** the first solution build failed once on the missing empty `CE_TRANSFORM_2027.arx` copy (known, git-ignored); I created the empty file and the whole solution built with **0 errors**.
2. **Civil net10 focused** (every PR's test classes, the C77/C78/C79a/C79b1/C79b2/C79c defaults classes, C79a/b1/b2 finalizer guards, TestHygieneAppDataGuardTests, RedoSafe*, Bug351bPlanMarkerTests, C60AuditSourcePinGuardTests, plus every class matching Tidy, Xcivil, PitSchedule; guard class excluded here): first run 2,120 total, 2,115 passed, 3 skipped, **2 failed** (the two test pins, see mistake 2). After the repair: **2,120 total, 2,117 passed, 3 skipped, 0 failed.** (Its end-of-run line about the real-folder guard being inconclusive while the robot's AutoCAD ran is printed but is not a failure; the guard itself passed in the full run.)
3. **Civil net48 focused** (same filter): 2,116 total, 1,955 passed, 147 skipped, **14 failed**. **Two** are the same two test pins on a net48 test build made before the repair; after rebuilding net48, those two classes plus my defaults class: **57 total, 57 passed.** **The other 12 are `System.InvalidProgramException` at an AutoCAD geometry type (`Point3d.Origin`, `Point3d.X`, `Vector3d.ZAxis`, `Vector3d.Length`) used outside AutoCAD on net48:** the known reference-only kind; all pass on net10. By name: 4 in `Bug587PitScheduleRowGrowthTests` (#1881's own tests; **new here**), and `BranchHostLabelTidyRuleTests` (2), `Bug1000XcivilTranslateSpotFallTests` (2), `Bug1001XcivilPitIdNeighbourTests` (2), `Bug1002XcivilFallBlockRotationTests` (2). **Honest gap:** those last 8 are classes outside the C-79b2 finalizer's net48 filter (it ran 6,053 tests; mine is a different, smaller filter that includes every Xcivil and Tidy class), so I could not compare them by name against its list of 129; they are the same exception kind, and none sits in code this train added to. I did not run the C-79b2 finalizer's full 6,053-test net48 filter. I compared my 14 against its failed list by name: the 129 it holds that are not in my filter simply were not run here.
4. **Civil net10 full, ONE run after the last commit `a98e7823`:** **22,703 total, 22,671 passed, 32 skipped, 0 failed**, 5 min 13 s, **with `ZzRealSettingsFileGuard` in the run (2 passed)**. `C79cNewSwitchDefaultsTests` 31 passed; C79a/b1/b2 defaults and finalizer guards all passed; `TestHygieneAppDataGuardTests` 9 passed; `Bug351bPlanMarkerTests` 20 passed; `C60AuditSourcePinGuardTests` 39 passed, 3 not run.
5. **Manager net10 full, one run after the last commit:** **1,152 total, 1,150 passed, 2 skipped, 0 failed**. (No Manager code changed; run anyway as the job asked.)
6. **Settings guard file `C:\Lisp Files\_ACAD_DRIVER\settings_guard.json`:** at 10:43 (start) it held **entries** (a robot start at 10:42:37; the robot's AutoCAD was running). Before the full run (11:23) and after it (11:28) the file was **absent** ("clear (absent)"), so I ran the guard class inside the full run. No wait was needed. I never weakened or touched it.
7. **Byte-order-mark scan** (first three bytes at the base `d4ce878e` against HEAD, small .ps1, `C:\CE_WORK\scratch\c79c\bomscan.ps1`): 37 changed files, 36 are .cs; **lost a mark: 0; gained a mark: 0.** `UserSettings.cs` still has its mark. (The new test files follow the neighbouring test files, which have none.)
8. **REGRESSION_LOG.md:** lines starting with seven `<`, `=`, `>` or `|`: **0** (checked before the push, and in every merge result).
9. **Protected paths check:** `git diff --stat origin/claude/rel-20261110a..HEAD -- Modules/Manager Shared Installer Installer.Tests Modules/Manager/Installer CE_ACAD_PLUGIN.slnx` is **EMPTY**. No Manager, CE_SHARED, Shared, installer, loader, `SettingsService.cs` or solution-file change. (Whole diff: 37 files.)

### Isolation stamps (Tim's real files, read-only)

1. **Before (10:43:44):** `CD_Settings.json` 15,355 bytes, modified 2026-10-31 23:42:39 UTC (10:42:39 Melbourne), SHA256 `0BF1B94A...7107` (this is the robot's changed copy: the guard file lists the same hash as "written" and `ACD64E79...3140` as the original); `CS_Settings.json` 351,713 bytes, 2026-03-31 02:18:00 UTC, `622A246F...C3EB`; `CE_Admin\outbox` 28,857 files, newest 23:43:12 UTC.
2. **After (11:30:32):** `CD_Settings.json` 15,270 bytes, modified **2026-10-03 21:22:30 UTC**, SHA256 **`ACD64E79...3140`** (the 4 Oct original, put back by the robot after its AutoCAD ended: exactly the behaviour in the C-79b1 job's robot note; **not by my tests**: my runs all used the isolated folders and the guard passed); `CS_Settings.json` unchanged (same size, time and hash); `CE_Admin\outbox` 28,896 files (**+39**), newest 00:29:59 UTC.
3. **The 39 outbox files** appeared at 1 to 3 a minute from 10:44 to 11:30. I read the 11:28 burst: they are crash-inference, usage and plugin-registration files from **Civil 3.0.88 inside AutoCAD 26** running the command PIT (the installed plugin in the robot's AutoCAD), not from a unit test. I did not read every one of the 39. I cannot prove none came from my runs, but my runs set CE_LOG_DIR_OVERRIDE and the Structural app-data root to scratch and the Manager and Civil hygiene guards passed.

### RETEST (for CE 02), changed paths and the smoke cases they need

Changed-files list: `C:\CE_PLAN\areas\TRAIN_C79C_CHANGED_FILES.txt` (37 paths).

1. **CLASS to recommend: FULL.** #1975 runs after every pit MOVE for every colleague (Opus pre-review AF, point 1). This train also changes `UserSettings.cs`, so N91 (start-up smoke) is in it as well.
2. **SHARED paths and the case each needs:**
   1. **`Modules/Drainage/Models/UserSettings.cs`** (ten switches, five figures): N91 start-up smoke with a saved old settings file and with an empty one; the settings window opens; a saved value does not move.
   2. **`LinkService.TextClashTidyUp.cs`, `LabelPlacementRule.cs`, `OwnPipeStripClearRule.cs`, `TextClashTidyUpRule.cs`, `TidyLeaderOutRule.cs`, `TidyScanReachRule.cs`, `TidyWindowIndex.cs`, `MovedLabelKeptWordingRule.cs`, `TidyLabelsStartUpRule.cs`, `TidyLabelsCommand.cs`, `LinkService.SegmentAnalysis.cs` (label and pit-move code):** the label cases in item 3.
   3. **`LinkCommands.ImportXcivil.cs`, `XcivilImportService.cs`, `XcivilImportLockedLayers.cs`, `ImportDrawnLedger.cs`, `XcivilImportCancelWording.cs`:** the import cases in item 3.
   4. **`PitScheduleRowGrowth.cs`, `PitScheduleViewModel.RowGrowth.cs`, `.Schedule.cs`, `.NetworkRedesign.cs`, `PitScheduleContinuationLayout.cs`, `PitScheduleCellUpdatePlanner.cs`, `PitScheduleCellUpdateModels.cs`:** N35_sched_row2 and its switch-off twin.
   5. **`colleague-defaults.json`, anything under Shared or CE_SHARED, the settings engine, the loader, the installer: not touched.**
3. **AutoCAD checks the robot must make:**
   1. **Labels already beside a pipe must not move** on a pit MOVE (the main regression risk named in AF: a normally drawn invert text measures about 70 mm clear; if CE's measure includes the mask border every invert text beside every moved pit would be pushed out a lane). Check the other four invert texts, the number circle and the cover text keep their places on the same MOVE.
   2. **Pit MOVE of 2 m** (the G5 copy, MOVE P3 0,2000): the IL text lies clear of its own pipe (N10_pit_move_strip); its switch-off twin C10 (`linking.tidyKeepsLabelsOffOwnPipeStrip` false) must show the old overlap, or the case proves nothing.
   3. **Undo after the MOVE:** one U puts the pit and its labels back; Redo after it.
   4. **Tidy labels with No and with Esc** changes nothing in the drawing (BUG-873): read the drawing back, and check that the project record is not marked and not saved at that moment.
   5. **Pit Schedule row** for a pit with a long lid and remarks note (three or more lines): row twice as tall, white strips hide the middle line, rows below drop one row; and the switch-off twin (N35_sched_row2 with `linking.scheduleRowGrowsForLongRemark` false then Update placed schedule: strips gone, rows back to 750); needs a Codex look at the wrap and the PDF plot.
   6. **Import results page** for CDIMPORTXCIVIL: a pit on a locked layer reads "Not drawn - layer ... is locked"; an import that draws nothing says "Nothing was drawn"; **cancelled sentence**: close the schedule page of the consultant import, read "CDIMPORTXCIVIL cancelled. Nothing was drawn." and check nothing was drawn.
   7. **Cheap extras:** a moved or flipped pipe label keeps "APPROX." (BUG-1161, visible effect unsure); a pipe drawn in a layout is checked against that layout's text (BUG-891); Tidy labels on a big drawing gives the same answer as before (BUG-962 speed is not measured).

### What I did NOT do

1. **Open anything in AutoCAD**, install, deploy, make a version commit or mark any bug fixed. Every bug of the train stays OPEN. Built and unit-tested only.
2. **Run the C-79b2 finalizer's full 6,053-test net48 filter.** I ran a smaller net48 filter (see Build and tests, item 3) and compared failed names against the finalizer's list where the classes overlapped.
3. **Compare the 8 non-train net48 reds** (BranchHost, Bug1000, Bug1001, Bug1002) against the base by name: they were outside the finalizer's filter. Same exception kind, none in code this train touched.
4. **Measure** the speed gain of #1980 or the wrap of the #1881 note; **prove** that normal invert texts measure clear of their own strip (AF's main risk): that needs AutoCAD.
5. **Close, retarget, rename or delete** any PR or branch; touch the held PRs (#1948, #1961, #1963, #1964, #1966, #1968, #1971, #1973, #1872, #1924) or the never PRs (#1841, #1879, #1883, #1817).
6. **Touch** Tim's real settings files, the outbox, or any other worktree. The only folders I made are under `C:\CE_WORK\build\c79c` and `C:\CE_WORK\scratch\c79c`.
7. **Do the Opus finalizer's judgement** on the REDO list, the Kingston-style open questions, or the two verdicts "KEEP-WITH-NOTE": those stay with the finalizer.
