# Director's summary (the page Tim gets every time he asks "how are things going")

**Why this file exists.** Tim, 17 Nov 2026: "i need a way to understand wht we have planned, what we have built, how close we are to finishing or getting a ready version for me to test and bugs and anythign else thats important if i was a director looking to get summaries. i need this everytime i ask how things are going and also you need to keep me on track with planning, building annd beyond". The planning chat updates this page before every progress answer and always uses these seven headings in this order.

**Last updated:** Wed 18 Nov 2026, 8:35 am.

## 1. Headline

The seven windows are ready for you to try, outside AutoCAD. The AutoCAD part has started and its foundation passed 24 of 25 checks inside real AutoCAD overnight. There is no version to draft with yet.

## 2. Planned: 17 of 18 steps

Done: ribbon, names, the look of every window, the foundation, the first-release list (7 tools), how we work, the plan, the six loops (`stage6\LOOPS.md`), the research on testing faster (`reference\research\R-004`). Left: step 16, your verdict after using the windows (`stage6\TRY_THE_WINDOWS.md`, ten minutes).

## 3. Built (four separate facts)

1. **The brain:** built 5 of 5 pieces; 536 automatic checks pass; each piece reviewed by something that did not build it.
2. **The seven windows on a test bench, outside AutoCAD:** built 7 of 7; 241 checks and 1,170 click steps pass on the builder's side.
3. **Independent trial of the windows:** three full runs overnight by a tester that did not build them, real mouse and keyboard. Run 1 found wrong figures (commas, impossible figures shown green). Run 2 found more (Levels bent a held grade). Run 3: no wrong figure found, 155 of 155 steps, all seven ready for you, five with a named caution.
4. **The AutoCAD foundation** (hidden notes on ordinary objects, joins, self-check): written; 87 checks on a pretend drawing; two runs inside real AutoCAD 2027 on a test copy: 23 of 25, then 24 of 25. One gap left: exploding a pipe from code loses its note.
5. **Tools for AutoCAD:** the Pit tool (PIT / PT) is BUILT and reviewed against a pretend drawing (18 Nov, 8:30 am) but has NOT run in AutoCAD; its first AutoCAD run is tonight after 5:30 pm. Pipe is being built now. Tools proven in AutoCAD: 0 of 7.
6. **Installed: 0. Accepted by you: 0.**

## 4. How close to a version you can test (estimates, not promises)

1. **Windows to click, outside AutoCAD:** now.
2. **Pit and Pipe you can draft with in AutoCAD:** about 1 to 2 weeks.
3. **First release, all seven tools, on your PC:** about 4 to 8 weeks.
4. **Colleagues:** after one real job carried through by you; add 1 to 2 weeks.
5. Good sign for the estimate: the new test method runs a full AutoCAD pass in about 2 min 20 s (the old way took about 16 min), so each night can fit many passes. The figures tighten after the first AutoCAD night on the Pit tool (tonight).
6. Stages: A trials mostly done · B foundation: brain yes, AutoCAD side 24 of 25 · C windows done on the bench · D tools in AutoCAD 0 of 7 · E one real job not started.

## 5. Problems and bugs

1. **Open in the windows (none a wrong figure):** Levels draws an over-held gap on one pipe; Levels has an inner scroll bar and a cut-off list; "350" alone refused in Pit; small layout and wording items. All listed in `stage6\TRY_THE_WINDOWS.md` and with the build chat.
2. **Exploding a pipe from code loses its hidden note** (typed EXPLODE kept it in the earlier trial). Needs a typed check with you watching.
3. **Grip trial crashed AutoCAD** (17 Nov). Cause not proven. Ordinary AutoCAD grips only until understood.
4. **Double-click** opens our window but AutoCAD's own polyline edit also runs. Not solved.
5. **SECURELOAD reads 0 in your normal AutoCAD profile** (default 1). Left by the first trial run on 16 Nov. At 0 AutoCAD loads any program without asking. Your call to set it back; our night tests would then need a trusted folder, also your call.
6. **Not proven:** facts in the Properties palette; the ribbon on screen; update inside AutoCAD; the 2560 x 1440 screen for real; the Boyd's "storage needed" figure by hand.

## 6. Waiting on Tim

1. **Step 16:** try the seven windows, ten minutes, five answers.
2. SECURELOAD: set back to 1, or leave.
3. Two boxes not in the approved mock-ups: "what is over it" in Pipe; pipe size in Detention. Add them?
4. Slab thicknesses (path 0.10, driveway 0.125, crossover 0.15) are the planning chat's guesses: correct them.
5. Upper limits for the "Needs a look" lines (how deep, how big, how flat is silly): the build chat's figures are DRAFT.
6. Detention blue (colour 160) on a real plot; AS 3500.3 underside-of-pavement check; one council's step irons wording.
7. Ten small DRAFT calls on the Pit tool (the office block as the symbol, label positions and others): to come to you as one clickable batch.
8. A new outside library used for tests only (reads saved drawings): DRAFT for your yes.
9. Parked from the testing research: the no-screen engine, Autodesk's cloud engine, a second machine.
10. The other leftovers of the first trial run.

## 7. Next step (one only)

You: try the seven windows with `stage6\TRY_THE_WINDOWS.md`.
