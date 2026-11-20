# Owed in AutoCAD (every proof still to be shown in a test AutoCAD, with its state)

**Kept by:** the AutoCAD test room ("CE_ACAD / acad test / 01"). **Started:** Fri 20 Nov 2026, 11:30 am.
**Rule (D-346, added 20 Nov):** a fix may merge on its bench tests and one honest check; it is "proven" only when its owed list here has passed in AutoCAD, in pictures.
**States:** OWED (not yet run) · PASS (date, picture) · FAIL (date, picture, what was seen) · SEEN (no ruling yet, put to Tim) · WAITS (its work is not on the main line) · PARKED (off the release).
**Count on 20 Nov, 1:00 pm:** PASS 0 / FAIL 0 / OWED 14 / WAITS 21 / PARKED 1 (of 36). Two check-room verdicts received, both HOLD: the night scripts on the main line (section F) and the pipe's opening size (section G).

## A. From `stage6\STAGE1_TIMS_EYES.md` (the everyday run proves these; steps in `EVERYDAY_RUN.md`)

1. **A-1 Windows in the approved style inside AutoCAD** (line 1; run step 3, 7). OWED.
2. **A-2 Window opens at a sensible size** (line 2; step 3, 7). OWED.
3. **A-3 Preview shows the real thing** (line 3; step 3, 7). OWED.
4. **A-4 Office blocks brought in, never a plain square** (line 4, D-352; step 4). OWED.
5. **A-5 A pipe always opens with a size, 100 dia. default** (line 5; step 7). OWED.
6. **A-6 What is clicked is drawn** (line 6; step 8). OWED.
7. **A-7 Invert levels on the plan, label never "unknown DIA"** (line 7; step 8). OWED.
8. **A-8 Draw first, window second; run through pits splits; picked polyline replaced** (7a, D-354 to D-356; steps 3, 7, 9). WAITS: not built.
9. **A-9 Live on the drawing while the window is open; Cancel removes it** (7b, D-357; steps 3, 6). WAITS: not built; how it is done without saving until OK is for the build to prove.
10. **A-10 Labels land in the right spot; grips stretch and adjust; levels work along the run** (7c, D-359). WAITS: not built; the run steps for grips are not written until Tim's room has his words on what each grip does.
11. **A-11 The typed EXPLODE of a pipe** (line 12; step 19). OWED: no pipe could be drawn on 20 Nov, so it has never been tried; the result goes to Tim as SEEN.

## B. From the copy rule (D-340; `C:\CE_CIVIL` branch design/copy-identity, section 5, tests 1 to 13)

12. **B-1 What AutoCAD really does to a pointer** on COPY, MIRROR, classic ARRAY, paste, and WBLOCK then INSERT. Reported "7 of 7" by the CECOPYID night check on 19 Nov (results folder `2026-11-19_copyid_test1`, not on the main line, no pictures). This room has not seen it. OWED until re-run with pictures.
13. **B-2 Each of the 5 kinds copied alone** (tag, cover text, pipe label, inspection opening, council pit symbol): the copy never moves with the owner, survives the owner's erase. WAITS on the doorway rebuild.
14. **B-3 Copied with its owner gives P4 with its own tag; pit copied alone; pipe copied alone** (run step 15 covers the first). WAITS.
15. **B-4 MIRROR, classic ARRAY of 3, paste in the same drawing, cut and paste, paste into another drawing then save and reopen, WBLOCK then INSERT.** WAITS.
16. **B-5 A copy of a copy; erase the original after each route; OOPS brings it back whole.** WAITS.
17. **B-6 An older drawing with a copied tag; damaged joins listed, nothing moves.** WAITS.
18. **B-7 A locked layer, xref or reference edit when a join is made: refused before anything is written.** WAITS.

## C. From the edit doorway (D-348; branch design/edit-doorway, section 3 item 5 and its "not checked" list)

19. **C-1 Is AutoCAD's own MOVE and our follow-up ONE Undo?** Named in `STATE.md` as the first AutoCAD job after the restart. Does not need the rebuild: OWED (run steps 13 and 14 show it on what is on the main line).
20. **C-2 One Undo and one Redo per command,** for PT, PIPE, and each of MOVE, COPY, ERASE on a pit and a pipe. WAITS on the rebuild for the full list.
21. **C-3 The put-back after a native MOVE with a joined pipe on a locked layer:** the pit returns and the command line says "P3 not moved: its pipe P3 to P4 is on locked layer STORMWATER". WAITS.
22. **C-4 The REFEDIT answer:** what the tool does and says while a reference is being edited. WAITS.

## D. From the night scripts themselves (round 2, merged at 374991c, "not run in AutoCAD")

23. **D-1 The safe runner's first live run:** launch records the process, NETLOAD and commands go through the checked route, the close needs no force. OWED (tonight, build room).
24. **D-2 The bare title after our own close of the drawing** ("Autodesk AutoCAD 2027"), marked in the safety file as "not checked in a live AutoCAD yet". OWED (seen or not in tonight's close log).

## E. Night checks known to be out of date, and one old gap (from `acad\night_results\TREND.md`)

25. **E-1 Inch and metre pit size on the main line** was never re-run in AutoCAD on main. PARKED: metre drawings are off the release (D-344).

## F. From the check room's verdict on the night scripts (HOLD, 20 Nov 11:24 am; `check\VERDICTS\night-scripts-on-main.md`)

**State of the scripts:** HOLD on the main line (22993fa). No night runs until the launcher fix (team/night-launch) has the check room's MERGE against D-364. These four are added to the count (now 29): OWED 2 / WAITS 2.

26. **F-1 Where the plug-in's own test commands save to** (nobody has checked): after a night, list every file the test AutoCAD wrote outside `C:\CE_WORK\civil_tests\`. OWED (read from disk before and after the first live run; no picture needed, said as such).
27. **F-2 What AutoCAD writes to Tim's profile when a test AutoCAD exits** (nobody has checked). OWED: looked at by reading only, never by changing anything; what is found goes to the control room and Tim.
28. **F-3 The launcher counts an AutoCAD as its own only if it created it** (D-364): first live launch shows the recorded process is the one created. WAITS on team/night-launch.
29. **F-4 The Pit and Pipe windows are expected by identity under the test switch** (`PICTURE_ROUTE.md` conditions 4 and 5): first live PT in Cancel mode. WAITS on team/acad-pictures.

## G. From the check room's verdict on the pipe's opening size (team/pipe-default, A5: HOLD, three blockers; `check\VERDICTS\team-pipe-default.md` section 6)

Nothing of this is shown until the fix merges. All seven WAIT. They expand item A-5.

30. **G-1 From nothing, a pipe opens at 100.** WAITS.
31. **G-2 One 225 pipe arriving: the next opens at 225.** WAITS.
32. **G-3 150, 225 and 375 arriving: opens at 375.** WAITS.
33. **G-4 A typed size stands.** WAITS.
34. **G-5 After a typed size, a fresh pipe is back at 100.** WAITS.
35. **G-6 An older 375 pipe keeps its width and label when only the label side is changed.** Also record whether opening the drawing, or REGEN alone, changes any width or label (not proven either way on the bench). WAITS.
36. **G-7 An upstream resize:** record every pipe below, before and after. No ruling yet (U-048): marked SEEN and put to Tim, not PASS or FAIL. WAITS.

**Coming from the check room once written:** the owed list for A1 to A3 (the windows, being checked).

**Also noted, not counted as owed proofs (they are faults in the checks, asked of the build room):** CEPIT3, CEPIPE3 and CELEV2 still expect an inch drawing to be refused; CELEV1's third check expects "Chosen" where "TypedOver" is right; CETEST lists its run twice, so its lines count twice; the code-route EXPLODE check has failed in every pass since pass 1.
