# Train C-79b1 (Civil + Manager) assembly report, Sun 1 Nov 2026, 02:35 to 03:25 Melbourne

Assembler: Sonnet 5.5, headless (CE 01 job "ASSEMBLE TRAIN C-79b1"). Nothing was opened in AutoCAD, nothing installed or deployed, no version commit, no bug marked fixed, no PR closed, retargeted or deleted, no branch deleted.

## FOR TIM

1. **Answer first:** all 18 PRs are merged on a new branch, `claude/rel-20261108a`, head **`f5eebc77efbbaa0357559c6412076b7b5fbf3a21`** (pushed normally, `git ls-remote` reads it back). It sits on the C-79a branch (`claude/rel-20261106a`, head 37dc1e62, after the C-79a finalizer said GO).
2. **What the train is:** the saved record and Undo fixes, the Inspector fixes, the network-redesign warnings, the Edit Pipe fixes, the large-pipe minimum fall, and the pit-label double-click switch.
3. **The pit-label double-click (#1923) went in with its switch OFF.** Its head was still 454e3eab and the default in the code reads OFF, so it follows your 22 Oct ruling. Nothing changes on a pit label until someone turns `doubleClick.pitLabelStopsAttributeEditorFirst` on.
4. **#1972 went in at its fixed head 32fc1a44** (not the old 556b3848).
5. **#1868 (large-pipe minimum fall)** does nothing until you type the 1-in-N figure for 450 mm and larger pipes in Settings.
6. **What is tested:** built and unit-tested only, by machine. Civil: 22,176 tests, 0 failed. Manager: 1,152 tests, 0 failed. **Nobody opened any of this in AutoCAD.**
7. **Three small things I had to fix to get green** (all test or test-list files, no product code changed by me): two old tests that pinned the exact wording of code a PR deliberately changed (#1952 and #1950), one old C-79a test that said the #1923 switch was absent, and the REDO-safe review list needed two renamed lines (item 4 of the technical part). The REDO-safe lines need an Opus look.
8. **Your real files were not touched:** your settings file and the CE_Admin folder read the same before and after (stamps in section 6). The robot was running AutoCAD during the job; the real-settings guard was held back until the robot finished, then it ran and passed.
9. **Next:** the finalizer reads the protected record code (LinkService.Persistence.cs, ProjectDataService.Persistence.cs) and confirms the two renamed REDO-safe lines.

---

## Technical part

### 1. Base and order

1. **Base:** `origin/claude/rel-20261106a` = 37dc1e62. The C-79a finalizer report (`release-v3-colleagues-TRAIN_C79A_FINALIZER_REPORT_2026-10-31.md`) exists and begins "GO at 37dc1e62". Branch `claude/rel-20261108a` was free. Worktree `C:\CE_WORK\build\c79b1`.
2. **Live heads** read with `gh` at 02:37: every one of the 18 matched the list (all OPEN, all drafts), including #1972 = 32fc1a44 and #1923 = 454e3eab. Nothing moved.
3. **Merge order:** exactly the list's, #1922 first, #1868 second, #1923 last. Each merged as its branch (`git merge --no-ff`). For every stacked child the merge-base stat showed only the child's own files (3 to 8 files each, never above 12), so no net-diff fallback was needed.

### 2. Per PR: head, files, conflicts

1. **#1922 B-099** (7a3238a7): 16 files, conflict at the top of REGRESSION_LOG.md (both kept). **Non-test files it touches:** nine files in the OLD Structural copy, `Modules/Structural/Services/` `CommandHistoryService.cs`, `ExcelMTextService.cs`, `HealthCheckService.cs`, `Logger.cs`, `LoggingService.cs`, `StructuralCommandLogger.cs`, `SupportBundleService.cs`, `XclmTxtService.cs` and the new `LogFolderRedirect.cs`. Each routes the log folder through one seam that returns the real folder unchanged when the variable `CE_LOG_DIR_OVERRIDE` is not set (read in `LogFolderRedirect.cs`). It also adds `Modules/TestSupport/RealFolderWatch.cs` and a line in the Civil, Manager and Structural test projects. No Civil or Manager shipped file changes. Finalizer to confirm.
2. **#1868 B-019** (38c3f825): 4 files (expected). Conflicts in UserSettings.cs and REGRESSION_LOG.md, both additive, both kept (the two switch blocks sit one after the other, each with its own summary comment).
3. **#1891 B-071** (4f21fc9d): 7 files. Log conflict only. Adds three REDO-safe baseline lines of its own (`GiveCopiedSourcesOwnTag` transaction).
4. **#1892 B-070** (9545489c): 8 files. Conflicts in UserSettings.cs and the log, both kept. Touches LinkService.Persistence.cs (the protected file).
5. **#1940 B-121** (c55494e0): 12 files. Log conflict only.
6. **#1943 B-121** (62c8f363): 8 files (own files only, the parent #1940 was already in). Log conflict only.
7. **#1945 B-121** (7c31c33c): 7 files. UserSettings.cs and log, both kept.
8. **#1950 B-120** (649df208): 5 files. UserSettings.cs and log, both kept.
9. **#1952 B-118** (6845a095): 6 files. UserSettings.cs and log, both kept. Touches ProjectDataService.Persistence.cs (protected).
10. **#1880 B-059** (3f7ed338): 5 files. Log conflict only. InspectorPaletteService.cs merged automatically.
11. **#1951 B-127** (d34c51b8): 5 files. Log conflict only.
12. **#1953 B-127** (c6a04c9a): 6 files. Log conflict only. **This PR dropped the UTF-8 byte-order mark from UserSettings.cs** (same trap as #1962 in C-79a). I restored it in its own commit 79636fcc; the file now differs from the base by 167 added lines and no removed ones.
13. **#1955 B-127** (f5d89113): 8 files. Log conflict only. LinkService.cs, ProjectDataService.cs and ProjectDataService.Persistence.cs merged automatically.
14. **#1958 B-127** (9d25604c): 6 files. Log conflict only.
15. **#1969 B-119** (1d411b28): 5 files. UserSettings.cs and log, both kept (as the review asked).
16. **#1970 B-119** (b3e76c82): 6 files. UserSettings.cs and log, both kept. PipeEditCommand.Update.cs auto-merged with #1969; LinkService.Persistence.cs auto-merged with #1892. No hunk in either protected file was resolved by me; the persistence file differences are the PR's own.
17. **#1972 B-119** (32fc1a44, the fixed head): 5 files, 2 commits. UserSettings.cs and log, both kept. PipeEditCommand.Update.cs auto-merged. It does **not** touch LinkService.Persistence.cs (checked).
18. **#1923 B-110** (454e3eab, default OFF read in the diff: `PitLabelStopsAttributeEditorFirstDefault = false`): 6 files, 2 commits, clean merge. Touches DoubleClickSettings.cs, CompoundEditModeService.cs, DoubleClickHitTest.cs.

**Result: 18 of 18 merged.** Conflicts were only ever the top of REGRESSION_LOG.md and the neighbours in UserSettings.cs, all purely additive (the UserSettings base side was empty every time). Nothing else conflicted. No PR was stopped.

### 3. Switches and the new test class

1. **New switches (18):** 15 ON (guard a fix) and 3 OFF. Civil only. **No Manager change** (no Manager file in the train; Manager tests ran in full anyway).
2. **OFF (3):** `linking.redesignApplyStopsOnDamagedOutletRoles` (#1940), `linking.redesignApplyStopsOnUnreadableLpd` (#1943), `doubleClick.pitLabelStopsAttributeEditorFirst` (#1923).
3. **ON (15):** `linking.unreadableLinkRecordSkippedOnOpen`, `copiedDownpipeGetsOwnTag`, `redesignApplyNoticesDamagedOutletRoles`, `redesignApplyNoticesUnreadableLpd`, `lpdWarnsWhenOutletsApprovedInAnotherFile`, `twinUpgradeRestoresRouteOnRefusal`, `undoRefreshesUnreadableRecordHold`, `inspectorReadsSavedRecordWhenNotLoaded`, `inspectorShowsRecordWaitingToSave`, `undoRemembersEachDrawingsRecord`, `inspectorUnreadableRecordLoggedOnce`; `pipe.largePipeRedesignReadsMinFall`, `editPipeStoresLevelsWithDecimalPoint`, `editPipeLevelWriteSaysWhenNotSaved`, `cascadeQuestionAfterEditCommits`.
4. **New class** `Modules/Drainage.Tests/Services/C79b1NewSwitchDefaultsTests.cs` (commit 4445c243): pins all 18 through BOTH start-up reads (DeserializeSettings and DeserializeSettingsTolerant) for an empty file, a C-79a-shaped file and a group missing the keys, at each shipped default; typed false changes only itself (whole settings object compared); typed true changes only itself; all 18 typed false at once; a fresh settings object saves each at its default; exactly three ship OFF; the #1923 constant is false. The C-79a class names are not reused.

### 4. Things I changed beyond merging (all in separate commits, easy to revert)

1. **BOM restore on UserSettings.cs** (79636fcc), see 2.12. **BOM scan result:** every changed `.cs` file compared at base and at HEAD (first three bytes). Only UserSettings.cs had lost it (before my restore); after the restore none differs. The other files flagged by the scan were new files that never had one.
2. **REDO-safe baseline: two lines** (24c8e539, `RedoSafeReviewedHooks.baseline.txt`). The hook guard `EveryHookBetweenCommands_IsRedoSafe_OrReviewed` failed on the merged line with two "new" reaches. I read both and judged them renames of an identical reach, then recorded them: (a) `<StartCdEditAsync>d__40` became `d__41` (the compiler renumbered the async state machine after #1923 added code in `CompoundEditModeService.cs`; same hook `OnCdEditIdle`, same `ExecuteInCommandContextAsync`; the old line is replaced); (b) `LinkService.TryStorePipeInverts => StartTransaction` added under `OnCommandEnded` (#1970 moved the body of `StorePipeInverts` into `TryStorePipeInverts` and made the old one forward to it: same transaction, same callers, only the name is new; the old `StorePipeInverts` line is kept). **This is a REDO-safety review by Sonnet, so the Opus finalizer must confirm it** (model routing rule). If it disagrees, revert 24c8e539 and the guard goes red.
3. **C-79a test made true** (2363cc1a): `C79aNewSwitchDefaultsTests.ThePitLabelDoubleClickSwitchOf1923_IsNotInThisTrain` asserted the #1923 switch property does not exist. With #1923 in, it failed. It now says: absent, or where present it must be OFF through both reads. It still protects "ships OFF".
4. **Two source-shape tests follow the merged PRs** (f5eebc77), intent unchanged: `Bug192LightReadTests.ProjectRecordReRead_AfterUndo_UsesAnOpenCloseRead...` now expects the `TryLoadFromDrawingLightDetailed(...)` call that #1952 uses, and I added a check that the detailed reader is `StartOpenCloseTransaction` (a stronger pin, not a weaker one); `LinkServiceSpeedRound4Tests.UpgradeOnePipeToObject_RecordsPipes...` now expects the extra `out rootBefore` argument that #1950 adds. Neither PR updated the pin in its own branch.
5. **Placeholder file** `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx` created empty in the worktree (git-ignored; Civil net10 build needs it to copy). Not committed.

### 5. Build and tests

All with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, BelowNormal, one dotnet command at a time, TEMP, TMP, `CE_LOG_DIR_OVERRIDE` and `CE_STRUC_SUITE_APPDATA_ROOT` set to fresh folders under `C:\CE_WORK\scratch\c79b1\run-*` for every run. C: free was 58 GB at every start.

1. **Builds (Release):** Civil net10 0 errors (the first try failed only for the missing placeholder, item 4.5, and passed after it); Civil net48 0 errors; Manager net10 0 errors; Manager net48 0 errors.
2. **Focused Civil net10 (after all my commits):** 524 tests, 524 passed, 0 failed, 0 skipped. Covers every changed test class of the 18 PRs, C77, C78, C79a (including the finalizer guards) and C79b1 defaults, TestHygieneAppDataGuardTests, Bug351bPlanMarkerTests (the BOM test) and the REDO-safe guards (`RedoSafe*`). The first focused run had 2 failures (items 4.2 and 4.3), fixed.
3. **Full Civil net10 Release, after the last commit (f5eebc77):** total 22,176; passed 22,144; failed 0; skipped 32. **This run excluded the class `ZzRealSettingsFileGuard`** because the robot's `settings_guard.json` still showed an entry. An earlier full run (before the two pin fixes, same code otherwise) had 2 failures, the two pins of item 4.4; I did not claim it.
4. **Real-settings guard (`ZzRealSettingsFileGuardTests`):** `settings_guard.json` showed one entry (robot's change of CD_Settings.json, owner Claude-driverv3) at 02:39, 03:01 and 03:10; the file was absent at 03:19, so I ran the class then: 2 tests, 2 passed (the real Civil settings file is unchanged by the run; the watch reports a created, deleted, longer or rewritten file). Not weakened.
5. **Full Manager net10 Release:** total 1,152; passed 1,150; failed 0; skipped 2 (Manager tests ran after the last Civil-side commit; no Manager source changed in the train).
6. **Not run:** net48 test lanes (they do not load, as before), Structural tests (not in this train; the old Structural copy changed only through #1922 and I did not run its tests), nothing in AutoCAD.
7. **REDO-sensitive hit list** (added lines in product code containing CommandWillStart, CommandEnded, DocumentActivated, Veto, Idle, StartTransaction, SetSystemVariable, SendStringToExecute, LockDocument, File.WriteAllText): two. `LinkService.CopiedSourceOwnTag.cs` (#1891) `StartTransaction`, and `LinkService.PipeObjectUpgrade.cs` (#1950) `StartTransaction` (the main-line restore). Each already has its reviewed baseline line from its own PR, and the guard passes. The two rename lines of item 4.2 are the only baseline changes made by me.

### 6. Isolation stamps (Tim's real files)

1. **Before (02:46):** CD_Settings.json 2026-10-04 08:22:30, 15,270 bytes, SHA256 ACD64E79A33B...; CS_Settings.json 2026-03-31 13:18:00, 351,713 bytes, SHA256 622A246F7D3B...; CE_Admin outbox folder time 2026-07-03 12:46:34, 28,329 files, newest 02:45:16.
2. **After (03:20):** CD_Settings.json 2026-10-04 08:22:30, 15,270 bytes, ACD64E79A33B (**unchanged**); CS_Settings.json unchanged; CE_Admin folder time unchanged, 28,361 files, newest 03:19:54. The outbox grew by 32 files over the 34 minutes, as it did during the C-79a run; the robot was running AutoCAD on this PC at the time (settings guard entries), and my runs had their log and temp folders redirected away from it. I did not prove which process wrote the 32 files.
3. CD_Settings.json is the robot's write-back copy of the 4 Oct file, so "unchanged" here means the file is back to the 4 Oct bytes and date at both stamps; at 02:32 and 02:56 the robot had it changed for a few minutes (guard entries), which is the robot's doing, not a test's.

### 7. Shared paths and the smoke case each needs

Class asked of the finalizer: area plus N91 (UserSettings.cs additive) plus the record/Undo smoke cases; the protected-file code needs the finalizer's full read. The file list is `C:\CE_PLAN\areas\TRAIN_C79B1_CHANGED_FILES.txt` (85 paths against 37dc1e62).

1. **`Modules/Drainage/Models/UserSettings.cs`** (18 new switches, additive; BOM kept): N91 start-up smoke; read back that the file loads with the new keys missing.
2. **`LinkService.cs`, `LinkService.Cache.cs`, `LinkService.Persistence.cs` (protected), `LinkService.Utilities.cs`, `LinkService.CopiedSourceOwnTag.cs`, `LinkService.PipeObjectUpgrade.cs`:** record/Undo smoke (move a pit, Undo, pit list intact); copy a downpipe and read its tag; twin pipe upgrade refused case.
3. **`ProjectDataService.cs`, `ProjectDataService.Persistence.cs` (protected), `ProjectDataService.KeptRecords.cs`:** save, close, reopen and Undo-in-A/pick-in-B record smoke.
4. **`InspectorPaletteService.cs`, `InspectorProjectSourceRule.cs`, `InspectorUnreadableRecordMemory.cs`, `CdCheckProjectSourceRule.cs`:** Inspector smoke on a drawing with no record loaded; CDCHECK shows the same record.
5. **`PipeEditCommand.Update.cs`:** Edit Pipe with a typed level (comma-decimal PC), a write that cannot be saved, and the downstream question after accepting.
6. **`CompoundEditModeService.cs`, `DoubleClickSettings.cs`, `DoubleClickHitTest.cs`:** double-click on a pit label with the switch OFF (nothing changes) and, if Codex looks, ON.
7. **`NetworkRedesign*.cs`, `LpdService.cs`, `CivilDesignCommand.cs`:** redesign Apply with a damaged outlet-role record and with an unreadable LPD (one warning, Apply carries on); CDDESIGN with outlets approved under another path.
8. **No CE_SHARED, installer, loader, SettingsService.cs, colleague-defaults.json or Manager change.** The OLD Structural copy has 9 changed files via #1922 (log-folder seam only).

### 8. Not in this report's scope and carried

1. #1841 was never merged (already in the line); #1868 sat on its branch with 4 files as expected.
2. The C-79b2 list, the "over the limit" PRs and the held PRs were not touched.

### 9. What I did NOT do

1. Did not open AutoCAD, install, deploy, or commit a version.
2. Did not run the Structural tests, the net48 test lanes, or any robot case.
3. Did not run the real-settings guard during the robot's runs (held until `settings_guard.json` was absent), and did not touch Tim's real files.
4. Did not review the protected persistence code beyond checking the merges were the PRs' own hunks; the finalizer does that.
5. Did not add a REGRESSION_LOG entry for my own test and baseline commits (their reasons are in the commit messages and this report); the finalizer's log entry can carry them.
6. Did not find which process wrote the 32 new CE_Admin outbox files.
7. Did not mark any bug fixed; every bug of the train stays open.
