# Structural floor-capture and mapping daily card

**Planning-only companion.** This covers the ordinary EXCELMAPFLOOR/EXCELCAPTURESELECTION and EXCELMAPFLOORAREA/EXCELCAPTUREAREA routes that feed schedule review. It is grounded in [ST-07](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md>) and current named source. It does not calculate, confirm a member floor, write a schedule or claim a runtime result.

## Source observation versus governing rule

| Route | Named current source observation | Governing planning treatment |
|---|---|---|
| Selection capture | Prompts for a floor, accepts explicit selected text, blocks or Xrefs, extracts marks including nested block text, assigns each extracted key to the selected floor in a session map, then saves the project session and settings. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ExcelMTextCommands.cs:28>), [selection](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:542>), [save](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:665>). | ST7-4/7–9 requires explicit source/revision/provenance and keeps learned answers as **Candidate**. An extracted mark is evidence, not a governing member identity/floor or an authority to overwrite a confirmed mapping. |
| Area capture | Prompts for a floor and two window corners, then gathers text, MText, multileaders and inserts within a crossing window before using the same mapping/save routine. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ExcelMTextCommands.cs:51>), [area selection](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:584>). | A window is only a selection convenience. It must show every candidate and never convert a nearby, copied, Xref-derived or same-looking mark into an adopted schedule fact. |

## Proposed first-use review sequence

| Step | Drafter action | Visible outcome and boundary |
|---|---|---|
| **1. Start capture** | From **Main: Import schedule evidence**, choose **Capture selected marks** or **Capture area**. The header names active drawing/layout/view/level context and labels the operation **Candidate mapping**. | The existing EXCELCAPTURE* aliases remain familiar entry points. The capture route cannot change project/document context or invent one. |
| **2. Choose scope and intended floor** | Select explicit local entities, or draw the area window. Choose the floor deliberately from the supported floor list; **Unknown / Cancel** leaves no pending assignment. | A selected mark in a different level/view, a nested block, copied entity or Xref-derived text is shown as a separate evidence row with source kind and identity. Same visible mark across levels never merges automatically. |
| **3. Review extraction before any saved mapping** | Large preview lists each candidate: displayed mark, explicit source entity, drawing/layout/view/level, local/Xref/nested/copy state, selected proposed floor, existing mapping if any, source/revision time and Candidate/Manual/Unknown status. | The preview groups **new candidate**, **same candidate**, **conflict with confirmed/Manual**, **unreadable**, and **no mark** separately. No nearest-object or partial-text match fills a row silently. Xref content stays evidence; the route never edits it. |
| **4. Decide each row** | Actions are **Keep as Candidate**, **Exclude**, **Mark Unknown**, **Open current mapping**, and **Cancel**. A known manual/confirmed mapping remains visible beside the candidate; a candidate cannot replace it. | **Save candidate review** persists only the reviewed candidate/provenance/receipt. **Adopt for schedule review** is a separate explicit handoff that identifies the selected row and downstream schedule draft; it remains a review decision, not a structural calculation. |
| **5. Reopen or revise** | On reopen, select a candidate mapping and show Before / Current / Pending, source identity/revision, its selection/window origin and any later drawing change/deletion. | A deleted/missing source becomes **Missing**. A changed source becomes **Needs review**. Unchanged manual mapping remains Manual; it is not reset by newer capture evidence. **Discard pending** changes only the open draft. |

## Current-source boundary and proposed cancellation

Current source assigns map entries and calls session/settings saves after extraction; it does not establish a preview-before-save, candidate status, a per-row conflict door or a rollback receipt. The proposed target above changes that ordering. It is not a claim that the current aliases are safe to run unchanged.

| Situation | Proposed truthful result |
|---|---|
| Cancel before reviewed Save | No candidate map, session record, settings change or schedule draft is created. |
| Some selected entities yield no usable mark | Retain the entity receipt as **No mark**; save only explicitly chosen candidate rows. Do not call the empty result a successful mapping. |
| Candidate conflicts with confirmed/Manual floor | Show both values/source/revision. Preserve the governing confirmed/Manual value; the candidate is Needs review until deliberate adoption. |
| Source deleted after candidate save | Mark candidate Missing while retaining its historical receipt. It does not erase or overwrite a separately confirmed mapping. |
| Partial persistence uncertainty | Receipt distinguishes candidate rows reviewed, candidate rows persisted and schedule adoption requested. Reopen/readback before retry; no duplicate candidate history or automatic schedule change. |

## Fictitious everyday example

On a synthetic two-level drawing, the drafter opens **Capture selected marks**, selects two local labels and one Xref-derived label, then chooses a floor. The preview shows the two local candidates, the Xref evidence row and a third same-looking mark already manually assigned on another level. The drafter keeps one local candidate, marks the Xref result Unknown and excludes the other. No schedule changes.

Later, the first label is copied and its original deleted. Reopening the candidate shows its original source as Missing and the new local object as a separate candidate; it does not transfer the saved floor assignment by proximity. The drafter keeps the existing Manual mapping and parks the new candidate for schedule review.

## Future representative acceptance (not performed)

1. Capture a selection containing local text, nested block text, an Xref-derived label and no-mark geometry; inspect separate candidate rows and zero drawing changes.
2. Use area capture across two levels with duplicate visible marks; confirm the preview holds separate identities and does not merge them.
3. Capture a candidate that conflicts with Manual/confirmed mapping, Cancel, reopen, then deliberately save a candidate; verify the adopted basis remains unchanged until separate review.
4. Delete/copy a source after candidate save; reopen and inspect Missing/new-candidate/Manual states, partial-persistence receipt and safe retry.

## Links and limits

- [W8 workflow](structural_workflow_cards.md), [member schedule daily card](structural_member_schedule_creation_revision_daily_card.md), [control-semantics supplement](structural_control_semantics_supplement.md) and [writer/recovery supplement](structural_mts_xcl_writer_recovery_supplement.md) own the next schedule-draft, insertion and receipt stages.
- XCLMTXTINDEX remains an unqualified ghost, not an expert capture/discovery path.
- No project/client source was opened. Current source file/session side effects and every proposed visual/native Cancel/Undo/save-reopen behavior need future AutoCAD evidence.
