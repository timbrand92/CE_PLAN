# Carpark audit, chunk 18 of 21 (BUG-1071 to BUG-1130), Mon 2 Nov 2026

## FOR TIM

1. **Counts (60 entries):** 35 have a draft or branch, 9 look already fixed in the Civil line, 7 are fixable now, 6 need your ruling, 2 are unclear, 1 is closed (won't fix). Nothing is installed-waiting-proof that I could confirm.
2. **Most pilot-critical fixable now, 1:** BUG-1081, Water Tank writes riser and dropper lettering onto a locked layer.
3. **Most pilot-critical fixable now, 2:** BUG-1080, CDREFRESHBLOCKS changes the shared symbol that locked copies use.
4. **Most pilot-critical fixable now, 3:** BUG-1083, Water Tank accepts an attached Xref as the block to turn into a tank.
5. **Most pilot-critical fixable now, 4:** BUG-1105, a Blue Factor report's tank is never compared with the drawn reuse share. Only four of the seven fixable-now entries are pilot-critical (the rest are BUG-1114, 1118, 1127).
6. **PROBLEM FOUND, needs CE 05 today:** `C:\CE_PLAN\BUG_CARPARK.md` has been cut down to 5 lines. Commit 20e999d3 ("BUG-791 note: Plan size (mm) wording is intended") overwrote the file, and 5cd059e9 repeated it. The last good copy is commit b498a968 (17,974 lines). I did not touch it.

## What I read, and what I could not verify

1. **Read:** every entry's Symptom, Expected and Status for BUG-1071 to BUG-1130, taken from the good copy (commit b498a968), because the live file is damaged. The file has grown since the brief, so I went by heading id, not position. By id the range starts at BUG-1071 and ends at BUG-1130, as the brief said.
2. **Checked:** git history on origin/claude/rel-20261102a (fetched), and every remote branch whose name carries a bug number in this range, to see whether it is already in the Civil line.
3. **Not verified, PRs:** the `gh` command is not on this tool's path, so I could not list PRs. Where the carpark names a PR (#1900, 1902 to 1905, 1908) I quote it; otherwise I name the branch. A branch with "not in the Civil line" has at least one commit that rel-20261102a lacks.
4. **Not verified, Structural:** the Structural drafts (BUG-1121 to 1129) were checked against the carpark notes and branch names only, not against rel-20261026s.
5. **Not verified, ledger:** the runner ledger (ledger.json) has no entry naming any BUG in this range that I could find, so I have no robot or Codex result for any of them.
6. **ALREADY-FIXED means merged, not accepted:** every one of the nine is merged into the Civil line but the carpark still says OPEN, and I found no real-AutoCAD acceptance. Under the ledger rules none counts FIXED yet.
7. **Not run:** no build, no test, no AutoCAD, no robot.

## Classification (one line per entry)

1. BUG-1071 | HAS-DRAFT | no | Branch origin/fb/bug1071-skipped-save-honest (1 commit not yet in rel-20261102a); no PR number checked.
2. BUG-1072 | HAS-DRAFT | no | Branch origin/fb/b12-BUG-1072-backup-words ("Also autosave" tick wording); not in the Civil line.
3. BUG-1073 | HAS-DRAFT | no | Branch origin/fb/b12-BUG-1073-markup-unreadable (plain [CE] sentence); not in the Civil line.
4. BUG-1074 | ALREADY-FIXED | no | Commit 9135d337 via PR #1718 is in rel-20261102a; carpark still says OPEN and no AutoCAD acceptance found.
5. BUG-1075 | ALREADY-FIXED | no | Same commit 9135d337 / PR #1718 (CDSPINEUPGRADE wording) is in rel-20261102a; carpark still OPEN.
6. BUG-1076 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1076-diagnostics-words; not in the Civil line.
7. BUG-1077 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1077-bset-words; not in the Civil line.
8. BUG-1078 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1078-markup-help-words; not in the Civil line.
9. BUG-1079 | HAS-DRAFT | no | Branch origin/fb/b13-BUG-1079-pdf-help-words; not in the Civil line.
10. BUG-1080 | FIXABLE-NOW | yes | No branch or commit found; the entry names the code (db.Insert in CDREFRESHBLOCKS) and the exact skip-and-say rule; protected-layer rule.
11. BUG-1081 | FIXABLE-NOW | yes | No branch or commit found; entry says check each attribute's real layer and drop the allow-on-locked flag; protected-layer rule.
12. BUG-1082 | HAS-DRAFT | yes | Branch origin/fb/b14-bug-1082-level-mark-locked (locked 25DIMS/25TEXT and REFEDIT stop); not in the Civil line.
13. BUG-1083 | FIXABLE-NOW | yes | No branch or commit found; entry says reject an attached or overlaid Xref at the pick and at Apply, with a plain message.
14. BUG-1084 | UNCLEAR | no | Entry itself says "not yet shown": Codex must first confirm in native AutoCAD that Hatch Change edits inside REFEDIT; no result recorded.
15. BUG-1085 | ALREADY-FIXED | no | Commit c9b41484 via PR #1730 is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
16. BUG-1086 | ALREADY-FIXED | no | Same commit c9b41484 / PR #1730 is in rel-20261102a; carpark still OPEN.
17. BUG-1087 | ALREADY-FIXED | no | Commit 02508426 via PR #1733 is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
18. BUG-1088 | HAS-DRAFT | yes | Branch origin/fb/bug1088-sizer-grade-ladder; entry says the preferred design grade number needs Tim's ruling, so check what number the draft used.
19. BUG-1089 | HAS-DRAFT | yes | Branch origin/cx5/bug-1089-pipeflows-settings-limits (3 commits, recorded evidence); not in the Civil line.
20. BUG-1090 | HAS-DRAFT | yes | Branch origin/fb/pc4-bug1090-hgl-not-checked (commit f3f38c24) sits one commit past rel-20261102a.
21. BUG-1091 | HAS-DRAFT | yes | Branch origin/fb/bug1091-redesign-reads-min-fall (2 commits); not in the Civil line.
22. BUG-1092 | HAS-DRAFT | yes | Branch origin/fb/bug1092-uphill-any-fall (2 commits, one a review fix); not in the Civil line.
23. BUG-1093 | HAS-DRAFT | yes | Branch origin/fb/bug1093-cover-rl-zero (2 commits); not in the Civil line.
24. BUG-1094 | HAS-DRAFT | yes | Branch origin/claude/b131-bug1094-inspector-grade-red (B-131); not in the Civil line.
25. BUG-1095 | ALREADY-FIXED | yes | Commit b531c85e via PR #1852 (B-017) is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
26. BUG-1096 | HAS-DRAFT | yes | Branch origin/fb/bug1096-reuse-boxes (3 commits, B-029b); not in the Civil line.
27. BUG-1097 | ALREADY-FIXED | yes | Commit 2817bf97 via PR #1859 (B-034) is in rel-20261102a; carpark still OPEN, no AutoCAD proof seen.
28. BUG-1098 | HAS-DRAFT | yes | Branch origin/cx6/bug-1098-bd29 (Kingston credit and eligibility); not in the Civil line.
29. BUG-1099 | HAS-DRAFT | no | Branch origin/fb/bug1099-council-tc (B-018); entry says Tim must rule first because the same Tc sizes the outlet pipe (question C17).
30. BUG-1100 | NEEDS-TIM | no | Which "basis" choices does CDDESIGN ask for when a council has no reuse rule, and how is the answer saved on the job?
31. BUG-1101 | ALREADY-FIXED | no | Commit 67e50f68 via PR #1770 is in rel-20261102a; carpark still OPEN.
32. BUG-1102 | HAS-DRAFT | no | Branch origin/cx6/bug-1102-bd23 (underground detention warning); not in the Civil line.
33. BUG-1103 | HAS-DRAFT | no | Branch origin/cx4/bug-1103-charged-diameter-sense (2 commits); not in the Civil line.
34. BUG-1104 | HAS-DRAFT | no | Branch origin/claude/b132-bug-1104-tank-orifice-minimum is one commit ahead; a second branch cx6/bug-1104-bd24 is already inside the Civil line, so check which is current.
35. BUG-1105 | FIXABLE-NOW | yes | No branch or commit found; entry gives the full rule (store rating, file, date, tank litres; warn on mismatch; typed-reason override).
36. BUG-1106 | ALREADY-FIXED | no | Commit 3a0c8a5e via PR #1761 is in rel-20261102a; carpark still OPEN.
37. BUG-1107 | HAS-DRAFT | no | Branch origin/cx6/bug-1107-bd26 (5 commits ahead); not in the Civil line.
38. BUG-1108 | HAS-DRAFT | yes | Branch origin/fb/bug1108-reuse-share-minimum (B-120, 4 commits); not in the Civil line.
39. BUG-1109 | NEEDS-TIM | no | May the office change council values through an overlay file in CDRULEBOOK, and who may do it?
40. BUG-1110 | HAS-DRAFT | no | Branch origin/cx6/bug-1110-bd27 (3 commits); not in the Civil line.
41. BUG-1111 | HAS-DRAFT | no | Branch origin/cx4/bug-1111-predev-c-working-text; not in the Civil line.
42. BUG-1112 | HAS-DRAFT | no | Branch origin/claude/bug-1112-wsud-export-no-sample-site (B-061); not in the Civil line.
43. BUG-1113 | HAS-DRAFT | no | Branch origin/cx4/bug-1113-bluefactor-same-name (2 commits); not in the Civil line.
44. BUG-1114 | FIXABLE-NOW | no | No branch or commit found; entry asks for a tank list box on the Settings page, no engineering number needed.
45. BUG-1115 | HAS-DRAFT | no | Branch origin/cx5/bug-1115-cdwt-typed-zero-detention (4 commits); not in the Civil line.
46. BUG-1116 | HAS-DRAFT | no | Branch origin/claude/b132-bug-1116-large-lot-tc-note; not in the Civil line.
47. BUG-1117 | NEEDS-TIM | no | Delete the unused ifd-melbourne.json, or make CE read it so the office can edit rainfall?
48. BUG-1118 | FIXABLE-NOW | no | No branch or commit found; entry says scale the 100-unit preview through the drawing-unit conversion.
49. BUG-1119 | CLOSED-OR-WONT-FIX | no | Status WONT FIX on Tim's yes (decision 178, 31 Oct 2026): no command calls the detector yet.
50. BUG-1120 | NEEDS-TIM | no | Confirm the STORM "None" wording, the Bayside reuse formula and the charged-downpipe citation.
51. BUG-1121 | HAS-DRAFT | no | Carpark note: DRAFT PR #1900 (B-081), built and unit-tested only.
52. BUG-1122 | HAS-DRAFT | no | Carpark note: DRAFT PR #1905 (B-083), built and unit-tested only.
53. BUG-1123 | HAS-DRAFT | no | Carpark note: DRAFT PR #1903 (B-083), built and unit-tested only.
54. BUG-1124 | NEEDS-TIM | no | Approve a new CEMEMBER question "Upright leg [Long/Short]" for unequal angles (review-gate workflow card needed).
55. BUG-1125 | NEEDS-TIM | no | Approve a new CEMEMBER "Standing/Flat" question for RHS (review-gate workflow card needed).
56. BUG-1126 | HAS-DRAFT | no | Carpark note: DRAFT PR #1902 (B-082), built and unit-tested only.
57. BUG-1127 | FIXABLE-NOW | no | No branch found; entry gives the exact fix (outer tip corners sharp, arc on the inside corner) from supplier drawings.
58. BUG-1128 | HAS-DRAFT | no | Carpark note: DRAFT PR #1904 (B-083), built and unit-tested only.
59. BUG-1129 | HAS-DRAFT | no | Carpark note: DRAFT PR #1908 (B-088); N40, R6, R10 still have no catalogue row.
60. BUG-1130 | UNCLEAR | no | Needs the 250UC89.5 root radius from the BUG-818 section list, which is not in yet; no branch found.
