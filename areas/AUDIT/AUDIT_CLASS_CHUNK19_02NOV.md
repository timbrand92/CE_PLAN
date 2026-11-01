# Carpark audit chunk 19 of 21 — BUG-1131 to BUG-1190 (60 entries)

Written by Sonnet (Team, read-only) on Mon 2 Nov 2026, Melbourne time, for CE 05 / CE 00.

## FOR TIM

1. **Carpark file is damaged (urgent, not part of this audit).** `C:\CE_PLAN\BUG_CARPARK.md` is now about 1 KB and holds only one repeated note. Its last two commits (20e999d3 and 5cd059e9, both 2 Nov 05:53) cut it from 2.1 MB. The last good copy is commit b498a968 (1 Nov 22:10). I did not touch it. I read entries from that good copy through git.
2. **Counts for the 60 entries:** 16 INSTALLED-WAITING-PROOF, 32 HAS-DRAFT, 7 FIXABLE-NOW, 3 UNCLEAR, 1 NEEDS-TIM, 1 DUPLICATE. None are ALREADY-FIXED, CLOSED-OR-WONT-FIX or other duplicates.
3. **Installed copy:** the Civil bundle on this PC reads 3.0.88 (build 3fbb9da5). That is the tip of the Civil line, so all 16 merged fixes are installed. None has been proven in AutoCAD, so none counts as fixed.
4. **FIXABLE-NOW, pilot-critical (only three of the seven):** BUG-1166 (Civil and Manager look for the office folders in different places), BUG-1173 (colleague pack backup lists too few folders; a document edit), BUG-1175 (leftover wording and file paths pointing at Tim's own folders).
5. **Other FIXABLE-NOW, not pilot-critical:** BUG-1148, BUG-1154, BUG-1160, BUG-1163.
6. **Needs a person, not code, before 9 Nov:** BUG-1169 (Max's Structural version), BUG-1170 (Max's Manager version) and BUG-1176 (how the package is delivered: USB or synced folder, not a downloaded zip).

---

## Entries

1. BUG-1131 | HAS-DRAFT | pilot-critical no | Draft PR #1902 (B-082) reads a length over 100 as millimetres; built and unit-tested only.
2. BUG-1132 | HAS-DRAFT | pilot-critical no | Draft PR #1932 (B-106) adds supplier names with a former-names map; 250UC73 (73.0 versus 250UC72.9) is held for Tim.
3. BUG-1133 | UNCLEAR | pilot-critical no | Entry itself says UNSURE whether any sheet puts the angle symbol anywhere but after the size; the fix has two options (replace with EA/UA, or warn) and no branch exists.
4. BUG-1134 | HAS-DRAFT | pilot-critical no | Draft PR #1914 (B-092), branch claude/s16-bug-1134; unit-tested only; the schedule is switched off by default.
5. BUG-1135 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1747 on the Civil line 31 Oct; installed in 3.0.88; the older-build round trip is not tried in AutoCAD.
6. BUG-1136 | HAS-DRAFT | pilot-critical no | Draft PR #1893 is on the Civil line only; it needs a twin on the Structural line (rel-20261026s) before it can ship there.
7. BUG-1137 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1778 31 Oct; the fault only hits AutoCAD 2022 to 2024 and Max is on 2026.
8. BUG-1138 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1748 31 Oct (CDUPGRADE follow-up in 8dfc0f52); older-AutoCAD lane only.
9. BUG-1139 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078): a copied beam starts with empty links; not opened in AutoCAD.
10. BUG-1140 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1763 31 Oct; a pasted downpipe no longer takes the original's label; copy and paste is everyday work.
11. BUG-1141 | HAS-DRAFT | pilot-critical no | Branch fb/bug-1141-unreadable-pit-record-link-cache (tip 9545489c, 30 Oct), not merged; I found no PR number (the gh tool is missing here).
12. BUG-1142 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1752 31 Oct; only triggers when a pit record is already damaged.
13. BUG-1143 | HAS-DRAFT | pilot-critical no | Branch cx4/bug-1143-design-draft-backup (26 Oct), not merged; no PR number found; it is older than the 31 Oct drafts and may need restating on the current line.
14. BUG-1144 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1144 (B-121, 31 Oct), not merged; no PR number found.
15. BUG-1145 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1765 31 Oct; a schedule Xref'd into a sheet no longer shows OUT OF DATE for unrelated changes, and Project QA stops failing for the same reason.
16. BUG-1146 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077, Structural line); footing-size memory per drawing.
17. BUG-1147 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077): newer footing data is kept; the beam-link data part is not mentioned in the note.
18. BUG-1148 | FIXABLE-NOW | pilot-critical no | Expected behaviour is stated exactly (a matching non-blank identity, copy only labels whose owner note names the source pit); no commit or branch found.
19. BUG-1149 | HAS-DRAFT | pilot-critical no | Branch fb/pc2-BUG-1149-bound-source-frozen (24 Oct), not merged; its tip line reads "a gone source no longer hides a changed or unloaded second source", so it may cover only part of the BIND case.
20. BUG-1150 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1758 31 Oct; a pasted CE network is no longer lost after reopening.
21. BUG-1151 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1777 31 Oct; the pit move names the pipe objects that could not follow; older-AutoCAD lane only.
22. BUG-1152 | HAS-DRAFT | pilot-critical no | Branch fb/bug1152-twin-upgrade-atomic (B-120, 31 Oct), not merged; no PR number found.
23. BUG-1153 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1153 (31 Oct), not merged, built on top of the BUG-1144 branch.
24. BUG-1154 | FIXABLE-NOW | pilot-critical no | The entry names the existing 255-character splitter to reuse; no commit or branch found.
25. BUG-1155 | HAS-DRAFT | pilot-critical no | Branch claude/b115-bug-1155-xref-recreated (B-115, 31 Oct), restated on the C-78 line, not merged.
26. BUG-1156 | HAS-DRAFT | pilot-critical no | Branch fb/bug1156-draft-keeps-unknown-fields (B-120, 31 Oct), not merged.
27. BUG-1157 | HAS-DRAFT | pilot-critical no | Branch claude/b119-bug-1157-level-write-not-saved (B-119, 31 Oct), not merged.
28. BUG-1158 | HAS-DRAFT | pilot-critical no | Branch claude/b121-n7-bug1158 (31 Oct) compares drawings with SameDatabase; not merged.
29. BUG-1159 | HAS-DRAFT | pilot-critical no | Draft PR #1898 (B-077): unreadable size entries are kept.
30. BUG-1160 | FIXABLE-NOW | pilot-critical no | The entry states what to store ("last written by" and "highest version ever written"); no commit or branch found; it builds on the merged BUG-1135 fix.
31. BUG-1161 | HAS-DRAFT | pilot-critical no | Branch claude/b124-n10-bug1161-moved-label-keeps-wording (B-124, 31 Oct), not merged.
32. BUG-1162 | HAS-DRAFT | pilot-critical no | Draft PR #1899 (B-078): a damaged point load list is refused.
33. BUG-1163 | FIXABLE-NOW | pilot-critical no | One-line expected behaviour (also write waiting records when a DXF export starts); no commit or branch found.
34. BUG-1164 | HAS-DRAFT | pilot-critical no | Branch claude/b119-bug-1164-comma-levels (B-119, 31 Oct), not merged.
35. BUG-1165 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1751 31 Oct; the code reads blocks from the running bundle first, but an administrator still has to check the all-users folders on Max's PC before 9 Nov.
36. BUG-1166 | FIXABLE-NOW | pilot-critical yes | Expected behaviour is one shared office-folder lookup used by Civil and Manager (Manager's order already exists); no commit found; looking at where Max's OneDrive puts the folder is a separate hand step.
37. BUG-1167 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1754 31 Oct; folders in a copied settings file follow the receiving PC; I did not read any settings file.
38. BUG-1168 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1775 31 Oct; the job-time folder is looked for again at each start; the OneDrive-synced hand step before Max's first start still stands.
39. BUG-1169 | UNCLEAR | pilot-critical yes | Missing: the version and date of Max's old July Structural bundle, and whether it carries its own CE_SHARED.dll; only someone at Max's PC can supply it.
40. BUG-1170 | UNCLEAR | pilot-critical yes | Missing: Max's current Manager version (is it older than 22 Jul?); only someone at Max's PC can supply it.
41. BUG-1171 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1860 (B-050) 31 Oct; Manager sends a short list of Civil failures and never deletes unsent files.
42. BUG-1172 | HAS-DRAFT | pilot-critical no | Branch claude/n2-b116-bug1172-net8-lane-label (B-116, 31 Oct), not merged.
43. BUG-1173 | FIXABLE-NOW | pilot-critical yes | A document-only fix (the pack's own notes say the code is correct): add three folders and a "MENULOAD, unload CE_SUITE_MANAGER_MENU" line to the colleague pack; the pack wording is not yet edited.
44. BUG-1174 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1174-cdwt-says-why-no-window (27 Oct), not merged; no PR number found.
45. BUG-1175 | FIXABLE-NOW | pilot-critical yes | The entry names the three places (CDSL message, CDHELP path, CDTRENCHGRATEAUDIT file path) and the fix; they point at Tim's own folders, which Max's PC will not have.
46. BUG-1176 | NEEDS-TIM | pilot-critical yes | Question: will the package reach Max by USB or the synced pilot folder (never a downloaded zip)? It is a delivery choice, not code.
47. BUG-1177 | DUPLICATE-OF-BUG-1202 | pilot-critical no | The carpark already says so (same weekly time export, PR #1776) and closed it on Tim's yes, decision 178, 31 Oct.
48. BUG-1178 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1178-shared-mismatch-colleague-words (26 Oct), not merged; no PR number found.
49. BUG-1179 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1769 31 Oct; a damaged approval file now says CE could not check, not "CE is current."
50. BUG-1180 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1774 31 Oct; the Drawing Repair banner fix.
51. BUG-1181 | HAS-DRAFT | pilot-critical no | Branch cx4/bug-1181-manager-off-next-start (26 Oct), not merged; no PR number found.
52. BUG-1182 | HAS-DRAFT | pilot-critical no | Branch cx5/bug-1182-view-history-own-module (26 Oct), not merged; no PR number found.
53. BUG-1183 | HAS-DRAFT | pilot-critical no | Branch claude/bug-1183-pier-schedule-row-identity-s1026 (30 Oct), not merged; no PR number found.
54. BUG-1184 | HAS-DRAFT | pilot-critical no | Draft PR #1895 (head d09b4935, Structural line): a new size gets the next free BR or SPR mark.
55. BUG-1185 | HAS-DRAFT | pilot-critical no | Draft PR #1906 (B-084): tagging adds only a label (switch TagBearersLabelOnly ON).
56. BUG-1186 | HAS-DRAFT | pilot-critical no | Draft PR #1912 (B-091): CSTAGBEARERS and CSSUBFLOORGRID refuse a locked layer and never unlock it.
57. BUG-1187 | HAS-DRAFT | pilot-critical no | Draft PR #1913 (B-091): a mistyped lineweight keeps the layer unchanged and says why.
58. BUG-1188 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merged as PR #1773 31 Oct; no more invented "AT 1 IN 100" on a LandXML pipe with no grade.
59. BUG-1189 | HAS-DRAFT | pilot-critical no | Branch fb/pc3-BUG-1189-moved-survey-xref (24 Oct), not merged; no PR number found.
60. BUG-1190 | INSTALLED-WAITING-PROOF | pilot-critical no | Merged as PR #1755 31 Oct; levels in a nested, turned survey block now land where the drawing shows them.

---

## What I could not verify

1. **Damaged carpark.** Today's `BUG_CARPARK.md` is cut down. I read the entries from commit b498a968 (1 Nov 22:10). If any note was added after that, I did not see it. Heading numbers also differ from the brief: BUG-1131 is the 1082nd heading in the good copy, not the 1081st, so I went by ids 1131 to 1190 as the brief says.
2. **No PR tool.** The `gh` command is not on this machine's path in either shell, so I could not list PRs. PR numbers come from the carpark notes and from merge commits on the Civil line. Where an entry says "branch ... no PR number found", the branch exists on origin and is not merged, but I could not confirm whether it has an open PR, was closed, or was superseded.
3. **Draft branches were not diffed.** I read each branch's last commit line, not its code. A draft branch dated 24 to 27 Oct (BUG-1143, 1149, 1174, 1178, 1181, 1182, 1189) may be older than the current line and may need restating.
4. **Installed state.** I read only the Civil product version (3.0.88, build 3fbb9da5, equal to the Civil line tip). I did not find a Structural bundle DLL version, so I made no installed claim for the Structural drafts. Nothing here was run, built, tested or opened in AutoCAD.
5. **Ledger.** I looked for these ids in `areas\runner-reports\ledger.json`; it lists cases by case code, not by BUG id, so it gave no per-entry result.
6. **Pilot-critical is my judgement** from the entry text (does Max meet it on AutoCAD 2026 from 9 Nov), not a ruling.
7. **Not changed:** I edited no other file, ran no git write, built nothing and read no settings file.
