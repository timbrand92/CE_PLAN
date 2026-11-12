# TOOL NOTE: Offset beam (5)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws one beam moved sideways from the line or points you pick,** by 45 or 100 mm toward a side you choose. It has the same extras as command 4: regular or lower, an optional shortening, and a suffix on the mark.
2. **Regular goes on layer BEAM, Lower on BEAM LOWER.** The mark goes on 25TEXT. You see a temporary preview and say Accept before anything is drawn.
3. **Each end can be a support block, a line or a picked point,** in any mix. The Settings "merge" switch does not matter here: command 5 always allows objects.
4. **The side choices follow the beam's direction:** North or South for a level beam, East or West for an upright one, and NW/SE or NE/SW for a diagonal one.
5. **The mark is placed by the same side-and-room rule as commands 1 and 2.** Marks starting with L or RL are lintels and go outside, using an inside-the-building point (see BSET).

## 2. What it changes in the drawing

1. **A beam line** on BEAM (colour 4, Continuous) or BEAM LOWER (colour 2, HIDDEN), at the offset position.
2. **A beam mark** on 25TEXT (colour 7): single-line text with no suffix, multi-line text with any suffix.
3. **Layers are created if missing.** The HIDDEN linetype is not loaded for you.
4. **CE's record on the beam:** which support each end sits on, and its mark. Only supports you picked as objects are recorded.
5. **A small record of this placement,** so a repeat cannot make a second beam. Plus the inside point, if you picked one at the question.
6. **All of that is one write.** The code never saves the drawing.
7. **Not the drawing:** a line in the Structural log for every result. The side and distance you chose last are kept in memory for this AutoCAD session only.
8. **Later, outside this command:** when a picked support moves, the beam end and mark follow and CE prints "CE moved ... One U undoes both."

## 3. What it will not do

1. **Drawing read-only:** stops. It prints "[CE_STRUC] BEAM-5: the drawing is read-only. Save a copy you can edit first." and then "Beam cancelled before CE checked the drawing. Nothing was written."
2. **Units must be millimetres, metres or inches,** checked before the first question: "Beam not placed: this drawing's units are not millimetres, metres or inches, and CE does not guess or rescale a drawing. Type UNITS, set the insertion units to millimetres, metres or inches, then run the command again." The line does not say which unit the drawing has (the log does).
3. **Model space only.** On a layout tab or during REFEDIT it stops with the wrong line (see 7).
4. **Old beam-link engine switched on in Settings:** "Beam not placed: the old command-8 beam-linking engine is switched on in CE Settings ... Switch the old engine off, then run the command again."
5. **A support or line inside an Xref** is refused. Only a CE support block, a straight line or one polyline segment can be an end.
6. **Beam shorter than 50 mm:** "Beam not placed: the two points you picked are too close together. Pick a longer beam line."
7. **Offset distances other than 45 or 100:** "Beam not placed: the offset distance must be 45 or 100. Run the command again and pick one of those two." The distance cannot be typed freely.
8. **Shortening that would leave the beam too short** is refused, with "shortening by that amount would leave the beam too short".
9. **Layers locked, off, frozen, recoloured or with another linetype,** or no HIDDEN linetype for a lower beam: refused before writing, never unlocked. The line it shows is wrong (see 7).
10. **Does not use the layer names on Settings.** It always writes BEAM, BEAM LOWER and 25TEXT.

## 4. What it asks you, and what Enter means

1. **"Choose beam type [Regular/Lower] <Regular>:"** (CE gives "Choose beam type"; AutoCAD adds the list and default). Enter is Regular, always. Esc: "Beam cancelled at the beam-type question. Nothing was written."
2. **Ends:** "Select the first support (a support block or a line), or press Enter to pick points: " and the follow-up questions exactly as for command 1.
3. **"Offset beam side [North/South] <North>:"** (CE gives "Offset beam side"; AutoCAD adds the two sides for this beam and the default). Enter is the first side offered, or the side you used last in this AutoCAD session when Settings "remember last choices" is on and that side is still offered.
4. **"Offset distance [45/100] <100>:"** Enter is 100, or the distance you used last in this session (same switch).
5. **"Shorten beam line? [None/Start/End/Both] <None>:"** Enter is None. Skipped, without a word, when CE has already shortened an end by itself where it meets a beam line at about a right angle.
6. **"Shorten by [45/100] <100>:"** Asked after Start, End or Both.
7. **"Enter text <last>: "** or "Enter text: ". Enter takes the shown text. With none shown, Enter fails (see 7).
8. **"Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:"** The default is CONT when CE found a support under the middle of the beam, otherwise NONE. OTHER asks "Enter other suffix text: " (Enter on empty fails, see 7).
9. **"No inside-points saved. Click inside the building to propose one (or Enter to skip): "** Asked when none is saved and the Settings switch is on, for every mark. Enter skips.
10. **"Beam preview [Accept/Cancel] <Accept>: "** Enter accepts. Esc or Cancel: "Beam cancelled. Nothing was written."

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** A missing fact becomes a refusal line or one of the questions above.
2. **"Beam result is uncertain: CE cannot confirm whether the beam was written. Do not repeat the command — check the drawing and the Undo list first."** (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`): the shorter wording shows only when no reason is attached, and an uncertain result always carries one (`Structural.DesignCore\ConnectedDesign\BeamRefusalWording.cs:311-314`). CE cannot confirm whether the beam was written. Look at the drawing and the Undo list first.
3. **"Beam placed, but its post-write update needs review."** The beam is in. The follow-along was not told.
4. **"Beam not placed: CE could not confirm this beam's preview or write still exactly matches the drawing (one of command 4 or 5's safety checks). Run the command again."** CE's own check between preview and write failed. This line is also given for other, different causes (see 7).

## 6. How to undo it

1. **U once.** It says "Beam placed. One UNDO removes the complete beam." The record says one U was seen for commands 1 and 4 on Structural 1.0.77. Command 5 was not in that test. Not run on this build.
2. **The Structural log line stays.** It is not part of the drawing.

## 7. Known faults

**Still open**
1. **BUG-1139:** a copied beam keeps the original's support and mark links. Way round: not known.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-050:** the mark side no longer depends on which end you picked first.

**Partly fixed**
1. **BUG-577:** units are refused before any question, in plain words. The record names commands 1, 2 and 4 only: command 5 goes through the same check. Still open: the line does not name the drawing's unit.
2. **BUG-211:** erasing a column that carries a beam is no longer silent: CE prints that the beam end has no support and marks it Unresolved. It still asks no question first.

**New in code, no bug covers it**
1. **Locked, frozen, off, or differently coloured layers, or no HIDDEN linetype:** shows the "safety checks ... Run the command again" line. Running it again cannot fix the cause.
2. **Layout tab or REFEDIT:** the same "safety checks" line.
3. **A lintel mark with no inside point is placed as an ordinary mark,** with no refusal. Commands 1 and 2 refuse.
4. **The inside-point question is asked for every mark** when none is saved.
5. **Offset and shorten amounts are fixed at 45 and 100,** with no Settings value.
6. **No best-available question,** and no plain wording when neither side of the beam is clear.
7. **Enter at "Enter text:" or "Enter other suffix text:" with nothing shown** prints "Beam not placed: one of the command-line prompts did not complete properly. Try the command again."
8. **The remembered side and distance are lost when AutoCAD closes.** Text, type, suffix and shortening are not remembered at all.
9. **Help text for 5 is vague:** "Beam offset helper command." and "Follow-up tool for offset beam placement workflow." It does not say that the beam is moved 45 or 100 mm.
10. **Layer names on Settings are ignored.**

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the beam command file, the Host, Commit or Preview folders, or the DesignCore beam files).
2. **One difference outside this command:** CE's own beam and column grips exist only on 2027. On 2022 to 2026 AutoCAD's plain grips are used.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\`. S = `Structural\`, H = `Structural\Services\ConnectedDesign\Host\`, C = `Structural\Services\ConnectedDesign\Commit\`, D = `Structural.DesignCore\ConnectedDesign\`.

1. **1.1, 1.4:** `S\Commands\BeamPlacementCommands.cs:80-91`; `D\BeamSpecialCommandIntentPlanner.cs:171-185, 214-243, 246-287`.
2. **1.2:** `H\BeamSpecialCommandAutoCadPromptSession.cs:102-110`; `D\BeamAtomicCommitAdmission.cs:25-42`; `C\AutoCadBeamSpecialAtomicWriter.cs:106-111`.
3. **1.3, 4.2:** `H\BeamSpecialCommandAutoCadPromptSession.cs:115-132`; `H\BeamCommandAutoCadPromptAdapter.cs:149-161, 185-307, 326-391`.
4. **1.5, 2.2, 7 new 3:** `D\BeamSpecialCommandPreviewPlanner.cs:194-206, 234-255`; `D\BeamLabelClassification.cs`; `S\Models\UserSettings.cs:737`.
5. **2.1, 2.3:** `D\BeamAtomicCommitAdmission.cs:25-42`; `C\BeamAtomicLayerWriter.cs:44-47, 72-83`; `C\AutoCadBeamSpecialAtomicWriter.cs:106-125`.
6. **2.4-2.6:** `C\AutoCadBeamSpecialAtomicWriter.cs:125-159, 340-375, 454-462`; no save call in the Host, Commit or Preview folders (search for Save, QSAVE, SendStringToExecute).
7. **2.7:** `H\BeamCommandAutoCadRoute.cs:384-388` (the result sink both routes use: `H\BeamSpecialCommandAutoCadRoute.cs:22`); `H\BeamSpecialCommandAutoCadPromptHelpers.cs:11-32`; `H\BeamSpecialCommandAutoCadPromptSession.cs:170-212`.
8. **2.8:** `S\Services\BeamLinkService.ConnectedFollowApply.cs:548-553`.
9. **3.1:** `H\BeamSpecialCommandAutoCadRoute.cs:34-45`; `S\Services\DrawingSafetyService.cs:35-41`; `D\BeamRefusalWording.cs:168-169`.
10. **3.2, 7 BUG-577:** `H\BeamSpecialCommandAutoCadPromptSession.cs:90-99` (before the beam-type question, for both 4 and 5); `D\BeamRefusalWording.cs:212-216`.
11. **3.3, 7 new 2:** `H\BeamCommandAutoCadContext.cs:47-75`; `H\BeamSpecialCommandAutoCadCaptureFactory.cs:78-83, 107-110`; `D\BeamRefusalWording.cs:556-559, 602-606`.
12. **3.4:** `H\BeamSpecialCommandAutoCadRoute.cs:62-68`; `D\BeamRefusalWording.cs:186-189`.
13. **3.5:** `H\BeamCommandAutoCadPromptAdapter.cs:598-617, 711-717`; `D\BeamRefusalWording.cs:292-295`.
14. **3.6:** `S\Services\BeamDraftingStandards.cs:78`; `H\BeamCommandAutoCadPromptAdapter.cs:404-408`; `D\BeamRefusalWording.cs:231-233`.
15. **3.7, 4.4, 4.6, 7 new 5:** `H\BeamSpecialCommandAutoCadPromptSession.cs:188-206`; `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:165-197`; `D\BeamRefusalWording.cs:405-407`.
16. **3.8:** `D\BeamSpecialCommandPreviewPlanner.cs:164-170`; `D\BeamRefusalWording.cs:455-458`.
17. **3.9, 7 new 1:** `C\BeamAtomicLayerWriter.cs:44-47, 61-70`; `C\AutoCadBeamSpecialAtomicWriter.cs:111, 172-176`; `D\BeamSpecialAtomicCommit.cs:160-167`; `D\BeamRefusalWording.cs:556-559, 602-606`.
18. **3.10, 7 new 10:** `D\BeamAtomicCommitAdmission.cs:25-42`; `S\Models\UserSettings.cs:439, 442`.
19. **4.1:** `H\BeamSpecialCommandAutoCadPromptHelpers.cs:34-54, 132-178`; `D\BeamRefusalWording.cs:234-235`.
20. **4.3, 4.4, 7 new 8:** `H\BeamSpecialCommandAutoCadPromptHelpers.cs:11-32, 56-130`; `H\BeamSpecialCommandAutoCadPromptSession.cs:150-213`.
21. **4.5:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:152-182`.
22. **4.7, 7 new 7:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750`; `H\BeamCommandSettingsSnapshotReader.cs:137-139`; `S\Commands\BeamPlacementCommands.cs:194, 412, 610`; `D\BeamRefusalWording.cs:546-548, 587-591`.
23. **4.8, 7 new 7:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:201-274`.
24. **4.9, 7 new 4:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:90-124`; `H\BeamCommandAutoCadInsidePointProposalAdapter.cs:182-185`.
25. **4.10, 5.2, 5.3:** `H\BeamSpecialCommandAutoCadRoute.cs:70-100`; `H\BeamCommandAutoCadRoute.cs:292-313, 404-444`.
26. **5.4:** `D\BeamRefusalWording.cs:556-559`.
27. **6.1:** `H\BeamCommandAutoCadRoute.cs:411-412`; record BUG-182 (Codex pass 13, Structural 1.0.77, commands 1 and 4).
28. **7 BUG-1139:** `S\Services\BeamLinkService.cs:73-86`; `S\Services\BeamLinkService.Reactors.cs:395-416`.
29. **7 BUG-050:** `D\BeamSpecialCommandIntentPlanner.cs:324`; `D\BeamPlacementPlanner.cs:301-304`.
30. **7 BUG-211:** `S\Services\BeamLinkService.Reactors.cs:395-400`; `S\Services\SupportErasedPlanner.cs:412-440`.
31. **7 new 6:** `D\BeamSpecialCommandPreviewPlanner.cs:234-249` (the request does not set the best-available switch; default off at `D\BeamPlacementPlanModels.cs:128`); `D\BeamPlacementPlanner.cs:488-491`; `D\BeamRefusalWording.cs:163-512` (no entry for PLACEMENT_CONTEXT_UNRESOLVED).
32. **7 new 9:** `S\Assets\Config\command-registry.json:2050` (the entry for command 5).
33. **8.1:** no `#if` in `BeamPlacementCommands.cs`, `H\*.cs`, `C\*.cs`, `S\Services\ConnectedDesign\Preview\*.cs`, `D\*.cs`, `BeamLinkService*.cs`. **8.2:** `S\Services\StructuralFrameGripOverrule.cs:12-17, 45-47, 61-79`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
