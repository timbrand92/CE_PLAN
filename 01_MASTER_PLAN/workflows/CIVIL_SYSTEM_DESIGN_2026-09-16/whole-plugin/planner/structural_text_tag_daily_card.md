# Structural daily text and tag placement — familiar aliases, one reviewed native result

**Latest planning checkpoint:** 2026-09-17T02:08:43.8072108+10:00. This W7 companion turns the approved ST-04 daily placement rule into a concrete first-use path for ordinary generic text (`18L/R/T/B`, `25L/R/T/B`), beam tags (`EBT/EBB`, `BEBT/BEBB`, `IBT/IBB`) and support tags (`THL/THR`, `PFL/PFR`, `BPL/BPR`). It applies [ST-04 Structural text and tag placement](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-04_TEXT_PLACEMENT.md>) ST4-1–15 and [W7 reconciliation](structural_approved_card_reconciliation.md). It does not set a designation, text height, scale, engineering value, support relation or asset approval.

> **Current-source observation:** the familiar aliases dispatch `CeTextService.Run(...)` in [CeTextCommands.cs:8](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/CeTextCommands.cs:8>)–[:89](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/CeTextCommands.cs:89>). The declarations prove reachability, not native preview, final output, ownership persistence or AutoCAD acceptance. The approved ST-04 preset/backbone and preview contract remains governing. Information/actions below appear in familiar command prompts, transient drawing preview or an existing palette; they do not require a new modal window for each direct alias. Any Main/More placement remains **Proposed**.

## Start with the known shorthand, show its full result

| Familiar family | Approved preservation | Proposed first-use view |
|---|---|---|
| `18L/R/T/B`, `25L/R/T/B` | Keep useful generic-text shortcuts as aliases to one CE Text preset backbone. L/R/T/B selects a starting position only. | The prompt/transient preview or existing palette shows selected preset role, prefix if any, layer, **plotted** height, justification, preferred side and rotation behaviour. It names the local drawing/layout/view and calls the output **Independent text** unless an explicit relationship is confirmed. |
| `EBT/EBB`, `BEBT/BEBB`, `IBT/IBB` | Keep quick structural-mark aliases while using the same shared placement backbone. | An owned beam/support/foundation label requires an explicitly selected eligible parent and shows its exact identity. Without one, show **Select parent / Place deliberate generic note / Cancel**; only the deliberate generic-note choice is Independent. The user supplies the designation. Full prefix is previewed before placement, so `EBT` plus `1` reads `EB1`, while entered `EB1` does not become `EBEB1`. |
| `THL/THR`, `PFL/PFR`, `BPL/BPR` | Keep support-tag aliases and their starting-side distinction. | Show selected support identity only when explicitly selected/recognised. A crossing line, nearest tag or same-looking support on another level is not a parent link. |

## One daily placement from selection to editable output

| Step | Drafter action | Proposed output / safety boundary |
|---|---|---|
| **1. Select a reference only where the alias needs one** | For an owned beam/support/foundation label, select an eligible local parent; for a generic note, deliberately choose the independent route without a reference. | The prompt/transient preview or existing palette shows current drawing/layout/view and selected explicit identity. No proximity, crossing or source suggestion manufactures a parent relationship. Footing geometry/trim routes stay W5/ST-06; `SFT/SFB/BSFT/BSFB` remain familiar transition aliases whose text path stays ST-04 while their footing geometry stays ST-06 until replacement acceptance. Long standard notes stay ST-07/AS-01. |
| **2. Enter only the supplied text/designation** | Type the actual text or designation. See the complete prefix result before preview. Last-used text is visible only within the current drawing/session. | CE never invents a structural designation or silently carries an engineering mark/value into another project. Candidate/unknown text asset is Preview-only; only individually Approved CE native TEXT/MTEXT styles/assets may apply. |
| **3. Review a single live placement** | Preview full native text result against the working drawing: content, prefix, current plotted scale basis, side, rotation, justification and explicit parent/Independent state. `F` flips side, `R` changes reference/alignment and Tab cycles a ranked alternative where available. | The accepted preview and final drawing result must be identical. A ranked alternative is a presentation candidate, not a new structural decision. Manual selection always remains available. |
| **4. Confirm native placement of one editable annotation** | The confirming native placement click names alias/preset, selected local scope, full visible result, parent state and target native text type. | Creates native editable TEXT/MTEXT—not an inserted/exploded anonymous palette block. It is one intended Undo boundary, does not QSAVE and does not change a beam/support/foundation or calculation. |
| **5. Edit ordinary presentation later** | Use native edit/MOVE on the recognised text. A deliberate manual position is retained. Text↔MText conversion preserves explicit link where one exists. | Moving/formatting a label remains presentation. Editing embedded designation tokens is a separate reviewed value edit: show Before / Current / Pending and do not silently claim synchronized engineering data. If a text/record mismatch is deliberately retained, show Needs review rather than Current. |

## Ownership, copy and conversion stay explicit

| Action | Approved rule / proposed daily outcome |
|---|---|
| Move / Edit / Erase | MOVE of an owned parent carries its explicitly linked label appropriately; direct label MOVE preserves its deliberate location. EDIT preserves location and explicit ownership. Erasing a label never erases its parent. Erasing a parent leaves the owned-label relationship unresolved or follows the applicable approved compound rule—never silently attaches it elsewhere. |
| Copy owned text with its parent | A copied parent receives a fresh linked-label identity; a copied generic note remains independent. The existing `COPYM`/`CEMCOPY` helper is shared-command ownership, not a CE Text action contract. No copied text inherits an unconfirmed support/link/calculation identity. |
| `R2LTXT` | Use the existing command/palette detail to select recognised eligible text only; preview selected count, content, rotation, position and ownership; Apply one Undo. Preserve those fields. It is not a broad conversion of all nearby text and no registry gap is treated as approval to retire it. |
| Changed source while a placement/edit draft is open | Show Before / Current / Pending. An unchanged retained manual position is not a conflict. A new confirmed manual MOVE invalidates only a pending presentation draft consuming the old position; it does not make numerical calculations stale or auto-catch up other labels. |

## Cancel, partial outcome and reopen

| Situation | Proposed truthful result |
|---|---|
| Cancel/Escape before the confirming native placement click | No text, parent link or placement state is created. Previous layer/style/snaps restore as ST4-14 requires; native proof remains future work. |
| Asset/style missing or candidate-only | Explain which Approved asset is absent/which candidate is Preview-only. Do not substitute an anonymous block, invent style or explode geometry. |
| Placement/link receipt partial | Read back native text, parent identity, parent-independent state and manual location before retry. Retry needs verified absence or safe resume; it never duplicates a possibly placed tag. |
| Save/reopen | Future native verification reads text content, native type, rotation/position, explicit ownership and Manual/Unknown state separately. Open-drawing placement is not proof of a saved DWG or an issued sheet. |

## Fictitious daily drawing example

On a synthetic Level 1 framing plan, the drafter selects B4 and uses `EBT`. They enter `EB1`, see exactly `EB1` in the live preview, use `F` to clear a brace zone and Apply one native tag explicitly linked to B4. They then use `25R` to place an independent coordination note next to B4; it remains independent despite being nearby.

The drafter MOVE’s the EB1 label to a deliberate manual position. A later soft placement suggestion does not snap it back. When a genuine designation edit is requested, a transient review in the existing command/palette context shows the old displayed token, proposed token, linked B4 identity and record state; Cancel leaves both untouched. Copying B4 yields a fresh copied label identity, while copying the generic note stays independent. A recognised-only `R2LTXT` preview is cancelled without changing any text.

## Future representative acceptance

Use a synthetic two-level plan with one selected beam, one selected support, generic notes, duplicate-looking nearby text, candidate asset, approved asset and a changed source during a pending placement. Inspect: alias discovery; exact prefix/no double prefix; explicit parent versus Independent; plotted scale context; F/R/Tab; preview/final consistency; native editable output; manual MOVE/EDIT preservation; designation-token review; parent copy/erase scope; recognised-only conversion; Cancel, partial readback/retry and save/reopen. Inspect actual drawing output before reporting Tested or Tim-accepted.

**Outstanding Tim choices:** none created. Main/More button placement and receipt wording are **Proposed**. ST-04 owns ordinary structural text; ST-06 owns footing geometry; ST-07/AS-01 owns long standard notes; shared owner retains COPY helper. Native result, style persistence, Undo and save/reopen remain future evidence gates.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.




