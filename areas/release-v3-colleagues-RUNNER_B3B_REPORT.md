# Runner B3b: stronger checks for R12, R19b, R28 and fresh passes for R01, R03, R05, R08 on Civil 3.0.75 (Sun 25 Oct 2026)

Written Sun 25 Oct 2026 about 16:35 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER: R12 R19B R28 STRONGER CHECKS, AND 3.0.75 PASSES FOR R01 R03 R05 R08". Job ran 14:54 to 16:30 on a Sunday (free window). Real AutoCAD 2027 on test copies only, one session at a time under the shared lock as `Claude-driverv3`, foreground only. Built and run by me; **not independently reviewed**. Nothing in `DESK_LOG.md`, `BUG_CARPARK.md`, any `review.txt` or `ledger.json` was edited by hand (the runner wrote the ledger rows).

## ANSWER FIRST

1. **Build:** read live from the DLLs at 14:54, at about 15:18 and at 16:28 and in every run header: **Civil 3.0.75+2c805a39 / Manager 1.1.75+2c805a39 / Structural 1.0.123+4af3f37d**. The live bundle folder was created 03:33 today and was not touched, so no run straddles an install.
2. **R12 (quick MOVE): PASS, PASS.** Runs `b3bd1` (RUN-20261025-1508) and `b3bd2` (RUN-20261025-1516). New evidence: the pit name label (handle 109E08) and the cover level text "CL 18.88" (109E0F) both moved exactly 2000 mm with the pit and both came back exactly after one U (0 mm, 0 mm). Case hash **85BAD74AEDEB**. Red: `R12_NOU_BROKEN` FAILED in `b3bd1` on all four position checks: `$ret_a` 1990.3, `$ret_b` 1988, `$ret_lab` 2000, `$ret_cl` 2000 (each asked 0 +- 0.5). Variant hash D70D7B7AA3E1 (I extended it so the new label and cover checks go red too).
3. **R19b (erase pit P3 with six pipes): PASS, PASS.** `b3bd1`, `b3bd2`. All six pipes are now read, not one, and each still reads as a STORMWATER PIPE after the ERASE: 10A98D, 109E23, 109ED4, 110179, 110136, 10A901. The object count straight after the ERASE is 1031 (1034 before: the pit, its name label and its cover text), and 1034 again after U. Case hash **3536E3A4615D**. Reds, all FAILED in `b3bd1`: `R19b_BROKEN` (expects 7; unchanged file 4729BB887F19), new `R19b_COUNT_BROKEN` (an extra text erased: `$e1` = 1030, expected 1031; hash 519375085E7C; a true check red), new `R19b_PIPE_BROKEN` (pipe 109E23 erased as well: the read of that pipe stops with an AutoCAD error, so this red comes from a tool error, not a check line; hash 0B5739E993B4).
4. **R28 (CDPROFILE start): PASS, PASS.** `b3bd1`, `b3bd2`. The Profiles window dump now shows the start pit: the text "Choose a start pit and route. Preview before placing or updating the profile." is followed by the text "P3". Case hash **7F29403F16E7**. Red: `R28_BROKEN` FAILED in `b3bd1`: "Select a CE pit block." found, no Profiles window, no dump (three checks failed, including the new P3 one). Variant hash E8665FBDA33C.
5. **R01 (PIT and CD keep placing until Esc): PASS, PASS.** `b3bh1` (RUN-20261025-1520) and `b3bh3` (RUN-20261025-1556). Case hash **99BC70E23675** = the hash in its review file. The runner printed **ACCEPTED-READY** in `b3bh3`, on Civil 3.0.75.
6. **R03 (one IL text at each pipe end): PASS, PASS.** `b3bh1`, `b3bh3`. Hash **4384D2D7B6B9** = review file. **ACCEPTED-READY** printed in `b3bh3`, on 3.0.75.
7. **R05 (one outcome line per command, and "cancelled"): PASS, PASS.** `b3bh2` (RUN-20261025-1538) and `b3bh4` (RUN-20261025-1611). Hash **4E5A615417F8** = review file. **ACCEPTED-READY** printed in `b3bh4`, on 3.0.75.
8. **R08 (REDO after U and a real-mouse pit pick): FAIL, FAIL. A REAL-LOOKING FAULT ON 3.0.75, NOT A CASE FAULT.** Hash **4A42C588E549** = review file (unchanged). It ran in two separate runs and the runner re-ran each in a second fresh AutoCAD, so four fresh AutoCAD sessions: `b3bh2-s1`, `b3bh2-s2`, `b3bh4-s1`, `b3bh4-s2`. All four failed the same way and in the same place. R08 passed on 3.0.74 (hdnA4, hdnB4b), so its two passes there do not carry over: **R08 is not ACCEPTED-READY on 3.0.75**. Detail in "R08" below. I stopped at that point, as the rule says after three consecutive failures.
9. **What is ready for the independent reviewer:**
   1. **New text, needs a fresh review file:** R12, R19b, R28. Each now has two passes in separate sessions on 3.0.75, no FAIL, and its reds. R19b's `R19b_PIPE_BROKEN` red is a tool-error red; the reviewer may prefer `R19b_COUNT_BROKEN` and `R19b_BROKEN` as the checks' reds.
   2. **Nothing to redo:** R01, R03, R05. Unchanged files, review files still match, two passes on 3.0.75 and the runner printed ACCEPTED-READY.
   3. **R08 needs a decision, not a review:** see below.
10. **Not done, said plainly:** I wrote no review.txt and did not touch the ledger by hand. No Codex run. The pit's name label and cover text were not looked at on screen: only their positions were read.

## R08: what happened and what it means

1. **Where it fails:** round 1 only. The control round with no pick passes ("Everything has been redone"). Round 1 (draw a line, U, real-mouse click on pit P3, wait 12 s, REDO) prints `Nothing to redo`. Rounds 2 to 5 pass, and the final proof read finds the click selected pit 109D56 (`pick-first set: 1 object(s) 109D56`) in every session. So the click did hit the pit, and the loss is on the first click after a fresh start. This is the "first run after opening, pick, REDO" route that Codex reported failing for BUG-861 and that R08's own review said was never explained.
2. **On the same drawing, same case text, same click point, same build (3.0.75)** the case passed twice on 3.0.74. Nothing in the case, runner or driver changed (case hash equal to the review; driver v2, v3 and v3 session and the runner main file unchanged by me). So it is either a change in CE 3.0.75 or a first-click timing change. I did not find out which.
3. **Evidence:** reports `RUN-20261025-1538-C3.0.75-b3bh2` and `RUN-20261025-1611-C3.0.75-b3bh4`, checks 5 and 6: `Command: | Command: REDO | Nothing to redo`. CE log: 155 and 153 new lines, 0 with [ERR]. Not read line by line.
4. **Bug number:** BUG-861 (OPEN) is the one it matches. I did not add or change anything in the bug file (instruction). Suggested for the desk: attach "R08 round 1 fails 4 of 4 fresh sessions on Civil 3.0.75, passes on 3.0.74" to BUG-861.
5. **Exact steps if someone wants to see it by hand:** open the fixture drawing (DRV1_B1 copy), CE Inspector palette showing, ZOOM to pit P3 (centre 53777.7,-25569.9, height 1200), LINE from 53500,-26000 to 53900,-26000, type U, with the real mouse click pit P3 once, wait 12 seconds, type REDO. Expected: "Everything has been redone". Seen: "Nothing to redo". This is the first line drawn after a fresh start (after a control line, U and REDO that works).
6. **Next step I recommend:** a Codex pass of the BUG-861 route on 3.0.75, and a look at what CE's 3.0.75 change touched in the Inspector refresh. Not mine to do.

## Evidence per run (all Civil 3.0.75, Manager 1.1.75, Structural 1.0.123)

1. **`b3bprobe1` RUN-20261025-1455** (probe, no ledger): the objects near pit P3 and the pit erase count. Found the pit name label 109E08 ("PIT LABEL" block, 52570.9,-26238.3), the cover text 109E0F ("CL 18.88", 54354.4,-24866.6), and the object count after the ERASE (1031).
2. **`b3bprobe2` RUN-20261025-1457** (probe, no ledger): every pipe object's bounding box. The six pipes at P3 were worked out by their boxes touching the pit's 900 mm outline: 10A98D (from the west, ends 450 mm west of the pit centre), 109E23 (to the east), 110136 and 110179 (north side), 109ED4 and 10A901 (south side). Six matches the CE message "6 pipes now have ends that are Not connected yet" and the driver run 20 reading.
3. **`b3btrial1` RUN-20261025-1500** (trial of the edited cases, no ledger): R12, R19b, R28 passed and four variants went red.
4. **`b3bd1` RUN-20261025-1508** (15:08 to 15:16, one session): R12 PASS, R12_NOU_BROKEN FAIL (known red), R19b PASS, R19b_BROKEN FAIL, R19b_PIPE_BROKEN FAIL, R19b_COUNT_BROKEN FAIL (all known reds), R28 PASS, R28_BROKEN FAIL (known red).
5. **`b3bd2` RUN-20261025-1516** (15:16 to 15:20): R12, R19b, R28 all PASS.
6. **`b3bh1` RUN-20261025-1520** (15:20 to 15:38; the long wait was the lock, not the case): R03 PASS, R01 PASS.
7. **`b3bh2` RUN-20261025-1538** (15:38 to 15:55): R05 PASS (21 s); R08 FAIL in s1 and in the rerun s2.
8. **`b3bh3` RUN-20261025-1556** (15:56 to 16:10): R03 PASS, R01 PASS, both ACCEPTED-READY.
9. **`b3bh4` RUN-20261025-1611** (16:11 to 16:28): R05 PASS (20 s), ACCEPTED-READY; R08 FAIL in s1 and in the rerun s2.
10. **Every session:** clean end (AutoCAD left 0, lock none, guard clear), 0 settings fingerprint differences, fixture DRV1_B1 34BBE37C2EA4 unchanged. Tim's four settings files read back at the end: CD_Settings.json ACD64E79A33B (read back by hand), the other three equal in every run's fingerprint line (622A246F7D3B, EFE307C4FC74, 2972CE70C514). No acad.exe left, lock free at 16:28.

## What I changed, listed loudly

1. **Case files** (`C:\Lisp Files\_ACAD_DRIVER\cases\`, not a git repository):
   1. `R12_quick_move_opens_no_window.case.txt`: new hash 85BAD74AEDEB (was 84658F195D14). Added: reads of the name label and cover text before the MOVE (placed where the probe found them, 0 +- 0.5 mm), after the MOVE (2000 +- 150) and after U (0 +- 0.5), plus record-only reads of IL texts 1155B6, 116A3C and 116BE4. Their moves read 1899.4, 1925.7 and 1999.1 mm in both sessions: they follow the pit, but two of the three are not exactly 2000 (not judged; the plan's placement rules are not recorded).
   2. `R19b_erase_pit_with_several_pipes.case.txt`: new hash 3536E3A4615D (was E1FE2D54B3FA). Added: the six pipe reads, the 1031 count straight after the ERASE, and the 1034 return was already there.
   3. `R28_cdprofile_start.case.txt`: new hash 7F29403F16E7 (was 3A778E5F30F1). Added: the Profiles window dump and the "P3 follows the instruction line" check.
2. **Variants** (`cases\variants\`): `R12_nou_broken` edited (D70D7B7AA3E1, was baef9edad42b); `R28_broken` edited (E8665FBDA33C, was 928917e7af5a); `R19b_broken` unchanged (4729BB887F19); **new** `R19b_count_broken` (519375085E7C) and `R19b_pipe_broken` (0B5739E993B4).
3. **Not changed:** R01, R03, R05, R08 case files (hashes 99BC70E2, 4384D2D7, 4E5A6154, 4A42C588 = their review files). No review.txt written; ledger not hand edited. `case_runner.ps1` 7E3BC77F93F4, driver v2 120EE24D15B2, v3 7CADBF80D5AA, v3 session 9A7B8D210C7F unchanged. **`case_runner_lib.ps1` now reads A229DC0BAFA1 (the batch 2 job saw 5AB2CBC1A5A0): it was last written today at 12:29, before this job started, by another job. I did not edit it.**
4. **Scratch (this PC only):** `C:\ce_rc_scratch\b3b\` (probe cases, run outputs, originals of R12, R19b and R28 as `*_orig_b3b.txt`). Not a build or deploy script. Probe and trial reports sit in `runner-reports` with no ledger rows.

## What I did NOT check (RULES 5.9)

1. **Nothing was looked at.** No window or picture judged. R28's window is asserted by its title and by the P3 text in its dump; what else it lists is not read.
2. **R12's other invert texts:** 116A0E (the sixth text near the pit) was not read: its place was not in the probe's 1500 mm list and I did not add another probe. Only 1155B6, 116A3C and 116BE4 are recorded.
3. **R19b does not read the Pit Schedule** and does not read that the links come back after U, only that all six pipes remain and the pit returns.
4. **R19b's six handles were found from pipe bounding boxes** (a pipe object returns no end points to the runner), checked against the CE message count of six. I did not read each pipe's end node.
5. **R08's cause is not found.** I did not read the CE log line by line, did not run it on 3.0.74 again, and did not try a longer wait before the first click.
6. **R01, R03, R05:** their second-pipe label, leader and Structural/Manager outcome lines are outside their cases as before.
7. **The case-blind text checks and the "red only for BUG cases" runner gaps** from earlier reviews are the runner owner's, unchanged.

## Summary (under 100 words)

R12, R19b and R28 now carry the stronger checks the review asked (pit label and cover text; all six pipes plus the 1031 count; the Profiles window's start pit P3). Each passed twice in separate sessions on Civil 3.0.75 and their variants went red; they need fresh reviews. R01, R03, R05 passed twice unchanged and the runner printed ACCEPTED-READY. R08 failed in four fresh sessions on 3.0.75, always in round 1 (REDO says "Nothing to redo" after the first pit click), though it passed on 3.0.74: matches BUG-861, so R08 is not accepted.
