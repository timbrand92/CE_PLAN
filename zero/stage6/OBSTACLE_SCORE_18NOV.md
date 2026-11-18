# Obstacle course score, 18 Nov 2026 (the four AutoCAD tools)

**Date:** Wed 18 Nov 2026, about 11:30 pm by the clock (Melbourne). Written by a helper of the planning chat (delivers O-018 once the planning chat has checked it). Read only: nothing run, built, installed or committed.
**Read:** `stage6\OBSTACLE_COURSE.md` (OC-01 to OC-27); `C:\CE_CIVIL\acad\night_results\TREND.md` in full; `C:\CE_CIVIL\BUILD_LOG.md` (morning note, entries 41 to 46); `C:\CE_CIVIL\acad\NIGHT_TEST.md` (what each night check proves); pass 10's result lines; `C:\CE_CIVIL\src\CeCivil.Hands\EditGuard.cs` (what the lock guard checks). Section 12 of `BOARD.md` to item 90.
**The passes:** TREND holds TEN AutoCAD passes on 18 Nov, not nine. Pass 6 ran no checks (the guard found the PC in use). Pass 10 (11:12 pm, commit adcc5aa, bends) is newer than the board. The last full figures: pass 9, PASS 102 / FAIL 1 / NOT TESTED 2 of 105; pass 10, PASS 110 / FAIL 2 / NOT TESTED 2 of 114.

---

## Answer first

1. **Pit: 0 of 27 proven in AutoCAD. Pipe: 0 of 27. Long section: 0 of 27. LPD: 0 of 27.**
2. **No obstacle has been passed by any tool.** All 27 are still open for all four.
3. **Why so low when 110 of 114 night checks pass:** each night check proves one part of an obstacle. Every obstacle also has a part that needs a typed command, a mouse, a look, a second AutoCAD session without the plug-in, or something not built yet (metre drawings, TBC on the sheet, the plot line, the shared-settings guard, the fault report).
4. **Installed: 0. Accepted: 0. Everywhere.**

---

## How each mark was given (strict)

1. **PROVEN IN AUTOCAD:** every line of the obstacle that applies to the tool passed in a named night check in a named pass. A part proven is named in the reason but does not make the mark.
2. **TESTED ON THE PRETEND DRAWING ONLY:** every applicable line is built and tested, but some only on the pretend drawing (the fake drawing in the hands tests), the brain or the bench windows. The bench is counted here, because it is not AutoCAD.
3. **NOT TESTED:** the behaviour exists or may exist, but at least one applicable line has no test recorded anywhere. "Proposed does not apply" also lands here: only a reviewer may rule that (course part D1), and it is never a pass.
4. **NOT BUILT:** at least one applicable line asks for something that is not built.
5. **The weakest line sets the mark.** Order: PROVEN, then PRETEND ONLY, then NOT TESTED, then NOT BUILT.
6. **The night checks and what they prove** (from `NIGHT_TEST.md`): CETEST, the drawing link, notes, joins, golden recordings, saves in 2000 and 2013; CEPIT1 to 8, the Pit tool in side drawings (block, layers, text, edit, Cancel, units refused, copy, move found, turn, stand-in, foreign dictionary, PIT BLOCK 3 states and sizes); CEPIPE1 to 8, the Pipe tool and the LPD marker (CEPIPE8); CELEV1 to 7, the Long section (held grades with sources, Cancel, branches, move found, copy, put-back, names, speed); CESPEED, 13 speed limits; CEFACTS1, the block's own properties and the size step; CECOPY1 to 3, MIRROR, ARRAY and a paste stand-in; CEWHOSE, which plug-in declares each name; CEBEND1 to 4, bends (pass 10 only). All run in side drawings, through code, with no typed command, mouse or window on screen.

---

## 1. Pit tool (PIT, PT, PP)

1. **OC-01 Units: NOT BUILT.** Metre drawings are refused in words (CEPIT3, passes 2 to 10); D-217 wants both; metres are queued (BUILD_LOG morning note).
2. **OC-02 Plain words: NOT TESTED.** No scan for handles, paths or banned words is recorded; only "refused in words" lines are checked.
3. **OC-03 Honest closing line: NOT TESTED.** No check compares the closing line with the drawing read back, or tests "saved".
4. **OC-04 Unknown stays unknown: NOT BUILT.** TBC and APPROX. are not printed on the sheet (N-005); the "Not known" sweep is built (pass 9) but not seen on screen.
5. **OC-05 One value, one place: NOT BUILT.** The drawing does not keep its designed standards (D-180, N-009). Part proven: layers, colours and text from the lists (CEPIT1, passes 2 to 10).
6. **OC-06 Typed figures kept: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: an edit keeps every object and changes words in place (CEPIT2, passes 2 to 10); padlock, unreadable entry and "only changed fields" on the bench and fake.
7. **OC-07 Undo and redo: NOT TESTED.** No typed U in any pass (N-019).
8. **OC-08 Cancel and preview: NOT BUILT.** OC-08.4 needs the ribbon, which is not built. Part proven: planning alone draws nothing (CEPIT3). Escape at prompts, the window's X, "not marked changed" and preview against result are not tested.
9. **OC-09 Move, copy, erase: NOT TESTED.** Part proven: COPY from code takes the next free number (CEPIT4, pass 9), MIRROR, ARRAY and a paste stand-in each get their own identity (CECOPY1 to 3, passes 8 to 10), plain move found (CEPIT5), erase (golden_pit_labels_erase). Not tested: typed COPY, Ctrl grip-copy, real PASTE with save and reopen, OOPS, Save As figures.
10. **OC-10 Labels: NOT TESTED.** A hand-moved tag keeping its offset is built (round 39) but needs a supervised MOVE (NIGHT_TEST entry 39 item 1); label angles not checked.
11. **OC-11 Levels along a run: TESTED ON THE PRETEND DRAWING ONLY.** The brain's 20-pit job and the bench; no night check writes levels through the Pit tool.
12. **OC-12 Long section on the sheet: NOT TESTED.** Proposed does not apply (the Pit tool draws no long section); a reviewer must rule it.
13. **OC-13 Pit schedule: NOT TESTED.** Proposed does not apply while no schedule tool exists; a reviewer must rule it.
14. **OC-14 Real geometry: NOT TESTED.** Nothing records the Pit tool's part of cover or geometry in AutoCAD.
15. **OC-15 Names and numbers: NOT BUILT.** Retyping to rename, one series, the after-issue choices (D-183 to D-185, N-008) are not built. Part proven: next free number for copies (CEPIT4, CECOPY1 to 3).
16. **OC-16 UCS and rotation: NOT BUILT.** Nothing handles a UCS (course, searched 18 Nov; nothing since says otherwise). Part proven: a turned pit moves its joined end (CEPIT6).
17. **OC-17 Windows fit: NOT BUILT.** Small-screen tabs (D-193, N-020) are not built; no window has been seen inside AutoCAD.
18. **OC-18 Ours only, double-click: NOT BUILT.** Double-click takeover is proven only on the trials chat's test code (R-011), not in the Pit tool (U-033).
19. **OC-19 Protections: NOT BUILT.** Lock, xref and reference edit are checked before an edit (batch B), on the pretend drawing only; the guard (`EditGuard.cs`) has no read-only drawing or paper-space check.
20. **OC-20 Nothing shared changed: NOT BUILT.** No shared-settings guard (SP-18), no before-and-after snapshot.
21. **OC-21 Native untouched: NOT TESTED.** No with-and-without comparison has run. Known clash on OC-21.3: PIT and PP are declared by both plug-ins (CEWHOSE, pass 9).
22. **OC-22 No plug-in: NOT TESTED.** Part proven: notes invisible to a plain view, only plain classes, saves in 2000 and 2013 (CETEST, passes 2 to 10). Nobody has opened or plotted the drawing without the plug-in.
23. **OC-23 Unfinished is normal: NOT BUILT.** The plot line (D-188, N-020) is not built. Part proven: a stand-in outline on a blank drawing, listed as not done (CEPIT7, passes 7 to 10).
24. **OC-24 The two wrong-figure cases: NOT TESTED.** Proposed does not apply (they are Detention's); a reviewer must rule it.
25. **OC-25 Privacy: NOT BUILT.** No log or fault report (N-012).
26. **OC-26 Speed: NOT TESTED.** Part proven: plug-in load, self-check, Pit window model, typing, pit move (54 ms cold, 45 warm in pass 9; 57 and 46 in pass 10). Not measured: the window on screen, plot, save, pan, zoom, copying 200.
27. **OC-27 Failures contained: NOT TESTED.** Part proven: an office dictionary left alone (CEPIT7, passes 7 to 10). Not tried: a damaged or newer note, a missing list file, a failed save; the Pit put-back is fake only.

**Pit: 0 of 27 proven in AutoCAD.** Pretend only 2; not tested 13; not built 12.

---

## 2. Pipe tool (PIPE, CD)

1. **OC-01 Units: NOT BUILT.** Metres refused in words (CEPIPE3, passes 2 to 10); not built.
2. **OC-02 Plain words: NOT TESTED.** No words scan recorded.
3. **OC-03 Honest closing line: NOT TESTED.** No check of the closing line against the drawing.
4. **OC-04 Unknown stays unknown: NOT BUILT.** TBC and APPROX. not printed (N-005); TBC in place of an unknown grade (D-277) is not stated built.
5. **OC-05 One value, one place: NOT BUILT.** D-180 not built (N-009). Part proven: layers, colours, linetype and label from the lists (CEPIPE1).
6. **OC-06 Typed figures kept: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: an edit keeps the objects and changes width and words in place (CEPIPE2); the rest bench and fake.
7. **OC-07 Undo and redo: NOT TESTED.** CEBEND4 takes back the last pipe through the plan in AutoCAD (pass 10), not a typed U.
8. **OC-08 Cancel and preview: NOT BUILT.** No ribbon (OC-08.4); the live on-cursor preview is not built (O-026). Part proven: Cancel draws nothing (CEPIPE3).
9. **OC-09 Move, copy, erase: NOT BUILT.** A copied pipe is still "not yet named" (CEPIPE4, pass 10; entry 42 obstacle line d). Part proven: joins stay on the originals, plain move found, erased pit reported (CEPIPE4 to 6).
10. **OC-10 Labels: NOT BUILT.** A typed-over pipe label is not kept and flagged (N-007). Labels following a moved pipe are built (batch B), not proven in AutoCAD; CEBEND1 FAILS on the bent pipe's label start point (pass 10).
11. **OC-11 Levels along a run: TESTED ON THE PRETEND DRAWING ONLY.** Brain and bench.
12. **OC-12 Long section on the sheet: NOT TESTED.** Proposed does not apply; reviewer to rule.
13. **OC-13 Pit schedule: NOT TESTED.** Proposed does not apply; reviewer to rule.
14. **OC-14 Real geometry: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: the length along the bends, not straight across (CEBEND3, pass 10). Cover to the outside top and under the paving along the pipe: brain only.
15. **OC-15 Names and numbers: NOT BUILT.** D-183 to D-185 not built.
16. **OC-16 UCS and rotation: NOT BUILT.** No UCS handling.
17. **OC-17 Windows fit: NOT BUILT.** Small-screen tabs not built; window not seen in AutoCAD.
18. **OC-18 Ours only, double-click: NOT BUILT.** Not in the real tool (U-033).
19. **OC-19 Protections: NOT BUILT.** Lock, xref, reference edit on the pretend drawing only; no read-only or paper-space check.
20. **OC-20 Nothing shared changed: NOT BUILT.** No shared-settings guard.
21. **OC-21 Native untouched: NOT TESTED.** No with-and-without comparison. Known clash: CD declared by both plug-ins (CEWHOSE, pass 9).
22. **OC-22 No plug-in: NOT TESTED.** Notes invisible and saves proven (CETEST); never opened without the plug-in.
23. **OC-23 Unfinished is normal: NOT BUILT.** Plot line not built. Part proven: join-later parts and rejoins a loose end (CEPIPE7, passes 2 to 10).
24. **OC-24 Wrong-figure cases: NOT TESTED.** Proposed does not apply; reviewer to rule.
25. **OC-25 Privacy: NOT BUILT.** No log or fault report.
26. **OC-26 Speed: NOT TESTED.** Part proven: Pipe window model 31 ms cold, 21 warm, typing, pit move with pipes (CESPEED pass 10). Not measured on screen, plot, save, pan, zoom, copying 200 pipes.
27. **OC-27 Failures contained: NOT TESTED.** Put-back at nine points is on the fake only; damaged note not tried.

**Pipe: 0 of 27 proven in AutoCAD.** Pretend only 3; not tested 10; not built 14.

---

## 3. Long section tool (LONGSECTION, LG)

1. **OC-01 Units: NOT BUILT.** CELEV2 refuses inches; metre drawings are still refused by the tools (NIGHT_TEST entry 41 obstacle line c).
2. **OC-02 Plain words: NOT TESTED.** No words scan recorded.
3. **OC-03 Honest closing line: NOT TESTED.** Part proven: a failing step puts back and says so (CELEV5, passes 1 to 10). No check of the closing line against the drawing.
4. **OC-04 Unknown stays unknown: NOT BUILT.** TBC and APPROX. not printed (N-005).
5. **OC-05 One value, one place: NOT BUILT.** D-180 not built. Part proven: the typed names are the office list's (CELEV6).
6. **OC-06 Typed figures kept: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: a typed grade is held with its source and a typed-over figure reads "TypedOver" (CELEV1, passes 8 to 10). "Only changed figures written back" (DQ-033) and the window: fake and bench.
7. **OC-07 Undo and redo: NOT TESTED.** No typed U.
8. **OC-08 Cancel and preview: NOT BUILT.** No ribbon. Part proven: Cancel and a standing clash write nothing (CELEV2).
9. **OC-09 Move, copy, erase: NOT TESTED.** Part proven: a copy carries the join figure (CELEV4), a plain move is said (CELEV3). Typed commands not tested.
10. **OC-10 Labels: NOT TESTED.** It changes label words in place (CELEV1); its cover-text redo (DQ-034) needs a supervised look (NIGHT_TEST entry 42 item 6), not done.
11. **OC-11 Levels along a run: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: typed grades and drops written into the records (CELEV1); the brain's 20-pit job; "OK still saves with Wrong" is the window, not seen.
12. **OC-12 Long section on the sheet: NOT BUILT.** "Draw on sheet" is built last (D-276, N-021).
13. **OC-13 Pit schedule: NOT TESTED.** Proposed does not apply; reviewer to rule.
14. **OC-14 Real geometry: TESTED ON THE PRETEND DRAWING ONLY.** Part proven: the length along the bends through the Long section's find (CEBEND3, pass 10). Cover along the pipe: brain only.
15. **OC-15 Names and numbers: NOT BUILT.** Renumbering not built; it shows a duplicate as "P3 (2)" (fake).
16. **OC-16 UCS and rotation: NOT BUILT.** No UCS handling.
17. **OC-17 Windows fit: NOT BUILT.** Small-screen tabs not built; repeating rows for long runs (D-271) not stated built; not seen in AutoCAD.
18. **OC-18 Ours only, double-click: NOT BUILT.** Not in the real tool.
19. **OC-19 Protections: NOT BUILT.** Pretend drawing only; no read-only or paper-space check.
20. **OC-20 Nothing shared changed: NOT BUILT.** No shared-settings guard.
21. **OC-21 Native untouched: NOT TESTED.** LONGSECTION and LG are declared by the new plug-in only (CEWHOSE, pass 9); no with-and-without comparison.
22. **OC-22 No plug-in: NOT TESTED.** Never opened without the plug-in.
23. **OC-23 Unfinished is normal: NOT BUILT.** Plot line not built. Part proven: a loose start and a branch are followed and said (CELEV2, passes 2 to 10).
24. **OC-24 Wrong-figure cases: NOT TESTED.** Proposed does not apply; reviewer to rule.
25. **OC-25 Privacy: NOT BUILT.** No log or fault report.
26. **OC-26 Speed: NOT TESTED.** Part proven: window model 93 ms cold, slowest warm 112.8 (limit 300), typing, CELEV7 (pass 10). Not measured on screen.
27. **OC-27 Failures contained: NOT TESTED.** Part proven: put-back (CELEV5). Damaged or newer note not tried.

**Long section: 0 of 27 proven in AutoCAD.** Pretend only 3; not tested 11; not built 13.

---

## 4. LPD tool (LEGALPOINT, LPD; was Outlet)

1. **OC-01 Units: NOT BUILT.** Side drawings in millimetres only; metres not built.
2. **OC-02 Plain words: NOT TESTED.** No words scan recorded.
3. **OC-03 Honest closing line: NOT TESTED.** Nothing recorded.
4. **OC-04 Unknown stays unknown: NOT BUILT.** TBC and APPROX. printing not built anywhere (N-005).
5. **OC-05 One value, one place: NOT BUILT.** D-180 not built; the no-plot layer name is the build's proposal (entry 42 line c).
6. **OC-06 Typed figures kept: NOT TESTED.** No typed figure of LPD's is recorded as tested.
7. **OC-07 Undo and redo: NOT TESTED.** No typed U.
8. **OC-08 Cancel and preview: NOT BUILT.** No ribbon; no Cancel check for LPD recorded.
9. **OC-09 Move, copy, erase: NOT TESTED.** The tag following a moved end is built (item 80) on the fake only; no copy check.
10. **OC-10 Labels: NOT TESTED.** Tag slid along the pipe and following, fake only; angles not checked.
11. **OC-11 Levels along a run: NOT TESTED.** Proposed does not apply; reviewer to rule.
12. **OC-12 Long section on the sheet: NOT TESTED.** Proposed does not apply; reviewer to rule.
13. **OC-13 Pit schedule: NOT TESTED.** Proposed does not apply; reviewer to rule.
14. **OC-14 Real geometry: NOT TESTED.** Proposed does not apply; reviewer to rule.
15. **OC-15 Names and numbers: NOT TESTED.** Named by kind; "numbered only when two of a kind" (D-275) is not recorded as tested.
16. **OC-16 UCS and rotation: NOT BUILT.** No UCS handling.
17. **OC-17 Windows fit: NOT TESTED.** Whether LPD opens a window, and its size, is not stated; nothing seen in AutoCAD.
18. **OC-18 Ours only, double-click: NOT BUILT.** A pick that is not our pipe is refused in words (fake, entry 42 item 5); double-click not in the real tools.
19. **OC-19 Protections: NOT BUILT.** Pretend drawing only; no read-only or paper-space check.
20. **OC-20 Nothing shared changed: NOT BUILT.** No shared-settings guard.
21. **OC-21 Native untouched: NOT TESTED.** LPD and LEGALPOINT are free (name check, pass 8; CEWHOSE, pass 9); no with-and-without comparison.
22. **OC-22 No plug-in: NOT TESTED.** Never opened without the plug-in.
23. **OC-23 Unfinished is normal: NOT BUILT.** Plot line not built. Part proven: the marker is named by kind on a layer that does not plot, and a loose end on it joins (CEPIPE8, passes 8 to 10).
24. **OC-24 Wrong-figure cases: NOT TESTED.** Proposed does not apply; reviewer to rule.
25. **OC-25 Privacy: NOT BUILT.** No log or fault report.
26. **OC-26 Speed: NOT TESTED.** CESPEED has no LPD line.
27. **OC-27 Failures contained: NOT TESTED.** Nothing recorded for LPD.

**LPD: 0 of 27 proven in AutoCAD.** Pretend only 0; not tested 17; not built 10.

---

## 5. Totals

1. **Pit:** 0 of 27 proven in AutoCAD.
2. **Pipe:** 0 of 27 proven in AutoCAD.
3. **Long section:** 0 of 27 proven in AutoCAD.
4. **LPD:** 0 of 27 proven in AutoCAD.
5. **All four together:** 0 of 108. The course's starting score (3 of 108) counted the bench windows as a fourth column and counted bench passes; this score has no bench column and counts AutoCAD only.

## 6. Obstacles no tool has passed

All 27: OC-01 to OC-27.

---

## 7. The five closest to passing, and the one check that would close the biggest gap in each

1. **OC-26 Speed (Pit, Pipe, Long section).** Every limit CESPEED measures passes (pass 9 and 10). One check: a timed session with and without the plug-in loaded for plot, save, pan and zoom (OC-26.7), on a test copy. Still left after it: the window on screen (stopwatch) and copying 200 pipes (OC-26.8, a CESPEED line).
2. **OC-09 Copies (Pit).** COPY from code, MIRROR, ARRAY and a paste stand-in pass. One check: a supervised session with Tim's mouse (W-066): Ctrl grip-copy, typed COPY, a real PASTE into a second drawing saved, closed and reopened, then OOPS after an erase. Still left: Save As figures (OC-09.5).
3. **OC-27 Failures contained (Long section, Pit).** Put-back (CELEV5) and the office dictionary (CEPIT7) pass. One check: a night check that plants one damaged note and one newer-version note in a side drawing and runs each tool (OC-27.1). Still left: a failed save says "not saved" (OC-27.5).
4. **OC-22 No plug-in (all four).** Notes invisible, plain classes and old-format saves pass. One check: a night session that opens the saved test drawing in AutoCAD WITHOUT loading the plug-in, edits a pit and plots to file, against the plot with it (OC-22.1). Still left: DXF (OC-22.2) and the self-check's offer after a colleague's move (OC-22.4).
5. **OC-14 Real geometry (Pipe).** The length along the bends passes (CEBEND3, pass 10). One check: a CEBEND line that reads the cover at a point between the pits, to the outside top of the pipe and the underside of the paving (OC-14.2).

---

## 8. What I could not determine

1. **Whether a words scan exists** (OC-02): no file read says one was built since 18 Nov morning.
2. **Whether fake-drawing tests exist for the closing line** (OC-03.1, .2, .4) and for "edits save only changed fields" in the Pit and Pipe tools.
3. **Whether LPD opens a window** (OC-17) and what its typed prompts are.
4. **Whether TBC replaces an unknown grade on a pipe label** (D-277 DQ-050) is built.
5. **Whether the Long section's repeating rows** (D-271 DQ-032) are built.
6. **OC-06.5 against D-263:** the course says a new window never starts from a hidden remembered figure; D-263 (Tim) says pits, inlets and tanks open with last used, kept in a CE file, with a setting. Whether OC-06.5 still stands as written is the planning chat's to settle.
7. **Whether CEPIT1 and CEPIPE1 prove an EXISTING layer is left unchanged** (OC-20.2): NIGHT_TEST says EnsureLayer "never changes one that is there", but the pass 10 line names only "layers are made from the list".
8. **The bench windows** (Detention, Tank, Inlet, Schedule) were not scored: they are not AutoCAD tools, and no night check opens them.
9. **I did not open every result file of every pass;** marks rest on TREND, NIGHT_TEST, the BUILD_LOG entries named and pass 10's summary lines. "Not built" for the read-only and paper-space guard rests on one file, `EditGuard.cs`.
