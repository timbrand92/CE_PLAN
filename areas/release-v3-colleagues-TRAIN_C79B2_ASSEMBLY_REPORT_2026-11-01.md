# Train C-79b2 (Civil) assembly report, Sun 1 Nov 2026, first job 05:14 to 05:43, resumed job 06:54 to 07:35 Melbourne

Assembler: Sonnet 5.5, headless (CE 01, register B-143 resume). Nothing was opened in AutoCAD, nothing installed or deployed, no version commit, no bug marked fixed, no PR closed, retargeted or deleted, no branch deleted.

## FOR TIM

1. **Answer first:** all 16 PRs are merged on a new branch, `claude/rel-20261110a`, head **`c01788a723e3a103453f9c25102be60a14da66dc`**, pushed normally and read back with `git ls-remote`. It sits on the C-79b1 GO head `bab2dbf8` (`claude/rel-20261108a`, which had not moved).
2. **Plain statement about the first job:** it ended its turn early, with the build still running and nothing tested, pushed or reported. This resumed job re-checked the worktree (clean, head 2869183a, 39 commits ahead as expected, branch not yet on GitHub), then ran every test and pushed.
3. **Tested by machine only:** Civil 22,493 tests, 0 failed (32 skipped as before). Manager 1,152 tests, 0 failed. **Nobody opened any of this in AutoCAD.**
4. **One small fix I had to make:** a house test that checks every new setting has a written "Default:" line failed on two settings of #1939 (the survey-layer word lists). I added the line and an explicit "no words ship" start value to both. It changes nothing on screen.
5. **Two shipped figures a drafter will notice:**
   1. **Maximum pipe speed (#1960):** a uPVC connection pipe in auto-design and the Edit Pipe grade strip now use 3.0 m/s (was 6.0 for every material). Metal reads 4.0 (was 6.0). Concrete stays 6.0. A high-flow uPVC connection pipe can come out one size larger. The figures are the Settings table you already have; **no saved value of any user moves.** CPAA's 8 m/s for precast concrete against the house 6.0 is still your question and ships as the PR says (not changed).
   2. **Roof-and-paved C (#1965):** CDCALC Pump system and Rational tabs now read the one Settings figure. At the shipped 0.9 nothing moves. If an office has typed another figure in Settings, those two tabs now follow it. **No saved value moves.**
6. **Your real files were not touched:** your settings file, the structural settings and the CE_Admin outbox read as before (section 6).
7. **Next:** the Opus finalizer. Needs your answer: none from me.

---

## Technical part

### 1. State re-checked in the resumed job

1. `git status` clean; local head 2869183a before my fix; `git log origin/claude/rel-20261108a..HEAD` showed the 16 merges plus the assembler's own 007fc8fc, 2490fd60, d35d30eb, 2869183a.
2. `git ls-remote`: rel-20261108a = bab2dbf8 (not moved, so nothing to merge in); rel-20261110a did not exist, now it does.
3. The build of 05:43 (0 errors) was newer than the last commit's code; I still rebuilt Civil net10 tests and Civil net48 after my fix.
4. **Heads:** the second parent of each merge matches the list exactly (#1946 8ef5e68e, #1944 e5bccf42, #1960 02d582e3, #1965 2f7549e6, #1967 ade56d0d, #1874 1b8b4af1, #1954 da8e8f68, #1956 8b7ade95, #1897 b73618c3, #1920 aba41924, #1919 d12f06d7, #1927 1732eb32, #1938 87104a99, #1939 209cc31d, #1974 3993061a; #1937 branch tip 99f4b09e). I read these from git. **I did not re-read the PR state on GitHub** (the `gh` tool is not on this job's path), so "still OPEN" is the first job's reading.
5. **Pre-reviews:** the Opus review AD (areas/OPUS_PREREVIEW_AD_1965_GROUP_01NOV.md) says KEEP-WITH-NOTE for #1965, #1967 and #1974 (none CHANGE-NEEDED). I did not re-read the earlier R, S, T, X, Y, Z, AB reviews; the first job applied them.

### 2. Per PR: how it was merged

1. **By branch (`git merge --no-ff`), 15 PRs:** #1946, #1944, #1960, #1965, #1967, #1874, #1954, #1956, #1897, #1920, #1919, #1927, #1938, #1939, #1974.
2. **#1874, #1954, #1956 merge-base check:** #1874 merged as a branch, 3 own commits, 14 files (its own 14; the stat is the merge-base to branch tip, not the GitHub list). #1954 1 commit 7 files, #1956 1 commit 9 files. None carried a foreign commit, so no net diff was needed.
3. **Other stacked children:** #1920 (on #1897) 1 commit 10 files; #1927 (on #1919) 1 commit 6 files; #1939 with #1938 5 files each. All under 40 files.
4. **#1897** carries a merge of `origin/claude/rel-20261102a` inside its own branch; those commits were already in the line, so the merge added only its own 3 commits and 15 files.
5. **#1937 (B-115): NET DIFF ONLY** (commit f7ff4515), 6 files (PitScheduleQaService.cs, PitScheduleStatusService.cs, UserSettings.cs, a test, a test edit, the log). Its branch was never merged.
6. Conflicts were only at the top of REGRESSION_LOG.md and neighbouring switches in UserSettings.cs, both sides kept (the first job's finding). Nothing else conflicted.

### 3. The #1937 Xref statement

#1937 reads Xref load state (`PitScheduleXrefSourceInfo`, `PitScheduleXrefLoadState.Loaded`) to choose a wording and a status. **No added line opens an object for write, takes a lock, erases, commits, or writes to an Xref, a locked layer or a REFEDIT object** (I read every added line of the net diff in Services).

### 4. REDO-sensitive hit list

I scanned the added lines of every non-test file in the train (CommandWillStart, CommandEnded, DocumentActivated, Veto, Idle, StartTransaction, SetSystemVariable, SendStringToExecute, LockDocument, File.WriteAllText). **Zero hits.** No RedoSafe baseline file changed in this train. The REDO-safe guard classes (`RedoSafe*`) passed. Opus finalizer to judge as usual.

### 5. New switches (17, all ON) and the new test class

All Civil, all ship ON, all pinned by `Modules/Drainage.Tests/Services/C79b2NewSwitchDefaultsTests.cs` (commit 2490fd60) through both start-up reads (DeserializeSettings and DeserializeSettingsTolerant) for an empty file, a C-79b1-shaped file and a group missing the keys, plus "typed false changes only itself" and "fresh object saves each at its default":

1. `options.labelSizesReadDrawingUnits` (#1946)
2. `linking.recoveryPositionMatchReadsDrawingUnits` (#1944)
3. `pipeSpeedChecks.sizingReadsMaterialTable` (#1960)
4. `detention.pumpAndRationalUseHardGroundC` (#1965)
5. `pipe.gradeWarningFiguresNeverMatch` (#1967)
6. `detention.rainwaterReuseBoxes` (#1874)
7. `detention.reuseMinimumUsesReuseShare` (#1954)
8. `detention.designDraftKeepsUnknownFields` (#1956)
9. `checks.screensShareOneCover` (#1897)
10. `checks.screensMeasureCoverToPipeTop` (#1920)
11. `pipe.gradeMismatchIsWarningLine`, 12. `pipe.steeperThanGradeWarns`, 13. `pipe.flatterThanMinimumWarnsInDefault` (#1919, three switches)
14. `pipe.recallLastNewUpstreamUsesStandardGrade` (#1927)
15. `linking.pitScheduleRecreatedSourceWording` (#1937)
16. `survey.longSectionBoundaryFollowsCurves` (#1938)
17. `survey.longSectionSurveyLevelsOnSurveyLayersOnly` (#1939)

Plus the two layer-word lists of #1939, which ship empty (blank = the shipped words). **No Manager file changed** (checked: the diff has no Modules/Manager path); Manager tests ran in full anyway.

### 6. Changed shipped figures (#1960 and #1965)

1. **#1960 maximum speed, connection pipe and Edit Pipe grade strip:** uPVC 6.0 to 3.0 m/s; metal 6.0 to 4.0; concrete 6.0 to 6.0 (no change); unknown material 6.0 to 6.0. Source: the Settings table `designStandards.scourVelocityByMaterial` ("house rule"). Switch OFF gives the old 6.0 for every material. **Existing user's saved value:** the table values saved in a user's file are not changed; what moves is where two screens read them, by default (switch missing = ON).
2. **#1965 roof-and-paved C, Pump system weighted C and the Rational row start:** old fixed 0.9, new = Settings `hardGroundRunoffC` (shipped 0.9). At 0.9 no change. Blank, zero, negative, above 1 or a non-number falls back to 0.9. **Saved value does not move;** a user who typed another figure now sees the two tabs follow it.
3. Not changed (the PR says so, Tim's call): Detention Design 0.85, WSUD 0.85, Charged system 0.9.

### 7. What I changed beyond merging (all separate commits)

1. 007fc8fc (first job): restored the summary opener the #1919 merge of UserSettings.cs left off (comment only).
2. 2490fd60 (first job): the new test class.
3. d35d30eb (first job): **UTF-8 byte-order mark restored on SettingsSizingStandards.cs**, dropped by #1960's branch (no text change).
4. 2869183a (first job): change-log entry for the assembly and blank lines between run-together entries.
5. **c01788a7 (this job): UserSettings.cs, #1939's `LongSectionSurveyLevelLayerWords` and `LongSectionNotSurveyLayerWords`** got "Default: none ..." in their notes and an explicit `= null`. Without it `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault` fails (the focused run showed 1 failed of 2,993; #1939's own branch predates the guard). A null list is what the property already held. BOM on UserSettings.cs kept (checked).

### 8. Byte-order-mark scan

Every changed file (80, of which 78 `.cs`) compared first three bytes at base bab2dbf8 and HEAD (small .ps1, `C:\CE_WORK\scratch\c79b2\bomscan.ps1`, run again after the last commit). **Lost a mark: 0. Gained: 0.** 26 files are new and carry none (as the base's new files do). The one loss (SettingsSizingStandards.cs) is fixed by d35d30eb.

### 9. Build and tests

All with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, BelowNormal, my own commands one at a time, TEMP, TMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT under `C:\CE_WORK\scratch\c79b2\t_*`. C: free 54 GB at every start.
1. **Builds (Release):** whole solution 0 errors (first job, 05:43). After c01788a7: Civil tests net10 0 errors; Civil product net48 0 errors. Manager test project: built and ran inside its test command (I did not read a separate error count).
2. **Focused Civil net10 (after c01788a7):** total 2,993; passed 2,990; failed 0; skipped 3. Filter = every class of the 16 PRs plus C77/C78/C79a/C79b1/C79b2 defaults and finalizer guards, TestHygieneAppDataGuardTests, RedoSafe*, Bug351bPlanMarkerTests and ZzRealSettingsFileGuard (`train_classes.txt` in the scratch folder). **The first focused run (before c01788a7) had 1 failure** (item 7.5), fixed and re-run. I did not count tests per class.
3. **ZzRealSettingsFileGuard:** `C:\Lisp Files\_ACAD_DRIVER\settings_guard.json` was **absent** at 06:54 (before the focused run), at 07:03 (before the full run) and at 07:17 (after it), so the guard ran in the focused set and in the full run, and passed. I did not read the file mid-run.
4. **Full Civil net10 Release, after the last code commit (c01788a7):** total 22,493; passed 22,461; failed 0; skipped 32. (Report-only commits after that: none to the repo.)
5. **Full Manager net10 Release:** total 1,152; passed 1,150; failed 0; skipped 2.
6. **Not run:** net48 test lanes (do not load, as before), Structural tests, any robot case, anything in AutoCAD.

### 10. Isolation stamps (Tim's real files)

1. **First job, before (05:17):** CD_Settings.json 15,314 bytes, 01 Nov 05:15:31 (the robot's changed copy at that moment), CS_Settings.json (TIM_CE_CADTOOLS) 351,713 bytes 31 Mar 13:18:00 hash 622A246F7D3B, CS_Settings.json (CE_STRUC_SUITE) 35,613 bytes 30 Oct 19:54:14 hash D604CE689671, outbox folder time 28 Apr 11:36:51, **28,483 files**, newest 05:17:27. AutoCAD (robot) running since 05:15.
2. **Resumed job, before (07:10):** CD_Settings.json 15,270 bytes, 04 Oct 08:22:30, hash ACD64E79A33B (the 4 Oct original); CS_Settings.json 351,713 bytes 31 Mar 13:18:00, 622A246F7D3B; CE_STRUC_SUITE CS_Settings.json 35,613, 30 Oct 19:54:14, D604CE689671.
3. **After (07:26 to 07:31):** all three settings files **identical** to item 2 (size, date, hash). The CE_Admin outbox folder time is unchanged (28 Apr 11:36:51); file count **28,614** at 07:31, newest 07:31, against 28,483 at 05:17: +131 files in 2 h 14 min. The robot's AutoCAD was running on this PC during the job; my runs had their log and temp folders redirected under C:\CE_WORK. I did not prove which process wrote the 131 files.
4. I did not take a fresh outbox count at 07:10, so the outbox growth is measured against the first job's 05:17 reading only.

### 11. Shared paths and the smoke case each needs

The full list is `C:\CE_PLAN\areas\TRAIN_C79B2_CHANGED_FILES.txt` (80 paths against bab2dbf8). Re-test class: area plus N91, S1 for #1960 and #1965, the cover screens (#1897, #1920: Inspector, Civil Hub, repair check) and the Grade mismatch window (#1919, #1927) each their own tool case.

1. **UserSettings.cs** (17 new switches, additive, BOM kept; 168 lines added, 0 removed against the C-79b1 head, my fix included): N91.
2. **SettingsSizingStandards.cs, CdCommand.cs, CdCommand.Grade.cs, CdCommand.GradeSuggestion.cs, PipeEditCommand.GradeSuggestion.cs, AutoDesignService.cs:** S1 and the Edit Pipe grade strip and Grade mismatch window.
3. **ProjectDataService.cs, ProjectDataService.Recovery.cs, ProjectDataRecoveryGuardService.cs (#1944):** save, close, reopen in a non-metre drawing.
4. **InspectorPaletteService.cs (#1920):** Inspector cover figure.
5. **PumpSizingService.cs, RationalMethodViewModel.cs (#1965):** S1, CDCALC tabs.
6. **No CE_SHARED, Shared, installer, loader, SettingsService.cs, colleague-defaults.json or Manager change.**

### 12. What I did NOT do

1. Did not open AutoCAD, install, deploy, run any robot case or commit a version.
2. Did not re-read PR state on GitHub (no `gh` here), and did not re-read the earlier pre-reviews (only the AD review).
3. Did not run Structural tests, net48 test lanes or count tests per class.
4. Did not review the protected persistence code (this train does not touch LinkService.Persistence.cs or ProjectDataService.Persistence.cs; ProjectDataService.cs and .Recovery.cs are touched by #1944).
5. Did not add a REGRESSION_LOG entry for c01788a7 (reason is in its commit message and this report).
6. Did not find which process wrote the 131 new outbox files.
7. Did not mark any bug fixed; every bug of the train stays open.
