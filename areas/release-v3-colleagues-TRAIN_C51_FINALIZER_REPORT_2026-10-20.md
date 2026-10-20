# Train C-51 finalizer report (Civil + Manager), Tue 20 Oct 2026, 12:44 to 13:05 (Melbourne time)

**ANSWER FIRST**

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020e` @ `ec358f0bcfcacbd8c3b3936eb6741b2e246de9e5`. Same as the assembly report. `git ls-remote` checked at the start (12:44) and again at the end (13:00); both gave this sha.
3. **What I changed:** nothing. No commit on the train, nothing pushed to the plugin repo. No fix was needed and no default had to be turned OFF.
4. **Manager must ship: no.** The train changes 6 files: 4 in `Modules/Drainage`, 1 in `Modules/Drainage.Tests` and `REGRESSION_LOG.md`. No Manager, Installer, Shared (CE_SHARED), csproj, props or slnx file.
5. **Tests (Release, at the final head):**
   1. **Whole solution:** 0 errors.
   2. **Civil net10 full:** 18,909 run, 18,888 pass, 19 skipped, **2 failed**: Glen Eira (the known red) and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` ("The PDF renderer produced only blank page(s)", 16 s). The PDF one is NOT caused by this train: its file is not in the merge, and it **passed when re-run on the same build** (MarkupFileImageLoaderTests 15 of 15). It is the Windows PDF renderer being slow under load. I did not run it on the base.
   3. **Manager net10 full:** 824 of 824.
   4. **Civil net48 focused:** 218 run, 217 pass, 1 failed (`Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`, the `InvalidProgramException` from the net48 reference stub). Same test and same error as C-49, C-50 and the C-51 assembly run; its files are not in this merge.
   5. **Red check of #1484 (mine):** I put the old "must wholly surround" rule back for one run. **3 of the 25 sheet-frame tests failed**, including the one built from the exact run 36 border and window. So the new tests really test the new rule. Then I restored the code before the full builds.
6. **What Tim will see in AutoCAD (once C-51 is installed):**
   1. **Tidy labels and the automatic tidy after a MOVE** stop saying "No clear spot ... (on "the block Drawing Border")" when the pipe starts inside the border, even if the pit at the other end sits outside the border's edge (the run 36 drawing: pipe P3 -> P2).
   2. Pits, PIT LABEL blocks and ordinary blocks are still avoided as before.
   3. **The callout drag words** ("Would sit on top of ...") stop naming the drawing border when the callout point is near the border's edge.
   4. Turning `linking.tidyIgnoresSheetFrame` OFF gives exactly today's behaviour.
7. **Do not mark FIXED:** BUG-141. Built and unit-tested only. Nobody has run it in AutoCAD. The "SC" text half is not covered at all. The standing lists from C-49 and C-50 still apply.
8. **Switches and defaults:** the train adds **no new switch and no new default**. It widens what the existing switch `linking.tidyIgnoresSheetFrame` (ON) treats as the sheet frame. The old behaviour (the Drawing Border blocking every label) is the bug Tim reported, so ON stays.
9. **Switches without a Settings row (not built):** `linking.tidyIgnoresSheetFrame` (C-47, still only in `UserSettings.cs`); standing: `linking.tidyPitByBodyOutline` (C-49), `detention.detentionWithoutLengthNotDiameterChecked` (C-47), `survey.surveyReadsMTextAndMoreTags` and the rest of C-45's 32.
10. **Risks:**
    1. **A big ordinary block can now stop being an obstacle (LOW, accepted).** Any plain block more than twice the search area each way that holds the pipe's start and the area's centre is ignored. On a 20 m pipe that means a block over about 46 m by 7 m; for a pit's cover text or a callout point, over about 6 to 9 m each way (a large tank or building block). Before, the same block was already ignored when it surrounded the area; now it is also ignored when the area pokes out past one edge. The cost: a label may be left sitting over that block's linework instead of being pushed off it. Pits are never affected (they are measured separately and never treated as a frame).
    2. **The pipe's start is the test point (LOW).** A pipe drawn from the outside pit inwards still gives today's "No clear spot" on the border. Safe side.
    3. **Metre drawings (LOW, not new).** The search margin is a fixed 1,550 drawing units, so in a metre drawing the area is huge and no border ever counts as the frame. That was already so before this train; the "metre" test leaves the margin out.
    4. **The "more than 2 times" number is still fixed in the code (LOW, follow-up).** See section 2 item 3.
    5. **Not run:** Installer.Tests (compile only, rule), the full net48 lane, Structural, anything in AutoCAD or accoreconsole.
11. **Installer safety:** nothing on this train touches the installer. **#1475 (the installer PR the brief names) is not on C-51**: it is an open draft on base `claude/rel-20261019a`, head `f2c6f848`, and it was not merged. So C-51 cannot affect the signed-update gate (`OfficialReleaseGate`) in any way. Note for whoever trains #1475 later: it edits `Shared/CE.Release/OfficialReleaseGate.cs` itself and three CE_SHARED files, so that train will need a full gate review and both Civil and Manager shipping.
12. **Your settings files:** unchanged (size and first 8 of SHA-256 at 12:45 and 13:00).

---

## 1. Re-review (step 1)

1. **Merged PRs:** one, #1484 (merge `ec358f0b`, PR head `01fb0b2a`). No PR on this train had a MERGE-WITH-FIXES verdict.
2. **Review entries:** the Sonnet fix draft is entry 1419. Fable round 11 reviewed it in entry 1470 (MERGE, 2 LOW). There was **no Opus entry**, so I reviewed it fully (section 2).
3. **Shared/:** unchanged (`git diff --stat` base to head lists 6 files, none under Shared/). Civil and Manager keep the same CE_SHARED.

## 2. #1484 full review (step 2): MERGE

1. **(a) Does it fix the run 36 case?** Yes, from the code and the numbers.
   - Border (-3981.69,-54945.80)-(75518.31,1754.20) is 79,500 by 56,700. Window (52658.32,-27344.04)-(78899.44,-21795.72) is 26,241 by 5,548. Ratios 3.03 and 10.22: passes "more than 2x each way".
   - Window centre (65778.88, -24569.88) is inside the border (x below 75,518; y inside).
   - The pipe start (pit P3) is inside the window's left part. The window's left edge is the pipe's left end less the 1,550 margin, so P3 is near x 54,200 to 56,000, well inside the border. The test uses (54500, -24600). The real P3 point is not in the log; this is my reading, not proven.
   - **The RED is real:** with the old rule put back, 3 tests fail, including `Run36Border_WhoseRightEdgeIsShortOfTheWindow_IsASheetFrameWhenItHoldsTheLabelStart`.
2. **(b) Can a real obstacle disappear?**
   - **Pit:** no. A pit is marked `isPit` in the scan and never enters `PlainBlocks`, and only `PlainBlocks` can be a frame.
   - **Hatch or polyline:** not in scope. The scan reads text-like objects and blocks only.
   - **Ordinary label, symbol, PIT LABEL:** no. They are far under 2x the window.
   - **A big ordinary block (site plan bound as a block, a large tank, a building):** yes, if it is over 2x each way and holds both points. Before this PR the same block was already ignored when it surrounded the window, so the new risk is only the "pokes out one side" case. The obstacle was the block's whole rectangle, which for a block that size mostly produced "No clear spot" anyway, not a better spot.
   - **Judgement: acceptable for a switch that is ON.** The old behaviour is the reported bug, OFF restores today, and the worst case is a label left over a big block's linework, which the drafter sees and moves. Listed as a risk (answer first 10.1).
3. **(c) R-00, the 2x number:** may follow as a LOW. It is a shape test ("is this block the sheet?"), not an engineering value: no design standard, clearance or council number depends on it, and it is unit-free. Putting it on the Settings page now needs a new row, which this job must not build. Follow-up: add `linking.sheetFrameSizeRatio` (default 2) with a row when the Tidy settings rows are built.
4. **(d) Other checks:**
   1. **Millimetre and metre:** the size and point tests are unit-free; the fixed 1,550 margin is old (risk 10.3).
   2. **Switch OFF equals today:** `IsSheetFrame` returns false first when OFF. Test `SwitchOff_TheStartPointChangesNothing_TodaysBehaviour`.
   3. **The #1483 log reason agrees:** `WhyNotSheetFrame` uses the same `IsMuchBigger`, `Surrounds` and `HoldsTheLabel` helpers and returns null exactly when `IsSheetFrame` is true. Test asserts it on the run 36 numbers.
   4. **Redo-safe:** no new write, transaction or saved data. The scan is still read-only.
   5. **Locked layers:** nothing is unlocked or bypassed; only which object counts as an obstacle changes.
   6. **Second path (Fable LOW, confirmed):** the callout-drag nearby words (L8) now also pass their own point, so a border near the callout point is no longer reported as "Would sit on top of". The REGRESSION_LOG entry says it in one clause only. Advisory text only; acceptable.
5. **Verdict: MERGE (GO).** 4 LOW, no fix needed on the train.

## 3. Defaults (step 3)

1. **New switches:** none.
2. **Changed default:** none. `TidyIgnoresSheetFrame` stays `= true`; only its comment changed in `UserSettings.cs` (+3 -2).
3. **Behaviour change by default:** yes, under that ON switch (answer first item 6). Old behaviour is the bug (BUG-141, Tim's report), so it stays ON.

## 4. Test evidence (step 5)

1. **Environment:** private detached worktree `C:\ce-fin\c51` at `ec358f0b`; Release; `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`; `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`; AutoCAD 2027 folder on PATH; 0-byte `CE_TRANSFORM_2027.arx` placeholder; Below Normal; every command in the foreground; Temp and logs inside `C:\ce-fin`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` written only while each command ran (checked gone at the end). Nothing deployed. No AutoCAD, no accoreconsole.
2. **Timings:** red check 50 s; whole solution 3 m 01 s first, then 59 s; Civil net10 full 5 m 26 s; PDF re-run 35 s; Manager 7 s; net48 focused 10 s.
3. **Slip of mine:** my first two solution builds stopped on `Installer.Tests` with "git exited 9009" because git was not on the PATH my script handed to dotnet. Not a code fault. I passed the git path as a build property and the build went to 0 errors. Cost about 2 minutes.
4. **Hygiene:** worktree removed with `git worktree remove --force`, `c51tmp` and `c51logs` deleted (logs copied to my session scratchpad first). The plugin checkout's working tree is as I found it. **Not mine, left alone:** `C:\ce-fin\logs` (3.5 MB of 19 Oct test logs from an earlier job).
