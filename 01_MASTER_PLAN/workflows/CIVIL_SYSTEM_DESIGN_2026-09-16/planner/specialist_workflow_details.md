# Specialist Civil workflow details

**Proposed planning detail — not an implementation instruction.** This annex deepens the specialist systems in Master Plan §11 H, I and J, plus retained charged-system calculation. It preserves existing calculation routes and names gaps rather than inventing a device, a hydraulic result, a number, a council policy or a new command.

## Shared specialist-system behaviour

| Requirement | Proposed behaviour for review |
|---|---|
| When it appears | A specialist system appears only when an engineer selects it or credible project/source evidence makes it relevant. A job does not need every system. |
| Evidence first | Show the source/document status, selected drawing evidence and any manual/pinned decision before a value affects a result or drawing. |
| Main page | Engineering task groups, a large actual-plan preview, visible primary actions and More for rare options. No compulsory wizard or invented stage. |
| Actions | **Use proposal**, **Adjust**, **Select/draw**, **Enter manual**, **Show source**, **Show on plan**, **Keep unresolved**, **Cancel**. Actions available depend on the task; a proposed source value never writes by inspection alone. |
| Manual override | Keep value, source/reason, revision and dependency status. New evidence marks **Needs review**. Only a confirmed governing change makes a consuming result **Numerically out of date**. Missing/unsupported basis means **Cannot calculate**. |
| Preview / safety | Temporary overlays are non-printing and clear on Cancel/Escape. Actual drawing edit uses the owner command and one accepted AutoCAD operation equals one Undo. Locked/Xref/REFEDIT/foreign content is read-only; never bypass it. |
| Assessment wording | A reported rating, target or calculator estimate is shown as its source/result type. CE must not present it as model execution, council approval or issued-design compliance unless that separate proof exists. |

## H1 — Pump station, wet well, pump controls and rising main

### What the user needs to decide

| Engineering task | Fields grouped for review | Evidence / Unknown state |
|---|---|---|
| Confirm this is a pumped system | System name/role; reason for pumping; associated drainage catchment/system; discharge destination; source/decision status. | A pumped system is not inferred from a low point or a line that resembles a rising main. Connection/destination stays Unknown until proven or selected. |
| Define the physical wet well/SPS | Selected pit/detail identity; plan position; geometric dimensions; cover/top, base/bottom and operating reference levels; inlet/outlet/rising-main attachment; applicable access/detail evidence. | Survey/report/drawing levels are evidence until confirmed. Where levels conflict, retain both and show a field-level conflict. |
| Set pump-control information | Duty/standby/control arrangement; selected start/stop/alarm/reference levels; power/control notes; source/revision/manual reason. | No control philosophy, equipment selection or level should be invented from a generic SPS label. |
| Define rising-main route | Pipe identity/type, route/length from actual drawing, material/diameter/connection target where confirmed; plan/profile representation. | Crossing/proximity never proves the destination. A route can remain unconnected/Needs review. |
| Check the selected calculation | Only the confirmed inputs required by the retained Pump System calculation route; source/status of each; result revision. | A calculation is **Cannot calculate** when its required basis is missing or unsupported. It does not select/validate a pump manufacturer, power/control design or council discharge arrangement by itself. |

### Retained source-observed path

- `CDCALC` already exposes a **Pump System** calculator tab.
- Source includes Pump sizing models/service, SPS detail models/generator, rising-main recognition and Pit Schedule handling.
- No `CDPUMP` command declaration was observed in the bounded `Modules/Drainage` command scan. That is not proof no route exists elsewhere.

### Preview and visible actions

| While reviewing | While working on drawing | Primary actions |
|---|---|---|
| Source-page/detail comparison, selected calculation inputs/results and field-level conflict list. | Actual plan preview with wet well, attached pipes/rising main and linked outlet highlight; profile/schedule preview when their owner route is available. | **Use evidence**, **Adjust system**, **Show source**, **Show on plan**, **Open existing calculation**, **Open existing pit/pipe editor**, **Keep unresolved**, **Cancel**. |

### Future representative acceptance

1. Start with a synthetic SPS/wet-well, a proposed rising-main route and a source-level conflict.
2. Open the specialist review. Confirm the conflict remains visible and no level is adopted merely because one source is newer.
3. Deliberately choose one recorded governing level; check only results/details that consume it become **Numerically out of date**.
4. Change the drawn rising-main end so it crosses an unrelated pipe; confirm no hydraulic destination is inferred.
5. Cancel a preview, then save/reopen: temporary overlay is gone; accepted decision, conflict and source references remain.

## H2 — Charged drainage system

### What the user needs to review

| Engineering task | Fields grouped for review | Evidence / Unknown state |
|---|---|---|
| Confirm charged-system scope | Which confirmed roof/catchment, downpipes, pipes and destination belong to the selected charged system; any excluded/bypass route. | A charged system is not inferred from a label alone. Each physical link needs actual/proven or explicit connection evidence. |
| Review physical route | Pipe identities, type/material/diameter/length from the drawing; relevant elevations/head/reference points; fittings/loss information where the retained calculator requires it. | Plan geometry and text may disagree; plan-label authority is reconciled rather than overwritten. Unsupported/missing inputs remain Unknown. |
| Review design input | Confirmed catchment/rainfall/criteria basis and result revision. | Use the job-specific basis, or the named Melbourne office curve only when its appropriate zone is confirmed. Do not silently fall back to it. |
| Drawing output | Pipe presentation, route, relevant callouts and downstream item connection. | A successful calculator result does not create a physical pipe route or prove equipment compatibility. |

### Retained source-observed path

- `CDCALC` has a **Charged System** tab with its own inputs/results.
- The source inventory identifies charged-pipe types, pipe editor/drawing routes and schedule/profile consumers.
- This annex proposes no new charged-system command or replacement calculator.

### Future representative acceptance

1. Use a synthetic confirmed charged roof-to-destination arrangement and one unrelated crossing pipe.
2. Open existing CDCALC Charged System route from the review door; check it shows only deliberately selected/confirmed inputs.
3. Change a confirmed contributing catchment; result is **Numerically out of date**, never silently recalculated.
4. Remove a required input; it says **Cannot calculate**, without a replacement value.
5. Reopen the drawing and verify retained system identity, source status and explicit exclusions.

## I1 — Raingarden / bioretention

### What the user needs to decide

| Engineering task | Fields grouped for review | Evidence / Unknown state |
|---|---|---|
| Identify the device | Name/type; selected/drawn boundary; measured area; physical item such as associated GIO where applicable; plan location. | `CDRG` and GIO are retained routes. A source proposal or a plan outline does not prove final device geometry. |
| Identify what drains to it | Confirmed contributing catchment portions; treatment destination/overflow path if separately proven; report/model source and revision. | Roof fall, visual proximity or a plan crossing does not prove a hydraulic allocation. |
| Capture treatment basis | Source-stated device requirements/assumptions/targets/results; soil/extended-detention/submerged-zone information only if actually supplied by the source or manually confirmed. | Blank source fields stay Unknown. Finding a MUSIC/WSUD report does not mean CE executes or validates its model. |
| Review provided versus assessed | Selected/drawn device area/geometry versus a source/proposed requirement; result type and source status. | No automatic claim that a measured plan area proves model performance or compliance. |

### Preview and visible actions

Actual-plan preview shows selected boundary, contributing confirmed portions, item/GIO association and any separately confirmed overflow. Source-page preview shows the report row/page. Actions: **Use source proposal**, **Select outline**, **Draw boundary**, **Adjust**, **Link confirmed catchment**, **Show source**, **Keep unresolved**, **Cancel**.

### Future representative acceptance

1. Synthetic job has a report proposal, a different drawing boundary and one DP with no confirmed destination.
2. Open raingarden review; source and measured area are both visible without substitution.
3. Confirm an outline and one catchment portion; check allocation/review status changes but no DP link is inferred for the unconfirmed DP.
4. Change the source report only: **Needs review** appears, while the pinned governing boundary/result remains matched to prior inputs.
5. Escape temporary catchment shading; ensure no hatch, Civil record or calculation input was created.

## I2 — Swales, buffer strips, sedimentation and other treatment devices

### Planning boundary

Master Plan §11 I explicitly names **swales, buffer strips, sedimentation and treatment devices**. The D+F evidence says historical report rows include rainwater tank, None and Buffer Strip; it does not establish an approved interactive Civil workflow for every device type. Existing CDCALC WSUD measures are retained as an estimate/assessment route, not a device-design or model-running claim.

| Device family | Proposed review groups | Source/unknown boundary |
|---|---|---|
| Vegetated swale | Plan route/boundary; contributing catchment portions; inlet/outlet/overflow if proven; source requirement/assumption; selected detail/standard. | No source-observed dedicated placement command is recorded in this planner. Do not invent geometry, grade, treatment performance or hydraulic link. |
| Buffer strip | Boundary/route; surface/material context; contributing area; source-stated treatment arrangement and comparison evidence. | Historical report evidence supports the category, not a completed physical-design workflow. |
| Sedimentation device/basin | Selected device/detail; position/boundary; contributing catchment; inlet/outlet/overflow only when proven; source assumptions/maintenance notes. | Retained WSUD measure is an assessment option. It does not supply a final device layout, construction detail or model validation. |
| Other treatment device | Device type from approved catalogue/source; physical footprint; connected catchment/system; source/model/status; downstream treatment sequence. | Do not create a generic catch-all device that silently has engineering defaults. Unknown device data remains Unknown. |

### Retained assessment path — explicitly limited

`CDCALC` contains a **WSUD** tab with pre/post areas, selected measures and target/achieved display. Source labels it as an estimator and directs formal MUSIC modelling to a specialist. Therefore:

- CE may display a report’s stated treatment assessment or its own retained estimator result with the method/source named.
- CE must not say it ran a MUSIC model, validated a `.sqz` model, or proved council compliance simply because it found a report or shows an estimator pass.
- A source/report result stays distinct from a requirement and from what is physically provided on the drawing.

### Future representative acceptance

1. Synthetic job contains a buffer-strip proposal and a sedimentation-device report reference, but no confirmed geometry.
2. The review shows both as evidence/proposals and offers Select/draw/manual, with **Keep unresolved** available.
3. Selecting a measure in the retained WSUD calculator visibly labels it as calculator output, not formal model execution.
4. Change a confirmed contributing catchment; affected estimator/result is **Numerically out of date**. A changed source with unchanged pinned basis is **Needs review**.
5. Confirm Schedule/Profile/Issue routes do not invent a detail or treatment link for an unresolved device.

## I3 — Soakage / infiltration

| Engineering task | Fields grouped for review | Evidence / Unknown state |
|---|---|---|
| Confirm suitability path | Selected soakage system/type; contributing catchment; documented ground/site investigation reference; applicable authority/criteria source; explicit engineer decision. | Soakage is not a default for leftover/unclassified area. A soil description without a confirmed engineering basis stays evidence/Unknown. |
| Define proposed physical system | Selected device/footprint/location; inlet/outlet/overflow where proven; detail/source; drawing representation. | No `CDSOAK` declaration was observed in the bounded command scan. Interactive placement and detail route remain Unknown. |
| Review retained sizing path | Only confirmed inputs required by `SoakageSizingService`; result basis/source/revision. | A retained sizing service does not replace geotechnical suitability or prove approval. Missing basis is **Cannot calculate**. |

**Visible actions:** **Show source**, **Use proposal**, **Select/draw physical evidence**, **Enter/pin manual basis**, **Open retained sizing route when available**, **Keep unresolved**, **Cancel**.

### Future representative acceptance

1. Open synthetic job with a soakage proposal but no confirmed ground evidence.
2. CE shows **Cannot calculate** and keeps normal drainage work available.
3. Add a documented/manual governing basis with reason; preview only the selected footprint/connection evidence.
4. Change source evidence while pinning the existing basis; system becomes **Needs review**, not automatically recalculated.
5. Check locked/Xref outline is read-only and no surrogate soakage boundary is made.

## J — Overland flow, overflow paths, flood/surcharge evidence and surface safety

### What the user needs to review

| Engineering task | Fields grouped for review | Evidence / Unknown state |
|---|---|---|
| Identify why review is needed | Relevant authority/source condition; known flood/surcharge/overflow evidence; drawing/revision status. | Council record establishes that conditions can alter requirements, but it does not authorise a generic default or a calculated result here. |
| Define evidence path | Site/surface boundary; selected existing/proposed levels with datum; explicit path boundary/route; upstream/downstream points; receiving condition/source. | CDFALL, CDSL and slab tools are adjacent evidence tools only. No `CDOVERLAND` declaration was observed in the bounded scan. |
| Relate to drainage | Confirmed overflow point and affected physical system/catchment, only where evidence proves/selects it. | Pipe crossings/proximity do not create an overflow path. Missing route/level/safety method is **Cannot calculate**, not a pass/fail guess. |
| Drawing/issue output | Temporary review overlay, named evidence references and unresolved warning; later approved plan note/detail only from selected record. | CE must not create a safe-path claim, a flood level or a construction requirement from a generic grade arrow. |

### Preview and visible actions

Source-page preview while reviewing requirements; actual plan preview while selecting evidence. Actions: **Show source**, **Show selected levels**, **Select/draw evidence boundary**, **Record manual/pinned decision**, **Show affected systems**, **Keep unresolved**, **Cancel**. A reviewed future workflow may offer a deliberate output route only after its engineering method is approved.

### Future representative acceptance

1. Synthetic drawing has source evidence calling for overland review, one explicit path candidate, and an unrelated crossing pipe.
2. Open review: source/page and plan evidence appear; no hydraulic connection is made from the crossing.
3. Leave path/level method unresolved: CE shows **Cannot calculate** for any dependent safety result while other drafting continues.
4. Pin an engineering basis then change a measured boundary: CE shows **Needs review**; it does not recalculate or clear the pin.
5. Escape overlay, save/reopen: temporary display clears; source/manual decision and unresolved warning persist.

## Water Tank — last, read-only interface summary

This planner does not redesign CDWT or change its owner. Tim’s scoped override remains: **Claude owns the CDWT window for now**. The facts below are already recorded; where an exact end-user approval record is absent, status says Unknown.

| Already recorded end-user interface / rule | Source / status |
|---|---|
| Tank visual/window must appear before command-line choice; tank list is ordered by size; dimensions and tank type must be visible; selection order must make practical sense. | Test Day W-01 to W-05. Reported fault/required outcome; not Tim-accepted. |
| Tank plan representation uses true library size by stretching; tank type is selected; trafficable is a property of the specified tank, not material. | Consolidated record, Tim’s 15 Sep tank rulings. Behaviour approval recorded; current window/runtime status not rechecked here. |
| Latest dated report is the current report for forward work, and CE says which it used; no historical live-job back-fix sweep. | Consolidated record, Tim’s tank rulings. Applies to report selection, subject to document identity/revision conflict handling. |
| Reuse capacity, detention credit and physically provided capacity are separate; tank-owned detention/orifice identity is separate from a site OSD-pit orifice; tank-base RL is separate from slab/top/TWL. | Master CDWT protected-recovery/project-comparison record. Source/planning evidence; integrated/runtime/AutoCAD acceptance Unknown here. |
| Catalogue uses distinct manufacturer/product footprints; exact unmatched construction detail stays blocked rather than stretching/reusing a merely similar detail. | Master protected-recovery record. Source-only safety direction; no released-detail claim. |
| Multi-tank work needs per-tank and group authority; conflicts in issued/project evidence remain visible and prevent automatic numeric adoption. | Master protected-recovery/project-comparison record. Source/planning evidence; UI interaction approval beyond the listed W items is Unknown. |

### Water Tank future acceptance — owned elsewhere

The active CDWT owner should test, in AutoCAD: visual-first selection; ordered list; dimensions/type/trafficable status; true-size plan placement; explicit source/revision; separate reuse/detention/provided quantities; multi-tank/group behaviour; unmatched-detail block; Cancel/Undo/save-reopen. This planner does not create a competing Water Tank scenario, window or implementation contract.

## Dated integration boundary — 16 September overnight record

The newer Test Day tail records active CD/PIT preview selection/drag/dry-run work, PLACE-01 callout/twin placement work, and the C7 native-polyline probe/rebuild and approved later auto-upgrade-on-open path. It also records specific migration safeguards: readers/2024 enabler first, one first-backup, one Undo, and one clear count/backup line. Those are active owner-work, not a generic specialist workflow to redesign here.

Where a specialist workflow consumes a Civil pipe, pit, callout, twin or migration result, it must use the owner-published identity/selection/migration contract when available. It must not substitute generic CDREPAIR, relinking or drawing recovery for an expressly approved migration path, and it must not claim the overnight source/probe record is AutoCAD acceptance of a specialist system.

---

## Verification status

No specialist system was run, calculated, placed, modelled, rendered, built, installed or AutoCAD-tested in this planning annex. Existing routes above are source-observed or record-backed only. All new workflow detail is Proposed and awaits Tim review plus later independent audit.
