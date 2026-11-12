# TOOL NOTE: A-bracing, wall brace type A (AB)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws a type A wall brace** between two points you give: the BRACING block, type A, on layer WALL BRACING TYPE A.
2. **Chooses the side the brace faces** from the Xref walls when it can, and asks "Toggle flip?" only when it cannot.
3. **Warns when the brace is longer than the office limit** (Settings, 2700 mm as shipped). It keeps the length you drew.
4. **Same code as STRUCAB.** If a ribbon button starts it, the button runs STRUCAB. Whether a button exists on the tab was not checked here.

## 2. What it changes in the drawing

1. **One BRACING block** in Model space on layer WALL BRACING TYPE A (colour 10, DASHDOT2), with the type tag A, the length, the rotation, the flip and the visibility "A-B BRACING".
2. **A hidden CE marker** is written on the new brace (CE's schema tag).
3. **Adds the layer if the drawing has none.** **Loads the BRACING block** from BRACING.dwg if the drawing has none, before the first question. If CE cannot find the file it opens a file picker.
4. **Adds layer 25CONT if the drawing has none,** when the brace is kept, and makes it current. Your own current layer is put back at the end.
5. **Moves the end of the brace** when it is within 1 degree of 0, 90, 180 or 270: the brace is drawn at the exact angle. No line says so.
6. **Changes CMDECHO, ANGBASE, ANGDIR and AUNITS** while it runs and puts them back at the end.
7. **Stores nothing in a CE record and never saves the drawing.** The Bracing Panel reads the blocks afterwards.

## 3. What it will not do

1. **Refuses before it asks anything:** read-only drawing, layout tab ("You are on a layout tab (paper space), so CE drew no bracing. Go to the Model tab, or double-click into a viewport, and try again."), REFEDIT open ("... so CE drew no bracing. Close it (REFCLOSE) and try again.").
2. **Refuses a drawing in metres, centimetres or inches** with the footing-words line (see fault 7 new 5). Units "not set" count as millimetres.
3. **Refuses a locked layer:** "Layer WALL BRACING TYPE A is locked, so CE drew no bracing. Unlock it and try again." CE never unlocks it.
4. **Never cuts a long brace.** Over the limit it prints "This brace is <n> mm, longer than the office limit of <limit> mm in CE Settings. CE kept the length you drew; check it."
5. **Limit left blank:** "The longest wall brace in CE Settings is not set, so CE did not check this brace's length. It was drawn as picked."
6. **The [Wall] option is off.** It only appears if the Settings Wall option is on (it ships off). No box for it was found on the Settings window.

## 4. What it asks you, and what Enter means

1. **"Specify first point of bracing:"** (with the Wall option on: "Specify first point of bracing or [Wall]:"). Esc prints "Operation cancelled." and draws nothing.
2. **"Specify second point of bracing (drag preview, ENTER for 0°/2700):"** Enter (or the Zero keyword) draws the Settings default length along the current UCS X direction. Esc prints "Operation cancelled."
3. **Default length blank in Settings:** the "ENTER" words are left out, and Enter prints "The default brace length in CE Settings is not set, so pick the second point." then asks again.
4. **A line "Preview length: <n>  rotation: <deg>°"** is printed, then the brace is drawn at once. It is not a pause before drawing.
5. **"Toggle flip? [Yes/No] <No>:"** asked only when CE could not tell the side, or Settings "Skip flip prompt when decisive" is off (box on the Settings window, ships on). Enter = No ("Flip unchanged."). Yes = "Brace flipped to the other side."
6. **Esc at the flip question removes the brace just drawn:** "Operation cancelled - block removed."

## 5. When it says Unknown or "needs checking"

1. **"CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side."** No Xref walls, no parallel wall near, or equal wall counts. Answer the flip question, or flip it by hand.
2. **"CE set the brace direction from the Xref walls: it goes on the side with fewer wall lines."** CE worked this out. With the skip setting on you are not asked, and it adds "CE could tell which way the brace faces, so it did not ask about flipping (ABFLIPAUTO is ON)." The "fewer wall lines" reason is not always the one CE used (fault 7 new 1).
3. **Units line:** "CE could not tell this drawing's units, so it did not check this brace's length. It was drawn as picked." (a unit code AutoCAD does not define, with the units hold switched off).

## 6. How to undo it

1. **U once per brace.** The code treats a typed command as one Undo step. Not proven in this note. No record of an AB Undo walk was found.
2. **Esc does not remove** the BRACING block definition or the layers CE added. Esc before the first point leaves the block loaded if CE loaded it.

## 7. Known faults

**Still open**
1. **BUG-467:** wrong place in a rotated UCS. The first point is right, the second is turned twice (`BracingCommands.cs:769`). The robot got 10091.2 mm at 120.81 degrees on 1.0.125 (record). The fix is a draft (PR #1921), not in this build.
2. **BUG-535 (part):** the longest brace and the Enter length have no box on the Settings window (only the skip-flip box is there).
3. **BUG-475, BUG-497, BUG-498, BUG-499, BUG-503:** listed against AB in the records. They are about BT1 (475), the schedules (497, 498, 503) and the Bracing Panel (499). None is an AB fault.

**Partly fixed**
1. **BUG-471:** in a metre, centimetre or inch drawing AB now refuses instead of converting. The length rule (BUG-428) converts, but is not reached while the units hold is on.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-473:** a locked WALL BRACING TYPE A layer stops AB with one line.
2. **BUG-472:** on a layout tab or inside REFEDIT it stops with one line.
3. **BUG-428:** a brace over the limit warns, and the limit is compared in millimetres.

**New in code, no bug covers it**
1. **The "fewer wall lines" line is printed for every side CE decides,** including the 2-wall-lines rule for type A, the local crowding test and the fallback. The reason shown may not be the reason used.
2. **The brace end is moved up to 1 degree** to a square angle, fixed in the code, with no line.
3. **Layer 25CONT is added quietly** if missing.
4. **No error catch.** Any other AutoCAD error opens AutoCAD's own error window.
5. **The units refusal talks about footings,** which this tool does not draw.
6. **The Wall option and the units switch have no Settings box.**

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no `#if` in `BracingCommands.cs`, `BracingService.cs`, `BracingLengthPolicy.cs`, `LayerService.cs` or `DrawingSafetyService.cs`). Not run on 2022 to 2024.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 1.2, 1.3:** `Commands\BracingCommands.cs:13-121`; `Structural.DesignCore\BracingLengthPolicy.cs:34-54, 63-77`.
2. **1.4:** `BracingCommands.cs:123-127`; `Services\RibbonCommandHubService.cs:787-792`; `Services\CommandRegistryService.cs:117-126, 572-581`; registry `Assets\Config\command-registry.json:2372-2392`.
3. **2.1:** `BracingCommands.cs:74-88`; `Services\BracingService.cs:1645-1721`.
4. **2.2:** `BracingService.cs:1684`.
5. **2.3:** `BracingCommands.cs:34-38`; `BracingService.cs:1491-1555, 1601-1608` (picker at 1511-1522).
6. **2.4:** `BracingCommands.cs:102-103`; `BracingService.cs:1610-1643`; restore `BracingCommands.cs:117-120`, `BracingService.cs:79-88`.
7. **2.5, 7 new 2:** `BracingService.cs:38, 98-105, 2217-2221`; `BracingCommands.cs:59`.
8. **2.6:** `BracingService.cs:66-96`.
9. **2.7:** no save call and no record call in the command file or `BracingService.cs`; panel read `Services\BracingPanelService.cs:26-31`.
10. **3.1:** `BracingCommands.cs:16-17`; `Services\DrawingSafetyService.cs:35-40, 62-102`; `Core\Symbols\ModelSpaceWriteGuard.cs:16-23`.
11. **3.2, 7 new 5:** `BracingCommands.cs:18`; `Services\FoundationService.Identity.cs:119-128`; `Core\Day1UnitsGuard.cs:11-17`; `Structural.DesignCore\DrawingUnitRule.cs:296-299, 330-332`.
12. **3.3:** `BracingCommands.cs:19-24`; `Services\LayerService.cs:219-232, 266-267`.
13. **3.4, 3.5, 5.3:** `BracingLengthPolicy.cs:39-42, 50-53, 68-72`; `BracingCommands.cs:48-58`.
14. **3.6, 7 new 6:** `BracingCommands.cs:577-602`; `Models\UserSettings.cs:820`; no match for the name in `UI\Dialogs\CeSettingsDialog.xaml.cs`.
15. **4.1, 4.2, 4.3, 4.4:** `BracingCommands.cs:41-46, 60, 584-586, 592, 736-771`; `BracingLengthPolicy.cs:109-121`. Codex saw "[Zero]" added to the second prompt on 1.0.109 (BUG-451).
16. **4.5, 4.6:** `BracingCommands.cs:97-103`; `BracingService.cs:1736-1783`; `Models\UserSettings.cs:804`; `UI\Dialogs\CeSettingsDialog.xaml:350`.
17. **5.1, 5.2, 7 new 1:** `BracingCommands.cs:63-72, 97-100`; `BracingService.cs:107-329`.
18. **6.1:** `Commands\CeStrucCommandBase.cs:106-111` (comment on typed commands).
19. **6.2:** `BracingCommands.cs:34`; `BracingService.cs:1491-1555`.
20. **7 BUG-467:** `BracingCommands.cs:736-771` (line 769); `BracingService.cs:1486`; carpark BUG-467 notes of 31 Oct.
21. **7 BUG-535:** `Models\UserSettings.cs:831-842`; `UI\Dialogs\CeSettingsDialog.xaml.cs:137, 357`.
22. **7 BUG-473, BUG-472, BUG-428, BUG-471:** `BracingCommands.cs:16-24`; `BracingLengthPolicy.cs:63-77`.
23. **7 new 4:** `BracingCommands.cs:29-121` (try and finally, no catch).
24. **8.1:** no `#if` in the five files named.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
