# BUGFIX p17 report, Fri 30 Oct 2026 (Structural group S2: BUG-451, BUG-472, BUG-480)

## ANSWER FIRST

**No PR opened. All three entries were skipped, with evidence below. No code was changed, nothing was built or tested, so no settings listings were needed (no test code ran).**

## FOR TIM

1. **BUG-472 (layout tab or REFEDIT writes into Model space):** already fixed on the Structural train. R1, BT1, AB, BB, C1, TS1, BTX, FSF and FPFC now stop with one plain line on a layout tab or inside REFEDIT and draw nothing. It came in with PR #887 (HUNT-S-07) and the newest Structural line already carries it. Nothing left to build. What is still unproven is that it works in AutoCAD: that is a test for CE 02, not a build.
2. **BUG-480 (status says "CE is current" when the office folder is missing):** this is a Manager bug, not Structural, and it is already fixed on the Civil/Manager line (comment "HUNT-M-05" in the status service). It needs a second Windows login or a PC without the office folder to see, so it is a test set-up item. CE 05 should send it to CE 04 or CE 02, not to a builder.
3. **BUG-451 (Codex W41 observations):** this is a list of what Codex saw, not a fault. Most of it was the test brief and a click on a prompt keyword. Two points are still "not understood" (FSF showing no "Specify start point" prompt, and where the pad footing label text sits). Those need a re-run in AutoCAD, so it is a test item, not a build.

## Technical detail

1. **BUG-472 evidence:** on `origin/claude/rel-20261026s` (head 204dfad2) PR #887 @ 906e3792 is an ancestor. `DrawingSafetyService.CommandPreFlightModelSpace` (DrawingSafetyService.cs:62) is called from BeamTextConvertCommands.cs:22 (BTX), BracingCommands.cs:17, 133, 248 (AB, BB, BT1), RafterJoistCommands.cs:99 (R1) and SupportBlockCommands.cs:215 (C1, TS1). FoundationService.cs:1211, 1325, 2068 carry the same guard for FSF and FPFC. The decision rule is `ModelSpaceWriteGuard` (Core/Symbols), with tests in `ModelSpaceWriteGuardTests.cs`. A later commit, bdb2c3d0, put the layout line first on the quick footing text tools. The reconciliation note (CARPARK_RECONCILIATION_2026-10-22.md) that said "no fix" is stale. REVIEWLANE_LOG line 1417 records #887 as MERGE.
2. **BUG-472 not proven:** I did not run it in AutoCAD, and I did not check STRSCHEDCREATE on a layout tab (a related finding in HUNT_STRUC_BRACING_REO_2026-10-12.md item 9, not part of BUG-472). If that is not yet carparked on its own, CE 05 may want to check.
3. **BUG-480 evidence:** `origin/claude/rel-20261102a`, `Modules/Manager/Services/CeReleaseStatusService.cs:158` has the "HUNT-M-05" comment ("no office folder ... is not the same as current"). TEAMLANE3_LOG line 402 says the same. The Structural train line has no Manager change for it, and Manager is outside group S2.
4. **BUG-451 evidence:** the carpark status is "OPEN (observations; W42 re-run in progress)", with no single fix named.
5. **My own mistakes:** none that cost anything. I did not claim a fix without reading the code on the line. The Manager grep on the S line returned nothing because that fix lives on the C-78 line, not the S line.
6. **Robot case:** none needed from this job. For BUG-472 a case would type BT1 (and C1, BTX) on a layout tab and check the one stop line and an unchanged entity count. The switch-off control does not apply because the fix has no Settings switch (it is a protection rule, not an engineering value).
