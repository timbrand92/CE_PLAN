# Claude-accepted ledger (Tim's rule of 24 Oct 2026; see decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md and RULES.md)

Items accepted by the runner plus an independent Opus review, on the installed build. Written by the desk. Never edited to say more than the reviews say.

1. **R15 Recover Inverts totals (spec card C38), 24 Oct 2026, installed Civil 3.0.72 / Manager 1.1.72.** Passed in two separate AutoCAD sessions (runs 3 and 4 of RUNNER_PHASE3_BATCH1), its broken variant R15_BROKEN fails as it must, and the independent review (areas\RUNNER_CASE_REVIEW_R11_R20_2026-10-24.md) found it covers the card. **Claude-accepted (daily tool: Recover Inverts).** No bug is proved by it, so no carpark entry changes.

Not yet accepted (from the same review): R11, R12, R14, R16, R18, R20 (need stronger checks or a broken variant), R13, R17, R19 (partial), R01-R10 (hardening job running).
2. **R17 Esc at CD's third point (daily tool D04), 24 Oct 2026, passes on Civil 3.0.73 (installed build is now 3.0.74: two passes on 3.0.74 owed).** Two sessions, red run on its broken variant, independent review (areas\RUNNER_CASE_REVIEW_B2_2026-10-24.md) says CLAUDE-ACCEPTED-READY. The "Enter gives the straight pipe" half is not in this acceptance. **Claude-accepted (daily tool D04, Esc half).**

3. **R20 CDEDIT keeps the selection (daily tool D17), 24 Oct 2026, Civil 3.0.74.** Two sessions, broken variant red, independent review says CLAUDE-ACCEPTED-READY. **Claude-accepted (daily tool D17).**

4. **R16 Tidy labels names the pipe (spec card C37), 24 Oct 2026, Civil 3.0.73 (3.0.74 re-runs owed).** Two sessions, broken variant R16_off red, independent review says CLAUDE-ACCEPTED-READY. Works only with the Tidy labels switch ON; the switch is OFF in Tim's file, so this is not proof for colleagues on 9 Nov until that is settled (question for Tim). **Claude-accepted (gap-plan check "Tidy labels names the pipe", switch ON only).**

Ledger note from the same review: runner run h2 is stamped Civil 3.0.73 but really ran on 3.0.74 (the install landed during its wait for the lock), so its R13 and R14 rows count as 3.0.74, not 3.0.73. ledger.json was not edited. Bugs: none may be written FIXED yet (BUG-384 is one assertion short).
