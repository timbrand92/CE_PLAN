# Acceptance ledger: Codex X-series looks of 23 to 24 Oct 2026 (X5 to X9)

Written Sat 24 Oct 2026 by the desk bookkeeper (Sonnet). Read-only on every input; the carpark entries BUG-1085 to BUG-1087 and this file are the only things written. Nothing here marks anything FIXED. Build under test in every run, read by Codex from the live DLLs: Civil 3.0.72+f7f7d551, Manager 1.1.72+f7f7d551, Structural 1.0.122+e6d597c0.

**Inputs read:** `CODEX_VERIFY_X5_20261023_2213.md` (the earlier X5 NOT STARTED reports of 21:40, 21:49 and 22:01 are ignored), `X6_20261023_2346`, `X7_20261024_0011`, `X8_20261024_0045`, `X9_20261024_0124` in `C:\Lisp Files\_TEST_COPIES_20260923`; `BUG_CARPARK.md`; `ACCEPTANCE_LEDGER_W_SERIES_2026-10-23.md`; RULES 4.5 and the 13.3 amendment of 20 Oct.

---

## ANSWER FIRST

1. **19 looks were judged across X5 to X9.** PASS 3, FAIL 9, DIFFERENT 0, BLOCKED 1, NOT TESTED 1, SEEN 4, ABSENT 1.

2. **Counts per run:**
   1. **X5 (CEMEMBER, Q and QD, 5 looks):** PASS 3, FAIL 0, DIFFERENT 0, BLOCKED 0, NOT TESTED 1, SEEN 1.
   2. **X6 (Manager and About windows, 4 looks):** PASS 0, FAIL 4, DIFFERENT 0, BLOCKED 0, NOT TESTED 0.
   3. **X7 (CDCALC and Pit Schedule, 4 looks):** PASS 0, FAIL 4, DIFFERENT 0, BLOCKED 0, NOT TESTED 0.
   4. **X8 (CDTWL list, Pit Schedule menu, Edit Pipe, 3 looks):** PASS 0, FAIL 1, DIFFERENT 0, BLOCKED 0, NOT TESTED 0, SEEN 1, ABSENT 1.
   5. **X9 (Tidy labels, 3 looks):** PASS 0, FAIL 0, DIFFERENT 0, BLOCKED 1, NOT TESTED 0, SEEN 2.

3. **Codex-accepted-ready: 3 looks.** X5-03, X5-04 and X5-05 are PASS, SURE, in real AutoCAD 2027 on a test copy, with the steps and screenshots recorded. They settle plan items (the CEMEMBER repeat and Reset answers, one U for a whole CEMEMBER run, and the Q and QD arrowheads at 1:50), not carpark bugs. No carpark entry can be marked FIXED from this series.

4. **No bug was fixed by anything the nine FAILs saw.** Every FAIL shows an old fault still present on the installed build. Six are bugs already in the carpark (BUG-090, BUG-817, BUG-1030, BUG-1032, BUG-1033, and BUG-1031 as an ABSENT). Three are new and are now filed:
   1. **BUG-1085:** opening and closing CEMANAGER leaves an undo step (X6-02, X6-03).
   2. **BUG-1086:** CE_VERSION leaves an undo step (X6-04).
   3. **BUG-1087:** the "CE SUITE" heading in About CE Suite is white on near-white (X6-01).

5. **Not a product fault:** X9-03 stopped because the real question was "Move these 2 labels now?" and the brief named "Move this label now?". BUG-1034 is neither passed nor failed. The next brief must allow the plural question.

6. **The undo family is now one pattern, seen five times on the installed build:** PITSCHEDULE (BUG-817), CDCALC (BUG-1030), CEMANAGER (BUG-1085) and CE_VERSION (BUG-1086) each leave their own undo step after a pure look. One shared fix is likely.

---

## 1. Every look

### X5: CEMEMBER and Q and QD (run 22:13 to about 22:52, 23 Oct; Structural 1.0.122)

1. **X5-01 NOT TESTED, UNSURE (UNREADABLE).** SI side elevation of a 310UB32, ends Both. The member (3000 mm, layers 18CONT 4 and 25CONT 2) and the prompts were as expected, but the small jog in each end break line is about 6 pixels wide, under the 20-pixel rule, so the break shape was not judged. Needs a closer zoom on a retry.
2. **X5-02 SEEN, UNSURE.** Section, Beyond: a dashed outline on 9HIDDEN2 with no hatch. The command history covered the lower flange, so the full outline and centring are not accepted.
3. **X5-03 PASS, SURE.** After X5-02, Enter alone took the remembered answers (View Section, name 310UB32, Section Beyond, Base Centre); the third outline sat in its view; View Reset printed "CEMEMBER: previous choices cleared." and the name question then had no remembered name. Evidence X5-35 to X5-47.
4. **X5-04 PASS, SURE.** Three side members in one run: one U echoed CEMEMBER and removed all three, the objects were equal to the saved set, and REDO brought all three back after a 12 second wait with no input. Evidence X5-48 to X5-66.
5. **X5-05 PASS, SURE.** Q and QD both completed at DIMSCALE 50 with the text TEST (no refusal). Q arrowhead about 150.4 units against style DIMASZ 3.0 x 50 = 150; QD dot about 75.9 units (ratio about 0.505). These are screen measurements, not engineering acceptance. Evidence X5-67 to X5-90.
6. **Housekeeping:** the settings files were identical at start and end; OSMODE and CLAYER unchanged; QUIT with No; the run's first line says AutoCAD was running because a different session (Claude-driverv3, pid 74648) started after X5 released its lock. Not X5's doing.

### X6: Manager and About windows (run 23:46, Manager 1.1.72)

1. **X6-01 FAIL, SURE (About CE Suite).** The three version rows match the DLLs (v3.0.72, v1.0.122, v1.1.72), no "CONFLICT" and no "Not loaded". But the AutoCAD row is still cut off, the Runtime and hover-help lines are hidden (wheel and edge drag did not help), and the "CE SUITE" heading is white on near-white. Existing BUG-090 (clipped rows) still seen; the heading is new as BUG-1087.
2. **X6-02 FAIL, SURE (Manager, no tabs).** After only Status was visible, the first U echoed CEMANAGER and the count stayed at 2; REDO said "Nothing to redo"; a second U took back the anchor circle. New BUG-1085.
3. **X6-03 FAIL, SURE (Manager after Status, Module, Updates, Help).** Same result; the tabs made no difference. BUG-1085.
4. **X6-04 FAIL, SURE (CE_VERSION).** The first U echoed CE_VERSION and the count stayed at 2. New BUG-1086.

### X7: CDCALC and Pit Schedule (run 00:11, Civil 3.0.72)

1. **X7-01 FAIL, SURE (CDCALC untouched, runs A and B).** Both runs: the first U echoed CDCALC and the count stayed at 1055. REDO said "Nothing to redo" (the 23 Oct W5 look saw "Everything has been redone", a small difference for the desk to note, no cause inferred). Existing BUG-1030, still seen on 3.0.72.
2. **X7-02 FAIL, SURE (CDCALC after Detention, Older longitudinal, Profiles, WSUD, Pump System).** Same: U echoed CDCALC. BUG-1030.
3. **X7-03 FAIL, SURE (read-only banner).** WSUD shows the banner and refuses typing; Pump System has no banner and a typed 7 did not appear (321 stayed). Existing BUG-1033, still seen.
4. **X7-04 FAIL, SURE (PITSCHEDULE).** U echoed PITSCHEDULE and the count stayed at 1055. Existing BUG-817, still seen on 3.0.72.

### X8: CDTWL list, Pit Schedule cell menus, Edit Pipe (run 00:45, Civil 3.0.72)

1. **X8-01 FAIL, SURE (CDTWL pick list at 10, 100 and 1000 m3).** All three runs: "the top of the highest detention pipe pipe 10B03B" (doubled "pipe", a handle in place of a pit name) on the usual-rule row, "-810 mm below the lowest lid" and "-270 mm below the lowest lid" on the rows above the lid, and no "ABOVE" row. Existing BUG-1032, still seen.
2. **X8-02 ABSENT, SURE (Pit Schedule cell menus).** The Cover, Pit Size and Inlet diameter cells each show the same eight items and none is a Delete cell or any blanking route. Existing BUG-1031, still true. This is the desk's open question, not a new fault.
3. **X8-03 SEEN, SURE (Edit Pipe).** For handle 10B03B the window reads "Flow: P6 -> P5", 375 mm, upstream 17.67 and downstream 17.58 m AHD. So the pipe's real pit-to-pit name exists and the CDTWL list could use it. An inline banner read "Material conflict: using STORMPRO from Pipe label in this drawing" (Inspector showed UPVC); nothing was changed. No new fault asserted.

### X9: Tidy labels Apply (run 01:24, Civil 3.0.72, BUG-1034)

1. **X9-01 SEEN, SURE.** Two pits (P8, P11) and two pipes built, both start invert texts moved by hand, and Civil said they stay because they were placed by hand.
2. **X9-02 SEEN, SURE.** Both hand-placed texts readable over their pits at the working zoom (about 223 and 182 pixels across).
3. **X9-03 BLOCKED, SURE.** Preview read "Will move 2 / No clear spot found 2", with "pipe P8 -> open end start invert text would move 500 mm" and "pipe P11 ... 375 mm". The question was "Move these 2 labels now?", not the briefed "Move this label now?", so Esc was pressed ("Nothing was moved"). Nothing after Apply was seen. BUG-1034 undecided.

---

## 2. Which looks are Codex-accepted-ready, and what each would let a desk write

1. **X5-03 (CEMEMBER repeat and Reset):** Codex-accepted-ready for the S-40 CEMEMBER plan items (#1504, #1505, #1506: repeat with the last choices, Reset clears). Needs the robot's matching PASS to complete RULES 13.3. No carpark BUG is closed by it.
2. **X5-04 (one U for a whole CEMEMBER run, REDO restores):** Codex-accepted-ready for the same S-40 CEMEMBER items (one U for a whole run). It also answers the old W7 fault where U followed a typed zoom. No carpark BUG closed.
3. **X5-05 (Q and QD arrowheads at 1:50):** Codex-accepted-ready for #1497 (AD, LD, Q at any DIMSCALE). It does not check that the dimension style is put back after cancel, so BUG-621 stays open.
4. **Not ready:** X5-01 (unreadable), X5-02 (limited), and all of X6 to X9 (FAIL, ABSENT, SEEN or BLOCKED).

**Proposed carpark edits (for the desk; this file does not make them).** None flips an entry to "FIXED (Codex-accepted, build, date)". All are "still seen" lines, each to be added with the look name and build:
1. **BUG-090:** still seen on Manager 1.1.72 (X6-01), rows still cut off.
2. **BUG-817:** still seen on Civil 3.0.72 (X7-04).
3. **BUG-1030:** still seen on Civil 3.0.72 (X7-01, X7-02), REDO difference noted.
4. **BUG-1031:** still true on 3.0.72 (X8-02).
5. **BUG-1032:** still seen on 3.0.72 (X8-01).
6. **BUG-1033:** still seen on 3.0.72 (X7-03).
7. **BUG-1034:** unchanged; X9 did not reach Apply (X9-03 BLOCKED).

---

## 3. What this series did NOT test

1. **X5-01 and X5-02:** the end break jog and the full Beyond outline were not read.
2. **BUG-1034:** the position of the moved invert text after Apply, against its own pipe line, and the sheet-size views.
3. **Engineering values:** nothing was accepted; X5 measurements and X8 and X9 numbers are readings only.
4. **Q and QD style restore after cancel** (BUG-621) and the CEMEMBER section hatch: not part of these looks.
5. **U and REDO for Tidy labels Apply:** not run.

**Brief lessons for the next runs:**
1. X5 retry: zoom closer on the CEMEMBER end break jog (X5-01) and move the command history off the lower flange (X5-02).
2. X9 retry: allow the plural "Move these 2 labels now?" question and note that the text box returned nil, so the overlap check needs a pipe width in the view.
3. For the undo looks, keep the rule "no zoom or typed command between the close and the U", which X6 and X7 kept.
