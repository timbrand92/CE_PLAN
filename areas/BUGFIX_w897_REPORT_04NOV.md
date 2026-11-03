# BUG-897 report (B-201, 4 Nov 2026): tiny Label slide step

## FOR TIM

1. **My own mistakes first:** my first test run failed because I guessed the old list size wrongly (I said over 9,000, it is 6,004). It was my test's number, not the fix. Corrected and re-run.
2. **What you will see differently:** if someone types a Label slide step of 0.001 in Settings, Tidy labels (CDTIDYLABELS) no longer works out about 500,000 positions per label before showing the preview. It raises the step to 5 mm (the 500 mm slide limit split into 100 positions) and carries on. Nothing is blocked. The log says "label slide step ... is too small; using 5 mm".
3. **Normal steps:** the usual 125 mm step, or anything 5 mm or bigger, behaves exactly as before. The 5 mm comes from your Slide limit setting divided by 100, not a fixed number.
4. **Switch:** `pipe.labelSlideWorkBudget` in `CD_Settings.json`, ON by default. Set it false and restart AutoCAD and the old behaviour (typed step used as typed) returns.
5. **NOT proven:** nobody has opened this in AutoCAD. It is built and unit-tested only. BUG-897 stays OPEN, not marked fixed.
6. **Robot case that proves it:** `N41_bug897_slide_budget` (to be written by the case runner). It sets Label slide step to 0.001 and restarts, types CDTIDYLABELS on a drawing with one pipe whose label overlaps a pit, and checks the preview appears within the normal time and the log line "label slide step 0.001 mm is too small; using 5 mm" is present. Switch-off control: the same with `pipe.labelSlideWorkBudget` false must NOT print that line (and takes the long wait, so use a short timeout and expect it to time out).

---

## Technical detail

1. **Fault confirmed on `origin/claude/rel-20261102a` (3fbb9da5), not already fixed:** `Rules/LabelPlacementRule.cs` `SlideTs` (AtPipeStart/AtPipeEnd) loops `k` from 1 until the 500 mm limit, step by typed step. 0.001 mm gives 500,000 per list, two lists. Caller `Services/LinkService.TextClashTidyUp.cs` `BuildOffsetCandidates` passed the typed step straight through.
2. **Change:** `LabelPlacementRule.BudgetedSlideStepMm` raises a too-small step to limit / `MaxSlideSpots` (100); `Spots(..., bool limitWork = false)` applies it. The caller passes `Pipe.LabelSlideWorkBudget` and logs a warning when the step is raised. CalloutShifts is untouched (already 4 steps each way). Settings: `PipeSettings.LabelSlideWorkBudget`, `[JsonProperty("labelSlideWorkBudget")]`, default true, doc ends "Default: on.".
3. **Files:** `Modules/Drainage/Rules/LabelPlacementRule.cs`, `Modules/Drainage/Services/LinkService.TextClashTidyUp.cs`, `Modules/Drainage/Models/UserSettings.cs`, `REGRESSION_LOG.md`, new `Modules/Drainage.Tests/Rules/Bug897LabelSlideWorkBudgetTests.cs`. CE_SHARED untouched. No window change.
4. **Tests (net10, one project, filtered):** Bug897LabelSlideWorkBudgetTests + LabelPlacementRuleTests: 14 of 14 pass. Earlier run with BranchHostLabelTidyRuleTests added: 25 passed, 1 failed (my test bound, fixed). Switch reads ON through `DeserializeSettings` and `DeserializeSettingsTolerant`; typed false changes only itself. Deviation: pinned in the bug's own test file, not a new C79 new-switch-defaults file (none exists yet on this base; the finalizer can fold it in).
5. **net48 compile:** `CE_CVL_SUITE.csproj -f net48` 0 errors.
6. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP set to `C:\CE_WORK\scratch\w897`. Manager tests not run. Listing of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` before and after: 36,873 lines each, **no differences** (full listings in `C:\CE_WORK\scratch\w897\appdata_before.txt` and `appdata_after.txt`, removed with the scratch folder).
7. **Redo and protection:** only the candidate list changes. No write, command, regen, view or system variable; no layers, Xref or REFEDIT touched.
