# BUGFIX n15 report: batch 15, AutoCAD 2022 to 2024 lane (B-129), Sat 31 Oct 2026

## FOR TIM (read this part only)

1. **Two draft PRs are open, both built and unit-tested only. Nobody has opened either in AutoCAD 2022 to 2024. Both bugs stay open.**
   1. **#1957 BUG-1211 (CDMENU says "loaded" when it is not).** Now, when you type CDMENU or press Restore CE Civil Tools, CE asks AutoCAD whether the "CE CVL" menu group is really loaded. If CUILOAD unloaded it, CE loads it again in the same session. CDMENU only prints "The Civil menu is loaded" after AutoCAD confirms. The Repair window no longer says "Installed menu: OK" just because the file exists: it says "CE Civil tools are loaded." only when the group is loaded, otherwise "CE Civil menu file is there but not loaded. Press Restore CE Civil Tools (below)."
   2. **#1959 BUG-1214 (CDASK From file offers PDFs it always rejects).** On 2022 to 2024 the file-type list in the picker now shows images only (PNG, JPG) plus All files. A PDF chosen through All files still gets the old "PDF support requires AutoCAD 2025 or later" sentence. 2025 and later is unchanged.
2. **Both are behind a Settings switch, ON:** `install.restoreMenuChecksLoadedGroup` and `ai.markupFilePickerMatchesLane`. Off gives the old behaviour exactly.
3. **What a robot or Codex run on AutoCAD 2022 to 2024 must prove** (nothing here can be checked on AutoCAD 2027):
   1. BUG-1211: CDMENU; CUILOAD, unload CE_CVL_SUITE_MENU; CDMENU again. Right = the line says loaded and CE CVL is back in CUILOAD. Then CDREPAIR with the group unloaded: status must NOT say loaded; press Restore; it must.
   2. BUG-1214: CDASK, From file... Right = no PDF entry in the type list.
4. **Skipped on purpose (parked by your decisions 25 and 181):** BUG-1209, 1210, 1212, 1213 and 304 (older-year gaps; stay open). Nothing else in this batch was skipped.
5. **One thing to know:** AutoCAD was running on this PC while I tested (a new acad.exe started 20:48 Melbourne). Files in your real CE folders changed during my run, including `CD_Settings.json`. I checked: my new setting names are not in that file, so my test runs did not write it; it was the installed plugin inside AutoCAD. Listings are below.

## Mistakes of my own (first)

1. My first test command lost its output (the test tool printed to a place my log did not capture) and the first run died on a missing 0-byte placeholder `CE_TRANSFORM_2027.arx`; I created the empty file in the worktree build folder and re-ran. No cost beyond about 6 minutes.
2. One run of the BUG-1214 branch showed 1 failed of 47 tests; I could not see its name because the quiet log hid it. Re-ran the same filter twice with full logging: 47 of 47 passed both times. Unidentified, probably timing under load (the PC was busy with other builds). Not proven either way.

## What is proven and what is not

1. **Built:** net48 Drainage compiles, 0 errors, on both branches (AutoCAD 2024 references). net10 compiles with the focused tests.
2. **Unit-tested (net10, focused):** 14 of 14 new BUG-1211 tests; BUG-1214 branch 47 of 47 (its new tests, the existing markup loader tests and the REDO call-graph tests); BUG-1211 branch also 103 of 103 on the related existing guards (menu safety contract, ribbon contract, repair counts, hosted-mode CUIX, repair layout, repair words, plain command messages, command error text, REDO call graph, C-78 switch defaults). Full suite NOT run (the job says focused only).
3. **NOT tested:** anything in AutoCAD. In particular: whether AutoCAD 2022, 2023 and 2024 really return the group name "CE_CVL_SUITE_MENU" from the `MenuGroups` list I read late-bound (`CuiMenuGeneratorService.IsMenuGroupLoaded`); if a year returns nothing, CE treats "cannot say" as not confirmed, reloads on restore, and says "loaded again, but AutoCAD did not confirm", it never claims loaded. The file picker itself. The Repair window drawn. The net48 CDMENU message. net8 lane not compiled by me.
4. **Robot cases to write (names in the style N31 / C31), both need a 2022 to 2024 lane that the robot does not have yet:**
   1. `N15_cdmenu_reload` (BUG-1211): types `CDMENU` (expects the line "The Civil menu is loaded."), `_.CUIUNLOAD` of group CE_CVL_SUITE_MENU, `CDMENU` again; checks the command line contains "The Civil menu is loaded." and a group list read (`(vl-catch-all-apply 'vla-item ...)` on MenuGroups) finds CE_CVL_SUITE_MENU. Switch-off control: set `install.restoreMenuChecksLoadedGroup` false, repeat; the group stays absent while the old line still prints.
   2. `N15_cdask_picker` (BUG-1214): types `CDASK`, presses From file..., reads the file-type combo items; checks none contains "pdf" (needs a Codex look, the picker is a window). Switch-off control: false = the PDF entries return.

## Drafts, shared files and clashes

1. **PRs:** #1957 (BUG-1211, branch claude/b129-bug1211-cdmenu-recheck) and #1959 (BUG-1214, branch claude/b129-bug1214-markup-picker), both draft, both against claude/rel-20261102a, both titled B-129. Neither is stacked on the other.
2. **Shared files touched:** `Modules/Drainage/Models/UserSettings.cs` and `REGRESSION_LOG.md` in both PRs (a new switch each, in different groups; expect a keep-both-sides conflict in the log when the second merges). CE_SHARED not touched. No Settings-engine or loader change, so no N91 needed.
3. **Open drafts seen on the same files:** #599 (ASCII sweep, touches WorkspaceMenuInstallerService.cs and the CDMENU failure line); #784 (CeUiThread/ribbon rebuild, different code); #742 (CeAssistantControl, BUG-406, different code); #1245 (Structural menu bar, a different module). Many UserSettings.cs drafts (#1918, #1927, #1904, #1938 and others) add switches in other groups.
4. **Files by PR.** #1957: new Rules/MenuRestoreRule.cs; Services/WorkspaceMenuInstallerService.cs, CuiMenuGeneratorService.cs, StandaloneCivilRibbonService.cs; Commands/HubCommands.cs; Dialogs/CdRepairDialog.xaml.cs; new test Bug1211MenuRestoreTests. #1959: new Rules/MarkupFilePickerRule.cs; Services/MarkupFileImageLoader.cs; Controls/CeAssistantControl.xaml.cs; new test Bug1214MarkupPickerTests. Window changes: none (a status sentence in the Repair window code only; no layout).

## Real-files compare (names, sizes, times only)

1. **Before my first test: 20:34. After my last: 20:52** (full listings: `C:\CE_WORK\scratch\n15\real_before.txt` and `real_after.txt`, deleted with the scratch folder after this report).
2. **Changed during the run:** 44 listing lines differ, all rewritten logs, outbox usage files, session files, the Manager menu .cuix, runtime diagnostics and `TIM_CE_CADTOOLS\CD_Settings.json` (15270 to 15404 bytes, 20:47:50) and `CD_RecentValues.json`. **Cause is AutoCAD, not my tests:** acad.exe (new process, started 20:48:03) was running, the file sets match a plugin load and unload, my two new setting names are absent from CD_Settings.json, and my test runs had TEMP, TMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT under C:\CE_WORK\scratch\n15. Other jobs were also running Structural and Civil tests on the PC. I did not touch the settings files and I run no Manager tests.
3. **Settings files at the end:** CD_Settings.json 15404 bytes 2026-10-31 20:47:50; CS_Settings.json (CE_STRUC_SUITE) 35613 bytes 2026-10-30 19:54:14 (unchanged); CE_CVL_SUITE\settings.json 672 bytes 2026-09-16 12:13:17 (unchanged).

## Housekeeping

1. **Worktree** C:\CE_WORK\build\n15 cleaned (`git clean -fdXq`, `git worktree remove`) at 20:54 Melbourne. Scratch folder C:\CE_WORK\scratch\n15 (22.6 MB of logs) removed after this report.
2. **C: free space:** 31.76 GB at start, 29.24 GB just before cleanup, 29.68 GB after the worktree went. The net effect on C: from my work is small and hidden by other jobs building at the same time, so I cannot quote a clean figure. The worktree and its build folders were the only large thing I made.
3. **Finished:** Saturday 31 October 2026, 20:55 by the PC clock (20:54:44 at worktree removal).
4. BUG_CARPARK.md not edited. AutoCAD, Codex and accoreconsole not started by me. No installed bundle or settings file touched.
