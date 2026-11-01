# Codex day, Mon 2 Nov 2026: what the PART cases leave unseen, grouped by screen

Written by a read-only planning job (no AutoCAD, no runner, no Codex, no git). Sources: C78_REVIEW_A to D and W1_REVIEW_E and F in this folder, the ledger ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md, the NOT_AUTOMATED lines of the case files under C:\Lisp Files\_ACAD_DRIVER\cases, and the Codex reports A78, A78b, A78c, A2 and A2b in C:\Lisp Files\_TEST_COPIES_20260923.

## Answer first

1. **43 C-78 cases were accepted PART** (review A 13, B 13, C 9, D 8). The two wave 1 reviews add 22 more (E 12, F 10), so the six reports hold 65 ACCEPT PART in all.
2. **29 of the 43 have something a person must SEE**; 14 have none (robot-readable, not built, or nothing drawn). Of the 29, two are already seen by Codex (N20v87 PASS in A2b today; the plain Grade mismatch window look of N33d PASS in A78b and A78c). That leaves **27 C-78 cases to look at**. Of the 22 wave 1 cases, **14 have a SEE item**.
3. **Nine groups, 41 looks, 164 Codex minutes (4 per look), about 11 usage points.** Set-up and clean end add about 6 minutes per group (54 minutes, about 3.6 points), not counted in those figures.
4. **Groups 1 and 2 are written as full briefs** in C:\Lisp Files\_CODEX_RUNNER: verifyS1_c88.txt and verifyS1_c88_full.txt (six looks, all runnable), verifyS2_c88.txt and verifyS2_c88_full.txt (six looks written, four runnable, two marked STEPS TO BE CONFIRMED and placed last).
5. **The other seven groups need a brief each** (S3 to S9, written by CE 02 the same way). Groups 4 and 7 need a settings pass (a switch changed and put back); the rest do not.

## How the 43 split (so nothing is lost)

1. **Already seen by Codex (2):** N20v87 (the leader on the 2 m pipe, A2-03 PASS in A2b this morning) and N33d (the window's look, A78b and A78c PASS; the Use and Keep answers it never covered are in group 1).
2. **No SEE item (14):** N06v87 (layer table colours not built; IL, label and pipe layers are recorded), N17v87 and N18v87 (REDO is not driven, a command-line matter), N19v87 (the 90 and 110 mm pair is in N23, accepted FULL), N24 (TG and the numbering rule are Tim's call), N28v87 (never-recolour not built), N38A (a baseline; the plan item leaves out the Checks palette), N81 (no label is placed, so nothing to see), R04v87 (a file hash), R14h_both_200v87, R14h_dstd_200v87 and R14h_pipekey_200v87 (CDTWL wording on the command line), R17v87 (pipe vertices), R19v87 (the several-pipe branch is text).
3. **Wave 1 with no SEE item (8 of 22):** W267, W278, W656, W657, W665p, W667, W740, W741.
4. **Not doable by Codex today:** the window look at 100, 125 and 150 per cent display scale (N33_grade_mismatch_x). It needs the Windows display scale changed, which is a system setting, and A78, A78b and A78c all record that the scale on this PC was never established. It is left for Tim or for a deliberate decision.

## Run order for the day

1. **S1, S2, S3, S5, S6, S8, S9** need no setting change: run them first, back to back, one AutoCAD session each.
2. **S4 and S7 last.** Each needs a switch changed before AutoCAD starts and put back by hash at the end (the settings pass of the shared file); they must not run beside another group.
3. **Sizes tie at 6 (groups 1 and 2) and at 5 (groups 3 and 4); the tie is broken by how well the steps are sourced.** Groups of 4 and 3 follow.

## The groups

### Group 1 (S1): the Grade mismatch window and its answers. 6 looks, 24 minutes. Brief written. Order 1.

New Pipe window, then the Grade mismatch window, on 20 m pipes on empty ground. No setting change.

1. **S1-01 Use answer (cases N33_grade_mismatch_x, N33c, N33d, N33e, N33f; reviews A and B: "what each answer writes is not checked").** SEE: clicking "Use 1 IN 200" places the pipe and its label reads 1 IN 200.
2. **S1-02 Keep answer (same cases).** SEE: clicking "Keep 1 IN 100" places the pipe and its label reads 1 IN 100.
3. **S1-03 steeper typed level (N33c; review A: "the look").** SEE: the window for a typed second level that makes about 1 IN 67 shows Use 1 IN 67, Keep 1 IN 100 and Cancel, none cut off; Cancel draws nothing.
4. **S1-04 changed grade box (N33e; review B hole 1).** SEE: after the grade box is changed to 200 the window still opens, with Keep 1 IN 200; Cancel draws nothing.
5. **S1-05 carried fall (N33f; review B hole 2).** SEE: after the upstream level is retyped and CE carries the fall, the window still opens (about 1 IN 40 against 1 IN 100); Cancel draws nothing.
6. **S1-06 Esc key (N33_grade_mismatch_x; A78b and A78c DIFFERENT, the key never reached the window).** SEE: Esc closes the window like Cancel and no pipe is drawn. Last, because the tool limit may repeat; DIFFERENT is an accepted outcome.

### Group 2 (S2): the Pit Schedule window. 6 looks, 24 minutes (4 runnable now). Brief written. Order 2.

Pit Schedule window after new pits, new pipes and CDSYNC. No setting change for the first four.

1. **S2-01 R02v87 (review C: schedule half read as text).** SEE: the new pit P8 on the schedule with its outlet level 18.00 and size filled in, cells plain.
2. **S2-02 R02bv87 (review C: "inlet's schedule row" never opened).** SEE: a pipe ended on P8 adds an inlet (about 17.90) beside the outlet.
3. **S2-03 W784 (review F: FROM column; the drawn-table refresh needs a placed schedule and is not in this look).** SEE: P11's group reads FROM C5 and FROM C6 on two rows, never C or Cs.
4. **S2-04 R13v87 (review D: header and layout never compared, BUG-855).** SEE: the schedule before and after CDSYNC is identical, and the header count agrees with the foot count.
5. **S2-05 N40 natural order (review B). WAITING FOR STEPS.** SEE: the schedule reads P1, P1A, P1B, P2 to P7, P9, P9A, P10, P10A, C1, SPS2, SPS10 whatever order the pits were placed. Needs the switch linking.pitScheduleNaturalOrder ON, so it belongs with a settings pass.
6. **S2-06 W210 (review E: Edit Pit and the schedule never compared). WAITING FOR STEPS.** SEE: a pit copied onto an erased junction shows its pipe in Edit Pit and the schedule alike. Needs handles the brief does not give Codex.

### Group 3 (S3): labels, texts and arrows on the plan, no switch. 5 looks, 20 minutes. Order 3.

1. **S3-01 R01v87 (review C: pit label block and text sizes not judged).** SEE: after two pits and two pipes by PIT and CD, each pit shows its number and its CL cover text readable, and the second pipe's label grade agrees with its levels (the ledger flagged 1 IN 54 against about 1 IN 200 as a possible fault).
2. **S3-02 R03v87 (review C).** SEE: one IL text at each pipe end, readable and clear of the pit and the pipe; they read three decimals (IL 18.000) where Tim's example is IL 33.00 (his call, report the look).
3. **S3-03 N44v87 (review B: labels and arrows of the new types only recorded).** SEE: Charged pipe, Suspended pipe, Rising main and Stormwater pipe each get a readable label, IL texts and arrow, not stacked or missing.
4. **S3-04 R33m (review D: "the copied label").** SEE: a COPY of a pit with 25TEXT locked draws the copy's pit label (a number other than P3) and no CL text, and the CE line names 25TEXT and does not say "no label". Locks a layer, so shared rule 5.11 must be lifted for this look only.
5. **S3-05 W285 (review E: "where the items sit").** SEE: after ERASE of a pipe and OOPS, its size label, both IL texts and its arrow sit where they were on the pipe.

### Group 4 (S4): label looks that need a switch (settings pass). 5 looks, 20 minutes. Order 8 (run late).

Four of the five need a switch changed first: pitLabelOnEsc (N80, W325), tidyLabelsEnabled (N67v87, N27v87), handPlacedLabelsStay (N27v87). W665 needs rotateScaleCopyLikeCopy, read it first (the robot pinned it, it is probably ON already).

1. **S4-01 N80 (review C: Tim's "learned office spot", corner and 350 mm distance not measured).** SEE: an Esc at the pit label question puts the PIT LABEL at the usual spot beside the pit, clear of the pit.
2. **S4-02 N67v87 (reviews B and C: where the text lands).** SEE: after Tidy labels Yes the moved invert text lands clear of the obstruction, readable.
3. **S4-03 N27v87 (review A: the pipe label itself).** SEE: a label moved by hand stays exactly where it was after Tidy labels, while the others move clear.
4. **S4-04 W665 (review F: "the look of the scaled block").** SEE: a SCALE Copy of a pit keeps its own label and cover text at the right size and place.
5. **S4-05 W325 (review E: "the look of the label, the far IL text and the arrow").** SEE: after OOPS of a pit, its label and a pipe, all three come back looking right.

### Group 5 (S5): the Edit Pipe window and the Cascade Preview. 4 looks, 16 minutes. Order 4.

Read the switches cascadeKeepsPitDrop, flatPipeIsWarningNotBlock and cascadeRelinksOnlyPlanPipes first (the W652 to W655 cases pin them).

1. **S5-01 R32v87 (review D: the arrow direction; R32bv87, accepted FULL, shares the picture).** SEE: reversing the levels in Edit Pipe turns the flow arrow round; a size-only save leaves it alone.
2. **S5-02 R11v87 (review C: the Recalculate box wording, the label re-tidy).** SEE: the "Recalculate downstream inverts" box and the Cascade Preview read plainly, and the texts change as the preview says.
3. **S5-03 W324 (review E: Apply and the repair offer not pressed).** SEE: the batch editor opens for the newer pipe, names the older one left out, and its Apply works.
4. **S5-04 W652, W654, W655 (review E: the Cascade Preview wording only recorded).** SEE: the preview shows the backwards or flat warning naming P82 -> P83, and the junction outlet kept under the lower arriving pipe.

### Group 6 (S6): a short pipe with no Grade mismatch window, label on the plan. 4 looks, 16 minutes. Order 5.

The robot used 4.1 m between two pits (the short-pipe nuisance of rounding) with pipe text off. Codex needs the same short pipe with pipe text ON and the leader answered by two clicks, as in A2-03.

1. **S6-01 N33a (review A: label grade not read).** SEE: "I know one end" ON at 1 in 100 opens no window and the label reads 1 IN 100.
2. **S6-02 N33b (review A).** SEE: CE's own second level opens no window and the label reads 1 IN 100.
3. **S6-03 N33g (review B).** SEE: after the upstream level is retyped, CE refills the second level, no window opens, and the label reads the typed grade.
4. **S6-04 N33h (review B: the open CE 04 label question, Tim's call).** SEE: with "I know one end" ON at 1 in 200 the label reads 1 IN 200 on a pipe that is really about 1 in 137. Report what shows; do not judge it.

### Group 7 (S7): switch looks that need a settings pass. 4 looks, 16 minutes. Order 9 (run last).

1. **S7-01 N33s (review B).** Needs pipe.mismatchBoxSkipsOwnSuggestion OFF. SEE: CE's own rounded level opens the window again (Use 1 IN 82, Keep 1 IN 100) on the 4.1 m pit-to-pit pipe.
2. **S7-02 N33_grade_mismatch_x_off (review A).** Needs grade.mismatchBoxCloseCancels OFF. SEE: the old two-button box (no Cancel button), and Esc and the X place the pipe with the typed grade.
3. **S7-03 N61 (review B: "stays hidden" never checked).** Needs checks.allowIgnoreFinding ON. SEE: an ignored finding stays out of CDCHECK and the Checks palette and comes back after an edit.
4. **S7-04 N42 (review B: the red centre and the DP text).** Needs doubleClick.sourceEditWindow ON and opensEditWindow OFF. SEE: a double-click on the red centre and then on the DP text of a new DP1 each open CE's Edit source window with DP1, and the AutoCAD attribute editor never opens; the green label (BUG-860) is also looked at.

### Group 8 (S8): CD and fall-suggestion prompts. 4 looks, 16 minutes. Order 6.

1. **S8-01 W216 (review E: Enter after an accepted arrow, the Codex route of 14 Oct).** SEE: CDFALLSUGGEST ends cleanly on Enter after one level is accepted, with no "Invalid point".
2. **S8-02 W713 (review F: the pit design-level offer not driven).** SEE: the pit design-level offer that CDFALLSUGGEST can make; report in what words it is offered and what it writes. Report only, no verdict on the words.
3. **S8-03 W223 (review E: the CD not-drawn-first branch and the "Flow:" line).** SEE: when the levels are typed in the opposite order, the New Pipe route and the "Flow:" line follow the levels (the Edit Pipe half is already proved as text).
4. **S8-04 W261 (review E: CD's "Use level direction" route).** SEE: the CD question that names both levels, and what the "Use level direction" answer draws; the diameter-only Edit Pipe save raises no false "flows uphill" line.

### Group 9 (S9): CDCHECK, the ribbon and a second drawing. 3 looks, 12 minutes. Order 7.

1. **S9-01 N41v87 (review B: the Checks palette, the "Drawing Border" wording, BUG-753, BUG-814, BUG-360).** SEE: after a MOVE and a STRETCH, CDCHECK's lines and the Checks palette read in plain words with no handle codes.
2. **S9-02 N91 (review C: ribbon tabs not read).** SEE: the ribbon tabs the case names (CE, CE STRUC, CE Tools) are present (report the real names; A78c saw Plug-ins, Featured Apps and CE Tools plus CE menus), and About CE Suite shows Civil, Structural and Manager at the installed versions with no "Not loaded" or "CONFLICT".
3. **S9-03 W743 (review F: the bug's main case needs a second drawing).** SEE: pressing Enter at the cover-level question of CDTG in a second, fresh drawing gives no PCL line (the 45.2 typed in the first drawing is not carried across). The shared file (N13) says to report a second drawing rather than open it, so CE 02 must lift that rule for this look.

## Five-line summary

1. **Groups:** 9.
2. **Looks:** 41 (group sizes 6, 6, 5, 5, 4, 4, 4, 4, 3; one look can cover two or three cases).
3. **Codex minutes:** 164 at 4 per look (S1 24, S2 24, S3 20, S4 20, S5 16, S6 16, S7 16, S8 16, S9 12), plus about 54 for set-up and clean end.
4. **Expected Codex usage points:** about 11 (164 divided by 15), about 14.5 with the set-up and clean-end time.
5. **Written now:** S1 (6 looks) and S2 (4 runnable, 2 waiting for steps); groups 3 to 9 still need their briefs.
