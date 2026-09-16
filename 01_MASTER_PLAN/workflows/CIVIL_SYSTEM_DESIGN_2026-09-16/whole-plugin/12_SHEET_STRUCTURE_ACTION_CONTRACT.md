# Sheet structure, file actions and cancellation

FOR TIM

Removing a sheet from an issue, excluding it from the managed register and archiving its drawing are three different actions. The plan keeps them separate and makes clear when an action has already changed a drawing or file.

## Evidence and status

Read16September2026 from shared owner `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN`: `Modules/Structural/UI/Pages/CeProjectSheetsWorkspaceView.xaml.cs` and `Modules/Structural/Services/CeSheetsStructureService.cs`. This is bounded source evidence, not current installed behaviour. It corrects the earlier generic Cancel/Undo statement in02; working routes remain with their owner. No action was executed.

## Distinct retained actions

| Action | Actual inspected handler behaviour | Planning requirement |
|---|---|---|
| Exclude selected / Manage selected | View2651–2673 changes IsManaged, exclusion clears IncludeInIssue, then reorders/filters draft rows | State whether excluded from management; no deletion/archive implied. Re-managing must not silently imply issue inclusion |
| Add to issue / Remove from issue | View2675–2699 changes membership; cannot include unmanaged rows | Preserve drawing and row; PDF membership is separate from revision/date and management |
| Duplicate / Insert Before / Insert After | View2206–2277 uses one duplication service with insertion position; persists manifest if created; reports copied title-block state and QSAVE need | Preview target DWG/layout and sheet position; distinguish actual file copy from active drawing layout clone. Cancel after completion does not remove accepted output |
| Archive selected | View2279–2354 confirms, calls service, reports moved/backed-up drawings/removed sheets and save requirement | Exact scope preview; distinguish whole-DWG move from active-layout removal; report actual archive path and each outcome |
| Renumber sheets | View2356–2372 resequences managed draft rows in current order | Explicit request only, preserve legitimate gaps unless this operation is accepted; register numbering is not yet proof of title-block updates |
| Reconcile files | View2374–2421 updates drawing assignments and saves if reassigned | Not merely a read-only scan. Show old/new assignments and exact identity evidence; no nearest-name substitution |
| Preview renames | View1709–1741 builds plan and shows old/new names or reasons | Preview only; do not imply frozen approval carries to a changed later plan |
| Apply renames | View1743–1831 rebuilds plan, confirms actionable count, applies, reconciles assignments and reports queued/pending/archived counts | Confirm the exact current paths, collisions and cleanup scope; distinguish completed from pending renames and preserve recovery evidence |

`PersistCurrentManifest` at810–820 calls the active workspace session Save, or the manifest save service when no session. Thus these handlers can save more than the single clicked field because they first merge form values into the current complete draft. The future review must disclose/resolve that draft scope; do not promise these actions leave all other unsaved form values pending without qualification.

## Archive: wording and service differ

The confirmation says only whole drawings are archived and partial-layout removal will be skipped. Deeper service inspection contradicts that blanket wording:

- Whole-DWG selection: StructureService175–243 moves the actual file to a unique Superseded path and removes its register rows; file failure produces a warning.
- Partial selection:209–213 calls RemoveLayoutsFromActiveDrawing. At246–325 this allows only the matching active drawing with a saved source file and no unsaved changes; it requires a remaining layout, copies a backup, then deletes selected layouts in memory and removes their manifest rows. It reports RequiresDocumentSave.
- The view persists only when ArchivedDrawingCount is positive. A partial-only operation reports backup/removal but does not enter that particular persistence branch. Save/Discard/reopen behaviour therefore requires owner qualification; it must not be declared atomic or fully durable from the completion message.

**Planning gap:** review wording must identify the actual proposed operation. The data/file/drawing effects and save requirements need one consistent receipt. Do not remove a supported partial-layout route merely because the current warning is inaccurate; do not call its recovery proven either.

## Rename and cleanup are not one harmless action

When there are no direct actionable renames, Apply Renames may ask to clean up unused drawings into Superseded. With actionable renames it confirms their count, then also reports any archived unused drawings and queued pending renames. Preserve useful recovery but show the full exact operation scope before accepting it. A prior Preview Renames listing is not a frozen plan identity in the inspected handler, because Apply builds a fresh plan.

## Proposed recovery and acceptance contract

1. Before file/drawing actions, identify the project, current draft changes, exact selected rows, file/layout operation and affected paths. No invented all-project action from one selected row.
2. After acceptance, record each completed, skipped, failed and pending result separately, including created files, archive/backup paths, active unsaved layouts and persisted register changes.
3. Closing or Discard only discards remaining draft. It must not promise reversal of an accepted file operation. Provide the owner's established explicit recovery route where available; otherwise report recovery unqualified, not “one Undo”.
4. Refresh/reopen compares actual file/layout/register state. A failed manifest save after a successful copy must not invite blind Duplicate again and create another copy.
5. Multi-file or file-plus-active-drawing operations need exact partial-failure recovery. AutoCAD Undo alone is not evidence of filesystem rollback.

These are proposed refinements of approved shared-project behaviour, requiring owner review before implementation. Existing routes and approved save boundaries remain in force.

## Synthetic end-user scenarios for qualification

### Ordinary use: add one drawing sheet during design

This proposed sequence joins the retained actions above. It does not introduce a second sheet manager or claim their implementation already has this review.

1. Select the actual source sheet by DWG and layout, then **Duplicate / Insert Before / Insert After**. The preview identifies whether the owner will create a new DWG or clone a layout in the active drawing; a sheet title alone is not enough.
2. Review the destination, intended register position and resulting sheet identity. Reuse of the source's copied title-block values is shown as a difference to resolve, not assumed valid new-sheet information. Preserve unrelated draft edits or disclose the complete draft that the retained action will save.
3. Confirm the qualified copy operation. Show the created DWG/layout separately from register persistence and any unsaved active drawing. If the copy exists but the register save fails, recover that existing copy rather than duplicating again.
4. Review the new sheet's title/number and exact title-block mapping under30. Changing register order is distinct from deliberate **Renumber sheets**, and neither proves the title block updated. Preserve existing legitimate gaps unless the reviewed renumber operation changes them.
5. Choose whether the new sheet is managed and whether it belongs in the next issue. Those are separate choices. An automatically suggested issue membership or revision is still reviewed under the issue owner's contract; creating a sheet does not issue it.
6. Before output, reconcile the actual saved/current source basis under29. Existing issued sheets retain their recorded revision/date unless deliberately revised; merely including them beside the new sheet does not revise them.

**Example:** insert a detail sheet after the drainage plan. The user can inspect the new sheet without automatically renumbering the whole set, changing earlier issue dates or archiving the source plan. If the later title-block review is cancelled, the accepted sheet copy still exists and its unresolved mapping remains visible.

This is a future representative end-to-end qualification: inspect actual new layout/file, register row, title block, issue membership and retained earlier history. A successful copy message alone does not establish those results. The exact numbering proposal and initial membership behavior remain owner-reviewed; no default has been silently chosen here.

| Sequence | Expected review evidence |
|---|---|
| Remove S02 from issue → Discard draft → reopen | Drawing untouched; membership returns according to actual saved state; no archive created |
| Exclude S02 → Save → Manage again | Register retained; issue inclusion is explicit; title-block state not silently declared updated |
| Duplicate → manifest save fails → retry | Actual created output identified first; no second unintended DWG/layout |
| Select one layout of active saved multi-layout DWG → Archive | Accurate layout-removal warning, actual backup, remaining layout and unsaved-state receipt |
| Same partial selection in inactive or dirty drawing | Clear skipped reason, no claimed complete archive |
| Archive mixed available/locked files → close | Per-file results and actual recovery paths; close does not pretend to undo completed moves |
| Preview renames → change sheet title → Apply | Review reflects changed exact paths; old preview not reused as approval |
| Reconcile → Discard/close → reopen | Saved path assignments distinguished from discarded subsequent edits |

No plugin build/test or AutoCAD verification was performed. Independent coverage audit is ongoing.
# Drawing Properties: one drawing versus shared project scope

Additional read-only source qualification from owner44b2 `Modules/Structural/UI/Dialogs/CePropsDialog.xaml.cs:20–81` and `Services/CeDrawingPropertiesService.cs:38–88,110–159,172–219`. This is not a live UI or installed-state check.

| Action / field | Observed effect | Required end-user distinction |
|---|---|---|
| Open properties | Loads drawing summary first, fills blanks from manifest, then parser fallback; update-manifest defaults on when a root is recognised, sync defaults off | Show each value's scope/source when values disagree. A nonblank drawing value is not proof it is the current shared project authority. |
| Save dialog | Copies trimmed fields and checkbox choices into model; Cancel returns false | Dialog acceptance is not yet durable saving. No drawing write occurs in that dialog Save handler itself. |
| Save drawing properties | Service updates drawing custom/legacy summary fields and notifies content changed before attempting manifest changes | Drawing changed in memory is separate from disk saved and manifest updated. Failure later does not prove this earlier step was undone. |
| Update project manifest | Replaces job metadata/defaults in manifest and assigns entered revision/date to every sheet row matching this DWG path | Project-level job edits and all-layouts-in-this-DWG revision edits are broader than a selected-sheet change. Preview exact affected scope; do not treat this as final issue history. |
| Sync project now | Available only with manifest update; service invokes shared SyncManifest after saving manifest | Changes to other managed drawings are a separate action under the existing shared owner's review/recovery contract. |
| Missing manifest | Service may load or scan before applying model | Opening and Save paths have different effects; no heavy scan-on-open inference. Qualify unexpected save-time scan/failure separately. |

The inspected path collapses the drawing's revision/date fields to one pair even when several layouts have different issued states. Approved included-versus-revised sheet rules still govern; an ordinary Properties edit cannot silently be treated as a verified new issue. Existing shared project draft, drawing update and issue owners must reconcile this retained route rather than create competing authority.

Future synthetic acceptance: a two-layout DWG with different revisions; drawing metadata disagreeing with shared metadata; Save with manifest update off/on; sync off/on; manifest failure after drawing-memory update; Cancel before acceptance; save/reopen. Compare exact field scopes, prior/current values, affected drawings and truthful partial-state messages. No job metadata, manifest or drawing was edited during this planning.
