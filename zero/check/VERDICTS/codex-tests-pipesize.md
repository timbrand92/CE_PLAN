# Answer: the pipe-size test list, codex/tests-pipesize-main at 6d49ad4

**Answer: HOLD THE LIST. Eleven reasons, all the list's own (each rests on a ruling up to D-414). This is the first answer on this list on the main line: fix round one of two follows.** Written Fri 20 Nov 2026, about 8:20 pm. Checked on the bench only. (The earlier tip 110c436 was sent back unchecked at the compile gate.)

**Who checked (both finished, both HOLD).** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\ps_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\ps_adv_REPORT.md`, proofs in `ps_adv_proofs\` (a shortcut build turned 22 of the 56 targets green with real drafting faults left in; 14 examples of its own).

## 1. Counts seen (the writer's counts are true)

The whole solution builds, the AutoCAD plug-in project included, no warnings. 57 cases: Part A 38 (1 control passes, 37 targets fail), Part B 19 targets fail. Seven are marked WAITING on A6's command route. No case is marked DRAFT. Every target that reaches its point fails on what the product does. Only tests changed. Older tests: all pass except speed and on-screen tests that time out on tonight's loaded PC, on code this branch does not touch. The writer's own report in the branch says the commit is "pending": it is stale.

## 2. Reasons to hold

Line numbers: A is `tests/CeCivil.Hands.Tests/PipeSizePartATests.cs`, B is `PipeSizePartBTests.cs`.

1. **A marker built to the ruling fails twelve targets, and stray text passes eight.** A:690-694 counts a marker by its LAYER's colour 40; D-412 and D-407 keep CE NO PLOT grey with the amber on the marker itself. Ordinary text on another amber no-plot layer was accepted. B:558-570 cannot see the marker's colour, its pipe or its reason. Read the marker's own colour, layer by name, owner and reason; two faults on one pipe, then one cured; a neighbour's marker left alone. Mark those rows DRAFT (D-412).
2. **A wrong instruction on the printed label passes.** A:18-27 and 508-516 check only how the label starts: "... INSTALL 450 DIA." added after the right words passed the 100 mm target and the 150 mm control. Compare the whole label, material, grade and punctuation, for a free pipe, an edit and a run (D-380, D-413 items 3 and 9).
3. **One test forces a wrong figure onto the sheet.** A:343 and 352: a pipe typed 225, its hold removed and its band drawn 230, must keep "225 DIA." after an untouched OK. D-389 item 2: the plan never carries a label that disagrees with the pipe; D-390 (Tim): shown as drawn. It must read "230 DIA." (material TBC where the office list has no 230: DRAFT), with the marker.
4. **A saved label can be lost.** The unreadable-band cases start from a fresh tool-made label (A:261-296); a hand-edited label is protected only in Pipe (A:299-318), not through Levels (A:478-504). A build that rewrites every label passed: an older label became "TBC DIA. TBC PIPE" and a hand-written instruction was replaced. Use an older unreadable band with readable words, and a hand-edited label through Levels; the exact old words after OK and after Undo (D-406 item 1).
5. **"Cannot check yet" is demanded where Tim ruled silence.** A:295, all six unreadable-band cases, want those words on a pipe whose "what is over it" is not set; D-413 item 2: the window then says nothing about cover. Any other grey line satisfies the check as written. Test the real case: over-it set, size unreadable.
6. **The polyline target types a keyword the ruled prompt does not offer.** A:165-168, B:244-246 and the test host (`Fake/CommandHost.cs:195-198, 221-228`) inject "Select" where the prompt offers only Polyline: a correct build cannot reach those assertions, and a hidden Select route passes. Send P, check the keyword was offered, and read the original path back on Cancel (D-410 items 5 and 9).
7. **A pipe extended from its loose end has no case** (D-410 item 2: one pipe, one label, one number, a bend where the parts meet). Both halves found it missing; on the bench today a run from a loose end added no length to the pipe. A target, marked WAITING on the start-on-a-pipe build if that is where it belongs.
8. **The one reader of the drawn pipe is not proven where it matters.** No case has a tapered band (225 to 375), a width read from the first length only, or two branches whose stored and drawn sizes disagree at a junction (D-349, D-384 item 1; the design page's tests 14, 25, 31; the same fault held the earlier rounds). The pretend drawing keeps one width for a whole pipe, so say plainly what is proven here and put the rest on the owed list by name.
9. **A typed size or length can come back after he clears it; a picked path can be lost.** A:565-580 removes the size from the fixture, never through the window; B:393-407 never reopens after a cleared length (the reviewer's case found the old hold still there); B:297-327 never tries Yes then Cancel on a picked path. Clear, save, reopen, edit again; Yes then Cancel against the original path, joins, numbers, labels and markers (D-379, D-410, D-413).
10. **The wrong pipe can change.** B:237-258 draws two pipes between the same pits, reads their titles and cancels (B:593): a build that saves by pit names changes the first pipe when he edits the second. Save 300 on the second after renaming a pit; read both pipes before and after Undo (D-398 item 2).
11. **Counts that cannot come true, and previews that break on the approved panel.** Four counted targets cannot go green on a right pipe-size build (among them A:117, a pipe continuing off a 375 main: the design page keeps that refusal for this build): WAITING, out of the count. The preview checks (A:155-156, 183; B:307, 313, 475-477) count EVERY band in the panel where A6's panel shows only the new parts.

## 3. To fix in the same round

1. **The drawing's own default pipe is never tried** (always the office 100): two drawings, one with 225 RCP 1 in 80 saved; a damaged setting invents no size. Mark WAITING on the settings store until it merges (D-414 items 1 and 3; D-425).
2. **Whole words and the right part:** the cover shortfall names its end and its pipe number (A:380-382 checks two fragments); the grey source word belongs to its own figure (A:665-672 accepts it anywhere); the shortfall example follows D-426 item 1.
3. **Stages kept apart:** the three end-symbol cases (A:97-112) are Stage 2; the two existing-pipe Yes or No cases (B:155-180) are the edit doorway's; mark the rows that rest on drafts DRAFT (none is marked today).
4. **The stale report out of the commit;** one squashed commit.

## 4. For the control room (no ruling found)

1. **The grey word beside a size worked from the pipe running in:** "follows Pipe 9 (P4 to P1)" (recommended, as D-413 item 14) or "biggest arriving at P1"; and for a pipe already drawn, "measured"?
2. **An older pipe drawn before pipes had numbers:** the next free number when first opened (recommended), or none until edited?
3. **An older joined pipe with no flow direction recorded:** does it count as arriving at a pit?
4. **Accepting the offered office size (225 for a pipe drawn 230):** does that become his typed size, held (the tests assume yes)?
5. **OK on a run without answering the "bump them" offer (D-410 item 3):** the same as No (the tests assume yes)?

## 5. Owed in AutoCAD

The real band's width on every length of a pipe and after a move; one Undo for each joint edit; the picked polyline really turned into the pipe and put back on Cancel; the marker on the real layer; the label's real words on the sheet.

## 6. Ruled since (control room, 8:19 pm, D-430, DRAFT)

1. **The grey word:** "follows Pipe 9 (P4 to P1)"; "measured" for a pipe already drawn whose size was read off the drawing.
2. **An older pipe gets the next free number at the first edit that writes it** (on OK), inside that edit's one unit; never on opening.
3. **No flow direction recorded:** from the higher to the lower end level where both are known; otherwise it does not count as arriving and the window says grey "flow direction not known"; nothing is guessed.
4. **Accepting the offered office size makes it his,** held as typed.
5. **OK without answering the bump offer is No:** the lengths stay, with the marker.
The rows that rest on these are marked DRAFT D-430; they came after the round and add no strike.


---

# Second answer: codex/tests-pipesize-main at c6b1f42

**Answer: HOLD THE LIST, on ONE reason, the list's own; round one of two from its baseline, so one round is left.** Written Fri 20 Nov 2026, about 11:10 pm. Checked on the bench only.

**Who checked, and how they split.** Honest check: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\ps2_honest_REPORT.md`: ACCEPT, all eleven closed, seven binding probes. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\ps2_adv_REPORT.md`, proofs in `ps2_adv_proofs\`: HOLD, eight closed and three PARTLY. Both saved shortcut builds now fail all 70 runnable targets. The check room read the test helper behind the disputed keyword itself (`PipeSizePartATests.cs:1044-1058`).

## 7. The reason to hold

1. **Two edit cases cannot pass on a right build.** The edit helper, when the pipe is not picked first, sends the keyword "Select" after the command starts (`PipeSizePartATests.cs:1048-1058`, used by A283 and B275), while A594-609 itself proves the ruled prompt rejects "Select" (D-410 items 5 and 9: the prompt offers Polyline). Pick the existing pipe through the ruled prompt (an object pick, or P for a path) and again by preselection; keep the rejected "Select" only as a negative control. Proof: `ps2_adv_proofs\ruled-prompt.patch`, `ReviewProbes.cs.txt`.

## 8. To fix in the same round (the other two PARTLY points; not holds alone)

1. **The marker's own colour** cannot be read on the pretend drawing: a colour NOTE satisfies the amber check on a grey triangle. Keep the colour row WAITING, out of the count, and name the AutoCAD case that proves colour 40 on the marker over the grey layer.
2. **Every piece of a band:** the taper and first-piece cases are a search of the adapter's source for method names (A827-837), which a build can dodge; say plainly on the row that the real taper is owed in AutoCAD, named.
3. **The rows that wait on other branches are still counted** (A190 x4, B17, B408 x2, B415, B585, the flow-arrow row, the two end-symbol rows): exclude them from the count by their trait; mark B253 (it needs A6's Polyline prompt).
4. **The cover sentence at A432** works the top of pipe without the wall: mark it DRAFT D-426 and restate when U-086 closes.
5. **One squashed commit;** one test host shared with A6.

## 9. What closed

The whole label compared; the 230 mm band keeps 230 with its marker; saved and hand-edited words kept through OK, Levels and Undo; silence about cover where nothing is over it; the loose-end extension (WAITING); clear, reopen and cancel; the wrong pipe of two; the impossible counts out; and the D-430 rows (source words, the older pipe's number, unknown flow, the accepted office size, the unanswered bump).
