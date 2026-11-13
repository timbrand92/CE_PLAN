# Trust run status board

**Rebuilt 2026-11-14 00:25 PC clock by lane trust-struc-mgr-plan, once a day at 6:00pm under Tim's rule of Sat 14 Nov, "Prove, don't draft". The ten tools are the controller's DRAFT order in `areas\trust-run\QUEUES.md` (last section) until Tim names his own. Counted from GitHub and the files named at the end; never estimated.**

---

# Tools accepted on Tim's PC: 0 of 10

# Tools in a colleague's hands: 0

---

## The ten tools, in order

1. **Two jobs mixed up: Help and Settings writing one job into another (BUG-1456).**
   1. **Built:** yes, Civil 3.0.90.2 = your 3.0.90 plus pull requests 2073 and 2083 (build commit `5c89ce30`).
   2. **Seen in AutoCAD:** yes: the robot, on scratch copies on your PC, 13 Nov: the seven ways it failed on 3.0.90 each passed twice in two AutoCAD starts (20 of 20); everyday tools, save and reopen work as before. Not tried: erasing a pit, AutoCAD 2022 to 2026.
   3. **Installed:** yes, on your PC since 13 Nov 13:46 (Manager 1.1.89 and Structural 1.0.126 unchanged). To put 3.0.90 back, with AutoCAD closed: `C:\CE_WORK\scratch\trust_install\restore_stateB.ps1`.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2073: GO (2026-11-13 05:53); reviewed head 1a28c3b3, same on GitHub; 2083: GO (2026-11-13 07:32); reviewed head 522e5502, GitHub head 8a6decef: moved since review, GO not yet re-confirmed.
   6. **Still owed:** a Codex look, then your word. The later doors 2078, 2089, 2090 and 2100 are not on your PC and are parked below.
2. **CLEAN and FASTSAVE saving over a template (BUG-1457, Structural).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** the fault yes, on your installed build, on a template copy (your real template untouched); the fix no.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2094: GO (2026-11-13 19:47); reviewed head 7a94d8e8, same on GitHub.
   6. **Still owed:** the review's before-merge items, then the robot on scratch template copies.
3. **CDLPD taking a plain line as the LPD pipe (BUG-1298).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** no; the fault is found by reading the code only.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2099: GO (2026-11-13 22:48); reviewed head c788a0ea, same on GitHub.
   6. **Still owed:** two small fixes from the review, then the robot on copies.
4. **CDRUNSOLVE following the wrong pipe at a branch (BUG-1355).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** no; the fault is found by reading the code only.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2092: FIX FIRST (2026-11-13 22:48); reviewed head 0f496074, same on GitHub.
   6. **Still owed:** the review's four items (with an LPD it never asks for an end pit, so its advice cannot be followed), then the robot on copies.
5. **Edit Pit changing CE's record on Cancel and making up values.**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** the fault yes, in AutoCAD on copies (`areas\TRUST_PROBES_13NOV.md`); the fixes no, only proof checks in the core console.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2064: GO (2026-11-13 11:50); reviewed head dde7825e, same on GitHub; 2049: GO (2026-11-13 03:45); reviewed head 98d81717, same on GitHub.
   6. **Still owed:** the robot on copies with each draft.
6. **Pit Schedule leaving plastic pits out (BUG-1274) and Export CSV with the file open (BUG-1342).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** the fixes no; BUG-1274 was found on a real council-issue drawing (4 Nov), BUG-1342 by reading the code.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2039: GO (2026-11-13 01:28); reviewed head fd9bcce5, same on GitHub; 2107: GO (2026-11-13 23:53); reviewed head 320dcdcb, same on GitHub.
   6. **Still owed:** the robot on copies.
7. **Renumber closing AutoCAD when two pipes run opposite ways (BUG-968).**
   1. **Built:** yes, already in your installed Civil.
   2. **Seen in AutoCAD:** yes: the robot, on copies, on the installed build (`areas\trust-run\EVIDENCE_STALE_BUGS.md`).
   3. **Installed:** yes, part of your installed Civil.
   4. **Accepted:** no.
   5. **Drafts and latest review:** none; the fix is already in the installed build.
   6. **Still owed:** a Codex look, then your word.
8. **Floor waste tool wiping pit inverts on Cancel (BUG-650).**
   1. **Built:** yes, already in your installed Civil.
   2. **Seen in AutoCAD:** yes: the robot, on copies, in two separate AutoCAD sessions (`areas\trust-run\EVIDENCE_STALE_BUGS.md`).
   3. **Installed:** yes, part of your installed Civil.
   4. **Accepted:** no.
   5. **Drafts and latest review:** none; the fix is already in the installed build.
   6. **Still owed:** a Codex look, then your word.
9. **Structural bracing schedule: one row short, keeps erased braces, counts roof trusses as wall bracing (BUG-497, 498, 499).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** no; no Structural draft has been shown in AutoCAD.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2044: GO (2026-11-13 00:06); reviewed head 87c29f01, same on GitHub; 2046: GO (2026-11-13 00:57); reviewed head 49f30cf2, same on GitHub; 2047: GO (2026-11-13 06:21); reviewed head f6b2ea12, same on GitHub.
   6. **Still owed:** for 2047, the left-out truss count shown on screen before you are asked; then the robot on copies.
10. **Structural support saying "linked to nearby beam" when the link was not saved (BUG-1414).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** no; the fault is found by reading the code only.
   3. **Installed:** no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2096: FIX FIRST (2026-11-13 23:53); reviewed head e4369378, same on GitHub.
   6. **Still owed:** the review's three items (its AutoCAD check cannot make the save fail on a beam CE drew), then the robot on copies.

---

# Parked, untouched

Under Tim's rule these stay as drafts; nothing is closed or deleted, and a draft comes back only when its tool comes up.

1. **Parked drafts:** 60 of the 73 open on GitHub (pull requests 2038 to 2110). None merged, none installed.
2. **Their latest review:** 41 GO, 3 FIX FIRST, 16 not reviewed.
3. **Moved on GitHub since their last review:** 9.

## Step 0, the read-only reader

1. **Pull request 2040: Reads what each drawn object is (pit, pipe, downpipe, tank, old palette blocks, old LISP text).** Verdict: GO (2026-11-13 07:03); reviewed head ebf7a21a, same on GitHub. Evidence: Run on six copies: the drawing's change counter and the files stayed the same, and each reading came out the same twice; CE's stored record was NOT compared before and after (EVIDENCE_READER.md). Owed: one small fix (a copy holding only an LPD turns "no CE record or unreadable" into "format not stated") and one caution (the 2500 mm pipe-end level reach was fitted to a made-up drawing whose layout was a guess); then the robot on copies.

## Step 1, the opening line

2. **Pull request 2041: One line when a Civil drawing opens: "all linked" or "needs checking".** Verdict: GO (2026-11-13 00:59); reviewed head 31f426ab, same on GitHub. Evidence: Counting and the no-write rule pass in the core console (proof check TRUST-OPEN-01, EVIDENCE_BRANCHES.md); the line itself on a real drawing opening not seen. Owed: three case-file disagreements for the controller to settle before the robot runs those cases (O18, O20, the word "record"); a "-" pipe end counts as linked in step 1 but "no owner" in step 5; then the robot on copies.
3. **Pull request 2078: Follow-up to the job mix-up (BUG-1456): the opening line says when a drawing holds another drawing's CE data.** Verdict: GO (2026-11-13 07:37); reviewed head e1bdc16e, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 2, the core ribbon

4. **Pull request 2038: Two tabs, CE Drainage and CE Design, with only the core buttons, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head 8da2ec4b, same on GitHub. Evidence: None (the ribbon not seen at all, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 3, same settings for everyone

5. **Pull request 2043: The office setup file, the list of what would change, the kept old file, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head a57b9e7e, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 4, Civil safety fixes

6. **Pull request 2042: Unsaved-work reminder and backup copies, Civil (BUG-1276).** Verdict: GO (2026-11-13 02:17); reviewed head 5f44223c, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
7. **Pull request 2052: PIT places a pit with a blank cover level and warns (BUG-1042).** Verdict: GO (2026-11-13 05:43); reviewed head 6b1865f6, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
8. **Pull request 2053: A guard that CD runs no record update before its first question (tests only).** Verdict: FIX FIRST (2026-11-13 03:14); reviewed head 9ffbeccb, same on GitHub. Evidence: None. Owed: fix the review list, then the robot on copies.
9. **Pull request 2055: Esc at the first question of CDTG, CDSL or CDWT changes nothing.** Verdict: GO (2026-11-13 05:10); reviewed head 0627df45, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
10. **Pull request 2056: Edit Pipe refuses locked layers and Xrefs before saving.** Verdict: GO (2026-11-13 05:43); reviewed head 40e891f0, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
11. **Pull request 2057: Esc cancels instead of skipping in CDWT and CDAGI (BUG-1289).** Verdict: GO (2026-11-13 04:12); reviewed head 311147d8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
12. **Pull request 2059: CD uses the "continues to another plan?" answer and reports missing parts (BUG-1281, 1282).** Verdict: GO (2026-11-13 05:43); reviewed head 0218bca8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
13. **Pull request 2060: CDMA moves only CE's flow arrows, and says so truthfully (BUG-1283, 1284).** Verdict: GO (2026-11-13 04:12); reviewed head d761ccd6, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
14. **Pull request 2061: CDLPD searches the right distance in a metre drawing.** Verdict: GO (2026-11-13 05:10); reviewed head 7386e906, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
15. **Pull request 2062: Start-up checks (read-only, Paper Space, REFEDIT, Structural) on eight drawing-changing tools (BUG-1286).** Verdict: GO (2026-11-13 06:20); reviewed head 620fe976, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
16. **Pull request 2063: Raingarden and AGI close distances in the drawing's units (BUG-1313).** Verdict: GO (2026-11-13 05:10); reviewed head 0c88fe55, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
17. **Pull request 2065: CDRUNSOLVE preview says what Apply really writes (BUG-1356).** Verdict: GO (2026-11-13 05:10); reviewed head cb133d67, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
18. **Pull request 2066: The read-only check flags a pit or pipe with a blank link (BUG-1339).** Verdict: GO (2026-11-13 07:03); reviewed head d846f1ed, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
19. **Pull request 2067: Moving the LPD takes the LPD tag off the earlier pipe end (BUG-1300).** Verdict: GO (2026-11-13 05:43); reviewed head 2d825913, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
20. **Pull request 2075: CDAGI's grade check is right in metre drawings.** Verdict: GO (2026-11-13 06:59); reviewed head 3960801a, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
21. **Pull request 2076: A guard that a cancelled CD writes nothing, on 2064's rule (tests only, built on 2064).** Verdict: GO (2026-11-13 06:59); reviewed head 0e08cc1f, GitHub head f326cc9f: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
22. **Pull request 2081: Move and Rotate and Copy and Rotate on AutoCAD 2027 say in plain words what they cannot move (BUG-1334).** Verdict: GO (2026-11-13 07:25); reviewed head c78016cf, GitHub head ac12e9b9: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
23. **Pull request 2082: CDWT by its window keeps the library tank's make, size and lid (BUG-1316).** Verdict: GO (2026-11-13 08:53); reviewed head 570743f3, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
24. **Pull request 2084: CDSOURCE never gives out a number twice (BUG-1318).** Verdict: GO (2026-11-13 07:34); reviewed head 7cfb9b69, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
25. **Pull request 2085: A CDTAG retag never leaves the old tag showing on the label (BUG-1320).** Verdict: GO (2026-11-13 11:50); reviewed head 9eb5f87b, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
26. **Pull request 2086: A CDTAG retag keeps a connection point you nudged (BUG-1321).** Verdict: GO (2026-11-13 08:53); reviewed head 38ac37ce, GitHub head 12e27bc1: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
27. **Pull request 2087: CDRULES keeps only its newest runs in the drawing (BUG-1358).** Verdict: not reviewed; GitHub head 9a006d78, not reviewed yet. Evidence: None. Owed: a review first.
28. **Pull request 2088: Report a problem (CDFEEDBACK) keeps your typed report when the save fails (BUG-1346).** Verdict: not reviewed; GitHub head 20e49aeb, not reviewed yet. Evidence: None. Owed: a review first.
29. **Pull request 2089: Fourth door on the job mix-up (BUG-1456): a copy of another drawing's record is never written by a tool's own step.** Verdict: FIX FIRST (2026-11-13 11:50); reviewed head e938d0d4, GitHub head a7ceef6e: moved since review, its FIX FIRST list not yet re-confirmed. Evidence: None. Owed: fix the review list, then the robot on copies.
30. **Pull request 2090: Job mix-up follow-up (BUG-1456): when CE refuses a write, it says so on the command line, not only in its log.** Verdict: GO (2026-11-13 11:50); reviewed head 39e489e9, GitHub head 8ecfece7: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
31. **Pull request 2091: A CDFIXTAGS rename keeps a source's connection point (built on 2086).** Verdict: not reviewed; GitHub head ac613e26, not reviewed yet. Evidence: None. Owed: a review first.
32. **Pull request 2093: CDRENUMBER names the pits not joined to the outlet before you say Yes (BUG-1306).** Verdict: not reviewed; GitHub head d0806ac9, not reviewed yet. Evidence: None. Owed: a review first.
33. **Pull request 2100: Job mix-up follow-up (BUG-1456): a guard on every routine outside the record service that saves or edits CE's record.** Verdict: FIX FIRST (2026-11-13 17:46); reviewed head 364ccc4e, same on GitHub. Evidence: None. Owed: fix the review list, then the robot on copies.
34. **Pull request 2101: CDLPD says when no note was drawn and keeps the earlier note linked (BUG-1301).** Verdict: not reviewed; GitHub head dc5b17ea, not reviewed yet. Evidence: None. Owed: a review first.
35. **Pull request 2103: CDWT's command line says when tanks or plan blocks are left out (BUG-1317).** Verdict: not reviewed; GitHub head fda04e40, not reviewed yet. Evidence: None. Owed: a review first.
36. **Pull request 2110: CDRG names a locked layer and says so before its questions (BUG-1315).** Verdict: not reviewed; GitHub head 54dbaa2c, not reviewed yet. Evidence: None. Owed: a review first.

## Step 4, Structural safety fixes (card TRUST-04 and the new Structural faults)

37. **Pull request 2048: Unsaved-work reminder and backup copies, Structural (BUG-1276).** Verdict: GO (2026-11-13 05:43); reviewed head 4370d7b7, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
38. **Pull request 2068: The A/B switch draws the new brace before erasing the old one, so a failed switch keeps the brace (BUG-1362).** Verdict: GO (2026-11-13 07:03); reviewed head e22522d3, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
39. **Pull request 2069: Beam tools name the layer that stopped them instead of "internal problem" (BUG-1365).** Verdict: GO (2026-11-13 05:43); reviewed head 44e1ac66, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
40. **Pull request 2070: A schedule size a support block cannot show is no longer drawn as a different size (BUG-1363).** Verdict: GO (2026-11-13 06:20); reviewed head db23f026, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
41. **Pull request 2071: The bracing table sync writes only the cells you edited (BUG-1361).** Verdict: GO (2026-11-13 07:03); reviewed head 514f8334, GitHub head 7c50f58c: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
42. **Pull request 2072: Typing B over A in the bracing table is refused with a plain line (BUG-1435; built on 2071).** Verdict: GO (2026-11-13 07:37); reviewed head 0f7ca816, GitHub head 273ae0dc: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies together with 2071 (2071 re-reviewed GO at 07:03).
43. **Pull request 2074: CLEAN skips objects on locked layers and says so (BUG-1439, 1442, 1447).** Verdict: GO (2026-11-13 07:37); reviewed head a38626fa, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
44. **Pull request 2077: BDL stops with a plain line in a metre, centimetre or inch drawing (BUG-1364).** Verdict: GO (2026-11-13 07:00); reviewed head 35ec2928, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
45. **Pull request 2079: BSET, BSETLIST and BSETRESET report failures truthfully; BSETRESET asks first (BUG-1400, 1401, 1403).** Verdict: GO (2026-11-13 07:00); reviewed head c7b5902f, GitHub head 30280ba5: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
46. **Pull request 2080: The bracing panel says what the count left out and counted (BUG-1369, 1370).** Verdict: GO (2026-11-13 07:26); reviewed head 159f554f, GitHub head 8db33084: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
47. **Pull request 2095: BDL stops first on a layout tab or in REFEDIT, and says what is drawn when it ends early (BUG-1396, 1397).** Verdict: not reviewed; GitHub head 3a5dc194, not reviewed yet. Evidence: None. Owed: a review first.
48. **Pull request 2097: P1's purlin lap question names the lap; no figure changed (BUG-1371).** Verdict: not reviewed; GitHub head 4e2753f4, not reviewed yet. Evidence: None. Owed: a review first.
49. **Pull request 2098: R1, P1 and FJ1 say when the depth picks were too close; no figure changed (BUG-1372).** Verdict: not reviewed; GitHub head 2fc8c210, not reviewed yet. Evidence: None. Owed: a review first.
50. **Pull request 2102: Four Structural Help entries say what the tools really do; words only (BUG-1405, 1395, 1448, 1382).** Verdict: not reviewed; GitHub head 38c67880, not reviewed yet. Evidence: None. Owed: a review first.
51. **Pull request 2104: R1, P1 and FJ1 say when they straighten the bay and slide the marker; no figure changed (BUG-1373, 1374).** Verdict: not reviewed; GitHub head 20d9c4a3, not reviewed yet. Evidence: None. Owed: a review first.
52. **Pull request 2105: AB, BB and BT1 say when they set a brace square and add layer 25CONT; no figure changed (BUG-1380, 1381).** Verdict: not reviewed; GitHub head c12457ad, not reviewed yet. Evidence: None. Owed: a review first.
53. **Pull request 2106: No apology line before the support angle question when the rotation preview is off; words only (BUG-1421).** Verdict: not reviewed; GitHub head 3bf64398, not reviewed yet. Evidence: None. Owed: a review first.
54. **Pull request 2108: The schedule commands stop first when they should and say when a table is not CE's (BUG-1424, 1430, 1438).** Verdict: not reviewed; GitHub head b3df6ba4, not reviewed yet. Evidence: None. Owed: a review first.
55. **Pull request 2109: The Help for the three schedule commands says what each asks and changes; words only (BUG-1429).** Verdict: not reviewed; GitHub head 2de99b5f, not reviewed yet. Evidence: None. Owed: a review first.

## Step 5, record changes made visible

56. **Pull request 2045: The read-only tools stop changing CE's record; every other change prints one line.** Verdict: GO (2026-11-13 03:45); reviewed head d0cf644c, same on GitHub. Evidence: Seen in the core console: CDGRAPH and CDDIAG leave the record identical, CDGRAPH counts 49 not 50 (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 7, the LPD as the start point

57. **Pull request 2058: The LPD confirmed once and stored; tools start from it.** Verdict: GO (2026-11-13 05:10); reviewed head 772b221d, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 8, Check this drawing, first slice

58. **Pull request 2051: A read-only list of Sure, Proposed and Unknown (typed CDCHECKDRAWING), switch off.** Verdict: GO (2026-11-13 06:21); reviewed head b9bed2e8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## The robot's own proof checks

59. **Pull request 2050: Headless checks that prove steps 1, 5 and 6 change nothing.** Verdict: GO (2026-11-13 03:45); reviewed head 03af5393, same on GitHub. Evidence: All four checks pass in the core console, each with a faulty twin that fails (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Structural step S1, the cut-down tab

60. **Pull request 2054: One Structural tab with the core tools in roof-down order, switch off.** Verdict: GO (2026-11-13 04:14); reviewed head 10a50084, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

---

## Where these come from

1. **The list and the GitHub heads:** `gh pr list --state open --draft` on the plugin repository at 2026-11-14 00:25, branches containing "trust" or "bug-1456".
2. **Verdicts, times and reviewed heads:** the latest line per pull request in `areas\trust-run\trust-review.md`, including "re-reviewed at" heads and the 06:21 re-read of 2038, 2043, 2047 and 2051 (GO holds at their new heads).
3. **What each row owes beyond the robot:** the review files in `areas\trust-run\reviews\` and `reviews\status-board-check.md`.
4. **Evidence:** `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_READER.md`, `EVIDENCE_CROSS_DRAWING.md`, `EVIDENCE_STALE_BUGS.md`. Fixes seen on the installed build (BUG-650, BUG-968, BUG-290) are not trial changes; they are on the morning page.
5. **Plain names and plan steps:** this lane, from the pull request titles and the review lines.
6. **The ten tools and the rule:** `areas\trust-run\QUEUES.md` and `areas\TRUST_AUTONOMOUS_RUN_12NOV.md`, last sections; what is installed: `areas\trust-run\INSTALL_TRIAL_13NOV.md` section 8 and `INSTALL_TRIAL_RESULT_13NOV.md`; evidence for each tool: the files named in its row.
