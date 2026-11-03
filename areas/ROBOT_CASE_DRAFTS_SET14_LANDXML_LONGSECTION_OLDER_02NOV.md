# Robot case drafts, set 14: LandXML import and long section, older fixes (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

Verdict: **ZERO robot cases drafted. All six fixes are BLOCKED-FOR-ROBOT. Six Codex looks are written instead.** Nothing was built, tested, installed or opened in AutoCAD. The only file written is this one.

---

## FOR TIM

1. **Result.** No robot case and no broken twin were drafted. I could not honestly write one that proves any of the six fixes. A case that only opens a window would "pass" on the old, broken build too, so it would prove nothing.
2. **Why, in drawing words.** The robot cannot pick a LandXML file (the file box is not something it can drive), and it is not allowed to press Apply in the Profiles window, so it can never draw a long section.
   1. **LandXML import (#1707, #1708, #1773):** the file has to be chosen before anything happens. Blocked.
   2. **Long section (#1711, #1710, #1709):** needs a route chosen in a drop-down the robot cannot set, a datum level typed into a box with no name, and the Apply button, which is on the refused list. Blocked.
3. **Codex-only fixes:** all six. Each has a numbered Codex look below, with a made-up LandXML file description where a file is needed (no client data).
4. **Opus review before running:** none of the six touches Undo, REDO, a locked layer or an Xref in a way that needs one. Only a note: the long-section looks end with one Undo (U) to remove the drawn section. That is the fix's own promise ("One AutoCAD Undo removes this change"), so the look checks it.
5. **What the robot can already do.** Case R28 (CDPROFILE asks for a pit and opens the Profiles window) and case R29 (CDIMPORTLANDXML opens its window, Cancel draws nothing). Confirmed: they are the only existing routes, and neither proves any of these six fixes.
6. **No existing case found for any of the six**, so none was skipped for that reason (checked again, see section 4).
7. **Could not verify:**
   1. Which Civil build is installed on your PC (I did not read the DLL). All six fixes are in the 2 Nov train, so any install of that train has them.
   2. GitHub still shows the six PRs as OPEN even though each has a merge commit in the 2 Nov train. This looks like a train-merge quirk. I did not chase it.
   3. Every window word and printed line in the Codex looks comes from the PR text. None was seen on a run. They are marked DERIVED.
8. **Nothing for you to decide or test.** The Codex looks go to Codex.

---

## 1. How these drafts were written

1. **Read:** `C:\TimOS\RULES.md` (top 120 lines); `cases\README_CASES.md` in full; `acad_driver_v3.allowlist.json`; the LandXML window entry in `acad_driver_witness_v2.allowlist.json`; R28, R29, N55 (draft) and the switch-off twin `R09s_new_switch_off_broken`; the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (first 200 lines). `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` was NOT read (time); the switch-off style came from the R09s twin instead.
2. **Read for each fix:** the PR text and file list (`gh pr view`), the carpark entries for BUG-766, BUG-764, BUG-760 (all marked OPEN there) and BUG-719 to 729 / BUG-1188 (line numbers only, status not read), the `REGRESSION_LOG.md` entry headings on `origin/claude/rel-20261102a`, the switch name and default for BUG-1188 (found in `UserSettings.cs`), and the `LEVEL` word (`LongitudinalNodeRow.LevelGradeWord`). No BUGFIX_*_REPORT file in `C:\CE_PLAN\areas` names any of the six.
3. **Latest line used:** `origin/claude/rel-20261102a` (3fbb9da5) after `git fetch`. All six merge commits are on it: #1707 07c2be88, #1708 caa8b105, #1773 0f7e76a6, #1711 410dfd81, #1710 28987b73, #1709 4dbab284.
4. **Not read:** the PR diffs line by line, the Structural line, Tim's settings files, the installed DLL.

### Why the robot cannot reach each item (the reasons, checked in the allow-lists)

1. **File chooser.** CDIMPORTLANDXML opens "Creative Engineering | LandXML import". The v2 list allows pressing "Choose LandXML*", "Read source", "Import to drawing", "Cancel" and "Close", but lists no typed field (`set` is empty), and "Choose LandXML*" opens a Windows file box the runner cannot drive. The import skips the window only when a matching .xml sits beside the last DWG import (source comment in `LinkCommands.ImportXcivil.cs`), which a fresh drawing does not have.
2. **Apply.** `Apply` is an exact entry in the v3 `never_buttons` list. The Profiles window matches only `Creative Engineering*`, which allows Cancel, Cancel without saving and Close.
3. **Route drop-down and datum box.** N55's header (read-only note by a previous drafter) records that the route picker is never pre-picked and the Datum RL box has no automation name. I did not re-check the XAML myself.
4. **Therefore** the proof of every fix needs a button the robot may not press or a file it cannot pick. A change to the allow-list needs a reviewed edit and was not made.

---

## 2. Robot cases

None. Every one is **BLOCKED-FOR-ROBOT**, one line each:

1. **#1707 (FB-16, BUG-719, 720, 723, 724):** BLOCKED-FOR-ROBOT. Needs a LandXML file picked in the file box.
2. **#1708 (FB-17, BUG-725, 728, 729):** BLOCKED-FOR-ROBOT. Same.
3. **#1773 (BUG-1188):** BLOCKED-FOR-ROBOT. Same. Its switch is `xcivilImport.importedPipeNoInventedGrade` (default ON). A switch-off twin in the R09s style would be easy to write, but with no way to run the import both halves would only open the window and could not tell on from off.
4. **#1711 (BUG-766):** BLOCKED-FOR-ROBOT. Needs Preview and Apply, route picker and datum box.
5. **#1710 (FB-19, BUG-760):** BLOCKED-FOR-ROBOT. Same.
6. **#1709 (FB-20, BUG-764):** BLOCKED-FOR-ROBOT. Same.

Order numbers 830 to 839 and ids W1707 to W1773 are left unused. If the allow-list is ever changed to let the robot press Apply and set the route, #1710 is the best first case (a level pipe is the simplest drawing to build and the word LEVEL is exact).

---

## 3. Codex looks

Common rules for all six:

1. **Copies only.** Work on a copy of the master drawing DRV1_B1 (millimetres) in `C:\ce_rc_scratch`. Never Save, never touch Tim's real drawings or settings files.
2. **Evidence folder:** `C:\CE_WORK\codex\<look id>\`. Save every screenshot there with the step number in its name.
3. **File box rule:** type the full path of the made-up file in the Windows file name box. Never accept a file, or take a screenshot of, whatever folder the box happened to open in (it may show client files).
4. **Made-up files** are written by Codex into the evidence folder using the descriptions below. Metres unless said. No client names.
5. **Everything marked DERIVED** is from the PR text and not seen on a run. If the window says something different, record the exact words and mark it a wording difference, not a fail, unless the meaning is wrong.
6. **End every look** with Escape or Cancel, one Undo (U) if anything was drawn, and a note of the object count before and after.

### Look C1: #1707 (FB-16), LandXML import reads real files. Covers the whole fix.

**Made-up file `FX16_SYNTH_A.xml`:** metres. Three pits.
1. **S1:** control pit, 0.9 by 0.9, at E 1000.000 N 2000.000, rim 45.200, invert 43.900.
2. **S2:** ordinary pit at E 1030.000 N 2000.000, rim 44.800, invert 43.600.
3. **S3:** ordinary pit at E 1060.000 N 2000.000, rim 44.400, invert 43.300.
4. **Pipe A:** from S1 to S2 written with `refStart="S1"` and `refEnd="S2"`, 300 diameter, class "uPVC SN10".
5. **Pipe B:** from S2 to S3, a 1200 by 600 box pipe, refs as above.
6. **Pipe C:** 300 diameter, with no pit named at either end.

**Steps:**
1. Open the copy. Type `CDIMPORTLANDXML`. The "LandXML import" window opens.
2. Press "Choose LandXML file" (wording DERIVED from the allow-list "Choose LandXML*"), type the full path, press Read source. Screenshot the review page.
3. **Right looks like (DERIVED):**
   1. The review says 3 pits and pipes read (not "3 pits, 0 pipes").
   2. The control pit row reads 900 by 900 (not 1800 by 900).
   3. The box pipe row says "1200 x 600 box pipe in the file, drawn as a 1200 mm round pipe - check the size" and is marked Check.
   4. Pipe C is reported "[CE] not drawn: the file does not say which pits it joins".
4. Press Import to drawing. Screenshot the plan. Right looks like: pipe A's label reads "uPVC SN10" (not "UPVC SN8"); the box pipe is a round 1200.
5. Press U once. Count objects: back to the start.
6. **Wrong looks like:** "3 pits, 0 pipes", a 1800 wide control pit, "UPVC SN8".
7. **Not proven by this look:** a real Civil 3D or 12d export (the PR says refStart/refEnd spelling was never checked against one).

### Look C2: #1708 (FB-17), scale, falling-pipe grade, cover levels. Covers the whole fix.

**Made-up file `FX17_SYNTH_MM.xml`:** `linearUnit="millimeter"`. Two pits at E 95000 N 50000 and E 105000 N 50000 (positions as written). Pit 1 `elevRim` 45.2299999. One pipe between them with slope -0.01. Import into the millimetre copy.
**Second file `FX17_SYNTH_NOUNITS.xml`:** the same two pits at E 95 and E 105 (a file with no Units line), slope -0.01.

**Steps and right looks (DERIVED):**
1. Import file 1. Both pits sit at the file's positions to within 1 mm. They are 10 000 mm apart, not 10 000 000.
2. The pipe label shows a grade of 1:100 (the same as a pipe written +0.01).
3. The cover text on pit 1 reads CL 45.23, not 45.2299999.
4. U. Import file 2. Both pits get the same factor: still 10 000 mm apart (95 000 and 105 000), not scattered (one at 95, one at 105 000).
5. U. Object count back to the start.
6. **Not proven:** reading a very large file as a stream (the PR says this half of BUG-729 is not in the change).

### Look C3: #1773 (BUG-1188), no invented "AT 1 IN 100". Part: ON build only.

**Made-up file `FX1188_SYNTH_NOGRADE.xml`:** two pits (S1 E 500 N 500 rim 30.000, S2 E 520 N 500 rim 29.500), one 300 mm RCP pipe, no slope, no invert levels.
**Second file `FX1188_SYNTH_SLOPE.xml`:** the same, with `slope="0.005"`.

**Steps and right looks (DERIVED):**
1. Import file 1 (Read source, Import to drawing). Right looks like: the pipe label reads "300 DIA. RCP PIPE" with no "AT 1 IN" anywhere, and the pipe is still drawn.
2. U. Import file 2. Right looks like: "AT 1 IN 200".
3. **Wrong looks like:** "AT 1 IN 100" on the no-grade pipe.
4. **Switch OFF is NOT looked at.** It needs the setting changed before AutoCAD starts and Codex must not edit Tim's real settings files. The red-before-green proof is the unit tests (PR text: 6 of 8 fail with the default flipped OFF).
5. **Not done by the fix:** a "grade missing" line in the review window (needs Tim's wording).

### Look C4: #1711 (BUG-766), CDPROFILE draws the branch junction tick. Part: one branch.

**Drawing (no file):** on the copy, in empty ground, place main pit P1, pit P2 20 000 mm away, and a pipe between them. Join a branch pipe (100 diameter) from a third pit so it meets the main pipe 6 400 mm from P1. Use CE's normal way of recording a branch; I did not check which command that is, so Codex records the one used.

**Steps and right looks:**
1. Zoom to P1. Type `CDPROFILE`, pick P1. In the Profiles window choose the route P1 to P2, type a datum level that is lower than the inverts (record the value), Preview New, pick an insertion point, then Apply.
2. **Right looks like (DERIVED):** a text "100 DIA. BRANCH" sits at chainage 6.4 m (within 0.05 m) with the branch invert under it.
3. Repeat on a route with no branch: no tick, as before.
4. Press U once. The section is gone. Object count back to the start.
5. **Not proven:** the PR says the tick is placed by the existing placer. The look does not check other junction types.

### Look C5: #1710 (BUG-760), level pipe draws, grade reads LEVEL. Covers the whole fix.

**Drawing (no file):** pit P1 invert 10.00, pit P2 invert 10.00, 20 000 mm apart, pipe with no "1 IN" grade label (a flat pipe).

**Steps and right looks (DERIVED):**
1. `CDPROFILE`, pick P1, choose the route, Review. The grade reads LEVEL; the speed and flow rows read "Blank (level pipe)".
2. Preview New, Apply. The section is drawn. PIPE GRADE reads LEVEL; the speed row is blank.
3. U once. Section gone.
4. **Control:** a pipe that rises along the flow still shows Unknown with its reason (the fix must not turn a rising pipe into LEVEL).
5. **Wrong looks like:** the route says "pipe grade Unknown" and the section cannot be drawn.
6. **Not proven:** the older long-section window (no review), which the PR says is not changed.

### Look C6: #1709 (BUG-764), boundary marks measured along the bent pipe. Part: the dog-leg and the 45 degree end.

**Drawing (no file):** a bent pipe: P1 at 0,0, a bend at 10000,0, P2 at 10000,10000. Make the bend the way CE normally makes one (not checked which command). A boundary line from 9000,5000 to 11000,5000 on layer BOUNDARY (or A-TITLE BOUNDARY). Second drawing area: a straight pipe leaving the last pit at 45 degrees towards a boundary 1.0 m away.

**Steps and right looks (DERIVED):**
1. `CDPROFILE`, P1 to P2, Review, Apply. Exactly one boundary mark, at chainage 15.0 m (within 0.05 m). Before the fix it was missed or shown where the pipe never crosses.
2. U once.
3. The 45 degree end case: the end-pit boundary distance reads 1.41 m (not 1.0 m).
4. A straight pipe with a boundary: marks identical to before.
5. **Not proven:** curved (arc) pipes (the PR's own "not checked") and a closed boundary's closing side (BUG-1012, a different fix).

---

## 4. Duplicate check and fixes skipped

1. **Checked again, by text and by file list, not by running anything.** Searched `C:\Lisp Files\_ACAD_DRIVER\cases` including every `drafts_*` folder and `variants`, the ledger `runner-reports\ledger.json`, and every `ROBOT_CASE_DRAFTS_*.md`, for the bug numbers, FB numbers, PR numbers, the switch name, `LANDXML` and `CDPROFILE`.
2. **Found:** R28 and R29 (only the start of each route), N55 (CDPROFILE window half, a draft, proves none of the six), and a text hit in W223 that is about Edit Pipe levels, not these fixes. The ledger hits are a coincidental hash and a run name, not these bugs.
3. **Skipped because a case already exists:** none.
4. **Skipped because blocked:** all six, see sections 1 to 3.

## 5. What was read, built, tested, and NOT proven

1. **Read:** the files listed in section 1, PR text and file lists, the merge commits on the 2 Nov train.
2. **Built:** nothing. **Tested:** nothing. **Opened AutoCAD, ran the robot:** no.
3. **NOT proven:** every fix in the set is unproven in AutoCAD. Every printed line and window word above is DERIVED from the PR text. The reasons the robot is blocked come from the allow-lists and the source, read once, not from a run.
