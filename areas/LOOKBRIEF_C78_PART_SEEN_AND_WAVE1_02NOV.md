# Codex look briefs: the SEEN halves of the C-78 PART cases, and the wave-1 looks (draft text)

Written by a read-only Sonnet drafter for CE 05, Mon 2 Nov 2026, at CE 00's request (CE 02 needs exact-step briefs today because Tim is away all day). Nothing was built, run, installed or pushed. No AutoCAD, no robot, no Codex run. Every expected word below comes from the robot case files, the C-78 review reports or the existing Codex briefs; where a word was not found in a file it says NOT FOUND. None of this is proven until Codex runs it in real AutoCAD on copies.

---

## FOR TIM

1. **How many looks:** 14 new looks (C78S-01 to C78S-14) for the seen halves of C-78 PART cases, in 2 batches: C78S1 (8 looks, about 45 minutes) and C78S2 (6 looks, about 50 minutes, needs a written GO because five of them need a Settings switch changed before AutoCAD starts).
2. **Wave-1 looks need no new writing:** all nine (BUG-246, 312, 573, 779, 783, 785, 786, 744, 746) are already written in `C:\Lisp Files\_CODEX_RUNNER\verifyA3_c88_full.txt` as W1-246, W1-312, W1-573, W1-779, W1-783, W1-785, W1-786, W1-744 and W1-746, with A3-00 (place a Pit Schedule) first. That is Codex batch A3, Mon 2 Nov 19:00. `FILL_CODEX_BRIEFS_02NOV.md` holds none of them (it is a queue report, and its jobs cover other looks). One of the nine will not run as written: W1-783 (Delete cell) has no menu item on 3.0.88 (BUG-1031), so it is NOT TESTED until the desk decides.
3. **Already covered, not repeated:** four PART looks are in `verifyA78c_c88_full.txt` (Grade mismatch Cancel, plain RG label, short-pipe leader, Esc and X). The leader retake is in `verifyA2_c88_full.txt` and `verifyA2b_c88_full.txt` as A2-03. The Esc result is already DIFFERENT on 3.0.88: the Grade mismatch box stayed open (CE 02 log, Sun 1 Nov 22:08).
4. **What I could not find:** the ledger (`runner-reports\ledger.json`) has no PART state at all (only PASS 1565, FAIL 696, FLAKY 1, 2262 runs). PART comes from the Opus review slips (reports C78_REVIEW_A to D: 43 PART). I took each "Codex must SEE" line from those reports. I also did not find the exact warning words for the curved-line and closed-line pipe (R39b), the Cascade Preview text (R11) or the Pit Schedule header count (R13, BUG-855): those looks say "copy the words".
5. **Skipped (reasons at the end):** 12 PART items. The main ones: the 100 / 125 / 150 per cent window look (needs a Windows display-scale change on Tim's PC), the label-grade question (Tim's call), the IL decimals question (Tim's call).
6. **The word "Save" appears in these briefs only as the caption of CE's own Edit Pipe button ("Edit pipe, Save", looks 03 and 09). That is a CE window button, not a file box. No look presses an Export, Save or Open box button. The banned BUG-421 word appears nowhere in this file (searched).**

---

## HOW TO USE THIS FILE (for CE 02)

1. **Each look is one block** with: look id, bug, build, fixture, steps, PASS, FAIL, what to screenshot, and the verdict line. Copy the blocks into one launcher per batch.
2. **COPY WORD FOR WORD** from `verifyA78c_c88_full.txt`: rules N1 to N17, D1 to D12 and changes (a) to (i), with the look id changed. Those rules win over anything below. Do not retype them.
3. **Evidence folder:** `C:\CE_WORK\codex\<look id>_<yyyyMMdd_HHmm>\` with copies, exports, shots and logs. Report `REPORT_<look id>.md` in that folder.
4. **Verdict line, one per look:** `<look id> PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE` then one plain sentence. Example: `C78S-03 PASS SURE: the arrow stayed pointing west after the size-only change.`
5. **Fixture:** a copy of DRV1_B1 inside `C:\Lisp Files\_TEST_COPIES_20260923` (copies only, never saved back). Build to test: Civil 3.0.88 (3fbb9da5), Manager 1.1.88, Structural 1.0.125.
6. **Typed text:** every type step is a whole command sent by D2 type, with `n meaning Enter. No typed line holds an open bracket and none holds a save-type word.
7. **If a Grade mismatch window opens where a look does not expect one:** copy its words, click Cancel, write DIFFERENT and carry on (rule (m) of verifyA78c).
8. **If a step names a switch:** read it with `D2 settings-temp status`. If it is not in the state the look needs, write NOT TESTED, NEEDS GO and move to the next look. Codex never changes a setting.
9. **ROUTE R (used by looks 04, 05, 08 and 09; this is the robot's SETUP-R47v written for Codex):**
   1. D2 pick-first 109D56, then D2 type "_.MOVE`n0,0`n0,2000" -Enter -Force (pit P3 moves up 2000 mm).
   2. D2 type "PIT`n150000,-80000" -Enter -Force -ExpectWindow "New Pit" -TimeoutSec 120. In the New Pit window type 19.000 in the cover level box. Click "Continue placement". When the window has closed, D2 esc-prompt three times (one Esc per question).
   3. D2 type "CD`n150000,-80000`n170000,-80000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. Type 18.000 in the first level box and 17.800 in the second (20 m at 0.2 m fall is 1 in 100, so no Grade mismatch window). Click "Start Pipe". When the window has closed, D2 esc-prompt once.
   4. D2 pick-first 10EC5D (the SPOT LEVEL block), then D2 type "_.MOVE`n0,0`n81839,-53713" -Enter -Force (it lands on the invert text at the start of the new pipe).
   5. D2 type "_.ZOOM _W 148500,-81500 152500,-78500" -Enter. This is the working view.
   6. After ROUTE R the new pit is P8 and the new pipe runs from P8 to an open end. Take picture R0 and write what you see at the pipe's start: the invert text IL 18.000 and the SPOT LEVEL block on top of it.

---

# BATCH C78S1 (8 looks, about 45 minutes, runs on what is installed, no GO needed)

Order is pilot-critical first: the pipe window a drafter meets every day, then Edit Pipe, then Tidy labels, then drawn-line pipes, then copies and the Pit Schedule.

---

## C78S-01 Grade mismatch window: the typed level is flatter, and the grade box is changed (B-057b, PR #1873; robot cases N33d and N33e)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. Empty ground 148000 to 172000 by -82000 to -58000. Switch `pipe.mismatchBoxSkipsOwnSuggestion`: shipped default is ON (a missing key reads ON; the robot cases pin it ON). Read it first with D2 settings-temp status and write it.
2. **Why this is a look:** the robot proved the window opens and read its words as text. Nobody has seen the window with these numbers. A drafter must still get the question when a typed level or a changed grade really disagrees.
3. **Steps:**
   1. D2 type "_.ZOOM _W 146000,-76000 174000,-58000" -Enter. Picture G0 (empty ground).
   2. D2 type "PIT`n150000,-70000" -Enter -Force -ExpectWindow "New Pit" -TimeoutSec 120. Type 19.000 in the cover level box. Click "Continue placement". After the window closes, D2 esc-prompt three times. Then D2 type "PIT`n154550,-70000" -Enter -Force -ExpectWindow "New Pit" -TimeoutSec 120, type 19.000, click "Continue placement", then D2 esc-prompt three times. Picture G1 (two pits, 4.55 m apart centre to centre, about 4.1 m between the pit walls).
   3. **Scenario A (typed level flatter):** D2 type "CD`n150000,-70000`n154550,-70000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. In the New Pipe window: diameter 100; untick "Pipe text" on plan (so no leader clicks are asked); untick "I know one end ..."; click "Set my own" and type 100 in its "1 in" box. Clear the first level box, type 19.45, wait 2 seconds. Write what the second level box now reads (expected 19.40, filled by CE). Then type 19.43 in the second level box. Screenshot the whole window (A1). Click "Start Pipe".
   4. Wait up to 30 seconds for the Grade mismatch window (it is not on the driver's wait list; watch your own screenshots). Click its title bar. Screenshot the whole window (M1) and enlarge once on its text and buttons (M1z). Copy word for word: the title, the heading, every line of the body, the three button captions left to right. Write whether any caption is cut off.
   5. Click "Cancel". D2 history 15: copy every [CE] line. D2 getvar CMDACTIVE (0 expected). Picture G2: no pipe between the pits.
   6. **Scenario B (grade box changed):** D2 type "CD`n150000,-70000`n154550,-70000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. Same box settings as step 3 (diameter 100, Pipe text off, "I know one end" off, Set my own 100). Clear the first level box, type 19.45, wait 2 seconds, write what the second level box reads (expected 19.40). Now change the "1 in" box from 100 to 200. Screenshot (B1). Click "Start Pipe". Wait up to 30 seconds. Click the window's title bar. Screenshot the whole window (M2) and enlarge once (M2z). Copy the words and buttons as in step 4. Click "Cancel". D2 history 15. Picture G3.
4. **PASS:** both windows open. Scenario A buttons read "Use 1 IN 205" and "Keep 1 IN 100". Scenario B buttons read "Use 1 IN 82" and "Keep 1 IN 200". All three buttons (the two above and "Cancel") are fully visible and readable. Cancel draws nothing.
5. **FAIL:** either scenario draws a pipe with no window (the box was wrongly skipped for a real disagreement), or Cancel leaves a pipe between the pits.
6. **DIFFERENT:** the window opens with other numbers (write them), or the second level box did not read 19.40 after you typed 19.45 (copy what it read: this is the remembered-levels finding in CASE_WRITING_C78_REPORT_30OCT.md section 8, NOT a Codex fault).
7. **Screenshot:** G0, G1, A1, M1, M1z, G2, B1, M2, M2z, G3.
8. **Old fault:** before B-057b the box also opened when CE's own suggested level was the cause. These two cases must STILL ask, so a missing window is the fault here.
9. **Verdict line:** `C78S-01 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE` then one sentence.

---

## C78S-02 Grade mismatch window: CE carried a fall you typed (B-057b; robot case N33f)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy, the same two pits as C78S-01 (place them again on a fresh copy, steps 1 and 2 of C78S-01). Switch default ON as in C78S-01.
2. **Steps:**
   1. D2 type "CD`n150000,-70000`n154550,-70000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. Diameter 100, "Pipe text" off, "I know one end ..." off, "Set my own" with 100 in the "1 in" box.
   2. Clear the first level box and type 19.45. Write what the second box reads (expected 19.40). Type 19.30 in the second level box. Then clear the first level box again and type 19.50. Wait 2 seconds. Write what the second box now reads (expected 19.35: CE carries the 0.15 m fall you typed). Screenshot (F1).
   3. Click "Start Pipe". Wait up to 30 seconds. Click the Grade mismatch window's title bar. Screenshot the whole window (M1) and enlarge once (M1z). Copy the words and the three button captions. Click "Cancel". D2 history 15. D2 getvar CMDACTIVE (0 expected). Picture F2.
3. **PASS:** the window opens; buttons read "Use 1 IN 27" and "Keep 1 IN 100"; nothing is drawn after Cancel.
4. **FAIL:** a pipe is drawn with no window.
5. **DIFFERENT:** other numbers (write them); or the second box reads something other than 19.35.
6. **Screenshot:** F1, M1, M1z, F2.
7. **Verdict line:** `C78S-02 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-03 Edit Pipe: the flow arrow after a reversal and after a size-only change (BUG-1222, BUG-223, BUG-686; robot cases R32 and R32b)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. No switch.
2. **Why this is a look:** the robot proved the arrow's number (the stored angle). Only the eye shows whether the arrow on the drawing points the right way and whether the level texts sit on the correct ends.
3. **Steps:**
   1. D2 type "_.ZOOM _W 148000,-95000 172000,-87000" -Enter. Picture E0.
   2. **Pipe A (upper, y -90000):** D2 type "CD`n150000,-90000`n170000,-90000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. Type 18.000 in the first level box and 17.800 in the second. Click "Start Pipe". After the window closes, D2 esc-prompt once.
   3. **Pipe B (lower, y -92000):** same, with D2 type "CD`n150000,-92000`n170000,-92000`n" and the same two levels. Picture E1 (zoom in so both pipes fill the width). Write which way each flow arrow points (expected: both point east, towards the lower level at x 170000) and which level text sits at each end.
   4. **Reverse pipe A:** click pipe A once by pixel (the upper pipe, on its line, away from the arrow and texts). D2 type "CDEDIT" -Enter -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120. Type 17.800 in the first level box and 18.000 in the second. Click the window's main apply button (caption "Edit pipe, Save"; this is CE's own Edit Pipe window, not a file box). Wait 6 seconds. D2 esc-prompt once. Picture E2: write which way pipe A's arrow points now (expected: west, reversed), where each IL text sits (expected: swapped to the other ends), and that pipe B is unchanged (arrow east).
   5. **Size only:** click pipe A once by pixel. D2 type "CDEDIT" -Enter -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120. Change ONLY the diameter to 150; touch no other box. Click the same apply button. Wait 6 seconds. D2 esc-prompt once. D2 history 15: copy every [CE] line (expected "Pipe updated." with no warning). Picture E3: write which way pipe A's arrow points now and whether the label now reads 150 (copy its words).
   6. Click pipe B once, CDEDIT as above, change only the diameter to 150, same button. Picture E4: pipe B's arrow still points east.
4. **PASS:** after step 4 pipe A's arrow points west and its texts are swapped; after step 5 the arrow STILL points west (it did not flip back); pipe B's arrow stays east after step 6; "Pipe updated." shows with no warning.
5. **FAIL:** the arrow flips back after the size-only change, or does not turn after the reversal, or a text lands on the wrong end.
6. **DIFFERENT:** a warning shows (copy it); the label wording differs (copy it).
7. **Screenshot:** E0 to E4, enlarged once on each arrow.
8. **Old fault:** BUG-1222, a size-only Save turned the arrow round.
9. **Verdict line:** `C78S-03 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-04 Tidy labels preview names the pipe and Esc moves nothing (BUG-856, UX-LBL-03; robot case R16)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. Switch `linking.tidyLabelsEnabled`: the robot notes say the default is now ON. Read it with D2 settings-temp status; if it reads false, write NOT TESTED, NEEDS GO.
2. **Steps:**
   1. Do ROUTE R. Picture R0 at the working view. Note the pixel position of the text IL 18.000 and of the SPOT LEVEL block over it.
   2. D2 type "CDTIDYLABELS`nAll" -Enter -Force. Wait 5 seconds. Screenshot the command line (T1). Copy word for word every [CE] line, including the line that names the pipe and the question.
   3. D2 esc-prompt once (this is the Esc answer to the question). D2 history 15: copy the [CE] lines. Picture T2 at the same view.
3. **PASS:** the preview line reads "pipe P8 -> open end start invert text would move 275 mm (further out)." and the summary has "Will move 1"; after Esc the history says "Nothing was moved."; picture T2 shows the IL 18.000 text and the SPOT LEVEL block at the same pixels as R0 (no label moved).
4. **FAIL:** any text has moved in T2, or the preview names no pipe.
5. **DIFFERENT:** other words or numbers (copy them); "No clear spot found 1" naming P3 -> P2 is expected, write it as seen.
6. **Screenshot:** R0, T1, T2.
7. **Verdict line:** `C78S-04 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-05 Tidy labels answered Yes: where the text lands, and one U (UX-LBL-03; robot case N67v87)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. Same switch rule as C78S-04.
2. **Steps:**
   1. Do ROUTE R. Picture R0. Write where IL 18.000 sits against the SPOT LEVEL block.
   2. D2 type "CDTIDYLABELS`nAll`nYes" -Enter -Force. Wait 5 seconds. D2 history 15: copy the [CE] lines (expected "Moved 1" and "Type U once to put every label back."). Picture T1 at the same view, then enlarge once on the invert text (T1z).
   3. Write: where the IL text now sits (further along the pipe, off the block?), whether it still crosses the pipe line, the SPOT LEVEL block or the pit, and whether it is readable.
   4. D2 type "U" -Enter. D2 history 5. Picture T2: the text is back exactly where it was in R0.
3. **PASS:** the text has moved clear of the SPOT LEVEL block, is readable, does not cross the pipe or pit, and one U puts it back at its R0 position.
4. **FAIL:** the text lands on the pipe, pit or another text, or one U leaves it moved.
5. **DIFFERENT:** it moved but sits somewhere you cannot judge (write the distance in the picture in mm using the grid scale you know from the zoom height).
6. **Screenshot:** R0, T1, T1z, T2.
7. **Verdict line:** `C78S-05 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-06 Pipe on a drawn curved line and on a closed line: straight between the corners (BUG-684; robot case R39b)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. No switch.
2. **Steps:**
   1. **Curved line:** D2 type "_.PLINE`n150000,-99000`n155000,-99000`nA`n160000,-97000`n" -Enter -Force. D2 type "_.ZOOM _W 148000,-100000 162000,-95000" -Enter. Picture C0 (a line, then a curved piece).
   2. D2 type "CD`nE`n152000,-99000" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 120 (E means use the existing line; the point is on the straight part). In the window type 18.000 and 17.800 in the two level boxes. Click "Start Pipe". After the window closes, D2 esc-prompt three times. D2 history 15: copy the whole warning word for word (the wording is NOT FOUND in the files I read; copy it). Picture C1, enlarge once on the curved end (C1z).
   3. **Closed line:** D2 type "_.PLINE`n150000,-93000`n154000,-93000`n154000,-90000`n150000,-90000`nC" -Enter -Force. D2 type "_.ZOOM _W 148000,-95000 162000,-88000" -Enter. Picture K0. D2 type "CD`nE`n152000,-93000" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 120, same two levels, "Start Pipe", D2 esc-prompt three times, D2 history 15, picture K1.
3. **PASS:** for each line CE warns in plain words that the pipe runs straight between the corners; a pipe is made; your drawn line is still there; in C1z and K1 the pipe is a straight run between the line's corner points and does NOT bend with the arc.
4. **FAIL:** no warning, the drawn line vanished, or the pipe bends round the arc.
5. **DIFFERENT:** the warning wording is unreadable or cut off (copy it).
6. **Screenshot:** C0, C1, C1z, K0, K1.
7. **Verdict line:** `C78S-06 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-07 Copy a pit while layer 25TEXT is locked: the copy looks and reads right (BUG-672 message half; robot case R33m)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. No switch.
2. **Steps:**
   1. D2 type "_.ZOOM _C 53778,-27000 14000" -Enter. Picture L0 (pit P3 and its label).
   2. D2 type "_.-LAYER`n_LOCK`n25TEXT`n`n" -Enter -Force. D2 pick-first 109D56. D2 type "_.COPY`n0,0`n0,-5000`n`n" -Enter -Force. D2 esc-prompt once. Wait 3 seconds.
   3. D2 history 15: copy every [CE] line word for word. Screenshot the command line (L1).
   4. D2 type "_.ZOOM _C 53778,-30500 4000" -Enter. Wait 5 seconds. Picture L2: the new pit. Write: whether it is a whole pit with its number, whether its cover text (CL ...) is missing, and the number it got.
   5. D2 type "U" -Enter. Picture L3 (the copy is gone). D2 type "_.-LAYER`n_UNLOCK`n25TEXT`n`n" -Enter -Force.
3. **PASS:** the copy is a whole pit with its own number and NO cover text; the message says the copy "got their own number but no cover text", names layer 25TEXT and gives the Undo sentence; it never says the copy has "no label"; one U removes the copy.
4. **FAIL:** the message says "no label" (the old wording), omits 25TEXT, or the copy shows a number on the wrong layer.
5. **DIFFERENT:** other words (copy them).
6. **Screenshot:** L0, L1, L2, L3.
7. **Verdict line:** `C78S-07 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-08 CDSYNC leaves the Pit Schedule exactly as it was (spec cards C42 and D27, BUG-855 header; robot case R13v87)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. No switch.
2. **Steps:**
   1. Do ROUTE R (it leaves one new pit and pipe, as the robot case does).
   2. D2 type "PITSCHEDULE" -Enter -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120. Click the title bar. Screenshot the whole window (S1). Copy: the header text, the row count shown (the robot read 27 rows on this fixture), every column title left to right, and the first three rows. Write whether any column or title is cut off. Click "Close".
   3. D2 type "CDSYNC" -Enter -Force. Wait 5 seconds. D2 history 15: copy the whole warning line, then the line "Pits relinked: 12, Pipes relinked: 50" if present.
   4. D2 type "PITSCHEDULE" -Enter -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120. Screenshot the whole window (S2). Copy the same header, row count, columns and first three rows. Click "Close".
   5. Write whether S1 and S2 are identical row for row.
3. **PASS:** the warning comes BEFORE the relink line; S1 and S2 show the same header, the same row count and the same rows; nothing is cut off.
4. **FAIL:** any row, cell or header count differs between S1 and S2.
5. **DIFFERENT:** a count other than 12 and 50 (write it); the header shows no count (write NOT SHOWN, this is not a fault by itself).
6. **Screenshot:** S1, S2.
7. **Verdict line:** `C78S-08 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

# BATCH C78S2 (6 looks, about 50 minutes, needs a written GO for the switch states below)

Each look names its switch. CE 02 sets the switch(es) through the driver's settings-temp before AutoCAD starts (settings are read at launch, so a mid-session change does nothing), writes the hash of the file before and after, and puts it back. Codex only reads with D2 settings-temp status. If a switch is not in the state the look needs: `NOT TESTED, NEEDS GO`.

---

## C78S-09 Edit Pipe cascade: the Recalculate question and the Cascade Preview (spec card C40; robot case R11v87)

1. **Build and fixture:** 3.0.88, DRV1_B1 copy. No switch.
2. **Steps:**
   1. D2 type "_.ZOOM _W 50000,-30000 80000,-20000" -Enter. Picture Q0 (the IL texts of the pipes around pit P3).
   2. D2 pick-first 10A98D (a pipe at P3). D2 type "CDEDIT`nY" -Enter -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120. Type 17.60 in the first level box and 17.50 in the second. Click the window's main apply button (caption "Edit pipe, Save"; CE's own window).
   3. A question box with Recalculate in its title should open. Screenshot it whole (Q1). Copy its title and every word. Click "Yes".
   4. The "Cascade Preview" window should open. Screenshot it whole (Q2). Copy: the title, the pipe and pit counts it lists (the robot read 4 pipes and 3 pits), the minimum grade line ("Min grade: 1:16") if shown, and every button. Click "Apply".
   5. Wait 3 seconds. Picture Q3 at the working view: write the new IL texts. D2 type "U" -Enter. Picture Q4: the texts are back as in Q0.
3. **PASS:** the question reads clearly in plain words; the preview lists the downstream pipes and pits; after Apply the texts change; one U puts every text back.
4. **FAIL:** a text is left changed after U, or the preview lists nothing.
5. **DIFFERENT:** the wording is jargon or cut off (copy it); other counts (write them).
6. **Screenshot:** Q0 to Q4.
7. **Verdict line:** `C78S-09 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-10 Double-click on a downpipe tag opens CE's Edit source window (robot case N42; needs a GO)

1. **Switches needed:** `doubleClick.sourceEditWindow` true and `doubleClick.opensEditWindow` false (the robot case sets them; the shipped defaults are NOT FOUND in the files I read: read both with D2 settings-temp status first and write them).
2. **Build and fixture:** 3.0.88, DRV1_B1 copy.
3. **Steps:**
   1. D2 type "_.ZOOM _C 3000,3000 3000" -Enter. D2 type "DP`n3000,3000`n" -Enter -Force. Wait 5 seconds. D2 esc-prompt once. D2 type "_.ZOOM _C 3000,3000 1200" -Enter. Picture D0. Write where the red centre of the symbol is and where the angled DP text is.
   2. Double-click the red centre by pixel (one double-click, no drag). Wait 3 seconds. Screenshot (D1): CE's "Edit source" window should show DP1. Write whether AutoCAD's own attribute editor window ever appears. Click "Close" in the Edit source window.
   3. Double-click the angled DP text by pixel. Wait 3 seconds. Screenshot (D2). Close the Edit source window with its "Close" button.
4. **PASS:** both double-clicks open the Edit source window showing DP1 and AutoCAD's attribute editor never appears.
5. **FAIL:** the attribute editor opens, nothing opens, or another source shows.
6. **BLOCKED:** the red centre cannot be found on the picture (write it; this is a view fault, not a product fault).
7. **Screenshot:** D0, D1, D2.
8. **Verdict line:** `C78S-10 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`. Not covered by this look: the green label (BUG-860), and OK saving a changed tag.

---

## C78S-11 Esc at the pit label question: no label by default, one label at the usual spot when the switch is ON (UX-CPLAN-22; robot cases N81 and N80; the ON half needs a GO)

1. **Switch:** `linking.pitLabelOnEsc`. Default is OFF (UserSettings.cs line 1244, from the C-78 review). Run part A on the default. Run part B only with the switch ON; otherwise B is NOT TESTED, NEEDS GO.
2. **Build and fixture:** 3.0.88, DRV1_B1 copy.
3. **Steps (A, switch OFF):**
   1. D2 type "_.ZOOM _C 150000,-80000 6000" -Enter. D2 type "PIT`n150000,-80000" -Enter -Force -ExpectWindow "New Pit" -TimeoutSec 120. Type 19.000 in the cover level box. Click "Continue placement". Screenshot the command line when the label question shows (P1) and copy its words.
   2. D2 esc-prompt once (Esc at the label question). D2 esc-prompt twice more. D2 history 15. Picture P2 around the pit: no label beside the pit.
   3. D2 type "U" -Enter. Picture P3: the pit is gone.
4. **Steps (B, switch ON, a fresh drawing copy):** the same, but after the label question press Esc once. Picture P4. Write: whether one label appears, which corner of the pit it is on, and its distance from the pit centre in mm (read it from the picture scale). D2 history 15: copy "[CE] Pit label placed at the usual spot beside the pit." if present. D2 type "U" -Enter. Picture P5: pit and label are both gone.
5. **PASS:** A has no label and no [CE] label line; B has exactly one label, clear of the pit symbol and readable, with the "usual spot" line; one U removes everything in both parts.
6. **FAIL:** A draws a label, or B draws none or two, or the label sits on the pit symbol.
7. **DIFFERENT:** the spot is far from the pit or off to one side (write the distance and the side). Whether the spot matches Tim's learned office spot is Tim's call, not this look's.
8. **Screenshot:** P1 to P5.
9. **Verdict line:** one line per part: `C78S-11A ...` and `C78S-11B ...`.

---

## C78S-12 Pit copied by ROTATE and SCALE onto itself: the Inspector shows P3 kept its pipes (BUG-1227 part A; robot case N70; needs a GO)

1. **Switches needed:** `linking.pitCopyKeepsOriginalPipeEnds` true and `linking.cleanUpGripRotateScaleCopies` false (the robot case sets them; defaults NOT FOUND, read both with D2 settings-temp status).
2. **Build and fixture:** 3.0.88, DRV1_B1 copy.
3. **Steps:**
   1. D2 type "_.ZOOM _C 53778,-25570 8000" -Enter. Picture I0.
   2. D2 pick-first 109D56. D2 type "CDINSPECTOR" -Enter -Force. If the Inspector asks for an object, click pit P3 by pixel. Screenshot the Inspector (I1). Copy every pipe it lists for P3 (the robot case reads five pipes joined to P3). Close it with its own Close button or its X.
   3. D2 type "_.COPY`n0,0`n0,-5000`n`n" -Enter -Force after D2 pick-first 109D56. D2 esc-prompt once. Wait 4 seconds.
   4. D2 pick-first 109D56. D2 type "_.ROTATE`n53777.7,-25569.9`nC`n90`n" -Enter -Force. Wait 8 seconds. D2 esc-prompt once.
   5. D2 pick-first 109D56. D2 type "_.SCALE`n53777.7,-25569.9`nC`n1.5`n" -Enter -Force. Wait 8 seconds. D2 esc-prompt once.
   6. D2 history 20: copy the [CE] lines (expected one keep-back line per copy: "P11 sits on pipe ends already joined to P3; they stay joined to P3." and the same for P12).
   7. D2 pick-first 109D56 again, then D2 type "CDINSPECTOR" -Enter -Force. Screenshot (I2). Copy every pipe it lists for P3. Do the same for P11 if its Inspector can be opened.
4. **PASS:** I2 lists the same pipes as I1 for P3 (nothing moved over to P11 or P12) and the keep-back lines show.
5. **FAIL:** P3's pipe list is shorter in I2 than in I1, or P11 or P12 lists pipes that were P3's.
6. **BLOCKED:** CDINSPECTOR cannot be opened on a pit (write what it did).
7. **Screenshot:** I0, I1, I2.
8. **Verdict line:** `C78S-12 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-13 Grade mismatch window returns when the "skip own suggestion" switch is OFF (B-057b; robot case N33s; needs a GO)

1. **Switch needed:** `pipe.mismatchBoxSkipsOwnSuggestion` false.
2. **Steps:** the same pits, CD points, New Pipe settings and typing as C78S-01 scenario A steps 1 to 3 up to and including typing 19.45 in the first level box (do NOT type a second level; leave CE's own 19.40). Write what the second box reads. Screenshot (N1). Click "Start Pipe". Wait up to 30 seconds. Screenshot the whole Grade mismatch window (M1) and enlarge once (M1z). Copy the words and the three buttons. Click "Cancel". D2 history 15.
3. **PASS:** the window opens; buttons read "Use 1 IN 82" and "Keep 1 IN 100". (This is the old behaviour; with the switch ON the same typing draws no window, which is C78S-01's control.)
4. **FAIL:** no window opens with the switch OFF.
5. **Screenshot:** N1, M1, M1z.
6. **Verdict line:** `C78S-13 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`.

---

## C78S-14 Grade mismatch window with the Cancel switch OFF: the old two-button box, and what Esc does (BUG-857 off half; robot case N33_grade_mismatch_x_off; needs a GO)

1. **Switch needed:** `grade.mismatchBoxCloseCancels` false.
2. **Steps:**
   1. D2 type "_.ZOOM _C 160000,-68000 26000" -Enter. D2 type "CD`n150000,-66000`n170000,-66000`n" -Enter -Force -ExpectWindow "New Pipe" -TimeoutSec 150. Untick "I know one end ..."; click "Set my own" and type 100 in its "1 in" box; type 18.000 and 17.900 in the two level boxes (a 20 m pipe at 1 in 200 against a typed 1 in 100). Click "Start Pipe".
   2. Wait up to 30 seconds. Click the window's title bar. Screenshot the whole window (O1) and enlarge once (O1z). Copy the heading, the body and the buttons. Expected: "Use 1 IN 200" and "Keep 1 IN 100" only, and NO Cancel button and NO line "places no pipe".
   3. Click the window's title bar once, then press the Esc key once. Screenshot straight away (O2). D2 history 15: copy every [CE] line. D2 getvar CMDACTIVE. Write whether the window closed and whether a pipe was drawn (picture O3 of the drawing).
   4. If the window stayed open, click "Keep 1 IN 100" to finish (a pipe is drawn on the copy only).
3. **PASS:** the two-button box shows (no Cancel, no "places no pipe"). Record what Esc did: the review note says Esc places the pipe at the typed 1 in 100 in this old mode; write exactly what you saw.
4. **FAIL:** a Cancel button or the "places no pipe" line shows with the switch OFF.
5. **Screenshot:** O1, O1z, O2, O3.
6. **Verdict line:** `C78S-14 PASS|FAIL|BLOCKED|NOT TESTED SURE|UNSURE`. Note for the desk: on 3.0.88 with the switch ON, Esc did NOT close the box (A78c, 1 Nov 22:08). This look shows the switch-OFF behaviour for comparison only.

---

# WAVE-1 LOOKS (nine bugs): already written, nothing new needed

All nine are in `C:\Lisp Files\_CODEX_RUNNER\verifyA3_c88_full.txt` (written Mon 2 Nov 06:22, Codex batch A3, Mon 2 Nov 19:00 to 22:30). `verifyW1_c88_full.txt` holds an earlier copy. The banned BUG-421 word appears in neither (counted: 0 in verifyA3).

1. **A3-00** (first, exploratory): place a linked Pit Schedule. Every Pit Schedule look below needs it. BLOCKED at A3-00 means stop and record.
2. **BUG-246:** W1-246 (also robot case W246 for the window words; the rest is K1_16 in ROBOT_CASE_DRAFTS_WAVE1_02NOV.md).
3. **BUG-312:** W1-312 (held-back labels survive a close and reopen; K1_01).
4. **BUG-573:** W1-573 (trailing zeros give no false changes; K1_02).
5. **BUG-779:** W1-779 (moving the drawn schedule changes no record; K1_03).
6. **BUG-783:** W1-783 (a blanked cell stays blank). It will not run as written: the cell menu on 3.0.88 has no Delete cell item (BUG-1031). The brief itself says NOT TESTED until CE 02 confirms steps. First cheap step for CE 02 to allow: open the cell menu and copy its items.
7. **BUG-785:** W1-785 (depth on the drawn schedule uses one rule; K1_05).
8. **BUG-786:** W1-786 (a second inlet pipe's rows stay with their pit; K1_06).
9. **BUG-744:** W1-744 (CDFIXTAGS renames only, adds no label; K1_07).
10. **BUG-746:** W1-746 (removing a tag erases its record; K1_08). The Wave-1 draft says the best proof is a headless test; the Codex look is optional.
11. **Other looks that already exist and are NOT repeated here:** K1 Excel (`verifyK1_c88_full.txt`, batch A), K1_02b BUG-1268 (queued job 210_look_k1_02b_cdcalc_xlsx.txt, output LOOKBRIEF_K1_02B_02NOV.md), W234 (queued job 214, output LOOKBRIEF_W234_BLOCKED_CASES_02NOV.md), batch B and C looks (queued jobs 211 to 213), the ribbon, second-drawing and two-start looks (job 219).

---

# PART CASES SKIPPED, AND WHY

1. **N33_grade_mismatch_x: window look at 100, 125 and 150 per cent** (review A, item 8). It needs the Windows display scale changed on Tim's PC. That is Tim's call; not briefed.
2. **N33_grade_mismatch_x Cancel look, N90 plain RG label, N20 short-pipe leader, N33 Esc and X:** already in `verifyA78c_c88_full.txt` as A78-01, A78-02, A78-03, A78-04. Results so far: A78-01 and A78-02 PASS (A78 and A78b reports), A78-03 DIFFERENT (the view was too tight; retake is A2-03 in verifyA2 and verifyA2b), A78-04 Esc DIFFERENT (the box stayed open; for CE 00 and CE 05 to decide). The X result was not found in the log lines I read.
3. **N33c window look:** the same window as C78S-01 with other numbers ("Use 1 IN 51", "Keep 1 IN 100"). Review A calls N33c a control that passes before and after the fix, so it adds little. Add it to C78S-01 as scenario C if CE 02 wants it.
4. **N33a, N33b, N33g, N33h: the label grade on the pipe** (for example "1 IN 100" on what is really a 1 in 137 pipe in N33h). Review B says that is the open CE 04 label question and Tim's call. The robot cases switch the pipe text off.
5. **N91 start-up smoke: ribbon tabs.** Covered by K1's start screenshot and the ribbon brief (job 219).
6. **R03v87: IL text with 3 decimals ("IL 18.000") against Tim's example "IL 33.00".** A drafting ruling for Tim, not a look.
7. **N90: the raingarden label sits on GUIDELINES, which is non-plot, so it will not print** (review C item 4). Judgement for Tim; checking it needs a print preview, which this look file does not drive.
8. **N06v87, N28v87, N44v87: "never recolour" and the pipe and label layer checks.** Not built (never-recolour) or checkable by the robot; no seen half.
9. **N24 CDRENUMBER numbering rule and the plan-label spot, N40 order groups LPD, OG and CP, N41v87 "Drawing Border" wording, N61 "stays hidden", N17 and N18 REDO:** each is a robot extension (more checks), not a look.
10. **R14h wording for the newly named pits (P3 180, P4 160, P5 150 mm), R15, R17, R19 several-pipe branch, R01v87 ending with Enter, R02 and R02b 75 mm edge:** robot checks the reviewers named; no seen half.
11. **N27 pit-move step, N80 "learned office spot" match to Tim's rule:** C78S-11 records the spot; whether it matches the office is Tim's call.
12. **N23v87, N38, N70 to N72, N90x, R14v87, R15v87, R16v87 (preview half), R32bv87, R39bv87, R39v87, N17v87, N18v87, N19v87 (ACCEPT FULL or robot-complete):** no seen half owed, except where C78S-03, 04, 06 and 12 add a picture check.
