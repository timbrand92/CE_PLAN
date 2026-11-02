# BUGFIX w1042 report: BUG-1042, blank cover level (3 Nov 2026, B-173 provisional)

## FOR TIM

1. **My own mistakes first:** I first made the work branch inside the main checkout by mistake, then moved it to the proper separate working folder and put the main checkout back on master (nothing was lost, nothing was pushed from there). My first two test runs failed on a quoting slip in my own run script (a space in the AutoCAD path), which cost about ten minutes. I did not count the running builds before the final compile check.
2. **One thing to read before anything else:** while my tests ran, three real files in `%APPDATA%\TIM_CE_CADTOOLS` changed: `CD_Settings.json` (now dated 4 Oct, 15,270 bytes, was 3 Nov 05:06, 15,355 bytes), `CD_RecentValues.json` (rewritten 05:23) and a Structural log. I do not think my run wrote them: my run's own redirect folder never created a settings folder, so it wrote nothing to the real settings. A robot-driven AutoCAD or another job on this PC is the likely writer. I cannot prove that, so please have someone look at why `CD_Settings.json` carries an old date. Both listings are in section 3 below.
3. **What a drafter will see:** in PIT, leave Cover level blank and the Place button now works. A line under the window says "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out." In PITEDIT, a pit with a blank cover can be saved after an unrelated change (say width 600 to 900), and the cover stays blank. It is never written as 0.000. A missing pit number, type, width or length still stops the button as before.
4. **The switch:** Settings key `pit.blankCoverIsWarningNotBlock`, ON by default. Turn it OFF (and restart AutoCAD) and the old "Enter the cover level." block returns exactly.
5. **What is NOT proven:** nobody has opened this in AutoCAD. The pit window's depth estimate and the setup advisor were not driven with a blank cover. The window layout is unchanged (no window file edited), but the warning line has not been looked at on screen. BUG-1042 stays OPEN.
6. **Robot case that proves it (proposed name `W1042_pit_blank_cover`, in the style of N31_dp_time):** (a) on a copy with pit P1 (600 x 600 grated) and blank cover, type PITEDIT, pick P1, change width to 900, press Save: check the command-line / log shows the save, then read P1's cover from the drawing data and check it is still blank; (b) type PIT with every field filled and Cover level cleared, press Place: check the pit is placed and its stored cover is blank (not 0.000); (c) switch-off control: set `pit.blankCoverIsWarningNotBlock` false BEFORE launch (CE reads it at start), repeat (b): the button stays grey and the line reads "Enter the cover level." Broken twin: case (c) is the twin.

## Technical detail

1. **Fault confirmed on `origin/claude/rel-20261102a` (3fbb9da5):** `Modules/Drainage/Rules/PitStartReadiness.cs` line 124-125 returned `Blocked("Enter the cover level.", "CoverLevel")`; `PitViewModel.CanExecutePlace` (line 1116) reads it for both New and Edit. Not already fixed. BUG-1043 (#1735, merged `ffa05119`) is the sibling; I reused its path (`BlankInvertWarnsOnly` input, a `Startable(Attention, ...)` line, a settings bool read by the view model).
2. **Change:** `PitStartInputs.BlankCoverWarnsOnly` (default true); rule returns the warning after all other blockers pass; `PitViewModel.StartReadiness` fills it from `SettingsService.Current?.Pit?.BlankCoverIsWarningNotBlock ?? true`; `PitSettings.BlankCoverIsWarningNotBlock` = true, JSON `blankCoverIsWarningNotBlock`, doc "Default: on.". Downstream was already safe: `PitAnnotationTextFormatter.FormatCoverText` drops the CL line for a blank cover; stored cover is the typed string.
3. **Tests:** new `Bug1042BlankCoverWarnsTests` (switch ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for four file shapes; typed false through both reads; blank and whitespace in new and edit mode; other blockers still block; OFF restores exact text and field; the real window view model button follows the switch in new and edit). Four older tests that pinned the block now run with the switch OFF (`PitStartReadinessTests`, `PitViewModelTests` x2, `PitWindowPresentationTests` x2). Focused run (net10.0-windows, one project, filter on eight fixtures): 161 passed, 0 failed, 0 skipped. net48 compile of `CE_CVL_SUITE.csproj`: 0 errors. Not run: the full suite, Manager, Structural.
4. **Follow-up for the finalizer:** add `pit.blankCoverIsWarningNotBlock` to the train's new-switch-defaults file (I did not edit the C-78 file to avoid a conflict with the finalizer).
5. **PR:** #1996, draft, base `claude/rel-20261102a`, one commit `6e3b64df`. Files: `Rules/PitStartReadiness.cs`, `ViewModels/PitViewModel.cs`, `Models/UserSettings.cs`, `REGRESSION_LOG.md`, four test files. CE_SHARED untouched. No open draft touched `PitStartReadiness.cs`; `PitViewModel.cs` is touched by other open drafts (#705, #715, #724, #734 and others), so expect a keep-both-sides merge on that one line.

## Section 3: isolation listings (files in the five folders; before at 05:19, after at 05:28 Melbourne)

Differences only (the full listings were in the scratch folder, now removed):

1. `CD_Settings.json`: before 15355 bytes, 2026-11-03 05:06:10; after 15270 bytes, 2026-10-04 08:22:30.
2. `CD_RecentValues.json`: before 13190 bytes, 05:19:09; after 13190 bytes, 05:23:12.
3. `ce_struc_structured_20261103.log` (logs folder): before 319113 bytes, 05:05:44; after 338652 bytes, 05:23:37.
4. Nothing else changed in `TIM_CE_CADTOOLS`, `CE_Admin\outbox` (empty) or `logs`. `CE_STRUC_SUITE` (CS_Settings.json), `CE_CVL_SUITE` and `CE_CADTOOLS` were listed and show no differences.
5. Isolation used: `CE_LOG_DIR_OVERRIDE`, `TEMP`, `TMP`, `CE_STRUC_SUITE_APPDATA_ROOT` set to a fresh folder under `C:\CE_WORK\scratch\w1042\run_*` for each test run.

## Cleanup

Worktree `C:\CE_WORK\build\w1042` cleaned with `git clean -fdXq` and removed; scratch folder removed after this report. C: free space: 28.7 GB before the build; cleaning the worktree and scratch released about 0.46 GB (C: shows 29 GB free after).
