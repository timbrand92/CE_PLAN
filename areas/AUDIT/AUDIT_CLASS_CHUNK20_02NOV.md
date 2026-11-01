# Carpark audit, chunk 20 of 21: BUG-1191 to BUG-1251 (Mon 2 Nov 2026, Melbourne)

Read-only audit by Sonnet (Team). Nothing was changed except this file.

## FOR TIM

1. **Counts (60 entries):** HAS-DRAFT 35, FIXABLE-NOW 9, NEEDS-TIM 5, UNCLEAR 9, ALREADY-FIXED 2. (BUG-1221 has no heading, so the range holds 60 entries.)
2. **Of the 35 with a draft:** 14 are already merged into the 2 Nov release line (rel-20261102a), though their pull requests still show as open drafts. The other 21 are drafts not yet in the release line. The 2 ALREADY-FIXED are also in that line.
3. **Five most pilot-critical FIXABLE-NOW:** (a) BUG-1205 a second AutoCAD is logged as a crash of the first; (b) BUG-1208 the second AutoCAD erases another window's saved position; (c) BUG-1197 updating one pit schedule changes another schedule's depth heading; (d) BUG-1231 the pit-explode message floods the command line with repeated lines; (e) BUG-1212 water tank pictures and first window missing on AutoCAD 2022-2024. Only (a) and (b) touch what a colleague would see in daily use. The other three are lower, so there are fewer than five truly critical ones.
4. **Questions that only you can answer in this range:** BUG-1236 (should FO get its own symbol), BUG-1242 (show the number on source tags, Monday question 44), BUG-1233 and BUG-1230 (the grade-row design, on hold for the whole-functionality review), BUG-1209 (older AutoCAD pit link method).
5. **Problem found:** the live file `C:\CE_PLAN\BUG_CARPARK.md` is damaged. It now holds 5 lines, the same BUG-791 note pasted three times. Commits 20e999d3 and 5cd059e9 overwrote it. The last good copy is commit b498a968 (17,974 lines). I read that copy and did not touch the live file. Someone should restore it before anyone else edits it.
6. **Not proven:** nothing here was run or opened in AutoCAD. "Merged into the release line" means the code is there. It does not mean it works, and it does not mean it is installed.

## What I read and what I could not verify

1. **Read:** every entry BUG-1191 to BUG-1251 from the b498a968 copy of the carpark (Symptom, Expected, Status, Notes), the git log of origin/claude/rel-20261102a, all open pull requests (gh), and QUESTIONS_FOR_MONDAY.md items 15, 43 and 44.
2. **Could not verify:** which build is installed in Tim's AutoCAD now. I did not read the bundle DLL, so no entry is classed INSTALLED-WAITING-PROOF.
3. **Could not verify:** whether any status in the live carpark moved after b498a968. The live file is damaged.
4. **Could not verify:** the Structural line (rel-20261026s). I searched only the Civil/Manager log by id. The Structural fixes (1199, 1200, 1203, 1204, 1219, 1224) were checked only through the open pull request list.
5. **Not searched:** REGRESSION_LOG.md. The ledger.json has no entry for these ids.
6. **Used by name:** a pull request still open as a draft but merged into the release line is classed HAS-DRAFT, with "in rel line" and the merge commit. Only two entries are classed ALREADY-FIXED, because the carpark says Tim or the robot accepted them.

## The 60 entries

1. BUG-1191 | HAS-DRAFT | pilot-critical no | Draft PR #1809 "show every survey finding before approval"; not in the release line.
2. BUG-1192 | HAS-DRAFT | pilot-critical yes | Draft PR #1864, in rel line (merge c748ebb3); warns when survey levels more than 1.20 m off the covers are dropped.
3. BUG-1193 | HAS-DRAFT | pilot-critical no | Draft PR #1938 follows the curve of a property boundary; not in the release line.
4. BUG-1194 | HAS-DRAFT | pilot-critical yes | Draft PR #1757, in rel line (merge bca7dcbd); CDTEXTSEG uses the leg you clicked.
5. BUG-1195 | HAS-DRAFT | pilot-critical no | Draft PR #1888 (B-072), turned UCS label angle; not in the release line.
6. BUG-1196 | HAS-DRAFT | pilot-critical yes | Draft PR #1760, in rel line (merge b99d0197); a wrong depth in the pit schedule is a wrong answer.
7. BUG-1197 | FIXABLE-NOW | pilot-critical no | No PR or commit found; Expected is exact (private heading per schedule, do not rewrite a shared definition).
8. BUG-1198 | HAS-DRAFT | pilot-critical no | Draft PR #1764, in rel line (merge 54f621e8); export no longer saves into the drawing.
9. BUG-1199 | HAS-DRAFT | pilot-critical no | Draft PR #1894 (Structural); not in the Civil release line.
10. BUG-1200 | HAS-DRAFT | pilot-critical no | Draft PR #1906 (B-084, also names BUG-1185); Structural.
11. BUG-1201 | HAS-DRAFT | pilot-critical no | Draft PR #1813 delays the CDSL block import.
12. BUG-1202 | HAS-DRAFT | pilot-critical no | Draft PR #1776, in rel line (merge 49b3f348); weekly export off the start-up thread.
13. BUG-1203 | HAS-DRAFT | pilot-critical no | Draft PR #1915 (B-092), Structural background refresh switch.
14. BUG-1204 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078, with 1139 and 1162), Structural link conversion.
15. BUG-1205 | FIXABLE-NOW | pilot-critical yes | No PR; Expected is exact (one record per session, crash only if the owner process is gone); touches a shared file, so Manager must be synced by hand.
16. BUG-1206 | HAS-DRAFT | pilot-critical no | Draft PR #1750, in rel line (merge a9a18a8f); CE Tools tab appears at start-up.
17. BUG-1207 | UNCLEAR | pilot-critical no | Fix kind is "probe first": nobody has shown that two sessions really overwrite log lines; a probe is missing.
18. BUG-1208 | FIXABLE-NOW | pilot-critical yes | No PR; Expected is exact (lock, re-read, change one entry, atomic replace).
19. BUG-1209 | NEEDS-TIM | pilot-critical no | Which way to link a downpipe to a pit on AutoCAD 2022-2024 is a design choice, and the entry says "protected change, route to owner".
20. BUG-1210 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (make the existing plan controls and clicks work on the older lane); a large port job.
21. BUG-1211 | HAS-DRAFT | pilot-critical no | Draft PR #1957 (B-129), CDMENU checks the menu is really loaded.
22. BUG-1212 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (port the two tank windows to the older lane); a large port job.
23. BUG-1213 | FIXABLE-NOW | pilot-critical no | No PR; Expected is exact (keep Source on every lane, read-only fallback with the retained text).
24. BUG-1214 | HAS-DRAFT | pilot-critical no | Draft PR #1959 (B-129), the picker offers images only on the older lane.
25. BUG-1215 | HAS-DRAFT | pilot-critical no | Draft PR #1768, in rel line (merge 784640d5); Help now names Send report.
26. BUG-1216 | HAS-DRAFT | pilot-critical no | Draft PR #1812; Help follows Rainfall and newer commands.
27. BUG-1217 | FIXABLE-NOW | pilot-critical no | No PR; help-text only, Expected names the exact tab names and the read-only wording.
28. BUG-1218 | HAS-DRAFT | pilot-critical no | Draft PR #1896 (B-074, with 1220), new Help pages.
29. BUG-1219 | HAS-DRAFT | pilot-critical no | Draft PR #1916 (B-092), Beam and Rafter/Joist Help says they open Settings.
30. BUG-1220 | HAS-DRAFT | pilot-critical no | Draft PR #1896 (B-074, with 1218), Reverse Flow wording.
31. BUG-1222 | ALREADY-FIXED | pilot-critical yes | PR #1832, commit 76171d1e in rel line; carpark Status says FIXED (Claude-accepted, Civil 3.0.85, 29 Oct) and Tim confirmed by hand.
32. BUG-1223 | HAS-DRAFT | pilot-critical no | Draft PR #1833, in rel line (merge 905dd2ba); the false "changed while you picked" is removed.
33. BUG-1224 | HAS-DRAFT | pilot-critical no | Draft PR #1918 (B-100), leaves lock, freeze and on/off alone; Tim's answer is Monday question 70 (the PR uses the recommended default).
34. BUG-1225 | ALREADY-FIXED | pilot-critical yes | PR #1830, commit 431c27c2 in rel line; carpark Status says Tim confirmed DP placed twice on 29 Oct (Civil 3.0.85).
35. BUG-1226 | HAS-DRAFT | pilot-critical no | Draft PR #1839 (B-006), in rel line (merge de05fa64); Recent invert buttons restored.
36. BUG-1227 | HAS-DRAFT | pilot-critical no | Draft PR #1867 (B-049a), Part A only, in rel line (merge 3c75396c); I could not see this entry's Symptom, so whether Part B remains is unknown.
37. BUG-1228 | HAS-DRAFT | pilot-critical yes | Draft PR #1837, in rel line (merge dced33cf); DP took about 30 seconds to place.
38. BUG-1229 | HAS-DRAFT | pilot-critical yes | Draft PR #1838 (B-005), in rel line (merge 679bf190); level never flatter than the grade chosen.
39. BUG-1230 | NEEDS-TIM | pilot-critical no | On hold for the whole-functionality review (Tim 29 Oct); what the preview should show is part of that review.
40. BUG-1231 | FIXABLE-NOW | pilot-critical no | No PR; Expected is one short line per cause and the useful sentence first.
41. BUG-1232 | UNCLEAR | pilot-critical no | Suspected only; not reproduced by hand, may be a robot test-drawing effect.
42. BUG-1233 | NEEDS-TIM | pilot-critical yes | The window must not switch Standard to "Set my own"; the fix depends on the grade row versus "I know one end" design (PC-02, PC-03), which is unsettled.
43. BUG-1234 | UNCLEAR | pilot-critical no | Tim's screenshot is not in the repo and the entry gives no clearances to aim for.
44. BUG-1235 | HAS-DRAFT | pilot-critical no | Draft PR #1967 (B-119); the warning never prints the same figure twice.
45. BUG-1236 | NEEDS-TIM | pilot-critical no | Card D08 says OF and FO share one symbol, Tim expected FO; Monday question 43 (recommended: FO gets its own symbol).
46. BUG-1237 | HAS-DRAFT | pilot-critical no | Draft PR #1889 (B-067); CDRENUMBER says what to draw.
47. BUG-1238 | HAS-DRAFT | pilot-critical no | Draft PR #1861 (B-043a), in rel line (commit 70dec2c2); one "Recent:" line on New Pipe / Edit Pipe.
48. BUG-1239 | UNCLEAR | pilot-critical no | Not yet known when the 450 units sideways shift happens (grade text off, or normal "Above" gap); needs one clarifying look.
49. BUG-1240 | HAS-DRAFT | pilot-critical no | Draft PR #1880 (B-059); Inspector reads the saved record after Save As.
50. BUG-1241 | UNCLEAR | pilot-critical no | A question from Tim, not a proven fault; the carpark says so.
51. BUG-1242 | NEEDS-TIM | pilot-critical no | Monday question 44 (show the number on every source tag, default on) has no recorded answer in what I read.
52. BUG-1243 | UNCLEAR | pilot-critical no | Tim's description of what CE Blocks should do is missing.
53. BUG-1244 | HAS-DRAFT | pilot-critical no | Draft PR #1936 (B-116); Refresh prints one plain line.
54. BUG-1245 | UNCLEAR | pilot-critical no | Which two objects Tim selected is not known, so whether it is a real refusal or a wording problem is unknown.
55. BUG-1246 | HAS-DRAFT | pilot-critical no | Draft PR #1891 (B-071); the copied downpipe gets its own next tag.
56. BUG-1247 | HAS-DRAFT | pilot-critical no | Draft PR #1876 (B-058); Updates & Rollback opens the drafter's own Updates screen.
57. BUG-1248 | FIXABLE-NOW | pilot-critical no | No PR; Expected gives the plain wording and says to move the technical detail behind a Details fold.
58. BUG-1249 | UNCLEAR | pilot-critical no | Which row Tim meant is not known (the carpark says so).
59. BUG-1250 | UNCLEAR | pilot-critical no | Seen once in one run, switch-off case not checked; evidence only.
60. BUG-1251 | HAS-DRAFT | pilot-critical yes | Draft PR #1866 (B-055), in rel line (merge cf71af0d); CDCHECK showed 44 false "Unresolved" instead of 4 after a reopen.

## Counts by class

1. **HAS-DRAFT:** 35.
2. **FIXABLE-NOW:** 9 (1197, 1205, 1208, 1210, 1212, 1213, 1217, 1231, 1248).
3. **NEEDS-TIM:** 5 (1209, 1230, 1233, 1236, 1242).
4. **UNCLEAR:** 9 (1207, 1232, 1234, 1239, 1241, 1243, 1245, 1249, 1250).
5. **ALREADY-FIXED:** 2 (1222, 1225).
6. **Not used:** DUPLICATE, INSTALLED-WAITING-PROOF, CLOSED-OR-WONT-FIX.
