# Structural supports, bracing and joist markers — daily floor-plan card

**Planning checkpoint:** 2026-09-17T01:34:12.0928778+10:00. This card turns approved [ST-02 Supports, bracing and joists](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-02_SUPPORTS_BRACING_JOISTS.md>) ST2-1–15 into one ordinary drafting sequence. It preserves familiar commands and exact approved limits; it does not choose member sizes, support marks, engineering links, load paths or structural adequacy.

> **Read with:** [W3/W4 workflow cards](structural_workflow_cards.md), [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md), [approved-card reconciliation](structural_approved_card_reconciliation.md), and [ST-02](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-02_SUPPORTS_BRACING_JOISTS.md>). Command declarations and prompts are source observations only: [support routes](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:109>), [AB/BB route](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BracingCommands.cs:13>) and [R1/FJ1 route](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/RafterJoistCommands.cs:54>). Main/More layout and receipts are **Proposed** pending implementation and AutoCAD evidence.

## One floor-plan workspace

For these direct drafting commands, the active drawing/layout/view, level, command, selected local identity and source state appear in the command prompt, transient drawing preview or existing palette—not in a compulsory new modal window. A nearby or crossing item remains unselected. Xref, locked, REFEDIT and unsupported objects remain protected.

| Discover | Existing / approved meaning | Proposed visible result |
|---|---|---|
| **Direct support route / existing palette** | Retained insert routes are `DS`, `DS1`, `TS1`, `C1` and `C2`; `SDS`, `SDS1`, `STS1`, `SC1`, `SC2` are switch-to-type routes. `TDS`, `TDS1`, `TTS1` and `TC1` stay hidden aliases. ST2-2 fixes the daily catalogue: **DS is 90×90 without a label**; DS1 is 90×90; TS1 is 135×90; C1 is 89 SHS; C2 opens its approved SHS/RHS/PFC picker. Current source exposes declared commands/insertion prompt, can inspect an active schedule row and asks C2 visibility where required. | Show the selected command/type, selected support compound or insertion point, current drawing/view/level, schedule evidence if present, and Confirmed/Manual/Assumed/Unknown state. A label preview appears only for a label-bearing support; DS visibly remains no-label. Schedule content pre-fills only visibly and is overridable; it never proves a support size or link. |
| **Direct bracing route / existing palette** | `AB` and `BB` retain first endpoint → completed live preview → second endpoint. `AB` visibly caps at **2700 mm** and shows `MAX`; `BB` and `BT` stay uncapped. `F` changes the initial auto-flip before final placement. | Show both selected endpoint identities with drawing/view/level, real final brace preview, type A/B, stated cap result when relevant, flip state and orientation. Ambiguous background evidence is not a decided flip. |
| **Direct R1 / FJ1 route** | Approved target is two selected boundaries → visible in-bay marker placement → tag. The current source still prompts LEFT/RIGHT then TOP/BOTTOM picks; that is source evidence, not the approved replacement. `P1` remains hidden pending its lap rule. | Show the two selected boundary identities and one proposed marker inside that bay before the tag is accepted. Four-point entry is fallback only. A boundary that cannot resolve stays Unknown; no nearby line is adopted. |
| **Existing palette: review and switch** | `ABS` changes A/B without moving, resizing or reflipping. A support switch retains its centre, rotation, mark, label location and true beam relations. | Show Before / Current / Pending footprint or brace state, exact selected identity, current level/view and affected confirmed links. Review does not select a nearby label/beam or change unselected objects. |

## Support placement and switching

| Step | Support action | Drawing and relation boundary |
|---|---|---|
| **1. Pick physical centre** | Start a retained insert route. Select the actual local insertion point; C2 presents its approved member-size picker before placement. The support preview uses the block's physical centre. | Where a clear stud-wall pair exists, preview centring/alignment in that wall. Otherwise preserve the cursor-driven orientation preview and visible `R` rotation choice. No wall, level, mark or size is inferred from proximity. |
| **2. Inspect the compound** | Preview block footprint, type, source/Manual/Unknown state, rotation and schedule evidence. For a label-bearing support, show the true text box and label location; DS retains its approved no-label output. Place a label left/right/top/bottom only where that selected support owns one. | A label-bearing support is block + typed support data + owned label; DS is its approved no-label exception. Text alongside a support is not collected or deleted by a radius/proximity sweep. |
| **3. Confirm genuine contacts** | After support footprint is selected, highlight every beam end that genuinely touches that footprint, listing each identity and its drawing/view/level. | One support may link to several displayed beam ends. **Any ambiguous candidate**, including one ambiguous candidate, requires **Confirm selected links** or **Leave unconnected / Needs review**. Do not automatically link the nearest beam, a crossing or a same-looking mark on another level. |
| **4. Apply or switch selected support** | The final native placement click produces one support compound. To change type, preselect or pick one support then use the appropriate switch route; preview the target outline before the confirming native click. Retain centre, rotation, mark, owned label location and confirmed beam links. | `R` is optional, not a forced re-rotation. A switch changes selected type only; it does not recreate labels, scan the drawing or change an unrelated support. |

## Bracing and marker sequence

| Step | AB / BB / ABS | R1 / FJ1 | Boundary |
|---|---|---|---|
| **1. Select known inputs** | Pick first local endpoint, then use the completed preview to pick the second. **Enter at the second endpoint retains the familiar 2700 mm horizontal default** under ST2-11. | Select the two actual boundaries being spanned. | The command prompt, transient preview or existing palette shows each selected identity, drawing/view/level and source/Manual/Unknown state. An unselected background line is only evidence. |
| **2. Review full output** | Preview actual brace, orientation, A/B state and auto-flip suggestion. For AB, if the requested span exceeds the approved cap, preview stops at 2700 mm with `MAX` before placement. **BT** remains uncapped and its number is entered/accepted before placement so the preview shows the completed mark. | Preview direction/span and move the finished marker within the selected bay; then enter/accept its tag. | Do not invent a tag, span, orientation or lap. The retained Enter/default and BT-number prompts are ST2-11/13 daily behavior, not engineering selection. `P1` stays unavailable rather than borrowing R1/FJ1 behaviour. |
| **3. Accept a deliberate change** | Press `F` before the final click to reverse the initial flip. Use `ABS` only on selected existing braces to switch A/B. | The final native placement click accepts only the displayed marker in the displayed bay. | `ABS` cannot move, resize or reflip a brace. A visible marker suggestion never becomes an unseen decision. |

## Selected edit, MOVE, COPY, Cancel and reopen

| Event | Proposed truthful outcome |
|---|---|
| **Select/Edit** | The direct selection prompt or existing palette identifies one support/bracing/marker compound and shows its current geometry, source state, view/level, owned label and confirmed links. The existing palette or direct command detail offers Before/Current/Pending. Editing one repeated label is mark scope only; it does not edit another level's mark or linked objects. |
| **MOVE** | Preview the selected compound and owned label. Moving a confirmed support names every affected linked beam end and offers **Edit this only** (move support while retaining the existing mismatch/review state) or explicit **Edit together** (preview the confirmed endpoint updates for the stated linked-beam scope). Moving a brace or marker changes only its selected compound. |
| **COPY** | A support copy receives a fresh identity and no inherited beam links unless the beams are copied with it. A copied brace/marker receives a fresh identity and needs its own explicit selected inputs/relation review. No copied entity borrows original links, marks or orientation by proximity. |
| **Cancel/Escape** | Before the final native placement click, no new compound, relation, marker/tag or label is created. For a current source route that might have a different native boundary, this is the approved target, not runtime proof. |
| **Partial or stale preview** | Report graphics, owned label, identity, relation receipt and source/Manual state separately. If any may have been placed, inspect/read back before retry; retry needs verified absence or a safe-resume boundary. A changed selected input while preview is open requires Refresh, Park, Discard or Cancel. |
| **Save/reopen and Undo** | One accepted support, brace, marker or selected switch is one intended Undo target. Future evidence must separately read compound identity, current drawing/view/level, owned label, source state and confirmed relation. Visible graphics alone are not proof. |

## Fictitious floor-plan before/after

On a synthetic Level 1 plan, two beams end on the footprint of a proposed `DS1`; a third beam crosses nearby and the same support mark is visible on Level 2. The drafter selects Level 1, previews the physical-centre footprint and owned label, then sees the two genuine Level 1 contacts and the crossing/Level 2 candidates marked **not selected**. They confirm the two contacts, place DS1, then switch that selected support to `TS1`; centre, rotation, mark, label position and the two confirmed links remain visible.

In the adjacent bay, `AB` begins at one explicit endpoint. The requested second endpoint would exceed the approved cap, so the preview stops with `MAX` before the click; the drafter flips it with `F` and Cancels, leaving no brace. `BB` is then placed between its two explicit endpoints and later selected for `ABS`; only A/B changes. For `R1`, the drafter selects the two bounding members, moves the displayed marker within that bay, accepts a supplied tag and places it once. `P1` is absent. Copying TS1 to another bay makes a fresh unconnected support; no nearby beam receives a link until explicitly reviewed.

## Future representative acceptance

In AutoCAD, use the synthetic two-level floor plan to inspect: physical-centre support placement; clear/ambiguous wall orientation; schedule evidence plus Manual/Unknown override; multiple true footprint contacts and Leave unconnected; selected support switching with owned label retained; AB cap/`MAX` and pre-place flip; uncapped BB; selected `ABS`; two-boundary R1/FJ1 visual placement; hidden P1; MOVE/COPY/Cancel/Undo; stale/partial receipt handling; and save/reopen identities. Inspect the real drawing before claiming Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, external/corpus access or client-project scan occurred.





