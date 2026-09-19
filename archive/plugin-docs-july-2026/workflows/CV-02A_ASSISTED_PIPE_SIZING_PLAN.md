# CV-02A — Assisted pipe sizing with end-user sign-off

**Status:** hardened plan and two-visual review package ready for Tim; not approved
**Depends on:** approved CV-02 behaviour, one corrected/versioned hydraulic
authority, CV-01G impact preview, CV-01H network controls, Civil Hub  
**Safe implementation:** A1–A3 advisory foundation only  
**Production Pass/Fail and Apply:** blocked  
**Deployment:** not authorised  
**DATA-01:** remains blocked

## Practical result

```text
Choose how staff are working
Drafting from designed plan / Designing from scratch
                    ↓
Review every input and its source
Flow · event · material/class · grade · levels · surface · rule version
                    ↓
Full-network advisory preview
Keep · Capacity-only upsize · Unknown · No feasible solution
                    ↓
Entire proposed schedule + labels shown before approval
                    ↓
After every production rule gate passes:
end-user sign-off → one Apply / one Undo
```

![Current single-pipe suggestion compared with full-network assisted sizing](../image/CV-02/cv-02a-assisted-pipe-sizing-mockup.png)

The left side is a workflow sketch of the current CDEDIT Q suggestion, not a
literal window copy. The right side is the proposed Civil Hub experience.

![Designed-plan and advisory-design modes plus runtime and accessibility states](../image/CV-02/cv-02a-assisted-pipe-sizing-states.png)

The second visual proves that both staff modes remain visibly different while
Legacy, Modern and Fluent retain the same information, decisions and safety
gate. All numbers shown in these planning visuals are synthetic examples
watermarked `NOT FOR DESIGN · NOT VERIFIED`.

## The two staff modes

| Mode | Staff provides | CE may do | CE must not do |
|---|---|---|---|
| **A — Drafting from a designed plan** | The named plan/revision plus documented diameter, material/class, direction/flow, grade and levels | Draft or compare the supplied design; show `Matches supplied design`, `Difference` or `Cannot verify`, with the exact source page/note when known | Redesign, substitute a preferred size, silently infer missing design intent or claim the engineer/council design is compliant |
| **B — Designing from scratch** | Catchments/flows, storm event, route, levels, material/class, surfaces and a named rule pack | Show advisory `Keep`, capacity-only `Upsize`, `Unknown` or `No feasible solution`, with every input and assumption | Show production Pass/Fail, call the result compliant, overwrite Fixed/designed values or apply a size while the production gates are closed |

No automatic downsizing is offered. If a smaller pipe appears possible, CE
keeps the drawn diameter and may show a non-actionable information note. A
future downsizing workflow would require separate explicit approval.

Mode is proposal-bound. Switching modes discards the old preview and requires a
fresh full-network review. Mode A never falls through to Mode B simply because
some plan evidence is missing; it returns `Cannot verify` and names the missing
document/value.

## What staff sees before any approval

The Civil Hub keeps the whole decision on one review page:

```text
Mode + source/rule banner
        ↓
Network map: branches, every LPD/outlet and protected boundaries
        ↓
Every pipe: supplied/current/proposed + inputs + assumptions + reason
        ↓
Downstream effects: labels, arrows, levels and every schedule row
        ↓
Per-item Keep / Accept / Reject / Manual value with reason
        ↓
Full-network reviewed proof → staff sign-off → future Apply gate
```

`Accept all reviewed suggestions` is unavailable until every pipe, unchanged
row, warning, Unknown and infeasible result has been visited in the unfiltered
review. It is never a shortcut around per-item Unknowns or a hidden
“changes-only” list.

For each row staff may:

- `Keep current/fixed` — no value change;
- `Accept suggestion` — only for a complete, non-stale and eligible proposal;
- `Reject suggestion` — retain the current value and record the rejection;
- `Set manually` — enter a value and mandatory plain-English reason; the value
  is recorded as `Designed` by default;
- `Set as Fixed control` — a separate explicit action requiring the authorised
  staff role, source/authority and reason; it is never implied by manual entry;
- `Locate` — show the pipe/pit in the drawing without changing it;
- `Review source/assumptions` — expand all inputs, exclusions and provenance.

The future sign-off record binds staff identity, UTC time, drawing/network
fingerprint, proposal hash, exact rule-source hash, mode, reviewed item set,
manual reasons, accept/reject choices and acknowledgements. It does not transfer
engineering responsibility to CE.

It also binds every external input used by the proposal: each host/source DWG
and XREF resolved identity/path, content fingerprint, load/read-only state and
the supplied-design document identity, revision and content hash. Retargeting,
replacing, unloading, reloading or changing any contributing source makes the
proposal stale.

## Why production sizing is blocked today

Tracked source and the engineering rulebook explicitly identify unresolved
production inputs:

- `MaterialVelocityLimits` contains placeholder maximum scour velocities;
- the current self-cleansing path uses full-bore velocity rather than a
  verified actual-design-flow/part-full result;
- council/project cover, location, pipe class and loading rules are incomplete;
- the DN90/DN100 grade/catalogue boundary requires reconciliation;
- capacity warning and project/council overrides need licensed-engineer
  confirmation and source/version records;
- approved-job regression validation requires a separately authorised DATA-01
  process, which remains blocked.

Until those gates pass, CV-02A may say `Advisory`, `Unknown` or
`No feasible solution`. It must not show a production `Pass`, claim compliance,
or enable size-changing Apply.

## Required inputs and provenance

Every pipe row records:

| Input | Required evidence |
|---|---|
| Design flow | L/s, storm/AEP, method, catchment/upstream total and source |
| Material | Exact controlled-catalogue material |
| Pipe class | Class/product where cover/loading or catalogue requires it |
| Length and route | Proven CE pipe geometry |
| Grade/levels | Physical-end identities plus Fixed/Designed provenance |
| Surface/cover | Governing surface source and location class |
| Rule pack | Project/council/office/standard source, approval and version |

There is no default flow, material, class, surface or generous unknown
velocity. Missing governing information propagates `Unknown`.

A manually locked downstream flow overrides upstream aggregation, while the
mismatch remains visible. Fixed levels always win. `No feasible solution` is
allowed only when every controlling rule/constraint is verified and
source-hashed, or when the contradiction follows solely from immutable Fixed
geometry. Otherwise the result is
`Unknown — feasibility cannot be established`. CE never moves survey/fixed
data or uses a placeholder rule to manufacture a result.

Mode A additionally requires the supplied-design authority: document title,
revision/date and, where available, sheet/detail/note reference. Missing or
contradictory plan evidence produces `Cannot verify`; CE does not “complete”
the engineer's design from its own advisory assumptions.

Mode B expands an assumptions drawer for every candidate:

- rainfall/intensity and storm/AEP source;
- catchment, runoff/flow method and upstream aggregation;
- material, pipe class and available diameter catalogue;
- route length, grade, roughness and full-bore capacity;
- actual-flow/part-full availability, cover surface and loading/location;
- safety margin, exclusions and the controlling project/council/office/standard
  rule source, approval state, version and content hash.

Unapproved example values exist only in synthetic tests and visuals. They are
always marked `NOT FOR DESIGN · NOT VERIFIED`.

## One hydraulic authority

CV-02A must not introduce another formula path.

1. The existing `PipeSizingSolver` becomes the one versioned, rule-aware sizing
   authority after its unsafe assumptions are corrected.
2. `PipeFlowSizingAdvisorService` remains a formatter/orchestrator only; it
   contains no hydraulic formula or default rule.
3. CDEDIT, CD, Inspector, CDRUNSOLVE, CDCALC and `NetworkDesignService` consume
   the same immutable request/result and exact rule-pack version.
4. Existing older calculations stay visibly `Legacy advisory` until rerun
   against an approved project rule pack.

The safe A1–A3 work can build the authority contract, fail-closed eligibility
gate, synthetic tests and read-only preview. It cannot install a production
numeric rule pack.

The A1/A2 boundary must also make the current unsafe defaults impossible to
misclassify as production evidence. A production-eligible request cannot call
`PipeSizingStandards.CreateDefault`, `MaterialVelocityLimits.BuildStandards` or
any adapter path that supplies the present 0.6 m/s, unknown/default 6.0 m/s,
600 mm cover or fallback grade/catalogue values. Those paths remain visibly
legacy/advisory until replaced by an explicit immutable rule pack carrying
source, jurisdiction, approval, version and content hash. Formatters and
AutoCAD adapters contain no formula or fallback value.

## Result model

Full-bore capacity and performance at actual design flow are separate rows.

| Result | Meaning before production gate |
|---|---|
| Keep | Current diameter is retained; supporting checks remain listed |
| Capacity-only upsize | Full-bore capacity indicates a larger DN; not a compliance result |
| Advisory | Calculation is useful but at least one governing rule is unverified |
| Unknown | A required input/rule/part-full result is unavailable |
| No feasible solution | Proven Fixed constraints cannot be reconciled |

Production `Pass`/`Fail` states do not exist unless the exact rule pack is
approved and every required calculation is verified. Unknown propagates
through network totals and never becomes a guessed result.

## Entire network and schedule before approval

The preview always includes:

- every pipe in the selected network, not only changed pipes;
- current and proposed DN, grade, levels, flow, capacity, design-flow
  performance, cover and controlling reason;
- every kept/upsized/Unknown/infeasible pipe;
- current and proposed pipe labels, arrows and full pit-schedule rows;
- CV-01G downstream impact and exact rule source/version;
- immutable drawing/network fingerprint and proposal hash.

The fingerprint covers the host drawing plus every contributing source DWG,
XREF and supplied-design document. It includes resolved identity/path, content
or revision hash and current load/read-only state; a source replacement,
retarget, unload/reload or state change invalidates the preview.

Staff may filter the view, but approval is unavailable unless the complete
unfiltered network and full proposed schedule were generated and reviewed.

The network map and table also name:

- every branch and merge;
- every LPD/outlet plus its explicit subnetwork assignment;
- Fixed controls and stop boundaries;
- rising mains/pumped/charged sections as `Excluded — dedicated workflow`,
  never gravity-sized;
- surcharge or capacity exceedance as an explicit failure/advisory state;
- loops, ambiguous direction, missing assignment and infeasible constraints as
  `Unknown` or `No feasible solution`;
- the exact downstream pipes, labels, arrows, pits and schedule rows affected
  by an accepted candidate.

One connected graph with two outlets cannot be divided or flow-allocated by
CV-02A. It reuses the approved CV-01H5 authority: staff must nominate graph-cut
boundaries and assign exactly one outlet to each resulting subnetwork. Each
subnetwork is calculated independently, while the combined review still shows
all outlets and every schedule row.

## Production release gates

All gates must pass before `CanApply` can ever be true:

1. Tim/licensed engineer approves every numeric rule and its source/version.
2. Actual-flow part-full calculations reproduce independently checked examples.
3. Material/class diameter catalogues and velocity rules are complete.
4. Cover/location/loading rules fail closed for every missing input.
5. CDEDIT, CDCALC, Inspector, CDRUNSOLVE and network design parity is exact.
6. Approved-job comparison passes under a separately authorised DATA-01
   process; DATA-01 is still blocked now.
7. Independent source/package audit passes on all three runtime lanes.
8. Tim approves the final full-network visual and AutoCAD behaviour.

Even after those gates, `CanApply` also requires:

- no `Unknown`, `Partial`, infeasible or stale selected result;
- no unverified/advisory governing rule for a selected change;
- every selected pipe still has the same identity, geometry, values and
  placement authority;
- CV-01G impact is complete;
- non-blocking advisories are individually acknowledged;
- staff tick the end-user sign-off.

The disabled action always has an adjacent plain-English reason, for example:
`Apply unavailable — 3 rules unverified, 1 pipe Unknown and the drawing changed
since this preview.` A tooltip repeats the same reason; colour is never the only
signal.

## Incremental build

### CV-02A1 — authority contract and eligibility gate

- immutable request/result/rule-provenance model;
- exact advisory/Unknown/No-feasible semantics;
- fail-closed `ProductionEligible` gate;
- synthetic inputs only, no WPF/Autodesk/DATA-01.

### CV-02A2 — one advisory calculation path

- audit/correct `PipeSizingSolver` behind explicit supplied rules;
- isolate and visibly reject placeholder/default production rules;
- part-full result remains Unknown until separately verified;
- adapters contain no formulas;
- identical-input parity tests for all current consumers.

### CV-02A3 — read-only Civil Hub preview

- implement the approved full-network/full-schedule visual;
- both staff modes, provenance and every blocker visible;
- per-item Keep/Accept/Reject/Manual-with-reason decisions are preview evidence
  only and cannot write the drawing;
- multiple-LPD assignments, excluded rising mains, downstream effects and
  supplied-plan differences remain visible;
- production Pass/Fail absent and Apply hard-disabled;
- no drawing writer.

### CV-02A4 — approved production rule pack

**Blocked:** licensed-engineer rule approval, source/version records and
DATA-01 approved-job validation are required first.

### CV-02A5 — atomic signed Apply

**Blocked by A4 and a separate final approval.** When eventually authorised:

- rebuild exact fingerprint immediately before Apply;
- one caller-owned transaction updates selected diameter geometry, linked data,
  owned labels/arrows and the complete schedule;
- any writer that cannot join blocks the whole increment;
- one AutoCAD Undo restores the complete before state;
- sign-off stores staff identity, UTC, proposal/rule hashes and acknowledgments.

## Scope and performance

- explicit selected connected network only; XREF networks are preview-only;
- maximum 500 pipes and the audited CV-01G 2,000-object, 4,000-link and
  5,000-presentation-record caps;
- the first record beyond a cap makes the preview `Partial`;
- no sizing during MOVE, grip drag, selection, zoom or passive Idle;
- immutable explicit-request calculation only;
- target: 1 second p95 for 500 synthetic pipes;
- a drawing change invalidates rather than merges a result.

## Required situations

| Situation | Expected now |
|---|---|
| Drafting from designed plan | Preserve supplied design; report only |
| Designing from scratch | Advisory Keep/Upsize preview |
| Missing flow/event/source | Unknown |
| Manual locked downstream flow | Preserve; show upstream mismatch |
| Unknown material/class | Unknown; no generous default |
| Placeholder scour rule | Advisory/Unknown; production blocked |
| Part-full self-cleansing unavailable | Unknown; no false Pass |
| Capacity below Q | Capacity-only upsize suggestion |
| Smaller pipe might carry Q | Keep current DN; information only |
| Fixed levels conflict independent of an unverified rule | No feasible solution |
| Feasibility depends on any unverified rule/input | Unknown — feasibility cannot be established |
| Surface unavailable | Cover Unknown |
| Several outlets | Explicit CV-01H branch assignment required |
| Two LPDs on separate networks | Show and size each assigned subnetwork independently; keep both in the combined schedule |
| One graph with two LPDs | Require explicit graph-cut/branch assignment; Unknown until complete |
| Rising main / pumped / charged pipe | Excluded and named; no gravity-size suggestion |
| Surcharge / full-bore capacity exceeded | Explicit controlling result; never hidden by an upsized downstream row |
| XREF network | Preview only; source DWG named and identity/path/content/load-state fingerprinted |
| Read-only or locked source | Preview/Locate only; no future Apply |
| Cap exceeded | Partial; Apply disabled |
| Drawing changes after preview | Stale; rebuild and re-sign |
| Mode A source revision changes | Stale; reload/review supplied design before comparison |
| Manual size | Designed by default; separate authorised `Set as Fixed control`; mandatory reason/source; downstream impact rebuilt |
| Accept all before every row reviewed | Disabled with an exact remaining-row reason |
| Cancel/Escape | No DBMOD/Undo/sign-off |
| Production gate incomplete | Apply absent/disabled |
| Future Apply failure | Whole transaction aborts |
| Future Apply then Undo | Exact before state returns |
| Save/reopen/rerun | No rounding drift; exact rule version retained |

## UI and release boundary

This is a Civil Hub page, not a new command or hydraulic engine. Existing
CDEDIT remains the familiar single-pipe doorway.

The page reuses the Hub 1216×698 first-open size, 900×600 minimum,
under-1100-pixel single-column reflow, 44-pixel targets, keyboard focus and
no-horizontal-scroll rule. Text plus shape identifies every status at
100/150/200% DPI across Legacy/Modern/Fluent presentation tiers.

| Tier | Presentation only | Behaviour that must remain identical |
|---|---|---|
| CE Legacy — AutoCAD 2022–2024 / net48 | Native WPF panels and simpler borders | Modes, rows, reasons, sources, decisions, review proof and blocked Apply |
| CE Modern — AutoCAD 2025–2026 / net8 | Approved modern controls/InfoBars after compatibility proof | Same |
| CE Fluent — AutoCAD 2027+ / net10 | Window-scoped Fluent styling after proof | Same |

Tab order follows mode → source/rules → network → pipe rows → schedule →
decisions → sign-off → Cancel/Apply. Enter activates the focused safe action;
Escape cancels without DBMOD, Undo or sign-off. Every row/action has a minimum
44-DIP target and visible focus. At 150/200% DPI or below 1100 px, the network,
inputs, pipe review and schedule stack vertically; tables virtualise or become
accessible row cards rather than clipping or creating horizontal scroll.

The same calculation/result ordering and blocked production gate apply in all
three runtime lanes. Presentation cannot alter engineering results.

Approval authorises A1–A3 advisory implementation only. It does not authorise
a production rule pack, Pass/Fail compliance, size-changing Apply, deployment
or DATA-01 access.

No implementation starts until Tim approves this plan and visual.
