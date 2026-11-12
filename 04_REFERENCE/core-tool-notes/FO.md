# TOOL NOTE: Front overflow (FO)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a front overflow** at the point you pick, tagged FO1, FO2 ... (numbered separately from OF).
2. **Uses the same OVERFLOW block as OF.** Everything else works exactly as OF.
3. **Carries on** to the next one until Esc.

## 2. What it changes in the drawing

1. **Draws** the OVERFLOW block on DOWNPIPES and a small tag label "FO" on GUIDELINES (does not plot).
2. **Splits a pipe run** it lands on. **Free pipe end:** becomes that end's owner. **Pit (2027 only):** writes a link to the pit.
3. **Before the point question:** marks the drawing as a CE drawing, makes the DOWNPIPES layer if missing, loads the block. No whole-drawing record update on the normal route.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Ambiguous, overlapping, or on another source:** asks you to pick again.
3. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick. On its own it names the lock; on a pipe or pit only "... could not be placed. Nothing was changed - see CE log for details."
4. **Missing block file:** only "FO command cancelled."

## 4. What it asks you, and what Enter means

1. **"Specify front overflow insertion point":** Enter is not accepted. Esc: "FO command cancelled."
2. **Next one:** "Pick the next FO, or press Esc to stop."
3. **No tag question, no window.**

## 5. When it says Unknown or "needs checking"

1. **Landing words** after each one say what it joined or split.

## 6. How to undo it

1. **U once per front overflow.** Not proven in AutoCAD.

## 7. Known faults

**Still there in this build**
1. **BUG-1236:** the symbol may read "OF". FO inserts the same OVERFLOW block as OF and nothing in the code gives FO its own symbol text. The green tag label does read "FO". (That the block itself carries the letters "OF" is in the block file, which this note did not open.) Tim's ruling: FO should insert with FO as the label.
2. **BUG-1209** (shared): no placing on a pit on AutoCAD 2022 to 2026.
3. **BUG-1118** (shared): the placing preview is a fixed size in drawing units.

**Question for Tim, not a fault**
1. **A front overflow splits a pipe it lands on,** like OF; only downpipes are kept from splitting.

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused.** Also on 2025 and 2026.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.2, 4.1:** `Commands\SourceBlockInsertCommands.cs:85-92` (line 89 uses the OVERFLOW block), `113-126`, `876-891`; separate numbering `Services\SourceTagService.cs:198, 222-224`.
2. **1.3, 4.2:** `SourceBlockInsertCommands.cs:895-899`; `Services\PlacementContinuationService.cs:43-76`.
3. **2.1:** `Services\LayerService.cs:150-152`; `Services\SourcePlacementService.cs:468, 495`; label from the tag family `Rules\SourceNumbering.cs:49`.
4. **2.2, 7 question:** `Rules\SourceLanding.cs:58-69`; `Services\LinkService.SourceLanding.cs:663-725`.
5. **2.3:** `SourcePlacementService.cs:415-420`.
6. **3.1:** `SourceBlockInsertCommands.cs:122`; `Services\DrawingSafetyService.cs:61-131`.
7. **3.2:** `Rules\SourceLanding.cs:103-137`; `Services\BlockService.cs:979-1000`.
8. **3.3:** `SourcePlacementService.cs:1384-1404`, `1440-1443`; `LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`.
9. **3.4:** `BlockService.cs:952`; `SourceBlockInsertCommands.cs:888`.
10. **4.1 (Enter):** `BlockService.cs:1610-1615`.
11. **7 BUG-1236:** `SourceBlockInsertCommands.cs:89`; ruling `C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md:421-424`.
12. **7, 8 shared:** `Services\SourceCloneMapNativeBridge.cs:185-229`; `SourcePlacementService.cs:1656-1658`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:37. Nothing was run in AutoCAD.
