1. **ANSWER FIRST — HIGH: 2; MEDIUM: 0; LOW: 0.** Both findings are verified by reading the installed release's code, including the AutoCAD callers. Neither has been reproduced in AutoCAD during this hunt. Suspected findings counted: 0.

2. **Most important finding — one Xref can silently stand in for another.** When two attached drawings share an internal drawing ID but contain different pit information, the reader gives both the first drawing's information. The intended warning never sees the difference. A drafter can therefore select what appears to be a valid source while the second drawing's pits or changed levels are absent.

3. **The other finding — Refresh can make a correct schedule wrong.** A twin 375 mm pipe shown as `2/375` can become `375`. The same refresh also replaces a trench grate's length with ordinary pit dimensions. The window and the placed schedule use different rules.

4. **Scope and limits.** Civil Services slice 5 of 6, reviewed 23 October 2026, Melbourne date. All 112 requested files were read, largest and central files first. No code changes, builds, tests, AutoCAD sessions, installations or sub-agents. The following tests are instructions for a later authorised AutoCAD session; no fixture was created here.

---

1. **S05-01 — HIGH — VERIFIED-BY-READING: the Xref reader defeats the different-data check for copied drawings.**

   **Location:** `Modules/Drainage/Services/PitScheduleXrefDiscoveryService.cs:394` (early cache return), `:403` (actual record read bypassed), `:413` (cache populated by drawing ID). Related check: `Modules/Drainage/Services/PitScheduleXrefDiscoveryCore.cs:63`.

   **What happens in AutoCAD:** Two distinct loaded Xrefs with a shared internal ID are displayed as one usable source, even when their pits differ. Information from whichever drawing is visited first is reused for both. The drafter does not receive the intended message explaining the conflicting copy.

   **Exact failure scenario:** A host attaches two physical DWGs derived from a copied drawing. Their non-empty AutoCAD `Database.FingerprintGuid` values match, but their saved CE project records differ in a pit level or pit membership. Both are loaded, readable and on a supported schema. `PitScheduleXrefSeparatesSaveAsCopies` is true, including its default when the setting is absent.

   **Proof:** `BuildProbe` at `PitScheduleXrefDiscoveryService.cs:191` obtains each node's actual database and drawing identity, then calls the shared read context at `:200`. `ReadProjectRecord` returns an existing snapshot by drawing identity at `:394` before checking database identity or reading the second database. The second probe consequently contains the first probe's JSON. The core deserialises that substituted JSON at `PitScheduleXrefDiscoveryCore.cs:174` and fingerprints it at `:194`. Its same-ID/different-data branch at `:63` cannot distinguish the pair; the ordinary branch at `:108` merely adds another attachment chain to the first source. The intended separate, unavailable entry and warning at `:72` through `:79` are bypassed. This is not merely an isolated helper: `ViewModels/PitScheduleViewModel.Data.cs:85` calls this discovery service and `:100` populates the visible source options from its result.

   **DETERMINISTIC TEST — NOT RUN:** Use synthetic `S05_A.dwg`, `S05_B.dwg` and an otherwise empty `S05_Host.dwg`. A has a valid saved CE pit A1 at cover RL 20.00 m. B is a file copy subsequently edited and saved with that cover at RL 21.00 m and an additional valid pit B2. Fixture preparation must verify that A and B have equal, non-empty `Database.FingerprintGuid` values and genuinely different saved CE project JSON; do not assume every Save As operation preserves the fingerprint. Give all entities valid CE identities and use the same supported project schema.

   **Typed steps:** Open the host. Type `_XATTACH` and attach A, then repeat for B, at separate positions. Ensure both are loaded. Type `PITSCHEDULE`, open **Source**, select **Drainage XREFs**, then click **Refresh**. Inspect both the source options and their status text/tooltips. Select the offered source and inspect **Rows**. Repeat in a fresh host with the attachment order reversed.

   **Assertion:** There must be two distinguishable entries for the differing records: the conflicting entry is unavailable with status text containing `same internal drawing ID` and `different pit data`, and the offered entry carries the corresponding note, as the core already specifies. At this ref, reading predicts one grouped source without that conflict message, with only the first visited record's rows/levels. The result must not silently depend on attachment traversal order. This asks for the existing diagnostic and source distinction; it does not propose a new command-wide hard block.

   **Repair boundary:** Cache raw records by actual database identity while comparing their contents. Group equal drawing IDs only after reading and fingerprinting each distinct database. Cover the discovery adapter as well as the pure core: probes supplied directly with different JSON do not exercise the faulty cache.

2. **S05-02 — HIGH — VERIFIED-BY-READING: linked-cell refresh discards schedule-specific pipe quantity and trench-grate length.**

   **Location:** `Modules/Drainage/Services/ScheduleLinkService.cs:2020` and `:2026` (inlet/outlet diameter), `:2001` and `:2619` (pit size). Correct presentation rules already exist in `Modules/Drainage/Services/PitScheduleBuilder.cs:1119` and `:49`.

   **What happens in AutoCAD:** A drafter sees two 375 mm pipes in the schedule window, but a linked refresh can change the drawn schedule to just `375`, losing the quantity. For a trench grate, refresh can replace a 3000 mm length with `300 x 300`. The stored engineering record need not change. A later full placement/update can restore the right text, leaving the two operations disagreeing.

   **Exact failure scenario:** A current-drawing schedule in model space contains ordinary linked cells, with valid matching drawing/pit/pipe identities, current live pipe authority, no field overrides, unlocked layers and no active REFEDIT. One linked pipe has canonical `Diameter = "375"` and `DetentionTwinPipes = true`. A separate linked pit has `PitType = "TG"`, `TgLengthMm = 3000`, `XWidth = 300` and `YWidth = 300`. The different dimension values deliberately make a wrong field substitution visible.

   **Proof — twin pipes:** The schedule builder at `PitScheduleBuilder.cs:1119` uses `DetentionTwinPipes` to produce `2/375`; `:1115` explicitly explains that the stored diameter remains 375. The live row builder uses that helper for inlets/outlets at `ViewModels/PitScheduleViewModel.Data.cs:363` and `:366`. Refresh instead calls `FormatDiameter(pipe.Diameter)` at `ScheduleLinkService.cs:2020` and `:2026`; that formatter at `:3580` has no twin-pipe input and returns `375`.

   **Proof — trench grates:** `PitScheduleBuilder.BuildPitSize` at `:51` returns `TgLengthMm` for a TG pit. Refresh's separate `BuildPitSizeText` at `ScheduleLinkService.cs:2619` handles detention pits, then falls through to `XWidth x YWidth` at `:2638`. It never checks TG or reads its length.

   **Proof — real drawing write:** Placement creates model-space MText from the row text and registers its linked field at `ViewModels/PitScheduleViewModel.Schedule.cs:1240`, `:1278`, `:1294` and `:1310`. **Refresh** is bound at `Dialogs/PitScheduleDialog.xaml:125`. Its live handler calls the stale-cell scan and then `RefreshLinkedCells` at `ViewModels/PitScheduleViewModel.Data.cs:2783` and `:2788`. The full scan visits these model-space cells at `ScheduleLinkService.Index.cs:92`. `ScheduleLinkService.cs:810` builds the incorrect replacement; `ScheduleCellRefreshGate.Decide` compares exact text, so `2/375` and `375` differ. The writer at `ScheduleLinkService.cs:769` upgrades and replaces the entity text. The second stale-cell check can then count that wrong text as successfully brought up to date.

   **DETERMINISTIC TEST — NOT RUN:** Prepare synthetic `S05_LinkedCells.dwg` with pits P1 and P2 connected by a valid twin detention pipe of diameter 375 mm, plus TG pit T1 with the dimensions above. Include a valid live pipe record and its matching plan entities. Use current-drawing sources and an ordinary linked schedule in model space. Set no manual diameter or pit-size overrides. Record the handles of P1's outlet-size MText, P2's inlet-size MText and T1's pit-size MText. The fixture starts with their correct drawn contents `2/375`, `2/375`, and `3000`.

   **Typed steps:** Type `PITSCHEDULE`. On **Source**, select **Current drawing**. Inspect **Rows**: the two pipe-size values must be `2/375` and T1's size must be `3000`. Click **Refresh**, close the window and use `_LIST` on each of the three recorded MText objects. Reopen `PITSCHEDULE` and compare the same rows. If creating a fresh fixture through normal schedule placement already changes the contents at command completion, capture that earlier failure and use the prepared fixture to isolate the explicit Refresh action.

   **Assertion:** Both drawn pipe cells must remain `2/375`; T1's drawn size must remain `3000`; the stored twin flag, diameter and TG length must remain unchanged. Reading predicts drawn values `375`, `375`, `300 x 300`, while the row builder still derives the correct values. The **Refresh** handler may additionally report cells `brought up to date` through its `[BUG-246]` log at `PitScheduleViewModel.Data.cs:2799`; that message is not a substitute for inspecting the three drawing values.

   **Repair boundary:** Reuse the schedule builder's field presentation rules in linked refresh, preserving its existing override and protection checks. This is one formatter-divergence finding with two concrete manifestations, not two separately counted findings.

3. **Evidence baseline and exclusions.** All source citations are relative to `C:\Lisp Files\CE_ACAD_PLUGIN`, read with Git at `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869`. The brief identifies this as installed Civil 3.0.70 / Manager 1.1.70; installation was not independently checked. No findings are asserted against Structural or a later branch tip. Prior audits read for deduplication: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, and `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Their findings are not repeated. A possible pump-sizing arithmetic issue was excluded because the traced live drawing caller does not supply pump inputs in this release. No new engineering defaults or Manager administrator work are proposed.

4. **Read coverage — 112 of 112 requested files.** Every item below is under `Modules/Drainage/Services/` at the pinned ref. Supporting callers were also read where needed. Coverage means code inspection, not proof that the remaining files are defect-free.

1. **Read:** `PitEraseFreeEndsMessagePolicy.cs`.

2. **Read:** `PitHoverMath.cs`.

3. **Read:** `PitHoverService.cs`.

4. **Read:** `PitMoveFollowPolicy.cs`.

5. **Read:** `PitOutletSpeedCheck.cs`.

6. **Read:** `PitRenumberApplyService.cs`.

7. **Read:** `PitScheduleBuilder.cs`.

8. **Read:** `PitScheduleCellUpdatePlanner.cs`.

9. **Read:** `PitScheduleContinuationLayout.cs`.

10. **Read:** `PitScheduleDifferenceService.cs`.

11. **Read:** `PitScheduleGradeNote.cs`.

12. **Read:** `PitScheduleHostAuthorityClassifier.cs`.

13. **Read:** `PitScheduleHostInstanceService.cs`.

14. **Read:** `PitScheduleLevelText.cs`.

15. **Read:** `PitScheduleMergedRowOverrides.cs`.

16. **Read:** `PitScheduleOutletSizeCheck.cs`.

17. **Read:** `PitScheduleOutputScope.cs`.

18. **Read:** `PitScheduleOverrideMarkPolicy.cs`.

19. **Read:** `PitSchedulePlanLevels.cs`.

20. **Read:** `PitScheduleQaAdapterService.cs`.

21. **Read:** `PitScheduleQaService.cs`.

22. **Read:** `PitScheduleRemarkText.cs`.

23. **Read:** `PitScheduleRowIdentityService.cs`.

24. **Read:** `PitScheduleRowOrder.cs`.

25. **Read:** `PitScheduleSnapshotBuilder.cs`.

26. **Read:** `PitScheduleSourceSelectionService.cs`.

27. **Read:** `PitScheduleStatusService.cs`.

28. **Read:** `PitScheduleUpdateGuardService.cs`.

29. **Read:** `PitScheduleXrefDiscoveryCore.cs`.

30. **Read:** `PitScheduleXrefDiscoveryService.cs`.

31. **Read:** `PitScheduleXrefWatcherAutoCadAdapter.cs`.

32. **Read:** `PitScheduleXrefWatcherCoordinator.cs`.

33. **Read:** `PitScheduleXrefWatcherLifecycleAdapter.cs`.

34. **Read:** `PitSelector.cs`.

35. **Read:** `PitSetupAdvisorService.cs`.

36. **Read:** `PitSpineRowBackfillService.cs`.

37. **Read:** `PlacementContinuationService.cs`.

38. **Read:** `PlainNumberText.cs`.

39. **Read:** `PolylinePlanRing.cs`.

40. **Read:** `PostImportQaReportFormatter.cs`.

41. **Read:** `PostUndoWriteWatch.cs`.

42. **Read:** `PreFlightSummaryFormatter.cs`.

43. **Read:** `ProfileRouteEvidenceCaptureService.cs`.

44. **Read:** `ProfileRouteReviewService.cs`.

45. **Read:** `ProjectDataFingerprintService.cs`.

46. **Read:** `ProjectDataRecoveryGuardService.cs`.

47. **Read:** `ProjectDataSanityService.cs`.

48. **Read:** `ProjectDataService.AiAccessDrawing.cs`.

49. **Read:** `ProjectDataService.cs`.

50. **Read:** `ProjectDataService.DrawingOwnedKeys.cs`.

51. **Read:** `ProjectDataService.FieldEdit.cs`.

52. **Read:** `ProjectDataService.GradeHeldChoice.cs`.

53. **Read:** `ProjectDataService.IgnoredChecks.cs`.

54. **Read:** `ProjectDataService.Instance.cs`.

55. **Read:** `ProjectDataService.KeptRecords.cs`.

56. **Read:** `ProjectDataService.LandUse.cs`.

57. **Read:** `ProjectDataService.MirrorCarry.cs`.

58. **Read:** `ProjectDataService.Mutations.cs`.

59. **Read:** `ProjectDataService.Persistence.cs`.

60. **Read:** `ProjectDataService.PipeEndRepair.cs`.

61. **Read:** `ProjectDataService.PipeEndSnapshot.cs`.

62. **Read:** `ProjectDataService.PipeOops.cs`.

63. **Read:** `ProjectDataService.PitOops.cs`.

64. **Read:** `ProjectDataService.Queries.cs`.

65. **Read:** `ProjectDataService.Rainfall.cs`.

66. **Read:** `ProjectDataService.RecordWriteHold.cs`.

67. **Read:** `ProjectDataService.Recovery.cs`.

68. **Read:** `ProjectDataService.Rulebook.cs`.

69. **Read:** `ProjectDataService.RulebookDrawing.cs`.

70. **Read:** `ProjectDataService.Spine.cs`.

71. **Read:** `ProjectDataStorageContract.cs`.

72. **Read:** `ProjectQaAutomaticOutputCurrencyCaptureService.cs`.

73. **Read:** `ProjectQaEvidenceCaptureService.cs`.

74. **Read:** `ProjectQaOutputCurrencyCaptureService.cs`.

75. **Read:** `ProjectQaOutputCurrencyPolicy.cs`.

76. **Read:** `ProjectQaSnapshotService.cs`.

77. **Read:** `ProposalApplyService.cs`.

78. **Read:** `ProposalApplyService.PlanBuilders.cs`.

79. **Read:** `Proposals/DetentionDraftBanner.cs`.

80. **Read:** `Proposals/LevelsProposalEngine.cs`.

81. **Read:** `Proposals/LevelsProposalModels.cs`.

82. **Read:** `Proposals/LevelsProposalSelection.cs`.

83. **Read:** `PumpPitScheduleReader.cs`.

84. **Read:** `PumpSizingService.cs`.

85. **Read:** `QuickModeService.cs`.

86. **Read:** `RaingardenAreaWords.cs`.

87. **Read:** `RaingardenPlacementPlan.cs`.

88. **Read:** `RationalFlowService.cs`.

89. **Read:** `RedoWindowGuard.cs`.

90. **Read:** `RelinkedPipeRecordWriter.cs`.

91. **Read:** `RepairRecommendation.cs`.

92. **Read:** `ReuseCreditService.cs`.

93. **Read:** `ReviewReadingService.cs`.

94. **Read:** `RoofCatchmentSplitService.cs`.

95. **Read:** `RuntimePathService.cs`.

96. **Read:** `ScheduleCellEditDecision.cs`.

97. **Read:** `ScheduleCellOverrideText.cs`.

98. **Read:** `ScheduleCellRefreshGate.cs`.

99. **Read:** `ScheduleLinkedCellRefreshPlanner.cs`.

100. **Read:** `ScheduleLinkService.cs`.

101. **Read:** `ScheduleLinkService.Index.cs`.

102. **Read:** `ScheduleLinkService.SamePlanReplacement.cs`.

103. **Read:** `ScheduleTypedNumber.cs`.

104. **Read:** `ScopePitClaimEvidence.cs`.

105. **Read:** `SelfPipeRepairService.cs`.

106. **Read:** `SettingsHistoryService.cs`.

107. **Read:** `SettingsService.cs`.

108. **Read:** `SettingsService.RememberedValues.cs`.

109. **Read:** `SettingsSizingStandards.cs`.

110. **Read:** `SlabBoundaryEditPlan.cs`.

111. **Read:** `SlabCloneRecordPolicy.cs`.

112. **Read:** `SlabCompoundMoveAutoCadAdapter.cs`.

---

1. **Summary.** Two high-severity findings remain after tracing live callers: Xref discovery substitutes one copied drawing's data for another, and linked refresh writes incomplete or wrong schedule values. All 112 requested files were inspected at the pinned Civil ref. Both findings include deterministic AutoCAD acceptance tests, none run. Only this findings file was authored; source code and installed plugins were not changed.
