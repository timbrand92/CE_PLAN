# Carpark audit, chunk 1 of 21 (entries 1 to 60, BUG-855 down to BUG-796)

Written by Sonnet (Team) on Mon 2 Nov 2026, Melbourne time. Read-only: no code changed, nothing built, no test run, no AutoCAD opened.

## FOR TIM

1. **Counts:** 45 installed-waiting-proof, 4 have a draft, 3 need Tim, 3 unclear, 2 fixable now, 2 already fixed, 1 closed, 0 duplicates.
2. **Fixable now (only two, neither is pilot-critical):** BUG-804 (AI schedule reader never sends a schedule beyond page 6) and BUG-806 (orifice detail mapper, not wired in yet).
3. **Half-done entries a builder could finish from the entry alone (none pilot-critical):** BUG-796 (Yes/No preview on four Repair Center buttons), BUG-808 (count a pipe as checked only when its checks ran), BUG-809 items 1 and 5, BUG-811 (vision log after the 60 s timeout).
4. **Needs Tim:** BUG-818 (ten-row check of the corrected section list; pilot-critical engineering values), BUG-819 (drawing code, paused behind 818), BUG-820 (should Recover Inverts draw the one missing end?).
5. **Pilot-critical and no fix on the line yet:** BUG-826 (Structural Reset Defaults, draft PR #1457) and BUG-805 (X-Civil import reads metres wrongly, draft PR #1987).
6. **Plain caveat:** "installed-waiting-proof" means a fix is merged on the release line, and most entries say Civil 3.0.70 carried it. Nobody has opened these in AutoCAD, so none is fixed.

## Entries (one line each)

1. BUG-855 | UNCLEAR | pilot-critical no | no fix or PR; which of the 96 issues is the new one is unknown, and the Codex check ran on an already-edited copy.
2. BUG-854 | ALREADY-FIXED | pilot-critical no | Codex-accepted on Civil 3.0.64, commit 039bedf6.
3. BUG-853 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 513059cf, in 3.0.70 via PR #1462, no robot or Codex run.
4. BUG-852 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager half merged (PR #1493, commit 4746cfa9); Structural half PR #1503 installed in 1.0.121; robot observation only.
5. BUG-851 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 09cbed4a, 3.0.70 via PR #1473; without it a colleague's Disable leaves grey proxy pipes.
6. BUG-850 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits d65d3f37 and 705c261b, 3.0.70 via PR #1448 and #1463; the Civil tab was rebuilt under the drafter.
7. BUG-849 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 742f36cb, 3.0.70 via PR #1454; administrator-only message.
8. BUG-848 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7eaa55db and 905e2dd0, 3.0.70 via PR #1469.
9. BUG-847 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 5bdd424b, 3.0.70 via PR #1474; client names in the support zip.
10. BUG-846 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 9c9aefda, 3.0.70 via PR #1449 and #1474.
11. BUG-845 | INSTALLED-WAITING-PROOF | pilot-critical no | commit affdf4dc, 3.0.70 via PR #1455.
12. BUG-844 | INSTALLED-WAITING-PROOF | pilot-critical no | commit e7b2dc74, 3.0.70 via PR #1452.
13. BUG-843 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7309b265, 3.0.70 via PR #1450; the "Add administrator" button stays a paused plan item.
14. BUG-842 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 7eaa55db, 3.0.70 via PR #1459 and #1469.
15. BUG-841 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 39fa859b and 5cd70fe3 are on the Structural line rel-20261026s (S-44); the entry still says plain OPEN, so install is not confirmed.
16. BUG-840 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit c5e28d8f on rel-20261026s (S-44); entry still says plain OPEN, so install is not confirmed.
17. BUG-839 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 0e13f2b2, 3.0.70 via PR #1476; regression tests in c463d44b.
18. BUG-838 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1446 and #1475 merged (installer half), 3.0.70; whether OneDrive sets read-only was never checked.
19. BUG-837 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 49c930c6, 3.0.70 via PR #1470.
20. BUG-836 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 49c930c6, 3.0.70 via PR #1470.
21. BUG-835 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 49c930c6 and f0f770c5; robot run 33 could not read the dashboard tabs, so it is unproven.
22. BUG-834 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 980d2f65 and 5881da68 refuse an older stage; the empty "--approved-version=" bypass is a separate open item (ledger F-020, BUG-886).
23. BUG-833 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d79f8f10, 3.0.70 via PR #1461.
24. BUG-832 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit d79f8f10, 3.0.70 via PR #1461; final checks in 4cb41a0b.
25. BUG-831 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 7e60a2b7, 3.0.70 via PR #1453.
26. BUG-830 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 0e13f2b2, 3.0.70 via PR #1476.
27. BUG-829 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 111e1505 and a690f36d, 3.0.70 via PR #1456.
28. BUG-828 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 2efe9fbd and a6707cef, 3.0.70 via PR #1458; nobody watched AutoCAD feed the text.
29. BUG-827 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 7e60a2b7 and f8ba8b90, 3.0.70 via PR #1453; the settings file is no longer overwritten when locked.
30. BUG-826 | HAS-DRAFT | pilot-critical yes | draft PR #1457, branch tl2-r455-bug826-reset; not merged onto rel-20261026s or rel-20261102a.
31. BUG-825 | INSTALLED-WAITING-PROOF | pilot-critical yes | step-iron half Codex-accepted on 3.0.66; velocity half robot PASS through the settings guard only (PR #1447, tests in 088f7cd0); joint-label-height half not run.
32. BUG-824 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit fdd724fc, 3.0.70 via PR #1443.
33. BUG-823 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 9db7cdf7, 3.0.70 via PR #1442.
34. BUG-822 | UNCLEAR | pilot-critical no | Tim has never seen the docked What's New panel (decision 151); parked until a test lists open windows after each step.
35. BUG-821 | CLOSED-OR-WONT-FIX | pilot-critical no | closed as "works as designed" on Tim's yes, decision 178, 31 Oct.
36. BUG-820 | NEEDS-TIM | pilot-critical no | wording half is Codex-accepted (commits 438ed483, 0fdf8176); open question: should CE draw the one missing invert text, or leave it as designed?
37. BUG-819 | NEEDS-TIM | pilot-critical no | card approved 19 Oct but the pause (ruling A) is not lifted and it waits on Tim's review of the section list (BUG-818); no code exists.
38. BUG-818 | NEEDS-TIM | pilot-critical yes | Tim's ten-row check of the corrected section list is not done and hollow-section and top-hat data sources are open; PR #1932 only renames 34 UB and UC rows.
39. BUG-817 | INSTALLED-WAITING-PROOF | pilot-critical no | Codex FAIL on 3.0.70 (23 Oct); fix commit f0a52f77 (PR #1671) is dated 24 Oct, after that build, so it needs a retest.
40. BUG-816 | HAS-DRAFT | pilot-critical no | draft PR #1875 gives the label tidy its own Settings row (plus 3 wording commits on fb/bug816-tidy-setting-row); not on the line.
41. BUG-815 | ALREADY-FIXED | pilot-critical yes | Codex-accepted on 3.0.64 for the R-06 wording and the false "outside 225-600" rows; commit 64e6751b.
42. BUG-814 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 05451d53 and 51267fd2; Codex W1-05 BLOCKED (fixture lacks DP3 tags); the "AGI 1" spacing is Tim's call.
43. BUG-813 | UNCLEAR | pilot-critical no | only the refusal wording is built (PR #1478); the rename itself still fails, and it needs a fixture of two ordinary source blocks to prove.
44. BUG-812 | INSTALLED-WAITING-PROOF | pilot-critical no | commits cedc590e and 676874b5, PR #1717 on rel-20261102a; not opened in AutoCAD.
45. BUG-811 | INSTALLED-WAITING-PROOF | pilot-critical no | level-cascade half merged (commit 49792eca, PR #1712); the vision-log half has no fix.
46. BUG-810 | INSTALLED-WAITING-PROOF | pilot-critical no | commit a8df1459, PR #1713 on rel-20261102a.
47. BUG-809 | INSTALLED-WAITING-PROOF | pilot-critical no | items 2, 3 and 4 merged (commits 5635eac1, 1be523c1, 614f06da); items 1 and 5 have no fix; item 4 Codex BLOCKED.
48. BUG-808 | INSTALLED-WAITING-PROOF | pilot-critical no | outlet half merged (commit 834870f3, PR #1431); the "checked 12" counting half has no fix.
49. BUG-807 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 1be523c1, 3.0.70 via PR #1409.
50. BUG-806 | FIXABLE-NOW | pilot-critical no | no fix or PR; the entry names the rule (head from the orifice IL, never round above the PSD limit) and the mapper has no live caller yet.
51. BUG-805 | HAS-DRAFT | pilot-critical yes | draft PR #1987 (B-158): metres, depth column and half-blank rows; not on the line (PR #817 is only the older typed-level wording).
52. BUG-804 | FIXABLE-NOW | pilot-critical no | no fix or PR; expected result is stated (send the hinted page and its neighbours); costs paid pages, so the page count is a small choice.
53. BUG-803 | INSTALLED-WAITING-PROOF | pilot-critical yes | commits 6199df19 and f0a87b5a, PR #1419 merged on rel-20261102a; entry gives no install note.
54. BUG-802 | INSTALLED-WAITING-PROOF | pilot-critical no | fixed with BUG-875 (commits 6b0a09da and 4f66d540, PR #1650); latent until Ignore ships.
55. BUG-801 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 165a12fa, 3.0.70 via PR #1416.
56. BUG-800 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1414 in 3.0.70; regression tests in 088f7cd0 and d9cc6866; a false "Network OK" would hide a failed check.
57. BUG-799 | INSTALLED-WAITING-PROOF | pilot-critical no | commits 7f4f8c39 and 73cd6f15, PR #1554 merged on rel-20261102a; entry gives no install note.
58. BUG-798 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 55671710, 3.0.70 via PR #1420 (Settings switch ON).
59. BUG-797 | INSTALLED-WAITING-PROOF | pilot-critical yes | draft PR #1400 in 3.0.70; robot saw only the cascade, Undo and REDO; Codex V2 and V2b NOT TESTED; the locked-layer case has never been tested by anyone.
60. BUG-796 | HAS-DRAFT | pilot-critical yes | report half is PR #1701 (commit aaaa7ff4, merged on rel-20261102a); the preview and Yes/No half has no fix.

## What I could not verify

1. **Install state:** I did not read the installed DLL version. Every "installed" line comes from the carpark text or from a commit being on origin/claude/rel-20261102a. Entries 15, 16, 53 and 57 carry no install note in the carpark.
2. **Open draft PRs:** the gh search matches loose text, so a draft whose title does not name the bug number could be missed. All PRs returned are drafts, including ones merged into the release lines.
3. **Ledger:** areas\runner-reports\ledger.json is keyed by robot case (R09, R02 and so on), not by bug number, so I could not map it to these entries.
4. **Code:** I did not read the source to confirm any fix works. The code was not built, tested or run in AutoCAD.
