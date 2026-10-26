1. **ANSWER FIRST — BUG-1174.** All three Release builds: 0 errors each. Final BUG-1174 tests: 12 passed, 0 failed. Red first: 2 failed, 1 passed. Untouched-base full suite: 20,539 total, 20,506 passed, 1 failed, 32 skipped. The final focused run passed all 13 cases: 12 new BUG-1174 cases and the maintained source check. A fresh unfiltered full suite is running. Draft PR and final branch head are pending. Nothing installed or checked in AutoCAD.

2. **Base and scope.** Fetched `origin/claude/rel-20261026u` at `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`, matching the brief's head. Branch `cx5/bug-1174-cdwt-says-why-no-window`; own worktree `C:\ce-cx\bd20`. C: had 44,738,764,800 bytes free at the first check. Only BUG-1174 is in scope.

3. **Baseline completed, 26 October 2026 evening, Melbourne time.** Untouched-base full Civil net10: 20,539 total, 20,506 passed, 1 failed, 32 skipped, duration 29 minutes 1 second. Failed test: `Diagnostic_MessagesReachTheLogFile`. The outer settings fixture also reported that its temporary `CE_CVL_SUITE.log` could not be removed because it was still open. No tracked source changed during the run. The first build attempt had stopped because the fresh worktree lacked `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx`; an empty, ignored, test-only placeholder there allowed the build and suite to run. AutoCAD 2027 is on the test process PATH. All commands use `SkipDevBundle=true`, `-nr:false`, `--disable-build-servers` and the brief's three reference paths. No AutoCAD process was started.

4. **Cause checked.** `ResolveMasterPath` returns an empty string for a blank Standard Details setting, a missing folder, or an existing folder without a recognised tank master drawing. CDWT currently asks the existing command-line question without explaining that result. The planned line uses only the stored folder value, with separate wording for those three cases.

5. **Shared-file notice.** BUG-1115 (cx_bd17) also changes `WaterTankCommand.cs`, near the later tank-point section. BUG-1174 belongs near the opening window fallback. No protected file or CE_SHARED source is to be changed.

6. **Not run and remaining work.** AutoCAD, the real tank window and real tank master files have not been opened. A normal Settings row failed its off-screen height check in both themes: 725 px against the brief's 673 px limit. As expressly allowed by the brief, the row and all its window changes were left out instead of squeezing the page. The default-on switch stays in the saved settings, with default-on, typed-off, both round trips and unchanged-other-keys coverage. No window changes or new pictures remain. The three builds and final 12-test check passed; the top regression entry is present. Still to do: compare full-suite failure names, push a draft PR and this report, then remove this session's worktree.

7. **Red first, observed before implementing the line.** Added the method returning null, then ran `FullyQualifiedName~Bug1174` in the requested Civil test project. Actual result: 3 total, 1 passed, 2 failed. Both failed assertions expected the requested line and received null.

   ```text
   Failed WaterTank_Bug1174_BlankSetting_SaysNoFolderIsSet [31 ms]
   Expected: "[CE] Tank pictures not shown: no Standard Details folder is set."
   But was:  null
   Failed WaterTank_Bug1174_MissingFolder_LineNamesTheFolder [< 1 ms]
   Expected: "[CE] Tank pictures not shown: Standard Details folder not found at C:\Example Job\Standard Details."
   But was:  null
   Passed WaterTank_Bug1174_SwitchOff_NoLine [1 ms]
   ```

8. **Final green lines, 26 October 2026, Melbourne time.** All 12 final tests passed, including the unchanged-other-keys check after deserialising each saved switch choice. Actual requested-name lines:

   ```text
   Passed WaterTank_Bug1174_BlankSetting_SaysNoFolderIsSet [704 ms]
   Passed WaterTank_Bug1174_MissingFolder_LineNamesTheFolder [< 1 ms]
   Passed WaterTank_Bug1174_SwitchOff_NoLine [1 ms]
   Test Run Successful.
   Total tests: 12
   Passed: 12
   ```

9. **Three Release builds, observed.** net48: 0 errors (6 minutes 46 seconds); net8.0-windows: 0 errors (11 minutes 25 seconds); net10.0-windows: 0 errors (7 minutes 50 seconds). Existing warnings remain. Each command used all mandatory safe flags and reference paths. The unfiltered final net10 suite started after the passing focused run, using those current binaries.

10. **Existing source check maintained.** The first after-change full run caught `Cdwt_IsWaterTanksOnly_AsksOneModeQuestion_AndAppliesThroughTheOneAtomicRunner`, which was pinned to the old one-line lookup spelling. BUG-1174 captures the stored folder once so the lookup and its explanation name the same folder. Stopped that run after about two minutes; it is not a full-suite result. Confirmed no BD20 test host remained before editing. Updated only that assertion to check both the Settings capture and the lookup using it; every placement-safety assertion remains. No production code changed after the three passing builds. The 12 new cases and this maintained check then passed together: 13 total, 13 passed, 0 failed. A fresh unfiltered full suite started afterwards.

11. **Full-suite gate currently pending, 27 October 2026, Melbourne time.** The completed first after-change run reported 20,551 total, 20,517 passed, 2 failed, 32 skipped (29 minutes 4 seconds). It repeated `Diagnostic_MessagesReachTheLogFile` and added `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`: `The requested resource is in use. (0x800700AA)`. The outer settings fixture repeated the temporary log cleanup error. The PDF case passed on the untouched base, so that run does not meet the matching-failure-name gate. An unchanged isolated PDF recheck then passed: 1 total, 1 passed, in 21 seconds. A fresh unfiltered full-suite retry is running. No PDF code or test was changed, skipped or weakened; the complete result of that retry is still required.
