**ANSWER FIRST — BUG-1102 — DONE**

1. **Build result:** draft PR [#1810](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1810). Built and unit-tested only. Not installed or checked in AutoCAD.
2. **What Tim will see:** CDWT previously accepted AboveGround silently on a Banyule job. It now prints: `[CE] Banyule requires 100 per cent of detention underground; the share above ground is 100 per cent.` The command-line route adds “This applies if the tank holds detention”, because that answer comes before the litres. The drafter can continue.
3. **Heads:** branch `cx6/bug-1102-bd23` at `46fc6968540092648407e10fbe9b0f385b08c981`. Base used: `claude/rel-20261026u` at `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`. The other release head checked was `claude/rel-20261026t` at `d3f9c5dfc6241815d587f335a7ae49ca603c58fa`. The final fetch found both release heads unchanged, so no merge was needed.
4. **Red and green:** red ran 5 tests: 2 failed, 3 passed. Final green ran 12 tests: 12 passed, 0 failed. The three required names are `DetentionLocation_Bug1102_BanyuleAboveGround_WarnsCouncilWants100Underground`, `DetentionLocation_Bug1102_GlenEira50Percent_NoWarningAtHalfAbove` and `DetentionLocation_Bug1102_CouncilWithNoRule_NoWarning`.
5. **Full Civil suite — console summary:** untouched base: **20,539 total; 20,505 passed; 2 failed; 32 skipped**. After: **20551 total; 20517 passed; 2 failed; 32 skipped**. The failing names are identical to the untouched base; there is no new failure.
6. **Exact real-AutoCAD check — NOT RUN:** on a Banyule test copy, run CDWT and answer AboveGround. Expect the [CE] line in item 2 naming Banyule, 100 per cent underground and 100 per cent above ground. AboveGround must remain available and remain the default. If the tank window opens, choose Above ground with detention, then continue; expect the same council warning before placement.
7. **Known limits:** the default deliberately stays AboveGround, including for a council asking for 100 per cent underground. Tank records do not retain the above-ground/underground answer, so CDDESIGN cannot measure the actual share: it now names the stored council requirement and says “the share above ground is not recorded. Check the detention location.” It does not claim an exceedance was measured.
8. **Settings limit:** the new row, beside the existing switches, measured **689 px in both themes**, over the **673 px** limit. The brief says to report this instead of squeezing. All window changes were removed. The stored switch ships ON; no Settings-window row ships. No new pictures are committed because no window change remains.
9. **Not run:** AutoCAD, the live tank or Settings window, a real drawing, Tim’s real settings file, or a native C++/ARX build. No deployment. Existing off-screen window checks are part of the full suite; the rejected row’s height check was also run off-screen.
10. **Overlapping open PRs:** [#1807 — BUG-1115](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1807) and [#1808 — BUG-1174](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1808) both change `WaterTankCommand.cs`, `UserSettings.cs` and `REGRESSION_LOG.md`. Both were verified as drafts. Open [#1721](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1721) also changes `WaterTankCommand.cs`. These files overlap; no other PR was merged.

---

11. **Red proof, product unchanged:** only the new test file was added after the untouched-base run. The missing warning returned null; the real CDDESIGN run also lacked the requirement line. Before the new warning method existed, the test’s temporary bridge represented its absence as silence; the final tests call the production method directly.

```text
Failed DetentionLocation_Bug1102_BanyuleAboveGround_WarnsCouncilWants100Underground [98 ms]
Expected: "Banyule requires 100 per cent of detention underground; the share above ground is 100 per cent."
But was: null
Failed DetentionLocation_Bug1102_DesignSaysTheCouncilRule_WhenLocationIsNotRecorded [96 ms]
Total tests: 5; Passed: 3; Failed: 2
```

12. **Green proof:**

```text
Passed DetentionLocation_Bug1102_BanyuleAboveGround_WarnsCouncilWants100Underground [2 s]
Passed DetentionLocation_Bug1102_CouncilWithNoRule_NoWarning [568 ms]
Passed DetentionLocation_Bug1102_GlenEira50Percent_NoWarningAtHalfAbove [88 ms]
Passed DetentionLocation_Bug1102_UndergroundControl_QuietInsideEveryCouncilLimit [316 ms]
Test Run Successful.
Total tests: 12
Passed: 12
```

13. **Coverage:** the normal control is underground detention inside every council limit, quiet both before and after. Other checks cover just over Glen Eira’s allowance, a changed in-memory council value, default ON, an older file loading ON, typed OFF retained through the production reader, JSON round-trip, another Settings row preserving that OFF value, OFF restoring the previous design lines and identical calculation summary, no-detention designs, and placement still available. New tests use in-memory settings and an intercepted save candidate; they write no settings file.
14. **One warning rule:** `WaterTankSelection.DetentionLocationWarning` reads `CouncilProfileService.GetById` and the existing `MinUndergroundPct` field. CDWT and CDDESIGN both call it. Nothing copies the council percentages or changes a council profile, calculation value, library size or engineering limit. The field `detention.detentionUndergroundShareWarning` defaults to true and documents ON/OFF. Its optional argument lets tests override it without a real settings file.
15. **Drawing safety:** the added code writes nothing to a drawing. It reads the already-open project’s council, reads settings/profile values, returns words and prints them. It adds no drawing record, transaction, placement, save or undo call. Cancelled choices return before the new CDWT warning. Existing drawing writes and locked-layer, Xref, REFEDIT, Undo/REDO and placement checks were not changed or natively tested.
16. **Protected files:** no CE_SHARED source, Structural source, protected command, save/undo handler, C7 object/overrule, tidy-up/placement service, split code, palette, or protected editing window was changed. The final product diff is four files: `Commands/WaterTankCommand.cs` (9 added lines), `Models/UserSettings.cs`, `Rules/WaterTankSelection.cs` and `Services/CivilDesignService.cs`. The one new test file is `Modules/Drainage.Tests/Rules/Bug1102DetentionLocationTests.cs`.
17. **Builds:** Release net48, net8.0-windows and net10.0-windows each finished with **0 errors**. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and all three reference arguments below. Nothing was written to ApplicationPlugins or ProgramData by this work.

```text
-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
-p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
-p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

18. **Test commands and environment:** project `C:\ce-cx\bd23\Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj`, framework `net10.0-windows`, Release. Red and green used `--filter "FullyQualifiedName~Bug1102"`. Full before/after used no filter. The after run used `--no-build --no-restore` on the assembly just built and checked. AutoCAD 2027 was on the test process PATH; AutoCAD was never started.
19. **Native placeholder:** the first untouched-base build stopped with MSB3030 because `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx` was absent. As allowed by the brief, a zero-byte test-only placeholder was created at that ignored build-output path. The untouched-source full suite was then run. The placeholder is not committed or deployed; this does not test native ARX behaviour.
20. **Baseline failures and cleanup:** `Diagnostic_MessagesReachTheLogFile` and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`. Baseline also printed a `SettingsIsolationSetup` teardown error: `CE_CVL_SUITE.log` was in use. The after run printed the same cleanup error. The headline totals are the CLI summaries. The saved TRX totals are 20,567 before and 20,579 after, with 60 NotExecuted result rows in each file; the console reports 32 skipped in each. Passed and failed counts agree. Both formats show exactly 12 added passes; no excluded case is claimed as tested.
21. **Row-fit evidence:** the rejected dark and light tests both printed `Expected: less than or equal to 673; But was: 689.0d`. The untouched base and final full-suite Settings markup checks both measured 670 px. No fonts, spacing, tabs or scroll areas were squeezed to fit the extra row. The persistence sibling named in the brief lives under `ViewModels/Bj32SettingsPersistenceTests.cs` in this base.
22. **Other shared Settings-file overlap:** the newest-400-open-PR file snapshot also found `UserSettings.cs` in the following open PRs. This is a bounded snapshot, not a claim that older open PRs cannot overlap. #1807 and #1808 were checked live separately after that snapshot.

```text
#1806, #1805, #1804, #1803, #1801, #1798, #1791, #1790, #1789, #1787, #1786, #1785, #1784, #1783, #1782, #1779, #1778, #1776
#1775, #1773, #1772, #1770, #1767, #1765, #1764, #1763, #1760, #1758, #1757, #1756, #1755, #1754, #1753, #1735, #1734, #1722
#1669, #1664, #1659, #1658, #1655, #1643, #1642, #1641, #1640, #1631, #1630, #1629, #1628, #1627, #1622, #1617, #1612, #1611
#1595, #1594, #1591, #1586, #1576, #1570, #1567, #1562, #1558, #1557, #1556, #1553, #1552, #1540, #1538, #1537, #1531, #1528
#1516, #1507, #1484, #1483, #1482, #1480, #1479, #1477, #1475, #1474, #1447, #1438, #1437, #1435, #1434, #1433, #1432, #1431
#1430, #1429, #1428, #1427, #1426, #1425, #1424, #1423, #1422, #1421, #1420, #1419, #1417, #1416, #1415, #1413, #1412, #1411
#1410, #1409, #1408, #1407
```

23. **Evidence on this PC:** `C:\ce-cx\bd23-evidence\bug1102-base.trx`, `bug1102-red.trx`, `bug1102-green.trx`, `bug1102-after.trx` and the rejected `bug1102-row-fit.trx`. Logs are outside the code worktree and are not pushed. The report is the only file staged from CE_PLAN.
24. **Undo and acceptance:** revert the BUG-1102 warning commit to restore the older behaviour. Nothing was installed. The bug carpark, desk log and queue were not edited; no acceptance claim is made. The remaining native check is item 6.

