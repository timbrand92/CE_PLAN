# Structural direct export — actual route scope and omission receipt card

**Planning-only.** This narrows W11-B’s direct Structural export contract. It preserves the four named current routes without inventing a converter, a common selected-object export, an issue/publish path or a compulsory export window.

> **Read with:** [W11-B export contract](structural_w7_w11_interaction_cards.md), [root direct-export findings](../22_CHECKLIST_AND_DRAWING_SAVE_BOUNDARIES.md), [source command/window ledger](structural_source_command_window_ledger.md), [member schedule card](structural_member_schedule_creation_revision_daily_card.md) and [whole-job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Exact route effects below are root’s named source observations in root22:57–61; no export was run. A declaration, source read or planning receipt is not a runtime, file-persistence or AutoCAD proof.

## Retained routes — source fact before proposal

| Direct route | Observed source effect | Proposed review boundary and explicit exclusion |
|---|---|---|
| `STRUCEXPORTCSV` | Despite the alias, the current route offers an **XLSX** destination, rescans the then-active drawing, and writes **Bracing** and **Bored Pier** sheets. Workbook `SaveAs` is the write boundary. | Bind the reviewed drawing identity before dispatch; show destination, XLSX name and the two actual sheet scopes. Do not promise a CSV, every member schedule, row-subset selection, schedule write-back, engineering QA, calculation or issue output. A zero-length warning fill is not engineering QA. |
| `STRUCEXPORTBLOCKS` | Copies **all DWG files recursively** from the deployed Blocks library into one chosen folder, by basename with overwrite enabled. Missing source may return silently; an exception after earlier copies can leave partial output. | Show deployed library source/version, source-file count, destination and every basename collision before a proposed export. Preserve distinct assets with equal basenames as a collision needing review. This is **not** a selected drawing-block export, Xref/REFEDIT conversion, asset substitution or drawing-object operation. |
| `STRUCEXPORTPDF` | Uses the **current layout**, copies plot settings, selects a PDF device, and applies Layout/ScaleToFit/centred settings. Optional paper/style overrides catch failures and retain fallback. | Bind and recheck the current layout immediately before dispatch; show actual paper, scale/style, output name and fallback state where present. It is a one-layout output, not shared issue membership, a revision change, publication, or proof of engineering adequacy. |
| `CEEXPORTNOTES` | Reads drawing `NoteStorage`, writes drawing-wide Markdown or HTML text and metadata, then separately attempts Explorer. Inspected writers omit image attachments. | Show source drawing/note-store identity, Markdown/HTML choice and image-attachment omission. A reviewed note-subset control is **Proposed only**; it must never be described as current behavior. No note merge, project-record rewrite, external-provider action or issue action follows. Explorer failure is separate from export success. |

## Ordinary direct-route review

These aliases remain direct command/prompt routes. Any preview or receipt may use command-line/transient status or an owner-approved existing surface; this card does not require a new setup window.

| Route | Drafter’s bounded action | Proposed visible receipt and recovery boundary |
|---|---|---|
| `STRUCEXPORTCSV` | Start the existing route and choose the offered XLSX destination. The proposed owner contract binds/revalidates the reviewed drawing at the actual export read; it does not ask the drafter to babysit an active document after dispatch. | Name reviewed drawing, destination, **Bracing** and **Bored Pier** sheets, written/unwritten/partial/unknown state and any active-drawing-change warning. Destination-dialog Cancel before dispatch is source-observed; after dispatch cancellation is not proof the file write stopped. Inspect the actual workbook before retry. |
| `STRUCEXPORTBLOCKS` | Start the library-copy route and choose one destination folder. | Name deployed library source/version, recursive source list/count, destination, collisions, copied/partial/unwritten state and missing-source condition. Current basename overwrite is source evidence, not approval of quiet overwrite; proposed review must preserve collision evidence and inspect target files before retry. External files have no drawing Undo. |
| `STRUCEXPORTPDF` | Make the intended local layout current, start the route, and review displayed paper/scale/style/output identity before dispatch. | Name current layout, actual plot settings/fallback state, output target and written/readable versus partial/unknown result. A matching-looking layout is never silently substituted. Open the produced PDF in future acceptance; it does not issue or revise a sheet. |
| `CEEXPORTNOTES` | Start the route for the current drawing’s `NoteStorage` and select Markdown or HTML where that current route offers it. | Name drawing-note scope, text/metadata output, omitted image attachments, target and written/readable versus partial/unknown result. A Proposed subset selection, if later approved, must show Included/Omitted note identities and cannot silently claim current source support. |

## Common external-file boundaries

| Event | Required planning distinction |
|---|---|
| Cancel/Escape before the source write boundary | Preserve the route’s current scope and no proposed artifact receipt. For `STRUCEXPORTCSV`, source observes destination-dialog Cancel before dispatch; every later cancellation/file-write outcome requires runtime qualification. |
| Collision, partial output or failure | Preserve reviewed route identity, target, source/layout/library/drawing context, completed/failed/unknown evidence and observed target files. Retry only after inspecting every target and collision; do not infer “no output” from a failure label. |
| Source/layout/drawing change while pending | Return only the affected route to Needs review. For XLSX, a then-active drawing switch is a qualified-risk boundary, not proof of a reproduced wrong-job export. For PDF, recheck current layout; for notes, retain current drawing NoteStorage scope; for library copy, retain deployed source/version scope. |
| Save/reopen and Undo | These are external artifacts. Closing the UI, drawing Undo, or saving/reopening a DWG cannot be advertised as deleting/reversing an export. Future acceptance separately opens the artifact and checks content, scope, destination and omission receipt. |

## Fictitious examples and future acceptance

On a synthetic drawing, the drafter chooses an XLSX destination; the Proposed owner binding/revalidation holds the reviewed drawing identity at the actual export read, and the receipt names only **Bracing** and **Bored Pier** sheets. They inspect the workbook before retrying an uncertain result. In a separate action, they choose a destination for the deployed Blocks library; two different source folders contain the same basename, so the collision is shown and the export is Parked. No drawing block is selected or copied. A note export records drawing-wide NoteStorage and its omitted image attachment; a later subset control remains a Proposed review item.

Future AutoCAD evidence should inspect: XLSX sheet coverage, drawing switch/cancel-after-dispatch behavior, library source/version and duplicate-basename collision/partial-copy handling, current-layout PDF settings and readable output, Markdown/HTML note scope and image omission, external-file retry, and absence of issue/revision/calculation/source-adoption side effects. Open real output files before calling any route Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, provider/corpus access or client-project scan occurred.


