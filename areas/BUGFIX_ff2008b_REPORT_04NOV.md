# BUGFIX ff2008b report: PR #2008 (B-190, BUG-959) fix-first, 4 Nov 2026

## FOR TIM

1. **What changed:** a CE window that is too tall for your laptop screen now opens on the big screen, fully visible, the same as before the PR. A window that does fit the laptop stays on the laptop. Before this fix, Calculations V2 (needs 820 high) on a 720-high laptop still hung about 100 units off the bottom, buttons included. The Civil Hub (needs 760) had the same fault.
2. **My earlier wording was wrong:** the PR log said Calculations V2's bottom buttons "stay on the screen". That was not true for a 720-high laptop. The log now has a correction line.
3. **Mistakes of my own:** none that cost anything. My first scratch script had its backslashes mangled by the shell, and the first test run failed to start. No build was wasted.
4. **What is NOT proven:** nobody has seen this on a real second screen. 15 of 15 unit tests pass on net10 and on net48. Bug 959 stays OPEN.
5. **Robot case to prove it (needs two real screens):** `N59_second_screen_fits`.
   1. Type: open AutoCAD on the smaller screen, run the command that opens a window that fits (for example a window with a minimum height under 700). Check: its bottom edge is at or above the laptop's usable bottom, and it is still on the laptop.
   2. Type: open Calculations V2 on the 720-high laptop. Check: it opens on the main screen and its bottom edge is inside the main screen's usable height.
   3. **Switch-off control:** set `options.windowsKeepSecondMonitorPosition` to false before AutoCAD starts. Repeat step 2 and the window opens on the main screen (same as the old behaviour). Repeat step 1 and it also opens on the main screen.
6. **Settings folders:** the before and after listings of your four real settings folders are identical (33,440 files in each, same names, sizes and times). My run wrote nothing there. The earlier report of `CD_Settings.json` changing was not from this job.

---

## Technical detail

1. **Finding closed (section F of PREREVIEW_FIXFIRST_COMMITS_04NOV.md):** the window's minimum size could exceed the screen it landed on.
2. **Branch and commit:** `claude/bug959-multimonitor`, head was `b84eab56`, new single normal commit `c5e9afb8`. Pushed with a normal push. No force-push, no retarget, no merge, no new PR.
3. **Change (about 10 lines):**
   1. `Modules/Drainage/Services/WindowSizingService.cs`: `ChoosePositionArea` takes optional `minWidth` and `minHeight` (default 0). A screen whose width or height is below those is skipped, so the main work area is returned. `ApplyPreferredWindowSize` passes `window.MinWidth` and `window.MinHeight`.
   2. `Modules/Drainage/Dialogs/CivilHubDialog.xaml.cs`: the Hub's restore call passes `MinWidth` and `MinHeight`.
   3. The rule lives in one place, `ChoosePositionArea`, as the review recommended. MinHeight is not lowered.
4. **Switch:** `options.windowsKeepSecondMonitorPosition`, unchanged, default on. With it off, `positionArea = workArea` and the new arguments are never used, so the old behaviour returns exactly. No new switch, so the new-switch-defaults test is unchanged.
5. **Tests (`Bug959SecondMonitorPositionTests`):** two new cases using the review's numbers (main 1920 x 1040, laptop 1280 x 720 at 1920,0). Minimum height 820 gives the main screen; minimum height 600 stays on the laptop. Run: `FullyQualifiedName~Bug959`, one project (`CE_CVL_SUITE.Tests`), net10.0-windows 15 of 15 pass, net48 15 of 15 pass (13 old plus 2 new). Flags: `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below-normal priority, isolation variables echoed before each run (CE_LOG_DIR_OVERRIDE, TEMP, TMP under `C:\CE_WORK\scratch\ff2008b`). The dotnet count was 0 before each run.
6. **Test limit, said plainly:** the new tests call `ChoosePositionArea` with the window minimum passed in. They do not construct a WPF window and call `ApplyPreferredWindowSize`, so the wiring of `window.MinHeight` into the call is read from the code, not run. The review suggested a single pure function for the whole size-and-position sum; I kept the change to the one rule to stay small. That larger refactor is not done.
7. **REGRESSION_LOG.md:** new entry at the top ("BUG-959 fix-first 2") with the correction of the overclaim and the robot wording. The older entry is left as written.
8. **Not touched:** CE_SHARED, Settings defaults, the installed bundle, ProgramData, Tim's settings files. No AutoCAD, Codex or accoreconsole started. No Manager tests.
9. **Settings folder listings (rule 1):** `before.txt` and `after.txt` in `C:\CE_WORK\scratch\ff2008b` (33,440 lines each; Caches and AutoSaveBackups subfolders left out), `Compare-Object` returned no difference. Covers `%APPDATA%\TIM_CE_CADTOOLS` (with CE_Admin and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS`.
10. **Still open from the review (not blocking):** the Hub reads screen scale before its window exists (mixed-scaling screens unproven); a saved Hub position in the last 100 units of a screen recentres; text clash with #2003 on `WindowSizingService.cs` for whichever merges second.
11. **Environment note:** a 0-byte `CE_TRANSFORM_2027.arx` placeholder was created untracked in the worktree (`Modules\Shared.Transform.Native2027\bin\x64\Release`); it is removed with the worktree clean-up.
