# TOOL NOTE: Inspection opening (IO)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places an inspection opening symbol** at the point you pick, tagged IO1, IO2 ...
2. **On a pipe run it splits the pipe** into two pipes with the IO between them, like a pit.
3. **Carries on** to the next one until Esc.

## 2. What it changes in the drawing

1. **Draws** the IO block on DOWNPIPES and a small tag label on GUIDELINES (does not plot).
2. **Splits a pipe run** it lands on and makes the IO the owner of the two new ends.
3. **Free pipe end:** the IO becomes that end's owner. **Pit (2027 only):** writes an IO-to-pit link.
4. **Before the point question:** marks the drawing as a CE drawing, makes the DOWNPIPES layer if missing, loads the IO block. No whole-drawing record update on the normal route.
5. **Tag numbers are never reused.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Ambiguous or overlapping spot:** asks you to pick again.
3. **On top of another source:** refused, pick again.
4. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick. On its own: "The source or GUIDELINES layer is locked. Nothing was placed." On a pipe or pit: only "... could not be placed. Nothing was changed - see CE log for details."
5. **Missing block file:** only "IO command cancelled."; reason in the CE log.

## 4. What it asks you, and what Enter means

1. **"Specify inspection opening insertion point":** Enter is not accepted. Esc: "IO command cancelled."
2. **Refused spot:** "Move the source and pick again, or press Esc."
3. **Next one:** "Pick the next IO, or press Esc to stop." Esc: "Stopped. Everything placed stays; U takes back the last one."
4. **No tag question, no window.**

## 5. When it says Unknown or "needs checking"

1. **Landing words** say what it joined or split: for example "Splits <pipe> here and joins the junction." or "Nothing nearby."

## 6. How to undo it

1. **U once per IO,** including the split. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under IO itself. Shared with DP and the other source commands:

**Still there in this build**
1. **BUG-1209:** no placing on a pit on AutoCAD 2022 to 2026.
2. **BUG-1118:** the placing preview is a fixed size in drawing units.

**Partly fixed**
1. **BUG-1228:** speed, as for DP.

**New in code, no bug covers it**
1. **Error line printed twice** when placing fails.

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused** ("Exact source COPY receipts are unavailable on this AutoCAD version"). Also on 2025 and 2026.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\SourceBlockInsertCommands.cs:65-72`, `113-126`, `876-891`; `Services\BlockService.cs:39`.
2. **1.2, 2.2:** `Rules\SourceLanding.cs:58-69`; `Services\LinkService.SourceLanding.cs:693-725`; `Services\LinkService.Split.cs:95-146`.
3. **1.3, 4.3:** `SourceBlockInsertCommands.cs:895-899`; `Services\PlacementContinuationService.cs:43-76`.
4. **2.1:** `Services\LayerService.cs:150-152`; `Services\SourcePlacementService.cs:468, 495`.
5. **2.3:** `LinkService.SourceLanding.cs:663-692`.
6. **2.4:** `SourcePlacementService.cs:415-420`; `BlockService.cs:949`.
7. **2.5:** `Services\SourceTagService.cs:196-240`.
8. **3.1:** `SourceBlockInsertCommands.cs:122`; `Services\DrawingSafetyService.cs:61-131`.
9. **3.2, 3.3, 4.2:** `Rules\SourceLanding.cs:103-137`; `Rules\SourcePickPipeRecordRule.cs:49-54`; `BlockService.cs:920-928, 979-1000`.
10. **3.4:** `SourcePlacementService.cs:1384-1404`, `1440-1443`; `LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`.
11. **3.5:** `BlockService.cs:952`; `SourceBlockInsertCommands.cs:888`.
12. **4.1 (Enter):** `BlockService.cs:1610-1615`.
13. **5.1:** `Rules\SourceLanding.cs:464-483`.
14. **6.1:** `LinkService.SourceLanding.cs:551` (one transaction); `PlacementContinuationService.cs:13-28`.
15. **7, 8:** as in the DP note: `Services\SourceCloneMapNativeBridge.cs:185-229`; `SourcePlacementService.cs:1656-1658`; `Models\UserSettings.cs:843`; `SourcePlacementService.cs:457, 477` with `SourceBlockInsertCommands.cs:888`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:37. Nothing was run in AutoCAD.
