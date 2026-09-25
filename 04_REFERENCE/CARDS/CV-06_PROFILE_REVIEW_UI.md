# CV-06 — linked profile review in Calculations

**Status:** Managed implementation; native AutoCAD acceptance pending.

## Approved workflow

1. `CDPROFILE` asks for one starting CE pit, then opens the existing Calculations window on its dedicated **Longitudinal Review** page. The normal `CDCALC` Longitudinal page remains unchanged.
2. Inspection reads a detached current-drawing snapshot and lists every reachable route. No route is selected automatically; a branch always requires an explicit route choice.
3. The user chooses the exact schedule set, datum and whole horizontal/vertical scales. Vertical exaggeration is displayed as horizontal scale divided by vertical scale.
4. **Preview New** asks for the final insertion point. **Preview Update** asks for the exact linked profile. Both capture immutable evidence through the single profile evidence adapter.
5. Ready, Unknown, Refused and Stale remain distinct. Unknown values display as `Unknown`; a real zero displays as `0.00`. The accepted Preview shows either the exact New insertion coordinates or the exact Update handle and frozen block position. Only Ready enables **Apply**.
6. Apply disables and consumes that exact Preview before it crosses into the writer. The adapter recaptures the drawing evidence and calls the strict writer in one transaction; only an Applied result commits.

## Safety boundary

- Opening and inspecting never call the legacy drawing-data migration or `ProjectDataService.Current` path.
- Route, schedule set, datum, either scale, target, refresh, selected pit or drawing context changes invalidate the accepted Preview before any AutoCAD prompt. Refresh and Apply also prove that the original drawing is still active before touching it.
- A reviewed LPD label comes only from the complete stored LPD authority set.
- The existing `LongitudinalSectionViewModel` and public legacy writer methods remain available internally; the new page does not use them as a second evidence or drawing path.

## Automated checks

- Pure view-model tests cover explicit route selection, distinguishable parallel-pipe branches, Unknown display, true zero, exact New/Update target summaries, input/drawing invalidation and one-use Apply on success, refusal or exception.
- Production-boundary checks prove `CDPROFILE` uses only the profile adapter wrappers and does not call `EnsureDrawingDataCurrent`, `ProjectDataService.Current` or open its own transaction.
- Managed compilation validates the existing-window XAML bindings and event handlers.

## Native AutoCAD acceptance

Test one straight route and one branched route: Cancel at pit/insertion/target selection; Unknown level; Preview New; Preview Update; input change after Preview; drawing switch; stale pipe/target; locked layer/Xref/REFEDIT refusal; Apply; one Undo; save/reopen and re-preview.
