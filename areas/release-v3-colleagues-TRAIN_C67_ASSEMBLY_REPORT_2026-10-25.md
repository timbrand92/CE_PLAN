# Train C-67 assembly report (Civil + Manager), Sun 25 Oct 2026, real clock 18:10 to 19:15 Melbourne

Built and unit-tested only. Not installed. Nobody has opened any of it in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` and `BUG_CARPARK.md` not edited. Structural is not in this train. Bug fixes only.

PR list read: `areas\TRAIN_C67_PR_LIST_2026-10-25.md`, last commit `0d23c25a`. Nine PRs, same order and same heads as the job text; no promotions.

Installed line read before starting (read-only, `FileVersionInfo`, from a .ps1 file, six DLLs): Civil `3.0.75+2c805a39733ea4649b4273f1f425a37cda463046` in Legacy, Modern and Net8; Manager `1.1.75+2c805a39733ea4649b4273f1f425a37cda463046` in Legacy, Modern and Net8. That is train C-65, so C-66 is NOT installed yet. Installing C-67 therefore delivers the C-66 changes AND these nine together (RULES 8.5). The base tip read with `git ls-remote` at 18:11 was exactly `577b5ce4c74745df988a105078a348c0b4fb1b64`.

## ANSWER FIRST

1. **Mistakes first.** (a) I lost about 20 minutes: my first whole-solution build wrapper used `start /belownormal`, which the shell path-mangled, so `cmd` hung and nothing compiled (no csc ever started). I stopped only my own stuck `cmd` (never a compiler), removed my own lock (it held my process id), and re-ran the build directly. (b) The solution build hit the tool's 600 s limit again and moved to the background; I polled its log and never killed it (it ended exit 0). (c) Priority: the first build ran at normal priority (my priority step had a mangled path). For all test steps the priority script reported "set" for every dotnet and testhost process it found (shown four times per step); I cannot show Windows really lowered the scheduling, only that the call succeeded. (d) The desk build lock was held for the solution build and all four test steps (`sln.lock.txt` and four others: "lock taken" x5), released each time; `build.lock` does not exist now. (e) The Structural settings file differs from the C-66 report's hash (see item 10 in section 4); it did not change during my job.
2. **Branch and head:** `claude/rel-20261025q` (name was free), pushed with a normal push, never forced. **Head `14ba8300cc901e3f784db06f45c4890c54ecae42`** = nine merge commits on the base `577b5ce4`; I made NO commit of my own. Against the base: 39 files, 1,647 lines added, 68 removed, 31 commits (`git rev-list --merges` says 10 because #1743's own head is itself a merge commit that carries C-65; it is not one of mine).
3. **Merged: 9 of 9 listed PRs**, plain `git merge --no-ff`, one merge commit each ("Merge PR #N (BUG-xxx) at <short head>"). **Every live head (gh, `git ls-remote`, fetched `refs/remotes/pr/N`) equalled the reference head: NO PR moved; none rewritten, stopped, merged, closed or already in the branch.** All nine are OPEN. The second parent of every merge commit equals the live head (checked, all nine). After every merge the numstat equalled the PR's own diff, except one explained line: #1759 REGRESSION_LOG.md shows 9 added lines in the merge against 8 in the PR because my script inserted the required blank line before its heading in the same merge commit (as ordered). #1743's numstat equalled its own change (7 files: the five product files, its test and the log), so its merge commit carried nothing extra. Zero conflict markers after every merge and at the end. Log headings: 1,439 on the base, 1,452 now (+13; the PR entries carry several headings each); headings with no blank line before: 160 on the base and 160 now.
4. **Left out:** nothing from the list. Not touched by design: #1771, #1756, #1767 (Tim's yes or decision), the WAITING PRs, the Shared/Installer/signing PRs, the 243 already-contained PRs.
5. **Scope:** `Shared/` EMPTY. `Installer`, `Installer.Tests`, `Modules/Manager/Installer` EMPTY. `CE.AI.Core` unchanged. **Manager: #1738 only**, three product files (`CeBlocksInsertService.cs` 19 lines, `CeBlocksSettings.cs` 6, NEW `CeBlocksLayerGate.cs` 44) plus test `Bug1047FrozenLayerTests.cs`. The new `CeBlocksLayerGate.cs` compiles into the Manager DLL and adds no bundle file (the 75-file bundle guard was NOT run: it needs a payload build). `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json`, every `PackageContents.xml`, the help file: unchanged. No file name matching sign, Signing, release authority or deploy scripts is in the diff; no `.csproj`, `.props`, `.targets` or `.ps1` changed. **`Tests\CE.TestHarness.Tests` links `CeBlocksSettings.cs`** (one of the changed Manager files; it gets a new internal property and two XML lines only, no call into another service): the project still COMPILES in the solution build (built to `net10.0-windows`, 0 errors).
6. **Settings keys added: five switches, all default ON in the merged code, none with a Settings page row** (section 3). No existing default changed. `NewSettingsKeys_NeedADocumentedDefault` PASSES. Settings-fit `EveryTab_FitsTheScreen_AtOneFixedHeight`: the five "Settings fits" cases (`SettingsWindowV3Tests`) pass 5 of 5; the run log prints "tallest tab needs 670 px; window 1100 x 718" at 1920x1080 100% (no change).
7. **Clashes:** `REGRESSION_LOG.md` clashed at all nine merges, resolved keeping every entry, newest on top. **`UserSettings.cs` did NOT clash**; the four Civil blocks merged by themselves. No other file clashed; no PR was stopped. The C-66 resolved pair (#1770/#1772 after `defaultTcMinutes`) is still in the file: not touched.
8. **Build:** whole solution Release **0 errors, 909 warnings** (10 m 6 s, `-m:1`). Frameworks: Civil and Manager built for **net48, net8.0-windows and net10.0-windows**; `CE.TestHarness.Tests` built (net10.0-windows); `Installer` (Debug, net9.0) and `Installer.Tests` (net9.0-windows) **COMPILED, not run**.
9. **Tests (head `14ba8300`, Release):** Civil net10 full suite **20,370 total, 20,338 passed, 32 skipped, 0 failed** (C-66 head 20,303; +67 as expected). Manager net10 full suite **1,013 total, 1,012 passed, 1 skipped, 0 failed** (C-66 1,002; +11 as expected). Civil net48 focused: **2,491 total, 2,309 passed, 131 skipped, 51 failed, the SAME 51 names as the C-66 list** (`diff` of the two failed-name lists is empty), all `InvalidProgramException`. **No new net48 red:** none of this train's classes is among the failed names. REDO call-graph baseline **25 of 25**, nothing re-pinned. The engineering back-test `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance` (both methods) and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet` PASS.
10. **For the finalizer:** (a) nothing is red; (b) six of the nine carry a fix commit with no second independent read (#1753, #1734, #1735, #1743, #1738, #1723): read them; this is the first test of the combination on the C-66 tip; (c) acad.exe was open at every test step (count 1; pid 104804 started 18:07): I never touched it; (d) the Manager 75-file bundle guard was not run; (e) the slab caller count (list section 1 item 1): not counted by me, the finalizer's ask; (f) nothing was seen in AutoCAD.

## 1. Merge list with heads and merge SHAs (merge order)

Reference head equals the live head for every PR; none moved.

1. **#1753** BUG-1051: live head `bb34aaee823048d15c9c7dadf48754531bf1f722`, merge `0ff2b557`, 11 files
2. **#1734** BUG-1040: live head `eb3a2889e53382df00885cc60841f8341f889b0f`, merge `c451c9f8`, 8 files
3. **#1735** BUG-1043: live head `4637698090bb70bcff36cf56f37638cabc70e0af`, merge `ffa05119`, 7 files
4. **#1743** BUG-1049: live head `2a85890d79661435ca0d6b8731ce105334b7cc03`, merge `8c0159f7`, 7 files
5. **#1738** BUG-1047 (Manager): live head `c5774cf2818d7f7c9bde1c3ce9c2177fa4ed13aa`, merge `8dd75f19`, 5 files
6. **#1759** BUG-1055: live head `8044f6aeb96ccd938c508ad6dc693f00b68eccfa`, merge `7d960c86`, 3 files
7. **#1724** BD06 tests: live head `c463d44b733772244b4b6fc3ff82ca50a76e0725`, merge `0ae4e1b0`, 4 files
8. **#1725** BD07 tests: live head `6a4790f9fe2755c924eb9a9ac8a5d7c19b320aea`, merge `fa4b049f`, 3 files
9. **#1723** BD05 tests: live head `b27b96b65ef8d9318f046499e0e23b5f94b612db`, merge `14ba8300` (branch head), 2 files

Files touched by more than one PR (log excluded): only `Modules/Drainage/Models/UserSettings.cs` (#1753, #1734, #1735, #1743), exactly as list section 4. Nothing else overlaps.

## 2. Scope check detail

1. **Shared:** `git diff --stat 577b5ce4..HEAD -- Shared` prints nothing.
2. **Installer, Installer.Tests, Modules/Manager/Installer:** nothing.
3. **Modules/Manager:** `CeBlocksInsertService.cs`, `CeBlocksSettings.cs`, new `CeBlocksLayerGate.cs`, test `Bug1047FrozenLayerTests.cs` (#1738 only). Only added file in Manager, Installer or Shared: `CeBlocksLayerGate.cs`.
4. **Configs, sign/release/deploy, csproj/props/targets/ps1:** none changed.

## 3. Settings keys (default in the merged code; I changed none)

From `git diff 577b5ce4..HEAD` of `UserSettings.cs` and `CeBlocksSettings.cs`: five added blocks, no removed line, no other settings model or Manager switch file changed. All `JsonProperty` names are unique. No Settings page row for any (a search of the XAML and Settings view models for each name finds nothing).

1. **`slabFallUsesDrawingUnits`** (#1753): group `surface` (class `SurfaceDrainageSettings`; so `surface.slabFallUsesDrawingUnits`). Default **on**. Doc line has "Default: on."
2. **`flatPipeIsWarningNotBlock`** (#1734): group `linking` (`LinkingSettings`). Default **on**. "Default: on."
3. **`batchBlankFieldIsLeftOut`** (#1743): group `linking`. Default **on**. "Default: on."
4. **`blankInvertIsWarningNotBlock`** (#1735): group `pipe` (`PipeSettings`). Default **on**. "Default: on."
5. **`FrozenLayerWarnsAndPlaces`** (#1738): Manager, `ce-blocks-settings.xml`, an `internal bool`, default **on**; the loader reads `(bool?)root.Element(...) ?? true`, so an older file without the element loads ON.
6. **No switch OFF.** No switch for #1759 and the three tests-only PRs. Slab key note: the list said `surface.slabFallUsesDrawingUnits`; the property is `slabFallUsesDrawingUnits` inside the `surface` group, consistent.

## 4. Build and test evidence

1. **Environment:** merge worktree `C:\ce-asm\c67`; build and test worktree `C:\asm67\w` (detached at `14ba8300`). Release. Every command carried `-p:SkipDevBundle=true -nr:false --disable-build-servers`; the solution build used `-m:1`. Refs as ordered (`_AcadRef48`, `_AcadRefNet8`, `_AcadRefNet10`, `_AcadRef100`), AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, made by me in the gitignored bin folder). Builds ran with the normal TEMP; test steps ran with a fresh TEMP and CE log folder inside it, in backslash form with long names (`C:\ce-asm\t67_<step>`), `VSTEST_CONNECTION_TIMEOUT=900`. Projects restored one by one (nine projects, all exit 0, a few seconds each); no whole-solution restore. Never deployed. Scripts and logs: `C:\ce-asm\` (`mergeone67.sh`, `loop67.sh`, `check67.sh`, `restore67.sh`, `bdsln67.sh`, `run67.sh`, `civil10_67.sh`, `mgr10_67.sh`, `named10_67.sh`, `f48_67.sh`, `trx67.ps1`, `list67.txt`, `logs67`).
2. **Whole solution Release build** (18:34 to 18:44, 10 m 6 s): 0 errors, 909 warnings.
3. **Civil net10 Release full suite** (18:45 to 18:55): **Total 20,370, Passed 20,338, Skipped 32, Failed 0.** In the tens of thousands.
4. **Manager net10 full suite:** **Total 1,013, Passed 1,012, Skipped 1 (`C60ManagerSupportTests`), Failed 0.** Manager net48: built in the solution build, 0 errors (Manager tests are net10 only).
5. **Civil net48 focused (class-name filters only):** the brief's classes plus the C-66 list plus `C66NewSwitch` plus this train's classes (filter in `f48_67.sh`). Result (18:59 to 19:08): 2,491 total, 2,309 passed, 131 skipped, 51 failed.
6. **The 51 compared by name:** identical to the C-66 list (17 known names, 17 `CdCreationPlanPointTests`, 17 in `Bug1194ClickedLegTests`, `Bug1190NestedSurveyBlockTransformTests`, `Rd09AnnotationPreparationTests`). All `InvalidProgramException`. The slab, propagation, batch-edit and CDPIPEOBJ tests all PASS on net48 too, so no new red there.
7. **REDO call-graph baseline** (`RedoSafeCallGraphTests`, net10 named run): 25 of 25. `RedoSafeReviewedHooks.baseline.txt` not changed by any merged PR; nothing re-pinned by me.
8. **Named runs (net10, one run, 266 tests, all pass, counts from the trx file; counts are the whole class, including older cases):** `Bug1051SlabFallSwitchTests` 8 of 8; `SlabServiceTests` 43; `Bug1040FlatPipeWarnsTests` 9; `PropagationPlanTests` 7; `PropagationPreviewViewModelTests` 35; `Bug1043BlankInvertWarnsTests` 9; `PipeStartReadinessTests` 26; `C2DrawingPresetTests` 37; `Bug1049BlankFieldLeftOutTests` 8; `NativePipeObjectTests` 10 (5 new); `Bd05ScheduleImportSurveyRegressionTests` 10; `Bd06ChecksFailureRegressionTests` 3; `Bd06SettingsMigrationRegressionTests` 3; `Bd06SettingsPageRegressionTests` 3 (Bd06 total 9); `Bd07RaingardenRegressionTests` 2 plus `RatingReportReaderRegressionTests` 5 (Bd07 files total 7; the review's "4 cases" is the raingarden and reader cases per PR text, I did not recount); `NewSettingsKeys_NeedADocumentedDefault` pass; `C65NewSwitchDefaultsTests` 3, `C66NewSwitchDefaultsTests` 3, `HelpGuideVersionTests` 2, `CrossModuleGuardTests` 6, `SettingsWindowV3Tests` 5. Manager `Bug1047FrozenLayerTests` **9 of 9** (7 plus the fix's tests as expected).
9. **Engineering back-test:** green on this head (section 4 item 9 in the answer block).
10. **Tim's settings files, before (18:11) and after (19:09):** `CD_Settings.json` acd64e7 (15,270 bytes), `CS_Settings.json` 622a246 (351,713 bytes), `CE_CVL_SUITE\settings.json` efe307c (672 bytes), `CE_STRUC_SUITE\CS_Settings.json` 0791b07 (35,467 bytes): **all unchanged during my job.** The Structural file differs from the C-66 report's after-hash (2972ce7, 35,259 bytes): it changed between jobs, not in mine.
11. **AutoCAD:** acad.exe pid 104804 (started 18:07) was open at every test step (count 1). A Codex or robot pass may have been running; I never touched it.
12. **Not tested:** anything in AutoCAD or accoreconsole; any window or picture; the Manager 75-file bundle guard; a payload build; `CE.TestHarness.Tests` built but not run; `Installer.Tests` compiled only; `CE.AI.Core.Tests`, `Drainage.ReleaseTests`, Structural tests; a net8 test run; the slab caller count; the hand-read of each fix commit.

## 5. For the finalizer

1. **Nothing is red.** No commit of mine, so nothing to revert but each merge (`git revert -m 1 <merge sha>`, newest first).
2. **Read** the six fix commits in full (list section 2), #1734 (cascade writer gate) and #1753 (slab callers) especially.
3. **Switches, no rows:** list them; `C67NewSwitchDefaultsTests` is the finalizer's to write.
4. **Versions** not bumped (payload builder: Civil 3.0.77 / Manager 1.1.77).
5. **Hygiene:** worktrees `C:\ce-asm\c67` and `C:\asm67\w` and the `t67_*` temp folders are removed after this report is pushed; the remote branch and my local branch `claude/rel-20261025q` stay. Scripts and logs stay in `C:\ce-asm\`.

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.**

## Summary

Branch `claude/rel-20261025q`, head `14ba8300`: all nine PRs merged, no head moved, no commit of mine. Shared and Installer untouched; Manager has one PR (frozen-layer CE Blocks, one new file, no bundle file). Solution builds with 0 errors. Civil net10 20,370 tests and Manager 1,013, none failed. Five bug-fix switches, all on, none with a Settings row. Civil net48 has the same 51 reference-only reds, nothing new. Nothing tested in AutoCAD.
