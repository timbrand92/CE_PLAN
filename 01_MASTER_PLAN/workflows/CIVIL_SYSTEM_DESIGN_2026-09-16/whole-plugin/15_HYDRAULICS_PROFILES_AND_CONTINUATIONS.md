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

## Calculation report controls — bounded source read-back

Inspected root `C:\Lisp Files\CE_ACAD_PLUGIN`, not another owner's newer implementation or installed state. `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:1163–1177` visibly binds four section choices and Export to PDF. `ViewModels/CalculationsV2ViewModel.cs:130–160` builds a FlowDocument and uses a PrintDialog; after confirmation it calls PrintDocument. In the inspected complete BuildFlowDocument body, a cover is always added and only ExportDetention adds section pages. ExportPipeFlows, ExportCatchments and ExportWsud are defined/bound but not consumed by that report-building body.

| Control/action | Current bounded source effect | Required planning consequence |
|---|---|---|
| Four section checkboxes | Only detention selection affects the inspected report composition | Do not claim exact selected output from controls alone. Reconcile every selected section with actual generated pages, or show unavailable output explicitly. |
| Export to PDF | Opens printer selection and submits a document; no explicit PDF file receipt in this method | Distinguish Print from verified saved PDF. Printer success is not issue completion or proof of filename/pages. |
| Suggested filename / Copy filename | Builds a sanitised name and copies it to clipboard at:281–305 | Suggested name is not the selected destination and does not establish a saved file. Clipboard failure is caught; no content/output proof. |
| Add System | Creates a view-model system then calls LoadFromDrawing at:102–111 | Scope/source/draft authority must remain explicit; a new tab is not proof of a distinct adopted outlet/system. |
| Refresh | Reloads each system from drawing and calls longitudinal refresh at:114–118 | Qualify pending edits before describing Refresh as read-only. No unconditional discard of manual inputs is approved here. |
| Insert Criteria | Builds selected system summary and invokes insertion service at:121–127 | Separate drawing output from report export and underlying source adoption; this read did not qualify the insertion service's native result. |

Proposed report acceptance: select each available section alone and together; inspect the actual generated document, its cover and page order; compare listed calculation basis/rule version with the reviewed input; cancel printer/file choice; verify exact saved artifact before sharing/issue. Missing sections, stale calculations and incomplete output stay visible. No report was generated or printed in this planning run. The computations-sheet design/doorway/issue interaction remains in the existing pending decisions; this evidence does not decide it for Tim.

### Detention refresh and system membership — inspected consumer

Root `ViewModels/DetentionSystemViewModel.cs:297–374` clears pipe/pit collections, obtains current drawing data and scans detention-typed pipes. The inspected method has no per-system/outlet argument or membership filter. `PopulateFromSeeds:381–460` creates new rows with IsSelected=true, includes connected pits, clears an unavailable OrificePitId and chooses the first pit when none is selected. These are source observations, not approved automatic outlet selection.

| Action | Source consequence | Target qualification |
|---|---|---|
| Refresh / Add from drawing | Rebuilds collections; previously excluded/removed row may return selected | Preserve explicit system membership and exclusions by stable identity, or present a reviewed difference. Do not describe refresh as merely updating displayed numbers. |
| Remove selected row | At:231–250 removes a view-model row and recalculates; no drawing deletion in that body | Label scope as calculation membership, not Delete pipe/pit. Persistence and refresh behaviour must be explicit. |
| Add another system tab | CalculationsV2 AddSystem calls this same drawing loader | A tab name alone does not prove distinct physical system/outlet scope. Qualify each system's adopted membership before totals or reports are treated as independent. |
| Orifice pit no longer available | Current source falls back to first pit | Required target must flag missing adopted control location; do not silently make another pit the governing outlet. Exact recovery interaction needs its reviewed owner contract. |
| Use Boyd's value | At:216–220 explicitly assigns suggested volume formatted to two decimals | Distinguish current suggestion from deliberately used required volume; method applicability and governing source remain separately reviewed. |

No broad claim that Refresh overwrites every manual input is supported: the inspected path specifically rebuilds pipe/pit membership and may replace orifice-pit selection. Other manual fields require their own consumer evidence. Future synthetic qualification: exclude one pipe, refresh; create two distinct systems; remove the adopted control pit; then save/reopen. Compare membership, outlet identity, selected totals, retained manual required volume and resulting report. Never let a missing reference quietly become a zero or an alternative outlet.

### Criteria insertion — output is not automatically a linked design record

Direct root read `Services/OnSiteDetentionCriteriaService.cs:16–216` establishes this sequence: locate named asset, reuse/load system-named definition, prompt placement, explode the new reference, erase it and replace text with summary rows. Definition loading precedes the placement prompt. Therefore Cancel at placement is not proof that no definition was added, and this multi-step path is not proven as one native Undo operation.

`PopulateExplodedCriteria` erases non-title text before checking usable extents. An early return for missing extents can still reach the caller's transaction commit. This is a source-level incomplete-output risk, not an observed drawing failure. A successful insertion prompt must not stand in for verified complete criteria content.

The output rows include PSD, TWL, head, orifice diameter, required volume, selected pit/pipe/extra contributions and total storage. `DetentionSystemViewModel.BuildSummary:556–595` converts input strings through `Parse:716–723`, which returns0 on parse failure. Thus this inspected handoff can lose the distinction between unsupported/invalid input and an actual zero. No new engineering default is approved. The target must retain missing/invalid status and prevent an apparently verified criteria note from presenting an invented zero.

The inspected insertion body contains no explicit document/page/revision or calculation-currentness stamp. That is a bounded service observation, not proof that all external infrastructure lacks provenance. Until qualified, treat these inserted notes as a snapshot needing comparison after design changes, not a proven live linked result.

AS-01's native/dynamic-object preservation rule still governs assets. This service's explicit explosion is not itself evidence of a catalogue-authorised exception. Existing owner must establish the intended asset contract before retaining or changing that behaviour; this planning does not redesign Water Tank or edit the active Civil implementation.

Future synthetic acceptance: missing criteria asset; Cancel after definition load; valid and invalid PSD/TWL/volume inputs; missing usable asset extents; repeat insertion with an existing same-name definition; one accepted drawing operation followed by native Undo/save/reopen; later changed calculation basis. Inspect actual text, remaining placeholders, graphic completeness and traceable scope. Keep criteria insertion, PDF output and final issue history as separate results.
