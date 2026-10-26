ANSWER FIRST — BUG-1201 — BLOCKED — draft PR #1813

1. **PR and code:** Full-suite validation is blocked: the completed changed runs do not match the zero-failure base. https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1813. Branch cx6/bug-1201-bd25; branch head 50145a60df841dbcaecd374e0bf61e698190b37a. Built and unit-tested only; no installation or AutoCAD acceptance.
2. **Base heads:** selected claude/rel-20261026u at 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. Fallback claude/rel-20261026t at d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Both were read from origin after fetch; the selected base was checked again before the three builds and before delivery: unchanged after the final fetch; merging origin/claude/rel-20261026u said Already up to date.
3. **Red and green:** unchanged-product red: Failed SpotLevel_Bug1201_EscapeAtFirstPrompt_LeavesNoBlockDefinition (1 failed, 3 passed). After the change: Passed SpotLevel_Bug1201_EscapeAtFirstPrompt_LeavesNoBlockDefinition; all 22 BUG-1201 checks passed. All 150 related checks passed.
4. **Full suite:** before: 20,539 total, 20,507 passed, 32 skipped, zero failed. After: 20,565 total, 20,531 passed, 32 skipped, 2 failed (26 min 37 s). Failed test names before: none. Failed test names after: Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce; Diagnostic_MessagesReachTheLogFile. All three Civil builds, net48 / net8.0-windows / net10.0-windows, completed with zero errors.
5. **What Tim will see:** in a build containing this change, CDSL then Escape at either question leaves no unused SPOT LEVEL block. The new line says “[CE] CDSL command cancelled. Nothing was changed.” Typing 18.600 still places P18.600. Settings → Newer tools has the checked row “CDSL loads its block after both answers”.
6. **Exact AutoCAD check, not run here:** use a saved Civil drawing without SPOT LEVEL. Record block-table names and DBMOD. Run CDSL, then Escape at the insertion-point question. Names and DBMOD must be unchanged; BLOCK must still have no SPOT LEVEL, and the CE log must have no “Loaded block” line. Repeat after picking the point and pressing Escape at the level question.
7. **Not run:** no AutoCAD session was started or used, no CDSL placement was tried in a real drawing, no installed Settings window was opened, and nothing was installed or deployed. Native drag appearance, DBMOD, BLOCK names, locked-layer / Xref / REFEDIT behaviour and Undo/REDO still need the AutoCAD check. Pictures cover AdvancedSettingsDialog; CivilSettingsView’s mirrored bindings were checked, but its Manager host was not rendered. The 16 pictures are real Settings markup rendered off-screen, not an AutoCAD acceptance.
8. **Limits:** OFF intentionally restores the older eager import, including its unused definition on Escape. The first completed changed-run had three failures; the test-list omission and the logging/PDF follow-up are recorded below. The untouched baseline printed a test-log cleanup warning despite reporting zero failed cases; the adapter also gives different discovered/skip totals in TRX. Both are recorded below.
9. **Open PR overlap:** 1404 open PRs checked at 2026-10-27 03:01:44 +11:00 Melbourne time; excluding #1813, 346 share code/test files, 20 share Settings pictures and 1396 share REGRESSION_LOG.md (groups overlap; no incomplete file lists). The complete snapshot and code-specific lists are below. All PR numbers in this report belong to timbrand92/CE_ACAD_PLUGIN.

---

1. **Scope and timing:** work began late on 26 October and continued on 27 October 2026, Melbourne time. Initial free space on C: was 44,456,525,824 bytes (44.5 GB), above the 8 GB stop threshold. The live BUG-1201 entry was OPEN. git grep found no existing BUG-1201 code entry and gh pr list found no open matching PR before work; the open-PR check was repeated during the baseline run.
2. **One working copy:** C:\ce-cx\bd25, created on cx6/bug-1201-bd25 from origin/claude/rel-20261026u. The untouched tracked tree was clean before the baseline and before the test-only red run. No main-checkout work was taken over. The release was fetched and merged, never rebased; it was already up to date at the pre-build check. Every commit made by this session names BUG-1201.
3. **The bug and the common preview:** the old command called EnsureBlockDefinition before its point question. Its shared drag helper called EnsureBlockDefinition again. Both were capable of importing SPOT LEVEL before Escape. The command also marked/saved/synchronised the Civil record and ensured its layer before either answer. Moving only the first EnsureBlockDefinition call would not have removed those drawing changes.
4. **Why BlockService changed:** the drag implementation is private to BlockService. A small internal overload accepts an already-read definition and forwards to the same drag implementation. Existing callers keep the original signature, including the final worldPlan parameter, and their older preparation. This preserves the tested source-placement contract without copying the drag logic or editing a protected placement service.
5. **What is read before the questions:** the ON path uses CommandPreFlightForDeferredApply. Its Civil approval reads the drawing type; it defers storing a newly agreed type. LayerService.IsLayerLocked reads the layer table and returns without committing. SurveyService.TryLoadSurveyPayload reads the survey payload and returns without committing. These normal read transactions are disposed; they do not write drawing objects.
6. **Detached first-use preview:** TryReadPreviewDefinition reads an existing local definition through an open-close transaction, rejecting external/dependent definitions through the existing local-block helper. If no definition exists, it reads SPOT LEVEL.dwg in a detached source database and copies it into a disposable preview database, using the drawing’s stored units. Layer preparation names that preview database explicitly. The temporary reference is never appended to the drawing. The shared preview reads a layer that already exists; it does not ensure a drawing layer on this route. The transient reference receives the explicit LayerId from that same database’s layer table. See [Autodesk’s LayerId reference](https://help.autodesk.com/cloudhelp/2026/ENU/OARX-ManagedRefGuide/files/OARX-ManagedRefGuide-Autodesk_AutoCAD_DatabaseServices_Entity_LayerId.html). The reference and preview database are disposed on Escape, error or accepted pick.
7. **No early quiet-setting write:** the preview deliberately uses the detached database’s Insert directly. InsertQuietly changes NOMUTT temporarily, so it is used only by the existing accepted drawing import, after both answers. No “Loaded block” CE log line is written by the detached preview.
8. **The internal test seam:** SpotLevelCommand.RunPlacement takes callbacks for loading, picking, reading the level and placing, with an optional switch value read from SettingsService.Current when omitted. The live command supplies the actual calls and passes its captured setting. ON calls loading only after both answers; either cancelled question returns before loading or placing. OFF calls the older preparation before the point, exactly restoring the older import order. This is one production order, not a second test-only placement rule.
9. **The accepted drawing write:** only after both answers does the ON path lock the document, recheck the layer and bind the correct Civil record with the existing no-write BindToDrawingForRightClick helper. That helper keeps another drawing’s owed save in memory. It then starts the accepted transaction, revalidates Civil approval/REFEDIT, writes the Civil marker, ensures the layer, calls TryEnsureBlockDefinitionInTransaction and replaces the preview definition ID with the drawing’s ID. AppendPreparedBlockReference and, when a level is given, SetAttributeInTransaction use that same transaction. A return or exception before commit reaches Abort, followed by disposal; a successful commit is disposed before the existing draw-order call. There is no purge or erase.
10. **Second placement:** TryEnsureBlockDefinitionInTransaction resolves an existing local definition before its Insert call. A second accepted placement reads and reuses that definition; it does not import or log another load. The source guard and callback checks cover both the accepted order and reuse.
11. **Protection and Undo/REDO:** the modal CDSL command is the only new code entry; no timer, Idle action, history handler or deferred drawing work is registered. No new work runs automatically between U and REDO. The accepted write uses a document lock and the caller’s transaction. Native history behaviour is not claimed from unit tests. Locked layers are checked before the pick and again under the lock; they are never unlocked. Existing local-block validation rejects dependent/Xref/overlay definitions, and accepted import validates again. Shared pre-flight and accepted Civil approval check REFEDIT. No reference is detached, cloned around or bypassed.
12. **Switch and Settings:** LinkingSettings.SpotLevelImportsAfterPick has JsonProperty spotLevelImportsAfterPick, an explicit true initialiser and “Default: on.” documentation. Both actual settings readers load a missing key ON and keep a typed OFF; JSON round-trip checks retain the same key. The command’s optional flag allows tests to set the mode in memory. The existing draft tracker, candidate writer, reset, search and change marks handle the row. Existing Bj32 persistence tests also read back a synthetic test-owned file; Tim’s real settings files are not used.
13. **Window layout and pictures:** the switch sits in spare space in Newer tools’ right column. The existing SettingsTickTextStyle, theme brushes, fixed header/footer, type size and spacing are reused. The existing STA RenderTargetBitmap check now includes the new row and enforces the 673 px limit. Final measured height: 670 px in both themes. All eight tabs were rendered at 1080p, scale 1; every one of the 16 pictures was inspected for clipping, overlap, scrollbars and private job information.
14. **What the tests prove:** the first red check is a source-order regression guard. It reported “Expected: greater than 5900” and “But was: 2428”, placing the drawing import before the level question. The later callback tests execute the command’s real order with in-memory drawing-write callbacks, including both cancellations, accepted placement, reuse, the ordinary P18.600 control, blank Enter and OFF. These are source/order/unit checks, not a native block-table or DBMOD measurement.
15. **Control correction before the proper red run:** the first control assertion omitted the existing P prefix. It was corrected to P18.600 while product code remained unchanged, then the proper red run showed only the cancellation regression failing. The product’s shared SpotLevelText formatter was not changed.
16. **Exact tests requested:** SpotLevel_Bug1201_EscapeAtFirstPrompt_LeavesNoBlockDefinition; SpotLevel_Bug1201_AcceptedPlacement_StillImportsAndPlaces; SpotLevel_Bug1201_SecondPlacement_DoesNotReimport. The source/control fixture is Modules/Drainage.Tests/Commands/SpotLevelBug1201Tests.cs. The callback/default/round-trip fixture is SpotLevelBug1201FlowTests.cs in the same folder. Existing Bj32 and C60 row cases cover the real Settings row and save/reset behaviour.
17. **Build and run evidence:** product build head 86f7688e8e384d7c639fd2ce6c53e17a0dc2ce36; full-suite test head 04ee49513588cd10a89cd267a73538c69142dc76. The later row-manifest edit changed test expectations only, not the product code. All .NET project paths were absolute. Every build and test used -p:SkipDevBundle=true -nr:false --disable-build-servers, plus the three reference parameters given in the brief. The three builds ran sequentially in the foreground. No version, installer, package or deployment change was made.
18. **Test-host setup:** AutoCAD 2027 was added to PATH for each test process. The worktree had a test-only, empty Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx placeholder so the existing build copy could complete. It is ignored build output, not a working native module, and was never deployed. No native AutoCAD pass is inferred from it.
19. **Before/after totals and failed names:** Console before: 20,539 total / 20,507 passed / 32 skipped / 0 failed. Complete final repeat: 20,565 total / 20,531 passed / 32 skipped / 2 failed. TRX before: 20,567 total, 20,507 Passed results, 60 NotExecuted results and zero Failed results. Final TRX: 20,593 total, 20,531 Passed, 60 NotExecuted and 2 Failed results. The XML Counters notExecuted attribute is 0 even though UnitTestResult has 60 NotExecuted records. Console and TRX therefore differ by 28 in their total/skip accounting; the reason was not established. Final failed names: CE_CVL_SUITE.Tests.Rules.ScaledPitRecordTests.Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce and CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile. Both were Passed on the untouched base. The final binding and PDF cases were Passed.

20. **Earlier completed changed-run:** after.log/after.trx recorded 20,565 total, 20,530 passed, 32 skipped and 3 failed (38 min 39 s). EveryBinding_NamesARealValue_SoNothingIsSilentlyUnbound needed the new row added to its expected list; that omitted test-list entry was corrected in 04ee49513588cd10a89cd267a73538c69142dc76. The production Settings row and bindings were already present. Diagnostic_MessagesReachTheLogFile timed out after 5 s, and LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully reported resource-in-use 0x800700AA. Both passed on the untouched base; their source files were left unchanged. The combined follow-up ran 77 cases: 76 passed and log delivery failed again; the corrected Settings binding and PDF case passed. Log delivery then passed alone (1/1), and the complete logging fixture with BUG-1201 passed (28/28). The complete final repeat still failed log delivery and also failed Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce: 1923 ms against its existing 1500 ms limit. Those files and limits were not changed. The repeated full suite does not match the zero-failure base, so validation is BLOCKED; the cause of the broader-run failures remains unestablished.
21. **Cleanup warning:** baseline SettingsIsolationSetup.EndIsolatedSettingsScope printed an IOException because CE_CVL_SUITE.log was still open when its temporary folder was removed. The runner still exited 0 with zero failed cases. Final run: the same CE_CVL_SUITE.log-in-use IOException was printed; the runner exited 1 and reported the two failed cases listed above. The baseline cleanup issue was left outside BUG-1201.
22. **Preserved scope:** CE_SHARED and every protected source file were left unchanged, including Structural, editors, LinkService, save/undo handlers, C7 objects/overrules, tidy-up and protected placement services. BlockService’s limited preview overload is described above. No engineering number, council value, library asset, client name or site address was added or changed.
23. **Review evidence on disk:** C:\ce-cx\bd25-evidence contains base.log/base.trx, red-corrected.log/red-corrected.trx, green-final.log/green-final.trx, related-final.log/related-final.trx, build-final-net48.log, build-final-net8.0-windows.log and build-final-net10.0-windows.log, after.log/after.trx (first completed changed-run), after-final.log/after-final.trx (complete repeat), failures-recheck.log/trx, logging-alone.log/trx, logging-with-bug1201.log/trx and the overlap snapshot. An earlier after-run was stopped when review made the transient preview’s layer ID explicit; after-before-layer-id.log preserves that partial run. It is not counted as a completed full-suite result. These logs are not committed to the code tree.
24. **Additional native checks, not run:** accept a point and type 18.600; verify LEVEL is P18.600 and the spot level is on the configured text layer. Place another and confirm there is no second Loaded block line. On a drawing copy, use U and REDO to check each accepted placement. Repeat cancellation with the text layer missing; it must remain missing. Check a locked text layer, an Xref-owned definition and REFEDIT: no unlocking, detaching, bypass or drawing change on refusal.
25. **Safe commands:** dotnet build or dotnet test used -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers and -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref" -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027". Tests used -f net10.0-windows; the three product builds used net48, net8.0-windows and net10.0-windows. The red and green runs added --filter "FullyQualifiedName~Bug1201".
26. **Exact red and green output:**

```text
red-corrected.log (product unchanged):
  Passed SpotLevel_Bug1201_AcceptedPlacement_StillImportsAndPlaces [11 ms]
  Passed SpotLevel_Bug1201_Control_OrdinaryProposedLevel_StillReadsP18600 [4 ms]
  Failed SpotLevel_Bug1201_EscapeAtFirstPrompt_LeavesNoBlockDefinition [29 ms]
  Expected: greater than 5900
  But was:  2428
  Passed SpotLevel_Bug1201_SecondPlacement_DoesNotReimport [2 ms]

green-final.log:
  Passed SpotLevel_Bug1201_AcceptedPlacement_StillImportsAndPlaces [1 ms]
  Passed SpotLevel_Bug1201_Control_OrdinaryProposedLevel_StillReadsP18600 [< 1 ms]
  Passed SpotLevel_Bug1201_EscapeAtFirstPrompt_LeavesNoBlockDefinition [< 1 ms]
  Passed SpotLevel_Bug1201_SecondPlacement_DoesNotReimport [1 ms]
Test Run Successful.
Total tests: 22
     Passed: 22
```

27. **Saving:** code branch and draft PR were pushed without bypassing the leak-scan hook. This report is saved from C:\CE_PLAN by its one filename; BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited by this session.

---

1. **Dark:** [settings-dark-1-drafting.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-1-drafting.png).
2. **Dark:** [settings-dark-2-pipes-pits.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-2-pipes-pits.png).
3. **Dark:** [settings-dark-3-design.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-3-design.png).
4. **Dark:** [settings-dark-4-survey.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-4-survey.png).
5. **Dark:** [settings-dark-5-display.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-5-display.png).
6. **Dark:** [settings-dark-6-advanced.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-6-advanced.png).
7. **Dark:** [settings-dark-7-newer tools.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-7-newer%20tools.png).
8. **Dark:** [settings-dark-8-fixes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-dark-8-fixes.png).
9. **Light:** [settings-light-1-drafting.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-1-drafting.png).
10. **Light:** [settings-light-2-pipes-pits.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-2-pipes-pits.png).
11. **Light:** [settings-light-3-design.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-3-design.png).
12. **Light:** [settings-light-4-survey.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-4-survey.png).
13. **Light:** [settings-light-5-display.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-5-display.png).
14. **Light:** [settings-light-6-advanced.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-6-advanced.png).
15. **Light:** [settings-light-7-newer tools.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-7-newer%20tools.png).
16. **Light:** [settings-light-8-fixes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/50145a60df841dbcaecd374e0bf61e698190b37a/docs/image/V3_WINDOWS/settings-light-8-fixes.png).

---

1. **Open PR snapshot:** 2026-10-27 03:01:44 +11:00 Melbourne time; 1404 open PRs checked, 0 incomplete file lists. Excluding this job's PR #1813, 1396 share at least one changed file. PR titles and bodies are omitted.

2. **Command and shared preview (1–25 of 34):** #2, #367, #369, #370, #371, #376, #452, #453, #454, #458, #460, #479, #489, #599, #631, #656, #671, #896, #910, #945, #959, #991, #994, #1005, #1090.

3. **Command and shared preview (26–34 of 34):** #1165, #1167, #1170, #1342, #1344, #1349, #1743, #1751, #1758.

4. **Settings and tests (1–25 of 323):** #56, #372, #383, #389, #390, #396, #398, #401, #406, #425, #426, #433, #435, #441, #452, #453, #454, #460, #475, #556, #575, #642, #643, #644, #680.

5. **Settings and tests (26–50 of 323):** #682, #694, #699, #703, #705, #707, #711, #713, #715, #717, #731, #772, #773, #785, #790, #791, #800, #805, #822, #828, #833, #834, #835, #836, #838.

6. **Settings and tests (51–75 of 323):** #839, #840, #841, #842, #844, #847, #849, #850, #853, #855, #888, #891, #892, #900, #901, #903, #905, #910, #911, #916, #917, #926, #928, #931, #932.

7. **Settings and tests (76–100 of 323):** #948, #950, #953, #954, #958, #959, #960, #969, #970, #972, #974, #976, #983, #992, #996, #997, #998, #1003, #1009, #1010, #1017, #1019, #1021, #1023, #1025.

8. **Settings and tests (101–125 of 323):** #1028, #1029, #1030, #1031, #1032, #1033, #1034, #1036, #1038, #1040, #1054, #1061, #1069, #1070, #1073, #1086, #1089, #1141, #1143, #1144, #1145, #1147, #1150, #1151, #1152.

9. **Settings and tests (126–150 of 323):** #1153, #1155, #1156, #1158, #1159, #1160, #1161, #1163, #1165, #1167, #1170, #1171, #1173, #1176, #1181, #1183, #1185, #1187, #1188, #1196, #1199, #1208, #1218, #1219, #1221.

10. **Settings and tests (151–175 of 323):** #1222, #1223, #1224, #1246, #1251, #1252, #1280, #1281, #1286, #1289, #1290, #1291, #1292, #1293, #1299, #1301, #1302, #1308, #1309, #1313, #1314, #1315, #1317, #1322, #1328.

11. **Settings and tests (176–200 of 323):** #1335, #1337, #1352, #1358, #1361, #1363, #1365, #1366, #1367, #1368, #1369, #1370, #1371, #1374, #1375, #1379, #1380, #1401, #1402, #1403, #1404, #1406, #1407, #1408, #1409.

12. **Settings and tests (201–225 of 323):** #1410, #1411, #1412, #1413, #1415, #1416, #1417, #1419, #1420, #1421, #1422, #1423, #1424, #1425, #1426, #1427, #1428, #1429, #1430, #1431, #1432, #1433, #1434, #1435, #1437.

13. **Settings and tests (226–250 of 323):** #1438, #1447, #1474, #1475, #1476, #1477, #1479, #1480, #1482, #1483, #1484, #1494, #1495, #1507, #1516, #1526, #1528, #1531, #1534, #1537, #1538, #1540, #1552, #1553, #1556.

14. **Settings and tests (251–275 of 323):** #1557, #1558, #1562, #1567, #1570, #1576, #1586, #1591, #1594, #1595, #1611, #1612, #1617, #1622, #1627, #1628, #1629, #1630, #1631, #1640, #1641, #1642, #1643, #1655, #1658.

15. **Settings and tests (276–300 of 323):** #1659, #1664, #1669, #1722, #1734, #1735, #1743, #1753, #1754, #1755, #1756, #1757, #1758, #1760, #1763, #1764, #1765, #1767, #1770, #1772, #1773, #1775, #1776, #1778, #1779.

16. **Settings and tests (301–323 of 323):** #1782, #1783, #1784, #1785, #1786, #1787, #1789, #1790, #1791, #1798, #1801, #1803, #1804, #1805, #1806, #1807, #1808, #1809, #1810, #1811, #1812, #1814, #1815.

17. **Settings pictures:** #441, #575, #1526, #1531, #1552, #1553, #1556, #1557, #1558, #1562, #1567, #1570, #1586, #1591, #1594, #1595, #1611, #1612, #1617, #1803.

18. **Common regression log (1–25 of 1396):** #1, #2, #3, #19, #22, #23, #43, #47, #56, #57, #69, #71, #72, #73, #88, #208, #230, #349, #350, #351, #352, #354, #355, #356, #357.

19. **Common regression log (26–50 of 1396):** #358, #359, #360, #361, #362, #363, #364, #365, #366, #367, #368, #369, #370, #371, #372, #373, #374, #375, #376, #377, #379, #380, #381, #383, #384.

20. **Common regression log (51–75 of 1396):** #387, #388, #389, #390, #391, #393, #394, #395, #396, #397, #398, #400, #401, #402, #403, #404, #405, #406, #407, #409, #410, #411, #412, #413, #414.

21. **Common regression log (76–100 of 1396):** #416, #417, #419, #420, #421, #422, #423, #424, #425, #426, #427, #429, #432, #433, #434, #435, #437, #438, #439, #440, #441, #442, #443, #444, #448.

22. **Common regression log (101–125 of 1396):** #450, #452, #453, #454, #458, #460, #463, #464, #469, #470, #473, #474, #475, #477, #478, #479, #486, #487, #489, #490, #491, #492, #497, #501, #502.

23. **Common regression log (126–150 of 1396):** #503, #507, #508, #513, #514, #516, #517, #518, #520, #537, #538, #540, #543, #545, #547, #548, #549, #550, #551, #552, #553, #554, #555, #556, #557.

24. **Common regression log (151–175 of 1396):** #558, #559, #560, #561, #562, #563, #564, #565, #566, #567, #568, #569, #570, #571, #572, #573, #574, #575, #576, #577, #578, #579, #580, #581, #582.

25. **Common regression log (176–200 of 1396):** #583, #584, #585, #586, #587, #588, #589, #590, #591, #592, #593, #594, #595, #596, #597, #598, #599, #601, #602, #603, #604, #605, #606, #607, #609.

26. **Common regression log (201–225 of 1396):** #610, #611, #612, #613, #614, #615, #616, #618, #619, #620, #621, #622, #623, #624, #625, #626, #627, #628, #629, #630, #631, #632, #633, #634, #635.

27. **Common regression log (226–250 of 1396):** #636, #637, #638, #639, #640, #641, #642, #643, #644, #645, #646, #647, #648, #649, #650, #651, #652, #653, #654, #655, #656, #658, #659, #660, #661.

28. **Common regression log (251–275 of 1396):** #662, #663, #664, #665, #666, #667, #668, #669, #670, #671, #672, #673, #674, #675, #676, #677, #678, #679, #680, #681, #682, #683, #684, #685, #686.

29. **Common regression log (276–300 of 1396):** #687, #688, #689, #690, #691, #692, #693, #694, #695, #696, #697, #698, #699, #700, #701, #702, #703, #704, #705, #706, #707, #708, #709, #710, #711.

30. **Common regression log (301–325 of 1396):** #712, #713, #714, #715, #716, #717, #718, #719, #720, #721, #722, #723, #724, #725, #726, #727, #728, #729, #730, #731, #732, #733, #734, #735, #736.

31. **Common regression log (326–350 of 1396):** #737, #738, #739, #740, #742, #743, #744, #745, #746, #747, #748, #749, #750, #751, #752, #753, #754, #755, #756, #757, #758, #759, #760, #761, #762.

32. **Common regression log (351–375 of 1396):** #763, #764, #765, #766, #767, #768, #769, #770, #771, #772, #773, #774, #775, #776, #777, #778, #779, #780, #781, #782, #783, #784, #785, #786, #787.

33. **Common regression log (376–400 of 1396):** #788, #789, #790, #791, #792, #793, #794, #795, #796, #797, #798, #799, #800, #801, #802, #803, #804, #805, #806, #807, #808, #809, #810, #811, #812.

34. **Common regression log (401–425 of 1396):** #813, #814, #815, #816, #817, #818, #819, #820, #821, #822, #823, #824, #825, #826, #827, #828, #829, #830, #831, #833, #834, #835, #836, #837, #838.

35. **Common regression log (426–450 of 1396):** #839, #840, #841, #842, #843, #844, #845, #846, #847, #848, #849, #850, #851, #852, #853, #854, #855, #856, #857, #858, #859, #860, #861, #862, #863.

36. **Common regression log (451–475 of 1396):** #864, #865, #866, #867, #868, #869, #870, #871, #872, #873, #874, #875, #876, #877, #878, #879, #880, #881, #882, #883, #884, #885, #886, #887, #888.

37. **Common regression log (476–500 of 1396):** #889, #890, #891, #892, #893, #894, #895, #896, #897, #898, #899, #900, #901, #902, #903, #904, #905, #906, #907, #908, #909, #910, #911, #912, #913.

38. **Common regression log (501–525 of 1396):** #914, #915, #916, #917, #918, #919, #920, #921, #922, #923, #924, #925, #926, #927, #928, #929, #930, #931, #932, #933, #934, #935, #936, #937, #938.

39. **Common regression log (526–550 of 1396):** #939, #940, #941, #942, #943, #944, #945, #946, #947, #948, #949, #950, #951, #952, #953, #954, #955, #956, #957, #958, #959, #960, #961, #962, #963.

40. **Common regression log (551–575 of 1396):** #964, #965, #966, #967, #968, #969, #970, #971, #972, #973, #974, #975, #976, #978, #979, #980, #981, #982, #983, #984, #985, #986, #987, #988, #989.

41. **Common regression log (576–600 of 1396):** #990, #991, #992, #993, #994, #995, #996, #997, #998, #999, #1000, #1001, #1002, #1003, #1004, #1005, #1006, #1007, #1008, #1009, #1010, #1011, #1012, #1013, #1014.

42. **Common regression log (601–625 of 1396):** #1015, #1016, #1017, #1018, #1019, #1020, #1021, #1022, #1023, #1024, #1025, #1026, #1027, #1028, #1029, #1030, #1031, #1032, #1033, #1034, #1035, #1036, #1037, #1038, #1039.

43. **Common regression log (626–650 of 1396):** #1040, #1041, #1042, #1043, #1044, #1045, #1046, #1047, #1048, #1049, #1050, #1051, #1052, #1053, #1054, #1055, #1056, #1057, #1058, #1059, #1060, #1061, #1062, #1063, #1064.

44. **Common regression log (651–675 of 1396):** #1065, #1066, #1067, #1068, #1069, #1070, #1071, #1072, #1073, #1074, #1075, #1076, #1077, #1078, #1079, #1080, #1081, #1082, #1083, #1084, #1085, #1086, #1087, #1088, #1089.

45. **Common regression log (676–700 of 1396):** #1090, #1091, #1092, #1093, #1094, #1095, #1096, #1097, #1098, #1099, #1100, #1101, #1102, #1103, #1104, #1105, #1106, #1107, #1108, #1109, #1110, #1111, #1112, #1113, #1114.

46. **Common regression log (701–725 of 1396):** #1115, #1116, #1117, #1118, #1119, #1120, #1121, #1122, #1123, #1124, #1125, #1126, #1127, #1128, #1129, #1133, #1134, #1135, #1136, #1137, #1138, #1139, #1140, #1141, #1142.

47. **Common regression log (726–750 of 1396):** #1143, #1144, #1145, #1146, #1147, #1148, #1149, #1150, #1151, #1152, #1153, #1154, #1155, #1156, #1157, #1158, #1159, #1160, #1161, #1162, #1163, #1164, #1165, #1166, #1167.

48. **Common regression log (751–775 of 1396):** #1168, #1169, #1170, #1171, #1172, #1173, #1174, #1175, #1176, #1177, #1178, #1179, #1180, #1181, #1182, #1183, #1184, #1185, #1186, #1187, #1188, #1189, #1190, #1191, #1192.

49. **Common regression log (776–800 of 1396):** #1193, #1194, #1195, #1196, #1197, #1198, #1199, #1200, #1201, #1202, #1203, #1204, #1205, #1206, #1207, #1208, #1209, #1210, #1211, #1212, #1213, #1214, #1215, #1216, #1217.

50. **Common regression log (801–825 of 1396):** #1218, #1219, #1220, #1221, #1222, #1223, #1224, #1225, #1226, #1227, #1228, #1229, #1230, #1231, #1232, #1233, #1234, #1235, #1236, #1237, #1238, #1239, #1240, #1241, #1242.

51. **Common regression log (826–850 of 1396):** #1243, #1244, #1245, #1246, #1247, #1248, #1249, #1250, #1251, #1252, #1253, #1254, #1255, #1256, #1257, #1258, #1259, #1260, #1261, #1262, #1263, #1264, #1265, #1266, #1267.

52. **Common regression log (851–875 of 1396):** #1268, #1269, #1270, #1271, #1272, #1273, #1274, #1275, #1276, #1277, #1278, #1279, #1280, #1281, #1282, #1283, #1284, #1285, #1286, #1287, #1288, #1289, #1290, #1291, #1292.

53. **Common regression log (876–900 of 1396):** #1293, #1294, #1295, #1296, #1297, #1298, #1299, #1300, #1301, #1302, #1303, #1304, #1305, #1306, #1307, #1308, #1309, #1310, #1311, #1312, #1313, #1314, #1315, #1316, #1317.

54. **Common regression log (901–925 of 1396):** #1318, #1319, #1320, #1321, #1322, #1323, #1324, #1325, #1326, #1327, #1328, #1329, #1330, #1331, #1332, #1333, #1334, #1335, #1336, #1337, #1338, #1339, #1340, #1341, #1342.

55. **Common regression log (926–950 of 1396):** #1343, #1344, #1345, #1346, #1347, #1348, #1349, #1350, #1351, #1352, #1353, #1354, #1355, #1356, #1357, #1358, #1359, #1360, #1361, #1362, #1363, #1364, #1365, #1366, #1367.

56. **Common regression log (951–975 of 1396):** #1368, #1369, #1370, #1371, #1372, #1373, #1374, #1375, #1376, #1377, #1378, #1379, #1380, #1381, #1382, #1383, #1384, #1385, #1386, #1387, #1388, #1389, #1390, #1391, #1392.

57. **Common regression log (976–1000 of 1396):** #1393, #1394, #1395, #1396, #1397, #1398, #1399, #1400, #1401, #1402, #1403, #1404, #1405, #1406, #1407, #1408, #1409, #1410, #1411, #1412, #1413, #1414, #1415, #1416, #1417.

58. **Common regression log (1001–1025 of 1396):** #1418, #1419, #1420, #1421, #1422, #1423, #1424, #1425, #1426, #1427, #1428, #1429, #1430, #1431, #1432, #1433, #1434, #1435, #1436, #1437, #1438, #1439, #1440, #1441, #1442.

59. **Common regression log (1026–1050 of 1396):** #1443, #1444, #1445, #1446, #1447, #1448, #1449, #1450, #1451, #1452, #1453, #1454, #1455, #1456, #1457, #1458, #1459, #1460, #1461, #1462, #1463, #1464, #1465, #1466, #1467.

60. **Common regression log (1051–1075 of 1396):** #1468, #1469, #1470, #1471, #1472, #1473, #1474, #1475, #1476, #1477, #1478, #1479, #1480, #1481, #1482, #1483, #1484, #1485, #1486, #1487, #1488, #1489, #1490, #1491, #1492.

61. **Common regression log (1076–1100 of 1396):** #1493, #1494, #1495, #1496, #1497, #1498, #1499, #1500, #1501, #1502, #1503, #1504, #1505, #1506, #1507, #1508, #1509, #1510, #1511, #1512, #1513, #1514, #1515, #1516, #1517.

62. **Common regression log (1101–1125 of 1396):** #1518, #1519, #1520, #1521, #1522, #1523, #1524, #1525, #1526, #1527, #1528, #1529, #1530, #1531, #1532, #1533, #1534, #1535, #1536, #1537, #1538, #1539, #1540, #1541, #1542.

63. **Common regression log (1126–1150 of 1396):** #1543, #1544, #1545, #1546, #1547, #1548, #1549, #1550, #1551, #1552, #1553, #1554, #1555, #1556, #1557, #1558, #1559, #1560, #1561, #1562, #1563, #1564, #1565, #1566, #1567.

64. **Common regression log (1151–1175 of 1396):** #1568, #1569, #1570, #1571, #1572, #1573, #1574, #1575, #1576, #1577, #1578, #1579, #1580, #1581, #1582, #1583, #1584, #1585, #1586, #1587, #1588, #1589, #1590, #1591, #1592.

65. **Common regression log (1176–1200 of 1396):** #1593, #1594, #1595, #1596, #1597, #1598, #1599, #1600, #1601, #1602, #1603, #1604, #1605, #1606, #1607, #1608, #1609, #1610, #1611, #1612, #1613, #1614, #1615, #1616, #1617.

66. **Common regression log (1201–1225 of 1396):** #1618, #1619, #1620, #1621, #1622, #1623, #1624, #1625, #1626, #1627, #1628, #1629, #1630, #1631, #1632, #1633, #1634, #1635, #1636, #1637, #1638, #1639, #1640, #1641, #1642.

67. **Common regression log (1226–1250 of 1396):** #1643, #1644, #1645, #1646, #1647, #1648, #1649, #1650, #1651, #1652, #1653, #1654, #1655, #1656, #1657, #1658, #1659, #1660, #1661, #1662, #1663, #1664, #1665, #1666, #1667.

68. **Common regression log (1251–1275 of 1396):** #1668, #1669, #1670, #1671, #1672, #1673, #1674, #1675, #1676, #1677, #1678, #1679, #1680, #1681, #1682, #1683, #1684, #1685, #1686, #1687, #1688, #1689, #1690, #1691, #1692.

69. **Common regression log (1276–1300 of 1396):** #1693, #1694, #1695, #1696, #1697, #1698, #1699, #1700, #1701, #1702, #1703, #1704, #1705, #1706, #1707, #1708, #1709, #1710, #1711, #1712, #1713, #1714, #1715, #1716, #1717.

70. **Common regression log (1301–1325 of 1396):** #1718, #1719, #1720, #1721, #1722, #1723, #1724, #1725, #1726, #1727, #1728, #1729, #1730, #1731, #1732, #1733, #1734, #1735, #1736, #1737, #1738, #1739, #1740, #1741, #1742.

71. **Common regression log (1326–1350 of 1396):** #1743, #1744, #1745, #1746, #1747, #1748, #1749, #1750, #1751, #1752, #1753, #1754, #1755, #1756, #1757, #1758, #1759, #1760, #1761, #1762, #1763, #1764, #1765, #1766, #1767.

72. **Common regression log (1351–1375 of 1396):** #1768, #1769, #1770, #1771, #1772, #1773, #1774, #1775, #1776, #1777, #1778, #1779, #1781, #1782, #1783, #1784, #1785, #1786, #1787, #1788, #1789, #1790, #1791, #1792, #1793.

73. **Common regression log (1376–1396 of 1396):** #1794, #1795, #1796, #1797, #1798, #1799, #1800, #1801, #1802, #1803, #1804, #1805, #1806, #1807, #1808, #1809, #1810, #1811, #1812, #1814, #1815.

