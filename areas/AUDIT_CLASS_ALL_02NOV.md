# Carpark audit, all 21 chunks merged, Mon 2 Nov 2026

Written by Sonnet (Team) for CE 05, Melbourne time. Read-only job: no code changed, nothing built, no test run, no AutoCAD opened, robot not run. Source: the 21 chunk files `C:\CE_PLAN\areas\AUDIT\AUDIT_CLASS_CHUNK01_02NOV.md` to `CHUNK21`. Every class below is the chunk auditor's call; I merged and counted them, I did not re-check any entry against the code or the installed bundle.

## FOR TIM

1. **Missing chunk files:** none. All 21 are there (chunk 21 is short, 17 entries). There are 1,217 entries in total, and no bug number appears twice.

2. **Counts per class (1,217 entries):**
   - **INSTALLED-WAITING-PROOF:** 534 (the fix is on the release line, nobody has proved it in AutoCAD)
   - **ALREADY-FIXED:** 205
   - **HAS-DRAFT:** 198 (a draft fix exists but is not on the line; 38 of these are pilot-critical)
   - **NEEDS-TIM:** 91
   - **FIXABLE-NOW:** 75
   - **UNCLEAR:** 65 (11 of these are pilot-critical)
   - **CLOSED-OR-WONT-FIX:** 34
   - **DUPLICATE:** 15

3. **Plain caveat:** "installed-waiting-proof" and "already fixed" are the auditors' reading of the carpark text and the commits on `origin/claude/rel-20261102a` (Civil/Manager) and `origin/claude/rel-20261026s` (Structural). Chunk 1 says plainly that nobody read the installed DLL version. Nothing here is Tim-accepted. Chunk 2 also found about 17 entries whose carpark text is out of date (fixed under hunt names, still reading plain OPEN).

4. **The 25 most pilot-critical FIXABLE-NOW, in the order a builder should take them.** Wrong numbers on a drawing or schedule first, then protection of locked layers and Xrefs, then the colleague install, then workflow gaps, then smaller items. Chunk 21 and the others label some entries pilot-critical "yes"; where an entry carries no label (BUG-1080 to 1105) I read its "yes" as pilot-critical.
   1. **BUG-497:** Structural bracing and pier tables are sized one row short; the fix is "count + 2". No judgement needed.
   2. **BUG-498:** a schedule refresh never clears leftover rows, so bracing can be overstated (the dangerous direction).
   3. **BUG-1052:** CDAGI treats drawing units as millimetres; wrong run lengths in a metre drawing.
   4. **BUG-1053:** the LandXML import reads rim levels with no unit conversion; convert to metres or show Unknown.
   5. **BUG-1042:** the Civil tip refuses with "Enter the cover level." when it should warn and keep cover Unknown.
   6. **BUG-027:** Grade still adds "MIN." against Tim's UX-CPLAN-05 ruling (CdCommand.Grade.cs 212 to 221).
   7. **BUG-1080:** Refresh Blocks inserts onto locked layers; skip and say so (protection rule).
   8. **BUG-1081:** attribute edits ignore the attribute's real layer lock; drop the allow-on-locked flag (protection rule).
   9. **BUG-1083:** reject an attached or overlaid Xref at the pick and at Apply, with a plain message (protection rule).
   10. **BUG-1105:** store tank rating, file, date and litres; warn on mismatch, typed-reason override.
   11. **BUG-1205:** one record per session; crash only if the owner process is gone (shared file, sync Manager by hand).
   12. **BUG-1208:** settings file written with lock, re-read, change one entry, atomic replace.
   13. **BUG-1064:** one machine-wide install lock in the installer (Opus lane, protected installer).
   14. **BUG-1065:** retire the live bundle on install and say so plainly if clean-up fails (Opus lane).
   15. **BUG-1166:** one shared office-folder lookup for Civil and Manager (affects Max's OneDrive).
   16. **BUG-1175:** CDSL, CDHELP and the trench-grate audit point at Tim's own folders; Max's PC will not have them.
   17. **BUG-1173:** colleague pack wording only: add three folders and the MENULOAD unload line.
   18. **BUG-396:** double-click on a placed pit schedule cell must open the Pit Schedule window at that cell (approved design; still failing on 3.0.56).
   19. **BUG-213:** older schedule has no working "Replace older schedule" button (Codex FAIL again on 3.0.49).
   20. **BUG-900:** collect schedule rows from every page in the X-Civil PDF extractor.
   21. **BUG-1148:** copy only labels whose owner note names the source pit (a copied pit can pick up the wrong labels).
   22. **BUG-235:** a copied pit can steal a pipe end from the original; warn on an exact overlap.
   23. **BUG-1160:** store "last written by" and "highest version ever written" in the settings record.
   24. **BUG-1154:** reuse the existing 255-character splitter so long text is not cut.
   25. **BUG-648:** AG drain accepts but draws no grade text; one visible 1:50 label per run.

   After these, the rest of the FIXABLE-NOW list is wording, help text, older-lane ports and log noise (see the merged list, entries tagged FIXABLE-NOW).

5. **Top NEEDS-TIM questions, grouped for CE 04.** These are Tim's engineering or design calls. Each has a recommendation in its own entry; I have not re-derived them.
   1. **Engineering numbers and rules (most pilot-critical):**
      - BUG-818: Tim's ten-row check of the corrected steel section list; hollow-section and top-hat data sources open.
      - BUG-685: a typed upstream level of 10.125, keep exact or round to 10.13?
      - BUG-095: Glen Eira detention 1.80 m³ against 2.58 m³; which basis (Boyd's sheet or Swinburne profile) is right.
      - BUG-1020 and BUG-245: which pit depth or pipe direction wins when recorded levels and drawn order disagree.
      - BUG-080 and BUG-775: maximum velocity for UPVC and pipe wall thickness per class.
      - BUG-056 and BUG-641: council connection matching rule and catchment dividing rule.
      - BUG-1060, BUG-431, BUG-534, BUG-538: which standards and council editions to show.
      - BUG-499, BUG-950: how A and B brace lengths combine, and the kN rating per bracing type.
      - BUG-866: rainfall-curve note and the 6 to 8 per cent low curve values.
   2. **Settings, job record and privacy:**
      - BUG-496 (decides 496, 500, 533, 548): job record saved per PC, or with the drawing, or with the job folder.
      - BUG-492 and BUG-423: time-log and report files named by Windows login.
      - BUG-557, BUG-429, BUG-493: personal-OneDrive fallback, writing new default rows on upgrade, which start-up writes to log.
   3. **Rollout and install (Max's pilot):**
      - BUG-1176: will the package reach Max by USB or the synced pilot folder.
      - BUG-883, BUG-483, BUG-553, BUG-554: double-click first install, an "OLD - do not use" folder, pip install OFF versus shipping packages, signature check versus WebView2 installer.
      - BUG-411 and BUG-354: F2 binding and removing the old line from Tim's AutoCAD profile.
   4. **True-size and scale rules:**
      - BUG-338 item 4 and BUG-321: draw true size in a real metre drawing.
      - BUG-454, BUG-315, BUG-505, BUG-949, BUG-952, BUG-910, BUG-954: text height and scale rules for pad labels, schedules, LBH, LBUH, CEMEMBER and hatch pairs.
   5. **Windows and names awaiting a command card (review gate):**
      - BUG-615, BUG-634, BUG-636, BUG-1124, BUG-1125, BUG-249, BUG-1029, BUG-1230: card approvals before any code.
      - BUG-934, BUG-935, BUG-222, BUG-172, BUG-517, BUG-525: window name, settings tabs, six missing ribbon icons, charcoal, gold and soft-grey theme colours.
   6. **Monday questions with no recorded answer:** BUG-1236 (OF and FO share one symbol), BUG-1242 (number on every source tag), BUG-1252 (label travels with the pipe end). BUG-1233 is waiting on the unsettled grade-row design.
   7. **Confirm to close:** BUG-061 (not reproduced, Tim to say if gone), BUG-750 (close as replaced by CEMEMBER?), BUG-558 (AutoCAD's own Redo behaviour), BUG-001, BUG-031, BUG-034 (popup or banner, auto-pick wanted?).
   8. **Full NEEDS-TIM list:** 91 entries, every one tagged in the merged list below.

6. **DUPLICATES to close (15).** Closing means writing "duplicate of" in the entry and leaving it in the file, because entries are never deleted (RULES 13.3 amendment, D6). Seven are already closed on Tim's yes of 31 Oct or decision 178.
   1. **BUG-436** of BUG-061 (closed 31 Oct).
   2. **BUG-402** of BUG-354 (closed 31 Oct).
   3. **BUG-307** of BUG-095 (closed 31 Oct).
   4. **BUG-872** of BUG-095 (test-only, no separate work).
   5. **BUG-455** and **BUG-562** of BUG-435 (decision 178).
   6. **BUG-564** of BUG-469 (decision 178).
   7. **BUG-1177** of BUG-1202 (decision 178).
   8. **BUG-256** of BUG-558, **BUG-248** of BUG-258, **BUG-451** of BUG-454, **BUG-533** of BUG-500, **BUG-017** of BUG-035, **BUG-022** of BUG-028.
   9. **BUG-192** is marked a duplicate of BUG-256, which is itself a duplicate of BUG-558. Point it at BUG-558. It is also pilot-critical and REDO after U is still failing there.
   10. **Careful:** BUG-436, BUG-402 and BUG-307 point at entries that are not closed themselves (BUG-061 and BUG-095 need Tim; BUG-354 needs Tim). Closing the duplicates does not close those.

7. **ALREADY-FIXED to close (205) and CLOSED-OR-WONT-FIX (34).** The full ID lists are at the bottom of this file, after the merged list. Do not write plain FIXED on any of them. Each needs the ledger wording: "FIXED (Codex-accepted, build, date)" or "FIXED (Claude-accepted, build, date)", only where the entry shows that acceptance. I did not re-check which wording each one has earned.

8. **NOT proven by this audit:** nothing was opened in AutoCAD, no installed DLL was read, no PR was re-read by me, no build or test was run. The class on each line is the chunk auditor's reading.

## Merged entries (one line each, 1,217)

Format: running number, original chunk and number in brackets, bug, class, pilot-critical flag, note. Order is the chunk order (newest bug first).

1. [chunk 01 #1] BUG-855 | UNCLEAR | pilot-critical no | no fix or PR; which of the 96 issues is the new one is unknown, and the Codex check ran on an already-edited copy.
2. [chunk 01 #2] BUG-854 | ALREADY-FIXED | pilot-critical no | Codex-accepted on Civil 3.0.64, commit 039bedf6.
3. [chunk 01 #3] BUG-853 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 513059cf, in 3.0.70 via PR #1462, no robot or Codex run.
4. [chunk 01 #4] BUG-852 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager half merged (PR #1493, commit 4746cfa9); Structural half PR #1503 installed in 1.0.121; robot observation only.
5. [chunk 01 #5] BUG-851 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 09cbed4a, 3.0.70 via PR #1473; without it a colleague's Disable leaves grey proxy pipes.
6. [chunk 01 #6] BUG-850 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits d65d3f37 and 705c261b, 3.0.70 via PR #1448 and #1463; the Civil tab was rebuilt under the drafter.
7. [chunk 01 #7] BUG-849 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 742f36cb, 3.0.70 via PR #1454; administrator-only message.
8. [chunk 01 #8] BUG-848 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7eaa55db and 905e2dd0, 3.0.70 via PR #1469.
9. [chunk 01 #9] BUG-847 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5bdd424b, 3.0.70 via PR #1474; client names in the support zip.
10. [chunk 01 #10] BUG-846 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9c9aefda, 3.0.70 via PR #1449 and #1474.
11. [chunk 01 #11] BUG-845 | INSTALLED-WAITING-PROOF | pilot-critical no | commit affdf4dc, 3.0.70 via PR #1455.
12. [chunk 01 #12] BUG-844 | INSTALLED-WAITING-PROOF | pilot-critical no | commit e7b2dc74, 3.0.70 via PR #1452.
13. [chunk 01 #13] BUG-843 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7309b265, 3.0.70 via PR #1450; the "Add administrator" button stays a paused plan item.
14. [chunk 01 #14] BUG-842 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7eaa55db, 3.0.70 via PR #1459 and #1469.
15. [chunk 01 #15] BUG-841 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 39fa859b and 5cd70fe3 are on the Structural line rel-20261026s (S-44); the entry still says plain OPEN, so install is not confirmed.
16. [chunk 01 #16] BUG-840 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit c5e28d8f on rel-20261026s (S-44); entry still says plain OPEN, so install is not confirmed.
17. [chunk 01 #17] BUG-839 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 0e13f2b2, 3.0.70 via PR #1476; regression tests in c463d44b.
18. [chunk 01 #18] BUG-838 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1446 and #1475 merged (installer half), 3.0.70; whether OneDrive sets read-only was never checked.
19. [chunk 01 #19] BUG-837 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 49c930c6, 3.0.70 via PR #1470.
20. [chunk 01 #20] BUG-836 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 49c930c6, 3.0.70 via PR #1470.
21. [chunk 01 #21] BUG-835 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 49c930c6 and f0f770c5; robot run 33 could not read the dashboard tabs, so it is unproven.
22. [chunk 01 #22] BUG-834 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 980d2f65 and 5881da68 refuse an older stage; the empty "--approved-version=" bypass is a separate open item (ledger F-020, BUG-886).
23. [chunk 01 #23] BUG-833 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d79f8f10, 3.0.70 via PR #1461.
24. [chunk 01 #24] BUG-832 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d79f8f10, 3.0.70 via PR #1461; final checks in 4cb41a0b.
25. [chunk 01 #25] BUG-831 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 7e60a2b7, 3.0.70 via PR #1453.
26. [chunk 01 #26] BUG-830 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 0e13f2b2, 3.0.70 via PR #1476.
27. [chunk 01 #27] BUG-829 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 111e1505 and a690f36d, 3.0.70 via PR #1456.
28. [chunk 01 #28] BUG-828 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 2efe9fbd and a6707cef, 3.0.70 via PR #1458; nobody watched AutoCAD feed the text.
29. [chunk 01 #29] BUG-827 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 7e60a2b7 and f8ba8b90, 3.0.70 via PR #1453; the settings file is no longer overwritten when locked.
30. [chunk 01 #30] BUG-826 | HAS-DRAFT | pilot-critical yes | draft PR #1457, branch tl2-r455-bug826-reset; not merged onto rel-20261026s or rel-20261102a.
31. [chunk 01 #31] BUG-825 | INSTALLED-WAITING-PROOF | pilot-critical yes | step-iron half Codex-accepted on 3.0.66; velocity half robot PASS through the settings guard only (PR #1447, tests in 088f7cd0); joint-label-height half not run.
32. [chunk 01 #32] BUG-824 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit fdd724fc, 3.0.70 via PR #1443.
33. [chunk 01 #33] BUG-823 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 9db7cdf7, 3.0.70 via PR #1442.
34. [chunk 01 #34] BUG-822 | UNCLEAR | pilot-critical no | Tim has never seen the docked What's New panel (decision 151); parked until a test lists open windows after each step.
35. [chunk 01 #35] BUG-821 | CLOSED-OR-WONT-FIX | pilot-critical no | closed as "works as designed" on Tim's yes, decision 178, 31 Oct.
36. [chunk 01 #36] BUG-820 | NEEDS-TIM | pilot-critical no | wording half is Codex-accepted (commits 438ed483, 0fdf8176); open question: should CE draw the one missing invert text, or leave it as designed?
37. [chunk 01 #37] BUG-819 | NEEDS-TIM | pilot-critical no | card approved 19 Oct but the pause (ruling A) is not lifted and it waits on Tim's review of the section list (BUG-818); no code exists.
38. [chunk 01 #38] BUG-818 | NEEDS-TIM | pilot-critical yes | Tim's ten-row check of the corrected section list is not done and hollow-section and top-hat data sources are open; PR #1932 only renames 34 UB and UC rows.
39. [chunk 01 #39] BUG-817 | INSTALLED-WAITING-PROOF | pilot-critical no | Codex FAIL on 3.0.70 (23 Oct); fix commit f0a52f77 (PR #1671) is dated 24 Oct, after that build, so it needs a retest.
40. [chunk 01 #40] BUG-816 | HAS-DRAFT | pilot-critical no | draft PR #1875 gives the label tidy its own Settings row (plus 3 wording commits on fb/bug816-tidy-setting-row); not on the line.
41. [chunk 01 #41] BUG-815 | ALREADY-FIXED | pilot-critical yes | Codex-accepted on 3.0.64 for the R-06 wording and the false "outside 225-600" rows; commit 64e6751b.
42. [chunk 01 #42] BUG-814 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 05451d53 and 51267fd2; Codex W1-05 BLOCKED (fixture lacks DP3 tags); the "AGI 1" spacing is Tim's call.
43. [chunk 01 #43] BUG-813 | UNCLEAR | pilot-critical no | only the refusal wording is built (PR #1478); the rename itself still fails, and it needs a fixture of two ordinary source blocks to prove.
44. [chunk 01 #44] BUG-812 | INSTALLED-WAITING-PROOF | pilot-critical no | commits cedc590e and 676874b5, PR #1717 on rel-20261102a; not opened in AutoCAD.
45. [chunk 01 #45] BUG-811 | INSTALLED-WAITING-PROOF | pilot-critical no | level-cascade half merged (commit 49792eca, PR #1712); the vision-log half has no fix.
46. [chunk 01 #46] BUG-810 | INSTALLED-WAITING-PROOF | pilot-critical no | commit a8df1459, PR #1713 on rel-20261102a.
47. [chunk 01 #47] BUG-809 | INSTALLED-WAITING-PROOF | pilot-critical no | items 2, 3 and 4 merged (commits 5635eac1, 1be523c1, 614f06da); items 1 and 5 have no fix; item 4 Codex BLOCKED.
48. [chunk 01 #48] BUG-808 | INSTALLED-WAITING-PROOF | pilot-critical no | outlet half merged (commit 834870f3, PR #1431); the "checked 12" counting half has no fix.
49. [chunk 01 #49] BUG-807 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 1be523c1, 3.0.70 via PR #1409.
50. [chunk 01 #50] BUG-806 | FIXABLE-NOW | pilot-critical no | no fix or PR; the entry names the rule (head from the orifice IL, never round above the PSD limit) and the mapper has no live caller yet.
51. [chunk 01 #51] BUG-805 | HAS-DRAFT | pilot-critical yes | draft PR #1987 (B-158): metres, depth column and half-blank rows; not on the line (PR #817 is only the older typed-level wording).
52. [chunk 01 #52] BUG-804 | FIXABLE-NOW | pilot-critical no | no fix or PR; expected result is stated (send the hinted page and its neighbours); costs paid pages, so the page count is a small choice.
53. [chunk 01 #53] BUG-803 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 6199df19 and f0a87b5a, PR #1419 merged on rel-20261102a; entry gives no install note.
54. [chunk 01 #54] BUG-802 | INSTALLED-WAITING-PROOF | pilot-critical no | fixed with BUG-875 (commits 6b0a09da and 4f66d540, PR #1650); latent until Ignore ships.
55. [chunk 01 #55] BUG-801 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 165a12fa, 3.0.70 via PR #1416.
56. [chunk 01 #56] BUG-800 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1414 in 3.0.70; regression tests in 088f7cd0 and d9cc6866; a false "Network OK" would hide a failed check.
57. [chunk 01 #57] BUG-799 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7f4f8c39 and 73cd6f15, PR #1554 merged on rel-20261102a; entry gives no install note.
58. [chunk 01 #58] BUG-798 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 55671710, 3.0.70 via PR #1420 (Settings switch ON).
59. [chunk 01 #59] BUG-797 | INSTALLED-WAITING-PROOF | pilot-critical yes | draft PR #1400 in 3.0.70; robot saw only the cascade, Undo and REDO; Codex V2 and V2b NOT TESTED; the locked-layer case has never been tested by anyone.
60. [chunk 01 #60] BUG-796 | HAS-DRAFT | pilot-critical yes | report half is PR #1701 (commit aaaa7ff4, merged on rel-20261102a); the preview and Yes/No half has no fix.
61. [chunk 02 #1] BUG-795 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f4242a21 (PR #1417) is on the line; entry says installed 3.0.70, no robot or Codex run.
62. [chunk 02 #2] BUG-794 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 45d28706 (PR #1405) is on the line; no robot or Codex run.
63. [chunk 02 #3] BUG-793 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9ae7f1d6 (PR #1540) is on the line with the switch ON; entry still says plain OPEN, and "Save changes?" on an untouched drawing was never tried.
64. [chunk 02 #4] BUG-792 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 4289e35a (PR #1426) fixes the numbers half only (title says so); the half where text typed into Depth, Size, FROM or Remarks is ignored is not shown fixed.
65. [chunk 02 #5] BUG-791 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 717badf8 (PR #1425); Codex W2-02 PASS SURE 23 Oct but not Codex-accepted because the robot cannot judge cell colours.
66. [chunk 02 #6] BUG-790 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits afc32901 and d321f4fd (PR #1403); no robot or Codex run.
67. [chunk 02 #7] BUG-789 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 0b2536a0 (PR #1406); robot run 32 PASS on 3.0.56, not Codex-accepted; the one-missing-end case is BUG-820.
68. [chunk 02 #8] BUG-788 | HAS-DRAFT | pilot-critical yes | reopened 23 Oct because the installed core fix (73a63971, PR #1404) never reaches the adapter; draft PR #1925 (B-113) is not on the line.
69. [chunk 02 #9] BUG-787 | HAS-DRAFT | pilot-critical yes | draft PR #1423 (commit 92f34616) is on branch rel-20261018d only; held 24 Oct and Opus pre-review of 1 Nov says change needed because the line rewrote the same code.
70. [chunk 02 #10] BUG-786 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 81da50b4 (PR #1422) is on the line, switch ON; no robot or Codex run.
71. [chunk 02 #11] BUG-785 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 90cd6139 (PR #1402) is on the line; no robot or Codex run.
72. [chunk 02 #12] BUG-784 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit a086151a (PR #1413); Codex W2-01 NOT TESTED because the drawing has no inlet from a non-P pit, so it needs a fixture with C1 upstream.
73. [chunk 02 #13] BUG-783 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5be02d8f (PR #1412) plus tests; Codex W2-03 BLOCKED because the cell menu has no Delete cell item on this build (see BUG-1031).
74. [chunk 02 #14] BUG-782 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5588c82d (PR #1400); robot runs 32 to 35 pass the normal cascade, but the low-end hand-typed case itself was never tested by anyone.
75. [chunk 02 #15] BUG-781 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 2d2e7b49 (PR #1401); no robot or Codex run (needs a real consultant PDF and DWG).
76. [chunk 02 #16] BUG-780 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 7a687e38 (PR #1415), switch ON; no robot or Codex run.
77. [chunk 02 #17] BUG-779 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit df125802 (PR #1410), switch ON; no robot or Codex run.
78. [chunk 02 #18] BUG-778 | INSTALLED-WAITING-PROOF | pilot-critical no | commit ac6f65ea (IJK-X2, PR #1398) says the note now reads 1%-term; the entry still says plain OPEN.
79. [chunk 02 #19] BUG-777 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d19500c9 (PR #1411); Codex W1-04 SEEN 23 Oct (offers 18.05), but the invert-plus-diameter cross-check was not done.
80. [chunk 02 #20] BUG-776 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 8cb019a2 (IJK-26, PR #1399) is on the line; the entry still says plain OPEN.
81. [chunk 02 #21] BUG-775 | NEEDS-TIM | pilot-critical no | no fix; needs the pipe wall thickness per pipe class (Tim's number, the Settings table is not filled); the rule has no caller yet, so it is latent.
82. [chunk 02 #22] BUG-774 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 0cbf3573 (IJK-23, PR #1397) says a repeated pick is ignored; the entry still says plain OPEN.
83. [chunk 02 #23] BUG-773 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 04930ee3 (PR #1432) fixes the true-centre half only (title says so); the rounding half (IJK-20) is not shown fixed.
84. [chunk 02 #24] BUG-772 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 8324a299 (PR #1428); cannot be tested on this build because the WSUD tab is read-only (Codex W5-03).
85. [chunk 02 #25] BUG-771 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 78e88961 (PR #1700) merged into the line on 24 Oct; the entry still says plain OPEN and Codex has not run CDRG.
86. [chunk 02 #26] BUG-770 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7c55eca2 and 920e7160 (PR #1424); latent, nothing draws it today.
87. [chunk 02 #27] BUG-769 | INSTALLED-WAITING-PROOF | pilot-critical no | commits a2d5ea9c and c62eb3bf (PR #1427); no robot or Codex run.
88. [chunk 02 #28] BUG-768 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9e20647e (PR #1421); no robot or Codex run.
89. [chunk 02 #29] BUG-767 | INSTALLED-WAITING-PROOF | pilot-critical no | commits d5115f0e and 805e5492 (PR #1433), switch ON; no robot or Codex run.
90. [chunk 02 #30] BUG-766 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 5ee899a2 (PR #1711) merged into the line on 24 Oct; the entry still says plain OPEN.
91. [chunk 02 #31] BUG-765 | HAS-DRAFT | pilot-critical no | draft PR #1939 (B-122, commit 209cc31d, 31 Oct) is not on the line (only on later branches).
92. [chunk 02 #32] BUG-764 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 32d8a155 (PR #1709) merged into the line on 24 Oct; the entry still says plain OPEN.
93. [chunk 02 #33] BUG-763 | INSTALLED-WAITING-PROOF | pilot-critical no | commit ad608b7b (IJK-08, PR #1396) says the grid shows one pipe per row; the entry still says plain OPEN.
94. [chunk 02 #34] BUG-762 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit aee03e91 (IJK-07, PR #1393) makes invert above cover Unknown with a reason; the entry still says plain OPEN.
95. [chunk 02 #35] BUG-761 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit b2b35d66 (IJK-06, PR #1395) removes the falling grade on a rising pipe; the entry still says plain OPEN.
96. [chunk 02 #36] BUG-760 | INSTALLED-WAITING-PROOF | pilot-critical no | commit b46f0c32 (PR #1710) merged into the line on 24 Oct; grade reads LEVEL; the entry still says plain OPEN.
97. [chunk 02 #37] BUG-759 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 4c0f1623 (IJK-04, PR #1394) refuses a datum above the lowest sump; the entry still says plain OPEN.
98. [chunk 02 #38] BUG-758 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 3e481b4b and 16f71a06 (PR #1407 and #1408); Codex W5-01 saw only the window half, and the hide switch and engineering half are untested.
99. [chunk 02 #39] BUG-757 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 44d09925 (IJK-02, PR #1391) makes the 0.000 trench grate cover Unknown; the entry still says plain OPEN.
100. [chunk 02 #40] BUG-756 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 1eb259ee (IJK-01, PR #1392) draws each pipe's top line at its own size; the entry still says plain OPEN.
101. [chunk 02 #41] BUG-755 | INSTALLED-WAITING-PROOF | pilot-critical no | commit cc6a5c58 (PR #1385) merged in S-44 and Structural 1.0.125 is installed; Codex on 1.0.118 still saw the pictures touch the top edge.
102. [chunk 02 #42] BUG-754 | INSTALLED-WAITING-PROOF | pilot-critical no | commit df7d2a5a (PR #1388, #1389); no robot or Codex run.
103. [chunk 02 #43] BUG-753 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 22921387 (PR #1387); Codex sampled 8 views fine but the 618-row list was not read end to end.
104. [chunk 02 #44] BUG-752 | INSTALLED-WAITING-PROOF | pilot-critical no | commit e31f4c63 (PR #1386) merged in S-44 and installed in 1.0.125; Codex last saw the clipped paths on 1.0.118, before the fix.
105. [chunk 02 #45] BUG-751 | HAS-DRAFT | pilot-critical no | draft PR #1383 (commit 4a5db9f7) is not on the Structural line; reviewed HOLD on 24 Oct.
106. [chunk 02 #46] BUG-750 | NEEDS-TIM | pilot-critical no | your CEMEMBER design replaces SBEAM and PR #1384 is not merged; question: close this bug as superseded?
107. [chunk 02 #47] BUG-748 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f19b054d (PR #1498) is in Structural 1.0.121 and later; the 1:50 density is still an unapproved straight line (QUESTIONS_FOR_MONDAY B4).
108. [chunk 02 #48] BUG-749 | UNCLEAR | pilot-critical no | seen three times, always when Codex typed text, so it may be how Codex types and not CE; missing a run that answers the prompt by another input method.
109. [chunk 02 #49] BUG-747 | INSTALLED-WAITING-PROOF | pilot-critical no | commits df12354d and 34c23f03 (PR #1364); no robot or Codex run.
110. [chunk 02 #50] BUG-746 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9bfc5cd8 (PR #1372); run 31 could not pick a tagged block, so it is unproven.
111. [chunk 02 #51] BUG-745 | INSTALLED-WAITING-PROOF | pilot-critical no | commits e6f44c09 and 0ceb3ae3 (PR #1345, #1350); no robot or Codex run, and it needs a metres drawing.
112. [chunk 02 #52] BUG-744 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f15b6c1f (PR #1343); no robot or Codex run.
113. [chunk 02 #53] BUG-743 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits e6f44c09 and 4b03ad1d (PR #1345); a wrong cover level could carry from one job to the next; no robot or Codex run.
114. [chunk 02 #54] BUG-742 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7e60da94 (PR #1358); robot runs 32, 34 and 35 PASS (refuses WT2), not Codex-accepted.
115. [chunk 02 #55] BUG-741 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 2df77713 (PR #1355, shared with BUG-740) offers DP4 and WT2; no robot or Codex run of the repair itself.
116. [chunk 02 #56] BUG-740 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 2df77713 and 98f605ea (PR #1355); robot runs 31 and 32 PASS the numbering, but the rename did not apply (BUG-813).
117. [chunk 02 #57] BUG-739 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 30db1214 (PR #1373) fixes the report half only; reading the PDF once is not shown fixed.
118. [chunk 02 #58] BUG-738 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 55dc8705 and 452f87c2 (PR #1365); no robot or Codex run.
119. [chunk 02 #59] BUG-737 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 5bab7211 and 100db1f2 (PR #1366); no robot or Codex run.
120. [chunk 02 #60] BUG-736 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 62dbbffc (PR #1359) reads "IL:12.34"; the (IN)/(OUT) half is not shown fixed.
121. [chunk 03 #1] BUG-735 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 9e0b391e on rel-20261102a, installed 3.0.70 (PR #1367), no robot or Codex pass.
122. [chunk 03 #2] BUG-734 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 5beb2458 (PR #1368), installed 3.0.70, wrong upstream level risk, no robot or Codex pass.
123. [chunk 03 #3] BUG-733 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b2d2d8d2 (PR #1353), installed 3.0.70, a pit was silently not drawn.
124. [chunk 03 #4] BUG-732 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit cde06b41 (PR #1356), installed 3.0.70, data loss on Replace, no robot or Codex pass.
125. [chunk 03 #5] BUG-731 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits cde06b41 and fff9fbed (PR #1356), installed 3.0.70, data loss on declined review.
126. [chunk 03 #6] BUG-730 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit ba9935b0 (PR #1354), installed 3.0.70, loses invert levels from the schedule table.
127. [chunk 03 #7] BUG-729 | ALREADY-FIXED | pilot-critical no | Commit 2ed82768 on rel-20261102a (with 725 and 728); entry still says OPEN and it is not installed.
128. [chunk 03 #8] BUG-728 | ALREADY-FIXED | pilot-critical no | Commit 2ed82768 on rel-20261102a; entry still says OPEN, and the real-export check was never done.
129. [chunk 03 #9] BUG-727 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit e6de44ad (PR #1377), installed 3.0.70.
130. [chunk 03 #10] BUG-726 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 388fe5e9 (PR #1357), installed 3.0.70.
131. [chunk 03 #11] BUG-725 | ALREADY-FIXED | pilot-critical yes | Commit 2ed82768 on rel-20261102a (one scale per file); entry still says OPEN, not installed, millimetre LandXML scatters the network.
132. [chunk 03 #12] BUG-724 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a keeps the file's pipe class; entry says OPEN, not installed.
133. [chunk 03 #13] BUG-723 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a flags box pipes; entry says OPEN, not installed.
134. [chunk 03 #14] BUG-722 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1363; no commit tagged with the number found on rel-20261102a (my search by number only).
135. [chunk 03 #15] BUG-721 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b8f87ade (PR #1380), installed 3.0.70, data loss without a question.
136. [chunk 03 #16] BUG-720 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a splits control pit width; entry says OPEN, not installed.
137. [chunk 03 #17] BUG-719 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a reads refStart/refEnd; entry says OPEN, and the entry's own "confirm with a real export" step is not recorded.
138. [chunk 03 #18] BUG-718 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1347 and #1351 (grouped LOW items).
139. [chunk 03 #19] BUG-717 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1348.
140. [chunk 03 #20] BUG-716 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1349.
141. [chunk 03 #21] BUG-715 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1346, pit design-level offer could be 0.2 m off with a breakline.
142. [chunk 03 #22] BUG-714 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1342 (shared level reader, same PR as 711 and 713).
143. [chunk 03 #23] BUG-713 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1342.
144. [chunk 03 #24] BUG-712 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 9fa679c8 (PR #1344), installed 3.0.70, robot observation PASS but not Codex-accepted.
145. [chunk 03 #25] BUG-711 | ALREADY-FIXED | pilot-critical no | FIXED (Claude-accepted, Civil 3.0.75, 25 Oct) by runner case R35, PR #1342; not confirmed in Tim's drawings.
146. [chunk 03 #26] BUG-710 | ALREADY-FIXED | pilot-critical yes | Merged PR #1341 (commit d51a13cb) on rel-20261102a; entry still says OPEN, wrong grade on metre drawings.
147. [chunk 03 #27] BUG-709 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1352 and #1438 (ships OFF); run 36 could not prove it.
148. [chunk 03 #28] BUG-708 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1360.
149. [chunk 03 #29] BUG-707 | HAS-DRAFT | pilot-critical no | Draft PR #1545 (branch cx/fb10-c60); fix commits f44c5083 and 8ed03233 are on rel-20261102a, but the entry says it is not installed.
150. [chunk 03 #30] BUG-706 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 6b7c968e (PR #1376), installed 3.0.70.
151. [chunk 03 #31] BUG-705 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commits 63fe52f5 and 7250faf2 (PR #1374), installed 3.0.70.
152. [chunk 03 #32] BUG-704 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commits 3579d32e and cb770842 (PR #1361), installed 3.0.70; a Codex check was blocked by a shared lock.
153. [chunk 03 #33] BUG-703 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit d6abf468 (PR #1371), installed 3.0.70, wrong ground levels at pits if it fails.
154. [chunk 03 #34] BUG-702 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 6332655f (PR #1362), installed 3.0.70, needs an AutoCAD scenario.
155. [chunk 03 #35] BUG-701 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit e9d3ebde (PR #1369), installed 3.0.70, possible hang in millimetre drawings.
156. [chunk 03 #36] BUG-700 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit de50f69f (PR #1375), installed 3.0.70, levels 1000 times too big if it fails.
157. [chunk 03 #37] BUG-699 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits 24e21a90 and 8af545ac (PR #1352), installed 3.0.70, drops spot levels above RL 500 on hill sites.
158. [chunk 03 #38] BUG-696 | INSTALLED-WAITING-PROOF | pilot-critical no | Entry says installed 3.0.70 via PR #1331; I found no commit tagged BUG-696 on rel-20261102a (not verified).
159. [chunk 03 #39] BUG-695 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 5af6ef3e (PR #1331), installed 3.0.70, only the quoted distance was wrong.
160. [chunk 03 #40] BUG-694 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit c9ee9843 (PR #1325), installed 3.0.70.
161. [chunk 03 #41] BUG-693 | ALREADY-FIXED | pilot-critical no | Commit 69451402, merged PR #1688 on rel-20261102a; entry says OPEN, not installed.
162. [chunk 03 #42] BUG-692 | ALREADY-FIXED | pilot-critical no | Commit 69451402, merged PR #1688 (e428d31f) on rel-20261102a; entry says OPEN, not installed.
163. [chunk 03 #43] BUG-691 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1335 (commit 1bd133b9), wrong split level of 19.95 instead of 19.97 if it fails.
164. [chunk 03 #44] BUG-690 | ALREADY-FIXED | pilot-critical yes | Merged PR #1659 (commit 92ebe3a7) on rel-20261102a; entry says OPEN, a junction could vanish from the Pit Schedule.
165. [chunk 03 #45] BUG-689 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1327; no commit tagged BUG-689 found on rel-20261102a (not verified), back-fall warning missing.
166. [chunk 03 #46] BUG-688 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2644c197 (PR #1327), installed 3.0.70.
167. [chunk 03 #47] BUG-687 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 6e30fc50 (PR #1319), installed 3.0.70, a typed flow was silently lost.
168. [chunk 03 #48] BUG-686 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2c21b843 (PR #1320), installed 3.0.70.
169. [chunk 03 #49] BUG-685 | NEEDS-TIM | pilot-critical yes | Two of Tim's rules conflict: should a typed upstream level (10.125) stay exact or round to the nearest 10 mm (10.13)?
170. [chunk 03 #50] BUG-684 | ALREADY-FIXED | pilot-critical yes | FIXED (Claude-accepted, Civil 3.0.75, 25 Oct) by runner case R39b, PR #1321; the "pick an existing CE pipe" half is not proved.
171. [chunk 03 #51] BUG-683 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits c807cd0e and f5e5472a (PR #1437), installed 3.0.70; run 36 could not reach the question.
172. [chunk 03 #52] BUG-682 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 60fcad04 (PR #1435), installed 3.0.70.
173. [chunk 03 #53] BUG-681 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b26a8ef3 (PR #1434), installed 3.0.70, schedule and drawing could disagree on levels.
174. [chunk 03 #54] BUG-680 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 3c539f02 (PR #1323), installed 3.0.70.
175. [chunk 03 #55] BUG-679 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit f100040a (PR #1326) covers the turn half; entry also lists an Align-to-building half that I could not confirm was done.
176. [chunk 03 #56] BUG-678 | INSTALLED-WAITING-PROOF | pilot-critical no | Entry says installed 3.0.70 via PR #1318; no commit tagged BUG-678 found on rel-20261102a (not verified).
177. [chunk 03 #57] BUG-677 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2b8ab057 (PR #1323), installed 3.0.70.
178. [chunk 03 #58] BUG-676 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 4e41ad56 (PR #1324), installed 3.0.70, a trafficable lid was silently downgraded.
179. [chunk 03 #59] BUG-675 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 4a56a72d (PR #1318), installed 3.0.70, rotated pit passed the fit check wrongly.
180. [chunk 03 #60] BUG-674 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit f100040a (PR #1326), installed 3.0.70, pipe ends stayed inside or short of the pit walls.
181. [chunk 04 #1] BUG-673 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 5bc5a17b on the 02a line, installed in Civil 3.0.70 via PR #1332; no robot or Codex result.
182. [chunk 04 #2] BUG-672 | ALREADY-FIXED | pilot-critical no | Commit 6f7736c5 (PR #1831) on the 02a line makes the locked-layer copy line name only what is missing, which answers the 25 Oct runner finding; not installed yet and not proven.
183. [chunk 04 #3] BUG-671 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 6b57f96c, installed in Civil 3.0.70 via PR #1337; the runner case R34 only mentions it.
184. [chunk 04 #4] BUG-670 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 6b57f96c, installed in Civil 3.0.70 via PR #1337; no robot case.
185. [chunk 04 #5] BUG-669 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix a1320ec6, installed via PR #1334; no robot case.
186. [chunk 04 #6] BUG-668 | HAS-DRAFT | pilot-critical yes | DRAFT PR #1539 is preparation only and says it is blocked (the real fix is in LinkService, which the brief forbade); the complete fix is not written.
187. [chunk 04 #7] BUG-667 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 212ca77d, installed via PR #1336; no robot case (needs the headless harness for a test).
188. [chunk 04 #8] BUG-666 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix in PR #1328 (installed in Civil 3.0.70 per Status); robot case R34 mentions it but does not prove it.
189. [chunk 04 #9] BUG-665 | ALREADY-FIXED | pilot-critical yes | Commit 6f7736c5 (PR #1831) on the 02a line fixes the ROTATE/SCALE Copy gap the 25 Oct runner still saw, with the switches pinned ON; the installed 3.0.75 build still fails with the tick OFF, so not installed or proven there.
190. [chunk 04 #10] BUG-664 | ALREADY-FIXED | pilot-critical no | Merge edc3fb97 (PR #1682, fix 19f02107) is on the 02a line; the Status still reads OPEN with no note.
191. [chunk 04 #11] BUG-663 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix b675df6e, installed via PR #1331; no robot case.
192. [chunk 04 #12] BUG-662 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix e857dedb, installed via PR #1330; the command is hidden from the ribbon.
193. [chunk 04 #13] BUG-661 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 503faf55, installed via PR #1329; no robot case (needs a rotated UCS drawing).
194. [chunk 04 #14] BUG-660 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix c0525699, installed via PR #1333; no robot case.
195. [chunk 04 #15] BUG-659 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixes 255338cd and 2f6cfca5, installed via PR #1322; wrong flow direction in the Pit Schedule, no robot case.
196. [chunk 04 #16] BUG-658 | FIXABLE-NOW | pilot-critical no | No fix or draft exists; Expected is clear (ask and apply after the edit commits, one Undo) and it names the code lines.
197. [chunk 04 #17] BUG-657 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 8caecdbf, installed via PR #1378; no robot case.
198. [chunk 04 #18] BUG-656 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 4019cc7e, installed via PR #1379; no robot case.
199. [chunk 04 #19] BUG-655 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd (BUG-652 to 655 together), installed via PR #1317; an engineering-level risk, no robot case.
200. [chunk 04 #20] BUG-654 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd and finalizer 1bd133b9, installed via PR #1317; an engineering-level risk, no robot case.
201. [chunk 04 #21] BUG-653 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd and finalizer 1bd133b9, installed via PR #1317; an engineering-level risk, no robot case.
202. [chunk 04 #22] BUG-652 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixes 3373b6cd and c14f04c8 (Opus review HIGH), installed via PR #1317; an engineering-level risk, no robot case.
203. [chunk 04 #23] BUG-651 | ALREADY-FIXED | pilot-critical no | Commit 2c35de86 (PR #1311, Esc at "Proceed with import?" cancels) is on the 02a line; the Status still reads OPEN.
204. [chunk 04 #24] BUG-582 | ALREADY-FIXED | pilot-critical no | Commit ea85e9ee ("New Pipe flow line uses the level it has already calculated") is on the 02a line; Status was never updated.
205. [chunk 04 #25] BUG-581 | UNCLEAR | pilot-critical no | Cause not proven (Manager hand-off to AutoCAD prompts is only a hypothesis) and the entry itself asks for a reviewed workflow card before repair.
206. [chunk 04 #26] BUG-580 | INSTALLED-WAITING-PROOF | pilot-critical no | Codex look L3-01c PASS on installed Manager 1.1.54 and 1.1.56 (Light header readable); draft PR #1255 is not on the 02a line, so the fix that did it is not named; left OPEN for the desk.
207. [chunk 04 #27] BUG-579 | HAS-DRAFT | pilot-critical no | DRAFT PR #1909 (B-088) keeps the typed depth on a new footing; the Undo/Redo part is not traced and nothing was opened in AutoCAD.
208. [chunk 04 #28] BUG-578 | HAS-DRAFT | pilot-critical no | DRAFT PR #1930 (B-104) names the footing PF1 everywhere, after Tim's decision 157; built and unit-tested only.
209. [chunk 04 #29] BUG-577 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 65a1f723 on the 26s line, installed in Structural 1.0.121 via PR #1294; no robot case.
210. [chunk 04 #30] BUG-576 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1261, installed in Structural 1.0.121 per the Status line; the 24 Oct triage disagrees, so the install is not confirmed.
211. [chunk 04 #31] BUG-575 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix c64fa0c0 on the 26s line, installed via PR #1273; no robot case.
212. [chunk 04 #32] BUG-574 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix da006db6 (same commit as BUG-650) on the 02a line, installed in Civil 3.0.70; no robot case.
213. [chunk 04 #33] BUG-573 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix caa1db83 (trailing zeros), installed via PR #1283; the later "actual placed values" extension is not shown fixed, and the native case SCHED-DIFF-02 still reads FAIL from 15 Oct.
214. [chunk 04 #34] BUG-572 | ALREADY-FIXED | pilot-critical no | Commit 6f0423d7 (Inspector pipe type from the recorded pipe) is on the 02a line; the first-selection "all Unknown" and heading parts of the entry are not shown fixed.
215. [chunk 04 #35] BUG-571 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d49e7026, installed via PR #1289; Codex case E9-02 was NOT TESTED (setup blocked).
216. [chunk 04 #36] BUG-570 | ALREADY-FIXED | pilot-critical no | Merge 01734d59 (PR #1693, fix ae1566c6, Edit Pit picture shows the typed number) is on the 02a line; Status still reads OPEN.
217. [chunk 04 #37] BUG-279 | INSTALLED-WAITING-PROOF | pilot-critical no | Items 0 to 2 fixed in PRs #471, #476, #480 (commit b9b30a46 on the 26s line); items 3 and 4 were never measured; mixed entry, needs splitting.
218. [chunk 04 #38] BUG-360 | INSTALLED-WAITING-PROOF | pilot-critical no | PRs #560 and #1296 installed, plus 5ce92c32 (no handle in the schedule footer); the plan-level, CDCATCHMENT and locked-layer wording extensions are not shown fixed.
219. [chunk 04 #39] BUG-367 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #568 and fix 8595a6d2 (layers made inside the undo) installed in Structural 1.0.121; driver run 10 confirmed the fault on 1.0.93 only.
220. [chunk 04 #40] BUG-371 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX on Tim's yes (decision 178, 31 Oct): finalizer LOW findings, a record not a fault.
221. [chunk 04 #41] BUG-394 | ALREADY-FIXED | pilot-critical no | Merge 9ba5d9f6 (PR #686, one shared helper for the doubled default text) is on the 26s line; Status still reads OPEN.
222. [chunk 04 #42] BUG-417 | NEEDS-TIM | pilot-critical yes | X-Civil import: should it skip locked layers and say so, or ask once with a preview (his question list item 13)? Code already skips and says so (7e097226, PR #765) but the carpark says his ruling is pending.
223. [chunk 04 #43] BUG-418 | ALREADY-FIXED | pilot-critical no | Merge 035256a7 (PR #764, ruled by Tim 7 Oct, INT-065) is on the 26s line; not yet proven in AutoCAD.
224. [chunk 04 #44] BUG-419 | NEEDS-TIM | pilot-critical no | A bundle of 49 audit findings; several need his numbers (built-in velocity, cover, grade, council values) typed into Settings rows.
225. [chunk 04 #45] BUG-420 | ALREADY-FIXED | pilot-critical no | Merge f86bfadd (PR #766, fix ad231728) is on the 02a line; the 3.0.33 FAIL predates it; later follow-up is BUG-426.
226. [chunk 04 #46] BUG-421 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (decision 178): not a CE fault, stray text came from Codex brief wording.
227. [chunk 04 #47] BUG-422 | ALREADY-FIXED | pilot-critical no | Merge 09e1ccd1 (PR #769, fix 58c70165: unknown ground level now says cover not checked) is on the 02a line.
228. [chunk 04 #48] BUG-423 | NEEDS-TIM | pilot-critical no | Three places still carry his real login or PC name (old report files kept, Manager report contents, support-bundle file names): keep or change? The LOWs were fixed by #774 (032e9f44).
229. [chunk 04 #49] BUG-424 | UNCLEAR | pilot-critical no | Bundle of seven items; items 4 and 5 are merged (5f62039b, bd4c5363) and item 6 is covered by BUG-575, but items 1 to 3 and 7 were not traced.
230. [chunk 04 #50] BUG-425 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixes via PRs #783, #784, #811 and tests on the 02a line; the pilot does not use the Manager update channel, and the six Tim decisions listed are not shown as answered here.
231. [chunk 04 #51] BUG-426 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 93585d67 (PR #786) installed; no robot case.
232. [chunk 04 #52] BUG-427 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 9b234835 (PR #789, one shared FLAT label rule) installed; the Structural STRETCH-on-a-footing note was never investigated.
233. [chunk 04 #53] BUG-428 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 5beeb384 (PR #787) on the 26s line, installed in Structural 1.0.121; no robot case.
234. [chunk 04 #54] BUG-429 | NEEDS-TIM | pilot-critical no | Should an upgrade ever write new default rows into the settings file, or only when he changes a value? PR #799 only touched the start-up log line.
235. [chunk 04 #55] BUG-430 | HAS-DRAFT | pilot-critical yes | Installed but still fails (Codex look 19 Oct); DRAFT PR #1923 (B-110) stops the attribute editor first; the double-click feature stays OFF until Codex looks.
236. [chunk 04 #56] BUG-431 | NEEDS-TIM | pilot-critical no | Kingston rulebook: the file says "Issue 5, 2025, AS/NZS 3500.3:2021" but the council document on disk is Version 5 of Sept 2018 citing the 2015 edition; which is current needs checking against the source.
237. [chunk 04 #57] BUG-432 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 14253b67 (PR #820) and PR #809 installed; no robot case.
238. [chunk 04 #58] BUG-433 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 3fa0dcdc (PR #808) on the 26s line, installed in Structural 1.0.121; no robot case.
239. [chunk 04 #59] BUG-434 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge b664bb2c (PR #810, layer comes back after C1/TS1 cancel) installed; no robot case.
240. [chunk 04 #60] BUG-435 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge b2d8d14a (PR #826, Civil half) on the 02a line; the start-up "syntax error" line was never traced to its source.
241. [chunk 05 #1] BUG-436 | DUPLICATE-OF-BUG-061 | pilot-critical no | Status line already says duplicate of BUG-061 (a Codex result record), closed on Tim's yes 31 Oct.
242. [chunk 05 #2] BUG-437 | INSTALLED-WAITING-PROOF | pilot-critical yes | C1/TS1 "Enter means auto" fixed by PR #812 (merge c1c4cf81, Structural line) and the layer fix by #810; Codex W31 saw #810 pass, the Enter part not yet re-tested. The start-up "Menu item failed to load" lines are a separate profile problem, not fixed here.
243. [chunk 05 #3] BUG-438 | INSTALLED-WAITING-PROOF | pilot-critical yes | "DefaultValue is not set" fixed by PR #815 plus the finalizer commit 1fd75ab6; Codex W39 (the proof) is not written on the entry.
244. [chunk 05 #4] BUG-439 | INSTALLED-WAITING-PROOF | pilot-critical no | Two MEDIUMs fixed in 37a99f27 and installed (Structural 1.0.121, #798); the 350 mm lintel tolerance is a Settings value Tim was asked to confirm; a LOW wording fix 74a1f2d3 sits on a side branch awaiting review.
245. [chunk 05 #5] BUG-440 | INSTALLED-WAITING-PROOF | pilot-critical yes | Zero-length pipe on import fixed by PR #814 (commits 9c89763c, 36758ff0); Codex W38 saw it work on 3.0.39 but it is not Codex-accepted on the entry. Tim's AutoCAD template path pointing at a bisect test copy needs Tim or the desk (not CE code).
246. [chunk 05 #6] BUG-441 | INSTALLED-WAITING-PROOF | pilot-critical no | Finalizer record; fixes #794/#796 installed; "Roll Back" must not be offered to colleagues until one PC proves it, which is not proven.
247. [chunk 05 #7] BUG-442 | INSTALLED-WAITING-PROOF | pilot-critical yes | Support zip (856 bytes, one file) fixed by PR #816 and the FLAT window by #819 (merges 51353ad2, 793f0d8b); no AutoCAD retest recorded.
248. [chunk 05 #8] BUG-443 | NEEDS-TIM | pilot-critical no | Question for Tim: is the floor arrow order "Joists/Bearers/Subfloor" right, and is "DENOTES POST UNDER" the legend wording he wants? The feature is switched off and hidden.
249. [chunk 05 #9] BUG-444 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (finalizer LOW record), closed on Tim's yes 31 Oct; the rebuilt marker is tracked in BUG-445.
250. [chunk 05 #10] BUG-445 | INSTALLED-WAITING-PROOF | pilot-critical yes | Codex W35 and W36 PASS the one-U, 12-second wait, REDO case, but it is not recorded as Codex-accepted on the entry; "typed level waits for Stop overriding" is already Tim's ruling (9 Oct).
251. [chunk 05 #11] BUG-446 | INSTALLED-WAITING-PROOF | pilot-critical no | Stale red marker after Edit Pipe Save fixed by PR #823 (merge 800cab61); no AutoCAD retest. The 79 missing log lines are unexplained.
252. [chunk 05 #12] BUG-447 | INSTALLED-WAITING-PROOF | pilot-critical yes | Import keeps a short branch pipe open at its far end via PR #827 (merge 1a14029d, finalizer 319ba688); the real cure (the end-matching step) still needs its own reviewed change.
253. [chunk 05 #13] BUG-448 | INSTALLED-WAITING-PROOF | pilot-critical yes | Column label fix is commit 1fd75ab6, installed; Codex W39 not recorded. One side question (should Esc at "Enter a number" remove the column?) is for Tim.
254. [chunk 05 #14] BUG-414 | ALREADY-FIXED | pilot-critical no | Edit Pit now refuses a rename onto an existing number: commit a2d765af, PR #758 (merge edaa82d9, labelled BUG-408b). The Status line still says OPEN.
255. [chunk 05 #15] BUG-415 | UNCLEAR | pilot-critical no | Missing: whether PR #758 or the BUG-351 follow-up already covers the bare "8" wording and the "C 2" warning (the entry says "fix with BUG-414"); needs one code read.
256. [chunk 05 #16] BUG-416 | INSTALLED-WAITING-PROOF | pilot-critical yes | Right-click "Select this run" losing REDO: PR #1502 merged into train C-57 (863828c1); never proven by Codex (V1 was FAIL UNSURE on 3.0.65).
257. [chunk 05 #17] BUG-413 | INSTALLED-WAITING-PROOF | pilot-critical no | Hashed machine-report file name merged (PR #745, merge 2e8b8f34); the "Tim's call on the name" part is answered by the build, so Tim only needs to confirm.
258. [chunk 05 #18] BUG-412 | UNCLEAR | pilot-critical no | Four observations from an old run (3.0.32), never retested; missing: a fresh run on the current build (unsaved-record line after Esc, CDRULES METRE-A grade check).
259. [chunk 05 #19] BUG-411 | NEEDS-TIM | pilot-critical yes | Question for Tim: keep F2 running CLEAN with a visible name and a confirmation, or move it off F2? (The Team also still has to find where F2 is bound.)
260. [chunk 05 #20] BUG-409 | CLOSED-OR-WONT-FIX | pilot-critical no | Test incident; Tim's Structural settings file was restored on 5 Oct (hash matches the original) and a rule was added to the test briefs.
261. [chunk 05 #21] BUG-410 | UNCLEAR | pilot-critical no | Old W11 observations (BTX with nothing found is silent, typing BEAM runs BEAMLINKDEBUG, and others); missing: a retest with a corrected brief. The _Dot message item belongs with BUG-400.
262. [chunk 05 #22] BUG-408 | INSTALLED-WAITING-PROOF | pilot-critical no | "Stop overriding" sentence now shown in the fixed footer: commit db03f411 on the release line; not retested.
263. [chunk 05 #23] BUG-405 | ALREADY-FIXED | pilot-critical no | Structural scrub of SourceRoot/StatusSummary is PR #748 (be36a4fc), the usage-report drawing name is PR #757, and the Civil file name is commit 31721cc5 (BUG-413).
264. [chunk 05 #24] BUG-406 | ALREADY-FIXED | pilot-critical no | Markup-plan length readers fixed by PR #1781 and #1820 (merge 1f4f2633); not reachable from a drafter's normal commands.
265. [chunk 05 #25] BUG-407 | ALREADY-FIXED | pilot-critical no | CSFDNPROPOSE registered and OwnList used: commit dd1a784b, PR #738 (hidden, switched off).
266. [chunk 05 #26] BUG-404 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (PC housekeeping, not a drafter command), closed on Tim's yes 31 Oct. Tim's own Windows Search setting is still his to change.
267. [chunk 05 #27] BUG-403 | INSTALLED-WAITING-PROOF | pilot-critical yes | Paste from a drainage drawing into a Structural drawing now prints the CDREPAIR line: PR #1782 and #1821 merged (5bcb1f65, d4f0a85c); no Codex PASS on the entry.
268. [chunk 05 #28] BUG-402 | DUPLICATE-OF-BUG-354 | pilot-critical no | Status line says duplicate of BUG-354 (same start-up line), closed on Tim's yes 31 Oct.
269. [chunk 05 #29] BUG-401 | CLOSED-OR-WONT-FIX | pilot-critical no | Tim decided 5 Oct (INT-059/060): New Pit cover stays blank after restart; a "propose last cover" switch exists, off by default (commit a9334dfd).
270. [chunk 05 #30] BUG-399 | UNCLEAR | pilot-critical no | Observation only; missing: a probe at a known pick point, and Tim's pick-tolerance value (the FEDIT edge-pick rule itself was decided in INT-042).
271. [chunk 05 #31] BUG-400 | INSTALLED-WAITING-PROOF | pilot-critical no | Duplicate _Dot message on pit placement: PR #671 merged (de9a2d57); Codex W10c saw none but did not certify it.
272. [chunk 05 #32] BUG-398 | ALREADY-FIXED | pilot-critical no | Preview and issue now share one revision/date decision: commit a730f2fb, test 94da56da (Structural line).
273. [chunk 05 #33] BUG-397 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager load list fixed by PR #684 (merge 4120f03c); Codex W3-01 saw "3 of 3 tools running"; the "must match what is really loaded" check is not written down.
274. [chunk 05 #34] BUG-396 | FIXABLE-NOW | pilot-critical yes | Item 1: double-click on a placed schedule cell must open the Pit Schedule window at that cell (approved design); Codex L4-08 still saw AutoCAD's own editor on 3.0.56; no fix commit found. Item 6 is already fixed (PR #747).
275. [chunk 05 #35] BUG-395 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed on Tim's yes 31 Oct.
276. [chunk 05 #36] BUG-393 | ALREADY-FIXED | pilot-critical no | The four metre-length readers fixed by PR #659 and the remainder by #666 (0f07a2ec, 929b013b). BUG-406 covers a different four.
277. [chunk 05 #37] BUG-392 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct; its findings are tracked under their own ids.
278. [chunk 05 #38] BUG-391 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (desk driver run record), closed 31 Oct; its seven findings are meant to live under their own ids (I did not check each one has an entry).
279. [chunk 05 #39] BUG-390 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct.
280. [chunk 05 #40] BUG-389 | ALREADY-FIXED | pilot-critical no | CDCHECK list prints plain arrows: PR #634 (merge 507ca294). Status line still says OPEN.
281. [chunk 05 #41] BUG-388 | ALREADY-FIXED | pilot-critical no | Beam, FDELETE and related prompts show the default once: commits 1c2361fd and 8efbc89a (Structural line).
282. [chunk 05 #42] BUG-387 | ALREADY-FIXED | pilot-critical no | Current layer put back: PR #683 (merge 6637535e); driver run 22 did not reproduce it and Codex W10-03 saw the layer kept.
283. [chunk 05 #43] BUG-385 | INSTALLED-WAITING-PROOF | pilot-critical yes | Revert Row Override made a row vanish; fixed by PR #612/#617/#667 and Codex W6-02 and W7-03 saw PASS in AutoCAD (BUG-390, BUG-392), but the entry's own Status was never updated to Codex-accepted.
284. [chunk 05 #44] BUG-386 | NEEDS-TIM | pilot-critical no | Question for Tim: after "Stop overriding", does the typed cover level stay (recommended, and what is built) or does CE put its own figure back? CE 05 sent this to CE 04 on 1 Nov.
285. [chunk 05 #45] BUG-384 | ALREADY-FIXED | pilot-critical no | Status says FIXED (Claude-accepted, Civil 3.0.75, runner case R23); not Tim-confirmed.
286. [chunk 05 #46] BUG-383 | UNCLEAR | pilot-critical no | A fresh open marks the drawing changed; missing: a probe that finds which object or setting changes at open (cause unknown, LOW).
287. [chunk 05 #47] BUG-381 | ALREADY-FIXED | pilot-critical no | Opening and closing the Foundations manager no longer marks the drawing changed: PR #586 (d9149dc3), driver run 19 PASS. A leftover extra undo step is noted in BUG-391 item 4.
288. [chunk 05 #48] BUG-382 | ALREADY-FIXED | pilot-critical no | Structural plain-wording sweep: PR #597 (merge 5d692738).
289. [chunk 05 #49] BUG-380 | INSTALLED-WAITING-PROOF | pilot-critical yes | The pipe batch edit left Tim's snaps changed; fixed by e3ffe44b (PR #585, installed); the FEDIT edge pick is decided (INT-042), the other W3 notes are brief errors.
290. [chunk 05 #50] BUG-376 | INSTALLED-WAITING-PROOF | pilot-critical yes | Blank IL cells in the Pit Schedule now fall back to the plan level: dd307761 and 59aeb250 on the release line; no clean Codex PASS recorded.
291. [chunk 05 #51] BUG-377 | ALREADY-FIXED | pilot-critical no | Raw arrow code printed plain: commit 1a059b6d; driver run 22 saw CDRUNSOLVE plain.
292. [chunk 05 #52] BUG-378 | INSTALLED-WAITING-PROOF | pilot-critical no | First-open pipe upgrade race: PR #602 merged (32ef6d35); driver run 22 C4 PASS, no Codex PASS.
293. [chunk 05 #53] BUG-375 | ALREADY-FIXED | pilot-critical no | Item 1 (register and registry one list) is commit fac19d70; item 2 (an old runner brief file) is housekeeping I did not check.
294. [chunk 05 #54] BUG-374 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct; the Edit Pipe Cancel finding lives in BUG-373.
295. [chunk 05 #55] BUG-373 | INSTALLED-WAITING-PROOF | pilot-critical no | Edit Pipe then Cancel no longer marks the drawing changed: PR #1663 (merge cd2cabb8); unnamed-control leftovers belong to the BUG-365 family.
296. [chunk 05 #56] BUG-372 | INSTALLED-WAITING-PROOF | pilot-critical no | Handle half passed on 3.0.57 (run 33) and PR #1835 merged; the "(on the block Drawing Border)" half is still seen and is tracked under BUG-141 and BUG-816.
297. [chunk 05 #57] BUG-370 | INSTALLED-WAITING-PROOF | pilot-critical no | Kind column plain English: PR #570 (merge 7b353319); undo counts all passed in driver run 11.
298. [chunk 05 #58] BUG-369 | INSTALLED-WAITING-PROOF | pilot-critical no | Frozen-layer plain line: PR #571 (merge af6eebf5); remaining notes are LOW.
299. [chunk 05 #59] BUG-368 | INSTALLED-WAITING-PROOF | pilot-critical yes | Extra Undo step inside typed Structural commands removed: PR #569 (merge 30c7c72b); driver run 11 saw one U work, no Codex-accepted entry.
300. [chunk 05 #60] BUG-366 | INSTALLED-WAITING-PROOF | pilot-critical yes | Quiet paste catcher is PR #567 (merge 0eff93d4); the CSREOBAR missing-layer fault fix is not confirmed by me (commit e2be93ab is about undo marks, not layers).
301. [chunk 06 #1] BUG-365 | INSTALLED-WAITING-PROOF | pilot-critical no | Status says fix installed via PR #578-580; git has 11 BUG-365 commits (driver run 15 names); one leftover (Structural telemetry carries real UserName/MachineName, Civil anonymises) should be checked against the privacy rule.
302. [chunk 06 #2] BUG-364 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #561 installed; the raw-handle wording on first locked move is listed as fixed by the finalizer in a later entry; the CPU part is the driver, not CE.
303. [chunk 06 #3] BUG-363 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #561 installed; item 1 (old copy pit MOVE rewords the original's labels) already PASSED in real AutoCAD, driver run 14, nothing Tim-accepted; items 2 to 4 are LOW.
304. [chunk 06 #4] BUG-362 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #562, #563 inside Structural 1.0.114/1.0.121; item 2 (reo bar units) says "settle before CSREOBAR is un-hidden", a hidden command.
305. [chunk 06 #5] BUG-361 | CLOSED-OR-WONT-FIX | pilot-critical no | Two dumps and the Codex and driver CPU runs show the 1 core is the screen-reading client, not CE; the Status line still says OPEN, so a closing "not CE" needs Tim's yes like BUG-326 got.
306. [chunk 06 #6] BUG-359 | CLOSED-OR-WONT-FIX | pilot-critical no | Status says "closed as driver" (confirmed by the BUG-361 dump); only LOW side items remain.
307. [chunk 06 #7] BUG-358 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #558 (git: "ERASE + FREGENALL is two U") and the driver run 6 in BUG-364 shows two U passing; finding 2 (pipe left detached when pit layer locked) is an unanswered design question.
308. [chunk 06 #8] BUG-357 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #557; the driver run in BUG-364 shows the line printed and labels staying "1 IN 100" with the pipe layer locked; nothing Codex-accepted.
309. [chunk 06 #9] BUG-356 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #556, 6 git commits; What's New is modeless and first-launch only per BUG-364; the acceptance ledger still notes it opens at every robot start because of the settings guard.
310. [chunk 06 #10] BUG-355 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #555, #639; Structural line has "FEDIT on CE's outline edits the nearest footing" (fa79444f, bc636eea), decided by Tim INT-042.
311. [chunk 06 #11] BUG-354 | NEEDS-TIM | pilot-critical no | The fault is in Tim's own AutoCAD profile file (ce_suite_startup.lsp), not in the repo; question: may the old (ce:load-strucplus-lisp) call be removed from your profile, and do colleagues' PCs get the same clean-up at rollout?
312. [chunk 06 #12] BUG-353 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #577, #582, #589; git has the C-9 item 1 fix (78e254b2) and the ARRAY line fix (c4ba9b6c); LOW items 4 to 6 not individually checked.
313. [chunk 06 #13] BUG-352 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #553, #554; Structural line has items 1 and 3 (85ff8893, 50d7d27f); items 2, 4, 5 are speed notes.
314. [chunk 06 #14] BUG-351 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #660, #670, #805, 27 git commits; narrow connected-end write PASSED Codex 14 Oct, but the entry itself says it does not close 351 (C2 rename, unconnected end, ARRAY remain); Tim answered (a) and (b).
315. [chunk 06 #15] BUG-350 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #550, #551, 9 git commits (items 7 and 9 visible); items 8, 10, 11 (PIT scale in metre drawings, older-pipe prompts, tooling) are not confirmed fixed.
316. [chunk 06 #16] BUG-349 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #546 inside Structural 1.0.114; items 1 to 4 fixed, item 5 is a design note and item 6 LOWs stay open.
317. [chunk 06 #17] BUG-348 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #545 inside Structural 1.0.114; Tim's INT-026 ruling already met; open items are MED/LOW unit-detection edge cases.
318. [chunk 06 #18] BUG-347 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 5704b6ae; entry is mostly Codex blocks, and its ARRAY item is the BUG-342/350 family.
319. [chunk 06 #19] BUG-346 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #549, #591, #592, 6 git commits (copy-label fixes visible).
320. [chunk 06 #20] BUG-345 | CLOSED-OR-WONT-FIX | pilot-critical no | Status: WONT FIX test tooling, closed on Tim's yes 31 Oct (decision 178).
321. [chunk 06 #21] BUG-344 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #542, #547 inside Structural 1.0.114; Tim's INT-026 "Convert units automatically".
322. [chunk 06 #22] BUG-343 | INSTALLED-WAITING-PROOF | pilot-critical no | Status line was never updated (still "OPEN 2 Oct"), but git has the split-pipe grade lock fix (027a8b51), the Repair Center regroup (e8916136) and the flat-pipe repair (760aded0), all in PR #513/#508; items 2 and 3 not individually checked.
323. [chunk 06 #23] BUG-342 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #567 (quiet paste), 3 git commits, Tim said "PASTE - YEP" (INT-048); a later entry (BUG-403) found it failing into a Structural drawing, and items 2 to 6 are separate.
324. [chunk 06 #24] BUG-341 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 1bf49237 in Structural 1.0.121; HIGH item is a corner grip turning a pad into a kite; nothing driven in AutoCAD.
325. [chunk 06 #25] BUG-340 | UNCLEAR | pilot-critical yes | Status says "items 1-6 (+9) to builder" and no PR is named; BUG-350's "passed" list shows the lowest-arrival Carry downstream, so some are fixed; needs a per-item read against C-7/C-8 commits before anyone builds.
326. [chunk 06 #26] BUG-339 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #538 (1 git commit); BUG-350's reviewer saw batch Apply working for most grades headless, no real-AutoCAD proof.
327. [chunk 06 #27] BUG-338 | NEEDS-TIM | pilot-critical no | Items 1 to 3 have fixes in git (027a8b51, 6bdde2c1); item 4 is marked "RULING FOR TIM": should CE draw true size in a real metre drawing (a DN300 pipe is a band 300 m wide today); all four office templates read mm, so the office is not hit.
328. [chunk 06 #28] BUG-337 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #508; metre drawing only, attribution unresolved by Codex.
329. [chunk 06 #29] BUG-336 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #523-525 inside Structural 1.0.114; items are Escape-undo, locked-outline wording, speed.
330. [chunk 06 #30] BUG-335 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #529-531; same family as BUG-334 and BUG-333, which carry the proof.
331. [chunk 06 #31] BUG-334 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #521, #522, #532; item 1 (one U takes back CE's redraw not the edit) was measured as one U in the 2027 core console, full AutoCAD not driven.
332. [chunk 06 #32] BUG-333 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #536, #539, #541; item 3 (LOADPATH in a metre drawing) says "Tim decides" measure nothing or convert.
333. [chunk 06 #33] BUG-332 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #512; LOW leftovers.
334. [chunk 06 #34] BUG-331 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #516, #646, 16 git commits covering items 1 to 5; metre drawings only.
335. [chunk 06 #35] BUG-330 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #627 merged (bab2dcaf); metre drawings only.
336. [chunk 06 #36] BUG-329 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #626; git has items 2 and 3 (4d78cd6f, 4f2430e3).
337. [chunk 06 #37] BUG-328 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #508, #513, 17 git commits (23fe830f and the repair); metre drawings only.
338. [chunk 06 #38] BUG-326 | CLOSED-OR-WONT-FIX | pilot-critical no | WONT FIX, AutoCAD's own fatal error from a Codex LAYER script, closed on Tim's yes 31 Oct.
339. [chunk 06 #39] BUG-325 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #507, 2 git commits; OOPS line wording.
340. [chunk 06 #40] BUG-324 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #507; BUG-339 says the older pipe is now left out with a plain line.
341. [chunk 06 #41] BUG-323 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #491, #507, 7 git commits; metre drawing display.
342. [chunk 06 #42] BUG-322 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #626; git has item 2 (4f2430e3); item 1 is metre-drawing label offsets.
343. [chunk 06 #43] BUG-321 | NEEDS-TIM | pilot-critical no | Status OPEN, no PR; label offsets in a metre drawing wait on the same true-size ruling as BUG-338 item 4 (the BUG-287 question); plus test-tooling leftovers that belong with BUG-318.
344. [chunk 06 #44] BUG-320 | UNCLEAR | pilot-critical no | Items 1 and 4 have fixes (PR #501 PasteCheck lines, PR #638); items 2 and 3 (CDREPAIR leaves the old pit number on a pasted label, wording of the locked-layer sentence) have no commit I could find and the status line was never updated.
345. [chunk 06 #45] BUG-319 | UNCLEAR | pilot-critical no | No PR named; commit 7f8e2249 (BUG-308) makes CDCALC's areas win, which may cover item 1; items 2 and 3 are hypothetical.
346. [chunk 06 #46] BUG-318 | INSTALLED-WAITING-PROOF | pilot-critical no | Test tooling; PR #644, #649, #677 named, and the Structural line's RibbonPresentationTests.cs now only writes to docs when CE_UPDATE_DOC_SCREENSHOTS=1 (I did not find the commit); proof is a clean git diff after a test run.
347. [chunk 06 #47] BUG-317 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #497, #502, 6 git commits; scaled pits in metre drawings.
348. [chunk 06 #48] BUG-316 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #504; Structural line has item 2 (c126f1df).
349. [chunk 06 #49] BUG-315 | NEEDS-TIM | pilot-critical no | Items 2 and 3 are fixed in the Structural line (d72c574a, e07e99b3); item 1 is still Tim's question: with DIMSCALE 0 and CANNOSCALE 1:1, keep the schedule text at 2.5 units or fall back to a 1:100 sheet height?
350. [chunk 06 #50] BUG-314 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #505 merged into train S-7 (bd920fbc); LOW footing-memory items.
351. [chunk 06 #51] BUG-313 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503, 4 git commits; native locked-layer check still never run in a real drawing per BUG-322 item 4.
352. [chunk 06 #52] BUG-312 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503; commit 7a47f825 keeps held-back labels in the drawing's CE record.
353. [chunk 06 #53] BUG-311 | NEEDS-TIM | pilot-critical no | Status OPEN, no PR; the entry itself says it needs Tim's decision: when CDRUNSOLVE/CDPROPAGATE is cancelled, accept that a palette edit made meanwhile is rolled back too, or make palette edits wait?
354. [chunk 06 #54] BUG-310 | UNCLEAR | pilot-critical no | The entry says "edge, not confirmed possible" (two objects sharing one identity key); needs a probe to show whether it can happen before anyone builds.
355. [chunk 06 #55] BUG-309 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503; git 0a1271c8 labels the grade in the drawing's own units.
356. [chunk 06 #56] BUG-308 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #497, 5 git commits; items (b) pipe landing at pit centre and (d) which tabs carry Save Draft are still "check or Tim's ruling".
357. [chunk 06 #57] BUG-307 | DUPLICATE-OF-BUG-095 | pilot-critical no | Status says duplicate of BUG-095 (red Glen Eira back-test), closed on Tim's yes 31 Oct; the engineering cause is tracked under BUG-095/BUG-872.
358. [chunk 06 #58] BUG-306 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #501, #638 (git d4c78c61): pit placing leaves CD_Settings.json byte-identical; a W8-09 partial PASS is recorded in a later entry.
359. [chunk 06 #59] BUG-305 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #501, 7 git commits (one [PasteCheck] summary per paste).
360. [chunk 06 #60] BUG-304 | UNCLEAR | pilot-critical no | Status OPEN 1 Oct and the entry's own correction says it is stale since S-4; what is missing is a check on AutoCAD 2024/2025/2026 (no 2024 on this PC) and real-window grip edits.
361. [chunk 07 #361] BUG-303 | INSTALLED-WAITING-PROOF | no | Several small items; commits 2e6d5e27 and 54be6df6 on the Structural line and PRs #494, #510 installed in 1.0.121; each item still needs checking against the PR.
362. [chunk 07 #362] BUG-302 | INSTALLED-WAITING-PROOF | no | Commit 2ead5192 (PR #495) makes the FADOPT label search 1.5 m in any unit; it says "code half", so the wording half (ruling not in decisions) is unchecked.
363. [chunk 07 #363] BUG-300 | UNCLEAR | no | Code redraws on the next footing command only; a tranche-3 batch (t3) waits on a robot check to see if OOPS needs its own redraw, and that result is not in the folder.
364. [chunk 07 #364] BUG-299 | INSTALLED-WAITING-PROOF | yes | Commit 93e3f3b0 (PR #493): an unfinished settings save is put back at start; a lost settings file would hit colleagues.
365. [chunk 07 #365] BUG-298 | INSTALLED-WAITING-PROOF | no | CDFIXPIPEENDS atomic repair is in commit 71980a7f (PR #490), though the carpark line still says OPEN.
366. [chunk 07 #366] BUG-297 | INSTALLED-WAITING-PROOF | no | Pit lookup reach is in commit 337b56ce (C-5, PR #491), though the carpark line still says OPEN.
367. [chunk 07 #367] BUG-296 | INSTALLED-WAITING-PROOF | no | Remaining millimetre distances are covered by commit 337b56ce (C-5); the full list is in the PR #478 body, not re-checked.
368. [chunk 07 #368] BUG-295 | UNCLEAR | no | Entry says all items need measuring in AutoCAD first; the 24 Oct triage lists it as a close candidate (test-tool item), so Tim or CE 00 must decide to close or measure.
369. [chunk 07 #369] BUG-294 | INSTALLED-WAITING-PROOF | no | Shared temp-folder fixture is in commit 26321e13 (PR #483); entry says not closed until a test run leaves Tim's real settings file untouched.
370. [chunk 07 #370] BUG-293 | INSTALLED-WAITING-PROOF | yes | Grade strip in metre drawings fixed by commits 337b56ce and 8866b09a (BUG-323); a wrong grade shows on every Edit Pipe in a metre drawing.
371. [chunk 07 #371] BUG-292 | INSTALLED-WAITING-PROOF | yes | Record-order fill is in commit 8eb5b113 (C-5); a plain Save reversing a downstream-first pipe is a wrong-level risk.
372. [chunk 07 #372] BUG-291 | INSTALLED-WAITING-PROOF | yes | Direction-aware Design grade is in commit 8eb5b113; a pipe turning round on Design grade is a wrong-level risk.
373. [chunk 07 #373] BUG-290 | INSTALLED-WAITING-PROOF | no | Refresh respects typed levels in commit 8eb5b113, plus BUG-650 commit da006db6; the five commands named in the entry were not each checked.
374. [chunk 07 #374] BUG-289 | INSTALLED-WAITING-PROOF | no | Repair refreshes the schedule in commit 8eb5b113 (PR #492).
375. [chunk 07 #375] BUG-288 | INSTALLED-WAITING-PROOF | no | Open-end rescan is back in commit 71980a7f (PR #490), and a later guard commit a6969702 keeps it wired.
376. [chunk 07 #376] BUG-287 | INSTALLED-WAITING-PROOF | yes | Mixed-units warning built in 337b56ce and 6bdde2c1 (works both ways); Tim's ruling on what the office does with such drawings is not recorded.
377. [chunk 07 #377] BUG-286 | INSTALLED-WAITING-PROOF | no | Locked-pit CD is in commit 71980a7f (PR #490).
378. [chunk 07 #378] BUG-285 | INSTALLED-WAITING-PROOF | yes | Pipe OOPS comes back with its record in commit 71980a7f (PR #490); a pipe returning bare looks like data loss.
379. [chunk 07 #379] BUG-284 | INSTALLED-WAITING-PROOF | no | Locked-layer write audit is commit 116ac434 (PR #489).
380. [chunk 07 #380] BUG-283 | UNCLEAR | no | Carpark says installed (PR #489), the 24 Oct triage says not installed; the 2 Nov Civil code no longer unlocks layers (BUG-417 comment at XcivilImportService.cs:1580), so check BUG-417 and the DLL; the skip-or-ask rule was queued as a question for Tim.
381. [chunk 07 #381] BUG-282 | INSTALLED-WAITING-PROOF | no | One rulebook cover value everywhere is in commit 337b56ce (PR #470).
382. [chunk 07 #382] BUG-281 | INSTALLED-WAITING-PROOF | no | Downpipe radius stored in millimetres is in commit 337b56ce (PR #491).
383. [chunk 07 #383] BUG-280 | UNCLEAR | no | Controller accepted two copies until the V3 cutover (1 Oct); the triage says it needs an Opus plan, so it is not due and no builder brief exists.
384. [chunk 07 #384] BUG-278 | INSTALLED-WAITING-PROOF | yes | Edit Pipe Save keeps the recorded direction in commits eb28feca and 1ef0fcaa (PR #469); a rewritten flow direction is a wrong-level risk.
385. [chunk 07 #385] BUG-277 | INSTALLED-WAITING-PROOF | no | Live bar length on grip stretch is in commits 060fbd6c and 64b57efc (Structural line).
386. [chunk 07 #386] BUG-276 | INSTALLED-WAITING-PROOF | no | Commits 841c35ec and 1c86ac7d on the Structural line; the carpark line still says built, not installed, so install state is unconfirmed.
387. [chunk 07 #387] BUG-274 | INSTALLED-WAITING-PROOF | no | U/REDO no longer re-queue footing drivers, commit cb17de15 (Structural line).
388. [chunk 07 #388] BUG-273 | INSTALLED-WAITING-PROOF | no | Plain job-file save failure line is in commits 61f2b1ad and 9dda7272 (PR #455, #467).
389. [chunk 07 #389] BUG-272 | INSTALLED-WAITING-PROOF | no | Newtonsoft method-not-found fix with a source guard is in commit a7833986 (PR #455).
390. [chunk 07 #390] BUG-275 | INSTALLED-WAITING-PROOF | no | Palette compares the document, not the database, commits f57033d6 and 2e6e730b (PR #464).
391. [chunk 07 #391] BUG-271 | INSTALLED-WAITING-PROOF | yes | Remaining millimetre reaches converted in commit 28d41fd9 (PR #470); a wrong reach in metre drawings gives missed links.
392. [chunk 07 #392] BUG-270 | INSTALLED-WAITING-PROOF | yes | Pit search reach converted to drawing units, commits 777845f3 and a4c48912 (PR #453); a metre drawing searched 100 m before.
393. [chunk 07 #393] BUG-269 | INSTALLED-WAITING-PROOF | no | Batched clean-up for -ARRAY with timing line, commits dfed4d03 and b7fc3dc8 (PR #458); the 48.8 s gain was not measured.
394. [chunk 07 #394] BUG-268 | INSTALLED-WAITING-PROOF | yes | CDFIXPIPEENDS repairs already-wrong copied pipes, commits 10fb2ba4 and 9020c48a (PR #444, #460); wrong pipes stay wrong until it is run.
395. [chunk 07 #395] BUG-267 | INSTALLED-WAITING-PROOF | no | OOPS returns a pit with labels and record, commit 10fb2ba4 (PR #443, #460).
396. [chunk 07 #396] BUG-266 | INSTALLED-WAITING-PROOF | no | Far pit COPY no longer rescans every open-end pipe, commit 146e2bf3 (PR #450).
397. [chunk 07 #397] BUG-265 | INSTALLED-WAITING-PROOF | no | Structural commits bc7b86b6 and 757ed4cf (PR #445) cover the debug lines; the "RESTART RECOMMENDED" text still exists in code, so that part is unproven.
398. [chunk 07 #398] BUG-264 | INSTALLED-WAITING-PROOF | no | Annotate flyouts fit a 1080-pixel screen, commit 62323dee (PR #456).
399. [chunk 07 #399] BUG-263 | INSTALLED-WAITING-PROOF | no | XCLMTXT review shows its waiting issue, commit 057883e0 (PR #446).
400. [chunk 07 #400] BUG-262 | INSTALLED-WAITING-PROOF | no | Locked and skipped items are named, commit 56501175 (PR #454).
401. [chunk 07 #401] BUG-261 | INSTALLED-WAITING-PROOF | yes | One upstream rule for Edit Pipe, commit 7bad3dfb (PR #444); the false uphill warning would mislead colleagues.
402. [chunk 07 #402] BUG-260 | INSTALLED-WAITING-PROOF | yes | Fix in commits 56501175 and 181d69cb (PR #454); the carpark status line still says OPEN and was never updated.
403. [chunk 07 #403] BUG-259 | INSTALLED-WAITING-PROOF | no | CDDESIGN Confirm setup keeps the outlet, commit c20f10d7 (PR #448).
404. [chunk 07 #404] BUG-258 | INSTALLED-WAITING-PROOF | no | PD text restored on OOPS, commit 0f0feb1b (PR #443).
405. [chunk 07 #405] BUG-257 | INSTALLED-WAITING-PROOF | yes | No write at close unless the record is the only unsaved change, commits d8b0b727 and 0e52afc3 (PR #442).
406. [chunk 07 #406] BUG-256 | DUPLICATE-OF-BUG-558 | no | Entry says the general case passed Codex W35 and the residual REDO cases are tracked as BUG-558 and BUG-861.
407. [chunk 07 #407] BUG-255 | INSTALLED-WAITING-PROOF | no | Edit Pipe cover comes from the rulebook, commit 28d41fd9 (PR #437, #470).
408. [chunk 07 #408] BUG-254 | INSTALLED-WAITING-PROOF | yes | Layer unlock removed from record writes, commits eb28feca and 3d0859b2 (PR #469); changing a locked layer breaks the native protection rule.
409. [chunk 07 #409] BUG-253 | INSTALLED-WAITING-PROOF | no | One pipe batch preflight, commit 7e756b07 (PR #648); behaviour unchanged, no AutoCAD step.
410. [chunk 07 #410] BUG-252 | INSTALLED-WAITING-PROOF | no | Roughness matches whole words, commit 65a842de (PR #632); whether any silent 0.013 fallback remains was not checked.
411. [chunk 07 #411] BUG-251 | INSTALLED-WAITING-PROOF | yes | Kingston commercial PSD 1 in 10, Tc 7 min, pre-development C, commit 000bc604 (PR #433, #803); a wrong council figure on a sheet.
412. [chunk 07 #412] BUG-250 | INSTALLED-WAITING-PROOF | no | Beam relink after OOPS with linking ON, commits 4dbc3820 and 73229f5e (PR #466); Tim's answer on whether OOPS should also bring the beam back (match Civil) is not recorded.
413. [chunk 07 #413] BUG-249 | NEEDS-TIM | yes | Boyd's rows are still fixed (BoydsCalcViewModel.cs:120 on the 2 Nov line); needs a command card and Tim's approval before any change.
414. [chunk 07 #414] BUG-248 | DUPLICATE-OF-BUG-258 | no | Same fault (OOPS after erasing a perimeter drain loses the PD text), same fix, PR #443.
415. [chunk 07 #415] BUG-247 | ALREADY-FIXED | no | Commit e8dd6631 (tests only) rewrote the two Manager payload tests; I did not run them.
416. [chunk 07 #416] BUG-246 | INSTALLED-WAITING-PROOF | no | Pit Schedule window finds cells kept as drawn, commits 50e14003 and 2175f147 (PR #658, #807).
417. [chunk 07 #417] BUG-244 | INSTALLED-WAITING-PROOF | yes | Automatic relink reads levels like Edit Pipe, commit 6282634c (PR #654); an open-end pipe could run uphill after an IL edit.
418. [chunk 07 #418] BUG-245 | NEEDS-TIM | yes | Which wins for a pit-to-open-end pipe when the drawn order and levels disagree; no commit and the triage lists it for Tim.
419. [chunk 07 #419] BUG-242 | INSTALLED-WAITING-PROOF | no | Inspector re-measures the raingarden area, commit 11c6d234 (PR #635).
420. [chunk 07 #420] BUG-243 | INSTALLED-WAITING-PROOF | no | Overlay label height in drawing units, commit 01bd5b91 (PR #633).
421. [chunk 08 #421] BUG-239 | INSTALLED-WAITING-PROOF | pilot-critical no | Council sources in words fixed by #629 (5d3dc9a9, 2d420688), in Civil 3.0.70; no robot or Codex run yet.
422. [chunk 08 #422] BUG-202 | UNCLEAR | pilot-critical no | Lag was mostly Tim's PC and AutoCAD itself; the two real CE faults were split into BUG-203 and BUG-204; missing: a fresh lag report on a current build to decide whether to close it.
423. [chunk 08 #423] BUG-224 | INSTALLED-WAITING-PROOF | pilot-critical yes | Crash on closing a drawing after Save As: fix c3e3cc48 and guard test #753 are on the release line, but the crash was never reproduced or re-run and the dump was never read; installed state not checked.
424. [chunk 08 #424] BUG-225 | FIXABLE-NOW | pilot-critical no | Pit tab Close button leaves the pit selected while the typed command works; expected result is clear and no fix commit exists.
425. [chunk 08 #425] BUG-226 | INSTALLED-WAITING-PROOF | pilot-critical no | Discipline button hover text fixed by #624 (511e9b20), Civil 3.0.70.
426. [chunk 08 #426] BUG-227 | INSTALLED-WAITING-PROOF | pilot-critical no | Settings hover text fixed by #625 (8520fa12), Civil 3.0.70.
427. [chunk 08 #427] BUG-228 | INSTALLED-WAITING-PROOF | pilot-critical no | CDDIAG words and tooltip fixed by #622 (222232ef), Civil 3.0.70.
428. [chunk 08 #428] BUG-229 | FIXABLE-NOW | pilot-critical no | Duplicate Draw Order rows still seen on 3.0.80 (Codex look F5); the carpark's "installed via #622" is a wrong link; expected is each layer once, so a builder can remove repeats on load.
429. [chunk 08 #429] BUG-240 | CLOSED-OR-WONT-FIX | pilot-critical no | Closed WONT FIX on Tim's yes (decision 178, 31 Oct 2026): a record of his AutoCAD profile, not a product fault.
430. [chunk 08 #430] BUG-238 | CLOSED-OR-WONT-FIX | pilot-critical no | WONT FIX: the finding was read from a private copy of the registry, Tim's real profile was fine.
431. [chunk 08 #431] BUG-235 | FIXABLE-NOW | pilot-critical no | A copied pit can steal a pipe end from the original; the plan already says stable identity beats proximity and the rule for an exact overlap is a plain warning; no fix commit found.
432. [chunk 08 #432] BUG-236 | INSTALLED-WAITING-PROOF | pilot-critical no | PD1 tag now follows its drain: #426 (a1489b44, d2c90661), Civil 3.0.70.
433. [chunk 08 #433] BUG-237 | INSTALLED-WAITING-PROOF | pilot-critical no | OOPS after erasing a column relinks beams: #428 (010b5acc, 05028608) in Structural 1.0.121.
434. [chunk 08 #434] BUG-234 | INSTALLED-WAITING-PROOF | pilot-critical no | Moved or gripped flat pipe records the new pits: #645 (f98ccde8), Civil 3.0.70.
435. [chunk 08 #435] BUG-233 | INSTALLED-WAITING-PROOF | pilot-critical no | Orifice line source in words: #420 (4c85a268, cd18a9eb), Civil 3.0.70.
436. [chunk 08 #436] BUG-232 | INSTALLED-WAITING-PROOF | pilot-critical no | Schedule refresh skips locked, Xref and REFEDIT cells: #423 (89ad7a0e), Civil 3.0.70.
437. [chunk 08 #437] BUG-230 | INSTALLED-WAITING-PROOF | pilot-critical no | PAVE and site-area readers use drawing units: #421 (2ac8999a), Civil 3.0.70; the open question of what INSUNITS Tim's office templates use is still unanswered.
438. [chunk 08 #438] BUG-231 | INSTALLED-WAITING-PROOF | pilot-critical no | AutoCAD shutdown no longer forces a write: #636 (d96b721b), Civil 3.0.70.
439. [chunk 08 #439] BUG-223 | INSTALLED-WAITING-PROOF | pilot-critical no | CDEDIT between two open ends follows the levels: b99851bd, #404 and #422, Civil 3.0.70.
440. [chunk 08 #440] BUG-203 | INSTALLED-WAITING-PROOF | pilot-critical no | Civil stays quiet in a Structural drawing: #393 (e51920d9); Codex was blocked because the test drawing was a Civil one.
441. [chunk 08 #441] BUG-204 | INSTALLED-WAITING-PROOF | pilot-critical no | Structural settings file stops growing: #399 (4e88c6e5), Structural 1.0.121.
442. [chunk 08 #442] BUG-205 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe between two open ends goes downhill: #404, Civil 3.0.70.
443. [chunk 08 #443] BUG-206 | UNCLEAR | pilot-critical no | OSMODE ended at 0 after a long run and no command was blamed; BUG-380 (e3ffe44b) fixed one snap-restore leak but nobody shows it is this one; missing: a repeat that names the command.
444. [chunk 08 #444] BUG-207 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 15 Oct 2026, Codex-accepted for the original one-Undo defect (commits 0ffa1231, 3868e1c9); grip and open-end routes were not retested.
445. [chunk 08 #445] BUG-208 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pipe end grip refused linked records: #410 plus later rounds (f1f9fa43, 82abe627), Civil 3.0.70; wrong links on a stretched pipe would reach a job.
446. [chunk 08 #446] BUG-209 | INSTALLED-WAITING-PROOF | pilot-critical yes | Catchment area was a million times too big and gave a false overload warning: fixed by 17b88211 (#411), Civil 3.0.70.
447. [chunk 08 #447] BUG-210 | INSTALLED-WAITING-PROOF | pilot-critical yes | Copied pit onto an erased pit's junction now links at once: #417 (06aaf868), Civil 3.0.70.
448. [chunk 08 #448] BUG-211 | INSTALLED-WAITING-PROOF | pilot-critical no | Erasing a column tells its beam: #415 (dbceb3d4, e03fafb3), Structural 1.0.121; Tim's workflow question (ask per beam) was part of the design check.
449. [chunk 08 #449] BUG-212 | INSTALLED-WAITING-PROOF | pilot-critical no | Placing a schedule on an older pit: #419 (f44f4d2d, 6e2aeda4), Civil 3.0.70.
450. [chunk 08 #450] BUG-213 | FIXABLE-NOW | pilot-critical yes | Older schedule has no enabled "replace" button (Codex FAIL again on 3.0.49); expected is a Replace older schedule action with preview and one U, and no fix commit found, only the legacy-cell commits 9cf10ffd and 4c433dbf.
451. [chunk 08 #451] BUG-214 | INSTALLED-WAITING-PROOF | pilot-critical no | CEFIND then Esc no longer marks the drawing changed: #416 (2dd5d47b, ae62eb2d), Civil 3.0.70.
452. [chunk 08 #452] BUG-215 | INSTALLED-WAITING-PROOF | pilot-critical no | RC needs one U: #418 (2c832e96, 4fc3d542), Structural 1.0.121; Codex saw a PASS on 15 Oct but the entry is not marked accepted.
453. [chunk 08 #453] BUG-216 | INSTALLED-WAITING-PROOF | pilot-critical no | CDFALLSUGGEST Enter finishes: f85c1f9e (#416), Civil 3.0.70; Codex accepted only one narrow Enter route on 14 Oct.
454. [chunk 08 #454] BUG-217 | INSTALLED-WAITING-PROOF | pilot-critical no | Perimeter drain draws its own PD tag: #417 (3ed1def2), Civil 3.0.70.
455. [chunk 08 #455] BUG-218 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 14 Oct 2026, Codex-accepted narrow PASS on Structural 1.0.116 (b0806aed); docked-Hub route not covered.
456. [chunk 08 #456] BUG-219 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager status bar shows the running version: #497 (31689f09), Civil 3.0.70.
457. [chunk 08 #457] BUG-220 | INSTALLED-WAITING-PROOF | pilot-critical no | Structural launcher no longer pops up at start: #465 (e6ceb972, b4ddbdb4), Structural 1.0.121.
458. [chunk 08 #458] BUG-221 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 19 Oct 2026, Codex-accepted look L3-01a and L3-01b (2f855c9c).
459. [chunk 08 #459] BUG-222 | NEEDS-TIM | pilot-critical no | Civil settings form scrolls the whole way; Tim's rule says use tabs but nobody has settled which settings go on which tab.
460. [chunk 08 #461] BUG-194 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe tab only for real CE pipes: #380 (381405f1), Civil 3.0.70.
461. [chunk 08 #462] BUG-193 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 30 Sep 2026, Codex-accepted for an ordinary pit only; the P6 900 x 900 case was not tested.
462. [chunk 08 #463] BUG-192 | DUPLICATE-OF-BUG-256 | pilot-critical yes | The entry's own status says it is tracked under BUG-256, BUG-558 and BUG-861; v2 proof work (#414) is on the release line; REDO after U is still the open symptom.
463. [chunk 08 #464] BUG-191 | INSTALLED-WAITING-PROOF | pilot-critical no | Use plan label is one named Undo: bb472399 (#359), Civil 3.0.70.
464. [chunk 08 #465] BUG-190 | ALREADY-FIXED | pilot-critical yes | Carpark status FIXED 29 Sep 2026, Codex-accepted (pass 17 Q4: Ctrl+S, close and reopen kept the data).
465. [chunk 08 #466] BUG-189 | ALREADY-FIXED | pilot-critical yes | Carpark status FIXED 30 Sep 2026 on Tim's word plus Codex timing; Structural timing is a separate lane.
466. [chunk 08 #467] BUG-188 | INSTALLED-WAITING-PROOF | pilot-critical no | CE Blocks attribute tags: PR #333 (33593742), installed 28 Sep; Tim's own check (place a tagged block, then explode it) is still outstanding.
467. [chunk 08 #468] BUG-187 | INSTALLED-WAITING-PROOF | pilot-critical no | Grade survives switching pipe type: 73c7d402 and 223c49f8; Codex tested an older build, not re-run on one with the fix.
468. [chunk 08 #469] BUG-186 | INSTALLED-WAITING-PROOF | pilot-critical no | Carry downstream refusal fixed (73c7d402), the reopened grade case fixed by 677dd6a5 (#361) in 3.0.13; Codex has not re-run it.
469. [chunk 08 #470] BUG-185 | INSTALLED-WAITING-PROOF | pilot-critical no | 45-degree beam on a rectangular column in a metre drawing: PR #295 shipped in Structural 1.0.78 per the entry; no commit message with this number was found, and it still needs an AutoCAD check.
470. [chunk 08 #471] BUG-184 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
471. [chunk 08 #472] BUG-183 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
472. [chunk 08 #473] BUG-182 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
473. [chunk 08 #474] BUG-181 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
474. [chunk 08 #475] BUG-180 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe or Pit tab comes to the front: 947a00c2 (#296, #298); Codex could not run the Home-tab step because the workspace has no Home tab, twice.
475. [chunk 08 #476] BUG-179 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
476. [chunk 08 #477] BUG-178 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
477. [chunk 08 #478] BUG-177 | INSTALLED-WAITING-PROOF | pilot-critical no | CDPIPEOBJ hidden from the ribbon as Tim ruled (UX-PIPE-08): PR #291 (64c5e3cc), Civil 3.0.7; status still "in progress", nothing left to build.
478. [chunk 08 #479] BUG-171 | INSTALLED-WAITING-PROOF | pilot-critical yes | Upgraded stormwater pipe opening as Detention: round 2 d6a02dcb (draft #196, merged into the train as a5443b8b); the Codex FAIL was on the older build and has not been re-run.
479. [chunk 08 #480] BUG-172 | NEEDS-TIM | pilot-critical no | Three Civil ribbon icons fixed (206ac2ba); six commands (CDPERIMETER, CDTWL, CDDEST, CDPAVE, CDKERB, CDSPOONDRAIN) have no artwork and Tim has to supply or approve pictures.
480. [chunk 09 #481] BUG-176 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #346 merged (7c0538f2) and the pass-18 wording fix #656 merged; Codex pass 18 was blocked by a different refusal, so the inlet landing is unproven.
481. [chunk 09 #482] BUG-175 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 49ea9be0 (PR #179) makes Edit Pipe decide the pipe type once; carpark says installed in 3.0.70, never tested by robot or Codex.
482. [chunk 09 #483] BUG-174 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 4e4d9cd4 (PR #177) removes the [CE] tag from questions; installed 3.0.70, no robot or Codex result.
483. [chunk 09 #484] BUG-173 | HAS-DRAFT | pilot-critical no | Pit one-page PR #184 (ready for review) and pipe one-page PR #180; 29 Oct triage says the New Pit window still has large empty areas.
484. [chunk 09 #485] BUG-170 | ALREADY-FIXED | pilot-critical no | What's New fix 4465e22d is on the live line, 26 of 26 tests passed on 28 Sep; never installed and Tim has not seen it, so it still needs his look.
485. [chunk 09 #486] BUG-169 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED, Codex-accepted pass 18; RC restore fbe20071 and layer fix 8d382ec0 are on the Structural line; the RC Undo part is BUG-215.
486. [chunk 09 #487] BUG-168 | ALREADY-FIXED | pilot-critical no | Tim confirmed CDGRIPDIAG Off in AutoCAD on 24 Sep and keyword fix 05000fb4 (PR #155) is on the live line; the 2024 check is still open.
487. [chunk 09 #488] BUG-167 | ALREADY-FIXED | pilot-critical no | Commit d6bea373 (PR #364) swaps the hanging zip step; carpark status still says OPEN until a real installer build finishes, which I did not see.
488. [chunk 09 #489] BUG-166 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #107 (a2f56f43) plus e4d690a5 are on the line and installed in 3.0.70; it cannot be proven without AutoCAD and no Codex or robot pass is recorded.
489. [chunk 09 #490] BUG-165 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 74285871 (PR #92) stops old date-style build numbers outranking Version 3; the check is a unit test, nothing for Tim to see in AutoCAD.
490. [chunk 09 #491] BUG-164 | ALREADY-FIXED | pilot-critical no | PR #90 (aeb03763) stops the close-down crash, Codex pass 17 B5 accepted it on 29 Sep; a different crash on closing one drawing is BUG-224.
491. [chunk 09 #492] BUG-163 | UNCLEAR | pilot-critical yes | Tim could not reproduce it on 24 Sep; the carpark names one live AutoCAD experiment (point the Standard Details folder at a master with the tank plan block renamed) that nobody has run.
492. [chunk 09 #493] BUG-162 | ALREADY-FIXED | pilot-critical no | Test-only fix, PR #93 merged (7627ed39).
493. [chunk 09 #494] BUG-161 | ALREADY-FIXED | pilot-critical no | PR #87 merged (b02f3ec7); nothing installed in AutoCAD is missing from master.
494. [chunk 09 #495] BUG-160 | INSTALLED-WAITING-PROOF | pilot-critical yes | Part 1 PR #354 and the Keep or Automatic window (91a08ce0) are on the line; installed in 3.0.70, not yet driven in AutoCAD.
495. [chunk 09 #496] BUG-158 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 842b2490 (PR #347) warns instead of dropping the council sheet; Codex pass 18 was blocked, it needs a drawing with a council set.
496. [chunk 09 #497] BUG-058 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d77f8d2b is on the line, and a Codex run on 8 Oct reports "source-tag pits registered 45"; nobody has written a pass for it.
497. [chunk 09 #498] BUG-059 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d48f8d5b is on the line; Codex run W25 (8 Oct) shows the doubling gone (63 pipes down to 53); needs a closing ruling.
498. [chunk 09 #499] BUG-060 | INSTALLED-WAITING-PROOF | pilot-critical no | Guard d77f8d2b is on the line; the P8 to P8 leftover was a zero-length pipe, and BUG-440 (PR #814) now skips such pipes.
499. [chunk 09 #500] BUG-061 | NEEDS-TIM | pilot-critical no | Codex W29 (8 Oct) found it not reproduced on that job and says close it only when Tim confirms; Tim to say if it is gone.
500. [chunk 09 #501] BUG-062 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 61eff37e (PR #365) makes the imported pit use its real block rotation; installed 3.0.70, untested.
501. [chunk 09 #502] BUG-063 | NEEDS-TIM | pilot-critical no | Tim must say how existing council pipes and the council stub should be drawn and layered in an import.
502. [chunk 09 #503] BUG-064 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit f42798c6 (PR #366) makes "Propose fixes for all" always report; the result uses a message box, so Codex was to judge the wording.
503. [chunk 09 #504] BUG-065 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit b42766ab (PR #368) trims imported pipes to the pit outline; Tim's 29 Sep ruling (keep imported levels, flag suspect ones) is a separate queue item A6.
504. [chunk 09 #505] BUG-066 | UNCLEAR | pilot-critical no | Needs Tim's screenshot to set the quality bar, and a re-look now that the doubled pipes are gone (BUG-059).
505. [chunk 09 #506] BUG-067 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0a79865a (PR #363) is on the line; Tim approved "Unknown" for the FROM column on 29 Sep; not driven in AutoCAD.
506. [chunk 09 #507] BUG-068 | NEEDS-TIM | pilot-critical no | Tim ruled "snap to the architectural xref" on 3 Jul but how to find that xref in his drawings (origin, rotation, scale) and how Mike's coordinates relate needs his example; no commit found.
507. [chunk 09 #508] BUG-069 | UNCLEAR | pilot-critical no | PR #369 was HELD because the real cause was never found; needs a Codex reproduction on the original drawing type first.
508. [chunk 09 #509] BUG-070 | INSTALLED-WAITING-PROOF | pilot-critical no | Batch commit ad285577 (BUG-070 to 078) is on the line; carpark says installed, awaiting Tim's AutoCAD confirm.
509. [chunk 09 #510] BUG-071 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; window sizing, a look-and-feel check in AutoCAD.
510. [chunk 09 #511] BUG-072 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; pit P-number label on resize, awaiting Tim's confirm.
511. [chunk 09 #512] BUG-073 | UNCLEAR | pilot-critical yes | Batch ad285577 is in, but Tim's 29 Oct screenshot (Civil 3.0.85) shows the New Pipe preview with no pipe drawn; the cause is not known and it is parked under BUG-1230.
512. [chunk 09 #513] BUG-074 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; its tests skip on the dev box, awaiting Tim's AutoCAD confirm.
513. [chunk 09 #514] BUG-075 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch; Codex ran a pass on 27 Oct per the 29 Oct triage, which still needs a reviewer to compare it with this entry.
514. [chunk 09 #515] BUG-076 | INSTALLED-WAITING-PROOF | pilot-critical no | Commits ad285577 and 509dc431 are on the line, installed in 3.0.70, queued for a Codex pass.
515. [chunk 09 #516] BUG-077 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; the 5 mm pit drop carries down the run, awaiting Tim's confirm.
516. [chunk 09 #517] BUG-078 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; above and below toggle in CDEDIT, awaiting Tim's confirm.
517. [chunk 09 #518] BUG-079 | INSTALLED-WAITING-PROOF | pilot-critical no | Rounds 1 to 8 landed as c940e457 (PR #370); needs a visual check of all 8 drag directions and a slab with falls.
518. [chunk 09 #519] BUG-080 | NEEDS-TIM | pilot-critical no | Tim must supply the AS/NZS 3500 or AS 2200 maximum velocity for UPVC (the code holds 3.0 and 6.0 m/s as unverified guesses); the carpark says do not tidy it until then.
519. [chunk 09 #520] BUG-056 | NEEDS-TIM | pilot-critical no | Four engineering questions are open: invert-to-invert or obvert match at the council connection, the drop across it, how detention pipes are held, and how the connection is marked.
520. [chunk 09 #521] BUG-057 | UNCLEAR | pilot-critical no | Tim said some proposed fixes are wrong but no example was ever captured; need the pit or pipe, the proposed value and the correct value.
521. [chunk 09 #522] BUG-053 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix was deployed as v2.1.11 on 24 Jun and has guard tests; I did not find a commit naming it on the live line, and it has not been run on the roof drawing with xrefs.
522. [chunk 09 #523] BUG-054 | UNCLEAR | pilot-critical no | Not diagnosed; the deciding test (does it repro with the CE bundle disabled) and the question whether the edited objects are CE or structural were never answered.
523. [chunk 09 #524] BUG-051 | ALREADY-FIXED | pilot-critical no | Carpark says FIXED on 15 Jun (publishing moved to the main thread, 18 of 18 tests); no commit naming it was found on either live line, and Tim has not confirmed.
524. [chunk 09 #525] BUG-049 | UNCLEAR | pilot-critical no | CEADS still exists on the Structural line, but no commit or test result says the open-window crash was fixed.
525. [chunk 09 #526] BUG-001 | NEEDS-TIM | pilot-critical no | C alias is fixed and confirmed; Copy Rotate and Move Rotate are with Tim, and the clash with Structural's own "C" command was never ruled on.
526. [chunk 09 #527] BUG-002 | ALREADY-FIXED | pilot-critical no | Tim confirmed "works for now" on 13 May; a rare 10 per cent residual case is parked without a repro.
527. [chunk 09 #528] BUG-003 | INSTALLED-WAITING-PROOF | pilot-critical no | 29 Sep triage found the orifice pit detail generator in code, installed in 3.0.13; queued for a Codex check that I did not find a result for.
528. [chunk 09 #529] BUG-004 | ALREADY-FIXED | pilot-critical no | Tim confirmed T2 on 20 May (the command is CDMANAGER).
529. [chunk 09 #530] BUG-005 | ALREADY-FIXED | pilot-critical no | Checklist T21 passed on 8 May.
530. [chunk 09 #531] BUG-006 | ALREADY-FIXED | pilot-critical no | Checklist T20 passed on 8 May.
531. [chunk 09 #532] BUG-008 | ALREADY-FIXED | pilot-critical no | Tim confirmed 13 May; ledger item F-229 may ask to remove the 90 per cent rule, which would need a re-test.
532. [chunk 09 #533] BUG-009 | ALREADY-FIXED | pilot-critical no | Checklist T17 passed on 20 May.
533. [chunk 09 #534] BUG-007 | CLOSED-OR-WONT-FIX | pilot-critical no | Umbrella record for the 8 May batch, closed on Tim's yes (decision 178, 31 Oct); entry kept.
534. [chunk 09 #535] BUG-010 | ALREADY-FIXED | pilot-critical no | CDCALC opened on three recorded runs and Tim re-confirmed T1 on 20 May.
535. [chunk 09 #536] BUG-011 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0bda3751 and PR #367 lock callout left-justify per direction (Tim's BUG-128 ruling); Codex or Tim has not confirmed on west callouts.
536. [chunk 09 #537] BUG-012 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0bda3751 (PR #367) stops the FALL text patch dragging both texts to the origin; a drawing already holding a damaged FALL SYMBOL must be purged first.
537. [chunk 09 #538] BUG-013 | ALREADY-FIXED | pilot-critical no | Serilog pin fixed in e4546f6b on 13 May; the entry is a permanent reminder, nothing to test.
538. [chunk 09 #539] BUG-014 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark names commit 13fc5acb (before the monorepo import); no commit naming it was found by search, and it has had no robot or Codex pass.
539. [chunk 09 #540] BUG-015 | INSTALLED-WAITING-PROOF | pilot-critical no | Same pre-import fix (grade text always shows "1 IN N"); no commit naming it was found by search, no robot or Codex pass.
540. [chunk 10 #1] BUG-016 | CLOSED-OR-WONT-FIX | pilot-critical no | The Custom grade box was replaced by the CD window redesign (entry and the 23 Oct reconciliation say so); proposal only, Tim has not said it.
541. [chunk 10 #2] BUG-017 | DUPLICATE-OF-BUG-035 | pilot-critical no | T23 to T25 were Tim-confirmed and the one remaining failure (T22) is BUG-035; the World-UCS guard is in place.
542. [chunk 10 #3] BUG-018 | ALREADY-FIXED | pilot-critical no | Last Status line says FIXED 20 May with Tim confirming T18; pre-monorepo, no commit found by search; PIT BLOCK 2 is later overtaken by PIT BLOCK 3.
543. [chunk 10 #4] BUG-019 | ALREADY-FIXED | pilot-critical no | Last Status line says FIXED 20 May with Tim confirming T7; pre-monorepo, no commit found by search.
544. [chunk 10 #5] BUG-020 | INSTALLED-WAITING-PROOF | pilot-critical no | Code writes R and D tags and sweeps all attributes (round 3); CDWT was rebuilt in CV4-9/15 (7831f74a); listed in the Codex look batch, no V3 evidence yet.
545. [chunk 10 #6] BUG-021 | INSTALLED-WAITING-PROOF | pilot-critical yes | Three rounds of code for the IL text side near 92 to 96 degrees; the 24 Oct triage found no V3 evidence, so it needs a robot look with a pipe at those angles.
546. [chunk 10 #7] BUG-022 | DUPLICATE-OF-BUG-028 | pilot-critical no | Middle floor wastes were Tim-confirmed; ends and corners are BUG-028 and the arrow is BUG-029.
547. [chunk 10 #8] BUG-023 | CLOSED-OR-WONT-FIX | pilot-critical no | Mechanics Tim-confirmed 20 May and the leftover UX points were split into BUG-030 to BUG-034; proposal only, the last Status line still says OPEN.
548. [chunk 10 #9] BUG-024 | INSTALLED-WAITING-PROOF | pilot-critical yes | Grade label rules are installed from May to July code; the 24 Oct triage says never tested by robot or Codex; the "CDEDIT rising main destination hard-coded WT" leftover is not checked.
549. [chunk 10 #10] BUG-025 | INSTALLED-WAITING-PROOF | pilot-critical yes | The 1.10 to 1.11 invert drift was fixed in two rounds (rounding noise, then keep the typed end) with tests; no V3 robot or Codex run found.
550. [chunk 10 #11] BUG-026 | INSTALLED-WAITING-PROOF | pilot-critical no | Inspector rounding now matches the label and the 1:94 cause was BUG-025; it is in the Codex look batch.
551. [chunk 10 #12] BUG-027 | FIXABLE-NOW | pilot-critical yes | The 29 Oct retest triage inside the entry says the installed code still adds "MIN." against Tim's UX-CPLAN-05 ruling (CdCommand.Grade.cs 212 to 221); a builder can fix it from that note, and the entry's older band rule (round 2) must be replaced by the ruling.
552. [chunk 10 #13] BUG-028 | INSTALLED-WAITING-PROOF | pilot-critical no | The 50 mm end and 25 mm corner insets were coded with 8 tests, then reshaped by R5 and R6; the 31 Oct lane plan puts it in the robot look-around.
553. [chunk 10 #14] BUG-029 | NEEDS-TIM | pilot-critical no | The entry asks for a QLeader on 25DIMS, then R6 changed it to a Leader with the TIM LEADER dimstyle on the STRIP DRAIN layer: which arrow style and layer is final?
554. [chunk 10 #15] BUG-030 | CLOSED-OR-WONT-FIX | pilot-critical no | The "[Yes/Ce]" command-line prompt was replaced by a popup (comment at CdCommand.Breakline.cs line 37 on the latest line), so the prompt no longer exists; proposal only.
555. [chunk 10 #16] BUG-031 | NEEDS-TIM | pilot-critical no | The popup is coded, but R5 and R6 later moved continuation to an in-dialog banner and a manual toggle; does Tim want the popup kept or retired?
556. [chunk 10 #17] BUG-032 | INSTALLED-WAITING-PROOF | pilot-critical no | The "Linked half" badge is coded for the Inspector; the 31 Oct lane plan puts it in the robot look-around; no V3 evidence.
557. [chunk 10 #18] BUG-033 | INSTALLED-WAITING-PROOF | pilot-critical no | Small-pipe arrow offset fixed by a clash radius that scales with pipe size, 9 tests; no V3 look.
558. [chunk 10 #19] BUG-034 | NEEDS-TIM | pilot-critical no | Only the "remember last choice" half was built; the auto-detect half (BUG-034b) is deferred, and R6.1 added a manual continuation toggle: is auto-pick still wanted?
559. [chunk 10 #20] BUG-035 | INSTALLED-WAITING-PROOF | pilot-critical yes | PIT is forced to rotation 0 after insertion as a defensive fix that masks the cause; the T22 retest (rotated UCS, CD then PIT) has not been done on V3.
560. [chunk 10 #21] BUG-036 | INSTALLED-WAITING-PROOF | pilot-critical no | CDREFRESHLINKS, R5 and R6.5 cover the MIRROR and MOVE cover-text case; the triage notes the entry carries a sub-heading and needs a robot look.
561. [chunk 10 #22] BUG-037 | CLOSED-OR-WONT-FIX | pilot-critical no | The installer audit of PIT BLOCK 2 found it staged, and PIT BLOCK 2 is now overtaken by PIT BLOCK 3; proposal only, colleague-machine check never done.
562. [chunk 10 #23] BUG-038 | INSTALLED-WAITING-PROOF | pilot-critical no | The combined SPS to breakline to destination invert line is coded in the Inspector; the 31 Oct lane plan puts it in the robot look-around.
563. [chunk 10 #24] BUG-040 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, closed on Tim's yes (decision 178, 31 Oct); CDWT is water tanks only.
564. [chunk 10 #25] BUG-041 | INSTALLED-WAITING-PROOF | pilot-critical no | The two-point limit on Custom grade was removed and coded 21 May; no V3 evidence in the 24 Oct triage.
565. [chunk 10 #26] BUG-042 | NEEDS-TIM | pilot-critical no | The entry itself says where to put the gravity breakline toggle needs Tim's UX answer; R6.2 then made Cross-plan break the toggle for all pipe types, so confirm that is the intended place.
566. [chunk 10 #27] BUG-087 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED 14 Aug with Tim confirming "HATCH WORKS HOWEVER" on Structural 1.0.72 (source 9af408a5).
567. [chunk 10 #28] BUG-086 | INSTALLED-WAITING-PROOF | pilot-critical yes | The C2 Upgrade or Cancel workflow was built and audited in Structural 1.0.67 (ff36a304), and C2 is in the Codex look batch of 31 Oct; no result found.
568. [chunk 10 #29] BUG-085 | INSTALLED-WAITING-PROOF | pilot-critical yes | The beam command 1 endpoint repair (d44c7b42) is in later Structural trains and the command is in the Codex look batch; no result found.
569. [chunk 10 #30] BUG-088 | INSTALLED-WAITING-PROOF | pilot-critical yes | The L4 midpoint fallback and RB9 label offset were fixed in 1.0.73 (4a5927a1, with abaa565a on the Structural line); in the Codex look batch, no result found.
570. [chunk 10 #31] BUG-089 | UNCLEAR | pilot-critical yes | No commit names this bug and the 1.0.73 work targets BUG-088's different error; missing: whether LINTEL_BOUNDARY_MISSING still appears for L2 and L4 on the current Structural build, which a Codex look would show.
571. [chunk 10 #32] BUG-090 | ALREADY-FIXED | pilot-critical no | Fixed by PR 1836 (3db30bfe, window grows to fit its rows); Codex G4-02 and A1-01 PASS on 30 Oct at 100% display, the 150% half was BLOCKED; the carpark Status line is stale and Tim also wants the version window moved into CE Manager.
572. [chunk 10 #33] BUG-091 | UNCLEAR | pilot-critical yes | The refusal wording from the entry no longer appears in the current Drainage code, and no commit names DR-CD-01 or this bug; missing: which commit carried the approved fix, and a live free-point CD and CDEDIT Apply check.
573. [chunk 10 #34] BUG-084 | INSTALLED-WAITING-PROOF | pilot-critical no | Drawing close now releases project data (tests 2 of 2 on net48 and net10); the entry itself says it still needs an AutoCAD open, close and reopen memory check.
574. [chunk 10 #35] BUG-083 | INSTALLED-WAITING-PROOF | pilot-critical no | PIT window cleanup on close is built and tested; the entry itself says it still needs an AutoCAD open and close memory check.
575. [chunk 10 #36] BUG-082 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED 27 Jul with 10 of 10 build-safety tests and no AutoCAD test needed; no commit found by the bug-number search.
576. [chunk 10 #37] BUG-050 | INSTALLED-WAITING-PROOF | pilot-critical yes | The beam label side fix (same side whichever end was clicked first) is installed in Structural 1.0.121; the triage says no robot case or Codex evidence yet.
577. [chunk 10 #38] BUG-052 | NEEDS-TIM | pilot-critical no | The automatic PIT BLOCK 3 migration was built and tested, but the entry's last step (drop PIT BLOCK 2 from the install) was gated on a rollout test: does Tim still want PIT BLOCK 2 removed? Follow-up problems sit in BUG-793.
578. [chunk 10 #39] BUG-093 | INSTALLED-WAITING-PROOF | pilot-critical no | The faulting grip class is no longer registered and PR 655 deleted it (bf2ff1f2); the triage says it needs a Codex retest of the Slide, Offset and Flip grips.
579. [chunk 10 #40] BUG-092 | UNCLEAR | pilot-critical yes | The 60-retry constants named in the entry are no longer in the Manager ribbon code on the latest line and no commit names this bug; missing: which commit changed it and whether the start-up lag is gone.
580. [chunk 10 #41] BUG-094 | INSTALLED-WAITING-PROOF | pilot-critical yes | The CDEDIT shared-picker correction was deployed (96e7d76a on 7 Sep); the entry says it awaits Tim's MLINE and PLINE check.
581. [chunk 10 #42] BUG-095 | NEEDS-TIM | pilot-critical yes | The Glen Eira detention storage is 1.80 m3 against 2.58 m3 in the fixture; which calculation basis (Boyd's sheet or the Swinburne profile) is right is an engineering call, and tolerances must not be widened.
582. [chunk 10 #43] BUG-096 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, a test packaging file only, closed on Tim's yes (decision 178).
583. [chunk 10 #44] BUG-097 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, a stale test count only, closed on Tim's yes (decision 178).
584. [chunk 10 #45] BUG-098 | INSTALLED-WAITING-PROOF | pilot-critical yes | The label-versus-ID mismatch warning is in the code (813b4672, 4a79f5ee, 5efae400); Codex pass 18 was BLOCKED because the mismatch could not be created, and the plan label is the authority.
585. [chunk 10 #46] BUG-099 | INSTALLED-WAITING-PROOF | pilot-critical no | The glyph fix is in (813b4672); Codex pass 18 was BLOCKED because no symbol showed on screen, so neither the old nor the new result was seen.
586. [chunk 10 #47] BUG-144 | INSTALLED-WAITING-PROOF | pilot-critical no | Survey Approve keyword fixed in 38842c9c; the lane plan notes there is no runner case yet for CDSURVEY.
587. [chunk 10 #48] BUG-145 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pit grip-move labels following once, fixed in 38842c9c; awaiting a robot or Codex look.
588. [chunk 10 #49] BUG-146 | INSTALLED-WAITING-PROOF | pilot-critical no | The tidy-up after MOVE now sees the established route's pipes (38842c9c); awaiting a robot or Codex look.
589. [chunk 10 #50] BUG-147 | INSTALLED-WAITING-PROOF | pilot-critical yes | The duplicate-tag refusal on CDFW and CDSOURCE was fixed (38842c9c, later 69852255 for BUG-152); awaiting a robot or Codex look.
590. [chunk 10 #51] BUG-139 | INSTALLED-WAITING-PROOF | pilot-critical no | Water tanks leave the identity gate (8c9f6833); awaiting a robot or Codex look.
591. [chunk 10 #52] BUG-140 | INSTALLED-WAITING-PROOF | pilot-critical yes | Labels follow a grip-moved pit once (8c9f6833, later 38842c9c); awaiting a robot or Codex look.
592. [chunk 10 #53] BUG-141 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED, Codex-accepted both halves on Civil 3.0.65 on 20 Oct (PRs 1482 and 1484, b56839b8); the leftover "no clear spot" on P3 to P2 is a real overlap and Tim said "yes leave it".
593. [chunk 10 #54] BUG-142 | INSTALLED-WAITING-PROOF | pilot-critical no | CDSURVEY approves at the command line when CESURVEYREVIEW is missing (8c9f6833); no runner case yet.
594. [chunk 10 #55] BUG-143 | INSTALLED-WAITING-PROOF | pilot-critical no | The CDPIPEOBJ look was fixed (8c9f6833) and kept true after the twin fix (42362023); it sits in the labels and drawn output look list.
595. [chunk 10 #56] BUG-127 | INSTALLED-WAITING-PROOF | pilot-critical no | Callout picks use NEAREST only (3197e3d4); BUG-106 shares the lane and there is no D card.
596. [chunk 10 #57] BUG-128 | INSTALLED-WAITING-PROOF | pilot-critical no | West callout text left-justified (3197e3d4); it is on the labels and drawn output look list.
597. [chunk 10 #58] BUG-129 | INSTALLED-WAITING-PROOF | pilot-critical no | The wrapped pipe label mask is tight (3197e3d4); it is on the labels and drawn output look list.
598. [chunk 10 #59] BUG-130 | INSTALLED-WAITING-PROOF | pilot-critical no | Tidy-up after MOVE now runs on the established route (3197e3d4); later tidy work (BUG-141) built on it.
599. [chunk 10 #60] BUG-131 | INSTALLED-WAITING-PROOF | pilot-critical no | The P9 pit grip-move left-behind text was fixed (3197e3d4); later grip-move bugs 140 and 145 followed.
600. [chunk 11 #1] BUG-132 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (R2 batch F1-F8, 15 Sep); carpark says awaiting Tim's retest.
601. [chunk 11 #2] BUG-133 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (live words on object picks); awaiting retest.
602. [chunk 11 #3] BUG-134 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (survey outlier now a warning); awaiting retest.
603. [chunk 11 #4] BUG-135 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (CDPIPEOBJ look, colour, lag); awaiting retest.
604. [chunk 11 #5] BUG-136 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (twin envelope on CDEDIT); awaiting retest.
605. [chunk 11 #6] BUG-137 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (Base RL into the tank record); awaiting retest.
606. [chunk 11 #7] BUG-138 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (pipe wider than pit asks to upsize); awaiting retest.
607. [chunk 11 #8] BUG-106 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 0b94f379 (callout landing) and 3197e3d4 (NEAREST-only picks, left-justified west callouts); awaiting retest.
608. [chunk 11 #9] BUG-105 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 598b4eec (twin arrow offset, single and twin values on Settings); awaiting retest.
609. [chunk 11 #10] BUG-104 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 813b4672 (linked text edit now says what it stored); awaiting retest.
610. [chunk 11 #11] BUG-103 | UNCLEAR | pilot-critical no | The MLeader refusal was fixed in 813b4672, but "riser and dropper blocks wrong, same with wt block" was never explained: needs Tim's screenshot of which block looks wrong.
611. [chunk 11 #12] BUG-102 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed in rounds 2, 4 and 7 (a53eec0a, 5efae400, 2c6072cf); awaiting retest.
612. [chunk 11 #13] BUG-101 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 7c3be5a3 (fall-arrow shaft 610 mm) and a2c1d060 (live words); awaiting retest.
613. [chunk 11 #14] BUG-100 | CLOSED-OR-WONT-FIX | pilot-critical no | Status is FIXED, Tim confirmed the typed A on b312bf0f (reconciled 23 Oct).
614. [chunk 11 #15] BUG-449 | CLOSED-OR-WONT-FIX | pilot-critical no | Status FIXED, Codex-accepted W40 (9 Oct, reconciled 23 Oct).
615. [chunk 11 #16] BUG-450 | INSTALLED-WAITING-PROOF | pilot-critical no | LOW 1 wording fixed by b448275f (PR #848, in the Structural line); the six other LOWs were not each checked here and LOW 2 (Esc keeps the column) needs Tim's choice.
616. [chunk 11 #17] BUG-451 | DUPLICATE-OF-BUG-454 | pilot-critical no | This is a list of what Codex saw; its two open points (FSF Enter, pad label not visible) are exactly BUG-454, and FSF Enter was fixed by 9520b54d.
617. [chunk 11 #18] BUG-452 | INSTALLED-WAITING-PROOF | pilot-critical no | The MEDIUM (login in the Manager trace) is fixed, and 9a7d9610 scrubs every trace line; carpark says installed in Civil 3.0.70 / Manager 1.1.70, untested; LOWs 2 to 10 not checked here.
618. [chunk 11 #19] BUG-453 | INSTALLED-WAITING-PROOF | pilot-critical no | Wording fix is on the Structural line (merge 620eb896 of PR #1797, c1533e67); gh still lists #1797 as a draft, and a "still to be built" sentence remains on the member-schedule lines (not in this entry's three commands).
619. [chunk 11 #20] BUG-454 | NEEDS-TIM | pilot-critical yes | FSF Enter is fixed (9520b54d, PR #846), but in a millimetre drawing at DIMSCALE 1 the pad label is still 2.5 mm high; question: should the pad label follow the annotation scale (for example 250 mm at 1:100) like the schedules do?
620. [chunk 11 #21] BUG-455 | DUPLICATE-OF-BUG-435 | pilot-critical no | Status line already says DUPLICATE OF BUG-435 and BUG-562, closed on Tim's yes (decision 178).
621. [chunk 11 #22] BUG-456 | INSTALLED-WAITING-PROOF | pilot-critical no | MEDIUM fixed in #827 (installed Civil 3.0.70 per the carpark); not tested by robot or Codex; the main LOWs are open and not individually checked.
622. [chunk 11 #23] BUG-457 | INSTALLED-WAITING-PROOF | pilot-critical yes | Redo-guard hardening landed as 4708690f / 6fb18124 (PR #870) on the Civil line and 9508e3f0 on the Structural line; the unwalked U/REDO routes in section 4 still need a Codex pass.
623. [chunk 11 #24] BUG-458 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-01 fixed by 980b10c6 (PR #880, merged into rel-20261009l) and tidied by b5e15dda; nobody has watched REFEDIT then PIT in AutoCAD.
624. [chunk 11 #25] BUG-459 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-02 fixed by 0d3ccb24 (PR #882, #1090); Codex W59b PASS on 3.0.48 (12 Oct), awaiting Tim's confirmation.
625. [chunk 11 #26] BUG-460 | CLOSED-OR-WONT-FIX | pilot-critical no | Status FIXED (Claude-accepted, Civil 3.0.84, runner case R33 passed twice, Opus review agrees); fix 0d3ccb24.
626. [chunk 11 #27] BUG-461 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-04 fixed by 10999597 (PR #883, merged into rel-20261009l); not seen in AutoCAD.
627. [chunk 11 #28] BUG-462 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-05 fixed by d687c15d (PR #884): New Pipe reads the Settings tolerance; not seen in AutoCAD.
628. [chunk 11 #29] BUG-463 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-06 fixed by 5792a99c (PR #885): schedule levels use the Settings decimals; not seen in AutoCAD.
629. [chunk 11 #30] BUG-464 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-07 fixed by 354be3b6 (PR #881): Pit Schedule off on a read-only drawing and during REFEDIT; Codex W50 was meant to see it, no pass recorded here.
630. [chunk 11 #31] BUG-465 | INSTALLED-WAITING-PROOF | pilot-critical no | Items 08/09 ee2d9e4d, 10 67b63a74, 11 cbe41302, 13 adff5b45, 14 d3250e90, 15 dc4f3772 are fixed; I found no commit for item 12 (CE puts a layer's colour back on every draw), so that one may still be open.
631. [chunk 11 #32] BUG-466 | NEEDS-TIM | pilot-critical no | HUNT-S-01 fixed (23a4f832, PR #865; Codex W57 saw it); Codex W51 asks Tim: when a mark already exists, is "next free mark, ask its size, 600 default" the wanted behaviour?
632. [chunk 11 #33] BUG-467 | HAS-DRAFT | pilot-critical yes | Robot FAIL 31 Oct (second point of BT1, AB and BB turned twice by the UCS); draft PR #1921 (B-109, no switch) is open; PR #1883 was closed.
633. [chunk 11 #34] BUG-468 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by a77eeec9 (columns count as posts with beam linking off); carpark says installed in Structural 1.0.121, untested.
634. [chunk 11 #35] BUG-469 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-04 fixed by 300a6a3e (PR #867); Codex W57 and W51 saw Esc cancel cleanly; the leftover undo step is filed as BUG-564.
635. [chunk 11 #36] BUG-470 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-05 fixed by 987ca9dd (PR #899), already in the Structural head 204dfad2; no AutoCAD proof.
636. [chunk 11 #37] BUG-471 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-06 fixed by 95488c6a (R1, BT1, C1, TS1 stop in non-millimetre drawings) and f6a24386 (AB, BB); no AutoCAD proof.
637. [chunk 11 #38] BUG-472 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-S-07 fixed by 906e3792 (PR #887): layout tab and REFEDIT stop with one line; not tried in AutoCAD (BTX on a layout was the worst case).
638. [chunk 11 #39] BUG-473 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-S-08 fixed by 06af5e65 (locked-layer guard for BT1, C1, TS1, AB, BB, BTX); no AutoCAD proof.
639. [chunk 11 #40] BUG-474 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-11 fixed by 8c46a8de and 81fcc357 (FEDIT asks Change / Leave / Another before a rename changes a saved size); needs an AutoCAD look.
640. [chunk 11 #41] BUG-475 | NEEDS-TIM | pilot-critical no | Most sub-items are fixed (S-10 cca118b9, S-12 a4e70908, S-14 ce31b395, S-15 6cf2add8), but S-13 says never decide without Tim: should BT1 obey the Settings "Longest wall brace" like AB and BB? and S-09: should a click at R1's first question pick directly?
641. [chunk 11 #42] BUG-476 | ALREADY-FIXED | pilot-critical yes | Wording fixed in b7619d9e and 0d06273f; 111e1505 (BUG-829) stops a colleague seeding their own list; Codex saw Tim's PC set up (W53); run 39 could not read the wording; a real "add an administrator" control was not found.
642. [chunk 11 #43] BUG-477 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-M-02 fixed by 41874359 (PR #868): Roll Back hidden behind the Manager switch showRollBack, OFF; no AutoCAD proof.
643. [chunk 11 #44] BUG-478 | HAS-DRAFT | pilot-critical yes | Wording fixed by 1db45965 (HUNT-M-03); the real "finish the update" step is draft PRs #1508 and #1515 (pure, switch OFF, nothing starts); the carpark says the route needs Tim's word.
644. [chunk 11 #45] BUG-479 | ALREADY-FIXED | pilot-critical no | HUNT-M-04 fixed by 4c4134fd (PR #869): status counts only valid approvals; the April approval file in the office folder was not checked by me.
645. [chunk 11 #46] BUG-480 | ALREADY-FIXED | pilot-critical no | HUNT-M-05 fixed by 4c4134fd (CeReleaseStatusService.cs line 158); carpark note says it needs a PC without the office folder to see it.
646. [chunk 11 #47] BUG-481 | ALREADY-FIXED | pilot-critical no | HUNT-M-06 fixed by 342baa37 and 622cd75f: Manager no longer forces MENUBAR unless forceMenuBar is on.
647. [chunk 11 #48] BUG-482 | ALREADY-FIXED | pilot-critical no | HUNT-M-07 fixed by dd6713f7: CESUPPORT says where the zip really goes, with a local-only folder switch (OFF).
648. [chunk 11 #49] BUG-483 | NEEDS-TIM | pilot-critical yes | Old install scripts in the office folder install old builds and promise automatic updates; question: may the old scripts and builds be moved into an "OLD - do not use" folder, with one pilot install note beside the real package? (Office folder not checked by me.)
649. [chunk 11 #50] BUG-484 | ALREADY-FIXED | pilot-critical no | HUNT-M-09 fixed by 5a344c73: CEHEALTH checks Manager, the Civil/Manager pair and duplicate installs.
650. [chunk 11 #51] BUG-485 | ALREADY-FIXED | pilot-critical no | HUNT-M-10 fixed by 3fdea24a: office-folder copy keeps failed reports waiting and never throws.
651. [chunk 11 #52] BUG-486 | ALREADY-FIXED | pilot-critical no | HUNT-M-11 fixed by b71d1139 behind the shortStagingFolders switch, which is OFF, so it does nothing until turned on.
652. [chunk 11 #53] BUG-487 | ALREADY-FIXED | pilot-critical no | HUNT-M-12/13 f31c325f, HUNT-M-14 280e7681, HUNT-M-15 4d8ce52a cover the four LOWs; items (a) to (d) are already listed under other BUGs.
653. [chunk 11 #54] BUG-488 | ALREADY-FIXED | pilot-critical yes | 97651f93: fault report and CEMANAGERDIAG now use coded names and the shared scrub (CeDiagnosticsService.cs lines 56-57, 286, 289); no AutoCAD proof; this was the privacy blocker.
654. [chunk 11 #55] BUG-489 | ALREADY-FIXED | pilot-critical yes | 0827bb32: the support zip cleaner now cuts names without .dwg, CD_ProjectData names and folder/PDF paths; the Civil log still writes DrawingName in JobTimeTracker.cs, so the clean zip relies on the cleaner; not tested.
655. [chunk 11 #56] BUG-490 | ALREADY-FIXED | pilot-critical yes | fefe6b1f: the Windows login is no longer written inside the drawing (DrawingPersonName: coded id or Settings value); no Environment.UserName left in the named files; not proven in a saved DWG.
656. [chunk 11 #57] BUG-491 | FIXABLE-NOW | pilot-critical no | Only A8 is done (f2669fa9); A6 (Manager failure report keeps paths), A9 (file names carrying drawing names) and A10 (dormant old Structural support zip) have no fix; A7 in Civil I could not confirm either way.
657. [chunk 11 #58] BUG-492 | NEEDS-TIM | pilot-critical yes | Time-log files and the weekly export are named by Windows login (CivilJobTimeSettings.cs 34, 38 still use Environment.UserName); question: default the name to blank and ask once, or to a coded name?
658. [chunk 11 #59] BUG-493 | NEEDS-TIM | pilot-critical no | An audit list of start-up writes, not a single fault; question: which start-up writes need a line in the CE log saying what was saved and why?
659. [chunk 11 #60] BUG-494 | INSTALLED-WAITING-PROOF | pilot-critical yes | The test's blind spots were addressed by the redo-guard port (9508e3f0, 4708690f); Codex still has not walked TS1, R1, FSF, FPFC, grip edits, Sheets update, drawing switch, or autosave between U and REDO.
660. [chunk 12 #1] BUG-495 | UNCLEAR | pilot-critical yes | Fix ee1fdecd is on the Structural train (rel-20261026s), not on the Civil line; it covers the Drawing Sheets window only, and the Sheets Manager window and the preview-before-plot are untouched; carpark note says "probably still there", which this contradicts; needs a read of CeSheetsManagerWindow plus the S31 Codex look.
661. [chunk 12 #2] BUG-496 | NEEDS-TIM | pilot-critical yes | Job record is saved per PC; the entry itself says "Tim's call which" (travel with the drawing or with the job folder).
662. [chunk 12 #3] BUG-497 | FIXABLE-NOW | pilot-critical yes | ScheduleService.cs on rel-20261026s still sizes bracing and pier tables "count + 1" while items start at row 2; the fix is "count + 2", no judgement needed.
663. [chunk 12 #4] BUG-498 | FIXABLE-NOW | pilot-critical yes | No commit found; refresh never clears leftover rows (tie-down already does); a schedule that overstates bracing is the dangerous direction.
664. [chunk 12 #5] BUG-499 | NEEDS-TIM | pilot-critical yes | Codex confirmed roof trusses (BT1) count in the wall total; the entry says how A and B lengths combine against required is Tim's engineering call (BUG-950 only covers differing types).
665. [chunk 12 #6] BUG-500 | NEEDS-TIM | pilot-critical no | Required bracing is stored per PC; the fix depends on Tim's choice on BUG-496 (one job-record fix covers 496, 500, 533).
666. [chunk 12 #7] BUG-501 | FIXABLE-NOW | pilot-critical no | C1/C2 take the first schedule row by mark; right result (ask which size, say which floor) is stated; no commit found.
667. [chunk 12 #8] BUG-502 | FIXABLE-NOW | pilot-critical no | CSSUBFLOORGRID still carries "150x50 F17" and "90x90 F17" defaults in UserSettings.cs on the Structural line; right result is "no default, blank shows Unknown" (R-00); typed command only.
668. [chunk 12 #9] BUG-503 | FIXABLE-NOW | pilot-critical no | Seven small items; S-13 (PR #1792) and S-15 (PR #1796) are merged on the Structural train, S-11 became BUG-504; S-09, S-10, S-12 and S-14 have no commit and each states the right result.
669. [chunk 12 #10] BUG-504 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 8a1aec7c on the Structural train (carpark: PR #1272, Structural 1.0.121); Codex reproduced the blank-class fault on 1.0.116, nobody has re-driven it since.
670. [chunk 12 #11] BUG-505 | NEEDS-TIM | pilot-critical yes | Still fails in real AutoCAD (Codex V3b-04, V8-01); draft PR #1926 (scale sentence) and merged #1853 (no-units note) are partial; the units rule (drawing UNITS versus CE's size guess) is with CE 04 for Tim.
671. [chunk 12 #12] BUG-506 | ALREADY-FIXED | pilot-critical yes | Commit 3112aa54 "HUNT2-C-02: connection pipe grade printed as 1:N, not 1:0" on rel-20261102a; not yet seen in AutoCAD.
672. [chunk 12 #13] BUG-507 | ALREADY-FIXED | pilot-critical no | Commit 4d3a07f5 (Boyd's starts blank) and merge of #1257 (window warning) on the Civil line; the Codex "Unknown shown as zero" remainder is not re-checked.
673. [chunk 12 #14] BUG-508 | ALREADY-FIXED | pilot-critical no | Commit 555374da (flows use the job curve, sentence plus Settings value) is on rel-20261102a but the switch ships OFF, so default behaviour is unchanged until it is turned on.
674. [chunk 12 #15] BUG-509 | ALREADY-FIXED | pilot-critical no | Commit 9793b9e7 "summary prints the before-development C used" on rel-20261102a.
675. [chunk 12 #16] BUG-510 | ALREADY-FIXED | pilot-critical no | Commit 2b95a21e (hard-ground C in Settings) and b780b732 (CDCALC Boyd's uses it) on rel-20261102a.
676. [chunk 12 #17] BUG-511 | ALREADY-FIXED | pilot-critical no | Commit 6ae16dde "CDDESIGN detention pipe limits read the Settings figures CDRULES checks" on rel-20261102a.
677. [chunk 12 #18] BUG-512 | ALREADY-FIXED | pilot-critical no | Commit ae64971a (HUNT2-C-08/09: LandXML placeholders marked and listed); LandXmlParser.cs now carries placeholder markers for 375 mm and 600 x 600.
678. [chunk 12 #19] BUG-513 | ALREADY-FIXED | pilot-critical no | Same commit ae64971a ("sump level not the invert").
679. [chunk 12 #20] BUG-514 | ALREADY-FIXED | pilot-critical no | Commit 499b97c8; RulebookEngine.cs now only warns when roughness.IsAssumed.
680. [chunk 12 #21] BUG-515 | ALREADY-FIXED | pilot-critical no | Commit 6ab18018 (storm-still-rising sentence, CDCALC and CDDESIGN) plus merged #1257 (window shows the warning); needs the Codex retest.
681. [chunk 12 #22] BUG-516 | ALREADY-FIXED | pilot-critical no | Status already FIXED (Codex-accepted, V2b V2-03); (a) by 380020a2 (switch OFF) and (c) by 372541b4; sub-item (d) LandXML size units has no commit found.
682. [chunk 12 #23] BUG-517 | NEEDS-TIM | pilot-critical yes | Part (g) done (5396cf9c, black printed sheet); the rest (four theme files, help, ribbon icons) needs Tim to pick the exact charcoal, gold and soft-grey colours; Codex W2 FAIL on build 3.0.87.
683. [chunk 12 #24] BUG-518 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 8d11531c; carpark says installed in Civil 3.0.70 / Manager 1.1.70 via PR #1297, not tested by robot or Codex.
684. [chunk 12 #25] BUG-519 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit ec7ef8a0 (one plain start-up line) is on the Structural train, so it is in 1.0.125; carpark status line not updated.
685. [chunk 12 #26] BUG-520 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed in Structural 1.0.121 via PR #1312; commit d4c9ef30 covers part (c); Civil rows (a)(b) and lintel override not confirmed.
686. [chunk 12 #27] BUG-521 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed 3.0.70 via PR #1222; commit 0bdbd536 says "display half", switch OFF, needs Opus review.
687. [chunk 12 #28] BUG-522 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit d2af210f; run 40 PASS for the equal-copies case only, the mismatch case is unproven.
688. [chunk 12 #29] BUG-523 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1307; commit af6a9d14 covers the Civil half of 1.11; Structural and Manager halves unconfirmed.
689. [chunk 12 #30] BUG-524 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1310; commits 42716215, 3962334d cover Civil titles; Structural ribbon labels (2.4) unconfirmed.
690. [chunk 12 #31] BUG-525 | NEEDS-TIM | pilot-critical no | The entry says to ask Tim with a picture about the water line (3.2) and the snap glow (3.14); the rest depends on the BUG-517 colours.
691. [chunk 12 #32] BUG-526 | UNCLEAR | pilot-critical no | Tim said "7yes" (five groups that print on drawings first) but the five group names are not written in the entry; draft card job z4 queued.
692. [chunk 12 #33] BUG-527 | UNCLEAR | pilot-critical no | Item 5.2 (pipe speed) merged as #1822 (bea97ec2); items 5.3 (fall-back numbers) and 5.4 (two job timers) have no commit found, so the entry is part fixed.
693. [chunk 12 #34] BUG-528 | FIXABLE-NOW | pilot-critical no | 6.3 is a one-line comment fix and 6.2 is a package version alignment for the 2022-2024 lane; no commit found.
694. [chunk 12 #35] BUG-529 | INSTALLED-WAITING-PROOF | pilot-critical no | Evidence note: all three refusals now warn and carry on on the Structural train (204dfad2 = 1.0.125) behind switches; but Tim's two Rebar switches were found True after the 30 Oct incident (BUG-1257).
695. [chunk 12 #36] BUG-530 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge of PR #1793 (b1fcf22f) on the Structural train, unknown-pad-size warning ON; the Settings box for the offered size was not confirmed.
696. [chunk 12 #37] BUG-531 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed 1.0.121 via PR #1496; scoped to EBT and the label helper; the other 22 places and tie-down, pit and pier labels not confirmed.
697. [chunk 12 #38] BUG-532 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1227; commit 6d903f98 covers the joist layer only; the four double-ups still need Tim to say which layer name is right.
698. [chunk 12 #39] BUG-533 | DUPLICATE-OF-BUG-500 | pilot-critical no | Entry says "same fault as BUG-500", fix together with 500 and 496, "do not fix it separately"; Tim said "8talk later".
699. [chunk 12 #40] BUG-534 | NEEDS-TIM | pilot-critical no | Entry says "Tim to rule on editions" for five standards tables (AS 3600, AS/NZS 4671, AS 2870, AS 1684.2, AS 4055).
700. [chunk 12 #41] BUG-535 | HAS-DRAFT | pilot-critical no | Draft PR #1910 (B-089) shows footing widths and brace lengths on CESETTINGS; the rest is parked by Tim ("8talk later").
701. [chunk 12 #42] BUG-536 | HAS-DRAFT | pilot-critical no | Draft PR #1911 (B-090) wires CSLOADPATH; SCREWPILE, REBAR and beam shorten already read Settings on the train; schedule and label sizes parked by Tim.
702. [chunk 12 #43] BUG-537 | NEEDS-TIM | pilot-critical no | Entry says to go through the list with Tim's command cards and mark each "drafter changes this" or "internal" before adding rows.
703. [chunk 12 #44] BUG-538 | NEEDS-TIM | pilot-critical no | Entry says Tim's word is needed on each council source and edition; partly built (a405ea64 reuse credits, 472cf28e pump settings) with today's numbers as defaults.
704. [chunk 12 #45] BUG-539 | ALREADY-FIXED | pilot-critical no | Commit 2b95a21e (hard-ground C in Settings) is read by CDDESIGN; the other tabs (Rational, Charged system, Detention Design 0.85, WSUD) not checked.
705. [chunk 12 #46] BUG-540 | ALREADY-FIXED | pilot-critical no | Commits 8729ae8e and ab44939c (step irons 900 mm office-wide); the after-command refresh remainder was split off as BUG-785.
706. [chunk 12 #47] BUG-541 | ALREADY-FIXED | pilot-critical no | Merge of PR #1786 (597f05de) and PR #1824 (3e3478ac) on rel-20261102a; the source of each fall is still Tim's word.
707. [chunk 12 #48] BUG-542 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit bdc70c03; carpark: installed via PR #1218, switch OFF, not tested by robot or Codex.
708. [chunk 12 #49] BUG-543 | ALREADY-FIXED | pilot-critical no | Merge of #1825 (1e741585) tests the Detention tab's council-coefficient switch on rel-20261102a.
709. [chunk 12 #50] BUG-544 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PRs #1223 and #1224; commits 0018b393, 03913e47 cover items 21, 29, 30 behind switches OFF.
710. [chunk 12 #51] BUG-545 | ALREADY-FIXED | pilot-critical no | Merge of #1823 (pit drop warning, 04687536) and #1785, plus the freeboard fix from BUG-516 (b).
711. [chunk 12 #52] BUG-546 | FIXABLE-NOW | pilot-critical no | No commit found; the entry lists the keys and labels for a Codex window-row job, no engineering value is needed.
712. [chunk 12 #53] BUG-547 | UNCLEAR | pilot-critical no | Grouped list of about 30 values; only merge #1819 (2785f072) appears; needs a per-item split before a builder can take it.
713. [chunk 12 #54] BUG-548 | NEEDS-TIM | pilot-critical no | The one MEDIUM waits on Tim's BUG-496 choice (lintel and schedule-placement values stored per PC); the seven LOWs are small but stay with the entry.
714. [chunk 12 #55] BUG-549 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merge of PR #949 (d82424b9) on the Structural line; carpark: installed in 1.0.121; blocks colleague install until proven off by default.
715. [chunk 12 #56] BUG-550 | HAS-DRAFT | pilot-critical yes | PR #1794 (BUG-550/557 MarkupAI switch) was merged into train S-45 then reverted (8be5beec) after a Codex HOLD; the PR stays open for the next Structural train.
716. [chunk 12 #57] BUG-551 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 4b4f68b3 (Civil AI paths use CE's own connection only); carpark: installed via PRs #950, #951, #952.
717. [chunk 12 #58] BUG-552 | UNCLEAR | pilot-critical yes | Merge of PR #1225 (d06da987) covers part (a) Civil fault reports; (b) the diagnostics report, (c) Desktop zips and Structural drawing-name coding have no commit found.
718. [chunk 12 #59] BUG-553 | NEEDS-TIM | pilot-critical yes | "Tim's rules do not cover this"; the entry asks Tim to rule on turning the automatic pip install OFF versus shipping the packages.
719. [chunk 12 #60] BUG-554 | NEEDS-TIM | pilot-critical yes | The entry asks Tim to rule on signature check versus shipping the WebView2 installer; whether the scheduled-task update source honours signed approval is not established.
720. [chunk 13 #1] BUG-555 | INSTALLED-WAITING-PROOF | pilot-critical no | CDHELP web fallback off by default: commit c2febcd4 (PR #1167), in Civil since 3.0.75, entry says installed 3.0.70; no AutoCAD look recorded.
721. [chunk 13 #2] BUG-556 | INSTALLED-WAITING-PROOF | pilot-critical no | Dead Azure upload code deleted in commit 2c20c16d (PR #1169), in Civil since 3.0.63; nothing visible to drive, proof is a search of the built DLL.
722. [chunk 13 #3] BUG-557 | NEEDS-TIM | pilot-critical no | Route 8 heartbeat switch is built (commit f835aafe, PR #1171) but route 12 (Structural time log falls back to the first OneDrive folder) is still in the code (SettingsManager.cs line 228); Tim to rule: remove the personal-OneDrive fallback?
723. [chunk 13 #4] BUG-558 | NEEDS-TIM | pilot-critical no | Entry's own final status says AutoCAD native behaviour (vanilla AutoCAD loses Redo after a view change); Tim to confirm; help-line commit a904d468 is in.
724. [chunk 13 #5] BUG-559 | UNCLEAR | pilot-critical no | CDIMPORTXCIVIL short P8 pipe explanation line missing; cause unknown, no commit, no PR; needs a re-run and a code read of the 3.0.41 path.
725. [chunk 13 #6] BUG-560 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 2f3f4df6 (CD binds CE's record before picking, Civil 3.0.50, PR #1244) matches hypothesis 2; the click-based cause was never proven, so confirm with a clicked pick on a second-opened drawing.
726. [chunk 13 #7] BUG-561 | HAS-DRAFT | pilot-critical yes | Fix commit e54b0aa5 is only on branch bug561-detention-sides (draft PR #987), not in the latest Civil line; entry warns the 30-degree square-to-0 case must also be tested.
727. [chunk 13 #8] BUG-562 | DUPLICATE-OF-BUG-435 | pilot-critical no | Entry's own last Status line says duplicate of BUG-435 (stale menus in Tim's acad.cuix), closed on Tim's yes, decision 178.
728. [chunk 13 #9] BUG-563 | HAS-DRAFT | pilot-critical no | Wording fix rides in draft PR #989 (with BUG-560); current code shows the dash in the window text, but I did not confirm the command-line text.
729. [chunk 13 #10] BUG-564 | DUPLICATE-OF-BUG-469 | pilot-critical no | Entry's own last Status line says duplicate of BUG-469 (FEDIT Esc leaves an undo step), closed on decision 178.
730. [chunk 13 #11] BUG-565 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 0c0c5153 (PR #1090) in Civil since 3.0.49; Codex W59b PASS on 3.0.48 recorded in the entry; Tim has not confirmed; the Edit Pit add-a-label case still fails late.
731. [chunk 13 #12] BUG-566 | HAS-DRAFT | pilot-critical no | Structural line still sets MENUBAR to 1 unchecked (CuiMenuGeneratorService.cs line 1419); fix is draft PR #1245 with a switch.
732. [chunk 13 #13] BUG-567 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-only; entry's last Status says WONT FIX, closed on decision 178.
733. [chunk 13 #14] BUG-568 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-only; entry's last Status says WONT FIX, closed on decision 178.
734. [chunk 13 #15] BUG-569 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-guard only; entry's last Status says WONT FIX, closed on decision 178.
735. [chunk 13 #16] BUG-583 | INSTALLED-WAITING-PROOF | pilot-critical no | ABS on a locked layer: commit 30e0270a (PR #1264) in Structural since 1.0.118; mixed-selection case never tested.
736. [chunk 13 #17] BUG-584 | INSTALLED-WAITING-PROOF | pilot-critical no | R1/FJ1/P1 now say when the block did not take the span: commit 0629b5fd, Structural 1.0.118 (entry says installed 1.0.121, PR #1295); it discloses the failure but the block width cause is not fixed, so the entry may need to stay open.
737. [chunk 13 #18] BUG-585 | INSTALLED-WAITING-PROOF | pilot-critical no | Esc at purlin lap question: commit 8e87d666 (PR #1270), Structural since 1.0.118; no AutoCAD look recorded.
738. [chunk 13 #19] BUG-586 | INSTALLED-WAITING-PROOF | pilot-critical yes | Custom Pit Schedule note kept beside With Step Irons: commits b27c49d2 and 13a77f38 (PR #1286), Civil since 3.0.51; no AutoCAD look recorded.
739. [chunk 13 #20] BUG-587 | HAS-DRAFT | pilot-critical no | Pit Schedule row grows to fit long notes: draft PR #1881 (B-028); not in the Civil line.
740. [chunk 13 #21] BUG-588 | INSTALLED-WAITING-PROOF | pilot-critical no | CDCHECK saved list includes away FALL arrows: commit 48f3480a (PR #1271), Civil since 3.0.51.
741. [chunk 13 #22] BUG-589 | INSTALLED-WAITING-PROOF | pilot-critical yes | First CDCHECK after reopening reads the saved pit list: commit 9c2e3d50 (PR #1266), Civil since 3.0.51; HIGH in the entry.
742. [chunk 13 #23] BUG-590 | INSTALLED-WAITING-PROOF | pilot-critical no | Issue state on every printed page and Excel tab: commit 4b741083 (PR #1281), Civil since 3.0.51.
743. [chunk 13 #24] BUG-591 | INSTALLED-WAITING-PROOF | pilot-critical no | Excel numbers saved as numbers: commit 558d7666 (with PR #1281), Civil since 3.0.51.
744. [chunk 13 #25] BUG-592 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pipe Flows shows Unknown not 0.00: commit 7553cea9 (PR #1274), Civil since 3.0.51; entry says installed 3.0.70.
745. [chunk 13 #26] BUG-593 | HAS-DRAFT | pilot-critical yes | Catchment stale flow after invalid rainfall: window fix in draft PR #1259 (old base rel-20261010b); no merged commit found; export side not integrated.
746. [chunk 13 #27] BUG-594 | INSTALLED-WAITING-PROOF | pilot-critical yes | Blue Factor rating report reader: commit be7827b8 (PR #1277), Civil since 3.0.51; HIGH in the entry.
747. [chunk 13 #28] BUG-595 | UNCLEAR | pilot-critical no | AutoCAD session would not close after the report-pick window; cause unproven, no commit; fresh-session workaround only.
748. [chunk 13 #29] BUG-596 | HAS-DRAFT | pilot-critical no | Whole-pipe loss labelled m/m: one-word label change in draft PR #1259; no merged commit found.
749. [chunk 13 #30] BUG-597 | INSTALLED-WAITING-PROOF | pilot-critical yes | Charged System shows Unknown for missing inputs: commit cfd179ea (PR #1275), Civil since 3.0.51.
750. [chunk 13 #31] BUG-598 | HAS-DRAFT | pilot-critical yes | Typed area still labelled Rating report: draft PR #1259 only; no merged commit found.
751. [chunk 13 #32] BUG-599 | INSTALLED-WAITING-PROOF | pilot-critical no | CDPROFILE names the missing DASHDOT2 before Apply: commit d95f2f55 (PR #1284), Civil since 3.0.51.
752. [chunk 13 #33] BUG-600 | INSTALLED-WAITING-PROOF | pilot-critical no | Long section title clears the scale note: commit c9509bda (PR #1291), Civil since 3.0.51.
753. [chunk 13 #34] BUG-601 | INSTALLED-WAITING-PROOF | pilot-critical no | Section update redraws without REGEN: commit 365c287e (PR #1290), Civil since 3.0.51.
754. [chunk 13 #35] BUG-602 | INSTALLED-WAITING-PROOF | pilot-critical no | LandXML that reads nothing now says so: commit f6389f40 (PR #1276), Civil since 3.0.51.
755. [chunk 13 #36] BUG-603 | INSTALLED-WAITING-PROOF | pilot-critical yes | LandXML Read source no longer writes: commit 2c490bca (PR #1308) plus ad6e7f9e, Civil since 3.0.51; HIGH in the entry.
756. [chunk 13 #37] BUG-604 | INSTALLED-WAITING-PROOF | pilot-critical no | LandXML results name their source: commit f6389f40 (same PR #1276), Civil since 3.0.51; later commits are tests only.
757. [chunk 13 #38] BUG-605 | INSTALLED-WAITING-PROOF | pilot-critical yes | LandXML inverts kept: commits f6389f40 and 8a54cef0 (PR #1276), Civil since 3.0.51; entry says installed 3.0.70, robot or Codex observation PASS noted in the carpark text.
758. [chunk 13 #39] BUG-606 | INSTALLED-WAITING-PROOF | pilot-critical no | CDCHECKDWG report goes to the CE report folder: commit 2b159615 (PR #1280), Civil since 3.0.51.
759. [chunk 13 #40] BUG-607 | INSTALLED-WAITING-PROOF | pilot-critical no | Comparison no longer says overall 100% with missing assets: commit c7dd9cda (PR #1279), Civil since 3.0.51.
760. [chunk 13 #41] BUG-608 | HAS-DRAFT | pilot-critical no | N/A on a checklist item asks why: draft PR #1606 (stacked on #1605); not in the Structural line.
761. [chunk 13 #42] BUG-609 | FIXABLE-NOW | pilot-critical no | Clear the checklist display when the last drawing closes; only a tests-only draft (PR #1260) exists, no design question open.
762. [chunk 13 #43] BUG-610 | INSTALLED-WAITING-PROOF | pilot-critical yes | Checklist survives N/A then Undo: commit eb7e41e0 (PR #1605), Structural since 1.0.124; HIGH in the entry.
763. [chunk 13 #44] BUG-611 | INSTALLED-WAITING-PROOF | pilot-critical no | Timber preview wording: commit 0bae4ef8 (PR #1262) is in the Structural line (checked); entry's own note says it needs a Codex look in AutoCAD.
764. [chunk 13 #45] BUG-612 | UNCLEAR | pilot-critical no | SBEAMEDIT cannot read a fresh 200PFC; commit 65a1f723 only names the real cause, the root cause was never found; needs a diagnosis run.
765. [chunk 13 #46] BUG-613 | HAS-DRAFT | pilot-critical no | Part-move warning in draft PR #1931 (Tim decision 158); full grouping (card ST-08) is after the pilot.
766. [chunk 13 #47] BUG-614 | INSTALLED-WAITING-PROOF | pilot-critical no | Hatches follow any scale: commit cfaa62ca (PR #1278), Structural since 1.0.118; Codex look 18 Oct saw no refusal at 1:50 on typed routes only, window route unlooked.
767. [chunk 13 #48] BUG-615 | NEEDS-TIM | pilot-critical no | Tim decision 166: command card first; Tim must approve the live-preview and Apply card before code (card queued, job z4).
768. [chunk 13 #49] BUG-616 | HAS-DRAFT | pilot-critical no | XRL waits for Apply: draft PR #1901 (B-080); not in the Structural line.
769. [chunk 13 #50] BUG-617 | INSTALLED-WAITING-PROOF | pilot-critical no | XRL names a locked layer before creating anything: commit e877b453 (PR #1287), Structural since 1.0.118.
770. [chunk 13 #51] BUG-618 | UNCLEAR | pilot-critical no | CXREF eInvalidKey; commit 65a1f723 only names the failing step, the copy still fails by the entry; needs a diagnosis run.
771. [chunk 13 #52] BUG-619 | INSTALLED-WAITING-PROOF | pilot-critical no | CEHATCHAUDIT and CEHATCHCHANGE read hatches outside the transaction: commit 670da629 (PR #1265), Structural since 1.0.118.
772. [chunk 13 #53] BUG-620 | INSTALLED-WAITING-PROOF | pilot-critical no | FASTSAVE only saves unless Settings FastSaveAlsoCleans is on: commit e877b453 (PR #1287), Structural since 1.0.118; I did not read the switch default.
773. [chunk 13 #54] BUG-621 | INSTALLED-WAITING-PROOF | pilot-critical yes | CE commands hand back colour, linetype, lineweight and dimension style: commits 1251b22f and 8a4bf682 (PR #1282), Structural since 1.0.118, switch default on.
774. [chunk 13 #55] BUG-622 | INSTALLED-WAITING-PROOF | pilot-critical no | MLL/MLR accept F: commits d5d64fd3 and dc7dfe19 (PR #1304), Structural since 1.0.118.
775. [chunk 13 #56] BUG-623 | UNCLEAR | pilot-critical no | Blank native text editor with Undefined shape; intermittent, font or style cause unproven, investigation entry; now seen in three places.
776. [chunk 13 #57] BUG-624 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit d5d64fd3 (PR #1304) reports a wrong-side note plainly; it may not move the note, so check the wrong-side placement itself.
777. [chunk 13 #58] BUG-625 | HAS-DRAFT | pilot-critical yes | Level Update only changes CE level marks: draft PRs #1885 and #1879 (B-065); not in the Structural line; HIGH in the entry.
778. [chunk 13 #59] BUG-626 | HAS-DRAFT | pilot-critical no | FFL Manual and Unknown with preview: draft PR #1933 (B-107); Tim decision 162 given.
779. [chunk 13 #60] BUG-627 | HAS-DRAFT | pilot-critical no | FFL triangle, tail and value move as one group: draft PR #1934 (B-108); Tim decision 163 given.
780. [chunk 14 #1] BUG-628 | ALREADY-FIXED | pilot-critical no | commit cfaa62ca (BL zigzag follows drawing scale, Structural line rel-20261026s, "needs Opus review"); Codex 18 Oct saw it before this; no AutoCAD proof since.
781. [chunk 14 #2] BUG-629 | ALREADY-FIXED | pilot-critical no | commits 6e77bf21 and 2965212f (BL and 25C text go into the current space, sized as plotted) on the Structural line; not proven in AutoCAD.
782. [chunk 14 #3] BUG-630 | HAS-DRAFT | pilot-critical no | draft PR #1981 (branch fb/bug630-section-mark-preview, SM card approved by Tim decision 171); block direction not yet applied.
783. [chunk 14 #4] BUG-631 | NEEDS-TIM | pilot-critical no | question: how should the section cut line, both bubbles and labels be tied together so they move as one (design pass inside the approved SM card, not answered).
784. [chunk 14 #5] BUG-632 | NEEDS-TIM | pilot-critical no | fix 80943121 exists but finalizer bf33ad78 ships it OFF "until Tim rules"; question: should the section letter sit in the clear half of the bubble by default?
785. [chunk 14 #6] BUG-633 | ALREADY-FIXED | pilot-critical no | commit 7d9599b5 (DSET accepts any kind of dimension) on the Structural line; not proven in AutoCAD.
786. [chunk 14 #7] BUG-634 | NEEDS-TIM | pilot-critical no | question: approve the DSET workflow card (mapping already given in decision 172: other styles become TIM LEADER or TIM DOT LEADER, old style purged); card still DRAFT, nothing built.
787. [chunk 14 #8] BUG-635 | ALREADY-FIXED | pilot-critical yes | commits 79c6af98 and bf7a3e82 (DSET, DSET1, DUP redraw and read the number back, switch default on); not proven in AutoCAD.
788. [chunk 14 #9] BUG-636 | NEEDS-TIM | pilot-critical yes | engine half merged (REGRESSION_LOG Structural line 803/808), but the pick, Preview and Apply window needs the DSET card approved (same question as BUG-634).
789. [chunk 14 #10] BUG-637 | UNCLEAR | pilot-critical no | Civil half built (REGRESSION_LOG 5700/5711, custom note beside "With Step Irons"); missing: an AutoCAD run of DUP to see if the two schedule notes still change, cause was never proved.
790. [chunk 14 #11] BUG-638 | ALREADY-FIXED | pilot-critical yes | REGRESSION_LOG entry at line 803 on the Structural line (locked-layer dimension refused, with BUG-583); no commit message names it and no AutoCAD proof.
791. [chunk 14 #12] BUG-639 | CLOSED-OR-WONT-FIX | pilot-critical no | Status line: WONT FIX, docs only, closed on Tim's yes (decision 178, 31 Oct).
792. [chunk 14 #13] BUG-640 | HAS-DRAFT | pilot-critical no | draft PR #1907 (B-087, switch Annotation.ArcDimSelectsGeometryFirst); built and unit-tested only.
793. [chunk 14 #14] BUG-641 | NEEDS-TIM | pilot-critical no | question: what dividing rule splits the catchment between pits (nearest pit, or drawn by the drafter)? REGRESSION_LOG 5828 says this is Tim's call.
794. [chunk 14 #15] BUG-642 | HAS-DRAFT | pilot-critical no | draft PR #1924 (B-111, branch claude/bug-642-catchment-label-clear-spot); first fix 287f788f is installed and still fails (Codex 18 Oct); units question with CE 04.
795. [chunk 14 #16] BUG-643 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 137834ed via PR #1269, installed in Civil 3.0.70; not yet tested by robot or Codex.
796. [chunk 14 #17] BUG-644 | HAS-DRAFT | pilot-critical no | branch origin/claude/bug-644-text-side-at-insertion (261aa2e9, F flips Top and Bottom at 25L insertion); PR number not verified (gh not available).
797. [chunk 14 #18] BUG-645 | HAS-DRAFT | pilot-critical no | branch origin/claude/bug-645-r2ltxt-ask-first (5fece523, R2LTXT asks first); PR number not verified (gh not available).
798. [chunk 14 #19] BUG-646 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 1251b22f via PR #1282, installed in Structural 1.0.121 per the entry; not yet tested by robot or Codex.
799. [chunk 14 #20] BUG-647 | UNCLEAR | pilot-critical no | CDFW part fixed (fb04a578), but the strip as a real asset whose MOVE carries its 17 child items has no stated design; missing: a build plan for the compound strip record.
800. [chunk 14 #21] BUG-648 | FIXABLE-NOW | pilot-critical no | AG drain accepts but draws no grade text; expected (visible 1:50 label tied to the run, one per run) is clear and no fix exists in either line.
801. [chunk 14 #22] BUG-649 | ALREADY-FIXED | pilot-critical yes | commits 3fb0ddbb and 72e2295f (rising drain warns, never "meets"), REGRESSION_LOG 5575 area; not proven in AutoCAD.
802. [chunk 14 #23] BUG-650 | ALREADY-FIXED | pilot-critical yes | commit da006db6 (cancelling CDFW or CDSOURCE no longer blanks pit inverts); not proven in AutoCAD.
803. [chunk 14 #24] BUG-697 | ALREADY-FIXED | pilot-critical no | commits 12ec1d1c and 1041f89b; Status line is FIXED (Claude-accepted, Civil 3.0.75, runner R39).
804. [chunk 14 #25] BUG-698 | ALREADY-FIXED | pilot-critical yes | commits b2c0a5bb and 225f0fc0; Status line is FIXED (Codex-accepted, Civil 3.0.64) and robot runs 31 to 46 pass.
805. [chunk 14 #26] BUG-856 | ALREADY-FIXED | pilot-critical no | commit e27b4971; Status line is FIXED (Codex-accepted, Civil 3.0.67, 21 Oct).
806. [chunk 14 #27] BUG-857 | ALREADY-FIXED | pilot-critical no | PR #1858 merged at c92db9ad (Esc and X cancel, Cancel button added); message says NOT BUILT, not proven in AutoCAD.
807. [chunk 14 #28] BUG-858 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 55a507f9 via PR #1510, installed in Structural 1.0.121; not yet tested by robot or Codex.
808. [chunk 14 #29] BUG-859 | UNCLEAR | pilot-critical no | PR #1834 (9b2da5c3) merged, but the robot failed 2 of 3 runs on Civil 3.0.88 (one pass was a one-off); missing: why the double-click route is flaky.
809. [chunk 14 #30] BUG-860 | ALREADY-FIXED | pilot-critical no | PR #1862 merged at c8df2e8c (green label double-click opens Edit source, switch ON); not proven in AutoCAD.
810. [chunk 14 #31] BUG-861 | UNCLEAR | pilot-critical yes | only diagnostic builds merged (PRs #1779, #1798, #1818, #1829); the robot still loses REDO after the first click on 3.0.83 and the cause is unknown.
811. [chunk 14 #32] BUG-862 | ALREADY-FIXED | pilot-critical no | commit 95eafe45 (command outcome line says completed after an Esc-ended run, refused for refusals); log line only.
812. [chunk 14 #33] BUG-863 | ALREADY-FIXED | pilot-critical no | Status line is FIXED (Claude-accepted, Civil 3.0.75, runner R10); guard commit d463134a.
813. [chunk 14 #34] BUG-864 | ALREADY-FIXED | pilot-critical no | PR #1529 merged into S-44 at 4db7661a (existing hidden layers kept); not proven in AutoCAD.
814. [chunk 14 #35] BUG-865 | UNCLEAR | pilot-critical no | no fix found; missing: the entry gives no speed target or measured drawing size, and its own text says a later Status line follows but none exists.
815. [chunk 14 #36] BUG-CDCHECKIGNORE-UNDO-C60 | ALREADY-FIXED | pilot-critical no | PR #1524 merged (eabeda2c, code 0d6ab60a); entry still says real-AutoCAD acceptance pending.
816. [chunk 14 #37] BUG-866 | NEEDS-TIM | pilot-critical yes | question: what should the CDDESIGN rainfall-curve note say, and are the curve values right (6 to 8 per cent low on Glen Eira sheets)? Branch b130-bug-866-rainfall-note exists, no ruling yet.
817. [chunk 14 #38] BUG-867 | ALREADY-FIXED | pilot-critical yes | PR #1530 merged at acd73cb4 (grade and speed on real pipe length, branch cx/eng-real-length-c60); not proven in AutoCAD.
818. [chunk 14 #39] BUG-868 | ALREADY-FIXED | pilot-critical yes | commit b8c17aa1 (PR #1676, pipe material in network sizing, switch ON); the first draft #1537 was never merged but this finished it.
819. [chunk 14 #40] BUG-869 | ALREADY-FIXED | pilot-critical yes | PR #1531 merged at 8f2d73fe (Pit Schedule depth to pit floor, commits 4a438d26 and ca83afd0); not proven in AutoCAD.
820. [chunk 14 #41] BUG-870 | HAS-DRAFT | pilot-critical yes | draft PR #1551 (branch cx/eng-move-pit-grade-c60, not merged); live wiring blocked behind a Settings switch in a protected file.
821. [chunk 14 #42] BUG-871 | ALREADY-FIXED | pilot-critical yes | PR #1538 merged at 218f09e7 (CDTWL reads drawing units, bf311924); not proven in AutoCAD.
822. [chunk 14 #43] BUG-872 | DUPLICATE-OF-BUG-095 | pilot-critical no | Status line says duplicate of BUG-095 and BUG-307; test-only fix, no separate work.
823. [chunk 14 #44] BUG-873 | HAS-DRAFT | pilot-critical no | PR #1977 (B-125, commit 9022d0d1, switch ON) is merged only in the newer C-79c on rel-20261112a, not in rel-20261102a.
824. [chunk 14 #45] BUG-874 | ALREADY-FIXED | pilot-critical no | commit cda22fb9 with review fix f119d8e7 (Esc after a CD pipe keeps the callout linked); not proven in AutoCAD.
825. [chunk 14 #46] BUG-875 | ALREADY-FIXED | pilot-critical no | PR #1650 merged (6b0a09da, follow-up 4f66d540); switch OFF today.
826. [chunk 14 #47] BUG-876 | ALREADY-FIXED | pilot-critical no | commit 73bc8264 (Replace keeps old pit when new one cannot be drawn); not proven in AutoCAD.
827. [chunk 14 #48] BUG-877 | ALREADY-FIXED | pilot-critical no | commit 91d8c39d with review fix 98006988 (import page no longer shows the first file after another is chosen); not proven in AutoCAD.
828. [chunk 14 #49] BUG-878 | ALREADY-FIXED | pilot-critical no | commit fca3e025 (a pipe no longer takes the single level named for another pipe); not proven in AutoCAD.
829. [chunk 14 #50] BUG-879 | FIXABLE-NOW | pilot-critical no | clear expected result (any CE hand move marks the label as hand-placed), file references given, Opus-checked; no fix in either line; protected file so Sonnet lane.
830. [chunk 14 #51] BUG-880 | ALREADY-FIXED | pilot-critical no | commit c857bdf9 (CEMEMBER held in a non-millimetre drawing) on the Structural line; chose the "warn" option; not proven in AutoCAD.
831. [chunk 14 #52] BUG-881 | ALREADY-FIXED | pilot-critical no | PR #1577 merged at b02389e2 (commit 8564a300, hatch audit keeps scale when scales disagree).
832. [chunk 14 #53] BUG-882 | FIXABLE-NOW | pilot-critical no | Installer/app.manifest line 7 on rel-20261102a still says requireAdministrator; pilot uses a hand install so not critical for 9 Nov.
833. [chunk 14 #54] BUG-883 | NEEDS-TIM | pilot-critical no | question: should double-clicking the installer do a first install (and what does it install), or does the pilot stay on hand install? Only the folder step HUNT-M-14 (280e7681) exists.
834. [chunk 14 #55] BUG-884 | ALREADY-FIXED | pilot-critical no | PR #1647 merged at 5ebefe6c (approvals resolve under each PC's office root, 066f8e09).
835. [chunk 14 #56] BUG-885 | HAS-DRAFT | pilot-critical no | draft PR #1649 (branch cx2/bug-885-frozen-packaging, not merged in rel-20261102a).
836. [chunk 14 #57] BUG-886 | ALREADY-FIXED | pilot-critical no | PR #1648 merged at 74cf6294 (office approval floor, unknown-office warning kept).
837. [chunk 14 #58] BUG-887 | HAS-DRAFT | pilot-critical no | draft PR #1652 (branch cx2/bug-887-shared-pair, commit 3ce97d64, not merged in rel-20261102a).
838. [chunk 14 #59] BUG-888 | FIXABLE-NOW | pilot-critical no | entry states a clear expected result (tested recovery of a complete pair, documented uninstall); no fix found in the installer code.
839. [chunk 14 #60] BUG-889 | ALREADY-FIXED | pilot-critical no | PR #1653 merged at b77c1a5b (Ignore offers "Asked again" rows); switch OFF today.
840. [chunk 15 #1] BUG-890 | HAS-DRAFT | pilot-critical no | branch origin/claude/b125-n11-bug890-leaderout-plain-labels-stay (1 Nov, B-125, switch linking.tidyLeade...) is not in either release line; no PR number verified.
841. [chunk 15 #2] BUG-891 | HAS-DRAFT | pilot-critical no | branch origin/claude/b125-n11-bug891-tidy-scan-own-space-and-reach (1 Nov) is not merged; switch OFF.
842. [chunk 15 #3] BUG-892 | ALREADY-FIXED | pilot-critical no | commit 498f0f7a on the Civil line, REGRESSION_LOG entry "BUG-892"; REDO loss never seen in AutoCAD.
843. [chunk 15 #4] BUG-893 | FIXABLE-NOW | pilot-critical no | only branch cx2/bug-893-ledger-batch05 (1 commit that routes the work, no code); Expected is clear, protected file so Sonnet lane.
844. [chunk 15 #5] BUG-894 | FIXABLE-NOW | pilot-critical no | same routing-only branch as BUG-893, no fix written; switch OFF.
845. [chunk 15 #6] BUG-895 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; Expected is clear ("Moved" counts real moves).
846. [chunk 15 #7] BUG-896 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; builder picks the bounded-work wording; switch OFF.
847. [chunk 15 #8] BUG-897 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; builder picks the work cap, Expected says "no hard block"; switch OFF.
848. [chunk 15 #9] BUG-898 | HAS-DRAFT | pilot-critical yes | branch origin/claude/b122-bug898-import-results-from-drawn (31 Oct, B-122) builds on the BUG-505 work (PR #1853 is merged) but is not merged itself.
849. [chunk 15 #10] BUG-899 | ALREADY-FIXED | pilot-critical yes | PR #1654 merged at ca5553d6 on the Civil line; not seen in AutoCAD.
850. [chunk 15 #11] BUG-900 | FIXABLE-NOW | pilot-critical yes | no commit, branch or log entry found; Expected is clear (collect rows from every schedule page); file Extract-XcivilPdfSchedule.ps1.
851. [chunk 15 #12] BUG-901 | ALREADY-FIXED | pilot-critical yes | PR #1848 merged at 3261cf8f plus follow-up 21a3bbb4 (Unknown wall reads Unknown); REGRESSION_LOG says built and unit-tested only, Tim's ruling recorded there.
852. [chunk 15 #13] BUG-902 | HAS-DRAFT | pilot-critical no | branches fb/bug902-cover-unknown-note and wip/bug902-b026c-rebase-30oct (30 Oct) cover only the Unknown cover row; checking cover along the pipe still needs Tim's word after 9 Nov.
853. [chunk 15 #14] BUG-903 | HAS-DRAFT | pilot-critical yes | draft PR #1920 (B-096, branch fb/bug903-measure-to-pipe-top-b096) per the carpark Note, after Tim's "10yes"; not merged, not opened in AutoCAD.
854. [chunk 15 #15] BUG-904 | ALREADY-FIXED | pilot-critical yes | PR #1656 merged at cb53d0f8 (warns when the shortest storm governs); REGRESSION_LOG entry; not seen in AutoCAD.
855. [chunk 15 #16] BUG-905 | ALREADY-FIXED | pilot-critical yes | PR #1856 merged at b780b732 (switch detention.boydsUsesHardGroundC ON); REGRESSION_LOG says it stays open until Tim has seen it.
856. [chunk 15 #17] BUG-906 | ALREADY-FIXED | pilot-critical no | PR #1655 merged at 52efb49b; REGRESSION_LOG entry for 23 Oct.
857. [chunk 15 #18] BUG-907 | HAS-DRAFT | pilot-critical yes | branch origin/claude/b130-bug-907-obvert-warning (31 Oct, B-130) not merged; carpark says needs Tim's word after 9 Nov.
858. [chunk 15 #19] BUG-908 | HAS-DRAFT | pilot-critical no | draft PR #1982 (B-150) per the carpark Note covers only the X-Civil level range; the council and pump values still need Tim's numbers.
859. [chunk 15 #20] BUG-909 | NEEDS-TIM | pilot-critical no | question: should CEMEMBER keep the height of raised picks or refuse them, and should the section square follow the UCS?
860. [chunk 15 #21] BUG-910 | NEEDS-TIM | pilot-critical no | question: on a layout sheet should LBUH, LBH and CEMEMBER break marks always be paper-sized (carpark says needs Tim's word; nothing built).
861. [chunk 15 #22] BUG-911 | HAS-DRAFT | pilot-critical no | branch origin/claude/tl2-r501-bug911-label-units (23 Oct) is in neither release line; no PR number verified.
862. [chunk 15 #23] BUG-912 | HAS-DRAFT | pilot-critical no | branch origin/claude/tl2-r501-bug912-cemember-default-scale (23 Oct, "CEMEMBER uses the office default scale when DIMSCALE is 0") is in neither line.
863. [chunk 15 #24] BUG-913 | HAS-DRAFT | pilot-critical yes | PR #1534 (on HOLD, tip 7410fd93 is not in the Civil line); the "Not loaded" starting text is still in CeVersionWindow.xaml.
864. [chunk 15 #25] BUG-914 | HAS-DRAFT | pilot-critical yes | PR #1534 (on HOLD); "Then run the CE installer" is still in PluginManagerWindow.xaml.
865. [chunk 15 #26] BUG-915 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); CheckIgnoreCommand.cs still prints 40 rows but offers every number; switch OFF.
866. [chunk 15 #27] BUG-916 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); both contradictory refusal lines are still in IgnoredChecks.cs lines 90 and 93.
867. [chunk 15 #28] BUG-917 | ALREADY-FIXED | pilot-critical no | PR #1665 merged at 24b09bd9 (commit 4d4b9b9c names update stage names); not seen in AutoCAD.
868. [chunk 15 #29] BUG-918 | ALREADY-FIXED | pilot-critical no | PR #1672 merged at 8b3a1e09 (the unwired "will finish when every AutoCAD window is closed" promise replaced by an administrator step).
869. [chunk 15 #30] BUG-919 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "CONFLICT — n copies" is still in CeVersionReport.cs line 97.
870. [chunk 15 #31] BUG-920 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the switched-off message still has no tab name in CheckIgnoreCommand.cs.
871. [chunk 15 #32] BUG-921 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "no CE project record yet" is still in CheckIgnoreCommand.cs line 49.
872. [chunk 15 #33] BUG-922 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the "could not check" wording is unchanged in ChecksResult.cs.
873. [chunk 15 #34] BUG-923 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Rule value provenance" is still in RulebookEngine.cs line 76.
874. [chunk 15 #35] BUG-924 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "no minimum ... in the rulebook" wording is still in RulebookEngine.cs.
875. [chunk 15 #36] BUG-925 | FIXABLE-NOW | pilot-critical no | only branch cx2/bug-925-source-values (records blocked gates, no code change); Expected is clear (values in words, no handles).
876. [chunk 15 #37] BUG-926 | HAS-DRAFT | pilot-critical no | PR #1534 partly (on HOLD); "Unknown" still in LinkCommands.ReadOnlyAudit.cs and the Settings window.
877. [chunk 15 #38] BUG-927 | ALREADY-FIXED | pilot-critical no | PR #1633 merged at 0ea77f4b (CDTAG's two messages in plain words).
878. [chunk 15 #39] BUG-928 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the "Tim decides when to hide it" tooltip is still in AdvancedSettingsDialog.xaml and CivilSettingsView.xaml.
879. [chunk 15 #40] BUG-929 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Nothing draws this row today" is still in both Settings files.
880. [chunk 15 #41] BUG-930 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the eight Fixes-tab tooltips were not re-read one by one here.
881. [chunk 15 #42] BUG-931 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "start-up heartbeat (install ID ..." is still at AdvancedSettingsDialog.xaml line 1174.
882. [chunk 15 #43] BUG-932 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Furthest a label may move out" has no model-millimetre note yet; switch OFF.
883. [chunk 15 #44] BUG-933 | ALREADY-FIXED | pilot-critical no | PR #1526 tip 3cb4c807 is merged in the Civil line; I saw the Double-click and slow-check progress rows in the Settings window, but did not confirm all four ticks.
884. [chunk 15 #45] BUG-934 | NEEDS-TIM | pilot-critical no | question: which one name for the window (Settings or Preferences); ribbon JSON still says "Preferences", the Edit Pipe window is protected; partly changed by commit 4d4b9b9c.
885. [chunk 15 #46] BUG-935 | NEEDS-TIM | pilot-critical no | question: approve "Drawing Standards (CDMANAGER)" and "CE Suite Manager" as the two names; carpark says naming is Tim's call (wording drafted in #1534, on HOLD).
886. [chunk 15 #47] BUG-936 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "network topology" is still in the Civil command-registry.json.
887. [chunk 15 #48] BUG-937 | HAS-DRAFT | pilot-critical no | the "Repair Centre" label is fixed (24b09bd9) but the tooltip still reads "sync, rebuild, upgrade and diagnostics"; tooltip is in PR #1534 (on HOLD).
888. [chunk 15 #49] BUG-938 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "upload queued telemetry" is still in the Manager command-registry.json.
889. [chunk 15 #50] BUG-939 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); Help still lists "Pipes &" tabs at guide-content.js line 95.
890. [chunk 15 #51] BUG-940 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); Help line about who can switch Checks on is unchanged at guide-content.js line 58.
891. [chunk 15 #52] BUG-941 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Use single pipe entity" is still in CdDialog.xaml line 469.
892. [chunk 15 #53] BUG-942 | UNCLEAR | pilot-critical no | commit 4d4b9b9c names BUG-942 (PR #1665) but the Inspector and Edit Pit files still hold old text; missing: a read of the Inspector rows in a build to see which words remain.
893. [chunk 15 #54] BUG-943 | ALREADY-FIXED | pilot-critical no | commits 4d4b9b9c and 24b09bd9 (PR #1665, Repair Centre steps and labels).
894. [chunk 15 #55] BUG-944 | ALREADY-FIXED | pilot-critical no | PR #1634 merged at 9354d130 (five command-line messages in plain words).
895. [chunk 15 #56] BUG-945 | ALREADY-FIXED | pilot-critical no | PR #1637 merged at 584fd168 (CDAUDIT and Recover Inverts messages).
896. [chunk 15 #57] BUG-946 | ALREADY-FIXED | pilot-critical no | commit fc12426c (CEHEALTH warns when a tool is installed but not loaded), merged via 5fc37df6.
897. [chunk 15 #58] BUG-947 | ALREADY-FIXED | pilot-critical no | commit 1899db50 (a damaged prepared copy is set aside and a fresh verified copy prepared).
898. [chunk 15 #59] BUG-948 | ALREADY-FIXED | pilot-critical no | commit 6db38faf (Updates and Rollback opens the Manager Updates page for a colleague).
899. [chunk 15 #60] BUG-949 | NEEDS-TIM | pilot-critical no | question: should LBH keep its stated 50 at 1:100 (and LBUH keep paper density); nothing built.
900. [chunk 15 #61] BUG-950 | NEEDS-TIM | pilot-critical yes | the interim fix is merged on the Structural line (b86a2f01, shows unknown when brace types differ); the kN rating per bracing type still needs Tim's numbers.
901. [chunk 16 #1] BUG-951 | HAS-DRAFT | pilot-critical no | Fix be6e198f is on branch claude/tl2-r501-bug951-tag-heights only, not on the Structural line.
902. [chunk 16 #2] BUG-952 | NEEDS-TIM | pilot-critical no | Tim's 29 Oct ruling is open to two readings (is "dimscale = 120" really 20; CEMEMBER to follow the old SBEAM rule), and the entry says to show him a picture first; no build found.
903. [chunk 16 #3] BUG-953 | HAS-DRAFT | pilot-critical no | Fix 602bc901 is on pr/1592, not on the Structural line.
904. [chunk 16 #4] BUG-954 | NEEDS-TIM | pilot-critical no | Which scale rule each fixed hatch pair follows is Tim's choice; only a coverage note was found.
905. [chunk 16 #5] BUG-955 | ALREADY-FIXED | pilot-critical no | Commit 22d1f3ed is on the Structural line (rel-20261026s).
906. [chunk 16 #6] BUG-956 | ALREADY-FIXED | pilot-critical no | Commits 69fc3269 and d1779258 are on the Structural line.
907. [chunk 16 #7] BUG-957 | ALREADY-FIXED | pilot-critical no | Commit 78a2303f is on rel-20261102a.
908. [chunk 16 #8] BUG-958 | FIXABLE-NOW | pilot-critical no | Expected behaviour is plain, the file and line are named, and no commit or branch for it exists.
909. [chunk 16 #9] BUG-959 | FIXABLE-NOW | pilot-critical no | Expected behaviour is plain, the files are named, and no commit or branch for it exists.
910. [chunk 16 #10] BUG-960 | ALREADY-FIXED | pilot-critical no | PR #1690 is merged (a39b638b) on rel-20261102a, with palette pictures recorded.
911. [chunk 16 #11] BUG-961 | HAS-DRAFT | pilot-critical no | Commit 13b95ef8 is on pr/1691 (cx2/bug-961-manager-fields); the carpark names #1527, which is out of date.
912. [chunk 16 #12] BUG-962 | ALREADY-FIXED | pilot-critical no | PR #1980 (4b03038b) is merged on rel-20261112a, but it is not on rel-20261102a.
913. [chunk 16 #13] BUG-963 | ALREADY-FIXED | pilot-critical yes | Merged on rel-20261102a (ea752acf, 111b8e0a), with a new switch default ON.
914. [chunk 16 #14] BUG-964 | ALREADY-FIXED | pilot-critical yes | PR #1669 merged (d361f797) on rel-20261102a.
915. [chunk 16 #15] BUG-965 | ALREADY-FIXED | pilot-critical yes | Merged on rel-20261102a (c73df761, 92e83fa5, ea752acf).
916. [chunk 16 #16] BUG-966 | ALREADY-FIXED | pilot-critical yes | Commit 04fae248 is on rel-20261102a.
917. [chunk 16 #17] BUG-967 | ALREADY-FIXED | pilot-critical yes | Test and proof commits (c6f550c6, 6a4790f9) are on rel-20261102a; I did not find the fix commit itself by number, so check it before trusting this.
918. [chunk 16 #18] BUG-968 | ALREADY-FIXED | pilot-critical yes | Commit ffd8e500 is on rel-20261102a.
919. [chunk 16 #19] BUG-969 | ALREADY-FIXED | pilot-critical yes | PR #1692 merged (c0706e5e) on rel-20261102a.
920. [chunk 16 #20] BUG-970 | ALREADY-FIXED | pilot-critical yes | Commits 2fb1ff7c and 2bd5c2be are on rel-20261102a.
921. [chunk 16 #21] BUG-971 | ALREADY-FIXED | pilot-critical yes | PR #1658 merged (f007893b) on rel-20261102a.
922. [chunk 16 #22] BUG-972 | HAS-DRAFT | pilot-critical yes | Commit 2829c47a is on pr/1572, not on the Structural line.
923. [chunk 16 #23] BUG-973 | ALREADY-FIXED | pilot-critical yes | PR #1568 merged (8fc66fec) on the Structural line.
924. [chunk 16 #24] BUG-974 | ALREADY-FIXED | pilot-critical yes | Commit cecf3506 is on the Structural line.
925. [chunk 16 #25] BUG-975 | ALREADY-FIXED | pilot-critical yes | PR #1564 merged (c4768031) on the Structural line.
926. [chunk 16 #26] BUG-976 | HAS-DRAFT | pilot-critical yes | Commit 2fbfef93 is on pr/1560 (tl2-r501-bug976-notes-overwrite), not on the Structural line.
927. [chunk 16 #27] BUG-977 | ALREADY-FIXED | pilot-critical yes | PR #1563 merged (3e23cd99) on the Structural line.
928. [chunk 16 #28] BUG-978 | ALREADY-FIXED | pilot-critical yes | PR #1566 merged (a9d64a24) on the Structural line.
929. [chunk 16 #29] BUG-979 | ALREADY-FIXED | pilot-critical no | PR #1559 merged (b04f72dc) on rel-20261102a.
930. [chunk 16 #30] BUG-980 | ALREADY-FIXED | pilot-critical no | PR #1561 merged (7a62f39e) on rel-20261102a.
931. [chunk 16 #31] BUG-981 | ALREADY-FIXED | pilot-critical no | PR #1631 merged (fb15c3f3) on rel-20261102a.
932. [chunk 16 #32] BUG-982 | HAS-DRAFT | pilot-critical no | Commit 18c6393e is on pr/1643, not on rel-20261102a.
933. [chunk 16 #33] BUG-983 | ALREADY-FIXED | pilot-critical no | PR #1574 merged (a25bd244) on the Structural line.
934. [chunk 16 #34] BUG-984 | HAS-DRAFT | pilot-critical no | Commit d7299d1e is on pr/1579, not on the Structural line.
935. [chunk 16 #35] BUG-985 | ALREADY-FIXED | pilot-critical no | PR #1575 merged (be1a5e98) on the Structural line.
936. [chunk 16 #36] BUG-986 | ALREADY-FIXED | pilot-critical no | PR #1581 merged (e490038a) on the Structural line.
937. [chunk 16 #37] BUG-987 | ALREADY-FIXED | pilot-critical no | Commit 5ca3f08f is on rel-20261102a.
938. [chunk 16 #38] BUG-988 | ALREADY-FIXED | pilot-critical no | PR #1642 merged (746a55e4) on rel-20261102a.
939. [chunk 16 #39] BUG-989 | NEEDS-TIM | pilot-critical no | Does Rollback keep the permanent identities and undo the rest, or refuse with a plain line? The entry says it needs Tim's word; only a coverage note exists.
940. [chunk 16 #40] BUG-990 | HAS-DRAFT | pilot-critical no | Commit 9c7953ce is on pr/1620, not on rel-20261102a.
941. [chunk 16 #41] BUG-991 | ALREADY-FIXED | pilot-critical no | PR #1618 merged (9476b85e) on rel-20261102a.
942. [chunk 16 #42] BUG-992 | ALREADY-FIXED | pilot-critical no | PR #1640 merged (3b14fc3a) on rel-20261102a.
943. [chunk 16 #43] BUG-993 | ALREADY-FIXED | pilot-critical no | PR #1583 merged (7114f63a) on rel-20261102a.
944. [chunk 16 #44] BUG-994 | HAS-DRAFT | pilot-critical no | Commit 8ae9c2f3 is on pr/1588, not on rel-20261102a.
945. [chunk 16 #45] BUG-995 | ALREADY-FIXED | pilot-critical no | PR #1599 merged (5cf293b6) on rel-20261102a.
946. [chunk 16 #46] BUG-996 | ALREADY-FIXED | pilot-critical no | PR #1641 merged (eb906d15) on rel-20261102a.
947. [chunk 16 #47] BUG-997 | ALREADY-FIXED | pilot-critical no | PR #1627 merged (b0c6a305) on rel-20261102a.
948. [chunk 16 #48] BUG-998 | ALREADY-FIXED | pilot-critical no | PR #1626 merged (6731077a) on rel-20261102a.
949. [chunk 16 #49] BUG-999 | ALREADY-FIXED | pilot-critical no | Commit 330ee22f is on rel-20261102a; it says "could not solve" in plain words.
950. [chunk 16 #50] BUG-1000 | ALREADY-FIXED | pilot-critical no | PR #1607 merged (208029d0) on rel-20261102a.
951. [chunk 16 #51] BUG-1001 | ALREADY-FIXED | pilot-critical no | PR #1601 merged (e7c42c99) on rel-20261102a.
952. [chunk 16 #52] BUG-1002 | ALREADY-FIXED | pilot-critical no | PR #1616 merged (47284178) on rel-20261102a.
953. [chunk 16 #53] BUG-1003 | ALREADY-FIXED | pilot-critical no | PR #1565 merged (be16a462) on rel-20261102a.
954. [chunk 16 #54] BUG-1004 | ALREADY-FIXED | pilot-critical no | Commit e0397253 is on rel-20261102a.
955. [chunk 16 #55] BUG-1005 | ALREADY-FIXED | pilot-critical no | PR #1628 merged (db942f59) on rel-20261102a.
956. [chunk 16 #56] BUG-1006 | NEEDS-TIM | pilot-critical no | What replacement advice should the too-slow and too-fast pipe warnings give? The entry says it is Tim's engineering call; only a "held" note exists.
957. [chunk 16 #57] BUG-1007 | ALREADY-FIXED | pilot-critical no | PR #1573 merged (261e4f96) on rel-20261102a.
958. [chunk 16 #58] BUG-1008 | ALREADY-FIXED | pilot-critical no | PR #1569 merged (ba6cd492) on rel-20261102a.
959. [chunk 16 #59] BUG-1009 | ALREADY-FIXED | pilot-critical no | PR #1614 merged (ed399bfc) on rel-20261102a.
960. [chunk 16 #60] BUG-1010 | ALREADY-FIXED | pilot-critical no | PR #1580 merged (fc978c23) on rel-20261102a; the "does the first idle 5 minutes count" billing question is a separate Tim ruling that the fix leaves alone.
961. [chunk 17 #1] BUG-1011 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixed by 27b35e16 and 8690ce14 (Civil line), installed 3.0.88; typed depth now reaches the pit levels; no robot or Codex PASS recorded.
962. [chunk 17 #2] BUG-1012 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1578 (409feaf5) merged in the Civil line, installed; the closing side of a boundary is now read; no proof run.
963. [chunk 17 #3] BUG-1013 | HAS-DRAFT | pilot-critical no | Branch claude/tl2-r501-bug1013-manifest-stale (commit b1ea7a87) is not merged into either line; PR number not checked.
964. [chunk 17 #4] BUG-1014 | INSTALLED-WAITING-PROOF | pilot-critical no | c5990580 is in the Structural line (installed 1.0.125); schedule box now turns with the UCS; no proof run.
965. [chunk 17 #5] BUG-1015 | INSTALLED-WAITING-PROOF | pilot-critical no | 5a8feaec is in the Structural line, installed; a refused RIB or REB puts the line back; no proof run.
966. [chunk 17 #6] BUG-1016 | INSTALLED-WAITING-PROOF | pilot-critical no | 555bd7ef is in the Structural line, installed; saving templates keeps the waiting suggestions file; no proof run.
967. [chunk 17 #7] BUG-1017 | INSTALLED-WAITING-PROOF | pilot-critical yes | f514c8ef is in the Civil line, installed; Manager buttons and CE Blocks tiles now cancel a running command first; no proof run.
968. [chunk 17 #8] BUG-1018 | FIXABLE-NOW | pilot-critical no | Entry gives the fix (do not cache a "not loaded" answer) and a test; no commit found; only reachable where the pipe-object hold is off, so not a colleague issue.
969. [chunk 17 #9] BUG-1019 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1689 (324bec7c) merged in the Civil line, installed; CDCALC now treats levels at or below RL 0.00 as real; no proof run.
970. [chunk 17 #10] BUG-1020 | NEEDS-TIM | pilot-critical yes | Which pit depth wins when the recorded floor and the connected pipe inverts disagree (the entry says this is Tim's call).
971. [chunk 17 #11] BUG-1021 | HAS-DRAFT | pilot-critical yes | Branch b03/bug-1021-twl-lid-no-floor (commit 7884b0cf, one commit not in the Civil line) is unmerged; PR number not checked.
972. [chunk 17 #12] BUG-1022 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1629 (01c299c8) merged in the Civil line, installed; a re-found pit keeps its schedule override and row order; no proof run.
973. [chunk 17 #13] BUG-1023 | NEEDS-TIM | pilot-critical no | Drop the 90 per cent saved-order rule? It reopens the BUG-008 symptom unless BUG-008 is re-tested (entry says Tim decides).
974. [chunk 17 #14] BUG-1024 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1597 (10ed4f53) merged in the Civil line, installed; CDSPINEUPGRADE no longer says "Nothing to write" wrongly; no proof run.
975. [chunk 17 #15] BUG-1025 | HAS-DRAFT | pilot-critical yes | Branch claude/tl2-r501-bug1025-reobar-layout-units (commit b8026c89) is not merged into the Structural line; PR number not checked; bar length reads 100000 instead of 100 on a schedule.
976. [chunk 17 #16] BUG-1026 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1535 is merged into the Civil line (b121d90c, follow-up c9585bc8), installed; carpark status "not installed" is stale; no proof run.
977. [chunk 17 #17] BUG-1027 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1535, merged and installed; support-zip contents not re-read here; no proof run.
978. [chunk 17 #18] BUG-1028 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1694 (fb3cfe3d, c9585bc8) merged in the Civil line, installed; ribbon-build and switch-file failures now leave a log line; no proof run.
979. [chunk 17 #19] BUG-1029 | NEEDS-TIM | pilot-critical no | Does Tim want a CE menu entry per tool (Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate, Copy + Rotate) on AutoCAD 2022 to 2024?
980. [chunk 17 #20] BUG-1030 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1636 (612938af) merged in the Civil line, installed; closing CDCALC unchanged writes no undo step; no proof run.
981. [chunk 17 #21] BUG-1031 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1865 (c9ec8c3b) merged in the Civil line, installed; Delete cell is back on the right-click menu (switch ON); no proof run.
982. [chunk 17 #22] BUG-1032 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1635 (a5751512) merged in the Civil line, installed; pick list names the pipe by its pits and says ABOVE for a level over the lid; no proof run.
983. [chunk 17 #23] BUG-1033 | FIXABLE-NOW | pilot-critical no | Entry says copy the WSUD "Read-only" banner to the Pump System tab; only the tab tooltip has it today (CalculationsV2Dialog.xaml:780); no commit found.
984. [chunk 17 #24] BUG-1034 | NEEDS-TIM | pilot-critical no | Is IL text sitting on its own pipe line the intended "in from the pipe end" spot? Same root as BUG-1253, fix together.
985. [chunk 17 #25] BUG-1035 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1722 (db50498a) merged in the Civil line, installed; Shallow pit depth box added to Settings; no proof run.
986. [chunk 17 #26] BUG-1036 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1728 (115eeaf0) merged in the Civil line, installed; Pipe Flows roughness note follows the Settings value; no proof run.
987. [chunk 17 #27] BUG-1037 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1729 (0d215deb) is in the Structural line, installed; column bars drawn at real diameter (switch ON); no proof run.
988. [chunk 17 #28] BUG-1038 | HAS-DRAFT | pilot-critical yes | Branch fb/b5-bug1038-typed-bar-count (commits 115a5c19, 2878e6c2; PR #1731 named in the commit) is not merged into the Structural line; 14N20 still cannot be typed.
989. [chunk 17 #29] BUG-1039 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1732 (91530aef) is in the Structural line, installed; timber quantity of 10 or more accepted (switch ON); no proof run.
990. [chunk 17 #30] BUG-1040 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1734 (eb3a2889) merged in the Civil line, installed; a kept flat pipe warns and the cascade carries on; no proof run.
991. [chunk 17 #31] BUG-1041 | HAS-DRAFT | pilot-critical yes | Branch fb/b6-bug1041-sheets-sync-scoped (commit 4ae66b1b) is not merged into the Structural line; PR number not checked.
992. [chunk 17 #32] BUG-1042 | FIXABLE-NOW | pilot-critical yes | Civil tip still returns Blocked("Enter the cover level.") at PitStartReadiness.cs:125; entry spells out the fix (warn, keep cover Unknown) and a test; sibling BUG-1043 shows the pattern.
993. [chunk 17 #33] BUG-1043 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1735 (46376980) merged in the Civil line, installed; the Civil tip still has a Blocked line at PipeStartReadiness.cs:188, so look at it when proof is run.
994. [chunk 17 #34] BUG-1044 | HAS-DRAFT | pilot-critical no | Branch cx6/bug-1044-bd30 (commits efaeff4c, 69643351, d38ca6ed, 4 not in the Civil line) is unmerged; PR number not checked.
995. [chunk 17 #35] BUG-1045 | FIXABLE-NOW | pilot-critical no | Structural half fixed (57c1b060, installed); the Civil half (CDDIAG, CDDASHBOARD, CDPARTS) still says "drawing is read-only" at DrawingSafetyService.cs:72.
996. [chunk 17 #36] BUG-1046 | FIXABLE-NOW | pilot-critical no | Civil tip still refuses in Paper Space at DrawingSafetyService.cs:117; entry gives the fix and a paper-space test; no commit found.
997. [chunk 17 #37] BUG-1047 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1738 (c5774cf2, 81d1772c) merged in the Civil line, installed; a frozen layer now warns "will be hidden" and places; switch default not read here.
998. [chunk 17 #38] BUG-1048 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1746 (518741ee) is in the Structural line, installed; hatch change now splits the selection; no proof run.
999. [chunk 17 #39] BUG-1049 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1743 (2a85890d) merged in the Civil line, installed; a blank ticked field no longer blocks the batch; no proof run.
1000. [chunk 17 #40] BUG-1050 | FIXABLE-NOW | pilot-critical no | Entry says allow deleting the last custom label style and fall back to built-in wording; LabelStyleDialogViewModel.cs still gates the button; no commit found.
1001. [chunk 17 #41] BUG-1051 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1753 (bb34aaee) merged in the Civil line, installed; slab fall worked in physical units (switch surface.slabFallUsesDrawingUnits ON); no proof run.
1002. [chunk 17 #42] BUG-1052 | FIXABLE-NOW | pilot-critical yes | AgiCommand.cs:268 still names drawing units "runLengthMm" and uses them as mm; entry gives the fix and a 1:10000 test; no commit found.
1003. [chunk 17 #43] BUG-1053 | FIXABLE-NOW | pilot-critical yes | LandXmlParser.cs reads elevRim with no unit conversion; entry spells out the rule (convert to metres, else Unknown) and a test; no commit found; no duplicate.
1004. [chunk 17 #44] BUG-1054 | FIXABLE-NOW | pilot-critical no | AgiCommand.Plan.cs:77 still compares a 1 mm tolerance with raw drawing units; entry gives the fix and a four-pick test; metre drawings only.
1005. [chunk 17 #45] BUG-1055 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1759 (8044f6ae) is the tip of its branch and merged in the Civil line, installed; message-only fix; no proof run.
1006. [chunk 17 #46] BUG-1056 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1056-habitable-floor-freeboard (commit adc9dbb8) is unmerged; entry also needs Tim's word on which floor evidence CE may use.
1007. [chunk 17 #47] BUG-1057 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1057-council-speed-bands (5 commits, tip 9fa33113) is unmerged; entry also needs Tim's word on the bands.
1008. [chunk 17 #48] BUG-1058 | HAS-DRAFT | pilot-critical no | Branch claude/b132-bug-1058-darebin-pit-spacing (commit 4c845162) is unmerged; entry also needs Tim's word.
1009. [chunk 17 #49] BUG-1059 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1059-maroondah-dn150-grade (commit 9c246a1c) is unmerged; entry also needs Tim's word.
1010. [chunk 17 #50] BUG-1060 | NEEDS-TIM | pilot-critical no | Which AS/NZS 3500.3 edition new jobs should show, and how it applies; default is still "2021" in UserSettings.cs:2750.
1011. [chunk 17 #51] BUG-1061 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1762 (f5cd0214) is in the Structural line, installed; RCBEAM warning and preview now match the drawing; no proof run.
1012. [chunk 17 #52] BUG-1062 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1762 (f5cd0214), installed; no-room warning stays on at zero width; no proof run.
1013. [chunk 17 #53] BUG-1063 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1762 (f5cd0214), installed; bar spacing no longer overstated by one bar diameter; no proof run.
1014. [chunk 17 #54] BUG-1064 | FIXABLE-NOW | pilot-critical yes | Entry gives the fix (one machine-wide install lock) and a disposable-folder test; no lock or mutex found in the installer on the Civil tip; Opus lane (protected installer).
1015. [chunk 17 #55] BUG-1065 | FIXABLE-NOW | pilot-critical yes | Entry gives the fix (retire the live bundle, say so plainly if clean-up fails) and a test; no commit found; Opus lane.
1016. [chunk 17 #56] BUG-1066 | FIXABLE-NOW | pilot-critical no | Entry gives the fix (keep the backup path in the failure record) and a test; no commit found; Opus lane.
1017. [chunk 17 #57] BUG-1067 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1719 (b6d3d692) merged in the Civil line; tests-only fix, so there is nothing to see in AutoCAD; no proof run.
1018. [chunk 17 #58] BUG-1068 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1719 (b6d3d692); tests-only fix; no proof run.
1019. [chunk 17 #59] BUG-1069 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1766 (d5f3c84d) is in the Structural line, installed; tests-only fix; no proof run.
1020. [chunk 17 #60] BUG-1070 | HAS-DRAFT | pilot-critical yes | Branch claude/b118-bug1070-undo-hold (commit 6845a095) is unmerged; PR number not checked; CE data can silently stop saving after an Undo.
1021. [chunk 18 #1] BUG-1071 | HAS-DRAFT | no | Branch origin/fb/bug1071-skipped-save-honest (1 commit not yet in rel-20261102a); no PR number checked.
1022. [chunk 18 #2] BUG-1072 | HAS-DRAFT | no | Branch origin/fb/b12-BUG-1072-backup-words ("Also autosave" tick wording); not in the Civil line.
1023. [chunk 18 #3] BUG-1073 | HAS-DRAFT | no | Branch origin/fb/b12-BUG-1073-markup-unreadable (plain [CE] sentence); not in the Civil line.
1024. [chunk 18 #4] BUG-1074 | ALREADY-FIXED | no | Commit 9135d337 via PR #1718 is in rel-20261102a; carpark still says OPEN and no AutoCAD acceptance found.
1025. [chunk 18 #5] BUG-1075 | ALREADY-FIXED | no | Same commit 9135d337 / PR #1718 (CDSPINEUPGRADE wording) is in rel-20261102a; carpark still OPEN.
1026. [chunk 18 #6] BUG-1076 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1076-diagnostics-words; not in the Civil line.
1027. [chunk 18 #7] BUG-1077 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1077-bset-words; not in the Civil line.
1028. [chunk 18 #8] BUG-1078 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1078-markup-help-words; not in the Civil line.
1029. [chunk 18 #9] BUG-1079 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1079-pdf-help-words; not in the Civil line.
1030. [chunk 18 #10] BUG-1080 | FIXABLE-NOW | yes | No branch or commit found; the entry names the code (db.Insert in CDREFRESHBLOCKS) and the exact skip-and-say rule; protected-layer rule.
1031. [chunk 18 #11] BUG-1081 | FIXABLE-NOW | yes | No branch or commit found; entry says check each attribute's real layer and drop the allow-on-locked flag; protected-layer rule.
1032. [chunk 18 #12] BUG-1082 | HAS-DRAFT | yes | Branch origin/fb/b14-bug-1082-level-mark-locked (locked 25DIMS/25TEXT and REFEDIT stop); not in the Civil line.
1033. [chunk 18 #13] BUG-1083 | FIXABLE-NOW | yes | No branch or commit found; entry says reject an attached or overlaid Xref at the pick and at Apply, with a plain message.
1034. [chunk 18 #14] BUG-1084 | UNCLEAR | no | Entry itself says "not yet shown": Codex must first confirm in native AutoCAD that Hatch Change edits inside REFEDIT; no result recorded.
1035. [chunk 18 #15] BUG-1085 | ALREADY-FIXED | no | Commit c9b41484 via PR #1730 is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
1036. [chunk 18 #16] BUG-1086 | ALREADY-FIXED | no | Same commit c9b41484 / PR #1730 is in rel-20261102a; carpark still OPEN.
1037. [chunk 18 #17] BUG-1087 | ALREADY-FIXED | no | Commit 02508426 via PR #1733 is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
1038. [chunk 18 #18] BUG-1088 | HAS-DRAFT | yes | Branch origin/fb/bug1088-sizer-grade-ladder; entry says the preferred design grade number needs Tim's ruling, so check what number the draft used.
1039. [chunk 18 #19] BUG-1089 | HAS-DRAFT | yes | Branch origin/cx5/bug-1089-pipeflows-settings-limits (3 commits, recorded evidence); not in the Civil line.
1040. [chunk 18 #20] BUG-1090 | HAS-DRAFT | yes | Branch origin/fb/pc4-bug1090-hgl-not-checked (commit f3f38c24) sits one commit past rel-20261102a.
1041. [chunk 18 #21] BUG-1091 | HAS-DRAFT | yes | Branch origin/fb/bug1091-redesign-reads-min-fall (2 commits); not in the Civil line.
1042. [chunk 18 #22] BUG-1092 | HAS-DRAFT | yes | Branch origin/fb/bug1092-uphill-any-fall (2 commits, one a review fix); not in the Civil line.
1043. [chunk 18 #23] BUG-1093 | HAS-DRAFT | yes | Branch origin/fb/bug1093-cover-rl-zero (2 commits); not in the Civil line.
1044. [chunk 18 #24] BUG-1094 | HAS-DRAFT | yes | Branch origin/claude/b131-bug1094-inspector-grade-red (B-131); not in the Civil line.
1045. [chunk 18 #25] BUG-1095 | ALREADY-FIXED | yes | Commit b531c85e via PR #1852 (B-017) is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
1046. [chunk 18 #26] BUG-1096 | HAS-DRAFT | yes | Branch origin/fb/bug1096-reuse-boxes (3 commits, B-029b); not in the Civil line.
1047. [chunk 18 #27] BUG-1097 | ALREADY-FIXED | yes | Commit 2817bf97 via PR #1859 (B-034) is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
1048. [chunk 18 #28] BUG-1098 | HAS-DRAFT | yes | Branch origin/cx6/bug-1098-bd29 (Kingston credit and eligibility); not in the Civil line.
1049. [chunk 18 #29] BUG-1099 | HAS-DRAFT | no | Branch origin/fb/bug1099-council-tc (B-018); entry says Tim must rule first because the same Tc sizes the outlet pipe (question C17).
1050. [chunk 18 #30] BUG-1100 | NEEDS-TIM | no | Which "basis" choices does CDDESIGN ask for when a council has no reuse rule, and how is the answer saved on the job?
1051. [chunk 18 #31] BUG-1101 | ALREADY-FIXED | no | Commit 67e50f68 via PR #1770 is in rel-20261102a; carpark still OPEN.
1052. [chunk 18 #32] BUG-1102 | HAS-DRAFT | no | Branch origin/cx6/bug-1102-bd23 (underground detention warning); not in the Civil line.
1053. [chunk 18 #33] BUG-1103 | HAS-DRAFT | no | Branch origin/cx4/bug-1103-charged-diameter-sense (2 commits); not in the Civil line.
1054. [chunk 18 #34] BUG-1104 | HAS-DRAFT | no | Branch origin/claude/b132-bug-1104-tank-orifice-minimum is one commit ahead; a second branch cx6/bug-1104-bd24 is already inside the Civil line, so check which is current.
1055. [chunk 18 #35] BUG-1105 | FIXABLE-NOW | yes | No branch or commit found; entry gives the full rule (store rating, file, date, tank litres; warn on mismatch; typed-reason override).
1056. [chunk 18 #36] BUG-1106 | ALREADY-FIXED | no | Commit 3a0c8a5e via PR #1761 is in rel-20261102a; carpark still OPEN.
1057. [chunk 18 #37] BUG-1107 | HAS-DRAFT | no | Branch origin/cx6/bug-1107-bd26 (5 commits ahead); not in the Civil line.
1058. [chunk 18 #38] BUG-1108 | HAS-DRAFT | yes | Branch origin/fb/bug1108-reuse-share-minimum (B-120, 4 commits); not in the Civil line.
1059. [chunk 18 #39] BUG-1109 | NEEDS-TIM | no | May the office change council values through an overlay file in CDRULEBOOK, and who may do it?
1060. [chunk 18 #40] BUG-1110 | HAS-DRAFT | no | Branch origin/cx6/bug-1110-bd27 (3 commits); not in the Civil line.
1061. [chunk 18 #41] BUG-1111 | HAS-DRAFT | no | Branch origin/cx4/bug-1111-predev-c-working-text; not in the Civil line.
1062. [chunk 18 #42] BUG-1112 | HAS-DRAFT | no | Branch origin/claude/bug-1112-wsud-export-no-sample-site (B-061); not in the Civil line.
1063. [chunk 18 #43] BUG-1113 | HAS-DRAFT | no | Branch origin/cx4/bug-1113-bluefactor-same-name (2 commits); not in the Civil line.
1064. [chunk 18 #44] BUG-1114 | FIXABLE-NOW | no | No branch or commit found; entry asks for a tank list box on the Settings page, no engineering number needed.
1065. [chunk 18 #45] BUG-1115 | HAS-DRAFT | no | Branch origin/cx5/bug-1115-cdwt-typed-zero-detention (4 commits); not in the Civil line.
1066. [chunk 18 #46] BUG-1116 | HAS-DRAFT | no | Branch origin/claude/b132-bug-1116-large-lot-tc-note; not in the Civil line.
1067. [chunk 18 #47] BUG-1117 | NEEDS-TIM | no | Delete the unused ifd-melbourne.json, or make CE read it so the office can edit rainfall?
1068. [chunk 18 #48] BUG-1118 | FIXABLE-NOW | no | No branch or commit found; entry says scale the 100-unit preview through the drawing-unit conversion.
1069. [chunk 18 #49] BUG-1119 | CLOSED-OR-WONT-FIX | no | Status WONT FIX on Tim's yes (decision 178, 31 Oct 2026): no command calls the detector yet.
1070. [chunk 18 #50] BUG-1120 | NEEDS-TIM | no | Confirm the STORM "None" wording, the Bayside reuse formula and the charged-downpipe citation.
1071. [chunk 18 #51] BUG-1121 | HAS-DRAFT | no | Carpark note: DRAFT PR #1900 (B-081), built and unit-tested only.
1072. [chunk 18 #52] BUG-1122 | HAS-DRAFT | no | Carpark note: DRAFT PR #1905 (B-083), built and unit-tested only.
1073. [chunk 18 #53] BUG-1123 | HAS-DRAFT | no | Carpark note: DRAFT PR #1903 (B-083), built and unit-tested only.
1074. [chunk 18 #54] BUG-1124 | NEEDS-TIM | no | Approve a new CEMEMBER question "Upright leg [Long/Short]" for unequal angles (review-gate workflow card needed).
1075. [chunk 18 #55] BUG-1125 | NEEDS-TIM | no | Approve a new CEMEMBER "Standing/Flat" question for RHS (review-gate workflow card needed).
1076. [chunk 18 #56] BUG-1126 | HAS-DRAFT | no | Carpark note: DRAFT PR #1902 (B-082), built and unit-tested only.
1077. [chunk 18 #57] BUG-1127 | FIXABLE-NOW | no | No branch found; entry gives the exact fix (outer tip corners sharp, arc on the inside corner) from supplier drawings.
1078. [chunk 18 #58] BUG-1128 | HAS-DRAFT | no | Carpark note: DRAFT PR #1904 (B-083), built and unit-tested only.
1079. [chunk 18 #59] BUG-1129 | HAS-DRAFT | no | Carpark note: DRAFT PR #1908 (B-088); N40, R6, R10 still have no catalogue row.
1080. [chunk 18 #60] BUG-1130 | UNCLEAR | no | Needs the 250UC89.5 root radius from the BUG-818 section list, which is not in yet; no branch found.
1081. [chunk 19 #1] BUG-1131 | HAS-DRAFT | pilot-critical no | Draft PR #1902 (B-082) reads a length over 100 as millimetres; built and unit-tested only.
1082. [chunk 19 #2] BUG-1132 | HAS-DRAFT | pilot-critical no | Draft PR #1932 (B-106) adds supplier names with a former-names map; 250UC73 (73.0 versus 250UC72.9) is held for Tim.
1083. [chunk 19 #3] BUG-1133 | UNCLEAR | pilot-critical no | Entry itself says UNSURE whether any sheet puts the angle symbol anywhere but after the size; the fix has two options (replace with EA/UA, or warn) and no branch exists.
1084. [chunk 19 #4] BUG-1134 | HAS-DRAFT | pilot-critical no | Draft PR #1914 (B-092), branch claude/s16-bug-1134; unit-tested only; the schedule is switched off by default.
1085. [chunk 19 #5] BUG-1135 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1747 on the Civil line 31 Oct; installed in 3.0.88; the older-build round trip is not tried in AutoCAD.
1086. [chunk 19 #6] BUG-1136 | HAS-DRAFT | pilot-critical no | Draft PR #1893 is on the Civil line only; it needs a twin on the Structural line (rel-20261026s) before it can ship there.
1087. [chunk 19 #7] BUG-1137 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1778 31 Oct; the fault only hits AutoCAD 2022 to 2024 and Max is on 2026.
1088. [chunk 19 #8] BUG-1138 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1748 31 Oct (CDUPGRADE follow-up in 8dfc0f52); older-AutoCAD lane only.
1089. [chunk 19 #9] BUG-1139 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078): a copied beam starts with empty links; not opened in AutoCAD.
1090. [chunk 19 #10] BUG-1140 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1763 31 Oct; a pasted downpipe no longer takes the original's label; copy and paste is everyday work.
1091. [chunk 19 #11] BUG-1141 | HAS-DRAFT | pilot-critical no | Branch fb/bug-1141-unreadable-pit-record-link-cache (tip 9545489c, 30 Oct), not merged; I found no PR number (the gh tool is missing here).
1092. [chunk 19 #12] BUG-1142 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1752 31 Oct; only triggers when a pit record is already damaged.
1093. [chunk 19 #13] BUG-1143 | HAS-DRAFT | pilot-critical no | Branch cx4/bug-1143-design-draft-backup (26 Oct), not merged; no PR number found; it is older than the 31 Oct drafts and may need restating on the current line.
1094. [chunk 19 #14] BUG-1144 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1144 (B-121, 31 Oct), not merged; no PR number found.
1095. [chunk 19 #15] BUG-1145 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1765 31 Oct; a schedule Xref'd into a sheet no longer shows OUT OF DATE for unrelated changes, and Project QA stops failing for the same reason.
1096. [chunk 19 #16] BUG-1146 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077, Structural line); footing-size memory per drawing.
1097. [chunk 19 #17] BUG-1147 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077): newer footing data is kept; the beam-link data part is not mentioned in the note.
1098. [chunk 19 #18] BUG-1148 | FIXABLE-NOW | pilot-critical no | Expected behaviour is stated exactly (a matching non-blank identity, copy only labels whose owner note names the source pit); no commit or branch found.
1099. [chunk 19 #19] BUG-1149 | HAS-DRAFT | pilot-critical no | Branch fb/pc2-BUG-1149-bound-source-frozen (24 Oct), not merged; its tip line reads "a gone source no longer hides a changed or unloaded second source", so it may cover only part of the BIND case.
1100. [chunk 19 #20] BUG-1150 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1758 31 Oct; a pasted CE network is no longer lost after reopening.
1101. [chunk 19 #21] BUG-1151 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1777 31 Oct; the pit move names the pipe objects that could not follow; older-AutoCAD lane only.
1102. [chunk 19 #22] BUG-1152 | HAS-DRAFT | pilot-critical no | Branch fb/bug1152-twin-upgrade-atomic (B-120, 31 Oct), not merged; no PR number found.
1103. [chunk 19 #23] BUG-1153 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1153 (31 Oct), not merged, built on top of the BUG-1144 branch.
1104. [chunk 19 #24] BUG-1154 | FIXABLE-NOW | pilot-critical no | The entry names the existing 255-character splitter to reuse; no commit or branch found.
1105. [chunk 19 #25] BUG-1155 | HAS-DRAFT | pilot-critical no | Branch claude/b115-bug-1155-xref-recreated (B-115, 31 Oct), restated on the C-78 line, not merged.
1106. [chunk 19 #26] BUG-1156 | HAS-DRAFT | pilot-critical no | Branch fb/bug1156-draft-keeps-unknown-fields (B-120, 31 Oct), not merged.
1107. [chunk 19 #27] BUG-1157 | HAS-DRAFT | pilot-critical no | Branch claude/b119-bug-1157-level-write-not-saved (B-119, 31 Oct), not merged.
1108. [chunk 19 #28] BUG-1158 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1158 (31 Oct) compares drawings with SameDatabase; not merged.
1109. [chunk 19 #29] BUG-1159 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077): unreadable size entries are kept.
1110. [chunk 19 #30] BUG-1160 | FIXABLE-NOW | pilot-critical no | The entry states what to store ("last written by" and "highest version ever written"); no commit or branch found; it builds on the merged BUG-1135 fix.
1111. [chunk 19 #31] BUG-1161 | HAS-DRAFT | pilot-critical no | Branch claude/b124-n10-bug1161-moved-label-keeps-wording (B-124, 31 Oct), not merged.
1112. [chunk 19 #32] BUG-1162 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078): a damaged point load list is refused.
1113. [chunk 19 #33] BUG-1163 | FIXABLE-NOW | pilot-critical no | One-line expected behaviour (also write waiting records when a DXF export starts); no commit or branch found.
1114. [chunk 19 #34] BUG-1164 | HAS-DRAFT | pilot-critical no | Branch claude/b119-bug-1164-comma-levels (B-119, 31 Oct), not merged.
1115. [chunk 19 #35] BUG-1165 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1751 31 Oct; the code reads blocks from the running bundle first, but an administrator still has to check the all-users folders on Max's PC before 9 Nov.
1116. [chunk 19 #36] BUG-1166 | FIXABLE-NOW | pilot-critical yes | Expected behaviour is one shared office-folder lookup used by Civil and Manager (Manager's order already exists); no commit found; looking at where Max's OneDrive puts the folder is a separate hand step.
1117. [chunk 19 #37] BUG-1167 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1754 31 Oct; folders in a copied settings file follow the receiving PC; I did not read any settings file.
1118. [chunk 19 #38] BUG-1168 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1775 31 Oct; the job-time folder is looked for again at each start; the OneDrive-synced hand step before Max's first start still stands.
1119. [chunk 19 #39] BUG-1169 | UNCLEAR | pilot-critical yes | Missing: the version and date of Max's old July Structural bundle, and whether it carries its own CE_SHARED.dll; only someone at Max's PC can supply it.
1120. [chunk 19 #40] BUG-1170 | UNCLEAR | pilot-critical yes | Missing: Max's current Manager version (is it older than 22 Jul?); only someone at Max's PC can supply it.
1121. [chunk 19 #41] BUG-1171 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1860 (B-050) 31 Oct; Manager sends a short list of Civil failures and never deletes unsent files.
1122. [chunk 19 #42] BUG-1172 | HAS-DRAFT | pilot-critical no | Branch claude/n2-b116-bug1172-net8-lane-label (B-116, 31 Oct), not merged.
1123. [chunk 19 #43] BUG-1173 | FIXABLE-NOW | pilot-critical yes | A document-only fix (the pack's own notes say the code is correct): add three folders and a "MENULOAD, unload CE_SUITE_MANAGER_MENU" line to the colleague pack; the pack wording is not yet edited.
1124. [chunk 19 #44] BUG-1174 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1174-cdwt-says-why-no-window (27 Oct), not merged; no PR number found.
1125. [chunk 19 #45] BUG-1175 | FIXABLE-NOW | pilot-critical yes | The entry names the three places (CDSL message, CDHELP path, CDTRENCHGRATEAUDIT file path) and the fix; they point at Tim's own folders, which Max's PC will not have.
1126. [chunk 19 #46] BUG-1176 | NEEDS-TIM | pilot-critical yes | Question: will the package reach Max by USB or the synced pilot folder (never a downloaded zip)? It is a delivery choice, not code.
1127. [chunk 19 #47] BUG-1177 | DUPLICATE-OF-BUG-1202 | pilot-critical no | The carpark already says so (same weekly time export, PR #1776) and closed it on Tim's yes, decision 178, 31 Oct.
1128. [chunk 19 #48] BUG-1178 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1178-shared-mismatch-colleague-words (26 Oct), not merged; no PR number found.
1129. [chunk 19 #49] BUG-1179 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1769 31 Oct; a damaged approval file now says CE could not check, not "CE is current."
1130. [chunk 19 #50] BUG-1180 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1774 31 Oct; the Drawing Repair banner fix.
1131. [chunk 19 #51] BUG-1181 | HAS-DRAFT | pilot-critical no | Branch cx4/bug-1181-manager-off-next-start (26 Oct), not merged; no PR number found.
1132. [chunk 19 #52] BUG-1182 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1182-view-history-own-module (26 Oct), not merged; no PR number found.
1133. [chunk 19 #53] BUG-1183 | HAS-DRAFT | pilot-critical no | Branch claude/bug-1183-pier-schedule-row-identity-s1026 (30 Oct), not merged; no PR number found.
1134. [chunk 19 #54] BUG-1184 | HAS-DRAFT | pilot-critical no | Draft PR #1895 (head d09b4935, Structural line): a new size gets the next free BR or SPR mark.
1135. [chunk 19 #55] BUG-1185 | HAS-DRAFT | pilot-critical no | Draft PR #1906 (B-084): tagging adds only a label (switch TagBearersLabelOnly ON).
1136. [chunk 19 #56] BUG-1186 | HAS-DRAFT | pilot-critical no | Draft PR #1912 (B-091): CSTAGBEARERS and CSSUBFLOORGRID refuse a locked layer and never unlock it.
1137. [chunk 19 #57] BUG-1187 | HAS-DRAFT | pilot-critical no | Draft PR #1913 (B-091): a mistyped lineweight keeps the layer unchanged and says why.
1138. [chunk 19 #58] BUG-1188 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1773 31 Oct; no more invented "AT 1 IN 100" on a LandXML pipe with no grade.
1139. [chunk 19 #59] BUG-1189 | HAS-DRAFT | pilot-critical no | Branch fb/pc3-BUG-1189-moved-survey-xref (24 Oct), not merged; no PR number found.
1140. [chunk 19 #60] BUG-1190 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1755 31 Oct; levels in a nested, turned survey block now land where the drawing shows them.
1141. [chunk 20 #1] BUG-1191 | HAS-DRAFT | pilot-critical no | Draft PR #1809 "show every survey finding before approval"; not in the release line.
1142. [chunk 20 #2] BUG-1192 | HAS-DRAFT | pilot-critical yes | Draft PR #1864, in rel line (merge c748ebb3); warns when survey levels more than 1.20 m off the covers are dropped.
1143. [chunk 20 #3] BUG-1193 | HAS-DRAFT | pilot-critical no | Draft PR #1938 follows the curve of a property boundary; not in the release line.
1144. [chunk 20 #4] BUG-1194 | HAS-DRAFT | pilot-critical yes | Draft PR #1757, in rel line (merge bca7dcbd); CDTEXTSEG uses the leg you clicked.
1145. [chunk 20 #5] BUG-1195 | HAS-DRAFT | pilot-critical no | Draft PR #1888 (B-072), turned UCS label angle; not in the release line.
1146. [chunk 20 #6] BUG-1196 | HAS-DRAFT | pilot-critical yes | Draft PR #1760, in rel line (merge b99d0197); a wrong depth in the pit schedule is a wrong answer.
1147. [chunk 20 #7] BUG-1197 | FIXABLE-NOW | pilot-critical no | No PR or commit found; Expected is exact (private heading per schedule, do not rewrite a shared definition).
1148. [chunk 20 #8] BUG-1198 | HAS-DRAFT | pilot-critical no | Draft PR #1764, in rel line (merge 54f621e8); export no longer saves into the drawing.
1149. [chunk 20 #9] BUG-1199 | HAS-DRAFT | pilot-critical no | Draft PR #1894 (Structural); not in the Civil release line.
1150. [chunk 20 #10] BUG-1200 | HAS-DRAFT | pilot-critical no | Draft PR #1906 (B-084, also names BUG-1185); Structural.
1151. [chunk 20 #11] BUG-1201 | HAS-DRAFT | pilot-critical no | Draft PR #1813 delays the CDSL block import.
1152. [chunk 20 #12] BUG-1202 | HAS-DRAFT | pilot-critical no | Draft PR #1776, in rel line (merge 49b3f348); weekly export off the start-up thread.
1153. [chunk 20 #13] BUG-1203 | HAS-DRAFT | pilot-critical no | Draft PR #1915 (B-092), Structural background refresh switch.
1154. [chunk 20 #14] BUG-1204 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078, with 1139 and 1162), Structural link conversion.
1155. [chunk 20 #15] BUG-1205 | FIXABLE-NOW | pilot-critical yes | No PR; Expected is exact (one record per session, crash only if the owner process is gone); touches a shared file, so Manager must be synced by hand.
1156. [chunk 20 #16] BUG-1206 | HAS-DRAFT | pilot-critical no | Draft PR #1750, in rel line (merge a9a18a8f); CE Tools tab appears at start-up.
1157. [chunk 20 #17] BUG-1207 | UNCLEAR | pilot-critical no | Fix kind is "probe first": nobody has shown that two sessions really overwrite log lines; a probe is missing.
1158. [chunk 20 #18] BUG-1208 | FIXABLE-NOW | pilot-critical yes | No PR; Expected is exact (lock, re-read, change one entry, atomic replace).
1159. [chunk 20 #19] BUG-1209 | NEEDS-TIM | pilot-critical no | Which way to link a downpipe to a pit on AutoCAD 2022-2024 is a design choice, and the entry says "protected change, route to owner".
1160. [chunk 20 #20] BUG-1210 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (make the existing plan controls and clicks work on the older lane); a large port job.
1161. [chunk 20 #21] BUG-1211 | HAS-DRAFT | pilot-critical no | Draft PR #1957 (B-129), CDMENU checks the menu is really loaded.
1162. [chunk 20 #22] BUG-1212 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (port the two tank windows to the older lane); a large port job.
1163. [chunk 20 #23] BUG-1213 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (keep Source on every lane, read-only fallback with the retained text).
1164. [chunk 20 #24] BUG-1214 | HAS-DRAFT | pilot-critical no | Draft PR #1959 (B-129), the picker offers images only on the older lane.
1165. [chunk 20 #25] BUG-1215 | HAS-DRAFT | pilot-critical no | Draft PR #1768, in rel line (merge 784640d5); Help now names Send report.
1166. [chunk 20 #26] BUG-1216 | HAS-DRAFT | pilot-critical no | Draft PR #1812; Help follows Rainfall and newer commands.
1167. [chunk 20 #27] BUG-1217 | FIXABLE-NOW | pilot-critical no | No PR; help-text only, Expected names the exact tab names and the read-only wording.
1168. [chunk 20 #28] BUG-1218 | HAS-DRAFT | pilot-critical no | Draft PR #1896 (B-074, with 1220), new Help pages.
1169. [chunk 20 #29] BUG-1219 | HAS-DRAFT | pilot-critical no | Draft PR #1916 (B-092), Beam and Rafter/Joist Help says they open Settings.
1170. [chunk 20 #30] BUG-1220 | HAS-DRAFT | pilot-critical no | Draft PR #1896 (B-074, with 1218), Reverse Flow wording.
1171. [chunk 20 #31] BUG-1222 | ALREADY-FIXED | pilot-critical yes | PR #1832, commit 76171d1e in rel line; carpark Status says FIXED (Claude-accepted, Civil 3.0.85, 29 Oct) and Tim confirmed by hand.
1172. [chunk 20 #32] BUG-1223 | HAS-DRAFT | pilot-critical no | Draft PR #1833, in rel line (merge 905dd2ba); the false "changed while you picked" is removed.
1173. [chunk 20 #33] BUG-1224 | HAS-DRAFT | pilot-critical no | Draft PR #1918 (B-100), leaves lock, freeze and on/off alone; Tim's answer is Monday question 70 (the PR uses the recommended default).
1174. [chunk 20 #34] BUG-1225 | ALREADY-FIXED | pilot-critical yes | PR #1830, commit 431c27c2 in rel line; carpark Status says Tim confirmed DP placed twice on 29 Oct (Civil 3.0.85).
1175. [chunk 20 #35] BUG-1226 | HAS-DRAFT | pilot-critical no | Draft PR #1839 (B-006), in rel line (merge de05fa64); Recent invert buttons restored.
1176. [chunk 20 #36] BUG-1227 | HAS-DRAFT | pilot-critical no | Draft PR #1867 (B-049a), Part A only, in rel line (merge 3c75396c); I could not see this entry's Symptom, so whether Part B remains is unknown.
1177. [chunk 20 #37] BUG-1228 | HAS-DRAFT | pilot-critical yes | Draft PR #1837, in rel line (merge dced33cf); DP took about 30 seconds to place.
1178. [chunk 20 #38] BUG-1229 | HAS-DRAFT | pilot-critical yes | Draft PR #1838 (B-005), in rel line (merge 679bf190); level never flatter than the grade chosen.
1179. [chunk 20 #39] BUG-1230 | NEEDS-TIM | pilot-critical no | On hold for the whole-functionality review (Tim 29 Oct); what the preview should show is part of that review.
1180. [chunk 20 #40] BUG-1231 | FIXABLE-NOW | pilot-critical no | No PR; Expected is one short line per cause and the useful sentence first.
1181. [chunk 20 #41] BUG-1232 | UNCLEAR | pilot-critical no | Suspected only; not reproduced by hand, may be a robot test-drawing effect.
1182. [chunk 20 #42] BUG-1233 | NEEDS-TIM | pilot-critical yes | The window must not switch Standard to "Set my own"; the fix depends on the grade row versus "I know one end" design (PC-02, PC-03), which is unsettled.
1183. [chunk 20 #43] BUG-1234 | UNCLEAR | pilot-critical no | Tim's screenshot is not in the repo and the entry gives no clearances to aim for.
1184. [chunk 20 #44] BUG-1235 | HAS-DRAFT | pilot-critical no | Draft PR #1967 (B-119); the warning never prints the same figure twice.
1185. [chunk 20 #45] BUG-1236 | NEEDS-TIM | pilot-critical no | Card D08 says OF and FO share one symbol, Tim expected FO; Monday question 43 (recommended: FO gets its own symbol).
1186. [chunk 20 #46] BUG-1237 | HAS-DRAFT | pilot-critical no | Draft PR #1889 (B-067); CDRENUMBER says what to draw.
1187. [chunk 20 #47] BUG-1238 | HAS-DRAFT | pilot-critical no | Draft PR #1861 (B-043a), in rel line (commit 70dec2c2); one "Recent:" line on New Pipe / Edit Pipe.
1188. [chunk 20 #48] BUG-1239 | UNCLEAR | pilot-critical no | Not yet known when the 450 units sideways shift happens (grade text off, or normal "Above" gap); needs one clarifying look.
1189. [chunk 20 #49] BUG-1240 | HAS-DRAFT | pilot-critical no | Draft PR #1880 (B-059); Inspector reads the saved record after Save As.
1190. [chunk 20 #50] BUG-1241 | UNCLEAR | pilot-critical no | A question from Tim, not a proven fault; the carpark says so.
1191. [chunk 20 #51] BUG-1242 | NEEDS-TIM | pilot-critical no | Monday question 44 (show the number on every source tag, default on) has no recorded answer in what I read.
1192. [chunk 20 #52] BUG-1243 | UNCLEAR | pilot-critical no | Tim's description of what CE Blocks should do is missing.
1193. [chunk 20 #53] BUG-1244 | HAS-DRAFT | pilot-critical no | Draft PR #1936 (B-116); Refresh prints one plain line.
1194. [chunk 20 #54] BUG-1245 | UNCLEAR | pilot-critical no | Which two objects Tim selected is not known, so whether it is a real refusal or a wording problem is unknown.
1195. [chunk 20 #55] BUG-1246 | HAS-DRAFT | pilot-critical no | Draft PR #1891 (B-071); the copied downpipe gets its own next tag.
1196. [chunk 20 #56] BUG-1247 | HAS-DRAFT | pilot-critical no | Draft PR #1876 (B-058); Updates & Rollback opens the drafter's own Updates screen.
1197. [chunk 20 #57] BUG-1248 | FIXABLE-NOW | pilot-critical no | No PR; Expected gives the plain wording and says to move the technical detail behind a Details fold.
1198. [chunk 20 #58] BUG-1249 | UNCLEAR | pilot-critical no | Which row Tim meant is not known (the carpark says so).
1199. [chunk 20 #59] BUG-1250 | UNCLEAR | pilot-critical no | Seen once in one run, switch-off case not checked; evidence only.
1200. [chunk 20 #60] BUG-1251 | HAS-DRAFT | pilot-critical yes | Draft PR #1866 (B-055), in rel line (merge cf71af0d); CDCHECK showed 44 false "Unresolved" instead of 4 after a reopen.
1201. [chunk 21 #1] BUG-1252 | NEEDS-TIM | pilot-critical no | On hold for Tim's Monday question 19: keep the label travelling with its pipe end (recommended) or build it so a hand-placed label stays put; the carpark entry says nothing was built.
1202. [chunk 21 #2] BUG-1253 | FIXABLE-NOW | pilot-critical no | Cause is named (a text's own pipe strip is never treated as keep-clear in LinkService.TextClashTidyUp.cs) and the expected result is stated; fix together with BUG-1034; no commit or PR found.
1203. [chunk 21 #3] BUG-1254 | UNCLEAR | pilot-critical no | The carpark note says probably no fault (the same window passed at 08:57) and only Tim or a clean re-look closes it; a re-look in AutoCAD is missing.
1204. [chunk 21 #4] BUG-1255 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits 96b87f73, 9a1f4e64, c137e78a and 0b8698eb (PR #1871, B-056) are in Civil/Manager 3.0.88 (C-78); I found no named acceptance in the ledger.
1205. [chunk 21 #5] BUG-1256 | FIXABLE-NOW | pilot-critical no | Plain wording change to one closing line (drop "pre-flight gate"); no commit or PR found; the "or change the card" alternative is a wording call a builder can settle with the plain sentence.
1206. [chunk 21 #6] BUG-1257 | HAS-DRAFT | pilot-critical yes | Draft PR #1922 (B-099, rel-20261102a) adds the missing redirects plus a guard test, per the carpark note; not merged and not opened in AutoCAD.
1207. [chunk 21 #7] BUG-1258 | FIXABLE-NOW | pilot-critical no | Expected result is one shared speed-limit rule from the Settings value (6.0 m/s as shipped); it follows draft #1857 (B-011), so check #1857 is in the train first; no commit found.
1208. [chunk 21 #8] BUG-1259 | UNCLEAR | pilot-critical no | The fix sits with the evidence-scan owner (areas\EV04_ISOLATION_REQUEST_30OCT.md), outside this repo, and I could not see whether the scans have been changed.
1209. [chunk 21 #9] BUG-1260 | FIXABLE-NOW | pilot-critical no | Either remove the unreachable Structural zip or skip key and settings files by name and scrub login, PC name and drawing path; both options are spelled out; no commit found.
1210. [chunk 21 #10] BUG-1261 | FIXABLE-NOW | pilot-critical no | Apply the same by-name skip as the zip (blob-config*, *.local.json, CE_SUITE folders) to the Manager upload; it follows B-063 (#1878), so check #1878 is in first; no commit found.
1211. [chunk 21 #11] BUG-1262 | HAS-DRAFT | pilot-critical no | Draft PR #1929 (B-101, Structural line) implements Tim's decision 150 (warn, plot nothing, keep revisions, record "no sheets"); it fixes the OLDER window and overlaps drafts #721 and #1248.
1212. [chunk 21 #12] BUG-1263 | FIXABLE-NOW | pilot-critical no | Expected result stated (show current values or say they are older than the drawing); LOW and rare; depends on draft #1880 (B-059) being in a train; no commit found.
1213. [chunk 21 #13] BUG-1264 | FIXABLE-NOW | pilot-critical no | Expected result stated (clear or reload the pit list after such an Undo); LOW and rare; depends on #1880; no commit found.
1214. [chunk 21 #14] BUG-1265 | FIXABLE-NOW | pilot-critical no | Merge the two near-identical rules into one and fix the comment at line 20; do it after #1866 and #1880 are both in a train; no commit found.
1215. [chunk 21 #15] BUG-1266 | FIXABLE-NOW | pilot-critical no | Log one line per unreadable record per drawing and remember the read per drawing; LOW log noise; depends on #1880; no commit found.
1216. [chunk 21 #16] BUG-1267 | HAS-DRAFT | pilot-critical no | Tim answered "5as recommened" (decision 122); draft PR #1927 (B-095, on the #1919 branch) works from the standard grade behind switch pipe.recallLastNewUpstreamUsesStandardGrade; built and unit-tested only.
1217. [chunk 21 #17] BUG-1268 | HAS-DRAFT | pilot-critical yes | Draft PR #1983 (q11, B-157, switch excel.confirmCalcXlsxSaved) adds a "saved" message, a file check and a start folder; 18 of 18 new tests and 116 of 116 in the focused set on both lanes per areas\BUGFIX_q11_REPORT_01NOV.md; it does not find why Windows said "not saved".

## Lists to close

1. **ALREADY-FIXED (205):** BUG-854, BUG-815, BUG-729, BUG-728, BUG-725, BUG-724, BUG-723, BUG-720, BUG-719, BUG-711, BUG-710, BUG-693, BUG-692, BUG-690, BUG-684, BUG-672, BUG-665, BUG-664, BUG-651, BUG-582, BUG-572, BUG-570, BUG-394, BUG-418, BUG-420, BUG-422, BUG-414, BUG-405, BUG-406, BUG-407, BUG-398, BUG-393, BUG-389, BUG-388, BUG-387, BUG-384, BUG-381, BUG-382, BUG-377, BUG-375, BUG-247, BUG-207, BUG-218, BUG-221, BUG-193, BUG-190, BUG-189, BUG-184, BUG-183, BUG-182, BUG-181, BUG-179, BUG-178, BUG-170, BUG-169, BUG-168, BUG-167, BUG-164, BUG-162, BUG-161, BUG-051, BUG-002, BUG-004, BUG-005, BUG-006, BUG-008, BUG-009, BUG-010, BUG-013, BUG-018, BUG-019, BUG-087, BUG-090, BUG-082, BUG-141, BUG-476, BUG-479, BUG-480, BUG-481, BUG-482, BUG-484, BUG-485, BUG-486, BUG-487, BUG-488, BUG-489, BUG-490, BUG-506, BUG-507, BUG-508, BUG-509, BUG-510, BUG-511, BUG-512, BUG-513, BUG-514, BUG-515, BUG-516, BUG-539, BUG-540, BUG-541, BUG-543, BUG-545, BUG-628, BUG-629, BUG-633, BUG-635, BUG-638, BUG-649, BUG-650, BUG-697, BUG-698, BUG-856, BUG-857, BUG-860, BUG-862, BUG-863, BUG-864, BUG-CDCHECKIGNORE-UNDO-C60, BUG-867, BUG-868, BUG-869, BUG-871, BUG-874, BUG-875, BUG-876, BUG-877, BUG-878, BUG-880, BUG-881, BUG-884, BUG-886, BUG-889, BUG-892, BUG-899, BUG-901, BUG-904, BUG-905, BUG-906, BUG-917, BUG-918, BUG-927, BUG-933, BUG-943, BUG-944, BUG-945, BUG-946, BUG-947, BUG-948, BUG-955, BUG-956, BUG-957, BUG-960, BUG-962, BUG-963, BUG-964, BUG-965, BUG-966, BUG-967, BUG-968, BUG-969, BUG-970, BUG-971, BUG-973, BUG-974, BUG-975, BUG-977, BUG-978, BUG-979, BUG-980, BUG-981, BUG-983, BUG-985, BUG-986, BUG-987, BUG-988, BUG-991, BUG-992, BUG-993, BUG-995, BUG-996, BUG-997, BUG-998, BUG-999, BUG-1000, BUG-1001, BUG-1002, BUG-1003, BUG-1004, BUG-1005, BUG-1007, BUG-1008, BUG-1009, BUG-1010, BUG-1074, BUG-1075, BUG-1085, BUG-1086, BUG-1087, BUG-1095, BUG-1097, BUG-1101, BUG-1106, BUG-1222, BUG-1225

2. **CLOSED-OR-WONT-FIX (34):** BUG-821, BUG-371, BUG-421, BUG-444, BUG-409, BUG-404, BUG-401, BUG-395, BUG-392, BUG-391, BUG-390, BUG-374, BUG-361, BUG-359, BUG-345, BUG-326, BUG-240, BUG-238, BUG-007, BUG-016, BUG-023, BUG-030, BUG-037, BUG-040, BUG-096, BUG-097, BUG-100, BUG-449, BUG-460, BUG-567, BUG-568, BUG-569, BUG-639, BUG-1119
