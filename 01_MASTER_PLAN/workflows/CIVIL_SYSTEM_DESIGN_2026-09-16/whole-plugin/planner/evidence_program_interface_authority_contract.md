# Evidence-program end-user interface and authority contract

**Planning-only.** This is an interface/authority contract distilled from the approved evidence program. It does not authorise corpus extraction, archive/history inspection, provider access, a new command, a new job, implementation, build, test, deployment or AutoCAD operation. No project corpus was read for this record.

## Canonical approved decisions

- [EV-01 — Scope](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-01_SCOPE.md>)
- [EV-02 — Acceptance gates](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-02_ACCEPTANCE_GATES.md>)
- [EV-03 — Evidence model](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-03_EVIDENCE_MODEL.md>)
- [EV-04 — Drafting Pattern Atlas](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-04_PATTERN_ATLAS.md>)
- [EV-05 — Engineering Context Map](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-05_ENGINEERING_CONTEXT_MAP.md>)
- [EV-06 — Gold Benchmark](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-06_GOLD_BENCHMARK.md>)
- [EV-07 — Automation Register](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/EV-07_AUTOMATION_REGISTER.md>)
- [DATA-01 — Privacy and provider clearance](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/DATA-01_CORPUS_PRIVACY.md>)

The full cards, including their approved refinements, govern. This concise contract cannot weaken a gate, promote a suggestion, or turn a future approved scope into permission to execute it.

## What a drafter/engineer eventually sees

| Surface | Visible information | User action | It must never do |
|---|---|---|---|
| **Pattern Atlas** | Context, preferred placement, up to two valid alternatives, clearances, hard-conflict flag, evidence status and `Unknown` reason. | Accept preview, choose Next/Flip where valid, free-place manually, or cancel. | Establish a calculation, member size, grade, load path or engineering approval. |
| **Engineering Context Map** | Value + units, applicable object/area, provenance, source revision/date, decision status, conflict/staleness and upstream/downstream dependencies. | Inspect basis, propose a formal override with scope/reason, review downstream effects, explicitly approve a change. | Replace survey/calculation/rulebook authority, average conflicts, overwrite original source, silently recalculate approved design. |
| **Gold Benchmark** | Sanitised comparison case, CE result versus approved final, meaningful difference classification, relationship/engineering/presentation score and evidence gap. | Review an exception as defect, intentional engineering difference, valid drafting alternative, historical problem or `Unknown`. | Feed final issue output back as a hidden input, treat entity IDs/pixel equality as correctness, silently rewrite a benchmark. |
| **Automation Opportunity Register** | Manual workflow, affected routes, evidence/exception/risk, authority needed, expected drawing result, maturity and queue. | Keep manual, improve/merge/rebuild existing route, make QA-only, or submit a separate CE Tool card for Tim approval. | Add a command, edit a rule/Atlas, build/deploy, raise its own maturity or turn frequency into engineering authority. |

## One authority chain

```text
Approved external/project authority + deterministic calculation + engineer decision
                                      │
                                      ▼
                           Engineering Context Map
                                      │ factual basis/status/staleness
                                      ▼
                           Pattern Atlas presentation
                                      │ ranked, visible alternatives
                                      ▼
                         Explicit user confirmation / QA
```

The Context Map coordinates authorities but does not replace them. The Atlas is an approved, explainable drafting reference. A drawing pattern may influence presentation only. It cannot establish a `Fixed`, `Derived` or `Designed` engineering fact.

### Authority and override contract

1. Source precedence is: current approved external authority → current engineer-approved project decision → current deterministic calculation → verified project schedule/drawing → historical evidence → corpus suggestion.
2. Facts are visibly `Fixed`, `Derived`, `Designed`, `Advisory` or `Unknown`; decision status is independently `Proposed`, `Checked`, `Approved` or `Superseded`.
3. A manual/pinned drafting placement outranks Atlas soft preference/default. If it creates a hard clash, retain it but show a QA finding; do not snap it back or silently accept the clash.
4. A governed engineering override shows existing authority, proposed value/scope/reason and downstream effect preview, then records explicit approval. Original provenance remains visible.
5. **Unadopted candidate evidence** marks the basis **Needs review** while recorded calculations remain matched to their pinned/governing inputs. Only an **adopted, confirmed governing-input change** makes consuming results **Numerically out of date**. It may prepare a review/recalculation preview, but does not quietly change approved values, drawings or issue state.

## Evidence life cycle and gates

| Door | Required condition | Result if it fails |
|---|---|---|
| **DATA-01 Gate 0** | Synthetic/de-identified records, translated local coordinates, stripped metadata, cleared/restricted history, warning-positive review samples and per-provider permission. | Restricted. Raw DWG/PDF/survey/image remains local and no provider/AI receives it. |
| **Evidence pairing** | Verified project/revision/input-final relationship; uncertain pair excluded. | Limited evidence or `Unknown`; no guessed pairing/default. |
| **Atlas default** | Context-specific pattern with supporting independent projects and EV-02 threshold. | Advisory/preview/manual alternative only. |
| **Engineering proposal** | Deterministic authority, complete provenance, conflict/Unknown handling and held-out proof. | Stay Advisory/Preview/Unknown; no engineering Apply. |
| **Benchmark promotion** | Held-out semantic comparison passes relationship, geometry, presentation, provenance, lifecycle and performance gates. | Bounded gap report; affected context remains Preview-only without delaying unrelated passing work. |
| **Automation maturity** | Separate approved CE Tool card plus evidence-gate result. | Remain A0 Observe, A1 Suggest or A2 Preview; no A3 Apply/A4 coordinated draft. |

EV-02 defines the future bounded benchmark program (at least 300 verified sets and 60 untouched complete-project holdouts, with separate relationship, placement, confidence and provenance gates). Those numbers are acceptance criteria for a separately authorised program, not a request to collect or process records now.

## Dependency contract

| Producer | Consumer | Safe handoff |
|---|---|---|
| Sanitised scene/evidence record | Atlas / benchmark | Stable record identity, classification, provenance, confidence and permitted-use status; no raw client payload. |
| Rulebook, approved calculation, engineer decision | Context Map | Value, units, revision, scope, approval and supersession. Conflicts remain plural/visible. |
| Context Map | Atlas / command preview | Touched-object facts and constraints only; no whole-project rescan, remote AI dependency or unrelated recalculation during cursor movement. |
| Atlas | Drawing preview | Ranked placements, hard constraints, explanation and evidence status. Accepted preview must match final result. |
| Benchmark / recurring correction | Opportunity Register | Evidence strength, exceptions, performance and risk; no automatic rule/tool mutation. |
| Opportunity Register | CE Tool card | A bounded workflow specification: selection, prompts, context, preview, alternatives, lifecycle, Escape, one Undo and acceptance evidence. |

## Representative future acceptance (synthetic or DATA-01-cleared only)

1. A manual beam-label move survives reopen and outranks Atlas preference; an overlap remains an explicit QA flag.
2. Two incompatible source values appear together in the Context Map; neither becomes zero/default; a scoped override preserves both original source and reason.
3. A new unadopted candidate marks the basis Needs review while the approved drawing/result still matches recorded governing inputs; deliberately adopting that governing input makes dependent schedule/detail/issue basis Numerically out of date, without silent replacement.
4. A benchmark case has a visually different but Atlas-approved layout with correct ownership and engineering meaning; classify it as a valid alternative rather than a defect.
5. A recurring drafting opportunity remains A1/A2 until its separate Tool card, gate evidence and Tim approval exist.

## Current status and ownership

| Fact | Status |
|---|---|
| EV-01 through EV-07 planning decisions | Approved planning records; no implementation/runtime acceptance inferred. |
| DATA-01 | **Blocked at Gate 0**; no raw corpus/history/provider access is implied. |
| Atlas, Context Map, Benchmark, Opportunity Register | Future durable outputs of the evidence program; no artefact or interactive surface is claimed built. |
| This planner | Owns this interface record only. Foundation/shared implementation, evidence execution and privacy operations remain with their designated owners. |


