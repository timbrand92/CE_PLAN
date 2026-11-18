# CLEAN / CN: what it does today, step by step

**Revision:** 1 (Wed 18 Nov 2026, afternoon, Melbourne time). IDs: CL-01 onwards, never reused.
**Why:** CLEAN is the first shared tool (TA-014, D-201). Tim: "I USE THIS COMMAND VERY OFTEN AS THE MAIN TOOL FOR SAVING THE DRAWING SO WE NEED TO WORK OUT HOW THIS WORKS AND CAN BE REPLICATED QUICKLY AND OFTEN" (TA-007).
**Read from (read only, nothing run):**
1. **The old Structural program:** `CleanPipelineService.cs` at `origin/claude/rel-20261114a`.
2. **The original LISP:** `SAVE OP.lsp` in the shared drafting folder, "TIM EXPORT" sub-folder.

They do the same steps in the same order.

**Not measured:** how long each step takes on a real drawing. AutoCAD was not opened.

## Today's steps, in order

1. **CL-01 Purge.** Runs AutoCAD's PURGE with All, every name, no asking (the same as typing -PURGE, A, *, N). Every unused block, layer, style and linetype goes, including office ones not yet used in that drawing.
2. **CL-02 Xrefs onto the XREF layer.** Every placed Xref is moved to layer XREF (colour 7, continuous), which is made if missing. This is today's XRL.
3. **CL-03 Text style.** Style STANDARD is set to Arial Narrow (ARIALN.TTF), height 0, width 1, no slant. Every text and multiline text in the drawing and inside blocks is moved to STANDARD. Other styles are kept, not deleted, and attributes are left alone. This is today's MTS. (Left out by FASTSAVE.)
4. **CL-04 ByLayer.** Left out by FASTSAVE. It does four things:
   - **Current settings:** colour, linetype and lineweight for new objects are set to ByLayer.
   - **Dimension and multileader styles:** every one has its colours, lines and lineweights set to ByLayer.
   - **Objects already drawn:** every dimension, leader and multileader is forced to ByLayer.
   - **Hatch default:** the next hatch is set to SOLID on HATCH 21, ByLayer. Hatches already drawn are not touched.
5. **CL-05 Regenerate all.** REGENALL.
6. **CL-06 Save.** Saves with the plug-in's own save, falling back to QSAVE. It skips saving if the drawing is a recovery or autosave copy, and says so.
7. **Around all of it:**
   - **One undo step:** one U undoes the whole CLEAN.
   - **Settings put back:** command echo and regen mode are restored after.
   - **Report:** about ten lines on the command line: before and after counts, each step's time, the save result.
8. **FASTSAVE:** a second command doing CL-01, CL-02, CL-05 and CL-06 only.

## Added by Tim for the new CLEAN (TA-035, TA-020)

1. **CL-07 Audit:** find and fix drawing errors.
2. **CL-08 Zero stray Z heights:** flatten objects that have a height by mistake.
3. **CL-09 Set the drawing units.**
4. **Typed names:** CLEAN, short name CN.

## The new CLEAN / CN, as Tim ruled it (TA-077 to TA-087)

Typed as CLEAN or CN. One command only: FASTSAVE is dropped (TA-087).

1. **Purge (CL-01):** everything unused EXCEPT the office layers, blocks and styles the CE tools use (TA-077).
2. **Xrefs onto XREF, colour 7, continuous (CL-02):** as today (TA-081).
3. **Text style (CL-03):** all text and multiline text to STANDARD, Arial Narrow, as today (TA-078).
4. **ByLayer (CL-04):** as today. CN no longer resets the hatch default; OFFICEHATCH remembers the last pick (TA-079).
5. **Audit (CL-07):** find and fix errors, on every CN (TA-083).
6. **Flatten (CL-08):** Tim's own method, his "3D to 2D" button that moves everything up 1e99 and back down (TA-082). It applies to:
   - this drawing, including locked and frozen layers, which are put back after;
   - the lines inside blocks;
   - each Xref's own file, opened, flattened and saved by CN with a backup copy first (TA-085, TA-086). This is the only step that changes files other than the open drawing. Before it saves, it checks the file is not read-only or open by someone else.
7. **Units (CL-09):** set to millimetres if they are not, and the report says so (TA-084).
8. **Regenerate all (CL-05),** as today.
9. **Save (CL-06):** as today, including skipping recovery and autosave copies.
10. **Around it:**
    - **One undo step:** for this drawing. An Xref file that was saved cannot be undone by U; its backup copy is the undo.
    - **Settings put back:** as today.
    - **Report:** ONE line, for example: "CLEAN: purged 14, Xrefs 2 to XREF, 38 texts to STANDARD, audit 0 errors, flattened 37 (1 Xref file), units OK, saved 1.8 s". The full detail goes to the log (TA-080).

**Not decided yet:** the time limit for CN on a big job. This is for `stage6\PERFORMANCE.md`; Tim has not ruled it.
