# Robot case drafts, set 02: cover, pit drop and checking messages (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Case drafts for six fix PRs heading for `origin/claude/rel-20261102a` (head 3fbb9da5, Civil 3.0.88), written as plain text below with the file name each should get. Nothing was run, built, installed or opened in AutoCAD. No case file was created in the cases folder; this is the only file written. No git write (only `git fetch`, `gh pr view` and `gh pr diff`).

---

## FOR TIM

1. **Done: 2 robot tests drafted, each with a deliberately wrong twin (4 case texts).** W1949 (a pit where the pipe leaving is bigger and its top sits above the pipe arriving) and W1890 (CDRULEBOOK says "Not saved" when CE did not save).
2. **Example.** W1949 places a 150 pipe arriving at a pit and a 225 pipe leaving it, runs CDRULES, and checks CE says "outlet pipe top is 45 mm above the inlet pipe top". The twin turns the new switch off before AutoCAD starts and must fail.
3. **Four fixes are Codex-only, none is a robot case:** #1882 (lid at RL 0.000, design window), #1897 with #1920 (cover screens: Inspector, Civil Hub), #1962 (Inspector grade colour) and #1889 (CDRENUMBER with no outlet). One line of reason each, and exact Codex steps, are in section 4.
4. **One case needs an Opus review before it runs:** W1890 uses one U (a line drawn and taken back) to make CE notice the damaged record, and it works on a deliberately damaged CE record. W1949 touches no Undo, REDO, locked layer or Xref.
5. **Both cases are PART claims.** W1949 proves the warning appears on the command line, not that Inspector or the Design Check windows show it. W1890 proves CDRULEBOOK only, not CDCHECKIGNORE.
6. **What I could not verify.** Every printed line marked DERIVED came from the PR text and its source, not from a run. W1949 may fail for a dull reason: CDRULES prints at most 20 rows, and DRV1_B1 may already fill them. The first run says. Neither case can run until a build holding #1949 and #1890 is installed (both are open drafts).
7. **None of the six already had a case.** No case, draft, ledger line or earlier drafts file names any of them (checked again, section 3).

---

## 1. What I read, built and tested

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md` (all of it); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (first 830 lines: seven cases and their twins, the format and style); `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` and `ROBOT_CASE_DRAFTS_SET01_PIPE_LEVELS_02NOV.md` (headers and the switch-off twin style); `FILL_ROBOT_CASES_02NOV.md` (lines naming this set); `variants\R09s_new_switch_off_broken.case.txt`; `SETUP-P8` and `SETUP-DMG-PITLIST`; cases N15, N61 (draft), W1892 and W1952 (drafts, as the model for damaged-record cases); `gh pr view` of all seven PRs (1882, 1897, 1920, 1949, 1962, 1890, 1889) and `gh pr diff` of 1889, 1890 and 1949; `BUGFIX_fx1882_REPORT_31OCT.md`; the installed-line source of `RulebookCommand.cs`, `RulesCommand.cs`, `ProjectDataService.Persistence.cs` and `UnreadableRecordHold.cs` on `origin/claude/rel-20261102a` (read with `git show` and `git grep` only).
2. **Not read in full:** `acad_driver_v3.allowlist.json` itself (I used the README's refused-button list and the press names already used by accepted cases); the second half of the TOP12 file (cases 9 to 12); `C79B1_FIXTURE_NOTE.md`; `BUG_CARPARK.md` (a search for the six bug numbers found no match under those spellings, so the carpark entries were not read).
3. **Built:** nothing. **Tested:** nothing. **Validated with the case validator:** nothing (validate with `pwsh -NoProfile -File case_runner.ps1 validate <folder>` before the first run).
4. **NOT proven:** that any printed line below is exactly what AutoCAD prints; that the damaged-record route puts CE into "held" state (W1890 guard line says so if it does not); that the 20-row CDRULES list shows the new row on DRV1_B1.

---

## 2. How the drafts were written (read before validating)

1. **Format.** README format: header lines, `STEPS`, `ASSERT`. Every `type` chain is a complete command, no `(`, no SAVE-type word. Both twins carry `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`.
2. **Switch-off twins.** Each twin is the same route and the same route checks with the PR's own switch typed `false` through `SETTING CD_Settings.json` before AutoCAD starts (the style of `variants\R09s_new_switch_off_broken`). Only the checks on the new wording go red. If a twin PASSES, the runner reports "now passes: candidate": the case then cannot tell old from new, and the fix goes to Codex.
3. **Settings are never read or written by hand.** Only the `SETTING` line is used. The main cases also set their own switch to `true` so the run does not depend on the default.
4. **Order numbers** 710 to 713. Fixture DRV1_B1, SLOT fresh. `REVIEWED_AGAINST` is empty on purpose; no review file is written.
5. **Ground.** W1949 uses 140000 to 150000, -80000 (just west of the SETUP-P8 pit at 150000,-80000) and -96000 for a reset pipe. TOP12 notes that 138000 to 172000 by -77000 to -98000 is the empty band used by accepted cases. If a first run shows an unexpected object there, move y by -15000 on both W1949 files together.
6. **No protection is bypassed.** Neither case unlocks a layer, touches an Xref, erases a CE object or overrides a refusal. W1890 changes the CE record only through the `record-set` verb that the existing setups SETUP-DMG-PITLIST and the probes already use; nothing is saved (CE never saves, the session copy on disk stays the master).

---

## 3. Existing-case check (done again, not trusted from the filler)

1. **Cases folder, drafts_* folders, variants, _setups:** a text search for 1093, 1882, 903, 1897, 1920, 907, 1949, 1094, 1962, 1071, 1890, 1237, 1889, `pitDropWarns`, `CDRULES`, `CDRULEBOOK`, `CDCHECKIGNORE` and `CDRENUMBER` found only older cases of other fixes: R10 (CDCHECKIGNORE switch off, BUG-866 family), N61 (ignore stays ignored), N08, N15, N24 (CDRENUMBER with two outlets), N50 (CDPERIMETER). None covers a PR in this set. **No case file named for any of the six exists.**
2. **Drafts in `C:\CE_PLAN\areas\ROBOT_CASE_DRAFTS_*.md`:** none of the seven PR numbers appears as a draft; WAVE1 only lists #1889 among PRs it did not examine (its note 6).
3. **Ledger `runner-reports\ledger.json`:** the W-ids present are W1952, W1892 (and their twins) only.
4. **Carpark / bug reports:** `BUGFIX_fx1882_REPORT_31OCT.md` names #1882 (a lid typed with a comma) and says "robot case C93 plus one" is the check; no `C93` file exists in the cases folder. That report covers a different change to #1882 from the zero-level change drafted here (see 4.1).

---

## 4. Fixes with no robot case (BLOCKED-FOR-ROBOT) and exact Codex looks

### 4.1 #1882 (B-069, BUG-1093): a pit lid at exactly RL 0.000 gets the cover check

**BLOCKED-FOR-ROBOT.** The finding appears in network design and network redesign (CDRUNSOLVE, the Civil Hub redesign), which are windows the robot's press list does not reach (README: no Apply, Save, Review changes or Design-window button). CDRULES does not use this code path.

**Codex look K_1882** (copy of a drawing only; evidence folder `C:\CE_WORK\codex\K_1882_<date>`):

1. **Set up (Codex, in AutoCAD).** On a copy: place two pits with PIT. Type the lid (cover level) of the downstream pit as `0.000` in the New Pit window. Join them with CD: invert at the downstream pit `-0.300`, pipe 225 (top at -0.075, so cover is 75 mm, below any minimum). Screenshot the pit window showing 0.000.
2. **Run.** Type CDRUNSOLVE (or open the Civil Hub redesign) on that copy.
3. **Right looks like.** A finding naming the downstream pit with the words "COVER" and "obvert cover" and "mm" and "< minimum" (DERIVED from the PR text; the exact words are not seen yet). Same finding as for a lid typed `0.001` with the invert at `-0.299`.
4. **Wrong looks like.** No cover finding for the 0.000 lid while 0.001 gets one.
5. **Also check.** A pit with the lid left blank gets no cover finding (stays Unknown).
6. **Twin by Codex (optional).** Set `cover.zeroCoverLevelIsReal` to false before launching AutoCAD (Settings guard, copy only): the 0.000 pit should then give no finding.
7. **Evidence.** Screenshots of the New Pit window, the finding list for 0.000 and for 0.001, the exact finding text copied into a note. Never accept or capture a folder the Save box opened in.

### 4.2 #1897 and #1920 (B-022 and B-096, BUG-903): every cover screen reads one minimum, measured to the outside top of the pipe

**BLOCKED-FOR-ROBOT.** The Inspector pit cover row and the Civil Hub are palette and window text; the repair check (Pass D) is a report whose command and wording are not recorded anywhere I read. The CDRULES side (Road row 600) needs the pit set to a Road surface, whose window control names I do not know.

**Codex look K_1897_1920** (copy only; evidence `C:\CE_WORK\codex\K_1897_1920_<date>`):

1. **Set up.** On a copy, place a pit in a Road area with lid (cover level) 19.000 and a 225 pipe leaving it with its invert at the pit 18.350. That is 650 mm to the pit invert and about 400 mm to the outside top of the pipe (PR example: 650 and 400).
2. **Read cover on four screens.** CDRULES (type CDRULES, then Problems; the saved list also names every row), the Inspector pit cover row (select the pit), the Civil Hub, and the repair check (CDGRAPH repair report, as the PR names it).
3. **Right looks like (switches ON, the default).** All four warn that cover is below the Road figure 600 mm, and the Inspector and Hub show a cover near 400 mm (to the pipe top), not 650.
4. **Wrong looks like.** CDRULES warns but the Inspector or Hub shows OK (the old 650 against the single 300 reading).
5. **Second check, Driveway pit.** A Driveway pit with 250 mm cover to the pipe top passes against its own row (200 with the paving slab) and does not show the single 300 figure.
6. **Twin by Codex (optional).** `checks.screensShareOneCover` and `checks.screensMeasureCoverToPipeTop` both false before launch: the old readings return.
7. **Evidence.** Four screenshots (one per screen), one note with the four cover figures side by side.

### 4.3 #1962 (B-131, BUG-1094): Inspector shows a pipe flatter than the minimum grade in red

**BLOCKED-FOR-ROBOT.** The thing that changed is a colour (red cross against amber triangle) in the Inspector, which the robot cannot read. The robot-readable part, "CDRULES already calls this pipe below minimum grade", is not part of this change (CDRULES is unchanged by the PR), so no case is drafted for it. The Codex look below does that comparison on the same pipe.

**Codex look K_1962** (copy only; evidence `C:\CE_WORK\codex\K_1962_<date>`):

1. **Set up.** Check the Settings minimum pipe grade reads 1 in 200 (PR example). On a copy, draw one 20 m pipe with CD from 150000,-80000 to 170000,-80000 with inverts 18.000 and 17.915 (85 mm fall over 20 m, about 1 in 235).
2. **Run.** Select the pipe and look at the Inspector Grade line. Then run CDRULES on the same copy and note its grade row for that pipe.
3. **Right looks like.** The Grade line shows the red cross, as CDRULES already does for this pipe.
4. **Wrong looks like.** An amber triangle (old behaviour: only 1 in 241 and flatter went red).
5. **Control.** A pipe at exactly 1 in 200 (inverts 18.000 and 17.900) must not show red. A "near the limit" amber band on a passing pipe is not part of this fix (it needs Tim's word).
6. **Evidence.** One screenshot of the Inspector for each pipe, the CDRULES grade row text.

### 4.4 #1889 (B-067, BUG-1237): CDRENUMBER says what to draw when it cannot find the outlet

**BLOCKED-FOR-ROBOT, for a fixture reason, not a visual one.** The words are command-line text the robot could read. But DRV1_B1 already has pipes leaving pits to open ground (N08 and N15 show CDRENUMBER asking "Which pit is the main outlet?"), so the no-outlet stop cannot happen on it. No small master with two pits and one pipe is on the list I saw in `C:\ce_rc_drv`. Taking pipes out of DRV1_B1 first would turn this into an erase-and-undo case that needs its own review. Suggested next step for the desk: a new empty master (millimetres) with two pits joined by one pipe, then a robot case is a ten-line text check.

**Codex look K_1889** (copy of a new empty drawing; evidence `C:\CE_WORK\codex\K_1889_<date>`):

1. **Set up.** New empty drawing copy in millimetres. PIT at 150000,-80000, PIT at 170000,-80000. CD pipe from the first to the second pit, inverts 18.000 and 17.900. Draw nothing else.
2. **Run.** Type CDRENUMBER.
3. **Right looks like.** The command line says: "CDRENUMBER numbers the pits from the outlet, but no pipe leaves any pit to open ground or an outfall, so it cannot tell which pit is the outlet. Draw the last pipe from the downstream pit out to an open end (finish it clear of every pit), then run CDRENUMBER again. Nothing was renumbered." (from the PR text, DERIVED). No pit number changes.
4. **Wrong looks like.** "No pit discharges outside the network" (the old line).
5. **Follow-up.** Draw one pipe from the downstream pit out to an open end 5 m beyond it, run CDRENUMBER again: it must now ask or renumber, not repeat the stop.
6. **Twin by Codex (optional).** `linking.renumberNoOutletSaysWhatToDraw` false before launch: the old sentence returns.
7. **Evidence.** Screenshot of the command line for both runs, pit numbers before and after.

---

## 5. The case texts

### Case 1 of 2: W1949, the pit where the outlet pipe top sits above the inlet pipe top (#1949, B-130, BUG-907)

**Intended file:** `W1949_outlet_top_above_inlet_top_warned.case.txt`

```
# W1949 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1949 (B-130, BUG-907), branch claude/b130-bug-907-obvert-warning, switch inverts.pitDropWarnsOutletTopAboveInletTop (ON by default).
# Tim, 29 Oct 2026 (decision 18, quoted in the PR): "yes - warn (never block, R-27) when the outlet pipe top sits above the inlet pipe top at a pit, as well as when inverts are wrong."
# Words from the PR diff (Rules/PitObvertRule.cs): detail = 'outlet pipe top is <excess> mm above the inlet pipe top (<outlet top> against <inlet top>): the pipe gets bigger, so the outlet invert needs to be lower'. Tops = invert + diameter/1000, three decimals; the excess is printed with up to one decimal ('0.#'). The finding is raised as a Warn under rule 'Pit invert drop' (RulebookEngine.cs) and is added only where a pit-drop finding for that pit exists.
# Route: SETUP-P8 places the pit at 150000,-80000 and the OUTLET pipe leaving it (150000,-80000 to 170000,-80000, invert 18.000 at the pit, default diameter, 225 on this PC per R18). This case adds the INLET pipe arriving at the same pit: 140000,-80000 to 150000,-80000, diameter 150, inverts 18.080 then 18.030 (10 m, 1 in 200). Outlet top 18.000 + 0.225 = 18.225. Inlet top 18.030 + 0.150 = 18.180. The invert drop at the pit is 30 mm, so the drop row passes (PR: a 20 mm drop passes) and only the new top-above-top warning is expected: 45 mm.
# DERIVED (never seen): the whole detail sentence; that the numbers are 45 / 18.225 / 18.180 (they hold only if the SETUP-P8 pipe is 225; the stable words are checked separately from the numbers); that CDRULES Problems lists the row within its first 20 rows on DRV1_B1 (CDRULES prints at most 20; the row may be cut: first run, read $rules in full); that the inlet pipe's end at 150000,-80000 joins the pit as the outlet's start did.
# Remembered values: YES. The inlet is typed with diameter 150, which CE remembers as the last New Pipe diameter. A reset pipe (diameter 225, free ground, placed AFTER CDRULES so it cannot affect the rule) puts it back, the pattern of SET01 and N33a. Check CD_RecentValues.json after the first run.
CASE W1949
TITLE A 150 pipe arriving and a 225 pipe leaving the same pit: CDRULES warns that the outlet pipe top is above the inlet pipe top (45 mm), and nothing is blocked
PLAN_ITEM PR #1949 (B-130 BUG-907) PART: the warning on the CDRULES command line for one pit with one outlet and one inlet. NOT whole: Design Check and Project Review (same rule list), the Fix suggestion (CDEDIT) and the cases 'level tops do not warn', 'several arriving pipes use the lowest top' and 'a missing level says nothing' are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
SETTING CD_Settings.json inverts.pitDropWarnsOutletTopAboveInletTop true
ORDER 710
TIMEOUT 1500
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED With the 150 inlet placed (one new CE pipe object), CDRULES Problems prints its summary line and a row containing 'outlet pipe top is 45 mm above the inlet pipe top (18.225 against 18.180)', in the pit-drop rule's wording, with no 'Pit invert drop' failure block and no window left open. The reset pipe (diameter 225) is then placed.
WHY_NOT_UNIT_TEST The unit test feeds the rule hand-made levels; only AutoCAD joins a real drawn pipe to a real drawn pit, reads both invert and diameter from the drawing and prints the row.
NOT_AUTOMATED The same warning in Design Check and Project Review windows, and the Fix suggestion text (not reachable by the press list). The cases with level tops, several arriving pipes and a missing level (unit-tested in the PR only).
NOT_AUTOMATED Whether the first 20 CDRULES rows include the new row on DRV1_B1 is not known; if the row is cut off the case FAILS on check 'has outlet pipe top is' and the full output is recorded.
STEPS
  ms-count -> $c0
  type "CD{NL}140000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $in_t1
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.FirstInvert" "18.080"
  ui2-set "New Pipe" "C2.SecondInvert" "18.030"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $in_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $in_e
  wait
  ms-new $c0 -> $mid
  select $mid object=CeCvlPipeObject -> $inlet
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $rules
  wait
  sleep 2
  esc-prompt -> $rules_e
  wait
  windows-snapshot -> $win_rules
  type "CD{NL}140000,-96000{NL}150000,-96000{NL}" -Force -ExpectWindow "New Pipe" -> $rs_t1
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $rs_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $rs_e
  wait
ASSERT
  count $inlet = 1
  history has "[CE] CDRULES:"
  history has "outlet pipe top is "
  history has " mm above the inlet pipe top ("
  history has "the pipe gets bigger, so the outlet invert needs to be lower"
  history has "outlet pipe top is 45 mm above the inlet pipe top (18.225 against 18.180)"
  not-contains $win_rules "Creative Engineering"
  record $rules "FULL CDRULES Problems output (find the outlet pipe top row; the list stops at 20 rows)"
  record $rules_e "what the closing Esc printed"
  record $inlet "the inlet pipe object (handle)"
```

**Twin:** `W1949_BROKEN_outlet_top_switch_off.case.txt`

```
# W1949_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Same route and same route checks as W1949, with the PR's own switch inverts.pitDropWarnsOutletTopAboveInletTop typed false before AutoCAD starts (style of variants\R09s_new_switch_off_broken). Settings are read at launch, so it cannot be changed mid-case. With it off CDRULES uses the invert-only drop check exactly, so the 30 mm drop passes silently and no outlet-top row exists: the three 'outlet pipe top' checks FAIL. The inlet-placed and CDRULES-ran checks must PASS.
# If this twin PASSES the case cannot tell the old behaviour from the new: send #1949 to Codex.
CASE W1949_BROKEN
TITLE BROKEN VARIANT of W1949: the new switch is OFF, yet the case still expects the outlet-top warning (must FAIL)
PLAN_ITEM red-before-green proof for W1949 (PR #1949, BUG-907)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
SETTING CD_Settings.json inverts.pitDropWarnsOutletTopAboveInletTop false
ORDER 711
TIMEOUT 1500
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1949
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF CDRULES prints no outlet-top row, so 'history has "outlet pipe top is "' fails. The inlet pipe is placed and CDRULES ran, so those checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1949's row check can go red on the old behaviour.
STEPS
  ms-count -> $c0
  type "CD{NL}140000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $in_t1
  ui2-set "New Pipe" "C2.Diameter" "150"
  ui2-set "New Pipe" "C2.FirstInvert" "18.080"
  ui2-set "New Pipe" "C2.SecondInvert" "18.030"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $in_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $in_e
  wait
  ms-new $c0 -> $mid
  select $mid object=CeCvlPipeObject -> $inlet
  type "CDRULES{NL}Problems" -Force -TimeoutSec 180 -> $rules
  wait
  sleep 2
  esc-prompt -> $rules_e
  wait
  type "CD{NL}140000,-96000{NL}150000,-96000{NL}" -Force -ExpectWindow "New Pipe" -> $rs_t1
  ui2-set "New Pipe" "C2.Diameter" "225"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.950"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $rs_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $rs_e
  wait
ASSERT
  count $inlet = 1
  history has "[CE] CDRULES:"
  history has "outlet pipe top is "
  history has "outlet pipe top is 45 mm above the inlet pipe top (18.225 against 18.180)"
  record $rules "FULL CDRULES Problems output with the switch OFF"
```

---

### Case 2 of 2: W1890, CDRULEBOOK says "Not saved" when CE did not save (#1890, B-067, BUG-1071)

**Intended file:** `W1890_cdrulebook_says_not_saved.case.txt`

```
# W1890 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED; NEEDS AN OPUS REVIEW BEFORE IT RUNS: one U, and a deliberately damaged CE record). PR #1890 (B-067 part 2, BUG-1071), branch carries Rules/SaveSkippedWordsRule.cs, switch linking.saveSkippedSaysNotSaved (ON by default).
# What the PR changes: on a drawing whose CE record CE holds as unreadable (BUG-971), CDRULEBOOK no longer prints '[CE] Pit invert drop set to ...'. It prints '[CE] Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. The pit invert drop is still <current>. Nothing was changed.' (SaveSkippedWordsRule.RulebookNotSaved with what='The pit invert drop' and stays=current.ToText(); RulebookCommand.cs shortcut path: the keywords 0, 20 and 50 set the drop). DERIVED: the figure after 'is still' (current.ToText() is not known; checked by its stable words only).
# This is NOT the BUG-971 line. The first skipped write of each kind also prints once '[CE] Not saved to the CE record (the rulebook record): the CE record in this drawing could not be read, so CE does not save over it. The original record stays in the drawing; drafting carries on.' (UnreadableRecordHold.SkippedWriteLine, RulebookRoute 'the rulebook record'). The new line begins 'Not saved: the CE data', so the two are told apart; both are recorded.
# Route: SETUP-DMG-PITLIST writes the one word DMGBROKEN2A4 into the saved CE project record in the open drawing with the v3 record-set verb (no typed Lisp; nothing saved; the session copy on disk stays the master). Then a short LINE is drawn far from the network and taken back with U, because the re-read at U is what finds the damaged record and puts CE into the 'held' state (the route of W1952 step (a); NOT confirmed by any run). Then CDRULEBOOK is asked for 50 mm.
# Guard line (same as W1952): the Civil log line '[ProjectData] The CE record in this drawing exists but could not be read ...'. If the guard FAILS, CE never held the record, and the route must change (CDSYNC as the trigger, as the PR says), not the checks.
# 'The drop must not claim to be 50 if it is unchanged' (PR): CDRULEBOOK Show is read before and after; the two are compared whole, so no wording is guessed.
# Remembered values: NO (no PIT or CD). Settings through the guard: saveSkippedSaysNotSaved true (the PR's switch), keepUnreadableDrawingRecord true (the BUG-971 hold).
CASE W1890
TITLE On a drawing whose CE record is damaged, CDRULEBOOK 50 says 'Not saved' and that the pit invert drop is still what it was, and never says it was set
PLAN_ITEM PR #1890 (B-067 part 2, BUG-1071) PART: CDRULEBOOK, pit invert drop, the shortcut keyword 50. NOT whole: CDCHECKIGNORE Ignore and Un-ignore (the finding list on a damaged record is not known, so the ignore route is a Codex look), CDRULEBOOK council and cover override, and the typed 'Enter drop in mm' route
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
SETTING CD_Settings.json linking.saveSkippedSaysNotSaved true
SETTING CD_Settings.json linking.keepUnreadableDrawingRecord true
ORDER 712
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the damage and one LINE plus U, CDRULEBOOK Show prints the current rulebook; CDRULEBOOK 50 prints '[CE] Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. The pit invert drop is still ... Nothing was changed.' and does NOT print 'Pit invert drop set to'; CDRULEBOOK Show again prints exactly what it printed before; the record still reads as the damaged word DMGBROKEN2A4 (untouched).
WHY_NOT_UNIT_TEST The writers return true or false inside a live drawing whose record is held as unreadable; only AutoCAD holds a real damaged record and shows the line the command prints.
NOT_AUTOMATED CDCHECKIGNORE (Ignore and Un-ignore) and the other five CDRULEBOOK saves (council twice, cover twice, pit drop typed). 'Asking again gets the same honest line' is not driven. See the Codex note for #1890 (section 6).
STEPS
  type "CDRULEBOOK{NL}Show" -Force -> $show_before
  wait
  esc-prompt -> $show_before_e
  wait
  type "_.LINE{NL}190000,-95000{NL}191000,-95000{NL}" -Force -> $line_a
  wait
  type "U" -Force -> $u_a
  wait
  sleep 3
  type "CDRULEBOOK{NL}50" -Force -> $rb50
  wait
  sleep 2
  esc-prompt -> $rb50_e
  wait
  type "CDRULEBOOK{NL}Show" -Force -> $show_after
  wait
  esc-prompt -> $show_after_e
  wait
  v3 record-set nod -Part CE_CVL_SUITE_PROJECT/PROJECT_DATA -To READ -> $rec_after
  wait
  getvar CMDACTIVE -> $ca
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[ProjectData] The CE record in this drawing exists but could not be read"
  history has "Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this."
  history has "The pit invert drop is still "
  history has "Nothing was changed."
  history absent "Pit invert drop set to"
  equals $show_after $show_before
  contains $rec_after "DMGBROKEN2A4"
  equals $ca 0
  record $show_before "FULL CDRULEBOOK Show before (the current drop, council and cover)"
  record $rb50 "FULL what CDRULEBOOK 50 printed (the BUG-971 line then the new line)"
  record $show_after "FULL CDRULEBOOK Show after"
  record $u_a "FULL what U showed"
  record $civlog "FULL civil log lines since the case began"
```

**Twin:** `W1890_BROKEN_not_saved_switch_off.case.txt`

```
# W1890_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN; NEEDS THE SAME OPUS REVIEW). Same route and same route checks as W1890, with the PR's own switch linking.saveSkippedSaysNotSaved typed false before AutoCAD starts (settings are read at launch). With it off the command prints the old success line '[CE] Pit invert drop set to ...' although CE skipped the save, so the two checks on the 'Not saved' words FAIL. The guard, the damaged record and the 'Show is unchanged' checks must PASS (the save is still skipped, only the words differ): this is what proves the case watches the words and not the data.
CASE W1890_BROKEN
TITLE BROKEN VARIANT of W1890: the new switch is OFF, yet the case still expects the 'Not saved' line (must FAIL)
PLAN_ITEM red-before-green proof for W1890 (PR #1890, BUG-1071)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
SETTING CD_Settings.json linking.saveSkippedSaysNotSaved false
SETTING CD_Settings.json linking.keepUnreadableDrawingRecord true
ORDER 713
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1890
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF CDRULEBOOK 50 prints 'Pit invert drop set to ...', so 'history has "Not saved: the CE data"' fails and 'history absent "Pit invert drop set to"' fails. The record stays damaged and Show is unchanged.
WHY_NOT_UNIT_TEST It exists only to prove W1890's wording checks can go red on the old behaviour.
STEPS
  type "CDRULEBOOK{NL}Show" -Force -> $show_before
  wait
  esc-prompt -> $show_before_e
  wait
  type "_.LINE{NL}190000,-95000{NL}191000,-95000{NL}" -Force -> $line_a
  wait
  type "U" -Force -> $u_a
  wait
  sleep 3
  type "CDRULEBOOK{NL}50" -Force -> $rb50
  wait
  sleep 2
  esc-prompt -> $rb50_e
  wait
  type "CDRULEBOOK{NL}Show" -Force -> $show_after
  wait
  esc-prompt -> $show_after_e
  wait
  v3 record-set nod -Part CE_CVL_SUITE_PROJECT/PROJECT_DATA -To READ -> $rec_after
  wait
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[ProjectData] The CE record in this drawing exists but could not be read"
  equals $show_after $show_before
  contains $rec_after "DMGBROKEN2A4"
  history has "Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this."
  history absent "Pit invert drop set to"
  record $rb50 "FULL what CDRULEBOOK 50 printed with the switch OFF"
```

---

## 6. Codex look for the second half of #1890

**Codex look K_1890** (copy only; evidence `C:\CE_WORK\codex\K_1890_<date>`). W1890 covers CDRULEBOOK only; CDCHECKIGNORE is left to Codex because the finding list on a damaged record is not known.

1. **Set up (from the PR text).** A test drawing copy with pit P1 on a wrong layer and the saved CE project record's `lastPitNumber` set to BROKEN. Turn on `keepUnreadableDrawingRecord`, `allowIgnoreFinding`, `useSharedResult` and `wrongLayerRows` (Settings, before AutoCAD starts).
2. **Run.** CDSYNC, then CDCHECKIGNORE, answer Ignore, pick P1's wrong-layer finding, reason Other, Enter.
3. **Right looks like.** "Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. P1 ... is not ignored and still shows on the Checks list. Nothing was changed, so there is nothing to undo." The finding still shows on the Checks list. There is no "Ignored:" line and no "Type U to take it back".
4. **Wrong looks like.** "Ignored: P1 ... Type U to take it back", although the finding comes back on the next check.
5. **Also.** CDRULEBOOK 50 then CDRULEBOOK Show: the drop must not read 50 if the first line said Not saved.
6. **Evidence.** Screenshot of the command line for the Ignore, the Checks list before and after, a note of the exact text.

---

## 7. Fixes skipped and why

1. **#1882, #1897 with #1920, #1962, #1889:** no robot case (section 4). Reasons: a design window the press list does not reach (#1882); palette and Hub text the robot cannot read (#1897, #1920); a colour (#1962); no master drawing without an outlet (#1889).
2. **No replacement fix taken.** None of the six already had a case, so there was nothing to replace. Two of the six produced robot cases, which is the most the evidence supports; the other four are Codex-only rather than padded with weak cases.
3. **Not examined:** whether #1920 (stacked on #1897's branch, base `fb/bug903-one-cover-figure-b022`) needs #1897 installed first for any Codex look: it does by the PR text ("same code"), so install both together.
4. **Time:** about 12 minutes of read-only work; no fix that turned out window-only took more than three.
