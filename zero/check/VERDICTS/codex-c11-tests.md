# Verdict: the C11 test list, branch codex/c11-tests pinned at 11c6041 (tests only)

**Verdict: HOLD THE LIST.** Written Fri 20 Nov 2026, about 12:06 pm, by the check room. This is a verdict on a list of tests, the "definition of done" for root cause C11 (one exact figure, one checker, one printer), not on any build. Checked on the bench.

**In one line.** The counts are true and most tests are sound, but the adversarial pass turned all 70 failing tests green, with all 25 controls still green, on a product that still labels a too-flat pipe as meeting its limit. A build cannot be accepted against this list until the Stage 1 part is corrected and widened as below.

**Who checked.** Honest check: Team helper, Claude Opus 5.5, `C:\CE_WORK\check\reports\c11-tests_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\c11-tests_adv_REPORT.md`, with every case by name in `c11-tests_adv_proofs\case-ledger.md`, the cheating change in `green-list-replay.patch` and its own 39 independent cases in `independent-readings.md`.

## 1. Counts seen

1. **By the honest check:** 1,945 ran. 70 fail, every one marked a target; 25 new pass, every one marked a control; the 1,850 older tests all pass; nothing fails outside the five new files. The two failures that drive a window fail the same when run alone.
2. **By the adversarial pass, separately:** 70 fail and 25 pass at the pin; 1,843 of the 1,850 older tests seen passing (the other 7 open saved drawings outside its folders and were left unverified).
3. **Only tests changed:** the five test files and the design page; nothing in the product.
4. **The cheat:** with a deliberately wrong product, all 95 C11 cases passed; 14 older tests then failed, so the wider suite is still a guard, but the list alone is not.

## 2. The control room's rulings on this list (about 12:05 pm by its clock)

1. **D-341 applies to lengths AND worked levels:** nearest tenth of a millimetre first, then half up for display.
2. **The list is split:** the Stage 1 part (Pit, Pipe, cover and grade: about 40 targets) is C11's definition of done now. The Stage 2 targets (pit schedule, Job window, legal point, Detention) stay on the branch marked as waiting and count neither for nor against a Stage 1 merge.
3. **The list is held** until it has a half-up test that a default-rounding printer fails.

## 3. What the Stage 1 list must have before a build is accepted against it

Each is a case where, with the list green, a wrong figure or wording could still reach the plan, or a ruling would be locked in the opposite way.

1. **A wrong expected figure:** `P3_01_Cover_uses_the_worked_invert_before_display_rounding` (`tests/CeCivil.Brain.Tests/AcceptanceC11ChecksTests.cs:80, 81, 93`) demands covers of 291.67 and 295.07 mm. As ruled it must lock 291.7 and 295.1 mm, compared at 0.1 mm.
2. **No test of half-up rounding** (D-341): 1.0049 m shows 1.00 and 1.0050 m shows 1.01; a worked invert of RL 5.125 prints 5.13 on the label. Every midpoint now in the list rounds the same under the computer's default, which would print 5.12: 10 mm wrong.
3. **Three tests reject the ruled label.** `Fix2_P2_A_placed_and_reopened_label_keeps_the_grade_that_was_checked` and both `Fix2_P2_Typed_label_keeps_the_boundary_warning_and_an_ordinary_grade` controls give only the upstream invert and require the label to end at the number (`tests/CeCivil.Hands.Tests/AcceptanceC11DrawingTests.cs:11, 18, 50`). D-236 and D-238 require "MIN." there. A builder who writes the ruled label fails them. Needed: zero, one and two given inverts, the whole drawing text read.
4. **The worked-invert test can be passed for its own numbers only.** `D350_A_worked_invert_prints_to_two_places_but_cover_uses_the_exact_figure` passes at RL 5.147; shift both levels up 3 m (RL 8.147, printed 8.15, ground 8.594, cover 297 mm) and the cheating product says Wrong, 294 mm. D-350 needs "Within the 5 mm tolerance". Needed: the same case at other levels, falls and sizes.
5. **A shortfall can read zero, without a unit, or two ways at once.** `P3_23_...` and `Fix2_P3_Cover_shortfall_...` read a fragment of the warning. The cheating product said "Short by 0 mm" for 299.9 against 300 at no tolerance (right: 0.1 mm), "Short by 0.01" for 294.9 at 5 mm (right: 5.1 mm), and both "10.1 mm" and "0.01" for 289.9 at 10 mm. Needed: the whole warning read, amount, unit and end, at each limit, just inside and 0.1 mm outside, for tolerances 0, 5 and 10.
6. **The grade on the plan can be wrong on a fresh run.** A 20.004 m pipe falling 100 mm is 1 in 200.04; the cheating product rounded the length to 20.00 m, said "Suits" and labelled it 1 in 200. Needed: lengths, falls and sizes the tests do not hard-code, comparing the window, the verdict and the placed and reopened label with figures worked independently.
7. **A typed pit level of 1,000 m or more is lost on reopening.** `P2_39_...` uses one value, 1001.25. Typing RL 1267.25 wrote "1,267.25" with a comma into the pit's note and the reader threw it away: reopened as "Not known", not held. Needed: several levels either side of 1,000 m, the stored number, its source and its hold checked separately.
8. **The Pit window's own depth sum does not add up as shown:** it reads 5.755 less 5.18 is 0.58, where the figures shown give 0.575 (`bench/CeCivil.Bench.Core/windows/pit.csv:60`). The list tests the Pipe sum only. Needed: the visible figures, signs and result of the Pit sum read and added.
9. **Belongs with the label and invert job (A7), noted so it is not lost:** a pit with cover not known puts no cover text on the drawing where D-178 asks for "TBC". The list's only "TBC" test is a Detention row.

## 4. Stage 2 targets (waiting; to fix before those parts reach their own gate)

1. **A reversed expectation in the schedule:** `P6_11_Any_negative_schedule_level_...` (`bench/CeCivil.Bench.Tests/AcceptanceC11WindowTests.cs:61`) requires the depth warning OFF on pit P2, whose outlet is at RL -0.30 m and whose depth depends on it (D-288).
2. **The Detention printed working is tested by a button being enabled and a method by name.** With the button doing nothing and the method returning its own numbers, all thirteen passed; the tile said "Suits" while the document said "Short by -0.01245225 m³" with 12.45 L to spare. Needed: press the real button with a recording printer and read the document it sends.
3. **Twelve of these need a Detention printed working that does not exist yet.**

## 5. Follow-ups (do not hold the list by themselves)

Kept in `FOLLOW_UP\part3-cover-and-grade.md`: the source-text checks can be satisfied by a rename; two controls stay green with their sum broken; loose "contains" checks ("6 mm" matches "16 mm"; "over by 999 l/s" passes); a division test passable by always answering 0.08; tests that call private names; the list of 28 older tests misses about 35 older assertions that expect metres with no unit, and `FactTests.WorkedOutRoundingThroughFact`; no case follows one figure through window, label, reopened check and printed working; no bad-input-then-repaired case in the list (older tests cover it).

## 6. Ruled since (control room, about 12:15 pm by its clock, and D-380)

1. **The tolerance setting:** whole millimetres only, 0 to 20 mm; a typed 2.5 or 99,999 is refused with words (the control room's DRAFT call; Tim's room to confirm).
2. **A length exactly half way at the first step** (1.00495 m) follows half up.
3. **A grade typed as a percentage is not in Stage 1:** grades are 1 in N. Sent to Tim's room.
4. **D-341 (rounding), D-344 (metres refused) and grades at two decimal places are Tim's word now** (D-380), no longer drafts.
5. **A shortfall is measured from the figure needed;** the tolerance only decides pass or fail. A cover shortfall reads "Wrong" and says how short and where (D-140, D-280).
6. **Schedule depth 0.27 beside printed levels 5.62 and 5.36:** with Tim's room for when the schedule returns.

## 7. What held up

The cover limits at 0, 5 and 10 mm tolerance behave at the limit and 0.1 mm either side; the six-storm Boyd's control fails when the inflow stops rounding; the 69 and 70 mm held-orifice controls catch a doubled flow; all 25 controls have a change that makes them fail; every expected figure the honest check worked by hand matched the rulings, apart from item 1 of section 3.


---

# Second answer: codex/c11-tests at ad01f9d (after its first fix round)

**Answer: HOLD THE LIST, narrowly. Four reasons; one fix round left (D-346).** Written Fri 20 Nov 2026, about 3:10 pm. Checked on the bench only. The list is much harder to cheat than at 11c6041: the old cheat that turned 70 of 70 targets green now turns 25 of 67.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\c11b_honest_REPORT.md` (ACCEPT for Stage 1: all eight held items are in and every expected figure, worked by hand, is right). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\c11b_adv_REPORT.md`, proofs in `c11b_adv_proofs\` (a new cheat turned all 67 Stage 1 targets green with all 25 controls, on a product that still labelled a too-flat pipe 1 in 200). Graded here.

## A. Counts seen (both helpers agree; the writer's counts are true)

1,975 ran: 67 Stage 1 targets fail, 33 waiting (Stage 2) targets fail, 25 controls pass, 1,850 older tests pass, 0 skipped. Only tests and the design page changed.

## B. Reasons to hold

1. **Four cases refuse the ruled wording.** `Design_Drawn_grade_and_placed_label_agree_after_the_tenth_mm_step` (`tests/CeCivil.Hands.Tests/AcceptanceC11DrawingTests.cs:332, 362-363, 383`) gives both inverts as MEASURED and reads everything after "1 IN" as a number. D-383 item 9 puts "MIN." on the label unless he TYPED both ends, so a correct build fails these four. Set the source of each end separately; assert the whole label with both measured, one typed and both typed.
2. **The whole shortfall sentence always says "needs 300 mm".** With 450 mm needed the cheating product printed "Short by 5.1 mm at P4 ...: cover 444.9 mm, needs 300 mm." and the list stayed green (`tests/CeCivil.Brain.Tests/AcceptanceC11ChecksTests.cs:182`). A wrong figure in words he reads. Use at least two different covers needed.
3. **A hidden caption passes for the visible cover check.** The D-383 test accepts any text control starting "Cannot check yet", without checking that it shows; a collapsed control passed, and with a real 5.1 mm shortfall no "Wrong" was on show (`bench/CeCivil.Bench.Tests/AcceptanceC11PrintedWorkingTests.cs:123`). Read the cover result shown at each end, before and after a surface is picked: the word, the colour, and that it and its parents are visible (D-140, D-219, D-383 item 7).
4. **A Stage 1 cover verdict is tested only in the waiting group.** Paving of 100.5 mm leaving 294.5 mm must read Wrong; a one-line change made the Pipe check say Suits and all 67 Stage 1 targets stayed green (`P3_35`, `P7_16`: `bench/CeCivil.Bench.Tests/AcceptanceC11WindowTests.cs:112`). Give the slab straight to the Pipe check in a Stage 1 target; leave the Job window's part waiting.

## C. To add in the same round (each is one more row; none holds the list alone)

1. **The fresh-run grade either side of a two-place limit:** 25.0007 m falling 125 mm is 1 in 200.01 (Needs a look); 25.0006 m is 200.00 (Suits); compare the first verdict, the placed label and the reopened verdict.
2. **The worked-invert cover at other levels:** RL 12.430, 8.3 m at 1 in 100, ground 12.794 (297 mm, Suits at 5 mm); and one below zero and one over 1,000.
3. **A pit level EDITED across 1,000 m:** from 1267.25 type 1358.375, OK, reopen: the figure, the hold and "Chosen" all survive.
4. **A drawn length a hair under the half-way point** from ends not at zero (1004.94999999999996 mm shows 1.00).
5. **The Pit depth sum at a second level, both ways** (6.755 less 6.18; 6.18 plus 0.575), and the exact 0.575 behind the 0.58.
6. **The label reads:** the 5.125 test finds "5.13" in ANY text and the missing cover finds "TBC" anywhere; read the named label and its end (shared with the A7 list).

## D. For the build of C11, to write on the list

1. **The Stage 1 gate is run with the filter** `C11=target&Stage!=2` (67) and `C11=control` (25); the 33 waiting targets run and fail, and are counted separately.
2. **Twenty-nine older tests fail on a right product** (they still expect the withdrawn printed-invert rule, metre drawings, or no text for a cover not known): named in `c11b_adv_proofs\wider-failures.md`. The list should name them so the builder corrects them to the ruling and nobody fixes the product back.

## E. For the control room to rule

1. **Two Stage 1 targets lean on later work:** `P3_40` (a job tolerance and a job slab figure: Job-window settings) and the detention row of `P3_25` (D-377 item 1: ordinary pipe only). Mark them waiting, or keep them?
2. **The shortfall sentence** "Short by 3 mm at P3, pipe from P4 to P3: cover 297 mm, needs 300 mm." is the product's own word order (D-280 rules only how short and where; D-350 quotes "3 mm short"). Confirm it once. D-397 also touches it: it names the pipe by its two pits.
3. **"MIN." with both ends MEASURED** (read from the drawing, not typed): read here as "MIN." stays, under D-383 item 9. Say if not.

## F. Follow-ups

`FOLLOW_UP\part3-cover-and-grade.md`: the two weak controls (council arrival; the rounding-source control) and the three source-text guards still pass with their faults in; the tolerance entry (2.5 refused, 99,999 accepted by the Job window: Stage 2, a draft).

## G. Ruled since (control room, about 3:10 pm, D-399, with Tim's D-398)

1. **`P3_40` and the detention row of `P3_25`:** mark them WAITING.
2. **The shortfall sentence, a DRAFT:** "Short by 3 mm at P3, Pipe 7 (P4 to P3): cover 297 mm, needs 300 mm." Tim ruled that every pipe has its own running number, never printed, shown as "Pipe 7 (P1 to P2)". The test holds the figures, the place and the pipe; the word order is a draft.
3. **"MIN." stays** with both ends measured.
4. **D-405 and D-406 (about 4:32 pm): the shortfall sentence is confirmed by Tim.** It is no longer a draft.


---

# Third answer: codex/c11-tests at 335ce64 (its last fix round): HELD, with a one-page open list

**Answer: HOLD THE LIST. It is held now (D-346: two rounds done). The open list is five small, exact items; two of them come from a ruling Tim made AFTER this round was written (D-406), not from a fault of the writer.** Written Fri 20 Nov 2026, about 4:45 pm. Checked on the bench only.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\c11c_honest_REPORT.md` (ACCEPT for Stage 1 with three small items open; it ran the full suite, which the builder had not). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\c11c_adv_REPORT.md`, proofs in `c11c_adv_proofs\` (HOLD; a third cheat, written against this tip, turned all 73 targets green). Graded here.

## H. Counts seen (the builder had only compiled; these are the check's own runs, and the two helpers agree)

1,985 tests: 73 Stage 1 targets (72 fail, 1 passes: see item 5), 25 controls pass, 33 waiting targets run and fail, 4 waiting tests skipped with their reasons, 1,850 older pass. Only test files changed. Every failing target fails on a wrong figure, word or missing label.

## I. What the round closed

All four reasons of the second answer and all six added rows are in (the reverse Pit sum is rightly waiting under D-392; the label read is by name for the cover and by text and end for the inverts). `P3_40` and the detention row of `P3_25` are waiting. The shortfall sentence holds the three figures, the end and the pipe. The two saved cheats, which turned all 67 targets green last round, now leave 13 of 73 red, every one a row from this round.

## J. THE OPEN LIST (one page; nothing else holds the list)

1. **Four expected labels are now wrong against Tim's ruling.** D-406 item 2 (filed 4:32 pm): a WORKED-OUT grade prints to the whole number ("1 IN 95"). The fresh-run and drawn-grade targets expect "… AT 1 IN 200.04" and the like (`tests/CeCivil.Hands.Tests/AcceptanceC11DrawingTests.cs:275-326, 364-375, 427-443`). Restate: the exact grade and the two-place verdict in the window; the whole-number worked grade on the named label; a TYPED grade exactly as typed (D-154). The empty waiting test at `:430` gets its body. Subject to question 1 below.
2. **A 225 pipe's label is expected to read "UPVC SN8" with no material typed,** and the office list has a default for 100 and 150 only (`src/CeCivil.Brain/data/material_by_size.csv`; an older test requires that 225 has none). Type the material in the fixture, or use a 150.
3. **The gate is not written on the list:** Stage 1 is `C11=target&Stage!=2`; controls `C11=control`; the 33 `Stage=2` targets and the 4 skipped are counted apart.
4. **The older tests the build must change are not named.** Twenty-nine older tests failed on the cheating product, but the two helpers agree that does NOT show 29 out-of-date tests: about 17 trace to a ruling that replaces them (D-350, the metre refusal, "MIN.", "CL TBC", D-341, the numbered pipe); the rest are guards that caught the cheat. The adversarial helper has sorted all 29 by name: `c11c_adv_proofs\older-rulings.md`. Put the out-of-date ones on the list with their rulings; the product is never changed back to suit one.
5. **`P3_35_Pipe_cover_of_294_5_mm_is_wrong_with_100_5_mm_of_paving` is marked a target but passes today** (`bench/CeCivil.Bench.Tests/AcceptanceC11WindowTests.cs:130`): relabel it a control (72 targets, 26 controls). In the same edit give the 450 mm requirement to Pipe 7 as well as Pipe 12 (`tests/CeCivil.Brain.Tests/AcceptanceC11ChecksTests.cs:166-210`), and supply what is over the pipe through the step 2 read-off (D-409 item 1), not a step 1 choice.

## K. Not held for, and why (the adversarial helper's other reasons)

A cheat written against this exact tip still turned all 73 green by keying on the listed lengths, levels and pipe numbers (a 26.0007 m pipe said Suits; a level of 1333.375 was lost; cover at RL 17.794 was worked from the rounded invert; the cover rows sat 5,001 pixels outside the window). After two rounds, more rows of the same kind only move the keys. That fault is caught at the BUILD's check, not by a longer list: **when the C11 build is handed over, its honest check runs the adversarial helper's independent probes** (`c11c_adv_proofs\`: 75 cases today, 23 failing on the cheating product) **against the product, and looks for values keyed to the tests.** This is written here so it is not lost.

## L. For the control room

1. **A too-flat pipe would be labelled as if it were at the limit.** 20.004 m falling 100 mm is 1 in 200.04: the check (two places, D-380) says Needs a look, flatter than 1 in 200; under D-406 item 2 the label prints "1 IN 200". Is that what Tim wants, or does a worked grade never print steeper than it is (1 in 200.04 prints "1 IN 201")? One row waits on the answer.
2. **How the list goes forward.** It is held under D-346. Recommended: not a design page: one short, bounded edit of exactly items 1 to 5 (two of them exist only because D-406 came after the round), read back by the check room by reading alone, with no new adversarial pass. Say if you want it otherwise.

## M. Follow-ups

`FOLLOW_UP\part3-cover-and-grade.md` stands: the two weak controls; the three source-text guards; the Pipe working rows against D-393's three decimals when the window is built; the pipe's running number is echoed from the fixture (the numbering job tests it); a detention row among the Stage 1 controls (`AcceptanceC11ChecksTests.cs:346`); the design page's report section still says 1,975 tests and 67 targets.

## N. Ruled since (D-410, Tim, about 4:48 pm): one more item for the open list

6. **A pipe's length MAY be typed** (overturns D-277 DQ-049; the one reader gives one "length used": the typed length if given, else the drawn one). Any target that assumes a length is only ever measured must be restated: the sums (fall, grade, cover along the pipe) use the length used, and the window says which it is. At least one target with a typed length that differs from the drawn one.

## O. Ruled since (control room, about 4:49 pm, D-411): how the list goes forward

1. **The 1 in 200.04 case is NOT ruled; it goes to Tim. DRAFT to close the list:** the check on exact figures says "Needs a look"; the label prints the whole number, half up: "1 IN 200"; the window shows the exact grade beside it ("1 in 200.04"). That test is marked DRAFT.
2. **No design page.** ONE bounded edit of exactly the open list (section J items 1 to 5, and item 6 in section N from D-410), read back by the check room by reading alone, with no new adversarial pass on the list.
3. **Condition, binding on the C11 BUILD:** at that build's check the adversarial probes are run against the product with figures the builder has not seen. No MERGE of that build without them.

## P. Ruled since (D-413, Tim, about 4:59 pm): two more items for the one bounded edit

7. **With "what is over it" not set, the window says NOTHING about cover.** The target `D383_Unknown_surface_and_then_short_cover_show_each_ends_visible_check` (`bench/CeCivil.Bench.Tests/AcceptanceC11PrintedWorkingTests.cs:114`) requires a grey "Cannot check yet" cover line at both ends before a surface is picked: restate its first half (no cover line at all, no figure, no guess); its second half (a surface set: "Wrong" in red, on show, at both ends) stands.
8. **Cover is checked at the TWO ENDS ONLY, plus any surface points he adds; never at a bend by itself.** Any target that demands a cover check at a bend is restated or parked; none was seen in the Stage 1 group at 335ce64, so this is a line for the list, and a thing the read-back looks for.
Also from D-413, for the wording targets: a grey source word on every figure he did not type; a typed length shows "typed 6.50 m, drawn 6.20 m" (with item 6 above).
