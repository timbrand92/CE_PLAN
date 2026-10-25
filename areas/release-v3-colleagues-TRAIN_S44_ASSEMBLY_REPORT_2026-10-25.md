# TRAIN S-44 (Structural) assembly report, 25 Oct 2026

Branch `claude/rel-20261025s`, pushed. Built and unit-tested only. Nobody has opened this train in AutoCAD. I installed nothing, ran no accoreconsole, changed no version field, closed no PR, deleted no branch, changed no PR base, marked no bug FIXED, did not edit DESK_LOG.md. Sun 25 Oct 2026, about 14:00 to 15:10 Melbourne (PC clock). Sonnet 5.5, Team, headless.

## ANSWER FIRST

1. **Branch `claude/rel-20261025s`, head `da852df3f58cc5ece891712eb7a258790e834c4d`**, pushed (local equals origin, checked). Base `origin/claude/rel-20261024s` at `4af3f37d7da3684c6d7179a65633aee40372c5a0` (installed Structural 1.0.123): `git ls-remote` gave exactly that tip. The name `claude/rel-20261025s` was free.
2. **32 PRs merged, 0 aborted.** Plain `git merge --no-ff`, one merge commit each, no squash, no rebase, no cherry-pick. 22 are the PRs in the brief (Group 1 items 1 to 10, Group 3 items 12 to 23). **10 more are my additions under "ALSO CHECK"** (see item 5). Before each merge I re-read the live head with gh and compared it with the fetched head: every head equalled the head in the brief or in the review. Nothing moved, no extra commits to re-read. The numstat gate (staged files against `gh pr view --json files`) passed on all 32: no PR dragged in a file outside its own list, and a second check after all merges (each merge's own diff against its PR file list, log excluded) was identical for all 32.
3. **Commits after the merges (mine, both re-pins, both with a `REGRESSION_LOG.md` entry):**
   1. `edee80ca` re-pins the Plugin.cs fingerprint in `Stage3ConnectedDesignBoundaryTests` (59F6B35C to 3721C26D) because #1566 changed `Plugin.cs`.
   2. `da852df3` re-pins the central register's fingerprint of Structural's command list in `Assets/Config/ce-tool-register.json` (94FC64FA to 30A0EEED) because #1742 reworded Help text in `Modules/Structural/Assets/Config/command-registry.json`. Row count and the 395 drift did not move.
4. **Left out, with reasons:**
   1. **#1737** (BUG-1041): live head is still `4ae66b1b`, the head the review said needs fixes 1 and 2. Left out as told.
   2. **#1731** (live head `2878e6c2` differs from the reviewed `115a5c19`, nobody re-reviewed), **#1560, #1572, #1457, #1212, #1245, #1592** (MERGE-WITH-FIXES in older reviews, no fixed head recorded), **#1045, #1049, #1052, #1055 and Codex group 10 (#1008, #1011, #1016 and others)** (the plan train), **#1600, #1602** (HOLD), **#1705, #1726** (not reviewed), **#397** (removes shipped code), every Civil and Manager PR.
   3. **Also seen and not added:** #1584, #1587, #1579, #1590, #1596, #1598, #1606, #1608, #1615 (MERGE-WITH-FIXES in review batches B8, B9, B10, no fixed head recorded). #1583 and #1580 are Civil. #1533 is already in the base.
5. **My 10 additions, each with its review and verdict.** The brief's list left out ten Structural PRs that Opus review batches gave a plain **MERGE, train S-44**, and whose live head equalled the reviewed head (read live from `gh pr list`). I added them, in this order, each through the same numstat gate: **#1574** (BUG-983, `f41f68dd`), **#1575** (BUG-985, `bd37c02a`), **#1577** (BUG-881, `8564a300`), **#1581** (BUG-986, `a99df168`), **#1582** (BUG-1016, `555bd7ef`), **#1585** (BUG-1015, `5a8feaec`), all in `REVIEW_PILE_B8_24OCT.md`; **#1589** (BUG-974, `cecf3506`), **#1603** (BUG-950, `b86a2f01`), **#1604** (BUG-880, `c857bdf9`) in `REVIEW_PILE_B9_24OCT.md`; **#1605** (BUG-610 checklist Undo, `eb7e41e0`, first in its stack) in `REVIEW_PILE_B10_24OCT.md`. **If the finalizer or Tim does not want them, drop merges `a25bd244` to `201392bd` (the last ten merge commits before my two re-pins).** None of the 32 has had an Opus finalizer yet: the finalizer must read all 32.
6. **Which merged PRs touch what:**
   1. **Shared/, Installer/, CE.Host, Manager, `ce-tool-register.json` source: none.** `ce-tool-register.json` changed only by my re-pin commit `da852df3` (one fingerprint, item 3.2).
   2. **Civil (`Modules/Drainage*`): one file, a test.** **#1766** edits `Modules/Drainage.Tests/Services/TeardownCrashGuardTests.cs` (+4 -68), as in its own file list. The review said "Structural train only"; this is a Civil test file in the Structural train. It does not change any Civil product code. The finalizer should confirm that is acceptable.
   3. **Plugin.cs: changed by #1566 only** (see item 8). **PackageContents.xml: unchanged.** **Command register (`command-registry.json`): #1742 changed Help text only** (2 lines, no command added or removed).
   4. Everything else is under `Modules/Structural*`, `Modules/Structural.Tests`, plus `REGRESSION_LOG.md`.
7. **Settings values added, all default ON in the merged code (`git diff 4af3f37d..HEAD` over `UserSettings.cs` and `SettingsService*`):**
   1. `Options.ColumnBarsAtRealSize` (#1729) true.
   2. `Options.HatchChangeSkipsRefusedAndChangesTheRest` (#1746) true.
   3. `Options.InspectRunsOnReadOnlyDrawing` (#1749) true.
   4. `Options.TimberQuantityAnyNumber` (#1732) true.
   5. `UnknownWhenTypesDiffer` (#1603, BUG-950) true. It has no settings-label row.
   6. Each is a plain property with `= true` as its initial value, so an old settings file without the key loads as true (Newtonsoft keeps the initial value when the key is missing). I did not run a separate old-file test for each; the PRs' own tests did (not re-checked one by one). #1744, #1739 and #1386 and #1464 change Settings window words and layout only, not values (item 12). #1460 changes how settings are saved, not what they are.
8. **Redo-killer scan** (every added line in the train diff, log excluded, tests excluded for the scan of product code): **no** `SetCurrentView`, `SetSystemVariable`, `SendStringToExecute` or `Regen` added; **no** event subscription, `+=` handler, Idle, timer, Document or Application event, window handler (`Loaded`, `SizeChanged`, `Closing`) added. Hits, all reviewed:
   1. **#1563** reads `editor.CurrentUserCoordinateSystem` in `SbeamCommandRunner.cs` lines 174, 201 and 202 and `SbeamEditCommandRunner.cs` lines 402, 421 and 422, and carries each picked point to World (`ToWorldPoint2`). **It only reads the UCS.** It never changes it.
   2. **#1736** (`LevelMarkCommands.cs` line 287) reads the system variable `REFEDITNAME` with `GetSystemVariable`. It is a read. The PR adds a locked-layer check and a stop during REFEDIT for FFL, RL, SSL, NGL and LM (+51 lines in that one file); it touches no other REFEDIT code.
   3. **#1566** (`Plugin.cs` line 456) removes the fixed constant `RuntimeMutexName` and creates the start-up guard (a `Mutex`) with a name that includes the AutoCAD process id (new `PluginRuntimeMutexName.For`). It adds no hook or event. It changes only the start-up guard name so a second AutoCAD is not blocked.
   4. **#1460** adds no hook. On the start-up path it saves a text copy of the settings after load (`_routineBaselineJson`). On the save path a routine save reads the file on disk, merges in what a second AutoCAD saved (`SettingsRoutineMerge.Apply`) and writes under the existing save lock. **Real finding: the new code trips a source guard (item 9.2).**
   5. **#1585** (`FoundationService.cs` lines 3827 to 3837) adds a short transaction inside the command that puts the picked line back on its own layer, or erases a line CE just drew, when RIB or REB is refused. Nothing is unlocked. This is a write, inside the command's own Undo group (per Opus's review).
9. **Build and tests (Release, every command `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, foreground or foreground-polled):**
   1. **Whole solution: 0 errors, 927 warnings** (the same 927 as S-43) after the first full build. After my second commit, an incremental rebuild gave 0 errors, 931 warnings.
   2. **Structural net10 by class chunks (464 classes, 16 chunks of 30, plus 7 nested-class tests; `SbeamEditAutoCadEvidenceReaderTests` left out): 5,918 passed, 1 failed**, 0 skipped. S-43 gave 5,725 and 0 failed: **+193 passed.** The one red is **`ProductionSource_DoesNotCallHostIncompatibleJTokenFormattingOverload`** (`StructuralNewtonsoftFormattingGuardTests`): `Modules/Structural/Services/SettingsRoutineMerge.cs` line 28 (from **#1460**) calls `disk.ToString(Formatting.Indented)` on a `JObject`. The guard says AutoCAD's own Newtonsoft can lack that overload, and names the fix: `JsonConvert.SerializeObject(token, Formatting.Indented)`. **This is a real red, not a fingerprint. I did not change the product code.** It fails on net48 too. It cannot fail on the base (the file does not exist there). **#1460 as merged risks a crash on the routine settings save path in AutoCAD; the finalizer should either fix that one line or drop #1460.**
   3. **Structural net48 (same chunks): 5,155 passed, 54 failed, 704 not run (5,913).** S-43: 4,976 passed, 39 failed, 704 not run. **I could not build the base `4af3f37d` for a by-name comparison, because C: fell below the 12 GB stop line (item 11), and I did not have S-43's list of 39 names.** What I can say from the names, not from a base run: of the 54 failing entries, **40** carry names that no merged PR added (they are the standing AutoCAD-stub and reference-drift kind, e.g. `SegmentsIntersect2D_*`, `ZcOutline_*`, `ManagedPublicApiAndReferences_MatchAcceptedBase`) and include the JToken guard red above, so 39 + 1; **14** are tests added by merged PRs that fail with `System.InvalidProgramException` in `Point3d.get_X` or `Matrix3d.get_Identity` (the same reference-stub error, for example `SbeamUcsPickTests.WorldUcs_ChangesNothing`, `BeamExtendArcBoundaryTests` chord tests, the support-neighbour tests). **The count 54 is not 39: the finalizer must build the base and compare names.** S-43's first assembly run also showed 54 (extra `Grades_*`, `Sbeam_*`, `AuxiliaryPalettes_*` from a bad build state); mine has no `Grades_*` or `Sbeam_*` rows, but it has `AuxiliaryPalettes_RenderEachTaskPage` x2. I could not rebuild clean for a second look, because of the disk.
   4. **DesignCore: 2,207 per lane** (net48, net8, net10), 2,202 passed, 5 failed per lane, exactly the five names (`HostedAndStandaloneModernOutputs_AreIsolatedAndCompileOppositeRuntimeContracts`, `LoadOrder_CannotBindStandaloneStructuralToCeShared` x2, `StandaloneReleaseLanes_HaveNoCeSharedDependencyOrPayload`, `StandaloneReleaseLanes_KeepCommandClassesAndSbeam_LeaveCeVersionToManager`). Total rose 2,200 to 2,207: new DesignCore tests from the merged PRs (#1589, #1603, #1604 and others).
   5. **CE.CommandTruth.Tests: 22 of 23.** First run was 21 of 23: the extra red was the central register fingerprint (item 3.2); re-pinned, then 22 of 23. The one standing red is `Structural_KnownRegistryDriftRemainsPinnedBacklog`: expects 301, finds **395**. **395 did not move** (no command added or removed).
   6. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
   7. **Settings and window guards by name, net10, all passed:** `StructuralSettingsFitAt150Tests` 1 of 1, `IssuePreviewSettingsRowTests` 5 of 5, `AutoCadWindowHostScrollTests` 3 of 3, `AutoCadWindowHostMathTests` 9 of 9, `AutoCadWindowHostGuardTests` 2 of 2, `UncitedEngineeringTablesGuardTests` 3 of 3. Also `Bug752SettingsLongPathTests` 2 of 2 (#1386), `Bug841BoxLabelTests` 8 of 8 and `Bug841SettingsNumberTextTests` 16 of 16 (#1464). **The Settings-fit at 150 per cent still passes with the Settings window changes of #1744, #1739, #1386 and #1464 in.** That is a test, not a look at the window.
   8. **New focused tests of every merged PR: 190 of 190 passed** on net10 (34 new test classes in 33 new test files; names below in section 3). The new tests of #1766 (`FoundationMonitorDetachGuardTests`) are among them.
   9. **Not run:** Structural net8 tests (built only), the Sbeam evidence class (hangs), Drainage tests (so the changed Civil test file of #1766 was not run), Manager, Installer.Tests, anything in AutoCAD or accoreconsole, the official release build (the payload builder's job).
10. **Pictures:** test runs regenerated about 75 window PNGs under `docs/image/V3_WINDOWS` and wrote 8 new ones (`structural-settings-*-saving-and-fault-reports.png` and similar, the tab is now "Saving and fault reports" after #1739). I discarded the changes and never committed any. **The committed PNG names for that tab (`...saving-and-diagnostics.png`) are now stale: for the finalizer or the window lane.**
11. **Disk and the build lock:** C: had 13.6 GB at the start, 11 GB after I created a second worktree for the base build, and 9.3 GB then 7.7 GB at the end (other jobs share this disk). The brief's stop line is 12 GB. **I stopped starting builds at that point**: I removed the base worktree at once and ran only tests from the existing build afterwards (no new build, and the rebuild after my second commit did not happen). So **the last tests ran on a build made after my first re-pin commit `edee80ca`, not after the final commit `da852df3`** (the last commit changes `ce-tool-register.json` and the log only, which the CommandTruth test reads from the repository at run time; it was run after that commit and gave 22 of 23). The build lock: `C:\CE_PLAN\desk_jobs\build.lock` was absent when I started and I took it for each command, then removed it when the command ended (it is not left behind).
12. **AutoCAD and settings files:** `acad.exe` was open during my runs (a robot pass, not mine; I never touched it): a process started 13:49 was there at 13:59, and a process started 15:00 was there at 15:04. Tim's four settings files, first 8 hex of SHA-256: at my start (13:59) **`TIM_CE_CADTOOLS\CD_Settings.json` read 15,302 bytes, written 13:58 today, `9d27b04c`**; at my end (15:04) it read **15,270 bytes, written 4 Oct 2026 08:22, `acd64e7` (the same size and hash as the S-43 reports)**. So that file was changed and changed back by something else (a robot AutoCAD job) around my start; I wrote nothing to it and will not guess more. The other three are unchanged at both times: `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`, `CE_STRUC_SUITE\CS_Settings.json` 35,259 `2972ce70`, `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
13. **Do not mark FIXED.** Every bug here needs a robot PASS plus a Codex PASS in AutoCAD.
14. **For the finalizer (Opus), in order of weight:**
    1. **#1460 JToken guard red** (9.2): fix one line or drop the PR.
    2. **The net48 count 54 against 39** (9.3): build the base, compare names, confirm the 14 are the stub error only.
    3. **All 32 merges are unreviewed by a finalizer**, including my 10 additions (item 5).
    4. **#1766 puts a Civil test file change in the Structural train** (item 6.2), and was never run here.
    5. **#1566 changes the start-up guard of Structural**: the only one-in-one-AutoCAD guard is now per process id, so two copies loaded into one AutoCAD are still refused, but a second AutoCAD now starts. Look at it.
    6. **#1736** now stops level marks during REFEDIT and on a locked 25DIMS or 25TEXT.
    7. **#1386 and #1464 and #1744 and #1739 change the Settings window**: the 150 per cent fit test passes, but nobody has looked at the window (Codex look needed, as the review said).
15. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Merge list, in order, with the live head at merge time

Group 1 (Opus review of 25 Oct, `REVIEW_OPEN_PRS_25OCT.md`). Merge commit hashes are on the branch (`git log --merges --first-parent 4af3f37d..da852df3`).

1. **#1762** `f5cd0214` BUG-1061 BUG-1062 BUG-1063 RCBEAM bar room. Only `REGRESSION_LOG.md` conflicted.
2. **#1746** `518741ee` BUG-1048 CEHATCHCHANGE. Log only.
3. **#1749** `57c1b060` BUG-1045 CE_INSPECT read-only. Clashed in `UserSettings.cs` and `SettingsService.LoadRecovery.cs` (both add a switch at the same spot): kept both, second block given its own `/// <summary>`.
4. **#1744** `65078082` BUG-1072 backup tick wording. Log only.
5. **#1739** `8218fe1c` BUG-1076 fault-report words. Clashed in `CeSettingsDialog.xaml` on the three tick lines: kept #1744's tick and grey line, and #1739's "Show save messages on the command line".
6. **#1745** `770759a2` BUG-1073 damaged markup review words.
7. **#1740** `ebf480f3` BUG-1077 BSET hover and Help. Its log entry (with the "5. Undo" line) is on top, in full.
8. **#1741** `0eef8a25` BUG-1078 markup tools Help. Log entry in full, with its Undo line.
9. **#1742** `6fb92d11` BUG-1079 PDF export Help. Also edits Structural `command-registry.json` (2 lines, Help text).
10. **#1766** `d5f3c84d` BUG-1069 drawing-close guards (tests only). Exactly its own 3 files (+96 -68 as the brief said, plus the log).
11. **#1737 left out** (head still `4ae66b1b`, fixes 1 and 2 not pushed).

Group 3 (older Opus reviews, bases older than the train):

12. **#1736** `f25ddba1` BUG-1082 level marks on a locked layer. Log only.
13. **#1729** `0d215deb` BUG-1037 column bars at real size (new switch ON). Log only.
14. **#1732** `91530aef` BUG-1039 SBEAM timber quantity (new switch ON). Clashed in `UserSettings.cs` and `SettingsService.LoadRecovery.cs` with #1729, #1746, #1749: kept both, added a blank line between blocks.
15. **#1385** `cc6a5c58` BUG-755 RCBEAM Type 2 and 6 pictures. Log only.
16. **#1386** `e31f4c63` BUG-752 Settings long paths. Log only (the dialog file merged without a clash).
17. **#1460** `c5e28d8f` BUG-840 routine save merge. Log only (but see item 9.2).
18. **#1464** `5cd70fe3` BUG-841 Settings mistyped number. Log only.
19. **#1529** `7bf04976` BUG-864 hidden layers kept. Merged clean; I moved its log entry to the top and removed one stray blank line (amended before pushing).
20. **#1563** `c571e917` BUG-977 SBEAM picks follow the UCS. Log only.
21. **#1564** `ada6c648` BUG-975 support switch neighbour label. Log only.
22. **#1566** `753d90bd` BUG-978 second AutoCAD startup. Log only.
23. **#1568** `59623e91` BUG-973 CESHEETSCLASSIC swap. Log only.

My additions (ALSO CHECK; Opus reviews B8, B9, B10 of 24 Oct; each log only):

24. **#1574** `f41f68dd`, 25. **#1575** `bd37c02a`, 26. **#1577** `8564a300`, 27. **#1581** `a99df168`, 28. **#1582** `555bd7ef`, 29. **#1585** `5a8feaec`, 30. **#1589** `cecf3506`, 31. **#1603** `b86a2f01`, 32. **#1604** `c857bdf9`, 33. **#1605** `eb7e41e0`.

(Items 24 to 33 are the ten additions; 22 + 10 = 32 merges, item 11 is the PR left out.)

**Log file:** the merged `REGRESSION_LOG.md` is +314 lines and 0 lines removed against the base, zero conflict markers, 32 new entries (664 headings before, 696 after, plus my two pin entries on top of the 32 PR entries). Newest merge on top, a blank line before each new heading, every numbered line of every PR entry present (the "5. Undo" lines of BUG-1077 and BUG-1078 are in).

## 2. Settings and scope

1. See ANSWER FIRST items 6 and 7. `UserSettings.cs` +22 lines, `SettingsService.LoadRecovery.cs` +19 -6, `SettingsService.cs` +18 -2 (the last is #1460's routine-save merge).
2. **Labels changed (words only):** "Record fault and speed information", "Include extra detail in that log" (new note line), "Report work taking longer than (ms)", "Also keep backup copies of Civil-only drawings", "Show save messages on the command line", tab "Saving and fault reports".

## 3. Test evidence

1. **Environment:** private worktree `C:\ce-asm\s44` (short path), own TEMP and `CE_LOG_DIR_OVERRIDE` under `C:\ce-asm\s44x`. `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on PATH for net10, Windows PowerShell folder on PATH for the net48 post-build. The local clone `C:\Lisp Files\CE_ACAD_PLUGIN` was used only to fetch and to create worktrees. Nothing deployed.
2. **Method as S-43:** restore with `EnableUnifiedHostAdapters=true`; standalone `CE_STRUC_SUITE.csproj` restore and build with `=false` (0 errors, 3 min), copy `bin\Standalone\Release` into `bin\Release`; forced restores with `=true`; whole solution `-m:1` (9 min 17 s; no MSB3030 errors, the DLLs were in the right folder). Totals are in the thousands, so the `_AcadRefNet8` name was right (no zero-test run).
3. **Net10 chunk counts (passed):** 330, 367, 232, 242, 320, 234, 335, 362, 353, 343, 679, 454, 307 (one red in the first run of this chunk was the Plugin.cs pin, fixed by `edee80ca`), 318 (+1 failed: the JToken guard), 326, 709, nested 7 = 5,918.
4. **Net48 chunk failures:** 3, 17, 3, 0, 0, 2, 6, 0, 1, 0, 0, 15, 0, 7, 0, 0, 0 = 54. Skipped (not run) 704.
5. **New test classes in the merged PRs (34, all passed, 190 tests):** `BracingPanelTypesDifferGuardTests`, `BracingPanelTypesDifferTests`, `Bug1037ColumnBarSizeTests`, `Bug1045InspectReadOnlyTests`, `Bug1048HatchChangeSplitTests`, `Bug1072CivilBackupWordingTests`, `Bug1073UnreadableMarkupReviewWordsTests`, `Bug1076FaultReportSettingsWordsTests`, `Bug1077BsetHelpWordsTests`, `Bug1078MarkupHelpWordsTests`, `Bug1079PdfExportHelpWordsTests`, `Bug1082LevelMarkLockedLayerTests`, `Bug610ChecklistSaveInPlaceTests`, `Bug752SettingsLongPathTests`, `Bug755RcBeamThumbnailBoundsTests`, `Bug840RoutineSaveMergeTests`, `Bug841BoxLabelTests`, `Bug841SettingsNumberTextTests`, `CeMemberUnitsGuardTests`, `CeSheetsSwapRenameTests`, `CeSheetsTitleXrefLayerMatchTests`, `ExistingHiddenLayerKeptTests`, `FoundationMonitorDetachGuardTests`, `FoundationPathDriverRevertTests`, `HatchAuditUnusableScaleTests`, `PluginRuntimeMutexNameTests`, `RcBeamBarRoomTests`, `ReoBarPlanLengthTests`, `SbeamUcsPickTests`, `SupportSwitchNeighbourTextTests`, `TemplateManagerPendingSuggestionsTests`, plus the new test files of #1575 (`BeamExtendArcBoundaryTests`) and #1766 (Drainage side not run). (Names read from the added files; the filter ran every class name taken from them.)
6. **What I did NOT do:** run the base `4af3f37d` (disk), a clean rebuild after the net48 count looked different from S-43 (disk), Structural net8 tests, the Sbeam evidence class, Drainage or Manager tests, Installer.Tests, the official release build, anything in AutoCAD.

## 4. Hygiene

1. **Leak scan:** clean on both pushes (36 terms), no `--no-verify`.
2. **Cleanup:** at the end of this job I removed the worktree `C:\ce-asm\s44`, the scratch folder `C:\ce-asm\s44x` and the helper refs `refs/remotes/pr/*` I created in the shared repository (the local branch `claude/rel-20261025s` stays). The base worktree `C:\ce-asm\s44b` was removed earlier. No `subst` was used (the path is short). Other jobs' folders under `C:\ce-asm` (`s66`, logs, scripts) were not touched.
3. Pictures under `docs/image/V3_WINDOWS`: see item 10; nothing committed.

## Summary

Train S-44 is `claude/rel-20261025s` at `da852df3` on base `4af3f37d` (installed 1.0.123). 32 PRs merged (22 from the brief, 10 added from Opus MERGE reviews); #1737 left out. Two fingerprint re-pins. Build 0 errors. net10: 5,918 passed, 1 failed (a real guard red in #1460's new code). net48: 54 failed against S-43's 39; base not built (disk below 12 GB). Not installed, nobody opened it in AutoCAD.
