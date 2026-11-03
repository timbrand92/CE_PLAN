# BUG-895 (B-199): Tidy labels "Moved" count, report, 4 Nov 2026

## FOR TIM

1. **A mistake of mine to check first:** after my test runs, one of your real files changed: `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` (your remembered last-used values). Same size (13,327 bytes), new time stamp 01:31. All my runs had the log and temp folders redirected, but the settings folder was not redirected in this job, so my tests MAY have rewritten it. Other jobs share this PC, so I cannot prove it was me. Please treat it as possible and check your recent values (for example the last pipe size or grade) look right. Nothing else in the four AppData folders changed.
2. **What you will see differently:** on a layout sheet, CDTIDYLABELS used to say "Moved 3" when it had counted pit cover level texts it can never move there. Now those texts are not counted, and one plain line says "Pit cover level texts left where they are: N (on a layout sheet or not allowed to be moved; see the log). Move them by hand." In Model space nothing changes unless the mover refuses a text, which is now taken out of the count too.
3. **Built and unit-tested only.** 90 focused tests pass on net48 and net10. Nobody has opened it in AutoCAD.
4. **NOT done: the Settings window tick.** The switch exists and ships ON, but it is only in the settings file. Every Settings tab is already at the 670 px height limit (adding one row pushed the Newer tools tab to 685 px and the Fixes tab to 678 px), so a visible tick needs a Codex layout change. Brief below.
5. **PR:** draft #2012, base `claude/rel-20261102a`, branch `cx/bug-895-moved-count`. BUG-895 stays OPEN.

## The robot case that would prove it

Name: `N32_tidy_layout_pitcover` (to be written). Open a drawing with one pipe and its pit on a layout (paper space) sheet whose pit cover text sits on another text. Type `CDTIDYLABELS`, answer All, check the command line: with the switch ON it must NOT say "Will move" for the cover text and must show the line "Pit cover level texts left where they are: 1". Control: set `linking.tidyCountsRealPitTextMoves` to false in the settings file before launch, repeat; the old "Will move 1" line must come back and the answer Yes must end with "Moved 1" while the text has not moved.

## Codex window brief (one line)

Add one tick to the Newer tools tab and Civil settings view after "Tidy labels also moves clashing pit cover text": label "Tidy labels counts only the pit cover texts it really moves", bound to `TidyCountsRealPitTextMoves`; the view-model, catalog and tab-list entries are also needed (copy the `TidyPitByBodyOutline` pattern, and the rows in `Bj34CivilSettingsRowsTests`, `Bj34SettingsPersistenceTests`, `SettingsWindowV3Tests`); I tried them and reverted them, nothing of that is in the PR. Tab height must stay at or under 670 px, which needs room found on that tab.

## Technical detail

1. **Fault confirmed on base 3fbb9da5:** `Services/LinkService.TidyPitText.cs` (old lines 116-120) did `outcome.WillMove++` for every planned cover text, and the apply pass only counted its own local `moved`, never fed back. `TryMovePitCoverText` (`LinkService.PitCoverText.cs:97`) refuses through `IsPipeAttachmentDirectManipulationAllowed` (`LinkService.PipeAttachmentGrip.cs:1016-1022`) whenever `OwnerId != ModelSpaceId`, so every layout-sheet cover text is refused, logged only.
2. **Change:** `PitTextTidyRule.CountsRealMoves()` and `ReportedMoves()`; `PlanOnePitCoverText` skips a non-Model-space cover text and counts it in `outcome.PitTextLeft`; the apply pass subtracts refused moves; `TidyLabelsSummaryRule.PitTextLeftLine`; `TidyLabelsCommand` prints the line in both preview and done passes. No new write, regen, view or system variable. No layer unlocked, Xref and REFEDIT untouched.
3. **Switch:** `UserSettings.Linking.TidyCountsRealPitTextMoves`, JSON `linking.tidyCountsRealPitTextMoves`, default true ("Default: on." in the property comment); OFF returns the old count exactly. Pinned through `DeserializeSettings` and `DeserializeSettingsTolerant` in `Bug895PitTextRealMovesTests` and `C76TidyLabelsDefaultOnTests`.
4. **Files:** `Models/UserSettings.cs`, `Rules/PitTextTidyRule.cs`, `Rules/TidyLabelsSummaryRule.cs`, `Services/LinkService.TidyPitText.cs`, `Services/LinkService.TextClashTidyUp.cs`, `Commands/TidyLabelsCommand.cs`, tests, `REGRESSION_LOG.md`. CE_SHARED untouched.
5. **Test run:** one project (`CE_CVL_SUITE.Tests`), filtered to Bug895, C76TidyLabelsDefaultOnTests, PitTextTidyRuleTests, Bj34 rows and persistence, SettingsWindowV3Tests; 90 passed, 0 failed, on net48 and net10. Environment: CE_LOG_DIR_OVERRIDE, TEMP, TMP under `C:\CE_WORK\scratch\w895`; `CE_STRUC_SUITE_APPDATA_ROOT` not set (Civil job); CD settings folder was NOT redirected (see item 1 above).
6. **AppData before/after:** lists are in `C:\CE_WORK\scratch\w895\appdata_before.txt` and `appdata_after.txt`; the only difference is the `CD_RecentValues.json` time stamp (and its folder's) at 01:31.
7. **Disk:** C: free 59 GB before, 58 GB after, before worktree clean-up.
