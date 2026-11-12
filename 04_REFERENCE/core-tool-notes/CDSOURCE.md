# TOOL NOTE: Generic source (CDSOURCE)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a named source** (roof drain, air-conditioning unit, overflow pipe, hot-water unit, or a name you type) with the SOURCE symbol.
2. **Numbers it for you:** ROOF DRAIN 1, ROOF DRAIN 2 ... Any type can be placed again.
3. **Carries on** to the next source until you press Esc.

## 2. What it changes in the drawing

1. **Draws** the SOURCE block on DOWNPIPES and a label on GUIDELINES (does not plot) showing the full name, for example "ROOF DRAIN 1".
2. **Splits a pipe run it lands on** (only downpipes are kept from splitting). **Free pipe end:** becomes that end's owner. **Pit (2027 only):** writes a link to the pit.
3. **Writes** the connection point, CE's link record and the project record, and refreshes linked schedule cells, all in one step.
4. **No whole-drawing record update before the pick.** It makes CE's record this drawing's without saving.
5. **Before the point question** it marks the drawing as a CE drawing, makes DOWNPIPES if missing (an existing unlocked layer gets CE's colour and linetype back), and loads the SOURCE block.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **SOURCE block missing:** "CDSOURCE refused - SOURCE.dwg is not in the drawing or any trusted block path. Stage the block and retry CDSOURCE. Nothing was placed." Checked before the first question.
3. **Custom with no name:** "CDSOURCE refused - a source needs a name. Nothing was placed."
4. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick; on the usual route it says only "Generic Source could not be placed. Nothing was changed - see CE log for details." (the layer is not named).
5. **Ambiguous, overlapping, or on another source:** asks you to pick again.

## 4. What it asks you, and what Enter means

1. **"Source type"** (Roof drain, Air-conditioning unit, Overflow pipe, Hot-water unit, Custom): on the first source Enter = Roof drain. Esc: "CDSOURCE cancelled - nothing was placed."
2. **"Source name (e.g. GREASE TRAP, CAR WASH)":** only for Custom. Spaces allowed.
3. **"Specify ROOF DRAIN 1 insertion point"** (the name changes): Enter is not accepted. Esc: "CDSOURCE cancelled - nothing was placed."
4. **Next source:** "Choose the next source, or press Esc to stop." then the type and point again. Esc: "Stopped. Everything placed stays; U takes back the last one."
5. **Enter at the next type question:** the code means it to end the run, but Roof drain is also set as the default answer; whether Enter ends the run or places another Roof drain is not proven.

## 5. When it says Unknown or "needs checking"

1. **Landing words** after each one: "Source block placed. ID: ROOF DRAIN 1." plus what it joined or split.

## 6. How to undo it

1. **U once per source.** Not proven in AutoCAD.
2. **After Esc at the point:** the layer, block load and CE marker stay in that command; it still says "nothing was placed".

## 7. Known faults

**Partly fixed**
1. **BUG-740:** multi-word names now keep every word and get a space before the number. Still there: after a COPY or a CDTAG retag the label loses the number (default numbering shows only WT, R and D numbers), and CDTAG cannot type a name with spaces.

**Still there in this build** (shared with all source commands)
1. **BUG-1209:** no placing on a pit on AutoCAD 2022 to 2026.
2. **BUG-1118:** the placing preview is a fixed size in drawing units.

**New in code, no bug covers it**
1. **Error line printed twice** when placing fails.
2. **Numbers can be reused:** CDSOURCE counts only names still in the drawing, so erasing ROOF DRAIN 3 and placing again gives ROOF DRAIN 3 again (not proven).
3. **A custom name ending in a number** gets another number added ("GREASE TRAP 2" becomes "GREASE TRAP 2 1"; not proven).
4. **Locked layer not named** on the usual route.

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused** ("Exact source COPY receipts are unavailable on this AutoCAD version"). Also on 2025 and 2026.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1, 4.2:** `Commands\SourceBlockGenericCommand.cs:35`, `62-69`, `144-207`; `Rules\GenericSourceTypes.cs:17-48`.
2. **1.2, 7 new 2, 7 new 3:** `SourceBlockGenericCommand.cs:71-73`; `Rules\GenericSourceTypes.cs:66-83`; compare `Services\SourceTagService.cs:235-237`.
3. **1.3, 4.4, 4.5:** `SourceBlockGenericCommand.cs:96-103`, `116-125`, `154`, `186-192`; `Services\PlacementContinuationService.cs:43-76`.
4. **2.1:** `Services\LinkService.SourceLanding.cs:654-657`; `Services\SourcePlacementService.cs:214, 468`.
5. **2.2:** `Rules\SourceLanding.cs:58-69`; `LinkService.SourceLanding.cs:663-725`.
6. **2.3:** `LinkService.SourceLanding.cs:644-661, 727-739`.
7. **2.4:** `SourceBlockGenericCommand.cs:50-54`; `Services\ProjectDataService.Mutations.cs:244-289`.
8. **2.5, 6.2:** `SourcePlacementService.cs:418-420`; `Services\LayerService.cs:478-496`; `Services\BlockService.cs:949`.
9. **3.1:** `SourceBlockGenericCommand.cs:45`; `Services\DrawingSafetyService.cs:61-131`.
10. **3.2:** `SourceBlockGenericCommand.cs:56-59, 227`.
11. **3.3:** `SourceBlockGenericCommand.cs:207`.
12. **3.4, 7 new 4:** `LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`; `Rules\SourceFamilies.cs:71`.
13. **3.5:** `Rules\SourceLanding.cs:103-137`; `BlockService.cs:920-928, 979-1000`.
14. **4.3 (Enter):** `BlockService.cs:1610-1615`; cancel words `SourceBlockGenericCommand.cs:91`.
15. **5.1:** `SourceBlockGenericCommand.cs:94`.
16. **7 BUG-740:** `Rules\SourceFamilies.cs:211-233`; `Services\LinkService.SpineClones.cs:157-159`; `Services\SourceTagService.SourceChangeApply.cs:33`; `Rules\SourceNumbering.cs:27-49`; `Commands\SourceTagCommand.cs:290`.
17. **7 new 1:** `SourcePlacementService.cs:477` and `SourceBlockGenericCommand.cs:89-90`.
18. **8.1:** `Services\SourceCloneMapNativeBridge.cs:185-229`; `LinkService.SourceLanding.cs:484-494`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:43. Nothing was run in AutoCAD.
