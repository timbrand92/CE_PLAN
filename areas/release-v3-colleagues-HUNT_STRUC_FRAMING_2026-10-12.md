# Structural bug hunt: framing, footings and beams (job dated 12 Oct, run 19 Oct 2026)

**What was read:** the code of the INSTALLED Structural, `origin/claude/rel-20261017s` (9a8e5d4e, Structural 1.0.118). The bundle in AppData reads AppVersion 1.0.118, so this is what Tim and colleagues run. It was read in a private read-only worktree (`C:\ce-hunt\struc-framing`, removed at the end). Nothing was built, run or opened in AutoCAD. Master was not read.

**Scope:** floor and roof framing (R1, FJ1, P1, CSSUBFLOORGRID), supports (C1, C2, DS1, TS1), beams (commands 1, 2, 4, 5, BDL, BEXTEND, BSET), footings (FPFC, FSF, REB, RIB, FEDIT, STUMPFOOTING, SCREWPILE, CSPIER, CSLOADPATH, CSMARKSRENUMBER), and the marks and schedules (FSTEXPORT, XCLMTXT, EXCELMAPFLOOR, STRSCHEDCREATE tie-downs, CSFOOTINGLEGEND), in roof-down order.

**Not repeated:** everything in HUNT_STRUC and HUNT2_STRUC (9 Oct), R00_STRUC, and the bug carpark up to BUG-819. Each item below was grepped in the carpark and area files by command and keyword first.

**How to read each item:** "Confirmed" means I traced the code from the command to the drawing write. "Plausible" means the code reads that way, but one step depends on AutoCAD or on the block's contents and needs a check on a copy. Nothing here has been seen in AutoCAD.

---

## FOR TIM: the 10 worst, in plain English

1. **Rafter and joist tags (R1, FJ1, P1) can land thousands of millimetres off the walls.** If you pick the right-hand wall first, or the wall line was drawn right to left, CE shifts the tag the wrong way. On an 8 m bay that is about 5.6 m out. This may be why BUG-584's tag ended up at 52000,16000.
2. **R1, FJ1 and P1 also slide the whole span line sideways when they dodge nearby text.** The line should stay wall to wall with only the tag moving. Instead it overshoots one wall and stops short of the other, by up to about 1.4 m in a 4 m bay.
3. **Beam commands 1 and 2 ignore the beam layer names in Settings.** They always draw on BEAM and BEAM LOWER. Set your beam layer to S-BEAM and the beams still go on BEAM, where the support tools, BDL and links cannot see them.
4. **Beam commands 1 and 2 refuse to draw when the BEAM layer already exists in another colour.** They also refuse when the layer is turned off, or when the HIDDEN linetype isn't loaded (any drawing started from acadiso.dwt). The refusal comes at the last step, in code words. An architect's drawing with its own BEAM layer stops every beam.
5. **Every footing label creeps sideways.** At each footing redraw CE treats an untouched label as hand-moved and shifts it left by half its width (about 300 mm for PF1). Each FEDIT shifts it again. You can't see it yet only because the labels are tiny (BUG-454). Once that is fixed it will show.
6. **Two strip footings meeting at a corner leave a square bite out of the outer corner.** This happens at every corner when strips are drawn one side at a time with FSF (for 300 wide strips, a 150 x 150 notch). A single bent polyline strip has its corners cut off instead.
7. **CSLOADPATH treats every pier, stump and screw pile as 450 across, whatever size you drew.** A post 200 mm off a 300 pier shows as "supported", which is the unsafe direction. A post 500 mm off a 1200 stump is flagged, and CE offers to add a pad on top of it.
8. **Screw piles and stump footings never appear in the footing schedule (FSTEXPORT), with no warning.** CSPIER piers also miss the footing schedule but do show in the bored pier schedule, so the two schedules disagree.
9. **CSPIER Row puts piers past the end of the row.** A 5000 mm row at 2400 centres offers 4 piers, and the last one lands 2200 mm past the end point you picked. CE keeps the spacing fixed instead of spreading the piers along the row.
10. **Beam command 1 switches into lintel mode for roof beams.** It reads any label starting with "L" as a lintel, so LRB1 or "LVL 240x45" gets lintel prompts and refusals. Level-prefixed lintels such as 1L1 and GL1 are NOT treated as lintels.

**Also worth knowing:** C2 says "size from the schedule" but quietly draws a different post when the schedule size isn't in the block (item 11). CSMARKSRENUMBER strips "(assumed size)" off pads that CSLOADPATH offered, so an undesigned pad then looks designed (item 12).

---

## Findings, most serious first

### FRAME-01. R1 / FJ1 / P1: the stretch correction goes the wrong way when the span runs right-to-left or top-to-bottom (HIGH, Confirmed in code; size of the error Plausible)
1. **Where:** `Commands/RafterJoistCommands.cs` 506-517 (`axis = direction.NearestCardinalDeg == 180.0 ? new Vector3d(-1.0, 0.0, 0.0) : ...`), 410 (`dynamicRotationDeg` is 0 for both 0° and 180°), 627-630 (`br.Rotation = 0.0` for both), 652-668 (the correction `frame.Axis * axisOffset + frame.Normal * normalOffset`). The frame axis comes from the pick order or the picked line's own direction (`TryBuildPlacementFrame`, 313-322).
2. **Steps:** R1, Point option. Left 58000,20000; right 50000,20000 (picked in reverse). Near and far 4000 apart. Or pick wall LINES that were drawn right to left.
3. **Now:** the 0° and 180° cases give an identical block (same Angle1, Rotation 0), but the position correction flips sign because frame.Axis and frame.Normal flip. One of each pair is moved the wrong way: (default INTERNAL − bay width) along the span, and (depth − default ARROW) across it. On an 8000 bay against the block's 2400 default, that is 5600 mm along the span.
4. **Also:** the correction uses the REQUESTED width, not the value read back from the block. When the block refuses the width (BUG-584), the block stays 2400 but is still moved as if it were 8000. BUG-584's own numbers fit this: picks centred at 54000,17000, insertion found at 52000,16000.
5. **Right:** the span line sits wall to wall whichever order you pick in.
6. **Fix idea:** work out the shift in the block's own axes (from Rotation and Angle1), using the values read back after setting them.
7. **Unit test RED:** yes, once the offset maths is pulled into a pure function. `ClassifyDirection` is already internal.

### FRAME-02. R1 / FJ1 / P1: auto-placement slides the whole block, so the span line no longer meets the walls (HIGH, Confirmed in code; depends on the block origin being the span centre, as the code comments say)
1. **Where:** `RafterJoistCommands.cs` 194-197 (on by default, `UserSettings.cs` ~916), 1150-1186 (candidates up to ±35% of the width along the span), 1133-1148 (the scoring assumes the member line still runs `frame.Left` to `frame.Right`). INTERNAL_DISTANCE is still set to the full width (636).
2. **Steps:** a 4000 mm bay with a 25TEXT note or beam label near mid-bay (inside the 500 clash radius). R1, four picks.
3. **Now:** the insertion point moves along the span by up to 1400 mm, and the full-width line moves with it.
4. **Right:** only the tag and arrow move. The line stays between the picked walls.
5. **Fix idea:** slide only across the span (depth direction), or don't move the member line.
6. **Unit test RED:** yes, if candidate selection is extracted.

### BEAM-01. Beam commands 1, 2, 4 and 5 ignore the Settings beam layer names (HIGH, Confirmed)
1. **Where:** `Modules/Structural.DesignCore/ConnectedDesign/BeamAtomicCommitAdmission.cs` 20-44. It writes `"BEAM", 4, "Continuous", "25TEXT"` and `"BEAM LOWER", 2, "HIDDEN"` into the code. Every other beam tool reads `BeamDraftingStandards.LayerBeam` (`Services/BeamDraftingStandards.cs` 22, from `Beams.BeamLayerName`): BDL, AutoSupportService, BeamLinkService, BEAMLINKMIGRATE.
2. **Steps:** Settings, beam layer S-BEAM. Run command 1.
3. **Now:** the beam lands on BEAM. Tools that look on S-BEAM don't see it.
4. **Right:** command 1 draws on S-BEAM. The Batch 13 card, test 8, asks for exactly that.
5. **Fix idea:** pass the Settings names into the layer snapshot.
6. **Unit test RED:** yes, if `CreateLayerSnapshot` takes the names as input. Otherwise a source guard.

### BEAM-02. Beam commands 1, 2, 4 and 5 refuse when BEAM exists in another colour or state, or HIDDEN is not loaded (HIGH, Confirmed)
1. **Where:** `Services/ConnectedDesign/Commit/BeamAtomicLayerWriter.cs` 45-46 (`if (!linetypes.Has(linetype)) throw Failure("REQUIRED_LINETYPE_MISSING")`) and 61-70 (a colour other than 4 or 2, a different linetype, a layer that is off, or one that isn't plotted all throw `REQUIRED_LAYER_MISMATCH`; 25TEXT in any colour but 7 does the same). Nothing in the connected route loads a linetype.
2. **Steps:** (a) a drawing from acadiso.dwt, command 2. (b) An architect's drawing whose BEAM layer is colour 140, command 1. (c) BEAM turned off, command 1.
3. **Now:** nothing is drawn. The refusal comes at commit time, and neither code has a plain sentence in `BeamRefusalWording`.
4. **Right:** use the shared rule (`LayerService.CreateIfMissing`, BUG-367): load HIDDEN from acad.lin and keep an existing layer's colour. Refuse only a locked or frozen layer, in plain words, before the preview.
5. **Fix idea:** as above.
6. **Unit test RED:** no (needs AutoCAD). Source guard only.

### FDN-01. Footing labels shift half their width at the next redraw, and again at every FEDIT (HIGH once BUG-454 is fixed; Confirmed in code)
1. **Where:** `Services/FoundationService.cs` 3082-3097. It compares `dbText.Position` with the default point, but the label is BottomCenter justified and placed by AlignmentPoint plus `AdjustAlignment` (3120-3124). For justified text, Position is the bottom-left that AutoCAD works out, so an untouched label always reads as "moved". The offset is stored as a hand move (3088-3096) and applied at 3104-3109. FEDIT clears the override (~1999), and the next redraw captures it again.
2. **Steps:** FPFC PF1. Then FPFC PF2, or FREGEN (a redraw rebuilds the whole system). Then FEDIT PF1 and Enter through.
3. **Now:** PF1's label moves left by half its width (about 300 mm at 250 high), and moves again after each FEDIT. In a tight pad layout it drifts toward the wrong pad.
4. **Right:** the label stays centred until the drafter moves it.
5. **Fix idea:** for justified text, compare AlignmentPoint, as `BeamLinkService.GripEdit.cs` ~307 already does.
6. **Unit test RED:** yes, if the "was it moved" test is extracted as a pure function of (alignment, position, justify, default).

### FDN-02. Strip footings: a square notch at every corner where two strips meet; a bent polyline strip gets its corners chamfered (HIGH, Confirmed)
1. **Where:** `FoundationService.cs` 3425-3461 (`TryCreateBandPolylineFromCurve`). Each strip is two offset copies of its line, closed square at the line's ends. Nothing extends a strip end to meet the next strip. `SampleCurve2d` (same file) then spaces points evenly every ~120 mm (`steps = ceil(length/120)`), so polyline vertices are not kept.
2. **Steps:** (a) FSF, Enter, line 0,0 to 5000,0, width 300. FSF, Enter, line 0,0 to 0,5000. (b) FSF on one L polyline with 3000 legs.
3. **Now:** (a) the outer corner is missing a 150 x 150 square. (b) The outer corner is cut by up to about 40 mm. Arcs come out as many short straight lines.
4. **Right:** a clean square outer corner. Polyline corners kept.
5. **Fix idea:** where strip ends meet, extend each band half a width past the shared point before joining. Keep every vertex of the offset curve and only subdivide arcs.
6. **Unit test RED:** (b) yes, if sampling becomes a pure function. (a) needs AutoCAD regions.

### FDN-03. CSLOADPATH uses 450 for every pier, stump and screw pile, whatever size was drawn (HIGH, Confirmed)
1. **Where:** `Services/FoundationService.LoadPath.cs` 329-340 read `element.PierDiameter`. A search of the module finds nothing that sets it, except a copy (`Models/FoundationModels.cs` 161) and a schedule read (`FoundationScheduleService.cs` 829). So `PierHalfWidthInDrawingUnits(0, …)` falls back to the 450 default. BP, STUMPFOOTING and SCREWPILE record their size as SizeX/Width, not PierDiameter.
2. **Steps:** (a) BP 300, post (C1) 200 mm off its centre, CSLOADPATH. (b) STUMPFOOTING 1200 square, post 500 off centre, CSLOADPATH.
3. **Now:** (a) "supported", which is unsafe. (b) Flagged as unsupported, and CE offers a pad on top of the stump.
4. **Right:** use the drawn size (and rotation for a square stump).
5. **Fix idea:** take the footprint from SizeX/SizeY/Width, not from PierDiameter.
6. **Unit test RED:** yes, once the footing-to-footprint mapping is pulled out of `CollectFootingFootprints`.

### SCHED-01. Screw piles and stump footings are left out of the footing schedule with no warning; CSPIER piers miss it too (HIGH, Confirmed)
1. **Where:** `Services/FoundationScheduleBuilder.cs` 81-89. The footing kinds are only PadFooting, StripFooting, ExternalBeam, InternalBeam, Thickening and BoredPier, and the filter is at ~153-155. SCREWPILE and STUMPFOOTING record kinds ScrewPile/StumpFooting. CSPIER (`BoredPierPlacementService`) never writes a footing record at all.
2. **Steps:** FPFC PF1, SCREWPILE SP1, STUMPFOOTING ST1, CSPIER row. Then FSTEXPORT, and STRSCHEDCREATE.
3. **Now:** the footing schedule lists only PF1. The CSPIER piers show in the STRSCHEDCREATE bored pier table but not in the footing schedule.
4. **Right:** SP and ST columns, or one plain line: "2 screw piles and 1 stump footing are not in this schedule."
5. **Fix idea:** add the two kinds (with type name and width format), or warn about every kind left out.
6. **Unit test RED:** yes. `FoundationScheduleBuilder.Build` with a ScrewPile item returns no column and no warning.

### FDN-04. CSPIER Row puts piers past the picked end (MEDIUM-HIGH, Confirmed)
1. **Where:** `Services/BoredPierPlacementService.cs` 228 (`defaultCount = RoundUp(length / spacing) + 1`) and 242-243 (piers at fixed spacing from the first point). `LegacyToolCommon.RoundUp` is a plain Ceiling with no tolerance.
2. **Steps:** CSPIER, Row, pick two points 5000 apart, centres 2400, Enter at "Number of piers <4>".
3. **Now:** piers at 0, 2400, 4800 and 7200. The last one is 2200 past the end. A 4800 row that measures 4800.0000001 (any rotated row) offers 4 instead of 3, so one pier lands a full spacing past the end.
4. **Right:** all piers within the row, either spread evenly or with the count floored.
5. **Fix idea:** count = floor(length/spacing + tolerance) + 1, or keep the round-up and spread evenly between the two picks.
6. **Unit test RED:** yes, if the count and position maths is extracted.

### BEAM-03. Lintel prefixes "L,RL" are matched by "starts with", so roof beams and LVL text go into lintel mode, and 1L1 does not (MEDIUM-HIGH, Confirmed)
1. **Where:** `Modules/Structural.DesignCore/ConnectedDesign/BeamLabelClassification.cs` 15-21 (`value.StartsWith(prefix, OrdinalIgnoreCase)`), default `LintelPrefixesCsv = "L,RL"` (`Models/UserSettings.cs` 714). Used at `BeamCommandAutoCadPromptAdapter.cs` ~71 and `BeamSpecialCommandPreviewPlanner.cs` ~201.
2. **Steps:** command 1, text LRB1, or text "LVL 240x45". Separately, command 1 with text 1L1.
3. **Now:** LRB1 and LVL go into lintel mode. They ask for an inside point, or refuse with LINTEL_BOUNDARY_MISSING / FORCED_SIDE_NOT_CLEAR. 1L1 and GL1 are drawn as ordinary beams. `XclmTxtFloorConvention.cs` ~28 itself says "L" must never swallow "LRB".
4. **Right:** classify by the mark's family (`MemberMarkGrammar` gives family L for 1L1 and LRB for LRB1).
5. **Fix idea:** as above.
6. **Unit test RED:** yes. `IsLintel("LRB1","L,RL")` is true today and should be false. `IsLintel("1L1","L,RL")` is false today and should be true.

### SUP-01. C2 says it used the schedule size but draws the default post (MEDIUM-HIGH, Confirmed)
1. **Where:** `Commands/SupportBlockCommands.cs` 250-255 prints `size '...' from the schedule, shown as '...'`. `SetDynamicVisibility` at 1470-1484 falls back to the command default when that state isn't in the block, and returns true. So the C2-only check at 326 (`if (Cmp.Equals(type, "C2") && !visibilityApplied)`) never fires. The only trace is a log line.
2. **Steps:** an imported member schedule with C2 = "125 x 75 x 4 RHS" (not one of the 9 block states). Run C2.
3. **Now:** the command line says the schedule size was used. The block shows the default C2 size.
4. **Right:** say plainly "125 x 75 RHS is not a C2 size in the block, so CE drew 2x89 SHS", or ask for the size.
5. **Fix idea:** make the fallback visible on the command line, and have the C2 check treat a fallback as not applied.
6. **Unit test RED:** partly. `ResolveAllowedVisibility` is pure and returns null for this input; the message choice needs extracting.

### MARK-01. CSMARKSRENUMBER treats "PF3 (assumed size)", "PF1-EXT" and "PF1 TYP" as plain marks and drops the suffix (MEDIUM-HIGH, Confirmed)
1. **Where:** `Services/FoundationService.cs` 74-76. The label pattern `^\s*(prefix)\s*(?<key>[A-Za-z0-9]+)?` has no end anchor, so "PF3 (assumed size)" reads as key 3. `FoundationService.Marks.cs` 213-226 then counts it as a standard mark (its comment says hand-typed labels are never touched), and 287 renames it to prefix + new number. CSLOADPATH writes "(assumed size)" at `FoundationService.LoadPath.cs` 825.
2. **Steps:** CSLOADPATH, accept the offered pad (PF3 (assumed size)). CSMARKSRENUMBER, Yes.
3. **Now:** the pad becomes a plain "PF1" (or whatever number it gets). The only sign that its size was never designed is gone. Hand suffixes are lost the same way.
4. **Right:** a label with anything after the number is left alone.
5. **Fix idea:** anchor the pattern (`\s*$`), or skip any label with text after the key.
6. **Unit test RED:** yes. `BuildRenumberCandidates` with "PF2-EXT" includes it today.

### FDN-05. FEDIT "Change footing type" from a pad to a strip or footing beam draws a ring around the pad (MEDIUM, Confirmed in code; exact outline Plausible)
1. **Where:** `FoundationService.cs` 1881 (the type question is only offered for pads and thickenings) and 1961 (`element.Kind = newKind`). The redraw then treats the closed pad rectangle as a strip centre line with a width (3410: a closed polyline is used as-is only when the width is 0), and builds a band around the pad's edge. The pad's X/Y size is also written into the strip size library.
2. **Steps:** FEDIT a pad, Yes at "Change footing type?", StripFooting.
3. **Now (from code):** a 300-wide ring round the old pad edge, or "band region build failed" and no outline.
4. **Right:** refuse a type change between a pad and a strip, or ask the new type's sizes.
5. **Fix idea:** as above.
6. **Unit test RED:** partly (`ReadFeditKindAnswer` is pure; the geometry is not).

### FDN-06. FSF on a closed polyline: the label goes in the middle of the building and the outline probably fails (MEDIUM, label Confirmed, outline Plausible)
1. **Where:** `FoundationService.cs` ~3828-3832 (FSF takes any polyline), 3448-3460 (the outer ring is joined to the reversed inner ring through a zero-width slit), ~4749-4753 (`TryGetRectangleFromEntity` sends a closed four-sided strip to the PAD label branch). FADOPT already refuses closed strip polylines (~1630); FSF does not.
2. **Steps:** FSF, pick a closed rectangular polyline round the building, width 300.
3. **Now:** the label sits at the building centre. The outline is probably skipped ("band region build failed").
4. **Right:** a closed strip ring with its label on the strip, or a plain refusal.
5. **Fix idea:** build a closed strip as outer region minus inner region, and pick the label rule by footing type, not by shape.
6. **Unit test RED:** no.

### FDN-07. Strip labels overlap the strip when the strip was drawn right to left (MEDIUM, Confirmed in code)
1. **Where:** `FoundationService.cs` ~4757-4787 (the side offset uses the line's own left), ~5565-5571 (rotation flipped 180° between 90° and 270°), ~5240 (offset = half width + 200), BottomCenter justification.
2. **Steps:** FSF, Enter, line 5000,0 to 0,0, width 300, DIMSCALE 100.
3. **Now:** the label sits below the strip, with its text reading back toward it, so it crosses the edge by about 50 mm. At 1:200 it sits on the centre line.
4. **Right:** the label sits clear of the strip on either side.
5. **Fix idea:** when the rotation is flipped, flip the side too, or use TopCenter.
6. **Unit test RED:** yes, if the label pose maths is extracted.

### MARK-02. CSMARKSRENUMBER mixes up band and plain marks in the size library (MEDIUM, Confirmed)
1. **Where:** `FoundationService.Marks.cs` 297-333. The bucket is cleared and rebuilt as `byMark[mark]`, keyed on the number only, so BEB3 and EB3 (or BPF2 and PF2) collide, and BEB's own key "BEB3" is wiped.
2. **Steps:** BEB3 at 400 and EB3 at 300 in one raft. Renumber that family. REB, type EB3.
3. **Now:** EB3 can come out 400 wide.
4. **Right:** each family keeps its own size.
5. **Fix idea:** key the rebuilt entries by the label's own prefix.
6. **Unit test RED:** yes. `ApplyRenumberToRegistry` is pure.

### BEAM-04. Beam commands 1 and 2 take the auto-trim distance from "last shorten distance", not the locked 100 mm (MEDIUM, Confirmed)
1. **Where:** `Services/ConnectedDesign/Host/BeamCommandSettingsSnapshotReader.cs` 130 passes `ParseTrimAmount(source.LastShortenDistance)` as TrimAmountMm. `BeamCommandPreviewPlanner.cs` ~476-480 uses it for the stop short of the support. Locked rule: 100 mm (rulebook, Structural, 10 Jun 2026).
2. **Steps:** any CS_Settings.json with `"LastShortenDistance": "45"` (left by the old 4/5 shorten choice, or copied from a colleague). Command 1 against a wall.
3. **Now:** the beam stops 45 mm short. A blank or non-number value makes every 1/2/4/5 run refuse with SETTINGS_VALUES_INVALID.
4. **Right:** 100 mm, from `BeamDraftingStandards.EndpointAutoTrimAmount`.
5. **Fix idea:** pass that value instead.
6. **Unit test RED:** yes, once `Capture` is made internal.

### BEAM-05. BSET stores the inside point in UCS coordinates (MEDIUM where a UCS is used, Confirmed)
1. **Where:** `Commands/BeamInsidePointCommands.cs` 36-37: `// pr.Value is already WCS — no TransformBy needed`, then `BeamInsidePointStore.Add(db, pr.Value)`. Editor.GetPoint returns UCS. The module's own adapter converts it (`BeamCommandAutoCadInsidePointProposalAdapter.cs` ~198).
2. **Steps:** UCS origin moved to the building corner. BSET, click inside. Command 1 with a lintel.
3. **Now:** the inside point is off by the UCS offset, so the lintel label can land on the inside face.
4. **Fix idea:** `pr.Value.TransformBy(ed.CurrentUserCoordinateSystem)`.
5. **Unit test RED:** no. Source guard.

### BEAM-06. Beam commands 1, 2, 4 and 5 never save the last beam text (MEDIUM, Confirmed)
1. **Where:** read at `BeamCommandSettingsSnapshotReader.cs` 137-139 (`LastBeamText`, RememberLastChoices on by default). Only BDL writes it (`Commands/BeamPlacementCommands.cs` ~194). Nothing in `Services/ConnectedDesign` writes it.
2. **Steps:** BDL with LB3. Then command 1, Enter at "Enter text <LB3>".
3. **Now:** LB3 again, a duplicate mark. Without BDL the default is never your last mark.
4. **Fix idea:** save the accepted label after a successful commit, or drop the default.
5. **Unit test RED:** no. Source guard.

### BEAM-07. Beam labels with a suffix are measured 1000 times too wide in metre drawings (MEDIUM, Confirmed in code, symptom Plausible)
1. **Where:** `Services/ConnectedDesign/Host/BeamCommandAutoCadDetachedTextMeasurer.cs` 50-55. It measures `BeamDraftingStandards.BuildMTextFormat`, which embeds `\H250;` and `\H180;` in drawing units, while the written label is unit-scaled (`BeamPreviewDisplayProjector.BuildMText` 143-155).
2. **Steps:** INSUNITS metres. Command 1 with CONT, or 4/5 with any suffix.
3. **Now (from code):** a clash box about 1.5 km wide, so every side is blocked: a refusal or the wrong side.
4. **Fix idea:** measure the same unit-scaled string the writer uses.
5. **Unit test RED:** yes (compare the two builders at factor 0.001).

### BEAM-08. BEXTEND: Esc at "Shorten after extend?" keeps the extension and leaves the label behind; a locked layer gives the AutoCAD error box (MEDIUM, Confirmed)
1. **Where:** `Commands/BeamExtendCommands.cs` 87 (end moved), 94-97 (`if (!TryPromptKeywords(...)) { tr.Commit(); return; }`), 51 and 112 (ForWrite, no locked-layer check, no try/catch in the command). The label it moves is the nearest 25TEXT within 3000 (260-282), not the beam's linked label.
2. **Steps:** (a) BEXTEND, beam, boundary, Enter, Esc. (b) Lock BEAM, BEXTEND.
3. **Now:** (a) the beam is extended, its label stays at the old midpoint, and nothing is said. (b) eOnLockedLayer error box.
4. **Right:** Esc changes nothing. A locked layer gives one plain line.
5. **Fix idea:** ask before writing, or abort on Esc. Check the layer lock first.
6. **Unit test RED:** no.

### BEAM-09. BDL: Esc at a text question leaves bare beam lines; BDL ignores drawing units (LOW-MEDIUM, Confirmed)
1. **Where:** `Commands/BeamPlacementCommands.cs` 159-170 (both lines committed first), 191 and 205 (Esc returns), 215-216 (link skipped). `Services/BeamService.cs` 67 (50 minimum in raw units), 144 (100 offset).
2. **Now:** Esc leaves two lines with no label and no link. In a metre drawing a beam needs to be 50 m long.
3. **Fix idea:** collect every answer before writing, and scale by the unit factor.
4. **Unit test RED:** partly (`IsValidBeamLength` with metre points).

### FDN-08. STUMPFOOTING and SCREWPILE ignore a rotated UCS and are not stopped on a layout tab (MEDIUM, Confirmed)
1. **Where:** `Services/FoundationStumpFootingService.cs` 51, 71, 92 and `Services/FoundationScrewPileService.cs` 64, 73, 105 use the raw clicked point. The layout-tab list at `FoundationService.cs` ~5337-5340 covers THC, PFC, SF, REB, RIB and BP only. These two commands were not in HUNT-S-02 or HUNT-S-07.
2. **Now:** with a rotated UCS they land away from the click. On a layout tab they go into model space at paper coordinates.
3. **Fix idea:** convert from UCS to World, and add both commands to the layout check.
4. **Unit test RED:** no.

### FDN-09. REB / RIB clicked outside every slab leave a stray line on the raft layer (LOW-MEDIUM, Confirmed)
1. **Where:** `FoundationService.cs` ~3884-3893 and ~3861-3865 commit the line (or move the picked line to the raft layer) before ~1343-1351 finds there is no host slab.
2. **Now:** "No slab perimeter contains the selected point", but the line stays with no record, and the drafter's picked line has been moved to the raft layer. FADOPT later adopts it as a beam.
3. **Fix idea:** find the host before drawing or moving anything.
4. **Unit test RED:** no.

### SCHED-02. XCLMTXT carries a floor from an earlier heading into a later section that names no floor (MEDIUM, Confirmed)
1. **Where:** `Services/ExcelMTextService.cs` 2070-2082. `contextualFloor` is set by a floor heading ("ROOF BEAMS") and never reset by a heading with no floor, so "COMMON MEMBERS" and its rows inherit Roof.
2. **Input:** a CSV with no floor column: `ROOF BEAMS` / `RB1` / `COMMON MEMBERS` / `DS1` / `C1`.
3. **Now:** DS1 and C1 go in the ROOF MEMBER SCHEDULE.
4. **Right:** they go to "Floor not given" (the BUG-195 rule: never quietly filed under a named floor).
5. **Fix idea:** at every heading, set contextualFloor to the heading's floor, Unknown included.
6. **Unit test RED:** yes (`LoadSourcePreviewRows` on a temporary CSV).

### SCHED-03. EXCELMAPFLOOR and EXCELMAPFLOORAREA save a floor map that nothing reads (MEDIUM, Confirmed)
1. **Where:** `ExcelMTextService.cs` 690-788 write `session.MemberFloorMap` (770). Its only reader is `LoadSourcePreviewRows(…, memberFloorMap)` (373, 404), and XCLMTXT calls it without the map (`Services/XclmTxtService.cs` ~403). Both commands are on the ribbon (Schedules > Import).
2. **Now:** "Unique marks mapped: N", "Session saved", then XCLMTXT ignores it.
3. **Fix idea:** load the session and pass the map, or point the commands at the dialog's Capture button.
4. **Unit test RED:** source guard.

### SCHED-04. Floor capture misses marks that start with a level number (1FB1, 3FB2, 2L1) (MEDIUM, Confirmed)
1. **Where:** `ExcelMTextService.cs` 1068, `\b[A-Za-z]{1,4}\d{1,4}...\b`. There is no word boundary between "3" and "F", so nothing matches. The same gap is at 1055. Reached by EXCELMAPFLOOR(AREA) and the XCLMTXT dialog's "Capture from area" (`XclmTxtAdvancedEditDialog.xaml.cs` ~298).
2. **Now:** "No matching marks were found in the draft for that captured area."
3. **Fix idea:** allow up to two leading digits, as `MemberMarkGrammar` does.
4. **Unit test RED:** yes (`ExtractMemberMarks("3FB1 190x45 LVL")` returns nothing).

### SCHED-05. The member size list saved after an XCLMTXT insert includes rows the engineer unticked (MEDIUM-LOW, Confirmed)
1. **Where:** `XclmTxtService.cs` ~303-312. The filter `!r.IsTitleRow && !string.IsNullOrWhiteSpace(r.Mark)` has no Include test. `MemberScheduleService.FindByCode` returns the first match.
2. **Steps:** the source has "C1 89 SHS" (old) then "C1 100 SHS". Untick the first, insert, then C1.
3. **Now:** the post is drawn 89 SHS. **Right:** 100 SHS.
4. **Fix idea:** add `&& r.Include`.
5. **Unit test RED:** yes, once the filter is extracted. Otherwise a source guard.

### SCHED-06. The built-in floor guesses beat the engineer's own section heading (MEDIUM, Plausible; office call)
1. **Where:** `ExcelMTextService.cs` 148-207 (TB goes to Third Floor; WP, SS and OR go to Mezzanine; ROOF, JOIST, BALCONY and GROUND match anywhere in the description via `IndexOf`, 2508-2529). `ApplyFloorMappings` runs before the heading pass.
2. **Input:** under "FIRST FLOOR BEAMS": `TB1 190x45 LVL`, or `L3 190x45 LVL LINTEL SUPPORTS ROOF`.
3. **Now:** TB1 goes to THIRD FLOOR and L3 to ROOF.
4. **Fix idea:** the heading wins. Whole-word matching. Tim's call on the TB/WP/SS/OR guesses.
5. **Unit test RED:** yes (`InferFloorFromMember("TB1", …)` returns ThirdFloor).

### SCHED-07. The member schedule block gets an empty third column when one group is taller than a column (LOW-MEDIUM, Confirmed by trace)
1. **Where:** `ExcelMTextService.cs` `DetermineScheduleLayout` 3807-3872 packs whole groups (41 rows exceeds 31, so 3 columns), but the rows are then laid out in order (`ReorderRowsByPackedGroups` returns early at ~4649).
2. **Now:** one 40-row "COMMON MEMBERS" group gives a "3 COLUMNS" block with column 3 empty.
3. **Fix idea:** count columns with the same in-order fill the placement uses.
4. **Unit test RED:** yes.

### SCHED-08. Natural sort missing: TD10 before TD2 in the tie-down schedule, SL10 before SL2 in the legend, PF1A after PF10 in the footing schedule (LOW, Confirmed)
1. **Where:** `Modules/Structural.DesignCore/TieDownScheduleCalculator.cs` 31-36 and `SlabLegendTextBuilder.cs` ~56 (plain alphabetical sort). `FoundationScheduleBuilder.cs` ~279-291 (`TrailingNumber` needs digits at the end, so PF1A sorts as stem "PF1A").
2. **Fix idea:** sort by prefix, then number, then letter.
3. **Unit test RED:** yes.

### FRAME-03. R1: walls up to 12° off square (in World) are drawn square to the page (MEDIUM, Plausible)
1. **Where:** `RafterJoistCommands.cs` 390-420 and 496-560. The tolerance is 12° (`UserSettings.cs` ~918). A Horizontal or Vertical class snaps the frame to exactly 0° or 90° and re-projects the width.
2. **Steps:** a building skewed 8° in World (no UCS). R1, perpendicular picks.
3. **Now:** the span line runs 8° out of square, and its ends miss the walls.
4. **Fix idea:** snap within about 1-2° only, or never when both picks are objects.
5. **Unit test RED:** partly (`ClassifyDirection` is pure).

### SUP-02. DS, DS1, TS1, C1 and the S-switch commands ignore a failed size change (MEDIUM, Plausible: needs an older SUPPORT BLOCK definition in the drawing)
1. **Where:** `SupportBlockCommands.cs` 322-329 (only C2 checks the result) and ~567 (`SetDynamicVisibility(br, targetVisibility);`, result thrown away).
2. **Now:** the post keeps its old look. A switch still moves it by the new size's offsets and changes its layer, with no message.
3. **Fix idea:** check the result everywhere, and run the C2 block upgrade for the S-commands too.
4. **Unit test RED:** source guard.

### Hidden or switched-off commands (LOW for colleagues today; HIGH when switched on)
1. **CSSUBFLOORGRID: the edge bearers vanish when the joist direction is even slightly off square.** `Core/Subfloor/TimberSubfloorGridPlanner.cs` 136-157 and 233. An end row through a single corner gives one crossing and throws, so the row is dropped. A 10000 x 6000 floor at 0.5° gets 3 bearers instead of 5, leaving 2.5 m of unsupported joist at each end. Pure function, RED test easy.
2. **CSSUBFLOORGRID: a U- or T-shaped floor gets bearers in one leg only.** `ClipLineThroughPoint` (223-266) returns one interval. With an odd crossing count it spans the first to the last crossing, across ground outside the floor (240-242). Pure, RED test easy.
3. **CSSUBFLOORGRID / CSTAGBEARERS reuse BR1 for a different size.** Labels go on 25TEXT (`Services/TimberSubfloorService.cs` 334, 360), but the scan for existing marks reads only the bearer and stump layers (289).
4. **CSSUBFLOORGRID never looks up the span table, and a bearer under 2 bays gets no stumps.** `TimberSubfloorService.cs` 79-82 and planner 186 (`if (segments <= 1) yield break;`). Whether bearer ends need stumps is an engineering call for Tim.
5. **CSSUBFLOORGRID / CSTAGBEARERS ignore a rotated UCS.** `TimberSubfloorService.cs` 188 and 435.
6. **CEAUTOSUPPORT (preview only):** proposes posts on top of existing C1s (`Services/AutoSupportService.cs` 97-123). A column can lose to a pad at a shared beam end, depending on sort order (`SupportPlacementEngine.cs` 684-703). Walls are paired by largest overlap, not smallest gap (`WallPairingService.cs` ~84).
7. **CSLINTELPROPOSE:** with no largest-opening limit (`UserSettings.cs` ~1419), two separate collinear walls 4 m apart across a hall come out as one 4 m "opening" (`LintelProposalPlanner.cs` 165-201).
8. **CSWALLSCHEDULE / CSLINTELTABLE** place the table at the UCS point without converting to World (`WallScheduleService.cs` ~403, `LintelTableService.cs`).
9. **CSROOFSETOUT** defaults to the long side for rafters, the opposite of the floor setout's short side (`RoofSetoutPlanner.cs` ~175). The prompt says so openly; this is Tim's call, not a fault.

---

## Roof-down order, what this hunt adds
1. **Roof (R1, FJ1, P1):** FRAME-01 and FRAME-02 can put the span line itself in the wrong place, not just the tag. This is the first thing drawn in roof-down order, and it is what a colleague checks first.
2. **Upper floors (beams 1 and 2):** BEAM-01 and BEAM-02 decide whether a beam is drawn at all, and on which layer. BEAM-03 sends roof beams into lintel mode.
3. **Posts (C2):** SUP-01 can draw a post size that disagrees with the member schedule.
4. **Footings:** FDN-03 makes the load-path check wrong for every pier, stump and pile. FDN-02 and FDN-01 spoil the plan's look. SCHED-01 leaves piles and stumps off the schedule.

## What I did not check
1. **Nothing was run.** Every symptom comes from reading the code. FRAME-01, FRAME-02 and SUP-02 depend on what is inside RAFTER-JOISTV2 and SUPPORT BLOCK NEW, and those blocks were not opened.
2. **Not read, or skimmed only:** the old beam linking engine (off by default), BTX beyond earlier hunts, the footing grip edit (off by default), CSFDNPROPOSE, and NativeBoredPierService.
3. **FEDIT strip-to-pad** was reported by one sub-check, but the code only offers a type change on pads and thickenings (1881), so it was dropped. Only pad-to-strip is reported (FDN-05).

## Summary
I read the installed Structural 1.0.118 code for framing, beams, footings, marks and schedules. I found 41 new defects (33 numbered, plus 8 in hidden or switched-off commands), none already in the carpark or the earlier hunts. The worst are geometric. Rafter and joist tags can be pushed metres off the walls when picked or drawn right to left, or when they dodge text. Strip footings get a notch at every corner. Footing labels creep half their width at every redraw. Beam commands 1 and 2 ignore the Settings layer names and refuse outright on an existing BEAM layer of another colour, or with HIDDEN unloaded. CSLOADPATH treats every pier, stump and pile as 450, which is unsafe for a 300 pier. Screw piles and stumps are missing from the footing schedule. CSPIER puts piers past the end of the row. Beam command 1 mistakes LRB roof beams for lintels. Most items can be shown RED by a unit test once one small piece of maths is pulled out as a pure function. The R1 offset fix, the label anchor fix, the beam layer snapshot and the pier footprint fix are each a few lines. No BUG numbers have been filed; the controller does that.
