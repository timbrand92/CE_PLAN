# Civil drafting anatomy: how the office physically draws a stormwater and pavement sheet

**Made:** Mon 16 Nov 2026, read-only study. **Status:** measured facts from files, not yet confirmed by the principal. Nothing here is a decision.

**Privacy:** jobs are JOB_A, JOB_B, JOB_C. No client, street, job number or staff name is recorded. Two style names and one block name in the drawings contain a staff first name or initials; they are written here as "T-- LEADER", "T-- DOT LEADER", "R- DIMSTYLE" and "R- TITLE SHEET". The exact spellings are in the raw dumps.

**Raw dumps (local only, they DO contain client text, never copy them to a repository):** `C:\CE_WORK\scratch\zero_study\A_drafting\_raw_local_only\`. Converted copies of office templates: `...\A_drafting\conv\`. Scripts: `...\A_drafting\*.py`.

## 0. Sources and how each is cited

1. **[JOB_A], [JOB_B], [JOB_C]** = `C:\CE_WORK\realjobs\JOB_x\work.dxf` (text export of the finished job drawing).
2. **[PDF_C]** = the issued sheet of JOB_C seen as a picture (`zero_see\JOB_C\png\p1_r1_c1.png`). Only this one tile was looked at in this study; the earlier Stage 1 notes cover the rest of the pictures.
3. **[MASTER]** = `CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dxf` (the office master of blocks, layers, schedules and notes).
4. **[A1CIVIL]** = `A1 Templates\CE_A1_C01 - VERTICAL.dwg`, converted to DXF on a copy. This is the civil sheet template the three jobs were clearly started from.
5. **[XREFTMPL]** = `Xref Templates\X2----.dwg`, converted on a copy.
6. **[DETAILS]** = `Standard Details\Civil\CE Civil Details.dwg`, converted on a copy. **[COMP]** = `CE Computation Sheet.dwg`, converted on a copy.
7. **[CTB]** = `CTB Files\Creative Engineering.ctb`, decoded (it is a zlib-compressed text file; decoding worked). `A1 Residential Structures.ctb` was decoded for comparison.

**What "in the window" means below:** every sheet is a 79,500 x 56,700 rectangle of model space seen through one viewport. Objects inside that rectangle print. Objects outside it are "parked" and never print.

---

## 1. Drawing set-up

1. **Units.** Millimetres (INSUNITS 4, metric, decimal). One drawing unit = 1 mm of real ground on the plan. [JOB_A/B/C, MASTER, A1CIVIL]
2. **Where the design sits.** Local coordinates, not map coordinates. Sheet 1 always occupies model space X 106,313 to 185,813 and Y -209,927 to -153,227 in all three jobs and in the template. The site is wherever the background lands inside that frame. No real-world easting/northing is used. [JOB_A/B/C, A1CIVIL]
3. **The whole sheet is built in model space at full plan size.** Plan, notes, legend, pit schedule, criteria box, warning boxes and details are all model-space objects laid out inside the frame as if model space were a giant A1 sheet 100 times bigger. [JOB_A/B/C]
4. **The frame.** A block named "Drawing Border" (two polylines on DEFPOINTS, 795 x 567) inserted at scale 100 on layer BLOCKS. It does not plot; it only shows the drafter where the sheet edge is. Above it sits a 5000-high text on DEFPOINTS with the sheet number ("C01") so the sheet can be found when zoomed out. [JOB_A/B/C, A1CIVIL]
5. **Second sheet.** The next sheet is a second "Drawing Border" exactly 100,000 to the right (X 206,313). JOB_A uses it for its second sheet. The template already has two frames and two layouts (C01, C02). [JOB_A, A1CIVIL]
6. **Layouts (paper space).** One layout per sheet, named C01 (and C02). Page set-up name "A1 PDF", plot device "DWG To PDF.pc3" (the template itself says "AutoCAD PDF (High Quality Print).pc3"), paper "ISO full bleed A1 (594 x 841)", landscape, plot scale 1:1, plot style table "Creative Engineering.ctb", colour-dependent plot styles. [JOB_A/B/C, A1CIVIL]
7. **Viewport.** Exactly ONE working viewport per layout: 795 x 567 on paper, on layer DEFPOINTS (so its edge never prints), scale 1:100, **locked**, no layers frozen in it, not clipped. Its view centre is (146,063, -181,577) for sheet 1 and (246,063, -181,577) for sheet 2. [JOB_A/B/C, A1CIVIL]
8. **What lives in paper space.** Only the title block: one block "R- TITLE SHEET" at 0,0 scale 1, plus loose texts for the drawing title, the scale line, the revision letter and the revision rows (see 6.38 to 6.40). Nothing else. [JOB_A/B/C]
9. **How 1:100 plan and 1:20 details share one sheet.** There is no 1:20 viewport. Details are drawn FIVE TIMES real size in model space and seen through the same 1:100 viewport. Their dimensions are then typed over by hand: e.g. a dimension that measures 750 carries the typed text "150"; measured 2250 carries "450". In the standard pit detail block all 4 dimensions are typed over, ratio 5.0. Details pasted from other sources carry other ratios (2.15, 2.55 measured), i.e. they were scaled to fit. [JOB_C, block "PIT 900 MAX" and two machine-named detail blocks]
10. **1:500 key plan (JOB_A).** A block containing the same background reference inserted at scale 0.2, placed inside the 1:100 frame. Same trick in the other direction. [JOB_A]
11. **Part plans (JOB_A).** The one background file is attached THREE times side by side in model space, each clipped to a different 6-point polygon, each with its own title "PART PLAN n / SCALE 1 : 100". Match lines are drawn by hand. [JOB_A]
12. **Annotation scaling.** Nothing is annotative. No object in any of the three jobs carries annotative data. All text is fixed model-space height = paper height x 100 (2.5 mm on paper = 250 in model). DIMSCALE 100. CANNOSCALE 1:1. [JOB_A/B/C]
13. **Linetype scaling.** LTSCALE 1000, PSLTSCALE 0, MSLTSCALE 0, CELTSCALE 1. The linetype definitions are the small imperial ones (DASHED = 0.5 dash, 0.25 gap), so on the plan a DASHED pipe has a 500 dash and 250 gap = 5 mm and 2.5 mm on paper. [JOB_A/B/C, MASTER]
14. **Background (architect / survey) attachment.**
    1. **Pattern.** The office first makes its own cleaned background drawing, saved as `.\Xref\Xref_<job>.dwg` beside the job drawing (relative path). The job drawing attaches that ONE file. [JOB_A/B/C]
    2. **How many.** JOB_B and JOB_C attach it twice under two reference names, "Xref_<job>_Site" and "Xref_<job>_Ground", inserted 50,000 apart in Y, each clipped to a rectangle (the cleaned file holds the site plan and the ground floor plan one above the other). JOB_A attaches it under one name, three times, each clipped to a polygon. [JOB_A/B/C]
    3. **Layer and scale.** Inserted on layer XREF, scale 1, rotation 0. [JOB_A/B/C]
    4. **Fading.** Not done by reference fading or by layer overrides in the job. The grey look comes from the layer colours INSIDE the cleaned background file plus the plot style table: architecture sits on "A-ARCH BACKGROUND" (colour 11 = prints black at 70% screen, 0.09 pen), windows/doors/steps on colour 9 (black, 40% screen, 0.10 pen), walls on colour 47, roof outline on colour 55, survey on 253, driveway on 254. VISRETAIN is 1 (layer changes made in the job would be kept), but only 2 reference layers are frozen in JOB_C and none in JOB_A. 10 reference layers in JOB_A carry a transparency value. [JOB_A, JOB_C, CTB]
    5. **Layer count.** Each attachment brings its own copy of the background's layers: 81 per attachment in JOB_C (162 of the 313 layers in that file), 34 in JOB_A. [JOB_A, JOB_C]
    6. **What is in the background file.** Title boundary with bearings and lengths, street name, bench mark box, survey levels, contours, neighbours, the architect's building. These print on the sheet [PDF_C] but are NOT in the job drawing, so they come through the reference. Layer names seen: A-TITLE BOUNDARY (colour 2, DASHDOT2), BOUNDARY, EASEMENT (colour 6, DASHED), A-SURVEY, CONTOURS, TPZ, TREE, SEWER, G-ANNO-TEXT. The background file itself was not available to open (see section 10).
    7. **The background template [XREFTMPL]** is a near-empty drawing with the office layers (105) and a small block of text and lines (28 texts, 27 lines), millimetres, no layout content.
15. **Other attachments.** JOB_C holds two PDF underlays inside detail blocks (water tank installation diagrams, pointing at the Standard Details\Civil folder by relative path) and the office logo image inside the title block. [JOB_C]
16. **Draw order.** Controlled per block and in model space with draw-order tables (146 such tables in JOB_C). Used with wipeouts and text masks so labels cover lines. [JOB_C]

---

## 2. Layers

**Naming scheme (three families).** [MASTER, A1CIVIL, JOB_A/B/C]

1. **Pen-and-kind layers:** a number that was once the pen width, then the kind: 18CONT, 18HIDDEN, 18HIDDEN2, 18TEXT, 20TEXT, 25CONT, 25DIMS, 25HIDDEN, 25TEXT, 35CONT, 35TEXT, 50CONT, 50TEXT, 70CONT, 70DASHED, 70HIDDEN, 9CONT. Colour picks the pen: 18 = colour 6, 20 = colour 10, 25 = colour 7, 35 = colour 2, 50 = colour 3, 70 = colour 4, 9 = colour 9.
2. **Thing layers:** named for what is drawn: STORMWATER PIPE, STORMWATER PIT, DOWNPIPES, SEWER, TPZ, FLOOR LEVEL, and so on.
3. **Hatch-by-colour layers:** "HATCH nn" where nn was the colour number (HATCH 11, HATCH 21, HATCH 51, HATCH 141...), some with a purpose added ("HATCH 74 - BANDBEAM").
4. **Sheet layers:** prefixed "0-" for the title block (0-TITLE, 0-TITLE BLOCK, 0-TITLE TEXT, 0-TITLE REVISION, 0-SCALE BAR, 0-NORTH, 0-STAMP-PRELIMINARY, 0-STAMP-TENDER, 0-STAMP-APPROVAL, 0-STAMP-CONSTRUCTION).

**Lineweight and plot.** Every layer has lineweight "Default" except TREE (0.00) and TREE EXISTING (0.20). Printed thickness comes from the colour through the plot style table, not from the layer lineweight. Every layer plots except DEFPOINTS, GUIDELINES and HATCHOUTLINE. [A1CIVIL, JOB_C]

**What the plot style table does with each colour [CTB].** (Pen width in mm; "own colour" means it prints in colour.)

1. **Colour 1:** black, 0.18.
2. **Colour 2:** black, 0.35.
3. **Colour 3:** black, 0.50.
4. **Colour 4:** black, 0.40 (the "70" layers do not print at 0.70 with this table; the older "A1 Residential Structures.ctb" has colour 4 at 0.70 and colour 1 at 0.25).
5. **Colour 5:** black, 1.00.
6. **Colour 6:** black, 0.13 (the "18" layers print at 0.13).
7. **Colour 7:** black, 0.25.
8. **Colour 8:** black, 0.10.
9. **Colour 9:** black screened to 40%, 0.10 (prints light grey).
10. **Colour 10:** own colour (red), 0.18, 90% screen.
11. **Colour 11:** black screened to 70%, 0.09.
12. **Colour 150:** own colour (blue), 0.25.
13. **Colour 211:** own colour (magenta), object lineweight.
14. **Colour 250:** black at 25% screen, 0.15 (light grey fill). **251:** own colour 45%, 0.15. **252:** own colour 90%, 0.15. **253:** own colour, 0.18.
15. **Colours 21, 41, 61, 171:** black, screened to 20%, 10%, 50%, 80%.
16. **Colours 14, 49, 74, 138, 141, 201, 242:** own colour screened to 20-25% (pale tints for fills). **34:** own colour 30%. **47:** own colour 80%, 0.10. **73:** own colour 20%, 0.10.
17. **Everything else (187 of 255 colours):** own colour, object lineweight, 100%.
18. **Meaning:** colours 1 to 9, 11, 21, 41, 61, 130, 131, 171, 250 print black or grey. Almost every other colour prints in colour. That is why the sheet says "print in full colour".

**Civil layers, with colour / linetype and what is on them** (values from [JOB_C] and [A1CIVIL]; "in blocks" = only used inside block definitions).

1. **STORMWATER PIPE** - colour 150 (prints blue), DASHED. The fat centre polyline of every new gravity pipe.
2. **STORMWATER CHARGED PIPE** - colour 10 (prints red), DASHED. The fat centre polyline of every charged pipe (roof to tank).
3. **STORMWATER SUSPENDED PIPE** - colour 211 (prints magenta), DASHED. Suspended pipes. Only used inside the legend in these three jobs.
4. **STORMWATER PIPE CHARGED TO RAINGARDEN** - in the template only; not used on the three jobs.
5. **STORMWATER RISING MAIN** - in [MASTER] only.
6. **DRAINAGE** - colour 6 (black 0.13), continuous. The double-line multiline that draws the two pipe walls over every pipe. Also the box round the detention criteria.
7. **DRAINAGE UNDER SLAB** - colour 6, HIDDEN. In blocks only.
8. **EX STORMWATER** - colour 9 (grey), HIDDEN. Walls (multiline) and stub lines of existing drains.
9. **EX DRAIN HATCH** - colour 61 (black 50% screen), PHANTOM. The fat centre polyline of an existing drain (width 225 on JOB_C, object linetype scale 0.4).
10. **EX PIT** - colour 9. Existing pit drawn as loose lines (a 450 square with a cross, and a 675 dashed outer square).
11. **EXISTING DRAIN** - colour 2. In blocks only.
12. **STORMWATER** - colour 9. The layer that pit blocks, pit tags, small symbol blocks and the top warning boxes are INSERTED on. The layer itself draws nothing visible; the block contents are on their own layers.
13. **STORMWATER PIT** - colour 2 (black 0.35). Inside the pit block: the cross lines (forced to colour 9) and the masks.
14. **PITS HIDDEN** - colour 7, HIDDEN. Inside the pit block: the pit outline.
15. **GRATED TRENCH** - colour 9. Inside the pit block: the grate hatch. Also legend lines.
16. **TRENCH GRATE** - colour 9. Trench grate block and its hatch.
17. **DOWNPIPES** - colour 2. Downpipe / overflow / inspection opening circles. **DOWNPIPES HATCH** - colour 10 (red): the solid fill of the circle. **DOWNPIPE TXT** - colour 7: the "DP" attribute.
18. **FLOOR WASTE** - colour 7. Floor waste circle and honeycomb hatch.
19. **SPOON DRAIN** - colour 10 in jobs and template (colour 1 in [MASTER]). Spoon drain multiline and "SD" label.
20. **AGI DRAIN** - colour 2, linetype AG_LINE. Agricultural drain as plain lines (8 lines in JOB_A).
21. **OVERLAND FLOW** - colour 34 (own colour at 30%). Overland flow arrow block and its label.
22. **FLOOR LEVEL** - colour 7. "FFL" texts.
23. **PAVEMENT LEVELS** - colour 7. Legend only on these jobs.
24. **20TEXT** - colour 10 (red). Invert levels on JOB_C; the level attribute of the finished-ground-level block.
25. **18TEXT** - colour 6. Invert levels on JOB_A and JOB_B (each forced to colour 1); small "FLOW" and placeholder texts.
26. **25TEXT** - colour 7. All ordinary notes, pipe labels, cover levels, schedule cell text.
27. **35TEXT** - colour 2. Dwelling / garage names, pit tag attribute, schedule headings.
28. **50TEXT** - colour 3. Big headings inside blocks (500 high).
29. **TEXT TITLE** - colour 4. The plan title and scale line.
30. **25DIMS** - colour 7. Every leader (flow arrows, pointer leaders), every dimension, and some blocks.
31. **25CONT / 35CONT / 50CONT / 70CONT / 18CONT** - general line work. 50CONT carries the building outline (polyline, global width 70). 35CONT carries the note "shadow box" frames (width 150).
32. **SAWCUT** - colour 2, DASHDOT2. Saw cut lines (plain lines) and the saw-cut tag block.
33. **CONSTRUCTION JOINT** - colour 3, PHANTOM_CJ in JOB_C and the template (CENTER2 in JOB_A and JOB_B, PHANTOM in [MASTER]).
34. **SLAB CJ, SLAB SC, SLAB PERIMETER, SLAB STEP, 25TEXT - JOINT TEXT** - pavement joint content, mostly inside blocks.
35. **HATCH 21** - colour 49 in the jobs (21 in the template): solid fill of the driveway slab (prints pale grey on [PDF_C]). **HATCH 141** - colour 149 in JOB_C: solid fill of the building footprint (prints light blue). **HATCH 51** - colour 250: fill of note boxes (prints yellow on [PDF_C]; see section 10). **HATCH 11** - colour 11: earth and concrete patterns in details; also the green heading text of the criteria box (forced to colour 3). **HATCH WATER** - colour 150: tank fill. **HATCH EARTH** - colour 11.
36. **HATCHOUTLINE** - colour 215, does not plot. Boundary polylines of hatches.
37. **BATTER** - colour 253. Batter lines and fills.
38. **RETAINING WALL / SLEEPER RETAINING WALL** - colour 1. Wall as a fat polyline plus multiline.
39. **TPZ** - colour 2, HIDDEN. Tree protection zone arcs/lines and the "TPZ" / "SRZ" texts (SRZ forced to colour 233). **TREE** - colour 65 (73 in JOB_A/B). **TREE EXISTING** - colour 53.
40. **SEWER** - colour 9, linetype SEWER. **WATER** - colour 9, WATER. **GAS** - colour 9, GAS_LINE. **TELSTRA** - colour 9, TELSTRA. **ELEC OVERHEAD** - colour 251, ELECTRICITY. Existing services as plain lines with an object linetype scale (0.1, or 2.0 for gas).
41. **BYDA** - colour 7. The "before you dig" block.
42. **KERB & CHANNEL** - colour 7. Legend only.
43. **BOUNDARY** (colour 2, DASHDOT), **EASEMENT** (colour 6, DASHED), **FENCE** (11), **DRIVEWAY** (254), **SURVEY** (253), **LANDSCAPING**, **WALLS...**: exist in the job file but are empty there; this content arrives through the background reference.
44. **SCHEDULE** - colour 7. The ruled lines of the pit schedule block.
45. **Section Marks, Section Scale, SECTION TAG** - section mark and detail title blocks.
46. **BLOCKS** - colour 7. The catch-all layer that detail blocks, note blocks, the legend, the schedule and the border are inserted on.
47. **XREF** - colour 7. Background attachments.
48. **WIPEOUT** - colour 255, DOT. Masks.
49. **GUIDELINES** - colour 75, no plot. Helper geometry inside blocks. **DEFPOINTS** - colour 129, no plot.
50. **CLOUD** - colour 10 (12 in [MASTER]). Revision clouds. Empty in these jobs.

**Standard versus invented.**

1. **[MASTER] has 189 layers; [A1CIVIL] has 149.** 33 template layers are NOT in the master (all the "0-" sheet layers, FLOOR LEVEL, PAVEMENT LEVELS, OVERLAND FLOW, SAWCUT, DOWNPIPE TXT, KERB & CHANNEL, STORMWATER SUSPENDED PIPE, STORMWATER PIPE CHARGED TO RAINGARDEN, DRAINAGE UNDER SLAB, SLAB CJ, Section Marks, Section Scale, TEXT TITLE and others). 73 master layers are not in the civil template (mostly structural).
2. **17 layers have the same name but different colour or linetype in master and template** (e.g. SPOON DRAIN 1 vs 10, DEFPOINTS 5 vs 129, CONSTRUCTION JOINT PHANTOM vs PHANTOM_CJ, WIPEOUT DOTX2 vs DOT, TREE 73 vs 65).
3. **Layers on a job that are in neither standard:** JOB_A and JOB_B: 25CENTER2 (A only), AREA OF INTEREST HATCH, BATTER SYMBOL, CONCRETE HATCH, HATCH 14, HATCH 240, HATCH DECK, LOADBEARING, WALL BLOCK, WALLS EXISTING HATCH, WATER TANK (A only), DOWN PIPES (B only, a second spelling of DOWNPIPES), five "$n$A-ARCH BACKGROUND" layers (B only: left behind when a reference was bound and pasted). All three: RED, GREEN, BEAMS, TITLEBLOCKTEXT2, "Layer 1", "c-signs". These arrive with pasted blocks.
4. **One file serves civil and structural.** About 60 structural layers (BEAM, RAFTERS, JOISTS, BRACING, STRIP FOOTINGS...) sit in every civil job, used only by the layer-legend block.

---

## 3. Text

1. **One text style does everything.** "STANDARD" = Arial Narrow (ARIALN.TTF), width factor 1.0, no oblique, height 0 (height set per text). [JOB_A/B/C, MASTER, A1CIVIL]
2. **Other styles present.** "ISO" (same font, unused). Three "x-sheet$0$..." styles (Arial Narrow and Arial) used only by labels inside the title block; they came from a bound reference. The master has one stray style on Simplex.shx. [JOB_C, MASTER]
3. **Heights actually used (model units; divide by 100 for mm on paper).** [JOB_A/B/C]
    1. **Pipe label:** 250. MTEXT, layer 25TEXT.
    2. **Invert level:** 180. Layer 20TEXT (JOB_C) or 18TEXT with colour 1 (JOB_A, JOB_B).
    3. **Pit cover level and "PP" plastic pit tag:** 200. MTEXT, layer 25TEXT.
    4. **Pit tag (P1, P2):** 350, attribute on 35TEXT ("SPS" placeholder is 300).
    5. **Downpipe tag "DP":** 250. **IO / FW / OF / F/A / T/B:** 250. **GIO / GSP / GOF:** 200.
    6. **Finished ground level (FGL) block attribute:** 200. **Fall arrow text:** 200.
    7. **Floor level:** 250, underlined.
    8. **Dwelling / garage names:** 350, plain TEXT on 35TEXT, justified Middle.
    9. **General notes and leaders' notes:** 250.
    10. **Pit schedule:** cell text 250; column headings 250 (on 35TEXT); table title 500; the small note 180.
    11. **Criteria box:** heading 350, body 250.
    12. **Plan title:** 700 (one MTEXT holding the title and the "SCALE 1 : 100" line at a smaller inline height).
    13. **Tree zone tags:** 280. **Warning box text:** 240 to 300. **Disclaimer:** 280.
    14. **Title block:** 1.5, 2.0, 2.5, 3.0, 4.0 in paper space.
4. **TEXT versus MTEXT.** Almost everything typed by the drafter is MTEXT (164 MTEXT against 46 plain TEXT in JOB_C model space; 275 against 49 in JOB_A). Plain TEXT survives for dwelling names, tree tags, old placeholders and the title block.
5. **Justification.** Pipe labels: top centre (some top left when broken onto two lines). Invert levels: bottom left in JOB_C, top left in JOB_A and JOB_B. Cover levels: varies (top left, bottom right, top right, middle right). Schedule cells: middle centre; remarks middle left. Floor levels: bottom centre.
6. **Background mask.** Pipe labels, invert levels, cover levels, tank notes and most plan notes have the MTEXT background mask ON, using the drawing background colour. Schedule cells, floor levels, titles and the criteria box have no mask. Symbol letters inside the small dynamic blocks are masked too. [JOB_A/B/C]
7. **Colours.** By layer, with a few forced overrides: invert levels colour 1 on JOB_A/B; criteria heading colour 3; SRZ colour 233.
8. **Inline formatting used inside MTEXT:** line breaks, underline, colour changes, height changes, tabs (the criteria box lines its numbers up with tab characters), bullets and paragraph settings in notes.

---

## 4. Dimension and leader styles

1. **Styles in every job:** "STANDARD", "STANDARD$7", "R- DIMSTYLE", "T-- LEADER". The master also has "T-- DOT LEADER". [JOB_C, MASTER]
2. **Values (STANDARD, R- DIMSTYLE and T-- LEADER are the same):** overall scale 100, arrow size 3 (300 in model), text height 2.5 (250), extension offset 1, extension beyond 1, text gap 1, text above the line, aligned with the line, decimals 0, text style STANDARD, arrowhead = the default closed filled arrow, all colours ByLayer. [JOB_C, MASTER]
3. **"T-- DOT LEADER" (master only):** overall scale 20, arrow size 1.5, dot arrowheads. It is the master's current style, which suggests it is meant for 1:20 details. [MASTER]
4. **Leaders are the old LEADER object, never the multileader.** Zero multileaders in all three jobs, the master, the template and the details file. A multileader style "Standard" exists but is unused. [all sources]
5. **Leaders are never attached to their text.** Every one of the 82 leaders in JOB_C (90 in JOB_A, 100 in JOB_B) has no annotation link. The note beside it is a separate MTEXT. Move the text and the leader stays behind.
6. **Leader layer and overrides.** All on 25DIMS. Most carry per-object overrides of the style (scale 100, arrow 3, gap 1), i.e. they were copied from one original rather than drawn fresh.
7. **Two uses of a leader.** (a) Flow arrow: 2 points, exactly 750 long (52 of 82 in JOB_C), lying beside the pipe. (b) Pointer from a note to an object: 2 or 3 points, 600 to 6750 long.
8. **Dimensions.** Few (12 in JOB_C, 4 in JOB_A, 7 in JOB_B), all on 25DIMS, style STANDARD. On the plan they are used as labelled brackets with the measurement replaced by words, e.g. a 4.1 m dimension whose text is "NEW CROSSOVER TO COUNCIL REQUIREMENTS". Every dimension inside the window on JOB_B and JOB_C has typed-over text. In details the number is typed over (see 1.9).
9. **Units.** Decimal, whole millimetres, no suffix.

---

## 5. Linetypes

All from [JOB_C]; identical in [MASTER]. Lengths are in the linetype's own units and are multiplied by LTSCALE 1000 and the object's own linetype scale.

1. **DASHED:** dash 0.5, gap 0.25. Used for new pipes: 500 dash, 250 gap on the plan.
2. **HIDDEN:** 0.25 / 0.125. **HIDDEN2:** 0.125 / 0.0625.
3. **DASHDOT:** 0.5, gap 0.25, dot, gap 0.25. **DASHDOT2:** half of that (saw cuts, title boundary).
4. **CENTER:** 1.25, 0.25, 0.25, 0.25. **CENTER2:** half.
5. **PHANTOM:** 1.25, 0.25, 0.25, 0.25, 0.25, 0.25. **PHANTOM2:** half. **PHANTOM_CJ:** an office variant, 0.3175, 0.0635, 0.0635, 0.0635, 0.0635, 0.0635 (construction joints).
6. **DOT, DOT2, DOTX2.**
7. **SEWER:** dash 15, gap 1, letter "S" (text scale 2.5, style STANDARD), gap 3.2. Pattern length 19.2. Because this pattern is about 30 times bigger than the others, objects on it carry an object linetype scale of 0.1.
8. **WATER:** same with "W", pattern length 19.5. **TELSTRA:** same with "T", pattern length 19.0.
9. **ELECTRICITY:** dash 12.7, gap 5.08, letter "E" (scale 2.54), gap 5.08. Pattern 22.86.
10. **GAS_LINE:** dash 0.5, gap 0.2, text "GAS" (scale 0.1), gap 0.25. Pattern 0.95. Used with object linetype scale 2.0.
11. **AG_LINE:** dash 0.5, gap 0.4, text "AG" (scale 0.25), gap 0.35. Pattern 1.25. Used with object linetype scale 0.7 on the placeholder.
12. **Multiline styles (for pipe walls):** CLOSED-ENDS (two lines at +0.5 and -0.5, capped ends; the current style in the jobs), STANDARD and STANDARD1 (same two lines, open ends), CLOSED. Scale = pipe diameter, so the two lines sit exactly at the pipe walls.

---

## 6. Every civil element: what it is made of

Measurements are from the plotted window of the job named. "Parked" means the copy-and-fill sample sitting outside the frame.

1. **New stormwater pipe (gravity).** TWO objects drawn on top of each other. (a) A polyline on STORMWATER PIPE with global width = the pipe diameter (100, 150, 225, 300 seen), linetype ByLayer (DASHED), colour ByLayer, linetype generation off. Almost always 2 points; one polyline per run between pits. (b) A multiline on DRAINAGE, style CLOSED-ENDS (JOB_B, JOB_C) or STANDARD1 (JOB_A), scale = the same diameter, zero (centre) justification, between the same two points. On paper: a 1 to 3 mm wide blue dashed band with two thin black edge lines [PDF_C]. In JOB_C 11 of 15 pipe polylines have a multiline on exactly the same end points; in JOB_B 25 of 33; in JOB_A none match within 5 mm (the multilines were drawn separately).
2. **Charged pipe.** Same pair, polyline on STORMWATER CHARGED PIPE (prints red dashed). Width 100 (one 150 on JOB_A). Can have 3 to 6 points. Usually runs from a downpipe to the tank symbol, not pit to pit.
3. **Suspended pipe.** Layer STORMWATER SUSPENDED PIPE exists (magenta dashed). Not drawn on any of the three plans; only in the legend. On JOB_A a charged pipe label reads "...CHARGED TO WATER TANK or SUSPENDED UNDER ...", i.e. the wording carries it.
4. **Detention pipe (JOB_B).** No special layer or object. Ordinary STORMWATER PIPE polylines of width 225 (four of them) and 300 (one) with the usual multiline. "Twin" pipes are two polylines side by side. Only the label says detention: "2 x 225 DIA. STORMPRO PIPES AT 1 IN 200" and a second line "9m DETENTION".
5. **Existing drain.** Polyline on EX DRAIN HATCH with width = diameter (225), object linetype scale 0.4, plus a multiline on EX STORMWATER. Labelled with ordinary MTEXT ("225 DIA COUNCIL STORMWATER PIPE"). Prints as a grey dashed band [PDF_C].
6. **Pipe label.** One MTEXT, layer 25TEXT, height 250, mask on, top-centre justified, rotated to the pipe. Wording pattern: "<dia> DIA. <material> [<class>] PIPE AT 1 IN <grade>", e.g. "100 DIA. UPVC PIPE AT 1 IN 100", "150 DIA. UPVC SN8 PIPE AT 1 IN 100", "100 DIA. SEWER CLASS PIPE AT 1 IN 100", "100 DIA. UPVC PIPE CHARGED TO WATER TANK", "150 DIA. UPVC CHARGED PIPE TO WT", "... AT 1 IN 100 MIN.". Short runs get a two-line label set off to the side with a pointer leader. Placement is measured in section 7.
7. **Flow arrow.** A separate 2-point LEADER on 25DIMS, 750 long, default filled arrowhead 300 long, parallel to the pipe, 150 to 990 off the centreline (typically 170 to 390), on either side. Not linked to the pipe. In JOB_C 8 of the 13 parallel arrows sit in the first or last quarter of the run. 7 of the 13 point WITH the direction the pipe was drawn and 6 AGAINST it, so drawn direction says nothing about flow. Other 2-point leaders at right angles to a pipe are note pointers, not flow arrows.
8. **Pit (all kinds).** ONE dynamic block "Stormwater Pit", inserted on layer STORMWATER at scale 1, usually rotation 0 (rotated to the pipe on JOB_A: 147, 207, 209 degrees). It has one visibility list with 16 states: 350x350 Grated pit, 350x350 Junction pit, 450x450 Grated Pit, 450x450 junction pit, 600x600 Grated Pit, 600x600 Junction, 600x900 Grated Pit, 600x900 Junction, 750x750 Grated Pit, 900x900 Junction Pit, 900x900 Grated Pit, 600x1200 Detention Pit, SPS Vertical, SPS Horizontal, Enviss Sentinel, Settling Tank. No attributes. Inside, per state: a square outline polyline on PITS HIDDEN (the copy used for the small plastic pits shows a 583 square although pipes stop 175 from its centre; another copy shows 750 square; which state name each is could not be read), a mask (wipeout) on STORMWATER PIT, then either a grate hatch (user-defined lines on GRATED TRENCH) or two diagonal cross lines on STORMWATER PIT forced to colour 9. The 59 objects of all states are stored in every copy; only 3 to 6 are visible. [JOB_C]
9. **Junction pit versus grated pit versus plastic pit.** Junction = the cross; grated = the line hatch; both are states of the same block. A plastic pit is the 350 grated state with a loose text "PP" beside it. Nothing in the block says "plastic".
10. **Orifice / control pit.** On the plan it is still the same pit block, in a state that shows a crossed chamber and a grated chamber side by side inside a dashed outline, 1650 x 900 overall (pit P1 on JOB_C) [PDF_C, JOB_C]. Its real description (baffle, orifice, levels) is in the detail and the schedule, not in the symbol.
11. **Older pit block.** [MASTER] also holds "PIT BLOCK 3": visibility list (GRATED PIT, SOLID PIT, SPS GRATED PIT, SPS SOLID PIT, DETENTION PIT) plus stretch distances X_WIDTH, Y_WIDTH, SPS_RADIUS. Not used on the three jobs.
12. **Pit tag.** Block "PIT LABEL" inserted on STORMWATER, scale 1. One attribute, tag "FB", value "P1", "P2"... height 350 on 35TEXT. The circle is a 101-point mask (wipeout) on 50CONT whose frame prints (wipeout frames are switched on in the drawing). The block also carries hidden leftover lines on structural layers BEAMS and COLUMN UNDER: it is a re-used structural beam tag (FB = footing beam). Placed 850 to 1540 from the pit insertion point, on any side, with nothing connecting them. [JOB_B, JOB_C]
13. **Cover level.** Loose MTEXT on 25TEXT, height 200, mask on, usually rotated +45 or -45 degrees, wording "CL 5.35", or two lines "PP" / "CL 5.65" for a plastic pit. 560 to 1290 from the pit insertion point (JOB_C). (One on JOB_B is plain TEXT on 18TEXT colour 10.)
14. **Invert level.** Loose text "IL 5.13", height 180. JOB_C: MTEXT on 20TEXT, bottom-left, mask on (four are plain TEXT with no mask). JOB_A and JOB_B: MTEXT on 18TEXT, colour forced to 1, top-left, mask on. Rotated to the pipe it belongs to, sitting just clear of the pipe edge at the pipe end (measured in section 7). One per pipe end. Prints red [PDF_C].
15. **Downpipe.** Dynamic block "DOWNPIPE DYNAMIC WITH MASK", inserted on DOWNPIPES (JOB_C) or STORMWATER (JOB_A, JOB_B), scale 1. Contents: a circle radius 175 on DOWNPIPES, a solid hatch on DOWNPIPES HATCH (red), a helper circle on DEFPOINTS, and one attribute tag "DP" (prompt "NAME", default "DP", height 250, layer DOWNPIPE TXT). Dynamic parts: a point with a move action so the "DP" text can be dragged, and two flips. Where a pipe leaves a downpipe there is also a tiny plain block (machine name, circle radius 75 with solid red fill, on layer 0) marking the pipe end.
16. **Inspection opening.** Block "INSPECTION OPENING DYNAMIC WITH MASK": same build as the downpipe but the letters are fixed MTEXT "IO" (250, masked), no attribute. Grated version "GRATED INSPECTION OPENING DYNAMIC WITH MASK": the floor-waste symbol at scale 1.5 with fixed text "GIO" (200).
17. **Floor waste.** "FLOOR WASTE DYNAMIC WITH MASK": circle radius 100 on FLOOR WASTE, HONEY pattern hatch scale 5, fixed MTEXT "FW" (250, masked), same move and flip parts.
18. **Overflow and friends.** "OVERFLOW" ("OF"), "GRATED OVERFLOW" ("GOF"), "GRATED SURCHARGE PIPE" ("GSP"), "FROM ABOVE" ("F/A"), "TO BELOW" ("T/B"): all the same pattern as the two above with different fixed letters. JOB_B uses OVERFLOW three times.
19. **Water tank.** Plain (not dynamic) blocks named by size: "3000 LITRE TANK", "3500 LITRE TANK", "5000 LITRE TANK", "6000 LITRE TANK". Contents: a rounded outline polyline on 35CONT (the 3500 is 2250 x 650), a gradient-solid hatch on HATCH WATER, one attribute tag "WT" (default "DP", shown value "WT", height 250, layer 25TEXT). Inserted on 25DIMS or BLOCKS (whichever layer was current).
20. **Tank note.** Loose MTEXT, 25TEXT, 250, mask on, three lines: "3000 lt WATER TANK" / "1000 lt FOR DETENTION" / "2000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE". Typed by hand on each tank. JOB_A has a longer one on layer 25CONT.
21. **Roof-to-tank areas box.** One loose MTEXT ("ROOF 1 DISCHARGE TO WATER TANK 1 = 164m2" per line) with a rectangle polyline round it. [JOB_C]
22. **Trench grate.** Dynamic block "TRENCH GRATE" on layer TRENCH GRATE: outline polyline, a mask, two ANSI31 hatches (scale 31.5); two stretch distances (length and width). The parked samples are stretched to 100, 150, 200, 300 wide by 1600 or 3100 long, each with a parked "CL _____" text. JOB_B uses a different pasted block ("200 TRENCH GRATE").
23. **Spoon drain.** A multiline on SPOON DRAIN (style CLOSED, scale 100) plus the block "STRIP DRAIN LABEL DYNAMIC" (a leader and the text "SD", 180 high, rotate and flip grips). Only parked on these jobs.
24. **Agricultural drain.** Plain LINEs on AGI DRAIN with the AG_LINE linetype (8 on JOB_A, 1 on JOB_B). No width, no walls.
25. **Raingarden (JOB_B).** No block. A spline and a closed polyline on DRAINAGE with a solid hatch forced to colour 201, plus typed notes. The section and filter specification are pasted detail blocks.
26. **Overland flow arrow.** Block "OVERLAND FLOW PATH" on OVERLAND FLOW: one arrow-shaped polyline 1614 x 576 with a solid hatch. Label is a loose MTEXT, 180 high. Parked on JOB_C.
27. **Fall arrow.** Two generations. (a) "FALL SYMBOL" dynamic block (JOB_C, inserted at X scale -1 on 25CONT, and a machine-named copy of it on 25DIMS): a leader, a helper polyline, attribute "FALL" (default "FALL", 200) and attribute "FALL_GRADE" (default blank, 200); rotate, stretch and flip grips. (b) "Fall" (JOB_B, [MASTER]; inserted at scale 0.92): a leader and fixed TEXT "FALL" 250. On paper: a short arrow with the word FALL along it [PDF_C].
28. **Floor level.** Loose MTEXT on FLOOR LEVEL, 250, underlined, "FFL 6.05". No block.
29. **Finished ground / pavement level.** Dynamic block (machine name only, no proper name) with attribute tag "LEVEL" (default "P__.__", 200, on 20TEXT), a small X tick (two 141-long lines) and move grips. Values typed "FGL 6.15". The parked samples read "P__.__". A second block family "RL LEVEL" / "RL___" (attribute "RL__.__", 250, with a filled triangle) is parked.
30. **Existing level, bench mark, title boundary, bearings, easement, street name, contours.** Not in the job drawing. They print from the background reference [PDF_C]. "MATCH EXISTING LEVELS" is a loose MTEXT in the job with a pointer leader.
31. **Tree protection zone.** Arcs and lines on TPZ (HIDDEN) drawn by hand (12 arcs on JOB_B), a hatch (ANSI31 on a HATCH layer, forced colour) and plain TEXT "TPZ" / "SRZ" 280 high. The tree symbol is a pasted architect block on TREE at scale 160.
32. **Existing services.** Plain LINEs on SEWER, WATER, GAS, TELSTRA, ELEC OVERHEAD with the lettered linetypes and an object linetype scale; size note is plain TEXT ("EX. 750 DIA. SEWER MAIN"). A large sewer is a 700-wide polyline with circle and arc ends, forced colours 233 and 242.
33. **Slab and pavement hatches.** Solid hatches on HATCH 21 (driveway) and HATCH 141 (building), some associative and some not, with boundaries on HATCHOUTLINE or none. JOB_B: ANSI31 scale 50 on HATCH 150 (permeable paving).
34. **Saw cuts and joints.** Saw cut = plain LINE on SAWCUT (DASHDOT2) with a loose MTEXT "SC" rotated 90, 250, masked. The parked tag block has attribute "TAG" (values "SC", "CJ", "TJ") on layer "25TEXT - JOINT TEXT".
35. **Section mark and detail title.** "TAG SECTION MARK" (attributes "SEC" and "DWG", stretch / rotate / two flips) and "Section Title" (attributes "SECTIONMARK", "SECTIONSHEETNUMBER", fixed text "SECTION" and "SCALE 1:20"). Both are drawn at paper size and inserted at scale 100. Parked only on JOB_C. Detail titles on the sheet are mostly MTEXT inside each detail block (500 high on 50TEXT).
36. **North point and scale bar.** Inside the title block in paper space (layers 0-NORTH and 0-SCALE BAR; bar segments are polylines of width 1; text 2.5). A block "MOC" is inserted on the plan at scale 0.45 to 0.5 on JOB_A and JOB_B (not opened; likely a north point, see section 10).
37. **Warning boxes (top row).** Each is its own machine-named block inserted on STORMWATER at scale 0.967. Inside: a solid hatch on HATCH 51, an outline on HATCHOUTLINE, one MTEXT (250 to 300), and a nested dynamic "shadow box" (two polylines on 35CONT, one of width 150 forming the drop shadow, stretchable). On paper: yellow box, black shadow [PDF_C].
38. **Notes blocks.** General notes, council notes, the disclaimer ("CVL DISCLAIMER NOTE") and the before-you-dig block are each ONE block holding one long MTEXT (250 or 280) plus a shadow box. Inserted on BLOCKS (BYDA for before-you-dig, scale 0.5). To change a word the drafter edits inside the block.
39. **Legend.** Block "CIVIL LEGEND", inserted on BLOCKS at scale 1, 9250 x 30,190. 224 objects: sample pipes (polylines of width 150 and 225 on the real pipe layers), lines, 40 texts (250 / 200 / 180), small nested symbols. Identical on all three jobs; not edited per job.
40. **Pit schedule.** NOT an AutoCAD table (there are no table objects anywhere). It is the dynamic block "Pit Schedle" (spelt that way) on BLOCKS: 13 lines and 4 polylines on SCHEDULE, 12 heading MTEXTs (250, on 35TEXT), a 500-high title, a 180 note. 17,200 wide. One dynamic distance "ROW NUMBERS" with a stretch and an array action adds rows 1500 apart. The CELL VALUES are loose MTEXTs lying on top of the block: layer 25TEXT, height 250, middle-centre, no mask, each in a text box 1000, 1500 or 2000 wide (4200 for remarks, 1100 for pit number). JOB_C has 26 such cells for 2 pits. A pit with two inlets uses a second row with the repeated cells left empty.
41. **Detention criteria box.** A rectangle polyline on DRAINAGE; a heading MTEXT "ON SITE DETENTION CRITERIA" (350, layer HATCH 11, colour 3, prints green heading); ONE body MTEXT (250, 25TEXT) with a line per quantity and tab characters between the name and the value: "PERMITTED SITE DISCHARGE <tab> 6.00 l/s", "HEAD ... 380mm", "DIA. OF ORIFICE ... 69mm", "TWL ... 5.20m", then the storages. All typed. [JOB_C, JOB_B]
42. **Site / roof area box.** [A1CIVIL] parks a "SITE INFO AND CALCULATIONS" sample. On JOB_C the roof areas are one MTEXT in a rectangle (6.21).
43. **Title block.** Block "R- TITLE SHEET" in paper space at 0,0, 795 x 567. **It has NO attributes.** 106 objects: border and ruling lines on 0-TITLE and 0-TITLE BLOCK, fixed labels as plain TEXT ("DRAWING No:", "REVISION:", "DATE:", "APPROVED:", "DESIGNED:", "DRAWN:", "ORIGINAL SIZE:", "SCALE:", "TITLE:", "PROJECT:", "CLIENT:", "JOB NO:", "REVISION DESCRIPTION", "No.", "APPROVED", "DRAWN", "CHECKED", "DATE"), the job's own values as plain TEXT inside the block (so they are changed by editing the block), the office logo image, the scale bar, the reduced-plot note. Two fields exist: the drawing number is a field showing the layout tab name ("C01"), and the office address is a hyperlink field. [JOB_C, A1CIVIL]
44. **Drawing title and scale line.** Loose MTEXT (4.0 high, layer 0-TITLE TEXT) and loose TEXT "1:100, 1:20" (3.0) in paper space, over the block.
45. **Revision rows.** In the template the first row is inside the block. On the jobs each revision row is SIX loose plain TEXTs in paper space on 0-TITLE REVISION, height 1.5: revision letter, description ("PRELIMINARY ISSUE", "FOR COUNCIL APPROVAL"), three initials, date. Rows are 4 to 5 apart in Y. A new row is made by copying the last row up and retyping. The current revision letter is a separate loose TEXT (4.0) in the corner.
46. **Issue stamp.** Four MTEXTs stacked in the same place inside the title block, each on its own layer: 0-STAMP-PRELIMINARY ("PRELIMINARY ISSUE / NOT TO BE USED FOR PRICING PURPOSES / NOTE: DRAWING TO BE PRINTED IN FULL COLOUR"), 0-STAMP-TENDER, 0-STAMP-APPROVAL ("FOR COUNCIL APPROVAL / NOT TO BE USED FOR CONSTRUCTION PURPOSES ..."), 0-STAMP-CONSTRUCTION. The drafter freezes three and thaws one. On JOB_C the APPROVAL layer is thawed and the other three frozen.
47. **Details.** Each detail is one block inserted on BLOCKS at scale 1 (drawn 5x inside), e.g. "PIT 900 MAX", "PIPE BEDDING R.C & GRASS", "SLAB ON GROUND 04", "Saw cut", "REENTRANT BARS", "LAP SPLICE" (inserted at scale 5). Job-specific details (orifice pit with this job's levels, tank detail with this job's litres) are machine-named blocks whose numbers were typed inside the block. Details use hatches AR-CONC (scale 3), EARTH (scale 40), ANSI31, and old-style leaders.
48. **Computation sheet [COMP].** A separate small drawing: 6 blocks, 2 fields, no tables. Not examined further.

---

## 7. Pipes in detail (measured)

1. **Object type.** Lightweight polyline with a global width, plus a multiline for the walls. Never a plain line, never a multiline alone. [JOB_A/B/C]
2. **Global width = nominal diameter in mm:** 100, 150, 225, 300. JOB_A has several at 149.9999999999999 (a copied-and-scaled pipe).
3. **The dashed blue / red look.** Layer colour 150 or 10 prints in its own colour through the plot style table; layer linetype DASHED at LTSCALE 1000 gives 500 / 250 dashes; the global width makes the dash a solid block as wide as the pipe. No hatch, no special linetype.
4. **Pipe ends.** At a 350 pit the polyline stops 175 from the pit insertion point (the pit edge); at larger pits 43 to 400; at a downpipe it stops on the downpipe point (0). So pipes run edge to edge, not centre to centre, but not consistently. [JOB_C]
5. **Label offset, the template standard.** The parked samples in every job (100, 150, 225, 300 pipes, one label above and one below each) all have the nearest edge of the label text 73 to 74 clear of the pipe EDGE (not centreline). For a 100 pipe that is a text edge 123 from the centreline.
6. **Label offset, as drawn on real pipes (clear gap from pipe edge to nearest edge of text; labels parallel to the pipe only).**
    1. **JOB_A, 8 real labels:** 76, 76, 76, 80, 83, 95, 130, 152.
    2. **JOB_B, 16 real labels:** 60, 62, 76, 78, 78, 80, 81, 92, 95, 98, 107, 138, 141, 157, 171, and one at 761.
    3. **JOB_C, 8 real labels:** 73, 109, 115, 117, 155, 183, 196, and one at 1129.
    4. **Reading:** the drafter aims for about 75 to 100 clear (0.75 to 1 mm on paper) and moves out to 110 to 200 when something is in the way.
7. **Label side.** Above the pipe on 36 and below on 23 of the 59 parallel labels (including parked samples). No fixed side.
8. **Label rotation.** Within 0.2 degrees of the pipe on every parallel label, and turned to read left-to-right or bottom-to-top (a pipe drawn at -90 gets text at +90).
9. **Label position along the run.** Insertion point (the middle of the text) between 0.41 and 0.72 of the run on the parallel labels of JOB_B and JOB_C; roughly centred, nudged to miss things.
10. **Labels not parallel.** 2 or 3 labels per job are horizontal two-line labels (top-left justified) placed 400 to 2000 away from a short or crowded run, with a pointer leader.
11. **Invert level text position.** Parallel to its pipe; clear gap between the pipe edge and the text 22 to 88 (median 49 to 54 in all three jobs); placed 170 to 900 along from the pipe end. On either side of the pipe.
12. **Cover level text position.** Not related to a pipe: at +45 or -45 degrees, 560 to 1290 from the pit insertion point (JOB_C).
13. **Is anything linked?** No. No fields in pipe or level text (the only fields in each job are the two in the title block). No groups (zero in all three jobs). No attributes on pipes. No extended data on pipes or level text other than AutoCAD's own (text mask settings, leader style overrides). The polyline and its multiline are two unrelated objects. Label, flow arrow, invert text, cover text, pit tag and pit are six unrelated objects per pit end.
14. **Ready-made pipe pieces in [MASTER].** Blocks "100 DIA. PIPE", "150 DIA. PIPE", "225 DIA. PIPE", "300 DIA. PIPE", "100 DIA CHARGED PIPE", "100 PIPE", "100 CHARGED PIPE": each holds one 8252-long pipe polyline, its multiline, two labels (above and below) and four flow-arrow leaders. They are meant to be inserted, exploded and stretched. The same strip appears already exploded as the parked samples in the civil template.

---

## 8. Evidence of how drafters actually work

1. **Copy-and-fill is the method.** The civil template parks a full kit of samples outside the frame: 597 of its 620 model objects are parked. A finished job still has 374 (JOB_A) to 423 (JOB_C) parked objects. Parked placeholders include "IL _____", "CL _____", "CL ____", "NGL ___", "P__.__", "RL__.__", "00.00", "P00.00", sample pipes of every size with labels, every symbol block once, tanks of four sizes, trench grates in eight sizes, dwelling name texts ("Dwelling 1", "Unit 1", "Townhouse 1", "Garage"), service line samples, a tree zone sample.
2. **The same parked kit is in all three jobs** (same coordinates, same wording), which confirms they started from [A1CIVIL].
3. **Machine-named blocks.** 43 to 46 block definitions per job have names of the form "A$C" plus eight characters, the name AutoCAD gives a block pasted from another drawing with "paste as block". The template already has 57 and the master 279. They include every warning box, the general notes, the council notes, the job's orifice pit detail and tank detail, the level tag and one fall arrow. Their real identity is only knowable by looking inside.
4. **Dynamic block copies.** 60 to 70 anonymous copies per job (one per differently-stretched or differently-flipped insert).
5. **Dimensions are typed over** everywhere (section 4.8, 1.9).
6. **Per-object overrides.** 70 of 82 leaders in JOB_C carry the same copied override set. Forced colours on text (invert levels colour 1; SRZ 233). Forced linetypes on 12 objects in JOB_C (existing pit lines HIDDEN, etc.).
7. **Objects on whatever layer was current.** Tank blocks on 25DIMS in JOB_C and BLOCKS in JOB_A/B; downpipes on DOWNPIPES in JOB_C and STORMWATER in JOB_A/B; fall arrows on 25CONT and 25DIMS in the same job; the criteria box outline on DRAINAGE; the criteria heading on HATCH 11; a tank note on 25CONT; warning boxes on STORMWATER; a multiline on 25TEXT.
8. **Leftover structural content.** The pit tag is a structural beam tag with hidden beam lines and the attribute tag "FB". Structural layers and a structural layer-legend block ("LAYERS") are parked in every civil job. Blocks "SCABBLE", "CJ Detail", "REENTRANT BARS", "LAP SPLICE" travel with the template.
9. **Exploded things.** Existing pits are loose lines, not the pit block. The sample pipe strips are exploded copies of the master's pipe blocks. Cell text in the schedule is loose.
10. **Leftovers from bound references.** Layers "$0$A-ARCH BACKGROUND" to "$4$..." in JOB_B; text styles "x-sheet$0$..." in the title block; an architect's tree block "...-site-TP$0$DSHRUB3".
11. **Data left by add-ons (noted only, not analysed).**
    1. Registered application names in every job, with no objects using most of them: "StrucPlus", "RAK", "DCO15", "GeoCivilGIN", "GeoCivilFeature", "CHIEFARC-LNWT", "AcAecLayerStandard", "AEC_XDATA_BOUND_SPACE", "ACET-TEXTMASK", "AdeskUnderlayLayerOverrideData".
    2. Named dictionaries from AutoCAD Architecture-type products ("AcAec", "AEC_DISP_REP...", "AEC_PROPERTY_SET_DEFS", "AEC_VARS") and "BNS_VARIABLES", "ASE_INDEX_DICTIONARY".
    3. Extended data actually on plotted objects: "AECGUIBASE" on the background inserts only; AutoCAD's own on MTEXT (mask), leaders and dimensions (style overrides), hatches (gradient colours), dynamic block parts.
    4. Extension dictionaries on objects: only AutoCAD's own (dynamic block data on 51 inserts, the clip boundary on the background inserts, scale data on the viewport).
    5. Files beside the templates written by other tools: "*.timcad_checklist.json", "*.jobtime_cache.json", "JOBTIME_LOG.csv", "CE_INSPECT_*.json", and detail drawings saved as "*_PRE_C7_<date>.dwg". Noted, not opened.
12. **Groups:** none. **Tables:** none. **Multileaders:** none. **Annotative objects:** none. **Fields:** only the title block's two.

---

## 9. Differences

**Between the three jobs.**

1. **Sheets.** JOB_B and JOB_C: one sheet. JOB_A: two sheets (second frame 100,000 to the right, second layout C02).
2. **Background.** JOB_B/C: two named attachments of one file, rectangular clips. JOB_A: one name attached three times with polygon clips (part plans) plus a 0.2-scale copy in a block (key plan).
3. **Invert level text.** JOB_C: layer 20TEXT, colour by layer, bottom-left. JOB_A/B: layer 18TEXT, colour forced to 1, top-left.
4. **Downpipe layer.** DOWNPIPES (JOB_C) versus STORMWATER (JOB_A/B).
5. **Pipe wall multiline style.** CLOSED-ENDS (JOB_B/C) versus STANDARD1, not sharing end points with the polyline (JOB_A).
6. **Fall arrow block.** "FALL SYMBOL" with attributes (JOB_C) versus older "Fall" with fixed text at scale 0.92 (JOB_B).
7. **Pit rotation.** Square to the sheet (JOB_B/C) versus rotated to the pipes (some pits, JOB_A).
8. **Construction joint linetype.** PHANTOM_CJ (JOB_C) versus CENTER2 (JOB_A/B).
9. **Extra invented layers.** JOB_A/B carry about 18 to 25 layers not in the template; JOB_C only 5. JOB_A/B look like they were started from an older copy of the template than JOB_C.
10. **Content only on one job.** JOB_A: agricultural drains (8 lines), retaining wall polylines (width 112 and 225, colour 31), part-plan titles, soakage and tank details. JOB_B: detention pipes (225 and 300 wide), tree zone arcs, raingarden shape, trench grate, overflow symbols, permeable paving hatch. JOB_C: pump placeholder parked, two PDF tank diagrams in blocks.
11. **Same on all three:** units, frame position, viewport, scale factors, text style, heights, dimension styles, pipe build, pit block, pit tag, schedule block, legend, disclaimer, title block, stamp layers, plot style table.

**Between the jobs and [MASTER].**

1. **The master is a parts store, not a sheet.** It is saved in model space with headings 1000+ high ("SCHEDULES", "HATCHES", "CIVIL", "LEGEND", "NOTES & SHADOW BOXES", "SECTIONS", "LAYERS", "TEXT", "COPY FROM HERE", "WORK IN PROGRESS"...). One A4 layout named "LOOK LEFT AND CLICK".
2. **The jobs come from [A1CIVIL], not directly from the master.** The sheet layers, the title block, the border frame and the parked civil kit are in the template only.
3. **Master has extra civil blocks not seen on the jobs:** "PIT BLOCK 3", the pipe strip blocks, "RL", "RL-BOTTOM", "SHADOW BOX W MASK", "Section Flag", "Section Title Block".
4. **Master and template disagree on 17 layer definitions** (section 2).
5. **Master current dimension style** is the 1:20 dot leader; jobs use the 1:100 arrow styles.
6. **[DETAILS]** is likewise a parts store: 96 named blocks (42 machine-named) under big headings by topic and by council; drafters copy from it. Several headings are old job addresses, i.e. examples kept as masters.

---

## 10. Could not determine

1. **Contents of the background drawing** (how the title boundary, bearings, easement, bench mark, existing levels, contours and street name are drawn: text or block, heights, layers used). **Why:** the cleaned `Xref_<job>.dwg` files are not in the job copies; only the list of their layer names and colours comes through. The office folder for real projects was outside this study's allowed sources.
2. **Which visibility state name each pit insert is set to.** **Why:** the DXF shows which objects are visible in each copy (so the size is known from the visible outline) but the state name is stored in a form this reader did not decode.
3. **Why note boxes on layer HATCH 51 (colour 250) print yellow on the issued PDF** when the decoded plot style table sends colour 250 to 25% black. **Why:** hatch true-colour or gradient colour values were not decoded; the fills probably carry their own colour. Same doubt for the grey driveway on layer HATCH 21 (colour 49).
4. **The printed thickness of "object lineweight" colours.** **Why:** layers are set to "Default" lineweight and the default value is a setting of the drafter's AutoCAD, not stored in the DXF.
5. **Whether the plot style table used on the day matched the decoded file.** **Why:** only the current file in the CTB folder was decoded; older issues may have used an earlier version.
6. **What the block "MOC" is** (inserted on the plan of JOB_A and JOB_B). **Why:** not opened in this pass. Likely a north point; unconfirmed.
7. **The exact clip rectangles in sheet terms and whether the clip frames are shown.** Only their shape (rectangle or 6-point polygon) and that they are enabled were read.
8. **Draw order of pipe polyline versus multiline versus label** (which is on top). **Why:** the draw-order tables exist but were not decoded. On paper the label mask covers the pipe and the walls sit over the band [PDF_C].
9. **Stretch / flip settings of each dynamic insert** (e.g. exact trench grate length chosen) beyond the visible extents listed.
10. **Whether tool palettes are the real source of the blocks.** A "Tool Palettes" folder exists beside the templates and the details file has a heading "TOOL PALETTES CIVIL BLOCKS"; the palette files were not read.
11. **Sheets other than the first tile of JOB_C as pictures.** This pass looked at one picture tile only; JOB_A and JOB_B paper look is taken from the earlier Stage 1 notes.
12. **A3 templates, the council-specific A1 template, the long-section examples and the other detail drawings.** Not converted in this pass (time), so long sections, basement sheets and council variants are not covered here.
13. **Whether "T-- DOT LEADER" (scale 20) is really used for details.** It is in the master only; the three jobs' details use the scale-100 styles with typed-over text.
