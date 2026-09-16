# Structural high-use window action contract

**Purpose.** This companion to the retained-control ledger follows source-observed action paths for high-use Structural windows that can change a drawing, working draft, or user record. It preserves controls and action order for review. It is not runtime proof or a decision to retain every implementation detail.

- Full 47-surface control inventory: [structural_retained_control_ledger.md](structural_retained_control_ledger.md).
- Command and entry-route inventory: [structural_source_command_window_ledger.md](structural_source_command_window_ledger.md).
- Workflow intent and review cards: [structural_workflow_cards.md](structural_workflow_cards.md).
- Shared project, sheet/issue, settings, Manager, AI, and installer behaviour remains root-owned even where a surface sits in Modules/Structural.
- **Evidence boundary:** statements below are bounded current-source observations. They do not prove visibility, successful AutoCAD execution, persistence compatibility, or Tim acceptance.
- Historical source initialisers are evidence only. This contract proposes no engineering or drafting number.

## Planning terms

| Term | Meaning |
|---|---|
| Preserve for review | Do not remove, merge, or silently repurpose the existing route before its owner reviews the AutoCAD outcome. |
| Keep/Modify proposal | Existing source route; intended future result needs Tim review and AutoCAD acceptance. |
| Root interface | Preserve control and handoff boundary while shared owner resolves behaviour. This planner does not redesign it. |
| Unknown | Source did not establish the claimed result, visibility, persistence, or recovery behaviour. |

## A. Beam Settings — W3 framing/supports

**Observed entry:** Modules/Structural/Commands/BeamSettingsCommand.cs:32 creates BeamSettingsDialog. The complete editable-control list is in the retained-control ledger.

| Existing action / source | Source-observed effect | Preservation and review gate |
|---|---|---|
| Reset Remembered Choices — UI/Dialogs/BeamSettingsDialog.xaml.cs:123-142 | Replaces working remembered quick-choice fields and tells the user Save is needed. | **Keep/Modify proposal.** Reset stays local until Save. Cancel must leave stored choices unchanged. Source choices are not approved design settings. |
| Save — …BeamSettingsDialog.xaml.cs:144-247 | Validates offset/context/tolerance/search/support fields. On success copies the dialog state to ResultSettings, sets DialogResult true, and closes. Invalid input focuses the failed field. | Preserve field-level feedback, explicit save, and working-versus-result state. What changes future placement versus existing entities is Unknown. |
| Cancel — …BeamSettingsDialog.xaml.cs:250-253 | Sets DialogResult false and closes. | Preserve. Acceptance must show no setting or drawing change. |
| Support preview and Escape choices — …:36-37, 72-73, 237-238 | Carries check-state for rotation preview and whole-flow Escape cancellation into result settings. | Preserve separately. The source does not prove a native preview/grip/Undo result. W3/W4 acceptance must test placed support, Escape before commit, and save/reopen. |

The window passes an in-memory result to its command route. It is not evidence that a beam/support relation is inferred safely, that an Xref is editable, or that background geometry is structural evidence. W3/W4 retain explicit scope, manual/pinned state, visible preview, and normal locked-layer/Xref/REFEDIT protections.

## B. FST library and foundation manager — W5

**Observed entries:** Modules/Structural/Services/CeTextService.cs:1831 and Modules/Structural/Services/FoundationService.cs:692 create FstManagerWindow. The exact approved `ST-06` and FST action split are retained in [structural_approved_card_reconciliation.md](structural_approved_card_reconciliation.md).

| Existing action / source | Source-observed effect | Preservation and review gate |
|---|---|---|
| Library Add / Delete / Sort — UI/FstManagerWindow.xaml.cs:230-264; cell completion :648 | Changes selected size-library rows. XAML exposes keyed size rows for several foundation families. | **Keep/Modify proposal.** Retain explicit row scope, editable key/dimension fields, and Cancel/Save separation. A library row is not job engineering approval. |
| Refresh / system selection — …:366-371 | Refreshes manager data and responds to selected-system change. | Preserve for review. A displayed status does not prove a complete model. |
| Regenerate selected / all — …:376-386 | Calls `FoundationService.RegenerateSystemFromUi` immediately, then refreshes the manager. | Existing action is immediate, not a Save-controlled draft. Preserve distinct scope; a future reviewed replacement needs affected-item preview, manual/pinned override retention and defined action-level Undo. |
| Delete selected / Zoom selected — …:426-445 | Delete confirmation then `DeleteElementFromUi` immediately; Zoom operates on the chosen element record. | Existing deletion is immediate. Preserve selected-item confirmation and native protection checks; a future `ST6-9` route must show Element-only/Entire-system counts before Apply. An element list does not permit changing Xref, locked, or foreign content. |
| Rename / Delete system — …:455-524 | Rename prompts then calls `RenameSystemFromUi` immediately; delete confirmation says “This cannot be undone” then calls delete immediately. | Existing actions are immediate. Preserve confirmation/revision evidence; do not claim Cancel reverses a completed rename/delete. |
| Re-link / Remove orphan / diagnostics — …:537-640 | Separate orphan remediation and diagnostic-log actions. | Preserve as recovery paths. They do not prove automatic relinking is safe. Require candidate source, change preview, Cancel, one Undo, and save/reopen review. |
| Save Size Library / Cancel — …:524-534 | Save calls `CommitAllEdits()` then closes; Cancel only closes. This split is evidenced for size-library edits, not manager operations above. | Preserve separation for library rows only. Acceptance: edit row → Cancel → reopen; Save → reopen shows data location. |

Manager XAML shows systems, elements, diagnostics, orphans, label, kind, driver handle and override signal. Preserve those review signals; do not collapse an override into a calculated label or assume a listed record is complete.

## C. RC member, RC beam picker, steel picker — W6

| Window / action | Source-observed effect | Preservation and review gate |
|---|---|---|
| RCMemberDialog live input — UI/Dialogs/RCMemberDialog.xaml.cs:297-318 | Text/combo/top-bar changes re-render the canvas and run source warning logic. Top-bar check state controls its corresponding fields. | **Keep/Modify proposal.** Preserve large visual preview and invalid-input feedback. Preview depicts typed input; it is not a design calculation or approval. |
| RCMemberDialog Place Section / Cancel — …:322-452 | Validates positive entered values and selected bar/tie values, builds an RCMemberResult for beam/rectangular/circular mode, then closes. Cancel closes. | Preserve typed result versus drawing insertion. AutoCAD acceptance: invalid input remains editable; Cancel makes no drawing change; placement then Undo/save/reopen is reviewed. |
| RCBeamPickerDialog Place / Cancel — UI/Dialogs/RCBeamPickerDialog.xaml.cs:202-213 | Accepts picker result or closes. XAML separates Beam Types and Ligature Types. | Preserve tabs and selected-type result. Runtime placement/output is Unknown. |
| SteelSectionPicker selection and view — UI/Dialogs/SteelSectionPickerDialog.xaml.cs:63-108, 173-228 | Family, section, timber dimensions, view, flange orientation and scale re-render preview; flange controls are restricted to source-recognised asymmetric family/elevation combinations. | Preserve selection-dependent availability and preview. Do not replace with a universal control set that enables irrelevant orientation. |
| SteelSectionPicker Place / Cancel — …:237-262 | Builds selection result and closes; Cancel closes. | Preserve explicit placement. Catalogue completeness, drawing output, and discoverability are Unknown. |

A copied detail, manually adjusted label, missing catalogue item, or changed background remains a separate review state. None of these pickers may silently make a preview selection an approved detail standard.

## D. Excel-to-text schedule cockpit — W8

**Observed entry:** Modules/Structural/Services/XclmTxtService.cs:161-166 opens the Excel sheet picker and XclmTxtDialog. Project-to-issue publication after schedule review is root-owned.

| Existing action / source | Source-observed effect | Preservation and review gate |
|---|---|---|
| Choose sheet — UI/Dialogs/ExcelSheetPickerDialog.xaml.cs:33-52 | Requires a selected sheet before DialogResult true; Cancel returns false. | Preserve explicit source/sheet choice. Candidate selection is not source adoption or currency. |
| Change Source / Change Sheet / Refresh Past Jobs / Start Fresh / Re-analyze — UI/Dialogs/XclmTxtDialog.xaml.cs:588, 676, 757, 825, 840 | Loads/refreshes a review draft. Source change sets current draft and saves it. | **Keep/Modify proposal.** Preserve source identity, sheet name, candidate/review display, and fresh-start route. Do not quietly overwrite a chosen source. |
| Apply suggestions — …:848-1006, 1113-1133 | Takes an undo snapshot. If no source-defined safe fix exists, removes that snapshot and directs user to Accept, Dismiss, Exclude, or manual editor. | Preserve safe-fix boundary, alternatives, and action-level Undo. “Safe” is implementation wording, not engineering acceptance. |
| Accept As Is / Dismiss / Exclude rows — …:1135-1198, 1371-1381 | Records issue state/reason/time; exclusion changes Include after an undo snapshot, then re-analyses/saves. | Preserve separate outcomes. Accepted, dismissed, excluded are not source truth or design decision. |
| Set affected rows to level / Include or exclude — …:1200-1238 | Applies user-selected level or inclusion state to affected rows. | Preserve explicit row scope, repeated marks across levels, and manual review. No inferred floor assignment. |
| Insert — …:1240-1281 | Requires selected proposal, insert gate, custom blocking warning, then explicit drawing-modification confirmation naming member count and selected levels. | Preserve gates and confirmation. Acceptance covers missing workbook, conflicting selection, failed gate, Cancel at confirmation, drawing Undo, save/reopen. |
| Close / Undo — …:1300-1304, 1457-1470 | Close saves draft. Undo uses a bounded local row-snapshot stack. | Preserve draft review and distinction between cockpit Undo and AutoCAD drawing Undo. A saved draft is not automatically a governing issue source. |

## E. Notes and time — W0 support tools

| Window / action | Source-observed effect | Preservation and review gate |
|---|---|---|
| Notes panel — UI/Palette/NotesPanel.xaml and …xaml.cs:728, 847, 1118 | Exposes notes/tags/all-jobs, add note/tag, edit tags, refresh; some actions launch note entry/browser. | **Keep/Modify proposal.** Preserve add/browse/filter routes and explicit Save/Cancel in note entry. Project identity/permission scope remains Unknown. |
| Notes browser — UI/Dialogs/NotesBrowserDialog.xaml.cs:830, 1034, 1039, 1073 | Has edit-tags, refresh, add-note, close. XAML exposes global search and user/tag/attachment/status filters. | Preserve filter scope and action separation. Review a note tied to changed markup and one with missing attachment without claiming it resolves attachment state. |
| Time entry browser — UI/TimeEntryBrowserWindow.xaml.cs:151, 163, 192, 241 | Has Apply filter, Delete selected, Save changes, Close; XAML has date/job/user filters and entry grid. | Preserve explicit filter, selected-row deletion, and save/close boundaries. Generic field labels only are recorded; no actual job/client data. Acceptance covers unsaved/deleted row, save/reopen, background/project change. |

## F. Contextual, ribbon, and diagnostic routes

| Route | Bounded source evidence | Required planning treatment |
|---|---|---|
| Beam/support/bracing context | Command/service routes listed in the source ledger contain point/entity/selection prompts. | Preserve explicit selection and confirmation. A prompt does not prove contextual palette, grip, relationship, or background interpretation. |
| Detail/foundation/schedule selection | The managers/pickers above hold selection state. | Keep selection separate from source adoption, output placement, and issue acceptance. |
| Ribbon/classic menu/help | CeStrucRibbonContributor, StructuralRibbonDefinitionService, RibbonCommandHubService, CuiMenuGeneratorService and registry services are source-observed. | Preserve command identity/group/help route; runtime visibility/parity is Unknown. |
| Native/custom grips | Bounded Modules/Structural scan did not establish a direct GripOverrule handler. | Do not claim grips globally absent. Approved shared-native direction belongs to its owner; W3/W4/W5 retain grip acceptance requirements. |
| Diagnostics/recovery | FST diagnostics, CeAlert, Admin, progress, reporting surfaces appear in the ledger. | Preserve diagnostic output and non-destructive Cancel/Close. Repair/migration needs source, preview, backup/Undo and owner-approved acceptance before implementation. |

## Action-specific future acceptance

1. **Working-state cancellation:** edit Beam Settings, an FST row, RC member inputs and XCLMTXT rows; cancel each applicable window; verify the right state is unchanged before and after reopen.
2. **Scoped Undo:** apply one cockpit change then undo it there; insert only after confirmation and prove drawing Undo separately. Regenerate/relink foundation items only after its own preview and one action-level Undo are defined.
3. **Selection and protection:** test selected beam/support/foundation/detail routes on a locked layer, Xref and unsupported object. Native protection remains visible; no route may bypass it.
4. **Evidence and revision:** change a background/markup source, leave a manual label or missing workbook/detail source unresolved, reopen manager/cockpit, and confirm the review signal remains visible rather than silently replaced.
5. **Shared handoff:** after a successful or blocked Structural review, use the root-owned project-to-issue path. Failed handoff reports the boundary and preserves Structural review state. This makes no claim about newer owner planning outside this checkout.

| Established from source | Still Unknown / owner review |
|---|---|
| Named windows, main action handlers, validation routes, local working/result boundaries, schedule draft snapshots, insert confirmation, selected-system/action separation. | Runtime reachability, drawing output, persistence destination/compatibility, AutoCAD Undo grouping, Xref/locked/REFEDIT response, preview fidelity, revision evidence quality, shared publish/history, installed version, Tim acceptance. |

**Built:** not assessed. **Tested:** no runtime or AutoCAD testing. **Installed:** not assessed. **Tim-accepted:** not assessed.



