# Carpark audit, chunk 15 of 21 (headings 841 to 900)

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, read-only. Covers BUG-890 to BUG-950 in `C:\CE_PLAN\BUG_CARPARK.md`: 61 entries, because counting "## BUG-" headings from the top gives heading 841 = BUG-890 (chunk 14 ended at BUG-889), while the brief named BUG-891 to BUG-950. I took both ends so nothing is missed. Checked against `origin/claude/rel-20261102a` (Civil/Manager) and `origin/claude/rel-20261026s` (Structural) after a fetch.

## FOR TIM

1. **Counts:** 31 have a draft waiting (21 of them are the one wording pull request #1534, on hold), 16 are already fixed in code, 7 can be fixed now, 6 need your ruling, 1 is unclear (61 in all).
2. **Fixable now (7):** BUG-900 (a pit schedule over several PDF pages loses the later pages' sizes and levels) is the only one that touches the 9 Nov pilot. The other six (BUG-893 to 897, 925) are Tidy labels clean-ups behind a switch that ships OFF, plus the Council source window wording.
3. **Your rulings wanted (6):** BUG-950 (kN rating per bracing type), BUG-949 (LBH hatch density at 1:100), BUG-909 (CEMEMBER with raised picks and the UCS), BUG-910 (break marks on a layout sheet), BUG-934 (one name for Settings or Preferences), BUG-935 (the two things called "CE Manager").
4. **Most pilot-critical not yet proven in AutoCAD:** BUG-901, 904, 905 (cover and storage figures, merged), BUG-899 and 898 (import position and results page), BUG-903 and 907 (cover and pit-drop checks, drafts only).
5. **Not proven:** nothing was run in AutoCAD by me, and "already fixed" means merged in the code lines, not accepted. Nearly every Status line in this block still says OPEN, so the carpark lags the code.
6. **Could not check:** the `gh` tool is not available on this PC, so I could not read pull request states. Draft status comes from branch tips, merge commits and the notes in the carpark, not from GitHub.

## Entries

1. BUG-890 | HAS-DRAFT | pilot-critical no | branch origin/claude/b125-n11-bug890-leaderout-plain-labels-stay (1 Nov, B-125, switch linking.tidyLeade...) is not in either release line; no PR number verified.
2. BUG-891 | HAS-DRAFT | pilot-critical no | branch origin/claude/b125-n11-bug891-tidy-scan-own-space-and-reach (1 Nov) is not merged; switch OFF.
3. BUG-892 | ALREADY-FIXED | pilot-critical no | commit 498f0f7a on the Civil line, REGRESSION_LOG entry "BUG-892"; REDO loss never seen in AutoCAD.
4. BUG-893 | FIXABLE-NOW | pilot-critical no | only branch cx2/bug-893-ledger-batch05 (1 commit that routes the work, no code); Expected is clear, protected file so Sonnet lane.
5. BUG-894 | FIXABLE-NOW | pilot-critical no | same routing-only branch as BUG-893, no fix written; switch OFF.
6. BUG-895 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; Expected is clear ("Moved" counts real moves).
7. BUG-896 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; builder picks the bounded-work wording; switch OFF.
8. BUG-897 | FIXABLE-NOW | pilot-critical no | same routing-only branch, no fix written; builder picks the work cap, Expected says "no hard block"; switch OFF.
9. BUG-898 | HAS-DRAFT | pilot-critical yes | branch origin/claude/b122-bug898-import-results-from-drawn (31 Oct, B-122) builds on the BUG-505 work (PR #1853 is merged) but is not merged itself.
10. BUG-899 | ALREADY-FIXED | pilot-critical yes | PR #1654 merged at ca5553d6 on the Civil line; not seen in AutoCAD.
11. BUG-900 | FIXABLE-NOW | pilot-critical yes | no commit, branch or log entry found; Expected is clear (collect rows from every schedule page); file Extract-XcivilPdfSchedule.ps1.
12. BUG-901 | ALREADY-FIXED | pilot-critical yes | PR #1848 merged at 3261cf8f plus follow-up 21a3bbb4 (Unknown wall reads Unknown); REGRESSION_LOG says built and unit-tested only, Tim's ruling recorded there.
13. BUG-902 | HAS-DRAFT | pilot-critical no | branches fb/bug902-cover-unknown-note and wip/bug902-b026c-rebase-30oct (30 Oct) cover only the Unknown cover row; checking cover along the pipe still needs Tim's word after 9 Nov.
14. BUG-903 | HAS-DRAFT | pilot-critical yes | draft PR #1920 (B-096, branch fb/bug903-measure-to-pipe-top-b096) per the carpark Note, after Tim's "10yes"; not merged, not opened in AutoCAD.
15. BUG-904 | ALREADY-FIXED | pilot-critical yes | PR #1656 merged at cb53d0f8 (warns when the shortest storm governs); REGRESSION_LOG entry; not seen in AutoCAD.
16. BUG-905 | ALREADY-FIXED | pilot-critical yes | PR #1856 merged at b780b732 (switch detention.boydsUsesHardGroundC ON); REGRESSION_LOG says it stays open until Tim has seen it.
17. BUG-906 | ALREADY-FIXED | pilot-critical no | PR #1655 merged at 52efb49b; REGRESSION_LOG entry for 23 Oct.
18. BUG-907 | HAS-DRAFT | pilot-critical yes | branch origin/claude/b130-bug-907-obvert-warning (31 Oct, B-130) not merged; carpark says needs Tim's word after 9 Nov.
19. BUG-908 | HAS-DRAFT | pilot-critical no | draft PR #1982 (B-150) per the carpark Note covers only the X-Civil level range; the council and pump values still need Tim's numbers.
20. BUG-909 | NEEDS-TIM | pilot-critical no | question: should CEMEMBER keep the height of raised picks or refuse them, and should the section square follow the UCS?
21. BUG-910 | NEEDS-TIM | pilot-critical no | question: on a layout sheet should LBUH, LBH and CEMEMBER break marks always be paper-sized (carpark says needs Tim's word; nothing built).
22. BUG-911 | HAS-DRAFT | pilot-critical no | branch origin/claude/tl2-r501-bug911-label-units (23 Oct) is in neither release line; no PR number verified.
23. BUG-912 | HAS-DRAFT | pilot-critical no | branch origin/claude/tl2-r501-bug912-cemember-default-scale (23 Oct, "CEMEMBER uses the office default scale when DIMSCALE is 0") is in neither line.
24. BUG-913 | HAS-DRAFT | pilot-critical yes | PR #1534 (on HOLD, tip 7410fd93 is not in the Civil line); the "Not loaded" starting text is still in CeVersionWindow.xaml.
25. BUG-914 | HAS-DRAFT | pilot-critical yes | PR #1534 (on HOLD); "Then run the CE installer" is still in PluginManagerWindow.xaml.
26. BUG-915 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); CheckIgnoreCommand.cs still prints 40 rows but offers every number; switch OFF.
27. BUG-916 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); both contradictory refusal lines are still in IgnoredChecks.cs lines 90 and 93.
28. BUG-917 | ALREADY-FIXED | pilot-critical no | PR #1665 merged at 24b09bd9 (commit 4d4b9b9c names update stage names); not seen in AutoCAD.
29. BUG-918 | ALREADY-FIXED | pilot-critical no | PR #1672 merged at 8b3a1e09 (the unwired "will finish when every AutoCAD window is closed" promise replaced by an administrator step).
30. BUG-919 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "CONFLICT — n copies" is still in CeVersionReport.cs line 97.
31. BUG-920 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the switched-off message still has no tab name in CheckIgnoreCommand.cs.
32. BUG-921 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "no CE project record yet" is still in CheckIgnoreCommand.cs line 49.
33. BUG-922 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the "could not check" wording is unchanged in ChecksResult.cs.
34. BUG-923 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Rule value provenance" is still in RulebookEngine.cs line 76.
35. BUG-924 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "no minimum ... in the rulebook" wording is still in RulebookEngine.cs.
36. BUG-925 | FIXABLE-NOW | pilot-critical no | only branch cx2/bug-925-source-values (records blocked gates, no code change); Expected is clear (values in words, no handles).
37. BUG-926 | HAS-DRAFT | pilot-critical no | PR #1534 partly (on HOLD); "Unknown" still in LinkCommands.ReadOnlyAudit.cs and the Settings window.
38. BUG-927 | ALREADY-FIXED | pilot-critical no | PR #1633 merged at 0ea77f4b (CDTAG's two messages in plain words).
39. BUG-928 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the "Tim decides when to hide it" tooltip is still in AdvancedSettingsDialog.xaml and CivilSettingsView.xaml.
40. BUG-929 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Nothing draws this row today" is still in both Settings files.
41. BUG-930 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); the eight Fixes-tab tooltips were not re-read one by one here.
42. BUG-931 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "start-up heartbeat (install ID ..." is still at AdvancedSettingsDialog.xaml line 1174.
43. BUG-932 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Furthest a label may move out" has no model-millimetre note yet; switch OFF.
44. BUG-933 | ALREADY-FIXED | pilot-critical no | PR #1526 tip 3cb4c807 is merged in the Civil line; I saw the Double-click and slow-check progress rows in the Settings window, but did not confirm all four ticks.
45. BUG-934 | NEEDS-TIM | pilot-critical no | question: which one name for the window (Settings or Preferences); ribbon JSON still says "Preferences", the Edit Pipe window is protected; partly changed by commit 4d4b9b9c.
46. BUG-935 | NEEDS-TIM | pilot-critical no | question: approve "Drawing Standards (CDMANAGER)" and "CE Suite Manager" as the two names; carpark says naming is Tim's call (wording drafted in #1534, on HOLD).
47. BUG-936 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "network topology" is still in the Civil command-registry.json.
48. BUG-937 | HAS-DRAFT | pilot-critical no | the "Repair Centre" label is fixed (24b09bd9) but the tooltip still reads "sync, rebuild, upgrade and diagnostics"; tooltip is in PR #1534 (on HOLD).
49. BUG-938 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "upload queued telemetry" is still in the Manager command-registry.json.
50. BUG-939 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); Help still lists "Pipes &" tabs at guide-content.js line 95.
51. BUG-940 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); Help line about who can switch Checks on is unchanged at guide-content.js line 58.
52. BUG-941 | HAS-DRAFT | pilot-critical no | PR #1534 (on HOLD); "Use single pipe entity" is still in CdDialog.xaml line 469.
53. BUG-942 | UNCLEAR | pilot-critical no | commit 4d4b9b9c names BUG-942 (PR #1665) but the Inspector and Edit Pit files still hold old text; missing: a read of the Inspector rows in a build to see which words remain.
54. BUG-943 | ALREADY-FIXED | pilot-critical no | commits 4d4b9b9c and 24b09bd9 (PR #1665, Repair Centre steps and labels).
55. BUG-944 | ALREADY-FIXED | pilot-critical no | PR #1634 merged at 9354d130 (five command-line messages in plain words).
56. BUG-945 | ALREADY-FIXED | pilot-critical no | PR #1637 merged at 584fd168 (CDAUDIT and Recover Inverts messages).
57. BUG-946 | ALREADY-FIXED | pilot-critical no | commit fc12426c (CEHEALTH warns when a tool is installed but not loaded), merged via 5fc37df6.
58. BUG-947 | ALREADY-FIXED | pilot-critical no | commit 1899db50 (a damaged prepared copy is set aside and a fresh verified copy prepared).
59. BUG-948 | ALREADY-FIXED | pilot-critical no | commit 6db38faf (Updates and Rollback opens the Manager Updates page for a colleague).
60. BUG-949 | NEEDS-TIM | pilot-critical no | question: should LBH keep its stated 50 at 1:100 (and LBUH keep paper density); nothing built.
61. BUG-950 | NEEDS-TIM | pilot-critical yes | the interim fix is merged on the Structural line (b86a2f01, shows unknown when brace types differ); the kN rating per bracing type still needs Tim's numbers.

## What I could not verify

1. **Pull request states:** `gh` is not installed on this PC, so every PR number comes from the carpark notes or from merge commits. Where I wrote "branch ... no PR number verified", the branch exists but I could not see whether a PR is open.
2. **PR #1534 contents:** I read only its branch tip title (BUG-913 to 916); the rest of its coverage is taken from the carpark lines and from the old wording still being in the Civil line.
3. **AutoCAD:** nothing here was run, built or tested by me. Every ALREADY-FIXED line means merged only.
4. **Count basis:** the file has grown since the brief was written (now 1218 headings), so the list ends at BUG-950 by id, not by a count of 900.
