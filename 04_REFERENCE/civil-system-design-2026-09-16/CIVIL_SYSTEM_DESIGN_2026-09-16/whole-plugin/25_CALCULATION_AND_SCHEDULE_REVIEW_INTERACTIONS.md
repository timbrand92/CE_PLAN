# Civil calculation and schedule review — detailed interaction proposals

FOR TIM

Refresh should show what changed without losing your exclusions or the value you were typing. A detention system needs an explicit set of assets and control pit; a pit schedule needs to retain both its linked value and your override.

This resumed planning block develops concrete interactions under [HD/HV/CV6 authority](15_HYDRAULICS_PROFILES_AND_CONTINUATIONS.md) and [PS1–22](13_CIVIL_APPROVED_DECISION_RECONCILIATION.md). Existing approved requirements govern. Window arrangement, labels and review sequences below are proposals, not built or Tim-accepted changes. Current source effects remain separately recorded in15. No hydraulic values or engineering tolerances are adopted here.

## A. First detention system — choose the physical system before counting storage

**Example:** a drawing contains two separate detention systems. A new calculation must not collect every detention-labelled pipe in the drawing into both systems.

| User step | Visible selection and preview | Result / cancellation |
|---|---|---|
| Open calculations and add a system | Name identifies this calculation record; a large plan preview shows candidate assets without counting them as confirmed members. Header shows drawing and source freshness. | Opening/creating a draft does not edit the drawing or establish a control pit. Close preserves or discards draft through the reviewed close policy. |
| Choose assets | **Select on plan** returns to ordinary drawing selection. **Review candidates** lists supported typed assets with their identity and inclusion reason. Existing system assignments and missing identities are visible. | Hover/highlight is not selection. Cancel drawing selection returns to the retained draft. No inferred membership solely from nearness or common naming. |
| Review membership | Included and excluded rows are distinguishable; excluded rows retain a reason. Preview highlights exactly the included physical assets. Shared/duplicate claims are findings requiring review, not silently resolved assignments. | **Exclude from this calculation** changes draft membership only; it never deletes a pipe or pit from the drawing. Numerical totals remain labelled draft until membership is confirmed. |
| Nominate control pit and destination | Pick the exact available control pit from the reviewed system and show it on plan with its relevant connection. Missing or ambiguous relationship is identified. | No first-row or nearest-pit default. Selecting a name does not establish a hydraulic connection. No complete design result while its required control identity is unresolved. |
| Review basis | Membership, control pit, adopted requirements, manual required storage and input evidence are shown together. Unknown inputs are named. Method capability and result status remain separate. | Confirming membership does not approve an unsupported calculation method or source rule. Manual required storage is retained independently of a calculated suggestion. |
| Calculate / review result | Show the exact confirmed system, governing inputs and calculation revision beside result/controlling reason. Review a suggested design change separately. | Running a calculation does not silently resize drawing assets, change control pit, adopt a report or downsize pipes. |

**Main surface:** system selector, physical membership summary, control pit, governing required storage, result status and large plan/result preview. **More:** detailed provenance, exclusion reasons and technical calculation breakdown. Essential missing-input or conflicting-assignment reasons remain visible on the main surface. Existing fields in the retained-control record remain available; this proposal does not remove them to fit the sketch.

## B. Refresh while detention edits are pending

1. An excluded pipe and a manually entered storage requirement remain visibly pending in the draft. **Refresh from drawing** obtains a new comparison; it does not replace the working collection immediately.
2. The review shows **Added / Changed / Missing** assets against the last confirmed membership. Each row shows prior inclusion and draft inclusion; new candidates are not pre-confirmed members.
3. Existing exclusions remain excluded unless explicitly changed. A renamed-but-identical asset retains identity; an uncertain match remains unresolved rather than matched by its text alone.
4. A missing control pit is shown as **Missing — choose replacement**. Keep the prior identity for evidence; do not select another pit automatically. Calculations needing that pit remain unavailable until the basis is resolved.
5. **Use reviewed drawing changes** updates only selected source information in the draft. Manual required storage, exclusions and unrelated system records remain intact. The last confirmed result stays labelled with its old adopted basis while these edits remain pending; a draft calculation has its own Draft result status. Only confirmation of changed governing inputs makes that confirmed result numerically out of date, pending recalculation. Separately, an actual adopted drawing-geometry change may already have invalidated the old basis; show that specific cause rather than blaming the mere presence of a draft.
6. **Cancel review** returns to the prior draft, which is visibly based on an older drawing snapshot. **Apply** stays unavailable while that snapshot is stale; pending work is retained for another review.

If only a candidate document is discovered, retain current governing inputs and calculation status while showing Needs review. If adopted drawing geometry changes, affected results are out of date. Those different triggers must not share an unconditional red “recalculate everything” action.

Partial refresh failure leaves the prior confirmed system and pending draft visible. Show which source comparison could not be completed; do not publish partial new totals as current. Save/reopen must distinguish confirmed membership, stored pending work if supported, last result basis and actual DWG save. Draft persistence is a proposed feature, not a claim about current source.

## C. Pit schedule — linked source changes while a cell is being edited

**Example:** a pit's linked cover level changes in the drawing while the drafter is entering a schedule-only override. The specific example values in any visual are fictional levels, not design recommendations.

| Moment | What the user sees / does | What remains protected |
|---|---|---|
| Begin editing a cell | Linked value, override mode and reason are available. The cell is visibly pending until accepted. **Update source pit/pipe** is a separate action from **Schedule-only override**. | Typed schedule text never silently becomes hydraulic truth. Xref engineering data stays read-only. |
| Source changes | Banner: **Drawing changed — review before updating**. Update/Place using the stale snapshot is disabled; the typed value remains in its cell/draft. | No automatic refresh erases the edit. Existing placed schedule and confirmed source remain untouched by opening the review. |
| Choose Review changes | Compare **Previous linked value / New linked value / Saved override and saved reason / Your pending override and pending reason** for the affected cell. Highlight its pit in the large preview. Unchanged rows stay quiet. | Natural/custom order, set membership and insertion point are retained. No wholesale override reset. |
| Keep pending override | Keep the currently typed pending value and pending reason, not the different saved override. Show the exact proposed value in the action preview. To retain the saved override instead, first choose **Discard pending edit**, then review that restored value against the new source. | This choice does not write back to source. The cell remains visibly an override, not “verified engineering”. Saving it records the source version actually reviewed. |
| Use linked value | Preview removal of this cell's override and show the new linked value. **Restore Row** remains a distinct wider-scope action with affected cells visible. | Do not reset neighbouring overrides because one cell is restored. |
| Continue editing | Keep draft open with unresolved comparison. | Stale Update stays disabled. Closing uses approved Apply / Discard / Continue Editing; Apply cannot bypass unresolved identity/stale preview checks. |
| Discard pending edit | Restore the saved override and its saved reason, or the saved linked-value mode if no override was stored. This is not Restore Cell. | Source-change Needs review remains; Discard cannot silently adopt a new linked value or declare a stale placed schedule Current. Cancel comparison alone retains the pending edit. |
| Review update | Show added/removed/changed rows and exact selected schedule set/placed instance, then update that instance at its existing insertion point. | No automatic delete/re-place or extra schedule. Accepted update has the approved single Undo expectation, subject to native qualification. |

If a linked pit is removed, retain the pending cell edit as unresolved work in the review; do not silently turn it into an authoritative orphan row. Offer review of removal or explicit creation of a set-owned manual row as a proposal. Such a row is clearly manual and cannot claim the missing pit's engineering identity. Duplicate displayed numbers and impossible ownership remain blocking conditions under PS5/PS21.

## D. Planning stress cases for independent audit

| Scenario | Required outcome |
|---|---|
| Two physical detention systems, same asset type | No duplicated automatic membership or control-pit selection; each confirmed scope explicit |
| Exclude pipe → Refresh → Cancel | Exclusion and pending manual values retained; old snapshot identified; stale Apply unavailable |
| Adopted control pit disappears | Missing identity visible, no replacement by first row, no fabricated complete result |
| Schedule source changes twice during review | Second change invalidates the first comparison; retain pending override, review fresh source before update |
| Restore one overridden cell | Only that cell returns to linked value; other overrides/order/placement retained |
| Source Xref unloads while editing | Pending work retained; source Unloaded; no source write-through, invented zero or “Current” update |
| Placed text was manually changed too | Show drawing-text discrepancy alongside source/override comparison; never quietly overwrite or treat it as a source edit |

These scenarios are planning checks, not executed plugin tests. Next visual focuses on the source-change/override comparison; independent audit must challenge the actual action states, not only the existence of these rows.
