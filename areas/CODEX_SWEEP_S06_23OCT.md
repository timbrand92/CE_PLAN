1. **ANSWER FIRST — HIGH: 1; MEDIUM: 3; LOW: 0.** Four faults are verified by reading the installed Civil code. The most important is **S06-01: CDSPOON rejects its own newly drawn objects and rolls the whole placement back**, even in an ordinary unlocked drawing.

2. **What Tim will meet.** Spoon drains cannot finish normally. X-Civil imports can leave levels and fall arrows behind when the network moves, turn rotated fall arrows the wrong way, and replace an available pit label with an invented number.

3. **Limits.** All 111 requested files were read, largest first. These are code-proven findings, not AutoCAD observations. No build, test, AutoCAD session, installation, code edit or sub-agent was used. The tests below are proposed deterministic checks for the installed release.

---

1. **Audit basis.** CODE SWEEP S06, Civil Services slice 6 of 6; 23 October 2026, Melbourne. Repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. Ref: `origin/claude/rel-20261022m`; pinned commit: `40ee0a36f7960145743954b39859eb6c3af92869` (Civil 3.0.70 / Manager 1.1.70). All code paths below are relative to that repository and all line numbers refer to that commit. The Structural ref is outside this slice.

   Read first: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md` and `CODEX_AUDIT_STRUCTURAL_22OCT.md` in `C:\CE_PLAN\areas`. Their findings are not repeated. This report does not propose extra engineering settings outside Settings, additional hard blocks, or parked Manager administrator work.

2. **S06-01 — HIGH — Spoon placement rejects the colours it just wrote. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Services/SlabService.cs:2264`, `:2279`, `:2418`, `:2421`.

   **In AutoCAD:** A drafter traces a valid spoon drain and chooses Close. Nothing remains in the drawing. The command reports a failed check and rolls the placement back. The same mismatch affects standalone and slab-owned spoons.

   **Exact failure:** The boundary and hatch are both created with `ColorIndex = ByLayerColourIndex` (256, declared at line 24). Before commit, `RequireSpoonGeometry` demands that their entity colour indices equal `COLOR_SLAB_PERIMETER` (2) and `COLOR_SPOON_HATCH` (35). Those constants are in `LayerService.cs:215` and `:223`. A ByLayer entity retains index 256 even when its layer displays colour 2 or 35. The first colour comparison therefore fails in a normal successful geometry-write path.

   **Call-chain proof:** `Commands/SpoonCommand.cs:150` calls this placement method. `SlabService.cs:2308` performs the check before the commit at `:2318`. `SourceChangeCoordinator.cs:60` verifies before committing, and `:71` aborts on the exception. `SlabService.cs:2427` supplies the error text; `:2460` adds the rollback text.

   **DETERMINISTIC TEST — not run:** Use a fresh writable Civil drawing in model space, World UCS, millimetres, with no REFEDIT and with the slab perimeter and spoon hatch output layers absent or unlocked. Set `DYNMODE` to 0 and `OSMODE` to 0. Type `CDSPOON`; press Enter for standalone; enter `10000,10000`, `12000,10000`, `12000,11000`, `10000,11000`, then `Close`. Assert command history contains `[CE] The spoon boundary or hatch failed exact readback. No spoon output was committed.` and there is no new boundary or hatch. The corrected result must instead contain `CDSPOON complete.`, one closed four-vertex boundary and one associated SOLID hatch, both ByLayer. Repeat inside a registered slab after selecting its boundary to cover the owned path.

3. **S06-02 — MEDIUM — Moving the imported network leaves spot levels and fall arrows at the old coordinates. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Services/XcivilImportService.cs:708`; `Modules/Drainage/Services/XcivilPitInsertionService.cs:899`, `:1058`, `:1087`.

   **In AutoCAD:** When an imported drainage layout is automatically moved to the host drawing, its levels and fall arrows can remain far away. The import can finish with the correct number of objects while annotations no longer describe the nearby network.

   **Exact failure:** `ResolveXcivilImportTranslation` at `XcivilPitInsertionService.cs:878` returns the difference between host and imported network centres when the separation exceeds the trigger distance. The call at `XcivilImportService.cs:708` translates pits, pipes, text entries, AGI lines, supplemental lines and source blocks. Neither its arguments nor the helper signature include `spotLevelCandidates` or `fallArrowCandidates`. Those are separate records, not aliases of the moved text positions. Later loops at `:1134` and `:1172` insert them using their unchanged positions. The earlier unit-scaling pass does include these collections; it does not repair this later translation omission.

   **DETERMINISTIC TEST — not run:** Prepare a synthetic millimetre DWG in World UCS. On a layer named `PIT`, draw two closed 600 mm squares centred at (10000,10000) and (20000,10000). Connect their centres with a line on `SWD PIPE`. Insert a simple block named `S06_SPOT` at (15000,12000), scale 1, rotation 0, with one non-constant attribute `LEVEL=10.000` and no leader. Insert a simple block named `S06_FALL` at (15000,14000), scale 1, rotation 0, with `FALL=FALL` and `FALL_GRADE=1 IN 100`. Supply no PDF, schedule, entity-dump sidecar or model-space leaders. Keep the source closed during import.

   In a fresh target Civil drawing, World UCS and millimetres, draw only a rectangle from (990000,990000) to (1010000,1010000). Ensure output layers are unlocked and the installed `SPOT LEVEL` and `FALL SYMBOL` library blocks are available. Type `CDIMPORTXCIVIL`, choose the source DWG, click **Read source**, then **Import to drawing**. Open the debug log whose path the command prints. Assert `Applied import translation: (985000, 990000)`. In Properties, the imported spot should be at (1000000,1002000), but this code inserts it at (15000,12000); the imported fall symbol should be at (1000000,1004000), but remains at (15000,14000). The `[SPOT-INSERT]` log also records `pos=(15000,12000)`. Assert the pits have moved while these two annotations have not. If block assets are unavailable, use the spot insertion log to prove the coordinate defect; missing assets are a separate setup failure.

4. **S06-03 — MEDIUM — A used pit label prevents the next pit from taking another available label. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Services/XcivilScheduleService.cs:819`, `:845`, `:881`.

   **In AutoCAD:** A source drawing with two pit numbers can import as one correct number and one newly generated number. The available second number is ignored. The debug summary can also count the unresolved pit as assigned.

   **Exact failure:** The globally distance-sorted loop evaluates `!assignedPits.Add(candidate.PitIndex) || !assignedTexts.Add(candidate.TextIndex)`. A pit is added to the assigned set before checking whether its nearest text is already used. When the text check fails, the pit stays in that set, so all later candidate labels for that pit are skipped. Its actual `PitId` remains empty. `XcivilImportService.cs:473` calls the faulty allocator; `:562` later generates numbers for unresolved imported pits.

   **DETERMINISTIC TEST — not run:** Prepare a fresh synthetic millimetre source DWG, World UCS, no schedule/PDF/sidecar and no other labels. Draw two closed 600 mm square polylines on layer `PIT`, centred at A=(10000,10000) and B=(11000,10000). Add left-justified DBText `P10` at (10000,12000) and `P20` at (11000,13000), height 100 mm, on a separate `PIT_LBL` layer. Do not put text inside either pit. Import into a fresh empty Civil drawing with `CDIMPORTXCIVIL`, **Read source**, **Import to drawing**.

   The earlier local-label pass has an 1800 mm radius for these squares (`XcivilEntityScanner.Pits.cs:609`), so it takes neither label. The later 4500 mm search admits all four pairs. Their order is A/P10=2000 mm, B/P10=2236.068 mm, B/P20=3000 mm, A/P20=3162.278 mm. A takes P10; B is prematurely marked assigned when P10 is rejected as used; B never takes P20. The squares are 1000 mm apart, beyond the 900 mm equivalence distance for these 600 mm pits, so they remain separate. Their closed-polyline provenance supplies pit evidence and preserves them through network filtering.

   Assert the printed debug-log path contains one `pit-id assign` for `tag=P10`, a `pit-id unresolved` for the pit at (11000,10000), and `Pit ID assignment: assigned=2 unresolved=1`. Assert a later `generated-pit-id` gives that pit `assigned=P11`; the imported schedule review/number is P11 rather than the available P20. A corrected result must assign P10 and P20 with no generated number for either pit.

5. **S06-04 — MEDIUM — Rotated exported fall-arrow blocks lose their direction. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Services/XcivilEntityScanner.cs:1874`, `:1901`, `:1910`; `Modules/Drainage/Services/XcivilPitInsertionService.cs:1092`, `:1099`.

   **In AutoCAD:** Two fall arrows which point at right angles in the source can both point the same way after import. The gradient text survives, making the wrong direction look plausible.

   **Exact failure:** The Civil 3D-style fallback reads a line, leader or polyline inside a block definition. It calculates `directionAngle` from those local coordinates, then transforms only the text position through the block and parent transforms. It stores `Rotation = 0.0` and the untransformed direction angle. The insertion helper fixes block rotation at zero and sets `Angle1` to that angle plus PI. Therefore a 90-degree source block rotation changes the imported position but not the imported direction. This applies to the fallback for gradient/label layers, not merely a hypothetical unrecognised block.

   **DETERMINISTIC TEST — not run:** Use a fresh millimetre source DWG with the two 600 mm `PIT` squares and connecting `SWD PIPE` line from S06-02. Define a block `S06_GRADIENT` with base (0,0), a line from (0,0) to (1000,0), and DBText `1:100` at (0,0), height 100 mm. Give it no attributes. Insert two references on layer `FALL`: one at (15000,14000), scale 1, rotation 0 degrees; another at (15000,18000), scale 1, rotation 90 degrees. The layer name admits this fallback (`XcivilEntityScanner.cs:1767`); the absence of a `FALL` attribute avoids the attribute-based branch.

   Import into a fresh empty World-UCS Civil drawing using `CDIMPORTXCIVIL`, **Read source**, **Import to drawing**. Ensure the `FALL SYMBOL` library asset is available and output layers are unlocked. Confirm the log reports two block-based fall candidates and no applied translation. Select each imported `FALL SYMBOL` and inspect its **Angle1** dynamic property in Properties. Assert both are 180 degrees in the audited code, despite source directions differing by 90 degrees. A corrected result must preserve a 90-degree difference modulo 360 degrees. Compare the relative angle rather than relying on the symbol's drawing convention. This test uses an empty target to isolate direction loss from S06-02.

6. **Reading coverage and verification boundary.** All 111 requested files were obtained with `git show origin/claude/rel-20261022m:<path>` and read, starting with the largest and most central services. Supplemental command callers, layer constants and import-window captions were inspected using Git. No suspected finding is included in the counts. Manual checks above remain unexecuted. The following inventory is in descending source-size reading order; every name is under `Modules/Drainage/Services/`.

```text
SlabService.cs
XcivilImportService.cs
TextService.cs
SourcePlacementService.cs
XcivilEntityScanner.cs
XcivilPipeInsertionService.cs
Spine/CivilSpineProjector.cs
XcivilScheduleService.cs
XcivilEntityScanner.Pipes.cs
XcivilImportService.Pipeline.cs
XcivilPitInsertionService.cs
XcivilLayerRecognition.cs
XcivilImportReportService.cs
XcivilNetworkFilterService.cs
SurveyService.cs
SourceTagService.cs
XcivilEntityScanner.Pits.cs
XcivilImportService.Insertion.cs
SlabCompoundMovePlan.cs
XrefSiteGeometryService.cs
XcivilPipeInsertionService.Annotations.cs
SlabCreationStoragePlan.cs
TreeSiteConstraintService.cs
SourceChangeCaptureModels.cs
SurveyIntakeSanityService.cs
SurfaceEvidenceMapService.cs
WaterTankDetailDrafter.cs
SlabFallRegenerationPlan.cs
SpsDetailGenerator.cs
StormReportReader.cs
Spine/SpineRecordJson.cs
WaterTankPlanBlockSource.cs
SlabManualJointPlacementPlan.cs
UcsGuardService.cs
SuggestionLedgerService.cs
SlabManualJointPlacementService.cs
SourceTagService.SourceChangeRead.cs
XcivilVisionScheduleExtractionService.cs
SlabConstrainedSurfacePlan.cs
SourceCloneMapNativeBridge.cs
SourceChangePlan.cs
XcivilLayerRecognition.Visual.cs
ThemeService.cs
XcivilVisionFallbackOrchestrator.cs
XrefGeometryMath.cs
XcivilJunctionDeconflictionService.cs
Spine/PipeLengthMath.cs
WindowSizingService.cs
WorkspaceMenuInstallerService.cs
XcivilPackageLocatorService.cs
TelemetryQueueService.cs
SurfaceOverlayPlanService.cs
XcivilVisionScheduleParser.cs
SurveyIntakeCaptureService.cs
XcivilSourceTagPitRegistrationService.cs
UcsService.cs
SlabEditAuthorityPolicy.cs
XcivilImportIdempotencyService.cs
Spine/SpineDecisionLedger.cs
SourceTagRemovalClaims.cs
SlabCompoundMoveNativeSession.cs
WaterTankPlanBlockSketch.cs
StandaloneCivilRibbonService.cs
WaterTankDetailFieldMap.cs
SoakageSizingService.cs
SlabSpoonPlacementPlan.cs
WaterTankDetailGrouping.cs
Spine/SpineRecordStore.cs
SlabLevelAuthorityPolicy.cs
SurfaceEvidenceSourceCacheService.cs
SnapTargetFeedback.cs
SurfaceOverlayTransientService.cs
SourceChangeDecisionPolicy.cs
XcivilScheduleDegradedDetector.cs
SurveyIntakeReviewSession.cs
WhatsNewVersionGate.cs
SurveyIntakeApprovalPolicy.cs
WaterTankZoneSplit.cs
SurveyIntakeApplyCoordinator.cs
SourceChangeCoordinator.cs
XrefDownpipeDetectionService.cs
VertexPickLiveFeedback.cs
XcivilImportPreflightService.cs
SourceTagService.SourceChangeApply.cs
Spine/SpineRollbackStore.cs
XcivilEntityScanner.Geometry.cs
SuppliedDesignLookupService.cs
SlabFlowOverlayService.cs
TankLibraryService.cs
SourceTagRepairService.cs
XcivilImportTolerances.cs
ThemeCommandRefreshService.cs
TelemetryEvent.cs
XcivilSourceUnitsCheck.cs
SourceChangeRefusalText.cs
SurveyIntakeStalenessService.cs
SpotLevelReader.cs
SurveyProvenanceEvidenceService.cs
UsageTipService.cs
SlabTypeService.cs
TransientDrawableSet.cs
Spine/SpineConnectionActionResolver.cs
SurveyOutlierMarkingPolicy.cs
SourceChangeRuntimeIntentJournal.cs
WindowHelpKeyBinding.cs
WorkingDatabaseScope.cs
SuggestionLedgerValues.cs
SourceChangeMessagePolicy.cs
ToolbarLayoutService.cs
WhatsNewService.cs
SlabCreationProjectEvidence.cs
```

7. **Summary.** Four code-proven faults remain: spoon placement always fails its colour check on the normal write path; network translation omits spot levels and fall arrows; pit-number matching can discard a usable label; and rotated exported fall arrows lose their rotation. All 111 files were read and prior audits excluded. No code or drawing was changed, and no test was run. The next useful check is the standalone CDSPOON reproduction, followed by the three small synthetic imports above.
