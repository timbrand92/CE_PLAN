# Office tool palettes in the CE plugin — proposal for Tim (24 Sep 2026)

**Why:** Tim, 24 Sep about 11:10 (verbatim): *"I HAVE A FULL SUITE OF TOOL PALETTE WHICH WOULD BE GREAT IF THIS WAS
INCLUDED IN OUR PLUGIN SOMEHOW THINK ABOUT IT FIRST"*, folder `Creative Engineering - Drafting\Tool Palettes\NEW`.
**Status:** Option A chosen by Tim 24 Sep. Nothing built. Not a Tuesday item.

## 1. What the suite is (read-only helper, 24 Sep; nothing opened in AutoCAD)

1. **12 palettes, 371 entries, 2.1 MB:** Blocks Civil (46), Block Civil 2 (46, but named "BLOCKS CIVIL" inside, so
   the two collide), Framing (22), Ground (20), Hatches (35), Labels Civil (30), Notes (22), Sched (24), Steel (43),
   Text (33), Timber (31), Walls (19).
2. **307 real tools, all block inserts.** The rest are dividers and headings. No commands, no macros, no LISP.
3. **Five source drawings only.** 296 of the 307 blocks come from one office drawing:
   `Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg`. One set points into a "Superseded Stuff" folder.
4. **Paths are portable** (`%UserProfileFolder%\Creative Engineering\...`), so they work on any PC where OneDrive
   puts the office folders under the user's own profile, the same way as on Tim's.
5. **Ten of the twelve were exported from an older AutoCAD;** Framing and Ground are from 2027.
6. **How it is loaded today:** imported by hand into each AutoCAD profile (Tim's 2027 profile holds them as imported
   palettes; no shared palette folder is set).
7. **An older copy** sits at `C:\Lisp Files\ACAD TOOL PALETTES` (11 of 12 identical in size). Never package from it.
8. **The plugin has nothing for palettes yet.** `docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md` already lists it as a
   future task.

## 2. The two ways to do it

1. **A — a CE Blocks palette inside the plugin (recommended).**
   A CE palette, docked like the Inspector, reads the blocks straight from the office block drawing on OneDrive, in
   Tim's twelve groups and order (read from the palette files). Click a block and it inserts on the right layer, at
   the drawing's scale, ByLayer.
   - **Why:** one source of truth. Update the office drawing once and everyone has it tomorrow, with nothing to
     re-export or re-import. It works the same on 2022 to 2027, and nobody's AutoCAD setup gets touched.
   - **Cost:** a real build (palette window, block previews, insertion), a few days. The block-preview method is
     already proven (PROBE-75).
2. **B — the plugin loads your existing palettes into each colleague's AutoCAD.**
   On first start, the plugin imports the twelve palette files into that person's AutoCAD, so they look exactly as
   they do for Tim.
   - **Why:** quick, and it looks the same as today.
   - **Cost:** it writes into each person's AutoCAD setup; any change needs a re-export and re-import everywhere; the
     older exports and the name clash come along; no smarts on insert.

## 3. Before either

1. Fix the name clash (Block Civil 2 is named "BLOCKS CIVIL" inside).
2. Move the tools that point into "Superseded Stuff" onto a live drawing, or drop them.
3. Tim decides whether the older `C:\Lisp Files\ACAD TOOL PALETTES` copy can go (not deleted by any chat).

## 4. Tim's answer

24 Sep about 11:40 (verbatim): *"LETS GO WITH OPTION A FOR CE BLOCKS"*. Next: a command card for the CE Blocks palette (review gate). Not a Tuesday item.
