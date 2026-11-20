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


---

# Second answer: codex/tests-units at df9d533 (after its fix round)

**Answer: HOLD THE LIST. Six reasons, all the list's own.** Written Fri 20 Nov 2026, about 5:56 pm. Checked on the bench only. Under D-416 the round count restarts from the decisions record at D-416: this answer is the list's baseline; two rounds follow.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\unitsb_honest_REPORT.md` (hold narrowly, two reasons). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\unitsb_adv_REPORT.md`, proofs in `unitsb_adv_proofs\` (the four saved cheats are all caught now; a new one turned all 104 targets green while an ordinary metre drawing still took a pit, two layers and the office set-up). Graded here.

## 7. Counts seen (the writer's counts are true)

Pretend drawing 794: this list 121 cases: 104 targets fail, each because the product draws or says nothing where it should refuse; 16 controls pass (12 drive the commands, 4 test the word matcher); 1 waiting (the legal point, Stage 2), skipped. 673 older pass. The whole solution builds. Only tests changed. Brain 750 and bench 438 pass when run alone (three brain timing tests and one four-minute bench style check failed in a loaded full run and passed alone). The two writers' commits read as one round: nothing doubled or half-done in the test file.

## 8. What the round closed

Feet; the edit of an existing pit and pipe by Select and select-first, in a refused drawing and after the units change with parts present; every write the pretend drawing offers now logged and the drawing compared before and after; bare and populated drawings; refusal before any prompt, click or window; the grey line in every NEW window (D-403 item 1); the words must name the unit and say it is not supported; the control reads both sides of the pit at two scales; layout sheet and read-only for PT, PIPE and CD; the older contrary tests named; the legal point parked.

## 9. Reasons to hold

1. **A drawing with an ordinary identity still gets past.** Every pretend drawing is named "Drawing1.dwg" or carries a "FAKE-" key (`tests/CeCivil.Hands.Tests/DrawingUnitsDoorwayTests.cs:44, 77, 291`; `Fake/FakeDrawing.cs:154`); a real drawing gives a fingerprint. A product that skipped drawings with a real-looking fingerprint passed all 793 tests; on such a drawing set to metres it placed a pit, made two layers and brought in the office set-up. Use fresh, real-looking fingerprints, bare and populated.
2. **Units and command names with no row.** `:22-23` lists metres, centimetres, inches and feet. A fix refusing just those four turned all 72 unit targets green; yards and decimetres still drew a pipe (the product converts them: `src/CeCivil.Hands/Units/DrawingUnits.cs:21-24`). And a product that let the full command name PIT through passed everything and drew in feet (`src/CeCivil.Acad/PitCommand.cs:25`). The doorway is "millimetres or not set, else refuse": add the other named units and one code with no name; drive every registered command name.
3. **The grey "treated as millimetres" line can vanish when an EXISTING part is edited.** D-403 item 1 (ruled): every window. The repeat targets open new windows only (`:168, 201`); the edit controls use millimetre drawings (`:272`). A product that dropped the line on edits passed everything.
4. **A pit at the wrong scale passes, and a good drawing can be refused.** The control reads the pit's two stretch distances but not the insertion's scale: a pit inserted at scale 2 passed (`:248-262, 521-525`). Both scale rows use the architectural display format: a product that REFUSED an ordinary decimal millimetre drawing at 1:50 passed all 120.
5. **The drafter can be told the opposite.** With the list green the product said to stay on the layout sheet, called a read-only drawing "not read-only", followed a metre warning with "These units are supported", and on a change from not set to millimetres said millimetres were unsupported (`:122, 556-577`). A sound sentence can also fail the matcher ("Only millimetre drawings are supported. This drawing is in metres."). Test what the whole line means, not a fragment.
6. **Two report files are in the commit and contradict each other:** `tests/CeCivil.Hands.Tests/reports/UNITS_TESTS_REPORT.md` (out of date) and `UNITS_VERDICT_RESPONSE.md`. Off the branch.

## 10. To fix in the same round

1. **Centimetres in the edit rows** (`:65`); PP and the levels window on a layout sheet and in a read-only drawing (`:92-102`); a model-space viewport inside a layout sheet (the pretend drawing cannot show it today: `Fake/CommandHost.cs:221-222`).
2. **Two targets prescribe how the code is built, not what the drafter gets:** exactly ONE bring-in call (`:227`: two calls bringing the same things failed it) and zero start-up calls (`:553`). Assert what arrives and what stays as it was.
3. **The hidden write at start-up is caught only by a counter:** connect the observer to the real start-up routine so the write itself is seen (the adversarial helper's patch `14-observe-real-startup-call.patch` shows how).
4. **Mark which rows rest on a draft:** 80 of the 104 targets rest on D-403 items 2 to 4 (drafts); the file cites D-403 without saying so.
5. **ONE test host** for this list, the A4c list and A6 (this copy has no Undo record). The scratch folder `obj/units-doorway-proof-cd76d105` in the writer's copy is to be removed.

## 11. For the control room

1. **A units setting the tool cannot name** (a code with no unit): say it cannot read the units, show the code, and leave the drawing alone (recommended)?
2. **A layout sheet with a viewport open into the model:** PT and CD work as normal there (recommended: the pit lands in the model at true size), or refused like the sheet?
3. **The "treated as millimetres" line:** in the window only (as the tests have it), or on the command line too?
4. **The units change between millimetres and "not set" while a window is open:** OK still closes it and draws nothing (as the D-403 draft reads)?

## 12. Owed in AutoCAD

Section 5 of the first answer stands: with the real units reader made to answer millimetres for every drawing the list stays as it was, and on the bench a 150 pipe measured 150,000 mm in a metre drawing: only AutoCAD can show the real setting being read. Add: a model viewport on a layout sheet; the grey colour of the line; the drawing not marked as changed and nothing to Undo after a refusal.

## 13. Ruled since (control room, about 5:58 pm, D-418)

1. **A units code with no name:** refused, the code shown, the drawing left alone.
2. **DRAFT: a layout sheet with a viewport open into the model works as normal.**
3. **"Treated as millimetres":** in the window only when there is a window; on the command line, once per command, only when there is none.
4. **DRAFT: the units change between millimetres and "not set" with a window open: OK goes ahead and draws** (the two rows that close the window on that change are restated).



---

# Third answer: codex/tests-units at bee88b6

**Answer: HOLD THE LIST. Six reasons, all the list's own; a seventh rests only on D-418 and does not count. This was round one of two from the D-416 baseline: ONE round is left.** Written Fri 20 Nov 2026, about 8:30 pm. Checked on the bench only. (65d95d1 was sent back unchecked; this tip carries it.)

**Who checked, and how they split.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\unitsc_honest_REPORT.md`: ACCEPT (all six reasons of the second answer closed; one merge condition: the report file). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\unitsc_adv_REPORT.md`, proofs in `unitsc_adv_proofs\`: HOLD: a deliberately faulty build (a four-file change to the product, the submitted tests untouched) passed all 915 active cases while a metre drawing still took a pit and two new layers; eight cases of its own each then failed on that build. Both finished before this was written. The metre refusal is a hard limit (D-344, D-380): a list that a build can pass while drawing in a metre drawing is not accepted, so the hold stands. The honest half is right that every reason of the second answer is closed for the cases it named; these are further ways past the same doorway.

## 14. Counts seen (the writer's counts are true)

The whole solution builds, the AutoCAD plug-in project included, no warnings. Pretend drawing 1,589: this list 916 cases, 879 targets fail (each on what the product draws or says, none on the test's wiring), 1 waiting (the legal point, Stage 2); 673 older pass. 816 rows are marked DRAFT (D-403). Only tests changed. Speed and style tests failed only under tonight's load.

## 15. What the round closed

A fresh fingerprint for every pretend drawing; every units code 1 to 24 and code 99 against all seven command names; the grey line on edits of existing parts; scale 2 fails and decimal millimetres at 1:50 is not refused; whole-message comparison against a reversal; results checked instead of call counts; the real start-up routine spliced into the test host; DRAFT marks; the D-418 rows (an unnamed code, a layout viewport, the notice's place, millimetres to unset and back).

## 16. Reasons to hold

Line numbers are in `tests/CeCivil.Hands.Tests/DrawingUnitsDoorwayTests.cs`.

1. **A refusal can still write to the drawing and leave an Undo step.** The before-and-after comparison (`:571-589`) sees only objects that survive; the pretend drawing leaves erased objects out (`Fake/FakeDrawing.cs:174`). A refusal that made and erased a circle and closed an Undo group passed. D-344, D-380, D-403 item 2: a refused drawing is left alone. Check the next object number, the write history and the Undo marks the host already records (`Fake/CommandHost.cs:96`); the real drawing's changed flag and Undo list go on the owed list.
2. **A layout viewport lets a forbidden drawing through.** The viewport rows (`:278`) use only writable millimetre drawings; the read-only and layout rows (`:178`) never have a viewport active. A build that accepts a viewport BEFORE asking units or read-only placed a pit and made two layers in a metre drawing. Each refusal again with a viewport active, before any prompt.
3. **A run picked BEFORE the command, in metres, reaches the levels window.** The levels names go only by ordinary selection (`:85`); the refused-unit edit rows are the five Pit and Pipe names (`:105`). With a pipe already selected the levels window opened and took OK. Add a preselected run in metres, inches and unset (D-383, D-344).
4. **A drawing that opens unset and changes to metres while the window is open is drawn in.** Every changed-to-refused row opens in millimetres (`:205-210`); the one unset row changes to millimetres (`:240`). Unset to metres after the pick and before OK placed a pit. The window closes, the command line says why, the drawing is unchanged (D-403 item 4).
5. **The drawing's name can decide the refusal.** Every pretend drawing's name starts with the same word (`:184, 283, 477`): a guard that looks at the name passes the whole list, and a metre drawing with an ordinary saved path took a pit. Vary folder and name independently of units and contents, and include an unsaved drawing. (This is the second answer's reason 1, half closed: the fingerprint now varies, the name does not.)
6. **Right words fail and wrong words pass.** The comparisons at `:97`, `:197` and `:752` demand one exact sentence the rulings do not give ("Only millimetre drawings are supported. This drawing is in metres." fails); for an unnamed code `:149-151` accept "Code 98 is supported. Nothing was drawn. Continue in these units." Test the meaning: the unit or code is named, it is refused, nothing was drawn, and no line says the opposite. (The second answer's reason 5 again.)
7. **(D-418 item 9 only: no strike.)** The unset notice can be echoed on the command line in other words (`:719-734` know a short list of phrases): check which channel carries a units message at all.

## 17. To fix in the same round

1. **The report file out of the commit** (`tests/CeCivil.Hands.Tests/reports/UNITS_TESTS_REPORT.md`: it still says the tip is 1df68ab). Both halves ask this.
2. **The four D-418 rows that already pass** are named controls (nobody has seen them fail).
3. **A units change with a window open** is tried for PT, PIPE and CD only: add PP and the levels window.
4. **Older tests that go under the doorway and still expect conversion** (`PitRollbackAndUnitsTests.cs:130`, `PitSizeUnitsTests.cs:22, 38`, `PipeToolTests.cs:298`): named in the hand-over, to be retired or restated with the build.
5. **Which space owns a part placed through a viewport** is not proven on the pretend drawing: owed in AutoCAD, by name.

## 18. A note for the control room

This list has now been held three times, each time on a new way past the same doorway found by a faulty build written to pass it. The check room's view: the six reasons above are the last cheap ones (each is a missing combination, not a new idea), and the build of the units doorway will be checked by the same probes whatever the list says. If the next round closes these six, further "a cheat could pass" findings will be put as follow-ups and binding probes for the build, as D-411 did for C11, not as another hold.

## 19. Owed in AutoCAD

The real drawing's changed flag and Undo list after a refusal; the colour of the grey line; model or paper ownership through a viewport; the saved drawing's own fingerprint after reopen.
