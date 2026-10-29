# Raingarden label RG1, RG2 (card D07, UX-SRC-03): build report, Thu 29 Oct 2026

## FOR TIM

1. **Answer:** draft PR #1845 is open. CDRG now writes the raingarden's name (RG1, then RG2 and so on, counted per drawing) in the middle of the outline, the way DP and OF carry their tags. Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **What you will see differently:** place a raingarden with CDRG. A text "RG1" sits at the centre of the outline. The next raingarden gets RG2. One Undo (U) takes away the outline, the hatch and the label together.
3. **Locked layer:** if the label layer is locked, or is an Xref layer, CE does not unlock it. The raingarden is still placed and the command line says "RG1 was placed without its label: layer GUIDELINES is locked or protected, and CE does not draw on it."
4. **Switch:** Settings file key `linking.raingardenTagLabel`, ON. Set it to false and CDRG behaves exactly as before (no label).
5. **My mistakes first:** (a) an earlier attempt of this job had left uncommitted work; I reused it and checked it rather than rewriting it. (b) The full test run caught one red of mine: a safety list for the "between commands" REDO check had to learn that the label writer moved into a helper. I added 24 lines to it and re-ran that check (43 of 43 pass), but did not re-run the whole suite after that one change. (c) My first two helper scripts mangled backslashes and line endings; no product file was affected.
6. **What is NOT proven:** how it looks in AutoCAD (text size, position, layer colour), the lock message on screen, Undo of the label, and a drawing with RG1 already in it. The label layer is the fixed GUIDELINES layer DP and OF already use, so there is no separate layer setting (one code path). The switch is not on the Settings page.
7. **Robot case to prove it:** **C31_rg_label.** Fresh drawing, type CDRG and pick a closed outline (as case R-RG does); then CDRG again on a second outline. Check: a TEXT on layer GUIDELINES with text RG1 near the first outline centre and RG2 near the second (text count 2, contents RG1 and RG2). Then type U once: the text count must drop by the label of the last raingarden together with its outline. Switch-off control **C31s:** set `linking.raingardenTagLabel` false before launch (settings are read at start-up), repeat the first CDRG: TEXT count on GUIDELINES must be 0 while the raingarden's outline still exists.

---

## Technical detail

1. **PR:** #1845 (draft), base `claude/rel-20261026z`, branch `fb/raingarden-rg-label`, commit message names UX-SRC-03 / D07 (no BUG number exists).
2. **Entry point:** `Modules/Drainage/Services/SourcePlacementService.cs` `AppendRaingardenLabel`, called after `plan.AddExactProjectRow` in `CommitRaingardenWithGio` and `CommitRaingardenGeometry`, in the placement transaction. Name comes from `RaingardenPlacementPlan.NextName` (RG{count+1}, skipping used names), unchanged.
3. **One code path:** `SourceTagService.EnsureTagLabel` text creation split into `AppendLabelText`; DP, OF, WT call it unchanged (left-aligned); raingarden calls it centred at `plan.Centroid`. A source guard pins one `new DBText` in that file.
4. **Locked layer:** layer record read first; `IsLocked || IsDependent` leaves the label out, logs a warning, adds the line to the terminal message only if the raingarden committed. No layer property is assigned (guarded by test).
5. **Switch:** `LinkingSettings.RaingardenTagLabel`, new `Rules/RaingardenLabelRule.cs` (pure). Pinned through `DeserializeSettings` and `DeserializeSettingsTolerant`, typed false, typed true, OFF draws nothing and touches nothing.
6. **REDO baseline:** `RedoSafeReviewedHooks.baseline.txt` +24 lines (8 writes under each of OnCommandEnded, OnCommandCancelled, OnCommandFailed). The hooks already reached the same writes through `EnsureTagLabel`; only the attributed method name moved. Old `EnsureTagLabel` lines left in place.
7. **Tests:** focused Civil net10 (Raingarden, SourceTag, C75NewSwitch, label tests): 297 passed, 0 failed. Full Civil net10: 20,823 total, 20,790 passed, 32 skipped, 1 failed (the RedoSafe baseline above); after the baseline fix RedoSafe plus label tests: 43 of 43. Civil net48 build: 0 errors. Test count was not zero.
8. **Not done:** C75NewSwitchDefaultsTests was not edited (a separate pin file `RaingardenLabelTests` carries this switch); Settings page row not added; Manager and Structural untouched; CE_SHARED untouched.
9. **Housekeeping:** worktree `C:\ce-fx\brg` (placeholder `CE_TRANSFORM_2027.arx` is untracked/ignored; bin/obj cleaned with git clean -fdXq). Logs in `C:\ce-fx\brg_logs`, `C:\ce-fx\brg_t`.
10. **Undo:** revert the commit, or set the switch false.
