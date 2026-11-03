# BUGFIX ff2003: fix-first for draft PR #2003 (B-184, BUG-958), 4 Nov 2026

## FOR TIM

1. **Mistakes of my own first:** my first test run failed to start (wrong path to the build tool in my own script). It cost a minute, no harm. The "real files" listing showed two files changed during my window; both were written by a different, live AutoCAD session (see item 6), not by my test.
2. **What you will see differently:** with the Remember switch ticked, Edit Pit and New Pit now reopen where you dragged them, like Edit Pipe and CDS. Before this fix they still popped up at CE's centre.
3. **What I changed:** one line. The Pit window sizing step set "placed by hand" without the "CE placed this" label. It now uses the label. Nothing else moved.
4. **Also remembering their spot (same switch, harmless):** CDS dialog, More Options, editor text review, pit details review, Water Tank and the fallback workshop editors. Named in the REGRESSION_LOG entry.
5. **Switch:** unchanged. `windowPlacement.rememberFittedWindows`, Default: on. OFF gives the old behaviour exactly.
6. **NOT proven:** nobody has opened Edit Pit or New Pit in AutoCAD to see them reopen at the dragged spot. BUG-958 stays OPEN. Not tried on a second monitor. The review's open question (remembered spot saved at one window height, reopened at another) is still untraced.
7. **Pushed:** one extra normal commit `babaaf9f` on `claude/b184-w958-remember-window-position` (on top of `ea5b215b`). No new PR, no force-push, no retarget.

## Robot case that proves it: `W958_remember_fitted_window` (extend with Edit Pit and New Pit)

1. **Types:** run `CDPIT` (Edit Pit) on a pit, drag the window to a corner, close with Cancel, run `CDPIT` again. Then `CDPITNEW` (New Pit) and do the same. Check the second open sits at the dragged Left/Top (the CE log "window placement restored" line, or the window rectangle read back), and the height is still CE's fitted height.
2. **Switch-OFF control:** set `windowPlacement.rememberFittedWindows` false in the settings file BEFORE AutoCAD starts, repeat. Both windows must open at CE's centre again.
3. **Also needed for the case:** `windowPlacement.remember` ON (it is OFF by default, INT-073).
4. Command names above are from the area's usual names; I did not re-check them against the command list.

## Technical detail

1. **Finding fixed (the only one under FIX FIRST):** `Modules/Drainage/Dialogs/PitWindowLayout.cs:26` set `WindowStartupLocation.Manual` directly. Now it calls `CE_CVL_SUITE.Services.WindowSizingService.MarkFittedByCe(window)`, which sets Manual and records the window. `MarkFittedByCe` changed from `private` to `internal` (`WindowSizingService.cs:83`). Dialogs namespace differs from Services, hence the full name.
2. **Left alone as the review asked:** `PitDialog`, `PitScheduleDialog`, `DesignCheckDashboardDialog` (they place themselves on purpose).
3. **Test:** `Bug958RememberFittedWindowsTests.BothScreenFits_MarkTheirWindow_AndTheHookAsksBeforeLeavingAlone` now also reads `PitWindowLayout.cs`, requires `WindowSizingService.MarkFittedByCe(window);` and no direct Manual setter.
4. **REGRESSION_LOG.md:** entry point 1 extended with the review fix and the extra windows.
5. **Run:** one test project (`CE_CVL_SUITE.Tests`, net10.0-windows, Release), filter `FullyQualifiedName~Bug958RememberFittedWindowsTests`, flags `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, AutoCAD 2027 on PATH. Result: **Passed 9, Failed 0, Skipped 0, Total 9.** (Count is not zero.) Isolation variables echoed first: TEMP, TMP and CE_LOG_DIR_OVERRIDE under `C:\CE_WORK\scratch\ff2003\run_000423`; CE_STRUC_SUITE_APPDATA_ROOT set too. The slot check showed 0 or 1 dotnet builds running. C: free 66.6 GB before the build.
6. **net48 compile** of `Modules/Drainage/CE_CVL_SUITE.csproj`: 0 errors (246 warnings, existing). CE_SHARED not changed. Manager tests not run.
7. **Real-file listings** (names, sizes, last-write, before and after: `C:\CE_WORK\scratch\ff2003\before.txt` and `after.txt`, 36,814 lines each). Two lines differ:
   1. `%APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log` 4,899,499 → 4,899,576 bytes, last write 00:01:29 → 00:06:04. The new line is "User went idle after 300s", following a "Document activated: C:\ce_rc_drv\CLDV32359191_B1.dwg" line at 00:01:29: that is a live AutoCAD (a driver drawing), not my Drainage test.
   2. `%APPDATA%\CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` 228 bytes, last write 00:03:47 → 00:05:47: a two-minute heartbeat from a running Manager.
   3. I cannot prove from files alone that my run did not touch them, but neither is a file the Drainage tests write and both carry live-AutoCAD content. Flagging per rule 1. TIM_CE_CADTOOLS (incl. CD_Settings.json, CS_Settings.json), CE_CVL_SUITE and CE_Admin\outbox: no change.
8. **Open overlap check:** I did not run `gh pr list` (gh is not on this job's PATH). The change touches only the PR's own files.
9. **Not done:** no AutoCAD, no robot run, no window looked at.
