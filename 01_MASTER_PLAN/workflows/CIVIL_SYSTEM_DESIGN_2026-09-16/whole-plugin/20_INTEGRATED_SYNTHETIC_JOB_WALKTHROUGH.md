# Integrated job walkthrough — planning stress check

FOR TIM

This follows one fictional job through both disciplines and a later revision. It checks whether the planned sequence makes sense. It is not an AutoCAD test and uses no client drawing.

## Starting evidence

Fictional job with one Civil drawing, two Structural layouts and a shared sheet register. Survey/background/report revision A and engineer markup A exist. A roof outline, two discharge outlets, several members and one manually positioned label are known. All example identities and values below are synthetic; no engineering size, level, rule or area is being approved.

## Walkthrough and expected state

| Step | User action | Automatic assistance | Confirmation / override | Durable result and cancellation boundary |
|---|---|---|---|---|
| 1 | Open saved Civil drawing | Recognise its project and prior records | Show unresolved identity if ambiguous; exceptional recovery interaction remains unreviewed | No write to a guessed job, no new project or folder created merely by opening; no folder-link wizard. See [pending recovery decision](../planner/decisions_for_tim.md), row9 |
| 2 | Open CDDESIGN; Select/change documents | Discover candidates and show relevant document/page/revision evidence | Select governing report; defer conflict | Discovery list is not adopted design; Cancel review leaves old basis |
| 3 | Review survey and background | Identify units/transform and suspect point | Confirm alignment; exclude suspect point | Retained source fingerprint/transform; no zero-level substitution |
| 4 | Select roof/site geometry | Suggest site extent, surface class and catchment separately | Draw/adjust boundary or retain manual area | Geometry identity and manual basis retained; unclassified surface not assumed pervious |
| 5 | Allocate one roof to two DPs | Check portions against shared area and display destinations | Unequal allocation allowed; each DP one destination | No duplicated full roof on both DPs; no cross-outlet basis mixing |
| 6 | Draw pipe and insert drainage items | Prefill proven ends, levels and annotation preview | Explicit connection/branch/outlet; Fixed values protected | Atomic accepted drawing operation; cancelled proposal unchanged |
| 7 | Review calculation | Same versioned engine across edit/calculation/Inspector | Accept governing inputs, retain locked value | Capacity and design-flow checks separate; missing authority not Pass |
| 8 | Prepare Structural framing from markup | Recognise relevant view/member instructions | Unknown member size stays unresolved; confirm clear instructions | No invented size/load path; source and item identity retained |
| 9 | Change one confirmed member | Show operation scope and affected linked views | Edit this only | Member changes, related schedule/label stays; discrepancy for QA, no automatic catch-up |
| 10 | Move its label by hand | Keep actual position as presentation override | User chooses location | Subsequent coordinated size change preserves position; no Atlas snap-back |
| 11 | Insert standard detail | Preview actual asset/version/variables | Confirm suitability; fill project fields | Editable project copy; master unchanged; placeholders remain visible findings |
| 12 | Create pit and Structural schedules | Use respective governing records and source-qualified rows | Review differences; schedule-only override has reason | Current insertion point retained on update; copy of schedule not silently authoritative |
| 13 | Review QA | Current evidence, stale outputs, scoped findings | Resolve or deliberately record departure | Fail/Unknown not falsified; only relevant source change reopens departure |
| 14 | Prepare issue A | Suggest affected sheets, exact package list | Select PDF membership separately from revision changes | All selected expected output verified before final history; no actual publishing in this walkthrough |
| 15 | Cancel plotting after preparation | Retain reviewed intent and truthful incomplete state | Retry same operation after resolving cause | No extra revision increment; no complete issue claim from partial PDF |
| 16 | Receive background/report B | Detect changed evidence and show affected area/member candidates | Retain pinned Civil area; defer adoption | Needs review only; existing calculation basis numerically unchanged |
| 17 | Adopt revised Civil area | Preview consequences for allocated DPs/outlets/calculation | Confirm exact changed scope | Dependent calculations/schedules/sections become out of date; unrelated Structural values stay |
| 18 | Review engineer markup B | Show changed instruction for one member | Accept that instruction with chosen edit scope | Reopen relevant old exception; unrelated member decisions retained |
| 19 | Prepare issue B | Suggest changed sheets and current package | Include unchanged sheets while revising only changed sheets | Unchanged dates/revisions retained; previous issued PDF remains history |
| 20 | Service or library unavailable | Show exact unavailable source, retain last evidence | Continue permitted manual drafting | No similar-name substitution, no hidden upload/provider switch or fabricated successful save |

## Cross-module contract conclusions

1. **Job identity is shared; engineering authority is scoped.** One project record does not mean Civil/Structural share one calculation or that two outlets share governing conditions.
2. **Evidence adoption is a separate operation.** Step16 does not trigger step17. This distinction must appear in every dependent view and any evidence-program suggestion.
3. **Manual control survives automatic assistance.** DP allocation, label placement, pinned area and independent member edit persist with their appropriate scope and QA consequences.
4. **Issue review consumes current evidence; it cannot manufacture it.** A missing workbook, unverified schedule or absent PDF stays visible. User disposition of engineering findings is distinct from mechanically complete output.
5. **Cancel has an operation boundary.** It cancels pending review/placement, not already completed file copying, archiving or earlier accepted drawing changes. Settings save, drawing Undo and file recovery are distinct.

## Seams that still need implementation-owner qualification

| Seam | Concrete outstanding evidence |
|---|---|
| Job saved or copied outside recognised project | Exact existing recognition/identity behaviour and reviewed exceptional recovery; no silent adoption of another job |
| Per-outlet allocation consumed by calculations | Exact stable roof/DP/outlet identity and allocation conservation across edits/copy/reopen |
| Revision evidence to affected outputs | Actual dependency stamps and relevant-change matching, not generic all-project stale flag |
| Independent Structural edit into schedule review | Exact consumer mismatch and later explicit coordinated scope; no automatic catch-up |
| Combined issue across multiple DWGs | Existing owner is combined-per-DWG; full selected-set combined PDF remains a qualified implementation gap |
| Unchanged included sheet date | Existing shared owner stamps included dates; approved revised-versus-included distinction remains an owner gap |
| Settings precision | Root11 consumer check shows calculated decimals affects values; actual units/common rounding need exact owner qualification |
| Cross-DWG continuation | Paired publication/recovery and per-DWG Undo, not one global Undo; J6/J7 integration/live evidence separate |

These gaps do not require Tim to repeat settled decisions. They require evidence and bounded implementation contracts from existing owners before building. This overnight records them and does not modify their work.

## Review result

The planned sequence supports start, ongoing review and later issue/revision without a compulsory wizard. The table exposes concrete integration seams rather than declaring the whole product verified. Read it with19, the specific action contracts and the independent audit. It is a planning walkthrough only; all native outcomes above remain future acceptance expectations.
