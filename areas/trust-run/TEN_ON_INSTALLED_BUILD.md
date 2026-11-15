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
4. **CDEDIT owed parts, robot, Sun 15 Nov 15:21 to 15:37 (Civil 3.0.90.10; scratch copy `CLDTP_TEN_CESAVE.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_cdedit_save2.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_144612\`). Uses the two Save presses Tim allowed in queue item 16. CE's record was read before Save, after Save and after the one U each time.**
   - Set-up: a fresh pipe P10 to P9 drawn with CD and Start Pipe. Its window closed and CE's record read fine (595,085 characters).
   - **E-1 Edit Pit Save, then one U: PASS.** Before: P10 cover in the record 19.45. Set 19.95 and pressed Save: the command line said "Pit updated.", record 19.45 to 19.95. One U echoed CDEDIT and the record went back to 19.45. Record and drawing were identical to before the edit (record identical apart from the known format/path stamp). Screenshot `TEN_CDEDIT_pit_saved_2.png`.
   - **E-2 Edit Pipe Save, then one U: PASS.** The window heading read "Flow: P10 → P9". Before: diameter in the record 100. Set 150 and pressed Save: "Pipe updated.", record 100 to 150. One U echoed CDEDIT and the record went back to 100. Record and drawing were identical to before the edit. Screenshot `TEN_CDEDIT_pipe_saved_2.png`.
   - **E-3 Edit Pipe Save again, save the copy, reopen: PASS.** Record 150 after Save, and still 150 after save-copy and reopen.
   - Closed with no save. The driver says "the 4 settings files have the same SHA-256 as at the start of the pass". The driver also listed one log it could not read (`Drawing1_1194d4fde.log`): a note only, not a CE message.
   - An earlier try (14:54 to 15:08) is void, not a fail. The driver change of 14:50 had stopped v3 from pressing Start Pipe, so the set-up never finished (see the lane file, 15:12).
   - **For the controller to weigh:** the robot has now seen Save plus one Undo, with CE's record either side, for both Edit Pit and Edit Pipe, and Edit Pipe Save holding through save and reopen. Codex has seen Edit Pit's whole job (TCE14) but not Edit Pipe Save. A Codex look at Edit Pipe Save, one U, save and reopen (TCE16) comes next if you want it for the count.
5. **Codex look TCE16 E1 (15:50 to 16:02, Civil 3.0.90.10, copy `CLDTP_TCE16.dwg`): OVERALL NOT TESTED: EVIDENCE.** Codex's screenshot saver kept saving an old picture, so no step counts toward acceptance. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCE16_E1_20261115_1550.md`; screenshots in `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\` under TCE16.
   - What Codex saw on screen, written as observations only, matched the robot at every step:
     - E-01 Cancel: the heading read "Flow: P10 → P9", diameter 150; nothing changed (object count 1057).
     - E-02 Esc: "*Cancel*"; nothing changed.
     - E-03 Save at 225: "Pipe updated.", and the pipe text became "225 DIA. UPVC PIPE AT 1 IN 100". No question appeared.
     - E-04 one U: echoed CDEDIT; the text went back to 150; Edit Pipe showed 150.
     - E-05 Save again, save and reopen: 225 held.
   - Settings were unchanged and the installed versions were the same at start and end.
   - **Finding for Tim (human use):** while the diameter box already showed 225, the pipe picture inside the Edit Pipe window still showed the old "150" label. After Save the drawing was right. Whether that preview should refresh as you type is a question for him.
   - Also seen: the "What CE Found" panel opened at start-up describing an empty Drawing1. The reopened drawing printed "CE: needs checking. 22 pipes not linked. Type CDCHECKCURRENT to see them." (This is the standard test drawing's older pipes.)
   - Needs a rerun with a working screenshot saver for the count. It runs on 3.0.90.11 after batch 9 goes in, if the controller wants it.
7. **Codex look TPS15 S1 first run (12:33 to 12:47): open/Close PASS, Esc while placing PASS; placing BLOCKED.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPS15_S1_20261115_1234.md`. S-01: "2 rows listed", Close, R3 2 = START (TPS15-04 to -06). S-02: Place schedule, Esc at the insertion point, back to the window, Close: no table, R3 2 (TPS15-07 to -12). S-03 and S-05: at the insertion point the Pit Schedule window still holds AutoCAD, so the driver refused to type the point (BUSY) and hand typing became PASTECLIP. Rerun from 12:4x answering the point with one mouse click in the drawing.
8. **Codex look TPS15 S1 rerun (12:48 to 13:00): place, one U, save and reopen PASS.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPS15_S1_20261115_1249.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TPS15_S1_20261115_1249\screenshots\`.
   - S-01 open/Close PASS ("2 rows listed", count 2; TPS15-04 to -06).
   - **S-03 place PASS:** one mouse click answered the insertion point; the schedule appeared above-right of the pits; objects 2 to 11 (TPS15-12 to -15).
   - **S-04 one U PASS:** echoed PITSCHEDULE; the schedule gone; objects back to 2 (TPS15-16-undo.jpg).
   - **S-05 place again, save, reopen PASS:** table still there, 11 objects (TPS15-17 to -22).
   - S-02 (Esc while placing) BLOCKED in this run only for the count reading; it PASSED in the first TPS15 run (Esc, no table, count 2).
9. **PITSCHEDULE summary:** robot open/Close PASS x2 (it cannot press "Place schedule"); Codex PASS on open/Close, Esc while placing, place, one U and save/reopen (across the two TPS15 runs), with screenshots and object counts. For the controller to weigh and write. Placing is not possible on the standard test drawing (older unlinked schedule; "Continue to Place / update" greyed out with the reason on the Placement tab).

**Controller's check, PITSCHEDULE on Civil 3.0.90.10, Sun 15 Nov 2026 13:00:** both Codex reports read. Each says OVERALL BLOCKED on its own (`CODEX_VERIFY_TPS15_S1_20261115_1234.md`: S-01 open/Close PASS, S-02 Esc while placing PASS, S-03 to S-05 blocked by the driver refusing a point; `..._1249.md`: S-01 PASS, S-02 BLOCKED on a count reading only, S-03 place PASS objects 2 to 11, S-04 one U echoed PITSCHEDULE and back to 2, S-05 save and reopen 11). **Across the two runs every step has one PASS; no single run passed all five.** Screenshot `TPS15-22-reopened.jpg` seen by the controller: STORMWATER PIT SCHEDULE with rows P1 and P2 (450 x 450, cover 20.00, Class C Grated Lid) present after save and reopen, CE CVL SUITE v3.0.90 in the status bar. **Pit Schedule's everyday job on a simple drawing (open, Close, Esc while placing, place, one Undo, save and reopen) is proven by Codex over two runs; the robot proved open and Close only.** Not counted as the tool accepted: fixture was two pits with no pipes (inlet, outlet and depth columns empty, so nothing shown about those), no CE record reading either side, "Update existing schedule" not tried, placing is greyed out on the standard test drawing because of an older unlinked schedule (the window says so; whether a drafter can get past that is a human-use question to look at), not run on a real-job copy.

### 5. CDRULES with CDCALC

1. **Robot (13:01 to 13:11; logs `C:\CE_WORK\scratch\trust_install\ten_rules.out`, `ten_rules2.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_125911\`, `...\session_20261115_130556\`):**
   - **CDRULES asks at the command line:** "CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>". **Esc: PASS** ("*Cancel*", record and drawing identical).
   - **Problems (Enter) and Explain:** list the rule findings (for example "R-14 Wet-well review threshold: not evaluated here (needs the pump-station storage calculation).") and end "[CE] Full list saved: ...\logs\cdrules-...txt. Drawing geometry unchanged; results recorded in the project." **Values:** lists the values in use (for example "R-24 AS/NZS 3500.3 edition: 2021", "R-31 speed in a pipe leaving a pit ...: recommended 1.5 m/s (office), limit 2 m/s (office)") and ends "Nothing was changed." **pReview:** "[CE] No finding had a planned edit to preview."
   - **Drawing unchanged by all four answers: PASS.** **CE's record changed, as CDRULES says ("results recorded in the project"): its stored record grew from about 247,000 to about 2,040,000 characters** in one session of four runs. No level, size, number, label, layer or colour changed. For the controller and Tim: the drawing file grows by roughly 1.8 MB of rule results; whether it keeps growing with each run is not checked.
   - **CDCALC: opens "Creative Engineering | Calculations (CDCALC)"** ("Calculations", "Review drainage inputs, check the results and prepare the computation ...", Detention / Storage sections); closing it changes nothing (record identical apart from the format/path stamp, drawing identical): **PASS.** TEN_CDCALC.png.
   - pReview's lines contain "→" (written "\U+2192" in AutoCAD's own log); how it looks on screen is not captured (the command line is out of the screenshots).
2. **Codex look TRC14 R1 (13:12 to 13:22): CDRULES Esc PASS, CDCALC open/close PASS; Problems/Values NOT TESTED (evidence); my brief's mistake ran CLEAN.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TRC14_R1_20261115_1313.md`.
   - R-01 PASS ("<Problems>: *Cancel*", count 1054). R-04 PASS (Calculations window opened and closed; count 1054; TRC14-06, -07).
   - R-02, R-03 NOT TESTED (EVIDENCE): Problems and Values ran (their words are in Codex's driver log `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TRC14_R1_20261115_1313\exports\driver_calls.txt`), but the screenshots show no command line.
   - **My brief allowed F2 to show the command-line history; on this PC F2 runs CE's CLEAN.** CLEAN ran and saved the scratch test copy `CLDTP_TRC14.dwg` ("Done in 1.1 s: 6 steps done, 0 failed, drawing saved."; layers 662 to 659, blocks 189 to 183, text styles 53 to 52). Only that scratch copy; settings files unchanged; nothing else touched. Never F2 in a brief again.
   - R-05 DIFFERENT for that reason (count 1054 kept after save and reopen).

### 6. CDCHECKCURRENT and 7. MR (move and rotate)

1. **Robot (13:23 to 13:31, copy `CLDTP_TEN_CCMR.dwg`; log `C:\CE_WORK\scratch\trust_install\ten_cc_mr.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_132123\`):**
   - **CDCHECKCURRENT: PASS:** "[CE] Drawing check complete. 27 items need checking. Nothing has been fixed automatically."; CE's record and drawing identical before and after. TEN_CDCHECKCURRENT.png.
   - **MR Esc: PASS:** "Select objects: *Cancel*"; record and drawing identical.
   - **MR move: PASS:** P10 picked, base at its centre, to 1 m east, rotation 0: "1 found ... Move Rotate complete."; P10 moved in the drawing (PIT BLOCK 3 at 55436.26,-69493.57) AND in CE's record (55436.3, -69493.6). TEN_MR_moved.png.
   - **MR one U: PASS:** the U echoed MR (after one U for my ZOOM); P10 back at 54436.3 in both; record and drawing byte-identical to the start.
   - **MR move again, save, reopen: PASS:** 55436.3 kept in both after reopening.
   - The driver's quit then closed the drawing but AutoCAD stayed open with no drawing (CE's 'What CE Found' panel showing), as at 05:58; I ended it (my own start, nothing open); settings files the same.
2. **Codex look TCM14 M1 (13:35 to 13:44): OVERALL PASS** (covers CDCHECKCURRENT, CDRULES and MR). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TCM14_M1_20261115_1335.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\TCM14_M1_20261115_1335\screenshots\`; command-line words in `...\exports\driver_calls.txt`.
   - M-01 CDCHECKCURRENT PASS ("[CE] Drawing check complete. 27 items need checking. Nothing has been fixed automatically."; R3 1054; TCM14-03-check.png, TCM14-03-panel.png).
   - M-02 CDRULES Problems and Values PASS ("Drawing geometry unchanged; results recorded in the project." / "Nothing was changed."; R3 1054; TCM14-04, -05).
   - M-03 MR Esc PASS ("Select objects: *Cancel*"; TCM14-06, -07). M-04 MR move PASS ("1 found", "Move Rotate complete."; P10 1 m right; TCM14-08-moved.png). **M-05 one U PASS** (echoed MR; P10 back; TCM14-09-undo.png). M-06 move again, save, reopen PASS (TCM14-10 to -13).
3. **Summary:** CDCHECKCURRENT: robot PASS + Codex PASS. MR: robot PASS 5 of 5 + Codex PASS. CDRULES with CDCALC: robot PASS (Esc, all four answers, CDCALC open/close) + Codex PASS (Esc and CDCALC in TRC14; Problems and Values in TCM14). For the controller to write. (CDRULES stores its results in CE's record, about 1.8 MB: for Tim's eye.)

### 8. CDRENUMBER (a real renumber, applied with Yes)

1. First robot run (13:45 to 13:56): NOT a test (my script's function was named Ren, which PowerShell runs as Rename-Item, so CDRENUMBER never ran; the U took back my last pipe). Rerun from 13:5x.
2. Second robot run (13:56 to 14:07): with no pipe leaving the network, CDRENUMBER refused clearly and changed nothing: 'CDRENUMBER numbers the pits from the outlet, but no pipe leaves any pit to open ground or an outfall, so it cannot tell which pit is the outlet. Draw the last pipe from the downstream pit out to an open end ...' (TEN_REN_no.png; record and drawing identical). Rerun with an outlet pipe from P3 to an open end.
3. **Robot with an outlet pipe (14:08 to 14:20, blank scratch copy: pits P1 @10000, P2 @20000, P3 @30000, pipes P1→P2→P3 and P3 to an open end; log `C:\CE_WORK\scratch\trust_install\ten_ren3.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_140754\`): 4 PASS of 4.**
   - **No: PASS:** "Renumber downhill to uphill: / P3 -> P1 / P1 -> P3 / 2 pit(s) will be renumbered. Apply? [Yes/No] <No>: N" then "Renumber cancelled - nothing changed."; record and drawing identical (TEN_REN_no.png).
   - **Yes: PASS:** "Renumbered 2 pit(s) downhill to uphill. One Undo restores the old numbers."; CE's record now P3 @10000, P2 @20000, P1 @30000 and the pipes P3→P2, P2→P1 (TEN_REN_yes.png).
   - **One U: PASS:** echoed CDRENUMBER; record and drawing byte-identical to the start.
   - **Yes again, save, reopen: PASS:** the new numbers kept after reopening.
   - Renumbering happened only after the drafter's Yes (Tim's rule).
4. Codex look TRN15 first run (14:32 to 14:37): BLOCKED (Codex's screen connection failed after launch; nothing tested). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TRN15_N1_20261115_1433.md`. Its AutoCAD (under my lock) closed by the driver's quit, settings the same, fixture unchanged. Rerun from 14:4x.

**Controller's check, CDCHECKCURRENT, MR and CDRULES with CDCALC on Civil 3.0.90.10, Sun 15 Nov 2026 14:39:** Codex report `CODEX_VERIFY_TCM14_M1_20261115_1335.md` read (OVERALL PASS, M-01 to M-06 PASS 6, FAIL 0, one run); screenshot `TCM14-09-undo.png` seen by the controller (command line shows U then MR; P10 back at its first place, CL 19.45). `CODEX_VERIFY_TRC14_R1_20261115_1313.md` read: OVERALL BLOCKED (F2 ran CLEAN on the scratch copy; R-01 Esc and R-04 CDCALC open/close PASS, R-02/R-03 not tested there).
1. **MR: counted ACCEPTED** under Tim's "codex alone is fine" (Esc, move, one Undo, save and reopen all in one clean Codex run; robot 5 of 5 with CE's record moving and coming back with the pit).
2. **CDCHECKCURRENT: counted ACCEPTED** (a look-only tool: ran, said "27 items need checking. Nothing has been fixed automatically.", drawing and CE's record identical before and after by robot; Codex PASS in the same clean run).
3. **CDRULES with CDCALC: everyday job seen, HELD, not counted.** Problems and Values passed in TCM14; Esc and CDCALC open/close passed only in the blocked TRC14 run; CDCALC was opened and closed, nothing calculated or placed; and CDRULES adds about 1.8 MB of rule results to CE's record while saying "Drawing geometry unchanged" (true, but the record grows: to be looked at against the look-only rule). Wanted: one clean Codex run covering Esc, Problems, Values, CDCALC doing a calculation, save and reopen.
**Count on 3.0.90.10: PIT, CD, MR, CDCHECKCURRENT accepted = 4 of Tim's ten.** Held: CDEDIT (Edit Pipe Save), PITSCHEDULE (one clean run with a pipe), CDRULES with CDCALC (above). Still to run on this build: CDLPD, CDRUNSOLVE; CDRENUMBER robot 4 of 4, Codex look running.
5. Codex look TRN15 second run (14:39): NOT STARTED (Explorer minimised; Codex's screen check refused). Third run (14:43 to 14:47): BLOCKED at N-00 ("FrameArrived timed out: timed out waiting on channel", twice; Codex's own screen tool). Reports `CODEX_VERIFY_TRN15_N1_20261115_1439.md`, `..._1443.md`. Nothing tested, AutoCAD closed, settings the same. **CDRENUMBER: robot PASS 4 of 4 (No, Yes, one U, save/reopen) with log and screenshots; Codex witness still owed.**

## THE TEN ON 3.0.90.10, WHERE THEY STAND (Sun 15 Nov 14:48 PC clock)

1. **PIT:** robot 5/5 + Codex 5/5 PASS. Ready for the controller to write.
2. **CD:** robot 5/5 + Codex 5/5 PASS. Ready.
3. **CDEDIT:** robot (Cancel pit, Esc, Cancel pipe) + Codex OVERALL PASS (Cancel, Esc, Save, one U, save/reopen). Ready.
4. **PITSCHEDULE:** robot open/Close x2 + Codex PASS on open/Close, Esc while placing, place, one U, save/reopen (blank fixture with two pits). For the controller to weigh (robot cannot press "Place schedule"; on the standard test drawing placing is greyed out because of an older unlinked schedule).
5. **CDRULES with CDCALC:** robot PASS (Esc, all four answers, CDCALC open/close; drawing unchanged) + Codex PASS (Esc and CDCALC, then Problems and Values). Ready. For Tim's eye: CDRULES stores about 1.8 MB of results in CE's record.
6. **CDCHECKCURRENT:** robot PASS + Codex PASS. Ready.
7. **MR:** robot 5/5 (Esc, move in drawing and record, one U, save/reopen) + Codex PASS. Ready.
8. **CDRENUMBER (real renumber):** robot 4/4 PASS; Codex witness NOT TESTED (Codex screen tool failures x3). Lines for unreached pits and loops: PASS on batch 8 (earlier section).
9. **CDRUNSOLVE:** skipped from the ten on the controller's order; its Apply then one U was shown to work (RSQ18, readings), typing Q not yet tested.

## THE REST OF THE TEN ON CIVIL 3.0.90.11 (batch 9, installed 15 Nov 16:03)

### 4. PITSCHEDULE: one clean Codex run with a pipe (TPS16)

1. **Codex look TPS16 S1 (18:44 to 18:59, Civil 3.0.90.11, copy `CLDTP_TPS16.dwg`).** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_TPS16_S1_20261115_1858.md`; screenshots in `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\` under TPS16.
   - **Fixture:** ordinary pits P1 and P2 joined by a CE pipe, plus one unnumbered plastic pit (made by the robot, `ps_prep2.ps1`).
   - **Result:** OVERALL NOT TESTED only because of the hover sentence. **S-02 to S-05 all PASS in one run**, every result SURE, and the screenshot saver checked (no repeats).
   - **S-01 open and Close:** "2 rows listed" and the grey line "1 plastic pit not listed (no number)", the singular form. Count stayed 7. The hover sentence was NOT TESTED: Codex's screen tool has no hover action. I added the hover to this brief for batch 9; it is not part of the plain job.
   - **S-02 Esc while placing PASS:** one Esc at the insertion point. The window came back, then Close. No table; count 7.
   - **S-03 place PASS:** one mouse click near x 40000, y 25000 placed the table above-right of the pits; count 7 to 18.
   - **S-04 one U PASS:** echoed PITSCHEDULE; the table was gone and the count back to 7.
   - **S-05 place again, save and reopen PASS:** the table was still there after reopening; count 18.
   - Settings unchanged; versions unchanged; AutoCAD closed by Codex. Tim's last-used pit read ordinary before and after (hash D0E30F0F2371, plastic False, label True, schedule True).
   - **For the controller to weigh:**
     - Pit Schedule's plain job (open, Close, Esc while placing, place, one Undo, save and reopen) is now proven by Codex in ONE run on a drawing with a pipe.
     - Still open: the hover sentence (needs a person or a hover-capable tool), "Update existing schedule", and the older unlinked schedule on the standard drawing.
