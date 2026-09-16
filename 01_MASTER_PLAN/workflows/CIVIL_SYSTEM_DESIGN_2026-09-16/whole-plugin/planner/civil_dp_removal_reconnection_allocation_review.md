# Civil DP removal and reconnection — released-allocation review proposal

**Planning checkpoint:** 2026-09-17T00:55:31.6700510+10:00. This proposal closes only the user interaction between an already selected downpipe (DP) removal/reconnection and its catchment allocation review. It does not redesign Drainage Items, CD/PIT, CDDESIGN, calculation, profile or Water Tank work; their active owners remain unchanged.

> **Authority and boundaries:** [shared setup/allocation depth audit](../audit/coverage/SHARED_SETUP_ALLOCATION_DEPTH_AUDIT.md) SHUX03 identifies this precise gap. [Root change/allocation contract](../23_CHANGE_ALLOCATION_AND_ISSUE_HANDOFF.md) §2 is authoritative for shared roof/DP accounting and §5 for copied DP review. Read also the [15 Sep Drainage Items handover](C:/Users/TimothyBrand/.codex/worktrees/28a2/CE_ACAD_PLUGIN/docs/workflows/CIVIL_WINDOWS_PLANNING_2026-09-15_DRAINAGE_ITEMS_DESIGN.md) §11: each DP has one destination, an outlet has its own authoritative LPD record, and portions may be unequal. This is a reviewable proposal, not an accepted workflow or implementation claim.

## What the reviewer sees before a choice

Start from one **selected existing DP**, its stable identity and drawing/view context. The review pane shows, without deriving any value:

| Show separately | Why it remains separate |
|---|---|
| Existing DP graphic/state | A drawing erase, retained graphic or reconnection can be an already committed drafting action. It is not itself proof that the hydraulic allocation changed. |
| Original catchment/source and confirmed total, if known | Site extent, surface classification and hydraulic catchment remain distinct. Missing value stays Unknown. |
| Last confirmed DP allocation and basis | The last confirmed portion/outlet remains visible as the historical governing basis. A Manual/pinned portion cannot be silently divided across remaining DPs. If its DP graphic/reference is missing, show that mismatch as **Needs review**. |
| Old nominated destination/outlet and new selected destination, if any | A DP has one destination. Outlets retain separate governing records/calculation scope; similar labels or nearest geometry are not a destination. |
| Proposed allocation draft | **Propose released/unassigned**, **propose reviewed reassignment**, or **leave confirmed basis unchanged**. The pane names the exact scope and affected outlet/calculation review. A draft is distinct from the retained confirmed allocation and does not compute a new engineering value. |

## Proposed Main/More sequence

| Point | User-visible proposal | Result / boundary |
|---|---|---|
| **Main: select DP and action** | Select old DP; header shows existing graphic, catchment, assigned portion, old destination, manual/pinned status and current source/revision state. Choose **Remove graphic** or **Reconnect graphic** through the familiar active-owner route. | This does not infer a new catchment, destination or allocation from position/crossing/proximity. If the route has already erased/reconnected graphics, show that as an existing completed drawing action rather than pretending it is a draft. |
| **Main: review released allocation** | After removal, show **DP graphic: removed/retained as observed** beside **last confirmed allocation: portion/outlet retained; DP reference missing — Needs review**. Actions: **Propose released/unassigned**, **Stage reviewed reassignment**, or **Cancel allocation review**. | No nearest-DP reassignment, equal redistribution or unclassified remainder assumption. The proposal is not governing until confirmed; Cancel allocation review does not claim to undo an earlier ERASE. |
| **Main: review reconnection** | For a reconnected DP, show old and newly selected destination/outlet side by side with the same original portion/catchment. Large plan preview highlights the DP, catchment and both destination scopes. | A selected new destination is only a review draft until adoption. It cannot merge different outlets’ LPD/catchment/calculation bases or make the old destination disappear without a visible old/new diff. |
| **More: reassign a reviewed portion** | Pick the target DP/catchment/outlet deliberately. Show every affected entered portion and remaining/unresolved balance, distinguishing Confirmed, Manual/pinned, Candidate and Unknown. | Allow unequal entered portions. Do not alter another DP’s value to balance totals. No numerical tolerance, routing or hydraulic default is created by this card. |
| **More: manual override and source change** | Keep Manual/pinned portion/basis visible. If source/catchment/destination changes while review is open, show old/new evidence and mark the draft Needs review. | A manual value is never quietly overwritten. An unadopted candidate causes review, not a numerical stale claim; an adopted governing change makes only its consumers Out of date. |
| **Apply reviewed allocation** | Preview retained confirmed old allocation beside the proposed new allocation/outlet membership, manual overrides, proposed released-balance state, and known affected calculations. Confirm the selected scope. | On a successful confirmation, the allocation becomes released/unassigned or reassigned as selected; before that it remains a draft. The allocation receipt is distinct from the graphic route receipt. Only this confirmed governing change makes dependent results numerically Out of date. No issue/drawing completion claim follows. |

## Cancel, Escape, Undo, save/reopen and partial receipt

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Escape **before** graphic action | No proposed graphic or allocation change. |
| Cancel/Escape during allocation review after a prior physical erase/reconnect | Discard only the pending allocation draft. Keep the already completed drawing action visible; retain the last confirmed allocation with its missing-DP/reference mismatch marked Needs review. |
| Cancel before allocation Apply | No release/reassignment is adopted. Existing confirmed/manual portions remain as the recorded basis; the removed/reconnected DP reference mismatch stays visible as Needs review, rather than silently restoring, redistributing or declaring a numerical result stale. |
| Undo | Native Undo of a physical remove/reconnect and Undo of a later allocation change are separate future capabilities. This proposal does not promise a cross-operation/global Undo. |
| Partial action | Report drawing action and allocation action separately: for example **graphic removed / confirmed allocation retained with missing reference**, **allocation draft not adopted**, or **confirmed allocation receipt Unknown**. None is displayed as confirmed release/reassignment without its own receipt. Review actual drawing/reference state before retry. |
| Retry | Begin with readback of DP identity, graphic state, catchment/portion/destination references and any partial allocation receipt. Never repeat a remove, reconnect or reassignment merely because a prior label said Failed/Unknown. |
| Save/reopen | Restore stable DP/catchment/destination identities and last confirmed allocation plus explicit missing-reference/Needs-review state. A confirmed release/reassignment is shown only with its receipt; persistence of an un-applied draft is an owner evidence gap, never adoption. Label text, position or nearest DP never recreates an allocation. |

## Fictitious representative scenario

A synthetic roof catchment has two deliberately unequal DP portions. Select the first DP and remove its graphic. The review retains its last confirmed portion/outlet but marks the removed DP reference Needs review, while the remaining selected DP portion is unchanged. Stage a released/unassigned draft, then Cancel allocation review: the graphic remains removed, no share is silently moved, and the last confirmed basis remains visible with its mismatch. Then reconnect the second DP to a deliberately selected different outlet. Review old/new destinations and the same portion; retain a Manual override; stage but do not Apply a reassignment after a changed source makes it Needs review. Reopen the drawing with a missing former-DP reference and verify it remains unresolved rather than attaching to the nearest remaining DP.

## Acceptance boundary and ownership

Future representative acceptance must separately inspect the graphic result, allocation state, outlet scope, calculation staleness after confirmed governing change, native Undo, save/reopen and no-proximity reassignment. It must include remove, reconnect-to-same outlet, reconnect-to-different outlet, manual override, Cancel after prior erase, partial receipt and missing-reference cases.

Active Drainage Items/CD/PIT owners retain the item/pit/pipe operations. Root23 retains allocation/storage integration. This companion proposes only the review doorway and result wording so those owners can link it once; it does not create a competing window or prescribe an implementation.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, test, AutoCAD, process, drawing, client scan, deployment or issue action occurred.