# BUG-901: cover measured to the outside top of the pipe (CE 01 Build, Thu 29 Oct 2026)

Draft PR **#1848** (branch `fb/cover-to-pipe-outside`, base `claude/rel-20261026z`, Civil 3.0.85). Head `3261cf8f`.
Built and unit-tested. **Not installed. Nobody has opened it in AutoCAD.** BUG-901 stays open.

## FOR TIM (ANSWER FIRST)

1. **PR:** #1848, a draft. Nothing is merged, installed or marked FIXED.
2. **What a drafter will see differently:** in CDRULES, the minimum cover rule (R-04) now measures cover from the pit lid level to the **outside** top of the pipe, as AS/NZS 3500.3 does. The row says which wall it used, for example "cover 275 mm to the outside top at P2 (pipe wall 45 mm, Settings RCP 375, Assumed) is below 300 mm".
3. **Before and after, one example** (downstream pit lid at RL 45.300, office minimum cover 300 mm):
   1. **UPVC 225, invert 44.770:** before, 305 mm (passes). After, 305 less a 20 mm wall = **285 mm (warns)**.
   2. **Concrete 375 (RCP / RRJ), invert 44.605:** before, 320 mm (passes). After, 320 less a 45 mm wall = **275 mm (warns)**. This is Tim's own example from the question ("320 really about 275").
4. **Where the wall figures come from:** no wall or outside-diameter table existed in CE (the pipe-to-pit fit evidence holds walls per pipe opening, not per size and material). So I added a Settings table, `cover.pipeWallThicknessMm`. It ships with **Tim's two examples only** (29 Oct 2026): UPVC 225 = 20 mm; concrete 375 = 45 mm (written as RCP, RRJ, CONCRETE and CONC, the same four spellings as the roughness table). Every figure shows "Assumed" until the tick `cover.pipeWallThicknessConfirmed` is turned on. Nothing is hard-coded in the calculation.
5. **Every other size, for example UPVC 100 and 150:** the wall is Unknown. CDRULES keeps the old measure and the old pass or warn, and adds "Pipe wall Unknown (no wall in Settings for UPVC 150), so cover is measured to the inside top as before." It is never a quiet zero and never a block.
6. **Switch:** `cover.measuredToPipeOutside`, ON. OFF gives exactly the old words and results (pinned over a grid of 6 sizes, 6 materials and 5 levels).
7. **Mistakes of my own, first:**
   1. My build wrapper first called dotnet without its full path, so nothing ran. That cost 2 minutes and no damage.
   2. **On my second attempt, my "is the PC free" check read the disk-space line ("FREEGB") as "FREE".** My test run started at 12:24 while the C-76 chain's net48 build (`C:\fin76`) was running. The two ran together for about a minute. I stopped my own run by its own process number only. The other job was not touched. CE 01 should check that the C-76 payload's net48 step finished cleanly. I have not looked.
   3. I first put the cover table into the CDRULES "has anything changed" fingerprint. Ten existing tests that pin "an unchanged job's saved CDRULES run never turns stale" caught it, and I took it out. Cost: one 9-minute test run.
   4. I waited the full 2 hours for the C-76 chain. After that I stopped counting its idle controller window as busy, and waited only while some other dotnet or MSBuild was actually running. Other fix jobs (bpipedef, btidy) were already building between its steps.
8. **NOT proven:**
   1. Nothing has been seen in AutoCAD.
   2. The wall table has no row on the Settings page yet. It lives in the settings file only (`%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, group `cover`).
   3. **CD's own level and size helpers were NOT changed.** The new pipe level suggestions, the pipe sizing check, the levels proposal and the pit setup advisor still aim for the minimum cover to the inside top. So a pipe CD places exactly at the minimum will now show an R-04 warning in CDRULES. It is a warning, never a block. Making CD aim deeper is a separate item and needs Tim's word.
   4. A saved CDRULES run is not flagged as changed when the switch or a wall figure changes. This keeps the established rule that saved runs never go stale. Re-run CDRULES after editing the table.
   5. Tim's question 21(l) (take the wall for every size and material from the pipe data or the standard, and show the table on Settings) is still unanswered. The earlier desk note said 20 mm looks high for UPVC. No standard was checked for either figure.
9. **Robot case that proves it** (for CE 02 to write; suggested name **N36_cdrules_cover_outside** with the switch-off twin **N36o_cover_outside_off**; renumber if N36 is taken):
   1. **Set-up:** fresh drawing. Two pits: P1 lid 46.000, and P2 lid 45.300. One UPVC 225 pipe from P1 to P2, inverts 45.000 then 44.770. A second pair of pits (P3 lid 46.000, P4 lid 45.300) with an RCP / RRJ 375 pipe, inverts 45.000 then 44.605. Office minimum cover 300 mm (the shipped figure).
   2. **Types:** `CDRULES`, then the All option, and reads the saved findings text file (not the 20-row command line).
   3. **Checks (switch ON, shipped settings):** the R-04 line for P1→P2 downstream contains "cover 285 mm to the outside top at P2 (pipe wall 20 mm, Settings UPVC 225, Assumed) is below 300 mm". The R-04 line for P3→P4 downstream contains "cover 275 mm to the outside top at P4 (pipe wall 45 mm, Settings RCP 375, Assumed) is below 300 mm".
   4. **Twin (switch OFF):** set `cover.measuredToPipeOutside` to false in the settings file **before AutoCAD starts** (CE reads settings at start-up). Same steps. The same lines read "cover 305 mm to obvert at P2" and "cover 320 mm to obvert at P4", both passes.
   5. **Unknown control (optional third pipe):** a UPVC 150 pipe gives "Pipe wall Unknown (no wall in Settings for UPVC 150), so cover is measured to the inside top as before."

## Technical detail

1. **Cause:** `Modules/Drainage/Rules/RulebookEngine.cs`, `CoverRules`. The old line was `coverMm = (coverLevel - il) * 1000.0 - diameterMm`. The same sum is in `Rules/RuleFixPlanner.cs`, `PlanCover`. The wall was never taken off.
2. **Change:**
   1. New pure rule `Rules/PipeCoverToOutsideRule.cs` (`IsOn`, `WallMm`, `Measure`). It matches the table row by whole word of the material, longest word first, as the roughness and speed tables do. The size must equal the diameter (within 0.5 mm). A wall of 0 or less, not a number, or as big as the pipe counts as Unknown.
   2. `RulebookValues.Resolve` reads the group once, through a new optional `cover` parameter (default: the live Settings group, else the shipped group). A row typed twice in different case becomes one row, never a crash.
   3. The R-04 finding and its evidence name the wall. The fix planner lowers by the same measure. An Unknown wall is noted just before its closing line.
3. **Settings:** new group `cover` in `Models/UserSettings.cs`, documented "Default: on." It sits outside DesignStandards and outside the CDRULES criteria. A typed table replaces the shipped one (ObjectCreationHandling.Replace, the same as every Settings table).
4. **Reviewed and deliberately left alone:**
   1. `NetworkDesignService` (classic-solve cover notes).
   2. `PipeSizingSolver.CheckCover`.
   3. `PipeGradeAdvisorService`.
   4. `Proposals/LevelsProposalEngine` (the ceiling and the cover row).
   5. `PitSetupAdvisorService`.
   6. `NetworkRedesignSolverService.OutputValidation`.
   7. The Inspector "Cover depth", the Civil Hub, the repair-audit Pass D and `CivilNetworkHealthService`. These measure pit depth, lid to pit floor, not cover over a pipe.
5. **REDO and protection:** reading only. No drawing write, command, regen, view or system variable change. No layer, Xref or REFEDIT path is touched. CE_SHARED, Structural and Manager are unchanged.
6. **Tests:** new `Bug901CoverToPipeOutsideTests`. It covers:
   1. The shipped group.
   2. The switch ON through both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) for `{}`, a file without the group, an empty group and a null group.
   3. Typed false, and a typed table.
   4. Known walls: UPVC, uPVC, UPVC SN8, RCP / RRJ, Concrete.
   5. Unknown walls: UPVC 150, PVC 225, FRC 375, no material, and walls of 0, -5, not a number and 225.
   6. R-04 for the two report pipes, ON and OFF.
   7. The OFF grid.
   8. Every other rule identical ON and OFF.
   9. The fix planner ON, OFF and with an Unknown wall.
   10. The fingerprint unchanged ON and OFF.
   11. A source guard: the rule holds no wall figure, AutoCAD call, command, system variable or Settings read.
7. **Runs** (private worktree `C:\ce-fx\bcover`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, AutoCAD 2027 on PATH, placeholder arx):
   1. First full net10 run: 11 failed. One was my own sentence missing its full stop; ten were the fingerprint pins. Both fixed.
   2. Focused rerun: 245 passed, 0 failed.
   3. Full Civil net10 suite: **20,806 passed, 0 failed, 32 skipped (20,838)**. The PDF page test did not fail, so no lone re-run was needed.
   4. net48 compile of `CE_CVL_SUITE`: 0 errors (242 existing warnings).
   5. Nothing was deployed. No AutoCAD, Codex or accoreconsole was started.
8. **Undo:** revert commit `3261cf8f`, or set `cover.measuredToPipeOutside` to false.
