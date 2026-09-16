# Shared controls — source-backed preservation ledger

FOR TIM

Start with the [whole-job journey](19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). This generated ledger is an inventory checklist, not a completed window contract. Rows without verified handler/consumer meaning remain unresolved. Retaining evidence of a control does not approve its exposure, its current side effects or a replacement layout. Read the linked action and approved-requirement companions before designing a window.

Existing fields and actions are preserved while the shared pages are reconciled. This ledger is supporting evidence, not a proposal to give every control its own page.

---

## Evidence limits

Each control below is a static source declaration. Values, runtime visibility, native behaviour and installed availability are not proven. Code-created dialogs remain separately reviewed. Later-owner controls do not erase older retained recovery routes.

## baseline — CeProjectSetupDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeProjectSetupDialog.xaml`.

SHA256: `62337ce8eeeb43dd5c6d11e34a9244d969e239f2ca0f56129ac87a61b3c3cde6`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 55 | TextBox | txtProjectRoot | IsReadOnly: True |
| 60 | ComboBox | cboProfiles | Owner semantics require inspection |
| 97 | TextBox | txtJobNumber | Owner semantics require inspection |
| 102 | TextBox | txtClientName | Owner semantics require inspection |
| 107 | TextBox | txtJobName | Owner semantics require inspection |
| 112 | TextBox | txtJobAddress | Owner semantics require inspection |
| 117 | TextBox | txtSuburb | Owner semantics require inspection |
| 122 | TextBox | txtDrawnBy | Owner semantics require inspection |
| 127 | TextBox | txtDesignedBy | Owner semantics require inspection |
| 143 | TextBox | txtInitialRevision | Owner semantics require inspection |
| 146 | TextBox | txtTitleSheetTitle | Owner semantics require inspection |
| 150 | TextBox | txtAdditionalSheetTitles | Owner semantics require inspection |
| 157 | CheckBox | chkSeedSharedTitleXref · Seed shared A1 title xref into the project Xref folder | IsChecked: True |
| 187 | Button | btnCreate · Create Setup | Owner semantics require inspection |
| 193 | Button | btnCancel · Cancel | Owner semantics require inspection |

## baseline — CeSheetsWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsWindow.xaml`.

SHA256: `7b17e16a14c451017261792fa9f7969893b1ef8e522ccf529059a17be1ab52fd`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 57 | TextBox | txtProjectRoot | IsReadOnly: True |
| 68 | Button | btnBrowse · Browse... | Click: BtnBrowse_Click |
| 73 | Button | btnScan · Scan | Click: BtnScan_Click |
| 105 | TextBox | txtJobNumber | Owner semantics require inspection |
| 108 | TextBox | txtClientName | Owner semantics require inspection |
| 111 | TextBox | txtJobAddress | Owner semantics require inspection |
| 114 | TextBox | txtSuburb | Owner semantics require inspection |
| 117 | TextBox | txtDrawnBy | Owner semantics require inspection |
| 120 | TextBox | txtDesignedBy | Owner semantics require inspection |
| 134 | TextBox | txtIssueDate | Owner semantics require inspection |
| 171 | ComboBox | cboDisciplineFilter | Owner semantics require inspection |
| 215 | DataGridCheckBoxColumn | Issue | Binding: {Binding IncludeInIssue, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 218 | DataGridTextColumn | Order | Binding: {Binding SheetOrder} · IsReadOnly: True |
| 222 | DataGridTextColumn | Sheet No | Binding: {Binding SheetNumber, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 225 | DataGridTextColumn | Sheet Title | Binding: {Binding SheetTitle, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 228 | DataGridTextColumn | Rev | Binding: {Binding CurrentRevision} · IsReadOnly: True |
| 232 | DataGridTextColumn | Disc | Binding: {Binding Discipline} · IsReadOnly: True |
| 236 | DataGridTextColumn | Layout | Binding: {Binding LayoutName} · IsReadOnly: True |
| 240 | DataGridTextColumn | Drawing | Binding: {Binding DwgPath} · IsReadOnly: True |
| 251 | Button | btnMoveUp · Move Up | Click: BtnMoveUp_Click |
| 256 | Button | btnMoveDown · Move Down | Click: BtnMoveDown_Click |
| 261 | Button | btnRenumber · Renumber Sheets | Click: BtnRenumber_Click |
| 277 | Button | btnUpdate · Update Drawings | Click: BtnUpdate_Click |
| 293 | Button | btnPublish · Publish Issue PDF | Click: BtnPublish_Click |
| 298 | Button | btnSave · Save | Click: BtnSave_Click |
| 337 | Button | btnClose · Close | Click: BtnClose_Click |

## baseline — CeSheetsManagerWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsManagerWindow.xaml`.

SHA256: `c8e6086bc570e2d885370425d82fd8bd26fbafbc88b1b9e67c76e5c33560d16c`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 56 | TextBox | txtProjectRoot | Owner semantics require inspection |
| 66 | Button | Browse... | Click: BtnBrowseProject_Click |
| 70 | Button | Open Folder | Click: BtnOpenProjectFolder_Click |
| 74 | Button | Setup Project | Click: BtnSetupProject_Click |
| 78 | Button | Scan Project | Click: BtnScanProject_Click |
| 85 | Button | Force Full Rescan | Click: BtnForceRescanProject_Click |
| 113 | TextBox | txtJobNumber | Owner semantics require inspection |
| 116 | TextBox | txtJobName | Owner semantics require inspection |
| 119 | TextBox | txtJobAddress | Owner semantics require inspection |
| 122 | TextBox | txtSuburb | Owner semantics require inspection |
| 125 | TextBox | txtClientName | Owner semantics require inspection |
| 128 | TextBox | txtDefaultDrawnBy | Owner semantics require inspection |
| 131 | TextBox | txtDefaultDesignedBy | Owner semantics require inspection |
| 147 | TextBox | txtIssueDate | Owner semantics require inspection |
| 150 | TextBox | txtIssueRevision | Owner semantics require inspection |
| 152 | CheckBox | chkCouncilApproval · For council approval | Owner semantics require inspection |
| 157 | TextBox | txtIssueFolderName | IsReadOnly: True |
| 161 | CheckBox | chkSyncLayoutNames · Rename layout tabs from the manager | IsChecked: True |
| 178 | ListBox | lstIssueHistory | Owner semantics require inspection |
| 190 | TextBox | txtIssueDiff | IsReadOnly: True · Visibility: Collapsed |
| 199 | Button | btnReissueFrom · Reissue from Selected | Click: BtnReissueFrom_Click |
| 236 | Button | Map Title Block | Click: BtnMapTitleBlock_Click |
| 244 | TextBox | txtHealthDetails | IsReadOnly: True |
| 269 | CheckBox | chkShowExcluded · Show excluded | Owner semantics require inspection |
| 275 | Button | Add To Issue | Click: BtnIncludeSelectedInIssue_Click |
| 276 | Button | Remove From Issue | Click: BtnExcludeSelectedFromIssue_Click |
| 277 | Button | Duplicate Selected | Click: BtnDuplicateSelected_Click |
| 278 | Button | Insert Before | Click: BtnInsertBefore_Click |
| 279 | Button | Insert After | Click: BtnInsertAfter_Click |
| 280 | Button | Exclude Selected | Click: BtnExcludeSelected_Click |
| 281 | Button | Manage Selected | Click: BtnManageSelected_Click |
| 282 | Button | Archive Selected | Click: BtnArchiveSelected_Click |
| 283 | Button | Renumber Sheets | Click: BtnRenumberSheets_Click |
| 284 | Button | Reconcile Files | Click: BtnReconcileFiles_Click |
| 285 | Button | Move Up | Click: BtnMoveUp_Click |
| 286 | Button | Move Down | Click: BtnMoveDown_Click |
| 287 | Button | Bump Revision | Click: BtnBumpRevision_Click |
| 302 | MenuItem | Set Drawn By for Selected… | Click: CtxSetField_Click |
| 303 | MenuItem | Set Designed By for Selected… | Click: CtxSetField_Click |
| 304 | MenuItem | Set Revision for Selected… | Click: CtxSetField_Click |
| 305 | MenuItem | Set Discipline for Selected… | Click: CtxSetField_Click |
| 307 | MenuItem | Bump Revision for Selected | Click: BtnBumpRevision_Click |
| 309 | MenuItem | Select by Discipline… | Click: CtxSelectByDiscipline_Click |
| 310 | MenuItem | Select All Managed | Click: CtxSelectAllManaged_Click |
| 312 | MenuItem | Renumber Selected from… | Click: CtxRenumberSelectedFrom_Click |
| 313 | MenuItem | Show Numbering Gaps | Click: CtxShowGaps_Click |
| 317 | DataGridTextColumn | Status | Binding: {Binding ManagementStatus} · IsReadOnly: True |
| 318 | DataGridTextColumn | Issue | Binding: {Binding IssueStatus} · IsReadOnly: True |
| 319 | DataGridTextColumn | Order | Binding: {Binding SheetOrder} |
| 320 | DataGridTextColumn | Sheet No | Binding: {Binding SheetNumber} |
| 321 | DataGridTextColumn | Sheet Title | Binding: {Binding SheetTitle} |
| 322 | DataGridTextColumn | Revision | Binding: {Binding CurrentRevision} |
| 323 | DataGridTextColumn | Drawn By | Binding: {Binding DrawnBy} |
| 324 | DataGridTextColumn | Designed By | Binding: {Binding DesignedBy} |
| 325 | DataGridTextColumn | Discipline | Binding: {Binding Discipline} · IsReadOnly: True |
| 326 | DataGridTextColumn | Layout Tab | Binding: {Binding LayoutTabName} |
| 327 | DataGridTextColumn | Layout | Binding: {Binding LayoutName} · IsReadOnly: True |
| 328 | DataGridTextColumn | Drawing Path | Binding: {Binding DwgPath} · IsReadOnly: True |
| 333 | Button | Save Manifest | Click: BtnSaveManifest_Click |
| 334 | Button | Sync Drawings | Click: BtnSyncDrawings_Click |
| 335 | Button | Map Title Block | Click: BtnMapTitleBlock_Click |
| 336 | Button | Preview Renames | Click: BtnPreviewRenames_Click |
| 337 | Button | Apply Renames | Click: BtnApplyRenames_Click |
| 338 | Button | Create Issue Snapshot | Click: BtnCreateIssue_Click |
| 339 | Button | Publish Issue PDFs | Click: BtnPublishIssue_Click |
| 340 | Button | Validate Project | Click: BtnValidateProject_Click |
| 368 | Button | btnCancelScan · Cancel Scan | Click: BtnCancelScan_Click · Visibility: Collapsed |
| 374 | Button | Close | Click: BtnClose_Click |

## baseline — CeSheetsSyncPreviewWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsSyncPreviewWindow.xaml`.

SHA256: `c5cf5aec6f50722862bdee46d2a316662c60cd64c49edb9443bfa0d9628f41f0`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 182 | Button | Cancel | Click: BtnCancel_Click |
| 187 | Button | btnApplySync · Apply Sync | Click: BtnApplySync_Click |

## baseline — CeSheetsValidationReportWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsValidationReportWindow.xaml`.

SHA256: `257df6deb1ca4a7367b4407779eaa6528abe0deb3a0247adf0937bd979421930`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 125 | DataGridTextColumn | Status | Binding: {Binding SeverityLabel} |
| 128 | DataGridTextColumn | Sheet # | Binding: {Binding SheetNumber} |
| 131 | DataGridTextColumn | Title | Binding: {Binding SheetTitle} |
| 134 | DataGridTextColumn | Drawing | Binding: {Binding DwgName} |
| 137 | DataGridTextColumn | Issues | Binding: {Binding IssueCount} |
| 212 | Button | Export Report... | Click: BtnExportReport_Click |
| 216 | Button | Close | Click: BtnClose_Click |

## baseline — CeSharedTitleMappingWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSharedTitleMappingWindow.xaml`.

SHA256: `9dc92e765bf4cb230db1b7e48e86aa672b5ecb991e67829b3cc9db6fd78a7b4b`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 63 | DataGridTextColumn | Candidate | Binding: {Binding CandidateLabel} · IsReadOnly: True |
| 64 | DataGridTextColumn | Block | Binding: {Binding OwnerBlockName} · IsReadOnly: True |
| 65 | DataGridTextColumn | Layer | Binding: {Binding LayerName} · IsReadOnly: True |
| 66 | DataGridTextColumn | Tag/Source | Binding: {Binding SourceName} · IsReadOnly: True |
| 67 | DataGridTextColumn | Sample | Binding: {Binding SampleText} · IsReadOnly: True |
| 68 | DataGridTextColumn | Scope | Binding: {Binding ScopeKind} |
| 69 | DataGridTextColumn | Field | Binding: {Binding FieldName} |
| 70 | DataGridTextColumn | Sheet | Binding: {Binding SheetNumber} |
| 71 | DataGridTextColumn | Revision | Binding: {Binding RevisionCode} |
| 72 | DataGridTextColumn | Discipline | Binding: {Binding DisciplineCode} |
| 73 | DataGridTextColumn | Mapping | Binding: {Binding MappingLabel} · IsReadOnly: True |
| 91 | CheckBox | chkSaveReusable · Save as reusable template mapping in CS_Settings.json | Owner semantics require inspection |
| 101 | Button | Clear Selected | Click: BtnClearSelected_Click |
| 105 | Button | Save Mapping | Click: BtnSave_Click |
| 112 | Button | Cancel | Click: BtnCancel_Click |

## baseline — CePropsDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CePropsDialog.xaml`.

SHA256: `6f91c1115f0471074147d7a9819c3bc2e7c35d82aba7fee474e2fda47f4014c1`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 73 | TextBox | txtDrawingPath | IsReadOnly: True |
| 84 | TextBox | txtProjectRoot | IsReadOnly: True |
| 119 | TextBox | txtJobNumber | Owner semantics require inspection |
| 122 | TextBox | txtJobName | Owner semantics require inspection |
| 125 | TextBox | txtJobAddress | Owner semantics require inspection |
| 128 | TextBox | txtSuburb | Owner semantics require inspection |
| 131 | TextBox | txtClientName | Owner semantics require inspection |
| 134 | TextBox | txtDefaultDrawnBy | Owner semantics require inspection |
| 137 | TextBox | txtDefaultDesignedBy | Owner semantics require inspection |
| 164 | TextBox | txtRevision | Owner semantics require inspection |
| 167 | TextBox | txtIssueDate | Owner semantics require inspection |
| 183 | CheckBox | chkUpdateManifest · Update CE project manifest for this drawing | Owner semantics require inspection |
| 188 | CheckBox | chkSyncProject · Sync managed project drawings now after save | Owner semantics require inspection |
| 215 | Button | Cancel | Click: BtnCancel_Click |
| 221 | Button | Save | Click: BtnSave_Click |

## baseline — CeIssuePublishDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeIssuePublishDialog.xaml`.

SHA256: `5e3e88f2e4cd3b5b5d6997545d187b23b990b6268711bd3174d85b913f9a3a6f`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 43 | TextBox | txtIssueDate | Owner semantics require inspection |
| 47 | CheckBox | chkCouncil · For council approval | Owner semantics require inspection |
| 56 | RadioButton | rbSeparate · Separate packs (a folder per discipline) | IsChecked: True |
| 61 | RadioButton | rbCombined · One combined pack (single folder) | Owner semantics require inspection |
| 89 | Button | btnPublish · Publish | Click: BtnPublish_Click |
| 98 | Button | btnCancel · Cancel | Click: BtnCancel_Click |

## baseline — CeSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSettingsDialog.xaml`.

SHA256: `a2424eef3636f4507bf7b2c4302d4fa78e2c0aa8a4f8861c83daa6510f8a1871`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 31 | Button | Reset Defaults | Click: OnResetDefaultsClick |
| 32 | Button | Cancel | Click: OnCancelClick |
| 33 | Button | Save | Click: OnSaveClick |
| 37 | TabItem | GeneralTab · General | Owner semantics require inspection |
| 41 | TextBox | DataFolderTextBox | Owner semantics require inspection |
| 42 | TextBox | UserNameTextBox | Owner semantics require inspection |
| 43 | ComboBox | DefaultTabComboBox | Owner semantics require inspection |
| 49 | ComboBox | PaletteDockComboBox | Owner semantics require inspection |
| 54 | ComboBox | ThemeComboBox | Owner semantics require inspection |
| 59 | TextBox | IdleTimeoutTextBox | Owner semantics require inspection |
| 60 | TextBox | LastPaletteWidthTextBox | Owner semantics require inspection |
| 61 | TextBox | FavoriteCommandsTextBox | Owner semantics require inspection |
| 62 | CheckBox | AutoResumeSessionCheckBox · Auto resume session | Owner semantics require inspection |
| 63 | CheckBox | ShowStatusBarTimerCheckBox · Show status bar timer | Owner semantics require inspection |
| 64 | CheckBox | ShowFloatingTimerCheckBox · Show floating timer | Owner semantics require inspection |
| 65 | CheckBox | ShowPaletteOnStartupCheckBox · Show palette on startup | Owner semantics require inspection |
| 70 | TabItem | BeamTab · Beam | Owner semantics require inspection |
| 94 | TextBox | BeamRegularOffsetTextBox | Owner semantics require inspection |
| 98 | TextBox | BeamMTextOffsetTextBox | Owner semantics require inspection |
| 102 | TextBox | BeamParallelToleranceTextBox | Owner semantics require inspection |
| 106 | TextBox | BeamSearchDistanceTextBox | Owner semantics require inspection |
| 110 | TextBox | BeamWindowDistanceTextBox | Owner semantics require inspection |
| 114 | TextBox | BeamWindowBandTextBox | Owner semantics require inspection |
| 118 | TextBox | BeamCenterToleranceTextBox | Owner semantics require inspection |
| 122 | TextBox | BeamOffsetMarginTextBox | Owner semantics require inspection |
| 128 | TextBox | SupportInsertOsmodeTextBox | Owner semantics require inspection |
| 132 | TextBox | SupportRotateOsmodeTextBox | Owner semantics require inspection |
| 136 | TextBox | SupportTextOsmodeTextBox | Owner semantics require inspection |
| 140 | CheckBox | BeamLinkingEnabledCheckBox · Enable beam linking (move/erase beam, supports &amp; text together) | Owner semantics require inspection |
| 144 | CheckBox | BeamUseInsideOutsidePromptCheckBox · Prompt once if no inside-points saved (J11 — recommended) | Owner semantics require inspection |
| 148 | CheckBox | BeamDiagnosticModeCheckBox · Diagnostic mode (writes one trace line per beam placement) | Owner semantics require inspection |
| 150 | CheckBox | BeamAutoOffsetCheckBox · Auto offset from xref context | Owner semantics require inspection |
| 151 | CheckBox | BeamAutoWallsCheckBox · Use walls for auto offset | Owner semantics require inspection |
| 152 | CheckBox | BeamAutoWindowsCheckBox · Use windows for auto offset | Owner semantics require inspection |
| 154 | CheckBox | BeamRememberChoicesCheckBox · Remember last choices | Owner semantics require inspection |
| 155 | CheckBox | BeamMergeCommandModesCheckBox · Merge 1/2/4 with 1A/2A/4A | Owner semantics require inspection |
| 156 | CheckBox | BeamSupportPreviewCheckBox · Support rotation preview | Owner semantics require inspection |
| 157 | CheckBox | BeamSupportCancelWholeCheckBox · ESC cancels whole support flow | Owner semantics require inspection |
| 174 | TextBox | BeamAdvancedMinReferenceSegmentLengthTextBox | Owner semantics require inspection |
| 179 | TextBox | BeamAdvancedMinWindowOffsetDriverSegmentLengthTextBox | Owner semantics require inspection |
| 184 | TextBox | BeamAdvancedWallAssemblyGapToleranceTextBox | Owner semantics require inspection |
| 202 | TextBox | BeamAdvancedEndpointAutoTrimPerpendicularToleranceDegTextBox | Owner semantics require inspection |
| 207 | TextBox | BeamAdvancedEndpointAutoTrimPointToleranceTextBox | Owner semantics require inspection |
| 212 | TextBox | BeamAdvancedEndpointAutoTrimSearchDistanceTextBox | Owner semantics require inspection |
| 219 | TextBox | BeamAdvancedCandidateTPositionsCsvTextBox | Owner semantics require inspection |
| 234 | TextBox | BeamAdvancedPreviewMarkerSizeTextBox | Owner semantics require inspection |
| 251 | TextBox | BeamAdvancedLintelPrefixesCsvTextBox | Owner semantics require inspection |
| 256 | TextBox | BeamAdvancedXrefScanLayerPatternsCsvTextBox | Owner semantics require inspection |
| 274 | TextBox | BeamAdvancedMigrateSupportEndpointToleranceTextBox | Owner semantics require inspection |
| 279 | TextBox | BeamAdvancedMigrateTextProximityToleranceParallelTextBox | Owner semantics require inspection |
| 284 | TextBox | BeamAdvancedMigrateTextProximityToleranceAlongTextBox | Owner semantics require inspection |
| 294 | TabItem | JointTab · CJ / SSC | Owner semantics require inspection |
| 296 | TextBox | JointBaseOffsetTextBox | Owner semantics require inspection |
| 297 | TextBox | JointCollisionMarginTextBox | Owner semantics require inspection |
| 298 | CheckBox | JointAutoSideCheckBox · Auto choose clean side | Owner semantics require inspection |
| 299 | CheckBox | JointPromptAmbiguousCheckBox · Prompt when ambiguous | Owner semantics require inspection |
| 303 | TabItem | SupportsTab · Supports | Owner semantics require inspection |
| 305 | CheckBox | SupportAutoDetectSideCheckBox · Auto detect support text side | Owner semantics require inspection |
| 309 | TabItem | BracingTab · Bracing | Owner semantics require inspection |
| 311 | CheckBox | BracingSkipFlipPromptCheckBox · Skip flip prompt when decisive | Owner semantics require inspection |
| 315 | TabItem | RafterJoistTab · Rafter / Joist | Owner semantics require inspection |
| 317 | TextBox | RjClashRadiusTextBox | Owner semantics require inspection |
| 318 | TextBox | RjSnapToleranceTextBox | Owner semantics require inspection |
| 319 | TextBox | RjLastR1TextBox | Owner semantics require inspection |
| 320 | TextBox | RjLastFj1TextBox | Owner semantics require inspection |
| 321 | TextBox | RjLastP1TextBox | Owner semantics require inspection |
| 322 | CheckBox | RjAutoPlacementCheckBox · Enable auto placement | Owner semantics require inspection |
| 323 | CheckBox | RjDebugLoggingCheckBox · Enable debug logging | Owner semantics require inspection |
| 327 | TabItem | RebarTab · Rebar | Owner semantics require inspection |
| 329 | TextBox | RebarSizeTextBox | Owner semantics require inspection |
| 330 | TextBox | RebarSpacingTextBox | Owner semantics require inspection |
| 331 | TextBox | RebarZoneTextBox | Owner semantics require inspection |
| 332 | TextBox | RebarCountTextBox | Owner semantics require inspection |
| 333 | TextBox | RebarLengthTextBox | Owner semantics require inspection |
| 334 | TextBox | RebarQuantityTextBox | Owner semantics require inspection |
| 335 | TextBox | RebarExportPathTextBox | Owner semantics require inspection |
| 339 | TabItem | AnnotationTab · Annotation | Owner semantics require inspection |
| 341 | TextBox | AnnotationLevelTypeTextBox | Owner semantics require inspection |
| 342 | TextBox | AnnotationSectionDirectionTextBox | Owner semantics require inspection |
| 343 | TextBox | AnnotationArcDimTypeTextBox | Owner semantics require inspection |
| 347 | TabItem | XrefLayerTab · Xref Layer | Owner semantics require inspection |
| 349 | TextBox | XrefTargetLayerTextBox | Owner semantics require inspection |
| 350 | TextBox | XrefColorTextBox | Owner semantics require inspection |
| 351 | TextBox | XrefLinetypeTextBox | Owner semantics require inspection |
| 355 | TabItem | SystemTab · System | Owner semantics require inspection |
| 358 | TextBox | DiagnosticsThresholdTextBox | Owner semantics require inspection |
| 359 | TextBox | AutoSaveIntervalTextBox | Owner semantics require inspection |
| 360 | TextBox | AutoSaveIdleDelayTextBox | Owner semantics require inspection |
| 361 | TextBox | AutoSaveMaxCopiesTextBox | Owner semantics require inspection |
| 362 | TextBox | AutoSaveBackupRootTextBox | Owner semantics require inspection |
| 363 | CheckBox | OptionsDebugLoggingCheckBox · Enable global debug logging | Owner semantics require inspection |
| 364 | CheckBox | DiagnosticsEnabledCheckBox · Enable diagnostics | Owner semantics require inspection |
| 365 | CheckBox | VerboseDiagnosticsCheckBox · Enable verbose diagnostics | Owner semantics require inspection |
| 366 | CheckBox | AutoSaveEnabledCheckBox · Enable autosave | Owner semantics require inspection |
| 367 | CheckBox | AutoSaveWriteBackupsCheckBox · Write rolling backups | Owner semantics require inspection |
| 368 | CheckBox | AutoSaveEchoCheckBox · Echo saves to command line | Owner semantics require inspection |
| 369 | TextBox | InstallPackageVersionTextBox | IsReadOnly: True |
| 370 | TextBox | InstallBundleRootTextBox | IsReadOnly: True |
| 371 | TextBox | InstallRuntimeAssemblyTextBox | IsReadOnly: True |
| 372 | TextBox | InstallSharedAssetsTextBox | IsReadOnly: True |
| 373 | TextBox | InstallWorkspaceCuixTextBox | IsReadOnly: True |
| 378 | TabItem | DataAutomationTab · Data / Automation | Owner semantics require inspection |
| 381 | TextBox | ExcelLastFolderTextBox | Owner semantics require inspection |
| 382 | TextBox | ExcelProjectSessionTextBox | Owner semantics require inspection |
| 383 | TextBox | ExcelSourceFileTextBox | Owner semantics require inspection |
| 384 | TextBox | ExcelPlacementModeTextBox | Owner semantics require inspection |
| 385 | TextBox | ExcelPreferredColumnsTextBox | Owner semantics require inspection |
| 386 | TextBox | ExcelRowsPerColumnTextBox | Owner semantics require inspection |
| 387 | TextBox | ExcelFloorGapTextBox | Owner semantics require inspection |
| 388 | TextBox | ExcelTextOffsetXTextBox | Owner semantics require inspection |
| 389 | TextBox | ExcelTextOffsetYTextBox | Owner semantics require inspection |
| 390 | TextBox | ExcelMinimumDistanceTextBox | Owner semantics require inspection |
| 391 | TextBox | ExcelScheduleBlockNameTextBox | Owner semantics require inspection |
| 392 | TextBox | ExcelScheduleBlockFileTextBox | Owner semantics require inspection |
| 393 | CheckBox | ExcelAdaptiveLearningCheckBox · Enable adaptive learning | Owner semantics require inspection |
| 394 | CheckBox | ExcelInsertScheduleBlocksCheckBox · Insert schedule blocks | Owner semantics require inspection |
| 395 | CheckBox | ExcelAuxWipeoutCheckBox · Use auxiliary wipeouts | Owner semantics require inspection |
| 396 | CheckBox | ExcelStaticGeometryCheckBox · Convert blocks to static geometry | Owner semantics require inspection |
| 397 | CheckBox | ExcelMarkPrefixRulesCheckBox · Use mark prefix rules | Owner semantics require inspection |
| 398 | CheckBox | ExcelMezzanineCheckBox · Use second floor label for mezzanine | Owner semantics require inspection |
| 399 | CheckBox | ExcelCombineRoofCheckBox · Combine roof and first floor schedules | Owner semantics require inspection |
| 400 | CheckBox | ExcelDuplicateAuditCheckBox · Enable duplicate mark audit | Owner semantics require inspection |
| 401 | CheckBox | ExcelAuditOnlyCheckBox · Audit only | Owner semantics require inspection |
| 402 | TextBox | XclmLastFolderTextBox | Owner semantics require inspection |
| 403 | TextBox | XclmProjectSessionTextBox | Owner semantics require inspection |
| 404 | TextBox | XclmSourceFileTextBox | Owner semantics require inspection |
| 405 | TextBox | XclmAutoApplyThresholdTextBox | Owner semantics require inspection |
| 406 | TextBox | XclmReviewThresholdTextBox | Owner semantics require inspection |
| 407 | CheckBox | XclmBackgroundRefreshCheckBox · Background refresh enabled | Owner semantics require inspection |
| 408 | CheckBox | XclmPreferPdfCheckBox · Prefer member schedule PDF | Owner semantics require inspection |
| 409 | TextBox | MarkupLastFolderTextBox | Owner semantics require inspection |
| 410 | TextBox | MarkupApiKeyEnvTextBox | Owner semantics require inspection |
| 411 | TextBox | MarkupBaseUrlTextBox | Owner semantics require inspection |
| 412 | TextBox | MarkupModelTextBox | Owner semantics require inspection |
| 413 | TextBox | MarkupThresholdTextBox | Owner semantics require inspection |
| 414 | TextBox | MarkupArchitectIdTextBox | Owner semantics require inspection |
| 415 | TextBox | MarkupDrafterIdTextBox | Owner semantics require inspection |
| 416 | TextBox | MarkupPythonTextBox | Owner semantics require inspection |
| 417 | TextBox | MarkupWorkerTimeoutTextBox | Owner semantics require inspection |
| 418 | CheckBox | MarkupEnabledCheckBox · Enable MarkupAI | Owner semantics require inspection |
| 419 | CheckBox | MarkupCivilOntologyCheckBox · Include civil ontology | Owner semantics require inspection |
| 420 | CheckBox | MarkupLearningOptInCheckBox · Learning data opt in | Owner semantics require inspection |
| 421 | CheckBox | MarkupSaveProjectFolderCheckBox · Save packages to project folder | Owner semantics require inspection |
| 422 | CheckBox | MarkupBootstrapWorkerCheckBox · Auto bootstrap worker | Owner semantics require inspection |
| 423 | CheckBox | MarkupChatEnabledCheckBox · Enable chat | Owner semantics require inspection |

## baseline — SettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\SettingsDialog.xaml`.

SHA256: `6df6c06e44f40302b9f93823e0c52c9526ebc8ef5c79c0c99ad54a1c8f303b96`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 60 | TextBox | txtIdleTimeout | Text: 5 |
| 67 | CheckBox | chkAutoResumeSession · Auto-resume session when returning from idle | Owner semantics require inspection |
| 71 | CheckBox | chkShowStatusBarTimer · Show timer in AutoCAD status bar | Owner semantics require inspection |
| 75 | CheckBox | chkShowFloatingTimer · Show floating timer window | Owner semantics require inspection |
| 99 | ComboBox | cboDefaultTab | Owner semantics require inspection |
| 116 | ComboBox | cboPaletteDock | Owner semantics require inspection |
| 132 | ComboBox | cboTheme | Owner semantics require inspection |
| 159 | TextBox | txtUserName | Owner semantics require inspection |
| 180 | TextBox | txtDataFolder | IsReadOnly: True |
| 185 | Button | Browse... | Click: BtnBrowseDataFolder_Click |
| 210 | Button | Reset to Defaults | Click: BtnResetDefaults_Click |
| 214 | Button | About | Click: BtnAbout_Click |
| 220 | Button | Save | Click: BtnSave_Click |
| 228 | Button | Cancel | Click: BtnCancel_Click |

## baseline — AdvancedSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\AdvancedSettingsDialog.xaml`.

SHA256: `9f74d9e830c74b4e6aca0c077a347ecb1dc3b8762d4053141c3a139064e67c53`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 37 | ComboBox | (unnamed) | ItemsSource: {Binding InvertPositionOptions} · SelectedItem: {Binding DefaultInvertPosition} |
| 43 | ComboBox | (unnamed) | ItemsSource: {Binding MirrorOptions} · SelectedItem: {Binding DefaultMirror} |
| 62 | TextBox | (unnamed) | Text: {Binding InvertInwardDistance, UpdateSourceTrigger=PropertyChanged} |
| 69 | TextBox | (unnamed) | Text: {Binding InvertMaskOffsetMm, UpdateSourceTrigger=PropertyChanged} |
| 95 | TextBox | (unnamed) | Text: {Binding DefaultMinimumGrade, UpdateSourceTrigger=PropertyChanged} |
| 102 | TextBox | (unnamed) | Text: {Binding DefaultStandardGrade, UpdateSourceTrigger=PropertyChanged} |
| 121 | TextBox | (unnamed) | Text: {Binding CalculatedInvertDecimals, UpdateSourceTrigger=PropertyChanged} |
| 127 | TextBox | (unnamed) | Text: {Binding MinOutletDropMm, UpdateSourceTrigger=PropertyChanged} |
| 135 | CheckBox | Remember last Quick Mode settings | IsChecked: {Binding RememberQuickMode} |
| 138 | CheckBox | Default Auto-zoom in CD | IsChecked: {Binding DefaultAutoZoom} |
| 146 | Button | Open OSNAP Settings | Command: {Binding OsnapCommand} |
| 170 | TextBox | (unnamed) | Text: {Binding DsMinimumPipeGrade, UpdateSourceTrigger=PropertyChanged} |
| 176 | TextBox | (unnamed) | Text: {Binding DsMaximumPipeVelocity, UpdateSourceTrigger=PropertyChanged} |
| 182 | TextBox | (unnamed) | Text: {Binding DsMinimumCoverDepth, UpdateSourceTrigger=PropertyChanged} |
| 188 | TextBox | (unnamed) | Text: {Binding DsLpdPitIdentifier, UpdateSourceTrigger=PropertyChanged} |
| 194 | TextBox | (unnamed) | Text: {Binding DsMaxPipeRunLength, UpdateSourceTrigger=PropertyChanged} |
| 222 | ComboBox | (unnamed) | ItemsSource: {Binding SurveyWorkflowModeOptions} · SelectedItem: {Binding SurveyWorkflowMode} |
| 229 | TextBox | (unnamed) | Text: {Binding SurveyRlToleranceMm, UpdateSourceTrigger=PropertyChanged} |
| 243 | ComboBox | (unnamed) | ItemsSource: {Binding ThemeOptions} · SelectedItem: {Binding SelectedTheme} |
| 251 | CheckBox | Use step-by-step wizard mode | IsChecked: {Binding UseStepByStepCdMode} |
| 254 | CheckBox | Draw pipe run before options dialog (CD) | IsChecked: {Binding CdDrawFirst} |
| 262 | CheckBox | Enable diagnostic logging | IsChecked: {Binding DebugLogging} |
| 276 | Button | Reset to Defaults | Command: {Binding ResetCommand} |
| 281 | Button | Cancel | Command: {Binding CancelCommand} |
| 287 | Button | OK | Command: {Binding OkCommand} |

## baseline — OsnapSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\OsnapSettingsDialog.xaml`.

SHA256: `63d3c495403ab4972a7294725fd602b5008fb4e671db23919bbade5e20d64f53`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 75 | CheckBox | {Binding Name} · {Binding Name} | IsChecked: {Binding DrawingEnabled} |
| 87 | Button | Use current AutoCAD | Command: {Binding UseCurrentForDrawingCommand} |
| 91 | Button | All On | Command: {Binding DrawingAllOnCommand} |
| 95 | Button | All Off | Command: {Binding DrawingAllOffCommand} |
| 126 | CheckBox | {Binding Name} · {Binding Name} | IsChecked: {Binding TextEnabled} |
| 138 | Button | Use current AutoCAD | Command: {Binding UseCurrentForTextCommand} |
| 142 | Button | All On | Command: {Binding TextAllOnCommand} |
| 146 | Button | All Off | Command: {Binding TextAllOffCommand} |
| 164 | Button | Restore CE Defaults | Command: {Binding ResetDefaultsCommand} |
| 169 | Button | Cancel | Command: {Binding CancelCommand} |
| 176 | Button | Save + Use Drawing Now | Command: {Binding ApplyCommand} |
| 183 | Button | Save &amp; Close | Command: {Binding OkCommand} |

## baseline — HelpGuideWindow.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\HelpGuideWindow.xaml`.

SHA256: `98ee0ab90011fd2ef74b66ae7aec3054b5149a6e753089fb2f3d7e2692d1fe25`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 36 | Button | OpenInBrowserButton · Open in default browser | Click: OnOpenInBrowser |

## baseline — CdHelpDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\CdHelpDialog.xaml`.

SHA256: `34418bd6612c09d3950b7702f9ac8fd2afcb0156e707a8ca34d7d628777c79e3`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 47 | Button | Open CE Suite Manager | Click: OnRunCommand |
| 110 | Button | Pipe Layout (CD) | Click: OnRunCommand |
| 111 | Button | Pit Layout (PIT) | Click: OnRunCommand |
| 112 | Button | Edit Existing (CDEDIT) | Click: OnRunCommand |
| 113 | Button | Pit Schedule | Click: OnRunCommand |
| 114 | Button | Design Check | Click: OnRunCommand |
| 115 | Button | Long. Profile | Click: OnRunCommand |
| 116 | Button | Inspector | Click: OnRunCommand |
| 117 | Button | Repair Center | Click: OnRunCommand |
| 190 | Button | Close | Click: OnClose |

## baseline — PluginManagerWindow.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Manager\UI\Dialogs\PluginManagerWindow.xaml`.

SHA256: `46be2a5177d8bc06caa06fda51d670bdb9f9e1824f95c8ba13df9840197dfc45`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 205 | Button | Open Hub | Click: BtnOpenHub_Click |
| 211 | Button | Open Help | Click: BtnOpenHelp_Click |
| 218 | Button | {Binding SettingsButtonLabel} | Click: BtnSettings_Click |
| 224 | Button | Open Repair | Click: BtnOpenRepair_Click |
| 231 | Button | View Commands | Click: BtnViewCommands_Click |
| 237 | Button | BtnToggle · {Binding ToggleButtonLabel} | Click: BtnToggle_Click |
| 248 | Button | Load Now | Click: BtnLoad_Click · Visibility: {Binding CanLoadNow, Converter={StaticResource BoolToVis}} |
| 255 | Button | {Binding InstallButtonLabel} | Click: BtnInstall_Click · Visibility: {Binding CanInstallOrUpdate, Converter={StaticResource BoolToVis}} |
| 262 | Button | View History | Click: BtnViewHistory_Click · Visibility: {Binding HasUpdateNotes, Converter={StaticResource BoolToVis}} |
| 268 | Button | View Superseded | Click: BtnViewSuperseded_Click · Visibility: {Binding HasSupersededBuilds, Converter={StaticResource BoolToVis}} |
| 335 | Button | btnAdminDashboard · Admin Dashboard | Click: BtnAdminDashboard_Click · Visibility: Collapsed |
| 348 | Button | ⟳  Refresh | Click: BtnRefresh_Click |
| 464 | Button | btnUploadTelemetry · Upload Pending Admin Data | Click: BtnUploadTelemetry_Click |
| 479 | Button | btnSendDiagnostics · ⬆  Send Diagnostics | Click: BtnSendDiagnostics_Click |

## baseline — PluginAdminWindow.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Manager\UI\Dialogs\PluginAdminWindow.xaml`.

SHA256: `4c08a9c5e0ce91394c4b8e7aaf699562951ed6186e74ff39bdc119a7ddcd85e7`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 48 | Button | Publish to Azure | Click: BtnPublishToAzure_Click |
| 52 | Button | Upload Pending | Click: BtnUploadPending_Click |
| 56 | Button | Create Support Bundle | Click: BtnCreateBundle_Click |
| 60 | Button | BtnRefresh · Refresh | Click: BtnRefresh_Click |
| 123 | TabItem | tabOverview · Overview | Owner semantics require inspection |
| 142 | TabItem | tabMachines · Machines | Owner semantics require inspection |
| 148 | DataGridTextColumn | User | Binding: {Binding UserName} |
| 149 | DataGridTextColumn | Machine | Binding: {Binding MachineName} |
| 150 | DataGridTextColumn | Last Seen | Binding: {Binding LastSeenLocal} |
| 151 | DataGridTextColumn | AutoCAD | Binding: {Binding AutoCadVersion} |
| 152 | DataGridTextColumn | Restart | Binding: {Binding RestartState} |
| 153 | DataGridTextColumn | Health | Binding: {Binding HealthState} |
| 154 | DataGridTextColumn | Versions | Binding: {Binding PluginVersions} |
| 159 | TabItem | tabUsage · Usage | Owner semantics require inspection |
| 166 | TabItem | tabFailures · Failures | Owner semantics require inspection |
| 174 | MenuItem | Mark as Investigated | Click: MnuAcknowledgeFailure_Click |
| 178 | DataGridTextColumn | Time | Binding: {Binding LocalTime} |
| 179 | DataGridTextColumn | Severity | Binding: {Binding Severity} |
| 180 | DataGridTextColumn | User | Binding: {Binding UserName} |
| 181 | DataGridTextColumn | Machine | Binding: {Binding MachineName} |
| 182 | DataGridTextColumn | Plugin | Binding: {Binding PluginId} |
| 183 | DataGridTextColumn | Category | Binding: {Binding Category} |
| 184 | DataGridTextColumn | Type | Binding: {Binding Type} |
| 185 | DataGridTextColumn | Message | Binding: {Binding Message} |
| 206 | TabItem | tabUpdates · Updates | Owner semantics require inspection |
| 213 | Button | Approve Available Build | Click: BtnApproveAvailable_Click |
| 217 | Button | Roll Back Approved Release | Click: BtnRollbackApproved_Click |
| 221 | Button | Canary Rollout... | Click: BtnCanaryRollout_Click |
| 225 | Button | Promote to All | Click: BtnPromoteToAll_Click |
| 236 | TabItem | tabSupportBundles · Support Bundles | Owner semantics require inspection |
| 243 | TabItem | tabPolicies · Policies | Owner semantics require inspection |

## baseline — FeedbackDialog.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\FeedbackDialog.xaml`.

SHA256: `c8374080fddbabc82d7d1b156ef753b41ac4b447d2a33d624bf1cfb96ae5fa16`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 59 | RadioButton | Bug report | IsChecked: {Binding IsTypeBug} |
| 62 | RadioButton | Suggestion / feature request | IsChecked: {Binding IsTypeSuggestion} |
| 69 | TextBox | (unnamed) | Text: {Binding Title, UpdateSourceTrigger=PropertyChanged} |
| 76 | TextBox | (unnamed) | Text: {Binding Description, UpdateSourceTrigger=PropertyChanged} |
| 148 | Button | Submit | Click: OnSubmit |
| 156 | Button | Cancel | Click: OnCancel |

## baseline — WhatsNewDialog.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\WhatsNewDialog.xaml`.

SHA256: `328e7642390c391eb2f01cfda8efa744abf664252b56bcb13444fe2d7382230f`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 75 | Button | How To Guide | Click: OnHowToGuide |
| 81 | Button | Got It | Click: OnGotIt |

## baseline — CeAssistantControl.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\Controls\CeAssistantControl.xaml`.

SHA256: `4c67186c9fe652753259ba250a932527fd77b827b70b9a59ff7884c8704c50b2`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 144 | Button | AnalyzeMarkupsButton · Analyse markups | Click: AnalyzeMarkupsButton_Click |
| 156 | Button | AnalyzeFromFileButton · From file… | Click: AnalyzeFromFileButton_Click |
| 168 | Button | ReviewChangesButton · {Binding ReviewChangesButtonText} | Click: ReviewChangesButton_Click · Visibility: {Binding HasPendingMarkupPlan, Converter={StaticResource BoolToVis}} |
| 184 | TextBox | InputBox | Text: {Binding InputText, UpdateSourceTrigger=PropertyChanged} |
| 201 | Button | SendButton · Send | Click: SendButton_Click |
| 208 | Button | (unnamed) | Owner semantics require inspection |

## baseline — MarkupAIPanel.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\UI\Palette\MarkupAIPanel.xaml`.

SHA256: `a2a6e4d4253d2fa89b3464db01143b8289caa649a30068d51940f41d0dc60e72`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 50 | TextBox | txtPdfPath | Owner semantics require inspection |
| 51 | Button | Browse... | Click: BtnBrowsePdf_Click |
| 52 | Button | Parse | Click: BtnParse_Click |
| 56 | ComboBox | cmbSourceMode | Owner semantics require inspection |
| 62 | ComboBox | cmbProjectType | Owner semantics require inspection |
| 69 | Button | Load... | Click: BtnLoadPackage_Click |
| 70 | Button | Replan | Click: BtnReplan_Click |
| 71 | Button | Save | Click: BtnSave_Click |
| 92 | DataGridCheckBoxColumn | OK | Binding: {Binding IsApproved} |
| 93 | DataGridTextColumn | Page | Binding: {Binding Page} |
| 94 | DataGridTextColumn | Source | Binding: {Binding Source} |
| 95 | DataGridTextColumn | Type | Binding: {Binding Intent} |
| 96 | DataGridTextColumn | Text | Binding: {Binding Text} |
| 97 | DataGridTextColumn | Conf | Binding: {Binding Confidence} |
| 98 | DataGridTextColumn | Exec | Binding: {Binding Executor} |
| 99 | DataGridTextColumn | Place | Binding: {Binding PlacementReady} |
| 100 | DataGridTextColumn | Command | Binding: {Binding Command} |
| 101 | DataGridTextColumn | Reason | Binding: {Binding ExecutorReason} |
| 102 | DataGridTextColumn | Group | Binding: {Binding GroupKey} |
| 103 | DataGridTextColumn | SubBatch | Binding: {Binding SubBatchKey} |
| 104 | DataGridTextColumn | Status | Binding: {Binding Status} |
| 109 | Button | Visual Preview | Click: BtnVisualPreview_Click |
| 110 | Button | Approve Selected | Click: BtnApproveSelected_Click |
| 111 | Button | Reject Selected | Click: BtnRejectSelected_Click |
| 112 | Button | Preview Next | Click: BtnPreviewNext_Click |
| 113 | Button | Run Next Group | Click: BtnRunNext_Click |
| 114 | Button | Undo Last Group | Click: BtnUndoLast_Click |
| 115 | Button | Refresh | Click: BtnRefresh_Click |
| 132 | TextBox | txtChatPrompt | Owner semantics require inspection |
| 133 | Button | Ask AI | Click: BtnAskAi_Click |
| 134 | Button | Apply Suggestions | Click: BtnApplyAi_Click |

## shared-owner — CeProjectSetupDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeProjectSetupDialog.xaml`.

SHA256: `62337ce8eeeb43dd5c6d11e34a9244d969e239f2ca0f56129ac87a61b3c3cde6`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 55 | TextBox | txtProjectRoot | IsReadOnly: True |
| 60 | ComboBox | cboProfiles | Owner semantics require inspection |
| 97 | TextBox | txtJobNumber | Owner semantics require inspection |
| 102 | TextBox | txtClientName | Owner semantics require inspection |
| 107 | TextBox | txtJobName | Owner semantics require inspection |
| 112 | TextBox | txtJobAddress | Owner semantics require inspection |
| 117 | TextBox | txtSuburb | Owner semantics require inspection |
| 122 | TextBox | txtDrawnBy | Owner semantics require inspection |
| 127 | TextBox | txtDesignedBy | Owner semantics require inspection |
| 143 | TextBox | txtInitialRevision | Owner semantics require inspection |
| 146 | TextBox | txtTitleSheetTitle | Owner semantics require inspection |
| 150 | TextBox | txtAdditionalSheetTitles | Owner semantics require inspection |
| 157 | CheckBox | chkSeedSharedTitleXref · Seed shared A1 title xref into the project Xref folder | IsChecked: True |
| 187 | Button | btnCreate · Create Setup | Owner semantics require inspection |
| 193 | Button | btnCancel · Cancel | Owner semantics require inspection |

## shared-owner — CeSheetsWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsWindow.xaml`.

SHA256: `7b17e16a14c451017261792fa9f7969893b1ef8e522ccf529059a17be1ab52fd`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 57 | TextBox | txtProjectRoot | IsReadOnly: True |
| 68 | Button | btnBrowse · Browse... | Click: BtnBrowse_Click |
| 73 | Button | btnScan · Scan | Click: BtnScan_Click |
| 105 | TextBox | txtJobNumber | Owner semantics require inspection |
| 108 | TextBox | txtClientName | Owner semantics require inspection |
| 111 | TextBox | txtJobAddress | Owner semantics require inspection |
| 114 | TextBox | txtSuburb | Owner semantics require inspection |
| 117 | TextBox | txtDrawnBy | Owner semantics require inspection |
| 120 | TextBox | txtDesignedBy | Owner semantics require inspection |
| 134 | TextBox | txtIssueDate | Owner semantics require inspection |
| 171 | ComboBox | cboDisciplineFilter | Owner semantics require inspection |
| 215 | DataGridCheckBoxColumn | Issue | Binding: {Binding IncludeInIssue, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 218 | DataGridTextColumn | Order | Binding: {Binding SheetOrder} · IsReadOnly: True |
| 222 | DataGridTextColumn | Sheet No | Binding: {Binding SheetNumber, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 225 | DataGridTextColumn | Sheet Title | Binding: {Binding SheetTitle, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay} |
| 228 | DataGridTextColumn | Rev | Binding: {Binding CurrentRevision} · IsReadOnly: True |
| 232 | DataGridTextColumn | Disc | Binding: {Binding Discipline} · IsReadOnly: True |
| 236 | DataGridTextColumn | Layout | Binding: {Binding LayoutName} · IsReadOnly: True |
| 240 | DataGridTextColumn | Drawing | Binding: {Binding DwgPath} · IsReadOnly: True |
| 251 | Button | btnMoveUp · Move Up | Click: BtnMoveUp_Click |
| 256 | Button | btnMoveDown · Move Down | Click: BtnMoveDown_Click |
| 261 | Button | btnRenumber · Renumber Sheets | Click: BtnRenumber_Click |
| 277 | Button | btnUpdate · Update Drawings | Click: BtnUpdate_Click |
| 293 | Button | btnPublish · Publish Issue PDF | Click: BtnPublish_Click |
| 298 | Button | btnSave · Save | Click: BtnSave_Click |
| 337 | Button | btnClose · Close | Click: BtnClose_Click |

## shared-owner — CeSheetsManagerWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsManagerWindow.xaml`.

SHA256: `6e62767a9b07bf2de47be1ac7d0f7667d430cef1bca5e7250c0409cd9e374a63`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|

## shared-owner — CeSheetsSyncPreviewWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsSyncPreviewWindow.xaml`.

SHA256: `c5cf5aec6f50722862bdee46d2a316662c60cd64c49edb9443bfa0d9628f41f0`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 182 | Button | Cancel | Click: BtnCancel_Click |
| 187 | Button | btnApplySync · Apply Sync | Click: BtnApplySync_Click |

## shared-owner — CeSheetsValidationReportWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsValidationReportWindow.xaml`.

SHA256: `257df6deb1ca4a7367b4407779eaa6528abe0deb3a0247adf0937bd979421930`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 125 | DataGridTextColumn | Status | Binding: {Binding SeverityLabel} |
| 128 | DataGridTextColumn | Sheet # | Binding: {Binding SheetNumber} |
| 131 | DataGridTextColumn | Title | Binding: {Binding SheetTitle} |
| 134 | DataGridTextColumn | Drawing | Binding: {Binding DwgName} |
| 137 | DataGridTextColumn | Issues | Binding: {Binding IssueCount} |
| 212 | Button | Export Report... | Click: BtnExportReport_Click |
| 216 | Button | Close | Click: BtnClose_Click |

## shared-owner — CeSharedTitleMappingWindow.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSharedTitleMappingWindow.xaml`.

SHA256: `9dc92e765bf4cb230db1b7e48e86aa672b5ecb991e67829b3cc9db6fd78a7b4b`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 63 | DataGridTextColumn | Candidate | Binding: {Binding CandidateLabel} · IsReadOnly: True |
| 64 | DataGridTextColumn | Block | Binding: {Binding OwnerBlockName} · IsReadOnly: True |
| 65 | DataGridTextColumn | Layer | Binding: {Binding LayerName} · IsReadOnly: True |
| 66 | DataGridTextColumn | Tag/Source | Binding: {Binding SourceName} · IsReadOnly: True |
| 67 | DataGridTextColumn | Sample | Binding: {Binding SampleText} · IsReadOnly: True |
| 68 | DataGridTextColumn | Scope | Binding: {Binding ScopeKind} |
| 69 | DataGridTextColumn | Field | Binding: {Binding FieldName} |
| 70 | DataGridTextColumn | Sheet | Binding: {Binding SheetNumber} |
| 71 | DataGridTextColumn | Revision | Binding: {Binding RevisionCode} |
| 72 | DataGridTextColumn | Discipline | Binding: {Binding DisciplineCode} |
| 73 | DataGridTextColumn | Mapping | Binding: {Binding MappingLabel} · IsReadOnly: True |
| 91 | CheckBox | chkSaveReusable · Save as reusable template mapping in CS_Settings.json | Owner semantics require inspection |
| 101 | Button | Clear Selected | Click: BtnClearSelected_Click |
| 105 | Button | Save Mapping | Click: BtnSave_Click |
| 112 | Button | Cancel | Click: BtnCancel_Click |

## shared-owner — CePropsDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CePropsDialog.xaml`.

SHA256: `6f91c1115f0471074147d7a9819c3bc2e7c35d82aba7fee474e2fda47f4014c1`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 73 | TextBox | txtDrawingPath | IsReadOnly: True |
| 84 | TextBox | txtProjectRoot | IsReadOnly: True |
| 119 | TextBox | txtJobNumber | Owner semantics require inspection |
| 122 | TextBox | txtJobName | Owner semantics require inspection |
| 125 | TextBox | txtJobAddress | Owner semantics require inspection |
| 128 | TextBox | txtSuburb | Owner semantics require inspection |
| 131 | TextBox | txtClientName | Owner semantics require inspection |
| 134 | TextBox | txtDefaultDrawnBy | Owner semantics require inspection |
| 137 | TextBox | txtDefaultDesignedBy | Owner semantics require inspection |
| 164 | TextBox | txtRevision | Owner semantics require inspection |
| 167 | TextBox | txtIssueDate | Owner semantics require inspection |
| 183 | CheckBox | chkUpdateManifest · Update CE project manifest for this drawing | Owner semantics require inspection |
| 188 | CheckBox | chkSyncProject · Sync managed project drawings now after save | Owner semantics require inspection |
| 215 | Button | Cancel | Click: BtnCancel_Click |
| 221 | Button | Save | Click: BtnSave_Click |

## shared-owner — CeIssuePublishDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeIssuePublishDialog.xaml`.

SHA256: `229177ee83479d6e9b062b81249fdd91d0d04a260b24ce0513060687158cdb88`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 43 | TextBox | txtIssueDate | Owner semantics require inspection |
| 47 | CheckBox | chkCouncil · For council approval | Owner semantics require inspection |
| 56 | RadioButton | rbSeparate · Separate packs (a folder per discipline) | IsChecked: True |
| 61 | RadioButton | rbCombined · One combined pack (single folder) | Owner semantics require inspection |
| 89 | Button | btnPublish · Review | Click: BtnPublish_Click |
| 98 | Button | btnCancel · Cancel | Click: BtnCancel_Click |

## shared-owner — CeSheetsIssueReviewDialog.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSheetsIssueReviewDialog.xaml`.

SHA256: `6277285b75c6e3eac6a120791668acd4a4382475f361c41aeba728c7e14333d0`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 47 | DataGridTextColumn | Sheet No | Binding: {Binding SheetNumber} |
| 48 | DataGridTextColumn | Title | Binding: {Binding SheetTitle} |
| 49 | DataGridTextColumn | Rev | Binding: {Binding Revision} |
| 50 | DataGridTextColumn | Discipline | Binding: {Binding Discipline} |
| 51 | DataGridTextColumn | DWG | Binding: {Binding DrawingPath} |
| 52 | DataGridTextColumn | Actual layout | Binding: {Binding ActualLayout} |
| 92 | Button | btnBack · Back | Click: BtnBack_Click |
| 94 | Button | btnIssue · Issue | Click: BtnIssue_Click |
| 97 | Button | Cancel | Click: BtnCancel_Click |

## shared-owner — CeProjectSheetsWorkspaceView.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Pages\CeProjectSheetsWorkspaceView.xaml`.

SHA256: `b85e1c97a9df72e4d24201d94dbd09e44408ba005d314ebfc9871b8ebdc39368`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 52 | TextBox | txtProjectRoot | Owner semantics require inspection |
| 62 | Button | Browse... | Click: BtnBrowseProject_Click |
| 66 | Button | Open Folder | Click: BtnOpenProjectFolder_Click |
| 70 | Button | Setup Project | Click: BtnSetupProject_Click |
| 74 | Button | Scan Project | Click: BtnScanProject_Click |
| 81 | Button | Force Full Rescan | Click: BtnForceRescanProject_Click |
| 109 | TextBox | txtJobNumber | Owner semantics require inspection |
| 112 | TextBox | txtJobName | Owner semantics require inspection |
| 115 | TextBox | txtJobAddress | Owner semantics require inspection |
| 118 | TextBox | txtSuburb | Owner semantics require inspection |
| 121 | TextBox | txtClientName | Owner semantics require inspection |
| 124 | TextBox | txtDefaultDrawnBy | Owner semantics require inspection |
| 127 | TextBox | txtDefaultDesignedBy | Owner semantics require inspection |
| 143 | TextBox | txtIssueDate | Owner semantics require inspection |
| 146 | TextBox | txtIssueRevision | Owner semantics require inspection |
| 148 | CheckBox | chkCouncilApproval · For council approval | Owner semantics require inspection |
| 153 | TextBox | txtIssueFolderName | IsReadOnly: True |
| 157 | CheckBox | chkSyncLayoutNames · Rename layout tabs from the manager | IsChecked: True |
| 174 | ListBox | lstIssueHistory | Owner semantics require inspection |
| 186 | TextBox | txtIssueDiff | IsReadOnly: True · Visibility: Collapsed |
| 195 | Button | btnReissueFrom · Reissue from Selected | Click: BtnReissueFrom_Click |
| 232 | Button | Map Title Block | Click: BtnMapTitleBlock_Click |
| 240 | TextBox | txtHealthDetails | IsReadOnly: True |
| 265 | ComboBox | cboDisciplineFilter | Owner semantics require inspection |
| 274 | CheckBox | chkShowExcluded · Show excluded | Owner semantics require inspection |
| 280 | Button | Add To Issue | Click: BtnIncludeSelectedInIssue_Click |
| 281 | Button | Remove From Issue | Click: BtnExcludeSelectedFromIssue_Click |
| 282 | Button | Duplicate Selected | Click: BtnDuplicateSelected_Click |
| 283 | Button | Insert Before | Click: BtnInsertBefore_Click |
| 284 | Button | Insert After | Click: BtnInsertAfter_Click |
| 285 | Button | Exclude Selected | Click: BtnExcludeSelected_Click |
| 286 | Button | Manage Selected | Click: BtnManageSelected_Click |
| 287 | Button | Archive Selected | Click: BtnArchiveSelected_Click |
| 288 | Button | Renumber Sheets | Click: BtnRenumberSheets_Click |
| 289 | Button | Reconcile Files | Click: BtnReconcileFiles_Click |
| 290 | Button | Move Up | Click: BtnMoveUp_Click |
| 291 | Button | Move Down | Click: BtnMoveDown_Click |
| 292 | Button | Bump Revision | Click: BtnBumpRevision_Click |
| 307 | MenuItem | Set Drawn By for Selected… | Click: CtxSetField_Click |
| 308 | MenuItem | Set Designed By for Selected… | Click: CtxSetField_Click |
| 309 | MenuItem | Set Revision for Selected… | Click: CtxSetField_Click |
| 310 | MenuItem | Set Discipline for Selected… | Click: CtxSetField_Click |
| 312 | MenuItem | Bump Revision for Selected | Click: BtnBumpRevision_Click |
| 314 | MenuItem | Select by Discipline… | Click: CtxSelectByDiscipline_Click |
| 315 | MenuItem | Select All Managed | Click: CtxSelectAllManaged_Click |
| 317 | MenuItem | Renumber Selected from… | Click: CtxRenumberSelectedFrom_Click |
| 318 | MenuItem | Show Numbering Gaps | Click: CtxShowGaps_Click |
| 322 | DataGridTextColumn | Status | Binding: {Binding ManagementStatus} · IsReadOnly: True |
| 323 | DataGridTextColumn | Issue | Binding: {Binding IssueStatus} · IsReadOnly: True |
| 324 | DataGridTextColumn | Order | Binding: {Binding SheetOrder} |
| 325 | DataGridTextColumn | Sheet No | Binding: {Binding SheetNumber} |
| 326 | DataGridTextColumn | Sheet Title | Binding: {Binding SheetTitle} |
| 327 | DataGridTextColumn | Revision | Binding: {Binding CurrentRevision} |
| 328 | DataGridTextColumn | Drawn By | Binding: {Binding DrawnBy} |
| 329 | DataGridTextColumn | Designed By | Binding: {Binding DesignedBy} |
| 330 | DataGridTextColumn | Discipline | Binding: {Binding Discipline} · IsReadOnly: True |
| 331 | DataGridTextColumn | Layout Tab | Binding: {Binding LayoutTabName} |
| 332 | DataGridTextColumn | Layout | Binding: {Binding LayoutName} · IsReadOnly: True |
| 333 | DataGridTextColumn | Drawing Path | Binding: {Binding DwgPath} · IsReadOnly: True |
| 338 | Button | Save Manifest | Click: BtnSaveManifest_Click |
| 339 | Button | Sync Drawings | Click: BtnSyncDrawings_Click |
| 340 | Button | Map Title Block | Click: BtnMapTitleBlock_Click |
| 341 | Button | Preview Renames | Click: BtnPreviewRenames_Click |
| 342 | Button | Apply Renames | Click: BtnApplyRenames_Click |
| 343 | Button | btnCreateIssue · Create Issue Snapshot | Click: BtnCreateIssue_Click |
| 344 | Button | btnPublishIssue · Publish Issue PDFs | Click: BtnPublishIssue_Click |
| 345 | Button | Validate Project | Click: BtnValidateProject_Click |
| 373 | Button | btnCancelScan · Cancel Scan | Click: BtnCancelScan_Click · Visibility: Collapsed |
| 379 | Button | btnClose · Close | Click: BtnClose_Click |

## shared-owner — ProjectSheetsWorkspacePage.xaml

Workflow: [02_SHARED_JOB_AND_ISSUE.md](02_SHARED_JOB_AND_ISSUE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Pages\ProjectSheetsWorkspacePage.xaml`.

SHA256: `54ae89c6d3e7222f218409b9834de63c76ef202771372274ccd7d71b47b2c75b`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 26 | Button | apply · Save Project | Click: ActionClicked |
| 27 | Button | discard · Discard | Click: ActionClicked |

## shared-owner — CeSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\CeSettingsDialog.xaml`.

SHA256: `a2424eef3636f4507bf7b2c4302d4fa78e2c0aa8a4f8861c83daa6510f8a1871`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 31 | Button | Reset Defaults | Click: OnResetDefaultsClick |
| 32 | Button | Cancel | Click: OnCancelClick |
| 33 | Button | Save | Click: OnSaveClick |
| 37 | TabItem | GeneralTab · General | Owner semantics require inspection |
| 41 | TextBox | DataFolderTextBox | Owner semantics require inspection |
| 42 | TextBox | UserNameTextBox | Owner semantics require inspection |
| 43 | ComboBox | DefaultTabComboBox | Owner semantics require inspection |
| 49 | ComboBox | PaletteDockComboBox | Owner semantics require inspection |
| 54 | ComboBox | ThemeComboBox | Owner semantics require inspection |
| 59 | TextBox | IdleTimeoutTextBox | Owner semantics require inspection |
| 60 | TextBox | LastPaletteWidthTextBox | Owner semantics require inspection |
| 61 | TextBox | FavoriteCommandsTextBox | Owner semantics require inspection |
| 62 | CheckBox | AutoResumeSessionCheckBox · Auto resume session | Owner semantics require inspection |
| 63 | CheckBox | ShowStatusBarTimerCheckBox · Show status bar timer | Owner semantics require inspection |
| 64 | CheckBox | ShowFloatingTimerCheckBox · Show floating timer | Owner semantics require inspection |
| 65 | CheckBox | ShowPaletteOnStartupCheckBox · Show palette on startup | Owner semantics require inspection |
| 70 | TabItem | BeamTab · Beam | Owner semantics require inspection |
| 94 | TextBox | BeamRegularOffsetTextBox | Owner semantics require inspection |
| 98 | TextBox | BeamMTextOffsetTextBox | Owner semantics require inspection |
| 102 | TextBox | BeamParallelToleranceTextBox | Owner semantics require inspection |
| 106 | TextBox | BeamSearchDistanceTextBox | Owner semantics require inspection |
| 110 | TextBox | BeamWindowDistanceTextBox | Owner semantics require inspection |
| 114 | TextBox | BeamWindowBandTextBox | Owner semantics require inspection |
| 118 | TextBox | BeamCenterToleranceTextBox | Owner semantics require inspection |
| 122 | TextBox | BeamOffsetMarginTextBox | Owner semantics require inspection |
| 128 | TextBox | SupportInsertOsmodeTextBox | Owner semantics require inspection |
| 132 | TextBox | SupportRotateOsmodeTextBox | Owner semantics require inspection |
| 136 | TextBox | SupportTextOsmodeTextBox | Owner semantics require inspection |
| 140 | CheckBox | BeamLinkingEnabledCheckBox · Enable beam linking (move/erase beam, supports &amp; text together) | Owner semantics require inspection |
| 144 | CheckBox | BeamUseInsideOutsidePromptCheckBox · Prompt once if no inside-points saved (J11 — recommended) | Owner semantics require inspection |
| 148 | CheckBox | BeamDiagnosticModeCheckBox · Diagnostic mode (writes one trace line per beam placement) | Owner semantics require inspection |
| 150 | CheckBox | BeamAutoOffsetCheckBox · Auto offset from xref context | Owner semantics require inspection |
| 151 | CheckBox | BeamAutoWallsCheckBox · Use walls for auto offset | Owner semantics require inspection |
| 152 | CheckBox | BeamAutoWindowsCheckBox · Use windows for auto offset | Owner semantics require inspection |
| 154 | CheckBox | BeamRememberChoicesCheckBox · Remember last choices | Owner semantics require inspection |
| 155 | CheckBox | BeamMergeCommandModesCheckBox · Merge 1/2/4 with 1A/2A/4A | Owner semantics require inspection |
| 156 | CheckBox | BeamSupportPreviewCheckBox · Support rotation preview | Owner semantics require inspection |
| 157 | CheckBox | BeamSupportCancelWholeCheckBox · ESC cancels whole support flow | Owner semantics require inspection |
| 174 | TextBox | BeamAdvancedMinReferenceSegmentLengthTextBox | Owner semantics require inspection |
| 179 | TextBox | BeamAdvancedMinWindowOffsetDriverSegmentLengthTextBox | Owner semantics require inspection |
| 184 | TextBox | BeamAdvancedWallAssemblyGapToleranceTextBox | Owner semantics require inspection |
| 202 | TextBox | BeamAdvancedEndpointAutoTrimPerpendicularToleranceDegTextBox | Owner semantics require inspection |
| 207 | TextBox | BeamAdvancedEndpointAutoTrimPointToleranceTextBox | Owner semantics require inspection |
| 212 | TextBox | BeamAdvancedEndpointAutoTrimSearchDistanceTextBox | Owner semantics require inspection |
| 219 | TextBox | BeamAdvancedCandidateTPositionsCsvTextBox | Owner semantics require inspection |
| 234 | TextBox | BeamAdvancedPreviewMarkerSizeTextBox | Owner semantics require inspection |
| 251 | TextBox | BeamAdvancedLintelPrefixesCsvTextBox | Owner semantics require inspection |
| 256 | TextBox | BeamAdvancedXrefScanLayerPatternsCsvTextBox | Owner semantics require inspection |
| 274 | TextBox | BeamAdvancedMigrateSupportEndpointToleranceTextBox | Owner semantics require inspection |
| 279 | TextBox | BeamAdvancedMigrateTextProximityToleranceParallelTextBox | Owner semantics require inspection |
| 284 | TextBox | BeamAdvancedMigrateTextProximityToleranceAlongTextBox | Owner semantics require inspection |
| 294 | TabItem | JointTab · CJ / SSC | Owner semantics require inspection |
| 296 | TextBox | JointBaseOffsetTextBox | Owner semantics require inspection |
| 297 | TextBox | JointCollisionMarginTextBox | Owner semantics require inspection |
| 298 | CheckBox | JointAutoSideCheckBox · Auto choose clean side | Owner semantics require inspection |
| 299 | CheckBox | JointPromptAmbiguousCheckBox · Prompt when ambiguous | Owner semantics require inspection |
| 303 | TabItem | SupportsTab · Supports | Owner semantics require inspection |
| 305 | CheckBox | SupportAutoDetectSideCheckBox · Auto detect support text side | Owner semantics require inspection |
| 309 | TabItem | BracingTab · Bracing | Owner semantics require inspection |
| 311 | CheckBox | BracingSkipFlipPromptCheckBox · Skip flip prompt when decisive | Owner semantics require inspection |
| 315 | TabItem | RafterJoistTab · Rafter / Joist | Owner semantics require inspection |
| 317 | TextBox | RjClashRadiusTextBox | Owner semantics require inspection |
| 318 | TextBox | RjSnapToleranceTextBox | Owner semantics require inspection |
| 319 | TextBox | RjLastR1TextBox | Owner semantics require inspection |
| 320 | TextBox | RjLastFj1TextBox | Owner semantics require inspection |
| 321 | TextBox | RjLastP1TextBox | Owner semantics require inspection |
| 322 | CheckBox | RjAutoPlacementCheckBox · Enable auto placement | Owner semantics require inspection |
| 323 | CheckBox | RjDebugLoggingCheckBox · Enable debug logging | Owner semantics require inspection |
| 327 | TabItem | RebarTab · Rebar | Owner semantics require inspection |
| 329 | TextBox | RebarSizeTextBox | Owner semantics require inspection |
| 330 | TextBox | RebarSpacingTextBox | Owner semantics require inspection |
| 331 | TextBox | RebarZoneTextBox | Owner semantics require inspection |
| 332 | TextBox | RebarCountTextBox | Owner semantics require inspection |
| 333 | TextBox | RebarLengthTextBox | Owner semantics require inspection |
| 334 | TextBox | RebarQuantityTextBox | Owner semantics require inspection |
| 335 | TextBox | RebarExportPathTextBox | Owner semantics require inspection |
| 339 | TabItem | AnnotationTab · Annotation | Owner semantics require inspection |
| 341 | TextBox | AnnotationLevelTypeTextBox | Owner semantics require inspection |
| 342 | TextBox | AnnotationSectionDirectionTextBox | Owner semantics require inspection |
| 343 | TextBox | AnnotationArcDimTypeTextBox | Owner semantics require inspection |
| 347 | TabItem | XrefLayerTab · Xref Layer | Owner semantics require inspection |
| 349 | TextBox | XrefTargetLayerTextBox | Owner semantics require inspection |
| 350 | TextBox | XrefColorTextBox | Owner semantics require inspection |
| 351 | TextBox | XrefLinetypeTextBox | Owner semantics require inspection |
| 355 | TabItem | SystemTab · System | Owner semantics require inspection |
| 358 | TextBox | DiagnosticsThresholdTextBox | Owner semantics require inspection |
| 359 | TextBox | AutoSaveIntervalTextBox | Owner semantics require inspection |
| 360 | TextBox | AutoSaveIdleDelayTextBox | Owner semantics require inspection |
| 361 | TextBox | AutoSaveMaxCopiesTextBox | Owner semantics require inspection |
| 362 | TextBox | AutoSaveBackupRootTextBox | Owner semantics require inspection |
| 363 | CheckBox | OptionsDebugLoggingCheckBox · Enable global debug logging | Owner semantics require inspection |
| 364 | CheckBox | DiagnosticsEnabledCheckBox · Enable diagnostics | Owner semantics require inspection |
| 365 | CheckBox | VerboseDiagnosticsCheckBox · Enable verbose diagnostics | Owner semantics require inspection |
| 366 | CheckBox | AutoSaveEnabledCheckBox · Enable autosave | Owner semantics require inspection |
| 367 | CheckBox | AutoSaveWriteBackupsCheckBox · Write rolling backups | Owner semantics require inspection |
| 368 | CheckBox | AutoSaveEchoCheckBox · Echo saves to command line | Owner semantics require inspection |
| 369 | TextBox | InstallPackageVersionTextBox | IsReadOnly: True |
| 370 | TextBox | InstallBundleRootTextBox | IsReadOnly: True |
| 371 | TextBox | InstallRuntimeAssemblyTextBox | IsReadOnly: True |
| 372 | TextBox | InstallSharedAssetsTextBox | IsReadOnly: True |
| 373 | TextBox | InstallWorkspaceCuixTextBox | IsReadOnly: True |
| 378 | TabItem | DataAutomationTab · Data / Automation | Owner semantics require inspection |
| 381 | TextBox | ExcelLastFolderTextBox | Owner semantics require inspection |
| 382 | TextBox | ExcelProjectSessionTextBox | Owner semantics require inspection |
| 383 | TextBox | ExcelSourceFileTextBox | Owner semantics require inspection |
| 384 | TextBox | ExcelPlacementModeTextBox | Owner semantics require inspection |
| 385 | TextBox | ExcelPreferredColumnsTextBox | Owner semantics require inspection |
| 386 | TextBox | ExcelRowsPerColumnTextBox | Owner semantics require inspection |
| 387 | TextBox | ExcelFloorGapTextBox | Owner semantics require inspection |
| 388 | TextBox | ExcelTextOffsetXTextBox | Owner semantics require inspection |
| 389 | TextBox | ExcelTextOffsetYTextBox | Owner semantics require inspection |
| 390 | TextBox | ExcelMinimumDistanceTextBox | Owner semantics require inspection |
| 391 | TextBox | ExcelScheduleBlockNameTextBox | Owner semantics require inspection |
| 392 | TextBox | ExcelScheduleBlockFileTextBox | Owner semantics require inspection |
| 393 | CheckBox | ExcelAdaptiveLearningCheckBox · Enable adaptive learning | Owner semantics require inspection |
| 394 | CheckBox | ExcelInsertScheduleBlocksCheckBox · Insert schedule blocks | Owner semantics require inspection |
| 395 | CheckBox | ExcelAuxWipeoutCheckBox · Use auxiliary wipeouts | Owner semantics require inspection |
| 396 | CheckBox | ExcelStaticGeometryCheckBox · Convert blocks to static geometry | Owner semantics require inspection |
| 397 | CheckBox | ExcelMarkPrefixRulesCheckBox · Use mark prefix rules | Owner semantics require inspection |
| 398 | CheckBox | ExcelMezzanineCheckBox · Use second floor label for mezzanine | Owner semantics require inspection |
| 399 | CheckBox | ExcelCombineRoofCheckBox · Combine roof and first floor schedules | Owner semantics require inspection |
| 400 | CheckBox | ExcelDuplicateAuditCheckBox · Enable duplicate mark audit | Owner semantics require inspection |
| 401 | CheckBox | ExcelAuditOnlyCheckBox · Audit only | Owner semantics require inspection |
| 402 | TextBox | XclmLastFolderTextBox | Owner semantics require inspection |
| 403 | TextBox | XclmProjectSessionTextBox | Owner semantics require inspection |
| 404 | TextBox | XclmSourceFileTextBox | Owner semantics require inspection |
| 405 | TextBox | XclmAutoApplyThresholdTextBox | Owner semantics require inspection |
| 406 | TextBox | XclmReviewThresholdTextBox | Owner semantics require inspection |
| 407 | CheckBox | XclmBackgroundRefreshCheckBox · Background refresh enabled | Owner semantics require inspection |
| 408 | CheckBox | XclmPreferPdfCheckBox · Prefer member schedule PDF | Owner semantics require inspection |
| 409 | TextBox | MarkupLastFolderTextBox | Owner semantics require inspection |
| 410 | TextBox | MarkupApiKeyEnvTextBox | Owner semantics require inspection |
| 411 | TextBox | MarkupBaseUrlTextBox | Owner semantics require inspection |
| 412 | TextBox | MarkupModelTextBox | Owner semantics require inspection |
| 413 | TextBox | MarkupThresholdTextBox | Owner semantics require inspection |
| 414 | TextBox | MarkupArchitectIdTextBox | Owner semantics require inspection |
| 415 | TextBox | MarkupDrafterIdTextBox | Owner semantics require inspection |
| 416 | TextBox | MarkupPythonTextBox | Owner semantics require inspection |
| 417 | TextBox | MarkupWorkerTimeoutTextBox | Owner semantics require inspection |
| 418 | CheckBox | MarkupEnabledCheckBox · Enable MarkupAI | Owner semantics require inspection |
| 419 | CheckBox | MarkupCivilOntologyCheckBox · Include civil ontology | Owner semantics require inspection |
| 420 | CheckBox | MarkupLearningOptInCheckBox · Learning data opt in | Owner semantics require inspection |
| 421 | CheckBox | MarkupSaveProjectFolderCheckBox · Save packages to project folder | Owner semantics require inspection |
| 422 | CheckBox | MarkupBootstrapWorkerCheckBox · Auto bootstrap worker | Owner semantics require inspection |
| 423 | CheckBox | MarkupChatEnabledCheckBox · Enable chat | Owner semantics require inspection |

## shared-owner — SettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Dialogs\SettingsDialog.xaml`.

SHA256: `6df6c06e44f40302b9f93823e0c52c9526ebc8ef5c79c0c99ad54a1c8f303b96`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 60 | TextBox | txtIdleTimeout | Text: 5 |
| 67 | CheckBox | chkAutoResumeSession · Auto-resume session when returning from idle | Owner semantics require inspection |
| 71 | CheckBox | chkShowStatusBarTimer · Show timer in AutoCAD status bar | Owner semantics require inspection |
| 75 | CheckBox | chkShowFloatingTimer · Show floating timer window | Owner semantics require inspection |
| 99 | ComboBox | cboDefaultTab | Owner semantics require inspection |
| 116 | ComboBox | cboPaletteDock | Owner semantics require inspection |
| 132 | ComboBox | cboTheme | Owner semantics require inspection |
| 159 | TextBox | txtUserName | Owner semantics require inspection |
| 180 | TextBox | txtDataFolder | IsReadOnly: True |
| 185 | Button | Browse... | Click: BtnBrowseDataFolder_Click |
| 210 | Button | Reset to Defaults | Click: BtnResetDefaults_Click |
| 214 | Button | About | Click: BtnAbout_Click |
| 220 | Button | Save | Click: BtnSave_Click |
| 228 | Button | Cancel | Click: BtnCancel_Click |

## shared-owner — AdvancedSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\AdvancedSettingsDialog.xaml`.

SHA256: `6dd2dbf4f73aebe6dc9d52732c90ad99b1874ea8960d215588d14a700902135a`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 37 | ComboBox | (unnamed) | ItemsSource: {Binding InvertPositionOptions} · SelectedItem: {Binding DefaultInvertPosition} |
| 43 | ComboBox | (unnamed) | ItemsSource: {Binding MirrorOptions} · SelectedItem: {Binding DefaultMirror} |
| 62 | TextBox | (unnamed) | Text: {Binding InvertInwardDistance, UpdateSourceTrigger=PropertyChanged} |
| 69 | TextBox | (unnamed) | Text: {Binding InvertMaskOffsetMm, UpdateSourceTrigger=PropertyChanged} |
| 95 | TextBox | (unnamed) | Text: {Binding DefaultMinimumGrade, UpdateSourceTrigger=PropertyChanged} |
| 102 | TextBox | (unnamed) | Text: {Binding DefaultStandardGrade, UpdateSourceTrigger=PropertyChanged} |
| 121 | TextBox | (unnamed) | Text: {Binding CalculatedInvertDecimals, UpdateSourceTrigger=PropertyChanged} |
| 127 | TextBox | (unnamed) | Text: {Binding MinOutletDropMm, UpdateSourceTrigger=PropertyChanged} |
| 135 | CheckBox | Remember last Quick Mode settings | IsChecked: {Binding RememberQuickMode} |
| 138 | CheckBox | Default Auto-zoom in CD | IsChecked: {Binding DefaultAutoZoom} |
| 146 | Button | Open OSNAP Settings | Command: {Binding OsnapCommand} |
| 170 | TextBox | (unnamed) | Text: {Binding DsMinimumPipeGrade, UpdateSourceTrigger=PropertyChanged} |
| 176 | TextBox | (unnamed) | Text: {Binding DsMaximumPipeVelocity, UpdateSourceTrigger=PropertyChanged} |
| 182 | TextBox | (unnamed) | Text: {Binding DsMinimumCoverDepth, UpdateSourceTrigger=PropertyChanged} |
| 188 | TextBox | (unnamed) | Text: {Binding DsLpdPitIdentifier, UpdateSourceTrigger=PropertyChanged} |
| 194 | TextBox | (unnamed) | Text: {Binding DsMaxPipeRunLength, UpdateSourceTrigger=PropertyChanged} |
| 222 | ComboBox | (unnamed) | ItemsSource: {Binding SurveyWorkflowModeOptions} · SelectedItem: {Binding SurveyWorkflowMode} |
| 229 | TextBox | (unnamed) | Text: {Binding SurveyRlToleranceMm, UpdateSourceTrigger=PropertyChanged} |
| 243 | ComboBox | (unnamed) | ItemsSource: {Binding ThemeOptions} · SelectedItem: {Binding SelectedTheme} |
| 251 | CheckBox | Draw pipe run before options dialog (CD) | IsChecked: {Binding CdDrawFirst} |
| 258 | CheckBox | Enable diagnostic logging | IsChecked: {Binding DebugLogging} |
| 272 | Button | Reset to Defaults | Command: {Binding ResetCommand} |
| 277 | Button | Cancel | Command: {Binding CancelCommand} |
| 283 | Button | OK | Command: {Binding OkCommand} |

## shared-owner — OsnapSettingsDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\OsnapSettingsDialog.xaml`.

SHA256: `6bf1941bd907ffde6878d45d254765f7751cfd5b05fba50204d40312e76f72de`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 75 | CheckBox | {Binding Name} · {Binding Name} | IsChecked: {Binding DrawingEnabled} |
| 87 | Button | Use current AutoCAD | Command: {Binding UseCurrentForDrawingCommand} |
| 91 | Button | All On | Command: {Binding DrawingAllOnCommand} |
| 95 | Button | All Off | Command: {Binding DrawingAllOffCommand} |
| 126 | CheckBox | {Binding Name} · {Binding Name} | IsChecked: {Binding TextEnabled} |
| 138 | Button | Use current AutoCAD | Command: {Binding UseCurrentForTextCommand} |
| 142 | Button | All On | Command: {Binding TextAllOnCommand} |
| 146 | Button | All Off | Command: {Binding TextAllOffCommand} |
| 164 | Button | Restore CE Defaults | Command: {Binding ResetDefaultsCommand} |
| 169 | Button | Cancel | Command: {Binding CancelCommand} |
| 176 | Button | Save + Use Drawing Now | Command: {Binding ApplyCommand} |
| 183 | Button | Save &amp; Close | Command: {Binding OkCommand} |

## shared-owner — CivilSettingsView.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\CivilSettingsView.xaml`.

SHA256: `c67210f6936839c8b3c765dc7b39860a33be16394f1960e9a257d7c30e4a2f03`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 15 | ComboBox | (unnamed) | ItemsSource: {Binding InvertPositionOptions} · SelectedItem: {Binding DefaultInvertPosition} |
| 17 | ComboBox | (unnamed) | ItemsSource: {Binding MirrorOptions} · SelectedItem: {Binding DefaultMirror} |
| 32 | TextBox | (unnamed) | Text: {Binding InvertInwardDistance, UpdateSourceTrigger=PropertyChanged} |
| 35 | TextBox | (unnamed) | Text: {Binding InvertMaskOffsetMm, UpdateSourceTrigger=PropertyChanged} |
| 52 | TextBox | (unnamed) | Text: {Binding DefaultMinimumGrade, UpdateSourceTrigger=PropertyChanged} |
| 54 | TextBox | (unnamed) | Text: {Binding DefaultStandardGrade, UpdateSourceTrigger=PropertyChanged} |
| 69 | TextBox | (unnamed) | Text: {Binding CalculatedInvertDecimals, UpdateSourceTrigger=PropertyChanged} |
| 72 | TextBox | (unnamed) | Text: {Binding MinOutletDropMm, UpdateSourceTrigger=PropertyChanged} |
| 78 | CheckBox | Remember last Quick Mode settings | IsChecked: {Binding RememberQuickMode} |
| 79 | CheckBox | Default Auto-zoom in CD | IsChecked: {Binding DefaultAutoZoom} |
| 85 | Button | Open OSNAP Settings | Command: {Binding OsnapCommand} |
| 103 | TextBox | (unnamed) | Text: {Binding DsMinimumPipeGrade, UpdateSourceTrigger=PropertyChanged} |
| 106 | TextBox | (unnamed) | Text: {Binding DsMaximumPipeVelocity, UpdateSourceTrigger=PropertyChanged} |
| 109 | TextBox | (unnamed) | Text: {Binding DsMinimumCoverDepth, UpdateSourceTrigger=PropertyChanged} |
| 112 | TextBox | (unnamed) | Text: {Binding DsLpdPitIdentifier, UpdateSourceTrigger=PropertyChanged} |
| 114 | TextBox | (unnamed) | Text: {Binding DsMaxPipeRunLength, UpdateSourceTrigger=PropertyChanged} |
| 132 | ComboBox | (unnamed) | ItemsSource: {Binding SurveyWorkflowModeOptions} · SelectedItem: {Binding SurveyWorkflowMode} |
| 134 | TextBox | (unnamed) | Text: {Binding SurveyRlToleranceMm, UpdateSourceTrigger=PropertyChanged} |
| 140 | CheckBox | Draw pipe run before options dialog (CD) | IsChecked: {Binding CdDrawFirst} |
| 144 | CheckBox | Enable diagnostic logging | IsChecked: {Binding DebugLogging} |
| 146 | Button | Reset Civil | Command: {Binding ResetCivilCommand} |

## shared-owner — CivilGeneralSettingsView.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\CivilGeneralSettingsView.xaml`.

SHA256: `8bbf63c073e431ab67b5cdd5c6fdbe6861988af6a3d3e5619e1a7b128c0eb947`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 11 | ComboBox | (unnamed) | ItemsSource: {Binding ThemeOptions} · SelectedItem: {Binding SelectedTheme} |
| 14 | Button | Reset General | Command: {Binding ResetGeneralCommand} |

## shared-owner — CivilHelpGuideView.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\CivilHelpGuideView.xaml`.

SHA256: `d41c81b8b856f40bccc37c4f8f859c4f49baae33edb690647b5503c80bf22ad5`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 28 | Button | OpenInBrowserButton · Open in default browser | Click: OnOpenInBrowser |

## shared-owner — HelpGuideWindow.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\HelpGuideWindow.xaml`.

SHA256: `a2c63a5e2a0b12b8800ffbe9bebea9333f4cf6b83c12eb29a877bcb34ff0fb2f`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|

## shared-owner — CdHelpDialog.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\CdHelpDialog.xaml`.

SHA256: `83a19132aabc1092322cf262900dcccd96d25ff6aa7dab6761828fc7f0d4ce46`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 104 | Button | Pipe Layout (CD) | Click: OnRunCommand |
| 105 | Button | Pit Layout (PIT) | Click: OnRunCommand |
| 106 | Button | Edit Existing (CDEDIT) | Click: OnRunCommand |
| 107 | Button | Pit Schedule | Click: OnRunCommand |
| 108 | Button | Design Check | Click: OnRunCommand |
| 109 | Button | Long. Profile | Click: OnRunCommand |
| 110 | Button | Inspector | Click: OnRunCommand |
| 111 | Button | Repair Center | Click: OnRunCommand |
| 184 | Button | Close | Click: OnClose |

## shared-owner — SettingsWorkspacePage.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Pages\SettingsWorkspacePage.xaml`.

SHA256: `e4ec0fb2ca7152cd0726a0ff9b797750920eb9d194ab9d3f2516bb8f5ed7dbf8`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 16 | TabItem | General | Owner semantics require inspection |
| 22 | TabItem | Civil | Owner semantics require inspection |
| 27 | Button | civilFallback · Open existing Civil settings | Click: ActionClicked |
| 31 | TabItem | Structural | Owner semantics require inspection |
| 35 | Button | structuralSettings · Open Structural settings | Click: ActionClicked |
| 38 | TabItem | Manager | Owner semantics require inspection |
| 43 | Button | companyControls · Company controls | Click: ActionClicked · Visibility: Collapsed |
| 55 | Button | apply · Apply | Click: ActionClicked |
| 56 | Button | discard · Discard | Click: ActionClicked |

## shared-owner — HelpWorkspacePage.xaml

Workflow: [03_SETTINGS_ASSETS_AND_HELP.md](03_SETTINGS_ASSETS_AND_HELP.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Pages\HelpWorkspacePage.xaml`.

SHA256: `527b2043f284b136e8643124eb15c191e41436dfb829316b513b2cdc32690024`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 16 | TabItem | Civil | Owner semantics require inspection |
| 21 | Button | civilFallback · Open existing Civil Help | Click: ActionClicked |
| 25 | TabItem | Task journeys | Owner semantics require inspection |
| 31 | TabItem | Structural | Owner semantics require inspection |
| 34 | Button | structuralFallback · Open existing Structural Help | Click: ActionClicked |
| 37 | TabItem | Manager &amp; Support | Owner semantics require inspection |

## shared-owner — PluginManagerWindow.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Dialogs\PluginManagerWindow.xaml`.

SHA256: `886a42b3c25b5c34ac7c3a4f47d8a29e9a9b5a7571869e78a68b779c86d1709e`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 48 | Button | Review update | Click: BtnReviewPreparation_Click · Visibility: {Binding CanReviewPreparation, Converter={StaticResource BoolToVis}} |
| 49 | Button | View receipt | Click: BtnViewPreparationReceipt_Click · Visibility: {Binding CanViewPreparationReceipt, Converter={StaticResource BoolToVis}} |
| 70 | Button | btnAdminDashboard · Admin Dashboard | Click: BtnAdminDashboard_Click · Visibility: Collapsed |
| 71 | Button | Refresh | Click: BtnRefresh_Click |
| 95 | TabItem | Status | Owner semantics require inspection |
| 105 | TabItem | tabModule · Module | Owner semantics require inspection |
| 108 | ListBox | icPlugins | ItemsSource: {Binding Modules} · SelectedItem: {Binding SelectedModule, Mode=TwoWay} · Visibility: Collapsed |
| 109 | ListBox | (unnamed) | Owner semantics require inspection |
| 128 | Button | Open Hub | Click: BtnOpenHub_Click |
| 129 | Button | Open Help | Click: BtnOpenHelp_Click |
| 130 | Button | {Binding SelectedModule.Descriptor.SettingsButtonLabel} | Click: BtnSettings_Click |
| 131 | Button | Open Repair | Click: BtnOpenRepair_Click |
| 132 | Button | View Commands | Click: BtnViewCommands_Click |
| 133 | Button | {Binding SelectedModule.Descriptor.ToggleButtonLabel} | Click: BtnToggle_Click |
| 134 | Button | Load Now | Click: BtnLoad_Click · Visibility: {Binding SelectedModule.CanLoadNow, Converter={StaticResource BoolToVis}} |
| 135 | Button | View History | Click: BtnViewHistory_Click |
| 136 | Button | View Superseded | Click: BtnViewSuperseded_Click |
| 143 | TabItem | tabUpdates · Updates | Owner semantics require inspection |
| 173 | Button | Review update | Click: BtnReviewPreparation_Click · Visibility: {Binding SelectedModule.CanReviewPreparation, Converter={StaticResource BoolToVis}} |
| 174 | Button | View preparation receipt | Click: BtnViewPreparationReceipt_Click · Visibility: {Binding SelectedModule.CanViewPreparationReceipt, Converter={StaticResource BoolToVis}} |
| 179 | Button | Confirm preparation | Click: BtnInstall_Click |
| 180 | Button | Cancel | Click: BtnCancelPreparation_Click |
| 193 | TabItem | tabHelp · Help | Owner semantics require inspection |
| 197 | TabItem | tabSettings · Settings | Owner semantics require inspection |
| 201 | TabItem | tabProjectSheets · Project / Sheets | Owner semantics require inspection |
| 206 | TabItem | tabDrawingRepair · Drawing Repair | Owner semantics require inspection |
| 213 | TabItem | tabProjectQa · Project QA | Visibility: Collapsed |
| 223 | Button | btnUploadTelemetry · Upload Pending Admin Data | Click: BtnUploadTelemetry_Click |
| 224 | Button | btnSendDiagnostics · Send Diagnostics | Click: BtnSendDiagnostics_Click |

## shared-owner — PluginAdminWindow.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Dialogs\PluginAdminWindow.xaml`.

SHA256: `dcb6d8881b52fe6c29e9d29b4decc170651abf799b9acfba9e9fe2755499248f`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 48 | Button | Upload Pending | Click: BtnUploadPending_Click |
| 52 | Button | Create Support Bundle | Click: BtnCreateBundle_Click |
| 56 | Button | BtnRefresh · Refresh | Click: BtnRefresh_Click |
| 119 | TabItem | tabOverview · Overview | Owner semantics require inspection |
| 138 | TabItem | tabMachines · Machines | Owner semantics require inspection |
| 144 | DataGridTextColumn | User | Binding: {Binding UserName} |
| 145 | DataGridTextColumn | Machine | Binding: {Binding MachineName} |
| 146 | DataGridTextColumn | Last Seen | Binding: {Binding LastSeenLocal} |
| 147 | DataGridTextColumn | AutoCAD | Binding: {Binding AutoCadVersion} |
| 148 | DataGridTextColumn | Restart | Binding: {Binding RestartState} |
| 149 | DataGridTextColumn | Health | Binding: {Binding HealthState} |
| 150 | DataGridTextColumn | Versions | Binding: {Binding PluginVersions} |
| 155 | TabItem | tabUsage · Usage | Owner semantics require inspection |
| 162 | TabItem | tabFailures · Failures | Owner semantics require inspection |
| 170 | MenuItem | Mark as Investigated | Click: MnuAcknowledgeFailure_Click |
| 174 | DataGridTextColumn | Time | Binding: {Binding LocalTime} |
| 175 | DataGridTextColumn | Severity | Binding: {Binding Severity} |
| 176 | DataGridTextColumn | User | Binding: {Binding UserName} |
| 177 | DataGridTextColumn | Machine | Binding: {Binding MachineName} |
| 178 | DataGridTextColumn | Plugin | Binding: {Binding PluginId} |
| 179 | DataGridTextColumn | Category | Binding: {Binding Category} |
| 180 | DataGridTextColumn | Type | Binding: {Binding Type} |
| 181 | DataGridTextColumn | Message | Binding: {Binding Message} |
| 202 | TabItem | tabUpdates · Updates | Owner semantics require inspection |
| 209 | Button | Approve Available Build | Click: BtnApproveAvailable_Click |
| 213 | Button | Roll Back Approved Release | Click: BtnRollbackApproved_Click |
| 217 | Button | Canary Rollout... | Click: BtnCanaryRollout_Click |
| 221 | Button | Promote to All | Click: BtnPromoteToAll_Click |
| 232 | TabItem | tabSupportBundles · Support Bundles | Owner semantics require inspection |
| 239 | TabItem | tabPolicies · Policies | Owner semantics require inspection |

## shared-owner — FeedbackDialog.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\FeedbackDialog.xaml`.

SHA256: `c8374080fddbabc82d7d1b156ef753b41ac4b447d2a33d624bf1cfb96ae5fa16`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 59 | RadioButton | Bug report | IsChecked: {Binding IsTypeBug} |
| 62 | RadioButton | Suggestion / feature request | IsChecked: {Binding IsTypeSuggestion} |
| 69 | TextBox | (unnamed) | Text: {Binding Title, UpdateSourceTrigger=PropertyChanged} |
| 76 | TextBox | (unnamed) | Text: {Binding Description, UpdateSourceTrigger=PropertyChanged} |
| 148 | Button | Submit | Click: OnSubmit |
| 156 | Button | Cancel | Click: OnCancel |

## shared-owner — WhatsNewDialog.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Dialogs\WhatsNewDialog.xaml`.

SHA256: `328e7642390c391eb2f01cfda8efa744abf664252b56bcb13444fe2d7382230f`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 75 | Button | How To Guide | Click: OnHowToGuide |
| 81 | Button | Got It | Click: OnGotIt |

## shared-owner — CeAssistantControl.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Drainage\Controls\CeAssistantControl.xaml`.

SHA256: `e002597fbeb3ab09be40b346ae211c1ddb937b0191f54002d4a94376ff489f5c`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 144 | Button | AnalyzeMarkupsButton · Analyse markups | Click: AnalyzeMarkupsButton_Click |
| 156 | Button | AnalyzeFromFileButton · From file… | Click: AnalyzeFromFileButton_Click |
| 168 | Button | ReviewChangesButton · {Binding ReviewChangesButtonText} | Click: ReviewChangesButton_Click · Visibility: {Binding HasPendingMarkupPlan, Converter={StaticResource BoolToVis}} |
| 184 | TextBox | InputBox | Text: {Binding InputText, UpdateSourceTrigger=PropertyChanged} |
| 201 | Button | SendButton · Send | Click: SendButton_Click |
| 208 | Button | (unnamed) | Owner semantics require inspection |

## shared-owner — MarkupAIPanel.xaml

Workflow: [04_PRODUCT_SUPPORT_AND_ASSISTANCE.md](04_PRODUCT_SUPPORT_AND_ASSISTANCE.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Structural\UI\Palette\MarkupAIPanel.xaml`.

SHA256: `a2a6e4d4253d2fa89b3464db01143b8289caa649a30068d51940f41d0dc60e72`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 50 | TextBox | txtPdfPath | Owner semantics require inspection |
| 51 | Button | Browse... | Click: BtnBrowsePdf_Click |
| 52 | Button | Parse | Click: BtnParse_Click |
| 56 | ComboBox | cmbSourceMode | Owner semantics require inspection |
| 62 | ComboBox | cmbProjectType | Owner semantics require inspection |
| 69 | Button | Load... | Click: BtnLoadPackage_Click |
| 70 | Button | Replan | Click: BtnReplan_Click |
| 71 | Button | Save | Click: BtnSave_Click |
| 92 | DataGridCheckBoxColumn | OK | Binding: {Binding IsApproved} |
| 93 | DataGridTextColumn | Page | Binding: {Binding Page} |
| 94 | DataGridTextColumn | Source | Binding: {Binding Source} |
| 95 | DataGridTextColumn | Type | Binding: {Binding Intent} |
| 96 | DataGridTextColumn | Text | Binding: {Binding Text} |
| 97 | DataGridTextColumn | Conf | Binding: {Binding Confidence} |
| 98 | DataGridTextColumn | Exec | Binding: {Binding Executor} |
| 99 | DataGridTextColumn | Place | Binding: {Binding PlacementReady} |
| 100 | DataGridTextColumn | Command | Binding: {Binding Command} |
| 101 | DataGridTextColumn | Reason | Binding: {Binding ExecutorReason} |
| 102 | DataGridTextColumn | Group | Binding: {Binding GroupKey} |
| 103 | DataGridTextColumn | SubBatch | Binding: {Binding SubBatchKey} |
| 104 | DataGridTextColumn | Status | Binding: {Binding Status} |
| 109 | Button | Visual Preview | Click: BtnVisualPreview_Click |
| 110 | Button | Approve Selected | Click: BtnApproveSelected_Click |
| 111 | Button | Reject Selected | Click: BtnRejectSelected_Click |
| 112 | Button | Preview Next | Click: BtnPreviewNext_Click |
| 113 | Button | Run Next Group | Click: BtnRunNext_Click |
| 114 | Button | Undo Last Group | Click: BtnUndoLast_Click |
| 115 | Button | Refresh | Click: BtnRefresh_Click |
| 132 | TextBox | txtChatPrompt | Owner semantics require inspection |
| 133 | Button | Ask AI | Click: BtnAskAi_Click |
| 134 | Button | Apply Suggestions | Click: BtnApplyAi_Click |

## shared-owner — ProjectQaPage.xaml

Workflow: [05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md](05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Pages\ProjectQaPage.xaml`.

SHA256: `1474aa31d710ea934c3c5ac834feb4bb8f7104dc89d515fb0156aa2d28ec93d8`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 43 | ComboBox | (unnamed) | ItemsSource: {Binding Contributors} · SelectedItem: {Binding SelectedContributor, Mode=TwoWay} |
| 77 | Button | Cancel | Click: Cancel_Click · Command: {Binding CancelCommand} |
| 83 | Button | Refresh drawing | Command: {Binding RefreshCommand} |
| 157 | ListBox | (unnamed) | ItemsSource: {Binding VisibleFindings} · SelectedItem: {Binding SelectedFinding, Mode=TwoWay} |
| 163 | ListBox | (unnamed) | Owner semantics require inspection |
| 190 | Button | Previous | Command: {Binding PreviousFindingsCommand} |
| 195 | Button | Next | Command: {Binding NextFindingsCommand} |
| 239 | Button | Show in drawing | Command: {Binding ShowCommand} |
| 258 | Button | Close | Click: Close_Click |

## shared-owner — DrawingRepairPage.xaml

Workflow: [05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md](05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md). Source: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN\Modules\Manager\UI\Pages\DrawingRepairPage.xaml`.

SHA256: `d5bee1fc1501ba54f8d4b104b60451aeb66ce6f9d36a7b1e79ded83843ab64a0`. Disposition: **retain capability; reconcile route**.

| Line | Control | Name / label | Action / binding |
|---:|---|---|---|
| 64 | ComboBox | (unnamed) | ItemsSource: {Binding Contributors} · SelectedItem: {Binding SelectedContributor, Mode=TwoWay} |
| 130 | ListBox | (unnamed) | ItemsSource: {Binding VisibleFindings} · Visibility: {Binding HasPreview, Converter={StaticResource BoolToVis}} |
| 135 | ListBox | (unnamed) | Owner semantics require inspection |
| 168 | Button | Previous | Command: {Binding PreviousFindingsCommand} |
| 173 | Button | Next | Command: {Binding NextFindingsCommand} |
| 233 | Button | Unavailable | Owner semantics require inspection |
| 245 | Button | Unavailable | Owner semantics require inspection |
| 259 | Button | Fix it | Command: {Binding FixCommand} |
| 265 | Button | Cancel preview | Command: {Binding CancelCommand} |
| 271 | Button | Close | Click: Close_Click |
| 276 | Button | Inspect drawing | Command: {Binding InspectCommand} |
