# BUGFIX w896 REPORT — BUG-896 (Tidy labels, crowded drawing)  — 4 Nov 2026

**Result: STOPPED, NO PR OPENED.** The fault is real, but the fix needs a new Settings switch, and a switch in this codebase needs rows in two settings windows (Codex-owned). That is more than one small window change. Brief written: `areas/BRIEF_W896_TIDY_CROWDED_WORDING_04NOV.md`.

## FOR TIM

1. **What happens today (confirmed in the code, not seen in AutoCAD):** if one pipe has more than 1,000 text objects near its labels, Tidy labels gives up on that pipe and counts it as "CE could not read it (see the log)". Other pipes carry on. If that was the only pipe, you then see "No CE label needs to move", which looks like a clean result when it is not.
2. **What you would see after the fix:** a plain line such as "Pipes left alone: 1 with more than 1,000 text objects nearby (CE limits the work to stay quick)." The valid pipes are still tidied, as now.
3. **Why no PR:** a new on-by-default switch must appear in the Advanced Settings window and the Civil Settings view, plus their lists. The batch rule says that means a Codex window brief, not a Sonnet PR. I have not started the code change.
4. **Mistakes of my own:** none so far. I did not build, test or start AutoCAD, so nothing here is proven beyond reading the code.
5. **NOT proven:** the behaviour in AutoCAD, and the exact obstacle count at which a real drawing trips the limit.
6. **Question for you, one line:** is the 1,000-object limit right to keep (just explain it), or should it become a Settings value? I assumed "keep it, explain it". A Settings value is a larger change.

## TECHNICAL DETAIL

1. **Base checked:** origin/claude/rel-20261102a (Civil, Drainage). Not Structural, so the stop-if-Structural rule does not apply. Not already fixed: no commit on the base changes this.
2. **Fault, file and line (base):**
   - `Modules/Drainage/Services/LinkService.TextClashTidyUp.cs:33` `TidyUpMaxObstacles = 1000`.
   - `:700-701` in `TidyScan.Filter` throws `InvalidOperationException("more than 1000 text objects sit near the pipe; nothing was moved")`.
   - `:197-204` the per-pipe catch (only when `!outcome.WriteStarted`) does `outcome.PipesUnreadable++` and logs a warning. The wording is lost to the drafter.
   - `Rules/TidyLabelsSummaryRule.cs:42-52` `LeftAloneLine` words that count as "that CE could not read (see the log)".
   - `Commands/TidyLabelsCommand.cs:63, 141-148` `WriteSkipNotes` prints it.
3. **Proposed fix (small, ready for whoever builds it):**
   - Add a dedicated exception type, thrown at `:701` instead of `InvalidOperationException`. The catch at `:197` counts it in a new `outcome.PipesTooCrowded` and not in `PipesUnreadable`.
   - Add a `pipesTooCrowded` argument to `LeftAloneLine`, with a new clause: "N with more than 1,000 text objects nearby (CE limits the work to stay quick)". The 1,000 comes from the constant, not typed again.
   - New switch `Linking.TidyCrowdedWordingEnabled`, default true. OFF puts the count back in `PipesUnreadable` with the old wording exactly.
   - Pin both start-up reads (`SettingsService.DeserializeSettings`, `DeserializeSettingsTolerant`) in a new `C79NewSwitchDefaultsTests`-style file.
   - Add a unit test for `LeftAloneLine` with the new clause, and a source guard like `TidyLabelsGateTests.cs:172-182`.
   - REGRESSION_LOG.md entry.
4. **Why the window work is needed.** The nearest example is `TidyPitByBodyOutline`. Its footprint is `UserSettings.cs`, `AdvancedSettingsDialog.xaml`, `CivilSettingsView.xaml`, `AdvancedSettingsViewModel.cs` and `.DraftingFixes.cs`, `SettingsValueCatalog.cs`, `SettingsWindowV3Tests.cs:354`, `Bj34CivilSettingsRowsTests.cs` and `Bj34SettingsPersistenceTests.cs`. Two of those are windows.
5. **Rules kept:** CE_SHARED untouched. No locked layer unlocked (the locked-layer guard at `:150-154` is unchanged). No Xref or REFEDIT content touched. REDO-safe: wording and a counter only, no new drawing write.
6. **Robot case (named, for the build that follows):** `N32_tidy_crowded`. It opens a drawing with one pipe and 1,001 MTEXT objects placed near its labels, and types `CDTIDYLABELS`, Enter (All), then Enter. It checks the command line for "Pipes left alone: 1 with more than 1,000 text objects nearby". Control: set `TidyCrowdedWordingEnabled` to false before launch, repeat, and check the line reads "Pipes left alone: 1 that CE could not read (see the log)".
7. **Disk and cleanup:** no worktree was created, nothing built. C: free space is unchanged. Nothing was run against %APPDATA%, so the before/after listings have no differences to report (no tests were run).
8. **Evidence note for the carpark (CE 05 to add; I may not edit BUG_CARPARK.md):** BUG-896 confirmed at the lines above on rel-20261102a; fix needs a settings-window brief; still OPEN.
