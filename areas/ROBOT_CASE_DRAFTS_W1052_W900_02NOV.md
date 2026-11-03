# Robot case drafts: draft PRs from jobs 300 to 307 (BUG-027, BUG-1042, BUG-1053, BUG-1166, BUG-900) (Tue 3 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get, plus Codex look steps for what the robot cannot prove. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. (The order gave the path as `C:\CE_PLANreas\...`; I took that as a lost backslash and wrote to `C:\CE_PLAN\areas\`.)

---

## FOR TIM

1. **Five jobs opened a pull request, two did not.** Drafted: BUG-027 (#1997), BUG-1042 (#1996), BUG-1053 (#1995), BUG-1166 (#1998), BUG-900 (#1999). Skipped: BUG-1052 (fix only on a local branch, no PR) and BUG-396 (not built, no PR).
2. **Two cases the robot can run, each with a twin that must fail:** W1027 (a pipe label with only the first level typed must not end in "MIN.") and W1042 (New Pit with the cover level blank must still let you press Place). The twins turn the fix's own switch off before AutoCAD starts. Order numbers 800 to 803.
3. **Four things the robot cannot prove, written as Codex steps:** Edit Pit saving with a blank cover, the LandXML millimetre levels (BUG-1053), the multi-page PDF (BUG-900) and the OneDrive office folders (BUG-1166). Reasons: the robot cannot choose a file in a file box, cannot press Edit Pit's Save, and cannot change which folders exist on the PC.
4. **None of the five fixes is in any build yet.** I checked each pull request against Civil 3.0.89 (commit 61fd6fbc), the first candidate (rel-20261108a, 3.0.90) and the second (rel-20261110a): not in any of them, and none of their switch names appear in the code of any of the three. So on the installed build the cases are meant to fail, and a pass tells us nothing until a build holding the fix is installed.
5. **One thing to look at:** three of these jobs (BUG-027, BUG-1042, BUG-1053) report that your real `CD_Settings.json` came back with an old date (4 Oct, 15,270 bytes) after their runs. They think another job's AutoCAD did it, but all three flagged it and none could prove it. I did not open the file. CE 01 should look before any merge.
6. **Not proven:** every window word and button name marked DERIVED was read from code or earlier reports, not seen on a run. No case was checked with the runner's `validate`. Nothing for you to test or decide.

---

## 1. What I checked, and where each fact came from

1. **Fetch first.** `git fetch origin` ran at the start. Tips seen: `rel-20261102a` = 3fbb9da5, `rel-20261108a` = cf059dcf (Civil 3.0.90 candidate b1), `rel-20261110a` = aa3b92ac (b2). Commit 61fd6fbc exists locally. I did not read the installed DLL's version string, so "Civil 3.0.89 = 61fd6fbc" is the order's word, not my check.
2. **Pull requests (read with `gh pr list --state all --search ...`; `gh` is at `C:\Program Files\GitHub CLI\gh.exe`, not on the shell PATH).** All five are open drafts, base `claude/rel-20261102a`:
   1. **#1997** B-174 BUG-027, head 352a838b, switch `pipe.gradeLabelNeverMin`, ON.
   2. **#1996** B-173 BUG-1042, head 6e3b64df, switch `pit.blankCoverIsWarningNotBlock`, ON.
   3. **#1995** B-172 BUG-1053, head 26afae19, switch `xcivilImport.landXmlLevelsConvertedToMetres`, ON.
   4. **#1998** B-176 BUG-1166, head 6f5a80d9, switch `linking.officeFolderFollowsOneDrive`, ON.
   5. **#1999** B-177 BUG-900, head 3a6a0b80, switch `xcivilImport.pdfScheduleReadsAllPages`, ON.
3. **Where each is, against the builds (read with `git merge-base --is-ancestor` on each PR head, fetched with `git fetch origin pull/<n>/head`).** All five answer NO for 61fd6fbc, rel-20261108a and rel-20261110a. A search of `Modules` in those three commits for each switch name found zero files (a control search for `scaleNoteOnReviewPage`, which is in 61fd6fbc, found five, so the search works).
4. **Settings group names** (BUG-027 `PipeSettings` under `"pipe"`, BUG-1042 `PitSettings` under `"pit"`, BUG-1053 `XcivilImportSettings`) were read in `UserSettings.cs` on the PR heads. The `SETTING CD_Settings.json <group.key> false` form is the one the 1195 draft and README_CASES use. The group names for `xcivilImport` and `linking` were not re-read.
5. **Reports read in full:** `BUGFIX_w027`, `w1042`, `w1052`, `w1053`, `w1166`, `w396`, `w900` (all 03NOV). **Cases read:** README_CASES.md in full; K02 (BUG-027, 30 Oct corrected copy), N05, R24, R29, R37; the style file `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` (parts).
6. **What the robot has (README_CASES):** it can set a Settings key through the guard before AutoCAD starts, type chains, set and press window controls (New Pit, New Pipe) and read controls and text with `ui-dump`, `control` and `control-text`. It cannot: choose a file (the file box allows Cancel only, R29 header), press Edit Pit "Edit pit, Save" (not on the press list, README batch 3 item 5), set environment variables, or create or hide folders. No metre-authored drawing exists on this PC (R24 header), so INSUNITS 6 cases are an artefact risk.

---

## 2. Case texts (runner-ready)

**How these are written.** README_CASES.md format. Fixture DRV1_B1, SLOT fresh. REVIEWED_AGAINST empty. Run alone, outside Tim's hours (8:30am to 2:00pm and 3:00pm to 5:30pm Melbourne). No case saves, unlocks, detaches or bypasses anything. Validate first without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_w1027_w1042_03nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.

### Case 1 of 2: W1027 and W1027_BROKEN (BUG-027, PR #1997, orders 800 and 801)

**Intended file:** `W1027_one_level_pipe_label_never_ends_in_min.case.txt`

```
# W1027 DRAFT (read-only drafter, Sonnet, 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #1997 (B-174, BUG-027, carpark stays OPEN). Same route as K02 (30 Oct corrected copy, drafts_carpark_30oct), now with an order number, the fix's own switch twin, and EXPECT-FAIL for the installed build. Tim's ruling UX-CPLAN-05 (26 Sep 11:46): "Keep the May rule: no MIN."
# The fix is NOT in Civil 3.0.89 (61fd6fbc), nor in rel-20261108a (cf059dcf) nor rel-20261110a (aa3b92ac): checked 3 Nov. On those builds this case should FAIL on 'not-contains $lt "MIN."' (the old label ends 'MIN.'). Remove the EXPECT-FAIL line once a build holding #1997 is installed.
# Switch: pipe.gradeLabelNeverMin, ON by default. This case sets nothing and proves the shipped default; the twin sets it false.
# Route (K02, DERIVED from code, never run): CD with two typed points opens New Pipe; Standard grade, 'I know one end' off, second level switched off by its screen name 'Set second end level' (the old id C2.SecondInvertEnabled belongs to a hidden toggle). Remembered values: YES. Switching the second level off is saved to CD_RecentValues.json (the guard does not restore that file), so the case ends with a reset pipe that turns it back on.
CASE W1027
TITLE A pipe with only its first level typed (Standard grade) gets a label ending in the grade number, with no MIN.
PLAN_ITEM PR #1997 (B-174, BUG-027), Tim's ruling UX-CPLAN-05 of 26 Sep 2026
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 800
TIMEOUT 900
BUG BUG-027
EXPECT-FAIL BUG-027
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CD from 150000,-96000 to 170000,-96000 with Standard grade, 'I know one end' off, first level 18.000 and the second level switched off: Start Pipe gives exactly one pipe and one label matching '<size> DIA. <material> PIPE AT 1 IN <n>' with nothing after the number, never 'MIN.'. Exactly one IL text (IL 18.000). A reset pipe (150000,-100000 to 170000,-100000, both levels) follows and is recorded. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The older unit test asserted the opposite (100 MIN.); only the drawn label in a live CD shows what the drafter gets.
NOT_AUTOMATED Edit Pipe's twin path for the same label is not driven.
NOT_AUTOMATED How the label looks is not judged; only its words.
STEPS
  copy-info -> $copy0
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM _W 148000,-102000 172000,-94000" -Force
  wait
  ms-count -> $c0
  type "CD{NL}150000,-96000{NL}170000,-96000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" ""
  ui2-set "New Pipe" "Set second end level" "off"
  ui-dump "^New Pipe" -TimeoutSec 60 -> $np
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new
  select $new "object~^CeCvlPipeObject$" -> $pipe
  select $new "text~ DIA\. " -> $label
  field $label text -> $lt
  select $new "text~^IL " -> $ils
  field $ils text -All -> $ilt
  ms-count -> $cR
  type "CD{NL}150000,-100000{NL}170000,-100000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "Set second end level" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
  windows-snapshot -> $win_end
ASSERT
  count $pipe = 1
  count $label = 1
  not-contains $lt "MIN."
  matches $lt "^\d+ DIA\. \S+ PIPE AT 1 IN \d+$"
  count $ils = 1
  contains $ilt "IL 18.000"
  not-contains $win_end "Grade mismatch"
  copy-unchanged $copy0
  record $lt "FULL the pipe label text"
  record $np "FULL New Pipe window before Start Pipe (second level off)"
  record $cd "FULL CD"
  record $cdR "FULL CD reset pipe"
```

**Twin:** `W1027_BROKEN_one_level_pipe_label_never_ends_in_min.case.txt`

```
# W1027_BROKEN DRAFT (3 Nov 2026; NOT RUN). The fix's own switch-off control: pipe.gradeLabelNeverMin false BEFORE AutoCAD starts (CE reads settings at start). The old ' MIN.' label returns exactly (PR #1997 says so), so the case still expecting no MIN. must FAIL on the 'not-contains' and the 'matches' checks. Same route as W1027 up to the label; the reset pipe is kept so the remembered values go back.
# Meaningful only on a build that holds PR #1997. On 3.0.89 and the two candidates the key does not exist and the label is old anyway, so the twin fails for the same reason as W1027 and proves nothing about the switch. If it PASSES on a build holding #1997, the switch does not bring MIN. back and the fix cannot be told from the old build here: say so.
CASE W1027_BROKEN
TITLE BROKEN VARIANT of W1027: the new switch is OFF, so the label still ends in MIN. while the case expects none (must FAIL)
PLAN_ITEM red-before-green proof for W1027 (PR #1997, B-174, BUG-027)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.gradeLabelNeverMin false
ORDER 801
TIMEOUT 900
BUG BUG-027
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1027
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch off the label reads '... PIPE AT 1 IN <n> MIN.', so the two label checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1027's label checks can go red.
STEPS
  getvar OSMODE -> $osm0
  v3 setvar OSMODE 0 -> $osm_set
  type "_.ZOOM _W 148000,-102000 172000,-94000" -Force
  wait
  ms-count -> $c0
  type "CD{NL}150000,-96000{NL}170000,-96000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" ""
  ui2-set "New Pipe" "Set second end level" "off"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $start
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $esc1
  wait
  ms-new $c0 -> $new
  select $new "text~ DIA\. " -> $label
  field $label text -> $lt
  type "CD{NL}150000,-100000{NL}170000,-100000{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cdR
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeDefault" "on"
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "Set second end level" "on"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $startR
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $escR
  wait
ASSERT
  count $label = 1
  not-contains $lt "MIN."
  matches $lt "^\d+ DIA\. \S+ PIPE AT 1 IN \d+$"
  record $lt "FULL the pipe label text (must end MIN. with the switch off)"
```

### Case 2 of 2: W1042 and W1042_BROKEN (BUG-1042, PR #1996, orders 802 and 803)

**Intended file:** `W1042_new_pit_blank_cover_still_places.case.txt`

```
# W1042 DRAFT (read-only drafter, Sonnet, 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #1996 (B-173, BUG-1042, carpark stays OPEN). New Pit with the Cover level box blank: the Place button stays pressable and a line under the window says 'The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out.' (words from the PR's PitStartReadiness.cs line 94 and the w1042 report). The old build blocked the button with 'Enter the cover level.'.
# The fix is NOT in Civil 3.0.89 (61fd6fbc), rel-20261108a or rel-20261110a (checked 3 Nov). On those builds this case should FAIL at the 'enabled' check and the 'control-text' check. Remove EXPECT-FAIL once a build holding #1996 is installed.
# Switch: pit.blankCoverIsWarningNotBlock, ON by default. This case sets nothing; the twin sets it false.
# DERIVED, never seen on a run: (a) that the Place button is the one named 'New pit, Continue placement' (N05, N29 press it) and that its 'enabled' reading follows CanExecutePlace; (b) that the other fields (number, type, width, length) open filled so only the cover blocks (R24 and N05 set only the cover); (c) that Esc three times ends the label and cover prompts without a label or cover text (the proven SETUP-P8 route, N05_BROKEN); (d) that a blank cover leaves no 'CL ' text (the PR says FormatCoverText drops the CL line for a blank cover, read from its report, not seen).
# Remembered values: YES. PIT remembers the typed cover level; this case clears it, so after the run the remembered cover is blank. A later case that expects 19.000 sets it itself (N05 does).
CASE W1042
TITLE With the cover level left blank, New Pit's Place button is pressable, the pit is placed, and no cover text (CL) is drawn
PLAN_ITEM PR #1996 (B-173, BUG-1042) PART: New Pit only. NOT whole: PITEDIT saving a pit with a blank cover (the robot cannot press Edit pit, Save) is Codex look K1042E below; the line's wording and look are Codex too
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 802
TIMEOUT 900
BUG BUG-1042
EXPECT-FAIL BUG-1042
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED PIT at 150000,-80000 with the Cover level box cleared: the window shows the Place button enabled and a line containing 'The cover level is blank'; pressing it places exactly one pit block on STORMWATER PIT, adds no text starting 'CL ', prints 'Pit placed successfully.', and 'Enter the cover level' never appears on the command line. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the readiness rule and the view model; only the live window shows whether the button is pressable and the pit lands in the drawing.
NOT_AUTOMATED PITEDIT with a blank cover (Edit pit, Save is not on the press list): Codex look K1042E.
NOT_AUTOMATED That the line under the window is readable and not clipped: Codex look.
NOT_AUTOMATED That the stored cover is Unknown and not 0.000 is read only through the pit's plan text (no CL line); the stored value itself is not read by the robot.
STEPS
  copy-info -> $copy0
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" ""
  ui-dump "^New Pit" -TimeoutSec 60 -> $np
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  esc-prompt -> $pit_e1
  esc-prompt -> $pit_e2
  esc-prompt -> $pit_e3
  wait
  ms-new $n0 -> $new
  select $new object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
  select $new "text~^CL " -> $covers
  windows-snapshot -> $win_end
ASSERT
  control $np "New pit, Continue placement" enabled
  control-text $np has "The cover level is blank"
  control-text $np absent "Enter the cover level"
  history has "Pit placed successfully."
  history absent "Enter the cover level"
  count $pits = 1
  count $covers = 0
  not-contains $win_end "New Pit"
  copy-unchanged $copy0
  record $np "FULL New Pit window with a blank cover"
  record $pit_t2 "FULL what the Place press reported"
  record $new "FULL objects it added"
```

**Twin:** `W1042_BROKEN_new_pit_blank_cover_still_places.case.txt`

```
# W1042_BROKEN DRAFT (3 Nov 2026; NOT RUN). The fix's own switch-off control: pit.blankCoverIsWarningNotBlock false BEFORE AutoCAD starts. The old block returns ('Enter the cover level.', Place greyed, per the w1042 report item 6c), so the case still expecting a pressable button must FAIL. It does not press Place (a greyed button cannot be pressed); it reads the window, then closes it.
# Meaningful only on a build that holds PR #1996 (the key is unknown to older builds, which are already old-behaviour). If the 'enabled' check PASSES with the switch off, the switch does not restore the block and W1042 cannot tell old from new here: say so.
# DERIVED: that the old block line reads 'Enter the cover level.' in the window text (from PitStartReadiness.cs before the PR); the control-text 'absent' check will show whether the dump carries it.
CASE W1042_BROKEN
TITLE BROKEN VARIANT of W1042: the new switch is OFF, so a blank cover blocks Place while the case expects it pressable (must FAIL)
PLAN_ITEM red-before-green proof for W1042 (PR #1996, B-173, BUG-1042)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pit.blankCoverIsWarningNotBlock false
ORDER 803
TIMEOUT 900
BUG BUG-1042
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1042
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch off the Place button is greyed and the window says 'Enter the cover level.', so the 'enabled' and 'has' checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1042's button and wording checks can go red.
STEPS
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" ""
  ui-dump "^New Pit" -TimeoutSec 60 -> $np
  close-windows -> $closed
  esc-prompt -> $e1
  wait
  ms-count -> $n1
ASSERT
  control $np "New pit, Continue placement" enabled
  control-text $np has "The cover level is blank"
  record $np "FULL New Pit window with the switch OFF"
  record $closed "FULL what close-windows did"
  record $n1 "object count after (no pit expected)"
```

---

## 3. BLOCKED-FOR-ROBOT: Codex look steps (a Codex pass in real AutoCAD on copies only, screenshots and exact steps recorded)

Order numbers 804 to 807 are reserved for these four so the desk keeps one list. Every Codex run: work on a COPY of a drawing, never save, put any made-up test file in the desk's agreed scratch folder `C:\ce-fx\<job-id>\` only, and set a switch only through the settings guard (never by hand in Tim's real settings file). None of these fixes is in an installed build yet (Section 1, point 3), so Codex needs a build holding the PR first.

1. **K1042E (order 804), BUG-1042 (PR #1996): Edit Pit saves a pit whose cover is blank, and the cover stays blank.** Why not the robot: Edit pit, Save is not on the press list.
   1. Place a pit on a copy with the cover left blank, as in W1042 (the Place button must be pressable).
   2. Type `PITEDIT`, pick that pit. In Edit Pit change the width from 600 to 900 (any field except the cover). Look: the Save button is pressable.
   3. Press Save. Look: the window closes, the pit on the plan is drawn at the new width, and no "CL" cover text appears on the plan.
   4. Type `PITEDIT` and pick it again. Look: the Cover level box is empty, never 0.000. Press Close or Cancel, not Save.
   5. Broken twin (switch off): set `pit.blankCoverIsWarningNotBlock` false through the guard before launch and repeat step 2 on a pit with a blank cover. Right (old behaviour back): the Save button is grey and the window says "Enter the cover level.".
   6. Look at the line under the New Pit window ("The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out."): words readable, not clipped. The window layout was not changed by the PR, so a clipped line would be a new fault.
2. **K1053 (order 805), BUG-1053 (PR #1995): LandXML levels in millimetres come in as metres.** Why not the robot: the file box in the LandXML import window cannot be driven (R29 header); "Read source" is not on the press list.
   1. Make a made-up LandXML file `UNIT-RL-MM.xml` in the scratch folder. The PR's own test builds it like this (read from `Bug1053LandXmlLevelUnitTests.cs` on the PR head): a LandXML 1.2 file with `<Units><Metric linearUnit="millimeter"/></Units>` and one structure `P1` with `elevRim="100200"`, a centre of `6000 345 100200`, a 0.9 by 0.9 rectangular structure and `<Invert elev="100000"/>`. No client data.
   2. Open a fresh empty copy drawing with INSUNITS 4 (millimetres). Type `CDIMPORTLANDXML`. Choose the file. Press Read source.
   3. Look: the review line for P1 shows cover level 100.2 (or 100.20) and NOT 100200; the invert shows as IL 100, not thrown out. (The exact wording of the review line is not recorded in the report: read what it says and record it.)
   4. Import into the disposable copy only. Look: P1's cover reads 100.20 and its IL text reads "IL 100".
   5. Same file with `linearUnit="meter"`, rim 100.200 and invert 100.000: same cover and IL.
   6. Broken twin 1 (switch off): set `xcivilImport.landXmlLevelsConvertedToMetres` false through the guard before launch and repeat steps 2 and 3. Right (old behaviour back): the review reads 100200 and P1 has no IL.
   7. Broken twin 2 (unknown unit): a file with `linearUnit="furlong"`. Right: P1 comes in with a blank cover (Unknown), and the import report says the levels are Unknown. It never blocks.
   8. Not decided: a file with no Units line is read as metres (as today). Tim has a pending question on this in the w1053 report (item 7); do not judge it.
3. **K900 (order 806), BUG-900 (PR #1999): an X-Civil PDF whose pit schedule runs over two or more sheets is read from every sheet.** Why not the robot: it needs a chosen DWG and PDF (file box), Windows text recognition on a real PDF, and a sample that does not exist in the repo (w900 report item 5).
   1. Someone makes a made-up PDF with a PIT SCHEDULE split over two sheets, each sheet titled PIT SCHEDULE, plus a made-up pipe schedule on two sheets, and the matching DWG. No client data. Without this nothing can be run.
   2. Open a copy drawing. Type `CDIMPORTXCIVIL`. Choose the DWG and the PDF, read the source, then look at the pit and pipe schedule page and the import report.
   3. Right (switch on): the report has lines `pit-schedule-page-read page=1 rows=N` and `page=2 rows=M`, and `pit-schedule-total-rows=` equal to N+M. Pits listed on sheet 2 carry sizes and levels. The pipe schedule has rows from every sheet, not only the last.
   4. Right for a sheet titled PIT SCHEDULE with no readable table: a warning in the import report and the import carries on.
   5. Press Close, never "Import to drawing", unless the import is into a disposable copy and the desk asked for it.
   6. Broken twin (switch off): set `xcivilImport.pdfScheduleReadsAllPages` false through the guard before launch and repeat. Right (old behaviour back): no `page-read` lines, pits on the other sheet come in without sizes and levels.
   7. Known gap, not claimed: a continuation sheet whose top does not read as PIT SCHEDULE is not detected and gets no warning (w900 report item 4).
4. **K1166 (order 807), BUG-1166 (PR #1998): Civil finds the office folders under OneDrive.** Why not the robot: the case needs a PC profile where the Users\Creative Engineering folders do not exist but the office folder exists under `%OneDriveCommercial%\Creative Engineering - Drafting\...`. The robot cannot set environment variables or create, hide or rename folders, and it must never move Tim's real folders.
   1. Use a test Windows profile or a PC set up the way the office folders arrive ("Add shortcut to My files"), such as Max's. Tim's own PC must not be altered. The carpark asks for a look at Max's real OneDrive layout before 9 Nov (w1166 report item 6); that look has not happened.
   2. Start AutoCAD with the fixed build. Type `CDWT`. Right: the command line does NOT print the old tank questions, the tank pictures show, and the CE log holds the line `[BUG-1166] options.standardDetailsCivilFolder was not on this PC; using the office folder on OneDrive`. (Wording read from the w1166 report item 7: read the CE log for the exact line and record it.)
   3. Type `CDFEEDBACK`. Right: it reaches the office folder and does not say "saved on this PC". Type `CDNEWDWG`: it finds the templates. Do not submit feedback or save a drawing.
   4. A folder typed in Settings that exists must never be moved. Look: a Settings folder that exists on this PC is unchanged after the start.
   5. Broken twin (switch off): set `linking.officeFolderFollowsOneDrive` false before launch and repeat step 2. Right (old behaviour back): the log line is absent and the old tank questions appear.
   6. On a PC where the folders are in the plain Users\Creative Engineering place, nothing changes: look at that as the control.

---

## 4. Skipped items and why

1. **BUG-1052 (job 301, CDAGI metre grade): no PR, so skipped as ordered.** The w1052 report says the fix is committed locally only (branch `w1052-bug1052-agi-units`, commit 6b26e852) and no PR was opened. I confirmed no `w1052` branch exists on `origin` and `gh pr list` returned no BUG-1052 PR. Its proposed case `N_agi_metre_grade` also could not run honestly as drafted: no drawing authored in metres exists on this PC (R24 header), so INSUNITS 6 on a millimetre master is an artefact risk. Whoever drafts it after the PR opens should read R24's header first.
2. **BUG-396 (job 306, double-click opens Pit Schedule): no PR, nothing built.** The w396 report stopped for two reasons (a command card is needed and the Pit Schedule window has no "open at this pit" step, which is Codex's window). The older BUG-396 pull requests in the list (#681, #689, #685, #747, #723, #727, #674, #687) are other items and not from jobs 300 to 307; I did not draft for them. The brief `BRIEF_W396_DOUBLECLICK_02NOV.md` exists and names its own robot case (section 6); I did not read it.
3. **Jobs 300 to 307 are eight numbers, the order named seven bugs.** I found reports for w027, w1042, w1052, w1053, w1166, w396 and w900 only. If an eighth job exists I did not find it (the search terms in the order did not name it).
4. **Other PRs the search returned** (#1491 BUG-825, #1990 BUG-1270, #1987 BUG-805 and about twenty older ones) are not from these jobs and were not drafted.
5. **A real "pit cover stored as Unknown, not 0.000" read.** Not possible for the robot today: it reads a pit's plan text (no CL line), not the stored record. Covered by Codex look K1042E step 4 (the box reads empty).

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** `C:\TimOS\RULES.md`; the seven BUGFIX reports (03NOV) in full; `README_CASES.md` in full; cases K02 (30 Oct), N05, R24, R29 and R37; `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` (header, two cases, the Codex notes and its skipped and not-proven sections); the settings group names and switch lines in `UserSettings.cs` on each PR head; the PR test file `Bug1053LandXmlLevelUnitTests.cs` (first 70 lines); the changed-file lists of all five PRs. I did NOT read the runner's code, `BRIEF_W396_DOUBLECLICK_02NOV.md`, the BUG_CARPARK entries, or the full PR diffs.
2. **Built:** nothing. **Tested:** nothing. No case was checked with `case_runner.ps1 validate`; first runs may need small fix-ups. No AutoCAD, no robot, no settings file read or written.
3. **Side effects of this job:** `git fetch origin` (allowed), plus `git fetch origin pull/<n>/head` for #1995 to #1999, which left five local read-only references `refs/remotes/prtmp/1995` to `1999` in this repo's `.git` (nothing in any working folder). The desk can drop them with `git update-ref -d` if wanted. `gh` was run by its full path.
4. **NOT proven:** every line marked DERIVED; that control names `C2.CoverLevel`, `Set second end level` and `New pit, Continue placement` exist and behave as written on the build that holds these PRs; that `control ... enabled` reads a greyed Place button as false; that the switch group names `xcivilImport` and `linking` match the JSON the guard sets (the `pipe` and `pit` groups were read); that Civil 3.0.89 is 61fd6fbc on the robot's AutoCAD (the order's word); that the five PRs will still merge cleanly (other drafts touch `PitViewModel.cs` and `UserSettings.cs`, per the w1042 report).
5. **Where I did not agree with a report or the order:** the w027 report says K02 has "no twin by design". The PR carries a switch, so a switch-off twin is possible and I wrote one (W1027_BROKEN). The order lists BUG-1052 in the search, but the job opened no PR, so it is skipped.
6. **Tim's work hours:** all runs belong outside 8:30am to 2:00pm and 3:00pm to 5:30pm Melbourne, Monday to Friday. Two of these cases place pits and pipes, so give each at least 10 minutes on a loaded PC.
