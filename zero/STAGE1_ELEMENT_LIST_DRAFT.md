# Stage 1 element list (draft 1): what is on a council stormwater sheet

**Status:** draft, from ONE finished job only (coded JOB_C, a civil job from 2025, read-only copy in `C:\CE_WORK\realjobs`). Made Mon 16 Nov 2026.
**How it was read:** the drawing's contents were listed by machine (layers, blocks, text, line work). **The sheet has NOT been seen as a picture yet**, so layout, look and anything inside nested blocks is unknown. Nothing identifying the job is recorded here.
**Still to do:** see the sheet as a picture; repeat for JOB_A and JOB_B (civil) and JOB_D and JOB_E (structural); add the items from `STAGE1_GUIDEBOOK_NOTES.md` that this job did not use; Tim confirms.

## The sheet

1. **One drawing file, one A1 sheet** (layout named "A1 PDF"), titled "Stormwater drainage and pavement plan and details", scales 1:100 and 1:20.
2. **Two architect / base drawings attached as references** (a site one and a ground floor one), each bringing in about 80 layers of its own.
3. **Title block and border**, with a revision list (date, drawn / checked initials, issue description such as "Preliminary issue" and "For council approval", revision letter).
4. **Disclaimer note block, legend block, north point, scale title.**

## On the plan

1. **Stormwater pipes** as lines with a width, on their own layer; **charged pipes** (to tanks) on a separate layer; a general drainage layer drawn as double lines.
2. **Pipe notes** with leaders, e.g. "100 dia. UPVC pipe at 1 in 100", "100 dia. riser to water tank", "100 dia. dropper from water tank".
3. **Pits** as blocks, with a **pit label** block (pit number such as P1, P2; "SPS" for a pump station) and level tags.
4. **Invert levels** ("IL 5.13") as plain text at pits and pipe ends; about 30 of them on this job. Cover levels ("CL") and finished ground levels ("FGL 6.15") likewise.
5. **Floor levels** ("FFL 6.35") on their own layer; pavement level tags ("P 00.00", "RL").
6. **Downpipes** as blocks with a "DP" tag; **floor wastes, inspection openings, grated inspection openings** as blocks.
7. **Water tanks** as blocks by size (3000, 3500, 5000 and 6000 litre on this job) with a "WT" tag and a note giving total litres, litres for detention and litres for reuse.
8. **Trench grates / strip drains** as blocks with a note ("300 wide trench with class C grate"); spoon drain; agricultural drain.
9. **Fall arrows** ("FALL" symbol) and **overland flow path** arrow with its label.
10. **Existing services and assets**: existing council drain, existing pits, sewer (with size note), water, gas, telecom, overhead power, each on its own layer and line type; a "before you dig" block.
11. **Site items**: title boundary, easement, fences, driveway, crossover notes ("new crossover to council requirements"), retaining walls, batters with hatch, trees with tree protection zone and structural root zone circles.
12. **Pavement items**: slab hatches, saw cuts, tool joints, construction joints with tags, mesh note, dwelling and garage names.
13. **Dimensions and leaders**: about 80 leaders and 12 dimensions.
14. **Revision clouds** layer.

## Tables and boxes on the sheet

1. **On-site detention criteria** box (permitted site discharge in l/s, head in mm, and more not yet read).
2. **Site info and calculations** box (site area, total impervious area, and more not yet read).
3. **Pit schedule** block.
4. **Stormwater pump system specifications** box (present on this job).

## Details on the sheet

1. Pit detail (titled by pit, e.g. "P1 pit detail"); "pit 900 max" block.
2. Pipe bedding detail (under concrete and grass).
3. Grated overflow and grated surcharge pipe details; pipe inlet.
4. Slab on ground detail, construction joint detail, saw cut detail, lap splice, re-entrant bars, scabble.
5. Section marks and section titles linking plan to details.
6. General notes (stormwater under slabs, neighbour permission note, and others not yet read in full).

## House standards seen in this one drawing (observed, not yet confirmed as the standard)

1. **Layers named by pen weight and kind**: 18, 20, 25, 35, 50, 70 with CONT / TEXT / HIDDEN / DIMS (e.g. 25TEXT, 35CONT), plus layers named for the thing (STORMWATER PIPE, STORMWATER PIT, DOWNPIPES, EX STORMWATER, SEWER, TPZ, OVERLAND FLOW, FLOOR LEVEL). 313 layers in the file, most of them structural layers or layers from the attached drawings; only 59 carry anything.
2. **One drawing template serves civil and structural**: structural layers (beams, footings, rafters, bracing) sit unused in this civil job.
3. **Text**: two main text styles; most notes sit on 25TEXT, levels on 20TEXT, names on 35TEXT.
4. **Dimension styles**: one office dimension style and one leader style.
5. **Line types** for services: sewer, water, gas, telecom, electricity, agricultural drain.
6. **Blocks**: many are smart blocks with a built-in mask (downpipe, floor waste, inspection opening, strip drain label). About 50 blocks have machine-made names (pasted in from other drawings).
7. **Placeholders in the template**: blank forms such as "IL _____", "FFL __.__", "____ lt water tank" sit in the drawing ready to be copied and filled in.

## Seen as a picture (added 16 Nov 2026, afternoon)

The issued "for council approval" PDF of the same job was turned into pictures and read. Headless plotting of the drawing itself did not work on this PC (the headless engine found no plotters), so the issued PDF was used instead. What the picture added to the lists above:

1. **Sheet layout.** Plan top-left, about half the sheet. General notes column and full civil legend on the right. Pit schedule and detention criteria box directly under the plan. Details across the bottom. Council notes, charged-system notes and a tank installation picture bottom-right beside the title block. A row of coloured warning / read-with boxes along the top edge. Approval stamp box ("For council approval, not for construction") above the title block.
2. **Colour carries meaning on the issued sheet**: new drain pipes blue dashed, charged pipes red dashed, suspended pipes magenta, building footprint light blue, driveway slab grey, tree zones green hatch, architect's background grey. The sheet says "print in full colour".
3. **Pit schedule columns**: pit no., pit size, inlet (from, dia, invert level), outlet (dia, invert level), cover level, depth to outlet, type of lid and remarks. One pit can take two rows when it has two inlets. Three standing notes under it.
4. **Detention criteria box rows**: permitted site discharge (l/s), head (mm), orifice diameter (mm), top water level, volume required, then each storage (each water tank) and a total.
5. **Plan labels**: pipe note on each run (size, material, class, grade, e.g. "150 dia. UPVC SN8 pipe at 1 in 100"), flow arrows, pit tag in a circle, cover level and invert levels in red at each pit, "PP" plastic pits with cover levels, downpipe tags, tank note (total / detention / reuse litres), roof-to-tank areas box, floor levels, finished ground levels, "match existing levels", bench mark box, crossover notes, connection note to the council pipe with an approximate invert level, title boundary lengths and bearings, street name.
6. **Details seen**: orifice pit detail drawn with this job's own numbers (cover level, top water level, baffle height, orifice size, inlet and outlet inverts, chamber sizes); junction pit; pipe bedding under pavement and grass; trench beside footing with angle-of-repose values; services penetration through footing; flexible service pipe through footing; water tank detail with this job's litres and tank size; charged system diagram; driveway slab note, re-entrant bars, lap splice, sawcut.
7. **The same fact, counted on this one sheet**: the control pit's inlet invert appears 5 times (plan, schedule twice, detail twice); its outlet invert 3 times; its cover level 3 times; orifice size, head and top water level twice each; each tank's litres 3 to 4 times. Depth to outlet in the schedule is cover level minus outlet invert, worked by hand.
8. **Assumptions are written as notes**: the connection note says "approx" invert to council's satisfaction, builder to confirm; the council notes say the invert at the discharge point is assumed.

## Across three civil jobs (added 16 Nov 2026, afternoon)

Issued PDFs of all three civil copies were read as pictures (overview of every sheet; close reading of JOB_C only so far). The three are different kinds of job, which is useful:

1. **JOB_C, two units, flat suburban lot.** Detention in two water tanks only, one orifice pit, two pits in the schedule, one sheet. Issued for council approval.
2. **JOB_B, two units, flat suburban lot.** Detention in pipes and pits and tanks together: twin 225 detention pipes at 1 in 200, a 300 detention pipe, eight pits, two pairs of tanks. Also a raingarden, a trench grate, permeable paving, a tree protection zone and a neighbour's footing near the boundary. One sheet. Construction issue.
3. **JOB_A, single house on a large sloping rural lot.** No detention. Twelve pits, long runs, a soakage pit of modular units discharging overflow to a dam, a fire-fighting tank, a reuse tank, existing agricultural drains, silt pits, a sleeper retaining wall, survey contours. The site is too big for one view, so the plan is cut into three part plans with match lines and a 1:500 key plan. Two sheets: plan, then details and notes. Construction issue.

**What stays the same on all three (the fixed frame):** title block and revision list, issue stamp box, top row of warning boxes, general notes, civil works legend (identical on all), disclaimer box, before-you-dig block, charged system notes and tank installation picture, pit schedule with the same columns and the same three standing notes, pipe bedding detail, junction pit detail, services penetration and flexible pipe details, plan title and scale, the same pipe colours and label wording.

**What changes with the job (the moving parts):**
1. **How storage is made up.** The detention criteria box lists every storage by name: each pit, each detention pipe by size and length, each tank, then a total against the volume required (JOB_B: 6.36 provided against 5.35 required). JOB_A has no criteria box at all.
2. **Which details appear.** Orifice pit detail only with detention; raingarden section and filter layer specification only with a raingarden; soakage detail only with soakage; agricultural drain trench detail only with those drains; a second, deeper junction pit detail (900 to 1200) only when a pit is that deep; tank detail drawn to the job's own tank size, litres and orifice.
3. **Which notes appear.** Council's own notes block (JOB_C); tree protection note; neighbour's footing note; retaining wall note; soakage assumptions note.
4. **How the plan is cut.** One view at 1:100, or part plans with match lines and a key plan.
5. **How many sheets.** One when it fits; plan plus a details sheet when it does not.
6. **Pit schedule length and shape.** 2 rows to 20-odd rows; a pit with several inlets takes several rows; remarks carry lid class and silt pit levels.
7. **Issue stage.** Preliminary, for council approval, construction issue: the stamp box, revision row and (it appears) the same drawing reissued at each stage. One job's folder shows the run: set-up, mark-ups, preliminary P1, P2, revision A for council, council approval, construction.

**Elements seen on these two that JOB_C did not have:** detention pipes (twin and single, labelled with size, grade and metres of detention), raingarden symbol with area and section, permeable paving area, trench grate with class, surcharge / overflow pipes with grated caps, soakage unit grid, fire tank, existing agricultural drains, silt pits, part-plan match lines and labels, key plan, retaining wall line with note, contours and spot levels from survey, neighbour's footing hatch with note, bearings and distances on boundaries.

## First observations for planning (mine, to be tested with Tim)

1. **Levels are loose text.** An invert level is typed text beside a pit; nothing ties it to the pit or the pipe. If a level changes, every text is found and retyped by hand. This fits "drawing does not match" being a common cause of rework.
2. **The same number lives in several places**: spreadsheet, criteria box, pit schedule, plan text.
3. **Work is copy-and-fill from template placeholders**, which is fast for a house job (under half a day) and sets the bar the plugin must beat.
