# Wave 1 case writing, job P2: OOPS after ERASE (Sat 31 Oct 2026)

Writer: Opus agent on Team, job letter P2, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Bugs: BUG-267, BUG-285, BUG-325, BUG-330, BUG-667. Nothing was run in AutoCAD; no existing case, setup, spec, driver or settings file was changed; nothing committed. Source of every word: commit `3fbb9da5` (Civil 3.0.88, `origin/claude/rel-20261102a`), read with `git show` / `git grep` from `C:\Lisp Files\CE_ACAD_PLUGIN`.

## ANSWER FIRST

1. **Counts:** 4 of 5 bugs have a case and a broken twin (8 files): BUG-267, BUG-285, BUG-325, BUG-667. 1 bug has no case: BUG-330.
2. **Why BUG-330 has none:** its installed fix (PR #627) only changes how metre drawings read pipe length (CDCALC pre-fill, Design Review, dashboard fix). That needs the wave 2 metre drawing. Its OOPS item (pipes losing their end-owner choice) has no fix in the installed code, so no case can pass.
3. **Cases (folder `cases\drafts_wave1_31oct`):** W267 and W267_BROKEN; W285 and W285_BROKEN; W325 and W325_BROKEN; W667 and W667_BROKEN.
4. **What they prove in drafting terms:** OOPS after erasing a pit brings back its name label and cover text (W267). OOPS after erasing a pipe brings back its label, IL texts and arrow, and moving its pit then drags the pipe again (W285). OOPS says what it brought back in one line, and one U takes it all away (W325). A pit label erased on its own no longer breaks the next U or PITDELETE (W667).
5. **Made-up drawing only:** DRV1_B1 plus new objects at 150000,-80000. W267 and W285 use SETUP-R47v. W325 and W667 place their own pit with its label (linking.pitLabelOnEsc ON, the N80 route).
6. **Twins:** each twin changes one check to the old, broken behaviour, so it must FAIL on that check. The checks are: pit back bare at 1038 objects; pipe back bare at 1036; no OOPS line; the old 'Error during PITDELETE' line.
7. **Checks done offline:** validate 16 files, 0 invalid (the folder is shared with other writers). check_ids: 'every control id is known'. My 8 files contain no 'print', no street name, and only one level, 17.800 (correct, see W325).
8. **Biggest risk 1:** W667 picks the pit by typing a point on its north wall (150000,-79675). That position comes from the code and has never been driven. If the pick misses, W667 FAILS on the PITDELETE line, and its record shows the prompt again.
9. **Biggest risk 2:** the word list of pipe items in the OOPS line ('label, 2 IL texts and flow arrow') depends on the type CE stored against each item. It is not pinned: the cases match it loosely and record it.
10. **Biggest risk 3:** W267 expects 'pit P3 with its 2 labels'. That needs CE to read the owner note on the fixture's older labels. Codex C6-07 saw 'pit P2 with its label' in the same family of drawing, so it is likely.
11. **Never seen on a run (DERIVED):** every OOPS line, every count after ERASE, OOPS and U, the PITDELETE line, and the pipe position after the MOVE. Measured inputs: 1040 objects after SETUP-R47v, P3's ERASE taking 3 objects, the CDCHECK totals line, the six new objects and their layers.
12. **Codex look still needed:** after OOPS, do the labels look right and sit where they were (C5-07 left the far IL text and arrow Unknown)? Check BUG-330 on a metre drawing in wave 2.

## 1. BUG-267: OOPS after erasing a pit brings back its labels and record

1. **Case / twin:** `W267_erase_pit_oops_labels_back.case.txt` (CASE W267) / `W267_BROKEN.case.txt`.
2. **In AutoCAD terms:** after SETUP-R47v (P3 moved up 2 m, new pit P8 and a pipe; 1040 objects), CDCHECK Problems is run, pit P3 (109D56) is picked and erased (the pit, its name label and its cover text go: 1037), then OOPS. At the end: 1040 objects again, the command line holds exactly one line '[CE] OOPS brought back pit P3 with its 2 labels, and re-linked it.', P3 reads back on STORMWATER PIT, and CDCHECK Problems ends its totals with '4 Unresolved, 0 Not Connected, 0 Unknown.' (no pipe end left loose).
3. **Code for the checked words and numbers:** ERASE takes exactly the pit block's listed attachments, `LinkService.Compound.cs` 236-258. OOPS restores them and the record at command end, `LinkService.PitOops.cs` 99-256 (labels 159-186, record 214-234, summary call 241-245). The one line: `Rules/OopsBackSummary.cs` 115-143, pit wording 175-182, ' with its N labels' 194-200, ', and re-linked it' 136-142. The order at command end is `LinkService.Reactors.cs` 933-941.
4. **Measured, not derived:** 1040 after SETUP-R47v and the CDCHECK totals line '218 objects, 189 connections: 184 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.' (R19v87 PASS on 3.0.88, RUN-20261031-1356-C3.0.88-bF8v). P3 alone takes 3 objects (R19b: 1034 to 1031).
5. **DERIVED, never seen:** 1037 and 1040; the '2 labels' (the count of attachments CE erased, both restored only if each label's owner note reads back); the OOPS line; 0 Not Connected after OOPS.
6. **Arithmetic:** 1040 minus 3 (pit, name label, cover text) = 1037; plus 1 (AutoCAD's OOPS: the pit) plus 2 (CE: the two labels) = 1040. The pre-fix result was 1038.
7. **What the twin breaks:** `number $e2 = 1038` instead of 1040 (labels left erased, the old behaviour).
8. **Why no U here:** a U after the second CDCHECK would undo CDCHECK, not OOPS. The one-U proof is in W325.
9. **Codex look:** the two labels back in their old places; the Pit Schedule row for P3 after OOPS.

## 2. BUG-285: OOPS after erasing a pipe

1. **Case / twin:** `W285_erase_pipe_oops_items_back.case.txt` (CASE W285) / `W285_BROKEN.case.txt`.
2. **In AutoCAD terms:** after SETUP-R47v, the new pipe from P8 (150000,-80000) to the open end at 170000,-80000 is picked and erased. The pipe, its label, both IL texts and its flow arrow go (1035; of the six new objects only the pit is left). Then OOPS: all five come back (1040), one on 25TEXT, two on 20TEXT and one on ARROW. One OOPS line says 'pipe from P8 ... and re-linked it.' Then P8 is picked and moved 1000 mm down: the pipe's P8 end follows, so its box's lower-left y drops below -80500. Before the fix the pipe was not back on P8's list and stayed at -80112.5.
3. **Code:** ERASE takes the band, glyphs and listed attachments, `LinkService.Compound.cs` 200-234. OOPS restores the items (166-193), the pit lists (195-230) and the record (119-143), `LinkService.PipeOops.cs` 98-270. The pit list is re-joined only if the pit has not moved, `Rules/PipeOopsPolicy.cs` 38-48. Item nouns: `PipeOopsPolicy.cs` 55-70 and `OopsBackSummary.cs` 203-230. Pipe name 'from P8' for an open end: `OopsBackSummary.cs` 150-158 (To empty). The pipe record's From/To come from `CdCommand.Schedule.cs` 40-82.
4. **Measured:** 1040 after the setup; the six new objects and their layers (STORMWATER PIT, STORMWATER PIPE, 25TEXT, 20TEXT, 20TEXT, ARROW: N06 layer read on 3.0.88); the pipe box lower-left corner (150225, -80112.5) (3.0.88 runs).
5. **DERIVED:** 1035, 1040, the OOPS line, and y after the MOVE.
6. **Arithmetic:** 1040 minus 5 (pipe plus label, 2 IL, arrow) = 1035; plus 1 (AutoCAD: the pipe) plus 4 (CE) = 1040; pre-fix 1036. The pipe runs from the pit wall at x 150225 to 170000, so it is 19.775 m long. After moving P8 by 0,-1000 the P8 end is at about (150225, -81000). The band is 225 wide (half is 112.5), and the pipe now slopes 1000 in 19,775 (cos 0.9987), so its lowest corner is at about -81000 - 112.4 = -81112.4. The check is '< -80500', so the result is clear either way. Lesson 2 applies: the end level follows the pipe at the same grade, and no question or window is expected.
7. **Not pinned:** the item list nouns. A CD pipe's IL text is stored as a start-invert text (CDTIDYLABELS runs say 'start invert text'). The arrow is registered by `CdCommand.Arrows.cs` 437 with no type given, so it may read 'other item'. If every item has its type: 'with its label, 2 IL texts and flow arrow'. The case matches `with its [^.]+` and records the line.
8. **What the twin breaks:** `number $e2 = 1036` (bare pipe).
9. **Codex look:** the label and IL texts back exactly where they were.

## 3. BUG-325: OOPS says in one line what it brought back

1. **Case / twin:** `W325_erase_pit_label_pipe_oops_one_line.case.txt` (CASE W325) / `W325_BROKEN.case.txt`.
2. **In AutoCAD terms (Codex C5-07 route on made-up objects):** with linking.pitLabelOnEsc ON (SETTING line, guard restores), PIT at 150000,-80000, cover 19.000. Continue placement, then Esc at the label question, which places the number label at the usual spot (N80 route, PASS on 3.0.87). Then CD from the pit to 170000,-80000 at 18.000 / 17.800. Pick the pit and the pipe together and ERASE: everything new goes (the count equals the count before PIT). OOPS: everything comes back, the pit label is back, and there is exactly ONE line matching '[CE] OOPS brought back pit P8 with its label, and pipe from P8 with its ..., and re-linked them.' Then one U (echo OOPS) takes the lot away: the count is back to the after-erase value.
3. **Code:** the line comes from `Rules/OopsBackSummary.cs` 115-143: two parts joined with ', and ' (139-141), the comma rule (141), ', and re-linked them' for two objects (142), and 'pit P8 with its label' (178, 199). It is said once at the end of OOPS: `LinkService.PipeOops.cs` 292-324 (restore notes are kept and said after the summary), `LinkService.Reactors.cs` 935-941. The one-U claim is in `LinkService.PitOops.cs` 248-253 and `LinkService.PipeOops.cs` 263-268 (written inside OOPS's own command end). The label is registered to the pit in `PitCommand.cs` ~480-510; its usual-spot line is at `PitCommand.cs` 500.
4. **Arithmetic:** the pipe runs from the P8 wall (150225) to 170000, so it is 19.775 m. 18.000 - 17.800 = 0.200 m fall, which is 1 in 98.9. That is steeper than 1 in 100, so no Grade mismatch window opens (same levels and length as SETUP-P8v and R47v, PASS on 3.0.88).
5. **DERIVED:** the whole line, the pit number P8 (the same PIT on the same fixture is P8 in every P8 and R47 run), and the counts.
6. **What the twin breaks:** `history count "[CE] OOPS brought back" = 0` (the silence Codex saw).
7. **Not covered:** C5-07 also asked how the pipe label, far IL text and arrow look after OOPS (Unknown then). That is a Codex look item.

## 4. BUG-667: a pit label erased on its own no longer breaks U or PITDELETE

1. **Case / twin:** `W667_erased_pit_label_then_u_then_pitdelete.case.txt` (CASE W667) / `W667_BROKEN.case.txt`.
2. **In AutoCAD terms:** with linking.pitLabelOnEsc ON, place a pit at 150000,-80000 with its number label (as W325, no pipe). Pick only the label and ERASE it; the pit stays. Draw a short LINE (140000,-90000 to 141000,-90000) and U it (echo LINE). That U makes CE rebuild its link memory while the erased label is still on the pit's list. Zoom to the pit and type PITDELETE, picking the north wall at 150000,-79675. The checks: 'Pit deleted (block + label/cover).', no 'Error during PITDELETE', nothing of the new pit left, and no [ERR] line in the Civil log during the case.
3. **Code:** fix 212ca77d (PR #1336). The rebuild skips an erased listed label, `LinkService.Cache.cs` 582-586 and 672-676. It runs at the end of U, `LinkService.Reactors.cs` 923-924. PITDELETE opens the listed label in a way that tolerates erased objects, `LinkService.cs` 528-530. PITDELETE prompt 'Select pit block to delete: ', success line 109, error line 114, in `Commands/LinkCommands.cs` 49-116.
4. **Pick point arithmetic:** the opening is 450 square (R02 and N19: the pipe box starts at x 150225), and the wall is drawn 100 mm outside it (`PitOutline.cs`, quoted in N19). The north wall line is therefore at -80000 + 225 + 100 = -79675. The label sits bottom right and there is no pipe, so nothing else is near that point. The view is zoomed to 2000 mm first.
5. **DERIVED:** the pick landing, the PITDELETE line, and the empty list after it. If the pick misses, try the opening line y -79775.
6. **What the twin breaks:** it expects the old line '[CE] Error during PITDELETE - see CE log for details.'.
7. **Not driven:** the other symptoms (a pipe MOVE not carrying labels, dangling schedule rows).
8. **Risk:** 'log civil absent "[ERR]"' could also catch an unrelated error. Any such line is worth seeing anyway.

## 5. BUG-330: no case (why)

1. **What is installed:** PR #627 (merge bab2dcaf; commits 6662aa7a, ddfc4459, bb45cd59, abf4fe51). `REGRESSION_LOG.md` at 3fbb9da5, section 'BUG-330 (Civil)' (line 9083): CDCALC pre-fill, Design Review and the dashboard 'Propose fix / Fix all' read an older metre record's pipe length in the drawing's units. This is item (1) of the carpark entry, and only part of it.
2. **Item (1) needs a metre drawing** with an old record (pits with no stored units): wave 2's metre fixture. The case to write then is a 20 m pipe falling 0.100 in CDCALC, which should pre-fill 1 in 200.
3. **Item (2), OOPS and the end-owner choice, is not fixed in the installed code.** `ProjectDataService.PitOops.cs` and `LinkService.PitOops.cs` at 3fbb9da5 put back the pit record, its pipe records and the chosen outlet (`PitOopsRecordNote.cs`), but no end-owner choice. A case would fail, so this goes back to a builder, not to a tester.
4. **Items (3)** (Pipe tab in mm) **and (4)** (batch stops on one pipe) are not in PR #627 either.

## 6. Faults noticed (not edited)

1. **BUG_CARPARK.md, BUG-330 status line:** 'fix installed in Civil 3.0.70 via PR #627' reads as if all four items are fixed. PR #627 covers only part of item (1). The entry should be split before anyone marks it FIXED.
2. **No fault found** in SETUP-R47v, R19v87, R19b or N80 as used here.
