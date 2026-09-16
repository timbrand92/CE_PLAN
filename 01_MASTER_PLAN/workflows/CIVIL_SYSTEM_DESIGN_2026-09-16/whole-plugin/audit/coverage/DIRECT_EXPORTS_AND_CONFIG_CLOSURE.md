# Direct exports and configuration correction read-back

FOR TIM

The direct export descriptions match their source. They correctly separate exported files from issued drawings. The Parts Reset and Label Apply All success wording is corrected.

---

Clock: 2026-09-16 13:49:29 UTC / 23:49:29 Sydney. No export, viewer, settings save, runtime, build, git, client scan or AutoCAD operation.

## Actual source checked

- UtilityCommands95–222 and ExportService15–254: STRUCEXPORTCSV chooses XLSX, emits Bracing/Bored Pier only; lambda ignores supplied cancellation token/document while service retrieves then-active document. Runner AsyncCommandService33–93 locks originally captured document and invokes callback from Task.Run. Root22 correctly retains identity/cancellation qualification without inventing a reproduced wrong-job export.
- Block export recurses source DWGs, flattens basename, overwrite=true, missing folder returns. Partial/collision receipt is a required target, not current batch atomicity.
- PDF helper sets Layout, ScaleToFit and centred after copying settings; optional overrides swallow failure. Actual page/file verification is absent from this body. Direct route is not a verified issue or proof of parity with combined publication.
- NotesExportService12–91 plus command wrapper reads drawing NoteStorage, writes text/metadata only, then Explorer has separate catch. Correctly not a full shared-note/attachment archive.
- InspectCommands17–94 reads selected entities and writes timestamped JSON in drawing folder or Desktop fallback. It includes drawing identity, but no external upload occurs in that method. No client output was opened.

No new material source-claim correction in root22 direct-export section. Future output receipt correctly requires identity, scope, destination, completeness and fallback; direct file writes are not reversed by drawing Undo.

## Explicit finding status changes

| Finding | Status and read-back |
|---|---|
| CFG-01 | Closed planning wording: Parts Reset now distinguishes immediate memory replacement, attempted write and swallowed persistence result; Cancel has no rollback. |
| CFG-02 | Closed planning wording: Label Apply All documents precommit count and caught error, adds failure-before-commit scenario without assuming runtime rollback. |
| CFG-03 | Closed status wording: remaining map acknowledges root13 sampled consumer trace and retains only unsampled governing activation/revision questions. |
| SURF-02 | Closed by direct §B read: source dispatch/search/pin/recent traced through root24, native reachability/focus/result distinct. |

These closures do not mean source bugs fixed, native tests passed or Tim acceptance. Remaining finite planning work is TPZ/SRZ persistence/edit/source revision, source-tag exact selection/split scope, unsampled governing-use/revision transitions and final action-contract coverage/status/morning-pack reconciliation. Later owner deltas may close these; this report does not assume that. Whole-plugin completion stays open.
