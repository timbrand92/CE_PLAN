# Answer: the A7 test list (labels, inverts and arrows), codex/tests-a7b at 893e54c, now codex/tests-a7-clean at bafd6fb

**Answer: HOLD THE LIST. Nine reasons.** Written Fri 20 Nov 2026, about 3:10 pm, by the check room. Checked on the bench only. First answer on this list. Both helpers read 893e54c; the clean branch bafd6fb has the same test files (checked by reading), so every finding carries over. Fix on bafd6fb.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a7b_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a7b_adv_REPORT.md`, proofs in `a7b_adv_proofs\` (a cheat of seven product files turned the list green with levels, labels and warnings still wrong). They agree; graded here.

## 1. Counts seen (the writer's counts are true)

Pretend drawing 748 ran, 679 passed, 69 targets fail; bench 439 ran, 1 target fails; 0 skipped; six controls pass; nothing older fails. The new bench test makes no second window thread. Every target fails on a real fault except the mask target (it fails on a field the pretend drawing does not have).

## 2. Closed already

**The 29 result files with the user and machine name** are not on bafd6fb or anywhere in its history, and main now ignores such files (a05472a). The old branch stays untouched (D-394).

## 3. Reasons to hold

1. **The short-pipe targets require the wrong words, and can never pass once arrows are drawn.** `Stage1A7PlacementOrderTests.cs:168, 178, 182, 188` require exactly "100 DIA. UPVC PIPE AT 1 IN 100" with neither end typed, where D-238 and D-383 item 9 end it "MIN."; and their pointer count takes the flow arrow (a leader on the same layer, on by default) for a callout pointer. Tell the pointer (label to a point on the pipe) from the arrow (along the pipe, tip downstream), and add one case with both drawn.
2. **A wrong invert passes.** `Stage1A7RunInvertTests.cs:10` accepts text that CONTAINS "12.60": "IL 12.609" passed. `Stage1A7FlowAndWordingTests.cs:357` finds only text starting "IL", so "APPROX. IL ..." is missed. Compare the whole text, by pipe and by end.
3. **A run's levels are checked in the proposed answers, not on the drawing** (`Stage1A7RunInvertTests.cs:49, 80-89`): the cheat filled six strings and drew nothing. Read the drawn text of every end of the run, then reopen it (D-141, D-383 items 8 and 9).
4. **A "slid" label or arrow passes after moving 0.02 mm** and still lies across what it was to clear (`Stage1A7FlowAndWordingTests.cs:96, 105, 109, 121, 379`; `Stage1A7PlacementOrderTests.cs:12, 30`). The whole length of the text, and both ends of the arrow, must clear every obstruction (D-361, D-365, D-369). "Same point" is a tenth of a millimetre (D-341), not a hundredth.
5. **The flow arrow passes as a plain line with no head** (`Stage1A7FlowAndWordingTests.cs:417-423`): reversed, it looks the same on the sheet (D-369, D-370).
6. **The overlap flag is tested by the stop-gap D-385 replaced** (`Stage1A7PlacementOrderTests.cs:194-236`): a hidden record, a command-line line and a property that always says yes turned it green with no marker drawn. Require the amber no-plot marker beside the blocked text (the marker itself is the flag job's, codex/tests-flag), and that the mask comes from the call the tool makes.
7. **Pit text is checked by its anchor point only** (`Stage1A7PlacementOrderTests.cs:72-77, 269-275`; `Stage1A7AnnotationTests.cs:151-166`): the number control passes today with the number starting at the pit centre and running right; a cover text can run back across the pit; the angle is taken so that upside-down text passes. The cover target accepts "TBC" on any text and does not check that an old level went (`:239`).
8. **No test that the drafter's own text survives** (D-377 items 5 and 6, D-014, D-182): erasing a pipe takes its label, levels and arrow and leaves the pits; text erased by hand stays gone after the next edit; a label moved or reworded by hand is kept and flagged; one Undo for each.
9. **Older tests still demand the opposite and are left standing:** `PipeWindowFromDrawingTests.cs:59-85, 147, 212-225, 264` (no "MIN."; arrow and invert ticks hidden; a later pipe kind drawn); `PipeToolTests.cs:101`; `PitToolTests.cs:86`; `bench/CeCivil.Bench.Tests/FifthPassTests.cs:57-67`. Correct them in the list, or name them in it, so the builder is not pulled both ways.

## 4. To add in the same round (not holds alone)

1. **A third value of each setting, another origin, pit size and pipe length,** and a pipe drawn right to left for the label and inverts: two samples of each can be memorised (a 475 mm setting used 325).
2. **Move the D-382 preview target to the window list (7b):** it would hold A7 for the window's fault, and two fixed pit names pass it.
3. **Do not key anything on a pipe's name** (D-397): pick pipes by identity.
4. **The fixture label** "150 DIA. UPVC PIPE AT 1 IN 100" with both levels typed is wrong twice (D-239: UPVC SN8; the exact grade): use the 100 dia. fixture.
5. **The single-invert target** (`FlowAndWording:152`) hands the tool one level past the window; under D-383 item 9 the other end is worked out and written.

## 5. For the control room (no ruling found)

1. **Which words for a cover not known: "TBC" or "CL TBC"?** The tests take either.
2. **Ticks:** D-377 item 6 says every piece of text has its own tick; D-393 has one "Invert levels" tick on the run window. Which does the list test?
3. **"Above" on a pipe drawn right to left or upright;** the corner and the angle of the cover text on a TURNED pit (D-267 against D-363); what the 200 mm and the 900 mm measure to; which side the number tries first beside the pit; where a slid invert ends up.
4. **Whose settings the four distances are** (office or job); an old label whose size cannot be read ("TBC DIA." or as drawn and flagged); a worked grade's decimal places; Reverse with both ends typed.
5. **A later pipe drawn through an existing label:** does the first label move, or stay and take the marker?

Each is written out as Tim could answer it in the two reports (honest section 6; adversarial section 4).

## 6. Follow-ups

In the two reports and `FOLLOW_UP\part2-pit-and-pipe.md`: text heights at 1:100 and the arrow's size; the "MIN." tick; mirror, move, a pit dropped mid-pipe, the callout by a grip; text against another pipe, label or pit; a pipe at an angle; the on-screen test `ListControlsTests` flakes by itself (an older fault of the windows, seen with the PC in use); `TESTS_REPORT.md` links to a folder that is not in the commit.

## 7. Ruled since (control room, about 3:10 pm, D-399, with Tim's D-398)

1. **"CL TBC" only** for a cover not known (Tim: "'CL 12.95', and 'CL TBC' when not known").
2. **Ticks:** each piece of text has its own tick on the part (D-377 item 6); the run window's one "Invert levels" tick sets both ends on every pipe of the run (D-393). Test both.
3. **Placing:** the cover level on a turned pit is at 45 degrees to the SHEET, off the corner nearest the top right; the pit number stays flat and upright (D-267); the arrow is centred below, between the two levels, else on the label's side; the 900 mm is from the pit centre (D-366); a plastic pit reads "PP" over "CL 5.65" as one two-line text at 45 degrees; the pit number is always the office circle tag.
4. **The four distances are OFFICE settings** in Stage 1.
5. **NOT ruled, mark WAITING** (with Tim's room): "above" on a right-to-left or upright pipe; what the 200 mm measures to; which side first beside the pit; where a slid invert ends; an old label whose size cannot be read; a worked grade's decimal places; Reverse with both ends typed; a later pipe through an existing label.
6. **D-400 (Tim, about 3:22 pm) closes two of the waiting items:** the number beside the pit tries RIGHT first, then left; the 900 mm is pit centre to circle centre. Also ruled: ByLayer for everything; Z 0 and scale 1 always; a pipe with bends has one label centred above its longest straight length, the arrow on the other side of that length, inverts only at the two ends of the whole pipe, and an invert at a bend by the pit slides past the bend to the first straight length with room; the mask is on from day one with a way to turn it off (draft: one office setting). "In the way" is text, pipe bands and pits now; building walls in an xref and the green impervious-area line are to count, but how is NOT ruled: tests for those WAITING.
7. **D-402 (Tim, about 3:36 pm):** the cover level's corners go clockwise from the top right; 400 mm clear from the pit's OUTER dashed corner to the nearest end of the text; the text lines up from the pit outwards (the left corners WAITING on a picture). Retyping a cover level text sets the pit's level (cover only; D-185 stands for inverts and grades). This settles reason 7's "which end of the text" for the right-hand corners.
8. **D-405 and D-406 (Tim, about 4:32 pm) close most of the waiting items:** a 50CONT polyline 70 wide counts as in the way; a pipe label with no clear spot goes on a pointer; the 200 mm is from the pit's OUTER dashed line; an invert slides at most 1,000 mm; "above" is the side the text's top faces; a size that cannot be read is shown as drawn, plus the marker; a worked grade is to the whole number; Reverse with both ends typed turns the arrow, reads red "Wrong: runs uphill" and leaves the levels unchanged; a later pipe through a label moves the EARLIER label in the same Undo; the circle is 150 mm clear of the pit edge; a Mask tick on EACH text. Walls in an xref are still WAITING. The fix round (2c426d6) was written before these: its re-check reads them and says which targets must be restated.
9. **D-413 (Tim, about 4:59 pm):** a label with NO grade leaves the grade off (not "TBC"); an invert level RETYPED on the plan as a number SETS the level (only grades are never changed by text): the control "retyping an invert or grade leaves the figures" is now half wrong and must be split; text heights and layers: label 250 on 25TEXT, invert 180 on 20TEXT, cover 200 on 25TEXT, pit number 350 on 35TEXT; a grey source word on every figure he did not type; a typed length shows "typed 6.50 m, drawn 6.20 m" and survives a move, with the marker. The native commands: BREAK gives two pipes; JOIN and FILLET at 0 give one pipe; a rounded fillet is refused; OFFSET gives a loose pipe.


---

# Second answer: codex/tests-a7-clean at 2c426d6 (after its first fix round)

**Answer: HOLD THE LIST. Ten reasons. Seven exist only because Tim ruled after the round was written (D-404 to D-414); three are faults of the list. One fix round left.** Written Fri 20 Nov 2026, about 5:10 pm. Checked on the bench only.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a7c_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a7c_adv_REPORT.md`, proofs in `a7c_adv_proofs\` (it broke all nine controls and added seven faults of its own; worked drawings in `a7c_adv_proofs\drawing-cases.md`). They agree; graded here.

## 10. Counts seen (the writer's counts are true)

Pretend drawing 812: this list 139 cases: 116 targets fail, 1 target passes today (a control in all but name), 9 controls and reader checks pass, 13 waiting (skipped with reasons); 673 older pass. Brain 750; bench 438 pass and the 2 moved preview cases fail (now tagged 7b, not A7). The whole solution builds. Only tests changed. The saved cheat, which turned the old list wholly green, now turns 13 of 116 targets green.

## 11. What the round closed

Short-pipe words now end "MIN."; whole invert texts read by owner and end, "APPROX. IL" included; a run's six drawn texts read, then again after save and reopen; a slid label or arrow must clear with its whole box, at a tenth of a millimetre; a headless arrow fails; a real amber triangle on a no-plot layer, the mask read from what the tool writes; pit number and cover checked by the whole text, right way up, "CL TBC" exactly; erase, hand-erase, hand-move and reword cases; the older contrary tests named; three values of each setting; the preview moved to 7b; nothing keyed on a pipe's name.

## 12. Reasons to hold

**From rulings filed after the round (restate to them):**

1. **The flow arrow must be the office block TIM_CVL_ARROW** (D-404, D-396: "nothing new is drawn"). Every arrow target looks only for drawn lines with two wings (`Stage1A7FlowAndWordingTests.cs:451-495`); a real block gave zero arrows; 17 target cases can never pass a right build. One owned block reference on 25DIMS (D-414), pointing downstream, scale 1.
2. **A PIPE label with no clear spot goes on a pointer** (D-405 item 3, D-407 item 6). `Stage1A7PlacementOrderTests.cs:223-265` want it back at its first spot with the marker. The first-spot-with-marker cases move to an invert (after its flip and 1,000 mm slide), a pit number and a cover level (the cover case at `:229` must also require its marker).
3. **A Mask tick on EACH text, on from day one** (D-406 item 6). The mask is tested as one office switch (`Stage1A7DrawingFinishSituations.cs:70-87`; `PlacementOrder:241-257`).
4. **Eight things now ruled are still waiting and uncounted:** the 200 mm measured from the pit's OUTER dashed line to the nearest end of the text (today no live target fixes where an invert sits along the pipe); the invert's slide of at most 1,000 mm (a setting); which side is "above" (the side the text's top faces); a 50CONT polyline 70 wide counts as in the way; an old label whose size cannot be read stays as drawn, with the marker; a worked grade to the whole number; Reverse with both levels typed (arrow turns, red "Wrong: runs uphill", levels unchanged); a later pipe through a label moves the EARLIER label in the same Undo. The wall inside an xref is NOT Stage 1 (D-414): keep it out of the count.
5. **One control now demands that his edit is lost:** `Stage1A7PipeTextSituations.cs:140-170` retypes "IL 12.60" as "IL 14.25" and requires the level to stay 12.60. D-413: an invert retyped on the plan as a number SETS the level (a grade is never changed by text).
6. **The pit number's tag:** the tests take the block name from the office list, which still says "PIT LABEL" (`src/CeCivil.Brain/data/tools.csv:411`), and accept plain text on it; ruled: PIT LABEL 2 with the number in its attribute PIT_LABEL (D-404), the circle at least 150 mm clear of the pit edge (D-406 item 5; a circle 50 mm clear passed: `PlacementOrder:348-359`).
7. **The marker's colour is asserted on its LAYER** (`PlacementOrder:304-320`; `Stage1A7PitTextSituations.cs:145-147`); D-412 (draft): the layer "CE NO PLOT" stays grey and the marker carries its own amber; its height is the text height, one text height clear (D-414).

**Faults of the list:**

8. **A wrong grade is required.** `PipeText:27-35` requires "1 IN 100" on a pipe 9 m long (3 + 4 + 2) falling 0.12 m from 12.40 to 12.28: that is 1 in 75. The fixture hands in grade 100 whenever two levels are given (`FlowAndWording:249-262`). Use the window's own sum; with D-406 item 2 the label reads "1 IN 75".
9. **A later pipe kind can be picked and an ordinary pipe drawn without a word** (`Stage1A7RunInvertTests.cs:168-181` passes on that). D-377 item 1: if the kind can be picked at all it is refused in words and nothing is drawn.
10. **A level worked out from an APPROX. level must print as a firm "IL 12.41"** (`RunInvert:23-38`). Not ruled (question 1): park that half.

## 13. To fix in the same round

1. **A label lying ACROSS a pipe band passes as "75 mm clear"** (an absolute value: `Stage1A7AnnotationTests.cs:198-212`); a slid arrow is checked against bands only, not its own label, the inverts or the pits (`FlowAndWording:497-511`); a pointer may stop a text height short of its label (`:440`); `Annotation:29` compares to six decimals where a tenth of a millimetre is the same point.
2. **Read every owned invert by its role first, then its words** (a linked text reading "TBC" was invisible); the two end ticks can be swapped and still pass (`Stage1A7TextOwnershipTests.cs:81-94`); erase one of two neighbouring pipes and keep the other's text.
3. **Text heights and layers** (D-413): label 250 on 25TEXT, invert 180 on 20TEXT, cover 200 on 25TEXT, pit number 350 on 35TEXT; **part layers** (D-414): pit and tag on STORMWATER, band on STORMWATER PIPE, edges on DRAINAGE, arrow on 25DIMS. A label with no grade leaves the grade off: "100 DIA. UPVC PIPE".
4. **The four distances are office defaults that a drawing may override** (D-414, the Settings window): keep the office cases, add one drawing changed and another left alone.
5. **A run of six pits, both ways, from a middle hold;** two pipes between the same two pits picked by identity (D-397, D-398).
6. **Four targets fail on a reader the tests do not have** (ByLayer, Z 0, scale 1, the block's own part settings): the pretend drawing must record these from the calls the tool makes; Z 0 is owed in AutoCAD.
7. **THE BRANCH HAS MOVED ON AND THE RUN FILES ARE BACK:** the tips 19324db and 01b22f5 hold the 12 run files again (`.a7-review-run`, `.a7-verify`: a sandbox account name, work paths, two third-party program files). The tree handed over next must not hold them; a squash of a tree that still holds them is not enough.

## 14. For the control room

1. **A level worked out from an APPROX. level:** does it print "APPROX." too? (Recommended: yes.) And the words of the one standing note D-177 asks for.
2. **Where the pit's outer dashed line is:** the tests take 100 mm outside the opening for every pit, a figure marked draft in the office list; it should be read from PIT BLOCK 3 when the 18 copies are opened.
3. **Two legs of a bent pipe exactly the same length:** which takes the label?
4. **The left corners of the cover level** still wait on Tim's picture (three skipped cases).

## 15. Follow-ups

In the two reports and `FOLLOW_UP\part2-pit-and-pipe.md`: the one-sample targets the cheat beat (vary length, size and pit numbers for "MIN.", the later kinds, the new-pipe arrow tick, the stacked label); the sleeve, ByLayer and Z 0 for every object and the pit block's own settings belong to other lists; D-385's hover words; mirror, a moved pipe, a pit dropped mid-pipe, the callout by a grip; the on-screen `ListControlsTests` flake; `TESTS_REPORT.md` links to a folder not in the commit.

## 16. Ruled since (control room, about 5:13 pm, D-416)

1. **The round count restarts.** A reason that exists only because of a ruling filed after the round began does not count toward the two rounds. The baseline from now is the decisions record at D-416 (Tim is away until Monday; the rulings hold still). This list carries forward only its own faults: reasons 8, 9 and 10 of section 12.
2. **DRAFT: a level worked out from an APPROX. level prints "APPROX." too.** The standing note, DRAFT words: "LEVELS MARKED APPROX. ARE ASSUMED AND ARE TO BE CONFIRMED ON SITE BEFORE CONSTRUCTION." Test that the note exists and that APPROX. carries; mark the exact words DRAFT.
3. **The pit's outer dashed line is read from PIT BLOCK 3 itself at each size** when the 18 copies are opened; the 100 mm is DRAFT until then; mark the tests that lean on it DRAFT.
4. **DRAFT: two legs exactly equal: the label goes on the UPSTREAM leg.**
5. **The 12 run files:** the build room strips them before the next hand-over; the check room does not check a tip that holds them.


---

# Third answer: codex/tests-a7-clean at de5d082

**Answer: HOLD THE LIST. Eight reasons, all the list's own (none comes from a ruling filed after the D-416 baseline). This is round one of two from that baseline.** Written Fri 20 Nov 2026, about 7:25 pm. Checked on the bench only.

**Who checked, and how they split.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a7d_honest_REPORT.md`: ACCEPT, with ten small fixes. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a7d_adv_REPORT.md`, proofs in `a7d_adv_proofs\`: HOLD. The check room read the test lines behind the adversarial pass's reasons 1, 6 and 7 itself and found each as described; a hold needs only one true reason, so the list is held. The honest check is right about everything it looked at: the ten reasons and seven same-round items of the second answer are closed for their named cases.

## 17. Counts seen (the writer's counts are true)

The whole solution builds, the AutoCAD plug-in project included, no warnings. Pretend drawing 868: 696 pass, 164 targets fail (79 marked DRAFT, 85 firm), 8 skipped with reasons (3 waiting on Tim's picture of the left corners, 4 owed in AutoCAD, 1 out of Stage 1). 8 more targets already pass. All 673 older cases pass. Only tests changed. The saved cheat turns 8 of the 164 green and breaks one. A few speed tests and one on-screen list test failed under the heavily loaded PC and pass alone; the branch touches none of that code.

## 18. What the round closed

The three carried faults: the 9 m bent pipe must print 1 in 75; a later pipe kind that is offered must refuse and draw nothing; a level worked from an APPROX. level keeps APPROX. (DRAFT D-416). Also: the arrow is the office block; a label with no clear spot goes on a pointer; a Mask tick per text; the 200 mm from the outer dashed line; the 1,000 mm slide on a straight pipe; 50CONT in the way; an unreadable old size kept with its marker; the whole-number grade on the sheet; Reverse; the later pipe through a label; a retyped invert sets the level; no run files in the tree.

## 19. Reasons to hold

1. **A right build cannot turn the arrow-off target green.** Switching the arrow off must leave no new linework at all (`Stage1A7FlowAndWordingTests.cs:69`; the stock-take at `:378-386` is the one taken before the pipe was drawn, and `:504` counts every line), yet the pipe's own two edge lines on DRAINAGE are required by `Stage1A7DrawingFinishSituations.cs:51`. Keep the two edges, by their own identity and position, and check only that the arrow is gone. The arrow reader at `:527` also lets ANY open zero-width DRAINAGE line through: a second arrow drawn from three lines passes.
2. **A two-line label can lie across its own pipe and pass.** `Stage1A7PipeTextSituations.cs:35-43` measures the height of one line: top-centred 250 text at 375 from the centre line of a 100 pipe reads 75 clear while its second line reaches 125 past the centre line. Measure the whole text box, for the bent and the short stacked cases (D-361, D-367, D-400).
3. **At a bend an invert can slide well past the 1,000 mm limit.** `PipeTextSituations.cs:78-86` accepts the first invert anywhere up to 3,500 along the next leg; the straight-pipe limit at `Stage1A7PlacementOrderTests.cs:315` is never asked of a bent pipe. Measure the travel through the bend; the first spot past the setting stays with its marker (D-405 item 5).
4. **A Mask tick can work the wrong text.** `Stage1A7D406Tests.cs:303-324` accepts any one text changing: Label, upstream and downstream ticks wired to each other's text pass, saved and reopened; the same on the pit number and cover. Each named tick must change the mask on its own named text, the tag's attribute included (D-406 item 6).
5. **After an edit, wrong levels can stay on the sheet.** Raising the top level by 0.25 is read on pipes one, two and five only (`Stage1A7D413Tests.cs:146-167`): pipe three left at IL 12.36 where it must read 12.61 passes. The whole-run reversal (`:192`) reads no written level. Read all ten texts and every hold on the SAME edited run after reopen. A typed length is never followed by a stretch (`Stage1A7D410Tests.cs:31-41`): a held 6.50 m replaced by the newly drawn 7.20 m prints 12.46 for 12.47 and passes.
6. **The no-grade target is handed its own answer.** `D413Tests.cs:8-22` writes "100 DIA. UPVC PIPE" into the fixture and reads it back; it is one of the eight targets already green. Start from a saved pipe with a size and material and no grade, open it, press OK, and read its text after reopen (D-413 item 3).
7. **An edit to one pipe can rewrite its neighbour's label and pass.** With two pipes between the same pits (`D413Tests.cs:201-222`) the first pipe's label is checked by its object, never its words, and neither running number is read. Pick each by its own pipe number through the normal edit route; compare both pipes' words, levels and links after reopen (D-397, D-398 item 2).
8. **Draft answers are counted as firm.** The two worked-grade rows fail only because the WINDOW shows 95 where the test wants 94.6 (`D406Tests.cs:83-86`): the sheet's whole number is ruled (D-406 item 2), the window's figure is not (D-411 item 1 is a draft, for one case). Two left-corner rows measure 400 mm to an end that D-419 item 9 leaves open (`Stage1A7PitTextSituations.cs:89, 105, 182-199`). The three block sizes the tests assume (the 800 circle, the arrow's outline) are not marked DRAFT as the 100 mm wall is. Keep the ruled halves as targets; mark or park the rest, so that Tim overturning a draft changes only DRAFT rows.

## 20. To fix in the same round

1. **A changed setting is tried through a route the plug-in does not have** (`DrawingFinishSituations.cs:70-93` seeds the pretend drawing's system variables). Restate it against the settings store once that is on the main line; a waiting row until then.
2. **The marker beside a blocked pit number or a hand-edited cover** is accepted at any size, anywhere near (`PlacementOrderTests.cs:292`; `PitTextSituations.cs:145`): hold it to the text's height and its ruled spot.
3. **Older tests that now contradict the list are still live** (`PipeWindowFromDrawingTests.cs:212-225` no MIN.; `PipeToolTests.cs:99-102`; `PitToolTests.cs:86`; `FifthPassTests.cs:57-67`): named in the hand-over, as allowed; each must be retired or restated in the same commit as the build that turns its opposite green.
4. **The eight targets that already pass** are named controls, or made to fail first.
5. **Position checks to the 5 mm of D-341** (400.02 mm is refused at `PlacementOrderTests.cs:446`).
6. **Mis-tagged rows:** the two typed-length rows carry DRAFT D-412 though they assert no marker; D-419 items 4 and 8 have no row.
7. **One squashed commit;** the writer's dated report stays out of the main line's test tree; the root `TESTS_REPORT.md` still describes drawn arrow wings and one office mask switch.

## 21. For the control room

1. **A worked grade in the window:** with a fall of 0.20 m over 18.92 m, does the grade box show 94.6 (with 95 on the sheet) or 95 in both places?

## 22. Follow-ups and owed

Follow-ups: the sleeve's two clicks belong to the pipe window's list, the words stay here; a mirrored run, four exits each fully annotated, a rectangular pit at 90 degrees and far-from-origin cases have no row. Owed in AutoCAD (not a hold): Z 0; one Undo for each joint edit; the real block outlines and text widths; masks and ByLayer on real objects; plotting.
