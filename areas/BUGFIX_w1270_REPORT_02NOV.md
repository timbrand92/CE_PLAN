# BUGFIX w1270 report: BUG-1270 CDSYNC rewrites "IL 17.900" as "IL 17.90" (B-162, 2 Nov 2026)

## FOR TIM

1. **What you will see differently:** make a pipe with levels typed as 18.100 and 17.900, run CDSYNC, and the plan still says IL 18.100 and IL 17.900. Before, the lower level came back as IL 17.90 and the grade text could move from 1 IN 100 to 1 IN 99.
2. **What it is:** CDSYNC re-links every pipe. CE then re-checks any pipe that holds a grade and writes the lower level back using the Settings "Calculated decimals" (2). The number was the same, but the writing cut off the third decimal. The top level was written back exactly as drawn, which is why only one end changed.
3. **The fix:** if the re-worked level is the same as the drawn one at the Settings decimals, CE now writes nothing. A level that really changes (you move a pit) is written exactly as before. New Settings switch `cdsync.keepsLevelTextFormat`, ON. OFF gives the old behaviour exactly. Default: on.
4. **My own mistakes first:** (a) I could not run AutoCAD, so the cause is found by reading the code and matching it to the robot's numbers, not by watching it. It fits the robot reading (top end untouched, bottom end cut to 2 decimals, grade text shifted) but it is NOT proven. (b) Three of my first test runs failed on set-up (wrong path quoting, missing placeholder file); no effect on your PC.
5. **NOT proven:** nothing has been opened in AutoCAD. The pit depth change from 1.00 to 1.10 on P8 is NOT touched and NOT explained by this fix (CE 02 reads it separately, PROBE-CDSYNC-BA2). One thing I noticed: the pit-depth change and this change both show on the same pit P8, so they may share a trigger (CDSYNC marking pipes as changed), but I did not look into the depth code.
6. **Robot case that proves it:** PROBE-CDSYNC-BA on a drawing like Codex S2-04. It types `CD`, two points (130000,-80000 and 150000,-80000), sets New Pipe `C2.FirstInvert` = 18.100 and `C2.SecondInvert` = 17.900, presses Start Pipe, then types `CDSYNC` alone. It reads all IL texts of the new pipe before and after. PASS = both read `IL 18.100 | IL 17.900` identical. Switch-off twin: set `cdsync.keepsLevelTextFormat` to false in the settings file BEFORE launching AutoCAD (CE reads settings at start); the same steps must then read `IL 18.100 | IL 17.90`. Also check the grade text stays `1 IN 100`.

---

## Technical detail

1. **Fault confirmed on base `origin/claude/rel-20261102a` (3fbb9da5, Civil 3.0.88):**
   1. `Modules/Drainage/Commands/LinkCommands.cs` CDSYNC (line 120 onward) calls `LinkService.RegisterPipe` for every pipe, then `ProjectDataService.SyncWithDrawing` and `LinkService.UpdatePipeEndpointsFromProjectData` (lines 189-190).
   2. `Services/LinkService.Utilities.cs` `ApplyGradeLockToInverts` (line 2075) runs for a pipe queued as changed (`LinkService.PipeUpdates.cs` line 181, `ApplyPipeUpdates`). For a grade-held pipe (`IsGradeHeld`: any mode but "inverts"/blank/"default") it works the bottom level with `ComputeGradeLockLevels` (line 2321): `newFrom = fromText` verbatim, bottom `= ToString("F{decimals}")` with `decimals = Inverts.CalculatedDecimals` (2). The untyped path then wrote it (`WriteGradeLockInvertsToEntities` then the record) even when the number was unchanged. Typed bottom levels already skip when equal at the displayed precision (`GradeHeldLevelChoiceService.Decide`, SameAtDisplayedPrecision); the untyped path had no such check.
   3. The New Pipe window defaults to a held grade (`IsGradeFromInverts = false`, CdViewModel.Grade.cs), so a pipe made with typed inverts is still grade-held, and the dialog-typed level is not flagged as a typed bottom level.
2. **Ruled out as the writer:** `ScheduleLinkService.FormatLevel2Dp` and `PipeTruthResolverService.FormatInvert` (schedule/read only), `ComposeLinkedInvertPlanWording` (Edit Pipe save only), `ProjectDataService.DeriveMissingPitInvertsFromPipes` (fills blanks only), `RefreshPipeMetadataFromDrawing` (reads text, no write), `FlatPipeRepair` (CDFIXFLATPIPES only), `IlNumberFormat` in InvertPropagation (cascade preview only).
3. **Direction/intent note:** this is the same-direction re-work of a held grade, not a pipe leaving a pit versus arriving at it. The fix keeps to the text format and the write/no-write decision.
4. **Change:** `Models/CdSyncSettings.cs` (new group `cdsync`), `Models/UserSettings.cs` (`CdSync` property), `Rules/GradeLockLevelFormatRule.cs` (pure rule), `Services/LinkService.Utilities.cs` (one early return before the write), `REGRESSION_LOG.md`, `Modules/Drainage.Tests/Services/Bug1270CdSyncLevelTextTests.cs`. CE_SHARED untouched. No new write, command, regen, view or system variable; REDO-safe (it removes a write).
5. **Tests:** `dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj --filter FullyQualifiedName~Bug1270CdSyncLevelTextTests`, Release, flags `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`: net48 6 passed, net10.0 6 passed, 0 failed (count not 0). The net48 build compiled Drainage for net48 (compile check). Only these tests ran, none of the others.
6. **Side effect to know:** a held-grade pipe whose worked level differs from the stored one by less than half a step at the Settings decimals (under 5 mm at 2 decimals) is no longer rewritten when something marks it changed. Moves that change the level by 5 mm or more write as before.
7. **Not done:** the repo-wide new-switch-defaults test files (C61 to C78 style) are per-train finalizer files; this PR pins the switch through both start-up reads in its own test file instead.

## Isolation listings (rule 1)

1. Variables set before the run: `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\w1270\log`, `TEMP`/`TMP=C:\CE_WORK\scratch\w1270\tmp`, `CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\w1270\strucroot`. No Manager tests.
2. Listings: `C:\CE_WORK\scratch\w1270\before.txt` (35,817 lines, taken 11:54) and `after.txt` (46 lines differ), both over `%APPDATA%\TIM_CE_CADTOOLS` (with CE_Admin\outbox and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`.
3. **Real files DID change between the listings, and I am saying so first as the rule requires:** `CD_Settings.json` (12:03:22), `CD_RecentValues.json` (12:06:56), `CE_CVL_SUITE.log`, `ce_struc_suite.log`, `runtime_*`, `manager-menu-state.json`, `CE_SUITE_MANAGER.json`, outbox `machines` and `usage` files. An `acad.exe` (PID 52644, started 12:03:25) was running on this PC from another job's robot; these are its start-up and run writes. `CD_Settings.json` changed 3 seconds before that AutoCAD started, so it is the one I cannot separate by timestamp alone. My run could not have written it: only my 6 tests ran, they read JSON text in memory and write no file, and the product code under test writes nothing.
4. C: free space: 47.6 GB before, 47.1 GB after the build (worktree not yet removed at this point).

## Branch and PR

1. Branch `claude/w1270-cdsync-decimals`, base `claude/rel-20261102a`, one commit. PR: #1990 (draft).
2. Bug stays OPEN. Never FIXED until the ledger accepts it by name.
