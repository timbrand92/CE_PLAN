# BUG-1031 fix report: Pit Schedule right-click menu offers "Delete cell" (build B-024, 30 Oct 2026)

## ANSWER FIRST

1. **PR:** #1865, DRAFT, against `claude/rel-20261026z` (Civil 3.0.85). Branch `fb/bug1031-pit-schedule-delete-cell`, worktree `C:\ce-fx\c79b`.
2. **Built and unit-tested only.** Nobody has opened it in AutoCAD. BUG-1031 is NOT marked FIXED. A window is accepted only by a Codex look.
3. **My mistakes:** none that cost anything. One slip: my first edit chain ran `pwsh` from the Bash tool (not on its PATH), so the rule file was not created on that call; I caught it by the empty `git diff` and redid it. No product effect.

## FOR TIM

1. **What you will see:** open PITSCHEDULE, right-click any cell. The menu now has "Delete cell", between "Restore Cell" and "Restore Row". It was never on the menu; the code behind it was already in the window, with nothing pointing at it.
2. **Worked example:** right-click the Cover cell of pit P3, choose Delete cell. The cell goes blank and the row shows as changed. With "A cell you clear in the Pit Schedule stays blank" on (it is on), the drawn schedule shows that cell empty too. Restore Cell brings the drawing value back. Undo in the window puts it back.
3. **If the column is read-only** (for example a calculated column), the status line at the bottom says "Selected cell is read-only." and nothing changes.
4. **What it does NOT touch:** CDDESIGN, CDCHECK and CDRULES answers do not change. Nothing is written to the drawing by the menu item itself. No layer is unlocked and no Xref or REFEDIT content is reached.
5. **Switch:** `linking.pitScheduleDeleteCellMenu`, ON. Typed false in `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` gives the old eight-item menu back. Read when the window opens. It has no row on the Settings page (the neighbouring BUG-1222 and BUG-1223 switches have none either).
6. **Needed from Tim:** nothing. A Codex look is needed (below). Whether blanking should also be allowed on a non-linked manual row is not asked: it already works through the same command.

---

## TECHNICAL DETAIL

1. **Cause:** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml` (cell ContextMenu, about line 508 to 560) never declared the item. `OnDeleteCellClicked` is at `Dialogs/PitScheduleDialog.xaml.cs:303` and calls `ViewModel.DeleteCellCommand`, which runs `ExecuteDeleteCell` (`ViewModels/PitScheduleViewModel.cs:1075`): undo snapshot, then `TrySetCellValue(row, column, "DELETE")`. Confirmed on `origin/claude/rel-20261026z` (09126560), not just the 3.0.72 entry.
2. **Change:** menu item (`Click="OnDeleteCellClicked"`, `Visibility` bound to `ShowDeleteCellMenuItem`); `PitScheduleViewModel.ShowDeleteCellMenuItem` reads new `Rules/PitScheduleDeleteCellMenuRule.IsOn(SettingsService.Current?.Linking)`; `LinkingSettings.PitScheduleDeleteCellMenu` (json `pitScheduleDeleteCellMenu`, "Default: on."). The menu already greys when `IsCurrentDrawingEditingEnabled` is false.
3. **Tests:** new `Bug1031DeleteCellMenuTests` (focused run 19 passed, count not 0, including the existing `ScheduleDeleteCellStaysBlank` tests): switch ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for three file shapes; typed false turns off only itself on both reads; rule reads ON for a null group; source guards (item between Restore Cell and Restore Row, declared once, uses the existing handler and rule; rule file has no write, regen, system variable or network text).
4. **Not done on purpose:** no row in `C75NewSwitchDefaultsTests`-style finalizer file (that is the finalizer's job); no Settings-page row (see FOR TIM 5).
5. **Full suite (net10, Debug, after the focused run):** Total 20,814, Passed 20,779, Skipped 32, Failed 3. (a) `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` needs AutoCAD's renderer: re-run alone, PASSED. (b) `FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and (c) `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure` read IL ("Release IL keeps ...") and fail on a Debug build; they are in files I did not touch (`SourceAtomicCoordinatorDependencyTests`). I did not re-run them on Release or on the unchanged base, so "unrelated" is my reading, not a measured control. The C62 train report's Release full suite had 0 failed.
6. **net48 compile:** `CE_CVL_SUITE.csproj -f net48`, 0 errors.
7. **Build safety:** every command had `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below-normal, through my own wait-for-slot script; nothing deployed; CE_SHARED unchanged.

## NOT PROVEN

1. That the item actually appears and sits in the right place in the live window (headless tests read the XAML text, not the window).
2. That the right-clicked cell, not the previously current cell, is the one blanked. The handler uses `ScheduleGrid.CurrentItem` and `CurrentCell` (as Restore Cell does). A right-click on a different cell without a left-click first may blank the earlier current cell. This is the main thing a Codex look must check.
3. That Undo in the window restores the cell and the drawn schedule shows it blank after Save and reopen (BUG-783's route).

## ROBOT / CODEX CASE

**Name:** `N33_ps_delete_cell` (control `N33_ps_delete_cell_off`).

1. Open the Pit Schedule test drawing with pits P1 to P3, run PITSCHEDULE. Left-click the Cover cell of P3, right-click it. Read the menu item names: "Delete cell" must be listed after "Restore Cell" and before "Restore Row".
2. Click Delete cell. Check the P3 Cover cell reads empty and the row's Override indicator is ticked.
3. Right-click a Cover cell of P2 WITHOUT left-clicking first, choose Delete cell: check it is P2's cell that went blank, not P3's (not-proven item 2).
4. Click Restore Cell on P3: the Cover value returns. Click Undo: the P2 cell returns.
5. Right-click a read-only column cell, choose Delete cell: the status line reads "Selected cell is read-only."
6. **Switch-off control:** type `"pitScheduleDeleteCellMenu": false` in the `linking` group before launching AutoCAD (settings are read at launch), open the same window, right-click: the menu has eight items and no "Delete cell".
7. **Codex needs:** screenshots of the menu with the item (switch ON), the menu without it (switch OFF), and the P3 cell blank, saved beside the steps.
