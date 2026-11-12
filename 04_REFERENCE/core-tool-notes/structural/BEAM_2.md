# TOOL NOTE: Lower beam (2)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws one lower beam** as a line on layer BEAM LOWER (dashed, HIDDEN), with its beam mark on 25TEXT, after you have seen a temporary preview and said Accept.
2. **Each end can be a support block, a line or a picked point,** in any mix. It can also start from objects you selected before typing 2.
3. **Puts the mark on the side with room.** It tries one side, and switches to the other only if the first is fully blocked and the other fully clear.
4. **Marks starting with L or RL are treated as lintels** (the list is on Settings). Those go on the outside, decided by an "inside the building" point (see BSET).
5. **May shorten an end** where it sits on a beam line crossing at about a right angle. The preview shows the shortened line. Which lines count: not known (reader not read).
6. **Asks about CONT.** when it finds a support under the middle of the beam.
7. **Difference from 1:** no "best available text position" question. When neither side is clear it stops (see 7).

## 2. What it changes in the drawing

1. **A beam line** on BEAM LOWER (colour 2, linetype HIDDEN).
2. **A beam mark** on 25TEXT (colour 7), as single-line or multi-line text, chosen by CE.
3. **Layers BEAM LOWER and 25TEXT are created if missing.** The current layer is not changed. The HIDDEN linetype is not loaded for you (see 3).
4. **CE's record on the beam:** which support each end sits on, and its mark. A support is recorded only when you picked it as an object. A point picked near a column records no support.
5. **A small record of this placement,** so a repeat of the same placement cannot make a second beam. Plus the inside point, if you picked one at the lintel question.
6. **All of that is one write.** The code never saves the drawing.
7. **Not the drawing:** a line in the Structural log for every result.
8. **Later, outside this command:** when a picked support is moved, the beam end and mark follow and CE prints "CE moved ... One U undoes both."

## 3. What it will not do

1. **Drawing read-only:** stops. It prints "[CE_STRUC] BEAM-2: the drawing is read-only. Save a copy you can edit first." and then "Beam cancelled before CE checked the drawing. Nothing was written."
2. **Units must be millimetres, metres or inches.** Any other: "Beam not placed: this drawing's units are not millimetres, metres or inches, and CE does not guess or rescale a drawing. Type UNITS, set the insertion units to millimetres, metres or inches, then run the command again." The line does not say which unit the drawing has (the log does).
3. **Model space only.** On a layout tab or during REFEDIT it stops, but the line it prints is the wrong one (see 7).
4. **Old beam-link engine switched on in Settings:** "Beam not placed: the old command-8 beam-linking engine is switched on in CE Settings ... Switch the old engine off, then run the command again."
5. **A support or line inside an Xref:** "Beam not placed: that endpoint belongs to an Xref, which CE will not edit." Only a CE support block, a straight line or one polyline segment can be an end.
6. **Beam shorter than 50 mm** (scaled for the drawing units): "Beam not placed: the two points you picked are too close together. Pick a longer beam line."
7. **The same support or line for both ends** is refused.
8. **Layers BEAM LOWER or 25TEXT locked, off, frozen, recoloured or with another linetype,** or a drawing with no HIDDEN linetype loaded: refused before writing, never unlocked, never loaded. The line it shows is wrong (see 7).
9. **Mark blank, or longer than 512 characters:** stops. The line it shows is wrong (see 7).
10. **Does not use the layer names on Settings.** It always writes BEAM LOWER and 25TEXT (see 7).

## 4. What it asks you, and what Enter means

1. **Selected 1 or 2 objects first:** it uses them and does not ask for ends. If they are not usable it asks as below.
2. **"Select the first support (a support block or a line), or press Enter to pick points: "** Enter takes points. Esc: "Beam cancelled. Nothing was written." Asked only while Settings "merge" is on (the shipped setting). Off: points only.
3. **After a support:** "Select the end support (a support block or a line), or press Enter to pick a point: " Enter asks "Specify the END point: ".
4. **After a line:** "Select the end support (a support block or a line), or [Point/WholeLine] <WholeLine>: " Enter uses the whole picked line as the beam.
5. **Points route:** "Specify the START point: " then "Specify the END point or [Object]: ".
6. **"Enter text <last>: "** (or "Enter text: " with no remembered text). Enter takes the shown text. With no text shown, Enter fails (see 7).
7. **Lintel mark and no inside point saved:** "No inside-points saved. Click inside the building to propose one (or Enter to skip): " Enter skips, and the beam is then refused: "Beam not placed: no inside-of-building point in this drawing. Pick one now, or run BSET." The point is saved only if the beam is placed.
8. **"Mid-span support detected. Add CONT. suffix? [Yes/No] <No>: "** Enter is No.
9. **"Beam preview [Accept/Cancel] <Accept>: "** Enter accepts. Esc or Cancel: "Beam cancelled. Nothing was written." Nothing is written before Accept.

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** A missing fact becomes a refusal line or one of the questions above.
2. **"Beam result is uncertain: CE cannot confirm whether the beam was written. Do not repeat the command — check the drawing and the Undo list first."** (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`): the shorter wording shows only when no reason is attached, and an uncertain result always carries one (`Structural.DesignCore\ConnectedDesign\BeamRefusalWording.cs:311-314`). CE cannot confirm whether the beam was written. Look at the drawing and the Undo list before running it again.
3. **"Beam placed, but its post-write update needs review."** The beam is in. The step that tells the follow-along that a beam was added did not complete.
4. **A lintel mark that cannot find a clear outside spot:** "Beam not placed: CE could not tell which side of the beam to use for the label. Run BSET to set an inside-of-building point, then try again." This line is also given when the point exists and the outside is only partly read.

## 6. How to undo it

1. **U once.** It says "Beam placed. One UNDO removes the complete beam." The record says one U was seen to remove a beam on Structural 1.0.77 (command 1 and 4 tests). Not run for command 2 on this build.
2. **The Structural log line stays.** It is not part of the drawing.

## 7. Known faults

**Still open**
1. **BUG-089:** lintel marks L2 and L4 were refused with "no inside-of-building point" although a point was given. The code still refuses with that line when no saved point is found and the "propose one" question is skipped or switched off. What went wrong in the recorded case is not traced. Way round: run BSET first.
2. **BUG-1139:** a copied beam keeps the original's support and mark links. Way round: not known.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-185:** a 45 degree beam on a non-square column in a metre drawing no longer ties to the wrong side.
2. **BUG-050:** the mark side no longer depends on which end you picked first (the beam is turned to run left to right, or bottom to top, before the side is chosen).

**Partly fixed**
1. **BUG-088:** a lintel mark whose outside side is fully read but blocked (the L4 case) now places at the middle instead of stopping. A wall face parallel to the beam and up to 2000 away (the search distance on Settings) can still push a mark that far out, so a far-away mark is not ruled out.
2. **BUG-577:** units are refused up front, before any question, in plain words. Still open: the line does not name the drawing's unit.
3. **BUG-211:** erasing a column that carries a beam is no longer silent: CE prints that the beam end has no support and marks it Unresolved, and the beam stays. It still asks no question first, which is what the bug asked for.

**New in code, no bug covers it**
1. **Locked, frozen, off, or any colour or linetype other than CE's (BEAM LOWER 2 HIDDEN, 25TEXT 7 Continuous), or no HIDDEN linetype in the drawing:** refuses every beam with "Beam not placed. CE hit an internal problem it could not put into a plain reason. Nothing was drawn. Try again; if it repeats, turn on STRUCDEBUG and send the Structural log to the office." The real reason is not said.
2. **No room for the mark on either side (ordinary mark):** command 2 has no best-available question, and the code for this case has no plain wording. The line shown is probably the same "internal problem" line. Whether it is the first code reported: not known.
3. **Layout tab or REFEDIT:** it prints "Beam not placed: CE hit an internal problem at the drawing check step. Nothing was drawn." The real reason is not said.
4. **Enter at "Enter text:" with nothing shown** prints "Beam not placed: one of the command-line prompts did not complete properly. Try the command again."
5. **"Remember last choices" does not remember the mark** for 1, 2, 4 or 5. Only BDL stores it.
6. **Any mark starting with L or RL** (so also LVL1, say) is a lintel and brings the inside-point question.
7. **The end shortening is not named in any line.** Only the preview shows it.
8. **Layer names on Settings are ignored.** BEAM, BEAM LOWER and 25TEXT are fixed in the commit code.

Closed earlier by Codex on other builds, not repeated here: BUG-182, BUG-183, BUG-184.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the beam command file, the Host, Commit or Preview folders, or the DesignCore beam files).
2. **One difference outside this command:** CE's own beam and column grips for editing a followed beam exist only on 2027. On 2022 to 2026 AutoCAD's plain grips are used.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\`. S = `Structural\`, H = `Structural\Services\ConnectedDesign\Host\`, C = `Structural\Services\ConnectedDesign\Commit\`, D = `Structural.DesignCore\ConnectedDesign\`.

1. **1.1, 2.1:** `S\Commands\BeamPlacementCommands.cs:64-70`; `D\BeamAtomicCommitAdmission.cs:34-42`; `C\AutoCadBeamAtomicWriteGateway.cs:192-261`; `H\BeamCommandAutoCadRoute.cs:96-139, 292-313`.
2. **1.2:** `H\BeamCommandAutoCadPromptAdapter.cs:163-183, 185-307, 326-391, 453-497`.
3. **1.3:** `D\BeamPlacementPlanner.cs:301-304, 374-402, 443-461`; `H\BeamCommandAutoCadPlacementEvidenceReader.cs:171-179`.
4. **1.4:** `D\BeamLabelClassification.cs` (whole file); `S\Models\UserSettings.cs:737`; `D\BeamPlacementPlanner.cs:336-373, 404-430`; `H\BeamCommandAutoCadPromptAdapter.cs:71-75`.
5. **1.5:** `D\BeamAxisEndAdjustment.cs:16-18`; `H\BeamCommandSettingsSnapshotReader.cs:130-143`.
6. **1.6, 4.8:** `H\BeamCommandAutoCadRoute.cs:245-278`; `D\BeamCommandHostFlow.cs:206-221`.
7. **1.7, 7 new 2:** `D\BeamCommandPreviewPlanner.cs:161-162`; `D\BeamPlacementPlanner.cs:463-491`; `D\BeamRefusalWording.cs:163-512` (no entry for PLACEMENT_CONTEXT_UNRESOLVED); `D\BeamCommandHostFlow.cs:417` (issue codes passed on).
8. **2.2:** `D\BeamAtomicCommitAdmission.cs:34-42`; `C\AutoCadBeamAtomicWriteGateway.cs:206-261`.
9. **2.3, 3.8, 7 new 1:** `C\BeamAtomicLayerWriter.cs:44-47, 61-83`; `C\BeamAtomicWriteSession.cs:112-116`; `D\BeamAtomicCommitCoordinator.cs:107-117`; `H\BeamCommandAutoCadRoute.cs:446-467`; `D\BeamRefusalWording.cs:80-84, 568-608`.
10. **2.4:** `C\AutoCadBeamAtomicWriteGateway.cs:263-331` (support links at 270-305).
11. **2.5, 2.6:** `C\AutoCadBeamAtomicWriteGateway.cs:333, 409-447`; `C\AutoCadBeamInsidePointAtomicWriter.cs:75-78`; no save call in the Host, Commit or Preview folders (search for Save, QSAVE, SendStringToExecute).
12. **2.7:** `H\BeamCommandAutoCadRoute.cs:384-388`.
13. **2.8:** `S\Services\BeamLinkService.ConnectedFollowApply.cs:548-553`.
14. **3.1:** `H\BeamCommandAutoCadRoute.cs:44-55`; `S\Services\DrawingSafetyService.cs:35-41`; `D\BeamRefusalWording.cs:168-169`.
15. **3.2, 7 BUG-577:** `H\BeamCommandAutoCadPromptAdapter.cs:34-41`; `D\BeamRefusalWording.cs:212-216`; `H\BeamCommandAutoCadRenderPort.cs:65-103`.
16. **3.3, 7 new 3:** `H\BeamCommandAutoCadContext.cs:47-75`; `H\BeamCommandAutoCadRoute.cs:155-175`; `D\BeamRefusalWording.cs:626-649`.
17. **3.4:** `H\BeamCommandAutoCadRoute.cs:69-75`; `D\BeamRefusalWording.cs:186-189`.
18. **3.5:** `H\BeamCommandAutoCadPromptAdapter.cs:598-617, 711-717`; `D\BeamRefusalWording.cs:292-295, 347-350`.
19. **3.6:** `S\Services\BeamDraftingStandards.cs:78`; `H\BeamCommandAutoCadPromptAdapter.cs:48-50, 404-408`; `D\BeamRefusalWording.cs:231-233`.
20. **3.7:** `H\BeamCommandAutoCadPromptAdapter.cs:294-298`; `D\BeamRefusalWording.cs:336-338`.
21. **3.9, 7 new 4:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750, 61-70`; `D\BeamRefusalWording.cs:546-548, 587-591`.
22. **3.10, 7 new 8:** `D\BeamAtomicCommitAdmission.cs:25-42`; `S\Models\UserSettings.cs:439, 442`.
23. **4.1:** `H\BeamCommandAutoCadPromptAdapter.cs:163-183`.
24. **4.2:** `H\BeamCommandAutoCadPromptAdapter.cs:149-161, 185-198`; `S\Models\UserSettings.cs:517`; `D\BeamRefusalWording.cs:571-575`; `H\BeamCommandAutoCadRoute.cs:464-466`.
25. **4.3, 4.4:** `H\BeamCommandAutoCadPromptAdapter.cs:226-239, 247-280, 426-427`.
26. **4.5:** `H\BeamCommandAutoCadPromptAdapter.cs:326-345`.
27. **4.6:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750`; `H\BeamCommandSettingsSnapshotReader.cs:137-139`.
28. **4.7, 7 BUG-089:** `H\BeamCommandAutoCadInsidePointProposalAdapter.cs:130-135, 182-185`; `D\BeamPlacementPlanner.cs:338-345`; `H\BeamCommandAutoCadPlacementEvidenceReader.cs:239-268`; `D\BeamRefusalWording.cs:241-243`; `C\AutoCadBeamAtomicWriteGateway.cs:333`.
29. **4.9, 5.2, 5.3:** `H\BeamCommandAutoCadRoute.cs:292-313, 404-444`.
30. **5.4:** `D\BeamPlacementPlanner.cs:432-442`; `D\BeamRefusalWording.cs:428-431`.
31. **6.1:** `H\BeamCommandAutoCadRoute.cs:411-412`; `C\AutoCadBeamAtomicWriteGateway.cs:333, 440-447`; record BUG-182 (Codex pass 13, Structural 1.0.77, command 1 and command 4 only).
32. **7 BUG-1139:** `S\Services\BeamLinkService.cs:73-86`; `S\Services\BeamLinkService.Reactors.cs:395-416`.
33. **7 BUG-185:** `D\BeamCommandSourceCompatibility.cs:689-707`.
34. **7 BUG-050:** `D\BeamPlacementPlanner.cs:301-304`; `D\BeamAxisEndAdjustment.cs:7-13`.
35. **7 BUG-088:** `D\BeamPlacementPlanner.cs:404-430`; `H\BeamCommandAutoCadPlacementMath.cs:88-141`; `D\BeamCommandHostModels.cs:67, 92`; `H\BeamCommandSettingsSnapshotReader.cs:141`; `S\Models\UserSettings.cs:494`.
36. **7 BUG-211:** `S\Services\BeamLinkService.Reactors.cs:395-400`; `S\Services\SupportErasedPlanner.cs:412-440`.
37. **7 new 5:** `S\Commands\BeamPlacementCommands.cs:194, 412, 610`; `H\BeamCommandSettingsSnapshotReader.cs:137-139`.
38. **7 new 6:** `D\BeamLabelClassification.cs`; `S\Models\UserSettings.cs:737`.
39. **7 new 7:** `H\BeamCommandAutoCadRoute.cs:384-391` (the only text the route writes); `D\BeamAxisEndAdjustment.cs:16-18`.
40. **8.1:** no `#if` in `BeamPlacementCommands.cs`, `H\*.cs`, `C\*.cs`, `S\Services\ConnectedDesign\Preview\*.cs`, `D\*.cs`, `BeamLinkService*.cs`. **8.2:** `S\Services\StructuralFrameGripOverrule.cs:12-17, 45-47, 61-79`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
