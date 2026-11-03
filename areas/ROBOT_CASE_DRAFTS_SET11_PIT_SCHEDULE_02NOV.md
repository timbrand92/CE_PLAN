# Robot case drafts, set 11: Pit Schedule fixes (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** One robot case with its failing twin, and six numbered Codex looks, for the Pit Schedule fix PRs #1881, #1760, #1764, #1765, #1767 and #1722. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder; the only file written is this one. No git write.

---

## FOR TIM

1. **Drafted: 1 robot case and 1 broken twin (2 case texts).** The robot can prove one of the six fixes, in part: the Pit Schedule "Shallow" depth is now a Settings value (#1722, BUG-1035). Case W1722 sets it to 2000 mm and checks pit P3 (1.63 m deep) reads "Shallow"; the twin leaves it at 300 and must fail.
2. **Codex-only: five fixes** (#1881, #1760, #1764, #1765, #1767). The robot cannot reach any of them: the button that draws the schedule is disabled for it, Export is on its refused list, and two of them need a second drawing with an Xref.
3. **Needs an Opus review before it is run:** none of the drafted cases touches Undo, REDO, a locked layer or an Xref. The Codex looks for #1881 (Undo, a locked layer), #1765 and #1767 (an Xref, BIND) do touch them: Codex must use copies only and must not unlock, detach or unload anything.
4. **The one robot case is a PART claim.** It proves the Settings value changes what the STATE column says. It does not prove the Settings page box (a Codex look, section 4) and it cannot prove the drawn schedule.
5. **Not verified.** I did not run anything. The word "Shallow" in the STATE cell, the "Link and overrides" button press and the P3 row layout are DERIVED from the source and from other runs; none has been seen on a run (section 2).
6. **Two of the six may not be in the installed build.** The branch log of origin/claude/rel-20261102a holds the merges of #1722, #1760, #1764 and #1765, and the last probe runs read the installed Civil as 3.0.88+3fbb9da5, which is the tip of that branch. I found no merge of #1881 or #1767 in that log. Both look like later train items, so a robot or Codex run on 3.0.88 would not contain them.
7. **Nothing for you to decide or test.** The drafts go to CE 05 for the queue, then to an Opus review.

---

## 1. How the drafts were written

**What I read (and not more):** `C:\TimOS\RULES.md`; `README_CASES.md` in full; the v3 allow-list (never_buttons holds `*Export*`, `Save*`, `Apply`, `Continue placement`; the Pit Schedule window can be pressed only through the `Creative Engineering*` entry: Cancel, Close); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the wave-1 draft file; the existing cases R25, R38, N09, R09s and R09s_new_switch_off_broken; the probe cases PROBE-PS-CTL and PROBE-PS-TAB and the reports RUN-20261102-0001-C3.0.88-pPS, 0050-pPSd, 0325-pPSc and 0327-pPSt; the six PR texts and the #1722 diff (`gh pr view`, `gh pr diff`); the carpark entries BUG-1035, BUG-1198 and the others by number; the Civil source on `origin/claude/rel-20261102a` (`git show`, `git grep` only).

**Search for an existing case (checked again, not trusted from the queue filler):**

1. No file in `C:\Lisp Files\_ACAD_DRIVER\cases` (including `variants`, `controls`, `_setups` and every `drafts_*` folder) names `shallowPitDepthMm`, a PR number, a BUG number or a case id W1722, W1760, W1764, W1765, W1767 or W1881.
2. `ledger.json` has no id W1722 to W1881.
3. No `ROBOT_CASE_DRAFTS_*.md` drafts any of the six. The wave-1 file names #1881 only: it set it BLOCKED-FOR-ROBOT as its item K1_09, with a Codex look. This file repeats that verdict and does not draft it again.
4. Existing cases that touch the Pit Schedule (R25, R38, N09, N33) read the window on the "Pit and pipes" view only. None reads the STATE column, so none overlaps W1722.

**What the robot can and cannot do (confirmed against R25, R38 and the probes):**

1. **Can:** open PITSCHEDULE, read its cells as text (R38 reads row P3: FROM P4, DIA 450, IL 17.30, DIA 450, IL 17.25, COVER 18.88, PIT DEPTH 1.63), close it with the Close button.
2. **Cannot place a drawn schedule:** probe pPS (RUN-20261102-0001): `Continue to Place / update` is refused, "button is disabled; nothing was pressed". Probe pPSc (0325) read it as `enabled = False` on the untouched drawing.
3. **Cannot press the Source tab:** probe pPSt (0327) found no button named Source; the window's real buttons are Close, Refresh, Relink and recalculate, three radio buttons (Pit and pipes, Lid and remarks, Link and overrides), + Add Row, - Remove Row, Reset Sort, Export CSV and Export Excel.
4. **Cannot type into a cell or press a right-click menu item** (R25 and R38 NOT_AUTOMATED lines: the cells have no accessible id; the menu items are not pressable).
5. **Never pressed on purpose:** Export CSV and Export Excel (refused: `*Export*`).

**Format.** README format: header lines, `STEPS`, `ASSERT`. Fixture DRV1_B1, `SLOT fresh`, order numbers 800 and 801, `REVIEWED_AGAINST` empty, a `type` chain with no `(` and no SAVE-type word. The twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`. The settings mechanism used is the README one: `SETTING CD_Settings.json <key> <value>`, set through the v2 guard before AutoCAD starts and restored by hash after; Tim's real settings files are never read or written by this draft, and `hashes-unchanged` is not used because the guard holds the file changed.

**Validate first, without AutoCAD:** copy each block in section 3 to its file name in a drafts folder (suggested `cases\drafts_set11_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.

---

## 2. What is DERIVED (read from the source, not seen on a run)

1. **The setting key and its default.** `linking.shallowPitDepthMm`, default 300, in the CD settings file (the same file as every other `linking.` key the existing cases set). Read from `UserSettings.cs` on `origin/claude/rel-20261102a` (line 1035). A value of 0 or less falls back to 300.
2. **The STATE word.** `HealthStateLabel` is `Deep` if the row is deep, else `Shallow` if shallow, else `OK` (`PitScheduleRow.cs` line 512). A row is shallow when its depth in metres is below the setting divided by 1000 (`UpdateWarning`, `PitScheduleViewModel.Data.cs` line 2187). A row is deep only when its depth is over the step-iron depth and it has no step-irons note.
3. **P3 reads Shallow at 2000 mm.** R38 recorded P3's depth cell as 1.63 (metres). 1.63 is below 2.00, so the shallow test is true. Whether the row also counts as deep depends on `HasStepIrons`: 1.63 m is over the 0.9 m step-iron line, which should set the step-irons note and so clear "deep". If that does not hold, the cell reads `Deep` and the case goes red on a value, not on a tool problem. **The reviewer must check this first.**
4. **The STATE column sits on the "Link and overrides" view.** `ColumnIsInView` shows SOURCE, STATE, OVERRIDE, OVERRIDE REASON and WARNING only on that view; the window opens on "Pit and pipes". Pressing that radio button with `ui2-press` is NOT seen on a run: the probe listed it among the window's buttons, and memory from 29 Oct records that v2 can press the "Lid and remarks" radio. If the press is refused the runner reports BLOCKED (a tool problem), never FAIL.
5. **The dump shape.** The row regex copies R38's: a DataItem named `Pit P3` and the cell texts after it, up to the next `Pit ` name. The STATE cell should be a Text control named by its value (`Shallow`). Not seen on a run.

---

## 3. The case texts

### File: `W1722_shallow_depth_is_a_settings_value.case.txt`

```
# W1722 DRAFT (Sonnet, Team, Mon 2 Nov 2026; NOT RUN YET). PR #1722 (BUG-1035): the Pit Schedule STATE column calls a pit Shallow below a depth that used to be fixed at 300 mm in the program; it is now the Settings value linking.shallowPitDepthMm (300 mm unless the office changes it). A warning only.
# Route: PITSCHEDULE opens on the untouched DRV1_B1 copy (27 rows, as R25 and R38 read it); the Link and overrides view shows the STATE column; pit P3 is 1.63 m deep (R38: PIT DEPTH 1.63). With the value set to 2000 mm before AutoCAD starts, P3 is shallower than the line, so its STATE cell must read Shallow. At the shipped 300 it reads OK (that is the twin W1722_BROKEN).
# DERIVED (not seen on a run): the key name and default (UserSettings.cs line 1035); the STATE words Shallow / OK / Deep (PitScheduleRow.cs line 512); that P3 is not also deep (1.63 m is over the 0.9 m step-iron line, which should give it the step-irons note and clear 'deep'); that ui2-press can press the Link and overrides radio button; the row layout of the dump.
# Part claim only: the Settings page box (Pipes and Pits tab) and a typed manual row are not reachable by the robot (Codex look 1722-A).
CASE W1722
TITLE With the Shallow pit depth set to 2000 mm in Settings, the Pit Schedule STATE column reads Shallow for pit P3 (1.63 m deep); the window closes and changes nothing
PLAN_ITEM BUG-1035 (PR #1722), PART claim: the STATE column follows the Settings value for a pit read from the drawing. NOT claimed: the Settings page box, a typed manual row (Depth 0.29, 0.30, 0.31), the fallback to 300 for 0 or a negative value, the caution colour.
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.shallowPitDepthMm 2000
ORDER 800
TIMEOUT 900
BUG BUG-1035
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED PITSCHEDULE opens on the untouched copy; after the Link and overrides button is pressed, the row of pit P3 has a STATE cell reading Shallow and no STATE cell reading OK; the Close button closes the window; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests drive a typed manual row. This reads a real pit of a real drawing through the live window, with the value arriving from the settings file CE reads at AutoCAD start.
NOT_AUTOMATED The Settings page box for the value (Pipes and Pits tab) is not read: the tab cannot be pressed by the robot. Codex look 1722-A.
NOT_AUTOMATED The 300 mm default is checked only by the twin W1722_BROKEN (P3 reads OK at 300); the 290, 300 and 310 mm boundary needs typed cells, which the robot cannot do.
NOT_AUTOMATED The caution colour of the row is not read (a colour is not a text).
STEPS
  copy-info -> $copy0
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps1
  sleep 5
  ui2-press "Pit Schedule" "Link and overrides" -Secs 30
  sleep 3
  ui-dump "Pit Schedule" -> $psd
  ui-press "Pit Schedule" "Close" -> $psc
  await-window-gone "Pit Schedule" -Secs 120
  wait
  windows-snapshot -> $win_end
ASSERT
  control $psd "Pit P3" exists
  control $psd "STATE" exists
  matches $psd "name.:.Pit P3.,.id(?:(?!name.:.Pit ).)*?name.:.Shallow."
  matches $psd "^(?!.*name.:.Pit P3.,.id(?:(?!name.:.Pit ).)*?name.:.OK.)"
  window-closed $psc
  not-contains $win_end "Pit Schedule"
  copy-unchanged $copy0
  record $psd "FULL Link and overrides view of the Pit Schedule (find the Pit P3 row and its STATE cell)"
  record $psc "FULL what pressing Close reported"
```

### File: `variants\W1722_BROKEN.case.txt`

```
# W1722_BROKEN DRAFT (Sonnet, Team, Mon 2 Nov 2026; NOT RUN YET). The deliberately broken twin of W1722: the Shallow pit depth is left at 300 mm, the number that was fixed in the program before PR #1722, so pit P3 (1.63 m) must read OK, not Shallow. The case must FAIL on the Shallow check.
# Same route as W1722 (the same press of the Link and overrides button, the same dump); only the Settings value differs. Expected red: the P3 row's STATE cell reads OK (or Deep) and no Shallow follows Pit P3; the 'no OK' check fails too. The route checks (Pit P3 exists, STATE exists, window closes, copy unchanged) should still PASS: that shows the case reached the window and the failure is the value.
# Honest limit: the installed Civil already holds the fix, so this is not 'the old build failing'. It proves the case can tell 300 mm from 2000 mm. A red on the pre-fix build is not available.
# DERIVED: as W1722.
CASE W1722_BROKEN
TITLE BROKEN VARIANT of W1722: the Shallow pit depth at 300 mm, so pit P3 (1.63 m) reads OK and not Shallow (must FAIL)
PLAN_ITEM red-before-green proof for W1722 (BUG-1035, PR #1722), PART claim as W1722
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.shallowPitDepthMm 300
ORDER 801
TIMEOUT 900
BUG BUG-1035
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1722
REVIEWED_AGAINST
EXPECTED With the Shallow pit depth at 300 mm, pit P3 has a STATE cell reading Shallow (this must NOT happen: the case is meant to fail here).
WHY_NOT_UNIT_TEST As W1722: it reads a real pit of a real drawing through the live window.
NOT_AUTOMATED The state of every other row is recorded in the dump, not asserted.
STEPS
  copy-info -> $copy0
  type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps1
  sleep 5
  ui2-press "Pit Schedule" "Link and overrides" -Secs 30
  sleep 3
  ui-dump "Pit Schedule" -> $psd
  ui-press "Pit Schedule" "Close" -> $psc
  await-window-gone "Pit Schedule" -Secs 120
  wait
  windows-snapshot -> $win_end
ASSERT
  control $psd "Pit P3" exists
  control $psd "STATE" exists
  matches $psd "name.:.Pit P3.,.id(?:(?!name.:.Pit ).)*?name.:.Shallow."
  matches $psd "^(?!.*name.:.Pit P3.,.id(?:(?!name.:.Pit ).)*?name.:.OK.)"
  window-closed $psc
  not-contains $win_end "Pit Schedule"
  copy-unchanged $copy0
  record $psd "FULL Link and overrides view of the Pit Schedule (the Pit P3 STATE cell should read OK here)"
  record $psc "FULL what pressing Close reported"
```

---

## 4. Codex looks (numbered; what the robot cannot reach)

Rules for every look: copies only; evidence in `C:\CE_WORK\codex\<look id>_<date>\` (screenshots, the command-line text, the CE log lines); never accept or capture a folder the box opened in; never unlock a layer, detach or unload an Xref to make a step work. Settings are changed before AutoCAD starts and put back after.

1. **1722-A: the Settings page box and typed rows (BUG-1035, PR #1722).** Why not the robot: the Settings tab and typed cells cannot be driven.
   1. Close AutoCAD. Back up the CD settings file. Set `linking.shallowPitDepthMm` to 450. Start AutoCAD, new millimetre drawing.
   2. Type CDS, open the Pipes and Pits tab. Right looks like: a box "Shallow pit depth" under "Rows per sheet" reading 450, with "mm · usually 300" beside it. Type 0 in it: a plain line under it says the schedule will use 300 mm. Cancel.
   3. Type PITSCHEDULE, untick Auto-calculate depth, click + Add Row three times, type Depth 0.29, 0.30, 0.31 (Tab after each). Right looks like: all three STATE cells read Shallow and the rows are the caution colour.
   4. Put the value back to 300 (restore the backup byte for byte), restart, repeat step 3. Right looks like: 0.29 Shallow, 0.30 OK, 0.31 OK.
   5. Evidence: `C:\CE_WORK\codex\1722A_<date>\`.

2. **1881-A: a long lid and remarks note grows the row (BUG-587, PR #1881; draft, base rel-20261026z, so first confirm it is in the build under test).** Why not the robot: needs a placed schedule (Place is disabled for it) and a look at the drawn rows. Same as wave-1 item K1_09.
   1. Drawing with pits P1, P2, P3. P1 lid Class C Grated Lid with the step-irons note, P2 a lid note that wraps to three or more lines ("CODEX CHECK With Step Irons"), P3 plain. Place the schedule, then Update placed schedule.
   2. Right looks like: P2's row is 1500 high (two rows) with its text centred and no line through the middle; P3 sits one row lower; P1 and P3 keep 750 rows.
   3. Save, reopen, Update again: nothing moves. Press U once: the white strips and the cells go together. Undo is one step.
   4. Set `linking.scheduleRowGrowsForLongRemark` to false before launch (restart) and place fresh: the old fixed rows return with nothing extra drawn. With the schedule layer locked, Update leaves the strips and the command line says so; nothing is unlocked.
   5. Evidence: `C:\CE_WORK\codex\1881A_<date>\`.

3. **1760-A: a lower second outgoing pipe is counted on refresh (BUG-1196, PR #1760; switch `linking.pitScheduleRefreshCountsAllConnectedPipes`, ON).** Why not the robot: needs a placed schedule and PITEDIT's Save.
   1. Pits P2, P3, P4 (600 x 600). Two 225 pipes leave P2: P2 to P3 at RL 10.40 at P2, P2 to P4 at RL 9.90 at P2. P2 cover RL 11.00, floor RL 10.20. Make P2 to P3 the chosen outlet in the Pit Schedule window. Settings: pit-floor depth ON, step irons deeper than 900 mm (defaults).
   2. PITSCHEDULE, place the schedule. Right looks like: P2 depth 1.10 and "With Step Irons".
   3. PITEDIT, pick P2, change only Plan length 600 to 900, save. Right looks like: the drawn depth is still 1.10 with the step-irons note, and reopening PITSCHEDULE also says 1.10 (before the fix: 0.80 and the note gone).
   4. Control: move the lower pipe to arrive at P2 (P1 to P2, RL 9.90 at P2). Right looks like: 1.10 both before and after.
   5. Switch OFF (before launch) should give the old 0.80. Evidence: `C:\CE_WORK\codex\1760A_<date>\`.

4. **1764-A: cancelling an export no longer changes the drawing (BUG-1198, PR #1764; switch `linking.pitScheduleExportWritesNothing`, ON).** Why not the robot: Export is on its refused list and a file chooser opens. Note: Codex look H3 of 30 Oct could not reach the Export Excel step (no chooser, a Pit Schedule rendering error twice, BUG-1255), so run CSV first and record it if Excel fails again.
   1. Open a saved drawing with one scheduled pit and no manual rows. Type PITSCHEDULE. Edit nothing.
   2. Click Export CSV, then Cancel in the file chooser. Right looks like: no "Project data saved to DWG" line on the command line or in the CE log for this click.
   3. Close the schedule window, type CLOSE. Right looks like: AutoCAD does NOT ask "Save changes?".
   4. Click Export CSV again and save a file into the evidence folder (not a folder the box opened in). The file opens and lists the same rows as the window; the drawing still asks nothing.
   5. Edit a pit's remarks in the window, close it, type CLOSE: this one should ask to save. Evidence: `C:\CE_WORK\codex\1764A_<date>\`.

5. **1765-A: OUT OF DATE follows only what the schedule draws (BUG-1145, PR #1765; switch `linking.pitScheduleFingerprintScopedToSchedule`, ON).** Why not the robot: needs a sheet drawing that Xrefs a stage drawing, and two drawings. Copies only; do not detach or unload the Xref.
   1. Stage drawing with pits and pipes, and a sheet that Xrefs it. Place a Pit Schedule on the sheet (CDSCHED). Save both.
   2. In the stage drawing, ignore one CDCHECKS finding (or save a CDCALC draft) and save. Open the sheet, reload the Xref, open the Pit Schedule window. Right looks like: status CURRENT and Project QA shows no "schedule out of date" failure.
   3. In the stage drawing change one pit size (900 to 1200), save, reload the Xref on the sheet. Right looks like: OUT OF DATE naming the stage drawing.
   4. Upgrade check: a sheet whose schedule was placed by the previous build reads CURRENT when nothing changed. Evidence: `C:\CE_WORK\codex\1765A_<date>\`.

6. **1767-A: a source gone after BIND reads frozen as placed (BUG-1149, PR #1767; draft, switch `linking.pitScheduleBoundSourceFrozen`, ON; first confirm it is in the build under test).** Why not the robot: XREF Bind, a second drawing, a file rename on disk. Copies only.
   1. Drawing with a CE Civil Xref and a placed linked Pit Schedule. Right looks like: CURRENT.
   2. XREF, select the Xref, Bind (Bind type, then repeat on a fresh copy with Insert type). Save.
   3. Open PITSCHEDULE. Right looks like: SOURCE NOT FOUND with "If you bound the Xref, the schedule is frozen as placed. The placed schedule is preserved." Update is not offered and the placed schedule does not change.
   4. Check Drawing / project QA. Right looks like: the schedule line is a warning (Unknown) with the same sentence, not a Fail.
   5. Control, in a copy: rename the Xref file on disk instead of binding, then reload. Right looks like: still SOURCE MISSING and a Fail.
   6. Set the switch false before launch and repeat steps 3 and 4: the old SOURCE MISSING and Fail. Evidence: `C:\CE_WORK\codex\1767A_<date>\`.

---

## 5. Fixes skipped as robot cases, and why

1. **#1881 (BUG-587), BLOCKED-FOR-ROBOT:** needs a drawn schedule; `Continue to Place / update` is disabled for the robot (probes pPS and pPSc). Codex look 1881-A. Already K1_09 in the wave-1 file; not drafted twice.
2. **#1760 (BUG-1196), BLOCKED-FOR-ROBOT:** needs a placed schedule and PITEDIT's Save button (not on the press list, README batch 3). Codex look 1760-A.
3. **#1764 (BUG-1198), BLOCKED-FOR-ROBOT:** Export CSV and Export Excel are refused buttons and open a file chooser. Codex look 1764-A.
4. **#1765 (BUG-1145), BLOCKED-FOR-ROBOT:** a sheet that Xrefs a stage drawing: a second drawing and an Xref. Codex look 1765-A.
5. **#1767 (BUG-1149), BLOCKED-FOR-ROBOT:** XREF Bind and a renamed file on disk. Codex look 1767-A.
6. **#1722 (BUG-1035):** drafted in part (W1722 and W1722_BROKEN). The Settings box and typed rows are Codex look 1722-A.

---

## 6. What was read, built, tested, and what is NOT proven

1. **Read:** the files and PR texts listed in section 1, and the Civil source on `origin/claude/rel-20261102a` by `git show` and `git grep`. I did not read the installed DLL; the build 3.0.88+3fbb9da5 comes from the header of the last probe reports.
2. **Built:** nothing. **Tested:** nothing. No AutoCAD was opened, the robot was not run, no settings file was read or written.
3. **NOT proven:** that W1722 passes (section 2 items 3, 4 and 5 are the risks); that the twin goes red on the Shallow check; that the installed build holds #1881 or #1767; anything about the five Codex-only fixes beyond the PR text, which is the writers' own account and has not been seen in AutoCAD.
4. **Honest limit of the twin:** it shows the case can tell a 300 mm line from a 2000 mm line. It is not a failure on the build from before PR #1722.
5. **Safety:** the case never unlocks a layer, detaches an Xref or bypasses an AutoCAD protection; it presses only Link and overrides (a column view) and Close. It does not press Export.
