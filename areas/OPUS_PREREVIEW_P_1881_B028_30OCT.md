# Opus pre-review P: PR #1881 (B-028, BUG-587, a Pit Schedule row grows for a long lid and remarks note)

Written Friday 30 October 2026 by an independent read-only Opus reviewer for CE 00.
Head reviewed: 2179b824 (branch fb/bug587-schedule-row-height), one commit on top of claude/rel-20261026z at 09126560 (the merge base is that tip exactly).
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code and ran read-only merge checks only.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, train C-79 (FULL class).** It is built and unit-tested only. Nobody has opened it in AutoCAD, and BUG-587 stays OPEN.
2. **What you will see:** a pit whose lid and remarks note runs to three lines or more gets a row twice as tall (1500 instead of 750). The note is centred in it, and white strips hide the line across the middle of that row. The rows below drop one row. Every other row stays 750.
3. **Your first choice (draw the lines closer) will never happen on the real schedule.** With 250-high text in a 750 row, three lines only fit at 0.8 times the text height between lines, and the shipped minimum is 1.2. So every note of three lines or more goes straight to a double row, and a two-line note was already fine. That is just the geometry, not a fault.
4. **One fault to fix before it is installed.** If the double row ever looks wrong on a job and someone turns the switch off and presses Update, the table does not go back. The cells stay where the double row put them, the table frame shrinks one row and the white strips stay. The bottom pit then hangs below the frame. The only way out is to erase the schedule and place it again. This is a small fix and I have written it up for the finaliser.
5. **The switches and five figures are in the settings file only, not on the Settings page.** You are already being asked where they should go (QUESTIONS_FOR_MONDAY item 75), and I recommend the same new "Switches" tab. Add the five figures to that question; they are file-only too.
6. **Still not seen by anyone:** whether AutoCAD wraps the note where CE expects; whether the white strips show a thin outline around each strip; how the strips plot to PDF; Undo and Redo; save and reopen. The robot case and the five Codex looks below cover these.

---

## DETAIL

### 1. What happens to the schedule

1. **The plan:** before anything is drawn, CE works out a sheet and a row slot for every row (`Services/PitScheduleRowGrowth.cs` 261-287, `PitScheduleSlotLayout.Build`). Placement, Update placed schedule and the network-redesign rewrite all call the same plan: `PitScheduleViewModel.Schedule.cs` 1287 (place) and 1096 (update), and `PitScheduleViewModel.NetworkRedesign.cs` 252 (redesign). One plan for all three paths is good: it follows design rule #1.
2. **Row heights:** only the first row of a pit, or a row that heads a new sheet, is measured, and only the lid and remarks column (column 10, 4200 wide, text 250) is measured (`PitScheduleViewModel.RowGrowth.cs` 44-81). A row is one slot (750) or two slots (1500). Nothing grows past two (`MaxRowSpan`, `PitScheduleRowGrowth.cs` 55). An over-long note still draws at two rows, and CE writes a warning to its log (`RowGrowth.cs` 73-79).
3. **Text position:** every cell of a two-row row is centred on the middle of its two slots (`Schedule.cs` 1325 and 1446, `GetSlotCentreDrop`, `CentreSlot` in `PitScheduleRowGrowth.cs` 213). I checked the arithmetic. The first row centre is 375 below the table top (`YStart = -375`, `PitScheduleViewModel.cs` 37), so the line between slots s and s+1 is at the table top minus (s+1) x 750. The strips are drawn at exactly that height (`RowGrowth.cs` 230-232).
4. **Do the rows below move?** Yes. Every row after a two-row row drops 750 on that sheet. On Update, a cell that the new layout moves by 300 or more is moved (`PitScheduleCellUpdatePlanner.cs` diff, threshold `ReflowThreshold = 0.4 x 750 = 300`, `PitScheduleContinuationLayout.cs`). The REGRESSION_LOG entry and the `UserSettings.cs` comment both say "an existing schedule does not move". That is true only for a schedule with no long notes. An existing schedule that has a long note does move on its next Update. That is the intended effect, but the wording should be corrected.
5. **Sheet breaks:** a two-row row that does not fit what is left of a sheet starts the next sheet (`PitScheduleRowGrowth.cs` 272-279). Each sheet's master block is stretched to the slots it uses (`Schedule.cs` 2166 and 2177). The sheet-count plan comes from the slot plan (`BuildChangePlanForSetCount`, `PitScheduleContinuationLayout.cs`). A continuation sheet still sits at the same fixed drop below the first (`GetSheetOffset`, unchanged). A grown row can therefore add a continuation sheet one row earlier than before. That sheet appears at the usual place below the table, which may fall outside a viewport or title-block frame the drafter set up. This is existing behaviour, now triggered sooner.
6. **The pit number at the top of sheet 2:** the "top of sheet" test now uses the slot on the sheet, not the row number. This applies to placement (1298), desired cells (1428) and the link row (`LinkRowFor`, about 1766). The in-job review found this one and it is right. A side effect, pinned by the test `ARowPushedToTheTopOfTheNextSheetByADoubleRow_RepeatsItsPitColumns`: the repeated note at the top of sheet 2 is the same long note, so that row is two rows thick there too.
7. **Overall table height, title block and frame:** no title block, frame, viewport or plot setting is touched. The table bottom moves down 750 for each grown row. Anything a drafter placed just below the schedule (notes, a legend) can now be overlapped. This is not checked anywhere.
8. **Other CE tools that read the schedule's geometry:** I searched for every use of the old row arithmetic (`GetRowIndexInSet`, `GetSetIndex`, `RowSpacing *`, `PitScheduleContinuationLayout.RowHeight`, `ROW NUMBERS`, `RowCount`) outside the tests. The only other reader is `IsLegacyScheduleGridPosition` (`Schedule.cs` 1954). It is used by the redesign guard to find old unlinked text, and linked cells never reach it. The cell links, CDSYNC, the Pit Schedule editor, the Design Impact snapshot and the update guard all work from links, handles and the stored rows, not from positions. Plot code is untouched. I found no reader that would misread a two-row row.
9. **Can a re-run double up strips or leave orphans?** Update and redesign first erase every strip carrying this schedule's id (xdata `CE_SCHED_ROWMASK` plus the instance id, `RowGrowth.cs` 138-161 and 184-202), then draw the new ones, so pressing Update twice does not double them. Orphans are still possible in three ways:
   - **Switch turned off:** the method returns before it looks for old strips (`RowGrowth.cs` 180), so they stay. See section 7, finding A.
   - **Schedule erased by hand:** the strips stay, just as the cells already do, because nothing watches for the block being erased. An orphan strip is white and hides whatever is later drawn under it.
   - **Schedule copied with COPY:** the copied strips carry the same id. The next Update of the original erases the copy's strips too, because the search covers all of model space (`RowGrowth.cs` 143). The cells probably share the same pre-existing limitation; I did not verify that.
10. **Is anything drawn outside the schedule's own layers?** No. The strips go on the schedule block's own layer (`authority.Layer`, `RowGrowth.cs` 242, normally `SCHEDULE`). No layer is created: `EnsureRowMaskRegApp` adds only the xdata name, `CE_SCHED_ROWMASK`, to the drawing (`RowGrowth.cs` 280-289). Everything goes in model space, the same space as the cells.

### 2. The line-count estimate (0.75 of the text height per character)

1. **How it works:** characters per line = floor(4200 / (250 x 0.75)) = 22. The note is then word-wrapped at 22 characters, and `\P` and line breaks start new lines (`PitScheduleRowGrowth.cs` 71-120).
2. **Why it can be wrong:**
   - **Font:** the cell is drawn in the drawing's *current* text style at the moment of placing or updating (`TextStyleId = db.Textstyle`, `Schedule.cs` 1339 and 1667). CE does not know that style's font or width factor.
   - **Narrow and wide letters:** a lower-case-heavy note in a TrueType font such as Arial averages roughly 0.5 to 0.55 of the text height per character. That gives about 30 to 33 characters per line, so CE over-counts. An all-capitals note in a stroke font can average 0.8 or more, about 20 to 21 per line, so CE under-counts. These are my rough estimates, not measurements.
   - **Formatting codes:** any inline codes in the contents, such as font or height overrides, are counted as letters.
3. **If it counts too few lines:** a note that really draws as three lines is treated as two. The row stays 750 and the text crosses the lines exactly as it does today. That is no worse than now, but BUG-587 is not fixed for that note.
4. **If it counts too many lines:** a note that draws as two lines gets a needless double row. The table is 750 longer and the rows below move. It may also start an extra continuation sheet. With Arial-like fonts, notes of roughly 45 to 65 characters fall in this band.
5. **The robot drawing sits right on the edge.** P1 "Class C Grated Lid - With Step Irons" is 35 characters, counted as two lines. P2 at 47 characters is counted as three. A different current text style could flip either one. The robot case must record which text style was current.
6. **A safer measure:** let AutoCAD do the wrapping. Create the remark cell with its real style, width and contents inside the same transaction, read its real height, and decide the row from that. The current estimate would stay as the fallback when the real height cannot be read. I have not verified that the real height can be read at that point, so prove it first with the existing accoreconsole plugin probe (memory note "accoreconsole plugin probe"). Until then, the 0.75 figure stays in the settings file for tuning, and Codex looks 1 and 2 will show whether it is close.

### 3. Native AutoCAD protection rule

1. **Locked layer:** CE never unlocks anything; I searched the new code for unlock calls and found none. If the schedule block's layer is locked, no strips are drawn and the command line gets one line: "[CE] Some row lines inside a two-row remark were left showing ..." (`RowGrowth.cs` 206-208 and 277-278). An old strip on a locked layer is skipped, not erased (`RowGrowth.cs` 195-199).
2. **One edge case:** if an old strip sits on a different, locked layer (a drafter moved it) while the block's own layer is unlocked, the old strip stays and a new one is drawn as well. That is low risk.
3. **What else happens when the schedule layer is locked:** stretching the master block on a locked layer is a pre-existing step (`Schedule.cs` 2163-2177). As I understand AutoCAD's .NET rules it would refuse, so the whole Update would stop and nothing would change. I have not verified this in AutoCAD.
4. **Xref and REFEDIT:** the strips are created only in the current drawing's model space, beside the cells. Nothing reaches into an Xref. Update already refuses while REFEDIT is open (`Schedule.cs` 1076-1080, pre-existing). The placement path has no REFEDIT check of its own. That gap is pre-existing and was not added by this PR, but the new strips now follow the same path as the cells.
5. **Nothing bypassed:** no layer is unlocked, no Xref is detached, nothing is exploded or cloned. The rule is respected, with the warning-not-block behaviour of R-27.

### 4. Wipeout strips: look, plot and Undo

1. **Layer and colour:** the strips are on the schedule block's layer with the drawing's default properties (`SetDatabaseDefaults`, `RowGrowth.cs` 313-317), so their colour comes from the layer. A strip is 50 high (25 each side of the line, from the settings file). Each one stops 20 short of every column line, so the column lines stay unbroken (`RowGrowth.cs` 233-238).
2. **Small marks at each column line:** because of that 20 gap on both sides, about 40 of the middle line still shows at each of the ten column lines, like tick marks. Whether that reads as clean or as a fault is for a Codex look to judge.
3. **Strip outlines (WIPEOUTFRAME) are the biggest visual unknown.** The code deliberately sets no system variable. If a drawing has the AutoCAD system variable WIPEOUTFRAME set to 1, each strip shows and plots its own rectangle outline. That draws ten little boxes across the row, which is worse than the single line it hides. With WIPEOUTFRAME at 2 the outlines show on screen but do not plot; at 0 they do not show at all. XCLMTXT's strips are affected in the same way. Codex must record WIPEOUTFRAME in every look and repeat Look 1 with it at 1.
4. **Background:** a strip hides with the background colour. On a dark model-space screen it hides in dark, and on a white plot it hides in white; both should be fine. A plot style or PDF setting that does not paint a white page, or a coloured paper background, is untested. Nothing here is specific to dark theme.
5. **Draw order:** the strips are moved to sit just above each sheet's master block (`RowGrowth.cs` 256-270, `DrawOrderTable.MoveAbove`), so cell text stays on top. Two notes on this:
   - **A crash warning in XCLMTXT's own code:** XCLMTXT itself, the precedent Tim named, does NOT change the draw order. Its code says draw-order changes "have been the likeliest remaining unmanaged crash trigger" and relies on creation order instead (`Modules/Structural/Services/ExcelMTextService.cs` 4795-4797). Civil already makes undo-recorded draw-order moves in pit and pipe edits (comment in `Modules/Drainage.HeadlessProof/UndoChecks.cs` 625-626), so this is not new to Civil. It is still the riskiest line in the PR. The robot run should watch for a fatal error, and so should the U and REDO steps.
   - **Strips can sit above older text:** a strip sits directly above its sheet's master block. If a continuation master is created by a later Update, it is newer than cells that already existed. A cell that existed before and moves onto that new sheet in a two-row row would then sit *under* the strip. The strip would cut through the middle of that note, because the note is centred on the hidden line. This is low frequency (a schedule that grows from one sheet to two on an Update, with a double row on sheet 2) but visible.
6. **XCLMTXT precedent, other differences:** XCLMTXT inserts the office's own `WIPEOUT` block from `WIPEOUT.dwg` (`ExcelMTextService.cs` 3357-3360 and 4114-4121), not raw wipeouts. It also gives a double-height cell a double box height (`BoxHeightDouble`, 4128-4135). Here, every cell, including a two-row one, gets the ordinary 750 box height (`TrySetMTextBoxHeight(mtext, column.BoxHeight)`, `Schedule.cs` 1341 and 1669). I cannot say whether that changes how AutoCAD centres the note (rule 12.5). It is cheap to give a two-row cell a box of 1500 to match XCLMTXT; that is optional.
7. **Undo:** the strips are made inside the same transaction as the cells for placement (`Schedule.cs` 1364, before the commit at about 1374), update (1131) and redesign (`NetworkRedesign.cs` 282). So one U should take the strips and the cells together; this is verified from the code only. A whole fresh placement may already cost more than one U, because the block is inserted in an earlier transaction (see `EraseFailedScheduleBlock`, `Schedule.cs` 1387); that is pre-existing. The BUG-587 entry asks for "one Undo / delayed Redo", and nothing here proves Redo.

### 5. Settings-first (R-00)

1. **What is file-only:** the two switches `linking.scheduleRowGrowsForLongRemark` and `linking.scheduleDoubleRowHidesDivider`. So are the five figures: `scheduleLongRemarkCharWidthFactor` 0.75, `scheduleLongRemarkMinLinePitch` 1.2, `scheduleRowTextMargin` 50, `scheduleDoubleRowMaskInset` 20 and `scheduleDoubleRowMaskHalfHeight` 25 (`UserSettings.cs`, linking group). All seven ship ON or at their shipped figures. Both start-up reads are tested.
2. **The cost:** if the estimate misbehaves on a job, a drafter has no visible way to turn the double row off or to tune the 0.75. The only route is hand-editing `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. This breaks R-00 for seven values. The 0.75 figure is the one most likely to need tuning per office font.
3. **Already asked:** I checked `C:\CE_PLAN\QUESTIONS_FOR_MONDAY.md` item 75. It already asks where file-only switches go and lists these two. It does not list the five figures, so add them there rather than asking Tim again.
4. **Options for Tim (no collapsed expanders):**
   - **(a) RECOMMENDED, the same as item 75:** a new Settings tab "Switches". It holds every new on/off switch as a plain-English tick list, plus a "Pit Schedule long notes" group with the five figures. The list may scroll.
   - **(b)** Move the existing "Pit Schedule fixes" column off the "Fixes" tab into its own "Pit Schedule" tab. That frees room on "Fixes" and keeps every schedule value together.
   - **(c)** Add them to the "Newer tools" tab, which already scrolls (`CivilSettingsView.xaml` 220-221). This is cheapest, but schedule values would be split across two tabs.

   Any of these is a Settings-engine change, so it forces a FULL re-test under the re-test rule.

### 6. Clashes and test isolation

1. **claude/rel-20261102a (91963bd0):** the read-only `git merge-tree` shows one conflict, `REGRESSION_LOG.md`. Both sides add an entry at the top, so it is trivial to resolve. `UserSettings.cs` auto-merges.
2. **No logic clash with rel-20261102a:** in the merged tree, every caller of the changed signatures (`SynchronizeScheduleMastersInTransaction`, `PitScheduleCellUpdatePlanner.Build`) is one this PR already updated. rel-20261102a changes `PitScheduleViewModel.cs` only by adding `ShowDeleteCellMenuItem` (BUG-1031), and does not touch the schedule services.
3. **Open PRs:** I checked #1857 (718ec21c), #1868 (38c3f825), #1871 (0b8698eb), #1872 (336bc513), #1873 (ba299320), #1874 (1b8b4af1), #1875 (107a6a74), #1876 (d30041c4), #1877 (b9842f28) and #1878 (f0500eda). Each conflicts with #1881 only in `REGRESSION_LOG.md` (top-of-file entries). Each auto-merges `UserSettings.cs`. #1871 (BUG-1255) also auto-merges `PitScheduleViewModel.Schedule.cs`: its change is in the Excel export around lines 136-170, far from this PR's lines. No real code conflicts.
4. **The base is old:** #1881 is built on rel-20261026z. rel-20261102a is 166 files ahead, including `SettingsWindowV3Tests.cs` and the C-76 and C-77 switch tests. The full suite must be re-run on the C-79 base. A green run on 26z says nothing about 02a.
5. **Test isolation, the new tests:** the 34 new tests are pure. They build plans in memory, read settings from JSON strings and read source files for the guards. None writes a file. Code they reach reads `SettingsService.Current`, which goes to a temporary folder when CE_LOG_DIR_OVERRIDE is set (`SettingsService.cs` 46-52). The author set that variable in all runs.
6. **The two focused runs without the Structural root variable:** the Civil test project references Drainage and Manager only, not Structural (`Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj`). So a Civil-only focused run is unlikely to have touched Structural's settings. I did NOT look at `%APPDATA%`, and I cannot rule out a Manager-side write. If the desk wants certainty, compare the modified times of the Structural settings and log files against the 19:16 and 19:48 runs. That check is for the desk, not this review.

### 7. What is NOT proven, findings, and the AutoCAD scenario

**Findings, in order of importance:**

1. **A. Turning the switch off does not restore an already-drawn schedule (fix before install).** With the switch off, `ResolveLayoutReflowThreshold` returns 0 before it looks at the existing cells (`RowGrowth.cs` 93-94). So the cells keep their grown positions, because the planner only moves a cell when its row order changes. The master block is stretched back to the plain row count (`Schedule.cs` 2166). `RebuildRowMasksInTransaction` also returns before it finds the old strips (`RowGrowth.cs` 180).

   The result: the last row's cells hang one row below the frame, and strips hide real lines between different pits. The author's report mentions only that the strips stay.

   Suggested fix, about ten lines: when the switch is off but this schedule still has `CE_SCHED_ROWMASK` strips (proof it was grown), erase them and use the 300 move threshold once, so the cells return to the plain grid. A schedule that never grew still gets exactly the old behaviour.
2. **B. The draw-order move** goes against XCLMTXT's own crash note (section 4, item 5). Keep it, but have the robot watch for it.
3. **C. Strips above older text** on a continuation sheet created by a later Update (section 4, item 5). This is low risk. A fix is to move the grown row's own cells to the top of the draw order after the strips. That is another draw-order write, so weigh it against B.
4. **D. A drafter's own nudge of 300 or more is reset** on Update whenever the schedule has a two-row row (`RowGrowth.cs` 95-96 and 99-109). Before this PR, every hand-placed cell was kept exactly. Smaller nudges are still kept. This is acceptable, but it should be in the REGRESSION_LOG entry.
5. **E. The "draw the lines closer" step is dead at the shipped figures** for this column (section FOR TIM, line 3). The test `ThreeLines_AtTheShippedFigures_CannotBeSqueezedIn_SoTheRowTakesTwoRows` pins it. Only the test with a 900-high row exercises that step.
6. **F. The tightened spacing is never undone.** If a note was drawn tighter (only possible for five or more lines, at 0.72) and is later shortened, the cell keeps 0.72, because the null spacing is never written back (`Schedule.cs` 1693-1698). This is cosmetic.
7. **G. A self-checking test:** `TheWipeoutStripsStayInsideTheColumnsAndTheTableEdge` checks that the strips match CE's own column list. It does not check them against the real lines in the master block. Whether the block's left edge really sits at the insertion point plus 100 is not proven anywhere.

**NOT proven (beyond the author's list, which is accurate):**

1. The real wrapping against the estimate, in the office's current text style.
2. Strip outlines (WIPEOUTFRAME), and the tick marks at the column lines.
3. PDF and plot output, and plot scale.
4. A dark screen background.
5. One U, delayed REDO, then QSAVE and reopen.
6. Locked SCHEDULE layer, REFEDIT open, and the schedule seen through an Xref.
7. Drawings in metres.
8. AutoCAD 2024 (net48): it only compiled, and its tests were not run.
9. The switch-off update (finding A).
10. COPY of a schedule.

**Robot case N35_sched_row2 (the author's design is sound; additions marked NEW):**

1. Open a copy of the P1/P2/P3 drawing. **NEW:** record the current text style and WIPEOUTFRAME in the case log.
2. PITSCHEDULE, Place.
3. Check that P1 to P2 and P2 to P3 are both 1125 apart in Y on column 1, that every cell of P2's row has the same Y, and that there are 10 WIPEOUT entities with xdata `CE_SCHED_ROWMASK`.
4. **NEW:** Update placed schedule twice. There must still be exactly 10 strips and the Y values must be unchanged (no doubling).
5. **NEW:** one U, then check that the strip count and the cells are back to the state before the Update. Then a delayed REDO, and check again.
6. QSAVE, close, reopen, Update. All Y values must be unchanged.
7. **NEW (records finding A):** set `scheduleRowGrowsForLongRemark` to false in the case's own settings copy, then Update, not a fresh Place. On today's code, expect cells still 1125 apart and 10 strips left. After the fix, expect 750 apart and 0 strips.
8. **Control N35_sched_row2_off:** switch false, fresh Place. Expect 750 and 750, and 0 strips.
9. **Old-build check (rule 4.5, Claude-accepted condition 2):** N35_sched_row2 must FAIL on the installed C-78 build (gaps 750, 0 strips).

**The five Codex looks (the drafter must SEE these):**

1. **Look 1:** P1/P2/P3 placed, zoomed to P2's row. The note is inside the row, no line passes through a letter, and the middle line is hidden behind the note. Note how the tick marks at the column lines look. Do this once with WIPEOUTFRAME as found and once at 1 on the copy.
2. **Look 2:** a pit with a note of about six lines. The row is two rows thick, the note is complete, and the CE log has the warning. Say whether the last line crosses the bottom line.
3. **Look 3:** about 19 ordinary pits, then a long-note pit. The double row starts sheet 2, sheet 1's frame is the right height, and the pit number repeats at the top of sheet 2.
4. **Look 4:** edit P2's note, then Update placed schedule. P3 and the rows below move and nothing doubles up. One U puts it back. **NEW:** plot to PDF and look at P2's row in the PDF.
5. **Look 5 (control):** with the switch false on a fresh Place, the old fixed rows come back. **NEW:** also the switch false on an Update of an already-grown schedule (finding A).

### 8. Verdict

1. **KEEP-WITH-NOTE.** The design follows Tim's ruling (29 Oct, QUESTIONS 21e). It uses one plan for place, update and redesign, has warnings rather than blocks, unlocks nothing, adds no system variable and leaves CE_SHARED untouched. The arithmetic checks out.
2. **Fix before install (finaliser or a follow-up commit on this PR):** finding A, the switch-off recovery.
3. **Wording fixes:** correct "an existing schedule does not move" in REGRESSION_LOG and in the `UserSettings.cs` comment, and add finding D.
4. **Train:** C-79, FULL class. It changes the Settings model (seven new linking values) and all three schedule drawing paths. It needs a rebase onto rel-20261102a (only the REGRESSION_LOG clash) and a full Civil re-run there.
5. **BUG-587 stays OPEN** until the robot case passes twice and a Codex look passes (rules 4.5 and 13.3).
