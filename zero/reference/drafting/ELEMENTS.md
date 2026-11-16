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
5. **Muscle memory and look (owner's rulings):** "A LOT OF OUR STAFF HAVE BUILT MUSCLE MEMORY TO HOW THINGS LOOK AND FEEL NOW SO MAKE SURE IT ALIGNS WITH THAT VISION AND THAT UNDERSTANDING" (D-032). The concept pictures are illustrations, not one-to-one: the real thing uses the office's own blocks and layouts exactly as drawn today (D-039).
6. **Parts move and flip (owner's ruling):** "GRIPS NEED TO WORK SO TEXT / INVERT TEXT / ARROW CAN BE MOVED PEPENDICULAR TO LINE OR PARALLEL TO LINE, COVER LEVEL TEXT CAN BE FLIPPED AND MOVED AND PIT LABEL CAN BE MOVED AND FLIPPED WE NEED ALL SCENARIOS" (D-037). Today no part is linked, so every one is moved by hand (item 1 above).
7. **Same spot on every pipe (owner's ruling):** "ALL PIPES ACT IN THE SAME OR SIMILAR WAYS LIKE INVERT LELVEL IS ALWAYS PLACED IN THE SAME SPOT ON THE PIPE UNLESS THERES CLASHES IN WHICH CASE IT SLIDES UP AND DOWN TO SUIT" (D-041). Read as one standard spot for each part on every pipe kind; a clash is solved by sliding the part along the pipe.
8. **Nothing optional is forced (owner's ruling):** "WHAT IF I DONT WANT TO PUT SAWCUTS OR GIO NEEDS TO GO SOMEWHERE ALONG THE PIPE. THE REST LOOKS GREAT" (D-050). Read as: a slab does not require saw cuts; an inlet such as a GIO goes exactly where the drafter clicks along the pipe and can be slid along afterwards.
9. **AGI drains carry no invert (owner's ruling):** "AGI DRAINS DONT HAVE INVERT LEVELS." (D-040).
10. **Two things the real drawing shows (owner's rulings):** the tank note has a leader arrow back to the tank (part of the tank element): "WATER TANK TEXT HAS AN ARROW BACK TO WATER TANK ISNT SHOWN IN YOURS BUT THATS HOW WE DISPLAY IT"; a pit shows its inner wall line and its outer dashed / hidden line: "THE PIT AND THE PIT WALL YOURE SHOWING JUST THE INTERNAL PIT WALL LINE AND NOT THE OUTER DASHED/HIDDEN LINE" (D-039).

Evidence: STUDY_A section 7 item 13, section 8 items 1 and 12, section 3 item 1, section 1 item 12; DECISIONS D-011 to D-015, D-032, D-037, D-039, D-040, D-041, D-050.

---

## E-001 New stormwater pipe (gravity)

1. **What it is:** A new underground gravity drain between pits, shown as a wide blue dashed band with two thin black edge lines.
2. **How it is drawn today:** TWO objects on top of each other. (a) A polyline on STORMWATER PIPE (colour 150, prints blue; linetype DASHED by layer), global width = the pipe diameter (100, 150, 225, 300 seen), linetype generation off, almost always 2 points, one polyline per run between pits. (b) A multiline on DRAINAGE (colour 6, prints black 0.13), style CLOSED-ENDS (JOB_B, JOB_C) or STANDARD1 (JOB_A), scale = the same diameter, zero (centre) justification, between the same two points. With LTSCALE 1000 the dash is 500 and the gap 250 (5 mm and 2.5 mm on paper). No hatch, no special linetype.
3. **Text:** None on the pipe itself. See E-006 (label), E-007 (flow arrow), E-014 (invert levels).
4. **Standard position / offset as measured:** Pipe ends: at a 350 pit the polyline stops 175 from the pit insertion point (the pit edge); at larger pits 43 to 400; at a downpipe it stops on the downpipe point (0). So pipes run edge to edge, not centre to centre, but not consistently (JOB_C). Settled by Tim, D-102, 16 Nov 2026: new pipes stop at the pit's solid inner wall line, not at the measured offsets above (D-102)
5. **What it relates to but is not tied to today:** The pit at each end; its label; its flow arrow; an invert text at each end; its schedule cells; its multiline (the polyline and its multiline are two unrelated objects). Drawn direction says nothing about flow.
6. **Facts it would hold in a one-network drawing:** From pit and to pit; diameter; material and class; length; upstream and downstream invert; grade (S-008); whether it is a detention pipe; cover at each end (S-010).
7. **Appears also in:** Pit schedule (inlet "from / dia / invert", outlet "dia / invert": E-040); legend (sample pipes: E-039); long section rows (E-062).
8. **Differences seen between jobs:** Multiline on exactly the same end points as the polyline on 11 of 15 pipes in JOB_C and 25 of 33 in JOB_B; none match within 5 mm in JOB_A (the multilines were drawn separately). JOB_A has several widths of 149.9999999999999 (a copied-and-scaled pipe). Multiline style CLOSED-ENDS (JOB_B/C) against STANDARD1 (JOB_A).
9. **Owner's ruling on pick-or-type boxes:** The Material box is a list to pick from AND type into: "material selection for pipes must be text field as well a drop down"; the Grade box the same: "same with grade". Pipe size and lid can also be typed as well as picked; pit size stays list only; on a pipe BOTH invert levels (upstream and downstream) can be typed over: "you need ability to override both invert levels as well" (D-079, D-080)
10. **Working rule for the mock-up, owner to confirm:** When the downstream invert is typed over, the grade is worked out from the two inverts and the length, the value is marked "typed over", and "Put back" returns it to the grade-driven value (D-080)
11. **Owner's ruling on where a pipe stops at a pit:** "At the inner wall line": the pipe passes the dashed outer line and stops at the solid inner wall. This differs from how it is drawn today (item 4); new sheets will differ from old ones at pit edges (D-102)
12. **Owner's ruling on a branch with no pit:** A branch joining a pipe with no pit is always allowed; an inspection opening is offered, never forced (see E-016) (D-081)
13. **Owner's ruling on a pit placed on a drawn pipe:** "Split the pipe in two": two pipes joined to the new pit, each with its own label and levels; "What else changes" says so (D-077)
14. **Owner's ruling on the drop across a pit:** "Office standard, can be typed over" (D-084; S-025)
15. **Owner's rulings on minimum cover and grade:** Cover follows the standard's table by situation (L-004, D-133); detention pipe grade follows the stepped list by size (L-001, D-134)

Evidence: STUDY_A section 6 item 1, section 7 items 1 to 4 and 13, section 2 civil layers 1 and 6, section 9 item 5; D-077, D-079, D-080, D-081, D-084, D-102, D-123, D-133, D-134.

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
9. **Suspended pipe on a sheet:** CIV-11: "SUSPENDED" pipes drawn in magenta inside the building with "150 DIA. UPVC SUSPENDED PIPE AT 1 IN 100 MIN." labels (STUDY_D section 4.4 item 2)

Evidence: STUDY_A section 6 item 3, section 2 civil layer 3 and "Standard versus invented" item 1; STUDY_B section 1k item 5; STUDY_D section 4.4 item 2.

## E-004 Detention pipe

1. **What it is:** A large pipe laid nearly flat to store water; drawn as an ordinary pipe and known as detention only from its label.
2. **How it is drawn today:** No special layer or object. Ordinary STORMWATER PIPE polylines of width 225 (four on JOB_B) and 300 (one) with the usual multiline. "Twin" pipes are two polylines side by side.
3. **Text:** Label as E-006 with a second line: "2 x 225 DIA. STORMPRO PIPES AT 1 IN 200" / "9m DETENTION". CIV-04 runs labelled 19 m, 8 m, 6 m.
4. **Standard position / offset as measured:** As E-001 and E-006.
5. **What it relates to but is not tied to today:** Its line in the criteria box storage list; the storage sum; the pits at its ends.
6. **Facts it would hold in a one-network drawing:** Everything in E-001, plus: is detention (yes); number of pipes side by side; storage volume (S-004); maker's inside and outside diameters (S-013).
7. **Appears also in:** Detention criteria box (pipe by size and length: E-041); computations storage list.
8. **Differences seen between jobs:** Only JOB_B of the three has them (225 and 300 wide). Grades seen across jobs: 1 in 150, 1 in 190, 1 in 200 (L-001).
9. **Settled by Tim, D-083, 16 Nov 2026, own kind and layer:** Detention is "its own kind with a slightly different blue colour and layer, we will need to update the legend as well". For new sheets item 2 ("No special layer or object") no longer holds. Which blue and which layer name: Unknown (to settle with the standards list; `standards\layers.csv` carries a placeholder row) (D-083)
10. **Layer and blue to be proposed:** "You propose, I approve on a sheet": a layer name in the office's style and two or three blues that print clearly different through the office plot style, shown on a sample sheet for the owner to pick. Owed (D-118)
11. **Settled by Tim, D-082, 16 Nov 2026, twin pipes:** "One pipe that says '2 x 225'": one pipe with a number-of-pipes box; it draws two bands and one label, and the storage sum counts both. This replaces item 2's "two polylines side by side" for new sheets (D-082)
12. **Owner's rulings on grade and cover:** Minimum grade 225 at 1 in 200, 300 at 1 in 250, larger at 1 in 300 (D-134); cover over a detention pipe stays 300 (D-133)

Evidence: STUDY_A section 6 item 4, section 9 item 10; STUDY_B section 1d item 7; ELEMENT_LIST "Across three civil jobs"; D-082, D-083, D-118, D-133, D-134.

## E-005 Existing drain

1. **What it is:** A council or other existing drain; prints as a grey dashed band.
2. **How it is drawn today:** A polyline on EX DRAIN HATCH (colour 61, black at 50% screen; linetype PHANTOM) with width = diameter (225 on JOB_C), object linetype scale 0.4, plus a multiline on EX STORMWATER (colour 9, grey; HIDDEN). Stub lines of existing drains also on EX STORMWATER.
3. **Text:** Ordinary MTEXT: "225 DIA COUNCIL STORMWATER PIPE". On CIV-01 the existing council drains are labelled with "depth to be confirmed".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The connection note (E-058); the discharge point; existing pits (E-065).
6. **Facts it would hold in a one-network drawing:** Diameter; owner (council); invert where known, and whether that invert is given or assumed (D-030: no set way of showing what was assumed).
7. **Appears also in:** Legend; connection note; pit schedule row for an existing council pit on an outfall sheet.
8. **Differences seen between jobs:** Measured on JOB_C only.
9. **Existing drain redrawn in the background file:** Where the office wants a surveyed drain to read as an existing drain it redraws it in the background file with its own build: the JOB_C background holds one polyline of width 300 on EX DRAIN HATCH (object linetype scale 0.4) and 2 lines on EX STORMWATER. Surveyed pits and services otherwise stay as the surveyor's lines on the survey layer (STUDY_D section 1.2 item 9)
10. **Conflict (width):** Width 225 on the job drawing (earlier study) against width 300 in the JOB_C background file; the two are different files and were not reconciled (STUDY_D section 1.2 item 9)

Evidence: STUDY_A section 6 item 5, section 2 civil layers 8 and 9; STUDY_B section 1a item 5; STUDY_D section 1.2 item 9.

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
9. **Owner's ruling on the grade printed:** "What the inverts give: 1 in 59": the label always shows the true grade between the two printed inverts, so a checker working from the sheet gets the same figure. A typed grade is the aim; the printed grade is worked out from the rounded levels (D-123)

Evidence: STUDY_A section 6 item 6, section 7 items 5 to 10 and 13, section 3 items 3.1, 5 and 6; DIGEST section 1 item 3; DECISIONS D-012, D-014; D-123.

## E-007 Flow arrow

1. **What it is:** A short arrow beside a pipe showing which way the water runs.
2. **How it is drawn today:** A separate 2-point LEADER (the old leader object, never a multileader) on 25DIMS (colour 7), 750 long, default closed filled arrowhead 300 long, parallel to the pipe. Not linked to the pipe. Most carry the same copied per-object overrides (scale 100, arrow 3, gap 1).
3. **Text:** None.
4. **Standard position / offset as measured:** 150 to 990 off the centreline (typically 170 to 390), on either side. In JOB_C 8 of the 13 parallel arrows sit in the first or last quarter of the run. 7 of the 13 point WITH the direction the pipe was drawn and 6 AGAINST it. 52 of the 82 leaders in JOB_C are exactly 750 long.
5. **What it relates to but is not tied to today:** The pipe's direction of fall (higher invert to lower invert). The older study: "direction should come from levels, not the direction the line was drawn"; it may sit on the other side from the label.
6. **Facts it would hold in a one-network drawing:** None of its own: direction read from the pipe's inverts; its own hand-moved position.
7. **Appears also in:** Master pipe-strip blocks (four flow-arrow leaders each); the "LABELS CIVIL" tool palette.
8. **Differences seen between jobs:** None recorded beyond position.
9. **Owner's ruling on moving the arrow:** The arrow can be moved perpendicular to the line or parallel to it (D-037, quoted under the facts true of every element) (D-037)

Evidence: STUDY_A section 6 item 7, section 4 items 4 to 7, section 7 item 14; DIGEST section 1 item 4; D-037.

## E-008 Pit (all kinds)

1. **What it is:** The plan symbol of a stormwater pit of any size or type.
2. **How it is drawn today:** ONE dynamic block "Stormwater Pit", inserted on layer STORMWATER (colour 9) at scale 1. One visibility list with 16 states: 350x350 Grated pit, 350x350 Junction pit, 450x450 Grated Pit, 450x450 junction pit, 600x600 Grated Pit, 600x600 Junction, 600x900 Grated Pit, 600x900 Junction, 750x750 Grated Pit, 900x900 Junction Pit, 900x900 Grated Pit, 600x1200 Detention Pit, SPS Vertical, SPS Horizontal, Enviss Sentinel, Settling Tank. No attributes. Inside, per state: a square outline polyline on PITS HIDDEN (colour 7, HIDDEN), a mask (wipeout) on STORMWATER PIT, then either a grate hatch (user-defined lines on GRATED TRENCH, colour 9) or two diagonal cross lines on STORMWATER PIT forced to colour 9. The 59 objects of all states are stored in every copy; only 3 to 6 are visible.
3. **Text:** None in the block. See E-012 (tag), E-013 (cover level), E-014 (invert levels).
4. **Standard position / offset as measured:** Usually rotation 0 (square to the sheet). The copy used for the small plastic pits shows a 583 square although pipes stop 175 from its centre; another copy shows 750 square.
5. **What it relates to but is not tied to today:** Its tag; its cover level text; one invert text per connected pipe end; the pipes that stop at its edge; its schedule row(s); for a detention pit, its line in the criteria box.
6. **Facts it would hold in a one-network drawing:** Number; type; size; cover level; each connection's invert (each inlet's "from", dia and invert; the outlet's dia and invert); depth to outlet (S-011); lid type and remarks; whether it holds detention water (S-005). A pit keeps its identity when its tag changes.
7. **Appears also in:** Pit schedule (E-040); criteria box storage list; junction pit and orifice pit details (E-047); legend.
8. **Differences seen between jobs:** Rotated to the pipe on some JOB_A pits (147, 207, 209 degrees); square to the sheet on JOB_B/C. The pit block drawing shipped in the two plug-in bundles differs in size between them.
9. **Which state each pit is set to (decoded):** The chosen state name is held as plain text in each dynamic insert's own data. JOB_C (8 pits on the sheet): six "350x350 Grated pit", one "450x450 Grated Pit" (P2), one "600x1200 Detention Pit" (P1). JOB_B (13): three "350x350 Grated pit", one "350x350 Junction pit", one "450x450 Grated Pit", three "600x600 Grated Pit", two "600x900 Junction", one "900x900 Grated Pit", one "600x1200 Detention Pit". JOB_A (12): eight "450x450 Grated Pit", four "600x600 Grated Pit". One parked sample on each job (STUDY_D section 3.1 items 1 to 3)
10. **Conflict (typed size against state):** The size typed in the pit schedule is NOT always the state drawn: JOB_C's schedule says "2 / 600 x 600" for the pit drawn with the 600x1200 state; JOB_B's sums label pits 900 x 900 and 900 x 600 where the drawing uses other states (STUDY_D section 3.1 item 4)
11. **State names are a ready-made vocabulary:** The 16 state names are already in every drawing and can be read by a program (STUDY_D section 7 item 5)
12. **Owner's ruling on what a pit shows:** A pit shows its inner wall line and its outer dashed / hidden line: "THE PIT AND THE PIT WALL YOURE SHOWING JUST THE INTERNAL PIT WALL LINE AND NOT THE OUTER DASHED/HIDDEN LINE" (D-039)
13. **Owner's ruling on grips:** "WITH THE GRIPS THERE NEEDS TO BE AS MANY AS THERE ARE NOW FOR THE INDIVIDUAL ELEMENTS WITHIN THE OVERALL ELEMENT" (D-033)
14. **Owner's ruling on joining:** A pipe is an element and a pit is an element; they work together but are not one: "I MEANT MORE THAT THOISE 13 ELEMENTS BECOME ONE PIPE AND TWO PITS THAT WORK TOGETHER BUT ARENT ONE FULL ELEMENT, DOES THAT MAKE MORE SENSE? OTHERWISE IT MIGHT GET TOO STICKY?" Where a pipe starts: "I WANT EVERYTHING TO INTERACT AND PLAY NICE TOGETHER, SAY AN END USER WANTS TO DRAW A PIPE FROM ONE PIT TO ANOTHER AND THEY SELECT SOMEWHWERE ON THE PIT I WANT IT TO VISUALLY SHOW IT COMING FROM EXACTLY ON THE PIT WALL IN LINE WITH WHERE THEY CLICKED" (D-031, D-034)
15. **Owner's ruling on pit numbers:** "P1 at the outlet, Renumber button": new pits take the next free number; a Renumber button re-runs them from the outlet working upstream when asked (D-075)
16. **Owner's ruling on plastic pits in the schedule:** "My choice per pit": a tick box "In the schedule" on each plastic pit, starting ticked (D-076)
17. **Owner's ruling on a pit placed on a drawn pipe:** "Split the pipe in two" (D-077; E-001)
18. **Owner's ruling on cover levels:** "Locked on every pit": once typed, only the person can change a cover level; working out levels along a run never touches it (D-078)
19. **Owner's ruling on where a pipe stops:** "At the inner wall line": the solid inner wall, past the dashed outer line (D-102)
20. **Owner's ruling on pit kinds on day one:** Junction, grated, plastic; orifice (control) pit; pump pit and bought-in units. Silt pit and soakage pit were not ticked: later (D-104)
21. **Owner's ruling on pits as detention storage:** "Only pits I tick": volume = plan size times water depth, the depth worked out from the top water level (D-105; S-005)
22. **Owner's rulings on pit size by depth and step irons:** Guidebook table (D-135); step irons deeper than 1.0 m (D-136); see L-006

Evidence: STUDY_A section 6 item 8, section 2 civil layers 12 to 15, section 9 item 7, section 10 item 2; MODEL_NOTES "What it teaches" item 3; STUDY_C section 2D item 7; STUDY_D section 3.1 and section 7 item 5; D-031, D-033, D-034, D-039; D-075, D-076, D-077, D-078, D-102, D-104, D-105, D-135, D-136.

## E-009 Junction pit, grated pit and plastic pit

1. **What it is:** The three everyday pit types as they read on the plan: a cross for a junction (solid lid), a line hatch for a grated pit, and "PP" beside a small grated pit for a plastic pit.
2. **How it is drawn today:** Junction = the cross; grated = the line hatch; both are states of the block in E-008. A plastic pit is the 350 grated state with a loose text "PP" beside it. Nothing in the block says "plastic".
3. **Text:** "PP": height 200 (2.0 mm), MTEXT on 25TEXT, often as the first line of the cover level text ("PP" / "CL 5.65").
4. **Standard position / offset as measured:** As E-013 for the "PP" / cover text.
5. **What it relates to but is not tied to today:** The pit type column of the schedule ("all pits scheduled including plastic ones" is a council request).
6. **Facts it would hold in a one-network drawing:** Type (junction, grated, plastic) as one fact of the pit in E-008.
7. **Appears also in:** Pit schedule; junction pit detail; legend; "PP" tags on the LABELS CIVIL palette.
8. **Differences seen between jobs:** None recorded.
9. **Owner's ruling on plastic pits:** A plastic pit is one of the day-one pit kinds (D-104); each has an "In the schedule" tick box, starting ticked: "My choice per pit" (D-076)

Evidence: STUDY_A section 6 item 9, section 3 item 3.3; STUDY_B section 4 item 1; STUDY_C section 2B; D-076, D-104.

## E-010 Orifice / control pit

1. **What it is:** The two-chamber pit with a baffle wall and orifice that controls the outflow of a detention system.
2. **How it is drawn today:** Still the block in E-008, in a state that shows a crossed chamber and a grated chamber side by side inside a dashed outline, 1650 x 900 overall (pit P1 on JOB_C). Its real description (baffle, orifice, levels) is in the detail and the schedule, not in the symbol.
3. **Text:** Tag, cover and invert texts as other pits.
4. **Standard position / offset as measured:** 1650 x 900 overall (JOB_C). Usually near the discharge point at the low end of the site.
5. **What it relates to but is not tied to today:** The criteria box (head, orifice, top water level); the orifice pit detail drawn with this job's numbers; the connection to the council system.
6. **Facts it would hold in a one-network drawing:** As E-008, plus: top water level; baffle (plate) height; orifice diameter; orifice invert (20 above the outlet invert, inlet 20 above that: S-025); chamber sizes; lid class of each chamber.
7. **Appears also in:** Criteria box (E-041); orifice pit detail (E-047); pit schedule.
8. **Differences seen between jobs:** JOB_A has none (no detention). One council uses a single chamber with a plate (L-007).
9. **Control pit state name:** The orifice / control pit is the state named "600x1200 Detention Pit" (JOB_C P1, one pit on JOB_B). The pit schedule on JOB_C types its size as 600 x 600 (STUDY_D section 3.1 items 1, 2 and 4)
10. **Owner's rulings on the orifice pit:** The orifice (control) pit is one of the day-one pit kinds (D-104). The drop across a pit and the steps in the orifice pit are an "Office standard, can be typed over" (D-084; S-025)

Evidence: STUDY_A section 6 item 10; STUDY_B section 3 item 7; ELEMENT_LIST "Seen as a picture" items 6 and 7; STUDY_D section 3.1; D-084, D-104.

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
9. **Owner's ruling on flip and move:** The pit label can be moved and flipped (D-037, quoted under the facts true of every element) (D-037)
10. **Owner's ruling on numbering:** "P1 at the outlet, Renumber button": see E-008 (D-075)

Evidence: STUDY_A section 6 item 12, section 3 item 3.4, section 8 item 8; MODEL_NOTES "What it teaches" item 3; DIGEST section 3 item 8; D-037; D-075.

## E-013 Cover level

1. **What it is:** The lid (surface) level of a pit, written beside it.
2. **How it is drawn today:** Loose MTEXT on 25TEXT, usually rotated +45 or -45 degrees. (One on JOB_B is plain TEXT on 18TEXT colour 10.)
3. **Text:** Height 200 (2.0 mm); mask on; justification varies (top left, bottom right, top right, middle right). Wording "CL 5.35"; or two lines "PP" / "CL 5.65" for a plastic pit. Parked placeholders "CL _____", "CL ____".
4. **Standard position / offset as measured:** 560 to 1290 from the pit insertion point (JOB_C); not related to a pipe.
5. **What it relates to but is not tied to today:** Its pit; the cover level cell of the schedule; depth to outlet; the orifice pit detail; finished ground or survey levels it was taken from.
6. **Facts it would hold in a one-network drawing:** None of its own: it shows the pit's cover level. (Cover levels are normally fixed on a tight site: D-018.)
7. **Appears also in:** Pit schedule (E-040); orifice pit detail. On JOB_C the control pit's cover level appears 3 times.
8. **Differences seen between jobs:** One plain TEXT on 18TEXT colour 10 on JOB_B. Conflict (colour): the Stage 1 picture reading says "cover level and invert levels in red at each pit"; STUDY_A puts cover levels on 25TEXT (colour 7, prints black) and only invert levels on a red layer. Not settled.
9. **Owner's ruling on flip and move:** Cover level text can be flipped and moved (D-037, quoted under the facts true of every element) (D-037)
10. **Owner's ruling on locking:** "Locked on every pit": once typed, only the person can change a cover level; working out levels along a run never touches it (D-078)

Evidence: STUDY_A section 6 item 13, section 3 items 3.3, 5 and 6, section 7 item 12, section 8 item 1; ELEMENT_LIST "Seen as a picture" items 5 and 7; D-037; D-078.

## E-014 Invert level

1. **What it is:** The level of the inside bottom of a pipe at a pipe end, written beside the pipe.
2. **How it is drawn today:** Loose text, one per pipe end, rotated to the pipe it belongs to. JOB_C: MTEXT on 20TEXT (colour 10, prints red), mask on (four are plain TEXT with no mask). JOB_A and JOB_B: MTEXT on 18TEXT with colour forced to 1, mask on.
3. **Text:** Height 180 (1.8 mm). Bottom-left justified in JOB_C; top-left in JOB_A and JOB_B. Wording "IL 5.13". Parked placeholder "IL _____". Prints red.
4. **Standard position / offset as measured:** Parallel to its pipe; clear gap between the pipe edge and the text 22 to 88 (median 49 to 54 in all three jobs); placed 170 to 900 along from the pipe end; on either side of the pipe.
5. **What it relates to but is not tied to today:** The pipe end and the pit it enters or leaves; the schedule's inlet and outlet invert cells; the pipe's grade in its label; the orifice pit detail.
6. **Facts it would hold in a one-network drawing:** None of its own: it shows the invert of one pipe end at one pit. (The council connection invert is normally fixed on a tight site: D-018. Which inverts change when a pit moves depends on the design: D-016.)
7. **Appears also in:** Pit schedule; orifice pit detail; long section. On JOB_C the control pit's inlet invert appears 5 times (plan, schedule twice, detail twice) and its outlet invert 3 times. About 30 invert texts on that job.
8. **Differences seen between jobs:** Layer, colour and justification differ between JOB_C and JOB_A/B as above.
9. **Owner's rulings on invert text:** "AGI DRAINS DONT HAVE INVERT LEVELS." (D-040). Invert text sits in the same spot on every pipe and slides to avoid a clash (D-041, quoted under the facts true of every element). It can be moved perpendicular or parallel to the line by grip (D-037) (D-037, D-040, D-041)
10. **Owner's rulings on typing over:** Both invert levels of a pipe can be typed over (D-080). The grade in the pipe label is worked out from the two printed inverts (D-123; E-006)

Evidence: STUDY_A section 6 item 14, section 7 item 11, section 3 items 3.2 and 5, section 9 item 3; ELEMENT_LIST "On the plan" item 4 and "Seen as a picture" item 7; D-037, D-040, D-041; D-080, D-123.

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
9. **Owner's ruling on where an inlet goes:** A GIO goes exactly where the drafter clicks along the pipe and can be slid along afterwards; it can also be placed off a pipe (D-050, quoted under the facts true of every element) (D-050)
10. **Owner's ruling on the inspection opening offer:** The owner proposed: "allow it and offer an io if its a bend point in main pipe and theres no io on the main line and the run is long or is this over complicating it?" Filed ruling: a branch joining a pipe with no pit is always allowed; an inspection opening is OFFERED (never forced) when the join is at a bend in the main pipe, the main line has no inspection opening, and the run is long. How long is "long": Unknown (to come from the office list or AS 3500.3, to be looked up). It stays one quiet offer line with its numbers in the office list (D-081)
11. **Owner's ruling on the typed name:** IO is kept: "Keep IO, rename C and RC" (D-054)

Evidence: STUDY_A section 6 item 16, section 3 item 3.5; STUDY_B section 3 items 3 and 14; GUIDEBOOK_NOTES "Elements" item 18; D-050; D-054, D-081.

## E-017 Floor waste

1. **What it is:** A small grated floor outlet ("FW").
2. **How it is drawn today:** Block "FLOOR WASTE DYNAMIC WITH MASK": circle radius 100 on FLOOR WASTE (colour 7), HONEY pattern hatch scale 5, fixed MTEXT, same move and flip parts as the downpipe.
3. **Text:** "FW" height 250 (2.5 mm), masked.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pipe or strip drain it feeds; a schedule "from" cell.
6. **Facts it would hold in a one-network drawing:** Type; what it feeds.
7. **Appears also in:** Legend; tool palette; plug-in bundle block; basement plans.
8. **Differences seen between jobs:** None recorded.
9. **Basement use:** Strip drains (SD) and floor wastes (FW) all over the basement slab with fall arrows; see E-068 (STUDY_D section 4.5 item 2)

Evidence: STUDY_A section 6 item 17, section 2 civil layer 18; DIGEST section 1 item 6, section 2 item 2; STUDY_D section 4.5 item 2.

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
9. **Tank symbol library and tank labels:** The plan-view tank library (CE Civil WATER TANKS PLAN, Sep 2026) holds named blocks for 2500, 3000, 3500, 5000, 6000 litre tanks and one underground 5000, under ABOVE GROUND and UNDERGROUND by shape and make (slimline, round, concrete, donut / bagel, four makes). The current civil A1 template has an above-ground 2,500 litre tank block that the Jan and Oct 2025 copies lack. On sheets: tanks named RWT1 to RWT3 (CIV-11); a modular underground detention tank drawn as a hatched grid with a note giving make, length x width x height and "HOLD MINIMUM 18.2m3 DETENTION VOLUME"; "15000 LITRE UNDERGROUND WATER TANK FOR ON-SITE DETENTION PURPOSES. PROVIDE ORIFICE TO BASE OF TANK" (CIV-15); an in-basement rainwater tank "16.63m2 RAINWATER TANK FOR TOILET FLUSHING AND WATER REUSE" (CIV-10) (STUDY_D section 2.3 item 4, section 2.1 item 3, section 4.4 item 2, 4.8 item 3, 4.5 item 2)

Evidence: STUDY_A section 6 item 19, section 8 item 7, section 2 "Standard versus invented" item 3; DIGEST section 7 item 3; ELEMENT_LIST "Across three civil jobs" item 3; STUDY_D section 2.1, 2.3, 4.4, 4.5, 4.8.

## E-020 Tank note

1. **What it is:** The three-line note on each tank giving total litres, detention litres and reuse.
2. **How it is drawn today:** Loose MTEXT, layer 25TEXT, typed by hand on each tank. JOB_A has a longer one on layer 25CONT.
3. **Text:** Height 250 (2.5 mm), mask on, three lines: "3000 lt WATER TANK" / "1000 lt FOR DETENTION" / "2000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE". CIV-04: "1100 lt for detention". Parked placeholder "____ lt water tank".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Its tank; the criteria box tank line; the tank detail; the STORM report.
6. **Facts it would hold in a one-network drawing:** None of its own: it reads the tank's total, detention and reuse litres.
7. **Appears also in:** Criteria box; tank detail. Each tank's litres appear 3 to 4 times on JOB_C.
8. **Differences seen between jobs:** JOB_A's note is longer and on 25CONT. Real jobs have had tank splits differing between plan and detail on the same stamped sheet.
9. **Owner's ruling on the leader arrow:** The tank note has a leader arrow back to the tank, and that is how the office displays it (a part of the tank element). "WATER TANK TEXT HAS AN ARROW BACK TO WATER TANK ISNT SHOWN IN YOURS BUT THATS HOW WE DISPLAY IT" (D-039)

Evidence: STUDY_A section 6 item 20, section 8 item 7; ELEMENT_LIST "House standards" item 7 and "Seen as a picture" item 7; DIGEST section 3 item 8; D-039.

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
9. **Stretch distances read as zero:** The template's stretchable "TRENCH GRATE" has no state name; its two stretch distances read as zero in the parked samples (sizes come from separate saved copies). JOB_A and JOB_B use plain blocks named "100 / 200 / 300 TRENCH GRATE" (STUDY_D section 3.1 item 5)
10. **Conflict (parked samples):** The earlier study lists parked samples stretched to 100, 150, 200, 300 wide by 1600 or 3100 long; the later decode reads the stretch distances as zero. Not settled (STUDY_D section 3.1 item 5)

Evidence: STUDY_A section 6 item 22, section 2 civil layer 16; ELEMENT_LIST "On the plan" item 8; MODEL_NOTES "What it teaches" item 5; STUDY_D section 3.1 item 5.

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
9. **Owner's ruling:** "AGI DRAINS DONT HAVE INVERT LEVELS." So an agricultural drain carries no invert text (D-040)

Evidence: STUDY_A section 6 item 24, section 2 civil layer 20, section 5 item 11; DIGEST section 2 item 5, section 7 item 3; D-040.

## E-025 Raingarden

1. **What it is:** A planted filter bed that treats driveway water.
2. **How it is drawn today:** No block. A spline and a closed polyline on DRAINAGE with a solid hatch forced to colour 201, plus typed notes (JOB_B). The section and filter specification are pasted detail blocks.
3. **Text:** Typed notes giving the area (CIV-08's sheet labels 3.5 square metres).
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The paved area it treats; the STORM report's raingarden area; its overflow pipe.
6. **Facts it would hold in a one-network drawing:** Area; type; catchment treated; overflow connection. How the area is chosen: Unknown (Q-005).
7. **Appears also in:** Raingarden section and filter layer specification (E-047); STORM report; legend.
8. **Differences seen between jobs:** Only JOB_B of the three. The layer STORMWATER PIPE CHARGED TO RAINGARDEN is in the template only and unused.
9. **Raingarden on plan and in detail (CIV-08):** A small green shape with a note "3.5m2 RAINGARDEN. MIN. 1m2 REQUIRED TO TREAT DRIVEWAY OF DWELLING 1"; "IN-GROUND INFILTRATION RAINWATER GARDEN TYPICAL SECTION" with layer callouts (50 gravel mulch, 500 filter media, 100 transition, 300 drainage) and "NOTE: BOTTOM OF RAINGARDEN UNLINED HENCE AGI DRAIN NOT REQUIRED". The details library: heading RAINGARDEN, SWALE, GRASSED SWALE, BUFFER STRIP, LEGEND, then 33 job references each with that job's raingarden section; an area note "TOTAL AREA: 31m2 DRAINING 396m2 OF CAR PARK"; one named block "RAINGARDEN NO LINING" (STUDY_D section 4.2 items 4 and 5, section 2.3 item 6)
10. **How the area is chosen (answered in part):** In three jobs (CIV-09, the architect's earlier report, CIV-08) the area typed into the STORM report is a round 1.00 m2, chosen so the total passes 100%, and the drawn raingarden is as big or bigger. No separate sizing sum exists. 1.00 m2 treating 49.8 m2 of roof is 2.0% of the area draining to it and scores 128%; the earlier report used 1.00 m2 for 61.76 m2 (1.6%) (STUDY_D section 5.5 item 6)
11. **Other raingarden labels:** CIV-14: "ROOF CATCHMENT TO RAINGARDEN", "TO VEGETABLE RAINGARDEN", "RAINGARDEN DETAIL". CIV-07: a "BUFFER STRIP" legend swatch and "TYPICAL BUFFER STRIP DETAIL" (STUDY_D section 4.7 item 2, section 4.1 item 5)

Evidence: STUDY_A section 6 item 25, section 2 civil layer 4; STUDY_B section 1h items 6 and 7; DIGEST section 2 item 6; STUDY_D section 2.3 item 6, 4.1, 4.2, 4.7, 5.5.

## E-026 Overland flow arrow

1. **What it is:** A broad arrow showing the path of surface water in a big storm.
2. **How it is drawn today:** Block "OVERLAND FLOW PATH" on OVERLAND FLOW (colour 34, prints own colour at 30%): one arrow-shaped polyline 1614 x 576 with a solid hatch. Label is a loose MTEXT. Parked on JOB_C.
3. **Text:** Label height 180 (1.8 mm).
4. **Standard position / offset as measured:** 1614 x 576 arrow. Placement not measured.
5. **What it relates to but is not tied to today:** Surface levels and falls; the 1 in 100 storm note.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Legend (councils ask for overland flow arrows and legend).
8. **Differences seen between jobs:** Parked only on JOB_C.
9. **Overland flow break in kerb:** CIV-11: "PROVIDE 500 WIDE BREAK IN KERB TO ALLOW FOR OVERLAND FLOW PATH AT 1% AEP" (STUDY_D section 4.4 item 2)

Evidence: STUDY_A section 6 item 26, section 2 civil layer 21; GUIDEBOOK_NOTES "Elements" item 15; STUDY_B section 4 item 1; STUDY_D section 4.4 item 2.

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
9. **Basement slab levels:** Basement plans carry "SSL 16.60" style slab surface levels (CIV-10) (STUDY_D section 4.5 item 2)

Evidence: STUDY_A section 6 item 28, section 3 items 3.7, 5 and 6; ELEMENT_LIST "On the plan" item 5; STUDY_D section 4.5 item 2.

## E-029 Finished ground level and pavement level tags

1. **What it is:** A spot level on finished ground or paving, with a small cross tick.
2. **How it is drawn today:** Dynamic block (machine name only, no proper name) with attribute tag "LEVEL" (default "P__.__", on 20TEXT, colour 10), a small X tick (two 141-long lines) and move grips. A second block family "RL LEVEL" / "RL___" (attribute "RL__.__", with a filled triangle) is parked. Layer PAVEMENT LEVELS (colour 7) is used in the legend only on these jobs.
3. **Text:** "LEVEL" attribute height 200 (2.0 mm); values typed "FGL 6.15". "RL" attribute height 250 (2.5 mm). Parked samples "P__.__", "P00.00", "RL__.__", "NGL ___", "00.00".
4. **Standard position / offset as measured:** Not measured. Councils ask for spot levels at corners and near pits.
5. **What it relates to but is not tied to today:** Survey levels; pit cover levels; fall arrows.
6. **Facts it would hold in a one-network drawing:** The level; its kind (finished ground, pavement); where it came from.
7. **Appears also in:** Tool palette (RL tags, pit level tags); plug-in bundle block (spot level).
8. **Differences seen between jobs:** None recorded.
9. **Level grids and path grades:** See E-071 (grid of red pavement levels with fall arrows on a car park; path grades written as "1:22 14%") (STUDY_D section 4.4 item 2, 4.8 item 3)

Evidence: STUDY_A section 6 item 29, section 2 civil layers 23 and 24, section 8 item 1; GUIDEBOOK_NOTES "Elements" item 17; STUDY_D section 4.4 item 2, 4.8 item 3.

## E-030 Existing levels, bench mark, title boundary, bearings, easement, street name, contours

1. **What it is:** The survey and title information under the design.
2. **How it is drawn today:** Not in the job drawing. They print from the background reference (E-056). Layer names seen inside the background: A-TITLE BOUNDARY (colour 2, DASHDOT2), BOUNDARY, EASEMENT (colour 6, DASHED), A-SURVEY, CONTOURS, TPZ, TREE, SEWER, G-ANNO-TEXT. In the job file the layers BOUNDARY (colour 2, DASHDOT), EASEMENT (colour 6, DASHED), FENCE (11), DRIVEWAY (254), SURVEY (253) exist but are empty. "MATCH EXISTING LEVELS" is a loose MTEXT in the job with a pointer leader.
3. **Text:** Unknown (inside the background file, not opened): Q-101. Superseded by STUDY_D section 1.2 items 1 to 10, 16 Nov 2026.
4. **Standard position / offset as measured:** Unknown: Q-101. Superseded by STUDY_D section 1.2 items 1 to 10, 16 Nov 2026.
5. **What it relates to but is not tied to today:** Cover levels and finished levels are picked from the survey levels; the discharge point sits on the boundary side.
6. **Facts it would hold in a one-network drawing:** Survey levels as the source of cover levels.
7. **Appears also in:** Outfall plan offsets from the title boundary.
8. **Differences seen between jobs:** JOB_A shows survey contours and bearings and distances on boundaries.
9. **Title boundary line:** Plain LINEs (4 in JOB_C and JOB_B) or one polyline of width 20 to 30 (JOB_A, JOB_B) on layer A-TITLE BOUNDARY, colour 2, linetype DASHDOT2, by layer. Not a block (STUDY_D section 1.2 item 1)
10. **Boundary lengths and bearings:** Plain TEXT on A-TITLE BOUNDARY. JOB_C: height 250, style ISO, one text per side holding both, rotated to the side (0 or 90), pattern length then bearing ("42.67m - 187 deg 19'40""). JOB_B: height 450, length and bearing as two separate texts ("44.03M" and "186 deg 17'"), surveyor's fonts. JOB_A: MTEXT height 250 on G-ANNO-TEXT (colour 2), pattern "40.14m  82 deg 4'30"". No fixed height: the office retypes or keeps the surveyor's (STUDY_D section 1.2 item 2)
11. **Easements:** JOB_A: 4 plain LINEs on EASEMENT (colour 6, DASHED) plus surveyor's easement lines on A-SURVEY with imported linetypes. JOB_B: none drawn (a sample on A-EASEMENT only). JOB_C: none. No easement text standard was found (STUDY_D section 1.2 item 3)
12. **Street name:** JOB_C: one MTEXT, height 400, letter-spaced, on A-ARCH BACKGROUND with colour forced to 2. JOB_B: one TEXT, height 400, letter-spaced, rotated 90, on A-TITLE BOUNDARY. JOB_A: none in the file (STUDY_D section 1.2 item 4)
13. **Bench mark box:** JOB_C: two TEXTs height 300 ("TBM RIVET", "RL:5.31") inside a closed 4-point polyline, all on A-ARCH BACKGROUND with colour forced to 2 (prints black 0.35). JOB_B: three TEXTs (220 to 250 high) and a closed polyline of width 10 with a mask, on the surveyor's own layer, colour forced to 2, plus a surveyor's symbol block at scale 400. Loose objects, not an office block (STUDY_D section 1.2 item 5)
14. **Survey spot levels:** JOB_C: plain TEXT height 200 on CONTOURS AND LEVELS (colour 45), rotated 45 degrees or to the contour, e.g. "5.39"; no cross symbol. JOB_B: plain TEXT height 220 on A-SURVEY (colour 11), value only, with a small surveyor's cross block "056" at scale 100 at some points. JOB_A: MTEXT height 300 on A-SURVEY with colour forced to 250, each with a 2-line cross block at scale 800 (76 of them) (STUDY_D section 1.2 item 6)
15. **Contours:** JOB_C: 42 plain LINEs on CONTOURS AND LEVELS with object linetype scale 0.5 (the layer linetype in that file is the lettered SEWER type, an accident of the clean-up), labels as TEXT 200. JOB_A: 123 polylines on CONTOURS (colour 34), majors forced to colour 33, imported dashed linetype on some, labels MTEXT height 500. JOB_B: none (STUDY_D section 1.2 item 7)
16. **Kerb and channel, footpath, crossover:** Plain LINEs on SURVEY / A-SURVEY (JOB_C 237 lines; JOB_B 208 lines and 13 polylines) with the surveyor's words as text ("EXISTING CROSSOVER" height 300 in JOB_C, 180 in JOB_B). No office kerb layer is used in the background (STUDY_D section 1.2 item 8)
17. **Neighbours' buildings:** Lines on SURVEY with MTEXT labels height 400 ("ADJOINING CARPORT", "SINGLE STOREY ... RESIDENCE") and house numbers height 700 (JOB_C). JOB_B: on A-ARCH BACKGROUND with colour forced to 250 and MTEXT height 300 (STUDY_D section 1.2 item 10)

Evidence: STUDY_A section 6 item 30, section 1 item 14.6, section 2 civil layer 43, section 10 item 1; OPEN_QUESTIONS Q-101; STUDY_D section 1.2 items 1 to 10.

## E-031 Tree protection zone

1. **What it is:** The no-dig circle round a tree to be kept (TPZ), and the inner structural root zone (SRZ).
2. **How it is drawn today:** Arcs and lines on TPZ (colour 2, HIDDEN) drawn by hand (12 arcs on JOB_B), a hatch (ANSI31 on a HATCH layer, forced colour) and plain TEXT "TPZ" / "SRZ" (SRZ forced to colour 233). The tree symbol is a pasted architect block on TREE at scale 160.
3. **Text:** Plain TEXT height 280 (2.8 mm). Wording "TPZ", "SRZ".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The arborist report; pits and pipes kept out (L-013); the tree protection note.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Legend; tree protection note. Prints as green hatch.
8. **Differences seen between jobs:** JOB_B only (12 arcs). TREE layer colour 65 in JOB_C and the template, 73 in JOB_A/B and the master.
9. **Tree drawn in a cleaned background:** JOB_C: 608 LINEs and 8 CIRCLEs on TREE EXISTING (colour 53): the canopy is an exploded architect symbol, the trunk a small circle. Tree protection circles are CIRCLEs and ARCs on TPZ (colour 2, HIDDEN), inner root zone forced to colour 233, radius typed from the arborist (1,600 to 2,500). JOB_B: canopies are 22 CIRCLEs and 529 LINEs on A-LANDSCAPE (colour 73). The green tree-zone hatch seen on paper is drawn in the background file on a HATCH layer (ANSI31, scale 100; JOB_C layer HATCH 70) (STUDY_D section 1.2 item 16)
10. **Conflict (tree symbol):** The earlier study found the tree symbol as a pasted architect block on TREE at scale 160 and 12 TPZ arcs on JOB_B; the cleaned JOB_C background has exploded lines and typed circles. Different files; not reconciled (STUDY_D section 1.2 item 16)
11. **Tree protection requirements box:** CIV-15 carries a yellow box "SPECIFIC REQUIREMENTS FOR ALL WORKS WITHIN TREE PROTECTION ZONES" (ten bullets from the arborist) and many large tree-zone circles in green hatch (STUDY_D section 4.8 item 3)

Evidence: STUDY_A section 6 item 31, section 2 civil layer 39, section 3 item 3.13; ELEMENT_LIST "Seen as a picture" item 2; STUDY_D section 1.2 item 16, section 4.8 item 3.

## E-032 Existing services

1. **What it is:** Sewer, water, gas, telecom and overhead power lines already on the site.
2. **How it is drawn today:** Plain LINEs on SEWER, WATER, GAS, TELSTRA (all colour 9) and ELEC OVERHEAD (colour 251) with the lettered linetypes (SEWER, WATER, GAS_LINE, TELSTRA, ELECTRICITY) and an object linetype scale (0.1, or 2.0 for gas). A large sewer is a 700-wide polyline with circle and arc ends, forced colours 233 and 242.
3. **Text:** Size note as plain TEXT: "EX. 750 DIA. SEWER MAIN". CIV-08: the sewer main labelled with offset and depth.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Clearances (1 m from sewer ties; 150 at a crossing: L-013); the before-you-dig block.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence, beyond size, offset and depth where a crossing is checked.
7. **Appears also in:** Legend; long section (councils ask for existing services shown on it); service crossing section.
8. **Differences seen between jobs:** Not compared.
9. **Sewer in a background file:** JOB_A background: the sewer is 2 LINEs on SEWER (lettered linetype, object scale 0.1), 2 circles and 2 TEXTs height 250 ("150mm PVC SEWER MAIN", "2.1m DEEP APPROX") (STUDY_D section 1.2 item 9)
10. **Services crossing a long section:** Shown as an ELLIPSE (a round pipe squashed by the exaggeration) at the service's depth, a thin dash-dot vertical line through it, and stacked rotated labels ("HIGH PRESSURE / GAS PIPELINE / DEPTH UNKNOWN", "WATER MAIN / DEPTH UNKNOWN", "TELECOM LINE / DEPTH UNKNOWN", an existing sewer with offset and depth) (STUDY_D section 2.6 item 12)

Evidence: STUDY_A section 6 item 32, section 2 civil layer 40, section 5 items 7 to 10; STUDY_B section 1e item 6, 1h item 7; STUDY_D section 1.2 item 9, section 2.6 item 12.

## E-033 Slab and pavement hatches

1. **What it is:** The fills that show driveway slab, building footprint and special paving.
2. **How it is drawn today:** Solid hatches on HATCH 21 (driveway; layer colour 49 in the jobs, 21 in the template) and HATCH 141 (building; colour 149 in JOB_C), some associative and some not, with boundaries on HATCHOUTLINE (colour 215, does not plot) or none. JOB_B: ANSI31 scale 50 on HATCH 150 (permeable paving).
3. **Text:** None.
4. **Standard position / offset as measured:** Not applicable.
5. **What it relates to but is not tied to today:** The impervious areas used in the sums (roof, paving); the driveway pavement detail.
6. **Facts it would hold in a one-network drawing:** Area and kind (roof, paving, pervious), each named and counted once, for S-001.
7. **Appears also in:** Legend; computations (areas). On paper: driveway pale grey, building light blue.
8. **Differences seen between jobs:** Permeable paving only on JOB_B. JOB_A/B carry extra hatch layers not in the template (CONCRETE HATCH, HATCH 14, HATCH 240, HATCH DECK, AREA OF INTEREST HATCH). Why HATCH 21 (colour 49) prints grey is not explained by the decoded plot style table (Q-103). Superseded by STUDY_D section 3.2, 16 Nov 2026.
9. **Why the driveway prints grey and the building light blue:** Viewport colour overrides on the layers (HATCH 21 -> colour 21 = black at 20%; HATCH 141 -> colour 141 = own colour, light blue, at 25%) through the sheet viewport; in model space the layers are 49 and 149. Measured on the issued JOB_C sheet: building footprint red 223, green 247, blue 255; driveway 204, 204, 204. The older Bayside job-as-template sets HATCH 51 to colour 51 directly instead (STUDY_D section 3.2 items 2 to 5)
10. **Other hatch facts:** Tank symbols use real gradients (two blues) on HATCH WATER; batter fills are colour 250 forced; downpipe dots are solid by layer (red) (STUDY_D section 3.2 item 6)

Evidence: STUDY_A section 6 item 33, section 2 civil layers 35 and 36 and "Standard versus invented" item 3, section 10 item 3; STUDY_D section 3.2.

## E-034 Saw cuts and joints

1. **What it is:** The joint lines in a concrete driveway: saw cut (SC), construction joint (CJ), tool joint (TJ).
2. **How it is drawn today:** Saw cut = plain LINE on SAWCUT (colour 2, DASHDOT2) with a loose MTEXT "SC" rotated 90. The parked tag block has attribute "TAG" (values "SC", "CJ", "TJ") on layer "25TEXT - JOINT TEXT". Construction joint layer CONSTRUCTION JOINT (colour 3): linetype PHANTOM_CJ in JOB_C and the template, CENTER2 in JOB_A and JOB_B, PHANTOM in the master.
3. **Text:** "SC" height 250 (2.5 mm), masked, rotated 90.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The slab outline; the saw cut and construction joint details.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Saw cut detail, construction joint detail (E-047); legend.
8. **Differences seen between jobs:** Construction joint linetype differs in three places as above.
9. **Owner's ruling:** Saw cuts are only drawn if the drafter draws them; a slab does not require them (D-050, quoted under the facts true of every element) (D-050)

Evidence: STUDY_A section 6 item 34, section 2 civil layers 32 to 34, section 9 item 8; D-050.

## E-035 Section mark and detail title

1. **What it is:** The mark on the plan that points to a detail, and the title under a detail.
2. **How it is drawn today:** "TAG SECTION MARK" (attributes "SEC" and "DWG", stretch / rotate / two flips) and "Section Title" (attributes "SECTIONMARK", "SECTIONSHEETNUMBER", fixed text "SECTION" and "SCALE 1:20"). Both are drawn at paper size and inserted at scale 100. Parked only on JOB_C. Detail titles on the sheet are mostly MTEXT inside each detail block.
3. **Text:** Detail titles inside blocks: height 500 (5.0 mm) on 50TEXT.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The detail it points to and the sheet number it is on.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Details.
8. **Differences seen between jobs:** Parked only on JOB_C.
9. **Sections on outfall sheets:** "SECTION A-A" at 1:20 across the outfall trench (CIV-05, CIV-10) (STUDY_D section 2.6 item 16)

Evidence: STUDY_A section 6 item 35, section 2 civil layer 45; STUDY_D section 2.6 item 16.

## E-036 North point and scale bar

1. **What it is:** The north arrow and the bar scale.
2. **How it is drawn today:** Inside the title block in paper space (layers 0-NORTH and 0-SCALE BAR; bar segments are polylines of width 1). A block "MOC" is inserted on the plan at scale 0.45 to 0.5 on JOB_A and JOB_B (not opened; likely a north point, unconfirmed). Superseded by STUDY_D section 3.3, 16 Nov 2026.
3. **Text:** Scale bar text 2.5 (paper space).
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The viewport scale.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Title block (E-043).
8. **Differences seen between jobs:** "MOC" on JOB_A and JOB_B only. What "MOC" is: Unknown (Q-103). Superseded by STUDY_D section 3.3, 16 Nov 2026.
9. **What MOC is:** The "no digging" pictogram: a digger under a red circle-and-bar in a rounded square. 55 objects (three solid hatches, polylines and lines) all on layer 25CONT, about 6,900 x 4,000 as drawn. Inserted once per sheet on layer STORMWATER at scale 0.45 to 0.5, beside the optic fibre warning box under the top row of boxes. JOB_C does not have it (it has the newer "before you dig" logo block). It also sits on the basement structural S01 template. It is NOT a north point; the north point is in the title block (STUDY_D section 3.3 items 1 to 3)

Evidence: STUDY_A section 6 item 36, section 10 item 6; STUDY_D section 3.3.

## E-037 Warning boxes (top row)

1. **What it is:** The row of coloured read-this boxes along the top edge of the sheet.
2. **How it is drawn today:** Each is its own machine-named block inserted on STORMWATER at scale 0.967. Inside: a solid hatch on HATCH 51 (colour 250), an outline on HATCHOUTLINE, one MTEXT, and a nested dynamic "shadow box" (two polylines on 35CONT, one of width 150 forming the drop shadow, stretchable).
3. **Text:** MTEXT height 250 to 300 (section 6) or 240 to 300 (section 3) in the same study.
4. **Standard position / offset as measured:** Along the top edge of the sheet.
5. **What it relates to but is not tied to today:** Nothing on the network. Risk notes on the plan are boxed, often red, placed at the spot they concern.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Every sheet (part of the fixed frame).
8. **Differences seen between jobs:** Same on all three. On paper: yellow box, black shadow; why colour 250 prints yellow is not explained (Q-103). Superseded by STUDY_D section 3.2, 16 Nov 2026.
9. **Why the boxes print yellow:** The fills carry no colour of their own: every solid hatch on HATCH 51, HATCH 21 and HATCH 141 is colour by layer, no true colour, gradient off. Each of four layers carries a viewport colour override for both viewports of the layout: HATCH 51 -> 51, HATCH 21 -> 21, HATCH 141 -> 141, HATCH 74 -> 74. In model space the same layers are 250, 49, 149 and 117. The plot style table then prints colour 51 as its own colour (pale yellow) at 25% screen. Measured on the issued JOB_C sheet: yellow boxes red 255, green 255, blue 223. A new layout or viewport without the four overrides prints dark grey boxes (STUDY_D section 3.2 items 1 to 5)

Evidence: STUDY_A section 6 item 37, section 3 item 3.13, section 10 item 3; DIGEST section 1 items 1 and 10; STUDY_D section 3.2.

## E-038 Notes blocks

1. **What it is:** The standing notes: general notes, council notes, the disclaimer, the before-you-dig block, charged system notes.
2. **How it is drawn today:** Each is ONE block holding one long MTEXT plus a shadow box: general notes, council notes, the disclaimer ("CVL DISCLAIMER NOTE") and the before-you-dig block. Inserted on BLOCKS (BYDA for before-you-dig, scale 0.5). To change a word the drafter edits inside the block. General notes and council notes are machine-named blocks.
3. **Text:** MTEXT height 250 (2.5 mm) or 280 (disclaimer); bullets and paragraph settings.
4. **Standard position / offset as measured:** General notes column on the right; council notes and charged-system notes bottom-right beside the title block.
5. **What it relates to but is not tied to today:** The council (its own notes block; one council alone had at least 27 different note blocks depending on the job's conditions); the assumed discharge invert (the council notes say the invert at the discharge point is assumed).
6. **Facts it would hold in a one-network drawing:** Which council, so the right notes come with it.
7. **Appears also in:** Details file headings by council.
8. **Differences seen between jobs:** Council's own notes block (JOB_C); tree protection note; neighbour's footing note; retaining wall note; soakage assumptions note. The standard is quoted with three different years on real jobs.
9. **Kingston's notes library and other council notes:** Kingston has a whole drawing of council standard-drawing tiles (3 layouts, 6 model-space headings, 27 numbered tiles, 39 machine-named blocks, on an old A3 sheet); other council note blocks sit inside the details file under headings KINGSTON NOTES and MARIBYRNONG NOTES, and parked in the A1 template (Manningham; Casey commercial). The Bayside notes exist only inside a finished job saved as the Bayside template (STUDY_D section 2.3 item 8, section 2.1 items 1 and 2)
10. **Pump control notes:** CIV-07 carries a PUMP NOTES box (items a to f, from the standard), a PUMP CONTROL PANEL NOTE (dual adaptor for a generator, battery backup), a CONTROL PANEL NOTE with a small picture of the panel ("to be mounted on the external wall") and a large-type box "NOTE: FULLY TANKED PUMP PIT. COUNCIL DOES NOT ACCEPT SUB-SURFACE WATER AND GROUNDWATER INTO THE PUMP SYSTEM" (STUDY_D section 4.1 item 4)
11. **Retaining wall note and shared drainage notes:** CIV-15: a RETAINING WALL NOTE box. Basement jobs: "AN AGREEMENT SHALL BE MADE AMONG DWELLING OWNERS FOR THE MAINTENANCE OF THE SHARED DRAINAGE AND RAINWATER RE-USE ASSETS..." and "NOTE: WATER FROM FLOOR WASTES AND STRIP DRAINS MUST BE COLLECTED AND TREATED PRIOR RE-USE" (STUDY_D section 4.8 item 3, section 4.5 item 3)
12. **Standing notes that travel with a long section:** An "OUTFALL DRAIN NOTES" block (reinstatement of footpath, kerb and nature strip to council satisfaction) and, on CIV-05, a yellow NOTES box of eight council conditions (STUDY_D section 2.6 item 15)

Evidence: STUDY_A section 6 item 38, section 8 item 3; ELEMENT_LIST "Seen as a picture" items 1 and 8 and "Across three civil jobs" moving part 3; MODEL_NOTES "What it teaches" item 8; DIGEST section 3 item 8; STUDY_D section 2.1, 2.3, 2.6, 4.1, 4.5, 4.8.

## E-039 Legend

1. **What it is:** The full civil works legend.
2. **How it is drawn today:** Block "CIVIL LEGEND", inserted on BLOCKS at scale 1, 9250 x 30,190. 224 objects: sample pipes (polylines of width 150 and 225 on the real pipe layers), lines, 40 texts, small nested symbols.
3. **Text:** Heights 250 / 200 / 180.
4. **Standard position / offset as measured:** Right-hand strip of the sheet with the general notes.
5. **What it relates to but is not tied to today:** Nothing: a symbol in it does not mean the item is on the job.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** Every sheet.
8. **Differences seen between jobs:** Identical on all three jobs; not edited per job.
9. **Legend moved:** CIV-08 sheet 1: the CIVIL WORKS LEGEND sits at the bottom left; CIV-11: legend and general notes top right; CIV-15: legend top right. Pavement legend swatches: see E-073 (STUDY_D section 4.2 item 1, 4.4 item 1, 4.8 item 1)
10. **Owner's ruling on the legend:** Detention pipe is its own kind, on its own layer, in a slightly different blue, and "we will need to update the legend as well": the legend gains a line for it. The line itself is not yet drawn: Unknown (D-083)

Evidence: STUDY_A section 6 item 39; DIGEST section 1 item 11; STUDY_D section 4.2, 4.4, 4.8; D-083.

## E-040 Pit schedule

1. **What it is:** The ruled list of every pit with its size, inlets, outlet, cover level, depth and lid.
2. **How it is drawn today:** NOT an AutoCAD table. The dynamic block "Pit Schedle" (spelt that way) on BLOCKS: 13 lines and 4 polylines on SCHEDULE (colour 7), 12 heading MTEXTs, a title, a note. 17,200 wide. One dynamic distance "ROW NUMBERS" with a stretch and an array action adds rows 1500 apart. The CELL VALUES are loose MTEXTs lying on top of the block: layer 25TEXT, each in a text box 1000, 1500 or 2000 wide (4200 for remarks, 1100 for pit number).
3. **Text:** Cell text 250, middle-centre, no mask (remarks middle-left); column headings 250 on 35TEXT; title 500; small note 180.
4. **Standard position / offset as measured:** Directly under the plan, beside the criteria box. Rows 1500 apart; block 17,200 wide.
5. **What it relates to but is not tied to today:** Every pit, its pipes and levels on the plan; the depth sum.
6. **Facts it would hold in a one-network drawing:** None of its own: every cell is read from the pits and pipes.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md` for columns and build.
8. **Differences seen between jobs:** 2 rows (JOB_C: 26 loose cells for 2 pits) to 20-odd rows; a pit with several inlets takes several rows with the repeated cells left empty; remarks carry lid class and silt pit levels.
9. **Rows seen in more recent jobs:** CIV-11: 8 pits over about 20 rows (each inlet its own row: from P6, DP, AGI, TG, WT2, ACO), lids "Class D Solid Lid With Step Irons" and "Class D Grated Lid With Step Irons", a twin pit "1 / 900 x 900 + 1 / 900 x 900"; a yellow "PIT SCHEDULE NOTE" ("PITS P1 / P2 / ... ARE ALL TO HAVE [make] LITTER BASKET"). CIV-10: a pit "JP1" ("New Junction Pit to Council Standard ..."); the pump well as a row ("SPS / 1500 DIA x 2750") with inlets from "HLs", remarks "SUMP PIT PIT IL ...", "SILT PIT PIT IL ...", "PUMP AS PER MANUFACTURER'S SPECIFICATIONS". CIV-12: kept as its own workbook and PDF (5 pits plus the well) with the same columns as the sheet. CIV-08 remarks: "Silt Pit IL 4.13 Class B Grate", "Plastic Pit Class A Grate" (STUDY_D section 4.4 item 5, 4.5 item 6, 5.3 item 5, 4.2 item 6)
10. **Owner's ruling on how it is placed:** "Placed once, then follows the pits": type SH, pick where it goes; it draws in the office's layout (ordinary lines and text) and then updates itself whenever a pit or pipe changes (D-109)
11. **Owner's ruling on typed-over cells:** "Yes, with a padlock like everything else": a cell normally reads the pit; typed over it is held and shows a closed padlock; one click lets it follow the pit again (D-103)
12. **Owner's ruling on rows besides the numbered pits:** The existing council pit connected to; a pump well; plastic pits that are ticked (D-110, D-076)
13. **Wording read off three issued sheets:** Title, column headings and three standing notes, identical on all three: see `drafting\TABLES_AND_BOXES.md` section 1 items 14 to 16 and `standards\wording_patterns.csv`. A pit with several inlets takes one schedule row per inlet (16 rows for 12 pits on one job) (D-113)
14. **Owner's ruling on a long schedule:** "It runs long; I make room": one block that grows downward; the plugin only warns that it may not fit (D-114). What happens on the sheet when a long schedule will not fit its spot beyond that warning: not asked again (D-114)

Evidence: STUDY_A section 6 item 40, section 3 item 3.10; ELEMENT_LIST "Seen as a picture" item 3 and "Across three civil jobs" moving part 6; DIGEST section 1 item 6; STUDY_D section 4.2 to 4.5, 5.3; D-076, D-103, D-109, D-110, D-112, D-113, D-114.

## E-041 Detention criteria box

1. **What it is:** The box that states the detention design: permitted discharge, head, orifice, top water level, volume required and each storage.
2. **How it is drawn today:** A rectangle polyline on DRAINAGE; a heading MTEXT on layer HATCH 11 with colour forced to 3 (prints green); ONE body MTEXT on 25TEXT with a line per quantity and tab characters between the name and the value. All typed.
3. **Text:** Heading "ON SITE DETENTION CRITERIA" height 350 (3.5 mm); body 250 (2.5 mm); no mask. Lines: "PERMITTED SITE DISCHARGE <tab> 6.00 l/s", "HEAD ... 380mm", "DIA. OF ORIFICE ... 69mm", "TWL ... 5.20m", then the storages.
4. **Standard position / offset as measured:** Directly under the plan beside the pit schedule, at the downstream end.
5. **What it relates to but is not tied to today:** The sums (S-003, S-006, S-007); the orifice pit; each tank, detention pipe and pit named in it.
6. **Facts it would hold in a one-network drawing:** None of its own: all read from the job facts and the network.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md` for rows.
8. **Differences seen between jobs:** JOB_C: tanks only. JOB_B: every pit, pipe and tank listed. JOB_A: no box at all.
9. **Rows on later jobs:** CIV-11: "SITE PERMITTED SITE DISCHARGE", HEAD, DIA. OF ORIFICE, TWL, TOTAL VOLUME REQUIRED, then the modular tank by name, TOTAL. CIV-15: PERMITTED SITE DISCHARGE, HEAD (1230mm), DIA. OF ORIFICE, TWL, VOLUME REQUIRED, "UNDERGROUND WT", TOTAL. CIV-09 (JOB_B): the box lists every storage, 6.36 provided against 5.35 required, with twin 225 detention pipes at 1 in 200 (STUDY_D section 4.4 item 4, 4.8 item 4, 5.5 item 8)
10. **Owner's rulings on the box and its window:** "One 'Detention' window for the job" holds what is fixed, the volume needed, the storage you have and the orifice, and fills the criteria box on the sheet (D-099). Its answer is "Both, side by side": storage against what is needed, and discharge against what is permitted (D-106). Methods in the first release: Boyd's method and OSD4W / Swinburne (D-098)

Evidence: STUDY_A section 6 item 41, section 3 items 3.11 and 8; ELEMENT_LIST "Seen as a picture" item 4 and "Across three civil jobs" moving part 1; STUDY_D section 4.4, 4.8, 5.5; D-098, D-099, D-106.

## E-042 Site / roof area box

1. **What it is:** A box of site area and impervious area figures, where a council asks.
2. **How it is drawn today:** The civil template parks a "SITE INFO AND CALCULATIONS" sample. On JOB_C the roof areas are one MTEXT in a rectangle (E-021).
3. **Text:** Site area, total impervious area, "and more not yet read".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The areas in the sums (S-001).
6. **Facts it would hold in a one-network drawing:** None of its own: site, impervious and pervious areas counted once.
7. **Appears also in:** Computations.
8. **Differences seen between jobs:** Used "where a council asks".
9. **Owner's ruling on where a site area comes from:** "Picked off the drawing, or typed": an area picked from a closed outline stays linked and updates if the outline changes, or it is simply typed; each shows where it came from (D-107). Adds: "site areas might be able to come from council documents": a third source on the same fact; the first release marks such a figure "given" (D-108)

Evidence: STUDY_A section 6 item 42; ELEMENT_LIST "Tables and boxes" item 2; STUDY_B section 2 outputs item 2; D-107, D-108.

## E-043 Title block

1. **What it is:** The sheet border and title panel.
2. **How it is drawn today:** Block "R- TITLE SHEET" in paper space at 0,0, scale 1, 795 x 567. It has NO attributes. 106 objects: border and ruling lines on 0-TITLE and 0-TITLE BLOCK, fixed labels as plain TEXT, the job's own values as plain TEXT inside the block (changed by editing the block), the office logo image, the scale bar, the reduced-plot note. Two fields: the drawing number shows the layout tab name ("C01"); the office address is a hyperlink field.
3. **Text:** Heights 1.5, 2.0, 2.5, 3.0, 4.0 in paper space. Fixed labels: "DRAWING No:", "REVISION:", "DATE:", "APPROVED:", "DESIGNED:", "DRAWN:", "ORIGINAL SIZE:", "SCALE:", "TITLE:", "PROJECT:", "CLIENT:", "JOB NO:", "REVISION DESCRIPTION", "No.", "APPROVED", "DRAWN", "CHECKED", "DATE".
4. **Standard position / offset as measured:** Paper space 0,0.
5. **What it relates to but is not tied to today:** The job facts (project, client, job number); the revision rows; the issue stamp.
6. **Facts it would hold in a one-network drawing:** Job facts typed once.
7. **Appears also in:** See `drafting\TITLE_BLOCK_AND_ISSUE.md`.
8. **Differences seen between jobs:** Same on all three. Text styles "x-sheet$0$..." inside it came from a bound reference.
9. **Two title strip orientations:** Vertical title strip on CIV-05, 07, 08, 14, 15; horizontal strip along the bottom on CIV-10 and CIV-11. The civil template folder only has the vertical one; how horizontal civil sheets are made: Unknown. The structural horizontal title block (Sep 2026) has separate revision-letter texts for structural and civil and five stamp layers including two preliminary stamps ("checked" and "not checked" by a named person) (STUDY_D section 2.1 items 6 and 7)

Evidence: STUDY_A section 6 item 43, section 1 item 8, section 3 items 2 and 3.14; STUDY_D section 2.1 items 6 and 7.

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
9. **Tender stage in use:** CIV-15 (council is the client): revision list shows P1 to P3 (preliminary), T1 to T4 (tender, rows reading "TENDER ISSUE"), then A (construction); the tender stamp layer is in use (STUDY_D section 4.8 item 7)

Evidence: STUDY_A section 6 item 46, section 2 naming family 4; ELEMENT_LIST "Across three civil jobs"; STUDY_D section 4.8 item 7.

## E-047 Details

1. **What it is:** The construction details across the bottom of the sheet.
2. **How it is drawn today:** Each detail is one block inserted on BLOCKS at scale 1 (drawn 5x inside), e.g. "PIT 900 MAX", "PIPE BEDDING R.C & GRASS", "SLAB ON GROUND 04", "Saw cut", "REENTRANT BARS", "LAP SPLICE" (inserted at scale 5). Job-specific details (orifice pit with this job's levels, tank detail with this job's litres) are machine-named blocks whose numbers were typed inside the block. Details use hatches AR-CONC (scale 3), EARTH (scale 40), ANSI31, and old-style leaders. JOB_C holds two PDF underlays inside detail blocks (water tank installation diagrams).
3. **Text:** Titles 500 on 50TEXT inside the block. Dimensions are typed over: a dimension that measures 750 carries the typed text "150"; measured 2250 carries "450" (ratio 5.0). Pasted details carry other ratios (2.15, 2.55 measured).
4. **Standard position / offset as measured:** Lower band of the sheet.
5. **What it relates to but is not tied to today:** The pit, tank or pipe the detail describes; the same levels and sizes on the plan, schedule and criteria box.
6. **Facts it would hold in a one-network drawing:** Orifice pit detail: cover, top water level, baffle height, orifice, inverts, chamber sizes, lid classes. Tank detail: litres, split, tank orifice, footprint. All read from the network.
7. **Appears also in:** The office details file (96 named blocks, 42 machine-named, under headings by topic and by council).
8. **Differences seen between jobs:** Orifice pit detail only with detention; raingarden section only with a raingarden; soakage detail only with soakage; agricultural drain trench detail only with those drains; a deeper junction pit detail (900 to 1200) only when a pit is that deep; tank detail drawn to the job's own tank. Details seen on JOB_C: orifice pit; junction pit; pipe bedding under pavement and grass; trench beside footing with angle-of-repose values; services penetration through footing; flexible service pipe through footing; water tank detail; charged system diagram; driveway slab note, re-entrant bars, lap splice, sawcut.
9. **Standard Details Civil drawings:** Nine drawings, all parts stores in model space under headings 3,000 to 6,000 high: CE Civil Details (23,863 objects, 96 named blocks plus 42 machine-named); ORIFICE PITS (12,871 objects, DIMSCALE 20, 54 named blocks, about 26 worked orifice pit details for 8 councils); WATER TANKS - PUMP STATIONS (19,489 objects, 156 named blocks, 127 machine-named); WATER TANKS PLAN; SOAKAGE PITS - INFILTRATION (2,336 objects); RAINGARDENS - SWALES - BUFFER STRIPS (9,715 objects, 83 named blocks, 104 proxy objects); LONG SECTION EXAMPLES (nine); KINGSTON COUNCIL NOTES; CE Roof Details. Topics present: orifice / control pits per council, junction pits (900 max. and 900 to 1200 deep), silt pit, side entry pit, tanks, pump stations, soakage, raingardens / swales / buffer strips, spoon drains, kerbs, pavements and joints, pipe bedding, penetrations, long sections, council note blocks, legends (STUDY_D section 2.3 items 1 to 11)
10. **Orifice pit details by council:** Titles nearly all "ORIFICE PIT P1 DETAIL / SCALE 1:20" (21 copies) with one of several standing lines: "PIT TO BE CONSTRUCTED IN ACCORDANCE WITH COUNCIL STANDARDS", "BAFFLE WALL PIT TO BE CONSTRUCTED IN ACCORDANCE WITH COUNCIL REQUIREMENTS", "REFER ALSO TO COUNCIL STANDARD DRAWING" (28 times), "TO BAYSIDE / GLEN EIRA / MANNINGHAM COUNCIL'S REQUIREMENTS". Councils named: Bayside, Boroondara, Glen Eira, Kingston, Knox, Manningham, Monash, Mornington Peninsula. Each is a pasted job detail whose numbers are edited inside the block. What differs council to council (baffle, plate, sizes): Unknown (STUDY_D section 2.3 item 2, Still unknown item 15)
11. **Re-saved library drawings:** Two library drawings were re-saved on 10 Nov 2026 with "_PRE_C7_" backup copies beside them, and two long-section library blocks are named "CE_CPB_<date>_<time>": recent plug-in tools have been run on the shared library drawings (STUDY_D section 7 item 15)
12. **Details seen on issued sheets:** Soakage: "TYPICAL DETAIL FOR SOAKAGE PIT 1 / 2 / 3"; raingarden: "IN-GROUND INFILTRATION RAINWATER GARDEN TYPICAL SECTION" (layers 50 gravel mulch, 500 filter media, 100 transition, 300 drainage) and a three-column FILTER / TRANSITION / DRAINAGE LAYER specification; pump: "STORMWATER PUMP STATION (SPS) DETAIL"; basement: "TYPICAL STRIP DRAIN (SD) DETAIL", "TYPICAL FLOOR WASTE (FW) DETAIL"; industrial: "P6 CONTROL PIT DETAIL", "SPOON DRAIN IN CONCRETE PAVEMENT DETAIL", "TYPICAL CONCRETE KERB DETAIL", "CONSTRUCTION JOINT DETAIL", "SLAB SPECIFICATIONS"; sports pavilion: "ASPHALT PAVEMENT DETAIL", "TYPICAL ASPHALT ACCESS PAVEMENT", "SILT PIT DETAIL", "KERB RAMP DETAILS"; outfall: "CONNECTION TO NEW COUNCIL SIDE ENTRY PIT DETAIL", a "SECTION A-A" at 1:20 across the trench (STUDY_D section 4.2 item 5, 4.1 item 3, 4.5 item 4, 4.4 item 6, 4.8 item 5, 4.3 item 2, 2.6 item 16)

Evidence: STUDY_A section 6 item 47, section 1 items 9 and 15, section 9 "Between the jobs and MASTER" item 6; ELEMENT_LIST "Seen as a picture" item 6 and "Across three civil jobs" moving part 2; STUDY_B section 2 outputs item 3; STUDY_D section 2.3, 2.6, 4.1 to 4.8, 7 item 15.

## E-048 Computation sheet

1. **What it is:** The office drawing sheet the computations are set out on.
2. **How it is drawn today:** A separate small drawing ("CE Computation Sheet"): 6 blocks, 2 fields, no tables. Not examined further.
3. **Text:** Unknown. Superseded by STUDY_D section 2.4, 16 Nov 2026.
4. **Standard position / offset as measured:** Unknown. Superseded by STUDY_D section 2.4, 16 Nov 2026.
5. **What it relates to but is not tied to today:** The computations PDF sent to council (two to four pages: required figures, storage list, orifice sum, then "WSUD").
6. **Facts it would hold in a one-network drawing:** The computations sheet prints from the same numbers as the drawing (D-021).
7. **Appears also in:** The council submission.
8. **Differences seen between jobs:** Unknown.
9. **What the office computation sheet drawing is:** An A4 portrait page for hand-style sketches, not a stormwater form. One layout "Computation Sheet Plot HERE" (A4, page set-up "CE COMP SHEET PDF", office plot style table), one 210 x 297 viewport at 1:100. A block "COMPUTATION SHEET1" (frame and header) with a parked instruction "DOUBLE CLICK TO EDIT PROPERTIES. DATE WILL UPDATE AUTOMATICALLY UPON PLOTTING" (STUDY_D section 2.4 items 1 and 2)
10. **What is drawn on it today:** A rainwater head / box gutter sketch with dimensions (175, 600, 150, 200), "NOT TO SCALE", and notes beginning "THE RAINHEAD SHALL BE FULLY SEALED TO THE BOX GUTTER...": it issues a one-page sketch on the office calc header, separate from the Word-and-spreadsheet computations (STUDY_D section 2.4 item 3, section 7 item 17)
11. **What computations look like:** A Word document of pasted spreadsheet pictures with three typed lines, printed to PDF (CIV-02). What went to council: the sheet, this PDF and a declaration form (STUDY_D section 5.2 item 4)

Evidence: STUDY_A section 6 item 48; STUDY_B section 1 "Common path" item 4; DECISIONS D-021; STUDY_D section 2.4, 5.2, 7 item 17.

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
9. **Architect's building in the background:** Walls: plain LINEs and ARCs on A-WALL, colour 47 (873 objects in JOB_C, 461 in JOB_A, 396 in JOB_B), all exploded, no wall blocks; wall fill hatches (pattern, not solid) on A-WALL HATCH colour 11. Roof: LINEs, ARCs and SPLINEs on A-ROOF OUTLINE and A-ROOF LOWER OUTLINE (colour 55), fall arrows as tiny solid hatches, TEXT height 240, roof fill patterns on A-ROOF HATCH / A-ROOF LOWER HATCH (colour 41). Windows and doors: LINEs and ARCs on A-WINDOW & DOOR colour 9 (1,183 objects in JOB_C; JOB_B still has 11 unexploded architect door / window blocks). Stairs and similar: A-STAIRS UP / A-STAIRS DOWN (9; down is HIDDEN2), A-STEP (9), A-DWAFTWALL (9; spelt that way in the jobs, A-DWARFWALL in today's template), A-FENCE (47), A-BALUSTRADE (47). Driveway: lines and closed polylines on DRIVEWAY colour 254 (STUDY_D section 1.2 items 11 to 15)

Evidence: STUDY_A section 2 civil layer 31; STUDY_D section 1.2 items 11 to 15.

## E-053 Retaining wall

1. **What it is:** A retaining wall line on the plan.
2. **How it is drawn today:** A fat polyline plus multiline on RETAINING WALL / SLEEPER RETAINING WALL (colour 1). JOB_A: retaining wall polylines of width 112 and 225, colour 31.
3. **Text:** A retaining wall note.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Agricultural drains behind it; levels each side.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence. Retaining walls were not found as civil sums.
7. **Appears also in:** Tool palette (retaining wall); supplier guides in the reference folder only.
8. **Differences seen between jobs:** JOB_A only (a sleeper retaining wall). Shown on CIV-12.
9. **Retaining wall notes on paper:** CIV-11: "PROPOSED RETAINING WALLS TO BE CONFIRMED"; CIV-15: a RETAINING WALL NOTE box; the details library has "RETAINING WALLS ON CIVILS" and "FLOOD PROOF WALLS" headings, a "RETAINING WALL" block and a "retaining wall on boundary" detail (STUDY_D section 4.4 item 2, 4.8 item 3, 2.3 item 1)

Evidence: STUDY_A section 2 civil layer 38, section 9 item 10; STUDY_B section 1l items 3 and 5; STUDY_D section 2.3 item 1, 4.4, 4.8.

## E-054 Batter

1. **What it is:** A sloped bank between two levels.
2. **How it is drawn today:** Batter lines and fills on BATTER (colour 253). JOB_A/B also carry a layer BATTER SYMBOL not in the template.
3. **Text:** None recorded.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Finished levels.
6. **Facts it would hold in a one-network drawing:** None needed by the schedule or sums in the evidence.
7. **Appears also in:** Tool palette (batter, on BLOCKS GROUND).
8. **Differences seen between jobs:** Not compared.
9. **Batter limit on a sheet:** CIV-11: "MAX. 1:4 BATTER" (STUDY_D section 4.4 item 2)

Evidence: STUDY_A section 2 civil layer 37 and "Standard versus invented" item 3; ELEMENT_LIST "On the plan" item 11; STUDY_D section 4.4 item 2.

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
9. **Stacked plans in the cleaned file:** One file holds several plans stacked 50,000 apart in Y. JOB_C: site plan Y about -37,000 to +2,000, ground floor Y -73,000 to -57,600, first floor with roof Y -123,000 to -107,600. JOB_B: site plan Y -46,000 to +27,000, ground floor Y -80,000 to -57,600. JOB_A: site survey Y 0 to 123,000, ground floor Y -27,500 to -3,000, upper level Y -77,000 to -57,600 (STUDY_D section 1.1 item 1)
10. **Why the job attaches it twice:** The site band of JOB_C holds NO building walls (only survey, trees, contours, title boundary, fences, street name, bench mark). The building arrives through the second attachment, inserted 50,000 higher so it lands on top of the site plan. Insert points 44,929,-104,915 and 44,929,-154,915 (STUDY_D section 1.1 item 2)
11. **Registration marks:** The same helper lines on layer GUIDELINES (does not plot) at the same coordinates in all three files: X 22,198 and 47,198; Y -7,643, -57,643, -107,643. They come from the template and mark where each plan is to be placed (STUDY_D section 1.1 item 3)
12. **Units, layout and text style of the cleaned file:** Millimetres, LTSCALE 1000, DIMSCALE 100. One unused paper layout with two viewports; nothing is plotted from it. STANDARD is Arial Narrow, but the architect's and surveyor's text keeps its own styles (Century Gothic family in JOB_C; Isocpeur and Arial in JOB_B; Stylus and Arial in JOB_A) (STUDY_D section 1.1 items 4 to 6)
13. **What cleaning meant:** Architect's originals for JOB_C: 18 files, one per sheet, 21 to 39 layers each with American-style names, 73 to 240 block definitions, 366 to 389 MTEXTs and 42 to 170 dimensions per plan, LTSCALE 1. Cleaned file JOB_C: 85 layers (28 carry anything), 4 block definitions, 0 dimensions, 3,557 plain lines. Steps read from the difference: start from the office background template; paste site plan, ground floor and upper floor at their 50,000 stations; explode everything; move objects onto office A- layers by kind (the layer forces the office colour: walls 47, windows 9, roof 55, background 11, survey 253 or 11); delete the architect's dimensions, room names, notes, tags and title block (389 MTEXTs down to about 40); keep the surveyor's text in its own fonts; add office content (boundary text, bench mark box, tree zones, existing drain) (STUDY_D section 1.3 items 1 to 3)
14. **Grey set two ways:** JOB_B: 341 of 371 objects on A-ARCH BACKGROUND forced to colour 250. JOB_A: all 869 objects on A-SURVEY forced to colour 250. JOB_C (newest) sets it by layer. Layer counts after cleaning: JOB_A 36, JOB_B 34, JOB_C 85. JOB_A and JOB_B keep surveyor blocks, imported linetypes and surveyor layer names; JOB_C is fully on office layers (STUDY_D section 1.3 items 4 to 6)
15. **Conflict (layer count):** STUDY_D counts 85 layers in the cleaned JOB_C background file; the earlier study counted 81 background layers per attachment in the job (see SHEET_SETUP section 8 item 6). Not settled (STUDY_D section 1.3 item 2)
16. **Design content lives in the background file:** Tree zones, existing drain, footing hatches, load-bearing wall hatches, a solid colour-201 fill and the bench mark box are drawn in the background file, not in the job drawing. A tool that reads only the job drawing will not see them. A change to the building means editing the floor band; a change to survey means editing the site band; the job drawing never changes (STUDY_D section 1.2 item 17, section 7 items 2 and 3)
17. **Clip boundaries:** JOB_C: two rectangles, both with left edge X 106,313 and top edge Y -153,227 (the left and top edges of the sheet frame): site attachment 58,518 wide x 25,872 high, ground attachment 58,518 x 26,566; both attachments moved 2,630 to the right after clipping. JOB_B: two rectangles 50,509 x 29,365 and 51,545 x 30,327. JOB_A: three 6-point polygons, each top edge on the frame top (Y -153,227), plus one unclipped copy inside the key plan block at scale 0.2. The clip outline is switched off. Six JOB_C downpipe symbols carry the same clip rectangle (clipped by accident with the background) (STUDY_D section 3.5 items 1 to 6)
18. **Leftovers:** JOB_C: 117 shrunk architect note MTEXTs (1.5 to 4 high) parked beside the site plan and one empty architect block. JOB_B: one insert about 6,000,000,000 units away (wrecks zoom extents) and a parked structural steel section catalogue. JOB_A: 20 block definitions left from the survey underlay. A sync-conflict copy (file name ending in a PC name) exists for a background file of JOB_A (STUDY_D section 1.2 item 18, section 7 item 16)
19. **Background templates:** Six files: blank (Dec 2025, 105 layers, 61 objects; the current starter) and five older ones named site, ground, first, roof and basement (2022 to 2023; 90 layers, 58 objects each). The blank one holds a printed key of 27 background layers with one sample line and one name text (height 250) each, plus the registration lines on DEFPOINTS and a sample MTEXT with mask. Colours differ slightly from the jobs (A-WINDOW & DOOR 253 in the template, 9 in the jobs). The older level templates also carry sample existing-pit lines, existing drain polylines and a tree-zone arc. The jobs studied use ONE file with the levels stacked (STUDY_D section 1.4 items 1 to 3)

Evidence: STUDY_A section 1 item 14, section 9 item 2; INTERVIEW items 7 and 8d; STUDY_D section 1.1 to 1.4, section 3.5, section 7 items 2, 3 and 16.

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
9. **Connection note examples:** CIV-05: "CONNECT TO NEW SIDE ENTRY PIT AT APPROX IL ... TO COUNCIL SATISFACTION". CIV-11: a long note about replacing the existing pit with a new junction pit and confirming its depth; a pit tagged "LPD" at the legal point of discharge and one tagged "OG"; "OVERFLOW TO DISCHARGE TO ATMOSPHERE" (STUDY_D section 4.3 item 1, 4.4 item 2)

Evidence: STUDY_B section 1a item 5, 1b item 4, section 2 inputs item 1; ELEMENT_LIST "Seen as a picture" items 5 and 8; INTERVIEW items 8g, 8h, 8za; STUDY_D section 4.3, 4.4.

## E-059 Pump station, rising main and pump specification box

1. **What it is:** A pump well that lifts water to a receiving pit, its pressure pipe, and the box that states the pump duty.
2. **How it is drawn today:** Pit block states "SPS Vertical" and "SPS Horizontal" exist (E-008); the pit tag placeholder "SPS" (E-012). Layer STORMWATER RISING MAIN is in the master only. A pump placeholder is parked on JOB_C. The paper look of pump sheets has not been seen (Q-106). The older study: schedule row, pump specification box, wet-well section, green rising main to a receiving pit, then gravity to the kerb. Superseded by STUDY_D section 4.1, 16 Nov 2026.
3. **Text:** Pump box (CIV-07): dual alternating pumps 7.90 l/s, static rise 0.67, rising main 6 m, minimum wet well 4.72, comply with the standard. Notes: "fully tanked pump pit, no groundwater into the pump system"; control panel and alarm note; the standard's pump clauses.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pump sums (S-014, S-015); the receiving pit; the permitted discharge (pump rate).
6. **Facts it would hold in a one-network drawing:** Pump rate; number of pumps; static rise; rising main size and length; wet well volume, shape and plan size; the seven named levels; cover level; discharge invert.
7. **Appears also in:** Pump station section (detail); pit schedule row; pipe descriptions for rising main on the LABELS CIVIL palette.
8. **Differences seen between jobs:** CIV-07: 2,000 dia fibreglass well. CIV-10: rectangular well 9.6 m x 1.5 m with the detention in the same well. CIV-12: dual 2.5 l/s pumps.
9. **Paper look of a pump sheet (CIV-07):** One sheet, vertical title, for council approval, 1:100 and 1:20. The detention criteria box is replaced by a pump box and the right half of the details strip is taken by the pump station. Box "STORMWATER PUMP SYSTEM (SPS) SPECIFICATIONS" rows: "DUAL 7.90 l/s ALTERNATING PUMPS", "0.67m STATIC RISE", "5m RISING MAIN", "MIN. 4.72m3 WET WELL STORAGE", "SOLID CLASS C LID", "PUMP & WET WELL TO COMPLY WITH AS3500.3" (STUDY_D section 4.1 items 1 and 2)
10. **Conflict (rising main length):** The earlier study records the CIV-07 rising main as 6 m (and in S-015 as 6 m of 50 dia); the pump box as read from the sheet picture says 5m. Not settled (STUDY_D section 4.1 item 2)
11. **Pump station detail:** A section of a round well (2000 dia.) with a ladder of levels down the right side, each a level tick and a name: top cover level, inlet level, HIGH LEVEL ALARM, TOP WORKING LEVEL, PUMP 2 START LEVEL, PUMP 2 STOP LEVEL, PUMP 1 START LEVEL, ALL PUMP STOP LEVEL, base level; a grey band for the stored volume labelled with cubic metres of detention; "WET WELL STORAGE (MINIMUM x m3)"; "MIN. CAPACITY"; rising main outlet, inlet pipe, grated class C trafficable cover (STUDY_D section 4.1 item 3)
12. **On the plan:** The well is a circle with an "SPS" tag in a circle; a "RISING MAIN" pipe in a third colour (green) from the well to the kerb; "CONNECT TO KERB & CHANNEL AT APPROX IL ..."; "100 DIA. DROPPER FROM WATER TANK / CONNECT INTO PP" and "100 DIA. RISER TO WATER TANK" labels; a small isometric picture of a plastic pit titled "PIT P1 DETAIL". The well is a pit-schedule row whose "from" cell reads SPS (STUDY_D section 4.1 items 5 and 6)
13. **Pump jobs on other sheets:** CIV-14 sheet 3: a pump station (1800 dia.) with the same pump boxes. CIV-12: well 1,500 dia., pump specification block as printed on the sheet. Civil template copies of Jan and Oct 2025: pump specification placeholder ("DUAL xx l/s ALTERNATING PUMPS / x.xxm STATIC RISE / xxm RISING MAIN / MIN. xx.xxm WET WELL STORAGE / SOLID CLASS B LID") (STUDY_D section 4.7 item 2, section 5.3 item 3, section 2.1 item 3)

Evidence: STUDY_B section 1g items 5 and 6, 1l items 1 and 3; STUDY_A section 6 items 8 and 12, section 2 civil layer 5, section 9 item 10; DIGEST section 1 item 9, section 2 item 1; ELEMENT_LIST "Tables and boxes" item 4; STUDY_D section 2.1 item 3, 4.1, 4.7, 5.3.

## E-060 Soakage pit and silt pit

1. **What it is:** A buried pit of plastic modules where water soaks into the ground, with a silt pit before it.
2. **How it is drawn today:** How the grid is drawn (objects, layer) was not measured: Unknown (Q-106). JOB_A's sheet has a soakage unit grid, silt pits and soakage and tank details. Superseded by STUDY_D section 4.2 item 2 (paper look only; objects and layer still Unknown), 16 Nov 2026.
3. **Text:** Each soakage pit titled with its module count and grid; "wrapped in geotextile"; silt pit inverts; a soakage assumptions note.
4. **Standard position / offset as measured:** Rules: modules 1 m from footings, 2 m from boundaries, 1.5 m from tree zones where possible; at the low point (L-016).
5. **What it relates to but is not tied to today:** The soakage sum (S-016); its catchment; the soil report.
6. **Facts it would hold in a one-network drawing:** Module count and grid (wide x long, single or double height); width, length and depth; catchment; soil rate; moderating factor; silt pit levels.
7. **Appears also in:** Typical section per pit (detail); schedule remarks (silt pit levels).
8. **Differences seen between jobs:** CIV-08: 60, 40 and 30 double modules. JOB_A: overflow to a dam.
9. **Soakage on plan (CIV-08):** Each soakage pit is a grid of small rectangles (one per module) with a label block: "SOAKAGE PIT 1 / 60 DOUBLE SOAKAGE MODULES (5 x 11). INSTALL THE MATRIX WATER TANK IN ACCORDANCE WITH MANUFACTURER'S SPECIFICATIONS. SOAKAGE MODULES ARE TO BE WRAPPED IN GEOTEXTILE FABRIC." (also 30 modules as 3 x 10 and 40 as 4 x 10) (STUDY_D section 4.2 item 2)
10. **Typical soakage detail:** Section through a silt pit with trash rack, inlet pipe, module block with count, levels, compacted sand and geotextile notes, manufacturer line. The details library holds 20 copies of "TYPICAL ATLANTIS MATRIX WATER TANK DETAIL", pit details P1 and P3 and a standing note "NO GROUNDWATER HAS BEEN ENCOUNTERED WITHIN 1m OF SOAKAGE PITS"; it uses the Stormwater Pit block. Schedule remarks carry silt pit levels ("Silt Pit IL 4.13 Class B Grate") and "Plastic Pit Class A Grate" (STUDY_D section 4.2 items 5 and 6, section 2.3 item 5)
11. **Soakage pit sized by module count (CIV-13):** Module 0.408 wide x 0.685 long; 14 wide x 13 long gives 5.712 x 8.905 m; storage depth 0.45 m; porosity 0.95 (module heights listed beside: double 880, single 450). Infiltration area 81.0 m2, perimeter 29.2 m, volume 22.9 m3. A small separate drawing "soakage.dwg" sits in the folder (STUDY_D section 5.4 items 2 and 5)
12. **Owner's ruling on day-one pit kinds:** Silt pit and soakage pit were not ticked as day-one pit kinds: later (D-104)

Evidence: STUDY_B section 1h items 2 to 7, section 3 item 16; ELEMENT_LIST "Across three civil jobs" item 3 and moving parts 2 and 6; STUDY_D section 2.3 item 5, 4.2, 5.4; D-104.

## E-061 Roof hatch and roof-area legend

1. **What it is:** A hatch over the roof area that goes to a tank, with a legend giving the area per dwelling.
2. **How it is drawn today:** Not measured on JOB_A/B/C: Unknown. JOB_A/B carry a layer "AREA OF INTEREST HATCH" not in the template; its use is not stated.
3. **Text:** Legend giving roof area in square metres per dwelling.
4. **Standard position / offset as measured:** Unknown.
5. **What it relates to but is not tied to today:** The roof-to-tank areas box (E-021); the STORM report.
6. **Facts it would hold in a one-network drawing:** Roof area to each tank, counted once.
7. **Appears also in:** Kingston's commonly-asked list ("roof hatch and area legend").
8. **Differences seen between jobs:** Unknown.
9. **Roof hatch on paper:** CIV-07: roof catchment as a blue diagonal hatch over the building, legend line "HATCH DENOTES AREA OF ROOF CATCHMENT DIRECTED TO WATER TANK" and a label "177m2 ROOF CATCHMENT AREA TO WATER TANK" on each dwelling. CIV-08: each dwelling's roof hatched a different colour and direction with a legend row of four swatches ("ROOF 1 TO WT1 - 140.2m2", "ROOF 2 TO WT2 - 131.9m2"). CIV-01: a small PDF of an upper-floor plan with part of the roof hatched, "57m2 OF ROOF CATCHMENT AREA TO WATERTANK SHOWN HATCHED", a measured area drawn in CAD. Objects and layer of the hatch: still Unknown (STUDY_D section 4.1 item 5, 4.2 item 3, 5.1 item 2)

Evidence: GUIDEBOOK_NOTES "Elements" item 14; STUDY_B section 4 item 1, section 2 outputs item 1; STUDY_A section 2 "Standard versus invented" item 3; STUDY_D section 4.1, 4.2, 5.1.

## E-062 Outfall plan and long section

1. **What it is:** A narrow plan of a drain in the road reserve and a long section (side view along the pipe) with rows of figures.
2. **How it is drawn today:** Not measured (long-section examples were not converted): Unknown (Q-102). On CIV-05 it is a second sheet (C02). Superseded by STUDY_D section 2.6 (measured on nine examples), 16 Nov 2026.
3. **Text:** Rows: pipe size, pipe grade, pipe design flow, velocity, invert depth, invert level, surface level, chainage, datum.
4. **Standard position / offset as measured:** Horizontal 1:250, vertical 1:25 (one council). Lower-centre of the sheet when present.
5. **What it relates to but is not tied to today:** The outfall pipes and pits on the plan; survey levels along the route; existing services crossed.
6. **Facts it would hold in a one-network drawing:** For each point along the run: chainage, surface level, invert level, invert depth; per pipe: size, grade, design flow, velocity; datum.
7. **Appears also in:** See `drafting\TABLES_AND_BOXES.md`. With it: outfall plan at 1:100 with offsets from the title boundary; two-row pit schedule; 1:20 service-crossing section; locality plan; pasted council standard drawings; council notes block; service-crossing clouds.
8. **Differences seen between jobs:** Only 2 of the 30 jobs in the August study had one, both for the outfall to the council pit; rows and scales differed.
9. **How a long section is drawn:** No tool draws it; every one is loose lines and text. Plain LINEs, plain TEXT (306 on the measured example), a few MTEXTs, polylines with width for pits, ellipses for crossing services. No blocks, no table object, no attributes. Older examples sit on layers 25CONT, 35CONT, 25TEXT, 35TEXT, 50TEXT; three newer ones on a layer "SCHED" (STUDY_D section 2.6 item 1)
10. **Scales:** Seven examples are horizontal 1:100 with vertical 1:50 (1 m of level = 2,000 units, 1 m of chainage = 1,000 units); one is 1:200 / 1:100. The issued CIV-05 sheet states 1:250 / 1:25. The scale is typed under the title (STUDY_D section 2.6 item 2)
11. **Conflict (scales):** 1:100 / 1:50 on seven worked examples against 1:250 / 1:25 on the issued CIV-05 sheet. Not settled (STUDY_D section 2.6 item 2)
12. **Datum line and row lines:** The top line of the table is a full-width LINE labelled at left "DATUM LEVEL R.L. 125.00m" (also "DATUM LEVEL AHD 35.00m", "DATUM LEVEL R.L. 12m AHD"), TEXT height 350 on 35TEXT. Row lines are horizontal LINEs 1,500 apart (15 mm on paper), all the same length (30,506 on the measured example), closed by a vertical line left of the titles (STUDY_D section 2.6 items 3 and 4)
13. **Row titles:** Height 350, left-justified, on 35TEXT, top to bottom on the fullest example: DATUM LEVEL, PIPE SIZE, PIPE GRADE, Vp - PIPE VELOCITY PART FULL, Qf - PIPE FLOWING FULL, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE. Variants: PIPE CAPACITY in place of the two flow rows; "PIPE CHAINAGE TO CENTERLINE"; a newer set with units in the title ("CHAINAGE (m)", "INVERT DEPTH (mm)", "SURFACE LEVEL (m)", "PIPE INVERT LEVEL (m)", "PIT INVERT LEVEL (m)"). CIV-05 as issued: PIPE SIZE, PIPE GRADE, PIPE DESIGN FLOW / VELOCITY, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE (STUDY_D section 2.6 item 5)
14. **Vertical grid and column text:** One vertical LINE per chainage point. At pits and ends it runs from the bottom of the table up to the surface line; at in-between points it is in two pieces (bottom four rows only, 6,000 long; and from the datum up to the surface); the upper rows (size, grade, flow) are left open so text can span a run. Level and chainage values are TEXT height 250 on 25TEXT, rotated 90 degrees, just right of their line, two decimals; two inverts at a pit are two texts side by side. Pipe size ("225 DIA. RC CLASS 2 RJJ PIPE"), grade ("1 in 100"), velocity ("1.46 m/s") and flow ("58 l/s") are horizontal TEXT centred in the run (STUDY_D section 2.6 items 6 and 7)
15. **Pipe, surface, pits:** Pipe: two parallel LINEs on 35CONT (invert and obvert) with the gap equal to the diameter times the exaggeration (450 for a 225 pipe at 1:50), continuous, not the dashed band used on plan. Surface: LINEs on 25CONT; footpath, crossover and kerb as a second line 200 below with short end ticks; labels ("CROSSOVER", "FOOTPATH", "NATURE STRIP") TEXT or MTEXT 180 to 250. Pits: a vertical polyline of width 300 on 35CONT from surface to invert with "PIT P1" / "PIT CP1" / "ExP" TEXT 250 rotated 90 above; on CIV-05 the bars carry a circled tag (STUDY_D section 2.6 items 8 to 10)
16. **Title boundary, ends, title:** A vertical LINE on layer BOUNDARY (DASHDOT) from the datum up past the surface labelled "TITLE BOUNDARY" rotated 90. A break symbol (zig-zag polyline and arc) where the existing pipe carries on. Title "LONGITUDINAL SECTION" or "OUTFALL DRAIN LONGITUDINAL SECTION", TEXT height 500 underlined, two scale lines at 250 below (STUDY_D section 2.6 items 11, 13 and 14)
17. **What else is on an outfall sheet:** Its own plan "OUTFALL DRAINAGE PLAN" at 1:100 of the street reserve, a circular "LOCALITY PLAN" with north point, a short pit schedule (existing council pit and new side entry pit), a "SECTION A-A" at 1:20 across the trench showing clearances to crossing services, and a "BUILDER TO CONFIRM LOCATION AND DEPTH OF ALL SERVICES" box. Existing council pit tagged "ExP", new side entry pit "SEP"; the pipe in the road uses the same blue band as site pipes; the CIV-05 revision list has ten rows. Pasted as pictures on CIV-05: three council standard drawings (side entry pit, bedding and backfill, property drainage inlet connection) (STUDY_D section 2.6 items 15 and 16, section 4.3 item 1)

Evidence: STUDY_B section 1e item 5, section 3 item 21; DIGEST section 1 items 1 and 8, section 2 item 7; STUDY_A section 10 item 12; STUDY_D section 2.6, 4.3.

## E-063 Revision cloud

1. **What it is:** A cloud drawn round something that changed in this revision.
2. **How it is drawn today:** Layer CLOUD (colour 10 in jobs and template, 12 in the master). Empty in the three jobs.
3. **Text:** None.
4. **Standard position / offset as measured:** Not applicable.
5. **What it relates to but is not tied to today:** The revision row it belongs to.
6. **Facts it would hold in a one-network drawing:** None.
7. **Appears also in:** The typed helper `RC` (rectangular revision cloud at the office arc size).
8. **Differences seen between jobs:** None drawn on JOB_A/B/C.
9. **Clouds in use:** Two rows of the pit schedule on CIV-10 sheet 1 are ringed with a red cloud (the only cloud seen on any civil sheet in the basement study). CIV-15 shows red clouds around several small items on the plan (STUDY_D section 4.5 item 5, section 4.8 item 3)

Evidence: STUDY_A section 2 civil layer 50; STUDY_C section 2A item 6; STUDY_D section 4.5 item 5, 4.8 item 3.

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
9. **Sample existing-pit lines in older level templates:** The older background templates carry sample existing-pit lines and existing drain polylines, so the office expects existing pits to be drawn in the background file (STUDY_D section 1.4 item 3)

Evidence: STUDY_A section 2 civil layer 10, section 8 items 6 and 9; STUDY_B section 1e item 5, section 2 inputs item 3; STUDY_D section 1.4 item 3.

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

## E-067 Cut and fill zone (earthworks plan)

1. **What it is:** A coloured hatched zone on a site earthworks sheet, labelled with a name and a bench level. Civil does draw earthworks on a public building job (CIV-15).
2. **How it is drawn today:** Coloured hatched zones over the survey contours and spot levels with the bench mark box, on a sheet "SITE CUT AND FILL PLAN" at 1:100. Objects and layers: Unknown (read as a picture only).
3. **Text:** Each zone has a name and a bench level: "SITE CUT 1 / BENCH RL 27.98" (with "PROPOSED FFL 27.98"), "SITE CUT 2 / SCRAPE EXISTING TO SUIT PROPOSED PATH ... ALLOW FOR 130 THICK PAVEMENT", "SITE CUT 3", "SITE CUT 4", "INFILL SLAB 1 CUT / BENCH RL 27.78", "INFILL SLAB 2 CUT", "FILL 1 / RL 27.78", "PROPOSED SUSPENDED SLAB NO FILL / ALLOW FOR FOOTING EXCAVATION", "SITE SCRAPE TO ALLOW FOR 140 THICK ASPHALT PAVEMENT". No volumes are stated.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The survey levels and contours (E-030); the pavement build-ups (E-073); the proposed floor level.
6. **Facts it would hold in a one-network drawing:** Zone name; bench level; area. Volumes are not stated on the sheet: Unknown whether they are worked out anywhere.
7. **Appears also in:** Only on its own sheet (sheet 3 of CIV-15). It was first issued alone as a tender-stage "cut & fill plan".
8. **Differences seen between jobs:** Seen on CIV-15 only. This answers the earlier question "earthworks drawn by civil: not found" (STUDY_B).

Evidence: STUDY_D section 4.8 item 6, section 7 item 6.

## E-068 Strip drain, ramp trench and ramp hump (basement)

1. **What it is:** The strip drains, floor wastes, trench across the ramp and hump at the ramp top that collect basement water.
2. **How it is drawn today:** Drawn as loose symbols on the basement slab plan: strip drains "SD" and floor wastes "FW" all over the slab with fall arrows. Objects and layers: Unknown (read as a picture only).
3. **Text:** "300(W) TRENCH WITH CLASS C GRATE" across the ramp; "RAMP UP"; "500 WIDE HUMP 30 HIGH" at the ramp top; sump pits "600 x 600 WITH CLASS C GRATE ... (INTERNAL) PIT"; "RISING MAIN"; "VOID TO BASEMENT BELOW" on the ground sheet. Notes: "BASEMENT TO BE FULLY TANKED WATERTIGHT"; "BATTERY BACK UP".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The pump well and rising main (E-059); floor waste (E-017); trench grate (E-022); the structural drawings (grid bubbles and pile wall, E-074).
6. **Facts it would hold in a one-network drawing:** Type; width; grate class; what it drains to.
7. **Appears also in:** Details "TYPICAL STRIP DRAIN (SD) DETAIL" and "TYPICAL FLOOR WASTE (FW) DETAIL" (sections at the shotcrete wall with strip drain make, geotextile, 50 x 50 spoon drain, waterproofing "REFER TO STRUCTURAL").
8. **Differences seen between jobs:** CIV-10 and CIV-12 (basement jobs).

Evidence: STUDY_D section 4.5 items 2 to 4.

## E-069 Staged works marking

1. **What it is:** The wording and legend that separate stage 1 and stage 2 of a staged job.
2. **How it is drawn today:** Separate sheets per stage: sheet titles "STAGE 1 - STORMWATER DRAINAGE AND PAVEMENT PLAN" and "STAGE 2 - ...". Objects and layers: Unknown (read from text only).
3. **Text:** Legend line "DENOTES EXTENT OF STAGE 1 WORKS" (carried in the details library). The job was issued through revision E as "CVL ... STAGE 1 & 2".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Every element drawn in a stage; the sheet numbering (C01, C02 ...).
6. **Facts it would hold in a one-network drawing:** Which stage each element belongs to: Unknown whether anything holds this today.
7. **Appears also in:** Details library legend.
8. **Differences seen between jobs:** CIV-14 (childcare centre, three sheets, staged). Read by text only.

Evidence: STUDY_D section 4.7 item 1.

## E-070 Proprietary product call-out

1. **What it is:** A note on the plan naming a manufacturer's product and telling the builder to follow the maker's specification.
2. **How it is drawn today:** Loose text or labelled blocks beside the item; no standard object. Objects and layers: Unknown.
3. **Text:** "REFER MANUFACTURER SPECIFICATIONS"; "INSTALL THE MATRIX WATER TANK IN ACCORDANCE WITH MANUFACTURER'S SPECIFICATIONS"; "PUMP AS PER MANUFACTURER'S SPECIFICATIONS"; litter basket note on the pit schedule. Products named on sheets: modular detention tank (make, length x width x height), soakage modules, a proprietary treatment device (make and model), litter baskets, strip drains, tank makes.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The item it describes (E-019, E-060, E-040, E-068); the maker's data; the volume it must hold.
6. **Facts it would hold in a one-network drawing:** Make; model; size; the volume it holds (for the criteria box).
7. **Appears also in:** Pit schedule remarks; criteria box line; details.
8. **Differences seen between jobs:** Seen on CIV-08, CIV-10 and CIV-11.

Evidence: STUDY_D section 7 item 11, section 4.4 items 2 and 3, section 4.2 item 2.

## E-071 Grid of pavement levels and falls

1. **What it is:** A grid of finished levels with fall arrows across a hardstand or car park, and written path grades.
2. **How it is drawn today:** Red level texts at grid points with fall arrows across the whole hardstand (CIV-11); survey contours and existing surface levels in brown across the whole site (CIV-15). Objects and layers: Unknown.
3. **Text:** Path grades written as "1:22 14%"; "CROSSFALLS SHALL BE NO STEEPER THAN 1:40" (CIV-15); "RE-LINE DDA PARKING BAYS"; kerb ramp details.
4. **Standard position / offset as measured:** Not measured. The industrial grid covers every car space, kerb line and accessible bay.
5. **What it relates to but is not tied to today:** The finished-level tags (E-029); fall arrows (E-027); the pavement specification (E-073); limits (L-025).
6. **Facts it would hold in a one-network drawing:** Level at each point; the fall between points.
7. **Appears also in:** Kerb ramp detail; pavement plan sheet.
8. **Differences seen between jobs:** CIV-11 (industrial) and CIV-15 (sports pavilion) only.

Evidence: STUDY_D section 4.4 item 2, section 4.8 item 3.

## E-072 Pasted council standard drawing

1. **What it is:** A council's own standard drawing pasted onto the sheet as a picture or block.
2. **How it is drawn today:** Pasted as pictures on outfall sheets (CIV-05: three: side entry pit, bedding and backfill, property drainage inlet connection). One council has a whole library drawing of them: Kingston, 27 numbered tiles with 39 machine-named blocks on an old A3 sheet, three layouts. Layers: Unknown.
3. **Text:** Standing lines on details: "REFER ALSO TO COUNCIL STANDARD DRAWING" (28 times in the orifice pit details library, naming standard drawings for Mornington Peninsula, Knox and two others).
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The council (C- file); the pit or pipe it governs.
6. **Facts it would hold in a one-network drawing:** Which council standard drawing applies to which element: Unknown whether anything holds this today.
7. **Appears also in:** Council notes blocks (E-038); outfall sheets (E-062).
8. **Differences seen between jobs:** CIV-05 (three pictures); Kingston library only for one council.

Evidence: STUDY_D section 2.6 item 15, section 2.3 items 2 and 8, section 7 item 10.

## E-073 Pavement specification legend swatch

1. **What it is:** A coloured legend swatch carrying a full specification paragraph for a pavement type, with the plan areas filled in the matching colour.
2. **How it is drawn today:** Four coloured swatches in the legend, each a full specification paragraph: "130mm ASPHALT FOOTPATH" (asphalt type and depth, crushed rock depth and class, refer also to the council standard drawing), "125mm THICK RC INFILL SLAB", "150mm THICK RC INFILL SLAB" (mesh, chairs, strength, oxide colour, subgrade CBR, edge thickening), "140mm ASPHALT ACCESS PAVEMENT" with a design vehicle statement. Industrial: "150mm THICK RC CARPARK SLAB" and "150mm THICK R.C SPOON DRAIN" each with mesh, cover, concrete strength, slump, sub-base and edge beam lines. Objects and layers: Unknown.
3. **Text:** "PAVEMENT DESIGNED FOR ONCE PER YEAR ACCESS BY ... RIGID TRUCK WITH A MAXIMUM WEIGHT OF 14 TONNE, CRANE TRUCK ... 18-20 TONNE"; "REFER TO STRUCTURAL DRAWINGS FOR ALL OTHER EXTERNAL PAVING, RAMP, STAIRS AND RAFT SLAB SPECIFICATIONS".
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** Slab and pavement hatches (E-033); the pavement details; limits (L-020).
6. **Facts it would hold in a one-network drawing:** Pavement type; thickness; specification lines; design vehicle.
7. **Appears also in:** Legend (E-039); details (E-047).
8. **Differences seen between jobs:** Only on bigger jobs (CIV-11, CIV-15). Plain houses carry none.

Evidence: STUDY_D section 4.8 item 2, section 4.4 item 3, section 7 item 7.

## E-074 Structural grid bubbles and pile wall (basement background)

1. **What it is:** Information greyed in from the structural drawings on a basement plan: grid bubbles and the pile wall.
2. **How it is drawn today:** Grid bubbles with letters down the side and numbers along the top; the pile wall drawn as a row of circles round the boundary with pile notes greyed in. Objects and layers: Unknown (read as a picture only).
3. **Text:** Pile notes from the structural drawings.
4. **Standard position / offset as measured:** Not measured.
5. **What it relates to but is not tied to today:** The basement slab (E-028) and the strip drains (E-068); the structural set.
6. **Facts it would hold in a one-network drawing:** Not a network element.
7. **Appears also in:** Basement sheets only.
8. **Differences seen between jobs:** CIV-10 and CIV-12. Read as pictures of CIV-10 only.

Evidence: STUDY_D section 4.5 item 2.

---

Next free number: E-075
