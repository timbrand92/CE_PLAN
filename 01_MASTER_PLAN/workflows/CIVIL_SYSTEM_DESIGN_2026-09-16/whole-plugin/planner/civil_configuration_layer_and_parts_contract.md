# Civil configuration action contract — Layer Manager and Parts Catalogue

> **Governing companions:** [whole-job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md) · [shared settings action contract](../11_SHARED_SETTINGS_ACTION_CONTRACT.md) · [approved assets and settings requirements](../14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md) · [Civil decisions](../13_CIVIL_APPROVED_DECISION_RECONCILIATION.md) · [Civil route/control ledger](civil_route_control_preservation_ledger.md) · [Civil action-boundary contract](civil_action_boundary_contract.md). This is source-backed planning only. It proves neither a live setting, an AutoCAD result nor Tim acceptance.

## Scope

This pass traces two high-impact non-CD/PIT configuration surfaces with materially different Save/Reset boundaries:

1. **CDMANAGER Layer Manager** — draw order and colour overrides.
2. **CDPARTS Parts Catalogue** — pit and pipe entries.

OSNAP settings are already covered by the root shared-settings contract. Label Style Editor source contract is now completed in [label-style source map](civil_label_style_and_remaining_source_map.md): CDLABELSTYLE opens it, invalidates its cache after close, and announces the active style. [LabelStyleCommands.cs:20](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/LabelStyleCommands.cs:20>) [LabelStyleCommands.cs:31](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/LabelStyleCommands.cs:31>) [LabelStyleCommands.cs:34](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/LabelStyleCommands.cs:34>)

## A. Layer Manager — drawn result, draft configuration and saved configuration

### Controls retained from the observed window

| Window control group | Existing fields/actions | Classification |
|---|---|---|
| Draw Order | Apply-after-normal-CD and Apply-after-Save/Regen checkboxes; a rule row has Layer, After Commands and After Save/Regen; Add Layer, Remove Selected, Reset Defaults, Apply Now (Model), Apply Now (All Layouts), Save Draw Order Settings. [LayerManagerDialog.xaml:56](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:56>) [LayerManagerDialog.xaml:69](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:69>) [LayerManagerDialog.xaml:101](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:101>) | Preserve field/action vocabulary pending UI review. A listed rule is not a claim that the layer exists or is safe to modify. |
| Layer Colours | Read-only category/layer/description/default ACI; editable Override ACI described in the observed UI as 1–255 or blank default; Reset All to Defaults and Save Colour Overrides. [LayerManagerDialog.xaml:141](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:141>) [LayerManagerDialog.xaml:145](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:145>) [LayerManagerDialog.xaml:162](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:162>) | Source input validation is observed; it does not approve any particular colour/asset appearance. |
| Label/Dim door | Open Label Style Editor and Run DIMSTYLE. [LayerManagerDialog.xaml:171](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:171>) | Preserve discovery door only. Source fields/actions/file/active/Apply All are in the [label-style source map](civil_label_style_and_remaining_source_map.md); native drawing behavior remains unproved. |
| Close | Close button only. [LayerManagerDialog.xaml:222](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/LayerManagerDialog.xaml:222>) | No observed generic Apply/Discard close prompt. Closing cannot roll back an already-applied drawing operation or an already-saved preference. |

### Current source action boundaries

| Action | Current source effect | Save/Cancel/Undo limit |
|---|---|---|
| Open/load | Constructor takes a clone/snapshot of layer-order settings and saved colour overrides. [LayerManagerViewModel.cs:97](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:97>) [LayerManagerViewModel.cs:118](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:118>) | Source proves an in-window copy, not a live reload or current drawing result. |
| Add/remove/reset draw-order rules | Add rejects blank/duplicate names and begins new rows with Ignore action; remove mutates only the view-model list; Reset Defaults repopulates from default settings. [LayerManagerViewModel.cs:163](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:163>) [LayerManagerViewModel.cs:186](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:186>) [LayerManagerViewModel.cs:197](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:197>) | These actions are draft mutations until Save. Close discards unsaved rule edits as far as this view-model shows, but runtime close/keyboard behavior is untested. |
| Apply Now | Builds the draft setting and invokes drawing draw-order rules in Model or All Layouts. [LayerManagerViewModel.cs:203](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:203>) [LayerService.cs:693](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/LayerService.cs:693>) | This is a source-observed drawing action independent of Save. It does not prove an AutoCAD preview, a visible difference, native Undo grouping, Xref/locked-layer protection, or save/reopen durability. |
| Save draw-order configuration | Normalizes and writes layer-order settings through SettingsService. [LayerManagerViewModel.cs:211](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:211>) [LayerService.cs:639](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/LayerService.cs:639>) | This is configuration persistence, separate from applying rules to the open drawing. Existing drawings must not be silently reworked simply because a default/configuration changed. |
| Reset/save colour override | Reset Colour Defaults only clears editor cells and says Save is still required. Save validates each typed value, refuses the whole save if any nonblank invalid value exists, then replaces SettingsService colour overrides. [LayerManagerViewModel.cs:292](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:292>) [LayerManagerViewModel.cs:312](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:312>) [LayerManagerViewModel.cs:327](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/LayerManagerViewModel.cs:327>) | Reset then Close is a discarded editor change. Save is a user-settings mutation. Source does not prove persistence success, consumer refresh, or alteration of an already drawn entity. |

### Required planning contract

The shared asset/settings approvals govern this route:

- A changed default does not alter existing objects. Deliberate existing-drawing update requires reviewed Preview, Apply and Undo.
- Missing layers/styles lead to repair preview rather than an overwrite of working standards.
- A catalogue baseline is a candidate, not blanket visual authority; only individually approved assets govern appearance.
- Configuration is separate from engineering authority. No configuration action establishes a hydraulic connection, catchment, grade, calculated result or issue readiness.

| Future representative acceptance | Required evidence |
|---|---|
| Draft a rule, Reset Defaults, then Close | Reopen shows saved configuration unchanged; no drawing has changed. |
| Apply Model only then Undo | Visible scoped result, one native Undo and save/reopen are checked independently; locked/Xref/REFEDIT/unsupported content is not bypassed. |
| Apply All Layouts then Cancel/Close | Receipt identifies that Apply already acted; Close does not falsely promise rollback. |
| Invalid colour among valid colours | No colour overrides save; clear status identifies invalid entry; prior saved overrides remain available on reopen. |
| Reset colours then Cancel versus Save | Cancel retains previous settings; Save produces an explicit user-settings receipt, with no automatic conversion of existing objects. |

## B. Parts Catalogue — per-user file with immediate in-memory Reset

### Controls retained from the observed window

| Tab | Existing editable fields | Existing actions |
|---|---|---|
| Pit Sizes | X Width (mm), Y Width (mm), Pit Type, Lid Class, Plastic, Custom Label (optional). [PartsCatalogueDialog.xaml:68](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:68>) [PartsCatalogueDialog.xaml:84](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:84>) | Add Row, Duplicate, Delete Row. [PartsCatalogueDialog.xaml:91](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:91>) |
| Pipe Diameters | Diameter (mm), Material, Custom Label (optional). [PartsCatalogueDialog.xaml:121](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:121>) | Add Row, Duplicate, Delete Row; footer Reset to Defaults, Cancel, Save. [PartsCatalogueDialog.xaml:128](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:128>) [PartsCatalogueDialog.xaml:146](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml:146>) |

The displayed mm labels describe source UI field units. They do not adopt a dimension, material, pit type, lid class, shape, label or value as an approved engineering default.

### Current source action boundaries

| Action | Current source effect | Save/Cancel/Undo limit |
|---|---|---|
| Open/load | CDPARTS calls EnsureLoaded. The service uses a cached catalogue and locates parts_catalogue.json beside CD_Settings.json; a missing or unreadable file seeds in-memory defaults, and the missing-file path writes them. [PartsCatalogueCommands.cs:25](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/PartsCatalogueCommands.cs:25>) [PartsCatalogueCommands.cs:40](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Commands/PartsCatalogueCommands.cs:40>) [PartsCatalogueService.cs:30](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/PartsCatalogueService.cs:30>) [PartsCatalogueService.cs:35](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/PartsCatalogueService.cs:35>) | This is per-user configuration source behavior, not project/drawing authority. A load fallback is not silent engineering approval or proof that a usable file persisted. |
| Add/delete/duplicate in the window | View model copies service entries into local collections. Add/delete/duplicate first mutate only those local collections; duplicate clears display name so auto-name may regenerate. [PartsCatalogueViewModel.cs:68](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:68>) [PartsCatalogueViewModel.cs:93](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:93>) [PartsCatalogueViewModel.cs:100](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:100>) [PartsCatalogueViewModel.cs:107](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:107>) | Cancel closes with false and does not call Replace. [PartsCatalogueViewModel.cs:158](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:158>) [PartsCatalogueViewModel.cs:164](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:164>) There is no source evidence for validation, an existing drawing update, native Undo or save/reopen. |
| Save | Replace swaps both full collections, writes the service file and raises CatalogueChanged, then closes true. [PartsCatalogueViewModel.cs:158](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:158>) [PartsCatalogueService.cs:75](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/PartsCatalogueService.cs:75>) | Save is configuration-file intent; SaveInternal catches write exceptions and returns no success result to the caller. [PartsCatalogueService.cs:95](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/PartsCatalogueService.cs:95>) Caller closure is not a proven persistence receipt. |
| Reset to Defaults | The window invokes ResetToDefaults, which builds defaults, invokes SaveInternal to attempt a file write, raises CatalogueChanged, then reloads local collections. [PartsCatalogueViewModel.cs:145](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/ViewModels/PartsCatalogueViewModel.cs:145>) [PartsCatalogueService.cs:85](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Drainage/Services/PartsCatalogueService.cs:85>) | **Important current-source distinction:** Reset has already replaced the in-memory catalogue and attempted a file write before a later Cancel. Cancel has no source rollback for the previous catalogue; whether the file changed depends on the swallowed SaveInternal result. No confirmation, backup, repair preview, file success receipt or Undo is shown by this source. |

### Required planning contract

- The parts catalogue is one candidate input to the approved asset catalogue, not a second authority and not a project-wide engineering selection.
- Any asset/default change must leave existing drawing objects unchanged until the user takes a reviewed Preview/Apply/Undo action.
- Reset needs a visible scope and recoverable outcome. Present source’s immediate in-memory reset and attempted persistence are observed actions, not approved target behavior.
- New or changed dimensions/materials remain Candidate/Unknown unless an approved catalogue/source/engineering review establishes them. No source default is promoted by this plan.

| Future representative acceptance | Required evidence |
|---|---|
| Add/delete/duplicate then Cancel | Reopen has the prior catalogue; no existing pit/pipe in any drawing changed. |
| Save a deliberate custom row | Explicit result separates Saved, failed/unknown persistence and in-memory refresh; save/reopen checks the file actually used. |
| Reset then Cancel | User sees that reset has already changed in-memory configuration and attempted persistence, or target design defers it to a confirmed/recoverable operation. It never suggests Cancel undid it or proves the file changed. |
| Unreadable/missing file | Warning identifies scope and preserved/recoverable original where possible; values remain Candidate/Unknown rather than silently becoming approved defaults. |
| Use a catalogue entry in a future PIT/CD flow | Entry selection is visible and source-qualified; it does not silently re-size existing assets, create connections or establish calculated suitability. |

## Handoff gaps

| Route | Classification | Next useful trace |
|---|---|---|
| Label Style Editor source trace | Completed source trace | [Label-style source map](civil_label_style_and_remaining_source_map.md) records fields, file, active-selection distinction and Apply All boundary; remaining target/native work is separately classified. |
| Layer Apply native effect and protection behavior | Native-only | Representative AutoCAD review for model/layout scope, undo, Xref/locked/REFEDIT and saved-drawing effect. |
| Parts file write success/failure receipt and recovery | Source-answerable plus native save/reopen | Persist API currently swallows exceptions; a reviewed result/recovery contract is needed before a success claim. |
| Asset/council/engineering suitability | Tim/owner approval | Use the canonical asset catalogue and engineering rules; no values are decided here. |

**Built:** not assessed. **Tested:** no runtime/AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.
