# Runner B5: the Codex case-review asks (R09, R04, R11, R13, R14, R19, R21, R22, R24, R26) on the installed build (Mon 26 Oct 2026)

Written Mon 26 Oct 2026 about 20:50 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER: APPLY THE CODEX CASE REVIEW ASKS". Real AutoCAD 2027 on test copies only, one session at a time under the shared lock as `Claude-driverv3`. Nothing in `DESK_LOG.md`, `BUG_CARPARK.md`, any `review.txt` or `ledger.json` was edited by hand. Built and run by me; **not independently reviewed**.

## FOR TIM

1. **Nothing for you to decide and nothing for you to test.** Most of the work is done; two cases still need their second run on the newest build, and one case cannot be run at all yet.
2. **A new Civil build, 3.0.79 (Manager 1.1.79), landed at about 17:00 while I was working.** Everything I proved before that is on 3.0.78 and counts as the older build. On 3.0.79 each case so far has one pass, not two.
3. **Proved twice on 3.0.78 (two separate AutoCAD starts each, with a failing twin):** R04 (CE never saves), R11 (Edit Pipe with U and REDO), R13 (CDSYNC warns then relinks), R19 (erase a pit keeps the pipes, U brings it back).
4. **One pass on 3.0.79 as well:** R14 (the freeboard warning, and now the raised 200 mm setting), R21 (CDCHECK totals), R26 (CDSURVEY refusal), R13. R22 (CDCHECK words) fails on 3.0.79 exactly as on 3.0.78, which is the real fault it is meant to show (BUG-372).
5. **The downpipe double-click (R09, BUG-859) is still a real fault.** The right log is now read. CE catches the double-click, but AutoCAD's own attribute editor still opens first. It failed the same way in two separate sessions on 3.0.78. The two runs on 3.0.79 were blocked by a robot start-up fault, so that is not yet repeated on the new build.
6. **R24 (the metre drawing) is NOT run.** No drawing really saved in metres exists on this PC (see below). I need one before the case can mean anything.
7. **Why the job stopped short:** Codex held the AutoCAD lock for about 1 hour 40 minutes, so a whole pack of mine was blocked; later two packs hit robot faults; then the 2-hour limit of my background runner cut the last chain off. I did not restart it. No AutoCAD of mine is left running and Tim's four settings files match their expected hashes.

---

## ANSWER FIRST (for the independent reviewer)

Hash is the first 12 characters of SHA-256 of the case file as it stands now. Builds: **3.0.78+d8840a09** (runs up to b5r2d, 16:44) and **3.0.79+d3f9c5d** (runs b5r2e onward, from 17:06). Structural 1.0.124+3a3caa all along. Run ids are `RUN-20261026-<time>-C<build>-<tag>`; reports and JSON are in `runner-reports\`.

1. **R09 (BUG-859, double-click on a new downpipe). FAIL(known) twice on 3.0.78, BLOCKED twice on 3.0.79.** Hash 8763A665A9C3; variant `R09_OFF_BROKEN` 93283A5F5254. EXPECT-FAIL BUG-859 kept. On 3.0.78: b5a1 (13:12) 6 of 12, b5r1b (14:18) 6 of 12, b5r2a (15:52) 6 of 12, each time the log check `log civilx has "TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle"` passes and the window checks 3 to 8 fail (only "Enhanced Attribute Editor" is open). The OFF variant fails the log check (5 of 12), so it is a true red. Evidence line (b5a1, structured log 13:18:20): the scheduled-CDEDIT line present, window list only "Enhanced Attribute Editor". The evidence line is also in the case header and NOT_AUTOMATED. 3.0.79: b5s1a BLOCKED both (`the watchdog did not start within 20 s`, a robot start-up fault, no result). Not rerun.
2. **R04 (CE never saves). PASS on 3.0.78 twice:** b5r1g (15:45) and b5r2d (16:32), 6 of 6 each. Hash 443604166CC0 (unchanged since B4). Failing twin `R04_SAVE_BROKEN` CF906DD5B5FB FAIL both (4 of 5, `copy-unchanged`). Not run on 3.0.79 (chain cut off). Covers PIT, CD, CDSYNC, CDRECOVERINVERTS and PITSCHEDULE only.
3. **R11 (Edit Pipe cascade, U and REDO). PASS on 3.0.78 twice:** b5r1b and b5r2b, 19 of 19. Hash B40EBE88E6B6. Twin `R11_BROKEN` 8816ED720182 FAIL both (16 of 19, checks 10 to 12). 3.0.79: BLOCKED (`v2 HARD TIMEOUT`, a tool fault) in b5s1b.
4. **R13 (CDSYNC warns then relinks, Pit Schedule figures before and after). PASS on 3.0.78 twice (b5r1b, b5r2b) and PASS on 3.0.79 once (b5s1b, 18 of 18 each).** Hash BE176845E3D2. Twins `R13_BROKEN` 5BF76CC1A48A (17 of 18, check 2) and `R13_ROWS_BROKEN` 20F1DA2ECDA6 (16 of 18, checks 7 and 10) FAIL on 3.0.78 in b5r1b and b5r2c. Not run on 3.0.79.
5. **R14 (CDTWL freeboard 150 mm, and the raised setting). PASS on 3.0.78 (b5r1e) and PASS on 3.0.79 (b5r2e, 17:06).** 9 of 9 each. Hash 6B375F8D1219. Reds FAIL both builds: `R14_DSTD_BROKEN` 7A3DDB43627D and `R14_PIPEKEY_BROKEN` 2A7B5814A3EC (5 of 9, checks 1 to 4), `R14_BROKEN` 0A1D406FC38A (0 of 1). The raise-the-setting cases (setting set through the settings guard, restored by hash) `R14h_dstd_200` 75A91D22C754, `R14h_pipekey_200` CCF6A4F7A293, `R14h_both_200` DF7288A88698: PASS 6 of 6 on 3.0.78 (b5r1f) and PASS 6 of 6 on 3.0.79 (b5r2f), so the warning follows the 200 mm setting. **Two passes on one build: not yet** (one on each build).
6. **R19 (erase a pit keeps pipes, U restores, the missing half). PASS on 3.0.78 twice: b5r1d and b5r2c, 20 of 20.** Hash BE503780EB3B. Twins `R19_BROKEN` 459642E60F06 (19 of 20, check 4) and `R19_NOU_BROKEN` 68F58D55C1E2 (16 of 20, checks 9, 12, 13, 14) FAIL in b5r1d and b5r2d. Not run on 3.0.79.
7. **R21 (CDCHECK totals, stronger reads). PASS 10 of 10 on 3.0.78 (b5r1a) and on 3.0.79 (b5s1g, 18:39).** Hash 2462CD753D29. Twin `R21_BROKEN` 8A3037724FDB FAIL both (7 of 10, checks 1 to 3). One pass per build.
8. **R22 (CDCHECK words). FAIL(known) 4 of 7 on 3.0.78 (b5r1a) and on 3.0.79 (b5s1g), checks 2 to 4 fail.** Hash 8C3D7C746AD4. EXPECT-FAIL BUG-372 kept (real fault: handle and internal-id words still print). The positive check `[CE] CDCHECK:` passes, so silence is not success. Same result both builds; a second run on one build is still wanted.
9. **R24 (metre drawing). NOT RUN.** The case still switches INSUNITS to 6 on a millimetre master. The review needs a drawing genuinely saved in metres. The three DRV*_METRE masters read INSUNITS 4 (earlier probes), CLD393_METRE is a copy of DRV15_METRE, and `METRE_VERIFYC4C.dwg` and `METRE1_VERIFYC5.dwg` (under `_TEST_COPIES_20260923`) were not probed. **What is needed:** one drawing saved with INSUNITS 6 and pit and text blocks in metres, registered as a fixture; then the review's lines (remove `v3 setvar INSUNITS 6`, add `ui-dump "New Pit" -> $pit_size_before` and its `record`, a check tied to the selected pit size, a mis-scaled twin). Hash of R24 unchanged 1BECEC091BED.
10. **R26 (CDSURVEY refusal stores nothing). PASS 11 of 11 on 3.0.78 (b5r1a) and on 3.0.79 (b5s1g).** Hash 2EC1D6D74E0F. Reds `R26_BROKEN` F97ED32F05D5 (10 of 11, check 1) and `R26_PICK_BROKEN` D4D56A81DFC8 (10 of 11, check 3) FAIL both. The wrong-pick sentence `[CE] Please click directly on the survey XREF block.` and the second-call checks are in. Part only: no survey Xref exists, so V1 intake and D26 (CDSL) are not proved.
11. **Ready for the independent reviewer (two passes on one build and a red twin):** R04, R11, R19 (all 3.0.78) and R13 (3.0.78 twice, plus one on 3.0.79). **Real-fault cases whose FAIL is the result:** R09 (BUG-859, two FAILs on 3.0.78) and R22 (BUG-372). **Needs a second pass first:** R14 and its raise cases, R21, R26 (one pass per build). **Not ready:** R24.
12. **Straddles:** no run crosses the 3.0.78 to 3.0.79 install: b5r2d ended 16:44 on 3.0.78, b5r2e began 17:06 on 3.0.79. A first b5r2g (17:35) was BLOCKED entirely by Codex's lock (60-minute wait ran out), no result.

## Blocked runs, said plainly

1. **b5r2g (17:35, 3.0.79):** all six cases BLOCKED, the lock was held by Codex-E7 from 17:33 to about 19:15. Never forced.
2. **b5s1a (19:31):** R09 and R09_OFF_BROKEN BLOCKED, watchdog did not start.
3. **b5s1b (19:51):** R11 and R11_BROKEN BLOCKED, `v2 HARD TIMEOUT`; R13 passed.
4. **b5s1c (20:20):** R13_BROKEN, R13_ROWS_BROKEN, R19 on 3.0.79: no report, the background runner hit its 2-hour limit and was stopped. Its lock file was left behind by the dead runner; I removed it (it was mine, holder gone). I did not restart the chain, as the tool advised.
5. **Not run at all on 3.0.79:** R19 group, R04 group, second pass of everything.

## What I changed, listed loudly

1. **Case files:** none edited in this restart session. The first session (13:10 to about 15:20) had already applied the review lines to R09, R09_OFF_BROKEN, R11, R11_BROKEN, R13 and its twins, R14 and the three R14h cases, R19 and twins, R21, R22, R26 and twins (case file dates 14:08 to 15:16); the hashes above are those current texts. R24, R04 untouched. No review.txt written; no case with a review.txt touched except as the job named.
2. **Runner, v2, v3 driver:** untouched. Scratch only: `C:\ce_rc_scratch\b5fix\` (run helpers, chain list files, a `chain3.ps1` copy that waits 200 s between packs so AutoCAD is free for other jobs).
3. **Tim's four settings files** read back at 20:48: CD_Settings.json ACD64E79A33B, TIM_CE_CADTOOLS CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74, Structural CS_Settings.json 0791B07EBCD9 (the value since the 25 Oct Structural install). No acad.exe of mine running.

## Not done, said plainly (RULES 5.9)

1. Second pass on 3.0.79 for every case; R09, R11 on 3.0.79; the whole R19 and R04 groups on 3.0.79.
2. R24 (needs a genuine metre drawing and Tim's word on any engineering pit size).
3. Nothing was looked at on screen; no Codex look requested.
4. R26 proves only the refusal half; R14 proves the warning wording and the raised setting only, not BUG-777, BUG-871 or BUG-1032.

To finish (free window, nobody on the PC): `pwsh -NoProfile -File C:\ce_rc_scratch\b5fix\chain3.ps1 -ListFile C:\ce_rc_scratch\b5fix\list4.txt -ChainTag c5` runs the remaining packs (edit the list first to drop b5s1g and b5s1b's R13 line, add the R09 and R11 re-runs); run it in pieces under the 2-hour tool limit.

## Summary (under 100 words)

Civil 3.0.79 landed mid-job. On 3.0.78, R04, R11, R13 and R19 each passed twice with failing twins; R09 failed twice (real fault BUG-859, right log now read); R22 fails as meant (BUG-372). On 3.0.79, R14 (plus raised-setting cases), R21, R26 and R13 each passed once; R22 failed the same way. R09 and R11 on 3.0.79 were blocked by robot faults, Codex held the lock for 100 minutes, and my runner hit its time limit. R24 not run: no genuine metre drawing exists. No bug status changed.
