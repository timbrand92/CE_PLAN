# Train C-47 assembly report (Civil + Manager), Tue 20 Oct 2026 morning (03:32 to 04:10, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020a`, pushed with a normal push. Head `ad43f0cdf7d7d36e764ee24f695266acb13bc8e3` (local equals origin). Base `origin/claude/rel-20261019b` @ `0bbf4882` (the installed Civil 3.0.57 / Manager 1.1.57 line, train C-46).
2. **Merged: 6 PRs** (6 first-parent merge commits, no squash, no rebase, no cherry-pick): #1475, #1474, #1477, #1478, #1480, #1479. Every merged head equals the live PR head (re-checked with gh immediately before each merge).
3. **Left out, with reasons:**
   1. **#1441, a NEW finding for the finalizer:** its live head is `438ed483`, one commit past the head C-46 merged (`95054f66`). That commit ("the totals line does not count a pipe with only one invert text as already done") has no Opus entry in the review log. The merged part is already in the base. I left it out because nothing reviewed it. Say if you want it in.
   2. **Superseded, already known (entries 1314 to 1321, 1334):** #1445, #1451, #1465, #1467, #1468, #1471, #1472. All still open, none closed.
   3. **By Tim's list:** #1382, #1384, #1419, #1423 (no newer review says MERGE), and every Structural PR (#1457, #1460, #1464, #1466; base `claude/rel-20261017s`).
   4. **No PR was left out for a missing fix round.** All six fix rounds were already pushed when I started (03:35). Nothing else is open on base `claude/rel-20261019a`, `019b` or `20261020*` beyond the list above (checked with gh at 04:03).
4. **Does any merged PR touch Shared/? No.** `git diff --name-only 0bbf4882 HEAD` lists no `Shared/` file. #1474 and #1475 each had their Shared half dropped in their fix rounds. Civil and Manager keep the same CE_SHARED as C-46.
5. **Build:** whole solution Release, **0 errors**. The first run failed on one error only: the 0-byte transform placeholder file was missing in the new worktree (MSB3030 on `CE_TRANSFORM_2027.arx`). I made the file and re-ran. That second run was incremental, so its warning count (116) is not comparable with C-46's 889. First run: 842 warnings, 16 min 24 s. Second run: 0 errors, 2 min 48 s.
6. **Tests:**
   1. **Civil net10 full suite:** 18,863 run, 18,843 pass, 19 skipped, **1 failed**: `BackTest_GlenEira24115_Computed_WithinTolerance`, the known red. Total is in the thousands (C-46: 18,830, so 33 new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10:** 824 of 824 (C-46: 815).
   3. **Civil net48 focused (CERef 24.3.0):** 185 of 185, 0 failed. Classes: Bug141SheetFrameTests, Bug815DetentionNoLengthTests, RulebookDetentionPipeTests, Bug430OwnerAnswerLoggedTests, SourceChangeRefusalTextTests, plus RedoSafe and DoubleClick.
   4. **New reds: none**, so no base comparison was needed.
7. **For the finalizer:**
   1. **Read the fix rounds (reviewed head to merged head):** #1478 (reviewed `ce977899`, merged `66744813`), #1479 (reviewed `c2a8b57e`, merged `89f8ac9d`), and the five MERGE-WITH-FIXES rounds #1474 `13dd7478`, #1475 `f2c6f848`, #1477 `906802c9`. Each carries a "needs Opus re-review" note in review log entries 1352 to 1357. #1480 is merged at the reviewed head `3ccbda24`.
   2. **#1479 brings #1436's two later commits** (`82ceaf4e`, `9769e1d0`), which were never installed: confirmed in the file list (item 3 of section 2: `PipeRecordTypeResolver.cs`, `PipeWindowPrefill.cs`, `PipeSizeNetworkReviewService.cs`, `CdCommand.Schedule.cs`, `PipeEditCommand.Update.cs`, and 43 added lines in `RulebookDetentionPipeTests.cs`). #1436's own branch must not be merged a second time.
   3. **Installer changes** (#1475: `Installer/SafeBundleInstaller.cs` and two tests). Installer.Tests were compiled (inside the 0-error solution build), never run (rule). Ship the Installer with Civil and Manager.
   4. **Manager changes** (#1474: `CeSupportBundleScrub.cs` and a test class). Manager must ship.
   5. **Two new switches, both ON by default, no Settings page row** (the standing R-00 LOW): `detention.detentionWithoutLengthNotDiameterChecked` (#1479) and `linking.tidyIgnoresSheetFrame` (#1480). #1478 rides the existing `linking.sourceTagRefusalsInPlainWords`.
   6. **Version bump and the C-47 `REGRESSION_LOG.md` train entry are not added by me.**
   7. **Do not mark FIXED** (review entry 1350): BUG-813 (diagnostic only), BUG-815 (rows should go; why 14 downpipes carry a drawn Detention type is open), BUG-141 (border half only), BUG-430 (diagnostic), BUG-847 and BUG-838 (built only). None has had a real AutoCAD pass. Built and unit-tested only: nothing installed, deployed or opened in AutoCAD.
8. **Your settings files:** unchanged (size and checksum read before and after, section 4).

---

## 1. Rule checks

1. **Verdicts read:** review log entries 1279 to 1358 (newest wins). #1474, #1475, #1477 MERGE-WITH-FIXES with fix rounds pushed 20 Oct about 03:00 (entries 1352 to 1354); #1478 and #1479 MERGE-WITH-FIXES with fix rounds pushed (entries 1356, 1357); #1480 MERGE. No HOLD or REJECT in the set.
2. **Ancestry:** `git merge-base --is-ancestor` checked each head against the branch before each merge: none was already in. Of every open PR on base `019a` or `019b`, 14 were not in the base: the six merged here plus #1441 and the seven superseded (section list above).
3. **Merge method:** `git merge --no-ff`, one merge commit per PR.
4. **File check, and a correction to the method:** `gh pr view N --json files` lists a PR's files against the PR's own base. #1474, #1475 and #1477 are based on `claude/rel-20261019a`, so gh lists C-46's files as well (a merge of the installed line into the branch). For those three I compared the merge's `git diff --numstat` with `git diff --numstat 0bbf4882 pr/N` (the PR's real change on top of the installed line): **same file set for all three.** For #1478, #1479 and #1480 (base `019b`) the script compared the merge numstat with the gh file list: **identical for all three.**

## 2. Merges, in order (second parent = PR head used, merge commit)

1. #1475 `f2c6f848` (merge `2eb72895`): `Installer/SafeBundleInstaller.cs` (+20 -1), `Installer.Tests/SafeBundleInstallerTests.cs` (+27), REGRESSION_LOG (+9). Clean apart from the log.
2. #1474 `13dd7478` (`bbaeb5dd`): `Modules/Manager/Services/CeSupportBundleScrub.cs` (+21 -6), `CeSupportBundleScrubTempAndAutosaveTests.cs` (+61), REGRESSION_LOG (+9).
3. #1477 `906802c9` (`e4929eae`): `Modules/Drainage/Services/CompoundEditModeService.cs` (+23 -1), `Bug430OwnerAnswerLoggedTests.cs` (+60), REGRESSION_LOG (+18).
4. #1478 `66744813` (`ecd5cb99`): `LinkService.SourceChanges.cs`, `SourceChangeCaptureModels.cs`, `SourceChangeRefusalText.cs`, `SourceChangeRefusalTextTests.cs`, REGRESSION_LOG.
5. #1480 `3ccbda24` (`7d04e0ca`): `LinkService.TextClashTidyUp.cs`, `TidyObstacleRule.cs`, `UserSettings.cs` (Linking switch), `Bug141SheetFrameTests.cs`, REGRESSION_LOG.
6. #1479 `89f8ac9d` (`ad43f0cd`): `RulebookEngine.cs`, `PipeRecordTypeResolver.cs`, `PipeWindowPrefill.cs`, `PipeSizeNetworkReviewService.cs`, `CdCommand.Schedule.cs`, `PipeEditCommand.Update.cs`, `UserSettings.cs` (Detention switch), `Bug815DetentionNoLengthTests.cs`, `RulebookDetentionPipeTests.cs`, REGRESSION_LOG.

Net change of the train against the installed line: 23 files, +730 -22 (`git diff --stat 0bbf4882 HEAD`).

## 3. Conflicts

1. **REGRESSION_LOG.md** conflicted on the last three merges (each PR adds at the top). Resolved by keeping the base and applying that PR's own added block, so **every entry is kept**: the log gains exactly 100 lines, 0 deletions (9 + 9 + 18 + the other three).
2. **No code conflict.** No hand merge was needed. `UserSettings.cs` merged clean with both new switches (Detention and Linking), as review entry 1347 predicted.

## 4. Build and test evidence

1. **Build:** `dotnet build C:\ce-asm\c47\CE_ACAD_PLUGIN.slnx -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `GitExecutable` = the Git cmd path, AutoCAD 2027 on PATH. Run 1: 1 error (missing placeholder, see answer item 5), 842 warnings, 16 min 24 s. Run 2 (placeholder made, incremental): **0 errors**, 116 warnings, 2 min 48 s. Logs: `C:\ce-asm\logs\c47_build_run1_noplaceholder.log` and `c47_build.log`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` taken only while each command ran.
2. **Civil net10 (Release, `--no-build`, `-f net10.0-windows`, fresh CE log folder):** 18,863 total, 18,843 pass, 19 skipped, **1 failed** (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red), 5 min 14 s. Total is in the thousands.
3. **Manager net10 (long Temp-path log folder, the C-46 trap):** 824 of 824, 5 s.
4. **Civil net48 focused:** 185 of 185, 4 s (filter above).
5. **Settings files, size and first 8 of SHA-256, read before and after, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`. These are the same values as C-46.
6. **Not run:** Installer.Tests (compile only, rule), net48 full lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, each PR alone, anything in AutoCAD or accoreconsole, the base on net48.

## 5. Hygiene

1. AutoCAD and accoreconsole were not running (tasklist at the end); nothing deployed, nothing written to the application plugins folder, no version edited. CE logs went to scratch folders under Temp.
2. No PR closed, no branch deleted. `DESK_LOG.md` not edited.
3. The worktree `C:\ce-asm\c47` and the scratch logs were removed at the end (see the last line of this report once the job ends).
