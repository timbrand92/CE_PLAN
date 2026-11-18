# Check of the board revision 2 draft (for the planning chat)

**Date:** Wed 18 Nov 2026, about 11:20 pm by the clock (Melbourne). Written by a helper of the planning chat. Read only: nothing run, built, installed or committed; `BOARD.md` and `BOARD_REV2_DRAFT.md` are untouched.
**Read in full:** `BOARD_REV2_DRAFT.md`; `BOARD.md` section 12 items 1 to 90 (and the ID lists of sections 2 to 7); `DECISIONS.md` D-238 to D-297; `MORNING_19NOV.md`; `DIRECTOR_SUMMARY.md`. **Also read to settle facts:** `C:\CE_CIVIL\acad\night_results\TREND.md` (ten passes, not nine: pass 10 ran at 11:12 pm, after the board's last item), `C:\CE_CIVIL\BUILD_LOG.md` (morning note, entries 41 to 46), `C:\CE_CIVIL\acad\NIGHT_TEST.md`, `rulings\INDEX.md` (two lines), `C:\CE_CIVIL\src\CeCivil.Hands\EditGuard.cs` (what the lock guard checks).
Nothing here is a ruling. Where the files do not say, this page says "not stated".

---

## 1. Verdict

1. **Yes, the draft can replace the board once the corrections in part 3 and the new lines in part 5 are pasted in.** Its shape, IDs and most lines are right, and its W count is arithmetically correct.
2. **What is wrong with it, in short:** (a) it stops at item 79, so items 80 to 90 (batch B, passes 8 and 9, preview option C's second test, the tank blocks, the Pit window in the approved style) are missing and about a dozen of its open lines are now closed or narrowed; (b) two "closed" lines say fixes were "proven in pass 7" when no night check runs those windows; (c) four plain fact slips (PP called free; SH called unknown; invert text called done; D-191 used for something it does not say); (d) three closed W IDs are counted but never listed.
3. **Corrections: 47** (part 3). **Not sure entries:** 14 fully settled by the files, 4 partly, 8 left for the planning chat (part 4). **New lines: 6 W, 3 O, 5 N (3 already closed), 2 U, 0 K** (part 5).

---

## 2. Recounted totals

1. **W, waiting on Tim:** the draft's 45 is right (28 old IDs + 17 new, W-044 to W-060). Its "14 closed" is also right, but only 11 are listed: W-007, W-026 and W-042 are missing from the closed list (correction 11). **After this check: 51 open** (45 + W-061 to W-066; none of the 45 closes, several narrow).
2. **O, owed:** draft 33. Closed by items 82 and 83: O-028, O-029, O-035. New: O-038 to O-040. **After this check: 33 open.**
3. **N, problems:** draft 38. Closed: N-016, N-064, N-068 (N-016 by the passes, the other two by items 80, 82 and 87). New open: N-072, N-073. New and already closed: N-069, N-070, N-071. **After this check: 37 open** (38 − 3 + 2).
4. **U, unproven:** draft 38. Closed: U-038 (item 82), U-039 (TREND pass 3). New: U-041, U-042. **After this check: 38 open.**
5. **K, parked:** 25, unchanged. Nothing in items 80 to 90 parks anything.
6. **Highest IDs after this check:** W-066, O-040, N-073, U-042, K-025.

---

## 3. Corrections to the draft (each with the exact replacement line)

### Header

1. **Draft header, "Last AutoCAD pass" line.** Wrong: it says pass 7 and that the risk-list fixes after pass 7 are not run; pass 7 WAS the risk-list commit 4821fd4 (TREND line 7), and passes 8 and 9 have run since (items 82, 87). Replace with:
   "**Installed: 0. Accepted by Tim: 0.** Last AutoCAD pass on the board: pass 9 (8:55 pm, f24a3c1), 105 checks, PASS 102 / FAIL 1 (the known code-route EXPLODE gap) / NOT TESTED 2; speed 13 of 13. Newer than the board: pass 10 (11:12 pm, adcc5aa, bends), 114 checks, PASS 110 / FAIL 2 / NOT TESTED 2 (TREND line 10). Function batches A and B and the risk-list fixes are run in AutoCAD; what the night checks do not touch (the bench windows) is not."
2. **Draft header, counts block.** Replace the five lines with: "W 51 open; O 33 open; N 37 open; U 38 open; K 25. Closed since revision 1: W 14, O 7, N 35 (including N-069 to N-071, opened and closed the same evening), U 4 numbered."

### Waiting on Tim (W)

3. **W-051 (preview).** Its test result is out of date: item 85 found a way round the save prompt and proved docking. Replace with:
   "**W-051 Preview: option A, B or C.** Ask: A as approved (a quarter of the window), B half the window, C no preview inside, the window docked beside the real drawing, which zooms to and lights up the system. Tested on a 2,500-object drawing (items 74, 85; R-012): C docks at the right with the drawing usable, runs in 7 to 11 thousandths of a second, and by the supported graphics route leaves the drawing unmarked, so AutoCAD asks no "Save changes?". Still to do for C: an accurate zoom by that route (it landed off-centre at about 1.5 times the scale), a click on the docked window's OK and Cancel with his own mouse, and proof that docking saves nothing in his profile. Planning chat recommends C, with B as the fallback until those three are proven (MORNING item 3). Detail: `pictures\preview_options.html`, D-297. Since: 18 Nov, 5:30 pm. Needs: one click."
4. **W-046 source.** It is recorded: MORNING item 12. Replace "Source: your brief; not recorded in BOARD.md (check `interview_tools\TEXT_SPEC.md`)" with "Source: `MORNING_19NOV.md` item 12 (stays as placed, as hatches TA-110, or resizes, as dimensions D-210)."
5. **W-060 source.** It is recorded: MORNING item 13. Replace its Ask and Source with "Ask: plain names for the two detention methods; the planning chat's proposal is "Office method (Boyd's)" and "Council tool (OSD4W)". Source: `MORNING_19NOV.md` item 13."
6. **W-039 (two pairs).** Pair (a) is settled: `rulings\INDEX.md` marks D-060 against D-143 and D-174 "SETTLED by D-263 (18 Nov)", in Tim's words ("Smart: pipe follows what it joins"). Replace with:
   "**W-039 One pair of rulings that pull against each other (narrowed).** Whole-job facts in a CE side panel (D-048) against a Job window (D-099, D-171). Pair (a) is settled by D-263; pair (c) by D-278. Detail: `rulings\INDEX.md`. Since: 18 Nov. Needs: one click, with a part-drawn job as the example."
7. **W-048 (189 layers).** The list has landed (item 83). Replace with:
   "**W-048 The 10 layer questions (20 of the master's 189 layers).** Ask: settle the overlaps the interview chat found (`interview_tools\LAYERS_BY_FUNCTION.md` rev 1, LY-001 to LY-189: 136 keep, 28 as the hatch list, 4 drop-candidates never used, 1 retired); and where the consultant match list lives (office IT folder assumed, DRAFT). Since: 18 Nov, 8:20 pm. Needs: one click per question. Before: OL."
8. **W-009.** Add at the end: "The 3,500 L tank block and the word "Slimline" are now separate asks, W-061 and W-062 (item 84)."
9. **W-058.** Add at the end: "The build went ahead on this DRAFT reading in batch B (item 80: a council pit uses the office pit block; the kerb is a listed stand-in), so his answer may change built work."
10. **W-024.** Its note leans on D-191, which as recorded says only that drafters start a new job "From the office template". D-191 does not say an existing layer is never changed, so D-260's DQ-005 citation does not support that. Replace the Note with: "Note: D-260 (planning chat's call, DQ-005) says an existing layer is never changed and cites D-191, but D-191 is about starting from the office template; OC-20.2 says the same as D-260 and is not ruled (OQ-07). Still his call."
11. **Closed list, add three W IDs** (the draft counts them in "14 closed" but never names them). Add under "By Tim's rulings":
    "**W-007** The build chat's DRAFT calls: 104 of 104 closed (item 53; the last, D-293). **W-026** The draft speed and upper limits: settled by D-288 (DQ-089 to DQ-096, as built; planning chat's call, his to overturn). **W-042** Merged: its PIT and CD half is W-003 (closed by D-258); its SH half was answered by TREND pass 3 (SH is AutoCAD's own shell command), see U-039."

### Owed (O)

12. **O-022.** The joints names need no change (item 62: SSC is the short name, "SC" only the printed label; "the names page was right"). Replace with: "**O-022 Bring the `rulings\` names page and THE_PLAN section 3 into line with D-274** (Outlet and LPD are one tool, LEGALPOINT / LPD). The joints names are right as they stand (item 62). Since 18 Nov."
13. **O-028 (batch B).** CLOSED by item 82. Move to the closed list as: "**O-028** Function batch B committed (fa8bcb7, reviewed twice, PASS) and run in AutoCAD as pass 8 (item 82). Left over and carried: Ctrl grip-copy (U-035, W-066); which plug-in AutoCAD runs for PIT, PP and CD (U-031, W-063)."
14. **O-029 (run batches A and B at night).** CLOSED by item 82 ("Batches A and B are now both run in AutoCAD"). Move to the closed list with that citation.
15. **O-030 (text heights).** Wrong about invert text. NIGHT_TEST entry 41 item 4: "Nothing draws the invert text yet ... no tool uses it". Replace with: "**O-030 Text heights from size times DIMSCALE.** Built in batch A (entry 41, ea1af65) for pit numbers, cover levels and pipe labels, and drawn at DIMSCALE 100 in passes 8 to 10 (CEPIT1, CEPIPE1: 350, 200 and 250). Not done: invert text is only a row in the office list (20TEXT, 1.8 mm); nothing draws it yet. Not proven in AutoCAD: 1:20, 1:50 and DIMSCALE 0 (U-042). Since 18 Nov."
16. **O-031 (tank sums).** Narrowed. Replace with: "**O-031 Each tank holds its own detention; no orifice pick list; no pipe size box in Detention (D-285).** Not stated built. Done: the Tank size list from the office tank blocks (item 87; read from the civil template copy, the office master holds no tank block; bench only, the Tank window has no AutoCAD command); re-use typed once and detention = tank less re-use (item 78). Since 18 Nov."
17. **O-032 (restyle).** Narrowed. Replace with: "**O-032 Restyle the other windows to the approved style when each is next touched** (D-295, his rule 3). Done: the shared style parts and the Pit bench window, committed ec66ca3 after a separate checker's PASS (items 88 to 90); the AutoCAD Pit tool keeps its own layout and live preview until W-051. Since 18 Nov."
18. **O-033 (preview option C tests).** Narrowed by item 85. Replace with: "**O-033 Preview option C, remaining tests:** an accurate zoom by the graphics route; a real mouse click on the docked window's OK and Cancel (the robot's keyboard reached them, its mouse did not); proof that docking saves nothing in his profile. Proven since: docked at the right; no "Save changes?" by the graphics route; outlines and tags with no view change (item 85). Only if he picks C. Since 18 Nov."
19. **O-034 (R-70 checks).** Add: "The build chat's runner now has the guard trip that stops the whole pass, the 10-second input wait and a 60-second limit per step (items 55, 73). "Exactly one test AutoCAD after a launch" and the notification guard: not stated built."
20. **O-035 (189-layer list).** CLOSED by item 83 (`interview_tools\LAYERS_BY_FUNCTION.md` rev 1, committed 5:39 pm). Move to the closed list; what it asks of Tim is W-048.
21. **O-018 (re-score the obstacle course).** Replace with: "**O-018 Re-score the obstacle course.** Re-scored against passes 1 to 10 in `stage6\OBSTACLE_SCORE_18NOV.md` (helper, 18 Nov night); open until the planning chat has checked it. Since 18 Nov."

### Problems (N)

22. **N-001.** Replace "still fails in pass 7" with "still fails in passes 9 and 10 (golden_explode_pipe)".
23. **N-004 (bends).** Bends are built (entry 46). Replace with: "**N-004 Bends.** Built on the pretend drawing (entry 46) and run in AutoCAD in pass 10 (11:12 pm, newer than the board): CEBEND1 to CEBEND4, 9 checks, 1 fail (the label's start point, N-073). Still not built: arcs, a branch joined to a main pipe, splitting a main pipe (entry 46 item 9). Status: AutoCAD, one fail."
24. **N-006 (pipe labels follow a move).** Status: "bench". Replace "Batch B." with "Built in batch B (fa8bcb7); not stated proven in AutoCAD; no night check named for it."
25. **N-008 (copies and numbering).** Narrowed. Replace with: "**N-008 Numbering rules still not built:** one series for two systems (D-183), the after-issue choices (D-184), retyping a tag renames the pit (D-185). A copied pipe is still "not yet named" (entry 42 obstacle line d; CEPIPE4 in pass 10). Proven in AutoCAD since: a copied pit takes the next free number and its own identity by COPY from code (CEPIT4, pass 9), MIRROR, ARRAY and a paste stand-in (CECOPY1 to 3, pass 8), and a mirrored copy's level is marked Assumed (CECOPY1)."
26. **N-011 (protections).** Status: "bench". Replace with: "**N-011 Locked layers, xrefs and reference edit:** checked before every edit by PT, PIPE, the Long section and LPD, said in words (batch B, item 80); tested on the pretend drawing only; the AutoCAD proof is a supervised look (NIGHT_TEST entry 42 item 7; a robot may not lock a layer). Not built: a read-only drawing and paper space (the guard, `EditGuard.cs`, checks only lock, xref and reference edit)."
27. **N-013.** Remove the claim about invert text. Replace with: "**N-013 The Pipe tool does not yet draw the flow arrow, the invert text or the office's edge lines.** Found; invert text is a list row only (NIGHT_TEST entry 41 item 4); edge lines are O-026 (queued, item 88)."
28. **N-014.** Replace with: "**N-014 Joining to another pipe is not built; a pit dropped on a pipe does not split it** (D-077). A click on an existing pipe now ends the new pipe as a "junction" note, not a join and not a split (entry 46, DRAFT). Pipe-end join to a pit wall (D-270) is built and committed (batch B); its grip proof is a supervised look (NIGHT_TEST entry 42 item 5)."
29. **N-016.** CLOSED. Move to the closed list as: "**N-016** PIT BLOCK 3's stretch sizes are set and read back through the block's own distances: CEPIT8 8 of 8 in pass 5 and in every pass since (TREND lines 5, 7 to 10)."
30. **N-025.** Narrowed. Replace with: "**N-025 One golden recording still not seen:** golden_pit_state_set is NOT TESTED in every pass (CETEST's side drawing has no real dynamic block). All the others are re-taken each pass and pass, except golden_explode_pipe (N-001)."
31. **N-064 (stale CELEV1).** CLOSED: corrected in batch B (item 80); passes 8, 9 and 10 do not fail it. Move to the closed list.
32. **N-067 (DIMSCALE 0).** Status: "bench". Replace "Batch B, first." with "Alert before the window opens and nothing drawn at a guessed height: built in batch B (item 80). AutoCAD proof needs a DIMSCALE 0 test copy made by Tim (NIGHT_TEST entry 42 item 9; U-042)."
33. **N-068 ("Not known" sweep).** CLOSED as a build item: the sweep is in f24a3c1, run as pass 9 (item 87). Move to the closed list; the on-screen look of the words is U-041.
34. **N-032 and N-033 used twice.** Replace the closed line's tail with: "Written as **N-032 (item 13)** a palette size not carried into our note: closed by round 39 (item 45) and proven in AutoCAD by CEFACTS1 check 3 (passes 7 to 10); **N-033 (item 13)** CEPROPS already taken: closed by the rename to CEFACTS1 (item 24). **N-032 (item 17) to N-038** as below. IDs are not reused; the item number tells them apart."
35. **Closed list item 19 overclaims.** "proven in pass 7" is not supported: the night checks do not open the windows. Replace with: "**N-032 (item 17) to N-038** (the seven build-against-ruling fixes), lid class in the Pit window, "SPS grated" and "SPS solid": round 39, abd517c, reviewed twice, PASS; built and tested on the pretend drawing and the bench. In AutoCAD only two parts are covered: N-038 by CELEV1 (once its stale check was corrected, pass 8) and the size step by CEFACTS1 check 3. The hand-moved label (N-032 item 17) needs a supervised MOVE (NIGHT_TEST entry 39 item 1); the grey and amber looks need a look."
36. **Closed list item 20 overclaims** (as does board item 72). The Detention, Tank, Inlet and Schedule windows are bench windows; no night check opens them. Replace with: "**N-039 to N-056** (18 wrong-figure and pretend-to-work fixes; N-056 settled by D-289): 4821fd4, reviewed by Opus, PASS WITH FIXES; fixed and tested on the bench (brain 598, bench 313 at the time). Pass 7 ran that commit with no new failure in the night checks, but those checks do not exercise the bench windows, so these fixes are bench-proven, not AutoCAD-proven. Boyd's re-worked by hand under round-first: 2.65 and 2.29 unchanged, the office case 1.66, the made-up job 1.64."

### Unproven (U)

37. **U-012 (names free).** PP is not free. Replace with: "**U-012 That each typed name is free in AutoCAD 2027.** Read so far: SCH, SCHEDULE, LPD, LEGALPOINT, TRENCHGRATE, AG and LG are free (TREND passes 3, 4, 8); SH is AutoCAD's own shell command (pass 3); TG is the old plug-in's (pass 4, kept by D-233); PIT, PP and CD are declared by both the new and the old plug-in (CEWHOSE, pass 9). Not yet read: BREAKLINE (an Express Tools name), REVBOX, CLEAN, ARCDIM and the others."
38. **U-031 (D-258).** Replace the Proof with: "Read-only finding (CEWHOSE, pass 9): PIT, PP and CD are each declared by both plug-ins; PT, PIPE, LONGSECTION, LG, LEGALPOINT and LPD by the new one only. Which one AutoCAD runs for the three shared names cannot be read without typing it. Proof: a supervised typed check with Tim (W-063), or loading the new plug-in before the old."
39. **U-034 (preview option C).** Replace with: "**U-034 Preview option C: an accurate zoom by the graphics route, a real mouse click on the docked window's OK and Cancel, and nothing saved in his profile by docking.** Proven since: docked at the right; no save prompt by the graphics route (item 85). Proof: R-012 follow-up (O-033)."
40. **U-035 (copy identity).** Replace with: "**U-035 A copy gets its own identity by Ctrl grip-copy, typed COPY and a real PASTE.** Proven in AutoCAD: COPY from code (CEPIT4), MIRROR, ARRAY and a WblockClone stand-in for paste (CECOPY1 to 3, pass 8). Proof: a supervised session with his mouse (W-066)."
41. **U-038.** CLOSED by item 82 (batches A and B and the risk-list commit are run in AutoCAD, passes 7 to 9). Move to the closed list.
42. **U-039 (SH).** CLOSED by TREND pass 3: "SH is AutoCAD's own shell command (acad.pgp: SH = DOS command)". Move to the closed list with: "Answered: SH clashes. Whether our tool needs another short name is the planning chat's to put under W-019."

### Where things live, and Not sure

43. **Section 7 item 19, highest IDs.** Replace "Highest now W-060, O-037, N-068, U-040, K-025" with "Highest now W-066, O-040, N-073, U-042, K-025".
44. **Section 7 item 24, night check names.** Replace the list with: "night check names CESEED, CESPEED, CETEST, CEPIT1 to 8, CEPIPE1 to 8, CELEV1 to 7, CEFACTS1, CECOPY1 to 3, CEWHOSE, CEBEND1 to 4."
45. **Section 7 item 23, build chat files.** Add `acad\night_results\TREND.md` (one line per AutoCAD pass, ten so far) and `acad\NIGHT_TEST.md`.
46. **Section 8 Not sure 4.** Settled; replace with: "Pass 4 squares: TREND line 4 reads PASS 97 / FAIL 4 / NOT TESTED 2 plus one CESEED done, 104 in all."
47. **Section 6, "By the planning chat", O-014.** Keep closed, add: "The summary is stale again since items 85 and 87 (see O-040)."

---

## 4. The 26 "Not sure" entries, one by one

1. **The W count.** SETTLED: 45 is right (28 old + 17 new). The slip is in the closed list, which names 11 of 14 (correction 11).
2. **N-032 and N-033 used twice.** SETTLED: item 13's pair closed by round 39 plus CEFACTS1 check 3 (passes 7 to 10) and by the CEFACTS1 rename (item 24); item 17's pair closed on the bench (item 45). Write them with the item number (correction 34).
3. **N-048 against N-001.** SETTLED: board item 40 and item 72 describe one fault (golden_explode_pipe, code route); merge stands; N-048 stays a closed-as-duplicate ID, never reused.
4. **Pass counts.** SETTLED: pass 4 squares with CESEED (TREND line 4); pass 7 squared to 102 (item 73).
5. **D-261 against D-290.** SETTLED: D-290 says it corrects D-261 on DQ-022.
6. **W-023 against the Manager spec.** SETTLED: item 28 (TA-088 to TA-098) "fault report always carries the drawing (office IT folder only)"; item 81 calls W-023 overturned.
7. **W-024 against D-260.** NOT SETTLED, and the draft's reason is weaker than it looks: D-191 does not say what D-260 cites it for (correction 10). Keep open; ask the planning chat.
8. **W-002 and N-003.** NOT SETTLED. Darebin 0.80 confirmed: not stated. N-003's "Kingston rainfall everywhere": the risk-list fixes N-040 to N-042 touch it (council C line, emptied rainfall, APPROX.) but no file says N-003 is finished. Ask the planning chat.
9. **W-008, W-009, W-010, W-019, W-020.** MOSTLY NOT SETTLED. W-009's tank-size half is settled by D-282 and since narrowed by item 84 (W-061, W-062); FO and OF still open. The other four: not stated. Ask the planning chat.
10. **W-018 (Bl).** NOT SETTLED: D-250 does not name Bl. Keep open.
11. **W-039 pair (a).** SETTLED: `rulings\INDEX.md` marks it settled by D-263 (correction 6).
12. **W-040.** SETTLED for the ASK items (item 21: "All five ASK items ... are now answered"). Whether the 77 FP lines still stand after D-246 and D-274: not stated; ask the planning chat.
13. **Planning-chat calls counted as closed.** SETTLED as the board's own convention (item 53: "104 of 104 closed"); W-026 closes on D-288 under it. The policy itself stays the planning chat's.
14. **W-050 against D-288.** SETTLED: both stand; MORNING item 10 still asks it. Keep open.
15. **O-009, O-014, O-015, O-016, O-020.** PARTLY. O-014: closed, but the summary is stale again (O-040). O-020: held for W-043, keep. O-009, O-015, O-016: not stated; ask the planning chat.
16. **N-016, N-025, N-002.** SETTLED: N-016 closed (correction 29); N-025 narrowed to one recording (correction 30); N-002 closed on CESPEED's own "moving a pit with its pipes" line (54 ms cold, 45 warm in pass 9).
17. **N-027.** SETTLED: the board names a commit for every round (abd517c, 4821fd4, ea1af65, fa8bcb7, f24a3c1, ec66ca3; adcc5aa in TREND). The BUILD_LOG entries' "Not committed" headers were written at build time and are stale.
18. **N-017 and U-033.** NOT SETTLED: a policy choice (the rule is in the builder brief, item 51; the real tools do not carry it yet). Ask the planning chat.
19. **Items from the brief not in BOARD.md.** PARTLY: W-060 and W-046 are in MORNING items 13 and 12 (corrections 4, 5). U-036 (fonts inside AutoCAD windows): not stated in any file read; ask the planning chat.
20. **Time stamps written from memory.** NOT SETTLED beyond the board's own corrections (items 20, 43, 48, 53, 90). Leave as "about".
21. **Alias file as a "saved setting" under rule 1.9.** NOT SETTLED (item 68 lists it unsure). Ask the planning chat (it may be Tim's call).
22. **Hours disagree.** PARTLY: `C:\TimOS\RULES.md` is the only rulebook and wins over AGENTS.md (AGENTS.md says so itself). RULES 1.8 sets the working and free windows; D-159 is the narrower standing yes for night AutoCAD tests (5:30 pm to 8:30 am weekdays, all weekend; not 2 to 3 pm). Whether the zero plan's own hours should be brought into line: ask the planning chat.
23. **Revision 1 sections 4, 8 and 10 not in the layout.** NOT SETTLED: a layout choice. Ask the planning chat.
24. **Item 69's slip on the tight-spaces page.** NOT SETTLED: not stated fixed. Leave noted.
25. **Small unplaced items** (grade pick list "60" DRAFT; 23 rulings fixes not shown applied; Match and Turned hidden). SETTLED as stated: none is shown done since; keep as written.
26. **K-009 trimmed.** SETTLED: item 28 (TA-096) moved statistics into the first release.

**Fully settled by the files: 14** (1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 16, 17, 25, 26). **Partly settled: 4** (9, 15, 19, 22; the open half of each goes to the planning chat). **Not settled, ask the planning chat: 8** (7, 8, 10, 18, 20, 21, 23, 24).

---

## 5. New since the draft: items 80 to 90 of section 12, ready to paste

### What items 80 to 90 close in the draft

1. **The speed regression** (opened by item 82): closed by item 87, pass 9: a pit move with its pipes 54 ms cold, 45 warm (limit 100). Issued below as N-069, closed.
2. **The "Not known" sweep:** N-068 closed (item 87).
3. **The stale checks:** CELEV1, N-064, closed (items 80, 82); CEPIT4, closed (item 87; N-070 below).
4. **Batch A and batch B run in AutoCAD:** O-029 and U-038 closed (item 82); O-028 closed (item 82).
5. **The 189-layer list:** O-035 closed (item 83).
6. **Preview option C's save prompt and docking:** W-051, O-033 and U-034 narrowed (item 85): no save prompt by the graphics route; docks at the right. Not closed: zoom accuracy, his mouse, his profile.
7. **The Tank list from the office blocks:** O-031 narrowed (item 87).
8. **The approved style on a real window:** O-032 narrowed (items 89, 90).
9. **N-016 and U-039:** closed by TREND (not items 80 to 90, but the same evening's passes).

### New W lines (continue after W-060)

1. **W-061 The 3,500 L tank outline.** Ask: which drawing counts: the civil template's block (890 x 2400) or what the old jobs measured (2250 x 650); one block name, two outlines. DRAFT until he says. Also a DRAFT note: a real tank's rounded corners can make a catalogue height read more than 3.5 per cent over (item 87). Detail: items 84, 87; D-282. Since: 18 Nov, 8:39 pm. Needs: one click.
2. **W-062 Is every rectangular tank "Slimline".** Ask: yes or no. Detail: item 84. Since: 18 Nov, 8:39 pm. Needs: one click.
3. **W-063 The supervised PIT, PP and CD check.** Ask: type PIT, PP and CD once each at the PC while a supervised check watches, with both plug-ins loaded, to see which tool opens (CEWHOSE shows both declare the three names). Detail: item 87, U-031, D-258. Since: 18 Nov, 8:58 pm. Needs: at the PC (can share a sitting with W-059).
4. **W-064 Three window calls on the approved style (planning chat's DRAFT).** Ask: (a) a figure that can be worked out or held shows as a quiet dashed field while worked out and becomes a full box when held, with both values shown; (b) a missing input is amber "Not known" with "Needs you", a check that cannot run is grey; (c) the AutoCAD Pit tool keeps its working live preview until the preview is ruled. Detail: item 89, `pictures\pit_window_approved_style.png` and `_needs_you.png`. Since: 18 Nov, about 10:25 pm. Needs: one click each.
5. **W-065 Click budgets per window (his screen rule 18).** Ask: the budget for each window; the Pit window counts 1 pick, 4 clicks, 1 typed figure, no scrolling, from the layout, not tested. Detail: item 89. Since: 18 Nov, about 10:25 pm. Needs: one figure per window.
6. **W-066 A Ctrl grip-copy look with his own mouse.** Ask: Ctrl grip-copy a pit (and a typed COPY and a real PASTE) while a supervised check watches; each copy should be numbered at once and say so once. Detail: MORNING item 15, BUILD_LOG morning note Next 5, U-035. Since: 18 Nov. Needs: at the PC.

### New O lines (continue after O-037)

1. **O-038 Check the CE no-plot layer against the master's 8 non-printing helper layers** (build chat), so D-275's CE layer does not duplicate one. Item 83. Since 18 Nov, 8:20 pm.
2. **O-039 The Pit window's next-round fixes** (build chat): the "needs you" answer has no label; "2 figures need you: cover level, depth" should read "cover level or depth"; padlocks hard to tell apart; about 400 px empty below the steps at 1440. Item 90. Since 18 Nov, 10:39 pm.
3. **O-040 Refresh `DIRECTOR_SUMMARY.md` and the morning pack** (planning chat) for pass 9, pass 10 and item 85. Today it says docking is not proven and AutoCAD asks "Save changes?" (section 6 item 2), lists the LPD merge and text from DIMSCALE as "Not built" (section 5 item 2) while section 3 says both are built and run, gives brain 598 and bench 313 (now 651 and 351), and carries a 7:49 pm stamp over an 8:57 pm pass. Since 18 Nov.

### New N lines (continue after N-068)

1. **N-069 Speed regression: a pit move with its pipes took 121 ms cold and 111 warm** (pass 8; the join step read the office list 48,323 times). CLOSED: fixed in round 43 (f24a3c1), proven in pass 9, 54 ms cold and 45 warm, with a test that fails if it comes back (items 82, 84, 87).
2. **N-070 The night check CEPIT4 expected "not yet named (copy of P3)"** where D-262 gives P4: the check was stale, not the tool. CLOSED: corrected, passes in pass 9 (items 82, 87).
3. **N-071 The command-owner check CEWHOSE wrote only to the command line,** so a robot could not read it. CLOSED: writes `cewhose_latest.txt` since pass 9 (items 82, 87).
4. **N-072 The Pit window's sketch prints "CL Not known" where the sheet prints "CL TBC" (D-178).** Found (planning chat's note, item 90): a preview of sheet text must say TBC. For the build chat with O-039.
5. **N-073 A bent pipe's label: the text's start point AutoCAD reports (1563.8) is not the one the plan set (1657.5).** First caught by CEBEND1 in pass 10 (TREND line 10, 11:12 pm, newer than the board); most likely the text's justification. Found; fix next round.

### New U lines (continue after U-040)

1. **U-041 "Not known" reads exactly so, in grey, in the Pit, Pipe and Long section windows opened from AutoCAD; the sheet still prints TBC.** Built (item 87); no robot can judge it. Proof: a supervised look (NIGHT_TEST entry 43 item 3).
2. **U-042 Text heights at 1:20 and 1:50, and the DIMSCALE 0 notice, in real AutoCAD.** Proven on the pretend drawing only; a robot may not set DIMSCALE (rule 1.9), so the proof needs test copies that already carry DIMSCALE 20, 50 and 0, made or named by Tim. Source: NIGHT_TEST entry 41 item 2 and entry 42 item 9 (not on the board as an ask; whether it becomes a W is the planning chat's call).

### New K lines

None. Item 88's "not tonight" list (turning a pit, the live preview, anything typed at PIT, PP or CD) is an order of work, not a parking.

---

## 6. One clean "Waiting on Tim" list, in asking order (merged with `MORNING_19NOV.md`, nothing twice)

### Batch 1: safety and his PC

1. **W-057** Retire the old desk robot. One click.
2. **W-053** His "q" alias: put back or leave removed. One click.

### Batch 2: the look

3. **W-051** Preview A, B or C (C docks, no save prompt; three leftovers). One click.
4. **W-055** Pipe labels in tight spaces. One click.
5. **W-049** The "_pedit, *Cancel*" line on double-click. One click.

### Batch 3: engineering

6. **W-056** Detention pipe cover under a driveway (D-145 against D-287). One click.
7. **W-058** How the end of a system is drawn. One click.
8. **W-061** The 3,500 L tank outline. One click.
9. **W-062** Every rectangular tank "Slimline"? One click.
10. **W-052** PT opening at 450 x 450 against last used. One click.

### Batch 4: smaller, when convenient

11. **W-050** A schedule depth worked from a level below 0.00, marked on the sheet? One click.
12. **W-054** One re-use figure, two tanks. One click.
13. **W-046** Existing civil text when DIMSCALE changes. One click.
14. **W-060** Plain names for the two detention methods. One click.
15. **W-048** The 10 layer questions. One click each.

### At the PC, one supervised sitting

16. **W-059** The typed EXPLODE check.
17. **W-063** Typing PIT, PP and CD with both plug-ins loaded.
18. **W-066** Ctrl grip-copy, typed COPY and a real PASTE with his mouse.

### Documents and small settings (MORNING item 15)

19. **W-002** Council minimum runoff: documents for two councils, one click for Darebin.
20. **W-047** Legend wording for joints and hatches; AJ layer name and colour.
21. **W-045** Default pen for each text size.

### New since the morning pack

22. **W-064** Three window calls on the approved style.
23. **W-065** Click budgets per window.

### Needed before a named tool

24. **W-004** Inspection opening spacing (AS 3500.3). Document.
25. **W-008** Which inlet symbols. One click.
26. **W-009** How FO and OF are drawn. Document.
27. **W-010** Top water level; orifice pit always last before the council connection. One click each.
28. **W-012** Pipe capacity on bigger jobs.
29. **W-014** Boyd's or OSD4W confirmation and OSD4W inputs. Document.
30. **W-015** Detention pipe pen width, legend wording, colour 160 on a real plot. At the PC.
31. **W-017** Form of cover-level help. One click.
32. **W-018** Move his Bl alias so BL is BREAKLINE. At the PC.
33. **W-019** Typed names still to pick. One click per batch.
34. **W-020** Base scales for the hatch tool. One click.
35. **W-022** Buttons on the three ribbon tabs. One click per tab.
36. **W-024** An office layer already in the drawing with another colour. One click.
37. **W-025** A night session with old and new plug-ins together. One click.
38. **W-039** Side panel (D-048) against a Job window (D-099, D-171). One click.
39. **W-043** How our facts show for a selected object, after the night proof. One click.
40. **W-044** The CN time limit on a big job. One click.

### Can wait

41. **W-027** Numbering option offered first after issue.
42. **W-028** Laptop screen sizes.
43. **W-029** Monash step irons wording.
44. **W-030** Freeze the old bug list.
45. **W-032** Hatch fault checks.
46. **W-033** Leftovers of the first trial run (ZeroTrial profile, isolate folder; his to do).
47. **W-034** Disk clean-up leftovers.
48. **W-035** Client details in local study copies.
49. **W-036** Questions for the later kinds.
50. **W-037** Where the no-plug-in drawing is.
51. **W-038** Which real job to carry through.

**End of the list: 51 open.**

---

## 7. Contradictions found while checking (for the planning chat)

1. **"Proven in AutoCAD" for bench fixes.** Board item 72 says round 39 and the risk list N-039 to N-056 "are now proven in AutoCAD apart from two failures", and the draft's closed list says "proven in pass 7". The night checks (CETEST, CEPIT, CEPIPE, CELEV, CESPEED, CEFACTS1, CECOPY, CEWHOSE, CEBEND) never open the Detention, Tank, Inlet or Schedule windows. Bench-proven only (corrections 35, 36).
2. **D-260 cites D-191 for "an existing layer is never changed";** D-191 as recorded says drafters start from the office template.
3. **Invert text.** Board item 78 lists "invert text 1.8 mm on 20TEXT" as built in batch A; NIGHT_TEST entry 41 item 4 says nothing draws invert text yet.
4. **The 3,500 L tank.** D-282 says the office 3,500 L slimline block is 2.25 long; item 84 says the office master holds no tank block and the civil template's is 890 x 2400; the old jobs measured 2250 x 650.
5. **`DIRECTOR_SUMMARY.md` contradicts itself and the board** (O-040).
6. **BUILD_LOG morning note** says "Nine AutoCAD test passes yesterday (4:50 am to 8:57 pm)"; TREND's first pass is 12:16 pm, pass 6 ran no checks, and pass 10 (bends) ran at 11:12 pm after the note said bends' check "is the next pass". The NIGHT_TEST section headers still say "Not run in AutoCAD" for checks run in ten passes.
7. **Draft U-012 says PP is free;** TREND pass 4 says PP is the old plug-in's command.
8. **Draft U-039 says the next pass reads SH;** TREND pass 3 already read it.
9. **The obstacle line OC-06.5** ("never a hidden remembered one") against D-263 (pits, inlets and tanks open with last used, kept in a CE file, with a setting). Not resolved here.

---

## 8. What this check did not do

1. Did not open `BOARD.md` sections 1 to 11 line by line beyond their ID lists, nor `rulings\` beyond two INDEX lines, `OPEN_QUESTIONS.md`, `IDEAS.md`, `PARKING_LOT.md` or the interview specs.
2. Did not check whether the 23 rulings fixes (O-002) were applied, or the state of O-009, O-015, O-016.
3. Did not open any AutoCAD result file except pass 10's summary lines, and did not run, build or commit anything.
