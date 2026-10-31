# Wave 1 case writing, job T1: group T (BUG-216, BUG-740, BUG-741, BUG-742), Sat 31 Oct 2026

Writer: Opus case writer, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Installed build read: Civil 3.0.88+3fbb9da5. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, driver or settings file was edited. Nothing committed or pushed.

## ANSWER FIRST

1. **All 4 bugs have a case and a must-fail twin:** 8 new files, all pass the offline check (57 files checked, 0 invalid; every control id known). Nobody has run them.
2. **Two bugs are only half covered.** BUG-740: the CDSOURCE and COPY routes are covered; the CDTAG Set and "Number sources" setting routes are not. BUG-741: the WT1 half is covered; the "ROOF DRAIN 1" half is not.
3. **Why the halves are missing:** no typed route can make two blocks both called "ROOF DRAIN 1", and CDTAG cannot pick an already-tagged block with a typed point. These go to a Codex look (section 6).
4. **BUG-216, CDFALLSUGGEST Enter:** W216 picks an empty spot, skips the level, then presses Enter at "Next level (0 placed, 1 skipped), or Enter to finish:". The command must end on that Enter with "CDFALLSUGGEST finished. 0 placed, 1 skipped." and no "Invalid point".
5. **BUG-742, CDTAG used name:** W742 tags pit P10 as WT2, which is already taken. It must refuse with "[CE] CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed." and add nothing.
6. **BUG-741, CDFIXTAGS numbering:** W741 tags pits P10 and P9 as WT1 (switch off), so three blocks share WT1. CDFIXTAGS must propose WT13 and WT14 (the drawing already holds WT1 to WT12), never "WT1 1", and No renames nothing.
7. **BUG-740, Roof drain copy:** W740 places a Roof drain (ROOF DRAIN 1), copies it 3 m east, then places another Roof drain. The copy's label must read "ROOF DRAIN" (never "ROOF" or "ROOF1"), and the second Roof drain must come out ROOF DRAIN 3.
8. **Each twin breaks one thing:** W216 leaves out the last Enter, W742 turns the used-name switch off, W741 leaves it on, and W740 leaves out the copy.
9. **Least certain step:** W740 is the first robot case ever to drive CDSOURCE. If CDSOURCE refuses (SOURCE block missing) or the keyword route differs, W740 fails on its first check, not on a stall.
10. **One thing the desk should know:** the run 34 and 35 notes quote old CDTAG wording ("Show tag label on screen?", "CDTAG applied: tag=..."). The 3.0.88 code says "Show the tag label on the drawing?" and "[CE] Tagged WT1. ...". My cases assert the 3.0.88 words only.
11. **Not tested by anyone:** every number and line below comes from the code or from earlier runs on 3.0.55 to 3.0.59. None of it has been seen on 3.0.88.
12. **Next step:** CE 02 runs the 8 files (about 4 minutes each, no pointer steps, no windows). Then an Opus paper review.

---

## DETAIL

### 1. Files written

All files are in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\`:

1. `W216_cdfallsuggest_enter_finishes.case.txt` and `W216_BROKEN.case.txt` (ORDER 2160, 2161)
2. `W740_copy_roof_drain_keeps_whole_name.case.txt` and `W740_BROKEN.case.txt` (ORDER 7400, 7401)
3. `W741_cdfixtags_next_free_number.case.txt` and `W741_BROKEN.case.txt` (ORDER 7410, 7411)
4. `W742_cdtag_untagged_used_name_refused.case.txt` and `W742_BROKEN.case.txt` (ORDER 7420, 7421)

Checks run (all offline):

1. `case_runner.ps1 validate ...drafts_wave1_31oct` gave "57 file(s) checked, 0 invalid". The other 49 files are from other writers.
2. `check_ids.ps1 -Folders drafts_wave1_31oct` gave "RESULT: every control id is known". My cases use no control ids.
3. Grep of my 8 files for "print" (any case), for 17.8 / 17.9 and for street words found nothing.

All cases share these conditions:

1. **Drawing and slot:** fixture DRV1_B1, slot fresh.
2. **No pointer steps and no windows:** every case can run with the screen locked.
3. **Clean ending:** every typed chain is followed by `esc-prompt`, which says "nothing to cancel" when idle, then `wait`.

### 2. BUG-216: W216 and W216_BROKEN

1. **What it does in AutoCAD:**
   1. Type CDFALLSUGGEST.
   2. Pick 150000,-98000. This is empty ground, the same spot R36 uses for a floor waste.
   3. Press Enter at "No spot level here - enter a level (m), or Enter to skip:". CE says "No level at this point" and counts the point as skipped.
   4. Press Enter at "Next level (0 placed, 1 skipped), or Enter to finish:".
   5. At the end, the command must have finished on that Enter, inside the typed result: "CDFALLSUGGEST finished. 0 placed, 1 skipped.". There must be no "Invalid point" and no new object, and the file must be unchanged.
2. **Code at 3fbb9da5 that the checked words come from:**
   1. `Commands/FallSuggestCommand.cs` 62-75: the loop; Enter or Esc ends it, and line 75 writes the count line.
   2. `Commands/FallSuggestCommand.cs` 89-93: AllowNone = true, which is the fix.
   3. `Commands/FallSuggestCommand.cs` 186: the level question.
   4. `Rules/FallSuggestPromptRules.cs` 6-9: the prompt text.
   5. `Rules/FallArrowGeometry.cs` 93: "No level at this point — type or pick a level first. ..." Only the part before the dash is asserted.
3. **Fixture fact:** DRV1_B1 has a grated pit. CDCHECK on DRV1_B1 names "the nearest grated pit P4" (EXPECTED line of `cases\variants\R22_off_broken.case.txt`). Without one, CE would stop at line 54, "no grated pit was found", and the case would fail on its count check.
4. **Derived, never seen on a run:** the exact count line with 0 placed and 1 skipped.
5. **Arithmetic:** no levels or lengths are involved. The count is 0 placed and 1 skipped.
6. **Enter count:** the typed string `CDFALLSUGGEST{NL}150000,-98000{NL}{NL}` gives three Enters, and the runner adds a fourth.
   1. Enter 1 runs the command.
   2. Enter 2 answers the point.
   3. Enter 3 skips the level.
   4. Enter 4 answers "Next level".
7. **What the twin breaks:** it leaves out the last `{NL}`. Nobody presses Enter at "Next level", so the esc-prompt ends the command, which is the old way out. The count line then arrives only after the Esc, so the twin fails on `contains $fs "CDFALLSUGGEST finished. 0 placed, 1 skipped."`. It cannot stall: a typed chain that stops at a waiting prompt counts as a good step.
8. **Not covered:** Enter after an accepted arrow (1 placed). It is the same prompt code, but it needs a point with a known level uphill of a grated pit with a known cover level, and those fixture levels were not read. Codex accepted that route on 3.0.49 (14 Oct).

### 3. BUG-742: W742 and W742_BROKEN

1. **What it does in AutoCAD:**
   1. Zoom to P9 and P10 (centre 59232,-69535, height 15000).
   2. Run CDTAG, pick pit P10 by the typed point 54436.3,-69493.6, type WT2, and press Enter at the show-label question.
   3. At the end, the command line must say "[CE] CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed.". There must be no "Tagged WT2" and no "Nothing Selected", the object count must be the same and the file unchanged.
2. **Code at 3fbb9da5:**
   1. `Commands/SourceTagCommand.cs` 148-157 (the pick), 288-298 (the tag prompt), 322-333 (the show-label question, asked BEFORE the name check, hence the extra Enter) and 351-359 (the BUG-742 check).
   2. `Rules/SourceTagNameFreeRule.cs` 15-27: the words.
   3. `Models/UserSettings.cs` 976-977: switch `linking.cdTagRefusesUsedNumberedName`, default true, pinned ON by a SETTING line.
   4. `Services/SourceTagMessages.cs` 12-16: the "Tagged" line, which must be absent.
3. **Fixture facts:**
   1. The typed point picks P10: runs 31, 32, 34 and 35 used it.
   2. WT2 is already taken: WT1 to WT12 exist (run 31 B item 3.1).
   3. Run 32 B item 12 saw this exact refusal on 3.0.56.
4. **Derived:** the refusal on 3.0.88 is derived from unchanged code. It has not been seen on 3.0.88.
5. **What the twin breaks:** the SETTING line sets the switch OFF, which is the route from before the fix. CDTAG then writes WT2 on P10, as runs 31, 34 and 35 did with DP3. The twin fails on the refusal check and on the object count (a WT2 label is added).
6. **Not covered:** the retag route of an already tagged source and the Edit Source window. Both are BUG-814, not this bug.

### 4. BUG-741: W741 and W741_BROKEN

1. **What it does in AutoCAD:**
   1. The switch is OFF (SETTING line), and the view is zoomed as in W742.
   2. CDTAG P10 as WT1, then CDTAG P9 (64028,-69576.4) as WT1. Each must say "Tagged WT1.".
   3. Run CDFIXTAGS and answer No.
   4. At the end CDFIXTAGS must show:
      1. "The source tag 'WT1' is on more than one block (3 blocks).";
      2. one proposal ending "-> WT13" and one ending "-> WT14";
      3. no "WT1 1" or "WT1 2" anywhere;
      4. "[CE] Nothing was renamed.";
      5. an unchanged file.
2. **Code at 3fbb9da5:**
   1. `Rules/DuplicateSourceTagPolicy.cs` 36-42: the "more than one block" line.
   2. `Rules/DuplicateSourceTagPolicy.cs` 50-61: the proposal line.
   3. `Rules/DuplicateSourceTagPolicy.cs` 83-103: the first block keeps its name, and each name proposed is then taken.
   4. `Rules/DuplicateSourceTagPolicy.cs` 111-130: a run-on family takes the highest number in use plus 1 (the fix).
   5. `Commands/SourceTagRepairCommand.cs` 49-77: the lines and the Yes/No question.
3. **Arithmetic (derived, never seen):**
   1. The highest WT number in the drawing is 12.
   2. WT1 sits on 3 blocks: the first keeps WT1, the second becomes WT13 and the third WT14.
   3. Before the fix the proposals were "WT1 1" and "WT1 2".
   4. AGI x4 also appears ("AGI 1", "AGI 2", "AGI 3") but is not asserted.
4. **Not asserted:** which WT1 block keeps its name, and the X, Y of each proposal. Both depend on the order of objects in the drawing.
5. **Why No:** a Yes rename on pit blocks is refused by design ("another kind of object"). That is BUG-813, not this bug.
6. **What the twin breaks:** the switch stays ON. Both CDTAG WT1 steps are refused, so no WT1 pair exists. The twin fails on `history count "Tagged WT1." = 2` and on the WT1, WT13 and WT14 checks. It does not stall: CDFIXTAGS still asks its question because of the AGI four.
7. **Not covered: "ROOF DRAIN 1" becoming "ROOF DRAIN 1 1"** (lines 132-142). No typed route makes two blocks both called ROOF DRAIN 1:
   1. CDTAG takes no spaces (`SourceTagCommand.cs` 290).
   2. CDSOURCE numbers each one.
   3. COPY renumbers too (W740).
   4. Custom CDSOURCE "ROOF DRAIN 1" would become "ROOF DRAIN 1 1" by its own numbering.

   This half needs a prepared drawing (two source blocks with that stored tag, made by an unpatched build or a reviewed tool), so it waits for wave 2.

### 5. BUG-740: W740 and W740_BROKEN

1. **What it does in AutoCAD:**
   1. Run CDSOURCE, choose RoofDrain and pick 150000,-98000. Expect "Source block placed. ID: ROOF DRAIN 1.", one SOURCE block, and a label "ROOF DRAIN 1". Esc ends the carry-on.
   2. Select that block by handle and COPY it 3000,0. This is accepted case N12's COPY route.
   3. Check that the copy adds one SOURCE block and one label reading "ROOF DRAIN" or "ROOF DRAIN 2", never "ROOF" or "ROOF1". Check there is no "could not be given its own link" line.
   4. Run CDSOURCE RoofDrain again at 156000,-98000. Expect "Source block placed. ID: ROOF DRAIN 3." and never "ROOF DRAIN 2.".
2. **Code at 3fbb9da5:**
   1. `Commands/SourceBlockGenericCommand.cs` 63-94 and 116-119.
   2. `Services/PlacementContinuationService.cs` 69-72: the "Stopped" line.
   3. `Services/LinkService.SourceLanding.cs` 648-657: CDSOURCE writes the exact tag as the label.
   4. `Services/LinkService.SpineClones.cs` 157-180: the copy's tag and label.
   5. `Services/SourceTagService.cs` 196-239: AllocateNextTag.
   6. `Rules/SourceFamilies.cs` 211-221 and 228-233: the fix.
   7. `Rules/SourceNumbering.cs` 34-51: label text by numbering mode.
   8. `Services/SourcePlacementService.cs` 357-378 and `Rules/GenericSourceTypes.cs` 66-83: the next Roof drain number.
   9. `Rules/CloneSourceCopyRule.cs` 28-34: the "left as copied" line, which must be absent.
3. **Arithmetic (derived, never seen):**
   1. The drawing has no multi-word source name, so the first is ROOF DRAIN 1.
   2. The copy becomes ROOF DRAIN 2 (live numbers {1}, no stored high-water yet).
   3. The next CDSOURCE sees 1 and 2, so it gives 3.
   4. Before the fix the copy was "ROOF1", so the next CDSOURCE gave "ROOF DRAIN 2" again.
4. **Label of the copy:** "ROOF DRAIN" under the default "Only when scheduled" mode, or "ROOF DRAIN 2" under "Always". The project's mode was not read, so both are accepted.
5. **Unconfirmed, never driven:**
   1. The CDSOURCE typed chain itself. No robot case has run CDSOURCE; R36 only recorded its first prompts.
   2. The block's name "SOURCE".
   3. That the COPY handler gives a lone source block its own number on AutoCAD 2027. BUG-1137's "left as copied" line is for AutoCAD 2022 to 2024.
6. **What the twin breaks:** it leaves out the copy step (the pick-first and the COPY lines). No copy appears, and the second CDSOURCE takes ROOF DRAIN 2. The twin fails on the copy counts and on the ROOF DRAIN 3 checks.
7. **Not covered:**
   1. CDTAG Set on a Roof drain: a tagged block cannot be picked by a typed point (run 31 C.4), and pick-first CDTAG was ignored in run 32.
   2. The "Number sources" project setting: it is changed in a window.
   3. Hot water unit and AC unit: the same code, not driven.

### 6. What a Codex look must see (the halves the robot cannot reach)

1. **BUG-740, CDTAG Set:** in a test copy, place a Roof drain with CDSOURCE, click it, and run CDTAG Set. Keep the name or type a new one. The label must stay "ROOF DRAIN ..." and never become "ROOF".
2. **BUG-740, numbering setting:** change the project's "Number sources" setting between Never, Only when scheduled and Always. The Roof drain label must read "ROOF DRAIN" or "ROOF DRAIN 1", and never "ROOF".
3. **BUG-741, ROOF DRAIN half:** this needs a drawing holding two blocks both stored as "ROOF DRAIN 1". CDFIXTAGS must then propose "ROOF DRAIN 2" (or the next free number), never "ROOF DRAIN 1 1". This needs a fixture, so it waits for wave 2.

### 7. Could not write, and faults noticed (names only, nothing edited)

1. **Not written:** the two halves in section 6, for the reasons given there.
2. **Brief lesson 4 versus the runner code:** brief lesson 4 says "'field' on an empty selection fails the step". `case_runner_lib.ps1` line 349 returns an empty value with the step OK. My twins rely on neither.
3. **Stale wording in the carpark:** the BUG-742 and BUG-814 entries quote CDTAG lines from 3.0.56 to 3.0.59 ("Show tag label on screen?", "CDTAG applied: tag=DP3. Pipes linked to this block: 0."). The installed code now says "Show the tag label on the drawing?" (`SourceTagCommand.cs` 322) and "[CE] Tagged DP3. No pipes are connected to it yet." (`SourceTagMessages.cs` 12-16, BUG-927). Anyone writing a check from the carpark text would assert the wrong words.
4. **R36 header:** it says "the CDSOURCE prompt chain is not known". The chain is now read from the code (section 5) but is still unproven live.
