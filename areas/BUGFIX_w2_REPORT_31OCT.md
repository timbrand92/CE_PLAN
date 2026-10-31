# B-094: colleagues start New Pipe in Custom 1 in 100 (job w2, Sat 31 Oct 2026)

## FOR TIM

1. **Draft PR #1928** (B-094), on top of the C-78 line. Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **What a colleague will see:** on their first ever login (no CE settings file yet), New Pipe opens with "Set my own" ticked and 1 in 100 typed in the box, the same as yours. Before, it opened on the table grade.
3. **What it does NOT touch:** anyone who already has a settings file keeps exactly what they saved, including you. Nothing is moved or rewritten. A file with no grade in it, an empty file and a damaged file all keep the old start too.
4. **A mistake of mine, caught by my own test:** my first version set only the grade (two lines) and the New Pipe window still opened on the table grade. The window only opens on the saved grade when its "Recall last settings" box is ticked, and that box starts unticked on a fresh login. So the starting settings now also tick that box. **Side effect to know about:** a colleague's New Pipe window will also remember their last size, material and text choices from one pipe to the next, as your window does. If you only want the grade and not the remembering, say so; it needs a small code change instead (one line to remove in the starting-settings file undoes this).
5. **The off switch:** the existing "office starting settings" switch (settings.firstStartUsesColleagueDefaults, ON). Turn it off in the shipped file and a fresh login gets the old start exactly.
6. **Re-test (area plus smoke):** New Pipe, plus the Settings smoke set (load, save, migrate, switches). Robot case below.
7. **Real settings file changed during my job (read this):** your `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` is a different file from the one I listed before my first test: it went from 15302 bytes (last written 31 Oct 16:51:57) to 15270 bytes with a last-written time of 4 Oct 08:22:30. A write by my tests would show today's time, not an old one, and my tests point at a temporary folder; the pattern looks like a copy restored with its old time stamp by something else while AutoCAD (acad.exe) was running on your PC and 16 new usage records were being written (16:54 to 17:11). I cannot prove it was not my run, so I am telling you. I did not touch the file myself and did not start AutoCAD.

## ANSWER FIRST

1. **PR:** #1928, draft, base `claude/rel-20261102a` (head was 3fbb9da5), branch `claude/b094-new-pipe-custom-1-in-100`, commit 22766c90. No earlier PR touches the same file's lines: #1844 (F-023 shipped starting settings) lists `colleague-defaults.json` but the file is already on the base, so I built on the base. #1919, #1920, #1924, #1925 touch other Civil files; I changed no line of `UserSettings.cs`.
2. **Fault re-checked first:** it still existed on the base. `GradeSettings.Method` starts as "defaultMin" and the New Pipe window only applies the saved grade when `options.rememberCdSettings` is on (`CdViewModel.Settings.cs` lines 15 to 26), whose built-in default is false (`UserSettings.cs` line 1782).
3. **Cause and entry point:** the fresh-login path is `SettingsService.LoadSettings` (no file) to `ColleagueDefaultsService.BuildFreshSettings` to the shipped `Modules/Drainage/Assets/Config/colleague-defaults.json`. Only that file changed (plus tests and REGRESSION_LOG.md).
4. **Nothing hard-coded:** the value lives in the shipped starting-settings file, which is Settings data; the built-in defaults in `UserSettings.cs` are unchanged, so no saved file and no other test moves.
5. **Why a new switch was not added:** the existing switch (ON) already guards exactly this path and OFF already returns the old start; I pinned that with a test.
6. **Tests (net10):** new class `B094ColleaguesStartNewPipeInCustom100Tests` (11 cases): shipped file holds custom/100/recall-on; empty profile loads custom 100; both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`) give custom 100; a fresh-login New Pipe window view-model opens with Custom ticked and 100; a saved value wins (defaultStd, defaultMin, custom 80) and the file text is unchanged; a file with no grade block, an empty file and a damaged file keep the built-in start; switch OFF gives the old start; built-in defaults unchanged. Focused run with the F-023 and Round-2 colleague tests: 46 of 46 passed. Full Civil suite once at the end: 21601 passed, 0 failed, 32 skipped (test count not zero). net48 test project build: 0 errors.
7. **REGRESSION_LOG.md:** entry added at the top.

## ROBOT CASE (proposal, style N31_dp_time / C31)

**Name: C94_colleague_new_pipe_custom100** (with twin **C94_off**).
1. **Set-up (copies only):** a test profile folder with NO CD_Settings.json and the build's shipped colleague-defaults.json.
2. **Types:** start AutoCAD on that profile, run `CD`, read the New Pipe window state.
3. **Checks:** the "Set my own" radio is on, the grade box reads `100`, and the CE log shows the line "Fresh profile: office starting settings applied". After closing with Cancel, no CD_Settings.json has been created.
4. **Switch-off control (C94_off):** same profile but the shipped file's `settings.firstStartUsesColleagueDefaults` set to false: the window opens on Default and the box is empty.
5. **Saved-value control:** a profile whose CD_Settings.json says `defaultStd`: the window opens on Standard, not Custom.
Acceptance of the window itself is a Codex look (it is a window); the log lines and the file-not-created check are Claude-accepted material.

## WHAT IS NOT PROVEN

1. Not opened in AutoCAD, not driven by the robot or Codex; no screenshot of the window.
2. A real first login on a colleague's PC was not run; the shipped-file read is tested with the real shipped text through both start-up reads, and the window through its view-model.
3. Whether the "Recall last settings" box is visibly ticked and stays ticked in the window was not looked at.
4. Tim's installed bundle was not read, so whether the installed build ships this Assets file path unchanged was not checked (the csproj copies the whole `Assets\Config` folder, which a test pins).
5. The Manager and Structural tests were not run (the job forbids Manager tests and the change does not touch them).

## Mistakes of my own (first)

1. First version did nothing in the window (grade alone is not enough); found by my own window test, fixed before the PR.
2. I wrote a quote mark inside the JSON note text and broke the shipped file; 15 tests failed at once and caught it; fixed.
3. Two shell command-line slips (a stuck helper and a path with a space) cost about four minutes; no files were affected.

## Real-files compare (names, sizes, times; no contents)

Before the first test (16:54) and after the last (17:14): 33392 files listed before, 33408 after. Folders listed: `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and `logs`), `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_CADTOOLS` (including `CE_Admin`), and `%APPDATA%\CE_SUITE`. Differences, 16 new files, all in `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31` (usage records timed 16:54 to 17:11, written while acad.exe was running), and changed files:
1. **Settings files:** `TIM_CE_CADTOOLS\CD_Settings.json` 15302 bytes / 31 Oct 16:51:57 became 15270 bytes / 4 Oct 08:22:30 (see FOR TIM item 7). Not changed: `CS_Settings.json` (351713 bytes, 31 Mar 13:18:00) and `CD_RecentValues.json` is a remembered-values file rewritten at 17:12:36 (same 12220 bytes).
2. **Logs and state, written by the live AutoCAD session (acad.exe was running):** `CE_CVL_SUITE\logs\CE_CVL_SUITE.log`, `ce_cvl_structured_20261031.log`, `native_grip_2027.log`, `ledger\suggestions.jsonl`, `telemetry\outbox.jsonl`, `CE_STRUC_SUITE\logs\ce_struc_suite.log` and `RuntimeDiagnostics\*`, `TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log`, `CE_Admin\sessions\*.json`, `CE_Admin\outbox\machines\*.json`, `CE_CADTOOLS\CE_Admin\manager-menu-state.json`, `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json`, `CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix`. My test processes had TEMP, TMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT set to scratch folders (printed before every run) and never pointed at the real APPDATA.

## Housekeeping

1. **C: free space:** 45.99 GB at the start (16:51), 44.1 GB after cleaning up (17:15): down about 1.9 GB over the job. Other jobs ran at the same time, so I cannot say how much was mine. Never below 43.7 GB at any check (limit 30 GB).
2. **Cleaned:** `git clean -fdXq` in my worktree, then `git worktree remove`; the scratch folder `C:\CE_WORK\scratch\w2` removed. The branch `claude/b094-new-pipe-custom-1-in-100` and PR #1928 stay (nothing is deleted).
3. **Finished:** Saturday 31 October 2026, 17:16 Melbourne (AEDT) at the time of writing, before the report push.
4. **Not touched:** BUG_CARPARK.md, DESK_LOG.md, Tim's settings files (read: names, sizes and times only), installed bundles, ProgramData, CE_SHARED. AutoCAD, Codex and accoreconsole were not started.
