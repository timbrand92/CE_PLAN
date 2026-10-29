# Runner report: C-76 bug proofs and full re-test on Civil 3.0.86

Written Fri 30 Oct 2026, about 06:10 Melbourne time, by the tally job (CE_ACAD / robot / test / 16). Read-only tally of the runner's own report files. No ledger, carpark, case or runner file was edited.

---

## ANSWER FIRST

**All three fixes (BUG-859, BUG-372, BUG-1228) work in the robot's AutoCAD. One old fault (R21) is still open, and it is not a C-76 regression. Nothing was seen on a screen by a person, and no bug is marked FIXED.**

## FOR TIM

1. **No regression from C-76.** Every accepted case that failed or was blocked on 3.0.86 either passed on a clean second start or is the known fault named below. The two that stayed short are R08 and R21.
2. **BUG-859 (double-click on the downpipe DP1): the fix works.** The new window case R09s passed in 2 starts of 2 that actually ran. The double-click opened "Creative Engineering | Edit source" with the tag DP1, and AutoCAD's Enhanced Attribute Editor never opened, not even 10 seconds later.
3. **BUG-859 control:** with the new switch turned OFF the robot saw AutoCAD's Enhanced Attribute Editor open, as it did on 3.0.85. That proves the case can tell the two apart.
4. **BUG-372 (CDCHECK showing handles and CE-CIV-PIPE ids): the fix works.** R22 passed 2 of 2. With the switch OFF the case failed on exactly the two checks it should (the old FALL arrow line with a handle, and the CE-CIV-PIPE lines).
5. **BUG-1228 (downpipe takes about 30 s): the fix works, with one honest wrinkle.** N36 passed 2 of 3 starts. The first start (a cold start) failed by a whisker: one read took 1617 ms against a 1500 ms limit, and the whole DP took 11.3 s against 10 s. The next two starts read in about 1.1 s and the DP took about 8.1 s. With the fix OFF, the same drawing took 28.9 s.
6. **Full re-test: 64 of the 66 counted cases have two clean PASS starts on 3.0.86.** The two short are R08 (the known mouse-focus fault, blocked every time) and R21.
7. **R21 is the old B-055 fault, not C-76.** CDCHECK reads the wrong pit and pipe list when a drawing is reopened in the same AutoCAD. It failed 3 times on a start after R12 and passed once when it ran after other cases. See `areas\R21_MOVE_UNDO_DIAGNOSIS_30OCT.md`.
8. **Needs a Codex look:** BUG-090, the Manager About window (CE_VERSION), at 100 and 150 percent display scaling. It is a window and was not part of this job.
9. **Still needed before anything counts as accepted:** an independent Opus review that names the case hash, for R09s, R22, N32, N33 and N36 (details below).

---

## DETAIL

### 1. Build and install
1. **Civil DLL ProductVersion:** 3.0.86+5888ee757244aac89283aaaf2ba68e51470ecbb3 (read again at 06:05, unchanged since the chain started, so no pass is voided).
2. **Manager DLL:** 1.1.86+5888ee757244aac89283aaaf2ba68e51470ecbb3.
3. **Install time (Civil bundle Contents folder created):** Thu 29 Oct 2026 5:51 PM.
4. **Chain:** 33 spec lines, ALL DONE at 04:40 on Fri 30 Oct. Afterwards CE 02 added diagnostics a80X8, a80X9, a80X7 and extra clean starts b80X6, b80X5a, b80X5b. All on the same build (the chain's progress file records the build on every line).

### 2. Case hash note
1. **Hashes in the job text were stale for three drafts.** R09s, R09s_new_switch_off_broken and R09s_compound_off_broken were edited at 16:33 on 29 Oct (copies of the older text are kept as .pre_review). The runner recorded the new hashes: R09s 22A1F008, R09s_new_switch_off_broken 0DBDCD01, R09s_compound_off_broken 5BA73D0D. This was before the chain started, so every run used the same text.
2. **Unchanged hashes:** R09 8763A665, R09_off_broken 93283A5F, R22 8C3D7C74, R22_off_broken BACB1EB2, N36 98209E97, N36_BROKEN 27C84F95, all as the job listed.

### 3. Proofs, one by one
1. **R09s (BUG-859, the new case).** Hash 22A1F008. a80R09s was BLOCKED (AutoCAD busy). PASS in b80R09s (RUN-20261029-2000-C3.0.86-b80R09s) and PASS in b80X5a session 1 (RUN-20261030-0519-C3.0.86-b80X5a). All 14 checks passed both times, including SourceEdit.Tag = DP1, SourceEdit.Cancel, SourceEdit.OK and the window closing. So the case text did not need correcting.
2. **R09 (old case).** Hash 8763A665. BLOCKED both times (AutoCAD busy), so it never ran on 3.0.86. It is expected to fail checks 5 to 8 anyway (wrong control names), so R09s replaces it.
3. **R09_off_broken (sourceEditWindow OFF).** FAIL in a80T09, on checks, not on a broken step: check 2 (no TryRedirectToCdEdit log line), check 3 (Edit source not open), check 4 (Enhanced Attribute Editor opened), checks 5 to 8 (window not open).
4. **R09s_new_switch_off_broken.** a80C09n BLOCKED (AutoCAD busy). In b80X5a session 2: FAIL on check 2 (no "EATTEDIT stopped before AutoCAD" line), check 4 and check 5 (Enhanced Attribute Editor opened). The fix works only if this twin opens AutoCAD's editor, and it did.
5. **R09s_compound_off_broken.** FAIL in a80C09c, on checks 2 to 5 (no stop line, Enhanced Attribute Editor opened) and the dependent window checks.
6. **R22 (BUG-372).** PASS in a80R22 (RUN-20261029-1907) and PASS in b80R22 (RUN-20261029-2018). Hash 8C3D7C74.
7. **R22_off_broken.** FAIL in a80D: check 2 found "[CE] Fall 1. FALL arrow, handle 1197BB ... (off by 168 degrees)" (27 lines with "handle "); check 3 found "CE-CIV-PIPE-6A33BA73-..." (17 lines). Check 1 passed, as the job asked.
8. **N36 (BUG-1228).** Hash 98209E97. Start 1 (a80D, session 2): FAIL on check 9 (source landing read 1617 ms, over 1500) and check 10 (DP completed 11303 ms, over 9999). Start 2 (b80N36): PASS, source landing read 1068 ms, source change read 448 ms, DP completed 8122 ms. Start 3 (b80X5a session 3): PASS, reads 1172 ms and 396 ms, DP completed 8182 ms. All three show "reads each object once: on". Likely a cold-start effect on the very first start of the whole chain; not proven.
9. **N36_BROKEN.** FAIL in a80D, as wanted: reads 5509 ms and 5210 ms, "reads each object once: off", DP completed 28902 ms. The placement checks (1 to 4) passed.
10. **N32 (D24, every new object on its office layer).** a80K1 BLOCKED (not calibrated). PASS in b80K1 (RUN-20261029-2029) and PASS in b80X5b (RUN-20261030-0546). Two passes in different sessions. Twin N32_BROKEN FAIL in a80K1 on "value CETWIN20TEXT | CETWIN20TEXT (expected 20TEXT | 20TEXT)", as designed. N32 was running at job start; this is its second clean start. Note: the note I was given said b80X5b ended about 06:05, but its log already held a run line (ended 05:54), so I counted it.
11. **N33 (D21, schedule groups).** PASS in a80K1 and PASS in b80K1: two passes in different sessions. Twin N33_BROKEN FAIL in a80K1 on the order check (CP2 expected above P1), as designed.

### 4. What each proof still needs
1. **R09s:** 2 passes on one build, twin fails as wanted. Needs an independent Opus review naming hash 22A1F008 against the BUG-859 entry. The window itself ("Edit source" looks right) needs a Codex look, because a person must see it.
2. **R22:** 2 passes, twin fails on the right checks. Needs the Opus review naming hash 8C3D7C74. It is a command-line check, so it can count as Claude-accepted once reviewed.
3. **N36:** 2 passes of 3 starts, with the cold-start miss above. Needs the Opus review naming hash 98209E97, and the reviewer should decide whether the first-start miss (1617 ms, 11.3 s) means the limits are too tight for a cold start. Not for me to loosen.
4. **N32:** 2 passes. Needs the Opus review naming its hash (not re-read here).
5. **N33:** 2 passes. Needs the Opus review naming its hash (not re-read here).
6. **BUG-090:** needs the Codex look at 100 and 150 percent scaling. Not run.

### 5. Full re-test (66 counted cases)
1. **Two PASS starts on 3.0.86 (64):** N01 N02 N03 N04 N05 N06 N07 N08 N09 N11 N12 N15 N16 N17 N18 N19 N20 N21 N22 N23 N24 N25 N26 N27 N28 N29, R01 R02 R02b R03 R04 R05 R07 R10 R11 R12 R13 R14 R14h_both_200 R14h_dstd_200 R14h_pipekey_200 R15 R16 R17 R19 R19b R20 R23 R26 R28 R31 R32 R32b R33 R33m R34a R34sn R35 R36 R37 R37b R38 R39 R39b.
2. **One PASS (1):** R21. Failed in a80F8, b80F8 and a80X8 (and R21_DIAG in a80X9) on "command line holds 0 lines containing '[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected' (expected 2)". It passed in a80X7 when run after R23, R20, R19, R19b. This matches the B-055 diagnosis; it is not a C-76 regression.
3. **None (1):** R08 (counted as R08_redo_after_pick_x5). BLOCKED "AutoCAD busy" in a80L and b80L: the known mouse-focus fault. Never ran.
4. **Blocked once, then cleared:** R02b (a80F3, "v2 HARD TIMEOUT") and R32 (a80F5, same) were BLOCKED in their first starts, a tool or load problem and not a result. Both PASSED in b80X6 (RUN-20261030-0507). The tally counts them as two passes (R02b with b80F3 and b80X6; R32 with b80F5 and b80X6), so each has two clean PASS starts.
5. **Other cases that ran in the old 3.0.85 list:** nothing else failed. The tally counts two PASS sessions each from the a and b chain starts.

### 6. State at the end
1. **AutoCAD (acad.exe) running:** 0 at 06:05.
2. **Lock:** none (no active ACAD_LOCK file; the other lock files in C:\ce_rc_scratch are old, dated 22 to 27 Oct).
3. **Settings guard:** ALARM on b80X5a: session 2 "did NOT end clean (acad left 0, lock stale, guard clear False)". The session after it (b80X5a session 3) and the whole later b80X5b run ran normally and ended without an alarm. Only older backups of 22 Oct sit in the guard folder. I did not open the settings file to check it, so CE 02 should confirm the guard is clear.
4. **CD_RecentValues.json:** the SHA-256 now (after everything) is 1ED40D52CDAD6D1DF5F1CDFC0B7A37B29F7B0777BD9DBDDE2E707489CA90C233. The "before" hash was not recorded by the first attempt of this job (it ended early), so I cannot give it. Every case that runs CD and starts a pipe rewrites it, as do SETUP-P8, SETUP-P8x2 and SETUP-R47.

### 7. What was not run, and what was not tested
1. **Not run:** R09 (blocked twice), R08 (blocked twice), BUG-090 (a window, out of scope for this job). No failed case was re-run again by me: the time window was Fri 06:00 to 07:50 and I was told not to wait for any process, and the clean extra starts b80X6, b80X5a and b80X5b were already run by CE 02.
2. **Nothing was looked at on a screen.** Window titles and control names were read by the runner, not seen by a person. Timings are the CE log's figures, not a stopwatch.
3. **I did not re-read the N32 and N33 case hashes or the Opus review files.**
4. **No bug is marked FIXED.** I did not write the ledger or edit any carpark file.
