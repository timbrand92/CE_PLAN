# Soakage — investigation, sizing and actual provision

FOR TIM

Begin with the ground investigation and confirmed contributing area. A soakage calculation can compare a stated method's figures; it cannot decide site suitability or prove that the proposed module and overflow are actually drawn.

## Authority and scope

Proposed ordinary workflow expands parent specialist_workflow_details I3 and preserves source-first/manual-control rules. No generic soil rate, setback, groundwater clearance, module size, safety factor, emptying threshold or authority approval is invented. No new CDSOAK command or existing interactive placement path is assumed. Existing Design Package/system identity is reused where available; no duplicate package. Water Tank remains separately owned and last.

## Read-only evidence and exact limit

Inspected17September2026 in root `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage`: complete Services/SoakageSizingService.cs and Models/SoakageModels.cs; Services/AutoDesignOrchestrator.cs:152–160 and268–312. Bounded search of Drainage *.cs found branch invocation and input/result records. No soakage match was found in the specifically searched CalculationsV2Dialog.xaml/ViewModels surfaces; that is not proof of absence throughout the plugin.

| Source | Observation | Planning consequence |
|---|---|---|
| SoakageModels inputs:26–33 | Area, runoff coefficient, intensity, duration, soil infiltration rate, module depth and length | Record each input's actual applicability/source and units. The scalar record does not carry a geotechnical approval decision by itself |
| SoakageSizingService:80–120 | Computes inflow; derives footprint/width from inflow/depth/length; assumes infiltration over four sides and base; compares outflow with inflow | State method assumptions and qualification. Calculated infiltration area is not plan footprint and is not evidence every face can infiltrate on this site |
| Same service:48–65 | Exposes a fixed list of module depths | Source catalogue values are not independently verified product availability or engineering choices; do not auto-select one for the job |
| Same service:142–177 | Range checks return failing result with reason and zero-valued numeric fields for invalid input | UI must distinguish Invalid/ Cannot calculate from a valid numerical zero. A result record carrying zero is not proof no storage is needed |
| SoakageModels result:56–63 | Result stores volumes, infiltration area, emptying time, pass flag, net required storage and reason; no physical identity or width/footprint fields | Physical-module selection and traceable geometry require explicit integration/derivation evidence; do not assume the result itself identifies a drawn system |
| AutoDesignOrchestrator:152–160 | Optional soakage branch calls Size and adds warning if not Pass | Existing branch solver exists; preserve it. Source invocation does not prove user-facing route, suitability checks or complete design acceptance |
| Same orchestrator:294–305 vicinity | Summary prints soakage volumes, infiltration area, emptying time and PASS/DOES NOT PASS | Output wording must identify the bounded comparison. Source's PASS does not establish geotechnical, site or authority compliance |

Method-validation comments in source were read but not independently verified against the named spreadsheet, manufacturer or current standards. No service was executed and no physical design is endorsed by this planning.

## Ordinary end-user sequence

| Step | What is shown and prepared | What remains deliberate |
|---|---|---|
| Identify the proposed soakage system | Selected job/catchment and existing proposal/package; actual known physical footprint if any | Soakage is selected because of confirmed design intent, not assigned to an unclassified remainder or leftover runoff |
| Review investigation and suitability | Relevant report/page/revision, test location/depth/units, stated applicability and any limitations; known groundwater/site constraints where supplied | Record the engineer's suitability basis. A soil description or infiltration rate alone is not a suitability approval |
| Confirm contributing portions | Existing catchments, allocated portions, surface classes and source/manual basis | No double count with another outlet/treatment system, no unknown DP automatically allocated |
| Review calculation basis | Applicable method/version, rainfall event/intensity/duration, coefficient, confirmed infiltration-rate basis and geometry assumptions | Unknown or unsupported method assumptions mean Cannot calculate for that basis; no default rate or interpretation of ambiguous units |
| Review physical candidate | Actual/selected module depth and length, expected footprint/width derivation, construction evidence and available site envelope | A retained sizing calculation does not select a current product or construction detail. Unsupported/unmatched asset stays unresolved, not approximated |
| Compare result and assumptions | Inflow/outflow, named infiltration surface, storage/emptying figures and exact limited comparison, alongside unresolved suitability | Do not relabel a passing within-storm comparison as approved site design. A supported calculation can still need separate suitability/physical review |
| Review location, inlet and overflow | Selected/drawn evidence boundary and exact confirmed source/destination identities, existing levels/datum and applicable constraints | No inferred hydraulic link, nearby outlet or safe-overflow claim. Any required overflow assessment needs its own confirmed method/basis |
| Confirm actual provision and output | Reviewed physical geometry/capacity, selected construction detail, calculation/input identity and source status | Use the existing owner route only when qualified. If placement route is unavailable, retain the reviewed proposal and state that actual provision is not established |

Main groups: **Investigation**, **Catchment and sizing basis**, **Physical provision**, with one large source-page/plan preview and visible Show source, Review inputs, Show on plan, Review result and existing qualified owner actions. These are proposals, not extra mandatory stage tabs. Critical missing suitability/input/overflow evidence stays visible; More contains method workings and source history.

## Comparing method geometry with drawing geometry

Keep plan footprint, module depth, storage volume and infiltration surface as separate quantities with units. The inspected method derives its width and counts four sides plus base; the actual plan boundary and usable faces may differ. Show those differences. Do not stretch a merely similar block to imply a verified proprietary detail, or change the physical footprint solely because a scalar result exists.

If the applicable design needs constraints the retained service cannot represent, show the limitation and retain a separately documented qualified assessment. Do not add a silent factor, ignore the constraint or declare the code's method suitable by default. A manual governing input retains its source/reason and review status; it cannot waive a missing method without an explicit engineering decision outside this planning.

## Revision and cancellation

A new investigation or test is a candidate and reopens relevant suitability review. Retaining a confirmed rate/pin preserves its previous basis visibly; adopting a changed governing rate/geometry/area makes actual consuming results out of date. A changed investigation location may affect applicability even when its numeric rate is unchanged.

Cancel a proposed boundary/input review retains the prior confirmed record and clears temporary overlays. Previously accepted drawing actions keep their own receipt/Undo boundary. An unavailable drawing route is not a reason to invent a CDSOAK command or call the design installed. Reopen must distinguish saved proposal, actual physical object identity, governing inputs and historical result; no link reconstructed from proximity.

## Fictional representative review

Start with an investigation report, confirmed roof portion and a candidate module footprint, with one uncertain test applicability and no confirmed overflow. Review the exact test/page and leave applicability unresolved while other drafting continues. Once a proper basis is provided by the engineer, compare supported method assumptions against the actual geometry. Keep infiltration surface distinct from footprint. Inspect the bounded result and its limitations; select only a qualified physical/detail route and preserve unresolved overflow. Change the report revision, then the adopted infiltration rate in separate steps: suitability review first, numerical invalidation only when governing inputs change.

Future qualification must also cover invalid input returning zero-valued failure fields, geometry/result mismatch, unknown units, incomplete catalogue detail and save/reopen identity. No native test, manufacturer validation, geotechnical recommendation or standards calculation occurred in this block.
