# Evidence Job 1 — CE detail library catalogue (17 Oct 2026)

**Status:** read-only evidence job, run headless on Tim's PC from copies (H2: "i want to start building the library").
Generic summary only. The index and picture atlas are local-only (last section).

## Answer first

1. **Every DWG was read or listed with a reason.** 218 DWG copied and scanned: 204 read, 14 could not be read (all 14 are
   AutoCAD auto-recovery copies or one damaged file; reasons below). Zero silent skips.
2. **The library is real and big, but it is not yet a library.** The 45 current readable Standard Details drawings hold
   about 1,558 separate drawn frames (details, notes blocks, tables, schedules). Only about 271 carry a "SCALE 1:xx" label.
   Nothing is indexed, numbered or tagged today: the drawings are working files, not a catalogue.
3. **Civil and Structural details do not overlap in wording.** One Civil frame matches one Footing frame word for word; no
   Civil title appears in a Structural folder. They overlap in topic (see below), not in content.
4. **The office drawing standard is consistent and easy to describe:** one Arial Narrow font, model space in millimetres,
   2.5 mm text at 1:100 (250 drawing units), colour-per-pen-width layers, one dimension style family.
5. **Biggest waste: duplicates.** 211 groups of identical frames (444 frames), mostly the same detail pasted into several
   drawings. Six groups cross folders.

## What was scanned

1. **Source:** the office Standard Details folder and the Drawings Templates folder (copies only; nothing written to the
   office folders; 6 drawings had AutoCAD lock files, so someone may have had them open; only copies were opened).
2. **On disk, Standard Details:** 187 DWG, 9 DXF, 16 PDF. **Copied and read:** 107 DWG outside the top-level
   `0_SUPERSEDED` folder, plus 111 template DWG = 218. The 80 DWG inside `0_SUPERSEDED` were listed only, as the brief says.
3. **Split of the 107:** 47 current drawings and 60 inside older "Superseded" sub-folders of the category folders.
4. **DXF and PDF:** copied (10 DXF, 14 PDF) but not content-read; they are not DWG. Listed here as not analysed.
5. **Method:** a small read-only reader (AutoCAD core console 2027, side-database read, no plugin loaded) pulled layers,
   linetypes, text styles, dimension styles, blocks, layouts, extents and all model-space text. A second pass grouped
   geometry into frames (items within 250 mm of each other) to find each detail. One PDF plot per frame, rendered to PNG.

## Counts per category (current drawings; frames = drawn blocks of 12+ items)

1. **Footing Details:** 10 current drawings (9 readable), 39 superseded; 559 frames; 132 scale labels.
2. **Civil:** 9 drawings; 416 frames; 81 scale labels.
3. **Swimming Pool Details:** 3 drawings; 336 frames; 18 scale labels.
4. **Framing and Bracing Details:** 2 current, 8 superseded; 126 frames; 2 scale labels.
5. **Retention and Suspended Slab Details:** 6 current, 13 superseded; 47 frames; 9 scale labels.
6. **Alterations and Additions:** 2 current (1 readable); 19 frames; 5 scale labels.
7. **Block, Fence and Retaining Wall Details:** 3 drawings; 15 frames; 9 scale labels.
8. **Industrial and Commercial:** 6 drawings; 15 frames; 9 scale labels.
9. **Stairs:** 2 drawings; 15 frames; 5 scale labels.
10. **Custom:** 1 drawing; 7 frames. **Top level (custom, job-specific, computation sheet):** 3 drawings; 3 frames.
11. **Templates (readable, current):** 26 drawings; 61 frames. 84 more template DWG sit in Superseded folders (read for
    headers and standards only).

**Counting caveat:** "frames" overcount (a table or a stray note can split into pieces) and "scale labels" undercount
(framing, retention and basement drawings mostly have no scale text in model space; scales may live in viewports).
The honest range for "how many details" is roughly 271 to 1,558; a hand count of one drawing would settle it.

## Office standards found (45 current Standard Details drawings; templates agree)

1. **Units and scale:** 37 of 45 in millimetres, 8 with units "Undefined". LTSCALE 1000 in 42, 200 in 3. Details are drawn
   1:1 in model space and labelled 1:20 (186 labels), 1:10 (36), 1:100 (24), 1:50 (23).
2. **Text:** every drawing has an Arial Narrow style (standard) and 31 also have an "iso" Arial Narrow style. Most common
   heights: 250 (about 12,300 texts), 180 (about 2,600), 350 (about 1,200), 200, 300, 500. Eleven drawings still carry an
   ISO3098B shape-font style and 15 carry an Annotative style, so the font standard is not 100% clean.
3. **Dimension styles:** the office style (text 2.5, arrow 3, overall scale 100, 0 decimals) is in 38 files; the plain
   Standard style in 35; a leader style in 34; a dot-arrow leader style (arrow 1.5) in 27; a one-decimal variant in 28 with
   scale 50 and 100 versions. 15 drawings carry a stray Annotative dimension style sized 0.18 (not millimetre-sensible).
4. **Layer naming = pen width:** the number prefix is the pen width in hundredths of a millimetre, set by colour.
   White 25 (0.25 mm), yellow 35, green 50, cyan 70, magenta 18, grey (colour 9) 9. Suffix is the use: CONT, TEXT,
   DIMS, HIDDEN, HIDDEN2, DASHED. All lineweights are "ByLineWeightDefault", so printed weight depends entirely on the
   colour-based plot style file. Layers in every drawing: 0, DEFPOINTS, 25TEXT, 25DIMS, 35CONT. Near-universal:
   25CONT, 18CONT, 50CONT, 50TEXT, HATCH 21, BLOCKS, GUIDELINES (non-plot), HATCHOUTLINE (non-plot), 35TEXT.
5. **Layers per drawing:** 11 to 145. Several drawings carry far more layers than the convention needs (leftovers from
   pasted sheets).
6. **Linetypes:** HIDDEN and HIDDEN2 in 44/43 files, DASHED 38, CENTER2 and DASHDOT2 33; the "2" variants are the
   scaled set. CENTER, PHANTOM, DOT families are also loaded.
7. **Blocks:** 341 distinct named blocks across the drawings; 825 dynamic-block definitions counted across files.
   Most shared: dot marker, section tail and flag, section title, wall blocks (stud, brick, 190 and 140 block), dowel bar,
   drawing border, shadow box.
8. **Drawing versions:** 23 of 45 saved as AutoCAD 2010 format, 22 as 2018 format. Templates: 21 of 26 are 2018 format.
9. **Templates:** A1 and A3 sheet templates (A3 structural sets carry 14 to 18 layouts), a typical blocks/layers/schedules/
   notes drawing (455 blocks, 188 layers), six xref background templates (90 layers each), civil sheet templates (92 to 240
   layers), basement sheet set (S01 to S06). Template layers add north arrow, construction and tender stamps, XREF,
   WIPEOUT, SUPPORT DS.

## Duplicates and near duplicates

1. **Exact duplicate frames** (same wording, same item count, same size): 211 groups, 444 frames. 32 groups are inside one
   drawing; 179 are copies across different drawings.
2. **Across category folders:** 6 groups: Custom with Footing (four), Alterations and Additions with Footing (one),
   Industrial and Commercial with Retention (one).
3. **Near duplicates** (same wording, different geometry or size): 20 groups, 45 frames; none cross folders. These are the
   cases where the same detail was edited in one place and not the other, and need a human pick.
4. **Whole files:** no two drawings are byte-identical. 15 groups share a base name between a current and one or more
   superseded versions (including machine-name copies such as "-DESKTOP-xxxx"). Two current Swimming Pool drawings, two
   current Footing drawings and the two Alterations and Additions drawings share a base name and need checking for which
   is the live one.

## Civil / Structural overlaps

1. **Wording overlap:** effectively none. 1 frame outside Civil matches a Civil frame word for word; 0 titles match.
2. **Topic overlap (keyword scan, indicative):** 128 frames outside the Civil folder mention drainage terms (98 in Swimming
   Pool Details, 20 in Footing Details, 5 in Retaining Wall, a few elsewhere): pool and footing drainage, agricultural
   drains, downpipes. In the other direction, 182 of the 416 Civil frames (44%) mention structural terms (concrete,
   reinforcement, footings, block walls, steel), mainly the water tank, pit and retaining details.
3. **Implication for one library:** the category split today is by trade of the drawer, not by what the detail is.
   A single library tagged by element (pit, tank, footing, wall, stair, roof) would remove the Civil/Structural boundary
   for most of these.

## Anything odd

1. **Frame splitting:** the atlas shows some frames with stray text from a neighbouring detail or a clipped title,
   because frames are grouped by distance, not by a drawn border. Treat the atlas as a browse aid, not a final crop.
2. **Large pasted images and shape-font text** appear in some drawings (orange sheet-reference text and reference-file
   names inside civil frames), i.e. leftovers from job sheets.
3. **Units "Undefined"** in 8 drawings and the stray Annotative styles are the only visible technical drift in the standard.
4. **Details without scale labels** are common in framing, retention and basement files; scale is not machine-readable
   there.
5. **6 frames could not be plotted** (the core console reports "Invalid Window" for them; they sit at far-out model
   coordinates). They are in the index with no picture.

## Could not read (14 DWG, with reasons)

1. **13 files named like auto-recovery copies:** reason "drawing needs recovery" (eDwgNeedsRecovery). 3 of these are in
   current folders (one Alterations and Additions drawing, one Footing Details drawing, one basement sheet template);
   10 are in Superseded folders.
2. **1 file in a Superseded Footing folder:** reason "bad drawing header" (eBadDwgHeader), i.e. damaged.
3. **Not attempted:** a full recovery of these 14 (opening them for repair writes to the copy only and is cheap to do on
   request). The current ones likely have a healthy twin: the recovered copies share a base name with a readable file.

## Where the local-only material lives (never in a repo)

1. **Folder:** `C:\ce_evidence_local\job1\` (outside every repo, not pushed).
2. **`index.json`** (8 MB): per drawing, every layer, linetype, text style, dimension style, block, layout, plus every frame
   with its size, wording sample, scale label and picture path.
3. **`atlas_png\`**: 1,613 pictures, one per frame (plotted monochrome through the standard core-console PDF plotter,
   rendered at 80 dpi). **`atlas_sheets\`**: 166 contact sheets (12 pictures per page, titled) for flipping through.
4. **`src\`**: the copies that were read (518 MB). **`analysis1..5.txt`**: raw summaries behind this note.
5. **Tooling kept local:** the reader and plot scripts are throwaway files outside every repo; no plugin code was loaded,
   no bundle, settings or office file was touched. The shared AutoCAD isolation folder gained plotter files copied from the
   user profile so the core console could plot (read-only copy of printer configs, no setting changed).

## What this did NOT cover

1. DXF and PDF content (not read), the 80 DWG in the top-level `0_SUPERSEDED` folder (listed only), and any viewport scale
   set in paper space.
2. "Same detail" is judged by identical wording and size, not by a human look; near duplicates need a person.
3. Nothing here has been shown to Tim yet; the contact sheets are ready for the 26 Oct session if wanted.
