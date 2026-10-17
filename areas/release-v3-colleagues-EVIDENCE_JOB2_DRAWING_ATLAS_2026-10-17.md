# Evidence Job 2 — CE drawing atlas across job types (17 Oct 2026)

**Status:** first complete pass finished Sat 17 Oct 2026, about 21:00 Melbourne. Read-only evidence job run headless on Tim's PC
from copies (H1: "yes"; ruling I1: harvest every detail). Generic summary only: counts, standards, lessons. No client names,
addresses or job numbers. Pictures and per-job facts are local-only (last section).

## Answer first

1. **The sample is 78 real issued jobs (not 60), all read.** 78 of 78 jobs: 685 DWG copied, 679 read, 6 could not be read
   (reasons below); 641 issued sheets read from the latest issued PDF set of each job; 5,080 drawn items harvested from those
   sheets, of which 4,526 are details.
2. **CE work is overwhelmingly one repeated house-set.** The whole Projects folder holds 1,975 job folders (2020 to 17 Oct 2026).
   Only 1,165 have an issued PDF set. Of those, about 790 are houses (new, alterations/additions, multi-unit) and 82 are basements.
   Commercial and industrial issued sets are rare (about 44 together) and are built a different way (see below).
3. **Standard vs custom: about 85% of the details on real jobs are NOT found in the library index from Job 1.** Per job, the
   median share that matches the library is 15%. Many of those are really "standard in practice" (the same title appears on 20 to 50
   of the 78 jobs) but the library index does not hold them in matching words. That is the library-candidate list below.
4. **Schedules are blocks, not AutoCAD tables.** 0 AutoCAD Table objects in 679 drawings. Schedules are inserted blocks
   (for example a two-column member schedule block and an A3 footing schedule block) plus a SCHEDULE layer used in 57 of 70 structural jobs.
5. **The architectural background is the same recipe on almost every job:** one prepared Xref drawing, attached as an overlay several
   times (one insert per level, for example site, ground over, ground under, first over, roof), each clipped, all on one XREF layer, colour
   left BYLAYER. Details in the set-up section.
6. **Civil and Structural share one drawing standard.** 36 of 78 jobs have both a Civil and a Structural DWG; the two share the same
   base layers, text style, dimension style and pen colours, and differ only in the discipline layers (service and drainage layers vs beams,
   supports and bracing layers).

## 1. Job-type counts in the whole Projects folder

Method: automatic, from the issued PDFs (the "PROPOSED ..." project line in the title block and sheet titles, plus folder-name words).
These are estimates by keyword, not a hand count. A person should spot-check before anyone quotes them.

1. **Folders in total:** 1,975 (2020: 395; 2021: 356; 2022: 357; 2023: 308; 2024: 330; 2025: 138; 2026 to date: 91).
2. **No drawings in the folder (quote or never issued):** 741.
3. **Drawings present but no issued PDF set found:** 69. **Issued PDF with no readable text (older plots):** 55, of which 30 are 2020.
4. **Alterations and additions:** 336.
5. **Single dwelling (new):** 230.
6. **Townhouses / multi-unit (including dual occupancy):** 218.
7. **Basement (house or multi-unit with a basement plan):** 82.
8. **Civil only, stormwater drainage:** 90. **Civil only, roads / subdivision / services:** 42.
9. **Commercial / community building:** 27. About 200 folder names mention pavilions, schools, childcare or similar, but most hold no issued drawings.
10. **Industrial / steel-frame building:** 17.
11. **Small elements (stairs, fences, crossovers, driveways):** 22. **Deck / small outbuilding:** 19. **Pool only:** 10. **Retaining wall only:** 6. **Other / unclassified:** 11.
12. **Types not on Tim's list that turned up:** small elements (stairs, fence plans, crossovers), pool-with-deck-and-fence sets, and
    drainage-only sets for subdivision lots. No new large job type was found.

## 2. Sample size per type (78 jobs, recent issued jobs, mostly 2024 to 2026)

1. Alterations and additions 15; single dwelling 9; townhouses / multi-unit 9; basement 9.
2. Commercial / community 6; civil stormwater 5; small elements 5; civil roads / services 4; industrial 4.
3. Deck / outbuilding 3; pool 3; retaining wall 3; other 3.
4. Larger than the "about 60" in the brief because the first keyword split was wrong (it mixed pools, fences and houses into the wrong
   types), so jobs were added to bring thin types up. Types with only 3 to 6 real jobs in the folder (retaining wall, pool, small elements, industrial) are
   covered by nearly every job that exists, so those results are close to complete for those types.

## 3. Typical sheet sets (from the issued PDFs)

1. **House set (new, alterations/additions, multi-unit): A3 landscape, median 10 to 12 sheets.** Order: general notes (sheets 1 and 2),
   ground floor footing plan, first floor framing plan, roof framing plan, footing details (1 to 3 sheets), first floor framing details
   (1 to 3 sheets), bracing details. Alterations jobs sometimes add remedial works details and a demolition sheet. Sheet numbers S01 upward.
2. **Stamp on the sheet:** "CONSTRUCTION ISSUE" on most sheets, "TENDER ISSUE" on some, "PRELIMINARY ISSUE" and "FOR COUNCIL APPROVAL" on a few.
   The stamps are layers (0-STAMP-CONSTRUCTION, 0-STAMP-TENDER, 0-STAMP-PRELIMINARY) switched per issue.
3. **Basement set: A1 landscape, median 6 sheets (range 2 to 12).** Adds a basement plan / retention and footing plan and a ground floor plan;
   the general notes and detail sheets are fewer than on a house set.
4. **Commercial and industrial: A1 landscape, one DWG per sheet** (S01, S02 ... and C01, C02 ... as separate files), 6 to 19 sheets, Structural and
   Civil issued together in some jobs. The title block is not a block in these drawings; the words TITLE and SHEET appear in 273 and 196 Xref names across the
   sample, so it arrives as an Xref or per-sheet drawing.
5. **Civil only (9 sampled): A1 sheets, 1 to 4 sheets per job in the sample.** Stormwater pit schedule appears on 31 of the 78 jobs.
6. **Small elements and retaining walls: A4 portrait notes sheets and A3 plans, 2 to 3 sheets** (one retaining-wall set is a 39-page A4 booklet).
7. **Pool: A3, 4 to 5 sheets;** general notes, pool plan, pool details, footing plan and details, pool/deck/fence footing details.
8. **One DWG, many layouts** is the rule for houses, pools, decks, small elements and most civil lot sets (median 7 to 12 layouts per file, named S01..., C01...,
   plus a few "SPARE" layouts). **One DWG per sheet** is the rule for commercial, industrial and most basement jobs.

## 4. Standard vs custom details

Method: every drawn item was read from the issued PDF (title text set in the larger size, wrapped titles joined, picture cut out for each) and compared with the
Job 1 library index by title and by words inside the detail.

1. **Harvested:** 4,526 details; with plans, schedules and notes blocks, 5,080 items in all across 74 jobs (4 jobs had nothing to harvest: lot drainage or notes-only).
2. **Matched to the library (same title and same wording, or same wording under a different title):** 691 (15%).
3. **Title is in the library but the content differs (edited standard):** 326 (7%).
4. **Not in the library index:** 3,509 (78%).
5. **Plans, schedules and notes (not counted as details):** 125 plans and 164 schedules and 45 notes blocks are also not in the library.
6. **Library candidates:** 896 distinct detail titles are not in the library. 266 appear on 2 or more jobs, 115 on 5 or more, 69 on 10 or more, 42 on 20 or more of the
   78 jobs. 630 appear on a single job (true one-offs, or the same detail worded differently). The most repeated are the footing service-penetration,
   flexible service pipe, lap splice in fabric, tree root barrier, trench adjacent to footing, double studs and joists, laminated members, temporary wall bracing,
   trench mesh lapping, timber beam to timber beam and top plate joining details. Three titles in the 10+ group are just generic words (footing type, legend, section).
7. **How good is "not in the library"?** The Job 1 index grouped details by distance, not by drawn border, so it merges and splits details. Treat 78% as an upper
   bound. The candidates are confirmed in the Monday picture cards.
8. **Details are mostly drawn once and pasted as blocks** (names like A$C... in the drawings) rather than inserted as named blocks, so no block name identifies a standard detail.

## 5. Schedules

1. **Schedule titles on the issued sheets (jobs out of 78):** member schedule 39, masonry lintel schedule 31, column base plate schedule 31,
   stormwater pit schedule 31, roof member schedule 13, screw pile schedule 10, first floor member schedule 8, soldier pile wall schedule 6, sleeper wall schedule 5.
2. **Layout:** schedules sit at the sheet side in the framing plan sheets (member schedules) or under a detail (column base plates), and as a block on the footing plan (footing schedule).
3. **Made as blocks:** a two-column member schedule block (148 inserts), an A3 footing schedule block (74), a plain member schedule block (11), a footing schedule block (6),
   a stormwater pit schedule block, a block wall schedule block. 0 Table objects.

## 6. Architectural background set-up (Xref)

1. **316 drawings carry Xref inserts.** Inserts per drawing: median 4; 78 drawings have 1 insert, 45 have 4, 38 have 5, up to 32 on the largest.
2. **Same source file, many inserts:** in 157 of the 316 drawings every insert points at one source file (the job's prepared Xref drawing); the rest use several (architect sheets, survey, title sheet).
3. **Attach type:** 96% are overlays. **Path:** 85% are relative (the job's Xref folder), the rest absolute (retaining-wall and some civil jobs).
4. **Clips:** 55% of inserts are clipped (one clip per level), and in 95 drawings every insert is clipped.
5. **Placement:** 81% are in model space, 19% in paper space (title sheets). Scale 1 and rotation 0 in nearly all (21 inserts at 0.01, 49 rotated).
6. **Layer and colour:** all inserts sit on the XREF layer, colour BYLAYER (only 5 inserts carry a colour override). Of 45,686 Xref layers seen in the host drawings, about 14% show
   a colour different from the Xref-folder file (indicative only, layers were not paired file by file). 26 drawings use per-viewport layer overrides.
7. **Level naming in the Xref block names:** words ground (374), over (207), under (155), roof (164), site (110), first (92), basement (60), mezzanine (28), elevations (95).
   Pattern: job tag, then the level, then "over" or "under" for the structure above or below that floor.
8. **The prepared Xref drawing:** 356 Xref-folder drawings read, median 54 layers with 19 used; the common layers are 0, GUIDELINES, XREF, A-ARCH BACKGROUND, A-WALL,
   A-TITLE BOUNDARY, A-WINDOW & DOOR, A-WALL HATCH, A-ROOF OUTLINE and CE text/pen layers. So it is a cleaned architect file with a few CE layers, not an empty template.

## 7. Layers, text heights, linetypes, dimension styles

1. **Layer rule:** pen width in hundredths of a mm then the use (25CONT, 25TEXT, 25DIMS, 35CONT, 50CONT, 70CONT, 18CONT, 9CONT). Colours: white 25, yellow 35, green 50, cyan 70, magenta 18, grey 9.
   Present in 59 to 70 of 70 structural jobs. Also in nearly all: 0, DEFPOINTS, BLOCKS, HATCHOUTLINE, GUIDELINES, XREF, BORDER, SCHEDULE, CLOUD, hatch layers by number (HATCH 21, 51, 11, 74, 141).
2. **Structural discipline layers:** BEAM, SUPPORT, SUPPORT COLUMN, SUPPORT DS, WALL BRACING TYPE A and B, SLAB INTERNAL BEAM, LOADBEARING WALL, SECTION TAG.
3. **Civil discipline layers:** STORMWATER, STORMWATER PIPE, STORMWATER CHARGED PIPE, DRAINAGE, SPOON DRAIN, AGI DRAIN, SEWER, WATER, GAS, TELSTRA, ELEC OVERHEAD, TREE, TPZ, SAWCUT, RETAINING WALL, EX (existing) layers.
4. **Text:** one style (STANDARD = Arial Narrow) in all; a few jobs also carry ISO (Arial Narrow), SWISS B, and Annotative or SHAPE-font leftovers. Model text heights: 250 (2.5 mm at 1:100), 350, 200, 180, 300 in nearly every job;
   structural adds 4200, 10000, 220, 500, 1000. Civil adds 700, 5000, 280 and unusual scaled values.
5. **Printed size:** A3 sheet body text 7.9 pt (2.8 mm) and 9.9 pt (3.5 mm), titles 13.9 pt (4.9 mm); A1 body 9.9 pt. Layout (paper-space) text: 1.5 mm most common, then 2.5, 4, 3.5, 5.
6. **Linetypes:** BYLAYER in 68 of 70 structural jobs; HIDDEN and HIDDEN2 used, DASHED, DASHDOT2 sparse. Civil also uses DOT, DASHDOT, CENTER2.
7. **Dimension styles:** STANDARD at scale 100 (63 of 70 structural, 39 of 44 civil), a "leader" style at scale 100 (42 structural, 10 civil), an "RS" style (23 and 9), a few scale 20/80 oddities.
8. **Drawing facts:** units millimetre, LTSCALE 1000 in 316 of 324, saved mostly in 2018 format (284), 32 in 2010 format, 5 in 2000 format. Viewport scales: 1:100 on nearly every sheet; 1:20 and 1:50 viewports not found as separate window scales
   (details are drawn in the same model space at the right size, not scaled by viewport).
9. **Plot style:** "Creative Engineering.ctb" on almost all sheets; "A3 Residential Structures.ctb" on some A1 sets (commercial, industrial, retaining wall).

## 8. Title block variants

1. **A3 sheet:** 308 sheets in 32 jobs carry the full label set (project, client, drawing, design, drawn, checked, approved, scale, issue date, revision, reference, drawing number) and the "CE A3 TITLE SHEET" block.
2. **A1 sheet:** 151 sheets in 34 jobs show a shorter label set; 74 sheets in 16 jobs show no readable labels (outlined or a different block).
3. **Older "RS" title block and plot style:** "RS TITLE SHEET" / "RS A3 TITLE SHEET" blocks still turn up in house, civil and retaining-wall jobs.
4. **A4 portrait (595 x 842 pt) and US letter (612 x 792) variants:** 82 sheets in 4 jobs and 6 sheets in 3 jobs.
5. **Title text is paper-space MText** (2.5 mm) on the layout, not attributes in the block: only 5 of 963 layouts read carry block attributes.

## 9. Civil versus Structural in the same set

1. **DWG:** 36 jobs have both; 34 have Structural only; 8 have Civil only.
2. **Issued PDF:** 43 Structural only, 16 Structural plus Civil, 12 Civil only, 7 other.
3. **Shared:** 24 layers are in at least half of the jobs with both (the 25/35/50/18 text, dimension and continuous layers, XREF, GUIDELINES, HATCHOUTLINE, BLOCKS, DEFPOINTS).
4. **Different:** the discipline layers above; civil adds a separate civil title text layer and a larger range of dashed/dot/centre linetypes; structural has a "TIM LEADER" dimension style more often.
5. **Both disciplines use the same A3 or A1 title block, text style, units and ctb** in the jobs read, so Civil and Structural can share one house standard.

## 10. What could not be read, and why

1. **6 DWG:** 5 "drawing needs recovery" (auto-recovery style copies) and 1 "bad drawing header". Each job still had its other drawings read.
2. **741 folders hold no drawings** and 69 hold DWG but no issued PDF; nothing could be classified or read for these. 55 issued PDFs have no readable text (mostly 2020 and 2021); they were counted but not classed.
3. **Architectural PDFs and the architect's own CAD files** were not read (very large, not CE output). Only the prepared Xref drawing and the Xref insert settings were read.
4. **Superseded revisions, Engineering (computations, markups, soil reports), Admin and Certification folders** were not read.
5. **93 pages of A1 commercial and industrial sets** were too dense for the picture cutter (over 30,000 vector paths); sheet facts were read but the detail pictures for those pages are text-only crops.
6. **Per-detail DWG harvest was not used.** Details are pasted as anonymous blocks inside model space and are not separated by a border, so the issued PDF was the reliable source. Detail pictures are cut from the issued sheet and some are cropped imperfectly.
7. **Library match is by wording,** not by a person's look.
8. **PDFs over 40 MB were not copied** (none were in the harvested sets).
9. **Job type and sample choice are keyword-based** and have not been checked by a person.

## 11. Where the local-only material lives (never in a repo)

1. **Progress file:** `C:\ce_evidence_local\atlas_progress.json` (one entry per job; restart resumes).
2. **Per-job facts and everything client-identifying:** `C:\ce_evidence_local\job2\` (catalogue of all 1,975 folders, classified job types, sample list, copies of the 78 jobs' drawings and PDFs, raw reads, matches).
3. **Picture atlas:** `C:\ce_evidence_local\atlas_pictures\` with one folder per job type: a typical sheet set picture, the most repeated unmatched details, every harvested detail picture and every sheet picture;
   plus `_library_candidates\` (contact sheets of the 145 repeated library candidates, 24 per page).
4. **Library candidate list with job counts:** `C:\ce_evidence_local\job2\library_candidates.json`; every detail with its match status: `details_matched.json`.

## 12. What this did NOT cover

1. Nothing here has been shown to Tim. The atlas is ready for the Monday 26 Oct 08:40 session (about 20 minutes: one sheet-set picture per type, then the candidate sheets).
2. No AutoCAD behaviour was driven; this is reading of finished drawings only. Nothing is built, tested, installed or accepted by this job.
3. Pen weights and colours were read from the drawings, not checked against a printed sheet.
