# Concept gap check

**Made:** Mon 16 Nov 2026 (Melbourne) by a separate completeness checker, after D-042 ("EVERYTHING LOOKS RIGHT BUT I MIGHT HAVE MISSED SOME STUFF").
**Status:** a gap report only. Nothing here redesigns anything, nothing is a decision, nothing is approved.
**Checked:** `design\CONCEPT.md`, `pictures\new_plugin_concept_v2.html` ("the concept page"), `pictures\new_plugin_elements.html` ("the elements page"), against `DECISIONS.md` D-001 to D-042, `RULES.md`, `UI_UX_RULES.md`, the whole reference library, and `evidence\STUDY_D_GAPS_CLOSED.md` (which the reference library does not yet include).
**Words used:** "covered" = the pages show it with its parts, how it is placed, what it joins, what it holds and where it shows up. "Partly" = it is there but something a drafter or engineer needs is not. "Missing" = on neither page.
**Limits of this check are in section 5.** The biggest one: I read the words and the drawing code of the two pages, not the rendered pictures.

---

## 1. The ten most important gaps (worst first)

1. **Setting up the sheet is not in the concept at all.** Attaching the cleaned background twice (site band and floor band, stacked 50,000 apart), lining it up on the registration marks, clipping it to the frame, the model-space frame, the second sheet, part plans and the key plan have no card and no step. Why it matters: on every real job this is the first hour of work, and "a revised background arrives from the architect" (the owner's number one cause of rework) starts here.
2. **The printed look depends on four viewport colour overrides that no page mentions.** Driveway grey, building light blue and the yellow note boxes only print right through a viewport that carries the overrides (STUDY_D 3.2). Why it matters: a new sheet or second sheet made without them prints dark grey boxes, and the "looks and plots identical with no plugin" promise (D-015) is tested on exactly this.
3. **The fixed frame of every sheet has no home.** General notes, the disclaimer, the before-you-dig block, the top row of warning boxes, the no-digging pictogram, standard details (pipe bedding, junction pit, trench beside footing), plan title, section marks and detail titles are on every issued sheet, yet the pages say the parked kit is "gone; buttons instead" and give no button for any of them. Why it matters: on a plain house these are most of the sheet; the drafter would be back to copying from an old job on day one.
4. **The agricultural drain card contradicts D-040.** The card prints an invert text at the pit, holds "Invert at P5 · 5.32" and feeds "AGI 100 5.32" into the pit schedule. The owner said "AGI DRAINS DONT HAVE INVERT LEVELS". Why it matters: it is the one place where the page states the opposite of a decision in the owner's words.
5. **The side panel, where all the engineering happens, is drawn once and only for the easiest case.** Job facts, Storage and Checks have no mock-up; Levels is shown for one straight run with fall to spare. The hard case of D-017 (the discharge invert is high and there may not be enough depth to the back of the site; branches; a tank outlet in the middle) is not shown. Why it matters: D-035 asked to see "how the whole process would work"; levels are where a tight site is won or lost.
6. **Rainfall and the council's settings have no visible home, and neither does the computations sheet.** Boyd's needs the Bureau rainfall table for the site; OSD4W jobs need the settings recorded; council-supplied jobs need no required-storage page. No card shows where these are typed or what the computations PDF looks like for each job kind. Why it matters: the computations PDF goes to council with every detention job (D-021 says it prints from the same numbers).
7. **Raingardens, a second sheet, a horizontal title strip, tender issues and staged drawings are "later" or absent, but they turn up on ordinary jobs.** A two-unit job in a council that wants a 100% water-quality rating has a raingarden (JOB_B); CIV-10 and CIV-11 use the horizontal title strip; a public job runs P, T, then construction; a childcare job is staged. Why it matters: Release 2 says "houses and units with detention" but the first such units job in one of those councils would stop.
8. **CE tools and the Manager are a paragraph each, not on either page, and the helpers staff demonstrably use are not all named.** Not named: saw cut and joint lines (SC, CJ), text at pen size, the 1:20 to 1:100 dimension switch used on details, copy-multiple, the block library, the layer and style update, the multiline (pipe wall) helpers. Why it matters: D-006 put CE tools and the Manager in scope now, and D-036 asked for everything "fully covered prior to progressing".
9. **How staff work today (copy a sample, drag from a palette, copy from the last job) is removed without saying what happens when they still do it.** A pit copied from another drawing, a block dragged from the BLOCKS CIVIL palette, a pasted detail: is it an element, a dumb block, or flagged? Why it matters: the usage record shows downpipe, inspection opening and trench grate commands used twice each; "the tool palettes and copy-paste did that work". D-032 is about exactly this habit.
10. **The two-way trip through a PC with no plugin, and two people on one job, are a single "must be proven" line.** Copy and paste between drawings, WBLOCK, saving to an older format, an outsider's edit, OneDrive conflict copies (seen on a JOB_A background and 15 templates) and a colleague on AutoCAD 2022 or 2026 (three PCs in the records) are not thought through. Why it matters: this is the live failure the owner described in D-015, and D-008 (2027 only) makes every older PC a "no plugin" PC.

---

## 2. Contradictions with the owner's decisions

Twelve places found. The first five are direct contradictions; the other seven are decisions that the pages ignore or only half honour.

1. **D-040 ("AGI DRAINS DONT HAVE INVERT LEVELS") against the agricultural drain card.** The card says: Parts "Invert text at the pit IL 5.32 · 1.8 mm, red"; Holds "Invert at P5 · 5.32 chosen"; "Nothing typed until you give its invert at the pit". The silt pit card says "Inverts · 5.32 in, 5.30 out". The pit schedule mock-up prints the row "P5 ... AGI 100 5.32". What the card does get right: "a plain line with AG along it: no band, no walls" and "Label: none unless you add one". Not known: whether the schedule's invert cell for an "AGI" inlet row is left blank on real sheets (CIV-11's schedule has "from AGI" rows; their invert cells were not read).
2. **D-039 (the tank note has a leader arrow back to the tank) against both tank cards.** Above-ground tank Parts: "Tag WT · 2.5 mm, inside the symbol, as today / Tank note three lines · 2.5 mm · read from the tank / Symbol the block for its size". Underground tank the same. "How each part moves" card 7: "Tag inside the symbol; note under it" and "Move the note: Drag it anywhere". No leader or pointer is named as a part of the tank, and the tank drawings carry no arrowhead. (Other cards do name a pointer: the trench grate "note + pointer", "Match existing levels".) So when the note is dragged away there is nothing tying it back to its tank.
3. **D-039 (a pit shows the inner wall line and the outer dashed / hidden line) is honoured in a heading but not in the parts or the join rule.** The pits heading says "Same block, same sizes, same dashed outline", but every pit card lists only "Symbol: the pit block you know", and every card says "pipe ends join on the wall" without saying which of the two lines is "the wall". D-034 needs this exact: the pipe starts "EXACTLY ON THE PIT WALL". Today the pipe band stops at the pit edge (175 from the centre of a 350 pit) but not consistently. I could not see the rendered pictures, so I cannot say whether the drawings now show both lines.
4. **D-018 (cover levels, connection invert, top water level and orifice normally fixed) is applied to one pit only.** The orifice pit holds "Cover level · 5.60 measured · locked"; the junction, grated, plastic and silt pits hold "Cover level · 5.75 measured" with no lock. CONCEPT.md says "cover levels ... are locked by default". Also "Orifice · 67 dia worked out · locked" sits beside "you choose the new size", so the page says both that it is worked out and locked and that the engineer picks it. Nowhere is it shown what a lock looks like, how it is taken off, or whether a locked level can still be typed over.
5. **D-032 (muscle memory) against "Parked samples beside the sheet: gone; buttons instead" and "Typed names for things that have none in the hands today ... legal point of discharge".** The legal point of discharge has a typed name today (CDLPD, in the usage record), so does the agricultural drain (CDAGI), the plastic pit (PP), spot level, fall, tank, strip drain, kerb and tree zones. The page writes "press LPD" and "press Ag drain". The names typed most that the pages do not carry forward: PITEDIT, CDEDIT, PIPEEDIT (named as kept, but no edit window is drawn), CDTAG (64 uses), CDINSPECTOR (42), CDSYNC (10).
6. **D-036 ("FULLY COVERED PRIOR TO PROGRESSING") and D-006 (civil, CE tools and Manager now).** Neither page draws a CE tool, the Manager, the standards list, the Job facts tab, the Storage tab or the Checks tab. The concept page's next steps go straight to "Design Pit and Pipe first".
7. **D-041 (each part in the same standard spot on every pipe; a clash is solved by sliding along the pipe).** The pages give a standard spot in words for the label ("near the middle") and the invert text ("at the pipe end, just clear") but not for the flow arrow ("beside the pipe"), and choice 18 says "Label on a pipe with bends. One label, on the straight you choose", which is no standard spot. "Push off (perpendicular)" is offered as an equal move; D-037 asks for it, D-041 says the clash move is the slide. Which one the plugin tries first is not said. No numbers are ruled (measured today: label 73 to 74 clear of the pipe edge in the template; invert text 22 to 88 clear and 170 to 900 along from the end; arrow 150 to 990 off the centreline).
8. **D-033 and D-037 (grips).** The concept page counts "flow arrow: both ends" as two grips, but the elements page says "Its direction is never set by hand". What the head-end grip does is not said. Bend points of a pipe with bends (charged pipes have 3 to 6 points today) are not counted: "pipe: each end and the middle". The pit schedule's row grip, the shadow box stretch grips and the section mark grips are not mentioned. Not known: whether "AS MANY AS THERE ARE NOW" means the loose objects of a hand-drawn job (what the page counted) or the grips of the present plugin's pipe.
9. **R-35 ("Warn and carry on; don't block") and the pages' own "Nothing is ever blocked" against the issue step.** CONCEPT.md step 9: "check list must have no red". Title block card: "Checks list: no red before a council or construction issue". A real sheet is sometimes issued with a known red (CIV-06 was tuned to land exactly on the limits; CIV-11's sheet and sums disagreed at approval).
10. **D-025 (design and drafting meet either way; the plugin must suit both).** Nothing on either page shows the mark-up route: what the drafter can place without levels, who types engineering values, how the engineer sees what the drafter assumed, or how a marked-up print is worked through.
11. **D-022 (council, then AS 3500.3, then office).** CONCEPT.md says "Each limit shows which of the three it came from". No check on either page shows a source, and the Checks tab is not drawn.
12. **The four issue stamps "as now" against CONCEPT.md step 9 "pick the stage (preliminary, for council approval, construction)".** Tender is dropped in CONCEPT.md and kept ("one of four, as now") on the elements page. The newer horizontal title block has five stamps, including two preliminary ones ("checked" and "not checked").

Decisions checked and found honoured on the pages: D-002, D-003 (site area card), D-008, D-011 as corrected by D-031, D-012, D-013, D-014, D-016 (situation 21), D-019, D-020 (site area only; roof and paving have no "architect's figure" choice), D-021 (in words), D-023 (criteria box prints "HEAD 310mm", the sum uses 276.5), D-024, D-028, D-034, D-037 (the nine part-move cards), D-038 (26 situations; more are listed in check H). Not testable on a page: D-001, D-004, D-005, D-007, D-009, D-010, D-015 (a promise until proven), D-026, D-027, D-029, D-030, D-042.

---

## 3. Results of the checks

### Check A. Every element E-001 to E-066

**Covered (22):** E-001 gravity pipe, E-003 suspended pipe, E-004 detention pipe, E-007 flow arrow, E-009 junction / grated / plastic pit, E-012 pit tag, E-013 cover level, E-014 invert level, E-015 downpipe, E-016 inspection opening, E-017 floor waste, E-018 overflow family, E-021 roof-to-tank box, E-022 trench grate, E-023 spoon drain, E-026 overland flow arrow, E-039 legend, E-058 connection note, E-059 pump station (later), E-060 soakage and silt pit (later), E-064 riser and dropper, E-065 existing pit.

**Partly covered (28), with what is not there (item 27 holds two):**

1. **E-002 Charged pipe.** No home for the head check inputs (S-018). Not shown: "charged system to pit" (a second notes block in the library), the unused "charged to raingarden" layer, the wording variant "150 DIA. UPVC CHARGED PIPE TO WT".
2. **E-005 Existing drain.** The office draws existing drains in the background file, not the job drawing (STUDY_D 1.2 item 9). The card places it in the job. Which file it lives in is not decided. "Depth to be confirmed" wording not shown.
3. **E-006 Pipe label.** The two-line label set off from a short run with a pointer (2 or 3 per job today) is not shown; "push off" has no pointer.
4. **E-008 Pit.** Not covered: pit turned to the pipe (JOB_A pits at 147, 207, 209 degrees); the 16 looks of the block against the page's seven kinds (750 x 750, 600 x 900, "Enviss Sentinel", "Settling Tank"); a twin pit ("1 / 900 x 900 + 1 / 900 x 900"); pits not named P-something (JP1, CP1, SEP, ExP, "LPD", "OG"); a sump pit; renumbering; the mismatch already seen between the look of the symbol and the size typed in the schedule ("2 / 600 x 600" on a 600x1200 look).
5. **E-010 Orifice / control pit.** Not covered: the single-chamber-with-plate council version; lid class per chamber; the control pit not being P1 (CIV-11 "P6 CONTROL PIT"); storage held in the pit itself.
6. **E-019 Water tank.** Missing leader (D-039). Not covered: tank shapes and makes in the library (slimline, round, concrete, ring-shaped, four makes); reuse-only tank (the plain house has a 3,000 litre reuse tank with no detention line); detention-only tank ("15000 LITRE UNDERGROUND WATER TANK FOR ON-SITE DETENTION PURPOSES. PROVIDE ORIFICE TO BASE OF TANK"); a tank inside a basement labelled by area; fire tank; concrete pad level in the note; names RWT1 to RWT3.
7. **E-020 Tank note.** Leader; the wording for the cases in item 6.
8. **E-024 Agricultural drain.** Contradicts D-040 (section 2 item 1). Existing agricultural drains and the "no groundwater to the kerb" rule not covered.
9. **E-025 Raingarden.** A card exists, marked Later. Needed sooner (see gap 7).
10. **E-027 Fall arrow.** Grade written as "1:22 14%" on paths; the older fixed-text arrow.
11. **E-028 Floor level.** Slab surface level (SSL), garage levels, "PROPOSED FFL" not on the Release 1 card.
12. **E-029 Level tags.** The "RL" tag family with a triangle, "NGL", the four corner pavement tags, and a whole car park of levels on a grid are not covered.
13. **E-030 Survey and title information.** Title boundary and easement have cards. No card for: bench mark box, boundary lengths and bearings text, street name, contours, neighbours' buildings, kerb and channel, footpath, crossover. Several of these are added by the office in the background file; with what tool is not said.
14. **E-031 Tree zones.** Read-only card. The office also draws the circles, the green hatch and "TPZ" / "SRZ" text itself, and places the yellow tree requirements box.
15. **E-032 Existing services.** Read-only card. Drawing them from service plans (palette "services lines", "low pressure gas pipe") is not covered.
16. **E-033 Slab and pavement fills.** Paving and permeable paving have cards. Not covered: the building footprint fill, the viewport overrides that make the fills print, pavement types with their own colours, garden strips, infill slabs.
17. **E-038 Notes blocks.** Only the council notes block has a card. General notes, disclaimer, before-you-dig, charged system notes, pump notes, tree, neighbour's footing, retaining wall, soakage assumptions and shared drainage asset notes do not.
18. **E-040 Pit schedule.** Not covered: the three standing notes' wording (unknown in the evidence too); a row that is not a pit (pump well, existing council pit); hand override of a cell; what happens when 20 rows do not fit the space; the schedule kept as its own workbook and PDF on two jobs.
19. **E-041 Criteria box.** Not covered: the other row wordings seen ("SITE PERMITTED SITE DISCHARGE", "TOTAL VOLUME REQUIRED"); a job with no orifice (CIV-12 argues flows instead); the pit storage lines (the made-up job lists no pit although real boxes do).
20. **E-042 Site / area box.** Mentioned once ("site info box where a council asks"); no card.
21. **E-043 Title block.** The card lists project, title, scale, drawing number, revision. Not shown: client, job number, date, designed / drawn / approved, original size, logo, north point, scale bar, reduced-plot note; the horizontal strip; the title block attached as a reference on some templates.
22. **E-044 Drawing title and scale line.** In the title card as "title, scale" only.
23. **E-045 Revision rows.** The mock-up has one "DRAWN" column; real rows carry three sets of initials (drawn, checked, approved). P1, P2 and T1 to T4 numbering not shown.
24. **E-046 Issue stamp.** Tender dropped in CONCEPT.md; five stamps on the newer title block.
25. **E-047 Details.** Only the orifice pit detail and tank detail are carded. "Standard details come from the office library by name" is one line. Not covered: details drawn at five times size with typed-over dimensions; pasted details at other ratios; PDF pictures inside detail blocks; which detail a given element calls for (deeper junction pit detail only when a pit is that deep).
26. **E-056 Background attachment.** The "read from the background" family covers reading. Making, attaching, stacking, clipping and replacing it is missing.
27. **E-061 Roof hatch and legend.** Covered on the roof area card; the four-swatch legend row ("ROOF 1 TO WT1 - 140.2m2") is a second layout not shown. **E-062 Outfall plan and long section** is carded (later) but its sheet companions are not: locality plan, trench cross-section, pasted council drawings, outfall notes, crossing services as ellipses, break symbol.

**Missing from both pages (16; item 15 holds two):**

1. **E-011 Older pit block** (still on the palette; whether it is retired is not said).
2. **E-034 Saw cuts and joints** (SC, CJ, TJ lines and tags; used today, 21 runs of the saw cut helper).
3. **E-035 Section mark and detail title.**
4. **E-036 North point and scale bar.**
5. **E-037 Warning boxes** (top row).
6. **E-048 Computation sheet.**
7. **E-049 Dwelling and garage names.**
8. **E-050 Pointer leader and plan note** as a general thing (only "Match existing levels" is carded).
9. **E-051 Dimension used as a labelled bracket** ("NEW CROSSOVER TO COUNCIL REQUIREMENTS").
10. **E-052 Building outline** (the heavy outline over the background).
11. **E-053 Retaining wall.**
12. **E-054 Batter.**
13. **E-055 Sheet frame and sheet number text.**
14. **E-057 Part plans, match lines and key plan.**
15. **E-063 Revision cloud** and **E-066 Plan title and scale line.**

**Found in STUDY_D and in neither the library nor the pages (26):**

1. Background file: several plans stacked 50,000 apart in one file, attached twice so the bands overlay.
2. Registration marks (non-plotting guide lines at fixed coordinates) that line the bands up.
3. What "cleaning" a background means (explode, move to office layers, delete the architect's notes and dimensions, add boundary text, bench mark box, tree zones, existing drain).
4. The background template (a key of 27 layers) and the five older per-level templates.
5. Viewport colour overrides on four fill layers.
6. Draw order (fills and background at the bottom; walls over band; pits over pipes; downpipe dots over pipes).
7. Clip rectangles cut to the sheet corner; downpipes accidentally clipped with the background (they vanish if dragged outside).
8. The second frame 100,000 to the right and its layout.
9. The horizontal title strip on civil sheets (how those sheets are started is unknown).
10. Staged drawings and the legend line "DENOTES EXTENT OF STAGE 1 WORKS".
11. Tender issue stage in use (P, then T, then A).
12. Revision clouds in use (schedule rows on CIV-10; small items on CIV-15).
13. Pavement legend swatches, each a full specification paragraph and a design vehicle statement.
14. Car park level grids, car spaces, accessible bays, kerb ramps, crossfall and path grade notes.
15. Slab legend swatches with mesh, cover, strength and sub-base lines.
16. Structural grid bubbles and pile wall on basement sheets (named on the basement card as "read from the structural background"; no reading card).
17. Locality plan (a circle with a north point).
18. Trench cross-section at 1:20 with clearances to crossing services.
19. Council standard drawings pasted on as pictures; one council's library of 27 tiles.
20. PDF pictures inside detail blocks (tank installation diagrams).
21. The no-digging pictogram ("MOC") and the newer before-you-dig logo.
22. Buffer strips and swales (legend swatch and detail).
23. A small second plan "LOCATED OFF PLAN" with its own legend; "VOID TO BASEMENT BELOW"; ramp hump notes.
24. "SITE INFO AND CALCULATIONS" form parked in the template; a pit detail drawn as a small isometric picture.
25. The office calc header drawing used for one-page sketches (a rainwater head), separate from the computations.
26. Housekeeping facts that bear on any tool: a finished job saved as "the" council template; library drawings holding objects from another product that AutoCAD cannot edit; OneDrive conflict copies; palette tools that break when the master drawing or a machine-named block is renamed.

Already carded as "later" although first seen in STUDY_D: cut and fill zones, modular underground tank, treatment device and litter basket, kerb with an overland flow break, basement sheet.

### Check B. Every job kind K-001 to K-013: can the concept carry it, and the first thing that stops it

1. **K-001 Plain house.** Mostly carried by Release 1. First stop: the fixed frame (general notes, warning boxes, standard details, plan title) and the background set-up have no tool. Second: a reuse-only tank's note wording.
2. **K-002 House with detention.** Needs Release 2. First stop: the rainfall table for Boyd's has no home. Second: pit storage (which pits hold water, and the water depth) is not on any pit card. Third: one council job's sums use a flat 1.00 cubic metre credit for any tank of 2,500 litres or more, which is not "total less reuse" (D-024); which rule applies is not known.
3. **K-003 Units, tanks only.** First stop: the council's own orifice pit detail. The library holds about 26 pasted details for 8 councils with the numbers typed inside each block; none can be filled from facts as it stands.
4. **K-004 Units, pipes, pits and tanks.** First stop: the share underground has no place on a page (Storage tab not drawn). Second: "no detention pipes under dwellings or garages" needs the plugin to know a building or garage outline; that is not a "read from the background" kind.
5. **K-005 OSD4W.** Carried as a typed result. First stop: nowhere to record the settings (coefficients before and after, times, zone, storm years) or to attach the program's print to the computations.
6. **K-006 Council supplies both figures.** Carried. First stop: none in the drawing; the computations PDF layout for "council's figures, no required-storage page" is not shown.
7. **K-007 Pumped.** Later. First stop: it is not in Release 1 or 2. Then the unsettled pump workbook version (Q-003) and a criteria box and a pump box on the same sheet when the detention sits in the well.
8. **K-008 Soakage.** Later. First stop: areas can be pointed at a tank but not at a soakage pit (catchment per pit), and the rainfall table to 7 days has no home.
9. **K-009 Raingarden / STORM report.** First stop: the raingarden is "Later". Second: the office redoes the STORM report after the layout is drawn, and needs areas split by where they go (roof to tank, roof straight to drain, balcony, driveway untreated); the areas family has only "roof to tank", "paving", "permeable".
10. **K-010 Outfall with long section.** Later. First stop: the second sheet. Then: the area draining to each run (for the design flow row) has no home.
11. **K-011 Industrial.** First stop: horizontal title strip and three sheets. Then: modular tank (later), the yearly runoff reduction sum, the outlet stub capacity check, class D lids with step irons in remarks.
12. **K-012 Basement.** Later. First stop: more than one level in one job. Then: ramp and driveway grade (S-020) has no home.
13. **K-013 Other kinds and the "civil site job".** First stop: staging, tender stage, pavement legend swatches and cut and fill are not in the first releases; which "civil site" drawings the office does is still open (Q-011).

### Check C. Every sum S-001 to S-027: inputs, where shown, where it lands

**Covered (7):** S-004 detention pipe storage; S-006 storage total; S-007 orifice size (sum shown in full); S-008 pipe grade (sum shown); S-011 depth to outlet; S-021 long-section rows (later card); S-024 tank split as far as "total less reuse".

**Partly (15 sums; item 8 holds two):**

1. **S-001 Coefficient and effective area.** Areas have cards. The coefficient sum is shown nowhere; the pervious figure (0.30 or 0.35) is unruled.
2. **S-002 Permitted discharge by sum.** The rainfall figure has no home. Output row covered.
3. **S-003 Boyd's.** Named in CONCEPT.md only. Rainfall table input and the column of storm lengths are not shown.
4. **S-005 Pit storage.** A "pit that holds water" line is named on the criteria box card; no pit card shows the tick, the water depth or the sum.
5. **S-010 Pipe cover.** On the Checks list. The surface level at a pipe end that is not at a pit (downpipe, tank, open end) and which cover figure applies (under traffic, under pavement, single dwelling) have no home.
6. **S-012 Pit size from depth.** On the Checks list. Two office tables disagree (Q-004).
7. **S-013 Detention pipe cover with the maker's sizes.** CONCEPT.md names "real diameters" in the standards; no card uses them. Storage is worked from the nominal size today; which to use is not said.
8. **S-014 and S-015 Pump well and level ladder.** On the pump card (later). Workbook versions disagree (Q-003).
9. **S-016 Soakage balance.** On the soakage card (later); catchment per pit, moderating factor and the rainfall table have no home.
10. **S-017 Emptying time.** Not named. One job works out 25 days and says nothing; no limit is known.
11. **S-023 Share underground.** In CONCEPT.md step 6; on neither page.
12. **S-025 Invert steps.** The 20 mm orifice step shows inside the orifice sum. The inlet step, the 10 mm step at detention pits and the ordinary drop across a pit (the made-up job uses 20 mm) are not named as standards.
13. **S-026 OSD4W result.** Typed in; settings have no home.
14. **S-027 STORM rating.** "STORM tank figures" in job facts; the areas the report needs are not all there (check B item 9).

**Missing (5 sums, plus one sum not yet in the register):**

1. **S-009 Pipe capacity (Manning).** Only as a row on the later long section. One real job has a one-line outlet check on an ordinary sheet (CIV-12). How capacity is checked on detention jobs is still open (Q-002).
2. **S-018 Charged line head check.** Situation 3 names "the 300 minimum from gutter to tank inlet"; gutter level, tank inlet level, roof area per line, length and fittings have no home.
3. **S-019 Yearly runoff reduction and monthly tank balance.**
4. **S-020 Driveway grade** (six points along the drive).
5. **S-022 Pipe design flow as a running total down the line.**
6. **The one-line flow argument used instead of an orifice** on the basement house (found in STUDY_D 5.3; not yet in the sums register).

### Check D. Every limit L-001 to L-024: on the Checks list, and a home in the standards

**On the Checks list and with a home (6):** L-001 grade; L-006 pit size by depth; L-009 orifice constants; L-011 top water level below covers (the 300 below habitable floors and 150 ponding figures are not named); L-021 long section scales (later); L-024 tank orifice.

**Partly (13 limits; item 9 holds two):**

1. **L-003 Pipe under a garage.** "Needs an IO each side" is a check; the 150 SN8 class is only a line in the made-up council notes; the plugin has no way shown to know a garage.
2. **L-004 Minimum cover.** Check exists; four values unruled (Q-004); which situation a pipe is in is unknown to the plugin.
3. **L-005 Detention pipe cover with maker's sizes.** As S-013.
4. **L-007 Orifice pit build.** Carried by the library detail; "100 clear from lid to top of baffle" and wall thickness by council are not checks.
5. **L-008 Minimum orifice.** A home in the council rows; not named as a check.
6. **L-010 Share underground and tank credit.** A home in the council rows; not on a page.
7. **L-013 Clearances.** Boundary, easement, tree zones, services and neighbour's footing are checks (Release 2). Missing: 1 m from the crossover splay, new council pit 1 m from the crossover, connect above the top third of the council drain, 150 at a crossing.
8. **L-014 Charged lines.** The 300 head is named. Missing: 135 degree bends and no 90s, tank slab level nominated.
9. **L-015 Pumps** and **L-016 Soakage.** On their later cards in part.
10. **L-017 Storms, coefficients and times.** A home in the council rows; not on a page.
11. **L-018 STORM rating.** In job facts only.
12. **L-019 Lid classes.** The lid is a fact on the pit; no check that the class suits what is over it (driveway, car park, warehouse).

**Missing from the Checks list (5 limits, plus one part of L-006):** L-002 minimum pipe size (100; 150 between pits; outfall minimums); L-012 no detention pipes under dwellings or garages, and sleeves; L-020 driveway slab where a council sets it; L-022 pipe class under driveways and in the road ("SEWER CLASS PIPE"); L-023 groundwater kept out of the kerb outlet and the pump well; step irons by depth (part of L-006; three values unruled).

**Standards list (CONCEPT.md section 5): things with no named home.** The rainfall table for a site; the drop across a pit; the pit numbering rule; draw order; the viewport overrides; the pen table itself (named only in a comparison line on the concept page); the dimension and leader styles; the linetype and hatch pattern files; the 16 pit looks; lid wording for the schedule ("Class B Solid"); council note blocks and council standard drawings as files; dated versions of a council's row when its rules change mid-job.

### Check E. Inputs and outputs (INPUTS_AND_OUTPUTS.md)

**Inputs with a clear home (27):** 2, 3, 6, 11, 13, 14, 16, 19, 21, 22, 25, 27, 29, 31, 33, 35, 37, 38, 39, 40, 41, 42, 43, 46, 47, 48, 49 (6 lacks the offset; 29 is on a later card).

**Inputs with a partial home (13):** 1 discharge option (pipe, pit and kerb only; easement drain, new outfall, soak on site and existing internal system are not kinds of the LPD card); 4 method and settings; 8 treatment and reuse conditions; 12 boundary, bench mark, easements, neighbours (bench mark has none); 17 pit photos, pipe depths, footing probes (the footing card holds a soil angle but not the footing depth the check needs); 18 the architect's CAD; 20 roof plan and downpipe positions (placed by click; picking the architect's symbols is not offered); 28 STORM figures (bedrooms or occupants not held); 32 tank model, footprint and height; 34 pump duty; 36 which areas are impervious and the catchment split; 44 and 45 (later cards).

**Inputs with no home (9):** 5 gravity only or pump allowed; 7 connection standard drawing numbers and splay clearance; 9 long section needed or not; 10 fee, how to lodge, permit number and date, endorsed plans; 15, 23 (later kinds, named only); 24 landscape plan and crossover positions and widths; 26 soil profile and groundwater; 30 the rainfall table.

**Outputs covered (22):** 1 to 8, 12 to 15, 17, 18, 21, 22, and 9, 10, 11, 19, 23, 26 as later cards.

**Outputs partly or not covered (7):** 16 clearance dimensions on the plan (missing); 20 site areas box (no card); 24 soakage sections and 25 raingarden section (named, not carded); 27 service crossing section (missing); 28 computations PDF (no card); 29 the pack sent beside the drawing: STORM report, discharge letter, council declaration or checklist (no home in the Issue step); plus the council's own checklist of things it commonly asks for (roof hatch legend, splay dimension, crossover widths, spot levels at corners, "all pits scheduled").

### Check F. Decisions

See section 2. Twelve places; five direct.

### Check G. The drafter's whole day: things no card covers

1. **Starting a job.** CONCEPT.md step 1 is one sentence. Not covered: which template (vertical or horizontal strip), the job folder and file name rule (unknown in the evidence), the Xref folder, what happens to the 600 parked samples a template carries.
2. **Making the background.** Cleaning the architect's and surveyor's files is office work done before design; no tool, no checklist, no statement that it stays manual.
3. **Attaching and clipping the background.** Missing (gap 1).
4. **A revised background arrives.** The pages say "on open, one line says so" for a boundary and a survey level. Not covered: downpipes, roofs, paving and walls that moved; how the old and new backgrounds are compared; that the job drawing "never changes" when the background file is swapped, so nothing triggers a check unless the plugin looks inside the background.
5. **Details at five times size with typed-over dimensions.** Missing. The dimension scale switch (1:20 to 1:100) is a helper used today.
6. **Standard details and council notes from the office detail drawings.** One line. No card for picking, placing, updating when the library changes, or the nine library drawings.
7. **The legend.** Covered.
8. **Warning boxes.** Missing.
9. **Plain notes with leaders.** Only one instance carded.
10. **Dimensions as labelled brackets.** Missing.
11. **Revision rows, issue stamp.** Covered in part (check A items 23, 24).
12. **Drawing register.** Carded, later.
13. **Plotting to PDF with the office pen table.** "The PDFs are made" is one clause. Not covered: page set-up name, which plot device (two differ today), the pen table copy on each PC (local copies differ), the PDF file name, plotting every sheet, "print in full colour".
14. **A second sheet.** Missing.
15. **A council request for changes.** Not covered: clouding what changed, a reply list, comparing this revision with the last.
16. **Copying parts of a previous job.** Not covered (gap 9).
17. **Sending the drawing to someone with no plugin.** "The no-plugin copy is the same file" is the whole answer. Not covered: binding or sending the background with it, fonts, the pen table, the linetype files.
18. **Opening an old hand-drawn job.** D-027: opens and plots; adopt later. Not covered: a new revision of an old job (CIV-04 ran to Rev I after as-built mark-ups), which must then be done wholly by hand beside the new tools; and whether the new tools refuse, ignore or half-read old objects (the August notes record parked blanks being read as live design).
19. **As-built mark-ups after approval** (Q-010) and **an outside designer's drawings arriving** (CIV-11): not covered; import is ruled out for the first releases.
20. **Measuring for the fee or the council email** (site and impervious areas sent to the council before any layout): the areas tool can do it; no page says it can be used before anything else is placed.
21. **The roof catchment sketch as its own small PDF** (the only job-made item on the plain house): not covered.
22. **The mark-up route** (D-025): not covered.

### Check H. Everyday AutoCAD behaviour the pages do not address

Addressed on the pages: move, copy (one and a group), erase, stretch, mirror, rotate (text stays readable), undo (one line), double-click to edit.

Not addressed, each needs an answer before a tool is designed:

1. **Copy and paste between drawings; copy with base point.** Numbers clash, the other drawing has another council and other job facts, joins to things not copied.
2. **WBLOCK, and insert of a drawing that holds elements.**
3. **Scale.** A pit or a pipe scaled by 0.5: does the size fact change?
4. **Explode.** Of an element, of its parts, of a detail.
5. **Trim, extend, break, fillet, join, offset, lengthen, array on a pipe.**
6. **A rotated UCS or a plan drawn turned.** "Reads left to right or bottom to top" is measured against what?
7. **Layers frozen, off or locked.** A pit on a locked layer whose pipe end is dragged; a label on a frozen layer when the pipe changes; the office rule to respect locks.
8. **Objects inside the background reference.** Picking a line in it is assumed everywhere ("click the line in the background"); nested blocks, a clipped area, and the same file attached twice 50,000 apart are not addressed.
9. **Undo and redo in the middle of a command; cancel and Escape** half-way through a pipe with bends or a levels preview.
10. **Object snaps.** Does a pit wall or a pipe centre line offer its own snap; do running snaps fight the "in line with the click" rule.
11. **Window against crossing selection** when a group is picked: are parts picked on their own.
12. **Properties palette.** Can a level, a size or a layer be changed there; what if the layer is changed by hand.
13. **Match properties, quick select, select similar** across elements and parts.
14. **Change of layer, colour or linetype by hand** on a part (the standard says one thing, the drafter did another).
15. **Purge and the office CLEAN helper** (which purges, tidies reference layers and forces text styles): could it remove what the plugin stores.
16. **Audit and recover.**
17. **Saving to an older format, or to DXF.**
18. **Drawing recovery after a crash; autosave copies.** The records hold 842 "did not close cleanly" starts.
19. **Two people on copies of the same job** through OneDrive (conflict copies exist today).
20. **A drawing made on a newer version opened on a PC with an older version of the plugin.**
21. **Speed on a big sheet.** The industrial job has 8 pits over 20 schedule rows, a car park of levels and 313 layers; no target is stated.
22. **Draw order after an edit.** Who keeps pits over pipes and masks over bands.
23. **Text masks and the wipeout frame setting** (the pit tag circle prints because frames are on).
24. **Model space against the layout.** Title block, revision rows and stamp are in paper space; everything else is in model space; the Issue button works across both.
25. **Linetype scale.** The lettered service linetypes and the AG linetype need a per-object scale to look right.

More situations for the "Every situation" list (D-038): two pipe ends on the same spot of a wall; a pipe that crosses a match line onto the next part plan; a pipe that changes size or class part-way; a pipe passing under a trench grate or a paved area; a pit resized while joined; a pit turned; two systems and two discharge points on one site; an element dropped inside a tree zone or easement when Release 1 has no such checks; a downpipe whose position came from the background and then moved.

### Check I. CE tools and the Manager against reference\today

**CE tools named in CONCEPT.md section 6:** move + rotate, copy + rotate, leader, dimensions, hatches by pen, layer-by-pen quick set, revision cloud, clean and purge, background tidy, copy as block. Old names kept: MR, CR, Q, LD.

**Helpers the records or the drawings show in use that are not named:**

1. **C** (copy forced to multiple): 355 runs, the most used helper after the block library.
2. **The wrapped STRETCH:** 112 runs.
3. **QD** (leader with dot), **AD** (aligned dimension): in use; only Q and LD are named.
4. **SSC, CJ, CJSS** (saw cut and construction joint line with its tag): 21 runs; this is the "pavement" half of the sheet title.
5. **Text at pen size** (25C, 18T, 18B and the rest of that family): in use.
6. **DUP and DSET** (dimensions from the 1:20 set-up to 1:100, and the measuring factor): what makes the five-times details readable.
7. **LU** (bring in office layers and styles), **MTS** (merge text styles), **FASTSAVE**.
8. **DIV** (divide with marks): 10 runs.
9. **CML, SML** (the multiline styles used for pipe walls on every hand-drawn job).
10. **CEBLOCKS** (the office block library window): 1,017 runs, of which 985 are from one PC that may be a test account. Whether the block library belongs to CE tools or the Manager is not said.
11. **TP** (show one group of tool palettes) and the palettes themselves.
12. **Section mark, level marks (FFL, RL, SSL, NGL), break line, centreline:** today inside the structural program only, so a civil-only PC does not have them.
13. **Plot to PDF:** the only such command today is in the structural program.
14. **Schedule from a spreadsheet** (CIVILEXCELMTEXT): two jobs keep the pit schedule as a workbook.

What cannot be known from the records: plain AutoCAD commands, loose LISP tools and palette drags are not recorded. The civil records are almost all from April on two PCs. Q-015 is still open.

**What the Manager must still do that "three things only" drops or does not mention:**

1. **Carry the office standards, the pen table, the linetype and hatch files, the templates and the detail library to each PC,** and say which version of the standards a drawing was made with. Today every PC holds its own local pen table and its own palettes.
2. **Clear out what is there now:** seven bundles, 119 dated backup folders (10.2 GB), an old Manager in the all-users folder, two test bundles, and each PC's start-up list of private LISP copies that answer to the same typed names (CD, MR, CR). Which tool answers when a name exists twice is unknown today.
3. **Usage, machine and failure records.** They are the only evidence of what is used; CONCEPT.md keeps "send a fault report" only.
4. **A health check** (what is loaded, from where, does it match).
5. **Who may publish and who may change the standards** (today a list of administrators; only one Windows login can sign).
6. **What a PC not on AutoCAD 2027 gets.** The records show AutoCAD 2022 and 2026 on three PCs.
7. **Working when OneDrive has not synced** the shared folder.
8. **The pages the present Manager has that are not mentioned:** survey intake, sheets list, job checklist (23 templates), drawing repair. Dropping them may be right; it is not stated as a choice.
9. **The log of what each command did** (R-37) and, later, the AI cost cap (R-56).

---

## 4. Decisions the owner still has to make

Fifty-two questions, deduplicated from the 25 "Choices I had to make", the open questions and the gaps above. "Rec." is this checker's recommendation only. Each has a one-line real-job example.

### Pit

1. **Which line is "the wall" a pipe joins to?** (a) the inner wall line; (b) the outer dashed line; (c) the pit edge used today (175 from the centre of a 350 pit). Rec. (c) so new sheets match old ones. Example: a 150 pipe into P2 stops where it stops on the CIV-03 sheet.
2. **Are cover levels locked on every pit by default?** (a) all pits; (b) the orifice pit only; (c) none until the engineer locks. Rec. (a), per D-018. Example: P3's cover 5.78 picked off the survey cannot be changed by a levels preview.
3. **Is the pit size one fact, with the schedule reading the symbol?** (a) one fact; (b) schedule cell can be typed over. Rec. (a) with a remark field. Example: the pit drawn with the 600x1200 look that the schedule calls "2 / 600 x 600".
4. **How are pits numbered and renumbered?** (a) next free number, never renumbered; (b) P1 at the outlet, a Renumber button working upstream; (c) free typing. Rec. (b). Example: erase P3 on a five-pit job and the schedule runs P1, P2, P4, P5 unless renumbered.
5. **Do plastic pits get a number?** (a) yes, all pits scheduled (a council request); (b) no, "PP" only. Rec. (a). Example: P4 on the two-unit job.
6. **A pit dropped on a pipe:** (a) split the pipe in two; (b) leave it whole and flag it. Rec. (a). Example: adding an inspection pit half-way down a 22 m run.
7. **Moving a pit without its pipes: which held key?** (a) Ctrl; (b) Shift; (c) no key, a right-click choice. Rec. (c), because Ctrl and Shift already mean something on grips. Example: nudging P2 off a footing.
8. **Cover level text: four corners and two angles, plus free drag?** (a) as drawn; (b) free drag only. Rec. (a). Example: CL 5.75 clear of a wall at the top-right.
9. **Which pit kinds are in the first release?** (a) the seven on the page; (b) add twin pit, sump pit and a turned pit. Rec. (b) for the turned pit at least. Example: JOB_A pits turned to 147 degrees to suit the pipe.
10. **Which pits count as storage, and how is the water depth set?** (a) a tick on the pit, depth = top water level less the pit invert; (b) typed volume. Rec. (a). Example: CIV-02 pit P1 0.6 x 0.6 x 0.31 = 0.11.

### Pipe

11. **Standard spot of each part, in numbers.** (a) the template's (label 75 clear of the pipe edge, mid-run); (b) the averages measured on jobs; (c) the owner states them. Rec. (a). Example: a 100 pipe label 123 from the centreline.
12. **Clash move: slide first or push off first?** (a) slide along (D-041); (b) either, equally. Rec. (a) with push off still possible (D-037). Example: IL 5.24 slid 300 along to clear the P3 tag.
13. **One grip or two for along and off?** (a) one; (b) two. Rec. (b): two is nearer to what hands know and cannot be misread. Example: the label on a 45 degree pipe.
14. **What does the grip at the arrow head do?** (a) nothing, one grip only; (b) moves the arrow, never turns it; (c) flips side. Rec. (b). Example: the arrow on P3 to P2.
15. **Label on a pipe with bends.** (a) the longest straight; (b) the first straight; (c) the one the drafter picks, no standard. Rec. (a). Example: a charged line with five bends round a house.
16. **Twin detention pipes:** (a) one element, two bands, "2 x 225"; (b) two pipes side by side. Rec. (a). Example: JOB_B's twin 225 at 1 in 200.
17. **Marking detention:** (a) a tick on a pipe or pit; (b) its own kind. Rec. (a). Example: an 8 m run made detention after the council's figure arrives.
18. **Agricultural drain: what does it carry at the pit?** (a) nothing, and the schedule's invert cell is blank; (b) nothing on the plan, the pit's own inlet invert in the schedule; (c) as the card (contradicts D-040). Rec. (a) or (b); the owner must say which. Example: the "from AGI" row of P5.
19. **A branch onto a pipe with no pit:** (a) allowed, inspection opening offered; (b) allowed, inspection opening placed; (c) flagged. Rec. (a). Example: a downpipe joining a 100 pipe part-way.
20. **Open end wording and print:** one name ("open end" or "not joined"), and what "capped", "continues off the sheet" and "to kerb" print. Rec. "open end"; prints nothing until marked. Example: a stub left for a future unit.
21. **Flow arrow before levels are set:** (a) the way it was drawn; (b) no arrow until both inverts exist. Rec. (b): unknown stays unknown (R-35). Example: a first-day layout with no levels.
22. **How are pipe capacities checked on detention and bigger jobs (Q-002)?** (a) not at all; (b) outlet pipe only; (c) every run. Rec. (b) to start. Example: CIV-12's one line, 150 at 1 in 100 = 19.80 l/s.
23. **The drop across an ordinary pit and the steps in the orifice pit:** (a) office standard 20 / 20 / 10 mm; (b) typed each time. Rec. (a) as standards. Example: P2 in 5.15, out 5.13.
24. **Do existing drains live in the job drawing or the background file?** (a) job drawing; (b) background, read from there. Rec. (a) so a join is possible. Example: the 225 council pipe on JOB_C, today drawn in the background.

### Inlets

25. **Numbered or plain?** (a) plain "DP"; (b) DP1, DP2. Rec. (a), as printed today. Example: 18 downpipes on a two-unit job.
26. **Inspection opening on a pipe:** (a) rides on the pipe, pipe stays whole; (b) cuts the pipe. Rec. (a). Example: an IO each side of a garage.
27. **"FO" and "GIO":** confirm FO = front overflow and GIO = grated inspection opening. Rec. confirm. Example: the present plugin's own list calls GIO something else.
28. **Dragging a block from the old palette or copying one from another job:** (a) it becomes an element; (b) it stays a plain block and is flagged; (c) palettes are retired. Rec. (a). Example: a drafter drags "downpipe" from BLOCKS CIVIL out of habit.

### Tank

29. **Tank tag:** (a) "WT" on plan, "water tank 1" in boxes; (b) WT1, WT2 on plan. Rec. (b) on jobs with two or more tanks. Example: CIV-08 legend "ROOF 1 TO WT1".
30. **Tank note leader (D-039):** (a) always drawn; (b) only when the note is off the tank. Rec. (a), as today. Example: a slimline tank against a wall with its note in the yard.
31. **What a tank counts as detention:** (a) total less reuse (D-024); (b) the council's credit rule where it has one; (c) a flat 1.00 for tanks of 2,500 litres and over. Rec. (b) falling back to (a). Example: CIV-02's "Water Tank contribution ... = 1.00m3".
32. **Riser and dropper:** (a) ordinary pipes with wording; (b) keep the riser / dropper symbol as well. Rec. (a). Example: "100 DIA. DROPPER FROM WATER TANK / CONNECT INTO PP".
33. **Erasing a tank:** (a) its roof area stays, amber "no tank"; (b) the area goes too. Rec. (a). Example: the architect deletes tank 2.

### Line drains

34. **Kerb, side entry pit:** Release 1 or later? Rec. later, with the outfall. Example: CIV-05 sheet 2.
35. **Saw cuts and joints (SC, CJ, TJ):** (a) a CE tool in Release 1; (b) left to hand drafting. Rec. (a). Example: the driveway joint lines on every units job.

### Legal point of discharge

36. **"APPROX" in the note once the invert is confirmed:** (a) kept; (b) dropped. Rec. (a) while "builder to confirm" stays. Example: "AT APPROX IL 4.91m TO COUNCIL SATISFACTION".
37. **Which discharge kinds?** (a) pipe, pit, kerb; (b) add easement drain, new outfall, soak on site, existing internal system. Rec. (b) as wording only. Example: CIV-11 discharges to the existing internal system.
38. **Typed name:** keep CDLPD? Rec. yes. Example: typed 5 times in the record.

### Levels

39. **How is the top water level first chosen (Q-001)?** (a) typed by the engineer; (b) offered as the lowest cover less a margin. Rec. (a) until the owner states a rule. Example: 5.30 on the made-up job.
40. **What does "locked" do?** (a) nothing changes it without an unlock click; (b) a warning only. Rec. (a). Example: the council connection invert 4.91.
41. **Levels view for the hard case:** show (a) one run at a time; (b) the whole tree from the discharge point with the tightest branch marked. Rec. (b). Example: a high discharge invert and a back-of-site pit 40 m away.
42. **Fall arrow grade:** (a) read from two level tags; (b) typed; (c) left off. Rec. (a) when two tags are clicked. Example: FGL 5.90 to 5.80 over 4.0 m.

### Areas

43. **Area kinds:** (a) site, roof to tank, paving, permeable; (b) add roof not to a tank, balcony, untreated paving, catchment to a soakage pit or raingarden. Rec. (b). Example: the office STORM report for JOB_B has six area rows.
44. **Where the rainfall table comes from:** (a) typed per job from the Bureau; (b) held per suburb in the standards; (c) both. Rec. (a) with the last used offered. Example: 98.6 mm/h for the 1 in 10, 5 minute storm.

### Schedule and boxes

45. **Criteria box row order and wording:** (a) as JOB_C (discharge, head, orifice, top water level, required, storages, total); (b) the older order. Rec. (a). Example: the CIV-03 box.
46. **Legend:** (a) full, as now; (b) only what the job uses. Rec. (a) first. Example: the same legend block on all three studied jobs.
47. **The fixed frame (general notes, warning boxes, standard details, plan title):** (a) placed by one "start sheet" step from the library; (b) each a button; (c) left in the template. Rec. (a). Example: a plain house sheet is mostly these.
48. **May a sheet be issued with a red check?** (a) yes, with a typed reason kept; (b) no. Rec. (a) (R-35, D-003). Example: CIV-06 total 4.37 against 4.37.

### Title and issue

49. **Stages and revision names:** (a) four stamps, P1 / P2 then A, B, C, with T1.. for tender; (b) three stages. Rec. (a). Example: the public job that ran P1 to P3, T1 to T4, then A.
50. **Vertical and horizontal title strips, second sheet, part plans:** which are in Release 1? Rec. vertical strip and a second sheet. Example: JOB_A needs two sheets and three part plans.

### CE tools, Manager, standards

51. **The CE tools list (Q-015):** tick from the fourteen in check I plus the ten in CONCEPT.md. Rec. include C, QD, AD, SSC / CJ, text at pen size, DUP / DSET, LU and plot to PDF. Example: SSC run 21 times.
52. **The office rulings the standards need before any check can be built (Q-004 and more):** pipe cover (four values), pit size by depth (two tables), step iron depth (900 / 1,000 / 1,200), pervious coefficient (0.30 / 0.35), detention pipe grades, orifice constant (0.6), cover level text colour (black or red), pen for colour 4. Rec. rule each once under D-022. Example: one council's 250 cover everywhere against the standard's table.

Also still open and unchanged from OPEN_QUESTIONS.md, needed by later kinds or by Stage 5: Q-003, Q-005 to Q-014, Q-016, Q-017, and who accepts work (P-01).

---

## 5. What I could not check, and why

1. **The rendered pictures.** I read the words and the drawing code of both pages, not the pictures as a person sees them. So I cannot say whether a pit is now drawn with both wall lines, or whether a leader is drawn somewhere without being named. What I can say: no tank drawing contains an arrowhead, and no tank parts list names a leader.
2. **Draft 1 of the concept page** (`new_plugin_concept.html`) and `how_we_design_and_draw_civil.html`: not read; not asked for.
3. **The evidence files other than STUDY_D** (studies A, B, C, the interview): not read. I relied on the reference library made from them.
4. **`reference\standards\*.csv`** (layers, blocks, offsets, wording): not read row by row. The standards check in D is against CONCEPT.md's list only.
5. **The nine council files:** the register page was read in full; each council file was read by its headings and key lines only.
6. **`reference\today\INSTALL_TODAY.md`:** read by the opening of each item, plus the fragility list in full.
7. **Anything in AutoCAD.** Nothing was opened or run. Every statement about how AutoCAD commands would treat an element is an open question, not a finding.
8. **What colleagues really use.** The records count only commands the plugins wrap, are almost all from April on two PCs, and one PC may be a test account.
9. **Whether an "AGI" row of a real pit schedule carries an invert,** and the wording of the schedule's three standing notes, the tender and construction stamps: not in the evidence read.
10. **Whether the pages were edited after D-039 to D-041.** The decisions are dated the same day as the pages; I checked the pages as they are on disk now.
