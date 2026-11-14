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
