# Train C-48 assembly report (Civil + Manager), Tue 20 Oct 2026 morning (06:40 to 07:00, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020b`, pushed with a normal push. Head `69fdb56dd6258b1c86bf5c7534134b0e05d06980` (local equals origin). Base `origin/claude/rel-20261020a` @ `5e0dae9c` (the installed Civil 3.0.58 / Manager 1.1.58 line, train C-47).
2. **Merged: 1 PR:** **#1481** (BUG-854, the R-06 fix line for a Detention pipe with no length). One `--no-ff` merge commit, no squash, no rebase, no cherry-pick. Merged head `039bedf6` equals the live head (re-checked with gh just before the merge). Opus verdict MERGE (review entry 1370).
3. **Left out, with reasons:**
   1. **#1482 @ `ca534d48`:** MERGE-WITH-FIXES (entry 1371: 1 MEDIUM, a label on a detention tank's end wall would no longer count as a clash; plus 1 LOW wording). The live head is still `ca534d48`, the same head Opus reviewed. No fix round has been pushed, so by your rule it is not eligible. **Needs a Sonnet fix round, then a re-review.**
   2. **#1441 @ `438ed483`:** MERGE-WITH-FIXES (entries 1362 and 1372: one missing space after a comma in the CDRECOVERINVERTS totals message). Live head is still `438ed483`; the one-character fix has NOT been pushed. Left out. Merges onto the base with only a REGRESSION_LOG text conflict, once fixed.
   3. **Superseded, already known (entries 1314 to 1321, 1334):** #1445, #1451, #1465, #1467, #1468, #1471, #1472. All still open, none closed. None has a newer MERGE verdict.
   4. **By Tim's list:** #1382, #1384, #1419, #1423 (no newer review says MERGE), and every Structural PR (#1457, #1460, #1464, #1466; base `claude/rel-20261017s`).
   5. Ancestry check: of every open PR #1439 to #1482, the ones not in the base are exactly #1441, #1445, #1451, #1457, #1460, #1464, #1465, #1466, #1467, #1468, #1471, #1472, #1481, #1482. All others are already in the base (open on GitHub, not closed).
4. **Does any merged PR touch Shared/? No.** `git diff --name-only 5e0dae9c HEAD` lists no `Shared/` file (3 files: `Modules/Drainage/Rules/RuleFixAdvisor.cs`, `Modules/Drainage.Tests/Rules/RuleFixAdvisorTests.cs`, `REGRESSION_LOG.md`; +30 -0). No Manager or Installer file either.
5. **Build:** whole solution Release, **0 errors**, 889 warnings, 8 min 21 s.
6. **Tests:**
   1. **Civil net10 full:** 18,865 run, 18,844 pass, 19 skipped, **2 failed**: `BackTest_GlenEira24115_Computed_WithinTolerance` (the known red) and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (the known intermittent 30 s blank-PDF timeout; no PDF code in this train). The PDF test **passed on its own re-run** (1 of 1). Total is in the thousands (C-47: 18,863, so +2 = #1481's two new tests), so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10:** 824 of 824 (run 1 had 8 failures: my log folder was outside the real Temp folder, the known C-46 trap; environment, not code; run 2 with the long Temp path is the one reported).
   3. **Civil net48 focused (CERef 24.3.0):** 152 of 152, 0 failed (RuleFixAdvisor, RedoSafe, DoubleClick).
   4. **New reds: none.** Nothing needed comparing with the base.
7. **For the finalizer:**
   1. The train is a single small PR (wording of one fix line). Nothing to hand-merge: #1481 merged clean (REGRESSION_LOG had no conflict).
   2. **Manager and the Installer do not change; CE_SHARED does not change.** Civil only.
   3. **No new switch, no default changed, no version bump.** No REGRESSION_LOG train entry added by me.
   4. **Do not mark FIXED:** BUG-854 (wording only, not looked at in AutoCAD), plus the entry 1375 list. Built and unit-tested only: nothing installed or opened in AutoCAD.
   5. Decision for Tim or the desk: #1482 and #1441 are one small fix each away from a merge. If you want them in this train, they need a pushed fix round first.
8. **Your settings files:** unchanged (size and checksum read before and after, section 3).

---

## 1. Merge

1. **#1481** `039bedf6` (merge `69fdb56d`): `Modules/Drainage/Rules/RuleFixAdvisor.cs` (+2), `Modules/Drainage.Tests/Rules/RuleFixAdvisorTests.cs` (+17), `REGRESSION_LOG.md` (+11). The merge's `git diff --numstat HEAD~1 HEAD` equals `gh pr view 1481 --json files` exactly (3 files, same counts). `git merge-base --is-ancestor` said it was not already in the base.
2. Verdicts read: review log entries 1279 to 1376 (newest wins). #1481 MERGE; #1482 and #1441 MERGE-WITH-FIXES at heads equal to the live heads.

## 2. Build and test evidence

1. **Build:** `dotnet build CE_ACAD_PLUGIN.slnx -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `GitExecutable` = the Git cmd path, AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder made first (the C-47 trap). 0 errors. Build lock `C:\CE_PLAN\desk_jobs\build.lock` taken only while each command ran.
2. **Civil net10:** `dotnet test ... CE_CVL_SUITE.Tests.csproj --no-build -f net10.0-windows`, 5 m 27 s.
3. **Manager net10:** `--no-build -f net10.0-windows`, 6 s.
4. **Civil net48 focused:** `--no-build -f net48 --filter FullyQualifiedName~RuleFixAdvisor|~RedoSafe|~DoubleClick`, 4 s.
5. **Settings files, size and first 8 of SHA-256, before (06:41) and after (06:57), unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
6. **Not run:** Installer.Tests (compile only, rule), full net48 lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, anything in AutoCAD or accoreconsole, the base on net48.

## 3. Hygiene

1. AutoCAD and accoreconsole were not running. Nothing deployed, nothing written to the application plugins folder, no version edited.
2. No PR closed, no branch deleted. `DESK_LOG.md` not edited.
3. Worktree `C:\asmt8`, `C:\asmt8logs` and the Temp CE log folders removed at the end.
