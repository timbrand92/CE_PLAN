# Train C-49 finalizer report (Civil + Manager), Tue 20 Oct 2026, 09:11 to about 09:45 Melbourne time

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Nothing installed, deployed or version-edited. No AutoCAD, no accoreconsole.

**ANSWER FIRST**

1. **Verdict: GO.**
2. **Final head:** `58a832107f7b033a47be1beccf2e4601a7bdf709` on `claude/rel-20261020c`, unchanged. Checked with `git ls-remote` at the start (09:11) and at the end (09:37): it equals the assembly report's head.
3. **What I changed: nothing.** No commit, no push to the plugin repo. No default needed turning off, nothing needed fixing.
4. **Manager must ship: no.** The train changes 9 files, all under `Modules/Drainage`, `Modules/Drainage.Tests` and `REGRESSION_LOG.md`. No Manager, Installer, `Shared/`, csproj, props or slnx file. Manager 1.1.58 stays as installed.
5. **Tests (Release, at the final head):**
   1. **Whole solution build:** 0 errors, 889 warnings (same count as C-47 and C-48), 17 min 48 s.
   2. **Civil net10 full:** 18,878 run, 18,858 pass, 19 skipped, **1 failed: Glen Eira** (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red). Same numbers as the assembly run.
   3. **Manager net10 full:** 824 of 824.
   4. **Civil net48 focused** (Bug141, TidyObstacle, PitOutline, Bug820, RecoverInverts, RedoSafe, DoubleClick; CERef 24.3.0): 237 run, 229 pass, 7 skipped, **1 failed: `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`**. Not new: it crashes inside AutoCAD's own point type (`InvalidProgramException` at `Point3d.get_X`, the net48 reference-DLL stub), in a test file and a code file this train does not touch (I checked both with `git diff`), and the assembler saw the same failure on the base 69fdb56d.
6. **What Tim will see in AutoCAD (once a release is installed):**
   1. **Tidy labels** (and the tidy-up after MOVE, STRETCH or a PITEDIT resize) stops saying "No clear spot ... (on pit P8)" when a label sits clearly beside the pit. Labels may sit up to about 175 mm closer to a pit than before, never on the pit you can see. A label on a pit, or on a detention tank's end wall, is still moved off.
   2. **CDRECOVERINVERTS** totals line: a pipe with only one of its two invert texts is no longer counted as "already had invert text" (the next line still lists those pipes). Example: 5 pipes left alone, 2 of them with one text only, now reads "3 already had invert text".
7. **Do not mark FIXED:** BUG-141 (stays open until a driver run shows the P8 line gone; the hidden circle on P8 not measured; the tank's long sides and the "SC" block not covered) and BUG-820 (totals half). Plus the standing lists (entries 1366, 1375, 1382). All built and unit-tested only: not installed, not tested in AutoCAD, not accepted.
8. **Switches without a Settings row:** new: `linking.tidyPitByBodyOutline` (ON). Standing: C-47's two (`detention.detentionWithoutLengthNotDiameterChecked`, `linking.tidyIgnoresSheetFrame`) and C-45's 32 (R-00 LOW). I built no rows.
9. **Risks:** low. Labels may now sit closer to a normal pit; if a pit block draws a lid or wall line outside its opening size, a label could land on that line (LOW 2, entry 1371, not proven either way). Whether a detention tank block draws walls along its long sides is not checked (the block is a shipped DWG). Switch OFF gives exactly today's behaviour.
10. **Held, not in this train:** #1438 and #1437 (fix-round commits need an Opus re-review), #1483 (not reviewed), and Tim's list (Structural, #1382, #1384, #1419, #1423).
11. **Your settings files:** unchanged (full SHA-256 compared before 09:13 and after 09:36).

---

## 1. Re-review

1. **MERGE-WITH-FIXES PRs merged: both, each now at a re-reviewed head.**
   1. **#1482** reviewed MERGE-WITH-FIXES at ca534d48 (entry 1371), fix round to a4c53b9f (entry 1385), re-reviewed MERGE (entry 1389). I read the fix-round diff ca534d48..a4c53b9f (3 files: `PitOutline.cs`, `Bug141PitBodyTests.cs`, `REGRESSION_LOG.md`) and the full train diff. Merged head equals the re-reviewed head (`git merge-base --is-ancestor`).
   2. **#1441** reviewed MERGE-WITH-FIXES at 438ed483 (entry 1372), fix round to 0fdf8176 (entry 1386), re-reviewed MERGE (entry 1390). Fix-round diff: one character in `LinkCommands.cs` plus a REGRESSION_LOG entry. Merged head equals the re-reviewed head.
2. **PRs merged without a review entry:** none.
3. **Shared/:** no file changed (`git diff --name-only 69fdb56d 58a83210`). Civil and Manager carry the same CE_SHARED as C-47/C-48.
4. **REGRESSION_LOG.md merge:** no conflict markers left (counted 0); all four new entries (two BUG-141, two BUG-820) present beside the older ones.

## 2. #1441 and #1482 checked by reading

1. **#1441 message fix is right.** The totals line now reads "..., {count} already had invert text, {skippedCount} skipped ..." with the space after the comma. The count is `max(0, already - onlyOne)`; I checked in `LinkCommands.cs` that `onlyOneTextCount++` sits inside the same branch as `alreadyHasTextCount++` (lines 2358 to 2361), so the one-text pipes are a subset and the subtraction is safe.
2. **#1482 detention end-wall allowance is right.** The detention branch of `PitOutline.For` passes `DetentionDividingWallMm * |X scale|` (150 mm) as a wall allowance; every other pit gets 0. Only the new `TryGetBodyBounds` (the label scan) uses it, widening the along-the-tank interval only. `TryGetCoverage`, `Touches` and `WallLength`, which pipe ends and pipe lengths use, do not.
3. **No pit is lost as an obstacle.** A pit with no size of its own is built as a box from the block's drawn extents, so its "body" is still those extents; a pump station is its circle either way; a pit with no outline at all returned false before and still does.
4. **Only caller:** `TryGetPitBoundaryExtents` (the tidy scan) is the one place that now goes through `TidyObstacleRule.TryGetPitFootprint`.

## 3. New defaults

1. **`linking.tidyPitByBodyOutline`, ON (from #1482).**
   1. **Changes what Tim sees by default: yes.** Tidy labels no longer treats the gap between a pit body and the block's hidden pump-station circle as "on the pit".
   2. **Is the old behaviour the bug: yes.** The old behaviour is exactly BUG-141's P8 line: a label visibly clear of the pit reported as "No clear spot ... (on pit P8)" because of a circle nobody can see. ON is right under Tim's rule; OFF gives today's coverage exactly (test).
   3. **Settings page row: none** (R-00 LOW, standing; windows are Codex's).
2. **#1441:** no switch, default or Settings key. The count change is the bug itself (a one-text pipe reported as done).
3. **Turned OFF by me: none.** No commit needed.

## 4. Installer safety

This train does not touch the installer. #1475 (the installer read-only clean-up) shipped in C-47 and is already installed; the brief's mention is carried over. **This train cannot affect the signed-update gate (OfficialReleaseGate) in any way:** no Installer, Manager, Shared, csproj, props, targets or slnx file changed. Installer tests not run (rule), and not needed.

## 5. Build and test evidence

1. Private detached worktree `C:\ce-fin\c49` at `58a83210`, 0-byte `CE_TRANSFORM_2027.arx` placeholder created first. Every command: Release, Below Normal, foreground, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, AutoCAD 2027 folder on PATH, Temp in a long-path folder under the real Temp, solution build `-m:1`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` created only while each command ran and removed after; no waits.
2. Times: solution build 17 min 48 s; Civil net10 full 5 min 9 s; Manager 9 s; net48 focused 11 s.
3. **Not run:** Installer.Tests, full net48 lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, anything in AutoCAD or accoreconsole.
4. **Slip of mine:** the solution build outran the tool's 10-minute foreground limit and was moved to the background by the tool; I kept working in the same turn and waited on it in the foreground until it finished. Nothing else ran alongside it.

## 6. Hygiene

1. AutoCAD and accoreconsole not running (checked). Nothing deployed, nothing written to the application plugins folder, no version edited, no PR closed or merged, `DESK_LOG.md` not edited.
2. Settings files, size and SHA-256 first 8, before and after, unchanged: `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 acd64e79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 622a246f; `CE_STRUC_SUITE\CS_Settings.json` 34,858 24d8e5f7; `CE_CVL_SUITE\settings.json` 672 efe307c4.
3. Worktree `C:\ce-fin\c49` (1.8 GB) removed with `git worktree remove --force` and pruned; my logs `C:\ce-fin\c49logs` and my Temp folder deleted. Left by others, not deleted: `C:\ce-fin\logs`. Main checkout as I found it.
