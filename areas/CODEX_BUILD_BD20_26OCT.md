1. **ANSWER FIRST — BUG-1174.** Build in progress. Untouched-base full suite: 20,539 total, 20,506 passed, 1 failed, 32 skipped. Draft PR, red/green checks, after-change totals and final branch head are pending. Nothing installed or checked in AutoCAD.

2. **Base and scope.** Fetched `origin/claude/rel-20261026u` at `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`, matching the brief's head. Branch `cx5/bug-1174-cdwt-says-why-no-window`; own worktree `C:\ce-cx\bd20`. C: had 44,738,764,800 bytes free at the first check. Only BUG-1174 is in scope.

3. **Baseline completed, 26 October 2026 evening, Melbourne time.** Untouched-base full Civil net10: 20,539 total, 20,506 passed, 1 failed, 32 skipped, duration 29 minutes 1 second. Failed test: `Diagnostic_MessagesReachTheLogFile`. The outer settings fixture also reported that its temporary `CE_CVL_SUITE.log` could not be removed because it was still open. No tracked source changed during the run. The first build attempt had stopped because the fresh worktree lacked `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx`; an empty, ignored, test-only placeholder there allowed the build and suite to run. AutoCAD 2027 is on the test process PATH. All commands use `SkipDevBundle=true`, `-nr:false`, `--disable-build-servers` and the brief's three reference paths. No AutoCAD process was started.

4. **Cause checked.** `ResolveMasterPath` returns an empty string for a blank Standard Details setting, a missing folder, or an existing folder without a recognised tank master drawing. CDWT currently asks the existing command-line question without explaining that result. The planned line uses only the stored folder value, with separate wording for those three cases.

5. **Shared-file notice.** BUG-1115 (cx_bd17) also changes `WaterTankCommand.cs`, near the later tank-point section. BUG-1174 belongs near the opening window fallback. No protected file or CE_SHARED source is to be changed.

6. **Not run and remaining work.** AutoCAD, the real tank window and real tank master files have not been opened. The line and default-on switch are now written; the green check is building. Still to do: check Settings coverage and fit, build three lanes, compare full-suite failure names, add the top regression entry, push a draft PR and this report, then remove this session's worktree.

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
