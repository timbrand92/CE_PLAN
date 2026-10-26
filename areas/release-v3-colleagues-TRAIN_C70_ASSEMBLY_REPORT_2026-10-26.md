# Train C-70 assembly report (Civil + Manager), Mon 26 Oct 2026, 16:54 to about 17:40 Melbourne

Built and unit-tested only. Not installed. Nobody has opened #1798 in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` and `BUG_CARPARK.md` not edited. Bug fixes only; this train is one DIAGNOSTIC PR, not a fix: BUG-861 stays open. Structural is not in this train.

PR list read: `areas\TRAIN_C70_PR_LIST_2026-10-26.md` (file dated 26 Oct 13:55, 10,448 bytes; read at 16:55). One PR, #1798, same head and order as the job text.

Installed line read first (16:55, read-only, `FileVersionInfo` from a .ps1 file, six DLLs): Civil `3.0.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e` in Legacy, Modern and Net8 (26 Oct 04:28 to 04:33); Manager `1.1.78+d8840a0920f97fedc3b94f98e56eb5a4eb6b663e` in Legacy, Modern and Net8 (26 Oct 04:59). That is C-68 with C-69 not installed yet: acceptable.

## ANSWER FIRST

1. **Mistakes and gaps first, plainly:**
   1. My first version-reading script had a bad regular expression (backslashes) and printed errors; I fixed it and re-ran it. Nothing was touched.
   2. **acad.exe WAS open (one process) during the Civil net10 run, the Manager net10 run and the net48 run.** I never touched it and never took its lock. It was closed at the very start (count 0 at 16:55) and open again at the end (count 1 at 17:37).
   3. The whole-solution build, the Civil net10 run and the net48 run each hit the 600 s tool limit and moved to the background. I polled their end-marker files in the foreground and killed nothing.
   4. My named run is smaller than C-69's (275 tests, not 1,027) because C-70's job text asked for a shorter class list. That is not missing tests.
   5. The PR has NOT had an independent read. Its own author's report says "not independently reviewed". My merge check proves only that the right files came in; I did not review the code logic.
2. **Branch and head:** `claude/rel-20261026u`, pushed with a normal push (never forced). **Head `f2c1bf81d65bffb2f573d0890682f68781e3a41f`** (the merge of #1798). `git ls-remote` confirms it. The branch did not exist before (letter `u` was free). I made no commit of my own.
3. **Base tip used and why it is right:** `d3f9c5dfc6241815d587f335a7ae49ca603c58fa` = the C-69 branch `claude/rel-20261026t` as read live at 16:55. It is a descendant of the C-69 finalizer commit `e7009af1` (`git merge-base --is-ancestor` true). It carries the C-69 version commit ("Version: Civil 3.0.79 / Manager 1.1.79 (C-69)" is the top commit). The four version places read 3.0.79 / 1.1.79 on the tip: `Installer\PackageContents.xml` AppVersion 3.0.79; `Modules\Drainage\CE_CVL_SUITE.csproj` Version 3.0.79; `Modules\Manager\CE_SUITE_MANAGER.csproj` Version 1.1.79; `Modules\Manager\Installer\PackageContents.xml` AppVersion 1.1.79. The C-69 finalizer report's first block reads **GO** at `e7009af1`, nothing reverted, nothing dropped. I edited no version place; they still read 3.0.79 / 1.1.79 on my branch (the payload builder makes Civil 3.0.80 / Manager 1.1.80).
4. **Merged: 1 of 1.** #1798 (BUG-861 diagnostic switches), live head `0e583f6495b44f9b3effb75c75606cf2cd146891`, merge commit `f2c1bf81`. gh, `git ls-remote refs/pull/1798/head`, `git ls-remote refs/heads/fb/bug861-diag-switches` and my fetched `refs/remotes/pr/1798` all read that same head, equal to the reference head. **It did NOT move since the reference.** State OPEN, base on GitHub `claude/rel-20261025r` (untouched). The second parent of the merge commit equals the live head (checked). Merge-base with the previous tip is the C-68 commit as predicted; the numstat of the merge equals the PR's own diff: **MATCH, 11 files**.
5. **Which merged PRs touch Shared/, Installer/ or Modules/Manager: none.** All three diffs against the base tip are empty (section 3).
6. **Manager code is UNCHANGED in this train.** Manager 1.1.80 will be a re-stamp. The four version places still read 3.0.79 / 1.1.79 on my branch.
7. **Settings keys added (all in the new `diag.redo` group, every default `false` = off = normal behaviour, read from the merged code, not changed by me):** `disableSelectionObserver`, `disableRibbonContextTab`, `disablePaletteSelectionHandler`, `disablePaletteFirstPickLog`, `disablePaletteTimer`, `disablePaletteRefresh`, `disableContributedPages`, `disableProjectDataSync`, `disablePaletteFirstScan`, `disableOwnershipHighlight`, `disableTwinPickRedirect`, `disableCompoundSelection`, `disableHoverServices`, `disableProjectQaWait`, `disableAllSelectionWork`. Fifteen keys, each initialised `= false`, each with a `/// <summary>` ending "Default: off." (the group line ends "Default: all off."). None has a Settings page row (the PR touches no window file). `NewSettingsKeys_NeedADocumentedDefault` PASSED.
8. **Build:** whole solution Release **0 errors, 909 warnings** (16:57 to 17:12, `-m:1`, exit 0, 14 m 39 s; same 909 as C-67 and C-68). Frameworks built: Civil, Manager and CE_SHARED for **net48, net8.0-windows and net10.0-windows**; `Tests\CE.TestHarness.Tests` built (net10.0-windows); `CE_CVL_SUITE_Installer` (Debug net9.0) and `CE_CVL_SUITE_Installer.Tests` (net9.0-windows) **COMPILED, not run**. Manager net48 built with 0 errors.
9. **Tests (head `f2c1bf81`, Release):**
   1. Civil net10 full: **20,514 total, 20,482 passed, 32 skipped, 0 failed** (11 m 5 s). That is 20,474 (C-69 assembler) + 5 (finalizer's `C69NewSwitchDefaultsTests`) + 35 (`Bug861DiagSwitchesTests`) = 20,514, exactly. No tests missing. The PDF page test did not fail.
   2. Manager net10 full: **1,041 total, 1,040 passed, 1 skipped, 0 failed** (the C-69 finalized number; no Manager change here).
   3. Civil net48 focused (class-name filters): **2,758 total, 2,569 passed, 134 skipped, 55 failed.** The 55 failed names are **exactly the same set of 55 names** as the C-69 assembler's net48 run (compared by test name in the two result files: "identical sets of failed test names"); every one is the `System.InvalidProgramException` from the reference-only AutoCAD DLL (no failure with any other message). No new red. The new class `Bug861DiagSwitchesTests` **passes on net48 too: 35 of 35.** (2,758 = 2,718 + 5 + 35.)
   4. Named net10 run (275 tests, 272 passed, 3 NotExecuted, 0 failed): `RedoSafeCallGraphTests` **25 of 25** (no count moved, nothing re-pinned); `PickHandlerProbeTests` 7 of 7; `InspectorPaletteRenderTests` 22, `InspectorPaletteServiceHintTests` 13, `InspectorPaletteWordingTests` 5, all pass; `Bug861RedoFirstClickTests` **4 of 4**; `Bug861DiagSwitchesTests` **35 of 35**; `C67NewSwitchDefaultsTests` 3, `C68NewSwitchDefaultsTests` 3, `C69NewSwitchDefaultsTests` 5; `CrossModuleGuardTests` 6; `HelpGuideVersionTests` 2; `C5MixedUnitsTests` 54 of 54 on net10; `C60AuditSourcePinGuardTests` 42 (39 passed, 3 NotExecuted, the same three as in C-69; `NewSettingsKeys_NeedADocumentedDefault` PASSED); `SettingsWindowV3Tests` 34 of 34 (includes the Settings-fit cases; the log prints "tallest tab needs 670 px" for each of the 5 screen cases); `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance`, `BackTest_GlenEira23129_...` and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet` all PASS.
   5. net48 by name: `Bug861RedoFirstClickTests` 4 of 4, `PickHandlerProbeTests` 7 of 7, `C69NewSwitchDefaultsTests` 5 of 5, `C60AuditSourcePinGuardTests` 39 passed + 3 NotExecuted, `C5MixedUnitsTests` 4 failed (the 4 reference-only names that also fail on the base) and 50 passed.
   6. Manager by name (net10): `TestHygieneAppDataGuardTests` 10 and `TestHygieneOfficeFolderGuardTests` 4 pass; `CeAdminPluginOutboxDrainTests` 19 of 19 pass; `CeAdminPolicyServiceTests` 21, `CeAdminUploadTempFilesTests` 1, `C69ManagerSwitchDefaultsTests` 9 pass. There is no test class named `CeAdminStorage*`; the storage service is covered by the drain tests.
10. **Clash blocks resolved:** only `REGRESSION_LOG.md` clashed (both sides prepend an entry): every entry kept, newest on top, 14 added lines, nothing removed, 0 conflict markers anywhere (`git grep` empty), **headings with no blank line before: 160 on the base tip and 160 after the merge** (equal, so no blank-line fix was needed; headings 1,484 to 1,485). `UserSettings.cs` and `InspectorPaletteService.cs` auto-merged; I READ both (section 2).
11. **For the finalizer:** (a) the PR has had no independent read: read `RedoDiagSwitches.cs` in full (it must read only switch values and fixed text) and the first statement of each guarded service; (b) `C70NewSwitchDefaultsTests` is yours to write; (c) the 3 NotExecuted in `C60AuditSourcePinGuardTests` and the skipped counts (32 Civil, 1 Manager) are as in C-69; (d) the author ran Civil in Debug and saw two `SourceAtomicCoordinatorDependencyTests` red; in Release (my run) there are 0 failures, as the job text predicted.

## 1. Merge list

1. **#1798** BUG-861-diag, live head `0e583f6495b44f9b3effb75c75606cf2cd146891`, merge `f2c1bf81d65bffb2f573d0890682f68781e3a41f`, 11 files, log clash only (kept both), numstat MATCH. Message "Merge PR #1798 (BUG-861-diag) at 0e583f64".
2. Numstat (merge equals the PR's own diff): `Bug861DiagSwitchesTests.cs` 209/0 (new, 35 tests); `DiagSettings.cs` 83/0 (new); `UserSettings.cs` 4/0; `CivilOwnershipHighlightService.cs` 4/0; `CivilProjectQaAutomaticService.cs` 3/0; `CivilSelectionObserver.cs` 6/0; `CompoundSelectionService.cs` 1/0; `InspectorPaletteService.cs` 20/1 (the `--stat` total reads 21 changed lines); `PitHoverService.cs` 2/0; `RedoDiagSwitches.cs` 146/0 (new); `REGRESSION_LOG.md` 14/0.

## 2. The two auto-merged files, read after the merge

1. **`UserSettings.cs`** (`git diff d3f9c5df..HEAD`): the PR adds exactly four lines, at line 92 to 95 after the `linking` group:
   ```
   /// <summary>BUG-861 diagnostic switches (26 Oct 2026). Every key defaults to the normal behaviour; nothing changes for a drafter.  Default: every key off.</summary>
   [JsonProperty("diag")]
   public DiagSettings Diag { get; set; } = new DiagSettings();
   ```
   The `JsonProperty("diag")` name is unique. Every C-69 block is still present in the merged file: `pipeSpeedChecks` (line 209), `sharedValues` (213), `wsudTab` (217), `chargedTab` (221), `reaches` (225), `pasteLineForDrawingWithNoRecord` (587), `sheetAccentColour` (1520), `connectionPipe` (2537), `orificeUsesRuledGravity` (2545), `detentionTabUsesCouncilOrificeCo` (2552), `slabMinimumFalls` (2675). The C-68 switch `inspectorPickWaitsAfterUndo` is present (597, default ON, unchanged). The C-67, C-66 and C-65 switches have their own pin tests (`C67NewSwitchDefaultsTests` and `C68NewSwitchDefaultsTests` pass; the C61 to C66 pin classes were in the net48 run).
2. **`InspectorPaletteService.cs`**: holds #1779's deferral (`InspectorPickWaitsAfterUndo` at line 731 to 736, the "pick deferred" and "pick refreshed" log stages at 721 and 728, `LogFirstPickState`), #1784's speed-limit line (line 3462, `PipeSpeedLimitSources.MaxText(SettingsSizingStandards.MaterialLimitOn ...)`), AND #1798's seven switch checks, each the first statement of its method (lines 527 `EnsureDrawingDiscovered`, 648 and 655 `OnImpliedSelectionChanged`, 711 `RefreshAfterPick`, 802 `LogFirstPickState`, 1521 `RefreshContributedPagesOutsideRedoWindow`, 1528 `SyncProjectDataOutsideRedoWindow`). The expression-bodied `RefreshContributedPagesOutsideRedoWindow` became a block body so the guard can come first; the call inside is unchanged.

## 3. Scope check

1. `git diff --stat d3f9c5df..HEAD -- Shared`: **empty** (CE_SHARED unchanged).
2. `-- Installer Installer.Tests Modules/Manager/Installer`: **empty**.
3. `-- Modules/Manager Modules/Manager.Tests`: **empty** (no Manager file changed; no file added under Manager, Installer or Shared).
4. `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json`, any `PackageContents.xml`, any help file: **none changed**, so no CrossModuleGuard count change (`CrossModuleGuardTests` 6 of 6 pass).
5. Files matching sign, Signing, Release or deploy names: **none**.
6. No `.csproj`, `.props`, `.targets` or `.ps1` in the diff (the Manager bundle file-count guard is unaffected; no payload built here).
7. `git diff --shortstat d3f9c5df..HEAD`: **11 files changed, 492 insertions(+), 1 deletion(-)**. Files: the eleven in section 1. `CE.AI.Core` and `CE.AI.Core.Tests`: unchanged.

## 4. Method and hygiene

1. Merge done in `C:\ce-asm\c70`; build and test in `C:\asm70\w` (same commit), as asked. Refs as in the C-69 report (`_AcadRef48`, `_AcadRefNet8`, `_AcadRefNet10`, `_AcadRef100`, AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, `VSTEST_CONNECTION_TIMEOUT=900`). Every command ran with `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal (a priority-setter script ran during each step). Builds used the normal TEMP; test steps used a fresh TEMP and CE log folder inside it (`C:\ce-asm\t70_<step>`, backslash form, long names). Nine projects restored one by one (all exit 0, a few seconds each); no whole-solution restore. The five net48 test names and the class filters are in `C:\ce-asm\logs70\f48_filter.txt` and `named_filter.txt`. Never deployed.
2. **Desk lock:** `build.lock` was taken ("lock taken") and released for the whole-solution build, the Civil net10 run, the Manager net10 run, the net48 run and the named run. It did not exist afterwards (checked).
3. **Disk:** 49.2 GB free at the start, 46.9 GB at the end; never near the 8 GB line. Nothing deleted except my own worktrees and `t70_*` folders.
4. **Tim's settings files, before (16:55) and after (17:37), first 8 characters of SHA-256:** `CD_Settings.json` ACD64E79 (15,270 bytes), `CS_Settings.json` 622A246F (351,713), `CE_STRUC_SUITE\CS_Settings.json` 0791B07E (35,467), `CE_CVL_SUITE\settings.json` EFE307C4 (672): **all unchanged.**
5. Worktrees `C:\ce-asm\c70` and `C:\asm70\w` removed (`git worktree remove --force`, then prune), `C:\asm70` and the `t70_*` folders deleted. The remote branch `claude/rel-20261026u` and the local branch of the same name stay. Scripts and logs stay in `C:\ce-asm\` (`mk70.ps1`, `mergeone70.sh`, `check70.sh`, `restore70.sh`, `bdsln70.sh`, `run70.sh`, `civil10_70.sh`, `mgr10_70.sh`, `f48_70.sh`, `named10_70.sh`, `trx70.ps1`, `cmp70.ps1`, `fail70.ps1`, `logs70`, `s70`). Undo of the whole train: delete the new branch. Undo of the PR alone: `git revert -m 1 f2c1bf81`.

## 5. NOT tested

1. Anything in AutoCAD or accoreconsole: nobody has run #1798 in AutoCAD.
2. That the switches really change an AutoCAD session (only that each site asks its switch first, which the 35 tests check by reading the source).
3. No REDO check of any kind; BUG-861 stays open.
4. The `[REDO-DIAG]` lines were not looked at in a real CE log.
5. `Installer.Tests` compiled only; `CE.TestHarness.Tests` built, not run; Manager net48 tests not run (build only); `CE.AI.Core.Tests`, `Drainage.ReleaseTests`, Structural tests and a net8 test run not run; no payload built (Manager 75-file guard not run).
6. The PR's code has had no independent read.

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.**

## Summary

Branch `claude/rel-20261026u`, head `f2c1bf81`, on the C-69 tip `d3f9c5df` (version commit present). #1798 merged, unmoved, numstat matches its 11 files; only the log clashed. Shared, Installer and Manager untouched. Solution builds with 0 errors on all three frameworks. Civil net10 20,514 and Manager 1,041, zero failed. Net48 shows the same 55 reference-only reds as C-69, and the 35 new switch tests pass on both. Fifteen `diag.redo` keys, all default off. AutoCAD was open during runs. Nobody has run this in AutoCAD.
