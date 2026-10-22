1. **ANSWER FIRST — HIGH: 0; MEDIUM: 2; LOW: 1.** Three new findings, all verified-by-reading. No suspected finding is included in the counts. Native AutoCAD reproduction remains untested.

2. **Most important — a moved roof can leave a nearby pit out of the warning list.** Compare background only measures proximity to the roof's new position. A pit beside the old roof edge can need attention and receive no warning.

3. **Other effects.** Checks can zoom out to 2 km in a metre drawing when Settings says 2 m. The full-detail Inspector's Back button can put drawing A's view into drawing B.

4. **Scope and limits.** Independent S01 review dated 23 October 2026, Melbourne. All 112 requested files were read. No plugin changes, builds, tests, AutoCAD sessions, installations or sub-agents were used. The native tests below are instructions for a later authorised test run, not claimed results.

---

1. **Technical basis.** Source: C:\Lisp Files\CE_ACAD_PLUGIN, origin/claude/rel-20261022m, commit 40ee0a36f7960145743954b39859eb6c3af92869, the brief's Civil 3.0.70 / Manager 1.1.70 reference. Source was read with git show/git grep; no working-tree source was used as evidence. Structural is outside this sweep.

2. **Earlier findings excluded.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md and CODEX_AUDIT_CIVIL_22OCT.md, CODEX_AUDIT_GATE_22OCT.md and CODEX_AUDIT_STRUCTURAL_22OCT.md. This report does not repeat their cancellation logging, early drawing writes, ignore-record, tidy-label, missing progress, DP editing or Structural findings.

3. **Rulings applied.** These are correction requests, not proposals for extra hard blocks. R-27 remains unchanged. The existing Settings value remains the authority for Show where's minimum view under R-00. No Manager administrator work is proposed.

1. **S01-01 — MEDIUM — moved background geometry loses its old affected area. VERIFIED-BY-READING.**

   **For Tim:** After a roof moves, Compare background can name a pit beside the new roof but omit a pit beside the old roof. The old roof position also matters when checking the drainage design.

   **Source:** Modules/Drainage/Services/BackgroundXrefGeometryDiffService.cs:104 removes the matched old polygon; :109 records only the new polygon's bounding box. The same old-footprint loss occurs for a moved boundary at :74. Modules/Drainage/Services/BackgroundXrefAffectedObjectsService.cs:18 sets a 3000 mm buffer; :35-49 includes only candidates inside the supplied buffered boxes.

   **Reachable command:** Modules/Drainage/Commands/BackgroundXrefCompareCommand.cs:84 passes the diff into :102-109 to print nearby CE objects. :135-144 supplies recorded pit positions. The command saves the new snapshot at :113, so the omitted former position is also gone from the next comparison.

   **Exact failure scenario:** One roof moves 4500 mm east, within the 5000 mm matching radius. P1 was 500 mm west of the old roof edge; it is now 5000 mm west of the new edge. P1 is outside the only retained 3000 mm buffer, so it is omitted. This is not an unknown-units or Xref-transformation case.

   **DETERMINISTIC TEST — fixture:** Use synthetic, saved host and background DWGs, both INSUNITS=4, World UCS, model space. Attach the background at 0,0, scale 1, rotation 0. Background contains a closed TITLE BOUNDARY rectangle from -5000,-5000 to 15000,15000 and one closed ROOF rectangle from 0,0 to 10000,10000. Host contains registered CE pits P1 at -500,5000 and P2 at 15000,5000. Use a fresh host/Xref name with no existing comparison snapshot.

   **DETERMINISTIC TEST — actions:** In the host type CDXREFCOMPARE once to establish the baseline. Open the background; type _.MOVE, select only the ROOF rectangle, Enter, 0,0, 4500,0; save and return to the host. Reload that Xref. Type CDXREFCOMPARE again.

   **DETERMINISTIC TEST — assertion:** The command line must report Roof moved and include both P1 and P2 among nearby CE objects: each is 0.5 m from an affected old or new roof footprint. Current source predicts Roof moved and P2, but no P1. P2 is a positive control proving pit lookup and reporting worked. No geometry is expected to change in the host.

   **Correction boundary:** Retain the affected extents of both old and new geometry for matched moves. Keep the configured comparison policy; do not add a drafting block.

2. **S01-02 — MEDIUM — Show where treats millimetres as drawing units. VERIFIED-BY-READING.**

   **For Tim:** In a drawing measured in metres, Show where can zoom so far out that the selected pit becomes almost invisible. The default closest view is labelled 2000 mm, but the code applies 2000 metres.

   **Source:** Modules/Drainage/Services/ChecksListPaletteService.cs:251-252 builds boxes straight from entity extents in drawing units. :215 passes the Settings object without unit conversion. Modules/Drainage/Services/Checks/ShowWhere.cs:74 reads ShowWhereMinViewMm; :116-120 uses that millimetre number as the minimum width. Modules/Drainage/Services/Checks/AutoCadShowWhereSurface.cs:58-59 assigns it straight to AutoCAD view width/height.

   **Settings evidence:** Modules/Drainage/Models/UserSettings.cs:2798 defaults ShowWhereMinViewMm to 2000. Modules/Drainage/Dialogs/CivilSettingsView.xaml:313 explicitly labels the value as millimetres across the screen. There is no INSUNITS conversion anywhere in the above path.

   **Exact failure scenario:** A valid metre drawing contains a 0.6 m square registered pit. Its individual Checks row is selected. On an ordinary landscape viewport the size-derived width is only a few metres; the minimum then raises it to 2000 drawing units, which means 2 km. Millimetre drawings hide this error.

   **DETERMINISTIC TEST — fixture:** Synthetic saved drawing, INSUNITS=6, World UCS, plan view, model space and one viewport. A registered CE pit P1 has actual block extents 0.6 m by 0.6 m. Give it an isolated wrong-layer finding by moving just its block to an ordinary unlocked test layer, with wrong-layer checks enabled. Enable the Checks list and set closest Show where view to 2000 mm in Settings. Use a landscape drawing viewport with width/height ratio between 1 and 3.

   **DETERMINISTIC TEST — actions:** Type CDCHECKS. Select P1's wrong-layer row, which targets only P1, and click Show where. Return focus to the command line and evaluate (getvar "VIEWSIZE").

   **DETERMINISTIC TEST — assertion:** For that small object, view height must remain below 5 drawing units (5 m), with the 2 m physical minimum applied correctly. Current source predicts a height between about 667 and 2000 drawing units, depending on viewport aspect ratio. Repeat on an equivalent millimetre fixture to confirm that the physical view widths agree after conversion. Do not use a two-object row, whose combined extents would change the expected view.

   **Correction boundary:** Convert the Settings minimum from millimetres to current drawing units, or consistently convert all geometry and view dimensions at the adapter boundary. Preserve the user's Settings value.

3. **S01-03 — LOW — Back restores a view from another drawing. VERIFIED-BY-READING.**

   **For Tim:** Find a pit in drawing A, switch to drawing B, then press Back in the full-detail Inspector. Drawing B can jump to A's position and magnification. This changes the view, not the drawing objects.

   **Source:** Modules/Drainage/Services/CeZoomHighlightService.cs:39 stores one static previous view. :41-48 records no drawing or viewport identity. :142 reads whichever document is active; :149-157 applies the saved view there. The saved view is cleared only after Back (:167) or plugin shutdown (:331), not on document activation.

   **Reachable controls:** Modules/Drainage/Commands/CeFindCommand.cs:87 calls ZoomAndHighlight for a pit with autoFade=false. Modules/Drainage/Services/InspectorPaletteService.cs:268 binds the Inspector's GoBackCommand directly to the service. Modules/Drainage/Controls/InspectorPanelControl.xaml:340 wires its full-detail Connections tab's Back button. The activation handler at InspectorPaletteService.cs:439-479 invalidates selection but does not clear the saved view.

   **Exact failure scenario:** The saved view belongs to A; B becomes active without another CE zoom. Back has no document check and restores A's centre, target, direction, twist and dimensions into B. Even if highlights are cleared, that does not clear the saved view.

   **DETERMINISTIC TEST — fixture:** Open synthetic millimetre model-space drawings A and B in one AutoCAD session, World UCS and plan view. A contains a registered pit P1; B contains a registered pit P2 at 0,0. Give A a view centred at 100000,100000 with height 10000; give B a view centred at 0,0 with height 2000. No other CE zoom should intervene.

   **DETERMINISTIC TEST — actions:** In A type _.ZOOM, _C, 100000,100000, 10000; then CEFIND and P1. Switch to B by its drawing tab. Type _.ZOOM, _C, 0,0, 2000. Open CDINSPECTOR if it is hidden. Single-click P2 and wait for its details to appear. Click Show full detail if that switch is present; choose Selected object > Connections and click Back. Do not click a connection row first.

   **DETERMINISTIC TEST — assertion:** B must retain its centre at 0,0 and view height 2000 because B has no saved CE navigation view. Read (getvar "VIEWCTR") and (getvar "VIEWSIZE"). Current source predicts A's centre near 100000,100000 and height 10000 in B. Use the Inspector control specified here; the Project Review window has separate bindings and is not the route used to prove this finding.

   **Correction boundary:** Bind saved views to their document and viewport, and refuse or discard a restore into a different context.

1. **Coverage record.** Read all 112 requested files, comprising 25,071 source lines in the pinned-ref inventory. Largest files were read first, followed by the remaining services and their callers. The entries below record reading coverage, not a claim that every unreported path is fault-free. Paths are relative to Modules/Drainage/Services/.

1. **Read:** BlockService.cs (2735 lines).
2. **Read:** CivilHelpHost.cs (965 lines).
3. **Read:** AutoDesignService.cs (763 lines).
4. **Read:** CivilProjectQaAutomaticService.cs (727 lines).
5. **Read:** ArrowService.cs (635 lines).
6. **Read:** AutoCadContinuationPairLockedSession.cs (634 lines).
7. **Read:** CalculationExportPackage.cs (587 lines).
8. **Read:** AdminTelemetryService.cs (539 lines).
9. **Read:** AutoCadContinuationPairPlacementStore.cs (502 lines).
10. **Read:** CdImportCompareSnapshotService.cs (468 lines).
11. **Read:** CivilProjectQaContributor.cs (450 lines).
12. **Read:** CivilOwnershipHighlightService.cs (444 lines).
13. **Read:** CeCvlRibbonContributor.cs (428 lines).
14. **Read:** Checks/ChecksResult.cs (395 lines).
15. **Read:** CivilDrawingRepairContributor.cs (363 lines).
16. **Read:** CivilNetworkSelectContextMenuService.cs (360 lines).
17. **Read:** AutoDesignOrchestrator.cs (345 lines).
18. **Read:** CivilNetworkHealthService.cs (344 lines).
19. **Read:** CloneOwnedSpineIdentityPolicy.cs (339 lines).
20. **Read:** CeBatchEditApplyCoordinator.cs (337 lines).
21. **Read:** CeZoomHighlightService.cs (334 lines).
22. **Read:** CeBellStatusBarService.cs (317 lines).
23. **Read:** Checks/Slowdown.cs (309 lines).
24. **Read:** CdDrawFirstFlowService.cs (285 lines).
25. **Read:** AutoCadContinuationPairLockedSession.Helpers.cs (281 lines).
26. **Read:** Checks/IgnoredChecks.cs (277 lines).
27. **Read:** CivilSelectionObserver.cs (274 lines).
28. **Read:** CompoundBoundsOverrule.cs (273 lines).
29. **Read:** ChecksListPaletteService.cs (266 lines).
30. **Read:** CivilHubService.cs (257 lines).
31. **Read:** Checks/PipeEndOffPit.cs (248 lines).
32. **Read:** CivilDesignService.cs (242 lines).
33. **Read:** CalculationWorkspacePersistenceService.cs (241 lines).
34. **Read:** CdHelpService.cs (239 lines).
35. **Read:** CeWindowPlacementHook.cs (229 lines).
36. **Read:** Checks/ShowWhere.cs (228 lines).
37. **Read:** CalculationWorkspaceDraftBounds.cs (221 lines).
38. **Read:** AutoCadContinuationPairLockedSession.Finalisation.cs (221 lines).
39. **Read:** CdDrawFirstLpdAuthorityService.cs (208 lines).
40. **Read:** ArchetypeClassifier.cs (205 lines).
41. **Read:** CivilJobTimeSettings.cs (204 lines).
42. **Read:** Checks/ChecksResultReader.cs (198 lines).
43. **Read:** CommandOutcomeLogService.cs (194 lines).
44. **Read:** CeInspectorHostPageCoordinator.cs (190 lines).
45. **Read:** CeAiSeatGrantService.cs (184 lines).
46. **Read:** CivilLinkedFieldImpactService.cs (182 lines).
47. **Read:** CivilJobTimeService.cs (182 lines).
48. **Read:** CeCvlClassicRibbonLayout.cs (179 lines).
49. **Read:** BrokenXrefPathRepairService.cs (178 lines).
50. **Read:** BackgroundXrefGeometryDiffService.cs (176 lines).
51. **Read:** CeAssistantPaletteService.cs (176 lines).
52. **Read:** BackgroundDownpipeSymbolReader.cs (175 lines).
53. **Read:** CeAiOffPcGate.cs (174 lines).
54. **Read:** CivilBackgroundXrefNoticeService.cs (167 lines).
55. **Read:** CivilSelectionClassifier.cs (163 lines).
56. **Read:** Checks/ChecksListModel.cs (163 lines).
57. **Read:** CloneCleanupMessages.cs (162 lines).
58. **Read:** CivilProjectQaRegistrationService.cs (161 lines).
59. **Read:** AnnotationMoveService.cs (161 lines).
60. **Read:** CivilHubNavigationService.cs (158 lines).
61. **Read:** AtomicDrawingChangeRunner.cs (156 lines).
62. **Read:** CdCalcPrefillService.cs (154 lines).
63. **Read:** CommandAliasService.cs (150 lines).
64. **Read:** BoundedJsonReadService.cs (141 lines).
65. **Read:** CeChipVocabulary.cs (134 lines).
66. **Read:** CeMessageService.cs (132 lines).
67. **Read:** CompoundBoundsService.cs (129 lines).
68. **Read:** CommandRegistryService.cs (124 lines).
69. **Read:** CivilQuietMode.cs (114 lines).
70. **Read:** CeThemeResolver.cs (114 lines).
71. **Read:** CatalogueService.cs (114 lines).
72. **Read:** CloneBatchTimings.cs (112 lines).
73. **Read:** CivilAiDrawingFactsContext.cs (109 lines).
74. **Read:** CivilProjectStartDraftStorage.cs (104 lines).
75. **Read:** CeWindowTitle.cs (102 lines).
76. **Read:** CivilDrawingRepairRegistrationService.cs (101 lines).
77. **Read:** CivilNetworkHealthDashboardAdapterService.cs (101 lines).
78. **Read:** CalculationPageStamp.cs (96 lines).
79. **Read:** AcadPgpAliasReader.cs (89 lines).
80. **Read:** Checks/ChecksListRouting.cs (85 lines).
81. **Read:** BackgroundXrefCompareCoordinator.cs (85 lines).
82. **Read:** BatchSharedWork.cs (85 lines).
83. **Read:** CivilHelpNavigationHost.cs (85 lines).
84. **Read:** Checks/AutoCadShowWhereSurface.cs (80 lines).
85. **Read:** BackgroundXrefAffectedObjectsService.cs (76 lines).
86. **Read:** Checks/IgnoreFindingPicker.cs (70 lines).
87. **Read:** CivilBackgroundXrefReader.cs (70 lines).
88. **Read:** CeSharedCopyCheck.cs (70 lines).
89. **Read:** CeAiEgressAuditService.cs (68 lines).
90. **Read:** Checks/PitLayerFactReader.cs (67 lines).
91. **Read:** CeAiEndpointResolver.cs (65 lines).
92. **Read:** CeAutoCadThemeReader.cs (65 lines).
93. **Read:** BackgroundXrefSnapshotCacheService.cs (58 lines).
94. **Read:** CeGeometryCleanupService.cs (58 lines).
95. **Read:** CeAiProposalApplyCoordinator.cs (55 lines).
96. **Read:** CeWindowTitleHook.cs (52 lines).
97. **Read:** BlockGhostFollower.cs (52 lines).
98. **Read:** CdDrawFirstEndpointCandidateService.cs (49 lines).
99. **Read:** BackgroundXrefBaselineService.cs (47 lines).
100. **Read:** CommandLineText.cs (46 lines).
101. **Read:** CivilNames.cs (45 lines).
102. **Read:** CommandErrorText.cs (40 lines).
103. **Read:** CalculationDraftCloseGuard.cs (37 lines).
104. **Read:** CivilHelpGuideSource.cs (36 lines).
105. **Read:** CatchmentOverlayStyle.cs (36 lines).
106. **Read:** Checks/ChecksPaletteFeed.cs (32 lines).
107. **Read:** CompoundBehaviorDefaults.cs (31 lines).
108. **Read:** CascadeRelinkScope.cs (27 lines).
109. **Read:** CdDrawFirstHostGate.cs (26 lines).
110. **Read:** CommandIconService.cs (20 lines).
111. **Read:** CeAiMasterSwitch.cs (18 lines).
112. **Read:** CloneLinkHandles.cs (17 lines).

1. **Summary.** Three new findings: zero HIGH, two MEDIUM and one LOW. Prioritise retaining the old affected footprint when background geometry moves, then correct Show where's metre conversion and isolate Back views by drawing. All 112 files were read at the requested Civil release. Evidence is source-based; the native reproduction tests remain unrun. No plugin code was changed and no defect is marked fixed.
