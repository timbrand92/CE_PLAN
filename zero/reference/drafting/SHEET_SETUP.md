# Sheet set-up: how a civil drawing file and its sheets are arranged today

What was measured in three finished jobs (JOB_A, JOB_B, JOB_C), the civil A1 template and the office master. Re-filed from the evidence on Mon 16 Nov 2026. Measured facts, not yet confirmed by the owner. Model units are millimetres of real ground.

## How to add to this file

1. Add a new numbered item at the END of the section it belongs to (never renumber existing items), or add a new section at the end of the file.
2. Give the measured value and say which coded job or office file it came from.
3. If a new measurement disagrees with one here, add it beside the old one under "Conflict:" and do not choose.
4. End every section with an "Evidence:" line.

## 1. Units and where the design sits

1. **Units:** Millimetres (INSUNITS 4, metric, decimal). One drawing unit = 1 mm of real ground on the plan.
2. **Coordinates:** Local, not map coordinates. No real-world easting / northing is used. The site is wherever the background lands inside the frame.
3. **Everything is in model space at full plan size:** plan, notes, legend, pit schedule, criteria box, warning boxes and details are all model-space objects laid out inside the frame as if model space were a giant A1 sheet 100 times bigger.
4. **"In the window" and "parked":** objects inside the frame print; objects outside it are parked copy-and-fill samples and never print. The template has 597 of its 620 model objects parked; a finished job still has 374 (JOB_A) to 423 (JOB_C) parked objects.

Evidence: STUDY_A section 0 and section 1 items 1 to 3, section 8 item 1.

## 2. Model space frame

1. **Frame block:** "Drawing Border" (two polylines on DEFPOINTS, 795 x 567) inserted at scale 100 on layer BLOCKS. It does not plot (see E-055).
2. **Sheet 1 position:** X 106,313 to 185,813 and Y -209,927 to -153,227 (79,500 x 56,700), the same in all three jobs and in the template.
3. **Sheet number text:** 5000 high, on DEFPOINTS, above the frame ("C01").
4. **Second sheet:** a second "Drawing Border" exactly 100,000 to the right (X 206,313). The template already has two frames and two layouts (C01, C02). JOB_A uses it.

Evidence: STUDY_A section 1 items 2, 4 and 5.

## 3. Layouts (paper space)

1. **One layout per sheet,** named C01 (and C02).
2. **Page set-up:** name "A1 PDF"; paper "ISO full bleed A1 (594 x 841)"; landscape; plot scale 1:1; plot style table "Creative Engineering.ctb"; colour-dependent plot styles.
3. **Plot device:** "DWG To PDF.pc3" on the jobs; the template itself says "AutoCAD PDF (High Quality Print).pc3".
4. **What lives in paper space:** only the title block (one block "R- TITLE SHEET" at 0,0 scale 1) plus loose texts for the drawing title, the scale line, the revision letter and the revision rows. Nothing else.
5. **Conflict:** the first Stage 1 note says the layout is "named A1 PDF"; the later measured study says the layouts are named C01 / C02 and "A1 PDF" is the page set-up name. Not settled by a decision.

Evidence: STUDY_A section 1 items 6 and 8; ELEMENT_LIST "The sheet" item 1.

## 4. Viewport

1. **Exactly ONE working viewport per layout:** 795 x 567 on paper, on layer DEFPOINTS (so its edge never prints), scale 1:100, locked, no layers frozen in it, not clipped.
2. **View centre:** (146,063, -181,577) for sheet 1 and (246,063, -181,577) for sheet 2.

Evidence: STUDY_A section 1 item 7.

## 5. Scales, and how details are drawn at 5 times

1. **Plan scale:** 1:100. The title block scale line reads "1:100, 1:20".
2. **No 1:20 viewport exists.** Details are drawn FIVE TIMES real size in model space and seen through the same 1:100 viewport.
3. **Detail dimensions are typed over by hand:** a dimension that measures 750 carries the typed text "150"; measured 2250 carries "450". In the standard pit detail block ("PIT 900 MAX") all 4 dimensions are typed over, ratio 5.0.
4. **Pasted details carry other ratios** (2.15, 2.55 measured), i.e. they were scaled to fit.
5. **"T-- DOT LEADER"** (overall scale 20, arrow 1.5, dot arrowheads) exists in the master only and is its current style, which suggests it is meant for 1:20 details; the three jobs' details use the scale-100 styles with typed-over text. Whether it is really used: Unknown.

Evidence: STUDY_A section 1 item 9, section 4 item 3, section 10 item 13.

## 6. Part plans and key plan (a site too big for one view)

1. **Part plans (JOB_A):** the one background file is attached THREE times side by side in model space, each clipped to a different 6-point polygon, each with its own title "PART PLAN n / SCALE 1 : 100". Match lines are drawn by hand.
2. **1:500 key plan (JOB_A):** a block containing the same background reference inserted at scale 0.2, placed inside the 1:100 frame.
3. **How many sheets:** one when it fits; plan plus a details-and-notes sheet when it does not (JOB_A: two sheets). Outfall, basement and industrial jobs add sheets (C02 seen; CIV-10 has three civil sheets).

Evidence: STUDY_A section 1 items 10 and 11; ELEMENT_LIST "Across three civil jobs" item 3 and moving parts 4 and 5; STUDY_B section 1e item 5, 1k item 5, 1l item 1.

## 7. Annotation and linetype scaling

1. **Nothing is annotative.** No object in any of the three jobs carries annotative data.
2. **Text height:** fixed model-space height = paper height x 100 (2.5 mm on paper = 250 in model).
3. **DIMSCALE 100. CANNOSCALE 1:1.**
4. **LTSCALE 1000, PSLTSCALE 0, MSLTSCALE 0, CELTSCALE 1.**
5. **Linetype definitions are the small imperial ones** (DASHED = 0.5 dash, 0.25 gap), so on the plan a DASHED pipe has a 500 dash and 250 gap = 5 mm and 2.5 mm on paper.
6. **Lettered service linetypes** are about 30 times bigger, so objects on them carry an object linetype scale of 0.1 (2.0 for gas). See `standards\linetypes.csv`.

Evidence: STUDY_A section 1 items 12 and 13, section 5.

## 8. Background (architect / survey) attachment

1. **Pattern:** the office first makes its own cleaned background drawing, saved as `.\Xref\Xref_<job>.dwg` beside the job drawing (relative path). The job drawing attaches that ONE file.
2. **How many:** JOB_B and JOB_C attach it twice under two reference names, "Xref_<job>_Site" and "Xref_<job>_Ground", inserted 50,000 apart in Y, each clipped to a rectangle (the cleaned file holds the site plan and the ground floor plan one above the other). JOB_A attaches it under one name, three times, each clipped to a polygon.
3. **Layer and scale:** inserted on layer XREF, scale 1, rotation 0.
4. **Fading:** not done by reference fading or by layer overrides in the job. The grey look comes from the layer colours INSIDE the cleaned background file plus the plot style table: architecture on "A-ARCH BACKGROUND" (colour 11 = black at 70% screen, 0.09 pen), windows / doors / steps on colour 9 (black, 40% screen, 0.10 pen), walls on colour 47, roof outline on colour 55, survey on 253, driveway on 254.
5. **Layer keeping:** VISRETAIN is 1. Only 2 reference layers are frozen in JOB_C and none in JOB_A. 10 reference layers in JOB_A carry a transparency value.
6. **Layer count:** each attachment brings its own copy of the background's layers: 81 per attachment in JOB_C (162 of the 313 layers in that file), 34 in JOB_A.
7. **What is in the background file:** title boundary with bearings and lengths, street name, bench mark box, survey levels, contours, neighbours, the architect's building. Layer names seen: A-TITLE BOUNDARY (colour 2, DASHDOT2), BOUNDARY, EASEMENT (colour 6, DASHED), A-SURVEY, CONTOURS, TPZ, TREE, SEWER, G-ANNO-TEXT. The file itself was not opened: Unknown (Q-101).
8. **The background template** is a near-empty drawing with the office layers (105) and a small block of text and lines (28 texts, 27 lines), millimetres, no layout content.
9. **Other attachments:** JOB_C holds two PDF underlays inside detail blocks (water tank installation diagrams, pointing at the Standard Details\Civil folder by relative path) and the office logo image inside the title block.
10. **Leftovers from bound references:** layers "$0$A-ARCH BACKGROUND" to "$4$..." in JOB_B; text styles "x-sheet$0$..." in the title block; an architect's tree block.
11. **Clip rectangles in sheet terms and whether clip frames are shown:** Unknown.

Evidence: STUDY_A section 1 items 14 and 15, section 8 item 10, section 10 items 1 and 7.

## 9. Plot style table and colour

1. **Printed thickness comes from the colour** through the plot style table, not from the layer lineweight. Every layer has lineweight "Default" except TREE (0.00) and TREE EXISTING (0.20).
2. **Every layer plots** except DEFPOINTS, GUIDELINES and HATCHOUTLINE.
3. **Colours 1 to 9, 11, 21, 41, 61, 130, 131, 171, 250 print black or grey.** Almost every other colour prints in colour. That is why the sheet says "print in full colour". Full list: `standards\pen_colours.csv`.
4. **Colour carries meaning on the issued sheet:** new drain pipes blue dashed, charged pipes red dashed, suspended pipes magenta, building footprint light blue, driveway slab grey, tree zones green hatch, architect's background grey. The older study adds: rising main green, agricultural drain black.
5. **Conflict (colour 4 pen):** 0.40 in the current table against 0.70 in the older "A1 Residential Structures.ctb" (so the "70" layers do not print at 0.70 with the current table). Not settled by a decision.
6. **Conflict (copies of the table):** the same three or four plot style file names are kept in three places with different dates for the same name. Whether the table used on the day matched the decoded file: Unknown.
7. **Unknown:** why note boxes on HATCH 51 (colour 250) print yellow and the driveway on HATCH 21 (colour 49) prints grey when the decoded table says otherwise; the printed thickness of "object lineweight" colours (Q-103).

Evidence: STUDY_A section 2 "Lineweight and plot" and "What the plot style table does", section 10 items 3 to 5; ELEMENT_LIST "Seen as a picture" item 2; DIGEST section 1 item 9; STUDY_C section 2D item 8.

## 10. Draw order and masks

1. **Draw order** is controlled per block and in model space with draw-order tables (146 such tables in JOB_C), used with wipeouts and text masks so labels cover lines.
2. **Wipeout frames are switched on** in the drawing (the pit tag circle is a wipeout whose frame prints).
3. **Which is on top** of pipe polyline, multiline and label was not decoded. On paper the label mask covers the pipe and the walls sit over the band. Unknown beyond that (Q-103).

Evidence: STUDY_A section 1 item 16, section 6 item 12, section 10 item 8.

## 11. Text, dimension and leader styles

1. **One text style does everything:** "STANDARD" = Arial Narrow (ARIALN.TTF), width factor 1.0, no oblique, height 0 (set per text). Other styles present but unused or stray: "ISO"; three "x-sheet$0$..." styles inside the title block; one stray style on Simplex.shx in the master.
2. **Conflict:** the first Stage 1 note says "two main text styles"; the measured study says one text style does everything. Not settled by a decision.
3. **Dimension styles in every job:** "STANDARD", "STANDARD$7", "R- DIMSTYLE", "T-- LEADER" (two of these names carry a staff first name or initials and are written masked, as in the evidence). STANDARD, R- DIMSTYLE and T-- LEADER are the same: overall scale 100, arrow size 3 (300 in model), text height 2.5 (250), extension offset 1, extension beyond 1, text gap 1, text above the line, aligned with the line, decimals 0, text style STANDARD, default closed filled arrowhead, all colours ByLayer. Units decimal, whole millimetres, no suffix.
4. **Leaders are the old LEADER object, never the multileader,** and are never attached to their text.
5. **Multiline styles (pipe walls):** CLOSED-ENDS (two lines at +0.5 and -0.5, capped ends; the current style in the jobs), STANDARD and STANDARD1 (same two lines, open ends), CLOSED. Scale = pipe diameter.
6. **Heights:** see `standards\text_heights.csv`.

Evidence: STUDY_A sections 3 and 4, section 5 item 12; ELEMENT_LIST "House standards" items 3 and 4.

## 12. Where the sheet's parts sit (reading path)

1. Warning notes across the top.
2. Plan upper-left / centre, about half the sheet.
3. Pit schedule and detention criteria directly below or beside the downstream end.
4. Job details in a lower band; long section lower-centre when present.
5. Full legend and general notes in a right strip.
6. Council notes, charged-system notes and a tank installation picture bottom-right beside the title block.
7. Title and revisions at the outer edge; the approval stamp box above the title block.
8. Sparse sheets are fine: details are chosen for the job, not to fill space. All 30 jobs of the August study followed this grammar.

Evidence: DIGEST section 1 items 1 and 13; ELEMENT_LIST "Seen as a picture" item 1; MODEL_NOTES "What it teaches" item 9.

## 13. Templates and the master

1. **The jobs come from the civil A1 template** ("CE_A1_C01 - VERTICAL"), not directly from the master. The same parked kit is in all three jobs (same coordinates, same wording).
2. **The master** ("typical blocks, layers, schedules and notes") is a parts store, not a sheet: saved in model space with headings 1000+ high ("SCHEDULES", "HATCHES", "CIVIL", "LEGEND", "NOTES & SHADOW BOXES", "SECTIONS", "LAYERS", "TEXT", "COPY FROM HERE", "WORK IN PROGRESS"...). One A4 layout named "LOOK LEFT AND CLICK". Its current dimension style is the 1:20 dot leader.
3. **The details file** is likewise a parts store: 96 named blocks (42 machine-named) under big headings by topic and by council; several headings are old job addresses, i.e. examples kept as masters.
4. **One file serves civil and structural:** about 60 structural layers sit in every civil job, used only by the layer-legend block.
5. **Master and template disagree:** master 189 layers, template 149; 33 template layers are not in the master; 73 master layers are not in the template; 17 layers have the same name but different colour or linetype. See `standards\layers.csv`.
6. **JOB_A/B look like they were started from an older copy of the template than JOB_C** (about 18 to 25 extra layers against 5).
7. **Not covered yet:** A3 templates, the council-specific A1 template, long-section examples, the other civil detail drawings (Q-102); whether tool palettes are the real source of the blocks.

Evidence: STUDY_A section 2 "Standard versus invented", section 8 items 1 and 2, section 9, section 10 items 10 and 12.

## 14. Data left in the drawings by add-ons and other tools (noted only, not analysed)

1. **Registered application names in every job,** with no objects using most of them: "StrucPlus", "RAK", "DCO15", "GeoCivilGIN", "GeoCivilFeature", "CHIEFARC-LNWT", "AcAecLayerStandard", "AEC_XDATA_BOUND_SPACE", "ACET-TEXTMASK", "AdeskUnderlayLayerOverrideData".
2. **Named dictionaries** from AutoCAD Architecture-type products ("AcAec", "AEC_DISP_REP...", "AEC_PROPERTY_SET_DEFS", "AEC_VARS") and "BNS_VARIABLES", "ASE_INDEX_DICTIONARY".
3. **Extended data actually on plotted objects:** "AECGUIBASE" on the background inserts only; AutoCAD's own on MTEXT (mask), leaders and dimensions (style overrides), hatches (gradient colours), dynamic block parts.
4. **Extension dictionaries on objects:** only AutoCAD's own (dynamic block data on 51 inserts, the clip boundary on the background inserts, scale data on the viewport).
5. **Files beside the templates written by other tools:** checklist, job-time cache and inspection files, a job-time log, and detail drawings saved as dated "PRE" copies. Noted, not opened.
6. **Machine-named blocks:** 43 to 46 block definitions per job have names AutoCAD gives a block pasted from another drawing; the template already has 57 and the master 279. Dynamic block copies: 60 to 70 anonymous copies per job.
7. **Groups:** none. **Tables:** none. **Multileaders:** none. **Annotative objects:** none. **Fields:** only the title block's two.

Evidence: STUDY_A section 8 items 3, 4, 11 and 12.
