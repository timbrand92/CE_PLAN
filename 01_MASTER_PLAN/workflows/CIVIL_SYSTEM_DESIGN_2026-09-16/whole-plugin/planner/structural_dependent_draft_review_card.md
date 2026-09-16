# Structural dependent-draft review card — proposed joined interaction

**Planning checkpoint:** 2026-09-17T00:59:26.3087608+10:00. This companion makes the five cross-card interactions from the [multi-floor walkthrough](structural_multifloor_interaction_walkthrough.md) reviewable as one user sequence. It is a proposal for owner review, not an implementation or new engineering authority.

> **Read with:** [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md), [W7–W11 interaction cards](structural_w7_w11_interaction_cards.md), [W0–W1 context cards](structural_w0_w1_context_notes_time_cards.md), and [approved Structural decisions](structural_approved_card_reconciliation.md). The existing **Edit this only**, **Edit together** and visible **Manual creation** decisions remain unchanged.

## What the review card compares

The card opens only from a selected local result, a pending detail/schedule draft, or a deliberately opened review finding. It never finds a nearest beam, label, support, section mark or schedule row.

| Column | Before | Current | Pending |
|---|---|---|---|
| **Object identity** | Stable original/copy identity, drawing/view/level, relation state and last reviewed source/revision. | Identity and relation state read at review opening, including protected/missing state. | Exact draft target(s) and whether each is selected-original, selected-copy, Manual/independent, or unbound. |
| **Basis and values** | Previous confirmed/Manual/Unknown basis and presentation state. | Actual changed source/operation receipt, or an explicit statement that no material basis changed. | Proposed detail/schedule/presentation action and the basis it was prepared from. |
| **Manual/pinned presentation** | Existing manual label/mark/detail presentation and reason if recorded. | Retained Manual/pinned badge. | Any requested presentation change shown separately from engineering/source status. |
| **Outcome** | Previous receipt, if any. | Complete/Partial/Failed/Unknown/Blocked only for the reviewed operation. | Draft is Current to its recorded basis, Needs review, Parked, Discarded or not created. |

An **unchanged retained** label/mark position, saved default, or remembered setting by itself is **not** an actual changed source or operation conflict. It stays visible as Manual/pinned or future-default context. Only a direct confirmed change, a changed source, missing/protected identity, or an operation receipt affecting the selected relation may make a dependent draft Needs review.

## Main path: identify, compare, decide

| Step | Main interaction proposal | Result / boundary |
|---|---|---|
| **1. Enter review** | Header names job/drawing/view/level, selected stable identity, source/revision, operation receipt and pending-draft count. Large preview highlights only selected local items. | A same-looking mark on another level/view is not added. Unknown/missing/protected state remains explicit. |
| **2. Compare Before / Current / Pending** | Three aligned panels show prior basis, current readback/receipt and each draft. Highlight only changed fields, relation and scope; preserve unchanged Manual/pinned presentation in place. | A saved default appears in a small future-default line, never as a conflict by itself. No default, member property or engineering value is invented. |
| **3. Select one draft** | Select a detail, schedule, markup or presentation draft. Show its intended drawing/view/level and selected identity binding. | One draft can be reviewed without applying or discarding all others. A draft with incomplete current receipt is Unknown rather than quietly current. |
| **4. Choose action** | Main actions: **Open draft review**, **Keep pending**, **Park**, **Discard**, **Cancel**. Where a direct operation is supported, it is previewed separately. | Keep pending does not apply. Park retains original context/basis. Discard deletes only the local un-applied draft. Cancel makes no draft, drawing, source or setting change. |
| **5. Apply a reviewed downstream action** | Show exact affected identity, before/current/pending values and explicit output before Apply. If the user chooses an object edit, visible scope is **Edit this only** or **Edit together**. | Edit this only remains non-sticky: it changes only the selected object/label and leaves linked discrepancy for later QA. Edit together is available only after preview names each confirmed relation and exact change; it never expands to a nearby/copy/look-alike object. |

## Original/copy and Manual detail binding

| Situation | Proposed choice and receipt |
|---|---|
| **First detail for selected copied beam** | Header shows the selected copied-beam stable identity and its unconnected support/relationship state. Create/detail preview uses that selected identity. It does not ask the detail-COPY choice and does not inherit the original beam calculation or detail. |
| **Manual creation with no selected member** | Keep visible **Manual creation**. Result is Manual/Unknown and unverified, with drawing/view/level identity. It never fabricates a member or automatically binds to a copied beam because it looks similar. |
| **Copy an existing detail** | Only here offer **another view of same member**, **new member**, or **independent detail**. Preview old/new relationship and destination view/level. Fresh internal identity and duplicate visible reference confirmation remain required. |
| **Schedule row for original or copy** | Show original/copy identity and relationship state. Actions: keep independent, bind the deliberately selected existing identity, mark Unknown, Park, Discard or Cancel. A copied label/visible mark cannot bind the row. |

## Changed basis and stale-preview interlock

| Event while the card is open | Proposed outcome |
|---|---|
| Source revision or confirmed selected-object operation changes | Show old/current evidence/receipt and mark only dependent drafts **Needs review**. Disable Apply for that stale draft. Actions: refresh comparison, open draft review, Park, Discard, or Cancel. |
| User applies **Edit this only** to selected object | Retain relation/discrepancy and show it in Current; do not revise pending details/schedules or move connected objects. It may make a specifically dependent draft Needs review only when its recorded selected relation/basis changed. |
| User proposes **Edit together** | Require confirmed object list, drawing/view/level and exact relation change in preview. Any changed/missing/protected member is removed from the proposed scope and shown for review; no implicit propagation. |
| Only settings/default is saved | Keep existing drafts Current to their recorded basis and show future-default context. Do not reset manual positions, source basis, relationship state or calculation status. |
| A confirmed Manual MOVE changes presentation while a placement draft is open | Show old/new manual position and the draft placement basis. Mark only a draft that consumes the old presentation position **Needs review**; offer refresh, Park, Discard or Cancel. Keep the moved presentation as Manual/pinned. It does not make engineering/calculation values numerically stale, auto-catch up related graphics, or invalidate unrelated drafts. |
| Protected/missing item detected on revalidation | Mark that item Blocked/Missing and the related draft Unknown or Needs review according to the missing relation. Preserve all other independent drafts; never unlock/detach/clone. |

## Park, Discard, Cancel, partial receipt and reopen

| Boundary | Required scope and truthful outcome |
|---|---|
| **Park** | Retains only the named draft with original job/drawing/view/level, identity, prior basis, current observed state and manual/pinned presentation. It does not transfer context, update another job, write drawing output or turn a draft into confirmed data. |
| **Discard** | Removes only selected un-applied draft content after showing its identity/scope. It does not undo a prior physical operation, change a saved setting, or delete source/drawing evidence. |
| **Cancel** | Closes current review/preview without new output. It does not roll back an accepted immediate operation, save a draft, or reset manual presentation. |
| **Partial/Failed/Unknown upstream receipt** | List each dependent draft separately as Current to unchanged basis, Needs review, or Unknown. Do not call a dependent draft updated merely because one other row completed. Retry begins with targeted readback and can never repeat a potentially completed drawing change. |
| **Save/reopen** | Future proof must distinguish saved drawing output, operation receipt, pending/parked draft and manual/pinned state. Current persistence behaviour is not established by this planning card. Reopen cannot reconstruct a relation from text/position/proximity. |

## Fictitious representative scenario

On a synthetic Level 1/Level 2 job, select a copied Level 1 beam and begin its first detail. Open a separate Manual detail on Level 2. Start a foundation review that completes one selected local element, skips one protected item and leaves one row Unknown. The card marks only the detail/schedule draft tied to the completed element Needs review; the Manual detail and the saved future default remain as they were. Use Edit this only on the selected copied beam, Park its schedule draft, then open a copied detail and deliberately choose independent detail. Change the source while a preview is open; verify Apply disables for that draft. Reopen and confirm each parked/Manual/copy identity still names its original drawing/view/level, with no automatic relation or retry.

## Future acceptance boundary

Test in the real application with: one selected original, one copied member, one Manual-created detail, same visible mark on two levels, a saved setting, a real source/operation change, a protected object and Partial/Unknown receipts. Verify the three-column comparison, non-sticky Edit this only, constrained Edit together, Park/Discard/Cancel scope, save/reopen and drawing Undo boundaries separately. This is a future acceptance scenario, not a test claim.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD, process, deployment, issue action or client scan occurred.