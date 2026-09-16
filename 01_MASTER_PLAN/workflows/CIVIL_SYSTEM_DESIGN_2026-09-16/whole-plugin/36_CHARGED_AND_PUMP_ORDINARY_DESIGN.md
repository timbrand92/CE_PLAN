# Charged and pumped drainage — ordinary design review

FOR TIM

Start with the actual catchment and route. Review the head, losses and equipment basis, then compare the result with the selected pipe or wet well. A calculator result alone must not claim that a pump has been selected or validated.

## Authority and status

Expands parent specialist_workflow_details H1/H2, root15 method authority, root25/26 draft/result boundaries and root32 drawing selection. Existing CDCALC Charged System and Pump System routes remain. No new command, engineering method, control philosophy, equipment choice or numeric default is approved. Existing item/pipe/SPS/Water Tank owners remain unchanged; Water Tank stays last. This is a source-qualified planning proposal, not a product change or engineering verification.

## Bounded source observations — current checkout only

Read17September2026 under `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage`: complete ViewModels/ChargedSystemCalcViewModel.cs, PumpSystemCalcViewModel.cs and CalculationBaseViewModel.cs; Dialogs/CalculationsV2Dialog.xaml616–783. No native/runtime calculation ran and no current standard was validated. Source constants and external-code labels below are observations, not endorsed rules.

| Source observation | User-visible planning consequence |
|---|---|
| Charged model:8–16 and Pump model:7–14 contain pre-filled example-like inputs; constructors recalculate | Opening must not represent those values as confirmed job data. Identify them as unadopted/unverified until supplied by reviewed project/manual evidence |
| Charged model:112–153 calculates from scalar catchment/pipe/head/loss inputs; no physical route identity or branch selection is represented in that method | The proposed route review is a required owner integration, not already proven by the calculator. A network drawing cannot silently be reduced to one representative pipe |
| Charged model:133–140 multiplies the friction-gradient result by pipe length, then adds minor loss. XAML:672–674 displays the resulting FrictionLoss with m/m | Unit/presentation discrepancy in this inspected binding: distinguish friction gradient from total friction head. Owner must qualify/correct before output acceptance. No native reproduction claimed |
| Charged model:124–128 early-return warning checks only certain positive inputs; CalculateHazenWilliams:158–159 returns0 for nonpositive roughness/diameter/flow; Parse:165–171 returns0 on failure | Invalid roughness/length/loss/head/diameter state must remain explicit; an unsupported or invalid basis cannot become zero loss or a current successful comparison |
| Charged model:142–148 clips negative remaining head and uses a fixed inlet coefficient for QMax | Show shortage and applicable coefficient/method basis; never silently approve those source assumptions as universal geometry/equipment rules |
| Pump model:111–137 uses entered pump flow, catchment/rainfall/duration, a fixed pumping interval and site-area-based minimum to produce a selected wet-well volume | This is the inspected storage calculation scope. It contains no pump-curve/head-loss equipment selection in this method. SelectedWetWell is a computed figure, not a confirmed physical wet well |
| Pump model:45–50 ARI setter triggers recalculation, but Recalculate:111–143 does not read ARI | Changing the ARI field alone does not demonstrate a corresponding rainfall selection/change. Show the adopted rainfall event/source explicitly; no implied automatic IFD lookup |
| Pump model:125–129 clamps coefficient and substitutes a fixed storm duration when parsed duration is nonpositive | Invalid/Unknown input needs visible review; no quiet replacement policy is authorised by this source behaviour |
| Both methods warn and return early on some invalid inputs without clearing result properties; base ResetWarnings changes only warning collection/status | Earlier numeric results can remain in those properties. Target must label retained results by their old basis and invalid/current status, not present them as freshly calculated valid values |

These are concrete planning findings for the calculation owner, not changes made here. No global absence of other services or newer owner work is asserted.

## A. Charged system: select route, then compare head and capacity

| Drafter's step | Large preview and proposed controls | Required boundary |
|---|---|---|
| Select the system | Named roof/catchment portions, confirmed DPs, physical pipe route and destination. Select on plan follows root32. | No route from nearest line, pipe crossing or matching label. Unknown connections remain visible |
| Review route basis | Exact member identities, lengths, diameters/material source and relevant reference levels/datum. Show excluded/bypass branches separately. | Mixed diameters/parallel branches cannot silently become one length/diameter. If the retained method cannot represent the arrangement, show Unsupported basis and retain another qualified assessment route |
| Review design flow | Confirmed contributing portions, rainfall event/intensity/source and runoff basis. Compare any manual pin with candidate source value. | No unapproved generic curve/coefficient or equal allocation; candidate area adoption remains separate |
| Review available head | Named upstream/downstream reference roles and levels, datum and chosen governing head, with manually supplied basis visible. | No silent datum conversion or lowest/highest point rule. Missing reference prevents a supported head comparison |
| Review losses | Named roughness/material basis, friction gradient versus total friction head, selected fittings/minor-loss basis and inlet assumptions supported by the method. | Zero fittings/loss is not a default for unknown route detail. No guessed coefficients or inlet shape |
| Compare calculation | Design flow, supported capacity comparison, total losses and available/residual head, with basis/currentness and specific limiting reason. | Bounded check is not blanket system compliance; deficit remains visible rather than disguised as available zero head |
| Choose a drawing change | Open the existing selected pipe/item owner with exact proposed scope, then refresh reviewed route after accepted change. | No automatic resizing, downsizing, reconnection or rewriting of manual labels. Result and actual drawing remain separate until read back |

Main shows system/route identity, source status, flow/head/loss comparison and large plan/profile preview. More holds detailed fitting/assumption evidence and method limitations. Essential unsupported arrangement or missing datum stays on Main. Exact controls are proposed; no alternate engineering engine is introduced.

## B. Pumped system: separate storage calculation from equipment duty

| Drafter's step | Proposed review | Required decision/result |
|---|---|---|
| Identify wet well and destination | Exact local SPS/wet-well identity, contributing catchment, rising-main route and explicit receiving destination | Pumping is an explicit system choice, not inferred from a low point; crossing a pipe does not connect to it |
| Review site inflow basis | Total/impervious/pervious and Unclassified state, adopted rainfall intensity/event/duration and runoff coefficients with source/purpose | Confirm area reconciliation and event basis. Entered ARI cannot imply automatic rainfall lookup in the retained source path |
| Review pump-flow basis | Entered/adopted pump flow with source, duty reference, equipment identity if actually selected, and Unknown head/curve status where unresolved | Flow may be a design assumption or documented duty. It is not proof that a real pump delivers it against this system |
| Review rising-main and duty evidence | Actual route, diameter/material, elevations/datum, relevant losses and receiving condition; show manufacturer/engineer duty evidence if supplied | Retained storage calculator does not establish pump-curve/system-curve compatibility. Missing/unsupported assessment remains separate and visible |
| Review controls and storage assumptions | Confirmed start/stop/alarm/reference levels, duty/standby arrangement if supplied, operating/storage intervals, minimum-storage authority and manual requirements | No invented control philosophy or generic minimum based only on source code. Unknown criteria stay unresolved |
| Inspect retained storage result | Effective catchment, inflow volume, pumping-volume assumption, additional/minimum/calculated storage and chosen requirement; show units and method/source | Computed selected volume is labelled a calculation result. It does not create, select or verify physical wet-well geometry |
| Compare actual provision | Selected wet-well geometry and usable storage for the reviewed level range, supported equipment/duty and drawings/details | Capacity or levels not established remain Unknown. Separate geometry, operating volume and equipment adequacy; no tank reuse/detention credit crossover |
| Prepare actual change/output | Open the relevant existing pit/SPS/pipe/detail owner with reviewed target, then read back and update the appropriate result/output | No automatic equipment selection, controls design, creation of rising main or council discharge approval |

Showing an unsupported duty assessment does not stop unrelated drafting or wipe useful storage work. It prevents the partial calculation being labelled a complete verified pump system.

## C. Draft, revision and output

Changing an input may update a labelled draft preview where the retained calculator supports it. It does not adopt source evidence or write drawing geometry. Confirmed results retain exact recorded input/source/method versions; new candidate evidence prompts suitability review, adopted governing changes make actual consumers out of date.

If a required input becomes invalid, retain the old result only as historical/old-basis data with Cannot calculate for the current proposal. Do not leave the same normal result styling while only a small warning changes. Manual required values and unaccepted edits remain distinct.

Use a reviewed selected-result output contract. A note/PDF must name whether it presents charged-flow checking, wet-well storage, externally assessed equipment duty or actual drawing provision. No one combined success label substitutes for missing methods or evidence. Criteria, profile, schedule, PDF and issue history remain separately owned outputs. Root15 export limitations still apply.

## Fictional ordinary acceptance scenarios

1. Charged roof route has known pipe geometry, one unknown fitting basis and an unrelated crossing pipe. Review exact scope; no inferred connection or zero-loss substitution. Supply a reviewed fitting basis, compare head/capacity, propose one pipe change and verify drawing readback before refreshing the result.
2. Charged arrangement branches into different diameters. Show method applicability limitation; do not reduce it silently to one diameter or claim the scalar route proves the whole network.
3. Pumped basement example has wet-well geometry and a nominated pump flow but no manufacturer-duty evidence. Review storage separately, leave equipment adequacy Unknown, and preserve the actual rising-main destination.
4. Change the displayed ARI without changing rainfall evidence: do not imply a different rainfall event was automatically obtained. Change duration to invalid: no quiet replacement or current result.
5. After a valid result, clear a required field, then Cancel and reopen. Old result/input identity and current invalid draft remain distinguishable; no source/drawing changes from inspection.

Built: no plugin change. Tested: read-only source inspection only, no hydraulic execution or AutoCAD. Installed: nothing. Tim-accepted: existing requirements only; these interaction proposals await review.
