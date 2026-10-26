ANSWER FIRST — BUG-1044 — DONE

1. **Draft:** [PR #1816](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1816), OPEN and DRAFT, against `claude/rel-20261026u`. Branch `cx6/bug-1044-bd30`; head `d38ca6ed75c9fe33682444fc06c678083d48e95c`. Built and unit-tested only. No installation or AutoCAD acceptance is claimed.
2. **Both release heads:** fetched u = `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1` (the base used); fetched t = `d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. The last fetch found both unchanged. Master was never used. Builds and tests checked code commit `6964335189964631e3edb8ab605713c360b29eb0`; the final commit changes only REGRESSION_LOG.md.
3. **What Tim will see:** before, A (P1/P2) and B (P1/P3) produced an empty schedule and stopped Continue to Place. After, A/P2 and B/P3 remain available. Data check says `[CE] Pit P1 appears in A and B. Rename it in a source drawing. This number is left out of the schedule.` Continue to Place stays available for P2/P3. Neither original P1 nor any spine ID is renamed, merged or overwritten.
4. **The brief's wording:** this implements its later, specific instruction to keep non-clashing pits and leave the clashing number unavailable for placement. It gives TWO placeable rows plus the P1 notice. The live carpark's earlier FOUR-row wording is different; that variant is not claimed here.
5. **Red first:** product unchanged at test-only commit `fd124d9f`. Three requested tests ran: two failed, one passed. Actual console lines:

```text
  Failed PitScheduleSources_Bug1044_ClashingPitIsNeverMergedOrOverwritten [113 ms]
  Missing:  < "P2", ... >
  Passed PitScheduleSources_Bug1044_NoClash_Unchanged [55 ms]
  Failed PitScheduleSources_Bug1044_TwoDrawingsBothHaveP1_ShowsNonClashingPitsAndNamesTheClash [1 ms]
  Missing:  < "P2", ... >
Total tests: 3
     Passed: 1
     Failed: 2
```

6. **Green:** the final exact BUG-1044 filter ran 15 tests, all passed. These include all three requested names, default/older-file/typed-OFF/round-trip checks, a normal-job ON/OFF control, source-record checks, edge cases and two compiled-window renders. Actual lines:

```text
  Passed PitScheduleSources_Bug1044_ClashingPitIsNeverMergedOrOverwritten [119 ms]
  Passed PitScheduleSources_Bug1044_NoClash_Unchanged [5 ms]
  Passed PitScheduleSources_Bug1044_TwoDrawingsBothHaveP1_ShowsNonClashingPitsAndNamesTheClash [4 ms]
Test Run Successful.
Total tests: 15
     Passed: 15
```

7. **Complete Civil totals:** before: 20,539 total, 20,497 passed, 10 failed, 32 skipped. After: 20,554 total, 20,514 passed, 8 failed, 32 skipped. All eight failing names also failed on the base; no new failing name. The 15 added cases account for the total increase. The corrected Settings-window and neighbouring Xref selection checks also pass 145/145.
8. **Builds:** the corrected version built net48, net8.0-windows and net10.0-windows with 0 errors each. Every build and test used SkipDevBundle=true, node reuse off, disabled build servers and all three prescribed AutoCAD reference paths. No deployment occurred.
9. **Switch and its limit:** `linking.xrefScheduleKeepsNonClashingRows` ships ON, and missing keys in older settings load ON. A typed false is kept and restores the older empty schedule and wording exactly. No Settings row is supplied: my attempted row made the whole editor 689 px, above its existing 670 px limit and the brief's 673 px limit. As the brief permits, I omitted it rather than squeezing the window. Both themes now measure 670 px. The saved switch is tested in memory only; Tim's settings files were not touched.
10. **Exact real-AutoCAD check, NOT RUN:** in a host copy, attach synthetic A (P1/P2) and B (P1/P3). Run PITSCHEDULE > Source > Drainage XREFs, tick both. Expect TWO placeable rows, A/P2 and B/P3, one P1 notice naming A and B under Data check, and Continue to Place available. Place only P2/P3 in the host copy; confirm both sources still contain their original P1 and their IDs. This is the brief's non-clashing placement variant, not a four-row claim.
11. **Not run:** AutoCAD was not started; no real AutoCAD window, live Xref/stage DWG file, native placement, U/REDO, Cancel or Escape drawing session was exercised. No installation, live settings change or drawing acceptance is claimed. The 24 pictures are compiled WPF windows rendered off-screen only, in dark and light at 1080p scale 1; all were inspected.
12. **Other limits and overlap:** the existing Warnings badge counts row warnings, so it can show 0 while Data check names the clash. If every pit clashes, there is naturally no row to place. [PR #1767](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1767) and BUG-1155 were read before editing; discovery/status work is untouched. #1767 overlaps the settings model only; #1765 overlaps the Data file elsewhere. Detailed open-PR file numbers follow below. The common regression log keeps all base entries.

---

1. **Scope and code proof:** only two product source files differ from the base: `Modules/Drainage/Models/UserSettings.cs` and `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs`. The saved boolean is beside the existing Xref schedule switch, defaults true and has `/// Default: on.`. The existing `FindDuplicatePitNumbers` remains the sole duplicate-number authority. Its case-insensitive, trimmed pit numbers filter the existing `AppendExternalSourceRows` path before any inlet rows are built. The existing drawing-qualified identities and grouping remain in use. No engineering value was chosen or changed. Pit Schedule XAML and both Settings layouts are unchanged.
2. **Read-only drawing proof:** `PitScheduleXrefDiscoveryService.cs:268-339` reads source path/record data using ForRead for the block record, dictionaries and Xrecord. The modified loader only reads the selected source snapshots and fills schedule rows. Its row-builder calls retain `updateProjectData:false` (Data.cs:817,823); `_isLoadingRows` guards row loading, and the external-row guard returns before write-through (Data.cs:1210,1228). The source-record test serialises both sources before/after and asserts equality, separate P1 objects and separate qualified handle identities. Existing placement code was neither edited nor invoked. This change adds no drawing write, including none between U and REDO. Native locked-layer/Xref/REFEDIT/Cancel/Escape behaviour was not exercised or newly certified.
3. **Protected source:** CE_SHARED source, Structural, edit/new-pit windows and view models, PipeEditCommand*, PitEditCommand*, PitCommand*, LinkService*, save/undo handlers, C7 pipe objects/overrules, tidy-up/placement services, CDBREAK/PIT split and the CE Blocks palette are unchanged. No new command, engineering rule, layout or number was added. New drafter notices start `[CE]`. Data and screenshots use synthetic A/B and Example Job data.
4. **Test location:** `Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj`; new `Services/Bug1044PitScheduleSourcesTests.cs` and `Dialogs/Bug1044PitScheduleRenderTests.cs`. The existing outlet-size source guard's expected row-builder call is updated for its extra argument. The three required tests are shown above. Additional checks cover fresh settings, `{}`, empty linking settings, typed OFF, both in-memory round trips, exact OFF wording, the no-clash ON/OFF control, multiple clashes, case/padding, excluded pits, all-clashing pits and deselecting B to recover P1. Render tests assert the named tab is selected, the full P1 notice is shown, no settings file is created, and the whole Settings editor remains within its unchanged 670 px limit. No existing limit/check was weakened.
5. **Sibling checks read:** Bug1097ChargedMinimumHeadTests, Bj32CivilSettingsRowsTests, Bj32SettingsPersistenceTests and RelinkKeepsRecordedDirectionTests. The new switch has the same default-on, old-file, explicit-OFF and round-trip coverage, performed in memory through SettingsService.DeserializeSettings. With no new window row, no draft/search/reset/save registration is added. The existing Settings save makes a detached copy of the full settings before changing tracked rows (`AdvancedSettingsViewModel.cs:1655`), rather than reconstructing the linking group and discarding this saved key.
6. **Correction owned:** the first after run reported 20,556 total, 20,510 passed, 14 failed, 32 skipped. Six were new failures from my attempted Settings row: the tracked-value contract and five whole-window height checks (689 px > 670 px). My first render checked the page content (448 px), not the whole editor. I removed the row, its draft plumbing and two row-only cases, restored the original contracts, added the whole-window assertion, rebuilt all three targets and repeated the entire suite. The final totals above supersede that unsuccessful attempt; no unrelated failure was altered.
7. **Baseline selection:** the valid untouched-base run completed before the first test/product edit and used NUnit.NumberOfTestWorkers=0; the final full run used the same. The runner selected every non-explicit case. There are 28 normally excluded explicit cases in addition to the console totals; the TRX discovered totals are therefore 20,567 before and 20,582 after. Progress log counts include explicit skipped entries; the final selected-case skipped total is 32 in both runs. Base duration: 1.2022 hours. Final duration: 12.7913 minutes. Earlier incomplete attempts are not counted as results.
8. **Reference setup:** the fresh worktree initially failed to copy the absent native placeholder. I created only the ignored zero-byte `C:\ce-cx\bd30\Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx` required for the test build, and prefixed process PATH with `C:\Program Files\Autodesk\AutoCAD 2027`. Nothing was copied to ApplicationPlugins or ProgramData. Default-worker baseline attempts stalled; the complete comparison uses the documented NUnit zero-worker mode, with no test filter and no hidden failures. No placeholder is a claim of real AutoCAD operation.
9. **Commands:** all project paths were absolute, Release, with the following common arguments. The red and final green runs added exactly `--filter "FullyQualifiedName~Bug1044"`. Full runs had no filter, console/TRX logging, `--blame-hang-timeout 3m --blame-hang-dump-type mini` and `-- NUnit.NumberOfTestWorkers=0`. Rendering updates were enabled only for the picture run, disabled for the final full/filter runs. Incidental legacy picture updates from the wider render check were restored; only bug1044-prefixed pictures are committed.

```text
dotnet build C:\ce-cx\bd30\Modules\Drainage\CE_CVL_SUITE.csproj -f <net48|net8.0-windows|net10.0-windows> -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref" -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
dotnet test C:\ce-cx\bd30\Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref" -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

10. **Evidence files, outside the removable worktree:** `C:\ce-cx\bd30-base-sequential.log`, `C:\ce-cx\bd30-red.log`, `C:\ce-cx\bd30-final-green.log`, `C:\ce-cx\bd30-fit-recheck.log`, `C:\ce-cx\bd30-final-after.log`; matching TRX files in `C:\ce-cx\evidence-bd30` and `bd30-failure-comparison.json`. Corrected build logs are `C:\ce-cx\bd30-final-build-net48.log` (242 warnings, 0 errors), `bd30-final-build-net8.0-windows.log` (216 warnings, 0 errors), and `bd30-final-build-net10.0-windows.log` (214 warnings, 0 errors). All three exits were 0. Raw logs/dumps/contact sheets were not committed.
11. **Base failures, exact names:**

```text
CE_CVL_SUITE.Tests.Dialogs.StandardsWindowTests.PartsSaveIncludesRowsBeyondTheViewportAndCancelLeavesSavedPartsAlone
CE_CVL_SUITE.Tests.Rules.ScaledPitRecordTests.Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce
CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_DoesNotChangeTheStoredCatalogue
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_DoesNotWriteToDisk
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_ReturnsIndependentCopies
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheFileCannotBeWritten_ReportsFailureWithAReason
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheWriteFails_LeavesTheStoredCatalogueUnchanged
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheWriteSucceeds_ReportsSuccessAndNoError
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueViewModelTests.SaveCommand_Execute_RaisesRequestCloseWithTrue
```

12. **Final failures, exact names:**

```text
CE_CVL_SUITE.Tests.Dialogs.StandardsWindowTests.PartsSaveIncludesRowsBeyondTheViewportAndCancelLeavesSavedPartsAlone
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_DoesNotChangeTheStoredCatalogue
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_DoesNotWriteToDisk
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.GetDefaults_ReturnsIndependentCopies
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheFileCannotBeWritten_ReportsFailureWithAReason
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheWriteFails_LeavesTheStoredCatalogueUnchanged
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueSaveResetTests.TryReplace_WhenTheWriteSucceeds_ReportsSuccessAndNoError
CE_CVL_SUITE.Tests.ViewModels.PartsCatalogueViewModelTests.SaveCommand_Execute_RaisesRequestCloseWithTrue
```

13. **Base failures that passed in the final run:**

```text
CE_CVL_SUITE.Tests.Rules.ScaledPitRecordTests.Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce
CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile
```

14. **Open PR inventory:** 1,406 open PRs were fetched with gh's number/title/files fields. The numbers below exclude this PR and mean file overlap, not a claim that every old open PR has changes still absent from the release. Raw inventory: C:\ce-cx\bd30-open-prs-final.json. REGRESSION_LOG.md is a shared append-only merge surface: all original base entries remain after the new top entry, and later merges must retain both sides.

15. **Modules/Drainage/Models/UserSettings.cs:** 56, 372, 383, 389, 390, 396, 398, 401, 406, 426, 435, 452, 475, 556, 642, 643, 680, 682, 694, 699, 703, 705, 707, 731, 772, 773, 785, 790, 791, 800, 805, 822, 828, 833, 834, 835, 836, 838, 839, 840, 841, 842, 844, 847, 849, 850, 853, 855, 888, 891, 892, 900, 901, 903, 905, 910, 911, 916, 917, 926, 928, 931, 932, 948, 950, 953, 954, 958, 959, 960, 969, 970, 972, 974, 976, 992, 996, 997, 998, 1003, 1009, 1010, 1017, 1019, 1021, 1023, 1025, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1036, 1038, 1040, 1054, 1061, 1069, 1070, 1073, 1086, 1089, 1141, 1143, 1144, 1145, 1147, 1150, 1151, 1152, 1153, 1155, 1156, 1158, 1159, 1160, 1161, 1163, 1167, 1171, 1173, 1176, 1181, 1183, 1185, 1187, 1188, 1196, 1199, 1218, 1219, 1221, 1222, 1223, 1224, 1280, 1281, 1286, 1289, 1290, 1291, 1292, 1293, 1299, 1301, 1302, 1308, 1309, 1313, 1314, 1315, 1317, 1322, 1328, 1335, 1337, 1352, 1358, 1361, 1363, 1365, 1366, 1367, 1368, 1369, 1371, 1374, 1375, 1379, 1380, 1401, 1402, 1403, 1404, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1415, 1416, 1417, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1437, 1438, 1447, 1474, 1475, 1477, 1479, 1480, 1482, 1483, 1484, 1507, 1516, 1528, 1531, 1537, 1538, 1540, 1552, 1553, 1556, 1557, 1558, 1562, 1567, 1570, 1576, 1586, 1591, 1594, 1595, 1611, 1612, 1617, 1622, 1627, 1628, 1629, 1630, 1631, 1640, 1641, 1642, 1643, 1655, 1658, 1659, 1664, 1669, 1722, 1734, 1735, 1753, 1754, 1755, 1756, 1757, 1758, 1760, 1763, 1764, 1765, 1767, 1770, 1772, 1773, 1775, 1776, 1778, 1779, 1782, 1783, 1784, 1785, 1786, 1787, 1789, 1790, 1791, 1798, 1801, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814, 1815, 1817.

16. **Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:** 362, 384, 489, 540, 548, 584, 589, 604, 637, 641, 643, 658, 681, 723, 740, 763, 766, 786, 805, 807, 817, 829, 885, 912, 914, 948, 954, 1192, 1402, 1415, 1422, 1423, 1431, 1531, 1552, 1553, 1556, 1557, 1558, 1562, 1567, 1570, 1586, 1591, 1594, 1595, 1611, 1612, 1617, 1660, 1765.

17. **Modules/Drainage.Tests/Services/PitScheduleOutletSizeCheckTests.cs:** 1431.

18. **Modules/Drainage.Tests/Services/Bug1044PitScheduleSourcesTests.cs:** none.

19. **Modules/Drainage.Tests/Dialogs/Bug1044PitScheduleRenderTests.cs:** none.

20. **How the named work merges:** #1767 is BUG-1149, the notice after BIND. Its discovery/source-status path is unchanged; retain both independent settings keys. #1765's source-fingerprint changes are elsewhere in the Data file; retain its identity handling and this loader filter. BUG-1155's live recreated-Xref-source entry was read; the required exact open-PR search found no PR naming it. This branch does not change discovery or replace source identities. Common log entries must be combined, never replaced. No other PR was merged into this branch.
21. **Pictures:** all 24 files below are committed and listed in draft PR #1816. They use the existing real compiled Settings and Pit Schedule windows, themes, fixed footers and bounded lists; no new look was invented. The latest no-checkbox Settings pages and both Source-warning pictures were visually inspected. The first-placement Changes page correctly says there are no schedule changes to review. These are off-screen captures, not AutoCAD screenshots.
1. **bug1044-pitschedule-dark-changes.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-dark-changes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-dark-changes.png).

2. **bug1044-pitschedule-dark-placement.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-dark-placement.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-dark-placement.png).

3. **bug1044-pitschedule-dark-rows.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-dark-rows.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-dark-rows.png).

4. **bug1044-pitschedule-dark-source.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-dark-source.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-dark-source.png).

5. **bug1044-pitschedule-light-changes.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-light-changes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-light-changes.png).

6. **bug1044-pitschedule-light-placement.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-light-placement.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-light-placement.png).

7. **bug1044-pitschedule-light-rows.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-light-rows.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-light-rows.png).

8. **bug1044-pitschedule-light-source.png:** [docs/image/V3_WINDOWS/bug1044-pitschedule-light-source.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-pitschedule-light-source.png).

9. **bug1044-settings-dark-advanced.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-advanced.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-advanced.png).

10. **bug1044-settings-dark-design.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-design.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-design.png).

11. **bug1044-settings-dark-display.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-display.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-display.png).

12. **bug1044-settings-dark-drafting.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-drafting.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-drafting.png).

13. **bug1044-settings-dark-fixes.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-fixes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-fixes.png).

14. **bug1044-settings-dark-newer-tools.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-newer-tools.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-newer-tools.png).

15. **bug1044-settings-dark-pipes-pits.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-pipes-pits.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-pipes-pits.png).

16. **bug1044-settings-dark-survey.png:** [docs/image/V3_WINDOWS/bug1044-settings-dark-survey.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-dark-survey.png).

17. **bug1044-settings-light-advanced.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-advanced.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-advanced.png).

18. **bug1044-settings-light-design.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-design.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-design.png).

19. **bug1044-settings-light-display.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-display.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-display.png).

20. **bug1044-settings-light-drafting.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-drafting.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-drafting.png).

21. **bug1044-settings-light-fixes.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-fixes.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-fixes.png).

22. **bug1044-settings-light-newer-tools.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-newer-tools.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-newer-tools.png).

23. **bug1044-settings-light-pipes-pits.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-pipes-pits.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-pipes-pits.png).

24. **bug1044-settings-light-survey.png:** [docs/image/V3_WINDOWS/bug1044-settings-light-survey.png](https://github.com/timbrand92/CE_ACAD_PLUGIN/blob/cx6/bug-1044-bd30/docs/image/V3_WINDOWS/bug1044-settings-light-survey.png).

---

1. **Delivery:** branch and draft PR remain open; no merge, rebase, force-push, ready-for-review change or branch deletion. All four branch commit messages name BUG-1044. The latest release merge was already up to date. Leak scans on branch pushes passed. This report is saved and pushed by its own name only; no carpark, desk log, queue or unrelated plan file was staged.
2. **Cleanup:** after confirming both pushes and clean status, I verified the absolute path, branch and head, then removed only this job's `C:\ce-cx\bd30` worktree with git worktree remove. The path is absent and the branch remains at d38ca6ed75c9fe33682444fc06c678083d48e95c. The draft PR, committed pictures and outside evidence remain available. No other working copy was removed.
3. **Undo and remaining check:** a saved false for this switch restores the older behaviour (proved in memory); reverting the BUG-1044 branch removes the change. Nothing was installed, so no live rollback is needed. The real-AutoCAD copy check in answer item 10 remains owed, not claimed as passed.

4. **Recorded:** 27 October 2026 04:25 AEDT (Melbourne). Initial C: free space was 40.86 GB, above the 8 GB stop limit. Live BUG-1044 was OPEN and the exact open-PR search found no existing fix before work began.
