1. **ANSWER FIRST — HIGH: 3; MEDIUM: 1; LOW: 0.** Four new faults are supported by the code. Changing a support can move another support's text; extending a beam to a curved boundary can leave it 2,000 mm short; adding a note after a damaged notes file can replace the user's previous notes; saving checklist templates deletes pending suggestions.

2. **Most important — changing one support can alter its neighbour's text.** The switch command collects text by distance, without checking which support owns it. Rotating the selected support then rotates that unrelated text too. A drafter can leave the neighbouring support with the wrong label position after an apparently ordinary edit.

3. **Evidence status — verified by reading, not witnessed in AutoCAD.** This was a read-only review on 23 October 2026, Melbourne time. No build, test, AutoCAD session, installation or source change was performed. The tests below are instructions for a later driver, not claimed results.

---

1. **S15-01 — HIGH — switching a support erases and moves nearby text that does not belong to it. Verified by reading.**

   **File:line:** `Modules/Structural/Commands/SupportBlockCommands.cs:562`; capture filter at `:1793` and `:1798`; erase at `:1871`; replacement at `:1921`; rotation at `:672` and `:742`.

   **What Tim meets:** Changing support A can move support B's label, although B was never selected. Even before rotation, the original nearby text is erased and replaced with a new object. This is a drawing-content fault, not a wording preference.

   **Exact failure scenario:** Two supports are close together. Text on `SUPPORT TEXT`, `SUPPORT TEXT COLUMN` or `SUPPORT COLUMN TEXT OVER` has its insertion point within 260 drawing units of A's calculated centre. Run a switch such as `SDS` on A and choose a different rotation. The code treats all qualifying text as A's side labels, regardless of ownership.

   **Proof:** `SwitchSupportBlock` captures labels at line 562, erases them at 564 and recreates them at 580, committing at 582. `CaptureSupportSideTextLabels` enumerates model space at 1785–1788 and tests only the layer and distance; it does not read a support-to-label link. The rotation stage repeats that same search at 672, calculates the rotation at 732 and transforms every captured object at 742. Replacement also does not preserve all text properties: the DBText initializer at 1921–1929 omits justification, alignment point and width factor. The neighbouring-text movement is sufficient to prove this finding without relying on those additional losses.

   **DETERMINISTIC TEST — fixture:** Use a disposable model-space drawing in millimetres, World UCS, standard CE support settings (DS = 90 x 90), unlocked/thawed/on layers, no REFEDIT, `OSMODE=0`, `DYNMODE=0`, `ANGBASE=0`, `ANGDIR=0`, decimal-degree angles. Use two authentic `SUPPORT BLOCK NEW` block references in the `90 x 90` state, scale 1 and rotation 0: A has insertion (0,0,0), B has insertion (200,0,0). A's centre is therefore (45,45,0). Put a base-left, non-annotative DBText reading `S15 NEIGHBOUR` at (245,145,0), rotation 0, height 50 mm, width factor 1, on `SUPPORT TEXT`. It belongs visually to B and has no link to A. Record B's handle and position and the text's handle and position. Do not add other text within the capture radius.

   **Typed steps:** Type `SDS`; select A; type `90` at “Specify rotation (drag to preview):”. Inspect B and the text by Properties or a database read.

   **Assertion:** B and its text must remain unchanged, including the text's identity, insertion (245,145,0) and rotation 0. The code predicts that B stays put but the original text is erased, a replacement receives a new handle, and its insertion becomes (-55,245,0) with rotation 90 degrees. Its starting distance from A's centre is approximately 223.607 mm, inside the 260 mm capture radius. As a control, repeat with the text outside that radius: it should remain untouched.

2. **S15-02 — HIGH — BEXTEND uses the chord of a curved polyline and reports that the beam reached the boundary. Verified by reading.**

   **File:line:** `Modules/Structural/Commands/BeamExtendCommands.cs:237`; intersection at `:184`; endpoint write at `:89`; success message at `:126`.

   **What Tim meets:** A beam extended to a curved wall or other curved polyline can stop well short of it. AutoCAD's command line nevertheless says the beam was extended to the boundary.

   **Exact failure scenario:** The selected boundary is a lightweight polyline containing an arc segment. BEXTEND accepts that object but calculates intersections using straight lines between its vertices, ignoring the arc's bulge.

   **Proof:** The command explicitly allows Polyline at line 37. `TryExtractSegmentsFromCurve` obtains consecutive vertex positions at 239–240 and adds straight endpoint pairs at 241; the closing segment is handled identically at 244–248. It never reads the segment type or bulge. Line 184 feeds those pairs into a straight-line intersection routine. Line 89 assigns the resulting point to the beam end, line 123 commits, and lines 126–131 report “Beam extended to the boundary at its end.”

   **DETERMINISTIC TEST — fixture:** Use a disposable millimetre drawing in model space, World UCS and Z=0, with no nearby beam text. Name the beam's layer `S15_BEAM` and create a LINE from (0,0,0) to (3000,0,0). Name the boundary's layer `S15_ARC_BOUNDARY`. Create an open two-vertex LWPOLYLINE with vertices (5000,-2000) and (5000,2000), first-vertex bulge +1, second-vertex bulge 0, elevation 0 and normal (0,0,1). This is the right-hand semicircle of radius 2,000 mm centred at (5000,0), crossing the beam's forward line at (7000,0).

   **Typed steps:** Type `BEXTEND`; select the beam; select the curved boundary near (7000,0); answer `End`; answer `None` to shortening. Read the beam end and length in Properties and retain the command-line text.

   **Assertion:** End point must be (7000,0,0), length 7,000 mm, and the end must lie on the actual selected curve. The code predicts (5000,0,0), length 5,000 mm, with the success sentence quoted above: a 2,000 mm shortfall. Control: replace the polyline with a straight LINE from (7000,-2000,0) to (7000,2000,0); the same command must reach (7000,0,0).

3. **S15-03 — HIGH — saving a new note after a read failure can overwrite the user's previous notes. Verified by reading.**

   **File:line:** `Modules/Structural/Core/Notes/SharedNotesManager.cs:1082`; add path at `:357` and `:369`; overwrite at `:1100`; UI success path at `Modules/Structural/UI/Palette/NotesPanel.xaml.cs:869`.

   **What Tim meets:** If the user's notes file is damaged, adding one new note can replace it with a file containing only that new note. Earlier notes from multiple drawings disappear from the live notes store. The save is treated as successful.

   **Exact failure scenario:** The existing `notes_data.json` contains notes but cannot be parsed. The folder and file remain writable. A drafter uses the Notes palette to add and save another note.

   **Proof:** Lines 52–53 store notes in `<DataFolder>/Job Notes/<UserName>/notes_data.json`, shared by that user's drawings. `AddNote` forces a fresh read at 357. `LoadData` catches the read/deserialisation exception, logs it at 1081, and returns an empty `SharedNotesData` at 1082. That return value does not distinguish a failed read from an empty store. The caller adds the new note at 364 and saves at 369. `SaveData` writes the same file at 1100 and returns true at 1107. The palette follows the successful-save branch at 869–878; its “Save Failed” message at 886 is bypassed. Supplemental read: `Modules/Structural/Services/CloudFileHelper.cs`, `WriteFileWithRetry`, writes a temporary file, deletes the original and moves the temporary file into its place; that path does not preserve a recovery copy.

   **DETERMINISTIC TEST — fixture:** Use an isolated test profile and disposable DataFolder with synthetic user `S15_REVIEW`, never a real notes folder. Save two synthetic drawings, `S15_A.dwg` and `S15_B.dwg`. Through `CENOTES` → `+ Note` → `Save`, create notes `S15 FIRST` and `S15 SECOND`, one in each drawing. Confirm both entries and their IDs exist in the user's single notes file. Preserve a test-only copy outside that live folder. Prepend the literal text `S15_CORRUPT!` to the JSON file, leaving all original bytes after it and keeping the file writable. This guarantees a parse failure and remains repairable by removing the prefix.

   **Typed/click steps:** With S15_A active, type `CENOTES`; click `+ Note`; enter `S15 THIRD`; click `Save`. Inspect the live JSON file and refresh the Notes palette. Capture the CE log with Debug logging enabled.

   **Assertion:** A failed read must not replace the existing notes bytes with an empty-store save. Preserve the damaged source for recovery and make the unsuccessful/pending save visible to the drafter. The code instead predicts valid replacement JSON with exactly one Notes entry, `S15 THIRD`; both original IDs are absent. The log contains “Failed to load shared notes:” followed by “Saved 1 shared notes for user” and “Shared project note saved (ID:”, without the “Save Failed” window. Repeat from the intact two-note fixture as a control: saving the third note must retain all three. This finding concerns protecting the notes store; it does not require blocking drawing work.

4. **S15-04 — MEDIUM — saving checklist templates deletes all pending checklist suggestions. Verified by reading.**

   **File:line:** `Modules/Structural/Core/Checklist/TemplateManager.cs:1298` and `:1302`; suggestion storage at `:1328`; reachable UI call at `Modules/Structural/UI/Palette/ChecklistPanel.xaml.cs:758`.

   **What Tim meets:** A colleague sends a checklist suggestion and receives confirmation. Later, someone saves the checklist templates. The suggestion disappears without being reviewed, and the window says there are no pending suggestions.

   **Exact failure scenario:** A writable Templates folder contains ordinary template JSON files and `pending_changes.json`. Saving templates runs a deletion loop that includes the pending-suggestions file.

   **Proof:** `SubmitSuggestion` stores suggestions in `Path.Combine(_templatesFolder, "pending_changes.json")` at 1328 and writes it at 1348. `SaveAllTemplates` enumerates every `*.json` in that same folder at 1298 and deletes each at 1302. It then saves only ChecklistTemplate objects at 1312–1314; it does not restore the suggestions file. `ChecklistPanel.ShowTemplateSelector` calls this routine when `TemplatesWereEdited` is true at 756–759. `TemplateSelectorDialog.xaml.cs:152` sets that flag after the editor returns Save Changes. `GetPendingSuggestions` returns an empty list when the file is missing at 1366–1368; the palette displays “No pending template suggestions.” at 947. This is Structural checklist functionality, not parked Manager administrator work.

   **DETERMINISTIC TEST — fixture:** Use an isolated, writable DataFolder and a fresh AutoCAD session with standard checklist templates loaded, initially no `Templates/pending_changes.json`. Use a disposable drawing. Type `CECHECKLIST`, click `Select Template`, choose a Structural Residential template and `Apply`.

   **Click steps:** Click `Suggest Edit`; choose `Add a new checklist item`; select an existing category; enter item text `S15 CHECK` and reason `S15 audit fixture`; click `Send suggestion`. Dismiss “Suggestion Submitted”. Confirm on disk that `pending_changes.json` contains exactly one pending suggestion and record its ID. Without restarting, reloading templates or opening the suggestions viewer, click `Select Template` → `Edit Templates...` → `Save Changes`, then close the selector with `Cancel`. The editor save still triggers the caller's `TemplatesWereEdited` branch. Click the clipboard button whose tooltip is `View pending template suggestions` in the checklist palette.

   **Assertion:** The recorded suggestion must still exist with status pending and be visible for review. The code predicts that `pending_changes.json` is missing, the CE log says “Saved edited templates to disk”, and the palette shows “No pending template suggestions.” The deliberate ordering prevents a separate template-reload issue from obscuring this deletion.

5. **Scope, exclusions and confidence.**

   Source: `C:/Lisp Files/CE_ACAD_PLUGIN`, fetched Git ref `origin/claude/rel-20261022s2`, pinned commit `2c9a96942a024888a5ab520600f2d5025de83036` (Structural 1.0.121). File:line references above belong to that commit, not the working tree. All 331 requested files were retrieved individually with `git show`, largest first: 84 Commands, 81 Core, 37 Models and 129 UI files; total source size 3,973,287 bytes. Central command/UI/storage paths were then traced to establish the four findings. The inventory below records those file reads; it is not a claim that every runtime path was exercised.

   Prior reports consulted: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_CIVIL_22OCT.md` and `CODEX_AUDIT_GATE_22OCT.md`, plus the 22 October Structural-command, window and record hunts for overlap. Their existing unit-scale, UCS, hatch, settings, hidden-layer, DPI and command-outcome findings are not repeated. The support-switch cancellation behaviour was not counted as a defect. No suspected-only item is included.

   No new command prohibition or engineering setting is proposed. R-27 and R-00 remain applicable. The Civil + Manager colleague release date remains 9 November; this Structural audit does not change that scope. Manager administrator work remains parked. Only this findings file is authorised for commit and push in CE_PLAN.

6. **File-read inventory — all 331 requested paths, in descending source-size order.**

```text
Modules/Structural/Models/UserSettings.cs
Modules/Structural/Core/Checklist/TemplateManager.cs
Modules/Structural/UI/Palette/MainPalette.xaml.cs
Modules/Structural/Commands/SupportBlockCommands.cs
Modules/Structural/Commands/HatchCommands.cs
Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml.cs
Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml.cs
Modules/Structural/Commands/RafterJoistCommands.cs
Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml
Modules/Structural/Commands/BeamPlacementCommands.cs
Modules/Structural/Core/Notes/SharedNotesManager.cs
Modules/Structural/Commands/DimensionCommands.cs
Modules/Structural/UI/Palette/NotesPanel.xaml.cs
Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml
Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml.cs
Modules/Structural/Core/JobTime/JobTimeTracker.cs
Modules/Structural/UI/Dialogs/NotesBrowserDialog.xaml.cs
Modules/Structural/Commands/HatchPersistencePolicy.cs
Modules/Structural/Core/Reports/ReportManager.cs
Modules/Structural/UI/FstManagerWindow.xaml
Modules/Structural/Commands/BracingCommands.cs
Modules/Structural/UI/Palette/ChecklistPanel.xaml.cs
Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs
Modules/Structural/Commands/HatchUpgradeCommands.cs
Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml.cs
Modules/Structural/Models/CeSheetsModels.cs
Modules/Structural/UI/FstManagerWindow.xaml.cs
Modules/Structural/Commands/SupportBlockDefinitionUpgradeService.cs
Modules/Structural/Commands/RebarCommands.cs
Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.cs
Modules/Structural/UI/Dialogs/XclmTxtAdvancedEditDialog.xaml.cs
Modules/Structural/UI/Dialogs/NoteEntryDialog.xaml.cs
Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml.cs
Modules/Structural/Core/PlanLevels/PlanLevelRecord.cs
Modules/Structural/Core/Roofs/RoofPointLoadAcrossDrawings.cs
Modules/Structural/Core/Rebar/ReoBarCore.cs
Modules/Structural/Models/ExcelImportModels.cs
Modules/Structural/Commands/LoadBearingWallCommands.cs
Modules/Structural/Commands/SbeamEditCommandRunner.cs
Modules/Structural/Commands/SoilAndWindCommands.cs
Modules/Structural/UI/Palette/MainPalette.xaml
Modules/Structural/UI/Palette/MemberCataloguePanel.xaml.cs
Modules/Structural/UI/Dialogs/HatchPreviewGeometry.cs
Modules/Structural/UI/Dialogs/CeHatchPresetDialog.cs
Modules/Structural/UI/StrucSuiteWindow.xaml
Modules/Structural/Commands/MarkupAICommands.cs
Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.Preview.cs
Modules/Structural/Commands/CeMemberCommands.cs
Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml
Modules/Structural/Models/XclmTxtModels.cs
Modules/Structural/Commands/SectionDetailCommands.cs
Modules/Structural/UI/Palette/CommandsPanel.xaml
Modules/Structural/UI/Palette/CommandsPanel.xaml.cs
Modules/Structural/Models/FoundationStatusWords.cs
Modules/Structural/Commands/UnitCopyCommands.cs
Modules/Structural/UI/Dialogs/TemplateEditorDialog.xaml.cs
Modules/Structural/Commands/InspectCommands.cs
Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml
Modules/Structural/UI/Dialogs/CommandHelpWindow.xaml.cs
Modules/Structural/Core/Schedules/MemberScheduleFromPlan.cs
Modules/Structural/Core/Framing/LintelProposalPlanner.cs
Modules/Structural/Commands/BeamSettingsCommand.cs
Modules/Structural/Core/LevelCarry/LevelCarryRecord.cs
Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml
Modules/Structural/UI/Dialogs/ReportsDialog.xaml.cs
Modules/Structural/Models/XclmTxtScheduleReconstruction.cs
Modules/Structural/Core/Checklist/ChecklistItem.cs
Modules/Structural/Commands/BeamTextConvertCommands.cs
Modules/Structural/Core/Roofs/RoofPointLoadMarkers.cs
Modules/Structural/Commands/ColumnDetailCommands.cs
Modules/Structural/UI/Palette/MarkupAIPanel.xaml.cs
Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml.cs
Modules/Structural/UI/Dialogs/TemplateEditorDialog.xaml
Modules/Structural/Models/FoundationModels.cs
Modules/Structural/UI/Dialogs/RCMemberDialog.xaml
Modules/Structural/UI/LayerManagerWindow.xaml.cs
Modules/Structural/UI/Themes/Theme.Base.xaml
Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml.cs
Modules/Structural/UI/Dialogs/FloatingTimerWindow.xaml.cs
Modules/Structural/UI/Dialogs/CeIssuePublishDialog.xaml.cs
Modules/Structural/Core/Subfloor/TimberSubfloorGridPlanner.cs
Modules/Structural/UI/LayerManagerWindow.xaml
Modules/Structural/Core/Marks/MemberMarkEngine.cs
Modules/Structural/Commands/SectionMarkCommands.cs
Modules/Structural/Core/JobParser/JobParser.cs
Modules/Structural/Commands/BeamLinkMigrateCommand.cs
Modules/Structural/UI/Palette/MemberCataloguePanel.xaml
Modules/Structural/UI/Dialogs/NotesBrowserDialog.xaml
Modules/Structural/Core/Checklist/ChecklistStorage.cs
Modules/Structural/Commands/BeamExtendCommands.cs
Modules/Structural/UI/Themes/StructuralEditorShellTheme.xaml
Modules/Structural/Models/ProjectData.cs
Modules/Structural/Commands/LevelMarkCommands.cs
Modules/Structural/Core/Framing/FramingLegendPlanner.cs
Modules/Structural/Models/MarkupAIModels.cs
Modules/Structural/UI/Dialogs/ViewSuggestionsDialog.xaml.cs
Modules/Structural/Core/Roofs/RoofSetoutPlanner.cs
Modules/Structural/UI/Dialogs/CommandHelpWindow.xaml
Modules/Structural/Core/Roofs/RoofAreaGeometry.cs
Modules/Structural/Core/Roofs/RoofPointLoadCarryDown.cs
Modules/Structural/Commands/WeldMarkCommands.cs
Modules/Structural/UI/Dialogs/CePropsDialog.xaml
Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.Edit.cs
Modules/Structural/Models/XclmTxtLearningLogic.cs
Modules/Structural/Core/JobTime/JobTimeSession.cs
Modules/Structural/Commands/LegacyPortCommands.cs
Modules/Structural/UI/Palette/SheetsPanel.xaml.cs
Modules/Structural/Models/XclmTxtFloorConvention.cs
Modules/Structural/Core/Units/UnitCopyPlan.cs
Modules/Structural/Core/Notes/OfficeNotesLibrary.cs
Modules/Structural/Core/Notes/GeneralNotesAssembler.cs
Modules/Structural/Commands/UtilityCommands.cs
Modules/Structural/Commands/SbeamCommandRunner.cs
Modules/Structural/UI/Dialogs/XclmTxtAdvancedEditDialog.xaml
Modules/Structural/Core/Units/UnitScheduleGrouper.cs
Modules/Structural/UI/Dialogs/CommandPaletteWindow.xaml
Modules/Structural/UI/TimeEntryBrowserWindow.xaml.cs
Modules/Structural/UI/Palette/ChecklistPanel.xaml
Modules/Structural/UI/Dialogs/AboutDialog.xaml
Modules/Structural/Core/Notes/NoteStorage.cs
Modules/Structural/Commands/LineStyleCommands.cs
Modules/Structural/Commands/CeTextCommands.cs
Modules/Structural/Models/ConnectedDesign/ConnectedStructuralRecord.cs
Modules/Structural/UI/Dialogs/CommandPaletteWindow.xaml.cs
Modules/Structural/UI/Palette/PaletteManager.cs
Modules/Structural/UI/Palette/NotesPanel.xaml
Modules/Structural/UI/Palette/MarkupAIPanel.xaml
Modules/Structural/Commands/AdminCommands.cs
Modules/Structural/Core/Schedules/MemberScheduleRead.cs
Modules/Structural/Core/Notes/LeaderNoteSuggester.cs
Modules/Structural/Core/Schedules/WallScheduleBuilder.cs
Modules/Structural/UI/Dialogs/NoteEntryDialog.xaml
Modules/Structural/Commands/BatterCommands.cs
Modules/Structural/UI/Dialogs/CeSheetsValidationReportWindow.xaml
Modules/Structural/UI/Dialogs/RCLigDialog.xaml
Modules/Structural/UI/AutoCadWindowHostHelper.cs
Modules/Structural/Commands/StructuralGripEditCommands.cs
Modules/Structural/Commands/SchedulingCommands.cs
Modules/Structural/UI/Dialogs/BeamSettingsDialog.xaml
Modules/Structural/UI/Palette/SelectedBeamInspectorPanel.xaml
Modules/Structural/Core/LevelCarry/LevelCarryGeometry.cs
Modules/Structural/Models/FstMemoryData.cs
Modules/Structural/UI/Dialogs/CeSheetsSyncPreviewWindow.xaml
Modules/Structural/Commands/CeStrucCommandBase.cs
Modules/Structural/Core/Symbols/NotesDrawingGuards.cs
Modules/Structural/Core/Units/UnitTagPrefix.cs
Modules/Structural/UI/Dialogs/TemplateSelectorDialog.xaml
Modules/Structural/UI/Dialogs/CeProjectSetupDialog.xaml
Modules/Structural/Core/Bracing/BracingWallSpan.cs
Modules/Structural/Commands/HatchBoundaryClosePolicy.cs
Modules/Structural/UI/Dialogs/CeSheetsValidationReportWindow.xaml.cs
Modules/Structural/Commands/BreaklineCommands.cs
Modules/Structural/UI/Dialogs/ReportsDialog.xaml
Modules/Structural/Commands/JobTimerDebugCommand.cs
Modules/Structural/UI/Dialogs/ColumnVisibilityPickerDialog.cs
Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.SteelTimberExtras.cs
Modules/Structural/UI/Dialogs/FloatingTimerWindow.xaml
Modules/Structural/UI/Dialogs/SuggestEditDialog.xaml.cs
Modules/Structural/UI/Dialogs/SettingsDialog.xaml.cs
Modules/Structural/UI/Dialogs/BracingPanelWindow.xaml.cs
Modules/Structural/Core/Notes/Note.cs
Modules/Structural/UI/Dialogs/IdlePromptDialog.xaml
Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml
Modules/Structural/UI/Dialogs/AdminHubWindow.xaml
Modules/Structural/UI/Dialogs/ScreenSnipOverlayForm.cs
Modules/Structural/UI/Dialogs/HatchBoundaryWarningDialog.cs
Modules/Structural/Core/Symbols/SlabStepPlanner.cs
Modules/Structural/UI/Dialogs/CeSharedTitleMappingWindow.xaml.cs
Modules/Structural/Core/Rebar/ReoBarLiveRules.cs
Modules/Structural/Core/Framing/BeamHoverLine.cs
Modules/Structural/Core/Units/DrawingScaleRule.cs
Modules/Structural/UI/JobTimerToast.xaml.cs
Modules/Structural/UI/TimeEntryBrowserWindow.xaml
Modules/Structural/Commands/BracingPanelCommands.cs
Modules/Structural/Models/MarkupAIAutomationModels.cs
Modules/Structural/UI/Dialogs/TemplateSelectorDialog.xaml.cs
Modules/Structural/Commands/AutoSupportCommands.cs
Modules/Structural/UI/Themes/StructuralWindowTheme.cs
Modules/Structural/Core/Units/MLeaderSideRule.cs
Modules/Structural/Core/Units/DimensionFactorReadback.cs
Modules/Structural/Commands/StrucDebugCommand.cs
Modules/Structural/UI/Dialogs/SuggestEditDialog.xaml
Modules/Structural/UI/Dialogs/SettingsDialog.xaml
Modules/Structural/Core/Framing/LintelJobRules.cs
Modules/Structural/Core/Marks/WallMarkPlanner.cs
Modules/Structural/Core/Marks/FoundationMarkPrefixes.cs
Modules/Structural/UI/Dialogs/CeProjectSetupDialog.xaml.cs
Modules/Structural/Commands/BeamInsidePointCommands.cs
Modules/Structural/UI/Dialogs/RCBeamPickerDialog.xaml
Modules/Structural/Commands/TieDownCommands.cs
Modules/Structural/UI/Dialogs/CeSharedTitleMappingWindow.xaml
Modules/Structural/Core/Schedules/MemberScheduleBlockSplitter.cs
Modules/Structural/Commands/ExcelMTextCommands.cs
Modules/Structural/Core/Schedules/ScheduleRowLink.cs
Modules/Structural/Core/Units/UnitScheduleHeadings.cs
Modules/Structural/Core/Symbols/ClearSpot.cs
Modules/Structural/UI/Dialogs/RCLigDialog.xaml.cs
Modules/Structural/Models/MarkupAICorpusStandardsModels.cs
Modules/Structural/Core/Notes/PlanMarkSuffix.cs
Modules/Structural/Core/Units/SectionMarkIdentifierRule.cs
Modules/Structural/Models/XclmTxtDisplayHelpers.cs
Modules/Structural/Core/Floors/FloorSetoutPlanner.cs
Modules/Structural/Core/Units/UnitLinkGroup.cs
Modules/Structural/UI/Dialogs/CeIssuePublishDialog.xaml
Modules/Structural/Core/Schedules/LintelTableSource.cs
Modules/Structural/UI/Dialogs/AdminHubWindow.xaml.cs
Modules/Structural/UI/Palette/SelectedBeamInspectorPanel.xaml.cs
Modules/Structural/UI/Dialogs/AboutDialog.xaml.cs
Modules/Structural/UI/Palette/SheetsPanel.xaml
Modules/Structural/Commands/DiagnosticsCommands.cs
Modules/Structural/Models/AccessibleNames.cs
Modules/Structural/Commands/UiCommands.cs
Modules/Structural/UI/Dialogs/CePropsDialog.xaml.cs
Modules/Structural/Core/Units/UnitDrawingSettings.cs
Modules/Structural/Commands/SupportBlockDefinitionUpgradePolicy.cs
Modules/Structural/Models/MemberCatalogue/MemberCatalogueModels.cs
Modules/Structural/UI/Dialogs/CeNewSheetDialog.xaml.cs
Modules/Structural/Commands/MLeaderCommands.cs
Modules/Structural/Models/MarkupAIStandardsModels.cs
Modules/Structural/Core/Roofs/GirderTrussMarkEngine.cs
Modules/Structural/Core/Roofs/SpanArrowPlanner.cs
Modules/Structural/Core/JobParser/JobInfo.cs
Modules/Structural/UI/Dialogs/CeNewSheetDialog.xaml
Modules/Structural/Core/Rebar/ReoEntryRules.cs
Modules/Structural/Models/CeProjectSetupModels.cs
Modules/Structural/UI/MarkupWindow.xaml.cs
Modules/Structural/Core/Schedules/WallScheduleGrid.cs
Modules/Structural/Core/Units/UnitText.cs
Modules/Structural/UI/Dialogs/IdlePromptDialog.xaml.cs
Modules/Structural/Core/Notes/NotesLibraryResolver.cs
Modules/Structural/Core/JobParser/ClientPrefixConfig.cs
Modules/Structural/UI/XclmTxtConverters.cs
Modules/Structural/UI/Dialogs/CategoryManagerDialog.xaml
Modules/Structural/Commands/AutoSupportReferenceCommands.cs
Modules/Structural/UI/Dialogs/CategoryManagerDialog.xaml.cs
Modules/Structural/Core/SupportSizeChoices.cs
Modules/Structural/Core/BeamDistanceChoices.cs
Modules/Structural/Models/BeamLinkData.cs
Modules/Structural/UI/Dialogs/CeSheetsSyncPreviewWindow.xaml.cs
Modules/Structural/Core/Schedules/MemberSchedulePlacementRule.cs
Modules/Structural/Core/Units/SectionIdentifierSequence.cs
Modules/Structural/Core/Footings/FootingWidthAsk.cs
Modules/Structural/Core/Units/CurrentAppearanceRule.cs
Modules/Structural/UI/Dialogs/CeProgressDialog.xaml.cs
Modules/Structural/Commands/BeamLinkDebugCommand.cs
Modules/Structural/Core/Roofs/TrussDirectionPlanner.cs
Modules/Structural/UI/Palette/PaletteThemeHelper.cs
Modules/Structural/Models/MemberCatalogue/MemberCatalogueInspectorModels.cs
Modules/Structural/Commands/Base/BaseStructuralCommand.cs
Modules/Structural/UI/Dialogs/BracingPanelWindow.xaml
Modules/Structural/UI/Dialogs/ViewSuggestionsDialog.xaml
Modules/Structural/Core/Notes/NotePathHelper.cs
Modules/Structural/UI/Dialogs/ExcelSheetPickerDialog.xaml
Modules/Structural/Commands/Base/StructuralDetailHelpers.cs
Modules/Structural/UI/Dialogs/ExcelSheetPickerDialog.xaml.cs
Modules/Structural/Commands/SteelworkDetailCommands.cs
Modules/Structural/Models/ExcelWorkbenchModels.cs
Modules/Structural/UI/Dialogs/CeAlertDialog.xaml.cs
Modules/Structural/Models/FoundationPlanSettings.cs
Modules/Structural/Core/ScheduleSetPlan.cs
Modules/Structural/UI/Dialogs/CeProgressDialog.xaml
Modules/Structural/Models/CePlannedPlotPage.cs
Modules/Structural/Core/Footings/FootingSizeLimitRule.cs
Modules/Structural/Commands/SheetsCommands.cs
Modules/Structural/UI/Dialogs/CeAlertDialog.xaml
Modules/Structural/Models/FoundationProposalSettings.cs
Modules/Structural/UI/Dialogs/BracingPanelPlacement.cs
Modules/Structural/Models/ReoBarSettings.cs
Modules/Structural/Models/CommandRegistryModels.cs
Modules/Structural/Core/Units/SectionMarkTag.cs
Modules/Structural/Core/Symbols/StepTagBlockLocator.cs
Modules/Structural/UI/JobTimerToast.xaml
Modules/Structural/Core/Symbols/ModelSpaceWriteGuard.cs
Modules/Structural/Core/Footings/FeditSavedSizeRule.cs
Modules/Structural/Models/ConnectedDesign/SelectedBeamInspectorModels.cs
Modules/Structural/Commands/FootingGripCommands.cs
Modules/Structural/UI/Dialogs/SettingsSaveAttempt.cs
Modules/Structural/UI/Themes/Theme.SwissModern.xaml
Modules/Structural/Commands/NotesSymbolsCommands.cs
Modules/Structural/Commands/JobTimerEditCommand.cs
Modules/Structural/Models/CeDrawingPropertiesModel.cs
Modules/Structural/Models/XclmTxtLearnedCorrections.cs
Modules/Structural/UI/StrucSuiteWindow.xaml.cs
Modules/Structural/Core/Units/PaperSpaceSizeRule.cs
Modules/Structural/UI/Themes/Theme.SwissModern.Dark.xaml
Modules/Structural/Core/Rebar/ReoStartValues.cs
Modules/Structural/Core/Units/UnitSkippedObject.cs
Modules/Structural/Commands/BasementCommands.cs
Modules/Structural/UI/Themes/StructuralEditor.Dark.xaml
Modules/Structural/UI/Themes/StructuralEditor.Light.xaml
Modules/Structural/Commands/BeamCommandsShared.cs
Modules/Structural/UI/MarkupWindowHost.cs
Modules/Structural/Models/WallScheduleSettings.cs
Modules/Structural/Commands/TimberSubfloorCommands.cs
Modules/Structural/Commands/ReinforcementDetailCommands.cs
Modules/Structural/Core/Footings/BoredPierDiameterChoice.cs
Modules/Structural/Models/LintelTableSettings.cs
Modules/Structural/Core/Units/LabelTextHeightRule.cs
Modules/Structural/Commands/FoundationScheduleCommands.cs
Modules/Structural/Commands/LayerManagerCommands.cs
Modules/Structural/Models/CommandHubTagSettings.cs
Modules/Structural/Commands/ReoBarCommands.cs
Modules/Structural/Commands/FoundationPlanCommands.cs
Modules/Structural/UI/MarkupWindow.xaml
Modules/Structural/Commands/WallScheduleCommands.cs
Modules/Structural/Commands/PierCommands.cs
Modules/Structural/Commands/StructuralWakeCommand.cs
Modules/Structural/UI/Dialogs/SettingsAppearancePreview.cs
Modules/Structural/UI/Dialogs/StructuralDisplayText.cs
Modules/Structural/Commands/LintelProposalCommands.cs
Modules/Structural/Models/FoundationCenterlineChoice.cs
Modules/Structural/UI/Dialogs/CeValidationSummaryText.cs
Modules/Structural/Commands/FloorSetoutCommands.cs
Modules/Structural/Commands/MemberScheduleCommands.cs
Modules/Structural/UI/Palette/StructuralInspectorPanel.xaml.cs
Modules/Structural/Commands/LevelCarryCommands.cs
Modules/Structural/Commands/RoofSetoutCommands.cs
Modules/Structural/Commands/LintelTableCommands.cs
Modules/Structural/Commands/PointLoadCommands.cs
Modules/Structural/Core/Day1UnitsGuard.cs
Modules/Structural/Commands/FramingLegendCommands.cs
Modules/Structural/Commands/PlanLevelCommands.cs
Modules/Structural/Commands/MarkupQaCheckCommands.cs
Modules/Structural/Commands/SlabDetailCommands.cs
Modules/Structural/UI/Palette/StructuralInspectorPanel.xaml
Modules/Structural/Models/LinkData.cs
Modules/Structural/Models/FoundationGripSettings.cs
Modules/Structural/Commands/FootingProposalCommands.cs
Modules/Structural/Commands/ArchitecturalChangeReviewCommands.cs
Modules/Structural/Commands/LoadPathCommands.cs
Modules/Structural/Commands/CeSettingsCommands.cs
```

7. **Summary.** Four new faults were verified by code reading: support switches alter unrelated text; BEXTEND intersects curved polylines incorrectly; a failed notes read can become a destructive successful save; and saving checklist templates deletes pending suggestions. Each finding has a precise synthetic fixture, an AutoCAD interaction sequence and an observable assertion. No runtime result is claimed. No source repository was changed, and no build, test, installation or AutoCAD session was run.
