# Train C-52 assembly report (Civil + Manager), Tue 20 Oct 2026 (13:51 to 14:05 by the PC clock)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020f`, pushed with a normal push. Head `5bc9616746a0b62ffea7e52044fcd3718798305e` (`git ls-remote` equals local). Base `origin/claude/rel-20261020e` @ `279c231c` (train C-51, the INSTALLED Civil 3.0.61 / Manager 1.1.61 line).
2. **Merged: 1 PR**, one `--no-ff` merge commit, no squash, no rebase, no cherry-pick: **#1485** (BUG-141 text obstacle: the CE log names a TEXT kept as an obstacle; diagnostic only) at live head `b56839b87c2ce7bcc94517fd8d3306f0df79e28b`. It is a draft PR on base `claude/rel-20261020e` (correct). It has **NO Opus review entry yet**; I merged it as briefed, so **the C-52 finalizer must review it fully**. The PR branch did not contain the C-51 version commit, so the plain merge brought the tree together with it; no conflict.
3. **Left out, with reasons:** everything else, by the brief. Structural PRs (base `claude/rel-20261017s`), #1382 (LBUH, parked to Thu 29 Oct), #1384 (SBEAM, superseded by CEMEMBER), #1419 and #1423, and anything HOLD, REJECT or SUPERSEDED-BY. Nothing closed or deleted.
4. **Does any merged PR touch Shared/? No.** Four files: one new test and two product files under `Modules/Drainage*`, plus `REGRESSION_LOG.md`. No Manager, Installer, Shared, csproj, props or slnx file.
5. **Build (Release):** whole solution **0 errors** (235 warnings). Drainage project, both targets: 0 errors, 662 warnings.
6. **Tests (Release):**
   1. **Civil net10 full:** 18,913 run, 18,893 pass, 19 skipped, **1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`** (the known red). Total is in the thousands (C-51: 18,909; +4 new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10 full:** 824 of 824.
   3. **Civil net48 focused** (CERef 24.3.0; Bug141, Bug709, SurveyLevelTags, SamePlanLevelLength, TidyObstacle, TextClashTidyUp, RedoSafe, DoubleClick, SheetFrame, TidyPitText): 222 run, 221 pass, **1 failed: `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`** (`R3BatchGuardTests.cs:46`, the net48 reference-DLL stub `InvalidProgramException`). Not new: the same test failed the same way in the C-49, C-50 and C-51 runs. I did not re-run it on the base this time. **Note for the finalizer:** #1485 adds a text-obstacle test file in the same BUG-141 area, and that one passes on net48.
7. **For the finalizer:**
   1. **Civil only.** Manager, Installer and CE_SHARED do not change.
   2. **Review #1485 in full** (no Opus entry). It changes `TidyObstacleRule.cs` (+14) and `LinkService.TextClashTidyUp.cs` (+5), both additions only. It is meant to be diagnostic only: please confirm no behaviour change (no new switch, no changed default, no change to what counts as an obstacle).
   3. **Do not mark FIXED:** BUG-141. Built and unit-tested only; nobody has opened it in AutoCAD.
   4. No version bump and no REGRESSION_LOG train entry added by me.
8. **Your settings files:** unchanged (size and first 8 of SHA-256 read before the merge and after the last test).

---

## 1. Merge list

1. **#1485** live head `b56839b87c2ce7bcc94517fd8d3306f0df79e28b`. `gh pr view` (base `claude/rel-20261020e`, draft, open, branch `claude/b4-bug141-text-obstacle`) and a fetch of `refs/pull/1485/head` immediately before the merge gave the same sha. `git merge-base --is-ancestor` said the PR was not in the base. Merge commit `5bc96167`, no conflict, no conflict markers.
2. **Numstat check:** `git diff --numstat HEAD~1 HEAD` equals `gh pr view 1485 --json files` exactly: `Bug141TextObstacleLineTests.cs` 58/0, `TidyObstacleRule.cs` 14/0, `LinkService.TextClashTidyUp.cs` 5/0, `REGRESSION_LOG.md` 11/0.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c52`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, every command in the foreground. `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, Temp and CE log folder inside `C:\ce-asm\c52tmp`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone). Nothing deployed.
2. **Timings:** Drainage build 1 m 34 s; whole solution 2 m 18 s; Civil net10 full about 5 m; Manager 5 s; net48 focused 4 s.
3. **Failing tests:** `Failed` lines read from the saved logs: net10 only Glen Eira; net48 only the Bug141 stub one.
4. **My own slip (not a product fault):** my first Manager run put the CE log folder outside the temp folder, so 8 settings-folder guard tests failed ("must only ever touch the run's temporary settings file"). I moved the log folder inside the temp folder and re-ran: 824 of 824. The Civil net10 run was done with the first setting and still had only the Glen Eira failure.
5. **Settings files, size and first 8 of SHA-256, before and after, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
6. **Not run:** Installer.Tests (compile only, rule), full net48 lane, Structural, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). No version edited, no PR closed, no branch deleted. `DESK_LOG.md` not edited.
2. My worktree `C:\ce-asm\c52`, `c52logs` and `c52tmp` are removed after this report is pushed.
