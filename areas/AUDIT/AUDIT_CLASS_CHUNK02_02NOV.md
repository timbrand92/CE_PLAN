# Carpark audit, chunk 2 of 21 (entries 61 to 120, BUG-795 down to BUG-736)

Written by Sonnet (Team) on Mon 2 Nov 2026, Melbourne time. Read-only: no code changed, nothing built, no test run, no AutoCAD opened, no robot run. The only file written is this one.

## FOR TIM

1. **Counts:** 53 installed-waiting-proof, 4 have a draft, 2 need Tim, 1 unclear, 0 fixable now, 0 duplicates, 0 already fixed, 0 closed.
2. **Fixable now: none.** Every entry here either already has a fix on the release line (Civil 3.0.88 is on your PC), or has a draft, or is waiting on you.
3. **Pilot-critical with a draft but not on the line:** BUG-788 (two Save As copies of an Xref merge into one; draft PR #1925, reopened after the first fix failed) and BUG-787 (a typed pit cover slides to another row; draft PR #1423, on hold and needs rebasing).
4. **Needs Tim:** BUG-775 (what pipe wall thickness per pipe class to use for services clearance; latent, not wired in) and BUG-750 (confirm the steel beam inner-line bug is closed because your CEMEMBER design replaced it).
5. **The carpark is out of date for about 17 entries.** BUG-756, 757, 759, 761, 762, 763, 774, 776 and 778 were fixed by PRs #1391 to #1399 under hunt names (IJK-01 and so on) and BUG-760, 764, 766 and 771 were merged on 24 Oct, yet their entries still read plain OPEN with no "installed" note. Several others still say "installed in 3.0.70" when 3.0.88 is now installed.
6. **Plain caveat:** "installed-waiting-proof" means the fix is on the release line and on your PC. Nobody has proved these in AutoCAD, so none is fixed.

## Entries (one line each)

1. BUG-795 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f4242a21 (PR #1417) is on the line; entry says installed 3.0.70, no robot or Codex run.
2. BUG-794 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 45d28706 (PR #1405) is on the line; no robot or Codex run.
3. BUG-793 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9ae7f1d6 (PR #1540) is on the line with the switch ON; entry still says plain OPEN, and "Save changes?" on an untouched drawing was never tried.
4. BUG-792 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 4289e35a (PR #1426) fixes the numbers half only (title says so); the half where text typed into Depth, Size, FROM or Remarks is ignored is not shown fixed.
5. BUG-791 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 717badf8 (PR #1425); Codex W2-02 PASS SURE 23 Oct but not Codex-accepted because the robot cannot judge cell colours.
6. BUG-790 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits afc32901 and d321f4fd (PR #1403); no robot or Codex run.
7. BUG-789 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 0b2536a0 (PR #1406); robot run 32 PASS on 3.0.56, not Codex-accepted; the one-missing-end case is BUG-820.
8. BUG-788 | HAS-DRAFT | pilot-critical yes | reopened 23 Oct because the installed core fix (73a63971, PR #1404) never reaches the adapter; draft PR #1925 (B-113) is not on the line.
9. BUG-787 | HAS-DRAFT | pilot-critical yes | draft PR #1423 (commit 92f34616) is on branch rel-20261018d only; held 24 Oct and Opus pre-review of 1 Nov says change needed because the line rewrote the same code.
10. BUG-786 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 81da50b4 (PR #1422) is on the line, switch ON; no robot or Codex run.
11. BUG-785 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 90cd6139 (PR #1402) is on the line; no robot or Codex run.
12. BUG-784 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit a086151a (PR #1413); Codex W2-01 NOT TESTED because the drawing has no inlet from a non-P pit, so it needs a fixture with C1 upstream.
13. BUG-783 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5be02d8f (PR #1412) plus tests; Codex W2-03 BLOCKED because the cell menu has no Delete cell item on this build (see BUG-1031).
14. BUG-782 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5588c82d (PR #1400); robot runs 32 to 35 pass the normal cascade, but the low-end hand-typed case itself was never tested by anyone.
15. BUG-781 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 2d2e7b49 (PR #1401); no robot or Codex run (needs a real consultant PDF and DWG).
16. BUG-780 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 7a687e38 (PR #1415), switch ON; no robot or Codex run.
17. BUG-779 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit df125802 (PR #1410), switch ON; no robot or Codex run.
18. BUG-778 | INSTALLED-WAITING-PROOF | pilot-critical no | commit ac6f65ea (IJK-X2, PR #1398) says the note now reads 1%-term; the entry still says plain OPEN.
19. BUG-777 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d19500c9 (PR #1411); Codex W1-04 SEEN 23 Oct (offers 18.05), but the invert-plus-diameter cross-check was not done.
20. BUG-776 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 8cb019a2 (IJK-26, PR #1399) is on the line; the entry still says plain OPEN.
21. BUG-775 | NEEDS-TIM | pilot-critical no | no fix; needs the pipe wall thickness per pipe class (Tim's number, the Settings table is not filled); the rule has no caller yet, so it is latent.
22. BUG-774 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 0cbf3573 (IJK-23, PR #1397) says a repeated pick is ignored; the entry still says plain OPEN.
23. BUG-773 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 04930ee3 (PR #1432) fixes the true-centre half only (title says so); the rounding half (IJK-20) is not shown fixed.
24. BUG-772 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 8324a299 (PR #1428); cannot be tested on this build because the WSUD tab is read-only (Codex W5-03).
25. BUG-771 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 78e88961 (PR #1700) merged into the line on 24 Oct; the entry still says plain OPEN and Codex has not run CDRG.
26. BUG-770 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7c55eca2 and 920e7160 (PR #1424); latent, nothing draws it today.
27. BUG-769 | INSTALLED-WAITING-PROOF | pilot-critical no | commits a2d5ea9c and c62eb3bf (PR #1427); no robot or Codex run.
28. BUG-768 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9e20647e (PR #1421); no robot or Codex run.
29. BUG-767 | INSTALLED-WAITING-PROOF | pilot-critical no | commits d5115f0e and 805e5492 (PR #1433), switch ON; no robot or Codex run.
30. BUG-766 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 5ee899a2 (PR #1711) merged into the line on 24 Oct; the entry still says plain OPEN.
31. BUG-765 | HAS-DRAFT | pilot-critical no | draft PR #1939 (B-122, commit 209cc31d, 31 Oct) is not on the line (only on later branches).
32. BUG-764 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 32d8a155 (PR #1709) merged into the line on 24 Oct; the entry still says plain OPEN.
33. BUG-763 | INSTALLED-WAITING-PROOF | pilot-critical no | commit ad608b7b (IJK-08, PR #1396) says the grid shows one pipe per row; the entry still says plain OPEN.
34. BUG-762 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit aee03e91 (IJK-07, PR #1393) makes invert above cover Unknown with a reason; the entry still says plain OPEN.
35. BUG-761 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit b2b35d66 (IJK-06, PR #1395) removes the falling grade on a rising pipe; the entry still says plain OPEN.
36. BUG-760 | INSTALLED-WAITING-PROOF | pilot-critical no | commit b46f0c32 (PR #1710) merged into the line on 24 Oct; grade reads LEVEL; the entry still says plain OPEN.
37. BUG-759 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 4c0f1623 (IJK-04, PR #1394) refuses a datum above the lowest sump; the entry still says plain OPEN.
38. BUG-758 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 3e481b4b and 16f71a06 (PR #1407 and #1408); Codex W5-01 saw only the window half, and the hide switch and engineering half are untested.
39. BUG-757 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 44d09925 (IJK-02, PR #1391) makes the 0.000 trench grate cover Unknown; the entry still says plain OPEN.
40. BUG-756 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 1eb259ee (IJK-01, PR #1392) draws each pipe's top line at its own size; the entry still says plain OPEN.
41. BUG-755 | INSTALLED-WAITING-PROOF | pilot-critical no | commit cc6a5c58 (PR #1385) merged in S-44 and Structural 1.0.125 is installed; Codex on 1.0.118 still saw the pictures touch the top edge.
42. BUG-754 | INSTALLED-WAITING-PROOF | pilot-critical no | commit df7d2a5a (PR #1388, #1389); no robot or Codex run.
43. BUG-753 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 22921387 (PR #1387); Codex sampled 8 views fine but the 618-row list was not read end to end.
44. BUG-752 | INSTALLED-WAITING-PROOF | pilot-critical no | commit e31f4c63 (PR #1386) merged in S-44 and installed in 1.0.125; Codex last saw the clipped paths on 1.0.118, before the fix.
45. BUG-751 | HAS-DRAFT | pilot-critical no | draft PR #1383 (commit 4a5db9f7) is not on the Structural line; reviewed HOLD on 24 Oct.
46. BUG-750 | NEEDS-TIM | pilot-critical no | your CEMEMBER design replaces SBEAM and PR #1384 is not merged; question: close this bug as superseded?
47. BUG-748 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f19b054d (PR #1498) is in Structural 1.0.121 and later; the 1:50 density is still an unapproved straight line (QUESTIONS_FOR_MONDAY B4).
48. BUG-749 | UNCLEAR | pilot-critical no | seen three times, always when Codex typed text, so it may be how Codex types and not CE; missing a run that answers the prompt by another input method.
49. BUG-747 | INSTALLED-WAITING-PROOF | pilot-critical no | commits df12354d and 34c23f03 (PR #1364); no robot or Codex run.
50. BUG-746 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9bfc5cd8 (PR #1372); run 31 could not pick a tagged block, so it is unproven.
51. BUG-745 | INSTALLED-WAITING-PROOF | pilot-critical no | commits e6f44c09 and 0ceb3ae3 (PR #1345, #1350); no robot or Codex run, and it needs a metres drawing.
52. BUG-744 | INSTALLED-WAITING-PROOF | pilot-critical no | commit f15b6c1f (PR #1343); no robot or Codex run.
53. BUG-743 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits e6f44c09 and 4b03ad1d (PR #1345); a wrong cover level could carry from one job to the next; no robot or Codex run.
54. BUG-742 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7e60da94 (PR #1358); robot runs 32, 34 and 35 PASS (refuses WT2), not Codex-accepted.
55. BUG-741 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 2df77713 (PR #1355, shared with BUG-740) offers DP4 and WT2; no robot or Codex run of the repair itself.
56. BUG-740 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 2df77713 and 98f605ea (PR #1355); robot runs 31 and 32 PASS the numbering, but the rename did not apply (BUG-813).
57. BUG-739 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 30db1214 (PR #1373) fixes the report half only; reading the PDF once is not shown fixed.
58. BUG-738 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 55dc8705 and 452f87c2 (PR #1365); no robot or Codex run.
59. BUG-737 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 5bab7211 and 100db1f2 (PR #1366); no robot or Codex run.
60. BUG-736 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 62dbbffc (PR #1359) reads "IL:12.34"; the (IN)/(OUT) half is not shown fixed.

## What I read, and what I could not verify

1. **Read:** the Symptom, Expected and every Status and Note for all 60 entries; the git history of origin/claude/rel-20261102a (tip 3fbb9da5, Civil 3.0.88) and origin/claude/rel-20261026s (tip 204dfad2, Structural 1.0.125); all 800 most recent PRs from GitHub by title; the 24 Oct triage and the 1 Nov draft-backlog notes.
2. **Installed:** I read the product version of the live bundle on your PC (Civil 3.0.88 at 3fbb9da5, Structural 1.0.125 at 204dfad2) and checked that each fix commit is an ancestor of those tips. So "installed" here means "in the build now on your PC", not "tested".
3. **Not verified:** I did not open the code diffs. For the IJK fixes (BUG-756 to 763, 774, 776, 778) I matched the hunt name in the commit title to the carpark symptom; I did not read the diff to confirm it covers everything in the Expected line.
4. **Not verified:** the ledger (ledger.json) has no bug-number field, so I could not use it. Robot and Codex results come only from the notes inside the entries.
5. **Not verified:** all PRs show as draft and OPEN on GitHub (the team's train method), so "merged" is read from the git history, not from PR state.
6. **Pilot-critical column** is my reading: yes where a wrong engineering number, wrong level, or a silent change to pit or pipe data could reach a colleague's job in week one. It is not Tim's list.
7. **Half-fixed entries a builder could finish from the entry alone:** BUG-792 (text typed into Depth, Size, FROM, Remarks), BUG-773 (rounding compare), BUG-739 (read the PDF once), BUG-736 ((IN)/(OUT) wording). I could not confirm they are undone without opening the diffs.
