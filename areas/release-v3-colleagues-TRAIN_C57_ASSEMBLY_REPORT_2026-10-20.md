# Train C-57 assembly report (Civil + Manager), Tue 20 Oct 2026 (run on the real clock Wed 21 Oct 04:03 to 04:30)

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261020k` at `081a5a838f068ebca2d365d081c4335cc78675bf`, pushed with a normal push (ls-remote equals this head). Base `origin/claude/rel-20261020j` at `581b0e7b` (installed Civil 3.0.66 / Manager 1.1.66, train C-56). No version bumped.
2. **Merged: 2 PRs, both at the named heads** (live head re-checked with gh immediately before each merge and equal): #1502 (222c35b4) and #1493 (4746cfa9). 21 files against the base.
3. **Left out:** nothing in scope. Structural PRs (including #1503, the Structural half of BUG-852, already in S-39), #1382, #1384, #1419, #1423, #1191, #1183, #1180 and the command-outcome logging PR were not touched.
4. **Shared/:** no merged PR touches `Shared/` (0 files). **Manager MUST ship:** #1493 changes 6 Manager source files, the Manager PackageContents and the Manager command registry; #1502 changes Civil only.
5. **Build:** whole solution Release, 0 errors, 888 warnings, 3 min 6 s.
6. **Tests (Release):**
   1. **Civil net10 full: 19,039 total, 19,017 pass, 19 skipped, 3 FAILED.** One is the known Glen Eira red. **TWO ARE NEW and come from #1493** (item 7.1).
   2. **Manager net10 full:** 837 of 837.
   3. **Civil net48 focused:** 192 of 192 (RedoSafe, DoubleClick, Bug416, Bug385, CeVersion, Bug852).
   4. Installer.Tests: compiled in the solution build, not run (rule).
7. **For the finalizer (read these):**
   1. **TWO NEW REDS, both `CrossModuleGuardTests` in Drainage.Tests, both caused by #1493 on a tree that does not hold the Structural half:**
      1. `DuplicateCommandScan_FindsNoDuplicates`: "CE_VERSION -> [Structural\Commands\AdminCommands.cs, Manager\Commands\PluginManagerCommands.cs]". Manager now owns CE_VERSION; this tree's Structural module still has its own (#1503 removes it, and #1503 is in S-39, not here).
      2. `DuplicateCommandScan_CommandCounts_MatchStudyEvidence`: Manager literal `[CommandMethod]` count is 12, the test expects 11 (Manager gained CE_VERSION). `Tests/CrossModuleGuardTests.cs` (Modules/Drainage.Tests/Services/CrossModuleGuardTests.cs line 120) was not edited by #1493.
      3. Both pass on the base (the C-56 finalizer saw only Glen Eira red; I did not re-run the base). Not fixed by me (assembler does not edit). **Decision for the finalizer:** move the Manager expected count 11 to 12 in this train; the duplicate clears only when #1503 is on the same tree. **Installed reality:** S-39 (Structural without CE_VERSION) is already installed on Tim's PC, so there is no runtime duplicate once C-57 goes on; the guard is only stale on a Civil+Manager-only tree. Please also check that the Structural count (288) is adjusted on the S-39 side.
   2. **Tim's `TIM_CE_CADTOOLS\CD_Settings.json` CHANGED during my run** (acd64e79, 15,270 bytes, before; 9d27b04c, 15,302 bytes, after; file time 04:16:37, inside my Civil net10 test window 04:13 to 04:20). No acad.exe or accoreconsole was running. This is the same 9d27b04c content the C-56 reports saw swapping in and out. I redirected TEMP and the CE log folder for every step, so I do not believe my run wrote it, but I did not prove it, and a unit test writing the real AppData file is possible. I kept no copy of the old content. Someone should read the file and decide. The other three settings files are unchanged.
   3. **#1502 has NO Opus review yet** (REVIEWLANE_LOG entry 1511 is a fix draft only): the finalizer must review it fully. In AutoCAD terms: the three CE right-click items stop writing a project record that belongs to a previous drawing. Changes are in `CivilNetworkSelectContextMenuService.cs` and `ProjectDataService.Mutations.cs`, plus 3 Bug385 test files, the new `Bug416SelectRunReadOnlyTests.cs` and `RedoSafeCallGraphTests.cs`.
   4. **#1493** (Opus MERGE-WITH-FIXES, these are the fixes): Manager owns CE_VERSION and opens its own version window (new `CeVersionReport.cs`, `CeVersionWindow.xaml`/`.cs`, `PluginManagerCommands.cs`, registry and register rows). Nothing installed or deployed. No bug marked FIXED (BUG-416 residual and BUG-852 stay open until driven in AutoCAD).

## 1. Merge list

1. **#1502 @ 222c35b4b732a68bd5ee78eb2e791501eb721c6c** (BUG-416 residual path). PR base `claude/rel-20261020i`. Not an ancestor of the base (checked). Merge `863828c1`. **Conflict: `REGRESSION_LOG.md` only**; kept both sides (every line the PR added is present in HEAD, no markers). Numstat file list equals the PR's file list (8 files).
2. **#1493 @ 4746cfa92584167e46200e5228041fc1c21e4f57** (BUG-852 Manager half). PR base `claude/b4-bug834-approved-version` (its two parents #1491/#1492 are already in the base). Not an ancestor (checked). Merge `081a5a83`. **Conflict: `REGRESSION_LOG.md` only**, kept every entry, checked line by line. Numstat file list equals the PR's file list (14 files).
3. Plain `git merge --no-ff`, one merge commit per PR, no squash, rebase or cherry-pick. `Shared/` touched by neither.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c57`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, every command in the foreground. Net10 refs `C:\TimOS\refs\autocad\autocad-2026-ref` (`_AcadRefNet8`) and `autocad-net8-ref` (2027, `_AcadRefNet10`/`_AcadRef100`); net48 `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; AutoCAD 2027 folder on PATH; 0-byte `CE_TRANSFORM_2027.arx` placeholder; fresh TEMP and CE log folder per step. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (gone at the end). 04:08 to 04:23.
2. **Timings:** solution 3 m 6 s; Civil net10 5 m 36 s (test duration); Manager 9 s; net48 focused 6 s. Civil total 19,039 is in the thousands, so the wrong-ref-name trap is not in play.
3. **Civil net10 failures (read from the saved log):** `BackTest_GlenEira24115_Computed_WithinTolerance` (known), `DuplicateCommandScan_CommandCounts_MatchStudyEvidence` (Expected 11, was 12), `DuplicateCommandScan_FindsNoDuplicates` (CE_VERSION in Structural and Manager).
4. **Tim's settings files (before / after):** `CS_Settings.json` 622a246f / 622a246f unchanged; `CE_CVL_SUITE\settings.json` efe307c4 / efe307c4 unchanged; `CE_STRUC_SUITE\CS_Settings.json` f68eeb5e / f68eeb5e unchanged; **`TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 / 9d27b04c CHANGED** (item 7.2; not reported as unchanged).
5. **Not run:** Installer.Tests, Structural, full net48, Manager release-candidate build, base re-run of the two new reds, anything in AutoCAD or accoreconsole.

## 3. Hygiene

1. No PR closed, no branch deleted, no version edited, `DESK_LOG.md` not edited, nothing installed or deployed.
2. Worktree `C:\ce-asm\c57`, `c57logs` and `c57tmp` removed after this report is pushed (other `C:\ce-asm` files are not mine).
3. **Four words:** built and unit-tested (3 reds, see 7.1). Not installed. Nobody has opened it in AutoCAD.
