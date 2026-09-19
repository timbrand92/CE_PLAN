# Structural first foundation placement — host-bound and standalone card

**Planning checkpoint:** 2026-09-17T01:08:34.5811465+10:00. This fills the ordinary drafting gap between the Foundation Manager/regeneration cards and the approved initial-placement sequence in [ST-06 Foundations and rebar](C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-06_FOUNDATIONS_REBAR.md) ST6-2 through ST6-10. It covers **RIB / REB / THC** as host-bound raft/slab elements and **SF / PFC** as standalone strip/pad-footing routes. It does not choose foundation sizes, depths, marks, engineering values or a new asset/library policy.

> **Read with:** [raft host entry/adoption](structural_raft_host_entry_adoption_card.md), [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md) W5, [approved reconciliation](structural_approved_card_reconciliation.md), [workflow cards](structural_workflow_cards.md) W5, [daily RBL/RBC card](structural_reinforcement_daily_placement_card.md), and [dependent-draft review card](structural_dependent_draft_review_card.md). ST6 remains the full approval authority; Main/More placement is proposed only where the approved card does not specify it.

## Daily discovery and host rule

| Group | Retained familiar routes | Non-negotiable identity boundary |
|---|---|---|
| **Host-bound raft/slab elements** | `RIB`, `REB` and `THC` remain frequent Foundation workspace aliases under ST6-2. | Before placement, each requires an **explicitly selected raft/slab host** under ST6-6. [Host entry/adoption](structural_raft_host_entry_adoption_card.md) records that `FADOPT` adopts an existing host but the named sources do not establish blank-perimeter creation. The host relationship is permanent. A nearby slab edge, filled hatch, similar mark or background line cannot become the host. |
| **Standalone foundation routes** | `SF` and `PFC` remain familiar routes for their selected/drawn footing driver geometry. | No raft/slab host is silently added because one is nearby. Standalone output still has its own driver geometry and compound identity. |
| **Legacy/manager work stays separate** | `FADOPT`, library maintenance, regenerate, system rename/delete and schedule export retain their existing approved cards. | This card is first placement, not a broad scan, an adoption shortcut, an automatic regeneration, or a second schedule engine. |

## Main first-placement sequence

| Step | Host-bound RIB / REB / THC | Standalone SF / PFC | Visible outcome |
|---|---|---|---|
| **1. Start with a local driver** | Preselect eligible local linework where supported, or choose/draw the intended driver geometry. Header shows drawing/view/level, selected geometry and source/Manual/Unknown state. | Preselect eligible local driver geometry where supported, or choose/draw the intended strip/pad footing driver. | Xref, REFEDIT, locked and unsupported geometry remains protected. A visible line or nearby label is never enough to infer a foundation type or source. |
| **2. Select the host or confirm standalone scope** | Select one exact raft/slab host. Preview names host stable identity, drawing/view/level and selected driver separately. If no eligible host is selected, block only this placement with **Host Unknown/Missing**. | Show **Standalone — no raft/slab host selected** beside the driver. Do not offer a nearest-host suggestion. | The distinction is visible before any size/type prompt or drawing output. |
| **3. Choose only supplied foundation information** | Choose type, mark, size/depth and any available source/approval state. Every value shows Confirmed, Manual/Designed, Assumed or Unknown. | Choose type, mark, size/depth and any available source/approval state with the same provenance treatment. | Missing size/depth stays **Unknown**, never zero and never inferred from a mark, common library entry or historical frequency. Where the missing field is required to derive the proposed geometry, do not present the warning as a complete preview/Apply permission: state **Cannot confirm complete compound**, then Park or Cancel until a governing input is supplied/reviewed. |
| **4. Inspect complete live preview** | When supplied inputs can derive the result, preview driver geometry, generated outlines/hatch, label/design data, selected host relationship and Flip/Rotate where relevant. | When supplied inputs can derive the result, preview driver geometry, generated outlines/hatch, label/design data and Flip/Rotate where relevant. | Preview identifies all local selected outputs and manual label position. If a required geometry input remains Unknown, show driver/host evidence and the Cannot-confirm state instead of fabricating a complete compound. This does not establish suitability, calculation or a schedule row. |
| **5. Apply one compound and repeat deliberately** | Apply creates one compound foundation element: driver geometry, generated outline/hatch, label, design data and permanent selected-host relation. Select/draw the next driver and host explicitly for a repeat placement. | Apply creates one compound foundation element: driver geometry, generated outline/hatch, label and design data. Select/draw the next driver explicitly for repeat placement. | One accepted element is one future Undo target. Applying a child element does not delete, own or alter the shared raft host. |

## Main and More controls

| Surface | Proposed visible actions | Boundary |
|---|---|---|
| **Main** | Start route; selected driver; selected host/Standalone state; type/mark/size/depth provenance; live preview; Flip/Rotate where relevant; Apply; Cancel/Esc. | Keep ordinary placement compact. Do not make the drafter navigate a Manager or create a system-wide edit merely to place one element. |
| **More: identity and provenance** | Show driver and host identities, source/revision, Manual/Designed reason, existing compound identity and candidate/missing evidence. | Inspection makes no host link, size decision or drawing change. |
| **More: selected edit/copy scope** | Selected **Move**, **COPY**, label position review and the existing edit path show exact selected compound and host relation. | MOVE affects only selected group. COPY creates a fresh identity and must link to the deliberately selected correct host where host-bound; it never shares or chooses a host automatically. |
| **More: recovery/legacy** | Link to FADOPT preview-only matching, Manager review, regeneration and schedule route only after the user deliberately opens those workflows. | No FADOPT nearest-label adoption, no FREGEN on drawing open, no whole-drawing scan while drafting, and no FSTEXPORT second schedule. |

## Cancel, Edit, partial and revision contract

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Esc before Apply | No foundation compound, host link or driver conversion is created. Existing local geometry, host and manual labels remain unchanged. |
| Cancel after a current direct route commits | Do not promise rollback. Inspect actual driver/output/host state before recovery; native Undo is separately proven later. |
| Host selection changes during preview | Disable Apply for that stale preview. Show old/new host identity and driver; refresh, choose new host, Park, Discard or Cancel the draft. Do not retain an old host by proximity. |
| Move the shared raft/slab host after children exist | Recheck the known host-bound children against the moved host and list each child identity, driver, relation state and any review finding. Preserve each child permanent host identity, authored/manual label position and selected compound scope. Actions: **Review affected children**, **Open selected refresh preview**, **Leave for review**, or **Cancel**. Recheck is not silent whole-system regeneration. Moving the shared host does not move/delete unrelated children, reset authored labels, or choose a new host. Any refresh stays selected/reviewed with its own receipt. |
| Manual label position or saved default changes | Preserve Manual/pinned presentation and treat a saved default as future-default context. A confirmed Manual MOVE can only review a pending placement draft that consumes its old position; it does not make engineering values stale. |
| Geometry/output completes but host or label/data receipt fails | State **Partial** with driver, generated graphics, label/design-data and host relation receipts separately. Do not repeat the route, create a duplicate compound or substitute a nearest host. |
| Edit / Move / COPY after placement | Edit preserves manual label placement. Move updates only selected foundation group. COPY creates fresh identity and, for host-bound output, requires explicit correct-host selection. It does not delete or move the shared raft host. |
| Save/reopen | Future proof must read back compound identity, driver geometry, generated parts, label/manual presentation, design-data provenance and host relationship separately. Visible graphics alone are insufficient. |

## Fictional before/after drawing example

On a synthetic raft-plan view, preselect a local internal driver and start RIB. The Main panel asks for one explicit raft host and shows its identity. Leave depth Unknown; the preview carries the Unknown warning, driver, full compound and host relation. Cancel once and check the original line and raft remain unchanged. Then Apply once, move the selected child compound without moving the raft, and COPY it only after selecting a different explicit raft host in the synthetic view.

On a second synthetic detail, start SF from a selected local path and PFC from selected/drawn local driver geometry. Each displays **Standalone** before the supplied type/mark/size/depth review and complete preview. No nearby raft hatch is selected. A missing/protected driver blocks only that placement. Change a selected host while a THC preview is open: its Apply is disabled until reviewed. No values, host or footing type are inferred in either before/after result.

## Future representative acceptance

Use a synthetic drawing with two local rafts, standalone local drivers, one Xref edge, one missing depth and a manual label position. Verify RIB/REB/THC require an explicit host; SF/PFC remain standalone; preview lists compound parts; Cancel/Esc leaves none; Apply creates one compound; Move/COPY preserve selected scope and shared-host protection; changed host makes preview stale; partial output does not retry blindly; save/reopen proves identities separately. This is a future AutoCAD checklist, not a test claim.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD, process, deployment, issue action or client scan occurred.


