# Robot case drafts, set 08: labels, text angle, metre drawings and double-click (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts for six fix PRs heading for `origin/claude/rel-20261102a`. Nothing was run, built, installed or opened in AutoCAD. No case file was created in the cases folder; the only file written is this one. No git write.

---

## FOR TIM

1. **Drafted:** 3 robot cases, each with a broken twin (6 case texts): W1888 (pipe label angle with a turned UCS), W1923 (double-click on a pit label) and W1946 (label sizes in a metre drawing).
2. **Codex only (no robot case):** #1924 (catchment label), #1944 (rebuilt pit record, metre drawing) and #1974 (CDSL and trench grate audit wording). Steps are in section 4.
3. **Example:** W1888 draws a pipe that bends, turns the UCS 45 degrees, runs CDTEXTSEG on the 45 degree leg and checks the label reads 45 degrees. The twin turns the fix off and must read 0.
4. **Needs an Opus review before it runs:** W1923 (double-click) because it hooks AutoCAD's own attribute editor start, and the case moves the real mouse; it runs alone, outside your hours. None of the three touches Undo, REDO, a locked layer or an Xref.
5. **Could not verify:** every window word, printed line and the label rotation reading is marked DERIVED (taken from the PR text, not seen on a run). W1946 needs a real metre drawing; the only fixture is a millimetre drawing switched to metres by the robot (the R24 artefact), so a fail there may not be a CE fault.
6. **Not proven by any of this:** nothing is accepted. These are drafts; no robot run, no review file.
7. **Nothing for you to test or decide.**

---

## 1. How the drafts were written (read before validating)

1. **What I read:** `C:\TimOS\RULES.md`; `cases\README_CASES.md`; the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the cases R09s, `variants\R09s_new_switch_off_broken`, R09, R17, R18, R24, N05 and the setup SETUP-P8; the six PRs with `gh pr view` and `gh pr diff` (code and REGRESSION_LOG text; the unit tests were not read in full); the carpark entries BUG-1195, BUG-642, BUG-321, BUG-296, BUG-430, BUG-1175; the review file of R09s.
2. **No case or draft exists for these six.** I searched `cases\` (including `variants\`, `previous\` and every `drafts_*` folder), `ROBOT_CASE_DRAFTS_*.md` and `ledger.json` for the PR numbers, the BUG numbers and `W1888`-style ids. The only hits were in `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (a line that lists #1888 and #1944 and #1946 as NOT yet drafted) and the carpark. No BUGFIX report in `areas\` names these PRs (the search was by name list, not by opening every file).
3. **Format:** header lines, STEPS, ASSERT. Every `type` chain is a complete command with no `(` and no SAVE-type word. Every twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`. REVIEWED_AGAINST is left empty. No review file is written.
4. **Order numbers** 770 to 775; SLOT fresh; fixture DRV1_B1 except W1946 (DRV15_METRE, as R24).
5. **Settings:** only `SETTING CD_Settings.json <key> <value>` (README batch 1 item 2). Tim's real settings files were not read or written. Settings are read when AutoCAD starts, so each twin sets its switch before launch. The case never uses `hashes-unchanged` (README says not to when a SETTING is set).
6. **Validate first, without AutoCAD:** copy each block to its file name in a new folder (suggested `cases\drafts_set08_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
7. **Protection:** no case unlocks a layer, detaches an Xref or goes round any AutoCAD protection. Every case ends with the drawing copy unsaved (CE never saves).

---

## 2. Whole or part, per fix

1. **W1888:** PART. The pipe label angle after CDTEXTSEG with the UCS turned 45 degrees. NOT the Edit Pipe "pick a point to move text" route (same code, not driven) and NOT the flow arrow (the PR says the arrow has the same fault and is not fixed).
2. **W1923:** PART. A double-click on the pit label of a freshly placed pit, with both switches ON. NOT a locked label layer, an Xref pit, REFEDIT, or a pit label with a frame round it.
3. **W1946:** PART. Pipe label position in a metre drawing only. NOT the label text height (the robot has no height reading; recorded only), NOT the flow arrow offset, NOT the pit hover radius (hover is a Codex look).

---

## 3. The case texts

### Case 1: W1888, CDTEXTSEG with a turned UCS (B-072, BUG-1195)

**Switch:** `linking.pipeTextMoveAngleFollowsUcs`, default ON (read from `UserSettings.cs` in PR #1888 and its REGRESSION_LOG entry).

**Intended file:** `W1888_textseg_turned_ucs_label_angle.case.txt`

```
# W1888 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1888, B-072, BUG-1195 (CDTEXTSEG writes a UCS angle into a World-plane text).
# Bug card test: UCS Z 45, CDTEXTSEG a diagonal pipe, midpoint pick 7071.067811865,0; the label's World rotation must be 45 degrees modulo 180.
# Route: a three-point pipe (CDTEXTSEG says 'Pipe only has one segment' for a two-point pipe, CdCommand.Arrows.cs): 150000,-85000 to 160000,-75000 (45 degrees in World, 14142 mm) to 180000,-75000 (horizontal, 20000 mm). The view is zoomed in World BEFORE the UCS is changed. Then the UCS origin goes to the first vertex and the UCS is turned 45 degrees about Z, so the diagonal leg is the UCS X axis: its midpoint is exactly 7071.067811865,0 in the UCS, the pick the bug card names.
# CDTEXTSEG prompts read from the PR branch source (CdCommand.Arrows.cs, PipeTextPlacementService.cs): 'Select pipe to move text between segments:' then 'Pipe text auto-placed on the clearest segment. Pipe has 2 segment(s).' then 'Pick a point to move pipe text to that segment, or press Enter to accept:' then 'Pipe text moved.' DERIVED: all four lines (not seen on a run).
# DERIVED: that CD accepts three typed World points and a free start (N48 and R17 do the two-point free-start form); that after Start Pipe on a multi-segment pipe CD asks one question that three esc-prompt lines end (README batch 3 item 4); the UCS command chain; that ent-read shows the label's rotation as "rotation":<radians> as it does for the flow arrow in R32 (the pattern rotation.:0\.785 is a guess at the digits); that the typed UCS point at the Select prompt picks the pipe.
# The label may already be on the diagonal leg after CD (CD puts it on the clearest segment). The twin is what proves the check can go red: with the switch OFF the move writes the UCS angle 0, so the label is horizontal.
# Remembered values: YES (CD typed; CD_RecentValues changes). Nothing is erased; nothing is saved.
CASE W1888
TITLE CDTEXTSEG with the UCS turned 45 degrees: the pipe label moved onto the 45 degree leg reads 45 degrees in the drawing, not flat
PLAN_ITEM BUG-1195 (PR #1888, B-072) PART: CDTEXTSEG route, one diagonal leg, UCS turned 45 degrees about Z with its origin on the first pipe point. NOT whole: the Edit Pipe 'pick a point to move text' route (same code, not driven), a UCS turned about X or Y, and the flow arrow (the PR says it has the same fault and is not fixed here)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP
ORDER 770
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED A three-point pipe (150000,-85000 / 160000,-75000 / 180000,-75000) is drawn with one label. With the UCS origin on 150000,-85000 and the UCS turned 45 degrees, CDTEXTSEG with the pipe picked and the diagonal leg's midpoint picked prints 'Pipe text moved.'; the label then lies within 3000 mm of the diagonal leg's middle (155000,-80000) and its rotation reads about 0.785 radians (45 degrees), not 0.
WHY_NOT_UNIT_TEST The unit tests prove the angle sum; only a real AutoCAD with a real turned UCS shows the label object the command writes.
NOT_AUTOMATED How the label looks (parallel to the pipe, readable): a Codex look. The label rotation reading is DERIVED (the ent-read field name and digits have not been seen for text).
NOT_AUTOMATED The Edit Pipe 'pick a point to move text' route, the flow arrow, and UCS turned about X or Y.
STEPS
  type "_.ZOOM{NL}_W{NL}146000,-90000{NL}184000,-70000" -Force
  wait
  ms-count -> $n0
  type "CD{NL}150000,-85000{NL}160000,-75000{NL}180000,-75000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $cd_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd_e1
  esc-prompt -> $cd_e2
  esc-prompt -> $cd_e3
  wait
  ms-new $n0 -> $new_all
  select $new_all "object~^CeCvlPipeObject$" -> $pipes
  select $new_all "text~ DIA\. " -> $label0
  field $label0 handle -> $lh
  ent-read {$lh} -> $le0
  type "_.UCS{NL}150000,-85000{NL}" -Force -> $ucs1
  wait
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs2
  wait
  getvar UCSORG -> $ucsorg
  type "CDTEXTSEG{NL}7071.067811865,0{NL}7071.067811865,0" -Force -TimeoutSec 90 -> $seg
  wait
  esc-prompt -> $seg_e
  ent-read {$lh} -> $le1
  select $new_all "text~ DIA\. " "near=155000,-80000,3000" -> $label_near
  type "_.UCS{NL}_W" -Force
  wait
ASSERT
  count $pipes = 1
  contains $seg "Pipe has 2 segment(s)."
  contains $seg "Pipe text moved."
  history absent "Pipe only has one segment"
  count $label_near = 1
  matches $le1 "rotation.:0\.785"
  record $le0 "the label as CD placed it (before the move)"
  record $le1 "the label after CDTEXTSEG (rotation read here)"
  record $ucsorg "UCSORG after the turn"
  record $seg "FULL what CDTEXTSEG printed"
```

**Twin:** `W1888_BROKEN_textseg_switch_off.case.txt`

```
# W1888_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same checks; the PR's own switch linking.pipeTextMoveAngleFollowsUcs is set OFF before AutoCAD starts. OFF returns the old angle exactly (PR REGRESSION_LOG item 4), so the label stays at the UCS angle 0 and the rotation check must FAIL. The route checks (pipe drawn, 'Pipe text moved.', label near the diagonal leg) still pass, which proves the command reached the move.
CASE W1888_BROKEN
TITLE BROKEN VARIANT of W1888: the new switch is OFF, so the label is left flat (rotation 0) with the UCS turned 45 degrees (must FAIL on the rotation check)
PLAN_ITEM red-before-green proof for W1888 (BUG-1195)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP
SETTING CD_Settings.json linking.pipeTextMoveAngleFollowsUcs false
ORDER 771
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1888
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the label is written at the UCS angle, so 'matches $le1 "rotation.:0\.785"' fails; 'Pipe text moved.' and the near-label check pass.
WHY_NOT_UNIT_TEST It exists only to prove W1888's rotation check can go red.
STEPS
  type "_.ZOOM{NL}_W{NL}146000,-90000{NL}184000,-70000" -Force
  wait
  ms-count -> $n0
  type "CD{NL}150000,-85000{NL}160000,-75000{NL}180000,-75000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $cd_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd_e1
  esc-prompt -> $cd_e2
  esc-prompt -> $cd_e3
  wait
  ms-new $n0 -> $new_all
  select $new_all "object~^CeCvlPipeObject$" -> $pipes
  select $new_all "text~ DIA\. " -> $label0
  field $label0 handle -> $lh
  ent-read {$lh} -> $le0
  type "_.UCS{NL}150000,-85000{NL}" -Force -> $ucs1
  wait
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs2
  wait
  type "CDTEXTSEG{NL}7071.067811865,0{NL}7071.067811865,0" -Force -TimeoutSec 90 -> $seg
  wait
  esc-prompt -> $seg_e
  ent-read {$lh} -> $le1
  select $new_all "text~ DIA\. " "near=155000,-80000,3000" -> $label_near
  type "_.UCS{NL}_W" -Force
  wait
ASSERT
  count $pipes = 1
  contains $seg "Pipe text moved."
  count $label_near = 1
  matches $le1 "rotation.:0\.785"
  record $le0 "the label as CD placed it"
  record $le1 "the label after CDTEXTSEG with the switch OFF"
```

---

### Case 2: W1923, double-click on a pit label (B-110, BUG-430)

**Switch:** `doubleClick.pitLabelStopsAttributeEditorFirst`, default OFF, so the case turns it ON before launch. It only works while `doubleClick.opensEditWindow` is also ON (PR #1923 `DoubleClickSettings.cs` comment), so the case sets both.

**Modelled on:** R09s and `variants\R09s_new_switch_off_broken` (accepted route, README `PROVES` of the DP double-click).

**Intended file:** `W1923_pit_label_double_click_stops_editor.case.txt`

```
# W1923 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1923, B-110, BUG-430 (double-click on a pit label opens AutoCAD's Enhanced Attribute Editor, not Edit Pit; switch doubleClick.pitLabelStopsAttributeEditorFirst, OFF by default).
# Modelled on R09s (accepted for the DP double-click: aim check, Edit source window, no Enhanced Attribute Editor). Same two pointer rules: this case moves the real mouse, so it runs FIRST and ALONE in its own AutoCAD start, only outside Tim's hours and only while nobody is using the PC.
# Route: PIT placed by the N05 route (label point clicked at 150000,-78500, then the cover text point, then Esc) so the pit has a linked PIT LABEL block (the label names its pit AND the pit lists it, the proof the fix needs, PR text). The view is zoomed in first, then v3 view-read and v3 deselect as in R09s, then a double-click on the label block.
# Log line read from the PR (Rules/DoubleClickAttributeEditorStopRule.PitLabelStoppedLogLine): "TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-430, doubleClick.pitLabelStopsAttributeEditorFirst); pit label". DERIVED (not seen on a run). Written to the structured log, runner key civilx (as R09s).
# DERIVED: the Edit Pit window title (the case matches the regex 'Edit [Pp]it' so 'Creative Engineering | Edit pit' also matches); that the Edit Pit window is readable and closable through the v3 'Creative Engineering*' read list with the title-bar 'Close' (R09s used that for Edit source: R09s review says pass); that the double-click target "ent {label handle}" with no -Part aims at the label's text (if the aim check misses the label the runner reports BLOCKED, never a result: then add a -Part for the label text as R09s does for the DP circle).
# Never presses Save, Accept or Delete. Close only. The pit stays in the unsaved copy.
# Remembered values: YES (PIT remembers its last values; CD_RecentValues changes).
CASE W1923
TITLE Double-click on the label of a new pit (both double-click switches ON): AutoCAD's attribute editor is stopped first and CE's Edit Pit window opens
PLAN_ITEM BUG-430 (PR #1923, B-110) PART: one linked pit label, nothing else near it, both switches ON. NOT whole: a label on a locked layer, an Xref pit, REFEDIT, a label inside a border or Xref plan (the PR's 'frame round it' case), and the 'switch OFF: nothing changes' side except in the twin
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json doubleClick.opensEditWindow true
SETTING CD_Settings.json doubleClick.pitLabelStopsAttributeEditorFirst true
SETUP
ORDER 772
TIMEOUT 600
BUG BUG-430
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After a pit is placed with its label (PIT LABEL reading P8), a double-click on the label opens CE's Edit Pit window and AutoCAD's Enhanced Attribute Editor does not open at all, even 10 seconds later; CE's structured log says 'EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-430, doubleClick.pitLabelStopsAttributeEditorFirst); pit label'.
WHY_NOT_UNIT_TEST Unit tests pin the rule; only a real mouse double-click on a real PIT LABEL block in AutoCAD shows which window opens (BUG-430 has failed three times in real AutoCAD with unit tests green).
NOT_AUTOMATED What the Edit Pit window shows (P8, cover level 19.000): a Codex look. Pressing Save in Edit Pit is refused by the press list and never done.
NOT_AUTOMATED A locked pit-label layer, an Xref pit, REFEDIT and a frame round the label are not driven (the PR keeps AutoCAD's own answer for the first three).
NOT_AUTOMATED DERIVED, not yet seen on a run: the Edit Pit window title, the aim at the label block, the log line wording. If only those fail while the double-click is caught (CE log line 'double-click hit-test') the fix may be fine and the case text needs one correction.
STEPS
  v3 setvar PICKFIRST 1
  v3 setvar DBLCLKEDIT 1
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  v3 view-read
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  v3 pt-click "150000,-78500" -Blind -> $click_label
  sleep 3
  v3 pt-click "151500,-81500" -Blind -> $click_cover
  sleep 3
  v3 esc-key
  sleep 3
  wait
  ms-new $n0 -> $new
  select $new "name~^PIT LABEL" -> $labels
  field $labels handle -> $lh
  ent-read {$lh} -> $le
  v3 view-read
  v3 deselect
  windows-snapshot -> $w0
  v3 pt-dblclick "ent {$lh}" -> $dc
  sleep 3
  ui-dump "Edit [Pp]it" -Optional -TimeoutSec 10 -> $ep
  windows-new $w0 -> $opened
  ui-press "Edit [Pp]it" "Close" -Optional -> $epc
  close-windows
  sleep 10
  windows-snapshot -> $w_after
  close-windows
ASSERT
  count $labels = 1
  matches $le "text.:.P8.,.insertion"
  log civilx has "EATTEDIT stopped before AutoCAD"
  log civilx has "doubleClick.pitLabelStopsAttributeEditorFirst"
  matches $opened "(?i)edit pit"
  not-contains $opened "Enhanced Attribute Editor"
  not-contains $w_after "Enhanced Attribute Editor"
  record $opened "the window(s) the double-click opened"
  record $w_after "windows open 10 s later (AutoCAD's editor must never appear, even late)"
  record $ep "the Edit Pit dump (window title and controls)"
  record $dc "the double-click result (the aim check line)"
```

**Twin:** `W1923_BROKEN_pit_label_switch_off.case.txt`

```
# W1923_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin, in the style of cases\variants\R09s_new_switch_off_broken: same route and checks, doubleClick.pitLabelStopsAttributeEditorFirst set false before AutoCAD starts (opensEditWindow stays true). The older path decides as on Civil 3.0.88: AutoCAD's Enhanced Attribute Editor opens (Codex looks L4-01a, BUG-430 carpark), so the checks 'stopped' log, 'Edit pit window' and 'no Enhanced Attribute Editor' must FAIL. Pointer case: runs ALONE in its own AutoCAD start. close-windows closes AutoCAD's editor through its listed Cancel.
CASE W1923_BROKEN
TITLE BROKEN VARIANT of W1923: the pit-label switch is OFF, so AutoCAD's attribute editor opens first as on 3.0.88 (must FAIL)
PLAN_ITEM red-before-green proof for W1923 (BUG-430, the new switch)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json doubleClick.opensEditWindow true
SETTING CD_Settings.json doubleClick.pitLabelStopsAttributeEditorFirst false
SETUP
ORDER 773
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1923
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF AutoCAD's Enhanced Attribute Editor opens, so 'log civilx has "EATTEDIT stopped before AutoCAD"', the Edit Pit window check and 'not-contains $opened "Enhanced Attribute Editor"' fail; the pit-placed and label-read checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1923's window checks can go red.
STEPS
  v3 setvar PICKFIRST 1
  v3 setvar DBLCLKEDIT 1
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  v3 view-read
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  v3 pt-click "150000,-78500" -Blind -> $click_label
  sleep 3
  v3 pt-click "151500,-81500" -Blind -> $click_cover
  sleep 3
  v3 esc-key
  sleep 3
  wait
  ms-new $n0 -> $new
  select $new "name~^PIT LABEL" -> $labels
  field $labels handle -> $lh
  ent-read {$lh} -> $le
  v3 view-read
  v3 deselect
  windows-snapshot -> $w0
  v3 pt-dblclick "ent {$lh}" -> $dc
  sleep 3
  ui-dump "Edit [Pp]it" -Optional -TimeoutSec 10 -> $ep
  windows-new $w0 -> $opened
  ui-press "Edit [Pp]it" "Close" -Optional -> $epc
  close-windows
  sleep 10
  windows-snapshot -> $w_after
  close-windows
  log-read civilx -> $cx
ASSERT
  count $labels = 1
  matches $le "text.:.P8.,.insertion"
  log civilx has "EATTEDIT stopped before AutoCAD"
  matches $opened "(?i)edit pit"
  not-contains $opened "Enhanced Attribute Editor"
  not-contains $w_after "Enhanced Attribute Editor"
  record $opened "the window(s) the double-click opened"
  record $cx "FULL the new structured CE log lines (look for 'left to start' or 'not stopped')"
```

---

### Case 3: W1946, label offset in a metre drawing (B-126, BUG-321)

**Switch:** `options.labelSizesReadDrawingUnits`, default ON (PR #1946 `UserSettings.cs`).

**Fixture:** DRV15_METRE, as R24. It is a millimetre drawing; the robot switches INSUNITS to 6 after AutoCAD starts (R24's own note: a FAIL may be that artefact, a real metre drawing does not exist on this PC). No pit is placed, so R24's "pit 1900 units wide swallows the pipe" problem cannot hit this case.

**Intended file:** `W1946_metre_drawing_pipe_label_offset.case.txt`

```
# W1946 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1946, B-126 batch 12, BUG-321 (label text heights, offsets, arrow offset and pit hover radius read the drawing's units).
# Fixture and the INSUNITS 6 step are R24's (R24: DRV15_METRE is a millimetre drawing, INSUNITS switched with the driver's own setvar, never saved). A pit is NOT placed (R24's pit came out 1900 units wide on 3.0.73 and CD then refused the pipe); the pipe has free ends, as the N48 and R17 CD routes do.
# What the bug did, from the carpark and the PR: CE's label offset (about 125 mm plus the pipe radius) was used as plain drawing units, so in a metre drawing the label sat about 237 m from a 20 m pipe. With the fix the offset is about 0.24 (metres). So the check is the same as R18's 'insertion point within 2000 mm of the pipe middle', written in metres: within 2 units.
# DERIVED: that CE reads the live INSUNITS (the PR's LabelUnitsRule calls LinkService.ActiveDrawingInsunits); that CD works with free ends in a metre drawing; the label regex (R18's, without the size and grade numbers fixed). The label's text height is NOT judged: the runner has no height reading (ent-read output is recorded for the reviewer).
# Remembered values: YES (CD typed).
CASE W1946
TITLE With INSUNITS 6 (metre drawing) a new 20 m pipe's label sits within 2 units of the pipe middle, not hundreds of units away
PLAN_ITEM BUG-321 (PR #1946, B-126) PART: the pipe label offset in a switched-to-metres drawing (INSUNITS 6 set by the robot on a millimetre master). NOT whole: the label text height (recorded, not judged), the flow arrow offset, the pit and cover labels, the pit hover radius (Codex look), and a real metre drawing
KIND deterministic
FIXTURE DRV15_METRE
SLOT fresh
SETUP
ORDER 774
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED With INSUNITS 6, CD from 150,-80 to 170,-80 (20 m) with inverts 18.000 and 17.900 draws one pipe and one label reading '<size> DIA. <material> PIPE AT 1 IN <n>'; the label's insertion point is within 2 units of the pipe middle 160,-80 and above the pipe line (y greater than -80).
WHY_NOT_UNIT_TEST The label position comes from the live text writer reading the live drawing units.
NOT_AUTOMATED A DRAWING AUTHORED IN METRES DOES NOT EXIST HERE (see R24): INSUNITS is switched after CE has loaded, so a FAIL may be that artefact and not a CE fault; a PASS proves the live INSUNITS reading only.
NOT_AUTOMATED The label text height (0.25 in a metre drawing) is recorded from ent-read, not judged. The flow arrow offset, the pit hover radius and the invert text distance are not driven.
STEPS
  v3 setvar INSUNITS 6
  getvar INSUNITS -> $iu
  ms-count -> $n0
  type "CD{NL}150,-80{NL}170,-80{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $cd_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd_e1
  wait
  ms-new $n0 -> $new_all
  select $new_all "object~^CeCvlPipeObject$" -> $pipes
  select $new_all "text~ DIA\. " -> $label
  field $label text -> $label_text
  field $label y -> $label_y
  field $label handle -> $lh
  ent-read {$lh} -> $le
  dist $label "160,-80" -> $label_dist
ASSERT
  equals $iu "6"
  count $pipes = 1
  count $label = 1
  matches $label_text "^\d+ DIA\. \S+ PIPE AT 1 IN \d+$"
  number $label_dist <= 2
  number $label_y > -80
  record $label_dist "distance of the label's insertion point from the pipe middle (drawing units)"
  record $le "FULL the label as read (look for the text height)"
  record $label "the label object (handle, layer, x, y)"
```

**Twin:** `W1946_BROKEN_metre_label_switch_off.case.txt`

```
# W1946_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and checks; the PR's switch options.labelSizesReadDrawingUnits is set OFF before AutoCAD starts. OFF = the old behaviour exactly (millimetre figures used as metre units), so the label is hundreds of units from the pipe and the distance check must FAIL. The pipe-drawn and label-wording checks still pass.
CASE W1946_BROKEN
TITLE BROKEN VARIANT of W1946: the new units switch is OFF, so the label sits hundreds of units away in a metre drawing (must FAIL on the distance check)
PLAN_ITEM red-before-green proof for W1946 (BUG-321)
KIND deterministic
FIXTURE DRV15_METRE
SLOT fresh
SETTING CD_Settings.json options.labelSizesReadDrawingUnits false
SETUP
ORDER 775
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1946
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the label is placed about 237 units from the pipe, so 'number $label_dist <= 2' fails.
WHY_NOT_UNIT_TEST It exists only to prove W1946's distance check can go red.
STEPS
  v3 setvar INSUNITS 6
  getvar INSUNITS -> $iu
  ms-count -> $n0
  type "CD{NL}150,-80{NL}170,-80{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $cd_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd_e1
  wait
  ms-new $n0 -> $new_all
  select $new_all "object~^CeCvlPipeObject$" -> $pipes
  select $new_all "text~ DIA\. " -> $label
  field $label text -> $label_text
  dist $label "160,-80" -> $label_dist
ASSERT
  equals $iu "6"
  count $pipes = 1
  count $label = 1
  matches $label_text "^\d+ DIA\. \S+ PIPE AT 1 IN \d+$"
  number $label_dist <= 2
  record $label_dist "distance with the switch OFF (expected to be about 237)"
```

---

## 4. Codex look notes (no robot case)

Evidence folder for all three: `C:\CE_WORK\codex\set08_02nov\<fix>\`. Use copies of drawings only. Never accept or capture a folder the box opened in.

### 4.1 #1924 (B-111, BUG-642): CDCATCHMENT label stays clear of the pipe wording

**BLOCKED-FOR-ROBOT, one line:** no robot has ever driven CDCATCHMENT (it needs a grated pit, a closed paved outline and two Select prompts), the grated-pit field id in New Pit is unknown, and what matters (the label not sitting on the pipe wording) is a picture. Not enough known to write a case that could do more than come back BLOCKED.

**Switch:** `surface.catchmentOverlayLabelAvoidsText`, default ON; `surface.catchmentOverlayLabelHeightMm`, default 200 (group `surface` from `UserSettings.cs`; PR text).

**Codex look:**

1. **Open** a copy of the CODEX_CATCHMENT_OVERLAY_20261015 drawing (the BUG-642 steps), two pits, P1 grated, a paved outline round the area, pipes labelled `225 DIA. UPVC PIPE AT 1 IN 48`. Confirm the Civil build shows the PR's change (read the DLL product version, not a document).
2. **Type** `CDCATCHMENT`, pick the paved outline, pick P1, press Enter to finish.
3. **Right looks like:** the catchment label (white, 200 mm text) does NOT overlap the pipe wording or the pit text; it sits up-left, down-right or further out if the old spot was taken. If no spot is clear, the command line shows one line saying so and the label sits at the old spot. Save a screenshot at the zoom a drafter would use.
4. **Type** `CDCATCHMENT` then `Hide`, then `Show`: the label comes back in the same clear spot.
5. **Repeat with the switch OFF** (set `surface.catchmentOverlayLabelAvoidsText` false before AutoCAD starts): the old overlap should come back. That is the red.
6. **Not covered:** Tim's own plotted look, other scales, colour and fill contrast.

### 4.2 #1944 (B-126, BUG-296): rebuilt pit record in a metre drawing

**BLOCKED-FOR-ROBOT, one line:** the fault only shows when a rebuilt pit record has lost both the pit's id and its handle in a metre drawing, which needs a real metre drawing (none exists on this PC, see R24) and a way to force a rebuild that no case has driven.

**Switch:** `linking.recoveryPositionMatchReadsDrawingUnits`, default ON.

**Codex look (only if Tim wants more than the unit tests, rare route, LOW value):**

1. **Open** a copy of a drawing really saved in metres (INSUNITS 6) with two pits 5 m apart, each with a different remark typed in Edit Pit.
2. **Erase** one pit and place a new pit at exactly its position; run `CDSYNC`, accept its question.
3. **Right looks like:** the new pit does NOT take the neighbour's remark; if the new pit is within 0.2 m of where the old one stood, it may take the old pit's data (that is the 200 mm rule, now 0.2 in a metre drawing). Pit Schedule shows each pit with its own remark.
4. **Evidence:** screenshot of the Pit Schedule before and after.
5. **This is not proof of the "id and handle both failed" path**; say so in the report.

### 4.3 #1974 (B-123, BUG-1175): CDSL and CDTRENCHGRATEAUDIT wording

**BLOCKED-FOR-ROBOT, one line:** CDSL's changed wording only prints when the SPOT LEVEL block file is missing, and the robot may not remove a file from the installed bundle (and CDTRENCHGRATEAUDIT's changed path needs the same file moved).

**Codex look (needs a bundle COPY, not Tim's live bundle; Tim's call whether to run it, because it needs a second place for the bundle):**

1. **Copy** the installed `CE_CVL_SUITE.bundle` to a scratch folder and load that copy on a test profile (or a colleague-type PC). Do NOT edit `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle`.
2. **Remove** `SPOT LEVEL.dwg` from the copy's `Contents\Blocks\`. Run `CDSL`.
3. **Right looks like:** the command line names only the bundle's Blocks folder ("CE_CVL_SUITE.bundle\Contents\Blocks\") or a reinstall; it does not say `C:\Lisp Files`.
4. **Put the file back, run `CDTRENCHGRATEAUDIT`:** it reports from the bundle's own TRENCH GRATE.dwg. Then remove `TRENCH GRATE.dwg` from the copy and run it again: one line says it was not found in the bundle's Blocks folder and "Nothing was audited."
5. **Not covered by this PR:** the CDHELP "Superseded folder" window line (the PR says it is a window and left it).
6. **Cheaper alternative for the desk:** the PR's own search test (no shipped string contains `C:\Lisp Files`) already covers the wording; the Codex look adds only that it prints in AutoCAD.

---

## 5. Fixes skipped, and why

1. **None skipped as "already has a case".** All six were checked (section 1 item 2).
2. **#1924, #1944, #1974:** not drafted as robot cases, reasons in section 4. The brief asked for up to five cases; only three had a route the robot can drive without a refused button, a missing fixture or a file change.

---

## 6. What was read, built, tested, NOT proven

1. **Read:** the files listed in section 1; PR diffs for all six (the non-test files in full for #1888, #1923, #1944, #1946, #1974; #1924 only the first part of the change, the label-spot search code after `ChooseLabelSpot` was not read).
2. **Built:** nothing. **Tested:** nothing. **Run in AutoCAD:** no. **Validated with `case_runner.ps1 validate`:** no (the validate step is the first job for CE 05).
3. **NOT proven:** every printed line and window word marked DERIVED; the `ent-read` rotation digits for a text object (W1888); the Edit Pit window title and the aim at the label block (W1923); that CD works with free ends in a metre drawing and that the robot's INSUNITS switch is read live by CE (W1946); that the three-point CD route and the UCS chains behave as written (W1888). A first run may need one or two corrections, as the 30 Oct set did.
4. **The robot cannot prove for W1946** a real metre drawing; for W1888 and W1923 the look (label parallel to the pipe; Edit Pit content) needs a Codex look if Tim wants it.
