# Checklist library and drawing-save boundaries

FOR TIM

Saving a library, updating a checklist in an open drawing, and saving that DWG to disk are separate events. A completed first step must not be presented as proof of all three.

This continues the [Structural control supplement](planner/structural_control_semantics_supplement.md) and [job journey](19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Observations below are source-only, from `C:\Lisp Files\CE_ACAD_PLUGIN`; no library, drawing or plugin file was modified or executed.

## Checklist: the complete observed handoff

| Action | Source evidence | Actual boundary and planned user meaning |
|---|---|---|
| Save Changes in Template Editor | Earlier supplement traces local deep copy into selector and `TemplatesWereEdited` | Accepts library edits into the caller; distinct from selecting a template for the drawing. |
| Close template selector after editing | `Modules/Structural/UI/Palette/ChecklistPanel.xaml.cs:741–760` checks `TemplatesWereEdited` and calls `SaveAllTemplates` before testing the selector result | Library saving occurs even if selector result is not true. Selector Cancel cannot be described as discarding already accepted template edits. |
| Persist edited library | `Modules/Structural/Core/Checklist/TemplateManager.cs:1290–1320` clears cache, deletes existing `*.json`, then calls `SaveTemplate` for each supplied template | Current source is a sequence of file changes, not an all-or-nothing library replacement. Individual delete failures are logged; return values from individual saves are not aggregated here. Panel's subsequent success log is not a complete durability receipt. |
| Save an individual template | Same file `:130–165` uses ID plus sanitised name, serialises, writes through file helper, then updates cache; returns false on exception | File-helper return alone does not prove concurrent-edit reconciliation or recoverable whole-library replacement. These remain owner qualification gaps. |
| Select template and confirm | Panel `:754–780`; `Core/Checklist/ChecklistStorage.cs:303–310` creates an instance then saves it | Drawing application is separate from library saving. Confirming applies a newly created instance; no existing-checklist merge or completed-item preservation is established by this path. |
| Save drawing checklist | `ChecklistStorage.cs:107–180` locks document, replaces header/items within drawing dictionary and commits | Updates the open drawing's data. No disk-save operation appears in this method; save/reopen still needs native evidence. |
| Library unavailable/corrupt | `TemplateManager.cs:59–104` reads each JSON, logs failures and creates defaults if none loaded | Do not describe default creation as successful recovery of the former library. Original custom content and deliberate reset remain distinct. |

## Planning contract and unexecuted acceptance scenarios

- Keep **Save library changes** separate from **Apply template to this drawing**. Make completed file effects visible before selector Close/Cancel is interpreted.
- Replacement failure must report which library state is retained and which files failed; no unconditional “saved” receipt. Proposed implementation must preserve recoverable prior content and reconcile simultaneous edits. These are required design/recovery details, not a claim current source does them.
- Template revision must not silently overwrite completed job checks. The reviewed Coordination/checklist requirements govern any deliberate update; existing source instance creation is not approval of a reset.
- Synthetic acceptance: edit a template, accept editor, cancel selector, reopen library; distinguish library change from unchanged drawing checklist. Then apply deliberately and inspect actual drawing instance.
- Synthetic acceptance: fail one library write and verify truthful partial/failure status and recoverable prior library; two editors must not silently erase each other's changes.
- Synthetic acceptance: apply a changed template to a completed checklist; show the reviewed retain/replace scope before losing completion records. Native behaviour and exact future interaction remain unproved.

## Civil: embedded data is not a disk-save receipt

`Modules/Drainage/Services/ProjectDataService.Persistence.cs:294–327` calls `SaveToDrawing` then logs success. The inspected `SaveToDrawing` body at `:514–557` serialises into the drawing dictionary and commits its transaction. That method does not itself write the DWG file to disk.

`LinkService.cs:961–1017` attempts a close-time flush only for its current database and detaches callbacks; `LinkService.Reactors.cs:752–768` flushes after listed modifying commands. These are bounded source observations, not proof of native close ordering, disk durability or all command coverage. Internal comments about AutoCAD internals are not adopted as verified facts.

The target status must distinguish **pending window edits → applied to open drawing → saved DWG → verified issue output**. A project-data success log alone cannot mark a file Saved or a job Ready. Auto-save, QSAVE, save/reopen, close-without-save and recovery after interruption remain separate future native scenarios. Do not automatically save a drawing merely to make a status green; retain the approved save owner and user intent.
