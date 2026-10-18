# Train C-45 finalizer report (Civil + Manager), Mon 19 Oct 2026 (about 08:23 to 09:15, Melbourne time)

**ANSWER FIRST**

1. **Verdict: GO.** Train `claude/rel-20261019a`, final head `a72ab578089608dec9b92b514a7aef1c5ea517e3` (was 0c9b0f21; one finalizer commit on top, normal fast-forward push, leak scan clean). Built and unit-tested only. Nobody has opened it in AutoCAD. Nothing installed, deployed or version-edited; AutoCAD and accoreconsole were not touched.
2. **The three unreviewed PRs:** #1436 MERGE (1 LOW), #1437 MERGE (2 LOW), #1438 MERGE, shipping switched OFF (1 MEDIUM to fix before anyone turns it on). **Nothing reverted.**
3. **Fix rounds:** all 22 MERGE-WITH-FIXES heads cure what their review entries asked (diffs read, not titles). The leftover LOW items (#1427, #1424 missing-level half, #1409 items 1 and 2, #1406 item 2, #1416 follow-up, #1403) are truly LOW and accepted.
4. **What I changed (commit a72ab578):**
   1. **CDTWL "usual level" switch turned OFF** (`linking.topWaterLevelDefaultIsHighestObvert`, from #1411). Which pipe "the highest detention pipe" means is your engineering call and is still queued, so CDTWL keeps offering the level it offers today.
   2. **The 18 net48 test failures fixed in the tests**, as C-44 did. The AutoCAD 2027 lane still runs every test for real.
   3. **REGRESSION_LOG entry** for the finalizer and the train.
5. **Manager must ship with this train:** #1388 and #1389 change Manager's windows (matching-pair rule). Nothing under `Shared/` changed, so CE_SHARED is identical for Civil and Manager.
6. **Tests at the final head:**
   1. **Whole solution, Release:** 0 errors, 885 warnings.
   2. **Civil net10:** 18,800 run, 18,780 pass, 19 skipped, 1 failed. The one failure is the known Glen Eira back-test, which also fails on the plain base.
   3. **Manager net10:** 757 of 757.
   4. **Civil net48 focused:** 769 run, 758 pass, 11 skipped, 0 failed.
7. **Correction to the assembly report:**
   1. **The 18 net48 failures:** only 9 are this train's new tests. The other 9 are older tests over older code. The assembler's class list held a stray name, "Row", which pulled in every test with "Row" in its name.
   2. **Civil pass count:** the assembler's three parts add up to 18,779 passes, not 18,780.
8. **Your settings files:** unchanged (size and checksum read before and after).

---

## 1. The three PRs no Opus review had seen

1. **#1436 (BUG-815), MERGE, 1 LOW.**
   1. **The fault:** CDCHECKS rule R-06 treated a 100 or 150 downpipe as a detention pipe whenever a "0" was stored in its detention-length field.
   2. **The fix:** only a real positive length counts now. No switch: the old behaviour is the bug, and the change only removes a false warning.
   3. **LOW:** two other places still use the old "not blank" test (`PipeWindowPrefill`, `PipeSizeNetworkReviewService`). Carpark suggestion.
   4. **Caveat:** the cause was read from the code, not seen in AutoCAD.
2. **#1437 (BUG-683), MERGE, 2 LOW.**
   1. **What changes:** CD's same-plan break now asks the real total length before it works out the far level and the grade. 1 in 100 from 20.00 over a real 50 m gives 19.50, not 19.80 over the drawn 20 m. The switch is ON (the old answer is wrong).
   2. **Units:** the offered default reads the drawing's units, so millimetre and metre drawings both offer the right figure.
   3. **Cancel:** cancelling the new question draws nothing and leaves your line where it was.
   4. **Checked:** this PR's own branch sits on the pre-fix #1435. On its own it would take out #1435's and #1434's fix rounds. The train's merge kept both: read on the head, and their tests pass.
3. **#1438 (BUG-709 reading half), MERGE, ships OFF.**
   1. **With the switch on:** CDSURVEY's XREF reader also reads multi-line text, and block attributes tagged LEVEL, ELEV, EL, ELEVATION or LVL.
   2. **MEDIUM, only when switched on:** the raw-survey DWG reader (CDSURVEY step 2's pairing) was not given the same rule. A survey written only in multi-line text would pair nothing. Fix it before the switch is turned on.
   3. **LOW:** a pit block's LEVEL attribute in a survey XREF could be read as a ground spot.

## 2. Fix rounds and leftover LOW items

Full list in the review log, entries 1273 and 1274. In short:

1. **The 22 fix rounds:** every one is a descendant of its reviewed head and cures its finding.
2. **Redo guard:** the train's baseline correctly counts three writes in the drawn-schedule cell handler (#1410 + #1426).
3. **One new LOW (#1403):** the design-review copy of your Settings is made without the Settings loader's own read rule. A design-table row an office deleted could reappear in the review's copy. Edge case; carpark suggestion.

## 3. New Settings switches (32, all Civil)

Your `CD_Settings.json` holds none of these keys (read today), so the defaults below are exactly what your PC gets.

1. **New behaviour, switched ON (29).** In each one, today's behaviour is the bug:
   1. `schedulePairRowsByOrderOnlyWhenSafe`, `pitScheduleDepthOneRule`, `designReviewReadsOfficeSettings`
   2. `pitScheduleXrefSeparatesSaveAsCopies`, `longSectionOlderWriterChecksLevels`, `levelTextRoundsHalfAway`
   3. `recoverInvertsChecksDrawnText`, `scheduleMoveKeepsRecords`, `scheduleDeleteCellStaysBlank`
   4. `scheduleFromKeepsPitNumber`, `scheduleMergedRowsKeepOwnPipe`, `qaMarksStaleOnCeWrites`
   5. `xrefRepairAvoidsHostAndPrefersMatchingFolder`, `scheduleContinuationRepeatsPitColumns`, `profilePitWidthCountsSpsRadiusOnlyOnPumpStations`
   6. `scheduleRowOrderByPit`, `longSectionBridgeFullBoreFlowRow`, `scheduleWindowMarksOnlyChangedCells`
   7. `scheduleTypedCellsMustBeClean`, `profileRouteDefaultsToItsOwnScheduleSet`, `wsudAreasHeldToSite`
   8. `sourceTagRefusalsInPlainWords`, `paletteCloseKeepsYourSelection`, `scheduleOutletVsLargestInlet`
   9. `raingardenPositionIsAreaCentre`, `longSectionFrameIncludesPipeStubs`, `cdUphillAnswerUpdatesSchedule`
   10. `cdUphillCancelPutsBackWhatItCan`, `cdSamePlanRealLengthFirst`
2. **ON, and ON means today's behaviour:** `showOlderLongSectionTab`. The CDCALC Older longitudinal tab stays visible, per your 18 Oct ruling. Checked in the model and in the window's fallbacks.
3. **OFF:**
   1. `surveyReadsMTextAndMoreTags` (#1438).
   2. `topWaterLevelDefaultIsHighestObvert`, **turned OFF by me.** Its old behaviour is not proven to be the bug. It stays OFF until you answer which pipe is "the highest".
4. **No row on the Settings page (Newer tools tab) for any of the 32.** Fine to ship; this is the standing R-00 LOW. List for Codex: every key in items 1 to 3.

## 4. What you will see in AutoCAD after this train is installed (none of it seen in AutoCAD yet)

1. **CDPROFILE:**
   1. A grate whose cover was skipped says its cover is not known, instead of drawing the ground at RL 0.
   2. A 225 before a 375 is drawn 225 deep.
   3. An invert above the cover is named.
   4. A datum too high is refused, with the highest datum you can use.
   5. A rising pipe shows no grade and says "P1 to P2 rises along the flow".
   6. A 600 x 600 pit is 600 wide in the section.
   7. A route in "Main" opens on "Main".
   8. The existing-pipe stub sits inside the frame.
2. **CDCALC Older longitudinal tab:**
   1. Still there.
   2. It refuses to export with a blank cover and names the pit.
3. **Drawn Pit Schedule:**
   1. MOVE or STRETCH no longer changes covers, sizes or levels.
   2. Typing "21,15" snaps back with a plain line.
   3. Delete cell stays blank.
   4. FROM shows "C1", not "C".
   5. A continuation sheet repeats the pit's number, size, outlet and cover.
   6. A pump station's depth stays put.
   7. No "-0.00".
4. **Pit Schedule window:**
   1. A new inlet sits under its pit.
   2. The AG row under merged downpipes shows the AG pipe.
   3. F2 then Enter marks nothing.
   4. OUTLET SMALLER THAN INLET shows as soon as the window opens.
5. **CD:**
   1. The Uphill box answer updates the schedule row.
   2. Cancel brings your line back.
   3. A same-plan break asks the real length first.
6. **Checks and reports:**
   1. "CE could not check ..." replaces a false green Network OK, and it cannot be ignored.
   2. Checks rows say "unnamed pipe".
   3. Project QA goes stale after CE edits.
   4. CDCHECKDWG says damaged data could not be read.
   5. CDCHECKS loses the false R-06 rows on downpipes.
7. **Other commands:**
   1. CDDASHBOARD and CDCHECKDWG judge by your Settings design values.
   2. CDXREFREPAIR never offers the drawing itself.
   3. CDRG sits in the middle of the shape.
   4. WSUD holds an impossible impervious area to the site, with a note.
   5. CDTAG refusals are in plain words.
   6. Closing What CE Found keeps your own selection.
   7. Recover Inverts redraws deleted IL texts.
   8. CDPROPAGATE keeps a hand-typed level on a pipe drawn from its low end.
   9. X-Civil import leaves unreadable schedule rows blank.
   10. CDSPOONDRAIN ignores a repeated pick.
8. **Manager:**
   1. Dark theme tabs are readable.
   2. Status cards show "3.0.55" with the build code underneath.
9. **CDTWL:** unchanged (switch OFF).

## 5. Do not mark FIXED (built and unit-tested only)

1. **New in this run:** BUG-683, BUG-709 (reading half, switched OFF), BUG-815 (cause unconfirmed).
2. **Already listed:** everything in review entries 1224 and 1266.
3. **Stay OPEN even after an AutoCAD pass:** BUG-777 (your question), BUG-772 (your question), BUG-770 (missing-level half), BUG-709 (dimension half and the raw-reader MEDIUM), plus the lists in 1224 and 1266.

## 6. Risks

1. **Unit tests and source guards only.** The drawing-level proof is the Codex pass. Recipes are in entries 1224.1 and 1266.1, plus:
   1. CD same-plan break with real length 50 m on a drawn 20 m.
   2. CDCHECKS on the run 31 downpipes.
2. **Biggest visible changes on day one:**
   1. Existing drawn Pit Schedules change "C" to "C1" in FROM at the next refresh.
   2. Design Review verdicts follow your Settings values.
3. **Your questions still open (in the Monday file, not touched by me):**
   1. CDTWL highest pipe.
   2. WSUD hold or blank.
   3. Hide the CDCALC Older tab.
   4. LBUH dots.
   5. Pit depth on X-Civil schedules.
4. **Not run:** Installer.Tests, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural (no Structural file changed), Manager on net48, each PR alone, the base on net48 (the older 9 failing there is by reading), AutoCAD, accoreconsole.

## 7. Hygiene

1. Worked in a private worktree, `C:\ce-fin\c45`.
2. The build lock was taken only while each command ran and is released.
3. Every run used Below Normal priority, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, and the refs from the C-45 assembly report.
4. **Manager tests:** they need the CE log folder inside the system temp folder. My first run put it elsewhere and 3 hygiene tests failed. The re-run with a temp folder passed 757 of 757.
5. **Your settings files, size and checksum at 08:28 and at the end, unchanged:**
   1. `CD_Settings.json`: 15,270 bytes.
   2. `TIM_CE_CADTOOLS\CS_Settings.json`: 351,713 bytes.
   3. `CE_STRUC_SUITE\CS_Settings.json`: 34,858 bytes.
   4. `CE_CVL_SUITE\settings.json`: 672 bytes.
6. AutoCAD was not running at the end.
