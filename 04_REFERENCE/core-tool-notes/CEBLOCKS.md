# TOOL NOTE: Office blocks palette (CEBLOCKS)

**Core since:** not yet
**Build this note describes:** Suite Manager code in the installed copy (commit cf059dcf, alongside Civil 3.0.90)

---

## 1. What it does

1. **Opens the CE Blocks palette** of office blocks (from the office block drawing on OneDrive).
2. **Click a block** to place it: scale, then points, carrying on until Esc.
3. **This is a Suite Manager tool,** not Civil; it is on the Civil tab end for convenience.

## 2. What it changes in the drawing

1. **Copies the block definition** from the office block drawing into this drawing and makes its layer if missing.
2. **Places the block** in the current space, with its attribute values as stored in the block (no attribute questions).
3. **Explodes it after placing** if that block is set to explode.
4. **Writes your "recent blocks" list** (last 6) to a file on this PC after each placement.
5. **Nothing in CE's drainage record.**

## 3. What it will not do

1. **REFEDIT open:** "Finish the reference edit before placing a CE block." If AutoCAD cannot say: "CE Blocks could not check the reference edit state. No block was placed."
2. **Locked layer:** "Layer X is locked. No block was placed." (checked before the first question).
3. **Frozen but unlocked layer:** warns the block will be hidden (CE does not thaw it) and places it (switch on).
4. **Office block drawing not synced:** "The source block drawing has not synced yet. Check OneDrive and try again."
5. **Block from an Xref:** "This block is from an external drawing and cannot be placed."
6. **Not checked:** Paper Space, read-only drawing, metre drawings (the palette scale is used as stored).

## 4. What it asks you, and what Enter means

1. **"Scale for X [Enter keeps N]":** Enter keeps the palette's scale. Esc places nothing.
2. **"Pick a point for X",** then **"Pick another point for X, or press Esc to stop".**
3. **"Rotation for X"** (only for blocks set to ask): Enter keeps the stored rotation. Esc stops.
4. **No live preview** while placing.

## 5. When it says Unknown or "needs checking"

1. **Palette files missing:** the palette shows a raw program message ("CE Blocks palette files are unavailable: ..."), and one missing file stops the whole palette.

## 6. How to undo it

1. **One U is expected to take back the whole run** of copies (each is its own step inside one command), although Help says "One Undo per insert". Not proven.
2. **Not undone by U:** the recent-blocks file.

## 7. Known faults

**Still there in this build**
1. **BUG-188 (part):** no live preview while placing. Attribute values are now copied from the block.
2. **BUG-1166:** the office folders are looked for only under your user folder.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1047:** a frozen layer warns and places, instead of refusing (switch on).
2. **BUG-524:** ribbon buttons show the command name in brackets (switch on, set by Civil).

**Reported, could not confirm in code**
1. **BUG-1243:** "does not work the way Tim wanted" — the record does not say what he wanted; the only gap against his earlier words is the missing preview.

**New in code, no bug covers it**
1. **Raw program message** when palette files are missing; one missing file stops the whole palette.
2. **Help says "its own fixed size",** but a scale question comes first.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Manager\`.

1. **1.1, 1.2:** `Commands\PluginManagerCommands.cs:16-24`; `Services\CeBlocksPaletteService.cs:19-47`; `Services\CeManagerCommandSender.cs:15-22`.
2. **2.1, 2.2:** `Services\CeBlocksInsertService.cs:140-183`, `235-249`, `263-299`.
3. **2.3:** `CeBlocksInsertService.cs:184-205`.
4. **2.4, 6.2:** `CeBlocksInsertService.cs:116-127`; `Services\CeBlocksSettings.cs:26, 37-41`.
5. **3.1:** `CeBlocksInsertService.cs:30-42`.
6. **3.2, 3.3, 7 BUG-1047:** `CeBlocksInsertService.cs:57-65, 251-261`; `Services\CeBlocksLayerGate.cs:20-35`; `CeBlocksSettings.cs:30`.
7. **3.4:** `CeBlocksInsertService.cs:47`. **3.5:** `CeBlocksInsertService.cs:156`.
8. **4.1 to 4.3:** `CeBlocksInsertService.cs:68-112`.
9. **4.4, 7 BUG-188:** no jig in `Modules\Manager`; `CeBlocksInsertService.cs:76, 86`.
10. **5.1, 7 new 1:** `CeBlocksPaletteService.cs:26`; `Services\CeBlocksCatalog.cs:44-50`.
11. **6.1, 7 new 2:** `Modules\Drainage\Assets\Help\guide-content.js:11`.
12. **7 BUG-1166:** `CeBlocksSettings.cs:32-35`.
13. **7 BUG-524:** `Shared\CE_SHARED\Services\RibbonBuilder.cs:268-270` (repo root); `Modules\Drainage\Models\UserSettings.cs:3668-3669`.
14. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:06. Nothing was run in AutoCAD.
