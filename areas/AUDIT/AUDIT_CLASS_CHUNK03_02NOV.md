# Carpark audit, chunk 3 of 21 (entries 121 to 180), Mon 2 Nov 2026

Read-only audit by Sonnet (Team). Nothing was changed except this file.

## FOR TIM

1. **Counts:** 60 entries (BUG-735 down to BUG-674). INSTALLED-WAITING-PROOF 45, ALREADY-FIXED 13, HAS-DRAFT 1, NEEDS-TIM 1, FIXABLE-NOW 0, DUPLICATE 0, CLOSED 0, UNCLEAR 0.
2. **Nothing here is waiting for a builder.** Every entry already has a fix installed in Civil 3.0.70 or a fix commit on the latest Civil line (origin/claude/rel-20261102a). The only entry with no fix is BUG-685.
3. **The one question for Tim (BUG-685):** when you type an upstream level of 10.125 and CE works the other end from the grade, does the typed level stay at 10.125 or round to 10.13 (nearest 10 mm)?
4. **Five most pilot-critical, waiting for proof in real AutoCAD (there are no FIXABLE-NOW entries):** BUG-731 and BUG-732 (Replace import erases earlier work or your own pipes), BUG-700 and BUG-699 (CDSURVEY drops or mis-scales levels), BUG-681 (schedule row disagrees with the drawn pipe after the Uphill answer).
5. **Thirteen entries still say OPEN but are already fixed in the code** (not yet installed): 719, 720, 723, 724, 725, 728, 729, 710, 690, 692, 693, plus 711 and 684 which are Claude-accepted. The carpark text needs updating by whoever owns it.
6. **Not proven:** I read entries, git history and the release branch only. No AutoCAD, no build, no test run. Details at the bottom.

---

"Pilot-critical yes" below means the entry is a data-loss, wrong-engineering-number or wrong-level risk on a core command (CD, Edit Pit, CDSURVEY, import, Pit Schedule), or is marked HIGH. That is my reading, not Tim's ruling.

## Entries

1. BUG-735 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 9e0b391e on rel-20261102a, installed 3.0.70 (PR #1367), no robot or Codex pass.
2. BUG-734 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 5beb2458 (PR #1368), installed 3.0.70, wrong upstream level risk, no robot or Codex pass.
3. BUG-733 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b2d2d8d2 (PR #1353), installed 3.0.70, a pit was silently not drawn.
4. BUG-732 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit cde06b41 (PR #1356), installed 3.0.70, data loss on Replace, no robot or Codex pass.
5. BUG-731 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits cde06b41 and fff9fbed (PR #1356), installed 3.0.70, data loss on declined review.
6. BUG-730 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit ba9935b0 (PR #1354), installed 3.0.70, loses invert levels from the schedule table.
7. BUG-729 | ALREADY-FIXED | pilot-critical no | Commit 2ed82768 on rel-20261102a (with 725 and 728); entry still says OPEN and it is not installed.
8. BUG-728 | ALREADY-FIXED | pilot-critical no | Commit 2ed82768 on rel-20261102a; entry still says OPEN, and the real-export check was never done.
9. BUG-727 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit e6de44ad (PR #1377), installed 3.0.70.
10. BUG-726 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 388fe5e9 (PR #1357), installed 3.0.70.
11. BUG-725 | ALREADY-FIXED | pilot-critical yes | Commit 2ed82768 on rel-20261102a (one scale per file); entry still says OPEN, not installed, millimetre LandXML scatters the network.
12. BUG-724 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a keeps the file's pipe class; entry says OPEN, not installed.
13. BUG-723 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a flags box pipes; entry says OPEN, not installed.
14. BUG-722 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1363; no commit tagged with the number found on rel-20261102a (my search by number only).
15. BUG-721 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b8f87ade (PR #1380), installed 3.0.70, data loss without a question.
16. BUG-720 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a splits control pit width; entry says OPEN, not installed.
17. BUG-719 | ALREADY-FIXED | pilot-critical yes | Commit f9eebcfb on rel-20261102a reads refStart/refEnd; entry says OPEN, and the entry's own "confirm with a real export" step is not recorded.
18. BUG-718 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1347 and #1351 (grouped LOW items).
19. BUG-717 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1348.
20. BUG-716 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1349.
21. BUG-715 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1346, pit design-level offer could be 0.2 m off with a breakline.
22. BUG-714 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1342 (shared level reader, same PR as 711 and 713).
23. BUG-713 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1342.
24. BUG-712 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 9fa679c8 (PR #1344), installed 3.0.70, robot observation PASS but not Codex-accepted.
25. BUG-711 | ALREADY-FIXED | pilot-critical no | FIXED (Claude-accepted, Civil 3.0.75, 25 Oct) by runner case R35, PR #1342; not confirmed in Tim's drawings.
26. BUG-710 | ALREADY-FIXED | pilot-critical yes | Merged PR #1341 (commit d51a13cb) on rel-20261102a; entry still says OPEN, wrong grade on metre drawings.
27. BUG-709 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1352 and #1438 (ships OFF); run 36 could not prove it.
28. BUG-708 | INSTALLED-WAITING-PROOF | pilot-critical no | Installed 3.0.70 via PR #1360.
29. BUG-707 | HAS-DRAFT | pilot-critical no | Draft PR #1545 (branch cx/fb10-c60); fix commits f44c5083 and 8ed03233 are on rel-20261102a, but the entry says it is not installed.
30. BUG-706 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 6b7c968e (PR #1376), installed 3.0.70.
31. BUG-705 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commits 63fe52f5 and 7250faf2 (PR #1374), installed 3.0.70.
32. BUG-704 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commits 3579d32e and cb770842 (PR #1361), installed 3.0.70; a Codex check was blocked by a shared lock.
33. BUG-703 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit d6abf468 (PR #1371), installed 3.0.70, wrong ground levels at pits if it fails.
34. BUG-702 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 6332655f (PR #1362), installed 3.0.70, needs an AutoCAD scenario.
35. BUG-701 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit e9d3ebde (PR #1369), installed 3.0.70, possible hang in millimetre drawings.
36. BUG-700 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit de50f69f (PR #1375), installed 3.0.70, levels 1000 times too big if it fails.
37. BUG-699 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits 24e21a90 and 8af545ac (PR #1352), installed 3.0.70, drops spot levels above RL 500 on hill sites.
38. BUG-696 | INSTALLED-WAITING-PROOF | pilot-critical no | Entry says installed 3.0.70 via PR #1331; I found no commit tagged BUG-696 on rel-20261102a (not verified).
39. BUG-695 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 5af6ef3e (PR #1331), installed 3.0.70, only the quoted distance was wrong.
40. BUG-694 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit c9ee9843 (PR #1325), installed 3.0.70.
41. BUG-693 | ALREADY-FIXED | pilot-critical no | Commit 69451402, merged PR #1688 on rel-20261102a; entry says OPEN, not installed.
42. BUG-692 | ALREADY-FIXED | pilot-critical no | Commit 69451402, merged PR #1688 (e428d31f) on rel-20261102a; entry says OPEN, not installed.
43. BUG-691 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1335 (commit 1bd133b9), wrong split level of 19.95 instead of 19.97 if it fails.
44. BUG-690 | ALREADY-FIXED | pilot-critical yes | Merged PR #1659 (commit 92ebe3a7) on rel-20261102a; entry says OPEN, a junction could vanish from the Pit Schedule.
45. BUG-689 | INSTALLED-WAITING-PROOF | pilot-critical yes | Installed 3.0.70 via PR #1327; no commit tagged BUG-689 found on rel-20261102a (not verified), back-fall warning missing.
46. BUG-688 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2644c197 (PR #1327), installed 3.0.70.
47. BUG-687 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 6e30fc50 (PR #1319), installed 3.0.70, a typed flow was silently lost.
48. BUG-686 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2c21b843 (PR #1320), installed 3.0.70.
49. BUG-685 | NEEDS-TIM | pilot-critical yes | Two of Tim's rules conflict: should a typed upstream level (10.125) stay exact or round to the nearest 10 mm (10.13)?
50. BUG-684 | ALREADY-FIXED | pilot-critical yes | FIXED (Claude-accepted, Civil 3.0.75, 25 Oct) by runner case R39b, PR #1321; the "pick an existing CE pipe" half is not proved.
51. BUG-683 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits c807cd0e and f5e5472a (PR #1437), installed 3.0.70; run 36 could not reach the question.
52. BUG-682 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 60fcad04 (PR #1435), installed 3.0.70.
53. BUG-681 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit b26a8ef3 (PR #1434), installed 3.0.70, schedule and drawing could disagree on levels.
54. BUG-680 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 3c539f02 (PR #1323), installed 3.0.70.
55. BUG-679 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit f100040a (PR #1326) covers the turn half; entry also lists an Align-to-building half that I could not confirm was done.
56. BUG-678 | INSTALLED-WAITING-PROOF | pilot-critical no | Entry says installed 3.0.70 via PR #1318; no commit tagged BUG-678 found on rel-20261102a (not verified).
57. BUG-677 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix commit 2b8ab057 (PR #1323), installed 3.0.70.
58. BUG-676 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 4e41ad56 (PR #1324), installed 3.0.70, a trafficable lid was silently downgraded.
59. BUG-675 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit 4a56a72d (PR #1318), installed 3.0.70, rotated pit passed the fit check wrongly.
60. BUG-674 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commit f100040a (PR #1326), installed 3.0.70, pipe ends stayed inside or short of the pit walls.

## What I could not verify

1. **Nothing was run.** No AutoCAD, no build, no tests, no robot. I read the carpark text, searched git history on origin/claude/rel-20261102a by bug number, and read the commit titles.
2. **No fix was read line by line.** A commit titled "Fix BUG-NNN" is taken as the fix for that entry. I did not check that it does everything the Expected behaviour line asks.
3. **No ledger evidence.** I searched the runner-report ledger for these bug numbers and found no entries; whether those reports use another label I did not check.
4. **Three entries have no commit under their own number** on rel-20261102a: BUG-678, BUG-689, BUG-696. I took the entry's own "installed 3.0.70 via PR" text. They may be inside a larger commit.
5. **No `gh`.** The GitHub command is not on this tool's path, so PR numbers come from the carpark text and commit titles, not from GitHub. I could not check whether PR #1545 is still an open draft.
6. **Installed versus on the branch.** For the 13 ALREADY-FIXED entries I know the fix is on rel-20261102a. I did not check what version is installed on Tim's machine, so "not installed" comes from the carpark entry text.
7. **Structural line (rel-20261026s) not searched.** All entries in this chunk are Civil.
