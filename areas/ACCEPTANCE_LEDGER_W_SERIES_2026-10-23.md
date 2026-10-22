# Acceptance ledger: Codex W-series looks of 23 Oct 2026

Written Fri 23 Oct 2026, about 10:35 Melbourne, by the CE acceptance clerk (Opus, desk agent). Read-only on every input; this is the only file written. The desk applies the carpark edits in section 4; nothing here marks anything FIXED by itself.

**Inputs read:** the seven W reports of 23 Oct in `C:\Lisp Files\_TEST_COPIES_20260923` (W1 06:22 and 08:42, W2 05:51, W3 07:23 and 09:11, W4 07:31, W5 08:20); the briefs `verifyW1_c60_full.txt` to `verifyW8_c60_full.txt` and `lookCOMMON_full.txt`; RULES 4.5 and the 13.3 amendment of 20 Oct; robot runs 34, 35, 37, 44 to 47; `DRIVER_V3_PHASE1B_REPORT.md`; `TESTING_REBUILD_SPEC_2026-10-22.md` (runner cases C01 to C40); `BUG_CARPARK.md`; `CARPARK_RECONCILIATION_2026-10-22.md`; `CODEX_ACCEPTANCE_BACKLOG_22OCT.md`; the installed Civil source at commit 40ee0a36 (read only, to settle three questions).

**Build under test (every report read it from the live DLLs):** Civil 3.0.70+40ee0a36 (Modern 12FFCFF1B34E), Manager 1.1.70+40ee0a36 (7A5A68ACF903), Structural 1.0.121+2c9a9694 (15B18533C482). The status bar matched in every run that started AutoCAD. Settings: all four files equal at start and end in every run; the two guarded keys (checks.checksCommandEnabled in W3, linking.tidyLabelsEnabled in W4) were restored by hash.

**The acceptance rule used (RULES 13.3 as amended 20 Oct):** an item is "FIXED (Codex-accepted, build, date)" only when the Claude robot (or the runner) has seen the same behaviour PASS AND this independent Codex pass PASSES. Engineering values still need Tim's word.

---

## ANSWER FIRST

1. **25 looks were judged** (W1 5, W2 4, W3 5, W4 5, W5 6). The first W1 (06:22) never started and the first W3 (07:23) was stopped at Explorer; both were re-run, so only the re-runs count.
2. **Accepted-ready (Codex PASS plus a robot PASS on the same behaviour): 5.** W1-03, W3-04, W4-01, W4-05, W5-05.
3. **Codex PASS only (no robot or runner PASS exists): 3.** W2-02 (BUG-791), W5-01 (BUG-758 window half), W5-02.
4. **FAIL or DIFFERENT: 9.** Only 3 are product faults: W2-04 confirms BUG-817 on 3.0.70; W5-04 is a NEW fault (CDCALC leaves an undo step); W5-03 is a NEW small fault (Pump System tab has no read-only banner). The other 6 (W1-02, W3-01, W3-03, W3-05, W4-02, W4-04) were caused by the brief, not the product.
5. **BLOCKED, NOT TESTED or SEEN: 8.** W1-01, W1-04, W1-05, W2-01, W2-03, W3-02, W4-03, W5-06. Seven are brief or fixture faults; W2-03 turned up a real gap (no "Delete cell" item exists in the menu).
6. **What can be marked FIXED now: no carpark bug.** The five accepted-ready looks are regressions or plan items, not open bugs:
   1. **BUG-698** (CDSYNC keeps the schedule): already FIXED; add a "still passes on 3.0.70" line.
   2. **UX-LBL-03 Tidy labels:** the counts and the Esc path are Codex-accepted on 3.0.70 (Apply, U and REDO are not).
   3. **UX-PERF-01 (#1514):** CDCHECKCURRENT stays quiet with its defaults; Codex-accepted on 3.0.70.
   4. **Checks list:** CDCHECKCURRENT folding into Checks is Codex-accepted on 3.0.70.
   5. **C-59 outcome lines:** the "cancelled" line for CDTIDYLABELS is Codex-accepted on 3.0.70.
7. **New defects for the carpark: 5** (section 3): CDCALC undo step, no Delete cell in the Pit Schedule menu, CDTWL list wording, Pump System banner, Tidy labels putting the IL text across its own pipe.
8. **Still to come:** W6 (Manager windows) started at 10:27 and was running when this was written. W7 (CEMEMBER, 6 looks) and W8 (AD/LD/Q at 1:50, 5 looks) have not run. They are not in these counts.
9. **The single biggest brief lesson:** a typed `(command "_.ZOOM" ...)` is itself an undo step. Three looks typed U after a zoom and undid the zoom instead of the CE command. Never zoom between the action and the U.

---

## 1. Every look

### W1: daily work on a Civil job drawing (run 08:42 to 09:06; the 06:22 run never started)

**W1 06:22 run, all five looks NOT STARTED.** Cause: environment. AutoCAD was already running and the shared lock was held by "Claude-driverv3" (the driver v3 phase 1B self-test). Not a brief fault. Lesson: the desk queued Codex while the runner self-test held the lock.

1. **W1-01 Edit Pipe cascade with U and REDO (UX-LBL-02 and the cascade).**
   1. **Result:** BLOCKED SURE. Apply raised a "Design Warnings" box the brief did not list ("Grade 1:231 is shallower than minimum 1:200 — risk of silting" / "Warnings are informational — the pipe has been saved."), so N7 stopped the look before U and REDO.
   2. **Robot:** PASS on every run 35 to 47 (run 47 on 3.0.70: "Updated 4 pipes and 3 pits from P3 (IL 17.50)", U echo CDEDIT, REDO "Everything has been redone").
   3. **Fault: the brief, two ways.**
      1. **Wrong pipe.** The brief calls handle 10A98D "the pipe P3 -> P2". The evidence says 10A98D is the P4 -> P3 pipe. The robot read its second invert as 17.30 and its cascade ran "from P3". Codex's W1-03 schedule shows P3's inlet from P4 at 17.30. Codex double-clicked the P3 -> P2 line and opened a different pipe, 109E23 (inverts 17.25 and 17.13). Typing 17.60 and 17.50 on that pipe gave a flat grade and the warning box. The Cascade Preview then read "Anchor P2 IL 17.50, 3 pipes, 4 pits".
      2. **Unlisted box.** The Design Warnings box was not among the allowed answers.
   4. **Product finding:** none. The box is CE's designed warning for a grade flatter than 1 in 200.
   5. **Re-run brief must change:**
      1. Select the pipe the robot used: TYPE (sssetfirst nil (ssadd (handent "10A98D"))), click the strip once with no Esc, then TYPE CDEDIT. Call it the P4 -> P3 pipe.
      2. Allow OK on Design Warnings.
      3. Say the footer button may read "Save" (Codex saw "Save"; the robot's automation name was "Save pipe and close").
      4. Keep the view fixed: no zoom between Apply, U and REDO.
2. **W1-02 Quick MOVE of pit P3 opens no CE window, labels follow, one U.**
   1. **Result:** DIFFERENT SURE.
      1. **Product half, as expected:** no CE window opened; P3 and its labels rose together; one line was printed: `[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "SC").`
      2. **Undo half, unproven:** U echoed "(Lisp Expression) GROUP" twice and P3 stayed moved; REDO said "Nothing to redo".
   2. **Robot:** PASS every run for the no-window and labels half (run 47 on 3.0.70).
   3. **Fault: the brief.** It ordered a typed `(command "_.ZOOM" ...)` and a DBMOD reading before the U. The zoom is an undo step of its own, so U took back the zoom, not the MOVE. Not a CE fault.
   4. **Re-run brief must change:** set the zoom once before the MOVE and take the AFTER shot at that same view. TYPE U straight after the MOVE screenshot, with no typed (command ...) line in between.
3. **W1-03 CDSYNC leaves the Pit Schedule rows alone (BUG-698 regression; BUG-855 reported).**
   1. **Result:** PASS SURE. The first four rows and the P3 and C1 rows were identical before and after "CDSYNC complete. Pits relinked: 11, Pipes relinked: 49". There were 27 rows both times.
   2. **Robot:** PASS runs 31 to 46; the last was run 46 on Civil 3.0.69. Run 47 on 3.0.70 did not run it (NOT RUN, call budget).
   3. **Acceptance:** meets 13.3. Robot PASS on 3.0.69 plus Codex PASS on 3.0.70, same behaviour. BUG-698 is already FIXED (Codex-accepted, 3.0.64); record this as a regression still passing on 3.0.70.
   4. **BUG-855 note:** the header read "95 data issues" before and after, so no increase was seen. Every robot run saw 95 then 96. W1-01 and W1-02 had already edited this drawing, so this proves neither way; BUG-855 stays OPEN.
4. **W1-04 CDTWL pick list names the highest obvert (BUG-777, #1411).**
   1. **Result:** SEEN SURE (SEEN was the brief's normal word).
      1. **The usual-rule line, word for word:** `18.05 the top of the highest detention pipe pipe 10B03B (CE design rule) - 695 mm below the lowest lid, holds 21840 L [CE's usual rule]`.
      2. **Not reached:** the answer 18.70 and the freeboard lines. The mouse wheel over the history zoomed the drawing, the typed answer became PASTECLIP, and two Esc presses cancelled it.
   2. **Cross-check:** not done. The brief allowed opening only the P3 -> P2 pipe, and the line names 10B03B.
      1. **A clerk's inference, UNSURE:** 18.05 equals the new P3-end invert typed in W1-01 (17.60) plus the 450 mm diameter. That fits the highest-obvert rule.
      2. **Unknown:** Edit Pipe called that pipe 109E23, not 10B03B, so it is not known whether 10B03B is the same pipe.
   3. **Robot:** saw only the freeboard line (runs 39 to 47). No robot PASS on the usual-rule line.
   4. **New defect, a wording fault, seen on screen and confirmed in the source:** the line says "pipe pipe 10B03B" (the word doubled, and an internal handle instead of a pit-to-pit name). Rows 1 and 2 read "- -810 mm below the lowest lid" and "- -270 mm below the lowest lid" for levels that are ABOVE the lid. See section 3, item 3.
   5. **Fault:** the brief. Its step "scroll up with the mouse wheel over the history" while the prompt waits caused the PASTECLIP. It also ruled out the cross-check on the pipe the line actually names.
   6. **Re-run brief must change:**
      1. Screenshot, answer, and only then read the list with TEXTSCR after the command ends.
      2. Allow the cross-check on whichever pipe the line names: find it by handle, open Edit Pipe, Cancel.
      3. Run CDTWL on a fresh copy, BEFORE any W1-01 edit, so the levels are the fixture's own.
5. **W1-05 Tag refusal words (BUG-814, #1429).**
   1. **Result:** BLOCKED SURE. The pick at 64028,-69576.4 gave "Enter tag (e.g., DP, WT1, IO):" with no DP3 default and no Set/Remove question. The view showed pit labels P10 and P9, not DP3. CDFIXTAGS was not reached.
   2. **Robot:** PASS runs 34 and 35 (on 3.0.58 and 3.0.59).
   3. **Fault: the fixture as briefed.** DRV1_B1 carries no DP3 pair. The robot made it itself in session 2 of runs 34 and 35. It set `linking.cdTagRefusesUsedNumberedName` false through the guard, then ran CDTAG DP3 at 54436.3,-69493.6 and at 64028,-69576.4. Both blocks are pit blocks (P10 and P9).
   4. **Re-run brief must change:** one guarded settings pass (linking.cdTagRefusesUsedNumberedName false, restored by hash). Then the robot's two setup CDTAG lines, then the look as written. BUG-813 (rename does not apply) stays reported only.

### W2: the Pit Schedule window (run 05:51 to 06:19)

1. **W2-01 FROM column keeps the number of a non-P pit (BUG-784, #1413).**
   1. **Result:** NOT TESTED SURE: FIXTURE. All 27 rows were read. No inlet in DRV1_B1 comes from a non-P pit: C1 and X1 are only downstream groups. Source tags lose their digits as designed (AGI, TG), and every real pit name keeps its number (P1 to P7).
   2. **Robot:** none.
   3. **Fault:** the fixture. The brief assumed C1 feeds a pit.
   4. **Re-run brief must change:** a fixture with a pit named C2 (or CP3) upstream of a P pit. The desk prepares a saved test copy once, or the runner builds it. Codex then reads the one FROM cell.
2. **W2-02 Only a real change marks a cell (BUG-791, #1425).**
   1. **Result:** PASS SURE. F2 then Enter left the size cell plain. Cover 18.88 to 18.98 turned the cell gold and italic. Size 900 x 900 to 1200 x 900 stayed plain and resized P3 (the inspector read 1200 x 900).
   2. **Robot:** none. The robot can read the schedule's text but not cell colours. No runner case exists for cell marks (spec C01 to C40 has none).
   3. **Acceptance:** Codex PASS only. **Missing:** a robot or runner PASS of the same behaviour. A runner case could read the row's override flag through the window tree (not written yet). Otherwise Tim must rule whether a Codex look alone accepts a colour-only window item.
3. **W2-03 Delete cell stays blank (BUG-783, #1412).**
   1. **Result:** BLOCKED SURE. The right-click landed after the grid had shifted and opened the menu for P2's WT1 row. Its eight items: Highlight Inlet, Highlight Outlet, Move Up, Move Down, Restore Cell, Restore Row, Enable Row Override, Stop overriding. There was no "Delete cell".
   2. **Clerk's check of the installed source (40ee0a36):** `PitScheduleDialog.xaml` has exactly those eight row-menu items. The Delete cell code exists (`OnDeleteCellClicked`) but no menu item calls it. So the missing item is not caused by the grid shift: the installed window offers no Delete cell at all, and BUG-783's fix cannot be reached from this window.
   3. **Fault:** partly the brief (clicking a row expands the detail panel and shifts the grid). Mainly a product gap. See section 3, item 2.
   4. **Re-run brief must change:** wait until the desk confirms where Delete cell is meant to be offered. Until then BUG-783 cannot be looked at in the window.
4. **W2-04 Open and close leaves no undo step (BUG-817).**
   1. **Result:** FAIL SURE. With no edit, DBMOD went 21 to 21, but U echoed PITSCHEDULE. "BUG-817 STILL SEEN". REDO echoed PITSCHEDULE, then "Everything has been redone".
   2. **Robot:** saw it in runs 30, 31 and 32.
   3. **Verdict:** BUG-817 confirmed on Civil 3.0.70 by an independent Codex look. No drawing change was shown; the fault is the spare undo step (a drafter's first U after looking at the schedule does nothing useful).

### W3: the Checks palette (run 09:11 to 09:30; the 07:23 run stopped at Explorer)

**W3 07:23 run, all five looks NOT TESTED.** Cause: the start route. Explorer's address-bar suggestion list stayed over the file list, so the DWG row could not be seen. The shared file's first route (`explorer.exe "<dwg>"`) worked in every later run, so make it the only route.

1. **W3-01 The palette and its counts.**
   1. **Result:** DIFFERENT SURE. The command line and the palette agree: "42 to look at · 234 OK · 342 not known (CE could not check)". The palette is readable and nothing is cut off. The buttons are Show where, Check again and Close, with no Fix.
   2. **Clerk's check of the installed source:** `ChecksListControl.xaml` has exactly Show where, Check again and Close. Fix was never in this palette, so the brief's expected text was wrong.
   3. **Robot:** printed the same 42 / 234 / 342 on the command line (run 45). It cannot read the palette.
   4. **Fault:** the brief. Re-run (cheap, inside the next W3) with the expected buttons corrected. The look is then a likely PASS, but it needs a fresh Codex word, not a desk re-judgement.
2. **W3-02 A pipe with no tag reads "unnamed pipe" (BUG-753, #1387).**
   1. **Result:** BLOCKED UNSURE.
      1. **What was seen:** eight sampled views. 5 rows read "unnamed pipe" and 0 rows contained "CE-CIV-PIPE-". First row: "(!) unnamed pipe and WT4: unnamed pipe flows to WT4: Unresolved (not confirmed from the other side)".
      2. **Why not judged:** one wheel notch skipped about eight rows, and the list is about 50 to 70 pages long.
   2. **Robot:** 20 command-line rows with no handle (runs 33, 45). The palette list was never read in full.
   3. **Fault:** the brief and the tool. A wheel scan of a 618-row list is not a fair job for Codex.
   4. **Re-run must change:** give the whole-list text check to runner case C15 (ui-dump of the palette, "no row name shows a raw handle"), and keep only the look for Codex. Until C15 runs, BUG-753 stays "partly seen".
3. **W3-03 Show where moves the view.**
   1. **Result:** FAIL SURE, by the brief's own test.
      1. **The behaviour asked for:** Show where was enabled after the row was picked, and one press zoomed to WT4 and its pipe.
      2. **Why it counted as a FAIL:** DBMOD went from 1 to 17.
   2. **Clerk's reading:** AutoCAD's documented DBMOD value 16 means "the view changed". 17 = 1 (already set when the copy opened) + 16 (the Show where zoom). A zoom always does this; it is not a drawing change.
   3. **Fault:** the brief's yardstick ("DBMOD equals the base" for a step that zooms). Not a product fault.
   4. **Re-run brief must change:** judge "nothing in the drawing changed" by the U echo and by reading the named row's object before and after, not by DBMOD. If DBMOD is used, write "a rise of exactly 16 is the view and is expected".
4. **W3-04 CDCHECKCURRENT folds into Checks.**
   1. **Result:** PASS SURE. It printed "[CE] What CE Found is now part of Checks." and opened "Creative Engineering | Checks (CDCHECKS)". The old panel did not open.
   2. **Robot:** run 45 (3.0.68) saw the same sentence with the Checks switch ON.
   3. **Acceptance:** meets 13.3. Codex-accepted (Civil 3.0.70, 23 Oct 2026) for the Checks-list plan item. This is not a carpark bug; record it in the area file.
5. **W3-05 Reading leaves no change, one U.**
   1. **Result:** FAIL SURE, again by the DBMOD test (17 against base 1). U echoed GRAPHSCR (the brief's own text-window command), and REDO echoed GRAPHSCR, then "Everything has been redone". No CDCHECKS step and no Show where step was undone.
   2. **Clerk's reading:** the brief's own words "U does not take back anything that CE did" were met. The DBMOD rise is the 16 from W3-03's zoom.
   3. **Fault:** the brief (the DBMOD yardstick, plus TEXTSCR and GRAPHSCR typed before the U, which hides the useful echo).
   4. **Re-run brief must change:** read the history BEFORE the read-only steps. After the palette closes, type nothing but U.

### W4: Tidy labels with its switch ON (run 07:31 to 08:12)

1. **W4-01 Baseline counts (UX-LBL-03).**
   1. **Result:** PASS SURE. The three expected lines, word for word: "Will move 0 · Placed by hand (left alone) 0 · No clear spot found 1", "No clear spot found: pipe P3 -> P2 label. Move it by hand.", "No CE label needs to move." There was no offer to switch itself on.
   2. **Robot:** PASS runs 40 to 46.
   3. **Acceptance:** meets 13.3. Codex-accepted (Civil 3.0.70, 23 Oct 2026) for the baseline-counts part of UX-LBL-03.
2. **W4-02 A label placed by hand on a pit stays (UX-LBL-03, BUG-141 pit part).**
   1. **Result:** DIFFERENT SURE. CE printed `[CE Civil] pipe P8 -> open end start invert text: sits on "pit P8" but was placed by hand, so it stays.` The IL text stayed on the pit in the picture.
   2. **Robot:** runs 35 and 37 saw the older words, "a pipe's start invert text: sits on ...".
   3. **Fault:** the brief's expected text was stale. Since 3.0.67 (BUG-856) the line names the pipe, which is the intended improvement. The behaviour fits a PASS. A fresh Codex word is still needed, against corrected expected words.
   4. **Also seen:** BUG-857 (closing Grade mismatch with X still places the pipe with the typed 1 IN 100) is still present on 3.0.70.
   5. **Re-run brief must change:** use the 3.0.70 wording. The robot has no run of this line on 3.0.70, so its next run should repeat it to get both on the same words.
3. **W4-05 Esc leaves everything (cancel path; C-59 outcome lines).**
   1. **Result:** PASS SURE. Esc at "Move this label now?" gave "*Cancel*" and "[CE] Nothing was moved.". The text stayed on the pit and DBMOD was unchanged (17, 17). The log shows "Command outcome: CDTIDYLABELS cancelled 37562 ms" and an earlier "completed" line.
   2. **Robot:** run 47 on 3.0.70 ("Nothing was moved"; "CDTIDYLABELS cancelled 5512 ms").
   3. **Acceptance:** meets 13.3 on the same build. Codex-accepted (Civil 3.0.70, 23 Oct 2026) for the Esc part of UX-LBL-03 and for the CDTIDYLABELS "cancelled" outcome line.
4. **W4-03 Apply with Yes moves the label off the pit.**
   1. **Result:** NOT TESTED UNSURE.
      1. **Seen:** "[CE] Moved 1 · Placed by hand (left alone) 0 · No clear spot found 1." / "Type U once to put every label back."
      2. **At the working zoom:** the IL text moved clear of the pit outline (about 75 to 94 capture pixels).
      3. **Not judged:** at sheet size the detail was UNREADABLE after one enlargement.
   2. **Possible new defect, seen independently by both:** after Apply, the IL text crosses its own pipe line. Codex: "the top of red IL text crosses the pipe band". Robot run 35: the text sits "on the blue pipe fill (the 'in from the pipe end' spot)". See section 3, item 5.
   3. **Fault:** the brief (a sheet-size reading of a 100 mm-scale IL text in a 569-pixel view is too small to read).
   4. **Re-run brief must change:** judge clearance at the working zoom with a stated scale (window height in drawing units over SCREENSIZE pixels). Add a close-up whose question is "does the text cross the pipe line?".
5. **W4-04 One U puts every label back, REDO.**
   1. **Result:** DIFFERENT SURE. Each U echoed "(Lisp Expression) GROUP" and only changed the view; the IL stayed off P8.
   2. **Robot:** run 35 PASS (U echoed CDTIDYLABELS, REDO "Everything has been redone").
   3. **Fault:** the brief. W4-03's typed sheet zoom came between the Apply and the U.
   4. **Re-run brief must change:** TYPE U straight after the Apply screenshot, with no typed zoom. Take the pictures at the view set before the Apply.

### W5: the CDCALC window and the What CE Found panel (run 08:20 to 08:37)

1. **W5-01 CDCALC opens with the Older longitudinal tab still there (BUG-758 window half, #1408).**
   1. **Result:** PASS SURE. All ten tabs are visible in the expected order, with no arrow and no clipping. Detention is selected.
   2. **Robot:** none (the robot cannot read the CDCALC window). No runner case exists for it.
   3. **Acceptance:** Codex PASS only. **Missing:** a runner ui-dump case for the tab strip. Also untested: the OFF switch (the tab hidden) and BUG-758's engineering half (the older tab still draws without CDPROFILE's checks). BUG-758 stays OPEN in any case.
2. **W5-02 Profiles and Older longitudinal tabs open without drawing anything.**
   1. **Result:** PASS SURE. Both tabs are readable with no overlap. DBMOD was still 1 after the window closed. No CE line printed.
   2. **Robot:** none. Plan item, no bug id.
   3. **Acceptance:** Codex PASS only. **Missing:** a robot or runner case (none in the spec).
3. **W5-03 The older calculators are read-only (window words; BUG-772 cannot be tested).**
   1. **Result:** DIFFERENT SURE.
      1. **WSUD:** shows "Read-only — an Older calculator, under review before its rules are signed. ...", and typing 7 changed nothing.
      2. **Pump System:** typing 7 also changed nothing, but the tab has NO banner.
   2. **Clerk's check of the installed source:** the Pump System tab has the read-only words only as a tooltip on its tab header. WSUD has both the tooltip and the banner. This is a real, small inconsistency. See section 3, item 4.
   3. **BUG-772:** still cannot be tested (the WSUD boxes refuse typing in this build).
4. **W5-04 Close CDCALC with nothing changed.**
   1. **Result:** FAIL SURE. "CDCALC LEFT AN UNDO STEP". DBMOD stayed at 1 and no save line printed, but U echoed CDCALC, and REDO echoed CDCALC, then "Everything has been redone". Nothing visible changed.
   2. **Robot:** none.
   3. **Verdict:** a NEW fault, the same family as BUG-817 (PITSCHEDULE). See section 3, item 1.
5. **W5-05 CDCHECKCURRENT is quiet with the defaults (UX-PERF-01, #1514).**
   1. **Result:** PASS SURE. One line, "[CE] Drawing check complete. 27 items need checking. Nothing has been fixed automatically.", with no progress line. The What CE Found panel opened and is readable. The log shows "Command outcome: CDCHECKCURRENT completed 358 ms".
   2. **Robot:** run 45 (3.0.68) saw the same line and the same 27 items.
   3. **Acceptance:** meets 13.3. Codex-accepted (Civil 3.0.70, 23 Oct 2026) for UX-PERF-01's quiet default. The progress line with checks.showProgressWhenSlow ON is still untested.
6. **W5-06 Closing the panel keeps your own selection (BUG-809 item 4, #1430).**
   1. **Result:** BLOCKED SURE. The row clicked (a title-block attachment finding) is not a drawing object, so the panel said "This item is not an object in the drawing, so there is nothing to show." Case A was not completed and case B was not started.
   2. **Robot:** none.
   3. **Fault:** the brief ("click ONE row" without naming one that points at a pit or pipe).
   4. **Re-run brief must change:** name the row to click (a finding about a pit or pipe in the Items tab; read the 27 items from a robot run first). Alternatively skip the row click, since the fault is about the selection on Close, not the row.

### W6 to W8 (not yet reported)

1. **W6, Manager windows (W6-01 to W6-04: BUG-754, BUG-852 Manager half):** started 10:27, running when this was written.
2. **W7, CEMEMBER on Structural 1.0.121 (W7-01 to W7-06: #1504, #1505, #1506):** not run yet.
3. **W8, AD, LD, Q and QD at 1:50 (W8-01 to W8-05: #1497):** not run yet.

---

## 2. Lessons for the brief writers (what Codex trips over)

1. **A typed zoom is an undo step.** `(command "_.ZOOM" ...)` makes U echo "(Lisp Expression) GROUP" and undo the zoom, not the CE command (W1-02, W2-02, W4-04). Set the view once BEFORE the action, take every picture at that view, and type nothing between the action and U except plain readings such as `(list (getvar ...))`. Those readings made no undo step in W2-04.
2. **DBMOD rises by 16 when the view moves.** That is AutoCAD's documented "view changed" value, so any Show where or zoom turns 1 into 17 (W3-03, W3-05). The fixture also opens with DBMOD 1 already set, so DBMOD cannot show a real drawing change at all. Prove "nothing changed" by the U echo and by reading the object before and after.
3. **TEXTSCR and GRAPHSCR are commands too.** Typed just before a U, they make the U echo GRAPHSCR (W3-05). Read the history before the step, or after REDO.
4. **Never turn the mouse wheel over the command history while a command is waiting.** In W1-04 it zoomed the drawing, took the focus away, and the next typed answer became PASTECLIP. Answer first, then read with TEXTSCR after the command ends.
5. **Check every handle and expected value against the robot's own evidence, on the installed build.**
   1. **Wrong handle:** 10A98D is the P4 -> P3 pipe, not P3 -> P2 (W1-01).
   2. **Stale words:** the "placed by hand" line names the pipe since 3.0.67 (W4-02).
   3. **A button that never existed:** the Checks palette never had Fix (W3-01).
   4. **A menu item that is not there:** the Pit Schedule menu has no Delete cell (W2-03).
   5. **Button captions:** Edit Pipe's footer read "Save" to Codex.
6. **Copy the robot's setup, not just its result.** The DP3 pair (W1-05) and pit P8 exist only because the robot made them in its run (W1-05 needs one guarded key and two CDTAG lines first). If a fixture lacks the case (no non-P pit upstream, W2-01), say so before the run.
7. **Use the robot's route when one is proven.** A typed pre-select of a handle plus the command is safer than a double-click pixel (W1-01 hit a different pipe).
8. **List every box a step can raise, and give one rule for each.** Design Warnings (OK) was missing in W1-01. The Grade mismatch rule disagrees between briefs: W1 says close with Keep and never the X, W4 says close with the X.
9. **Clicking a Pit Schedule row moves the grid.** The detail panel expands, so a right-click aimed from an older screenshot hits another row (W2-03). Click once, take a new screenshot, then right-click.
10. **Do not ask Codex to scan a long list with the wheel.** One notch skips about 8 rows (W3-02). Give whole-list text checks to the runner (case C15) and keep Codex for the look.
11. **A row-selection step must name a row that points at a drawing object** (W5-06).
12. **Sheet-size checks need a readable target.** Judge clearance at a working zoom with a stated drawing-units-per-pixel figure (W4-03).
13. **Start AutoCAD only by the shell hand-off** (`explorer.exe "<dwg>"`). Address-bar typing in Explorer failed once (W3 07:23).
14. **Desk scheduling:** do not queue a Codex look while a robot or runner self-test holds the shared lock (W1 06:22).

---

## 3. New defects for the carpark (ready entry text)

The proposed numbers start at the carpark's "next id" (BUG-1030) at the time of writing. The desk confirms the next free number when it applies them, because other chats add entries too.

1. **Proposed BUG-1030: closing CDCALC leaves an undo step (U echoes CDCALC).**
   > ## BUG-1030 — Closing CDCALC with nothing changed leaves an undo step of its own
   >
   > **Command / Area:** CDCALC (Calculations window), Civil 3.0.70 (Codex W5-04, 23 Oct 2026, test copy LKW5_B1 of DRV1_B1). LOW.
   >
   > **Symptom:** Open CDCALC, look at the Detention, Profiles, Older longitudinal, WSUD and Pump System tabs, change nothing, press the window's Close. DBMOD stays at its base (1) and no save line prints, but one U echoes "CDCALC", and REDO echoes "CDCALC" then "Everything has been redone". Nothing visible changes. A drafter who looks at the calculations and then presses U to take back their last real edit finds the U spent on CDCALC.
   >
   > **Expected behaviour:** Looking at CDCALC adds no undo step unless it really changed the drawing (then it says what it changed).
   >
   > **Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_W5_20261023_0820.md` item 9; evidence W5-15-undo-cdcalc.png, W5-16-redo.png, W5-35-undo-closeup.png. Same family as BUG-817 (PITSCHEDULE). Test: robot runner case "open CDCALC, Close, U" asserting the U echo is not CDCALC.
   >
   > **Status:** OPEN
2. **Proposed BUG-1031: the Pit Schedule window offers no "Delete cell", so the BUG-783 fix cannot be reached.**
   > ## BUG-1031 — Pit Schedule window: no "Delete cell" item on the cell right-click menu
   >
   > **Command / Area:** PITSCHEDULE window, cell right-click menu, Civil 3.0.70 (Codex W2-03, 23 Oct 2026; source read at commit 40ee0a36). MEDIUM-LOW (a drafter cannot blank a cell from the window; BUG-783 cannot be checked).
   >
   > **Symptom:** Right-click a cell in the Pit Schedule window. The menu lists Highlight Inlet, Highlight Outlet, Move Up, Move Down, Restore Cell, Restore Row, Enable Row Override, Stop overriding. There is no "Delete cell". In the installed source `Dialogs/PitScheduleDialog.xaml` declares exactly these eight items, while `PitScheduleDialog.xaml.cs` still has an `OnDeleteCellClicked` handler that no menu item calls.
   >
   > **Expected behaviour:** Either the menu offers "Delete cell" (and BUG-783's stays-blank fix is then looked at), or the desk records that blanking a cell is done another way and BUG-783's route is rewritten. Needs the desk to check the intended design first; not confirmed whether the item was removed on purpose.
   >
   > **Reference:** `CODEX_VERIFY_W2_20261023_0551.md` item 11 (evidence W2-44-cover-menu.png, W2-45-cover-menu-full.png). Related BUG-783.
   >
   > **Status:** OPEN
3. **Proposed BUG-1032: CDTWL pick list says "pipe pipe 10B03B" and "- -810 mm below the lowest lid" for a level above the lid.**
   > ## BUG-1032 — CDTWL pick list: handle instead of a pipe name, doubled "pipe", and negative "below the lowest lid"
   >
   > **Command / Area:** CDTWL, the numbered top-water-level list, Civil 3.0.70 (Codex W1-04, 23 Oct 2026; source `Rules/TopWaterLevelCandidates.cs` at 40ee0a36). LOW (wording), with an engineering-reading risk.
   >
   > **Symptom:** The usual-rule row reads "18.05 the top of the highest detention pipe pipe 10B03B (CE design rule) - 695 mm below the lowest lid ...": the word "pipe" is doubled and the pipe is named by an internal handle, not "P3 -> P2". Rows for levels above the lowest lid read "19.55 ... - -810 mm below the lowest lid" and "19.01 ... - -270 mm below the lowest lid": a level 810 mm ABOVE the lid is written as minus 810 mm below it, after a dash, so it reads like a typing error and can be misread as safe.
   >
   > **Expected behaviour:** "the top of the highest detention pipe P3 -> P2" (the pit-to-pit name, or "unnamed pipe near P3" with no handle); a level above the lowest lid reads "810 mm ABOVE the lowest lid (water would come out)".
   >
   > **Reference:** `CODEX_VERIFY_W1_20261023_0842.md` item 9 (evidence W1-04-picklist.png, W1-04-list-scroll.png). Code: `TopWaterLevelCandidate.Line` builds "(lowest lid - level) mm below the lowest lid" with no sign check; `Collect` adds " " + rulePipe after "pipe". Related BUG-777, BUG-753 (no handles on screen).
   >
   > **Status:** OPEN
4. **Proposed BUG-1033: the "Older calculators — Pump System" tab has no read-only banner.**
   > ## BUG-1033 — CDCALC Pump System tab is read-only but shows no read-only banner
   >
   > **Command / Area:** CDCALC, tab "Older calculators — Pump System", Civil 3.0.70 (Codex W5-03, 23 Oct 2026). LOW.
   >
   > **Symptom:** The WSUD tab shows the banner "Read-only — an Older calculator, under review before its rules are signed. ..." and refuses typing. The Pump System tab also refuses typing (a typed 7 left 321 unchanged) but shows no banner; the read-only words are only in the tab-header tooltip, which a drafter will not hover. A drafter clicks a grey box, types, nothing happens, and is not told why.
   >
   > **Expected behaviour:** The same banner at the top of the Pump System tab as on WSUD.
   >
   > **Reference:** `CODEX_VERIFY_W5_20261023_0820.md` item 8 (evidence W5-11-pump-before.png, W5-12-pump-after7.png, W5-34-pump-closeup.png). Source: `Dialogs/CalculationsV2Dialog.xaml` tab header tooltips at :780 and :1005, banner only at :1024.
   >
   > **Status:** OPEN
5. **Proposed BUG-1034 (UNSURE, needs a sheet-size look): Tidy labels Apply puts the start invert text across its own pipe line.**
   > ## BUG-1034 — Tidy labels Apply moves the IL text "in from the pipe end" onto its own pipe line
   >
   > **Command / Area:** CDTIDYLABELS Apply (switch linking.tidyLabelsEnabled ON), Civil 3.0.70 (Codex W4-03, 23 Oct 2026) and Civil 3.0.59 (robot run 35). LOW-MEDIUM (plan readability); needs a drafting judgement.
   >
   > **Symptom:** After a hand MOVE puts "IL 18.000" on new pit P8, Tidy labels Apply with Yes moves it 500 mm "in from the pipe end (4)". The text is now clear of the pit, but it sits across the pipe: Codex saw "the top of red IL text crosses the pipe band" at the working zoom; the robot's run 35 shot showed it "sitting on the blue pipe fill". On a plotted sheet the invert text would print over the pipe line.
   >
   > **Expected behaviour:** The moved text is clear of the pit AND of its own pipe line (beside the pipe, like the other invert texts). If sitting on the pipe is the intended "in from the pipe end" spot, the desk records that and closes this.
   >
   > **Reference:** `CODEX_VERIFY_W4_20261023_0731.md` item 9 (evidence W4-33-applied-detail2.png, W4-34-afterapply.png); `release-v3-colleagues-CLAUDE_DRIVER_RUN35_V2_2026-10-20.md` B item 4. Related UX-LBL-03.
   >
   > **Status:** OPEN

---

## 4. Proposed status-line edits for BUG_CARPARK.md (the desk applies them)

Every "old" text is the current status line read on 23 Oct 10:20. None of these changes an entry to FIXED.

1. **BUG-698.**
   1. **Old:** `**Status:** FIXED — 2026-10-20 (Codex-accepted, V2-04, Civil 3.0.64; reconciled 23 Oct 2026)`
   2. **New:** keep it, and add the body line `**Codex W1-03 (23 Oct 2026, Civil 3.0.70): PASS SURE, regression still passes.** Rows identical before and after CDSYNC (11 pits, 49 pipes relinked); robot run 46 PASS on 3.0.69.`
2. **BUG-753.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1387, #1388; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1387, #1388; Codex W3-02 BLOCKED UNSURE 23 Oct: 8 sampled palette views show "unnamed pipe" and no CE-CIV-PIPE- text, but the 618-row list was not read end to end; needs runner case C15 for the full text, then a Codex look)`
3. **BUG-758.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1407, #1408; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1407, #1408; Codex W5-01 PASS SURE 23 Oct for the window half only: the Older longitudinal tab is present by default, ten tabs readable; no robot or runner case; the tab-hidden switch and the engineering half are untested)`
4. **BUG-772.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1428; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1428; cannot be tested on this build: Codex W5-03, 23 Oct, saw the WSUD tab read-only, typing refused)`
5. **BUG-777.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1411; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1411; Codex W1-04 SEEN 23 Oct: the usual-rule row offers 18.05 and names pipe 10B03B; cross-check of invert plus diameter not done; wording fault split out as BUG-1032; engineering default needs the cross-check before acceptance)`
6. **BUG-783.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1412; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1412; Codex W2-03 BLOCKED 23 Oct: the cell right-click menu has no Delete cell item on this build, so the route cannot be reached; see BUG-1031)`
7. **BUG-784.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1413; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1413; Codex W2-01 NOT TESTED 23 Oct: FIXTURE, DRV1_B1 has no inlet from a non-P pit; real pit names P1 to P7 keep their numbers; needs a fixture with a C or CP pit upstream)`
8. **BUG-791.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1425; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1425; Codex W2-02 PASS SURE 23 Oct on 3.0.70: F2-Enter leaves the cell plain, a typed Cover is marked gold/italic, a typed size resizes the pit and stays plain; robot cannot judge cell colours and no runner case exists, so not yet Codex-accepted under RULES 13.3)`
9. **BUG-809.**
   1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1409, #1418, #1430; not yet tested by robot or Codex; reconciled 23 Oct 2026)`
   2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1409, #1418, #1430; item 4 Codex W5-06 BLOCKED 23 Oct: the row clicked was not a drawing object; items 1 to 5 still untested)`
10. **BUG-814.**
    1. **Old:** `**Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1429, #1439; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)`
    2. **New:** `**Status:** OPEN (fix installed in Civil 3.0.70 via PR #1429, #1439; robot PASS runs 34 and 35; Codex W1-05 BLOCKED 23 Oct: the fresh fixture has no DP3 tags, which the robot builds itself; re-run with the robot's setup)`
11. **BUG-817.**
    1. **Old:** `**Status:** OPEN`
    2. **New:** `**Status:** OPEN (Codex W2-04 FAIL SURE 23 Oct on Civil 3.0.70: open and Close with no edit, DBMOD 21 to 21, one U echoes PITSCHEDULE; REDO "Everything has been redone"; confirmed independently of the robot)`
12. **BUG-855.**
    1. **Old:** `**Status:** OPEN`
    2. **New:** keep it, and add the body line `**Codex W1-03 (23 Oct, 3.0.70):** the header read 95 before and 95 after CDSYNC, but the copy had already been edited by W1-01 and W1-02, so this neither confirms nor clears the robot's 95 to 96.`
13. **BUG-857.**
    1. **Old:** `**Status:** OPEN`
    2. **New:** keep it, and add the body line `**Codex W4-02 (23 Oct, 3.0.70): still seen.** Closing Grade mismatch with X placed the pipe with the typed 1 IN 100. Still needs Tim's call on what X should mean.`
14. **Five new entries:** add BUG-1030 to BUG-1034 from section 3 (numbers confirmed by the desk), and move the carpark's "Next BUG ID to use" on by five.

**Plan items, not carpark lines (record them in the area file, `release-v3-colleagues.md` or the plan queue):**

1. **UX-LBL-03 Tidy labels:** baseline counts (W4-01) and the Esc path (W4-05) are Codex-accepted (Civil 3.0.70, 23 Oct 2026). Apply, U and REDO, and the hand-placed line on 3.0.70 words, are still open.
2. **UX-PERF-01 (#1514):** the quiet default is Codex-accepted (Civil 3.0.70, 23 Oct 2026). The progress line with its switch ON is untested.
3. **Checks list:** CDCHECKCURRENT folding into Checks is Codex-accepted (Civil 3.0.70, 23 Oct 2026). The palette window (W3-01) needs a re-look with corrected buttons.
4. **C-59 command outcome lines:** the CDTIDYLABELS "cancelled" line is Codex-accepted (Civil 3.0.70, 23 Oct 2026).
5. **UX-LBL-02 and the Edit Pipe cascade:** still only robot-proven; the W1-01 re-run is needed.

---

## 5. What this ledger did NOT do

1. **No picture was opened by the clerk.** Every result is Codex's own word from its report. The three source reads (Pit Schedule menu, Checks palette buttons, CDTWL line format) were read-only, at the installed commit.
2. **No engineering value was judged.** 18.05 and the grade figures are reported only.
3. **W6, W7 and W8 are not covered.** W6 was running at the time of writing; W7 and W8 had not started.
4. **BUG_CARPARK.md was not edited.**
