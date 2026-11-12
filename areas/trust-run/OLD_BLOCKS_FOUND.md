# Old block versions found (lane trust-acad-evidence, night of 12 to 13 Nov 2026)

**Status: DRAFT evidence. Built n/a. Tested yes (read from real drawings). Installed n/a. Accepted no.**

---

# FOR TIM

1. **The old pit is called "Stormwater Pit", not "PIT BLOCK".** It is in your office block drawing (the one your tool palettes pull from) and in every old copy of the civil block library I could open (8 Feb 2022, 11 Mar 2022, a 2021 copy). It has no number or label built into it: no attributes at all. It draws on layers STORMWATER PIT, PITS HIDDEN, GRATED TRENCH (and GRATE in the old copies).
2. **CE does not call it a pit today.** CE only treats blocks named PIT BLOCK, PIT BLOCK 2 or PIT BLOCK 3 as pits (the code check in `BlockService`). A "Stormwater Pit" from your palette would be ignored by CDSYNC and the check unless the reader learns the name.
3. **There was never a pit label block in the old libraries.** The pit number and levels were ordinary text or the small blocks COVER LEVEL, INVERT and NEW LEVEL (one has an attribute, EXISTING_LEVEL). So an old job has pit number text with no block behind it. The reader must say "Unknown" or "Proposed from the nearest text", never Sure.
4. **Downpipes and tanks do carry attributes:** the old DOWNPIPE block has one, DP. The old tanks (3000 LITRE TANK, a 5000 LITRE underground tank) have one, WT, with default text "DP". The current palette master has DOWNPIPE DYNAMIC WITH MASK with no attributes, so a downpipe drawn from the new palette carries no data at all.
5. **Old pipes were blocks, not lines.** 100, 150, 225 and 300 DIA. PIPE blocks (with a text note) and "100 PIPE" lines on layer STORMWATER PIPE exist in the same drawings. This matches the old-tool findings in the reader design (a line plus text).

**What I did NOT do or could not do**

1. I did not open any job drawing and did not read the Projects folder.
2. One file, an even older 2019 backup of the civil block library, would not open (AutoCAD error 190). Not read.
3. I read block definitions only (names, layers, attributes). I did not look at what a block looks like, and I did not read the many anonymous (dynamic) block copies.
4. The palette XML files were read for the source drawing only. They all point to one block drawing (the office master) and one A1 template; none points anywhere else.

---

# DETAIL

## 1. Where it came from

1. **Palettes (office drafting folder, "Tool Palettes", including NEW and OLD TOOL PALETTES):** every civil block tool (BLOCKS CIVIL, BLOCK CIVIL 2, C BLK, CIVIL, CIVIL-Administrator, 2024 and 2026 files) takes its drawing from one office master drawing in "Drawings Templates", plus one A1 template for the title border. So the master drawing IS the palette's block library.
2. **Master drawing copy:** the 23 Sep 2026 version, 791 block definitions (336 anonymous).
3. **Old block library drawing, "Superseded Stuff\CIVIL BLOCKS":** versions dated 8 Feb 2022 (569 definitions), 11 Mar 2022 (575), and a 2021 backup (511). The 2019 backup would not open.
4. **How read:** each copy made under `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY`, exported to DXF with the AutoCAD core console (no CE plugin loaded; CE's live log did not grow), and the BLOCKS section read as text. This avoids CE's pit-swap changing the old symbols before they are seen.

## 2. The drainage blocks found (name, parts, layers, attributes)

Same in the 8 Feb 2022, 11 Mar 2022 and 2021 libraries (22 matching definitions each). The master shows the same family plus the current names.

1. **Stormwater Pit:** 45 parts (59 in the 2026 master); layers DEFPOINTS, GRATE, GRATED TRENCH, PITS HIDDEN, STORMWATER PIT (the 2026 master drops DEFPOINTS and GRATE). No attributes.
2. **PIT BLOCK 3:** only in the 2026 master: 15 parts; layers GRATED TRENCH, PITS HIDDEN, STORMWATER PIT. No attributes. (The earlier names PIT BLOCK and PIT BLOCK 2 are not in these drawings; the March 2025 palette metadata lists "PIT BLOCK".)
3. **ORIFICE PIT** (93 parts) and **ORIFICE PIT P1** (91): detail symbols on layers 18CONT, 18TEXT, 25CONT, 25DIMS, 25TEXT, 50TEXT, DEFPOINTS, GREEN, RED (P1 also HATCH EARTH and WATER TANK). No attributes.
4. **PIT 900 MAX** (72 parts): a section detail, not a plan symbol. No attributes.
5. **DOWNPIPE:** 3 parts, layers 25TEXT and DOWNPIPES; attribute DP (default text "DP"). The master also has **DOWNPIPE DYNAMIC WITH MASK** (4 parts; layers 25TEXT, DOWNPIPES, DOWNPIPES HATCH, SUPPORT DEFPOINTS), **OVERFLOW**, **GRATED INSPECTION OPENING DYNAMIC WITH MASK**, **GRATED OVERFLOW**, **GRATED SURCHARGE PIPE** (the last three on FLOOR WASTE and 25TEXT). None has attributes.
6. **Tanks:** **3000 LITRE TANK** (5 parts; layers 25TEXT, 35CONT, HATCH WATER; attribute WT, default "DP"). **POLYMASTER UNDERGROUND 5000 LITRE TANK** (5 parts; layers HATCH WATER, STORMWATER). No attribute on the 5000.
7. **Pipes:** **100, 150, 225, 300 DIA. PIPE** (8 parts each; layers 25DIMS, 25TEXT, DRAINAGE, STORMWATER PIPE), **100 PIPE** (2 parts; DRAINAGE, STORMWATER PIPE), **100 DIA CHARGED PIPE** and **100 CHARGED PIPE** (layer STORMWATER CHARGED PIPE; in the master), **PIPE INLET**, **CUT PIPE**. No attributes.
8. **Level and annotation blocks:** COVER LEVEL (1 part, layer 18TEXT), INVERT (1 part, 18TEXT), NEW LEVEL (4 parts, layers 35TEXT and 9TEXT, attribute EXISTING_LEVEL), RL LEVEL (master only: attribute RL__.__ with default "RL__.__"), OVERLAND FLOW PATH, ARROWN.
9. **Legend:** CIVIL LEGEND (229 parts) lists the layer set of the old drawings: DRAINAGE, DOWN PIPES, EX PIT, EX STORMWATER, EX DRAIN HATCH, STORMWATER PIPE, STORMWATER SUSPENDED PIPE, PITS HIDDEN, GRATED TRENCH, FLOOR WASTE, SPOON DRAIN and others. Layer names contain no client or job names.
10. **Pit label blocks:** none in any of these drawings. The only "LABEL" blocks are bracing (PT250 to PT600 LABEL on layer WALL BRACING TYPE C) and BEAM LABEL.

## 3. What this means for the reader (areas\TRUST_READER_DESIGN_12NOV.md)

1. Add "Stormwater Pit" (any capitalisation) to the names the reader recognises as a pit, as **Proposed** (symbol only, no number), not Sure.
2. Treat pit number text and cover or invert levels near an old pit as **Proposed from text** with the distance shown; two pits in reach of one text stays **Unknown**.
3. A block called DOWNPIPE with attribute DP, or a TANK block with attribute WT, can be read as Sure for its kind. The value "DP" is a default, not data.
4. The current palette blocks (DOWNPIPE DYNAMIC WITH MASK, GRATED OVERFLOW and the like) carry nothing to read; a downpipe from the new palette is a symbol on a layer only.
5. Anonymous dynamic copies (336 to 409 per drawing) were not examined; a dynamic block's visible name in a drawing is its parent name (PIT BLOCK 3 was shown as the effective name in the test copies).

## 4. Not covered

1. The PIT BLOCK and PIT BLOCK 2 original drawings (only the current PIT BLOCK 2 and 3 masters shipped with the plugin were available; the plan notes already say the oldest ones have no master).
2. The 2019 backup, the many other drawings in "Superseded Stuff", and any palette on a colleague's PC.
3. What a user dragged from the palette into real jobs over the years.

Files kept in `C:\CE_WORK\scratch\trustprobe\dxf` (DXF exports, parsed block lists): scratch only, not for any repository.
