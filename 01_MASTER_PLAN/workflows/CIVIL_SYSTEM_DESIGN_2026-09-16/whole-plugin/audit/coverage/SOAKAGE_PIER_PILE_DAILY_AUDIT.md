# Soakage and pier/pile daily workflow audit

FOR TIM

Both planning cards preserve their recorded limits. Soakage sizing stays separate from ground suitability and physical provision; pier/pile placement retains the approved visual choices and blocks missing approved assets.

---

## Independent evidence and disposition

Read root37 and the new structural_pier_pile_daily_placement_card.md in full. Read complete SoakageSizingService.cs and SoakageModels.cs, AutoDesignOrchestrator.cs lines152–160 and268–312, and canonical ST6-11/12. Repeated the narrow soakage search in CalculationsV2Dialog.xaml and ViewModels/*.cs; no match returned. This is a bounded negative result, not global route absence.

| Requirement / claim | Result |
|---|---|
| Sizing inputs and result shape | Verified seven scalar inputs, numerical result fields/reason and no physical identity or width/footprint field in result. |
| Method geometry | Verified inflow/depth footprint, derived width, four sides plus base, within-storm outflow comparison and emptying calculation. Root37 correctly distinguishes footprint, infiltration area, storage and actual site faces. No external method validation claimed. |
| Source module-depth catalogue | Verified fixed list. Root37 does not treat it as current supplier verification or selected engineering values. |
| Range failure | Verified validation reason with false Pass and zero numerical fields. Root37 correctly refuses to interpret these failure zeros as no storage required; this audit does not claim validation is exhaustive for every numeric representation. |
| Existing branch and summary | Verified optional Size invocation, warning on false Pass and summary fields/wording. Existing route is preserved without claiming UI placement or suitability proof. |
| Ordinary soakage flow | Explicit investigation/test applicability, allocation, method basis, physical candidate, result, location/overflow and provision/output. No invented soil values, implicit infiltration suitability, nearest connection, automatic placement or default detail. |
| Revision and Cancel | New test evidence prompts applicability review; confirmed governing change invalidates actual consumers. Historical basis remains visible, unknown route cannot become a fabricated command, and accepted drawing work retains its own boundary. |
| Bored-pier ordinary placement | Approved alias family retained; At cut green/solid versus Below yellow/hidden and approved diameter/hatch choices match ST6-11. Card does not select capacity/depth/diameter for the engineer. |
| Screw-pile/stump placement | Individually Approved bundle asset required; missing asset blocks without approximate circle, substitute or working-folder fallback, matching ST6-12. |
| Daily edit/partial/reopen | Selected compound scope, separated presentation versus supplied values, explicit COPY identity, preview freshness, partial receipts and separate persistence evidence are proposed honestly. |

No material correction found in this bounded readback. No hydraulic execution, manufacturer/standards validation, native UI inspection, build, deployment or overall completion claim.

## Next useful depth

Root is reconciling the existing DesignPackage/PumpSizing route with the legacy scalar calculator; that is useful because entry and result purpose must be explicit to a drafter. After that, the parent J overland-flow record remains a candidate for an ordinary trace/review sequence: select the actual route and evidence, review levels/datum/barriers and named destination, keep unsupported hydraulic/safety assessment visible, and generate only a clearly scoped representation. This must not invent an overland solver or safety criterion.
