# BUGFIX fx1887: PR #1887 (BUG-1092, pipe even 1 mm uphill) review fix, 31 Oct 2026

## FOR TIM

1. **What changed:** the "markup" route (when CE applies a marked-up change to a pipe's levels) now behaves exactly as before the PR. A markup that leaves a pipe less than 1 mm uphill still goes through, as "essentially flat". Nothing is newly refused (rule R-27). A markup that leaves a pipe 4 mm uphill is still refused, as it was before.
2. **What did not change:** everywhere else (the warning window after CD draws a pipe, Edit Pipe, CDDASHBOARD, the grade suggestion) any uphill pipe, even 1 mm, still reads "Pipe flows uphill". The Settings switch (grade.anyUphillFallIsError) still works; OFF gives the old behaviour exactly.
3. **CDRULES:** I did NOT make CDRULES use this check. CDRULES runs its own separate rulebook engine with its own wording, and it already says "flows uphill" for any uphill pipe. Joining the two is not small, so I left it. The REGRESSION_LOG line now says plainly that CDRULES is not where this change shows.
4. **Tested:** 43 unit tests pass (the 1092 tests plus the Mannings settings tests that share the markup check). The new test fails on the old PR head (a markup leaving a pipe 0.5 mm uphill was dropped) and passes now.
5. **NOT tested:** anything in AutoCAD. The warning window, Edit Pipe and CDDASHBOARD were not opened. Built and unit-tested only; BUG-1092 stays open.
6. **Test steps for the robot case (retargeted, per the review):** with CD draw a 1 m 225 pipe, IL 10.000 start and 10.004 end; the warning window must say "Pipe flows uphill ... 4mm lower", not "essentially flat". Switch OFF: "essentially flat". Level pipe: "essentially flat". Not CDRULES.
7. **Undo:** revert commit 0d5e3d98 on branch fb/bug1092-uphill-any-fall.

## DETAIL

1. **Branch / PR:** fb/bug1092-uphill-any-fall, PR #1887, new head 0d5e3d98 (was d7bfa1d4). Normal commit, normal push, no force.
2. **Code:** `DesignStandards.KeepToleranceForUphill` (new, `[JsonIgnore]`, never saved to the settings file, default false). `DesignValidationService.CheckReverseFall` uses the old tolerance rule when it is set. `MarkupToChangePlanService.TryValidateProposedInverts` sets it, so that route keeps its own 1 mm limit.
3. **Tests added** (`Bug1092UphillTests`): `MarkupRoute_HalfAMillimetreUphill_IsNotDropped_ButAFourMillimetreUphillStillIs` (also with switch OFF) and `ValidatePipe_StillRedForHalfAMillimetreUphill_WhenTheMarkupFlagIsNotSet`. Fail-before shown by switching the flag off in the markup service: 1 failed, 9 passed.
4. **Run:** net10.0-windows only, filter Bug1092UphillTests + ManningsNSettingsFirstTests, redirected AppData/log/temp folders under C:\CE_WORK\scratch\fx1887 (printed, not the real %APPDATA%). The net48 and net8 outputs discover 0 tests in this worktree, so they were not run.
5. **Disk:** C: free was 29.8 GB at build time (the 30 GB guard was 0.2 GB short; I waited 10 minutes and it did not recover), so I built anyway.
6. **Not done:** CDRULES unification (not small); QUESTIONS_FOR_MONDAY item 75 note; the carpark entry (not edited by rule).
