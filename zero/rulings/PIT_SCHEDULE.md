# Current rulings: Pit schedule

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

1. **In the first release** (D-097).
2. **Typed name SCHEDULE / SH** (D-101). **Superseded by D-233 (18 Nov):** SCHEDULE / SCH (item 16).
3. **Placed once, then follows the pits:** type SH, pick where it goes, it draws in the office's layout and updates itself whenever a pit or pipe changes; ordinary lines and text (D-109).
4. **Cells can be typed over, with a padlock like everything else:** a typed-over cell is held and shows a closed padlock; one click lets it follow the pit again (D-103).
5. **Rows besides the numbered pits:** the existing council pit connected to, a pump well, and plastic pits that are ticked (D-110, D-076).
6. **Plastic pits:** a tick box "In the schedule" on each, starting ticked (D-076).
7. **A pit with several inlets takes one schedule row per inlet** (seen on issued sheets, D-113).
8. **Wording read off three issued sheets (identical):** title "STORMWATER PIT SCHEDULE"; headings PIT No., PIT SIZE, INLET (FROM, DIA, INVERT LEVEL), OUTLET (DIA, INVERT LEVEL), COVER LEVEL, DEPTH TO OUTLET, TYPE OF LID AND REMARKS; three standing dash-bullet notes as quoted in D-113 (D-113, answering D-112 "Read it off an issued job").
9. **A long schedule on the sheet:** "It runs long; I make room"; one block that grows downward, and the plug-in only warns that it may not fit (D-114).
10. **The window puts its preview on the left at full height, choices on the right,** because the subject is tall (D-113).
11. **The Columns card comes out of the window,** because the office schedule block does not drop columns and does not need to (D-169).
12. **The on-sheet scale choice comes out of the window;** it is used once a year at most, and Tim is "happy to be proven otherwise" (D-169).
13. **The schedule row follows a renamed pit** (D-185) **and goes when a pit is erased,** coming back with one undo (D-221).
14. **The pit schedule row rules are taken from the old plug-in,** re-checked against a real job first (D-095).
15. **Pit schedule window: "tick"** (D-112) **and "good"** apart from the two cards removed (D-169).

### Added 18 Nov 2026, D-230 to D-297

16. **Typed name SCHEDULE / SCH (D-233):** "SCHEDULE / SCH" replaces SH, which is AutoCAD's own shell command (found when the third AutoCAD pass read which short names are already taken).
17. **A pit switched between grated and solid cover changes its schedule row (D-257):** "Yes, everything follows (Recommended)": the pit on the plan, the schedule row, the lid class check and the storage tick in Detention all change from the one edit.
18. **Build calls on the schedule (D-288; planning chat's call from his rulings; his to overturn):** DQ-085 schedule rows run outlet first, following the flow (pits are numbered from the outlet, D-183); DQ-087 the "runs long" warning starts from 20 rows; DQ-088 a very long schedule preview never shrinks below 0.8 and scrolls inside its own frame (a long list may scroll; the window itself does not).
19. **The schedule window's preview is at the left, as in every window (D-296):** its size and form are OPEN under D-297.

### Added 20 Nov 2026, D-298 to D-383

20. **The restyled Pit schedule window is right as drawn (D-309):** "pit schedule, source, is great"; it keeps its preview at the left (D-299 put the top preview on Detention only, D-313 added Long section and Pipe).
21. **In the one-job release, Stage 2 (D-338, D-347):** "Pit schedule" ticked for the first job; it waits until he has drafted with Stage 1.
22. **Schedule holds are not closed by the edit doorway** and need their own fix in Stage 2 (D-348).

## Changed along the way

1. **The window with a Columns card and an on-sheet scale choice (bench version) lost both (D-169, 18 Nov).**
2. **The open question of a 16-row schedule (D-112) was settled for the window by D-113 (preview left, full height) and for the sheet by D-114 (grows downward, warns only), both 16 Nov.**
3. **SCHEDULE / SH (D-101) became SCHEDULE / SCH (D-233, 18 Nov),** because SH is AutoCAD's own shell command.

## Still open on this subject

1. **Filing the issued-sheet wording into `reference\drafting\TABLES_AND_BOXES.md`** (D-113). Waits on: the planning chat.
2. **Standing note wording says step irons at 1.2 m while the office figure is 1.0 m;** raise with Tim when notes are built (D-136). Waits on: Tim.
3. **Order of rows, outlet first or upstream first:** "the office's way, once", not stated (INPUT_AUDIT Schedule window). Waits on: Tim. **Taken by D-288 DQ-085 (planning chat's call from his rulings; his to overturn):** outlet first, following the flow.
4. **That the office schedule block cannot drop columns** is stated, not verified (INPUT_AUDIT, D-169). Waits on: the build chat.
5. **SH typed in a layout (now SCH, D-233):** heights should follow the space clicked in (SITUATIONS H2). Waits on: the build chat.
6. **Schedule rows coming back after ERASE then UNDO** is untested (SITUATIONS C9). Waits on: a test.
7. **The bench schedule starts at "P0"; must be P1 at the outlet** (SITUATIONS D1). Waits on: the build chat.
8. **A pit's number disagrees between the Pit window and the schedule on the bench** (INPUT_AUDIT section 2 item 2). Waits on: the build chat.
9. **The schedule's on-sheet scale:** Tim open to being shown the scale choice is needed more than once a year (D-169). Waits on: Tim (only if evidence appears).
10. **Full verdict waits on real use** (D-087). Waits on: Tim.
11. **SCH has to be typed once in AutoCAD 2027 to prove it free,** as for every other short name (D-233). Waits on: a test.

**Closed (D-230 to D-297):** the typed name clash with AutoCAD's shell command (closed by D-233); the order of rows (taken by D-288 DQ-085, planning chat's call from his rulings; his to overturn).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-309, D-338, D-347, D-348.

Added 18 Nov 2026: `DECISIONS.md` D-233, D-257, D-288, D-296, D-297.

1. `DECISIONS.md` D-076, D-095, D-097, D-103, D-109, D-110, D-112 to D-114, D-169, D-185, D-221.
2. `reference\drafting\TABLES_AND_BOXES.md`; `design\INPUT_AUDIT.md` Schedule window.
3. `stage6\OBSTACLE_COURSE.md` OC-13.
