# CE Blocks palette — command card, DRAFT for Tim's OK (24 Sep 2026)

**Why:** Tim, 24 Sep (verbatim): *"LETS GO WITH OPTION A FOR CE BLOCKS"* (proposal:
`04_REFERENCE/TOOL_PALETTES_PROPOSAL_2026-09-24.md`). **Status:** APPROVED by Tim 24 Sep 15:00 (all three recommended answers, decision file).
Classification: **Missing** (today the palettes are AutoCAD tool palettes imported by hand into each profile).

## 1. What it does on the drawing

1. `CEBLOCKS` (and a button on the CE, CE STRUC and CE Tools tabs) opens one docked **CE Blocks** palette.
2. It shows Tim's **twelve groups in his order**, read from his palette files in
   `Creative Engineering - Drafting\Tool Palettes\NEW`, so re-arranging a palette there changes CE Blocks too.
3. Click a block: it goes in **exactly as the palette does today** (section 2), read from the office block drawing.
   The office drawing is only ever read, never opened for editing or saved.
4. **One AutoCAD Undo per insert.** Escape during placement leaves the drawing unchanged. A locked target layer is
   named on the command line and nothing is inserted there.
5. If OneDrive has not synced the block drawing yet, the palette says so in one plain line and stays usable.
6. Both lanes: 2027 and 2022-2024.

## 2. What the palettes do today (every one of the 307 tools read, 24 Sep)

1. **Groups (block tools / entries):** Blocks Civil 34/46, Block Civil 2 34/46, Framing 19/22, Ground 16/20,
   Hatches 33/35, Labels Civil 24/30, Notes 18/22, Sched 18/24, Steel 37/43, Text 31/33, Timber 27/31, Walls 16/19.
   The rest are dividers and headings, kept as dividers.
2. **Layer:** every tool inserts on **its own stored layer** (made if missing). None use the current layer.
3. **Linetype** ByLayer on all; **colour** ByLayer on 300, the other 7 (Framing: C1, C1-R, DS1, TS1, TS1-R, PC1-R,
   P1-R) keep their stored colour.
4. **Scale:** a **fixed factor per tool**, not tied to the drawing scale (none are annotative). 278 at 1; 29 at
   another factor (e.g. Ground slab thickness x100, Walls x5, 14 leader-text blocks x0.2).
5. **Rotation:** 0 on 304; Ground's T-BRACKET 90, FOOTING 90, SCREW PILE 45. Some tools ask for rotation on insert,
   some explode after insert, per palette, as stored.
6. **Sources:** 296 of 307 from `Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg`; two Steel tools
   point into `Superseded Stuff` (they keep working; flagged on the palette tidy-up list).
7. "Block Civil 2" is named "BLOCKS CIVIL" inside: CE Blocks shows it as **Block Civil 2** (its file name).

## 3. How it is built (for the builder)

1. **Owner: CE Manager** (the CE Tools plugin every colleague has). Not CE_SHARED: that library has one shared
   identity between Civil and Manager and Structural does not load it. The CE and CE STRUC ribbon buttons run
   Manager's `CEBLOCKS` command.
2. Reuse: palette hosting (`Modules/Drainage/Services/InspectorPaletteService.cs`,
   `Modules/Structural/UI/Palette/PaletteManager.cs`), the read-only side-drawing block load (`BlockService.cs`,
   `WaterTankPlanBlockSource.cs` and the CDWT picker), the office-path resolution for this same drawing
   (`Modules/Structural/Services/CeInstallPaths.cs`).
3. Pictures: the palettes' own thumbnails first (they exist, 64 px); live previews (PROBE-75 method) later.
4. Settings page (R-00): the palette folder and the block drawing path.

## 4. Tim's AutoCAD checklist (after build)

1. `CEBLOCKS`: the palette docks and shows the twelve groups in the same order as your tool palettes.
2. Steel group, click WELD VERT: it lands on layer WELDING at the same size as from your old palette.
3. Ground group, SCREW PILE: it goes in at 45 degrees, as today.
4. Press Escape while placing: nothing is added. After an insert, one U removes it.
5. Freeze or lock the target layer of a block and insert it: the command line says why nothing went in.
6. Repeat 1 and 2 in AutoCAD 2024.

## 5. Questions for Tim

1. **Keep every block exactly as the palettes insert it today** (own layer, own fixed size, rotation and explode as
   stored)? **Recommended: yes** — nothing changes for anyone's hands.
2. **Pictures:** use the palettes' own small thumbnails first, sharper live pictures later? **Recommended: yes.**
3. **Where:** one CE Blocks palette, opened from a button on all three CE tabs? **Recommended: yes.**

## 6. Tim's answers (24 Sep 15:00)

1. Yes, same as today. 2. Yes (thumbnails first). 3. Yes (all three tabs).
