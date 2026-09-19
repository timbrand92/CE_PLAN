# Civil system planning — source authority and conflicts

**Planning-only annex.** Created 16 September 2026. This is a map of what can direct the next Civil design review. It does not claim that a command, window or drawing output is Built, Tested, Installed or Tim-accepted.

## Read this first

| When deciding | Use this first | Why it matters on a drawing |
|---|---|---|
| A current Civil workflow or window | Tim's latest dated approval in the 15–16 September Design/Windows handover and Test Day record | It stops an old mock-up bringing back a compulsory wizard, a small preview, or command-line design questions. |
| Engineering number or council requirement | Approved council/engineering contract and Settings record with its source | A figure printed beside an OSD pit must say where it came from and must not be a remembered office default. |
| Existing retained command | Current documented behaviour, then a Tim workflow card before change | A working drafter route must be kept until its replacement passes an AutoCAD test. |
| What happens in AutoCAD | Tim's observed Test Day result or an AutoCAD acceptance record | Source reading and a green build cannot prove the drawing behaves correctly. |

## Current decisions that direct this annex

| Topic | Current direction | Authority / date | State |
|---|---|---|---|
| Whole-job design | `CDDESIGN` supports an empty drawing, design development and revisions/issue. It guides the next useful action without an artificial stage selector or compulsory wizard. | Civil Windows planning handover, approved continuation, 16 Sep | Behaviour approved; no integrated-product claim. |
| Project documents | Recognise the project folder and discover across the job folders automatically. The visible control is **Select / change documents**. An ambiguous project stays unresolved. | Civil Windows handover, 16 Sep | Behaviour approved; recovery interaction still needs review. |
| Design overview | Keep **Discharge**, **Design criteria**, **Catchments**, a job overview, visible actions and a large relevant preview. | Civil Windows handover, 15–16 Sep | Behaviour approved. |
| Evidence first | Extract/measure/propose, then the engineer confirms governing values before calculation or drawing impact. Newer documents trigger comparison, not automatic adoption. | Civil Windows handover, 16 Sep | Behaviour approved. |
| Areas | Site boundary, surface/imperviousness and hydraulic catchment are separate. Existing catchment plans are considered before redraw. No automatic equal DP split or unclassified-pervious remainder. | Civil Windows handover, 15–16 Sep | Behaviour approved. |
| Preview | Review source pages while judging evidence; show the actual drawing while judging areas/network. No invented completed network on an empty job. | Civil Windows handover; Test Day §6b–d, 16 Sep | Behaviour approved. |
| Drainage Items | DP/IO/GIO/FW/TG/AGI/OF main choices; More contains the approved FO, Strip Drain, custom source, Raingarden and LPD choices. Existing item commands preselect the matching item. Additional source-inventoried item types are not approved additions and require future workflow review. | Civil Windows handover, 15 Sep | Behaviour approved. Do not reopen in this planning block. |
| Water Tank | Plan last. `CDWT` window ownership is temporarily Claude-only, per Tim's 16 Sep override. | Test Day §4a; V3 §11 G | Scope/ownership direction only; not reallocated here. |
| Calculations | One computed record should feed computations sheet, OSD criteria block and orifice detail. Designed storage and provided/drawn storage stay separate. | D+F plan, §§3–4 | Proposed design direction; calculations sheet presentation has current Test Day failures. |
| Rainfall | Hold IFD coefficient block per job, with place/source. Do not quietly use the shipped Melbourne curve for every job. | IFD rainfall record, 15 Sep | Behaviour approved; obtaining new fitted blocks remains Unknown. |
| Native protections | Never silently alter locked, Xref, REFEDIT or foreign objects. Show read-only/choice state and keep inspection possible. | Master / drawing-intelligence brief | Binding protection. |

## Conflict register — resolve by the listed rule

| ID | Older or conflicting record | Current ruling | Planning consequence |
|---|---|---|---|
| C-01 | Earlier CDDESIGN idea required a user to link a project folder. | Project folder recognition/discovery is automatic; user can only Select/change loaded documents. | Do not design a first-use folder-link screen. Keep an explicit unresolved-project recovery card. |
| C-02 | Earlier CDDESIGN was a one-time setup form and could presume an existing network. | It is a whole-job overview from blank drawing through revision/issue; no invented network. | Status/preview must derive from actual records and selected evidence. |
| C-03 | Older UI material used fixed stages, heavier rails and/or source-style controls. | Contextual next action, minimal tabs/no main scrolling, visible actions, large preview. | Treat older layouts as historic reference only, not a final window specification. |
| C-04 | Blue Factor was initially an uninspected report family. | Its revision/status/page evidence and image-only-report failure mode are now known. | Empty text extraction means “needs visual/readable extraction”, never “no report content”. |
| C-05 | Historical source documents can disagree in date, quantity and intended treatment. | Newer is discovery evidence only; compare document-internal date/revision/status/scope and require a governing choice. | Store both values and their evidence; do not overwrite accepted/manual values. |
| C-06 | Architectural site coverage, garden, permeability and driveway labels may look arithmetically related. | They are not automatically hydraulic areas. | Surface/classification/flow allocation must be separately confirmed; no remainder defaults. |
| C-07 | Earlier drainage-item wording included a “Roof Drain” type while the approved window calls it DP. | DP is the reviewed downpipe path; older CDSOURCE category must be reconciled deliberately. | Do not silently delete/rename old drawing identities. |
| C-08 | Ruling B normally assigns windows to Codex. | Tim: “build the CDWT window yourself, ignore ruling B for now.” This is CDWT-only. | Water Tank planning must preserve Claude temporary window ownership. No broader reassignment. |
| C-09 | Rulebook wording can be read as a fixed pipe-obvert TWL rule. | Tim ruled a higher element such as trench grate may govern; CE presents candidates for confirmation. Floor level does not set TWL. | Do not propose automatic TWL selection or use floor level as the TWL source. |
| C-10 | Existing tool uses one Melbourne IFD curve. | Coefficients are held per job; silent Melbourne fallback is prohibited. | Design can accept a user-pasted current block, but creation/fit of a new block remains an open engineering path. |
| C-11 | Master plan status tables and historic deployment records contain stale/live contradictions. | This annex is planning-only and does not repeat live status. | Never infer installed or working state from the plan labels. |
| C-12 | Old calculation and drawing outputs can be useful evidence. | They must not be imported as the new calculation's truth or teach rules automatically. | Show them as comparison evidence only. |
| C-13 | Ruling B normally assigns the CD/PIT windows to Codex. | Test Day §6g temporarily assigns CD/PIT polish to Claude. | This planner must not allocate, redesign or touch the active CD/PIT work. |
| C-14 | Existing project-path helper falls back to the current directory and deliberately excludes folders such as Architectural, Survey and Xref from sheet scans. | CDDESIGN needs automatic recognition plus discovery across **all relevant job folders**; ambiguous recognition remains unresolved. | Do not reuse directory fallback as proof of project identity or inherit sheet-scan exclusions for design-report discovery. |
| C-15 | Council records can be read as a generic values/default problem. | Council integration establishes three modes: Published, Council-issued and Compute-to-ARR, with source/provenance per rule. Nothing in that plan is built. | Criteria UI must model the mode, show values/provenance and never turn a free-text warning/default into an engineered check. |

## Source boundaries and confidence

| Source set | Safe use in this planning | Do not claim |
|---|---|---|
| `V3_0_PLAN.md` §11 | Full A–M Civil coverage spine and staged delivery context | Current installed behaviour or AutoCAD proof. |
| `V3_CONSOLIDATED_RECORD_2026-09-15.md` | Decision history, command/window register and known supersessions | That its live/deploy register is current. It explicitly records stale-register faults. |
| `CIVIL_WINDOWS_PLANNING_2026-09-15_DRAINAGE_ITEMS_DESIGN.md` | Latest window/design direction and bounded historical-evidence lessons | A production contract or live implementation. It is planning authority. |
| `AREA_D_F_CATCHMENTS_CDCALC_OSD_PLAN.md` | Calculation chain, provenance gate and computation-output relationship | A settled choice on the remaining listed questions. |
| `ENGINEERING_RULEBOOK.md` | Marked office/council rules and unresolved assumptions | That every draft number is approved; use dated Tim corrections where they conflict. |
| `02_COUNCIL_RULES/COUNCIL_RULES_V3_INTEGRATION.md` + `OPEN_QUESTIONS.md` | Council modes, current field gaps, provenance model and genuine unanswered engineering choices | That the required model/checks already exist. The integration record explicitly says nothing there is built. |
| Bounded source reconciliation supplied by integration owner, 16 Sep | Existing `DesignInputs` carries an optional outfall invert/source geometry; Design Package models have branches/results/details/long section/calculation/warning/refusal concepts; Design Impact models have stable pit/pipe identity, directed connections, presentation and Complete/Partial/Unknown/OutOfDate states. | That all source/catchment/revision dependencies are persisted or integrated. This was not a whole-repository absence proof. |
| `TEST_DAY_RESULTS_2026-09-16.md` | Tim's real drawing observations, ownership override and newer presentation rulings | That untested areas passed. |
| Scoped historical trial | Evidence-model limits: documents/measurements are proposals, not adopted design | Any client/job detail. This annex deliberately records none. |

## Evidence root needs from the integration owner

The following need a source/status reconciliation outside this annex before a behaviour contract is written:

1. Project recognition may safely use the bounded path marker as a *candidate only*. The current helper's fallback directory and its exclusions are not a recognised-project result. The unresolved/ambiguous-project recovery interaction remains unapproved.
2. Existing Design Package / Impact concepts should be inspected and reused before new records are proposed: DesignInputs (including optional outfall/source geometry), branches/results/details/long section/calculation/warnings/refusals, stable pit/pipe identities, directed connections, presentation and Complete/Partial/Unknown/OutOfDate state. Whether sheet/criteria/detail currently share a stable calculation-result identity remains to be checked.
3. The authoritative council-rule integration field list and unresolved decision basis in `02_COUNCIL_RULES/COUNCIL_RULES_V3_INTEGRATION.md` §6 and `OPEN_QUESTIONS.md`, so this planner does not invent engineering fields.
4. Completed bounded retained-command inventory: [retained_command_inventory.md](retained_command_inventory.md) records surface drains, slab, grades, pumps, soakage, profiles, schedules, repair and help. Its source observation does not settle runtime behaviour, recovery support or AutoCAD acceptance.

---

## Technical appendix — terms held apart

`Source evidence` is an identified document/page or drawing measurement. `Proposal` is a value CE offers for review. `Governing value` is the confirmed value used by the design. `Calculated result` is derived from the governing inputs. `Provided value` is the capacity actually represented by the drawing. `Display wording` is plan presentation only. These must have distinct identities, provenance and revision history.

**Planning status:** proposed / awaiting review.  
**Built:** not assessed.  
**Tested:** no AutoCAD test run by this planning annex.  
**Installed:** not assessed.  
**Tim-accepted:** no.
