# Gaps closed: background files, templates and libraries, undecoded items, more job kinds on paper, missing sums, colleagues' PCs

**Made:** Mon 16 Nov 2026, read-only study D. **Status:** measured from files; nothing here is confirmed by the principal and nothing is a decision.

**Privacy:** jobs are JOB_A/B/C and CIV-01 to CIV-15; PCs are PC-1 to PC-7. No client, street, job number or staff name is written here. The keys are local-only files in this folder (`KEY_LOCAL_ONLY.txt`, `KEY_PC_LOCAL_ONLY.txt`). Everything under `raw\`, `jobs\`, `bg\`, `util\` and `png\` holds real names: local only, never copy to a repository.

**Folder:** `C:\CE_WORK\scratch\zero_study\D_gaps`. Scripts are the `.py` and `.ps1` files there. OneDrive downloads worked today (about 40 online-only files fetched, none stalled).

## 0. Sources and how each is cited

1. **[BG_A], [BG_B], [BG_C]** = the cleaned background drawing of each job (`Xref\Xref_<job>.dwg`), copied to `bg\JOB_x\xref.dwg` and converted to DXF.
2. **[ARCH_C]** = three of the architect's original CAD files for JOB_C (one file per architect sheet), copied and converted.
3. **[JOB_A/B/C]** = `C:\CE_WORK\realjobs\JOB_x\work.dxf`.
4. **[TMPL:name]** = a converted copy in `tmpl\`. **[DET:name]** = a converted copy in `det\`.
5. **[PDF:CIV-nn pN]** = the latest issued civil PDF of that job, page N, looked at as a picture (`png\`) and as extracted text.
6. **[SUMS:CIV-nn]** = computation PDF or workbook of that job in `jobs\CIV-nn\`.
7. **[IT]** = the office IT folder, sub-folder for plug-in administration (machine, usage and failure records). **[EXPORT]** = AutoCAD "export settings" packages in the drafting utilities folder.
8. **[CTB]** = the decoded plot style table from study A.

---

## 1. The background file

### 1.1 How the file is arranged

1. **One file holds several plans stacked 50,000 apart in Y.** In [BG_C] the survey / site plan sits at Y about -37,000 to +2,000, the ground floor plan at Y -73,000 to -57,600, and the first floor with roof at Y -123,000 to -107,600. In [BG_B] the site plan is at Y -46,000 to +27,000 and the ground floor at Y -80,000 to -57,600. [BG_A] has the site survey at Y 0 to 123,000, the ground floor at Y -27,500 to -3,000 and an upper level at Y -77,000 to -57,600.
2. **The site band of [BG_C] holds NO building walls.** It holds only survey, trees, contours, title boundary, fences, street name and bench mark. The building arrives through the second attachment (the ground floor band) which the job inserts 50,000 higher so that it lands on top of the site plan. That is why the job attaches the same file twice under two names and 50,000 apart: the two bands are overlaid on the sheet. [BG_C bands; JOB_C insert points 44,929,-104,915 and 44,929,-154,915]
3. **Registration marks.** The same helper lines on layer GUIDELINES (does not plot) appear at the same coordinates in all three files (X 22,198 and 47,198; Y -7,643, -57,643, -107,643). They come from the template and mark where each plan is to be placed so the bands line up. [BG_A/B/C]
4. **Units and scales.** Millimetres, LTSCALE 1000, DIMSCALE 100, one unit = 1 mm of ground, same as the job sheet. [BG_A/B/C]
5. **Layout.** One unused paper layout with two viewports. Nothing is plotted from this file. [BG_A/B/C]
6. **Text style.** STANDARD is Arial Narrow as in the office standard, but the architect's and surveyor's text keeps its own styles (Century Gothic family in [BG_C]; Isocpeur and Arial in [BG_B]; Stylus and Arial in [BG_A]).

### 1.2 How each item is drawn

1. **Title boundary line.** Plain LINEs (4 in [BG_C] and [BG_B]) or one polyline of width 20 to 30 ([BG_A], [BG_B]) on layer A-TITLE BOUNDARY, colour 2, linetype DASHDOT2, by layer. Not a block.
2. **Boundary lengths and bearings.** Plain TEXT on A-TITLE BOUNDARY. [BG_C]: height 250, style ISO, one text per side holding both, pattern "42.67m - 187°19'40", rotated to the side (0 or 90). [BG_B]: height 450, length and bearing as two separate texts ("44.03M" and "186°17'"), surveyor's fonts. [BG_A]: MTEXT height 250 on layer G-ANNO-TEXT (colour 2), pattern "40.14m  82°4'30"". So the office retypes or keeps them, with no fixed height.
3. **Easements.** [BG_A]: 4 plain LINEs on layer EASEMENT (colour 6, DASHED), plus surveyor's easement lines left on A-SURVEY with imported linetypes. [BG_B]: none drawn (a sample on A-EASEMENT only). [BG_C]: none. No easement text standard was found.
4. **Street name.** [BG_C]: one MTEXT, height 400, letter-spaced, on A-ARCH BACKGROUND with colour forced to 2. [BG_B]: one TEXT, height 400, letter-spaced, rotated 90, on A-TITLE BOUNDARY. [BG_A]: none in the file.
5. **Bench mark box.** [BG_C]: two TEXTs height 300 ("TBM RIVET", "RL:5.31") inside a closed 4-point polyline, all on A-ARCH BACKGROUND with colour forced to 2 (prints black 0.35). [BG_B]: three TEXTs (220 to 250 high) and a closed polyline of width 10 with a mask, on the surveyor's own layer, colour forced to 2, plus a surveyor's symbol block at scale 400. Loose objects, not an office block.
6. **Survey spot levels.** [BG_C]: plain TEXT height 200 on CONTOURS AND LEVELS (colour 45), rotated 45 degrees or to the contour, e.g. "5.39"; no cross symbol in the file. [BG_B]: plain TEXT height 220 on A-SURVEY (colour 11), value only, with a small surveyor's cross block "056" at scale 100 at some points. [BG_A]: MTEXT height 300 on A-SURVEY with colour forced to 250, each with a 2-line cross block at scale 800 (76 of them).
7. **Contours.** [BG_C]: 42 plain LINEs on CONTOURS AND LEVELS with an object linetype scale 0.5 (the layer linetype in this file is the lettered SEWER type, an accident of the clean-up), labels as TEXT 200. [BG_A]: 123 polylines on CONTOURS (colour 34), majors forced to colour 33, imported dashed linetype on some, labels MTEXT height 500. [BG_B]: none.
8. **Kerb and channel, footpath, crossover.** Plain LINEs on SURVEY / A-SURVEY ([BG_C] 237 lines, [BG_B] 208 lines and 13 polylines) with the surveyor's words as text ("EXISTING CROSSOVER" height 300 in [BG_C]; 180 in [BG_B]). No office kerb layer is used in the background.
9. **Existing pits and services from survey.** Left as surveyor's lines on the survey layer. Where the office wants them to read as existing drains it redraws them in the background file with its own existing-drain build: [BG_C] holds one polyline of width 300 on EX DRAIN HATCH (object linetype scale 0.4) and 2 lines on EX STORMWATER. [BG_A] holds the sewer as 2 LINEs on SEWER (lettered linetype, object scale 0.1), 2 circles and 2 TEXTs height 250 ("150mm PVC SEWER MAIN", "2.1m DEEP APPROX").
10. **Neighbours' buildings.** Lines on SURVEY with MTEXT labels height 400 ("ADJOINING CARPORT", "SINGLE STOREY ... RESIDENCE") and house numbers height 700 [BG_C]; in [BG_B] on A-ARCH BACKGROUND with colour forced to 250 and MTEXT height 300.
11. **Architect's building: walls.** Plain LINEs and ARCs on A-WALL, colour 47 (873 objects in [BG_C], 461 in [BG_A], 396 in [BG_B]). All exploded; no wall blocks. Wall fill hatches (pattern, not solid) on A-WALL HATCH, colour 11.
12. **Roof outline.** LINEs, ARCs and SPLINEs on A-ROOF OUTLINE and A-ROOF LOWER OUTLINE, colour 55, with fall arrows as tiny solid hatches and TEXT height 240. Roof fill patterns on A-ROOF HATCH / A-ROOF LOWER HATCH, colour 41.
13. **Windows and doors.** LINEs and ARCs on A-WINDOW & DOOR, colour 9 (1,183 objects in [BG_C]). [BG_B] still has 11 architect door / window blocks on this layer (not exploded).
14. **Stairs, steps, dwarf walls, fences, balustrades.** A-STAIRS UP / A-STAIRS DOWN (colour 9; down is HIDDEN2), A-STEP (9), A-DWAFTWALL (9; spelt that way in the jobs, A-DWARFWALL in today's template), A-FENCE (47), A-BALUSTRADE (47).
15. **Driveway.** Lines and closed polylines on DRIVEWAY, colour 254.
16. **Trees.** [BG_C]: 608 LINEs and 8 CIRCLEs on TREE EXISTING (colour 53): the canopy is an exploded architect symbol, the trunk a small circle. Tree protection circles are CIRCLEs and ARCs on TPZ (colour 2, HIDDEN), the inner root zone forced to colour 233, radius typed from the arborist (1,600 to 2,500). [BG_B]: canopies are 22 CIRCLEs and 529 LINEs on A-LANDSCAPE (colour 73). The green tree-zone hatch seen on paper is drawn in the background file on a HATCH layer (ANSI31, scale 100, [BG_C] layer HATCH 70).
17. **Other hatches in the background.** Load-bearing wall hatches (structural layers), a solid colour-201 fill, the neighbour's footing hatch. So some design content (tree zones, existing drain, wall-over hatches) lives in the background file, not in the job drawing.
18. **Leftovers.** [BG_C] has a pile of the architect's sheet notes shrunk to 1.5 to 4 high text parked beside the site plan (117 MTEXTs), and one empty architect block. [BG_B] has one insert sitting about 6,000,000,000 units away (which wrecks zoom extents) and a parked structural steel section catalogue. [BG_A] has 20 block definitions left from the survey underlay.

### 1.3 What "cleaning" evidently means (architect originals against the cleaned file)

1. **Architect's originals [ARCH_C]:** one DWG per sheet (18 files), exported from a building-model product. Per file: 21 to 39 layers with American-style names (A-WALL, A-GLAZ, A-DOOR, A-FLOR, A-ROOF, G-ANNO-TEXT, C-PROP-LINE, C-TOPO-MAJR...), every layer a different bright colour, 73 to 240 block definitions, 366 to 389 MTEXTs and 42 to 170 dimensions per plan, LTSCALE 1, architect's linetypes, a title block and viewports in paper space.
2. **Cleaned file [BG_C]:** 85 layers, of which 28 carry anything; 4 block definitions; 0 dimensions; 3,557 plain lines. The 57 unused layers are office layers that came with the background template.
3. **So the steps were:** (a) start from the office background template; (b) paste in the site plan, ground floor and upper floor each at its 50,000 station; (c) explode everything (walls, doors, windows, trees become loose lines); (d) move objects onto the office "A-" layers by kind, which forces the office colour through the layer (walls 47, windows 9, roof 55, background 11, survey 253 or 11); (e) delete the architect's dimensions, room names, notes, tags and title block (389 MTEXTs down to about 40 survey and neighbour labels); (f) keep the surveyor's text but leave its fonts; (g) add office content (boundary text, bench mark box, tree zones, existing drain).
4. **Colours forced per object as well.** [BG_B]: 341 of 371 objects on A-ARCH BACKGROUND are forced to colour 250; [BG_A]: all 869 objects on A-SURVEY are forced to colour 250. So grey-ness is set two ways: by layer in [BG_C] (the newest), by object in the older two.
5. **Layer counts after cleaning:** [BG_A] 36, [BG_B] 34, [BG_C] 85. The job then shows that many layers again per attachment.
6. **Not every job is cleaned to the same depth.** [BG_A] and [BG_B] keep surveyor blocks, imported linetypes and surveyor layer names; [BG_C] is fully on office layers.

### 1.4 The office background templates [TMPL:x_blank, x_site, x_ground, x_first, x_roof, x_basement]

1. **Six files.** The blank one (dated Dec 2025, 105 layers, 61 objects) is the current starter. Five older ones are named for site, ground, first, roof and basement (2022 to 2023; the "first" one re-saved Sep 2026; 90 layers, 58 objects each, identical object counts). The older idea was one background file per level; the jobs studied use ONE file with the levels stacked.
2. **What the blank one holds:** a printed key of the background layers, one sample line and one name text (height 250) per layer, 27 of them: A-WALL (47), A-WALL HATCH (11), A-WINDOW & DOOR (253 in this template, 9 in the jobs), A-STAIRS UP, A-STAIRS DOWN, A-STEP, A-DWARFWALL, A-DECK (49), A-ROOF OUTLINE and LOWER OUTLINE (55), A-ROOF HATCH and LOWER HATCH (41), A-FENCE (47), A-FENCE HATCH, A-BALUSTRADE, A-EXISTING WALL (61), A-EXISTING WALL HATCH (250), A-EXISTING STAIRS, A-DEMOLISH (10, DOT2), A-TITLE BOUNDARY (2, DASHDOT2), A-EASEMENT (2, DASHDOT2), A-SURVEY (11), A-LANDSCAPE (73), A-ARCH BACKGROUND (11), DRIVEWAY (254), CONTOURS AND LEVELS (45, CENTER2). Plus the registration lines on DEFPOINTS and a sample "MTEXT WITH MASK".
3. **The older level templates** also carry sample existing-pit lines, existing drain polylines and a tree-zone arc, i.e. the office expects existing drains to be drawn in the background file.

---

## 2. Templates and libraries

### 2.1 A1 templates folder

1. **CE_A1_C01 - VERTICAL** (Oct 2026). The civil sheet template studied by A. Two frames and two layouts (C01, C02), 149 layers, 107 named blocks, 620 model objects. Title strip down the right-hand side. Besides A's parked kit it parks a "SITE INFO AND CALCULATIONS" form, a "CHARGED PIPE TO RG" sample, a tree-zone hatch sample and two council name headings above parked note blocks (Manningham; Casey commercial). [TMPL:a1_c01_vert]
2. **CIVIL TEMPLATES\BAYSIDE COUNCIL** (Feb 2026). NOT a blank council template: it is a finished two-unit job saved into the template folder, with its design still in it (8 pits, 24 downpipes, levels, dated revision rows, its two background attachments). 241 layers (94 more than the civil template, mostly the attachment's), one layout. Council-specific content found: a "SHARED DRAINAGE ASSET" note about shared drains needing common property or easements and an agreement between owners; detention pipes labelled with metres of detention; tank notes with concrete pad level; a pump specification placeholder. Layer colours differ from the main template (HATCH 51 is 51 here, 250 there; HATCH 21 is 49 here, 21 there). [TMPL:a1_bayside]
3. **BASEMENT SHEET SET\Civil\25-xxx - C01** (Jan 2025) and **SUPERSEEDED\Civil\25-xxx - C01** (Oct 2025). Earlier copies of the civil template: one frame, one layout, 524 to 584 objects. They carry a second schedule block "STORMWATER PIT SCHEDULE 2024" beside the older one, a pump specification placeholder ("DUAL xx l/s ALTERNATING PUMPS / x.xxm STATIC RISE / xxm RISING MAIN / MIN. xx.xxm WET WELL STORAGE / SOLID CLASS B LID"), and a "RAINWATER GARDEN" text. They lack the silt pit block and the above-ground 2,500 litre tank block that the current template has. [TMPL:a1_basement_civil_c01, a1_superseded_civil_c01]
4. **BASEMENT SHEET SET** (Jan 2025): six structural sheets S01 to S06 as separate drawings plus a sheet-set file. S01 holds general notes and a drawing list that already names "STORMWATER DRAINAGE AND PAVEMENT PLAN" and "STORMWATER DRAINAGE AND PAVEMENT DETAILS" as sheets of the set. It also holds the block "MOC" and an "ANGLE OF REPOSE" block. [TMPL:a1_basement_s01]
5. **CE_A1_S01 - VERTICAL and - HORIZONTAL** (2026). Structural first sheets: one frame at 0,0, one layout S01, the title block attached as a reference (not a block) on layer XREF, a drawing-list table made of loose texts (sheet number, title, revision). The horizontal one has the title strip along the bottom. [TMPL:a1_s01_vert, a1_s01_horiz]
6. **1CE_TITLE BLOCK VERTICAL and 2CE_TITLE BLOCK HORIZONTAL.** The title block drawings the structural sheets reference. The horizontal one (Sep 2026) has separate revision-letter texts for structural and civil, and five stamp layers including two preliminary stamps ("checked" and "not checked" by a named person). [TMPL:a1_title_horiz]
7. **Both title orientations are used on civil jobs.** Vertical strip on CIV-05, 07, 08, 14, 15; horizontal strip on CIV-10 and CIV-11 [PDF]. The civil template folder only has the vertical one, so horizontal civil sheets are made another way: Unknown how.
8. **SUPERSEEDED** holds 15 older copies, several with a PC name on the end (sync conflict copies). There is also an unsaved recovery file in the live folder.

### 2.2 A3 templates folder

1. **Four current files, all structural.** A plain one (14 layouts S01 to S14), a basement one (18 layouts), and two builder-specific ones (14 layouts each, one with 123 named blocks of that builder's standard schedules and details). A3 paper, one 408 x 262 viewport at 1:100 plus a small north-point viewport per layout, title block as a block in paper space, page set-up "CE A3 TO PDF". Sheets are laid out in model space on a 50,000 grid. [TMPL:a3_*]
2. **There is no A3 civil template.** Civil is always A1 in what was read.

### 2.3 Standard Details\Civil (nine drawings)

All are parts stores in model space under big headings (3,000 to 6,000 high); one unused layout each. Many sub-headings are old job references (kept as worked examples); they are not listed here.

1. **CE Civil Details** (3.2 MB, Oct 2026). 23,863 objects, 96 named blocks plus 42 machine-named. Main headings: TYPICAL DETAILS, PAVEMENTS / KERBS (CONCRETE PAVEMENTS, ASPHALT PAVEMENTS, GRAVEL, PERMEABLE PAVING, KERBS IN R.C SLAB), SPOON DRAIN - kerbs, GRATED TRENCH, PIPE BEDDING (two council variants), SUMP, RAINWATER HEAD, PENETRATION THROUGH BAND BEAMS, RETAINING WALLS ON CIVILS, FLOOD PROOF WALLS, DRIVEWAY/ROAD DESIGN, LONG SECTION EXAMPLES, FIRE SERVICES, ROOF DETAILS, KINGSTON NOTES, MARIBYRNONG NOTES, PUMP NOTES FROM AS3500, TOOL PALETTES CIVIL BLOCKS, VARIOUS. Detail titles found: junction pit (900 max. and 900 to 1200 deep), grated silt pit, side entry pit, sealed inspection opening, pipe bedding (pavement, grass, asphalt, fire service), spoon drain in concrete pavement (min. grade 1:100 and 1:200 versions), grated drain (residential; commercial/industrial), kerb and channel type B2, concrete kerb to asphalt, light / medium duty asphalt pavement build-ups (180, 280, 290, 475 thick), permeable driveway and paving, expansion joint set-up, construction joint, sawcut, scabble joint, re-entrant bars, lap splice, slab on engineered fill, pipe penetration through slab band beam, retaining wall on boundary, typical paving plan around house, down pipe detail, car park drainage detail, driveway long section at 1:50, civil works legend. Named blocks include the pipe strips (100 / 150 / 225 / 300 DIA. PIPE and DESCRIPTION), COVER LEVEL, INVERT, RL___, RISING MAIN, SILT PIT, PIT 900 MAX, PIPE BEDDING R.C & GRASS, PIPE INLET, CIVIL LEGEND, OVERLAND FLOW PATH, BATTER, RETAINING WALL. [DET:civil_details]
2. **CE Civil ORIFICE PITS Details** (4.7 MB, re-saved 10 Nov 2026; a "_PRE_C7_" copy sits beside it). 12,871 objects, DIMSCALE 20. 54 named blocks. Headings by council: BOROONDARA, MONASH, MORNINGTON (PENINSULA), plus old job references. About 26 worked orifice pit details, nearly all titled "ORIFICE PIT P1 DETAIL / SCALE 1:20" (21 copies) with one of several standing lines: "PIT TO BE CONSTRUCTED IN ACCORDANCE WITH COUNCIL STANDARDS", "BAFFLE WALL PIT TO BE CONSTRUCTED IN ACCORDANCE WITH COUNCIL REQUIREMENTS", "REFER ALSO TO COUNCIL STANDARD DRAWING" (28 times; named standard drawings for Mornington Peninsula, Knox and two others), "TO BAYSIDE / GLEN EIRA / MANNINGHAM COUNCIL'S REQUIREMENTS". Councils named in the text: Bayside, Boroondara, Glen Eira, Kingston, Knox, Manningham, Monash, Mornington Peninsula. Two named blocks "ORIFICE PIT" and "ORIFICE PIT P1"; the rest are machine-named, i.e. each is a pasted job detail whose numbers are edited inside the block. [DET:orifice_pits]
3. **CE Civil WATER TANKS - PUMP STATIONS Details** (4.1 MB). 19,489 objects, 156 named blocks (127 machine-named). Headings: SLIMLINE, UNDERGROUND, CONCRETE, DONUT / BAGEL, named tank makes (4), WITH FLOATERS, DETENTION ONLY, REUSE, SHARED (DETENTION & REUSE), SEDIMENTATION TANK, PUMP STATIONS (WITH DETENTION, WITHOUT DETENTION, WITHOUT DETENTION / 2 SPS), LEGEND, two CHARGED SYSTEM NOTES blocks (charged system to tank; charged system to pit). Titles: "SPS STORMWATER PUMP SYSTEM DETAIL / SCALE 1:20" (4), "STORMWATER PUMP STATION SP1 DETAIL" (2), a builder's reinforced concrete underground tank (4). 70 texts mention an orifice (tank outlets). [DET:tanks_pumps]
4. **CE Civil WATER TANKS PLAN** (Sep 2026). Plan-view tank symbols under ABOVE GROUND and UNDERGROUND, by shape and make: SLIMLINE, ROUND, CONCRETE, DONUT / BAGEL, four makes, VARIOUS. Named blocks: 2500, 3000, 3500, 5000, 6000 litre tanks and one underground 5000. [DET:tanks_plan]
5. **CE Civil SOAKAGE PITS - INFILTRATION Details** (Feb 2026). 2,336 objects. One heading DETENTION and two job references. 20 copies of "TYPICAL ATLANTIS MATRIX WATER TANK DETAIL", pit details P1 and P3, a standing note "NO GROUNDWATER HAS BEEN ENCOUNTERED WITHIN 1m OF SOAKAGE PITS". Uses the Stormwater Pit block. [DET:soakage]
6. **CE Civil RAINGARDENS - SWALES - BUFFER STRIPS Details** (4.1 MB, re-saved 10 Nov 2026 with a "_PRE_C7_" copy). 9,715 objects, 83 named blocks, 104 proxy objects (content from another product that AutoCAD cannot edit). Headings: RAINGARDEN, SWALE, GRASSED SWALE, BUFFER STRIP, LEGEND, then 33 job references each with that job's raingarden section. Titles: RAIN GARDEN DETAIL, #1 and #2, an "INFILTRATION TYPE OF RAINGARDEN", one area note of the form "TOTAL AREA: 31m2 DRAINING 396m2 OF CAR PARK". One named block "RAINGARDEN NO LINING". [DET:raingardens]
7. **CE Civil LONG SECTION EXAMPLES** (Oct 2026). Nine worked long sections; see 2.6.
8. **CE Civil KINGSTON COUNCIL NOTES** (Sep 2026). Three layouts ("Kingston Council Sheet 1 to 3") and six model-space headings (SHEET 1 to 6) with 27 numbered tiles: the council's standard drawings pasted as blocks (39 machine-named blocks), on an old A3 title sheet. This is the only council with its own notes drawing. Other council note blocks live inside CE Civil Details (KINGSTON NOTES, MARIBYRNONG NOTES) and parked in the A1 template (Manningham, Casey commercial). [DET:kingston_notes]
9. **CE Roof Details** (Dec 2025). Small: roof drainage / downpipe sketches, a bracing block, a legend. [DET:roof_details]
10. **PDFs beside them:** orifice pit detail, pump station detail, Kingston notes, pipe cover table, pump station diagram, two tank diagrams, swale types. Two of the tank diagrams are the PDF underlays A found inside JOB_C.
11. **Which details exist, by topic:** orifice / control pits per council: yes, about 26 worked ones for 8 councils, as pasted job details. Junction pits: yes (two depths), silt pit, side entry pit. Tanks: yes, many. Pump stations: yes (with and without detention, twin). Soakage: yes (modular units). Raingardens / swales / buffer strips: yes. Spoon drains: yes. Kerbs: yes. Pavements and joints: yes. Pipe bedding: yes (general plus two council variants). Penetrations: yes. Long sections: yes (nine). Council note blocks: Kingston (drawing of its own), Maribyrnong, Manningham, Casey commercial, Bayside (only inside the job-as-template). Legends: one civil works legend (same block as on every job) plus legends in the tank and raingarden drawings.

### 2.4 CE Computation Sheet.dwg [A's converted copy]

1. **What it is:** an A4 portrait calculation page for hand-style sketches, not a stormwater form. One layout "Computation Sheet Plot HERE" (A4, page set-up "CE COMP SHEET PDF", office plot style table), one 210 x 297 viewport at 1:100.
2. **Fill-in parts:** a block "COMPUTATION SHEET1" (the page frame and header) with a parked instruction "DOUBLE CLICK TO EDIT PROPERTIES. DATE WILL UPDATE AUTOMATICALLY UPON PLOTTING" (the two fields A counted are the date and a property).
3. **What is drawn on it today:** a rainwater head / box gutter sketch with dimensions (175, 600, 150, 200), "NOT TO SCALE", and notes beginning "THE RAINHEAD SHALL BE FULLY SEALED TO THE BOX GUTTER...". So it is used to issue a one-page sketch on the office calc header.

### 2.5 Tool palettes, civil only [palette files]

1. **BLOCKS CIVIL (current set, Dec 2024), tool -> source block -> master drawing.** Every tool points at the office master "CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg" in the Drawings Templates folder, except the downpipe, which points at the civil A1 template. Stormwater pit -> "Stormwater Pit"; pit block -> "PIT BLOCK"; downpipe -> "DOWNPIPE DYNAMIC WITH MASK" (from CE_A1_C01 - VERTICAL.dwg); overflow -> "OVERFLOW"; inspection opening, grated inspection, floor waste -> their "... DYNAMIC WITH MASK" blocks; trench grate -> "TRENCH GRATE"; cut tube, scabble, RL right -> named blocks. Thirteen tools point at machine-named blocks in the master: riser / dropper, existing pit and pipes, existing council drain, cut pipe, RL left, fall label, spoon drain label top and bottom, the four "P level" corner tags, services lines, low pressure gas pipe, civil retaining wall.
2. **LABELS CIVIL (24 tools):** invert level (4 corner variants), cover level (4), "PP" (4), flow arrow top and bottom, pipe description top and bottom for 100, 150, 225, 300 and rising main. All from the master drawing.
3. **"NEW" set (Sep 2026):** BLOCKS CIVIL, BLOCK CIVIL 2 and LABELS CIVIL: 56 tools from the master, 2 from the civil A1 template.
4. **Consequence:** a palette tool breaks if the master drawing is renamed or moved, or if a machine-named block inside it is purged or re-pasted (its name changes).
5. **How palettes reach a PC:** each PC's palette path is its own local AutoCAD folder (see 6.6), so the shared palette files are imported by hand into each PC; they are not read live from the shared folder.

### 2.6 Long sections: how one is drawn

**Sources:** nine examples in [DET:long_section_examples] (measured in detail on one, checked across all), and the issued sheet of CIV-05 [PDF:CIV-05 p2] and CIV-10 [PDF:CIV-10 p2]. No tool draws these; every one is loose lines and text.

1. **Objects.** Plain LINEs, plain TEXT (306 of them), a few MTEXTs, polylines with width for pits, ellipses for crossing services. No blocks, no table object, no attributes. The older examples sit on layers 25CONT, 35CONT, 25TEXT, 35TEXT, 50TEXT; three newer ones sit on a layer "SCHED".
2. **Scales.** Horizontal 1:100 with vertical 1:50 on seven examples (so heights are drawn at twice size: 1 m of level = 2,000 units, 1 m of chainage = 1,000 units); one at 1:200 / 1:100. The issued CIV-05 sheet states "HORIZONTAL SCALE 1:250 / VERTICAL SCALE 1:25". The scale is typed under the title.
3. **Datum line.** The top line of the table, a full-width horizontal LINE, labelled at the left "DATUM LEVEL R.L. 125.00m" (also seen "DATUM LEVEL AHD 35.00m", "DATUM LEVEL R.L. 12m AHD"), TEXT height 350 on 35TEXT. All heights above it are measured from that line.
4. **Row lines.** Horizontal LINEs 1,500 apart (15 mm on paper), all the same length (30,506 on the measured example), closed by a vertical line at the left of the titles.
5. **Row titles (height 350, left-justified, on 35TEXT), top to bottom on the fullest example:** DATUM LEVEL, PIPE SIZE, PIPE GRADE, Vp - PIPE VELOCITY PART FULL, Qf - PIPE FLOWING FULL, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE. Variants across the nine: PIPE CAPACITY instead of the two flow rows; "PIPE CHAINAGE TO CENTERLINE"; a newer set with units in the title ("CHAINAGE (m)", "INVERT DEPTH (mm)", "SURFACE LEVEL (m)", "PIPE INVERT LEVEL (m)", "PIT INVERT LEVEL (m)"). CIV-05 as issued: PIPE SIZE, PIPE GRADE, PIPE DESIGN FLOW / VELOCITY, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE.
6. **Vertical grid.** One vertical LINE per chainage point. At pits and at the ends it runs from the bottom of the table right up to the surface line. At in-between points it is in two pieces: through the bottom four rows only (6,000 long: invert depth, invert level, surface level, chainage), and again from the datum line up to the surface. The upper rows (size, grade, flow) are left open so their text can span a whole pipe run.
7. **Text per column.** Level and chainage values are TEXT height 250 on 25TEXT, rotated 90 degrees, sitting just right of their vertical line, two decimals ("126.58", "5.56"). Where a pit has two inverts there are two texts side by side. Pipe size ("225 DIA. RC CLASS 2 RJJ PIPE"), grade ("1 in 100"), velocity ("1.46 m/s") and flow ("58 l/s") are horizontal TEXT centred in the run.
8. **Pipe.** Two parallel LINEs on 35CONT per run: invert and obvert, the gap equal to the diameter times the vertical exaggeration (450 for a 225 pipe at 1:50). Continuous, not the dashed coloured band used on plan.
9. **Surface.** LINEs on 25CONT from point to point. Footpath, crossover and kerb are shown as a second line 200 below the first (pavement thickness at twice size) with short end ticks. Labels above ("CROSSOVER", "FOOTPATH", "NATURE STRIP", street name) as TEXT or MTEXT 180 to 250.
10. **Pits.** A vertical polyline of width 300 on 35CONT from surface down to invert, drawn as a solid bar, with "PIT P1" / "PIT CP1" / "ExP" as TEXT 250 rotated 90 above. On the issued CIV-05 sheet the pit bars carry a circled pit tag on top.
11. **Title boundary.** A vertical LINE on layer BOUNDARY (DASHDOT) from the datum up past the surface, labelled "TITLE BOUNDARY" rotated 90.
12. **Services crossings.** An ELLIPSE (a round pipe squashed by the exaggeration) at the service's depth, a thin dash-dot vertical line through it, and stacked rotated labels ("HIGH PRESSURE / GAS PIPELINE / DEPTH UNKNOWN", "WATER MAIN / DEPTH UNKNOWN", "TELECOM LINE / DEPTH UNKNOWN", an existing sewer with offset and depth).
13. **Ends.** A break symbol (zig-zag polyline and arc) where the existing pipe carries on.
14. **Title.** "LONGITUDINAL SECTION" or "OUTFALL DRAIN LONGITUDINAL SECTION", TEXT height 500 underlined, with the two scale lines at 250 below.
15. **Standing notes that travel with it:** an "OUTFALL DRAIN NOTES" block (reinstatement of footpath, kerb and nature strip to council satisfaction) and on CIV-05 a yellow NOTES box of eight council conditions plus three council standard drawings pasted as pictures (side entry pit, bedding and backfill, property drainage inlet connection). [PDF:CIV-05 p2]
16. **What else is on an outfall sheet [PDF:CIV-05 p2, CIV-10 p2]:** its own plan "OUTFALL DRAINAGE PLAN" at 1:100 of the street reserve, a circular "LOCALITY PLAN" with north point, its own short pit schedule (existing council pit and the new side entry pit), a "SECTION A-A" at 1:20 across the trench showing clearances to crossing services with dimensions, and a "BUILDER TO CONFIRM LOCATION AND DEPTH OF ALL SERVICES" box.

---

## 3. Items study A could not decode

### 3.1 Which visibility state each pit is set to (decoded)

**How:** each dynamic insert carries, in its own attached data, a record holding the chosen state name as plain text. [JOB_A/B/C, `gap3.py`]

1. **JOB_C (8 pits on the sheet):** six "350x350 Grated pit" (the plastic pits and small grated pits), one "450x450 Grated Pit" (P2), one "600x1200 Detention Pit" (P1, the orifice pit). One parked sample: "350x350 Grated pit".
2. **JOB_B (13 on the sheet):** three "350x350 Grated pit", one "350x350 Junction pit", one "450x450 Grated Pit", three "600x600 Grated Pit", two "600x900 Junction", one "900x900 Grated Pit", one "600x1200 Detention Pit". One parked.
3. **JOB_A (12 on the sheet):** eight "450x450 Grated Pit", four "600x600 Grated Pit". One parked.
4. **So the orifice / control pit is the state named "600x1200 Detention Pit"**, and the state name is readable by a program. The size typed in the pit schedule is NOT always the state: JOB_C's schedule says "2 / 600 x 600" for the pit drawn with the 600x1200 state; JOB_B's sum labels pits 900 x 900 and 900 x 600 where the drawing uses other states.
5. **Trench grates:** the template's stretchable "TRENCH GRATE" has no state name; its two stretch distances read as zero in the parked samples (their sizes come from separate saved copies). JOB_A and JOB_B use plain blocks named "100 / 200 / 300 TRENCH GRATE".

### 3.2 Why the note boxes print yellow and the driveway grey (solved)

1. **The fills carry no colour of their own.** Every solid hatch on HATCH 51, HATCH 21 and HATCH 141 is colour "by layer", no true colour, gradient switched off. (Each stores AutoCAD's default blue-to-yellow gradient pair, unused.) [JOB_A/B/C]
2. **The layers have a second colour that applies only inside the sheet viewport.** Each of four layers carries a viewport colour override for both viewports of the layout: HATCH 51 -> colour 51, HATCH 21 -> colour 21, HATCH 141 -> colour 141, HATCH 74 -> colour 74. In model space the same layers are 250, 49, 149 and 117 (dark colours that show up on a black screen). [JOB_C layer records]
3. **The plot style table then gives the printed look:** colour 51 = own colour (pale yellow) at 25% screen; colour 141 = own colour (light blue) at 25%; colour 21 = black at 20% (light grey). [CTB]
4. **Checked against paper:** the issued JOB_C sheet measures yellow boxes at red 255, green 255, blue 223; building footprint 223, 247, 255; driveway 204, 204, 204. These are exactly colour 51 at 25%, colour 141 at 25% and black at 20%. [PDF of JOB_C, pixel samples]
5. **Meaning for any tool:** the fills only print right when seen through a viewport that carries these four overrides. A new layout or viewport without them prints dark grey boxes. The older "Bayside" job-as-template instead sets HATCH 51 to colour 51 directly.
6. **Other hatch facts:** tank symbols use real gradients (two blues) on HATCH WATER; batter fills are colour 250 forced; downpipe dots are solid by layer (red).

### 3.3 What block "MOC" is (identified)

1. **It is the "no digging" pictogram:** a digger under a red circle-and-bar in a rounded square. 55 objects (three solid hatches, polylines and lines) all on layer 25CONT, about 6,900 x 4,000 as drawn. [JOB_A/B block; PDF of JOB_B top right]
2. **Use:** inserted once per sheet on layer STORMWATER at scale 0.45 to 0.5 beside the optic fibre warning box, under the top row of boxes. JOB_C does not have it (it has the newer "before you dig" logo block instead). It also sits on the basement structural S01 template.
3. **It is not a north point.** The north point is in the title block.

### 3.4 Draw order (decoded)

**How:** model space has a draw-order table listing every object; position in it gives what is drawn on top. All 633 objects of JOB_C are in it. [JOB_A/B/C]

1. **Bottom of the pile:** the solid fills (driveway, building footprint, note-box fills: positions 0 to 16 of 633 in JOB_C), then the background attachments (positions 2 and 3 in JOB_C).
2. **Pipe band then walls:** in every matched pair the wall double-line is drawn after (on top of) the coloured band: 10 of 10 in JOB_C, 25 of 25 in JOB_B.
3. **Pits over pipes:** the pit block is on top of the pipe band in 6 of 8 cases (JOB_C), 10 of 12 (JOB_B); over the walls in all matched cases there. JOB_A is mixed (3 over, 5 under).
4. **Downpipe dots over pipes** (JOB_B 10 of 10, JOB_C 2 of 2; JOB_A mixed).
5. **Invert texts and flow arrows are usually over the pipe** (about 80 to 90%), but not always: nobody tidies the order, the mask on the text does the visible work.
6. **Pit tag versus pit:** the tag is usually UNDER the pit in the table (they do not overlap, so it does not show).
7. **Reading:** the order is what falls out of copy and paste plus an occasional "send to back" on fills and backgrounds. It is not maintained deliberately, and JOB_A shows it going wrong without anyone noticing on paper.

### 3.5 Clip boundaries of the background attachments (decoded)

1. **JOB_C:** two rectangles, both with the left edge at X 106,313 and the top edge at Y -153,227, which are exactly the left and top edges of the sheet frame. Site attachment 58,518 wide x 25,872 high; ground attachment 58,518 x 26,566. Both attachments were moved 2,630 to the right after clipping (the clip moved with them).
2. **JOB_B:** two rectangles from the same frame corner: 50,509 x 29,365 and 51,545 x 30,327.
3. **JOB_A:** three 6-point polygons (the part plans), each with its top edge on the frame top (Y -153,227), plus one unclipped copy inside the key plan block at scale 0.2.
4. **Frames:** the clip outline is switched off (it does not show or print).
5. **So the plan area is cut by eye to the sheet corner**, wide enough for the plan and stopping where the notes column and the schedule start.
6. **A side-effect found in JOB_C:** six downpipe symbols carry the very same clip rectangle as the background. The drafter clipped with a selection that included them. Harmless on paper, but those downpipes will vanish if dragged outside the rectangle.

---

## 4. Paper look of more job kinds

**Method:** latest issued civil PDF of each job, every sheet rendered; nine sheets read closely as pictures (CIV-05 p2, CIV-07, CIV-08 p1, CIV-10 p1, CIV-11 p1, CIV-15 p1 and p3, and JOB_B / JOB_C tiles), the rest by their extracted text. Only things NOT already in A's notes or the Stage 1 element list are listed.

### 4.1 Pump job, CIV-07 (one sheet, vertical title, "for council approval", 1:100 and 1:20)

1. **Zones:** as the standard sheet, with the detention criteria box replaced by a pump box, and the right half of the details strip taken by the pump station.
2. **"STORMWATER PUMP SYSTEM (SPS) SPECIFICATIONS" box**, bullet rows: "DUAL 7.90 l/s ALTERNATING PUMPS", "0.67m STATIC RISE", "5m RISING MAIN", "MIN. 4.72m3 WET WELL STORAGE", "SOLID CLASS C LID", "PUMP & WET WELL TO COMPLY WITH AS3500.3".
3. **"STORMWATER PUMP STATION (SPS) DETAIL"**: a section of a round well (2000 dia.), with a ladder of levels down the right side, each a level tick and a name: top cover level, inlet level, HIGH LEVEL ALARM, TOP WORKING LEVEL, PUMP 2 START LEVEL, PUMP 2 STOP LEVEL, PUMP 1 START LEVEL, ALL PUMP STOP LEVEL, base level; a grey band for the stored volume labelled with cubic metres of detention; "WET WELL STORAGE (MINIMUM x m3)"; "MIN. CAPACITY"; rising main outlet, inlet pipe, grated class C trafficable cover.
4. **"PUMP NOTES:" box** (items a to f, from the standard), **"PUMP CONTROL PANEL NOTE"** (dual adaptor for a generator, battery backup), **"CONTROL PANEL NOTE"** with a small picture of the panel and "to be mounted on the external wall", and a large-type box "NOTE: FULLY TANKED PUMP PIT. COUNCIL DOES NOT ACCEPT SUB-SURFACE WATER AND GROUNDWATER INTO THE PUMP SYSTEM".
5. **On the plan:** the well as a circle with an "SPS" tag in a circle; a "RISING MAIN" pipe drawn in a third colour (green) from the well to the kerb; "CONNECT TO KERB & CHANNEL AT APPROX IL ..."; roof catchment shown as a blue diagonal hatch over the building with a legend line "HATCH DENOTES AREA OF ROOF CATCHMENT DIRECTED TO WATER TANK" and a label "177m2 ROOF CATCHMENT AREA TO WATER TANK" on each dwelling; "100 DIA. DROPPER FROM WATER TANK / CONNECT INTO PP" and "100 DIA. RISER TO WATER TANK" labels; a small isometric picture of a plastic pit titled "PIT P1 DETAIL"; a "BUFFER STRIP" legend swatch and "TYPICAL BUFFER STRIP DETAIL".
6. **Schedule:** the well is a row whose "from" cell reads SPS.

### 4.2 Soakage with raingarden, CIV-08 (two sheets)

1. **Sheet 1 zones:** plan across the top; under it the pit schedule and, unusually, the CIVIL WORKS LEGEND moved to the bottom left; three soakage details and the tank detail in the middle; general notes moved to the lower right.
2. **Soakage on plan:** each soakage pit is a grid of small rectangles (one per module) with a label block: "SOAKAGE PIT 1 / 60 DOUBLE SOAKAGE MODULES (5 x 11). INSTALL THE MATRIX WATER TANK IN ACCORDANCE WITH MANUFACTURER'S SPECIFICATIONS. SOAKAGE MODULES ARE TO BE WRAPPED IN GEOTEXTILE FABRIC." (also 30 modules as 3 x 10 and 40 as 4 x 10).
3. **Roof catchments:** each dwelling's roof hatched a different colour and direction, with a legend row of four swatches: "ROOF 1 TO WT1 - 140.2m2", "ROOF 2 TO WT2 - 131.9m2" and so on.
4. **Raingarden on plan:** a small green shape with a note "3.5m2 RAINGARDEN. MIN. 1m2 REQUIRED TO TREAT DRIVEWAY OF DWELLING 1".
5. **Details:** "TYPICAL DETAIL FOR SOAKAGE PIT 1 / 2 / 3" (section through silt pit with trash rack, inlet pipe, module block with count, levels, compacted sand and geotextile notes, manufacturer line); "IN-GROUND INFILTRATION RAINWATER GARDEN TYPICAL SECTION" with layer callouts (50 gravel mulch, 500 filter media, 100 transition, 300 drainage) and "NOTE: BOTTOM OF RAINGARDEN UNLINED HENCE AGI DRAIN NOT REQUIRED"; a three-column specification box FILTER LAYER / TRANSITION LAYER / DRAINAGE LAYER with a grading table (description, proportion, grading); "TYPICAL WATER TANK DETAIL".
6. **Schedule remarks** carry silt pit levels ("Silt Pit IL 4.13 Class B Grate") and "Plastic Pit Class A Grate".
7. **"PERMEABLE DRIVEWAY"** area labelled on plan (pink fill). **Sheet 2:** "PAVEMENT PLAN AND DETAILS" with "DRIVEWAY DETAIL" and "PERMEABLE PAVING DETAIL".

### 4.3 Outfall with long section, CIV-05 (two sheets; sheet 2 "OUTFALL DRAINAGE PLAN AND DETAILS", scale "AS SHOWN", construction issue at revision E)

1. Covered in 2.6 items 15 and 16. Extra points: the outfall pipe in the road is drawn with the same blue band as site pipes; existing council pit tagged "ExP", new side entry pit "SEP"; connection note "CONNECT TO NEW SIDE ENTRY PIT AT APPROX IL ... TO COUNCIL SATISFACTION"; adjoining lot numbers and "CROSSOVER No. nn" named on the section; the revision list on this sheet has ten rows.
2. Sheet 1 adds "CONNECTION TO NEW COUNCIL SIDE ENTRY PIT DETAIL" and "WT1 / WT2 WATER TANK DETAIL".

### 4.4 Industrial, CIV-11 (three sheets, HORIZONTAL title strip along the bottom, "for council approval" revision D)

1. **Sheet 1 zones:** plan takes two-thirds of the sheet; legend and general notes top right; pit schedule right; criteria box and slab legend under the plan title; title strip full width at the bottom with the revision list at its left.
2. **New on plan:** boundary sides labelled "SITE 35670 (350°37'20")"; car park slab in grey with every car space, kerb lines, accessible bays; a grid of red pavement levels with fall arrows across the whole hardstand; "SUSPENDED" pipes drawn (magenta) inside the building with "150 DIA. UPVC SUSPENDED PIPE AT 1 IN 100 MIN." labels; water tanks named RWT1 to RWT3; a modular underground detention tank drawn as a hatched grid with a note giving make, length x width x height and "HOLD MINIMUM 18.2m3 DETENTION VOLUME"; a proprietary treatment device called out by make and model "REFER MANUFACTURER SPECIFICATIONS"; "OVERFLOW TO DISCHARGE TO ATMOSPHERE"; "PROVIDE 500 WIDE BREAK IN KERB TO ALLOW FOR OVERLAND FLOW PATH AT 1% AEP"; "PROPOSED RETAINING WALLS TO BE CONFIRMED"; "MAX. 1:4 BATTER"; a pit tagged "LPD" at the legal point of discharge and one tagged "OG"; a long connection note about replacing the existing pit with a new junction pit and confirming its depth.
3. **Boxes:** "PIT SCHEDULE NOTE: PITS P1 / P2 / ... ARE ALL TO HAVE [make] LITTER BASKET" (yellow); slab legend swatches "150mm THICK RC CARPARK SLAB" and "150mm THICK R.C SPOON DRAIN" each with mesh, cover, concrete strength, slump, sub-base and edge beam lines.
4. **Criteria box rows:** "SITE PERMITTED SITE DISCHARGE", HEAD, DIA. OF ORIFICE, TWL, TOTAL VOLUME REQUIRED, then the modular tank by name, TOTAL.
5. **Schedule:** 8 pits over about 20 rows (each inlet its own row: from P6, DP, AGI, TG, WT2, ACO), lids "Class D Solid Lid With Step Irons", "Class D Grated Lid With Step Irons", a twin pit "1 / 900 x 900 + 1 / 900 x 900".
6. **Sheet 2:** "P6 CONTROL PIT DETAIL", "SPOON DRAIN IN CONCRETE PAVEMENT DETAIL", "TYPICAL CONCRETE KERB DETAIL", "CONSTRUCTION JOINT DETAIL", "SLAB SPECIFICATIONS". **Sheet 3:** almost no text (a picture sheet); not read closely.

### 4.5 Basements, CIV-10 (three sheets, horizontal title, construction issue revision C) and CIV-12 (two sheets)

1. **A separate basement-level sheet:** "BASEMENT STORMWATER DRAINAGE PLAN" [CIV-10 p1], "BASEMENT DRAINAGE PLAN" [CIV-12 p1], then "GROUND FLOOR STORMWATER DRAINAGE PLAN" [CIV-10 p3] and an outfall sheet [CIV-10 p2].
2. **New on a basement plan:** structural grid bubbles (letters down the side, numbers along the top); the pile wall drawn as a row of circles round the boundary with pile notes from the structural drawings greyed in; "SSL 16.60" slab surface levels; strip drains "SD" and floor wastes "FW" all over the slab with fall arrows; "300(W) TRENCH WITH CLASS C GRATE" across the ramp; "RAMP UP", "500 WIDE HUMP 30 HIGH" at the ramp top; sump pits labelled "600 x 600 WITH CLASS C GRATE ... (INTERNAL) PIT"; an in-basement rainwater tank ("16.63m2 RAINWATER TANK FOR TOILET FLUSHING AND WATER REUSE"); "RISING MAIN"; "VOID TO BASEMENT BELOW" on the ground sheet.
3. **Notes:** "BASEMENT TO BE FULLY TANKED WATERTIGHT"; "NOTE: WATER FROM FLOOR WASTES AND STRIP DRAINS MUST BE COLLECTED AND TREATED PRIOR RE-USE"; "NOTE: AN AGREEMENT SHALL BE MADE AMONG DWELLING OWNERS FOR THE MAINTENANCE OF THE SHARED DRAINAGE AND RAINWATER RE-USE ASSETS..."; "BATTERY BACK UP"; fill compaction notes.
4. **Details:** "TYPICAL STRIP DRAIN (SD) DETAIL" and "TYPICAL FLOOR WASTE (FW) DETAIL" (sections at the shotcrete wall with strip drain make, geotextile, 50 x 50 spoon drain, waterproofing "REFER TO STRUCTURAL"), "STORMWATER PUMP STATION (SPS) & WATER TANK DETAIL", "ORIFICE P1 PIT DETAIL".
5. **A revision cloud in use:** two rows of the pit schedule on CIV-10 p1 are ringed with a red cloud (the only cloud seen on any civil sheet).
6. **Schedule oddities:** a pit named "JP1" with remark "New Junction Pit to Council Standard ..."; the pump well as a row ("SPS / 1500 DIA x 2750") with inlets from "HLs" (high levels), remarks "SUMP PIT PIT IL ...", "SILT PIT PIT IL ...", "PUMP AS PER MANUFACTURER'S SPECIFICATIONS" [SUMS:CIV-12 pit schedule].

### 4.6 Council-supplied, CIV-06 (one sheet)

1. Nothing new in kind: the standard sheet with "ORIFICE PIT P1 DETAIL", "WATER TANK DETAIL", "TYPICAL TRENCH ADJACENT TO FOOTING DETAIL", detention criteria box. The council's figures only change the numbers. Read by text only.

### 4.7 Childcare centre, CIV-14 (three sheets, staged)

1. **Staging is the new feature:** sheet titles "STAGE 1 - STORMWATER DRAINAGE AND PAVEMENT PLAN" and "STAGE 2 - ..."; the details library carries a matching legend line "DENOTES EXTENT OF STAGE 1 WORKS". The job was issued through revision E as "CVL ... STAGE 1 & 2".
2. **New labels:** "ROOF CATCHMENT TO RAINGARDEN", "TO VEGETABLE RAINGARDEN", "RAINGARDEN DETAIL", "PROPOSED RAMP" with a pavement level, "150 HIGH KERB", "KERB & CHANNEL TO ...", "INVERT OF CONCRETE KERB", "TYPICAL EXTERNAL PAVING DETAIL", retaining wall notes, and a pump station (1800 dia.) with the same pump boxes as 4.1 on sheet 3. Read by text only.

### 4.8 Sports pavilion, CIV-15 (three sheets, vertical title; council is the client)

1. **Sheet 1 "STORMWATER DRAINAGE AND PAVEMENT PLAN", scale "AS SHOWN".** The plan fills the sheet; the legend is top right; pit schedule and criteria box sit bottom centre inside the plan area.
2. **Pavement legend with four coloured swatches, each a full specification paragraph:** "130mm ASPHALT FOOTPATH" (asphalt type and depth, crushed rock depth and class, "refer also to [council] standard drawing"), "125mm THICK RC INFILL SLAB", "150mm THICK RC INFILL SLAB" (mesh, chairs, strength, oxide colour, subgrade CBR, edge thickening), "140mm ASPHALT ACCESS PAVEMENT" with a design vehicle statement ("PAVEMENT DESIGNED FOR ONCE PER YEAR ACCESS BY ... RIGID TRUCK WITH A MAXIMUM WEIGHT OF 14 TONNE, CRANE TRUCK ... 18-20 TONNE"). The plan areas are filled in the matching colours.
3. **Other new items:** survey contours and existing surface levels in brown across the whole site; many large tree-zone circles in green hatch; a yellow box "SPECIFIC REQUIREMENTS FOR ALL WORKS WITHIN TREE PROTECTION ZONES" (ten bullets from the arborist); "RETAINING WALL NOTE" box; "REMEDIATE GRAVEL SURFACE" swatch; red clouds around several small items on the plan; an underground tank drawn in plan ("15000 LITRE UNDERGROUND WATER TANK FOR ON-SITE DETENTION PURPOSES. PROVIDE ORIFICE TO BASE OF TANK"); spoon drains called up by width ("300 WIDE SPOON DRAIN REFER TO DETAIL"); crossfall instructions ("CROSSFALLS SHALL BE NO STEEPER THAN 1:40"); path grades written as "1:22 14%"; expansion joint notes between asphalt and concrete; "RE-LINE DDA PARKING BAYS"; a small second plan "STRATCO SHED SLAB / SCALE 1:100 - LOCATED OFF PLAN" with its own legend; "REFER TO STRUCTURAL DRAWINGS FOR ALL OTHER EXTERNAL PAVING, RAMP, STAIRS AND RAFT SLAB SPECIFICATIONS".
4. **Criteria box rows:** PERMITTED SITE DISCHARGE, HEAD (1230mm), DIA. OF ORIFICE, TWL, VOLUME REQUIRED, "UNDERGROUND WT", TOTAL.
5. **Sheet 2:** "ASPHALT PAVEMENT DETAIL", "TYPICAL ASPHALT ACCESS PAVEMENT", "SILT PIT DETAIL", "CONSTRUCTION JOINT DETAIL", "KERB RAMP DETAILS", plus the standard set.
6. **Sheet 3 "SITE CUT AND FILL PLAN" at 1:100: an earthworks sheet drawn by civil.** Coloured hatched zones each labelled with a name and a bench level: "SITE CUT 1 / BENCH RL 27.98" (with "PROPOSED FFL 27.98"), "SITE CUT 2 / SCRAPE EXISTING TO SUIT PROPOSED PATH ... ALLOW FOR 130 THICK PAVEMENT", "SITE CUT 3", "SITE CUT 4", "INFILL SLAB 1 CUT / BENCH RL 27.78", "INFILL SLAB 2 CUT", "FILL 1 / RL 27.78", "PROPOSED SUSPENDED SLAB NO FILL / ALLOW FOR FOOTING EXCAVATION", "SITE SCRAPE TO ALLOW FOR 140 THICK ASPHALT PAVEMENT", over the survey contours and spot levels, with the bench mark box. No volumes are stated. It was first issued alone as a tender-stage "cut & fill plan". This answers B's "earthworks drawn by civil: not found".
7. **Issue stages on a public job:** P1 to P3 (preliminary), T1 to T4 (tender), then A (construction): the revision list shows "TENDER ISSUE" rows, and the tender stamp layer is in use.

### 4.9 Apartments

1. **Not found.** No folder from 2023 to 2026 in the job index is named as apartments; the nearest kind is CIV-10 (units over a shared basement), covered above.

---

## 5. Sums that were missing

### 5.1 Plain house, CIV-01: what the folder really contains

1. **No calculation of the drainage.** The civil folder holds only the eight blank template workbooks every job is seeded with (all still at their 2014 to 2021 template dates, so never opened and saved), the council's discharge letter, the "before you dig" replies, two scanned hand mark-ups and one small PDF.
2. **The one job-made item** is that small PDF: an upper-floor plan with part of the roof hatched and the words "57m2 OF ROOF CATCHMENT AREA TO WATERTANK SHOWN HATCHED". It is a measured area, drawn in CAD, to satisfy a tank-catchment requirement. No pipe check, no downpipe count, no computations PDF, and nothing was sent to council as sums. [SUMS:CIV-01]
3. **So on a house with no detention the pipes are by rule** (100 dia. at 1 in 100), and the only number worked is a roof area to the tank. This answers B's question 1 from the files; the principal should still confirm.

### 5.2 House with detention, CIV-02 (Kingston) [SUMS:CIV-02, three pages, read in full]

1. **Page 1, required storage (Boyd's sheet):** catchment 561 m2; impervious 305, pervious 256; runoff coefficient 0.65; effective area 364.1 m2; "1:5 PSD" at 83 mm/hr gives 5.17 l/s; restricted outflow taken as 5.00 l/s; 1 in 10 year storms of 5 to 30 minutes (98.6 down to 40.9 mm/hr) each give inflow, outflow, volume in and storage; the largest storage is 1,492 litres at 5 minutes. "Detention Required 1492 L".
2. **Page 2, storage provided:** 9 m of 225 pipe = 0.36 m3; pit P1 (0.6 x 0.6, 0.31 deep) 0.11 m3 and pit P2 (0.45 x 0.45, 0.23 deep) 0.05 m3; "IN PIPES AND PITS = 0.52 m3"; then a typed line "Water Tank contribution for tanks 2500L or above = 1.00m3"; "TOTAL = 1.52m3 > 1.49m3".
3. **Page 3, orifice:** 5.00 l/s; coefficient 0.6, gravity 9.81; 67 mm at plate height 310 mm, head 0.2765 m (plate height less half the orifice); 4.93 l/s < 5.00; "Adopt 67 mm diameter orifice".
4. **Form:** the computations are a Word document of pasted spreadsheet pictures with three typed lines, printed to PDF. What went to council: the sheet, this PDF and a declaration form.
5. **New rule seen:** a flat 1.00 m3 detention credit for any tank of 2,500 litres or more (source not stated on the page).

### 5.3 Basement house, CIV-12 (Glen Eira) [SUMS:CIV-12, four pages plus pump sheet and pit schedule, read in full]

1. **Page 1:** site 919 m2; existing impervious 568; proposed 577 ("pool area not considered"); Boyd's sheet with the permissible discharge taken from the EXISTING site: 16.13 l/s at the 5-minute 1 in 5 intensity 94.3 mm/hr; coefficient 0.70; storage required 1,125 litres.
2. **Page 2, a three-line argument instead of an orifice:** "1 in 5 ARI flow from other impervious areas 445 x 0.9 x 94.3 / 3600 = 10.49 l/s"; "Pump flow rate (basement) = 2.5 l/s"; "Total 12.99 l/s < 16.13 l/s (permissible site discharge), therefore OK". Then **outlet pipe capacity by Manning's formula**: 150 dia. at 1 in 100, roughness 0.01, gives 19.80 l/s at 1.12 m/s; "12.99 < 19.80, therefore OK". Then "DETENTION = 3m3 (minimum as per AS 3500.3)" against "pump wet well volume", therefore OK. So this job has a real pipe capacity check, one line long.
3. **Pages 3 and 4, pump:** basement catchment 132 m2, coefficient 1; 1 in 10, 2-hour rain 18.1 mm/hr; volume 4.78 m3; pump 2.50 l/s; pumped in 30 minutes 4.50 m3; extra storage 0.28 m3; "1% catchment" 1.32 m3; "therefore select 3.00 m3 wet well". Discharge invert 31.6, inlet at pump pit 28.46, static rise 3.14 m, rising main 18 m of 50 dia., cover 28.97. Level ladder: high level alarm 28.56, top working level 28.36, pump 2 start 28.26, pump 1 start 26.76, all pumps stop 26.66, bottom 26.26, total depth 2.71 m, 1,500 dia. well. Specification block as printed on the sheet.
4. **Errors on the pages:** the later pump print carries another job's number in its page-2 header; one line reads "12.99 L/d".
5. **Pit schedule kept as its own workbook and PDF** (5 pits plus the well), with the same columns as the sheet.

### 5.4 Rural house, soak on site, CIV-13 (Bass Coast) [SUMS:CIV-13 soakage workbook, read cell by cell]

1. **Inputs:** impervious 365 m2 x 0.9 = 328.5, taken as catchment 329 m2 with coefficient 1; pervious 0; soil permeability 0.325 mm/hr (from the percolation report in the job's folder); moderating factor 2; 1 in 10 year.
2. **The pit is sized by module count:** module 0.408 wide x 0.685 long; 14 wide x 13 long gives 5.712 x 8.905 m; storage depth 0.45 m; porosity 0.95. (Module heights listed beside: double 880, single 450.) Infiltration area 81.0 m2, perimeter 29.2 m, volume 22.9 m3.
3. **Check table:** for each storm from 5 minutes up: intensity, volume in, volume out by soakage during the storm, storage needed, storage provided as a ratio, "OK" or "Inadequate". At 5 minutes: 3.04 m3 in, 0.005 out, ratio 11.4.
4. **Emptying time worked out as 608 hours** (25 days). Nothing on the sheet flags it; this job's overflow goes to a dam (Stage 1 notes).
5. **Also in the folder:** a pit schedule workbook and PDF, and a small separate drawing "soakage.dwg".

### 5.5 Bayside raingarden job end to end, CIV-09 (= JOB_B) [SUMS:CIV-09]

1. **What the council gave:** the discharge letter says discharge must not exceed the pre-development peak and tells the applicant to e-mail the council for the "storage volume and permissible site discharge". A separate e-mail reply ("PSD and SSR parameters") supplied them. The e-mail itself was not opened (a message file); its figures appear in the sums and on the sheet: permissible site discharge 7.48 l/s, storage required 5.35 m3.
2. **Sums sent to council (two pages):** page 1 is only the storage list and the orifice. Pipes: 32 m of 225 (1.27 m3) and 3 m of 300 (0.21) = 1.48. Pits: four pits by plan size and storage depth = 0.88 (two more pits listed at zero depth). Tanks WT1 and WT2 at 2 m3 each. "TOTAL STORAGE 6.36". Orifice: 7.48 l/s; 77 mm at plate height 410 mm, head 0.3715 m; 7.4 l/s < 7.48; adopt 77 mm. This older orifice sheet prints "= 2.6 Ao root h" with gravity 9.8. Page 2 is the STORM report. There is NO required-storage page because the council supplied it.
3. **Pit labels against numbers** (as B noted): pits labelled 600x600, 900x900, 900x600, 600x600 are worked as 0.6 x 0.9, 0.6 x 0.9, 0.9 x 0.9, 0.6 x 0.9.
4. **STORM report by the office (13 Mar 2024), inputs:** municipality and rainfall station (Bayside), development type "Residential - Multiunit", site 1,031 m2, then one row per impervious area: "Roof 1 to RWT" 243 m2 -> rainwater tank 6,000 L, 5 bedrooms; "Roof 2 to RWT" 184 m2 -> tank 6,000 L, 4 bedrooms; "Balcony to storm" 10.5 m2, "Roof 2 to storm" 15.2 m2, "Driveway 1" 35 m2 -> no treatment; "Roof 1 to storm" 49.8 m2 -> "Raingarden 100mm", area 1.00 m2.
5. **Outputs:** treatment 111.8% and 119.6% for the two tanks (tank supply reliability 97.9%), 128.15% for the raingarden, 0 for untreated rows; overall "STORM Rating 103%" (100 is the pass mark).
6. **How raingarden area relates to treated area:** 1.00 m2 of raingarden treats 49.8 m2 of roof, that is 2.0% of the area draining to it, and scores 128%. The architect's earlier report (May 2023, in the same folder) used 1.00 m2 for 61.76 m2 of driveway and paths (1.6%) with one 12,000 L tank on 506 m2 of roof, scoring 101%. CIV-08's sheet says "3.5m2 raingarden, min. 1m2 required to treat driveway". So in all three the area typed into STORM is a round 1 m2, chosen so the total passes 100%, and the drawn raingarden is as big or bigger. No separate sizing sum exists.
7. **What changed between the architect's report and the office's:** the office split the roof into what really reaches each tank and what goes straight to the drain, split the tank into two of 6,000 L, and moved the raingarden from the driveway to a piece of roof. The inputs follow the drainage layout, so the report is redone after the layout is drawn.
8. **On the sheet:** criteria box lists every storage (JOB_B: 6.36 provided against 5.35 required), the raingarden symbol with its section and filter specification, twin 225 detention pipes at 1 in 200.
9. **Other files:** three dated versions of the detention workbook (one prefixed with a second person's initials), an older orifice workbook, and the architect's sustainability report (not read).

---

## 6. What colleagues' PCs have

### 6.1 The records [IT]

1. **Three kinds, written by the plug-ins themselves into the shared IT folder:** 9 machine records (one small file per PC per module, overwritten each time), 2,637 usage records (one file per command run) and 1,029 failure records, in day folders from 20 Apr 2026 to 16 Nov 2026. Also one policy file (who is an administrator), two "approved release" files from April, one support bundle, and a work folder from an AutoCAD 2026 settings experiment.
2. **Gaps in time:** usage records exist for April (1,442), then almost nothing May to September (66), then October (624) and November (505). Reporting was evidently off or broken for five months.

### 6.2 How many PCs, and what each last reported

**Seven distinct PC names appear. PC-2 is the PC this study ran on.**

1. **PC-1:** AutoCAD 2022 in April (one record from AutoCAD 2027 in October). Last reported Civil 1.1.0.0 and Structural 1.0.91 (machine record) on 30 Apr 2026; Manager 1.0.0 on 5 Oct 2026. 746 usage records, 745 of them in April. A real drafting PC in April.
2. **PC-2 (this PC):** AutoCAD 2022 in April, AutoCAD 2027 later. Civil 1.1.0.0 and Structural 1.0.79 on 28 Apr 2026; Manager 1.1.34 on 7 Oct 2026. 786 usage records; 941 of the 1,029 failure records.
3. **PC-3:** AutoCAD 2026. Manager 1.0.0, last seen 26 Aug 2026. 11 failure records, no usage records.
4. **PC-4:** AutoCAD 2027. Manager 1.1.1, last seen 24 Sep 2026. No usage or failure records.
5. **PC-5:** AutoCAD 2026. Manager 1.0.0, last seen 21 Apr 2026. Nothing else.
6. **PC-6:** AutoCAD 2027. Manager 1.1.89, last seen 16 Nov 2026. 1,103 usage records in October and November, 985 of them one command (the block library window), plus version and health checks. This looks like an automated test PC or account, not a drafter: Unknown which.
7. **PC-7:** AutoCAD 2027. Manager 1.1.89, last seen 15 Nov 2026. Two usage records (a health check and a version check).
8. **Reading:** AutoCAD 2022, 2026 and 2027 are all in the records. Only two PCs ever reported Civil or Structural through this channel, both at the April versions (Civil 1.1.0.0). **No record shows any PC other than this one running a Civil newer than April's.** Since October only the Manager reports usage. What Civil and Structural versions the colleagues run today cannot be told from these records.
9. **Where the modules were loaded from:** Civil from the per-user plug-in folder on both April PCs.

### 6.3 Commands actually used (all records; nearly all April, two PCs)

**Count, then how many PCs used it.** Results overall: 2,564 success, 71 cancelled, 2 failed. 74 distinct command names.

1. **CEBLOCKS** 1,017 (2 PCs; 985 from PC-6 in Oct to Nov): the Manager's block library.
2. **C** 355 (2): structural shortcut.
3. **CD** 155 (2): civil pipe drawing; median 20.7 seconds per use; 14 not completed.
4. **LD** 133 (2): structural.
5. **STRETCH** 112 (2): the structural suite's wrapped stretch.
6. **PITEDIT** 74 (2): civil.
7. **CEMANAGER** 68 (3).
8. **CDEDIT** 67 (2): civil.
9. **PIPEEDIT** 66 (2): civil; 8 not completed.
10. **CDTAG** 64 (2): civil; 7 not completed.
11. **CE_VERSION** 63 (2).
12. **PIT** 45 (2): civil; median 28.6 seconds; 8 not completed.
13. **CDINSPECTOR** 42 (2): civil.
14. **PITSCHEDULE** 39 (2): civil; median 21.6 seconds.
15. **CE_STRUC_SUITE** 33, **Q** 32, **CEHEALTH** 29, **CLEAN** 26, **SSC** 21, **QD** 12.
16. **CDSYNC** 10, **CEMANAGERADMIN** 10, **DIV** 10, **CPB** 10 (copy-paste as block).
17. **CDIMPORTXCIVIL** 9 (1 PC), **RC** 9, **21H** 9, **CEMANAGERLOGS** 9, **CDREPAIR** 8.
18. **Then under 8 each:** CEMANAGERREFRESH, CESURVEYREVIEW, CDLPD (5), CDFALL (4), PFC, AD, 18B, CDREBUILD, CDDEBUG, 25C, LU, CR, PITDELETE, CESUPPORT, CEMANAGERUPDATES, TG (2), CETOOLS, 18T, CJSS, C1, CDHELP, DP (2), IO (2), DS.
19. **Civil total in the records: about 600 runs, all in April on two PCs, and 12 command names account for nearly all of it:** CD, PITEDIT, CDEDIT, PIPEEDIT, CDTAG, PIT, CDINSPECTOR, PITSCHEDULE, CDSYNC, CDIMPORTXCIVIL, CDREPAIR, CDLPD. Downpipe, inspection opening and trench grate commands were used 2 times each; the tool palettes and copy-paste did that work.
20. **Limit:** these records only count commands the plug-ins wrap. Plain AutoCAD commands, the loose LISP tools and palette drags are not recorded, so "most used" here means most used CE commands.

### 6.4 Most common failures (1,029 records)

1. **842 are "the previous session did not close cleanly"** (756 Manager, 66 Civil, 20 Structural). These are inferred at the next start-up, so they include AutoCAD being killed, a PC shut down, or a real crash; the record cannot tell which.
2. **94 "skipped faulty ribbon contributor"** (88 Structural, 6 Civil): the Manager could not get a module's ribbon panel and carried on without it.
3. **61 start-up errors:** "Manager startup failed" 32, "Background update or upload work failed" 29.
4. **25 ribbon errors:** "CE ribbon build or validation failed. Gave up after N attempts" (trigger: workspace changed 19, ribbon instance changed 4), "AutoCAD ribbon is not ready yet" 2.
5. **6 command errors:** "AutoCAD reported that SETVAR failed" 4, two window errors in the Manager.
6. **By month:** April 111, May 689, July 88, August 126, September 12, October 3. **By PC:** PC-2 941, PC-1 77, PC-3 11. Almost all are from this PC during development; colleagues' PCs contribute 88.

### 6.5 How the shared LISP files and palettes get onto a colleague's PC [EXPORT]

**Source:** seven AutoCAD "export settings" packages in the drafting utilities folder (AutoCAD 2022, 2025 and 2027; two people). One colleague's 2025 package and this PC's 2027 package were unpacked in the scratch folder and read. No profile (.arg) files, no office menu file and no written install instructions for LISP were found there; the instruction documents in that folder are from 2015 (plot styles location, batch plot settings, dimension style and layer screenshots) and were not opened.

1. **Mechanism = hand-made AutoCAD settings, then copied between versions with AutoCAD's own export / import settings tool.** There is no office installer for the LISP generation.
2. **Support search path** on the colleague's PC includes, by hand: the shared drafting "Lisp Files" folder (through that person's OneDrive sync), a sub-folder of it named for a person, a local folder `C:\Lisp Files`, and the bought-in structural toolkit's folders.
3. **Trusted locations** list the same four folders, so AutoCAD loads from them without a warning.
4. **Start-up suite** (the "load these every time" list in AutoCAD's load-application window) holds the LISP files one by one. The count stored is 17, and the entries seen point at a personal folder on the C: drive, an old lettered network drive, and `C:\Lisp Files` (pipe creation, the older pipe command, saw-cut / joint tool, copy-rotate, copy-paste-as-block, a text-style merger). So each PC loads its own private copies; a fix to a shared LISP file does not reach a PC that loads a private copy.
5. **No acaddoc.lsp or acad.lsp** exists in the shared LISP folder (18 LISP files, 6 dialog files, 382 button pictures, two linetype files). Nothing auto-loads the folder.
6. **Linetypes and hatch patterns:** the two office linetype files are read from the shared LISP folder; one hatch pattern file from the local `C:\Lisp Files`.
7. **Tool palettes:** the palette path is the PC's own local AutoCAD folder, and the package carries that PC's own palette catalogue files (14 of them, with names like CIVIL, FRAMING LABELS, BRACING, HATCH, SCHEDULES & NOTES, STEEL MEMBERS, SECTION TOOLS) and about 780 tool pictures. So palettes are imported once and then live locally; the shared "Tool Palettes" folder is a hand-out, not a live source. Each tool still points at the master drawing by full path (2.5).
8. **Plot style table:** a local copy in the PC's own plot styles folder, not read from the shared CTB folder. Different PCs can therefore plot with different versions of the table.
9. **Templates:** the template path is AutoCAD's default local folder; no office template is set for "new drawing". Jobs are started by copying the template drawing.
10. **Menus:** the stock AutoCAD menu plus the bought-in structural toolkit's menu; no office menu on the colleague's PC. This PC's 2027 package also carries the three CE menu files and the plug-in folders in its paths.
11. **A wart on this PC:** the trusted-locations setting lists the same Civil plug-in folder at least 15 times over (it is appended at each install).

---

## 7. Anything else found

1. **A real job sits in the template folder as "the" Bayside template** (2.1 item 2). Anyone starting from it inherits that job's pits, levels, background names and 94 extra layers.
2. **Design content lives in the background file** (tree zones, existing drain, footing hatches, bench mark box). A tool that reads only the job drawing will not see it.
3. **The site plan and the floor plan are two overlays of one file** (1.1). A change to the building means editing the floor band; a change to survey means editing the site band; the job drawing never changes.
4. **Viewport colour overrides are part of the house style** (3.2). Four layers print right only through a viewport carrying them.
5. **Pit state names are a ready-made vocabulary** of 16 pit kinds and sizes already in every drawing (3.1), and the schedule's typed size can disagree with it.
6. **Civil does draw earthworks** on a public building job: a cut and fill plan with named bench zones (4.8 item 6).
7. **Civil sheets carry pavement engineering on bigger jobs:** asphalt and concrete build-ups as coloured legend swatches with specification text and a design vehicle statement (4.8), car-park levels on a grid (4.4), kerb ramps, crossfall limits.
8. **Tender issues exist** on public jobs (P, then T, then A), using the tender stamp.
9. **Staged drawings exist** (childcare job: stage 1 and stage 2 plans on separate sheets).
10. **Council standard drawings are pasted onto the sheet as pictures** on outfall jobs (three on CIV-05), and one council has a whole library drawing of them (Kingston, 27 tiles).
11. **Proprietary products are named on the sheet** with "refer manufacturer specifications": modular detention tank, soakage modules, treatment device, litter baskets, strip drains, tank makes.
12. **A pipe capacity check does exist on one job** (Manning, one pipe, one line: 5.3). The principal's question "is anything calculated" has two answers: none on a plain house; one line where a pump and gravity flow share an outlet.
13. **A flat 1 m3 detention credit for tanks of 2,500 L and over** is written into one Kingston job's sums (5.2).
14. **The soakage sheet works out a 25-day emptying time and says nothing** (5.4).
15. **Two library drawings were re-saved on 10 Nov 2026 with "_PRE_C7_" backup copies beside them, and two long-section library blocks are named "CE_CPB_<date>_<time>"**: recent plug-in tools have been run on the shared library drawings. One library drawing holds 104 proxy objects.
16. **Sync conflict copies** (file name ending in a PC name) exist for a background file of JOB_A and for 15 superseded templates: two people edited the same drawing through OneDrive.
17. **The office calc header in CAD** (computation sheet drawing) is used for one-page sketches such as a rainwater head, separate from the Word-and-spreadsheet computations.

---

## Still unknown

1. **Sheets not looked at as pictures:** CIV-05 p1, CIV-06, CIV-08 p2, CIV-10 p2 and p3, CIV-11 p2 and p3, CIV-12 p1 and p2, CIV-14 p1 to p3, CIV-15 p2. **Why:** time; they were read from extracted text only, so their layout and symbols are not described.
2. **An apartment job and a school job.** **Why:** no folder named as apartments in 2023 to 2026; a school was not opened once a sports job was found.
3. **How horizontal-title civil sheets are started** (no horizontal civil template in the folder). **Why:** not shown in files.
4. **The council's own PSD / storage e-mail for CIV-09 and the architect's sustainability report.** **Why:** message file and a long report, not opened.
5. **Whether the 1 m3 tank credit and the 2% raingarden area are office rules or council rules.** **Why:** only the typed results are in the files.
6. **What Civil and Structural versions colleagues run today.** **Why:** since October only the Manager writes usage records; no machine record for Civil or Structural is newer than April.
7. **Whether PC-6 is a person or a test robot,** and which PCs belong to which colleague in the office. **Why:** names were deliberately not interpreted.
8. **Whether "did not close cleanly" records are crashes or ordinary shut-downs.** **Why:** the record is an inference made at next start-up.
9. **How often colleagues use plain AutoCAD commands, loose LISP tools and palettes.** **Why:** not recorded anywhere.
10. **The 2015 instruction documents and the other four settings packages** in the utilities folder. **Why:** not opened (old; and two packages were enough to see the mechanism).
11. **The start-up suite's full 17 entries on the colleague's PC.** **Why:** only the entries visible in the package text were read; the rest are stored in a form not decoded.
12. **Stretch values of each trench grate and the exact row count of each pit schedule block.** **Why:** the stored distances read as zero; the size is held in a per-insert copy that was not measured.
13. **Easement text standard and kerb-and-channel standard in a background file.** **Why:** none of the three jobs has one drawn the office way.
14. **Printed thickness of "default lineweight" objects, and whether every PC plots with the same plot style table.** **Why:** each PC holds a local copy of the table (6.5 item 8); only the shared one was decoded.
15. **Inside the BOROONDARA / MONASH / MORNINGTON orifice details, what differs council to council** (baffle, plate, sizes). **Why:** counted and titled only, not compared drawing by drawing.
16. **Tool palette "NEW" set tool-by-tool,** and whether colleagues have imported it. **Why:** only source drawings were counted.
