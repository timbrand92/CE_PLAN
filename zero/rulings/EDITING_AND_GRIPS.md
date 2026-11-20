# Current rulings: Editing, grips and plain AutoCAD commands

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

(Added subject: these decisions did not fit one of the named pages.)

## What is decided now

### Grips

1. **As many grips as there are now for the individual parts within the element** (D-033).
2. **Grips move text, invert text and arrow perpendicular or parallel to the line; cover level text and the pit label can be moved and flipped;** "WE NEED ALL SCENARIOS" (D-037).
3. **Grips are researched and tested before they are built in the new plug-in;** Tim's intention is that CE objects show different grip icons "if this is possible" (D-199).
4. **The new plug-in must never change how native AutoCAD objects behave** (D-199 item 4).
5. **An inlet such as a GIO slides along the pipe by its grip** (D-050).

### Editing

6. **Changing a thing has no typed name:** click it and use its tab, grips or Properties (D-056). **See the INDEX clash list:** D-383 item 1 adds the typed name CDEDIT, "EDITS ANY CE OBJECT SELECTING THE RIGHT EDIT WINDOW" (item 31); D-383 does not name D-056.
7. **Properties, and double-click opens the window** it was placed with (D-061, D-048).
8. **A pit placed on a drawn pipe splits it in two** (D-077).
9. **MOVE a pit:** tag and cover level text go with it; a hand-moved label keeps its offset (D-181).
10. **ERASE a pit:** tag, text and row go; pipes stay "not joined yet"; one undo brings everything back (D-221).
11. **COPY to a mirror unit:** sizes and grades copy, levels marked assumed, next free numbers (D-179).
12. **Retyping a pit tag renames the pit** (D-185); **typed-over label text is kept and flagged** (D-182).
13. **A label moved by hand stays where it was put when the pipe changes** (D-014).
14. **Things interact precisely:** a pipe drawn from a pit starts exactly on the pit wall in line with the click (D-034).

### Added 18 Nov 2026, D-230 to D-297

15. **Extra grips, and research AND testing of AutoCAD's own grip shapes (D-244):** told that different grip icons are not proven possible on AutoCAD 2027 (a grip in a chosen place, hover words and a hover menu do work; the trial crash and the hatch fault are not proven), Tim: "EXTRA GRIPS OPTION BUT CAN YOU NOT DO SOME HARD PROPER RESEARCH AND TESTING TO SEE IF WE CAN AT LEAST USE AUTOCADS DIFFERENT CRIP TYPES LIKE IS IN DYNAMIC BLOCKS?" So: extra grips in the right places, with hover words and a menu; and proper research AND testing into whether AutoCAD's own grip shapes, as seen on dynamic blocks (the stretch arrow, flip arrow, rotate dot, lookup triangle and the like), can be used on CE things. Assigned to the trials chat.
16. **Resizing a pit with joined pipes (D-256):** by grip, the block's own properties or the window, "Pipe ends follow the wall (Recommended)"; lengths and labels update and one Undo puts it all back.
17. **Turning a pit (D-266, D-267):** plain ROTATE works as well as the window's Turn button and the turn while placing; only the pit box turns and the text stays put and upright. **Turn while placing changed by D-381 item 4 (20 Nov):** the angle is never asked while placing; Turn is a button in the window.
18. **COPY of a single pit (D-262):** "Next free number at once (Recommended)".
19. **Drawing a run of pipes (D-237):** "Like PLINE and LINE: it carries on"; one undo steps back one pipe. **Made specific by D-324 (19 Nov):** while the command runs undo takes back the last pipe; after Enter one undo takes back the whole run.

### Added 20 Nov 2026, D-298 to D-383

20. **A part on a frozen or off layer (D-320):** "Offer to turn it on". The window says so and offers a button; nothing changes unless he presses it (the planning chat's "never offer" overturned).
21. **Undo while drawing pipes (D-324):** "Yes, as described (Recommended)". Pits: one pit per Undo (D-377 item 7).
22. **Copies, tags, arrays and blocks (D-340):** two tags claiming one pit: "Leave both, list it (Recommended)"; a tag, label or symbol copied on its own: "Your own plain text (Recommended)", never moved, renumbered or erased, said once at the end of the COPY; parts inside an array or unexploded block: "Say so once (Recommended)", "parts inside an array or block are not followed; explode it to work on them". The first test (what AutoCAD does to a pointer on each copy route) comes first.
23. **The edit doorway (D-348):** every edit to a pit, pipe, label or join passes one gate that collects the parts by their two-sided joins, checks every part first, writes once as a whole or not at all, and says so once. A pit moved with MOVE whose joined pipe is on a locked layer: "Pit goes back (Recommended)", the command line says "P3 not moved: its pipe P3 to P4 is on locked layer STORMWATER". It delivers the copy rule of D-340 with it. Not closed by the doorway: hand-written pipe wording after a resize; the inner-wall trim and folded branches; an occupied pipe name; schedule holds (Stage 2).
24. **Twin barrels and TRIM (D-349):** "Both become 7 m (Recommended)": an edit to one barrel wins and the other is changed to match.
25. **A polyline picked as the run (D-356, D-375):** "Replaced by pipes, bends kept (Recommended)"; one Undo brings the polyline back; an arc, a closed polyline, a locked layer or an xref is REFUSED with the reason said.
26. **Grips to stretch and adjust are a Stage 1 must (D-359):** "Labels land in the right spot,Grips to stretch and adjust,Levels work along the run".
27. **A typed EXPLODE of a pipe (D-376):** "Plain AutoCAD pieces, looks the same"; the tool stops looking after it and says so once; one Undo makes it a pipe again. What EXPLODE really leaves is still to be shown; a pit was not asked. His supervised check could not test it because no pipe was drawn (D-351).
28. **Pipe moved, erased, text erased (D-377):** a pipe moved on its own comes off its pits, "not joined yet", one Undo (TR-037); erasing a pipe takes its label, levels and arrow, pits stay (TR-038); a piece of text erased by hand stays gone, the same as unticking it (TR-039); a pit dropped on a loose pipe end joins and trims it (TR-035).
29. **Not settled (D-378 item 4):** a pit moved so a pipe's length changes: "window opens to select one or the other and how it will transpire down the system if it exists"; to be worked through with the edit doorway (an AutoCAD MOVE finishes in one go with one Undo) and R-41 before it is built.
30. **Plain AutoCAD edits ruled (D-381):** several pipes or several pits open in ONE window, "Varies" where they differ, pits and pipes picked together open nothing (TR-054); STRETCH with a crossing window moves the pits caught, joined pipes follow at their ends, a pipe end caught without its pit comes off (TR-055); moving the whole plan, his words: "what about if we move the plan on the page with everything, its shouldnt mess anything up": moving everything together changes nothing (no join, level, label position, held figure or number, and no window), proof in AutoCAD owed; MIRROR keeps text readable, re-placed by the placing rules, arrows pointing with the flow (TR-056); a pipe copied on its own is a new loose pipe with the same figures, its levels marked assumed (TR-057).
31. **CDEDIT and double-click (D-383 item 1):** "CDEDIT, EDITS ANY CE OBJECT SELECTING THE RIGHT EDIT WINDOW", plus double-click; CDEDIT is a new typed name, to be checked against the old plug-in's names; his question "CAN WE EDIT IN PROPERTIES OR A CD INSPECTOR WINDOW?" is owed an answer.

## Changed along the way

1. **Grips were "somewhat working" in the older plug-in;** Tim now asks for research and testing before implementing (D-199, 18 Nov). No earlier grip ruling was replaced.
2. **"Research and test grips before they are built, icons if possible" (D-199) was made specific by D-244 (18 Nov):** extra grips with hover words and a menu now, plus proper research and testing of AutoCAD's own dynamic-block grip shapes.
3. **"One undo steps back one pipe" (D-237) was made specific by D-324 (19 Nov).**
4. **Turn while placing with an optional second click (D-266) was changed by D-381 item 4 (20 Nov).**
5. **The planning chat's "never offer" for a frozen or off layer was overturned by D-320 (19 Nov).**

## Still open on this subject

1. **Different grip icons on CE objects:** R-006 says not possible on AutoCAD 2027 as far as proven (own icons painted nothing on 4 Sep); what works is a grip in a chosen place, a words-on-hover tip and one grip with a hover menu. Tim has not been told this as a ruling question. Waits on: Tim. **Put to him and answered by D-244 (18 Nov):** research AND testing of AutoCAD's own grip shapes; the result is item 9 below.
2. **Trial 2, custom grip: FAIL (clicking it crashed AutoCAD, 17 Nov);** likely cause the grip answering "Failure", not proven; built-in grips on a plain polyline, the grip-drag copy and the menu NOT TESTED (D-155; TRIAL_RESULTS; R-006 B2). Waits on: a test.
3. **Trial 8, double-click: PARTIAL;** AutoCAD's own PEDIT also runs (TRIAL_RESULTS). Waits on: a test.
4. **Plain AutoCAD edits not yet settled or tested:** whole-run MOVE, MIRROR label side, ROTATE readability, STRETCH, SCALE, EXPLODE, MATCHPROP and layer change shown amber, frozen or locked layers wording, paste and WBLOCK, PURGE, AUDIT, RECOVER (SITUATIONS C2, C4 to C7, C10, C11, C13 to C15). Waits on: the build chat.
5. **Compare native behaviour with the old plug-ins loaded too** (OBSTACLE_COURSE OQ-10, OC-21). Waits on: Tim.
6. **AutoCAD's own protections win (locked layers, xrefs, REFEDIT):** no check yet exists (OBSTACLE_COURSE part E, OC-19). Waits on: the build chat.
7. **Several things selected show "Varies" in the window; a pipe already selected when PT is typed places a pit on it** (SITUATIONS G2, G9). Waits on: the build chat.
8. **Properties and double-click routes are not proven** (THE_PLAN section 6a item 3; trial 5 BLOCKED). Waits on: a test. D-288 DQ-103 (planning chat's call from his rulings; his to overturn) now plans rows in AutoCAD's own Properties with nothing registered, pending a night proof, with no registry change either way.
9. **The result of the research and testing of AutoCAD's own grip shapes on CE objects** (D-244). Waits on: the trials chat.
10. **D-056 (no typed name for changing a thing) against D-383 item 1 (CDEDIT);** see the INDEX clash list. Waits on: Tim.
11. **What EXPLODE really leaves on a pipe; a typed EXPLODE of a pit was not asked** (D-376, D-351). Waits on: a test, then Tim's room.
12. **Moving the whole plan changes nothing: proof in AutoCAD owed** (D-381 item 7). Waits on: a test.
13. **The copy identity first test** (D-340). Waits on: a test.

**Closed (D-298 to D-383):** plain AutoCAD edits in open item 4 now ruled for STRETCH, EXPLODE of a pipe, MIRROR, frozen or off layers and locked layers on a move (D-320, D-348, D-376, D-381); AutoCAD's own protections on a locked layer (open item 6 in part, D-348: the pit goes back); several selected shows "Varies" (open item 7, D-381 item 5).

**Closed (D-230 to D-297):** whether Tim wants different grip icons on CE objects (answered by D-244: research and test them).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-320, D-324, D-340, D-348, D-349, D-351, D-356, D-359, D-375 to D-378, D-381, D-383; `design\COPY_IDENTITY.md`, `design\EDIT_DOORWAY.md` (in `C:\CE_CIVIL` design branches).

Added 18 Nov 2026: `DECISIONS.md` D-237, D-244, D-256, D-262, D-266, D-267, D-288.

1. `DECISIONS.md` D-014, D-033, D-034, D-037, D-048, D-050, D-056, D-061, D-077, D-155, D-179, D-181, D-182, D-185, D-199, D-221.
2. `reference\research\R-006_HATCH_AND_GRIPS.md`; `reference\research\R-002_HOW_TO_BUILD_IT.md` section C.
3. `design\SITUATIONS.md` section C; `stage6\OBSTACLE_COURSE.md` OC-09, OC-18, OC-19, OC-21.
