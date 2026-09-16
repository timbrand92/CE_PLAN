# Structural division-marker daily card

**Planning-only companion.** This documents the direct DIV / DIVX guideline-marker route. It does not treat a division point, cross or copied block as a bored-pier, support, footing, calculation, asset approval or engineering instruction.

## Current source and approved boundary

| Route | Named current source observation | Planning consequence |
|---|---|---|
| DIV | Requests a selected line/polyline or two points, then Spacing/Number division input. A Number is source-defined as segments, so interior markers equal segments minus one; Spacing rounds the chord length up to segments, then uses redistributed actual chord gaps. A selected polyline is reduced to its first/last-vertex chord, not its path/bulges. It creates interior points, ensures a non-plottable Guidelines layer, creates cross block references in one Undo-mark transaction and reports a count. [Declaration](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:105>), [route](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeBoredPierService.cs:75>). | Direct utility reachability is observed. Its guideline marks are not a ST-06 foundation record and cannot create a hydraulic/structural relationship from crossing or proximity. |
| DIVX | Uses the same division input, then offers Cross/Block. Cross follows the same guide-mark path; Block asks the user to select a block and clones it at the computed points. [Route](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeBoredPierService.cs:120>), [block clone](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeBoredPierService.cs:184>). | This source does not prove preview, safe partial outcome, relationship preservation or an approved copied asset. The direct aliases stay **Keep/Modify proposal**, pending normal workflow review. |

## Direct daily flow — proposed, no compulsory window

| Step | Native-style action | Transient review and output boundary |
|---|---|---|
| **1. Identify only the guide span** | Type DIV or DIVX. Select one explicit local line/polyline or enter two points; select spacing or number as the familiar prompt asks. | A short command-line status names the two endpoints/chord, method, requested input, segments, interior guide-point count and actual redistributed chord gap. It refuses to imply along-polyline/bulge spacing. It states **no member/pier/support relation**. Xref, locked, REFEDIT and unsupported content retain native protection; no local substitute is made. |
| **2. Choose DIVX marker only when needed** | DIV remains cross-only. DIVX retains Cross or an explicitly selected local Block marker. | Block choice shows the exact selected block identity and any unavailable/protected state. The command cannot choose a nearby block, clone Xref content or infer an approved library asset. A CE-owned/engineering block is rejected here and handed to its approved owning-copy workflow; it cannot be treated as an independent guide clone by label alone. Cross markers and eligible plain-block clones stay temporary drawing guides unless another reviewed command explicitly adopts them. |
| **3. Confirm the bounded marker output** | A transient preview/status shows the computed guide points, target guide layer or selected marker, and the active drawing/layout/view. **Apply** commits only the listed guide markers. | Preview/Apply is **Proposed**: current source inserts directly after prompts. The target receipt separates point calculation, marker placement and any layer setup. It does not claim a guideline count is a completed design network. |
| **4. Cancel, undo or inspect** | Cancel/Escape before Apply creates no marker output in the proposed target. Native Undo remains the ordinary recovery path. | Current source may ensure its guideline layer before marker transaction and does not prove full cancellation rollback. Reopen/inspect before retry; a Block-clone partial outcome must list placed/absent/Unknown rows rather than print a total as proof all clones exist. |
| **5. Later use of a guide point** | A later foundation/support/detail tool must require its own explicit selected object, source and reviewed relationship. | Moving, erasing or copying a guide mark changes that guide only. It does not move, delete, connect or revise a related structural object, and no automatic adoption occurs. |

## Fictitious before/after

On a synthetic local plan, the drafter divides an explicit temporary guide span and places cross markers. The status shows the endpoint chord, selected method, requested input, segments, interior points and actual chord gap; it does not promise path-length spacing across a polyline. They Cancel a second DIVX run before selecting a block; there is no marker output to treat as a pier layout.

Later they deliberately select a local block for one DIVX run. The receipt says which computed points received a block and which need review. Erasing one cloned marker does not affect beams, piers, footings or any schedule. If a later foundation route needs a position, it opens its own explicit selection/review rather than reading the nearest cross.

## Future representative acceptance (not performed)

1. Run both endpoint modes, both division methods and DIVX Cross/Block; inspect command-line prompt order, marker count, guide-layer state and one Undo in a synthetic drawing.
2. Test Cancel at endpoint, method, marker and block-selection stages; inspect both marker geometry and pre-existing/current guide-layer state.
3. Include a plain local block, a CE-owned/engineering block, an Xref block and protected content; verify only an explicitly eligible plain local block can be selected, CE-owned blocks hand off to their approved copy workflow, and no foreign content is copied.
4. Force an uncertain block clone result, inspect every point before retry, then verify moving/erasing a guide marker never affects a structural compound or schedule.

## Links and limits

- [ST-06](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-06_FOUNDATIONS_REBAR.md>) and [pier/pile daily card](structural_pier_pile_daily_placement_card.md) retain bored-pier/foundation authority. This guide utility is deliberately separate.
- The current source's guide-layer creation, marker scaling, block cloning, native Undo and partial/cancel behavior require real AutoCAD evidence. No runtime test was performed.

