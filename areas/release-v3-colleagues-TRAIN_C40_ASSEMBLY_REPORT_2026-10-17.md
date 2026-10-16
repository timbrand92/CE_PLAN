# Train C-40 assembly report (Civil + Manager), Sat 17 Oct 2026

**Answer first:** the C-40 train is assembled, builds with 0 errors on all three lanes, and the tests are green apart from the known Glen Eira red and one real net48-only red in the #1310 window-title test. Nothing was installed, deployed, version-edited or opened in AutoCAD. Built and unit-tested only; nobody has looked at any of it in AutoCAD.

## 1. The branch

1. **Branch:** `claude/rel-20261017c`, pushed to origin (new branch, normal push). Final head `753bbbde30e3c9dfa55d936e272b01cd96325f26`. Local head equals origin head.
2. **Base:** `origin/claude/rel-20261010e` at `d36f9545` ("Version: Civil 3.0.50 / Manager 1.1.50"). The tip had not moved. The branch contains the whole C-39 line plus the 37 PRs below, merged with plain `git merge --no-ff`, one merge commit per PR, no squash, no rebase, no cherry-pick.
3. **Installed Civil bundle (read only):** 3.0.50+d36f9545. No version field, csproj or PackageContents was changed by any PR except one test project (see section 5).

## 2. What merged (37 PRs, in this order, heads used)

1. **Codex test PRs:** #1253 `26ea12a2`, #1255 `8789a8ed`, #1257 `4ede9332`.
2. **First Civil batch:** #1263 `da006db6`, #1266 `9c2e3d50`, #1271 `48f3480a` (after #1266), #1268 `72e2295f`, #1269 `137834ed`, #1277 `be7827b8`, #1279 `c7dd9cda`, #1280 `4f939b6e`, #1283 `caa1db83`, #1284 `d95f2f55`.
3. **Calculation window family:** #1259 `4b1477b3` (export fix head, before #1274 and #1275 as both carry its commits), #1274 `7553cea9`, #1275 `cfd179ea`, #1281 `116f4d7e`, #1286 `13a77f38`.
4. **Round 2 and 3 Civil:** #1276 `8a54cef0`, #1288 `fb04a578`, #1289 `d49e7026`, #1290 `365c287e`, #1291 `c9509bda`, #1292 `ea85e9ee`, #1293 `287f788f`, #1296 `5ce92c32`, #1303 `2e9f0d6b`, #1307 `af6a9d14`, #1297 `8d11531c`, #1302 `99e9d47a`, #1309 `31e9d554`, #1305 `9728a1ac` (carries #1145 `438af1d5`).
5. **Post-review heads (fix rounds after the Opus review; the finalizer must verify these):** #1310 `3962334d`, #1301 `978a501d`, #1299 `092d5e5a`, #1308 `ad6e7f9e` (branch also carries #1276 `8a54cef0`; #1276 went in first), and **#1311 `2c35de86` (new, never reviewed)**.
6. **Every PR was open at the head used.** Heads of all PRs not in item 5 equal the heads named in the review log (entries 982 to 1058). No "already in base" case occurred.

## 3. What was skipped and why

1. **#1256 and #1258:** not merged. Review entry 1019.1: their guards arrive inside the repairs (#1286 carries #1256 byte for byte; #1258's six guard files are inside #1274, #1275, #1276, #1277, #1279 and #1281). Merging them would add the same files twice. To be closed once the train ships.
2. **#1145:** not merged separately. Its one commit came in through #1305. To be closed once the train ships.
3. **Structural PRs and everything else not in the brief:** untouched.
4. **No PR was stopped for a conflict, a version change or a project-file change.**

## 4. Hand resolutions

1. **REGRESSION_LOG.md:** clashed on almost every merge (all but a few). Resolved byte-safely every time from the three index versions (stored LF, no CR added), keeping every entry of both sides, then a blank line put back before any new heading the union had glued to the line above. Checks on the final file: 0 conflict markers, 0 duplicate `## ` headings (C-39 had 986 headings, the train has 1034, 48 added), 513 lines added and 0 removed against C-39, 0 control characters and 0 CR in any added line. The final file holds 4 control characters in total; the same 4 are in C-39 already (not mine).
2. **UserSettings.cs:** hand-resolved at #1286 (two blocks: top-level properties and the settings classes), #1289 (same two blocks), #1291 (one block, restored the blank line and the opening summary line), #1302 (one block) and #1299 (one block: closing brace, blank line and opening summary line between the `WindowFeel` and `WindowPlacement` classes). #1281, #1290, #1301, #1308 and #1309 merged without a Settings clash in this order. The first #1286 resolution accidentally tripled the file's leading byte-order mark; it was caught by the numstat check (20/1 against the expected 19/0), repaired and the merge commit amended before anything was pushed. No other file was touched by hand.
3. **PlainNumberText.cs:** #1281 and #1289 add the identical file; git took one copy (#1289 shows 33 fewer added lines than its own diff, for that reason only).
4. **#1308 after #1276:** merged without a textual clash. The review (entry 1043) says #1308's own fix round closes the "false message" meaning clash; the fix head `ad6e7f9e` was used as asked. I did not test the LandXML review window.

## 5. Numstat checks

1. **Equal to the PR's own numstat (log file aside):** 32 of 37 on the first check.
2. **Explained differences:** #1274 and #1275 (carry #1259's commits; each equals its own commits once #1259 is in; #1275 also brings #1258's `ChargedResultAvailabilityRegressionTests.cs` through its merge commit), #1289 (shared `PlainNumberText.cs`, item 4.3), #1305 (adds #1145's files), #1308 (the files #1276 already brought).
3. **Project files:** the only project-file change in the whole train is `Installer.Tests/CE_CVL_SUITE_Installer.Tests.csproj` from #1253 (a `GitExecutable` property and quoted path in the test project, reviewed MERGE in entry 982). It is not a version, plugin csproj or PackageContents change. I kept it and flag it here because the brief says to stop on a csproj change; the finalizer can drop #1253 if that was not the intent. No `PackageContents.xml`, `.props` or `.targets` changed. `RedoSafeReviewedHooks.baseline.txt` was not touched.

## 6. Shared, registry and Settings

1. **Files under Shared/ that changed (4):** `Shared/CE_SHARED/Services/CeRibbonLabel.cs` (new, #1297), `RibbonBuilder.cs` (#1297), `CeWindowPlaceStore.cs` (new, #1299), `CeWindowPlacement.cs` (new, #1299). Civil and Manager must ship together. Built CE_SHARED.dll is byte-identical in Drainage, Manager and Shared output on net48, net8 and net10 (SHA-256 prefixes 4901c86f, 578d2881, 8c286013).
2. **command-registry.json:** not changed. **council-profiles.json:** not changed. No new command was added by any PR.
3. **Manager source:** one file, `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml` (#1255, header name colour).
4. **Existing Settings defaults changed:** none (0 lines removed from UserSettings.cs).
5. **New Settings that ship OFF (equal to today):** `windowPlacement.remember` false (#1299); `councilRfi.enabled` false (#1302); `tankCallout.addMakeAndSize` false (#1305).
6. **New Settings that ship ON or with a number (visible new behaviour, all marked draft or ruled in the reviews):**
   1. `calculationExport.stampIssueStateOnEveryPage` true and `calculationExport.excelNumbersAsNumbers` true (#1281).
   2. `pitScheduleRemarks.keepCustomNoteBesideStepIrons` true (#1286).
   3. `pitScheduleExcel.numbersAsNumbers` true (#1289).
   4. `pipe.calculatedLevelSetsDirection` true (#1292).
   5. `surfaceDrainage` group: catchment overlay label colour 7 (same as before), label offset 300 (the review says 0 meant the old position, so 300 changes where labels stand) and `catchmentOverlayFillBehindDrawing` true (#1293).
   6. `longSection.refreshDisplayAfterUpdate` true (#1290) and `longSection.fitWrappedTitle` true (#1291).
   7. `xcivilImport.landXmlAskBeforeWrite` true (#1308): LandXML import now asks before it writes; Enter means No.
   8. `windowFeel.previewQuietMs` 300 (#1301; Tim's ruling).
   9. `jobChecklist.draftMinJobs` 3 and `jobChecklist.draftMinSharePercent` 50 with an empty `officeSteps` list (#1309; builder numbers, rule only, no caller).
7. **New Settings that change today's behaviour by being OFF:** `checks.consultantCheckReportBesideDwg` false (#1280). OFF is the new behaviour (the report goes to the CE report folder); ON is today's (beside the checked drawing). This is the one default that differs from today's behaviour when left alone.
8. **Already existing and unchanged:** `rightClick.showCommandNames` true (Tim's ruling; #1297 now reads it for the ribbon).

## 7. Redo-killer sweep (standing rule)

1. **Added lines in non-test C# containing** `StartTransaction(`, `SetCurrentView(`, `SetSystemVariable(`, `.Idle`, `DocumentActivated`, `DocumentBecameCurrent`, `CommandEnded`, `CommandWillStart`, `SelectionChanged` or `SendStringToExecute`: none across the whole train diff.
2. **Redo guard tests:** green on net10 (inside the Civil run) and on net48 (focused run). No baseline line was needed or edited.

## 8. Builds

1. **Whole `CE_ACAD_PLUGIN.slnx` Release**, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from the CERef 24.3.0 folder, net8 refs from the 2026 ref folder, net10 off the AutoCAD 2027 install, the stub-reference property not passed: **0 errors, 885 warnings** (C-39: 873), 3 min 51 s. Drainage, Manager and CE_SHARED built for net48, net8 and net10.
2. **Native transform file:** copied read-only from the installed bundle into the ignored build folder; removed again by `git clean -fdXq`.
3. **Disk:** 28 GB free before and after. The shared build lock was taken and released around every build and test run.

## 9. Tests (net10 with AutoCAD 2027 on PATH, `--no-build`, one NUnit worker, log folder redirected to scratch; every run printed a non-zero total)

1. **Manager:** 751 run, 751 pass (C-39: 751).
2. **Civil (Drainage.Tests):** **17,764 run, 17,744 pass, 19 skipped, 1 failed.** C-39 was 17,258 / 17,238 / 19 / 1. The 506 extra tests are the new tests of this train. The one red is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one.
3. **CommandTruth 64/64. TestHarness 101/101 on the second run. Spine 81/81. Diagnostics 19/19. AI.Core 42/42. ReleaseTests 16/16.** All equal to C-39.
4. **TestHarness first run: 1 red, a flake.** `OfflineHelpTests.ReadingStateRoundTripsAndRecoversFromCorruptOrRemovedTopic` failed at the second save of the help-reading file; run again alone it passed 101/101. No Help or TestHarness file is in this train. Treat as the old flake.
5. **Installer.Tests** (with the brief's filter, net9): 273 run, 237 pass, 36 fail. Same count as C-38 and C-39 (36). I did not diff the names against the earlier list this time; they are the same installer-route and packaging tests.
6. **Focused net48 run of every changed test class plus the redo classes (Drainage.Tests):** 615 run, 585 pass, 29 skipped, **1 failed (real, net48 only).** `Bug524WindowTitleCommandTests.EveryCommandInTheTable_IsARealCivilCommand_AndEveryWindowNameIsARealWindow` (PR #1310): "WaterTankDialog is not a window in the Civil assembly". The cause: the CDWT tank window is compiled only for the AutoCAD 2027 lane (`Page Remove` for every lane except net10 in `CE_CVL_SUITE.csproj`), but #1310's title table lists `WaterTankDialog` and the test demands every listed window exist in whichever lane it runs. It passes on net10. The fix is in the test (skip names that a lane does not compile, or exclude `WaterTankDialog` on net48); the title hook itself is harmless on net48. I did not change it, because it is not a baseline pin. Left for the finalizer.
7. **The two `SourceAtomicCoordinatorDependencyTests` IL reds and anything else:** not seen in the Civil run on this tree (only Glen Eira failed there).
8. **Not run:** Structural tests (no Structural file touched), AI.Harness tests, accoreconsole, anything in AutoCAD. A net48 Manager number (the Manager test project is net10 only).

## 10. Hygiene

1. **Tim's settings files, unchanged at the start, around every run and at the end:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` 34,217 bytes C5186042 (not the 33,198 / 5A8C447A in older briefs; it did not change during my run).
2. **Live CE folders under the roaming profile (file count / bytes), identical at start and end:** CE_CVL_SUITE 99 / 34,087,726; CE_STRUC_SUITE 2,472 / 2,096,853,513; TIM_CE_CADTOOLS 22,137 / 1,130,373,906.
3. **AutoCAD:** not running at any point (checked before every suite). No Codex START in the 3 minutes before any run. Nothing was written to the application plugins folder.
4. **Cleanup:** `git clean -fdXq` done, worktree kept and clean, branch pushed.

## 11. What the Opus finalizer should do

1. **Verify the four post-review fix heads** (#1299, #1301, #1308, #1310) and **review #1311** (Esc at "Proceed with import?"), which has no review yet.
2. **Fix the net48 red** in `Bug524WindowTitleCommandTests` (section 9.6).
3. **Decide the #1253 project-file change** (section 5.3) and the `checks.consultantCheckReportBesideDwg` OFF-means-changed default (section 6.7).
4. **Add the C-40 merge entry to the log** (the assembler adds none) and close #1145, #1256 and #1258 after shipping.
5. **Not checked by me:** any window, drawing, Excel file or printed page; the 885 warnings; whether any merged PR's tests are weak; Manager on net48.
