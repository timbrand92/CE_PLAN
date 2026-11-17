# Director's summary (the page Tim gets every time he asks "how are things going")

**Why this file exists.** Tim, 17 Nov 2026: "i need a way to understand wht we have planned, what we have built, how close we are to finishing or getting a ready version for me to test and bugs and anythign else thats important if i was a director looking to get summaries. i need this everytime i ask how things are going and also you need to keep me on track with planning, building annd beyond". The planning chat updates this page before every progress answer and always uses these seven headings in this order.

**Last updated:** Wed 18 Nov 2026, 5:10 am.

## 1. Headline

The plan is finished bar your verdict on the windows. The thinking part and all seven windows are built and tested OUTSIDE AutoCAD. The AutoCAD part has your yes (D-158) and starts tonight. There is no version for you to draft with yet.

## 2. Planned: 17 of 18 steps

Done: ribbon, names, the look of every window, the foundation, the first-release list (7 tools), how we work, the plan itself. Added 18 Nov: the six loops that carry the work (`stage6\LOOPS.md`) and the research on testing faster (`reference\research\R-004`). Left: step 16, your verdict after using the windows.

## 3. Built (four separate facts)

1. **The brain** (facts, sums, joins, office standards, checks): built 5 of 5 pieces; 488 automatic checks pass; each piece reviewed by something that did not build it. Your rulings D-140 to D-156 are in.
2. **The seven windows on a test bench, outside AutoCAD:** built 7 of 7; 147 checks and 880 click steps by the build chat's own scripts pass. An independent look at every opening screen found every figure right and 10 faults of wording and layout; those are fixed and in review, with two layout faults sent back.
3. **Independent click and typing trial of the windows:** run twice (18 Nov, 2:25 am and 5:00 am). Second run: most faults confirmed fixed; SIX windows ready for Tim with cautions; LEVELS ALONG A RUN NOT READY (it bends a held grade instead of saying "out by"). Wrong figures remain in Levels, Pipe (green Suits while over-held) and Tank (levels worked from the list size when a size is typed). With the build chat to fix; then a third run.
4. **The AutoCAD part:** the foundation code is written (85 checks on a pretend drawing) and had its FIRST RUN INSIDE AUTOCAD 2027 on 18 Nov, 4:50 am, on a test copy: 23 of 25 checks pass. The new fast test method works: the whole pass took about 2 min 20 s from double-click to close, against about 16 min the old way. Our hidden notes were read back from the saved drawings without AutoCAD (6 of 6). Two faults found: a layer fault in the adapter, and exploding a pipe from code loses its note. AutoCAD was closed normally; nothing installed. Tools built in AutoCAD: 0 of 7.
5. **Installed: 0. Accepted by you: 0.**

## 4. How close to a version you can test (estimates, not promises)

1. **Windows to click, outside AutoCAD:** 1 to 2 days.
2. **Pit and Pipe you can draft with in AutoCAD:** about 1 to 2 weeks.
3. **First release, all seven tools, on your PC:** about 4 to 8 weeks.
4. **Colleagues:** after one real job carried through by you; add 1 to 2 weeks.
5. These tighten after the first AutoCAD night on the Pit tool. The old plugin looked finished on the bench and failed in AutoCAD on 16 Sep, so nothing is called close until it has worked in AutoCAD.
6. Stages: A trials mostly done · B foundation half (brain yes, AutoCAD side starting) · C windows done on the bench · D tools in AutoCAD 0 of 7 · E one real job not started.

## 5. Problems and bugs

1. **Grip trial crashed AutoCAD** (17 Nov). Cause not proven. Pits and pipes will use AutoCAD's ordinary grips only until it is understood.
2. **Double-click:** opens our window, but AutoCAD's own polyline edit also runs. Not solved.
3. **Not proven:** facts in AutoCAD's Properties palette; the ribbon on screen; update inside AutoCAD; the 2560 x 1440 screen for real; the new one-start test method inside AutoCAD 2027; reading our hidden notes from a saved drawing without AutoCAD.
4. **Leftovers from the first trial run** are still on your PC for you to look at. One matters: the security setting SECURELOAD reads 0 in your normal profile (AutoCAD's default is 1). It was set by the first trial run on 16 Nov and never put back, because no chat may change a saved setting. At 0, AutoCAD loads any program without asking. Your call whether to set it back to 1; if you do, our night tests need a trusted folder, which is also your call.
5. **Wrong figures found in the windows** by the independent click and typing trial (18 Nov, 2:25 am; all seven windows, 635 of 646 real click steps): a number typed with a comma quietly becomes another number in five windows ("0,8" deep becomes 0.00 and shows green); impossible figures (a negative depth, paving bigger than the site) show green "Suits"; a typed-over schedule cover level does not change the depth; a typed tank size does not change its litres; the window X and Escape do nothing; some warnings are missing (step irons, small detention pipe). The sums themselves were right wherever a sensible figure was typed. All sent to the build chat to fix before Tim tries the windows.
6. No person has used the windows yet.

## 6. Waiting on Tim

1. Step 16: try the seven windows and give your verdict (after the independent trial).
2. Slab thicknesses (path 0.10, driveway 0.125, crossover 0.15) are the planning chat's guesses: correct them.
3. Look at the detention blue (colour 160) on a real plot.
4. Whether cover is measured from the underside of the pavement in the printed AS 3500.3: not checked.
5. One council's step irons figure (0.9 m): needs the council's own wording; left blank.
6. A new outside library for tests only (reads saved drawings): listed as DRAFT for your yes.
7. Decisions parked from the testing research: the no-screen engine, Autodesk's cloud engine, a second machine.
8. The leftovers of the first trial run.

## 7. Next step (one only)

The build chat fixes the wrong figures the trial found; the trial is run again; then your ten-minute list to try the windows.
