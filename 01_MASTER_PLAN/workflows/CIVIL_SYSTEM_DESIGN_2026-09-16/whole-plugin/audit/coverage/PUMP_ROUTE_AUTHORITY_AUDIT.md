# Pump route authority reconciliation audit

FOR TIM

The two pump routes are correctly kept distinct. One event-label detail needs correction: the entered event, council-adjusted event and rainfall curve actually evaluated can differ.

---

## Evidence and verified claims

Read root38 in full; complete PumpSizingService.cs, PumpModels.cs and DesignPackageModels.cs; RationalFlowService.cs151–211, coefficient-table references and Bracket341–369; AutoDesignOrchestrator pump invocation160–172. Root36 legacy route was independently read in the preceding audit.

- Pump branch calls the retained service and returns scalar result/notes in the existing package; no new physical identity or persistence proof is invented.
- Service uses fixed runoff assumptions, its duration list and the two-argument static rainfall path.
- Wet-well volume is computed using one selected duty; duty is then reselected without recomputing that volume. Root38 appropriately calls this a dependency-consistency concern, not a demonstrated numerical failure.
- Static rise offset and suggested diameter are fixed source rules; rising-main length is validated/reported but not used for route friction calculation here.
- Ladder exceedance returns the largest duty with a warning. Proposal correctly requires the unresolved custom-equipment qualification to remain visible.
- Ramp branch produces a flow figure, not overland route/safety proof.
- Purpose/input comparison before volume comparison, deliberate governing result, retained historical record, and common output authority are clear proposals. No automatic retirement or new engineering engine is authorised.

## PUMPROUTE01 — medium

File: root38 rainfall/event comparison contract.

The displayed effective event can still misdescribe the evaluated rainfall basis. PumpSizing resolves an ARI, but GetIntensity brackets the static table; Bracket clamps outside its range and interpolation occurs between available curves. Source table and helper were read directly, not inferred from comments alone. Root38 currently mentions effective ARI/static source without exposing this final selection distinction.

Required proposal: show requested event, council-resolved event and actual curve/bracket/clamp/interpolation status separately. A substituted boundary curve must not silently carry an exact requested-event label. Unqualified applicability remains unresolved. This records current source behaviour and proposes honest presentation; it does not authorise a new interpolation rule or numeric design assumption.

Finding sent root. No numerical experiment, native test, engineering validation or whole-plugin completion claim.

## PUMPROUTE01 closed — 2026-09-17T01:20:47.5951468+10:00

Read actual added source row and Rainfall evaluation display requirement. Requested event, council-resolved event and evaluated curve/bracketing/interpolation/clamp are now separate; unsupported exact-event claims are excluded and no new clamp-acceptance policy is introduced. Closed at planning-proposal level, without numerical or native execution.

