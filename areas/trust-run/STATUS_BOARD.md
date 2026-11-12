# Trust run status board

**Rebuilt 2026-11-13 05:56 PC clock by lane trust-struc-mgr-plan, counted from the files named at the end. Nothing here is installed or accepted. Rebuilt at every check-in until told otherwise.**

---

# FOR TIM

1. **Trial changes built as drafts:** 34 (pull requests 2038 to 2073). None merged, none installed.
2. **Latest review verdict:** 30 fit for the robot to test on copies, 4 to fix first (2053, 2062, 2064, 2070), 0 stopped.
3. **Any real evidence on the trial builds:** 5 of 34 (2040, 2041, 2045, 2049, 2050), all from the core console, none from a window, the ribbon or a drawing opening in full AutoCAD. For 2064 and 2073 only the fault they cure has been seen, on the installed build.
4. **Still owed by every one:** the robot on copies in full AutoCAD, a Codex look where something is seen on screen, and your trial; that waits on question 0 (where trial builds may be seen).
5. **Accepted by you or by Codex:** none.

---

## Step 0, the read-only reader

1. **Pull request 2040: Reads what each drawn object is (pit, pipe, downpipe, tank, old palette blocks, old LISP text) without changing anything.** Verdict: GO (2026-11-13 05:10). Evidence: Run on six copies: changes nothing, same answer twice; three misses found and since addressed by the reader lane (EVIDENCE_READER.md). Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 1, the opening line

2. **Pull request 2041: One line when a Civil drawing opens: "all linked" or "needs checking".** Verdict: GO (2026-11-13 00:59). Evidence: Counting and the no-write rule pass in the core console (proof check TRUST-OPEN-01, EVIDENCE_BRANCHES.md); the line itself on a real drawing opening not seen. Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 2, the core ribbon

3. **Pull request 2038: Two tabs, CE Drainage and CE Design, with only the core buttons, behind a switch that ships off.** Verdict: GO (2026-11-13 00:54). Evidence: None (EVIDENCE_BRANCHES.md: the ribbon not seen at all). Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 3, same settings for everyone

4. **Pull request 2043: The office setup file, the list of what would change, the kept old file; switch off.** Verdict: GO (2026-11-13 04:14). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 4, Civil safety fixes

5. **Pull request 2039: Pit Schedule says which pits it left out (BUG-1274).** Verdict: GO (2026-11-13 01:28). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
6. **Pull request 2042: Unsaved-work reminder and backup copies, Civil (BUG-1276).** Verdict: GO (2026-11-13 02:17). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
7. **Pull request 2052: PIT places a pit with a blank cover level and warns (BUG-1042).** Verdict: GO (2026-11-13 05:43). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
8. **Pull request 2053: Tests that Cancel leaves CE's record as it was (tests only).** Verdict: FIX FIRST (2026-11-13 03:14, head 9ffbeccb). Evidence: None. Owed: fix the review list, then the robot on copies.
9. **Pull request 2055: CDTG, CDSL and CDWT stop updating CE's record before their first question.** Verdict: GO (2026-11-13 05:10). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
10. **Pull request 2056: Edit Pipe refuses locked layers and Xrefs before saving.** Verdict: GO (2026-11-13 05:43). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
11. **Pull request 2057: Esc cancels instead of skipping in CDWT and CDAGI (BUG-1289).** Verdict: GO (2026-11-13 04:12, head 311147d8). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
12. **Pull request 2059: CD: the "continues to another plan?" answer and missing parts (BUG-1281, 1282).** Verdict: GO (2026-11-13 05:43). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
13. **Pull request 2060: CDMA moves only CE's flow arrow, and says so truthfully (BUG-1283, 1284).** Verdict: GO (2026-11-13 04:12, head d761ccd6). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
14. **Pull request 2061: CDLPD search distances converted for metre drawings.** Verdict: GO (2026-11-13 05:10, head 7386e906). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
15. **Pull request 2062: Start-up checks (read-only, Paper Space, REFEDIT, Structural) on eight more tools (BUG-1286).** Verdict: FIX FIRST (2026-11-13 05:10, head da1a6e49). Evidence: None. Owed: fix the review list, then the robot on copies.
16. **Pull request 2063: Raingarden and AGI close distances converted for metre drawings (BUG-1313).** Verdict: GO (2026-11-13 05:10, head 0c88fe55). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
17. **Pull request 2064: A cancelled command writes nothing, and no command writes one drawing's record into another (BUG-1456).** Verdict: FIX FIRST (2026-11-13 05:04, head d64e9a72). Evidence: The fault itself seen on the installed build, 6 in 11 tries (EVIDENCE_CROSS_DRAWING.md); the fix not seen. Owed: fix the review list, then the robot on copies.
18. **Pull request 2065: CDRUNSOLVE preview says what Apply really writes (BUG-1356).** Verdict: GO (2026-11-13 05:10, head cb133d67). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
19. **Pull request 2066: The read-only check flags a blank link (BUG-1339).** Verdict: GO (2026-11-13 05:10, head 1ff10de2). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
20. **Pull request 2067: Moving the LPD clears it from the earlier pipe end (BUG-1300).** Verdict: GO (2026-11-13 05:43, head 2d825913). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
21. **Pull request 2073: Each drawing keeps its own CE record: Help, Settings and every other tool can no longer write one job into another (BUG-1456 cure, no switch).** Verdict: GO (2026-11-13 05:53, head 1a28c3b3). Evidence: The fault seen on the installed build, 6 in 11 tries (EVIDENCE_CROSS_DRAWING.md); the cure not seen yet. Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 4, Structural safety fixes (card TRUST-04 and the new Structural faults)

22. **Pull request 2044: Bracing schedule no longer one row short (BUG-497).** Verdict: GO (2026-11-13 00:06, head 87c29f01). Evidence: None (no Structural branch could be shown headless, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where seen, then your trial.
23. **Pull request 2046: Refreshing a schedule drops erased braces and piers (BUG-498).** Verdict: GO (2026-11-13 00:57, head 49f30cf2). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
24. **Pull request 2047: Roof trusses (BT1) left out of wall bracing totals, until Tim answers (BUG-499).** Verdict: GO (2026-11-13 00:58, head 4bb65787). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
25. **Pull request 2048: Unsaved-work reminder and backup copies, Structural (BUG-1276).** Verdict: GO (2026-11-13 05:43). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
26. **Pull request 2068: The A/B switch draws the new brace before erasing the old one, so a failed switch keeps the brace (BUG-1362).** Verdict: GO (2026-11-13 05:43, head 9c457445). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
27. **Pull request 2069: Beam tools say which layer stopped them instead of "internal problem" (BUG-1365).** Verdict: GO (2026-11-13 05:43, head 44e1ac66). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.
28. **Pull request 2070: Support blocks: a schedule size the block cannot show becomes Unknown, not the default size (BUG-1363).** Verdict: FIX FIRST (2026-11-13 05:43, head 93d4733f). Evidence: None. Owed: fix the review list, then the robot on copies.

## Step 5, record changes made visible

29. **Pull request 2045: The read-only tools stop changing CE's record; every other change prints one line.** Verdict: GO (2026-11-13 03:45). Evidence: Seen in the core console: CDGRAPH and CDDIAG leave the record identical, CDGRAPH counts 49 not 50 (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 6, Unknown instead of made-up values

30. **Pull request 2049: No more made-up "100 dia UPVC", lid class or pit numbers, behind a switch that ships off.** Verdict: GO (2026-11-13 02:17). Evidence: Proof check TRUST-UNKNOWN-01 passes in the core console (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 7, the LPD as the start point

31. **Pull request 2058: The LPD confirmed once and stored; tools start from it.** Verdict: GO (2026-11-13 05:10). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.

## Step 8, Check this drawing, first slice

32. **Pull request 2051: A read-only list of Sure, Proposed and Unknown (typed CDCHECKDRAWING), switch off.** Verdict: GO (2026-11-13 04:14). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.

## The robot's own proof checks

33. **Pull request 2050: Headless checks that prove steps 1, 5 and 6 change nothing.** Verdict: GO (2026-11-13 03:45). Evidence: All four checks pass in the core console, each with a faulty twin that fails (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where seen, then your trial.

## Structural step S1, the cut-down tab

34. **Pull request 2054: One Structural tab with the core tools in roof-down order, switch off.** Verdict: GO (2026-11-13 04:14). Evidence: None. Owed: the robot on copies, then a Codex look where seen, then your trial.

---

## Where these come from

1. **Verdicts, times and heads:** the latest line per pull request in `areas\trust-run\trust-review.md` (the pull request each line opens with). A head is shown only where that line states one.
2. **Plain names and plan steps:** this lane, from the same review lines and the builder lane files.
3. **Evidence:** `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_READER.md`, `EVIDENCE_CROSS_DRAWING.md`, `EVIDENCE_STALE_BUGS.md`. Fixes seen on the installed build (BUG-650, BUG-968, BUG-290) are not trial changes and are on the morning page instead.
