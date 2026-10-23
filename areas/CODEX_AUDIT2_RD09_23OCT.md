1. **ANSWER FIRST — HIGH 2 / MEDIUM 1 / LOW 0.** Three new faults in the test evidence, all SURE and verified by reading. No new drawing failure is claimed as reproduced. No tests or AutoCAD were run.

2. **Most important: eight pipe-label tests can report success without checking a pipe.** Editing a diameter, moving an endpoint and placing masked invert labels are all named as tested, but these eight tests only announce a pass when AutoCAD's library can load. Four print “Verified manually in AutoCAD” without performing or reading back a manual check.

3. **Second: the pipe-to-pit ownership tests do not prove the connections.** The ordinary test only creates a callable action without calling it. Three disabled tests would still announce a pass if enabled. A wrong From/To pit could therefore escape these checks.

4. **Third: two drawing-close checks look in a retired folder.** They skip when that folder is absent, although the current Structural source exists. If an old copy is present, they can check that unrelated copy instead.

5. **The “about 22” figure needs care.** This revision contains 20 permanently ignored cases and two conditional skips caused by the old folder lookup. Separately, 25 cases require an explicit request to run. Other skips depend on libraries and local files. These are source counts, not a measured test-run total. The inventory below names the cases and reasons.

---

1. **Scope and pins.** Read RULES, ROUTER, START_HERE, MASTER_PLAN, the supplied C58/C60/S40/S41 audit and all three `CODEX_AUDIT_*_22OCT.md` reports. Searched BUG_CARPARK before reviewing and again against the candidate findings; checked FINDINGS_LEDGER for duplicates. This is RD09, skipped and weak Civil tests, supporting the Civil + Manager colleague release on 9 November 2026. Manager administrator work remains parked.

2. **Source identity.** Fetched the plugin repository. Read Civil/Manager at `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, through Git in the detached review worktree `C:\ce-cx\rd09`. The limited Structural cross-check used `origin/claude/rel-20261023s`, commit `e6d597c0fbc25e78118760887a70810e0890c9a9`, through `git show`/`git grep`. The brief identifies these as the installed lines; installed DLLs were not independently inspected. All references below use these pins, not master or another chat's uncommitted files.

3. **Meaning of severity and proof.** HIGH means false assurance about common drawing edits or network identity; MEDIUM means an intended safety regression check does not inspect the current source. SURE verifies the test defect, not an observed AutoCAD malfunction. The example drawing failures are consequences these tests cannot detect, not assertions that the pinned product currently exhibits them. Every deterministic test below is a proposed check for a later authorised test lane, NOT RUN here.

4. **Counting method.** Inventoried NUnit Ignore, Explicit, TestCase Ignore, Assert.Ignore and Assert.Inconclusive, including class-level attributes. Looked for Assert.Pass, literal true assertions, no-result exception checks and test bodies disconnected from production. No literal `Assert.True(true)` or `Assert.IsTrue(true)` was found in the Civil test tree. A simple method-body scan produced false positives on braces inside source-code strings; those candidates were inspected and rejected. This is not a compiler-backed exhaustive count of every assertion-free method.

**Ranked new findings**

1. **RD09-01 — HIGH — eight automatic passes falsely stand in for pipe-label behaviour. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage.Tests/Services/AnnotationSystemTests.cs:164`, `:189`, `:211`, `:228`, `:289`, `:306`, `:322`, `:337`. Their unconditional pass statements are at `:180`, `:201`, `:220`, `:236`, `:301`, `:317`, `:332`, `:347`.

   **What the office would see:** a release can be reported green even if Edit Pipe leaves the old diameter on its label, an endpoint grip strands the invert text, or the requested background mask is missing. The test names promise those checks; the bodies do none of them.

   **Exact failure scenario:** `EnsureAutoCADInPath` at `:31` sets `_acadAvailable` after loading acdbmgd. Each of the eight methods either skips because that failed, or immediately calls Assert.Pass. There is no drawing fixture, command invocation, grip action, entity inspection or saved native receipt. Loading a library is the only precondition for success. This remains true even inside a running AutoCAD session.

   **Misleading supporting checks:** the first two passes cite `UpdateAnnotationContent_NullId_ReturnsFalse` at `:131`; that check is itself Explicit and only tests a null identifier. It cannot establish preservation or text updates on a real annotation. `GlobalOffsetChange_OnlyAffectsNewAnnotations` at `:247` constructs two unrelated objects and checks their assigned properties without changing Settings or creating/editing a pipe. `InvertText_BottomPosition_IsOppositeOfDefault` at `:275` compares local literals “Top” and “Bottom”; changing production placement would not affect it.

   **Relevant production, not invoked by these tests:** `Modules/Drainage/Services/TextService.cs:1239` and `:2196`; `Services/LinkService.PipeAttachmentUpdates.cs:98`. Other tests inspect planning and source wiring, including PipeAttachmentSemanticContractTests and PreparedPipeOutputTests. They do not turn these eight passes into observed AutoCAD results.

   **DETERMINISTIC TEST — false-pass control:** in a later disposable test copy, substitute an annotation writer that does nothing, keeping its signature. Select these eight cases only. A valid regression suite must fail on unchanged text/positions/masks; the present eight bodies have no dependency on that writer and still call Assert.Pass whenever `_acadAvailable` is true. Require the test runner's command-line result to say Failed for the broken writer. Do not perform this substitution in the installed plugin.

   **DETERMINISTIC TEST — actual drawing:** synthetic millimetre DWG, World UCS, unlocked layers, one isolated CE polyline pipe named RD09-P1, from `(0,0)` to `(10000,0)`, diameter 150 mm, known endpoint inverts, pipe text plus both invert labels. Record each label handle, text, position and mask. Type `PIPEEDIT`, select RD09-P1, change diameter to 225 mm and Save. Assert the same label handles still resolve and the diameter text reads 225. One U must restore 150; REDO must restore 225. On a separate copy grip-stretch the second endpoint to `(10000,5000)`; assert the endpoint's invert label retains its recorded relative offset to that endpoint and the pipe label lies on its updated recorded segment/offset, rather than remaining at its old coordinates.

   **DETERMINISTIC TEST — four placement states:** use separate copies and the invert-label controls in Edit Pipe to select above/below and mask on/off. Save each state. Assert the actual MText lies on the selected side of the directed pipe and its BackgroundFill equals the chosen boolean. Capture the window selection and entity readback together. A comment or the “Verified manually” test message is not evidence.

   **Smallest fix:** remove the false acceptance wording and make these cases explicitly unverified until they have a host fixture or a validated native receipt. Replace each pass with assertions on the real saved entities. Replace the literal/independent-object checks with calls through the actual placement/settings consumer. Preserve useful pure geometry and null-input tests; do not add a drafting hard block.

2. **RD09-02 — HIGH — the ownership test family cannot detect a pipe assigned to the wrong pits. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage.Tests/Services/OwnershipTests.cs:16`, `:32`, `:36`, `:43`, `:50`, `:61`, `:71`; production `Modules/Drainage/Services/LinkService.Registration.cs:632`.

   **What the office would see:** a pipe can appear in a schedule with the wrong From/To pit while this test family reports no failure. The most important close-pit example is only a comment, not a drawing operation.

   **Exact failure scenario:** `SetExplicitPipeOwnership_ApiExists` creates an Action at line 20 and asserts that the Action is non-null; it never invokes it. This proves compile-time availability only. The integration fixture is unconditionally Ignore. Its first two methods call production with `ObjectId.Null` and only require no exception. Its remaining three methods contain comments followed by Assert.Pass. Removing the Ignore alone would therefore not check saved ownership, geometry fallback or close-pit selection.

   **Boundary of the finding:** PipeEndpointConnectionPlannerTests checks planning and ordering around the setter, and other network tests have meaningful expected results. No claim is made that all topology logic lacks unit tests. The missing evidence is the selected objects becoming the correct persisted native From/To links and retaining those links after editing/reopening.

   **DETERMINISTIC TEST — false-pass control:** in a future disposable test copy replace only SetExplicitPipeOwnership's implementation with an empty body. The ApiExists test must fail if offered as ownership evidence; it currently cannot. After replacing the three placeholder cases with real tests, the same no-op must fail their stored-link assertions. Null-input no-throw tests should still pass and should be reported as null-input tests only.

   **DETERMINISTIC TEST — actual drawing:** synthetic millimetre fixture with CE pits P3 at `(0,0)` and P5 at `(10000,0)`, and a third unselected pit P9 close to P5 within the configured endpoint search range. Record the actual pit handles so selection is unambiguous. Type `CD`, deliberately snap from P3 to P5 and finish the pipe. Type `PITSCHEDULE`. Assert the pipe row says From P3 and To P5, never P9. Read the pipe's stored explicit pit identifiers as well as the displayed row. Type `PIPEEDIT`, select that pipe, change only 150 mm to 225 mm and Save; assert From/To remain P3/P5. QSAVE, close/reopen the copy and assert the same identifiers and row. A second fixture without nearby pits must retain unknown/empty endpoints rather than inventing ownership. The original 200 mm close-pit example should use a prepared accepted fixture if new-pipe checks prevent constructing that arrangement interactively; do not weaken those checks to make the test run.

   **Smallest fix:** keep/rename the signature test as a compile contract, replace the three pass-only cases with a host-backed registration/readback test, and execute that fixture in the native lane. Null-ID smoke tests are not substitutes for registering a real object.

3. **RD09-03 — MEDIUM — two drawing-close safety checks search outside the current project and can skip or inspect stale code. SURE; verified-by-reading.**

   **File:line:** `Modules/Drainage.Tests/Services/TeardownCrashGuardTests.cs:35`, `:39`, `:42`, `:73`, `:77`, `:80`, `:261`. Current Structural implementation: `Modules/Structural/Services/FoundationMonitor.cs:111`, `:146`, `:155` at the Structural pin.

   **What the office would see:** there is no reliable test receipt for these two close-drawing protections. A later regression in clearing pending footing objects before closing a DWG could escape these guards, with a potential AutoCAD close/crash consequence. The current Structural source DOES clear the pending objects; this report does not allege a current crash there.

   **Exact failure scenario:** both tests walk upwards from the test-output folder looking for `CE_STRUC_SUITE/CE_STRUC_SUITE/Services/FoundationMonitor.cs`. The pinned repository stores the file under `Modules/Structural/Services`. A normal isolated checkout containing only the current tree reaches Assert.Ignore. If an ancestor contains the retired folder shape, the test reads that file without checking its revision. Merely placing the right current source beside Civil cannot make the intended lookup work. The first assertion also searches for the older `FoundationRegistryService.Invalidate` wording, whereas the pinned Structural Detach calls `ForgetDrawing`; repairing the path needs a current semantic assertion too.

   **DETERMINISTIC TEST — source and command-line result:** fixture is an isolated checkout of the pinned trees, with no retired sibling folder. Run just `FoundationMonitor_Detach_FlushesStaleObjectIds_BeforeInvalidate` and `FoundationMonitor_Detach_RemoveWhereHasPerIdTryCatch` in a later authorised lane. Assert two executed cases, zero ignored, and an evidence line naming `Modules/Structural/Services/FoundationMonitor.cs` plus the intended Structural commit. Today the locator returns null in that fixture. Negative control: alter only a disposable copy's Detach to omit the pending-ID cleanup; require Failed, not Ignored or Passed. Put a harmless retired-shaped decoy in an ancestor; assert the resolved source and result do not change.

   **DETERMINISTIC TEST — native companion:** two synthetic drawings A and B, each with one CE footing driver, with A's handle recorded. In A, `MOVE` its driver by 100 mm, then `CLOSE` and choose No for the disposable copy. For a controlled pending-work case, the native harness must queue A's known driver immediately before the normal close event. At Detach completion assert no pending handle belongs to A; after returning to B assert B remains responsive, its footing is unchanged and the CE log has no Monitor.OnIdle failure for A. Repeat the same sequence on the older supported AutoCAD lane. This native test was not performed here.

   **Smallest fix:** move/locate these assertions in the Structural suite against its own pinned `Modules/Structural` source; fail clearly when required source is missing. Restrict the scan to Detach and assert cleanup precedes the current ForgetDrawing call. Do not use the Civil branch's older Structural snapshot to certify the separately installed Structural release.

**Skip inventory A — 20 unconditional ignored cases, plus the two old-path cases**

1. **LinkRegistrationServiceTests.RegisterPit_DefaultObjectId_DoesNotThrow.** `Services/LinkPersistenceServiceTests.cs:122`; fixture Ignore at `:118`: requires live AutoCAD native host. It only exercises a null object ID.
2. **LinkRegistrationServiceTests.RegisterSourceBlock_DefaultObjectId_DoesNotThrow.** Same file `:128`; same fixture Ignore and null-ID reason.
3. **LinkRegistrationServiceTests.RegisterPitAttachment_NullIds_DoesNotThrow.** Same file `:134`; same fixture Ignore; both IDs null.
4. **LinkRegistrationServiceTests.RegisterSourceBlockAttachment_NullIds_DoesNotThrow.** Same file `:140`; same fixture Ignore; both IDs null.
5. **LinkRegistrationServiceTests.RegisterAttachment_NullIds_DoesNotThrow.** Same file `:146`; same fixture Ignore; both IDs null. Installing AutoCAD does not remove this fixed Ignore attribute.
6. **OwnershipIntegrationTests.SetExplicitPipeOwnership_NullPipeId_DoesNotThrow.** `Services/OwnershipTests.cs:36`; fixture Ignore `:32`, native host required. Null-ID smoke check only.
7. **OwnershipIntegrationTests.SetExplicitPipeOwnership_BothEmptyPitIds_DoesNotThrow.** Same file `:43`; same fixed Ignore, null object ID and empty names.
8. **OwnershipIntegrationTests.RegisterPipe_WithExplicitPitIds_StoresOwnership.** Same file `:50`; same fixed Ignore. Its body is also a pass-only placeholder, RD09-02.
9. **OwnershipIntegrationTests.RegisterPipe_NoExplicitIds_FallsBackToGeometrySnap.** Same file `:61`; same fixed Ignore and placeholder.
10. **OwnershipIntegrationTests.TwoAdjacentPits_DrawPipeBetweenThem_CorrectIdsAssigned.** Same file `:71`; same fixed Ignore and placeholder.
11. **MultiPlanNetworkDrawingStoreTests.EmptyDrawing_ReadsAsNotPresentWithoutCreatingRecord.** `Services/MultiPlanNetworkDrawingStoreTests.cs:117`; fixture Ignore `:107`: standalone Database construction can crash the AutoCAD 2027 native APIs. Real read assertions exist; run only with a suitable native host.
12. **MultiPlanNetworkDrawingStoreTests.InvalidNativeDocument_DoesNotCreateDrawingStorage.** Same file `:138`; same fixed Ignore; meaningful invalid-write/read assertions.
13. **MultiPlanNetworkDrawingStoreTests.ValidRisingMain_RoundTripsFromDrawingAsOneLogicalPipe.** Same file `:164`; same fixed Ignore; meaningful ownership, fragment and continuation readback assertions.
14. **MultiPlanNetworkDrawingStoreTests.RollbackRestoresPreviousValidatedNativeRecord.** Same file `:198`; same fixed Ignore; meaningful previous-diameter readback assertion.
15. **LongSectionBridgeTests.BuildDefaultOptions_ThreePitSection_DatumMatchesLongSection.** `Services/LongSectionBridgeTests.cs:449`, Ignore `:448`: export-options type is in an AutoCAD-coupled service file; the stated reason is unavailable acdbmgd in the unit runner.
16. **LongSectionBridgeTests.BuildDefaultOptions_ThreePitSection_ScalesAre100And50.** Same file `:466`, Ignore `:465`; same reason. It compares numeric scale values if enabled.
17. **LongSectionBridgeTests.BuildDefaultOptions_ThreePitSection_StartAndEndPitIdsSet.** Same file `:483`, Ignore `:482`; same reason. These three attributes are unconditional, not environment probes. Git search found no production caller of BuildDefaultOptions at this pin: do not present them as three proven holes in the actual CDLONGSEC doorway. Other LongSectionBridge tests do execute pure transformations.
18. **C60AuditSourcePinGuardTests.TidyLabelsPreview_ReachesTheYesQuestionWithoutWritingInitialisation.** `Services/C60AuditSourcePinGuardTests.cs:105`, Ignore `:104`: BUG-863.
19. **C60AuditSourcePinGuardTests.TidyCountPass_UsesNoNormalTransaction.** Same file `:130`, Ignore `:129`: BUG-863.
20. **C60AuditSourcePinGuardTests.LayerEnsure_OnlySetsAppearanceOnNewRecords.** Same file `:137`, ignored TestCase `:136`: BUG-864.
21. **TeardownCrashGuardTests.FoundationMonitor_Detach_FlushesStaleObjectIds_BeforeInvalidate.** `Services/TeardownCrashGuardTests.cs:35`, conditional Ignore `:42`: retired source path absent; RD09-03. This is conditional, not one of the 20 Ignore attributes.
22. **TeardownCrashGuardTests.FoundationMonitor_Detach_RemoveWhereHasPerIdTryCatch.** Same file `:73`, conditional Ignore `:80`: same retired source path; RD09-03.

1. **Inventory path convention.** Paths in the inventories above and below are relative to `Modules/Drainage.Tests/`. The 22 entries explain a plausible 20 + 2 result on a clean isolated checkout, not proof that a particular historical run skipped exactly these cases. No TRX or equivalent result file was supplied/read for that run. Explicit exclusions and additional environment conditions can change what the adapter reports.

**Skip inventory B — 25 Explicit cases, normally excluded unless selected deliberately**

1. **PitLabelAttributeProbeTests.PitLabelBlocks_ReportWhetherTheNumberIsAnAttribute.** `Commands/PitLabelAttributeProbeTests.cs:29`; Explicit `:28`: requires `CE_PIT_LABEL_DWG` pointing to a drawing copy with CE pits. Missing input also calls Ignore.
2. **PitLabelAttributeProbeTests.PipeAttachmentBlocks_ReportWhetherTheyCarryAttributes.** Same file `:108`; Explicit `:107`: same variable, copy with CE pipes; diagnostic output, ends in Assert.Pass.
3. **WaterTankPickerTests.TimsMaster_WhatTheWindowWillList.** `Commands/WaterTankPickerTests.cs:177`; Explicit `:176`: requires `CE_WT_MASTER`; absent file also skips.
4. **WaterTankPickerTests.TimsMaster_WhichPlansNeedATitle.** Same file `:196`; Explicit `:195`: same requirement; reports a probe and passes.
5. **WaterTankPickerTests.TimsMaster_EveryListedBlockHasAPicture.** Same file `:219`; Explicit `:218`: needs the water-tank master copy. This one has picture-related assertions; do not classify every master probe as empty.
6. **ReplicationEvidenceTests.Replicate_All14RealJobs_FromInputsOnly_Twice.** `Diagnostics/ReplicationEvidenceTests.cs:78`; fixture Explicit `:39`: on-demand evidence run writes a report. It does assert collected failures are empty.
7. **ReplicationEvidenceTests.DraftEvidenceDetails_ThreeRealJobs_EngineNumbersOnOfficeTemplate.** Same file `:187`; same fixture Explicit; requires the office master, otherwise Inconclusive. It has assertions, not a placeholder.
8. **SurveyDiagnosticTests.Inspect_SurveyDwg_ReportAllEntities.** `Diagnostics/SurveyDiagnosticTests.cs:46`; fixture Explicit `:21`: inspect a local survey DWG manually. Missing local mapping is Inconclusive. Diagnostic, not drawing acceptance.
9. **XrefSiteGeometryArchiveValidationTests.Extract_AllKnownArchiveJobs_BoundaryWithinHalfPercent.** `Diagnostics/XrefSiteGeometryArchiveValidationTests.cs:61`; fixture Explicit `:24`: reads the local office archive; absent archive is Inconclusive.
10. **AnnotationSystemTests.UpdateAnnotationContent_NullId_ReturnsFalse.** `Services/AnnotationSystemTests.cs:131`; Explicit `:127`: ObjectId access needs native initialisation/live document. Separate from the eight ordinary placeholder methods.
11. **CouncilSourcePageRendererTests.Render_LocalK02_EachRecordedHighlightOverlaysRealPassageInk.** `Services/CouncilSourcePageRendererTests.cs:91`; Explicit `:90`: retained fingerprinted source PDF via `CE_K02_SOURCE_PATH`; missing variable/file skips. Generated-PDF tests remain separate.
12. **DetailReplicaComparator.CompareOrificeReplicaAgainstW2626.** `Services/DetailReplicaComparator.cs:34`; Explicit `:33`: reads local archive; unavailable source is Inconclusive. Produces a gap report rather than requiring zero gaps.
13. **DetailReplicaComparator.CompareSpsReplicaAgainst2515.** Same file `:46`; Explicit `:45`: same local-archive/gap-report purpose.
14. **MasterDetailCaptureTests.DiscoverZones_PumpStationMaster_ListsSpsDetails.** `Services/MasterDetailCaptureTests.cs:27`; Explicit `:26`: office master read on demand; missing master is Inconclusive.
15. **MasterDetailCaptureTests.CaptureSpsVariants_ToEvidence.** Same file `:47`; Explicit `:46`: writes evidence drawings, requires the master. Assertions check capture success and block/entity readback.
16. **OrificePitDetailW2626ProofTests.GenerateReplicaDwg_ForSideBySideProof.** `Services/OrificePitDetailW2626ProofTests.cs:25`; Explicit `:24`: generates an evidence DWG for later visual comparison.
17. **OrificePitDetailW2626ProofTests.GenerateSpsReplicaDwg_ForSideBySideProof.** Same file `:44`; Explicit `:43`: same output-artifact reason. Writer success is checked, not visual equivalence to the reference drawing.
18. **PipeFlowSizingParityTests.WriteGolden.** `Services/PipeFlowSizingParityTests.cs:132`; Explicit `:131`: deliberately rewrites the expected-results file from the code under test, intended for the base commit only. Correct to keep this outside routine regression runs; the ordinary parity test reads the existing expected results.
19. **PitBlockCompatibilityProbe.ComparePitBlock2vs3.** `Services/PitBlockCompatibilityProbe.cs:27`; Explicit `:26`: reads local block DWGs; missing sources are Inconclusive; diagnostic output then Pass.
20. **PitBlockCompatibilityProbe.DumpPitBlock3_ShippedVsUpdated.** Same file `:43`; Explicit `:42`: same local block requirement, comparing shipped and updated copies; diagnostic output then Pass.
21. **Sps2515MinerProbe.DumpSpsDetailAnatomy.** `Services/Sps2515MinerProbe.cs:29`; Explicit `:28`: local project archive only; missing input is Inconclusive; diagnostic dump.
22. **StandardDetailLibraryMinerProbe.CataloguePumpStationMaster.** `Services/StandardDetailLibraryMinerProbe.cs:31`; Explicit `:30`: local standard-detail master; missing master is Inconclusive.
23. **StandardDetailLibraryMinerProbe.CatalogueOrificePitsMaster.** Same file `:38`; Explicit `:37`: same local-master/catalogue purpose.
24. **W2626ConventionMinerProbe.DumpDraftingConventions.** `Services/W2626ConventionMinerProbe.cs:30`; Explicit `:29`: local archive only; missing drawing is Inconclusive; diagnostic dump.
25. **CouncilSourceViewModelTests.Presenter_LocalK02_ProductionFieldAndEachExplicitBranchRenderTheirRecordedPage.** `ViewModels/CouncilSourceViewModelTests.cs:123`; Explicit `:122`: requires retained fingerprinted K02 PDF via `CE_K02_SOURCE_PATH`; absent source skips. Generated-file presenter tests remain separate.

**Other conditional exclusions — why the total is machine dependent**

1. **AutoCAD library unavailable.** `AcadTestHost.cs:45`, `:50`, `:70`, `:89` can ignore every test in a fixture calling EnsureLoadedOrIgnore. The cause is no matching native installation or failure to load acdbmgd, with a cached missing result. This is distinct from running inside acad.exe: loading acdbmgd alone does not supply command events or a drawing window.

2. **Fixtures using that shared gate.** The direct callers at this pin are Bug605LandXmlPitInvertTests, Bug605NamedInvertTests, LandXmlNativeInvertRegressionTests, LandXmlUnknownsTests, PipeTextSegmentChooserTests; Bug542LongSectionRoughnessTests, Bug544XcivilImportSettingsTests, CeAiEndpointResolverTests, CeAiMasterSwitchTests, DesignFlowsJobCurveTests, HardGroundRunoffCTests, MarkupAnalysisPrivacyTests, both MultiPlanNetworkDrawingStore fixtures, NoDetentionSentenceTests, PreDevCPrintedTests, StormStillRisingTests, XcivilAiFallbackPrivacyTests, XcivilEndMatchBug447Tests, XcivilImportToleranceSettingsTests, XcivilJunctionDeconflictionServiceTests, XcivilPipeSourceDeduplicationTests, XcivilPipeTrimToPitOutlineTests, XcivilRainwaterTankRecognitionTests, XcivilSourceTagPitRegistrationTests, XcivilZeroLengthPipeTests, BoydsStartsBlankTests and Bug544DetentionTabPreDevCTests. Every discovered case in the affected fixture is conditional on that setup; none is claimed skipped on this PC in this audit.

3. **Fixtures with their own library lookup.** CopyRotateCommandsTests (`Commands/CopyRotateCommandsTests.cs:102`, `:117`), GeometryHelperTests (`Helpers/GeometryHelperTests.cs:49`, `:68`), LandXmlParserTests (`Helpers/LandXmlParserTests.cs:47`, `:61`), LinkPersistenceServiceTests (`Services/LinkPersistenceServiceTests.cs:44`, `:57`), PipePickRotatedUcsTests (`Services/PipePickRotatedUcsTests.cs:34`, `:41`), PropagationCascadeHuntTests (`Services/PropagationCascadeHuntTests.cs:32`, `:39`), PropagationPlanTests (`Services/PropagationPlanTests.cs:74`, `:83`), UcsGuardServiceTests (`Services/UcsGuardServiceTests.cs:47`, `:62`), XcivilEntityScannerPipeTests (`Services/XcivilEntityScannerPipeTests.cs:41`, `:54`) and XcivilPitRotationTests (`Services/XcivilPitRotationTests.cs:30`, `:36`) skip on absent/unloadable native AutoCAD libraries. AnnotationSystemTests has the separate per-method gates inventoried in RD09-01 and inventory B10.

4. **Missing detail masters.** `Services/OrificeStandardDetailDrafterTests.cs:705` and `Services/WaterTankDetailDrafterTests.cs:445` call Ignore through SkipIfMasterAbsent for the tests requiring their office masters. Null-input/missing-path tests can run without those masters. This is a real conditional coverage loss for output drawings, but not proof of a product error or reason to put private drawings in the repository.

5. **Other conditions.** `Services/C617UserWritersMixedUnitsTests.cs:231` skips its native graph case when AutoCAD geometry is unavailable. `Services/RaingardenAtomicPlacementTests.cs:20` skips only the net48 stub-lane path after InvalidProgramException; `AutoCadStubLane.cs:20` rethrows on the modern lane. Do not describe modern-lane failures as intentional skips.

6. **Diagnostics and environment.** `Services/LoggingServiceThroughputTests.cs:149` skips Diagnostic_MessagesReachTheLogFile when logging cannot initialise. `Models/PerfDiagWordsTests.cs:109`, `:123` mark the June/January Melbourne timestamp tests Inconclusive if timezone data is absent. `Services/SharedRuntimePathAndIconTests.cs:94` skips its non-bundle assumption when actually running inside a bundle. `Services/SharedCommandRegistryModelTests.cs:33` contains a missing-registry Ignore, but its TestPaths.SourceFile call already asserts that the file exists; do not assume this branch normally produces a skip.

7. **Known conditional guard.** `Services/C60AuditSourcePinGuardTests.cs:91` has a self-quarantine at `:97`: BUG-863. At this pin, CheckIgnoreCommand no longer contains the old initialisation call tested by that condition, so it is not counted among the 22 above. No previous bug is re-reported here.

**Weak-test inventory and commands effectively untested by those checks**

1. **PIPEEDIT / CDEDIT pipe edit.** AnnotationSystemTests' two edit cases check no entity identity or changed text. Effectively untested there: Save writes the requested diameter/grade into the existing label, Cancel preserves it, and one Undo restores the prior entities. Planning/view-model/source tests elsewhere remain useful; do not describe the entire command as having zero tests.

2. **AutoCAD endpoint grips and CD invert placement.** The two grip and four invert-mask cases are the six other false passes in RD09-01. No assertion proves a label follows a native grip or uses the requested side/mask. The local-string and unrelated-offset-object tests also cannot establish drawing behaviour. Native grips are not equivalent to calling a geometry helper with already-correct coordinates.

3. **CD to PIT/PITSCHEDULE ownership.** OwnershipTests has one signature-only check, two ignored null/no-throw checks and three ignored placeholders. Effectively untested by this family: the selected pit handles are saved, a competing nearby pit is not substituted, geometry fallback gives the right result, and ownership survives Edit Pipe and reopen. The five ignored LinkRegistrationServiceTests do not fill that gap: they all supply null IDs.

4. **PIT / PITEDIT / source-block attachment registration.** The ignored LinkRegistrationServiceTests test only harmless handling of missing inputs. They contain no actual pit, source block, attachment registration or readback. This is a narrow coverage limitation, not a new claim that PIT/PITEDIT lack all tests. Window/view-model tests and other placement contracts exist; the ordinary user command, saved label and reopen need native evidence.

5. **CDDESIGN exception-only examples.** `Services/AutoDesignServiceTests.cs:43`, `:53`, `:80` call Design and discard its returned proposal. They prove no exception for zero/negative head on no-detention jobs and positive head on detention jobs; they do not validate storage, flow or orifice size. Other cases in the same file assert archetype, zero detention and weighted C, and AutoDesignBackTestTests/DetentionPipeLimitsRuleTests exercise results. Therefore “CDDESIGN is entirely untested” would be false. The proposed test improvement is to retain and assert the returned proposal for each distinct fixture, not to treat every DoesNotThrow as defective.

6. **CDWT / orifice-detail no-throw examples.** `Services/WaterTankDetailDrafterTests.cs:124` and `Services/OrificeStandardDetailDrafterTests.cs:316` only establish that a missing master does not throw. Neighbouring cases assert a failure result/warning and, when masters exist, output values and entity contents. Do not inflate these limited smoke tests into proof that a real inserted detail is correct; equally, do not erase the genuine surrounding coverage.

7. **Diagnostic methods are not acceptance tests.** PipeAttachmentBlocks_ReportWhetherTheyCarryAttributes, TimsMaster_WhichPlansNeedATitle, the two PitBlockCompatibilityProbe cases, SurveyDiagnosticTests, Sps2515MinerProbe, StandardDetailLibraryMinerProbe and W2626ConventionMinerProbe dump information then pass. DetailReplicaComparator (`Services/DetailReplicaComparator.cs:80`, `:105`, `:127`) prints missing entities/text and differing extents, then passes regardless of gap size. This is consistent with its stated gap-report purpose; it cannot be counted as a zero-difference assertion. Keep diagnostic output outside accepted-drawing pass totals.

8. **No blanket “no assertions” claim.** Assert.Pass is a success signal, not a behavioural assertion. Conversely, Assert.DoesNotThrow can be the correct assertion for a null guard or deliberate fault-tolerance contract, and helpers can contain meaningful nested assertions. For example SelfPipeRepairServiceTests' no-throw blocks also inspect results. The rejected no-assertion candidates LockedLayerRecordWriteRuleTests.SourceGuard_TheRunningListIsReadNeverWritten and Bug859Round2HitTestTests.TheHitTest_OnlyReads_ItNeverOpensAnythingForWriteOrSelects both contain Assert.Multiple; they are not empty tests.

9. **Native command/event evidence remains separate.** Source text checks for a method call, command-name string or guard order do not simulate a real double-click, right-click, active drawing, modal window, native selection timing or Undo/Redo. Command-outcome text alone is also not a drawing-value assertion. Relevant already-known findings are BUG-859, BUG-860, BUG-861, BUG-862, BUG-863 and BUG-864. They are not counted again or expanded here.

**What I did NOT check**

1. **No execution.** No build, unit-test run, AutoCAD/accoreconsole, drawing, installation, deployment or sub-agent. Executed tests: 0; runtime pass/fail/skip totals: not measured. The deterministic scenarios above are instructions, not receipts. No current native fault is marked fixed, reproduced or accepted.

2. **No private fixtures or live settings.** Did not open the office archive, client drawings, local source PDFs, installed DLLs or Tim's Settings. The audit does not verify what conditional tests ran in a historical “22 skipped” result, which test filter was used, or how its adapter counted Explicit cases.

3. **Bounded coverage.** Civil test-source inventory and selected high-use command families, with a limited Structural source/guard cross-check. Not a full Manager/Structural suite audit, exhaustive command-frequency ranking, dynamic coverage measurement or proof that no other weak tests exist. No usage telemetry was read; high-use priority follows the brief's drafting workflows.

4. **Changes and handoff.** Only this findings file is authored in CE_PLAN. No code/branch/PR or BUG_CARPARK, DESK_LOG or QUEUE edit. The temporary detached review worktree is removed after verifying it is clean. Next work belongs to the test owners: replace false acceptance passes, fix the obsolete source lookup, then produce native drawing-value receipts. R-00/R-27 remain unchanged; this report introduces no new engineering numbers or command hard blocks.

**Summary — under 100 words**

Three verified test defects: eight automatic pipe-label passes, an ownership test family that never proves real saved links, and two close-drawing guards aimed at a retired source path. The inventory identifies 20 fixed Ignore cases, two old-path conditional cases and 25 Explicit cases, with further environment-dependent skips. “Green” therefore does not certify these native drafting actions. Prioritise real entity readback for pipe edits, grips and pit ownership, and bind source guards to the correct release. No tests or AutoCAD were run; no new runtime failure is claimed.
