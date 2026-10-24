# Train C-64 (Civil + Manager) PR list, Sat 24 Oct 2026, built about 14:00 to 14:30 Melbourne

Built and unit-tested only. Nothing here is installed or accepted. This list is the single source of truth for the C-64 assembler (`train_c64_assembler_job.txt` reads it at start). No PR closed, retargeted or merged by this job; no bug marked FIXED.

## ANSWER FIRST

1. **40 PRs are in the train** (the cap), ranked: Group 1 = 14 data-loss and wrong-answer fixes; Group 2 = 16 daily-tool, privacy and pilot-critical fixes; Group 3 = 4 import and long-section fixes; Group 4 = 6 PRs whose review said MERGE-WITH-FIXES (or MERGE with a later asks) and whose fix a builder then pushed, but nobody independently re-reviewed the fix commit itself (merged last, so the finalizer can take any back out with `git revert -m 1`).
2. **Base:** `origin/claude/rel-20261024m` tip `5467f7053a2e9275cb450409c142ef9aa26dad53` (read with `git ls-remote` at 14:28; version commit "Civil 3.0.73 / Manager 1.1.73 (C-63)" on the Opus-signed `31689290d9338e81832931fa0526229977915c9c`). All 40 PRs were fetched at their live head and trial-merged (`git merge-tree`) onto that tip: **every one clashes only in `REGRESSION_LOG.md`, except #1419, which also clashes in `UserSettings.cs` (two neighbouring additions: keep both)**. None is already in the tip (`merge-base --is-ancestor`).
3. **Correction for the desk (RULES 6.2):** the brief called the installed line "Civil 3.0.74 / Manager 1.1.74 (C-64)". The truth, read on this PC at 14:19: the six installed DLLs read `3.0.73+5467f7053a2e...` and `1.1.73+5467f7053a2e...` (that is C-63, installed 11:36). So **this train, C-64, becomes Civil 3.0.74 / Manager 1.1.74**, the payload builder's job, and the jobs are written that way.
4. **Left out on purpose and loud:** nothing in the 40 touches `Shared/`, `Installer/`, `Installer.Tests/`, `Modules/Manager/Installer/` or a signing or deploy file (checked per PR with `git diff --name-only` from the merge-base). The PRs that DO touch those (#992, #1649, #1652, #1234, #1235) are all HOLD or REJECT and are listed in section 5 so the finalizer sees them.
5. **Manager:** #1730 (About CE Suite and CEMANAGER no longer use up a U) and #1750 (CE Tools tab when Manager loads first) change Manager code, so this is a real Manager release (75-file guard to be re-run).
6. **Pilot-critical batches 2 and 3:** no report exists yet (`areas\release-v3-colleagues-PILOT_CRITICAL_BATCH2_REPORT.md` and `_BATCH3_REPORT.md` absent at 14:28). If they land with an independent review that says MERGE before the assembler starts, the desk promotes them by adding a line to section 1 (the assembler reads this file at start).
7. **Not in the train (reasons below):** 10 PRs WAITING for a fix that is not pushed yet (#1748 is the important one: data loss, one wording string owed); 19 PRs ranked next in line that did not fit under the cap of 40; every HOLD, REJECT and notes-only PR.

## 1. IN THE TRAIN, in merge order (reference head = the live head at 14:13, re-checked for the Group 4 and pilot PRs at 14:28; the assembler re-reads the live head and refuses a rewritten branch)

How to read each line: PR number, bug ids, 40-character reference head, the review that said MERGE, why it is in.

### Group 1: data loss and wrong answers (14, all independently reviewed MERGE)

1. **#1747** BUG-1135 (HIGH, data loss), head `346d8e6b05e2906a32edec167dc72d13c6f6e6b5`, base rel-20261024m. REVIEW_PILOT_CRITICAL_24OCT.md item 1: MERGE. An older CE no longer deletes the newer parts of the job record; the version marker is never lowered. Limit to tell Tim: builds installed before this one (3.0.73 and older) still drop and lower; older builds will refuse a CE XREF saved by this build (harmless when every PC gets the same build).
2. **#1642** BUG-988, head `3d6c2b88a4891f78f0b423efc3e35edcfcd69f6a`. REVIEW_PILE_B1_24OCT.md item 1: MERGE. A drawing's own empty CE record now beats an old record file on the PC (a colleague's rainfall and numbering no longer come back). Switch `linking.drawingRecordBeatsPcFile` ON.
3. **#1627** BUG-997, head `3acc9b20902138d2d7bca1be746d1efa4639817c`. B1 item 10: MERGE. Update Existing changes only the older long section you picked, not every copy sharing its block. Switch `linking.longSectionUpdateKeepsCopies` ON.
4. **#1629** BUG-1022, head `01c299c8723d2b131e79f1fec990d840e7d64ebb`. REVIEW_PILE_B2_24OCT.md item 2: MERGE. A pit CE re-finds keeps its schedule override and its row position. Switch `refoundPitKeepsScheduleOverrides` ON. Shares `ProjectDataService.cs` with #1747 (different hunks).
5. **#1628** BUG-1005, head `3851df80bfd91abeef5c46e33c750c8c9b71d5a6`. B2 item 1: MERGE. CDRENUMBER counts the joining pipe when it picks the main line. Switch `renumberScoresJoiningPipe` ON.
6. **#1631** BUG-981, head `2c481e58d24f4155c8489e4a9a4f5ebed20cb62c`. B2 item 3: MERGE. A Pit Schedule built from two Xrefs keeps each drawing's pits as separate groups. Switch `scheduleXrefGroupsKeepDrawing` ON.
7. **#1559** BUG-979, head `ab8980c8e58f48d9856007a48763991f3f36b1f4`. REVIEW_PILE_B7_24OCT.md: MERGE. CDJOINT keeps the old joints if you press Esc (the erase moves later).
8. **#1578** BUG-1012, head `409feaf57277fcf7ae38e21088f54da150e11cef`. B1 item 8: MERGE. The long section reads the closing side of a closed boundary (a pipe crossing it gets its boundary mark).
9. **#1573** BUG-1007, head `1d03449206f9b31c7f02fcb0cda89ac746775ce1`. B2 item 4: MERGE. The CDFALL arrow points the way you picked in a metre drawing.
10. **#1641** BUG-996, head `c0a03bc129b7007676c0c9bea580da4e889f2acd`. B2 item 9: MERGE. Mirrored CD text keeps its link to the pipe. Switch `cdMirrorKeepsPipeTextLink` ON.
11. **#1561** BUG-980, head `81e64f7da2ba1690b3d7b7101622da73a7e2f369`. B2 item 8: MERGE. CDCALC Pipe Flows refills the grade when a second pipe is picked. Shares `PipeFlowCalcViewModel.cs` with #1728.
12. **#1599** BUG-995, head `fc905d69f52cced399dc6f56dbc82e7d685f5cf8`. B2 item 6: MERGE. Inspector health buttons zoom to the right pits when the UCS has been moved.
13. **#1712** BUG-811 level cascade half, head `49792ecacfcbb6d9eb50d619b9b51ff894123d38`. REVIEW_CX4_AND_BATCH4_24OCT.md: MERGE. A rejoining pit follows the lowest arriving pipe. Cascade write, one Undo: the finalizer reads it for REDO-safety.
14. **#1341** BUG-710, head `4771157cafe939db8f9c1bf892121a4a490b210d`, base rel-20261018c. REVIEW_PILE_B6_24OCT.md: MERGE. CDFALLSUGGEST grade on metre drawings. Trial merge clashed only in the log (base is 674 commits behind, files=5).

### Group 2: daily tools, privacy and pilot-critical (16, all independently reviewed MERGE)

15. **#1750** BUG-1206, head `cf6b3bec255c640e38616155d71c6f979beb739a`. REVIEW_PILOT_CRITICAL_24OCT.md item 3: MERGE. The CE Tools tab appears when Manager loads before Civil. MANAGER code (CeUnifiedRibbonService).
16. **#1751** BUG-1165, head `29324462abcfa34c06c641451d74302a8f35937d`. Pilot review item 4: MERGE. CE blocks come from the running CE copy, not an old all-users copy. Switch `pits.blocksFromRunningBundleFirst` ON.
17. **#1754** BUG-1167, head `9bb151be546c0691c5dfd497a9531ca1601f0bd7`. Pilot review item 5: MERGE. Office folders in a copied settings file follow this PC. Switch `linking.otherUsersFoldersFollowThisPc` ON.
18. **#1638** (no bug number; PRIVACY), head `14c8272c1212fb2bb92ced918f1067098732453a`. REVIEW_PILE_B11_24OCT.md item 4: MERGE. CDCHECKIGNORE stores the coded name, not the Windows login, in the drawing. The finalizer must give it a bug number in its report.
19. **#1618** BUG-991, head `004ece8d52fa1b9513802b1bd69bf0102a25b2f8`. REVIEW_PILE_B10_24OCT.md: MERGE. The shared AI sender no longer follows a redirect (the key cannot be sent elsewhere).
20. **#1569** BUG-1008, head `23f1289a0a20197e2608c5c818da8ef703a4e931`. B1 item 3: MERGE. Double-clicking a Remarks cell in the Pit Schedule opens it for typing. Shares `PitScheduleDialog.xaml.cs` with #1614 (Group 4).
21. **#1565** BUG-1003, head `51a01fcca69d4aed63103f71904643beb415548e`. B1 item 4: MERGE. CEFIND finds P1A, C2 and the pipes between them.
22. **#1635** BUG-1032, head `a57515120c4e5b2e382bdd34377eb398096489ea`. B1 item 11: MERGE. CDTWL pick list names the pipe once and says ABOVE the lowest lid.
23. **#1580** BUG-1010, head `b3ee3ea308805a2754202c7754bf7d5634f0f560`. REVIEW_PILE_B8_24OCT.md: MERGE. "Click to count that time" adds the break once.
24. **#1583** BUG-993, head `0fd88b48f2f0677623f43976142d176f528f9b36`. B8: MERGE. CDCHECK adds a FALL symbol's own rotation to it. Shares `FallArrowGeometry.cs` with #1341 (Group 1).
25. **#1554** BUG-799, head `7f4f8c390c5b123acd1954e278386f28edce139b`. REVIEW_PILE_B3_24OCT.md item 3: MERGE. An unloaded Xref shows SOURCE UNLOADED, not SOURCE MISSING (15 files).
26. **#1655** BUG-906, head `52efb49b918875d429c6935dfd1b440047611892`. B3 item 5: MERGE. CDRULES R-30 leaves the storage grade unknown when the detention length is missing. Reuses the existing R-06 switch (OFF brings back old R-06 and R-30 together).
27. **#1656** BUG-904, head `cb53d0f897afcf79c95e70fb46b5ff4d6ccbc5c9`. B3 item 4: MERGE. CDDESIGN warns when the shortest storm tried gives the most storage. Engineering question for Tim (finer sweep near the peak) is in B3 ANSWER FIRST item 6: the note ships, the sweep is parked.
28. **#1640** BUG-992, head `c9e26aa59926de528dec693165e07f2e1369c470`. B3 item 6: MERGE. CDXREFCOMPARE also lists CE objects near a moved shape's old position. Switch `linking.xrefCompareChecksOldPosition` ON.
29. **#1730** BUG-1085 and BUG-1086, head `c9b414847f2068a7a8e8c859126de1d71c979048`. REVIEW_PILE_B15_24OCT.md item 1: MERGE. Looking at CEMANAGER or About CE Suite no longer uses up the next U. **Undo-related and MANAGER code: the finalizer reads it for REDO-safety.**
30. **#1728** BUG-1036, head `115eeaf03beb429871c18525e7cb501e104b08ed`. B15 item 3: MERGE (both commits: the review asked a fix, it is in). The Pipe Flows Roughness box starts from the office Settings value.

### Group 3: the rest (4, all independently reviewed MERGE)

31. **#1601** BUG-1001, head `7e32a24125f382fcff10f4afbf9ac6ea0bff39d1`. B3 item 7: MERGE. X-Civil import gives two close pits their own labels.
32. **#1607** BUG-1000, head `8adabfe69a7a8fcf2b39239795f555ee1f80412e`. B3 item 8: MERGE. X-Civil import moves spot levels and FALL arrows with the pits and pipes.
33. **#1616** BUG-1002, head `74c696781e45debad04f7f72356d63a9178044fe`. B3 item 9: MERGE. X-Civil import keeps a rotated FALL arrow block's direction.
34. **#1711** BUG-766, head `5ee899a2ee49203db09a06b7a4aa61c37078e23b`. REVIEW_CX4_AND_BATCH4_24OCT.md: MERGE. CDPROFILE draws the branch junction tick. Shares `LongitudinalSectionService.cs` with #1627.

### Group 4: review said MERGE-WITH-FIXES (or MERGE with asks) and the builder pushed the fix; the fix commit itself is NOT independently re-reviewed (6; merge last; the finalizer reads each fix commit as a first review and says KEEP or DROP)

35. **#1626** BUG-998, head `e852f2589d879ca412520bc829d23da75fd82e14` (review head `d6ac68ce`). B1 item 9: MERGE-WITH-FIXES. Fix pushed by Max build G (`MAX_BUILD_G_REPORT.md` item 2.8). Network redesign "before" levels are each pipe's own. Note from the builder: the swap guard is not a visible fix; the 4,000 pipe limit is.
36. **#1597** BUG-1024, head `10ed4f53f235eb3005380575e8b191555c859e23` (review head `a11a1bef`). B1 item 6: MERGE-WITH-FIXES. Fix pushed by Max G (item 2.7): no empty rollback file. CDSPINEUPGRADE Apply brings a rebuilt CE record back in step.
37. **#1419** BUG-803, head `f0a87b5a85353d25712ee6dc73cad0a6c19491c1` (review head `6199df19`), base rel-20261018d. REVIEW_PILE_B6_24OCT.md: MERGE-WITH-FIXES. Fix pushed by Max G (item 2.9). CDREBUILD cannot point a kept pit at somebody else's pipe. **Trial merge: clashes in `UserSettings.cs` (`rebuildKeepsOnlyCarrierIdentity`, a neighbouring addition: keep both) and the log.**
38. **#1614** BUG-1009, head `d91e4dfb0417eaa57a5a5abdd912727e99e92e13` (review head `26fcd655`). B2 item 7: MERGE-WITH-FIXES. Fix pushed by Max G (item 2.6): the double-click no longer looks up an Xref row's pipe in the current drawing. Shares `PitScheduleDialog.xaml.cs` with #1569 and `PitScheduleViewModel.cs` with #1722.
39. **#1722** BUG-1035, head `db50498a7a1d4b3f5fad7651b520c0e4edd0fc10` (review head `544022b8`). CX4 review: MERGE-WITH-FIXES. Fix pushed by Max G (item 2.2): the "Shallow" depth is a Settings value (`shallowPitDepthMm`, a value, not a switch; the builder added a Pipes and Pits box and says the Settings window stayed within 670 px: the finalizer runs the Settings-fit test).
40. **#1717** BUG-812, head `676874b54645f83aa8b838856ffc54b876a5c413` (reviewed at `cedc590e`). CX4 review: MERGE; the asks were fixed by Max build F (`MAX_BUILD_F_REPORT.md` item 1): the copied-pump-pit line prints once per drawing per session.

## 2. Expected new Settings keys in the train (the diff is the truth; the finalizer judges each)

1. **Bug-fix switches, all expected ON:** `linking.drawingRecordBeatsPcFile` (#1642), `linking.longSectionUpdateKeepsCopies` (#1627), `refoundPitKeepsScheduleOverrides` (#1629), `renumberScoresJoiningPipe` (#1628), `scheduleXrefGroupsKeepDrawing` (#1631), `cdMirrorKeepsPipeTextLink` (#1641), `linking.xrefCompareChecksOldPosition` (#1640), `pits.blocksFromRunningBundleFirst` (#1751), `linking.otherUsersFoldersFollowThisPc` (#1754), `rebuildKeepsOnlyCarrierIdentity` (#1419). Group names of the first-named five are read from the diff by the assembler (the JsonProperty names above are exact; their group is not recorded here).
2. **A value, not a switch:** `shallowPitDepthMm` (#1722; the review asked that it be a Settings value; 300 mm is the old fixed number).
3. **No Settings page row for most of these** (the Settings window is at its 670 px limit); the finalizer lists every switch without a row, builds none, and writes the C-64 new-switch defaults test (older settings file loads each one ON; a typed OFF is kept; the C-61 to C-63 defaults pinned again).

## 3. Files touched by more than one PR in the train (by `git diff --name-only` from each merge-base; the log excluded)

1. `Modules/Drainage/Models/UserSettings.cs`: #1642, #1627, #1629, #1628, #1631, #1641, #1754, #1655, #1640, #1419, #1722 (ten switches and one value added at neighbouring places: keep all, unique JsonProperty names).
2. `Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs`: #1569 and #1614. `Modules/Drainage/ViewModels/PitScheduleViewModel.cs`: #1614 and #1722.
3. `Modules/Drainage/Rules/FallArrowGeometry.cs`: #1341 and #1583. `Modules/Drainage/Services/LongitudinalSectionService.cs`: #1627 and #1711. `Modules/Drainage/Services/ProjectDataService.cs`: #1747 and #1629. `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs`: #1561 and #1728.
4. Not trial-merged together: this list gives the overlaps; a real clash on one of them stops that PR only (the assembler's rule) and the rest carry on.

## 4. WAITING for a fix that is not pushed yet (NOT merged; only the desk can promote one into section 1)

1. **#1748** BUG-1138 (data loss, MERGE-WITH-FIXES), live head `f9667b01b37a90676934b44b799e6a2a0859b4d2` = the reviewed head. One string owed in `UnloadedPipeObjectRule.cs` `RefusalLine` (after a pit MOVE it must say "Your edit stands; every pit keeps its old pipe list. Run CDSYNC on a PC with the current CE suite on AutoCAD 2027 to relink."). Exact text in REVIEW_PILOT_CRITICAL_24OCT.md item 2. About five minutes of work; merges clean (rc 0). **The one data-loss PR left out: the desk should have a builder push that string before the assembler starts.**
2. **#1643** BUG-982 (wrong levels saved flat): MERGE-WITH-FIXES, live head `18c6393e63a99301ac45a6b12a551f66f3222895` = reviewed head, fix NOT pushed (needs a rebase onto C-63's one-in-N helper; trial merge clashes in `LinkService.RepairAudit.InvertPropagation.cs`).
3. **#1593** BUG-1021 (CDTWL low lid): head `7884b0cf...` unchanged, fix not pushed (needs a rebase; clashes in `DetentionBranchCollector.cs`; merge #1635 first).
4. **#1588** BUG-994 (Inspector drawn length): head `8ae9c2f3...` unchanged, fix not pushed (clashes in `InspectorPaletteService.cs`).
5. **#1657** BUG-917 and **#1691** BUG-961 (Manager wording and hidden field names): heads unchanged, fixes not pushed; both clash in `PluginManagerWindow.xaml`; #1657 half-overlaps C-63's #1665.
6. **#1000** UX-SEL-01 (pick prompts in drafting words): MERGE-WITH-FIXES, the fix is a hand merge of three code files (`LinkCommands.cs`, `PitEditCommand.cs`, `RunSolveCommand.cs`); the assembler never hand-resolves code logic.
7. **#1620** BUG-990 (heartbeat https only): review says MERGE only after Tim answers where the heartbeat may go on a PC with no approved-address record (REVIEW_PILE_B10_24OCT.md item 6). Tim's question; not turned into a decision.
8. **#1195** (Manager M03 standard files) and **#1198** (M05): the wording of the repair advice ("run the CE installer again" or "ask your CE administrator") needs Tim's word (`MAX_BUILD_G_REPORT.md` section 3 item 2); neither is wired in to anything a drafter sees.

## 5. Touch Shared, Installer or signing files (the finalizer must see these loudly; all LEFT OUT)

1. **#992** (CE_SHARED, two files, and the ribbon): HOLD until after 9 Nov (REVIEW_PILE_B12_24OCT.md); Manager would need its pinned CE_SHARED fingerprint renewed.
2. **#1649** BUG-885 (replaces `Installer/build_installer.ps1` with a pack-only tool and adds a signing-tool operation): HOLD (REVIEW_CODEX_LF_A/B_23OCT.md); would leave the next train unable to build Civil.
3. **#1652** BUG-887 (installer refuses a half whenever the other half's CE_SHARED differs): HOLD; it would stop every normal update and is a new hard block (R-27).
4. **#1234** (Manager update staging) and **#1235** (Manager install service): REJECT, already installed another way (REVIEW_PILE_B5_24OCT.md).
5. **Already in the tip, for the record:** #1647 (Manager approval reader) and #1648 (installer office-approval reading) went into C-63; the installer EXE was changed there.

## 6. Ranked next in line (over the cap of 40, all independently reviewed; the desk can promote any, in this order)

1. **#1713** BUG-810 audits only read, metre drawings and pit wall (CX4: MERGE).
2. **#1225** BUG-552 fault reports name no drawing or client path (privacy; fix pushed by Max G, head `6ace3ae193ca644401bf434fa98feea49766497d`; REVIEW_PILE_B4: MERGE-WITH-FIXES, still leaks a drawing name with spaces unless the G fix covered it: read it). Merges with a log clash only; its base is 1,047 commits behind.
3. **#1167** BUG-555 and BUG-491 (privacy: CDHELP web fallback off by default; G fix, head `1cc57d9d62d40c33fe8ba20eb44c20218119261c`; clashes in `UserSettings.cs` and the log).
4. **#985** CDASK Analyse markups never sends the live screen (privacy; head `3a8d09017e24e47e18f9e1c672f128ab34089226`; B12: MERGE; its base is 1,082 commits behind, log clash only).
5. **#1010** LandXML circular pit reads diameter first (head `1ca9c5146f8754afe3f02ac1d8f406674dc6163d`; B12: MERGE-WITH-FIXES, the fix is the settings clash only; switch `xcivilImport.landXmlCircularDiameterFirst` ON).
6. **#1720** RD03 FA01 (pit cover blank allowed, office editors open anywhere): live head `10d43278518945d0dad67ffb9afafd224382aa01`, 33 files; reviewed at `50fd12eb`, and three later commits (e596d426, 5cce5453, e59db341 and 10d43278) were never re-reviewed. Read the later commits first.
7. **#1718** BUG-1074 and BUG-1075 (Manager hover and CDSPINEUPGRADE plain words, 25 files; CX4: MERGE).
8. **#1733** BUG-1087 About CE Suite heading readable (B15: MERGE).
9. **#1719** RD09 false test passes removed (tests only; CX4: MERGE).
10. **#1633** BUG-927, **#1634** BUG-944 (G fix, head `9354d130f31821ce1554a5b3e1e65c5a83671340`), **#1637** BUG-945 (G fix, head `584fd1684e4b9da571e2499793799cf059b8c3a9`): plain command-line wording (REVIEW_PILE_B11).
11. **#1672** BUG-918 (Manager wording, B1 item 2: MERGE), **#1690** BUG-960 (Checks and What CE Found follow theme changes, B11), **#1703** (Manager regression cases, tests only, B11).
12. **#1243** BUG-558 Help note on Undo and Redo (B5: MERGE), **#1047** plastic pit PP line (B14: MERGE; file a carpark bug first), **#1056** (tests only), **#1314** Tidy labels (B2: MERGE, only matters with its switch ON).

## 7. Left out: HOLD, REJECT, notes-only, unreviewed, plan-train, Structural

1. **HOLD / REJECT (independent review):** #1721 (HOLD, head moved since review), #1716 (HOLD; clash with the two LandXML PRs; its rebased copy #1727 has no independent review), #1706 (REDO-hook, cause never reproduced, the C-63 finalizer left it out), #1661 (never built), #1670, #1714, #1715 (notes only), #1644 (superseded by installed #1617), #1190, #1423, #1070, #1192, #1084, #1019, #1383, #1521, #1246, #397, and the REJECT-superseded set #1215 #1216 #1217 #1219 #1221 #1229 #1230 #1231 #1232 #1233 #1236 #1238 #1242 #1256.
2. **Plan work for a later plan train (not pilot fixes):** #1086, #1048, #1037, #1039, #1021, #1025, #1028, #1033, #1036, #1040, #1042, #1046, #1053, #1054 and the Manager rules #1200, #1198, #1195.
3. **Structural PRs (never in this train):** every PR the pile reviews name for S-44 (for example #1736, #1731, #1729, #1732, #1385, #1386, #1529, #1460, #1464, #1563 to #1568, #1574 to #1590, #1603 to #1608, #1615 and the #1695 family).
4. **No review exists:** drafts of FB Team batches 6 to 13 (no branch or report), and Codex PRs of the cx2 and cx3 branches.

## 8. What I did NOT check

1. **Nothing was built or run.** "Fix pushed" means the live head equals the head named in the builder report; I did not read the fix commits.
2. **Pairwise merges inside the train were not simulated beyond the overlap list in section 3**; only each PR against the tip.
3. **Reviews of #1747 and the other pilot-critical PRs** were read, not re-derived; their review heads equal the live heads (checked at 14:28).
4. **#1000's, #1010's and the older-base PRs' (#1341, #1419, #1225, #1167, #985) semantic fit** with C-63 was judged only by a clean text merge.
5. **Which Settings group the first five switch names belong to** (read from the diff by the assembler).
6. The older reviews of C-63's own PRs were not re-read; their PRs are already in the tip.
