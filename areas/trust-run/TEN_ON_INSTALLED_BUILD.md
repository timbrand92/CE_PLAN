# Ten core tools on the installed build (now Civil 3.0.90.10, batch 8)

Lane trust-acad-evidence, on the controller's order of Sat 14 Nov about 23:18: run the ten tools on the build already installed, one at a time, robot first, then one Codex look. Every PASS has a screenshot or a log at a full path, or it is NOT TESTED.

## FOR TIM (read this first)

1. **Build on the PC:** Civil 3.0.90.3+11c0093c, Structural 1.0.126.1, Manager 1.1.89 (nothing installed tonight).
2. **Drawings:** scratch copies of the standard test drawing only (C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY and C:\Lisp Files\_TEST_COPIES_20260923). No client job, no template.
3. **The plain job per tool:** run it, Cancel, Esc, one Undo, save and reopen.
4. **Progress:** 1 of 10 tools robot-tested (PIT: 5 PASS of 5). Codex looks: 0 of 10 done so far.
5. **Nothing here is marked FIXED.** Acceptance needs robot PASS plus Codex PASS, each with evidence.

## 1. PIT (place a pit)

**Robot pass: Sat 14 Nov 23:29 to 23:38, copy C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\CLDTP_TEN_PIT.dwg.**
Log: C:\CE_WORK\scratch\trust_install\ten_pit.out. CE record readings: C:\CE_WORK\scratch\trustprobe\reads\TP_0.record.txt to TP_6.record.txt.

1. **P-1 Cancel: PASS.** PIT with a point opened the New Pit window; closing it gave "PIT command cancelled." Pits 11 before, 11 after; objects 1034 before, 1034 after.
2. **P-2 Esc: PASS.** Esc at "Specify pit insertion point:" gave "*Cancel*" and "PIT command cancelled." Counts unchanged (11 pits, 1034 objects).
3. **P-3 Place: PASS.** Cover 20.00, Continue placement: "Pit placed successfully." Pits 11 to 12, objects 1034 to 1035. Esc at the label and cover text questions stopped cleanly ("Everything placed stays; U takes back the last one").
4. **P-4 One Undo: PASS.** One U: pits back to 11, objects back to 1034, in the drawing and in CE's record.
5. **P-5 Place again, save, reopen: PASS.** 12 pits before save; after reopening 12 pits, 1035 objects, drawing not marked changed.
6. **Settings:** the 4 settings files had the same SHA-256 at the end as at the start. AutoCAD closed by the robot.
7. **Note (not a fault):** at P-2 the driver raised its "waiting at a prompt" alarm; this is expected when PIT waits for a point, and the Esc then worked.

**Codex look (verifyTPIT14):** first run 23:40 NOT STARTED (my launcher named a different lock owner from the full brief; fixed in the brief maker, nothing in AutoCAD happened). Second run started 23:44; result below when it lands.

**PIT verdict so far: robot PASS 5 of 5. Codex: pending.**

## 2 to 10

Not run yet: CD, CDEDIT, PITSCHEDULE, CDRULES with CDCALC, CDCHECKCURRENT, MR, CDRENUMBER (apply with Yes, and the loop message). CDRUNSOLVE level-writing skipped on the controller's order.

## Also on this order

1. **Retake Codex screenshots for BUG-1456, BUG-1355, BUG-1457 (saved case):** not started.
2. **CDLPD (BUG-1298):** to be written as PROVISIONAL (awaiting Tim), never FIXED.

## ON CIVIL 3.0.90.10 (batch 8, installed 15 Nov 07:48; the controller's order: the ten run on batch 8, PIT first, robot then one Codex look each)

### 1. PIT

1. **Robot (09:44 to 09:55), copy `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\CLDTP_TEN_PIT.dwg`: 5 PASS of 5.** Log `C:\CE_WORK\scratch\trust_install\ten_pit_b8.out`; readings `C:\CE_WORK\scratch\trustprobe\reads\TP_0.record.txt` to `TP_6.record.txt`.
   - P-1 Cancel (New Pit window closed, nothing placed): pits 11 and objects 1034 before and after.
   - P-2 Esc at "Specify pit insertion point:": unchanged.
   - P-3 place (cover 20.00, Continue placement): pits 11 to 12, objects 1034 to 1035.
   - P-4 one U: back to 11 / 1034 in the drawing and CE's record.
   - P-5 place again, save, reopen: 12 pits after reopening, drawing not marked changed.
   - Settings files the same; AutoCAD closed by the driver.
2. **Codex look verifyTPIT14: running from 09:55.**
3. **Codex look TPIT14 T1 (09:55 to 10:12): Cancel, Esc and place PASS; one U DIFFERENT because of my brief.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPIT14_T1_20261115_0956.md`.
   - T-01 Cancel PASS ("PIT command cancelled.", R2 11 / R3 1054 unchanged); T-02 Esc PASS ("*Cancel*", "PIT command cancelled."); T-03 place PASS ("Pit placed successfully.", R2 12).
   - T-04 DIFFERENT: the brief had Codex ZOOM after placing, so the one U echoed "ZOOM" and the pit stayed (R2 12). Not a CE fault (the robot's P-4 shows one U removes the pit). T-05 then counted 13 for the same reason; save and reopen themselves worked.
   - Brief fixed (zoom before the command, U must echo PIT); fixture reset from the standard copy (SHA-256 34BBE37C...); rerun from 10:1x.
4. **Codex look TPIT14 T1 rerun (10:13 to 10:29): every PIT behaviour step PASS.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPIT14_T1_20261115_1014.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TPIT14_T1_20261115_1014\screenshots\`.
   - T-01 Cancel PASS ("PIT command cancelled.", R2 11 / R3 1054 = START; TPIT14-03-window.png, TPIT14-04-cancel.png).
   - T-02 Esc PASS ("Specify pit insertion point: *Cancel*", "PIT command cancelled."; TPIT14-05-insertion.png, TPIT14-06-escape.png).
   - T-03 place PASS ("Pit placed successfully.", R2 12; TPIT14-12-cover-retry.png, TPIT14-16-placed.png).
   - **T-04 one U PASS** (the U echoed `PIT`; the pit gone; R2 11 / R3 1054 = START; TPIT14-17-one-undo.png vs TPIT14-16-placed.png).
   - T-05 save and reopen PASS (R2 12 after reopening, pit visible; TPIT14-28-reopened.png, TPIT14-30-final-pit.png).
   - T-00 DIFFERENT: Codex's own start paperwork (log snapshot not taken), not a CE behaviour. Settings files unchanged.
5. **PIT: robot PASS 5 of 5 + Codex PASS 5 of 5 on Civil 3.0.90.10, each with logs and screenshots.** For the controller to write; I have not marked anything.

**Controller's check, PIT on Civil 3.0.90.10, Sun 15 Nov 2026 10:40:** robot log read (`C:\CE_WORK\scratch\trust_install\ten_pit_b8.out`: P-1 to P-5 PASS, settings unchanged); Codex report read (`CODEX_VERIFY_TPIT14_T1_20261115_1014.md`: PASS 5, FAIL 0); screenshot `TPIT14-29-reopened-pit.png` seen (the placed pit present after save and reopen). **PIT's everyday job (Cancel, Esc, place, one Undo, save and reopen) is proven by robot and Codex.** NOT yet written as the tool accepted: Tim's five-rule gate (15 Nov) also wants it used on a copy of a real job (copies being made), and PIT's known open points are not looked at (blank cover level: place and warn, wording owed to Tim; a plastic pit cannot be numbered in the one-page window, fix being built to his picture).

### 2. CD (draw a pipe)

1. **Robot (10:30 to 10:39, copy `CLDTP_TEN_CD.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_cd_b8.out`; readings TC_0 to TC_6):** C-1 Cancel (New Pipe window closed, nothing drawn) PASS: pipes 49 / objects 1034 unchanged. C-3 draw P10 to P9 (Start Pipe) PASS: pipes 49 to 50. C-4 one U PASS: back to 49 / 1034, CE's record back too. C-5 draw again, save, reopen PASS: 50 pipes after reopening, DBMOD 0.
2. **C-2 Esc redone (10:39 to 10:43, copy `CLDTP_TEN_CDE.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_cd_esc.out`): PASS.** The first run's Esc step was not a test (the driver refuses a bare CD; it needs -ExpectPrompt). Redone: "Specify first point or [Existing line] [Existing]: *Cancel*" then "[CE] CD command cancelled."; drawing and CE's record identical.
3. **CD robot: 5 PASS of 5.** Settings files the same each time.
4. **Codex look TCD14 T1 (10:43 to 10:58): every CD step SEEN working, but T-01 to T-04 NOT TESTED (EVIDENCE).** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCD14_T1_20261115_1044.md`. Codex saw: Cancel (R2 30 / R3 1054 unchanged), Esc ("*Cancel*", unchanged), draw (R2 31 / R3 1057), **one U echoed CD and the pipe was gone (back to 30 / 1054)**, save and reopen (31 / 1057, fresh screenshot TCD14-15-fresh-screenshot-0.jpg: T-05 PASS). But its saver kept the T-00 image for T-01 to T-04, so no visual PASS for those. Rerun planned.

### 3. CDEDIT (edit a pit or pipe)

1. **Robot (10:59 to 11:08, copy `CLDTP_TEN_CDEDIT.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_cdedit.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_105626\`):**
   - E-1 Edit Pit on P10, Cancel without saving: PASS (CE's record identical apart from the known format/path stamp; drawing identical). TEN_CDEDIT_pit_cancel.png.
   - E-2 Esc at "Select a pit, pipe, source or CE text to edit:": PASS ("*Cancel*"; record and drawing identical).
   - E-3 Edit Pipe on a pipe just drawn with CD (heading "Flow: P10 → P9"), Cancel without saving: PASS (record byte-identical, drawing identical). TEN_CDEDIT_pipe_cancel.png.
   - **NOT done by the robot:** Save, one U after Save, save and reopen ("Edit pit, Save" refused by the driver; Tim's question 16). Codex look TCE14.
5. **Codex look TCD14 rerun (11:10 to 11:17): BLOCKED at T-02.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCD14_T1_20261115_1110.md`. T-01 Cancel PASS; Esc did cancel CD, but Codex stopped on the driver's expected 'waiting at a prompt' alarm. Brief now says that alarm is expected at that one step; third run from 11:1x.
6. **Codex look TCD14 third run (11:18 to 11:31): every CD step PASS, fresh screenshots.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCD14_T1_20261115_1119.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TCD14_T1_20261115_1119\screenshots\`.
   - T-01 Cancel PASS (R2 30 / R3 1054 = START; TCD14-04 to -06). T-02 Esc PASS ("*Cancel*"; TCD14-07, -08). T-03 draw PASS (R2 31 / R3 1057; TCD14-09 to -12). **T-04 one U PASS: echoed CD, pipe gone, back to 30 / 1054 (TCD14-13-one-undo.png).** T-05 save and reopen PASS (31 / 1057 after reopening; TCD14-17 to -20).
7. **CD: robot PASS 5 of 5 + Codex PASS 5 of 5 on Civil 3.0.90.10, each with logs and screenshots.** For the controller to write.

**Controller's check, CD on Civil 3.0.90.10, Sun 15 Nov 2026 11:32:** robot log read (`C:\CE_WORK\scratch\trust_install\ten_cd_b8.out`: C-1 to C-5 PASS) and Codex report read (`CODEX_VERIFY_TCD14_T1_20261115_1119.md`: T-00 to T-05 PASS, the U echoed CD and the counts returned to the start). No screenshot viewed by the controller for CD. **CD's everyday job (Cancel, Esc, draw a pipe between two pits, one Undo, save and reopen) is proven by robot and Codex.** Not yet counted as the tool accepted: not run on a real-job copy; New Pipe's known points (59 controls, to be redrawn to Tim's picture later) are look, not behaviour.
2. **Codex look TCE14 E1 (11:32 to 11:45): OVERALL PASS.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCE14_E1_20261115_1133.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TCE14_E1_20261115_1133\screenshots\`.
   - E-01 Cancel PASS (Edit Pit showed 19.45; P10 stayed CL 19.45; R3 1054; TCE14-02, -03). E-02 Esc PASS ("Select a pit, pipe, source or CE text to edit: *Cancel*"; TCE14-04, -05).
   - **E-03 Save PASS** (cover 19.95, "Pit updated.", P10 reads CL 19.95; no label question; TCE14-06, -07).
   - **E-04 one U PASS** (echoed CDEDIT; P10 back to CL 19.45; Edit Pit showed 19.45; TCE14-08, -09).
   - **E-05 save and reopen PASS** (CL 19.95 after reopening; TCE14-10, -11).
3. **CDEDIT: robot PASS (Cancel pit, Esc, Cancel pipe) + Codex PASS (Cancel, Esc, Save, one U, save and reopen) on Civil 3.0.90.10.** For the controller to write. (Edit Pipe Save was not tried; Edit Pit's was.)

### 4. PITSCHEDULE

1. **Robot first run (11:46 to 11:57): NOT a test.** The driver's window close failed at once (window still loading), the modal Pit Schedule then blocked every later step, and I ended that AutoCAD (my own, scratch copy, settings the same). Log `C:\CE_WORK\scratch\trust_install\ten_ps.out`.
2. **Robot retry (11:58 to 12:02, copy `CLDTP_TEN_PS2.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_ps2.out`): open and Close PASS, twice** (window's own Close button after 12 s; CE's record and drawing identical before and after). Screenshot of the window: `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_114351\TEN_PS_window.png` ("Will be placed: 27 rows · All sets · All systems", "Drawing check: 95 data issues may affect this schedule", "27 rows listed").
3. **Seen:** on the standard test drawing "Continue to Place / update" is greyed out (both opens). So placing, one U and save/reopen could not be done by the robot; Codex look TPS14 (it can open the Placement tab and see what it needs).
4. **Codex look TPS14 S1 (12:03 to 12:11): open/Close PASS again; placing BLOCKED by the test drawing.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPS14_S1_20261115_1203.md`. Placement tab: the standard test drawing already holds an older schedule that has no linked source record, so "Continue to Place / update" and "Update existing schedule" are both greyed out (TPS14-10-placement.png). Placement tab words: "The entire schedule remains available on the Rows tab before you approve. After successful placement this window closes automatically and does not reopen." / "Close keeps saved row edits. Cancel during placement adds no schedule." Next: a blank scratch copy with two ordinary pits (no older schedule), robot.
5. **Robot on a blank copy with two pits (12:12 to 12:24): NOT a test** (my script swallowed its own window lines; the window stayed open). Learned from the screen (`C:\CE_WORK\scratch\trust_install\screen_ps3.png`): on a drawing with no older schedule "Continue to Place / update" IS available and moves to the Placement tab ("Place schedule", "Will be placed: 2 rows · All sets · All systems", "No linked pit schedule was found in this drawing."); the final button "Place schedule" is not on the robot's press list. I ended that AutoCAD (my own; settings the same).
6. **Codex look TPS15 on a blank fixture with P1 and P2 (`C:\Lisp Files\_TEST_COPIES_20260923\CLDTP_TPS15.dwg`, made by `ps_prep.ps1`): running from 12:3x** (open/Close, Esc while placing, place, one U, save and reopen).

**Controller's check, CDEDIT (Edit Pit) on Civil 3.0.90.10, Sun 15 Nov 2026 12:45:** Codex report read (`CODEX_VERIFY_TCE14_E1_20261115_1133.md`: E-01 to E-05 PASS 5, FAIL 0; Save changed P10 from CL 19.45 to 19.95, one U echoed CDEDIT and put 19.45 back, 19.95 held after save and reopen); screenshot `TCE14-08-undo-after.png` seen by the controller (P10 reads CL 19.45 after the one Undo; status bar shows CE CVL SUITE v3.0.90). Codex notes its own paperwork was not exact (driver call record partly rebuilt); the five things seen stand. **Edit Pit's everyday job (Cancel, Esc, Save, one Undo, save and reopen) is proven by Codex, with Cancel and Esc also by robot.** Not counted as the tool accepted: Save was not done by the robot (press list), Edit Pipe Save not tried at all, no before/after CE record reading around Save and U (Codex read the drawing text and the window, not the record), not run on a real-job copy. Next for this tool: Edit Pipe Save with one U, and a record reading either side.
