# Wave 1 case writing, job E1 (group E: Edit Pipe, flow direction, size-only save, levels after repair)

Writer: Opus, Team job E1, Sat 31 Oct 2026 (Melbourne). Installed build read: Civil 3.0.88 at 3fbb9da5 (origin/claude/rel-20261102a). Nothing was run in AutoCAD; no build, no test, no commit.

## Answer first

1. **Result:** 3 of my 4 bugs have a case and a twin: BUG-223, BUG-261, BUG-278. BUG-292 has no case.
2. **Files:** 6 files in `_ACAD_DRIVER\cases\drafts_wave1_31oct\`: W223 + W223_BROKEN, W261 + W261_BROKEN, W278 + W278_BROKEN.
3. **Offline checks:** validate 30 files, 0 invalid. check_ids: every control id is known. No "print", no 17.9, no street name in my files.
4. **Why BUG-292 has no case:** it needs a pipe whose drawn ends store NO level while its record does. Every pipe CD draws stores both levels on the pipe itself, so the robot cannot make that pipe on DRV1_B1. It needs a made-up wave 2 drawing with one old-style pipe, or a Codex look.
5. **One route change, said plainly:** Tim's and Codex's steps for BUG-261 and BUG-278 start with CD's "Use level direction" question. A case cannot answer that question after a window press (R31's finding). My cases reach the same stored pipe through an Edit Pipe save instead. A Codex look should still run the CD-question route once.
6. **What is already proven elsewhere:** R32v87 (PASS on 3.0.88 today) already proves BUG-223's arrow half. W223 adds the window half: the box names and the plain note.
7. **Twins:** each twin leaves out the one Edit Pipe step that turns the pipe round. All other steps and checks are identical, so it fails on a check, never on a stalled step.
8. **Robot time (an estimate):** about 5 to 7 minutes a case, so about 35 to 40 minutes for all six.
9. **Not seen on any run yet:** the window words BEFORE Save (W223), the reopened boxes after a size-only save (W261), and P8's schedule row as an INLET (W278). Each is marked DERIVED below.
10. **Could merge:** W223 and W261 use the same pipe and route. Merging them would save about 5 minutes but needs one twin for two bugs. I kept them apart.
11. **Faults noticed in existing files:** R32v87 and R32bv87 still say they are "expected to FAIL" (BUG-1222), but both PASS on 3.0.88. Carpark BUG-292 names the wrong PR. Carpark BUG-223's status line is stale. Details are in the last section.
12. **Nothing for Tim to do now.** The cases need the wave Opus review, then CE 02's robot run, then a Codex look.

## Per bug

### 1. BUG-223: Edit Pipe on a pipe between two open ends follows the typed levels

1. **Case and twin:** `W223_edit_pipe_open_ends_window_follows_levels.case.txt` (CASE W223) and `W223_BROKEN.case.txt`.
2. **What it does in AutoCAD:**
   1. Draws a 20 m pipe with CD between two empty points (150000,-90000 to 170000,-90000), 18.000 then 17.800.
   2. Opens CDEDIT. The first box must be named Upstream, with no "levels fall" note.
   3. Types 17.800 in the first box and 18.000 in the second. Before Save, the first box must read Downstream, the second Upstream, and the window must say "The levels fall from point 2 to point 1; CE records that as the flow direction." The old note "Upstream invert is lower than downstream" must be gone.
   4. Presses Save: "Pipe updated.", no "flows uphill" anywhere on the command line, and the arrow turns (rotation about 3.14).
   5. Reopens CDEDIT: 17.800 in the first box, named Downstream; 18.000 in the second; the note is still there. Then Cancel without saving.
   6. At the end no CE window is open and the drawing file on disk is unchanged.
3. **Where the checked words come from (3fbb9da5):**
   1. `ViewModels/CdViewModel.Inverts.cs` 282-313: the box names Upstream / Downstream.
   2. `CdViewModel.Inverts.cs` 400-427: two same-named ends follow the typed levels.
   3. `CdViewModel.Inverts.cs` 1036-1041: the note text, word for word.
   4. `Commands/PipeEditCommand.cs` 556: "Pipe updated.".
   5. `Helpers/ConnectedPipeFlowResolver.cs` 898-981: ResolveWithLevels.
   6. `Dialogs/PipeEditWorkshopDialog.xaml` 230 and 244: the boxes update on every key (PropertyChanged), so the window can be read before Save.
   7. Control names and the reopened values were seen in a real 3.0.88 dump: `pack_runs\ui_dumps\Creative_Engineering_Edit_Pipe_130928.json` (R32bv87, run RUN-20261031-1259-C3.0.88-bF5v). Its rows read "Edit pipe, Set first end level", then "Downstream", then C2.FirstInvert = 17.800, plus the note.
4. **DERIVED, never seen on a run:**
   1. The note and the Downstream name straight after typing, before Save.
   2. "Upstream" on the first box at the first open.
5. **Arithmetic:** 170000 - 150000 = 20.000 m, two free ends (no pit wall cut). 18.000 - 17.800 = 0.200 m, which is 1 in 100 exactly. That is not flatter than 1 in 100, so no Grade mismatch window. Same levels as R32v87, which passed on 3.0.88.
6. **The one thing the twin breaks:** the two typing steps in the first CDEDIT are left out. The window keeps 18.000 / 17.800, so the note check, the Downstream check, the arrow check and the reopen checks fail. A plain Save with nothing changed writes "Pipe updated." (R32v87's second save, PASS), so nothing stalls.
7. **Not covered:**
   1. CD's not-drawn-first branch. The New Pipe window's "Flow:" line is not shown in its 3.0.88 dump, so it is not asserted.
   2. Tim's "18.00 / 18.00, nothing reversed" step. A level pipe opens the Grade mismatch window.
   3. Pipe schedule row: two open ends have no Pit Schedule row.
8. **Codex look:** after Save, the arrow points from the 18.000 end (east) to the 17.800 end (west).

### 2. BUG-261: a size-only Edit Pipe save gives no false "flows uphill" line

1. **Case and twin:** `W261_edit_pipe_size_only_no_false_uphill.case.txt` (CASE W261) and `W261_BROKEN.case.txt`.
2. **What it does in AutoCAD:**
   1. Draws the same 20 m pipe with CD, 18.000 / 17.800.
   2. Turns it round in CDEDIT: 17.800 / 18.000, Save. The pipe now flows from its SECOND drawn end, which is the state Codex reached with "Use level direction".
   3. Opens CDEDIT again and changes ONLY the diameter, 225 to 150, then Save.
   4. Checks: "Pipe updated."; no "Creative Engineering | Design Warnings" window; no command-line line in the whole case contains "flows uphill" or the exact old wording "upstream IL 17.800 is 200mm lower"; the arrow still reads rotation about 3.14.
   5. Reopens CDEDIT: 17.800 in the first box named Downstream, 18.000 in the second named Upstream, diameter 150. Then Cancel without saving.
   6. The one pipe label reads "150 DIA. UPVC PIPE AT 1 IN 100". No CE window is left open; the drawing file is unchanged.
   7. If the old fault came back, the warning would open the Design Warnings window. The case reads the open windows straight after Save, then closes any CE window, so it fails on a check and not on a stall.
3. **Where the checked words come from (3fbb9da5):**
   1. `Commands/PipeEditCommand.Update.cs` 570-574: the BUG-261 fix. The design check now takes the recorded From level as upstream, not the first box.
   2. `PipeEditCommand.Update.cs` 598-603: each warning is written as "[CE] Warning: <message>".
   3. `PipeEditCommand.Update.cs` about 1270-1283: the warnings then open the Design Warnings window.
   4. `Dialogs/PipeValidationWarningDialog.xaml` 5: the window title "Creative Engineering | Design Warnings".
   5. `Services/DesignValidationService.cs` 320-327: the message "Pipe flows uphill — upstream IL {F3} is {mm}mm lower than downstream IL {F3}".
   6. `Helpers/ConnectedPipeFlowResolver.cs` 612: OrientLevelsForDesignCheck.
   7. The label wording and "no Warning" after a 150 size-only save were seen in R32bv87 (PASS on 3.0.88).
4. **DERIVED, never seen on a run:** the reopened boxes after the size-only save. R32bv87 dumped the window BEFORE the size change, where it already read Downstream 17.800 / Upstream 18.000.
5. **Arithmetic:**
   1. The pipe is 20.000 m long with a 0.200 m fall, so 1 in 100.
   2. The old false line for these levels: |17.800 - 18.000| x 1000 = 200, formatted with no decimals: "upstream IL 17.800 is 200mm lower than downstream IL 18.000".
   3. The label at 150 DIA reads 1 IN 100.
6. **The one thing the twin breaks:** the first CDEDIT types nothing, so the pipe is never turned round. The arrow stays at rotation 0 and the reopened first box reads 18.000, named Upstream, so the checks fail. A 150 DIA pipe at 1 in 100 opens no window (R32bv87 pipe B, PASS), so nothing stalls.
7. **Codex look:** run Codex's own V8.11 steps once. CD between two empty points, 10.00 then 11.00, answer Use level direction, Edit Pipe diameter 100 to 150, Save. There must be no "flows uphill" line, and reopening must show Downstream 10.00 / Upstream 11.00 with the arrow pointing left. That is the only way to cover the CD-question route.

### 3. BUG-278: Edit Pipe Save keeps a pipe's recorded flow; it is not turned back to drawn order

1. **Case and twin:** `W278_edit_pipe_save_keeps_flow_into_pit.case.txt` (CASE W278) and `W278_BROKEN.case.txt`. Set-up: SETUP-R47v.
2. **What it does in AutoCAD:**
   1. The set-up places pit P8 at 150000,-80000 (cover 19.000). It draws a pipe FROM P8 (18.000) to an open end at 170000,-80000 (17.800), so P8 is the upstream end.
   2. CDEDIT: the first box (P8's end) must be named Upstream.
   3. Types 17.800 at P8 and 18.000 at the open end: the first box must now read Downstream. Save: "Pipe updated.". The pipe now flows from the open end INTO P8, against its drawn direction.
   4. CDEDIT again, diameter only, 225 to 150, Save: "Pipe updated.", and no CE window is open after it. This is Tim's step 2.
   5. No "flows uphill" anywhere on the command line.
   6. Reopens CDEDIT: 17.800 named Downstream, 18.000 named Upstream, diameter 150. Then Cancel without saving.
   7. PITSCHEDULE: P8's row must list the pipe as an INLET, 150 at 17.800, with both outlet cells blank. Before the fix, the save's re-link made P8 the From end again, so the schedule listed it as P8's OUTLET.
   8. At the end no CE window is open; the drawing file is unchanged.
3. **Where the checked words come from (3fbb9da5):**
   1. `Commands/PipeEditCommand.Update.cs` 635-638: the save calls RegisterPipe with keepRecordedDirection: true.
   2. `Services/LinkService.Registration.cs` 567-572.
   3. `Rules/RecordedPipeDirectionRule.cs` 24-27: the recorded From/To is kept.
   4. `Helpers/ConnectedPipeFlowResolver.cs` 936-981: with one pit and one open end, the typed levels set the flow.
   5. `PipeEditCommand.cs` 556: "Pipe updated.".
   6. P8's real row after this set-up on 3.0.88 (R02v87 run RUN-20261031-1217-C3.0.88-bF3v, dump `Creative_Engineering_Pit_Schedule_PITSCHEDULE_122026.json`): "Pit P8= | P8=P8 | 450 x 450=450 x 450 | DET X (Grated): blank= | FROM: blank= | DIA (Inlet): blank= | IL (Inlet): blank= | 225=225 | 18.000=18.000 | 19.000=19.000 | Depth=". That is an outlet at 18.000.
4. **DERIVED, never seen on a run:**
   1. P8's row with the pipe as an inlet ("150=150 | 17.80…=17.80… | DIA (Outlet): blank= | IL (Outlet): blank="). The check accepts 17.8, 17.80 or 17.800.
   2. The FROM cell for an open-end upstream is not pinned; the check skips it.
   3. That the single inlet sits on P8's main row, not on a "pipe from" second row. If the robot shows a second row, the regex needs a rewrite, not the code.
5. **Arithmetic:**
   1. P8 is 450 x 450, so CE moves the pipe end 225 mm to the pit wall (box corner x 150225, R02v87 PASS).
   2. Length 170000 - 150225 = 19.775 m.
   3. Fall 0.200 m: 0.200 / 19.775 = 1 in 98.9. That is steeper than 1 in 100 either way round, so no Grade mismatch window.
   4. 17.800 at P8 is 1.200 m below the 19.000 cover.
6. **The one thing the twin breaks:** the first CDEDIT types nothing, so P8 stays upstream. The reopened first box reads 18.000 named Upstream, and P8's row keeps the pipe as its outlet, so the schedule check fails. Every step is one already passed on 3.0.88 (plain save, 150 DIA save, schedule open and close).
7. **Not covered:**
   1. Tim's step 3: Edit Pipe + Save on a pipe that CDFIXPIPEENDS has just repaired. This needs a 3.0.16-damaged copy; no made-up fixture has one (wave 2).
   2. Tim's step 4 (one U after Save) and save, close and reopen of the drawing.
   3. The arrow (BUG-278's fix does not touch it).
8. **Codex look:**
   1. Tim's steps 1 and 2 exactly, through CD "Use level direction".
   2. The arrow points into P8.
   3. One U after the Save puts everything back.

### 4. BUG-292: Edit Pipe filled blank level boxes in record order: NO CASE

1. **Why no case:** the faulty fill only runs when the pipe stores NO level at its drawn ends but its record does.
   1. `Commands/PipeEditCommand.DataCollection.cs` 84-85 reads the pipe object's own two levels first.
   2. Lines 101-106 fill blank boxes from the record.
   3. Lines 255-270 and `Rules/RecordLevelFillRule.cs` (the BUG-292 fix) put them on the right ends.
2. **Why the robot cannot make that pipe:**
   1. Every pipe CD draws stores both typed levels on the pipe object (`Services/PipeEntityService.cs` 79-87), and erasing its IL texts does not clear them.
   2. A CD pipe drawn with no levels has no record levels either, so nothing is filled.
   3. The fix also needs a pit-to-pit pipe whose record runs against its drawn order. CD can only make that through the command-line direction question, which a case cannot answer.
3. **Fixture fact not checked:** whether DRV1_B1 already holds an old-style pipe (polyline and multiline, no CE pipe object) drawn from its downstream pit is unknown. I did not read the fixture, and I did not guess a handle.
4. **Where it goes:**
   1. A wave 2 made-up drawing with one old-style pit-to-pit pipe, drawn from P2 to P1, record P1 to P2 with levels, and no IL texts.
   2. Or a Codex look on such a copy. Tim's check: open Edit Pipe; P2's box shows P2's level; a plain Save leaves P1 as the inlet end in the Pit Schedule.
5. **Note:** the carpark says BUG-292's fix came in PR #437. The regression log (C-5 entry) and commit 8eb5b113 show it came in C-5 (PR #492), installed since 3.0.19.

## Anything not written, and faults noticed (names only, nothing edited)

1. **Not written:** BUG-292 (see above).
2. **R32v87 and R32bv87** (`drafts_v387_30oct`): both still carry "BUG BUG-1222". Their EXPECTED text says a check "is expected to FAIL" on BUG-1222, but both PASS on 3.0.88 (RUN-20261031-1259-C3.0.88-bF5v), and the B8 review already accepted BUG-1222 on 3.0.85. The wording is stale; a retag needs CE 02's normal slip.
3. **Carpark BUG-223 status line** still says "not yet tested by robot or Codex". R32v87 has a PASS on 3.0.88 today (part only). For CE 05.
4. **Carpark BUG-292** names PR #437 as the fix; the fix is C-5 (commit 8eb5b113). For CE 05.
5. **BUG-1222's own Test line** asks to retag R32b EXPECT-FAIL. That is out of date now that the fix passes.
6. **R31** says no case can answer CD's direction question. This still blocks the "Use level direction" half of BUG-205, BUG-261 and BUG-278. A driver step that answers a CE command-line keyword question after a window press would open all three to the robot. That is a driver change: it needs review, not a writer.
