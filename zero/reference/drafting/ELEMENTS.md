# Drawing elements register (E-)

Every thing that appears on a civil sheet, one item each: what it is, exactly how it is drawn today, its text, its measured position, and what it relates to. Re-filed from the evidence on Mon 16 Nov 2026. All measurements are in model units (1 unit = 1 mm of ground; divide text heights by 100 for mm on paper at 1:100). Nothing here is confirmed by the owner as the standard.

E-001 to E-048 follow STUDY_A section 6 items 1 to 48 in the same order. E-049 onward are elements described elsewhere in the evidence.

## How to add to this file

1. Take the number on the last line ("Next free number"). Never reuse or renumber.
2. Copy the eight headings below in the same order and fill every one with what was measured; write "Unknown" or "None" rather than leaving one out.
3. Give objects, layer, colour, linetype, widths, block name and attributes exactly as read from a drawing, and say which coded job (JOB_A/B/C) or office file each came from.
4. Put any new layer, text height, block, offset or wording into the matching file in `reference\standards\` as a new row.
5. Finish with an "Evidence:" line and move "Next free number" on by one.

## Fixed headings for every item

1. **What it is** (drafting words)
2. **How it is drawn today** (objects, layer, colour, linetype, widths, block name, attributes)
3. **Text** (height in model units and mm on paper, justification, mask, wording pattern with real examples)
4. **Standard position / offset as measured** (numbers)
5. **What it relates to but is not tied to today**
6. **Facts it would hold in a one-network drawing** (taken only from what the schedule and sums need)
7. **Appears also in** (schedule, criteria box, detail, legend)
8. **Differences seen between jobs**
9. **Evidence** (written as the closing line)

## Facts true of every element today

1. Nothing is linked: no fields in pipe or level text, no groups, no attributes on pipes, no extended data other than AutoCAD's own. Label, flow arrow, invert text, cover text, pit tag and pit are six unrelated objects per pit end.
2. Work is copy-and-fill: a kit of samples is parked outside the sheet frame (597 of the template's 620 model objects) and copied in.
3. One text style ("STANDARD", Arial Narrow) does everything; nothing is annotative.
4. Decisions that bear on every element: a pipe is one element and a pit is one element, each with editable parts, joined but not merged (D-011 as corrected by D-031); as many grips as today (D-033); a pipe starts on the pit wall in line with the click (D-034); offsets are settings (D-012); one place for standards (D-013); a hand-moved label stays put (D-014); looks and plots identical with no plugin (D-015).

Evidence: STUDY_A section 7 item 13, section 8 items 1 and 12, section 3 item 1, section 1 item 12; DECISIONS D-011 to D-015.

---

## E-001 New stormwater pipe (gravity)

1. **What it is:** A new underground gravity drain between pits, shown as a wide blue dashed band with two thin black edge lines.
2. **How it is drawn today:** TWO objects on top of each other. (a) A polyline on STORMWATER PIPE (colour 150, prints blue; linetype DASHED by layer), global width = the pipe diameter (100, 150, 225, 300 seen), linetype generation off, almost always 2 points, one polyline per run between pits. (b) A multiline on DRAINAGE (colour 6, prints black 0.13), style CLOSED-ENDS (JOB_B, JOB_C) or STANDARD1 (JOB_A), scale = the same diameter, zero (centre) justification, between the same two points. With LTSCALE 1000 the dash is 500 and the gap 250 (5 mm and 2.5 mm on paper). No hatch, no special linetype.
3. **Text:** None on the pipe itself. See E-006 (label), E-007 (flow arrow), E-014 (invert levels).
4. **Standard position / offset as measured:** Pipe ends: at a 350 pit the polyline stops 175 from the pit insertion point (the pit edge); at larger pits 43 to 400; at a downpipe it stops on the downpipe point (0). So pipes run edge to edge, not centre to centre, but not consistently (JOB_C).
5. **What it relates to but is not tied to today:** The pit at each end; its label; its flow arrow; an invert text at each end; its schedule cells; its multiline (the polyline and its multiline are two unrelated objects). Drawn direction says nothing about flow.
6. **Facts it would hold in a one-network drawing:** From pit and to pit; diameter; material and class; length; upstream and downstream invert; grade (S-008); whether it is a detention pipe; cover at each end (S-010).
7. **Appears also in:** Pit schedule (inlet "from / dia / invert", outlet "dia / invert": E-040); legend (sample pipes: E-039); long section rows (E-062).
8. **Differences seen between jobs:** Multiline on exactly the same end points as the polyline on 11 of 15 pipes in JOB_C and 25 of 33 in JOB_B; none match within 5 mm in JOB_A (the multilines were drawn separately). JOB_A has several widths of 149.9999999999999 (a copied-and-scaled pipe). Multiline style CLOSED-ENDS (JOB_B/C) against STANDARD1 (JOB_A).

Evidence: STUDY_A section 6 item 1, section 7 items 1 to 4 and 13, section 2 civil layers 1 and 6, section 9 item 5.

## E-002 Charged pipe

1. **What it is:** A pipe that runs full under head, usually from a downpipe to the water tank; prints red dashed.
2. **How it is drawn today:** The same pair as E-001, with the polyline on STORMWATER CHARGED PIPE (colour 10, prints red; DASHED). Width 100 (one 150 on JOB_A). Can have 3 to 6 points. Usually runs from a downpipe to the tank symbol, not pit to pit.
3. **Text:** Label as E-006: "100 DIA. UPVC PIPE CHARGED TO WATER TANK", "150 DIA. UPVC CHARGED PIPE TO WT". On JOB_A: "...CHARGED TO WATER TANK or SUSPENDED UNDER ...".
4. **Standard position / offset as measured:** Not measured separately from E-001.
5. **What it relates to but is not tied to today:** The downpipes it collects; the tank it feeds; the roof area going to that tank (E-021).
6. **Facts it would hold in a one-network drawing:** Which downpipes feed it and which tank it feeds; diameter; material; roof area carried (for S-018 and E-021).
7. **Appears also in:** Legend; charged system notes and diagram (E-038, E-047).
8. **Differences seen between jobs:** One 150 wide on JOB_A; otherwise 100.

Evidence: STUDY_A section 6 item 2, section 2 civil layer 2, section 6 item 6.

## E-003 Suspended pipe

1. **What it is:** A pipe hung under a slab or floor rather than buried; prints magenta dashed.
2. **How it is drawn today:** Layer STORMWATER SUSPENDED PIPE exists (colour 211, prints magenta, DASHED). Not drawn on any of the three plans studied; only in the legend. On JOB_A the wording of a charged pipe label carries it. The layer is in the civil template but not in the master.
3. **Text:** "...CHARGED TO WATER TANK or SUSPENDED UNDER ..." (JOB_A).
4. **Standard position / offset as measured:** Not measured (none drawn).
5. **What it relates to but is not tied to today:** Unknown (none drawn). CIV-11's sheet has suspended pipes under the slab; not measured.
6. **Facts it would hold in a one-network drawing:** As E-001; Unknown beyond that.
7. **Appears also in:** Legend.
8. **Differences seen between jobs:** None drawn on JOB_A/B/C.

Evidence: STUDY_A section 6 item 3, section 2 civil layer 3 and "Standard versus invented" item 1; STUDY_B section 1k item 5.

## E-004 Detention pipe

1. **What it is:** A large pipe laid nearly flat to store water; drawn as an ordinary pipe and known as detention only from its label.
2. **How it is drawn today:** No special layer or object. Ordinary STORMWATER PIPE polylines of width 225 (four on JOB_B) and 300 (one) with the usual multiline. "Twin" pipes are two polylines side by side.
3. **Text:** Label as E-006 with a second line: "2 x 225 DIA. STORMPRO PIPES AT 1 IN 200" / "9m DETENTION". CIV-04 runs labelled 19 m, 8 m, 6 m.
4. **Standard position / offset as measured:** As E-001 and E-006.
5. **What it relates to but is not tied to today:** Its line in the criteria box storage list; the storage sum; the pits at its ends.
6. **Facts it would hold in a one-network drawing:** Everything in E-001, plus: is detention (yes); number of pipes side by side; storage volume (S-004); maker's inside and outside diameters (S-013).
7. **Appears also in:** Detention criteria box (pipe by size and length: E-041); computations storage list.
8. **Differences seen between jobs:** Only JOB_B of the three has them (225 and 300 wide). Grades seen across jobs: 1 in 150, 1 in 190, 1 in 200 (L-001).

Evidence: STUDY_A section 6 item 4, section 9 item 10; STUDY_B section 1d item 7; ELEMENT_LIST "Across three civil jobs".

## E-005 Existing drain

1. **What it is:** A council or other existing drain; prints as a grey dashed band.
2. **How it is drawn today:** A polyline on EX DRAIN HATCH (colour 61, black at 50% screen; linetype PHANTOM) with width = diameter (225 on JOB_C), object linetype scale 0.4, plus a multiline on EX STORMWATER (colour 9, grey; HIDDEN). Stub lines of existing drains also on EX STORMWATER.
3. **Text:** Ordinary MTEXT: "225 DIA COUNCIL STORMWATER PIPE". On CIV-01 the existing council drains are labelled with "depth to be confirmed".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The connection note (E-058); the discharge point; existing pits (E-065).
6. **Facts it would hold in a one-network drawing:** Diameter; owner (council); invert where known, and whether that invert is given or assumed (D-030: no set way of showing what was assumed).
7. **Appears also in:** Legend; connection note; pit schedule row for an existing council pit on an outfall sheet.
8. **Differences seen between jobs:** Measured on JOB_C only.

Evidence: STUDY_A section 6 item 5, section 2 civil layers 8 and 9; STUDY_B section 1a item 5.

## E-006 Pipe label

1. **What it is:** The note along a pipe giving size, material, class and grade.
2. **How it is drawn today:** One MTEXT, layer 25TEXT (colour 7), rotated to the pipe. Short runs get a two-line label set off to the side with a pointer leader (E-050).
3. **Text:** Height 250 (2.5 mm on paper); top-centre justified (some top-left when broken onto two lines); background mask ON. Wording pattern: "<dia> DIA. <material> [<class>] PIPE AT 1 IN <grade>". Real examples: "100 DIA. UPVC PIPE AT 1 IN 100"; "150 DIA. UPVC SN8 PIPE AT 1 IN 100"; "100 DIA. SEWER CLASS PIPE AT 1 IN 100"; "100 DIA. UPVC PIPE CHARGED TO WATER TANK"; "150 DIA. UPVC CHARGED PIPE TO WT"; "... AT 1 IN 100 MIN."; "2 x 225 DIA. STORMPRO PIPES AT 1 IN 200".
4. **Standard position / offset as measured:**
   1. Template standard: nearest edge of the label text 73 to 74 clear of the pipe EDGE (not centreline) on all parked samples; for a 100 pipe that is a text edge 123 from the centreline.
   2. As drawn (clear gap from pipe edge): JOB_A, 8 labels: 76, 76, 76, 80, 83, 95, 130, 152. JOB_B, 16 labels: 60, 62, 76, 78, 78, 80, 81, 92, 95, 98, 107, 138, 141, 157, 171 and one at 761. JOB_C, 8 labels: 73, 109, 115, 117, 155, 183, 196 and one at 1129. Reading: about 75 to 100 clear, moved out to 110 to 200 when something is in the way.
   3. Side: above the pipe on 36 and below on 23 of 59 parallel labels. No fixed side.
   4. Rotation: within 0.2 degrees of the pipe, turned to read left-to-right or bottom-to-top (a pipe drawn at -90 gets text at +90).
   5. Along the run: insertion point (middle of the text) between 0.41 and 0.72 of the run (JOB_B, JOB_C).
   6. Not parallel: 2 or 3 labels per job are horizontal two-line labels (top-left) placed 400 to 2000 away from a short or crowded run, with a pointer leader.
   7. Conflict: the August study measured "about 139 off a 150 pipe in clear space, about 406 when crowded, about 592 off a 525 pipe" (it does not say whether from the centreline or the edge), against 73 to 74 clear of the pipe edge in the template. Settled in principle by D-012 (the offset is a setting, the same everywhere unless moved for a clash); the value itself is not ruled.
5. **What it relates to but is not tied to today:** Its pipe (size, grade from the inverts and length). Nothing ties them: change the pipe and the label must be retyped.
6. **Facts it would hold in a one-network drawing:** None of its own: it reads the pipe's diameter, material, class and grade. It keeps only its hand-moved position (D-014).
7. **Appears also in:** Legend sample pipes carry labels; master pipe-strip blocks hold a label above and below.
8. **Differences seen between jobs:** Gaps as listed above; wording carries "MIN." on some.

Evidence: STUDY_A section 6 item 6, section 7 items 5 to 10 and 13, section 3 items 3.1, 5 and 6; DIGEST section 1 item 3; DECISIONS D-012, D-014.

## E-007 Flow arrow

1. **What it is:** A short arrow beside a pipe showing which way the water runs.
2. **How it is drawn today:** A separate 2-point LEADER (the old leader object, never a multileader) on 25DIMS (colour 7), 750 long, default closed filled arrowhead 300 long, parallel to the pipe. Not linked to the pipe. Most carry the same copied per-object overrides (scale 100, arrow 3, gap 1).
3. **Text:** None.
4. **Standard position / offset as measured:** 150 to 990 off the centreline (typically 170 to 390), on either side. In JOB_C 8 of the 13 parallel arrows sit in the first or last quarter of the run. 7 of the 13 point WITH the direction the pipe was drawn and 6 AGAINST it. 52 of the 82 leaders in JOB_C are exactly 750 long.
5. **What it relates to but is not tied to today:** The pipe's direction of fall (higher invert to lower invert). The older study: "direction should come from levels, not the direction the line was drawn"; it may sit on the other side from the label.
6. **Facts it would hold in a one-network drawing:** None of its own: direction read from the pipe's inverts; its own hand-moved position.
7. **Appears also in:** Master pipe-strip blocks (four flow-arrow leaders each); the "LABELS CIVIL" tool palette.
8. **Differences seen between jobs:** None recorded beyond position.

Evidence: STUDY_A section 6 item 7, section 4 items 4 to 7, section 7 item 14; DIGEST section 1 item 4.

## E-008 Pit (all kinds)

1. **What it is:** The plan symbol of a stormwater pit of any size or type.
2. **How it is drawn today:** ONE dynamic block "Stormwater Pit", inserted on layer STORMWATER (colour 9) at scale 1. One visibility list with 16 states: 350x350 Grated pit, 350x350 Junction pit, 450x450 Grated Pit, 450x450 junction pit, 600x600 Grated Pit, 600x600 Junction, 600x900 Grated Pit, 600x900 Junction, 750x750 Grated Pit, 900x900 Junction Pit, 900x900 Grated Pit, 600x1200 Detention Pit, SPS Vertical, SPS Horizontal, Enviss Sentinel, Settling Tank. No attributes. Inside, per state: a square outline polyline on PITS HIDDEN (colour 7, HIDDEN), a mask (wipeout) on STORMWATER PIT, then either a grate hatch (user-defined lines on GRATED TRENCH, colour 9) or two diagonal cross lines on STORMWATER PIT forced to colour 9. The 59 objects of all states are stored in every copy; only 3 to 6 are visible.
3. **Text:** None in the block. See E-012 (tag), E-013 (cover level), E-014 (invert levels).
4. **Standard position / offset as measured:** Usually rotation 0 (square to the sheet). The copy used for the small plastic pits shows a 583 square although pipes stop 175 from its centre; another copy shows 750 square.
5. **What it relates to but is not tied to today:** Its tag; its cover level text; one invert text per connected pipe end; the pipes that stop at its edge; its schedule row(s); for a detention pit, its line in the criteria box.
6. **Facts it would hold in a one-network drawing:** Number; type; size; cover level; each connection's invert (each inlet's "from", dia and invert; the outlet's dia and invert); depth to outlet (S-011); lid type and remarks; whether it holds detention water (S-005). A pit keeps its identity when its tag changes.
7. **Appears also in:** Pit schedule (E-040); criteria box storage list; junction pit and orifice pit details (E-047); legend.
8. **Differences seen between jobs:** Rotated to the pipe on some JOB_A pits (147, 207, 209 degrees); square to the sheet on JOB_B/C. The pit block drawing shipped in the two plug-in bundles differs in size between them.

Evidence: STUDY_A section 6 item 8, section 2 civil layers 12 to 15, section 9 item 7, section 10 item 2; MODEL_NOTES "What it teaches" item 3; STUDY_C section 2D item 7.

## E-009 Junction pit, grated pit and plastic pit

1. **What it is:** The three everyday pit types as they read on the plan: a cross for a junction (solid lid), a line hatch for a grated pit, and "PP" beside a small grated pit for a plastic pit.
2. **How it is drawn today:** Junction = the cross; grated = the line hatch; both are states of the block in E-008. A plastic pit is the 350 grated state with a loose text "PP" beside it. Nothing in the block says "plastic".
3. **Text:** "PP": height 200 (2.0 mm), MTEXT on 25TEXT, often as the first line of the cover level text ("PP" / "CL 5.65").
4. **Standard position / offset as measured:** As E-013 for the "PP" / cover text.
5. **What it relates to but is not tied to today:** The pit type column of the schedule ("all pits scheduled including plastic ones" is a council request).
6. **Facts it would hold in a one-network drawing:** Type (junction, grated, plastic) as one fact of the pit in E-008.
7. **Appears also in:** Pit schedule; junction pit detail; legend; "PP" tags on the LABELS CIVIL palette.
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 6 item 9, section 3 item 3.3; STUDY_B section 4 item 1; STUDY_C section 2B.

## E-010 Orifice / control pit

1. **What it is:** The two-chamber pit with a baffle wall and orifice that controls the outflow of a detention system.
2. **How it is drawn today:** Still the block in E-008, in a state that shows a crossed chamber and a grated chamber side by side inside a dashed outline, 1650 x 900 overall (pit P1 on JOB_C). Its real description (baffle, orifice, levels) is in the detail and the schedule, not in the symbol.
3. **Text:** Tag, cover and invert texts as other pits.
4. **Standard position / offset as measured:** 1650 x 900 overall (JOB_C). Usually near the discharge point at the low end of the site.
5. **What it relates to but is not tied to today:** The criteria box (head, orifice, top water level); the orifice pit detail drawn with this job's numbers; the connection to the council system.
6. **Facts it would hold in a one-network drawing:** As E-008, plus: top water level; baffle (plate) height; orifice diameter; orifice invert (20 above the outlet invert, inlet 20 above that: S-025); chamber sizes; lid class of each chamber.
7. **Appears also in:** Criteria box (E-041); orifice pit detail (E-047); pit schedule.
8. **Differences seen between jobs:** JOB_A has none (no detention). One council uses a single chamber with a plate (L-007).

Evidence: STUDY_A section 6 item 10; STUDY_B section 3 item 7; ELEMENT_LIST "Seen as a picture" items 6 and 7.

## E-011 Older pit block

1. **What it is:** An earlier pit symbol kept in the office master drawing.
2. **How it is drawn today:** Block "PIT BLOCK 3" in the master: a visibility list (GRATED PIT, SOLID PIT, SPS GRATED PIT, SPS SOLID PIT, DETENTION PIT) plus stretch distances X_WIDTH, Y_WIDTH, SPS_RADIUS. Not used on the three jobs.
3. **Text:** None recorded.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Not applicable (unused).
6. **Facts it would hold in a one-network drawing:** As E-008.
7. **Appears also in:** The current BLOCKS CIVIL tool palette lists both "stormwater pit" and "pit block".
8. **Differences seen between jobs:** Not on any job read.

Evidence: STUDY_A section 6 item 11, section 9 "Between the jobs and MASTER" item 3; STUDY_C section 2B.

## E-012 Pit tag

1. **What it is:** The pit number in a circle (P1, P2 ...).
2. **How it is drawn today:** Block "PIT LABEL" inserted on STORMWATER, scale 1. One attribute, tag "FB", value "P1", "P2"... on 35TEXT (colour 2). The circle is a 101-point mask (wipeout) on 50CONT whose frame prints (wipeout frames are switched on in the drawing). The block also carries hidden leftover lines on structural layers BEAMS and COLUMN UNDER: it is a re-used structural beam tag (FB = footing beam).
3. **Text:** Attribute height 350 (3.5 mm); the "SPS" placeholder is 300. Wording "P<n>"; "SPS" for a pump station.
4. **Standard position / offset as measured:** 850 to 1540 from the pit insertion point, on any side, with nothing connecting them (JOB_B, JOB_C).
5. **What it relates to but is not tied to today:** Its pit; the pit number column of the schedule; "from" cells of other schedule rows that name it.
6. **Facts it would hold in a one-network drawing:** None of its own: it shows the pit's number. Renaming a pit must not make a new pit or break its pipes.
7. **Appears also in:** Pit schedule; criteria box storage lines by pit name; detail titles ("P1 pit detail").
8. **Differences seen between jobs:** None recorded. A real job once had a schedule with two rows both "P1".

Evidence: STUDY_A section 6 item 12, section 3 item 3.4, section 8 item 8; MODEL_NOTES "What it teaches" item 3; DIGEST section 3 item 8.

## E-013 Cover level

1. **What it is:** The lid (surface) level of a pit, written beside it.
2. **How it is drawn today:** Loose MTEXT on 25TEXT, usually rotated +45 or -45 degrees. (One on JOB_B is plain TEXT on 18TEXT colour 10.)
3. **Text:** Height 200 (2.0 mm); mask on; justification varies (top left, bottom right, top right, middle right). Wording "CL 5.35"; or two lines "PP" / "CL 5.65" for a plastic pit. Parked placeholders "CL _____", "CL ____".
4. **Standard position / offset as measured:** 560 to 1290 from the pit insertion point (JOB_C); not related to a pipe.
5. **What it relates to but is not tied to today:** Its pit; the cover level cell of the schedule; depth to outlet; the orifice pit detail; finished ground or survey levels it was taken from.
6. **Facts it would hold in a one-network drawing:** None of its own: it shows the pit's cover level. (Cover levels are normally fixed on a tight site: D-018.)
7. **Appears also in:** Pit schedule (E-040); orifice pit detail. On JOB_C the control pit's cover level appears 3 times.
8. **Differences seen between jobs:** One plain TEXT on 18TEXT colour 10 on JOB_B. Conflict (colour): the Stage 1 picture reading says "cover level and invert levels in red at each pit"; STUDY_A puts cover levels on 25TEXT (colour 7, prints black) and only invert levels on a red layer. Not settled.

Evidence: STUDY_A section 6 item 13, section 3 items 3.3, 5 and 6, section 7 item 12, section 8 item 1; ELEMENT_LIST "Seen as a picture" items 5 and 7.

## E-014 Invert level

1. **What it is:** The level of the inside bottom of a pipe at a pipe end, written beside the pipe.
2. **How it is drawn today:** Loose text, one per pipe end, rotated to the pipe it belongs to. JOB_C: MTEXT on 20TEXT (colour 10, prints red), mask on (four are plain TEXT with no mask). JOB_A and JOB_B: MTEXT on 18TEXT with colour forced to 1, mask on.
3. **Text:** Height 180 (1.8 mm). Bottom-left justified in JOB_C; top-left in JOB_A and JOB_B. Wording "IL 5.13". Parked placeholder "IL _____". Prints red.
4. **Standard position / offset as measured:** Parallel to its pipe; clear gap between the pipe edge and the text 22 to 88 (median 49 to 54 in all three jobs); placed 170 to 900 along from the pipe end; on either side of the pipe.
5. **What it relates to but is not tied to today:** The pipe end and the pit it enters or leaves; the schedule's inlet and outlet invert cells; the pipe's grade in its label; the orifice pit detail.
6. **Facts it would hold in a one-network drawing:** None of its own: it shows the invert of one pipe end at one pit. (The council connection invert is normally fixed on a tight site: D-018. Which inverts change when a pit moves depends on the design: D-016.)
7. **Appears also in:** Pit schedule; orifice pit detail; long section. On JOB_C the control pit's inlet invert appears 5 times (plan, schedule twice, detail twice) and its outlet invert 3 times. About 30 invert texts on that job.
8. **Differences seen between jobs:** Layer, colour and justification differ between JOB_C and JOB_A/B as above.

Evidence: STUDY_A section 6 item 14, section 7 item 11, section 3 items 3.2 and 5, section 9 item 3; ELEMENT_LIST "On the plan" item 4 and "Seen as a picture" item 7.

## E-015 Downpipe

1. **What it is:** The point where a roof downpipe meets the ground drainage; a small red-filled circle tagged "DP".
2. **How it is drawn today:** Dynamic block "DOWNPIPE DYNAMIC WITH MASK", scale 1, inserted on DOWNPIPES (JOB_C) or STORMWATER (JOB_A, JOB_B). Contents: a circle radius 175 on DOWNPIPES (colour 2), a solid hatch on DOWNPIPES HATCH (colour 10, red), a helper circle on DEFPOINTS, and one attribute tag "DP" (prompt "NAME", default "DP", layer DOWNPIPE TXT, colour 7). Dynamic parts: a point with a move action so the "DP" text can be dragged, and two flips. Where a pipe leaves a downpipe there is also a tiny plain block (machine name, circle radius 75 with solid red fill, on layer 0) marking the pipe end.
3. **Text:** Attribute height 250 (2.5 mm), masked. Wording "DP".
4. **Standard position / offset as measured:** A pipe stops on the downpipe point (0 gap).
5. **What it relates to but is not tied to today:** The pipe (gravity or charged) it feeds; the tank it ends up at; the roof area it carries; a schedule row's "from" cell (downpipes appear as "from" sources, not as pits).
6. **Facts it would hold in a one-network drawing:** Its tag; what it feeds (pipe or tank); roof area where the roof-to-tank box needs it.
7. **Appears also in:** Pit schedule "from" cells; legend; BLOCKS CIVIL tool palette; a block drawing in the civil plug-in bundle.
8. **Differences seen between jobs:** Inserted on DOWNPIPES (JOB_C) against STORMWATER (JOB_A/B). JOB_B has a second spelling of the layer, "DOWN PIPES".

Evidence: STUDY_A section 6 item 15, section 2 civil layer 17 and "Standard versus invented" item 3, section 9 item 4; DIGEST section 1 item 6; MODEL_NOTES "What it teaches" item 5.

## E-016 Inspection opening

1. **What it is:** A capped access point on a pipe ("IO"), and its grated version ("GIO").
2. **How it is drawn today:** Block "INSPECTION OPENING DYNAMIC WITH MASK": same build as the downpipe (E-015) but the letters are fixed MTEXT, no attribute. Grated version "GRATED INSPECTION OPENING DYNAMIC WITH MASK": the floor-waste symbol at scale 1.5 with fixed text.
3. **Text:** "IO" height 250 (2.5 mm), masked. "GIO" height 200 (2.0 mm).
4. **Standard position / offset as measured:** Not measured. Rules place them at changes of direction, each side of a pipe under a garage, and at 135 degree bends on charged lines (L-003, L-014).
5. **What it relates to but is not tied to today:** The pipe it sits on; a schedule "from" cell.
6. **Facts it would hold in a one-network drawing:** Type (IO or GIO); the pipe it is on.
7. **Appears also in:** Legend; tool palette; plug-in bundle block.
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 6 item 16, section 3 item 3.5; STUDY_B section 3 items 3 and 14; GUIDEBOOK_NOTES "Elements" item 18.

## E-017 Floor waste

1. **What it is:** A small grated floor outlet ("FW").
2. **How it is drawn today:** Block "FLOOR WASTE DYNAMIC WITH MASK": circle radius 100 on FLOOR WASTE (colour 7), HONEY pattern hatch scale 5, fixed MTEXT, same move and flip parts as the downpipe.
3. **Text:** "FW" height 250 (2.5 mm), masked.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pipe or strip drain it feeds; a schedule "from" cell.
6. **Facts it would hold in a one-network drawing:** Type; what it feeds.
7. **Appears also in:** Legend; tool palette; plug-in bundle block; basement plans.
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 6 item 17, section 2 civil layer 18; DIGEST section 1 item 6, section 2 item 2.

## E-018 Overflow and related letter symbols

1. **What it is:** The family of small lettered symbols: overflow, grated overflow, grated surcharge pipe, pipe from above, pipe to below.
2. **How it is drawn today:** Blocks "OVERFLOW" ("OF"), "GRATED OVERFLOW" ("GOF"), "GRATED SURCHARGE PIPE" ("GSP"), "FROM ABOVE" ("F/A"), "TO BELOW" ("T/B"): all the same pattern as E-016 and E-017 with different fixed letters.
3. **Text:** "OF", "F/A", "T/B" height 250 (2.5 mm); "GSP", "GOF" height 200 (2.0 mm); masked.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pipe or tank it serves; details "grated overflow" and "grated surcharge pipe" (E-047).
6. **Facts it would hold in a one-network drawing:** Type; what it is on.
7. **Appears also in:** Legend; details; tool palette; schedule "from" cells for overflows.
8. **Differences seen between jobs:** JOB_B uses OVERFLOW three times.

Evidence: STUDY_A section 6 item 18, section 3 item 3.5; ELEMENT_LIST "Details on the sheet" item 3; DIGEST section 1 item 6.

## E-019 Water tank

1. **What it is:** The plan outline of a rainwater tank, tagged "WT".
2. **How it is drawn today:** Plain (not dynamic) blocks named by size: "3000 LITRE TANK", "3500 LITRE TANK", "5000 LITRE TANK", "6000 LITRE TANK". Contents: a rounded outline polyline on 35CONT (the 3500 is 2250 x 650), a gradient-solid hatch on HATCH WATER (colour 150), one attribute tag "WT" (default "DP", shown value "WT", layer 25TEXT). Inserted on 25DIMS or BLOCKS (whichever layer was current).
3. **Text:** Attribute height 250 (2.5 mm). Wording "WT".
4. **Standard position / offset as measured:** Not measured. 3500 litre footprint 2250 x 650.
5. **What it relates to but is not tied to today:** The charged pipes in; the outlet and overflow; its tank note (E-020); its line in the criteria box; the roof area going to it (E-021); the tank detail drawn to this job's size, litres and orifice.
6. **Facts it would hold in a one-network drawing:** Total litres; detention litres; reuse litres; tank orifice (30 mm: D-024); inlet, outlet and overflow connections; roof area connected; footprint and model.
7. **Appears also in:** Tank note; criteria box; tank detail and installation diagram (E-047); roof-to-tank areas box.
8. **Differences seen between jobs:** Inserted on 25DIMS in JOB_C and BLOCKS in JOB_A/B. JOB_A also has a fire-fighting tank and a layer "WATER TANK" not in the template. The old plug-in stored tanks as pits, noted as a workaround.

Evidence: STUDY_A section 6 item 19, section 8 item 7, section 2 "Standard versus invented" item 3; DIGEST section 7 item 3; ELEMENT_LIST "Across three civil jobs" item 3.

## E-020 Tank note

1. **What it is:** The three-line note on each tank giving total litres, detention litres and reuse.
2. **How it is drawn today:** Loose MTEXT, layer 25TEXT, typed by hand on each tank. JOB_A has a longer one on layer 25CONT.
3. **Text:** Height 250 (2.5 mm), mask on, three lines: "3000 lt WATER TANK" / "1000 lt FOR DETENTION" / "2000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE". CIV-04: "1100 lt for detention". Parked placeholder "____ lt water tank".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Its tank; the criteria box tank line; the tank detail; the STORM report.
6. **Facts it would hold in a one-network drawing:** None of its own: it reads the tank's total, detention and reuse litres.
7. **Appears also in:** Criteria box; tank detail. Each tank's litres appear 3 to 4 times on JOB_C.
8. **Differences seen between jobs:** JOB_A's note is longer and on 25CONT. Real jobs have had tank splits differing between plan and detail on the same stamped sheet.

Evidence: STUDY_A section 6 item 20, section 8 item 7; ELEMENT_LIST "House standards" item 7 and "Seen as a picture" item 7; DIGEST section 3 item 8.

## E-021 Roof-to-tank areas box

1. **What it is:** A small box listing how much roof drains to each tank.
2. **How it is drawn today:** One loose MTEXT with a rectangle polyline round it (JOB_C).
3. **Text:** One line per roof: "ROOF 1 DISCHARGE TO WATER TANK 1 = 164m2".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The tanks; the STORM report's roof areas; the roof hatch (E-061).
6. **Facts it would hold in a one-network drawing:** None of its own: roof area to each tank, counted once.
7. **Appears also in:** STORM report; roof hatch legend.
8. **Differences seen between jobs:** Areas seen: 164 and 164 (CIV-03 / JOB_C); 118.6 (CIV-02); 188.2 and 221.9 (CIV-04).

Evidence: STUDY_A section 6 items 21 and 42; STUDY_B section 1b item 4, 1c item 7, 1d item 7.

## E-022 Trench grate

1. **What it is:** A long grated drain across a driveway or garage door.
2. **How it is drawn today:** Dynamic block "TRENCH GRATE" on layer TRENCH GRATE (colour 9): outline polyline, a mask, two ANSI31 hatches (scale 31.5); two stretch distances (length and width). Parked samples are stretched to 100, 150, 200, 300 wide by 1600 or 3100 long, each with a parked "CL _____" text. JOB_B uses a different pasted block ("200 TRENCH GRATE").
3. **Text:** A note such as "300 wide trench with class C grate"; a cover level text as E-013.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pit or pipe it falls to; its cover level; its lid class.
6. **Facts it would hold in a one-network drawing:** Width; length; grate class; level; what it drains to.
7. **Appears also in:** Legend; tool palette; plug-in bundle block.
8. **Differences seen between jobs:** JOB_B's pasted "200 TRENCH GRATE" block against the template's dynamic block.

Evidence: STUDY_A section 6 item 22, section 2 civil layer 16; ELEMENT_LIST "On the plan" item 8; MODEL_NOTES "What it teaches" item 5.

## E-023 Spoon drain

1. **What it is:** A shallow dished surface drain.
2. **How it is drawn today:** A multiline on SPOON DRAIN (style CLOSED, scale 100) plus the block "STRIP DRAIN LABEL DYNAMIC" (a leader and the text "SD", rotate and flip grips). Only parked on the three jobs. Layer colour 10 in jobs and template, colour 1 in the master.
3. **Text:** "SD" height 180 (1.8 mm).
4. **Standard position / offset as measured:** Not measured (parked only).
5. **What it relates to but is not tied to today:** Fall arrows into it; the pit or floor waste it falls to.
6. **Facts it would hold in a one-network drawing:** Width; length; fall; what it drains to.
7. **Appears also in:** Legend; spoon drain details in the detail library; basement plans.
8. **Differences seen between jobs:** Parked only on JOB_A/B/C. Layer colour differs between master (1) and template (10).

Evidence: STUDY_A section 6 item 23, section 2 civil layer 19; DIGEST section 2 items 2 and 3.

## E-024 Agricultural drain

1. **What it is:** A slotted subsoil drain along walls or behind retaining walls.
2. **How it is drawn today:** Plain LINEs on AGI DRAIN (colour 2, linetype AG_LINE, which writes "AG" along the line); 8 lines on JOB_A, 1 on JOB_B. No width, no walls. Object linetype scale 0.7 on the placeholder.
3. **Text:** The "AG" is part of the linetype.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The 100 pipe or silt pit it joins; no groundwater to the kerb (L-023).
6. **Facts it would hold in a one-network drawing:** Length; what it drains to.
7. **Appears also in:** Agricultural drain trench detail (only on jobs with those drains); legend.
8. **Differences seen between jobs:** JOB_A 8 lines (existing agricultural drains), JOB_B 1, JOB_C none. The old plug-in stored agricultural drains as pits, noted as a workaround.

Evidence: STUDY_A section 6 item 24, section 2 civil layer 20, section 5 item 11; DIGEST section 2 item 5, section 7 item 3.

## E-025 Raingarden

1. **What it is:** A planted filter bed that treats driveway water.
2. **How it is drawn today:** No block. A spline and a closed polyline on DRAINAGE with a solid hatch forced to colour 201, plus typed notes (JOB_B). The section and filter specification are pasted detail blocks.
3. **Text:** Typed notes giving the area (CIV-08's sheet labels 3.5 square metres).
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The paved area it treats; the STORM report's raingarden area; its overflow pipe.
6. **Facts it would hold in a one-network drawing:** Area; type; catchment treated; overflow connection. How the area is chosen: Unknown (Q-005).
7. **Appears also in:** Raingarden section and filter layer specification (E-047); STORM report; legend.
8. **Differences seen between jobs:** Only JOB_B of the three. The layer STORMWATER PIPE CHARGED TO RAINGARDEN is in the template only and unused.

Evidence: STUDY_A section 6 item 25, section 2 civil layer 4; STUDY_B section 1h items 6 and 7; DIGEST section 2 item 6.

## E-026 Overland flow arrow

1. **What it is:** A broad arrow showing the path of surface water in a big storm.
2. **How it is drawn today:** Block "OVERLAND FLOW PATH" on OVERLAND FLOW (colour 34, prints own colour at 30%): one arrow-shaped polyline 1614 x 576 with a solid hatch. Label is a loose MTEXT. Parked on JOB_C.
3. **Text:** Label height 180 (1.8 mm).
4. **Standard position / offset as measured:** 1614 x 576 arrow. Placement not measured.
5. **What it relates to but is not tied to today:** Surface levels and falls; the 1 in 100 storm note.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Legend (councils ask for overland flow arrows and legend).
8. **Differences seen between jobs:** Parked only on JOB_C.

Evidence: STUDY_A section 6 item 26, section 2 civil layer 21; GUIDEBOOK_NOTES "Elements" item 15; STUDY_B section 4 item 1.

## E-027 Fall arrow

1. **What it is:** A short arrow with the word FALL showing which way a paved surface slopes.
2. **How it is drawn today:** Two generations. (a) "FALL SYMBOL" dynamic block (JOB_C, inserted at X scale -1 on 25CONT, and a machine-named copy of it on 25DIMS): a leader, a helper polyline, attribute "FALL" (default "FALL") and attribute "FALL_GRADE" (default blank); rotate, stretch and flip grips. (b) "Fall" (JOB_B, master; inserted at scale 0.92): a leader and fixed TEXT "FALL".
3. **Text:** (a) attributes height 200 (2.0 mm). (b) fixed text height 250 (2.5 mm). Wording "FALL".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Pavement levels (E-029); the pit or grate the surface falls to.
6. **Facts it would hold in a one-network drawing:** Direction; grade where given.
7. **Appears also in:** Tool palette ("fall label"); plug-in bundle block.
8. **Differences seen between jobs:** "FALL SYMBOL" with attributes (JOB_C) against older "Fall" with fixed text at scale 0.92 (JOB_B). Inserted on 25CONT and 25DIMS in the same job.

Evidence: STUDY_A section 6 item 27, section 9 item 6, section 8 item 7.

## E-028 Floor level

1. **What it is:** The finished floor level of a dwelling or garage.
2. **How it is drawn today:** Loose MTEXT on FLOOR LEVEL (colour 7). No block. The layer is in the template but not in the master.
3. **Text:** Height 250 (2.5 mm), underlined, bottom-centre, no mask. Wording "FFL 6.05", "FFL 6.35". Parked placeholder "FFL __.__".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The architect's floor levels; top water level at least 300 below habitable floors (L-011).
6. **Facts it would hold in a one-network drawing:** The level, and where it came from (architect).
7. **Appears also in:** Not recorded.
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 6 item 28, section 3 items 3.7, 5 and 6; ELEMENT_LIST "On the plan" item 5.

## E-029 Finished ground level and pavement level tags

1. **What it is:** A spot level on finished ground or paving, with a small cross tick.
2. **How it is drawn today:** Dynamic block (machine name only, no proper name) with attribute tag "LEVEL" (default "P__.__", on 20TEXT, colour 10), a small X tick (two 141-long lines) and move grips. A second block family "RL LEVEL" / "RL___" (attribute "RL__.__", with a filled triangle) is parked. Layer PAVEMENT LEVELS (colour 7) is used in the legend only on these jobs.
3. **Text:** "LEVEL" attribute height 200 (2.0 mm); values typed "FGL 6.15". "RL" attribute height 250 (2.5 mm). Parked samples "P__.__", "P00.00", "RL__.__", "NGL ___", "00.00".
4. **Standard position / offset as measured:** Not measured. Councils ask for spot levels at corners and near pits.
5. **What it relates to but is not tied to today:** Survey levels; pit cover levels; fall arrows.
6. **Facts it would hold in a one-network drawing:** The level; its kind (finished ground, pavement); where it came from.
7. **Appears also in:** Tool palette (RL tags, pit level tags); plug-in bundle block (spot level).
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 6 item 29, section 2 civil layers 23 and 24, section 8 item 1; GUIDEBOOK_NOTES "Elements" item 17.

## E-030 Existing levels, bench mark, title boundary, bearings, easement, street name, contours

1. **What it is:** The survey and title information under the design.
2. **How it is drawn today:** Not in the job drawing. They print from the background reference (E-056). Layer names seen inside the background: A-TITLE BOUNDARY (colour 2, DASHDOT2), BOUNDARY, EASEMENT (colour 6, DASHED), A-SURVEY, CONTOURS, TPZ, TREE, SEWER, G-ANNO-TEXT. In the job file the layers BOUNDARY (colour 2, DASHDOT), EASEMENT (colour 6, DASHED), FENCE (11), DRIVEWAY (254), SURVEY (253) exist but are empty. "MATCH EXISTING LEVELS" is a loose MTEXT in the job with a pointer leader.
3. **Text:** Unknown (inside the background file, not opened): Q-101.
4. **Standard position / offset as measured:** Unknown: Q-101.
5. **What it relates to but is not tied to today:** Cover levels and finished levels are picked from the survey levels; the discharge point sits on the boundary side.
6. **Facts it would hold in a one-network drawing:** Survey levels as the source of cover levels.
7. **Appears also in:** Outfall plan offsets from the title boundary.
8. **Differences seen between jobs:** JOB_A shows survey contours and bearings and distances on boundaries.

Evidence: STUDY_A section 6 item 30, section 1 item 14.6, section 2 civil layer 43, section 10 item 1; OPEN_QUESTIONS Q-101.

## E-031 Tree protection zone

1. **What it is:** The no-dig circle round a tree to be kept (TPZ), and the inner structural root zone (SRZ).
2. **How it is drawn today:** Arcs and lines on TPZ (colour 2, HIDDEN) drawn by hand (12 arcs on JOB_B), a hatch (ANSI31 on a HATCH layer, forced colour) and plain TEXT "TPZ" / "SRZ" (SRZ forced to colour 233). The tree symbol is a pasted architect block on TREE at scale 160.
3. **Text:** Plain TEXT height 280 (2.8 mm). Wording "TPZ", "SRZ".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The arborist report; pits and pipes kept out (L-013); the tree protection note.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Legend; tree protection note. Prints as green hatch.
8. **Differences seen between jobs:** JOB_B only (12 arcs). TREE layer colour 65 in JOB_C and the template, 73 in JOB_A/B and the master.

Evidence: STUDY_A section 6 item 31, section 2 civil layer 39, section 3 item 3.13; ELEMENT_LIST "Seen as a picture" item 2.

## E-032 Existing services

1. **What it is:** Sewer, water, gas, telecom and overhead power lines already on the site.
2. **How it is drawn today:** Plain LINEs on SEWER, WATER, GAS, TELSTRA (all colour 9) and ELEC OVERHEAD (colour 251) with the lettered linetypes (SEWER, WATER, GAS_LINE, TELSTRA, ELECTRICITY) and an object linetype scale (0.1, or 2.0 for gas). A large sewer is a 700-wide polyline with circle and arc ends, forced colours 233 and 242.
3. **Text:** Size note as plain TEXT: "EX. 750 DIA. SEWER MAIN". CIV-08: the sewer main labelled with offset and depth.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Clearances (1 m from sewer ties; 150 at a crossing: L-013); the before-you-dig block.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence, beyond size, offset and depth where a crossing is checked.
7. **Appears also in:** Legend; long section (councils ask for existing services shown on it); service crossing section.
8. **Differences seen between jobs:** Not compared.

Evidence: STUDY_A section 6 item 32, section 2 civil layer 40, section 5 items 7 to 10; STUDY_B section 1e item 6, 1h item 7.

## E-033 Slab and pavement hatches

1. **What it is:** The fills that show driveway slab, building footprint and special paving.
2. **How it is drawn today:** Solid hatches on HATCH 21 (driveway; layer colour 49 in the jobs, 21 in the template) and HATCH 141 (building; colour 149 in JOB_C), some associative and some not, with boundaries on HATCHOUTLINE (colour 215, does not plot) or none. JOB_B: ANSI31 scale 50 on HATCH 150 (permeable paving).
3. **Text:** None.
4. **Standard position / offset as measured:** Not applicable.
5. **What it relates to but is not tied to today:** The impervious areas used in the sums (roof, paving); the driveway pavement detail.
6. **Facts it would hold in a one-network drawing:** Area and kind (roof, paving, pervious), each named and counted once, for S-001.
7. **Appears also in:** Legend; computations (areas). On paper: driveway pale grey, building light blue.
8. **Differences seen between jobs:** Permeable paving only on JOB_B. JOB_A/B carry extra hatch layers not in the template (CONCRETE HATCH, HATCH 14, HATCH 240, HATCH DECK, AREA OF INTEREST HATCH). Why HATCH 21 (colour 49) prints grey is not explained by the decoded plot style table (Q-103).

Evidence: STUDY_A section 6 item 33, section 2 civil layers 35 and 36 and "Standard versus invented" item 3, section 10 item 3.

## E-034 Saw cuts and joints

1. **What it is:** The joint lines in a concrete driveway: saw cut (SC), construction joint (CJ), tool joint (TJ).
2. **How it is drawn today:** Saw cut = plain LINE on SAWCUT (colour 2, DASHDOT2) with a loose MTEXT "SC" rotated 90. The parked tag block has attribute "TAG" (values "SC", "CJ", "TJ") on layer "25TEXT - JOINT TEXT". Construction joint layer CONSTRUCTION JOINT (colour 3): linetype PHANTOM_CJ in JOB_C and the template, CENTER2 in JOB_A and JOB_B, PHANTOM in the master.
3. **Text:** "SC" height 250 (2.5 mm), masked, rotated 90.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The slab outline; the saw cut and construction joint details.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Saw cut detail, construction joint detail (E-047); legend.
8. **Differences seen between jobs:** Construction joint linetype differs in three places as above.

Evidence: STUDY_A section 6 item 34, section 2 civil layers 32 to 34, section 9 item 8.

## E-035 Section mark and detail title

1. **What it is:** The mark on the plan that points to a detail, and the title under a detail.
2. **How it is drawn today:** "TAG SECTION MARK" (attributes "SEC" and "DWG", stretch / rotate / two flips) and "Section Title" (attributes "SECTIONMARK", "SECTIONSHEETNUMBER", fixed text "SECTION" and "SCALE 1:20"). Both are drawn at paper size and inserted at scale 100. Parked only on JOB_C. Detail titles on the sheet are mostly MTEXT inside each detail block.
3. **Text:** Detail titles inside blocks: height 500 (5.0 mm) on 50TEXT.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The detail it points to and the sheet number it is on.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Details.
8. **Differences seen between jobs:** Parked only on JOB_C.

Evidence: STUDY_A section 6 item 35, section 2 civil layer 45.

## E-036 North point and scale bar

1. **What it is:** The north arrow and the bar scale.
2. **How it is drawn today:** Inside the title block in paper space (layers 0-NORTH and 0-SCALE BAR; bar segments are polylines of width 1). A block "MOC" is inserted on the plan at scale 0.45 to 0.5 on JOB_A and JOB_B (not opened; likely a north point, unconfirmed).
3. **Text:** Scale bar text 2.5 (paper space).
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The viewport scale.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Title block (E-043).
8. **Differences seen between jobs:** "MOC" on JOB_A and JOB_B only. What "MOC" is: Unknown (Q-103).

Evidence: STUDY_A section 6 item 36, section 10 item 6.

## E-037 Warning boxes (top row)

1. **What it is:** The row of coloured read-this boxes along the top edge of the sheet.
2. **How it is drawn today:** Each is its own machine-named block inserted on STORMWATER at scale 0.967. Inside: a solid hatch on HATCH 51 (colour 250), an outline on HATCHOUTLINE, one MTEXT, and a nested dynamic "shadow box" (two polylines on 35CONT, one of width 150 forming the drop shadow, stretchable).
3. **Text:** MTEXT height 250 to 300 (section 6) or 240 to 300 (section 3) in the same study.
4. **Standard position / offset as measured:** Along the top edge of the sheet.
5. **What it relates to but is not tied to today:** Nothing on the network. Risk notes on the plan are boxed, often red, placed at the spot they concern.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Every sheet (part of the fixed frame).
8. **Differences seen between jobs:** Same on all three. On paper: yellow box, black shadow; why colour 250 prints yellow is not explained (Q-103).

Evidence: STUDY_A section 6 item 37, section 3 item 3.13, section 10 item 3; DIGEST section 1 items 1 and 10.

## E-038 Notes blocks

1. **What it is:** The standing notes: general notes, council notes, the disclaimer, the before-you-dig block, charged system notes.
2. **How it is drawn today:** Each is ONE block holding one long MTEXT plus a shadow box: general notes, council notes, the disclaimer ("CVL DISCLAIMER NOTE") and the before-you-dig block. Inserted on BLOCKS (BYDA for before-you-dig, scale 0.5). To change a word the drafter edits inside the block. General notes and council notes are machine-named blocks.
3. **Text:** MTEXT height 250 (2.5 mm) or 280 (disclaimer); bullets and paragraph settings.
4. **Standard position / offset as measured:** General notes column on the right; council notes and charged-system notes bottom-right beside the title block.
5. **What it relates to but is not tied to today:** The council (its own notes block; one council alone had at least 27 different note blocks depending on the job's conditions); the assumed discharge invert (the council notes say the invert at the discharge point is assumed).
6. **Facts it would hold in a one-network drawing:** Which council, so the right notes come with it.
7. **Appears also in:** Details file headings by council.
8. **Differences seen between jobs:** Council's own notes block (JOB_C); tree protection note; neighbour's footing note; retaining wall note; soakage assumptions note. The standard is quoted with three different years on real jobs.

Evidence: STUDY_A section 6 item 38, section 8 item 3; ELEMENT_LIST "Seen as a picture" items 1 and 8 and "Across three civil jobs" moving part 3; MODEL_NOTES "What it teaches" item 8; DIGEST section 3 item 8.

## E-039 Legend

1. **What it is:** The full civil works legend.
2. **How it is drawn today:** Block "CIVIL LEGEND", inserted on BLOCKS at scale 1, 9250 x 30,190. 224 objects: sample pipes (polylines of width 150 and 225 on the real pipe layers), lines, 40 texts, small nested symbols.
3. **Text:** Heights 250 / 200 / 180.
4. **Standard position / offset as measured:** Right-hand strip of the sheet with the general notes.
5. **What it relates to but is not tied to today:** Nothing: a symbol in it does not mean the item is on the job.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Every sheet.
8. **Differences seen between jobs:** Identical on all three jobs; not edited per job.

Evidence: STUDY_A section 6 item 39; DIGEST section 1 item 11.

## E-040 Pit schedule

1. **What it is:** The ruled list of every pit with its size, inlets, outlet, cover level, depth and lid.
2. **How it is drawn today:** NOT an AutoCAD table. The dynamic block "Pit Schedle" (spelt that way) on BLOCKS: 13 lines and 4 polylines on SCHEDULE (colour 7), 12 heading MTEXTs, a title, a note. 17,200 wide. One dynamic distance "ROW NUMBERS" with a stretch and an array action adds rows 1500 apart. The CELL VALUES are loose MTEXTs lying on top of the block: layer 25TEXT, each in a text box 1000, 1500 or 2000 wide (4200 for remarks, 1100 for pit number).
3. **Text:** Cell text 250, middle-centre, no mask (remarks middle-left); column headings 250 on 35TEXT; title 500; small note 180.
4. **Standard position / offset as measured:** Directly under the plan, beside the criteria box. Rows 1500 apart; block 17,200 wide.
5. **What it relates to but is not tied to today:** Every pit, its pipes and levels on the plan; the depth sum.
6. **Facts it would hold in a one-network drawing:** None of its own: every cell is read from the pits and pipes.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md` for columns and build.
8. **Differences seen between jobs:** 2 rows (JOB_C: 26 loose cells for 2 pits) to 20-odd rows; a pit with several inlets takes several rows with the repeated cells left empty; remarks carry lid class and silt pit levels.

Evidence: STUDY_A section 6 item 40, section 3 item 3.10; ELEMENT_LIST "Seen as a picture" item 3 and "Across three civil jobs" moving part 6; DIGEST section 1 item 6.

## E-041 Detention criteria box

1. **What it is:** The box that states the detention design: permitted discharge, head, orifice, top water level, volume required and each storage.
2. **How it is drawn today:** A rectangle polyline on DRAINAGE; a heading MTEXT on layer HATCH 11 with colour forced to 3 (prints green); ONE body MTEXT on 25TEXT with a line per quantity and tab characters between the name and the value. All typed.
3. **Text:** Heading "ON SITE DETENTION CRITERIA" height 350 (3.5 mm); body 250 (2.5 mm); no mask. Lines: "PERMITTED SITE DISCHARGE <tab> 6.00 l/s", "HEAD ... 380mm", "DIA. OF ORIFICE ... 69mm", "TWL ... 5.20m", then the storages.
4. **Standard position / offset as measured:** Directly under the plan beside the pit schedule, at the downstream end.
5. **What it relates to but is not tied to today:** The sums (S-003, S-006, S-007); the orifice pit; each tank, detention pipe and pit named in it.
6. **Facts it would hold in a one-network drawing:** None of its own: all read from the job facts and the network.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md` for rows.
8. **Differences seen between jobs:** JOB_C: tanks only. JOB_B: every pit, pipe and tank listed. JOB_A: no box at all.

Evidence: STUDY_A section 6 item 41, section 3 items 3.11 and 8; ELEMENT_LIST "Seen as a picture" item 4 and "Across three civil jobs" moving part 1.

## E-042 Site / roof area box

1. **What it is:** A box of site area and impervious area figures, where a council asks.
2. **How it is drawn today:** The civil template parks a "SITE INFO AND CALCULATIONS" sample. On JOB_C the roof areas are one MTEXT in a rectangle (E-021).
3. **Text:** Site area, total impervious area, "and more not yet read".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The areas in the sums (S-001).
6. **Facts it would hold in a one-network drawing:** None of its own: site, impervious and pervious areas counted once.
7. **Appears also in:** Computations.
8. **Differences seen between jobs:** Used "where a council asks".

Evidence: STUDY_A section 6 item 42; ELEMENT_LIST "Tables and boxes" item 2; STUDY_B section 2 outputs item 2.

## E-043 Title block

1. **What it is:** The sheet border and title panel.
2. **How it is drawn today:** Block "R- TITLE SHEET" in paper space at 0,0, scale 1, 795 x 567. It has NO attributes. 106 objects: border and ruling lines on 0-TITLE and 0-TITLE BLOCK, fixed labels as plain TEXT, the job's own values as plain TEXT inside the block (changed by editing the block), the office logo image, the scale bar, the reduced-plot note. Two fields: the drawing number shows the layout tab name ("C01"); the office address is a hyperlink field.
3. **Text:** Heights 1.5, 2.0, 2.5, 3.0, 4.0 in paper space. Fixed labels: "DRAWING No:", "REVISION:", "DATE:", "APPROVED:", "DESIGNED:", "DRAWN:", "ORIGINAL SIZE:", "SCALE:", "TITLE:", "PROJECT:", "CLIENT:", "JOB NO:", "REVISION DESCRIPTION", "No.", "APPROVED", "DRAWN", "CHECKED", "DATE".
4. **Standard position / offset as measured:** Paper space 0,0.
5. **What it relates to but is not tied to today:** The job facts (project, client, job number); the revision rows; the issue stamp.
6. **Facts it would hold in a one-network drawing:** Job facts typed once.
7. **Appears also in:** See `drafting\TITLE_BLOCK_AND_ISSUE.md`.
8. **Differences seen between jobs:** Same on all three. Text styles "x-sheet$0$..." inside it came from a bound reference.

Evidence: STUDY_A section 6 item 43, section 1 item 8, section 3 items 2 and 3.14.

## E-044 Drawing title and scale line (paper space)

1. **What it is:** The sheet's title and the scales, in the title block.
2. **How it is drawn today:** Loose MTEXT (layer 0-TITLE TEXT) and loose TEXT in paper space, over the block.
3. **Text:** Title height 4.0; scale line "1:100, 1:20" height 3.0. Title wording: "Stormwater drainage and pavement plan and details".
4. **Standard position / offset as measured:** In the title panel.
5. **What it relates to but is not tied to today:** The viewport scale; the 5x details.
6. **Facts it would hold in a one-network drawing:** Sheet title and scales.
7. **Appears also in:** Title block.
8. **Differences seen between jobs:** Basement and outfall sheets carry other titles ("basement stormwater drainage plan").

Evidence: STUDY_A section 6 item 44; ELEMENT_LIST "The sheet" item 1; STUDY_B section 1l items 1 and 3.

## E-045 Revision rows

1. **What it is:** The list of issues: letter, description, initials, date.
2. **How it is drawn today:** In the template the first row is inside the block. On the jobs each revision row is SIX loose plain TEXTs in paper space on 0-TITLE REVISION: revision letter, description, three initials, date. A new row is made by copying the last row up and retyping. The current revision letter is a separate loose TEXT in the corner.
3. **Text:** Row text height 1.5; current revision letter 4.0. Descriptions: "PRELIMINARY ISSUE", "FOR COUNCIL APPROVAL".
4. **Standard position / offset as measured:** Rows 4 to 5 apart in Y.
5. **What it relates to but is not tied to today:** The issue stamp (E-046); the current revision letter.
6. **Facts it would hold in a one-network drawing:** Revision letter, description, drawn / checked / approved initials, date, once per issue.
7. **Appears also in:** See `drafting\TITLE_BLOCK_AND_ISSUE.md`.
8. **Differences seen between jobs:** None recorded. Real jobs have had revision / date / file-name errors.

Evidence: STUDY_A section 6 item 45; DIGEST section 6 item 12.

## E-046 Issue stamp

1. **What it is:** The box above the title block that says what the issue is for.
2. **How it is drawn today:** Four MTEXTs stacked in the same place inside the title block, each on its own layer: 0-STAMP-PRELIMINARY, 0-STAMP-TENDER, 0-STAMP-APPROVAL, 0-STAMP-CONSTRUCTION. The drafter freezes three and thaws one. On JOB_C the APPROVAL layer is thawed and the other three frozen.
3. **Text:** "PRELIMINARY ISSUE / NOT TO BE USED FOR PRICING PURPOSES / NOTE: DRAWING TO BE PRINTED IN FULL COLOUR"; "FOR COUNCIL APPROVAL / NOT TO BE USED FOR CONSTRUCTION PURPOSES ...". Tender and construction wording not quoted in the evidence.
4. **Standard position / offset as measured:** Above the title block.
5. **What it relates to but is not tied to today:** The latest revision row.
6. **Facts it would hold in a one-network drawing:** The issue stage (preliminary, tender, for council approval, construction).
7. **Appears also in:** Revision rows.
8. **Differences seen between jobs:** JOB_C for council approval; JOB_A and JOB_B construction issue.

Evidence: STUDY_A section 6 item 46, section 2 naming family 4; ELEMENT_LIST "Across three civil jobs".

## E-047 Details

1. **What it is:** The construction details across the bottom of the sheet.
2. **How it is drawn today:** Each detail is one block inserted on BLOCKS at scale 1 (drawn 5x inside), e.g. "PIT 900 MAX", "PIPE BEDDING R.C & GRASS", "SLAB ON GROUND 04", "Saw cut", "REENTRANT BARS", "LAP SPLICE" (inserted at scale 5). Job-specific details (orifice pit with this job's levels, tank detail with this job's litres) are machine-named blocks whose numbers were typed inside the block. Details use hatches AR-CONC (scale 3), EARTH (scale 40), ANSI31, and old-style leaders. JOB_C holds two PDF underlays inside detail blocks (water tank installation diagrams).
3. **Text:** Titles 500 on 50TEXT inside the block. Dimensions are typed over: a dimension that measures 750 carries the typed text "150"; measured 2250 carries "450" (ratio 5.0). Pasted details carry other ratios (2.15, 2.55 measured).
4. **Standard position / offset as measured:** Lower band of the sheet.
5. **What it relates to but is not tied to today:** The pit, tank or pipe the detail describes; the same levels and sizes on the plan, schedule and criteria box.
6. **Facts it would hold in a one-network drawing:** Orifice pit detail: cover, top water level, baffle height, orifice, inverts, chamber sizes, lid classes. Tank detail: litres, split, tank orifice, footprint. All read from the network.
7. **Appears also in:** The office details file (96 named blocks, 42 machine-named, under headings by topic and by council).
8. **Differences seen between jobs:** Orifice pit detail only with detention; raingarden section only with a raingarden; soakage detail only with soakage; agricultural drain trench detail only with those drains; a deeper junction pit detail (900 to 1200) only when a pit is that deep; tank detail drawn to the job's own tank. Details seen on JOB_C: orifice pit; junction pit; pipe bedding under pavement and grass; trench beside footing with angle-of-repose values; services penetration through footing; flexible service pipe through footing; water tank detail; charged system diagram; driveway slab note, re-entrant bars, lap splice, sawcut.

Evidence: STUDY_A section 6 item 47, section 1 items 9 and 15, section 9 "Between the jobs and MASTER" item 6; ELEMENT_LIST "Seen as a picture" item 6 and "Across three civil jobs" moving part 2; STUDY_B section 2 outputs item 3.

## E-048 Computation sheet

1. **What it is:** The office drawing sheet the computations are set out on.
2. **How it is drawn today:** A separate small drawing ("CE Computation Sheet"): 6 blocks, 2 fields, no tables. Not examined further.
3. **Text:** Unknown.
4. **Standard position / offset as measured:** Unknown.
5. **What it relates to but is not tied to today:** The computations PDF sent to council (two to four pages: required figures, storage list, orifice sum, then "WSUD").
6. **Facts it would hold in a one-network drawing:** The computations sheet prints from the same numbers as the drawing (D-021).
7. **Appears also in:** The council submission.
8. **Differences seen between jobs:** Unknown.

Evidence: STUDY_A section 6 item 48; STUDY_B section 1 "Common path" item 4; DECISIONS D-021.

## E-049 Dwelling and garage names

1. **What it is:** The name written on each building ("Dwelling 1", "Unit 1", "Townhouse 1", "Garage").
2. **How it is drawn today:** Plain TEXT on 35TEXT (colour 2).
3. **Text:** Height 350 (3.5 mm), justified Middle.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The roof-to-tank areas by dwelling.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Roof hatch legend "per dwelling".
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 3 item 3.8, section 2 civil layer 27, section 8 item 1.

## E-050 Pointer leader and plan note

1. **What it is:** A typed note with an arrow pointing at the thing it describes.
2. **How it is drawn today:** An old LEADER object on 25DIMS, 2 or 3 points, 600 to 6750 long, never attached to its text (every one of the 82 leaders in JOB_C, 90 in JOB_A, 100 in JOB_B has no annotation link). The note is a separate MTEXT on 25TEXT. Zero multileaders anywhere.
3. **Text:** Height 250 (2.5 mm), mask on for most plan notes. Examples: "MATCH EXISTING LEVELS"; "100 dia. riser to water tank"; "100 dia. dropper from water tank".
4. **Standard position / offset as measured:** Arrow size 300, scale 100, gap 1 (style values).
5. **What it relates to but is not tied to today:** The object it points at. Move the text and the leader stays behind.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Details (old-style leaders).
8. **Differences seen between jobs:** 82 leaders in JOB_C, 90 in JOB_A, 100 in JOB_B.

Evidence: STUDY_A section 4 items 4 to 7; ELEMENT_LIST "On the plan" item 2.

## E-051 Dimension used as a labelled bracket

1. **What it is:** A dimension line whose number has been replaced by words or a typed value.
2. **How it is drawn today:** Dimensions on 25DIMS, style STANDARD; few (12 in JOB_C, 4 in JOB_A, 7 in JOB_B). On the plan the measurement is replaced by words. Every dimension inside the window on JOB_B and JOB_C has typed-over text.
3. **Text:** Height 250 (style text height 2.5 at scale 100). Example: a 4.1 m dimension whose text is "NEW CROSSOVER TO COUNCIL REQUIREMENTS".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Crossover positions and widths; the 1 m from splay dimension councils ask for.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Details (typed-over dimensions at ratio 5).
8. **Differences seen between jobs:** Counts as above.

Evidence: STUDY_A section 4 items 2 and 8; GUIDEBOOK_NOTES "Elements" items 13 and 16.

## E-052 Building outline

1. **What it is:** The heavy outline of the building on the civil plan.
2. **How it is drawn today:** A polyline on 50CONT (colour 3) with global width 70.
3. **Text:** None.
4. **Standard position / offset as measured:** Not applicable.
5. **What it relates to but is not tied to today:** The architect's background; the building footprint fill (E-033).
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Not recorded.
8. **Differences seen between jobs:** Not compared.

Evidence: STUDY_A section 2 civil layer 31.

## E-053 Retaining wall

1. **What it is:** A retaining wall line on the plan.
2. **How it is drawn today:** A fat polyline plus multiline on RETAINING WALL / SLEEPER RETAINING WALL (colour 1). JOB_A: retaining wall polylines of width 112 and 225, colour 31.
3. **Text:** A retaining wall note.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Agricultural drains behind it; levels each side.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence. Retaining walls were not found as civil sums.
7. **Appears also in:** Tool palette (retaining wall); supplier guides in the reference folder only.
8. **Differences seen between jobs:** JOB_A only (a sleeper retaining wall). Shown on CIV-12.

Evidence: STUDY_A section 2 civil layer 38, section 9 item 10; STUDY_B section 1l items 3 and 5.

## E-054 Batter

1. **What it is:** A sloped bank between two levels.
2. **How it is drawn today:** Batter lines and fills on BATTER (colour 253). JOB_A/B also carry a layer BATTER SYMBOL not in the template.
3. **Text:** None recorded.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Finished levels.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Tool palette (batter, on BLOCKS GROUND).
8. **Differences seen between jobs:** Not compared.

Evidence: STUDY_A section 2 civil layer 37 and "Standard versus invented" item 3; ELEMENT_LIST "On the plan" item 11.

## E-055 Sheet frame and sheet number text

1. **What it is:** The non-printing rectangle in model space that shows the drafter where the sheet edge is.
2. **How it is drawn today:** A block named "Drawing Border" (two polylines on DEFPOINTS, 795 x 567) inserted at scale 100 on layer BLOCKS. It does not plot. Above it sits a text on DEFPOINTS with the sheet number ("C01").
3. **Text:** Sheet number height 5000.
4. **Standard position / offset as measured:** Sheet 1: X 106,313 to 185,813 and Y -209,927 to -153,227 (79,500 x 56,700). Second sheet exactly 100,000 to the right (X 206,313).
5. **What it relates to but is not tied to today:** The layout viewport of the same sheet.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** See `drafting\SHEET_SETUP.md`.
8. **Differences seen between jobs:** Same position in all three jobs and the template. JOB_A uses the second frame.

Evidence: STUDY_A section 1 items 2, 4 and 5.

## E-056 Background attachment (architect and survey)

1. **What it is:** The cleaned architect / survey drawing attached under the design.
2. **How it is drawn today:** The office first makes its own cleaned background drawing, saved as `.\Xref\Xref_<job>.dwg` beside the job drawing (relative path). Attached on layer XREF (colour 7), scale 1, rotation 0. JOB_B and JOB_C attach it twice under two names ("Xref_<job>_Site", "Xref_<job>_Ground"), 50,000 apart in Y, each clipped to a rectangle. JOB_A attaches it under one name three times, each clipped to a polygon.
3. **Text:** Comes with the background.
4. **Standard position / offset as measured:** The two attachments 50,000 apart in Y.
5. **What it relates to but is not tied to today:** Everything picked off it (areas, levels, downpipe positions). When the architect changes plans the design is reworked by hand (a main cause of rework: D-030).
6. **Facts it would hold in a one-network drawing:** Not a network element.
7. **Appears also in:** See `drafting\SHEET_SETUP.md` for fading and layer counts.
8. **Differences seen between jobs:** Two named rectangular attachments (JOB_B/C) against one name three times with polygon clips plus a 0.2-scale copy in a block (JOB_A).

Evidence: STUDY_A section 1 item 14, section 9 item 2; INTERVIEW items 7 and 8d.

## E-057 Part plans, match lines and key plan

1. **What it is:** The way a site too big for one view is cut into pieces.
2. **How it is drawn today:** JOB_A: the one background file attached THREE times side by side in model space, each clipped to a different 6-point polygon, each with its own title. Match lines are drawn by hand. The 1:500 key plan is a block containing the same background reference inserted at scale 0.2, placed inside the 1:100 frame.
3. **Text:** "PART PLAN n / SCALE 1 : 100".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Pipes that cross a match line continue on the next part plan.
6. **Facts it would hold in a one-network drawing:** Not a network element.
7. **Appears also in:** See `drafting\SHEET_SETUP.md`.
8. **Differences seen between jobs:** JOB_A only.

Evidence: STUDY_A section 1 items 10 and 11; ELEMENT_LIST "Across three civil jobs" item 3 and moving part 4.

## E-058 Connection note (the discharge point)

1. **What it is:** The note at the point where the site's drain joins the council system, with the approximate invert.
2. **How it is drawn today:** A typed note with a pointer leader (E-050). How the discharge point itself is marked beyond the note is not described in the evidence: Unknown.
3. **Text:** "connect to council pit at approx IL 1.14 to council satisfaction, builder to confirm" (CIV-01); "approx IL 0.96" (CIV-02). The council notes say the invert at the discharge point is assumed.
4. **Standard position / offset as measured:** Not measured. Kerb connections 1 m clear of the crossing splay (L-013).
5. **What it relates to but is not tied to today:** The last pipe's downstream invert; the existing council drain (E-005); the council letter.
6. **Facts it would hold in a one-network drawing:** Discharge point kind (kerb, council pit or pipe, easement drain, new outfall, soak on site, existing internal system); its invert; whether that invert is given or assumed. The council connection invert is normally fixed on a tight site (D-018).
7. **Appears also in:** Council notes block; council standard connection drawings.
8. **Differences seen between jobs:** Wording varies by council and discharge option. There is no set way of showing what was assumed (D-030).

Evidence: STUDY_B section 1a item 5, 1b item 4, section 2 inputs item 1; ELEMENT_LIST "Seen as a picture" items 5 and 8; INTERVIEW items 8g, 8h, 8za.

## E-059 Pump station, rising main and pump specification box

1. **What it is:** A pump well that lifts water to a receiving pit, its pressure pipe, and the box that states the pump duty.
2. **How it is drawn today:** Pit block states "SPS Vertical" and "SPS Horizontal" exist (E-008); the pit tag placeholder "SPS" (E-012). Layer STORMWATER RISING MAIN is in the master only. A pump placeholder is parked on JOB_C. The paper look of pump sheets has not been seen (Q-106). The older study: schedule row, pump specification box, wet-well section, green rising main to a receiving pit, then gravity to the kerb.
3. **Text:** Pump box (CIV-07): dual alternating pumps 7.90 l/s, static rise 0.67, rising main 6 m, minimum wet well 4.72, comply with the standard. Notes: "fully tanked pump pit, no groundwater into the pump system"; control panel and alarm note; the standard's pump clauses.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pump sums (S-014, S-015); the receiving pit; the permitted discharge (pump rate).
6. **Facts it would hold in a one-network drawing:** Pump rate; number of pumps; static rise; rising main size and length; wet well volume, shape and plan size; the seven named levels; cover level; discharge invert.
7. **Appears also in:** Pump station section (detail); pit schedule row; pipe descriptions for rising main on the LABELS CIVIL palette.
8. **Differences seen between jobs:** CIV-07: 2,000 dia fibreglass well. CIV-10: rectangular well 9.6 m x 1.5 m with the detention in the same well. CIV-12: dual 2.5 l/s pumps.

Evidence: STUDY_B section 1g items 5 and 6, 1l items 1 and 3; STUDY_A section 6 items 8 and 12, section 2 civil layer 5, section 9 item 10; DIGEST section 1 item 9, section 2 item 1; ELEMENT_LIST "Tables and boxes" item 4.

## E-060 Soakage pit and silt pit

1. **What it is:** A buried pit of plastic modules where water soaks into the ground, with a silt pit before it.
2. **How it is drawn today:** How the grid is drawn (objects, layer) was not measured: Unknown (Q-106). JOB_A's sheet has a soakage unit grid, silt pits and soakage and tank details.
3. **Text:** Each soakage pit titled with its module count and grid; "wrapped in geotextile"; silt pit inverts; a soakage assumptions note.
4. **Standard position / offset as measured:** Rules: modules 1 m from footings, 2 m from boundaries, 1.5 m from tree zones where possible; at the low point (L-016).
5. **What it relates to but is not tied to today:** The soakage sum (S-016); its catchment; the soil report.
6. **Facts it would hold in a one-network drawing:** Module count and grid (wide x long, single or double height); width, length and depth; catchment; soil rate; moderating factor; silt pit levels.
7. **Appears also in:** Typical section per pit (detail); schedule remarks (silt pit levels).
8. **Differences seen between jobs:** CIV-08: 60, 40 and 30 double modules. JOB_A: overflow to a dam.

Evidence: STUDY_B section 1h items 2 to 7, section 3 item 16; ELEMENT_LIST "Across three civil jobs" item 3 and moving parts 2 and 6.

## E-061 Roof hatch and roof-area legend

1. **What it is:** A hatch over the roof area that goes to a tank, with a legend giving the area per dwelling.
2. **How it is drawn today:** Not measured on JOB_A/B/C: Unknown. JOB_A/B carry a layer "AREA OF INTEREST HATCH" not in the template; its use is not stated.
3. **Text:** Legend giving roof area in square metres per dwelling.
4. **Standard position / offset as measured:** Unknown.
5. **What it relates to but is not tied to today:** The roof-to-tank areas box (E-021); the STORM report.
6. **Facts it would hold in a one-network drawing:** Roof area to each tank, counted once.
7. **Appears also in:** Kingston's commonly-asked list ("roof hatch and area legend").
8. **Differences seen between jobs:** Unknown.

Evidence: GUIDEBOOK_NOTES "Elements" item 14; STUDY_B section 4 item 1, section 2 outputs item 1; STUDY_A section 2 "Standard versus invented" item 3.

## E-062 Outfall plan and long section

1. **What it is:** A narrow plan of a drain in the road reserve and a long section (side view along the pipe) with rows of figures.
2. **How it is drawn today:** Not measured (long-section examples were not converted): Unknown (Q-102). On CIV-05 it is a second sheet (C02).
3. **Text:** Rows: pipe size, pipe grade, pipe design flow, velocity, invert depth, invert level, surface level, chainage, datum.
4. **Standard position / offset as measured:** Horizontal 1:250, vertical 1:25 (one council). Lower-centre of the sheet when present.
5. **What it relates to but is not tied to today:** The outfall pipes and pits on the plan; survey levels along the route; existing services crossed.
6. **Facts it would hold in a one-network drawing:** For each point along the run: chainage, surface level, invert level, invert depth; per pipe: size, grade, design flow, velocity; datum.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md`. With it: outfall plan at 1:100 with offsets from the title boundary; two-row pit schedule; 1:20 service-crossing section; locality plan; pasted council standard drawings; council notes block; service-crossing clouds.
8. **Differences seen between jobs:** Only 2 of the 30 jobs in the August study had one, both for the outfall to the council pit; rows and scales differed.

Evidence: STUDY_B section 1e item 5, section 3 item 21; DIGEST section 1 items 1 and 8, section 2 item 7; STUDY_A section 10 item 12.

## E-063 Revision cloud

1. **What it is:** A cloud drawn round something that changed in this revision.
2. **How it is drawn today:** Layer CLOUD (colour 10 in jobs and template, 12 in the master). Empty in the three jobs.
3. **Text:** None.
4. **Standard position / offset as measured:** Not applicable.
5. **What it relates to but is not tied to today:** The revision row it belongs to.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** The typed helper `RC` (rectangular revision cloud at the office arc size).
8. **Differences seen between jobs:** None drawn on JOB_A/B/C.

Evidence: STUDY_A section 2 civil layer 50; STUDY_C section 2A item 6.

## E-064 Riser and dropper

1. **What it is:** The vertical lengths of a charged line: the riser up into the tank and the dropper down from it.
2. **How it is drawn today:** Not measured in STUDY_A. A "riser/dropper" block is on the BLOCKS CIVIL tool palette and riser and dropper block drawings ship in the civil plug-in bundle.
3. **Text:** Pipe notes with leaders: "100 dia. riser to water tank", "100 dia. dropper from water tank".
4. **Standard position / offset as measured:** Unknown.
5. **What it relates to but is not tied to today:** The tank; the charged pipe.
6. **Facts it would hold in a one-network drawing:** Which tank; diameter.
7. **Appears also in:** Charged system diagram (detail).
8. **Differences seen between jobs:** Unknown.

Evidence: ELEMENT_LIST "On the plan" item 2; STUDY_C section 1 item 1.5 and section 2B item 1.1; STUDY_B section 2 outputs item 1.

## E-065 Existing pit

1. **What it is:** A pit already on or near the site (often the council's).
2. **How it is drawn today:** Loose lines on EX PIT (colour 9): a 450 square with a cross, and a 675 dashed outer square. Not the pit block. Forced linetype HIDDEN on the existing pit lines in JOB_C.
3. **Text:** Not recorded.
4. **Standard position / offset as measured:** 450 square inside a 675 square.
5. **What it relates to but is not tied to today:** The existing drain (E-005); the connection note (E-058).
6. **Facts it would hold in a one-network drawing:** Cover and invert levels where known (survey: "existing pits with cover and invert levels"); a schedule row on an outfall sheet.
7. **Appears also in:** Pit schedule on an outfall sheet (existing council pit row); tool palette ("existing pit and pipes").
8. **Differences seen between jobs:** Not compared.

Evidence: STUDY_A section 2 civil layer 10, section 8 items 6 and 9; STUDY_B section 1e item 5, section 2 inputs item 3.

## E-066 Plan title and scale line (model space)

1. **What it is:** The title under the plan ("... PLAN / SCALE 1 : 100").
2. **How it is drawn today:** One MTEXT on TEXT TITLE (colour 4) holding the title and the "SCALE 1 : 100" line at a smaller inline height. The layer is in the template but not in the master.
3. **Text:** Height 700 (7.0 mm); no mask.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The viewport scale.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Part plan titles (E-057).
8. **Differences seen between jobs:** None recorded.

Evidence: STUDY_A section 3 items 3.12 and 6, section 2 civil layer 29 and "Standard versus invented" item 1.

---

Next free number: E-067
