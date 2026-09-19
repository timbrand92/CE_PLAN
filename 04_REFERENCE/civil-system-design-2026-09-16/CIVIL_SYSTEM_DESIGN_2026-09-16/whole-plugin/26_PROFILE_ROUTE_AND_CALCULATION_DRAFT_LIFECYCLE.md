# Long-section route changes and calculation drafts — interaction proposals

FOR TIM

A placed long section must not quietly jump to another branch when a pipe disappears. Closing a calculation must distinguish saved inputs, pending edits, the result and any note already placed on the drawing.

This continues the approved CV6/HD/HV requirements in [15](15_HYDRAULICS_PROFILES_AND_CONTINUATIONS.md), PS close protections where applicable in [13](13_CIVIL_APPROVED_DECISION_RECONCILIATION.md), and the proposed membership interaction in [25](25_CALCULATION_AND_SCHEDULE_REVIEW_INTERACTIONS.md). It describes proposed interaction detail, not current implementation, engineering defaults or permission to alter active-owner windows.

## A. Create a long section from scratch

1. Choose **Long section**, then **Select start pit on plan**. Show the exact drawing/pit identity and highlight it. Cancel selection returns to the existing work surface, retaining any other draft.
2. Highlight reachable routes using known connectivity. At each real branch show destination names and a plan highlight for the selected alternative. An unrelated nearby LPD is not a route candidate. Ambiguity remains visible; never guess an outlet to make the list complete.
3. Review the ordered pit/pipe route, nominated endpoint and any missing levels/surface. The main pane is the proposed profile; selecting a row highlights its source in plan. **More** shows source identities, governing calculation version and detailed checks.
4. Enter or confirm datum, horizontal/vertical scales and any vertical exaggeration. No numeric default is approved by this proposal. Show missing settings and Unknown levels as such; do not draw a zero-level profile merely to fill the pane.
5. Preview the exact section and drawing footprint. Keep readable approved text/graphics; if it does not fit, propose a reviewed continuation/layout change rather than shrinking text. Existing approved profile/schedule format governs.
6. **Place linked section** requests insertion point. Cancel point selection retains route/settings/draft; failed insertion reports known output state and returns to review. A successful linked insertion records route, settings and source revision under the existing owner, followed by native Undo/save-reopen qualification.

## B. A saved route is no longer valid

**Example:** an existing profile follows P1 → P2 → P3. A later drawing change removes its P2–P3 pipe while another branch from P2 still reaches P4. The section must not silently become P1 → P2 → P4.

| Step | Proposed visible experience | Protected state |
|---|---|---|
| Open existing section | Show its last placed appearance labelled **Out of date — route interrupted**, with the missing segment highlighted. Preserve previous route identities and scales. | No silent geometry update, nearest-segment substitution or deletion of the existing section. |
| Review route | Split display into the retained route list and plan/profile preview. Identify unchanged segments, missing segment and any genuinely reachable alternatives. | Candidate alternatives do not become the adopted route by hover or first-list selection. |
| Choose replacement | **Select replacement on plan** or choose a displayed reachable route; show endpoint, ordered segment changes and affected profile rows before accepting. An alternative destination is explicitly visible. | No change to the network itself from choosing a display route. Editing network engineering is a separate existing command. |
| Keep old section | Retain old placed output as out of date with its missing-route finding. | Never relabel it Current or use it as a newly verified calculation result. Ordinary drawing work remains usable. |
| Review update | Compare removed/added/changed route rows; preserve existing insertion point and unaffected presentation/settings. Manual presentation differences are shown, not discarded. | Updating a route does not authorise adopting an unrelated source, moving fixed levels or changing diameter/material. |
| Apply update | Update the exact selected existing linked instance using the reviewed route and current source evidence. | If geometry changes again during review, retain pending choices and require a fresh comparison. No delete/re-place fallback or duplicate instance hidden behind success. |

**Unknown/partial recovery:** if output or saved route evidence cannot be read back after failure, classify the operation Unknown. Inspect the actual selected instance before any retry; only retry when absence or a qualified safe-resume point is established. Do not assume a thrown error proves no geometry was written. Cancel before Apply retains old section plus pending choices under the reviewed close policy; Cancel after a committed operation cannot promise to undo it.

## C. Calculation drafts, switching systems and closing

Separate four states in the same surface: **confirmed system inputs**, **pending input edits**, **result with its consumed basis**, and **placed/exported outputs**. A tab or selected system name alone does not prove separate physical membership.

| Action | Proposed treatment of pending work | Result/output consequence |
|---|---|---|
| Switch to another existing system | Retain the outgoing draft visibly under its exact system identity and show the incoming system's own draft/confirmed state. Dirty marker means pending edits, not failed hydraulics. | Never recalculate, clear or copy membership merely by switching. No merge by similar system name. |
| Add system | Start an unconfirmed system record and use [25's membership review](25_CALCULATION_AND_SCHEDULE_REVIEW_INTERACTIONS.md). Existing drafts remain separate. | No all-drawing auto-selection and no inherited control pit. |
| Calculate pending edits | Offer **Preview calculation** with explicitly Draft result and its input basis. This action does not save/adopt pending inputs by implication. | Last confirmed result remains tied to its prior confirmed basis; draft result cannot be passed to issue as current without the reviewed confirmation/output path. |
| Save confirmed inputs | Review scope and source changes, then confirm selected input changes. Record actual success/failure separately from recalculation. | Confirmed changed governing inputs invalidate their old results. Recalculation failure cannot be hidden by a successful input save. |
| Close with pending drafts | Show affected system names and **Apply / Discard / Continue Editing** as a proposed calculation-close pattern; preserve approved exact close behaviour for PS windows separately. Apply reviews and validates the pending scopes; it cannot bypass missing identity or stale source. | Discard restores confirmed inputs/results under their actual freshness, not fabricated Current. Continue Editing keeps all pending values. Previously placed notes/files remain separate completed work. |
| Delete calculation record | Preview selected calculation identity, memberships and dependent outputs; require explicit scoped confirmation under its reviewed owner. | Record deletion is not permission to delete physical pipes/pits or issued outputs. A linked output becomes missing/unresolved until deliberately reconciled; no silent reassignment to another system. |

Draft persistence between sessions is proposed, not assumed built. Until qualified, the UI must not promise recovery of unsaved drafts after closing/crash. Stored confirmed records, actual DWG disk save and exported files need their own truthful receipts.

## D. Insert or update criteria text from a calculation

**Select result → review content/source → preview on drawing → place/update.** The selected confirmed result, system, governing requirements and source revision are visible. A draft result or unresolved required value is shown explicitly; it cannot silently become authoritative issued criteria. Unsupported fields/sections are identified rather than omitted behind a generic success.

For an existing generated note, identify the exact note instance and compare prior generated text, current confirmed result and any direct/manual text differences. Proposed actions are **Update reviewed generated fields**, **Keep existing note for review**, or **Cancel**; manual text is not silently erased. If the note has no provable relationship, keep it unlinked and require explicit selection/association review—no nearest-text matching.

Cancel at insertion point retains the calculation and text preview; no note should be claimed placed. If placement partly succeeds, report exact known geometry state and inspect it before retrying. Saving criteria parameters is not proof the note exists; note placement is not proof the calculation record or DWG reached disk. No automatic explode/asset fallback is authorised here beyond existing approved asset policy.

## E. Independent planning checks

- Remove one saved-route pipe while a different branch remains: show interruption and explicit destination change, never silently reroute.
- Change route geometry again after review: invalidate Apply while retaining pending route choices.
- Switch between two systems with different unsaved exclusions: no shared rows, control-pit substitution or lost manual storage value.
- Preview a draft result then Discard: recover confirmed basis and actual freshness; no draft values remain in criteria output.
- Update criteria text manually, then revise the calculation: show generated/manual difference before replacement.
- Fail after potential profile/note insertion: Unknown requires readback before retry, not automatic duplication.

All are proposed planning scenarios. No command, profile, calculation, note or output was created in AutoCAD during this run.
