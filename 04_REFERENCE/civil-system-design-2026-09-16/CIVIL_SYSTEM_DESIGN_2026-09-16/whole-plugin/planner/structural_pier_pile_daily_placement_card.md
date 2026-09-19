# Structural daily bored-pier, screw-pile and stump-footing placement card

**Planning checkpoint:** 2026-09-17T01:15:56.6264639+10:00. This card deepens approved [ST-06 Foundations and rebar](C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-06_FOUNDATIONS_REBAR.md) ST6-11 and ST6-12: one retained bored-pier engine for **BP / SPW / SPW3 / SPW6 / SPWC** aliases, plus approved-asset placement for **SCREWPILE** and **STUMPFOOTING**. It does not choose capacity, depth, mark, diameter, library row or engineering value.

> **Read with:** [first foundation placement card](structural_foundation_first_placement_card.md), [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md) W5, [approved reconciliation](structural_approved_card_reconciliation.md), and [workflow cards](structural_workflow_cards.md) W5. The ST6-11 visual choices are existing approved rules; Main/More arrangement and lifecycle wording are proposals pending implementation evidence.

## Retained discovery and asset gate

| Daily entry | Required visible state | Boundary |
|---|---|---|
| **Foundation workspace: bored pier aliases** | Familiar `BP`, `SPW`, `SPW3`, `SPW6` and `SPWC` remain discoverable but lead to one bored-pier engine. The header shows alias used, selected/drawn local location, drawing/view/level and supplied source/Manual/Unknown fields. | Aliases do not create different engineering engines or silently different defaults. No nearby geometry/label establishes a mark, size, depth or source. |
| **Foundation workspace: screw pile / stump footing** | Before the location point is accepted, show the individually Approved AS-01 asset identity/status from the Plugin bundle, selected drawing/view/level and supplied source/Manual/Unknown fields. | If the required Approved asset is missing, block placement honestly. Never draw an approximate circle, substitute another asset, or use an asset from `C:\Lisp Files`. |
| **More: asset and identity review** | Show asset identity/version/status, selected compound identity, source/revision, Manual/Designed reason and any existing label position. | Inspection does not approve an asset, invent a library entry or replace an existing placed graphic. |

## Main first-placement sequence

| Step | Bored pier engine — BP/SPW aliases | Screw pile / stump footing | Output boundary |
|---|---|---|---|
| **1. Select/draw location** | Select or draw the intended local driver/location. Preselection is supported only where the route accepts it; otherwise pick the actual location. | Verify Approved asset first, then select/pick the intended local location. | Xref, REFEDIT, locked and unsupported content remain protected. A nearby circle or label is not a placement point or existing foundation identity. |
| **2. Choose supplied information and visual state** | Choose supplied type/mark/size/depth/source state. Show the exact approved state choices: **At cut — green/solid** or **Below — yellow/hidden**, and the approved pier-diameter choices **300 / 450 / 600** plus approved hatch state. | Choose supplied type/mark/size/depth/source state; asset identity remains visible. | The approved visual choices do not establish capacity or select a diameter. Missing size/depth remains Unknown, never zero or a historical/default guess. |
| **3. Inspect complete live preview** | Preview driver/location, approved state/color/linetype, diameter choice, hatch state, label/design data and orientation where relevant. | Preview the exact Approved asset, driver/location, label/design data and orientation where relevant. | Preview names selected asset or bored-pier state and all compound parts. It is not a calculation/suitability result and cannot silently substitute graphics. |
| **4. Apply/repeat** | Apply one compound; permit repeated deliberate local placements with the selected approved visual state. Esc cleanly ends the repeat sequence. | Apply one compound; repeat only by explicit next location while the Approved asset remains available. Esc cleanly ends the repeat sequence. | One accepted placement is one future Undo target. It does not create a schedule, adopt nearby legacy geometry or alter other foundation elements. |

## Later edit, copy and output review

| User action | Proposed visible result | Preservation rule |
|---|---|---|
| **Select existing pier/pile/stump compound** | Show stable identity, driver/location, exact current visual state or asset identity, source/revision and Manual/pinned label presentation. | A loose label/circle/line is not the compound. No nearest-text or layer-only reconstruction. |
| **Edit visual/presentation or supplied values** | Main separates label/position formatting from a requested type/mark/size/depth/source edit. More shows Before/Current/Pending and output scope. | Editing label presentation preserves ownership and cannot silently change embedded basis. A value edit is explicitly reviewed with Confirmed/Manual/Unknown provenance; no new value is derived. |
| **Move** | Preview only the selected compound moving with its owned label/graphics. | MOVE updates selected group only. It does not move a background object, another pier/pile, a schedule view or a shared host by proximity. |
| **COPY** | Preview source/destination identity and exact destination drawing/view/level. For screw/stump output, recheck the required Approved asset before placement. | COPY creates a fresh foundation identity; it does not silently copy approval/source basis or make a duplicate claim. Missing asset blocks the new copy without changing the source compound. |
| **Erase/recovery** | More names **Element only** or **Entire system** with exact count before Apply, then reports actual selected outcome. | Do not broaden deletion from a selected pier/pile/stump. Existing generic FDELETE behavior is not treated as the approved replacement. |

## Cancel, missing asset, partial and reopen contract

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Esc before Apply | No new driver, compound, asset reference or label is created. |
| Missing or invalid Approved asset | Placement is blocked with asset identity/status and selected location retained for review. There is no circle fallback, substitute block, asset-path search or implicit later retry. |
| Asset/source/location changes while preview is open | Mark the preview Needs review and disable Apply. Show Before/Current/Pending, then Refresh, Park, Discard or Cancel; do not apply stale graphics. |
| Partial compound receipt | Report driver/location, graphics/asset, label/design-data and source/approval state separately. Do not repeat a possibly placed item or rebuild from a nearby circle/text. |
| Save/reopen | Future proof must read back stable compound identity, driver/location, exact At cut/Below state or asset identity, label/manual position and provenance separately. Visible graphics alone are not proof. |

## Fictional before/after drawing example

On a synthetic local plan, start `SPW3`, choose the approved **Below** state and one supplied diameter choice. The preview shows yellow/hidden output and approved hatch state. Place two explicit local points, then Escape; each is an independent compound. Start `BP` separately, select **At cut**, inspect green/solid preview and Cancel before placement. No capacity, depth or mark is inferred.

In the same synthetic drawing, start SCREWPILE with its Approved asset present, preview it once and Apply. Copy it to another explicit location after the asset check passes. Then make the asset unavailable and attempt a new pile and stump footing: each blocks with no approximate circle and no change to existing compounds. Move one placed pier and edit its label presentation; unrelated pier/pile graphics stay where they are.

## Future representative acceptance

In AutoCAD, use a synthetic drawing to verify all bored-pier aliases reach one visual engine, At cut/Below output, the approved diameter/hatch choices, repeat placement/Esc, approved screw/stump asset selection, missing-asset block, selected Move/COPY/Erase scope, partial receipt and save/reopen. Inspect actual graphics and status in the real application before claiming Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD, process, deployment, issue action or client scan occurred.