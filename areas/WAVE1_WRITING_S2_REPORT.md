# Wave 1 case writing, job S2: BUG-779, BUG-780, BUG-782, BUG-783 (Sat 31 Oct 2026)

Writer: Opus case writer S2 (brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`). Written Sat 31 Oct 2026, afternoon, Melbourne. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, spec, driver or settings file was edited. Nothing committed, pushed or deleted. Source of every word and number: the installed build, commit `3fbb9da5` (Civil 3.0.88).

## FOR TIM

1. **Answer:** 2 of my 4 bugs now have a robot case and a "must fail" twin; 2 cannot be proved by the robot and go to a Codex look. Nobody has run any of them yet.
2. **BUG-782 has a case (W782, twin W782_BROKEN):** a pipe drawn from its LOW end, with its high end level typed by hand, then a Recalculate downstream from the pipe above it.
3. **What W782 checks, in drawing terms:** pits A, B, C in a row. Pipe B to C is drawn starting at C, then its B end is typed by hand as 18.38. Lowering pipe A to B at B to 18.30 and saying Yes to Recalculate must leave B to C reading IL 18.38 (kept) and IL 18.15 (moved down).
4. **The old fault it catches:** before the fix CE kept the wrong end: B to C came out 18.28 (your typed level overwritten) and 18.25 (the low end stuck). The twin expects that old answer and must fail.
5. **BUG-780 has a case (W780, twin W780_BROKEN):** two downpipes and a pit pipe all running into one pit, then the Pit Schedule window is read.
6. **What W780 checks:** DP1 and DP2 (100 mm) both arrive at 18.31, so the schedule merges them into one "DPs" row. The next row, the 225 mm pipe from the upstream pit at 18.53, must show 225 and 18.53, not DP2's 100 and 18.31.
7. **BUG-779 (moving the drawn schedule changes pit records): no robot case.** The robot cannot make a live drawn schedule on the test drawing, and cannot type into a schedule cell. Codex look needed.
8. **BUG-783 (Delete cell comes back as the word DELETE): no robot case.** "Delete cell" is a right-click menu item and the robot cannot press menu items. Codex look needed.
9. **Checks done offline:** the format check passes (49 files in the folder, 0 invalid) and every window control the cases use is a known one.
10. **Biggest risk in W782:** the robot has never answered CE's "drawn one way, levels say the other" question by typing UseLevelDirection. If that step goes wrong the run stops BLOCKED, which means the route is wrong, not CE.
11. **Biggest risk in W780:** the robot has never drawn a pipe starting on a downpipe (case N53 is written but unrun). If CE does not join the pipe to the downpipe, the DPs check fails and the record shows why.
12. **Nothing for you to do now.** The Opus review reads these next, then CE 02 runs them.

---

## DETAIL

### 1. Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W782_cascade_keeps_hand_level_on_pipe_drawn_from_low_end.case.txt`
2. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W782_BROKEN.case.txt`
3. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W780_schedule_row_below_merged_dps_keeps_own_pipe.case.txt`
4. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W780_BROKEN.case.txt`
5. This report.

### 2. Checks before finishing (all offline)

1. **Validate:** `case_runner.ps1 validate ...\drafts_wave1_31oct` printed `49 file(s) checked, 0 invalid` (my 4 files plus the other writers' files). Mine: W782 and W782_BROKEN 101 steps, 31 checks; W780 and W780_BROKEN 85 steps, 16 checks.
2. **Control ids:** `check_ids.ps1 -Folders drafts_wave1_31oct` printed `RESULT: every control id is known` (302 known ids, 49 files).
3. **Word scan of my 4 files:** no "print" in any form (the comment word "printed" was reworded to be sure), no 17.8 or 17.9 literal (all levels here are 18.xx and match the arithmetic below), no street, road or client name. Pits and downpipes are made-up, placed in the empty ground 148000..172000 by -82000..-58000 (J5 brief).

### 3. BUG-782: W782 and W782_BROKEN

1. **What the case does (drafter's words):**
   1. Types PIT three times, cover 19.000: A at 150000,-70000, B at 160000,-70000, C at 170000,-70000.
   2. CD from A to B, 225 mm, Standard grade, main pipe text off, 18.50 / 18.40.
   3. CD from C to B (the low end first), first box 18.25 (C), second box 18.35 (B). Start Pipe. CE asks on the command line which way the pipe runs; the case types `UseLevelDirection`. The line still starts at C, the record runs B to C.
   4. Edit Pipe on B to C: only the second box (the B end) changed to 18.38, Save. This marks the B end as typed by hand. The C end text is untouched, so CE does not ask Recalculate.
   5. Edit Pipe on A to B: 18.50 / 18.30, Save, Yes to Recalculate downstream, Apply in Cascade Preview.
   6. Must be true at the end: "[CDEDIT-CASCADE] Updated 1 pipes and 1 pits from ... (IL 18.30). Min grade: 1:", "[CDEDIT-CASCADE] 1 level(s) you set by hand were kept as they were, on ", exactly one IL 18.38 and one IL 18.15, no IL 18.28 and no IL 18.25, log line "IL=18.30 pipes=1 pits=1", no CE window open, drawing file unchanged.
   7. Checked in between: the New Pipe boxes really held 18.25 / 18.35; CE said "but the entered levels indicate"; after step 4 the texts read one IL 18.38, one IL 18.25, no IL 18.35, and no Recalculate window opened.
2. **Code the words and numbers come from (3fbb9da5):**
   1. `Rules/PinnedEndMap.cs` 11-15: the hand marks are read as From = upstream, To = downstream, whatever the drawn direction (the fix).
   2. `Services/LinkService.RepairAudit.InvertPropagation.cs` 54-66 (reads the hand marks), 469-478 (BUG-782 mapping into the plan), 222-245 (the edited pipe counts at its level BEFORE the save), 257-258 (switch linking.cascadeKeepsPitDrop), 329 (existing fall), 378-427 (the leaving pipe starts one existing pit drop under the lowest arriving level), 443 (new downstream = new upstream minus the pipe's own fall), 903-916 (texts and record from one keep decision), 945-952 (record written by flow), 1037 (the "kept" line), 1039 (the "Updated" line), 1040 (the log line).
   3. `Services/CdDrawFirstFlowService.cs` 75-82 (a pipe drawn against its levels needs a decision), 101-103 (the "Pipe was drawn ... but the entered levels indicate ..." words), 119.
   4. `Commands/CdCommand.cs` 166-178 and 259-300 (the question comes on the command line after Start Pipe, keyword UseLevelDirection; written at 268), 853 (no Uphill box for a pipe drawn pit to pit).
   5. `Commands/PipeEditCommand.Update.cs` 1550-1596 (a changed box marks its own end as typed by hand; an untouched end keeps its mark), 1947-1981 (Recalculate is asked only when the downstream text changes, by exact text compare: line 1957).
   6. `Commands/PipeEditCommand.DataCollection.cs` 260-272 (Edit Pipe shows levels on their drawn ends, so the first box of a pipe drawn from C is the C end).
3. **Arithmetic (derived, never seen on a run):**
   1. Each pipe is 10 m centre to centre, about 9.55 m wall to wall (225 mm into each 450 pit wall). A fall of 0.10 is about 1 in 96, steeper than 1 in 100; Standard grade never opens the Grade mismatch window.
   2. B to C after step 4: B end 18.38 (hand), C end 18.25, own fall 0.13.
   3. Anchor B at 18.30. Lowest pipe arriving at B before the save: A to B at 18.40. Existing drop at B = 18.40 - 18.38 = 0.02. Planned B end = 18.30 - 0.02 = 18.28. Planned C end = 18.28 - 0.13 = 18.15.
   4. Fixed build: the hand level is the upstream end, kept: written 18.38 / 18.15. Min grade about 9.55 / 0.23 = 1 in 42 (not asserted; length not read).
   5. Old build: the hand mark landed on the downstream end: written 18.28 / 18.25. The "kept" line came out the same, so only the texts tell the two apart.
   6. All levels are typed with two decimals so the stored, shown and plan texts are the same string; this matters because the Recalculate check compares text exactly.
4. **Derived but never seen on a run:** every cascade number above; the UseLevelDirection answer being accepted; the first Edit Pipe box being the C end; no Recalculate box at step 4.
5. **What the twin breaks:** W782_BROKEN changes only the four after-cascade level checks to the old answer (18.38 none, 18.15 none, 18.28 one, 18.25 one). No switch exists for this fix, so the twin works like the N33a twin: it states the old result and must fail on those four checks on 3.0.88.
6. **What a Codex look must see if the robot cannot:** after the cascade, zoom to pits B and C: the B end of pipe B to C reads IL 18.38 and the C end IL 18.15. The flow arrow still points B to C. A screenshot plus the command-line text "1 level(s) you set by hand were kept".
7. **Not covered:** CDPROPAGATE with Keep (the bug's own route) needs an entity pick on the anchor pit, an unproven route (same note as W652). Same mapping code, so W782 proves the fix; Codex can look at CDPROPAGATE separately.

### 4. BUG-780: W780 and W780_BROKEN

1. **What the case does (drafter's words):**
   1. PIT twice, cover 19.000: Y at 160000,-60000 (upstream), X at 160000,-70000.
   2. DP at 150000,-66000 (DP1) and DP at 150000,-74000 (DP2), each with one Esc.
   3. CD DP1 to X and DP2 to X: 100 mm, Standard grade, text off, 18.51 / 18.31 each.
   4. CD Y to X: 225 mm, 18.73 / 18.53. CD X to an open end at 170000,-70000: 225 mm, 18.21 / 18.11 (X's outlet).
   5. PITSCHEDULE, read every row and cell, Close.
   6. Must be true: 4 pipes and 2 downpipes drawn; "Downpipe placed. Tag: DP1." and "... DP2."; a row with FROM DPs, DIA 100, IL 18.31; a row with FROM <Y's number>, DIA 225, IL 18.53; no row with a P-number FROM and 100 / 18.31; the window closed; drawing file unchanged.
2. **Code the words and numbers come from (3fbb9da5):**
   1. `Services/PitScheduleBuilder.cs` 118 and 198-222 (FROM label: P + digits keeps its number, DP1 becomes DP), 282-334 (the merge: same label and same level text gives one row with "s" added, line 326; each kept row carries the index of the first inlet of its group when the switch is on), 301-303 (P + digits never merged), 427-468 (IL shown = stored level text at that pit), 661-670 (inlets in level order, ties in drawing order), 938-951 (outlet chosen by levels), 1067-1091 and 1110-1122 (size shown as whole millimetres).
   2. `ViewModels/PitScheduleViewModel.Data.cs` 305-322 (BUG-780: each row takes its own source pipe), 360-366 (FROM, DIA (Inlet), IL (Inlet) from that pipe).
   3. `Models/UserSettings.cs` 831-837 (linking.scheduleMergedRowsKeepOwnPipe, default on), 807-813 (linking.scheduleFromKeepsPitNumber, default on).
   4. Row text shape: `ui_map\w3_pit_schedule.txt` lines 120-141 (column order), N11 rows such as "P4=P4 | 450=450 | 17.30=17.30".
3. **Arithmetic and lengths:**
   1. DP to X: about 10.77 m centre to centre less 225 mm = 10.55 m, fall 0.20, about 1 in 53.
   2. Y to X: 9.55 m, fall 0.20, about 1 in 48.
   3. X to open end: 9.775 m, fall 0.10, about 1 in 98 (steeper than 1 in 100).
   4. X's inlets in order: DP1 pipe 18.31, DP2 pipe 18.31, Y pipe 18.53. Merge gives DPs (source 0) and Y (source 2 with the switch on, position 1 with it off).
   5. Fixed: second row 225 / 18.53. Old (switch off): second row 100 / 18.31 (DP2's pipe), Y's own pipe missing.
4. **Derived but never seen on a run:** the two rows; CD starting on a downpipe joining to it; the window dump reaching pit X's rows (N09 and N29 read rows down to C1 at the bottom, so the whole grid has been readable).
5. **What the twin breaks:** W780_BROKEN turns linking.scheduleMergedRowsKeepOwnPipe OFF (the old pairing). It must fail on the 225 / 18.53 row check and on the "no P row at 100 / 18.31" check. The DPs row still passes.
6. **What a Codex look must see if the robot cannot:** the Pit Schedule window, pit X's two rows: DPs 100 18.31, then the upstream pit 225 18.53.
7. **Not covered:** the drawn table and the CDDESIGN redesign review (the other two copies of the pairing), and an edit on that row going to the right pipe (grid cells have no control ids).

### 5. BUG-779: no case (Codex look)

1. **Why the robot cannot prove it:**
   1. The fault needs a LIVE drawn schedule cell whose text differs from the record (an override typed in the window, or a 3-decimal cover drawn as 2 decimals), then a MOVE of the table.
   2. The drawn table already in DRV1_B1 is stale for this copy: runs print "Pit schedule cell for P3 (inlet pipe size) not updated: the pit or pipe it was placed for no longer matches this drawing" (242 times in the reports). For such cells `ScheduleLinkService.cs` 211-219 (`EditedCellMayChangeRecord`, 473-477) returns before the BUG-779 decision on old and new builds alike, so a MOVE proves nothing.
   3. A fresh table cannot be placed: "Continue to Place / update" is disabled on DRV1_B1 in `ui_map\w3_pit_schedule.txt` (lines 625, 673, 682; "Update existing schedule" 755). It is gated by `PitScheduleWorkflowState.cs` 37-38 (no blocking differences). This map is from 3 Oct; not re-read on 3.0.88.
   4. An override needs typing into a grid cell; the cells have no control ids (map lines 143-163) and no case has ever set one.
   5. A 3-decimal cover on an existing pit needs Edit Pit "Save pit and close"; the runner's format check refuses any press containing the word Save for ui2-press, and v3's list for "Creative Engineering*" presses only Cancel or Close.
2. **What the fix does (for the Codex brief):** `Services/ScheduleCellEditDecision.cs` 25-34 (a cell still showing CE's text changes nothing; an overridden cell is put back with a message), 41-58 (a level within 5 mm of the stored figure, or the same size, is left alone), 84-86 (the message "This Pit Schedule cell (...) shows a figure typed in the Pit Schedule window, so CE did not write it into the pit or pipe. Change it in PITSCHEDULE."); `Services/ScheduleLinkService.cs` 231-265 and 454-459; switch linking.scheduleMoveKeepsRecords (`UserSettings.cs` 791-797).
3. **What a Codex look must see:** on a copy with a freshly placed schedule: override P3's cover to 21.50 in the window, close, MOVE the whole table; P3's cover in Edit Pit still reads its real value and the plan label is unchanged. Then type a new figure into the overridden drawn cell: the cell goes back and the message above appears. Switch off control: the old write-back returns.
4. **What would unlock a robot case:** a wave 2 fixture whose drawn schedule belongs to the copy (placed on the current build, nothing blocking), plus a known route to edit one cell.

### 6. BUG-783: no case (Codex look)

1. **Why the robot cannot prove it:**
   1. The route is the Pit Schedule cell right-click menu, item "Delete cell" (restored by BUG-1031, switch linking.pitScheduleDeleteCellMenu, `UserSettings.cs` 765-772). Neither v2 nor v3 has a step for a context menu item.
   2. The drawn half (cover cell reads DELETE after PITEDIT) also needs a live drawn table, blocked on DRV1_B1 as for BUG-779.
   3. Typing an empty value into the cell would be a different path from "Delete cell", so it would not prove this fix.
2. **What the fix does (for the Codex brief):** `Services/ScheduleCellOverrideText.cs` (DELETE is a marker for blank, never shown), `ViewModels/PitScheduleViewModel.Filters.cs` 58 (shown blank in the window), switch linking.scheduleDeleteCellStaysBlank (`UserSettings.cs` 774-780). Fix rounds b27b96b6 and 28996088 (deleted Remarks never print "DELETE With Step Irons").
3. **What a Codex look must see:** right-click P3 Cover, Delete cell: blank. Place or update the table, PITEDIT P3, Save: the drawn cover cell stays blank (not "DELETE", lid not "Delete"). On a pit over 1.2 m deep, Delete cell on Remarks: the drawn cell reads "With Step Irons" only. Then CDDESIGN redesign Apply does not refuse with "edited directly or out of date".

### 7. Could not write, and faults noticed (names only, nothing edited)

1. **Could not write:** BUG-779 and BUG-783, reasons in sections 5 and 6.
2. **Fault worth a look, DRV1_B1 fixture:** its drawn Pit Schedule cells are stale for every robot copy ("no longer matches this drawing"). Any case that claims to prove a drawn-table behaviour on this fixture proves nothing for those cells. Wave 2 should make a fixture with a live drawn schedule.
3. **N53_cd_from_dp_joins_downpipe (drafts_next40_a_30oct):** still unrun, so "CD started on a downpipe" is unproven; W780 and N53 share that risk. Run N53 first if possible.
4. **W653_BROKEN in this folder** has no W653 main case beside it at the time I checked (another writer's job, possibly still writing).
5. **ui_map w3_pit_schedule.txt** is from 3 Oct (older build); the disabled state of "Continue to Place / update" on 3.0.88 is not re-read. A one-line v3 ui-dump probe would settle it.
