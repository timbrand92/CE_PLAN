# Change, allocation and issue handoff — proposed implementation contract

FOR TIM

A revised roof must flag the calculations that actually use it. A copied DP must not silently receive the entire roof again. Including an unchanged sheet in the issue PDF must not give that sheet a new revision.

This makes the approved [change rules](05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md), [Civil authority](18_NETWORK_SOURCE_SURFACE_AND_QA_AUTHORITY.md), [schedule rules](13_CIVIL_APPROVED_DECISION_RECONCILIATION.md) and [issue rules](02_SHARED_JOB_AND_ISSUE.md) concrete for existing implementation owners. It is proposed planning detail, not newly approved behaviour, a storage redesign or implemented functionality.

## 1. Evidence handed to a calculation or dependent output

Each affected owner needs enough information to distinguish these events without asking Tim to repeat a confirmed decision:

| Event | Required information | User-visible consequence |
|---|---|---|
| Candidate source discovered | Job identity; document identity, page, stated revision and observed content/version evidence; affected scope; extraction uncertainty | New evidence / Needs review. Existing adopted calculation remains unchanged. |
| Governing input adopted | Exact confirmed target and prior/new value; units; source evidence; adoption decision; manual/pinned status and intended scope | Only consumers of the changed governing fact become numerically out of date. |
| Presentation-only edit | Object/view identity and changed display/position; unchanged engineering fact | Preserve manual presentation. Do not falsely mark numerical calculation changed. |
| Independent Structural edit | Exact selected object and operation scope; related objects deliberately left unchanged | Relevant discrepancy retained; no automatic catch-up later. |
| Calculation or output refreshed | Exact consumed input/rule versions, source scope, result and completion evidence | Current only for that scope. Failed/partial refresh leaves affected output stale or unavailable. |

These are information requirements, not prescribed new record names or duplicate stores. Reuse the existing owner and fingerprint authority. A filename, displayed mark or timestamp alone cannot establish identity or currentness.

An unrelated report page changing must not automatically invalidate every calculation. Conversely, a relevant instruction changing must reopen its dependent remembered exception even when its member mark stays the same. Exact relevant-change detection requires source qualification before automation; uncertain matching produces review, not invented certainty.

## 2. Shared roof and DP allocation

Read the resumed [DP removal/reconnection and released allocation proposal](planner/civil_dp_removal_reconnection_allocation_review.md) with the table below. It makes the remove/reconnect review concrete while keeping physical drawing deletion, assignment changes and unresolved shares separate. It is awaiting independent readback and does not alter the active Drainage Items owner.

The approved handover permits unequal sharing of one catchment, with each DP having one destination. Distinguish the source roof/catchment, its confirmed total area, each assigned portion, each DP identity and its nominated destination/outlet. Site extent, impervious classification and hydraulic catchment retain their separate meanings.

| Operation | Required preservation/check | Unsettled detail / implementation gate |
|---|---|---|
| Initial allocation | Show confirmed total, assigned portions and remaining/unresolved amount; detect overlapping/doubled claims | Numerical tolerance and any permitted unallocated balance must come from the approved engineering rule, not this document. |
| Change roof outline | Candidate geometry change is review only while old basis remains adopted | After adoption, recheck allocations and affected consumers. Do not assume equal redistribution. |
| Manually override one share | Keep the entered value and its basis visible; recompute allocation discrepancy | Do not silently reduce another DP's share to make totals fit. |
| Copy DP | Preserve the distinction between copied graphic/owned data and a new hydraulic allocation | Exact copy/reassignment interaction is not settled here. Identify duplicate claims for review; no automatic second full-roof allocation. |
| Remove or reconnect DP | Identify released/affected assignment and destination scope | Do not silently move its catchment to the nearest DP or a different outlet. Reviewed reassignment remains explicit. |
| Save/reopen or load source drawing | Restore stable assignments and report missing references; names/positions alone do not establish a match | Native persistence and qualified source identity need implementation evidence. No zero replacement for missing area. |
| Two outlets | Keep each destination and governing conditions separate | Shared-network split follows the approved nominated split, not first/nearest outlet selection. |

**Synthetic planning example:** one confirmed 100-unit area assigned 60/40 must still total 100 after reopening. Copying the 60-share DP cannot silently make the allocated total 160. Adopting an area of 120 exposes a 20-unit difference for reviewed allocation; the plan does not approve automatic 72/48 redistribution. These arbitrary units demonstrate accounting only, not drainage design values or tolerance.

## 3. Issue membership and revised-sheet membership

Keep these two reviewed sets distinct throughout preview, publication and history:

- **Included outputs:** every sheet the user selected for this issue package, including unchanged sheets.
- **Revised sheets:** only the sheets receiving the reviewed new revision/date and corresponding revision graphics.

The issue handoff carries exact drawing/layout/sheet identities and reviewed order, prior/proposed revision and date for each sheet, output grouping, filenames/folders, source evidence and the user's disposition of unresolved findings. Full-set combined PDF is the approved target; the inspected owner currently qualifies combined-per-DWG. That difference must remain visible until reconciled by its owner.

| Stage | Completion condition | Failure / retry boundary |
|---|---|---|
| Review | Exact included and revised sets visible, resources and findings exposed | Cancel retains draft intent; no completed issue claim. |
| Produce outputs | Each expected selected sheet represented in its intended file/group/order | Partial files do not prove complete issue. Keep truthful partial state; no extra revision increment on retry. |
| Verify outputs | Existing owner proves exact expected output and source/selection consistency | Changed source or membership requires renewed review; do not reuse an old receipt for different content. |
| Record history | Only verified reviewed result recorded, preserving unchanged-sheet dates/revisions | History-save failure is distinct from plot failure; retry recording without silently plotting/revising again. |
| Later issue | Compare against immutable prior issued evidence | Current edits never rewrite the earlier issued PDF or its recorded baseline. |

**Synthetic planning example:** sheets1–6 are included; sheets2 and5 are revised. All six must appear in the reviewed package, while1/3/4/6 retain their previous dates/revisions. If sheet5 fails to plot, the package is incomplete. Retrying must not advance2/5 another revision. This is an acceptance expectation, not a performed test.

## 4. Completion of this planning contract versus product proof

These interface requirements close the broad handoff descriptions with concrete state, scope and failure cases. They do not establish implementation. Existing owners still need to qualify dependency matching, allocation tolerance/copy interaction, consumed-version persistence, full-set PDF grouping and unchanged-sheet dates. Engineering or interaction choices absent from approved records stay open; source-answerable ownership and evidence questions should be resolved before asking Tim.

## 5. Proposed copied-DP review — concrete interaction for review

This fills the interaction gap above without declaring a new accepted COPY policy or modifying the Drainage Items owner's window. The approved invariants already apply: one DP destination, shared-area accounting, no automatic equal division and no second full-roof claim.

**Drawing example:** DP1 serves a confirmed portion of Roof A. The drafter copies its symbol to a second roof corner. The copied symbol's position alone cannot establish whether it shares Roof A, serves another catchment or is only a drafting copy.

| Point in the workflow | Proposed visible experience | Preserved result |
|---|---|---|
| Ordinary COPY completes | Keep the drafting operation usable. Identify the copied source as requiring allocation review rather than silently treating the copied allocation as additional confirmed flow. Exact badge/notification timing is proposed, not accepted. | Original DP and adopted allocation stay unchanged. No nearest-outlet assignment. |
| Open copied DP / review finding | Large plan preview highlights original DP, copied DP, Roof A and known nominated destination. Show original assigned amount, confirmed total and currently unassigned balance. Missing values say Unknown. | Show source evidence and manual entries without inventing an available balance or numerical tolerance. |
| Choose its intended service | Offer **Share this catchment**, **Choose another catchment**, or **Leave unassigned** as a proposed review choice. Pick/draw follows the existing catchment tools; it does not create a second site-area definition. | Selecting a route remains a draft. Copying a graphic is not acceptance of a hydraulic assignment. |
| Review shared portions | Present each relevant DP and entered share beside the confirmed catchment total. Permit unequal manual entries. Display excess/shortfall and destination scope; never rebalance others automatically. | Existing confirmed shares stay until the complete selected change is reviewed. Accepted tolerances come from engineering authority, not this proposal. |
| Apply allocation | Preview the exact old/new assignments and affected calculations. Require the normal adoption confirmation and qualified identities. If source or destination changed during review, refresh that scope before Apply. | One intended allocation change; unrelated catchments/outlets and pinned values are retained. Dependent results become out of date only after governing change. |
| Cancel / close | Discard pending allocation edits. The already copied graphic remains with unresolved allocation status; Cancel is not advertised as undoing the earlier COPY. | Original assignments stay. Native Undo of COPY or of a later allocation is separately qualified; no cross-operation/global Undo promise. |
| Save/reopen or partial failure | Retain the copied object's distinct identity and explicit unresolved/confirmed state. Missing roof/DP/destination is a visible reference problem. | Do not silently recreate an allocation from a duplicate label, nearby position or stale source. A failed receipt cannot show confirmed allocation. |

This is a reviewable interaction proposal, not an automatic engineering answer. The outstanding Tim choice is the presentation and handling of an unassigned copied DP; the invariant against duplicated adopted area is already settled. Existing active owner must review the proposal before implementation. Future synthetic checks cover copied-to-same-roof, copied-to-different-roof, duplicate visible labels, Cancel after COPY, changed source during review and reopen with a missing reference.
## Last Civil interface check — Water Tank owner handoff

This is a proposed cross-tool review sequence under the settled Drainage Items/CDDESIGN handover, root18 CV4-9–11 inheritance and C8 owner-preservation card. It is not a tank-window design, control proposal, new calculation method or ownership reassignment. The existing CDWT owner's later approved recovery/catalogue/detail choices govern its own window and physical operations. No implementation task is contacted or changed.

| Job moment | Required handoff between existing owners |
|---|---|
| Report discovered before a tank is drawn | Keep candidate requirement, purpose, document/page/revision and uncertainty. A report volume does not create a physical tank, adopt a design value or establish detention/reuse allocation. |
| Governing facts confirmed | Retain required capacity and use separately from calculated result and drawn provision. Existing linked roof/treatment/reuse grouping decision remains open; this handoff does not choose group versus individual confirmation. |
| Tank owner adopts, inserts or annotates | Use that owner's approved explicit mode and permanent tank/callout/riser/dropper relationships. An annotation alone is not proof of a physical tank, hydraulic connection or usable storage. |
| Compare required, calculated and provided values | Show each value's purpose, units, source and actual object/result identity. Total/nominal, detention and reuse capacities are not interchangeable. Missing information remains Unknown. No automatic conversion, arithmetic allocation or double credit is invented here. |
| Confirm an applicable relationship | Carry the exact tank/system/catchment/outlet identity already reviewed through its owners. A matching tank name, nearby DP or similar capacity cannot establish the relationship. Preserve the recorded manual basis and unresolved remainder. |
| Report revision arrives or tank provision changes | Candidate-only revision opens review without adopting values. An accepted relevant physical/value change marks only actual dependent results for review/out-of-date status, retaining their earlier basis. Unrelated outlet/treatment records do not inherit it. |
| Prepare issue | Show the confirmed requirement, selected calculation evidence and actual provision/relationship status together. The shared issue owner retains QA disposition and output verification; this adds no universal plot ban or new tank editor. |

**Fictional example:** a report specifies reuse storage, while the drawing only carries a generic total-volume callout. The review shows the reuse requirement and the generic provision separately; detention provision remains Unknown until its actual basis is established. Moving that callout does not alter either volume. Confirming a later report value does not automatically resize the tank or reconnect a DP.

**Cancellation example:** tank geometry was accepted through its owner, then a later allocation comparison is cancelled. Preserve the accepted geometry and its actual saved/unsaved state; retain the previous confirmed allocation or visible unresolved relationship. Do not claim that cancelling the comparison removed the tank, approved its volume or undid a prior operation.

Future combined proof belongs to the existing owners: one source fact before geometry; one explicit physical adoption/insertion/annotation mode; exact relationships; required/calculated/provided comparison; candidate revision versus adopted change; retained manual basis; cancelled later comparison; partial output and save/reopen. This is documentary planning only, not an executed old-project trial or new native acceptance. Water Tank was considered last in this interface review; its separately authorised implementation schedule remains unchanged.
