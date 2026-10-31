# Wave 1 case writing, job T2: BUG-743, BUG-744, BUG-746, BUG-713 (Sat 31 Oct 2026, about 15:20 PC clock)

Writer: Opus Wave 1 case writer T2, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, spec, driver or settings file was edited. Nothing committed or pushed. No agents spawned.

## ANSWER FIRST

1. **Count:** 2 of my 4 bugs have a case and a twin: BUG-743 (W743) and BUG-713 (W713). 2 have no case: BUG-744 and BUG-746.
2. **BUG-743 is only part-proved:** the case shows "Blank" means no cover level even right after a typed 45.2, and Enter with nothing typed means no level. The real fault (job B picking up job A's level) needs a second drawing in one AutoCAD, which the robot cannot open. That half is a Codex look.
3. **BUG-713, fully on the fall arrow route:** a blank spot level 20 mm from the pick no longer hides a P19.020 spot 40 mm away. CDFALLSUGGEST must suggest a fall toward the new pit at 1:100 and never ask "No spot level here".
4. **BUG-744, no case:** it needs CDFIXTAGS to actually rename an ordinary source block. On the test drawing every rename is refused (BUG-813: the doubled blocks are pit blocks). A copied downpipe gets a fresh number, so no typed route makes two ordinary blocks share a name.
5. **BUG-746, no case:** the fault is a hidden record left in the file after a tag is removed. The robot cannot read hidden records (no typed LISP is allowed, and ent-read reads drawing objects only). Removing a tag on a pit block would also hit the same refusal.
6. **Twins:** W743_BROKEN answers Enter instead of Blank on grate C, so it must carry PCL 45.200 and fail. W713_BROKEN puts the good spot 60 mm away (outside the 50 mm reach), so CE must ask "No spot level here" and fail.
7. **Checks done:** validate 61 files, 0 invalid. check_ids: every control id is known. No "print", no 17.9 or 17.8, no street name in my four files.
8. **Biggest risks:** CDTG and CDFALLSUGGEST have never been driven by the robot. The callout position (650 mm above each grate) and the blank spot's empty LEVEL value are worked out from the code, not seen.
9. **Run order:** each main case before its twin in one drawing (ORDER 900/901 and 902/903). If W743_BROKEN shares W743's drawing, its grate A also shows 45.200. That is still a failed check, but it muddies the reason.
10. **Teammate overlap:** job T1 wrote W740, W741 and W742 (CDFIXTAGS, CDTAG) in the same folder. Their W741 also says a rename after Yes is BUG-813 and cannot be proved. That matches my BUG-744 finding.
11. **Codex looks needed:** BUG-743 other-drawing Enter, BUG-744 rename keeps labels, BUG-746 record erased. Recipes are in sections 2, 3 and 4.
12. **Not claimed:** nothing here is tested. Every expected word and number comes from the code at 3fbb9da5 (installed Civil 3.0.88).

---

## 1. Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W743_cdtg_blank_cover_level_is_unknown.case.txt`
2. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W743_BROKEN.case.txt`
3. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W713_fallsuggest_skips_blank_spot_level.case.txt`
4. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W713_BROKEN.case.txt`
5. This report.
6. **Source pinned:** `git show 3fbb9da5:Modules/Drainage/...` in `C:\Lisp Files\CE_ACAD_PLUGIN` (read only).

## 2. BUG-743: CDTG cover level, Enter to skip (W743, twin W743_BROKEN)

1. **What the case does (drafter's words):** it draws four 2 m trench grates with CDTG along y -68000: A from 162000, B from 164500, C from 167000, D from 169500. Each is 300 wide, Standard, class C, outlet skipped. At the cover level prompt it answers A with Enter, B with 45.2, C with Blank and D with Enter.
2. **What must be true at the end:**
   1. Callouts A and C have no PCL line.
   2. Callouts B and D end "PCL 45.200 m AHD".
   3. Four TRENCH GRATE blocks are on layer TRENCH GRATE.
   4. The prompt reads "Cover Level (m AHD) or [Blank] <enter to skip>".
   5. Nothing is cancelled, there is no "Requires numeric value", no CE window is left open and the file is unchanged.
3. **Where the words come from (Commands/SourceBlockInsertCommands.cs at 3fbb9da5):**
   1. **Prompt:** line 763; the Blank keyword is line 769.
   2. **Blank means not known:** lines 779-783.
   3. **Enter:** gives this drawing's remembered level, or not known (lines 784-789).
   4. **Remembered:** only when a level was given (lines 361-362), and only for the same drawing (Rules/TrenchGrateCoverMemory.cs lines 31-32, key = file path plus drawing id, SBIC line 795).
   5. **Callout text:** lines 808-823. The PCL line is added only when a level is known, as 0.000 (line 813).
   6. **Placed line:** lines 400-401.
   7. **Outlet prompt:** AgiCommand.cs line 218; Enter skips it (lines 224-225).
4. **Derived, never seen on a run:**
   1. **Callout position:** 650 mm above each grate start (300 x 1.5 + 200, SBIC lines 22-23, 681-683, 840), so the case looks near start x, -67350, within 400 mm.
   2. **Tag numbers:** TG2 to TG5, because the fixture holds TG1 (recorded, not checked).
   3. **Prompt default:** the D prompt shows the remembered 45.2 (recorded only).
   4. **Typing chains:** the chain counts follow N51, which is written but never run.
5. **Arithmetic:** 45.2 is shown as 45.200. Each grate is 2000 mm long. The grates sit 500 mm apart, so no two callouts fall within 400 mm of the wrong start.
6. **The one thing the twin breaks:** grate C is answered with Enter instead of Blank. It must fail on `not-contains $tc "PCL"`, because Enter after 45.2 in the same drawing offers 45.200.
7. **What a Codex look must see (the part the robot cannot do):**
   1. Open a copy drawing A and run CDTG with 45.2.
   2. In the same AutoCAD, open a second copy saved under another name (drawing B).
   3. Run CDTG in B and press Enter at the cover level prompt.
   4. B's callout must have no PCL line, and the prompt must show no 45.2 default.
   5. Also check a copy made in Explorer from A (same drawing id, other path) gets no level (TrenchGrateCoverMemory.cs lines 12-17).
8. **Scope:** a part case. Under the 24 Oct rule it counts for the Blank and same-drawing half only. BUG-743 stays unproven until the Codex look.

## 3. BUG-744: CDFIXTAGS labels (NO case)

1. **Why no case:** the fix (SourceTagRepairCommand.cs lines 161-166) only matters when a CDFIXTAGS rename really applies. It keeps "had a label" and never adds one. On DRV1_B1 no rename applies:
   1. **The DP3 pair:** both are pit blocks, refused "already carries the CE identity of another kind of object" (BUG-813, runs 32 to 34).
   2. **The four AGI blocks:** refused because their pick areas overlap.
2. **No typed route makes a fresh doubled pair of ordinary source blocks:**
   1. **COPY:** a copied source gets a fresh number (Services/LinkService.SpineClones.cs lines 157-164).
   2. **CDTAG with the BUG-742 switch off:** it can double a name only on blocks a typed point can hit. Those are pit blocks (T1's W741 uses P9 and P10), so the rename is refused again.
   3. **A downpipe circle:** hitting it needs a pointer click at a waiting prompt. That works only on a world point from a stored view, and the circle's world point is not known without reading the drawing first.
3. **The second symptom** (rename refused when the GUIDELINES layer is missing) needs the same applying rename.
4. **Codex look recipe:**
   1. In a copy, place DP twice (DP1, DP2).
   2. Set `linking.cdTagRefusesUsedNumberedName` false.
   3. Insert a plain DOWNPIPE DYNAMIC WITH MASK block.
   4. CDTAG it by mouse as DP1, answering No to "Show the tag label on the drawing?".
   5. Run CDFIXTAGS and answer Yes.
   6. The renamed block must keep its label state: the block with no label gets no new label, and the labelled one shows its new name.
   7. Repeat with layer GUIDELINES purged first: the rename must not be refused.
5. **What would make it a robot case:** the fixture named in ROBOT_GAPS_2026-10-19 item 8, two ordinary source blocks both tagged DP3, one with no label.

## 4. BUG-746: source tag removal leaves an orphan record (NO case)

1. **Why no case:** the fix (Services/SourceTagService.cs lines 488-503, `EraseRecord` before `dict.Remove`) changes only hidden records in the file. The visible drawing is the same before and after the fix.
2. **The robot cannot read them:**
   1. Typed LISP is banned (README_CASES step 1: "No `(`"; memory note: typed LISP wedged AutoCAD).
   2. `ent-read` reads only drawing objects through COM (acad_driver_v3.ps1 lines 817-835) and cannot list an extension dictionary.
3. **Reaching the removal:** it needs CDTAG Remove on a tagged block picked by a typed point. Those are pit blocks, where the source change is refused (BUG-813 family), as in run 31.
4. **Codex look recipe (or a headless test):**
   1. Before removal, read the CE_SOURCE_TAG record handles of a tagged downpipe with `(entget (cdr (assoc 360 (entget (handent "<h>")))))`. Run 31 noted 11C558 and 11C562.
   2. Run CDTAG by mouse, choose Remove, and see "[CE] CDTAG removed. Source and pipe changes saved together." (SourceTagCommand.cs line 86).
   3. `(entget (handent "<record handle>"))` must return nil (the record is erased). On the old build it returned the record.
5. **Better route:** a headless test on a real Database. The fix is pure database work, which fits BUG-746 better than a robot case.

## 5. BUG-713: spot-level finder, blank spot hides a valid one (W713, twin W713_BROKEN)

1. **What the case does (drafter's words):**
   1. Types PIT at 156000,-61500 with cover 19.000, using SETUP-R47v's New Pit steps.
   2. CDSL at 156020,-63500 with Enter: a blank spot level.
   3. CDSL at 156040,-63500 with 19.020.
   4. CDFALLSUGGEST, picks 156000,-63500 and answers Skip, then Esc.
2. **What must be true:**
   1. The blank spot's LEVEL is empty and the good one reads P19.020.
   2. CE never asks "No spot level here" and never says "No level at this point".
   3. It says "[CE] Suggested: FALL toward P..., 1:100." and then "Next level (0 placed, 1 skipped)".
   4. "CDFALLSUGGEST finished. 0 placed, 1 skipped." appears.
   5. No FALL block is added, no CE window is left open and the file is unchanged.
3. **Where the words come from (at 3fbb9da5):**
   1. **Finder:** Services/SpotLevelReader.cs lines 24-71; a blank LEVEL is skipped at lines 60-61; Rules/SpotLevelText.cs TryPickNearest lines 62-86 ranks only readable spots.
   2. **Reach:** 50 mm, FallSuggestCommand.cs line 37 and lines 196-197.
   3. **Prompts:** Rules/FallSuggestPromptRules.cs lines 6-9.
   4. **"No spot level here":** FallSuggestCommand.cs line 186.
   5. **"Suggested":** lines 115-116.
   6. **"Accept, Move or Skip this fall?":** line 165.
   7. **"finished":** line 75.
   8. **"No level at this point":** FallArrowGeometry.cs line 93.
   9. **Grade text:** FallArrowGeometry.cs lines 194-202.
   10. **CDSL:** "Spot level placed. Level: (blank)" or "P19.020" at SpotLevelCommand.cs line 161; Enter places a blank level at lines 124-127; the P plus 3 decimals format at SpotLevelText.cs lines 90-91.
   11. **Pit type:** the default GRATED PIT (Models/PitData.cs line 22) counts as grated (FallSuggestCommand.cs lines 227-230).
4. **Arithmetic:**
   1. **Run:** the pick point is 2000 mm south of the pit centre, so 2.000 m.
   2. **Fall:** 19.020 - 19.000 = 0.020 m.
   3. **Grade:** 2.000 / 0.020 = 100, shown "1:100".
   4. **Spot distances:** the blank spot is 20 mm from the pick and the good spot 40 mm, both inside 50 mm.
   5. **Nearest-pit guard:** the nearest other pit typed in this folder is at 160450,-64000, 4.5 m from the pick (others 4.7, 5.3 and 6.0 m). So the new pit at 2 m is the nearest downhill grated pit, even if earlier cases left pits with cover 19.000 in a shared drawing.
5. **Derived, never seen on a run:**
   1. CDFALLSUGGEST has never been driven on DRV1_B1.
   2. A blank CDSL leaves the LEVEL attribute empty. The case checks this as a guard, so a non-empty default shows as a plain red line, not a false pass.
   3. The pit number is recorded only.
   4. The second esc-prompt should find "nothing to cancel".
6. **The one thing the twin breaks:** the good spot sits 60 mm away (outside the reach). The whole layout is also moved 6000 mm east, only so it never meets W713's pit and spots in a shared drawing. It must fail on "No spot level here", "Suggested" and "1:100". It does not stall: Skip at the number prompt is refused, the first Esc cancels that prompt, and the second ends the command.
7. **Not driven:**
   1. The pit design-level offer (DesignLevelService.cs line 222, same reader, design levels only), which the bug also names.
   2. An unreadable (not blank) nearer spot, which CDSL can no longer make (BUG-711).

## 6. Seen on screen versus read from the drawing

1. **Read from the drawing or command line (Claude-acceptable under the 24 Oct rule, once reviewed and passed twice):** callout text, block counts and layers, CDSL and CDFALLSUGGEST command-line lines, and the spot LEVEL attributes.
2. **Needs a Codex look:**
   1. The look of the trench grate callout.
   2. The BUG-743 other-drawing half.
   3. BUG-744 and BUG-746 as recipes above.

## 7. Could not write, and faults noticed in existing files (named only, not edited)

1. **Could not write:** BUG-744 and BUG-746 (sections 3 and 4).
2. **N51_trench_drain_two_points_u (drafts_next40_a_30oct):**
   1. Its header quotes the cover prompt as "Cover Level (m AHD) or [Blank] <enter to skip>: " at line 763, which is right at 3fbb9da5.
   2. It checks `select $new "text~WIDE TRENCH WITH CLASS C GRATE"` without a near filter. That is fine alone, but in a shared drawing after W743 it would still count only its own new objects (ms-new), so no fault.
   3. Not run yet, so the CDTG chain is still unproven.
3. **Shared drawing note for the desk:** W743 and W713 both use SLOT fresh with no SETTING line, so they share a drawing with most wave-1 cases.
   1. W713 adds one grated pit (156000,-61500); W743 adds four TG nodes.
   2. With ORDER 900 to 903 they run last, after cases that count pits or tags.
   3. W741 and W742 (job T1) carry SETTING lines, so they run in their own start and do not meet mine.
