# Owed in AutoCAD (every proof still to be shown in a test AutoCAD, with its state)

**Kept by:** the AutoCAD test room ("CE_ACAD / acad test / 01"). **Started:** Fri 20 Nov 2026, 11:30 am.
**Rule (D-346, added 20 Nov):** a fix may merge on its bench tests and one honest check; it is "proven" only when its owed list here has passed in AutoCAD, in pictures.
**States:** OWED (not yet run) · PASS (date, picture) · FAIL (date, picture, what was seen) · SEEN (no ruling yet, put to Tim) · WAITS (its work is not on the main line) · PARKED (off the release).
**Count on 20 Nov, 1:45 pm:** PASS 0 / FAIL 0 / OWED 14 / WAITS 67 / PARKED 1 (of 82; one item struck). Nine check-room verdicts received, all HOLD or held. Three check-room verdicts received, all HOLD: the night scripts on the main line (section F), the pipe's opening size (section G) and the windows (section H).

## A. From `stage6\STAGE1_TIMS_EYES.md` (the everyday run proves these; steps in `EVERYDAY_RUN.md`)

1. **A-1 Windows in the approved style inside AutoCAD** (line 1; run step 3, 7). OWED.
2. **A-2 Window opens at a sensible size** (line 2; step 3, 7). OWED.
3. **A-3 Preview shows the real thing** (line 3; step 3, 7). OWED.
4. **A-4 Office blocks brought in, never a plain square** (line 4, D-352; step 4). OWED.
5. **A-5 A pipe always opens with a size, 100 dia. default** (line 5; step 7). OWED.
6. **A-6 What is clicked is drawn** (line 6; step 8). OWED.
7. **A-7 Invert levels on the plan, label never "unknown DIA"** (line 7; step 8). OWED.
8. **A-8 Draw first, window second; run through pits splits; picked polyline replaced** (7a, D-354 to D-356; steps 3, 7, 9). WAITS: not built.
9. **A-9 Live in the window's own preview panel: the real plan around the part, changing as he types; nothing on the drawing until OK** (7b; D-382 corrects D-357; steps 3, 6, 7). WAITS: not built. Whether the part should also show on the drawing behind is not yet asked of Tim.
10. **A-10 Labels land in the right spot; grips stretch and adjust; levels work along the run** (7c, D-359). WAITS: not built; the run steps for grips are not written until Tim's room has his words on what each grip does.
11. **A-11 The typed EXPLODE of a pipe** (line 12; step 21; ruled by D-376: plain AutoCAD pieces that look the same, said once, one Undo makes it a pipe again). OWED: no pipe could be drawn on 20 Nov, so it has never been tried; what EXPLODE really leaves is written down for Tim.

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

**REPLACED 20 Nov, about 12:10 pm:** the fix was held after its last round and goes to a design page then one build (D-372). The first list of 7 steps (G-1 to G-7) is superseded by the 10 below, from the last section of `check\VERDICTS\team-pipe-default_HELD.md`. Nothing is shown until that build merges. All ten WAIT. They expand item A-5.

30. **G-8 A run:** five pits 10 m apart, a 375 arriving at the first; PIPE through all five, OK without typing. All four pipes 375, labelled "375 DIA.". With the arrival at the second pit instead: 100, 375, 375, 375. WAITS.
31. **G-9 Junctions:** two equal sizes arriving; then 150, 225 and 375 arriving. The largest. WAITS.
32. **G-10 From nothing:** 100, labelled "100 DIA. ... AT 1 IN 100 MIN.". WAITS.
33. **G-11 A typed size stands;** after it a fresh pipe is back at 100, and a pipe off a 225 is 225. WAITS.
34. **G-12 An older pipe arriving:** a pipe drawn 375 with nothing typed comes into a pit; PIPE from that pit opens at 375. WAITS.
35. **G-13 A disagreeing pipe:** draw a 300, change its width to 375 in Properties; ground 10.00, invert 9.38, cover needed 300. Its window shows the drawn 375 with the typed 300 beside it, cover 55 mm short. Then on fresh copies: OK untouched; label side only; grade only: width and label unchanged each time. WAITS. (Changing a width in Properties by a robot needs a typed route; if there is none, this step is Tim's hands.)
36. **G-14 A width that cannot be read** (set to 0): the window says so in words; OK leaves width and label as they were. WAITS.
37. **G-15 Read off, not typed:** an existing pipe's size shows as worked out from the drawing; after OK its note does not say it was typed. WAITS.
38. **G-16 Different widths along one pipe; a real twin-barrel pair (D-349); a saved copy after open and REGEN alone:** every width and label recorded before and after. WAITS.
39. **G-17 One Undo** after each OK puts back widths, labels and notes together. WAITS.

(The window items in section H below keep their labels H-1 to H-10; their list numbers run on from here.)

## H. From the check room's verdict on the windows (team/acad-windows, A1 to A3: HOLD, two blockers; `check\VERDICTS\team-acad-windows.md` section 7)

Nothing of this is shown until the fix merges. All ten WAIT. They expand items A-1 to A-3. As built today the window would not open at all (an error line on the pit and pipe commands).

37. **H-1 The window opens at all and is the approved style.** WAITS.
38. **H-2 Its size, with nothing cut off.** The night records the width and height in figures beside the picture. WAITS.
39. **H-3 Centred on AutoCAD, and which monitor it lands on.** No night picture shows the whole AutoCAD window (screen copy dropped, D-388): judged from the figures the plug-in records (the window's left, top, width and height beside AutoCAD's own); the look of it is for Tim's hands. WAITS.
40. **H-4 A resize is remembered.** Only with a test settings file in the test folder, never Tim's. Before it runs, the build room must say where the size is kept; if it is anywhere in Tim's own settings, this step is NOT RUN and goes to Tim's hands. WAITS.
41. **H-5 A damaged size file:** the window still opens at its usual size and says nothing alarming. Test file only, as H-4. WAITS.
42. **H-6 A pipe with one end not joined shows no second pit in ANY picture** (window preview and drawing). WAITS.
43. **H-7 Both ends joined:** both pits shown. WAITS.
44. **H-8 A pit of unknown size is drawn dashed** in the preview. WAITS.
45. **H-9 Cancel, the X and Escape change nothing** on the drawing. Cancel and X go through the window's own controls from inside the plug-in. Escape is a key: no key is sent by a robot, so it is raised inside the window by the plug-in or left for Tim's hands, and the page says which. WAITS.
46. **H-10 A picture over a real test drawing, to judge the rose against the drawing's colours** (screen rule 16). In the theme Tim's AutoCAD is set to only: the colour theme is a saved AutoCAD setting and is never changed by a robot (rule 1.9). The other theme stays for Tim's hands unless he says yes in words. WAITS.

**Only AutoCAD can show these, and how far a night picture goes:** screen rule 16 (H-10, one theme); rule 18, clicks and one undo (the typed U after each command is shown; a real click is Tim's); rule 28, motion (a still picture cannot show motion: Tim's hands); AutoCAD's light theme (as H-10).

## I. From the check room's verdict on the picture route (team/acad-pictures2: HOLD; `check\VERDICTS\team-acad-pictures2.md` section 4)

**Standing word:** this room does not use the route and does not run its tests (they show a real window that can ask for Tim's keyboard focus). No AutoCAD run and no picture run until the launcher AND this route each have the check room's MERGE on both halves and this room says go (D-364 item 10, D-388). Night one is one PT in Cancel mode only. All nine WAIT.

50. **I-1 The window's own timer and frame callbacks run while AutoCAD shows the window.** WAITS.
51. **I-2 The window picture shows the preview drawn.** WAITS.
52. **I-3 What AutoCAD's own view picture gives while the window is open.** WAITS.
53. **I-4 The copy of our window by its handle shows the drawing area.** STRUCK 20 Nov: the handle copy and the screen copy are dropped (D-388); not counted.
54. **I-5 A typed point with the "no snap" word is taken at PT's prompt.** WAITS.
55. **I-6 The Size list's words can be reached, and its pop-up does not trip the 2-second window rule.** WAITS.
56. **I-7 The window's marker lands inside the 2 seconds.** WAITS.
57. **I-8 The switch turns itself off on a swapped drawing.** WAITS.
58. **I-9 "TEST SWITCH ON" shows on the command line.** WAITS.

**Picture rule from this verdict:** a copy of AutoCAD's own window shows the file tabs and command-line history of Tim's profile. This room looks at every picture before it leaves the PC; pictures never go into a repository.

## J. From the check room's verdict on draw first, window second (team/a6-draw-first: HOLD; `check\VERDICTS\team-a6-draw-first.md` section 7)

Nothing is shown until it merges. All eight WAIT. They expand item A-8. This room types PT and PIPE only, never PIT, PP or CD.

59. **J-1 PT, three pits, Enter, then U once:** only the last pit goes (one pit per Undo). WAITS.
60. **J-2 PIPE from open ground with two bends.** WAITS.
61. **J-3 PIPE through three pits, clicking the ends only.** WAITS.
62. **J-4 A picked polyline replaced by pipes, and one U brings the polyline back.** WAITS.
63. **J-5 Each refused polyline** (an arc, closed, on a locked layer, in an xref; D-375): refused with the reason said, nothing drawn. WAITS.
64. **J-6 Cancel and Escape at each point.** Cancel is typed or pressed through the window's own control; Escape is a key and no key is sent by a robot, so Escape is Tim's hands unless the plug-in raises it itself. WAITS.
65. **J-7 Every command with the pit, tag, cover and pipe layers locked, off and frozen in turn.** Layer states are changed in the test copy only and it is closed without saving. WAITS.
66. **J-8 Redo after each Undo.** WAITS.

## K. From the check room's verdict on the held depth (team/held-depth: HOLD; `check\VERDICTS\team-held-depth.md` section 7)

Nothing is shown until it merges. All four WAIT.

67. **K-1 Regrade, move and erase the leaving pipe, reading the pit's cover text each time.** WAITS.
68. **K-2 Edit and erase the cover text by hand, then Pit OK.** WAITS.
69. **K-3 A metre drawing is refused, with nothing brought in.** By PT and PIPE from this room; the typed names PP and CD are Tim's hands. WAITS.
70. **K-4 One Undo for each of the above.** WAITS.

## L. From the check room's verdict on the flag marker (its test list is held; `check\VERDICTS\codex-tests-flag.md` section 5)

Nothing is shown until it merges. All six WAIT.

71. **L-1 The marker on the plan at 1:100 and at one other scale.** WAITS.
72. **L-2 The words shown on hover match the window's words.** A hover needs a real mouse: Tim's hands, unless the words can be read another way. WAITS.
73. **L-3 A plot of the sheet, with an ordinary line as witness: the line plots, the marker does not.** Only by a typed plot to a PDF file in the test folder, with no saved plot setting changed; the PDF is opened and looked at. If that cannot be done without touching a saved setting, it is Tim's hands. WAITS.
74. **L-4 Save and reopen** (a saved COPY in the test folder, never the night's test copy itself): the marker is still there and still right. WAITS.
75. **L-5 Copy, move, mirror** a flagged pipe: the marker goes with its pipe and a copy has its own. WAITS.
76. **L-6 Cancel, one Undo and Redo.** The danger to look for: Undo takes the marker and leaves the undersized pipe. WAITS.

## M. From the check room's verdict on the units doorway (its test list is held; `check\VERDICTS\codex-tests-units.md` section 5)

Nothing on the bench reads AutoCAD's own units setting, so only AutoCAD can show these. Nothing is shown until it merges. All seven WAIT. Each uses its own test copy, made from the office master with that one drawing setting changed in the copy; no setting of Tim's AutoCAD is touched. This room types PT and PIPE; the typed names PP and CD are Tim's hands. (K-3 is the metre case of this list.)

77. **M-1 A drawing set to metres:** refused, nothing brought in, the drawing not marked as changed, nothing to Undo. WAITS.
78. **M-2 A drawing set to inches:** the same. WAITS.
79. **M-3 A drawing set to feet:** the same. WAITS.
80. **M-4 A drawing with no units set:** drawn at true size, with the grey line saying so. WAITS.
81. **M-5 The display format changed, insertion units left at millimetres:** drawn as normal. WAITS.
82. **M-6 On a layout sheet.** What is right is as the verdict page says; recorded as seen if it does not say. WAITS.
83. **M-7 In a read-only drawing.** As M-6. WAITS.

**Also noted, not counted as owed proofs (they are faults in the checks, asked of the build room):** CEPIT3, CEPIPE3 and CELEV2 still expect an inch drawing to be refused; CELEV1's third check expects "Chosen" where "TypedOver" is right; CETEST lists its run twice, so its lines count twice; the code-route EXPLODE check has failed in every pass since pass 1.
