# TOOL NOTE: Beam with lower line (BDL)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws two parallel lines in one go:** a BEAM line between two points you pick, and a BEAM LOWER line beside it at a distance and on a side you choose.
2. **Puts a mark on each,** each mark on the side away from the other line. The BEAM mark is asked first, then the BEAM LOWER mark.
3. **Points only.** No support objects, no preview and Accept, no CONT., no inside-the-building point. Nothing like commands 1, 2, 4 and 5 after their rebuild.
4. **It is the one beam command still on its old code.** It was left until last on purpose, to be moved across after command 5 and tested.
5. **Tries to link the lines to nearby supports** when beam linking is on in Settings (it is on as shipped).

## 2. What it changes in the drawing

1. **A BEAM line and a BEAM LOWER line,** drawn straight away, before you are asked for any text. Layer names come from Settings (BEAM and BEAM LOWER as shipped). Colours 4 and 2, linetypes Continuous and HIDDEN.
2. **Two marks on 25TEXT,** placed by the older label routine.
3. **Layers are created if missing** (an existing layer keeps its lock, freeze, on/off and colour). While it runs it makes each layer current, and at the end puts back the current layer, command echo, object snap setting and MIRRTEXT.
4. **The view is zoomed:** ZOOM Object on the first line, then ZOOM 0.7X.
5. **Each line is its own write,** not one write for the pair.
6. **Link records,** when Settings beam linking is on: it records each line, looks for a support block (a block whose name contains SUPPORT) within 250 drawing units of each end, and links the mark.
7. **The last BEAM text is remembered in Settings.** The Settings file is rewritten only when something changed. The drawing is never saved.

## 3. What it will not do

1. **Drawing read-only:** stops. It prints "[CE_STRUC] BDL: the drawing is read-only. Save a copy you can edit first."
2. **Beam shorter than 50 drawing units:** "Beam not placed: the two points you picked are too close together. Pick a longer beam line." There is no unit conversion (see 7), so in a metre drawing that is 50 m.
3. **Offset distance of zero or less:** the prompt does not accept it.
4. **Does not check the drawing's units, the space you are in, REFEDIT or locked layers.** Only the read-only check is made (see 7).
5. **Does not show a preview or ask Accept.** Cancelling part way leaves the lines drawn (see 7).
6. **Settings values out of range** are put back to their defaults for this run, with "One or more Beam Settings values were out of range and have been reset to their defaults for this command. Check CE Settings > Beam."

## 4. What it asks you, and what Enter means

1. **"Specify the START point: "** Esc ends the command with no message.
2. **"Specify the END point (drag preview): "** A line and a short tick showing the offset follow the cursor. Esc ends the command with no message.
3. **"BEAM LOWER offset side [N/S] <N>: "** The two letters are the compass sides across the beam (N/S, or E/W for an upright beam). Enter is the first letter shown. Esc ends the command.
4. **"BEAM LOWER offset distance <100>: "** The default is the Settings support-block face offset (100 as shipped), in drawing units. Enter takes it. Esc ends the command.
5. **"Enter BEAM text <last>: "** or "Enter BEAM text: ". Enter takes the shown text. With none shown, Enter ends the command with no message. Esc ends it. Both leave the two lines drawn.
6. **"Enter BEAM LOWER text <BEAM text>: "** Enter takes the BEAM text. Esc ends it, leaving the lines and the first mark.

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** The only refusal lines are the ones in section 3 and these two.
2. **"Beam not placed: CE could not draw the BEAM line - no drawing is available to write to. Try the command again."** Nothing was drawn.
3. **"BEAM LOWER not placed: CE could not draw the second line (the BEAM line above was drawn - Undo removes it if you want to start again). No drawing is available to write to. Try the command again."**
4. **Lines printed by the older label routine** (when it cannot place a mark): not known (that routine was not read for this note).

## 6. How to undo it

1. **Not known whether one U removes everything.** The two lines are separate writes, and two ZOOM commands run inside the command. No test of BDL's Undo is in the records read.
2. **If the second line fails,** the line above says Undo removes the first.

## 7. Known faults

**Still open**
1. **BUG-050:** the mark side depended on which end was picked first. BDL still uses the label routine named in the bug. Whether reversed ends give the same side in BDL: not traced.

**Already fixed in this build, not yet seen working in AutoCAD**
1. None found for BDL.

**Partly fixed**
1. None found for BDL.

**New in code, no bug covers it**
1. **No units.** The 50 minimum, the 100 offset default, the 250 support search and the mark offsets are applied as drawing units. In a metre drawing a beam under 50 m is refused as "too close together", the offset default is 100 m, and a support block up to 250 m away can be linked. Commands 1, 2, 4 and 5 scale or refuse.
2. **Cancel leaves the drawing changed.** Esc, or Enter with no text shown, at "Enter BEAM text" or "Enter BEAM LOWER text" ends the command with both lines already in the drawing and no message.
3. **No model-space or REFEDIT check.** The lines are always drawn in Model space, whichever space you picked the points in. On a layout tab they would land at the layout's coordinates.
4. **No locked-layer check** on BEAM, BEAM LOWER or 25TEXT. The lines are added to the layer as it stands. Whether AutoCAD accepts new lines on a locked layer: not known. Commands 1, 2, 4 and 5 refuse that case.
5. **The view is zoomed with no line saying so,** and the zoom is not part of an Undo.
6. **The last mark is stored for the other beam commands too:** after BDL, commands 1, 2, 4 and 5 offer BDL's mark as their default text.
7. **Layer names come from Settings here, but not in commands 1, 2, 4 and 5.** The same Settings box gives two different results.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the beam command file, the beam service, the label routine or the inside-point store).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. Paths that start `Structural.DesignCore\` (or `..\Structural.DesignCore\`) are under `Modules\`, beside `Structural\`, not inside it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).

1. **1.1, 1.2, 4.3-4.6:** `Commands\BeamPlacementCommands.cs:93-231`; registry `Assets\Config\command-registry.json:2135-2155`.
2. **1.3:** `Commands\BeamPlacementCommands.cs:110-112, 202, 214` (PointsOnly, no suffix, no inside point); `Services\BeamService.cs:49-63`.
3. **1.4:** `Commands\BeamPlacementCommands.cs:7-15`.
4. **1.5, 2.6:** `Commands\BeamPlacementCommands.cs:218-219, 688-735, 739-800`; `Services\BeamLinkService.cs:26-32, 52-53, 104-105`; `Models\UserSettings.cs:523`.
5. **2.1:** `Commands\BeamPlacementCommands.cs:106-107, 159, 172`; `Services\BeamDraftingStandards.cs:20-32`; `Services\BeamService.cs:85-100`.
6. **2.2:** `Commands\BeamPlacementCommands.cs:185, 201-203, 213-215`; `Services\BeamDraftingStandards.cs:25`.
7. **2.3:** `Services\BeamService.cs:22-47, 70-84`; `Services\LayerService.cs:206-216`; `Commands\BeamPlacementCommands.cs:102-107, 226-229`.
8. **2.4, 7 new 5:** `Services\BeamService.cs:537-551`; `Commands\BeamPlacementCommands.cs:184`.
9. **2.5, 6.1:** `Services\BeamService.cs:85-100`; `Commands\BeamPlacementCommands.cs:159, 172`.
10. **2.7:** `Commands\BeamPlacementCommands.cs:190-194, 229`; `Services\SettingsService.cs:124-138`.
11. **3.1:** `Commands\BeamPlacementCommands.cs:97`; `Services\DrawingSafetyService.cs:35-41`.
12. **3.2:** `Commands\BeamPlacementCommands.cs:121-127`; `Services\BeamDraftingStandards.cs:78`; `Services\BeamService.cs:65-68`.
13. **3.3:** `Commands\BeamPlacementCommands.cs:146-152`.
14. **3.4, 7 new 1, 3, 4:** `Commands\BeamPlacementCommands.cs:97-110` (the only check made); no INSUNITS, DrawingUnit or UnitFactor in `Commands\BeamPlacementCommands.cs`, `Services\BeamService.cs` or `Services\BeamTextPlacementService.cs` (search); `Services\BeamService.cs:92-93` (writes to Model space); `Services\LayerService.cs:206-216`.
15. **3.5, 7 new 2:** `Commands\BeamPlacementCommands.cs:159-172` (lines drawn), `191-192, 206-207, 201-203, 213-215` (the returns).
16. **3.6:** `Commands\BeamPlacementCommands.cs:808-836`.
17. **4.1, 4.2:** `Commands\BeamPlacementCommands.cs:110-112, 269-279`; `Services\BeamService.cs:1146-1170`.
18. **4.3:** `Commands\BeamPlacementCommands.cs:132-141, 233-241`; `Services\BeamService.cs:1108-1144`.
19. **4.4:** `Commands\BeamPlacementCommands.cs:145-156`; `Models\UserSettings.cs:554`.
20. **4.5, 4.6:** `Commands\BeamPlacementCommands.cs:190-216, 1476-1517`.
21. **5.2, 5.3:** `Commands\BeamPlacementCommands.cs:160-181`.
22. **7 BUG-050:** `Commands\BeamPlacementCommands.cs:201-203, 213-215`; record BUG-050.
23. **7 new 6:** `Commands\BeamPlacementCommands.cs:193-194`; `Services\ConnectedDesign\Host\BeamCommandSettingsSnapshotReader.cs:137-139`.
24. **7 new 7:** `Commands\BeamPlacementCommands.cs:106-107` and `Services\BeamDraftingStandards.cs:22-23` (BDL reads the Settings names); `..\Structural.DesignCore\ConnectedDesign\BeamAtomicCommitAdmission.cs:25-42` (commands 1 and 2 write fixed names).
25. **8.1:** no `#if` in `Commands\BeamPlacementCommands.cs`, `Services\BeamService.cs`, `Services\BeamTextPlacementService.cs`, `Services\BeamInsidePointStore.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
