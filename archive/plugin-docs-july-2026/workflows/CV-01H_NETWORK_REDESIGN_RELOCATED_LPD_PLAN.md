# CV-01H — Network redesign including relocated LPD

**Status:** visual/implementation approved; H1–H4 independently PASS;
H5 multiple-LPD authority queued
**Depends on:** CV-01E connected identity/flow, CV-01G impact preview,
CV-01F connected levels, existing `NetworkDesignService`, Fixed/Designed
provenance  
**Implementation:** H1/H2/H3A/H3B/H3C1/H3C2A/H3C2B/H3C3 independently
PASS; H4 final formal re-audit PASS at
`90451c1e41ef2942d11294bb81d8e043f78a959f`
**Deployment:** not authorised  
**DATA-01:** remains blocked

## Practical result

```text
Choose top control(s) + new bottom outlet / LPD
        ↓
CE reuses proven pit positions and pipe routes where practical
        ↓
Whole-network before/after:
Keep · Reverse · Regrade · New route required · Fixed stop · No feasible
        ↓
Full impact preview + explicit end-user sign-off
        ↓
One atomic Apply / one Undo
```

![Current run solve compared with relocated-LPD redesign](../image/CV-01/cv-01h-relocated-lpd-redesign-mockup.png)

The left side is a workflow sketch of current `CDRUNSOLVE`, not a literal
copy of its window. The right side is the proposed Civil Hub experience.

## The two staff modes

| Mode | CE behaviour |
|---|---|
| Drafting from a designed plan | Preserve supplied directions, levels and sizes; enter them quickly and report inconsistencies without redesigning them |
| Designing from scratch | Propose topology direction and Designed levels; show sources and `Advisory — engineer review required`; never claim compliance |

Pipe sizing is excluded. Existing sizes remain unchanged until the separately
approved CV-02A sizing workflow is reviewed and signed off.

## Exact relocated-LPD case

1. Staff nominate the connected network and its existing preliminary
   `LPD-EAST`.
2. Staff nominate/create `LPD-WEST`, its outlet IL and its provenance.
3. If the old outlet role is `Designed`, the proposal may retire that role but
   does not delete the object.
4. If the old outlet/boundary is `Fixed`, CE cannot move, delete, demote or
   overwrite it. The proposal must disconnect before it or return infeasible.
5. CE keeps pit XY positions unless a separate user move is explicitly in the
   proposal.
6. Existing pipe geometry is reused when it still connects the same stable pit
   identities. Flow metadata may reverse without reversing the polyline.
7. Any genuinely new connection requires a user-drawn or user-confirmed route;
   CE does not invent a path across the site.

## Topology rules

- stable identity and proven connectivity only; never nearest geometry;
- a tree has one unique path to its nominated outlet;
- a loop/mesh is `Unknown` until the user nominates the break/flow edge;
- with several outlets, staff assign each branch/catchment to an outlet; CE
  never chooses the nearest outlet;
- branch directions are oriented toward their explicitly assigned outlet;
- rising mains retain stored pump/design direction;
- XREF networks are preview-only and direct staff to edit the source DWG;
- existing/council pipes and boundaries are stop points.

## Fixed and Designed values

| Source | Default |
|---|---|
| Survey import / council boundary / existing asset | `Fixed` |
| CE calculation | `Designed` |
| Hand-entered | `Designed` with one-click lock, matching the approved CV-01 rule |

Fixed cover RLs, outlet ILs, pipe sizes, grades or user locks always win. A
conflict returns `No feasible solution`; it never unlocks or moves a Fixed
value. Unlocking is a separate deliberate, logged user action before a new
proposal is created.

## One engineering authority

CV-01H does not introduce another grade/sizing solver.

1. A new pure topology planner orients explicit connected subnetworks and
   records keep/reverse/new-route decisions.
2. The existing `NetworkDesignService` is extended through one reviewed
   `PreserveExistingSizes` redesign mode for Designed levels/grades.
3. Each explicitly assigned outlet subnetwork is solved once; results are
   combined only after every subnetwork is feasible and revalidates cleanly.
4. CV-01G produces the full drawing/label/arrow/schedule impact.
5. CV-02A remains the only future pipe-sizing suggestion doorway.

Unverified design rules stay visibly advisory. Missing governing values
propagate `Unknown`; they never become a false Pass.

## Immutable redesign plan

The plan records:

- current drawing/network fingerprint and canonical plan hash;
- work mode and nominated top/bottom controls;
- outlet assignments and Fixed/Designed provenance;
- every kept, reversed, regraded, newly required or retired-role item;
- before/after levels, direction, labels, arrows and full schedule rows;
- warnings, Unknown items and infeasible constraints;
- the exact rule source/version for every computed value.

`CanApply` requires:

- no `Unknown`, `Partial`, infeasible or stale result;
- every new connection route explicitly supplied;
- every subnetwork revalidates cleanly;
- complete CV-01G impact evidence;
- the end-user sign-off checkbox.

## Stale and atomic apply

Immediately before Apply, CE rebuilds the same canonical fingerprint used by
CV-01G. Any difference closes the apply path and requires a new proposal.

Apply is one caller-owned AutoCAD transaction containing:

- topology/from-to metadata;
- Designed levels/grades;
- flow arrows and owned labels;
- LPD role changes;
- linked ProjectData and complete schedule refresh.

If any existing write service cannot join that transaction, the writer
increment remains blocked; CV-01H must not apply a partial network. One AutoCAD
Undo restores the complete pre-redesign state.

The sign-off record stores staff identity, UTC time, drawing fingerprint,
proposal hash, work mode and rule basis. It contains no free-text contact or
payment data.

## Performance

- preview starts only on explicit request;
- use the audited CV-01G caps: 2,000 CE objects, 4,000 links and 5,000
  presentation/schedule records; the first record beyond a cap makes the
  result `Partial`;
- cycles remain `Partial` and name both ends of the repeated edge;
- no full network solve during MOVE, grip drag, selection or zoom;
- calculation runs from an immutable snapshot and posts results on Idle;
- a changed drawing invalidates the result rather than merging silently.

## Incremental build

### CV-01H1 — pure topology redesign planner

- control points, outlet assignment, unique-path orientation;
- keep/reverse/new-route/fixed-stop/Unknown classifications;
- opposite-side-LPD and multiple-outlet synthetic tests;
- no Autodesk or WPF dependency.

**Built and independently PASS 2026-07-24:** one AutoCAD-free planner
accepts stable nodes/connections, explicit top controls, explicit
branch-to-outlet assignments and user-nominated break edges. It classifies
existing routes as Keep/Reverse, preserves Fixed and rising-main direction,
names XREF boundaries, requires user-confirmed new routes and refuses to
choose between multiple outlets or break a loop itself. The exact
opposite-side-LPD case reuses the same tree, proposes only Designed flow
metadata reversals, retires only the old Designed outlet role and nominates
the new role. A connected old Fixed outlet is infeasible until staff nominate
a break before it. The immutable result carries the source-network
fingerprint, work mode, controls, assignments, `CV-01H1/topology-v1` rule
authority and a canonical plan hash. Every assigned outlet now requires its
own top control; Fixed/XREF/rising-main protection precedes any new-route
confirmation; the hash binds every raw topology/provenance field; and callers
cannot raise the locked 2,000-node/4,000-link safety limits. Focused synthetic
evidence is 34/34 in
net48 and net10; all three Release lanes compile with zero errors using
`-p:SkipDevBundle=true`.

The first independent audit identified those four bounded gaps. The first
correction re-audit then found that a null/damaged node or link row could
throw during hashing. All five findings are corrected and behaviorally
guarded: damaged rows receive an explicit hash sentinel and return `Unknown`
without proceeding. The final independent re-audit passed exact clean commit
`dcae8e2` with no findings.

### CV-01H2A — locked-size solver mode — independently PASS

- reviewed `PreserveExistingSizes` mode in the one `NetworkDesignService`;
- exact existing diameter per stable endpoint pair;
- missing, invalid, duplicate or infeasible size evidence fails closed;
- the normal sizing mode remains the unchanged default;
- no command, drawing or multi-outlet orchestration.

**Built 2026-07-24; independently PASS:** the existing service can now
run with a one-diameter ladder per pipe. It therefore calculates only whether
the existing size can support the proposed Designed grade/levels. It never
tries the next diameter. A hydraulically infeasible DN100 remains visibly
DN100 and blocked. Missing, invalid, duplicate or damaged size rows never
fall back to the office size ladder. Every oriented pipe must consume exactly
one evidence row and no unrelated row may remain. Endpoint IDs use
length-prefixed keys, so separator characters cannot bind a size to another
pipe. Focused evidence is 18/18 for the new
mode and 23/23 for the unchanged normal solver in both net48 and net10.

The first independent audit found the unrelated-row and endpoint-key gaps.
Both are corrected and behaviorally guarded. Formal re-audit passed exact
clean commit `f96d602` with no findings.

### CV-01H2B — explicit subnetwork orchestration

- one result per explicitly assigned outlet subnetwork;
- Fixed conflict, Unknown source, infeasible and revalidation gates;
- no pipe-size proposal.

**Built and independently PASS 2026-07-24:** one AutoCAD-free coordinator
accepts only the exact complete H1 plan, current network fingerprint and
current topology hash. It copies all calculation rows and standards, requires
exact node/link/outlet membership and provenance, and calls the audited H2A
locked-size mode exactly once per outlet. Results are not combined unless
every outlet returns the exact requested pit/pipe identities, unchanged
diameters, feasible values and a clean round-trip. Fixed invert conflicts,
Fixed link boundaries, XREF outlets, incomplete solver output, exceptions and
stale or malformed plans fail closed. It copies and independently reruns the
H1 input, then requires the supplied H1 result to match the proven result
exactly. A canonical `CV-01H2/solver-v1` hash binds the verified H1 plan hash,
all exact H2B solve inputs, required standards source/version, standards
values and complete outputs. Focused synthetic evidence is 56/56 in net48
and net10.

The first independent audit found four bounded fail-closed gaps: blocked H1
node decisions were not rejected; finite but impossible solver numbers could
be signed; malformed diameter ladders could pass; and distinct raw provenance
strings could share a hash. All four are corrected and directly guarded.
Depth, fall, velocity, outlet datum and pipe/pit invert relationships must now
be physically consistent before H2B can produce a hash.

The correction re-audit then found that a solver could return a positive but
wrong cumulative flow and still be signed. H2B now independently rebuilds
each directed pipe's exact cumulative catchment flow from the copied H1
topology. Leaf, branched and separate-outlet cases are directly guarded; one
branch cannot borrow or swap another branch's flow.

Formal re-audit passed exact clean H2B correction `20294dd` plus the
tests/docs-only command-count child `7d8bf4b`, with no findings. The auditor
independently reproduced 56/56 focused tests in both runtime extremes and
zero-error Release builds in all three runtime lanes.

Drafting-from-designed-plan mode deliberately does not run this redesign
solver: its supplied directions/levels/sizes remain unchanged. H3 may present
them, but a separate validation authority is required before CE can call that
mode solved.

### CV-01H3 — full read-only redesign preview

- implement the approved visual in Civil Hub;
- entire before/after network, values, impact and schedule;
- no Apply until H1/H2 and CV-01G pass.

**H3A independently PASS 2026-07-24:** the pure preview-evidence
boundary re-runs the signed H2 calculation and CV-01G impact check. It requires
the exact current network fingerprint, every current pit invert, matching
stable pit/pipe identities and ownership, complete CE label/arrow coverage and
the linked schedule authority. Pipe evidence must also match the H1 gravity or
rising-main type and contain no contradictory direction issue. Input and
impact evidence are bounded and indexed before coverage checks so an oversized
network fails closed without freezing the Hub. It produces immutable
before/after pit, pipe and impact rows only when everything is current and
complete. A canonical
`CV-01H3/preview-v1` hash binds the signed H2 result, CV-01G fingerprint,
current/proposed values, provenance and exact ordered change plan. Missing,
stale, infeasible, forged or partial evidence has no preview hash. H3A has no
AutoCAD, WPF or writer dependency. Exact accepted correction:
`335f1af7752206bc0d367038b2e219d52e7ccc9d`.

**H3B independently PASS 2026-07-24:** the existing Civil Hub
now owns one `Network redesign` page. It presents all pit rows, all pipe rows,
schedule/label/arrow impacts and blockers in virtualised tabs with explicit
before/proposed headings. The page has 44 px actions, keyboard/Escape, a
responsive summary layout and native WPF DPI behaviour across all three
presentation lanes. The normal Hub route safely shows an empty page; a
validated H3A result can be injected with a fail-closed refresh provider.
H3B remains read-only and contains no Apply button, command or rival palette.
The first audit found that a rejected forged result still exposed untrusted
rows. The correction suppresses every pit, pipe, impact and summary count
unless the whole preview is accepted as complete. Formal re-audit passed exact
clean commit `e7216cd964d16f4d5809d5c1231099da531481b8` with no findings.

### CV-01H3C — real-drawing bridge

**H3C1 independently PASS 2026-07-24:** one pure coordinator
now carries one immutable evidence set through the accepted H1 topology
planner, H2 locked-size solver and H3 signed full-preview boundary. It cannot
report complete unless every stage agrees. Missing topology, actual standards
values, linked schedule/annotation impact evidence or current impact
fingerprint stops before solving and exposes no proposal rows. Getter-only
results recheck exact stage references, authorities, work mode, fingerprints
and hashes; bounded copying stops oversized, endless or damaged evidence
before H1. It has no AutoCAD, WPF, command, transaction or writer dependency.
The first audit found forgeable completion and unbounded input copying. Formal
correction re-audit passed exact clean commit
`605bcdc619c9e9e697dbaf051fe0ff84bf65b610` with no findings.

**H3C2A independently PASS 2026-07-24:** one AutoCAD-free
projector converts already-read CE ProjectData and CV-01G truth into the H3C1
request. It binds stable pit/pipe handles, exact drawing revision, positions,
current levels/directions/diameters, explicit local-flow provenance,
standards, controls, assignments and outlet data. Missing, crossing,
duplicate, malformed, external-only, stale or oversized evidence returns
`Unknown` and no request.

The first exact-commit audit found that copied public snapshot rows could
replace a drawing handle/source or current connection direction/type while
retaining the ProjectData revision, and that unrelated/nested ProjectData
lanes were not bounded before JSON freezing. The correction now requires the
existing CV-01G projector's canonical drawing-truth seal, rechecks exact
handle/source/link structure against the bounded frozen ProjectData, and
bounds every serialized lane before hashing. Focused tests are 51/51 and the
combined redesign suite is 176/176 in both runtime extremes; full modern is
3959 passed plus 13 intentional skips and every release lane builds with zero
errors.

Formal correction re-audit passed exact clean commit
`e7507f3f440c532c0cd1aa7ad128e7778e772034` (tree
`00e3d96a0b0a7cfcd15d18125abf8603a7470e0a`) with no findings.

**H3C2B independently PASS 2026-07-24:** one shared read-only AutoCAD
reader now supplies both the existing design-impact preview and the redesign
bridge. It peeks only already-loaded ProjectData, freezes it before reading,
uses the existing pipe-truth/link/LPD/schedule authorities, caps attachment,
presentation, authority and model-space evidence, and repeats the active
drawing plus frozen ProjectData fingerprint check at the end. Its getter-only
result exposes a fresh ProjectData copy per consumer. Any switch, mutation,
oversize or unreadable evidence returns `Unknown`; nothing is repaired or
written.

**H3C3 independently PASS 2026-07-24:** the commandless nomination flow now
lives on the one existing `CDHUB` page. Staff choose one connected network,
top controls, explicitly confirmed current/proposed outlets, explicit local
flows and outlet ILs, one branch assignment per pit and any required loop
break. Session choices are memory-only and drawing-fingerprint bound. The Hub
closes before each AutoCAD prompt, every continuation and Preview reads H3C2B
again, and only an explicit read-only Preview can enter H3C2A/H3C1. Cancel,
drawing switch, foreign/disconnected selection, incomplete/oversized
evidence, loop without a break or Fixed/XREF conflict exposes no proposal.
There is no new command, palette, solver or writer.

The first audit found that an empty current-outlet nomination could hide the
old LPD role. The correction requires explicit confirmation: a Designed old
LPD stays visible through the retirement preview, while a Fixed/XREF old LPD
is named as a preserved blocker and cannot be recast. Formal re-audit passed
exact clean commit `a007bf7dc01c2426835ed82ec5f964bc1374e0e6` (tree
`15099375d0b0d4255d592c9686f309d125cfdeb7`) with no findings. H4 remains a
separate writer/sign-off increment.

### CV-01H4 — sign-off and atomic Apply

- exact plan/fingerprint recheck;
- one user-owned transaction and one Undo;
- failure restores everything;
- save/reopen and rerun idempotence evidence.

**H4 source complete 2026-07-24:** the existing commandless Civil Hub page
shows every proposed pit, pipe, label/arrow impact and the complete final pit
schedule before enabling one explicit approval checkbox and Apply action. Apply
re-reads the active drawing under one document lock, requires the exact signed
ticket, blocks REFEDIT/read-only/paper-space/headless/stale conditions, then
preflights every linked object, visible schedule cell, flow-arrow segment,
ProjectData record, outlet role and sign-off record before one transaction.

The transaction updates pit/pipe truth, labels, every intermediate IL, flow
arrows, the existing authoritative PITSCHEDULE, ProjectData, Designed outlet
roles and the H4 sign-off together. Grade authority is stored as exact inverts,
the existing CDLPD remains Fixed, reactors are suppressed for the caller-owned
write, and a post-commit cache failure can no longer be reported as a rollback.
One AutoCAD Undo is intended to restore the complete change.

The first formal audit failed exact candidate `5e828b3` because direct visible
schedule edits could be overwritten and an invalid arrow segment could be
silently skipped. Exact correction `4e5cd193a594fec683dcb79c3c984f1dce2569cc`
now reconciles every owned visible cell to current ProjectData/manual/XREF/
override truth before erase, requires exact writable arrow-block and
non-degenerate segment evidence. Re-audit then found that legacy write helpers
could still silently skip an unwritable linked IL/grade/existing arrow. Exact
follow-up `2612a2399ec1f6bf139cb694ab3a2b310bfe9863` opens every linked
annotation for write before the first change, rewrites MText/DBText/MLeader
through strict H4 paths and requires every existing arrow to update regardless
of the insert-arrow setting. Any refusal throws and rolls back the whole
transaction. Re-audit then found that the regex replacement for a new invert
could interpret the digits as a capture-group number and produce a label such
as `$199.500`. Exact correction
`d69a6a798263ae1dcb169add6cfd91cea8a8b42b` uses the matched prefix directly
and is guarded by positive, signed, unit-suffixed and non-invert cases.
239/239 focused NetworkRedesign tests pass on net48 and net10, and all three
Release lanes build with zero errors. Final formal correction re-audit passed
exact clean closure `90451c1e41ef2942d11294bb81d8e043f78a959f`
(tree `2accbfe7e9c5e53c9cb0b2abef291d8644b753f1`) with no findings. No AutoCAD,
package, deployment, ApplicationPlugins or DATA-01 action occurred.

## Required situations

| Situation | Expected |
|---|---|
| One top + one bottom control | Unique connected proposal |
| Several top controls | Every branch listed; Fixed top values preserved |
| Preliminary LPD moved opposite side | Reuse pit positions/routes; reverse only unique proven paths |
| Old LPD is Designed | Retire outlet role only after Apply |
| Old LPD is Fixed | Preserve it; disconnect before it or infeasible |
| Several outlets | Explicit branch assignment required |
| Loop/mesh | Unknown until user selects break/flow |
| Missing new connection | New route required; Apply disabled |
| Fixed levels conflict | No feasible solution; no unlock |
| Equal/missing levels | Unknown; no guessed direction |
| Rising main | Stored pump direction preserved |
| XREF network | Preview only; source DWG named |
| Pipe sizes | Unchanged; CV-02A hand-off only |
| Manual label offsets | Preserved unless explicitly included |
| Drawing changes after preview | Stale; recompute and re-sign |
| Cancel/Escape | No change and no sign-off record |
| Apply failure | Whole transaction aborts |
| Apply then Undo | Entire network returns in one Undo |
| Save/reopen/rerun | Same result; no duplicate objects or schedule |

## AutoCAD and release boundary

The same information, order, sign-off and safety apply in AutoCAD 2022–2024,
2025–2026 and 2027. The screen follows the approved Civil Hub resize, keyboard,
100/150/200% DPI and Legacy/Modern/Fluent presentation rules.

Approval authorises planning-to-code for H1–H4. It does not approve new
hydraulic/sizing rules, compliance claims, automatic site routing, XREF
write-back, deployment or DATA-01 access.

Tim approved the reviewed smart-Civil visual pack and instructed Codex to
build the complete agreed queue with independent audit on 2026-07-24. H1
remains calculation-only; that approval does not bypass the separate H2,
H3, H4, AutoCAD or deployment gates above.
