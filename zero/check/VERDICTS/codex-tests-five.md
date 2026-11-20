# Verdict: the test list for the five smaller Stage 1 pieces, branch codex/tests-five pinned at b23d46f (tests only)

**Verdict: HOLD THE LIST.** Written Fri 20 Nov 2026, about 2:10 pm, by the check room. A verdict on a list of tests, not on a build. Checked on the bench.

**What the list is.** The failing tests that define "done" for the five pieces the edit doorway does not close (D-348): a hand-written pipe label kept through a resize; the trim of a pipe to a pit's inner wall, with scaled pits; a branch that folds back on itself; a pipe name already taken; and moved lettering in the Pipe window's preview. Schedule holds, the Stage 2 piece, is rightly not in it.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\tests-five_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\tests-five_adv_REPORT.md`, proofs in `tests-five_adv_proofs\` (the change that turned the list green is `green.patch`; what the drawing then did is in `OBSERVATIONS.md`).

## 1. Counts seen

1. **By the honest check, full suite:** brain 750 passed; reader 19 passed, 2 skipped (main's own); hands 681 passed, 6 failed, exactly the six drawing targets, for the right reasons; bench 438 passed and 3 failed, the three new window tests, all for the WRONG reason (a thread error).
2. **The claim "everything older still passes" is false.** Run with the rest of the bench, the new window test class either fails itself or makes four older window tests fail, depending on which starts first; without the new class the bench passes 438 of 438 three times running. Run alone, the new class gives 2 targets failing and 1 control passing, as claimed.
3. **Only tests changed;** nothing in the product.
4. **The cheat:** the adversarial pass turned all 17 green with a few lines of special cases; on that version 26 of its 35 independent checks still failed.

## 2. What the list must have before a build is accepted against it

1. **One window thread for the bench.** The new class borrows another class's window thread and so makes a second one (`bench/CeCivil.Bench.Tests/Stage1DoorwayGapPreviewTests.cs:13-14`). Both classes must share one, and three whole-suite runs must show only the two window targets failing.
2. **The hand-written label test must ask for more than one sentence surviving one resize** (`tests/CeCivil.Hands.Tests/Stage1DoorwayGapDrawingTests.cs:12-28`). A one-line exception for its own sentence passes it. Today, a tool label whose words the drafter then edits ("RETAIN EXISTING OUTLET") is replaced by a resize, a regrade or a change of side; a copied pipe's label is overwritten too. And nothing asks for the flag: D-182 and D-103 keep his wording and flag it; D-385 makes the flag the small amber marker that never plots, with the window saying the same and one click to follow again. Needed: edit only the words of a tool label, save and reopen, change the pipe three ways, check the words held and the marker set, release once, change again; and a wording that still matches, to check there is no false warning.
3. **The branch tests rest on a join the test writes itself** (`Stage1DoorwayGapDrawingTests.cs:303-320`). The product saves no join when a branch is drawn onto a main; the test writes a one-sided one so its control can pass. Under D-374 (a run ending on a pipe joins it part way) and D-340 (every join written on both parts) the test must draw the branch with the pipe tool and assert the join is saved on both parts: a new failing target.
4. **The wall tests use exact equality and one face of one square pit** (`Stage1DoorwayGapDrawingTests.cs:89-129, 271, 274`). A correct answer 0.04 mm away is rejected, against D-341 (within a tenth of a millimetre is the same point; Tim's word in D-380); and the cheat recognised the test's own dimensions. With the list green: at scale 1.5 an angled entry misses the wall by 161.6 mm and a corner by 212.1 mm; a second pipe on the same wall is left 250 mm inside; a pipe wholly inside a pit gets a join 300 mm short of any wall; a pit widened after a correct drop leaves the end 225 mm inside. Needed: other faces, turned pits, angled entries, two pipes on a wall, widening and shrinking, compared to a wall worked out independently, to a tenth of a millimetre.
5. **Nothing checks the label's "MIN."** The label controls feed in finished wording with both inverts given. Through the real window, with no invert or one invert typed, the drawing prints "150 DIA. UPVC SN8 PIPE AT 1 IN 100": D-238 and D-383 item 9 need "MIN.". This belongs to the label job (A7), but an existing test outside this list already expects the label WITHOUT "MIN." (`tests/CeCivil.Hands.Tests/PipeWindowFromDrawingTests.cs:212`): it must be corrected there, or a builder following the ruling is told to take "MIN." off again.

## 3. No ruling (for Tim's room)

**A second pipe between the same two pits** ("P1 to P2" already exists and another is drawn between them). The test catches the silent mismatch without saying what the name should be, which is right: nobody has ruled it. Question for Tim, with the honest report's wording and recommendation (its section 5).

## 4. Follow-ups

In the two reports: "large corners", "text height and scale" and "a label turning with its pipe" sit in the same geometry group of the doorway design and have no test here; the occupied-name target's weak spot; the remaining adversarial cases (the rest of its section 1 and its section 2).
