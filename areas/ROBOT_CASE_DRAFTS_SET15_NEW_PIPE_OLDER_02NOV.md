# Robot case drafts, set 15: New Pipe, Edit Pipe and speed limits, older merged fixes (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Case drafts for six fix PRs that are already merged into earlier trains and installed. The case texts are below with the file name each should get. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. Git was used read-only (`git fetch`, `gh pr view`, `gh pr diff`).

---

## FOR TIM

1. **Done.** 4 robot tests written on paper, each with a deliberately wrong copy that must fail (8 case texts): W1838 (New Pipe never works out a downstream level flatter than the grade you chose), W1857 (a comma in the Diameter box is refused with a plain sentence), W1861 (one "Recent:" line under Size and Material), and W1700 (CDRG finishes when you press Enter; Undo at the first point no longer cancels).
2. **Example.** W1838 draws a 9.2 m pipe, chooses "Set my own" 1 in 100, types the upstream level 19.45, and checks the window works the downstream out as 19.35 and leaves the grade at 100 (the old window said 19.36 and 1 in 102). Its wrong copy turns the new switch off before AutoCAD starts and must fail.
3. **Two fixes are Codex-only, not robot:** #1846 (one-piece pipe object on for every Windows login: the robot only ever runs as Tim's login, where Automatic was already on, so it cannot tell old from new) and #1805 (Pipe Flows warnings: the CDCALC result sits in a window the robot cannot read reliably, and its roughness cell is typed). Exact Codex steps are in section 4.
4. **Needs an Opus review before it is run:** W1700 and its twin. CDRG draws an outline and the case ends with one U (Undo) on it, and it presses Enter and U inside a running command. The other three cases touch no Undo, REDO, locked layer or Xref.
5. **Safety note for the desk.** W1838 and W1861 change the "last used" New Pipe values on this PC (the settings guard does not restore them). Each ends with a reset pipe that puts them back (same pattern as N33a and W1947). W1857 cancels the window and draws nothing.
6. **None of the six already had a case.** I checked again (section 1, item 7). The PR texts name proposed cases N32_cd_grade_never_flatter, N40_comma_refused and N41_unset_speed; none exists in the cases folder, the drafts folders or the ledger. W1857 here covers N40's first half only; N41 (unset material speed) is not drafted.
7. **Not proven, plainly.** Every line marked DERIVED was read from the PR text and its tests, not seen on a run. The Recent button names, the "Ready to start the pipe." line and the exact text shown in the second-level box (19.35 against 19.350) are the weakest. All four drafts are build-pending checks: none has been validated with the runner, run, or reviewed.

---

## 1. How the drafts were written (read before validating)

1. **Format.** README_CASES.md format: header lines, `STEPS`, `ASSERT`. Every `type` chain is a complete command, no `(`, no SAVE-type word. Every twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`. Every PLAN_ITEM line says PART and which part.
2. **Switch-off twins.** W1838, W1857 and W1861 each have a twin that is the same route with the PR's own switch typed `false` through `SETTING CD_Settings.json` before AutoCAD starts (the style of `variants\R09s_new_switch_off_broken`). Only the check on the new behaviour should go red. If a twin PASSES the runner reports "now passes: candidate": that case cannot tell old from new and goes to Codex.
3. **W1700 has no switch** (the PR says the old behaviour was the bug). Its twin is an "old behaviour" copy: the same route but it expects the old line "CDRG command cancelled." after Enter. It must FAIL on any build holding #1700 and would pass on one without it. That is a weaker red-before-green proof than a switch twin; say so in any report.
4. **Route copied from proven patterns.** The New Pipe controls (`C2.Diameter`, `C2.IsGradeCustom`, `C2.CustomGrade`, `C2.AutoCalcSecondInvert`, `C2.IsAutoCalcUpToDown`, `C2.KnownInvert`, `C2.FirstInvert`, `C2.SecondInvert`, `C2.IsGradeDefault`, `C2.CreatePipeText`), the press `New pipe, Start Pipe` and the cancel `Cancel without saving` are as in SET01 W1947 and N33a. The CDRG prompts and corners are as in N04 (empty ground at 160000,-80000, DRV1_B1).
5. **Ground.** Pipes sit on free-end rows y -90000, -92000 and -94000 (as R31 and SET01 use), no pits. CDRG uses the N04 corners; the Undo and Enter legs use y -70000, which is empty ground in the same drawing (DERIVED from the N04 ground; not checked on a run).
6. **REVIEWED_AGAINST is empty** in every draft; no review file written. **Order numbers** 840 to 847. **Fixture** DRV1_B1, **SLOT fresh**.
7. **Check done again, as the brief asked.** I searched every `cases\drafts_*` folder, `variants`, `controls`, `_setups`, every `C:\CE_PLAN\areas\ROBOT_CASE_DRAFTS_*.md`, and `runner-reports\ledger.json` for the six PR numbers, the six bug numbers, the four switch names and the printed sentences ("Nothing to undo yet", "Pick at least 3 points", "has a comma"). No case and no draft. The only hits were unrelated: SET01 and the top-12 draft use the same CD route (not these fixes), N04 uses CDRG for a different fix (no pipe needed, closes with C), and the case ids N32, N40 and N41 in the folder are different cases (N32 is the office-layer case).
8. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set15_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.

---

## 2. The case texts

### Case 1 of 4: W1838, the downstream level is never flatter than the grade chosen (PR #1838, B-005, BUG-1229; orders 840 and 841)

**Intended file:** `W1838_downstream_level_never_flatter.case.txt`

```
# W1838 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1838 (B-005, BUG-1229), switch pipe.suggestedLevelNeverFlatterThanGrade, ON by default.
# Tim's sighting (Civil 3.0.85, 29 Oct): P10 to P9, 100 mm UPVC, 9.2 m, Set my own 1 in 100, "I know one end", typed 19.45. The window put 19.36 downstream and changed the grade box to 1 in 102. Fix: the suggested level is rounded DOWN to the Settings step (10 mm), so 19.358 gives 19.35 (0.10 m fall over 9.2 m, 1 in 92) and the box keeps 100.
# Route: CD between two free ends 9.2 m apart (150000,-90000 to 159200,-90000), 100 mm, text off, Set my own 1 in 100, "I know one end" ON with the upstream known, level 19.45. The grade box is typed again after the level so the window re-works the level the way a typed character does (the old fault happened at the next typed character).
# No pits, so no pit-wall shortening: length 9.200 m (DERIVED from the typed points; not seen on a run).
# Remembered values: YES. New Pipe saves grade mode, the Set my own value, "I know one end", text and size to CD_RecentValues.json, which the settings guard does NOT restore. The case ends with a RESET pipe (Standard grade, work-out off, 225, text on, 18.000 / 17.900) as N33a and W1947 do. If the case stops early, put the New Pipe values back by hand.
# DERIVED, never seen on a run: that the second-level box reads exactly '19.35' (it may read '19.350'; if the check fails on that alone, loosen it and say so); the pipe's IL texts reading 19.45 and 19.35; that no Grade mismatch window opens. The PR says Start Pipe already rounds the fall UP, so the DRAWN pipe may read 19.35 on the old build too: the window box is the check that goes red, not the drawn IL.
CASE W1838
TITLE New Pipe, Set my own 1 in 100, one end known at 19.45 on a 9.2 m pipe: the downstream box reads 19.35 (never 19.36) and the grade box still reads 100
PLAN_ITEM PR #1838 (BUG-1229, B-005) PART: the upstream-known direction on one 9.2 m pipe, read from the New Pipe window before Start Pipe plus the two drawn IL texts. NOT whole: the downstream-known direction, the 20 m example (19.25), Edit Pipe, the Start Pipe label 1 IN 92 and a different Calculated decimals step are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.suggestedLevelNeverFlatterThanGrade true
ORDER 840
TIMEOUT 1500
BUG BUG-1229
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CD from 150000,-90000 to 159200,-90000, 100 mm, Set my own 1 in 100, "I know one end" ON (upstream known), level 19.45: the New Pipe window shows the second level 19.35 and the grade box 100; no Grade mismatch window after Start Pipe; one new CE pipe; its IL texts read 19.45 and 19.35. A reset pipe follows. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests call the rounding rule; only the live window decides, at the next typed character, whether a level CE suggested is held as the drafter's own fall and written back into the grade box.
NOT_AUTOMATED The Start Pipe label (1 IN 92), the 20 m example and the downstream-known direction are not checked (Codex look K_1838 in section 4 if wanted).
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}159200,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "on"
  ui2-set "New Pipe" "C2.IsAutoCalcUpToDown" "on"
  ui2-set "New Pipe" "C2.KnownInvert" "19.45"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start1
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w1
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new1
  select $new1 "object~^CeCvlPipeObject$" -> $pipe1
  select $new1 "text~^IL " -> $ils1
  field $ils1 text -All -> $ilt1
  log-read civil -> $civlog
  type "CD{NL}150000,-94000{NL}170000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
ASSERT
  control $np1 "C2.SecondInvert" value "19.35"
  control $np1 "C2.CustomGrade" value "100"
  not-contains $w1 "Grade mismatch"
  count $pipe1 = 1
  matches $ilt1 "IL 19\.450?(?!\d)"
  matches $ilt1 "IL 19\.350?(?!\d)"
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window after the level was typed (second level, grade box)"
  record $cd1 "FULL CD"
  record $ilt1 "the IL texts of the pipe"
  record $civlog "FULL new Civil CE log lines"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

**Twin:** `W1838_downstream_level_never_flatter_BROKEN.case.txt`

```
# W1838_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control: pipe.suggestedLevelNeverFlatterThanGrade typed false before AutoCAD starts (OFF = the old behaviour exactly: 19.36 and 1 in 102). Same route, same window checks. It must FAIL on the two 'control' checks (second level and grade box). If it PASSES, the robot's typed entry did not trigger the old fault: W1838 then proves nothing and the fix goes to Codex look K_1838.
CASE W1838_BROKEN
TITLE BROKEN VARIANT of W1838: the never-flatter switch is OFF, the case still expects 19.35 and a grade box of 100 (must FAIL)
PLAN_ITEM red-before-green proof for W1838 (PR #1838, BUG-1229)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.suggestedLevelNeverFlatterThanGrade false
ORDER 841
TIMEOUT 1200
BUG BUG-1229
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1838
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the window rounds to the nearest 10 mm, so the second level reads 19.36 and the grade box 102; the two 'control' checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1838's window checks can go red.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}159200,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "100"
  ui2-set "New Pipe" "C2.CreatePipeText" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "on"
  ui2-set "New Pipe" "C2.IsAutoCalcUpToDown" "on"
  ui2-set "New Pipe" "C2.KnownInvert" "19.45"
  ui2-set "New Pipe" "C2.CustomGrade" "100"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start1
  await-window-gone "^New Pipe" -Secs 120
  sleep 4
  windows-snapshot -> $w1
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new1
  select $new1 "text~^IL " -> $ils1
  field $ils1 text -All -> $ilt1
  type "CD{NL}150000,-94000{NL}170000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
ASSERT
  control $np1 "C2.SecondInvert" value "19.35"
  control $np1 "C2.CustomGrade" value "100"
  not-contains $w1 "Grade mismatch"
  record $np1 "the New Pipe window, switch OFF"
  record $ilt1 "the IL texts, switch OFF"
```

---

### Case 2 of 4: W1857, a comma figure in the Diameter box is refused (PR #1857, B-011, #1788 extras; orders 842 and 843)

**Intended file:** `W1857_comma_figure_refused.case.txt`

```
# W1857 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1857 (B-011, the first of the two #1788 extras), switch pipe.boxRefusesCommaFigure, ON by default. Tim, 29 Oct 2026 on #1788: "agreed to two small extras".
# The PR's own worked example: in New Pipe, typing 630,5 in Diameter holds Start Pipe and the line under the window reads 'Diameter box: 630,5 has a comma: type 630.5'. Typing 630.5 brings the button back; the line then reads 'Ready to start the pipe.' (that last line is from the PR's AutoCAD check, DERIVED).
# Route: CD between two free ends (150000,-90000 to 160000,-90000), type 630,5, read the window, then 630.5, read the window again, then Cancel without saving. No pipe is drawn and no Start Pipe is pressed, so the remembered New Pipe values are not changed (DERIVED: Cancel without saving does not remember the typed size).
# The check reads the window text, not the drawing. The sentence is from TypedFigureCommaRule.Refusal in the PR diff (Rules/TypedFigureCommaRule.cs).
# DERIVED, never seen on a run: that the dump holds the sentence as plain control text; that the Start Pipe button name is 'New pipe, Start Pipe' in the dump and reads enabled again after 630.5; the 'Ready to start the pipe.' wording.
CASE W1857
TITLE New Pipe: 630,5 typed in Diameter shows 'Diameter box: 630,5 has a comma: type 630.5'; 630.5 clears it and Start Pipe is ready again; nothing is drawn
PLAN_ITEM PR #1857 (B-011, #1788 extras) PART: the comma refusal on the Diameter box in New Pipe only. NOT whole: the Start Pipe button being greyed while the comma is there, Edit Pipe (CDEDIT), the level boxes and the detention length box, the 1,200 two-readings sentence, and the second extra (unset material speed, the N41 case) are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.boxRefusesCommaFigure true
ORDER 842
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED New Pipe opens for the two free ends. With 630,5 in Diameter the window text holds 'Diameter box: 630,5 has a comma: type 630.5'. With 630.5 in Diameter that sentence is gone, the window text holds 'Ready to start the pipe.' and the Start Pipe button is enabled. Cancel without saving closes the window; no CE pipe was added; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests call the rule on a string; only the live window decides whether the typed Diameter box is read by the rule, shows the sentence under the window and clears it on the next typed figure.
NOT_AUTOMATED That the Start Pipe button is greyed while the comma stands is not asserted (the check list has no 'disabled' check): it is in the recorded window dump and in the Codex look K_1857 (section 4).
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}160000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "630,5"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui2-set "New Pipe" "C2.Diameter" "630.5"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np2
  ui-press "New Pipe" "Cancel without saving" -> $cancel
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc1
  wait
  ms-count -> $c1
ASSERT
  control-text $np1 has "Diameter box: 630,5 has a comma: type 630.5"
  control-text $np2 absent "has a comma"
  control-text $np2 has "Ready to start the pipe."
  control $np2 "New pipe, Start Pipe" enabled
  equals $c1 $c0
  copy-unchanged $copy0
  record $np1 "FULL New Pipe window with 630,5 typed (the sentence under the window, the Start Pipe button state)"
  record $np2 "FULL New Pipe window with 630.5 typed"
```

**Twin:** `W1857_comma_figure_refused_BROKEN.case.txt`

```
# W1857_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control: pipe.boxRefusesCommaFigure typed false before AutoCAD starts (OFF = the old behaviour: no sentence, Start Pipe stays enabled). Same route and the same sentence check. It must FAIL on 'control-text $np1 has "Diameter box: ..."'. If it PASSES, the sentence shows with the switch off and W1857 proves nothing.
CASE W1857_BROKEN
TITLE BROKEN VARIANT of W1857: the comma-refusal switch is OFF, the case still expects the comma sentence (must FAIL)
PLAN_ITEM red-before-green proof for W1857 (PR #1857, B-011)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.boxRefusesCommaFigure false
ORDER 843
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1857
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF there is no comma sentence under the window, so the 'has' check on 630,5 fails.
WHY_NOT_UNIT_TEST It exists only to prove W1857's sentence check can go red.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  ms-count -> $c0
  type "CD{NL}150000,-90000{NL}160000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd1
  ui2-set "New Pipe" "C2.Diameter" "630,5"
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np1
  ui-press "New Pipe" "Cancel without saving" -> $cancel
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc1
  wait
ASSERT
  control-text $np1 has "Diameter box: 630,5 has a comma: type 630.5"
  record $np1 "the New Pipe window with 630,5 typed, switch OFF"
```

---

### Case 3 of 4: W1861, one "Recent:" line under Size and Material (PR #1861, B-043a, BUG-1238; orders 844 and 845)

**Intended file:** `W1861_one_recent_line_new_pipe.case.txt`

```
# W1861 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1861 (B-043a, BUG-1238, slice S1 of the New Pipe declutter), switch pipe.declutteredLayout, ON by default. Tim, 29 Oct: "i am happy with that".
# The fix puts the Recent size, Recent material and Recent level buttons on ONE 'Recent:' line under Size and Material. With the switch OFF the one-page window has no recent size or material buttons (B-006's window). The automation names come from the PR's tests: 'Use recent diameter 150 mm', 'Use recent material UPVC', 'Use recent invert 18.190 m AHD' (DERIVED; the robot has not seen them in a dump).
# Route: draw two pipes so the recent list holds 150 and 225: pipe A (150 mm) then the reset pipe (225 mm, which is also the remembered-values reset the pattern needs). A third CD opens New Pipe, reads the dump, and cancels. No pit, no pit-wall shortening.
# What this does NOT prove: the line sits under the Size and Material boxes, the window does not scroll, nothing runs off the edge, a small laptop scale. Those are a window look; the PR says it needs a Codex look at real size and a small laptop scale (K_1861 in section 4).
# DERIVED, never seen on a run: that the dump lists the buttons by automation name; that the recent list holds 150 once a 150 pipe has been started; that the caption text 'Recent:' is in the dump. Both control names and the text can be adjusted after the first run, but a twin that PASSES means the check cannot tell old from new.
CASE W1861
TITLE New Pipe shows ONE 'Recent:' line with a 'Use recent diameter 150 mm' button after a 150 mm pipe has been drawn
PLAN_ITEM PR #1861 (B-043a, BUG-1238) PART: the 'Recent:' caption and one recent-size button exist in the New Pipe window (read from the window dump). NOT whole: the line's position under Size and Material, no scroll, the recent material and level buttons, pressing a button to fill a box, Edit Pipe, and a small-laptop scale are not checked
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.declutteredLayout true
ORDER 844
TIMEOUT 1500
BUG BUG-1238
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Two pipes are drawn first (150 mm, then 225 mm with the New Pipe values reset to Standard grade, text on, 18.000 / 17.900). The third New Pipe window shows the caption 'Recent:' and a button named 'Use recent diameter 150 mm'. The window is cancelled; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests build the window layout in memory; only the live New Pipe window, fed by the real remembered values from two drawn pipes, shows the buttons.
NOT_AUTOMATED The position of the line, scrolling, edge clipping, the material and level buttons, button presses (the press list has no recent buttons) and Edit Pipe are Codex look K_1861 (section 4).
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  type "CD{NL}150000,-90000{NL}160000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdA
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startA
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escA
  wait
  type "CD{NL}150000,-92000{NL}160000,-92000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
  type "CD{NL}150000,-94000{NL}160000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd3
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np3
  ui-press "New Pipe" "Cancel without saving" -> $cancel
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc3
  wait
ASSERT
  control-text $np3 has "Recent:"
  control $np3 "Use recent diameter 150 mm" exists
  copy-unchanged $copy0
  record $np3 "FULL third New Pipe window (the Recent line, every button name)"
  record $cdR "FULL CD reset pipe (puts the remembered New Pipe values back)"
```

**Twin:** `W1861_one_recent_line_new_pipe_BROKEN.case.txt`

```
# W1861_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control: pipe.declutteredLayout typed false before AutoCAD starts (OFF = B-006's window: the levels row under the level boxes, no recent sizes or materials). Same route, same checks. It must FAIL on 'control $np3 "Use recent diameter 150 mm" exists'. If it PASSES, the old window already shows the button and W1861 cannot tell old from new: Codex look only.
CASE W1861_BROKEN
TITLE BROKEN VARIANT of W1861: the declutter switch is OFF, the case still expects the recent-size button (must FAIL)
PLAN_ITEM red-before-green proof for W1861 (PR #1861, BUG-1238)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.declutteredLayout false
ORDER 845
TIMEOUT 1500
BUG BUG-1238
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1861
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the one-page window has no recent size buttons, so the 'exists' check fails.
WHY_NOT_UNIT_TEST It exists only to prove W1861's button check can go red.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  type "CD{NL}150000,-90000{NL}160000,-90000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdA
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startA
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escA
  wait
  type "CD{NL}150000,-92000{NL}160000,-92000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
  type "CD{NL}150000,-94000{NL}160000,-94000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd3
  sleep 2
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np3
  ui-press "New Pipe" "Cancel without saving" -> $cancel
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc3
  wait
ASSERT
  control $np3 "Use recent diameter 150 mm" exists
  record $np3 "the third New Pipe window, switch OFF"
```

---

### Case 4 of 4: W1700, CDRG finishes on Enter; Undo at the first point no longer cancels (PR #1700, BUG-771, FB-13; orders 846 and 847)

**Needs an Opus review before it is run** (Undo inside a running command; the case ends with one U on the new raingarden).

**Intended file:** `W1700_cdrg_enter_finishes_undo_keeps_asking.case.txt`

```
# W1700 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1700 (BUG-771, FB-13). No switch: the old behaviour was the bug.
# Sentences from the PR diff (Commands/RaingardenOutlineStep): '[CE] Pick at least 3 points (2 so far).' and '[CE] Nothing to undo yet. Pick the next point.'. Prompts read from N04: 'Specify first raingarden point:' and 'Add a GIO source to this raingarden? [Place/Skip] <Skip>:'. Old behaviour printed 'CDRG command cancelled.' and drew nothing when Enter was pressed.
# Leg 1 (Undo then too few points): CDRG, first point 160000,-70000, U (nothing to undo yet, keeps asking), second point 161000,-70000, then Enter with only 2 points (must say 'Pick at least 3 points (2 so far).' and keep asking), then Esc: 'CDRG command cancelled.' and nothing drawn. The chain does not end on Enter: the final auto-Enter of the type step is the blank Enter after the second point.
# Leg 2 (Enter finishes): CDRG, the four N04 corners 160000,-80000 / 164000,-80000 / 164000,-77000 / 160000,-77000, then a blank Enter (two {NL} in a row after the last point), then Skip at the GIO question. Right = an outline of 4 vertices, 'Raingarden RG<n> placed. 4 vertices, 12.0 m2' (area DERIVED: N04's formula with INSUNITS 4, not seen on a run). The old build would say 'CDRG command cancelled.' and draw nothing.
# Then one U: echoes CDRG and takes the raingarden back (N04 pattern); the object count returns to the count after leg 1.
# Not an Xref or locked-layer case: empty ground, new object on its own layer. Nothing is unlocked or bypassed.
CASE W1700
TITLE CDRG: Enter after four corners closes the outline (Raingarden placed, 4 vertices); Undo at the first point says nothing to undo and keeps asking; Enter after 2 points asks for more; Esc draws nothing
PLAN_ITEM PR #1700 (BUG-771, FB-13) PART: three of its four sentences, driven by typed answers: Enter finishes with 4 corners, Undo with one point keeps asking, Enter with 2 points keeps asking. NOT whole: right-click as the finish, exactly 3 points, snapping back to the first point, the Close keyword wording, and the raingarden's look are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 846
TIMEOUT 900
BUG BUG-771
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Leg 1 prints '[CE] Nothing to undo yet. Pick the next point.' then '[CE] Pick at least 3 points (2 so far).', then Esc prints 'CDRG command cancelled.' and the object count has not changed. Leg 2 prints 'Raingarden RG<n> placed. 4 vertices, 12.0 m' with no 'CDRG command cancelled.' after the Enter; the object count rises by the outline. One U echoes CDRG and the count returns to the count after leg 1. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests call the decision rule on a prompt result; only a live CDRG prompt shows that a typed Enter or U reaches that rule and not the old cancel.
NOT_AUTOMATED Right-click to finish and exactly three points are not driven (the pointer verbs prove their own hit and this prompt needs no pointer); the outline's look and the RG label are a picture item.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRG{NL}160000,-70000{NL}U{NL}161000,-70000" -Force -> $leg1
  esc-prompt -> $leg1_esc
  wait
  ms-count -> $c1
  type "CDRG{NL}160000,-80000{NL}164000,-80000{NL}164000,-77000{NL}160000,-77000{NL}{NL}Skip" -Force -> $leg2
  wait
  sleep 2
  ms-count -> $c2
  ms-new $c1 -> $new_rg
  field $new_rg object -All -> $rg_objects
  type "U" -> $u1
  wait
  ms-count -> $c3
ASSERT
  history has "Nothing to undo yet. Pick the next point."
  history has "Pick at least 3 points (2 so far)."
  history count "CDRG command cancelled." = 1
  equals $c1 $c0
  history has "Add a GIO source to this raingarden?"
  history has "Raingarden RG"
  # DERIVED (N04's formula, INSUNITS 4, typed corners), not seen on a run:
  history has "placed. 4 vertices, 12.0 m"
  history absent "Error during CDRG"
  history absent "was not placed"
  number $c2 > $c1
  contains $u1 "CDRG"
  equals $c3 $c1
  copy-unchanged $copy0
  record $leg1 "FULL what CDRG printed for the Undo and 2-point leg"
  record $leg1_esc "FULL the Esc line"
  record $leg2 "FULL what CDRG printed for the Enter leg"
  record $rg_objects "object types CDRG added"
  record $u1 "FULL what U printed"
```

**Twin:** `W1700_cdrg_enter_finishes_undo_keeps_asking_BROKEN.case.txt`

```
# W1700_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). #1700 has no switch, so this twin is an OLD-BEHAVIOUR copy, not a switch-off copy: the same Enter leg, but it expects the OLD result (Enter cancels, nothing drawn, no 'Raingarden RG... placed'). It must FAIL on any build holding #1700 and would PASS on one without it. This is a weaker proof than a switch twin: the real red-before-green proof is the same case on an older build.
CASE W1700_BROKEN
TITLE BROKEN VARIANT of W1700: expects the OLD CDRG result after Enter (cancelled, nothing drawn) (must FAIL)
PLAN_ITEM red-before-green proof for W1700 (PR #1700, BUG-771)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 847
TIMEOUT 600
BUG BUG-771
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1700
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the fix installed Enter closes the outline, so 'CDRG command cancelled.' is absent and the object count rises; both checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1700's Enter check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDRG{NL}160000,-80000{NL}164000,-80000{NL}164000,-77000{NL}160000,-77000{NL}{NL}Skip" -Force -> $leg2
  wait
  sleep 2
  ms-count -> $c2
ASSERT
  history has "CDRG command cancelled."
  equals $c2 $c0
  record $leg2 "FULL what CDRG printed for the Enter leg"
```

---

## 3. What was read, built, tested and NOT proven

1. **Read:** `C:\TimOS\RULES.md` (top), `README_CASES.md` in full, the press list in `acad_driver_v3.allowlist.json` (the New Pipe entries), SET01 (the finished New Pipe example with the reset-pipe pattern), N04 (CDRG route), the six PR texts with `gh pr view`, and the sentences, switch names and control names from the PR diffs with `gh pr diff`. I did not re-read the TOP12 and WAVE1 drafts in full: SET01 already follows their format and I copied its header lines, so the match to those two is by SET01, not direct. I did not read BUG_CARPARK.md entries, the BUGFIX reports in `C:\CE_PLAN\areas`, the repo's REGRESSION_LOG.md, or the runner reports for R02, R14, R18 and N04 (only N04 itself): the drafts rest on the PR texts. I did not check which of these PRs are in the installed build beyond the brief's word.
2. **Built:** nothing. **Tested:** nothing. No AutoCAD, no robot, no validate run.
3. **NOT proven:** every case is a draft. Any line marked DERIVED may be wrong. The window-dump control names (`C2.SecondInvert`, `C2.CustomGrade` as reads, `Use recent diameter 150 mm`, the Start Pipe `enabled` check) are untested, and the dump may hold values with a different number of decimals. A twin that PASSES instead of failing means that case cannot tell old from new.
4. **Not checked:** whether each switch name still holds the default stated in its PR on `origin/claude/rel-20261102a` (the brief and the PR texts agree; I did not open the settings file in the repo).

---

## 4. Codex look notes (cases the robot cannot prove)

Evidence folder for every look: `C:\CE_WORK\codex\<look id>\`. Never accept or capture a folder the box opened in.

### K_1846: one-piece pipe object on for every Windows login (PR #1846, B-046). BLOCKED-FOR-ROBOT: the robot always runs as Tim's login, where Automatic was already on before this fix, so old and new look the same.

1. **Set up.** AutoCAD 2027, a Windows login that is NOT Tim's (Max's, or a test login), Settings, Advanced, One-piece pipes left on Automatic. Do not edit any settings file by hand.
2. **Do.** Open a drawing with an old-style pipe. Draw one new pipe with CD. Then select the new pipe and the old pipe and look at the object type (the Properties palette or the CE pipe check).
3. **Right looks like.** The new pipe is the one-piece CE pipe object and the old pipe is upgraded to it, with Automatic on that login. Settings reads "On" (or the Automatic wording that says it is on for everyone); the two new sentences in Advanced Settings are readable.
4. **Also.** Set One-piece pipes to Off on the same login: new pipes stay ordinary. Set it to On: they are one-piece. On AutoCAD 2022 to 2024 (if a machine is to hand) pipes stay ordinary.
5. **Evidence.** Screenshot of the Settings row, screenshot of the Properties of the new pipe, a note of the login name and the AutoCAD year, saved to `C:\CE_WORK\codex\K_1846\`.
6. **Note.** PR #1844's F23s and F23x robot cases expect "held (setting Automatic ..." on a non-Tim login and change meaning once this fix lands (the PR says so).

### K_1805: Pipe Flows warns at the Settings speed limits (PR #1805, BUG-1089). BLOCKED-FOR-ROBOT: the CDCALC Pipe Flows result and warning sit in a window with a typed roughness box, and the robot cannot read CDCALC results reliably (the old memory note: CDCALC results are window-only).

1. **Set up.** AutoCAD with the Civil bundle, Settings, Newer tools, "[CE] Pipe Flows uses the Settings speed limits" ticked, the Settings minimum speed 0.6 m/s and the general maximum 6 m/s.
2. **Do.** Type CDCALC and open Pipe Flows. Enter 300 mm, concrete roughness, grade 1 in 600.
3. **Right looks like.** The speed reads 0.56 m/s and the existing sedimentation warning shows.
4. **Then.** 375 mm at 1 in 20: speed 3.55 m/s, with no scour warning (the maximum is 6 m/s).
5. **Switch off.** Untick the row in Settings, Save, close and reopen AutoCAD: the old 0.5 and 3.0 m/s limits apply (3.55 m/s now warns).
6. **Evidence.** One screenshot per case above (three images), the Settings tick row, saved to `C:\CE_WORK\codex\K_1805\`.

### K_1838, K_1857 and K_1861: the window looks the robot cannot give

1. **K_1838.** New Pipe, Set my own 1 in 100, "I know one end", level 19.45 on a 9.2 m pipe: the second level reads 19.35 and the grade box still reads 100. After Start Pipe the pipe label reads 1 IN 92. Then type a 20 m pipe: second level 19.25. Evidence in `C:\CE_WORK\codex\K_1838\`.
2. **K_1857.** New Pipe and Edit Pipe: 630,5 in Diameter greys Start Pipe (Save in Edit Pipe) and the line under the window reads "Diameter box: 630,5 has a comma: type 630.5". Then 1,200 gives both readings ("type 1200 (no comma) or 1.200 (decimal point)"). Then the second extra: CDRULES on a pipe whose material has no speed limit shows the office Maximum pipe velocity line. Evidence in `C:\CE_WORK\codex\K_1857\`.
3. **K_1861.** New Pipe and Edit Pipe at real size and at a small-laptop scale: one "Recent:" line under Size and Material holding recent sizes, materials and levels. Press 150 and the Size box reads 150; press UPVC SN8 and the Material box reads UPVC SN8. The window must not scroll and the plan preview stays at the bottom. Evidence in `C:\CE_WORK\codex\K_1861\`.

---

## 5. Fixes skipped and why

1. **#1846 (B-046):** drafted as Codex-only (K_1846), no robot case: the robot only runs as Tim's login.
2. **#1805 (BUG-1089):** drafted as Codex-only (K_1805), no robot case: window-only result and a typed roughness box. I spent about the three minutes allowed on it.
3. **#1857's second half (unset material speed, N41):** not drafted. It needs a CDRULES run with a blank material speed and the CDRULES saved findings text (a separate read); the robot could do it, but it is a separate case. It is in K_1857.
4. **Cases already existing:** none of the six.
