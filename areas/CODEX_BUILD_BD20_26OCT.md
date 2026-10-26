1. **ANSWER FIRST — BUG-1174.** Build in progress. Draft PR, red/green checks, full-suite totals and final branch head are pending. Nothing installed or checked in AutoCAD.

2. **Base and scope.** Fetched `origin/claude/rel-20261026u` at `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`, matching the brief's head. Branch `cx5/bug-1174-cdwt-says-why-no-window`; own worktree `C:\ce-cx\bd20`. C: had 44,738,764,800 bytes free at the first check. Only BUG-1174 is in scope.

3. **Baseline in progress.** Tracked source is unchanged. The first build attempt stopped because the fresh worktree lacked `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx`. Added an empty, ignored, test-only placeholder at that path and restarted the untouched-base full Civil net10 suite. AutoCAD 2027 is on the test process PATH. All commands use `SkipDevBundle=true`, `-nr:false`, `--disable-build-servers` and the brief's three reference paths. No AutoCAD process was started.

4. **Cause checked.** `ResolveMasterPath` returns an empty string for a blank Standard Details setting, a missing folder, or an existing folder without a recognised tank master drawing. CDWT currently asks the existing command-line question without explaining that result. The planned line uses only the stored folder value, with separate wording for those three cases.

5. **Shared-file notice.** BUG-1115 (cx_bd17) also changes `WaterTankCommand.cs`, near the later tank-point section. BUG-1174 belongs near the opening window fallback. No protected file or CE_SHARED source is to be changed.

6. **Not run and remaining work.** AutoCAD, the real tank window and real tank master files have not been opened. Still to do: prove the first two requested tests fail against the silent method, implement the line and default-on switch, check Settings coverage and fit, build three lanes, compare full-suite failure names, add the top regression entry, push a draft PR and this report, then remove this session's worktree.
