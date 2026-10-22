# Daily tools test cases: the 30 tools a drafter uses every day (Civil + Manager), 23 October 2026

Written Fri 23 Oct 2026, 00:00 to 01:00 Melbourne, by a test-engineer agent (Opus 5.5) for the desk. Read-only on source: nothing built, run, installed or opened in AutoCAD. The only file written is this one.

**Installed line checked:** `origin/claude/rel-20261022m` head `40ee0a36` ("Version: Civil 3.0.70 / Manager 1.1.70 (C-60)"). The same commit is printed by robot run 47 and Codex V10 as the installed DLL product version. Every "INSTALLED" line below was checked by `git log --grep`, `git grep` or `git merge-base --is-ancestor` against that ref. Every "SWITCH" line was read from the ref's `Modules/Drainage/Models/UserSettings.cs` and from Tim's own `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, which I read back at 00:18 on 23 Oct with hash ACD64E79A33B.

**Where the 30 come from:** `RELEASE_9NOV_GAP_PLAN_2026-10-22.md` section 2 lists them, so this file uses that list in its order. The gap plan numbers them C41 to C70. `TEST_CASES_DRAFT_22OCT.md` already uses C41 to C48 for other cases, so the cases here are numbered **D01 to D30** (D01 = gap plan item 1). The desk can renumber them when the pack is merged.

---

## ANSWER FIRST

1. **Installed:** 28 of 30 are in the installed line with their behaviour in place. **UX-LYR-01** is only part-built (D24). **UX-LYR-04 is not built** (D25): nothing in the installed Civil marks a pit as existing or demolished, there is no DEMO layer and no "TO BE REMOVED" text.
2. **Switched on with Tim's switches:** 27 of 30. Three are not on for Max today:
   - **UX-LBL-01** (a hand-moved label stays put): its switch is OFF.
   - **UX-UNDO-01** ("Undid: ..." sentence): its two switches are OFF.
   - **UX-LYR-04:** not built.
3. **Testable now on Tim's PC with existing drawings:** 27 of 30. Three need something that does not exist yet:
   - **D25 (UX-LYR-04):** needs the build first, then a drawing with existing and demolished pits.
   - **D26 (CDSL):** needs a drawing that holds a stored CDSURVEY survey.
   - **D29 (CDFEEDBACK):** the "Send report" half needs the spare Windows login. On Tim's PC, sending would put a file into the shared office feedback folder. The Cancel half is safe now.
   - **D20 (CDRENUMBER) may also need one:** a drawing with mixed-up pit numbers, if DRV1_B1 already numbers downhill to uphill.
4. **Routes proven:**
   - **4 fully proven:** D01, D03, D12, D18.
   - **7 partly proven:** D07, D14, D19, D21, D24, D26, D27.
   - **19 unproven:** steps are written from the source and marked as such.
5. **Kinds:** 25 are deterministic. 5 need a window look: D05, D22, D28, D29, D30.
6. **The five riskiest tools:**
   1. **UX-LYR-04 (D25), not built.** The gap plan counts it as installed. Max will get no greyed existing work and no demolished layer.
   2. **UX-WORD-03 CDFEEDBACK (D29).** This is Max's only bug route, and nobody has ever pressed "Send report" in AutoCAD. On a PC without the office folder it saves on that PC only and asks him to email the file.
   3. **UX-CPLAN-18/19 CDRENUMBER (D20).** It renumbers every plain P pit in the drawing in one go and has never been run in AutoCAD. A wrong outlet choice would renumber a whole job (one U puts it back).
   4. **UX-SCHED-04 (D22).** The drawn Pit Schedule goes on the issued sheet. Its continuation onto a next sheet has never been driven, and the robot lists the drawn schedule as blocked.
   5. **UX-PIT-02 / UX-PIPE-02 joins (D02, D03).** A pipe that silently misses its pit gets wrong links and levels. A typed first point that missed its pit was seen in robot run 30 ("Flow: Open end -> P9", the BUG-560 drift).

### Corrections to the gap plan (RULES 6.2)

1. **UX-PIPE-02 is not "auto-join within 75 mm".** A pipe end joins a pit inside the pit's outline plus 100 mm (`linking.pitCatchMarginMm`, D02). The 75 mm figure is UX-PIPE-02b, which joins a pipe end to another pipe end. That switch, `linking.autoJoinPipeEnds`, is **false** in Tim's file, so it is OFF.
2. **UX-LYR-04 is not built.** The installed line has only these pieces:
   - **Pit status, data only:** a status field on the pit record (commit 41a1b21a), with no window or command that sets it.
   - **Existing pipes:** existing pipes on EX DRAIN HATCH, colour 61, which is green, not grey.
   - **Checks switch:** `checks.leaveOutRemovedPits`, OFF.
3. **UX-LYR-01 is only part-built.** Built so far:
   - **Layers and current layer:** objects go on office layers, and CD and Edit Pipe keep the current layer.
   - **Layer names in Settings:** empty means today's names (00b09bd3).
   - **Missing layers:** made in the office colour (ba0bb8e0).

   Not built: "an existing layer is never recoloured". Card 5.1 classes it MODIFY.
4. **Three items are OFF for Max:**
   - **UX-LBL-01:** `linking.handPlacedLabelsStay` false.
   - **UX-UNDO-01:** `options.cdCommandLine.sayWhatWasUndone` false, and `options.autoCadStyleCdPrompts` false.
   - **UX-SCHED-06:** its refinement (P1A straight after P1, SPS2 before SPS10) is behind `linking.pitScheduleNaturalOrder` false. The basic order (P2 before P10) already works with it off.

   Until Tim switches the first two on, they are not daily tools for Max.
5. **The UX-PIPE card is stale.** `docs/workflows/UX-PIPE-01-03-07_CARD.md` says UX-PIPE-03 is "guarded by CD-ESC-01 (044fbb88)". CD-ESC-01 was withdrawn the same afternoon (8093c4ed). The installed behaviour is Escape at the third point cancels the pipe, which matches Tim's 25 Sep ruling "Keep CE's rule".

### For the desk, not Tim

1. **AutoCAD was running during my reads.** At 00:00 to 00:18 on 23 Oct a test session held a temporary guard change in Tim's CD_Settings.json (`checks.checksCommandEnabled` true). By 00:18 the file was back to its original hash ACD64E79A33B, which I read myself. AutoCAD was still running at 00:18. I touched nothing.
2. **CE writes files beside drawings.**
   - **On open:** CE writes `<drawing>_PRE_C7_<time>.dwg` beside each drawing it opens (robot run 47, A.5).
   - **On CD placement:** CE writes `pipe.lastChoiceByJob` into Tim's settings file.

   Neither changes the drawing itself, but every case must keep the guard restore and the end-of-case hash check.

---

## RECIPE CONVENTIONS (inherited)

1. **The recipe rules are not repeated here.** All recipe conventions 1 to 12 of `C:\CE_PLAN\areas\TEST_CASES_DRAFT_22OCT.md` apply unchanged to every case: TYPE, `<LF>`, PICK-FIRST, READ ENTITY, READ SELECTION, START, BASELINE, END, the four settings hashes, LOG NEW from byte offsets, pointer preconditions, window rules, and ROUTE PROVEN versus UNPROVEN.
2. **Two extra field labels.** COMMAND says what the tool does in one plain sentence. INSTALLED and SWITCH carry the git and settings evidence.
3. **Settings file:** CD = `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. Tim's original hash is ACD64E79A33B, read 23 Oct 00:18. All Civil keys named below live in that file. Change them only through the settings guard before launch, read them back from the file, and restore by hash.
4. **Outcome log lines:** "Command outcome: PIT|CD cancelled" after a PIT or CD finished with Esc is BUG-862. Its fix is drafted and not installed. Judge the word against the installed build and record it; do not fail a case on it.
5. **No raw LISP.** Run 47 wedged AutoCAD on a typed LISP line. Every drawing read below is a READ ENTITY or READ SELECTION. Earlier LISP reads are cited only as proof that the value can be read.

## FIXTURES USED (all exist; hashes read 23 Oct)

1. **F-B1** = `C:\ce_rc_drv\DRV1_B1.dwg`, 1,080,181 bytes, SHA-256 34BBE37C2EA4...
   - **Pit P3:** handle 109D56 (INSERT on STORMWATER PIT, read by Codex V10 item 9).
   - **Pipe P3:** handle 10A98D.
   - **Older downpipe:** 1093C7. Never touch it.
   - **At open:** CLAYER is BLOCKS and INSUNITS is 4 (Codex V10 item 8). The CE log reads "pits=11, pipes=49".
2. **F-BLANK** = `C:\ce_rc_vc7\BLANK_TARGET_VC7.dwg`, 10,056 bytes, SHA-256 9A8AA4DDCC29... It is empty and untagged. Opening it asks "This drawing isn't tagged yet. Is this a Civil drainage drawing? [Yes/No] <Yes>": answer Y. Codex V10 read INSUNITS 0 at open.
3. **F-SCHED** = `C:\Lisp Files\_TEST_COPIES_20260923\V3UX_20261014\schedule-placement\CODEX_SCHEDULE_PLACE_20261014.dwg`, 150,627 bytes, SHA-256 371768A9FAA4... It is an optional alternative for D22. I have not verified its contents.
4. **F-DWGCHK** = `C:\Lisp Files\_TEST_COPIES_20260923\V3UX_20261014\drawing-check\CODEX_DWG_CHECK_20261015.dwg`, 161,895 bytes. It is an optional alternative for D28. I have not verified its contents.

## SHARED SETUP SETUP-P8 (route proven: R47 B.4.2, R44 B.5, R45 B.6, R46 B.3; pit named P8 on this fixture per robot run 31)

1. **New pit.** TYPE "PIT<LF>150000,-80000"; expect window New Pit. Set C2.CoverLevel=19.000. Press "Continue placement" with a 120 s allowance (the robot measured 39 to 58 s).
2. **End the pit.** esc-prompt three times: at "Specify pit label insertion point:", at "Click to place cover text (Enter = <BR>):" and at the next-pit prompt. Require "Pit placed successfully." and "[CE] Stopped. Everything placed stays; U takes back the last one." With `linking.pitLabelOnEsc` OFF, these Escapes leave the pit with no label and no cover text.
3. **New pipe.** TYPE "CD<LF>150000,-80000<LF>170000,-80000<LF>"; expect New Pipe. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.900. Press "Start Pipe" with a 120 s allowance (it passed the 30 s watchdog in runs 43 to 46).
4. **End the pipe.** esc-prompt once. Require:
   - "[CE] End is free: open end flagged, connect it later."
   - "Inserted flow arrow. Flow: P8 -> Open end"
   - "[CE] Pipe placed."
   - "[CE] Stopped."
5. **New objects.** Resolve them as the difference between the handle sets before and after. Never select by picture.

---

CASE D01
TITLE PIT and CD keep placing until Esc, and Esc keeps what was placed
PLAN ITEM UX-STD-01b (gap plan 2 item 1)
COMMAND PIT and CD place one pit or pipe after another without retyping the command, until Esc.
INSTALLED Yes. Commit fe4f6904 (26 Sep, "apply UX-STD-01b override (no Batch tick at all)") is in the ref. The wording is in `PitCommand.cs:219` "[CE] Pit placed. Pick the next pit, or press Esc to stop.", `CdCommand.cs:235` "[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop." and `PlacementContinuationService.cs:69`.
SWITCH None: always on. Related: `options.cdDrawFirst` true in Tim's file, so CD asks for points first and then opens New Pipe.
BUILD Civil 3.0.70 / Manager 1.1.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE PROVEN BY R47 B.4.2 (also R44 B.5, R45 B.6, R46 B.3) for the Esc ending. Ending a run with Enter alone is UNPROVEN.
STEPS
1. START and BASELINE. Capture handle set H0 and the Civil log offsets.
2. Run SETUP-P8 steps 1 and 2. Read history after "Continue placement" and after the third esc-prompt.
3. Run SETUP-P8 steps 3 and 4. Read history after "Start Pipe" and after the esc-prompt.
4. Read handle set H1. Check ObjectName and Layer of every handle in H1 minus H0 with READ ENTITY.
5. TYPE "U" once. Read its echo, then read handle set H2.
ASSERTIONS
1. History holds "[CE] Pit placed. Pick the next pit, or press Esc to stop." and "[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop.". Each Esc is followed by "[CE] Stopped. Everything placed stays; U takes back the last one." for the pit and "[CE] Stopped." for the pipe.
2. H1 minus H0 holds exactly one new STORMWATER PIT insert and one new pipe. No second New Pit or New Pipe window opened after an Esc.
3. After one U the new pipe, its arrow and its texts are gone and the new pit is still there. Record the U echo word.
4. LOG NEW in CE_CVL_SUITE.log holds exactly one "Command outcome: PIT <word> <n> ms" and one "Command outcome: CD <word> <n> ms". Record the word (BUG-862, convention 4).
KIND deterministic
FAIL MEANS PIT or CD stops after one object, keeps going after Esc, or Esc throws away what was already placed.
WHY A UNIT TEST CANNOT CATCH THIS The run is a chain of real AutoCAD command instances queued one behind another. Only live AutoCAD shows the next prompt and the Esc ending.

---

CASE D02
TITLE A pipe end catches a pit only within its outline plus 100 mm
PLAN ITEM UX-PIT-02 (gap plan item 2)
COMMAND CD joins a pipe end to a pit only when the end lands inside the pit's real outline plus 100 mm. The pit block's hidden circle no longer counts.
INSTALLED Yes. Commit 64c5e3cc (27 Sep, "pit catch reach") is in the ref. Code: `UserSettings.cs:894` `pitCatchMarginMm` and `Rules/PitOutline.cs` TouchMarginMm.
SWITCH `linking.pitCatchMarginMm` = 100.0 in Tim's file (build default 100, range 0 to 500). The pit size defaults in Tim's file are `pit.xWidth` 600 and `pit.yWidth` 900. `pit.spsRadius` is "0".
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. The PIT and CD chain is proven (R47 B.4.2). The outline read and the two near-miss pipes have never been run. Find the pit's edge from data, never from a picture.
STEPS
1. Run SETUP-P8 steps 1 and 2 only, so there is a pit P8 and no pipe. Resolve P8's handle and read its rotation with READ ENTITY.
2. TYPE "PITSCHEDULE". Read the Rows tree (R44 B.9 route), take P8's PIT SIZE, and close the schedule by its proven close route.
3. Compute the pit's +X edge. Width W runs along X at rotation 0. Xe = 150000 + W/2, which is 150300 if W is 600. If the rotation is not 0, or PIT SIZE is blank, stop the case as BLOCKED.
4. Draw the near pipe. TYPE "CD<LF>160000,-79800<LF><Xe+90>,-79800<LF>"; expect New Pipe. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.950. Press "Start Pipe" (120 s), then esc-prompt once. Read history and the polyline vertices.
5. Draw the far pipe. TYPE "CD<LF>160000,-80200<LF><Xe+110>,-80200<LF>". Use the same inverts, Start Pipe and esc-prompt. Read history and vertices.
ASSERTIONS
1. **Near pipe (end 90 mm outside the outline):** history has "Flow: Open end -> P8" and no "End is free" line for the end at the pit. Its last vertex X is less than or equal to Xe, because the end moves onto the pit wall.
2. **Far pipe (end 110 mm outside):** history has "[CE] End is free: open end flagged, connect it later." and "Flow: Open end -> Open end". Its last vertex stays at Xe+110, within 1 mm.
3. Neither pipe names any other pit.
KIND deterministic
FAIL MEANS A pipe end snaps onto a pit it does not touch, or misses one it does touch. The Pit Schedule then carries wrong inlets and levels.
WHY A UNIT TEST CANNOT CATCH THIS The catch uses the real pit block's drawn outline and the live CD landing in the drawing.

---

CASE D03
TITLE A new pipe joins the only pit at its end
PLAN ITEM UX-PIPE-02 (gap plan item 3, wording corrected above)
COMMAND CD joins a new pipe end to the pit it lands on when exactly one pit is there.
INSTALLED Yes, behaviour from before 25 Sep. `docs/workflows/UX-PIPE-01-03-07_CARD.md` (rewritten 30 Sep) says "UX-PIPE-02 auto-join to the only matching pit - BUILT, unchanged". REGRESSION_LOG says "The pit half already exists and is unchanged".
SWITCH None for joining a pit: always on. The separate pipe-to-pipe-end join (UX-PIPE-02b) is `linking.autoJoinPipeEnds` false in Tim's file, with `linking.pipeEndJoinDistanceMm` 75.0. It is OFF.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE PROVEN BY R47 B.4.2 "Inserted flow arrow. Flow: P8 -> Open end" (also R44 B.5, R45 B.6, R46 B.3).
STEPS
1. Run SETUP-P8 in full and read every new history line.
2. With READ ENTITY, read the new pipe's first vertex and P8's insertion point.
3. TYPE "PITSCHEDULE". Read P8's outlet DIA and outlet IL cells from the Rows tree, then close.
ASSERTIONS
1. History has "Inserted flow arrow. Flow: P8 -> Open end" and exactly one "[CE] End is free: open end flagged, connect it later." That line is for the far end, which is free by design.
2. The pipe's first vertex lies inside P8's outline, within the 100 mm catch.
3. The Pit Schedule row P8 shows outlet IL 18.000 and the pipe's diameter.
4. If history shows "Flow: Open end -> Open end" or "Open end -> ..." for this start, record FAIL and cite the BUG-560 drift seen in robot run 30.
KIND deterministic
FAIL MEANS A pipe drawn from a pit is left unjoined, so the schedule and the levels lose that pipe.
WHY A UNIT TEST CANNOT CATCH THIS The join is made by the live CD point landing against the real pit in the drawing.

---

CASE D04
TITLE Esc at CD's third point cancels the pipe and draws nothing
PLAN ITEM UX-PIPE-03 (gap plan item 4)
COMMAND CD with two points picked: Esc at the third point throws the pipe away, and Enter gives the straight pipe.
INSTALLED Yes. `CdCommand.cs` TryCollectPoints returns false on Esc, which prints "[CE] CD command cancelled." (`CdCommand.cs:99`). CD-ESC-01 (044fbb88), which kept the two-point pipe on Esc, was withdrawn by 8093c4ed on 23 Sep. Tim ruled on 25 Sep: "Keep CE's rule".
SWITCH None. In Tim's file, `options.cdDrawFirst` is true and `options.autoCadStyleCdPrompts` is false (the old prompt words).
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. The two typed CD points are proven (R47 B.4.2). Esc at the third point has never been run. The chain must not end with a final <LF>.
STEPS
1. Read handle set H0, DBMOD, the history offset and the Civil log offsets.
2. TYPE "CD<LF>150000,-80000<LF>170000,-80000", with no final Enter. Require the third-point prompt to be waiting and record its exact words.
3. esc-prompt once and wait idle. Read history, the window list and handle set H1.
4. Contrast run (proven). TYPE "CD<LF>150000,-85000<LF>170000,-85000<LF>"; expect New Pipe. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.900, press "Start Pipe", then esc-prompt once. Read handle set H2.
ASSERTIONS
1. After the Esc, history has "[CE] CD command cancelled.", no New Pipe window opened, and H1 = H0 (no polyline, arrow or text left behind).
2. LOG NEW has one "Command outcome: CD cancelled <n> ms" for step 3.
3. After the contrast run, H2 minus H1 holds exactly one pipe with two vertices.
KIND deterministic
FAIL MEANS Esc leaves a half-made pipe in the drawing, or opens the pipe window anyway.
WHY A UNIT TEST CANNOT CATCH THIS The result depends on AutoCAD's live point prompt answering Esc during real point collection.

---

CASE D05
TITLE The pipe window offers the recent diameters, materials and inverts as one-click buttons
PLAN ITEM UX-PIPE-04 (gap plan item 5)
COMMAND The New Pipe and Edit Pipe window shows "Recent:" buttons for diameter, material and invert. One click fills the box.
INSTALLED Yes. Commit 49c22823 (25 Sep) is in the ref. `PipeEditWorkshopDialog.xaml:112, 124, 266` gives automation names "Use recent diameter {n}" and "Use recent material {m}". `WorkshopEditorFocus.cs:204` gives "Use recent invert {x} m AHD".
SWITCH None.
- **Window:** Tim's file has `editorShell.flags."editors.workshopLayout"` true, so this window is the one in use.
- **Recent lists:** `pipe.recentDiameters` holds 9 values starting 300, 100, 450. `pipe.recentMaterials` holds 5 values starting UPVC, STORMPRO.
- **Settings write:** CD also writes `pipe.lastChoiceByJob` into the file on placement. The guard must restore it.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed. Record any in-session hash change of CD_Settings.json as a CE write and require it restored at END.
ROUTE UNPROVEN. New Pipe opening and `ui set` on C2.* are proven (R47). The Recent buttons have never been read or pressed.
STEPS
1. Run SETUP-P8 steps 1 and 2. TYPE "CD<LF>150000,-80000<LF>170000,-80000<LF>"; expect New Pipe.
2. Read the window controls as text. List every control named "Use recent diameter *", "Use recent material *" and "Use recent invert *". Capture the whole window.
3. Press "Use recent diameter 225". If it is not listed, press the first listed value that differs from the current diameter, and record which. Read the diameter field.
4. Press "Use recent material STORMPRO". If it is not listed, press the second listed material, and record which. Read the material field.
5. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.900, press "Start Pipe", then esc-prompt once. READ ENTITY the new label.
ASSERTIONS
1. The diameter buttons equal the file's `pipe.recentDiameters` values, and the material buttons equal `pipe.recentMaterials`. Record any extra or missing value.
2. After each press the box equals the button's value. The drawn label begins "<that diameter> DIA. <that material> PIPE".
3. The capture shows the Recent row unclipped and readable (look).
KIND needs a window look (assertions 1 and 2 are deterministic)
FAIL MEANS The buttons are missing, show the wrong values, or a press does not reach the box and the drawn label.
WHY A UNIT TEST CANNOT CATCH THIS The buttons are built from the real settings lists inside the installed window.

---

CASE D06
TITLE "Show grade in pipe text" can be turned off on an ordinary pipe
PLAN ITEM UX-PIPE-05 (gap plan item 6)
COMMAND New Pipe has a "Show grade in pipe text" toggle on every pipe type. Off, the drawn label leaves out "AT 1 IN ...", and the grade stays in the pipe's data.
INSTALLED Yes. Commits 49c22823 and f8b1d072 (a separate stored value per pipe type) are in the ref. `CdViewModel.cs:151` labels the toggle "Show grade in pipe text" (ordinary pipe) or "Include known grade" (existing pipe).
SWITCH `pipe.nonExistingPipeShowGrade` true in Tim's file (shown). Unticking writes false into the file; the guard restores it.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None set beforehand. Record the in-session write of `pipe.nonExistingPipeShowGrade`.
ROUTE UNPROVEN. The toggle has never been pressed by the robot or Codex.
STEPS
1. Run SETUP-P8 steps 1 and 2. TYPE "CD<LF>150000,-80000<LF>170000,-80000<LF>"; expect New Pipe.
2. Read the unique toggle "Show grade in pipe text" (expect on). Set it off through its control and read it again.
3. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.900, press "Start Pipe", then esc-prompt once.
4. READ ENTITY the new label and both new IL texts.
5. With the guard still holding, read `pipe.nonExistingPipeShowGrade` from the file.
ASSERTIONS
1. The label matches "^[0-9]+ DIA\. .+ PIPE$". It contains no "AT 1 IN" and no "FLAT".
2. The IL texts still read "IL 18.000" and "IL 17.900".
3. The in-session file value is false and is restored at END (common hash check).
KIND deterministic
FAIL MEANS The grade cannot be hidden on an ordinary pipe, or hiding it changes the levels.
WHY A UNIT TEST CANNOT CATCH THIS The toggle, the label writer and the settings file have to agree in the live window.

---

CASE D07
TITLE A downpipe and a raingarden can be placed before any pipe exists
PLAN ITEM UX-SRC-05 (gap plan item 7)
COMMAND DP (downpipe) and CDRG (raingarden) place on their own, like pits, on a drawing with no pipes.
INSTALLED Yes. Commit bd884d1f (BUG-176, merged in #346) is in the ref. CDRG and GIO no longer require a pipe. DP already placed free-standing through `SourcePlacementService.Place`.
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-BLANK, fresh copy (no pits, no pipes)
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN. DP is proven by Codex V10 (`CODEX_VERIFY_V10_20261022_2056.md` items 6 and 8): Y to the untagged question, DP at 150000,-80000, then "Downpipe placed. Tag: DP1. Nothing nearby. The source connects when a pipe is drawn to it." CDRG is UNPROVEN: typed points into its drag preview, the Close keyword and the GIO question.
STEPS
1. Open the copy and answer "Y" to the untagged question. Require "[CE] Drawing tagged Civil - civil drainage tools are enabled here." Read handle set H0.
2. TYPE "DP<LF>150000,-80000". Read history, then esc-prompt at "[CE] Pick the next DP, or press Esc to stop.".
3. TYPE "CDRG<LF>160000,-80000<LF>164000,-80000<LF>164000,-77000<LF>160000,-77000<LF>C<LF><LF>". The last empty answer takes the default Skip at "Add a GIO source to this raingarden? [Place/Skip] <Skip>:". If any other prompt waits, esc-prompt and mark the CDRG half BLOCKED with the prompt text.
4. Read handle set H1. TYPE "U" once and read handle set H2.
ASSERTIONS
1. **DP:** history holds "Downpipe placed. Tag: DP1." and one new insert named DOWNPIPE DYNAMIC WITH MASK.
2. **CDRG:** a closed boundary and an RG1 label exist in H1 minus H0. History has no "CDRG command cancelled." and no refusal that mentions a pipe.
3. One U removes every raingarden piece and leaves the downpipe (H2 = H0 plus the downpipe).
KIND deterministic
FAIL MEANS A source refuses or misbehaves when there is no pipe yet, which is the normal order of drafting.
WHY A UNIT TEST CANNOT CATCH THIS The placement route depends on the live drawing having no pipe to split or join.

---

CASE D08
TITLE Overflow and front overflow use one symbol with different tags
PLAN ITEM UX-SRC-01 (gap plan item 8)
COMMAND OF and FO place the same overflow symbol. The tag (OF1 or FO1) and the plan label tell them apart.
INSTALLED Yes. Commit 74b12f51 (built) and commit 1d1e1541 (29 Sep, guard tests and card `docs/workflows/UX-SRC-01-03_CARD.md`) are in the ref. In `SourceBlockInsertCommands.cs:75-93`, OF and FO both insert BLOCK_OVERFLOW.
SWITCH None in Settings. The project's "Number sources" setting in the Pit Schedule window (default "Only when scheduled") decides whether the label reads OF or OF1.
BUILD Civil 3.0.70
FIXTURE F-BLANK, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. OF and FO have never been typed by the robot or Codex. The DP route has the same shape and is proven (Codex V10).
STEPS
1. Open the copy and answer Y. Read handle set H0.
2. TYPE "OF<LF>150000,-80000". esc-prompt at "[CE] Pick the next OF, or press Esc to stop.".
3. TYPE "FO<LF>152000,-80000". esc-prompt at the next-FO prompt.
4. READ ENTITY both new inserts: block name, tag attribute and the plan label text.
ASSERTIONS
1. History holds "Overflow placed." and "Front overflow placed.".
2. Both inserts have the same block name.
3. The tags are OF1 and FO1, each counting from 1. With the default Number sources, the plan labels read "OF" and "FO".
KIND deterministic
FAIL MEANS An overflow and a front overflow look different, or carry the same tag, so the schedule mixes them up.
WHY A UNIT TEST CANNOT CATCH THIS The real block insert, the tag counter and the label are written in the live drawing.

---

CASE D09
TITLE The pit label shows the pit number and the cover text shows CL and the level
PLAN ITEM UX-CPLAN-21 (gap plan item 9)
COMMAND PIT writes a number label ("P8") and a cover-level text ("CL 19.000") when the drafter places them.
INSTALLED Yes, behaviour from before 25 Sep, audited 27 Sep (daf6f486). REGRESSION_LOG records `PitViewModel` LabelPosition "BR", AddCoverText true and the PIT_LABEL attribute. `PitAnnotationTextFormatter.cs:28` formats "CL {level}".
SWITCH `options.createText` true in Tim's file. `linking.pitLabelOnEsc` is absent, so it defaults OFF: Esc at the label prompt leaves NO label. This case therefore answers the prompts with points.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. SETUP-P8 Escapes both prompts (proven). Answering them with typed points has never been run.
STEPS
1. TYPE "PIT<LF>150000,-80000"; expect New Pit. Set C2.CoverLevel=19.000 and press "Continue placement" (120 s).
2. At "Specify pit label insertion point:", TYPE "150900,-79100".
3. At "Click to place cover text (Enter = <BR>):", send an empty answer (TYPE "") for the office corner.
4. esc-prompt at the next-pit prompt.
5. With READ ENTITY, read the new PIT LABEL block (attribute PIT_LABEL, layer, insertion point) and the new cover MTEXT (contents, layer).
6. TYPE "U" once and read the handle set.
ASSERTIONS
1. PIT_LABEL reads "P8". The block is on layer STORMWATER PIT LABEL with its insertion at 150900,-79100 within 1 drawing unit.
2. The cover text contents match "^CL 19\.0+$" as its only line. There is no IL line, because invert display is off by default.
3. One U removes the pit, its label and its cover text together.
KIND deterministic
FAIL MEANS A placed pit is missing its number or its cover level, or they are on the wrong layer.
WHY A UNIT TEST CANNOT CATCH THIS The label block, the attribute and the MText are created by the live PIT prompts.

---

CASE D10
TITLE The pipe label sits mid-pipe along the line and reads "100 DIA. UPVC PIPE AT 1 IN 200"
PLAN ITEM UX-CPLAN-23 (gap plan item 10)
COMMAND CD writes one label at the middle of the pipe, along the line, reading left to right, with size, material and grade.
INSTALLED Yes, behaviour from before 25 Sep, audited by daf6f486. `QuickModeService.CalculatePipeTextPosition` puts it at the midpoint and `GetReadableTextAngleWithVerticalFlip` keeps it readable. `PipeAnnotationTextFormatter.cs:129` formats "{d} DIA. {m} PIPE AT 1 IN {g}".
SWITCH Tim's file has `options.createText` true, `options.pipeTextLayoutMode` "auto", `options.defaultPipeTextPosition` "Above" and `pipe.nonExistingPipeShowGrade` true. Default pipe: `pipe.diameter` "100", `pipe.material` "UPVC". `pipe.lastChoiceByJob` can override these per folder, so the case reads the window.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN for reading the label. Placement is proven (R47 B.4.2). Robot run 31 recorded this same 20 m pipe as "exactly 1 in 200" (build 3.0.5x).
STEPS
1. Run SETUP-P8. In step 3, before "Start Pipe", read the New Pipe diameter and material fields as text (d, m).
2. Resolve the new TEXT or MTEXT whose content contains " DIA. ".
3. READ ENTITY its contents, position, rotation and layer, plus the pipe polyline's vertices and length L.
ASSERTIONS
1. The text equals "<d> DIA. <m> PIPE AT 1 IN <g>", where g = round(L in metres / 0.100). Robot run 31 expects g = 200.
2. Projected onto the pipe, the label lies within 10 per cent of the pipe length of its midpoint. It is offset to the Above side, with rotation 0 (reads left to right).
3. Exactly one such label exists for this pipe, and it never reads "TYP.".
KIND deterministic
FAIL MEANS The pipe label has the wrong size, material or grade, or sits off the pipe or upside down.
WHY A UNIT TEST CANNOT CATCH THIS The label position comes from the real drawn polyline and the live text writer.

---

CASE D11
TITLE A pipe too short for its label gets the label on a leader
PLAN ITEM UX-CPLAN-24 (gap plan item 11)
COMMAND CD puts a short pipe's label out on a leader when the text would not fit along the pipe.
INSTALLED Yes, behaviour from before 25 Sep. `TextService.cs:154` RequiresPipeCallout triggers when the text is wider than 95 per cent of the pipe length. `CreatePipeTextCallout` (line 355) builds an MLeader. This is not Tidy labels' leader-out (`linking.tidyLeaderOut` false, OFF).
SWITCH `options.pipeTextLayoutMode` "auto" in Tim's file.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. No short pipe has ever been drawn by the robot or Codex. `TryPreparePipeCallout` may ask for a leader point, and its prompt words are unknown.
STEPS
1. Run SETUP-P8 steps 1 and 2.
2. TYPE "CD<LF>150000,-80000<LF>151200,-80000<LF>" (1.2 m); expect New Pipe. Set C2.FirstInvert=18.000 and C2.SecondInvert=17.990, then press "Start Pipe".
3. If a leader or label point prompt waits, record its words and TYPE "151200,-78500". Any other unknown prompt: esc-prompt and BLOCKED.
4. esc-prompt at the next-pipe prompt. Resolve the new entities.
ASSERTIONS
1. There is exactly one new MULTILEADER whose text contains " DIA. ". There is no plain mid-pipe label for this pipe.
2. The leader's arrow point lies within the pipe's extents, within 50 mm.
3. Record the grade text (expected "AT 1 IN 120" or what the trimmed length gives).
KIND deterministic
FAIL MEANS A short pipe's label is crammed over the pipe and its pits instead of being led out clear.
WHY A UNIT TEST CANNOT CATCH THIS The fit test uses the real text width and the drawn length, and the leader is placed by live prompts.

---

CASE D12
TITLE One IL text at each pipe end
PLAN ITEM UX-CPLAN-26 (gap plan item 12)
COMMAND CD writes one invert-level text at each end of the pipe, near where it meets the pit.
INSTALLED Yes, behaviour from before 25 Sep, audited by daf6f486. `LabelPlacementRule` has AtPipeStart and AtPipeEnd. `PipeEndAnnotationTextFormatter.cs:10` writes "IL {value}" once per end. Not built: the ruling's "with a short leader" (REGRESSION_LOG audit item 6, which waits for a card).
SWITCH Tim's file has `options.createText` true, `options.defaultInvertPosition` "Bottom" and `options.invertInwardDistance` 200.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE PROVEN BY robot run 32 V2 B and run 33 V2 B.8 (build 3.0.56). The new pipe's IL texts were read as "IL 18.000" and "IL 17.900", one each. Placement is re-proven on 3.0.70 by R47 B.4.2. The old LISP read becomes READ ENTITY.
STEPS
1. Run SETUP-P8.
2. READ ENTITY every TEXT or MTEXT in H1 minus H0 whose content begins "IL ". Record each one's distance from P8's insertion point and from the pipe's open end.
ASSERTIONS
1. There are exactly two new IL texts: "IL 18.000", the nearer to P8 (within 1500 mm of its centre), and "IL 17.900", the nearer to the open end.
2. Neither end has a second IL text.
3. Record, without judging, whether a leader line is drawn. None is expected, because that nuance is not built.
KIND deterministic
FAIL MEANS A pipe end is missing its invert level, or has two, so the levels on the plan cannot be read.
WHY A UNIT TEST CANNOT CATCH THIS The two texts are placed against the real pit and pipe geometry in the drawing.

---

CASE D13
TITLE A pipe label moved by hand stays where it was put (switch OFF for Max today)
PLAN ITEM UX-LBL-01 (gap plan item 13)
COMMAND After you MOVE one pipe label by hand, later CE label tidying leaves it where you put it.
INSTALLED Code yes, behaviour OFF. Batch 1 card 1.2 is in the ref: `Rules/HandPlacedLabelRule.cs` and `UserSettings.cs:662` `handPlacedLabelsStay`. REGRESSION_LOG says "default OFF until Tim says".
SWITCH `linking.handPlacedLabelsStay` is absent from Tim's file, so it is false (OFF). `linking.tidyLabelsEnabled` is absent, so Tidy labels is OFF too. Max gets neither until Tim switches them on.
BUILD Civil 3.0.70
FIXTURE F-B1, two fresh copies (profile A, profile B)
SETTINGS NEEDED Profile A: none. Profile B: `linking.handPlacedLabelsStay`=true and `linking.tidyLabelsEnabled`=true through the guard before launch, each read back from the file.
ROUTE UNPROVEN.
STEPS
1. Run SETUP-P8. Resolve the new pipe label handle L and its position P0.
2. PICK-FIRST L, then TYPE "_.MOVE<LF>0,0<LF>0,1000". Read L's position P1.
3. PICK-FIRST the P8 pit handle, then TYPE "_.MOVE<LF>0,0<LF>500,0". A pit move re-tidies its pipe's labels. Read L's position P2 and history.
4. Profile B only: TYPE "CDTIDYLABELS<LF>All". Read the summary, then esc-prompt at "Move this label now? [Yes/No] <No>:".
ASSERTIONS
1. **Profile B:** P2 equals P1 within 1 mm. The Tidy summary counts "Placed by hand (left alone) 1".
2. **Profile A:** record P2 and history. With the switch off, CE may re-place the label. This is the expected OFF behaviour, not a fail.
3. Both profiles: the four settings hashes are restored at END.
KIND deterministic
FAIL MEANS With the switch on, CE still moves a label the drafter placed on purpose.
WHY A UNIT TEST CANNOT CATCH THIS The hand-placed mark is written by a real MOVE and read by a later live tidy.

---

CASE D14
TITLE Erasing a pit keeps its pipes with free ends and one U restores everything
PLAN ITEM UX-EDIT-01 (gap plan item 14)
COMMAND Plain ERASE on a connected pit removes the pit. Its pipes stay with "Not connected yet" ends, one line says how many, and one U restores everything.
INSTALLED Yes. Commits d4f52fca and 9a32d7f4 (29 Sep) are in the ref. Code: `Services/PitEraseFreeEndsMessagePolicy.cs`, called from `LinkService.Utilities.cs:3382`.
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-B1, pit P3 109D56
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN BY robot run 25 B.3 and B.4 (build 3.0.53). Typed `_.ERASE` after PICK-FIRST, then U, was proven for a pipe and for a pit label. Erasing the pit body itself has never been run.
STEPS
1. READ ENTITY 109D56 and require INSERT on STORMWATER PIT. Otherwise stop the case as BLOCKED.
2. Count the pipes joined to P3 (N) from the Pit Schedule P3 inlet and outlet cells (R44 B.9 route), and record their handles. Read the entity count E0.
3. PICK-FIRST "109D56", then TYPE "_.ERASE". Read history and entity count E1.
4. Check that each of the N pipe handles still exists.
5. TYPE "U" once. Read the echo, entity count E2, and whether 109D56 exists.
ASSERTIONS
1. History has "[CE Civil] The pit was erased and the schedule is updated. N pipes now have ends that are Not connected yet. U restores everything.". For N = 1 the wording is "1 pipe now has an end that is Not connected yet".
2. All N pipes still exist after the ERASE.
3. After one U, 109D56 exists, E2 = E0 and the echo is "ERASE".
KIND deterministic
FAIL MEANS Erasing a pit takes its pipes with it, says nothing, or cannot be undone in one step.
WHY A UNIT TEST CANNOT CATCH THIS The message comes from CE watching a real native ERASE and its links in the drawing.

---

CASE D15
TITLE Copying a pit makes a real CE pit with a new number, flagged Check levels
PLAN ITEM UX-EDIT-02 (gap plan item 15)
COMMAND COPY on a pit makes a real CE copy with the next free number. Its levels are flagged "Check levels" until confirmed in Edit.
INSTALLED Yes. Commits 3adea8f7 and 70f9bf98 (29 Sep) are in the ref. Code: `Rules/CopiedLevelsRule.cs` and `LinkService.Utilities.cs:520`.
SWITCH None for a plain COPY. Related settings in Tim's file:
- **Grip, rotate and scale copies:** `linking.cleanUpGripRotateScaleCopies` false. It covers only those copies.
- **Copy clean-up:** `linking.copyCleanUpKeepsEveryPiece` true.
- **Native copy:** `options.useNativeCopyRotate` false.
BUILD Civil 3.0.70
FIXTURE F-B1, pit P3 109D56
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. Robot run 2026-10-09 wedged AutoCAD because COPY's Multiple mode left a point prompt open. The chain below ends COPY explicitly.
STEPS
1. Verify 109D56 as in D14 step 1. Read handle set H0.
2. PICK-FIRST "109D56", then TYPE "_.COPY<LF>0,0<LF>0,-5000<LF>". The last <LF> answers the next "Specify second point" and ends COPY. If AutoCAD still waits, esc-prompt once and record it.
3. Read history and handle set H1. READ ENTITY the copied pit's PIT_LABEL (through its new label block) and the original's.
4. TYPE "U" once and read handle set H2.
ASSERTIONS
1. History has "1 pit copied and numbered as new. Check levels: they came across from the originals (the Inspector shows which ones to confirm).". If pipes came too, it reads "1 pit and N pipes copied ...".
2. The copy's PIT_LABEL is a new free P number, not "P3". The original still reads "P3".
3. After one U, H2 = H0.
KIND deterministic
FAIL MEANS A copied pit keeps the original's number or silently carries levels as if they were checked.
WHY A UNIT TEST CANNOT CATCH THIS CE reacts to a real native COPY and renumbers the clone in the live drawing.

---

CASE D16
TITLE Exploding a pit is allowed and says what left the schedule
PLAN ITEM UX-EDIT-04 (gap plan item 16)
COMMAND EXPLODE on a CE pit is allowed. One line names what is now plain linework and has left the schedule, and U restores it.
INSTALLED Yes. Commits 6f2ad64e and 9a32d7f4 (29 Sep) are in the ref. Code: `Services/ExplodeLeftScheduleMessagePolicy.cs` (wording at lines 58 and 74).
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-B1, pit P3 109D56
SETTINGS NEEDED None changed.
ROUTE UNPROVEN.
STEPS
1. Verify 109D56. Read the Pit Schedule rows (R44 B.9 route) and confirm P3 is listed, then close.
2. PICK-FIRST "109D56", then TYPE "_.EXPLODE". Read history.
3. Read whether 109D56 exists. TYPE "PITSCHEDULE", read the rows and close.
4. TYPE "U" once. Reopen the schedule, read the rows and close.
ASSERTIONS
1. History has "P3 is now plain linework and has left the schedule; N pipes now have ends not connected yet. U restores it.". If no pipe end is freed, the line has no middle clause.
2. After the EXPLODE, 109D56 is gone and the schedule has no P3 row.
3. After U, 109D56 is back and the P3 row is back.
KIND deterministic
FAIL MEANS A pit silently drops out of the schedule when exploded, or cannot be brought back.
WHY A UNIT TEST CANNOT CATCH THIS The line comes from CE watching a real EXPLODE of its own block.

---

CASE D17
TITLE Editing with CDEDIT leaves your selection as it was
PLAN ITEM UX-STD-06 (gap plan item 17)
COMMAND CDEDIT gives back the objects you had selected after its editor closes.
INSTALLED Yes. Commit 855ea184 (27 Sep, "keep selection") is in the ref, with tests in `CdEditSelectionRestoreTests`. CDEDIT restores the selection after a single editor or a same-type batch editor. It does not restore after the mixed-object refusal.
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-B1, pipe P3 10A98D. A second pipe handle is needed: before step 3, read one other INSERT-free polyline on a STORMWATER pipe layer by READ ENTITY and record its handle (FIXTURE DATA, not a picture pick).
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. PICK-FIRST, then CDEDIT, then Edit Pipe is proven (R47 B.4.5). The selection has never been read afterwards. The Edit Pipe cancel control name is unproven, so this case uses "Save pipe and close" with no change.
STEPS
1. PICK-FIRST "10A98D", then TYPE "CDEDIT<LF>Y"; expect Edit Pipe. Press "Save pipe and close" without changing a value. If a Recalculate box appears, record it and answer No.
2. READ SELECTION. Read DBMOD.
3. PICK-FIRST "10A98D,<second pipe>", then TYPE "CDEDIT". Record the window title. Close it by a unique Cancel or Close control. If none is found, mark this step BLOCKED.
4. READ SELECTION.
ASSERTIONS
1. After step 1 the selection is exactly {10A98D}.
2. After step 3 the selection is exactly {10A98D, second pipe}.
3. No new CE window is left open.
KIND deterministic
FAIL MEANS After editing, the drafter's selection is lost or changed, so the next command acts on the wrong objects.
WHY A UNIT TEST CANNOT CATCH THIS Selection restore runs against AutoCAD's live implied selection after a real modal window.

---

CASE D18
TITLE CE never saves the drawing: the file stays unchanged until you save
PLAN ITEM UX-STD-03 (gap plan item 18)
COMMAND No Civil command saves the drawing file. Only the drafter saves.
INSTALLED Yes. Commit eab4b3ab (25 Sep, removed TryAutoSave and both SaveAs calls) and commit 803424a3 (CDREBUILD wording) are in the ref.
SWITCH None. The `autoSave.*` keys are still in Tim's file (`enabled` true), but eab4b3ab stopped reading them.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed. Do not change SAVETIME. AutoCAD's own SAVETIME autosave writes a .sv$ file in TEMP, not the drawing (Codex V10 item 4).
ROUTE PROVEN BY R47 A.5 and R46 A.6. After PIT, CD, the CDEDIT cascade, CDSYNC, PITSCHEDULE and CDRECOVERINVERTS, every copy's SHA-256 equalled its source at the end. CE wrote only separate `_PRE_C7_` backups on open.
STEPS
1. After launch and idle, read the copy's LastWriteTime T0 and SHA-256 S0. List the copy folder (F0).
2. Run SETUP-P8. Then TYPE "CDSYNC", then "CDREBUILD", then "CDRECOVERINVERTS". Then "PITSCHEDULE", closed by its proven route.
3. Before END, read the copy's LastWriteTime T1 and SHA-256 S1, and list the folder (F1).
ASSERTIONS
1. S1 = S0 and T1 = T0.
2. CDREBUILD history contains "it does not save the drawing itself" and "It does not save the drawing.".
3. F1 minus F0 holds only files named `<copy>_PRE_C7_<time>.dwg`, or nothing. Any other new file beside the drawing is a finding.
KIND deterministic
FAIL MEANS CE saved over the drafter's drawing without being asked.
WHY A UNIT TEST CANNOT CATCH THIS Only the real file on disk after a real AutoCAD session shows whether anything wrote to it.

---

CASE D19
TITLE Every CE step undoes under its own command name; with the switch on, CD says what [Undo] took back
PLAN ITEM UX-UNDO-01 (gap plan item 19)
COMMAND U names the CE command it undoes. With the switches on, CD's route [Undo] prints "Undid: point N of the pipe route.".
INSTALLED Partly. Commit 706ebd6b (the CD [Undo] "Undid: ..." sentence) and commit be370f23 are in the ref. Code: `Models/CdCommandLineSettings.cs` and `CdCommandLineSpecRules.cs:169-175`.
SWITCH OFF in Tim's file: `options.cdCommandLine.sayWhatWasUndone` false and `options.autoCadStyleCdPrompts` false. The [Undo] keyword is offered only when the second one is on. What Max gets today is AutoCAD's own U echo of the command name.
BUILD Civil 3.0.70
FIXTURE F-B1, two fresh copies (profile A, profile B)
SETTINGS NEEDED Profile A: none. Profile B: `options.autoCadStyleCdPrompts`=true and `options.cdCommandLine.sayWhatWasUndone`=true through the guard, each read back from the file.
ROUTE PARTLY PROVEN. The U echo words are proven in R47 ("CDEDIT", "CDCHECKIGNORE", "LINE") and R44 B.8 ("CDEDIT"). The switched-on sentence has never been run.
STEPS
1. **Profile A.** Run SETUP-P8, TYPE "U" and read the echo. Then PICK-FIRST "109D56", TYPE "_.MOVE<LF>0,0<LF>0,2000", TYPE "U" and read the echo.
2. **Profile B.** TYPE "CD<LF>150000,-85000<LF>160000,-85000<LF>165000,-87000<LF>U". The final U answers the [Undo] keyword at the fourth point. Read history, then esc-prompt once and read history.
ASSERTIONS
1. **Profile A:** each U echo names the command that made the change (CD or the CD continuation, then MOVE). Record any "GROUP" or "(Lisp Expression)" echo as an observation only. V10 saw those for LISP-typed commands.
2. **Profile B:** history has "Undid: point 3 of the pipe route." (record the exact words), then "[CE] CD command cancelled." after the Esc. Nothing is drawn.
KIND deterministic
FAIL MEANS The drafter cannot tell what one U will take back.
WHY A UNIT TEST CANNOT CATCH THIS AutoCAD's own undo echo and the live CD prompt keyword are only visible in a running session.

---

CASE D20
TITLE CDRENUMBER numbers pits from P1 at the outlet, up the main line first
PLAN ITEM UX-CPLAN-18/19 (gap plan item 20)
COMMAND CDRENUMBER renumbers plain P pits from P1 nearest the outlet, rising uphill along the longest line, then each branch. It always shows a preview and asks first.
INSTALLED Yes. Commit fe391be3 (27 Sep) is in the ref. Code: `Commands/PitRenumberCommand.cs` and `Rules/PitRenumberPlanner.cs` (the longest-line rule).
SWITCH None. The question "<n> pit(s) will be renumbered. Apply? [Yes/No]" defaults to No.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy. If it already reads downhill to uphill, the Yes half needs FIXTURE NEEDED: a copy with P numbers deliberately out of order.
SETTINGS NEEDED None changed.
ROUTE UNPROVEN.
STEPS
1. READ ENTITY every PIT_LABEL attribute and record the map M0. Read DBMOD.
2. TYPE "CDRENUMBER". Read history.
   - If "Which pit is the main outlet? Type its mark or pick it on screen [...] <default>:" waits, record the list and send an empty answer (the default).
   - If history says "Pit numbers already read downhill to uphill - nothing to renumber.", record it and mark assertions 2 and 3 NOT TESTED: FIXTURE.
3. At "<n> pit(s) will be renumbered. Apply? [Yes/No]", TYPE "No". Read history, then re-read the labels (M0b) and DBMOD.
4. Repeat step 2 with the same outlet answer, and answer "Yes". Read history and the labels (M1).
5. TYPE "U" once and re-read the labels (M2).
ASSERTIONS
1. The No path prints "Renumber cancelled - nothing changed.", M0b = M0 and DBMOD is unchanged.
2. The Yes path prints "Renumbered n pit(s) downhill to uphill. One Undo restores the old numbers.". M1 matches the preview lines "<old> -> <new>" exactly, and only plain P<n> pits change (C1, AGI, TG and WT tags are untouched).
3. M2 = M0 after one U.
KIND deterministic
FAIL MEANS Pits are renumbered in the wrong order, non-P pits are touched, or one U does not put the old numbers back.
WHY A UNIT TEST CANNOT CATCH THIS The network walk runs on the real drawing's pits and pipes and writes every label in one live command.

---

CASE D21
TITLE The Pit Schedule lists pits in natural number order (P2 before P10)
PLAN ITEM UX-SCHED-06 (gap plan item 21)
COMMAND PITSCHEDULE sorts P1, P2 ... P9, P10, never P1, P10, P2.
INSTALLED Yes for number order. `Helpers/PitIdComparer.cs` CompareLegacy already sorts by the number in the name ("already satisfies UX-SCHED-06", REGRESSION_LOG). The Batch 1 card 1.8 refinement (P1A straight after P1, SPS2 before SPS10) is in the ref behind a switch.
SWITCH `linking.pitScheduleNaturalOrder` is absent from Tim's file, so it is false. Basic number order is on; the P1A and SPS refinement is OFF.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy. It has no P10, so the case places P8 to P10 itself. The refinement needs FIXTURE NEEDED: pits named P1A, SPS2 and SPS10, with the switch on.
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN. Opening PITSCHEDULE, reading `ui tree "Pit Schedule" -Depth 6` and closing are proven (R44 B.9, R45 B.10, R46 B.7). A second and third New Pit window in one PIT run is unproven.
STEPS
1. TYPE "PIT<LF>150000,-80000"; expect New Pit. Set C2.CoverLevel=19.000 and press "Continue placement". esc-prompt at the label and at the cover prompt.
2. At "Pick the next pit", TYPE "152000,-80000"; require New Pit again and record its pit-name field. Press "Continue placement" and esc-prompt twice.
3. At "Pick the next pit", TYPE "154000,-80000" and repeat. Then esc-prompt at the next-pit prompt.
4. READ ENTITY the three new pits' names. If the window gives no name, read it from the Pit Schedule.
5. TYPE "PITSCHEDULE". Read the Rows tree, extract the PIT No. order, then close.
ASSERTIONS
1. The three new pits are P8, P9 and P10. Record the actual names.
2. The P rows run in ascending number order, ending ... P7, P8, P9, P10. P10 is never placed between P1 and P2.
3. Groups follow CompareLegacy: LPD, OG, P..., CP..., then the rest.
4. The P1A and SPS refinement is NOT TESTED (switch off, no fixture).
KIND deterministic
FAIL MEANS The schedule lists P10 straight after P1, so the issued table reads out of order.
WHY A UNIT TEST CANNOT CATCH THIS The order shown depends on the live window reading the real pits after placement.

---

CASE D22
TITLE A long Pit Schedule placed in the drawing continues on the next sheet with its headers
PLAN ITEM UX-SCHED-04 (gap plan item 22)
COMMAND The Pit Schedule placed in the drawing starts a new, repeated-header part below the first once a sheet's row limit is reached.
INSTALLED Yes. Commit fe391be3 (27 Sep) is in the ref: `Services/PitScheduleContinuationLayout.cs` (stacks "Below") and `UserSettings.cs:1569` `scheduleRowsPerSheet`.
SWITCH `pit.scheduleRowsPerSheet` = 20 in Tim's file. The case sets 5 through the guard, so DRV1_B1's 11 pits must continue.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy. F-SCHED is the optional alternative.
SETTINGS NEEDED `pit.scheduleRowsPerSheet`=5 through the guard before launch, read back from the file, restored at END.
ROUTE UNPROVEN. The robot gaps file lists "drawn Pit Schedule" as blocked. The "Continue to Place / update" button and its placement prompts have never been driven.
STEPS
1. TYPE "PITSCHEDULE". Read the Rows tree and count the pit rows R.
2. Press "Continue to Place / update". Record every prompt or window. Answer an insertion-point prompt with TYPE "200000,-50000". Any other unknown question: esc-prompt or Cancel, and BLOCKED.
3. Read the new drawn schedule entities in H1 minus H0. Record their type: TABLE, blocks or text.
4. Capture a zoom of the placed parts. TYPE "U" once and read the handle set.
ASSERTIONS
1. There are ceil(R/5) parts, each holding at most 5 data rows. Parts 2 onwards sit below part 1, with the same X and a lower Y.
2. Every part repeats the header row (PIT No., PIT SIZE, ... REMARKS).
3. The rows read in the window's order across the parts. No pit is lost or doubled at a break.
4. One U removes the whole placed schedule.
5. Look: the parts are readable and nothing overlaps.
KIND needs a window look (assertions 1 to 4 are deterministic)
FAIL MEANS The printed schedule on the sheet runs off the page, drops rows at a break, or loses its headers.
WHY A UNIT TEST CANNOT CATCH THIS The drawn table is built by live placement in the real drawing at the real row limit.

---

CASE D23
TITLE Excel export of the Pit Schedule has a checking sheet
PLAN ITEM UX-SCHED-02 (gap plan item 23)
COMMAND The Pit Schedule's "Export Excel" writes a workbook: the schedule as drawn, plus a "Checking" sheet that says where every value came from.
INSTALLED Yes. Commit 74b12f51 is in the ref, with the 27 Sep review fix. `ViewModels/PitScheduleViewModel.Schedule.cs:103-146` has ExportExcel and writes the "Checking" sheet, header "PIT No.", "FIELD", "VALUE", "SOURCE" (line 150).
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. "Export Excel" was seen enabled (robot run 14 B item 44) but never pressed. It opens a Windows Save dialog. Codex filled such a dialog in V8-01b; robot driver v2 may not use file dialogs.
STEPS
1. TYPE "PITSCHEDULE" and press "Export Excel".
2. In the Save dialog, set File name to `<run folder>\D23_export.xlsx` through the fixed dialog-path route. Press Save. Read any message.
3. Close the schedule. Read DBMOD.
4. Outside AutoCAD, read the xlsx as a zip: the sheet names in `xl/workbook.xml` and row 1 of the second sheet.
ASSERTIONS
1. The file exists and is larger than 0 bytes.
2. It has two sheets, and the second is named "Checking".
3. Checking row 1 reads "PIT No.", "FIELD", "VALUE", "SOURCE". The FIELD column uses plain office wording, never code names such as "InletInvert".
4. Every PIT No. in the window appears on sheet 1. DBMOD is unchanged.
KIND deterministic
FAIL MEANS The export is missing, has no checking sheet, or the checking sheet speaks in code names.
WHY A UNIT TEST CANNOT CATCH THIS The workbook is written from the live window's rows through a real file dialog.

---

CASE D24
TITLE New pits, pipes and texts go on the office layers; the current layer never changes
PLAN ITEM UX-LYR-01 (gap plan item 24; part-built, see corrections)
COMMAND PIT and CD put each new object on its office layer and leave the drafter's current layer alone.
INSTALLED Partly.
- **Behaviour from before:** `Services/LayerService.cs` sets the office layers, and CD and Edit Pipe restore the current layer (OsnapService).
- **Batch 5 card 5.1 pieces:** 00b09bd3 (layer names in Settings, empty = today's) and ba0bb8e0 (a missing layer is made in the office colour).
- **Not built:** "an existing layer is never recoloured". No such switch exists in the ref.
SWITCH `layerNames` is absent or empty in Tim's file, so today's names apply. `layerColours.overrides` is {}.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy (CLAYER BLOCKS at open, Codex V10 item 8)
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN. New entities' layers were read in robot runs 32 and 33. CLAYER was read in Codex V10's START readings.
STEPS
1. Read CLAYER (C0). Read the layer table's colour and linetype for STORMWATER PIT, STORMWATER PIT LABEL, ARROW, 25TEXT and the pipe layers (L0).
2. Run SETUP-P8, then D09 steps 1 to 4 at 156000,-80000, which gives a labelled pit.
3. Read CLAYER (C1). READ ENTITY the layer of every object in H1 minus H0. Read the layer table again (L1).
ASSERTIONS
1. C1 = C0. Read CLAYER after each Esc path as well.
2. Pits are on STORMWATER PIT and pit labels on STORMWATER PIT LABEL. The pipe polyline is on its pipe-type layer (record the name). IL texts and the label are on the pipe-text layer and the arrow on ARROW. Nothing is on layer 0 or on C0.
3. Record, without judging, any difference between L1 and L0. The "never recolour an existing layer" half is not built.
KIND deterministic
FAIL MEANS CE work lands on the wrong layer, or CE changes the layer the drafter was drawing on.
WHY A UNIT TEST CANNOT CATCH THIS Layer choice and current-layer restore happen in the live drawing's layer table.

---

CASE D25
TITLE Existing work greyed on EX layers, demolished dashed on a DEMO layer (NOT BUILT)
PLAN ITEM UX-LYR-04 (gap plan item 25)
COMMAND None today. The ruling asks for existing pits and pipes greyed on EX layers, and demolished ones dashed on a DEMO layer with "TO BE REMOVED".
INSTALLED NO, as specified.
- **Existing pipes:** the "Existing Pipe" type draws on EX DRAIN HATCH (colour 61, green, PHANTOM) with the outline on EX STORMWATER (colour 9, HIDDEN). This is from before (`LayerService.cs:106-115`).
- **Pit status:** New, Existing or ToBeRemoved is a data field only (41a1b21a). No window or command sets it.
- **Demolished:** "TO BE REMOVED", a DEMO layer and "STORMWATER DEMOLISH" appear nowhere in `Modules/Drainage`.
- **Checks:** `checks.leaveOutRemovedPits` is OFF.
SWITCH Not applicable.
BUILD Civil 3.0.70
FIXTURE NEEDED A drawing with pits marked Existing and To be removed. It cannot be made through the window today.
SETTINGS NEEDED None.
ROUTE UNPROVEN. The New Pipe "Existing Pipe" type selector has never been driven.
STEPS
1. This is the installed part only. TYPE "CD<LF>150000,-90000<LF>160000,-90000<LF>". In New Pipe choose the pipe type "Existing Pipe" by its unique text control; if it is not found, mark BLOCKED. Set inverts 18.000 and 17.950, press "Start Pipe", then esc-prompt.
2. READ ENTITY the new polyline, the outline and the label: layer, colour and linetype as resolved through the layer.
ASSERTIONS
1. The polyline is on EX DRAIN HATCH and the outline on EX STORMWATER. The label begins "EXISTING ".
2. Record the layer colours (61 and 9). Grey is not met by design today. Report the item as NOT INSTALLED, never as PASS.
KIND deterministic (installed part only); item verdict NOT INSTALLED
FAIL MEANS For the installed part: an existing pipe is drawn as new work. For the item: Max cannot show demolished or existing pits at all.
WHY A UNIT TEST CANNOT CATCH THIS Layer and linetype come from the live layer table as CD writes the pipe.

---

CASE D26
TITLE CDSL shows the survey level as existing and asks for the proposed level
PLAN ITEM UX-SURV-03 (gap plan item 26)
COMMAND CDSL places a spot level. Where a survey is linked it first shows the existing survey level at that point, then asks you to type the proposed level, with no default.
INSTALLED Yes. Commit 5c67c393 (29 Sep) is in the ref. `Commands/SpotLevelCommand.cs:91-102` writes "  Existing level from the survey here: <x.xxx> m (<source>)". The prompt is "Enter proposed spot level (m): " (line 171).
SWITCH `survey.workflowMode` 0 (Design) in Tim's file. The existing-level line appears only in Design mode and only when the drawing holds a CDSURVEY payload.
BUILD Civil 3.0.70
FIXTURE NEEDED for assertion 1: a copy of a drawing with a stored CDSURVEY survey and one known point with a known survey level within 3 m. DRV1_B1 has SPOT LEVEL blocks (for example 10EE19, value P19.200), but nothing shows it holds a survey payload. Step 2 records which. F-B1 serves the other assertions.
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN. CDSL's start is proven on a locked layer only (robot run 30 B.7). The point and level answers have never been run.
STEPS
1. Confirm layer 25DIMS is unlocked by reading the layer table. Read handle set H0.
2. TYPE "CDSL<LF>150000,-80000". Read history: the existing-level line, "No survey level near this point.", or no line.
3. At "Enter proposed spot level (m): ", TYPE "18.600". READ ENTITY the new SPOT LEVEL block's LEVEL attribute and layer.
4. TYPE "CDSL<LF>150500,-80000<LF>", where the empty answer gives a blank level.
5. TYPE "CDSL<LF>151000,-80000<LF>18600". Read the refusal, then esc-prompt.
ASSERTIONS
1. With the survey fixture, history has "  Existing level from the survey here: <x.xxx> m" before the prompt, and the prompt carries no <default>. On F-B1, record whether the line appears.
2. Step 3 prints "Spot level placed. Level: <value>" with value = 18.600 in the attribute's text form (record the exact form). The block is on 25DIMS.
3. Step 4 prints "Spot level placed. Level: (blank)".
4. Step 5 prints "[CE] "18600" is not a level in metres (for example 18.600). Type it again, or press Enter for a blank level.", and after the Esc "CDSL command cancelled. Nothing was placed.". No new block is added.
KIND deterministic
FAIL MEANS The survey level is offered as the level to place, or a mistyped level is placed silently.
WHY A UNIT TEST CANNOT CATCH THIS The survey lookup reads the payload stored in the real drawing at the picked point.

---

CASE D27
TITLE CDSYNC and CDREBUILD each warn in one line before they change anything
PLAN ITEM UX-REP-01 (gap plan item 27)
COMMAND CDSYNC and CDREBUILD print one plain line naming what they will change and that one U undoes it, before they write.
INSTALLED Yes. Commits 37fa0f5e (25 Sep) and 803424a3 are in the ref. The lines are at `Commands/LinkCommands.cs:125` and `:213`.
SWITCH None. Both commands are typed-only, hidden from the ribbon.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy
SETTINGS NEEDED None changed.
ROUTE PARTLY PROVEN. The CDSYNC line was seen in R44 B.9, R45 B.10 and R46 B.7 ("Pits relinked: 12, Pipes relinked: 50" after the setup). CDREBUILD has never been run by the robot or Codex.
STEPS
1. Capture the history offset and log offsets. TYPE "CDSYNC" and read history.
2. Capture new offsets. TYPE "CDREBUILD" and read history.
3. TYPE "U" once and read the echo.
ASSERTIONS
1. CDSYNC's first CE line is "[CE] CDSYNC will re-link every pit and pipe in this drawing to CE's records, from what is currently drawn. One U undoes it.". It comes before "CDSYNC complete. Pits relinked: <n>, Pipes relinked: <m>". On an untouched F-B1 copy, expect n = 11 and m = 49 (record).
2. CDREBUILD's first CE line begins "[CE] CDREBUILD will rebuild this drawing's stored pit and pipe data" and contains "it does not save the drawing itself". Its last CE line is "[CE] CE's stored pit and pipe data is up to date in this drawing. It does not save the drawing. Run PITSCHEDULE to verify output.".
3. The U echo is "CDREBUILD". LOG NEW holds one "Command outcome: CDSYNC completed" and one "Command outcome: CDREBUILD completed".
KIND deterministic
FAIL MEANS A drawing-wide rewrite starts with no warning, or claims to save the drawing.
WHY A UNIT TEST CANNOT CATCH THIS The order of the warning against the real write is only visible on the live command line.

---

CASE D28
TITLE CDCHECKDWG ends with one summary line and opens the results list
PLAN ITEM UX-IMP-02 (gap plan item 28)
COMMAND CDCHECKDWG checks a drawing, prints one summary line instead of a long dump, opens a read-only results window, and writes a report file.
INSTALLED Yes. Commit 0948bb62 (27 Sep) is in the ref. `Commands/CheckDwgCommand.cs:44-115`, `ConsultantDwgCheckService.BuildOneLineSummary` (line 296) and the window titled "Creative Engineering | Check consultant drawing results".
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-B1, fresh copy. Enter checks the current drawing by reading the copy on disk. F-DWGCHK is the optional alternative.
SETTINGS NEEDED None changed.
ROUTE UNPROVEN. The robot gaps file lists CDCHECKDWG as blocked, because its window is not allow-listed in driver v2.
STEPS
1. Capture offsets and list the copy folder (F0). Read the copy's SHA-256 (S0).
2. TYPE "CDCHECKDWG<LF>". The empty answer to "Enter DWG path to check (Enter = current drawing): " means the current drawing.
3. Read history. Read the results window's controls as text, capture it, then press "Close".
4. List the folder (F1) and read the copy's SHA-256 (S1).
ASSERTIONS
1. History has these lines, in order:
   - "[CE] CDCHECKDWG: checking current drawing (<name>). Note: unsaved changes are not reflected - this reads the on-disk file."
   - "[CE] CDCHECKDWG reading: <path>"
   - exactly one summary line matching "[0-9]+\.[0-9]% layer recognition, [0-9]+ unrecognized layers?, ([0-9]+ QA findings?|no CE project data)"
   - "[CE] CDCHECKDWG wrote report: <path>"
2. No more than 5 new CE lines in total (no 80-line dump).
3. The window title is as above, and its row count text equals the report's finding count. Close works.
4. F1 minus F0 is exactly one `<copy>_CDCHECKDWG_<stamp>.txt`, and S1 = S0.
KIND needs a window look (assertions 1, 2 and 4 are deterministic)
FAIL MEANS The drafter gets a wall of command-line text, no list, or a check that changed the drawing.
WHY A UNIT TEST CANNOT CATCH THIS The command reads a real DWG off disk and opens a live window.

---

CASE D29
TITLE CDFEEDBACK prints one honest line: sent, or saved on this PC
PLAN ITEM UX-WORD-03 (gap plan item 29)
COMMAND CDFEEDBACK opens the Feedback window. After "Send report", one line says truthfully whether the report reached the office feedback folder or stayed on this PC.
INSTALLED Yes. Commits 8393abcc, abb30c48 and 2f020d38 (25 to 26 Sep) are in the ref. `Commands/FeedbackCommand.cs:25-28` holds ResultLine. The window is "Creative Engineering | Feedback", with Problem or Idea, "Send report" and "Cancel". It never creates the office folder (2f020d38).
SWITCH None.
BUILD Civil 3.0.70
FIXTURE F-BLANK. ENVIRONMENT NEEDED for the send half: a standard Windows login without the office OneDrive IT Admin folder (the spare login in the gap plan, section 3 item 1). On Tim's PC that folder exists, so "Send report" would put a file into the shared office feedback folder. The send half needs Tim's yes even on the spare login.
SETTINGS NEEDED None changed.
ROUTE UNPROVEN.
STEPS
1. **Part A, Tim's PC, safe.** List `%APPDATA%\CE_CVL_SUITE\feedback` (F0). TYPE "CDFEEDBACK". Read the window controls as text and capture it. Press "Cancel". Read history and list the folder again (F1).
2. **Part B, spare login only, after Tim's yes.** TYPE "CDFEEDBACK". Choose "Problem" and type "PACK TEST - please ignore" in the text box. Press "Send report". Read history and list `%APPDATA%\CE_CVL_SUITE\feedback`.
ASSERTIONS
1. **Part A:** history is exactly "CDFEEDBACK cancelled." and F1 = F0.
2. **Part B:** exactly one result line, "[CE] Saved on this PC only: the office folder wasn't reachable. Email this file to <Tim's address> so Tim gets it: <path>". The <path> exists as a new feedback_<stamp>.json. No office IT Admin folder was created. On a PC that has the folder, the line is "[CE] Report sent to the office feedback folder. Thank you!".
3. Look (Part A capture): the window text is readable, and "Send report" and "Cancel" are visible.
KIND needs a window look
FAIL MEANS A colleague's bug report is lost or claims to have been sent when it was not. This is Max's only bug route.
WHY A UNIT TEST CANNOT CATCH THIS The result depends on the real folders on the real login and the live window.

---

CASE D30
TITLE Selecting a pipe or pit brings its own ribbon tab to the front
PLAN ITEM UX-RIBBON-01 (gap plan item 30)
COMMAND Selecting a CE pipe, pit or source jumps the ribbon to its contextual tab (Pipe, Pit or Source). Esc returns to the CE tab.
INSTALLED Yes. Commit 02937109 (25 Sep) is in the ref. `Services/CeCvlRibbonContributor.cs:182-230` defines CE_CVL_CTX_PIPE "Pipe" (Edit Pipe, Adjust Positions, Reverse Flow, Focus, Close), CE_CVL_CTX_PIT "Pit" (Edit Pit, Flip Cover Text, Focus) and CE_CVL_CTX_SOURCE "Source". `StandaloneCivilRibbonService.cs:163` applies the switch.
SWITCH Tim's file has `options.jumpToContextualTabOnSelect` true and `options.showClassicCeTabs` false. The classic tabs would switch contextual tabs off.
BUILD Civil 3.0.70
FIXTURE F-B1, pipe P3 10A98D and pit P3 109D56
SETTINGS NEEDED None changed.
ROUTE UNPROVEN.
- **Reading the tab:** no route reads the active ribbon tab.
- **PICK-FIRST:** it is a LISP selection and may not raise the same event as a mouse click. Codex V10 run B's mouse pick did refresh the Inspector.
- **Prerequisite:** C02 pointer calibration for step 5.
STEPS
1. Read the active ribbon tab name as text from the AutoCAD frame (selector to be proved). Call it T0.
2. PICK-FIRST "10A98D". Wait 2 s, read the active tab and capture the ribbon.
3. esc-prompt once to clear the selection, then read the active tab.
4. PICK-FIRST "109D56" and read the active tab. esc-prompt.
5. Comparison, only after C02 passes: one calibrated mouse click on 10A98D's mid-point world coordinate, then read the active tab.
ASSERTIONS
1. After the pipe is selected, the active tab is "Pipe", showing Edit Pipe, Adjust Positions, Reverse Flow, Focus and Close.
2. After the pit is selected, the active tab is "Pit".
3. After Esc, the CE tab is active again.
4. DBMOD is unchanged throughout (selection only).
KIND needs a window look
FAIL MEANS The drafter has to hunt for the edit buttons after selecting an object.
WHY A UNIT TEST CANNOT CATCH THIS The contextual tab is raised by AutoCAD's live selection event in the real ribbon.

---

## What this file does NOT cover (RULES 5.9)

1. **Nothing has been run.** Not one of these 30 cases has been run on 3.0.70. Every assertion awaits a pack run.
2. **Words read from source are not proven.** Exact command-line wording that I took from the installed source and have not seen in a robot or Codex report is marked by its code line, not proven.
3. **Not covered by the 30:** the gap plan's "also run every pack" cases (C03, C12, C31 to C40) are in `TEST_CASES_DRAFT_22OCT.md`, so they are not repeated here.
4. **Manager:** only CE_VERSION (C12) and CDFEEDBACK touch Manager or Shared ground. No Manager window case is in the 30.
5. **Older AutoCAD years:** the 2022 to 2024 lane is not considered here. Max's AutoCAD year is still unrecorded (gap plan question 7).

## Summary (under 120 words)

The 30 daily tools come from the 9 Nov gap plan list, checked against the installed line `rel-20261022m` (40ee0a36). 28 are fully installed, UX-LYR-01 is part-built and UX-LYR-04 is not built. Three are off with Tim's switches (UX-LBL-01, UX-UNDO-01 and UX-LYR-04), so 27 are on. 27 cases can run now on existing test copies. Three need a fixture or environment: a survey drawing, a drawing with existing and demolished pits, and the spare login for CDFEEDBACK's send. Routes: 4 fully proven, 7 partly, 19 unproven. Riskiest: UX-LYR-04, CDFEEDBACK, CDRENUMBER, the drawn Pit Schedule continuation and pipe-to-pit joins. The gap plan's "75 mm auto-join" is the switched-off pipe-end join; pits use outline plus 100 mm.
