# Codex window brief — w896 / BUG-896: Tidy labels, crowded-drawing wording — 4 Nov 2026

**Base:** `claude/rel-20261102a` (Civil). **Report:** `areas/BUGFIX_w896_REPORT_04NOV.md` (fault, lines, proposed code).

## The window work (Codex)

1. **New switch:** `Linking.TidyCrowdedWordingEnabled` (bool, default true). Name can change if CE 01 prefers.
2. **Advanced Settings window:** add one checkbox row near `TidyLabelsEnabled` in `Dialogs/AdvancedSettingsDialog.xaml`. Tooltip: "When one pipe has more than 1,000 text objects nearby, Tidy labels says so in plain words instead of 'could not read'. Off = the old wording. Default: on."
3. **Civil Settings view:** the same row in `Dialogs/CivilSettingsView.xaml`.
4. **View model and catalogue:** `AdvancedSettingsViewModel.cs`, `.DraftingFixes.cs`, `SettingsValueCatalog.cs`, following the `TidyPitByBodyOutline` pattern.
5. **Tests to extend:** `SettingsWindowV3Tests.cs` list (line ~354), a `Bj3x` rows test and persistence test, and a new new-switch-defaults test file pinning both start-up reads.

## The non-window code (Sonnet, after the window row exists, or in the same PR)

1. A dedicated exception thrown at `LinkService.TextClashTidyUp.cs:701`, counted in `outcome.PipesTooCrowded` at `:197-204` when the switch is on.
2. `TidyLabelsSummaryRule.LeftAloneLine` gets a third count and the clause "N with more than 1,000 text objects nearby (CE limits the work to stay quick)". The 1,000 is read from the constant.
3. Switch OFF: counted in `PipesUnreadable`, old wording exactly.

## AutoCAD proof

Robot case `N32_tidy_crowded`: 1 pipe, 1,001 MTEXT near its labels; `CDTIDYLABELS`, Enter, Enter; check the line "Pipes left alone: 1 with more than 1,000 text objects nearby". Control with the switch off: "...1 that CE could not read (see the log)".

## Open question for Tim

Keep the 1,000 limit and only explain it (assumed), or make it a Settings value?
