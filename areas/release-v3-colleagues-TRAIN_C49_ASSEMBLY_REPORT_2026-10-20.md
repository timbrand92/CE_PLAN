# Train C-49 assembly report (Civil + Manager), Tue 20 Oct 2026 morning (08:35 to 09:15, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261020c`, pushed with a normal push. Head `58a832107f7b033a47be1beccf2e4601a7bdf709` (`git ls-remote` equals local). Base `origin/claude/rel-20261020b` @ `69fdb56d` (train C-48, Opus GO, not installed), which sits on the installed Civil 3.0.58 / Manager 1.1.58 line (`5e0dae9c`, C-47).
2. **Merged: 2 PRs, one `--no-ff` merge commit each, no squash, no rebase, no cherry-pick:**
   1. **#1482** (BUG-141 first half, Tidy labels measures a pit by its body) at head `a4c53b9f`, merge `9bb9ffb7`. Opus re-review entry 1389: MERGE. Live head checked with gh just before the merge: equal.
   2. **#1441** (BUG-820 totals half, CDRECOVERINVERTS totals line) at head `0fdf8176`, merge `58a83210`. Opus re-review entry 1390: MERGE. Live head checked just before the merge: equal.
3. **Left out, with reasons:**
   1. **Every other open Civil/Manager PR not in the base** has no newer MERGE verdict at its live head. By name: #1472, #1471, #1468, #1467, #1465 are SUPERSEDED-BY a PR that is already in the base (entries 1314 to 1320); #1445 is SUPERSEDED-BY #1470 (entry 1318) and #1451 is SUPERSEDED-BY #1474 (entry 1321), both already in the base; #1483 (`b03/bug-141-sheet-frame`, head `596b8c5c`, not found by `gh pr view`, no review entry): not reviewed, left out.
   2. **#1438 (head bccc9ca5) and #1437 (head f5e5472a):** their review entries (1272, 1271) say MERGE at the older heads 91839312 and c807cd0e. Each PR got one fix-round commit AFTER that review (the Opus fix rounds themselves), and those commits are not in the base (the earlier heads are, merged in C-45). There is **no re-review entry at the new heads**, so I left them out. **Needs an Opus re-review of the one fix-round commit each**, then they are one merge away.
   3. **By Tim's list:** #1382, #1384, #1419, #1423, and every Structural PR (base `claude/rel-20261017s`).
   4. The older Civil/Structural PRs in the not-in-base list (#1285 to #1341 etc.) are historical: reviewed MERGE at earlier heads and shipped in earlier trains, or Structural. None has a newer verdict. Nothing closed.
4. **Does any merged PR touch Shared/? No.** `git diff --name-only 69fdb56d HEAD` lists 9 files, all under `Modules/Drainage` or `Modules/Drainage.Tests` plus `REGRESSION_LOG.md`. No Manager, Installer, Shared, csproj, props or slnx file.
5. **Build:** whole solution Release, **0 errors**, 889 warnings (same count as C-47 and C-48), 20 min 08 s.
6. **Tests (Release):**
   1. **Civil net10 full:** 18,878 run, 18,858 pass, 19 skipped, **1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance`** (the known red). Total is in the thousands (C-48: 18,865; +13 new tests from the two PRs), so the `_AcadRefNet8` trap is not in play. The blank-page PDF test (intermittent in C-48) passed this time.
   2. **Manager net10 full:** 824 of 824.
   3. **Civil net48 focused (CERef 24.3.0; Bug141, TidyObstacle, PitOutline, Bug820, RecoverInverts, RedoSafe, DoubleClick):** 237 run, 229 pass, 7 skipped, **1 failed: `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`** (`InvalidProgramException` at `Point3d.get_X`, the net48 reference-DLL stub). **It fails on the base too** (69fdb56d, same filter file `R3BatchGuardTests`: 2 of 6 fail, this one and `Bug140_CacheHitPass...`, same exception). Neither test file nor `TextClashTidyUpObstaclePolicy.cs` is touched by this train. So this is an environment limit of the net48 test run, not a new red from #1482 or #1441.
7. **For the finalizer:**
   1. REGRESSION_LOG.md conflicted in both merges (every PR adds at the top); I kept every entry on both sides, deleted only the conflict markers. No code file conflicted. #1441's merge brings only its two commits (the totals half): its first half is already in the base, so its merge diff is 3 files (+21 -1 over 4 lines of code plus the log), not the 5 files `gh pr view` lists against its old base. #1482's merge diff equals `gh pr view 1482 --json files` exactly (6 files, same counts).
   2. **Civil only.** Manager, the Installer and CE_SHARED do not change.
   3. **New switch:** `linking.tidyPitByBodyOutline` (ON) from #1482, in `UserSettings.cs`; no Settings page row (R-00 LOW, standing). #1441 adds no switch.
   4. **Do not mark FIXED:** BUG-141 (stays open until a driver run shows the P8 line gone; the tank's long sides and the "SC" block are not covered) and BUG-820 (totals half). Both built and unit-tested only: not installed, not tested in AutoCAD.
   5. **Still waiting for an Opus re-review:** #1438 and #1437 fix-round commits (item 3.2).
   6. No version bump, no REGRESSION_LOG train entry added by me.
8. **Your settings files:** unchanged (size and first 8 of SHA-256 read before 08:38 and after 09:10).

---

## 1. Merge list

1. **#1482** live head `a4c53b9f9158f8f99392706f7b1514a3463aa995` (checked 08:38). `git merge-base --is-ancestor` said not in base. Merge `9bb9ffb7`. Files: `Bug141PitBodyTests.cs` +118, `UserSettings.cs` +8, `PitOutline.cs` +34 -6, `TidyObstacleRule.cs` +18, `LinkService.PitOutline.cs` +1 -1, `REGRESSION_LOG.md` +16. Equal to `gh pr view 1482 --json files`.
2. **#1441** live head `0fdf817647dfa50e01233570ae1bfa19427cb9aa` (checked 08:38). Not in base. Merge `58a83210`. Files: `Bug820TotalsLineTests.cs` +30, `LinkCommands.cs` +1 -1, `RecoverInvertsCertaintyRule.cs` +7, `REGRESSION_LOG.md` +13. This equals the PR's two commits only (`git diff --numstat` from the merge-base 95054f66 to 0fdf8176). `gh pr view` shows more because its base `claude/rel-20261019a` predates the part already in the base.
3. Verdicts read: REVIEWLANE_LOG entries 1385 to 1394 (newest wins): #1482 MERGE, #1441 MERGE, at heads equal to the live heads.

## 2. Test evidence

1. **Build:** `dotnet build CE_ACAD_PLUGIN.slnx -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder made first, Temp in a long folder under the real Temp. Build lock `C:\CE_PLAN\desk_jobs\build.lock` created only while each command ran and removed after.
2. **Civil net10:** `CE_CVL_SUITE.Tests.csproj --no-build -f net10.0-windows`, 5 m 52 s. **Manager net10:** 7 s. **Civil net48 focused:** `-f net48 --filter` the seven class names, 12 s.
3. **Base comparison (net48 red):** detached worktree at `69fdb56d`, `CE_CVL_SUITE.Tests.csproj -f net48` built (0 errors, 1 m 41 s), then `FullyQualifiedName~R3BatchGuardTests`: 2 failed, 4 passed, same `InvalidProgramException`.
4. **Settings files, size and first 8 of SHA-256, before and after, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
5. **Not run:** Installer.Tests (compile only, rule), full net48 lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. AutoCAD and accoreconsole not running (checked). Nothing deployed, nothing written to the application plugins folder, no version edited, no PR closed or merged on GitHub, no branch deleted. `DESK_LOG.md` not edited.
2. Worktrees `C:\ce-asm\c49` and `C:\ce-asm\b48`, my logs `C:\ce-asm\c49logs` and my Temp folder removed at the end. Left by others, not touched: `C:\ce-asm\logs`, `celog_*` folders.
3. **Slips of mine:** my first build attempt failed in 1 second (a space in the Git path broke the command line; nothing built, nothing written). And my first log folder name was the same as an older job's folder, `C:\ce-asm\logs`: I deleted only the three files I had just made there and left theirs.
