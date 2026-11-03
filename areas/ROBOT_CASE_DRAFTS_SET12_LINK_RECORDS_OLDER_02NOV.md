# Robot case drafts, set 12: pit and pipe link records, older fixes (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** One robot case with its broken twin, plus Codex look notes for the other five fixes. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; this is the only file written. No git write (only `git fetch`, `gh pr view` and `gh pr diff`, all read-only).

---

## FOR TIM

1. **Done.** One robot test written on paper with its deliberately wrong copy: **W1752** (one damaged pit record no longer stops a new pipe linking to its good pits) and **W1752_BROKEN**. Nothing for you to test or decide.
2. **Example.** W1752 places two pits, damages the saved link record on pit P3 (the way the damaged-record setups do, with no typed LISP), draws a pipe between the two good pits, then moves the first pit 1000 mm east. Right looks like: CE names P3 once on the command line, and the pipe's end moves 1000 mm with its pit.
3. **Codex only (five fixes, notes below):** #1748 and #1777 need a PC with no CE pipe add-on, #1758 needs a paste, save and reopen, #1816 needs two Xref drawings, #1712 needs a four-pit diamond with several windows whose wording nobody has seen.
4. **Opus review before run:** none of the six touches Undo, REDO or a locked layer. #1816 touches Xrefs and #1712 is the level cascade (its PR asked for an Opus review before the train). W1752 must still go to the usual batch review because it writes a damaged record into the open drawing copy.
5. **A correction to the brief.** All six PRs show OPEN on GitHub (not merged). The code for #1748, #1752, #1758, #1777 and #1712 is present on `origin/claude/rel-20261102a` (found by name). **The code for #1816 was not found on that line**, so it may not be in any installed build. I did not read the installed DLL, so "installed" is not verified for any of the six.
6. **Not proven:** every printed line and window word below that I did not see on a run is marked DERIVED. W1752's twin proves the line check can go red, not that the old build fails (see section 1, item 5).

---

## 1. How the drafts are written (read before validating)

1. **Format.** README_CASES.md format. Every `type` chain is a complete command, no `(`, no SAVE-type word. REVIEWED_AGAINST is left empty. Fixture DRV1_B1, SLOT fresh, order numbers 810 and 811.
2. **Checked again before drafting (read-only).** No case or draft exists for any of the six: I searched `C:\Lisp Files\_ACAD_DRIVER\cases` (main, `drafts_*`, `variants`, `_setups`, `held_dmg_lisp_blocked`), `runner-reports\ledger.json` (its only hits are run ids and hashes, not these bugs), and every `ROBOT_CASE_DRAFTS_*.md`. The nearest neighbours are **W1892** (BUG-1141, a damaged record named at U, a different fix) and **W1952**; neither covers BUG-1142. No ledger or REGRESSION_LOG entry proves any of the six under a case id.
3. **How the damage is made.** The `v3 record-set` verb writes the one word DMGBROKEN2A4 into pit P3's `PIT_LINK` record through COM, as `_setups\SETUP-DMG-LINKS.setup.txt` does (the file now uses `record-set`, not typed LISP). The W1892 draft's header still says "blocked by typed LISP"; that header looks stale, but I did not verify that `record-set` has run for `PIT_LINK` (the setup says it was proven on PROBE-RS-PIT and PROBE-RS-NOD). W1752 puts the three `record-set` steps inline because a case can name only one SETUP and this one needs two new pits.
4. **Why no setup.** SETUP-P8 places one pit and a pipe; W1752 needs a second pit at the pipe's far end, so it repeats the SETUP-P8 PIT route twice and the CD route once.
5. **No switch to turn off.** The PR text says plainly: "No Settings switch" for #1752. So the twin cannot be a switch-off twin. It is a **no-damage twin**: same route, no damage, still expects the CE line, so the line checks go red. That proves those checks can fail. **It does not prove the old build loses the link.** The old-build red for the move check needs a run on an install from before the fix (Civil 3.0.71 or earlier). The pipe-follows check (box corner moves 1000 mm) is the part that would also fail on the old build, because the old build links the pipe to no pit.
6. **Pipe-follows check.** The robot cannot read a pipe object's end points. R02 proved the pipe's box corner (`x` and `y` of the CeCvlPipeObject) sits 225 mm east of the start pit's centre. After a 1000 mm move east of the start pit the corner should read 151225. That is DERIVED from R02's number and not seen on a run.
7. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_set12_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
8. **Run alone, outside Tim's hours.** The two PIT windows and the CD window take 45 s to 4 minutes each under load: TIMEOUT 1500.

---

## 2. The case

### Case 1 of 1: W1752, one damaged pit record: the pipe still links to its two good pits (PR #1752, BUG-1142, pilot-critical)

**Intended file:** `W1752_one_damaged_pit_record_pipe_still_links.case.txt`

```
# W1752 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1752 (BUG-1142, pilot-critical batch 1), base claude/rel-20261024m; code present on origin/claude/rel-20261102a (LinkService.Geometry.cs RemovePipeLinksFromAllOwners, LinkService.Persistence.cs UnreadablePitRecordLine). No Settings switch (PR text: "No Settings switch").
# Route: two new pits (the SETUP-P8 PIT route twice, 20 m apart), then the saved link record on pit P3 (109D56) is damaged with the v3 record-set verb (same call as SETUP-DMG-LINKS), then CD draws a pipe between the two new pits, then the first new pit is moved 1000 mm east.
# Words from the PR text and installed source, DERIVED (not seen on a run): '[CE] The CE link record on pit P3 could not be read, so CE left that pit as it is and linked the pipe to the other pits. That pit may not follow its pipes when it is moved.' (UnreadablePitRecordLine). The pit name is the one CE holds for handle 109D56; P3 is DERIVED, so only 'on pit P' plus 'could not be read, so CE left that pit as it is' is matched. The log line '[Link] BUG-1142: pit 109D56 (' is matched on the handle. The line is written once per drawing per pit (UnreadablePitRecordsNamed), so the count is 1.
# DERIVED: the second pit is named P9; the flow line reads 'Flow: P8 -> P9'; pick-first accepts a {$variable} handle; the pipe box corner follows the pit 1000 mm east (R02: corner x 150225 for a pipe starting on the pit at 150000).
# No U is typed anywhere: a U runs the full link rebuild that W1892 (BUG-1141) judges, and would mix two fixes in one log.
# Remembered values: YES (PIT and CD remember cover level and inverts); the guard restores CD_Settings.json. No SETTING line here, so hashes-unchanged is used.
CASE W1752
TITLE One damaged pit record (P3) no longer stops a new pipe linking: CE names P3 once, leaves its record as it is, and the pipe follows its start pit when that pit is moved
PLAN_ITEM BUG-1142 (PR #1752) PART: new CD pipe between two good pits with one damaged pit record elsewhere: the line names the damaged pit once, the damaged record is left unchanged, and the pipe's start follows its pit. NOT whole: the Edit Pipe save route (the other caller of the same scan), the pit at the pipe's far end following a move, and the "pipe not half-registered" note (RegisterPipe still saves first, PR text) are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 810
TIMEOUT 1500
BUG BUG-1142
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After the damage, the record on pit 109D56 reads back starting DMGBROKEN2A4. The CD pipe from the first new pit (150000,-80000) to the second (170000,-80000) is placed; the command line holds the line '[CE] The CE link record on pit P... could not be read, so CE left that pit as it is and linked the pipe to the other pits. That pit may not follow its pipes when it is moved.' exactly once; the Civil log holds '[Link] BUG-1142: pit 109D56 ('. The record on 109D56 still reads back starting DMGBROKEN2A4 after the pipe and after the move (left exactly as it was). After MOVE of the first new pit 1000 mm east, the pipe's box corner x reads 151225 (within 50 mm) instead of 150225, which means the pipe was linked to that pit. One new pipe, two new pits.
WHY_NOT_UNIT_TEST The unit tests read ten records in memory and pin a source order; only AutoCAD walks every pit's real record at the moment CD links a new pipe, and only a real MOVE shows whether the pipe was linked.
NOT_AUTOMATED SEEN by Codex: the pipe end visibly stretches with the moved pit and P3 itself is untouched (the robot reads the pipe's box corner only, not its end points).
NOT_AUTOMATED The Edit Pipe save route (CDEDIT, Edit pipe, Save) uses the same scan and is not driven here.
STEPS
  copy-info -> $copy0
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -> $pitA_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pitA_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pitA_e1
  esc-prompt -> $pitA_e2
  esc-prompt -> $pitA_e3
  type "PIT{NL}170000,-80000" -Force -ExpectWindow "New Pit" -> $pitB_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pitB_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pitB_e1
  esc-prompt -> $pitB_e2
  esc-prompt -> $pitB_e3
  v3 record-set ent 109D56 -Part CE_CVL_SUITE_LINKS/PIT_LINK -To READ -> $dmg_before
  v3 record-set ent 109D56 -Part CE_CVL_SUITE_LINKS/PIT_LINK -To DMGBROKEN2A4 -> $dmg_write
  v3 record-set ent 109D56 -Part CE_CVL_SUITE_LINKS/PIT_LINK -To READ -> $dmg_after
  wait
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $pipe_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $pipe_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $pipe_e1
  wait
  sleep 3
  v3 record-set ent 109D56 -Part CE_CVL_SUITE_LINKS/PIT_LINK -To READ -> $dmg_after_pipe
  ms-new $n0 -> $new_all
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $all_pits
  select $new_all object=AcDbBlockReference "near=150000,-80000,700" -> $pitA
  select $new_all object=CeCvlPipeObject -> $pipes
  field $pitA handle -> $hA
  field $pipes x -> $px0
  pick-first "{$hA}"
  type "_.MOVE{NL}0,0{NL}1000,0" -Force -> $mv_a
  wait
  sleep 3
  ms-new $n0 -> $after_move
  select $after_move object=CeCvlPipeObject -> $pipes1
  field $pipes1 x -> $px1
  v3 record-set ent 109D56 -Part CE_CVL_SUITE_LINKS/PIT_LINK -To READ -> $dmg_after_move
  windows-snapshot -> $win_end
  log-read civil -> $civlog
ASSERT
  contains $dmg_after "DMGBROKEN2A4"
  history count "[CE] The CE link record on pit P" = 1
  history has "could not be read, so CE left that pit as it is and linked the pipe to the other pits. That pit may not follow its pipes when it is moved."
  log civil has "[Link] BUG-1142: pit 109D56 ("
  history has "Inserted flow arrow. Flow: P8 -> P"
  history absent "Flow: P8 -> Open end"
  contains $dmg_after_pipe "DMGBROKEN2A4"
  contains $dmg_after_move "DMGBROKEN2A4"
  count $all_pits = 2
  count $pipes = 1
  number $px0 = 150225 +- 50
  number $px1 = 151225 +- 50
  not-contains $win_end "Creative Engineering"
  hashes-unchanged
  copy-unchanged $copy0
  record $dmg_before "FULL the P3 link record before the damage (first 60 characters)"
  record $pipe_t1 "FULL what CD printed at its first prompts"
  record $pipe_e1 "FULL what the closing Esc printed (the CE line may be here)"
  record $mv_a "FULL what the MOVE printed"
  record $civlog "FULL civil log lines since the case began (look for BUG-1142)"
```

**Twin:** `W1752_one_damaged_pit_record_pipe_still_links_BROKEN.case.txt`

```
# W1752_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The no-damage twin (the PR has no switch to turn off). Same route and the same checks as W1752, but the three record-set damage steps are left out, so no pit record is unreadable and CE has nothing to name. The CE line checks MUST FAIL. The pipe-follows check should still PASS (nothing was damaged). This proves the line checks can go red; it does NOT prove the old build fails. The old-build red needs a run on an install from before the fix (Civil 3.0.71 or earlier), where both the line checks and the pipe-follows check are expected to fail with the record damaged.
CASE W1752_BROKEN
TITLE BROKEN VARIANT of W1752: no pit record is damaged, but the case still expects CE to name a damaged pit (must FAIL on the line checks)
PLAN_ITEM red-before-green proof for W1752 (BUG-1142), line checks only
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 811
TIMEOUT 1500
BUG BUG-1142
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1752
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with nothing damaged CE prints no 'The CE link record on pit' line and writes no BUG-1142 log line, so the two line checks fail. The pipe is still placed and still follows its pit, so those checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1752's line checks can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -> $pitA_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pitA_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pitA_e1
  esc-prompt -> $pitA_e2
  esc-prompt -> $pitA_e3
  type "PIT{NL}170000,-80000" -Force -ExpectWindow "New Pit" -> $pitB_t1
  ui2-set "New Pit" "C2.CoverLevel" "19.000"
  ui-press "New Pit" "New pit, Continue placement" -> $pitB_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pitB_e1
  esc-prompt -> $pitB_e2
  esc-prompt -> $pitB_e3
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $pipe_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $pipe_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $pipe_e1
  wait
  sleep 3
  ms-new $n0 -> $new_all
  select $new_all object=AcDbBlockReference "near=150000,-80000,700" -> $pitA
  select $new_all object=CeCvlPipeObject -> $pipes
  field $pitA handle -> $hA
  field $pipes x -> $px0
  pick-first "{$hA}"
  type "_.MOVE{NL}0,0{NL}1000,0" -Force -> $mv_a
  wait
  sleep 3
  ms-new $n0 -> $after_move
  select $after_move object=CeCvlPipeObject -> $pipes1
  field $pipes1 x -> $px1
  log-read civil -> $civlog
ASSERT
  count $pipes = 1
  number $px0 = 150225 +- 50
  number $px1 = 151225 +- 50
  history count "[CE] The CE link record on pit P" = 1
  log civil has "[Link] BUG-1142: pit 109D56 ("
  record $civlog "FULL civil log lines since the case began"
```

---

## 3. Codex look notes (fixes the robot cannot prove)

Each note: evidence folder under `C:\CE_WORK\codex\`, copies of drawings only, never accept a picture or folder that a Save or Open box opened in, and never unlock a layer, detach or unload an Xref, or unload the pipe add-on on Tim's own AutoCAD to make a check pass.

### K12_01: #1748 (BUG-1138) and #1777 (BUG-1151): no pipe add-on on the PC (BLOCKED-FOR-ROBOT)

**Why the robot cannot:** both fixes act only on a PC where CE pipe objects cannot be read (AutoCAD 2022 to 2024, no CE pipe add-on). The robot's AutoCAD is 2027 with the add-on loaded; making it unreadable would mean unloading the add-on, which is a protection bypass this task forbids. No switch exists for either fix (PR texts).

**Steps for Codex (PC with AutoCAD 2022 to 2024 and the current CE suite, no pipe add-on; copy a 3.0.7x drawing with CE pipe objects drawn on 2027; folder `C:\CE_WORK\codex\k12_01_unloaded_pipes\`):**
1. Open the copy. Type `CDSYNC`. Right looks like (DERIVED from PR #1748): `[CE] CDSYNC stopped: this drawing has 50 CE pipe objects this AutoCAD cannot read (the CE pipe add-on is not loaded on this PC). Every pit keeps its pipe list; nothing was changed. ...` with the right count for that drawing, and nothing else changed. Photograph the command line.
2. Type `U`. Right looks like: nothing CE to undo.
3. MOVE one pit that has a CE pipe object. Right looks like (DERIVED, PR #1748): one `[CE] Pipe relink stopped: ...` line. Then (DERIVED, PR #1777) one line naming each CE pipe object that stayed behind: `[CE] The pit moved but the CE pipe object P1 -> P2 stayed where it was: this AutoCAD cannot read it ...`. The pit moves, the pipe stays.
4. Type `U`. Right looks like: the pit goes back.
5. On Tim's 2027 PC, same drawing copy: CDSYNC prints the normal `CDSYNC complete` line, no stop line, and MOVE of a pit prints neither new line.
6. Record: PC and AutoCAD year, CE version, the exact lines.

### K12_02: #1758 (BUG-1150): pasted CE pits wake Civil after reopen (BLOCKED-FOR-ROBOT)

**Why the robot cannot:** it needs a paste into a second, new drawing, a save, a close and a reopen. The robot works on one drawing copy, refuses a Save, and cannot reopen inside a case. Switch: `linking.civilWakesForPitsWithoutRecord` (ON by default, read at start-up; present on rel-20261102a with default tests).

**Steps for Codex (copy of a CE drawing with a few pits and pipes; folder `C:\CE_WORK\codex\k12_02_paste_wakes_civil\`):**
1. Select the network (pits and pipes) and press CTRL+C.
2. Open a new drawing, save it as `Synthetic site A.dwg` in the evidence folder (a copy, not a job folder), then press CTRL+V.
3. If CDREPAIR advice appears, ignore it. Save and close.
4. Reopen the file. MOVE pit P3 a short way. Right looks like: the pipes at P3 stretch with it and its labels and cover text move with it. Wrong (the old fault): the pit moves alone.
5. Open an ordinary drawing with no CE pits. Right looks like: it opens quiet, no CE message.
6. Optional comparison: close AutoCAD, set `linking.civilWakesForPitsWithoutRecord` to false in a copy of the settings file (never Tim's live one without the desk's word), start AutoCAD, repeat 1 to 4: the old fault returns.

### K12_03: #1816 (BUG-1044): other Xref pits stay when two Xrefs both have a pit "P1" (BLOCKED-FOR-ROBOT)

**Why the robot cannot:** two Xref drawings attached from a file picker, then a window action. No switch name is on rel-20261102a (the key `linking.xrefScheduleKeepsNonClashingRows` was not found there), so first confirm the build under test holds this fix by reading its version line.

**Steps for Codex (two source drawings, A with pits P1 and P2, B with pits P1 and P3; folder `C:\CE_WORK\codex\k12_03_xref_clash\`):**
1. Open the Pit Schedule window and select A and B. Right looks like (DERIVED from PR #1816): P2 (from A) and P3 (from B) stay listed; the Data check says `[CE] Pit P1 appears in A and B. Rename it in a source drawing. This number is left out of the schedule.`; Continue to Place is available for the other pits. Wrong (the old fault): the whole schedule is empty and Continue to Place is stopped.
2. Do not press anything that renames or deletes in the source drawings; both original P1 records stay untouched.
3. Photograph the window in dark and light themes.

### K12_04: #1712 (BUG-811, level cascade half): a rejoining pit follows the lowest arriving pipe

**Why the robot cannot yet (not "never"):** a diamond (A to B, A to C, B to D, C to D) needs four pits and four pipes (eight windows), then the Edit Pipe older-version question, the Recalculate box, the Cascade Preview and a CDPROPAGATE route whose prompts after the anchor pick I did not find in the source in the time allowed. The only numbers I have are from the unit test: pit drop 50 mm, arrivals 10.30 via B and 10.00 via C, outlet 9.95. Writing a case on that would have had too many DERIVED parts to be trusted. If Tim wants it, the next drafter should read `LinkCommands.cs` CDPROPAGATE past line 524 and `Bug811RejoinCascadeOrderTests.cs`, then use the Pit Schedule dump (R02 route) to read pit D's outlet IL.

**Steps for Codex (copy of a drawing; folder `C:\CE_WORK\codex\k12_04_rejoin_cascade\`):**
1. Build A (150000,-80000), B (160000,-76000), C (160000,-84000), D (170000,-80000) with PIT, cover level 19.000 each. Draw pipes A to B (10.00 / 9.90), A to C (10.00 / 9.60), B to D (9.90 / 9.30) and C to D (9.60 / 9.30) with CD (Charged unticked).
2. Edit Pipe on A's outlet pipe, raise its upstream level by 0.50, Yes to Recalculate downstream, Apply.
3. Right looks like (DERIVED from PR #1712): D's outlet IL is one pit drop (50 mm) under the LOWEST pipe arriving at D, with no step at D. Read the IL texts at D and the Pit Schedule row for D. Wrong (the old fault): D's outlet sits above the lowest arrival (10.25 against 10.00 in the unit test).
4. Press U once. Right looks like: every level back as before. Do not press REDO (BUG-861).

---

## 4. Fixes skipped as a robot case, and why

1. **#1748 (BUG-1138):** Codex only (K12_01): needs a PC without the pipe add-on.
2. **#1777 (BUG-1151):** Codex only (K12_01): same PC; the line only appears there.
3. **#1758 (BUG-1150):** Codex only (K12_02): paste, save, reopen in a second drawing.
4. **#1816 (BUG-1044):** Codex only (K12_03): two Xref drawings; also its code was not found on the 2 Nov line.
5. **#1712 (BUG-811 cascade half):** not drafted (K12_04): too many unseen windows and prompts; a first run would mostly test my guesses.
6. **#1752 (BUG-1142):** drafted (W1752 and W1752_BROKEN above).

---

## 5. What was read, built, tested, and NOT proven

1. **Read:** `C:\TimOS\RULES.md`, `README_CASES.md`, the TOP12 example (first 830 lines), the WAVE1 switch-off notes, `R02`, `R11`, `W1892`, the DMG setups, `C79B1_FIXTURE_NOTE.md`, the six PR texts (`gh pr view`), the #1752 diff, the carpark entries (BUG-1142 in full), and the installed-line source on `origin/claude/rel-20261102a` for the BUG-1142 scan, its printed line and the BUG-811 unit-test numbers.
2. **Built:** nothing. **Tested:** nothing. **Installed:** not checked (the DLL's product version was not read). **Accepted:** nothing (a draft is not accepted by anyone).
3. **NOT proven:** that `record-set` works on `PIT_LINK` for pit 109D56 in DRV1_B1 (W1892's own notes say the same is unconfirmed); that pit 109D56 is named P3; the pit names P8 and P9; the pipe box corner after a pit move; that `pick-first` accepts a `{$variable}`; that the old build is red for W1752 (needs a pre-fix install); every window wording in the Codex notes.
4. **BUG_CARPARK:** no status was changed. None of the six may be marked FIXED on this paper alone.
