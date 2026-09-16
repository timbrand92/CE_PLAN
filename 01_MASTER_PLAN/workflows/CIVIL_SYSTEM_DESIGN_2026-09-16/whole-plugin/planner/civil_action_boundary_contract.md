# Civil action-boundary contract — non-CD/PIT routes

**Purpose.** This contract deepens the Civil route ledger with source-observed action boundaries. It retains useful behaviour, flags source/approved-direction conflicts, and deliberately leaves active CD/PIT workshop design to its owner.

- Route/control evidence: [civil_route_control_preservation_ledger.md](civil_route_control_preservation_ledger.md).
- Detailed end-user intent: [civil_uncovered_workflow_cards.md](civil_uncovered_workflow_cards.md).
- **Status:** source observation only. No route below is proven to run in AutoCAD or is Tim-accepted.

## 1. Survey and import actions

| Existing route | Source-observed action boundary | Required retained behaviour |
|---|---|---|
| CDSURVEY — CdSurveyCommand.cs:33-162 | Selects survey Xref. It reads spot levels; if no TIN it offers raw-survey DWG selection, where Cancel keeps spot levels only. It attempts an RL-label transform and reports limited/evidence outcomes. | Retain Xref-versus-raw-source, optional skip, transform failure visibility and stored-source identity. A suggestion for future pit cover is not an adopted governing engineering value. |
| CDIMPORTXCIVIL — LinkCommands.ImportXcivil.cs:27-184 | Uses source picker/package detection, detects a prior import, prompts Replace/Abort, preserves prior import on abort/cancel, writes reports/logs and post-import QA summary. | Retain explicit replace choice, report/log evidence and no-entities-on-abort. Future review must show source candidate/provenance and preview drawing impact before replacement. |
| CDIMPORTLANDXML — …:200-311 | May offer auto-detected LandXML beside source DWG or a picker; writes report/log. | Retain auto-detected item as a candidate requiring user choice. No silent source adoption. |
| CDIMPORTCOMPARE / CDEXPORTCORPUS — …:320-607 | Source paths/project ID prompts and export/compare reports exist. | Preserve as specialist evidence/audit tools. Do not treat corpus output as a live project source or a user production workflow until owner review. No client corpus is read in this planning pass. |

## 2. Slab and site actions

| Existing route | Source-observed action boundary | Required retained behaviour |
|---|---|---|
| CDSLABIMPORT — SlabCommand.cs:33-123 | Requires selected closed polyline with enough vertices before SlabDialog. Rejections explicitly cancel. | Preserve eligibility feedback and boundary selection. Geometry is not automatically a hydraulic catchment or surface classification. |
| CDSLAB / CDSLABELEDIT / CDSLABEREGEN — …:394-1045 | Supports selected/new boundary, point collection with Undo/Cancel, dialog result, edit selection and regenerate selection. | Preserve select/draw/manual distinction, point-level Undo, Cancel without partial drawing output, and a visual fall preview before confirmed regeneration. |
| SlabEditDialog — UI/Dialogs/SlabEditDialog.xaml.cs:26-78 | OK, Cancel and Regenerate are distinct. Regenerate refreshes falls from current points then writes; failures show warning. | Preserve that action split and failure feedback. Future acceptance must distinguish preview/working state from committed regeneration and prove one drawing Undo/save-reopen. |
| CDSL / CDFALL / CDJOINT family | Declared selection/prompt routes for spot level, fall and joint placement. | Preserve direct drafting entry routes and source/manual state. No new arbitrary drafting block or numerical default is proposed. |

## 3. Profiles and schedules

| Existing route | Source-observed action boundary | Required retained behaviour |
|---|---|---|
| CDPROFILE — ProfileCommands.cs:28-112 | Requires upstream pit with CE pit data and downstream connection, then requests insertion point. It reports invalid/no path and missing levels. | Preserve selected upstream scope, path failure message, insertion confirmation and output as a drawing action. No inferred path/link from proximity. |
| PitScheduleDialog — UI/Dialogs/PitScheduleDialog.xaml.cs:43-498 | Tracks grid edits and override promotion, has cell/row restore, drag/group handlers, saved window/column layout, and flushes pending project save on close. | Preserve scope, field/row override, restore, group arrangement and saved layout. Future review must make close/save timing visible and not turn an override into calculated source truth. |
| CalculationsV2Dialog — UI/Dialogs/CalculationsV2Dialog.xaml.cs:26-43; ViewModels/CalculationsV2ViewModel.cs:37-138 | Close is separate from Add Extra. Commands include add/refresh/insert criteria/export/copy name; source has print dialog and criteria insertion. | Retain existing tab/action vocabulary and separate review state from drawing/print action. Output/criteria insertion needs source/basis confirmation, output preview, drawing Undo where applicable, and root-owned issue handoff. |

## 4. Source blocks, treatment marks and protection marks

| Existing route | Source-observed action boundary | Required retained behaviour |
|---|---|---|
| CDSTRIP / CDSPOON — StripDrainCommand.cs:54-245; SpoonCommand.cs:23-139 | Freeform point collection supports Close/Undo/Cancel; strip drain has justification choice and style prerequisite. Spoon requires enough points for closed path. | Preserve each geometry workflow, per-point Undo and cancellation without an entity. Treat style/prerequisite failure visibly; do not collapse strip/spoon into generic surface drawing. |
| CDRG / CDTG — SourceBlockInsertCommands.cs:126-563 | Raingarden boundary jig supports Close/Undo/Cancel and optional GIO. Trench grate uses insertion/jig plus style/class/cover prompts. | Preserve separate command vocabulary and actual drawing preview. Reported treatment assessment remains distinct from engineering-model capability. |
| CDTAG / CDSOURCE — SourceTagCommand.cs:14-156; SourceBlockGenericCommand.cs:25-122 | Select/tag or insert source block, tag action/remove/show-label options and source-ID prompt are present. Source messages mention linked pipes and automatic inline split. | Preserve manual tag/source identity and visible action choice. **Conflict to resolve by owner:** approved direction prohibits inferred hydraulic links from crossings/proximity. Do not carry any automatic link/split claim forward until its trigger, source evidence, preview and user confirmation are specifically reviewed. |
| CDTPZ / CDSRZ — TpzCommand.cs:42-126; SrzCommand.cs:30-91 | Each asks centre then radius; Cancel is explicit before transaction/placement. | Preserve simple direct marks, cancellation and drawing Undo. They do not change catchment/network data unless a separately approved workflow says so. |

## 5. Proposal, hub and repair actions

| Existing route | Source-observed action boundary | Required retained behaviour |
|---|---|---|
| ProposalPreviewDialog — UI/Dialogs/ProposalPreviewDialog.xaml.cs:12-103 | Dialog only returns Apply/Cancel decision; actual apply is outside the dialog. It checks drawing/network identity when design impact is requested and tells user to rebuild proposal if it changed. | Preserve preview-before-apply and stale-identity refusal. Acceptance must prove Cancel leaves drawing unchanged and changed drawing state blocks/requires rebuild rather than silently applying old proposal. |
| PropagationPreviewDialog — UI/Dialogs/PropagationPreviewDialog.xaml.cs:11-40 | Shows an invert-cascade diff and returns Apply/Cancel. | Preserve old/new per-item comparison, selected scope, Cancel and one applied action Undo. Active pipe-edit owner remains responsible for implementation. |
| CivilHubDialog — UI/Dialogs/CivilHubDialog.xaml.cs:57-461 | Separates read-only health, design impact and network redesign; has refresh/show-on-plan/edit/schedule/profile navigation, saved bounds and close. | Preserve clear read-only versus action doors and the visible navigation route. Root owns shared help/project-QA/repair host; do not make this a duplicate master window. |
| CDREPAIR / CDLINK — UI/Dialogs/CdRepairDialog.xaml.cs:15-45; CdLinkDialog.xaml.cs:14-41 | Buttons route named commands then close; repair includes a workspace-menu refresh action. | Retain entrypoints and names while owner reviews ordinary repair host. Migration remains the specific approved existing-job-open and pipe-open/edit path with reader/enabler gate, first backup, one Undo and count/backup line. |
| Design Check Dashboard — UI/Dialogs/DesignCheckDashboardDialog.xaml.cs:22-40 | Close and item double-click route exist; XAML offers navigation/propose-fix/export. | Preserve reading, navigation and proposal distinction. Propose fix must open a preview with old/new/reason and never auto-apply. |

## Required future action batch

1. Cancel CDSURVEY at Xref selection and at optional raw-DWG selection; reopen source review and prove the right incomplete/source state.
2. Start import with prior import present; Abort and prove prior drawing content untouched; run a separate confirmed previewed replacement with one Undo.
3. Edit a slab's manual/source FSL, Cancel, reopen, then regenerate only after preview; Undo and prove provenance remains.
4. Make one schedule row override, restore it, close/reopen, then place/update only after confirmation and test drawing Undo separately.
5. Draw strip/spoon/raingarden with point Undo; cancel a trench grate and prove no entity; tag a source block without any proximity-created network link.
6. Open a proposal, change drawing identity before applying, and confirm it refuses/requires rebuild; test apply/cancel only on allowed selected scope.
7. Place/cancel TPZ and SRZ separately; prove no hydraulic/catchment mutation.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.

