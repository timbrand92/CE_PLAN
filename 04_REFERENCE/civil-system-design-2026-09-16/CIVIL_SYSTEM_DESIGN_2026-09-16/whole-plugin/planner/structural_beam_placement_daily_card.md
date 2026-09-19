# Structural beam placement — daily first-use card

**Planning checkpoint:** 2026-09-17T01:47:35.4379004+10:00. This card deepens approved [ST-01 Beams and explicit structural links](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-01_BEAMS_LINKS.md>) ST1-1–15 into the ordinary first beam on a drawing. It does not choose a beam size, support, load path, continuity, offset distance or engineering value.

> **Read with:** [W3 interaction cards](structural_w2_w6_interaction_cards.md), [supports/bracing daily card](structural_supports_bracing_daily_card.md), [dependent-draft review card](structural_dependent_draft_review_card.md), [approved reconciliation](structural_approved_card_reconciliation.md) and [ST-01](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-01_BEAMS_LINKS.md>). Current placement declarations and BDL source behavior are observations in [BeamPlacementCommands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BeamPlacementCommands.cs:44>). The Main/More sequence below is **Proposed** except for explicit ST-01 decisions; it is not a runtime claim.

## First beam — choose the familiar route

| Main entry | Approved daily distinction | Proposed first-use view |
|---|---|---|
| 1 Regular / 2 Lower | Retain the familiar regular and lower beam routes. Valid preselection comes before support/line/point prompts. | Header shows command, drawing/layout/view/level, selected local inputs, source/Manual/Unknown state and any confirmed support identities. A selected support is shared, not a beam-owned child. |
| 4 Special / 5 Offset | Keep them distinct. 5 offsets beam **geometry**, so it must show actual offset side before placement; retain the approved standard presets and permit an entered distance rather than inferring either. | Preview clearly names special versus offset result, picked axis, actual side, selected approved standard preset or entered distance, and supplied source/Manual/Unknown input. No unspecified current prompt value becomes an approved engineering or drafting default here. |
| BDL paired beam | One paired assembly has stable pair identity, fixed separation and two outside labels. | Preview shows both members, pair identity, both label sides and the selected coordinate/view basis as one pending assembly. It is not two independently linked beams. |
| 8 / Beam settings | Settings are a visible placement/default review surface, separate from drawing output. | **More: Beam settings** shows existing/proposed preference, use scope and whether it affects only future placement. Saving a default never resets an existing Manual/pinned label or beam presentation. |

## Select inputs, then inspect one complete preview

| Step | Drafter action | Result / protection boundary |
|---|---|---|
| **1. Start with valid preselection where available** | Select local known supports/linework only where the selected route accepts them. Otherwise follow support/line picks then point input as ST1-3 requires. | Header retains actual selected identity and drawing/layout/view/level. Nearby beam labels, Xref edges, crossing geometry and same-looking elements on another level are not selected inputs. |
| **2. State only supplied member information** | Show entered/linked mark or text, source revision/status and Manual/Unknown state. A midspan support can suggest CONT. only; suffix requires confirmation unless an approved relationship already proves it. | A label or nearby support cannot silently create continuity, a member link, a size, or an engineering conclusion. Unknown stays Unknown. |
| **3. Review geometry and label together** | The one side/clearance resolver previews beam geometry, owned label, side, current local coordinate basis, text layout, support relation and any perpendicular auto-trim. Approved drafting offsets are **45 mm base** and **70 mm extra suffix lift**; context may move text outward, never closer. | The same resolver governs preview and final placement across 1/2/4/5/BDL/BEXT. Perpendicular auto-trim must be visible in Preview before Apply. Site/unknown Xref layers cannot decide placement. Picking direction or rotated UCS must not reverse readable output. |
| **4. Confirm special modes** | For 5, preview actual geometric offset side and selected approved standard preset or entered distance. For BDL, preview both beam lines and two outside labels with stable pair identity. | No generic beam route hides 5 offset behavior or breaks BDL into separate unpaired results. |
| **5. Apply one beam assembly** | Explicit Apply names command, selected local scope, proposed graphics/owned labels, pair if present and confirmed support links. | Apply creates beam geometry plus its owned label; supports remain shared links. There is no forced QSAVE; a successful placement is one intended Undo target. Current source behavior that may force save is not an approved target. |

## Main and More after placement

| User task | Proposed visible outcome | Preservation rule |
|---|---|---|
| **Move body / move label** | Select the recognised beam assembly. Body move carries its owned label; label move is an independent retained presentation choice. | Beam-only MOVE does not carry an unselected shared support. A Manual label position is not reset by a later setting or source suggestion. |
| **Edit endpoint or confirmed relation** | Main previews the selected endpoint and its confirmed support relation. **Edit this only** preserves related records for review; explicit **Edit together** lists the confirmed affected endpoint/support scope and previews it. | An ambiguous support relation remains unlinked/Needs review. Do not broaden scope from a crossing/proximity candidate. |
| **Copy beam only** | COPY previews original and fresh beam/label identities and destination drawing/view/level. | A beam-only copy receives its copied owned label but **unconnected supports** until explicitly reviewed. It does not copy a calculation, load path or Manual engineering decision. |
| **BDL Move/COPY/Erase** | Treat the selected BDL as one pair in the scope preview: both lines, pair identity and two labels. | Do not strand one label, collapse separation or merge its support relationships with another beam. |
| **BEXT / BTX** | More shows the selected beam and owned label. BEXT previews the chosen end, boundary hit and trim-back before extension; BTX previews TEXT↔MTEXT conversion. | BEXT uses the owned label, never nearest text, and Cancel changes nothing. BTX preserves visual centre, rotation, style, text and beam ownership; conversion does not turn the label into independent nearby text. |

## Cancel, review state and reopen

| Event | Proposed truthful outcome |
|---|---|
| Cancel/Escape before Apply | No beam, label, BDL pair, new support link or inside-point record is created by the cancelled placement. |
| Optional inside-point assistance | Existing stored inside-point evidence is visible/resettable as ST1-7 requires. It is an optional lintel aid, not a second placement authority. Banked ST1-I1 automatic inside/outside behavior remains unplanned until Tim supplies drawing examples. |
| Input/source changes during preview | Show Before / Current / Pending beam/text/relation state. Disable Apply and offer Refresh, Park, Discard or Cancel. A Manual presentation move makes only a placement draft using the old position Needs review; it does not make engineering calculations stale. |
| Partial result | Separate receipt for beam geometry, owned label, BDL pair identity, confirmed support-link receipt and source/Manual state. Read back before retry; retry needs verified absence or qualified safe resume and never draws over a possibly placed beam. |
| Save/reopen | Future evidence must read beam/pair identity, owned label position, source/Manual state, selected coordinate/view context and confirmed support links separately. Visible linework is not proof of a link or provenance. |

## Fictitious daily drawing example

On a synthetic rotated Level 1 framing plan, the drafter starts 1 with two valid preselected local supports. The preview shows the beam, its owned label on the resolved side and both explicitly confirmed support links. A nearby Xref edge and a matching Level 2 label remain unselected. The drafter Cancels, leaving no beam or new inside-point. They restart and Apply one regular beam, then independently move its label.

Next they use 5 on one selected local axis, preview the actual offset side and selected approved preset or entered distance, and Park it when the context changes. They place one BDL pair, inspect both outside labels, and COPY only a regular beam: the copied beam has a fresh label identity and no support links. They then use BEXT on the original beam only and select BTX for its owned label. No command saves the drawing, alters another beam, treats a support as a child or turns a nearby support into continuity.

## Future representative acceptance

In AutoCAD, use a synthetic rotated two-level plan to inspect: 1/2/4/5/BDL distinctions; valid preselection versus point input; visible source/Manual/Unknown state; 45/70 drafting-offset preview; 5 actual offset side/preset-or-entered-distance; BDL pair/labels; preview-to-Apply consistency; no forced save; beam versus shared-support Move scope; explicit Edit-together; beam-only COPY unconnected supports; BEXT/BTX ownership; Cancel, Partial readback/retry and save/reopen. Inspect the real drawing before claiming Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.


