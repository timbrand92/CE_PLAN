# Codex audit sample, Mon 2 Nov 2026: 1 in 10 of the Claude-accepted cases

Written by a read-only planning job (no AutoCAD, no runner, no Codex, no git). Purpose: a spot check of the robot's own acceptance. Codex checks one drawing fact per case on its own, without reading the robot's result first, and says whether it sees the same fact.

## Answer first

1. **124 cases are in the population; every 10th in alphabetical order of case id gives 12 cases.**
2. **12 cases at about 3 minutes each is 36 look minutes** (about 2.4 usage points at 1 point per 15 minutes), plus about 6 minutes of set-up and clean end per AutoCAD session.
3. **Six of the twelve need a setting changed, a long set-up or give a time rather than a picture** (marked FLAG below: positions 10, 30, 40, 50, 70 and 110); each has a named swap, the next case in the same alphabetical list (or the next one that needs no setting).

## How the population was made (so it can be checked)

1. **Source:** every case file under C:\Lisp Files\_ACAD_DRIVER\cases whose review slip (the .review.txt beside it) has a VERDICT line saying CLAUDE-ACCEPTED-READY. That is 156 slips; the five slips that are not ready (R06, R09, R18 and two broken-variant slips) are left out.
2. **One entry per case id:** a case id that appears twice (N32, N33, N36 and R09s sit in two folders; R33m has its slip in the root folder and its case in variants) is counted once.
3. **Superseded older versions are dropped (27):** where a v87 re-run exists, the older id is left out and the v87 id stays, because the 3.0.88 acceptance rests on the v87 text. Dropped: N06, N17, N18, N19, N20, N23, N27, N28, R01, R02, R02b, R03, R04, R11, R13, R14, R14h_both_200, R14h_dstd_200, R14h_pipekey_200, R15, R16, R17, R19, R32, R32b, R39, R39b.
4. **Result: 124 case ids**, sorted alphabetically without regard to case. Position 10, 20, 30 and so on up to 120 are the sample. Cases that Tim also confirmed by hand (for example R03 through D12, R34a through D15) stay in: the sample audits the robot's proof, not the tool.
5. **Where the sample is run:** on a fresh copy of the fixture C:\ce_rc_drv\DRV1_B1.dwg (copies only), one AutoCAD session at a time, with the driver doing every command-line job as in the A2b brief. Each case's exact keystrokes are in its case file; the slip names the numbers the robot saw.

## The twelve

1. **Position 10: N11, the Edit Pipe cascade and the Pit Schedule** (slip: N11_cascade_schedule_levels_u_redo.review.txt, Civil 3.0.83).
   - **Fact:** after the Edit Pipe cascade from P3 (IL 17.50) the Pit Schedule reads P3 inlet 17.50 and outlet 17.45, and P2 inlet 17.33 and outlet 17.28.
   - **Codex, in plain steps:** select the pipe P4 to P3 (handle 10A98D), run CDEDIT, answer Yes to the older-version question, type 17.60 in the first level box and 17.50 in the second, Save, answer Yes to the recalculate question, press Apply in the Cascade Preview. Open the Pit Schedule (Rows, Pit and pipes) and read the four numbers. Close it. Do not press Refresh.
   - **FLAG:** about 5 minutes. If it will not fit in 3, swap to position 11, N12.
2. **Position 20: N23v87, the 100 mm catch edge** (slip: N23_pit_catch_boundary_90_caught_110_freev87.review.txt, 3.0.88, accepted FULL).
   - **Fact:** a pipe end 90 mm outside the 450 mm opening of a new pit is pulled onto the pit wall, and an end 110 mm outside stays free.
   - **Codex:** place a pit at 150000,-80000 with cover 19.000. Zoom to the window 150200,-80300 to 150450,-79700. Draw two pipes with CD by typed points, 160225,-79850 to 150315,-79850 and 160335,-80150 to 150335,-80150, levels 18.000 and 17.900 (answer Keep if a grade question opens). Look: the first pipe end touches the wall with no gap and the history says "was 90 mm short of the wall" and "Flow: Open end -> P8"; the second end sits visibly clear of the wall and says "Flow: Open end -> Open end".
3. **Position 30: N33_grade_mismatch_x_off, the old two-button box** (slip: N33_grade_mismatch_x_off.review.txt, 3.0.88, a control).
   - **Fact:** with the switch off the Grade mismatch box is the old box: buttons "Use 1 IN 200" and "Keep 1 IN 100" only, no Cancel button and no "places no pipe" sentence.
   - **Codex:** needs grade.mismatchBoxCloseCancels false before AutoCAD starts and put back after. Draw a 20 m pipe with CD, Set my own 1 in 100, levels 18.000 and 17.900, Start Pipe. Read the box and count its buttons. Press Keep to finish.
   - **FLAG:** setting change (a settings pass). If no settings pass runs today, swap to position 31, N33a_one_end_on_no_box.
4. **Position 40: N36, a downpipe on empty ground is quick** (slip: N36_dp_time_under_budget.review.txt, 3.0.86, accepted PART).
   - **Fact:** DP at 150000,-80000 places a downpipe tagged DP and offers the next one; the robot read 7.8 and 9.2 seconds in all (its wait included), limit 20 seconds. The time is the claim; the drawing shows only the new DP block and its tag.
   - **Codex:** send DP with the point 150000,-80000 and watch the clock from the send to the line "Downpipe placed. Tag: DP<n>." (screenshot every 5 seconds). Expected well under 20 seconds. Esc once to stop. Write the seconds and the tag.
   - **FLAG:** the fact is a time, not a drawing value. If Codex judges a stopwatch reading too loose, swap to position 41, N38_cdcheck_reopen.
5. **Position 50: N71v87, a ROTATE copy onto a loose pipe end** (slip: N71_rotate_copy_onto_loose_pipe_end_joinsv87.review.txt, 3.0.88, accepted FULL).
   - **Fact:** a ROTATE Copy of P3 that lands on the loose end of the new pipe is numbered P11 and joins the pipe (the CE log says the pipe now runs from P8 to P11).
   - **Codex:** place P8 at 150000,-80000 and a 20 m pipe from it to 170000,-80000. Select P3 (handle 109D56), ROTATE with base point 111888.85,-51784.95, Copy, 180 degrees. Look: a new pit sits on the loose end, its label reads P11, and the history names the join.
   - **FLAG:** long set-up (about 6 minutes) and the case sets two switches. If it will not fit in 3, swap to position 51, N72.
6. **Position 60: R03v87, one IL text at each pipe end** (slip: R03_one_il_text_each_endv87.review.txt, 3.0.88).
   - **Fact:** a new CD pipe has exactly two IL texts, IL 18.000 near the start pit and IL 17.800 near the open end.
   - **Codex:** place P8 at 150000,-80000 (cover 19.000), draw the pipe by CD from 150000,-80000 to 170000,-80000 with levels 18.000 and 17.800, zoom to each end and read the texts. Count the IL texts on the pipe.
7. **Position 70: R14h_both_200v87, the freeboard wording** (slip: R14h_both_200v87.review.txt, 3.0.88).
   - **Fact:** with both freeboard settings raised to 200 mm, CDTWL says "(200 mm is wanted)" for C1 (40 mm), P1 and P7 (110 mm each).
   - **Codex:** needs pipe.detentionFreeboardMm and designStandards.detentionFreeboardMm both 200 before AutoCAD starts, put back after. Run CDTWL with the two answers in the case file and read the lines.
   - **FLAG:** two setting changes and a command-line fact, not a picture. If no settings pass runs, swap to position 71, R14h_dstd_200v87 (same need), then to R14v87 (position 73, no change).
8. **Position 80: R21, the CDCHECK totals** (slip: R21_cdcheck_totals_add_up.review.txt, 3.0.80; N38A saw the same totals on 3.0.88).
   - **Fact:** on the untouched fixture CDCHECK (answer All, then Problems) prints "[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected", and each Esc says nothing in the drawing has been changed.
   - **Codex:** run CDCHECK, answer All, read the line, press Esc; run it again with Problems and read the line; check that 179 plus 1 plus 4 plus 0 is 184. A different total on a new build is a NOTE, not a failure of the robot.
9. **Position 90: R34a, a plain COPY of one pit** (slip: R34a_plain_copy_original_kept_u_restores.review.txt, 3.0.85).
   - **Fact:** COPY of pit P3 gives one new pit whose label reads P8 (the only free number in the drawing) while the original still reads P3, and CE says "1 pit copied and numbered as new."
   - **Codex:** select P3 and COPY it to a clear spot. Read both labels and the CE line. One U takes the copy away.
10. **Position 100: W216, CDFALLSUGGEST ends on Enter** (slip: W216_cdfallsuggest_enter_finishes.review.txt, 3.0.88).
    - **Fact:** at "Next level (0 placed, 1 skipped), or Enter to finish:" Enter ends the command with "CDFALLSUGGEST finished. 0 placed, 1 skipped." and no FALL block is added.
    - **Codex:** run CDFALLSUGGEST at the point 150000,-98000, press Enter at the level question, press Enter again at "Next level". Look for the finishing line and for any new FALL symbol.
11. **Position 110: W654, a kept typed level is named as running backwards** (slip: W654_cascade_kept_typed_level_backfall_warned.review.txt, 3.0.88).
    - **Fact:** the hand-typed 18.06 is kept and CE warns "P82 -> P83 will be flat or running backwards"; the texts read IL 17.95 and IL 18.06, never IL 17.86.
    - **Codex:** needs three pits P81 to P83 and two pipes (18.300 / 18.200 and 18.150 / 18.050) and three switches in the case file.
    - **FLAG:** long set-up and settings. Swap to position 111, W655.
12. **Position 120: W740, a copy of a roof drain keeps its whole name** (slip: W740_copy_roof_drain_keeps_whole_name.review.txt, 3.0.88).
    - **Fact:** a COPY of the block ROOF DRAIN 1 gets a label reading ROOF DRAIN (never ROOF or ROOF1), and the next CDSOURCE Roof drain is numbered ROOF DRAIN 3.
    - **Codex:** run CDSOURCE for a Roof drain at 150000,-98000 ("ID: ROOF DRAIN 1"), COPY the block 3 m east, read the copy's label, then run CDSOURCE for a Roof drain again at 156000,-98000 and read the ID it reports.

## Look minutes

1. **12 cases at about 3 minutes each: 36 look minutes.**
2. **If every FLAG swap is taken:** the swapped cases are N12, N33a_one_end_on_no_box, N38_cdcheck_reopen, N72, R14v87 and W655; they need no setting change and the same 3 minutes each, so the total stays 36.
3. **Result words for each case:** SAME (Codex sees the fact the slip names), DIFFERENT (it sees something else; write what), NOT TESTED (set-up or setting not available; name the swap used). A DIFFERENT is a finding about the robot's acceptance and goes to the desk the same day.
