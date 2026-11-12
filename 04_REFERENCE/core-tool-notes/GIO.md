# TOOL NOTE: Gross inlet (GIO)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a gross inlet (GIO) symbol** at the point you pick, tagged GIO1, GIO2 ...
2. **On a pipe run it splits the pipe** into two, with the GIO between them.
3. **Carries on** to the next one until Esc.

## 2. What it changes in the drawing

1. **Draws** the GIO block on the raingarden outline layer (50CONT), not DOWNPIPES, and a small tag label on GUIDELINES (does not plot).
2. **Splits a pipe run** it lands on. **Free pipe end:** becomes that end's owner. **Pit (2027 only):** writes a link to the pit.
3. **Before the point question:** marks the drawing as a CE drawing, makes the 50CONT layer if missing, loads the block. No whole-drawing record update on the normal route.
4. **Tag numbers are never reused.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Ambiguous, overlapping, or on another source:** asks you to pick again.
3. **Locked 50CONT or GUIDELINES layer:** checked after the pick. Placed on its own it says "The source or GUIDELINES layer is locked" (meaning 50CONT here); on a pipe or pit only "... could not be placed. Nothing was changed - see CE log for details."
4. **Missing block file:** only "GIO command cancelled."

## 4. What it asks you, and what Enter means

1. **"Specify GIO insertion point":** Enter is not accepted. Esc: "GIO command cancelled."
2. **Next one:** "Pick the next GIO, or press Esc to stop."
3. **No tag question, no window.**

## 5. When it says Unknown or "needs checking"

1. **Landing words** after each one say what it joined or split.

## 6. How to undo it

1. **U once per GIO,** including any split. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under GIO itself. Shared with all source commands:

**Still there in this build**
1. **BUG-1209:** no placing on a pit on AutoCAD 2022 to 2026.
2. **BUG-1118:** the placing preview is a fixed size in drawing units.

**Partly fixed**
1. **BUG-1228:** speed, as for DP.

**Good to know**
1. **CDRG can also place a GIO** for a raingarden, by a different route (see the CDRG note).

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused.** Also on 2025 and 2026.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1, 4.1:** `Commands\SourceBlockInsertCommands.cs:95-105` (own layer at 103-105), `113-126`, `876-891`; `Services\BlockService.cs:54`; `Services\LayerService.cs:205-207, 316`.
2. **1.2, 2.2:** `Rules\SourceLanding.cs:58-69`; `Services\LinkService.SourceLanding.cs:663-725`.
3. **1.3, 4.2:** `SourceBlockInsertCommands.cs:895-899`; `Services\PlacementContinuationService.cs:43-76`.
4. **2.3:** `Services\SourcePlacementService.cs:415-420`.
5. **2.4:** `Services\SourceTagService.cs:196-240`.
6. **3.1:** `SourceBlockInsertCommands.cs:122`; `Services\DrawingSafetyService.cs:61-131`.
7. **3.2:** `Rules\SourceLanding.cs:103-137`; `BlockService.cs:979-1000`.
8. **3.3:** `SourcePlacementService.cs:1384-1404`, `1440-1443`; `LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`.
9. **3.4:** `BlockService.cs:952`; `SourceBlockInsertCommands.cs:888`.
10. **4.1 (Enter):** `BlockService.cs:1610-1615`.
11. **7 shared:** `Services\SourceCloneMapNativeBridge.cs:185-229`; `SourcePlacementService.cs:1656-1658`; `Models\UserSettings.cs:843`.
12. **7 good to know:** `SourceBlockInsertCommands.cs:546-594`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:40. Nothing was run in AutoCAD.
