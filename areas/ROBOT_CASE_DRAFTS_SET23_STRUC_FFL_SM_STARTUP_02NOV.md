# Robot case drafts, set 23: Structural FFL, section mark SM and start-up refresh (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Four robot cases, each with a failing twin (8 case texts), written as plain text below with the file name each should get. One fix (#1915) cannot be proved by the robot, so it has a numbered Codex look. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `git fetch`, `gh pr view` and `gh pr diff`).

---

## FOR TIM

1. **4 robot cases with a failing twin each drafted (8 case texts):** W1933 (FFL asks the level source first, then the whole mark), W1934 (FFL triangle, tail and value are one AutoCAD group), W1981 (SM asks number and sheet before the points and waits for Enter; Escape draws nothing), W1981b (SM places the SECT MARK bubbles on Enter).
2. **Codex-only: #1915** (unticked Background refresh stops the start-up scan), marked BLOCKED-FOR-ROBOT. It needs the tick box off before AutoCAD starts, and the robot cannot set a Structural setting (see item 5). Exact steps are in Codex look K23_04.
3. **Every robot case here is a PART claim.** The picture of the preview (FFL and SM) and MOVE, COPY, ERASE and Undo on the FFL group need a Codex look (K23_01 to K23_03). The robot reads only the prompts, the printed lines, the object counts and the group list.
4. **Needs an Opus review before it is run:** nothing in the four robot cases presses U or REDO, touches a locked layer or an Xref. The two Codex looks that DO touch Undo (K23_02, the group and Undo) and the locked-layer stop (K23_01 step 7) should be reviewed by Opus before Codex runs them.
5. **No "switch off" twin is possible for any of these.** All three switches default ON, so the robot cases need no setting. But the robot's settings line writes a bare `CS_Settings.json` into the `TIM_CE_CADTOOLS` folder, and Structural 1.0.125 reads `CE_STRUC_SUITE\CS_Settings.json`. A switch-off twin would look like it ran and prove nothing. So each twin claims the OLD behaviour (the old first question, no group, the drawn bubble) and must FAIL on a build that has the fix. A twin that PASSES means the case cannot tell old from new: say so.
6. **Collision with two earlier drafts.** W1879 (set 09) and W1885 (set 22) type FFL as `FFL, point, side, value`. Once #1933 is merged and the switch is ON, FFL asks the level source first, so those two chains go out of step and must be changed to `FFL, Manual, value, point`. I did not edit them.
7. **What I could not verify:** that the Structural module is loaded in the robot AutoCAD (earlier robot runs typed BT1 and CSREOBAR on `DRV2_S1`, so it should be; every case also checks "Unknown command" never appears); that the installed Structural is a build that holds these fixes (these PRs are open and not merged, so on the installed 1.0.125 every main case would FAIL and every twin PASS: they only mean something after the train build is installed); that the office SECT MARK block is on this PC (W1981b depends on it); every prompt and printed line below was read from the PR diff, not seen on a run (all marked DERIVED).
8. **Nothing for you to test or decide.**

---

## 1. How the drafts were written (read before validating)

**What I read.**
1. `C:\TimOS\RULES.md`; `cases\README_CASES.md` in full; `acad_driver_v3.allowlist.json` (refused buttons: anything with Save, Apply, Export, Publish, Reset and so on; the settings window may only be closed with Cancel or Close).
2. The finished examples `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` and `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`; the Structural drafts of sets 09 and 22 (same FFL command, same fixture); `CASE_WRITING_STRUC_REPORT_30OCT.md`.
3. For each PR: `gh pr view` and `gh pr diff` (code, tests, REGRESSION_LOG text, switch name and default), the carpark entries BUG-626, BUG-627, BUG-630 and BUG-1203, and the SM and level-mark code at `origin/claude/rel-20261026s` after a `git fetch`.
4. No `BUGFIX_*_REPORT_*.md` in `C:\CE_PLAN\areas` describes these four fixes (the reports that matched were other bugs; the carpark notes for BUG-1203 point at the PR only).

**Re-check that no case exists (the earlier search matched the bug number as text only).** I searched the cases folder (main, `variants`, `_setups` and every `drafts_*` folder), every `ROBOT_CASE_DRAFTS_*.md` file and `runner-reports\ledger.json` for the four PR numbers, BUG-626, BUG-627, BUG-630, BUG-1203, and the words FFL, SECT MARK, SectionMark, FflOffers, LevelMarkGroups and BackgroundRefresh.
1. **#1933, #1934, #1981, #1915:** no case and no draft. The only FFL cases are the Level Update drafts W1879 and W1885, which use FFL only to draw a mark (see FOR TIM item 6). The ledger holds no result for any of them.

**Format.**
1. README format: header lines, `STEPS`, `ASSERT`. Case ids `W<PR number>` (W1981b for the second SM case) and `_BROKEN` twins, order numbers 920 to 927, fixture `DRV2_S1` (the Structural test copy; the same choice as sets 09 and 22), `SLOT fresh`, `REVIEWED_AGAINST` left empty, every `type` chain a complete command with no `(` and no SAVE-type word.
2. Every case starts with `settings-arm`: FFL and SM each save a remembered value into the Structural settings file, and `settings-arm` puts the exact bytes back at the end. No case uses `hashes-unchanged` (it conflicts with `settings-arm`); `copy-unchanged` proves the drawing file on disk is untouched.
3. **Empty ground.** 28000,18000 to 36000,30000 is the area sets 09 and 22 already use. If a first run shows an unexpected object there, move every x by the same amount.
4. **Chain counting.** `type` adds one Enter at the end. For SM, `SM{NL}{NL}T9{NL}{NL}30000,20000{NL}34000,20000{NL}` is: SM, Enter at the mode question, T9, Enter for a blank sheet, start, end, then the closing Enter takes the direction default and the command waits at the preview question. One more `{NL}` at the end makes the closing Enter place the mark.
5. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set23_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run the validator (I may not create files).
6. **DERIVED means:** read from the PR diff or the code, never seen on a run. Expect one or two fix-ups at first run.

**Nothing here unlocks a layer, detaches or unloads an Xref, or bypasses any AutoCAD protection.** The cases draw on layers 25DIMS, 25TEXT and the current layer, and press no U or REDO. If a layer in the fixture is locked, the PR's own stop line appears and the case FAILS; it is never worked around.

---

## 2. The cases

### Case 1 of 4: W1933, FFL asks the level source first, then shows the whole mark (PR #1933, B-107, BUG-626)

**Intended file:** `W1933_ffl_source_then_preview.case.txt`

```
# W1933 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1933 (B-107, BUG-626), base claude/rel-20261026s. Switch Annotation.FflOffersSourceAndPreview, Default: on (CS_Settings.json). Off gives the earlier prompts (point, side, value) exactly.
# Carpark BUG-626 (15 Oct 2026, Structural 1.0.116): FFL went point, side, value, then drew at once; no source choice, no preview, no placement click. Tim item 162 ("2yes"): Manual and Unknown only, with preview, F to flip, click to place.
# Route read from LevelMarkSourceFlow.cs in the PR diff (DERIVED, not seen on a run): FFL asks 'Level source [Manual/Unknown] <Manual>: ' (keyword question, Enter = Manual). Manual then asks 'Level value (e.g. +150, RL42.350, -50):'. Then the whole mark follows the cursor: 'Pick FFL point (right side) or [Flip]: '. A typed point places it; the word F turns it to 'Pick FFL point (left side) or [Flip]: '; Escape draws nothing. Placed lines (DERIVED): '[FFL] Level mark created.' and for Unknown '[FFL] Level mark created (level source: Unknown).' Unknown writes the plain word Unknown and asks no value. Manual writes the value in capitals.
# A mark is a triangle (closed polyline on 25DIMS), a tail (line on 25DIMS) and the value text (25TEXT): three objects. Three marks are placed (Manual 12.345, Unknown, Manual 5.5 after F) and one is cancelled by Escape, so the drawing gains exactly 9 objects: 3 texts on 25TEXT and 6 on 25DIMS (DERIVED from BuildSymbol, BuildTail, BuildLabel).
# The robot cannot see the preview picture: that is Codex look K23_01. Here only the prompts, the printed lines and the objects are read.
# Remembered values: YES. FFL saves the last level-mark type into the Structural settings file; settings-arm restores every settings file by hash at the end.
# No U or REDO is driven.
CASE W1933
TITLE FFL asks the level source first (Manual or Unknown), then the value for Manual, then the placement question with Flip; Unknown writes the word Unknown; F turns the side; Escape draws nothing
PLAN_ITEM BUG-626 / B-107 (PR #1933) PART: the prompt order, the Manual and Unknown results, the F flip prompt and the Escape stop, switch ON. NOT whole: that the preview looks right and follows the cursor, a mouse click to place, RL, SSL and NGL still asking their earlier questions, locked layer and REFEDIT stops, Undo (all Codex look K23_01), the switch-off behaviour (the runner cannot set a Structural key)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 920
TIMEOUT 900
BUG BUG-626
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED FFL typed alone prints 'Level source [Manual/Unknown] <Manual>:' and not 'Pick level point:'; Esc ends it. FFL, Manual, 12.345, then the typed point 30000,20000 prints the value question and then 'Pick FFL point (right side) or [Flip]:' and places one mark (text 12.345). FFL, Unknown, point 30000,24000 asks no value question and places a mark reading Unknown. FFL, Manual, 5.5, F, point 30000,28000 shows 'Pick FFL point (left side) or [Flip]:' after the F and places a mark reading 5.5. FFL, Manual, 9.999 then Esc draws nothing. Altogether three '[FFL] Level mark created' lines, one of them naming Unknown, 3 new texts on 25TEXT, 6 new objects on 25DIMS, no text 9.999, and the file on disk unchanged.
WHY_NOT_UNIT_TEST The unit tests judge the source words and the drag rule on made-up inputs; only the live command shows the real question order, the real Flip prompt and that Escape in the real drag adds nothing.
NOT_AUTOMATED The preview picture following the cursor and flipping with F (Codex look K23_01), a mouse click to place, RL, SSL and NGL (unchanged by the PR, not typed here), the locked-layer and REFEDIT stops, Undo being one step.
NOT_AUTOMATED The Structural Settings switch is not shown in a window (no Settings row yet). The switch-off behaviour is not run (the runner cannot set a Structural key; see set 23 FOR TIM item 5).
STEPS
  settings-arm
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "FFL" -Force -TimeoutSec 120 -> $a_src
  esc-prompt -> $a_e
  wait
  type "FFL{NL}Manual{NL}12.345{NL}30000,20000" -Force -TimeoutSec 120 -> $m
  wait
  type "FFL{NL}Unknown{NL}30000,24000" -Force -TimeoutSec 120 -> $u
  wait
  type "FFL{NL}Manual{NL}5.5{NL}F{NL}30000,28000" -Force -TimeoutSec 120 -> $f
  wait
  type "FFL{NL}Manual{NL}9.999" -Force -TimeoutSec 120 -> $esc_t
  esc-prompt -> $esc_e
  wait
  ms-count -> $c1
  ms-new $c0 -> $new
  select $new "text~^12\.345$" -> $t_m
  select $new "text~^Unknown$" -> $t_u
  select $new "text~^5\.5$" -> $t_f
  select $new "text~^9\.999$" -> $t_esc
  select $new "layer=25TEXT" -> $txts
  select $new "layer=25DIMS" -> $dims
  field $t_m layer -> $t_m_layer
  field $t_m x -> $x_m
  field $t_f x -> $x_f
  windows-snapshot -> $win_end
ASSERT
  contains $a_src "Level source [Manual/Unknown] <Manual>:"
  not-contains $a_src "Pick level point:"
  contains $m "Level value (e.g. +150, RL42.350, -50):"
  contains $m "Pick FFL point (right side) or [Flip]:"
  matches $m "(?s)Level source.*Level value.*Pick FFL point"
  contains $u "Pick FFL point (right side) or [Flip]:"
  not-contains $u "Level value"
  contains $f "Pick FFL point (left side) or [Flip]:"
  history count "[FFL] Level mark created" = 3
  history has "[FFL] Level mark created (level source: Unknown)."
  history absent "Unknown command"
  count $t_m = 1
  count $t_u = 1
  count $t_f = 1
  count $t_esc = 0
  equals $t_m_layer "25TEXT"
  count $txts = 3
  count $dims = 6
  count $new = 9
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $a_src "FULL what FFL typed alone printed (the first question)"
  record $m "FULL FFL Manual 12.345"
  record $u "FULL FFL Unknown"
  record $f "FULL FFL Manual with F"
  record $esc_t "FULL FFL Manual 9.999 before the Esc"
  record $esc_e "what the closing Esc printed"
  record $x_m "x of the right-side value text (the tick point is 30000)"
  record $x_f "x of the left-side value text (the tick point is 30000)"
  record $new "the new objects (handle, layer, x, y)"
```

**Twin:** `W1933_BROKEN_ffl_claims_old_first_question.case.txt`

```
# W1933_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Claims the OLD behaviour: that FFL's first question is 'Pick level point:' and that it never mentions a level source. On a build with PR #1933 and the switch ON, FFL's first question is 'Level source [Manual/Unknown] <Manual>:', so this must FAIL. If it PASSES, the installed build does not have the fix (or the switch is off): say so. A switch-off twin is not possible (set 23 FOR TIM item 5).
CASE W1933_BROKEN
TITLE BROKEN VARIANT of W1933: expects the old first question 'Pick level point:' and no level source (must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1933 (PR #1933, BUG-626)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 921
TIMEOUT 600
BUG BUG-626
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1933
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the fix the first question is the level source, so 'contains $a_src "Pick level point:"' and 'not-contains $a_src "Level source"' fail; nothing is drawn so the object count check passes.
WHY_NOT_UNIT_TEST It exists only to prove W1933's first-question check can go red.
STEPS
  settings-arm
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "FFL" -Force -TimeoutSec 120 -> $a_src
  esc-prompt -> $a_e
  wait
  ms-count -> $c1
ASSERT
  equals $c1 $c0
  contains $a_src "Pick level point:"
  not-contains $a_src "Level source"
  record $a_src "FULL what FFL typed alone printed"
```

---

### Case 2 of 4: W1934, the FFL triangle, tail and value are one AutoCAD group (PR #1934, B-108, BUG-627)

**Intended file:** `W1934_ffl_three_parts_one_group.case.txt`

```
# W1934 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1934 (B-108, BUG-627), STACKED on #1933: its base is claude/z1-ffl-source-preview, not the Structural train, so this case needs a build that holds BOTH PRs (the FFL chain below is #1933's order). Switch Annotation.LevelMarkGroupsComponents, Default: on. Off gives three loose objects as before.
# Carpark BUG-627: MOVE on the FFL triangle left the tail and the value behind. Tim decision 163 ("3yes"): one normal AutoCAD group, behind a Settings switch ON.
# What the PR does (read from LevelMarkGrouping.cs, DERIVED): inside the transaction that draws the three parts, it makes ONE anonymous group (AutoCAD gives it a name like *A1) with the description 'CE level mark' and puts the triangle, tail and value text in it. Each FFL placement makes its own group. RL, SSL and NGL are not grouped.
# How the robot reads it with no LISP (DERIVED, NOT seen on a run): the AutoCAD command -GROUP, option ?, listing every group. The group's description 'CE level mark' is expected to appear in that list next to its *A name. If this AutoCAD prints only names and no descriptions, the judged checks below FAIL for a reading reason: then read the two recorded lists by eye (two new *A groups after, none before) and move the check to Codex K23_02.
# Whether the fixture already holds groups is not known: the before-list is read first and must not contain 'CE level mark'.
# Not driven: MOVE, COPY, ERASE and Undo on the group (the robot's typed point may not pick the group; K23_02 is the Codex look). Nothing is erased or moved here.
# Remembered values: YES (see W1933).
CASE W1934
TITLE After FFL places two marks, AutoCAD lists two groups described 'CE level mark' that did not exist before; each mark is still three objects
PLAN_ITEM BUG-627 / B-108 (PR #1934) PART: that FFL makes the group (one per placed mark), switch ON, listed with the AutoCAD group list. NOT whole: that MOVE, COPY and ERASE act on all three parts, Undo and Redo, reopening the drawing, RL, SSL and NGL staying loose, marks already in a drawing staying untouched (all Codex look K23_02), the switch-off behaviour (the runner cannot set a Structural key)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 922
TIMEOUT 900
BUG BUG-627
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Before any mark the group list holds no 'CE level mark'. FFL, Manual, 12.345, point 30000,20000 and FFL, Unknown, point 30000,24000 each print '[FFL] Level mark created'. Afterwards the group list shows 'CE level mark' (two groups, recorded), and the drawing holds exactly 6 new objects (2 marks of 3). The file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests judge when a group is made on made-up ids; only the live drawing shows that the real command made the groups inside the real transaction.
NOT_AUTOMATED MOVE, COPY, ERASE, Undo and Redo on the group, reopening, and the other level-mark types (Codex look K23_02).
NOT_AUTOMATED The switch-off behaviour (three loose objects) is not run (the runner cannot set a Structural key; see set 23 FOR TIM item 5).
STEPS
  settings-arm
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  type "-GROUP{NL}?{NL}*" -Force -TimeoutSec 60 -> $g0
  esc-prompt -> $g0e
  wait
  ms-count -> $c0
  type "FFL{NL}Manual{NL}12.345{NL}30000,20000" -Force -TimeoutSec 120 -> $m
  wait
  type "FFL{NL}Unknown{NL}30000,24000" -Force -TimeoutSec 120 -> $u
  wait
  ms-count -> $c1
  ms-new $c0 -> $new
  type "-GROUP{NL}?{NL}*" -Force -TimeoutSec 60 -> $g1
  esc-prompt -> $g1e
  wait
  windows-snapshot -> $win_end
ASSERT
  history count "[FFL] Level mark created" = 2
  history absent "Unknown command"
  not-contains $g0 "CE level mark"
  count $new = 6
  matches $g1 "CE level mark"
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $g0 "FULL the group list BEFORE any mark"
  record $g1 "FULL the group list AFTER two marks (expect two new groups)"
  record $g1e "what the Esc after the group list printed"
  record $new "the new objects (handle, layer, x, y)"
```

**Twin:** `W1934_BROKEN_ffl_claims_no_group.case.txt`

```
# W1934_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route; it claims the OLD behaviour: no 'CE level mark' group after the marks. With PR #1934 and the switch ON the group exists, so 'not-contains $g1 "CE level mark"' must FAIL. If it PASSES either the group is not listed with its description by -GROUP ? (a reading problem, send W1934 to Codex K23_02) or the build has no fix. A switch-off twin is not possible (set 23 FOR TIM item 5).
CASE W1934_BROKEN
TITLE BROKEN VARIANT of W1934: expects no group after FFL (the old behaviour; must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1934 (PR #1934, BUG-627)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 923
TIMEOUT 900
BUG BUG-627
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1934
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the group exists with the fix, so 'not-contains $g1 "CE level mark"' fails; the placement checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1934's group check can go red.
STEPS
  settings-arm
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "FFL{NL}Manual{NL}12.345{NL}30000,20000" -Force -TimeoutSec 120 -> $m
  wait
  type "FFL{NL}Unknown{NL}30000,24000" -Force -TimeoutSec 120 -> $u
  wait
  ms-new $c0 -> $new
  type "-GROUP{NL}?{NL}*" -Force -TimeoutSec 60 -> $g1
  esc-prompt -> $g1e
  wait
ASSERT
  history count "[FFL] Level mark created" = 2
  count $new = 6
  not-contains $g1 "CE level mark"
  record $g1 "FULL the group list after two marks"
```

---

### Case 3 of 4: W1981, SM asks number and sheet before the points, shows the preview and waits (PR #1981, B-146, BUG-630)

**Intended file:** `W1981_sm_number_sheet_first_preview_waits.case.txt`

```
# W1981 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1981 (B-146, BUG-630), base claude/rel-20261026s (DRAFT PR). Switch Annotation.SectionMarkPreviewThenPlace, Default: on. Off returns today's order and drawn bubble exactly.
# Carpark BUG-630 (15 Oct 2026): SM asked the points and direction before the identifier and sheet, showed no whole mark, and drew the moment the sheet was typed. Tim decisions 164, 170, 171: number and sheet first, whole mark shown, wait for Enter, bubbles from the SECT MARK block.
# Order with the switch ON (read from SectionMarkCommands.cs and SectionMarkFlow.Order in the PR diff, DERIVED): mode question 'Section mark [Pick/?] <Pick>: ' (Enter = Pick), then identifier 'Section identifier (e.g. A, 1, 01):' and sheet 'Sheet reference (leave blank if same sheet):' (identifier first when the setting 'Section mark offers the next number on the sheet' is OFF, its default; sheet first when it is ON, and then the identifier question offers a number), then 'Section mark start point: ', 'Section mark end point:', 'View direction [Left/Right/Up/Down] <Left>: ', then the preview line 'Preview: section T9, same sheet, view Left, cut line 4000 long with a bubble at each end.' and the question 'Press Enter to place the section mark, or change the view [Left/Right/Up/Down/Place] <Place>: '. The robot does not read the setting 'offers next number' (Tim's real settings file is not read), so the check accepts either order of identifier and sheet and only requires that both come BEFORE the start point.
# Escape at the preview question draws nothing and leaves the remembered direction alone (PR text, DERIVED). The picture of the preview is a Codex look (K23_03).
# Points 30000,20000 and 34000,20000: 4000 mm apart on empty ground. The direction is taken as the default (Enter), so the printed word after 'view' is read, not fixed.
# Remembered values: YES. SM saves the section direction into the Structural settings file; settings-arm restores every settings file by hash at the end.
CASE W1981
TITLE SM asks the section number and sheet first, then the two points and the view direction, then prints the preview line and waits for Enter; Escape at that point draws nothing
PLAN_ITEM BUG-630 / B-146 (PR #1981) PART: the question order, the preview line and the wait, switch ON, and the Escape stop. NOT whole: the picture of the whole mark (cut line, both bubbles, view side) on screen, changing the view with L R U D at the preview, the SECT MARK bubbles (case W1981b), a locked layer, Undo, scales and UCS, the switch-off behaviour (Codex look K23_03)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 924
TIMEOUT 900
BUG BUG-630
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED SM, Enter at the mode question, T9, a blank sheet, start 30000,20000, end 34000,20000, Enter at the direction: the command asks the identifier and the sheet before 'Section mark start point:', then the end point and the view direction, prints 'Preview: section T9, same sheet, view <direction>, cut line 4000 long with a bubble at each end.' and asks 'Press Enter to place the section mark'. Esc then ends it: no object is added and no line says 'Section mark T9 created'.
WHY_NOT_UNIT_TEST The unit tests pin the step order as a list; only the live command shows the real questions in AutoCAD, that the preview line is printed and that Escape at that point adds nothing to the real drawing.
NOT_AUTOMATED The picture of the preview on screen and changing the view at the preview question (Codex look K23_03). The SECT MARK bubbles (case W1981b). Locked layer, Undo, scales and UCS. The switch-off order (the runner cannot set a Structural key).
STEPS
  settings-arm
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "SM{NL}{NL}T9{NL}{NL}30000,20000{NL}34000,20000{NL}" -Force -TimeoutSec 120 -> $sm
  esc-prompt -> $sm_e
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  matches $sm "(?s)(Section identifier|Sheet reference).*(Sheet reference|Section identifier).*Section mark start point"
  contains $sm "Section mark end point:"
  contains $sm "View direction [Left/Right/Up/Down]"
  matches $sm "Preview: section T9, same sheet, view (Left|Right|Up|Down), cut line 4000 long with a bubble at each end\."
  contains $sm "Press Enter to place the section mark"
  history absent "Section mark T9 created"
  history absent "Unknown command"
  equals $c1 $c0
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $sm "FULL what SM printed up to the preview question"
  record $sm_e "what the Esc at the preview question printed"
```

**Twin:** `W1981_BROKEN_sm_claims_old_order.case.txt`

```
# W1981_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Claims the OLD order: that after the mode question SM asks 'Section mark start point:' first. With PR #1981 and the switch ON the next question is the identifier (or the sheet), so this must FAIL. If it PASSES, the build has no fix or the switch is off: say so. A switch-off twin is not possible (set 23 FOR TIM item 5).
CASE W1981_BROKEN
TITLE BROKEN VARIANT of W1981: expects the old order, the start point asked straight after the mode question (must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1981 (PR #1981, BUG-630)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 925
TIMEOUT 600
BUG BUG-630
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1981
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the fix the question after the mode is the identifier or the sheet, so 'contains $sm "Section mark start point:"' fails; nothing is drawn so the object count check passes.
WHY_NOT_UNIT_TEST It exists only to prove W1981's order check can go red.
STEPS
  settings-arm
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "SM{NL}" -Force -TimeoutSec 120 -> $sm
  esc-prompt -> $sm_e
  wait
  ms-count -> $c1
ASSERT
  equals $c1 $c0
  contains $sm "Section mark start point:"
  record $sm "FULL what SM printed straight after the mode question"
```

---

### Case 4 of 4: W1981b, SM places the SECT MARK bubbles on Enter (PR #1981, B-146, BUG-630)

**Intended file:** `W1981b_sm_enter_places_sect_mark_blocks.case.txt`

```
# W1981b DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1981 (B-146, BUG-630), switch ON (default). Same route as W1981 with one more Enter at the end, so the closing Enter answers the preview question and places the mark.
# What the PR draws (read from SectionMarkCommands.cs and SectionMarkBlockService.cs, DERIVED): a cut line from the start to the end point on 25DIMS (with the hidden section tag), and at each end the block SECT MARK from the office standard blocks file (a copy of that file is read and never written), inserted unrotated at DIMSCALE on 25DIMS with the fields SEC = the identifier and DWG = the sheet. Then '[SM] Section mark T9 created.'
# If the office block cannot be found, SM prints ONE line starting 'Warning: the office SECT MARK block was not used (' and draws its earlier bubble instead (PR text). In that case this case FAILS on the block count, and the Warning line (recorded) tells an environment problem (block file not on the robot PC) from a code fault. Read the Warning line first.
# The block's own view-side choices, layer and scale are not read by the PR (card 3.4): they are NOT judged here.
# Remembered values: YES (see W1981).
CASE W1981b
TITLE SM places the mark on Enter: the cut line and two SECT MARK blocks, each carrying the identifier T9, and prints 'Section mark T9 created'
PLAN_ITEM BUG-630 / B-146 (PR #1981) PART: the placed result, the SECT MARK block at both ends with the identifier written in. NOT whole: the look of the bubbles, the view side, the sheet field with a typed sheet, layer and scale of the block, the fall-back bubble, Undo, locked layer (Codex look K23_03). Needs the office standard blocks file with a SECT MARK block on this PC (not checked)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 926
TIMEOUT 900
BUG BUG-630
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED SM, Enter, T9, a blank sheet, 30000,20000, 34000,20000, Enter at the direction and Enter at the preview question prints '[SM] Section mark T9 created.' and no Warning about the SECT MARK block. The drawing gains exactly 2 SECT MARK blocks (one at each end, within 5 mm of the end points), and one of them reads T9 when read back. The file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests judge the field values and the block lookup on made-up data; only the live command shows that the office block is found, copied in and inserted at both ends of the real cut line.
NOT_AUTOMATED How the bubbles look, which side the view arrow points, a typed sheet reference, the layer and scale of the block (Codex look K23_03).
STEPS
  settings-arm
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "SM{NL}{NL}T9{NL}{NL}30000,20000{NL}34000,20000{NL}{NL}" -Force -TimeoutSec 120 -> $sm
  wait
  esc-prompt -> $sm_e
  wait
  ms-new $c0 -> $new
  select $new "name~^SECT MARK$" -> $blocks
  select $blocks "near=30000,20000,5" -> $b1
  select $blocks "near=34000,20000,5" -> $b2
  field $b1 handle -> $h1
  ent-read {$h1} -> $e1
  windows-snapshot -> $win_end
ASSERT
  history has "[SM] Section mark T9 created."
  history absent "the office SECT MARK block was not used"
  history absent "Unknown command"
  count $blocks = 2
  count $b1 = 1
  count $b2 = 1
  matches $e1 "T9"
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $sm "FULL what SM printed, including any Warning about the block"
  record $new "the new objects (handle, layer, x, y)"
  record $e1 "FULL the first bubble as read back (fields)"
```

**Twin:** `W1981b_BROKEN_sm_claims_drawn_bubbles.case.txt`

```
# W1981b_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Claims the OLD result: that SM draws its own bubbles and inserts no SECT MARK block at all. With PR #1981 and the office block found, two blocks are inserted, so 'count $blocks = 0' must FAIL. If it PASSES, either the block was not found on this PC (the Warning line says so) or the build has no fix.
CASE W1981b_BROKEN
TITLE BROKEN VARIANT of W1981b: expects no SECT MARK block (the old drawn bubble; must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1981b (PR #1981, BUG-630)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 927
TIMEOUT 900
BUG BUG-630
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1981b
REVIEWED_AGAINST
EXPECTED Wrong on purpose: two SECT MARK blocks are placed with the fix, so 'count $blocks = 0' fails; the 'created' line check passes.
WHY_NOT_UNIT_TEST It exists only to prove W1981b's block count can go red.
STEPS
  settings-arm
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,30000" -Force
  wait
  ms-count -> $c0
  type "SM{NL}{NL}T9{NL}{NL}30000,20000{NL}34000,20000{NL}{NL}" -Force -TimeoutSec 120 -> $sm
  wait
  esc-prompt -> $sm_e
  wait
  ms-new $c0 -> $new
  select $new "name~^SECT MARK$" -> $blocks
ASSERT
  history has "[SM] Section mark T9 created."
  count $blocks = 0
  record $sm "FULL what SM printed, including any Warning about the block"
```

---

## 3. Fix not drafted as a robot case: BLOCKED-FOR-ROBOT

### #1915 (B-092, BUG-1203): unticked Background refresh stops the start-up schedule-history scan

**BLOCKED-FOR-ROBOT.** The robot would have to start AutoCAD with the tick box already OFF. The robot's settings line cannot do that for Structural (it writes the bare `CS_Settings.json` to the `TIM_CE_CADTOOLS` folder, but Structural reads `CE_STRUC_SUITE\CS_Settings.json` first), and the Settings window's Save button is refused. The PR also adds no log line, so there is nothing for the robot to read; the evidence is a saved time stamp in Tim's settings file, which these drafts may not read. A case would only come back BLOCKED or, worse, look like it ran. See Codex look K23_04.

---

## 4. Codex look notes (the robot cannot see these)

Evidence goes under `C:\CE_WORK\codex\set23_<look id>\`. Use copies of drawings only. Never accept or capture a folder that a Save box opened in. Any settings file Codex changes is backed up by hash first and put back by hash after.

**K23_01: FFL preview (PR #1933, BUG-626).** Needs the train build with #1933 installed, AutoCAD closed during the install.
1. Open a copy of a Structural drawing in millimetres. Type FFL and press Enter.
2. **Right looks like:** the first question is "Level source [Manual/Unknown] <Manual>:". Press Enter, type 12.345, press Enter.
3. **Right looks like:** a whole level mark (triangle, tail and 12.345) follows the cursor before anything is drawn; the question says "Pick FFL point (right side) or [Flip]:". Take a picture with the cursor in open space.
4. Type F, press Enter. **Right looks like:** the mark turns to the other side and the question says "(left side)". Click to place. One mark is drawn where the picture showed.
5. Type FFL, Unknown, click. **Right looks like:** no value question; the mark reads the word Unknown (not 0, not blank).
6. Type FFL, Manual, 9.999, then press Escape. **Right looks like:** nothing is drawn.
7. Lock layer 25DIMS (copy only) and type FFL. **Right looks like:** one plain line saying the layer is locked and no question is asked. Unlock it again; do not leave it locked.
8. Type RL, SSL and NGL once each. **Right looks like:** they ask their earlier questions, unchanged.
9. Save the pictures as `01_source.png` to `09_rl_ssl_ngl.png` in the evidence folder; write one line per step: seen or not seen.

**K23_02: FFL group, MOVE, COPY, ERASE and Undo (PR #1934, BUG-627).** Needs #1933 and #1934 both installed. Opus review first (Undo).
1. Place an FFL mark (Manual 12.345). Type MOVE, click ONLY the triangle, press Enter, pick a base point and move it 1000 mm right. **Right looks like:** the triangle, the tail and the value all move together.
2. Type U once. **Right looks like:** all three return together. Take a picture before the move, after, and after the U.
3. Repeat step 1 by clicking only the tail, then only the value text.
4. Type COPY on the value text. **Right looks like:** a whole second mark appears (three parts) and it is a separate group: MOVE on it does not move the first mark.
5. Type ERASE on the tail only. **Right looks like:** all three parts go. Type U: all three come back.
6. Save the copy under a new name in the evidence folder (not Tim's folder), close it, reopen it, and repeat step 1. **Right looks like:** still one unit after reopening.
7. Place an RL, an SSL and an NGL mark. MOVE the triangle of each. **Right looks like:** unchanged from before (these are not grouped).
8. One line per step: seen or not seen, with the picture name.

**K23_03: SM preview and SECT MARK bubbles (PR #1981, BUG-630).** Needs the train build with #1981 installed and the office standard blocks file on this PC. Opus review first (the locked-layer stop and Undo are in it).
1. In a copy in millimetres with DIMSCALE 100, type SM and Enter, then T9, a blank sheet, pick a start and an end point 4000 mm apart, press Enter at the direction.
2. **Right looks like:** the whole mark is on screen before anything is drawn: the cut line, a bubble at each end with T9, and a tick on the view side. Take a picture. The Command line shows the "Preview: section T9, same sheet, view ..." line and waits.
3. Type R, then U, then D, then L (each followed by Enter). **Right looks like:** the picture changes to that view each time and the preview stays up.
4. Press Enter to place. **Right looks like:** the cut line and two SECT MARK blocks appear, each showing T9, looking like the office standard bubble. Take a picture.
5. Type U once. **Right looks like:** the whole section mark goes in one step.
6. Repeat with a typed sheet reference S02. **Right looks like:** the DWG field of both bubbles reads S02.
7. Press Escape at the preview. **Right looks like:** nothing is drawn.
8. Lock layer 25DIMS (copy only), run SM through to Enter. **Right looks like:** one plain line "Layer 25DIMS is locked, so no section mark was drawn. Unlock it and run SM again." and nothing drawn. Unlock it again.
9. Rename the office blocks file away on the Codex copy of the profile only (never Tim's), run SM. **Right looks like:** one Warning line saying the SECT MARK block was not used and the earlier drawn bubble appears. Put the file back.
10. Pictures `01_preview.png` to `09_missing_block.png`; one line per step.

**K23_04: unticked Background refresh stops the start-up scan (PR #1915, BUG-1203).** Needs the train build with #1915 installed.
1. Back up `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` and write down its SHA-256. Close AutoCAD.
2. Make the cache stale: note the value of "LastCorpusRefreshUtc" in that file (the XclmTxt section). If it is missing or older than 12 hours that is the condition the carpark entry names; if not, clear it in the copy only.
3. Start AutoCAD, type CESETTINGS, open the XclmTxt (schedule history) page, untick "Background refresh enabled", close with the window's own OK (never touch another setting). Close AutoCAD.
4. Start AutoCAD again. Do NOT type XCLMTXT. Wait two minutes.
5. **Right looks like:** the file still shows an empty or unchanged "LastCorpusRefreshUtc", and Task Manager shows no long disk read by acad.exe in the schedule-history folders (a picture of the Resource Monitor disk list is enough).
6. Now type XCLMTXT and press its own Refresh button. **Right looks like:** it still refreshes when you ask, and the time stamp is written.
7. Close AutoCAD, tick the box again, restart, wait two minutes without typing XCLMTXT. **Right looks like:** with the box ticked the scan runs at start-up as before.
8. Put the settings file back and check its SHA-256 equals step 1.
9. Evidence: the two settings-file excerpts (time stamp lines only), the Resource Monitor pictures, one line per step.

---

## 5. Fixes skipped and why

1. **None skipped.** All four are covered: three as robot cases (parts only) and #1915 as a Codex look.

## 6. What I read, built, tested and did NOT prove

1. **Read:** the files listed in section 1, the four PR texts and diffs, the carpark entries, and the Structural SM code on the train line. No settings file of Tim's was opened.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Tim-accepted:** nothing.
3. **NOT proven:** that any of the four cases validates or runs; that the Structural module is loaded in the robot AutoCAD; that the installed Structural has these fixes (they are open PRs; on 1.0.125 every main case would fail and every twin pass); that the typed point answers the FFL placement question and that `F` is taken as Flip in a typed chain; that `-GROUP` with `?` lists the description; that the office SECT MARK block exists on this PC; that layers 25DIMS and 25TEXT are unlocked in `DRV2_S1`; every prompt and printed line (all DERIVED from the PR diffs); the preview picture, MOVE, COPY, ERASE and Undo on the group, and the start-up scan (Codex looks only).
4. **Housekeeping:** the four PR diffs were saved to a scratch folder `C:\CE_WORK\scratch\s23` for reading, and that one folder was deleted at the end.
