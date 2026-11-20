# Verdict: team/held-depth at cea5567 (a held pit depth; the stale cover text; metres refused)

**Verdict: HOLD. Four blockers, all from one cause: the branch now writes a WORKED-OUT cover level on the plan.** Written Fri 20 Nov 2026, about 2:50 pm, by the check room. Checked on the bench only. The first tip (6c9bc07) was checked but given no verdict because the branch was still moving; this is the branch's first verdict, so one fix round is left before it is held (D-346).

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\held-depth2_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\held-depth2_adv_REPORT.md`, proofs in `held-depth2_adv_tests\`. They agree.

## 1. Suite seen

Brain 750, hands 699, bench 438, saved-drawing reader 19 passed and 2 skipped (main's own): 1,906 passed, 0 failed. Main is fully in. No test was removed; eight metre cases were taken out of older tests and five moved to centimetres, which is right now that metres are refused.

## 2. What works (each test fails when its fix is taken out)

1. **A typed depth is kept** on OK and reopen, through a second OK and an edit.
2. **The two stale-cover cases the check room reported are fixed:** the plan now reads CL 6.50 and CL 10.80.
3. **A metre drawing is refused by ONE shared check** for Pit, Pipe, the legal point and the long section, saying why, with nothing brought in or drawn (D-344, D-380). Millimetres, unitless and inches behave as before.
4. **The earlier findings:** a note holding both cover and depth follows D-387 (a new cover keeps the invert 9.60, depth becomes a worked 1.05) with Tim's own words; the 150 mm clash shows in the Pit window; a level or depth of 1,000 and over survives in a pit's note; the padlock that did nothing is off.
5. **The builder's restated test (M2) is right** under D-350.

## 3. Blockers

1. **A worked-out cover drawn on the plan goes stale when the pipe under it changes** (a wrong figure on the plan). P3 with a held depth of 2.00 over a leaving invert of 4.50: OK draws "CL 6.50". Regrade the pipe's end to 4.25 in the Pipe window: the plan still reads CL 6.50 while the pit's own figure is 6.25. Move or erase the pipe: CL 6.50 stays while the pit reads "Not known". The other way round, a pipe joined later leaves the ticked cover text missing. No word is said (`src/CeCivil.Hands/Pit/PitTool.cs:353`; `bench/CeCivil.Bench.Core/ToolWindow.cs:150-157`; the Pipe tool never touches a joined pit's cover text). On main a worked cover was never drawn. Found by both helpers.
2. **Pit OK overwrites the drafter's own text** (drawing content lost). On such a pit he edits the text to "CL 7.77"; opening the Pit window and pressing OK with nothing changed replaces it with CL 6.50, with no marker. If he erased the cover text by hand, OK draws it again. Both earlier versions left his text alone. D-377 item 6 (text erased by hand stays gone), screen rule 26, D-182.
3. **A rounding step puts a wrong level on the plan.** Leaving invert 9.505 and depth 0.995 make exactly 10.500; the window shows 10.51 and OK writes "CL 10.51"; clicking the cover's padlock then saves 10.51 as his choice and changes the depth. Invert 8.50495 with depth 1.00 writes "CL 9.50" where D-341 gives 9.51 (a tenth of a millimetre first, then half up).
4. **Typing a depth on a pit with no pipe out wipes the cover he typed, from the pit and now from the plan.** P5 placed at cover 10.50, "CL 10.50" on the plan; type depth 0.90, OK: the plan reads "CL TBC" (`PitTool.cs:268-271`; a test locks it in, `tests/CeCivil.Hands.Tests/HeldDepthTests.cs:205`). The window says so in words, but a figure he typed is gone; on main the plan kept it.

## 4. What the one remaining round should do

1. **Draw on the plan only a cover the drafter holds;** a worked-out cover stays in the window (or, if the control room rules that it is drawn, every edit that changes it rewrites it in the same Undo and says so, with D-341's rounding).
2. **Never overwrite or redraw text he edited or erased by hand.**
3. **With no pipe out, keep both the cover and the depth he typed** (the invert is then the worked figure), and correct the test at `HeldDepthTests.cs:205`.
4. **Failing tests first** for each: the regrade, the move and the erase of the pipe; the hand-edited and the hand-erased cover text; the two rounding cases; cover then depth on a lone pit.

## 5. For the control room to rule

1. **A held depth and a NEW INVERT** (the pipe is regraded): does the cover move or does the depth give way? D-387 rules only a new cover.
2. **A NEW DEPTH on a pit holding both cover and depth:** the builder keeps the invert and lets the cover follow, saying so. Not ruled; D-078 protects a typed cover.
3. **The Pit window Tim approved (D-386) has no depth box.** How much of this branch does that window keep? The metre refusal, the comma fix and the stale-cover fix stand on their own; the depth holding may not be reachable from the approved window at all.

## 6. Follow-ups

In the two reports and `FOLLOW_UP\part2-pit-and-pipe.md`: a copied pit's cover worked from an assumed level is written without "APPROX."; the clash line can name the wrong pit, and a 5 mm gap is left out at zero tolerance; the grade's words ("1 in 167") disagree with its check (C11's); the Pipe tool still writes "1,267.25" with a comma and the levels window cannot read it; "CL TBC" on the plan against "CL Not known" in the change preview; the schedule prints 0.99 for a depth of 0.995 (Stage 2).

## 7. Owed in AutoCAD (after the fix)

The nine steps of the honest report's section on the first tip stand, with: regrade, move and erase the leaving pipe and read the cover text each time; edit and erase the cover text by hand, then Pit OK; a metre drawing refused by PT, PP and CD with nothing brought in; one Undo for each.

## 8. Ruled since (control room, 20 Nov, D-392)

The three questions of section 5 are ruled as D-392: in Stage 1 a pit depth is never held and never typed (the approved window has no depth box); the cover is what he types, the invert comes from the pipes, the depth is always worked out; a new invert moves the depth, never the cover; an older held depth is let go at the first edit with the words of D-387; the cover on the plan is only the typed cover or "TBC", never a worked-out one. The next tip is checked against D-392.

## 9. Ruled since (D-402, Tim, about 3:36 pm)

Retyping a cover level text on the plan SETS the pit's level (cover only). Blocker 2 is to be read with this: a hand-edited "CL 7.77" is no longer just kept, it becomes the pit's typed cover; Pit OK must never put the old figure back over it. Text erased by hand still stays gone (D-377 item 6).

## 10. Ruled since (D-405 and D-406, Tim, about 4:32 pm): D-392 is NOT confirmed as written

Tim: "FOR SILT PITS THE DEPTH IS DEEPERE THAN THE LOWEST OUTLET". The depth must be worked as cover less the lowest outlet invert PLUS A SUMP VALUE (0 in Stage 1), and not hard-wired. The fix round is checked against that: depth still never held or typed in Stage 1, but the sum carries the sump figure as a value that can change, and no test or code may assume depth equals cover less invert for every pit.
