# BUGFIX pr2005: FIX-FIRST for draft PR #2005 (B-186, BUG-1046)

Tuesday 3 November 2026, about 8:10 pm Melbourne time. Sonnet 5.5, headless Team job.

## FOR TIM

1. **What you will see differently:** CDPARTS and CDLABELSTYLE still open on a layout sheet and during REFEDIT (that part of PR #2005 is unchanged). CDDASHBOARD (the Design Check dashboard) does NOT change: on a sheet it still says "cannot run in Paper Space", as it does today. The reason: its "Show in drawing" would zoom the sheet to a pit's model position and blank the sheet.
2. **My own mistakes:** none that cost anything. One slip: my edit tool stripped the invisible file-start marker (BOM) from two files; I put it back before committing, and the diff shows only the intended lines.
3. **What is NOT proven:** built and unit-tested only (18 of 18 pass). Nobody has opened this in AutoCAD. BUG-1046 is NOT fixed; I did not touch the carpark.
4. **No Codex patch existed** (`PATCH_PR2005_FIXFIRST_03NOV.patch` not found), so I wrote the change myself. It is the two-minute change the Opus pre-review named.
5. **Robot case (for CE 01 to schedule), in the style N31_dp_time:** `b186_sheet_windows`. It switches to Layout1, double-clicks inside to paper space, types `CDPARTS`, checks the window opens, closes it, types `CDLABELSTYLE`, same check; then types `CDDASHBOARD` and checks the command line carries "cannot run in Paper Space" (the dashboard keeps its refusal); then types `CD` and checks the same refusal line. Switch-off control: set `options.officeEditorsOpenAnywhere` false before launch (settings are read at AutoCAD start), repeat, and check `CDPARTS` now prints "cannot run in Paper Space". Entity count is read before and after and must be equal.
6. **Heads-up (rule 1):** a real AutoCAD (acad.exe, started 8:03 pm) was running on this PC during my test, not started by me. Files under `TIM_CE_CADTOOLS\CE_Admin` (outbox, sessions) and `CE_STRUC_SUITE\logs` changed in that window. Structural tests were never run by me and my Drainage test ran with TEMP and log folders redirected, so I believe AutoCAD wrote them, but I cannot prove it. The before and after listings (30 differing lines, all under CE_Admin outbox and sessions, CE_STRUC_SUITE logs and AutoSaveBackups) are not attached: they carry client project names and the leak scan refused them. The scratch copies were removed with the folder.

## Technical detail

1. **PR / branch:** #2005, `claude/b186-w1046`, base `claude/rel-20261102a`. One normal commit `9de8882d` on top of `abe5d2b9`, pushed, no force, no retarget. Draft status untouched.
2. **Fault confirmed on the PR head:** `Services/DrawingSafetyService.cs` line 63 listed `"CDDASHBOARD"` in `OpenAnywhereCommands`. CDDASHBOARD was already allowed during REFEDIT (base `ReadOnlyCommands`, line 34), so the only new effect was paper space, where "Show in drawing" goes through `CeZoomHighlightService` to `DrawingService.ZoomToEntityWithPadding` with no layout check.
3. **Change:** removed `"CDDASHBOARD"` from the set (line 63); doc comment says "never zoom the view". `Models/UserSettings.cs` summary now names three windows and says why the dashboard is excluded, still "Default: on." `REGRESSION_LOG.md` heading and item 3 updated. Test: `[TestCase("CDDASHBOARD")]` moved from the "opens anywhere" case to the "keeps its checks" case; fixture comment and two method names say three. The source-guard still asserts CDDASHBOARD calls `CommandPreFlight`.
4. **Switch:** `options.officeEditorsOpenAnywhere`, ON by default, unchanged. OFF = old refusals exactly. Both start-up reads still pinned by the existing tests in the same file.
5. **Tests:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -f net10.0-windows --filter FullyQualifiedName~Bug1046OfficeEditorsOpenAnywhere -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2 -c Release`: Passed 18, Failed 0. Isolation variables echoed first (CE_LOG_DIR_OVERRIDE, TEMP, TMP under `C:\CE_WORK\scratch\pr2005\run200233`). Note: APPDATA itself stayed real (listed before and after); the Drainage tests write to the overridden log and TEMP folders. Manager tests not run.
6. **net48 compile:** `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -f net48`: 0 errors (2 NU1903 package warnings, pre-existing). Took 2.6 s, so it may have been up to date from the test build's inputs; stated as is.
7. **Not touched:** CE_SHARED, locked layers, Xref and REFEDIT content, Tim's settings, bundles, ProgramData. Not deployed.
8. **Optional leftover from the pre-review:** the first commit's subject has no B-number; mine does. Left alone (no force-push).
9. **Cleanup:** see the line below.

Worktree cleaned and removed, scratch folder removed. C: free is now 73.1 GB (was 73.0 GB before the build).
