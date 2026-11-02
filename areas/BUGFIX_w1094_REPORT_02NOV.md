# BUGFIX w1094 — BUG-1094 Inspector "no Grade line" (B-166, 2 Nov 2026)

## FOR TIM

1. **Answer:** I found no missing warning in the code. The red Grade line and the "To fix" line are on the **Checks** tab of CE Inspector, not on Summary. Codex only looked at Summary, so it saw plain "Grade 1 in 235" and nothing else.
2. **No PR opened.** Making the Summary show the colour is a window change, so I wrote a Codex window brief instead: `C:\CE_PLAN\areas\BRIEF_W1094_INSPECTOR_HEALTH_02NOV.md`.
3. **What a drafter sees now:** on Summary a 1 in 235 pipe looks identical to a good one (white text). Nothing tells them to open Checks. That is the real gap.
4. **My own mistakes first:** none found by me in the code; but my base (`claude/rel-20261102a`, 3.0.88) does NOT contain #1962, so I could not run its tests there. I read the installed 3.0.89 source from commit 61fd6fbc instead.
5. **NOT proven:** nobody has seen the Checks tab on that pipe. I did not run AutoCAD, Codex or any test. If Checks is also empty there is a second fault (the stored levels not reaching the check, see technical 4). The brief starts with one 5-minute Codex look at Checks to settle it.
6. **Robot case (N31_dp_time style):** `B1_04c_inspector_checks_grade`. Types CD, a 100 UPVC stormwater pipe, Set my own 235, levels 18.000 then 17.900, selects it, opens CE Inspector, Show full detail, Selected object > Checks. Checks the Diagnostics text reads `Grade: 1:235  ✗  (min 1:200)` and the boxed line reads `To fix: set To IL to 17.88`. Switch-off control: set `grade.inspectorFlatterThanMinimumShowsRed` false before launch; the same line then reads `⚠` (amber) and the To fix line is still there. Needs a Codex look for the colour.

## Technical

1. **Fault trace (base 3fbb9da5, Civil 3.0.88):** `InspectorPaletteService.cs` line 1770 calls `CollectPipeWarnings` for every pipe in the item view. Line 3390 needs gravity, both inverts read, `fromIL > toIL`, length > 0; for 18.000/17.900 over 23.5 m all hold, so the Grade line is added (3428) and `GradeFixSuggestion` set (3439).
2. **Where they show:** `Controls/InspectorPanelControl.xaml` binds `HasWarnings`/`HealthWarnings` at lines 432-443 and `GradeFixSuggestion` at 444-446, both inside TabItem "Checks" (line 399). Summary (line 125) binds only `PipeGrade` (line 195), plain text from `FormatGrade`; no health binding anywhere on it.
3. **Installed vs base:** `git diff 3fbb9da5 61fd6fbc` touches InspectorPaletteService.cs only (6+/9-, the #1962 switch via `InspectorGradeStatusRule.Classify`); the XAML is identical. `Classify(true, 235, 200)` = Error (red).
4. **Residual doubt:** `CollectPipeWarnings` reads `pipeData.FromInvert`/`ToInvert` (ProjectData), while Summary shows `truth.StartInvertEvidence ?? pipeData` (line 1739). If ProjectData lacked the levels while the pipe's own data had them, Summary would show 18.000/17.900 yet no Grade line. Cannot be told apart without AutoCAD; the Checks look decides it.
5. **Isolation listings:** none taken because I ran no dotnet test or build; no real folder could have been written by my run.
6. **Cleanup:** worktree `C:\CE_WORK\build\w1094` and branch `claude/w1094-inspector-grade-line` (no commits, nothing pushed) removed; scratch folder removed.
