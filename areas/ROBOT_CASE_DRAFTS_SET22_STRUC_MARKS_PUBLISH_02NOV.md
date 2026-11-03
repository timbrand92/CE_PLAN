# Robot case drafts, set 22: Structural marks, copied beams, XRL, Publish Issue and bar mass (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Two robot cases, each with a failing twin (4 case texts), written as plain text below with the file name each should get. The other four fixes cannot be proved by the robot, so each has a numbered Codex look. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `git fetch`, `gh pr view` and `gh pr diff`).

---

## FOR TIM

1. **2 robot cases with a failing twin each drafted (4 case texts):** W1885 (Level Update changes the CE level mark and leaves an ordinary note) and W1908 (BARWEIGHT gives 1479.6 kg for 100 N20 at 6 m, the same as the bar schedule, and says so when a bar size is not in the catalogue).
2. **Codex-only (4 fixes, marked BLOCKED-FOR-ROBOT):** #1899 (copied beam, discarded open, damaged point-load list), #1901 (XRL), #1929 (Publish Issue with nothing ticked) and #1931 (moving part of an RC detail). Exact steps are in the Codex look notes below.
3. **Why those four are Codex-only.** RCBEAM and RCRECTCOL open data-entry windows the robot may not fill (#1931). Publish Issue is a Publish button, which the robot may never press (#1929). XRL needs an Xref, which is a second drawing, and the robot may not make one (#1901). #1899 needs a second AutoCAD session (close without saving, reopen) and a damaged saved list the robot cannot make without typed LISP.
4. **Needs an Opus review before it is run:** #1901 (it is about Xrefs, and Cancel must leave them untouched) and #1931 (it is about Undo: "Press U to undo"). The two robot cases themselves press no U, touch no locked layer and no Xref.
5. **The "switch off" twin is NOT possible for these two.** The robot's settings line writes the bare name `CS_Settings.json` into the `TIM_CE_CADTOOLS` folder, but Structural 1.0.125 reads `CE_STRUC_SUITE\CS_Settings.json` first and that file exists on this PC. A switch-off twin would look like it ran and prove nothing. So both twins claim the OLD behaviour and must fail on the fixed build. Fixing the setting path is a runner change, not mine to make.
6. **One earlier draft covers the same fix as #1885.** W1879 (set 09, ROBOT_CASE_DRAFTS_SET09) is for #1879, the same BUG-625 fix opened on the wrong line. The new W1885 is the same route for the right PR (the Structural line). When #1885 is merged, #1879 should be closed and W1879 dropped, so the robot does not run the same check twice.
7. **What I could not verify:** that the Structural plugin is loaded in the robot's AutoCAD (earlier robot runs typed BT1 and CSREOBAR on the Structural copy, so it should be); every command-line line and figure below came from the PR text, not from a run (all marked DERIVED); the two cases were not even run through the offline validator, because I may not create files.
8. **Nothing for you to test or decide.**

---

## 1. How the drafts were written (read before validating)

**What I read.**
1. `C:\TimOS\RULES.md`; `cases\README_CASES.md` in full (including the refused-press rules); `acad_driver_v3.allowlist.json` (window names it can press: Settings, About, Edit source and similar, with Cancel, Close or OK only).
2. The finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; set 09 (the W1879 draft); `CASE_WRITING_STRUC_REPORT_30OCT.md` and the S467 and S472 Structural cases (for the Structural fixture and `settings-arm`).
3. For each of the six: `gh pr view` and `gh pr diff` (code, REGRESSION_LOG entry, switch name and default), and the carpark headings in `BUG_CARPARK.md`. I read the code at `origin/claude/rel-20261026s` (after a fetch) for the BARWEIGHT and Level Update prompts and the settings paths.
4. I did not find a `BUGFIX_*_REPORT_*.md` in `C:\CE_PLAN\areas` that names these six by bug or PR number, apart from the fx1885 report named in set 09 (not opened again here).

**Re-check that no case exists (the earlier search matched the bug number as text only).** I searched the cases folder (main, `variants`, `_setups` and all `drafts_*` folders), every `ROBOT_CASE_DRAFTS_*.md` file and `runner-reports\ledger.json` for the six PR numbers, the eight bug numbers, and the words XRL, BARWEIGHT and LMU. Results:
1. **#1885 (BUG-625):** no case. The only draft is W1879 (set 09), same fix, different PR (see FOR TIM item 6).
2. **#1899, #1901, #1929, #1931, #1908:** no case and no draft anywhere.
3. The ledger holds no result for any of them.

**Format.**
1. Exactly the README format. Case ids `W<PR number>` and `W<PR number>_BROKEN`, order numbers 910 to 913, fixture DRV2_S1 (the Structural test copy, used by the S467 cases; DRV1_B1 is the Civil copy and these are Structural commands), `SLOT fresh`, REVIEWED_AGAINST left empty, no `(` and no SAVE-type word in any type chain.
2. Both cases begin with `settings-arm`, because BARWEIGHT and FFL each save the remembered last value into the Structural settings file; `settings-arm` puts the exact bytes back at the end.
3. Neither case uses `hashes-unchanged` (it conflicts with `settings-arm`); both use `copy-unchanged` to prove the drawing file on disk did not change.
4. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set22_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.

**DERIVED means:** the line or number was read from the PR text or code, and was not seen on a run. Expect one or two fix-ups on a first run.

**Nothing here unlocks a layer, detaches or unloads an Xref, or bypasses any AutoCAD protection.** W1885 draws one level mark and one note on the current layers. W1908 types BARWEIGHT three times, answers No to "Place result in drawing?" every time, and draws nothing.

---

## 2. The cases

### Case 1 of 2: W1885, Level Update changes the CE level mark and leaves an ordinary note (PR #1885, BUG-625)

**Intended file:** `W1885_lmu_only_changes_ce_level_mark.case.txt`

```
# W1885 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1885 (B-065, BUG-625), base claude/rel-20261026s (Structural 1.0.125). Same route as the set 09 draft W1879, written for the right PR.
# Carpark BUG-625 (15 Oct 2026, real AutoCAD, Structural 1.0.116): LMU on an ordinary note GENERAL NOTE KEEP, value 10.500, replaced the note's whole text and said 'Updated 1 level label(s)'.
# Route, read from LevelMarkCommands.cs on rel-20261026s: FFL asks 'Pick level point: ', then 'Side [Left/Right] <Right>: ' (Enter = Right), then 'Level value (e.g. +150, RL42.350, -50):', and prints '[FFL] Level mark created.' (that last line is DERIVED, taken from set 09, not re-read). LMU asks 'Select level value text to update: ' (TEXT and MTEXT) then 'New level value:' and prints '[CE_LEVELUPDATE] Updated N level label(s).'
# New lines with the switch ON (DERIVED, read from the PR diff, not seen on a run): '[CE_LEVELUPDATE] 1 CE level mark value(s) found; 1 other text object(s) left unchanged.' and, with only the note picked, '[CE_LEVELUPDATE] None of the 1 selected text object(s) is a CE level mark value, so nothing was changed. Pick the level text of an FFL, RL, SSL or NGL mark made by CE.' with NO value prompt.
# #1885 writes the hidden CE tag on every new mark whatever the switch says (PR source guard), so the FFL mark drawn here is recognised by its tag, not by its shape.
# The note is typed with the _.TEXT chain (style Standard, point, height 250, rotation 0, text, closing Enter). It sits 1500 mm above the mark, well clear of its tail, and carries no CE tag.
# Windows: 29000,19000 to 35000,23000 holds the mark and the note. The second window 29500,21000 to 35000,23000 holds the note only. DIMSCALE is read and recorded: if it is not 100 the label sits nearer and still falls inside the first window.
# Remembered values: YES. FFL saves the last level-mark type into the Structural settings file; settings-arm restores every settings file by hash at the end.
# No U or REDO is driven (BUG-625's own Undo and Redo history is not part of this claim).
CASE W1885
TITLE Level Update (LMU) over a CE level mark and an ordinary note changes only the mark (12.345 becomes 10.500) and keeps the note; over the note alone it changes nothing and asks no value
PLAN_ITEM BUG-625 / B-065 part 1 (PR #1885) PART: the recognition half, switch ON, on a mark CE drew in this session (recognised by its tag). NOT whole: marks drawn by older builds (the shape rule), RL, SSL and NGL (only FFL is drawn), MTEXT, the approved Preview and Apply stage (not built), Undo and Redo, locked layer, Xref and REFEDIT protection, the Settings window tick box (a Codex look)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 910
TIMEOUT 900
BUG BUG-625
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED FFL at 30000,20000 (Right, value 12.345) prints '[FFL] Level mark created.'; the note GENERAL NOTE KEEP is placed at 30000,21500. LMU over both says 1 CE level mark value found and 1 other text left unchanged, asks for the value once, 10.500 is typed: the mark's text reads 10.500 and the note still reads GENERAL NOTE KEEP. LMU over the note alone says none of the 1 selected is a CE level mark value, asks for no value, and the note still reads GENERAL NOTE KEEP. LMU adds no object. No CE window is left open.
WHY_NOT_UNIT_TEST The unit tests judge the recognition rule on made-up inputs; only the live command shows that a mark CE just drew carries the tag the rule needs, and that the note survives the real selection and write.
NOT_AUTOMATED Marks drawn before the tag existed (the shape rule), RL, SSL, NGL, MTEXT notes, rotated or moved labels.
NOT_AUTOMATED Preview and Apply (not built in this PR), Undo and Redo, locked layer, Xref and REFEDIT.
NOT_AUTOMATED The Structural Settings window Annotation tab tick box "Level Update (LMU) only changes CE level marks": a window look for Codex (the Save button is refused). The switch-off behaviour is not run (the runner cannot set a Structural key; see set 22 FOR TIM item 5).
STEPS
  settings-arm
  copy-info -> $copy0
  getvar DIMSCALE -> $ds
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,24000" -Force
  wait
  ms-count -> $c0
  type "FFL{NL}30000,20000{NL}{NL}12.345" -Force -TimeoutSec 120 -> $ffl
  wait
  type "_.TEXT{NL}_S{NL}Standard{NL}30000,21500{NL}250{NL}0{NL}GENERAL NOTE KEEP{NL}" -Force -> $txt
  wait
  ms-new $c0 -> $made
  select $made "text~^12\.345$" -> $mark_pre
  field $mark_pre handle -> $mark_h
  select $made "text~^GENERAL NOTE KEEP$" -> $note_pre
  field $note_pre handle -> $note_h
  ms-count -> $c1
  type "LMU{NL}_W{NL}29000,19000{NL}35000,23000{NL}{NL}10.500" -Force -TimeoutSec 120 -> $lmu1
  wait
  ms-count -> $c2
  ms-new $c0 -> $after1
  select $after1 "handle={$mark_h}" -> $mark1
  field $mark1 text -> $mark_txt1
  select $after1 "handle={$note_h}" -> $note1
  field $note1 text -> $note_txt1
  type "LMU{NL}_W{NL}29500,21000{NL}35000,23000{NL}" -Force -TimeoutSec 120 -> $lmu2
  esc-prompt -> $lmu2_e
  wait
  ms-count -> $c3
  ms-new $c0 -> $after2
  select $after2 "handle={$note_h}" -> $note2
  field $note2 text -> $note_txt2
  windows-snapshot -> $win_end
ASSERT
  contains $ffl "Pick level point:"
  contains $ffl "Level value (e.g. +150, RL42.350, -50):"
  history has "[FFL] Level mark created."
  count $mark_pre = 1
  count $note_pre = 1
  contains $lmu1 "New level value:"
  history has "1 CE level mark value(s) found; 1 other text object(s) left unchanged."
  equals $mark_txt1 "10.500"
  equals $note_txt1 "GENERAL NOTE KEEP"
  equals $c2 $c1
  history has "None of the 1 selected text object(s) is a CE level mark value, so nothing was changed."
  history count "New level value:" = 1
  equals $note_txt2 "GENERAL NOTE KEEP"
  equals $c3 $c1
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $ds "DIMSCALE of the Structural master (the tail and text sizes follow it)"
  record $ffl "FULL what FFL printed"
  record $txt "FULL what the _.TEXT chain printed"
  record $lmu1 "FULL what LMU printed with the mark and the note"
  record $lmu2 "FULL what LMU printed with the note alone"
  record $lmu2_e "what the Esc after the second LMU printed"
  record $made "the two objects FFL and TEXT added (handle, layer, x, y)"
```

**Twin:** `W1885_BROKEN_lmu_claims_old_overwrite.case.txt`

```
# W1885_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Proves the note check can go red. A switch-off twin is NOT possible: the runner expands CS_Settings.json to %APPDATA%\TIM_CE_CADTOOLS, but Structural 1.0.125 reads %APPDATA%\CE_STRUC_SUITE\CS_Settings.json first (SettingsService.cs, CurrentSettingsFolderName), and that file exists. So this twin claims the OLD behaviour (BUG-625 as reported on 15 Oct): the note is overwritten and LMU says 2 labels updated. On the fixed build both claims are false, so the case MUST FAIL. The route checks (FFL prompts, mark reads 10.500) are kept and pass, which proves LMU ran.
CASE W1885_BROKEN
TITLE BROKEN VARIANT of W1885: claims the old fault (LMU overwrites the ordinary note with 10.500 and says 2 labels updated), must FAIL on the fixed build
PLAN_ITEM red-before-green proof for W1885 (BUG-625, PR #1885)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 911
TIMEOUT 900
BUG BUG-625
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1885
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the fix in, the note still reads GENERAL NOTE KEEP, so 'equals $note_txt1 "10.500"' fails, and the log has no 'Updated 2 level label(s).' line.
WHY_NOT_UNIT_TEST It exists only to prove W1885's note check can go red.
STEPS
  settings-arm
  getvar DIMSCALE -> $ds
  type "_.ZOOM{NL}_W{NL}28000,18000{NL}36000,24000" -Force
  wait
  ms-count -> $c0
  type "FFL{NL}30000,20000{NL}{NL}12.345" -Force -TimeoutSec 120 -> $ffl
  wait
  type "_.TEXT{NL}_S{NL}Standard{NL}30000,21500{NL}250{NL}0{NL}GENERAL NOTE KEEP{NL}" -Force -> $txt
  wait
  ms-new $c0 -> $made
  select $made "text~^12\.345$" -> $mark_pre
  field $mark_pre handle -> $mark_h
  select $made "text~^GENERAL NOTE KEEP$" -> $note_pre
  field $note_pre handle -> $note_h
  type "LMU{NL}_W{NL}29000,19000{NL}35000,23000{NL}{NL}10.500" -Force -TimeoutSec 120 -> $lmu1
  wait
  ms-new $c0 -> $after1
  select $after1 "handle={$mark_h}" -> $mark1
  field $mark1 text -> $mark_txt1
  select $after1 "handle={$note_h}" -> $note1
  field $note1 text -> $note_txt1
ASSERT
  contains $ffl "Pick level point:"
  count $mark_pre = 1
  count $note_pre = 1
  contains $lmu1 "New level value:"
  equals $mark_txt1 "10.500"
  equals $note_txt1 "10.500"
  history has "Updated 2 level label(s)."
  record $lmu1 "FULL what LMU printed"
  record $note_txt1 "what the ordinary note reads after LMU"
```

---

### Case 2 of 2: W1908, BARWEIGHT uses the bar catalogue mass (PR #1908, BUG-1129)

**Intended file:** `W1908_barweight_uses_bar_catalogue.case.txt`

```
# W1908 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1908 (B-088, BUG-1129), base claude/rel-20261026s (Structural 1.0.125). Switch Options.BarWeightUsesBarCatalogue, default ON.
# Route, read from RebarCommands.cs RunBarWeight on rel-20261026s: 'Bar size [n12/n16/.../?] <default>: ' (a keyword; the tag is typed), 'Bar length (mm) <default>: ', 'Quantity <default>: ', then the result line '<tag> x <length>mm x <qty> bars = <weight, one decimal> kg' (the times sign is a non-ASCII character, so the checks start at 'bars = '), then 'Place result in drawing? [Yes/No] <No>: ' answered No, so nothing is drawn. BARWEIGHT saves the last size, length and quantity into the Structural settings file; settings-arm puts it back.
# Figures (DERIVED from the PR text, not seen on a run): 100 N20 at 6 m = 1479.6 kg now (1482.0 kg before). 50 N16 at 12 m = 946.8 kg now (948.0 kg before). N40, R6 and R10 are not in the bar catalogue: BARWEIGHT keeps the built-in mass and prints 'Note: N40 is not in the bar catalogue, so BARWEIGHT used its built-in mass of <x> kg/m; the bar schedule shows this size as UNKNOWN.' (x not known before the run, so the case checks the two ends of the line).
# UNCONFIRMED: that N40 is in BARWEIGHT's size list on this build (the PR says it is). If the keyword is refused the case FAILS at the N40 note check and the recorded $t_40 shows why.
# Remembered values: YES (settings-arm covers it). Nothing is drawn.
CASE W1908
TITLE BARWEIGHT gives 1479.6 kg for 100 N20 at 6 m and 946.8 kg for 50 N16 at 12 m (the bar schedule's figures, not the older 1482.0 and 948.0), and notes that N40 is not in the bar catalogue
PLAN_ITEM BUG-1129 / B-088 PART: the BARWEIGHT figures with the switch ON (two sizes in the catalogue, one not). NOT whole: that the bar SCHEDULE shows the same two figures (the schedule is a window or a placed table and was not read here; the schedule's figures are taken from the PR text), the switch-off behaviour (the runner cannot set a Structural key), the R6 and R10 sizes
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 912
TIMEOUT 600
BUG BUG-1129
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED BARWEIGHT N20, 6000 mm, 100 bars prints '... bars = 1479.6 kg'. BARWEIGHT N16, 12000 mm, 50 bars prints '... bars = 946.8 kg'. Neither prints the older 1482.0 kg or 948.0 kg and neither prints the 'not in the bar catalogue' note. BARWEIGHT N40, 6000 mm, 10 bars prints one note that N40 is not in the bar catalogue and the schedule shows it as UNKNOWN. No object is added, the drawing file on disk does not change, no CE window is left open.
WHY_NOT_UNIT_TEST The unit tests judge the mass rule with made-up inputs; only the real command in AutoCAD shows which table the live BARWEIGHT actually reads and what it prints.
NOT_AUTOMATED The bar schedule figures themselves (a window or a placed table; taken from the PR text, not read).
NOT_AUTOMATED The Settings tick box "BARWEIGHT uses the same bar masses as the bar schedule" and the switch-off figures (1482.0 kg): the runner cannot set a Structural key, so Codex looks at the box.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "BARWEIGHT{NL}N20{NL}6000{NL}100{NL}No" -Force -TimeoutSec 120 -> $t_20
  wait
  type "BARWEIGHT{NL}N16{NL}12000{NL}50{NL}No" -Force -TimeoutSec 120 -> $t_16
  wait
  type "BARWEIGHT{NL}N40{NL}6000{NL}10{NL}No" -Force -TimeoutSec 120 -> $t_40
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  contains $t_20 "Bar size"
  contains $t_20 "Place result in drawing?"
  history count "bars = 1479.6 kg" = 1
  history count "bars = 946.8 kg" = 1
  history absent "bars = 1482.0 kg"
  history absent "bars = 948.0 kg"
  history count "so BARWEIGHT used its built-in mass of" = 1
  history has "Note: N40 is not in the bar catalogue"
  history has "the bar schedule shows this size as UNKNOWN."
  equals $c1 $c0
  copy-unchanged $copy0
  not-contains $win_end "Creative Engineering"
  record $t_20 "FULL what BARWEIGHT printed for N20"
  record $t_16 "FULL what BARWEIGHT printed for N16"
  record $t_40 "FULL what BARWEIGHT printed for N40 (the note text and the built-in kg/m are not known before this run)"
```

**Twin:** `W1908_BROKEN_barweight_claims_old_figures.case.txt`

```
# W1908_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Proves the figure checks can go red. A switch-off twin is NOT possible (runner cannot set a Structural key; Structural reads CE_STRUC_SUITE\CS_Settings.json first, the runner writes TIM_CE_CADTOOLS). So this twin claims the OLD figures (1482.0 kg and 948.0 kg, BARWEIGHT's own older table). On the fixed build BARWEIGHT prints 1479.6 and 946.8, so the case MUST FAIL. The route checks (the two prompts are reached, a result line prints) are kept and pass.
CASE W1908_BROKEN
TITLE BROKEN VARIANT of W1908: claims the older BARWEIGHT figures 1482.0 kg and 948.0 kg, must FAIL on the fixed build
PLAN_ITEM red-before-green proof for W1908 (BUG-1129, PR #1908)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 913
TIMEOUT 600
BUG BUG-1129
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1908
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the fix in, BARWEIGHT prints 1479.6 kg and 946.8 kg, so 'history has "bars = 1482.0 kg"' and 'history has "bars = 948.0 kg"' fail.
WHY_NOT_UNIT_TEST It exists only to prove W1908's figure checks can go red.
STEPS
  settings-arm
  ms-count -> $c0
  type "BARWEIGHT{NL}N20{NL}6000{NL}100{NL}No" -Force -TimeoutSec 120 -> $t_20
  wait
  type "BARWEIGHT{NL}N16{NL}12000{NL}50{NL}No" -Force -TimeoutSec 120 -> $t_16
  wait
  ms-count -> $c1
ASSERT
  contains $t_20 "Bar size"
  contains $t_20 "Place result in drawing?"
  equals $c1 $c0
  history has "bars = 1482.0 kg"
  history has "bars = 948.0 kg"
  record $t_20 "FULL what BARWEIGHT printed for N20"
  record $t_16 "FULL what BARWEIGHT printed for N16"
```

---

## 3. Codex look notes (the four fixes marked BLOCKED-FOR-ROBOT)

Rules for every look below: use a copy of a drawing only, never Tim's live job drawing. Take a screenshot of each step. Save evidence under `C:\CE_WORK\codex\<folder named below>\`. Never accept or capture a folder that a file box opened in. A look is a PASS only if every "right looks like" line is seen; anything else is written down as seen. None of these may unlock a layer, detach or unload an Xref, or press a refused button.

### 3.1 #1931, BUG-613: moving only part of an RC beam or column detail (BLOCKED-FOR-ROBOT; Opus review first: Undo)

**Why not the robot:** RCBEAM opens a beam type picker window and a data-entry window; RCRECTCOL opens a data-entry window. The robot's press list does not include them and it may not fill them.

**Evidence folder:** `C:\CE_WORK\codex\W1931_rc_move_warning\`

1. Open a copy of the Structural test drawing. Confirm the switch is ON: Structural Settings window, the RC detail tick box about warning when only part moves, ticked. (Default ON.) Cancel the window.
2. Type RCBEAM. Pick any beam type in the picker, press its OK, fill the size window with 300 wide and 600 deep (or any values), press OK, click an insertion point. Right looks like: the command prints "RCBEAM: ... placed." and a beam outline with bars and a ligature appears.
3. Type MOVE. Click ONLY the outline line of the beam (one click, then Enter), pick a base point, then move it about 500 mm to the right. Right looks like: the command line prints one plain line saying the rest of the detail did not move, and ending with "Press U to undo" (the exact words are DERIVED from the PR, not seen: record what is really printed). The outline moved; the bars and ligature stayed. Nothing blocked.
4. Type U once. Right looks like: the outline goes back and the detail is whole again.
5. Type MOVE again, but this time window-select the WHOLE beam detail (outline, bars, ligature, labels, dimensions), and move it 500 mm. Right looks like: it all moves together and NO warning line is printed.
6. Repeat 2 to 5 once with RCRECTCOL (column).
7. Write down: the exact warning line, the number of pieces that moved, and the screenshots of 3, 4 and 5.
8. **Not covered:** the switch OFF behaviour (nothing printed), details drawn by older builds (no tag, so no warning), RCCIRCCOL, ROTATE, COPY, ERASE.

### 3.2 #1901, BUG-616: XRL says how many Xrefs will move and waits for Apply (BLOCKED-FOR-ROBOT; Opus review first: Xrefs)

**Why not the robot:** it needs a drawing with Xrefs attached, which is a second drawing, and the robot may not attach, detach, unload or unlock anything.

**Evidence folder:** `C:\CE_WORK\codex\W1901_xrl_confirm\`

1. Use a copy of a drawing that ALREADY has at least two Xrefs on layers that are not locked. If none exists, stop and write that down; do not attach one yourself.
2. Read the layer list before: which layer each Xref is on and whether it is locked. Screenshot.
3. Type XRL. Right looks like: the counts print, the Xrefs highlight, and the command asks "N Xref instances will move to layer XREF. Apply or Cancel?" with the right count N (the wording is DERIVED from the PR, record what is really printed). Screenshot.
4. Answer Cancel (type C). Right looks like: "Cancelled. Nothing was changed.", the Xrefs are still on their old layers, and NO layer called XREF was created. Screenshot the layer list.
5. Type XRL again and press Enter. Right looks like: Enter means Apply, the Xrefs move to layer XREF.
6. Type U. Right looks like: the Xrefs are back on their old layers.
7. Type XRLFAST. Right looks like: it never asks, it moves at once.
8. **Locked layer check (only if a copy already has a locked-layer Xref; never lock one yourself):** XRL must stop first with its locked-layer line. Nothing unlocked.
9. **Not covered:** Xrefs in other layouts, overlays, the switch OFF behaviour.

### 3.3 #1929, BUG-1262: Publish Issue with nothing ticked (BLOCKED-FOR-ROBOT)

**Why not the robot:** the Publish button is on the robot's never-press list (README: "never a Save, Delete, Publish, Send, Reset or Restore button").

**Evidence folder:** `C:\CE_WORK\codex\W1929_publish_issue_nothing_ticked\`

1. Use a COPY of a project or drawing set that CESHEETS can open, with at least two managed sheets. Note the folder where issues would be written and list it (screenshot of the listing before).
2. Open CESHEETS. Untick "include in issue" on every sheet. Screenshot.
3. Choose Publish Issue PDF. Right looks like: the Publish button is NOT greyed, and the preview line reads that nothing is ticked, nothing will be plotted, no revision will change, and "no sheets" will be recorded in the issue history (DERIVED from the PR; record the exact words). Screenshot.
4. Press Publish. Right looks like: ONE plain warning box ("Nothing is ticked, so nothing was plotted and no sheet revision or date was changed. The issue is recorded in the issue history as "no sheets"." per the PR; record the exact words), and nothing is plotted. Screenshot the box, then press OK.
5. List the issue folder again. Right looks like: no new folder, no new PDF.
6. Open the issue history. Right looks like: one new row reading "no sheets" with today's date. Every sheet's revision and date are unchanged (compare with a screenshot from step 2).
7. Repeat from the Sheets Manager with Create Issue. Right looks like: the same warning and one more "no sheets" row.
8. Tick one discipline and leave its revision blank. Right looks like: it still asks for a revision for that discipline (not covered by this fix).
9. Open Publish Issue again after the "no sheets" row exists and leave the revision blank. Right looks like: it skips the "no sheets" row and either publishes the earlier real issue or says "Create an issue snapshot first", with no error box.
10. **Not covered:** the switch OFF behaviour (old refusal).

### 3.4 #1899, BUG-1139, BUG-1204 and BUG-1162 (BLOCKED-FOR-ROBOT for all three)

**Why not the robot:** BUG-1204 needs close without saving and reopen inside one case (the case format cannot do that). BUG-1162 needs a drawing holding a damaged saved point-load list, which the robot cannot make without typed LISP (it wedges AutoCAD). BUG-1139 would need the beam and column commands' route; I did not read it, so I did not draft a robot case. A robot case for BUG-1139 may be possible later: the CE log line is readable with `log-read struc`.

**Evidence folder:** `C:\CE_WORK\codex\W1899_links_and_loads\`

BUG-1139 (copied beam):
1. On a copy of a drawing with one CE beam that already has a label and columns (do not make a new job drawing), type COPY, pick the beam, copy it 3000 mm sideways. Screenshot.
2. With the CE column command, place a column at the end of the COPIED beam. Right looks like: the copied beam gets its own empty link record; the original beam's label and columns are untouched and did not move or rename. Screenshot both beams.
3. Open the CE log for the session. Right looks like: a line that beam <handle> carried the record of beam <handle> (a copy), so it starts with an empty record of its own (DERIVED from the PR; record the real line).

BUG-1204 (discarded open):
4. Open a copy of an OLD drawing (one made before beam links) so CE converts its links. Close it WITHOUT saving. Reopen it. Right looks like: the conversion runs again and the labels are linked (before the fix, the second open left them unlinked).

BUG-1162 (damaged point-load list):
5. Only if a copy of a drawing with a damaged saved point-load list already exists (ask the desk; do not damage one yourself): type CSPOINTLOAD. Right looks like: one plain line refusing because a saved group is damaged, nothing drawn, and the saved list untouched (the "keep a copy of the damaged list" line may appear). If no such copy exists, write "no damaged-list copy, not looked at".

**Not covered:** the three switches OFF.

---

## 4. Fixes skipped and why

1. **None skipped as "already has a case".** Set 09's W1879 covers the same BUG-625 fix for a different PR (#1879, opened on the wrong release line), so W1885 is drafted for the right PR and the overlap is named in FOR TIM item 6.
2. **Not drafted as robot cases (BLOCKED-FOR-ROBOT):** #1899, #1901, #1929, #1931. Reasons are in FOR TIM item 3 and each Codex look.
3. **#1931 and #1901 are flagged for an Opus review before they are run**, because they touch Undo (#1931) and Xrefs (#1901).

---

## 5. What was read, built, tested, and NOT proven

1. **Read:** the files listed in section 1, the six PR descriptions and diffs, and the Structural code at `origin/claude/rel-20261026s` for the BARWEIGHT, Level Update and settings paths.
2. **Built:** nothing.
3. **Tested:** nothing. The robot was not run, AutoCAD was not opened, and the offline validator was not run (it needs the case files on disk and I may only write this one file).
4. **NOT proven:** that any of the four case texts is valid in the runner; that the Structural module is loaded in the robot's AutoCAD; that any printed line or figure is what AutoCAD really prints (all DERIVED from PR text or code); that N40 is in BARWEIGHT's size list; that the bar schedule shows 1479.6 and 946.8 (taken from the PR text); and none of the six bugs is fixed. All six stay open until a robot PASS plus a Codex PASS (or an accepted Claude PASS) is on record.
5. **Not done:** `BUG_CARPARK.md` was not edited. The desk may want one line under each bug: "robot case drafted 2 Nov 2026, not run" (W1885 for BUG-625, W1908 for BUG-1129).
