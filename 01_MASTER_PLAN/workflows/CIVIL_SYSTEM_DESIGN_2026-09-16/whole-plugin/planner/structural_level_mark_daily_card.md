# Structural daily level-mark card — select source, preview one compound, place or revise

**Planning checkpoint:** 2026-09-17T01:53:56.1548612+10:00. This W7 companion turns the approved level-mark rules into an ordinary drafter sequence for `CE_LEVELMARK`/`LM`, `FFL`, `RL`, `SSL`, `NGL` and recognised-mark update `LMU`. It inherits [ST-03 Annotation and dimensions](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-03_ANNOTATION_DIMENSIONS.md>) ST3-7–13 and the W7 [approved reconciliation](structural_approved_card_reconciliation.md). It does not choose a level value, scale, datum, source or engineering result.

> **Current-source observation:** direct aliases are declared in [LevelMarkCommands.cs:28](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:28>)–[:81](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:81>). Current `LM` asks type, then `RunDirect` persists a last type before point/side/value prompts; a later Cancel is not a rollback of that settings write ([LevelMarkCommands.cs:31](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:31>)–[:57](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:57>), [:154](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:154>)–[:194](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:194>)). Current `LMU` accepts generic TEXT/MTEXT selection ([LevelMarkCommands.cs:83](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:83>)–[:151](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:151>)); the restricted compound selection below is **approved target**, not a live-function claim.

## Familiar entry, then a complete single-mark review

| Main route | Retained distinction | Proposed first-use surface |
|---|---|---|
| `LM` / `CE_LEVELMARK` | Retain one type chooser with FFL, RL, SSL and NGL. The direct aliases `FFL`, `RL`, `SSL`, `NGL` remain familiar entry points. | Header identifies drawing/layout/view/current UCS, chosen mark type and whether its basis is **Trusted source**, **Manual**, or **Unknown**. The shown last-used type is a visible session/drawing preference only; it does not supply a level value or engineering basis. |
| Select source or Manual | Trusted source must show its actual document/record, revision and units. Manual value requires the drafter’s supplied value and reason. Unknown is a valid visible state. | No unverified source becomes a Manual value, and no missing value becomes `0.000` or another numeric placeholder. Selecting a background, crossing line, Xref or nearby text is not proof of a level source. |
| Pick point and side | Preserve point placement and side/`F` flip as familiar drafting gestures. | Preview the origin, symbol, tail, label, type, supplied source/value, local coordinate/UCS basis and left/right side as one compound before Apply. No source value appears as settled merely because a marker can be previewed. |

## Place one level mark without treating it as loose text

| Step | Drafter action | Proposed output / protection |
|---|---|---|
| **1. Identify purpose and basis** | Start with `FFL`, `RL`, `SSL`, `NGL` or `LM`; confirm the current mark type and choose Trusted source, Manual or Unknown. | The selected type drives marker form only. It does not infer floor build-up, structural adequacy, calculation identity or a datum. |
| **2. Provide only supported data** | For Trusted source, inspect record/revision/units; for Manual, enter the supplied value and reason; for Unknown, leave value/source visibly Unknown. | Manual and Unknown remain distinct after save/reopen. A familiar previous type never silently becomes an accepted value. |
| **3. Pick and preview** | Pick the local drawing point and use side / `F` to review the complete compound in the current view/UCS. | The preview contains symbol, tail, text, type, source/value state and orientation. It also names protected/unavailable selection conditions. Xref, REFEDIT, locked-layer and unsupported content retain native protection; nothing is unlocked or copied around. |
| **4. Apply** | Explicit Apply names one mark compound, drawing/view, type, source/Manual/Unknown state and intended visible pieces. | Apply creates one level-mark compound with one intended Undo boundary. It does not QSAVE, create a calculation, change a model or update another mark by value proximity. |
| **5. Move/edit presentation** | Select a recognised compound. Main offers Move compound, Move label presentation, `F` flip and Edit basis/value. | Moving a label is retained manual presentation and does not change its basis. Editing a value/source displays Before / Current / Pending, including units and record scope; it needs explicit confirmation. A presentation move does not make numeric calculations stale. |

## `LMU` is a recognised-compound revision, not a text sweep

| User action | Approved target / current-source distinction | Receipt and Cancel boundary |
|---|---|---|
| **More: Update recognised marks (`LMU`)** | Select recognised CE level compounds only. Preview each identity, current type/value/source, proposed value/source, affected drawing references and conflicts. This applies ST3-8, with ST3-7/13 compound ownership and normal editing boundaries, replacing the current generic TEXT/MTEXT selection scope. | Apply names exactly which recognised compounds changed, with one intended Undo. Generic text, dimensions, notes and nearby MText remain unselected. Cancel/Escape before Apply changes nothing. |
| **A source revision changes during review** | Show original confirmed basis, Current revised evidence and Pending edit. An unadopted candidate is **Needs review**; it does not make an unchanged adopted basis Cannot calculate. | Refresh, Park, Discard or Cancel preserve the last confirmed mark basis until an explicit Apply. A later retained Manual source/value is not auto-overwritten. |
| **Copy / erase** | Copy and erase must be explicit compound operations; no visible mark proves a copied identity has a valid source. | Copy receives fresh identity and visible provenance review; erase does not erase an upstream source or another mark. The exact approved copy/erase interaction is still a future native gate. |

## Cancel, Undo, save/reopen and partial outcomes

| Situation | Proposed truthful result |
|---|---|
| Cancel at type, point, side, source/value or preview stage | No level-mark compound is created or revised. Current source may already have remembered a mark **type**; it is a preference write, not a marker/level-value rollback claim. |
| Invalid/missing source or unsupported selection | Leave source/value Unknown and show why. Do not invent a numeric result, loose-text fallback, or automated engineering conclusion. |
| Apply then Undo | One accepted compound placement/update is one intended Undo target. Native Undo behaviour remains untested; a context-blind undo of unrelated drafting is not proposed. |
| Partial/failure report | Read back each compound identity, symbol/tail/label, type, source/value state and update result before retry. Retry requires verified absence or safe resume; never duplicate a possibly placed mark. |
| Save/reopen | Future native verification must read compound identity, owned label/manual presentation, type, source/Manual/Unknown state and confirmed update history separately. Open-drawing Apply is not proof the DWG was saved to disk. |

## Fictitious daily drawing example

On a synthetic Level 1 plan, a drafter uses `FFL` and selects a supplied trusted record. The preview shows the FFL symbol, tail and label beside the picked local point, with its source revision and units. They flip side before Apply and place one compound. They then move only the label to clear a hatch; the manual position is retained and does not change the supplied level.

A second mark has no reliable source. The drafter selects **Unknown**, places no fabricated number and leaves an assigned review item. Later `LMU` shows that recognised mark next to a candidate record revision; the drafter Parks rather than applying it. A loose nearby note and a Level 2 mark stay outside scope. After a drawing save/reopen in future native acceptance, the user checks that the first mark’s Manual presentation and both marks’ basis states remain distinct.

## Future representative acceptance

Use a synthetic two-level, rotated-UCS drawing with a trusted record, a Manual value, an Unknown mark, generic nearby TEXT/MTEXT, Xref and locked content. Inspect: alias discovery; type/source/Manual/Unknown selection; whole-compound preview and `F` flip; no numeric placeholder; one placement Undo; label move versus basis edit; current-source remembered-type boundary; recognised-only `LMU`; candidate revision Park/Cancel; partial readback/retry; and saved-versus-open-drawing distinction. Inspect the real drawing before reporting Tested or Tim-accepted.

**Outstanding Tim choices:** none created. The visible Main/More arrangement and receipt wording are **Proposed** presentation details. Source identity/revision, native compound persistence, Undo and save/reopen are future evidence gates, not planning approval.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.

