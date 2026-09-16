# Civil engineering dependency map

**Proposed planning map — not an engineering calculator.** It records dependency doors already established by the planning records and bounded source inventory. It does not introduce a number, equation, council policy or hydraulic result. Each system is optional: a job may have one, several or none. A missing system is not a failed design by itself.

## Reading the map

| Term | Meaning in this map |
|---|---|
| Evidence | Source document/page, selected drawing geometry, survey/import data, explicit user decision or existing Civil object. Evidence is not automatically governing. |
| Governing input | Confirmed/pinned/manual engineering input with source/reason. |
| Reference level | Named level relationship, such as cover, invert, top water, finished surface or outlet level. Its datum/units/source must stay visible. |
| Needs review | New evidence, geometry or a proposed value may affect the engineering basis, but the governing/pinned inputs have not changed. The existing numeric result remains matched to its recorded inputs. |
| Numerically out of date | A confirmed governing input has changed after a result/output was calculated. The prior result/output remains readable with its prior input revision; it is not recalculated automatically. |
| Cannot calculate | A required governing input is Unknown, inconsistent or unsupported for that calculation. CE explains the gap; it never substitutes a default. |
| Gap | A capability/data relationship not established by this planning or bounded source reading. It is not a zero or a safe substitute. |

## Shared foundation — applies only where the system uses it

```text
Evidence / confirmed decisions / actual Civil objects
                    ↓
            governing engineering inputs
                    ↓
      system-specific result or design check
                    ↓
 selected drawing output / schedule / profile / issue review
```

| Shared input/change | Used by | If changed | Must remain distinct |
|---|---|---|---|
| Project/document source, internal date/revision/status | All evidence-led systems | Mark the linked basis **Needs review**. No automatic replacement; an unchanged governing/pinned value leaves its numerical result matched to recorded inputs. | Source proposal, governing decision and manual/pinned override. |
| Council/design criteria and per-job rainfall basis | Gravity sizing where applicable, detention/orifice, pump/WSUD calculations | New evidence is **Needs review**; a confirmed governing-basis change makes related results/outputs **Numerically out of date**. | Published, council-issued and compute-to-ARR modes; sourced/assumed/office/manual state. |
| Site extent / surface / hydraulic catchment | Gravity demand, detention, treatment, pump/overland consideration | Measured/proposed change is **Needs review**. Confirmed governing record change makes allocations/results that consume it **Numerically out of date**. | Extent, surface class and hydraulic catchment/allocation. |
| Civil pit/pipe/item identities and proven connections | Gravity, detention storage, profiles/schedules, review | Physical capacity/output is **Needs review** after observation; confirmed engineering/geometry change makes dependent output/result **Numerically out of date**. | Exact/proven connection, possible/review state, explicit override and visual crossing. |
| Plan label edit | Any record whose established label contract makes the label authoritative | Reconcile label to record or show conflict. A confirmed governing edit makes the dependent result **Numerically out of date**; a conflict is **Cannot calculate** only where that field is required. | Authoritative label vs display-only wording/position override. |

## 1. Gravity drainage network

| Aspect | Dependency map |
|---|---|
| Applies when | A job has gravity pits/pipes/items. It does not apply merely because a survey or report exists. |
| Known input types | Confirmed pipe/pit geometry and stable identity; proven endpoint/topology relationship; pipe type/diameter/material where applicable; flow direction; cover and pipe-end invert/reference levels where actually known; surface/item connection evidence; project standards/criteria with source. Units are drawing units for geometry and the stored engineering unit for sizes/levels; source/datum remain visible. |
| Evidence door | Existing Civil object or deliberate user edit; survey/selected evidence may suggest a level but does not override an explicit engineering entry. Crossings/proximity are not connection evidence. |
| Consumers | Pipe/Pit editors; local topology reassessment; CDCHECK/Civil Hub/Dashboard; Pit Schedule; Long Profile; calculation input where a confirmed system uses the network. |
| Review / out-of-date effect | Observed geometry/connection evidence is **Needs review**. Confirmed connection, level, size or type change makes applicable topology/annotation/schedule/profile and storage/flow result **Numerically out of date**. Missing required level/input is **Cannot calculate** only for the calculation that requires it. |
| Retained source-observed tools | `CD`, `PIT`, `CDEDIT`, `PIPEEDIT`, `PITEDIT`, `CDRUNSOLVE`, `CDINSPECTOR`, `CDHUB`, `CDDASHBOARD`, `PITSCHEDULE`, `CDPROFILE`. |
| Known gaps / limits | Runtime truth and all editor outcomes remain unverified here. Do not create flow, invert or connection data just to complete a graph; simple pipes can be connected without manufactured levels. |

## 2. Detention storage and outlet/orifice

| Aspect | Dependency map |
|---|---|
| Applies when | Confirmed project requirements call for an OSD/detention system. It is not implied by a generic storage label, tank label or report headline score. |
| Known input types | Confirmed catchment/calculation inputs and criteria; selected detention pipes/pits and their actual geometry/levels; additional explicitly identified storage; permissible discharge/control arrangement; TWL candidate/reference level; outlet/orifice pit/baffle/orifice information where selected; council/source basis. Storage volume and flow use their displayed engineering units; level relationships keep their datum/reference clear. |
| Evidence door | CDDESIGN/criteria confirmation and physical Civil drawing evidence. `CDCALC` Detention tab visibly has detention item selection, required/additional storage, discharge control and result areas. Existing Design Package/Impact concepts should be reused before parallel records are created. |
| Consumers | CDCALC detention/Boyd’s/related result; calculations sheet, OSD criteria block and orifice detail once a selected result/output relationship is confirmed; Project Review comparison of designed versus provided storage. |
| Review / out-of-date effect | New source/measurement/candidate is **Needs review**. A confirmed criteria/rainfall/catchment, pipe/pit/tank/device, level or TWL choice change makes the consuming result/output **Numerically out of date**. Missing/inconsistent required basis is **Cannot calculate** for that result; CE does not fill it. |
| Retained source-observed tools | `CDCALC` Detention/Boyd’s tabs; Detention, OnSiteDetentionCriteria, Orifice and detail services/models; `PITSCHEDULE`, `CDPROFILE`, Hub/Dashboard review. |
| Known gaps / limits | Existing source proves concepts/routes, not a complete result-to-sheet/criteria/detail identity. Test Day recorded detention/TWL/output faults. CE must present candidates and a recorded manual choice; it must not select a governing TWL from a fixed assumption. |

## 3. Roof/reuse allocations

| Aspect | Dependency map |
|---|---|
| Applies when | A roof/catchment has a confirmed drainage/treatment/reuse arrangement. It is optional for any particular DP or job. |
| Known input types | Existing catchment-plan evidence or confirmed boundary; measured/report/manual area with source; DP identity; each DP’s confirmed contributing portion; treatment/reuse destination proposal or confirmed link; source page/revision/status. Area is shown in its declared units; drawing measurement keeps drawing-unit/scale basis. |
| Evidence door | CDDESIGN Catchments and Drainage Items DP workflow. First recognise an existing plan, then accept/adjust/select/draw/manual. DP allocation is opt-in and no equal split is automatic. |
| Consumers | Confirmed catchment record; DP allocation display; calculation inputs where the selected calculation uses it; treatment/reuse review; Project Review source/version comparison. |
| Review / out-of-date effect | A changed measured roof/source is **Needs review** while a deliberately pinned governing area remains unchanged; existing calculations still match their recorded inputs. Confirmed governing boundary/area/portion/destination change makes allocation reconciliation and consuming result **Numerically out of date**. Source revision alone never reallocates. |
| Retained source-observed tools | DP / `CDSOURCE`-family item routes; `CDCALC` Catchments tab; CDRG/GIO where a confirmed destination uses those items. |
| Known gaps / limits | Persisted roof-to-DP integration is not established by the records. Roof fall, proximity/crossing or a similar plan shape is not hydraulic evidence. No unallocated remainder defaults to any surface/flow class. |

## 4. WSUD and raingarden treatment

| Aspect | Dependency map |
|---|---|
| Applies when | A confirmed treatment device/sequence is required or selected. It is separate from OSD unless the engineer explicitly confirms an interface. |
| Known input types | Confirmed contributing catchment/area/surface; selected device boundary/area and associated item (for example GIO) where applicable; report/model assumptions and targets/results as evidence; physical connection only when proven/selected; source status/revision. |
| Evidence door | CDDESIGN treatment/catchment review; `CDRG`/GIO physical items; CDCALC WSUD tab with pre/post inputs, measures and target/achieved display. |
| Consumers | Treatment review; WSUD calculation/result display; project review and selected drawing output. |
| Review / out-of-date effect | Source/measurement change is **Needs review**. Confirmed governing catchment/surface/device/assumption change makes treatment result and consuming output **Numerically out of date**; an unsupported/missing model basis is **Cannot calculate**. |
| Retained source-observed tools | `CDRG`, GIO; `CDCALC` WSUD tab; Raingarden data/mutation paths. |
| Known gaps / limits | Current source does not establish a complete report-to-device workflow, MUSIC execution/validation, or an automatic physical hydraulic link. Do not call a reported score/target a confirmed compliance result. |

## 5. Soakage / infiltration

| Aspect | Dependency map |
|---|---|
| Applies when | Soakage/infiltration is selected and its ground/site basis is available. It is an alternative/adjacent system, not a default for unallocated water. |
| Known input types | Confirmed contributing area/flow basis, selected soakage concept and documented ground/site evidence. Relevant units/reference conditions must be carried from the source; this map does not define them. |
| Evidence door | Explicit engineer/system decision. Bounded source reading found `SoakageModels` and `SoakageSizingService`, plus Auto Design references. |
| Consumers | Any selected soakage sizing/result, related drawing/detail and Project Review. |
| Review / out-of-date effect | New ground/source evidence is **Needs review**. Confirmed governing catchment/criteria/ground/device change makes a supported soakage result/output **Numerically out of date**; absent suitability basis remains **Cannot calculate**. |
| Retained source-observed tools | `Models/SoakageModels.cs`, `Services/SoakageSizingService.cs`, Auto Design references. |
| Known gaps / limits | No `CDSOAK` declaration was found in the bounded command scan. Interactive placement/editing, ground-condition workflow, connection evidence and issue output are Unknown; do not manufacture an infiltration result. |

## 6. Pumped drainage / SPS / rising main

| Aspect | Dependency map |
|---|---|
| Applies when | A pumped system/SPS is selected. It is not inferred from a low point, pit name or rising-main-looking line. |
| Known input types | Confirmed catchment/flow inputs where the selected calculation uses them; pump duty/settings; wet-well/SPS physical geometry and relevant reference levels; rising-main identity/diameter/route/destination where proven; source/standard basis. |
| Evidence door | Explicit user/system decision and physical object evidence. Source-observed Pump System tab and PumpSizing/SPS/rising-main model/detail/schedule paths provide existing concepts. |
| Consumers | Pump result; SPS detail; rising-main schedule/profile/review and selected calculation/drawing output. |
| Review / out-of-date effect | New evidence is **Needs review**. Confirmed catchment/criteria/pump-duty or wet-well/rising-main geometry/destination/level change makes consuming detail/schedule/profile/result **Numerically out of date**; missing required pump basis is **Cannot calculate**. |
| Retained source-observed tools | CDCALC Pump System tab; PumpSizing service; SPS detail/models; rising-main recognition and Pit Schedule logic. |
| Known gaps / limits | No `CDPUMP` declaration was found in the bounded command scan. A complete SPS placement/editor/control workflow, applicable council discharge path and AutoCAD behaviour are Unknown. |

## 7. Overland flow, flood and surcharge evidence

| Aspect | Dependency map |
|---|---|
| Applies when | The job’s confirmed requirements or site evidence require overland/flood/surcharge assessment. It does not arise automatically from a fall symbol. |
| Known input types | Confirmed site/surface geometry, selected existing/proposed levels/reference datum, drainage/catchment evidence, relevant requirement/source and any explicit flow path. |
| Evidence door | Engineer review of source/drawing evidence. Existing CDFALL, CDSL and slab tools can represent adjacent level/fall information but are not a confirmed overland-flow analysis route. |
| Consumers | Project Review/issue evidence and any later reviewed drawing output/check. |
| Review / out-of-date effect | New evidence is **Needs review**. A confirmed selected path/level/surface/catchment/requirement change makes a supported evidence output **Numerically out of date**; the missing analysis route means a hydraulic result is **Cannot calculate**. |
| Retained source-observed tools | `CDFALL`, `CDSL`, CDSLAB/surface-drain routes only as adjacent retained tools. |
| Known gaps / limits | No `CDOVERLAND` declaration was found in the bounded command scan. Flow-path calculation, flood/surcharge modelling, safe output and issue criteria are Missing; CE must not infer them from plan crossings, proximity or generic grade arrows. |

## 8. Profiles, schedules, details and issue review

| Aspect | Dependency map |
|---|---|
| Applies when | A selected network/system/result needs drawing representation, construction information or issue review. Output does not itself make engineering accepted. |
| Known input types | Confirmed Civil identities/geometry/levels/connections; selected schedule set/path/insertion scope; applicable calculation result and criteria; plan-label authority/presentation override; source/revision/stale status. |
| Evidence door | Existing `CDPROFILE` path/insertion route; Calculations V2 Longitudinal export/update; `PITSCHEDULE` source/review/place route; selected result/detail services; Civil Hub/Dashboard review. |
| Consumers | Long profile, pit schedule, calculation sheet, OSD criteria/detail and Project Review/issue evidence. |
| Review / out-of-date effect | New source/geometry/label evidence is **Needs review**. Only a confirmed governing object/level/topology/criteria/catchment/result/label change makes the consuming output **Numerically out of date** and eligible for deliberate regeneration. Manual display override remains separate. |
| Retained source-observed tools | `CDPROFILE`, `PITSCHEDULE`, CDCALC Longitudinal, `CDHUB`, `CDDASHBOARD`, `CDINSPECTOR`, output/detail services. |
| Known gaps / limits | Source inspection does not prove correct rendered artefacts, consistent result identity across outputs, final issue gate or AutoCAD update/Undo/save-reopen behaviour. PDF must be opened visually before acceptance. |

## 9. Water Tank interfaces — last

| Aspect | Dependency map |
|---|---|
| Applies when | A water tank is explicitly selected in its own retained workflow. It is intentionally last in this planning sequence. |
| Known interface inputs | Tank selection/type/physical dimensions and position; roof/reuse relationship where confirmed; any expressly permitted detention contribution; associated outlet/control/level evidence; council/source basis. Keep litres/volume, physical dimensions and level reference/datum labelled as stored. |
| Evidence door | `CDWT` and its active owner workflow; CDDESIGN/roof allocation/calc only consume a reviewed tank interface. |
| Consumers | Tank drawing/detail, reuse arrangement, any confirmed detention-provided capacity comparison, schedule/profile/detail/review where applicable. |
| Review / out-of-date effect | New tank/source/roof evidence is **Needs review**. A confirmed tank type/size/position/roof allocation/level/control or governing-criteria change makes related reuse/detention capacity, detail and consuming result/output **Numerically out of date**; missing approved basis remains **Cannot calculate**. |
| Retained source-observed tools | `CDWT`; WaterTank detail models/services; CDCALC Detention tab’s existing additional-storage route only after its identity/basis is reviewed. |
| Known gaps / limits | This planner does not reassign CDWT: Tim’s temporary Claude-only window ownership stands. Retention, detention credit and physical provided capacity remain different quantities; no tank is counted or excluded automatically without the applicable approved/council basis. |

---

## Cross-system safety rules

1. A physical crossing/proximity never creates a hydraulic link.
2. A report result, device label or generic storage note is evidence/proposal, not a completed system.
3. User can continue unrelated drafting while an optional system is Unknown; CE records the risk/dependency rather than inventing completion.
4. On every accepted drawing change, one operation maps to one Undo. Preview/overlay clears on Cancel/Escape and does not create a governing value.
5. Locked/Xref/REFEDIT/foreign content is inspectable where supported but never silently unlocked, copied around or connected as a live Civil target.
6. A Needs review flag does not force recalculation. A Numerically out of date result/output is retained with its prior input revision; recalculating/regenerating/applying replacement is a deliberate reviewed step. Cannot calculate names the missing/inconsistent basis without inventing a result.

## Verification status

This dependency map is Proposed and awaits review. No system calculation, AutoCAD command, window, profile, schedule, detail, PDF, save/reopen or deployed bundle was run/read as verification by this planning pass.
