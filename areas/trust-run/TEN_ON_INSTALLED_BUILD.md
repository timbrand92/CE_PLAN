# Ten core tools on the installed build (Civil 3.0.90.3)

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
