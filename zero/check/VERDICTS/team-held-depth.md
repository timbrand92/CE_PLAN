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


---

# Final verdict: team/held-depth at d5154a7 (its LAST fix round)

**Verdict: HOLD, with the one-page open list below. This was the second and last round from the D-416 baseline: under D-346 the branch is now HELD, not sent round again; the control room decides what happens to it.** Written Fri 20 Nov 2026, about 9:15 pm. Checked on the bench only.

**Who checked.** Honest check: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\hd3_honest_REPORT.md`: HOLD on one blocker (original 2), the other three closed. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\hd3_adv_REPORT.md`, proofs and its own open list in `hd3_adv_proofs\` (`OPEN_LIST.md`, `verified-observations.txt`): HOLD, three of the four originals still reproduce, seven new. The build is clean; the plug-in compiles; the suite is green apart from two speed tests that fail on main too.

## 11. The open list

**This branch's own (the four from cea5567, and what this round added):**
1. **Original 1, still open: an old worked "CL 6.50" stays on the plan** after the depth is let go (no typed cover; OK twice; the note has no cover; D-392 wants "CL TBC"; nothing is said about the stale text). `PitTool.cs:286`.
2. **Original 2, still open (both halves): his own cover text is overwritten.** He retypes "CL 7.77"; changing only the pit's kind in the window puts "CL 6.50" back; "CL 7.77 CHECK" loses its words with no marker; and a plain OK leaves the window and the note saying 6.50 while the plan says 7.77 (D-402: the retyped number SETS the cover). `PitTool.cs:155, 279, 290`.
3. **Original 3, still open: the COVER padlock saves a worked level as his:** on a legacy pit (outlet 9.505, depth 0.995, no typed cover) the cover reads 10.51; clicking the cover's padlock writes 10.51 to the note and the plan (the sum is exactly 10.500). The round tested the depth padlock only. `WindowModel.cs:955, 1276`, `ToolWindow.cs:148`.
4. **New: the depth comes from the FIRST outlet drawn, not the lowest** (cover 12.00, outlets 10.80 then 10.50: 1.20 shown, 1.50 due; a known first outlet hides an unknown second). D-406 item 8, D-421. `PitTool.cs:699, 705`, `ToolWindow.cs:26`.
5. **New: the window uses the junction sump for every kind** (a test 0.30 grated sump: 0.62 shown, 0.92 due; deleting the grated row changes nothing). `sums.csv:10-11`, `ToolWindow.cs:85`.
6. **New: an unusable sump gives a confident depth** (−0.30 or 1,000,000 shows 0.32 or 1,000,000.62). D-425: refused in words. `sums.csv:9-10`, `pit_sumps.csv:5`.
7. **New: a held depth survives other edits:** a copied or pasted legacy pit keeps 1.23 held; a cover changed through the Run window keeps the old depth with no words. D-387, D-392. `HiddenNotes.cs:148`, `RunToolWindow.cs:139`.

**Found here, but owned by other jobs (they hold THIS branch only if it makes them worse; each goes to its owner):**
8. **Rounding:** "CL 12.345" printed for 12.345, and depth 0.995 shown 0.99 (the exact-rounding branch, its blockers 2 and 6; D-432's order: no routine before its MERGE).
9. **Protected layers:** an edit on a pit whose layer or text layer is OFF or FROZEN goes through (locked refuses). D-348; the drawing-safety job.
10. **Units:** a drawing in feet or centimetres takes the edit; the host asks for the pick and opens the window before the check. D-403; the units doorway (the binding test of D-431).

## 12. What closed this round

Depth is never typed in Stage 1 (the paths are gone, not patched); a lone pit keeps its typed cover; the two rounding cases on the depth padlock; the metre refusal, unset-is-millimetres and the decimal comma kept.

## 13. For the control room

The branch is held. Items 1 to 7 are its own; 4 to 6 overlap the Pit window branch (part B), which also changes depth to the lowest outlet plus a sump. Recommended: fold items 4 to 6 into ONE depth sum owned by one branch (one code path, design rule 1), and let this branch close only 1, 2, 3 and 7.
