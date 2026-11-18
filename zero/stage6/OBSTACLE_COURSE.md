# The obstacle course (revision 1)

**Why this file exists.** Tim, 18 Nov 2026 (D-212): "how can we reduce the number of bugs again ... rebuild the foundation, database and overall code to be scalable and also have the ability to be built upon". The planning chat's answer (D-213), approved to be written: "yes, write both". This is the second of the two: the standing obstacle course every tool must get through before it is called built or tested.
**Written:** 18 Nov 2026, Melbourne, by a helper of the planning chat. Read-only work: nothing run, built, installed or committed.
**Status: DRAFT for Tim.** Not approved until he has read it (D-213). Every rule below that Tim has not ruled says so.
**IDs:** obstacles are OC-01 onward, shared parts SP-01 onward, questions OQ-01 onward. An ID is never reused (D-205). A retired obstacle keeps its number, marked retired, with the date.

---

## A. The short answer for Tim

1. **What it is:** a fixed list of 27 tests, one for each mistake the old plug-ins kept making, plus speed and "native AutoCAD untouched". Every new tool runs the whole list.
2. **Where they came from:** 597 old bugs that would happen again in any plug-in. Every one of them sits behind one of the 27.
3. **Passed means:** each test has a pass rule in drafting words with a real example ("the same job in a millimetre and a metre drawing gives the same inverts"). Not tested never counts as passed.
4. **Built** = every test that needs no AutoCAD passes. **Tested** = the AutoCAD ones pass at night, run by something that did not build the tool. Accepted stays Tim's (or a robot pass, D-089).
5. **What it does to the bug count:** the same mistake cannot reach a second tool, because the test that caught it in the first tool runs on every tool after it. A new kind of mistake becomes a new line in the list.
6. **Today's honest score** (Pit, Pipe, Long section and the bench windows: 108 places to pass): 3 full passes. Most of the rest are not tested yet or fail on things known not to be built yet.
7. **Biggest gaps:** no part yet checks locked layers, xrefs or REFEDIT; nothing guards your current layer and settings; no fault report exists; the Detention window would repeat both wrong-figure bugs.
8. **10 questions for you** at the end (part G), most important first.

---

## B. The shared parts: every job done once

**The rule for all of them:** a tool may not do any of these jobs any other way. If a tool needs the job done differently, the shared part is changed (and every tool gets the change), never copied.
**How that is checked:** by tests that read the program files, as the brain already does (its tests fail if a pit, a fact name or a standard figure is written into program code). Each part below names its scan.
**"Today" is what is in `C:\CE_CIVIL` on 18 Nov 2026,** read from the files, not run.

1. **SP-01 Reading a typed number.**
   1. **Does:** turns what the drafter typed ("5.13", "1:100", "1 in 100", "1%", "0.01") into one figure, or says why it cannot; the PC's region setting never changes it.
   2. **Used by:** every window box, the schedule cells, every typed prompt.
   3. **Today:** exists as `TypedNumber` in the bench core, used by the window and schedule models. Not yet the only one: other number reading sits in about a dozen other files of the bench core and the tools (some of it reads the office lists, which is allowed).
   4. **Check:** a scan fails if any file other than the number reader and the list loader turns text into a number.
2. **SP-02 Units and scale.**
   1. **Does:** knows the drawing's units (millimetres, metres, none) and that the model is 1:1 with the layout at 1:100 (D-194); converts every distance, reach, tolerance, text height and offset through one place.
   2. **Used by:** every tool that draws, measures, searches near a pick, or works out a length, area or volume.
   3. **Today:** MISSING as a part. The drawing link can read the units (read only), but Pit, Pipe, Long section and Outlet each make their own millimetres-only check, four copies.
   4. **Check:** a scan fails if a tool reads the units or multiplies by 1000 itself; a brain test runs the same job in millimetres and metres.
3. **SP-03 A level.**
   1. **Does:** holds a level as a figure or "not known yet"; rounds half away from zero to the sheet's two decimals; prints 0.00 never -0.00; prints "TBC" when not known (D-178) and "APPROX." when assumed (D-177).
   2. **Used by:** Pit, Pipe, Long section, schedule, labels, criteria box.
   3. **Today:** the rounding exists in the brain (DESIGN.md 1.5). TBC and APPROX. printing: not built.
   4. **Check:** a scan fails if any file formats a level itself; a test prints -0.004, 0, blank and assumed and expects 0.00, 0.00, TBC, APPROX.
4. **SP-04 A grade.**
   1. **Does:** reads every typed form, prints "1 IN 100" as typed (D-154), knows "flat" and "uphill".
   2. **Used by:** Pipe, Long section, labels, schedule, fall arrows.
   3. **Today:** exists as `GradeLabel` in the bench core (one label rule; the Long section's grade words already come from it).
   4. **Check:** a scan fails if "1 IN" or "1 in " is written anywhere but the grade part.
5. **SP-05 Placing and moving a label.**
   1. **Does:** puts tags, cover texts, pipe labels and arrows at the office spot and gap, readable at any angle, clear of the outline; keeps a hand-moved label's offset when its thing moves (D-181); keeps typed-over words (D-182).
   2. **Used by:** Pit, Pipe, inlets, tank, outlet, later tools.
   3. **Today:** text sizes and offsets come from one list (`text_heights.csv`), but the placing is done separately inside the Pit tool and the Pipe tool. Copied.
   4. **Check:** a scan fails if a tool works out a label position itself.
6. **SP-06 A message to the drafter.**
   1. **Does:** one route for every command-line line, refusal and window warning; the words come from a words list; names things as the drawing does.
   2. **Used by:** every command and window.
   3. **Today:** the words are lines of `tools.csv` (shared), but each command (Pit, Pipe, Long section, Outlet) has its own way of saying them. Copied.
   4. **Check:** a scan fails if a command writes to the command line other than through the message part, or if a message contains a handle, a file path, a bracket tag or an IT word from a banned list.
7. **SP-07 Status words and colours.**
   1. **Does:** Suits, Needs a look, Wrong, each with its colour and the word, used for nothing else; "not joined yet" and "not known yet" in quiet grey (D-176).
   2. **Used by:** every window, list and check.
   3. **Today:** exists: the status words are in `checks.csv`; the colours, including the quiet grey `NotYet`, are in the shared theme (`Pal`).
   4. **Check:** a scan fails if a colour value or a status word is written outside the theme and the checks list.
8. **SP-08 The undo step.**
   1. **Does:** wraps one action, including the end-of-command mover, into one undo step; a look-only action adds none.
   2. **Used by:** every command.
   3. **Today:** each command sets its own undo flags. Not a shared part. One undo step is unproven in AutoCAD (BUILD_LOG summary).
   4. **Check:** a scan fails if any command sets undo flags itself; a night test counts undo steps.
9. **SP-09 "May I write here?"**
   1. **Does:** before anything is written, checks each object and layer it would touch: locked layer, frozen layer, xref, REFEDIT in progress, read-only drawing, paper space or model space. Refuses before the first write and names the layer.
   2. **Used by:** every tool that writes.
   3. **Today:** MISSING. A search of the code on 18 Nov found no locked-layer, xref, REFEDIT or space check anywhere.
   4. **Check:** a scan fails if the drawing link writes without asking this part first.
10. **SP-10 The hidden note and its reader.**
    1. **Does:** writes and reads each thing's facts, sources and position stamp; never touches a note that is not ours.
    2. **Used by:** every tool, the self-check, the Unfinished list.
    3. **Today:** exists, once: `HiddenNotes`, `Stamp`, `ReadOnceDrawing`. Proven in AutoCAD by CETEST (note round trip, invisible to a plain view).
    4. **Check:** a scan fails if any file reads or writes the extension dictionary other than this part.
11. **SP-11 Joins.**
    1. **Does:** a join as a soft pointer in the object's own record; ends follow at the end of a command; loose ends join when they meet (D-176).
    2. **Used by:** Pit, Pipe, Long section, Outlet, inlets, tank.
    3. **Today:** exists, once: `JoinStore`, `EndOfCommand`, `PipeEnds`.
    4. **Check:** a scan fails if a tool moves a joined end itself.
12. **SP-12 The office list reader.**
    1. **Does:** reads every standard, council figure and table once per AutoCAD session, in order of authority (D-022), with its source.
    2. **Used by:** everything.
    3. **Today:** exists: `OfficeLists` (read once, a test proves it) over the brain's standards reader.
    4. **Check:** the brain's existing scans (no standard figure in program code) extended to every project.
13. **SP-13 Selection and "is this ours?"**
    1. **Does:** decides whether an object is a CE thing (carries our note and registered name) before any code of ours acts on it; drives double-click and the light ribbon tab.
    2. **Used by:** every command, double-click, the self-check, following.
    3. **Today:** part exists: the on-open look for our registered name (`HoldsOurThings`) and `Names`. Double-click: not built.
    4. **Check:** a scan fails if any code reacts to an object before asking this part.
14. **SP-14 The window frame, cards, padlock and preview.**
    1. **Does:** the frame, cards, "What else changes", button bar, padlock, source chips and preview of the UI plan.
    2. **Used by:** every window.
    3. **Today:** exists once: `src/CeCivil.Window` (moved, not copied, on 18 Nov; entry 24), filled from window data files.
    4. **Check:** a scan fails if a window project draws its own card, button or padlock.
15. **SP-15 The Unfinished list.**
    1. **Does:** one list of not joined yet, not known yet, assumed, typed over and no longer matching, changed by hand.
    2. **Used by:** every tool, plotting (D-188).
    3. **Today:** exists for "not joined yet" only (`Unfinished`). The other kinds: not built.
    4. **Check:** a scan fails if a tool keeps its own list of loose or unknown things.
16. **SP-16 Logging and the fault report.**
    1. **Does:** one log per session, trimmed in size, with no login, PC name, drawing path or job name; the fault report builds from it and shows Tim exactly what it holds.
    2. **Used by:** every command; the Manager.
    3. **Today:** MISSING. No log is written by the new plug-in (the night checks write their own result files under `C:\CE_WORK\civil_tests\`).
    4. **Check:** a scan fails if any file writes a log itself; a test scans a made-up report for a login, a path and a job name.
17. **SP-17 Put back on failure.**
    1. **Does:** if a step fails part-way, everything the command wrote is put back and the words say so.
    2. **Used by:** every tool that writes.
    3. **Today:** each of Pit, Pipe, Long section and Outlet has its own put-back. Copied; the reviewer found gaps in two of them (entry 27 item 10).
    4. **Check:** a scan fails if a tool writes without going through the shared put-back.
18. **SP-18 The shared-settings guard.**
    1. **Does:** notes the current layer, snaps, ortho, current colour, linetype, text style, dimension style and every layer's state before a command, and checks they are the same after it, including after Escape or a fault.
    2. **Used by:** every command.
    3. **Today:** MISSING. (The code sets no AutoCAD system variable anywhere, searched 18 Nov, which is the right start.)
    4. **Check:** a scan fails if any file sets a system variable or changes an existing layer; a night test compares before and after.
19. **SP-19 Plan, then apply.**
    1. **Does:** a tool first works out everything it would do as plain data (the preview and "What else changes" show that plan), then applies exactly that plan, or nothing.
    2. **Used by:** every tool.
    3. **Today:** each tool plans "as pure data" in its own way. The pattern is repeated, not shared.
    4. **Check:** a test applies a plan and compares the drawing with the plan, object for object.
20. **SP-20 The speed meter.**
    1. **Does:** times every limit in `PERFORMANCE.md` the same way, cold and warm apart; a measure that cannot be taken says NOT TESTED.
    2. **Used by:** the night run for every tool.
    3. **Today:** exists: `Hands/Speed` and the night command CESPEED; every limit is a line of `speed_night.csv`.
    4. **Check:** every new tool adds its lines to the speed list or the gate refuses it.
21. **SP-21 Names and numbers.**
    1. **Does:** next free number, "8" and "P8" the same pit, one series per sheet (D-183), the three choices after issue (D-184), renaming by retyping (D-185).
    2. **Used by:** every tool that names things; find; schedule.
    3. **Today:** `Names` exists; next free numbers for copies (D-179) and the rest: not built (BUILD_LOG entry 27, second list, item 5).
    4. **Check:** a scan fails if a tool makes a name itself.
22. **SP-22 The drawing link (the only door to AutoCAD).**
    1. **Does:** every read and write of the drawing goes through one small list of calls (16 today), so every part above can be enforced in one place.
    2. **Used by:** everything.
    3. **Today:** exists: `IDrawing` and its AutoCAD version `AcadDrawing`; the brain and hands have no AutoCAD reference at all.
    4. **Check:** a scan fails if any project other than `CeCivil.Acad` names an Autodesk part.

---

## C. The obstacles

**How to read each one.** (1) the lesson; (2) old bugs behind it (pile A of the sweep, with stop-work pile D bugs named separately); (3) the pass rule with a real example; (4) where it is tested and what already covers part of it; (5) the shared part that makes it pass by construction; (6) Tim's ruling, or "not yet ruled" with one question.
**About the counts:** every one of the 597 pile-A bugs was placed in exactly one obstacle, by keyword and then by hand, once (method: R-007's own result files, read 18 Nov). They are a fair picture, not exact. The sweep itself was medium confidence (R-007 section "How far to trust it").
**Where tested, three places:** **no AutoCAD** (the brain, or the fake drawing in the hands tests); **the bench** (real clicks on the windows); **AutoCAD at night** (test copies, a robot that did not build it; rule 1.9 and D-159, D-160 apply). A fourth, **a look** (Codex or Tim seeing the screen), is named where only eyes can judge.
**Lines.** Each pass rule is numbered (OC-01.1, OC-01.2 ...). A new bug of the same kind adds a line (part D).

### OC-01 Units and scale *(one of the three lessons R-007 says are not yet written anywhere)*

1. **Lesson:** a drawing set up in metres, or a pit block inserted at a scale, must never change a level, a length, an area or a volume.
2. **Bugs behind it:** 45. For example BUG-328 (metre drawing gave levels 1,000 times wrong from a grade), BUG-871 (detention volumes wrong in metre drawings), BUG-322 (label offsets and text sizes ignored drawing units and block scale).
3. **Pass rule:**
   1. **OC-01.1:** the same two-unit job drawn in a millimetre drawing and in a metre drawing gives the same inverts, grades, pit depths, areas, storage and label words.
   2. **OC-01.2:** text and labels are sized for the 1:100 layout (D-194): a 250 tag in a millimetre model plots 2.5 mm high; the same tag in a metre model is 0.25 and also plots 2.5 mm.
   3. **OC-01.3:** anything drawn on a layout sheet is paper-sized (BUG-910).
   4. **OC-01.4:** every search reach and tolerance (snap to a pit wall, join a loose end) works the same in both drawings.
   5. **OC-01.5:** a PC with a comma as its decimal setting reads "5.13" and stores 5.13 (BUG-1164).
4. **Where tested:** no AutoCAD for OC-01.1 and OC-01.5 (the brain runs one job in two unit settings); fake drawing for OC-01.4; AutoCAD at night for OC-01.2 to OC-01.4. **Already covering part:** CEPIT3, CEPIPE3 and CELEV2 read the units and refuse anything but millimetres in words (passed at midday on 18 Nov). That is honest, but it is a refusal, not a pass of OC-01.1.
5. **Shared part:** SP-02 Units and scale.
6. **Ruling:** D-194 (model 1:1, layout 1:100). **Not yet ruled:** what happens in a metre drawing. Question OQ-02.

### OC-02 Plain words

1. **Lesson:** every message, prompt, tooltip and help line says what happened in drafting words, naming the pit or pipe as the drawing does.
2. **Bugs behind it:** 35. For example BUG-372 (messages named block names and handles, not "P8 to P11"), BUG-814 (refusals did not say why), BUG-923 (software words in check rows, no next step).
3. **Pass rule:**
   1. **OC-02.1:** no message contains a handle, an internal name, a file path, an error code, a bracket tag or a word from the banned IT list. Example: "P4 is on locked layer STORMWATER: nothing changed", never "eOnLockedLayer (1F3A)".
   2. **OC-02.2:** one word for one thing in every window and message (UI plan 7.2); two tools never share a name (BUG-935).
   3. **OC-02.3:** every refusal or warning gives one next step.
   4. **OC-02.4:** the prompt words match what Enter really does (BUG-1312).
4. **Where tested:** no AutoCAD (a scan of the words list and the message part; most of this obstacle is a file check). A look for the window wording. **Already covering part:** the code scans that keep names and figures out of program code mean every word already sits in a list where it can be scanned.
5. **Shared part:** SP-06 A message to the drafter.
6. **Ruling:** UI plan section 7 (approved with the windows, D-068 to D-070); D-049 (1) and (5); D-064.

### OC-03 An honest closing line

1. **Lesson:** a tool never says "done", "saved" or "placed" for something it did not do, and the counts it gives are the counts in the drawing.
2. **Bugs behind it:** 26. For example BUG-1357 (rules check claimed done when it was not), BUG-776 (a split message listed things not done), BUG-1273 (preview and completion lines counted different things).
3. **Pass rule:**
   1. **OC-03.1:** the closing line is written from the drawing as read back after the change. Example: "P3 moved: 2 pipe ends followed; 1 label on a locked layer did not."
   2. **OC-03.2:** the preview's "What else changes" and the closing line count the same things.
   3. **OC-03.3:** "saved" only after the drawing is seen saved and unmodified (BUG-1441).
   4. **OC-03.4:** any edit that changes an output marks earlier check results out of date; a warning the drafter set aside returns when its inputs change (BUG-801, BUG-875).
   5. **OC-03.5:** a command with nothing to do says so and why (BUG-064).
4. **Where tested:** fake drawing for OC-03.1, OC-03.2, OC-03.4; AutoCAD at night for OC-03.1 and OC-03.3. **Already covering part:** CELEV5 ("a failing step puts back everything written and says so") passed at midday.
5. **Shared parts:** SP-06 and SP-19.
6. **Ruling:** UI plan 7.3; SITUATIONS rule 6 (a proposal, not ruled one by one). No question: no drafter would choose otherwise.

### OC-04 Unknown stays unknown

1. **Lesson:** a figure nobody has given is "not known yet", never zero, never a made-up default, never a green tick.
2. **Bugs behind it:** 32. For example BUG-757 (a stored zero cover printed as RL 0), BUG-653 (a blank level read as RL 0), BUG-800 (a check that could not run showed green).
3. **Pass rule:**
   1. **OC-04.1:** a pit placed with no cover level prints "TBC" on the sheet (D-178) and reads "not known yet" in every window, list and check.
   2. **OC-04.2:** a real level of 0.00 or -0.20 is a level, checked like any other (BUG-686, BUG-1019).
   3. **OC-04.3:** a check that cannot run says "Cannot check yet: P4 cover level is not known", never Suits.
   4. **OC-04.4:** a status line never says current, passed or OK for something not checked or not loaded.
   5. **OC-04.5:** an assumed figure prints "APPROX." in front, with the one standing note (D-177).
4. **Where tested:** no AutoCAD for the figures (the brain keeps unknown as empty, never 0; its hard limit 5); the bench for the window words; AutoCAD at night for the printed TBC and APPROX. **Already covering part:** brain tests (an empty value never reads as 0, entry of 16 Nov).
5. **Shared parts:** SP-03 A level, SP-07 Status words.
6. **Ruling:** RULES 12.2; D-176, D-177, D-178. **Not yet ruled:** whether "Cannot check yet" is quiet grey or amber. Question OQ-06.

### OC-05 One value, one place

1. **Lesson:** every council and office figure comes from one list, with its source, and every tool, check, label and sheet reads that same figure.
2. **Bugs behind it:** 50, the largest group. For example BUG-282 (minimum cover differed between tools), BUG-790 (checks used built-in numbers), BUG-1117 (an editable value was not the one used).
3. **Pass rule:**
   1. **OC-05.1:** change minimum cover in a copied office list from 0.30 to 0.45: every window, check, schedule cell, label and printed note shows 0.45, with no program change.
   2. **OC-05.2:** every figure shows its source as a document and page, never a file path (BUG-239).
   3. **OC-05.3:** a council figure that the council states is used; one it does not state reads "not checked" (BUG-1057).
   4. **OC-05.4:** one fact is typed in one place and shown everywhere. Example: P3's kind and lid read the same in the Pit window and the schedule (today they do not, INPUT_AUDIT 2.2).
   5. **OC-05.5:** a drawing keeps the standard values it was designed with; a different office list on another PC changes nothing until a person says so (D-180).
4. **Where tested:** no AutoCAD for OC-05.1 to OC-05.4; AutoCAD at night for OC-05.5 (open the same drawing with a changed list). **Already covering part:** the brain test that changes a value in a copied list and gets the new answer; the scans that fail on a standard figure written in code; CEPIT1 and CEPIPE1 (layers, colours, text sizes from the lists) passed at midday.
5. **Shared part:** SP-12 The office list reader.
6. **Ruling:** D-002, D-021, D-022, D-171 (change 2), D-180.

### OC-06 Typed and held figures are kept

1. **Lesson:** what the drafter typed is never silently overwritten, rounded, switched or replaced by a remembered figure.
2. **Bugs behind it:** 36. For example BUG-685 (a typed level was moved and the printed grade was not the true one), BUG-1233 (the window changed a choice the drafter made), BUG-839 (a window saved a stale copy of fields not changed there).
3. **Pass rule:**
   1. **OC-06.1:** type 1 in 73: the label prints 1 IN 73 (D-154); type 5.137: it is held as typed.
   2. **OC-06.2:** "1:100", "1 in 100", "1%" and "0.01" are read as the same grade; something unreadable keeps the old figure and says so beside the box.
   3. **OC-06.3:** an edit saves only the fields the drafter changed.
   4. **OC-06.4:** a typed-over figure carries the padlock and the standard beside it (D-150); one click lets it follow again (D-103, D-182).
   5. **OC-06.5:** a new window starts from the office default or the drawing's own figure, never a hidden remembered one (BUG-1323).
4. **Where tested:** no AutoCAD (the brain's held facts are never changed by the solver); the bench by real clicks; AutoCAD at night for OC-06.3. **Already covering part:** CEPIT2, CEPIPE2 and CELEV1 (edits keep the same objects and change the words in place) passed at midday.
5. **Shared parts:** SP-01 Reading a typed number, SP-14 (padlock).
6. **Ruling:** D-079, D-086, D-103, D-150, D-154, D-182.

### OC-07 Undo and redo

1. **Lesson:** one action is one undo step, redo always works, and looking adds no step.
2. **Bugs behind it:** 20. For example BUG-256 (REDO after one U failed), BUG-412 (view commands added undo steps), BUG-1310 (a multi-part placement was not all-or-nothing).
3. **Pass rule:**
   1. **OC-07.1:** place a pit with its tag and cover text: one U removes all three; REDO puts all three back.
   2. **OC-07.2:** move a pit with plain MOVE: one U puts back the pit, its two pipe ends and its labels together.
   3. **OC-07.3:** open a window and Cancel, open a check, look at the schedule: the undo list is the same length after.
4. **Where tested:** AutoCAD at night only (a typed U needs a real command; BUILD_LOG entry 24 item 6). **Already covering part:** none; "one undo step is unproven" (BUILD_LOG summary).
5. **Shared part:** SP-08 The undo step.
6. **Ruling:** PERFORMANCE 4.5 and SITUATIONS rule 14, both proposals. No question: no drafter would choose otherwise.

### OC-08 Cancel, Escape and looking change nothing; the preview is the result

1. **Lesson:** Escape, Cancel or the window's X leave the drawing exactly as it was, and what Apply writes is exactly what the preview showed.
2. **Bugs behind it:** 33. For example BUG-873 (a cancelled run still wrote to the drawing), BUG-1354 (a look-only command wrote to the drawing), BUG-1269 (the preview promised something Apply did not write).
3. **Pass rule:**
   1. **OC-08.1:** Escape at every prompt, and the X on every window: the drawing has the same objects, the same notes and is not marked changed.
   2. **OC-08.2:** opening and closing any window, check or list leaves the drawing not marked changed (BUG-1198).
   3. **OC-08.3:** after OK, every figure and object in the drawing matches the preview and "What else changes", one for one.
   4. **OC-08.4:** starting a CE tool from the ribbon first cancels a running AutoCAD command (BUG-828).
4. **Where tested:** fake drawing for OC-08.1 and OC-08.3; the bench by real clicks (Escape on every window); AutoCAD at night for all four. **Already covering part:** CEPIPE3 and CELEV2 ("planning alone changes nothing, so Cancel draws nothing") passed at midday; CEPIT3 failed the same check at midday (below, part E); the bench click script `fix4_escape_everywhere`.
5. **Shared parts:** SP-19 Plan then apply, SP-08.
6. **Ruling:** UI plan 2.6; D-162 and D-167 (the preview is the drawing as AutoCAD shows it). "Escape cancels the whole window" is still DRAFT (BUILD_LOG DRAFT 8).

### OC-09 Move, copy, paste, mirror, array, erase, Save As

1. **Lesson:** a thing's parts stay with it whatever AutoCAD command moves it, and a copy is a new thing that never takes the original's labels or links.
2. **Bugs behind it:** 28, plus stop-work BUG-668 (moving or rotating a run put callouts in the wrong place) and BUG-224 (AutoCAD closed after Save As; cause never established). Examples: BUG-666 (erasing a copy deleted parts of the original), BUG-1140 (a pasted copy stole the original's labels), BUG-305 (labels did not travel with a pasted pit).
3. **Pass rule:**
   1. **OC-09.1:** copy P3 with its pipes to the mirror unit: sizes and grades copy, levels copy marked "assumed: from P3", the copies take the next free numbers (D-179), labels go with the copies, the original is untouched.
   2. **OC-09.2:** erase the copy: nothing of the original changes; OOPS brings the copy back whole.
   3. **OC-09.3:** paste a run into another drawing, save, close and reopen: it works with no repair and carries no link to the first drawing (BUG-342, BUG-1150).
   4. **OC-09.4:** MIRROR and ARRAY: labels stay readable and with their things.
   5. **OC-09.5:** Save As: every window shows the same figures before and after (BUG-1240).
4. **Where tested:** fake drawing for the plan; AutoCAD at night for all (typed COPY is not yet tested, BUILD_LOG summary). **Already covering part:** CETEST golden copy, erase and save checks; CEPIT4, CEPIPE4, CELEV4 passed at midday. They prove a copy is named "not yet named", which D-179 has since replaced with next free numbers.
5. **Shared parts:** SP-10 notes, SP-11 joins, SP-21 names.
6. **Ruling:** D-179, D-181; SITUATIONS rules 4 and 5.

### OC-10 Labels

1. **Lesson:** labels sit clear of pits, pipes and each other at every angle, and a label put somewhere by hand stays there.
2. **Bugs behind it:** 32. For example BUG-072 (labels lost their side and gap as the pipe angle changed), BUG-879 (a tidy moved a hand-placed label), BUG-1234 (invert text and arrows overlapped the pit).
3. **Pass rule:**
   1. **OC-10.1:** a pipe drawn at every angle from 0 to 345 degrees in 15-degree steps: its label reads left to right or bottom to top, at the office gap, clear of the pipe and both pit outlines.
   2. **OC-10.2:** a tag moved by hand 400 right and 200 up, then the pit moved with plain MOVE: the tag keeps its 400 and 200 offset (D-181).
   3. **OC-10.3:** a pipe label typed over by hand stays as typed, is flagged, and one click lets it follow (D-182).
   4. **OC-10.4:** a twin-barrel pipe's label clears the full width (BUG-1329).
4. **Where tested:** fake drawing for positions (OC-10.1, OC-10.2); AutoCAD at night to read positions back; **a look** for whether it reads well on the sheet. **Already covering part:** CEPIT1 and CEPIPE1 (labels take height, layer, words and place from the lists); CETEST golden label copy, move and erase.
5. **Shared part:** SP-05 Placing and moving a label.
6. **Ruling:** D-181, D-182. The gaps in `text_heights.csv` are DRAFT (entry 24).

### OC-11 Levels and grades along a run

1. **Lesson:** a level change carries down the run keeping the pit drop, the lowest arriving pipe governs, and back-fall is warned about, never hidden and never blocked.
2. **Bugs behind it:** 24. For example BUG-655 (downstream level did not use the lowest arriving pipe), BUG-652 (a level change lost the pit drop), BUG-689 (a grade change gave back-fall upstream with no warning).
3. **Pass rule:**
   1. **OC-11.1:** P3 has two pipes arriving at 5.30 and 5.25 and the office drop: its outlet invert works out from 5.25, and "What else changes" names the pipe that governs.
   2. **OC-11.2:** raise P1's outlet invert by 0.10: every pit downstream follows by 0.10, each pit drop unchanged, unless a level downstream is held, and then the clash is named by stretch and amount ("Out by 0.06 between P4 and P1", D-125).
   3. **OC-11.3:** a held level that makes a pipe run uphill shows red "Wrong" with the figures, and OK still saves (D-049, D-050).
   4. **OC-11.4:** where branches rejoin, the pit's level is worked out after all inflows (BUG-811).
4. **Where tested:** no AutoCAD (the brain); AutoCAD at night for the levels written. **Already covering part:** the brain's 20-pit branched job (five sub-cases, 200 shuffled orders) and the mock-up figures; CELEV1 passed at midday.
5. **Shared part:** the brain's sums and joins (SP-11).
6. **Ruling:** D-016 to D-018, D-086, D-124, D-125, D-154.

### OC-12 The long section on the sheet

1. **Lesson:** each pipe is drawn at its own size and grade, with the datum, depths and ground line right.
2. **Bugs behind it:** 13, plus stop-work BUG-756 (the top line drawn one pipe size too big before a size increase). Examples: BUG-759 (a datum above the lowest invert), BUG-1020 (pit depth not from the lowest of floor and pipes), BUG-768 (pit width from a default, not the pit).
3. **Pass rule:**
   1. **OC-12.1:** a run of 150, 150, 225: each pipe's top and bottom lines are drawn at that pipe's own diameter, including the one before the size increase.
   2. **OC-12.2:** the datum sits below the lowest invert; one above it is refused with a suggested figure.
   3. **OC-12.3:** each pit is drawn at its own width and depth, depth to the lowest of floor and every pipe.
4. **Where tested:** no AutoCAD for figures; AutoCAD at night for what is drawn; a look for the sheet.
5. **Shared parts:** SP-03, SP-04, SP-02.
6. **Ruling:** D-196 (name LONGSECTION, LG); D-030 (long sections only when the council asks). The long section on the sheet is not built yet.

### OC-13 The pit schedule

1. **Lesson:** rows belong to their pit, stay in order, and never change on a refresh unless the design changed.
2. **Bugs behind it:** 21, plus stop-work BUG-965 (a refresh changed "2/375" twin tanks to "375") and BUG-561 (a pit number change swapped grated and solid lids). Examples: BUG-786 (a pit's rows split apart on reopen), BUG-981 (two xrefs' pits mixed), BUG-573 (rounding counted as a change).
3. **Pass rule:**
   1. **OC-13.1:** add P7 in the middle of the run: every existing row keeps its order and its typed-over cells.
   2. **OC-13.2:** refresh twice with no design change: no cell changes and nothing reads "changed".
   3. **OC-13.3:** renumber P3 to P7: lid, size and every other cell stay with the pit.
   4. **OC-13.4:** two xrefs both holding a "P1": two rows, each labelled by its drawing.
   5. **OC-13.5:** "2/375" stays "2/375".
4. **Where tested:** no AutoCAD for rows; the bench; AutoCAD at night for the drawn table.
5. **Shared parts:** SP-21 names, SP-12, SP-14.
6. **Ruling:** D-103, D-169 (columns card and on-sheet scale out), D-185. The schedule on the sheet is not built yet.

### OC-14 Engineering sums use the real geometry and material

1. **Lesson:** sums use the pipe as drawn and as specified, not a straight line between pits or a default material.
2. **Bugs behind it:** 13. For example BUG-867 (grade from pit-to-pit distance, not drawn length), BUG-868 (capacity always as UPVC), BUG-901 (cover not measured to the outside top of the pipe).
3. **Pass rule:**
   1. **OC-14.1:** a pipe with one bend, 12.40 m along its bends and 11.90 m pit to pit: fall and grade use 12.40 (D-189).
   2. **OC-14.2:** cover is to the outside top of the pipe and the underside of the paving (D-146), checked along the pipe, not only at the pits.
   3. **OC-14.3:** a catchment with a curved edge: the area is the true curved area, not the chord.
4. **Where tested:** no AutoCAD (the brain); AutoCAD at night for drawn lengths.
5. **Shared parts:** the brain's sums; SP-02.
6. **Ruling:** D-102, D-146, D-189.

### OC-15 Names and numbers

1. **Lesson:** a pit number means one pit, is understood as typed, and is never lost or used twice.
2. **Bugs behind it:** 16. For example BUG-414 (renaming onto an existing number lost data), BUG-1307 ("8" and "P8" treated as different pits), BUG-1318 (an issued number reused).
3. **Pass rule:**
   1. **OC-15.1:** typing "8" finds P8.
   2. **OC-15.2:** retyping P3 as P7 renames the pit, its schedule row and pipe names (D-185); if P7 exists, both show amber and nothing is lost.
   3. **OC-15.3:** two systems on one site: one number series, street system first (D-183).
   4. **OC-15.4:** a pit added after issue offers next free, a letter (P3A) or renumber all (D-184).
4. **Where tested:** no AutoCAD; AutoCAD at night for the drawing.
5. **Shared part:** SP-21 Names and numbers.
6. **Ruling:** D-179, D-183, D-184, D-185.

### OC-16 UCS and rotated blocks

1. **Lesson:** a rotated UCS or a rotated pit block never shifts where things go.
2. **Bugs behind it:** 10. For example BUG-017 (tools placed things wrongly under a rotated UCS), BUG-661 (picks not converted to world), BUG-1195 (label angle wrong under a UCS).
3. **Pass rule:**
   1. **OC-16.1:** the same pits and pipes placed with the UCS turned 30 degrees and with a named UCS give the same world positions, labels and figures as in World.
   2. **OC-16.2:** a pit block turned 45 degrees: its pipe ends stop on its turned walls.
4. **Where tested:** AutoCAD at night. **Already covering part:** CEPIT6 (turning a pit in the tool moves the joined end) and CETEST's mover "follows move and turn" passed at midday. Nothing in the code handles a UCS yet (searched 18 Nov).
5. **Shared part:** SP-22 (picks converted once, in the drawing link) and SP-02.
6. **Ruling:** not ruled; a build rule, no question needed.

### OC-17 Windows fit, remember and read

1. **Lesson:** every window fits every office screen with nothing cut off, and comes back where it was left.
2. **Bugs behind it:** 27. For example BUG-955 (windows did not fit at 150 per cent scaling), BUG-958 (windows forgot their place), BUG-173 (clipped text).
3. **Pass rule:**
   1. **OC-17.1:** at 1920 x 1080 and 2560 x 1440, at 100 and 150 per cent Windows scaling, and on a drafting laptop: nothing clipped, nothing scrolls, OK and Cancel visible (D-065, D-193: cards go into tabs on a small screen).
   2. **OC-17.2:** a window reopens where it was left, on the second monitor too.
   3. **OC-17.3:** F1 and help name the real buttons of that window.
4. **Where tested:** the bench by real clicks and pictures; AutoCAD at night for the window inside AutoCAD; **a look** for readability. **Already covering part:** the bench's pictures at 1080 and 1440 and its layout check (47 states, 0 faults).
5. **Shared part:** SP-14.
6. **Ruling:** D-065, D-151, D-193.

### OC-18 Ours only: selection and double-click

1. **Lesson:** CE tools act only on CE things; a plain AutoCAD object behaves as AutoCAD made it.
2. **Bugs behind it:** 12. For example BUG-194 (an ordinary polyline brought up pipe tools), BUG-430 (double-click on a pit label opened the wrong editor), BUG-1284 (move-label tools acted on other objects).
3. **Pass rule:**
   1. **OC-18.1:** double-click a plain polyline: PEDIT, as without the plug-in. Double-click a CE pipe: the Pipe window, with no stray text on the command line.
   2. **OC-18.2:** give a CE tool a plain line: it refuses in words and changes nothing.
   3. **OC-18.3:** a change CE itself made is never refused as "not ours" (BUG-1223).
4. **Where tested:** AutoCAD at night (double-click needs a robot click; R-006 B3).
5. **Shared part:** SP-13 Selection and "is this ours?"
6. **Ruling:** D-055 to D-061 (double-click gets the window back); D-199 item 4.

### OC-19 AutoCAD's own protections win

1. **Lesson:** a locked layer, an xref, REFEDIT, a read-only drawing and paper space are never worked around; the tool refuses before writing anything and names the layer.
2. **Bugs behind it:** 30. For example BUG-797 (a locked layer left an object half-changed), BUG-1083 (an xref pick changed a layer before refusing), BUG-1084 (edits ran during REFEDIT).
3. **Pass rule:**
   1. **OC-19.1:** P4 on locked layer STORMWATER, edit its cover: "P4 is on locked layer STORMWATER: nothing changed"; the drawing is byte-for-byte the same; no layer is unlocked.
   2. **OC-19.2:** move a pit whose pipe label is on a locked layer: the pit and ends move, the label stays, the closing line says so (SITUATIONS rule 17).
   3. **OC-19.3:** pick a pit inside an xref: refused before anything is written.
   4. **OC-19.4:** run any CE writing tool during REFEDIT: refused with the reason.
   5. **OC-19.5:** a read-only drawing: tools that only read still work; tools that write say so once.
   6. **OC-19.6:** place a pit with a layout tab current: it goes where the drafter is working, or the tool says why not.
4. **Where tested:** fake drawing (the fake can mark a layer locked); AutoCAD at night. **Already covering part:** none.
5. **Shared part:** SP-09 "May I write here?" (missing today).
6. **Ruling:** SITUATIONS rule 17 (proposal); the native protection rule in the plug-in repository's instructions; R-007 lesson 4. No question: Tim's standing rule already says never bypass protected content.

### OC-20 Nothing shared left changed *(one of the three lessons R-007 says are not yet written anywhere)*

1. **Lesson:** a tool never leaves your current layer, snaps, styles, layer colours or settings different from how it found them, even after Escape or a fault.
2. **Bugs behind it:** 12, plus stop-work BUG-1457 (CLEAN and FASTSAVE overwrote the office template). Examples: BUG-387 (a window left the current layer and snaps changed), BUG-206 (snaps left changed after Escape), BUG-1444 (CLEAN changed shared layers and styles).
3. **Pass rule:**
   1. **OC-20.1:** before and after every command, including Escape part-way and a forced fault: the current layer, OSMODE, ORTHOMODE, current colour and linetype, text style, dimension style and every existing layer's colour, on, frozen and locked state are the same.
   2. **OC-20.2:** a missing office layer is made from the list; an existing layer is never altered, even if its colour differs from the list (the difference is said once).
   3. **OC-20.3:** nothing writes outside the drawing being worked on: no template, no other job's file, no AutoCAD support file.
4. **Where tested:** AutoCAD at night (a before-and-after snapshot around every night command). **Already covering part:** the code sets no system variable anywhere (searched 18 Nov).
5. **Shared part:** SP-18 The shared-settings guard (missing today).
6. **Ruling:** not yet ruled. Question OQ-07.

### OC-21 Native AutoCAD objects behave identically with and without the plug-in

1. **Lesson:** loading the plug-in must not change one thing about how a plain hatch, polyline, block or key behaves.
2. **Bugs behind it:** 6, plus stop-work BUG-1278 and BUG-1461 (hatch grips and Recreate boundary misbehaving with the old plug-ins loaded; cause not proven, R-006) and BUG-411 (the F2 key ran CLEAN). Examples: BUG-633 (native dimensions could not be picked normally), BUG-619 (hatch edits failed on existing drawings), BUG-978 (a second AutoCAD window loaded the plug-in only part-way).
3. **Pass rule:**
   1. **OC-21.1:** the same test drawing, with and without the plug-in loaded: a hatch (associative and not) shows the same grips; Recreate boundary makes the same number and kind of objects; a polyline shows the same grips; PEDIT, JOIN and STRETCH give the same result; a dynamic block shows the same grips and menus; double-click on a plain block opens the same editor.
   2. **OC-21.2:** our code is reached only for objects carrying our note, filtered by AutoCAD before our code runs (R-006 B2 items 1 to 3). Selecting 1,000 plain polylines costs the same with and without (R-006 B2 item 16).
   3. **OC-21.3:** no CE command or key takes a name or key AutoCAD or the office alias file already uses (the midday run's name list shows PIT and CD already answered before the plug-in loaded).
4. **Where tested:** AutoCAD at night, two sessions compared (one without the plug-in). A look for grips. **Already covering part:** CETEST "only plain classes in model space" and the three idle checks passed at midday; no grip code exists yet, so today's risk is low.
5. **Shared parts:** SP-13 and SP-22.
6. **Ruling:** D-199 item 4 ("the new plug-in must never change how native objects behave"). **Not yet ruled:** command names already in use, question OQ-09; whether to compare with the old plug-ins also loaded, question OQ-10.

### OC-22 A sheet opened with no plug-in

1. **Lesson:** a colleague, a council or a consultant without CE opens, edits and plots the drawing exactly as it would plot with CE.
2. **Bugs behind it:** 1 (BUG-1154: long hidden notes did not survive DXF and older DWG saves), plus stop-work BUG-1459 (pipes vanished for people without CE). Most of this kind died with the old special pipe object (pile B).
3. **Pass rule:**
   1. **OC-22.1:** open the test job in AutoCAD with no plug-in: no proxy warning, every pit and pipe visible and editable, and the plot matches the CE plot.
   2. **OC-22.2:** save as 2000 and 2013 DWG and as DXF, reopen with CE: every note and join is still there.
   3. **OC-22.3:** no status colour is ever written into the drawing (SITUATIONS rule 8): the plot is the same in any design state.
   4. **OC-22.4:** a colleague without CE moves a pit; reopened with CE, the self-check says what moved and offers to bring pipe ends back.
4. **Where tested:** AutoCAD at night (one session without the plug-in). **Already covering part:** CETEST "notes and records are invisible to a plain view", "only plain classes", and the 2000, 2013 and current saves passed at midday.
5. **Shared parts:** SP-10, SP-11, SP-22.
6. **Ruling:** D-027; the "no-plugin proof" in the order of work (HOW_WE_WORK, rules of the road 3); FOUNDATION (ordinary objects).

### OC-23 Unfinished is normal

1. **Lesson:** a loose pipe, a pit with no pipes, a figure marked TBC or APPROX. is ordinary drafting, never an error and never a stop.
2. **Bugs behind it:** 12. For example BUG-223 (a pipe between two loose ends took its direction differently in each window), BUG-210 (a pit brought onto loose ends did not join them), BUG-1040 (a held level causing back-fall stopped other changes).
3. **Pass rule:**
   1. **OC-23.1:** draw a pipe with both ends loose, save, reopen: no error, "not joined yet" in quiet grey, on the Unfinished list.
   2. **OC-23.2:** drop P2 on its free end: it joins, and "What else changes" says what filled in.
   3. **OC-23.3:** a run not reaching an outlet says "Cannot work out yet: P1 is not joined to an outlet" and does not run head, orifice or storage.
   4. **OC-23.4:** plot with open items: one quiet command-line line with the count; plotting carries on (D-188).
   5. **OC-23.5:** nothing odd ever blocks OK; it is warned about in one line under the card.
4. **Where tested:** fake drawing; the bench; AutoCAD at night. **Already covering part:** CEPIPE7 (a loose end joins with a real pointer and is said once) and CEPIPE8 (outlet) passed at midday.
5. **Shared parts:** SP-15 the Unfinished list, SP-07.
6. **Ruling:** D-049, D-050, D-175, D-176, D-177, D-178, D-188.

### OC-24 The two wrong-figure cases, worked through (R-008)

1. **Lesson:** a figure that goes out on a sheet is worked from the job's own rainfall and the council's own floor, and says so; it is never quietly worked from a sample.
2. **Bugs behind it:** 8, plus stop-work BUG-866 (rainfall note said high; storage about 18 per cent short on issued sheets) and BUG-1095 (council minimum C ignored; tank undersized). Examples: BUG-508 (a sum did not use the job's own rainfall), BUG-1099 (council before-development C not used), BUG-1111 (printed working did not show the figures used).
3. **Pass rule (worked figures from R-008, made-up sites):**
   1. **OC-24.1, rainfall:** a Glen Eira site, 600 m², 400 m² roofs and paving, 200 m² garden (C 0.70), permitted discharge 5.50 L/s, the site's 1 in 10 rainfall typed as 112, 85.0 and 69.4 mm/h at 5, 10 and 15 minutes: storage 2.65 m³ (governed at 10 minutes).
   2. **OC-24.2, rainfall not entered:** the same site with no site rainfall: the storage shows amber "rainfall is the office sample, not this site's", prints APPROX., and is on the Unfinished list. (Today's bench data would give about 1.85 m³, 30 per cent short, with no word on screen.)
   3. **OC-24.3, council floor:** a Darebin site, 600 m², 400 hard and 200 garden: the worked-out C 0.70 is raised to the council's 0.80, the words say "council minimum C governs", and storage (Boyd's, 1 in 10 office curve, permitted 4.45 L/s) is 3.75 m³, not 2.84.
   4. **OC-24.4:** the computations sheet prints the rainfall, C and source actually used.
4. **Where tested:** no AutoCAD (the brain and the Detention window on the bench); AutoCAD at night for the printed sheet. **Already covering part:** none; R-008 found the new plug-in's data would repeat both faults.
5. **Shared parts:** SP-12 The office list reader (rainfall by site, council floor as a list line), SP-03.
6. **Ruling:** D-207, D-212; D-022 (council first). **Not yet ruled:** questions OQ-04 and OQ-05. The council figures need Tim's word (engineering judgement, RULES 4.5).

### OC-25 Privacy of fault reports and logs *(one of the three lessons R-007 says are not yet written anywhere)*

1. **Lesson:** nothing the plug-in writes or sends carries a login, a PC name, a drawing path, a client or a job name.
2. **Bugs behind it:** 20. For example BUG-847 (the fault report kept job names and addresses in paths), BUG-405 (file names carried user and computer names), BUG-1260 (the report took key and settings files).
3. **Pass rule:**
   1. **OC-25.1:** make a fault report from a test drawing saved under a folder named like a street address, by a made-up login: the report, the log and any zip hold no login, PC name, path, address or job name.
   2. **OC-25.2:** no key or settings file is ever in a report.
   3. **OC-25.3:** nothing is sent anywhere unless the address is secure and approved, and the drafter sees what is sent.
   4. **OC-25.4:** two AutoCAD sessions never corrupt each other's log; the log stays trimmed in size.
4. **Where tested:** no AutoCAD (a scan of a made-up report); AutoCAD at night for a real report.
5. **Shared part:** SP-16 Logging and the fault report (missing today).
6. **Ruling:** RULES 11 (private data). **Not yet ruled:** what a report may carry. Question OQ-08.

### OC-26 Speed (every limit in PERFORMANCE.md)

1. **Lesson:** the plug-in never makes AutoCAD feel slower; every limit is measured every night and a limit broken is a fault like a wrong figure.
2. **Bugs behind it:** 13. For example BUG-202 (lag on select, hover, pan and zoom), BUG-269 (copying hundreds of pipes took minutes), BUG-1228 (placements slower than a second or two).
3. **Pass rule (limits are DRAFT until Tim rules, PERFORMANCE section 2):**
   1. **OC-26.1:** AutoCAD start: the plug-in adds no more than 1 second and reads no office list.
   2. **OC-26.2:** a drawing opens: self-check no more than 1 second on 500 objects, never holding up the drawing appearing.
   3. **OC-26.3:** a window opens within 0.3 second of the command.
   4. **OC-26.4:** every figure and the preview follow typing within 0.1 second.
   5. **OC-26.5:** moving a pit with its pipes: within 0.1 second on 2,500 objects.
   6. **OC-26.6:** idle: in a drawing with no CE objects, nothing at all; with CE objects, no more than 5 thousandths of a second added to a plain command on 2,500 objects.
   7. **OC-26.7:** plotting, saving, panning and zooming: no measurable change with the plug-in loaded.
   8. **OC-26.8:** copying or arraying 200 pipes finishes in seconds as one undo step (BUG-269).
4. **Where tested:** AutoCAD at night (CESPEED); no AutoCAD for the brain's 200-pit timing. **Already covering part:** CESPEED ran at midday: 12 PASS, 1 FAULT (part E).
5. **Shared part:** SP-20 The speed meter.
6. **Ruling:** D-165. **Not yet ruled:** the limits themselves; question OQ-03 (the one already broken).

### OC-27 Failures and damaged data are contained

1. **Lesson:** one damaged note, one missing file or one failed save never breaks the rest, never overwrites good data, and is always said.
2. **Bugs behind it:** 22, plus stop-work BUG-1456 (Help and Settings overwrote another job's stored data) and BUG-1276 (no backup written for hours). Examples: BUG-1141 (one damaged hidden note broke the rest), BUG-971 (unreadable data overwritten by a save), BUG-1157 (a failed save not reported).
3. **Pass rule:**
   1. **OC-27.1:** a drawing with one damaged note and one note written by a newer version: every other pit works; the two are named and left exactly as they are (SITUATIONS rule 10).
   2. **OC-27.2:** an object of the office's carrying its own data (for example the office pit block's own dictionaries) is read past and never written over.
   3. **OC-27.3:** a step that fails part-way puts everything back and says so.
   4. **OC-27.4:** a missing office list file or block is named in one line and the rest carries on.
   5. **OC-27.5:** a save that fails says "not saved".
4. **Where tested:** fake drawing (it can throw on the Nth call); AutoCAD at night. **Already covering part:** CELEV5 passed at midday; the Pit and Pipe put-back tests on the fake drawing; the new test that a dictionary not ours is left alone (NIGHT_TEST, entry 30), not yet run in AutoCAD.
5. **Shared parts:** SP-10, SP-17.
6. **Ruling:** RULES 12.3 (warn and carry on); SITUATIONS rule 10 (proposal). No question needed.

**Totals:** 597 pile-A bugs behind the 27 obstacles (every one placed once). Of the 15 stop-work bugs, 14 sit behind an obstacle as named above; BUG-1275 (steel beam crash) is structural, outside the first release.

---

## D. The gate: taking a tool through the course

### D1. The page each tool's builder fills in

One page per tool per build, kept beside the tool's design file (for example `acad\GATE_pit_tool.md`). Its shape:

1. **Tool, build and date.** For example "Pit tool, build of 19 Nov 2026, commit ...".
2. **One line per obstacle line,** OC-01.1 to OC-27.5, each with exactly one of:
   1. **PASS:** by what (the test's name, or the click script, or the night check), and when (date and time).
   2. **FAIL:** what was seen, and the bug ID in the new plug-in's list (D-205).
   3. **NOT TESTED:** why (for example "needs AutoCAD; tonight").
   4. **DOES NOT APPLY:** the reason in words (for example "the Pit tool writes no long section"), and the reviewer's name. Only the reviewer may write this, never the builder.
3. **The two counts at the top:** built (no-AutoCAD lines passed of those that apply) and tested (AutoCAD lines passed of those that apply), each as "N of M".

### D2. What the four words mean against the course

1. **Built:** every applicable obstacle line that needs no AutoCAD is PASS (the brain, the fake drawing, the code scans, the bench clicks).
2. **Tested:** every applicable obstacle line that needs AutoCAD is PASS at night, run by something that did not build the tool, on test copies (D-159, rule 1.9).
3. **Installed:** separate, only on Tim's yes (RULES 8.7).
4. **Accepted:** separate: Tim, or a robot pass when he is busy (D-089), plus a look for anything only eyes can judge (RULES 5.7). Never a count of passes.
5. **NOT TESTED is never a pass.** A tool with one NOT TESTED line is not built (or not tested).
6. **A FAIL is a fault** and goes ahead of new work (D-090).

### D3. How a new bug becomes a test, so it cannot come back

1. **A bug is found** in any tool (by the tester, the night run, Codex or Tim). It gets an ID in the new plug-in's own bug list (D-205).
2. **The reviewer asks one question:** which obstacle's lesson does this break?
3. **If it fits an obstacle:** a new numbered line is added to that obstacle (for example OC-10.5: "after MIRROR, a label's text reads left to right"), with its pass rule, a real example and where it is tested. From that moment every tool's gate page has that line.
4. **If it fits none:** a new obstacle is added with the next free number (OC-28 first), with the same six parts. An old number is never reused.
5. **The shared part is fixed once.** If the bug was in a shared part, fixing it fixes every tool; if a tool had done the job itself, the scan for that part gets the case that caught it.
6. **This is the scalability test of the foundation:** a new lesson is a new line in a list, never a special case in one tool (FOUNDATION, "the test of this page").
7. **The course's own revision goes up by one** for every new line or obstacle, with the date and the bug ID that caused it.

### D4. Proposal for later (not built; needs the build chat's own design)

The obstacle lines could become a list file the night run reads, so a new line automatically joins every tool's night run. That is a build question for the build chat, not decided here; no new script is created without Tim's approval (RULES 10.5).

---

## E. Where the built tools stand today

**Source:** `C:\CE_CIVIL\BUILD_LOG.md` and the midday AutoCAD run of 18 Nov 2026 (`acad\night_results\2026-11-18_midday`, results at 12:17 to 12:22 pm). Nothing was run for this page.
**Words:** PASS (the whole pass rule is proven where it must be), FAIL, NOT TESTED, UNKNOWN (the logs do not say), and "proposed does not apply" (only the reviewer can decide that). "Parts pass" names what has passed so far.
**The four columns:** Pit, Pipe, Long section, and the seven bench windows together.

### E1. What the midday run showed, in short

1. **CETEST:** 32 PASS, 1 FAIL (exploding a pipe from code loses its note; known, `acad\EXPLODE_GAP.md`), 1 NOT TESTED.
2. **Pit (CEPIT1 to 6):** 10 PASS, 2 FAIL (CEPIT3 and CEPIT5 stopped on the office pit block's own dictionaries; a fix is built and waits for the next run), 1 NOT TESTED.
3. **Pipe (CEPIPE1 to 8):** 16 PASS, 0 FAIL.
4. **Long section (CELEV1 to 7):** 9 PASS, 1 FAIL (CELEV2 expected a branch to be refused; the check was later changed to expect following, D-175, not yet re-run).
5. **Speed (CESPEED):** 12 PASS, 1 FAULT: moving a pit with its pipes took 208 thousandths of a second against a limit of 100.

### E2. Obstacle by obstacle

1. **OC-01 Units:** Pit FAIL, Pipe FAIL, Long section FAIL (each refuses a metre drawing in words, which the pass rule does not allow; becomes PASS for that line if Tim rules refusal, OQ-02); bench NOT TESTED.
2. **OC-02 Plain words:** UNKNOWN for all four (no words scan exists yet).
3. **OC-03 Honest closing line:** Pit UNKNOWN, Pipe UNKNOWN, Long section UNKNOWN (parts pass: CELEV5 says what it put back), bench UNKNOWN.
4. **OC-04 Unknown stays unknown:** FAIL for all four: the windows still say "unknown" and show "Cannot check yet" in amber, and TBC and APPROX. are not printed (BUILD_LOG entry 27 items 5 and 7; rework list item 3). Parts pass: the brain never turns unknown into 0.
5. **OC-05 One value, one place:** Pit FAIL, Pipe FAIL, Long section FAIL (the drawing does not yet keep its designed standards, D-180; parts pass: everything read from the lists, CEPIT1, CEPIPE1, CELEV6); bench FAIL (17 facts typed or held twice, INPUT_AUDIT section 2; P3's kind and lid differ between Pit and Schedule).
6. **OC-06 Typed figures kept:** NOT TESTED for all four (parts pass: CEPIT2, CEPIPE2, CELEV1 in AutoCAD; the bench's clicks type figures; keeping typed figures as a draft on Cancel is not built).
7. **OC-07 Undo and redo:** Pit, Pipe, Long section NOT TESTED ("one undo step is unproven"); bench proposed does not apply.
8. **OC-08 Cancel and preview:** Pit FAIL (CEPIT3); Pipe NOT TESTED and Long section NOT TESTED (parts pass: Cancel writes nothing, CEPIPE3, CELEV2; preview against result not checked in AutoCAD); bench PASS (Escape cancels every window, click script `fix4_escape_everywhere`; there is nothing to apply).
9. **OC-09 Move, copy, erase:** Pit FAIL and Pipe FAIL (copies are named "not yet named", D-179 now wants next free numbers and levels marked assumed; parts pass: CEPIT4, CEPIPE4, CETEST golden copies); Long section NOT TESTED (parts pass: CELEV4); bench proposed does not apply.
10. **OC-10 Labels:** Pit FAIL (a hand-moved tag stays put instead of keeping its offset, D-181, rework not built); Pipe FAIL (labels do not follow a move yet, entry 25 item 8); Long section NOT TESTED (it only changes label words); bench UNKNOWN (D-162: previews must draw text as it will look; redrawn since, not seen by Tim).
11. **OC-11 Levels along a run:** Pit NOT TESTED, Pipe NOT TESTED, Long section NOT TESTED in AutoCAD (parts pass: CELEV1); bench PASS (the brain's 549 tests reproduce Tim's window figures and the 20-pit branched job).
12. **OC-12 Long section on the sheet:** Long section NOT TESTED (not built); Pit, Pipe and bench proposed does not apply.
13. **OC-13 Pit schedule:** Pit, Pipe, Long section proposed does not apply (no schedule tool yet); bench NOT TESTED (the schedule window exists; its rows have not been run against OC-13).
14. **OC-14 Real geometry:** Pipe FAIL and Long section FAIL (bends not built, D-189); Pit NOT TESTED; bench NOT TESTED (parts pass: cover includes the pipe's diameter and the paving, D-146).
15. **OC-15 Names and numbers:** Pit FAIL and Pipe FAIL (D-179, D-183 to D-185 not built); Long section NOT TESTED; bench UNKNOWN.
16. **OC-16 UCS and rotation:** NOT TESTED for Pit, Pipe, Long section (parts pass: CEPIT6 and the turned-pit mover; nothing handles a UCS); bench proposed does not apply.
17. **OC-17 Windows fit:** Pit, Pipe, Long section NOT TESTED (no window has been seen on screen inside AutoCAD); bench FAIL (laptops and 150 per cent scaling not yet built, D-193; parts pass: 1080 and 1440 pictures, 47 layout states).
18. **OC-18 Ours only:** NOT TESTED for Pit, Pipe, Long section (double-click not built); bench proposed does not apply.
19. **OC-19 Protections:** NOT TESTED for Pit, Pipe, Long section, and expected to FAIL: the code holds no locked-layer, xref, REFEDIT or space check; bench proposed does not apply.
20. **OC-20 Nothing shared changed:** NOT TESTED for Pit, Pipe, Long section (parts: no system variable is set anywhere; whether an existing layer's colour is ever reset by "layers made from the list" is UNKNOWN); bench proposed does not apply.
21. **OC-21 Native untouched:** NOT TESTED for Pit, Pipe, Long section (parts pass: plain objects only, idle checks); the command-name line is UNKNOWN for Pit and Pipe (PIT and CD answered before load); bench proposed does not apply.
22. **OC-22 No plug-in:** NOT TESTED for Pit, Pipe, Long section (parts pass: notes invisible to a plain view, saves in three formats; nobody has opened a drawing in AutoCAD without the plug-in and plotted it); bench proposed does not apply.
23. **OC-23 Unfinished is normal:** Pit FAIL (TBC not printed; grey words not done), Pipe FAIL (same; parts pass: CEPIPE7, CEPIPE8 in AutoCAD), Long section FAIL (CELEV2 at midday; a loose start was still refused), bench FAIL ("Cannot check yet" amber).
24. **OC-24 Wrong figures:** bench FAIL (the Detention window would give Kingston rainfall on every Boyd's job and has no council floor, R-008); Pit, Pipe, Long section proposed does not apply.
25. **OC-25 Privacy:** NOT TESTED for all four (no log or fault report exists yet).
26. **OC-26 Speed:** Pit FAIL and Pipe FAIL (moving a pit with its pipes 208 against 100, which is their mover; parts pass: plug-in load 99 thousandths, self-check, window model open and typing inside their limits); Long section NOT TESTED (its measured lines all PASS, CELEV7 and CESPEED; the window on screen and plot, save, pan, zoom are not measured); bench UNKNOWN.
27. **OC-27 Failures contained:** Pit FAIL (CEPIT3 and CEPIT5 broke on the office block's own dictionaries); Pipe NOT TESTED (put-back at nine points proven on the fake drawing only); Long section PASS for what applies (CELEV5 in AutoCAD; damaged and newer notes not yet tried, so strictly NOT TESTED on OC-27.1); bench UNKNOWN.

### E3. The starting score

1. **Full passes:** 2 sure (OC-08 and OC-11 on the bench) and 1 near (OC-27 Long section, missing only the damaged-note case, counted below as NOT TESTED). Call it **3 of 108** (27 obstacles by 4 columns).
2. **FAIL:** 29. Most are known not-built items (the D-177 to D-195 rework, bends, TBC, grey words), not new surprises.
3. **NOT TESTED:** 48, mostly lines that need AutoCAD or a part that does not exist yet.
4. **UNKNOWN:** 12.
5. **Proposed does not apply:** 17, waiting on a reviewer.
6. **What it says:** the brain and the drawing link are sound where they have been run (the midday run passed 79 of its 86 checks, counted from the result files). The course's job now is the half nobody has tested yet: protections, settings, undo, words, privacy.

---

## F. What it will not catch

1. **Engineering judgement.** Whether a pit should be 600 or 900, whether a grade is sensible for the site, whether storage belongs in a tank or a pipe. The course checks the sums are honest, never that the design is good.
2. **Whether a sheet looks right.** Line weights, crowding, how a label reads on paper, whether a council officer will accept it. Only a look (Codex) and finally Tim's eyes judge that (RULES 5.7).
3. **Council rules nobody has entered.** If a council's floor, rainfall or minimum is not in the list, OC-05 makes the tool say "not checked", but no test can know the rule exists.
4. **Figures that are wrong in the list itself.** The course proves every tool reads the same figure; it cannot prove the figure is right. A wrong office figure is wrong everywhere, consistently.
5. **Real drafting habits the old bugs never showed.** A new way of working (a new council, a new kind of job) will find mistakes no obstacle covers yet; part D turns each into a line once found.
6. **AutoCAD's own faults.** If AutoCAD itself misbehaves (as R-006 thinks the hatch trouble may be), OC-21 shows it happens with and without the plug-in, and stops there.
7. **Tim's acceptance.** No count of passes replaces "Me, or a robot pass if I am busy" (D-089), and anything needing engineering judgement still needs his word (RULES 4.5).
8. **The sorting itself.** The bug counts rest on a once-over sort of cut-short bug text; a few bugs will sit under the wrong obstacle. That changes counts, not rules.

---

## G. Questions for Tim

1. **OQ-01 Is this the gate?**
   1. **Context:** this course decides when a tool may be called built and tested. Today the builders decide that from their own tests.
   2. **Example:** the Pit tool passed 10 of 13 of its own checks at midday, but on this course it has no full pass yet, because nobody has tried a locked layer, undo or a metre drawing.
   3. **Recommended:** yes. Every tool goes through all 27 obstacles; "does not apply" only from the reviewer; NOT TESTED never counts.
2. **OQ-02 A drawing set up in metres: work in it, or refuse?**
   1. **Context:** the Pit, Pipe and Long section tools refuse any drawing not in millimetres today, in plain words. 45 old bugs came from metre drawings handled badly.
   2. **Example:** a consultant's background arrives in metres and the drafter types PT. Refusing means re-setting the drawing first; working means the pit is drawn 0.9 wide instead of 900 and labels plot the same.
   3. **Recommended:** work properly in metres, and say once "This drawing is in metres; CE is working in metres." That keeps your "no hard blocks" rule, and OC-01 tests both.
3. **OQ-03 Moving a pit with its pipes: keep the 0.1 second limit?**
   1. **Context:** the midday run measured 0.21 seconds on a 2,500-object drawing, twice the draft limit. Most of it is finding which pipes point at the pit.
   2. **Example:** you drag a pit across the plan with MOVE: at 0.21 s you may feel a slight catch as the pipes catch up; at 0.1 s you would not.
   3. **Recommended:** keep 0.1 and have the build chat add the lookup list it has already named as the fix; nothing new starts until it passes.
4. **OQ-04 A detention job with no site rainfall entered: what happens?**
   1. **Context:** the Detention window today uses one Kingston job's rainfall for every site, silently (R-008). On the Glen Eira example that is 30 per cent short.
   2. **Example:** the drafter sizes a tank before looking up the Bureau figures. Option A: storage shows amber "rainfall is the office sample", prints APPROX. and goes on the Unfinished list. Option B: no storage figure until rainfall is entered.
   3. **Recommended:** A. It keeps the drafter moving, never hides the guess, and APPROX. on the sheet stops it going out unnoticed.
5. **OQ-05 Council minimum runoff C: which councils, from which documents?**
   1. **Context:** the old bug (BUG-1095) undersized tanks by about a quarter on Darebin, Maribyrnong and Boroondara jobs. The new plug-in has no council floor yet. This is an engineering figure, so it needs your word.
   2. **Example:** a 600 m² Darebin lot works out at C 0.70; with the floor it is 0.80 and storage goes from 2.84 to 3.75 m³.
   3. **Recommended:** enter the floor for those three councils from the council documents already on file (reference C-003 and the others), each with its source and page, as list lines; you confirm each figure once.
6. **OQ-06 "Cannot check yet": quiet grey or amber?**
   1. **Context:** you ruled loose pipes quiet (D-176). Checks that cannot run yet still show amber "Needs a look" in the windows.
   2. **Example:** a new pit before the cover level is known: amber on every card looks like a problem; grey says "not yet" without nagging.
   3. **Recommended:** grey, with the words; amber and red only for decided figures that are doubtful or wrong (SITUATIONS rule 13).
7. **OQ-07 An office layer already in the drawing with a different colour: leave it, or set it to the list?**
   1. **Context:** OC-20 says a tool never alters anything shared. A tool makes a missing layer from the office list, but a layer may already exist with another colour (an old job, a colleague's change).
   2. **Example:** STORMWATER PIPE exists in colour 3 instead of the list's colour. Leave it and say once, or quietly fix it to the list.
   3. **Recommended:** leave it and say once ("STORMWATER PIPE is colour 3 here; the office list says 150"), with a one-click fix. Never changed silently.
8. **OQ-08 What may a fault report carry?**
   1. **Context:** 20 old bugs were about logs and reports leaking logins, PC names, paths and job names. The new plug-in has no report yet.
   2. **Example:** a colleague's AutoCAD jams placing a pit. The report could carry: the CE version, the commands typed, the message shown, a coded drawing name and the drawing's object counts.
   3. **Recommended:** only those, never a path, login, PC name, client or job name, never the drawing itself unless the drafter attaches it; the drafter sees the whole report before it goes, and it goes to you only.
9. **OQ-09 PIT and CD already answer in AutoCAD before CE loads: keep them?**
   1. **Context:** the midday run's name list shows both names already did something before the plug-in loaded (from AutoCAD itself or your alias file; the file does not say which). LG was checked free; these were not.
   2. **Example:** if CD is one of your aliases, typing CD may run your old command on one PC and the Pipe tool on another.
   3. **Recommended:** the build chat reads which it is and reports; if it is your alias, you choose to move your alias or pick another name; OC-21.3 then checks every name every night.
10. **OQ-10 Compare native behaviour with your old plug-ins loaded too?**
    1. **Context:** OC-21 compares AutoCAD with and without the new plug-in. Your colleagues will have old and new side by side for a while.
    2. **Example:** the hatch trouble (BUG-1461) happened with the old plug-ins loaded; a test with only the new one would not see a clash between the two.
    3. **Recommended:** yes, a third session with old and new loaded together, on test copies, once the new plug-in is ready to sit beside the old one.

---

*End of the obstacle course, revision 1. Sources read: R-007 and its six result files (all 597 pile-A lines placed), FOUNDATION.md, UI_PLAN.md, SITUATIONS.md (18 rules and Tim's 18 answers), INPUT_AUDIT.md, PERFORMANCE.md, LOOPS.md, HOW_WE_WORK.md, R-006, R-008, DECISIONS D-162 to D-213, `C:\CE_CIVIL` DESIGN.md, BUILD_LOG.md, `acad\NIGHT_TEST.md`, the midday run's result files, `bench\WINDOW_BRIEF.md`, and the code folder lists. Nothing was run, built, installed or committed.*
