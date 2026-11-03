# BUG-959 report: Civil Hub position on a second monitor (B-190, 3 Nov 2026)

## FOR TIM

1. **What you will see differently:** leave the Civil Hub on your second monitor, close it, open it again: it reopens on the second monitor. Before, it jumped back to the main screen. CE windows that size themselves over AutoCAD (when AutoCAD is on the second monitor) also stay on that screen.
2. **My own mistakes first:** my first test command failed because the shell could not find `dotnet` (about 2 minutes lost, nothing changed). My "before" listing of your AppData folders ran slowly and overlapped the test run, so it is not a clean snapshot (see item 5).
3. **Built and unit-tested only.** 11 unit tests pass and the net48 compile is clean. Nobody has dragged a window to a second screen in AutoCAD.
4. **Not proven / known gaps:** (a) two monitors of different heights leave empty corners inside the desktop box; a window saved in an empty corner is not corrected. (b) The "centre over AutoCAD" first-open path and `FitEditorWindow` still use the main work area; they never read a saved position. (c) Mixed-DPI screens are untested.
5. **Your real folders:** listings are in `C:\CE_WORK\scratch\w959\appdata_before.txt` and `appdata_after.txt`. The only differences are logs, session files, usage outbox and machine JSON, written at 12:22 by a running AutoCAD or CE session. No settings file (`*Settings*.json`) is among them and my test runs write to the scratch folder only. I cannot prove from the timestamps alone that none of those log writes came from my run, because the "before" listing was slow.
6. **Robot case (not written, needs the runner):** name `N59_hub_second_monitor` with a switch-off control. It needs two monitors, which the robot PC may not have; if it has one, it cannot prove this and Codex must look with two screens. Steps: move the Hub to the second screen, close, reopen, read the Hub's left edge from the saved settings (`options.civilHubWindowLeft`) and check it is beyond the main screen width (switch ON). Then set `options.windowsKeepSecondMonitorPosition` to false before launch, repeat, and check the Hub opens centred on the main screen.

## Technical detail

1. **Fault confirmed on `origin/claude/rel-20261102a` (3fbb9da5):** `CivilHubDialog.xaml.cs` `TryApplySavedWindowBounds` used `SystemParameters.WorkArea` (main screen only) to test and clamp the saved Left/Top; `WindowSizingService.ApplyPreferredWindowSize` clamped the final position to the main work area even with the owner (AutoCAD) bounds known.
2. **Fix:** `WindowSizingService.ChoosePositionArea(main, allScreens, point, switch)` returns the virtual desktop when the point is on it (100 px margin kept), else the main work area. Used in the two places above. Width/height limits unchanged.
3. **Switch:** `options.windowsKeepSecondMonitorPosition` (`OptionSettings.WindowsKeepSecondMonitorPosition`), "Default: on." OFF gives the old area exactly.
4. **Tests:** `Bug959SecondMonitorPositionTests.cs`, 11 of 11 pass (net10.0-windows, filter by class, count not 0). Covers both start-up reads, typed false, on/off area choice, off-desktop fallbacks. I did not extend `C68NewSwitchDefaultsTests`; this class pins the new switch itself.
5. **net48:** `CE_CVL_SUITE.csproj` Release net48, 0 errors.
6. **PR:** draft #2008, base `claude/rel-20261102a`, branch `claude/bug959-multimonitor`, one commit. `gh pr list` could not be run in the shell (gh not on PATH, later found at `C:\Program Files\GitHub CLI`); I did not check for open drafts touching `WindowSizingService.cs` or `CivilHubDialog.xaml.cs` before editing. Check before merge.
7. **Untouched:** CE_SHARED, locked layers, Xref/REFEDIT, Tim's settings, installed bundles. Never deployed. BUG-959 stays OPEN.
