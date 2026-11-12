# TOOL NOTE: Move one label or arrow (CDANNOTATIONEDIT)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Moves, rotates, mirrors or flips one piece of text or one block** you pick: a pipe label, level text or flow arrow.
2. **Updates CE's link** for that item afterwards so it stays attached to its pipe.
3. **One item per command.**

## 2. What it changes in the drawing

1. **The one item you picked:** moved, rotated about a point, mirrored about a line, or turned 180 degrees about its own centre (Flip).
2. **CE's record of that item** is rewritten, even after Esc at a point question.
3. **No whole-drawing record update.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **A pit or downpipe block:** "That is a CE pit or downpipe block. Use CDEDIT."
3. **An item on a locked layer** (checked before any point is asked): "Layer "X" is locked, so CE left that label (and anything else on that layer) as it was. CE never unlocks a layer: unlock it and try again if it should change."
4. **A callout (leader) cannot be picked;** only text and blocks.
5. **Does not check the item is a CE label.** Any other text or block (a title block, an Xref) can be moved.

## 4. What it asks you, and what Enter means

1. **"Select annotation to edit (invert text, pipe text, arrow)":** a wrong pick says "Select an MText, DBText, or block entity." Esc ends.
2. **"Action [Move/Rotate/mIrror/Flip]"** (Move offered as default): what Enter does here is not known from the code.
3. **Move:** "Base point", then "Destination point".
4. **Rotate:** "Rotation base point <x,y>" (Enter = the item's centre), then "Rotation angle".
5. **Mirror:** two points of the mirror line.
6. **Flip:** no question.
7. **Esc at a point** ends; the item is not moved, but its link record is rewritten unchanged.

## 5. When it says Unknown or "needs checking"

1. **Not applicable.**

## 6. How to undo it

1. **U once.** Separate steps inside one command. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **Moves any text or block,** not only CE labels.
2. **The ribbon tooltip says "Slide / Offset / Flip / Reset"**, but the command offers Move, Rotate, Mirror and Flip.
3. **Flip can leave text upside down** (the slide and offset tool turns flipped text to read; this one does not).
4. **Never marks the label as placed by hand,** so Tidy labels can move it again (BUG-879, filed under CDTIDYLABELS).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.2, 2.1, 2.2:** `Commands\AnnotationEditCommand.cs:24`, `85-101`, `116-178`; `Services\LinkService.cs:1174`; `Services\LinkService.Persistence.cs:1075`.
2. **2.3:** no record update call in `AnnotationEditCommand.cs`.
3. **3.1:** `AnnotationEditCommand.cs:31`; `Services\DrawingSafetyService.cs:61-131`.
4. **3.2:** `AnnotationEditCommand.cs:54-58`; `Services\CommandWording.cs:10`.
5. **3.3:** `AnnotationEditCommand.cs:63`; `Rules\LockedLayerRecordWriteRule.cs:219-220`.
6. **3.4, 3.5, 7 new 1:** `AnnotationEditCommand.cs:36-41` (allowed types), `54` (only block test).
7. **4.1 to 4.7:** `AnnotationEditCommand.cs:36-38`, `71-80` (AllowNone false with a default), `116-162`, `174-178`, `101`.
8. **6.1:** `AnnotationEditCommand.cs:85-101`.
9. **7 new 2:** `Services\CeCvlRibbonContributor.cs:194`. **7 new 3:** `Services\LinkService.PipeAttachmentActions.cs:328` (not called here). **7 new 4:** `Services\LinkService.SegmentAnalysis.cs:278`.
10. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:58. Nothing was run in AutoCAD.
