# Wave 1 case writing, job P1: erase, OOPS, undo, relink after MOVE (Sat 31 Oct 2026)

Writer: Opus case writer, job letter P1, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Bugs: BUG-210, BUG-234, BUG-244, BUG-248, BUG-258. Installed build read: Civil 3.0.88+3fbb9da5. Nothing was run: no AutoCAD, no driver, no build, no test; only the offline `validate` and `check_ids`. No existing case, setup, driver or settings file was edited. Nothing committed or pushed.

## ANSWER FIRST

1. **All 5 bugs have a case:** 4 cases, each with a "must fail" twin (8 files). Nobody has run them yet.
2. **BUG-248 and BUG-258 share one case (W248):** they are the same fault, filed twice. Erase a perimeter drain, type OOPS: the drain AND its PD1 text must come back.
3. **BUG-210 (W210):** erase pit P8, copy a lone pit onto its spot. The copy must be linked to the pipe at once (CDCHECK and Edit Pit both show it).
4. **BUG-234 (W234):** a flat pipe P91 to P92 moved onto pits P93 and P94 must record P93 to P94. One end then stretched onto P92 must record P93 to P92.
5. **BUG-244 (W244):** a pipe between two open ends, saved high end first, must never be recorded uphill after MOVE, an end STRETCH and CDSYNC.
6. **Partly proved, needs a Codex look:** BUG-244's IL-text-edit branch (the robot cannot edit MText). For BUG-234 and BUG-244, the real grip drag (the robot types STRETCH instead).
7. **Weakest proof:** W244's deciding check is an absence (no uphill record line in the log). Its twin can only flip that check; it cannot make CE write a real uphill line.
8. **Offline checks:** validate gave 24 files, 0 invalid (my 8 plus other writers'). check_ids: "every control id is known". No "print", no street names. Every 17.x level matches the arithmetic below.
9. **Run time:** W234 places 4 pits, so allow up to 30 minutes. W210 runs SETUP-R47v (3 to 8 minutes). Run them in the free window.
10. **Untested routes:** two have never been driven by the robot: the Edit Pit window dump (W210) and OOPS (W248). If either step fails, it is a tool fault, not a result.
11. **Carpark tidy-up for the desk:** BUG-248 and BUG-258 are one fault. If W248 passes twice and Codex agrees, both can close together.
12. **Files:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W210*`, `W234*`, `W244*`, `W248*` (twins end `_BROKEN`).

---

## DETAIL

### 1. BUG-248 and BUG-258: OOPS brings back the PD text

1. **Case and twin:** `W248_oops_brings_back_pd_text.case.txt` (CASE W248) and `W248_BROKEN.case.txt` (CASE W248_BROKEN). PROVES_BUGS: BUG-248, BUG-258.
2. **In AutoCAD terms:** CDPERIMETER draws drain PD1 (a 2 m polyline at 150000,-80000 and the text PD1). The drain line is selected and erased: the line and the PD1 text both go. Type OOPS: the line is back, and the SAME PD1 text (same handle, same x and y) is back. The Civil log says it brought the text back. The command line never says CE could not bring it back. Then one U removes the line and the text again (U echoes OOPS).
3. **Words from the code (3fbb9da5):**
   1. `Services/LinkService.SurfaceDrainTags.cs` line 329: `[BUG-258] OOPS: PD text {tag} brought back with drain {drain}`. Line 345: `[BUG-258] OOPS: {n} PD text(s) brought back with their drains`. Both are Civil log INFO lines.
   2. `Rules/SurfaceDrainTagPolicy.cs` lines 76-80: the protected-text line "is back but CE could not bring back its PD text". It must not appear.
   3. Line 326: `tag.Erase(false)` un-erases the same text object, which is why the handle and position must match.
   4. OOPS only, never U, REDO or UNDO: `SurfaceDrainTagPolicy.RestoresTextAtCommandEnd`, line 91.
4. **Derived, never seen on a run:** that one U after OOPS removes both and echoes OOPS. This comes from the commit message of 4ce19d82 (headless proof PD-OOPS-U-01). A typed OOPS has never been driven by the robot.
5. **Arithmetic:** R37b's drain, word for word: 2.000 m, levels 18 and 17.9, fall 0.100, which is 1 in 20. It is a perimeter drain, not a CD pipe, so no Grade mismatch window. R37b passed on 3.0.88 today.
6. **What the twin breaks:** typed `_.REGEN` in place of `_.OOPS`. Nothing brings the drain or the text back, so it fails on the "back" counts and the two log lines.
7. **Codex look:** the locked-layer, Xref and REFEDIT branch is not driven. In that branch the text stays erased with one plain line. Codex should also check the text looks the same after OOPS (style and height): the robot reads only text and position.

### 2. BUG-210: a pit copied onto an erased pit's junction is linked at once

1. **Case and twin:** `W210_copy_pit_onto_erased_junction.case.txt` (CASE W210) and `W210_BROKEN.case.txt`. SETUP-R47v. PROVES_BUGS: BUG-210 (one pipe end).
2. **In AutoCAD terms:**
   1. SETUP-R47v gives new pit P8 at 150000,-80000 and a pipe from P8 to the open point 170000,-80000.
   2. The case places a lone pit at 150000,-70000 using the setup's own PIT steps. Then it reads CDCHECK Problems.
   3. It erases P8 ("1 pipe now has an end that is Not connected yet") and reads CDCHECK again.
   4. It COPYs the lone pit by 0,-10000 onto P8's old spot ("1 pit copied and numbered as new"). The new pit block must sit at 150000,-80000 within 1 mm.
   5. Straight after, with no other command: CDCHECK must read the full connection count again. PITEDIT on the copy must list the pipe as LEAVING and never say "The pit has no recorded connection to this pipe." Cancel closes it.
3. **Why a lone pit:** copying P3 or P8 brings in the pit-with-pipes copy rules (BUG-1227). A lone pit opens at the same default 450 size as P8, so the pipe end that CE put 225 mm into P8's wall is on the copy's wall too.
4. **Words from the code (3fbb9da5):**
   1. CDCHECK totals: `Commands/SpineCheckCommand.cs` line 91.
   2. Erase line: `Services/PitEraseFreeEndsMessagePolicy.cs` lines 40-44.
   3. Copy line: `Rules/CopiedLevelsRule.cs` line 28.
   4. The old fault's words: `Services/LinkService.PitConnectionEntry.cs` line 59.
   5. Role words ARRIVING and LEAVING: `ViewModels/PitConnectedLevelsViewModel.cs` lines 321-323.
   6. The fix: `LinkService.Utilities.cs` ReconcileClones calls `QueueClonePitRelinks` (commit 06aaf868).
5. **Numbers and what is derived:**
   1. **Seen on real runs:** `189 connections: 184 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.` after SETUP-R47v (R19v87 on 3.0.88). `188 connections: 183 Connected` with P8 erased (R19_NOU runs on 3.0.78 and 3.0.80).
   2. **Derived:** the lone pit adds an object but no connection, so the counts stay 189 and 184.
   3. **Derived:** on the old build the copy was linked only at the end of the NEXT non-COPY command. CDCHECK reports before its own end, so it would still read 188 and 183.
   4. **Derived:** the word LEAVING. The pipe starts at the copy at 18.000, its high end.
   5. **Not asserted:** the copy's number (it may reuse P8 or take the next free number). It is recorded from the Edit Pit dump.
6. **What the twin breaks:** the COPY goes 0,-9000, so the copy lands 1 m short at 150000,-79000. That pit's outline spans y -79225 to -78775. The pipe end at 150225,-80000 is 775 mm below it, far outside the 100 mm catch. The twin fails on the copy position, on CDCHECK (still 188 and 183) and on the missing LEAVING row.
7. **Codex look:** the Pit Schedule FROM, inlet and outlet cells for the copy; the six-pipe junction of the original report; U after the copy (Tim's step 5).

### 3. BUG-234: a flat pipe moved onto other pits records the new pits

1. **Case and twin:** `W234_flat_pipe_moved_onto_other_pits.case.txt` (CASE W234) and `W234_BROKEN.case.txt`. PROVES_BUGS: BUG-234 MOVE branch, and the one-end branch done by typed STRETCH.
2. **In AutoCAD terms:**
   1. Four pits are typed with PIT and numbered by hand (the N40 route, passed on 3.0.87), cover 19.000: P91 at 150000,-66000; P92 at 160000,-66000; P93 at 150000,-72000; P94 at 160000,-72000.
   2. CD runs from P91 to P92 with both levels 18.000 (flat).
   3. MOVE the pipe alone 0,-6000. The log must say `Pipe endpoints updated: <pipe> from=P93 to=P94`. Edit Pipe must show "Flow: P93 -> P94" and no P91 or P92 anywhere. Cancel closes it.
   4. ZOOM Window, then STRETCH the pipe's east end 6 m north onto P92. The log must say `from=P93 to=P92`. Edit Pipe must show "Flow: P93 -> P92" and no P94.
   5. Both IL texts still read IL 18.000.
3. **Why the flat pipe opens no Grade mismatch window:** `Commands/CdCommand.Grade.cs` line 249, `if (fall <= 1e-6) return false;`. A pipe with no fall is never compared with the grade. BUG-427 labels it FLAT (lines 187-193). Brief lesson 1 ("flatter than 1 in 100 opens the window") does not cover exactly flat.
4. **Words from the code:**
   1. `Services/ProjectDataService.Mutations.cs` line 1587: `Pipe endpoints updated: {Id} from={From} to={To}...`. The Id is the pipe's handle: today's real Civil log has `Pipe endpoints updated: 109BBC from=WT2 to=P2 fromKey=set`.
   2. The expected sides come from REGRESSION_LOG.md at 3fbb9da5, BUG-234 item 2. MOVE with neither stored pit at an end: the side proven from the released pits decides. One stored pit still at an end: it keeps its side.
   3. The Edit Pipe "Flow:" header and the end rows come from `ui_map\w2_edit_pipe.txt`.
5. **Arithmetic:**
   1. Pit centres are 10.000 m apart. Each end sits 225 mm into its wall, so the pipe runs from x 150225 to 159775 (9.550 m).
   2. After the MOVE the ends are at 150225,-72000 and 159775,-72000, on the walls of P93 and P94.
   3. The STRETCH window 159600,-72150 to 159950,-71850 catches the east vertex but not P94's insertion point (160000). The 0,6000 move puts the end at 159775,-66000, on P92's west wall.
   4. New length: sqrt(9.550² + 6.000²) = 11.278 m. The levels stay flat because there is no grade to hold.
6. **Derived:** that P91 to P94 are free numbers in DRV1_B1. The notes on R19, R34 and N71 say it holds P1 to P10; I did not open the drawing.
7. **What the twin breaks:** P93 and P94 are placed 1 m further south (y -73000). Their outline spans -73225 to -72775, so the moved pipe ends at -72000 are 775 mm clear and nothing links. The twin fails on both `from=P93` log lines and the Edit Pipe Flow checks. The STRETCH window still catches the east end, so no step stalls.
8. **Codex look:** a real grip drag of the end, P2 onto P3. Does CE treat a grip drag (GRIP_STRETCH) exactly like STRETCH? Also the Pit Schedule FROM and TO cells, and U after each step.

### 4. BUG-244: an open-end pipe stays downhill after the automatic relink

1. **Case and twin:** `W244_open_end_pipe_stays_downhill_after_move.case.txt` (CASE W244) and `W244_BROKEN.case.txt`. PROVES_BUGS: BUG-244 MOVE, end-move and CDSYNC branches only.
2. **In AutoCAD terms:**
   1. R32v87's first half, word for word (passed twice on 3.0.88): a 20 m pipe between the empty points 150000,-90000 and 170000,-90000, levels 18.000 and 17.800.
   2. CDEDIT with the levels typed the other way round (17.800 and 18.000), then Save: "Pipe updated." and the arrow turns (rotation about 3.1416). The high, east end is now From.
   3. Then: MOVE 0,1000; STRETCH the west end 1 m further west; CDSYNC.
   4. After each of the three: the arrow still reads about 3.1416. The Civil log never holds `Pipe inverts updated: <this pipe> from=17.`, so the record never makes the low end its From. One IL 18.000 text is left.
   5. At the end, Edit Pipe shows "The levels fall from point 2 to point 1; CE records that as the flow direction." and never "Upstream invert is lower than downstream". Cancel closes it.
3. **Words from the code (3fbb9da5):**
   1. `Services/ProjectDataService.Mutations.cs` line 1458: `Pipe inverts updated: {Id} from={FromInvert} to={ToInvert} (...)`.
   2. `ViewModels/CdViewModel.Inverts.cs` line 1040 (the status-chip line) and line 1050 (the uphill line). Run 1259-bF5v recorded the chip line on a reopened reversed pipe.
   3. `Commands/LinkCommands.cs` line 192: `CDSYNC complete. ...`.
   4. The fix: `Services/RelinkedPipeRecordWriter.cs` lines 39-53 (`ResolveWithLevels`).
4. **Arithmetic:**
   1. 20.000 m with a 0.200 fall is exactly 1 in 100, so no window.
   2. After the STRETCH the pipe is 21.000 m. At the held 1 in 100 from the fixed east end: 18.000 - 0.210 = 17.790 at the west end. This is derived (lesson 2: N41 read IL 17.78 at 22 m) and only RECORDED, not judged.
   3. The east IL 18.000 must stay.
5. **What is weak and derived:**
   1. The deciding check is an absence. On the old build the arrow was also left alone, so the arrow and chip checks are sanity checks only.
   2. The code does not confirm that CDSYNC reaches the relink writer. It registers pits and pipes, then runs SyncWithDrawing and UpdatePipeEndpointsFromProjectData. It is included because the bug names "relink all".
   3. The arrow and IL selects are limited to within 12 m of 160000,-89500. That keeps them from catching CDSYNC's redraws elsewhere in the drawing.
6. **What the twin breaks:** the one deciding check is flipped. It asks for the old uphill line, so on the fixed build it fails on that check alone. Steps are W244's, word for word.
7. **Codex look (needed):** this is the branch #654 itself added. In Edit Pipe, type 18.00 / 17.80 the wrong way round on a two-open-end pipe and Save. Edit the 17.80 IL text on the plan to 17.70. Grip-drag one end a little. Reopen Edit Pipe: From is still the 18.00 end, the arrow points to the 17.70 end, and there is no uphill warning. U puts it back. The robot cannot edit MText.

### 5. Could not write, and faults noticed

1. **Not written:** nothing. Every bug has a case, though BUG-244 and BUG-234 are partial (above).
2. **Brief lesson 1 is slightly too wide:** an exactly FLAT pipe never opens the Grade mismatch window (`CdCommand.Grade.cs` line 249). Only a pipe that falls, but less than its grade, does. That is useful for future flat-pipe cases.
3. **BUG-248 and BUG-258 are one fault in two entries:** close them together.
4. **N46 (drafts_next40_a_30oct):** this draft's Edit Pit dump has never been run by the robot. W210 is the second case to rely on it.
5. **No fault found** in SETUP-R47v, R19v87, R32v87, R37b or N41v87, whose routes I copied. Their recorded runs on 3.0.88 support them.
