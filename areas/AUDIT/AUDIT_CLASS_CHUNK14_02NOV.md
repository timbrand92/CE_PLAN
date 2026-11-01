# Carpark audit, chunk 14 of 21 (entries 781 to 840)

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, read-only. Covers the 60 "## BUG-" headings from BUG-628 to BUG-889 in `C:\CE_PLAN\BUG_CARPARK.md` (heading 781 is BUG-628, heading 840 is BUG-889; BUG-CDCHECKIGNORE-UNDO-C60 is heading 816 and is included).

## FOR TIM

1. **Counts:** 30 already fixed in code (merged, not yet proven in AutoCAD), 9 have a draft, 7 need your ruling, 5 unclear, 4 fixable now, 3 installed and waiting for proof, 1 duplicate, 1 closed (60 in all).
2. **Fixable now (only four exist, none is critical for 9 Nov):** BUG-879 (hand-moved labels not marked as hand-placed), BUG-648 (AG drain grade label missing on the drawing), BUG-882 (installer asks for administrator rights; the pilot uses a hand install), BUG-888 (no way back if the installer is stopped half-way).
3. **Your rulings wanted (7):** BUG-641 (how to split catchment between pits), BUG-866 (rainfall curve wording and values), BUG-632 (section letter in the clear half: switch ships OFF), BUG-634 and 636 (approve the DSET card), BUG-631 (link between section line, bubbles and labels), BUG-883 (how a new colleague first installs).
4. **Most pilot-critical not yet proven in AutoCAD:** BUG-650 and BUG-649 (stored inverts blanked, rising drain passed), BUG-635 (dimension number stays wrong after DSET1), BUG-868 to 871 (pipe material, pit floor depth, units). BUG-861 (REDO lost after the first click) is still unexplained.
5. **Not proven:** nothing here was run in AutoCAD by me. "Already fixed" means the fix is merged in the code lines; it does not mean the carpark Status line was accepted. Most Status lines in this block still say OPEN.

## Entries

1. BUG-628 | ALREADY-FIXED | pilot-critical no | commit cfaa62ca (BL zigzag follows drawing scale, Structural line rel-20261026s, "needs Opus review"); Codex 18 Oct saw it before this; no AutoCAD proof since.
2. BUG-629 | ALREADY-FIXED | pilot-critical no | commits 6e77bf21 and 2965212f (BL and 25C text go into the current space, sized as plotted) on the Structural line; not proven in AutoCAD.
3. BUG-630 | HAS-DRAFT | pilot-critical no | draft PR #1981 (branch fb/bug630-section-mark-preview, SM card approved by Tim decision 171); block direction not yet applied.
4. BUG-631 | NEEDS-TIM | pilot-critical no | question: how should the section cut line, both bubbles and labels be tied together so they move as one (design pass inside the approved SM card, not answered).
5. BUG-632 | NEEDS-TIM | pilot-critical no | fix 80943121 exists but finalizer bf33ad78 ships it OFF "until Tim rules"; question: should the section letter sit in the clear half of the bubble by default?
6. BUG-633 | ALREADY-FIXED | pilot-critical no | commit 7d9599b5 (DSET accepts any kind of dimension) on the Structural line; not proven in AutoCAD.
7. BUG-634 | NEEDS-TIM | pilot-critical no | question: approve the DSET workflow card (mapping already given in decision 172: other styles become TIM LEADER or TIM DOT LEADER, old style purged); card still DRAFT, nothing built.
8. BUG-635 | ALREADY-FIXED | pilot-critical yes | commits 79c6af98 and bf7a3e82 (DSET, DSET1, DUP redraw and read the number back, switch default on); not proven in AutoCAD.
9. BUG-636 | NEEDS-TIM | pilot-critical yes | engine half merged (REGRESSION_LOG Structural line 803/808), but the pick, Preview and Apply window needs the DSET card approved (same question as BUG-634).
10. BUG-637 | UNCLEAR | pilot-critical no | Civil half built (REGRESSION_LOG 5700/5711, custom note beside "With Step Irons"); missing: an AutoCAD run of DUP to see if the two schedule notes still change, cause was never proved.
11. BUG-638 | ALREADY-FIXED | pilot-critical yes | REGRESSION_LOG entry at line 803 on the Structural line (locked-layer dimension refused, with BUG-583); no commit message names it and no AutoCAD proof.
12. BUG-639 | CLOSED-OR-WONT-FIX | pilot-critical no | Status line: WONT FIX, docs only, closed on Tim's yes (decision 178, 31 Oct).
13. BUG-640 | HAS-DRAFT | pilot-critical no | draft PR #1907 (B-087, switch Annotation.ArcDimSelectsGeometryFirst); built and unit-tested only.
14. BUG-641 | NEEDS-TIM | pilot-critical no | question: what dividing rule splits the catchment between pits (nearest pit, or drawn by the drafter)? REGRESSION_LOG 5828 says this is Tim's call.
15. BUG-642 | HAS-DRAFT | pilot-critical no | draft PR #1924 (B-111, branch claude/bug-642-catchment-label-clear-spot); first fix 287f788f is installed and still fails (Codex 18 Oct); units question with CE 04.
16. BUG-643 | INSTALLED-WAITING-PROOF | pilot-critical yes | commit 137834ed via PR #1269, installed in Civil 3.0.70; not yet tested by robot or Codex.
17. BUG-644 | HAS-DRAFT | pilot-critical no | branch origin/claude/bug-644-text-side-at-insertion (261aa2e9, F flips Top and Bottom at 25L insertion); PR number not verified (gh not available).
18. BUG-645 | HAS-DRAFT | pilot-critical no | branch origin/claude/bug-645-r2ltxt-ask-first (5fece523, R2LTXT asks first); PR number not verified (gh not available).
19. BUG-646 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 1251b22f via PR #1282, installed in Structural 1.0.121 per the entry; not yet tested by robot or Codex.
20. BUG-647 | UNCLEAR | pilot-critical no | CDFW part fixed (fb04a578), but the strip as a real asset whose MOVE carries its 17 child items has no stated design; missing: a build plan for the compound strip record.
21. BUG-648 | FIXABLE-NOW | pilot-critical no | AG drain accepts but draws no grade text; expected (visible 1:50 label tied to the run, one per run) is clear and no fix exists in either line.
22. BUG-649 | ALREADY-FIXED | pilot-critical yes | commits 3fb0ddbb and 72e2295f (rising drain warns, never "meets"), REGRESSION_LOG 5575 area; not proven in AutoCAD.
23. BUG-650 | ALREADY-FIXED | pilot-critical yes | commit da006db6 (cancelling CDFW or CDSOURCE no longer blanks pit inverts); not proven in AutoCAD.
24. BUG-697 | ALREADY-FIXED | pilot-critical no | commits 12ec1d1c and 1041f89b; Status line is FIXED (Claude-accepted, Civil 3.0.75, runner R39).
25. BUG-698 | ALREADY-FIXED | pilot-critical yes | commits b2c0a5bb and 225f0fc0; Status line is FIXED (Codex-accepted, Civil 3.0.64) and robot runs 31 to 46 pass.
26. BUG-856 | ALREADY-FIXED | pilot-critical no | commit e27b4971; Status line is FIXED (Codex-accepted, Civil 3.0.67, 21 Oct).
27. BUG-857 | ALREADY-FIXED | pilot-critical no | PR #1858 merged at c92db9ad (Esc and X cancel, Cancel button added); message says NOT BUILT, not proven in AutoCAD.
28. BUG-858 | INSTALLED-WAITING-PROOF | pilot-critical no | commit 55a507f9 via PR #1510, installed in Structural 1.0.121; not yet tested by robot or Codex.
29. BUG-859 | UNCLEAR | pilot-critical no | PR #1834 (9b2da5c3) merged, but the robot failed 2 of 3 runs on Civil 3.0.88 (one pass was a one-off); missing: why the double-click route is flaky.
30. BUG-860 | ALREADY-FIXED | pilot-critical no | PR #1862 merged at c8df2e8c (green label double-click opens Edit source, switch ON); not proven in AutoCAD.
31. BUG-861 | UNCLEAR | pilot-critical yes | only diagnostic builds merged (PRs #1779, #1798, #1818, #1829); the robot still loses REDO after the first click on 3.0.83 and the cause is unknown.
32. BUG-862 | ALREADY-FIXED | pilot-critical no | commit 95eafe45 (command outcome line says completed after an Esc-ended run, refused for refusals); log line only.
33. BUG-863 | ALREADY-FIXED | pilot-critical no | Status line is FIXED (Claude-accepted, Civil 3.0.75, runner R10); guard commit d463134a.
34. BUG-864 | ALREADY-FIXED | pilot-critical no | PR #1529 merged into S-44 at 4db7661a (existing hidden layers kept); not proven in AutoCAD.
35. BUG-865 | UNCLEAR | pilot-critical no | no fix found; missing: the entry gives no speed target or measured drawing size, and its own text says a later Status line follows but none exists.
36. BUG-CDCHECKIGNORE-UNDO-C60 | ALREADY-FIXED | pilot-critical no | PR #1524 merged (eabeda2c, code 0d6ab60a); entry still says real-AutoCAD acceptance pending.
37. BUG-866 | NEEDS-TIM | pilot-critical yes | question: what should the CDDESIGN rainfall-curve note say, and are the curve values right (6 to 8 per cent low on Glen Eira sheets)? Branch b130-bug-866-rainfall-note exists, no ruling yet.
38. BUG-867 | ALREADY-FIXED | pilot-critical yes | PR #1530 merged at acd73cb4 (grade and speed on real pipe length, branch cx/eng-real-length-c60); not proven in AutoCAD.
39. BUG-868 | ALREADY-FIXED | pilot-critical yes | commit b8c17aa1 (PR #1676, pipe material in network sizing, switch ON); the first draft #1537 was never merged but this finished it.
40. BUG-869 | ALREADY-FIXED | pilot-critical yes | PR #1531 merged at 8f2d73fe (Pit Schedule depth to pit floor, commits 4a438d26 and ca83afd0); not proven in AutoCAD.
41. BUG-870 | HAS-DRAFT | pilot-critical yes | draft PR #1551 (branch cx/eng-move-pit-grade-c60, not merged); live wiring blocked behind a Settings switch in a protected file.
42. BUG-871 | ALREADY-FIXED | pilot-critical yes | PR #1538 merged at 218f09e7 (CDTWL reads drawing units, bf311924); not proven in AutoCAD.
43. BUG-872 | DUPLICATE-OF-BUG-095 | pilot-critical no | Status line says duplicate of BUG-095 and BUG-307; test-only fix, no separate work.
44. BUG-873 | HAS-DRAFT | pilot-critical no | PR #1977 (B-125, commit 9022d0d1, switch ON) is merged only in the newer C-79c on rel-20261112a, not in rel-20261102a.
45. BUG-874 | ALREADY-FIXED | pilot-critical no | commit cda22fb9 with review fix f119d8e7 (Esc after a CD pipe keeps the callout linked); not proven in AutoCAD.
46. BUG-875 | ALREADY-FIXED | pilot-critical no | PR #1650 merged (6b0a09da, follow-up 4f66d540); switch OFF today.
47. BUG-876 | ALREADY-FIXED | pilot-critical no | commit 73bc8264 (Replace keeps old pit when new one cannot be drawn); not proven in AutoCAD.
48. BUG-877 | ALREADY-FIXED | pilot-critical no | commit 91d8c39d with review fix 98006988 (import page no longer shows the first file after another is chosen); not proven in AutoCAD.
49. BUG-878 | ALREADY-FIXED | pilot-critical no | commit fca3e025 (a pipe no longer takes the single level named for another pipe); not proven in AutoCAD.
50. BUG-879 | FIXABLE-NOW | pilot-critical no | clear expected result (any CE hand move marks the label as hand-placed), file references given, Opus-checked; no fix in either line; protected file so Sonnet lane.
51. BUG-880 | ALREADY-FIXED | pilot-critical no | commit c857bdf9 (CEMEMBER held in a non-millimetre drawing) on the Structural line; chose the "warn" option; not proven in AutoCAD.
52. BUG-881 | ALREADY-FIXED | pilot-critical no | PR #1577 merged at b02389e2 (commit 8564a300, hatch audit keeps scale when scales disagree).
53. BUG-882 | FIXABLE-NOW | pilot-critical no | Installer/app.manifest line 7 on rel-20261102a still says requireAdministrator; pilot uses a hand install so not critical for 9 Nov.
54. BUG-883 | NEEDS-TIM | pilot-critical no | question: should double-clicking the installer do a first install (and what does it install), or does the pilot stay on hand install? Only the folder step HUNT-M-14 (280e7681) exists.
55. BUG-884 | ALREADY-FIXED | pilot-critical no | PR #1647 merged at 5ebefe6c (approvals resolve under each PC's office root, 066f8e09).
56. BUG-885 | HAS-DRAFT | pilot-critical no | draft PR #1649 (branch cx2/bug-885-frozen-packaging, not merged in rel-20261102a).
57. BUG-886 | ALREADY-FIXED | pilot-critical no | PR #1648 merged at 74cf6294 (office approval floor, unknown-office warning kept).
58. BUG-887 | HAS-DRAFT | pilot-critical no | draft PR #1652 (branch cx2/bug-887-shared-pair, commit 3ce97d64, not merged in rel-20261102a).
59. BUG-888 | FIXABLE-NOW | pilot-critical no | entry states a clear expected result (tested recovery of a complete pair, documented uninstall); no fix found in the installer code.
60. BUG-889 | ALREADY-FIXED | pilot-critical no | PR #1653 merged at b77c1a5b (Ignore offers "Asked again" rows); switch OFF today.

## What I could not verify

1. **Pull request states:** the `gh` tool is not installed in this session, so every PR state comes from git merge history and the carpark text. PR numbers for BUG-644 and BUG-645 are not known; only their branch names.
2. **AutoCAD proof:** nothing was run. I did not check the robot ledger case by case; ledger.json lists cases (R09, R10 and so on), not bug numbers, so I used the carpark's own Status lines for the accepted ones (697, 698, 856, 863).
3. **Installed versions:** I did not read the installed DLLs. "Installed" for 643, 646 and 858 is taken from the carpark text, not checked.
4. **Newer lines:** rel-20261106a to rel-20261112a exist on the remote and are ahead of rel-20261102a (178 commits for 1112a). I classified against rel-20261102a and rel-20261026s as asked, and looked at 1112a only for BUG-873 and BUG-890 (PRs #1977 and #1978 are merged there). Other entries in this chunk may also be merged there.
5. **Merged but not accepted:** the 30 "ALREADY-FIXED" lines are code merges. Under RULES 13.3 none is FIXED without a robot PASS plus a Codex PASS, except the four that already carry that on their Status line.
6. **Headings skipped:** two non-BUG headings sit inside this range (AUDIT-XCLMTXT-DECIMALS and AUDIT-XCLMTXT-ANGLES, both in draft PR #1533, already merged on the Structural line). They are not counted because they are not "## BUG-" headings.
