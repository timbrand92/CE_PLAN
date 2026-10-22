1. **ANSWER FIRST — 6 findings: HIGH 3 / MEDIUM 3 / LOW 0.** The most important is Markup Undo: after switching drawings, it targets the active drawing but marks the earlier drawing's markup as undone. The earlier note remains and running the batch again can duplicate it.

2. **What a drafter meets.** An excluded schedule row can still choose a column size. A section name containing 25.7 becomes 26. A turned schedule has text and frame facing different ways. A refused rib command changes the selected line. Copying an Xref loses whether its clip was inverted or switched off.

3. **Evidence and limits.** Verified by reading the specified source; not tested in AutoCAD. All 189 requested files were retrieved and read from Git, largest first, with deeper command-to-drawing traces for the findings below. No build, test run, AutoCAD session, installation, plugin edit or sub-agent was used. The tests below are instructions for a later tester on synthetic copies, not work for Tim.

---

1. **Technical scope and source identity.** CODE SWEEP S14, Structural Services slice 2 of 2; 23 October 2026, Melbourne time. Repository: C:\Lisp Files\CE_ACAD_PLUGIN. Reviewed ref: origin/claude/rel-20261022s2, pinned to commit 2c9a96942a024888a5ab520600f2d5025de83036, identified in the brief as Structural 1.0.121. Installed binaries were not inspected. Every service citation below is relative to Modules/Structural/Services/ and every line number refers to that pinned revision.

2. **Prior findings excluded.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md and CODEX_AUDIT_STRUCTURAL_22OCT.md, CODEX_AUDIT_CIVIL_22OCT.md and CODEX_AUDIT_GATE_22OCT.md. The findings below are different execution paths and failures, not repeats of their CEMEMBER, hatch, Civil read-only/REDO, release or Manager findings.

3. **Rulings and ownership.** This report proposes no new hard block and makes no release decision. R-27 and R-00 remain in force. The 9 November colleague release remains Civil + Manager; Manager administrator work stays parked. The only authored file is areas/CODEX_SWEEP_S14_23OCT.md in C:\CE_PLAN. No PR, branch, worktree or source commit is part of this hunt.

---

1. **S14-01 — HIGH — Markup Undo targets the wrong drawing and records success before Undo happens.**

   **For Tim.** Place an approved markup note in drawing A, switch to drawing B and use CEMARKUPUNDO. A's note stays, but CE says its batch was undone. Returning to A and running the same batch again can put a second note over the first. B's native Undo history is used instead.

   **Verified-by-reading.** MarkupAIRuntimeState.cs:9 and :18 keep one process-wide execution-history stack. MarkupAIWorkflowService.cs:179 pushes a batch without a drawing identity; :219 pops it before calling Undo. MarkupAIExecutionService.cs:220 queues only `_.U ` and immediately returns true. The supporting CommandDispatcher.cs:47 chooses MdiActiveDocument and :52 calls SendStringToExecute.

   MarkupAIWorkflowService.cs:240 changes the plans to Pending, :246 saves them and :250 returns `Undid batch '...'.` without waiting for a command result. The command entry point, Modules/Structural/Commands/MarkupAICommands.cs:251, checks the active drawing but does not match it to the batch's drawing. No activation handler clears or transfers this history.

   **Exact failure scenario.** A successful native note batch in A remains in shared history while B is active. An Undo queued on B cannot remove A's note. The saved plan nevertheless becomes Pending. This failure does not depend on which particular B object native U removes. Loss of a particular B object is a native-host consequence to measure, not a claimed observation.

   **DETERMINISTIC TEST — fixture.** Use two disposable, writable millimetre drawings, A and B, with World UCS and Model space active. In A draw a closed rectangle from (0,0) to (4000,4000). Use a fresh package ID with no previously saved command plans, no external parser and one approved note. The later tester can create the following synthetic package JSON outside either repository; use a fresh ID on each repeat:

   ```json
   {
     "PackageId": "s14-undo-note-v1",
     "IncludesCivil": false,
     "Items": [{
       "ItemId": "s14-note-1",
       "PageNumber": 1,
       "IntentType": 7,
       "Text": "S14 NOTE",
       "NormalizedText": "S14 NOTE",
       "Geometry": [[0,0],[100,0],[100,100],[0,100]],
       "Confidence": 1.0,
       "Approved": true,
       "RequiresManualReview": false
     }]
   }
   ```

   **Typed steps.** In A, CEMARKUPLOAD and choose that JSON. CEMARKUPPREVIEW must show one CeCommand NATIVE:NOTE action with place=yes. CEMARKUPRUN, Yes. Verify exactly one MTEXT containing S14 NOTE and CEMARKUPSTATUS executed=1. Switch to B, draw LINE from (0,0) to (1000,0), Enter; then CEMARKUPUNDO. Wait for the command prompt, run CEMARKUPSTATUS, switch back to A and run CEMARKUPRUN, Yes.

   **Assertion.** Record the `Undid batch` command-line text, Pending/executed values and number of S14 NOTE objects in A. The current path predicts A's original note survives the purported Undo and A then contains two such notes. A correct outcome must never mark an A batch undone while its objects remain; B's unrelated work must also survive. Record B's line separately to avoid treating native U grouping as already proven.

2. **S14-02 — HIGH — Rows deliberately excluded from the schedule still drive column sizing.**

   **For Tim.** Exclude C2 = 200 SHS from the schedule and insert the remaining beam row. The printed schedule omits C2, but typing C2 still takes 200 SHS from that excluded row instead of offering the column-size choice.

   **Verified-by-reading.** XclmTxtService.cs:277 passes the entire preview row collection to TryPersistMemberSchedule. Its filter at :311 checks only null, title status and blank mark; it does not check Include or the inserted floors. It saves those rows at :324.

   In contrast, ExcelMTextService.cs:2579 skips excluded rows and :465 filters the selected floors for actual placement. The supporting dialog confirms only included members at Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml.cs:1335, yet returns all rows at :1352. MemberScheduleService.cs:31 returns the first saved match by code. Modules/Structural/Commands/SupportBlockCommands.cs:244 then uses that match for C2; :255 says the size came from the schedule, and the size-choice branch at :258 is skipped.

   **Exact failure scenario.** One excluded, non-title C2 row remains in the preview alongside one included beam on the inserted floor. No duplicate mark or malformed source is needed. This is an unapproved sizing input, not merely a wrong saved-row count. Rows on floors that were not inserted are also retained by the same unfiltered save, but this finding uses explicit exclusion as its decisive case.

   **DETERMINISTIC TEST — fixture.** Clean millimetre Model-space drawing with no prior member-schedule snapshot; approved C2 block assets available, output layers unlocked, and normal C2 size choices in Settings. Prepare a synthetic two-member CSV with B1 / 310UB32 and C2 / 200 SHS. In XCLMTXT use Change Source to choose it, then Manual Editor. Set both rows to Ground Floor and non-title member rows.

   **Click/typed steps.** Select the C2 row, click Exclude Selected, confirm its Status reads Excluded, then Done. Select only Ground Floor for insertion and click Insert Selected. The confirmation must count one member. Confirm and pick (0,0). Verify the drawn schedule has B1 but no C2. Type C2.

   **Assertion.** The current save predicts `[XCLMTXT] Member schedule snapshot saved (2 row(s)).` despite only one inserted member, followed by `[CE] C2: size '200 SHS' from the schedule, shown as '200 SHS'.` C2 must instead offer its ordinary size choice when no included C2 row was approved. A later read of CE_STRUC_SUITE.MEMBER_SCHEDULE must contain only the approved inserted member, not the excluded C2.

3. **S14-03 — HIGH — Schedule insertion changes the engineer's decimal UB/UC designation.**

   **For Tim.** A schedule row supplied as 250UB25.7 is written as 250 UB 26. This changes the section designation, not just its spacing. A drafter can approve the decimal text in the preview and receive different text on the drawing.

   **Verified-by-reading.** ExcelMTextService.cs:486 reprocesses each non-title row at insertion. ProcessColumn2Text unconditionally calls NormalizeUcUbWholeNumbers at :5172. The regular expression at :6068 accepts decimal numbers on both sides of UB or UC; :6075 and :6076 pass both through ParseWholeNumber, which uses Math.Round(..., AwayFromZero) at :6090.

   The source-preview loader retains the source size at ExcelMTextSourcePreviewLoader.cs:473 and :483. NormalizePreviewSizeForWorkbench, ExcelMTextService.cs:5241, does not contain the whole-number UB/UC conversion. The Manual Editor's separate Normalize Selected action is not needed to trigger the insertion defect. Tim's 19 October CEMEMBER ruling also explicitly allows supplier names containing decimals; this is not a request to round a calculated result.

   **Exact failure scenario.** An included non-title B1 row contains 250UB25.7, with no learned size correction or custom member-map replacement for that complete designation. The built-in abbreviation matcher does not match the short 250UB token inside contiguous 250UB25.7 because the following digit is part of the token. The later mandatory whole-number conversion changes 25.7 to 26.

   **DETERMINISTIC TEST — fixture.** Disposable millimetre drawing and isolated test profile with no learned size corrections and the built-in member mappings. Synthetic CSV: one B1 / 250UB25.7 member row on Ground Floor. Use the Manual Editor's Size / Title cell to set that exact value if needed, press Tab to commit, then Done. Do not click Normalize Selected.

   **Click/typed steps.** Run XCLMTXT, load the fixture, confirm the preview still contains 25.7, select Ground Floor, click Insert Selected, confirm and pick (0,0). Double-click the B1 size MTEXT, or select it and read Contents in Properties.

   **Assertion.** The designation must still contain 25.7 after insertion, allowing spacing-only changes. The reviewed formatter predicts `250 UB 26`. Also compare the saved member-schedule Size with the visible MTEXT: XclmTxtService.cs:315 saves the preview SizeDisplay, so its lookup record can retain 25.7 while the drawing says 26. This mismatch is part of the same transformation fault.

4. **S14-04 — MEDIUM — Rotated-UCS schedule text and its frame use different directions.**

   **For Tim.** With the UCS turned 90 degrees, the schedule text turns with it but the live schedule frame stays square to World. The resulting text no longer sits in its frame; title/wipeout blocks can face the wrong way too.

   **Verified-by-reading.** ExcelMTextService.cs:3640 captures the current UCS. It transforms the insertion point at :3710 and inserts the frame at :3717. InsertBlock at :4975 creates a BlockReference with only Layer set, leaving its rotation and plane at their defaults. InsertBlockWithAttribute at :4993 does the same for auxiliary blocks.

   The MTEXT writer at :4897 and :4898 explicitly sets Normal=ucsZ and Direction=ucsX. Thus the text and block orientations differ by construction. XclmTxtService.cs:250 forces schedule blocks on and :252 leaves them live; this is the active XCLMTXT insertion path, not an unused helper.

   **Exact failure scenario.** World-Z UCS rotation of 90 degrees, valid MEMBER SCHEDULE definition available, ordinary Model-space insertion, no pre-rotated block definition. This deliberately avoids a tilted UCS or paper-space complication.

   **DETERMINISTIC TEST — fixture.** Synthetic millimetre drawing with the normal MEMBER SCHEDULE, WIPEOUT BLOCK and WIPEOUT definitions available. Use a Ground Floor schedule with a title and two included rows, B1 / 310UB32 and B2 / 200PFC. Use the same source once in a World-UCS control drawing and once in a copy.

   **Typed/click steps.** In the copy type UCS, World; UCS, Z, 90; PLAN, Current. Run XCLMTXT and Insert Selected at (0,0). Then UCS, World and PLAN, World so Properties values can be compared in World coordinates. Select the schedule frame and a size MTEXT; inspect their Rotation values and positions.

   **Assertion.** Frame and text must both follow the chosen placement UCS and the text must sit inside the intended columns. Current construction predicts the live frame at 0 degrees and the size MTEXT at 90 degrees. Record those Properties values and a screenshot. The World-UCS control must remain aligned; a missing frame asset is a failed fixture prerequisite, not a pass.

5. **S14-05 — MEDIUM — Refusing a rib without a slab leaves a changed or newly drawn centreline.**

   **For Tim.** Select an existing line for RIB where there is no slab. CE refuses the rib, but has already moved the original line onto SLAB INTERNAL BEAM. Choosing the two-point option instead leaves a new, unregistered line after the same refusal.

   **Verified-by-reading.** FoundationService.cs:1114 dispatches RIB with requiresRaftHost=true. ExecuteCreatePath calls TryGetOrCreatePathDriver at :1343 before it checks for a slab host at :1347. The selected-line branch upgrades the original object, changes its layer and commits at :3861 to :3865. The two-point branch appends and commits a new line at :3888 to :3892.

   Failure to find a slab prints hostReason and returns at :1349 to :1350. No rollback or removal follows. FoundationScheduleService.cs:226 closes the edit scope and disposes an Undo mark at :265; it is not a transaction that reverses the earlier committed line. The outer command wrapper likewise does not roll back an ordinary early return.

   **Exact failure scenario.** New millimetre Model-space drawing, no raft/slab perimeter, no infill host and no existing footing ownership on the selected ordinary line. The output layer is writable. This is not the already-reported protection against selecting another footing's outline.

   **DETERMINISTIC TEST — fixture.** Draw one ordinary line from (0,0) to (3000,0) on an unlocked layer named AUDIT-CENTRELINE. Record its handle and layer. Have no closed SLAB PERIMETER object and no registered infill. Use a fresh drawing without remembered IB1 width.

   **Typed steps.** RIB; enter 1 for the label, 300 for width, 0 for depth; select the line at (1500,0). After the refusal, select that same handle and inspect Layer in Properties. In a separate clean copy repeat RIB / 1 / 300 / 0, press Enter at the centreline selection prompt, then pick (0,0) and (3000,0).

   **Assertion.** The command line says `[FOUNDATION] No slab perimeter contains the selected point.` The first run must preserve AUDIT-CENTRELINE and the second must add no line if no rib was created. Current code predicts SLAB INTERNAL BEAM on the original line and one new unowned line in the second run. No foundation element is registered in either case. This report asks for a coherent unchanged-on-refusal outcome, not an additional hard block.

6. **S14-06 — MEDIUM — Xref copy/paste discards whether clipping is inverted or off.**

   **For Tim.** Copy an Xref whose clip hides the inside of a boundary, then paste it into another drawing. The paste recreates an ordinary clip, so it can show the opposite part of the reference. A clip switched off in the source can become active in the paste.

   **Verified-by-reading.** NativeCopyPasteXrefService.cs:18 defines clipboard data containing boundary points but no enabled or inverted flag. CopySelectedXref saves only those points at :100. CaptureXclipBoundaryWcs at :289 reads GetPoints, the clip transform and elevation; it never captures Definition.Enabled or SpatialFilter.Inverted.

   ApplyXclip at :359 runs XCLIP / New / Polygon using those points. There is no subsequent Off or Invert operation. These states are recognised elsewhere in the same slice: DrawingIntelligence/ArchitecturalOccurrenceAutoCadReader.cs:627 explicitly distinguishes disabled, inverted-enabled and normal-enabled clips. The copy path throws that distinction away.

   **Exact failure scenario.** A loaded planar Xref, scale 1, rotation 0, absolute source path and an explicit polygon clip with at least three vertices. Use different drawings for copy and paste so no pre-existing target clip can conceal the loss. The state omission is proven; the native visual outcome remains to be demonstrated with the test below.

   **DETERMINISTIC TEST — fixture.** A synthetic reference DWG containing one circle centred at (0,0), radius 100, and another at (3000,0), radius 100. Attach it at (0,0) in source host A using an absolute path. Use XCLIP / New boundary / Polygonal with corners (-500,-500), (500,-500), (500,500), (-500,500). Invert the clip so only the circle at (3000,0) is visible.

   **Typed steps.** CXREF, select that Xref. Open clean millimetre host B, type PXREF (the command uses the saved position). REGEN. Compare the two circle locations. Repeat from A after switching XCLIP Off, copying again and pasting into a separate clean host C.

   **Assertion.** B must show only the circle at (3000,0), matching the inverted source. C must show both circles, matching the disabled source. The reviewed replay instead requests a new ordinary polygon clip in both cases. Capture the final command line and the visible circle count/locations; if native XCLIP itself fails, record that separately rather than call clipping preservation successful. This finding does not assume anything about two-point rectangular boundaries.

---

1. **Reading ledger.** All 189 requested blobs were obtained with git show origin/claude/rel-20261022s2:<path>, in descending file-size order. The list below records that order and each Git blob's abbreviated identity. Paths are relative to Modules/Structural/Services/. Additional command, model, dialog and test-source reads were used only to establish callers, prerequisites and existing coverage; no tests were executed.

2. **Interpretation.** This was a fault hunt, not a certificate that the remaining files are fault-free. The counted findings have specific reachable code paths and observable assertions. Speculation about exact native Undo grouping, rectangular XCLIP point counts and other untraced possibilities is not counted as a finding.

1. **FoundationService.cs** — blob `732ebadd889d`; 297,338 bytes.
2. **ExcelMTextService.cs** — blob `01f77790baa7`; 261,449 bytes.
3. **XclmTxtService.cs** — blob `8fb427bf61e3`; 139,858 bytes.
4. **FoundationScheduleService.cs** — blob `f9ee0124b320`; 101,161 bytes.
5. **StructuralDetailService.cs** — blob `271245718e3c`; 98,558 bytes.
6. **XclmTxtCorpusPairingService.cs** — blob `052ad503e015`; 87,235 bytes.
7. **SettingsService.LoadRecovery.cs** — blob `324b41ce0fb5`; 81,194 bytes.
8. **ReoBarService.cs** — blob `809fc8d222ed`; 58,805 bytes.
9. **RibbonCommandHubService.cs** — blob `5ea23fcacc63`; 54,209 bytes.
10. **RuntimeDiagnosticsService.cs** — blob `a2699eb39a8c`; 53,166 bytes.
11. **NotesSymbolsPlacementService.cs** — blob `fb3d7210db88`; 52,070 bytes.
12. **NativeTimToolsService.cs** — blob `8dfeb37862f8`; 51,652 bytes.
13. **FoundationService.LoadPath.cs** — blob `c7f1dadafd9e`; 47,726 bytes.
14. **XclmTxtCorpusIndexService.cs** — blob `d8ad30f2852b`; 45,388 bytes.
15. **SettingsService.cs** — blob `2cfd90e9c22b`; 45,360 bytes.
16. **ScheduleService.cs** — blob `3e4a84ad6d25`; 42,719 bytes.
17. **MemberCatalogue/XlsxMemberCatalogueProvider.cs** — blob `d6ee700b6243`; 42,116 bytes.
18. **ExcelMTextSourcePreviewLoader.cs** — blob `1b4b6d93b8f6`; 38,651 bytes.
19. **FoundationInfillService.cs** — blob `ae7db09d573f`; 37,851 bytes.
20. **LayerService.cs** — blob `10fec3ffc820`; 37,096 bytes.
21. **DrawingIntelligence/ArchitecturalOccurrenceAutoCadReader.cs** — blob `64d6a88202e7`; 35,505 bytes.
22. **MarkupAIStandardsValidationService.cs** — blob `4e0f3f6a2dec`; 31,993 bytes.
23. **FoundationMonitor.cs** — blob `2b0146ea462a`; 31,168 bytes.
24. **ExportService.cs** — blob `8d158978cfb1`; 29,409 bytes.
25. **FoundationService.Grips.cs** — blob `4de7c85d0b5c`; 28,917 bytes.
26. **WallScheduleService.cs** — blob `763e1f779d81`; 28,723 bytes.
27. **MarkupAIStructuralExecutionService.cs** — blob `2ded7fb4d7a1`; 28,602 bytes.
28. **MarkupAICommandPlanner.cs** — blob `e70c825a28f3`; 28,122 bytes.
29. **FoundationService.LoadTrace.cs** — blob `df2606510229`; 27,957 bytes.
30. **FootingLegendService.cs** — blob `d9c20bc51576`; 27,454 bytes.
31. **SbeamAtomicPlacementWriter.cs** — blob `75bbff07282b`; 27,059 bytes.
32. **SbeamCompoundStore.cs** — blob `4f529926d4ce`; 26,430 bytes.
33. **FramingLegendService.cs** — blob `aeff02f8a981`; 26,232 bytes.
34. **MarkupAIWorkflowService.cs** — blob `d47743e2f073`; 25,411 bytes.
35. **TimberSubfloorService.cs** — blob `a15608fb8041`; 24,328 bytes.
36. **SbeamEditAutoCadEvidenceReader.cs** — blob `fa57fc5629fa`; 24,219 bytes.
37. **MLeaderCalloutService.cs** — blob `b36b63e04007`; 23,923 bytes.
38. **FoundationService.Marks.cs** — blob `e69e69b94875`; 23,062 bytes.
39. **LintelProposalService.cs** — blob `443ccb20dc51`; 21,836 bytes.
40. **ProjectDataService.cs** — blob `005c979c035d`; 21,755 bytes.
41. **RedoWindowGuard.cs** — blob `0f523c6181ee`; 21,570 bytes.
42. **SessionMerger.cs** — blob `b6ad26fae9ce`; 21,475 bytes.
43. **SupportErasedPlanner.cs** — blob `11de561aa5b7`; 21,360 bytes.
44. **JointDraftingService.cs** — blob `2d0c0eae0e9b`; 21,049 bytes.
45. **StructuralFrameGripOverrule.cs** — blob `e61373510fe9`; 19,841 bytes.
46. **NativeCopyPasteXrefService.cs** — blob `85b62ff9f9c8`; 19,746 bytes.
47. **LegacyToolCommon.cs** — blob `9d0f48473590`; 19,172 bytes.
48. **FoundationService.Identity.cs** — blob `fa517bacb6a2`; 19,012 bytes.
49. **UnitCopyService.cs** — blob `3f15d11eafe6`; 18,822 bytes.
50. **FoundationRegistryService.cs** — blob `c692148952fa`; 18,770 bytes.
51. **DrawingSafetyService.cs** — blob `ee0c126afb9d`; 18,560 bytes.
52. **FootingGripOverrule.cs** — blob `b344f16da08d`; 18,509 bytes.
53. **MarkupAIPyAutocadWorkerService.cs** — blob `e8a1ac855872`; 17,136 bytes.
54. **MarkupAIVisionParser.cs** — blob `ba64a9ca18ed`; 17,080 bytes.
55. **RedoWindowRegistry.cs** — blob `c041e417a06e`; 16,418 bytes.
56. **SbeamPickerSettingsCommitter.cs** — blob `dd0da440708d`; 16,358 bytes.
57. **SbeamAtomicEditWriter.cs** — blob `61197f1ecc96`; 16,214 bytes.
58. **NativeBoredPierService.cs** — blob `ef2cb85e0e76`; 16,037 bytes.
59. **PumpPitService.cs** — blob `559c7ef87235`; 15,055 bytes.
60. **ThemeManager.cs** — blob `bfd24d791fcb`; 14,981 bytes.
61. **FoundationScheduleBuilder.cs** — blob `0afddd942cda`; 14,849 bytes.
62. **FoundationService.Proposal.cs** — blob `8d9cc7254ee5`; 14,776 bytes.
63. **LegacyEnvironmentAuditService.cs** — blob `6a4802c79862`; 14,625 bytes.
64. **FoundationElementFollow.cs** — blob `bfaca6d71fdd`; 14,568 bytes.
65. **VersionInfoService.cs** — blob `cef492f5d5fc`; 14,520 bytes.
66. **StructuralIdleWorkPlanner.cs** — blob `4300fe5cdcc3`; 14,517 bytes.
67. **LevelCarryDrawService.cs** — blob `37e5a65871cd`; 14,460 bytes.
68. **MemberCatalogue/MemberCatalogueInspectorPresenter.cs** — blob `c91009cc4fb1`; 14,236 bytes.
69. **NotesImportService.cs** — blob `01d195beaff6`; 14,135 bytes.
70. **DrawingIntelligence/ArchitecturalOccurrenceAutoCadReaderContract.cs** — blob `9b8106fbb3b1`; 14,098 bytes.
71. **MarkupAIChatService.cs** — blob `978ca767c126`; 14,085 bytes.
72. **StandardsService.cs** — blob `e92ca2833c3e`; 13,929 bytes.
73. **SectionDatabaseService.cs** — blob `15e909b60d7e`; 13,903 bytes.
74. **DwgStorage.cs** — blob `0f8cef037d8e`; 13,698 bytes.
75. **DrawingIntelligence/ArchitecturalObjectArxCurrentFactJoin.cs** — blob `814f2e51e8d0`; 13,567 bytes.
76. **PlanLevelService.cs** — blob `c423664b03eb`; 13,487 bytes.
77. **RibbonFrontDoorService.cs** — blob `666f84365ae7`; 13,226 bytes.
78. **LintelTableService.cs** — blob `53f996aa16c3`; 13,189 bytes.
79. **PointLoadMarkerService.cs** — blob `902bb3deb085`; 12,439 bytes.
80. **StatusBarIndicatorService.cs** — blob `783a6a6031d8`; 12,385 bytes.
81. **MarkupAIBluebeamParser.cs** — blob `e84c7af882c3`; 12,281 bytes.
82. **SessionResumeCache.cs** — blob `aa8a5d00b12c`; 12,166 bytes.
83. **FoundationStumpFootingService.cs** — blob `40f50d37e095`; 12,000 bytes.
84. **SbeamPickerPreferenceStore.cs** — blob `43ff473aebd6`; 11,977 bytes.
85. **InstallMetadataService.cs** — blob `7bbd5b47093e`; 11,877 bytes.
86. **TimeEntryFileService.cs** — blob `1bb379467656`; 11,790 bytes.
87. **FstMemoryService.cs** — blob `afc9a8d5d73e`; 11,781 bytes.
88. **XclmTxtPdfTextExtractionService.cs** — blob `ba82e901c487`; 11,339 bytes.
89. **PerfTimingService.cs** — blob `2c2ce70f7401`; 11,261 bytes.
90. **MarkupAIStorageService.cs** — blob `2a4d098aaa64`; 11,193 bytes.
91. **LinkMigrationService.cs** — blob `510556efe857`; 11,154 bytes.
92. **FoundationScrewPileService.cs** — blob `c1a54448d1f5`; 10,998 bytes.
93. **GeotechReportReader.cs** — blob `1b0beb59238c`; 10,990 bytes.
94. **NativeXrefLayerService.cs** — blob `df17b0fcceba`; 10,908 bytes.
95. **MarkupAIExecutionService.cs** — blob `167804721760`; 10,862 bytes.
96. **S3NotesSymbolsSettings.cs** — blob `373c67e44808`; 10,794 bytes.
97. **RoofSetoutCommandService.cs** — blob `c868a85a34dc`; 10,735 bytes.
98. **MarkupAINativeExecutionService.cs** — blob `97110a5eef4e`; 10,664 bytes.
99. **DrawingIntelligence/StructuralIntelligenceGate2ReadOnlyHarness.cs** — blob `58423dfd0549`; 10,593 bytes.
100. **FloorSetoutCommandService.cs** — blob `425c5fc096cf`; 10,482 bytes.
101. **LevelCarryOtherDrawingReader.cs** — blob `c9cd7fcb7393`; 10,281 bytes.
102. **MarkupDrawingPlacementService.cs** — blob `56b2b1e0befc`; 10,265 bytes.
103. **LevelCarryCommandService.cs** — blob `5cafe99b1c6f`; 10,213 bytes.
104. **DrawingIntelligence/ArchitecturalObjectArxXclipReader.cs** — blob `d3059e8d36f0`; 10,146 bytes.
105. **MarkupAIDrawingStandardsExportService.cs** — blob `f57102054997`; 9,999 bytes.
106. **RoofSetoutDrawService.cs** — blob `95eb635df210`; 9,957 bytes.
107. **SettingsManager.cs** — blob `6c513e6701d2`; 9,895 bytes.
108. **DrawingIntelligence/ArchitecturalObjectArxOccurrenceReader.cs** — blob `7bdd1353a438`; 9,870 bytes.
109. **MemberScheduleService.cs** — blob `9c3d6f51ac7b`; 9,837 bytes.
110. **StructuralPiiHash.cs** — blob `e764243df916`; 9,372 bytes.
111. **PlanLevelWriter.cs** — blob `32c75f963524`; 9,278 bytes.
112. **TieDownService.cs** — blob `110f2383480b`; 9,154 bytes.
113. **MemberCatalogue/XlsxMemberCatalogueSourceDiscovery.cs** — blob `e8947bceecf2`; 9,036 bytes.
114. **MarkupAIOrchestratorService.cs** — blob `62b2fd72696d`; 8,627 bytes.
115. **FootingPlanTextBuilder.cs** — blob `1cffaf2e0b59`; 8,514 bytes.
116. **LoggingService.cs** — blob `154f7c7ca0f0`; 7,730 bytes.
117. **XclmTxtLearningService.cs** — blob `9da69452f444`; 7,685 bytes.
118. **SettingsUnknownMembers.cs** — blob `b9fee5d31b6a`; 7,613 bytes.
119. **ReinforcementService.cs** — blob `8ac2f2e5aa8d`; 7,585 bytes.
120. **PointLoadCommandService.cs** — blob `7d2d11cee56b`; 7,470 bytes.
121. **DrawingIntelligence/ArchitecturalChangeReviewRequestProducer.cs** — blob `aaf43de51653`; 7,409 bytes.
122. **HealthCheckService.cs** — blob `884142321f43`; 7,080 bytes.
123. **IdleDetector.cs** — blob `01d5d31473fc`; 6,844 bytes.
124. **MemberScheduleReaderService.cs** — blob `5220fee7074f`; 6,785 bytes.
125. **UnitDrawingSettingsService.cs** — blob `2a2c6dd37788`; 6,617 bytes.
126. **WorkspaceMenuInstallerService.cs** — blob `bf173a7b33bf`; 6,552 bytes.
127. **NativeTransformToolsService.cs** — blob `5580740cf908`; 6,489 bytes.
128. **ReoBarMonitor.cs** — blob `790cb0bebe59`; 6,426 bytes.
129. **StructuralInspectorContributor.cs** — blob `bb0dab194e69`; 6,190 bytes.
130. **SbeamPickerController.cs** — blob `ac93c1f2a80d`; 6,040 bytes.
131. **LineStyleCatalog.cs** — blob `be98625ce2d6`; 5,959 bytes.
132. **DrawingIntelligence/ArchitecturalObjectArxXrefDefinitionReader.cs** — blob `af001d17d305`; 5,833 bytes.
133. **StructuralTelemetryWriteQueue.cs** — blob `a0f12a22b16e`; 5,808 bytes.
134. **NotesExportService.cs** — blob `e76cd8a84ec0`; 5,746 bytes.
135. **ExcelWorkbookReader.cs** — blob `f49610e205f7`; 5,649 bytes.
136. **DrawingIntelligence/ArchitecturalObjectArxOccurrenceContract.cs** — blob `2f3f00d16c9e`; 5,639 bytes.
137. **StructuralGripEditQueue.cs** — blob `e818d60029a0`; 5,334 bytes.
138. **NotesSymbolsMetrics.cs** — blob `001604b27d72`; 5,187 bytes.
139. **StripLayerMergeRules.cs** — blob `817f442c2df1`; 5,060 bytes.
140. **PlanLevelCommandService.cs** — blob `a17f18cafe53`; 5,003 bytes.
141. **FoundationRedrawSnapshot.cs** — blob `2df4291b7386`; 4,965 bytes.
142. **DrawingIntelligence/ArchitecturalChangeReviewNativeBridge.cs** — blob `fe0c41ed6d83`; 4,947 bytes.
143. **DrawingIntelligence/ArchitecturalChangeReviewReceiptInbox.cs** — blob `d833c3b5e8df`; 4,940 bytes.
144. **SupportBlockJig.cs** — blob `96905fc744ae`; 4,849 bytes.
145. **SectionMarkRegistry.cs** — blob `934f48b45008`; 4,756 bytes.
146. **DrawingIntelligence/ArchitecturalObjectArxCurrentReviewReader.cs** — blob `6c55c92e7227`; 4,740 bytes.
147. **XDataSchemaService.cs** — blob `432f61253a82`; 4,672 bytes.
148. **Logger.cs** — blob `22ffef2fa207`; 4,645 bytes.
149. **DrawingIntelligence/ArchitecturalObjectArxXclipContract.cs** — blob `a1395f19036e`; 4,570 bytes.
150. **FoundationRegistryMemory.cs** — blob `963ee471b2be`; 4,398 bytes.
151. **SbeamEditReadDiagnostics.cs** — blob `1ac964ce129f`; 4,352 bytes.
152. **RecoverySnapshotService.cs** — blob `2672a19227b2`; 4,212 bytes.
153. **MarkupPdfPageRenderService.cs** — blob `edea7b915db3`; 4,138 bytes.
154. **WeldMarkGeometry.cs** — blob `dd397b1d0d2c`; 4,123 bytes.
155. **LevelCarryDrawingStore.cs** — blob `8b013c449358`; 4,060 bytes.
156. **XclmTxtTrendClassifier.cs** — blob `455868a81e49`; 3,945 bytes.
157. **MemberScheduleCommandService.cs** — blob `04ebdfb0a09d`; 3,918 bytes.
158. **LispLoader.cs** — blob `abfada90e768`; 3,897 bytes.
159. **SbeamPickerExceptionPolicy.cs** — blob `bc0954236d5f`; 3,846 bytes.
160. **StructuralComputationOptions.cs** — blob `bad21ee558ea`; 3,772 bytes.
161. **RebarService.cs** — blob `76b9b79d9f63`; 3,684 bytes.
162. **MemberCatalogue/XlsxMemberCatalogueModels.cs** — blob `3851adbb8a4b`; 3,450 bytes.
163. **JobFileSaveNotice.cs** — blob `1e70a372098f`; 3,414 bytes.
164. **DynamicPropertyReadback.cs** — blob `b397eee3f092`; 3,361 bytes.
165. **FoundationDiagnostics.cs** — blob `2d5afd82b0e2`; 3,193 bytes.
166. **StructuralAppDataPaths.cs** — blob `354a4ceb9de0`; 3,135 bytes.
167. **StructuralCommandLogger.cs** — blob `e278824c50ac`; 3,122 bytes.
168. **ToolbarLayoutService.cs** — blob `3d7e51ec69be`; 3,074 bytes.
169. **DrawingIntelligence/ArchitecturalObjectArxXrefDefinitionContract.cs** — blob `2fc2e02c5a8f`; 3,033 bytes.
170. **TimberGradeCatalogueService.cs** — blob `3df09a12724a`; 2,946 bytes.
171. **LogFolderRedirect.cs** — blob `86f68c36aca1`; 2,914 bytes.
172. **RuntimePathService.cs** — blob `0bb9655a915c`; 2,907 bytes.
173. **SettingsStartUpChange.cs** — blob `bfd7fae1374a`; 2,905 bytes.
174. **UnitTagPrefixService.cs** — blob `6d80ac21374d`; 2,760 bytes.
175. **MarkupAIOffPcPolicy.cs** — blob `579cda9c9906`; 2,724 bytes.
176. **LinkService.cs** — blob `01047c827dc4`; 2,632 bytes.
177. **MarkupAILearningService.cs** — blob `ff12d81eb74d`; 2,450 bytes.
178. **QuietBlockRead.cs** — blob `504477ce5609`; 2,432 bytes.
179. **MemberCatalogue/MemberCatalogueAsyncRequestGate.cs** — blob `334eef275b67`; 2,316 bytes.
180. **GroupSelectionService.cs** — blob `98933cd0bdc6`; 2,297 bytes.
181. **SettingRestore.cs** — blob `2ace5973066e`; 1,982 bytes.
182. **UnitToolsSwitchService.cs** — blob `0c66cee846f3`; 1,981 bytes.
183. **LoadPathUnlinkedPosts.cs** — blob `1fbc84108413`; 1,858 bytes.
184. **SbeamMemberNoteSelector.cs** — blob `2124944b5de2`; 1,544 bytes.
185. **MarkupAIRuntimeState.cs** — blob `08de7ce0cc48`; 1,248 bytes.
186. **LabelTextHeight.cs** — blob `c15eb239c952`; 1,206 bytes.
187. **DrawingIntelligence/ArchitecturalChangeReviewGateBRequestLoader.cs** — blob `134c807be6eb`; 1,036 bytes.
188. **DrawingScaleSetting.cs** — blob `bc659e731c86`; 973 bytes.
189. **MemberCatalogue/IMemberCatalogueProvider.cs** — blob `e9c4ed04a7ff`; 326 bytes.

---

1. **Summary.** Six findings: three HIGH and three MEDIUM. Prioritise drawing-specific Markup Undo, exclusion-safe schedule lookup and preservation of decimal section designations. Also align schedule blocks with their text, prevent partial centreline changes on refusal and preserve Xref clip state. All findings are verified by reading the pinned source; native behaviour awaits the specified tests. No plugin was changed or claimed fixed. Only this report is to be saved in CE_PLAN.
