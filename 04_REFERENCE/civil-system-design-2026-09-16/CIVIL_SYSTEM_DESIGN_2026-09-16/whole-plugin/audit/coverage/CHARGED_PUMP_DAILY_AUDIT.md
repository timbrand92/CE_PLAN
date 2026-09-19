# Charged and pump ordinary design — bounded audit

FOR TIM

The proposed sequence correctly separates wet-well storage from proof that a real pump works at the required duty. No material correction was found in this readback.

---

## Actual evidence

Read root36 in full, complete current-checkout ChargedSystemCalcViewModel.cs, PumpSystemCalcViewModel.cs and CalculationBaseViewModel.cs, plus CalculationsV2Dialog.xaml lines616–783. This was source/document inspection only; no calculator, hydraulic model, UI, AutoCAD or standard was tested or validated.

| Claim / workflow requirement | Independent finding |
|---|---|
| Source presets and constructor calculation | Verified in both models. Root36 correctly refuses to treat them as confirmed job inputs. |
| Charged route scope | Recalculate consumes scalar inputs, not network identity/branches. Proposed exact-route review and unsupported mixed arrangements are correctly labelled integration proposals. |
| Friction units | FrictionLoss receives helper result multiplied by length; XAML displays m/m. Bounded source mismatch recorded accurately, without claiming native reproduction. |
| Invalid charged inputs | Main early-return checks only coefficient/intensity/area/pipe diameter; helper returns zero for nonpositive arguments; parsing falls back to zero. Root36 does not claim exhaustive source validation. |
| Residual head and inlet coefficient | Negative remaining head clips to zero; a fixed inlet coefficient is used. Proposed visible deficit/applicability review does not approve these assumptions. |
| Pump ARI | Setter recalculates, but the calculation does not read Ari or retrieve rainfall. Proposal explicitly preserves event/source review. |
| Pump calculation scope | Effective catchment, rainfall duration, entered pumping volume and site minimum produce storage. No pump curve/duty selection is performed by this method. Root36 keeps that distinct from real equipment and usable physical volume. |
| Pump fallback and clamp | Coefficient clamped; nonpositive duration replaced. Proposal requires explicit invalid/Unknown handling, without adopting those substitutions. |
| Retained results | Early invalid-input return does not clear earlier result properties; base only changes warning collection/notifications. Proposal retains historical basis rather than presenting those numbers as current. |
| Ordinary charged production | Explicit system/route, flow, datum/head, losses, bounded comparison, selected drawing-owner change and reviewed readback. No inferred connections or automatic resizing. |
| Ordinary pump production | Explicit wet well/destination, inflow basis, assumed/documented pump flow, separate duty evidence, controls/storage basis, physical provision and owner output. No automatic equipment choice or control philosophy. |
| Revision/output | Candidate evidence versus governing change, draft versus confirmed results, invalid-input historical results and different output purposes remain separate. No blanket compliance claim. |

Disposition: no material correction found for this bounded planning/source readback. It is not whole-plugin completion or native acceptance.

## Next useful production depth

- Structural: ST6-11/12 bored-pier At cut/Below and approved screw-pile/stump asset placement, with missing-asset blocking and no approximate substitute. Existing first-foundation card explicitly covers different routes.
- Civil: specialist I3 still needs an ordinary investigation/suitability → confirmed sizing basis → actual soakage provision/overflow sequence, explicitly respecting that a placement command has not been established. No geotechnical values or suitability decision should be invented.
