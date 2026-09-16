# Root25 interaction audit — first read

FOR TIM

The new proposal substantially fills the calculation membership and schedule comparison gaps. Two state distinctions still need correction before closure: pending calculation edits versus adopted inputs, and a saved schedule override versus a newly typed replacement.

---

Actual file read: 25_CALCULATION_AND_SCHEDULE_REVIEW_INTERACTIONS.md, sections A–D. This audit assesses proposed interaction logic only; no calculation, source read, native action or visual test was performed.

| Finding | Evidence | Required change | Disposition |
|---|---|---|---|
| UX01-A | B5 updates accepted source information “in the draft” then says result remains out of date until confirmed input changes are calculated. | Separate pending review from adoption: retain the prior result with its exact confirmed basis while edits are pending; show draft comparison/result separately. Confirming governing changes invalidates affected prior results. Merely accepting source information into an unconfirmed draft must not imply adoption or overwrite the last result. | Open; root notified. |
| UX02-A | C compares Previous linked / New linked / Your pending override / Reason. It omits the separately saved override when a new value is typed. | Show saved override/reason and pending override/reason distinctly. Define Discard as discarding pending changes, restoring saved override, and retaining new-source Needs review. Keep override must clearly identify which value is being retained/confirmed. | Open; root notified. |

UX01 otherwise now supplies a concrete first-system route, Select on plan versus Review candidates, included/excluded rows and reasons, exact control choice, no fallback, no inferred connection, preserved manual required storage, comparison cancellation and partial-refresh state. Remaining general draft persistence/Close policy belongs to UX08, already assigned to root.

UX02 otherwise now supplies stale Update prevention, focused comparison, Keep versus Use linked value, separate wider Restore Row, Xref protection, missing pit/manual-row distinction, exact set/instance update and repeated-source-change invalidation. The saved-versus-pending override case is not closed merely by those other controls.

Planner received UX03–06 requirements directly. No whole-package completion disposition is made in this resumed review.
