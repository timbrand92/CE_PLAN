# BUGFIX t3 report, Sun 1 Nov 2026 (B-160, BUG-300)

## FOR TIM

1. **One draft PR is open: #1988** (Structural, base `claude/rel-20261026s`). Title starts "B-160 BUG-300". Built and unit-tested only. Nobody has opened it in AutoCAD. It needs an Opus review because it touches Undo and REDO.
2. **What you will see differently:** draw a footing with FST, ERASE one of its strip lines, type OOPS. The line comes back and, straight away, CE says "PF1 is back; CE redrew its outline." and the outline is on the drawing. Before, the outline stayed missing until the next footing command (FEDIT, FST and so on).
3. **One U after the OOPS takes back the line, the footing record and the outline together; REDO brings all three back.** That is how it is built (it runs inside OOPS's own Undo step and opens no second one). It is NOT yet seen in AutoCAD.
4. **Switch:** `FootingWidth.OopsRestoresOutlineAtOnce`, ON. OFF gives exactly today's behaviour (outline returns at the next footing command). It has no row in the Settings window; it is a settings-file value.
5. **If the footing's layer is locked,** or a block is open for editing (REFEDIT), or you are on a layout tab: CE changes nothing and says one line why. It never unlocks anything.
6. **My own decision to flag (a difference from the brief):** the brief said "when the OOPS or U command ends". I did OOPS only, on purpose. U, UNDO and REDO are the commands that open AutoCAD's REDO window, and a write at the end of U would throw REDO away. A U right after the ERASE already brings back line, record and outline in one step (that was built and measured in S-5), so U needed nothing. If you want U covered too, that needs its own reviewed design.
7. **Mistakes and gaps of my own, first:**
   1. The robot gate result was not attached to my brief, so I did not have it. I confirmed the gap by reading the code instead: nothing in the code reacts to OOPS (the footing watcher at `FoundationMonitor.cs` explicitly skips the U family and has no OOPS step; the only restore is the start-of-command check). That is a code read, not a drawing result. If CE 02's gate case found OOPS already restores the outline, this PR should be held and the batch closed as "no change".
   2. My first net48 build and my first test run failed on my own run script (an unquoted path with a space, and PowerShell missing from the PATH of the post-build step). I fixed the script and re-ran; the results below are from the clean runs.
   3. I did not prove a failing run on the old code. The new tests cannot compile without the new files, so a "red before" run does not exist.
8. **NOT proven:** the real OOPS in AutoCAD (that the restore joins OOPS's own Undo step, that one U and one REDO behave as described), the footing schedule refresh after OOPS, and the locked-layer line. All three need the robot case below.
9. **Windows-in-use safety:** AutoCAD was not started by me. An AutoCAD (pid 79548, started 23:04) was already running from another lane; see the listing note under TECHNICAL.

---

## TECHNICAL

1. **Fault confirmed on base (rel-20261026s, 204dfad2), by reading:**
   1. `FoundationService.cs` 896 to 911: `SyncRegistryWithDrawingState` lifts the "driver erased" mark when the line is live again (`IsErasedOrphanReason` and `IsLiveEntity`), and 986 to 995 redraws and says `RestoredFootingWords`.
   2. Its only callers are the start of each footing command (`ExecuteCore`, line 1088; `FoundationService.LoadPath.cs` line 80; and the one at about 1166). No OOPS hook existed.
   3. `StructuralIdleWorkPlanner.ShouldRedrawAtCommandEnd` returns false for U, UNDO, REDO, MREDO, so the command-end redraw never runs for the U family; OOPS passed that test but the redraw only handles lines queued by the erase/modify watcher, not a line coming back.
2. **Open drafts that touch the file:** `gh pr list --state open --search "FoundationService"` listed many; the three on the same base are #1909, #1930 and #1986. Their `FoundationService.cs` hunks start at lines 1296, 1374, 4197 (#1909); 1221, 1980, 2044, 4808 (#1930); 2072 (#1986). My change is an insertion at about line 1015 plus nothing else in that file, so I did not stack. Older drafts on other bases (#555, #558 and so on) are on retired bases and were not read line by line. #558 is titled "ERASE + FREGENALL is two U".
3. **Change (5 files plus log):**
   1. `Modules/Structural/Core/Footings/OopsRestorePolicy.cs` (new, pure): `IsOopsCommand`, `ShouldRestoreAtCommandEnd(command, switchOn)`, the two plain lines.
   2. `Services/FoundationMonitor.cs` `OnCommandEnded`: after the suspended check and before the normal redraw filter, `if (ShouldRestoreAtCommandEnd(...) && IsOutermostCommandEnd(doc, commandsStillRunning)) FoundationService.RestoreAfterOops(doc);`. Other command ends cost one string compare.
   3. `Services/FoundationService.cs` `RestoreAfterOops(Document)`: switch read; `FootingsBroughtBackByOops` (one registry read; returns if none, so nothing is written); REFEDIT or layout tab check (`ModelSpaceWriteGuard.StopLine`, quiet); locked-layer check on the footing's drafting layer and its line's layer; then `doc.LockDocument()` plus `FoundationScheduleService.BeginFoundationRefresh(new CommandExecutionContext("OOPS", doc))` around `SyncRegistryWithDrawingState(db)`. That is the same scope `ExecuteCore` uses, so a restored pad still refreshes a placed schedule and OOPS does not steal that update from the next footing command. No `BeginFoundationEdit`, no undo mark.
   4. `Models/UserSettings.cs` `FootingWidthSettings.OopsRestoresOutlineAtOnce = true`, doc line ends "Default: on.".
   5. Tests: `Core/Footings/Bug300OopsRestoreTests.cs`, `Models/B160NewSwitchDefaultsTests.cs`. `REGRESSION_LOG.md` entry appended.
4. **Build and tests (all with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below normal priority, one test project, a filter each time):**
   1. net10 test, filter on `Bug300OopsRestoreTests`, `B160NewSwitchDefaultsTests`, `S45NewSwitchDefaultsTests`, `Bug334Item6IdleLispTests`: 37 total, 37 passed, 0 failed.
   2. net10 test, filter on the footing monitor, REDO guard, undo review and Stage3 boundary classes (FoundationOopsAndLoadPathPostTests, FoundationMonitor*, RedoWindowGuardTests, FoundationLabelBroughtBackTests, BUG189SpeedFixGuards, S5/S6/S7/S2 review classes, Stage3ConnectedDesignBoundaryTests, FstNoUndoStepTests, Bug336*): 308 total, 308 passed, 0 failed.
   3. net48 compile of `CE_STRUC_SUITE.csproj` Release: 0 warnings, 0 errors (after fixing my run script's PATH).
   4. Refs used: the C-62 assembly report set (`_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`). Isolation variables echoed before every run: `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\t3\logs`, `TEMP` and `TMP=C:\CE_WORK\scratch\t3\tmp`, `CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\t3\struc`. Manager tests were never run. No test ran against the real AppData.
5. **Real AppData listings (rule 1):** before `C:\CE_WORK\scratch\t3\appdata_before.txt` (65,032 lines), after `appdata_after.txt` (65,038 lines), covering `TIM_CE_CADTOOLS` (with `CE_Admin\outbox` and `logs`), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`. Names, sizes and last-write times are in those files.
   1. **Files that changed between the two listings (16 lines, 11 files):** `CD_RecentValues.json`, three `usage_20261101_*.json` files (in `CE_Admin\outbox\usage` and `usage`), `ledger\suggestions.jsonl`, `logs\ce_cvl_structured_20261101.log`, `logs\CE_CVL_SUITE.log`, `CE_Admin\sessions\CE_SUITE_MANAGER.json`. All are Civil or Manager files in `TIM_CE_CADTOOLS`, with last-write times of 23:04 to 23:11, while an AutoCAD (pid 79548, started 23:04:33) was running. My runs were the Structural test project only, with every path overridden to the scratch folders (the scratch log and struc folders are empty, 0 files), so I judge these to be written by that AutoCAD, not by my tests. I cannot prove it from file times alone, so it is said here rather than assumed.
   2. **Nothing changed** under `CE_STRUC_SUITE`, `CE_CVL_SUITE` (the `%APPDATA%\CE_CVL_SUITE` folder) or `CE_CADTOOLS`.
6. **Robot case (name proposed: `T3_oops_restores_outline`, with twin `T3_oops_restores_outline_off`), in the style of N31_dp_time:**
   1. **Setup:** fresh copy of a made-up drawing; in the OFF twin set `FootingWidth.OopsRestoresOutlineAtOnce` to false in the Structural settings file BEFORE launch (settings are read at start-up).
   2. **Types (one chained string):** `FST`, draw a 4-point strip footing with its lines (answers as the existing footing cases), then `ERASE` and pick one strip line, Enter, then `OOPS`, and read nothing else in between.
   3. **Reads straight after OOPS (before any other command):** (a) the command line contains "is back; CE redrew its outline." (ON) and does not (OFF); (b) the count of the footing's outline entities on the CE outline layer is back to the pre-ERASE number (ON) and is 0 less the outline (OFF, the gap); (c) the footing record's "set aside" flag is clear (ON), set (OFF).
   4. **Undo and REDO (ON only):** type `U` once: the line, the record and the outline are all gone together (one step, U echoes "OOPS"); type `REDO`: all three are back. Switch-off control: the OFF twin keeps the gap, then `FEDIT` shows the line and outline come back at that command as today.
   5. **Locked-layer variant:** lock the footing layer, ERASE, OOPS: one line "is back, but its layer is locked" and the outline count stays 0; the layer is still locked afterwards.
   6. **Not yet written as a case file; CE 02 owns the robot queue.**
7. **Risk notes for the Opus review:**
   1. Whether a write in `CommandEnded` of OOPS joins OOPS's own Undo step. S-5 measured this for MOVE and ERASE in the 2027 core console (U echoed the command name, REDO brought both back); the same pattern is used here but OOPS itself was not measured.
   2. Whether `GlobalCommandName` arrives as "OOPS" in every spelling (`_OOPS`, `.OOPS`); the policy accepts all three.
   3. The restore leaves a prior drafter's "registry memory" state to `FoundationRegistryMemory` (line 84 of that file skips the U family); I did not change it.
8. **Not done:** no Settings window row; no U handling; no change to `BUG_CARPARK.md` or `DESK_LOG.md` (per rules). Bug stays OPEN.
9. **Clean-up:** done after this file was pushed; see the line at the very end.

## Clean-up result

1. Worktree `C:\CE_WORK\build\t3` cleaned (`git clean -fdXq`) and removed; the branch `claude/bug300-oops-restores-outline` is kept (PR #1988). C: free moved from 43.16 GB to 43.40 GB (0.24 GB).
2. **My mistake:** the scratch folder removal also deleted the two AppData listing files named in technical item 5, so the full listings no longer exist; the changed-file list in item 5.1 (from the comparison I ran first) is the record. The scratch folder itself could not be fully removed: this job's own tool-output file under `C:\CE_WORK\scratch\t3\tmp\claude` is held open by the running session. It holds only that session's output files.
