# Structural — consolidated delivery plan

## Authority and outcome

**Later approved work:** Tim authorised one shared beam-feedback engine for commands 1/2/4/5, now locally verified in [draft PR #73](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/73), pending reconciliation/review/AutoCAD acceptance. Tim then selected a shared native ObjectARX core across Structural, retaining working settings/schedules/QA. Follow [ST-NATIVE-01](workflows/ST-NATIVE-01_SHARED_STRUCTURAL_CORE.md) for the surveyed reuse, all-area coverage and staged migration. The earlier consolidation-only authority below is historical, not a stop on these specifically approved tasks.

Tim authorised consolidation and existing-work reconciliation on 14 September. This completes those two planning steps; it does not dispatch implementation or deploy. Exact user decisions remain in [drawing journey](workflows/STRUCTURAL_DRAWING_JOURNEY_2026-09-14.md); original [cards](CARDS/INDEX.md) retain their verbatim history. Later explicit journey decisions refine earlier behaviour, especially independent editing. Resolve concrete conflicts in the owning card before coding.

Product outcome: CE assists the complete Structural drafting session while preserving normal AutoCAD editing freedom. One product, six coordinated areas, one release authority. No separate plugins combined at the end.

## The user's complete journey

| Stage | Approved experience | Owner / source |
|---|---|---|
| Prepare backgrounds | Start from office templates; clean architect DWGs; align levels using building/grid/boundary references; maintain named under/over uses, clipping and colours. Confirm alignment on revised backgrounds. | Drafting, ST-05; journey setup/Xref batches |
| Prepare project | Folder-derived job number/address; editable people fields; optional client; reuse LU layer creation; sheets evolve throughout the job. Context distinguishes project host from background editing. | Drafting + shared Job Coordination |
| Understand the building | Relate architectural plans/elevations/sections, walls/openings/voids/setdowns/levels; retain source and uncertainty; show candidate versus engineer-confirmed support/load paths. | One shared interpretation owner with Drawing Intelligence; new bounded work |
| Propose drafting | Confirm input versions and plan viewport/area; show one whole-plan proposal with geometry, marks, labels, hatches and schedule. Preserve existing work; explicit replacement preview. | Framing/Foundations + Drafting |
| Review and accept | Compare source markup beside proposal; accept clear portions and adjust others; unknowns stay visible. One Undo for accepted proposal. | Shared preview/commit behaviour; owning workflow cards |
| Edit freely | Native AutoCAD edits, contextual panels and Civil-like grips. Edit together / Edit this only visible beside grips/right-click, for current operation only. Independent edits change no related objects, retain relationships unless disconnected, and leave quiet QA discrepancies. | Framing/Foundations/Drafting; single shared edit authority |
| Add details | DWG and PDF catalogue; thumbnails/plain search; separate details from multi-detail files; source-traced editable project copies; review on use; approved standards distinct from unreviewed examples. Library changes offered for comparison. Preserve existing linked-detail use until reconciled. | Sections & Details, ST-08 |
| Coordinate schedules | Confirmed coordinated edits update member/footing schedules with review highlights; independent edits do not silently propagate. Shared marks require a scope decision on size change. | Schedules & Sheets, ST-07 |
| Check against instructions | Highlight Missing / Different / Unable to verify against markup; no guessing or silent omission. Optional low-entry tracking. Remember scoped decisions, recheck changed evidence, Tim approves broader learning. | Job Coordination + semantic owners |
| Revise and issue | Shared sheet/register list; suggest affected sheets; unchanged sheets retain dates/revisions. Flexible P/T/A sequences. Latest-change clouds after A. Preview QA/revisions; combined PDF, full set or selected subset; editable filename/folder; safe retry and exact issue history. | Existing shared Project-to-Issue authority, ST-07/ST-09 |

## Reuse reconciliation — evidence, not a new acceptance audit

This pass reuses the [135-item evidence review](STRUCTURAL_PROGRESS_2026-09-13.md), original cards and RDY03–06 work records rather than repeating their investigations. Main HEAD remains `d017d506186729afbac9b97a050cc91c3ce8cfb8`, dirty with other work preserved. Isolated Structural HEAD remains `5fcf77abc97e1aec797cfe7e68f5f0be01c4c1bc`. Prior integration evidence is pinned to `0ea4e9bfdc4cb2d63ab9149b676759ffd752e05c`; this is not a fresh claim about current integration HEAD. Refresh exact source at dispatch.

| Area | Keep / modify | New or unproven completion work |
|---|---|---|
| Framing | Existing beam/support placement and label engines; explicit links; isolated record projector, captured-link bridge and read-only native adapter. | Persistent-ID storage/adoption and invocation; operation-scoped edits/grips; reliable relationship lifecycle; schedule connection; whole-plan proposal and source-markup context. |
| Foundations | FoundationService, foundation size workspace, strip/raft/bored-pier/rebar geometry; retain aliases per ST-06. | Reviewed hosts/compound ownership, unknown provenance, lifecycle/grips, slab-change preview, footing schedule integration. Preserve working geometry; modify orchestration. |
| Drafting | LU layer creation (Tim-confirmed), existing dimension/text/hatch/section-mark and native Xref services. | Complete setup experience, source-level/host-use model, preserved overrides/clips, common contextual edits and architecture interpretation. |
| Sections & Details | SBEAM, RC/column geometry and catalogue work; existing source-linked remedial detail practice observed in Bramerton. | Searchable DWG/PDF library, separate-detail boundaries, review status, source/version/project-copy lifecycle. Reconcile linked versus copied usage. Existing placeholder command registration is not functionality. |
| Schedules & Sheets | Existing reviewed shared Sheets/Issue producer and Manager consumer, publishing/finalisation/history services. | Structural semantic records into schedules/QA, independence handling, changed-sheet decisions, exact revised issue workflow and native acceptance. Do not build another publishing engine. |
| Job Coordination | Existing project/checklist/time/ledger ownership. | Markup-to-drawing comparison, optional instruction tracking, scoped remembered decisions and approval-controlled office preferences. No duplicate timer or project authority. |

RDY06: 27 focused offline checks per net48/net10 lane, native project compiled; no native execution, writer or command activation. Earlier source evidence proves useful parts, not the full connected workflow. The evidence board credits only ST7-14 as complete at its managed-source scope; all other partial/unverified status remains intact.

## Shared contracts to reconcile before implementation

| Shared responsibility | Must agree |
|---|---|
| Object identity and relationships | Permanent IDs/adoption; geometry versus interpretation; ownership; explicit connections; COPY/Undo/reopen. Beam-only COPY keeps copied label and no support connections. |
| Editing | Per-command starting behaviour; visible operation-scoped independent/coordinated choice; no auto-catch-up after independent edits; exact changed-object preview; protection and rollback. |
| Source and view context | Source versions, views/levels, host Xref occurrences/transforms/clips, evidence links and staleness. Never identify levels only from colour or coincident geometry. |
| Proposal and QA | Proposed/confirmed/unknown distinctions; whole-plan preview with partial acceptance; instruction coverage; review versus issue status. |
| Schedule and issue | One member/footing data path and one sheet/register authority; independent edits versus automatic updates; mixed sheet revisions and safe finalisation. |
| Detail catalogue | Source detail boundaries, approval/version metadata, project copies versus linked details; no implicit engineering suitability. |

## Delivery order and checks

| Chunk | Purpose / dependency | Completion check | Status / time confidence |
|---|---|---|---|
| D0 Consolidation + reuse map | Capture approved journey and avoid duplicate rebuilds. | Journey mapped to six areas, reuse/gaps and source limits explicit. | Complete as documentation; no product credit. |
| D1 First-slice card + shared contract | Resolve identity/adoption/invocation and per-command edit defaults; refresh exact source ownership. | Concrete reviewed workflow, files/base/owner, protections, Cancel/Undo/reopen and test plan. | Next; dependent planning, sequential. Duration requires source refresh. |
| D2 Connected framing slice | Two beams sharing a support with owned labels, contextual edits, independent/coordinated grip operations and one member schedule. Depends D1. | Automated lifecycle checks and one consolidated Tim AutoCAD exercise pass. | Proposed first usable slice; implementation duration unestimated. |
| D3 Foundations + details | Extend accepted shared contracts; catalogue first, review on use; foundation ownership/schedules. | Each bounded card integrated and accepted; no duplicated shared engines. | Can split only after dependencies settle. |
| D4 Architecture + whole-plan assistance | Bounded source interpretation, markup matching and proposal assembly using accepted drawing/edit paths. Define schemas/examples during D1; do not postpone all interpretation design until the end. | Representative cross-view cases, missed/false/unknown accounting, source tracing, safe partial acceptance. | Major new capability; no accuracy/date promise. |
| D5 QA + complete issue workflow | Connect instruction coverage, remembered decisions and established publishing authority. | Mixed revisions, subset/full PDF, nonprinting review overlays, retry/history and native acceptance. | Existing issue engine reused; broader checks dependent. |
| D6 Colleague qualification | Freeze exact integrated candidate and validate packaging/support. | Release gates below plus Tim/colleague acceptance. | Not yet ready. |

First-slice boundaries: D2 does not claim architectural inference, complete markup automation, detail library or whole-product release. The full approved vision remains in D3–D5. Existing tools remain available; incremental delivery must not remove working paths before replacements pass.

## Reviewable first Structural colleague package checklist

Proposed scope is the D2 framing slice plus existing supported host/installer, not the entire newly expanded product. This checklist is a proposal for package scope, not an already approved denominator or an effort-weighted percentage.

| Gate | Required evidence | Current status |
|---|---|---|
| PK1 Scope and source | Approved release inclusion, exact commits/dependencies and supported AutoCAD versions. | Pending |
| PK2 Connected framing | Beam/support/label/schedule path and mode-specific behaviour integrated. | Pending |
| PK3 Editing lifecycle | COPY rules, explicit connection, independent edits, Undo/Cancel/save-reopen/protection. | Pending |
| PK4 Drawing acceptance | Tim completes representative consolidated scenario on exact build. | Pending |
| PK5 Regression/review | Targeted checks and required independent manual Claude review on exact range. | Pending |
| PK6 Package integrity | Official packaging, version/hash/runtime/assets and approved installation process. | Pending |
| PK7 Colleague operation | Install/open/edit/save/reopen on colleague machine; actionable support/recovery information. | Pending |
| PK8 Release record | Known limits, release notes, exact accepted package and rollback authority recorded. | Pending |

Report gates individually until scope/measurement is accepted. Do not convert eight unequally sized gates into an invented percentage. No deployment until Tim's explicit AutoCAD-closed deployment instruction.

## Progress and forecast

Existing fixed checklist remains Framing 0/30 (29 partial), Foundations 0/15 (13 partial), Drafting 0/45 (37 partial), Details 0/15 (8 partial), Sheets 1/15 (12 partial), Coordination 0/15 (11 partial). Total 1/135 = 0.74%, 110 partial, 24 unverified. These are verified minimums for earlier scope, not completion of expanded journey requirements. New scope needs a reconciled item register before a new denominator is claimed. Colleague package percentage remains unmeasured.

Consolidation forecast: about 10–15 minutes sequential, zero workers; fan-out offers little saving for interdependent planning documents. No added worker usage. Whole-program sequential/parallel durations remain unestimated until D1 produces bounded work orders; inventing them now would conceal recognition and native integration uncertainty. Normally at most two independent workers later, explicit model/reasoning per task and fresh usage check before dispatch.

## Remaining decisions and next action

No broad questionnaire needed. Next prepare D1 using accepted answers and existing code: pin current source, nominate shared identity owner, reconcile operation starting modes and independent-edit schedule consequences, map card amendments, and prepare a concrete two-beam/support/label/schedule acceptance example. Ask only for genuinely missing interaction or engineering intent. Whole-plan extraction boundaries, linked-detail coexistence and exact learning/issue finalisation mechanics remain future owning-card details.

Verification for this planning pass: original card evidence and RDY records consulted; six areas and source limits mapped; all journey themes included; no source code, build, deployment, user drawing or existing source approvals changed. Manual AutoCAD tests are not needed for this documentation; D2 consolidates later tests.
