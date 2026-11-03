# Robot case drafts, set 09: long section, Level Update and start-up checks (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** One robot case with its failing twin (W1879 and W1879_BROKEN) written as plain text below, with the file name each should get. The other four fixes cannot be proved by the robot and have a numbered Codex look instead. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `git fetch`, `gh pr view` and `gh pr diff`).

---

## FOR TIM

1. **1 robot case with its twin drafted** (2 case texts): W1879, Level Update (LMU) changes only a real CE level mark and leaves an ordinary note alone. It draws a level mark and a note, runs LMU over both, and checks only the mark changed. The twin turns the fix's switch off before AutoCAD starts and must fail (the note gets overwritten).
2. **Codex-only (4 fixes):** #1938 (curved boundary in the long section), #1939 (long section reads only survey-layer levels), #1957 (CDMENU and Repair check the menu is loaded) and #1959 (CDASK From file no longer offers PDFs). Exact steps are in the Codex look notes below.
3. **Why the long section is Codex-only.** The robot's AutoCAD has no survey Xref in any test drawing, and it is not allowed to press Preview New or Apply in the Profiles window, so it cannot draw a long section at all. It also may not create an Xref (a second drawing).
4. **Why #1957 and #1959 are Codex-only.** Both fixes exist only in the AutoCAD 2022 to 2024 build. The robot's AutoCAD is 2027 only (the Autodesk folder on this PC holds AutoCAD 2027 and nothing else), so nothing on it can show them. The file picker in #1959 is also a window the robot may not drive.
5. **Needs an Opus review before it is run:** none of the five touches a locked layer, an Xref or REDO. W1879 does not press U. One caution for the desk: drawing a level mark makes the Structural plugin write its own settings file, so the run must use the runner's settings guard (the case does, with `settings-arm`).
6. **What I could not verify (plainly).** (a) Whether the Structural plugin is loaded in the robot's AutoCAD on the Structural test drawing: assumed from earlier Structural cases. (b) Whether the runner's settings guard can switch a Structural setting off at all: no existing case does it (see the note under W1879_BROKEN). (c) Every command-line line below was read from the PR text, not seen on a run: all marked DERIVED.
7. **A correction to the brief.** PR #1879 changes `Modules/Structural` files (LevelMarkCommands.cs, the Structural Settings window), not Civil ones, although it is on the Civil/Manager release line. Its Structural twin #1885 is a different branch: its report says new marks now carry the hidden tag whatever the switch says. #1879 as it stands writes the tag only when the switch is ON; the twin's route below depends on that, so re-check it if #1885's change is merged into #1879's line.
8. **Nothing for you to test or decide.**

---

## 1. How the drafts were written (read before validating)

1. **Read first:** `C:\TimOS\RULES.md`; `README_CASES.md` in full (header, steps, checks, the refused-press rules); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (to the end of case 8); the opening of `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`; the existing cases R28 and `variants\R09s_new_switch_off_broken`; the draft N55 (same long-section start); and the Structural proof draft S467a for the Structural fixture.
2. **Per fix:** `gh pr view` and `gh pr diff` (all five), the carpark entries (BUG-765, BUG-625, BUG-1193, BUG-1211, BUG-1214), the REGRESSION_LOG entries inside the diffs, and `BUGFIX_n15_REPORT_31OCT.md` and `BUGFIX_fx1885_REPORT_31OCT.md`. I found no BUGFIX report that names #1938 or #1939 (by PR or bug number).
3. **Re-checked that no case or draft exists** (the earlier search matched the bug number as text only). I searched the cases folder (main, `variants`, `_setups` and all 21 `drafts_*` folders) for the commands (CDPROFILE, CDMENU, CDASK, LMU, FFL), the bug numbers, the PR numbers, the switch names and the words "Level Update" and "boundary"; all ten `ROBOT_CASE_DRAFTS_*.md` files; and `runner-reports\ledger.json`. Results: R28 and `variants\R28_broken` (the start of CDPROFILE only) and the drafts N55 and N55_BROKEN (the Profiles window buttons only) are the only long-section cases; none of them touches any of the five fixes. No case or draft exists for the five. The ledger holds no W-numbered case at all.
4. **Format:** exactly the README format. Case ids W1879 and W1879_BROKEN, order numbers 780 and 781, `SLOT fresh`, REVIEWED_AGAINST left empty, every type chain a complete command with no `(` and no SAVE-type word.
5. **Fixture:** DRV2_S1 (the Structural test copy, used by the S467 drafts), not DRV1_B1, because the fix is in the Structural plugin and the layers and fixture belong to it. If the runner cannot run a Structural command on DRV1_B1 or DRV2_S1, the first run says so and the case comes back BLOCKED, not FAIL.
6. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set09_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
7. **Nothing here unlocks a layer, detaches an Xref or bypasses any protection.** The case only draws two ordinary objects on the current layers and runs LMU on them.

---

## 2. The case

### Case 1 of 1: W1879, Level Update changes the CE level mark and leaves an ordinary note (PR #1879, BUG-625)

**Intended file:** `W1879_lmu_only_changes_ce_level_mark.case.txt`

```
# W1879 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1879 (B-065, BUG-625), base claude/rel-20261102a. Structural commands.
# Carpark BUG-625 (15 Oct 2026, real AutoCAD, Structural 1.0.116): LMU on an ordinary note GENERAL NOTE KEEP, value 10.500, replaced the note's whole text and said 'Updated 1 level label(s)'.
# Route, from LevelMarkCommands.cs (read in the PR diff): FFL asks 'Pick level point: ', then 'Side [Left/Right] <Right>: ' (Enter = Right), then 'Level value (e.g. +150, RL42.350, -50):', and prints '[FFL] Level mark created.' LMU asks 'Select level value text to update: ' (TEXT and MTEXT only), then 'New level value:'.
# New lines with the switch ON (DERIVED, read from the PR diff, not seen on a run): '[CE_LEVELUPDATE] 1 CE level mark value(s) found; 1 other text object(s) left unchanged.' and '[CE_LEVELUPDATE] Updated 1 level label(s).'; with only the note picked '[CE_LEVELUPDATE] None of the 1 selected text object(s) is a CE level mark value, so nothing was changed. Pick the level text of an FFL, RL, SSL or NGL mark made by CE.' and NO value prompt.
# The note is typed with the _.TEXT chain that an existing case uses (style Standard, point, height, rotation, text, closing Enter). It sits 1500 mm above the mark and well clear of its tail, so the older 'looks like a mark' rule cannot claim it; it also carries no CE tag.
# Marks are drawn with FFL while the switch is ON (default), so the label carries the hidden CE tag (DERIVED: tag written only with the switch ON on this PR).
# Windows: 29000,19000 to 35000,23000 holds the mark (label near 31200 to 32100, y 20000, if DIMSCALE is 100) and the note (30000 to about 33400, y 21500 to 21750). The second window 29500,21000 to 35000,23000 holds the note only. DIMSCALE is read and recorded: if it is not 100 the label sits nearer and still falls inside both windows.
# Remembered values: YES. FFL saves the last level-mark type into the Structural settings file (LevelMarkDefaultType); settings-arm restores every settings file by hash at the end.
# No U or REDO is driven (BUG-625's own Undo and Redo history is not part of this claim).
CASE W1879
TITLE Level Update (LMU) over a CE level mark and an ordinary note changes only the mark (12.345 becomes 10.500) and keeps the note; over the note alone it changes nothing and asks no value
PLAN_ITEM BUG-625 / B-065 part 1 (PR #1879) PART: the recognition half, switch ON, on a mark that CE drew in this session. NOT whole: marks drawn before the tag existed (the older rule), RL, SSL and NGL (only FFL is drawn), the approved Preview and Apply stage (not built), Undo and Redo, locked layer, Xref and REFEDIT protection, the Settings window tick box (a Codex look)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 780
TIMEOUT 900
BUG BUG-625
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED FFL at 30000,20000 (Right, value 12.345) prints '[FFL] Level mark created.'; the note GENERAL NOTE KEEP is placed at 30000,21500. LMU over both says 1 CE level mark value found and 1 other text left unchanged, asks for the value once, 10.500 is typed: the mark's text reads 10.500 and the note still reads GENERAL NOTE KEEP. LMU over the note alone says none of the 1 selected is a CE level mark value, asks for no value, and the note still reads GENERAL NOTE KEEP. LMU adds no object. No CE window is left open.
WHY_NOT_UNIT_TEST The unit tests judge the recognition rule on made-up inputs; only the live command shows that a mark CE just drew carries what the rule needs, and that the note really survives the real selection and write.
NOT_AUTOMATED Marks drawn before the tag existed (older rule), RL, SSL, NGL, MTEXT notes, rotated or moved labels.
NOT_AUTOMATED Preview and Apply (not built in this PR), Undo and Redo, locked layer, Xref and REFEDIT.
NOT_AUTOMATED The Structural Settings window's Annotation tab tick box "Level Update (LMU) only changes CE level marks": a window look for Codex (the Save button is refused).
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
  not-contains $win_end "Creative Engineering"
  record $ds "DIMSCALE of the Structural master (the tail and text sizes follow it)"
  record $ffl "FULL what FFL printed"
  record $txt "FULL what the _.TEXT chain printed"
  record $lmu1 "FULL what LMU printed with the mark and the note"
  record $lmu2 "FULL what LMU printed with the note alone"
  record $lmu2_e "what the Esc after the second LMU printed"
  record $made "the two objects FFL and TEXT added (handle, layer, x, y)"
```

**Twin:** `W1879_BROKEN_lmu_switch_off.case.txt`

```
# W1879_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off control for PR #1879's own switch, in the style of cases\variants\R09s_new_switch_off_broken.case.txt: LevelUpdateOnlyChangesCeLevelMarks is false BEFORE AutoCAD starts (settings are read at AutoCAD start; a mid-case change does nothing).
# With the switch OFF, LMU is the old code path (PR text: 'OFF = the old behaviour exactly: every selected text is rewritten and no tag is written on new marks'). The note is overwritten with 10.500, so the check that the note still reads GENERAL NOTE KEEP MUST FAIL. The route checks (FFL prompts, the mark reads 10.500) still pass, which proves LMU ran.
# DERIVED, NOT SEEN: the settings key path 'Annotation.LevelUpdateOnlyChangesCeLevelMarks' in CS_Settings.json (the PR's unit test reads the JSON as {"Annotation":{"LevelUpdateOnlyChangesCeLevelMarks":false}}). No existing case sets a Structural (CS_) key; README batch 1 item 2 says the bare name CS_Settings.json is expanded to %APPDATA%\TIM_CE_CADTOOLS. If the runner's settings guard refuses the key, this twin comes back BLOCKED, not FAIL: say so in the report and use the Codex fallback (Settings window, Annotation tab, untick the box, restart AutoCAD) rather than writing the file by hand.
# Do NOT use hashes-unchanged here: the guard holds the settings file different while the case runs (README batch 1 item 2).
CASE W1879_BROKEN
TITLE BROKEN VARIANT of W1879: the Level Update switch OFF, so LMU rewrites the ordinary note as before (must FAIL: the note is overwritten with 10.500)
PLAN_ITEM red-before-green proof for W1879 (BUG-625, PR #1879's own switch)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
SETTING CS_Settings.json Annotation.LevelUpdateOnlyChangesCeLevelMarks false
ORDER 781
TIMEOUT 900
BUG BUG-625
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1879
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the whole selection is rewritten, so the note reads 10.500 and 'equals $note_txt1 "GENERAL NOTE KEEP"' fails; FFL, the mark reading 10.500 and the object count pass.
WHY_NOT_UNIT_TEST It exists only to prove W1879's note check can go red on the old behaviour.
STEPS
  settings-arm
  copy-info -> $copy0
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
  history has "[FFL] Level mark created."
  count $mark_pre = 1
  count $note_pre = 1
  equals $mark_txt1 "10.500"
  equals $note_txt1 "GENERAL NOTE KEEP"
  record $note_txt1 "what the note reads after LMU with the switch OFF (expected 10.500)"
  record $lmu1 "FULL what LMU printed with the switch OFF"
```

---

## 3. Codex look notes (the robot cannot prove these)

Rules for every look below: work on copies only, in an evidence folder under `C:\CE_WORK\codex\<job id>\`, a screenshot after each numbered step, never accept or capture a folder the box opened in, never edit Tim's own drawings or his real settings files by hand. A switch is changed only through the runner's settings guard or the Settings window and then AutoCAD is restarted (settings are read when AutoCAD starts).

### 3.1 BLOCKED-FOR-ROBOT: #1938 (BUG-1193), a curved boundary is followed along its curve

**Why the robot cannot:** it must draw the long section to see the mark (Preview New or Apply in the Profiles window, which are not on the press list), and it needs a survey Xref holding a curved boundary (no test drawing has an Xref; making one needs a second drawing).

1. **Needs an Opus look first:** none (it reads an Xref; it never changes one). Codex creates the Xref file itself in its own folder.
2. **Set up (Codex's own copy):** in a new drawing in `C:\CE_WORK\codex\b1193\`, draw an open polyline on a layer called BOUNDARY from 5000,-5000 to 5000,5000 with the first segment's bulge set to +1 (a half circle). Save it there as survey.dwg (Codex's own file, in Codex's own folder).
3. **Main drawing:** a copy of a drawing with two connected CE pits and a pipe between them that runs across the boundary at y 0 (the Structural/Civil robot masters have this; use a copy). Attach survey.dwg as an Xref at 0,0 on that copy.
4. **Run:** type `CDPROFILE`, click the first pit, pick the route, enter a datum, press Preview New and then Apply (Codex may press these; the robot may not), pick an insertion point.
5. **Right looks like:** the boundary mark on the drawn long section is 10.00 m from the first pit (where the curve really crosses the pipe), not 5.00 m (the straight chord). Screenshot of the section with the mark and the measured distance.
6. **Twin look:** start AutoCAD with `survey.longSectionBoundaryFollowsCurves` false (through the settings guard), repeat steps 4 and 5. Right looks like for the old behaviour: 5.00 m. If it still reads 10.00 m, the switch did not reach the code (report that).
7. **Not proved even then:** arcs other than a bulge polyline segment (an ARC entity) unless Codex also draws one: repeat step 2 with an ARC and say so.

### 3.2 BLOCKED-FOR-ROBOT: #1939 (BUG-765), the ground line reads only survey-layer levels

**Why the robot cannot:** the same two reasons as 3.1 (no survey Xref; the section cannot be drawn).

1. **Needs an Opus look first:** none.
2. **Set up (Codex's own copy):** a drawing in `C:\CE_WORK\codex\b765\` with plain level texts along the route: 19.20 on a layer called SURVEY-LEVELS at three places, and one text 18.60 on a layer called PIT INVERTS between two of the covers. Save as survey.dwg and attach it as an Xref to a copy of a two-pit drawing as in 3.1.
3. **Run:** `CDPROFILE`, first pit, route, datum, Preview New (and Apply if the existing-surface line only shows after it).
4. **Right looks like:** the existing-surface (ground) line stays level at 19.20 m with no dip to 18.60; the command line shows: `[CE] 1 plain number in the survey XREF (on layer "PIT INVERTS") was not used as ground levels, because that layer is not a survey layer.` (DERIVED from the PR text; copy the exact line seen).
5. **Fallback check:** rename every layer in survey.dwg to something no word list knows (for example `Z9`) and repeat: the line should say `[CE] The survey XREF's level texts are not on a layer CE recognises as a survey layer, so all <n> were used as before. Add your survey layer's name to the survey layer words in Settings if the surface line looks wrong.` and the ground line reads every text as before (DERIVED).
6. **Twin look:** start AutoCAD with `survey.longSectionSurveyLevelsOnSurveyLayersOnly` false; step 3 should then show the old dip to 18.60 and no `[CE]` line.
7. **Open question for Tim, not for the case:** the PR asks whether the shipped survey layer words (SURVEY, SURV, SPOT, LEVEL, LVL, RL, HEIGHT, ELEV, TOPO, GROUND, NSL, ESL, TIN, DTM, CONTOUR; and PIT, PIPE, DRAIN, INVERT, IL, STORM, SEWER, SW that override them) are right for his office's survey Xrefs. That is his word, not a test.

### 3.3 BLOCKED-FOR-ROBOT: #1957 (BUG-1211), CDMENU and Repair on AutoCAD 2022 to 2024 check the Civil menu is loaded

**Why the robot cannot:** the fix is inside `#if NET48` (the 2022 to 2024 lane); the robot's AutoCAD is 2027, which runs the other branch and prints the ribbon rebuild line instead. Also CUILOAD is a window with a file and group list. If a 2022, 2023 or 2024 AutoCAD with the CE Civil plugin installed is not available, this stays UNPROVEN: say so; do not substitute 2027.

1. **Needs an Opus look first:** none. (CUILOAD unloads a menu group; it touches no drawing, no layer and no Xref.)
2. **Run, on AutoCAD 2024 (then repeat the Repair part on 2022 and 2023), switch ON (default):** type `CDMENU`. Right looks like: `[CE] The Civil menu is loaded.` (the new wording without "If it is still hidden, restart AutoCAD." when AutoCAD confirms the group is loaded).
3. **Unload:** type `CUILOAD`, in the list choose CE_CVL_SUITE_MENU and click Unload, then Close. Screenshot the list showing it gone.
4. **Run `CDMENU` again.** Right looks like: the Civil menu is back on the menu bar and CUILOAD (open it again) lists CE_CVL_SUITE_MENU as loaded, and the line says `[CE] The Civil menu is loaded.` Wrong: the line says loaded and the group is still missing in CUILOAD (the old fault).
5. **Repair part:** unload the group again with CUILOAD, open the CE Repair window (command `CDREPAIR`), and read its menu line. Right looks like: it does not say `CE Civil tools are loaded.` while the group is unloaded (DERIVED wording from the PR text; copy the exact line). Then press its Restore button on a copy-safe drawing and read the line again.
6. **Switch-off twin:** start AutoCAD with `install.restoreMenuChecksLoadedGroup` false and repeat steps 3 and 4. Right looks like for the old behaviour: the old line `The Civil menu is loaded. If it is still hidden, restart AutoCAD.` and the group stays missing.
7. **Open risk to record:** whether each year returns the group name CE_CVL_SUITE_MENU from AutoCAD's loaded-groups list is not known. If CE prints `The Civil menu was loaded again, but AutoCAD did not confirm it...`, copy that line: it is the "AutoCAD cannot say" path, not a pass.

### 3.4 BLOCKED-FOR-ROBOT: #1959 (BUG-1214), CDASK From file no longer offers PDFs the older AutoCAD always rejects

**Why the robot cannot:** the fix is on the 2022 to 2024 lane only, and "From file..." opens a Windows file picker (the robot may not drive a file picker).

1. **Needs an Opus look first:** none.
2. **Run, on AutoCAD 2024:** type `CDASK`, click "From file...". The picker opens: do not choose any file yet. Open the file-type list at the bottom of the box and screenshot the list.
3. **Right looks like:** only image types (PNG, JPG) and "All files"; no entry that mentions PDF. Wrong (the old fault): a PDF entry in the list.
4. **Typed-in check:** with "All files" chosen, pick a copy of a one-page PDF kept in `C:\CE_WORK\codex\b1214\` (Codex's own folder; the picker's start folder is not evidence and its path must not be captured). Right looks like: the sentence `PDF support requires AutoCAD 2025 or later.` still appears (a PDF through All files is still turned away, as the PR says).
5. **Wording check (optional):** pick a copy of a text file through All files. Right looks like: `Unsupported file type '.txt' — pick a PNG or JPG file.` (DERIVED from the PR text; copy the exact line).
6. **Switch-off twin:** start AutoCAD with `ai.markupFilePickerMatchesLane` false and repeat step 2. Right looks like for the old behaviour: the PDF entry returns, and the unsupported-type sentence says PNG, JPG, or PDF.
7. **2025 and later:** repeat step 2 on any 2025 to 2027 AutoCAD if one is available: the list must be unchanged (images and PDF). The robot's 2027 can do this part (the picker is a window, so it is still a Codex look).

---

## 4. Skipped, and why

1. **Not drafted as robot cases:** #1938, #1939, #1957 and #1959. Each has a Codex look above. Each says in one line why the robot cannot prove it (3.1 to 3.4).
2. **Not skipped because of an existing case:** I found no existing case or draft for any of the five (see 1.3). R28 and the draft N55 reach only the Profiles window and are not a proof of #1938 or #1939.
3. **Fewer than the five cases the brief allowed.** The robot-provable set is one fix; I did not pad it. A second #1879 case with RL, SSL and NGL marks would be possible (each type drawn with its own FFL-style command) but would repeat the same route; it is left for after W1879 passes.

---

## 5. What was read, built, tested and NOT proven

1. **Read:** the documents listed in 1.1 and 1.2, the five PR texts and diffs, the five carpark entries, the two bugfix reports, the cases and drafts folders, the ledger and the Autodesk folder list on this PC.
2. **Built:** nothing. **Tested:** nothing. **Opened in AutoCAD:** nothing. **Changed:** only this file.
3. **NOT proven:** that either W1879 text validates or runs; that FFL, _.TEXT and LMU chains end exactly as typed (the closing Enter and the in-place text editor may need one fix on the first run); that the Structural plugin loads on DRV2_S1 in the robot's AutoCAD; that the settings guard can set a Structural key; that any `[CE]` or `[CE_LEVELUPDATE]` line below the PR text is worded as printed. Nothing about the four Codex-only fixes has been seen on any AutoCAD.
