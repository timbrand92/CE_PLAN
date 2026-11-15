# Trust run status board

**Rebuilt 2026-11-15 18:33 PC clock by lane trust-struc-mgr-plan, once a day at 6:00pm under Tim's rule of Sat 14 Nov, "Prove, don't draft". The ten tools are Tim's own, named Sat 14 Nov 00:28 ("Yes, use that ten"), in `areas\trust-run\QUEUES.md`. Accepted means Codex has seen the tool's whole everyday job pass in real AutoCAD on the installed build (Cancel, Esc, the job, one Undo, save and reopen), checked by the controller (Tim, Sun 15 Nov about 14:37: "codex alone is fine"). Counted from GitHub and the files named at the end; never estimated.**

---

# Tools accepted on Tim's PC: 4 of 10

# Tools in a colleague's hands: 0

**On Tim's PC now:** Civil 3.0.90.11 (trial batch 9, installed Sun 15 Nov 16:03 under the standing trial approval), Structural 1.0.126.1, Manager 1.1.89. To put back Civil 3.0.90.10, with AutoCAD closed: `C:\CE_WORK\scratch\trust_install\restore_batch14i.ps1`. **Accepted so far:** PIT, CD, CDCHECKCURRENT and MR, each on Civil 3.0.90.10. **Faults accepted:** 2, BUG-968 (the Renumber crash) and BUG-1298 (CDLPD taking a plain line).

---

## The ten tools, in order

1. **PIT (place a pit).**
   1. **Built:** the everyday job is in your installed Civil; draft 2052 (blank cover level, found by its title) is not installed.
   2. **Seen in AutoCAD:** yes: robot 5 of 5 and Codex 5 of 5 on Civil 3.0.90.10, 15 Nov (Cancel, Esc, place, one Undo, save and reopen); the controller saw the reopened pit on screen (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 1). On 3.0.90.11 only the smoke check has run.
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** yes.
   5. **Drafts and latest review:** 2052: GO (2026-11-13 05:43); reviewed head 6b1865f6, same on GitHub.
   6. **Still owed:** nothing for the count. Open points: the blank cover level wording (yours), and a plastic pit cannot be numbered in the one-page window (being built to your picture).
2. **CD (draw a pipe).**
   1. **Built:** the everyday job is in your installed Civil. New Pipe on one page (2111, your "build New Pipe") is in 3.0.90.11 behind a switch that is off.
   2. **Seen in AutoCAD:** yes: robot 5 of 5 and Codex 5 of 5 on Civil 3.0.90.10, 15 Nov (Cancel, Esc, draw, one Undo, save and reopen; `areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 2). On 3.0.90.11 with the switch off the robot drew a pipe and one Undo put it back. The one-page window with the switch on: Codex NP16 18:07, Cancel, draw and one Undo PASS, **Esc FAIL** (the page stays open) (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, batch 9).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03 (the one-page window switched off).
   4. **Accepted:** yes.
   5. **Drafts and latest review:** 2111: not reviewed; GitHub head 568f63b1, not reviewed yet; 2059: GO (2026-11-13 05:43); reviewed head 0218bca8, same on GitHub; 2053: FIX FIRST (2026-11-13 03:14); reviewed head 9ffbeccb, same on GitHub; 2076: GO (2026-11-13 06:59); reviewed head 0e08cc1f, GitHub head f326cc9f: moved since review, GO not yet re-confirmed.
   6. **Still owed:** nothing for the count. For the one-page window: the Esc fix (sent to the fix lane for batch 10), then save and reopen with it, and which starting size wins (100 in one run, 225 in another). 2059, 2053 and 2076 are not installed.
3. **CDLPD (legal point of discharge).**
   1. **Built:** yes, the "only a CE pipe" fix (2099 at `28dd045c`) in your installed Civil since 3.0.90.7.
   2. **Seen in AutoCAD:** the fix yes: Codex LPD15 L3 OVERALL PASS with a before-and-after record read on 3.0.90.7, a plain line and a bare pipe-layer line both refused, a CE pipe taken and kept after save and reopen (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, item 5a). The whole everyday job not yet run on 3.0.90.10 or 3.0.90.11.
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2099: BATCH-READY (2026-11-14 01:22); reviewed head 9c3f088e, GitHub head 28dd045c: moved since review, BATCH-READY not yet re-confirmed; 2061: GO (2026-11-13 05:10); reviewed head 7386e906, same on GitHub; 2067: GO (2026-11-13 05:43); reviewed head 2d825913, same on GitHub; 2101: not reviewed; GitHub head dc5b17ea, not reviewed yet.
   6. **Still owed:** its fault BUG-1298 is accepted ("FIXED (Codex-accepted, record-checked, Civil 3.0.90.7)"); the tool is not: its wording, the record format number and BUG-1299 (controller, 15 Nov 06:06), and its everyday-job run on the installed build. 2061, 2067 and 2101 are not installed.
4. **CDEDIT (edit a pit or pipe).**
   1. **Built:** yes: Edit Pit and Edit Pipe in your installed Civil, with the Cancel hold from 2064 and the Unknown-not-guessed values from 2049, both behind switches that are off.
   2. **Seen in AutoCAD:** Edit Pit: Codex TCE14 OVERALL PASS on 3.0.90.10 (Cancel, Esc, Save, one Undo, save and reopen). Robot 15 Nov 15:21 to 15:37: Edit Pit Save then one Undo and Edit Pipe Save then one Undo, with CE's record read either side, all PASS, and Edit Pipe's Save held through save and reopen. Codex on Edit Pipe Save (TCE16): NOT TESTED, stale screenshots (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 3).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03 (the two switches off).
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2064: GO (2026-11-13 11:50); reviewed head dde7825e, GitHub head 19569d86: moved since review, GO not yet re-confirmed; 2049: GO (2026-11-13 03:45); reviewed head 98d81717, GitHub head f9d35d0c: moved since review, GO not yet re-confirmed; 2056: GO (2026-11-13 05:43); reviewed head 40e891f0, same on GitHub.
   6. **Still owed:** held by the controller: Codex has not yet seen Edit Pipe Save with working screenshots. For your eye: Edit Pipe's little pipe picture keeps the old size until Save. With the switch off as shipped, a cancelled edit can still add a bare pipe-layer line to CE's record with a guessed size (seen on 3.0.90.7); with it on, it is not added. 2056 is not installed.
5. **CDRUNSOLVE (solve inverts down a run).**
   1. **Built:** yes, in your installed Civil (2092 at `263e604d`): the A/B question at a split, the design flow (Q) read from Edit Pipe (your "yes", 14 Nov 23:25), and the message saying where the Q box is (More..., Levels & Flow).
   2. **Seen in AutoCAD:** the split question and the no-Q message: robot, on 3.0.90.4 and 3.0.90.10. With flows written into a scratch copy by the test: the preview, Esc, Apply, and one Undo putting CE's record and the drawing back, seen in record readings (RSQ18); Codex saw it but its screenshots were stale. Typing Q in Edit Pipe: not seen (neither robot nor Codex can reach that box) (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, items 5, 6 and 6b). Left out of the run of the ten on the controller's order.
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2092: BATCH-READY (2026-11-14 01:22); reviewed head d686e787, GitHub head 263e604d: moved since review, BATCH-READY not yet re-confirmed; 2065: GO (2026-11-13 05:10); reviewed head cb133d67, same on GitHub.
   6. **Still owed:** Q typed in Edit Pipe seen working; Codex screenshots of Apply and one Undo; your engineering look at the levels Apply wrote while the preview warned of negative cover (queue item 9). Noted: a run that applies nothing still counts as its own Undo step. 2065 is not installed.
6. **CDRENUMBER.**
   1. **Built:** yes: the crash fix in your installed Civil, and 2093 (it names pits not joined to the outlet and loop pipes even when nothing needs renumbering) since 3.0.90.10.
   2. **Seen in AutoCAD:** a real renumber: robot 4 of 4 on 3.0.90.10 (No, Yes, one Undo, save and reopen; numbers changed only after Yes). The not-joined and loop lines: robot on 3.0.90.10. Codex witness of the real renumber: NOT TESTED, its screen tool failed three times (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 8; `areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, batch 8).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2093: not reviewed; GitHub head 644cb90e, not reviewed yet.
   6. **Still owed:** a Codex look at the real renumber. Its crash fault BUG-968 is accepted ("FIXED (Codex-accepted, Civil 3.0.90.3, 14 Nov 2026)").
7. **PITSCHEDULE.**
   1. **Built:** yes: the left-out plastic pits words and grey count (2039 at `102bb87f`) and the Export CSV guard (2107) in your installed Civil.
   2. **Seen in AutoCAD:** Codex over two runs on a blank copy with two pits: open and Close, Esc while placing, place, one Undo, save and reopen, each PASS once; robot open and Close. On 3.0.90.11 the robot saw "3 plastic pits not listed (no number)" and "1 row listed". Export CSV: NOT TESTED (the Save As box cannot be reached) (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 4; `areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`, batch 9).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2039: GO (2026-11-13 01:28); reviewed head fd9bcce5, GitHub head 102bb87f: moved since review, GO not yet re-confirmed; 2107: GO (2026-11-13 23:53); reviewed head 320dcdcb, GitHub head 9f8a73e4: moved since review, GO not yet re-confirmed.
   6. **Still owed:** held by the controller: one clean run on a drawing with pipes, a record reading either side, "Update existing schedule" tried, and why placing is greyed out on a drawing holding an older unlinked schedule.
8. **CDRULES with CDCALC.**
   1. **Built:** no fix for it is installed; the installed tool was run as it is.
   2. **Seen in AutoCAD:** CDRULES: robot Esc and all four answers, drawing unchanged; Codex TCM14 Problems and Values PASS. CDCALC: opened and closed, nothing changed, robot and Codex; nothing calculated. The Codex run with Esc and CDCALC (TRC14) was blocked by a brief mistake that ran CLEAN on the scratch copy (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 5).
   3. **Installed:** only the build that was there before.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2087: not reviewed; GitHub head 9891fbd8, not reviewed yet.
   6. **Still owed:** held by the controller: one clean Codex run (Esc, Problems, Values, CDCALC doing a calculation, save and reopen); a look at CDRULES adding about 1.8 MB of results to CE's record against the look-only rule. 2087 (keeps only its newest runs) is not reviewed and not installed.
9. **CDCHECKCURRENT (check this drawing).**
   1. **Built:** the installed tool; 2066 (flags a blank link, found by its title) is not installed.
   2. **Seen in AutoCAD:** yes: robot and Codex TCM14 on Civil 3.0.90.10, "27 items need checking. Nothing has been fixed automatically.", drawing and CE's record unchanged (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 6).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** yes.
   5. **Drafts and latest review:** 2066: GO (2026-11-13 07:03); reviewed head d846f1ed, same on GitHub.
   6. **Still owed:** nothing for the count.
10. **MR (move and rotate).**
   1. **Built:** the installed tool; 2081 (says what it cannot move on 2027) and 2062 (start-up checks) are not installed.
   2. **Seen in AutoCAD:** yes: robot 5 of 5 (the pit moved in the drawing and in CE's record, and came back with one Undo) and Codex TCM14 on Civil 3.0.90.10; the controller saw the Undo on screen (`areas\trust-run\TEN_ON_INSTALLED_BUILD.md`, section 7).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** yes.
   5. **Drafts and latest review:** 2081: GO (2026-11-13 07:25); reviewed head c78016cf, GitHub head ac12e9b9: moved since review, GO not yet re-confirmed; 2062: GO (2026-11-13 06:20); reviewed head 620fe976, same on GitHub.
   6. **Still owed:** nothing for the count. Your words of 5 Nov, "so far cr/mr work but not on all objects", are what 2081 is about.

## Safety fixes beside the ten (first, because they can lose work)

1. **Two jobs mixed up: Help and Settings writing one job into another (BUG-1456).**
   1. **Built:** yes: 2073 and 2083 since Civil 3.0.90.2, and the further layers 2100, 2089 and 2090 since 3.0.90.6.
   2. **Seen in AutoCAD:** the robot's ten-check smoke passed 10 of 10 on every batch, the latest on 3.0.90.11 (15 Nov 16:14 to 16:48). Codex, 14 Nov, saw no mixing, but four steps are NOT TESTED because it cannot screenshot its own readings (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`).
   3. **Installed:** yes, Civil 3.0.90.11, on your PC since Sun 15 Nov 16:03.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2073: GO (2026-11-13 05:53); reviewed head 1a28c3b3, same on GitHub; 2083: GO (2026-11-13 07:32); reviewed head 522e5502, GitHub head 8a6decef: moved since review, GO not yet re-confirmed; 2100: FIX FIRST (2026-11-13 17:46); reviewed head 364ccc4e, GitHub head 4a4d7c33: moved since review, its FIX FIRST list not yet re-confirmed; 2089: FIX FIRST (2026-11-13 11:50); reviewed head e938d0d4, GitHub head 7707d158: moved since review, its FIX FIRST list not yet re-confirmed; 2090: GO (2026-11-13 11:50); reviewed head 39e489e9, GitHub head 2e604481: moved since review, GO not yet re-confirmed; 2078: GO (2026-11-13 07:37); reviewed head e1bdc16e, same on GitHub.
   6. **Still owed:** Codex screenshots retaken (not started, `areas\trust-run\TEN_ON_INSTALLED_BUILD.md`). 2078 is not installed.
2. **CLEAN and FASTSAVE saving over a template (BUG-1457, Structural).**
   1. **Built:** yes, in Structural 1.0.126.1 (2094 at `2205dfde`).
   2. **Seen in AutoCAD:** the robot, 14 Nov: 5 of 5 on template copies. Codex saw the saved-drawing case twice but could not reach a never-saved drawing (the driver refuses NEW) (`areas\trust-run\INSTALL_BATCH_RESULT_14NOV.md`).
   3. **Installed:** yes, Structural 1.0.126.1 since 14 Nov 14:15.
   4. **Accepted:** no.
   5. **Drafts and latest review:** 2094: BATCH-READY (2026-11-14 01:38); reviewed head 2205dfde, same on GitHub.
   6. **Still owed:** a way for Codex to reach a never-saved drawing; Codex screenshots retaken (not started).

---

# Parked, untouched

Under Tim's rule these stay as drafts; nothing is closed or deleted, and a draft comes back only when its tool comes up.

1. **Parked drafts:** 46 of the 74 open on GitHub (pull requests 2038 to 2111). None merged. 3 of them are inside the trial build on Tim's PC (2040, 2041, 2045); the rest are not installed.
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

1. **The list and the GitHub heads:** `gh pr list --state open --draft` on the plugin repository at 2026-11-15 18:33, branches containing "trust" or "bug-1456".
2. **Verdicts, times and reviewed heads:** the latest line per pull request in `areas\trust-run\trust-review.md`, including "re-reviewed at" heads and the 06:21 re-read of 2038, 2043, 2047 and 2051 (GO holds at their new heads). The reviews done for the 15 Nov trial batches are written only in `areas\trust-run\INSTALL_BATCH_14NOV.md` (for example 2100, 2089 and 2090 GO at their batch 4 heads), not in trust-review.md, so a verdict shown here for a draft installed on 15 Nov can be older than its batch review.
3. **What each row owes beyond the robot:** the review files in `areas\trust-run\reviews\` and `reviews\status-board-check.md`.
4. **Evidence:** `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_READER.md`, `EVIDENCE_CROSS_DRAWING.md`, `EVIDENCE_STALE_BUGS.md`. Fixes seen on the installed build (BUG-650, BUG-968, BUG-290) are not trial changes; they are on the morning page.
5. **Plain names and plan steps:** this lane, from the pull request titles and the review lines.
6. **The ten tools and the rule:** `areas\trust-run\QUEUES.md` (Tim's ten, his standing trial approval, CODEX ALONE IS FINE) and `areas\TRUST_AUTONOMOUS_RUN_12NOV.md`, last sections; what each trial batch holds: `areas\trust-run\INSTALL_BATCH_14NOV.md`; what was seen: `areas\trust-run\TEN_ON_INSTALLED_BUILD.md` (with the controller's checks in it) and `INSTALL_BATCH_RESULT_14NOV.md`; faults accepted: `BUG_CARPARK.md` (BUG-968, BUG-1298); the controller's lines of 15 Nov in `areas\release-v3-colleagues-DESK_LOG.md`. A tool's drafts are those the files name, then open drafts whose title names that command (this lane's match by title).
