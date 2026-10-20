# Train C-51 assembly report (Civil + Manager), Tue 20 Oct 2026 (12:32 to 12:45, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020e`, pushed with a normal push. Head `ec358f0bcfcacbd8c3b3936eb6741b2e246de9e5` (`git ls-remote` equals local). Base `origin/claude/rel-20261020d` @ `9c97d36f` (train C-50, the INSTALLED Civil 3.0.60 / Manager 1.1.60 line).
2. **Merged: 1 PR**, one `--no-ff` merge commit, no squash, no rebase, no cherry-pick: **#1484** (BUG-141 border half: the sheet frame only has to contain the label) at live head `01fb0b2a5539cf16fa681eeba756040f08ce9c67`, merge `ec358f0b`. It is a draft PR on base `claude/rel-20261020d`. It has a fix-draft entry (1419) and **NO Opus review entry yet**; I merged it as briefed, so **the C-51 finalizer must review it fully**.
3. **Left out, with reasons:** everything else, by the brief. Structural PRs (base `claude/rel-20261017s`), #1382 (LBUH, parked to Thu 29 Oct), #1384 (SBEAM, superseded by CEMEMBER), #1419 and #1423 (HOLD), and any HOLD, REJECT or SUPERSEDED-BY PR. Nothing closed or deleted.
4. **Does any merged PR touch Shared/? No.** The merge changes 6 files: 1 test and 4 product files under `Modules/Drainage` / `Modules/Drainage.Tests`, plus `REGRESSION_LOG.md`. No Manager, Installer, Shared, csproj, props or slnx file.
5. **Build:** whole solution Release, **0 errors** (235 warnings, incremental). Drainage project first, both targets: 0 errors, 662 warnings.
6. **Tests (Release):**
   1. **Civil net10 full:** 18,909 run, 18,889 pass, 19 skipped, **1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`** (the known red). Total is in the thousands (C-50: 18,898; +11 new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10 full:** 824 of 824.
   3. **Civil net48 focused** (CERef 24.3.0; Bug141, Bug709, SurveyLevelTags, SamePlanLevelLength, TidyObstacle, TextClashTidyUp, RedoSafe, DoubleClick, SheetFrame, TidyPitText): 218 run, 217 pass, **1 failed: `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`**, `InvalidProgramException` inside `Point3d.get_X()` (the net48 reference-DLL stub), thrown from `TextClashTidyUpObstaclePolicy.cs:25` called by `R3BatchGuardTests.cs:46`. **Same test, same exception as the C-49 and C-50 runs**; neither file is in this merge, and the C-49 assembler saw it fail on its base. I did not re-run the base this time.
7. **For the finalizer:**
   1. **Civil only.** Manager, Installer and CE_SHARED do not change.
   2. **Review #1484 in full** (no Opus entry). It changes `TidyObstacleRule.cs` (+42 -17), `LinkService.TextClashTidyUp.cs` (+13 -10), `LinkService.TidyPitText.cs` (+2 -1) and `UserSettings.cs` (+3 -2). The `UserSettings.cs` change needs checking for a new switch or a changed default: I did not read it for that.
   3. **Do not mark FIXED:** BUG-141. Built and unit-tested only; nobody has opened it in AutoCAD.
   4. No version bump and no REGRESSION_LOG train entry added by me.
8. **Your settings files:** unchanged (size and first 8 of SHA-256 read before 12:34 and after 12:43).

---

## 1. Merge list

1. **#1484** live head `01fb0b2a5539cf16fa681eeba756040f08ce9c67`. Checked with `gh pr view` at 12:33 and again with a fetch of `refs/pull/1484/head` immediately before the merge; both gave this sha. `git merge-base --is-ancestor` said not in base. Merge `ec358f0b`, no conflict.
2. **Numstat check:** `git diff --numstat HEAD~1 HEAD` equals `gh pr view 1484 --json files` exactly, file by file: `Bug141SheetFrameTests.cs` 124/0, `UserSettings.cs` 3/2, `TidyObstacleRule.cs` 42/17, `LinkService.TextClashTidyUp.cs` 13/10, `LinkService.TidyPitText.cs` 2/1, `REGRESSION_LOG.md` 14/0. No conflict markers in the tree.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c51`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, all in the foreground. `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, Temp in `C:\ce-asm\c51tmp`, logs in `C:\ce-asm\c51logs`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone). Nothing deployed.
2. **Timings:** Drainage build 1 m 24 s; whole solution 2 m 31 s; Civil net10 full 5 m 10 s; Manager 10 s; net48 focused 11 s.
3. **Failing tests:** `Failed` lines read from the saved logs: net10 only Glen Eira; net48 only the Bug141 stub one.
4. **Settings files, size and first 8 of SHA-256, before and after, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
5. **Not run:** Installer.Tests (compile only, rule), full net48 lane, Structural, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). No version edited, no PR closed, no branch deleted. `DESK_LOG.md` not edited.
2. My worktree `C:\ce-asm\c51`, `c51logs`, `c51tmp` and `c51run.ps1` are removed after this report is pushed.
3. **Slip of mine:** my first Drainage build call passed the extra arguments wrongly, so dotnet stopped at once (0 s). Nothing built; fixed and rerun.
