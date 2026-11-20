# Answer: the units doorway test list (which drawings the tools work in), codex/tests-units at fea2222

**Answer: HOLD THE LIST. Five reasons.** Written Fri 20 Nov 2026, about 3:45 pm, by the check room. Checked on the bench only. First answer on this list.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\units_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\units_adv_REPORT.md`, proofs in `units_adv_proofs\` (a two-file cheat turned all 690 tests green; on a drawing the tests do not use, a pit was still placed in an inch and a metre drawing). They agree on the two main gaps; graded here.

## 1. Counts seen (the writer's counts are true)

Pretend drawing 690 ran: 16 targets fail, the millimetre control passes, 673 older pass, 0 skipped; brain 750 and bench 438 pass; the saved-drawing reader 19 pass, 2 skipped (main's own). Only test files changed; no run log in the commit. Every target fails because the product draws where it should refuse, or says nothing. The file is `tests/CeCivil.Hands.Tests/DrawingUnitsDoorwayTests.cs`.

## 2. Reasons to hold

1. **No case for a drawing in FEET** (lines 17-27 cover inches and metres only). Tim, TR-089 (filed in D-390 item 6): "inches or feet are refused like metres". A fix refusing only inches and metres turns the list green and a feet drawing still gets pits and pipes; the cheat drew a pipe there.
2. **No case for CHANGING an existing part in a refused drawing** (every refusal row starts a new part: 31-35, 140-167). With the units changed to metres after a pipe exists, Select and select-first both rewrote its width from 150 to 0.225 drawing units. If the fix also drops the metre conversion, an edit writes millimetre figures into a metre drawing: a 450 pit 450 m wide. Add Select on an existing pit and pipe, in a metre, inch and feet drawing: refused, the part and its records exactly as before.
3. **A refused command can still change the drawing unseen** (40-47 compare object numbers, some write calls, new layers and named imports). With the list green an existing pit went from 450 to 600 mm during the refusal, and a hidden record was written at command start: the copied test host does not log block-distance changes (`tests/CeCivil.Hands.Tests/Fake/CommandHost.cs:277`) and replaces the start-up step with nothing (`:222`). D-344, D-380: the release "does nothing"; D-381. Compare sizes, records, layer settings and block definitions before and after, and log every write, start-up included.
4. **The rows are keyed to one pretend drawing, and the refusal comes late.** Every refusal row uses the same numbered drawing with one pipe in it: a guard that recognises it passed everything, and a bare drawing with an ordinary identity took a pit, two layers and the office setup. The tests also let the click, the window and OK happen before the refusal (only the levels-along-a-run window must stay shut). Use bare and populated drawings; assert nothing was asked for and no window opened (subject to question 2).
5. **The "said once" targets may require the wrong thing** (lines 69, 87 demand NO line in the second window). Tim picked "Treat as millimetres, say so once"; his room's record of TR-089 reads one grey line in each window. With the list green the second Pipe window is blank. Question 1; mark the two targets waiting until it is ruled.

## 3. To fix in the same round

1. **The refusal words can say the opposite:** "metres only." and "Inches are supported. Only pipes can be drawn." pass the matcher (38, 243-244). Require the unit named AND that it is not supported.
2. **The control accepts a 450 by 600 pit** (line 207 takes any one distance of 450) and uses only the default scale: assert both sides, and one millimetre drawing at another dimension scale. Add CD, the levels window and the plastic preset (PP) in millimetres.
3. **Layout sheet and read-only drawing** (D-390: PT or CD on a layout sheet refused with words; a read-only drawing said before the first click, nothing drawn) have no test in this list or any other found: both commands took clicks, opened a window and made objects. Add them here, or name the list that carries them.
4. **Name the older tests that say the opposite,** so the builder corrects them to the ruling: `PitRollbackAndUnitsTests.cs:130` (inches, feet, metres and centimetres drawn), `PitSizeUnitsTests` inch and metre cases, `PipeToolTests.cs:298`.
5. **The copied test host** (`Fake/CommandHost.cs`) drops `PolylineHasArcs`, which A6 needs, always answers "nothing selected" to a pick-first, and must be joined with A6's copy by hand. Leave `TESTS_REPORT.md` off the main line.
6. **Scope:** the legal point is Stage 2 and the plotted long section is parked; keep the levels-along-a-run case (Stage 1, D-383 item 8), and do not make the other two Stage 1 conditions.

## 4. For the control room (no ruling found)

1. **"Say so once":** the grey line in EVERY window of a drawing with no units set, or in the first window only?
2. **When the refusal comes** in a metre, inch or feet drawing: before the first click (as the read-only drawing), or on OK?
3. **Every other unit** (centimetres, decimetres, yards and the rest): refused the same way, naming the unit?
4. **The units change while a Pit or Pipe window is open:** does OK close it, leave the drawing alone and say why?
5. **A command with no window:** where and how often is "treated as millimetres" said?

## 5. Owed in AutoCAD (when a build of this is merged)

The real reader: with the native units reader made to answer millimetres for every drawing, all 690 tests still passed, and on the bench a 150 pipe came out 150 m wide; nothing on the bench reads AutoCAD's own setting. So: PT, PP and CD in a real drawing set to metres, to inches and to feet (refused, nothing brought in, the drawing not marked as changed, nothing to Undo); in a drawing with no units set (drawn at true size, the grey line); with the display format changed and the insertion units left at millimetres (drawn as normal); on a layout sheet; in a read-only drawing.

## 6. Ruled since (control room, about 3:45 pm, D-403)

1. **RULED: the grey line shows in EVERY window of a drawing with no units set** (TR-089's record: "one grey line in each window"): once per window, not once per drawing. The two targets at lines 69 and 87 are wrong as written and must be restated.
2. **DRAFT: a refused-unit drawing is refused BEFORE THE FIRST CLICK** (as the read-only drawing and the layout sheet); nothing drawn, nothing changed, seen or unseen.
3. **DRAFT: every unit other than millimetres and "not set" is refused the same way,** naming the unit.
4. **DRAFT: the units change while a window is open:** OK closes it, the drawing is untouched, and the command line says why.
5. **DRAFT: a command with no window** says "treated as millimetres" once per command on the command line.
6. **The layout-sheet and read-only refusals go in THIS list,** with the edit of an existing part in a refused drawing.
