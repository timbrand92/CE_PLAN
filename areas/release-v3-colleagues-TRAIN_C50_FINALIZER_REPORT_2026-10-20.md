# Train C-50 finalizer report (Civil + Manager), Tue 20 Oct 2026, 11:13 to 11:45 (Melbourne time)

**ANSWER FIRST**

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020d` @ `82a58cda850d6c005726b93bd7a147a6cbf61b94`. Same as the assembly report. `git ls-remote` checked at the start (11:14) and again at the end (11:41); both gave this sha.
3. **What I changed:** nothing. I made no commit on the train and pushed nothing to the plugin repo. No fix was needed and no default had to be turned OFF.
4. **Manager must ship: no.** The train changes 9 files: 5 in `Modules/Drainage`, 3 in `Modules/Drainage.Tests` and `REGRESSION_LOG.md`. No Manager, Installer, Shared (CE_SHARED), csproj, props or slnx file changes.
5. **Tests (Release, at the final head):**
   1. **Whole solution:** 0 errors.
   2. **Civil net10 full:** 18,898 run, 18,878 pass, 19 skipped, 1 failed (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red).
   3. **Manager net10 full:** 824 of 824 pass.
   4. **Civil net48 focused:** 207 run, 206 pass, 1 failed (`Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`, an `InvalidProgramException` from the net48 reference stub).
   5. All counts equal the assembly run's. Neither red is new.
6. **What Tim will see in AutoCAD:**
   1. **Same-plan break (BUG-683):** nothing new. Only a test changed.
   2. **CDSURVEY (BUG-709):** nothing new by default, because the switch `survey.surveyReadsMTextAndMoreTags` stays OFF.
      - When it is turned on, CDSURVEY also finds levels written as multi-line text, and in tags LEVEL, ELEV, EL, ELEVATION and LVL.
      - It finds them in the survey XREF and in the raw survey DWG alike, so step 2 no longer reports too few pairs.
   3. **Tidy labels (BUG-141):** nothing changes on the drawing.
      - With CDDEBUG On, the CE log gains one line for each ordinary block (for example "Drawing Border") that Tidy labels keeps as an obstacle.
      - The line gives the block's layer, its corners and the search window's corners in drawing units, and why the block was not treated as the sheet frame.
7. **Do not mark FIXED:** BUG-683, BUG-709 (ships OFF; the dimension-text half is not done) and BUG-141 (diagnostic only; the "SC" obstacle is a text, which this line does not cover). The standing lists from C-49 (entries 1393, 1366, 1375, 1382) still apply. Everything here is built and unit-tested only: not installed by me, not tested in AutoCAD, not Tim-accepted or Codex-accepted.
8. **Switches without a Settings row:** the train adds no new switch.
   - Standing: `survey.surveyReadsMTextAndMoreTags` (OFF, one of C-45's 32; still not in `SettingsValueCatalog.cs`).
   - Standing: C-49's `linking.tidyPitByBodyOutline`.
   - Standing: C-47's two (`detention.detentionWithoutLengthNotDiameterChecked`, `linking.tidyIgnoresSheetFrame`).
   - Standing: the rest of C-45's 32.
   - I built no rows.
9. **Risks:**
   1. **Survey reader (low, and only with the switch ON).** An XREF that also holds pit blocks with a LEVEL attribute would add those levels as ground spots. The surface-disagreement check keeps a disagreeing one Unknown. The Settings note says so.
   2. **Log line work (LOW).** The new log line text is built even when CDDEBUG is off, before the logger throws it away. This only costs time, once per kept block per pipe. It changes nothing on the drawing and does not block GO.
   3. **Tests not run:** Installer.Tests (compile only, by rule), the full net48 lane, Structural, and anything in AutoCAD.
10. **Your settings files:** unchanged. I checked the size and the first 8 characters of the SHA-256 at 11:16, and again at 11:40.

---

## 1. Re-review (step 1)

1. **Verdicts read:** REVIEWLANE_LOG entries 1403 to 1410. #1437 MERGE (1404) and #1438 MERGE (1405), each at the head that was merged. #1483 was MERGE-WITH-FIXES (1406), and its fix round (1410, `f40de93d`) had no Opus re-review entry. Every merged PR has a review entry.
2. **#1437 (head f5e5472a, merged by `1b20cbfd`):** I read the merged diff. It is only the test-path change: 2 lines in `SamePlanLevelLengthTests.cs` now use `TestPaths.SourceFile` in place of four ".." steps, plus one REGRESSION_LOG line. No product code changed. **Confirmed.**
3. **#1438 (head bccc9ca5, merged by `06787d1b`):** I read the merged diff (4 code and test files plus the log). It is the cured raw-DWG reader.
   1. `ReadSpotLevels` now receives the switch value. With the switch OFF it skips multi-line text and accepts only the RL tag, exactly as the old reader did. In ACadSharp, multi-line text is a separate type from single-line text, so an OFF read takes no new path.
   2. With the switch ON it uses the same `IsLevelTag` and `TryParseRl` rules as the XREF reader. A new `PlainMTextValue` strips the formatting codes.
   3. A spot from an RL tag is still labelled "ATTR:RL", the same as before. No product code compares these labels (checked by search), so the new "ATTR:ELEV"-style labels cannot change any decision.
   4. The only change in `UserSettings.cs` is the help text. The default stays `= false`. **Confirmed: switch OFF.**
4. **#1483 fix round (596b8c5c to f40de93d, merged by `82a58cda`):** I read the diff from my reviewed head, leaving out the merge of C-49 (`a5b1f177`).
   1. **Layer:** `PlainBlockLayers` is filled on the same line as `PlainBlocks`, and the log line says "on layer X" ("?" when the layer is not known).
   2. **Units:** the figures now say "in drawing units" and print two decimals, so a metre drawing keeps 0.40.
   3. **CDDEBUG step:** the REGRESSION_LOG step says to turn CDDEBUG On first.
   4. **"SC" not covered:** said under "Not proven".
   5. **No decision changes.** `IsSheetFrame` is untouched. The new call sits after the sheet-frame `continue` and before `obstacles.Add`, the same items are kept and dropped as before, and it only writes to `LoggingService.Diagnostic`.
   6. The reason string uses the same four-side and "more than 2x" tests as `IsSheetFrame`, so it cannot disagree with the decision. Nothing is drawn, written or locked, and no switch is needed.
   7. **Verdict: MERGE.** One LOW, noted in Risk 2 and not a blocker.
5. **Shared/:** no file under `Shared/` (CE_SHARED) changed between `d25cefa8` and `82a58cda`, so Civil and Manager carry the same CE_SHARED as C-49.
6. **REGRESSION_LOG:** I counted 0 conflict markers in the train diff.

## 2. New defaults (step 3)

1. **The train adds no new Settings switch or default.** The only `UserSettings.cs` change is the help text for `SurveyReadsMTextAndMoreTags`.
2. **`survey.surveyReadsMTextAndMoreTags` OFF** (from #1438's first head, already in C-45/C-49). It would change what drafters see, and the old behaviour is not itself the bug (INT-073), so OFF is right. Nothing is turned ON and nothing needed turning OFF, so there is no commit.
3. **#1483** adds no switch. It is a log line that shows only with CDDEBUG On (`options.debugLogging`, default OFF).
4. **#1437** adds no switch. Its existing `CdSamePlanRealLengthFirst` ON was judged in C-49 and is unchanged.

## 3. Installer safety (step 4)

1. **#1475 is not in this train.** It shipped in C-47 (entry 1398). The C-50 diff touches no Installer, Manager, Shared or build file.
2. So this train **cannot affect the signed-update gate (`CeOfficialReleaseGate` / OfficialReleaseGate) in any way.** Installer tests were not run, by the compile-only rule.

## 4. Build and test evidence (step 5)

1. **Environment:**
   - Private detached worktree `C:\ce-fin\c50` at `82a58cda`, with a 0-byte `CE_TRANSFORM_2027.arx` placeholder at `Modules\Shared.Transform.Native2027\bin\x64\Release`.
   - Every command: Release, Below Normal, in the foreground, `-p:SkipDevBundle=true -nr:false --disable-build-servers`.
   - `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs` and `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`.
   - AutoCAD 2027 folder on PATH, Temp in `C:\ce-fin\c50tmp`, builds `-m:1`, logs to a file.
   - Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (checked gone at the end).
2. **Builds (0 errors each):**
   1. Civil plugin, both targets: 662 warnings, 8 min 54 s.
   2. Civil tests project: 155 warnings, 3 min 24 s.
   3. Whole solution: 96 warnings, 6 min 00 s. The run was incremental, so its warning count does not compare with a cold build.
3. **Test runs:**
   1. **Civil net10 full** (5 min 02 s): 1 failed, 18,878 passed, 19 skipped, 18,898 total. The only `Failed` line is Glen Eira. The total is in the thousands, so the `_AcadRefNet8` trap is not in play.
   2. **Manager net10 full:** 824 of 824.
   3. **Civil net48 focused** (Bug141, Bug709, SurveyLevelTags, SamePlanLevelLength, TidyObstacle, TextClashTidyUp, RedoSafe, DoubleClick): 207 run, 206 pass, 1 failed (the Bug141 net48 stub test).
4. **Neither red is new, and neither is in a file the train touches:**
   1. Glen Eira is the known red.
   2. The net48 red is in `R3BatchGuardTests.cs` and exercises `TextClashTidyUpObstaclePolicy`. Neither file changed between `d25cefa8` and `82a58cda` (checked with `git diff`).
   3. It fails the same way in the C-49 assembly and finalizer runs, and the C-49 assembler saw it fail on the base. I did not re-run the base.
5. **Settings files** (size, first 8 of SHA-256), before (11:16) and after (11:40), **unchanged:**
   - `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`
   - `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`
   - `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`
   - `CE_CVL_SUITE\settings.json` 672 `efe307c4`
6. **Not run:** Installer.Tests, the full net48 lane, CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, AutoCAD and accoreconsole.

## 5. Hygiene

1. AutoCAD and accoreconsole were not running (checked).
2. **Not done:** I deployed nothing, edited no version, made no train commit and pushed nothing to the plugin repo. No PR was closed or merged and no branch was deleted. Structural, #1382, #1384, #1419 and #1423 were not touched. `DESK_LOG.md` was not edited.
3. **Removed:** worktree `C:\ce-fin\c50` (1.71 GB), removed with `git worktree remove --force` and pruned. My folders `C:\ce-fin\c50logs` and `C:\ce-fin\c50tmp` and my script `C:\ce-fin\c50run.ps1` are also removed.
4. **Left as found:** the main checkout. `C:\ce-fin\logs` belongs to other jobs and was not touched.
5. **Slip of mine:** my first test-project build named the wrong project file, so dotnet stopped at once (0 s). Nothing was built and nothing needed a rerun.
