# Train C-45 assembly report (Civil + Manager), Mon 19 Oct 2026 (finished about 06:55, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261019a`, pushed. Head `0c9b0f21319f6950710b39f9840f2d9f45adbf9b` (unchanged by this run; local equals origin). Base `origin/claude/rel-20261018d` @ `70a4e24f`.
2. **Merged:** 50 PRs (50 first-parent merge commits): every number from #1387 to #1438 except #1419 and #1423. Every merged head equals the live PR head (checked again today at 06:17).
3. **Left out:** #1419 (Opus HOLD: CDREBUILD can give two pits one number), #1423 (Opus HOLD: typed cover lands on the wrong row), and the Structural PRs #1382 to #1386 (not in this train; #1382 LBUH is parked to Thu 29 Oct, #1384 SBEAM is held until Tim's design card exists). None of them is in the branch (checked by ancestry). **No excluded PR was merged by mistake, so no revert was needed.** Also not merged, other bases or duplicates: #1339 to #1341, #1381.
4. **Build:** whole solution Release, **0 errors**, 69 warnings (the C-44 count of 885 came from a full rebuild; this run reused compiled files from the first attempt, so the count is not comparable).
5. **Tests:** Civil net10 Release: **18,799 run, 18,780 pass, 19 skipped, 1 failed** (the known Glen Eira). Manager net10: **757 of 757**. Civil net48 focused: 1,351 run, 1,326 pass, 7 skipped, **18 failed, all `InvalidProgramException`** (the net48 reference-stub trap, not real reds; the same tests pass on net10).
6. **For the finalizer:** (a) three PRs numbered above #1435 were merged and were NOT reviewed by Opus: **#1436 `61d2939b`, #1437 `c807cd0e`, #1438 `91839312`**. Review these first. (b) The 18 net48 stub-lane tests need the C-44 treatment if the net48 run is part of the gate. (c) Nothing was installed, deployed, version-bumped or opened in AutoCAD: built and unit-tested only.

## 1. What happened

1. The first run (02:30 to 02:47) merged all 50 and pushed, then stopped without building. This run checked that state, built and tested in the foreground, and wrote this report.
2. **State checks done:** the worktree `C:\ce-asm\c45` was present, clean, on the branch and equal to origin. The merge list was compared with the rules: no #1382 to #1386, no #1419, no #1423. For every merge the second parent was compared with the live PR head: no difference. Files changed against the base: only Drainage, Drainage.Tests, the five Manager files of #1388 and #1389 (plus their two Manager test files), and `REGRESSION_LOG.md`. **Nothing under Shared changed, so CE_SHARED stays byte-identical between Civil and Manager.**
3. **Verdict check:** every PR merged with a MERGE-WITH-FIXES verdict has a live head newer than the head named in its review entry, and that live head is the one merged. The three red tests of the Opus trial merge (entry 1263) did not come back (section 4.2).
4. **Merge order note:** the first run merged in a different order from entry 1221/1265 (small ones first, the #1387 to #1389 stack in order). The result is the same set; the build and the full suite are the proof that the order did not matter.

## 2. Merges, oldest first (second parent = PR head used)

1. #1398 `ac6f65ea`
2. #1399 `8cb019a2`
3. #1390 `f6edcefb`
4. #1397 `6564720a`
5. #1405 `45d28706`
6. #1392 `1eb259ee`
7. #1391 `44d09925`
8. #1393 `aee03e91`
9. #1394 `4c0f1623`
10. #1396 `19087119`
11. #1395 `bac91c60`
12. #1387 `22921387`
13. #1388 `df7d2a5a`
14. #1389 `2f855c9c`
15. #1400 `2af9cee9`
16. #1403 `d321f4fd`
17. #1404 `9df157f9`
18. #1409 `1be523c1`
19. #1402 `5797f60f`
20. #1401 `c3fe83f7`
21. #1406 `d39a8a75`
22. #1407 `5feab4a3`
23. #1408 `69cab722`
24. #1414 `a792cf4b`
25. #1418 `80683e8c`
26. #1430 `46918bbd`
27. #1416 `d8e9ef17`
28. #1417 `c9a1b94d`
29. #1433 `805e5492`
30. #1421 `6177130e`
31. #1427 `9a0024b3`
32. #1424 `920e7160`
33. #1412 `28996088`
34. #1410 `375a1e62`
35. #1426 `cb5e822b`
36. #1413 `8e2b711b`
37. #1420 `de92add1`
38. #1422 `54e205dd`
39. #1415 `53de7571`
40. #1425 `e1a91fb5`
41. #1431 `0d01029b`
42. #1411 `17609231`
43. #1432 `846c5485`
44. #1428 `159fd909`
45. #1429 `8a39c193`
46. #1434 `b26a8ef3`
47. #1435 `28c1db7e`
48. #1437 `c807cd0e` (new, above #1435, not reviewed by Opus)
49. #1436 `61d2939b` (new, above #1435, not reviewed by Opus)
50. #1438 `91839312` (new, above #1435, not reviewed by Opus)

**Note on #1437:** it is stacked on #1435 and was merged after it; #1435 was reviewed (entry 1247, MERGE-WITH-FIXES) and its live head is the one merged.

## 3. Build

1. Whole `CE_ACAD_PLUGIN.slnx` Release, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs` (`_AcadRef48`), net8 refs from `C:\TimOS\refs\autocad\autocad-2026-ref` (`_AcadRefNet8`), net10 off the AutoCAD 2027 install. **0 errors.** Last run 2 min 48 s.
2. **Trap met on the way:** the Installer.Tests project runs `git` by name through `cmd` and failed with 9009 in the child shell used here (three runs of 1.5 to 3 minutes each). Passing `-p:GitExecutable="C:\Program Files\Git\cmd\git.exe"` fixed it. Not a code problem.
3. The build lock folder was taken only while each command ran and released after each.

## 4. Tests (net10, AutoCAD 2027 on PATH, `--no-build`, Release only, foreground)

1. **Civil net10, in three parts (each under 5 minutes):**
   1. Everything outside `Tests.Services.`: 8,358 run, 8,358 pass.
   2. Services classes A to L: 4,445 run, 4,436 pass, 8 skipped, 1 failed: `BackTest_GlenEira24115_Computed_WithinTolerance` (the known red on the plain base).
   3. Services classes M to Z: 5,996 run, 5,985 pass, 11 skipped, 0 failed.
   4. **Sum 18,799 run, 18,780 pass, 19 skipped, 1 failed.** The total is in the thousands, so the `_AcadRefNet8` trap is not in play. The Opus trial merge of 49 PRs ran 18,693; the extra 106 are #1436 to #1438 and the fix rounds.
2. **The three new reds of the Opus trial, checked specifically:** `RedoSafeCallGraphTests.EveryHookBetweenCommands_IsRedoSafe_OrReviewed` (#1410 / #1426) passes; `Bug262SkippedItemMessageTests.EveryRefreshMakesItsReportThroughTheOncePerSessionGate` (#1402) passes; `Bug601SectionDisplayRefreshTests.PaletteUpdate_FlagsTheBlockForARedraw_AfterTheNewLinesAreDrawn` (#1407) passes. The class that crashed the C-44 run (`XcivilImportTargetExtentsLeaveOutTests`) no longer builds a database and the run reached the end.
3. **Manager net10:** 757 run, 757 pass (C-44 was 751; the six extra are #1388 and #1389).
4. **Civil net48 focused (the 51 changed test classes plus RedoSafe and DoubleClick, CERef 24.3.0):** 1,351 run, 1,326 pass, 7 skipped, **18 failed, every one `System.InvalidProgramException`** (the reference stubs have no method bodies, so a test that touches an AutoCAD value type throws on this lane). Names: `XcivilImport_MatchesRowsByTheOldOrder_WhateverTheSettingSays`; `AgDrainAndPerimeterDrainRows_AreNotListedAsPitsWithoutIdentity`, `RealPitWithoutIdentity_IsStillListed_NextToASurfaceDrain`, `StripDrainRow_IsNotListedAsAPitWithoutIdentity`, `WaterTankRow_StillLeftOut`; `ARectangleWithFourCorners_IsUnchanged`, `ASquareOnSurveyCoordinates_HasItsCentreInTheMiddle_ToTheMillimetre`, `ASquareWithManyPointsOnOneEdge_HasItsCentreInTheMiddle`, `NoUsableArea_FallsBackToTheCornerAverage`, `TheOlderCornerAverageWasOffCentre`, `ThePlanStoresTheAreaCentre`; `ProjectReadback_RefusesChangedStoredRow`, `ProjectRow_PreservesUnrelatedDetachedProjectAndUsesExactDrawingIdentities`, `ProjectRow_RefusesMissingOrDuplicateBoundaryAndGioIdentity`; `EqualCountsAndNothingDropped_PairByOrderWithAWarning`, `EqualCountsButARowWasDropped_NothingIsPaired`, `OneRowThrownOut_PitsP1ToP3_NoRowIsGivenAPitByPosition`; `BuildImportReviewRows_KeysRowsByDrawingLabel_AndUnknownNeverReadsAsBlankOrZero`. They belong to this train's new tests; the same classes ran inside the 18,799 net10 run, which has no red apart from Glen Eira. I did not run the base on net48 to compare, so "new tests" is read from the changed-class list, not from a base run. Fix is in the tests (read the value, not the stub, or skip on the stub lane), as in C-42 and C-44.
5. **Not run:** Installer.Tests, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural (no Structural file changed), Manager on net48, each PR alone, anything in AutoCAD or accoreconsole.

## 5. Hygiene

1. **Tim's settings files, size and hash at the start (06:17) and the end (06:46), unchanged:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` 34,858 bytes 24D8E5F7; `CE_CVL_SUITE\settings.json` 672 bytes EFE307C4.
2. AutoCAD and accoreconsole were not running at any point; I did not start either. Nothing was deployed, nothing written to the application plugins folder, no version edited. The CE log folder was redirected to `C:\ce-asm\logs`.
3. This run made no commit on the plugin branch.

## 6. For the finalizer

1. Review #1436, #1437, #1438 first (section 2).
2. Decide on the 18 net48 stub-lane tests (section 4.4).
3. Add the C-45 merge entry to `REGRESSION_LOG.md` (the assembler adds none); the version commit comes from the payload builder.
4. **Do not mark FIXED** anything in this train without a real AutoCAD pass; entries 1224 and 1266 of the review log list the bugs that stay OPEN even after merge.
5. The new Settings switches (about 40 across #1387 to #1438) have no rows on the Newer tools tab (R-00 standing LOW).
