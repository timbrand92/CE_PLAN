# TOOL NOTE: Switch A/B bracing (ABS)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Switches the bracing blocks you select between type A and type B:** A becomes B, B becomes A.
2. **Skips what it cannot tell:** a block that is not clearly A or B (a BT1 truss, for example) is left alone with one line.
3. **Same code as ABSWITCH and STRUCABS.** ABSWITCH is hidden from the command list as a duplicate; typing it still runs this. If a ribbon button starts it, the button runs ABSWITCH.

## 2. What it changes in the drawing

1. **For a current-style BRACING block:** the type tag (A or B) and the layer, WALL BRACING TYPE A (colour 10) or WALL BRACING TYPE B (colour 150), both DASHDOT2. Length, rotation, flip, position and visibility are not touched.
2. **For an older-style brace block** (names such as "A - BRACING LEFT", "A - BRACING RIGHT", "B - BRACING"): it **erases the old block and draws a new BRACING block** at the same point with the same length, rotation and flip, on the new layer. Anything else on the old block is not copied. The new block is a new object.
3. **Adds the target layer if the drawing has none,** and loads the BRACING block from BRACING.dwg if the drawing has none, before the selection question.
4. **Does not store anything in a CE record and never saves the drawing.** The Bracing Panel reads the blocks afterwards.

## 3. What it will not do

1. **Refuses a read-only drawing:** "[CE_STRUC] ABSWITCH: the drawing is read-only. Save a copy you can edit first." (the name ABSWITCH is used even if you typed ABS).
2. **No layout-tab or REFEDIT stop.** Unlike AB, BB and BT1, ABS has no such check (fault 7 new 2).
3. **No units check.** It does not look at the drawing's units.
4. **Leaves a brace on a locked layer alone,** and a brace that would move onto a locked layer: "ABS left 1 bracing block alone: layer WALL BRACING TYPE B is locked. Unlock it and run ABS again." CE never unlocks a layer.
5. **Skips a block it cannot read as A or B:** "  Skipped one bracing block: CE could not tell whether it is type A or B."
6. **Leaves an older block with no stored length alone:** "One older bracing block does not store its length, so CE left it as it was." (a count line when there are several).
7. **Ignores anything selected that is not a bracing block:** "No bracing blocks found in selection."

## 4. What it asks you, and what Enter means

1. **"Select bracing block(s) to switch:"** Pick the blocks. Enter with nothing picked, or Esc, prints "No blocks selected." and ends. Nothing is changed.
2. **Nothing else is asked.** After the selection it works through every block with no further question.
3. **Lines as it goes:** "  Switched: A -> B", "  Converted & Switched: A -> B" (older block), then "=== SWITCH COMPLETE ===" and "Switched n of m bracing block(s)."

## 5. When it says Unknown or "needs checking"

1. **"  Skipped one bracing block: CE could not tell whether it is type A or B."** Check the block's type tag and layer by hand.
2. **"  Could not convert one older bracing block. It was left as it was."** This line is not always true (fault 7 new 1). Look for the old brace before you trust it.
3. **"Warning: BRACING block not loaded - legacy conversion may fail."** The BRACING block could not be loaded. Older blocks are still erased first (fault 7 new 1).

## 6. How to undo it

1. **U once for the whole command.** The code treats a typed command as one Undo step. Not proven in this note. No record of an ABS Undo walk was found.
2. **A failure part way is not rolled back by CE.** Each block is switched in its own step, so blocks already switched stay switched. U would undo them together.
3. **Esc does not remove** the BRACING block definition or layers CE added.

## 7. Known faults

**Still open**
1. **None found in the code.** BUG-583, the only open bug on this tool, is covered below. It stays open in the carpark because nothing has been seen working in AutoCAD.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-583:** a selected brace on a locked layer opened AutoCAD's "Unhandled exception eOnLockedLayer" window. The code now checks the layer of every brace, and the layer it would move to, before it opens anything for writing, and prints the line in section 3. It checks the block's layer, not the layer of the tag text inside it (whether that can differ is not known). The whole command still has no error catch, so any other AutoCAD error still shows AutoCAD's own window.
2. **BUG-428 (older block with no stored length):** such a block is left alone with one line.

**New in code, no bug covers it**
1. **An older brace can be lost while the line says it was kept.** For an older-style block the old block is erased first. If the new block then cannot be drawn (for example the BRACING block is missing, which only gets the warning above), the line says "It was left as it was." The old brace is gone.
2. **No layout-tab or REFEDIT stop.** For an older block on a layout tab or inside REFEDIT, the new block is drawn in Model space while the old one is erased where it was.
3. **A truss layer can read as type B.** If the type tag is blank, a layer named "... TYPE BT1" is read as type B, because the name contains "TYPE B". The block would then be switched to A.
4. **No error catch** in the command (try and finally only).
5. **The BRACING_LETTER tag is not updated** on a switch. Whether the block shows it is not known.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no `#if` in `BracingCommands.cs`, `BracingService.cs`, `LayerService.cs` or `BracingLengthPolicy.cs`). Not run on 2022 to 2024.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. Paths that start `Structural.DesignCore\` (or `..\Structural.DesignCore\`) are under `Modules\`, beside `Structural\`, not inside it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).

1. **1.1:** `Commands\BracingCommands.cs:369-373, 381-549`.
2. **1.2, 3.5, 5.1:** `BracingCommands.cs:469-473`; `Services\BracingService.cs:2079-2144`.
3. **1.3:** `BracingCommands.cs:375-381`; `Services\CommandRegistryService.cs:505-539`; registry `Assets\Config\command-registry.json:2490-2529` (ABSWITCH is an alias of ABS and has its own row); ribbon `Services\RibbonCommandHubService.cs:787-792`, `Services\CommandRegistryService.cs:117-126, 572-612`.
4. **2.1:** `BracingCommands.cs:501-528`; `BracingService.cs:1785-1837`.
5. **2.2, 7 new 1:** `BracingCommands.cs:484-500`; `BracingService.cs:2151-2207` (erase at 2169-2174, insert at 2176-2188, return at 2190-2191).
6. **2.3:** `BracingCommands.cs:395-398, 515-521`; `BracingService.cs:1491-1555, 1601-1608`.
7. **2.4:** no save call and no record call in `BracingCommands.cs` or `BracingService.cs`; panel read `Services\BracingPanelService.cs:26-31`.
8. **3.1:** `BracingCommands.cs:385`; `Services\DrawingSafetyService.cs:35-40`.
9. **3.2, 3.3, 7 new 2:** `BracingCommands.cs:385` (the only start check); `BracingService.cs:1676`.
10. **3.4:** `BracingCommands.cs:434-482, 538-540`; `Services\LayerService.cs:239-263`.
11. **3.6, 7 BUG-428:** `BracingCommands.cs:492-495, 535-537`; `Structural.DesignCore\BracingLengthPolicy.cs:83-96, 149-154`; `BracingService.cs:2157-2162`.
12. **3.7:** `BracingCommands.cs:400-429`.
13. **4.1, 4.2, 4.3:** `BracingCommands.cs:400-410, 431-545`.
14. **5.2, 5.3:** `BracingCommands.cs:395-398, 496-499`.
15. **6.1:** `Commands\CeStrucCommandBase.cs:106-111` (comment on typed commands).
16. **6.2:** `BracingCommands.cs:446-528`.
17. **7 BUG-583:** `BracingCommands.cs:434-482`; `Services\LayerService.cs:239-240`; symptom in carpark BUG-583.
18. **7 new 3:** `BracingService.cs:2104-2113, 2134-2141`.
19. **7 new 4:** `BracingCommands.cs:389-548` (try and finally, no catch).
20. **7 new 5:** `BracingCommands.cs:512` (only tag "A" is set); `BracingService.cs:1693` (BRACING_LETTER is set on insert, and no other place in `Modules` reads it).
21. **8.1:** no `#if` in the four files named.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
