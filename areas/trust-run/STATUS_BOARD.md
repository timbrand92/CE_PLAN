# Trust run status board

**Rebuilt 2026-11-14 18:32 PC clock by lane trust-struc-mgr-plan, once a day at 6:00pm under Tim's rule of Sat 14 Nov, "Prove, don't draft". The ten tools are Tim's own, named Sat 14 Nov 00:28 ("Yes, use that ten"), in `areas\trust-run\QUEUES.md`. Accepted means a robot PASS plus a Codex PASS in real AutoCAD on the installed build (Tim's "yes", 14 Nov about 16:05). Counted from GitHub and the files named at the end; never estimated.**

---

# Tools accepted on Tim's PC: 0 of 10

# Tools in a colleague's hands: 0

**On Tim's PC now:** Civil 3.0.90.3, Structural 1.0.126.1, Manager 1.1.89 (installed 14 Nov 14:15). To put back Friday's Civil 3.0.90.2 and Structural 1.0.126, with AutoCAD closed: `C:\CE_WORK\scratch\trust_install\restore_batch14.ps1`. **Faults accepted:** 1, BUG-968 (the Renumber crash, tool 6), which is not a whole tool.

---

## The ten tools, in order

1. **PIT (place a pit).**
   1. **Built:** as a draft only, not in an install package (2052, blank cover level, found by its title).
   2. **Seen in AutoCAD:** the PIT window opened only as part of the smoke check on Civil 3.0.90.3, 14 Nov, where it behaved as on the build before (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, detail 3.3); no fix for it has been seen.
   3. **Installed:** only the build that was there before; no fix for it is installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2052: GO (2026-11-13 05:43); reviewed head 6b1865f6, same on GitHub.
   6. **Still owed:** QUEUES.md names no fault or fix for it yet; it waits its turn in the order.
2. **CD (draw a pipe).**
   1. **Built:** as a draft only, not in an install package (found by their titles; 2053 and 2076 are tests only).
   2. **Seen in AutoCAD:** a pipe was drawn only as part of the smoke check on Civil 3.0.90.3, 14 Nov, where it behaved as on the build before (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, detail 3.3); no fix for it has been seen; a drawn pipe was still in CE's record after save and reopen.
   3. **Installed:** only the build that was there before; no fix for it is installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2059: GO (2026-11-13 05:43); reviewed head 0218bca8, same on GitHub; 2053: FIX FIRST (2026-11-13 03:14); reviewed head 9ffbeccb, same on GitHub; 2076: GO (2026-11-13 06:59); reviewed head 0e08cc1f, GitHub head f326cc9f: moved since review, GO not yet re-confirmed.
   6. **Still owed:** QUEUES.md names no fault or fix for it yet; it waits its turn in the order.
3. **CDLPD (legal point of discharge): a plain line taken as the LPD pipe (BUG-1298).**
   1. **Built:** yes, in Civil 3.0.90.3 (pull request 2099 at `9c3f088e`).
   2. **Seen in AutoCAD:** by Codex only, 14 Nov 16:15 to 16:30: a plain polyline on layer 0 is refused with "That line is not a CE pipe ... Nothing was changed"; a CE pipe is still taken and survives save and reopen. The robot could not click the line at that question, so there is no robot PASS (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, CDLPD Codex look).
   3. **Installed:** yes, Civil 3.0.90.3 on your PC since 14 Nov 14:15.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2099: BATCH-READY (2026-11-14 01:22); reviewed head 9c3f088e, same on GitHub; 2061: GO (2026-11-13 05:10); reviewed head 7386e906, same on GitHub; 2067: GO (2026-11-13 05:43); reviewed head 2d825913, same on GitHub; 2101: not reviewed; GitHub head dc5b17ea, not reviewed yet.
   6. **Still owed:** BUG-1298 stays open: a robot PASS beside the Codex PASS, or your ruling on whether a Codex PASS alone counts where the robot cannot pick (waiting on you, controller check 18:21). 2061, 2067 and 2101 are other CDLPD drafts, not installed.
4. **CDEDIT (edit a pit or pipe): changes CE's record on Cancel and makes up values.**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** the fault yes, in AutoCAD on copies (`areas\TRUST_PROBES_13NOV.md`); the fixes no. Edit then Esc only as part of the smoke check on Civil 3.0.90.3, 14 Nov, where it behaved as on the build before (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, detail 3.3); no fix for it has been seen.
   3. **Installed:** no fix installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2064: GO (2026-11-13 11:50); reviewed head dde7825e, same on GitHub; 2049: GO (2026-11-13 03:45); reviewed head 98d81717, same on GitHub; 2056: GO (2026-11-13 05:43); reviewed head 40e891f0, same on GitHub.
   6. **Still owed:** the robot on copies with each draft (2056, Edit Pipe and locked layers, found by its title).
5. **CDRUNSOLVE (solve inverts down a run): the wrong pipe followed at a split (BUG-1355), and no levels written.**
   1. **Built:** the split question yes, in Civil 3.0.90.3 (pull request 2092 at `d686e787`). Reading each pipe's design flow (Q) from Edit Pipe: built on 2092 at `382999f5` only, not installed; core console PASS (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, next batch candidate).
   2. **Seen in AutoCAD:** the split question yes: the robot, 14 Nov 15:16 to 15:37, A, B, Enter and Esc each behaved as designed, with and without an LPD, record unchanged. Codex saw the same but its screenshots were stale, so no Codex PASS. Levels written: no, because on this build every pit has a design flow of 0.
   3. **Installed:** the split question yes, Civil 3.0.90.3 since 14 Nov 14:15; the flow reading no.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2092: BATCH-READY (2026-11-14 01:22); reviewed head d686e787, GitHub head 382999f5: moved since review, BATCH-READY not yet re-confirmed; 2065: GO (2026-11-13 05:10); reviewed head cb133d67, same on GitHub.
   6. **Still owed:** your yes for a next install batch; your answer on where Q comes from (reading Q from Edit Pipe is the controller's DRAFT default, not your answer); 2092 re-reviewed at its new head; then the robot and Codex on a real run that writes levels. 2065 (the preview says what Apply writes) is not installed.
6. **CDRENUMBER: AutoCAD closing when two pipes run opposite ways (BUG-968).**
   1. **Built:** yes, already in your installed Civil.
   2. **Seen in AutoCAD:** yes: Codex (screenshot) and the robot (log), 14 Nov 17:44 to 17:59, on Civil 3.0.90.3: AutoCAD stayed open and "Renumber cancelled - nothing changed." (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, CDRENUMBER).
   3. **Installed:** yes, part of Civil 3.0.90.3.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2093: not reviewed; GitHub head d0806ac9, not reviewed yet.
   6. **Still owed:** the crash fault is accepted: BUG-968 "FIXED (Codex-accepted, Civil 3.0.90.3, 14 Nov 2026)", the first fault accepted under your 16:05 "yes". The tool is not: the plain message naming the two opposite pipes was not shown, and applying a renumber on that drawing was not tried (controller note, 18:25, in `BUG_CARPARK.md`). 2093 (names pits not joined to the outlet) is not installed.
7. **PITSCHEDULE: plastic pits left out (BUG-1274) and Export CSV with the file open (BUG-1342).**
   1. **Built:** as a draft only, not in an install package.
   2. **Seen in AutoCAD:** the fixes no; BUG-1274 was found on a real council-issue drawing (4 Nov). The window opened and closed only as part of the smoke check on Civil 3.0.90.3, 14 Nov, where it behaved as on the build before (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, detail 3.3); no fix for it has been seen.
   3. **Installed:** no fix installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2039: GO (2026-11-13 01:28); reviewed head fd9bcce5, same on GitHub; 2107: GO (2026-11-13 23:53); reviewed head 320dcdcb, GitHub head 9f8a73e4: moved since review, GO not yet re-confirmed.
   6. **Still owed:** the robot on copies.
8. **CDRULES with CDCALC (check against the rulebook, with calculations).**
   1. **Built:** as a draft only, not in an install package (2087, CDRULES keeps only its newest runs, found by its title).
   2. **Seen in AutoCAD:** no.
   3. **Installed:** no fix installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2087: not reviewed; GitHub head 9891fbd8, not reviewed yet.
   6. **Still owed:** QUEUES.md names no fault or fix for it yet; it waits its turn in the order.
9. **CDCHECKCURRENT (check this drawing, as the status line).**
   1. **Built:** as a draft only, not in an install package (2066, a blank link flagged, found by its title).
   2. **Seen in AutoCAD:** it ran only as part of the smoke check on Civil 3.0.90.3, 14 Nov, where it behaved as on the build before (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, detail 3.3); no fix for it has been seen.
   3. **Installed:** no fix installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2066: GO (2026-11-13 07:03); reviewed head d846f1ed, same on GitHub.
   6. **Still owed:** QUEUES.md names no fault or fix for it yet; it waits its turn in the order.
10. **MR (move and rotate).**
   1. **Built:** as a draft only, not in an install package (found by their titles).
   2. **Seen in AutoCAD:** no; your words of 5 Nov were "so far cr/mr work but not on all objects".
   3. **Installed:** no fix installed.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2081: GO (2026-11-13 07:25); reviewed head c78016cf, GitHub head ac12e9b9: moved since review, GO not yet re-confirmed; 2062: GO (2026-11-13 06:20); reviewed head 620fe976, same on GitHub.
   6. **Still owed:** QUEUES.md names no fault or fix for it yet; it waits its turn in the order.

## Safety fixes beside the ten (first, because they can lose work)

1. **Two jobs mixed up: Help and Settings writing one job into another (BUG-1456).**
   1. **Built:** yes, 2073 and 2083 in Civil 3.0.90.2 and again in 3.0.90.3.
   2. **Seen in AutoCAD:** the robot: 20 of 20 on 3.0.90.2 (13 Nov) and 20 of 20 again on 3.0.90.3 (14 Nov). Codex, 14 Nov 16:34 to 17:05, saw no mixing in two runs, but four steps are NOT TESTED because it cannot screenshot its own readings (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`).
   3. **Installed:** yes, Civil 3.0.90.3.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2073: GO (2026-11-13 05:53); reviewed head 1a28c3b3, same on GitHub; 2083: GO (2026-11-13 07:32); reviewed head 522e5502, GitHub head 8a6decef: moved since review, GO not yet re-confirmed; 2078: GO (2026-11-13 07:37); reviewed head e1bdc16e, same on GitHub; 2089: FIX FIRST (2026-11-13 11:50); reviewed head e938d0d4, GitHub head 7707d158: moved since review, its FIX FIRST list not yet re-confirmed; 2090: GO (2026-11-13 11:50); reviewed head 39e489e9, GitHub head 2e604481: moved since review, GO not yet re-confirmed; 2100: FIX FIRST (2026-11-13 17:46); reviewed head 364ccc4e, GitHub head 4a4d7c33: moved since review, its FIX FIRST list not yet re-confirmed.
   6. **Still owed:** the controller's ruling on whether a logged reading counts as Codex evidence. The later doors 2078, 2089, 2090 and 2100 are not installed.
2. **CLEAN and FASTSAVE saving over a template (BUG-1457, Structural).**
   1. **Built:** yes, in Structural 1.0.126.1 (pull request 2094 at `2205dfde`).
   2. **Seen in AutoCAD:** the robot, 14 Nov 15:45: 5 of 5 on template copies (never-saved refused, template opened left unsaved, saved drawing cleaned and saved). Codex saw the saved-drawing case twice but could not reach the never-saved case: the driver refuses NEW (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`).
   3. **Installed:** yes, Structural 1.0.126.1 on your PC since 14 Nov 14:15.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2094: BATCH-READY (2026-11-14 01:38); reviewed head 2205dfde, same on GitHub.
   6. **Still owed:** a way for Codex to reach a never-saved drawing (the driver allowed NEW from a named template copy); your choice on a template opened on purpose (built: cleaned, not saved).

---

# Parked, untouched

Under Tim's rule these stay as drafts; nothing is closed or deleted, and a draft comes back only when its tool comes up.

1. **Parked drafts:** 46 of the 73 open on GitHub (pull requests 2038 to 2110). None merged, none installed.
2. **Their latest review:** 32 GO, 1 FIX FIRST, 13 not reviewed.
3. **Moved on GitHub since their last review:** 6.

## Step 0, the read-only reader

1. **Pull request 2040: Reads what each drawn object is (pit, pipe, downpipe, tank, old palette blocks, old LISP text).** Verdict: GO (2026-11-13 07:03); reviewed head ebf7a21a, same on GitHub. Evidence: Run on six copies: the drawing's change counter and the files stayed the same, and each reading came out the same twice; CE's stored record was NOT compared before and after (EVIDENCE_READER.md). Owed: one small fix (a copy holding only an LPD turns "no CE record or unreadable" into "format not stated") and one caution (the 2500 mm pipe-end level reach was fitted to a made-up drawing whose layout was a guess); then the robot on copies.

## Step 1, the opening line

2. **Pull request 2041: One line when a Civil drawing opens: "all linked" or "needs checking".** Verdict: GO (2026-11-13 00:59); reviewed head 31f426ab, same on GitHub. Evidence: Counting and the no-write rule pass in the core console (proof check TRUST-OPEN-01, EVIDENCE_BRANCHES.md); the line itself on a real drawing opening not seen. Owed: three case-file disagreements for the controller to settle before the robot runs those cases (O18, O20, the word "record"); a "-" pipe end counts as linked in step 1 but "no owner" in step 5; then the robot on copies.

## Step 2, the core ribbon

3. **Pull request 2038: Two tabs, CE Drainage and CE Design, with only the core buttons, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head 8da2ec4b, same on GitHub. Evidence: None (the ribbon not seen at all, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 3, same settings for everyone

4. **Pull request 2043: The office setup file, the list of what would change, the kept old file, switch off.** Verdict: GO (2026-11-13 06:21); reviewed head a57b9e7e, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 4, Civil safety fixes

5. **Pull request 2042: Unsaved-work reminder and backup copies, Civil (BUG-1276).** Verdict: GO (2026-11-13 02:17); reviewed head 5f44223c, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
6. **Pull request 2055: Esc at the first question of CDTG, CDSL or CDWT changes nothing.** Verdict: GO (2026-11-13 05:10); reviewed head 0627df45, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
7. **Pull request 2057: Esc cancels instead of skipping in CDWT and CDAGI (BUG-1289).** Verdict: GO (2026-11-13 04:12); reviewed head 311147d8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
8. **Pull request 2060: CDMA moves only CE's flow arrows, and says so truthfully (BUG-1283, 1284).** Verdict: GO (2026-11-13 04:12); reviewed head d761ccd6, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
9. **Pull request 2063: Raingarden and AGI close distances in the drawing's units (BUG-1313).** Verdict: GO (2026-11-13 05:10); reviewed head 0c88fe55, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
10. **Pull request 2075: CDAGI's grade check is right in metre drawings.** Verdict: GO (2026-11-13 06:59); reviewed head 3960801a, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
11. **Pull request 2082: CDWT by its window keeps the library tank's make, size and lid (BUG-1316).** Verdict: GO (2026-11-13 08:53); reviewed head 570743f3, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
12. **Pull request 2084: CDSOURCE never gives out a number twice (BUG-1318).** Verdict: GO (2026-11-13 07:34); reviewed head 7cfb9b69, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
13. **Pull request 2085: A CDTAG retag never leaves the old tag showing on the label (BUG-1320).** Verdict: GO (2026-11-13 11:50); reviewed head 9eb5f87b, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
14. **Pull request 2086: A CDTAG retag keeps a connection point you nudged (BUG-1321).** Verdict: GO (2026-11-13 08:53); reviewed head 38ac37ce, GitHub head 12e27bc1: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
15. **Pull request 2088: Report a problem (CDFEEDBACK) keeps your typed report when the save fails (BUG-1346).** Verdict: not reviewed; GitHub head 20e49aeb, not reviewed yet. Evidence: None. Owed: a review first.
16. **Pull request 2091: A CDFIXTAGS rename keeps a source's connection point (built on 2086).** Verdict: not reviewed; GitHub head ac613e26, not reviewed yet. Evidence: None. Owed: a review first.
17. **Pull request 2103: CDWT's command line says when tanks or plan blocks are left out (BUG-1317).** Verdict: not reviewed; GitHub head fda04e40, not reviewed yet. Evidence: None. Owed: a review first.
18. **Pull request 2110: CDRG names a locked layer and says so before its questions (BUG-1315).** Verdict: not reviewed; GitHub head 54dbaa2c, not reviewed yet. Evidence: None. Owed: a review first.

## Step 4, Structural safety fixes (card TRUST-04 and the new Structural faults)

19. **Pull request 2044: Bracing schedule tables big enough for every brace (BUG-497).** Verdict: GO (2026-11-13 00:06); reviewed head 87c29f01, same on GitHub. Evidence: None (no Structural branch could be shown headless, EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.
20. **Pull request 2046: Refreshing a schedule drops erased braces and piers (BUG-498).** Verdict: GO (2026-11-13 00:57); reviewed head 49f30cf2, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
21. **Pull request 2047: Roof trusses (BT1) left out of wall bracing totals until you answer (BUG-499).** Verdict: GO (2026-11-13 06:21); reviewed head f6b2ea12, same on GitHub. Evidence: None. Owed: the left-out truss count is carried in the totals but shown in no window yet: it must be shown on screen before you are asked (that line belongs in the bracing panel note of pull request 2080; once both land, a BT truss on a hidden layer would be called "counted" by 2080 while 2047 leaves it out); then the robot on copies.
22. **Pull request 2048: Unsaved-work reminder and backup copies, Structural (BUG-1276).** Verdict: GO (2026-11-13 05:43); reviewed head 4370d7b7, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
23. **Pull request 2068: The A/B switch draws the new brace before erasing the old one, so a failed switch keeps the brace (BUG-1362).** Verdict: GO (2026-11-13 07:03); reviewed head e22522d3, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
24. **Pull request 2069: Beam tools name the layer that stopped them instead of "internal problem" (BUG-1365).** Verdict: GO (2026-11-13 05:43); reviewed head 44e1ac66, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
25. **Pull request 2070: A schedule size a support block cannot show is no longer drawn as a different size (BUG-1363).** Verdict: GO (2026-11-13 06:20); reviewed head db23f026, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
26. **Pull request 2071: The bracing table sync writes only the cells you edited (BUG-1361).** Verdict: GO (2026-11-13 07:03); reviewed head 514f8334, GitHub head 7c50f58c: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
27. **Pull request 2072: Typing B over A in the bracing table is refused with a plain line (BUG-1435; built on 2071).** Verdict: GO (2026-11-13 07:37); reviewed head 0f7ca816, GitHub head 273ae0dc: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies together with 2071 (2071 re-reviewed GO at 07:03).
28. **Pull request 2074: CLEAN skips objects on locked layers and says so (BUG-1439, 1442, 1447).** Verdict: GO (2026-11-13 07:37); reviewed head a38626fa, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
29. **Pull request 2077: BDL stops with a plain line in a metre, centimetre or inch drawing (BUG-1364).** Verdict: GO (2026-11-13 07:00); reviewed head 35ec2928, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
30. **Pull request 2079: BSET, BSETLIST and BSETRESET report failures truthfully; BSETRESET asks first (BUG-1400, 1401, 1403).** Verdict: GO (2026-11-13 07:00); reviewed head c7b5902f, GitHub head 30280ba5: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
31. **Pull request 2080: The bracing panel says what the count left out and counted (BUG-1369, 1370).** Verdict: GO (2026-11-13 07:26); reviewed head 159f554f, GitHub head 8db33084: moved since review, GO not yet re-confirmed. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.
32. **Pull request 2095: BDL stops first on a layout tab or in REFEDIT, and says what is drawn when it ends early (BUG-1396, 1397).** Verdict: not reviewed; GitHub head 3a5dc194, not reviewed yet. Evidence: None. Owed: a review first.
33. **Pull request 2096: A support is not said to be linked to a beam when the link was not saved (BUG-1414).** Verdict: FIX FIRST (2026-11-13 23:53); reviewed head e4369378, GitHub head bcec5e2b: moved since review, its FIX FIRST list not yet re-confirmed. Evidence: None. Owed: fix the review list, then the robot on copies.
34. **Pull request 2097: P1's purlin lap question names the lap; no figure changed (BUG-1371).** Verdict: not reviewed; GitHub head 4e2753f4, not reviewed yet. Evidence: None. Owed: a review first.
35. **Pull request 2098: R1, P1 and FJ1 say when the depth picks were too close; no figure changed (BUG-1372).** Verdict: not reviewed; GitHub head 2fc8c210, not reviewed yet. Evidence: None. Owed: a review first.
36. **Pull request 2102: Four Structural Help entries say what the tools really do; words only (BUG-1405, 1395, 1448, 1382).** Verdict: not reviewed; GitHub head 38c67880, not reviewed yet. Evidence: None. Owed: a review first.
37. **Pull request 2104: R1, P1 and FJ1 say when they straighten the bay and slide the marker; no figure changed (BUG-1373, 1374).** Verdict: not reviewed; GitHub head 20d9c4a3, not reviewed yet. Evidence: None. Owed: a review first.
38. **Pull request 2105: AB, BB and BT1 say when they set a brace square and add layer 25CONT; no figure changed (BUG-1380, 1381).** Verdict: not reviewed; GitHub head c12457ad, not reviewed yet. Evidence: None. Owed: a review first.
39. **Pull request 2106: No apology line before the support angle question when the rotation preview is off; words only (BUG-1421).** Verdict: not reviewed; GitHub head 3bf64398, not reviewed yet. Evidence: None. Owed: a review first.
40. **Pull request 2108: The schedule commands stop first when they should and say when a table is not CE's (BUG-1424, 1430, 1438).** Verdict: not reviewed; GitHub head b3df6ba4, not reviewed yet. Evidence: None. Owed: a review first.
41. **Pull request 2109: The Help for the three schedule commands says what each asks and changes; words only (BUG-1429).** Verdict: not reviewed; GitHub head 2de99b5f, not reviewed yet. Evidence: None. Owed: a review first.

## Step 5, record changes made visible

42. **Pull request 2045: The read-only tools stop changing CE's record; every other change prints one line.** Verdict: GO (2026-11-13 03:45); reviewed head d0cf644c, same on GitHub. Evidence: Seen in the core console: CDGRAPH and CDDIAG leave the record identical, CDGRAPH counts 49 not 50 (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 7, the LPD as the start point

43. **Pull request 2058: The LPD confirmed once and stored; tools start from it.** Verdict: GO (2026-11-13 05:10); reviewed head 772b221d, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Step 8, Check this drawing, first slice

44. **Pull request 2051: A read-only list of Sure, Proposed and Unknown (typed CDCHECKDRAWING), switch off.** Verdict: GO (2026-11-13 06:21); reviewed head b9bed2e8, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## The robot's own proof checks

45. **Pull request 2050: Headless checks that prove steps 1, 5 and 6 change nothing.** Verdict: GO (2026-11-13 03:45); reviewed head 03af5393, same on GitHub. Evidence: All four checks pass in the core console, each with a faulty twin that fails (EVIDENCE_BRANCHES.md). Owed: the robot on copies, then a Codex look where something is seen, then your trial.

## Structural step S1, the cut-down tab

46. **Pull request 2054: One Structural tab with the core tools in roof-down order, switch off.** Verdict: GO (2026-11-13 04:14); reviewed head 10a50084, same on GitHub. Evidence: None. Owed: the robot on copies, then a Codex look where something is seen, then your trial.

---

## Where these come from

1. **The list and the GitHub heads:** `gh pr list --state open --draft` on the plugin repository at 2026-11-14 18:32, branches containing "trust" or "bug-1456".
2. **Verdicts, times and reviewed heads:** the latest line per pull request in `areas\trust-run\trust-review.md`, including "re-reviewed at" heads and the 06:21 re-read of 2038, 2043, 2047 and 2051 (GO holds at their new heads).
3. **What each row owes beyond the robot:** the review files in `areas\trust-run\reviews\` and `reviews\status-board-check.md`.
4. **Evidence:** `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_READER.md`, `EVIDENCE_CROSS_DRAWING.md`, `EVIDENCE_STALE_BUGS.md`. Fixes seen on the installed build (BUG-650, BUG-968, BUG-290) are not trial changes; they are on the morning page.
5. **Plain names and plan steps:** this lane, from the pull request titles and the review lines.
6. **The ten tools and the rule:** `areas\trust-run\QUEUES.md` (Tim's ten, his acceptance answer, the CDRUNSOLVE flow note) and `areas\TRUST_AUTONOMOUS_RUN_12NOV.md`, last sections; what is installed and seen: `areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md` (with `INSTALL_TRIAL_RESULT_13NOV.md` for 3.0.90.2); what is accepted: `BUG_CARPARK.md` (BUG-968 and the controller note of 18:25) and the controller check of 18:21 in `areas\release-v3-colleagues-DESK_LOG.md`. A tool's drafts are those QUEUES.md names, then open drafts whose title names that command (this lane's match by title).
