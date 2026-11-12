# TOOL NOTE: Floor joist marker (FJ1)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Places a floor joist marker across one floor bay:** the same marker block as R1 (RAFTER-JOISTV2), tagged FJ1, on layer JOISTS by default.
2. **Takes four picks** (left, right, top, bottom), then asks for the tag text.
3. **Is R1's code** with a different layer, colour and tag. See the R1 note for the picks.

## 2. What it changes in the drawing

1. **One marker block** in Model space, with the tag text inside it, on the layer named by the Settings value RafterJoist.Fj1LayerName. It ships as JOISTS (colour 150, continuous). No box for it was found on the Settings window.
2. **A blank or unusable layer name** in Settings falls back to JOISTS and prints one line (section 3).
3. **Adds the layer if the drawing has none,** before the first question. A layer already there keeps its lock, freeze and colour.
4. **Brings the marker block in** from RAFTER-JOISTV2.dwg if the drawing does not have it.
5. **Saves CE's Settings file on your PC** after each placement, to remember the tag. It does not save the drawing.
6. **Slides the marker inside the bay** (Settings "Enable auto placement", ships on) and **straightens a bay within 12 degrees** of horizontal or vertical. No line says so for either.

## 3. What it will not do

1. **Refuses before it asks anything:** read-only drawing, layout tab ("... so CE placed no tag. Go to the Model tab, or double-click into a viewport, and try again."), REFEDIT open ("... so CE placed no tag. Close it (REFCLOSE) and try again.").
2. **Refuses every drawing whose units are not millimetres or not set** (metres, centimetres, inches, feet and the rest (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`)) with the footing-words line (see fault 7 new 4). Units "not set" count as millimetres.
3. **Bay too small or picks too close:** "[FJ1] Member length is too short to place the block." and the other "too close together" lines.
4. **Layer name AutoCAD would refuse:** "[FJ1] The Settings layer name is not one AutoCAD accepts, so JOISTS is used."
5. **No locked-layer check.** If the joist layer is locked it still draws there.
6. **Does not change what you pick.** Beams, walls and Xref objects are only read.
7. **Esc says nothing.** At any question it ends the tool with no marker and no line.

## 4. What it asks you, and what Enter means

1. **Four picks,** each "Pick ... [Object/Point] <Object>:" then "Select object:" or "Pick point:". Enter takes Object. Esc ends the tool.
2. **"Enter the tag text <FJ1>:"** Enter keeps the tag shown (the last FJ1 tag used on this PC). Esc ends the tool.
3. **No preview and no Yes/No.** The marker is drawn straight after the tag question.

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** It always draws a size worked out from your picks.
2. **After "[FJ1] Placed FJ1 on layer JOISTS." it can add:** "The block did not take the size you picked: span width <n> became <m>. ... Check the size in Properties (Ctrl+1) before you rely on this span. CE changed nothing else." Check Properties before you trust the marker.

## 6. How to undo it

1. **U once per marker.** The code treats a typed command as one Undo step. Not proven in this note. The carpark records one Undo and Redo passing for FJ1 on 1.0.116 (BUG-584 FJ1 extension).
2. **U does not undo** the remembered tag in the Settings file.
3. **Esc does not remove** the layer if CE added it before you pressed Esc.

## 7. Known faults

**Still open**
1. **BUG-475 (item S-09):** each pick is a question first, then a click.
2. **BUG-467:** rotated UCS. The Point option of the picks turns your click to World in the code; the open fault is the second point of AB, BB and BT1.
3. **BUG-537 (item 55):** colour 150 is fixed in the code.

**Partly fixed**
1. **BUG-584:** the FJ1 marker kept 2400 and 2600 widths on 1.0.116 (record). The code now warns (section 5). The cause is not fixed, and the check runs before the placement is committed, so whether it sees what AutoCAD finally keeps is not known.
2. **BUG-532 (item 2):** FJ1's layer now comes from Settings. The subfloor tools use FLOOR JOISTS and FJ1 still ships on JOISTS. No box for this layer name was found on the Settings window.
3. **BUG-471:** in a metre, centimetre or inch drawing it refuses instead of converting.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-472:** on a layout tab or inside REFEDIT it stops with one line and draws nothing.
2. **BUG-475 (items S-10, S-14):** Esc at "Select object:" ends the tool; the code-word lines show only with detailed logging on.

**New in code, no bug covers it**
1. **No locked-layer check** (section 3, line 5).
2. **Fixed numbers with no Settings name:** 25, 300, +200.
3. **A depth is guessed** if the top and bottom picks are under 25 units apart (300 or a quarter of the width), with no line.
4. **The units refusal talks about footings,** which this tool does not draw.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no `#if` in `RafterJoistCommands.cs`, `DynamicPropertyReadback.cs`, `DrawingSafetyService.cs` or `BeamService.cs`). Not run on 2022 to 2024.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. Paths that start `Structural.DesignCore\` (or `..\Structural.DesignCore\`) are under `Modules\`, beside `Structural\`, not inside it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).

1. **1.1, 1.2:** `Commands\RafterJoistCommands.cs:22, 75-82, 124-149`.
2. **2.1, 2.2, 3.4:** `RafterJoistCommands.cs:53-67, 78-81`; `Models\UserSettings.cs:979-982`.
3. **2.3:** `RafterJoistCommands.cs:113-117`; `Services\BeamService.cs:70-84`.
4. **2.4:** `RafterJoistCommands.cs:206-208, 709-757`.
5. **2.5:** `RafterJoistCommands.cs:258, 588-593`.
6. **2.6:** `RafterJoistCommands.cs:168-171, 194-204, 390-421, 496-564`; `Models\UserSettings.cs:968, 970`.
7. **3.1:** `Services\DrawingSafetyService.cs:35-40, 62-102`; `Core\Symbols\ModelSpaceWriteGuard.cs:16-23`; start check `RafterJoistCommands.cs:99`.
8. **3.2, 7 new 4:** `RafterJoistCommands.cs:100`; `Services\FoundationService.Identity.cs:119-128`; `Core\Day1UnitsGuard.cs:11-17`; `Structural.DesignCore\DrawingUnitRule.cs:296-299, 330-332`.
9. **3.3:** `RafterJoistCommands.cs:160, 301-311, 351-355`.
10. **3.5, 7 new 1:** no locked-layer call in `RafterJoistCommands.cs` (compare `Commands\BracingCommands.cs:19-24`).
11. **3.6:** `RafterJoistCommands.cs:1386-1393, 1475-1488`.
12. **3.7, 4.1, 7 BUG-475:** `RafterJoistCommands.cs:124-149, 1341-1356, 1396-1398`.
13. **4.2:** `RafterJoistCommands.cs:566-596`; `Models\UserSettings.cs:973`.
14. **5.2:** `RafterJoistCommands.cs:246-250, 676-686`; `Services\DynamicPropertyReadback.cs:64-65`.
15. **6.1:** `RafterJoistCommands.cs:105-106`; `Commands\CeStrucCommandBase.cs:106-118`.
16. **7 BUG-467, BUG-537, BUG-584, BUG-471, BUG-472:** `RafterJoistCommands.cs:22, 99-100, 236-250, 1360-1376`.
17. **7 BUG-532 partly:** `RafterJoistCommands.cs:53-67`; `Models\UserSettings.cs:976-982`; `Services\SettingsService.LoadRecovery.cs:1321`; no match for the name in `UI\Dialogs\CeSettingsDialog.xaml`.
18. **7 new 2, new 3:** `RafterJoistCommands.cs:27, 351, 362-368, 635`.
19. **8.1:** no `#if` in the four files named.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
