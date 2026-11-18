# Director's summary (the page Tim gets every time he asks "how are things going")

**Why this file exists.** Tim, 17 Nov 2026: "i need a way to understand wht we have planned, what we have built, how close we are to finishing or getting a ready version for me to test and bugs and anythign else thats important if i was a director looking to get summaries. i need this everytime i ask how things are going and also you need to keep me on track with planning, building annd beyond". The planning chat updates this page before every progress answer and always uses these seven headings in this order.

**Last updated:** Wed 18 Nov 2026, 1:50 pm. Everything open across every chat is on `BOARD.md`; what is decided now on any subject is in `rulings\`.

## 1. Headline

The plan is now checked against everything the office does, which it was not before today. Three tools run in real AutoCAD on test copies and pass almost every check. There is no version to draft with yet, and the first release is about three times the size of the first seven-tool list.

## 2. Planned

1. **The 18 checklist steps:** done.
2. **Today's correction (D-220):** the first-release list had never been checked against a full list of what the office's tools do. Now it has: 648 typed names mapped (`design\FUNCTION_MAP.md`), and a plan for every one that had none (`design\FUNCTION_PLAN.md`, 77 lines; tick sheet with Tim). Three made-up jobs walked from blank drawing to a council set: 49 of 96 steps were covered before, 96 of 96 after.
3. **First release, as proposed, 31 tools:** 12 civil (Pit, Pipe, Long section, six inlets, Tank, Detention, Schedule, plus Outlet, a Job window, legal point of discharge, trench grate, ag drain), 18 shared (CLEAN first) and the Manager; plus palette blocks. Not yet approved line by line.
4. **The gate:** every tool must pass the 27-test obstacle course (`stage6\OBSTACLE_COURSE.md`, D-216). Speed is a requirement (`stage6\PERFORMANCE.md`). Testing records every run and grows a check for every fault (R-70).
5. **Rulings today:** D-162 to D-230. Colour scheme and preview settled; PIT BLOCK 3 exactly as it is; metre drawings must work; unfinished is normal; assumed prints APPROX., unknown prints TBC; cover levels are the engineer's.

## 3. Built (four separate facts)

1. **The brain:** built, 549 automatic checks pass.
2. **Seven windows on a test bench:** built; three independent trials; the last found no wrong figure. Tim has used all seven. The new scheme, preview and schedule changes are not in them yet.
3. **AutoCAD foundation, Pit, Pipe, Long section, Outlet:** built and run twice in real AutoCAD 2027 on test copies on 18 Nov. Second pass: Pit 15 of 16 (1 not tested), Pipe 16 of 16, Long section 11 of 11, foundation 32 of 34. A full pass takes about 6 minutes (the old way: about 16 for less).
4. **Against the obstacle course:** 3 of 108 at the first count, before the second pass; most are simply not tested yet. Being re-scored.
5. **Speed, first real figures:** every limit met except one: moving a pit with its pipes the first time in a session, 0.21 s against 0.1 s. Not yet fixed or re-measured.
6. **Installed: 0. Accepted by Tim: 0.**

## 4. How close to a version you can test (estimates, not promises)

1. **Windows to click, outside AutoCAD:** now.
2. **Pit and Pipe you can draft with in AutoCAD:** about 2 weeks. Rework from today (bends, PIT BLOCK 3, metre drawings, locked layers) is inside that figure.
3. **The whole first release (31 tools):** no figure yet. If the seven-tool list was 1, this is about 3. A figure will be given once two or three tools have been through the gate and the time per tool is measured, not guessed.
4. **Colleagues:** after one real job carried through by Tim.

## 5. Problems and bugs

1. **Live risk in the INSTALLED plug-in (BUG-866):** with no site rainfall loaded, detention storage can come out 10 to 17 per cent short on some sites while the wording says it is safe. Until fixed: load the site's rainfall first; do not issue a storage figure beside "This job has no rainfall curve of its own". Jobs for three councils sized before 30 Oct may also be short (BUG-1095, fixed since).
2. **The new plug-in would have repeated both** as its data stood; being fixed now, with tests.
3. **New plug-in, known gaps:** nothing yet handles locked layers, xrefs, reference editing, paper space or a rotated UCS; metre drawings are refused (must work, D-217); bends not built; four jobs copied into each tool instead of shared. 28 open items in `NEW_BUGS.md`.
4. **Exploding a pipe from code loses its hidden note.** Needs a typed check.
5. **Grips:** the trial crashed AutoCAD; different grip icons are not proven possible on 2027; double-click also runs AutoCAD's own polyline edit.
6. **Native hatches misbehave in Tim's AutoCAD** (BUG-1278, BUG-1461): about 85 per cent sure it is not the CE plug-ins; not proven.
7. **PIT and CD are already commands in Tim's AutoCAD** (old plug-in): the two cannot share those names.
8. **SECURELOAD reads 0** in his normal profile, left by the first trial.
9. **The record itself:** the board's first check found 22 stale or contradictory places; most fixed the same day; the rest are listed in `BOARD.md` section 10.

## 6. Waiting on Tim (37 on the board; these are the ones that matter now)

1. **Seen the BUG-866 advice?** Reply "seen".
2. **The function plan tick sheet:** agreed unless he says otherwise; five questions first.
3. **Council minimum runoff figures** for two councils: needs a council document; left blank until then.
4. **SECURELOAD:** set back to 1, or leave.
5. **Picture sheets of 104 unknown blocks** to tick (interview chat).
6. **Three pairs of his own rulings that pull against each other** (tank re-use; what a new pipe opens with; side panel or Job window): to be put to him one at a time.
7. Everything else is held on the board and brought to him only when it blocks something.

## 7. Next step (one only)

Tonight after 5:30 pm: the Pit tool re-run on PIT BLOCK 3, with speed re-measured. Before then: the evidence-based proposal for the easiest, most AutoCAD-like way to use the plug-in (D-230).
