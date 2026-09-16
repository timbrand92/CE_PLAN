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

## Time-report export — file creation and opening are separate results

Direct root read `Modules/Structural/UI/Dialogs/ReportsDialog.xaml.cs:126–190,367–443` shows report generation by date range/type/user and CSV/HTML export from the retained report object. Type/user changes clear that object and disable export. The inspected Generate action uses a30-day/current-date fallback when a date is missing; this is source behaviour, not a newly approved reporting period.

Export handlers write through `Core/Reports/ReportManager.cs:628–646`, which creates the data-folder Reports directory and a name with second-resolution timestamp, writes through CloudFileHelper and returns its path. There is no SaveFileDialog or separate cancellation stage in these handlers. CSV then opens Explorer selection; HTML opens the saved file in a browser. Save and launch are inside one try/catch, so a launch failure after writing can be reported as an export error even though a file already exists. This is a source-level status ambiguity, not a tested failure.

Required target: show report type, dates, user scope and data snapshot used; separate **file saved** from **could not open viewer**; expose the actual destination; ensure retry does not quietly overwrite an earlier output or duplicate it without explanation. Same-second naming is not proof of unique artifact identity. Closing the report window does not undo already saved CSV/HTML and exporting does not alter time entries, drawing save status or issue history by itself.

Future synthetic acceptance: generate each report type, change filters then export, force a file-write failure, separately fail viewer launch after successful write, repeat export rapidly and inspect actual files and data scope. No time files were read and no report/viewer was generated or launched in this planning pass. The approved append-only adjustment and Unassigned-time contract remains in the [notes/time supplement](planner/structural_surface_action_coverage_and_notes_time.md).

**Date-filter freshness correction:** actual `ReportsDialog.xaml:82,85` date pickers have no date-change handler, and the inspected code references set/read dates without clearing the report when a user edits them. Type/user invalidation must not be generalized to dates. Generate periodA → change displayed dates to periodB → Export can still use the retained periodA report in this source path. Target must visibly retain the generated period or require regeneration before exporting a changed selection; no silent mismatch. This is source control-flow evidence, not an executed UI failure.

**File-helper recovery qualification:** direct `Services/CloudFileHelper.cs:139–200` writes a shared path+'.tmp', deletes an existing destination, then moves the temporary file; bounded retries eventually throw. The comment describing atomicity is not proof of an indivisible replacement, concurrent-writer protection or remote sync completion. Failure between delete and move, and two writers using the same temporary name, need recovery/concurrency qualification. Do not infer library/time/report save robustness from this helper's name. No helper operation was executed.
# Direct Structural exports — separate from issuing drawings

Additional bounded source read, 16 September overnight: root `Commands/UtilityCommands.cs:95–222`, `Commands/InspectCommands.cs:17–94`, `Services/ExportService.cs:15–254`, `Services/NotesExportService.cs:12–91`, `Services/AsyncCommandService.cs:33–93`. No export or command was run. Shared issue ownership and approved full-set/changed-sheet rules remain in the shared issue contract; these direct routes do not establish an issue receipt.

| End-user action | Inspected source effect | Required planning distinction |
|---|---|---|
| Export structural schedule | STRUCEXPORTCSV actually offers an XLSX file, rescans the active drawing and writes Bracing and Bored Pier sheets. Workbook SaveAs is the write boundary. | Preserve callable identity but label the actual file type and schedule coverage. Do not promise every structural member schedule. A zero-length warning fill is not engineering QA. |
| Cancel schedule export | Destination dialog Cancel returns before dispatch. After dispatch, the lambda does not use its cancellation token; ExportCsv independently obtains the then-active document rather than using the document supplied by the runner. | Pending cancellation is not proof the file write stopped. Bind the reviewed drawing and export receipt; a drawing switch needs qualification, not an invented claim of a reproduced wrong-job export. |
| Export block library | Copies all DWG files recursively from the deployed Blocks folder into one chosen folder using only each basename and overwrite=true; missing source returns silently. | It exports library files, not selected drawing objects. Show source/version, count and collisions before a proposed export; preserve distinct assets with equal basenames. An exception after earlier copies can leave partial output. No atomic batch or undo is evidenced here. |
| Export current layout PDF | Uses current layout, copies its plot settings, selects PDF device, applies Layout/ScaleToFit/centred settings and drives the plot engine. Optional paper/style overrides catch failures and retain fallback. | Single-layout output is not approved issue publication. Show actual paper, scale/style and output identity; source return alone does not verify page content. The separate combined publisher has a different settings pipeline—do not infer identical output from similar names. |
| Export drawing notes | Reads drawing NoteStorage, writes Markdown or HTML text and metadata, then separately attempts Explorer. Inspected writers do not copy image attachments. | Report drawing-note scope and omitted attachments; do not claim a complete shared-note archive. Explorer failure is separately caught here, so it does not reverse successful export. |
| Inspect selected entities | Serializes selected entity information to a timestamped JSON beside the drawing, or Desktop when no valid drawing folder; includes drawing path. Explorer launch is separately caught. | This is a local inspection export, not automatic support upload or an issued document. Show actual destination and selected count; second-resolution names do not prove collision protection. |

Proposed receipt across these routes: source drawing/library identity, selected scope, actual destination, completed/partial/failed/unknown result and any fallback. Closing the UI or drawing Undo cannot be advertised as undoing external files. Preserve existing working routes until reviewed replacement acceptance; these findings authorise planning only.

Future synthetic checks: switch drawing while schedule work is pending; request Cancel after dispatch; block destination write; duplicate block basenames in separate library folders; failure after one successful copy; inspect an unsaved drawing; export a note with an attachment; compare direct-layout PDF with reviewed issue output. Open actual files and inspect their contents during implementation qualification. None of these checks ran overnight.

### Markup diagnostic exports are not an ingestion approval

Root `MarkupAICommands.cs:303–451` and `MarkupAIDrawingStandardsExportService.cs:13–171` add two distinct routes. CEMARKUPDWGEXPORT takes an environment-specified destination or prompts for JSON (default fixed temporary filename), reads drawing standards/layers/styles/block metadata and writes the full resolved path. It is not a geometry backup, engineering compliance certificate or upload. Filename-derived project/discipline remains inferred context; preserve confirmed job identity separately. Repeated writes to the same path replace content through WriteAllText; no version receipt is demonstrated here.

CEMARKUPBENCH prompts for a folder, discipline and Bluebeam/Hand/Hybrid mode, recursively enumerates PDFs, parses/builds plans for each and writes one CSV after the loop. Its counts and confidence are parser/plan outcomes, not correct-design or actual drawing-execution evidence. The outer catch does not produce a per-file partial CSV receipt in the inspected body if processing fails midway. The parser's provider/transmission effects are not established by this caller read; it must not be described as an offline-only export. Existing evidence-program, approved provider and synthetic-corpus gates apply. Nothing was parsed, enumerated in a client folder, exported or sent in this planning run.

Required workflow distinction: local drawing snapshot export, authorised parser evaluation and design evidence adoption each have their own scope and result. Do not make a benchmark a hidden step when the user merely selects project documents. Future checks use authorised synthetic PDFs, explicit mode/provider scope and per-file outcome evidence, including failure after an earlier file and a destination collision.
