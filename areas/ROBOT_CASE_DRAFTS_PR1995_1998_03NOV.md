# Robot case drafts: PRs 1995, 1996, 1997, 1998 (Tue 3 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get, plus Codex looks for what the robot cannot do. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. (The brief spelt the output path "C:\CE_PLANreas\..."; I took it to mean `C:\CE_PLAN\areas\`.)

---

## FOR TIM

1. **None of the four fixes is in the build you have installed, or in the next two candidates.** I checked with git after a fresh fetch: Civil 3.0.89 (61fd6fbc), 3.0.90 (cf059dcf, b1) and 3.0.91 (aa3b92ac, b2) hold none of the four new switches. So the robot's "right" cases will fail on the installed build (that is the red) and can only pass on a build that carries the PRs.
2. **Drafted for the robot: four cases.** W1042A (PR 1996, blank cover level lets the Place button work) with its switch-off twin W1042A_OFF, and a switch-off twin K02_OFF for the existing case K02 (PR 1997, no "MIN." on the pipe label). Orders 820 to 822.
3. **PR 1995 (LandXML levels in metres) cannot go to the robot.** The robot cannot choose a LandXML file (the file box is closed to it), so the case named in the fix's own report cannot run. I wrote three Codex looks instead, with a made-up file you can paste.
4. **PR 1998 (office folder on OneDrive): this PC cannot show the fix.** Your PC has the plain "Creative Engineering" folders on disk and no office folders under OneDrive, so the new path never fires here. A robot guard would pass on the old build too, so I skipped it. A Codex look needs a spare profile or a test PC.
5. **One small thing to check in PR 1995.** A converted level drops its trailing zeros ("IL 100" where a metre file gives "IL 100.000"). I read this in the code and the tests, never saw it drawn. The Codex look checks how it reads.
6. **A flag from all four fix reports.** Each says files in `%APPDATA%\TIM_CE_CADTOOLS` changed during their runs, and two say `CD_Settings.json` went back to a 4 Oct copy (15270 bytes). I did not read your settings files. Someone should look at who is writing that file.
7. **Not proven:** every window word and printed line marked DERIVED came from code or reports, never a run. No case was run through `case_runner.ps1 validate`.

---

## 1. Facts checked, and where each came from

1. **Fresh fetch done first** (`git fetch origin`). Tips read: `claude/rel-20261102a` = 3fbb9da5; `claude/rel-20261108a` = cf059dcf (Civil 3.0.90, b1); `claude/rel-20261110a` = aa3b92ac (Civil 3.0.91, b2); installed Civil 3.0.89 = 61fd6fbc (version commit of 1 Nov).
2. **The four PR heads (read with `git`; `gh` is not on this shell's PATH, so PR state, draft status and review comments were NOT read).**
   1. **#1995, B-172, BUG-1053:** head `26afae19`, branch `claude/w1053-landxml-rim-units`. Switch `xcivilImport.landXmlLevelsConvertedToMetres`, ON.
   2. **#1996, B-173 (provisional), BUG-1042:** head `6e3b64df`, branch `claude/w1042-bug1042`. Switch `pit.blankCoverIsWarningNotBlock`, ON.
   3. **#1997, B-174, BUG-027:** head `352a838b`, branch `claude/b174-bug027-grade-no-min`. Switch `pipe.gradeLabelNeverMin`, ON.
   4. **#1998, B-176, BUG-1166:** head `6f5a80d9`, branch `w1166/bug-1166-office-folder`. Switch `linking.officeFolderFollowsOneDrive`, ON.
3. **Ancestry (checked myself):** none of the four heads is an ancestor of 61fd6fbc, cf059dcf, aa3b92ac or the 2 Nov tip; none of the four switch names appears in `UserSettings.cs` on any of those four commits. The only fixes in the repo are on the PR branches.
4. **What each fix does in the code (read from the diffs).**
   1. **1995:** the LandXML file's length unit (Metric or Imperial `linearUnit`) now turns the cover level, every invert and the sump level into metres before the 0 to 250 m range check. Millimetre 0.001, centimetre 0.01, foot 0.3048, US survey foot, metre 1. No Units element = metres, as before. A named unit CE cannot convert = levels Unknown, the report line "levels are Unknown: the file names a length unit CE cannot convert to metres", and the import carries on. Switch OFF = factor 1 always (old reading).
   2. **1996:** `PitStartReadiness` no longer returns the block "Enter the cover level." for a blank cover when the switch is ON. It returns the amber line "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out." The Place button stays live. Other missing fields still block. Switch OFF = old block exactly.
   3. **1997:** `BuildGradeValue` (New Pipe, grade Standard, one level typed, "I know one end" off) no longer returns the grade plus " MIN." when the switch is ON. Switch OFF = the old " MIN." line. Your ruling UX-CPLAN-05 (26 Sep): "Keep the May rule: no MIN."
   4. **1998:** new shared lookup `OfficeFolderLookup` (order: OneDrive office library, OneDrive "Creative Engineering" parent, then the plain Users path). Used by CDFEEDBACK, job time, CE Blocks' StructPlus lookup and, at settings load, Standard Details and Drawing Templates and the job-time folder. A folder that exists is never moved. The CE log gets `[BUG-1166] <name> was not on this PC; using the office folder on OneDrive: <path>` when a settings folder is moved. When a test run is on (`CE_LOG_DIR_OVERRIDE` set), the OneDrive root reads as null, so unit tests never reach the real office share.
5. **This PC's layout (read with `Test-Path`, folder names only, no settings file opened).** `%OneDriveCommercial%` = the "OneDrive - Creative Engineering" folder. `Creative Engineering - Drafting` and `Creative Engineering - IT Admin` exist under the plain `Users\<you>\Creative Engineering\` path and do NOT exist under OneDrive or under OneDrive\Creative Engineering. So on this PC the new code finds the plain path, as the old code did.
6. **The robot cannot reach PR 1995's file.** `acad_driver_witness_v2.allowlist.json` lets the robot press "Choose LandXML*", "Read source", "Import to drawing", "Cancel" and "Close" in the "LandXML import" window, with no typed field. "Choose LandXML*" opens a Windows file box the runner cannot drive (README_CASES and case R29 say the same). The robot's step list offers no way to put a file path in.
7. **The robot CAN dump and press in the New Pit window.** `ui2-set "New Pit" "C2.CoverLevel"` and `ui-press "New Pit" "New pit, Continue placement"` are used by the accepted-style case N05. `ui-dump` on New Pipe is used by K02; `ui-dump` on New Pit is NOT used by any case I read (DERIVED that it works; if the v3 list refuses it the step is BLOCKED, not a result).
8. **The robot CANNOT press "Edit pit, Save"** (README_CASES, batch 3, item 5). So PR 1996's PITEDIT half is Codex only.
9. **Switch-off twins work through `SETTING <file> <key> <value>`** (README_CASES, batch 2, item 2): set before AutoCAD starts, restored by hash after. The style is the one in `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` (W1888_BROKEN). All three keys live in `CD_Settings.json` (groups `pit`, `pipe`, `xcivilImport`); I confirmed the key names in the PR diffs, not in the file.
10. **Existing case K02** (`C:\Lisp Files\_ACAD_DRIVER\cases\drafts_carpark_30oct\K02_one_level_label_has_no_min_suffix.case.txt`, corrected 30 Oct, never run, never reviewed) is already the case PR 1997's report names. It has no twin by design (its red was the real fault on the installed build). The PR gives a clean switch, so a twin is now possible.

---

## 2. Robot case texts

**How these are written.** README_CASES.md format. Fixture DRV1_B1, SLOT fresh, REVIEWED_AGAINST empty. Every `type` chain is a complete command with no `(` and no SAVE-type word. Run alone, outside Tim's hours (Mon to Fri 8:30 to 2:00 and 3:00 to 5:30 Melbourne is Tim's). Validate first, without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_pr1995_1998_03nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or bypasses a protection. **Build rule:** these only mean something on a build that holds the PR (see FOR TIM 1). On the installed 3.0.89 the right cases fail and so do the twins; that is a known red, not a result for the fix.

### Case 1 of 3 (PR 1996, BUG-1042): W1042A and its switch-off twin W1042A_OFF

**Intended file:** `W1042A_new_pit_blank_cover_places_and_stays_blank.case.txt`

```
# W1042A DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #1996 (head 6e3b64df, B-173 provisional), BUG-1042 (carpark stays OPEN). Switch pit.blankCoverIsWarningNotBlock, ON by default; this case sets nothing and proves the shipped default on a build that holds the PR.
# What it proves (the New Pit half only): with the Cover level box left blank the amber line reads 'The cover level is blank: ...', the Place button ('New pit, Continue placement') is NOT greyed, and pressing it places one pit and one PIT LABEL and NO cover text (a blank cover is never drawn as CL 0.000).
# What it does NOT prove: that PITEDIT saves a pit with a blank cover (Edit pit, Save is not on the press list: Codex look K4_01); that the blank cover is stored blank rather than 0.000 inside the pit (the robot cannot read the stored cover value; the absent cover text is the nearest evidence); how the amber line looks (Codex look K4_01).
# Route is N05's, which was drafted but not yet run either: zoom, PIT at 150000,-80000, set the cover box, press Continue placement, one blind label click at 150000,-78500, then Esc twice. DERIVED, never seen: whether a cover-text prompt follows when the cover is blank (the code drops the CL line for a blank cover, so probably not); the two Esc presses cover both outcomes. DERIVED: ui-dump of the New Pit window works (K02 does it for New Pipe).
# Remembered values: PIT may save the last pit type and size to CD_RecentValues.json (the guard does not restore that file; the desk restores it).
CASE W1042A
TITLE With the Cover level box left blank, New Pit shows the blank-cover note, the Place button stays live, and the pit goes in with a label and no cover text
PLAN_ITEM PR #1996 (B-173, BUG-1042) PART: New Pit with a blank cover level. NOT whole: PITEDIT with a blank cover (Codex look K4_01); the stored cover value; the look of the note
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 820
TIMEOUT 900
BUG BUG-1042
PROVES_BUGS BUG-1042 (the New Pit half only)
REVIEWED_AGAINST
EXPECTED PIT at 150000,-80000 with the Cover level box cleared: the New Pit window text holds 'The cover level is blank'; the Place button is enabled; pressing it places exactly one pit block on STORMWATER PIT and one PIT LABEL block, and no new text starting 'CL '. The window is gone afterwards. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests drive the readiness rule and the window's view model; only a live New Pit window shows whether the button is really live and the pit really goes in.
NOT_AUTOMATED PITEDIT with a blank cover (Edit pit, Save is not pressable): Codex look K4_01.
NOT_AUTOMATED The stored cover value inside the pit and how the amber line looks: Codex look K4_01.
STEPS
  copy-info -> $copy0
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  v3 view-read
  ms-count -> $n0
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" ""
  ui-dump "^New Pit" -TimeoutSec 60 -> $np
  ui-press "New Pit" "New pit, Continue placement" -> $pit_t2
  await-window-gone "^New Pit" -Secs 120
  v3 pt-click "150000,-78500" -Blind -> $click_label
  sleep 3
  v3 esc-key
  sleep 3
  v3 esc-key
  wait
  ms-new $n0 -> $new
  select $new object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
  select $new "name~^PIT LABEL" -> $labels
  select $new "text~^CL " -> $covers
  history-tail -> $hist
  windows-snapshot -> $win_end
ASSERT
  control-text $np has "The cover level is blank"
  control $np "New pit, Continue placement" enabled
  count $pits = 1
  count $labels = 1
  count $covers = 0
  not-contains $win_end "New Pit"
  copy-unchanged $copy0
  record $np "FULL New Pit window with the cover blank"
  record $pit_t2 "what pressing Place reported"
  record $hist "FULL last command lines (does 'Pit placed successfully.' show?)"
```

**Twin:** `W1042A_OFF_new_pit_blank_cover_places_and_stays_blank.case.txt`

```
# W1042A_OFF DRAFT (Tue 3 Nov 2026; NOT RUN). The switch-off twin (style of W1888_BROKEN): pit.blankCoverIsWarningNotBlock false before AutoCAD starts, so the old block returns. Same route up to the dump, then the SAME two window checks as W1042A. It must FAIL on both: the line reads 'Enter the cover level.' and the Place button is greyed.
# The twin does NOT press the button (a press on a greyed button would be BLOCKED, not a red). It closes the window with its own close-windows step and places nothing.
# If it PASSES the switch is not being read (CE reads settings at AutoCAD start; the guard must be armed before launch) or the build lacks the PR: stop and say so.
CASE W1042A_OFF
TITLE BROKEN VARIANT of W1042A: the switch is OFF, the old block returns, the case still expects the Place button live (must FAIL)
PLAN_ITEM red-before-green proof for W1042A (PR #1996, B-173, BUG-1042)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pit.blankCoverIsWarningNotBlock false
ORDER 821
TIMEOUT 600
BUG BUG-1042
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1042A
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the New Pit window shows 'Enter the cover level.' and the Place button is greyed, so both window checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1042A's window checks can go red.
STEPS
  copy-info -> $copy0
  type "_.ZOOM _C 150000,-80000 8000"
  wait
  v3 view-read
  type "PIT{NL}150000,-80000" -Force -ExpectWindow "New Pit" -TimeoutSec 120 -> $pit_t1
  ui2-set "New Pit" "C2.CoverLevel" ""
  ui-dump "^New Pit" -TimeoutSec 60 -> $np
  close-windows
  wait
ASSERT
  control-text $np has "The cover level is blank"
  control $np "New pit, Continue placement" enabled
  copy-unchanged $copy0
  record $np "FULL New Pit window with the cover blank, switch OFF (expect 'Enter the cover level.')"
```

### Case 2 of 3 (PR 1997, BUG-027): K02 as it stands, plus its switch-off twin K02_OFF

**Right case:** use the existing `K02_one_level_label_has_no_min_suffix.case.txt` unchanged (its text asserts `not-contains $lt "MIN."` and `matches $lt "^\d+ DIA\. \S+ PIPE AT 1 IN \d+$"`). Not rewritten here. On a build with PR 1997 it should PASS. On installed 3.0.89 it is the expected red.

**Twin:** `K02_OFF_one_level_label_has_no_min_suffix.case.txt`

```
# K02_OFF DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). Switch-off twin of K02 for PR #1997 (head 352a838b, B-174), BUG-027 (carpark stays OPEN). pipe.gradeLabelNeverMin false before AutoCAD starts: the old ' MIN.' label returns. It is K02's route and K02's checks word for word; it must FAIL on 'not-contains $lt "MIN."' and on the label pattern, because the label ends '... AT 1 IN <n> MIN.' (CdCommand.Grade.cs BuildGradeValue, read from the PR diff; never drawn).
# On the installed 3.0.89 this twin ALSO fails (the build has no switch and always writes MIN.), so there it cannot tell switch-off from old build; it tells them apart only on a build that holds PR 1997.
# If it PASSES the switch was not read before launch or the build is not the PR's: stop and say so.
# Remembered values: same as K02 (the reset pipe at the end puts the second level back on).
CASE K02_OFF
TITLE BROKEN VARIANT of K02: the new switch is OFF, so a pipe with one level typed ends its label with MIN. (must FAIL)
PLAN_ITEM red-before-green proof for K02 (PR #1997, B-174, BUG-027)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json pipe.gradeLabelNeverMin false
ORDER 822
TIMEOUT 900
BUG BUG-027
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF K02
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the label reads '<size> DIA. <material> PIPE AT 1 IN <n> MIN.', so the two label checks fail; one pipe, one label and one IL text still draw and the file on disk is unchanged.
WHY_NOT_UNIT_TEST It exists only to prove K02's label checks can go red.
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
  record $lt "FULL the pipe label text, switch OFF (expect it to end MIN.)"
  record $np "FULL New Pipe window before Start Pipe (second level off)"
  record $cd "FULL CD"
  record $cdR "FULL CD reset pipe"
```

### Case 3 of 3: nothing for the robot (PR 1995 and PR 1998). See section 4.

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a copy, on a build that holds the PR)

1. **K4_01, BUG-1042 (PR #1996): PITEDIT saves a pit with a blank cover, and the note reads right.** Codex only: Edit pit, Save is not on the robot's press list.
   1. Open a copy of a drawing that has a CE pit (say P1, 600 x 600 grated). Type `PITEDIT`, pick P1. If its cover level box has a value, clear it. (If the pit already had a blank cover, use it as it is.)
   2. Look: a line under the window reads "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out." Nothing is clipped. The Save button is live.
   3. Change the width from 600 to 900 and press Save. Expect: it saves, the pit redraws at 900, and no "CL" text appears and none reads "CL 0.000". Open PITEDIT on P1 again: the cover box is still blank.
   4. Still in PITEDIT, type a missing pit number or clear the width: Save must still be blocked (a missing number, type, width or length still stops it).
   5. Control (optional, needs AutoCAD restarted with `pit.blankCoverIsWarningNotBlock` false): the same blank cover then shows "Enter the cover level." and Save stays greyed.
   6. Do not save the drawing. Close without saving.
2. **K4_02, BUG-1053 (PR #1995): a millimetre LandXML file imports its levels in metres.** The robot cannot choose the file, so this is Codex only. Use a made-up file; no client data.
   1. **Make the right file.** In a scratch folder (not a repo, not the shared office folder) save this text as `UNIT-RL-MM.xml` (one pit, millimetre file, cover 100200, invert 100000):
      `<?xml version="1.0" encoding="utf-8"?>`
      `<LandXML xmlns="http://www.landxml.org/schema/LandXML-1.2" version="1.2"><Units><Metric linearUnit="millimeter"/></Units><PipeNetworks><PipeNetwork name="Drainage" pipeNetType="Storm"><Structs><Struct name="P1" elevRim="100200"><Center>6000 345 100200</Center><RectStruct width="0.9" length="0.9"/><Invert elev="100000"/></Struct></Structs></PipeNetwork></PipeNetworks></LandXML>`
      That is the file the unit test builds, so the parser reads it. Where the pit lands on the plan does not matter; only its levels do.
   2. Open a copy of an empty civil drawing. Type `CDIMPORTLANDXML`. The window "Creative Engineering | LandXML import" opens. Press "Choose LandXML...", type the full path of the copy of the file, press Open. Press "Read source".
   3. Look: the line for P1 reads "cover level 100.20 m from the LandXML file" (DERIVED wording, `LinkCommands.ImportXcivil.cs` line 280). The old build reads "cover level 100200.00 m". It must not say "cover level Unknown".
   4. Press "Import to drawing" (on the copy only). Look at the new pit: its cover level is 100.20 and its invert text reads "IL 100" (the old build drew no IL at all, because 100000 m failed the 0 to 250 m check). **Look hard at this text:** a metre file gives "IL 100.000" (three decimals). If the converted pit reads "IL 100" with no decimals while a metre file reads "IL 100.000", say so; it may be a small wording gap in the fix (I read it in the code, I never saw it drawn).
   5. Do not save. Close without saving.
3. **K4_03, BUG-1053 twin 1 (wrong on purpose, must show the Unknown path): a unit CE cannot convert.** Same steps as K4_02, but save the file as `UNIT-RL-FURLONG.xml` with `<Units><Metric linearUnit="furlong"/></Units>` instead, and `elevRim="100.2"` and `<Invert elev="100.0"/>`.
   1. Press "Read source". Look: the line for P1 reads "cover level Unknown", and the import report carries "levels are Unknown: the file names a length unit CE cannot convert to metres". The window does not block and the import can still go ahead.
   2. A metre file with `linearUnit="meter"`, `elevRim="100.200"` and `<Invert elev="100.000"/>` must give "cover level 100.20 m" and "IL 100.000", the same as the millimetre file's cover.
4. **K4_04, BUG-1053 twin 2 (switch OFF, the old reading must return): needs AutoCAD restarted with `xcivilImport.landXmlLevelsConvertedToMetres` set false before launch.**
   1. Repeat K4_02 steps 2 to 3 with `UNIT-RL-MM.xml`. Expect the old line "cover level 100200.00 m". Pressing "Import to drawing" draws no IL text.
   2. If instead the line reads 100.20, the switch was not read at start or the build is not the PR's: stop and say so. (The robot's `SETTING` route could set this key, but cannot choose the file, so Codex runs it.)
5. **K4_05, BUG-1166 (PR #1998): Civil finds the office folders under OneDrive. Needs a profile or test PC where the plain office folders are NOT on disk.**
   1. **This PC cannot do it:** the plain `Users\<you>\Creative Engineering\Creative Engineering - Drafting` and `... - IT Admin` folders exist here and the OneDrive ones do not (read 3 Nov). The new code finds the plain path first on this PC, as before.
   2. **Needs:** a Windows account (or a PC) where `%OneDriveCommercial%\Creative Engineering - Drafting\Standard Details\Civil` exists (the office library added as a shortcut to My files) and `Users\<you>\Creative Engineering\` does not. Settings for the account point Standard Details at the plain path (the usual default). I have not seen Max's real OneDrive layout; the report says the carpark wants it looked at before 9 Nov.
   3. Start AutoCAD on that account. Open a copy of any civil drawing. Type `CDWT`: expect the tank pictures (no questions about where the details folder is). Type `CDNEWDWG`: expect the template list to open. Type `CDFEEDBACK`, press Cancel only (never "Send report"). Look at the CE log for `[BUG-1166] options.standardDetailsCivilFolder was not on this PC; using the office folder on OneDrive`.
   4. **Control:** `linking.officeFolderFollowsOneDrive` false before launch: that log line is absent and the old questions appear.
   5. **Never** send a report or write into the shared office folder. A folder you typed in Settings that exists is never moved: if you put a real path in Settings, nothing changes.

---

## 4. Skipped items and why

1. **A robot case for PR 1995 (BUG-1053).** BLOCKED-FOR-ROBOT. The robot cannot put a file path into the LandXML window's file box, so no LandXML file can be read. The fix's own report proposes `B172_landxml_mm_levels`, which starts "Type CDIMPORTLANDXML, choose the file": that step cannot be run by the robot as it stands. Looks K4_02 to K4_04 cover it. A reviewed allow-list change (or a pre-placed .xml beside the last DWG import, a path I did not test) would be the way to bring it in; I did not make either.
2. **A robot case for PR 1998 (BUG-1166).** Not drafted. On this PC the plain office folders exist, so the OneDrive path never fires; a case that checks "no [BUG-1166] log line" passes on the old build as well, so it cannot tell the fix from the old build. The robot also cannot change `%OneDriveCommercial%` or make the plain folders vanish. Look K4_05 covers it on a suitable profile.
3. **PITEDIT with a blank cover (PR 1996).** The robot cannot press "Edit pit, Save". Look K4_01.
4. **A right case for PR 1997 apart from K02.** Not needed: K02 is that case. I did not re-draft or re-check K02's own route, including its "Set second end level" box name (corrected 30 Oct from rel-20261029a, not re-verified on a later build).
5. **Two-level paths for PR 1997** (labels worked out from two levels never carried MIN.). Not changed by the fix, covered by existing cases, not touched.
6. **Manager, CE Blocks and the FeedbackDialog.xaml fixed path line (PR 1998).** Outside the PR (report section 3); no case.
7. **Stored cover value as 0.000 (PR 1996).** The robot cannot read the stored cover; the absent "CL" text in W1042A is the nearest evidence and does not prove the stored value.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** `C:\TimOS\RULES.md` in full; the four BUGFIX reports (w1053, w1042, w027, w1166, 3 Nov) in full; `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md` in full (the format); `README_CASES.md` in full; K02 (30 Oct corrected copy) in full; R29 and N05 in full; the first 40 lines of `ROBOT_CASE_DRAFTS_SET14_LANDXML_LONGSECTION_OLDER_02NOV.md`; the LandXML entry of the v2 allow-list; the PR diffs for 1995 (parser and its test file), 1996 (readiness rule and view-model line), 1997 (`CdCommand.Grade.cs`, `GradeLabelMinRule.cs`) and 1998 (lookup, locator, settings move, feedback, job-time and block changes); the `OfficeFolderFollowsOneDrive` line in `UserSettings.cs`; `Test-Path` on this PC's office folders (folder names, no settings file).
2. **Not read:** the PR descriptions and review comments (no `gh` on this shell's PATH, so PR state and draft flag are from the reports only); `REGRESSION_LOG.md` on the PR heads; the runner code beyond what README_CASES says; `PitCommand.cs` (so whether a cover-text prompt follows a blank cover is DERIVED); the full status of K03 to K08; Tim's real settings files (not opened, as ordered); the installed DLL's version string (3.0.89 and commit 61fd6fbc are as given in the brief).
3. **Built:** nothing. **Tested:** nothing. No case was validated with `case_runner.ps1 validate`; first runs may need small fix-ups. No AutoCAD, no robot, no settings file read or written, no git write (only `git fetch` and read-only `git` commands). No agents spawned.
4. **NOT proven:** every line marked DERIVED (the New Pit window text and control names, that `ui-dump` works on New Pit, the review-line wording of the LandXML window, the IL text format of a converted level, whether a cover-text prompt follows a blank cover); that the setting keys sit in `CD_Settings.json` (read from the diffs, not the file); that DRV1_B1 is clear near the pit and pipe positions used; that the robot's AutoCAD loads a build holding these PRs.
5. **Mismatch to know about:** the PR 1995 report says a metre file "gives the same numbers" as the millimetre file. By the code and the tests the cover reads the same (100.20) but the invert text differs ("IL 100" and "IL 100.000"). Marked in K4_02 step 4 for Codex to look at.
