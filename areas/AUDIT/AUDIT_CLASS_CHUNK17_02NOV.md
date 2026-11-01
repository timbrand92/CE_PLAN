# Carpark audit, chunk 17 of 21 (BUG-1011 to BUG-1070)

Written by Sonnet (Team), read-only, Mon 2 Nov 2026 (Melbourne). Nothing was changed except this file.

## FOR TIM

1. **Counts (60 entries):** 32 INSTALLED-WAITING-PROOF, 12 FIXABLE-NOW, 11 HAS-DRAFT, 5 NEEDS-TIM. No duplicates, none already proven, none closed or won't-fix, none unclear.
2. **Big finding:** 32 of the 60 are already fixed in code and installed on your PC (Civil 3.0.88, Manager 1.1.88, Structural 1.0.125). The carpark still says OPEN for them. None has a robot PASS plus Codex PASS recorded, so none can move to FIXED yet. They need a proof run, not more building.
3. **Most pilot-critical FIXABLE-NOW, 1 of 5:** BUG-1052. CDAGI and CDPERIMETER say a flat drain meets the minimum grade in a metre drawing (10 m run, 1 mm fall reads 1:10).
4. **2 of 5:** BUG-1053. LandXML pit levels in millimetres are stored as metres (100200 instead of 100.200).
5. **3 to 5 of 5:** BUG-1064 (a second installer running at once can put the old Civil back after a good install), BUG-1065 (a failed first install can leave the loading file behind) and BUG-1042 (New Pit refuses to go on when the cover level is blank).
6. **Questions only you can answer (5):** BUG-1020 (which pit depth wins when floor and pipes disagree), BUG-1023 (drop the 90 per cent saved-order rule), BUG-1029 (a menu entry per tool on AutoCAD 2022 to 2024), BUG-1034 (is invert text sitting on its own pipe line acceptable), BUG-1060 (which stormwater standard edition new jobs show).

## HOW THIS WAS DONE

1. **Range:** I went by heading ids, BUG-1011 to BUG-1070, which is 60 entries. Counting the "## BUG-" headings from the top of the file, BUG-1011 is heading number 962, not 961 (BUG-1010 is 961). If heading 961 (BUG-1010) belongs in this chunk, it was not classified here.
2. **Read:** every entry's Symptom, Expected, Reference, Test and last Status line in `C:\CE_PLAN\BUG_CARPARK.md`.
3. **History checked:** `git log` subjects on `origin/claude/rel-20261102a` (4,989 commits, tip 3fbb9da5, Civil 3.0.88) and `origin/claude/rel-20261026s` (tip 204dfad2, Structural 1.0.125). Unmerged branches named for a bug number were checked against both lines with a merge-ancestor test.
4. **Installed:** I read the version string of the installed DLLs. Civil and Manager read 3.0.88+3fbb9da5. Structural reads 1.0.125+204dfad2. Both equal the branch tips, so anything merged into those lines counts as installed.
5. **Code spot-checks on the Civil tip:** BUG-1042, 1043, 1045, 1046, 1050, 1052, 1053, 1054, 1060 and 1033 are still in the old state there.

## WHAT I COULD NOT VERIFY

1. **Pull requests:** the `gh` command is not available in this session's tools. I could not list PRs or read their state. For HAS-DRAFT entries I name the branch and commit, not a PR number, and I do not know whether a PR is open. PR numbers quoted for fixed entries come from merge commit subjects.
2. **No AutoCAD proof:** I opened nothing in AutoCAD and ran no tests and no robot. The ledger `ledger.json` holds no BUG ids and no F-ids from this range, so no robot result is tied to any of these entries.
3. **Switches:** several fixes sit behind switches (BUG-1031, 1037, 1039, 1045, 1047, 1051 and others). I confirmed the default is ON from the commit subject only for BUG-1031, 1037, 1039 and 1051. For the rest, I did not read the default.
4. **BUG-1043:** the commit I saw only changes the wording of the blank-end line. The Civil tip still has a "Blocked" line at `PipeStartReadiness.cs:188`. I took the merged PR #1735 as the fix, but it is worth a quick look when proof is run.
5. **BUG-1026 and BUG-1027:** the carpark says "fix drafted in #1535, not installed". That is stale. #1535 is merged into the Civil line and installed. I did not read the support-zip contents to confirm every file listed in BUG-1027 is now included.
6. **Pilot-critical** is my judgement: a wrong engineering result, silently lost data, or an install that can go wrong for a colleague. Tim has not set this.

## CLASSIFICATION

1. BUG-1011 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixed by 27b35e16 and 8690ce14 (Civil line), installed 3.0.88; typed depth now reaches the pit levels; no robot or Codex PASS recorded.
2. BUG-1012 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1578 (409feaf5) merged in the Civil line, installed; the closing side of a boundary is now read; no proof run.
3. BUG-1013 | HAS-DRAFT | pilot-critical no | Branch claude/tl2-r501-bug1013-manifest-stale (commit b1ea7a87) is not merged into either line; PR number not checked.
4. BUG-1014 | INSTALLED-WAITING-PROOF | pilot-critical no | c5990580 is in the Structural line (installed 1.0.125); schedule box now turns with the UCS; no proof run.
5. BUG-1015 | INSTALLED-WAITING-PROOF | pilot-critical no | 5a8feaec is in the Structural line, installed; a refused RIB or REB puts the line back; no proof run.
6. BUG-1016 | INSTALLED-WAITING-PROOF | pilot-critical no | 555bd7ef is in the Structural line, installed; saving templates keeps the waiting suggestions file; no proof run.
7. BUG-1017 | INSTALLED-WAITING-PROOF | pilot-critical yes | f514c8ef is in the Civil line, installed; Manager buttons and CE Blocks tiles now cancel a running command first; no proof run.
8. BUG-1018 | FIXABLE-NOW | pilot-critical no | Entry gives the fix (do not cache a "not loaded" answer) and a test; no commit found; only reachable where the pipe-object hold is off, so not a colleague issue.
9. BUG-1019 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1689 (324bec7c) merged in the Civil line, installed; CDCALC now treats levels at or below RL 0.00 as real; no proof run.
10. BUG-1020 | NEEDS-TIM | pilot-critical yes | Which pit depth wins when the recorded floor and the connected pipe inverts disagree (the entry says this is Tim's call).
11. BUG-1021 | HAS-DRAFT | pilot-critical yes | Branch b03/bug-1021-twl-lid-no-floor (commit 7884b0cf, one commit not in the Civil line) is unmerged; PR number not checked.
12. BUG-1022 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1629 (01c299c8) merged in the Civil line, installed; a re-found pit keeps its schedule override and row order; no proof run.
13. BUG-1023 | NEEDS-TIM | pilot-critical no | Drop the 90 per cent saved-order rule? It reopens the BUG-008 symptom unless BUG-008 is re-tested (entry says Tim decides).
14. BUG-1024 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1597 (10ed4f53) merged in the Civil line, installed; CDSPINEUPGRADE no longer says "Nothing to write" wrongly; no proof run.
15. BUG-1025 | HAS-DRAFT | pilot-critical yes | Branch claude/tl2-r501-bug1025-reobar-layout-units (commit b8026c89) is not merged into the Structural line; PR number not checked; bar length reads 100000 instead of 100 on a schedule.
16. BUG-1026 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1535 is merged into the Civil line (b121d90c, follow-up c9585bc8), installed; carpark status "not installed" is stale; no proof run.
17. BUG-1027 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1535, merged and installed; support-zip contents not re-read here; no proof run.
18. BUG-1028 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1694 (fb3cfe3d, c9585bc8) merged in the Civil line, installed; ribbon-build and switch-file failures now leave a log line; no proof run.
19. BUG-1029 | NEEDS-TIM | pilot-critical no | Does Tim want a CE menu entry per tool (Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate, Copy + Rotate) on AutoCAD 2022 to 2024?
20. BUG-1030 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1636 (612938af) merged in the Civil line, installed; closing CDCALC unchanged writes no undo step; no proof run.
21. BUG-1031 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1865 (c9ec8c3b) merged in the Civil line, installed; Delete cell is back on the right-click menu (switch ON); no proof run.
22. BUG-1032 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1635 (a5751512) merged in the Civil line, installed; pick list names the pipe by its pits and says ABOVE for a level over the lid; no proof run.
23. BUG-1033 | FIXABLE-NOW | pilot-critical no | Entry says copy the WSUD "Read-only" banner to the Pump System tab; only the tab tooltip has it today (CalculationsV2Dialog.xaml:780); no commit found.
24. BUG-1034 | NEEDS-TIM | pilot-critical no | Is IL text sitting on its own pipe line the intended "in from the pipe end" spot? Same root as BUG-1253, fix together.
25. BUG-1035 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1722 (db50498a) merged in the Civil line, installed; Shallow pit depth box added to Settings; no proof run.
26. BUG-1036 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1728 (115eeaf0) merged in the Civil line, installed; Pipe Flows roughness note follows the Settings value; no proof run.
27. BUG-1037 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1729 (0d215deb) is in the Structural line, installed; column bars drawn at real diameter (switch ON); no proof run.
28. BUG-1038 | HAS-DRAFT | pilot-critical yes | Branch fb/b5-bug1038-typed-bar-count (commits 115a5c19, 2878e6c2; PR #1731 named in the commit) is not merged into the Structural line; 14N20 still cannot be typed.
29. BUG-1039 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1732 (91530aef) is in the Structural line, installed; timber quantity of 10 or more accepted (switch ON); no proof run.
30. BUG-1040 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1734 (eb3a2889) merged in the Civil line, installed; a kept flat pipe warns and the cascade carries on; no proof run.
31. BUG-1041 | HAS-DRAFT | pilot-critical yes | Branch fb/b6-bug1041-sheets-sync-scoped (commit 4ae66b1b) is not merged into the Structural line; PR number not checked.
32. BUG-1042 | FIXABLE-NOW | pilot-critical yes | Civil tip still returns Blocked("Enter the cover level.") at PitStartReadiness.cs:125; entry spells out the fix (warn, keep cover Unknown) and a test; sibling BUG-1043 shows the pattern.
33. BUG-1043 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1735 (46376980) merged in the Civil line, installed; the Civil tip still has a Blocked line at PipeStartReadiness.cs:188, so look at it when proof is run.
34. BUG-1044 | HAS-DRAFT | pilot-critical no | Branch cx6/bug-1044-bd30 (commits efaeff4c, 69643351, d38ca6ed, 4 not in the Civil line) is unmerged; PR number not checked.
35. BUG-1045 | FIXABLE-NOW | pilot-critical no | Structural half fixed (57c1b060, installed); the Civil half (CDDIAG, CDDASHBOARD, CDPARTS) still says "drawing is read-only" at DrawingSafetyService.cs:72.
36. BUG-1046 | FIXABLE-NOW | pilot-critical no | Civil tip still refuses in Paper Space at DrawingSafetyService.cs:117; entry gives the fix and a paper-space test; no commit found.
37. BUG-1047 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1738 (c5774cf2, 81d1772c) merged in the Civil line, installed; a frozen layer now warns "will be hidden" and places; switch default not read here.
38. BUG-1048 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1746 (518741ee) is in the Structural line, installed; hatch change now splits the selection; no proof run.
39. BUG-1049 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1743 (2a85890d) merged in the Civil line, installed; a blank ticked field no longer blocks the batch; no proof run.
40. BUG-1050 | FIXABLE-NOW | pilot-critical no | Entry says allow deleting the last custom label style and fall back to built-in wording; LabelStyleDialogViewModel.cs still gates the button; no commit found.
41. BUG-1051 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #1753 (bb34aaee) merged in the Civil line, installed; slab fall worked in physical units (switch surface.slabFallUsesDrawingUnits ON); no proof run.
42. BUG-1052 | FIXABLE-NOW | pilot-critical yes | AgiCommand.cs:268 still names drawing units "runLengthMm" and uses them as mm; entry gives the fix and a 1:10000 test; no commit found.
43. BUG-1053 | FIXABLE-NOW | pilot-critical yes | LandXmlParser.cs reads elevRim with no unit conversion; entry spells out the rule (convert to metres, else Unknown) and a test; no commit found; no duplicate.
44. BUG-1054 | FIXABLE-NOW | pilot-critical no | AgiCommand.Plan.cs:77 still compares a 1 mm tolerance with raw drawing units; entry gives the fix and a four-pick test; metre drawings only.
45. BUG-1055 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1759 (8044f6ae) is the tip of its branch and merged in the Civil line, installed; message-only fix; no proof run.
46. BUG-1056 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1056-habitable-floor-freeboard (commit adc9dbb8) is unmerged; entry also needs Tim's word on which floor evidence CE may use.
47. BUG-1057 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1057-council-speed-bands (5 commits, tip 9fa33113) is unmerged; entry also needs Tim's word on the bands.
48. BUG-1058 | HAS-DRAFT | pilot-critical no | Branch claude/b132-bug-1058-darebin-pit-spacing (commit 4c845162) is unmerged; entry also needs Tim's word.
49. BUG-1059 | HAS-DRAFT | pilot-critical yes | Branch claude/b132-bug-1059-maroondah-dn150-grade (commit 9c246a1c) is unmerged; entry also needs Tim's word.
50. BUG-1060 | NEEDS-TIM | pilot-critical no | Which AS/NZS 3500.3 edition new jobs should show, and how it applies; default is still "2021" in UserSettings.cs:2750.
51. BUG-1061 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1762 (f5cd0214) is in the Structural line, installed; RCBEAM warning and preview now match the drawing; no proof run.
52. BUG-1062 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1762 (f5cd0214), installed; no-room warning stays on at zero width; no proof run.
53. BUG-1063 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1762 (f5cd0214), installed; bar spacing no longer overstated by one bar diameter; no proof run.
54. BUG-1064 | FIXABLE-NOW | pilot-critical yes | Entry gives the fix (one machine-wide install lock) and a disposable-folder test; no lock or mutex found in the installer on the Civil tip; Opus lane (protected installer).
55. BUG-1065 | FIXABLE-NOW | pilot-critical yes | Entry gives the fix (retire the live bundle, say so plainly if clean-up fails) and a test; no commit found; Opus lane.
56. BUG-1066 | FIXABLE-NOW | pilot-critical no | Entry gives the fix (keep the backup path in the failure record) and a test; no commit found; Opus lane.
57. BUG-1067 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1719 (b6d3d692) merged in the Civil line; tests-only fix, so there is nothing to see in AutoCAD; no proof run.
58. BUG-1068 | INSTALLED-WAITING-PROOF | pilot-critical no | Same PR #1719 (b6d3d692); tests-only fix; no proof run.
59. BUG-1069 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1766 (d5f3c84d) is in the Structural line, installed; tests-only fix; no proof run.
60. BUG-1070 | HAS-DRAFT | pilot-critical yes | Branch claude/b118-bug1070-undo-hold (commit 6845a095) is unmerged; PR number not checked; CE data can silently stop saving after an Undo.
