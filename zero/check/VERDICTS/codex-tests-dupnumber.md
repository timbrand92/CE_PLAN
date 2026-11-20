# Answer: the duplicate pit number test list, codex/tests-dupnumber-main at 865f14e

**Answer: HOLD THE LIST. Eight reasons, all the list's own (each rests on a ruling up to D-416; where D-421 alone makes a point it is marked and does not count). This is the first answer on this list: fix round one of two follows.** Written Fri 20 Nov 2026, about 8:05 pm. Checked on the bench only.

**Who checked (both finished, both HOLD).** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\dup_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\dup_adv_REPORT.md`, proofs in `dup_adv_proofs\` (a deliberately wrong build passed all 13 cases that run).

## 1. Counts seen

The whole solution builds, the AutoCAD plug-in project included, no warnings. Sixteen cases: 11 targets fail (each on what the product does, not on the test's wiring), 1 case named TARGET already passes (it is a control), 1 control passes, 3 Renumber cases are skipped as WAITING. All older tests pass (two speed tests and one on-screen test pass when run alone). Only tests changed. **The hand-over said "15 targets fail": on main it is 11;** the 15 was counted on the Pit window branch.

## 2. Reasons to hold

1. **A marker built to the ruling fails all three marker targets, and a wrong one passes.** The tests count a marker only when its LAYER's colour is 40 (`DuplicatePitNumberTests.cs:294-299`). D-412 item 1 and D-407 item 2: one layer named CE NO PLOT, grey (colour 8), never recoloured; the marker carries its OWN amber. A second amber no-plot layer passes; the layer's name is never read; a 1 by 2 mm triangle anywhere within 1,500 mm passes. Read the marker's own colour, the layer by name and that it does not plot; size equal to the number's text height (350), one text height clear (D-414 item 5). Mark the three rows DRAFT (D-401, D-412).
2. **The six refusal targets do not test the command.** The test opens the window itself (`:252-260`, `:269-279`) with a call that takes no drawing: two drawings with different numbers in use give the window the same inputs, so no change to the product alone can turn these green, and a builder who feeds the numbers in the TEST leaves PT in AutoCAD still accepting the duplicate. Drive ONE opener in the product that takes the drawing and that the Pit command also calls (name it in the list); if that opener exists only on the Pit window branch, the six rows are WAITING on it and out of the count. Swap only the other pit's tag in the same scene; try two drawings in both orders.
3. **A refusal that closes the window and throws his typing away passes.** All six rows accept Cancel plus a notice (`:15-41`); the product closes the window on Cancel. "Pit P4 is not already used" passes the word check; "Pit P4 is taken. Choose another number." fails it; "P40" satisfies a search for "P4". The window stays open through two refused OKs, every other answer kept, then one corrected OK saves once; the words name the number as a whole word (D-390 item 3).
4. **The number on the sheet can be plain text.** The fixture makes a block reference and sets its general text (`:219-223`); no test sets or reads the attribute PIT_LABEL by name; a new pit whose number was loose Text with no block passed (`:45-87`). Put different numbers in PIT_LABEL, a second attribute, the pit's note and loose text nearby, and prove which one reserves the number; read back PIT LABEL 2 and its named attribute after OK (D-398 item 5, D-404 item 2). If the pretend drawing cannot hold named attributes, that part is WAITING, out of the count, naming the AutoCAD case that proves it; the list stops claiming it.
5. **A hand-edited circle can leave two pits with one number and no marker.** The arrival rows call the end-of-command step themselves with objects they pick (`:113-146`); the real handler returns early on an empty plan: changing a tag from P9 to "4" beside P4 by hand gave no marker. Change only PIT_LABEL on one circle, drive the real end-of-command route, see both pits marked, then correct or erase one and check the survivors; three pits with one number; an unrelated amber mark left alone (D-185, D-390 item 3, D-407 item 4).
6. **"P 4" with a space inside is not tried,** though D-401 item 6 (Tim, D-414 item 4) says pit numbers ignore capitals and spaces and the Pit window verdict named this fault for this list: a build that trims the ends passes every row and writes "P 4" beside P4. Add "P 4", a trailing space, and "p3a" refused when P3A is in use. ("P04" is P4 under D-421 item 3: a later ruling, no strike.)
7. **The Renumber rows cannot be right as written.** All three are skipped; the helper always throws (`:282-283`). The downstream row starts with an unjoined pit already numbered P1, demands P1 for the picked pit AND no two alike, and checks only that the outside pit still exists: renaming the outside pit passes; leaving it alone, as the draft ruling says, can never pass. The uniqueness helper treats "1" and "P1" as different. Use a free P1 for the success case and a separate occupied-P1 case (see section 4 item 1); compare every outside pit before and after; compare numbers in their one written form. (The joined-only rule, the fork tie-break and the pit being placed are D-421's draft: mark those rows DRAFT D-421; they add no strike.)
8. **A report file is in the commit** (`tests/CeCivil.Hands.Tests/reports/DUPNUMBER_TESTS_REPORT.md`): it names a local workshop path and says things no longer true. Out of the commit.

## 3. To fix in the same round

Rename the passing "target" at `:44-56` a CONTROL; a number over 99 and a letter suffix as the number in use; a number freed by erasing and taken back by Undo; editing the SECOND of two old duplicates, or a pipe joined to either (D-401 item 5); the command line saying it too and an erased marker coming back, never on opening (D-407 item 4); a marker beside a pit on a locked layer (D-348, D-422).

## 4. For the control room (no ruling found)

1. **Renumber when a pit OUTSIDE the joined ones already holds the number:** refuse and name that pit (recommended, the same as a locked pit in the way), take the next free number, or go ahead with the marker on both?
2. **A pit pasted in from another drawing whose number is in use here:** the next free number, as COPY does (recommended), or keep it with the marker on both?
3. **A pit on a LOCKED layer:** does its number count as in use (recommended yes; D-421 names off and frozen only)?
4. **What a refusal leaves in the window:** the window open, the number box red with "P4 is already used by another pit", every other answer kept (recommended)?

## 5. Owed in AutoCAD

The attribute PIT_LABEL really read and compared on a real PIT LABEL 2; the refusal through the PT command itself; the marker on the real CE NO PLOT layer and that it does not plot; one Undo.
