# TOOL NOTE: Set an inside point (BSET)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Asks you to click a point inside the building** and saves it in this drawing.
2. **The beam commands use it for lintel marks** (marks starting with L or RL on Settings). They put those marks on the outside, the side away from the saved point.
3. **You can save more than one point,** one for each separate building. A beam uses the saved point nearest to its middle.
4. **It draws nothing.** The point is not shown on screen.

## 2. What it changes in the drawing

1. **Adds the point to a record kept in the drawing** (a named entry that holds the list of inside points). It is stored in drawing units, as clicked.
2. **Creates that record if the drawing has none.**
3. **No object, layer or label is drawn,** and no layer is changed.
4. **The drawing counts as changed,** so closing it asks to save. The command never saves.
5. **Not the drawing:** a line in CE's command history on the PC (the command, the drawing file name, the point and the new total).

## 3. What it will not do

1. **Does not check** whether the drawing is read-only, which space you are in, or REFEDIT (see 7).
2. **Does not check for a duplicate or a point too close to an old one.** Every click is added.
3. **Does not remove a point.** Only BSETRESET does, and it removes all of them.
4. **Does not say which building a point belongs to.** BSETLIST shows the coordinates only.
5. **Does not draw the point,** so you cannot see where earlier points are except by BSETLIST.

## 4. What it asks you, and what Enter means

1. **"Click inside the building area: "** Click a point. Any answer that is not a point, Esc included, prints "Cancelled." and changes nothing.
2. **After a point:** "Inside-point added. Total stored for this drawing: N." with N read back from the drawing.
3. **If the code itself fails** before reaching the store: "BSET: CE could not store that inside-point. Nothing changed. The reason is in the CE log." Failures inside the store do not reach this line (see 7).

## 5. When it says Unknown or "needs checking"

1. **Not applicable.** It shows no worked-out value.
2. **If the beam commands later say the saved point "looks wrong"** ("Beam not placed: the saved inside-of-building point looks wrong for this drawing. Run BSETRESET, then BSET to set a fresh point."), run BSETLIST and look at the coordinates, then BSETRESET and BSET again.

## 6. How to undo it

1. **U once should take the point out again,** because the change is made inside the command. Not proven in AutoCAD, and not seen in the records read.
2. **BSETRESET** removes every point, not just the last.

## 7. Known faults

**Still open**
1. None found in the records for BSET.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1077:** the tooltip and help no longer say "seed the lintel outside-flip" or "persistent inside-point store". They now read "Pick a point inside the building so CE can put lintel labels outside." and "CE remembers the point in this drawing ... Pick another inside point for each separate building."

**Partly fixed**
1. None found.

**New in code, no bug covers it**
1. **Says "added" when the save failed.** If the store cannot write, the error is swallowed and the line "Inside-point added. Total stored for this drawing: N." still prints. N then shows the old total, so a drafter would have to notice the count did not go up.
2. **A turned UCS may store the wrong place.** The beam commands convert a clicked point from the current UCS to World before saving it. BSET saves the click as given, and its comment says that is already World. One of the two is wrong. Not known which from the code, and not tested.
3. **No model-space or REFEDIT check.** A point clicked on a layout tab is saved as an inside point for model space.
4. **No read-only check.** The other beam commands refuse a read-only drawing. BSET changes it.
5. **A limit nobody is told about.** The beam commands read at most 128 saved points. With more, they stop with "the saved inside-of-building point looks wrong" and say to run BSETRESET. BSET does not stop you at 128.
6. **Registry text for BSETLIST and BSETRESET still uses words from the code:** "inside-points stored in the drawing's XRecord". It does not say what a drafter should do with them.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the command file or the inside-point store).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 4.1-4.3:** `Commands\BeamInsidePointCommands.cs:19-51`.
2. **1.2:** `Models\UserSettings.cs:737`; `Services\ConnectedDesign\Host\BeamCommandAutoCadInsidePointProposalAdapter.cs:130-135`; `..\Structural.DesignCore\ConnectedDesign\BeamPlacementPlanner.cs:336-373`.
3. **1.3:** `Services\BeamInsidePointStore.cs:54-77`; `Services\ConnectedDesign\Host\BeamCommandAutoCadReadScope.cs:251-300` (the point nearest the beam's middle).
4. **1.4, 2.3:** `Commands\BeamInsidePointCommands.cs:19-51` (no drawing call other than the store); `Assets\Config\command-registry.json:2158-2175` ("No drawing layer changes.").
5. **2.1, 2.2:** `Services\BeamInsidePointStore.cs:141-169` (three numbers per point; entry created at 155-165); key at line 23.
6. **2.4:** `Services\BeamInsidePointStore.cs:60-71` (written through the drawing's own database); no save call in `Commands\BeamInsidePointCommands.cs`.
7. **2.5:** `Commands\BeamInsidePointCommands.cs:23, 40-43`; `Services\CommandHistoryService.cs:48-69, 79-89`.
8. **3.1, 7 new 3, 4:** `Commands\BeamInsidePointCommands.cs:22-27` (no pre-flight call; compare `Services\ConnectedDesign\Host\BeamCommandAutoCadContext.cs:47-56` and `Services\DrawingSafetyService.cs:35-41`).
9. **3.2:** `Services\BeamInsidePointStore.cs:62-70`.
10. **3.3:** `Commands\BeamInsidePointCommands.cs:57-75`.
11. **5.2:** `..\Structural.DesignCore\ConnectedDesign\BeamRefusalWording.cs:257-259`.
12. **6.1:** `Services\BeamInsidePointStore.cs:60-71`; the record BUG-182 and BUG-183 show one-U checks for other CE writes only.
13. **7 BUG-1077:** `Assets\Config\command-registry.json:2164-2165`; the other two places named in the bug, `Services\RibbonCommandHubService.cs:1031` and `UI\Dialogs\CommandHelpWindow.xaml.cs:334-335`, print the registry's short and long text; the old words are found only in code comments (search for "seed the lintel", "persistent inside-point").
14. **7 new 1:** `Services\BeamInsidePointStore.cs:54-77`; `Commands\BeamInsidePointCommands.cs:37-39`.
15. **7 new 2:** `Commands\BeamInsidePointCommands.cs:36-37`; `Services\ConnectedDesign\Host\BeamCommandAutoCadInsidePointProposalAdapter.cs:198-199`.
16. **7 new 5:** `Services\ConnectedDesign\Host\BeamCommandAutoCadInsidePointProposalAdapter.cs:136-139`; `Services\ConnectedDesign\Host\BeamCommandAutoCadInsidePointStoreEvidenceReader.cs:170-181`; `..\Structural.DesignCore\ConnectedDesign\BeamRefusalWording.cs:244-259`.
17. **7 new 6:** `Assets\Config\command-registry.json:2176-2206`.
18. **8.1:** no `#if` in `Commands\BeamInsidePointCommands.cs` or `Services\BeamInsidePointStore.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
