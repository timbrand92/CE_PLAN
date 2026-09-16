# Structural W0–W1 context, notes and job-time interaction cards

> **Governing companions:** [notes/time source coverage](structural_surface_action_coverage_and_notes_time.md) · [Structural workflow cards](structural_workflow_cards.md) · [approved ST-09 reconciliation](structural_approved_card_reconciliation.md) · [shared job/issue owner contract](../02_SHARED_JOB_AND_ISSUE.md) · [job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md) · [drawing-save boundary](../22_CHECKLIST_AND_DRAWING_SAVE_BOUNDARIES.md). This is planning-only. It does not create a second project record, change shared-project ownership, prove multi-user persistence, or claim a live timer/window result.

## W0-A. Notes — write, attach and resolve inside the right job context

**Current-source boundary.** The Note Entry dialog returns a note draft; the browser turns it into a shared note, then adds attachments afterwards. Editing updates note fields before removing/adding attachments. Those are separate source operations, not an all-or-nothing attachment transaction. [Notes/time coverage](structural_surface_action_coverage_and_notes_time.md) records the exact source routes.

| User sequence | Proposed Main/More experience | Result and lifecycle boundary |
|---|---|---|
| **Main: open Notes** | Header shows current job/drawing/layout context, or **Unassigned context** where no confirmed job applies. Filter/list shows note state, category/priority, affected item and attachment status. It reads the shared project decision; it does not create/guess one. | Selecting a note opens its existing evidence and current revision. A note never becomes a structural instruction merely because it is visible. |
| **Main: New note / Edit note** | Enter category, priority, tags/content and optional drawing/element/calculation/schedule/markup relation. Before Save, a review pane identifies origin job/drawing/layout, affected item, proposed fields and requested attachment count. | Save Note creates/updates the note record only after explicit confirmation. Native drawing annotation, if requested, is a separately previewed action with its own result. |
| **Main: Resolve** | Show the exact note and current context; preview resolved status/reason rather than deleting it. | Resolve has a visible audit outcome and does not remove attachments or drawing annotation by implication. |
| **More: attachments** | Add/remove attachment requests list exact item and planned action. Attachment identity/result is shown separately from note fields; never display a client file path in a shared planning/export view. | Existing source may save the note then add attachments one at a time. Target receipt separates Note saved, Attachments complete, Attachments partial, and Attachment failure. |
| **More: relation/history** | Show explicit links, origin context, revision/conflict state and source/Manual/Unknown classification. | This is an inspection surface. It cannot silently move a note to another job, rewrite a source, or mark engineering as approved. |

### Concurrent edit and attachment partial-failure proposal

| Situation | Proposed visible choice/result |
|---|---|
| Another user changed the same note | Show Mine, Shared and common base with changed fields/attachments and origin context. The approved choices are **Keep mine / Keep shared / Merge / Cancel**. Merge is available only when the fields/attachments selected for merge are shown; no last-save-wins claim. |
| Note record saves but attachment add fails | Receipt says **Note saved — attachments partial**, names successful/failed requested attachments without copying their private location into the record, and offers Retry failed attachment(s), Keep note without them, or Cancel recovery. Retry does not create a second note or remove successful attachments. |
| Edit note fields succeeds, old attachment removal/new add then fails | Receipt distinguishes field record, removed attachments and added attachments. Re-open review before retry; do not assume a rollback or silently restore/delete an attachment. |
| Cancel before Save | Close draft/preview with no browser write or drawing annotation. |
| Cancel after a record write | Do not promise rollback. Show recorded note state and attachment outcome; return to review. Drawing Undo, note-record undo and attachment recovery remain distinct. |

### Fictitious two-job scenario

Job **North** has a pending note draft linked to one local beam; Job **South** is opened before Save. The switch banner says: “Pending note belongs to North / current drawing, not South.” **Recommended choices:** Stay and finish; Park draft with its North origin context; Discard draft; Cancel switch. Parking preserves the original job/drawing/layout and pending attachment requests as a draft only—it does not create a South note or a duplicate project record. Opening the parked draft from South offers **Return/resume North unchanged**, Park, Discard or Cancel. Explicit re-context review appears only if the user deliberately asks to move that draft; it is not required to return and finish it in North.

## W0-B. Job time — visible context, idle restoration and append-only correction

**Approved target.** Unknown drawings are **Unassigned/not billable**. After five inactive minutes, pause/exclude idle and offer visible restoration on return. Corrections are append-only adjustments retaining active time, excluded idle, manual adjustment, user/project/drawing/session and reason. Current CSV rewrite/save source is not relabelled as that accepted target.

| User sequence | Proposed Main/More experience | Result and lifecycle boundary |
|---|---|---|
| **Main: start/resume/pause/stop** | Header always names job/drawing/session context. If identity is not confirmed it reads **Unassigned — not billable**. Resume cannot silently make it billable from filename/folder inference. | Pause/Stop states are visible session states, distinct from time-file write and drawing SAVE. No engineering state changes. |
| **Main: idle return** | Show active time, excluded idle interval and a visible choice: **Keep excluded** or **Restore as adjustment**. The choice includes a reason field and the original session/context. | Restore creates a visible append-only adjustment; it is not a hidden counter change. Existing toast/auto-pause source is current evidence only, not proof this target is live. |
| **More: manual correction** | Select a time entry/period and show original active/excluded/manual components, source context and reason. Preview proposed append-only correction rather than replacing the historical entry. | Apply adds a traceable adjustment connected to user/job/drawing/session/reason. It does not rewrite another job’s history or set a structural result. |
| **More: review/export** | Filter by job/user/date/context and inspect adjustment chain. Expert debug remains outside ordinary billing review. | Export is a separately selected output, not issue publication or drawing acceptance. |

### Cancel, reopen and context-switch contract

| Situation | Proposed result |
|---|---|
| Cancel an idle restoration or correction preview | No adjustment is written; existing active/excluded record remains. |
| Cancel after append Apply | Do not promise removal. Show the created adjustment and offer a new explicit reversing adjustment only if the audited owner supports it. |
| Close/reopen time browser | Save/No/Cancel applies only to local browser draft. Reopen reads active/excluded/manual adjustments and context separately; a drawing SAVE counter does not prove the time record persisted. |
| Switch from North to South while correction is pending | Preserve correction draft with **North job/drawing/session** origin. Recommended choices: Finish/pause North first; Park correction under North; Discard draft; Cancel switch. Where South is already recognised automatically as a known drawing/job, South adopts that shared current context without a new wizard. Only an unknown or ambiguous South context is **Unassigned/not billable**. No timer/correction silently transfers across jobs. |
| Stop or close with active North timer | Show whether the North session was paused/stopped and whether a time record/adjustment is pending. Opening South does not make the old time appear on South. |

**Fictitious two-job scenario.** Track an assigned North session, go idle, choose Restore as adjustment, then request South while the reason is still a draft. Park it; verify the parked item retains North user/job/drawing/session. A recognised South opens in its own shared context; only an ambiguous South is Unassigned. Begin an independent South session. Reopen North and complete its adjustment. A concurrent correction from another user requires conflict/recovery review, not whole-file replacement.

## W1. Context switching uses the shared decision; it never duplicates it

**Entry.** The Structural work surface may show the current drawing/view/level/source/revision/confidence. Project identity and document selection remain shared-owner authority. Automatic recognition and active-document hooks may switch the current view to an already recognised shared drawing/job. The existing Select/change document/context control is for manual document/evidence override or resolving an unknown/ambiguous context; a fallback folder is not job identity.

| Proposed sequence | Visible fields/actions | Boundary |
|---|---|---|
| **Main: inspect current context** | Show current job decision state, drawing/layout/view/level, source/revision/confidence, active note/time session count and any parked item origin. | Inspection makes no project record and does not merge data from a second drawing. |
| **Main: Select/change context** | Show current context beside candidate context. A larger evidence preview identifies document/source; working drawing preview stays primary for drafting. Actions: Keep current, Select candidate for review, Confirm shared context where allowed by owner, or Cancel. | Selecting/reviewing candidate context does not adopt a source, transfer notes/timer or reassign manual structural choices. |
| **More: pending work** | List only pending drafts/corrections by origin job/drawing/session: Resume original, Park, Discard, or Cancel switch. | Resume original returns to the saved origin unchanged. Re-context requires explicit review only when the user deliberately moves one item; no bulk migration of pending notes/time corrections. |
| **More: conflict/revision** | Show changed/missing source and prior context side by side. Manual interpretation remains visible; candidate is Needs review. | A new revision does not silently alter a drawing, timer context or shared job record. |

### Future acceptance batch

1. Open two synthetic drawings for North and South with different level/view context; confirm neither borrows the other’s manual context.
2. Start a North note with an attachment that later fails; switch to South, park the North draft and verify no South note is created.
3. Return to North, resolve a simulated concurrent edit using Merge, then inspect record/attachment receipt separately.
4. Create a North idle-restoration draft, switch jobs, confirm its origin remains North; then verify a recognised South adopts its existing shared context while an ambiguous South is Unassigned.
5. Save/reopen both drawings and note/time surfaces; verify no hidden transfer, duplicate project record, issue action or engineering adoption.

## Remaining choices and evidence gates

**Recommendation:** put Notes, active timer context and parked-work warning in Main; put attachment recovery, adjustment history and context-conflict detail in More. Badge wording/color for Unassigned and whether Park uses a drawer or compact dialog are **Proposed owner presentation choices**, not a new Tim decision; [choice-authority review](structural_choice_authority_review.md) records the same bounded rule. ST-09 conflict choices, Unassigned/not-billable state, idle restoration and append-only corrections remain settled.

Future gates are separate: actual palette/context visibility; native drawn-note rendering; attachment-storage durability; concurrent persistence; true idle timing/toast behavior; drawing/time save-reopen; and Tim’s AutoCAD acceptance. No implementation, source edit, build, test, AutoCAD, process, corpus/client scan, issue or deployment action occurred.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.

| 2026-09-17T00:24:12.3888029+10:00 | Proposed | structural_w0_w1_context_notes_time_cards.md | Added W0–W1 context, concurrent-note/attachment, idle-restoration, append-only correction and two-job switching interaction proposals without duplicating shared project ownership. |

