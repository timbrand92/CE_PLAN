# Robot case drafts, SET 24: Structural RC windows, SBEAM timber, level marks, sheets sync, hatch change (older fixes) (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Two robot cases for fix PR #1736 (each with a broken twin, so four case texts), drafted on paper. The other five fixes (#1729, #1731, #1732, #1737, #1746) are window-only and are marked BLOCKED-FOR-ROBOT with a Codex look each. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder: the only file written is this one. No git write.

---

## FOR TIM

1. **2 robot cases drafted, each with a broken twin (4 case texts).** Both are for level marks (#1736, BUG-1082): W1736 (lock 25DIMS and 25TEXT, then FFL, NGL and LM must each say "Layer 25DIMS is locked, so CE drew no level mark" and draw nothing) and W1736R (with a block open for in-place editing, FFL, LM and RL must stop with the REFEDIT line before they ask for a point).
2. **Codex-only (BLOCKED-FOR-ROBOT, 5 fixes).** #1729 (column bar size), #1731 (typed bar count), #1732 (timber quantity of 10 or more), #1737 (one out-of-date drawing in the sheets update) and #1746 (hatch change). Each is a window the robot cannot read or a button it must not press. Codex looks are in part 3.
3. **Needs an Opus review BEFORE it is run:** W1736 and W1736R (a locked layer and REFEDIT). They only lock a layer and open an edit as set-up, and never unlock anything, but the rule says an Opus eye first. Also #1746 (its check ends with U, Undo), as a Codex look.
4. **A catch for the desk.** Two of the six PRs are NOT in the Structural line. #1731 (typed bar count, BUG-1038) and #1737 (sheets, BUG-1041) are not in `origin/claude/rel-20261026s` (their fix commits `115a5c19`, `2878e6c2` and `4ae66b1b` are not ancestors of it). The other four are (merge commits in S-44, all before the Structural 1.0.124 version commit `3a3caac5`). GitHub still shows all six as OPEN, not merged. So the installed Structural 1.0.124 should hold #1729, #1732, #1736 and #1746 and should NOT hold #1731 or #1737. Read from git, not from the installed DLL.
5. **Example of what W1736 checks.** Lock 25DIMS and 25TEXT, type FFL, pick 0,0, Right, type 10.000. Right looks like: the line "Layer 25DIMS is locked, so CE drew no level mark. Unlock it and try again." and nothing new in the drawing. The twin claims the old fault (a mark is drawn, "Level mark created") and must FAIL.
6. **Could NOT verify:** that the Structural plugin is loaded in the robot's AutoCAD (the bundle folder is installed, I did not open AutoCAD); that the robot accepts a typed `-LAYER` lock chain; the exact lines a first run prints. Both W1736 cases should PASS on the installed 1.0.124 (they prove an installed fix); only the twins prove the case can go red.
7. **Nothing for you to test or decide now.** All the bug entries stay OPEN.

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `README_CASES.md` in full, including the refused-button list; `acad_driver_v3.allowlist.json`; `CASE_WRITING_STRUC_REPORT_30OCT.md`; the S467 and S472 cases (`S472b_refedit_stops_proof` in full); `ROBOT_CASE_DRAFTS_SET19` (the Structural twin style); the six PR texts (`gh pr view`, read only); the diff of #1736; the Structural source on `origin/claude/rel-20261026s` (`LevelMarkCommands.cs`, `NotesDrawingGuards.cs`, `LayerService.cs`) with `git show` only; the carpark entries for BUG-1037, 1038, 1039, 1041, 1048 and 1082.
2. **Is there already a case?** No, checked again. No file in `cases\` (including every `drafts_*` folder and `variants\`) names BUG-1037, 1038, 1039, 1041, 1048 or 1082 (my search for the bare numbers found only handles and numbers in other cases, none these bugs). No `ROBOT_CASE_DRAFTS_*.md` names these PRs. `ledger.json` has no level mark, RC, SBEAM, hatch or sheets case. I did not find a `BUGFIX_*_REPORT` that names them (the PR texts carry the same facts).
3. **Why only #1736 is a robot case.** The allow-list (`acad_driver_v3.allowlist.json`) holds no RC column or beam window, no SBEAM window, no sheets panel and no hatch-change window, so none can be read. Their buttons ("Place Section", "OK", "Apply preset", "Preview drawing updates") are not on any press list either, and `Apply` and `Update Drawings` are on the refused list. Level marks are different: FFL, NGL and LM are all typed prompts on the command line.
4. **No Structural setting is used.** #1736 has no switch (the PR says so: drawing onto a protected layer is a defect). So the twins are "claims the old fault" twins, the S467 style. The switch-off twin style is not possible here. For the other five fixes the switches are named in the Codex looks.
5. **Fixture.** DRV2_S1 (the Structural copy in `C:\ce_rc_drv`, millimetres, used by the 30 Oct Structural cases), not DRV1_B1: the commands are Structural and DRV2_S1 is the one Structural run 2 and the S467 cases used. DRV1_B1 would also work (the level mark code has no units check that I saw). No setup file is needed. **SLOT fresh**, order numbers 930 to 933.
6. **Protection.** The set-up only LOCKS layers (`-LAYER Lock`) and opens a REFEDIT; no step unlocks, thaws, detaches or goes round anything. The locked layers stay locked to the end of the case. A second FFL after the refusals checks they are still locked.
7. **What is DERIVED (read from code, never seen on a run).** The prompt order (FFL: "Pick level point", "Side [Left/Right] <Right>", "Level value"; LM first asks "Level mark type"); the locked line text (`LayerService.LockedLayerLine`); the REFEDIT line text (`NotesDrawingGuards.RefEditStopMessage`); that 25DIMS is the layer named when both are locked (`FirstLockedLayer(db, "25DIMS", "25TEXT")`, argument order); that REFEDIT stops FFL and LM before any prompt. The `-LAYER` chain, and the `-BLOCK`, `-INSERT` and `-REFEDIT` chain copied from S472b (its order on AutoCAD 2027 is untried), are guesses until a first run.
8. **settings-arm.** RunDirect saves the "last level mark type" to the Structural settings file before it prompts, so both cases start with `settings-arm` (backs up the settings files and puts the same bytes back). No `hashes-unchanged`.
9. **To validate offline:** copy each block to its file name in a new folder (suggested `cases\drafts_struc_set24_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run this.
10. **Not proven by any of this:** that a first run behaves as DERIVED above; that Structural is loaded in the robot session; the normal mark with both layers unlocked (the same three objects as before: not driven, see NOT_AUTOMATED); LMU (not touched by the fix).

---

## 2. The case texts

### Case 1 of 2: W1736, level marks stop on locked 25DIMS and 25TEXT (#1736, BUG-1082), locked-layer half. Opus review before it is run

**Intended file:** `W1736_level_marks_stop_on_locked_layers.case.txt`

```
# W1736 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; locked layer: OPUS REVIEW BEFORE IT IS RUN). PR #1736 (BUG-1082), no switch, merged into S-44 (679945c1), before the Structural 1.0.124 version commit 3a3caac5. On the installed 1.0.124 this case should PASS (it proves an installed fix); the twin W1736_BROKEN is the red-before-green proof.
# Route (DERIVED from LevelMarkCommands.cs on rel-20261026s, not seen on a run): FFL, NGL and RL ask 'Pick level point:', then 'Side [Left/Right] <Right>:', then 'Level value (e.g. +150, RL42.350, -50):'; the lock check comes after those three answers and before any layer is made or anything drawn. LM first asks 'Level mark type [FFL/RL/SSL/NGL/?] <SSL>:'. A locked layer prints '[CE] Layer 25DIMS is locked, so CE drew no level mark. Unlock it and try again.' and draws nothing.
# Set-up (GUESSED chain, untried): -LAYER Make 25DIMS, Make 25TEXT, Set 0 (so layer 0 is current), Lock both. Nothing in this case ever unlocks a layer; a fourth FFL at the end checks the layers are still locked.
# Which layer is named when both are locked is DERIVED from the argument order of FirstLockedLayer (25DIMS first); it is recorded, not asserted.
CASE W1736
TITLE Both 25DIMS and 25TEXT locked: FFL, NGL and LM each say Layer 25DIMS is locked and draw no level mark; a fourth FFL still says so (layers still locked); nothing is added to the drawing
PLAN_ITEM BUG-1082 (PR #1736) PART: the locked-layer half, for FFL, NGL and LM, with both layers locked. NOT whole: the REFEDIT half (case W1736R), the line naming 25TEXT when only 25TEXT is locked, RL and SSL typed directly, the normal mark with both layers unlocked, and U and REDO after a refusal
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 930
TIMEOUT 600
BUG BUG-1082
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the set-up lock, FFL (0,0, Right, 10.000), NGL (0,2000, Right, 9.500), LM with SSL (0,4000, Right, 8.250) and a second FFL each print 'Layer 25DIMS is locked, so CE drew no level mark. Unlock it and try again.' (four times in the case); 'Level mark created' never appears; no unknown command; the number of objects in the drawing is the same before and after the four attempts; the file on disk does not change.
WHY_NOT_UNIT_TEST The unit tests pin the line wording and the order in the source text; only a real locked layer in AutoCAD shows that nothing is drawn and that the layers stay locked.
NOT_AUTOMATED The line that names 25TEXT when only 25TEXT is locked (needs a drawing with only that layer locked; this case never unlocks one).
NOT_AUTOMATED The normal mark with both layers unlocked (the same three objects as before), RL and SSL typed directly, and U or REDO after a refusal.
NOT_AUTOMATED How the refusal looks on screen (the line text is recorded, not judged).
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM{NL}_W{NL}-5000,-5000{NL}5000,6000" -Force
  wait
  type "_.-LAYER{NL}_M{NL}25DIMS{NL}_M{NL}25TEXT{NL}_S{NL}0{NL}_LOCK{NL}25DIMS,25TEXT{NL}" -Force -> $lay
  wait
  ms-count -> $c0
  type "FFL{NL}0,0{NL}Right{NL}10.000" -Force -TimeoutSec 90 -> $t_ffl
  esc-prompt -> $e_ffl
  wait
  type "NGL{NL}0,2000{NL}Right{NL}9.500" -Force -TimeoutSec 90 -> $t_ngl
  esc-prompt -> $e_ngl
  wait
  type "LM{NL}SSL{NL}0,4000{NL}Right{NL}8.250" -Force -TimeoutSec 90 -> $t_lm
  esc-prompt -> $e_lm
  wait
  type "FFL{NL}0,0{NL}Right{NL}10.000" -Force -TimeoutSec 90 -> $t_again
  esc-prompt -> $e_again
  wait
  ms-count -> $c1
ASSERT
  history count "Layer 25DIMS is locked, so CE drew no level mark. Unlock it and try again." = 4
  history absent "Level mark created"
  history absent "Unknown command"
  equals $c1 $c0
  copy-unchanged $copy0
  record $lay "FULL -LAYER reply (how the lock chain was taken)"
  record $t_ffl "FULL what FFL printed"
  record $t_lm "FULL what LM printed"
  record $e_again "FULL what the fourth FFL printed (layers still locked)"
```

**Twin:** `W1736_BROKEN_claims_old_fault.case.txt`

```
# W1736_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1736: the same steps, the OLD claim. Before BUG-1082 a level mark was drawn on the locked layers and CE said '[FFL] Level mark created.' On the installed 1.0.124 the fix is in, so this twin must FAIL. A PASS means the fix is not in the installed build, or the layers did not lock (read the -LAYER reply). No SETTING line: the PR has no switch.
CASE W1736_BROKEN
TITLE BROKEN VARIANT of W1736: claims a mark IS drawn on the locked layers and Level mark created is printed (must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1736 (BUG-1082, PR #1736)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 931
TIMEOUT 600
BUG BUG-1082
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1736
REVIEWED_AGAINST
EXPECTED Wrong on purpose: claims 'Level mark created' is printed and the drawing gains objects, which only the old build did.
WHY_NOT_UNIT_TEST It exists only to prove W1736's checks can go red.
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM{NL}_W{NL}-5000,-5000{NL}5000,6000" -Force
  wait
  type "_.-LAYER{NL}_M{NL}25DIMS{NL}_M{NL}25TEXT{NL}_S{NL}0{NL}_LOCK{NL}25DIMS,25TEXT{NL}" -Force -> $lay
  wait
  ms-count -> $c0
  type "FFL{NL}0,0{NL}Right{NL}10.000" -Force -TimeoutSec 90 -> $t_ffl
  esc-prompt -> $e_ffl
  wait
  type "NGL{NL}0,2000{NL}Right{NL}9.500" -Force -TimeoutSec 90 -> $t_ngl
  esc-prompt -> $e_ngl
  wait
  type "LM{NL}SSL{NL}0,4000{NL}Right{NL}8.250" -Force -TimeoutSec 90 -> $t_lm
  esc-prompt -> $e_lm
  wait
  ms-count -> $c1
ASSERT
  history count "Level mark created" = 3
  number $c1 > $c0
  history absent "so CE drew no level mark"
  record $t_ffl "FULL what FFL printed"
```

---

### Case 2 of 2: W1736R, level marks stop inside REFEDIT (#1736, BUG-1082), REFEDIT half. Opus review before it is run

**Intended file:** `W1736R_level_marks_stop_in_refedit.case.txt`

```
# W1736R DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; REFEDIT: OPUS REVIEW BEFORE IT IS RUN). PR #1736 (BUG-1082), no switch, in S-44, before 1.0.124. On the installed 1.0.124 this case should PASS (installed fix); W1736R_BROKEN is the red-before-green proof.
# Rule (DERIVED from LevelMarkCommands.cs and NotesDrawingGuards.cs on rel-20261026s): with REFEDITNAME not empty, FFL, RL, SSL and NGL (RunDirect) stop before the point prompt, and LM stops before its type prompt, each printing '[CE] A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn. Save or close the edit (REFCLOSE), then run this again.'
# Set-up: copied from S472b_refedit_stops_proof (typed -BLOCK, -INSERT, -REFEDIT; the question order on AutoCAD 2027 is UNTRIED). If the check REFEDITNAME = S472BLK fails first, read that as a set-up problem, not a CE fault, and fix the chain from the recorded replies. REFCLOSE Discard ends the edit; the runner reopens a fresh copy for the next case anyway. Xref in-place editing is not set up (no Xref the robot can rely on).
CASE W1736R
TITLE Inside REFEDIT of a plain block, FFL, LM and RL each stop with one REFEDIT line before asking for a point or a type, and nothing is drawn
PLAN_ITEM BUG-1082 (PR #1736) PART: the REFEDIT half, for FFL, LM and RL, with a plain block open (not an Xref). NOT whole: the locked-layer half (case W1736), NGL and SSL typed directly, an Xref in-place edit, and the 'CE could not check REFEDITNAME' line
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 932
TIMEOUT 600
BUG BUG-1082
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the typed set-up REFEDITNAME reads S472BLK. FFL, LM and RL each print 'A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn. Save or close the edit (REFCLOSE), then run this again.' (three times in the case); 'Pick level point' and 'Level mark type' never appear; no unknown command; the number of objects in Model space is the same before and after the three commands; the file on disk does not change.
WHY_NOT_UNIT_TEST The unit tests pin the decision with a name string and the position of the check in the source text; only AutoCAD's live REFEDITNAME inside a real in-place edit shows the command stopping before its first question.
NOT_AUTOMATED In-place editing of an Xref (the other half of the REFEDIT rule) and the unreadable-REFEDITNAME line.
NOT_AUTOMATED NGL and SSL typed directly, the locked-layer line, and how the line looks on screen (recorded, not judged).
STEPS
  settings-arm
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM{NL}_W{NL}14000,3000{NL}24000,9000" -Force
  wait
  type "_.LINE{NL}18000,5000{NL}20000,5000{NL}" -Force -> $ln
  wait
  type "_.-BLOCK{NL}S472BLK{NL}18000,5000{NL}_L{NL}" -Force -> $blk
  wait
  type "_.-INSERT{NL}S472BLK{NL}18000,5000{NL}1{NL}1{NL}0" -Force -> $ins
  wait
  type "_.-REFEDIT{NL}19000,5000{NL}_OK{NL}_All" -Force -> $re
  wait
  sleep 2
  getvar REFEDITNAME -> $ren
  ms-count -> $c0
  type "FFL" -Force -> $t_ffl
  esc-prompt -> $e1
  wait
  type "LM" -Force -> $t_lm
  esc-prompt -> $e2
  wait
  type "RL" -Force -> $t_rl
  esc-prompt -> $e3
  wait
  ms-count -> $c1
  type "_.REFCLOSE{NL}_Discard" -Force -> $rc
  wait
ASSERT
  equals $ren "S472BLK"
  contains $t_ffl "A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn. Save or close the edit (REFCLOSE), then run this again."
  contains $t_lm "A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn. Save or close the edit (REFCLOSE), then run this again."
  history count "A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn." = 3
  history absent "Pick level point"
  history absent "Level mark type"
  history absent "Unknown command"
  number $c1 = $c0
  copy-unchanged $copy0
  record $blk "FULL -BLOCK reply"
  record $ins "FULL -INSERT reply"
  record $re "FULL -REFEDIT reply (question order on this AutoCAD)"
  record $t_rl "FULL what RL printed"
  record $rc "FULL REFCLOSE reply"
```

**Twin:** `W1736R_BROKEN_claims_old_fault.case.txt`

```
# W1736R_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1736R: keeps the set-up check and claims the OLD behaviour (before BUG-1082 there was no REFEDIT check, so FFL went straight to 'Pick level point'). On the installed 1.0.124 this twin must FAIL. If the set-up check fails first, the REFEDIT never opened: read that as a set-up problem. No SETTING line: the PR has no switch.
CASE W1736R_BROKEN
TITLE BROKEN VARIANT of W1736R: inside REFEDIT, claims FFL asks Pick level point and prints no REFEDIT line (must FAIL on a build with the fix)
PLAN_ITEM red-before-green proof for W1736R (BUG-1082, PR #1736)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 933
TIMEOUT 600
BUG BUG-1082
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1736R
REVIEWED_AGAINST
EXPECTED Wrong on purpose: claims 'Pick level point' appears and no REFEDIT line is printed, which only the old build did.
WHY_NOT_UNIT_TEST It exists only to prove W1736R's checks can go red.
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM{NL}_W{NL}14000,3000{NL}24000,9000" -Force
  wait
  type "_.LINE{NL}18000,5000{NL}20000,5000{NL}" -Force -> $ln
  wait
  type "_.-BLOCK{NL}S472BLK{NL}18000,5000{NL}_L{NL}" -Force -> $blk
  wait
  type "_.-INSERT{NL}S472BLK{NL}18000,5000{NL}1{NL}1{NL}0" -Force -> $ins
  wait
  type "_.-REFEDIT{NL}19000,5000{NL}_OK{NL}_All" -Force -> $re
  wait
  sleep 2
  getvar REFEDITNAME -> $ren
  type "FFL" -Force -> $t_ffl
  esc-prompt -> $e1
  wait
  type "_.REFCLOSE{NL}_Discard" -Force -> $rc
  wait
ASSERT
  equals $ren "S472BLK"
  history has "Pick level point"
  history absent "A block or Xref is open for in-place editing (REFEDIT). Nothing was drawn."
  record $t_ffl "FULL what FFL printed inside REFEDIT"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Common rules for every look: use a COPY of a drawing, never Tim's job drawing; AutoCAD must have a Structural build that holds the PR (see FOR TIM item 4: #1731 and #1737 are not in the Structural line, so the installed 1.0.124 does not hold them); take the screenshots yourself and save them under `C:\CE_WORK\codex\<look name>\` (one folder per look); never accept or capture a folder a file box opened in. If a look needs the switch OFF, set it by hand in the Structural settings before AutoCAD starts and put the file back afterwards. Every word below marked DERIVED comes from the PR text, not from a run. The first column-bar check in each look is a LIST of one object, so the number is read from AutoCAD itself.

### Look 1: #1729 (BUG-1037), RCRECTCOL and RCCIRCCOL draw main bars at their real size. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The RC column window is not on the driver's read list, and its Place Section button is not on a press list.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1729`. Blank millimetre drawing copy, INSUNITS 4, DIMSCALE 20. Type RCRECTCOL: 400 x 400, N12 main bars, two per face, N10 ties, cover 40. Place Section at 0,0. Type LIST, pick the bar circle centred at 56,56, screenshot the text window. Repeat at 1000,0 with N24. Type RCCIRCCOL: diameter 450, eight N12, place, LIST one bar circle. Press U once after each placement.
3. **Right looks like (DERIVED from the PR text).** N12 circle radius 6 mm; N24 radius 12 mm; round column N12 radius 6 mm; no bar circle crosses the tie line; one U removes the whole column.
4. **Switch off.** `options.columnBarsAtRealSize` false before AutoCAD starts: every bar circle is the same fixed size (radius 20 mm at 1:20), as before.

### Look 2: #1731 (BUG-1038), RC windows take a typed bar count. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The RCBEAM, RCRECTCOL and RCCIRCCOL windows are not on the read list, and the count boxes are typed fields.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1731`. Use a build that holds #1731. Type RCCIRCCOL: diameter 600, N20, N10 ties, cover 40. Type 14 in Total bars. Screenshot the window and its preview. Place Section at 0,0 and count the bar circles. Repeat with 18. Type RCRECTCOL 800 x 800 with 7 bars per face. Type RCBEAM and type 14 in the bottom bar count. In each window clear the box or type 0 and press OK.
3. **Right looks like (DERIVED from the PR text).** The window keeps 14 and the preview shows 14 bars; the label reads 14N20 and there are exactly 14 bar circles; 18 the same; the rectangular column draws 24 bars; the beam keeps 14 (a "bars do not fit" warning may show, it does not block); a blank or 0 shows "[CE] ... must be a whole number of 1 or more (up to 999)." and the window stays open. A later Opus fix (`2878e6c2`) makes Bars per face take 2 or more: try 1 per face and record the message.
4. **Switch off.** `options.barCountsTypedFreely` false: the pick-only lists return and typing 14 does nothing.

### Look 3: #1732 (BUG-1039), SBEAM timber picker accepts ten or more pieces. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The SBEAM section window is not on the driver's read list and the Quantity box is a typed field.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1732`. Blank millimetre drawing copy. Type SBEAM, pick Timber, grade MGP10, width 45, depth 190, quantity 9, screenshot (OK enabled). Change quantity to 10, screenshot. Place the beam and screenshot the label. Type 0, then 2.5 in the box.
3. **Right looks like (DERIVED from the PR text).** 10 stays and OK stays enabled with no red message; the label reads "10 No 45 x 190 MGP10". 0 or 2.5 shows "Quantity (No.) must be a whole number, 1 or more." and OK is greyed.
4. **Switch off.** `options.timberQuantityAnyNumber` false: 10 shows "Quantity (No.) must be a whole number from 1 to 9." and OK is greyed.

### Look 4: #1737 (BUG-1041), one out-of-date drawing no longer stops every sheet title update. BLOCKED-FOR-ROBOT

1. **Why the robot cannot.** The older Sheets panel (CESHEETSCLASSIC) is not on the read list, and it needs a project with several drawings, a saved scan and a saved edit in one of them. "Update Drawings" and "Apply" are on the refused list.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1737`. Use a build that holds #1737, and a copy of a project (or a synthetic one) with sheets S01 and S02, title attributes, a complete saved scan, and S01's title changed OLD to NEW but not yet synced. Save a harmless edit in S02. Type CESHEETSCLASSIC, close the manager window, click "Preview drawing updates". Screenshot the warning and the preview. Do NOT press an update or apply button.
3. **Right looks like (DERIVED from the PR text).** A warning naming S02 only ("Left out 'J1_STR_S02.dwg': it was saved after the last project scan. Its sheets are not updated this time - rescan in CE Sheets Manager to include them. The other drawings go ahead."); S01's title shows as updated in the preview; S02's file untouched (check its date and time before and after).
4. **Switch off.** `ceSheets.SyncSkipsOnlyAffectedDrawings` false: "Sync blocked" and no sheet updated (the old all-or-nothing).

### Look 5: #1746 (BUG-1048), CEHATCHCHANGE changes the hatches it can and names the one it cannot clear. BLOCKED-FOR-ROBOT. Opus review (Undo) before it is run

1. **Why the robot cannot.** The hatch change window is not on the read list, picking two hatches needs the mouse, and its Apply preset button is not on a press list (`Apply` is on the refused list). The check also ends with U (Undo).
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_1746`. Blank drawing copy: two hatches in separate rectangles, H-A ordinary and H-B with a coloured background. Type CEHATCHCHANGE, select both, press Enter, pick PT slab, press Apply preset. Screenshot the command line and the drawing. Type U once and screenshot again. Do not clear H-B's background for CE; CE must never try to.
3. **Right looks like (DERIVED from the PR text).** H-A changes; the line "[CE] 1 hatch was left unchanged (handle ...): the coloured background cannot be cleared safely. Remove the background in AutoCAD so Properties shows None, then run CEHATCHCHANGE on it again. One U undoes the hatches that were changed." appears; one U puts H-A back. With only H-B selected the old refusal shows ("REFUSED ... Nothing was changed").
4. **Switch off.** `Options.HatchChangeSkipsRefusedAndChangesTheRest` false: both hatches refused, nothing changes.

---

## 4. Fixes skipped and why

1. **None skipped as "already has a case".** No case or draft exists for any of the six.
2. **#1729, #1731, #1732, #1737, #1746:** BLOCKED-FOR-ROBOT, Codex looks above. Windows not on the read list, typed fields, mouse picks or buttons the robot must not press.
3. **#1736 in part.** The robot cases cover FFL, NGL and LM with both layers locked, and FFL, LM and RL in a plain REFEDIT. Not covered: the line naming 25TEXT (needs only 25TEXT locked), RL and SSL typed directly, the normal mark, U and REDO after a refusal, and an Xref in-place edit.
4. **I did not use** a mid-case settings change, a second drawing, a typed table cell, a right-click menu item, an Export, Save or Apply press, or any unlock.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** the files and PRs in part 1 item 1, the Structural source on the train line by `git show`, and the cases folders and drafts for existing cases (part 1 item 2). Nothing in Tim's real settings files was opened. The Keys folder, `C:\CE_DrawingIntelligence` and AutoCAD were not touched. `git fetch` was run (read only).
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Tim-accepted:** nothing.
3. **NOT proven:** that any of the four case texts validates offline; that any prompt or printed line is exactly as DERIVED (first runs will need one or two fix-ups); that the Structural plugin is loaded in the robot's AutoCAD; that the typed `-LAYER` lock chain and the `-REFEDIT` set-up work on AutoCAD 2027; which build is installed (only the version commit order in git was read, not the installed DLL); and everything in the five Codex looks (window words, switch keys and numbers are from the PR text only).
