# Runner re-grade of every accepted case on the newly installed build 3.0.77 (Sun 25 Oct 2026)

Written Sun 25 Oct 2026 about 23:25 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER: RE-GRADE EVERY ACCEPTED CASE ON THE NEWLY INSTALLED BUILD". Job ran 20:50 to 23:21 (Sunday night, free window). Real AutoCAD 2027 on test copies only: 21 AutoCAD sessions (plus the runner's own automatic re-run of R08), one at a time under the shared lock as `Claude-driverv3`, foreground only. No case file, variant, review.txt, ledger.json, DESK_LOG.md or BUG_CARPARK.md was touched by me (the runner wrote the ledger rows). Built and run by me; **not independently reviewed**.

## FOR TIM

1. **All 20 cases passed twice on 3.0.77. None failed.** Each passed in two separate AutoCAD sessions on Civil 3.0.77+0d885094. The runner itself printed ACCEPTED-READY for all 20 on the second pass. So the nine C-67 fixes and the unreleased C-66 changes did not break any of them.
2. **No case was skipped for a changed file.** All 21 review files that say ready still match their case files exactly (R08 is one of the 21). Nothing needed reporting as "changed since review".
3. **The everyday-tool cards these 20 cases cover (D-numbers):**
   1. **D01** (PIT and CD keep placing until Esc, one U takes it back): R01.
   2. **D03** (a new pipe starts on a pit and ends on a pit and joins both): R02 and R02b together.
   3. **D04** (Esc at CD's third point cancels cleanly): R17.
   4. **D12** (one invert-level text at each pipe end): R03.
   5. **D14** (erase a pit that has several pipes, pipes stay, U brings it back): R19b.
   6. **D17** (CDEDIT keeps the selection): R20.
   7. **D26 is only part covered** (R35 checks the typed-level wording and the five accepted level forms; the survey line and the blank level are not run).
4. **The other cases cover bugs and specs, not a D-card:** R05 (one outcome line per command, #1507), R07 (Settings window opens, Cancel throws changes away), R10 (CDCHECKIGNORE with the switch off, BUG-863), R15 (Recover Inverts, C38), R16 (Tidy labels, C37), R23 (locked pipe layer, BUG-384), R28 (CDPROFILE start), R31 (BUG-205 wording half only), R35 (BUG-711), R37 (BUG-217 prompt wording half; a Codex look at PD1 on the plan is still needed), R38 (Pit Schedule row P3), R39 (BUG-697), R39b (BUG-684). Each is only as wide as its own review file says; none of this is Tim-accepted.
5. **R08 (REDO after U and a pick) is still a failure, reported separately and not counted.** First session: FAIL in both attempts, with CE's command line showing "Nothing to redo" where "Everything has been redone" was expected. Second session: BLOCKED by a runner tool error (not a CE result). BUG-861 stays open.

---

## Detail (for the desk)

### Build read live (20:51 start, again in every run header, and again at 23:21 end)

1. Civil 3.0.77+0d8850949cb764e4b3af36f99276b74312584ce5 (Legacy, Modern, Net8 all the same). Manager 1.1.77+0d885094. Structural 1.0.124+3a3caac5.
2. The build did not change during the job, so no run straddles an install. Every run header says `civil 3.0.77+0d885094`.

### Which cases were kept

1. Method: every `*.review.txt` read; kept where the VERDICT line is `CLAUDE-ACCEPTED-READY` and `CASE_SHA256_REVIEWED` equals today's Get-FileHash of the case file. 21 kept, 0 with a differing hash.
2. Kept (21): R01, R02, R02b, R03, R05, R07, R08, R10, R15, R16, R17, R19b, R20, R23, R28, R31, R35, R37, R38, R39, R39b.
3. Not run (verdict not ready): R04 (needs broken variant), R06 (needs Codex look), R09 (verdict FAIL, real fault BUG-859), R11, R12, R13, R14, R18, R19 (stronger assertion or partial). R21, R22, R24 to R27, R29, R30, R32 to R34, R36, R40 have no review file.

### Runs (all Civil 3.0.77, one AutoCAD session each, clean end, 0 settings differences)

Pass A (first sessions), then pass B (second sessions, a different session in a separate call):

1. **R05, R07, R10:** A `g77a1` RUN-20261025-2051 PASS x3. B `g77b1` RUN-20261025-2212 PASS x3.
2. **R17, R20, R23:** A `g77a3` RUN-20261025-2113 PASS x3. B `g77b3` RUN-20261025-2215 PASS x3.
3. **R19b, R28, R35:** A `g77a4` RUN-20261025-2118 PASS x3. B `g77b4` RUN-20261025-2221 PASS x3.
4. **R31, R37, R38:** A `g77a5` RUN-20261025-2121 PASS x3. B `g77b5` RUN-20261025-2224 PASS x3.
5. **R39, R39b:** A `g77a6` RUN-20261025-2130 PASS x2. B `g77b6` RUN-20261025-2232 PASS x2.
6. **R02, R02b, R03:** A `g77a7` RUN-20261025-2136 PASS x3. B `g77b7` RUN-20261025-2238 PASS x3.
7. **R01:** A `g77a8` RUN-20261025-2149 PASS. B `g77b8` RUN-20261025-2252 PASS.
8. **R15:** A `g77a9` RUN-20261025-2202 PASS. B `g77b9` RUN-20261025-2306 PASS.
9. **R16:** A `g77a10` RUN-20261025-2206 PASS. B `g77b10` RUN-20261025-2311 PASS.
10. **Acceptance field:** every pass-A run printed "0 ACCEPTED-READY, n PASS-UNREVIEWED" (one pass only); every pass-B run printed "n ACCEPTED-READY, 0 PASS-UNREVIEWED". 20 of 20.
11. Reports and JSON: `C:\CE_PLAN\areas\runner-reports\RUN-20261025-*-C3.0.77-g77*.md/.json`.

### R08 (extra observation, never counted)

1. `g77a2` RUN-20261025-2056 (20:56 to 21:13): FAIL, then the runner's automatic re-run in a fresh session also FAIL. Check 5 `contains $redo1 "Everything has been redone"` failed and check 6 `not-contains "Nothing to redo"` failed: the line read `Command: | Command: REDO | Nothing to redo`. Civil CE log: 157 new lines, 0 with [ERR]. Same shape as the known fail on 3.0.75 (BUG-861).
2. `g77b2` RUN-20261025-2316: BLOCKED before any step: `Exception setting "CalibRetry": The property 'CalibRetry' cannot be found on this object` (a runner session-state error after calibration said ok=False; not a CE result). Not re-run (one per session was the ask; it is not counted either way).

### Regression check

No counted case failed, so there is no possible regression to chase and no third session was needed.

### Safety read-back at the end (23:21)

1. Settings files: CD_Settings.json ACD64E79A33B, CS_Settings.json (TIM_CE_CADTOOLS) 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74: equal to the expected values. **Structural settings file differs from the old expected value:** `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` now reads 0791B07EBCD9 (35467 bytes), not the 2972CE70C514 quoted in earlier jobs. Its last-write time is 25 Oct 17:41:51, which is the Structural 1.0.124 install, hours before this job started; the runner's own per-run fingerprint check showed 0 differences in every run, so this job did not change it. Flag for the desk: the guard's expected hash for that file is stale.
2. No acad.exe left running; lock free; every run header "clean end: True".
3. Scratch (this PC only): `C:\ce_rc_scratch\regrade\` (select.ps1 chooses the cases, runpack.ps1 runs one batch, post.ps1 reads back). Not build or deploy scripts.

### What I did NOT check (RULES 5.9)

1. Nothing was looked at on screen; every case is a deterministic check (command-line text, drawing values, log lines, window titles, hashes).
2. Each case is only as wide as its review file: R05/R10 not every CE command; R31 BUG-205 wording half only; R37 non-visual half only; R38 and R28 narrow claims; D26 part only. BUG-861 (R08) is not closed.
3. The pass counts are on 3.0.77 only; the unreleased C-66 changes are not in this installed build, so they were not exercised.
4. Why the Structural settings hash moved at 17:41 (install, or something else) is not established.

## Summary (under 100 words)

Civil 3.0.77 was re-graded. 21 cases had a ready review with an unchanged hash; 20 counted cases each passed in two separate AutoCAD sessions (the runner printed ACCEPTED-READY for all 20), none failed. They cover D01, D03, D04, D12, D14 and D17 fully, D26 in part, plus 13 bug/spec cases. R08 stayed a known fail (BUG-861) once and was BLOCKED by a runner error once; it is not counted. Settings restored, no AutoCAD left, build unchanged during the job.
