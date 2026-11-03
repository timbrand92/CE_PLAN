# BUGFIX w1050 report: BUG-1050, last custom label style can be deleted (3 Nov 2026)

## FOR TIM

1. **Mistake of mine first:** I did not list the AppData folders before my first test run, only after. My tests were pointed at scratch folders (C:\CE_WORK\scratch\w1050), and the changed files in the listing are AutoCAD's own logs and session files from your running AutoCAD. No settings or label-style file changed. That is a weaker proof than the before-and-after pair the rule asks for.
2. **What you will see:** open CDLABELSTYLE with one custom style left. Delete style now works. The window says "No custom styles left: CE now uses its built-in wording. Save to keep this." After Save and reopen the list is empty, and new pit and pipe labels read the built-in wording (pit `{ID}  CL:{COVER}  IL:{INVERT}`, pipe `DN{DIA}  @  1:{GRADE}`). Labels already drawn do not change.
3. **Switch:** Settings key `options.lastLabelStyleCanBeDeleted`, ON. Off gives the old window exactly.
4. **PR:** #2010 (draft, base `claude/rel-20261102a`), titled B-197. One small code change, no window (XAML) change, CE_SHARED untouched.
5. **NOT proven:** nobody has opened this in AutoCAD. Built and unit-tested only. BUG-1050 stays open.
6. **Robot case (to write, in the N31_dp_time style):** `N_labelstyle_last_delete`. Isolated label_styles.json with one entry AUDIT-OLD; type CDLABELSTYLE, select AUDIT-OLD, press Delete style, read the status line "No custom styles left", press Save, reopen and check the list is empty and a new pit label reads `CL:` and `IL:` in the built-in wording. Switch-off control: set `options.lastLabelStyleCanBeDeleted` false before launch, repeat, and check Delete style stays greyed.

---

## Technical detail

1. **Fault confirmed on `claude/rel-20261102a` (3fbb9da5):** `LabelStyleDialogViewModel.cs` `CanDeleteStyle` required `Styles.Count > 1` and `ExecuteDeleteStyle` refused at `Count <= 1`. Also `LabelStyleService.Load()` only accepted a file with `Styles.Count > 0`, so an emptied catalogue would have been re-seeded with Default, Verbose, Compact after Save and reopen. Both had to change, so the carpark's "reopen shows it gone" would not have held with the button fix alone. `CurrentStyle` already falls back to `GetBuiltInDefault()`.
2. **Change:** new `Options.LastLabelStyleCanBeDeleted` (default true, "Default: on."); `LabelStyleService.LastStyleDeleteAllowed` reads it (settings read failure keeps on); VM allows deleting the last style and sets selection to null; `Load()` accepts an empty `styles` list only when the file has a `styles` key (a `{}` file still re-seeds) and the switch is on. Save already handles an empty list (`ActiveStyleName` becomes "Default").
3. **Tests:** `Bug1050LastLabelStyleDeleteTests.cs` (switch on: delete, save, reopen empty, fallback text; two-style delete unchanged; switch off: old behaviour and re-seed; `{}` file re-seeds; switch ON through `DeserializeSettings` and `DeserializeSettingsTolerant` for `{}` and a group without the key; typed false reads false). Two older tests in `LabelStyleDialogViewModelTests.cs` pinned the old wording and now set the switch off. The new-switch-defaults pin lives in the new test file rather than a C79 file, because C78NewSwitchDefaultsTests is the last finalizer and I did not want to edit it. Run: 72 passed on net10, 71 on net48 (both targets compiled), filter on Bug1050, LabelStyle, C78NewSwitchDefaults, SettingsService; count not 0.
4. **Not touched:** locked layers, Xref, REFEDIT, the drawing, CE_SHARED, Manager tests (not run).
5. **Isolation:** TEMP, TMP and CE_LOG_DIR_OVERRIDE set to C:\CE_WORK\scratch\w1050\tmp and \logs before each run. Listing after the last test (newest six files per folder, 3 Nov 2026 19:23): TIM_CE_CADTOOLS (sessions, outbox, logs, written 19:20 to 19:21), CE_STRUC_SUITE (logs, 19:21), CE_CVL_SUITE (logs, ledger/suggestions.jsonl 19:16, cdcheck output 19:04), CE_CADTOOLS (Manager session files 19:21, menu state 19:13). All are AutoCAD-written and none is a settings or label_styles file. No before listing was taken (see FOR TIM 1).
6. **Worktree:** C:\CE_WORK\build\w1050, branch `claude/b197-w1050`, one commit.
