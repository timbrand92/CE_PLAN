# BUGFIX w1092c: BUG-1092 Design Warnings uphill error row now red (B-165)

## FOR TIM

1. **What you will see:** in the Design Warnings window, a row that is an ERROR (for example "Pipe flows uphill ... 4mm lower") now has a red bullet and red words. A plain warning row stays amber with white words. Before, both looked the same.
2. **Switch:** Settings, `validation.errorRowsShowRed`, on by default. Switch it off and every row is amber again, exactly as it was.
3. **Mistakes of my own:** (a) my first test run failed because `dotnet` is not on this shell's path; no harm, just a few minutes. (b) the before and after listing of your real AppData folders is NOT identical; see item 5.
4. **What is NOT proven:** nobody has looked at the window in AutoCAD. The tests prove the colour choice (red only for Error with the switch on) and that the window file holds the trigger; they cannot prove it looks red. The robot cannot judge colour, so Codex needs to look.
5. **Isolation listing:** CE log files, session files and usage files under `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` changed between my first and last listing (about 19:00 to 19:08, Mon 2 Nov). I believe a real AutoCAD session run by another job wrote them: all three CE plugins logged "plugin terminated" at 19:08:39, and my test host never starts the plugins. The full listings were in my scratch folder, now removed; the difference is summarised in technical item 7. I did not touch them.
6. **Footer is wrong for an error row:** the window still says "Warnings are informational - the pipe has been saved." under a red error row. I left the wording alone as told. You or Codex decide the new wording.
7. **Pull request:** draft #1993, title starts "B-165". BUG-1092 is not marked fixed.

## Robot case that proves it (for CE 02)

Name: `N60_designwarn_uphill_red` (suggested, in the style of N31_dp_time).
1. Types: place a pipe with end inverts 6 mm uphill (outside the 5 mm band, an Error even without #1887), then Enter to get the Design Warnings window.
2. Checks: the window's uphill row (automation text contains "flows uphill") is present; Codex looks at the colour (bullet and words red). A second pipe that only warns (for example flatter than minimum): that row stays amber.
3. Switch-OFF twin: set `validation.errorRowsShowRed` to false before AutoCAD starts (CE reads settings at launch), repeat: the uphill row is amber with white words.

## Technical detail

1. **Fault confirmed** on origin/claude/rel-20261102a: `Modules/Drainage/Dialogs/PipeValidationWarningDialog.xaml` lines 52 to 61 (bullet `WarningBrush`, message `TextPrimaryBrush`), no read of `ValidationWarning.Severity` (`Models/DesignValidationModels.cs` line 17). `ErrorBrush` is in DarkTheme.xaml (line 67) and LightTheme.xaml.
2. **Change:** names `RowBullet` and `RowMessage` on the two row TextBlocks; one `DataTemplate.Triggers` DataTrigger on `Severity` through `ValidationErrorRowConverter` (new, `Dialogs/ValidationErrorRowConverter.cs`) that returns true only for Error with the switch on; two Setters to `ErrorBrush`. The converter reads `SettingsService.Current` at convert time and is ON if settings are missing. Not a new column, icon, style or size, so no Codex brief was needed.
3. **Settings:** new group `validation` (`ValidationDisplaySettings.ErrorRowsShowRed`, default true) in `Models/UserSettings.cs`.
4. **Tests:** `Dialogs/Bug1092DesignWarningsErrorRowRedTests.cs`, 8 passed through `net10.0-windows` (colour by severity both switch states, converter, defaults through `DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes, typed false, template source guard). Neighbouring run: all `NewSwitchDefaultsTests` plus `PipeValidationWarningViewModelTests`, 251 passed. net48 build of the plugin: 0 errors. Counts were not zero; AutoCAD 2027 was on the PATH. Existing C-78 defaults test did not need a change.
5. **Not touched:** `DesignValidationService`, PR #1887's branch, CE_SHARED, any severity or result, the footer text. No open draft touched the dialog file (searched before editing).
6. **Files:** `PipeValidationWarningDialog.xaml`, `ValidationErrorRowConverter.cs`, `UserSettings.cs`, the new test file, `REGRESSION_LOG.md`.
7. **Real-folder listing:** before 36,091 lines (written 19:04), after listing differs in 24 lines, all CE logs, session JSONs, a runtime snapshot, machine and usage files under outbox. No settings or bundle file was in the difference.
8. **Disk:** C: free was 43.1 GB before the build; 42.1 GB just before cleanup and 42.5 GB after (worktree, build output removed), so about 0.4 GB moved.
