# Robot case drafts: fixes B-179 to B-186 (jobs w806, w658, w235, w648, w879, w958, w1018, w1046) (Tue 3 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. (The brief named the output folder `C:\CE_PLANreas`; I took that as `C:\CE_PLAN\areas`.)

---

## FOR TIM

1. **Six cases drafted: three fixes, each with a twin that must fail.** W2001 (AG drain "1:50" text, PR #2001), W2002 (labels you move with CE's own tool stay put, PR #2002), W2005 (Parts catalogue and Label styles open on a layout sheet, PR #2005). Order numbers 840 to 845. A fourth fix needs a driver change before any case can be written (see 4).
2. **Five of the eight jobs get no case, and I say why in section 4.** w806 (orifice detail) has no command that reaches it. w658 and w235 opened no PR. w958 (windows remember their place) needs a window to be dragged, which the robot cannot do. w1018 (pipe object enabler late load) needs AutoCAD started without the enabler, which the robot cannot do. Codex steps for w958 and w1018 are in section 3.
3. **None of the six PRs is in any build yet.** I checked with git: the installed Civil 3.0.89 (61fd6fbc), candidate b1 (3.0.90, cf059dcf) and b2 (rel-20261110a) hold none of PR #2000 to #2005. Each PR sits on the 2 Nov release line, which is older than the installed build. So these cases can only run once a build that holds the PR exists. Only #1972 (BUG-658) is in b1 and b2.
4. **w958 and w1018: Codex only.** No robot route exists today. Sections 3 and 4 give exact Codex steps.
5. **One thing in the reports to know about.** w235's report says 61fd6fbc is not on the release line it read. It is: 61fd6fbc is later than the 2 Nov tip (3fbb9da5). The BUG-1227 Part A fix it relies on (28d8b972) is inside the installed 3.0.89. That does not change its answer.
6. **Question for you, carried from w648:** should the "1:50" text follow the drain when you MOVE, COPY or ERASE it, like the PD tag does? W2001 does not test that, because the PR does not do it yet.
7. **Not verified:** every printed line, window title and number marked DERIVED was read from code, not seen on a run. Nothing for you to test or decide before the robot runs.

---

## 1. Facts checked, and where each came from

1. **Pull requests (read with `gh pr view` after `git fetch origin` on 3 Nov 2026).** All six are OPEN, draft, base `claude/rel-20261102a` (tip 3fbb9da5):
   1. **#2000, B-179, BUG-806:** head `bb594ff4`, branch `claude/b179-bug806-orifice-head`.
   2. **#2001, B-182, BUG-648:** head `90037740`, branch `claude/w648-ag-grade-label`.
   3. **#2002, B-183, BUG-879:** head `229f354a`, branch `claude/w879-hand-placed`.
   4. **#2003, B-184, BUG-958:** head `ea5b215b`, branch `claude/b184-w958-remember-window-position`.
   5. **#2004, B-185, BUG-1018:** head `6dce9df9`, branch `w1018-nocache-notloaded`.
   6. **#2005, B-186, BUG-1046:** head `abe5d2b9`, branch `claude/b186-w1046`.
   7. **B-180 (w658) and the w235 job:** no PR. B-180 is unused; I saw no B-181 anywhere.
2. **Ancestry (checked myself with `git merge-base --is-ancestor`).**
   1. None of the six heads is in `61fd6fbc` (installed Civil 3.0.89). `git branch -r --contains` shows each head only on its own branch.
   2. None is in `cf059dcf` (Civil 3.0.90, rel-20261108a, candidate b1) or `aa3b92ac` (rel-20261110a, b2).
   3. The common base `3fbb9da5` and the BUG-1227 Part A commit `28d8b972` ARE inside `61fd6fbc`. `61fd6fbc` is inside both b1 and b2.
   4. The BUG-658 PR #1972 (head `32fc1a44`) IS in b1 and b2.
3. **The switches (read in `UserSettings.cs` on each PR head).** All default to ON, all in `CD_Settings.json`:
   1. `surface.agDrainGradeLabel` (#2001).
   2. `linking.ceMovesMarkHandPlaced` (#2002). It does nothing unless `linking.handPlacedLabelsStay` is also on, and that one is OFF by default.
   3. `options.officeEditorsOpenAnywhere` (#2005).
   4. `windowPlacement.rememberFittedWindows` (#2003) and `options.pipeObjectEnablerRetryWhenNotLoaded` (#2004) are not used by a case.
4. **How the robot reads and presses (README_CASES.md, `acad_driver_v3.allowlist.json`).** It can type commands, read the command line and read objects. It can press only the buttons on the allow-list. It has no step that drags a Windows window, and its pointer steps work on the drawing canvas only.
5. **#2001 code (read `Commands/AgiCommand.GradeLabel.cs` on the head).**
   1. After Accept, one MText with the contents "1:50" is added on the drain's layer, in the same transaction as the line (one Undo).
   2. Position: the middle of the LONGEST leg (the first one if two tie), just under the line, top-centre attachment, at the Surface drainage text height (250 mm by default per the regression entry). The gap is 0.3 times the text height.
   3. The text is "1:50" for a fall towards the outlet, "1:50 rising" for a rise. No text if a level is skipped or the levels are equal.
6. **#2005 code (read `DrawingSafetyService.cs` on the head).** The new set is CDPARTS, CDLABELSTYLE, CDDIAG, CDDASHBOARD. With the switch on, the paper-space refusal (`[CE] <command> cannot run in Paper Space. Please switch to the Model tab.`) and the REFEDIT refusal are skipped for those four only. Every other command still refuses. Window titles from the XAML: "Creative Engineering | Parts Catalogue" and "Creative Engineering | Label Styles". After the label-style window closes, CDLABELSTYLE prints `[CDLABELSTYLE] Active label style: ...`.
7. **#2002 code (read `Commands/AnnotationEditCommand.cs` and `HandPlacedLabelRule.cs` on the head).** CDANNOTATIONEDIT asks to select an annotation, then the keyword (Move, Rotate, mIrror, Flip), then for Move "Base point" and "Destination point". With both switches on, a label that really moved is marked "placed by hand" in the same write. CDTIDYLABELS then leaves it alone and counts it under "Placed by hand (left alone)" (wording and route copied from the accepted-style N27).
8. **Existing case for BUG-658.** `W658_cascade_after_edit_save.case.txt` and `W658_BROKEN.case.txt` already exist in `cases\drafts_c79b1_01nov\` for PR #1972. I read their headers. I did not write another.

---

## 2. Case texts

**How these are written.** README_CASES.md format. Every `type` chain is a complete command with no `(` and no SAVE-type word. Fixture DRV1_B1, SLOT fresh. REVIEWED_AGAINST is empty. Run alone, outside Tim's hours, on a build that holds the PR. Validate first, without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_fixes_03nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or bypasses a protection.

### Case 1 of 3: W2001 and W2001_BROKEN (PR #2001, B-182, BUG-648: AG drain grade text)

**Intended file:** `W2001_cdagi_draws_grade_text_one_undo.case.txt`

```
# W2001 DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #2001 (B-182, BUG-648; the carpark stays OPEN). Switch surface.agDrainGradeLabel, ON by default: this case sets nothing and proves the shipped default.
# Route (copied from N54, the CDAGI route written 30 Oct, itself DERIVED from the code): CDAGI, Enter (pipe property None), three vertices, Enter to finish, Enter to skip the outlet, start level, end level, Enter to Accept. N54 has not been seen to run, so a BLOCKED on the typed chain is a route problem and not a result.
# Numbers (DERIVED, never seen): vertices 150000,-80000 then 155000,-80000 then 155000,-85000 (two 5 m legs, 10 m in all, drawing in millimetres); levels 20.200 and 20.000 give a 0.2 m fall over 10 m = 1:50, the carpark's own figures moved onto DRV1_B1's open ground. Both legs are 5000 long: the code takes the FIRST of two equal legs, so the text sits under the middle of leg one, x = 152500, a little below y = -80000 (gap is 0.3 of the text height, 250 mm by default, so about 75 mm; the case allows 400 mm).
# Not driven: a rising run ('1:50 rising'), a run with a level skipped (no text), Charged and Suspended, an outlet pick, a metre drawing, MOVE/COPY/ERASE of the drain (the PR does NOT link the text to the drain; that is Tim's open question), plot height and save and reopen.
CASE W2001
TITLE CDAGI with start 20.200 and end 20.000 over a 10 m two-leg run draws one 1:50 text under the middle of the first leg, on the drain's layer, and one U takes the drain and the text back together
PLAN_ITEM PR #2001 (B-182, BUG-648) PART: the text exists, reads 1:50, sits under the first leg on the drain's layer, and one Undo removes everything. NOT whole: how the text looks (size, colour, readable, clear of the line) is the Codex look K3_01; moving, copying or erasing the drain with the text is not built
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 840
TIMEOUT 900
BUG BUG-648
PROVES_BUGS BUG-648 (the missing text half only; the follow-the-drain half is not built)
REVIEWED_AGAINST
EXPECTED CDAGI with vertices 150000,-80000, 155000,-80000 and 155000,-85000, no outlet, start level 20.200 and end level 20.000, answered Accept, prints a preview with 'Grade: 1:50' and 'AG drain AGI<n> placed.'. Two objects are added: one polyline and one text reading 1:50, both on layer AGI DRAIN. The text sits at x 152500 (within 5 mm) and below y -80000. One U takes both back and the object count returns to the count before CDAGI. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the text and the position on their own; only a live CDAGI in the real drawing shows the text is really written to the drawing, on the right layer, in the same Undo step.
NOT_AUTOMATED How the text looks (height, colour, readable, not touching the line): Codex look K3_01.
NOT_AUTOMATED Rising run, skipped level, equal levels, closed run and perimeter drain are not driven. The grade text following the drain on MOVE, COPY and ERASE is not built (open question to Tim, w648 report).
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDAGI{NL}{NL}150000,-80000{NL}155000,-80000{NL}155000,-85000{NL}{NL}{NL}20.2{NL}20{NL}" -Force -TimeoutSec 90 -> $ag
  wait
  esc-prompt -> $age
  wait
  ms-count -> $c1
  ms-new $c0 -> $new
  select $new "object~^AcDbPolyline$" -> $ag_line
  select $new "text~^1:50$" -> $grade
  field $grade layer -> $grade_layer
  field $grade x -> $grade_x
  field $grade y -> $grade_y
  type "U" -Force -> $u1
  wait
  ms-count -> $c2
  windows-snapshot -> $win_end
ASSERT
  contains $ag "AG drain pipe property [None/Charged/Suspended]"
  matches $ag "Grade: 1:50"
  matches $ag "AG drain AGI\d+ placed"
  count $ag_line = 1
  count $grade = 1
  equals $grade_layer "AGI DRAIN"
  number $grade_x = 152500 +- 5
  number $grade_y < -80000
  number $grade_y > -80400
  number $c1 > $c0
  equals $c2 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $ag "FULL CDAGI"
  record $age "FULL after the wait"
  record $new "FULL objects it added"
  record $grade_x "grade text x"
  record $grade_y "grade text y"
  record $u1 "FULL what U echoed"
```

**Twin:** `W2001_BROKEN_cdagi_draws_grade_text_one_undo.case.txt`

```
# W2001_BROKEN DRAFT (Tue 3 Nov 2026; NOT RUN). The switch-off control (the style of R09s_new_switch_off_broken): surface.agDrainGradeLabel false before AutoCAD starts, so the drawing is the old one (the polyline only, no text). Same route as W2001. It must FAIL on 'count $grade = 1' (no 1:50 text is drawn). If it PASSES, the old build also draws the text here and W2001 cannot tell old from new: say so and send the item to Codex look K3_01.
# The case stops reading at the count, because 'field' on an empty list would be BLOCKED and not FAIL.
CASE W2001_BROKEN
TITLE BROKEN VARIANT of W2001: the new switch is OFF, so no 1:50 text is drawn, yet the case still expects one (must FAIL)
PLAN_ITEM red-before-green proof for W2001 (PR #2001, B-182, BUG-648)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json surface.agDrainGradeLabel false
ORDER 841
TIMEOUT 900
BUG BUG-648
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W2001
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF only the polyline is drawn, so the check that one 1:50 text exists fails; the route, the preview and the polyline pass.
WHY_NOT_UNIT_TEST It exists only to prove W2001's text check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDAGI{NL}{NL}150000,-80000{NL}155000,-80000{NL}155000,-85000{NL}{NL}{NL}20.2{NL}20{NL}" -Force -TimeoutSec 90 -> $ag
  wait
  esc-prompt -> $age
  wait
  ms-new $c0 -> $new
  select $new "object~^AcDbPolyline$" -> $ag_line
  select $new "text~^1:50$" -> $grade
  type "U" -Force -> $u1
  wait
ASSERT
  matches $ag "Grade: 1:50"
  matches $ag "AG drain AGI\d+ placed"
  count $ag_line = 1
  count $grade = 1
  copy-unchanged $copy0
  record $new "FULL objects it added (switch OFF: the polyline only)"
```

### Case 2 of 3: W2002 and W2002_BROKEN (PR #2002, B-183, BUG-879: CE's own move marks the label "placed by hand")

**Intended file:** `W2002_cdannotationedit_move_marks_label_hand_placed.case.txt`

```
# W2002 DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #2002 (B-183, BUG-879; the carpark stays OPEN). Switch linking.ceMovesMarkHandPlaced, ON by default; it only acts while linking.handPlacedLabelsStay is ON, which is OFF by default, so this case sets BOTH (and linking.tidyLabelsEnabled) before launch, exactly as N27 does.
# This is N27 with ONE change: N27 moves the pipe's start invert text 5 mm down with AutoCAD's own MOVE (that route already marked the label before this PR). W2002 moves the same text 5 mm down with CE's OWN tool, CDANNOTATIONEDIT Move (the route this PR fixes). Everything else (SETUP-R47, the SPOT LEVEL block 10EC5D moved onto the text to make a clash, CDTIDYLABELS All then Yes, and every check) is N27's, copied.
# Route facts (read on the PR head): CDANNOTATIONEDIT asks to pick a pipe annotation, then the keyword (Move, Rotate, mIrror, Flip; default Move), then Base point, then Destination point. A label counts as moved only if it really changed.
# DERIVED, never seen on a run: (1) that the typed pick at the text's own insertion point selects it (a typed point at a Select prompt picks nothing unless the point is inside the view, README batch 3 item 3, so the view is zoomed first); (2) that the start invert text IL 18.000 is accepted as a pipe annotation by CDANNOTATIONEDIT; (3) that {$name} inside a type chain is replaced by the stored value (it is in dist and ent-read; the first run will show if type does the same). A BLOCKED or 'Nothing Selected' on the CDANNOTATIONEDIT line is a route problem and not a result.
# Remembered values: YES, SETUP-R47 types PIT and CD, so CE rewrites CD_RecentValues.json; the guard restores the settings files (three SETTING lines, so this case runs in its own guarded session).
CASE W2002
TITLE With the hand-placed switches on, a pipe text moved with CE's own CDANNOTATIONEDIT Move stays where it was put when Tidy labels is told Yes (counted 'Placed by hand (left alone) 1')
PLAN_ITEM PR #2002 (B-183, BUG-879) PART: the pipe-label half, for CDANNOTATIONEDIT Move only. NOT whole: the Slide along pipe, Move away from pipe and Flip side grips are not driven (grips need a click on a grip menu), nor the pit cover text flip (CDPITCOVERFLIP)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.handPlacedLabelsStay true
SETTING CD_Settings.json linking.ceMovesMarkHandPlaced true
SETUP SETUP-R47
ORDER 842
TIMEOUT 1500
BUG BUG-879
PROVES_BUGS BUG-879 (the CDANNOTATIONEDIT half of the pipe-label part only)
REVIEWED_AGAINST
EXPECTED With the three switches on: the new pipe's start invert text IL 18.000 at P8 is moved 5 mm down with CDANNOTATIONEDIT Move (it moves 5 mm); the SPOT LEVEL block 10EC5D is moved onto it as in R16; CDTIDYLABELS All then counts 'Placed by hand (left alone) 1', lists no 'start invert text would move' line, and after the Yes answer that text is exactly where CDANNOTATIONEDIT left it (0 mm, within 0.5); the drawing holds the same number of objects.
WHY_NOT_UNIT_TEST The mark is written by a real CE edit in the real drawing and read by a later live Tidy labels run.
NOT_AUTOMATED The Slide along pipe, Move away from pipe and Flip side grips, and the pit cover text flip: Codex look K3_02.
NOT_AUTOMATED A cancelled CDANNOTATIONEDIT prompt, or a label on a locked layer, marking nothing, is not driven.
STEPS
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  field $il0 x -> $il_x0
  field $il0 y -> $il_y0
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDANNOTATIONEDIT{NL}{$il_x0},{$il_y0}{NL}Move{NL}0,0{NL}0,-5" -Force -TimeoutSec 90 -> $ae
  wait
  ms-new $n0 -> $after_hand
  select $after_hand "handle={$ilh}" -> $il1
  dist $il1 "{$il_x0},{$il_y0}" -> $hand_moved
  field $il1 x -> $il_x1
  field $il1 y -> $il_y1
  ent-read 10EC5D -> $spot0
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  ms-count -> $cnt0
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-count -> $cnt1
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il2
  dist $il2 "{$il_x1},{$il_y1}" -> $tidy_moved
ASSERT
  count $il0 = 1
  number $hand_moved = 5 +- 0.5
  contains $spot0 "SPOT LEVEL"
  history has "Placed by hand (left alone) 1"
  history absent "start invert text would move"
  number $tidy_moved = 0 +- 0.5
  equals $cnt1 $cnt0
  record $ae "FULL what CDANNOTATIONEDIT printed"
  record $spot_move "FULL what the SPOT LEVEL MOVE printed"
  record $tidy "FULL what CDTIDYLABELS printed"
  record $tidy_esc "what the closing Esc printed"
  record $tidy_moved "how far the text moved during Tidy labels (mm)"
```

**Twin:** `W2002_BROKEN_cdannotationedit_move_marks_label_hand_placed.case.txt`

```
# W2002_BROKEN DRAFT (Tue 3 Nov 2026; NOT RUN). The switch-off control: linking.ceMovesMarkHandPlaced false before AutoCAD starts (the other two stay on), so the old build's behaviour returns: CDANNOTATIONEDIT moves the text but does not mark it. Same route and same checks as W2002. It must FAIL on 'history has "Placed by hand (left alone) 1"' (and, for the same reason, the text is moved by Tidy labels).
# If it PASSES, the old route marks the label too, and W2002 cannot tell old from new: send the item to Codex look K3_02 and say so. If the hand-move step is BLOCKED, fix the route in W2002 first.
CASE W2002_BROKEN
TITLE BROKEN VARIANT of W2002: the new switch is OFF, so CDANNOTATIONEDIT does not mark the label and Tidy labels may move it, yet the case still expects it left alone (must FAIL)
PLAN_ITEM red-before-green proof for W2002 (PR #2002, B-183, BUG-879)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETTING CD_Settings.json linking.handPlacedLabelsStay true
SETTING CD_Settings.json linking.ceMovesMarkHandPlaced false
SETUP SETUP-R47
ORDER 843
TIMEOUT 1500
BUG BUG-879
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W2002
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the new switch OFF the label is not marked, so Tidy labels does not count 'Placed by hand (left alone) 1' and it does list the start invert text as one to move; the hand move itself still works.
WHY_NOT_UNIT_TEST It exists only to prove W2002's mark check can go red.
STEPS
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  field $il0 x -> $il_x0
  field $il0 y -> $il_y0
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDANNOTATIONEDIT{NL}{$il_x0},{$il_y0}{NL}Move{NL}0,0{NL}0,-5" -Force -TimeoutSec 90 -> $ae
  wait
  ms-new $n0 -> $after_hand
  select $after_hand "handle={$ilh}" -> $il1
  dist $il1 "{$il_x0},{$il_y0}" -> $hand_moved
  field $il1 x -> $il_x1
  field $il1 y -> $il_y1
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il2
  dist $il2 "{$il_x1},{$il_y1}" -> $tidy_moved
ASSERT
  count $il0 = 1
  number $hand_moved = 5 +- 0.5
  history has "Placed by hand (left alone) 1"
  number $tidy_moved = 0 +- 0.5
  record $ae "FULL what CDANNOTATIONEDIT printed, switch OFF"
  record $tidy "FULL what CDTIDYLABELS printed, switch OFF"
  record $tidy_moved "how far the text moved during Tidy labels (mm), switch OFF"
```

### Case 3 of 3: W2005 and W2005_BROKEN (PR #2005, B-186, BUG-1046: Parts catalogue and Label styles on a layout sheet)

**Intended file:** `W2005_parts_and_label_style_open_on_layout_sheet.case.txt`

```
# W2005 DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #2005 (B-186, BUG-1046; the carpark stays OPEN). Switch options.officeEditorsOpenAnywhere, ON by default: this case sets nothing and proves the shipped default.
# Route for reaching a layout sheet (copied from S472a, a Structural draft that has not been seen to run): TILEMODE 0 goes to the last-used layout tab, _.PSPACE makes sure no viewport is active, CTAB is then a layout name. UNCONFIRMED: that DRV1_B1 has a layout tab, and that AutoCAD does not open a page-setup window on the first visit (if it does, the TILEMODE step stops and the case is BLOCKED, not FAIL).
# Window titles are DERIVED from the XAML on the PR head: 'Creative Engineering | Parts Catalogue' and 'Creative Engineering | Label Styles' (the allow-list entry 'Creative Engineering*' lets close-windows close them). Both commands are modal: the type step returns when the window has appeared.
# The control line: CD (a command that puts things in the drawing) must still refuse in paper space: '[CE] CD cannot run in Paper Space. Please switch to the Model tab.' (DrawingSafetyService line 128 on the PR head).
# Not driven: REFEDIT (needs a pick of a block reference and an in-place edit; Codex look K3_03), CDDIAG and CDDASHBOARD on a layout, and that the windows work properly once open.
CASE W2005
TITLE On a layout sheet in paper space, CDPARTS and CDLABELSTYLE open their windows instead of refusing, and CD still refuses
PLAN_ITEM PR #2005 (B-186, BUG-1046) PART: the paper-space half for CDPARTS and CDLABELSTYLE, with CD as the refusal control. NOT whole: the REFEDIT half, CDDIAG and CDDASHBOARD, and what the windows show (Codex look K3_03)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 844
TIMEOUT 900
BUG BUG-1046
PROVES_BUGS BUG-1046 (the paper-space half for CDPARTS and CDLABELSTYLE only)
REVIEWED_AGAINST
EXPECTED After TILEMODE 0 and _.PSPACE (CTAB is a layout name, not Model): CDPARTS opens the Parts Catalogue window and prints no 'cannot run in Paper Space'; the window is closed; CDLABELSTYLE opens the Label Styles window, prints no refusal, and after it is closed prints '[CDLABELSTYLE] Active label style:'; CD prints '[CE] CD cannot run in Paper Space' and draws nothing; the model-space object count is the same at the end; back on the Model tab no CE window is left open. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the rule with a made-up command name; only the live commands on a real layout tab show the windows open and the refusal still holds for drawing commands.
NOT_AUTOMATED The REFEDIT half (the line 'cannot run while a reference is being edited' must be absent): Codex look K3_03.
NOT_AUTOMATED CDDIAG and CDDASHBOARD on a layout are not typed. What the two windows show is not read.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "TILEMODE{NL}0" -Force -> $tab
  wait
  type "_.PSPACE" -Force -> $ps
  wait
  getvar CTAB -> $ctab
  type "CDPARTS" -Force -ExpectWindow "Parts Catalogue" -TimeoutSec 90 -> $parts
  windows-snapshot -> $w_parts
  close-windows -> $closed1
  wait
  type "CDLABELSTYLE" -Force -ExpectWindow "Label Styles" -TimeoutSec 90 -> $style
  windows-snapshot -> $w_style
  close-windows -> $closed2
  wait
  esc-prompt
  wait
  type "CD" -Force -TimeoutSec 60 -> $cd
  wait
  esc-prompt
  wait
  ms-count -> $c1
  type "TILEMODE{NL}1" -Force -> $back
  wait
  windows-snapshot -> $win_end
ASSERT
  matches $ctab "^(?!Model$)."
  not-contains $parts "cannot run in Paper Space"
  contains $w_parts "Parts Catalogue"
  not-contains $style "cannot run in Paper Space"
  contains $w_style "Label Styles"
  history has "[CDLABELSTYLE] Active label style:"
  contains $cd "CD cannot run in Paper Space"
  history count "cannot run in Paper Space" = 1
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $ctab "the layout tab it stood on"
  record $parts "FULL CDPARTS"
  record $style "FULL CDLABELSTYLE"
  record $cd "FULL CD on the layout"
  record $closed1 "FULL what closing the Parts window did"
  record $closed2 "FULL what closing the Label Styles window did"
```

**Twin:** `W2005_BROKEN_parts_and_label_style_open_on_layout_sheet.case.txt`

```
# W2005_BROKEN DRAFT (Tue 3 Nov 2026; NOT RUN). The switch-off control: options.officeEditorsOpenAnywhere false before AutoCAD starts, so the old refusals return. The two commands are typed bare, with no ExpectWindow (a refused command opens nothing, so waiting for a window would time out and give BLOCKED instead of FAIL). The case still expects NO refusal. It must FAIL on the two 'not-contains ... cannot run in Paper Space' checks.
# If it PASSES, the old build also opens both windows on a layout, and W2005 cannot tell old from new: send the item to Codex look K3_03. If a window did open, the close-windows step closes it.
CASE W2005_BROKEN
TITLE BROKEN VARIANT of W2005: the new switch is OFF, so CDPARTS and CDLABELSTYLE refuse on the layout sheet, yet the case expects no refusal (must FAIL)
PLAN_ITEM red-before-green proof for W2005 (PR #2005, B-186, BUG-1046)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json options.officeEditorsOpenAnywhere false
ORDER 845
TIMEOUT 900
BUG BUG-1046
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W2005
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF both commands print '[CE] <command> cannot run in Paper Space. Please switch to the Model tab.', so the checks that no refusal appears fail; the layout is reached and no window is left open.
WHY_NOT_UNIT_TEST It exists only to prove W2005's refusal checks can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "TILEMODE{NL}0" -Force -> $tab
  wait
  type "_.PSPACE" -Force -> $ps
  wait
  getvar CTAB -> $ctab
  type "CDPARTS" -Force -TimeoutSec 60 -> $parts
  wait
  close-windows -> $closed1
  esc-prompt
  wait
  type "CDLABELSTYLE" -Force -TimeoutSec 60 -> $style
  wait
  close-windows -> $closed2
  esc-prompt
  wait
  type "TILEMODE{NL}1" -Force -> $back
  wait
ASSERT
  matches $ctab "^(?!Model$)."
  not-contains $parts "cannot run in Paper Space"
  not-contains $style "cannot run in Paper Space"
  copy-unchanged $copy0
  record $parts "FULL CDPARTS, switch OFF"
  record $style "FULL CDLABELSTYLE, switch OFF"
```

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a copy)

1. **K3_01, BUG-648 (PR #2001): the 1:50 text reads well on the plan.**
   1. Open a copy of an empty-ground drawing in millimetres. Type `CDAGI`, Enter, then points 5000,5000, 10000,5000, 10000,0, Enter, Enter (skip the outlet), start level 20.2, end level 20, Enter (Accept).
   2. Look: a "1:50" text sits just under the middle of the first (5 m) leg, reading left to right, on the AG drain's layer. It is readable and does not touch the line.
   3. Type `U` once. The line and the text both disappear.
   4. Control: Settings, Surface drainage, `agDrainGradeLabel` off, restart AutoCAD (the switch is read at launch), repeat. Only the line appears.
   5. Not claimed: the text does not yet follow the drain on MOVE, COPY or ERASE.
2. **K3_02, BUG-879 (PR #2002): the grips and the pit cover text.**
   1. Settings on: "hand-placed labels stay" ON and `linking.ceMovesMarkHandPlaced` ON before launch. Place P1, P2 and a 100 mm pipe. Run `CDTIDYLABELS` once.
   2. Click the pipe description. Use the "Slide along pipe" grip to move it onto a second label. Run `CDTIDYLABELS`. Look: the summary says "Placed by hand (left alone) 1" and the description stayed where you put it.
   3. Repeat for "Move away from pipe" and "Flip side".
   4. Pit variant: run `CDPITCOVERFLIP` on P1's cover text, then Tidy labels with pit text tidy on. Look: the flipped text stays and is counted under "Placed by hand".
   5. Control: `linking.ceMovesMarkHandPlaced` false before launch gives the old result (the label is moved again).
3. **K3_03, BUG-1046 (PR #2005): REFEDIT half and the windows themselves.**
   1. Open a copy that holds a block. Type `REFEDIT`, pick the block, OK. Type `CDPARTS`. Look: the Parts Catalogue opens and the line "cannot run while a reference is being edited" is absent. Close the window. Repeat with `CDLABELSTYLE`.
   2. Type `CD` inside the REFEDIT. Look: it still refuses.
   3. Close the edit with `REFCLOSE` then Discard. Do not save the block.
   4. On a layout sheet, look at both windows once: all words readable, nothing cut off.
4. **K3_04, BUG-958 (PR #2003, no robot route): the four windows reopen where you left them.**
   1. Set `windowPlacement.remember` ON and `windowPlacement.rememberFittedWindows` ON in `CD_Settings.json` before launch (Settings, "Remember where windows were last left").
   2. Open Edit Pipe on a pipe. Note where the window sits. Drag it about 300 pixels right and down. Press Cancel without saving.
   3. Open Edit Pipe again. Look: the window opens at the dragged spot, not at the centre, and is the same size as the first time. Repeat for Edit Pit, New Pit and the Settings window (CDS).
   4. Control: `rememberFittedWindows` false before launch. The windows open at the centre again.
   5. Not claimed: a second monitor or an undocked laptop. BUG-959 is a different fault, not in this PR.
5. **K3_05, BUG-1018 (PR #2004, no robot route): the pipe object enabler loads late and CDPIPEOBJ then works.**
   1. AutoCAD 2027 only, on a copy of a drawing with NO CE pipe objects in it (a new blank drawing is best). Check that the pipe object gate lets CDPIPEOBJ run on this PC (it is held on colleagues' PCs; if you see that line, stop).
   2. The enabler normally loads when AutoCAD starts. Type `ARX`, `U`, then `CE_CVL_OBJECTS_2027`. If AutoCAD refuses to unload it, stop: do not force it. This step is the risk: never unload it in a drawing that holds CE pipe objects.
   3. Type `CDPIPEOBJ`. Look: "needs the CE pipe object enabler (AutoCAD 2027 only). Nothing was drawn."
   4. Type `ARX`, `L`, and the path of `CE_CVL_OBJECTS_2027.dbx` in the installed bundle. Type `CDPIPEOBJ` again. Look: the line is gone and it asks "First point of the pipe object". Press Esc.
   5. Control: `options.pipeObjectEnablerRetryWhenNotLoaded` false before launch. Repeat; the "needs the enabler" line stays after the load.

---

## 4. Skipped items and why

1. **w806 (PR #2000, B-179, BUG-806, orifice detail head). No case.** I searched the PR head for who calls `OrificeDetailFieldMap`. Only `OrificeStandardDetailDrafter` does, and I found nothing outside that file and its comments that calls the drafter. The report says the same: no command or window reaches it, so nothing on the drawing changes yet. Case name when it is wired in: `N_orifice_head` (Bayside figures: expect "420 HIGH" and "55 DIA. ORIFICE"; control switch `detention.orificeDetailHeadFromOrificeIl` false gives "670 HIGH" and "56 DIA. ORIFICE"). Its open question to Tim (what the centre IL on the detail should show) is in the w806 report, not mine.
2. **w658 (B-180, BUG-658). No PR opened by the job.** The fix is PR #1972 (B-119). Its robot case and twin already exist: `cases\drafts_c79b1_01nov\W658_cascade_after_edit_save.case.txt` and `W658_BROKEN.case.txt`. #1972 is in b1 and b2. Not rewritten.
3. **w235 (BUG-235, a copied pit must not steal a pipe end). No PR opened.** Already fixed by BUG-1227 Part A (28d8b972, inside installed 3.0.89). Covered by the robot cases N35 and R34 (the copy on top of the original). The report's two gaps stay open and are not drafted here: a copy placed 50 mm off (not on top), and one Undo after COPY. Suggested case if wanted: COPY pit P3 by 50 mm, check P3 still lists every pipe, then U and compare; control `linking.pitCopyKeepsOriginalPipeEnds` false. I did not write it because the brief says to skip jobs with no PR.
4. **w958 (PR #2003, BUG-958). Robot cannot do it.** The check needs a window dragged and the new position read. The runner has no step that drags a Windows window (its pointer steps are for the drawing area only), and the press list allows only Save, Cancel and Close on Edit Pipe, Edit Pit and New Pit. Codex look K3_04.
5. **w1018 (PR #2004, BUG-1018). Robot cannot do it safely.** The enabler is set to load when AutoCAD starts (`PackageContents.xml`, `LoadOnAutoCADStartup="True"`), so the robot's AutoCAD always has it loaded. The runner has no way to start AutoCAD without it, and unloading it inside a drawing with CE pipe objects could crash AutoCAD. Codex look K3_05, with the risk stated.
6. **A REFEDIT case for #2005.** Needs a pick of a block reference, an in-place edit and a safe close. Not drafted; Codex look K3_03.
7. **The pit cover text and the three grips for #2002.** Grips need a click on a grip menu that the robot's press list does not include. Not drafted; Codex look K3_02.
8. **B-181.** I found no job, PR or report using this number. Nothing to draft.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** `C:\TimOS\RULES.md` (first 150 lines); `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` in full (format); the eight `BUGFIX_<key>_REPORT_03NOV.md` reports in full; `README_CASES.md` in full; `acad_driver_v3.allowlist.json`; the cases N27, N54 (full), R37 (full), R27 (header and steps), and the headers of S472a and W658; the PR text (`gh pr view`) for #2000 to #2005 and #1972; `UserSettings.cs` switch lines on the heads of #2001, #2002, #2004 and #2005; `AgiCommand.GradeLabel.cs` (#2001); `AnnotationEditCommand.cs` prompts and `HandPlacedLabelRule.cs` (#2002); `DrawingSafetyService.cs`, `PartsCatalogueCommands.cs`, `LabelStyleCommands.cs` and the two window XAML titles (#2005); `NativePipeObjectCommands.cs`, `CeCvlObjectsBridge.cs` and `PackageContents.xml` (#2004); the BUG-648 and BUG-879 entries in `REGRESSION_LOG.md`; ancestry and branch-contains checks of all six heads against 61fd6fbc, cf059dcf and aa3b92ac.
2. **Not read:** the code of #2003 beyond its report (I took the "robot cannot drag a window" finding from the allow-list and the driver steps list, not from a search of every step); the code of #2000 beyond the caller search; the runner's own code for how `select`, `dist`, `field` and `type` treat `{$name}` inside a chain; the N27 review file; whether DRV1_B1 has a layout tab or open ground near 155000,-85000.
3. **Built:** nothing. **Tested:** nothing. No case was validated with `case_runner.ps1 validate`, so first runs may need small fix-ups. No AutoCAD, no robot, no settings file touched, no git write (only `git fetch origin`, as instructed). I added the `gh` folder to the PATH of my own shell session.
4. **NOT proven:** every line marked DERIVED. In particular: that the typed `CDAGI` chain runs (N54 is itself unseen); that CDANNOTATIONEDIT accepts the start invert text and that a typed pick at its insertion point selects it; that the layout sheet can be reached on DRV1_B1 without a page-setup window; the window titles; that a robot AutoCAD with `CD_Settings.json` keys `surface.agDrainGradeLabel` and `options.officeEditorsOpenAnywhere` set via SETTING accepts group.key names for those groups (N27 shows it for `linking`).
5. **Where I differ from the reports or the brief:** w235's report says the installed commit is not on the release line it read; it is later than that line (3fbb9da5 is inside 61fd6fbc). The brief lists eight jobs and "one right case and one twin each"; only three of the eight can be a robot case, and I explain the other five above.
