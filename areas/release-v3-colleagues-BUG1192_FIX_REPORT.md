# B-021 BUG-1192 fix report: the long section now says so when it throws away survey levels (30 Oct 2026, CE 01 Build)

## FOR TIM

1. **Draft PR #1864** (https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1864), branch `fb/bug1192-long-section-warning`, against `claude/rel-20261026z` (Civil 3.0.85). Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1192 is NOT fixed and not marked fixed.
2. **What you will see differently:** run CDPROFILE where the survey spots sit more than 1.20 m off the pit covers. The command line now prints one line per stretch, for example: "[CE] Long section: survey levels between chainage 5.0 and 15.0 m (RL 8.50) differ from the pit covers (RL 10.00) by more than 1.20 m and were not used; the ground line there runs straight between the covers. Check the survey."
3. **What does NOT change:** the drawing. The 70CONT ground line, the sections, the pipe, the labels and the tables are exactly as before. The warning is text only and never blocks. CDDESIGN, CDCHECK and CDRULES answers are untouched.
4. **Worked example (the bug's own numbers):** pit covers at RL 10.00, pipe crown RL 9.20, two survey spots at RL 8.50 either side of chainage 10 m (1.50 m below the covers).
   1. Before: the survey is thrown away silently, the ground line is a straight line at RL 10.00, the pipe looks buried 0.80 m, and nothing is said.
   2. After: the same drawing, plus the line above on the command line. You now know the pipe may be only 0.70 m below the crown level of the real ground (RL 8.50 is below the crown at RL 9.20).
   3. Control: spots at RL 9.50 are inside the 0.60 m tolerance, join the ground line, and no warning appears.
5. **The three tolerances (0.60, 0.90, 1.20 m)** used to be typed into the program. They are now Settings values (`longSection.surveyToleranceNearM`, `surveyToleranceMidM`, `surveyToleranceFarM`) with exactly today's figures, so nothing changes unless you edit them. A blank, zero or negative value uses the old figure, never a quiet zero.
6. **Switch:** `longSection.warnWhenSurveyLevelsIgnored`, ON. Type it as false in the settings file and the line disappears and nothing else changes.
7. **Your decision still stands, not built:** the dashed "Ground not confirmed here: check survey" stretch (QUESTIONS 21d, you said "yes", decisions item 42). That is a drawing change, so it needs its own switch and a workflow card first.
8. **My own mistakes first:**
   1. I waited about four hours for a build slot. Other jobs kept taking it, and my background waits were killed twice at the two-hour limit. I restarted with a faster check, which is how I got the slot.
   2. A previous attempt of this job left the code half done and a script with a path quoting fault. I fixed both (a missing "using" line, and the path with a space).
   3. My first full run failed the settings guard: my three new tolerance entries said "Default 0.60" instead of "Default: 0.60." Fixed and re-run green.
9. **Not proven:** anything in AutoCAD. The review window does not list the warning (command line and the CE log only). The new keys are not on the Settings page. The three search radii (2.5 m, 5 m, 12 m) are still typed in the program; they are not part of step one.
10. **Robot case to prove it (name `N41_long_survey_warn`):**
    1. Open the fixture: pits P1 at 0,0 and P2 at 20000,0 (cover RL 10.000), plus two survey spots at 9000,0 and 11000,0 labelled RL 8.50. Type `CDPROFILE`, datum 8.00, H100, V10, Preview New, Apply.
    2. Check the command-line text contains "survey levels between chainage 5.0 and 15.0 m (RL 8.50)" and "by more than 1.20 m". Check the 70CONT polyline vertices are the same as the switch-off run.
    3. Switch-off control: set `longSection.warnWhenSurveyLevelsIgnored` to false before launch (settings are read at AutoCAD start) and run the same steps: no "survey levels between" line.
    4. Second control: spots at RL 9.50: no line.

---

## Technical detail

1. **Entry point (confirmed on origin/claude/rel-20261026z, Civil 3.0.85):** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs`. `BuildExistingSurfaceSamples` (about line 1588, called at 983) seeds the ground line from pit covers; `TryEstimateSurveyLevel` (about 1767) held the three typed passes (2500 mm / 0.60 m, 5000 mm / 0.90 m, 12000 mm / 1.20 m); a probe that failed all three hit `continue` with no message. The 24 Oct lines 1468 to 1598 moved to about 1583 to 1790. In `ProfileRouteEvidenceCaptureService.cs`, `ProfileRouteReviewService.cs` and `LongitudinalSectionService.cs` I found no survey tolerance to change (only an unrelated 1.20 m existing-pipe display length at LongitudinalSectionService 361); I did not re-trace the 24 Oct line numbers there.
2. **Change:** new `Rules/LongSectionSurveyIgnoredRule.cs` (pure, headless: tolerances with fall-back, ignored-level filter needing two spots, run-merging message). `LongitudinalSectionViewModel.cs`: sampler takes the settings and a warnings list (an `internal` overload for tests), prints via `Editor.WriteMessage` plus `LoggingService.Warning`, repeat text within 30 s printed once (capture runs more than once per CDPROFILE). Four nested helper classes made `internal` for tests. `UserSettings.cs`: four keys in `LongSectionSettings`, each documented "Default: ..." with an explicit initialiser. No write, regen, view or system-variable change; no layer, Xref or REFEDIT touched. `CE_SHARED` unchanged.
3. **Tests:** `Bug1192LongSectionSurveyWarningTests` (16, run through both `DeserializeSettings` and `DeserializeSettingsTolerant` for the defaults, bad-value fall-back, the bug's numbers, RL 9.50 control, a wider Settings tolerance using the depression, switch OFF gives identical samples, source guards against drawing writes and hard-coded passes).
4. **Results:** Civil net10 full suite (Debug, AutoCAD 2027 on PATH): 20,822 total, 20,787 passed, 32 skipped, 3 failed. One was the C60 settings guard (my doc wording; fixed, the guard and C75 default tests re-run green: 101 passed). The other two, `SourceAtomicCoordinatorDependencyTests.FinalLandingProducerCollapsesOnlyItsOwnFreeEndRun...` and `...RefusedNativeCallbackInvalidatesTheManagedSession...`, read compiled code shape in Debug and fail the same way in another job's full run (prtext_burn2, BUG-861); I did not touch those files. net48 compile of the Drainage project: 0 errors. The one PDF page test did not fail.
5. **Files:** `Rules/LongSectionSurveyIgnoredRule.cs` (new), `Models/UserSettings.cs`, `ViewModels/LongitudinalSectionViewModel.cs`, `Drainage.Tests/Services/Bug1192LongSectionSurveyWarningTests.cs` (new), `REGRESSION_LOG.md`.
6. **Undo:** revert the commit, or set the switch to false.
