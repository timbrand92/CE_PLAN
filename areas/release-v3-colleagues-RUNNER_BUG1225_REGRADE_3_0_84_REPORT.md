# Robot job: prove the BUG-1225 fix, then re-grade every accepted case on Civil 3.0.84 (Wed 28 Oct 2026, from 14:45 Melbourne PC clock)

Job "TEST ROBOT: PROVE THE BUG-1225 FIX, THEN RE-GRADE EVERY ACCEPTED CASE ON CIVIL 3.0.84" (desk plan/03, Team, Sonnet). Real AutoCAD on test copies only, Tim away, `CE_RUNNER_TIM_AWAY=1`, one session at a time, 3 minutes with AutoCAD closed between sessions. Build read live from the installed DLLs at the start and in every run header: **Civil 3.0.84+94f521cc, Manager 1.1.84+94f521cc, Structural 1.0.125+204dfad2** (same in every run so far). No review.txt written, no runner, driver, ledger-by-hand, DESK_LOG, BUG_CARPARK or CD_RecentValues edit.

**INTERIM VERSION: Part 1 (the proof) is complete. Part 2 (the regrade) is in progress; its section below is filled as it finishes.**

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first:** one wasted pair of sessions. My first control run put the "switch OFF" setting on only one of its two cases, so the runner split them into two separate AutoCAD starts and there was no reopen between them: it proved nothing. I fixed the control and re-ran it twice (below). Cost: about 8 minutes of robot time. Nothing touched your drawings or settings.
2. **The BUG-1225 fix WORKS in the robot's AutoCAD: 6 of 6 sessions pass on Civil 3.0.84.** Three sessions of "place a downpipe, close the drawing without saving, open a fresh copy, place a downpipe again" (DP) and three of the same with an overflow and front overflow (OF): every second placement worked. On 3.0.83 the same pairs were refused 8 of 8 times.
3. **The control proves it is the fix:** with the new switch turned OFF (set through the settings guard, restored by file hash afterwards), the refusal came back in 2 of 2 sessions: "The source landing could not be refreshed. Nothing will be placed here." So the case does catch the bug, and the switch does turn the fix on and off.
4. **Right looks like this:** "Downpipe placed. Tag: DP1." and "Overflow placed. Tag: OF1." both times, and the CE log shows one new line in the reopened drawing: "[BUG-1225] ... was opened again after its drawing closed; CE loads this drawing's own record."
5. **Still not proven:** a drafter's own File > Close then File > Open by hand (the robot reopens a fresh copy of the file through its own driver); a plain pit or CD pipe as the first placement was not tried. Tim or Codex should do the 4 hand steps once before BUG-1225 is called fixed. It is NOT marked fixed.
6. **The regrade (Part 2) is still running** when this interim version was written. Its numbers follow in the final version of this file.

---

### Detail (the desk's part): Part 1

1. **Cases:** `N13a` then `N13` (DP), `N14a` then `N14` (OF), each pair in ONE AutoCAD start (`run-pack cases -Only "<first>,<second>" -NoRerun`), 3 fresh sessions each. All 12 cases PASS, 0 failing checks (including "history absent could not be refreshed", "history absent Nothing will be placed here", count of new downpipes = 1, and "log civil absent could not be refreshed" for N13).
2. **Session by session (run id, then the reopen log line in the CE log):**
   1. N13a/N13 session 1, RUN-20261028-1447-C3.0.84-p1n13a: PASS; log 14:49:03 `[BUG-1225] C:\ce_rc_drv\CLDV31447401_B1.dwg was opened again after its drawing closed; CE loads this drawing's own record.` DP1 placed both times (DP completed 32406 ms, then 29090 ms).
   2. N14a/N14 session 1, RUN-20261028-1453-C3.0.84-p1n14a: PASS; log 14:54:54 (CLDV31453091_B1.dwg). OF1 and FO1 placed, then OF1 again.
   3. N13a/N13 session 2, RUN-20261028-1458-C3.0.84-p1n13b: PASS; log 15:00:05 (CLDV31458561_B1.dwg).
   4. N14a/N14 session 2, RUN-20261028-1503-C3.0.84-p1n14b: PASS; log 15:05:43 (CLDV31504011_B1.dwg).
   5. N13a/N13 session 3, RUN-20261028-1509-C3.0.84-p1n13c: PASS; log 15:10:55 (CLDV31509391_B1.dwg).
   6. N14a/N14 session 3, RUN-20261028-1514-C3.0.84-p1n14c: PASS; log 15:16:37 (CLDV31514521_B1.dwg).
3. **Control, switch OFF:** two new cases of mine in `C:\Lisp Files\_ACAD_DRIVER\cases\controls\` (not in the main pack folder): `C13a_dp_before_reopen_switch_off` (copy of N13a) and `C13_dp_after_reopen_switch_off_refused` (copy of N13 whose assertion is turned round: it passes when the refusal text IS on the command line). Both carry `SETTING CD_Settings.json linking.reopenedDrawingLoadsItsOwnRecord false`. Valid runs: RUN-20261028-1523-C3.0.84-p1ctl2 and RUN-20261028-1528-C3.0.84-p1ctl3, both PASS (refusal seen, command line '[CE] The source landing could not be refreshed. Nothing will be placed here. Reason: The complete landing index has missing or unreadable drawing evidence (Source evidence changed during capture: 1091...'), CE log 15:25:09 and 15:30:17 `[WARN] [Source] Final landing refresh refused: ... pipe-row [first {"id":"1091A0" ...` , the same text as 3.0.83. In both, the "was opened again" line is absent (only the "closed" line appears), exactly as the fix report predicts. Settings fingerprints at the end equal the start (0 differences, guard clear).
   1. Voided first attempt: RUN-20261028-1520-C3.0.84-p1ctl (C13 alone in its own session, because only C13a carried the SETTING line; no reopen happened; its C13 "FAIL" means nothing).
4. **CE log note:** the live CE log rotated at 14:55 (the first two sessions' reopen lines are in `CE_CVL_SUITE.log.1`); every session's line was read from the log files.
5. **Not tested (RULES 5.9):** a hand close and reopen by a person; the second suspect named in the fix report (identities missing from stored rows with the save skipped); nothing was looked at on screen.

## Part 2: the regrade on 3.0.84 (in progress)

(to be filled in)
