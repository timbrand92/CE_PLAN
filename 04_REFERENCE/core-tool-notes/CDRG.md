# TOOL NOTE: Raingarden (CDRG)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Draws a raingarden outline** from the points you pick, fills it with a solid hatch and labels it "RG".
2. **Works out its area** (square metres) and records it.
3. **Can add a GIO** (gross inlet) to the raingarden in the same command.

## 2. What it changes in the drawing

1. **Draws** a closed outline on 50CONT, a solid hatch on HATCH113 (sent to the back), and a label on GUIDELINES (does not plot).
2. **The label reads "RG"** without a number by default; the record keeps RG1, RG2 ...
3. **Stores** the raingarden: name, outline, any GIO, area, centre (the true area centre, switch on).
4. **Does not record the outlet pit** (see 7).
5. **With a GIO:** places it and splits the pipe it lands on. On the older route the GIO goes in first, then the raingarden.
6. **No whole-drawing record update,** except on the older GIO route after every answer.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Locked or Xref 50CONT or HATCH113 layer:** refused only after the outline and the GIO answers. On screen (no GIO): "Raingarden could not be placed. Nothing was changed - see CE log for details." With a GIO on the exact route the same refusal names the GIO instead ("GIO could not be placed. Nothing was changed - see CE log for details."); on the older GIO route it comes after "GIO ... was placed, but the raingarden boundary was not". The layer is named only in the log.
3. **Locked GUIDELINES:** the raingarden is still placed and a line says the label was not.
4. **A drawing in no metric units:** placed with area Unknown and "The raingarden was placed without a size ...".
5. **Does not check for an outline that crosses itself;** the area is then wrong with no warning.
6. **One raingarden per command.**

## 4. What it asks you, and what Enter means

1. **"Specify first raingarden point":** Enter or Esc: "CDRG command cancelled."
2. **"Next point [Undo]"** (under 3 points), then **"Next point (N pts) [Close/Undo]"**: Enter (or right-click) with 3 or more points finishes the outline; with fewer: "[CE] Pick at least 3 points (N so far)." and it keeps asking. Undo removes the last point. Picking near the first point closes it. Esc cancels.
3. **"Add a GIO source to this raingarden? [Place/Skip] <Skip>":** Enter = Skip.
4. **"Specify GIO insertion point"** (if Place): Esc: "CDRG command cancelled."
5. **No window.**

## 5. When it says Unknown or "needs checking"

1. **Area Unknown** in a drawing without metric units (see 3.4).
2. **GIO placed but raingarden refused** (older route): "GIO ... was placed, but the raingarden boundary was not ... Press Ctrl+Z once to remove both". The same line also says "Nothing was changed".

## 6. How to undo it

1. **U once.** Everything is in one command. Not proven in AutoCAD.

## 7. Known faults

**Still there in this build**
1. **BUG-1107:** the raingarden's outlet pit is never recorded; the Inspector says "No outlet registered".
2. **BUG-773, part:** the saved area and centre are compared exactly when the raingarden is checked, so a good raingarden can be refused. No rounding or tolerance found.

**Partly fixed**
1. **BUG-773, part:** the stored centre is now the true area centre (switch on).

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-771:** Enter or right-click finishes the outline; Undo removes one point.

**New in code, no bug covers it**
1. **Self-crossing outline accepted** with a wrong area.
2. **Locked-layer reason only in the log,** and checked after every question.
3. **Missing GIO block** reads only "CDRG command cancelled."
4. **Close-on-first-point distance is 1 drawing unit** (1 m in a metre drawing).

## 8. On AutoCAD 2022 to 2024

1. **Same,** apart from a GIO landing on a pit, which is refused before 2027 (as for GIO).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Commands\SourceBlockInsertCommands.cs:417-518`; `Services\SourcePlacementService.cs:880-915`, `940-958`; `Services\LayerService.cs:205-211`.
2. **1.2, 2.3:** `Services\RaingardenPlacementPlan.cs:103-140`, `235-243`; `Models\UserSettings.cs:1010-1011`.
3. **2.2:** `Rules\RaingardenLabelRule.cs:28-39`; `UserSettings.cs:860, 867-868`; `RaingardenPlacementPlan.cs:290-300`.
4. **2.4, 7 BUG-1107:** `RaingardenPlacementPlan.cs:235-243`; `Services\InspectorPaletteService.cs:2428-2429`.
5. **2.5:** `SourceBlockInsertCommands.cs:546-607`; `SourcePlacementService.cs:665-673, 686-726`.
6. **2.6:** no record update call in CDRG; older route `SourcePlacementService.cs:1332`.
7. **3.1:** `SourceBlockInsertCommands.cs:424`; `Services\DrawingSafetyService.cs:61-131`.
8. **3.2, 7 new 2:** `SourcePlacementService.cs:843-860`, `602` (family "RG" at `824` gives "Raingarden"; the GIO route at `678` gives "GIO"; older route wrapper `724-726`); `SourceBlockInsertCommands.cs:612-614`.
9. **3.3:** `SourcePlacementService.cs:944-951`; `RaingardenLabelRule.cs:42-44`.
10. **3.4, 5.1:** `SourceBlockInsertCommands.cs:597, 619-621`.
11. **3.5, 7 new 1:** `RaingardenPlacementPlan.cs:103-132`.
12. **3.6:** no `PlacementContinuationService` in CDRG.
13. **4.1, 4.2, 7 BUG-771:** `SourceBlockInsertCommands.cs:438-518`, `923-934`; `Commands\RaingardenOutlineStep.cs:27-40` ("Pick at least" is line 28; Close with too few points says "Need at least 3 points to close", line 32; a finished outline under 3 points ends with "Need at least 3 points. CDRG command cancelled.", `SourceBlockInsertCommands.cs:522`).
14. **4.3, 4.4:** `SourceBlockInsertCommands.cs:526-559`.
15. **5.2:** `SourcePlacementService.cs:723-726`.
16. **6.1:** `SourcePlacementService.cs:686-699`.
17. **7 BUG-773:** `RaingardenPlacementPlan.cs:134-140`, `240-242`, `262-265`; `SourcePlacementService.cs:789`.
18. **7 new 3:** `Services\BlockService.cs:950-954`. **7 new 4:** `SourceBlockInsertCommands.cs:502-514`.
19. **8.1:** no `#if` on this path; GIO pit landing `Services\SourceCloneMapNativeBridge.cs:185-229`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.