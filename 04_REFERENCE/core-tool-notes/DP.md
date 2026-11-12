# TOOL NOTE: Downpipe (DP)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a downpipe symbol** at the point you pick and gives it the next free tag (DP1, DP2 ...).
2. **Joins what it lands on:** a free pipe end becomes the downpipe's; on a pipe run it sits on the main as a branch; on a pit it joins the pit (AutoCAD 2027 only).
3. **Carries on** to the next downpipe until you press Esc.

## 2. What it changes in the drawing

1. **Draws** the downpipe block (layer DOWNPIPES) and a small green tag label on GUIDELINES (does not plot), 250 up and right of the block.
2. **The label reads "DP" without the number** by default (the number is in the tag, shown in the Inspector). A project can switch numbers on in the Pit Schedule window.
3. **Never splits a main.** On a pipe run it says "The main is not split; draw the downpipe's pipe to it and it joins as a branch", and records a junction on the main.
4. **Free pipe end:** the downpipe becomes that end's owner.
5. **Pit (2027):** writes a downpipe-to-pit link on the block. The pit's pipes are not split.
6. **Before the point question** it marks the drawing as a CE drawing, makes the DOWNPIPES layer if missing, and loads the downpipe block into the drawing. No whole-drawing record update on the normal route.
7. **Tag numbers are never reused**, even after a downpipe is erased.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first). REFEDIT is checked again before the pick; if AutoCAD cannot say, it refuses.
2. **A pick that could connect two ways** (overlap, two candidates): "The source would have more than one possible connection. Move it and pick again." It asks again; it does not end.
3. **On top of another source:** "<tag> is already at this point, and a new source cannot sit on top of it."
4. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick. Placed on its own it says "The source or GUIDELINES layer is locked. Nothing was placed." Landing on a pit or pipe end it says only "Downpipe could not be placed. Nothing was changed - see CE log for details." (the layer is not named).
5. **Block missing from every block folder:** only "DP command cancelled." on screen; the reason is in the CE log.
6. **Pit landing on AutoCAD 2022 to 2026:** refused (see 8).

## 4. What it asks you, and what Enter means

1. **"Specify downpipe insertion point":** a live preview follows the cursor with green or red words. Enter is not accepted. Esc: "DP command cancelled."
2. **A refused spot:** "Move the source and pick again, or press Esc."
3. **Next downpipe:** "Pick the next DP, or press Esc to stop." Esc: "Stopped. Everything placed stays; U takes back the last one."
4. **No tag question.** No window.

## 5. When it says Unknown or "needs checking"

1. **Landing words** after each one say what it joined: "Joins pit P1.", "Becomes the end of ...", "Sits on ...", or "Nothing nearby. The source connects when a pipe is drawn to it."
2. **Record changing underneath:** "The Civil record is still changing underneath this pick ... Pick again."

## 6. How to undo it

1. **U once per downpipe.** Each one is its own command.
2. **After Esc at the first point:** the layer, block load and CE marker written before the question stay; one U should take them back (not proven).

## 7. Known faults

**Still there in this build**
1. **BUG-1209:** a downpipe cannot be placed on a pit on AutoCAD 2022 to 2024. Also on 2025 and 2026. Way round: place it beside the pit and draw its pipe.
2. **BUG-1118:** the placing preview is a fixed size in drawing units (marker 100, circle 90, text 120); huge in a metre drawing. Affects every source command.

**Partly fixed**
1. **BUG-1228 (slow):** each object is now read once per check (switch on), but the whole drawing is still read several times per downpipe.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-859:** double-click on a downpipe opens CE's Edit source, not AutoCAD's attribute editor (switch on).
2. **BUG-860:** double-click on the green label opens Edit source (switch on).

**Working as Tim ruled**
1. **BUG-1242:** the label shows "DP" without the number. Tim's ruling 77 (29 Oct): the number shows in the tag only. The bug entry still asks for the number and should be re-filed.

**New in code, no bug covers it**
1. **Junction result never said.** On a pipe run, whether the junction was recorded is not printed.
2. **Error line printed twice** when placing fails.
3. **Locked layer on the older route** (a downpipe on a run): no check before the block goes in, so the drafter may see only "Error placing DP - see CE log" with an untagged block left. Not proven.

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused:** "Source-to-pit placement is unavailable: Exact source COPY receipts are unavailable on this AutoCAD version." The same on 2025 and 2026.
2. **Everything else the same.**

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\SourceBlockInsertCommands.cs:55-62`, `113-126`, `876-891`; `Services\SourcePlacementService.cs:392`, `556-559`.
2. **1.3, 4.3:** `SourceBlockInsertCommands.cs:895-899`; `Services\PlacementContinuationService.cs:43-76`.
3. **2.1:** `Services\LayerService.cs:150-152`; `SourcePlacementService.cs:468, 495`; `Services\SourceTagService.cs:25`.
4. **2.2, 7 BUG-1242:** `Rules\SourceNumbering.cs:24, 34-50`; `Models\ProjectData.cs:107`; `C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md:426-429`.
5. **2.3, 7 new 1:** `Rules\SourceLanding.cs:58-69`, `480`; `SourcePlacementService.cs:462-465`, `1338-1339`, `1369-1377`; `Services\LinkService.Split.cs:66-93`; `Services\LinkService.NewPipeEnds.cs:258-312`.
6. **2.4, 2.5:** `Services\LinkService.SourceLanding.cs:551`, `644-692`.
7. **2.6:** `SourcePlacementService.cs:418-420`; `Services\BlockService.cs:949`; `Services\ProjectDataService.Persistence.cs:903-929`.
8. **2.7:** `SourceTagService.cs:196-240`.
9. **3.1:** `SourceBlockInsertCommands.cs:122`; `Services\DrawingSafetyService.cs:61-131`; `SourcePlacementService.cs:409-411`, `1448-1459`.
10. **3.2, 4.2:** `Rules\SourceLanding.cs:103-137`, `113`; `BlockService.cs:920-928`, `979-1000`.
11. **3.3:** `Rules\SourcePickPipeRecordRule.cs:49-54`.
12. **3.4:** free-standing route `SourcePlacementService.cs:518` (`CommitFreeStandingPlacement`), `1384-1404`, `1440-1443`; pit or pipe-end route `LinkService.SourceLanding.cs:612-617` and `SourcePlacementService.cs:596-602`.
13. **3.5:** `BlockService.cs:952`; `SourceBlockInsertCommands.cs:888`.
14. **4.1 (Enter):** `BlockService.cs:1610-1615` (no empty answer allowed in the pick).
15. **5.1:** `Rules\SourceLanding.cs:464-483`. **5.2:** `SourcePlacementService.cs:327-328`.
16. **6.1:** `PlacementContinuationService.cs:13-28`; `LinkService.SourceLanding.cs:551` (one transaction).
17. **7 BUG-1209, 8.1:** `Services\SourceCloneMapNativeBridge.cs:185-229`; `LinkService.SourceLanding.cs:484-494`.
18. **7 BUG-1118:** `SourcePlacementService.cs:1656-1658`, `1694-1695`; `BlockService.cs:1662, 1666, 1691-1693`.
19. **7 BUG-1228:** `Models\UserSettings.cs:843`; `LinkService.SourceLanding.cs:259`; whole-drawing reads `SourcePlacementService.cs:148, 245, 266`.
20. **7 BUG-859, 860:** `Services\CompoundEditModeService.cs:425-443`, `978-1070`; `Models\DoubleClickSettings.cs:35, 52, 80`.
21. **7 new 2:** `SourcePlacementService.cs:457, 477` and `SourceBlockInsertCommands.cs:888`.
22. **7 new 3:** `SourcePlacementService.cs:1322-1378` (block added at 1333, no lock check on this route).

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:37. Nothing was run in AutoCAD.
