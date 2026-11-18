# Current rulings: First release (what is in, what is not, the order of work)

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### The plan itself

1. **`stage6\THE_PLAN.md` draft 1 is the plan the build works to:** trials, foundation, window frame, one tool at a time, one real job, colleagues; no dates until the trials are done (D-115).
2. **AutoCAD 2027 only; civil, CE tools and Manager now; structural later** (D-008, D-006).
3. **2 to 5 people will use the civil tools in the first year** (D-026).

### In the first release

4. **Civil tools:** Pit, Pipe, Levels along a run (now Long section), Downpipe and the other inlets, Tank and detention sums, Pit schedule (D-097).
5. **Detention methods:** Boyd's and OSD4W / Swinburne (D-098).
6. **Pit kinds:** junction, grated, plastic, orifice, pump pit and bought-in units (D-104).
7. **Pipes with bends on every kind** (D-189).
8. **Other drains:** trench grate, AG and perimeter drains (D-223).
9. **Outlet:** the council pit or kerb outlet connected to is a proper outlet (D-190), with an Outlet tool added (THE_PLAN change note) and the legal point of discharge label as its own small tool (D-222). **Superseded by D-274 (18 Nov):** one tool, LEGALPOINT / LPD, does both; OUTLET as a separate tool goes (item 27).
10. **All 18 shared tools, CLEAN first,** each working and tested before release (D-201, D-209, D-214).
11. **A small Manager** (updates and version, health and fault report, office lists, job link, one admin page) (D-204; in the first release per THE_PLAN change note, the planning chat's reading).
12. **Underneath:** the foundation, the office list of standards, a self-check when a drawing opens, the ribbon of three tabs with a light tab on selection, and one-click update (THE_PLAN section 3; D-028, D-200, D-208).

### Not in the first release

13. **Title block and issue** (D-097).
14. **Silt and soakage pits** (D-104).
15. **Council-supplied figures typed in and the council's own calculator** (D-098).
16. **"Changed since last issue" list with "Mark as issued"** (D-187).
17. **Strip drain** (D-223).
18. **Taking up old drawings:** new jobs first, old hand-drawn drawings still open and plot (D-027); a one-off "make it ordinary" tool for the old special pipe comes later (D-119).
19. **Other existing drains stay hand-drawn** (D-190).
20. **Statistics, wider admin control and a better overall system** (D-205).
21. **Structural-only tools** (D-201, D-006).

### The order of work

22. **One tool at a time, each finished before the next** (D-091); **nothing new while a ribbon tool is broken** (D-090).
23. **Stages:** A trials; B foundation; C window frame and shared parts proven with the Pit window; D one tool at a time: Pit, Pipe, Long section, Inlets, Tank, Detention, Pit schedule; E one real job from blank drawing to issue by Tim, then colleagues (THE_PLAN section 4, approved by D-115).
24. **Build started:** the brain first, with no AutoCAD (D-127); then the window frame and all seven bench windows as a stand-alone test program (D-137, D-138); then the AutoCAD part, the foundation, then Pit, then Pipe, with nothing installed without Tim's yes (D-158).
25. **The five input changes, in order** (D-171; see FOUNDATION).
26. **The obstacle course is the gate every tool must pass** (D-216).

### Added 18 Nov 2026, D-230 to D-297

27. **One LPD tool for the end of a system (D-274):** ONE tool, LEGALPOINT / LPD, replaces the separate Outlet tool and the small LPD label tool; the civil tab is now 11 windows (see OUTLET_AND_LPD).
28. **Kinds of system end in the first version (D-273):** kerb and council pit; easement drain or council pipe; existing system on site; soak on site (the soakage sums stay later, D-104).
29. **The new Pit and Pipe tools take PIT and CD from the start (D-258):** while the old plug-in is loaded the old ones stop answering to those names; not proven how AutoCAD chooses, so the build must make the new one win and prove it, or say plainly that it cannot. **The trench grate keeps TG, but only once the old plug-in goes; until then it is tested as TRENCHGRATE (D-233).**
30. **The old scattered commands are consolidated into few tools, each a window (D-246):** the plan of how everything that exists today works for the end user is owed, shown as the drafter's picture (see DIRECTION and OLD_PLUGIN).
31. **Every window in the first release is built to the approved style and screen rules (D-286, D-295), preview at the left (D-296), preview size and form open (D-297):** see SCREENS_AND_STYLE.

## Changed along the way

1. **CE everyday helpers and Manager changes "not in the first release" (THE_PLAN section 3, 16 Nov) were changed by D-200, D-201, D-204 (18 Nov), widened by D-209 and confirmed by D-214.**
2. **"One short CE Civil tab" in the plan became three tabs (D-200, D-208).**
3. **HOW_WE_WORK's order still lists "title and issue, CE tools" after the pit schedule;** title and issue is out (D-097) and the CE tools are now in the first release (D-201).
4. **A separate Outlet tool and a small LPD label tool, both in the first release (D-190, D-222), became ONE tool, LPD (D-274, 18 Nov).**

## Still open on this subject

1. **The computations sheet:** only CDCALC makes it today and nothing in the first release prints it (FUNCTION_MAP FM-047); recommendation is to build it straight after release and keep the old CDCALC side by side meanwhile; Tim did not choose (D-220). Waits on: Tim.
2. **A proposed plan for EVERY function-map line not decided or that would be lost (67 names, 37 lines),** for Tim to correct in one sitting, not single questions (D-220, R-69). Waits on: the planning chat. D-246 adds that the function plan (31 tools) must be re-read against "few tools, each a window" and shown as the drafter's picture.
3. **17 retire proposals with a blank tick** (FUNCTION_MAP section 3 B). Waits on: Tim.
4. **Slab group (CDSLAB and the rest), spoon drain, kerb, paving overlay, tree zones, xref compare:** recommended park, not decided (FM-053, FM-057 to FM-060, FM-064). Waits on: Tim.
5. **Where the shared tools and Manager sit in the build order relative to the civil tools:** CLEAN first among shared tools, but the order against Pit, Pipe and the rest is not said (D-201, D-091). Waits on: Tim.
6. **When releases come:** Tim asked "how long until releases?" (D-158); no dates until the trials are done (D-115). Waits on: the planning chat.
7. **The real-job loop:** each tool that passes the night loop is run through a copied finished job (LOOPS loop 3); not started. Waits on: a test.
8. **THE_PLAN header still says "draft. Not approved"; section 4 still says Stage A trials ON HOLD; section 7 item 8 still says Stage 1 never had an approve.** D-115, D-116, D-159 and D-117 have since settled these. Waits on: the planning chat (stale text).
9. **What the robot pass must contain to count as accepted** (HOW_WE_WORK "Not settled" item 3). Waits on: Tim.
10. **Whether the 18 shared tools come before colleagues get anything:** answered "all 18" (D-214), but whether colleagues wait for every civil tool too is in THE_PLAN (stage E) and not restated by Tim. Waits on: Tim.

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-233, D-246, D-258, D-273, D-274, D-286, D-295 to D-297.

1. `stage6\THE_PLAN.md`; `DECISIONS.md` D-026, D-027, D-090, D-091, D-097, D-098, D-104, D-115, D-119, D-127, D-137, D-138, D-158, D-187, D-189, D-190, D-200, D-201, D-204, D-205, D-209, D-214, D-216, D-222, D-223.
2. `design\FUNCTION_MAP.md` sections 2 to 4.
3. `stage5\HOW_WE_WORK.md`.
