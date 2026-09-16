# Pump results — reconcile retained calculation routes

FOR TIM

The existing Pump System calculator and auto-design pump branch do different work. The window must say which result is being reviewed and what it proves, rather than present two competing answers as one approved design.

## Scope and authority

Source qualification supporting root36, not a second proposed pump engine. The approved common-authority direction and per-job rainfall/source rules govern the target. Existing sound routes remain until their owners reconcile behaviour and native acceptance; this overnight does not retire, replace or modify either. No source formula, office ladder, council override or standards comment is adopted as a new engineering rule.

## Actual bounded evidence

Read17September2026 in root `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage`: full Services/PumpSizingService.cs, Models/PumpModels.cs and Models/DesignPackageModels.cs; AutoDesignOrchestrator branch/summary lines already named in37; RationalFlowService.cs:151–211 plus coefficient/source declarations identified by bounded search. Root36 separately covers the complete legacy PumpSystemCalcViewModel. None was executed.

| Route / function | Observed scope | User-facing consequence |
|---|---|---|
| CDCALC Pump System view model | Entered rainfall intensity/duration, pump flow and surface areas produce a wet-well storage figure; ARI not consumed by its calculation | Show entered basis and storage-result scope; do not imply equipment selection or automatic rainfall retrieval |
| AutoDesignOrchestrator optional pump branch | Calls PumpSizingService.Design with PumpInputs and returns PumpDesign in existing DesignPackage | Reuse package identity and result; a separate pump proposal object/window must not become a competing untracked authority |
| PumpSizingService:174–209 | Resolves an effective ARI, uses fixed runoff assumptions, sweeps listed durations through RationalFlowService.GetIntensity | Compare effective event and actual rainfall source/zone with the confirmed job basis; a source council override is not new Tim approval |
| RationalFlowService:174–208 | Two-argument GetIntensity selects its static coefficient arrays; no job coefficient block is an argument in this inspected path | The observed call does not establish per-job rainfall support. Retained named office curve may be appropriate only under its confirmed applicability; do not silently use it for another location |
| Same service:151–188 | Documented/implemented bracketing supports interpolation and edge clamping of requested event | Show requested ARI, council-resolved ARI and actual evaluated curve/bracket/interpolation/clamp status separately. A displayed effective ARI alone cannot prove an exact matching event; unsupported range must not masquerade as a qualified exact event |
| PumpSizingService:221–244 | Computes storage using an initially selected duty, then reselects duty from refined storage without recomputing that storage after reselection in this method | Returned duty/storage pair needs explicit consistency qualification. This is an inspected dependency concern, not a reproduced numerical failure or an approved replacement formula |
| Same service:246–261 | Uses a fixed working-level offset for static rise; picks rising-main diameter by duty threshold. Length appears in notes and validation, not a route friction-loss calculation in this method | Static rise and suggested diameter are not a complete total-dynamic-head/pump-curve assessment. Retain actual route and external/qualified duty evidence |
| Same service:315–328 | If duty ladder is exceeded, returns its largest entry with a warning note | Returned numeric duty is not proof a standard pump satisfies the requirement. Show custom selection required; do not hide warning behind a successful result record |
| Same service:264–270 | Optional ramp branch computes a flow figure for the source's chosen event | A flow result does not prove the overland route, capacity or flood safety. Root specialist J evidence/method limits remain |
| PumpModels / DesignPackageModels | Input/result records carry scalar fields/results and notes, with optional branch outputs in the existing package | Product source names/comments do not establish all required identity, rule approval, equipment evidence or persistence is present |

## Proposed comparison at the window boundary

When opening an existing result from either retained route, show:

- **Purpose:** storage estimate, design-branch proposal, externally assessed equipment duty, or confirmed physical provision.
- **Basis:** selected job/system, adopted area/classification, rainfall source/zone/event/duration, pump-flow assumption or selected duty, level references and method/rule version.
- **Rainfall evaluation:** requested event, any council-resolved event, and actual evaluated curve or bracketing/clamping/interpolation outcome. Review method applicability before accepting an approximated/limited-range event; no new extrapolation or clamp-acceptance policy is introduced.
- **Status:** draft/confirmed historical/current to named basis, unsupported inputs/assumptions and exact unresolved warnings.
- **Relationship:** the existing selected DesignPackage/result identity and the actual drawing objects where explicitly linked; Unknown where linkage has not been established.

If both routes exist for the same system, compare them by purpose and governing inputs before comparing volumes. Different area meanings, rainfall durations, pump flow or minimum-storage assumptions are shown as differences, never averaged or resolved by newest timestamp. The engineer/owner selects a reviewed governing method/result under existing authority; opening a newer route does not replace the prior decision.

## Proposed reviewed handoff

1. Start from the exact selected system/package and its known result; inspect source-qualified differences.
2. Resolve actual applicable job rainfall and rule basis without adopting source constants as defaults. Unsupported needed inputs remain unresolved.
3. Review the method's result, internal consistency and warnings. A ladder-limit note or unverified duty/storage pair prevents a complete verified pump-system claim.
4. Deliberately record the governing result with purpose and source version through the existing owner. Keep superseded result readable as history, not a second active result.
5. Pass that same reviewed result to existing wet-well/rising-main/detail/schedule output owners. No re-computation through another route with different hidden assumptions during output.
6. After an accepted physical change, verify actual provision against the recorded result. A pipe diameter suggestion never proves a installed/selected product or manufacturer duty point.

The exact user doorway and implementation consolidation remain owner work. No new compulsory method picker, automatic engine migration or active-task change is authorised by this planning. The display contract can be met in existing reviewed surfaces.

## Future evidence required before native acceptance

Compare both routes for one fully specified fictional system with identical intended basis; document why outputs agree or differ rather than requiring arbitrary equality. Include a job-specific rainfall block versus the named office curve, explicit same-purpose area basis, changed ARI, ladder exceedance, final duty/storage consistency, and a rising-main-length change. Verify output uses the selected governing result, not a hidden alternative. Validate engineering method/rule authority separately before interpreting those checks as design approval.

No code change, build/test, numerical experiment, current-standard verification, equipment recommendation or native action occurred. This record preserves the identified gaps for the existing calculation owner.
