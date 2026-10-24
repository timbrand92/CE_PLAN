# Train C-64 assembly report (Civil + Manager), Sat 24 Oct 2026, real clock 14:32 to about 15:50 Melbourne

Built and unit-tested only. Not installed. Nobody has opened any of it in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` not edited. Structural is not in this train.

PR list read: `areas\TRAIN_C64_PR_LIST_2026-10-24.md`, last commit `fca39fdf` (14:31:19 the same day). It had the 40 PRs and no promotions.

## ANSWER FIRST

1. **Mistakes first, with the cost.** (a) My first merge run left four REGRESSION_LOG headings with no blank line before them (the entries BUG-906, BUG-799, BUG-993 and BUG-811 sat flush against the entry above): my blank-line step only looked at the lines each PR added, not at the old top entry that the new entry now touched. I noticed after all 40 merges, before any push, so I reset my own local, never-pushed branch to the base and re-ran all 40 merges with the step fixed (about 12 minutes lost). The pushed history is the second run: the count of headings with no blank line before is 160, exactly the base's 160. (b) The first Civil net10 full run had 2 red tests (item 8); one is a real failure that I fixed by one documentation line (item 6), the other is the PDF test that passes or fails with the PC's state. (c) Everything else ran first time; no hang, no build lost to the disk guard, no stalled restore.
2. **Branch and head:** `claude/rel-20261024n` (the name was free), pushed with a normal push. **Head `cb105ba84a04da49ae75106bd9f8105d98a15499`** = 40 merge commits on top of the base `5467f7053a2e9275cb450409c142ef9aa26dad53` (read with `git ls-remote` at 14:33: exactly the expected tip) plus ONE commit of mine at the very end (`cb105ba8`, item 6). The 40th merge is `7d79df7e`. Whole branch against the base: 132 files, 5,189 lines added, 127 removed (the 40 merges alone: 5,181 added; my commit adds 8).
3. **Merged: 40 of 40 listed PRs**, one plain `git merge --no-ff` commit each ("Merge PR #N (BUG-xxx) at <short head>"), no squash, no rebase, no cherry-pick. **Every live head (gh, `git ls-remote` and the fetched ref, all three) equalled the reference head: NO PR moved since the list and none was stopped, rewritten or not OPEN.** None was already in the branch. After every merge the files in the merge equalled the PR's own diff (the only differences were one extra blank line in REGRESSION_LOG.md at #1341, #1554, #1655 and #1656, which is my blank-line step). Zero conflict markers (checked after every merge and at the end).
4. **Left out:** nothing from the list. Everything in sections 4 to 7 of the list (WAITING, over the cap, HOLD, REJECT, Shared/Installer PRs, Structural) was not touched.
5. **Shared/: EMPTY** (`git diff --stat 5467f705..HEAD -- Shared` prints nothing). **Installer: EMPTY** (`Installer`, `Installer.Tests`, `Modules/Manager/Installer` all empty). **One thing outside both that you should see: #1618 changes `CE.AI.Core/AnthropicChatClient.cs` (3 lines) and `CE.AI.Core.Tests/AnthropicChatClientTests.cs` (69 lines)**: that is the shared AI runtime folder, not `Shared/`. Its 43 tests pass (item 8).
6. **One commit of mine, loud:** the test `NewSettingsKeys_NeedADocumentedDefault` was RED after merging #1419: its switch `linking.rebuildKeepsOnlyCarrierIdentity` had no "Default:" line in its documentation (the PR was written before that test existed on its base). I added the words " Default: on." to that one documentation comment, with a REGRESSION_LOG entry (commit `cb105ba8`). The value (on) is the PR's own and is not changed. The finalizer may drop it with `git revert cb105ba8` and write the line itself.
7. **Settings keys added by the 40 PRs, all default ON except the one value** (section 4): ten switches and one value in `LinkingSettings`, one switch in `pits`. No Settings page row for any switch. One Settings row for the value (#1722 "Shallow pit depth"). The Settings-fit test passes (5 of 5).
8. **Build and tests (final head `cb105ba8` unless said):** whole solution Release **0 errors, 909 warnings** (C-63 had 891), net48 AND net8.0-windows AND net10.0-windows built for Civil and Manager; Installer (Debug output, net9.0) and Installer.Tests (net9.0-windows) COMPILED, not run. Civil net10 Release full suite: **20,027 total, 20,005 passed, 22 skipped, 0 failed** (C-63: 19,803; 224 more tests). Manager net10: **956 total, 955 passed, 1 skipped, 0 failed** (C-63: 950). CE.AI.Core tests 43 of 43. Manager net48: build 0 errors (tests are net10 only). Civil net48 focused: **2,203 total, 2,115 passed, 65 skipped, 23 failed: 17 are the known reference-only names; 6 are NEW names, all `System.InvalidProgramException` from the net48 reference-only AutoCAD DLL, all in new tests of #1601, #1607 and #1616** (item 9). REDO call-graph baseline **25 of 25**. Nothing re-pinned.
9. **For the finalizer (read first):** (a) group 4 (#1626, #1597, #1419, #1614, #1722, #1717) was not independently re-reviewed; each can be taken out with `git revert -m 1 <merge sha>` (section 1, items 35 to 40; they are the last six merges before my commit). (b) #1712 and #1730 are the REDO-safety reads you were told about; the REDO baseline test is green, the baseline text file was not changed by any PR. (c) #1618 touches `CE.AI.Core` (item 5). (d) Eight new pictures (`docs/image/V3_WINDOWS/pitschedule-unloaded-*.png`, from #1554) were NOT opened by me. (e) The PDF test flaked (item 8 of the evidence). (f) AutoCAD (acad.exe, started 14:29) was open during every build and test step.

## 1. Merge list with heads and merge SHAs (merge order)

Reference head equals the live head for every PR (all three reads agreed). The merge commit is the short SHA at the end.

1. **#1747** BUG-1135: live head `346d8e6b05e2906a32edec167dc72d13c6f6e6b5` (equal to the reference), merge `a8c535d3`
2. **#1642** BUG-988: live head `3d6c2b88a4891f78f0b423efc3e35edcfcd69f6a` (equal to the reference), merge `746a55e4`
3. **#1627** BUG-997: live head `3acc9b20902138d2d7bca1be746d1efa4639817c` (equal to the reference), merge `b0c6a305`
4. **#1629** BUG-1022: live head `01c299c8723d2b131e79f1fec990d840e7d64ebb` (equal to the reference), merge `fa4351d8`
5. **#1628** BUG-1005: live head `3851df80bfd91abeef5c46e33c750c8c9b71d5a6` (equal to the reference), merge `db942f59`
6. **#1631** BUG-981: live head `2c481e58d24f4155c8489e4a9a4f5ebed20cb62c` (equal to the reference), merge `fb15c3f3`
7. **#1559** BUG-979: live head `ab8980c8e58f48d9856007a48763991f3f36b1f4` (equal to the reference), merge `b04f72dc`
8. **#1578** BUG-1012: live head `409feaf57277fcf7ae38e21088f54da150e11cef` (equal to the reference), merge `f7395406`
9. **#1573** BUG-1007: live head `1d03449206f9b31c7f02fcb0cda89ac746775ce1` (equal to the reference), merge `261e4f96`
10. **#1641** BUG-996: live head `c0a03bc129b7007676c0c9bea580da4e889f2acd` (equal to the reference), merge `eb906d15`
11. **#1561** BUG-980: live head `81e64f7da2ba1690b3d7b7101622da73a7e2f369` (equal to the reference), merge `7a62f39e`
12. **#1599** BUG-995: live head `fc905d69f52cced399dc6f56dbc82e7d685f5cf8` (equal to the reference), merge `5cf293b6`
13. **#1712** BUG-811: live head `49792ecacfcbb6d9eb50d619b9b51ff894123d38` (equal to the reference), merge `eb15aacb`
14. **#1341** BUG-710: live head `4771157cafe939db8f9c1bf892121a4a490b210d` (equal to the reference), merge `d51a13cb`
15. **#1750** BUG-1206: live head `cf6b3bec255c640e38616155d71c6f979beb739a` (equal to the reference), merge `a9a18a8f`
16. **#1751** BUG-1165: live head `29324462abcfa34c06c641451d74302a8f35937d` (equal to the reference), merge `b604cdd1`
17. **#1754** BUG-1167: live head `9bb151be546c0691c5dfd497a9531ca1601f0bd7` (equal to the reference), merge `e45a598d`
18. **#1638** PRIVACY-NOBUG: live head `14c8272c1212fb2bb92ced918f1067098732453a` (equal to the reference), merge `1d3990a0`
19. **#1618** BUG-991: live head `004ece8d52fa1b9513802b1bd69bf0102a25b2f8` (equal to the reference), merge `9476b85e`
20. **#1569** BUG-1008: live head `23f1289a0a20197e2608c5c818da8ef703a4e931` (equal to the reference), merge `ba6cd492`
21. **#1565** BUG-1003: live head `51a01fcca69d4aed63103f71904643beb415548e` (equal to the reference), merge `be16a462`
22. **#1635** BUG-1032: live head `a57515120c4e5b2e382bdd34377eb398096489ea` (equal to the reference), merge `2a3fc123`
23. **#1580** BUG-1010: live head `b3ee3ea308805a2754202c7754bf7d5634f0f560` (equal to the reference), merge `fc978c23`
24. **#1583** BUG-993: live head `0fd88b48f2f0677623f43976142d176f528f9b36` (equal to the reference), merge `7114f63a`
25. **#1554** BUG-799: live head `7f4f8c390c5b123acd1954e278386f28edce139b` (equal to the reference), merge `73cd6f15`
26. **#1655** BUG-906: live head `52efb49b918875d429c6935dfd1b440047611892` (equal to the reference), merge `d56b6dc7`
27. **#1656** BUG-904: live head `cb53d0f897afcf79c95e70fb46b5ff4d6ccbc5c9` (equal to the reference), merge `0ea1e181`
28. **#1640** BUG-992: live head `c9e26aa59926de528dec693165e07f2e1369c470` (equal to the reference), merge `3b14fc3a`
29. **#1730** BUG-1085-1086: live head `c9b414847f2068a7a8e8c859126de1d71c979048` (equal to the reference), merge `27c2c5db`
30. **#1728** BUG-1036: live head `115eeaf03beb429871c18525e7cb501e104b08ed` (equal to the reference), merge `7d52053b`
31. **#1601** BUG-1001: live head `7e32a24125f382fcff10f4afbf9ac6ea0bff39d1` (equal to the reference), merge `e7c42c99`
32. **#1607** BUG-1000: live head `8adabfe69a7a8fcf2b39239795f555ee1f80412e` (equal to the reference), merge `208029d0`
33. **#1616** BUG-1002: live head `74c696781e45debad04f7f72356d63a9178044fe` (equal to the reference), merge `47284178`
34. **#1711** BUG-766: live head `5ee899a2ee49203db09a06b7a4aa61c37078e23b` (equal to the reference), merge `410dfd81`
35. **#1626** BUG-998: live head `e852f2589d879ca412520bc829d23da75fd82e14` (equal to the reference), merge `6731077a`
36. **#1597** BUG-1024: live head `10ed4f53f235eb3005380575e8b191555c859e23` (equal to the reference), merge `633cda08`
37. **#1419** BUG-803: live head `f0a87b5a85353d25712ee6dc73cad0a6c19491c1` (equal to the reference), merge `04319a80`
38. **#1614** BUG-1009: live head `d91e4dfb0417eaa57a5a5abdd912727e99e92e13` (equal to the reference), merge `ed399bfc`
39. **#1722** BUG-1035: live head `db50498a7a1d4b3f5fad7651b520c0e4edd0fc10` (equal to the reference), merge `0ab9e32f`
40. **#1717** BUG-812: live head `676874b54645f83aa8b838856ffc54b876a5c413` (equal to the reference), merge `7d79df7e`

41. **My commit:** `cb105ba8` documentation line for `rebuildKeepsOnlyCarrierIdentity` and a log entry (item 6 above). Pushed.

## 2. What was NOT merged and why

1. Nothing in the list was skipped. Not merged by design: the 10 WAITING PRs (#1748, #1643, #1593, #1588, #1657, #1691, #1000, #1620, #1195, #1198), the 19 over the cap, every HOLD, REJECT, notes-only, plan-train and Structural PR (list sections 4 to 7). I changed none of them. #1748 (BUG-1138, data loss) is still the one data-loss PR left out.

## 3. Scope check

1. **Shared/:** empty. **Installer, Installer.Tests, Modules/Manager/Installer:** empty.
2. **Modules/Manager: two product files changed, both by existing PRs, no new file.** #1730: `Commands/PluginManagerCommands.cs` (4 added, 2 removed). #1750: `Services/CeUnifiedRibbonService.cs` (4 added, 3 removed). `git diff --diff-filter=A` on `Modules/Manager`, `Installer` and `Shared` is empty, so the 75-file bundle guard should not move. I did NOT run a release payload build, so the 75 is not re-counted.
3. **Config files:** `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json` and every `PackageContents.xml`: NONE changed. No command added or removed (no registry or toolbar change), so the CrossModuleGuard counts stand; CrossModuleGuard passes.
4. **Signing, release authority, deploy scripts:** none. (A path search for "sign" only finds the `NetworkRedesign...` files, because "Design" contains the letters.) No csproj, props or ps1 file changed.
5. **Files touched by more than one PR (computed from the merge diffs, log excluded):** `UserSettings.cs` (#1419, #1627, #1628, #1629, #1631, #1640, #1641, #1642, #1655, #1722, #1754); `PitScheduleDialog.xaml.cs` (#1569, #1614); `FallArrowGeometry.cs` (#1341, #1583); `LongitudinalSectionService.cs` (#1627, #1711); `ProjectDataService.cs` (#1629, #1747); `PipeFlowCalcViewModel.cs` (#1561, #1728); `PitScheduleViewModel.cs` (#1614, #1722). Same as list section 3. Only `UserSettings.cs` and the log clashed; every other overlap joined cleanly.
6. **Clashes:** `REGRESSION_LOG.md` clashed at most merges and was resolved keeping every entry (newest on top; heading count 1,345 on the base, 1,391 now; every base heading is still there). `UserSettings.cs` clashed at #1627, #1629, #1628, #1631, #1641, #1640 and #1419, each time two neighbouring pure additions of whole property blocks; I kept both (see section 4). No other file clashed and no PR was stopped.

## 4. Settings keys (default in the merged code; I changed none)

All JsonProperty names are unique within their class (checked by a script). Group = the class of `UserSettings.cs` that holds the key.

1. **`linking.drawingRecordBeatsPcFile`** (#1642): default **on**. No Settings page row.
2. **`linking.longSectionUpdateKeepsCopies`** (#1627): default **on**. No row.
3. **`linking.refoundPitKeepsScheduleOverrides`** (#1629): default **on**. No row. (The list wrote it without the `linking.` prefix: the diff shows it is in `LinkingSettings`.)
4. **`linking.renumberScoresJoiningPipe`** (#1628): default **on**. No row.
5. **`linking.scheduleXrefGroupsKeepDrawing`** (#1631): default **on**. No row.
6. **`linking.cdMirrorKeepsPipeTextLink`** (#1641): default **on**. No row.
7. **`linking.xrefCompareChecksOldPosition`** (#1640): default **on**. No row.
8. **`linking.otherUsersFoldersFollowThisPc`** (#1754): default **on**. No row.
9. **`linking.rebuildKeepsOnlyCarrierIdentity`** (#1419): default **on**. No row. Its documentation had no "Default:" line; I added "Default: on." (item 6 of the answer).
10. **`pits.blocksFromRunningBundleFirst`** (#1751, in `PitMigrationSettings`): default **on**. No row.
11. **A value, not a switch: `linking.shallowPitDepthMm`** (#1722): default **300.0 mm**. HAS a Settings row ("Shallow pit depth", Pipes and Pits tab, with a warning line). A blank, zero, negative or unreadable figure uses 300 mm in the schedule (no block).
12. **Existing switch, documentation only: `detentionWithoutLengthNotDiameterChecked`** (#1655): the documentation now says R-30 follows the same missing-length decision as R-06; default still **on**, no value change.
13. **The resolved blocks:** for each clash I kept both sides as separate blocks, each with its own summary, its own `JsonProperty` and its own initialiser, in the order the merges came (HEAD block first, then the PR's). They are visible as the diff of `Modules/Drainage/Models/UserSettings.cs` against the base (11 added blocks, no removed line).
14. **Switches with no Settings page row:** every switch above (items 1 to 10). The settings file is the only way to switch them off. **`NewSettingsKeys_NeedADocumentedDefault` passes** on the final head (it failed on #1419 before my documentation line). The C-64 "older file loads each one ON" test is NOT written by me (the list gave that to the finalizer).
15. **Settings-fit:** the 150 percent test (`EveryTab_FitsTheScreen_AtOneFixedHeight`, the five "Settings fits ..." cases: 2560x1440 at 150% dark, 1920x1080 at 150% dark, 125% dark, 100% light, 100% dark) **passes 5 of 5** on net10 after #1722's new row. I did not read the exact tallest-tab pixel height, so the 670 px figure is not re-measured; the test is the guard.

## 5. Build and test evidence

1. **Environment:** merge worktree `C:\ce-asm\c64`; build and test worktree `C:\asm64\w` (detached at the same commits; first `7d79df7e`, then `cb105ba8` for the rebuilds). Release. Every command carried `-p:SkipDevBundle=true -nr:false --disable-build-servers`; the solution build used `-m:1`. Refs: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`, AutoCAD 2027 on PATH, a 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, in the gitignored bin folder). **Builds ran with the normal TEMP; test steps ran with a fresh TEMP and CE log folder inside it**, `VSTEST_CONNECTION_TIMEOUT=900`. Projects were restored one by one first (Shared, CE.AI.Core, Drainage, Manager, the two test projects, Installer, Installer.Tests: all exit 0, a few seconds each, the package cache was warm); no whole-solution restore. Never deployed. I did not set dotnet to Below Normal by hand (my runner has no priority step that worked from this shell); say so honestly.
2. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` could not be taken (stale file, "lock NOT taken" on every step); I never deleted it and built in my own worktree.
3. **Whole solution Release build** (14:59 to 15:07, 7 m 48 s): **0 errors, 909 warnings.** Frameworks: `CE_CVL_SUITE.dll` and `CE_SUITE_MANAGER.dll` for **net48, net8.0-windows and net10.0-windows**. `CE_CVL_SUITE_Installer` (the solution builds it as Debug, net9.0 win-x64) and `CE_CVL_SUITE_Installer.Tests` (net9.0-windows) **COMPILED, not run.** Structural also compiled (the solution holds it; not in this train).
4. **Civil net10 Release full suite, final head `cb105ba8`** (15:33 to 15:40): **Total 20,027, Passed 20,005, Skipped 22, Failed 0.** In the thousands. `BackTest_GlenEira24115_Computed_WithinTolerance` is GREEN on this train (0 failed), so no PR here brought that red in.
5. **Civil net10 first full run, head `7d79df7e`** (15:07 to 15:17, before my documentation line): 20,027 total, 20,003 passed, 22 skipped, **2 failed**: `NewSettingsKeys_NeedADocumentedDefault` (real: #1419's switch, fixed by `cb105ba8`, then passes) and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` ("The PDF renderer produced only blank page(s) (1 of 1) — PDF page render failed in this AutoCAD session"). **The PDF test also failed when run alone** (about 15:25, 17 s), and **passed in the final full run (15:40)**. No file in the diff has anything to do with markup, PDF or rendering, so I call it the machine's state (acad.exe and other sessions open), not a train fault. I did not build the base to show that.
6. **Manager net10 full suite:** **Total 956, Passed 955, Skipped 1, Failed 0** (C-63: 950; 6 more from #1730 and #1750). **Manager net48:** build 0 errors, nothing run.
7. **CE.AI.Core.Tests** (net8.0): **43 of 43 pass** (changed by #1618).
8. **Civil net48 focused (class-name filters only; the saved filter is `C:\ce-asm\logs64\f48_filter.txt`):** the 20 classes of the brief (SettingsWindow, SettingsFit, SettingsValue, SettingsLoad, AdvancedSettings, C61NewSwitch, C62NewSwitch, C63NewSwitch, UserSettings, RedoSafe, CommandOutcomeLine, KeywordPromptBracketTag, CrossModuleGuard, CheckIgnore, DoubleClick, PickHandlerProbe, Raingarden, PitSchedule, Twl, Import, Propagate) plus NewSettingsKeys and the 47 test classes the merged PRs add or change (every class named in the added and changed Drainage test files). Result: **2,203 total, 2,115 passed, 65 skipped, 23 failed**, 6 m 59 s. All 23 are `System.InvalidProgramException` (23 of 23 in the log).
9. **The 23 compared by name:** **the 17 known reference-only names are all present, unchanged** (`NonfiniteSource_IsRefusedBeforeFlattening` x3, `EditorPick_UsesRotatedTranslatedUcsOnce` x2, `JigWorldPoint_PreviewTemporarySegmentAndFinalVertexHaveExactSameXY` x2, `Raingarden_SameOutlineInMillimetresOrMetres_Is600SquareMetres` x2, `Raingarden_UnitlessDrawing_PlacesWithAreaUnknownAndReason`, `Raingardens_AreNamedRG1_RG2_InOrder_AndNeverReuseAName`, `MillimetreDrawing_Raingarden_IsBitIdenticalToTheOldDivision`, `TiltedNestedSource_ComposesAllFramesBeforeFlattening`, `OverflowDuringTransform_IsRefused`, `DefaultImportAndSideDatabaseParametersDoNotOptIntoCdPlanAdmission`, `XcivilImport_DoesNotAskForTheMainToBeTidied`, `FindRecordedPitAt_WithNoExplicitMargin_UsesTheOfficesSettingsValue`). **6 NEW red names, same cause (the net48 build uses a reference-only AutoCAD DLL whose `Point3d.Origin` and `Vector3d.ZAxis` and `Vector3d.Length` throw InvalidProgramException; the same tests pass on net10):** from #1616 (`Bug1002XcivilFallBlockRotationTests`): `ABlockRotatedNinetyDegrees_TurnsTheArrowNinetyDegrees`, `TheBlocksOwnRotationAddsToTheArrowsAngleInsideTheBlock`; from #1601 (`Bug1001XcivilPitIdNeighbourTests`): `ASingleLabelIsStillGivenToOnlyOnePit`, `TwoClosePits_EachTakeTheirOwnLabel_WhenTheFirstPitsTextIsAlsoNearestToTheSecond`; from #1607 (`Bug1000XcivilTranslateSpotFallTests`): `NoSpotsOrFalls_IsStillFine`, `SpotLevelsAndFallArrows_MoveWithThePitsAndPipes`. New tests, so they do not exist on the base; I did not build the base. **So net48 has 6 new reds beyond the known 17: report them, and they matter only if someone runs net48 tests on a real AutoCAD 2024 reference.**
10. **REDO call-graph baseline** (`RedoSafeCallGraphTests`, net10, named run after all merges): **25 of 25 pass.** `RedoSafeReviewedHooks.baseline.txt` was not changed by any merged PR; **nothing re-pinned by me.**
11. **Tim's settings files, before (14:33) and after (15:40):** `TIM_CE_CADTOOLS\CD_Settings.json` acd64e7 (15,270 bytes), `CS_Settings.json` 622a246 (351,713 bytes), `CE_CVL_SUITE\settings.json` efe307c (672 bytes), `CE_STRUC_SUITE\CS_Settings.json` 2972ce7 (35,259 bytes): **all unchanged** (hash and size identical).
12. **AutoCAD:** acad.exe (started 14:29) was running during every build and test step (count 1 in each step log). A Codex or robot pass may have been running; I never touched it.
13. **Not tested:** anything in AutoCAD or accoreconsole; any window or picture (including the Settings row for "Shallow pit depth" and the eight Pit Schedule pictures from #1554); **Installer.Tests (compiled only)**; Manager net48 tests; the Manager release 75-file bundle guard (needs a payload build); the exact tallest-tab pixel height; Structural; the net48 reds against a base build; the base build for the PDF test; the C-64 new-switch defaults test (not mine to write); a net8 test run (only net10 and the net48 focused set were run).

## 6. For the finalizer

1. **Take out any group-4 PR with `git revert -m 1 <merge sha>`** (section 1, items 35 to 40). My commit `cb105ba8` can also be reverted on its own.
2. **Read:** #1712 and #1730 (cascade write and Undo, for REDO-safety); #1747's limit (builds 3.0.73 and older still drop and lower the version marker) is in the list.
3. **Ten switches, no rows:** the finalizer lists them, builds none, writes the C-64 defaults test.
4. **Versions** not bumped (payload builder: Civil 3.0.74 / Manager 1.1.74).
5. **Hygiene:** worktrees `C:\ce-asm\c64` and `C:\asm64\w` and the `t64_*` temp folders are removed after this report is pushed; my local branch `claude/rel-20261024n` stays (the remote branch stays). Scripts and logs stay in `C:\ce-asm\` (`mergeone64.sh`, `resolve_us.sh`, `loop64.sh`, `run64.sh`, `f48_64.sh`, `list64.txt`, `logs64`, `logs64_run1` = the first merge run that I discarded).

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.**

## Summary

Branch `claude/rel-20261024n`, head `cb105ba8`: all 40 PRs merged (no head moved), one documentation-line commit of mine. Shared and Installer untouched; Manager has two small edits, no new file. Solution builds clean on net48, net8 and net10. Civil net10 20,027 tests, 0 failed; Manager 955 of 956. Civil net48 shows the 17 known reds plus 6 new reference-only ones. Ten bug-fix switches added, all on, none with a row. Nothing tested in AutoCAD.
