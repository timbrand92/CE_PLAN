# TOOL NOTE: Regular beam (1)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws one regular beam** as a line on layer BEAM, with its beam mark on 25TEXT, after you have seen a temporary preview and said Accept.
2. **Each end can be a support block, a line or a picked point,** in any mix. It can also start from objects you selected before typing 1.
3. **Puts the mark on the side with room.** It tries one side of the beam, switches to the other if the first is fully blocked, and asks you if neither is clear.
4. **Marks starting with L or RL are treated as lintels** (the list is on Settings). Those go on the outside, decided by an "inside the building" point (see BSET).
5. **May shorten an end** where it sits on a beam line crossing at about a right angle. The preview shows the shortened line. Which lines count: not known (reader not read).
6. **Asks about CONT.** when it finds a support under the middle of the beam.

## 2. What it changes in the drawing

1. **A beam line** on BEAM (colour 4, Continuous).
2. **A beam mark** on 25TEXT (colour 7), as single-line or multi-line text, chosen by CE.
3. **Layers BEAM and 25TEXT are created if missing.** The current layer is not changed.
4. **CE's record on the beam:** which support each end sits on, and its mark. A support is recorded only when you picked it as an object. A point picked near a column records no support.
5. **A small record of this placement,** so a repeat of the same placement cannot make a second beam. Plus the inside point, if you picked one at the lintel question.
6. **All of that is one write.** The code never saves the drawing.
7. **Not the drawing:** a line in the Structural log for every result.
8. **Later, outside this command:** when a picked support is moved, the beam end and mark follow and CE prints "CE moved ... One U undoes both."

## 3. What it will not do

1. **Drawing read-only:** stops. It prints "[CE_STRUC] BEAM-1: the drawing is read-only. Save a copy you can edit first." and then "Beam cancelled before CE checked the drawing. Nothing was written."
2. **Units must be millimetres, metres or inches.** Any other: "Beam not placed: this drawing's units are not millimetres, metres or inches, and CE does not guess or rescale a drawing. Type UNITS, set the insertion units to millimetres, metres or inches, then run the command again." The line does not say which unit the drawing has (the log does).
3. **Model space only.** On a layout tab or during REFEDIT it stops, but the line it prints is the wrong one (see 7).
4. **Old beam-link engine switched on in Settings:** "Beam not placed: the old command-8 beam-linking engine is switched on in CE Settings ... Switch the old engine off, then run the command again."
5. **A support or line inside an Xref:** "Beam not placed: that endpoint belongs to an Xref, which CE will not edit." Only a CE support block, a straight line or one polyline segment can be an end.
6. **Beam shorter than 50 mm** (scaled for the drawing units): "Beam not placed: the two points you picked are too close together. Pick a longer beam line."
7. **The same support or line for both ends** is refused.
8. **Layers BEAM or 25TEXT locked, off, frozen, recoloured or with another linetype:** refused before writing, never unlocked. The line it shows is wrong (see 7).
9. **Mark blank, or longer than 512 characters:** stops. The line it shows is wrong (see 7).
10. **Does not use the layer names on Settings.** It always writes BEAM and 25TEXT (see 7).

## 4. What it asks you, and what Enter means

1. **Selected 1 or 2 objects first:** it uses them and does not ask for ends. If they are not usable it asks as below.
2. **"Select the first support (a support block or a line), or press Enter to pick points: "** Enter takes points. Esc: "Beam cancelled. Nothing was written." Asked only while Settings "merge" is on (the shipped setting). Off: points only.
3. **After a support:** "Select the end support (a support block or a line), or press Enter to pick a point: " Enter asks "Specify the END point: ".
4. **After a line:** "Select the end support (a support block or a line), or [Point/WholeLine] <WholeLine>: " Enter uses the whole picked line as the beam.
5. **Points route:** "Specify the START point: " then "Specify the END point or [Object]: ".
6. **"Enter text <last>: "** (or "Enter text: " with no remembered text). Enter takes the shown text. With no text shown, Enter fails (see 7).
7. **Lintel mark and no inside point saved:** "No inside-points saved. Click inside the building to propose one (or Enter to skip): " Enter skips, and the beam is then refused: "Beam not placed: no inside-of-building point in this drawing. Pick one now, or run BSET." The point is saved only if the beam is placed.
8. **"Mid-span support detected. Add CONT. suffix? [Yes/No] <No>: "** Enter is No.
9. **"Use CE's best available text position? [Yes/No] <Yes>:"** Asked only when neither side is clear. Enter is Yes. No cancels: "Beam cancelled. Nothing was written."
10. **"Beam preview [Accept/Cancel] <Accept>: "** Enter accepts. Esc or Cancel: "Beam cancelled. Nothing was written." Nothing is written before Accept.

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** A missing fact becomes a refusal line or one of the questions above.
2. **"Beam result is uncertain. Do not repeat the command; inspect the drawing."** CE cannot confirm whether the beam was written. Look at the drawing and the Undo list before running it again.
3. **"Beam placed, but its post-write update needs review."** The beam is in. The step that tells the follow-along that a beam was added did not complete.

## 6. How to undo it

1. **U once.** It says "Beam placed. One UNDO removes the complete beam." The record says one U was seen to remove the beam on Structural 1.0.77. Not run on this build.
2. **The Structural log line stays.** It is not part of the drawing.

## 7. Known faults

**Still open**
1. **BUG-1139:** a copied beam keeps the original's support and mark links, and a column placed under the copy is recorded against the original's mark. Way round: not known.
2. **BUG-089:** filed against command 2 (lintel marks L2, L4 refused with no inside point found). The same lintel code serves command 1. See BEAM_2.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-185:** a 45 degree beam on a non-square column in a metre drawing no longer ties to the wrong side.
2. **BUG-085:** the old "XREF_OBJECT_LIMIT_EXCEEDED" wording is gone, and all four ends (object to object, object to point, point to object, point to point) are asked for.
3. **BUG-050:** the mark side no longer depends on which end you picked first (the beam is turned to run left to right, or bottom to top, before the side is chosen).

**Partly fixed**
1. **BUG-577:** units are refused up front, before any question, in plain words. Still open: the line does not name the drawing's unit.
2. **BUG-211:** erasing a column that carries a beam is no longer silent. CE prints that the beam end has no support and marks it Unresolved, and the beam stays. It still asks no question first, which is what the bug asked for.
3. **BUG-088:** the lintel case that stopped (outside side fully blocked) now places at the middle. A wall face parallel to the beam and up to 2000 (the search distance on Settings) away can still push the mark that far out, so a far-away mark is not ruled out.

**New in code, no bug covers it**
1. **Locked, frozen, off, or any colour or linetype other than CE's (BEAM 4 Continuous, 25TEXT 7 Continuous):** an existing BEAM or 25TEXT layer set up differently refuses every beam, with "Beam not placed. CE hit an internal problem it could not put into a plain reason. Nothing was drawn. Try again; if it repeats, turn on STRUCDEBUG and send the Structural log to the office." The real reason is not said.
2. **Layout tab or REFEDIT:** it prints "Beam not placed: CE hit an internal problem at the drawing check step. Nothing was drawn." The real reason (not in model space) is not said.
3. **Enter at "Enter text:" with nothing shown** prints "Beam not placed: one of the command-line prompts did not complete properly. Try the command again."
4. **"Remember last choices" does not remember the mark** for 1, 2, 4 or 5. Only BDL stores it, so after BDL the mark BDL used is offered here.
5. **Any mark starting with L or RL** (so also LVL1, say) is a lintel and brings the inside-point question.
6. **The end shortening is not named in any line.** Only the preview shows it.
7. **Layer names on Settings are ignored.** BEAM, BEAM LOWER and 25TEXT are fixed in the commit code.
8. **Walls and openings are found by words in the layer name** (WALL, WINDOW, DOOR). A wall on a layer named otherwise does not steer the mark side.

Closed earlier by Codex on other builds, not repeated here: BUG-182, BUG-183, BUG-184.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the beam command file, the Host, Commit or Preview folders, or the DesignCore beam files).
2. **One difference outside this command:** CE's own beam and column grips for editing a followed beam exist only on 2027. On 2022 to 2026 AutoCAD's plain grips are used.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\`. S = `Structural\`, H = `Structural\Services\ConnectedDesign\Host\`, C = `Structural\Services\ConnectedDesign\Commit\`, D = `Structural.DesignCore\ConnectedDesign\`.

1. **1.1:** `S\Commands\BeamPlacementCommands.cs:56-62`; `H\BeamCommandAutoCadRoute.cs:96-139, 292-313`; `C\AutoCadBeamAtomicWriteGateway.cs:192-261`; `D\BeamAtomicCommitAdmission.cs:25-33`.
2. **1.2:** `H\BeamCommandAutoCadPromptAdapter.cs:163-183, 185-307, 326-391, 453-497`.
3. **1.3:** `D\BeamPlacementPlanner.cs:301-304, 374-402, 443-486`; `H\BeamCommandAutoCadPlacementEvidenceReader.cs:171-179`.
4. **1.4:** `D\BeamLabelClassification.cs` (whole file); `S\Models\UserSettings.cs:737`; `D\BeamPlacementPlanner.cs:336-373, 404-430`; `H\BeamCommandAutoCadPromptAdapter.cs:71-75`.
5. **1.5:** `D\BeamAxisEndAdjustment.cs:16-18`; `H\BeamCommandSettingsSnapshotReader.cs:130-143`; `S\Models\UserSettings.cs:538, 569-575`.
6. **1.6:** `H\BeamCommandAutoCadRoute.cs:245-278`; `D\BeamCommandHostFlow.cs:206-221`.
7. **2.1, 2.2:** `D\BeamAtomicCommitAdmission.cs:25-33`; `C\AutoCadBeamAtomicWriteGateway.cs:192-261`.
8. **2.3:** `C\BeamAtomicLayerWriter.cs:72-83`; no CLAYER write in `S\Services\ConnectedDesign` (search).
9. **2.4:** `C\AutoCadBeamAtomicWriteGateway.cs:263-331` (support links at 270-305).
10. **2.5, 2.6:** `C\AutoCadBeamAtomicWriteGateway.cs:333, 409-447`; `C\AutoCadBeamInsidePointAtomicWriter.cs:75-78`; no save call in the Host, Commit or Preview folders (search for Save, QSAVE, SendStringToExecute).
11. **2.7:** `H\BeamCommandAutoCadRoute.cs:384-388`.
12. **2.8:** `S\Services\BeamLinkService.ConnectedFollowApply.cs:548-553`.
13. **3.1:** `H\BeamCommandAutoCadRoute.cs:44-55`; `S\Services\DrawingSafetyService.cs:35-41`; `D\BeamRefusalWording.cs:168-169`.
14. **3.2, 7 BUG-577:** `H\BeamCommandAutoCadPromptAdapter.cs:34-41`; `D\BeamRefusalWording.cs:212-216`; `H\BeamCommandAutoCadRenderPort.cs:65-103`.
15. **3.3, 7 new 2:** `H\BeamCommandAutoCadContext.cs:47-75`; `H\BeamCommandAutoCadRoute.cs:155-175`; `D\BeamRefusalWording.cs:626-649`.
16. **3.4:** `H\BeamCommandAutoCadRoute.cs:69-75`; `D\BeamRefusalWording.cs:186-189`.
17. **3.5:** `H\BeamCommandAutoCadPromptAdapter.cs:598-617, 711-717`; `D\BeamRefusalWording.cs:292-295, 347-350`.
18. **3.6:** `S\Services\BeamDraftingStandards.cs:78`; `H\BeamCommandAutoCadPromptAdapter.cs:48-50, 404-408`; `D\BeamRefusalWording.cs:231-233`.
19. **3.7:** `H\BeamCommandAutoCadPromptAdapter.cs:294-298`; `D\BeamRefusalWording.cs:336-338`.
20. **3.8, 7 new 1:** `C\BeamAtomicLayerWriter.cs:61-70`; `C\BeamAtomicWriteSession.cs:112-116`; `D\BeamAtomicCommitCoordinator.cs:107-117`; `H\BeamCommandAutoCadRoute.cs:446-467`; `D\BeamRefusalWording.cs:80-84, 568-608`.
21. **3.9, 7 new 3:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750, 61-70`; `D\BeamRefusalWording.cs:546-548, 587-591`.
22. **3.10, 7 new 7:** `D\BeamAtomicCommitAdmission.cs:25-42`; `S\Models\UserSettings.cs:439, 442`.
23. **4.1:** `H\BeamCommandAutoCadPromptAdapter.cs:163-183`.
24. **4.2:** `H\BeamCommandAutoCadPromptAdapter.cs:149-161, 185-198`; `S\Models\UserSettings.cs:517`; `D\BeamRefusalWording.cs:571-575`; `H\BeamCommandAutoCadRoute.cs:464-466`.
25. **4.3, 4.4:** `H\BeamCommandAutoCadPromptAdapter.cs:226-239, 247-280, 426-427`.
26. **4.5:** `H\BeamCommandAutoCadPromptAdapter.cs:326-345`.
27. **4.6:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750`; `H\BeamCommandSettingsSnapshotReader.cs:137-139`.
28. **4.7:** `H\BeamCommandAutoCadInsidePointProposalAdapter.cs:130-135, 182-185`; `D\BeamPlacementPlanner.cs:338-345`; `H\BeamCommandAutoCadPlacementEvidenceReader.cs:259-263`; `D\BeamRefusalWording.cs:241-243`; `C\AutoCadBeamAtomicWriteGateway.cs:333`.
29. **4.8:** `H\BeamCommandAutoCadRoute.cs:256-278`.
30. **4.9:** `D\BeamCommandHostFlow.cs:48-49, 51-63, 258-283`; `D\BeamPlacementPlanner.cs:463-486`; `D\BeamCommandPreviewPlanner.cs:161-162`.
31. **4.10, 5.2, 5.3:** `H\BeamCommandAutoCadRoute.cs:292-313, 404-444`.
32. **6.1:** `H\BeamCommandAutoCadRoute.cs:411-412`; `C\AutoCadBeamAtomicWriteGateway.cs:333, 440-447`; record BUG-182 (Codex pass 13, Structural 1.0.77).
33. **7 Still open BUG-1139:** `S\Services\BeamLinkService.cs:73-86`; record BUG-1139 (the copy-detection step only runs with the old engine on: `S\Services\BeamLinkService.Reactors.cs:395-416`).
34. **7 BUG-185:** `D\BeamCommandSourceCompatibility.cs:689-707`.
35. **7 BUG-085:** `H\BeamCommandAutoCadPromptAdapter.cs:185-307, 326-391`; the code string XREF_OBJECT_LIMIT_EXCEEDED is not found anywhere in the code (search).
36. **7 BUG-050:** `D\BeamPlacementPlanner.cs:301-304`; `D\BeamAxisEndAdjustment.cs:7-13`.
37. **7 BUG-211:** `S\Services\BeamLinkService.Reactors.cs:395-400`; `S\Services\SupportErasedPlanner.cs:412-440`; `S\Services\BeamLinkService.SupportErased.cs:36-53`.
38. **7 BUG-088:** `D\BeamPlacementPlanner.cs:404-430`; `H\BeamCommandAutoCadPlacementMath.cs:88-141`; `D\BeamCommandHostModels.cs:67, 92`; `H\BeamCommandSettingsSnapshotReader.cs:141`; `S\Models\UserSettings.cs:494`.
39. **7 new 4:** `S\Commands\BeamPlacementCommands.cs:194, 412, 610` (the only writers of the remembered mark, in BDL and in code no command reaches); `H\BeamCommandSettingsSnapshotReader.cs:137-139`.
40. **7 new 5:** `D\BeamLabelClassification.cs`; `S\Models\UserSettings.cs:737`.
41. **7 new 6:** `H\BeamCommandAutoCadRoute.cs:384-391` (the only text the route writes); `D\BeamAxisEndAdjustment.cs:16-18`.
42. **7 new 8:** `S\Commands\BeamPlacementCommands.cs:1296-1372`; `H\BeamCommandAutoCadReadScope.cs:467-470`.
43. **8.1:** no `#if` in `BeamPlacementCommands.cs`, `H\*.cs`, `C\*.cs`, `S\Services\ConnectedDesign\Preview\*.cs`, `D\*.cs`, `BeamLinkService*.cs`. **8.2:** `S\Services\StructuralFrameGripOverrule.cs:12-17, 45-47, 61-79`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
