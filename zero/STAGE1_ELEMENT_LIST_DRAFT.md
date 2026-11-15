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

## First observations for planning (mine, to be tested with Tim)

1. **Levels are loose text.** An invert level is typed text beside a pit; nothing ties it to the pit or the pipe. If a level changes, every text is found and retyped by hand. This fits "drawing does not match" being a common cause of rework.
2. **The same number lives in several places**: spreadsheet, criteria box, pit schedule, plan text.
3. **Work is copy-and-fill from template placeholders**, which is fast for a house job (under half a day) and sets the bar the plugin must beat.
