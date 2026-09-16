# Hydraulic review, long sections and linked plans

FOR TIM

The designer sees one consistent calculation result, chooses the intended route at a branch, and can represent one pipe across separate plans without creating a fictitious pit or second pipe.

## Authority and limits

Read canonical CV-02_HYDRAULIC_DESIGN.md, CV-06_REVIEW_CALCULATION.md and CV-01J_MULTI_LEVEL_CONTINUATIONS.md including approval refinements and the latter's two-DWG recovery section. These approved requirements extend whole-plugin C2/C3/C6 and earlier Civil hydraulic-family planning. This is requirement inheritance, not verification of engineering standard editions, numeric compliance, current build status or installation. Existing CD/PIT/continuation/calculation owners remain responsible. No live calculation or AutoCAD action ran.

## Gravity hydraulics — approved HD1–15

| ID | Required behaviour |
|---|---|
| HD1 | Gravity scope; charged/pump/detention workflows separately reviewed, sharing governed rules where applicable |
| HD2 | Same geometry, flow and version-stamped rules produce identical results in CD/CDEDIT/Inspector/CDRUNSOLVE/CDCALC |
| HD3 | Project requirement→council→office→verified standard→advisory placeholder; show winning source and conflicts |
| HD4 | Source/approval/version per rule; rule changes compared against authorised approved examples before production authority |
| HD5 | Every flow has source; manual Designed flow can be locked |
| HD6 | Aggregate only known connected upstream sources; locked downstream flow wins with mismatch visible |
| HD7 | Full-pipe capacity separate from design-flow performance; no self-cleansing Pass from full-pipe velocity alone while partial-flow qualification absent |
| HD8 | No automatic downsizing; separate explicit approval required. Keep/upsizing recommendations do not imply automatic change |
| HD9 | Fixed levels win; incompatible cover/grade/inverts return No feasible solution, never move survey to force a solution |
| HD10 | Label achieved grade from final inverts as1:N, no MIN/MAX suffix; retain proposed grade in calculation record |
| HD11 | Surface-to-obvert cover at ends and worst reliable point along alignment |
| HD12 | No reliable surface→Unknown cover with missing evidence named |
| HD13 | One material/diameter/roughness/velocity catalogue; unknown material cannot gain favourable default |
| HD14 | Full internal precision and common approved final rounding; repeated calculation no drift |
| HD15 | Pass/Advisory/Fail/Unknown/No feasible solution with controlling reason; Unknown inputs propagate, no guessed downstream pass |

## Numeric rules — preserve HV1–15 with their verification gates

Do not reproduce historical values as a new current compliance table. Canonical CV02 values and refinements remain the exact source; later verified council/project records and adopted versions govern each job. The original approval itself requires source verification and authorised approved-job comparison before live Pass/Fail.

| ID | Required preserved decision / qualification |
|---|---|
| HV1 | Project stores applicable edition; no silent upgrade of existing jobs. Historical commencement/edition statement is not newly verified here |
| HV2–3 | Diameter/council grade table, replacing conflicting universal too-flat rule; edition verification and DN90-versus-base-ladder reconciliation remain explicit |
| HV4 | Proposed office self-cleansing basis stays Advisory until sourced/validated; council override, actual-flow depth and threshold sensitivity visible |
| HV5 | No favourable unknown-material velocity cap; early advisory distinct from authoritative maximum/Unknown compliance |
| HV6 | Sourced roughness by material; unknown material stays Unknown |
| HV7 | Controlled available diameter/material/class combinations, not every listed size for every product |
| HV8–10 | Office cover target distinct from compliance; proposed/existing verified surfaces appropriate to pipe; complete alignment; class/bedding/loading/manufacturer/council constraints; no universal maximum |
| HV11 | Editable office pit-drop default subordinate to sourced council minimum; default not synonymous with compliance |
| HV12 | Capacity comparison and separate near-capacity advisory; warning threshold not new failure threshold |
| HV13 | No default Q; retain units,event,method,catchment,source; missing flow→Unknown |
| HV14–15 | One common precision/gravity policy and full governing rule/council/version record; comparison evidence required |

CV-02A advisory visual/source staging is not authority to bypass these gates. Current rulebook/council work remains a dependency; no broad corpus access is authorised by this overnight.

## Review and long sections — approved CV6-1–15

| ID | Required experience |
|---|---|
| CV6-1–2 | Compose existing schedule/hydraulic/QA authorities in coordinated review; retain direct commands. Later standalone Civil access remains available |
| CV6-3 | Frozen non-writing opening snapshot; reconciliation separate |
| CV6-4 | Category,severity,source,status per finding; no authoritative label without basis |
| CV6-5 | Cached immediate view, safe refresh without pan/zoom/selection lag |
| CV6-6 | Navigate by stable identity; double-click zoom/select never auto-repair |
| CV6-7 | Fix/Fix All exact full preview, explicit filtered scope and skipped items, approve/apply/Undo; refuse stale plan. QA12 limits batching to identical reversible drafting fixes; unrelated engineering changes remain individually bounded, never blanket Fix All permission |
| CV6-8 | Selected start pit; show reachable routes and ask at branches; LPD only valid if reachable on selected network |
| CV6-9 | Missing cover/invert/surface remains Unknown; no zero datum or fabricated profile row |
| CV6-10 | Linked placed profile retains route,datum,scales,vertical exaggeration,network revision; update existing through preview/Undo |
| CV6-11 | Same governed calculation authority; no duplicate formulas in review panels |
| CV6-12 | Panel method capability Approved/Advisory/Blocked distinct from individual result status; unsupported method cannot masquerade as approved pump/WSUD design |
| CV6-13 | Inputs/results/overrides/council/calculation revision persisted with job; metadata suggestions confirmed |
| CV6-14 | Verified citation/applicable scope for standards claims; export exactly selected sections and preview actual package |
| CV6-15 | Consolidated branch/Unknown/read-only/stale/save/export qualification, representative profile/dashboard/PDF review |

**Long-section journey:** select upstream pit→highlight reachable routes→choose branch/outlet→review datum/scales/unknowns→preview→place linked section. Later changed invert→section Out of date→review differences→update same section. A nearby unrelated pit named LPD cannot redirect the route.

**Export journey:** select supported sections→show actual page/section list and missing inputs→preview generated package→confirm output. A selected Catchments section cannot silently produce only detention pages; unavailable sections are identified before claiming complete export.

## Multi-level continuation — separately approved CV-01J

One logical pipe owns displayed fragments across plans. Total developed length is fragmentA + proved/declared hidden length + fragmentB. Continuation marker is a display/mapping link, not a hydraulic node, riser, pit or another pipe.

| Step / consumer | Required result |
|---|---|
| Continue on another plan | Reuse CD route and saved plan mapping; linked marker pair visible |
| Mapping | One reference point only with confirmed equal orientation/scale; otherwise two reference points |
| Complete route | Draw/select second fragment to real destination; confirm partners,type,diameter/material,fragment/hidden/total lengths |
| Gravity | Direction from governing source/destination levels; grade uses total length |
| Rising main | Explicit pump/source→discharge; pressure/pump route, no gravity rejection or inferred direction from invert difference |
| Select any fragment | Same logical pipe in CDEDIT; no independent duplicated engineering values |
| PITSCHEDULE | Real pits only; no fake continuation row; optional plan/level/continuation information |
| Missing/conflicting evidence | Block creation/update for missingpartner/duplicateidentity/wrongendpoint/ambiguousmapping/stalegeometry/unknownhiddenlength; name reason |
| Existing pit orientation / PP | Preserve CV01J approved choices and later active PIT owner refinements; this annex does not redesign those windows |

**Cross-DWG recovery is not one global Undo.** The canonical J5B2 record describes one bounded Undo group in each drawing, durable pending/completed journals, verified paired publication and reverse compensation. Failure to compensate is repairable Incomplete, never Success. Confirm the two exact real writable documents; no Xref write-through or arbitrary inactive target. Save/reopen/retry must prove both sides, not just one marker.

The card records J5B2 source work, with J6 confirmation/consumer integration and live evidence still pending at that historical checkpoint. Do not mark whole continuation built from that partial source report. Its compatibility/per-split guarded rollback requirements remain relevant. Later C7 automatic migration is scope-specific: it cannot be assumed to approve every continuation-schema upgrade. Reconcile exact object/schema class with migration owner before changing a trigger; do not broadly disable the later C7 approval or silently broaden it.

## Synthetic qualification sequences

- Branching pit with unrelated nearby LPD: route choice remains explicit and only reachable LPD offered.
- Known full capacity but unverified partial-flow rule: capacity result and advisory self-cleansing remain distinct.
- Existing larger pipe: recommendation does not downsize without separate approval.
- Cover adequate at both ends but low mid-run: worst reliable surface point governs; missing intervening evidence stays visible.
- Recalculate identical versioned inputs repeatedly: stored/displayed levels and grade do not drift.
- Two-plan pipe with unknown hidden length: confirmation unavailable, no fabricated length/schedule row.
- Paired continuation fails on second DWG: exact recovery evidence, no false complete pair; independent per-DWG Undo explained.
- Profile update and selected report sections after network revision: stored route retained, stale preview refreshed, actual output matches selected sections.

These scenarios are planning requirements, not executed tests. Independent coverage audit ongoing.
