# Structural daily section-mark and reference card

**Planning checkpoint:** 2026-09-17T01:11:52.1980202+10:00. This compact daily drafting card deepens the approved [ST-03 annotation card](C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md) ST3-9 through ST3-10. It covers familiar **SM / SECTION** placement, reference review, Move/Edit/COPY and repeated references. It does not choose a drawing scale, sheet reference, identifier, section detail or engineering value.

> **Read with:** [W7–W11 interaction cards](structural_w7_w11_interaction_cards.md) W7-B, [approved reconciliation](structural_approved_card_reconciliation.md) ST-03, [workflow cards](structural_workflow_cards.md) W7 and [dependent-draft review card](structural_dependent_draft_review_card.md). ST-03 is the complete approved authority. Current source prompts are observations; target Main/More and compound behavior are planning proposals until built and checked.

## Discovery and Main placement path

| Point | Daily action and visible fields | Result / boundary |
|---|---|---|
| **Direct SM / SECTION start** | Start the familiar alias from the annotation tools. The command prompt, transient drawing preview or existing annotation palette shows current drawing, layout/model or paper space, plotted-scale basis, current UCS/view and selected source/reference state; it is not a compulsory new modal window. | The command does not infer a section/detail relationship from nearby graphics or text. Current space/scale is visible context, not a new preset/default. |
| **1. Confirm reference information** | Enter or confirm section identifier and sheet reference. Show full visible bubble text and current source/Manual/Unknown state before geometry placement. | Identifier/sheet reference are coordination information, not engineering design values. No automatic identifier or sheet reference is invented from nearby marks. |
| **2. Select cut** | Pick cut start then cut end in the current drawing space. Preview the full cut line immediately with both bubbles. | Selected points define only this mark. Xref/locked/REFEDIT/unsupported objects retain native protection; the route does not modify their source content. |
| **3. Set view direction** | Use cursor or **F** to choose the view/hatch direction. Preview names direction and orientation beside cut start/end, identifier and sheet reference. | The preview is a compound preview. F changes the proposed side/direction only; it does not rotate the drawing, alter scale, or change text/reference values. |
| **4. Confirm native placement** | The confirming native placement click creates one plottable compound: cut line, both bubbles, hatch/view direction, identifier and sheet reference. | One accepted mark is one future Undo target. It is not a created detail, calculation relation or sheet issue action. |
| **5. Repeat or finish** | Start a new explicit mark with its own identifier/reference review, or Escape from the next pending mark. | Escape before the confirming placement click leaves no new compound and restores normal drafting state; runtime proof remains future work. |

## Ordinary edit, Move and repeated-reference path

| User task | Proposed Main/More sequence | Preservation rule |
|---|---|---|
| **Select/edit recognised section mark** | Main highlights the entire recognised compound and shows cut line, both bubbles, direction, identifier, sheet reference, drawing/view/level and manual presentation state. More separates reference edit from presentation edit. | Never treat loose nearby TEXT/MTEXT, a single bubble or a generic line as a complete section mark. |
| **Move compound** | Preview all owned parts moving together, retaining their orientation and reference identity. | A deliberate manual position is preserved. Moving does not create/repoint a section detail or update a calculation. |
| **Change label/bubble presentation** | The direct edit prompt or existing palette permits selected owned bubble/label position or style presentation review. Before/after preview shows entire compound. | Presentation move/format remains Manual/pinned and does not silently alter identifier, sheet reference, direction or any engineering source. A saved style/default does not reset an existing manual position. |
| **Edit identifier or sheet reference** | The existing palette or direct edit prompt shows old/new identifier/reference, both bubble results, duplicate-reference status and downstream draft/sheet review scope. Actions: Review reference edit, Keep current, Park, Discard or Cancel. | This is a coordination-text change, not ordinary label formatting. It cannot quietly alter embedded compound identity or an issued sheet; affected reference drafts become Needs review only after confirmed change. |
| **COPY a section mark** | Preview source/destination drawing/view/level, fresh internal identity, visible identifier and reference. If the visible reference duplicates another mark, show explicit confirmation. | COPY preserves visible identifier but creates fresh internal identity. A duplicate reference is flagged; nothing silently renumbers or shares the old mark identity. |
| **ERASE** | Show the complete selected compound scope before removal. | Erase removes the selected owned compound only. It does not erase a related detail, generic note or unrelated reference. |

## Cancel, revision, partial and save/reopen contract

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Escape before the confirming placement click | No new section mark, bubbles, reference or hatch direction are created. |
| Cancel after current direct placement has committed | Do not promise rollback. Inspect actual complete-compound state; native Undo is a separate future proof. |
| Source/reference changes while preview is open | Show Before/Current/Pending identifier/reference/direction and mark that pending mark Needs review. Disable the confirming placement click until refresh, Park, Discard or Cancel. |
| Compound geometry places but one owned bubble/reference receipt fails | State Partial with cut, each bubble, direction, identifier and reference receipt separately. Do not retry blindly or reconstruct missing content from loose text. |
| Manual MOVE during a placement/reference draft | Retain the confirmed new manual presentation. Only a draft that consumes the old presentation position needs review; no engineering value becomes numerically stale and no related mark auto-catches up. |
| Save/reopen | Future proof must read back compound identity and every owned part plus manual position, reference and direction separately. Visible bubble text alone is insufficient. |

## Fictional before/after drawing example

On a synthetic Level 1 plan, begin `SM`, enter a supplied identifier and sheet reference, pick a cut across local drawing content and use F to review the view side. The preview shows both bubbles, full line and direction. Cancel once: no mark appears. Apply once: one compound appears. Move it to clear a local note; the whole mark moves while the deliberate position stays manual.

Copy the mark to a second synthetic view. The copy receives a fresh internal identity but retains the visible identifier; the duplicate reference prompt is shown rather than renumbering it. Open More, propose a changed sheet reference, then Park it when a source revision appears. The original remains unchanged. A loose nearby text note and protected Xref line are never claimed as part of either section mark.

## Future representative acceptance

In a synthetic drawing, verify `SM`/`SECTION`: model and paper-space placement, reference entry, start/end selection, F direction, full compound preview, Cancel, one Apply/Undo, Move, manual bubble position, reference edit, COPY/duplicate confirmation, partial receipt and save/reopen. Confirm all output in the real application before calling it Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD, process, deployment, issue action or client scan occurred.


