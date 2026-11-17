# Input audit: what the drafter types, and what the system could already know

**Why this page exists.** Tim, 18 Nov 2026 (D-169), after trying the seven bench windows: "SO WE HAVE THE DATABASE THAT IS SCALABLE AND CAN BE BUILT ON BUT WITH THE CALCULATIONS HOW CAN WE USE EVERYTHING IN THE WHOLE SYSTEM TO REDUCE THE AMOUNT OF MANUAL CALCULATIONS AND HOW WE CAN REDUCE THE AMOUNT OF INPUT NEEDED FROM END USER - SUCH AS HEAD AND ORIFICE AS AN EXAMPLE BUT THROUGHOUT THE ENTIRE PLUGIN". His standing aim: type once, saved everywhere (D-002); automate where well considered; must not feel complex.

**Status: a review, DRAFT for Tim.** Nothing here is built or decided. Every proposal is his call. Read-only audit of the bench windows (`C:\CE_CIVIL\bench\CeCivil.Bench.Core\windows\*.csv`, the screenshots in `bench\shots`), the brain's lists (`C:\CE_CIVIL\src\CeCivil.Brain\data\`), FOUNDATION.md, UI_PLAN.md, the reference library (SUMS, LIMITS, INPUTS_AND_OUTPUTS, JOB_KINDS, ELEMENTS, TABLES_AND_BOXES, TOOLS_TODAY, councils) and DECISIONS.md, 18 Nov 2026.

**The six sources, in order of preference (used all through this page):**
1. **A. The drawing:** measured from what is drawn.
2. **B. A joined thing:** read across a join from another thing.
3. **C. The job sheet:** a job fact typed once for the whole job.
4. **D. A standard:** office or council list, filled, can be typed over.
5. **E. A sum:** worked out from other figures.
6. **F. The drafter's choice:** must be typed or picked; no source can know it.

---

## The short answer for Tim

1. **Headline:** one ordinary two-unit job (4 pits, 5 pipes, 3 downpipes, a tank, detention) asks for **85 figures today; it could ask for 20**, or **12** if you give a rule for pit kind and lid.
2. **Where the drawing cannot be read** (levels, areas), the count is **31**, and each of those is still typed in one place only.
3. **Hand sums go to none:** the orifice by trial, the plate height, the pit size from its depth and the tank's detention litres would all be worked out.
4. **Head and orifice:** you give the permitted discharge and the top water level; the plugin finds the plate height (380), the head (345.5) and the orifice (69 mm, 5.84 of 6.00 l/s) from the levels already drawn.
5. **Biggest single win:** numbers, kinds and office defaults filled by themselves removes 30 figures and is mostly new lines in the lists.
6. **Typed twice today, and already disagreeing on the bench:** pit P3 is a "Junction pit, Grated lid" in the Pit window but a "Grated pit, Class C Lid + Grate" in the schedule.
7. **Never assumed silently:** permitted discharge, top water level, the rainfall table, the council and its connection invert stay visible with their source and padlock.
8. **Ten questions for you** are at section 9; nothing here is built until you say so.

---

## 1. Worked example: head and orifice, from what is drawn to 69 mm

The one made-up job (`windows\job.csv` and `detention.csv`). Each step says its figure, where it comes from (A to F), and what it is on the bench today.

1. **Site area 600 m².** Today: typed, "given". Could be A: the title boundary on the background drawing (E-030), or given by a council document (D-108). Kept on the job sheet.
2. **Roof 230 m².** Today: worked out from the three downpipes' roof areas, 82 + 82 + 66, each typed in the Inlet window. Could be A: the roof catchment hatch to tank WT1 (E-061), measured once.
3. **Paving 150 m².** Today: typed, "measured". Could be A: the driveway and paving hatches (HATCH 21, E-033).
4. **Garden 220 m².** Already E: 600 − 230 − 150.
5. **Coefficients 0.90 roof, 0.90 paving, 0.35 garden.** Already D (table `runoff_coefficients`, Boyd's row). The 0.35 against 0.30 is still not ruled (Q-004).
6. **Effective area 419 m², coefficient 0.70.** Already E: 207 + 135 + 77 = 419; 419 ÷ 600 = 0.70.
7. **Permitted discharge 6.00 l/s.** Today: typed, "given". Stays C: it comes from the council letter and only the letter can say it. Typed once on the job sheet. Where the council gives a rule instead of a figure, S-002 works it (coefficient × 1 in 5, 5 minute rain × site area ÷ 3600).
8. **Rainfall, 1 in 10, 5 to 30 minutes: 98.6, 73.6, 60.1, 51.5, 45.5, 40.9 mm/h.** Today: D, but these are ONE Kingston job's figures (S-003, CIV-03), not this site's. Must become C: the Bureau's table for the site, once per job. How it is got: UNKNOWN (question 5).
9. **Storage needed 1.64 m³.** Already E: at 5 minutes, 98.6 × 419 ÷ 3600 = 11.48 l/s in; less 6.00 out = 5.48 l/s; × 300 s = 1,643 L. The 5 minute storm governs.
10. **Detention pipe 0.56 m³.** Today: the pipe's 225 dia and 14 m are held in the Detention window's own data, not read from a drawn pipe. Could be A and B: the length measured off the drawn pipe, the diameter from the Pipe tool (225 is the office smallest for detention, D-147). 3.1416 × 0.1125² × 14 = 0.56.
11. **Top water level 5.40.** Today: held "chosen" but **there is no box for it on any window** (DRAFTS_detention item 7). Stays F: the one real detention design choice (D-018: normally fixed on a tight site; how it is first chosen is Q-001). Gets a box on the job sheet.
12. **Pits that hold water: P1 and P2 ticked, P3 not.** Stays F (D-105: "Only pits I tick"). Ticked once, in one place.
13. **Pit storage 0.08 + 0.06.** Already E: P1 0.45 × 0.45 × (5.40 − 5.00) = 0.08; P2 0.45 × 0.45 × (5.40 − 5.08) = 0.06.
14. **Tank share 0.94 m³.** Already E in the Detention window: 1.64 − 0.56 − 0.14 = 0.94. But the Tank window holds "Detention 1,000 L, chosen", so the tank note would print 1000 while the criteria box prints 0.94 (see section 2, item 4).
15. **The orifice pit is P1.** Today: nothing says so (the Pit window's Kind box is bench-only, no brain fact). Could be B: on a detention job, the pit whose outlet pipe ends at the council connection; suggested, typed over. Needs a join "the orifice sits in this pit" (question 6).
16. **P1 outlet invert 5.00.** Already B and E: the Levels window works it uphill from the council connection 4.95 (5.00 m at 1 in 100 = 0.05).
17. **Orifice invert 5.02.** Could be E with D: outlet invert + 0.020 (S-025; office standard, can be typed over, D-084). Not in the brain yet.
18. **Plate height 380 mm.** Today: typed, "chosen", with no tie to anything. Could be E: top water level − orifice invert = 5.40 − 5.02 = 0.38 m. The made-up job already agrees, so today two held figures happen to match; change either one and nothing tells you. This assumes the top of the baffle is at top water level: UNKNOWN office rule (question 1).
19. **Head 345.5 mm.** Already E: plate − half the orifice = 380 − 34.5 (D-023: the criteria box keeps printing the plate, 380, under HEAD).
20. **Orifice 69 mm.** Today: picked from a bench-only list (55 to 80) and checked by trial. Could be E: the largest whole millimetre whose flow stays under the permitted discharge. Flow = 0.6 × area × √(2 × 9.81 × head): 69 mm gives 5.84 l/s (Suits); 70 mm gives 6.01 l/s (over). So 69, and never below the council's minimum (L-008: 65 at two councils). Rounding to whole millimetres is what the jobs show (63, 65, 67, 69, 77, 79, 80); whether it is whole millimetres or a maker's list is question 3.
21. **Criteria box.** Already a view: PERMITTED SITE DISCHARGE 6.00 l/s, HEAD 380mm, DIA. OF ORIFICE 69mm, TWL 5.40m, VOLUME REQUIRED 1.64, each storage, TOTAL.

**What the drafter still gives for the whole chain:** the permitted discharge (or the council that sets it), the top water level, which pits hold water, and drawing the detention pipe. Everything else is drawn, joined, standard or worked out.

**What would have to exist:**
1. **A join** from the site to its orifice pit (one line in `joins.csv`).
2. **Two sums:** orifice invert = pit outlet invert + standard step; plate height = top water level − orifice invert (lines in `sums.csv`, "default" so they can be typed over).
3. **One new brain ability:** "the largest size that still passes" (the orifice formula cannot be turned round because the head depends on the diameter). Once it exists, each use is one line. The same ability sizes pits (section 5, chain 3).
4. **A box** for the top water level, and the council's minimum orifice as a council standard row.

---

## 2. Typed twice: facts asked for in more than one place, or that could disagree

1. **"Holds detention water", two facts.** The Pit window's tick (`pit_look.holds_detention`) and the Detention window's tick (`pit_stores.holds_water`). `facts.csv` itself says the first is "kept here only until the Detention tool joins the pit". Proposal: one tick on the join, shown in both windows.
2. **Pit kind and lid, two facts.** Pit window Kind and Lid (`pit_look`) against the schedule's own `pit_in_schedule.pit_kind` and `lid_remarks`. **Already disagreeing:** P3 is "Junction pit, Grated" in the Pit window and "Grated pit, Class C Lid + Grate" in the schedule. Proposal: the schedule reads the pit; a cell typed over stays held with its padlock (D-103).
3. **Council connection invert, held twice.** `job.csv` holds `council_invert` 4.95 AND `invert` 4.95. Proposal: invert = council invert by a sum, held once.
4. **Tank detention litres, held in one window and worked out in the other.** Tank window: 1,000 L "chosen". Detention window: share 0.94 m³ "worked out", with 0.06 spare. On the sheet the tank note says "1000 lt FOR DETENTION" and the criteria box tank line says 0.94. D-100 says the detention part is worked out from the volume needed. Proposal in section 5, chain 4.
5. **Re-use: two rulings that pull apart.** D-024: re-use comes from the STORM or sustainability report, the rest is detention. D-100: detention is what the sums need, re-use takes the rest. Question 4.
6. **Plate height against top water level and the orifice pit's invert.** Three figures that must agree; today plate and top water level are both held separately and nothing ties them.
7. **The detention pipe.** The Detention window has its own pipe (225 × 14 m) with its own held size; the Pipe window has a Kind "Detention". Two ways to say one thing. Proposal: a drawn pipe of kind "detention pipe" is joined to the site by itself.
8. **Roof area in three places.** Per downpipe (Inlet window), per tank (sum), for the site (a "default" sum that can be typed over). A site roof typed over stands with no clash, so a typed 240 beside downpipes adding to 230 would show no warning. Proposal: when typed over, the check says "Roofs joined add to 230.00; site roof is 240.00" (amber), as the garden check already does.
9. **Tank size and detention boxes in both the Tank and Detention windows.** One fact each, two places to type. Acceptable as two views of one fact, but only one should carry the box.
10. **Pit number** in the Pit window and the schedule's typed-over pit number. Fine by D-103, but numbers should be automatic (D-075).
11. **Cover level** in the Pit window, the Levels window row and the schedule's typed-over cell. One fact; the schedule cell is a deliberate hold.
12. **Grade** in the Pipe window and the Levels window (typing there changes every held grade). One fact, two boxes.
13. **Inlet arrival level in the schedule** (`inlet_in_schedule.invert`, typed "chosen" for DP4, DP5 and TG1). Where a branch pipe is drawn, it is that pipe's downstream invert (B).
14. **Downpipe size against the pipe it sits on.** DP3 100 and "pipe to P4" 100 are separate held figures.
15. **Hidden holds with no box anywhere:** the storm "1 in 10" and rain zone (Detention, shown but not typable), the top water level (no row at all), and each pipe's "what is over it" (held "chosen" in `job.csv`, no box in the Pipe window). These are inputs nobody can see to change.
16. **Two different "top water levels".** Tank TWL 7.75 (the tank's own, base + height) and the site TWL 5.40 (the detention system). Same words, different things: a naming risk on the sheet and in the windows.
17. **A wrong line in the Tank window.** `tank.csv` says "Criteria box orifice reads {WT1/orifice} mm" when the tank orifice changes. The criteria box DIA. OF ORIFICE is the control pit's orifice (69), not the tank's 30 (E-041). Two orifices could be confused on the sheet.

---

## 3. The job sheet: facts typed once for the whole job

**Proposed list (each shows value, source and padlock, like every other fact):**
1. **Council.** Picked from the council list. Fills, where the council's own file has a sourced figure (D-096): method, storms, coefficients, minimum orifice, underground share, cover figure, pipe minimums, tank credit rule.
2. **Kind of development.** Single dwelling, units, or other. Sets each pipe's starting "what is over it" (AS 3500.3 row: "single dwelling, no traffic" or "other site, no pavement"), and the job kind (K-001 to K-004).
3. **Discharge point and connection invert.** Kerb, council pit or pipe, and so on (Input 1); the invert as given, or marked "assumed" (D-030, E-058). The connection's ground level beside it.
4. **Permitted discharge.** Given by the council (l/s), or "worked out" when the council gives the rule (S-002).
5. **Storage given by the council.** Only where the council works it (K-006) or OSD4W gives it.
6. **Method.** Boyd's or OSD4W; filled from the council when on file, otherwise picked once (D-098).
7. **Storms.** Discharge storm and storage storm; filled from the council or the office (L-017).
8. **Rainfall table for the site.** One per job. How it arrives is UNKNOWN (question 5); until it is entered it shows "assumed" and the criteria box says so.
9. **Site area.** Measured from the boundary, typed, or given (D-107, D-108).
10. **Pre-development coefficient,** where the council fixes one (L-017: 0.4, 0.35 seen).
11. **OSD4W results,** when OSD4W: permitted and storage as typed from the program; zone and times (S-026).
12. **Top water level.** The detention system's one level (F). Today it has no box.
13. **Tank re-use needed,** from the STORM or sustainability report, if D-024 stands (question 4).

**Where it lives:**
1. **A "Job" window** in the same frame as the others (UI_PLAN section 3 item 4), reached from the short CE tab; the whole-job side panel of D-048 shows it too. Short name: not picked (naming rule D-055).
2. **It opens by itself** the first time a tool needs a job fact that is unknown (for example the Detention tool and no permitted discharge), with that line in focus. Nothing blocks; until it is filled the figure says "not known yet".
3. **The Detention window card 1 and the Levels window card 1 are views of it.** Change it in either and every view follows (FOUNDATION block 7).
4. **Stored with the drawing.** Where exactly is Stage 4 (Q-204).
5. **No Job Manager hand-over in the first release** (D-071 to D-074). Later the Job Manager could feed the council, permitted discharge and letter date it files, and receive the assumed values still open (D-071, D-074). No address or client detail is needed on the job sheet.

---

## 4. Reading the drawing

**Rule for all of these:** a figure read from the drawing shows "measured" and the object it came from. If it cannot be read it stays unknown and the window asks for it once; it is never guessed (RULES 12.2; DESIGN.md 5.6 "Cannot check yet").

1. **Pipe length.** Already read from the drawn pipe. Reliable.
2. **Which pipe joins which pit; where a downpipe ends up.** Reliable when drawn with the plugin's tools (D-034: a pipe starts on the pit wall). The old plugin already followed pipes from a downpipe to its end (CDDEST, T-038). Unreliable on hand-drawn sheets until the "take up an old drawing" tool exists (D-027, D-119).
3. **Where a downpipe sits along its pipe.** Already the click point.
4. **Tank size and shape.** Reliable when the office tank block is used: the blocks are named by size ("5000 LITRE TANK", E-019) and filed by shape. A tank drawn any other way: asked.
5. **Detention pipe.** Reliable: its own layer STORMWATER DETENTION PIPE (D-153, D-156).
6. **Site area from the title boundary.** Medium. The boundary is in the background drawing, not the job drawing (E-056 item 16), drawn as four plain lines on some jobs and one polyline on others (E-030 item 9). Four lines are not a closed outline, so it may need one pick round the corners. Fallback: typed or given.
7. **Paving area.** Medium. Driveway hatches are on HATCH 21 in the job drawing (E-033), some associative; other paving hatches vary by job (JOB_A and JOB_B carry extra hatch layers). Picked once and linked (D-107).
8. **Roof area.** Medium to low. The architect's roof is exploded lines, arcs and splines on A-ROOF OUTLINE, on the upper floor band 50,000 above (E-052, E-056). The roof catchment hatch per tank is drawn on some jobs (E-061: CIV-07, CIV-08, CIV-01) but its layer and objects are UNKNOWN. Best route: the drafter hatches the roof to each tank (as today on those jobs) and the plugin reads the hatch area. Question 8.
9. **Cover levels.** Low to medium. Survey spot levels are plain text, value only ("5.39"), on surveyor layers that differ per job, inside the background (E-030 item 14); finished levels are "FGL 6.15" tags in the job drawing (E-029). Which one a cover level follows is UNKNOWN (question 7). Proposal: offer the nearest level text, shown with the text it came from; once accepted it is locked (D-078).
10. **Connection ground level.** Low to medium. Nearest kerb or survey level; same caution as cover levels.
11. **Floor levels.** Medium. "FFL 6.05" text on FLOOR LEVEL (E-028). Used only for a check: top water level at least 300 below habitable floors where a council asks (L-011).
12. **What is over a pipe.** Medium. A pipe crossing a driveway hatch or the building outline (50CONT, E-052) could switch its situation; otherwise it takes the job's kind of development. Shown, can be changed.
13. **Tank base level.** Low. Ground near the tank for an above-ground tank; an underground tank is a design choice. Usually asked.
14. **Scale of the sheet.** Reliable from the viewport (the schedule's scale box is coming out anyway, D-169).

---

## 5. Chains that could run end to end with no typing

Once the drawing and the job sheet exist:

1. **Roofs to downpipes to tanks.** Roof hatch per tank (A) gives each tank's roof total, the roof-to-tank box (E-021) and the site roof. Where each downpipe goes comes from the joins (B). Pipe flow and size from roof areas (S-022, S-009) is NOT done on a house (D-019) and how it is done on bigger jobs is UNKNOWN (Q-002); the Manning formula itself is not written out in the evidence. So pipe sizes come from the office standard by kind of run, not from flow, until Tim says otherwise.
2. **Areas to storage to orifice.** Site, roof and paving (A) and the council's figures (C) give coefficient, storage needed, storage provided by the drawn detention pipe, ticked pits and tank, and then plate, head and orifice (section 1). Runs with no typing once permitted discharge and top water level are given.
3. **Levels to pit sizes to the schedule.** Cover levels and the connection invert, with the office grade and drop (D), give every invert along the run (built: the Levels window), then each pit's depth (E), then each pit's size as the smallest that suits its depth (S-012, D-135), step irons beyond 1.0 m (D-136), then every schedule row (built: the schedule window). A pit size feeds back into its storage (plan size × water depth), so a pit that grows changes the tank share and "What else changes" says so.
   **On the made-up job this catches two real slips:** P1 and P2 are 0.62 deep and drawn 450 x 450, which the office table allows only to 0.60. Worked out, both become 600 x 600; their storage goes from 0.08 and 0.06 to 0.14 and 0.12; the tank share drops from 0.94 to 0.83. P1 is also the orifice pit, whose chambers are at least 600 x 600 (L-007). The bench schedule prints both rows at 450 with no flag.
4. **Tank size to the tank note.** Tank size (given) less the re-use the STORM report needs gives the tank's room; the tank's detention is the smaller of that room and what the pipes and pits leave (D-100); re-use is the rest. The tank note, the criteria box tank line and the tank detail all read the same figures. This is honest: if the tank's room is too small, storage still comes out short (the builder's worry in DRAFTS_detention item 6 was that a detention worked back from the need could never be short; capping it by the re-use from the report fixes that). Needs question 4 answered.
5. **Kind of development and what is over each pipe to cover needed.** Job sheet (C) sets each pipe's situation; a driveway crossing (A) raises it; the cover table (D) and the pipe's levels (E) give the cover check. Built, except the reading.

---

## 6. The count (the headline)

**What is counted:** every figure or choice the drafter gives for this job, counted where the windows ask for it (a fact held twice is counted twice). Not counted: the ticks and side picks for what is shown on the drawing (they open on last used, D-060: 27 of them across the windows), figures already filled by a standard (grade, drop, cover needed, tank orifice, coefficients), and figures already measured from a drawn line (pipe length, where an inlet sits).

**The job:** the made-up job's shape: pits P1 to P4, four pipes to the council connection plus one detention pipe, three downpipes, tank WT1, Boyd's detention, the pit schedule.

**Today: 85**
1. **Pits, 24:** 4 pits × (number, size, kind, lid, cover level, detention tick).
2. **Pipes, 16:** 5 pipes × (size, material, what is over it) = 15, plus the detention pipe's kind = 1.
3. **Connection, 3:** council invert, the second "invert" held, connection ground.
4. **Levels, 1:** which way to work.
5. **Downpipes, 15:** 3 × (kind, number, size, roof area, drains to).
6. **Tank, 5:** number, size, shape, detention litres, base level.
7. **Detention, 11:** method, site area, permitted, storm, top water level, paving area, orifice, plate, and three "holds water" ticks.
8. **Schedule, 10:** 4 pit kinds and 4 lids again, the council pit's size and remarks.
9. **Total:** 24 + 16 + 3 + 1 + 15 + 5 + 11 + 10 = **85**.

**After, drawing readable: 20**
1. **Pits, 12:** kind 4 and lid 4 (no rule known yet), and one "holds water" tick each, 4. Number, size and cover level go.
2. **Pipes, 1:** choosing to draw the detention pipe as detention. Size, material and what is over it go.
3. **Connection, 1:** the council invert. The second copy and the ground level go.
4. **Levels, 0:** the brain works from whatever is held.
5. **Downpipes, 0:** kind from the command, number automatic, size standard, roof from the hatch, drains-to from the joins.
6. **Tank, 2:** size (given), re-use needed from the STORM report (new, only if D-024 stands). Number, shape, detention and base level go.
7. **Job sheet, 3:** council, permitted discharge, top water level. Method and storm come from the council; site and paving areas are measured; plate and orifice are worked out; the ticks moved to the pits.
8. **Schedule, 1:** the council pit's size (from the letter or the pit information sheet).
9. **Total:** 12 + 1 + 1 + 0 + 0 + 2 + 3 + 1 = **20**.

**After, with a rule for pit kind and lid: 12** (20 less 8).

**After, drawing NOT readable: 31** (20 plus 4 cover levels, connection ground, roof per tank, paving, site area, tank base, method and storm where the council file has nothing yet).

**Hand calculations:** today the drafter still trials the orifice, works the plate height, reads the pit size off the table and decides the tank's detention litres. After: none.

---

## 7. Risks, honestly

1. **A figure worked out is still the engineer's figure.** The engineer signs the design. Every worked-out figure therefore shows its sum, its source chip ("worked out", "measured", "standard", "typed over", "assumed") and its padlock; one click holds it. Nothing worked out is hidden behind a total.
2. **The orifice sits on a knife edge.** 69 mm gives 5.84 of 6.00 l/s; 70 mm gives 6.01. A 10 mm change in top water level moves the answer. The Discharge card must show the margin ("5.84 of 6.00") and "What else changes" must say when the orifice changes size by itself.
3. **The rainfall table on the bench is one Kingston job's.** Used silently on every job it would give wrong storage everywhere. Until the site's table is entered it must show "assumed", and the criteria box and computation sheet must say so.
4. **Plate = top water level less orifice invert is an assumption** about how the office sets the baffle. It must stay a "default" sum, typed over in one click, until Tim confirms (question 1).
5. **The pervious coefficient (0.35 or 0.30) is not ruled** (Q-004) and changes the storage needed. It is visible on card 2; it must not move without the card saying so.
6. **Areas read from hatches can miss a piece.** A roof part not hatched is simply not counted. Areas must show which outlines they came from, highlighted in the preview, and the "areas add up" check stays.
7. **Pit sizes that grow by themselves change storage and the tank split.** Always reported in "What else changes" ("P1 becomes 600 x 600; tank share 0.94 becomes 0.83").
8. **Levels read from text can be the wrong level** (existing survey against finished surface). Offered, never accepted silently; locked only once the drafter accepts (D-078).
9. **Council figures from one job's letter are not standards** (the Monash junction pit row is from one approval letter). The council file shows each figure's source and date (D-096, D-148).
10. **A typed figure over a default gives no clash by design** (a "default" sum). Where the default came from the drawing or a join (site roof, garden), a typed figure must raise an amber "adds up to" check so the two cannot quietly differ (D-003).
11. **Must never be assumed silently:** the council and its method; the permitted discharge; the connection invert (shown "assumed" until confirmed, D-030); the rainfall table; the top water level; which pits hold water (D-105); a council's tank credit rule; any coefficient the council fixes. Each is held, visible, with its source.
12. **The plugin never bends a standard by itself** (D-124). If held values cannot all fit, it says where and by how much (D-125) and changes nothing.

---

## 8. Order of work: the five changes that remove the most typing for the least building

1. **Numbers, kinds and office defaults fill themselves (removes 30).** Pit, downpipe and tank numbers next free (D-075); inlet kind from the command used; pipe size and material, downpipe size and tank shape from office standard rows; each pipe's "what is over it" from the job's kind of development. Building: new lines in `standards.csv` and `facts.csv`, one job fact. No new brain ability.
2. **One fact, one place (removes 13, and stops the P3 disagreement).** One "holds water" tick on the pit's join to the site; the schedule reads the pit's kind and lid; the connection invert held once; the detention pipe is the drawn pipe of kind "detention pipe"; tank size and detention have their box in one window. Building: data lines and window lines; no new ability.
3. **Head, orifice and pit size worked out (removes 6, and every hand trial).** The orifice pit join; orifice invert and plate height as default sums; orifice diameter as "the largest whole millimetre that passes", never below the council minimum; pit size as "the smallest that suits its depth"; the tank's detention worked out, capped by its room (after question 4). Building: one new brain ability (largest or smallest that passes), then one line per use.
4. **The job sheet (removes 2, and brings back three hidden inputs).** Council, kind of development, permitted discharge, storms, method from the council file, connection, site area, rainfall, and a box at last for the top water level. Building: one window in the standard frame; the Detention and Levels cards become views of it.
5. **Read the drawing, cheapest first (removes 14).** First where downpipes go, from the joins (3); then hatched roof per tank, paving and the boundary, each picked once and linked (D-107) (5); last, and most carefully, cover levels, connection ground and tank base from level text (6). Building: the joins are free; area picking is one tool used by three facts; level reading is the riskiest and waits for question 7.

---

## 9. Questions for Tim

1. **Baffle and top water level.** Is the top of the orifice pit baffle always at the top water level, so plate height = top water level less the orifice invert? (The made-up job agrees: 5.40 − 5.02 = 380 mm.)
2. **Top water level.** How is it first chosen (Q-001)? For example a set depth below the lowest cover of the pits that hold water?
3. **Orifice size.** Rounded down to a whole millimetre, or picked from a maker's or drill list?
4. **Tank re-use.** From the STORM or sustainability report (D-024), or worked out from the volume needed (D-100)? Recommendation: both, as one sum: re-use needed from the report sets the tank's room; the detention is what the sums need, up to that room.
5. **Rainfall.** Where does each site's Bureau table come from, and is one table per job right? (The bench uses one Kingston job's table.)
6. **Orifice pit.** On a detention job, is it always the last pit before the council connection?
7. **Cover levels.** Do they follow the finished levels (FGL tags) or the survey's existing levels? May the plugin offer the nearest level text for you to accept?
8. **Roof areas.** Is one roof hatch per tank the office way? Is a roof area per downpipe ever needed on houses and units?
9. **Pit kind and lid.** Is there a rule (for example grated where surface water collects; class by what is over it: B under a driveway, C in a car park, L-019)?
10. **Pipe sizes.** 100 from a downpipe and 150 between pits as the office start, or 100 everywhere unless the council says (L-002)?

Also UNKNOWN in the reference and listed for later: whether a detention pipe must sit fully below top water level to count its full volume; the council minimum orifice for most councils (L-008); the layer and objects of the roof hatch (E-061); the lid class rule.

---

## 10. Per-window lists

Each input: what it is today; where it could come from (A to F); what would have to exist; how sure. "Display" means a choice of what is shown on the drawing, opening on last used.

### Pit window: 10 inputs

1. **Size (pick from list).** Today: chosen. Could be E: the smallest size whose greatest depth suits the pit's depth (S-012, D-135), a council condition overriding (D-148); typed over. Needs: the "smallest that suits" ability, and the orifice pit's 600 x 600 minimum (L-007) as a standard. Sure: high (Tim ruled the table).
2. **Number (typed).** Today: typed. Could be D/E: next free number, Renumber from the outlet (D-075). Needs: a numbering rule line. Sure: high.
3. **Kind (pick).** Today: picked; bench-only, no brain fact. Could be B in part: orifice pit = the pit whose outlet ends at the connection on a detention job (suggested). Junction, grated or plastic: F. Needs: question 6 and 9. Sure: medium.
4. **Lid (pick or type).** Today: picked. Could be B/D: grate or solid follows the kind; class by what is over it (L-019). Needs: question 9. Sure: low until ruled.
5. **Holds detention water (tick).** Today: ticked, and ticked again in Detention. Stays F (D-105), in one place. Needs: one fact on the join. Sure: high.
6. **Cover level (typed).** Today: typed, "measured". Could be A: nearest level text; else F. Locked once set (D-078). Needs: question 7 and a level reader. Sure: low to medium.
7. **Depth (typed, the other way in).** Today: typed only to hold depth instead of cover. Already E (cover − outlet invert). Keep as a way in. Sure: high.
8. **Tag shown (tick).** Display. D. Sure: high.
9. **Cover level text shown (tick).** Display. D. Sure: high.
10. **Turned (pick).** Display. D (square to the sheet). Sure: high.

### Pipe window: 11 inputs (plus two held with no box)

1. **Size (pick or type).** Today: chosen. Could be D: by kind of run (downpipe branch, between pits, detention 225 smallest, D-147); later E by flow if Tim wants (D-019, Q-002). Needs: standard rows; question 10. Sure: medium.
2. **Kind (pick).** Today: picked. Could be A: the layer drawn on or the command used; B: joined to the site as storage. Needs: nothing new beyond the detention layer. Sure: high.
3. **Material (pick or type).** Today: picked, last used. Could be D: office default as a standard row. Sure: high.
4. **Grade (pick or type).** Already D (1 in 100, D-143; detention by size, D-134). Typed only to change. Sure: high.
5. **Work uphill or downhill (button).** Today: picked. Could be E: the brain already works from whatever is held. Keep the buttons as shortcuts. Sure: high.
6. **Upstream invert (typed to hold).** Already B/E (from the pit and the Levels run). Typed only to hold (D-080). Sure: high.
7. **Downstream invert (typed to hold).** As above. Sure: high.
8. **Label shown (tick).** Display. D.
9. **Flow arrow shown (tick).** Display. D.
10. **Invert at each end shown (tick).** Display. D.
11. **Label side (pick).** Display. D.
12. **Held with no box: what is over it.** Today: held "chosen" in the job data, invisible. Could be C (kind of development) then A (driveway crossing). Needs: a box, the job fact, a hatch read. Sure: medium.
13. **Held with no box: length.** Already A (measured from the drawn pipe). Sure: high.

### Levels window: 6 inputs (plus held levels as needed)

1. **Connection invert (typed).** Today: typed, "given". C: the job sheet, from the council letter or marked assumed (D-030). Stays a given figure. Sure: high.
2. **Connection ground (typed).** Today: typed, "measured". Could be A: nearest kerb or survey level; else C. Sure: low to medium.
3. **Grade for every pipe (typed).** Already D (1 in 100). Typed only to change. Sure: high.
4. **Drop across a pit (typed).** Already D (0.02, D-141). Sure: high.
5. **Direction (button).** Today: picked. E: from what is held (D-017: the critical value governs). Keep as shortcut. Sure: high.
6. **Invert out of the top pit (typed, downhill only).** F when working downhill from the top. Sure: high.
7. **Held levels (variable).** F: whatever is truly fixed on the site (D-018). Sure: high.
8. **Cover levels row and cover needed.** Not typed here: from the pits and the standard. Already right.

### Inlet window: 9 inputs

1. **Kind (picture buttons).** Today: picked. Could be A: the command used (DP, OF, FO, IO, GIO, FW, D-101). Picking only to change. Sure: high.
2. **Number (typed).** Today: typed. Could be E: next free per kind. Sure: high.
3. **Size (pick).** Today: picked. Could be D: office 100; or B: the pipe it sits on. Sure: medium.
4. **Along the pipe (typed or clicked).** Already A: where clicked, slid by grip (D-050). Sure: high.
5. **Roof area (typed).** Today: typed, "measured". Could be A: the roof hatch to the tank; per downpipe only if needed. Needs: question 8. Sure: medium.
6. **Drains to (pick).** Today: picked. Could be B: follow the pipes to the tank or pit (the old CDDEST did). Needs: the joins (exist). Sure: high when drawn with the tools.
7. **Letters shown (tick).** Display. D.
8. **Number shown (tick).** Display. D.
9. **Text side (pick).** Display. D.

### Tank window: 13 inputs

1. **Size (pick from list).** Today: chosen. C (given by the architect or STORM report) or A (the office block placed). Stays one given figure. Sure: high.
2. **Number (typed).** Today: typed. E: next free (WT1). Sure: high.
3. **Shape (pick).** Today: picked. A: from the block. Sure: high with office blocks.
4. **Diameter or width (typed to hold).** Already D (tank list). Sure: high.
5. **Height (typed to hold).** Already D. Sure: high.
6. **Detention (typed).** Today: chosen 1,000 L. Could be E (D-100), capped by the room left after the re-use the STORM report needs (D-024). Needs: question 4; a re-use fact; the room sum changed. Sure: medium.
7. **Base level (typed).** Today: typed, "measured". A for an above-ground tank (ground nearby); F underground. Sure: low.
8. **Top water level (typed, the other way in).** Already E (base + height). Sure: high.
9. **Orifice size (pick or type).** Already D (30 mm, D-024). Sure: high.
10. **Tank note shown (tick).** Display. D.
11. **Leader arrow shown (tick).** Display. D.
12. **Roof areas box shown (tick).** Display. D.
13. **Note side (pick).** Display. D.

### Detention window: 14 inputs in Boyd's (15 in OSD4W), plus three held with no box

1. **Method, Boyd's or OSD4W (button).** Today: picked. C/D: the council's file when sourced (D-096); else picked once on the job sheet. Sure: medium.
2. **Site area (typed, source picked).** Today: typed, "given". A (boundary) or C (council document). Job sheet. Sure: medium.
3. **Permitted discharge (typed).** Today: typed, "given". C: the council letter; only the letter knows it. Or E by S-002 when the council gives a rule. Sure: high.
4. **OSD4W permitted (typed).** Today: typed. C: the program's result, given (S-026). Sure: high.
5. **OSD4W storage (typed).** Today: typed. C: given. Sure: high.
6. **Tank size (typed).** Today: typed; the Tank window's fact. B: one box, in the Tank window. Sure: high.
7. **Tank detention (typed).** Today: typed; the Tank window's fact. E (see Tank item 6). Sure: medium.
8. **Roof (typed or worked out).** Today: worked out from downpipes, can be typed over. A: roof hatch; B: sum of what is joined. Sure: medium.
9. **Paving (typed).** Today: typed, "measured". A: paving hatches. Sure: medium.
10. **Garden (typed or worked out).** Already E (what is left). Sure: high.
11. **Tank share (typed to hold).** Already E. Sure: high.
12. **P1 holds water (tick).** F (D-105), one place. Sure: high.
13. **P2 holds water (tick).** As above.
14. **P3 holds water (tick).** As above.
15. **Orifice (pick from list).** Today: chosen from a bench-only list. E: largest whole millimetre that passes; council minimum checked. Needs: the new ability; question 3. Sure: high on the sum, medium on the rounding.
16. **Plate (typed).** Today: chosen. E/B: top water level − orifice invert. Needs: the orifice pit join; question 1. Sure: medium.
17. **Held with no box: storm "1 in".** D/C: council or office (L-017). Needs: the job sheet. Sure: high.
18. **Held with no box: rain zone (OSD4W).** C: the job sheet (Q-006). Sure: medium.
19. **Held with no box: top water level.** F. Needs: a box on the job sheet. Sure: high.

(Count: items 1 to 3 and 6 to 16 are the 14 boxes in Boyd's; OSD4W swaps item 3 for items 4 and 5, giving 15.)

### Pit schedule window: 17 inputs (plus held rows with no box)

1. **Order, outlet first or upstream first (button).** Today: picked. D: the office's way, once. Sure: medium.
2. **Existing council pit row (tick).** Today: ticked. B: shown when the run ends at a council pit. Sure: high.
3. **Pump well row (tick).** Today: ticked. B: shown when the job has one (it already says "none on this job"). Sure: high.
4. **Plastic pit P7 in the schedule (tick per plastic pit).** F (D-076), starting ticked. Sure: high.
5. to 14. **Ten column ticks.** Today: ticked. Remove: the office schedule block does not drop columns (D-169). Sure: high.
15. **A cell typed over (typed).** F by design, rare (D-103). Sure: high.
16. **Scale (pick).** Remove from the window (D-169); A from the sheet if ever needed. Sure: high.
17. **Standing notes shown (tick).** D. Sure: high.
18. **Held with no box: each pit's kind and lid again.** B: read from the pit (section 2, item 2). Sure: high.
19. **Held with no box: council pit size and remarks.** C: the council letter or pit information; the remarks word "Existing council pit" is D. Sure: high.
20. **Held with no box: inlet arrival levels.** B: the drawn branch pipe's downstream invert. Sure: medium.
21. **Held with no box: title.** Already D (the office's "STORMWATER PIT SCHEDULE", D-113). Sure: high.

**Totals on screen:** Pit 10, Pipe 11, Levels 6, Inlet 9, Tank 13, Detention 14, Schedule 17: **80 boxes, picks and ticks**, of which 27 are display choices and 53 are design figures. Plus at least 7 held figures with no box at all (what is over each pipe, storm, rain zone, top water level, the schedule's kind, lid and arrival levels).
