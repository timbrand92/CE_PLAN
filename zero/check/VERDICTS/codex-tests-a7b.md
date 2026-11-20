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
