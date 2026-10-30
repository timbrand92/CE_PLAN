# B-028 BUG-587 report: Pit Schedule row grows for a long lid and remarks note (30 Oct 2026)

## ANSWER FIRST
1. **PR:** draft PR #1881 against claude/rel-20261026z, branch fb/bug587-schedule-row-height, head 2179b824cabd3f76cea90ce443d0c817fb81350f.
2. **Status:** built and unit-tested only. Nobody has opened it in AutoCAD. BUG-587 is NOT fixed and is not marked fixed. It needs a Codex look.
3. **Switch:** linking.scheduleRowGrowsForLongRemark, ON. A second switch linking.scheduleDoubleRowHidesDivider, ON, controls only the wipeout strips.

## FOR TIM
1. **What you will see differently:** in the drawn Pit Schedule (PITSCHEDULE, Place or Update placed schedule), a pit whose lid and remarks run to three lines or more no longer has its text touching the line above or running across the bottom row line.
2. **How it behaves, in the order you ruled:** first CE tries drawing the lines closer together (never closer than 1.2 times the text height between lines). If that still does not fit, that whole row becomes two rows thick (1500 high instead of 750), its text is centred, and a strip of wipeout hides the line between its two halves, as XCLMTXT does.
3. **What does not change:** every other row keeps its 750 height. A pit with a one or two line note looks exactly as before. Rows below a two-row row move down one row. If the table runs onto a second sheet, a two-row row that does not fit the end of a sheet starts the next sheet.
4. **Worked example:** P1 "Class C Grated Lid - With Step Irons" (two lines), P2 "Class C Grated Lid - CODEX CHECK With Step Irons" (three lines), P3 (no note). P1 and P3 rows stay 750 high. P2's row is 1500 high with the note inside it. P3 sits one row lower than it used to.
5. **If it goes wrong:** set scheduleRowGrowsForLongRemark to false in CD_Settings.json (group linking) and place the schedule again for the old fixed rows. Undo once removes the strips and the cells together.
6. **Nothing for you to test.** The Codex look is listed below.

## My mistakes first
1. **I inherited an unfinished attempt and its tests were wrong in one place, and my own new test was wrong in one place.** One inherited test expected four questions to the sizing rule where five are correct; my new test expected a one-row second sheet where the correct answer is two rows. Both were wrong expectations, not wrong code.
2. **I found a real bug in the inherited code by review:** the "is this the top of a sheet" test used the row number, not the slot on the sheet. With a two-row row ahead of it, a row heading the second sheet would not have repeated its pit number. Fixed, with a test (ARowPushedToTheTopOfTheNextSheetByADoubleRow_RepeatsItsPitColumns).
3. **I added two tick boxes to the Settings page, and they broke 10 tests** (the 1080p and 150 percent fit tests: the page is exactly at its height budget). I removed them; the last switch fixes (C-75, C-62) also have no Settings row. The switches and figures are in CD_Settings.json only. R-00 says every value should be on the Settings page; this is a gap for Tim to rule on, not something I could fit.
4. **Test isolation:** the rule about CE_STRUC_SUITE_APPDATA_ROOT reached me part-way. My first two focused test runs (about 19:16 and 19:48) set TEMP, TMP and CE_LOG_DIR_OVERRIDE to a scratch folder but NOT CE_STRUC_SUITE_APPDATA_ROOT. The full-suite and net48 runs had all of them. I do not know whether those two focused runs touched Structural settings; I did not look at %APPDATA%.
5. **I waited about three hours in total for a free build slot** (two other lanes were busy); I stayed within two lanes.

## What changed in the code
1. **New files:** Services/PitScheduleRowGrowth.cs (line estimate, the fit decision, the sheet and slot plan, the settings reader); ViewModels/PitScheduleViewModel.RowGrowth.cs (sizing each row, the layout-move threshold, the wipeout strips).
2. **Edited:** PitScheduleViewModel.Schedule.cs and .NetworkRedesign.cs (placement, update and redesign all use one slot plan); PitScheduleContinuationLayout.cs (slot centre, sheet-count plan); PitScheduleCellUpdatePlanner.cs and PitScheduleCellUpdateModels.cs (move a cell only when the layout moved it by 300 or more; carry the line spacing); UserSettings.cs (the seven values); REGRESSION_LOG.md.
3. **Settings values (group linking):** scheduleRowGrowsForLongRemark true, scheduleDoubleRowHidesDivider true, scheduleLongRemarkCharWidthFactor 0.75, scheduleLongRemarkMinLinePitch 1.2, scheduleRowTextMargin 50, scheduleDoubleRowMaskInset 20, scheduleDoubleRowMaskHalfHeight 25. A zero, negative or missing figure reads the shipped one.
4. **With the switch OFF:** the slot plan equals the old grid (pinned over whole grids of row and sheet counts), the planner never moves a kept cell, no strip is drawn or erased. Both start-up reads (DeserializeSettings and DeserializeSettingsTolerant) are tested ON for an empty file and for an older file, and typed false turns off only itself. I did not edit C75NewSwitchDefaultsTests (other builders' pull requests touch it); the same pins are in the new test file.
5. **Redo and protection:** no command, regen, view or system variable. A locked schedule layer is never unlocked. The strips share the schedule's own transaction. CE_SHARED untouched.
6. **Template block and continuation sheets:** each sheet's master block is stretched to the number of slots it uses (a two-row row counts as two). The continuation count is worked out from the sheets the slot plan needs. A row that heads a sheet repeats its pit's lid and remarks (BUG-798) and is measured for growth too.

## Tests
1. **Civil net10 full suite:** 20,807 passed, 32 skipped, 0 failed, 20,839 total (not 0; AutoCAD 2027 on PATH). The one PDF page test passed in the full run.
2. **New file:** Bug587PitScheduleRowGrowthTests, 34 tests.
3. **net48:** Modules/Drainage compile, 0 errors. net48 tests were not run.
4. **Build commands** all had -p:SkipDevBundle=true -nr:false --disable-build-servers. No deploy.

## What is NOT proven
1. **The line count is an estimate.** I assume an average character is 0.75 of the text height wide. AutoCAD does the real wrapping, so a note may be measured as three lines when it draws as two (a row grows when it did not need to) or the reverse. The figure is a Settings value for exactly this reason.
2. **The look of the wipeout strips** (do they hide the middle line cleanly, do they sit under the text, do they print) has not been seen.
3. **Update of an existing schedule:** a cell whose text did not change keeps its old line spacing until its text changes. A row that becomes two rows thick moves its neighbours because the move is 300 or more.
4. **Switch turned OFF after strips were drawn:** the strips stay until the schedule is placed fresh. Deleting a whole schedule is not known to erase its strips (I found no delete routine).
5. **Plot scale, a schedule on a viewport, Xref and REFEDIT cases, a locked schedule layer** were not run.
6. **Undo and save/reopen in AutoCAD** were not run.

## Robot case (for CE 02)
1. **Case name:** N35_sched_row2 (keep the style of N31_dp_time) with its switch-off control N35_sched_row2_off.
2. **N35_sched_row2 types:** open the P1/P2/P3 test drawing (two 450 x 450 pits with a note on P2, as in BUG-587), PITSCHEDULE, Place, then read the drawn cells. **Checks:** P1 to P2 column 1 text is 1125 apart in Y and P2 to P3 is 1125 apart (P2's row is two rows thick and its text is centred on it, so it sits 1.5 rows below P1 and P3 is 1.5 rows below that; with the switch off both gaps are 750); the number of WIPEOUT entities carrying xdata CE_SCHED_ROWMASK is 10 (one per column); every cell of P2's row has the same Y.
3. **N35_sched_row2_off types:** the same, with linking.scheduleRowGrowsForLongRemark false in the case's own settings copy, a fresh Place. **Checks:** P1 to P2 and P2 to P3 are both 750 apart and there are 0 CE_SCHED_ROWMASK wipeouts. If the off case passes the same checks as the on case, the check is not testing the fix.
4. **Reopen check:** QSAVE, reopen, Update placed schedule, read again: all Y values unchanged.

## Cases a Codex look needs (the drafter must SEE these)
1. **Look 1:** the P1/P2/P3 drawing placed, zoomed to the P2 row: the note is inside the row, no line passes through any letter, no row line shows between the two halves, the text sits above the wipeout.
2. **Look 2:** a pit with a very long note (about 6 lines): the row is two rows thick, the note is complete and a warning is in the CE log.
3. **Look 3:** a table of about 19 ordinary pits then a long-note pit, so the two-row row falls at the end of sheet one: it starts sheet two, sheet one's master block is the right height, the pit number repeats at the top of sheet two.
4. **Look 4:** Update placed schedule after editing P2's note: P3 and the rows below move, nothing doubles up; Undo once puts it back.
5. **Look 5 (control):** the same drawing with the switch false: the old fixed rows return.

## Hand-offs
1. **Decision for CE 04:** the Settings page is at its height budget; where should the two BUG-587 switches be shown, or does the Settings page get a second page for the fix switches (R-00)?
2. **Decision for CE 04 (low risk):** the 0.75 character width is a guess; Codex looks 1 and 2 will show whether it needs changing.
