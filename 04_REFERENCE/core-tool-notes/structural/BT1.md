# TOOL NOTE: Roof bracing truss (BT1)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws a bracing truss line** between two points you give, using the same BRACING block as AB and BB, tagged BT with a number from 1 to 9.
2. **Chooses the side the brace faces** from the Xref walls when it can, and asks "Toggle flip?" only when it cannot.
3. **Does not warn about length.** AB and BB warn over the office limit; BT1 does not.

## 2. What it changes in the drawing

1. **One BRACING block** in Model space on layer WALL BRACING TYPE BT1 (colour 27, DASHDOT2) with the type tag BT1 to BT9, the length, the rotation, the flip and the visibility "BRACING TRUSS". Every truss number goes on the same layer.
2. **A hidden CE marker** is written on the new truss (CE's schema tag).
3. **Adds the layer if the drawing has none.** **Loads the BRACING block** from BRACING.dwg if the drawing has none, before the first question. If CE cannot find the file it opens a file picker.
4. **Adds layer 25CONT if the drawing has none,** when the truss is kept, and makes it current. Your own current layer is put back at the end.
5. **Moves the end of the truss** when it is within 1 degree of 0, 90, 180 or 270: it is drawn at the exact angle. No line says so.
6. **Changes CMDECHO, ANGBASE, ANGDIR and AUNITS** while it runs and puts them back at the end.
7. **Stores nothing in a CE record and never saves the drawing.** The Bracing Panel reads the blocks afterwards, and today it counts roof trusses as wall bracing (section 7).

## 3. What it will not do

1. **Refuses before it asks anything:** read-only drawing, layout tab ("You are on a layout tab (paper space), so CE drew no bracing truss. Go to the Model tab, or double-click into a viewport, and try again."), REFEDIT open ("... so CE drew no bracing truss. Close it (REFCLOSE) and try again.").
2. **Refuses every drawing whose units are not millimetres or not set** (metres, centimetres, inches, feet and the rest (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`)) with the footing-words line (see fault 7 new 5). Units "not set" count as millimetres.
3. **Refuses a locked layer:** "Layer WALL BRACING TYPE BT1 is locked, so CE drew no bracing. Unlock it and try again." CE never unlocks it.
4. **Does not check the length** against the Settings "longest wall brace". Whether that is a fault is not settled in the records (section 7).
5. **ABS will not switch a truss.** ABS skips it because its type is not A or B.

## 4. What it asks you, and what Enter means

1. **"Specify first point of bracing truss:"** Esc prints "Operation cancelled." and draws nothing.
2. **"Specify second point of bracing (drag preview, ENTER for 0°/2700):"** Enter (or the Zero keyword) draws the Settings default length along the current UCS X direction. Esc prints "Operation cancelled."
3. **Default length blank in Settings:** the "ENTER" words are left out, and Enter prints "The default brace length in CE Settings is not set, so pick the second point." then asks again.
4. **"Bracing truss number [1-9] <1>:"** Enter takes 1. Esc ends the tool with nothing drawn and no line. A number outside 1 to 9 is asked again by AutoCAD.
5. **A line "Preview length: <n>  rotation: <deg>°"** is printed, then the truss is drawn at once. It is not a pause before drawing.
6. **"Toggle flip? [Yes/No] <No>:"** asked only when CE could not tell the side, or Settings "Skip flip prompt when decisive" is off (ships on). Enter = No ("Flip unchanged."). Yes = "Brace flipped to the other side." Esc removes the truss just drawn: "Operation cancelled - block removed."

## 5. When it says Unknown or "needs checking"

1. **"CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side."** Answer the flip question, or flip it by hand.
2. **"CE set the brace direction from the Xref walls: it goes on the side with fewer wall lines."** CE worked this out. The reason shown is not always the one used (fault 7 new 1).
3. **If the BRACING block cannot be loaded:** "CE could not load the BRACING block, so no bracing was drawn. Check the BRACING file is not open in another program, then try again."

## 6. How to undo it

1. **U once per truss.** The code treats a typed command as one Undo step. Not proven in this note. The carpark records U and REDO echoing correctly for BT1 on 1.0.109, with the truss itself not fully seen (BUG-451, BUG-494).
2. **Esc does not remove** the BRACING block definition or the layers CE added.

## 7. Known faults

**Still open**
1. **BUG-499:** the Bracing Panel adds BT1 trusses to the wall bracing "provided". The code is unchanged: it counts every block named BRACING. A draft fix (PR #2047) leaves out BT numbers but is not in this build. Needs Tim's word on the rule.
2. **BUG-467:** wrong place in a rotated UCS. The second point is turned twice (`BracingCommands.cs:769`). The robot got a 10.6 m truss for 2400 mm typed on 1.0.125 (record). The fix is a draft (PR #1921), not in this build.
3. **BUG-475 (item S-13):** BT1 ignores the "longest wall brace" setting that AB and BB obey. BUG-475 says never decide without Tim; BUG-535 quotes Tim's ruling INT-076 that BT1 takes any width.
4. **BUG-535 (part):** the longest brace and the Enter length have no box on the Settings window.
5. **BUG-494, BUG-451:** Undo and Redo of BT1 not fully walked (records above).

**Partly fixed**
1. **BUG-471:** in a metre, centimetre or inch drawing BT1 now refuses instead of converting.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-473:** a locked WALL BRACING TYPE BT1 layer stops BT1 with one line.
2. **BUG-472:** on a layout tab or inside REFEDIT it stops with one line.
3. **BUG-424 (item 4):** a BRACING block that fails to load now gives the plain sentence in section 5 and the reason goes to the CE log.
4. **BUG-410 and BUG-413 (the "Duplicate definition of block _Dot ignored." line):** the block is now read quietly.
5. **BUG-475 (item S-14):** "Flip toggled to 1." is now "Brace flipped to the other side."

**New in code, no bug covers it**
1. **The "fewer wall lines" line is printed for every side CE decides,** including the local crowding test and the fallback. The reason shown may not be the reason used.
2. **The truss end is moved up to 1 degree** to a square angle, fixed in the code, with no line.
3. **Layer 25CONT is added quietly** if missing.
4. **No error catch.** Any other AutoCAD error opens AutoCAD's own error window.
5. **The units refusal talks about footings,** which this tool does not draw.
6. **The help text lists the questions in the wrong order:** "BT number 1-9" then "Insert point". The tool asks the points first, then the number.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no `#if` in `BracingCommands.cs`, `BracingService.cs`, `QuietBlockRead.cs`, `LayerService.cs` or `DrawingSafetyService.cs`). Not run on 2022 to 2024.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. Paths that start `Structural.DesignCore\` (or `..\Structural.DesignCore\`) are under `Modules\`, beside `Structural\`, not inside it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).

1. **1.1, 1.2:** `Commands\BracingCommands.cs:244-367`.
2. **1.3, 3.4, 7 BUG-475:** no `BracingLengthPolicy` call in `BracingCommands.cs:305-307` (compare `BracingCommands.cs:48-58`); BUG-475 and BUG-535 in `C:\CE_PLAN\BUG_CARPARK.md`.
3. **2.1:** `BracingCommands.cs:320-334`; `Services\BracingService.cs:1645-1721`.
4. **2.2:** `BracingService.cs:1684`.
5. **2.3:** `BracingCommands.cs:265-269`; `BracingService.cs:1491-1555, 1601-1608` (picker at 1511-1522).
6. **2.4:** `BracingCommands.cs:347-349`; `BracingService.cs:1610-1643`; restore `BracingCommands.cs:363-366`, `BracingService.cs:79-88`.
7. **2.5, 7 new 2:** `BracingService.cs:38, 98-105, 2217-2221`; `BracingCommands.cs:306`.
8. **2.6:** `BracingService.cs:66-96`.
9. **2.7, 7 BUG-499:** no save call and no record call in the command file or `BracingService.cs`; `Services\ProjectDataService.cs:282-286`; `Services\BracingPanelService.cs:26-31`.
10. **3.1:** `BracingCommands.cs:247-248`; `Services\DrawingSafetyService.cs:35-40, 62-102`; `Core\Symbols\ModelSpaceWriteGuard.cs:16-23`.
11. **3.2, 7 new 5:** `BracingCommands.cs:249`; `Services\FoundationService.Identity.cs:119-128`; `Core\Day1UnitsGuard.cs:11-17`; `Structural.DesignCore\DrawingUnitRule.cs:296-299, 330-332`.
12. **3.3:** `BracingCommands.cs:250-255`; `Services\LayerService.cs:219-232, 266-267`.
13. **3.5:** `BracingCommands.cs:469-473`.
14. **4.1, 4.2, 4.3, 4.5:** `BracingCommands.cs:271-285, 307, 736-771`; `Structural.DesignCore\BracingLengthPolicy.cs:109-121`. Codex saw "[Zero]" added to the second prompt and "Operation cancelled." on a second BT1 Esc on 1.0.109 (BUG-451).
15. **4.4:** `BracingCommands.cs:287-302`; `Services\CeQuestion.cs:16-20`.
16. **4.6:** `BracingCommands.cs:343-349`; `BracingService.cs:1736-1783`; `Models\UserSettings.cs:804`; `UI\Dialogs\CeSettingsDialog.xaml:350`.
17. **5.1, 5.2, 7 new 1:** `BracingCommands.cs:309-318, 343-346`; `BracingService.cs:107-329`.
18. **5.3, 7 BUG-424:** `BracingService.cs:1547-1553, 1558-1564`.
19. **6.1:** `Commands\CeStrucCommandBase.cs:106-111` (comment on typed commands); BUG-451 and BUG-494 in the carpark.
20. **7 BUG-467:** `BracingCommands.cs:736-771` (line 769); carpark BUG-467 notes of 31 Oct.
21. **7 BUG-535:** `Models\UserSettings.cs:831-842`; `UI\Dialogs\CeSettingsDialog.xaml.cs:137, 357`.
22. **7 BUG-473, BUG-472, BUG-471:** `BracingCommands.cs:247-255`.
23. **7 BUG-410, BUG-413:** `BracingService.cs:1530`; `Services\QuietBlockRead.cs:15-22`.
24. **7 BUG-475 S-14:** `BracingService.cs:1773`.
25. **7 new 4:** `BracingCommands.cs:260-366` (try and finally, no catch).
26. **7 new 6:** `Assets\Config\command-registry.json:2562-2565`; `BracingCommands.cs:271-295`.
27. **8.1:** no `#if` in the five files named.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
