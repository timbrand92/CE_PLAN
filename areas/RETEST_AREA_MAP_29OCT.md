# After an install, re-test only what the fix touched: the area map, the rule, and the weekend full re-test (29 Oct 2026)

Job `CE_ACAD / robot / plan / 14` (CE 02 Robot and Codex Testing, Team, Opus). Written Thu 29 Oct 2026, 11:11 to about 11:40 Melbourne (PC clock). Read and write documents only. Tim's AutoCAD was open and was not touched: nothing was started in AutoCAD, the runner, the driver, the settings guard or the lock. No runner, driver, chain, case, review, ledger, DESK_LOG or BUG_CARPARK file was edited. Source was read with `git show`, `git grep` and `git diff --name-only` at `origin/claude/rel-20261026z` = `09126560` (Civil 3.0.85, C-75). Tim's ruling: `decisions\2026-10-29_TIM_RETEST_RULE.md` ("Yes, recommended").

## ANSWER FIRST

1. **The map is written:** 66 accepted checks, sorted into 17 tool areas, plus a list of shared code that always means a full re-test.
2. **A focused fix saves most of the night.** Example: a fix to Edit Pipe only re-tests the 7 Edit Pipe checks, in about 1 hour 5 minutes instead of about 6 hours 40 minutes for all 66.
3. **But with today's habits it would almost never save anything.** Every fix also adds its own on/off switch to the CE settings file, and your rule says a settings change means re-test everything. So I need one ruling from you (question in FOR TIM, item 3).
4. **Checked against the last four installs (C-72 to C-75):** three of them changed the core of CE (the pit and pipe record, the undo plumbing, the start-up), so they would have been full re-tests anyway. Only C-75 would have been cut down, and only with the switch ruling: 32 checks in about 3 h 25 min instead of 6 h 40 min. Nothing would have been missed: the C-75 regrade had 0 failures on 53 checks.
5. **The weekend full re-test is ready to run** (not run): all 66 checks, twice each, in 38 AutoCAD starts. About 6 h 40 min with today's 3-minute wait between sessions; about 5 h 45 min once the staged shorter safe wait goes live. Written today's way, it would be about 8 h 15 min.

## FOR TIM

1. **What changes, in drawing terms.**
   - **Now:** after every install the robot re-runs all 66 checks twice. That is a whole night.
   - **After:** the robot reads which files the install changed and which tools they belong to. A fix to Edit Pipe re-runs the Edit Pipe checks only. The pit-catch, CDTWL and Pit Schedule checks keep their earlier pass, marked "carried from 3.0.85", until the Saturday full re-test.
   - **Still a full re-test:** any change to the settings, the pit or pipe record, labels, the undo and redo plumbing, the command log, the start-up and ribbon, the Manager, or anything the map does not know.

2. **Hours, with real examples (estimates from measured times).**
   - **An Edit Pipe fix:** 7 checks, about 1 h 5 min instead of about 6 h 40 min.
   - **A fix like C-75** (Edit Pipe arrow, ROTATE Copy of a pit, downpipe pick at a pipe end): 32 checks, about 3 h 25 min instead of 6 h 40 min.
   - **A fix to PIT or CD placement:** about 30 checks (36 if both), because many checks draw a pit and a pipe first. Roughly half a night.
   - **The last three installs before C-75** changed CE's core, so they would still be full re-tests.

3. **The one question for you.**
   - **Context:** every fix adds its own new switch to the CE settings file (for example "Edit Pipe reads the arrow from the drawn ends", default ON). Your rule says a settings change means re-test everything.
   - **Question:** may a fix that only ADDS its own new switch, and changes no existing setting, count as touching only its own tool?
   - **My recommendation: yes.** A new switch with a new name cannot change how PIT, CD or CDTWL read their own settings. Any EDIT to an existing setting, or a removed one, would still mean everything.
   - **What each answer means on a job night:** Yes: the C-75 install re-tests 32 checks (about 3 h 25 min) and carries 34. No: every install re-tests all 66 (about 6 h 40 min) and the new rule saves nothing until fixes stop adding switches.
   - **Until you answer,** the robot follows your rule as written: any settings file change means a full re-test.

4. **The Saturday full re-test (31 Oct and 7 Nov, and before Max).** All 66 checks, twice each, in separate AutoCAD starts. About 6 h 40 min today, about 5 h 45 min once the shorter safe wait goes live. Weekends are free time on your PC, so it fits in one day.

5. **What it cannot catch.** A fix to tool A that breaks tool B through some hidden link the map does not show. Example: an Edit Pipe fix that changes how a pipe end is stored, which CDSYNC then reads wrongly. CDSYNC would keep "carried" until Saturday. The Saturday full re-test is the safety net; the most it can hide is a few working days.

6. **What you need to do:** answer item 3 (yes or no). Nothing else.

---

## Technical detail

### 1. The accepted list that was mapped

1. **Computed 11:13 with a copy of the tally's own rule** (`C:\ce-fx\retest\probe_eligible_and_commands.ps1`, read only): every `*.review.txt` in `cases\` and `cases\variants\`, VERDICT line containing `CLAUDE-ACCEPTED-READY`, and `CASE_SHA256_REVIEWED` equal to `Get-FileHash` of the case file. Output `C:\ce-fx\retest\eligible_now.txt`.
2. **Result: 66 accepted and matching**, the same 66 as `C:\ce-fx\c75run\eligible.txt` (05:32). Not counted: R06, R09, R18 (no matching ready review), and the two variant reviews R08_broken and R10_broken (twins, not counted; `eligible.ps1` does not read `variants\*.review.txt`, so its file simply lacks those two rows).
3. **Commands per case** (typed steps, windows touched, SETUP and SETTING lines): `C:\ce-fx\retest\case_commands.txt`. The three setups matter a lot: **SETUP-P8 and SETUP-P8x2 run PIT and CD; SETUP-R47 runs MOVE, PIT and CD.** So 17 cases exercise PIT and CD even though their own steps never type them.

### 2. (a) The areas

Path patterns are relative to the repo root, with forward slashes exactly as `git diff --name-only` prints them. `*` means any text. A file can belong to more than one area; it then pulls in every area it belongs to. Command owners found with `git grep "CommandMethod(\"<NAME>\""` at `09126560`.

1. **Pit placement (PIT, the New Pit window).**
   - **Files:** `Modules/Drainage/Commands/PitCommand*.cs`, `Commands/PitEditCommand*.cs`, `Commands/PitCoverTextFlipCommand.cs`, `Dialogs/PitDialog*`, `Dialogs/PitWindowLayout*`, `Dialogs/PitOnePageLayout*`, `Dialogs/PitConnectionSelector*`, `Dialogs/PitDetailsReview*`, `Dialogs/PitReadinessPresentation*`, `Dialogs/PitEditWorkshopDialog*`, `ViewModels/PitViewModel*`, `ViewModels/PitSuggestionViewModel*`, `ViewModels/PitConnectedLevelsViewModel*`, `ViewModels/WorkshopPitCoverTextReadout*`, `Controls/Pit*`, `Controls/CePitPreviewControl*`, `Helpers/Pit*.cs`, `Services/PitHover*`, `Services/PitSelector.cs`, `Services/PitSetupAdvisorService.cs`, `Services/PitCoverText*`, `Services/PitBlockMigrationService.cs`, `Services/CoverLevelSourceService.cs`, `Services/PlacementContinuationService.cs`, `Services/AutoCadContinuationPair*`, `Services/ContinuationPair*`, `Services/LinkService.PitConnectionEntry.cs`, `Services/LinkService.PitOutline.cs`, `Services/LinkService.PitCoverText.cs`, `Services/LinkService.PitOwnership.cs`, `Services/LinkService.PitOops.cs` (all under `Modules/Drainage/`).
   - **Cases (27):** typed PIT: N05, N07, N19, N22, N23, N25, N28, N29, R05, R33. Through a setup: N06, N17, R01, R02, R02b, R03, R04 (SETUP-P8 or P8x2); R11, R13, R14, R14h_both_200, R14h_dstd_200, R14h_pipekey_200, R15, R16, R19, N27 (SETUP-R47).
2. **New Pipe and CD (CD, the New Pipe window, CD on an existing line).**
   - **Files:** `Commands/CdCommand*.cs`, `Commands/CdJointCommand.cs`, `Dialogs/CdDialog*`, `Dialogs/PipeWindowLayout*`, `Dialogs/PipeOnePageLayout*`, `Dialogs/PipePreviewInteraction*`, `Dialogs/GradeMismatchDialog*`, `Dialogs/PipeValidationWarningDialog*`, `ViewModels/CdViewModel*`, `ViewModels/PipeValidationWarningViewModel*`, `ViewModels/WorkshopPipeDrawingOptions*`, `Controls/CdPlanPreviewControl*`, `Controls/PipePreviewControl*`, `Controls/CePipePreviewControl*`, `Services/PipeCreationService*`, `Services/CdDrawFirst*`, `Services/CdCalcPrefillService.cs`, `Services/LastPipeChoiceService.cs`, `Services/PipeTextPlacementService.cs`, `Services/ArrowService.cs`, `Services/IlTextWriteGate.cs`, `Services/PipePickService.cs`, `Services/PipeEndpointConnection*`, `Services/PipeFitsPitRule.cs`, `Services/PipePitFitReviewService.cs`, `Services/PipeGradeAdvisorService.cs`, `Services/GradeHeldLevelChoice.cs`, `Services/GradeNoteMarker.cs`, `Services/PipeCrossingSplitService.cs`, `Services/InlineSplitDecisionPolicy.cs`, `Services/LinkService.NewPipeEnds.cs`, `.NewPipeIdentity.cs`, `.PipeEndJoin.cs`, `.PartnerInverts.cs`, `.EndpointPreview.cs`, `.SamePlanBreak*.cs`, `.CrossingSplit.cs`, `.Split.cs`, `.SplitDecisions.cs`, `.BranchJunctionDisplay.cs`, `.BreaklineAnchorMath.cs`, `Helpers/PipeDirectionHelper.cs`, `Helpers/InvertTextFootprintHelper.cs`, `Helpers/PipeTextSegmentChooser.cs`, `Helpers/SelfPipeGuard.cs`, `Helpers/BreaklineInvertResolver.cs`, `Helpers/ConnectedPipeFlowResolver.cs`, `Helpers/UpstreamDownstreamSuggest.cs`, `Helpers/PreviewDebounce.cs`.
   - **Cases (30):** typed CD: N07, N18, N19, N20, N23, N28, R02b, R17, R31, R32, R32b, R39, R39b. Through a setup: the 17 setup cases in item 1. **Plus R07 when `Commands/CdCommand.cs` itself changes** (the Settings command CDS lives in that file, line 1537).
3. **Edit Pipe (CDEDIT, the Edit Pipe window, the downstream cascade).**
   - **Files:** `Commands/PipeEditCommand*.cs`, `Commands/HubCommands.cs` (the CDEDIT doorway, line 75), `Commands/BatchEditDialogHost.cs`, `Commands/Editing/**`, `Dialogs/PipeEditWorkshopDialog*`, `Dialogs/EditPipePresentationLayout*`, `Dialogs/BatchEditWorkshopDialog*`, `Dialogs/PropagationPreviewDialog*`, `ViewModels/PropagationPreviewViewModel*`, `Services/PipeEditGuardService.cs`, `Services/PipeBatchWriteService.cs`, `Services/PipeSizeWriteService.cs`, `Services/CeBatchEditApplyCoordinator.cs`, `Services/CascadeRelinkScope.cs`, `Services/LinkedTextEditBatch.cs`, `Services/BatchSharedWork.cs`, `Services/LinkService.PipeUpdates.cs`, `.PipeWriteSeam.cs`, `.NetworkEdits.cs`, `.LinkedTextEdits.cs`, `Rules/EditPipe*.cs`.
   - **Cases (7):** N11, N26, R11, R20, R23, R32, R32b.
4. **Pit Schedule and renumber (PITSCHEDULE, CDRENUMBER).**
   - **Files:** `Commands/PitScheduleCommand.cs`, `Commands/PitRenumberCommand.cs`, `Commands/CdCommand.Schedule.cs`, `Dialogs/PitScheduleDialog*`, `ViewModels/PitSchedule*`, `Controls/ScheduleCellTextConverter*`, `Models/PitSchedule*`, `Services/PitSchedule*`, `Services/PitRenumberApplyService.cs`, `Services/ScheduleLinkService*`, `Services/ScheduleLinkedCellRefreshPlanner.cs`, `Services/ScheduleCell*`, `Services/ScheduleTypedNumber.cs`, `Services/CopiedScheduleAnnouncements.cs`, `Services/PitSpineRowBackfillService.cs`, `Services/LinkService.ScheduleLevels.cs`, `Services/LinkService.PitRenameOwnership.cs`.
   - **Cases (16):** N02, N08, N09, N11, N15, N24, N26, N29, R02, R04, R13, R38; and, to be safe, the copy cases that give a copied pit its own schedule row: N12, N16, R34a, R34sn.
5. **Sync, rebuild and recover inverts (CDSYNC, CDREBUILD, CDRECOVERINVERTS, link repair).**
   - **Files:** `Commands/LinkCommands*.cs` (CDSYNC line 118, CDREBUILD 210, CDRECOVERINVERTS 2216), `Commands/RefreshLinksCommand.cs`, `Commands/PipeEndRepairCommand.cs`, `Dialogs/CdRepairDialog*`, `Dialogs/CdLinkDialog*`, `Services/LinkService.RepairAudit*.cs`, `.RefreshLinks.cs`, `.PipeEndRepair*.cs`, `Services/ExactStoredLinkRepair*`, `Services/RelinkedPipeRecordWriter.cs`, `Services/RepairRecommendation.cs`, `Services/RepairReportText.cs`, `Services/SelfPipeRepairService.cs`, `Services/PipeEndReviewService.cs`.
   - **Cases (5):** N01, N26, R04, R13, R15.
6. **Tidy labels and label placement (CDTIDYLABELS, where a pit or pipe label lands).**
   - **Files:** `Commands/TidyLabelsCommand.cs`, `Services/LinkService.TidyPitText.cs`, `.TextClashTidyUp.cs`, `.PipeLabelReword.cs`, `Services/AnnotationMoveService.cs`, `Services/PipeTextPlacementService.cs` (also area 2), `Helpers/PitAnnotationShift.cs`, `Helpers/PitAnnotationMovePolicy.cs`, `Rules/*Tidy*.cs`. (The label WORDING formatters are in the SHARED list: Tim named labels as shared.)
   - **Cases (6):** R16, N27, N05, N20, N25, R03.
7. **Copy, move, rotate, scale, erase and explode of pits and pipes (plain AutoCAD commands on CE objects).**
   - **Files:** `Commands/CopyRotateCommands.cs`, `Commands/CdMoveCommands.cs`, `Commands/ExplodeEntityCommand.cs`, `Services/LinkService.NativeEdits.cs`, `.NativeEditRouting.cs`, `.PitMoves.cs`, `.PipeMoveHelpers.cs`, `.CloneRegeneration.cs`, `.CloneRepair.cs`, `.ForeignClones.cs`, `.SpineClones.cs`, `.LegacyCopyLabels.cs`, `.ExternalAttachmentMoves.cs`, `.AttachmentTransforms.cs`, `.LockedLayerChanges.cs`, `.PitRelinks.cs`, `.ArraySource.cs`, `.Compound.cs`, `Services/Clone*.cs`, `Services/ExternalMutationCommandPolicy.cs` (only MOVE, COPY, ROTATE, SCALE, ERASE-type commands; no CE command passes through it), `Services/NativeEdit*.cs`, `Services/PitMoveFollowPolicy.cs`, `Services/PitEraseFreeEndsMessagePolicy.cs`, `Services/ExplodeLeftScheduleMessagePolicy.cs`, `Services/MirrorService.cs`, `Services/BlockGhostFollower.cs`, `Services/PitHandleRefound.cs`, `Services/SourceCloneMapNativeBridge.cs`, `Rules/CloneOriginRule.cs`, `Rules/RotateScaleCopyRule.cs`.
   - **Cases (23):** typed: N02, N07, N12, N16, N17, N22, N27, R12, R16, R19, R19b, R33, R33m, R34a, R34sn, R37b. Through SETUP-R47 (it moves pit P3 first): R11, R13, R14, R14h_both_200, R14h_dstd_200, R14h_pipekey_200, R15.
8. **Downpipe, overflow and other sources (DP, OF, FO, CDRG raingarden, CDFW floor waste).**
   - **Files:** `Commands/SourceBlockInsertCommands.cs` (DP 55, OF 75, FO 85, CDRG 417), `Commands/SourceBlockGenericCommand.cs`, `Commands/SourceTag*.cs`, `Commands/SourceDestinationCommand.cs`, `Commands/FloorWasteCommand.cs`, `Commands/RaingardenOutlineStep.cs`, `Commands/WaterTankCommand*.cs` (shares the source landing), `Dialogs/SourceEditDialog*`, `Services/SourcePlacementService.cs`, `Services/SourceTag*`, `Services/SourceChange*`, `Services/LinkService.SourceLanding.cs` (also area 7: copy uses it), `.SourceChanges.cs`, `.SourceChangeApply.cs`, `.SourceChangeCapture.cs`, `.SourceChangePublication.cs`, `.SourceMoves.cs`, `.SurfaceDrainTags.cs`, `.DoubleClickOwner.cs`, `Services/Raingarden*`, `Services/DoubleClick*`, `Services/BackgroundDownpipeSymbolReader.cs`, `Services/XrefDownpipeDetectionService.cs`, `Rules/Source*.cs`.
   - **Cases (3):** N03, N04, R36. (R09, the DP double-click, is not counted today.)
9. **CDTWL detention top water level.**
   - **Files:** `Commands/DetentionTwlCommand.cs`, `Services/DetentionTwlService.cs`, `Services/DetentionSizingService.cs`, `Services/DetentionTwinPipe*`, `Services/OnSiteDetentionCriteriaService.cs`, `Models/DetentionModels.cs`.
   - **Cases (4):** R14, R14h_both_200, R14h_dstd_200, R14h_pipekey_200.
10. **Checks (CDCHECK, CDCHECKCURRENT, CDCHECKIGNORE).**
    - **Files:** `Commands/SpineCheckCommand.cs`, `Commands/CheckCurrentDrawingCommand.cs`, `Commands/CheckIgnoreCommand.cs`, `Commands/ChecksListCommand.cs`, `Commands/CheckDwgCommand.cs`, `Commands/HealthCheckCommand.cs`, `Services/Checks/**`, `Services/CurrentDrawingCheckService.cs`, `Services/ChecksListPaletteService.cs`, `Services/DrawingCheckPaletteService.cs`, `Services/MinimumCoverForChecks.cs`, `Services/PipeSpeedLimit*`, `Services/MaterialVelocityLimits.cs`, `Services/CivilNetworkHealth*`, `Models/IgnoredCheckData.cs`, `Models/DrawingCheckModels.cs`, `Controls/ChecksListControl*`, `Controls/DrawingCheckPanelControl*`, `ViewModels/ChecksListViewModel*`, `ViewModels/DrawingCheckViewModel*`.
    - **Cases (4):** R05, R10, R19, R21.
11. **Single small tools, one area each.**
    - **CDFEEDBACK:** `Commands/FeedbackCommand.cs`, `Services/FeedbackService.cs`, `Services/FaultReportTextScrub.cs`, `Dialogs/FeedbackDialog*`, `ViewModels/FeedbackViewModel*`. Case N21.
    - **CDSURVEY:** `Commands/CdSurveyCommand.cs`, `Modules/Drainage/Survey/**`, `Services/Survey*`. Case R26.
    - **CDPROFILE:** `Commands/ProfileCommands.cs`, `Services/LongSection*`, `Services/Longitudinal*`, `Services/ProfileRoute*`, `ViewModels/Longitudinal*`, `ViewModels/ProfileRoute*`, `Services/LinkService.ProfileReview.cs`. Case R28.
    - **CDSL spot level:** `Commands/SpotLevelCommand.cs`, `Services/SpotLevelReader.cs`. Case R35.
    - **CDPERIMETER (AGI):** `Commands/AgiCommand*.cs`. Cases R37, R37b.
12. **Structural.** `Modules/Structural/**`, `Modules/Structural.DesignCore/**`. No accepted case. Its DLL loads in the same AutoCAD, so the re-test is the launch group (R05, R07, R08, R10) as a load check.
13. **Civil tools with no accepted robot case yet.** Only these whole names: `Commands/CalculationsCommand.cs`, `Dialogs/Calculations*`, `ViewModels/*Calc*ViewModel.cs`, `ViewModels/Calculation*`, `ViewModels/WsudViewModel.cs`, `ViewModels/RationalMethodViewModel.cs`, `Services/Calculation*`, `Services/NetworkRedesign*`, `Services/Xcivil*`, `Services/Slab*`, `Services/Orifice*`, `Services/WaterTankDetail*`, `Services/CeAi*`, `Modules/Drainage/AI/**`. Re-test: the launch group as a load check. **Any file of these that is called from another area's file** (check with `git grep -l <ClassName> <new commit>`) belongs to that area too.
14. **Manager.** Listed under SHARED (it installs and loads CE).

### 3. (b) SHARED: a change here means the FULL set

All under `Modules/Drainage/` unless the path says otherwise.

1. **Settings** (every tool reads them at start-up): `Models/UserSettings.cs`, `Models/*Settings*.cs`, `Services/SettingsService*`, `Services/SettingsHistoryService.cs`, `Services/SettingsSizingStandards.cs`, `Services/ISettingsProvider.cs`, `Settings/**`, `Dialogs/*Settings*`, `ViewModels/*Settings*`, `ViewModels/SettingsValueCatalog.cs`. Proposed exception, waiting for Tim (FOR TIM item 3): a diff of a settings model that only ADDS a new switch block (summary comment, `[JsonProperty("<new name>")]`, property with its default) and removes or edits nothing counts as part of the fix's own area. Until Tim says yes, it is FULL.
2. **The pit and pipe record (CE's own memory of the network):** `Services/ProjectDataService*`, `Services/ProjectData*`, `Services/IProjectDataRepository.cs`, `Models/ProjectData.cs`, `Models/PitData.cs`, `Models/PipeTruthModels.cs`, `Models/EngineeringPipeSnapshot.cs`, `Services/Spine/**`, `Services/LinkService.Spine.cs`, `Services/LinkService.PipeRecord.cs`, `Services/PipeTruth*`, `Services/EngineeringPipeResolver.cs`, `Helpers/PipeRecordTypeResolver.cs`, `Services/LpdService*`, `Services/LpdStorageContract.cs`, `Services/MultiLpd*`.
3. **The linking engine core** (runs on every CE command and every edit): `Services/LinkService.cs`, `LinkService.Reactors.cs`, `.State.cs`, `.Instance.cs`, `.Registration.cs`, `.Cache.cs`, `.Persistence.cs`, `.Utilities.cs`, `.Geometry.cs`, `.PipeOwnership.cs`, `.PipeObjectUpgrade.cs`, `.UnloadedPipeObjects.cs`, `.MixedUnits*.cs`, `.DynamicProperties.cs`, `.SegmentAnalysis.cs`, `.PlanEditWords.cs`, `.PipeOops.cs`, `Services/ILinkService.cs`.
4. **Undo and redo plumbing:** `Services/LinkService.UndoTrace.cs`, `Services/PostUndoWriteWatch.cs`, `Services/RedoGapWatch.cs`, `Services/RedoWindowGuard.cs`, `Services/RedoDiagSwitches.cs`, `Services/OutsideCommandUndoPolicy.cs`, `Services/AtomicDrawingChangeRunner.cs`, `Models/DiagSettings.cs`.
5. **The command and outcome log, command-line words:** `Services/CommandOutcomeLogService.cs`, `Services/LoggingService.cs`, `Services/ILoggingService.cs`, `Services/LogFolderRedirect.cs`, `Services/CommandLineText.cs`, `Services/CommandWording.cs`, `Services/CommandErrorText.cs`, `Models/CdCommandLineSettings.cs`, `Commands/CeCommandBase.cs`, `Services/DrawingSafetyService.cs` (every command's pre-flight), `Services/IdleCommandGate.cs`, `Services/PerfTimingService.cs`.
6. **Labels and text:** `Services/PipeAnnotationTextFormatter.cs`, `Services/PitAnnotationTextFormatter.cs`, `Services/PipeEndAnnotationTextFormatter.cs`, `Services/TextService.cs`, `Services/LabelStyleService.cs`, `Models/LabelStyleData.cs`, `ViewModels/LabelWording.cs`, `Services/PlainNumberText.cs`.
7. **Layers, blocks, drawing access:** `Services/LayerService*`, `Services/CurrentLayerGuard.cs`, `Services/BlockService.cs`, `Services/DrawingService.cs`, `Services/IDrawingService.cs`, `Services/WorkingDatabaseScope.cs`, `Services/DatabaseIdentityComparer.cs`, `Services/UcsGuardService.cs`, `Services/UcsService.cs`, `Services/OsnapService.cs`, `Services/NearestOnlyOsnapScope.cs`.
8. **The overrules and CE's own pipe object** (they act on every pit and pipe on screen): `Services/*Overrule*.cs`, `Services/PipeOverruleService.cs`, `Services/Compound*`, `Services/NativeObjects/**`, `Services/PipeGeometry*`, `Services/PipeEntityService.cs`, `Services/PipeReadShare.cs`, `Services/DoubleClickHitTest.cs`.
9. **Load path, ribbon, bundle:** `PluginInitialization.cs`, `CeCvlModule.cs`, `GlobalUsings.cs`, `CE_CVL_SUITE.csproj` (any line other than the version), `Installer/**`, `Modules/*/Installer/**`, `Services/*Ribbon*`, `Services/CommandRegistryService.cs`, `Services/ICommandRegistry.cs`, `Services/CommandAliasService.cs`, `Services/AcadPgpAliasReader.cs`, `Services/CuiMenuGeneratorService.cs`, `Services/WorkspaceMenuInstallerService.cs`, `Services/ToolbarLayoutService.cs`, `Services/RuntimePathService.cs`, `Services/InstallIdentityService.cs`, `Assets/**`, `Resources/**`, `Themes/**`, `Properties/**`.
10. **Shared window parts** (every CE window): `Controls/CeEditorShell*`, `Controls/CeFieldRow*`, `Controls/AccessibleNames*`, `Controls/DarkTitleBarBehavior*`, `Controls/SearchableComboBox*`, `Controls/SelectAllBehavior*`, `Controls/StatusChip*`, `ViewModels/Shell/**`, `ViewModels/ViewModelBase.cs`, `ViewModels/RelayCommand.cs`, `Dialogs/Workshop*`, `Services/DialogService.cs`, `Services/WindowSizingService.cs`, `Services/CeWindow*`, `Services/ThemeService.cs`, `Services/CeTheme*`, `Services/InspectorPaletteService.cs`, `Controls/InspectorPanelControl*`, `ViewModels/InspectorViewModel*`.
11. **Other modules and repos:** `Shared/CE_SHARED/**`, `CE.AI.Core/**`, `CE.Cloud/**`, `Modules/Manager/**` (the Manager installs and loads CE), `Common/**` if one appears.
12. **Anything not listed in an area or here.** Unknown means FULL.

**Never counted as a change** (dropped before matching): `Modules/*.Tests/**`, `Modules/Arch.Tests.*/**`, `Tests/**`, `docs/**`, `*.md`, images; and `Installer/PackageContents.xml`, `Modules/Manager/Installer/PackageContents.xml`, `Modules/Drainage/CE_CVL_SUITE.csproj`, `Modules/Manager/CE_SUITE_MANAGER.csproj` **only when** `git diff -U0` shows nothing but the `<Version>` and `AppVersion=` lines (true for all four installs checked, section 5).

### 4. (c) The rule, as the robot job follows it after each install

1. **Read the two builds.** The installed DLL's product version (`3.0.NN+<commit>`) after the install, and the previous robot job's build line. The finalizer report `release-v3-colleagues-TRAIN_Cnn_FINALIZER_REPORT_<date>.md` names the train and its PRs.
2. **List the changed files:** `git diff --name-only <previous installed commit>..<new installed commit>` in the plugin repo (read only). If the previous installed commit is not an ancestor of the new one, stop: FULL.
3. **Drop** the never-counted files (end of section 3), after proving the four version files changed only their version lines.
4. **Match every remaining file.** SHARED: FULL, stop. A settings model: FULL unless Tim's switch ruling is yes AND the diff only adds new switch blocks. A file under `Modules/Drainage/Rules/`: take the areas of the files that call it (`git grep -l <ClassName> <new commit> -- Modules`); a caller in SHARED or in no area means FULL. Otherwise take every area whose patterns match. **No match: FULL.**
5. **Re-test set = the union of the matched areas' cases.** Run them as the weekend spec's lines filtered to that set: each case in an a line and a b line (two separate AutoCAD starts), DP and OF first in their start, the mouse cases together. **No twins** for a case whose file hash is unchanged (its twin already proved it can fail); a case whose file changed is a NEW acceptance and needs its twin and a fresh review as today.
6. **Any FAIL, FLAKY or BLOCKED in the re-test set: widen to FULL** in the next free window. A fix that broke its own area may have broken others.
7. **Record the decision** in the robot job report: the changed files, the area of each, PARTIAL or FULL, the re-tested cases and results, and the carried cases with "carried from <build>" (section 8).
8. **A carry lasts until the next full re-test** (Saturday, and before Max). A case may be carried across several installs; the label always names the build of its last two real passes.
9. **When unsure, FULL.** Tim's words: "Be conservative".

### 5. (d) The rule tried on the last four installs

Commits: C-71 `a2408a96` (3.0.81), C-72 `e30556ca` (3.0.82), C-73 `96455f13` (3.0.83), C-74 `94f521cc` (3.0.84), C-75 `09126560` (3.0.85). The four version files changed only their version lines every time.

1. **C-72 (3.0.81 to 3.0.82, 27 files, 10 product files after dropping tests and version files):** `Models/TabStartValueSettings.cs` (edits existing lines), `Services/SettingsSizingStandards.cs` (settings, speed limits for the checks), `Services/AutoDesignService.cs`, `Models/ConnectionPipeAssumption.cs`, three calculation view models, `Services/LinkService.RepairAudit.InvertPropagation.cs`. **Rule: FULL** (settings edits, plus files in no area).
2. **C-73 (3.0.82 to 3.0.83, 17 files):** `PluginInitialization.cs` (load path), `Services/LinkService.Reactors.cs` (core), `Services/PostUndoWriteWatch.cs`, `RedoGapWatch.cs`, `RedoDiagSwitches.cs` (undo plumbing), `Models/DiagSettings.cs`. **Rule: FULL.**
3. **C-74 (3.0.83 to 3.0.84, 13 files):** `Services/ProjectDataService.cs`, `.KeptRecords.cs`, `.Mutations.cs` (the pit and pipe record), `Services/LinkService.cs` (core), `Models/UserSettings.cs` (one new switch only), `Rules/ReopenedDrawingRecordRule.cs`. **Rule: FULL.**
4. **C-75 (3.0.84 to 3.0.85, 22 files, 10 product files):** `Commands/PipeEditCommand.DataCollection.cs` and `Rules/EditPipeReverseArrowReadRule.cs` (Edit Pipe); `Rules/RotateScaleCopyRule.cs`, `Services/CloneCleanupMessages.cs`, `Services/ExternalMutationCommandPolicy.cs`, `Services/LinkService.CloneRegeneration.cs` (copy and rotate); `Rules/SourcePickPipeRecordRule.cs`, `Services/LinkService.SourceLanding.cs` (sources; its changed parts are the landing index and receipts, used by DP, OF, the water tank and the source placement); `Models/UserSettings.cs` (four new switches only, 41 lines added, none removed).
   - **Under the rule as written: FULL** (the settings file changed).
   - **With the switch ruling (yes): PARTIAL.** Edit Pipe (7) + copy, move, rotate (23) + sources (3) = **32 checks re-tested, 34 carried from 3.0.84**. Estimated 206 min (about 3 h 25 min) against 400 min for the full set; 179 against 345 with the shorter safe wait. Example spec: `C:\ce-fx\retest\example_c75_partial.txt`, estimate `check_example_c75_partial.txt`.
5. **Would the rule have missed anything?** No. For C-72 to C-74 it gives FULL, so nothing could be missed. For C-75 the regrade (ledger item 26) found **0 failures, 0 flakes, 0 blocked on any counted case**; re-read now with `tally3.ps1`: 53 cases with two PASS sessions on 3.0.85 and an empty NON-PASS line (the other 13 had not run yet at 11:20). The runner reports for 3.0.82 to 3.0.84 do hold non-passes of now-accepted cases (R08 on all three; N05, N08, N15 to N22 on 3.0.83; R32, R32b, R33m on 3.0.83 and 3.0.84; some BLOCKED), but those are the REDO investigation, cases still being written, and the very faults C-75 fixed, on installs the rule would have re-tested in full anyway. I did not check each of those one by one.
6. **The honest saving so far:** one install in four, and only with the switch ruling. The rule pays when a train is a set of tool fixes (like C-75), not when it changes CE's core (like C-73 and C-74).

### 6. (e) What the rule cannot protect against

1. **Hidden links between tools.** The map is file by file. A fix in area A can change a shared value or a stored field that area B reads, without B's files changing. Example: an Edit Pipe fix that writes a pipe end's level in a new way; CDSYNC (area 5) reads that level, but no CDSYNC file changed, so the CDSYNC checks stay carried.
2. **Call chains the map does not list.** Most of CE's linking engine runs on every command; the core files are SHARED, but a "tool" file can still be called from elsewhere. Example: `LinkService.SourceLanding.cs` is also called from the copy code and from the core's `LinkService.Utilities.cs`; the map puts it in two areas, but a third caller added later would not be seen until the map is refreshed.
3. **AutoCAD state, not code.** A fix that changes timing (for example the order of work at the end of U) can upset a different check's REDO or Esc path. Only a run shows it.
4. **The checks themselves cover only parts of each tool.** A carried pass never proves more than the check did on the earlier build.
5. **The safety net:** the weekend full re-test runs all 66 checks on whatever is installed, so the longest a hidden break can sit carried is the working days since the last Saturday (or the pre-Max re-test). Any re-test failure also widens to FULL (rule step 6).
6. **The map goes stale.** New files appear every train. A new file matches no area, so it gives FULL (safe); the map should be refreshed when that keeps happening.

### 7. Task 2: the weekend full re-test spec

1. **File:** `C:\ce-fx\retest\spec_full_weekend.txt` (format of `c75regrade3\spec3.txt`; comment lines carry no bar). 23 lines: 11 a lines, the same 11 as b lines, and one extras line at the end (`xE|cases|R09,R22`, once; R08 is counted and already runs in aL and bL).
2. **How it is grouped:**
   - One plain AutoCAD start per line for the no-setting cases, reusing combinations that passed together on 3.0.85 (c75run spec_p2_1 to p2_6 and c1a1), merged to at most 4 SETUP cases and about 14 minutes of case time per start (the esc and reopen caps).
   - Each case with its own SETTING lines rides as a second start in a plain line's runner call (no chain gap between them): R14h_dstd_200 in F1, R14h_pipekey_200 in F2, R14h_both_200 in F3, R16 in F4, N27 in F5, N07 and N18 in F6, R34sn in L.
   - **DP and OF first:** N03 (ORDER 30) and N04 (ORDER 40) have the lowest ORDER in F1; the runner sorts by ORDER inside a start.
   - **Mouse line-ups:** R01, N05, N20 and N25 share F2 (the speed report's rule), R08 is in L: 2 line-ups per pass, 5 in all with R09.
3. **Checked by** `C:\ce-fx\retest\check_spec_full_weekend.ps1` (read only; the runner's `-Only` rule copied from `case_runner.ps1` line 425, the runner's grouping key, measured medians from the speed report). Output `check_spec_full_weekend_output.txt`: **66 of 66 counted cases covered once in a and once in b; no stray file matched; extras R09 and R22 only.** The checker found one fault in my first draft (a comment line holding bars would have been read as a job line by the chain) and it was fixed.
4. **Estimates (measured medians; stalls not included, real nights had four stalls over 20 minutes in the audit window):**
   - **This spec, today's 3-minute gap:** 38 starts, 5 line-ups, case time 251 min, overhead 83 min, 22 gaps: **about 400 min (6 h 40 min).**
   - **This spec with the staged 30-second safe wait (step 1):** **about 345 min (5 h 45 min).**
   - **The same 66 written today's way** (`spec_baseline_weekend_todaystyle.txt`, one line per setting case, never to be run): 44 starts, 11 line-ups: about 493 min (8 h 15 min), or 386 min with the short wait.
5. **Before running on Saturday:**
   - Re-run `eligible.ps1` (or the probe) first. The staged 29 Oct case apply changes some hashes (for example R33m); a case whose hash no longer matches its review drops out.
   - Use a copy of `chain3.ps1` with its build check changed from `3.0.85+*` to the installed build, its output folder set to `C:\ce-fx\retest`, and explicit `-StopFirst` and `-StopAll` times (its defaults are 07:50 and 08:10 the next morning, written for weeknights).
   - Weekends are free time on Tim's PC (RULES 1.8). The longest single start is about 22 minutes.

### 8. Task 3: the ledger label and the tally (proposal only, nothing edited)

1. **Ledger line, one per install, in `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`:**
   > NN. **Install re-test on Civil 3.0.86 (installed <date time>), robot job <name>, report <path>:** the install touched only <areas> (<k> changed files, listed in the report); those <n> cases passed in two separate AutoCAD starts on 3.0.86. The other <m> accepted cases were NOT re-run: **carried from 3.0.85+09126560** (two passes there, case files unchanged), counted as accepted until the full re-test on Sat 31 Oct: <ids>. Tim's rule of 29 Oct (decisions\2026-10-29_TIM_RETEST_RULE.md).
2. **The per-case label** wherever one case is named: `carried from 3.0.85+09126560`.
3. **The carry file (no ledger.json change):** the robot job writes `C:\CE_PLAN\areas\retest\CARRY_C3.0.86.txt`, one line per carried case: `N01_cdrebuild_warns_never_saves|carried from 3.0.85+09126560|install C-76|touched: Edit Pipe|until full re-test Sat 31 Oct`.
4. **The tally change (a copy of `tally3.ps1`, not applied):**
   ```powershell
   # proposal only: count a carried case as accepted but labelled (reads the carry file and the runner's own report JSON; never ledger.json)
   $cur = '3.0.86'
   $carry = @{}
   $cf = "C:\CE_PLAN\areas\retest\CARRY_C$cur.txt"
   if (Test-Path $cf) { foreach ($l in Get-Content $cf) { if ($l -match '^([^|#]+)\|carried from (\d+\.\d+\.\d+)\+(\w+)') { $carry[$matches[1]] = @{ build = $matches[2]; commit = $matches[3] } } } }
   # ... the existing loop fills $two / $one / $none for $cur ...
   $carried = @()
   foreach ($e in @($none + $one)) {
     if (-not $carry.ContainsKey($e)) { continue }
     $b = $carry[$e].build
     $rows = foreach ($f in Get-ChildItem $rep -Filter "RUN-*-C$b-*.json") { $j = Get-Content $f.FullName -Raw | ConvertFrom-Json
       if ($j.header.build_key -like "civil $b+$($carry[$e].commit)*") { $j.cases | Where-Object { $e -eq $_.id -or $e -like "$($_.id)_*" } } }
     $now = (Get-FileHash (Get-ChildItem 'C:\Lisp Files\_ACAD_DRIVER\cases' -Recurse -Filter "$e.case.txt" | Select-Object -First 1).FullName).Hash
     $ok = @($rows | Where-Object { $_.result -eq 'PASS' -and $_.file_sha256 -eq $now } | Select-Object -ExpandProperty session_id -Unique).Count -ge 2
     if ($ok) { $carried += "$e (carried from $b)" }
   }
   "CARRIED, COUNTED AS ACCEPTED BUT LABELLED ($($carried.Count)): $($carried -join ' ')"
   "COUNTED: $($two.Count) on $cur + $($carried.Count) carried"
   ```
   A carried case counts only if the carry file names it AND the named build still holds two PASS sessions at today's case hash. A case that failed on the new build is never carried (it is in the re-test set by rule step 6).

### 9. Files written by this job

1. `C:\CE_PLAN\areas\RETEST_AREA_MAP_29OCT.md` (this report, pushed).
2. `C:\ce-fx\retest\spec_full_weekend.txt` (Task 2) and its checker `check_spec_full_weekend.ps1` with output `check_spec_full_weekend_output.txt`.
3. `C:\ce-fx\retest\spec_baseline_weekend_todaystyle.txt` (comparison only, never to be run) and `check_baseline_output.txt`.
4. `C:\ce-fx\retest\example_editpipe.txt`, `example_c75_partial.txt` and their estimate files (examples only, never to be run).
5. `C:\ce-fx\retest\probe_eligible_and_commands.ps1`, `eligible_now.txt`, `case_commands.txt`, `probe_nonpass_by_build.ps1` (read-only probes); `acc.txt`, `acc_classes.tsv`, `cc.tsv` (working copies).

### 10. What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD, the runner or the driver.** Every hour figure is an estimate from measured medians (speed report `TESTING_SPEED_STEPS_1_2_STAGED_29OCT.md`), not a timed run. Stalls and reruns are not included.
2. **The new groupings F1 to F9 have not run together.** They are merges of groups that passed on 3.0.85, kept under the known caps, but a merged start can still hit an esc or reopen cap no one has seen.
3. **The area patterns were built from command owners and file names,** with spot checks of callers for the C-75 files only. I did not trace every call path; section 6 says what that misses.
4. **The older non-passes on 3.0.82 to 3.0.84** were classed from their run names and known history, not read one by one.
5. **The settings-switch exception is a proposal,** not a ruling. Until Tim answers, a settings model change means FULL.
6. **Structural and the no-case Civil tools** get only the launch-group load check. Whether Structural's DLL really shares the robot's AutoCAD start was not re-checked today.
7. **The staged case apply** (29 Oct) was not applied or re-hashed here; the weekend list must be recomputed on Saturday morning.

## Summary

The map sorts the 66 accepted checks into 17 tool areas and lists the shared code that forces a full re-test. A focused fix (Edit Pipe) re-tests 7 checks in about 1 hour instead of 6 h 40 min. But every fix adds a settings switch, so under the rule as written every install is still full: Tim's ruling is needed. On C-72 to C-75 the rule gives FULL three times and saves about half on C-75, missing nothing. The weekend spec covers all 66 twice in 38 starts: about 6 h 40 min, 5 h 45 min with the short wait.


---

## ADDENDUM 1 (29 Oct 2026, CE 02): Tim has answered the new-switch question: YES

Tim's words (decisions\2026-10-29_TIM_RETEST_RULE.md, Addendum 1): "yes. An Edit Pipe fix then re-tests 7 checks (about 1 hour) instead of all 66 (about 6 h 40 min)." So the rule in the procedure above ("A settings model: FULL unless Tim's switch ruling is yes AND the diff only adds new switch blocks") is now live. For every install the robot job states, before it runs anything, which of these applies:

1. **AREA re-test** only if the changed-files list touches no SHARED file and the only settings change is a brand-new switch with a new name added in a settings model file (for example `Models/UserSettings.cs`): confirm with `git diff <previous installed commit>..<new commit> -- <that file>` that every changed line is an ADDED line (a new property, default and doc comment) and none is an edited, renamed or removed existing line. Re-test the union of the touched areas' checks; record every other accepted check as 'carried from <build>'.
2. **FULL re-test** if any existing setting line is edited, renamed or removed (including default values and the sizing/start-value files such as `Models/TabStartValueSettings.cs` and `Services/SettingsSizingStandards.cs`, which edit existing lines), or any SHARED file is touched, or any changed file matches no area.
3. The robot job file names the decision ('AREA: added switch(es) only: <names>' or 'FULL: <reason>') and lists the carried checks. A new-switch decision is made by reading the diff, not by trusting the PR text.
4. The weekend full re-tests (Sat 31 Oct, Sat 7 Nov), the pre-pilot full re-test on the frozen build and the Max-like run stay as scheduled whatever the install rules say.

---

## Addendum 2 (29 Oct 2026 22:50): the smoke sets and Rule 14 live in RETEST_SMOKE_SETS.md (permanent, kept current by CE 02).
