# TOOL NOTE: Check this drawing, read only (CDCHECKCURRENT)

**Core since:** not yet (holds the "Check this drawing" button until that is built)
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Reads CE's saved record for this drawing and lists what it finds** in a palette, "CE Civil - What CE Found", Drawing Check tab.
2. **Counts** pits, water tanks, pipes, slabs and raingardens from the record.
3. **Flags** recorded pits or pipes whose drawn object is gone, open pipe ends, and pipes that may not fit their pits.

## 2. What it changes in the drawing

1. **Nothing in the drawing or CE's record.** It reads only, and compares the drawing's "changed" flag before and after: it says "Nothing has been changed in the drawing." or that the drawing changed while it was checking.
2. **Not drawing changes:** "Show selected" changes the selection and the view (your selection comes back when the palette closes, unless you changed it); a shaded overlay is shown on screen, not saved; attached Xref drawings are read from disk into memory.
3. **No record update** of any kind.

## 3. What it will not do

1. **Does not count pits or pipes that are drawn but not in the record.** It reads the record, not the drawing.
2. **Looks at Model Space only.**
3. **No start-up checks:** it runs on a read-only drawing, during REFEDIT and in a Structural drawing. As it only reads, that is harmless.
4. **Pits marked "To be removed" are counted** (the Pit Schedule leaves them out).
5. **A recorded pit or pipe with a blank link is never flagged** as missing.

## 4. What it asks you, and what Enter means

1. **No command-line questions.**
2. **"Pick a shaded surface area"** (palette button): Esc or Enter hides the overlay and says "Surface review closed. Nothing has been changed."
3. **The palette has no OK or Cancel;** close it when done.

## 5. When it says Unknown or "needs checking"

1. **Record unreadable, no record, no attached drawings, Xref not available:** each has its own line in the palette.
2. **Pipe-to-pit fit:** uses clearances from Settings that are marked not yet confirmed.

## 6. How to undo it

1. **Nothing to undo.**

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **Pits marked "To be removed" are counted.**
2. **Blank links are never flagged.**
3. **A Settings switch** (off by default) makes this button open the newer checks list instead.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1:** `Commands\CheckCurrentDrawingCommand.cs:20-34`; `Services\DrawingCheckPaletteService.cs:34, 68, 79`.
2. **1.2:** `Services\CurrentDrawingCheckService.cs:404-408`, `699-707`.
3. **1.3:** `CurrentDrawingCheckService.cs:384-395`, `413-471`.
4. **2.1:** `CurrentDrawingCheckService.cs:71-76`, `191-193`, `246`, `589-612`, `651-662`.
5. **2.2:** `DrawingCheckPaletteService.cs:164-173`, `203-211`, `311-393`; `Services\SurfaceEvidenceSourceCacheService.cs:20-60`.
6. **2.3, 3.3:** no `CommandPreFlight`, record update or bind in `CheckCurrentDrawingCommand.cs` or `CurrentDrawingCheckService.cs` (its own note at `19-20`, `577-578`).
7. **3.1:** `CurrentDrawingCheckService.cs:262-273`, `709-716`.
8. **3.2:** `CurrentDrawingCheckService.cs:250-256`.
9. **3.4, 7 new 1:** `CurrentDrawingCheckService.cs:404`; `Rules\ObjectStatusRule.cs:38`.
10. **3.5, 7 new 2:** `CurrentDrawingCheckService.cs:438, 457`.
11. **4.2:** `DrawingCheckPaletteService.cs:234-241`. **4.3:** `DrawingCheckPaletteService.cs:58, 270`.
12. **5.1:** `CurrentDrawingCheckService.cs:147-189`, `328-342`. **5.2:** `Models\UserSettings.cs:2589-2599`.
13. **7 new 3:** `CheckCurrentDrawingCommand.cs:28`; `Commands\ChecksListCommand.cs:50`; `UserSettings.cs:4083`.
14. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:00. Nothing was run in AutoCAD.
