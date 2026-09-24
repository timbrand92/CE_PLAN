# Structural weld mark — command card (24 Sep 2026)

**Status:** behaviour APPROVED by Tim 24 Sep about 11:58 (*"A"*, decision file). One measurement outstanding before
code (section 3). Classification: **Missing**.

## 1. What it does on the drawing

1. **Pick a welded edge:** a line, a polyline segment or an arc (or two points).
2. **Pick the side** the ticks go on.
3. CE's weld-run mark is drawn along that edge: a row of parallel diagonal ticks, the look of CE's own
   **WELD VERT / WELD HORIZ** blocks (STEEL tool palette), at any length and angle.
4. **Layer WELDING** (made if missing; an existing layer keeps its own colour and linetype). The drafter's current
   layer is put back afterwards (BUG-169 rule).
5. No arrow, reference line, tail or text (Tim: "JUST THE SYMBOL"). Weld sizes stay in CE's notes.
6. **One AutoCAD Undo.** Escape at any pick leaves the drawing unchanged. Locked layers and Xref content are refused
   and named on the command line. Enter repeats the command.
7. **Settings page (R-00):** tick length, spacing and angle, layer name. Defaults = CE's WELD VERT block, measured.
8. **Both lanes:** 2027 and 2022-2024.
9. **Ribbon:** CE STRUC tab, Steelwork, with a picture of the tick run.

## 2. Tim's AutoCAD checklist (after build)

1. Draw a 1 m line. Run the weld mark, pick the line, pick above it: ticks along its full length, above, on WELDING.
2. Repeat on a 30-degree line and on an arc: the ticks follow the edge.
3. Put the result beside an inserted WELD VERT block at the same scale: same tick size, spacing and angle.
4. Press Escape at the side pick: nothing drawn, your layer unchanged. One U after a finished mark removes it.
5. Repeat step 1 in AutoCAD 2024.

## 3. Outstanding before code

1. **Measure CE's WELD VERT and WELD HORIZ** (tick length, spacing, angle, lineweight, colour) from
   `Creative Engineering - Drafting\Superseded Stuff\SILVIAS SELECTION steel DETAILS.dwg`, read-only, headless, after
   17:30 or on the Test Station. Record the numbers here.
2. The block's source drawing sits in "Superseded Stuff": on the tool-palette tidy-up list (`04_REFERENCE/TOOL_PALETTES_PROPOSAL_2026-09-24.md` section 3).
