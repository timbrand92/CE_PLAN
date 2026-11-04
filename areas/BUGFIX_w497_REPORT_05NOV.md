# BUG-497 report (B-215), 5 Nov 2026

## FOR TIM
1. **PR:** draft PR on claude/rel-20261026s, title starts B-215 (number in the PR link given in the final message).
2. **What a drafter sees:** STRSCHEDCREATE makes the bracing, bored pier and tie-down tables with room for the title, the headings and every item. Before, each table was one row short (read from the code, never seen in AutoCAD).
3. **Switch:** Settings, ScheduleSet, "ScheduleTablesHaveTitleAndHeadingRows". Default: on. Off gives the old count exactly.
4. **Built and tested:** 7 unit tests pass (row counts with switch on and off, and the default through the settings reader). The net48 build compiled the DLL; its final check step failed only because powershell was not on this shell's PATH.
5. **NOT proven:** nobody drew a brace and ran STRSCHEDCREATE in AutoCAD. Not marked fixed.
6. **My own mistakes first:** (a) the first test run failed because the test project needs -p:EnableUnifiedHostAdapters=true, wasted one run. (b) Real-folder check: 7 files in Tim's real AppData changed between my before and after listings (CE_STRUC_SUITE logs, CE_CVL_SUITE log, CE_SUITE_MANAGER session file, 3 new usage files in TIM_CE_CADTOOLS outbox). An acad.exe (not mine) is running on this PC and writes exactly those files; my own scratch folder holds no CE logs, so I believe it was AutoCAD, but I cannot prove it.
7. **Robot case to prove it:** BUG497_schedule_rows: on a copy draw one AB brace, type STRSCHEDCREATE, check the bracing table has 3 rows with the brace on row 2 and no error; with the switch off the old error returns.

## Technical
- Confirmed on base: Modules/Structural/Services/ScheduleService.cs, BuildBracingTable, BuildBoredPierTable, BuildTieDownTable sized `count + 1`; items written from row 2.
- Change: new `ScheduleService.TableRowCount(items)` (items + 2 on; old Math.Max(2, items + 1) off), UserSettings.cs ScheduleSetSettings, REGRESSION_LOG.md entry, tests in Modules/Structural.Tests/Services/ScheduleTableRowCountTests.cs.
- Only one start-up reader exists in this branch (SettingsService.DeserializeSettingsTolerant); tested on blank, partial and typed-off files.
- Worktree C:\CE_WORK\build\w497 (git clean -fdXq done; worktree left in place). Listings: C:\CE_WORK\scratch\w497\listing_before.txt and listing_after.txt.
- 0-byte CE_TRANSFORM_2027.arx placeholder created in the worktree (untracked, not committed).
