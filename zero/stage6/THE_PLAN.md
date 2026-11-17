# Stage 6: the plan (draft 1, for Tim to approve)

**Written:** Mon 16 Nov 2026 night, by the planning chat "CE_ACAD / zero plan / 01". **Status: draft. Not approved.** It is built only from what Tim has decided (`DECISIONS.md` D-001 to D-114) and the documents named below. Where something is not proven it says so.

## 1. What is being built, in one paragraph

A new CE civil drainage plugin for AutoCAD 2027, built from a blank page, with the old plugin used only as a parts bin. The drafter places pits, pipes, inlets and tanks with short typed commands; each opens one window, the same family every time, with a live preview. Every number is held once, shows where it came from, and is either held or worked out ("hold what is fixed, the rest is worked out"). What is drawn is only ordinary AutoCAD linework, text and the office's own blocks, so a person with no plugin can open, edit and plot the sheet.

## 2. The documents that govern the build (read in this order)

1. `design\FOUNDATION.md`: the seven blocks. The test for every change: a new variable, thing or council rule is a new line in a list, never a new piece of screen.
2. `design\UI_PLAN.md`: how every window looks and behaves.
3. `UI_UX_RULES.md`: Tim's standing screen rules.
4. `stage5\HOW_WE_WORK.md`: built, tested, installed, accepted as four facts; one tool at a time; nothing new while a ribbon tool is broken.
5. `DECISIONS.md`: Tim's rulings in his words. If anything here disagrees with a decision, the decision wins.
6. The working mock-ups in `pictures\` (pit, pipe, run levels, inlet, tank, detention, schedule): each is the approved direction for its window ("right track"; full verdict only after real use, D-087).
7. `reference\`: the office's elements, sums, limits, councils and standards, each with its evidence.
8. `stage3\PARTS_BIN_REPORT.md` with D-094 to D-096: what is taken and what is left behind.
9. `reference\research\R-001` and `R-002`: what Autodesk's own pages say; and `stage4\TRIALS_BRIEF.md`.

## 3. The first release (D-097 to D-110)

1. **Pit** (PIT / PT): junction, grated, plastic, orifice, pump pit and bought-in units.
2. **Pipe** (PIPE / CD): new stormwater, charged, suspended, detention (own kind, layer and blue, with a legend line); twin as one pipe.
3. **Levels along a run** (LEVELS / LV): from either end.
4. **Inlets** (DOWNPIPE / DP, OVERFLOW / OF, FO, INSPECTION / IO, GIO, FLOORWASTE / FW).
5. **Tank** (TANK / TK), its note and leader.
6. **Detention** (DETENTION / DET): Boyd's and OSD4W / Swinburne; two answers; fills the criteria box.
7. **Pit schedule** (SCHEDULE / SH): placed once, then follows the pits.
Underneath all of them: the foundation, the office list of standards, a self-check when a drawing opens, the ribbon (short CE Civil tab plus a light tab on selection), and one-click update.
**Not in the first release:** title block and issue; silt and soakage pits; typed-in council figures and council calculators; job tracking hand-over to the Job Manager; CE everyday helpers; Manager changes; taking up old drawings; anything structural.

## 4. The order of work

1. **Stage A, the trials.** ON HOLD (PARKING_LOT P-08). Nothing starts AutoCAD until Tim agrees how. Trial 11 (sums in any direction, no AutoCAD) may run at any time. The brief must be rewritten first to forbid making profiles, force-closing AutoCAD, and running where a licence window can appear.
2. **Stage B, the foundation.** Facts with value, source and hold; sums that work in any direction; joins; the office list; the hidden note on ordinary objects; the self-check on open; the no-plugin proof. No tool on the ribbon yet.
3. **Stage C, the window frame and shared parts** from the UI plan, proven with the Pit window.
4. **Stage D, one tool at a time,** each through mock-up, build, test by something that did not build it, install once, accept: Pit, Pipe, Levels along a run, Inlets, Tank, Detention, Pit schedule.
5. **Stage E, one real job** (a house or two-unit job) carried from blank drawing to issue by Tim. Then colleagues.
No dates are given until the trials are done.

## 5. What is taken from the old plugin, and what is not (D-094 to D-096)

1. **Taken, each re-checked against a real job first:** orifice sums; storage in pipes, pits and tanks; rainfall data and curve; pipe capacity sums with their known-right answers; the office's own blocks; pit schedule row rules.
2. **Council figures:** only the sourced ones, with their source. The rest start blank until a real council letter gives them.
3. **Left behind:** the special one-piece pipe object; the linking code built round it; facts held in several places with repair commands; the settings store where a new value needs new code; the old windows.

## 6. What is NOT yet proven (the honest list)

1. Whether joins on ordinary objects survive every everyday AutoCAD command, and move as one undo step.
2. Whether the plugin's facts can show and be edited in AutoCAD's own Properties palette by the planned route. If not: an own side panel.
3. Whether a live preview of real drawing geometry inside an 80% window keeps up, and Inspect returns with its state.
4. Whether sums in any direction stay quick and predictable on a branched run with many held values.
5. Whether a sheet edited with no plugin comes back and is reported correctly.
6. Whether each typed name is free in AutoCAD 2027.
7. None of the windows has been used for real work, and their padlock clicks and typing were never tested by anyone but Tim.
If a trial fails, the build approach changes before any tool is built.

## 6a. What the trials of 16 Nov 2026 showed (read the trial results file for detail)

1. **Proven:** sums in any direction (plain code, far faster than needed); joins on ordinary objects through move, copy, mirror, rotate, stretch, save and reopen; a sheet with no plugin looks and plots identical, edits plainly, and the change is reported on return; a real AutoCAD picture as the live preview in about 21 to 39 ms, with Inspect keeping the typed values; speed about 40 ms per move on 2500 objects.
2. **Build approach changes:** a join is kept as a soft pointer on the object itself; joined pipe ends are moved at the end of the command (one undo step); a position stamp is kept with each note; no drawing-wide shelf of facts keyed by handle.
3. **Still not proven:** grips and double-click (need a real mouse); facts in AutoCAD's own Properties palette; the ribbon tab and tips on screen; the AutoCAD side of update and rollback; AutoCAD LT; a 2560 x 1440 window on a real screen; Tim's installed plugins were loaded during the trials and any interaction is unmeasured.

## 7. Open items carried into the build (none blocks the start)

1. How long a run is before an inspection opening is offered (AS 3500.3 figure not found online).
2. Detention layer name and its blue.
3. OSD4W inputs (not in the reference).
4. Tank sizes, diameters and heights for the office list; how FO and OF are drawn.
5. A pipe now stops at the pit's inner wall line (D-102): new sheets differ from old at pit edges.
6. How the plugin hands job facts to the Job Manager program.
7. Old drawings made with the special pipe object.
8. Stage 1 (how the office designs and draws) never had a formal "approve".

## 8. How building starts

In a NEW chat, never the planning chat. Its opening brief is `stage6\BUILD_CHAT_BRIEF.md`. The planning chat stays the place where Tim's decisions are recorded.

## 9. Speed (added 18 Nov 2026, D-165)

Speed is a requirement, checked like a sum: see `stage6\PERFORMANCE.md` (time limits for everything a drafter feels, measured every night; the smart ways the build keeps it fast; the PC protected in work hours).

## 10. The loops (added 18 Nov 2026, D-158 to D-160)

How the work keeps moving without Tim: see `stage6\LOOPS.md`.
