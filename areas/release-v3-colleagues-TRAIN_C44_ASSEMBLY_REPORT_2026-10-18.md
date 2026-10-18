# Train C-44 assembly report (Civil + Manager), Sun 18 Oct 2026 (about 12:45, Melbourne time)

**Answer first:** the C-44 train is assembled and pushed. 37 PRs merged, 1 contained already, 1 stopped on a code conflict (#1351), 1 left open on purpose (#1381). It builds with 0 errors on every lane. Every test suite is green except the known Glen Eira red, the known Installer reds (36, same as before) and ten net48-only stub-lane reds. **One real problem for the finalizer:** a new test from #1356 crashes the whole Civil test run (section 7.1). Nothing was installed, deployed, version-edited or opened in AutoCAD. Built and unit-tested only; nobody has looked at any of it in AutoCAD.

## 1. The branch

1. **Branch:** `claude/rel-20261018d`, pushed to origin (new branch, normal push). Head `ce6c40cd0bfd346a0f7fc6e41216527b5d4b59ef`. Local head equals origin head.
2. **Base:** `origin/claude/rel-20261018c` at `def8e56f` (Version: Civil 3.0.54 / Manager 1.1.54, C-43). The tip had not moved. The installed Civil DLL reads 3.0.54+def8e56f (read only, unchanged before and after).
3. **Method:** plain `git merge --no-ff`, one merge commit per PR (37 first-parent merges), no squash, no rebase, no cherry-pick. `merge-base --is-ancestor` said "not yet contained" before each merge. After every merge `git diff --numstat HEAD~1 HEAD` was compared with the PR's own file list from GitHub.
4. **The branch contains** the whole C-43 branch (rel-20261018c with the 3.0.54 version commit) plus the merged PRs below.
5. **No open PR above #1381 exists** (checked at the start and the end).

## 2. What merged (37 merge commits, in this order, heads used)

All heads equal the live PR heads (re-checked by `gh pr view` immediately before each merge; none moved).

1. **Settings page:** #1370 `de2d3cce` (fix head: the 23 existing newer-tool values on a new "Newer tools" tab).
2. **Spot levels:** #1342 `c4e7611b` (fix head), #1344 `9fa679c8`, #1348 `fba6f151`.
3. **Pit design-level offer:** #1346 `eca3dbaf`, #1349 `1379000c` (fix head), #1347 `049c6190`.
4. **CDTG:** #1345 `4b03ad1d` (fix head), #1350 `0ceb3ae3`.
5. **Source names:** #1343 `f15b6c1f`, #1355 `98f605ea` (fix head), #1358 `7e60da94`.
6. **Survey:** #1362 `6332655f`, #1361 `cb770842` (fix head, already joined with #1375), #1369 `e9d3ebde`, #1371 `d6abf468` (fix head), #1374 `7250faf2` (fix head), #1376 `6b7c968e`.
7. **X-Civil import:** #1353 `b2d2d8d2`, #1354 `ba9935b0`, #1364 `34c23f03` (fix head), #1365 `452f87c2` (fix head), #1366 `100db1f2` (fix head), #1367 `9e0b391e`, #1368 `5beb2458`, #1373 `30db1214`.
8. **LandXML and compare:** #1356 `fff9fbed` (fix head), #1380 `4c27c0a6`, #1363 `47f4c257` (fix head), #1357 `388fe5e9`, #1359 `62dbbffc`.
9. **Survey, rest:** #1352 `24e21a90` (fix head), #1360 `5084ff60`.
10. **Tags and cascade:** #1372 `9bfc5cd8`, #1377 `e6de44ad`, #1378 `8caecdbf`, #1379 `4019cc7e`.
11. **Contained already:** #1375 `de50f69f` is an ancestor of the branch after #1361 (its head `cb770842` carries #1375 joined by hand). No merge needed, nothing lost.
12. **Stopped:** #1351 `aabac696` (BUG-718 rest, stacked on #1349). Merging it gives a code conflict in `Modules/Drainage.Tests/Services/DesignLevelServiceTests.cs` (both it and #1349's fix round append tests at the end of the class; `<<<<<<<` at line 193). Not a conflict any review entry covers, so I aborted that merge and left it for the finalizer (the fix is the same as the other two test-file clashes: keep both sides, close the first test's brace). Nothing is stacked on #1351. Side effect: #1347's log item 5 says the unitless reach and the millimetre review are "done in #1351"; until #1351 merges that sentence is not true on this branch.
13. **Left open on purpose:** #1381 (duplicate of #1353, ruling D6).
14. **Open DRAFT PR not in any review entry:** #1341 (BUG-710, CDFALLSUGGEST grade on metre drawings, base `claude/rel-20261018c`, head `59eaee1d`). It is below #1342 so it was never in this list; not merged, not reviewed.

## 3. Heads newer than the reviewed MERGE heads (not re-reviewed by me)

1. **Fix rounds** (the brief's list, each newer than the head Opus reviewed): #1370, #1342, #1345, #1349, #1352, #1355, #1356, #1361, #1363, #1364, #1365, #1366, #1371, #1374. The finalizer should check each against its review entry (1133-1141, 1144, 1147, 1151, 1154, 1157, 1158, 1170-1179).
2. **Log-only follow-ups on MERGE PRs:** #1346 (`eca3dbaf`, one extra commit rewording a test step, entry 1148 LOW 1) and #1347 (`049c6190`, one extra commit on the log, entry 1149 LOW). Same two PRs the numstat sections below mention.

## 4. Hand resolutions

1. **REGRESSION_LOG.md** clashed on 32 of the 37 merges (the other five merged clean: #1370, #1344, #1350, #1380, #1379) (each PR adds its section at the top). Resolved byte-safe by script files: Latin-1 round trip so no byte changes, both sides kept, the incoming PR's section on top (newest first), exactly one blank line between sections, working copy CRLF kept, stored file LF (`i/lf` after every commit). The first resolver left two double blank lines after #1349 (which carries three hunks); I tidied them and amended that one merge commit before anything was pushed; after that the resolver collapsed blanks itself. Final checks on the finished file: 0 conflict markers, 1,116 headings and 0 duplicates, 421 lines added in all, no new control characters (the 4 that exist are in the base), no heading without a blank line before it in the first 700 lines, no double blank line in the first 600 lines (the base had one). Every non-blank added line of every merged PR is present except three that the fix rounds rewrote on purpose (#1344's older item 2 from #1342, #1349's older item 4 from #1346, #1375's item 6, now item 7 inside #1361's joined section).
2. **UserSettings.cs** clashed five times, always at the same place (a property added at the same spot in two PRs): #1369 against #1375/#1361 (`SurveySettings`), #1371 and #1374 (`SurveySettings`), #1380 and #1363 (`XcivilImportSettings`). Resolved by keeping every property block whole, each with its own `/// <summary>` opening line and one blank line between (the shared opening line had been taken by one side, as in C-42). Order in `SurveySettings`: `xrefHeightsStayRealLevels`, `intakeChecksFollowDrawingUnits`, `transformPairsNeedUniqueLevels`, `unitlessMetreSiteReadAsMetres`. Order in `XcivilImportSettings`: `scheduleCoverNeedsOneBareNumber`, `landXmlAsksBeforeReplacing`, `landXmlKeepsYourPitOnNumberClash`. Braces checked by eye and by the build.
3. **Two test files, brace fix from the review entries (1165.2 and 1182.5):** `XcivilPitRotationTests.cs` (#1354 over #1353) and `SurveyServiceTests.cs` (#1352 over #1361). Kept both sides with the closing brace of the first side's last test added, then a blank line, then the second side. The build proves the braces.
4. **Numstat differences, all explained:** the log gains one extra blank separator line on some merges (10 against 9, 11 against 10); `SurveyService.cs` (#1371, #1374), `XcivilScheduleService.cs` (#1366) show one line fewer than the PR because an earlier merged PR already added `using CE_CVL_SUITE.Rules;`; `UserSettings.cs` on #1380 shows 8 against 9 because I dropped the one blank line that would have doubled; #1349 shows a long list because its base branch was the older #1346 branch (everything from #1342 and #1346 was already in the train, so the merge brought only its own part). Every other merge was identical file by file.
5. **No count test, registry row, hash or RedoSafe baseline needed re-pinning.** `RedoSafeReviewedHooks.baseline.txt` was not touched by any merged PR and not by me.

## 5. Shared, registry, Settings

1. **Files under Shared/ that changed:** none. Manager source: none. Structural: none. Civil and Manager `CE_SHARED` stay byte-identical. Manager does not need to ship with this train. Every changed file is under `Modules/Drainage`, `Modules/Drainage.Tests` or is `REGRESSION_LOG.md` (105 files, +5,158 / -195).
2. **Registry, council profiles, csproj, props, PackageContents, version:** not changed (no merged PR touches a json, csproj, props or PackageContents file; checked on the file list of all 40 PRs before merging).
3. **New Settings properties, 14 in all** (the 23 rows on the new Settings page from #1370 reuse existing properties and add none). **None of the 14 has a row on the Settings page yet** (R-00 standing LOW; the Newer tools tab is the natural home). Every switch ships ON, so each one changes today's numbers on Tim's PC unless noted; OFF gives the old behaviour:
   1. `linking.cdTagRefusesUsedNumberedName` ON (#1358).
   2. `linking.cascadeRelinksOnlyPlanPipes` ON (#1379).
   3. `survey.surveyRlMinM` -100.0 and `survey.surveyRlMaxM` 3000.0 (#1352; the old range was 0 to 500, so levels above 500 and below 0 are now spots).
   4. `survey.xrefHeightsStayRealLevels` ON (#1375, via #1361).
   5. `survey.intakeChecksFollowDrawingUnits` ON (#1369).
   6. `survey.transformPairsNeedUniqueLevels` ON (#1371).
   7. `survey.unitlessMetreSiteReadAsMetres` ON (#1374).
   8. `xcivilImport.invertTextAtItsOwnPipeEnd` ON (#1367), `gradeInvertSkipsPipeDrawnFromLowEnd` ON (#1368), `pitFloorIsNotAPipeInvert` ON (#1366), `scheduleCoverNeedsOneBareNumber` ON (#1365), `landXmlAsksBeforeReplacing` ON (#1380), `landXmlKeepsYourPitOnNumberClash` ON (#1363).
   In every case the review ruled the old behaviour is the bug, and the change goes to Unknown, a refusal with a plain sentence, or a question, never to a new guessed figure. The two exceptions the review flagged are #1365 and #1374 (they could blank a cover or misread a millimetre drawing; both have fix rounds in the train).

## 6. Behaviour changes a drafter will notice (from the review entries; none seen in AutoCAD)

1. **Spot levels (#1342, #1344, #1348):** CDSL, the fall-arrow suggester, the pit offer and CDSLAB read one shared notation (18.6, P18.6, 18,6, 18.6m, RL, PRL); top-of-wall and bottom-of-wall levels are not ground levels (the fix round removed TW and BW from the reader, so #1348 keeps "TW 12.450" on imported wall levels); CDSL says so when the spot-level layer is locked, before placing anything.
2. **Pit design-level offer (#1346, #1349, #1347):** follows the slab's breaklines and the edited spot text; connected-level words use a full stop on any regional setting.
3. **CDTG (#1345, #1350):** remembered cover level keyed to the drawing, with a Blank keyword; trench numbers in drawing units (metre drawings now right).
4. **Source names (#1343, #1355, #1358):** CDFIXTAGS keeps label state, multi-word names like ROOF DRAIN 1 keep every word, DP3 and WT1 pairs number as DP4 and WT2; CDTAG refuses a numbered name another block already carries.
5. **Survey (#1362, #1361, #1375, #1369, #1371, #1374, #1376, #1352, #1360):** attribute defaults are not spots; both triangles of a quad face are kept (XREF and raw DWG); XREF heights are divided by the Z scale; duplicate-point checks use the drawing's units; the transform pairs only by unique levels; a no-units metre site is read as metres; the raw-survey choice is honest; levels above 500 and below 0 are read; suspect points are counted properly.
6. **X-Civil import (#1353, #1354, #1364, #1365, #1366, #1367, #1368, #1373):** two close pits with different numbers stay two; the drawn pit schedule table is kept; skipped unnumbered ends are named; the cover needs one bare number; a pit floor is not written as a pipe invert; IL text goes to its own pipe end; no uphill invert on a pipe drawn from its low end; the report says how many warnings are not listed.
7. **LandXML and compare (#1356, #1380, #1363, #1357, #1359):** X-Civil Replace erases late and never the drafter's own pipes; CDIMPORTLANDXML asks Replace or Abort when an earlier import exists (Enter = Abort); a clashing pit number no longer takes over your pit; the compare names the pipe that is really missing; "IL:12.34" reads as an invert.
8. **Tags and cascade (#1372, #1377, #1378, #1379):** removing a source tag erases its stored records; the compare can read a reference DWG that is open; the cascade writes a pipe's two level texts together or not at all and re-links only the pipes its preview lists.
9. **Settings page (#1370):** CDS gets a seventh tab "Newer tools" and CEMANAGER > Settings > Civil gets two inner tabs; 23 existing values become visible (no new value, no default changed).

## 7. Bugs only partly fixed (do not call them fixed)

1. **BUG-709** (#1352 is the range part only), **BUG-713** (#1342; reviewer's second point), **BUG-736** (#1359 is the "IL:" wording only), **BUG-745** (#1345, #1350; the block's own size and the scale fallback are still in drawing units).
2. Also partial by the review: **BUG-701** (#1369, transform RMS units open), **BUG-703** (#1371 part), **BUG-704** (#1361; check the raw-DWG reader fix against entry 1170.1), **BUG-705** (#1374), **BUG-739** (#1373, report half), **BUG-718** (#1347 is the culture part; the rest is in #1351, not in this train), **BUG-699** (#1352, range part).

## 8. Redo-killer sweep (standing rule)

1. Watched calls in added non-test lines: two `StartOpenCloseTransaction` reads (`DesignLevelService.cs`, `XcivilImportReportService.cs`; REDO is kept by the standing rule). No `StartTransaction`, `SetCurrentView`, `SetSystemVariable`, `Application.Idle`, `CommandWillStart`, `DocumentActivated`, selection-changed or timer line added in Drainage, Manager or Shared. The redo guard test passed in the Civil net10 run and in the net48 focused run.

## 9. Builds

1. **Whole `CE_ACAD_PLUGIN.slnx` Release**, `-m:1`, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net48 refs from the CERef 24.3.0 folder, net8 refs from the 2026 ref folder passed as `_AcadRefNet8`, net10 off the AutoCAD 2027 install: **0 errors, 885 warnings** (same warning count as C-42 and C-43), 4 min 9 s.
2. The native transform file was copied from another built worktree (it is a 0-byte stub on this machine in both places; the build and the tests accept it) and removed again by `git clean -fdXq`. The shared build lock was taken and released around every build and test run (no waits). C: 21 GB at the start, 20 GB after the clean.

## 10. Tests (net10 with AutoCAD 2027 on PATH, `--no-build`, one NUnit worker, log folder redirected to scratch; every run printed a non-zero total)

1. **THE PROBLEM: the Civil net10 run crashes.** `XcivilImportTargetExtentsLeaveOutTests` (a new test file from the #1356 fix round, entry 1158) builds a drawing database in the test (`new Database(true, true)`), and with real AutoCAD 2027 DLLs on PATH the native code throws an access violation (0xC0000005) in `LeavingOutEverything_GivesNoExtents`. The test host dies at test number about 14,792 of about 18,430, so everything after it never runs, and the run still prints a "Failed" summary line that looks like a normal result. The other class in this repo that builds a database (`MultiPlanNetworkDrawingStoreTests`) is marked `[Ignore("Requires live AutoCAD host; standalone Database construction can crash AutoCAD 2027 native APIs.")]` for exactly this reason. **Finalizer: add the same `[Ignore(...)]` to `XcivilImportTargetExtentsLeaveOutTests` (or move the two Database tests to the AutoCAD run).** I did not commit this (not a pin; brief says tell the finalizer). To see the rest of the suite I added `[Ignore]` to that class in my working copy only, rebuilt the Civil test project, ran, and then reverted the file with `git checkout` before pushing; the pushed branch does not contain it. I could not exclude the class by a test filter: four filter forms (class name, two method names, with and without a positive clause) all still ran it in the full run, although the same negative filters worked on small selections. Do not trust a filter to skip it.
2. **Civil (Drainage.Tests, net10), with the class ignored locally:** **18,427 run, 18,404 pass, 22 skipped, 1 failed.** C-43 was 18,129 / 18,109 / 19 / 1. The 298 extra tests are this train's; the 3 extra skips are the locally ignored class. The one red is `BackTest_GlenEira24115_Computed_WithinTolerance`, the known one on the plain base. The redo guard, the command count test, the Help guide count test and the registry-hash tests passed.
3. **Manager:** 751 / 751 (C-43: 751).
4. **Smaller suites:** CommandTruth 64/64, TestHarness 101/101, Spine 81/81, Diagnostics 19/19, AI.Core 42/42 (net8), ReleaseTests 16/16. All equal C-43.
5. **Installer.Tests** (brief's filter, net9): 273 run, 237 pass, 36 fail. Same counts as C-38 to C-43. I did not diff the 36 names. The filter did take effect here (280 tests listed, 273 run).
6. **Focused net48 run** (Drainage.Tests, the 41 changed test classes plus RedoSafe and DoubleClick; the crashing class left out): 656 run, 599 pass, 47 skipped, **10 failed, all `InvalidProgramException`** (the net48 lane builds against AutoCAD reference stubs with no method bodies, so a test that touches an AutoCAD value type throws; they pass on net10): `LandXmlPitClashRuleTests` x3 (`NothingLeftOut_NothingChangesAndNoLine`, `PipesNamingALeftOutPit_LeaveThatEndOpen_AndAreSaidInOneLine`, `SwitchOff_PipesKeepTheirPitNames`), `TrenchGrateCoverMemoryTests` x2 (`TheLiveLength_InAMetresDrawing_IsWordedInMillimetres`, `TheLiveLength_InAMillimetreDrawing_IsUnchanged`), `XcivilPitFloorNotInvertTests` x4 (`ManyPits_GiveOneSummaryLine_NamingTheCountAndTheFirstPits`, `NoDepthColumn_NothingToSay`, `PitFloorFromCoverMinusDepth_IsNotAddedAsAPipeInvert`, `SwitchOff_KeepsTodaysDerivedInvertText`), `XcivilScheduleBareCoverTests` x1 (`DrawnTableRow_CoverThenInvertWithNoCl_KeepsTheCover`). Same trap as C-42; the fix is in the tests (read the value, not the stub, or skip on the stub lane).
7. **Not run:** Structural tests (no Structural file touched), AI.Harness tests, Manager on net48, accoreconsole, anything in AutoCAD, each PR alone.

## 11. Hygiene

1. **Settings files, size and hash start unchanged before and after:** `CD_Settings.json` 15,270 bytes ACD64E79; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes 622A246F; `CE_STRUC_SUITE\CS_Settings.json` 34,858 bytes 24D8E5F7.
2. **Live CE folders under the roaming profile (files / bytes), identical before and after:** CE_CVL_SUITE 103 / 30,036,180; CE_STRUC_SUITE 2,476 / 2,096,981,693; TIM_CE_CADTOOLS 22,361 / 1,130,095,524.
3. **AutoCAD:** not running at any point; I did not start it. Nothing was written to the application plugins folder. `git clean -fdXq` done, worktree clean, no screenshots or docs images regenerated into the commit.

## 12. What the finalizer should do

1. **Fix the test crash first** (section 10.1): `[Ignore]` on `XcivilImportTargetExtentsLeaveOutTests` like `MultiPlanNetworkDrawingStoreTests`. Until then no full Civil run completes.
2. **Merge #1351** by hand (section 2.12), or leave BUG-718 partial and fix #1347's log sentence.
3. **Confirm the fix rounds** (section 3) against their review entries, and re-review #1346 and #1347's follow-up commits.
4. **Add the C-44 merge entry** to the log (the assembler adds none) and fix the ten net48 stub-lane tests if the net48 test run is part of the gate.
5. **Settings window:** 14 new switches have no row on the Newer tools tab (R-00). Decide whether that blocks the install.
6. **Question for Tim (entry 1173, engineering, RULES 4.5):** in the pit schedules these drawings come from, is "pit depth" measured to the pit floor or to the outlet invert? #1366 keeps the safe Unknown until he answers.
7. **Codex recipe additions** from entries 1167 and 1184 (TW spot in a CDSLAB slab; two DP3 blocks offer DP4; CDTG in a copied drawing; a survey XREF with a "650.2" lot-area text still loads; X-Civil Replace lands on the first import; a slab spot written "RL 18.600" still offers a pit level; PDF-less X-Civil test copy pit cover count; LandXML with a pit number you already drew; CDIMPORTLANDXML Abort, Esc, Enter, Replace; quad faces in the XREF and the raw DWG; metre survey XREF in a millimetre drawing; no-units millimetre drawing far from the origin; CDTAG Remove, U, REDO, AUDIT; CDIMPORTCOMPARE with the reference DWG open).
