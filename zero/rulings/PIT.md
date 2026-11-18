# Current rulings: Pit

Current rulings as of 18 Nov 2026, 1:40 pm (Melbourne), from decisions D-001 to D-229. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### What a pit is and how it looks

1. **Its own element:** a pit is an element and a pipe is an element; they work together but are not one element (D-031, which replaced the "one big element" reading of D-011).
2. **Office look:** a pit shows its inner wall line and its outer dashed / hidden line, and the real tool uses the office's own blocks exactly as drawn today (D-039).
3. **Inner wall line:** the inner wall stays as the edge of the block's wipeout, with no extra line drawn; the plug-in tells the drafter when the drawing's wipeout frame setting would hide it or stop it plotting, and the drafter changes the setting, never the plug-in (D-224).
4. **Plastic pit:** the same block sized at 350 x 350, no new state (D-224).
5. **New pits use PIT BLOCK 3 exactly as it is:** five kinds by visibility, size by its two stretches, the five sizes 350, 450, 600, 900, 1200 per side; no renamed parameters, no 50 mm step, no extra inner wall line; the old 16-state "Stormwater Pit" stays readable on old drawings; a size the block will not take is reported to the drafter, who decides (D-228, which settles D-215 and confirms the proposal in D-224; restated as "PIT BLOCK 3 (BK-020)" in D-229).

### Kinds and sizes

6. **Kinds on day one:** junction, grated, plastic, orifice (control) pit, pump pit and bought-in units; silt pit and soakage pit come later (D-104).
7. **Pit size is picked from the list only,** not typed (D-080: pipe size and lid were ticked as pick-or-type, pit size was not).
8. **Pit size by depth:** the guidebook table, 350 to 0.45, 450 to 0.60, 600 to 0.90, 600 x 900 to 1.20 with step irons, 900 x 900 deeper than 1.20; a council condition overrides (D-135).
9. **Typed name:** PIT / PT (D-101).

### Numbers

10. **Numbering:** P1 at the outlet; new pits take the next free number; a Renumber button re-runs them from the outlet upstream when asked (D-075).
11. **Two systems on one site:** one number series, no number used twice on a sheet, each system numbered from its own outlet, the street system first (D-183).
12. **Pit added after the sheet is issued:** the drafter chooses each time among the next free number, a letter such as P3A, or renumbering everything (D-184).
13. **Retyping a pit tag renames the pit:** the schedule row, pipe names and system strip follow, and a duplicate number shows amber on both (D-185).
14. **Placing many:** "Keep clicking, Enter to finish", each numbered in turn (D-186).

### Cover level and drop

15. **Cover levels are locked on every pit:** once typed only the person changes it; working out levels along a run never touches it (D-078, following D-018).
16. **Where a cover level comes from:** the engineer sets it from the internal house levels and the surrounding new and old pavement levels, never from the survey; a cover level not known yet prints "TBC" (D-178).
17. **Help with a cover level:** "HELP IS A SUGGESTION, ENGINEER GETS FINAL SAY"; any help is marked as a suggestion and the engineer's figure always wins (D-195).
18. **Drop across a pit:** office standard 0.02 from invert in to invert out, which can be typed over on a pit (D-141, D-084).
19. **Step irons:** needed deeper than 1.0 m (D-136); a pit that needs them shows amber "Needs a look", with no fourth kind of status (D-149).

### How a pit behaves with pipes and plain AutoCAD

20. **Pit placed on a drawn pipe:** the pipe is split in two, each part with its own label and levels, and "What else changes" says so (D-077).
21. **Erasing a pit with plain ERASE:** its tag, text and schedule row go; the pipes stay and read "not joined yet"; one undo brings everything back (D-221).
22. **Moving a pit with plain MOVE:** the number tag and cover level text go with the pit, and a hand-moved label keeps its offset in both directions (D-181).
23. **Copying to the mirror unit:** pit size and kind copy as they are, levels copy but are marked assumed until confirmed, and copies take the next free numbers (D-179).
24. **Plastic pits in the schedule:** a tick box "In the schedule" on each plastic pit, starting ticked (D-076).
25. **Pits as detention storage:** only pits the drafter ticks (D-105; detail on DETENTION).

### The Pit window

26. **Approved structure and look:** the Pit window (version 3) is approved and is the pattern every other window matches (D-068, D-069, D-070); square preview style (D-067); on the bench "PIT LOOKS GOOD" (D-162).
27. **Night tests:** they use a copy of the office drawing template and place the block themselves; the office template folder is read only (D-197).

## Changed along the way

1. **"One big element" (D-011, 16 Nov) became a pit and a pipe working together (D-031, 16 Nov).**
2. **Cover levels read off the drawing last (INPUT_AUDIT change 5, 18 Nov midday) were withdrawn by D-178 (18 Nov):** the survey never gives a cover level.
3. **R-009's suggested block edits (a real inner wall line, plain names, a 50 mm step, a plastic state, save as PIT BLOCK 4) were answered by D-224 (18 Nov), and then replaced by D-228 (18 Nov afternoon):** PIT BLOCK 3 exactly as it is, no edits.
4. **The office pit for testing was "Stormwater Pit" (midday run, D-197 wording, 18 Nov); D-215 said PIT BLOCK 3 is the one he means, and D-228 (18 Nov afternoon) made PIT BLOCK 3 the block new pits use;** "Stormwater Pit" stays readable on old drawings only.

## Still open on this subject

1. **Whether a turned (rotated) pit is part of the Pit window:** asked once on 16 Nov and never answered (DECISIONS "Open after this sitting", gap check Pit item 9). Waits on: Tim.
2. **Which of the three numbering choices is offered first after issue** (D-184). Waits on: Tim.
3. **"Next free number" means the lowest unused or the highest plus one:** D-075 against DRAFTS_pit 5, not asked (SITUATIONS B9). Waits on: Tim.
4. **Form of the cover level help:** click two trusted levels and work between them, or click one level and type a fall; not picked, both may be drawn for him (D-195). Waits on: the planning chat, then Tim.
5. **Rule for pit kind and lid:** grated where surface water collects, lid class by what is over it (INPUT_AUDIT question 9, L-019). Waits on: Tim.
6. **Pit size when the depth is not known:** proposal to draw at the last-used size marked assumed (SITUATIONS A2, F5). Waits on: Tim.
7. **Pump pit:** which pump workbook version is current, and when a wet well under 3 m³ is acceptable (OPEN_QUESTIONS Q-003). Waits on: Tim.
8. **Silt and soakage pits:** later (D-104); soakage storm starting point not known (Q-013). Waits on: Tim (later).
9. **Which half keeps which held invert when a pit splits a pipe** (SITUATIONS B7). Waits on: the build chat.
10. **A pit dropped on a free pipe end joins it:** SITUATIONS B1 says yes, which reverses DRAFTS_pipe 11.2 "cannot be joined later"; D-176 supports joining. Waits on: the build chat.
11. **Wipeout frame warning:** wording and which setting values trigger it (D-224). Waits on: the build chat.
12. **Bench schedule shows "P0"; it must start at P1 at the outlet** (SITUATIONS D1, D-075). Waits on: the build chat.
13. **Erase and undo of a pit:** the schedule rows coming back after ERASE then UNDO is untested (SITUATIONS C9); erase wording (C8). Waits on: a test.
14. **Moved distance for a "check: pit moved" note:** not known; "say 1 m" is only an example (SITUATIONS C1). Waits on: Tim.
15. **Where a click on the pit wall puts the pipe end:** the build disagrees with D-034 (SITUATIONS B13; DESIGN_PIPE_TOOL 2.4). Waits on: the build chat.
16. **Pit window content:** the choices, their order and words have not been gone through line by line (D-070, UI_PLAN section 9 item 1). Waits on: Tim.
17. **Full verdict on the Pit window** waits on real use (D-087). Waits on: Tim.
18. **CEPIT3 and CEPIT5 failed in the midday run;** a fix is built and waits for the next run (OBSTACLE_COURSE part E). Waits on: a test.

**Closed:** which block the new Pit tool uses, and the proposal "not yet confirmed by Tim in words" (closed by D-228, PIT BLOCK 3 exactly as it is); the night tests using the wrong pit block "Stormwater Pit" (closed by D-228; new pits use PIT BLOCK 3, "Stormwater Pit" stays readable on old drawings).

## Where the detail lives

1. `DECISIONS.md` D-031, D-039, D-075 to D-078, D-104, D-135, D-178, D-183 to D-186, D-195, D-215, D-221, D-224, D-228, D-229.
2. `reference\research\R-009_PIT_BLOCK.md`; `design\BLOCKS_REVIEW.md` (BK-020, BK-022).
3. `design\SITUATIONS.md` sections B, C and D; `design\INPUT_AUDIT.md` (Pit window).
4. `pictures\pit_window_full_size.html`; `design\UI_PLAN.md`.
