# Trust run status board

**Rebuilt 2026-11-13 07:26 PC clock by lane trust-struc-mgr-plan, after the review `reviews\status-board-check.md` (FIX FIRST, eight corrections). Counted from GitHub (open draft pull requests whose branch names contain "trust" or "bug-1456") and from the files named at the end. Nothing here is installed or accepted. Rebuilt at every check-in until told otherwise.**

---

# FOR TIM

1. **Trial changes built as drafts:** 47 open on GitHub (pull requests 2038 to 2084). None merged, none installed.
2. **Latest review verdict:** 42 fit for the robot to test on copies, 3 to fix first (2053, 2074, 2082), 2 not reviewed yet (2083, 2084).
3. **Moved on GitHub since their last review, verdict not re-confirmed:** 7 (2040, 2049, 2066, 2068, 2072, 2074, 2078).
4. **Any real evidence on the trial builds themselves:** 5 of 47 (2040, 2041, 2045, 2049, 2050), all from the core console; none from a window, the ribbon or a drawing opening in full AutoCAD. For 2073 only the fault it cures has been seen.
5. **Still owed by every one:** the robot on copies in full AutoCAD, a Codex look where something is seen, and your trial; that waits on question 0 (where trial builds may be seen). Some rows owe more first; each row says.
6. **Accepted by you or by Codex:** none.

---

## Step 0, the read-only reader

1. **Pull request 2040: Reads what each drawn object is (pit, pipe, downpipe, tank, old palette blocks, old LISP text).** Verdict: GO (2026-11-13 05:10); reviewed head d93ebdc0, GitHub head ebf7a21a: moved since review, GO not yet re-confirmed. Evidence: Run on six copies: the drawing's change counter and the files stayed the same, and each reading came out the same twice; CE's stored record was NOT compared before and after (EVIDENCE_READER.md). Owed: one small fix (a copy holding only an LPD turns "no CE record or unreadable" into "format not stated") and one caution (the 2500 mm pipe-end level reach was fitted to a made-up drawing whose layout was a guess); then the robot on copies.

## Step 1, the opening line

2. **Pull request 2041: One line when a Civil drawing opens: "all linked" or "needs checking".** Verdict: GO (2026-11-13 00:59); reviewed head 31f426ab, same on GitHub. Evidence: Counting and the no-write rule pass in the core console (proof check TRUST-OPEN-01, EVIDENCE_BRANCHES.md); the line itself on a real drawing opening not seen. Owed: three case-file disagreements for the controller to settle before the robot runs those cases (O18, O20, the word "record"); a "-" pipe end counts as linked in step 1 but "no owner" in step 5; then the robot on copies.
3. **Pull request 2078: Follow-up to the job mix-up (BUG-1456): the opening line says when a drawing holds another drawing's CE data.** Verdict: GO (2026-11-13 06:57); reviewed head 5bde761b, GitHub head 26f110fa: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 2, the core ribbon

4. **Pull request 2038: Two tabs, CE Drainage and CE Design, with only the core buttons, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head 8da2ec4b, same on GitHub. Evidence: None (the ribbon not seen at all, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 3, same settings for everyone

5. **Pull request 2043: The office setup file, the list of what would change, the kept old file, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head a57b9e7e, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 4, Civil safety fixes

6. **Pull request 2039: Pit Schedule says which pits it left out (BUG-1274).** Verdict: GO (2026-11-13 01:28); reviewed head fd9bcce5, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
7. **Pull request 2042: Unsaved-work reminder and backup copies, Civil (BUG-1276).** Verdict: GO (2026-11-13 02:17); reviewed head 5f44223c, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
8. **Pull request 2052: PIT places a pit with a blank cover level and warns (BUG-1042).** Verdict: GO (2026-11-13 05:43); reviewed head 6b1865f6, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
9. **Pull request 2053: A guard that CD runs no record update before its first question (tests only).** Verdict: FIX FIRST (2026-11-13 03:14); reviewed head 9ffbeccb, same on GitHub. Evidence: None. Owed: fix the review list, then the robot on copies.
10. **Pull request 2055: Esc at the first question of CDTG, CDSL or CDWT changes nothing.** Verdict: GO (2026-11-13 05:10); reviewed head 0627df45, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
11. **Pull request 2056: Edit Pipe refuses locked layers and Xrefs before saving.** Verdict: GO (2026-11-13 05:43); reviewed head 40e891f0, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
12. **Pull request 2057: Esc cancels instead of skipping in CDWT and CDAGI (BUG-1289).** Verdict: GO (2026-11-13 04:12); reviewed head 311147d8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
13. **Pull request 2059: CD uses the "continues to another plan?" answer and reports missing parts (BUG-1281, 1282).** Verdict: GO (2026-11-13 05:43); reviewed head 0218bca8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
14. **Pull request 2060: CDMA moves only CE's flow arrows, and says so truthfully (BUG-1283, 1284).** Verdict: GO (2026-11-13 04:12); reviewed head d761ccd6, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
15. **Pull request 2061: CDLPD searches the right distance in a metre drawing.** Verdict: GO (2026-11-13 05:10); reviewed head 7386e906, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
16. **Pull request 2062: Start-up checks (read-only, Paper Space, REFEDIT, Structural) on eight drawing-changing tools (BUG-1286).** Verdict: GO (2026-11-13 06:20); reviewed head 620fe976, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
17. **Pull request 2063: Raingarden and AGI close distances in the drawing's units (BUG-1313).** Verdict: GO (2026-11-13 05:10); reviewed head 0c88fe55, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
18. **Pull request 2064: A cancelled command writes nothing to CE's record (the BUG-1456 cure is no longer here; it is 2073).** Verdict: GO (2026-11-13 06:58); reviewed head 9d44a9c0, same on GitHub. Evidence: None for this change. Owed: the core-console checks first (CEPROOFTRUSTCANCEL, CEPROOFTRUSTESC), then the robot on copies with the switch on and off (re-reviewed GO at 06:58; its four earlier items answered).
19. **Pull request 2065: CDRUNSOLVE preview says what Apply really writes (BUG-1356).** Verdict: GO (2026-11-13 05:10); reviewed head cb133d67, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
20. **Pull request 2066: The read-only check flags a pit or pipe with a blank link (BUG-1339).** Verdict: GO (2026-11-13 05:10); reviewed head 1ff10de2, GitHub head d846f1ed: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
21. **Pull request 2067: Moving the LPD takes the LPD tag off the earlier pipe end (BUG-1300).** Verdict: GO (2026-11-13 05:43); reviewed head 2d825913, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
22. **Pull request 2073: Each drawing keeps its own CE record: Help, Settings or any tool can no longer write one job into another (BUG-1456 cure, no switch).** Verdict: GO (2026-11-13 05:53); reviewed head 1a28c3b3, same on GitHub. Evidence: The fault it cures was seen on the installed build, 6 times in 11 tries; a saved mixed-up drawing reopens with no warning and its Pit Schedule lists the other job's pits; one U straight after Help restores the drawing's own record (EVIDENCE_CROSS_DRAWING.md, parts 1 and 2). The cure itself has never run in AutoCAD. Owed: the core-console check first (CEPROOFCROSSDRAWING, step 1 in PENDING_TESTS.md), then the robot on copies; for the controller: a tool that changes the record in a drawing it never attached still changes the other drawing's record in memory.
23. **Pull request 2075: CDAGI's grade check is right in metre drawings.** Verdict: GO (2026-11-13 06:59); reviewed head 3960801a, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
24. **Pull request 2076: A guard that a cancelled CD writes nothing, on 2064's rule (tests only, built on 2064).** Verdict: GO (2026-11-13 06:59); reviewed head 0e08cc1f, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
25. **Pull request 2081: Move and Rotate and Copy and Rotate on AutoCAD 2027 say in plain words what they cannot move (BUG-1334).** Verdict: GO (2026-11-13 07:29); reviewed head c78016cf, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
26. **Pull request 2082: CDWT by its window keeps the library tank's make, size and lid (BUG-1316).** Verdict: FIX FIRST (2026-11-13 07:24); reviewed head d2bf2395, same on GitHub. Evidence: None. Owed: fix the review list, then the robot on copies.
27. **Pull request 2083: Follow-up to the job mix-up (BUG-1456): a change to CE's record is refused when the record belongs to another drawing.** Verdict: not reviewed; GitHub head 522e5502, not reviewed yet. Evidence: None. Owed: a review first.
28. **Pull request 2084: CDSOURCE never gives out a number twice (BUG-1318).** Verdict: not reviewed; GitHub head 7cfb9b69, not reviewed yet. Evidence: None. Owed: a review first.

## Step 4, Structural safety fixes (card TRUST-04 and the new Structural faults)

29. **Pull request 2044: Bracing schedule tables big enough for every brace (BUG-497).** Verdict: GO (2026-11-13 00:06); reviewed head 87c29f01, same on GitHub. Evidence: None (no Structural branch could be shown headless, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.
30. **Pull request 2046: Refreshing a schedule drops erased braces and piers (BUG-498).** Verdict: GO (2026-11-13 00:57); reviewed head 49f30cf2, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
31. **Pull request 2047: Roof trusses (BT1) left out of wall bracing totals until you answer (BUG-499).** Verdict: GO (2026-11-13 06:21); reviewed head f6b2ea12, same on GitHub. Evidence: None. Owed: the left-out truss count is carried in the totals but shown in no window yet: it must be shown on screen before you are asked; then the robot on copies.
32. **Pull request 2048: Unsaved-work reminder and backup copies, Structural (BUG-1276).** Verdict: GO (2026-11-13 05:43); reviewed head 4370d7b7, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
33. **Pull request 2068: The A/B switch draws the new brace before erasing the old one, so a failed switch keeps the brace (BUG-1362).** Verdict: GO (2026-11-13 05:43); reviewed head 9c457445, GitHub head e22522d3: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
34. **Pull request 2069: Beam tools name the layer that stopped them instead of "internal problem" (BUG-1365).** Verdict: GO (2026-11-13 05:43); reviewed head 44e1ac66, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
35. **Pull request 2070: A schedule size a support block cannot show is no longer drawn as a different size (BUG-1363).** Verdict: GO (2026-11-13 06:20); reviewed head db23f026, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
36. **Pull request 2071: The bracing table sync writes only the cells you edited (BUG-1361).** Verdict: GO (2026-11-13 07:03); reviewed head 514f8334, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
37. **Pull request 2072: Typing B over A in the bracing table is refused with a plain line (BUG-1435; built on 2071).** Verdict: GO (2026-11-13 06:19); reviewed head b3986ade, GitHub head 0f7ca816: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies together with 2071 (2071 re-reviewed GO at 07:03).
38. **Pull request 2074: CLEAN skips objects on locked layers and says so (BUG-1439, 1442, 1447).** Verdict: FIX FIRST (2026-11-13 06:19); reviewed head 42610102, GitHub head a38626fa: moved since review, its FIX FIRST list not yet re-confirmed. Evidence: None. Owed: fix the review list, then the robot on copies.
39. **Pull request 2077: BDL stops with a plain line in a metre, centimetre or inch drawing (BUG-1364).** Verdict: GO (2026-11-13 07:00); reviewed head 35ec2928, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
40. **Pull request 2079: BSET, BSETLIST and BSETRESET report failures truthfully; BSETRESET asks first (BUG-1400, 1401, 1403).** Verdict: GO (2026-11-13 07:00); reviewed head c7b5902f, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
41. **Pull request 2080: The bracing panel says what the count left out and counted (BUG-1369, 1370).** Verdict: GO (2026-11-13 07:33); reviewed head 159f554f, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 5, record changes made visible

42. **Pull request 2045: The read-only tools stop changing CE's record; every other change prints one line.** Verdict: GO (2026-11-13 03:45); reviewed head d0cf644c, same on GitHub. Evidence: Seen in the core console: CDGRAPH and CDDIAG leave the record identical, CDGRAPH counts 49 not 50 (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 6, Unknown instead of made-up values

43. **Pull request 2049: No more made-up "100 dia UPVC", lid class or pit numbers, switch off.** Verdict: GO (2026-11-13 02:17); reviewed head e7b9ccdc, GitHub head 98d81717: moved since review, GO not yet re-confirmed. Evidence: Proof check TRUST-UNKNOWN-01 passes in the core console (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 7, the LPD as the start point

44. **Pull request 2058: The LPD confirmed once and stored; tools start from it.** Verdict: GO (2026-11-13 05:10); reviewed head 772b221d, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 8, Check this drawing, first slice

45. **Pull request 2051: A read-only list of Sure, Proposed and Unknown (typed CDCHECKDRAWING), switch off.** Verdict: GO (2026-11-13 06:21); reviewed head b9bed2e8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## The robot's own proof checks

46. **Pull request 2050: Headless checks that prove steps 1, 5 and 6 change nothing.** Verdict: GO (2026-11-13 03:45); reviewed head 03af5393, same on GitHub. Evidence: All four checks pass in the core console, each with a faulty twin that fails (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Structural step S1, the cut-down tab

47. **Pull request 2054: One Structural tab with the core tools in roof-down order, switch off.** Verdict: GO (2026-11-13 04:14); reviewed head 10a50084, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

---

## Where these come from

1. **The list and the GitHub heads:** `gh pr list --state open --draft` on the plugin repository at 2026-11-13 07:26, branches containing "trust" or "bug-1456".
2. **Verdicts, times and reviewed heads:** the latest line per pull request in `areas\trust-run\trust-review.md`, including "re-reviewed at" heads and the 06:21 re-read of 2038, 2043, 2047 and 2051 (GO holds at their new heads).
3. **What each row owes beyond the robot:** the review files in `areas\trust-run\reviews\` and `reviews\status-board-check.md`.
4. **Evidence:** `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_READER.md`, `EVIDENCE_CROSS_DRAWING.md`, `EVIDENCE_STALE_BUGS.md`. Fixes seen on the installed build (BUG-650, BUG-968, BUG-290) are not trial changes; they are on the morning page.
5. **Plain names and plan steps:** this lane, from the pull request titles and the review lines.
