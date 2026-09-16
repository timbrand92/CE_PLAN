# Structural daily dimensions and leaders — native first use, CE context and safe revision

**Latest planning checkpoint:** 2026-09-17T02:00:26.9448419+10:00. This W7 companion makes the retained `AD`, `LD`, `Q`, `QD`, `RD`, `MLL` and `MLR` routes reviewable as a normal drafter path: select, follow native prompts, preview/position where approved, place, make an ordinary edit and return to the drawing. It inherits [ST-03 Annotation and dimensions](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md>) ST3-1–6, ST3-12–15 and [W7 approved reconciliation](structural_approved_card_reconciliation.md). It supplies no dimension, scale, geometry, engineering value or text default.

> **Current-source observation:** aliases dispatch native dimension/leader commands via [DimensionCommands.cs:96](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:96>)–[:116](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:116>). `RD` records its chosen arc type before dispatching native selection, so later Cancel does not roll back that preference ([DimensionCommands.cs:120](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:120>)–[:160](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:160>)). `MLL`/`MLR` source prompts arrow point then text and calls a preview-named helper ([MLeaderCommands.cs:16](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/MLeaderCommands.cs:16>)–[:75](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/MLeaderCommands.cs:75>)); that is source evidence, not a verified AutoCAD preview or placement result. The Main/More arrangement below is **Proposed** except for ST-03 decisions.

## First use stays familiar

| Main route | Approved production behaviour | Proposed visible context before/through the normal prompt |
|---|---|---|
| `AD` — aligned dimension | Retain AutoCAD’s normal associative dimension behaviour: selected geometry/points → finished dimension follows cursor → place. CE does not reorder or replace the native prompt sequence. | Header names active drawing/layout/view, eligible local selection if one exists, CE-shipped style and plotted-scale basis, and current source/Manual/Unknown context only where supplied. It never supplies a measurement or changes geometry. |
| `LD` — linear dimension | Retain the normal horizontal/vertical linear dimension flow and native grips/associativity. | Show the same portable CE style context. Do not silently change the drafter’s prior layer, style, snaps or other settings after completion; ST3-2 requires restoration. |
| `Q` / `QD` — direct leader | Retain native editable leader/text, with closed-filled arrow for `Q` and dot leader for `QD`. Do not explode into graphics or inject hidden command strings after workflow start. | The prompt flow stays quick. At placement, show only leader type, selected local anchor (if any), current drawing/view and native editable-object result; the text stays an independent drafting note unless an explicit relationship is established. |
| `MLL` / `MLR` — polished MLeader | Retain left/right initial side and the arrow point → text sequence. `F` toggles side before placement. | Preview arrow, landing and full text together before Apply; place one editable MLeader, not a collection of lines. The proposed preview is separate from current source helper naming. |
| `RD` — arc/radius/diameter | ST3-5 target order is **select supported arc/circle → choose Length / Radius / Diameter → preview native dimension → click**. Unsupported or broken geometry is refused, not approximated. | Display the selected type and supported geometry status. A remembered choice is a preference only; it is not a dimension placement or a current engineering decision. |

## One ordinary dimension/leader from selection to output

| Step | Drafter action | Result / guardrail |
|---|---|---|
| **1. Start from a local selected object or the familiar alias** | Preselect eligible local geometry where AutoCAD accepts it, or use the route’s existing prompt sequence. | Locked layers, Xrefs, REFEDIT and unsupported content keep native protections. A nearby line, text, hatch, or equivalent-looking geometry is never silently substituted. |
| **2. Read CE context, do not edit it as a value source** | Confirm portable CE style and plotted-scale context. For `RD`, first select a supported arc/circle, then choose Length/Radius/Diameter. For MLeader, choose `MLL` or `MLR`, arrow point then supplied note text. | Styles are CE-shipped, never drawn from a personal template path. The chosen styling does not establish an engineering value, source revision or calculation authority. |
| **3. Position the native result** | Continue the native dimension/leader prompt; for MLeader, inspect arrow/landing/text together and use `F` if required before Apply. | Dimension geometry remains associative and leader/text remains editable. The selected side/placement is visible in the current drawing/view; nothing is exploded or changed in another view. |
| **4. Apply one drawing annotation** | The visible receipt identifies command, selected local scope, style/scale context and native output type. | Accepted result is one intended Undo target. There is no forced drawing save or issue action. Source route declaration is not proof of native output, association or Undo behaviour. |
| **5. Use ordinary native editing** | Select the existing native dimension or leader; Move uses normal AutoCAD editing/grips. A user’s deliberate leader/text position is retained. | A manual presentation move is not snapped back by later suggested placement, does not alter the measured geometry, and does not make a calculation stale. A true edit to dimension geometry or linked source requires the owning workflow’s review. |

## Group repair is deliberately a separate More action

| Action | Approved target and source boundary | Cancel / result boundary |
|---|---|---|
| `DSET`, `DSET1`, `DUP` | ST3-12 consolidates these scattered legacy routes into a controlled expert review: select dimensions/leaders → show existing and proposed style/scale → preview count/scope → Apply → one Undo. Current declarations/source do not prove this approved target is live. | Cancel before Apply changes no selected item. Unrecognised styles stay unchanged and are reported. It never converts a whole drawing accidentally or forces save. |
| A changed drawing or source during group preview | Show exact selected identity and Before / Current / Pending style/scale/relationship. | Refresh, Park, Discard or Cancel the pending group. Read back partial/unknown results before retry; never reapply the whole batch over already changed annotations. |
| Copy, erase or move an annotation | Native editing remains authoritative. Copy/erase scope is the explicit selected native object(s), not neighbouring drawing content. | Copy/erase needs a fresh output/readback state; it does not alter parent geometry, schedule or calculation simply because the annotation refers to it. |

## Cancel, restore and reopen

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Escape during a native dimension/leader prompt | No new annotation is placed. For `RD`, the current source may already have saved the chosen arc type; this is a preference boundary, not a promise that every setting rolled back. |
| Cancel a MLeader preview | No arrow, landing or text is created by the pending target interaction. Existing source/runtime behaviour requires native proof. |
| Finish or cancel a route after CE temporary style setup | Previous layer, style, snaps and other AutoCAD settings restore as ST3-2 requires. Actual restoration needs future native verification. |
| Save/reopen | Future acceptance reads native associativity, editable leader/text and retained manual positions separately. An in-window receipt is not proof the DWG saved to disk. |

## Fictitious daily drawing example

On a synthetic rotated Level 1 plan, a drafter preselects a local member edge and uses `AD`. They follow the ordinary native prompts, inspect the associative dimension following the cursor, and place it using the CE portable style context. They move its native grip once; the measured object remains the selected geometry.

They use `QD` for a short independent drawing note, then `MLL` for a longer note: arrow point, supplied text, full left-side preview and `F` to put the landing on the other side. The position is deliberately adjusted later and remains manual presentation. Finally they open `RD`, select a supported arc, choose Radius, inspect the native preview and Cancel before click. ST3-5 therefore leaves no dimension; separately, current source may have remembered the chosen type before its native selection boundary. A broken arc is refused rather than receiving an approximate annotation. No command saves, changes another drawing or alters the member’s engineering record.

## Future representative acceptance

Use a synthetic drawing containing local geometry, an arc, an unsupported/broken object, an Xref, locked content and two levels/views. Inspect: `AD`/`LD` native associativity and prompt order; `Q`/`QD` editable leader distinction; `MLL`/`MLR` arrow/landing/text and `F`; `RD` target select → type → preview → click sequence, plus the separately observed current preference-before-native-Cancel boundary; restoration of layer/style/snaps; deliberate manual leader position; selected-scope repair preview; Cancel/Undo; and save/reopen of association/manual position. Inspect actual native output before reporting Tested or Tim-accepted.

**Outstanding Tim choices:** none created. Presentation placement of Main/More and receipt detail is **Proposed**, while the retained aliases, native-first behaviour, portable styles, normal editing, selected-scope repair and safety rules are approved. Native rendering, association, Undo and save/reopen are future evidence gates.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.


