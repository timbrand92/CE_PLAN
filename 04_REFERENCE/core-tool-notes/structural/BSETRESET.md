# TOOL NOTE: Clear all inside points (BSETRESET)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Clears every inside point saved in this drawing,** all at once.
2. **Use it when moving to a different building,** or when the building outline has changed. After it, the next lintel mark asks for a point again.

## 2. What it changes in the drawing

1. **Empties the record that holds the inside points.** Every point goes, not just the last one.
2. **Creates that record, empty, if the drawing had none.** So a drawing with no points still gets a new entry.
3. **The drawing counts as changed,** so closing it asks to save. The command never saves.
4. **Beams already placed are not touched.** Their marks stay where they are.
5. **Not the drawing:** a line in CE's command history on the PC.

## 3. What it will not do

1. **Does not ask first.** There is no question and no list of what is being cleared.
2. **Does not clear one point.** All or nothing.
3. **Does not check** whether the drawing is read-only, which space you are in, or REFEDIT (see 7).
4. **Does not move or redo any beam mark.** A lintel placed with an old point stays on the side it was given.

## 4. What it asks you, and what Enter means

1. **It asks nothing.** Typing BSETRESET clears the points straight away.
2. **What it prints:** "All inside-points cleared for this drawing."
3. **If the code itself fails** before reaching the store: "BSETRESET: CE could not clear the inside-points. The reason is in the CE log." Failures inside the store do not reach this line (see 7).

## 5. When it says Unknown or "needs checking"

1. **Not applicable.** It shows no worked-out value.
2. **If the beam commands say the saved point "looks wrong",** this is the command they tell you to run, followed by BSET.

## 6. How to undo it

1. **U once should bring the points back,** because the change is made inside the command. Not proven in AutoCAD, and not seen in the records read.
2. **If you cleared by mistake,** run BSET again for each building, or use U straight away.

## 7. Known faults

**Still open**
1. None found in the records for BSETRESET.

**Already fixed in this build, not yet seen working in AutoCAD**
1. None.

**Partly fixed**
1. None.

**New in code, no bug covers it**
1. **Says "cleared" when the clear failed.** If the store cannot write, the error is swallowed and the line "All inside-points cleared for this drawing." still prints. The points are then still there.
2. **Says "cleared" when there was nothing to clear,** and adds an empty record to the drawing.
3. **No question before clearing every point.** For a drawing with several buildings, one slip loses all the inside points.
4. **No read-only or model-space check.** The other beam commands refuse a read-only drawing. BSETRESET changes it.
5. **The registry text uses words from the code:** "Removes all inside-points stored in the drawing's XRecord."

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the command file or the inside-point store).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 2.1, 3.1, 3.2, 4.1-4.3:** `Commands\BeamInsidePointCommands.cs:57-75`; `Services\BeamInsidePointStore.cs:80-96`, `141-169`.
2. **1.2:** `Commands\BeamInsidePointCommands.cs:53-56` (the comment); `..\Structural.DesignCore\ConnectedDesign\BeamPlacementPlanner.cs:336-373`; `Services\ConnectedDesign\Host\BeamCommandAutoCadInsidePointProposalAdapter.cs:130-135`.
3. **2.2, 7 new 2:** `Services\BeamInsidePointStore.cs:153-165` (writes an empty list and creates the entry when it is missing).
4. **2.3:** `Services\BeamInsidePointStore.cs:86-90`; no save call in `Commands\BeamInsidePointCommands.cs`.
5. **2.4, 3.4:** the command and the store touch no beam, line or text (`Commands\BeamInsidePointCommands.cs:57-75`).
6. **2.5:** `Commands\BeamInsidePointCommands.cs:61, 67`; `Services\CommandHistoryService.cs:48-69, 79-89`.
7. **3.3, 7 new 4:** `Commands\BeamInsidePointCommands.cs:60-65` (no pre-flight call; compare `Services\DrawingSafetyService.cs:35-41`).
8. **5.2:** `..\Structural.DesignCore\ConnectedDesign\BeamRefusalWording.cs:244-259`.
9. **6.1:** `Services\BeamInsidePointStore.cs:86-90`.
10. **7 new 1:** `Services\BeamInsidePointStore.cs:92-95` (the catch only logs); `Commands\BeamInsidePointCommands.cs:65-66`.
11. **7 new 3:** `Commands\BeamInsidePointCommands.cs:63-67`.
12. **7 new 5:** `Assets\Config\command-registry.json:2176-2190`.
13. **8.1:** no `#if` in `Commands\BeamInsidePointCommands.cs` or `Services\BeamInsidePointStore.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
