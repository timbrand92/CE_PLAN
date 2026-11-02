# BRIEF w1094 (B-166): Inspector pipe Grade health line — window brief for Codex (2 Nov 2026)

## FOR TIM

1. **What is wrong:** it is probably not a missing warning. The red "Grade: 1:235 ✗ (min 1:200)" line and the "To fix: set To IL to ..." line live on a different tab from the one Codex looked at. In CE Inspector, after Show full detail, the tabs are Selected object > **Summary**, Connections, On plan, **Checks**. The plain "Grade 1 in 235" text is on Summary. The red line and To fix line are only on **Checks**, under a heading called "Diagnostics". Codex clicked Show full detail and scrolled Summary; it never opened Checks.
2. **Why that matters to a drafter:** nobody looking at Summary sees that a pipe is flatter than the minimum. The Summary shows the grade in plain white text, the same for a good pipe and a bad one.
3. **What I need decided (window change, so no code PR yet):** put the colour and the cross on the Summary Grade row. Recommendation: show the same "Grade: 1:235 ✗ (min 1:200)" text, red, in the Summary Grade row, and the To fix line directly under it. Checks keeps its copy.
4. **What is NOT proven:** nobody has seen the Checks tab on that pipe. If Checks is also empty, there is a second, real fault (see test 1 below).

## Codex look to run first (about 5 minutes, copy drawing only)

1. **Test 1:** same pipe as B1d (100 UPVC stormwater, Set my own 235, levels 18.000 then 17.900, 23.5 m, min 1 in 200). Select it, open CE Inspector, Show full detail, then click **Selected object > Checks**. Record the exact lines under "Diagnostics" and whether a boxed "To fix" line sits below.
   - Expected: "Grade: 1:235  ✗  (min 1:200)" and "To fix: set To IL to 17.882 or 17.883 m (achieves 1:200)" (18.000 minus 23.5/200 = 17.8825), plus "Pipe has no connections..." lines for open ends.
   - If present: the fault is the tab, go to item 2. If absent: report back; the cause is then the stored levels (item 3 of the report), not the window.
2. **Window change to build after test 1 passes:** Modules/Drainage/Controls/InspectorPanelControl.xaml, Summary tab, Grade row (line 194-195): bind a coloured text (PipeGradeHealth, new) beside or in place of `PipeGrade`; set it in `InspectorPaletteService.CollectPipeWarnings` from the same `gradeStatus`/`gradeSymbol` already computed there (around line 3428). One Settings switch, ON by default, documented "Default: on."; OFF returns the plain Summary exactly. Colour from the existing Error/Warning/Info brushes, never a new colour.
3. **Not to touch:** locked layers, Xref, REFEDIT, CE_SHARED. Warn only, never block.

## What I checked (read, not run)

1. The XAML is byte-identical between base `claude/rel-20261102a` (3fbb9da5, 3.0.88) and installed 3.0.89 (61fd6fbc). Only InspectorPaletteService.cs differs (the #1962 switch).
2. `HealthWarnings`, `HasWarnings` and `GradeFixSuggestion` are bound only at InspectorPanelControl.xaml lines 432-446, inside the Checks tab. No other tab binds them.
3. Rule `InspectorGradeStatusRule.Classify(true, 235, 200)` returns Error (red), so with the switch ON, 1 in 235 is red; the old band gave amber.
