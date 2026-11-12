# TOOL NOTE: Special beam (4)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Draws one beam with extra choices:** regular or lower, an optional shortening at either end, and a suffix on the mark (CANT, CONT, BOTH, LOWER, PORTAL, PF or your own).
2. **Regular goes on layer BEAM, Lower on BEAM LOWER.** The mark goes on 25TEXT. You see a temporary preview and say Accept before anything is drawn.
3. **Each end can be a support block, a line or a picked point,** in any mix.
4. **The mark is placed by the same side-and-room rule as commands 1 and 2.** With no suffix it is single-line text. With any suffix it is multi-line text.
5. **Marks starting with L or RL are lintels** and go outside, using an inside-the-building point (see BSET).
6. **No offset.** Offsetting a beam is command 5.

## 2. What it changes in the drawing

1. **A beam line** on BEAM (colour 4, Continuous) or BEAM LOWER (colour 2, HIDDEN).
2. **A beam mark** on 25TEXT (colour 7).
3. **Layers are created if missing.** The HIDDEN linetype is not loaded for you.
4. **CE's record on the beam:** which support each end sits on, and its mark. Only supports you picked as objects are recorded.
5. **A small record of this placement,** so a repeat cannot make a second beam. Plus the inside point, if you picked one at the question.
6. **All of that is one write.** The code never saves the drawing.
7. **Not the drawing:** a line in the Structural log for every result.
8. **Later, outside this command:** when a picked support moves, the beam end and mark follow and CE prints "CE moved ... One U undoes both."

## 3. What it will not do

1. **Drawing read-only:** stops. It prints "[CE_STRUC] BEAM-4: the drawing is read-only. Save a copy you can edit first." and then "Beam cancelled before CE checked the drawing. Nothing was written."
2. **Units must be millimetres, metres or inches.** The check now comes before the first question: "Beam not placed: this drawing's units are not millimetres, metres or inches, and CE does not guess or rescale a drawing. Type UNITS, set the insertion units to millimetres, metres or inches, then run the command again." The line does not say which unit the drawing has (the log does).
3. **Model space only.** On a layout tab or during REFEDIT it stops with the wrong line (see 7).
4. **Old beam-link engine switched on in Settings:** "Beam not placed: the old command-8 beam-linking engine is switched on in CE Settings ... Switch the old engine off, then run the command again."
5. **A support or line inside an Xref** is refused. Only a CE support block, a straight line or one polyline segment can be an end.
6. **Beam shorter than 50 mm:** "Beam not placed: the two points you picked are too close together. Pick a longer beam line."
7. **Shortening that would leave the beam too short:** "Beam not placed: shortening by that amount would leave the beam too short. Pick a smaller amount, or answer None to shortening."
8. **Shorten amounts are 45 or 100 only.** There is no other choice (see 7).
9. **Layers locked, off, frozen, recoloured or with another linetype,** or no HIDDEN linetype for a lower beam: refused before writing, never unlocked. The line it shows is wrong (see 7).
10. **Does not use the layer names on Settings.** It always writes BEAM, BEAM LOWER and 25TEXT.

## 4. What it asks you, and what Enter means

1. **"Choose beam type [Regular/Lower] <Regular>:"** (CE gives "Choose beam type"; AutoCAD adds the list and default). Enter is Regular, always, whatever you used last. Esc: "Beam cancelled at the beam-type question. Nothing was written."
2. **Ends:** with the Settings "merge" switch on (shipped), it asks "Select the first support (a support block or a line), or press Enter to pick points: " and the follow-up questions exactly as for command 1. Off: points only ("Specify the START point: ", "Specify the END point: ").
3. **"Shorten beam line? [None/Start/End/Both] <None>:"** Enter is None. Skipped, without a word, when CE has already shortened an end by itself where it meets a beam line at about a right angle.
4. **"Shorten by [45/100] <100>:"** Asked after Start, End or Both. The default is 45 only when the Settings shorten value is 45, otherwise 100.
5. **"Enter text <last>: "** or "Enter text: ". Enter takes the shown text. With none shown, Enter fails (see 7).
6. **"Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:"** The default is CONT when CE found a support under the middle of the beam, otherwise NONE. OTHER asks "Enter other suffix text: " (Enter on empty fails, see 7).
7. **"No inside-points saved. Click inside the building to propose one (or Enter to skip): "** Asked when none is saved and the Settings switch is on, for every mark, not only lintels. Enter skips.
8. **"Beam preview [Accept/Cancel] <Accept>: "** Enter accepts. Esc or Cancel: "Beam cancelled. Nothing was written."

## 5. When it says Unknown or "needs checking"

1. **It never shows Unknown.** A missing fact becomes a refusal line or one of the questions above.
2. **"Beam result is uncertain. Do not repeat the command; inspect the drawing."** CE cannot confirm whether the beam was written. Look at the drawing and the Undo list first.
3. **"Beam placed, but its post-write update needs review."** The beam is in. The follow-along was not told.
4. **"Beam not placed: CE could not confirm this beam's preview or write still exactly matches the drawing (one of command 4 or 5's safety checks). Run the command again."** CE's own check between preview and write failed. This line is also given for several other, different causes (see 7).

## 6. How to undo it

1. **U once.** It says "Beam placed. One UNDO removes the complete beam." The record says one U was seen to remove a command 4 beam on Structural 1.0.77. Not run on this build.
2. **The Structural log line stays.** It is not part of the drawing.

## 7. Known faults

**Still open**
1. **BUG-1139:** a copied beam keeps the original's support and mark links. Way round: not known.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-577:** command 4 no longer asks the Regular question and then stops on the units. The units are checked before any question.
2. **BUG-050:** the mark side no longer depends on which end you picked first (the beam is turned to run left to right, or bottom to top).

**Partly fixed**
1. **BUG-577:** the units line does not name the drawing's unit. The log does.
2. **BUG-211:** erasing a column that carries a beam is no longer silent: CE prints that the beam end has no support and marks it Unresolved, and the beam stays. It still asks no question first.

**New in code, no bug covers it**
1. **Locked, frozen, off, or differently coloured BEAM, BEAM LOWER or 25TEXT, or no HIDDEN linetype:** shows the "safety checks ... Run the command again" line. Running it again cannot fix the cause.
2. **Layout tab or REFEDIT:** the same "safety checks" line, not a plain "go to model space".
3. **A lintel mark with no inside point is placed as an ordinary mark,** with no refusal and no line. Commands 1 and 2 refuse in that case. The mark can land on the inside.
4. **The inside-point question is asked for every mark** when none is saved, not only lintels.
5. **Shorten amounts are fixed at 45 and 100.** The older code, still in the file but no longer used, offered a list taken from Settings.
6. **No best-available question,** and no plain wording when neither side of the beam is clear.
7. **Enter at "Enter text:" or "Enter other suffix text:" with nothing shown** prints "Beam not placed: one of the command-line prompts did not complete properly. Try the command again."
8. **"Remember last choices" remembers nothing here:** not the type, text, suffix or shortening.
9. **Any mark starting with L or RL** (so also LVL1, say) is a lintel.
10. **Layer names on Settings are ignored.**

Closed earlier by Codex on other builds, not repeated here: BUG-182.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no #if in the beam command file, the Host, Commit or Preview folders, or the DesignCore beam files).
2. **One difference outside this command:** CE's own beam and column grips exist only on 2027. On 2022 to 2026 AutoCAD's plain grips are used.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\`. S = `Structural\`, H = `Structural\Services\ConnectedDesign\Host\`, C = `Structural\Services\ConnectedDesign\Commit\`, D = `Structural.DesignCore\ConnectedDesign\`.

1. **1.1, 1.2:** `S\Commands\BeamPlacementCommands.cs:72-78`; `H\BeamSpecialCommandAutoCadPromptSession.cs:102-110`; `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:45-78`; `C\AutoCadBeamSpecialAtomicWriter.cs:106-111`; `D\BeamAtomicCommitAdmission.cs:25-42`.
2. **1.3, 4.2:** `H\BeamSpecialCommandAutoCadPromptSession.cs:115-132`; `H\BeamCommandAutoCadPromptAdapter.cs:149-161, 185-307, 326-391`; `S\Models\UserSettings.cs:517`.
3. **1.4, 7 new 3:** `D\BeamSpecialCommandPreviewPlanner.cs:194-206, 234-255`.
4. **1.5, 7 new 3:** `D\BeamLabelClassification.cs`; `S\Models\UserSettings.cs:737`; `D\BeamSpecialCommandPreviewPlanner.cs:201-233`.
5. **1.6:** `D\BeamSpecialCommandIntentPlanner.cs:171-185`; `D\BeamRefusalWording.cs:398-400`.
6. **2.1-2.3:** `D\BeamAtomicCommitAdmission.cs:25-42`; `C\BeamAtomicLayerWriter.cs:44-47, 72-83`; `C\AutoCadBeamSpecialAtomicWriter.cs:106-125`.
7. **2.4-2.6:** `C\AutoCadBeamSpecialAtomicWriter.cs:125-159, 340-375, 454-462`; no save call in the Host, Commit or Preview folders (search for Save, QSAVE, SendStringToExecute).
8. **2.7:** `H\BeamCommandAutoCadRoute.cs:384-388` (the result sink both routes use: `H\BeamSpecialCommandAutoCadRoute.cs:22`).
9. **2.8:** `S\Services\BeamLinkService.ConnectedFollowApply.cs:548-553`.
10. **3.1:** `H\BeamSpecialCommandAutoCadRoute.cs:34-45`; `S\Services\DrawingSafetyService.cs:35-41`; `D\BeamRefusalWording.cs:168-169`.
11. **3.2, 7 BUG-577:** `H\BeamSpecialCommandAutoCadPromptSession.cs:90-99, 256-262`; `D\BeamRefusalWording.cs:212-216`.
12. **3.3, 7 new 2:** `H\BeamCommandAutoCadContext.cs:47-75`; `H\BeamSpecialCommandAutoCadCaptureFactory.cs:78-83, 107-110`; `D\BeamRefusalWording.cs:556-559, 602-606`.
13. **3.4:** `H\BeamSpecialCommandAutoCadRoute.cs:62-68`; `D\BeamRefusalWording.cs:186-189`.
14. **3.5:** `H\BeamCommandAutoCadPromptAdapter.cs:598-617, 711-717`; `D\BeamRefusalWording.cs:292-295`.
15. **3.6:** `S\Services\BeamDraftingStandards.cs:78`; `H\BeamCommandAutoCadPromptAdapter.cs:404-408`; `D\BeamRefusalWording.cs:231-233`.
16. **3.7:** `D\BeamSpecialCommandPreviewPlanner.cs:164-170`; `D\BeamRefusalWording.cs:455-458`.
17. **3.8, 4.4, 7 new 5:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:165-197`; `S\Commands\BeamPlacementCommands.cs:1427`; `D\BeamRefusalWording.cs:405-407`.
18. **3.9, 7 new 1:** `C\BeamAtomicLayerWriter.cs:44-47, 61-70`; `C\AutoCadBeamSpecialAtomicWriter.cs:111, 172-176`; `D\BeamSpecialAtomicCommit.cs:160-167`; `D\BeamRefusalWording.cs:556-559, 602-606`.
19. **3.10, 7 new 10:** `D\BeamAtomicCommitAdmission.cs:25-42`; `S\Models\UserSettings.cs:439, 442`.
20. **4.1, 7 new 8:** `H\BeamSpecialCommandAutoCadPromptHelpers.cs:34-54, 132-178`; `D\BeamRefusalWording.cs:234-235`.
21. **4.3:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:152-182`.
22. **4.5, 7 new 7:** `H\BeamCommandAutoCadPromptAdapter.cs:719-750`; `H\BeamCommandSettingsSnapshotReader.cs:137-139`; `S\Commands\BeamPlacementCommands.cs:194, 412, 610`; `D\BeamRefusalWording.cs:546-548, 587-591`.
23. **4.6, 7 new 7:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:201-274`.
24. **4.7, 7 new 4:** `H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:90-124`; `H\BeamCommandAutoCadInsidePointProposalAdapter.cs:182-185`.
25. **4.8, 5.2, 5.3:** `H\BeamSpecialCommandAutoCadRoute.cs:70-100`; `H\BeamCommandAutoCadRoute.cs:292-313, 404-444`.
26. **5.4:** `D\BeamRefusalWording.cs:556-559`.
27. **6.1:** `H\BeamCommandAutoCadRoute.cs:411-412`; record BUG-182 (Codex pass 13, Structural 1.0.77, command 4 point mode).
28. **7 BUG-1139:** `S\Services\BeamLinkService.cs:73-86`; `S\Services\BeamLinkService.Reactors.cs:395-416`.
29. **7 BUG-050:** `D\BeamSpecialCommandIntentPlanner.cs:324`; `D\BeamPlacementPlanner.cs:301-304`.
30. **7 BUG-211:** `S\Services\BeamLinkService.Reactors.cs:395-400`; `S\Services\SupportErasedPlanner.cs:412-440`.
31. **7 new 6:** `D\BeamSpecialCommandPreviewPlanner.cs:234-249` (the request does not set the best-available switch; default off at `D\BeamPlacementPlanModels.cs:128`); `D\BeamPlacementPlanner.cs:488-491`; `D\BeamRefusalWording.cs:163-512` (no entry for PLACEMENT_CONTEXT_UNRESOLVED).
32. **7 new 9:** `D\BeamLabelClassification.cs`; `S\Models\UserSettings.cs:737`.
33. **8.1:** no `#if` in `BeamPlacementCommands.cs`, `H\*.cs`, `C\*.cs`, `S\Services\ConnectedDesign\Preview\*.cs`, `D\*.cs`, `BeamLinkService*.cs`. **8.2:** `S\Services\StructuralFrameGripOverrule.cs:12-17, 45-47, 61-79`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
