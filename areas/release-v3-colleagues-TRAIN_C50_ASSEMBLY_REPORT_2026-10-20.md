# Train C-50 assembly report (Civil + Manager), Tue 20 Oct 2026 morning (10:46 to 11:20, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020d`, pushed with a normal push. Head `82a58cda850d6c005726b93bd7a147a6cbf61b94` (`git ls-remote` equals local). Base `origin/claude/rel-20261020c` @ `d25cefa8` (train C-49, the INSTALLED Civil 3.0.59 / Manager 1.1.59 line).
2. **Merged: 3 PRs, one `--no-ff` merge commit each, no squash, no rebase, no cherry-pick:**
   1. **#1437** (BUG-683, same-plan break asks the real length; fix-round commit) at head `f5e5472a`, merge `1b20cbfd`. Review entry 1404: MERGE.
   2. **#1438** (BUG-709 reading half, fix round; ships OFF) at head `bccc9ca5`, merge `06787d1b`. Review entry 1405: MERGE. REGRESSION_LOG.md conflicted; kept both sides, removed only the markers.
   3. **#1483** (BUG-141 diagnostic, fix round) at head `f40de93d` (newer than 596b8c5c; it contains the C-49 head through its own merge `a5b1f177`), merge `82a58cda`. Review entry 1406 said MERGE-WITH-FIXES; the fix round is entry 1410. **There is no Opus re-review entry at f40de93d**; I merged it because the brief names the fix-round head. Finalizer: please read the fix round (entry 1410). No conflict this time (the PR already carried both `TryGetPitFootprint` and `WhyNotSheetFrame`; I counted 3 uses of the two names in `TidyObstacleRule.cs`, 0 conflict markers anywhere).
3. **Left out, with reasons:** every other open Civil/Manager PR not in the base, checked by ancestry against the final head: #1472, #1471, #1468, #1467, #1465 (SUPERSEDED-BY a PR already in the base), #1445 and #1451 (SUPERSEDED-BY #1470 and #1474, already in the base), #1423 and #1419 (HOLD, Tim's list). #1384 (SBEAM, superseded by CEMEMBER) and #1382 (LBUH, parked to Thu 29 Oct) and every Structural PR (base `claude/rel-20261017s`) by Tim's ruling. No other open PR has a MERGE verdict outside the base. Nothing closed or deleted.
4. **Does any merged PR touch Shared/? No.** `git diff --name-only d25cefa8 HEAD` lists 9 files: 5 under `Modules/Drainage`, 3 under `Modules/Drainage.Tests`, plus `REGRESSION_LOG.md`. No Manager, Installer, Shared, csproj, props or slnx file.
5. **Build:** whole solution Release, **0 errors**. Drainage project first (both targets): 0 errors, 662 warnings, 6 min 06 s. Whole solution after it: 0 errors, 235 warnings (incremental, so not comparable with the 889 of a cold build), 12 min 08 s.
6. **Tests (Release):**
   1. **Civil net10 full:** 18,898 run, 18,878 pass, 19 skipped, **1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`** (the known red). Total is in the thousands (C-49: 18,878; +20 new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10 full:** 824 of 824.
   3. **Civil net48 focused** (CERef 24.3.0; Bug141, Bug709, SurveyLevelTags, SamePlanLevelLength, TidyObstacle, TextClashTidyUp, RedoSafe, DoubleClick): 207 run, 206 pass, **1 failed: `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`** (`InvalidProgramException`, the net48 reference-DLL stub). **Same test, same exception as C-49's own run** (assembly and finalizer reports), and it fails on the base too (C-49 assembler checked 69fdb56d). This train touches neither `R3BatchGuardTests.cs` nor `TextClashTidyUpObstaclePolicy.cs` (not in the 9-file diff). I did not re-run the base this time; I rely on the C-49 comparison plus the untouched files.
7. **For the finalizer:**
   1. **Civil only.** Manager, the Installer and CE_SHARED do not change, so Manager does not need to ship for this train.
   2. **Switches:** #1437 and #1438 add no new switch beyond those already in the base in their first heads (their fix rounds are test, wording and reader-route changes); #1438's `survey.surveyReadsMTextAndMoreTags` stays OFF. #1483 adds no switch (diagnostic log line only, needs CDDEBUG On to show anything).
   3. **Do not mark FIXED:** BUG-683, BUG-709 (ships OFF; dimension-text half not done), BUG-141 (diagnostic only; "SC" is a text and is not covered). All built and unit-tested only.
   4. **Needs a look:** the #1483 fix round (item 2.3). No version bump and no REGRESSION_LOG train entry added by me.
8. **Your settings files:** unchanged (size and first 8 of SHA-256 read before 10:47 and after 11:12).

---

## 1. Merge list

1. **#1437** live head `f5e5472ae04a11a0b0e5eba02ed1ec58e42c50e9` (checked 10:47, equal to review). Not in base. Merge `1b20cbfd`. `git diff --numstat HEAD~1 HEAD`: `SamePlanLevelLengthTests.cs` +2 -3, `REGRESSION_LOG.md` +1. This is the fix round only (the earlier head c807cd0e is in the base); `gh pr view 1437 --json files` lists 6 files (+59, +7 -1, +15, +8, +13, +11) against the PR's older base, which matches what the base already holds.
2. **#1438** live head `bccc9ca5bfbec785458ccb1336946f4c85758dd9` (checked 10:47). Not in base. Merge `06787d1b`. Numstat: `SurveyLevelTagsTests.cs` +52 -2, `UserSettings.cs` +3 -1, `SurveyLevelTags.cs` +20, `SurveyService.cs` +22 -6, `REGRESSION_LOG.md` +1. Again the fix round only (first head 91839312 is in the base); `gh pr view` lists the larger first-round figures.
3. **#1483** live head `f40de93d5d1f47a1588aba03f39fc6dd396c1eb7` (checked 10:48). `git merge-base --is-ancestor 596b8c5c f40de93d` true; not in base. Merge `82a58cda`. Numstat: `Bug141SheetFrameTests.cs` +67, `TidyObstacleRule.cs` +38, `LinkService.TextClashTidyUp.cs` +6 -1, `REGRESSION_LOG.md` +12. `gh pr view 1483 --json files` lists 33 files because its base is the old `b03/bug-141-sheet-frame`; the four lines above are what is not already in C-49. The three of its own files (`Bug141SheetFrameTests.cs` 67, `TidyObstacleRule.cs` (+18 already in base, +38 new = 56 listed), `LinkService.TextClashTidyUp.cs` 6 -1, `REGRESSION_LOG.md`) agree.
4. Verdicts read: REVIEWLANE_LOG entries 1403 to 1410 (newest wins).

## 2. Test evidence

1. **Environment:** worktree `C:\ce-asm\c50` (private), `dotnet build/test ... -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers` (build also `-m:1`), process priority Below Normal, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder in the worktree, Temp in `C:\ce-asm\c50tmp`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` created only while each command ran and removed after (checked gone). Nothing deployed.
2. **Timings:** Civil net10 full 4 m 58 s; Manager net10 5 s; Civil net48 focused 4 s. The whole-solution build ran past the 10-minute tool limit and finished in the background (12 min 08 s); I waited for it and read its log.
3. **Failing tests:** `Failed` lines read from the saved logs: net10 only the Glen Eira one; net48 only the Bug141 stub one.
4. **Settings files, size and first 8 of SHA-256, before and after, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
5. **Not run:** Installer.Tests (compile only, rule), full net48 lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, anything in AutoCAD or accoreconsole. The base was not re-run for the net48 red (see 6.3).

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). Nothing deployed, no version edited, no PR closed or merged on GitHub, no branch deleted. `DESK_LOG.md` not edited.
2. Worktree `C:\ce-asm\c50`, `C:\ce-asm\c50logs`, `C:\ce-asm\c50tmp`, `C:\ce-asm\c50run.ps1` and the hash files I made are removed at the end. Left by others, not touched: `C:\ce-asm\logs`, `celog_*`, older hash files.
3. **Slip of mine:** none that cost a rerun. One note: git printed a "LF will be replaced by CRLF" warning on the REGRESSION_LOG conflict fix; the numstat for that file is +1 only, so line endings did not change the diff.
