# Wave 1 paper review, job RE (writers E1, E2, E3, E4)

Reviewer: Opus, Team job RE, Sat 31 Oct 2026 (Melbourne). Brief: `C:\CE_PLAN\desk_jobs\WAVE1_REVIEW_BRIEF.txt`. Code read at 3fbb9da5 (Civil 3.0.88). Nothing was run in AutoCAD. Only `validate` and `check_ids` were run. No case, setup or settings file was edited, no slip was written and nothing was committed.

## Answer first

1. **Counts (19 files):** 16 READY TO RUN, 3 FIX FIRST, 0 NOT RUNNABLE, 0 NEEDS A CODEX LOOK.
2. **FIX FIRST, one fault shared by three files:** W652, W652_BROKEN and W653_BROKEN. The Edit Pipe step sets pipe A to B to 18.500 / 18.200. That is 1 in 32 on a 225 pipe leaving a pit: 2.60 m/s against the 2.0 m/s pit-outlet limit. After Apply, the "Design Warnings" window opens and nothing closes it, so the case stalls instead of failing on a check.
3. **The fix:** type 18.300 instead of 18.500 in that step (W652 line 111; both twins line 104). That gives 1 in 95.5, shown as 1.50 m/s, which does not open the window. Every expected level stays the same.
4. **Riskiest 1, W652:** the stall above. Even after the fix it rests on two things never seen in AutoCAD: an empty value clearing the downstream box (line 98), and a speed that sits exactly on the 1.50 m/s line.
5. **Riskiest 2, W278:** it is the only case where one check tells the fixed build from the old one. That check is P8's Pit Schedule row showing the pipe as an INLET (line 70), and that row has never been seen. If the cell names differ, the case fails on wording, not on the fix.
6. **Riskiest 3, W656:** the main case would probably also pass on a build without the fix, because exactly one endpoint line was already seen on 3.0.88. Only the twin going red proves anything, and the twin's extra log lines are derived, never seen.
7. **Offline checks:** validate gave "57 file(s) checked, 0 invalid". check_ids gave "every control id is known" (58 files). All 19 of my files are clean.
8. **No window is left open by any READY case.** Every press is on a known button: Save, Cancel without saving, Start Pipe, Continue placement, Close, Apply. The Recalculate box is answered Yes, or No in W654; No is on the allow-list but has not been used in a case before.
9. **Every level was re-worked** for its own pipe length. Pits are 450 x 450, so ends sit 225 mm inside each wall: 10.450 m centres give 10.000 m of pipe (E3), and 10.000 m centres give 9.550 m (E2). Open-end pipes are 20.000 m (E1, W324).
10. **Bugs with no case (writers' calls, which I agree with):** BUG-292 (needs an old-style pipe); BUG-339, 688 and 689 (batch Apply is on no press list); BUG-687 (the Q box id is unknown); BUG-682 (the Uphill box is not on the message-box list). These go to a Codex look or a driver allow-list change, not to the robot.
11. **A writer claim corrected:** E3 said W652's three New Pipe pipes sit "right on the 1.5 line". They do: 1.502 m/s, shown as 1.50. CE compares the shown value, so the window does not open. Only the Edit Pipe step is over the limit.
12. **Next:** apply the one-line fix to the three W652 files, then all 19 can go to CE 02's robot run. Allow about 3 hours for all 19, mostly the four-pit cases.

---

## Per case

### 1. W223 and W223_BROKEN (BUG-223, Edit Pipe between two open ends): READY TO RUN

1. **Keys while a window is open:** none. Lines 24-25 set the New Pipe boxes; line 26 presses Start Pipe; line 27 waits for the window to close. Lines 39-41 set and dump inside Edit Pipe; line 42 presses Save. Line 50 presses "Cancel without saving", then line 51 waits for the window to close.
2. **Sources:**
   1. Note wording: `CdViewModel.Inverts.cs` 1040.
   2. Box names: `Inverts.cs` 291-297 and 305-311.
   3. Two open ends follow the typed levels: `ConnectedPipeFlowResolver.cs` 937-976.
   4. "Pipe updated.": `PipeEditCommand.cs` 556.
   5. The control-next row order ("Edit pipe, Set first end level", then "Downstream") is SEEN in `pack_runs\ui_dumps\Creative_Engineering_Edit_Pipe_130928.json`.
   6. The labels and note refresh while typing: `RefreshInvertWorkflow`, `Inverts.cs` 978-1000.
3. **Arithmetic:** 20.000 m with a 0.200 fall is 1 in 100. Open ends have no pit, so no wall cut and no pit-outlet check.
4. **Proves the bug:** yes. The old build kept "Upstream" and showed the "Upstream invert is lower" note.
5. **Twin:** it drops lines 39-40 only. It fails on the line 58 note check. A save with nothing typed closes the window either way (it may print "No changes detected" instead of "Pipe updated."), so it cannot stall.

### 2. W261 and W261_BROKEN (BUG-261, size-only save, false "flows uphill"): READY TO RUN

1. **Keys while a window is open:** none unsafe. Line 53 runs close-windows straight after the size-only save. This catches a Design Warnings window if the fault returns, so it would fail on line 66, not stall.
2. **Sources:**
   1. Fix: `PipeEditCommand.Update.cs` 570-574.
   2. Warning wording: `DesignValidationService.cs` 325.
   3. The label "150 DIA. UPVC PIPE AT 1 IN 100" was SEEN in R32bv87.
   4. The 225 starting size was SEEN in the 3.0.88 dump: the job's last size on a fresh DRV1_B1 is 225.
3. **Proves the bug:** yes. Before the fix, the first box (17.800) was treated as upstream, so the old line would say "upstream IL 17.800 is 200mm lower".
4. **Twin:** it fails on line 64 (the arrow stays at rotation 0) and line 70 (the box reads 18.000).

### 3. W278 and W278_BROKEN (BUG-278, Save keeps the recorded flow into P8): READY TO RUN (risk 2)

1. **Keys while a window is open:** none. Pit Schedule is closed by the known "Close" (line 53) and a wait for the window to close.
2. **Route checked:** an open end is stored as a blank name, so P8 to an open end has no two-name stored direction. `ResolveWithLevels` (`ConnectedPipeFlowResolver.cs` 937-976) then lets the typed levels turn the pipe into P8. The first box becomes "Downstream". Edit Pipe never shows the Grade mismatch window: that window exists only in `CdCommand.cs` 592.
3. **Arithmetic:**
   1. Length 170000 - 150225 = 19.775 m; fall 0.200, so 1 in 98.9.
   2. After the turn-round the upstream end is the open end, so no pit-outlet check applies.
   3. Twin: the pipe leaves P8 at 1.48 m/s (225 mm) and 1.13 m/s (150 mm). Both are within 1.5, so no window.
4. **Schedule regex (line 70):** the column order and the "DIA (Outlet): blank" cell names are SEEN in `Creative_Engineering_Pit_Schedule_PITSCHEDULE_122026.json`. A pit's first inlet sits on its main row, as for P4 to P7 in that dump, so the regex shape is right. The inlet 150 / 17.800 in it is DERIVED.
5. **Proves the bug:** yes, through the schedule only. Without the fix the reopened boxes would probably still read Downstream, because the levels decide them. The schedule row is the discriminating check.
6. **Optional hardening (not required):** add `close-windows -> $closed_after_size` after line 40, as W261 does.

### 4. W324 and W324_BROKEN (BUG-324, one older pipe in a two-pipe batch): READY TO RUN

1. **Keys while a window is open:** none. The batch editor is closed with close-windows (line 48). Nothing inside it is pressed.
2. **Sources:**
   1. "2 pipes selected - opening the batch editor.": `HubCommands.cs` 288, with a plain hyphen.
   2. Left-out line: `PipeBatchReadRule.cs` 51-63 and 128-131.
   3. Name "P4 -> P3": `PitMoveLockedPipeRule.cs` 67-68.
   4. Window title for one pipe: `PipeBatchReadRule.cs` 39-40.
   5. "Carry downstream" is always visible for pipes: `PipeEditCommand.Batch.cs` 318.
   6. "Apply to Selected": `BatchEditWorkshopDialog.xaml` 388.
3. **DERIVED:** that 10A98D still fails the batch read on this fixture (seen on DRV20_B1a on 4 Oct). If it reads instead, the case fails on line 63, not on a stall.
4. **Twin:** it fails on line 61 (it expects the old refusal).
5. **Minor:** the IL-text before/after check (lines 35-41 and 52-58) only reads objects after index 500 and 1000. It is weak but harmless.

### 5. W652, W652_BROKEN, W653_BROKEN (BUG-652 and BUG-653): FIX FIRST (risk 1)

1. **The fault:**
   1. Line 114 Save comes after levels 18.500 / 18.200 on A to B. That is 9.550 m with a 0.300 fall: 1 in 31.8.
   2. Speed: (1/0.010) x 0.05625^(2/3) x (1/31.8)^0.5 = 2.60 m/s. UPVC n is 0.01 in Tim's `CD_Settings.json`; the formula is `DesignValidationService.cs` 133-150.
   3. That is over the 2.0 m/s pit-outlet limit (`UserSettings.cs` 3302-3306; `PitOutletSpeedCheck.cs` 55-66). The warning is collected at `PipeEditCommand.Update.cs` 598-603.
   4. The Recalculate question (`Update.cs` 524, then 1908, then 1978) and Cascade Preview come first. The Design Warnings window (`Update.cs` 1272-1276) then opens after Apply (line 119).
   5. Nothing closes it, so the `wait` after line 119 stalls ("AutoCAD busy"). All three files stall at the same place.
2. **Exact fix:**
   1. W652 line 111: `  ui2-set "Edit Pipe" "C2.FirstInvert" "18.500"` becomes `  ui2-set "Edit Pipe" "C2.FirstInvert" "18.300"`.
   2. W652_BROKEN line 104 and W653_BROKEN line 104: the same replacement.
   3. W652 line 22 (EXPECTED): "set the levels 18.500 / 18.200" becomes "set the levels 18.300 / 18.200".
   4. In the header comment at line 4, "upstream retyped 18.500, unchanged" becomes "upstream 18.300 (lowered so pit A's outlet stays at 1.50 m/s)".
3. **Arithmetic after the fix:**
   1. A to B: 0.100 over 9.550 m is 1 in 95.5; 1.502 m/s, shown as 1.50, which is not over 1.5. No window.
   2. Anchor at B is 18.20. The drop at B is measured before the save: 18.400 - 18.350 = 0.050 (`InvertPropagation.cs` 233-245 and 420-425).
   3. B to C: 18.15 / 18.05.
   4. C to D: skipped (`InvertPropagation.cs` 309-316).
   5. Result: one IL 18.15, one IL 18.05, no IL 18.10, nothing below zero. The anchor and the levels after it are unchanged.
4. **Still DERIVED after the fix:**
   1. That the empty `ui2-set` at line 98 clears the box (no run has shown it).
   2. That CE does not write a level text such as "IL -" for a blank end. The formatter writes "IL " plus the value (`PipeEndAnnotationTextFormatter`), so a blank gives "IL ", which does not match line 121.
5. **Twins after the fix:** W652_BROKEN fails on the 18.15 / 18.05 / 18.10 counts; W653_BROKEN fails on `count $ilneg = 1`. Neither stalls.

### 6. W654 and W654_BROKEN (BUG-654, hand-typed level kept, pipe runs backwards): READY TO RUN

1. **Keys while a window is open:** none.
   1. Line 105 answers the Recalculate box No. The box is asked whenever the downstream text changes ("18.050" to "18.06"), even with no pipe beyond (`Update.cs` 1949-1979).
   2. Line 118 presses Apply.
2. **Arithmetic:**
   1. Pipes are 10.000 m. Step 1 makes P82 to P83 18.150 / 18.06, which is 1 in 111. That is fine in Edit Pipe: no mismatch window there, and only flatter than 1 in 200 warns.
   2. Speed of the 100 mm pipe: 0.86 m/s at 1 in 100 and 0.81 m/s at 1 in 111. No window.
   3. Step 2: anchor 18.00, drop 0.050, start 17.95, end 17.86 by grade. The P83 end is kept at 18.06 (marked by the Edit Pipe box edit only: `Update.cs` 1586-1596; New Pipe sets no mark).
   4. Written levels are 17.95 / 18.06, a back-fall, so the BUG-654 warning (`InvertPropagation.cs` 700-705 and 801-816) is printed.
   5. P83 counts as 1 pit updated (`InvertPropagation.cs` 963-969).
3. **Proves the bug:** yes. The old build wrote the same levels with no warning line.
4. **Twin:** it fails on line 135 (18.10 / 18.06 still falls).

### 7. W655 and W655_BROKEN (BUG-655, two pipes into P83): READY TO RUN

1. **Arithmetic:**
   1. The lowest other arrival is 17.900. The lowest arrival before the save is min(17.950, 17.900) = 17.900; minus 17.880, the drop is 0.020.
   2. Outlet = 17.900 - 0.020 = 17.88; end = 17.78.
   3. Source: `InvertPropagation.cs` 380-425. The warning words are at 413-418.
   4. The cascade rewrites unchanged rows too (`InvertPropagation.cs` 467-489 and 1085-1140), so "IL 17.880" becomes "IL 17.88" and lines 104-105 find them.
2. **Twin:** a SETTING line turns the switch off. That gives 18.15 / 18.05, which fails lines 146 and 149-152.

### 8. W656 and W656_BROKEN (BUG-656, cascade re-links only the preview's pipes): READY TO RUN (risk 3)

1. **Steps:** the same as N26's first half (PASS on 3.0.88). The 4-pipe / 3-pit line and the single 1094BE endpoint line were SEEN in Tim's 3.0.88 log.
2. **Risk:** the proof rests on the twin (switch off) writing far-pipe endpoint lines on a fresh copy. That is DERIVED from PIT runs. If the twin PASSES, the pair proves nothing and must be rethought.

### 9. W657 and W657_BROKEN (BUG-657, locked level-text layer): READY TO RUN

1. **Typed AutoCAD steps:**
   1. Lines 91 and 96 use -LAYER New and Lock in the R33 form (R33 PASS on 3.0.88).
   2. Line 94 CHPROP is a typed chain that has never been run. If CHPROP ignores the pick-first selection, it ends with nothing selected and the case fails on line 88's layer check, not on a stall.
2. **Arithmetic:** anchor 18.30, B to C 18.25 / 18.15. The locked end text is checked first (`InvertPropagation.cs` 1143-1158), so neither text is written (`IlTextWriteGate`). "Nothing was changed - no pipe could be updated (P82 -> P83)" (`InvertPropagation.cs` 1011-1018 and 1050-1052).
3. **Twin:** it drops the lock and fails on lines 131-137.

## Not reviewed, said plainly

1. **Not checked in AutoCAD:** nothing here was run. Every DERIVED item above is a paper reading.
2. **Not covered by a case:** E4's four bugs (687, 688, 689, 682) and E1's BUG-292 have no files. E2's BUG-339 also has none.
