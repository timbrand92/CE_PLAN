# Answer: the edit-doorway tests added for today's rulings, codex/doorway at b93d093

**Answer: HOLD THE LIST. First round; fix round one of two follows.** Written Sat 21 Nov 2026, about 1:09 am. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\doorway_honest_REPORT.md`: ACCEPT (figures 9.55, 10.55, 7.78 and 4.00 m right; it named the weak label checks as follow-ups). Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\doorway_adv_REPORT.md`, proofs in `doorway_adv_proofs\`: HOLD: four lines that moved every pipe label to (50 m, 50 m) on STRETCH, TRIM and EXTEND turned three targets green. On a first round a cheap wrong build a drafter would see is a reason to hold. Counts true: 14 doorway targets, 13 red, 1 control green; the whole solution builds; no report or run file; nothing older broken.

## 1. Reasons to hold

1. **A label anywhere passes** (both halves saw it; the adversarial build proved it): the STRETCH, TRIM and EXTEND targets (`tests/CeCivil.Hands.Tests/DoorwayRulingsTests.cs:141, 243, 263`) ask only that the label's anchor changed. Check its distance from the pipe and its place along it after the edit (D-361, D-413 items 11 and 13), and that other text (a sleeve note) did not move.
2. **A correct EXPLODE can fail:** `:22` demands the original pipe's handle be gone and `:23-25` look only at new handles; D-376 asks for ordinary pieces that look the same, which a correct result may make by reusing an existing entity. Check what is drawn, not which handles.
3. **A draft is used as a gate:** `:196-205` (and `tests/DOORWAY_AUTOCAD_PROOF.md:27`) require a new pipe after the highest is erased to take a higher number; D-398 item 2 and TR-119 leave reuse unasked. Mark it WAITING for Tim (see section 3).
4. **Erasure can take other drawing content and pass:** `:83-116` start with only a diameter label (the invert texts and arrow switched off), and `:116` demands that NO text anywhere holds "DIA.", so a build that erases a neighbour's label passes. Erase one pipe beside another and check the neighbour keeps every text (D-377 item 6, D-348).
5. **No protected neighbour in any edit row:** the offer and edit rows (`DOORWAY_AUTOCAD_PROOF.md:25-26, 33-38`) have no locked, off, frozen or xref participant (D-348).
6. **The passing control can reject unchanged behaviour:** `DoorwayCommandOutput.cs:28-43, 69-78` compile the hook against a stand-in observer; moving one expression into a property of the real observer, with the same meaning, broke it.

## 2. Same round

The hand-over names MIRROR, whole-plan move, JOIN, FILLET, OFFSET, U while drawing, double-click and the downstream offer reach, but none of them is in the test file: add them or take them off the claim (D-413: BREAK gives two pipes; JOIN and FILLET at 0 give one; a rounded fillet is refused; OFFSET gives a loose pipe); EXPLODE accepts a duplicate stacked text; BREAK and PEDIT do not check the one-line command message; the two-pipes case puts the second pipe exactly on the first.

## 3. For the control room (no ruling found)

1. **Is a pipe's number reused once the highest-numbered pipe is erased?** D-398 calls "never reused" the room's reading, not Tim's; D-377 item 2 for pits (highest plus one) would reuse it. Recommended: never reused within a drawing (a number on an issued sheet keeps its meaning).

## 4. Ruled since (control room, about 1:11 am, DRAFT, listed for Tim)

A pipe's number is never reused within a drawing, even when the highest-numbered pipe is erased (it is an identity, never printed); an Undo of the erase brings the same pipe back with its same number. Pits stay as Tim ruled (highest plus one). Reason 3 of section 1 is restated to this and marked DRAFT; it adds no strike.
