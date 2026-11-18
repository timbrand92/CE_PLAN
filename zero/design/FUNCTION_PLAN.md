# Function plan (revision 1): a plan for every function the office has today

**Written:** Wed 18 Nov 2026 (Melbourne time), by a read-only planning helper for the planning chat 'CE_ACAD / zero plan / 01'. Owed under D-220.
**Status: DRAFT for Tim to correct in one sitting.** Nothing here is a decision until Tim's word is filed in `DECISIONS.md`. Nothing was built, run, installed or committed; AutoCAD was not started; no git repository was changed.
**IDs:** FP-001 onward, never reused or renumbered; a later revision adds new numbers at the end. FM- numbers are `design\FUNCTION_MAP.md`; D- numbers are `DECISIONS.md`; E-, S-, L-, K- numbers are the reference library; SP- and OC- numbers are `stage6\OBSTACLE_COURSE.md`; ST- and MG- are `design\TOOLS_AND_MANAGER_INTERVIEW.md`; TA- are `interview_tools\ANSWERS.md`.
**The tick sheet** for marking this up fast is `design\FUNCTION_PLAN_TICK_SHEET.md`.

**What was read:** the whole function map; every decision D-001 to D-223; THE_PLAN, OBSTACLE_COURSE, PERFORMANCE, LOOPS, FOUNDATION, UI_PLAN, INPUT_AUDIT, SITUATIONS, the tools interview and its answers, the parts-bin report; the reference library (job kinds, sums, limits, elements, tables and boxes, title block and issue, the job flow, R-008). Where a purpose was unclear I read the old code: the Civil command registry at commit 2c8b7b1a and the loose LISP files in the shared drafting `Lisp Files` folder (read only).

---

## 1. The short answer for Tim

1. **77 lines planned (FP-001 to FP-077), every one of the 37 "not decided" lines, every "would be lost" item and every "proposed to retire" line.** 33 go into a first-release tool; 3 become small tools of their own (the ones you ruled today: LPD, trench grate, AG drains); 3 become blocks on the Blocks palette; 10 come after the first release, each with a named way to do the job until then; 3 stay outside CE exactly as they are; 25 retire, each with what replaces it (3 already ruled by you). **5 need your answer**; the other 72 follow from your own decisions.
2. **Civil, 12 tools:** PIT (PT), PIPE (CD), LONGSECTION (LG), the six inlets on one window (DP, OF, FO, IO, GIO, FW), TANK (WT), DETENTION (DET), SCHEDULE (SH), Outlet, the Job window, LEGALPOINT (LPD), TRENCHGRATE (TG), AGDRAIN (AG). Under them: the self-check on open and one Unfinished list.
3. **Shared, 18 tools:** CLEAN, dimensions and leaders, MR and CR, CPB, Divide, OFFICEHATCH, REVBOX, BREAKLINE, CJ and SSC, the Blocks palette, Text 25/18 with the TEXT window, pen quick-set, xref copy and paste, put on office layer, viewport scale, find and replace, area and length labels, small office symbols. **Manager, 1:** updates, fault report (with an Open logs button), office lists, job link, one admin page. **31 tools in all**, against 28 on yesterday's list.
4. **Palette blocks that carry jobs:** the legend with the new detention line, notes blocks, warning boxes, standard details, the fall arrow, the spot level, the overland flow arrow and the APPROX. standing note.
5. **What this plan honestly adds** to yesterday's list: the 3 small tools you ruled today, and about 20 additions inside tools already on the list (most are one line in a list or one more kind; five are real work).
6. **The three biggest additions, and why they cannot wait:** (1) **the computations PDF from Detention**: every detention job sends it to council, and the only other route is the old plug-in, whose storage can come out 17% short on a Glen Eira site while saying it is safe (R-008); (2) **the long section drawn on the sheet from LONGSECTION**: when a council asks, the job cannot be approved without it, and by hand it is about 300 lines of retyped levels; (3) **the pump well sums and box for the pump pit** you ticked for day one (D-104): a basement job cannot be lodged without the pump box, and the old pump sizing uses the same faulty rainfall curve.
7. **The walk-through:** 49 of 96 steps were covered before this plan; 96 of 96 are covered after it (91 by a first-release tool, palette block or AutoCAD's own command; 5 by a hand method this plan names).
8. **Size:** my rough estimate is that the first release is now about three times the seven-tool list; this plan adds about 40% to yesterday's list (about a sixth of that is your own rulings today).

---

## 2. The job walk-through

**How to read it.** Three made-up jobs, each walked from a blank drawing to a sheet set that can go to council. Each line says what is drawn, worked out or printed, then the tool that does it. "NOT COVERED before" means yesterday's list (THE_PLAN with the 18 Nov changes, before D-221 to D-223) had no tool and no named way to do it; the FP- line says what covers it now. "Covered" also counts AutoCAD's own commands and a hand method written in the plan.

### Job 1: a single house, no detention (like K-001)

The council letter says "single unit development", no permitted discharge. Connection to the existing council pit in the nature strip. A 3,000 litre reuse tank.

1. **Start the drawing from the office template:** by hand, as today (D-191). Covered.
2. **Attach the architect's and surveyor's plans and clean the background** (move the architect's linework onto the office A- layers, xrefs on the office layer): put on office layer (ST-14) and CLEAN (ST-01). Covered; FP-017 writes the background layers into the list.
3. **Job facts** (council, discharge kind): the Job window. Covered.
4. **Pits P1 to P3,** cover levels TBC until the engineer sets them (D-178): PIT. Covered.
5. **100 dia. pipes at 1 in 100,** labels and arrows: PIPE. Covered.
6. **Downpipes DP1 to DP8:** DOWNPIPE. Covered.
7. **Inspection openings at the bends:** INSPECTION. Covered.
8. **Charged line from the downpipes to the tank with "100 DIA. RISER TO WATER TANK" and the dropper label:** PIPE (charged) covered; the riser and dropper NOT COVERED before. Now FP-009 (TANK).
9. **The 3,000 litre tank, its note and leader:** TANK. Covered.
10. **Roof catchment area to the tank** (the only number worked on a plain house, CIV-01), the roof hatch and the area box: hatch covered by OFFICEHATCH; the area and the box NOT COVERED before. Now FP-012 (TANK).
11. **The existing council pit as the outlet:** Outlet (D-190). Covered.
12. **The legal point of discharge and the note "CONNECT TO COUNCIL PIT AT APPROX IL 1.14 TO COUNCIL SATISFACTION, BUILDER TO CONFIRM":** NOT COVERED before. Now FP-002 (LEGALPOINT, your D-222).
13. **Inverts worked back from the connection:** LONGSECTION. Covered.
14. **Existing council drains labelled "depth to be confirmed":** by hand (D-190). Covered.
15. **Driveway and building hatches:** OFFICEHATCH. Covered.
16. **Saw cuts and construction joints in the driveway:** SAWCUT and CONSTRUCTIONJOINT. Covered.
17. **Spot levels and fall arrows on the paving:** NOT COVERED before. Now FP-028 and FP-029 (Blocks palette).
18. **Overland flow arrow and the 1 in 100 storm note:** Blocks palette. Covered.
19. **Pit schedule with its three standing notes:** SCHEDULE. Covered.
20. **Legend, warning boxes, general and council notes, disclaimer, before-you-dig block:** Blocks palette. Covered.
21. **Junction pit, pipe bedding and tank installation details:** Blocks palette (the details library). Covered.
22. **The APPROX. standing note** (the connection invert is assumed, D-177): the rule is ruled, the note is NOT COVERED before. Now FP-015 (palette block; wording is ASK-1).
23. **Title block, revision row P1 then Rev A, issue stamp:** NOT COVERED before (title block and issue is out of the first release, D-097, with nothing said about what the drafter does). Now FP-016 (by hand as today, named).
24. **Unfinished list before issue, then CLEAN to save:** the Unfinished list and CLEAN. Covered.
25. **Plot to PDF:** AutoCAD's own Plot, with one quiet line about open items (D-188). Covered.

**Job 1: 19 of 25 steps covered before this plan; 25 of 25 after (24 by a tool, palette block or AutoCAD command, 1 by the named hand method for the title block).**

### Job 2: two units with detention (like K-003 and K-004)

Council gives the method (Boyd's); site rainfall from the Bureau. Storage in two tanks, a 225 detention pipe and the orifice pit. A trench grate at one garage door, an AG drain behind a retaining wall, a 1 m2 raingarden for the STORM report.

1. **Template:** by hand (D-191). Covered.
2. **Backgrounds:** put on office layer and CLEAN. Covered.
3. **Job window:** council, method, site and impervious areas picked off the drawing (D-107). Covered.
4. **The site's rainfall table:** the Job window holds it, but how it gets in was an open question (INPUT_AUDIT question 5): NOT COVERED before. Now FP-007 (Job window; ASK-2).
5. **Permitted discharge and volume required by Boyd's:** DETENTION. Covered.
6. **Pits, including the orifice pit P1 and a grated pit:** PIT. Covered.
7. **The 225 detention pipe at 1 in 200, in its own blue:** PIPE (detention). Covered.
8. **Gravity pipes and labels:** PIPE. Covered.
9. **Downpipes, charged lines to two tanks, riser and dropper labels:** riser and dropper NOT COVERED before. Now FP-009.
10. **Two 3,000 litre tanks with the split worked out (D-100):** TANK. Covered.
11. **Roof area to each tank box and roof hatch legend:** NOT COVERED before. Now FP-012.
12. **Trench grate across a garage door:** NOT COVERED before. Now FP-003 (TRENCHGRATE, your D-223).
13. **AG drain behind the retaining wall into P2, tagged AGI1, no inverts:** NOT COVERED before. Now FP-004 (AGDRAIN, your D-223).
14. **A floor waste and a GIO in the courtyard:** FLOORWASTE and GIO. Covered.
15. **Raingarden: outline, raingarden hatch, area note, its GIO and its detail:** NOT COVERED before. Now FP-022 (OFFICEHATCH, area label, GIO, palette detail).
16. **Kerb outlet, legal point of discharge label and connection note:** Outlet covered; LPD NOT COVERED before. Now FP-002.
17. **Levels from the connection back up the run:** LONGSECTION. Covered.
18. **Top water level kept below every grate and 300 below the floors (L-011):** the box is in Detention; the limits it must stay under NOT COVERED before. Now FP-008.
19. **Orifice size rounded down, plate height and head worked out (D-172, D-173):** DETENTION. Covered.
20. **Criteria box:** DETENTION (D-099). Covered.
21. **Orifice pit detail with this job's levels:** NOT COVERED before. Now FP-010 (DETENTION; ASK-4).
22. **Tank detail with litres, split and the 30 mm orifice:** NOT COVERED before. Now FP-011 (TANK).
23. **Pit schedule with the council pit row:** SCHEDULE (D-110). Covered.
24. **Driveway hatch, saw cuts, fall arrows and spot levels:** hatch and joints covered; falls and levels NOT COVERED before. Now FP-028, FP-029.
25. **Legend with the new detention pipe line (D-083):** NOT COVERED before (nobody owned the legend change). Now FP-015.
26. **Notes, warning boxes, standard details:** Blocks palette. Covered.
27. **APPROX. standing note:** NOT COVERED before. Now FP-015.
28. **P3 erased during design, then put back with Undo:** NOT COVERED before (PITDELETE undecided). Now FP-005 (PIT, your D-221).
29. **Title block and issue, P1 then Rev A:** NOT COVERED before. Now FP-016.
30. **Computations PDF for council (required storage, storage provided, orifice):** NOT COVERED before. Now FP-001 (DETENTION).
31. **Unfinished list, CLEAN, plot:** covered.

**Job 2: 15 of 31 steps covered before this plan; 31 of 31 after (30 by a tool, palette block or AutoCAD command, 1 by the named hand method for the title block).**

### Job 3: four townhouses on a long driveway, with a basement garage under the rear unit (like K-004, K-005, K-007 and K-012)

OSD4W council. Two systems: the front three units drain by gravity down the long driveway to the kerb; the basement drains to a pump well whose rising main lifts to a receiving pit. Storage in twin 225 pipes, a 300 pipe, pits and four tanks. At Rev B the council asks for a long section of the driveway run.

1. **Template:** by hand. Covered.
2. **Backgrounds:** put on office layer and CLEAN. Covered.
3. **Job window with the OSD4W settings and areas:** covered.
4. **The site's rainfall table:** NOT COVERED before. Now FP-007.
5. **OSD4W permitted discharge and storage:** DETENTION (D-098). Covered.
6. **Two systems, each from its own outlet, numbered street system first (D-183):** how the plug-in knows which pipe is in which system NOT COVERED before. Now FP-019.
7. **Pits along the driveway and the orifice pit:** PIT. Covered.
8. **The long driveway run with bends and IO offers:** PIPE (D-189, D-081). Covered.
9. **P5 to P4 clicked the wrong way round while designing:** NOT COVERED before. Now FP-018.
10. **Twin 225 and a 300 detention pipe:** PIPE (D-082). Covered.
11. **16 downpipes, charged lines to four tanks, risers and droppers:** risers and droppers NOT COVERED before. Now FP-009.
12. **Four tanks with their splits; roof area box:** tanks covered; roof box NOT COVERED before. Now FP-012.
13. **Check where every downpipe ends up before issue:** NOT COVERED before. Now FP-020.
14. **Trench grate across the top of the basement ramp:** NOT COVERED before. Now FP-003.
15. **Floor wastes on the basement slab:** FLOORWASTE. Covered.
16. **Strip drains on the basement slab:** NOT COVERED before (you parked the strip drain today, D-223). Now FP-027 (after the first release; drawn by hand meanwhile, named).
17. **The pump well:** PIT (pump kind, D-104). Covered.
18. **Wet well volume, pump level stack, pump specification box, pump station detail:** NOT COVERED before. Now FP-013 (PIT pump kind; ASK-3).
19. **Rising main from the pump to the receiving pit:** NOT COVERED before. Now FP-014 (PIPE, one more kind).
20. **Perimeter drain round the basement wall:** NOT COVERED before. Now FP-004.
21. **Kerb outlet and the LPD label:** Outlet covered; LPD NOT COVERED before. Now FP-002.
22. **Levels from the outlet up the long run:** LONGSECTION. Covered.
23. **Long section drawn on the sheet at Rev B:** NOT COVERED before. Now FP-006 (LONGSECTION).
24. **Top water level limits:** NOT COVERED before. Now FP-008.
25. **Criteria box:** covered.
26. **Orifice pit detail:** NOT COVERED before. Now FP-010.
27. **Tank details:** NOT COVERED before. Now FP-011.
28. **Pit schedule of 20-odd rows with the council pit and pump well rows:** SCHEDULE (D-110, D-114). Covered.
29. **Driveway concrete hatch, saw cuts, construction joints, and one joint changed from CJ to saw cut when the engineer says:** hatch and joints covered; the swap NOT COVERED before. Now FP-042.
30. **Driveway falls, spot levels and the driveway grade written as "1:12 8.3%":** NOT COVERED before. Now FP-028, FP-029 (grade text by the TEXT window, FP-030).
31. **Spoon drain along the driveway edge into a grated pit:** NOT COVERED before. Now FP-032 (after the first release; drawn by hand meanwhile, named).
32. **Kerb line at the crossover:** NOT COVERED before. Now FP-033 (put on office layer).
33. **Street tree protection zone circle and hatch:** NOT COVERED before. Now FP-035 (put on office layer and OFFICEHATCH).
34. **Legend with the detention line:** NOT COVERED before. Now FP-015.
35. **Notes, warning boxes, pump notes, standard details:** Blocks palette. Covered.
36. **APPROX. standing note:** NOT COVERED before. Now FP-015.
37. **Title block and issue: P1, Rev A, Rev B:** NOT COVERED before. Now FP-016.
38. **Revision cloud round what changed at Rev B:** REVBOX. Covered (the "changed since last issue" list is later, D-187).
39. **Computations PDF:** NOT COVERED before. Now FP-001.
40. **Unfinished list, CLEAN, plot:** covered.

**Job 3: 15 of 40 steps covered before this plan; 40 of 40 after (37 by a tool, palette block or AutoCAD command; 3 by named hand methods: title block, strip drain, spoon drain).**

### Totals

**49 of 96 steps covered before this plan; 96 of 96 after.** 91 by a first-release tool, a palette block or AutoCAD's own command; 5 by a hand method this plan names (title block and issue on all three jobs; strip drain and spoon drain on job 3).

---

## 3. The few things only Tim can answer

Everything else in this plan follows from your own decisions. These five turn on a fact about office practice that is not written down anywhere I could read.

1. **ASK-1 (FP-015): the wording of the APPROX. standing note.**
   - **Context:** you ruled that an assumed figure prints "APPROX. IL 4.95" and one standing note on the sheet explains it (D-177). The note's words were never given, and the council notes today only say the discharge invert is assumed.
   - **Real example:** a two-unit job issued at P1 before the council letter arrives: the connection invert and two cover levels print APPROX., and the note sits under the general notes.
   - **My recommended answer:** "LEVELS MARKED APPROX. ARE ASSUMED AND ARE TO BE CONFIRMED ON SITE BY THE BUILDER PRIOR TO THE COMMENCEMENT OF WORK. NOTIFY THE ENGINEER OF ANY DIFFERENCE." It goes on the palette as a notes block, and the Unfinished list reminds you to place it when anything prints APPROX.
2. **ASK-2 (FP-007): how a site's rainfall table reaches you today.**
   - **Context:** the Job window holds one rainfall table per job, and you may type your own estimate (D-218); the plug-in never supplies a curve (that is the fault R-008 found). How the office gets the site's figures is not recorded (INPUT_AUDIT question 5).
   - **Real example:** a Glen Eira two-unit job: you need the 1 in 10 year figures for 5 to 30 minutes and the 1 in 5 year, 5 minute figure for the permitted discharge.
   - **My recommended answer:** you copy the table from the Bureau's rainfall (IFD) page for the site and paste it into the Job window, which keeps the rows it needs and shows them with "given: Bureau, pasted 18 Nov". Typing the six or seven figures by hand also works.
3. **ASK-3 (FP-013): how the pump well's levels are set.**
   - **Context:** the office pump workbooks disagree (Q-003): one takes the static rise from the inlet invert and one from the top working level; one puts the bottom 400 below "all pumps stop" and one 300; a "small pumps" tab lets the wet well go under the standard's 3 m3.
   - **Real example:** a basement garage well 1,500 dia. with the inlet at 28.46 and the rising main discharging at 31.60: the static rise is 3.14 measured from the inlet, or 3.24 from a top working level 100 lower.
   - **My recommended answer:** do it as the newest office pump sums do (CIV-12): static rise from the inlet invert, bottom 400 below all pumps stop, wet well never below 3 m3 unless you type it over (shown amber "Needs a look").
4. **ASK-4 (FP-010): the orifice pit detail each council gets.**
   - **Context:** the details library holds about 26 worked orifice pit details for 8 councils, each pasted from an old job with the numbers retyped inside the block. What really differs between councils (pit shape, baffle, plate, or only the standing line and the council's standard drawing number) is not recorded (E-047 item 10).
   - **Real example:** a Kingston job and a Monash job: if the pit is the same and only the line "REFER ALSO TO COUNCIL STANDARD DRAWING ..." changes, one office detail serves both.
   - **My recommended answer:** one office orifice pit detail whose figures Detention fills in, with the council line taken from the council in the Job window; a council whose pit is truly a different shape gets its own detail. The library detail is set up on a copy first, as you allowed for the master blocks (TA-038).
5. **ASK-5 (FP-053, FP-054): your WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial and ET aliases, and the old TB2024 menu.**
   - **Context:** the commands those aliases run (Wall-l, Wall-t, mltim, Grabcopy, Dimsmallauto and the rest) are not in the shared LISP folder, the AutoCAD folders or any CE code. Purpose not found. They may belong to the bought-in structural toolkit the TB2024 menu calls.
   - **Real example:** typing WT today runs "Wall-t"; under D-170 the Tank tool is WT, so your WT alias has to move.
   - **My recommended answer:** leave them and the toolkit exactly as they are, outside CE; nothing is built for them. Tell me only if one of them is something CE should do.

---

## 4. What this does to the build order

**The rules that set the order:** one tool at a time, each finished before the next (D-091); nothing new while a ribbon tool is broken (D-090); the shared parts and the obstacle course are the gate every tool goes through (D-213, D-216); CLEAN first among the shared tools (D-201); all 18 shared tools and the Manager tested before release (D-214).

1. **The shared parts and the obstacle course first** (SP-01 to SP-22, OC-01 to OC-27). Three of them matter more after this plan: SP-02 units and scale (every new drawn thing), SP-05 label placing (LPD, trench grate, AG drain, tank and orifice details all place text), and SP-16 logging (the Manager's records and Open logs button, FP-047, FP-048).
2. **CLEAN** (D-201). Its own step first: measure what today's CLEAN does, step by step, on a real-size copy (ST-01). FP-043 adds the XRL ticks.
3. **The Blocks palette.** Brought forward because this plan leans on it: the legend with the detention line, the notes, the APPROX. note, the details, the fall arrow and the spot level (FP-015, FP-028, FP-029) are what every sheet needs, and the details library set-up for ASK-4 happens here.
4. **PIT** with the plain-ERASE behaviour (FP-005). The pump kind is drawn here; its sums wait until step 13.
5. **PIPE** with every kind, the rising main (FP-014) and "Turn round" (FP-018).
6. **Outlet, then LEGALPOINT.** Each outlet starts its own system (FP-019); the LPD label reads the outlet's invert (FP-002).
7. **The six inlets** with the "other inlet" kind (FP-021) and where each one ends up (FP-020).
8. **TRENCHGRATE and AGDRAIN.** Both use PIPE's wide window style, so they come straight after the inlets (FP-003, FP-004).
9. **SCHEDULE.** Now every kind of row exists (pits, inlets, trench grates, AG drains, council pit, pump well).
10. **LONGSECTION:** the window first, then "draw on the sheet" (FP-006). OC-12 is already written for it.
11. **TANK** with the riser and dropper, the roof area box and the tank detail (FP-009, FP-011, FP-012).
12. **The Job window** with the rainfall table (FP-007).
13. **DETENTION** with the criteria box, the top water level limits, the orifice pit detail and the computations PDF (FP-008, FP-010, FP-001). OC-24 (the two wrong-figure cases) is its hardest test. Then **the pump well sums and box** (FP-013), which reuse the Job window's rainfall and areas.
14. **The other shared tools,** easiest and most-used first: put on office layer (with the kerb, tree zone and background layers, FP-017, FP-033, FP-035), dimensions and leaders (FP-039), the TEXT window, MR and CR, CPB, Divide (FP-040), REVBOX, BREAKLINE, joints (FP-042, FP-044), OFFICEHATCH last of these because your hatch list is still being ticked (FP-041, FP-045), then pen quick-set, xref copy and paste, viewport scale, find and replace, area and length labels.
15. **The Manager** (updates and roll-back, fault report with Open logs, records, office lists, job link, admin page). The fault-report logging part is built in step 1 as SP-16; the updates part must be proven before any colleague install.
16. **One real job** (a house or two-unit job, coded name) from blank drawing to council set, then colleagues.

**Why this order:** the riskiest civil work (joins, levels, the sums) is proven early; every tool lands after the tools whose facts it reads (the schedule after the inlets; Detention after Tank and the Job window; the pump after Detention); and the palette comes early because the sheet furniture of every job depends on it.

**How much bigger (my estimate, not measured; no dates):**
1. **The seven-tool list** (Pit, Pipe, Long section, Inlets, Tank, Detention, Schedule): call it 1.
2. **Yesterday's list** (plus Outlet, the Job window, the 18 shared tools and the Manager): about 2.2. Many shared tools already work (TA-043), so this is the softest figure.
3. **After this plan:** about 3. The 3 small tools you ruled today are about a sixth of what this plan adds; the five real pieces of work (computations PDF, long section on the sheet, pump well, orifice pit detail, tank detail) are about half; the rest is about 15 small additions, each a line in a list or one more kind.
4. **What does not change:** the gate, the order of the first seven civil tools, and the rule that colleagues get nothing until all of it is tested (D-214).

---

## 5. The plan, line by line

**How each entry reads:** what it is today; the proposal (exactly one of: first release as part of a named tool; first release as its own small tool; first release as a palette block; after the first release, with what the drafter does meanwhile; kept outside CE side by side; retire, with what replaces it); why; a real example; the cost (small: a line in a list; medium: a new kind of an existing thing or a new card; large: a new window, a new kind of drawn table or a new tool); and whether your decisions settle it ("sure") or it needs you ("ASK").
**Cross-references for the "would be lost" list B** (where one FP covers several items): B1 FP-031; B2 FP-001; B3 FP-002; B4 FP-003, FP-021, FP-022; B5 FP-004, FP-027; B6 FP-030, FP-032, FP-033, FP-034, FP-035; B7 FP-028, FP-029; B8 FP-005; B9 FP-018, FP-019; B10 FP-020; B11 FP-036; B12 FP-039; B13 FP-041; B14 FP-042; B15 FP-040, FP-055, FP-057, FP-058; B16 FP-023; B17 FP-046; B18 FP-049; B19 FP-048; B20 FP-047.

### 5.1 Needed to finish a job

**FP-001. The computations sheet (CDCALC)**
1. **What it is today:** CDCALC, the calculations suite (Boyd's, orifice, detention, charged line and pump tabs), which also makes the computations sheet as PDF or Excel (FM-047; no recorded runs; lost list B2).
2. **Proposal:** FIRST RELEASE as part of DETENTION (DET): a "Computations" button prints the council PDF from the window's own figures: basis of design and where each figure came from (including the rainfall source, APPROX. when it is your estimate, D-218); volume required (Boyd's sum, or the OSD4W or council figure as given); storage provided item by item (each pipe by size and length, each ticked pit, each tank share); the orifice sum; then the total against the volume required. A4 pages on the office computation sheet header (E-048). Excel is not carried. The other CDCALC tabs are covered elsewhere: orifice and Boyd's in Detention, pump in FP-013; the charged line head check (S-018) waits for its office figures (formula not in the evidence).
3. **Why:** every detention job lodges it (K-002 to K-006); the sums are already in Detention (D-095, D-099) and you ruled the sheet prints from the same numbers (D-021). Until it exists the office would type the figures again into the Word document, which D-003 does not allow, or use the old CDCALC, which brings the old plug-in back beside the new one (CD clash, SITUATIONS I4) and the rainfall fault (R-008).
4. **Real example:** CIV-02: page 1 required 1.49 m3 by Boyd's; page 2 the 9 m of 225 pipe 0.36, P1 0.11, P2 0.05, tank 1.00, total 1.52; page 3 orifice 67 mm. Today a Word file of pasted spreadsheet pictures.
5. **Cost:** medium to large (a new printed output; the sheet layout logic in the old plug-in is pure and can be re-checked and taken like the sums, D-095).
6. **Sure or ask:** sure (D-021, D-095, D-220). Until Detention is accepted the office keeps today's workbook and Word route; never an old CDDESIGN storage figure without the site's rainfall (R-008).

**FP-002. The legal point of discharge (CDLPD)**
1. **What it is today:** CDLPD picks the connection kind, the pipe end and where the label sits (FM-018; 5 runs; lost list B3).
2. **Proposal:** FIRST RELEASE as its own small tool, **LEGALPOINT / LPD** (LPD is free in acad.pgp and in your alias list). Pick the point on the last pipe where the property drain becomes council's; it places the LPD tag and the connection note in the office wording for that discharge kind (kerb, council pit, easement drain), with the invert worked out at that point and printed APPROX. while assumed (D-177).
3. **Why:** you ruled it is its own small tool (D-222); every job has a connection note (E-058) and it is the figure most often assumed (D-030).
4. **Real example:** "CONNECT TO COUNCIL PIT AT APPROX IL 1.14 TO COUNCIL SATISFACTION, BUILDER TO CONFIRM" (CIV-01); when the council letter gives 1.08, you type it once and the note, the pipe label and the schedule follow.
5. **Cost:** medium (a new small tool on the square-preview window).
6. **Sure or ask:** sure (D-222).

**FP-003. Trench grate (CDTG, TG)**
1. **What it is today:** CDTG inserts a trench grate block and tags it; TG is its old alias (FM-032; TG 2 runs).
2. **Proposal:** FIRST RELEASE as its own small tool, **TRENCHGRATE / TG** (TG free in both lists). Wide-preview window (D-067): width, length and grate class, the office TRENCH GRATE stretch block on its layer, the cover level, and what it drains to (a pit or a pipe), shown as a "from TG1" row in the schedule.
3. **Why:** you put it in the first release today (D-223); garage doors and basement ramps carry one on most unit jobs.
4. **Real example:** a 300 wide trench with class C grate across the ramp top, 3.1 m long, draining to P4.
5. **Cost:** medium (a new small tool on PIPE's window style).
6. **Sure or ask:** sure (D-223).

**FP-004. Agricultural and perimeter drains (CDAGI, CDPERIMETER)**
1. **What it is today:** CDAGI and CDPERIMETER draw a drain line on the AGI DRAIN layer and tag it AGI1 or PD1 (FM-017; no recorded runs; lost list B5).
2. **Proposal:** FIRST RELEASE as its own small tool, **AGDRAIN / AG** (AG free in both lists), with two kinds in its window: agricultural drain and perimeter drain. Line-shaped, bends allowed, AG_LINE linetype, no invert levels (D-040), its end joins the pit or pipe it drains to and it shows as a "from AGI1" row in the schedule.
3. **Why:** you put both in the first release today (D-223); the bench schedule already has AGI inlet rows.
4. **Real example:** an AG drain behind a 900 high retaining wall, 14 m long, into P2, tagged AGI1, no invert text.
5. **Cost:** medium (a new small tool, one window, two kinds).
6. **Sure or ask:** sure (D-223).

**FP-005. Erasing a pit (PITDELETE)**
1. **What it is today:** PITDELETE deletes a pit with its tag and cover level text (FM-005; under 8 runs; lost list B8).
2. **Proposal:** FIRST RELEASE as part of PIT: no command. Plain ERASE of a pit takes its tag, cover text and schedule row with it; the two pipes stay and show "not joined yet"; one command-line line says so; one Undo brings everything back.
3. **Why:** you ruled exactly this (D-221).
4. **Real example:** P3 erased between P4 and P2 on a unit job: P4 to P3 and P3 to P2 stay as two loose pipes in grey until a new pit is dropped on them.
5. **Cost:** medium (part of the joins and following, SP-11).
6. **Sure or ask:** sure (D-221).

**FP-006. The long section drawn on the sheet (CDPROFILE)**
1. **What it is today:** CDPROFILE draws a long-section block from an upstream pit (FM-021; no recorded runs; lost list A1).
2. **Proposal:** FIRST RELEASE as part of LONGSECTION (LG): a "Draw on sheet" button places the long section as ordinary lines and text in the office layout (rows DATUM LEVEL, PIPE SIZE, PIPE GRADE, velocity and capacity, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE; 1:100 by 1:50 offered, any scale typed), and it then follows the run the way the schedule follows the pits.
3. **Why:** long sections are only drawn when the council asks (D-030), but when it asks the job cannot be approved without one; by hand it is about 300 loose lines and texts (E-062), every level retyped from the window, which D-003 does not allow. The obstacle for it already exists (OC-12).
4. **Real example:** at Rev B a council asks for the long section of the driveway run from P6 to the kerb: one click instead of an afternoon.
5. **Cost:** large (a new kind of drawn table that follows the run).
6. **Sure or ask:** sure (D-030, D-021). Built last inside LONGSECTION, after the window is accepted.

**FP-007. The site's rainfall (CDRAINFALL)**
1. **What it is today:** CDRAINFALL shows which curve the job is designed to and records the job's own coefficients from a text file or a paste (FM-050; no recorded runs; lost list A3).
2. **Proposal:** FIRST RELEASE as part of the Job window: one rainfall table per job, pasted from the Bureau's table or typed, each figure "given" with its source; or your own estimate, marked assumed and printed APPROX. until replaced (D-218). Until it is entered, storage reads "cannot work out yet: site rainfall not entered". The office curve is never used. The text-file import is not carried.
3. **Why:** D-218; R-008 found the old office curve 10 to 17% short on Glen Eira sites while saying it was safe.
4. **Real example:** a Glen Eira job: 112, 85.0, 69.4 mm/h at 5, 10 and 15 minutes, 1 in 10 year, pasted once; Detention, the computations PDF and the pump sums all read them.
5. **Cost:** small (one card in the Job window and a paste reader).
6. **Sure or ask:** ASK-2 (how the table reaches you today); the rest is sure.

**FP-008. The levels a detention system could be held to (CDTWL)**
1. **What it is today:** CDTWL works upstream from a detention outlet, lists every level the system could be held to and where each came from, then reports the storage (FM-023; no recorded runs; lost list A2).
2. **Proposal:** FIRST RELEASE as part of DETENTION: the top water level box shows the limits it must stay under, each with its source: the lowest grate or cover on the system and 300 below the lowest habitable floor (L-011). They are checks (amber, red), never a choice made for you. The full candidate list is not carried.
3. **Why:** the engineer sets the top water level (D-018, D-195: help is a suggestion); you did not answer how it is chosen and that is not re-asked (D-175).
4. **Real example:** a top water level of 5.20 typed: "Suits: 0.15 below the grate at P2 (5.35); 0.85 below FFL 6.35 less 300".
5. **Cost:** small (two checks on an existing box).
6. **Sure or ask:** sure (L-011, D-195).

**FP-009. Riser and dropper under the tank (CDWT's link)**
1. **What it is today:** CDWT tags a tank and links riser and dropper blocks under the same tag (FM-035; no recorded runs; lost list A4).
2. **Proposal:** FIRST RELEASE as part of TANK: where a charged pipe meets the tank, the office riser block and its label "100 DIA. RISER TO WATER TANK" go in, and the dropper and "100 DIA. DROPPER FROM WATER TANK" where the outlet leaves; they move with the tank and read the pipe's size.
3. **Why:** every tank job with a charged system shows them (E-064); typed once (D-002).
4. **Real example:** WT2 with a 100 charged line in and a 100 dropper to the orifice pit.
5. **Cost:** small (two parts of the tank, like its note and leader).
6. **Sure or ask:** sure (D-002, D-039).

**FP-010. The orifice pit detail with this job's figures (no old command)**
1. **What it is today:** no command. The detail is pasted from an old job and its cover, top water level, plate height, orifice size and inverts are retyped inside the block (E-047).
2. **Proposal:** FIRST RELEASE as part of DETENTION: the office orifice pit detail, placed from the palette, has its figures filled from the orifice pit and they follow when the design changes, like the criteria box.
3. **Why:** one fact in one place (D-171); on one issued job the control pit's inlet invert was typed five times (K-003).
4. **Real example:** the plate height changes from 380 to 390 at Rev C: the detail, the criteria box "HEAD" line (D-023) and the computations PDF change together.
5. **Cost:** medium (a detail block with fill-in figures, and the details library set up on a copy).
6. **Sure or ask:** ASK-4 (what differs between councils' details); the rest is sure.

**FP-011. The tank detail with this job's figures (no old command)**
1. **What it is today:** no command; the tank detail's litres, split and 30 mm orifice are typed inside the block (E-047).
2. **Proposal:** FIRST RELEASE as part of TANK: the office tank detail, placed from the palette, reads the tank's total, detention and reuse litres and its orifice.
3. **Why:** real jobs have had the tank split differ between plan and detail on the same stamped sheet (E-020).
4. **Real example:** a 3,000 litre tank with 1,100 litres for detention (CIV-04): plan note, detail and criteria box all say 1,100.
5. **Cost:** small to medium (same mechanism as FP-010).
6. **Sure or ask:** sure (D-002, D-171).

**FP-012. Roof area to each tank, and its box (no old command)**
1. **What it is today:** no command; the roof area is measured by hand and typed into a boxed note ("ROOF 1 DISCHARGE TO WATER TANK 1 = 164m2", E-021, E-061).
2. **Proposal:** FIRST RELEASE as part of TANK: roof area to the tank is one of the tank's facts, picked off a closed outline or a roof hatch (it stays linked, D-107) or typed; the box is a view of all tanks' roof areas, placed once.
3. **Why:** on a plain house it is the only number worked (K-001); the STORM report and some councils' lists need it.
4. **Real example:** two roofs of 164 m2, each hatched with OFFICEHATCH and picked: the box lists both and updates when the architect changes a roof.
5. **Cost:** small (a fact and a box view).
6. **Sure or ask:** sure (D-107, D-002).

**FP-013. The pump well sums, pump box and pump station detail (no old command; the old CDCALC pump tab)**
1. **What it is today:** pump sizing is a tab of CDCALC (and the office pump workbooks); the box and the level ladder are typed by hand (E-059, S-014, S-015).
2. **Proposal:** FIRST RELEASE as part of PIT, pump kind: the pit's window works out the wet well volume (the largest of the 2 hour storm less 30 minutes of pumping, 1% of the catchment, and 3 m3), the pump rate (equal to the permitted discharge, office practice), the level ladder and the static rise to the receiving pit; it places the "STORMWATER PUMP SYSTEM (SPS) SPECIFICATIONS" box and fills the pump station detail.
3. **Why:** you ticked the pump pit for day one (D-104); a basement job is not lodged without the box (CIV-07, CIV-12); the old pump sizing uses the same faulty office curve (R-008 D.4).
4. **Real example:** CIV-07: 472.2 m2 effective, 18.1 mm/h, pump 7.90 l/s, wet well 4.72 m3 (the 1% rule governs), static rise 0.67.
5. **Cost:** medium to large (new sums and two views on an existing pit kind).
6. **Sure or ask:** ASK-3 (which level rules); the rest is sure.

**FP-014. The rising main (no old command)**
1. **What it is today:** no command; drawn by hand on the master drawing's STORMWATER RISING MAIN layer, in green (E-059).
2. **Proposal:** FIRST RELEASE as part of PIPE: one more kind, "rising main", on its own layer, with no grade or cover sums (like a charged line, SITUATIONS B11), from the pump well to the receiving pit or kerb.
3. **Why:** every pump job has one; a kind is a line in a list (FOUNDATION test).
4. **Real example:** 18 m of 50 dia. rising main from the well to a receiving pit at 31.60.
5. **Cost:** small (one kind line).
6. **Sure or ask:** sure (D-104, FOUNDATION).

**FP-015. Sheet furniture on the palette: legend with the detention line, notes, warning boxes, standard details, the APPROX. note (no old command)**
1. **What it is today:** blocks dragged from the tool palettes; the legend block has no detention pipe line yet; the APPROX. note does not exist (E-037 to E-039, E-047).
2. **Proposal:** FIRST RELEASE as blocks on the Blocks palette: the CIVIL LEGEND block gains the detention pipe line (colour 160, DASHED, D-083, D-156); the notes blocks, warning boxes, council notes, before-you-dig and disclaimer; the standard details; and a new APPROX. standing note. The Unfinished list reminds you to place the APPROX. note when anything prints APPROX.
3. **Why:** every sheet carries them (K- common path); you asked for the legend line (D-083) and ruled the APPROX. note (D-177).
4. **Real example:** a two-unit job with a detention pipe: the legend shows the new blue line beside the ordinary pipe.
5. **Cost:** small (blocks in the master drawing and lines in the block list).
6. **Sure or ask:** ASK-1 (the APPROX. note's wording); the rest is sure.

**FP-016. Title block, revision rows and issue stamp (no old command)**
1. **What it is today:** edited by hand in the title block; revision rows copied up and retyped; stamp layers frozen and thawed (E-043 to E-046).
2. **Proposal:** AFTER THE FIRST RELEASE, in the title block and issue group (with the new-drawing tool, FP-037, and "changed since last issue", D-187). Until then the drafter does exactly what is done today.
3. **Why:** you did not tick title block and issue for the first release (D-097); today's way works and nothing in it is lost.
4. **Real example:** Rev A "FOR COUNCIL APPROVAL": copy the P1 row up, retype it, thaw 0-STAMP-APPROVAL, freeze 0-STAMP-PRELIMINARY.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-097).

**FP-017. Setting up the cleaned background (no old command)**
1. **What it is today:** by hand: paste the architect's plans, explode, move objects onto the office A- layers by kind, delete their dimensions and notes (job flow step 15).
2. **Proposal:** FIRST RELEASE as part of PUT ON OFFICE LAYER (ST-14): the office A- background layers are lines in its list, so "these lines are the architect's walls" is one pick; CLEAN puts the xrefs on the office xref layer.
3. **Why:** every job starts with it; ST-14 was ticked by you (D-209) and this only fills its list.
4. **Real example:** the architect's exploded ground floor: pick the walls, choose "A- building", done.
5. **Cost:** small (lines in a list).
6. **Sure or ask:** sure (D-209).

### 5.2 Civil drainage extras

**FP-018. Turning a pipe round (CDREVERSEFLOW, CDPIPEDIRECTION)**
1. **What it is today:** turn a pipe around, or correct a direction guessed from the click order (FM-013; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of PIPE: direction comes from the outlet. Until a run reaches an outlet it reads "as drawn, not settled"; when it does, arrows and inverts follow the real direction. Where both ends are pits with levels and a pipe is plainly backwards, one quiet line offers "Turn round".
3. **Why:** loose runs are normal (D-175, D-176); a quiet offer is your pattern for the IO (D-081).
4. **Real example:** you click P5 then P4 but the outlet is beyond P1: once the run joins the outlet the arrow turns and the inverts fall the right way.
5. **Cost:** small to medium (a rule in the joins).
6. **Sure or ask:** sure (D-176, D-081).

**FP-019. Which system a pipe belongs to (CDSYSTEM)**
1. **What it is today:** put picked pipes in a system by hand (FM-014; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of the Outlet tool: a system is everything that drains to one outlet, found from the joins, never typed; each outlet holds its own facts; the system strip and the Unfinished list name it ("rear system, to easement").
3. **Why:** each system is numbered from its own outlet (D-183).
4. **Real example:** front units to the kerb (P1 to P5), basement to the pump well then the receiving pit (P6 onward).
5. **Cost:** small (follows from the joins).
6. **Sure or ask:** sure (D-183).

**FP-020. Where each downpipe ends up (CDDEST)**
1. **What it is today:** follow the pipes and say where each downpipe ends up and where the trail stops (FM-038; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of the inlet window's system strip (D-167): each downpipe shows "to WT1, then the kerb", and any trail that stops short goes on the Unfinished list.
3. **Why:** checking nothing stops half way is part of the check before issue; D-167 already draws the strip.
4. **Real example:** DP7 drains to WT3, which overflows to P2: "DP7: WT3, then kerb"; DP9 stops at a loose pipe: listed.
5. **Cost:** small.
6. **Sure or ask:** sure (D-167, D-176).

**FP-021. Other inlet: roof drain, air-conditioner condensate (CDSOURCE)**
1. **What it is today:** CDSOURCE inserts a generic source block with a typed name, not in the pit schedule (FM-033; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of the inlet window: one more kind, "other inlet", with a typed tag; no typed name of its own (chosen in the window, D-058).
3. **Why:** a kind is a line in a list (FOUNDATION); nothing lost.
4. **Real example:** an AC condensate drain "AC1" connected to the charged line.
5. **Cost:** small (one kind line).
6. **Sure or ask:** sure (D-058, FOUNDATION).

**FP-022. Raingarden (CDRG)**
1. **What it is today:** CDRG draws a raingarden outline with a solid hatch and a GIO (FM-034; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of OFFICEHATCH: the raingarden hatch on HATCH 74 (as you kept it, TA-049), the live area label (ST-17), the GIO tool, and the raingarden section from the palette. Its own raingarden tool comes after the first release in the site group.
3. **Why:** some councils need one on an ordinary job (K-009); the shared tools already do every part of it.
4. **Real example:** "3.5m2 RAINGARDEN. MIN. 1m2 REQUIRED TO TREAT DRIVEWAY OF DWELLING 1" (CIV-08), with the area label updating as the outline is stretched.
5. **Cost:** small (one hatch choice).
6. **Sure or ask:** sure (TA-049, D-209).

**FP-023. Accepting a finding with a note (CDCHECKIGNORE)**
1. **What it is today:** hide one check finding with a reason, never switched on (FM-042; on the retire list; lost list B16).
2. **Proposal:** FIRST RELEASE as part of the Unfinished list: any amber or red finding can be accepted with a short note (survey, council requirement, engineer's judgement); it stays listed as "accepted: note", never hidden.
3. **Why:** you said disagreement may stand only with "a small note to justify" (D-003).
4. **Real example:** a 0.28 cover at a kerb connection the council told you to accept: "council letter 3 Apr" and it goes grey.
5. **Cost:** small.
6. **Sure or ask:** sure (D-003).

**FP-024. Taking up a block drawn by someone else (CDTAG's register part)**
1. **What it is today:** CDTAG tags and re-tags sources (64 runs) and registers foreign blocks (an AGI line, a council block, someone's tank block) as sources (FM-036; lost list A5).
2. **Proposal:** AFTER THE FIRST RELEASE, in the old-drawing take-up group (with FM-054, FM-180). Tagging and re-tagging is already covered (D-185). Until then the drafter places the office block with its tool beside or over the foreign one.
3. **Why:** taking up what others drew is the take-up group (D-027, D-192); a new job can always use the office blocks.
4. **Real example:** a council's own side entry pit block on an outfall plan: place the Outlet on it.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-027, D-192).

**FP-025. Find a pit by name (CEFIND)**
1. **What it is today:** type P7 or WT1 and CE zooms to it (FM-045; no recorded runs).
2. **Proposal:** AFTER THE FIRST RELEASE, in a drainage extras group. Until then the Unfinished list's jump-to, the system strip, or AutoCAD's own zoom.
3. **Why:** no recorded use; the Unfinished list covers most of the need.
4. **Real example:** a 14-pit job: zoom to P11 by eye from the schedule.
5. **Cost:** none now.
6. **Sure or ask:** sure.

**FP-026. Silt pit and soakage pit (part of PIT)**
1. **What it is today:** pit kinds the old tools offered; soakage grids drawn by hand (FM-001; lost list A6).
2. **Proposal:** AFTER THE FIRST RELEASE, in a soakage group (soakage pit, silt pit, the soakage balance S-016). Until then: a silt pit is placed as a junction pit with "SILT PIT IL ... CLASS B GRATE" typed into its schedule remarks (held, D-103); the module grid and details are drawn by hand and from the palette as today.
3. **Why:** you did not tick them for day one (D-104).
4. **Real example:** a soak-on-site house: 60 double modules (5 x 11) drawn as today.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-104).

**FP-027. Strip drain (CDSTRIP)**
1. **What it is today:** CDSTRIP draws a 100 mm strip drain with floor wastes at corners and every 12 m (FM-016; no recorded runs).
2. **Proposal:** AFTER THE FIRST RELEASE, in a site and basement group. Until then: draw the strip drain as a closed polyline and put it on the office strip drain layer (ST-14); place the floor wastes with FLOORWASTE; the label from the palette.
3. **Why:** you parked it today (D-223).
4. **Real example:** basement strip drains with floor wastes at each corner, drawn in a few minutes by hand.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-223).

### 5.3 Pavement and site

**FP-028. Fall arrow (CDFALL, CDFALLSUGGEST)**
1. **What it is today:** CDFALL inserts a fall symbol (4 runs); CDFALLSUGGEST points one at the nearest grated pit (FM-024).
2. **Proposal:** FIRST RELEASE as a block on the Blocks palette: the office FALL SYMBOL block, inserted on its layer at the right scale, its grade typed in its attribute. The "suggest a fall arrow" idea goes to the site group after the first release.
3. **Why:** a small office symbol is placed from the palette (your ST-18 pattern, TA-031); only placing a CE thing has a name (D-056).
4. **Real example:** a paved yard falling to a grated pit: drop FALL with "1:100".
5. **Cost:** small (a palette line).
6. **Sure or ask:** sure (TA-031).

**FP-029. Spot level (CDSL)**
1. **What it is today:** CDSL inserts and manages spot levels (FM-025; no recorded runs).
2. **Proposal:** FIRST RELEASE as a block on the Blocks palette: the office level tag block (FGL, pavement, RL) with its level typed in its attribute. Managing many spot levels goes with the slab group (FP-030).
3. **Why:** same as FP-028; a spot level is never a cover level (D-178).
4. **Real example:** "FGL 6.15" at the crossover.
5. **Cost:** small.
6. **Sure or ask:** sure (TA-031, D-178).

**FP-030. Slab falls (CDSLAB, CDSLABEDIT, CDSLABEREGEN, CDSLABFLOW)**
1. **What it is today:** design slab or hardstand falls and place fall symbols and spot levels; edit, regenerate, show where water goes (FM-053; no recorded runs; CDSLABEDIT labelled "known unsafe").
2. **Proposal:** AFTER THE FIRST RELEASE, in a site group (slab falls, driveway grade S-020, the suggested fall arrow, the catchment overlay, the spoon drain, the raingarden tool), reviewed through the command gate first; nothing forced (D-050); CDSLABEDIT never copied. Until then: slab outline by hand, OFFICEHATCH, CJ and SSC, fall arrows and levels from the palette, the driveway grade written with the TEXT window.
3. **Why:** no recorded use; slabs must be shown but nothing optional is forced (D-049, D-050).
4. **Real example:** a garage slab falling to a grated pit, drawn by hand as today.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-050).

**FP-031. Automatic saw-cut grid (CDJOINT)**
1. **What it is today:** CDJOINT lays a saw-cut grid on a slab outline, clipped, avoiding pits, with SC labels (FM-055; no recorded runs; lost list B1).
2. **Proposal:** AFTER THE FIRST RELEASE, as an option of SAWCUT ("fill this slab at 3.0 m"), never automatic. Until then saw cuts are drawn one by one with SAWCUT.
3. **Why:** saw cuts are drawn only when the drafter draws them (D-050).
4. **Real example:** a 6 x 9 m driveway slab at 3 m spacing: six SAWCUT lines.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-050).

**FP-032. Spoon drain (CDSPOON, CDSPOONDRAIN)**
1. **What it is today:** a spoon drain outline inside a slab, or a spoon drain run with length and fall (FM-057; no recorded runs).
2. **Proposal:** AFTER THE FIRST RELEASE, in the site group. Until then: AutoCAD's own MLINE (your ML alias, style CLOSED) put on the SPOON DRAIN layer (ST-14), with the "SD" label block from the palette.
3. **Why:** no recorded use; seen parked on the three studied jobs only (E-023).
4. **Real example:** a spoon drain along the driveway edge into P3.
5. **Cost:** none now.
6. **Sure or ask:** sure.

**FP-033. Kerb line (CDKERB)**
1. **What it is today:** a two-point kerb line in the legend style with an optional label (FM-058; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of PUT ON OFFICE LAYER: the kerb layer is a line in its list; draw the line, put it on KERB; the label from the palette.
3. **Why:** it is plain linework; ST-14 does exactly this.
4. **Real example:** the kerb and channel line at the crossover beside the discharge point.
5. **Cost:** small (a list line).
6. **Sure or ask:** sure (D-209).

**FP-034. Paved area and catchment overlay (CDPAVE, CDCATCHMENT)**
1. **What it is today:** quick-hatch a paved area with its pavement type; show a grated pit's paved catchment and warn when it is too big (FM-059; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of OFFICEHATCH: the paving hatches (driveway, permeable paving) are its choices, and the hatched area can be picked as a site area in the Job window (D-107). The catchment overlay and its grate warning go to the site group after the first release.
3. **Why:** site areas picked off the drawing are ruled (D-107); reading hatches by themselves is later (D-171 item 5).
4. **Real example:** a 60 m2 driveway hatched on HATCH 21 and picked as impervious area.
5. **Cost:** small.
6. **Sure or ask:** sure (D-107).

**FP-035. Tree protection zone and structural root zone (CDTPZ, CDSRZ)**
1. **What it is today:** draw a TPZ or SRZ circle on its layer, with a hatch (FM-060; no recorded runs).
2. **Proposal:** FIRST RELEASE as part of PUT ON OFFICE LAYER: TPZ and SRZ are lines in its list; draw the circle at the arborist's radius and put it on TPZ; the tree zone hatch from OFFICEHATCH.
3. **Why:** plain linework and a hatch; both tools are in the first release.
4. **Real example:** a street tree with a 4.8 m TPZ and 2.5 m SRZ.
5. **Cost:** small.
6. **Sure or ask:** sure (D-209).

**FP-036. Comparing a changed background and repairing xref paths (CDXREFCOMPARE, CDXREFREPAIR)**
1. **What it is today:** compare a changed architect's xref with its last version; find and repair broken xref paths (FM-064; no recorded runs; lost list B11).
2. **Proposal:** AFTER THE FIRST RELEASE: the compare joins the "changed since last issue" group (D-187). Path repair is done meanwhile, and for good, in AutoCAD's own External References palette.
3. **Why:** you put the change list later (D-187); AutoCAD already repairs paths.
4. **Real example:** the architect moves the garage 600 mm: compare the two backgrounds by eye with AutoCAD's own Compare until the group is built.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-187).

**FP-037. New job drawing from the template (CDNEWDWG)**
1. **What it is today:** pick a job folder, discipline and sheet size; CE copies and names the template and fills the title block (FM-065; no recorded runs).
2. **Proposal:** AFTER THE FIRST RELEASE, in the title block and issue group. Until then the template is copied by hand, as the office does today (D-191).
3. **Why:** the title block part is out of the first release (D-097).
4. **Real example:** copy CE_A1_C01 - VERTICAL into the job folder and rename it.
5. **Cost:** none now.
6. **Sure or ask:** sure (D-097, D-191).

**FP-038. Drawing discipline switch (CDDISCIPLINE)**
1. **What it is today:** view or set whether a drawing is Civil or Structural (FM-066; no recorded runs).
2. **Proposal:** RETIRE. Each tab offers only its own tools (D-208) and a CE civil thing carries its own note, so a drawing needs no discipline setting.
3. **Why:** no recorded use; nothing it guarded is left unguarded.
4. **Real example:** a structural sheet open with the civil tab showing: nothing happens unless a civil tool is used.
5. **Cost:** none.
6. **Sure or ask:** sure (D-208).

### 5.4 Shared tools and hatches

**FP-039. Dimension measuring factor (DSET, DSET1)**
1. **What it is today:** DSET sets the measuring factor on a picked dimension to 0.2 (read in your own DIMENSIONS SETUP.lsp); DSET1 converts to one fifth (FM-076; lost list B12).
2. **Proposal:** FIRST RELEASE as part of the Dimensions tool: a "detail drawn five times size" choice that sets the measuring factor on new or picked dimensions, so a 1:20 detail drawn at five times reads true sizes.
3. **Why:** the office's details are drawn five times size and their dimensions are typed over today ("750" measured carries "150", E-047); this does it properly; nothing lost.
4. **Real example:** a pit detail dimension measuring 2250 reads 450 without retyping.
5. **Cost:** small (one choice).
6. **Sure or ask:** sure (D-209, D-210).

**FP-040. Offset at a maximum spacing (MD)**
1. **What it is today:** MD arrays the picked objects between two points at the fewest equal spaces not more than a set distance, 1,200 by default (Maxdist.lsp; FM-082; not recorded).
2. **Proposal:** FIRST RELEASE as part of Divide: a second choice, "copy these objects across at equal spacing, at most 1,200 apart".
3. **Why:** same job as Divide (equal spacing between two points); nothing lost.
4. **Real example:** spreading joist lines at no more than 450 centres across a 3.6 m bay.
5. **Cost:** small.
6. **Sure or ask:** sure (D-209).

**FP-041. Hatch change, many at once, small gaps, check (CEHATCHCHANGE, CEHATCHBATCH, CEHATCHGAP, CEHATCHAUDIT)**
1. **What it is today:** change hatches to another preset; one preset on many outlines; hatch across small gaps; report non-standard hatches (FM-085; no recorded runs; lost list B13).
2. **Proposal:** FIRST RELEASE as part of OFFICEHATCH: "Change picked hatches to" and "Many outlines at once" buttons, and a small-gap box. The "check against the office list" job waits until your hatch list is settled and then becomes a CLEAN tick.
3. **Why:** one hatch window (D-201, TA-044); nothing lost.
4. **Real example:** the engineer swaps a slab type: pick six hatches, change to HATCH 21 concrete.
5. **Cost:** small to medium.
6. **Sure or ask:** sure (D-201).

**FP-042. Swap construction joint and saw cut (CJSS)**
1. **What it is today:** CJSS swaps a joint between construction joint and saw cut, line and label (FM-089; under 8 runs; lost list B14).
2. **Proposal:** FIRST RELEASE as part of the joint tools (CONSTRUCTIONJOINT, SAWCUT): the kind is a choice in Properties or the window on double-click (D-061); changing it changes the line, layer and label together.
3. **Why:** changing a thing has no typed name (D-056).
4. **Real example:** a joint drawn as CJ that the engineer calls a saw cut: change the kind in Properties.
5. **Cost:** small.
6. **Sure or ask:** sure (D-056, D-061).

**FP-043. XRL settings, information and silent variants (XRLCONFIG, XRLINFO, XRLSILENT and the rest)**
1. **What it is today:** variants of the xref tidy that CLEAN now does (FM-071; lost list A7).
2. **Proposal:** FIRST RELEASE as part of CLEAN: the settings are ticks in CLEAN's small window; "information" is CLEAN's one printed line; "silent" is how CLEAN always runs.
3. **Why:** CLEAN is one tool (D-204).
4. **Real example:** CLEAN prints "3 xrefs on the office xref layer, 12 layers tidied, saved".
5. **Cost:** small.
6. **Sure or ask:** sure (D-204).

**FP-044. How joint labels "learn" (CDCJ, CDSC label placing)**
1. **What it is today:** labels are placed where the old code puts them, and you said nothing helps or learns (FM-056; lost list A10; TA-009).
2. **Proposal:** FIRST RELEASE as part of the joint tools: the label sits in full words at the spot read from issued office sheets, like 25T or 25B depending on what is around (TA-025); a hand-moved label keeps its offset (D-181). Learning from issued sheets later is future idea FI-04.
3. **Why:** D-210 asks for the full-word label placed like 25T / 25B.
4. **Real example:** "SAW CUT" sits above the line where text is below it, and below where text is above.
5. **Cost:** small (inside the joint tools).
6. **Sure or ask:** sure (D-210, TA-025).

**FP-045. Which hatches the hatch window offers (the 40 hatch names)**
1. **What it is today:** about 40 number-named hatch commands (FM-083; lost list A11).
2. **Proposal:** FIRST RELEASE as part of OFFICEHATCH: its list is the one you are ticking now by function and layer (TA-047 to TA-056), each hatch a line in the office list.
3. **Why:** "give me a list ... and i will tick off" (TA-045); already in progress.
4. **Real example:** HATCH 74 offered three times by name: first floor over, band beam, raingarden (TA-049).
5. **Cost:** small (list lines).
6. **Sure or ask:** sure (TA-045 to TA-056; your remaining ticks, TA-056, are in the tools interview, not here).

**FP-046. Per-PC personal defaults (CDS, CESETTINGS)**
1. **What it is today:** your own CE defaults on this PC (FM-167, folded; the per-PC part is lost list B17).
2. **Proposal:** FIRST RELEASE as part of the window frame (SP-14): each window opens with what this person last used on this PC (D-060); office standards stay in the office list.
3. **Why:** D-060 "every time, like Hatch", already filled in.
4. **Real example:** you always draw 150 pipes on industrial jobs: PIPE opens at 150 on your PC.
5. **Cost:** small.
6. **Sure or ask:** sure (D-060).

### 5.5 Manager, help and records

**FP-047. Open the logs folder (CEMANAGERLOGS)**
1. **What it is today:** opens the CE support data folder (FM-163; 9 runs; lost list B20).
2. **Proposal:** FIRST RELEASE as part of the Manager's fault report: an "Open logs folder" button beside "Send fault report".
3. **Why:** 9 recorded runs; you look at logs without sending a report.
4. **Real example:** checking today's log after a strange save.
5. **Cost:** small.
6. **Sure or ask:** sure (MG-02).

**FP-048. Usage and failure records (no typed name)**
1. **What it is today:** a record of every command run and every failure written to the office IT folder (FM-173; 2,637 usage and 1,029 failure records; lost list B19).
2. **Proposal:** FIRST RELEASE as part of the Manager: failure records (they feed the fault report and "faults this week" on the admin page) and a plain count of each command per PC per day, with no login, drawing name, path or job name (OC-25).
3. **Why:** you did not tick "no usage records" (TA-012) and want statistics later (D-205); these records are the only evidence of real use.
4. **Real example:** the next function map can say "CLEAN 412 runs this month" instead of guessing.
5. **Cost:** small (on top of SP-16).
6. **Sure or ask:** sure (TA-012, D-205).

**FP-049. Help and the picture tour (CDHELP, CESTARTHERE, CEHELP, CE_HELP, ?CE)**
1. **What it is today:** a help centre, a 2-minute picture tour, command documentation (FM-170; CDHELP under 8 runs; lost list B18).
2. **Proposal:** FIRST RELEASE as part of the three ribbon tabs: every button's tip shows its short name and a small picture of what it draws, written when the tool is accepted; and a one-page printable list of every CE short name goes with the release. The picture tour comes after.
3. **Why:** 2 to 5 people use it in the first year (D-026) and you will show them; tips are AutoCAD's own way (D-049 item 3).
4. **Real example:** hovering over the Tank button shows "TANK (WT)" and a picture of a tank with its note and leader.
5. **Cost:** small per tool.
6. **Sure or ask:** sure (D-049, D-055).

**FP-050. The admin dashboard's other tabs (CEMANAGERADMIN tabs)**
1. **What it is today:** Usage, Machines, Failures, Policies, Support Bundles, Canary Rollout, Promote to All (FM-161; lost list A8).
2. **Proposal:** RETIRE. Replaced by the one admin page (each PC's version, faults this week, one approve button); statistics and wider admin control are future ideas.
3. **Why:** your own answer (TA-013, D-205).
4. **Real example:** approving 1.0.4 for everyone with one button.
5. **Cost:** none.
6. **Sure or ask:** sure (TA-013).

**FP-051. The old Manager pages (CEMANAGER's Status, Settings, Help, Project / Sheets, Project QA, Survey Intake, Drawing Repair)**
1. **What it is today:** eight pages in the old Manager (FM-156; lost list A9).
2. **Proposal:** RETIRE as pages. Status goes to updates and health; Settings to the office lists; Help to the ribbon tips (FP-049); Project, Sheets and QA wait with structural; Survey Intake with the imports; Drawing Repair is replaced by the self-check on open.
3. **Why:** no drawing tools in the Manager (TA-012, MG-06).
4. **Real example:** a drawing that lost its joins: the self-check says so on open and offers "bring 2 pipe ends back".
5. **Cost:** none.
6. **Sure or ask:** sure (TA-012, D-204).

### 5.6 Aliases and loose LISP

**How retiring loose LISP works:** the start-up suite and support paths on each PC are saved AutoCAD settings, which no chat may change without your yes (RULES 1.9). So a retired LISP file is moved into a "retired" sub-folder of the shared `Lisp Files` folder on the change-over day, with your yes, and each PC's start-up list is tidied by you or with your yes. Nothing is deleted.

**FP-052. Where CE's short names live (the office alias file)**
1. **What it is today:** the office alias file of 68 short names for AutoCAD's own commands (FM-176).
2. **Proposal:** FIRST RELEASE as part of the office list of names (edited in the Manager's office lists): CE's short names (PT, CD, WT, LPD and the rest) ship inside the plug-in from that one list; your alias file is never edited.
3. **Why:** the plug-in never edits your alias file (D-170); the short name sits in one office list (D-055).
4. **Real example:** a colleague's PC with an older alias file still answers PT with the Pit tool.
5. **Cost:** small.
6. **Sure or ask:** sure (D-055, D-170).

**FP-053. The commands behind WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial, ET**
1. **What it is today:** aliases in your file that run Wall-l, Wall-t, WX, L2ML, mltim, Dimsmallauto, Dimsmallorig, movedim, Grabcopy, _Pkser and MTE (FM-177). Purpose not found: none of them is defined in the shared LISP folder, the AutoCAD folders or any CE code.
2. **Proposal:** KEPT outside CE, side by side, untouched in your alias file. Risk: none to drawings; WT now belongs to the Tank (D-170), so your WT alias moves (your job, as you said).
3. **Why:** CE never edits your alias file (D-170).
4. **Real example:** typing Gr keeps doing whatever Grabcopy does today.
5. **Cost:** none.
6. **Sure or ask:** ASK-5.

**FP-054. The old TB2024 menu and the bought-in structural toolkit**
1. **What it is today:** an old menu of 4 pull-downs and about 30 toolbars calling 903 routines of a bought-in structural toolkit (FM-106). Whether anyone loads it: Unknown.
2. **Proposal:** KEPT outside CE, side by side, exactly as it is. Risk: none to civil drawings; it is bought-in and structural, which is parked (D-006).
3. **Why:** not ours; structural waits (D-006).
4. **Real example:** a colleague using a toolkit toolbar on a structural sheet carries on.
5. **Cost:** none.
6. **Sure or ask:** sure (D-006); the same question as ASK-5 confirms it.

**FP-055. 3D faces to lines (3DF2L)**
1. **What it is today:** a free third-party routine that turns 3D faces into lines (FM-104; not recorded).
2. **Proposal:** KEPT outside CE, side by side, as a loose LISP file. Risk: none; it is not ours and clashes with no CE name.
3. **Why:** not CE's; may help clean a surveyor's file.
4. **Real example:** a surveyor's drawing full of 3D faces before the background clean.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-056. Pit schedule from a spreadsheet (CIVILEXCELMTEXT)**
1. **What it is today:** brings a civil pit schedule from a CSV file into drawing text (FM-098; not recorded).
2. **Proposal:** RETIRE. Replaced by SCHEDULE, which draws from the pits themselves and follows them (D-109).
3. **Why:** the schedule is never retyped from elsewhere (D-002).
4. **Real example:** the 16-row schedule appears from the pits with SH.
5. **Cost:** none.
6. **Sure or ask:** sure (D-109).

**FP-057. Tool palette group switcher (TP)**
1. **What it is today:** shows one palette group, CIVIL, FRAMING, GROUND or SECTIONS (ToggleToolPaletteGroup.lsp; FM-103; not recorded).
2. **Proposal:** RETIRE once the Blocks palette is accepted. Replaced by the Blocks palette's groups. Until then it stays as it is.
3. **Why:** the Blocks palette replaces the palette sets (ST-10).
4. **Real example:** picking the Civil group in the Blocks palette instead of typing TP, CIVIL.
5. **Cost:** none.
6. **Sure or ask:** sure (ST-10).

**FP-058. The personal-folder commands (CDJ, the owner-named command in NEW.lsp, TEXTONLINE, TEXTONANGLELEFT, TEXTONANGLERIGHT)**
1. **What it is today:** purpose now found in the code (FM-105): CDJ and the owner-named command are early drafts of a pipe command (size, type, grade, inverts, then a polyline and its text); the three TEXT commands place "EB", "PF" and "BP" tags at 2.5 or 2.0 mm along a picked angle, with an option to mirror.
2. **Proposal:** RETIRE. Replaced by PIPE (for the two pipe drafts) and by the TEXT window's angle choice (for the three text commands; the structural tags themselves wait with structural, D-006).
3. **Why:** duplicates of first-release tools; not recorded.
4. **Real example:** "EB" along an edge beam line: the TEXT window with "along a picked line".
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-059. The big LISP pipe command (CDD, CDD3, CDDE, CDD-VERSION, CDD-OSNAP)**
1. **What it is today:** an 11,540-line LISP pipe command with its variants and helpers (FM-093; not recorded).
2. **Proposal:** RETIRE. Replaced by PIPE.
3. **Why:** a third way to draw a pipe (THE_PLAN section 3).
4. **Real example:** a 100 pipe at 1 in 100 drawn with CD.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-060. The older LISP CD ("Civil Pipe Creation")**
1. **What it is today:** an older LISP pipe command in six old copies, sharing the typed name CD (FM-094).
2. **Proposal:** RETIRE. Replaced by PIPE. It must be out of every start-up list before the new CD goes on a PC, or typing CD may run the wrong one (SITUATIONS I4).
3. **Why:** duplicate, and a name clash with the new CD.
4. **Real example:** a colleague types CD and gets the 2023 LISP dialog: that must not happen.
5. **Cost:** none.
6. **Sure or ask:** sure (D-057).

**FP-061. Older pipe-data dialog (TBDRAIN-INPUT)**
1. **What it is today:** an older pipe input dialog (FM-097).
2. **Proposal:** RETIRE. Replaced by the PIPE window.
3. **Why:** duplicate.
4. **Real example:** the pipe's size and grade are set in the PIPE window.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-062. Excel importer build steps (EXCELMODULES and nine more)**
1. **What it is today:** development switches of the structural Excel importer (FM-100).
2. **Proposal:** RETIRE. Not staff tools; the importer itself waits with structural (FM-099, D-006).
3. **Why:** development steps.
4. **Real example:** nobody types EXCELRESET on a job.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-063. Excel importer test routines (TESTBASICTEXT and nine more)**
1. **What it is today:** developer test routines (FM-101).
2. **Proposal:** RETIRE. Not staff tools.
3. **Why:** tests.
4. **Real example:** none on a job.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-064. Check and debug routines (CHECKWIPEOUTBLOCK and six more)**
1. **What it is today:** developer check, test and debug routines (FM-102).
2. **Proposal:** RETIRE. Not staff tools.
3. **Why:** developer routines.
4. **Real example:** none on a job.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-065. Old tool palettes (43 palette files, 2022 to Sep 2024)**
1. **What it is today:** earlier versions of the palette set (FM-109).
2. **Proposal:** RETIRE: moved to an archive folder, not deleted. Replaced by the Blocks palette.
3. **Why:** earlier copies of the current set.
4. **Real example:** none in use.
5. **Cost:** none.
6. **Sure or ask:** sure.

### 5.7 Retire

**FP-066. One-piece pipe object (CDPIPEOBJ)**
1. **What it is today:** a pipe drawn as one special AutoCAD object (FM-009).
2. **Proposal:** RETIRE. Replaced by PIPE, ordinary objects only.
3. **Why:** already ruled: "leave all 5 behind" (D-094, D-015).
4. **Real example:** a colleague with no plug-in sees and edits every pipe.
5. **Cost:** none.
6. **Sure or ask:** sure (D-094).

**FP-067. Upgrade to one-piece pipes (CDC7UPGRADE)**
1. **What it is today:** turns pipes into one-piece pipes (FM-010).
2. **Proposal:** RETIRE. The later "make it ordinary" tool (D-119) handles old drawings.
3. **Why:** already ruled (D-094, D-119).
4. **Real example:** an old drawing with one-piece pipes waits for the take-up tool.
5. **Cost:** none.
6. **Sure or ask:** sure (D-119).

**FP-068. Repeat copy (C)**
1. **What it is today:** AutoCAD's Copy forced to repeat (FM-078; 355 runs).
2. **Proposal:** RETIRE. Replaced by AutoCAD's own Copy, which repeats until Enter.
3. **Why:** already ruled: "Retire it, use Copy" (D-203).
4. **Real example:** C, pick, copy, copy, Enter.
5. **Cost:** none.
6. **Sure or ask:** sure (D-203).

**FP-069. Longer names for the repeat copy (COPYMULTI, COPYM, CEMCOPY)**
1. **What it is today:** the same job as C (FM-079; no recorded runs).
2. **Proposal:** RETIRE. Replaced by AutoCAD's own Copy.
3. **Why:** follows D-203.
4. **Real example:** as FP-068.
5. **Cost:** none.
6. **Sure or ask:** sure (D-203).

**FP-070. Change a source's type (CDSOURCECHANGETYPE)**
1. **What it is today:** reserved; it refuses (FM-039).
2. **Proposal:** RETIRE. Replaced by changing the kind in Properties or the inlet window (D-061).
3. **Why:** it does nothing today.
4. **Real example:** a floor waste changed to a GIO in Properties.
5. **Cost:** none.
6. **Sure or ask:** sure (D-061).

**FP-071. Bring CE windows forward (CDFOCUS)**
1. **What it is today:** brings old CE windows back to the front (FM-044).
2. **Proposal:** RETIRE. Replaced by the Inspect button on every window (D-065).
3. **Why:** only needed because old windows hid behind the drawing.
4. **Real example:** Inspect, look, back with everything typed kept.
5. **Cost:** none.
6. **Sure or ask:** sure (D-065).

**FP-072. Old name of CDDESIGN (CDSETUP)**
1. **What it is today:** prints one line and opens CDDESIGN (FM-049).
2. **Proposal:** RETIRE. Replaced by the Job window.
3. **Why:** old names are gone (D-053).
4. **Real example:** none.
5. **Cost:** none.
6. **Sure or ask:** sure (D-053).

**FP-073. Command hub and command search (CEPALETTE, CETOOLS, CETOOLSTOGGLE)**
1. **What it is today:** a command hub palette and a search that runs any CE command (FM-110; CETOOLS under 8 runs).
2. **Proposal:** RETIRE. Replaced by the three tabs with tips (D-200, FP-049).
3. **Why:** you did not tick command search (TA-031).
4. **Real example:** the Tank button on CE Civil, or WT typed.
5. **Cost:** none.
6. **Sure or ask:** sure (TA-031).

**FP-074. Ask CE assistant (CEASK, CDASK)**
1. **What it is today:** an optional assistant, off by default, whose path could send drawing text off the PC (FM-172; no recorded runs).
2. **Proposal:** RETIRE. Nothing replaces it; no decision asks for it.
3. **Why:** privacy risk and no use.
4. **Real example:** none.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-075. Civil fault-finding commands (CDDEBUG and nine more)**
1. **What it is today:** debug switches, grip and speed diagnostics, internal routes, a test runner, a developer export (FM-181; CDDEBUG under 8 runs).
2. **Proposal:** RETIRE. Replaced by the new build's own night tests, speed meter and fault report (SP-16, SP-20).
3. **Why:** internal to the old objects.
4. **Real example:** a slow move is caught by the night speed check, not by CEPERFDIAG.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-076. Leftover test bundles (CEW03TESTEXTRACT, CELINKSTATUS, CETESTCR, CETESTMR)**
1. **What it is today:** test pieces that never shipped as tools, one loading at every start-up (FM-182).
2. **Proposal:** RETIRE. MR and CR live once in the shared tools.
3. **Why:** leftovers; the fifth home of Move and Rotate.
4. **Real example:** none.
5. **Cost:** none.
6. **Sure or ask:** sure.

**FP-077. Structural fault-finding and plumbing (BEAMLINKDEBUG and seven more)**
1. **What it is today:** beam link dumps, tag diagnostics, time tracking diagnostics, snapshot recovery, palette restore (FM-184).
2. **Proposal:** RETIRE. Structural is rebuilt on the new foundation when it is unparked, with its own checks (D-006).
3. **Why:** internal to the old structural objects.
4. **Real example:** none.
5. **Cost:** none.
6. **Sure or ask:** sure (D-006).

---

## 6. Found while planning (for the record)

1. **SH in the acad.pgp copy:** the copy read for this plan has an "SH" line for an operating-system shell command. SH is the Pit schedule's short name (D-101). The night run's one-type check must look at which one answers.
2. **Purposes found** that the function map could not find: CDJ and the owner-named command in NEW.lsp are early pipe-command drafts; TEXTONLINE, TEXTONANGLELEFT and TEXTONANGLERIGHT place EB, PF and BP tags at an angle; DSET sets a dimension's measuring factor to 0.2 for details drawn five times size; MD arrays objects at a maximum spacing.
3. **Not found:** the commands behind your WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial and ET aliases (searched the shared LISP folder, its personal sub-folders and the AutoCAD program and settings folders).
4. **Old plug-in side by side:** this plan keeps nothing in the old Civil plug-in, because with both loaded CD answers unpredictably (SITUATIONS I4) and the old storage and pump figures carry the rainfall fault (R-008). The only things kept side by side are outside CE altogether (FP-053 to FP-055).
5. **What this plan did not do:** no AutoCAD was run, so nothing here is proven on screen; the costs and the size estimate are my judgement, not measured; the shared drafting folder was read only for the five unclear LISP names.
