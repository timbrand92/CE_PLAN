# Director's summary (the page Tim gets every time he asks "how are things going")

**Why this file exists.** Tim, 17 Nov 2026: "i need a way to understand wht we have planned, what we have built, how close we are to finishing or getting a ready version for me to test and bugs and anythign else thats important if i was a director looking to get summaries. i need this everytime i ask how things are going and also you need to keep me on track with planning, building annd beyond". The planning chat updates this page before every progress answer and always uses these seven headings in this order.

**Last updated:** Wed 18 Nov 2026, 12:30 pm.

## 1. Headline

Planning is finished and today you tested it against real use. Your verdict on the windows and your answers to the real-use questions changed the design for the better. Three tools are built for AutoCAD but two need rework to match how you really draw. First AutoCAD run of them is tonight. There is no version to draft with yet.

## 2. Planned: 18 of 18 steps, plus today's rulings (D-162 to D-196)

1. **Look:** one colour scheme on AutoCAD's own grey, rose accent, colour drawing the eye; status colours for status only.
2. **Preview, every window:** the drawing as AutoCAD shows it, where on the plan, where in the system.
3. **Names:** Tank is TANK / WT. Levels is now LONGSECTION / LG.
4. **Schedule:** the Columns card and scale choice are out.
5. **Speed is a requirement,** with time limits measured every night (`stage6\PERFORMANCE.md`).
6. **Cut the typing:** 85 figures typed on a two-unit job today, 20 to 31 possible; five changes approved in order (`design\INPUT_AUDIT.md`).
7. **Unfinished is normal:** loose pipes are allowed, quiet, and fill in when joined.
8. **Real use:** about 70 situations walked through; all 18 questions answered (`design\SITUATIONS.md`). Among them: assumed prints APPROX., not known prints TBC, cover levels are the engineer's and never the survey's, bends on every pipe, a real outlet, labels move with their pit, the drawing keeps the standards it was designed with.

## 3. Built (four separate facts)

1. **The brain:** built, 549 automatic checks pass, each piece reviewed separately.
2. **Seven windows on a test bench:** built; three independent trials by real mouse; the last found no wrong figure. You have used all seven and called them good, with changes now queued (scheme, preview, schedule cards).
3. **AutoCAD foundation:** two runs in real AutoCAD on a test copy: 24 of 25.
4. **Tools for AutoCAD:** Pit, Pipe, Long section and an Outlet tool are built. **First run inside real AutoCAD 2027, 18 Nov 12:16 to 12:22 pm, on a test copy:** foundation 32 of 34 checks pass; Pit 10 of 13; Pipe 16 of 16 (including join, part, re-join and the outlet); Long section 9 of 10. The whole run took 5 min 41 s. Real fault found: the Pit tool cannot yet read the office's own dynamic pit block in two cases (it trips on the block's own hidden data). Not accepted, not installed.
4a. **Speed, first real figures (limits in brackets):** plug-in start 0.1 s (1 s); self-check on opening a 500-object drawing 0.04 s (1 s); Pit window opens in 0.28 s the first time and 0.05 s after (0.3 s); Pipe window 0.02 s; Long section window 0.1 s; a typed figure follows in 0.02 s or less (0.1 s); idle adds nothing measurable. ONE OVER THE LIMIT: moving a pit with its pipes on a 2,500-object drawing takes 0.21 s the first time in a session (limit 0.1 s) and 0.05 s after.
5. **Rework found today, before any of it reached AutoCAD:** joining a pipe end later; a real outlet; bends; pipe ends that follow a pit's wall; a pit in a blank drawing; grey for not known; labels that move with the pit.
6. **Installed: 0. Accepted by you: 0.**

## 4. How close to a version you can test (estimates, not promises)

1. **Windows to click, outside AutoCAD:** now (the new scheme and preview are not in them yet).
2. **Pit and Pipe you can draft with in AutoCAD:** about 2 weeks. Today's rework adds to the earlier 1 to 2 weeks; it does not shorten it.
3. **First release, all seven tools:** about 5 to 9 weeks.
4. **Colleagues:** after one real job carried through by you; add 1 to 2 weeks.
5. These tighten after tonight's first AutoCAD run of Pit and Pipe.

## 5. Problems and bugs

1. **The tools as built assumed a tidy finished system.** Found today by you and by the walk-through; rework is under way before any new tool.
2. **A build mishap today:** a helper script swapped letters through five files. Proven fully undone by a separate reviewer; a rule now forbids bulk find-and-replace.
3. **Exploding a pipe from code loses its hidden note.** Needs a typed check with you.
4. **Grip trial crashed AutoCAD; double-click also runs AutoCAD's own polyline edit.** Not solved.
5. **SECURELOAD reads 0 in your normal AutoCAD profile** (default 1), left by the first trial run. Your call.
6. **Name clash found in AutoCAD:** PIT and CD are already commands in your AutoCAD (the installed old plug-in). The new and old plug-ins cannot both own those names; how you move from one to the other is a decision still to make.
6a. **Not proven:** facts in the Properties palette; the ribbon on screen; update inside AutoCAD; the corner locator inside AutoCAD; the Boyd's "storage needed" figure by hand.
7. **Speed:** not yet measured in AutoCAD. Tonight's run is the baseline.

## 6. Waiting on Tim

1. One office Stormwater Pit saved as `C:\CE_WORK\civil_tests\blocks\pit_seed.dwg`, or say "copy the template".
2. Three design questions to bring back properly, on a part-drawn job: how the top water level is first chosen; whether the orifice pit is always the last pit; tank re-use against detention.
3. The small DRAFT calls from the Pit, Pipe and Long section tools (about 30), as clickable batches, after the rework.
4. SECURELOAD: set back to 1, or leave.
5. Two boxes not in the mock-ups: "what is over it" in Pipe; pipe size in Detention.
6. DRAFT figures of mine to correct: slab thicknesses; the speed time limits; upper limits for "Needs a look".
7. The standing note wording for APPROX.; what form cover-level help takes; laptop screen sizes.
8. Detention blue on a real plot; the AS 3500.3 underside-of-pavement check; one council's step irons wording.
9. Parked: the no-screen engine (recommended against for now), the cloud engine, a second machine; the first trial's leftovers.

## 7. Next step (one only)

The build chat fixes the Pit tool's reading of the office pit block and re-runs the Pit checks at the next AutoCAD window (tonight after 5:30 pm, or sooner if you free AutoCAD again).
