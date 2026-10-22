1. **ANSWER FIRST — S12 Civil Models: 1 HIGH, 2 MEDIUM, 0 LOW.** Three new findings, all verified-by-reading. The most important: changing pipe levels can save a short pipe flat while reporting a grade of 1 in 300.

2. **What else goes wrong.** A freshly entered trench-grate cover level of RL 0.000 is treated as missing. An agreed design can also say nothing changed when a colleague's runoff setting produces different calculations.

3. **What was completed.** All 126 requested files were read, largest first, with callers checked for the findings below. No AutoCAD session, build or test was run. The tests below are instructions for a later AI tester on synthetic drawings, not a request for Tim to test.

---

1. **Scope and evidence — 23 October 2026, Melbourne.** Read `C:\TimOS\RULES.md`, `ROUTER.md` and the plan routing material. Audited Civil 3.0.70 at `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869`, after fetching origin. All source references below are at that commit, not the working checkout. Supporting paths beginning Commands, Services, Rules, ViewModels or Dialogs are relative to `Modules/Drainage/`.

   **Prior findings excluded:** read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`. The previously reported Ignore, Tidy, command-outcome and Structural defects are not recounted here. Structural and parked Manager administrator work were not swept.

   **Evidence standard:** verified-by-reading means the inputs, reachable caller and incorrect result follow from source. It does not mean reproduced in AutoCAD. There are no counted suspected findings. HIGH denotes an incorrect saved engineering result with a misleading completion message; MEDIUM denotes lost known evidence or a false design-change assessment. No new hard block is proposed: R-27 still applies.

2. **S12-01 — HIGH — the cascade checks a fall it does not actually save. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Models/PropagationPlan.cs:50`, `:56`, `:160`, `:184`.

   **What happens in AutoCAD:** the drafter asks for 1 in 300 on a 1 m pipe. CE says the proposal is OK, writes the same invert at both ends and reports `Min grade: 1:300`. The saved pipe is flat. This is more than rounding the visible labels: the pipe's stored level strings and project record are rounded too.

   **Exact failure scenario:** one ordinary gravity pipe between P1 and P2, drawn length 1,000 mm, initially falling from RL 10.010 to 10.000. Propagate upstream from P2 at RL 10.000 and override that pipe to `300`. The proposal becomes upstream 10.003333... and downstream 10.000. Both model checks see positive fall. Both saved strings become `10.00`.

   **Source proof:** `Services/LinkService.RepairAudit.InvertPropagation.cs:318` accepts the override as `1 / N`; `:405` adds that fall to the anchor. `PipeUpdate.IsFlatOrNegative` and `IsFlatOrNegativeWhenWritten` compare unrounded doubles. The latter's name therefore promises more than it checks. The writer uses format `0.00` at `:30`, rounds both ends at `:780`, writes them to the pipe at `:785` and to ProjectData at `:827`.

   **False reassurance:** `ViewModels/PropagationPreviewViewModel.cs:55` displays rounded levels, but `:65` chooses its status from the unrounded model and `:79` labels the row `OK`. The completion grade is calculated from unrounded proposed levels at `Services/LinkService.RepairAudit.InvertPropagation.cs:832`, then printed at `:917`. The second pre-write check at `:686` still does not account for rounding.

   **DETERMINISTIC TEST — fixture:** synthetic millimetre model-space DWG, World UCS, matching millimetre pit blocks, unlocked pipe and annotation layers. P1 at (0,0), P2 at (1000,0), cover RL 12.000 at both, one normal CE gravity pipe P1 to P2, DN 225, invert labels present, original levels 10.010/10.000. No other connected pipes, Xrefs or REFEDIT; manual level flags clear. Retain a pristine copy.

   **Typed steps:** type `CDPROPAGATE`; select the P2 block; enter `10`. In Cascade Preview, edit P1-to-P2's `Override (1:N)` cell to `300`, then press Tab to commit the cell. Capture its new levels, status and summary. Click `Apply`; if the fixture was made with hand-set flags, explicitly choose `Overwrite`. Double-click the P1-to-P2 pipe and read both invert fields. Capture the command-line completion text.

   **Assertion:** current source predicts preview levels `10.00`/`10.00` with status `OK`, saved levels `10.00`/`10.00`, and completion containing `Min grade: 1:300`. The stored fall is zero. A corrected implementation must base the warning and reported grade on the values actually saved; it must not certify the unrounded grade. Preserve Tim's level-format ruling unless separately changed. Any decision to retain a flat pipe remains a warning and drafter decision under R-27.

3. **S12-02 — MEDIUM — a real zero trench-grate cover level is mistaken for an old skipped answer. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Models/PitData.cs:80`, `:89`.

   **What happens in AutoCAD:** typing RL 0.000 for a new trench grate prints that cover on the plan, but Edit Pipe's grade suggestion treats the surface level as unknown. Its cover assessment omits a known shallow end.

   **Exact failure scenario:** a new TG record has `PitType = "TG"` and `CoverLevel = "0.000"`. `IsSkippedCoverPlaceholder` uses only those two values: there is no age, schema or provenance test. `KnownCoverLevelRl` consequently returns null even for an explicitly typed, legitimate zero.

   **Source proof:** `Commands/SourceBlockInsertCommands.cs:754` permits zero, `:781` accepts the typed value, `:381` stores it and `:789` formats it to three decimals. `:803` also prints `CL 0.000 m AHD` in the callout. `Commands/PipeEditCommand.GradeSuggestion.cs:71` resolves the endpoint's project record, `:82` reads its cover through the faulty method, and `:192` runs the advisor. `Services/PipeGradeAdvisorService.cs:188` then returns an unknown cover assessment. The old skipped-answer repair thus also applies to newly entered zeros.

   **DETERMINISTIC TEST — fixture:** synthetic mm model-space drawing, World UCS, unlocked standard CE layers, P1 at (10000,0), cover RL 1.000 and invert RL -0.300. No duplicate pit/source tags or stale connection keys. Office minimum cover 600 mm, with no council or project override; the fixture's DN 100 minimum-grade entry is 1:100. Empty trench-grate list so the next tag is TG1. Keep the Edit Pipe flow/Q field blank to exercise the grade advisor.

   **Typed steps:** type `CDTG`; pick start `0,0`, end `2000,0`; enter width `150`; choose Standard and grate class C. At the cover prompt explicitly type `0`, then Enter to skip the optional outlet pick. Confirm the new callout contains `CL 0.000 m AHD`. Use `CD` to draw one ordinary gravity pipe from TG1's connection point at (0,0) to P1, diameter 100 mm, upstream invert -0.200 and downstream invert -0.300. Complete placement. Double-click that TG1-to-P1 pipe and inspect the grade-suggestion strip's tooltip in Edit Pipe. Do not apply the suggestion.

   **Assertion:** the suggested upstream invert is -0.200, anchored on P1's -0.300 with 0.100 m fall. Actual TG1 cover is `(0 - (-0.200)) x 1000 - 100 = 100 mm`, below 600 mm. Current source instead predicts tooltip text containing `US pit TG1: CL unknown` and `not checked upstream (surface RL unknown)`. These strings are built at `ViewModels/CdViewModel.GradeSuggestion.cs:540`, `:547` and `:563`; `Dialogs/PipeEditWorkshopDialog.xaml:180` binds the tooltip. Repeat on a pristine copy with typed cover `0.001`: the upstream level must become known and its 101 mm cover must fail the minimum-cover assessment. This isolates the zero-specific loss.

   **Repair boundary:** distinguish legacy uncertainty from a newly supplied zero. Do not turn genuinely unknown old TG covers into known zeros. CDRULES is deliberately not the test for this finding: its separate live source projection supplies empty source-level evidence at `Services/LinkService.Spine.cs:258`, so that route would not isolate this model defect. Nor is the ordinary pit Inspector panel assumed for a TG source.

4. **S12-03 — MEDIUM — the agreed-design record omits the hard-ground runoff coefficient used by the calculation. Verified-by-reading.**

   **File:line:** `Modules/Drainage/Models/AgreedDesignSnapshot.cs:119`; `Modules/Drainage/Models/UserSettings.cs:2194`.

   **What happens in AutoCAD:** a colleague can open an agreed drawing with a different valid hard-ground runoff setting and see `Nothing has changed since the design was agreed.` Working the design out then produces a different weighted runoff coefficient. The drawing's areas and council need not change.

   **Exact failure scenario:** a 1,000 m² site has 600 m² roof/paving and 400 m² soft ground. Soft-ground C stays 0.30. The agreement is made with hard-ground C 0.90; a second session reads the same drawing with hard-ground C 0.60. Weighted C changes from 0.66 to 0.48. These are synthetic test values, not a recommended design coefficient.

   **Source proof:** `AgreedDesignInputs` contains only PreDevC, PostDevSoftGroundC and TcMinutes. `ViewModels/CivilDesignWindowViewModel.cs:163` captures only those effective inputs; `Rules/AgreedDesignRules.cs:106`, `:179` and `:206` respectively capture, check completeness and compare the same three values. The council's `ImperviousC` field is a different value, copied from the unchanged council profile at `CivilDesignWindowViewModel.cs:149`; it does not represent this Settings value.

   **Live calculation and wording:** `Services/AutoDesignService.cs:66` reads `Detention.HardGroundRunoffC`, and `:316` applies it to impervious area. `:102` computes the weighted C. The live route is `Commands/CivilDesignCommand.cs:102` to `Services/CivilDesignService.cs:174`, then `Services/AutoDesignOrchestrator.cs:143`. The report prints `Weighted C (post-dev)` at `Services/DesignProposalReport.cs:119`.

   **Why no warning appears:** `Rules/AgreedDesignRules.cs:221` has no comparison for the omitted value, nor does NotChecked account for it. `ViewModels/DesignDuringViewModel.cs:57` consequently permits the unchanged message; `Dialogs/CivilDesignWindow.xaml:241` displays it. Merely making a new agreement on this release does not cure the omission.

   **DETERMINISTIC TEST — fixture:** two isolated tester profiles A and B with otherwise identical valid `CD_Settings.json` and council catalogues. A has `detention.hardGroundRunoffC = 0.9`; B has `0.6`. Both have `designStandards.postDevSoftGroundC = 0.3`. Use fresh AutoCAD processes so settings are loaded once per profile; do not change Tim's settings. Prepare a synthetic Design-from-scratch DWG with Generic Default council, the areas above, a valid confirmed LPD at RL 10.000, readable outlet authority, residential land use and all setup questions answered. Detention can be off for this comparison. No job-folder reports or automatic area offers.

   **Typed steps:** in profile A, open the fixture, type `CDDESIGN`, click `Work out design`, and record `Weighted C (post-dev)` as 0.66. Click `Confirm setup` to record the agreement, close and `QSAVE`. In fresh profile B, open a copy of that saved DWG and type `CDDESIGN`. Capture the During page before agreeing anything again. Click `Work out design` and capture the result.

   **Assertion:** current source predicts During says `Nothing has changed since the design was agreed.` while the result now reports weighted C 0.48. Correct behaviour is to identify the coefficient change, or state it could not be compared for an older incomplete agreement. The reassuring unchanged sentence must not appear. A control reopening under profile A must retain 0.66. No settings UI control is assumed by this fixture: the isolated files represent two colleagues' loaded settings.

5. **Execution and ownership.** Source inspection only: no builds, tests, AutoCAD, installation, deployment, code commit, branch or sub-agent. The only authored repository file is this report. Proposed probes have not been run and no defect is marked fixed. Publishing is limited to this named file in CE_PLAN; unrelated working changes remain outside the commit.

6. **Complete read ledger.** All paths below are under `Modules/Drainage/Models/` at the pinned commit. All 126 were read with `git show`, in descending blob size; total source size 762,147 bytes. Caller reads above supplement that coverage. This is a read ledger, not a claim that the remaining files are runtime-certified.

7. **Read 1-10:** `UserSettings.cs`, `ProfileRouteReviewModels.cs`, `PitData.cs`, `CouncilProfileModels.cs`, `XcivilImportModels.cs`, `NetworkRedesignNominationModels.cs`, `CalculationPanelDraftData.cs`, `MultiPlanNetworkModels.cs`, `ChangePlan.cs`, `NetworkRedesignPipelineModels.cs`.

8. **Read 11-20:** `NetworkRedesignCurrentDrawingEvidence.cs`, `ProjectData.cs`, `PropagationPlan.cs`, `CalculationWorkspaceData.cs`, `OrificePitDetailModels.cs`, `ProjectQaOutputCurrencyModels.cs`, `DesignImpactModels.cs`, `NetworkRedesignDrawingEvidenceModels.cs`, `PipeSizingModels.cs`, `MultiLpdAuthorityModels.cs`.

9. **Read 21-30:** `AgreedDesignSnapshot.cs`, `SlabData.cs`, `ProjectQaReviewModels.cs`, `CivilProjectStartDraft.cs`, `NetworkRedesignTopologyModels.cs`, `AutoDesignModels.cs`, `ProjectQaCaptureModels.cs`, `PipeTruthModels.cs`, `NetworkRedesignSolverModels.cs`, `OrificeDetailModels.cs`.

10. **Read 31-40:** `SurveyIntakeModels.cs`, `DetentionModels.cs`, `NetworkRedesignPreviewModels.cs`, `PerfDiagWords.cs`, `LegacySplitMigrationModels.cs`, `CdDrawFirstFlowModels.cs`, `ExactStoredLinkRepairModels.cs`, `DashboardReport.cs`, `DesignPackageModels.cs`, `CatchmentModels.cs`.

11. **Read 41-50:** `PitScheduleDifferenceModels.cs`, `DrawingCheckModels.cs`, `PumpModels.cs`, `NetworkRedesignApplyModels.cs`, `DetailSelectionModels.cs`, `SurveyData.cs`, `ManualScheduleRowData.cs`, `ArchetypeModels.cs`, `XrefSiteGeometryModels.cs`, `PitScheduleHostInstanceRecord.cs`.

12. **Read 51-60:** `PitSelectionModels.cs`, `MultiLpdEndpointAuthorityModels.cs`, `NetworkDesignModels.cs`, `SurfaceColourMap.cs`, `PitScheduleCellUpdateModels.cs`, `MarkupFinding.cs`, `PavementAreaRecord.cs`, `CalculationExportSection.cs`, `CivilLinkedFieldChangeModels.cs`, `LevelsProposalSettings.cs`.

13. **Read 61-70:** `DoubleClickSettings.cs`, `JobLandUse.cs`, `GripRouteSettings.cs`, `SurfaceEvidenceModels.cs`, `SpsDetailModels.cs`, `PipePlanAnchor.cs`, `BackgroundXrefCompareModels.cs`, `PartsCatalogueData.cs`, `SurfaceOverlayModels.cs`, `CouncilRfiSettings.cs`.

14. **Read 71-80:** `SoakageModels.cs`, `PitScheduleXrefWatcherModels.cs`, `PitScheduleWorkflowState.cs`, `CrossingServiceSettings.cs`, `DesignValidationModels.cs`, `WaterTankDetailModels.cs`, `DesignImpactProjectionModels.cs`, `RaingardenData.cs`, `ProjectReviewApproval.cs`, `CeChipState.cs`.

15. **Read 81-90:** `EngineeringPipeSnapshot.cs`, `IgnoredCheckData.cs`, `PipeAnnotationHandles.cs`, `TreeSiteConstraint.cs`, `PitScheduleXrefSourceInfo.cs`, `LongSectionModels.cs`, `OrificePitDetailLiveInputs.cs`, `LayerOrderSettings.cs`, `GripDiagnosticWords.cs`, `PipeEndpointConnectionReviewData.cs`.

16. **Read 91-100:** `ConnectedPipeInfo.cs`, `JointModels.cs`, `OrificeModels.cs`, `PipeOopsNote.cs`, `ReuseCreditModels.cs`, `CeMessageUserSettings.cs`, `BrokenXrefRepairModels.cs`, `LabelStyleData.cs`, `SpoonDrainRecord.cs`, `PipeAttachmentSemantics.cs`.

17. **Read 101-110:** `PipePitFitEvidence.cs`, `PipeAttachmentBindingInfo.cs`, `SettingsHistoryEntry.cs`, `CdCommandLineSettings.cs`, `PitScheduleStatusModels.cs`, `HealthWarning.cs`, `PitPlanAnchor.cs`, `CatalogueSaveResult.cs`, `CivilOwnershipHighlightPlan.cs`, `NetworkCatalogueModels.cs`.

18. **Read 111-120:** `InspectorDisplayMode.cs`, `PausedFeatureData.cs`, `CeThemePreference.cs`, `PreviewDryRunHandler.cs`, `QuickModeSettings.cs`, `DesignLpdSelection.cs`, `PitOopsRecordNote.cs`, `FleetTelemetrySettings.cs`, `PipeType.cs`, `KeywordShortcutWords.cs`.

19. **Read 121-126:** `TankCalloutSettings.cs`, `PitOutletOverrideData.cs`, `ComputationTemplateInfo.cs`, `NetworkRedesignOutletRoleModels.cs`, `GradeMethod.cs`, `PipeTextLayoutMode.cs`.

20. **Summary.** Three new source-proven findings: one HIGH and two MEDIUM. Prioritise the cascade's rounded saved levels and false grade report. Preserve genuinely entered zero cover levels, and include the effective hard-ground runoff setting in agreed-design comparisons. All 126 requested models were read; runtime behaviour remains to be checked using the stated synthetic fixtures. No build, test or AutoCAD run was performed. Only this findings file was authored; no plugin change or fix is claimed.
