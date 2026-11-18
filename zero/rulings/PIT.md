# Current rulings: Pit

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### What a pit is and how it looks

1. **Its own element:** a pit is an element and a pipe is an element; they work together but are not one element (D-031, which replaced the "one big element" reading of D-011).
2. **Office look:** a pit shows its inner wall line and its outer dashed / hidden line, and the real tool uses the office's own blocks exactly as drawn today (D-039).
3. **Inner wall line:** the inner wall stays as the edge of the block's wipeout, with no extra line drawn; the plug-in tells the drafter when the drawing's wipeout frame setting would hide it or stop it plotting, and the drafter changes the setting, never the plug-in (D-224).
4. **Plastic pit:** the same block sized at 350 x 350, no new state (D-224).
5. **New pits use PIT BLOCK 3 exactly as it is:** five kinds by visibility, size by its two stretches, the five sizes 350, 450, 600, 900, 1200 per side; no renamed parameters, no 50 mm step, no extra inner wall line; the old 16-state "Stormwater Pit" stays readable on old drawings; a size the block will not take is reported to the drafter, who decides (D-228, which settles D-215 and confirms the proposal in D-224; restated as "PIT BLOCK 3 (BK-020)" in D-229).

### Kinds and sizes

6. **Kinds on day one:** junction, grated, plastic, orifice (control) pit, pump pit and bought-in units; silt pit and soakage pit come later (D-104).
7. **Pit size is picked from the list only,** not typed (D-080: pipe size and lid were ticked as pick-or-type, pit size was not). **Superseded by D-272 (18 Nov):** any pair the block takes is allowed (item 30).
8. **Pit size by depth:** the guidebook table, 350 to 0.45, 450 to 0.60, 600 to 0.90, 600 x 900 to 1.20 with step irons, 900 x 900 deeper than 1.20; a council condition overrides (D-135). **Changed by D-235 and D-272 (18 Nov):** depth is not the starting rule (the Pit tool opens at 450 x 450) and any pair the block takes is allowed; the table is a guide offered when the depth is known or the pit is added later (items 28 and 30).
9. **Typed name:** PIT / PT (D-101); PP is plastic pit (D-251, item 29).

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

26. **Approved structure and look:** the Pit window (version 3) is approved and is the pattern every other window matches (D-068, D-069, D-070); square preview style (D-067); on the bench "PIT LOOKS GOOD" (D-162). **Look and preview place superseded (18 Nov):** the look is now the approved window style (D-295) and the preview always sits at the left (D-296, which replaces the square style of D-067); the preview's size and form are OPEN (D-297); the structure stands. See SCREENS_AND_STYLE.
27. **Night tests:** they use a copy of the office drawing template and place the block themselves; the office template folder is read only (D-197).

### Added 18 Nov 2026, D-230 to D-297

28. **What the Pit tool opens at, and PP (D-235):** "PP COMMAND SHOULD OPEN PRESET WITH 350 x 350 PLASTIC PIT AND PIT COMMAND SHOULD OPEN WITH 450 x 450, SOMETIMES YOU WONT HAVE THE DEPTH BUT THIS CAN BE A FEATURE IF ADDING PIT AFTER." PIT opens at 450 x 450 and PP opens a 350 x 350 plastic pit. Working the size from the depth is not the starting rule, because the depth is often not known when a pit is placed; it is a feature offered when the depth is known or the pit is added later.
29. **Typed names PP and PIT (D-251, D-258):** "Remove my Pp alias; PP is plastic pit (Recommended)": his Pp alias (it ran PEDIT) was removed from his AutoCAD 2027 alias file, dated copy beside it (D-251). While the old plug-in is still loaded the new Pit and Pipe tools answer to PIT and CD straight away, PT and PIPE as well, and the old ones stop answering to those names ("New tools take PIT and CD now", not the recommended answer); how AutoCAD chooses when two plug-ins register the same name is not proven, so the build must make the new one win and prove it in the night run, or say plainly that it cannot (D-258).
30. **Pit size is any pair the block takes (D-272):** "Any pair the block takes (Recommended)": 350, 450, 600, 900 or 1200 each way, so 1200 x 900 works; the five office sizes sit at the top as the usual ones; anything PIT BLOCK 3 cannot draw is refused in words. This replaces the list-only reading of D-080 and D-135 for pit size (items 7 and 8).
31. **What the window opens with (D-263, refining D-234):** a pit opens with the last used choices, kept between AutoCAD sessions in a small CE file of its own (not an AutoCAD setting, profile or registry entry); a setting lets anyone switch any tool to "always office default" or "always last used". See WINDOWS for the whole ruling and the note under Still open about D-235.
32. **Lid class (D-240, D-242, D-243, D-287):** a pit's lid class depends on where the pit sits and what can drive over it, pit by pit, not a job-wide setting (Tim, D-240, after the planning chat asked it badly: "YOU NEED TO RESEARCH WHAT THIS MEANS BEFORE ASKING THIS STUFF"). A pit in a single house driveway opens with "Class C (office practice)" (D-242); garden pits are Class A (D-242, his old sheets); a pit in a truck hardstand or industrial slab opens with "Class D" (D-243). Lid class and pipe cover come from one "what is over it" list of ten presets (see LEVELS_AND_STANDARDS): a guide only, the engineer can change either on any pit (shown as typed over), nothing in it is enforced, and a council's request overrides (D-287, his words: "EVERYTHING WILL BE A GUIDE AND OR PRESET AND AN ENGINEER NEEDS TO HAVE ABILITY TO CHANGE").
33. **Resizing a pit with joined pipes (D-256):** "Pipe ends follow the wall (Recommended)": by grip, the block's own properties or the window, each pipe end moves to the new wall, lengths and labels update, and one Undo puts it all back (D-034 carried through).
34. **Switching a pit between grated and solid cover after it is drawn (D-257):** "Yes, everything follows (Recommended)": the pit on the plan, the schedule row, the lid class check and the storage tick in Detention all change from the one edit.
35. **Pump pit (D-247, D-252, D-259):** the two kinds in the Pit window are "SPS grated, SPS solid (Recommended)" (D-259). The pump sums are found and edited "On the pump pit (Recommended)": its own window shows the wet well volume, pump rate, level ladder and static rise, and they print in the same council computations PDF as the detention sums (D-247). Levels are set "As the newest office sums (Recommended)": static rise from the inlet invert; bottom 400 below all pumps stop; wet well never under 3 m3 unless typed over (amber, "Needs a look") (D-252).
36. **Orifice pit detail (D-253, not the recommended answer):** "The pits really differ by council", so the library keeps one orifice pit detail per council and Detention fills this job's figures into the detail that belongs to the job's council; the single office detail proposed in FP-010 is dropped.
37. **A single pit copied with plain COPY (D-262):** "Next free number at once (Recommended)".
38. **Turning a pit (D-266, D-267):** turning is built into the Pit window as a Turn button (the window steps aside, the pit turns on the cursor with a live preview like ROTATE, click or type the angle, the window returns showing it), and also while placing (first click position, optional second click angle); plain ROTATE does the same. Tim ticked "Turn while placing" and "Plain ROTATE works too" and did not tick "Pick a line or pipe to line up with" or "Text stays readable" as extra options (D-266). When a pit is turned only the pit box turns: "Text stays put and upright (Recommended)"; the tag and cover level stay level with the sheet at the same offset from the pit centre and pipe ends follow the turned walls (D-267). While placing, the pit on the cursor is the real block at the window's size, turning live, with "TBC" in grey for what is not known (D-267).
39. **A dragged pipe end meeting a pit (D-270):** "FIRST OPTION AND IF THE PIPE IS WITHIN THE OUTER WALL LINE AS WELL": an end let go anywhere on or inside the pit, counted to the pit's OUTER wall line, joins and is trimmed exactly to the wall in line with the pipe; short of the outer wall line it stays loose, "not joined yet"; it is not pulled in from outside.
40. **Build calls on the pit (D-260; planning chat's call from his rulings; his to overturn):** DQ-002 a grated pit uses the block's grated look and a junction pit the solid look with the cross; DQ-005 a missing layer is made with the office colour and said in one line, an existing layer is never changed (D-191); DQ-006 orifice and pump pits are a marked stand-in outline for now, with the real looks from PIT BLOCK 3 before first real use (D-104, D-228); DQ-009 the number starts 900 above and the cover level 700 below the pit centre as starting figures, then stay where the drafter puts them (D-012, D-181); DQ-011 and DQ-012 a marked stand-in outline, nominal 450 square, when the block or the size is missing, the size itself staying unknown (D-175, D-235).
41. **More build calls on the pit (D-261; planning chat's call from his rulings; his to overturn):** DQ-013 a stand-in pit is never swapped automatically, a "take it up" click is offered once the office block is in the drawing (the D-192 pattern); DQ-014 a pit drawn with the old block is readable only and an edit is refused in words (D-027, D-228); DQ-020 which side of a 600 x 900 pit runs across is read from PIT BLOCK 3's own X and Y widths, never guessed.

## Changed along the way

1. **"One big element" (D-011, 16 Nov) became a pit and a pipe working together (D-031, 16 Nov).**
2. **Cover levels read off the drawing last (INPUT_AUDIT change 5, 18 Nov midday) were withdrawn by D-178 (18 Nov):** the survey never gives a cover level.
3. **R-009's suggested block edits (a real inner wall line, plain names, a 50 mm step, a plastic state, save as PIT BLOCK 4) were answered by D-224 (18 Nov), and then replaced by D-228 (18 Nov afternoon):** PIT BLOCK 3 exactly as it is, no edits.
4. **The office pit for testing was "Stormwater Pit" (midday run, D-197 wording, 18 Nov); D-215 said PIT BLOCK 3 is the one he means, and D-228 (18 Nov afternoon) made PIT BLOCK 3 the block new pits use;** "Stormwater Pit" stays readable on old drawings only.
5. **Pit size picked from the list only (D-080, D-135) was replaced by any pair the block takes (D-272, 18 Nov);** size from the depth stopped being the starting rule (D-235).
6. **"Size by depth" and "last-used size marked assumed" (SITUATIONS A2, F5 proposal) were answered by D-235 (PIT opens at 450 x 450; the depth table is a feature) and D-263 (last used choices);** see the note under Still open.
7. **Lid class "once for the job" (the planning chat's recommendation) was corrected by D-240 to pit by pit,** then turned into ten "what is over it" presets (D-287).
8. **The square preview style (D-067) was replaced for where the preview sits by D-296 (18 Nov);** its size and form are open (D-297).
9. **Whether a turned pit is in the Pit window (open since 16 Nov) was answered by D-266 (18 Nov):** yes, with a live preview.

## Still open on this subject

1. **Whether a turned (rotated) pit is part of the Pit window:** asked once on 16 Nov and never answered (DECISIONS "Open after this sitting", gap check Pit item 9). Waits on: Tim. **Closed by D-266 (18 Nov):** yes, with a live preview (item 38).
2. **Which of the three numbering choices is offered first after issue** (D-184). Waits on: Tim.
3. **"Next free number" means the lowest unused or the highest plus one:** D-075 against DRAFTS_pit 5, not asked (SITUATIONS B9). Waits on: Tim.
4. **Form of the cover level help:** click two trusted levels and work between them, or click one level and type a fall; not picked, both may be drawn for him (D-195). Waits on: the planning chat, then Tim.
5. **Rule for pit kind and lid:** grated where surface water collects, lid class by what is over it (INPUT_AUDIT question 9, L-019). Waits on: Tim. **Lid part answered by D-240 and D-287 (ten presets, engineer can change); the pit-kind rule is still open.**
6. **Pit size when the depth is not known:** proposal to draw at the last-used size marked assumed (SITUATIONS A2, F5). Waits on: Tim. **Answered by D-235:** PIT opens at 450 x 450, PP at 350 x 350; after first use see item 19 (D-263).
7. **Pump pit:** which pump workbook version is current, and when a wet well under 3 m³ is acceptable (OPEN_QUESTIONS Q-003). Waits on: Tim. **Closed by D-252:** the newest office sums; a wet well under 3 m3 only if typed over, shown amber 'Needs a look'.
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
19. **POSSIBLE CONFLICT: what the Pit tool opens at.** D-235 says PIT opens at 450 x 450; D-263 (later) says pits open with the last used choices. They agree on the first use and may disagree after; neither marks the other. Planning chat's reading (board item 68; his to overturn): the typed name sets the SIZE preset (PT 450 x 450, PP 350 x 350); kind, lid and the rest open with last used. Waits on: Tim.
20. **Which plug-in wins the names PIT and CD when both are loaded** is not proven (D-258). Waits on: a test.
21. **Orifice and pump pits are a stand-in outline until the real looks from PIT BLOCK 3 are built;** the pit number as the office's circled tag and the masked levels and labels come before first real use (D-260). Waits on: the build chat.
22. **The 0.9 m above and 0.7 m below starting offsets for the number and cover text** are the planning chat's starting figures (D-260). Waits on: Tim (to overturn only).
23. **How the number and cover level text read when a pit is turned** was answered (D-267); the Pipe tool's matching on-cursor preview is designed, not built (D-267). Waits on: the build chat.

**Closed (D-230 to D-297):** whether a turned pit is in the Pit window (closed by D-266); the lid part of open item 5 above (answered by D-240 and D-287, ten presets, engineer can change; the pit-kind rule is still open); pump pit workbook version and when a wet well under 3 m3 is acceptable, open item 7 above (closed by D-252, "the newest office sums", amber "Needs a look" unless typed over); the name of a single copied pit (closed by D-262).

**Closed:** which block the new Pit tool uses, and the proposal "not yet confirmed by Tim in words" (closed by D-228, PIT BLOCK 3 exactly as it is); the night tests using the wrong pit block "Stormwater Pit" (closed by D-228; new pits use PIT BLOCK 3, "Stormwater Pit" stays readable on old drawings).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-235, D-240, D-242, D-243, D-247, D-251 to D-253, D-256 to D-263, D-266, D-267, D-270, D-272, D-287, D-295 to D-297; `reference\research\R-010_LID_CLASS.md`; `design\STYLE_APPROVED_18NOV.md`.

1. `DECISIONS.md` D-031, D-039, D-075 to D-078, D-104, D-135, D-178, D-183 to D-186, D-195, D-215, D-221, D-224, D-228, D-229.
2. `reference\research\R-009_PIT_BLOCK.md`; `design\BLOCKS_REVIEW.md` (BK-020, BK-022).
3. `design\SITUATIONS.md` sections B, C and D; `design\INPUT_AUDIT.md` (Pit window).
4. `pictures\pit_window_full_size.html`; `design\UI_PLAN.md`.
