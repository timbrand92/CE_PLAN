# Structural `CE_INSPECT` — selected-evidence export card

**Planning-only.** This card closes one narrow W11 seam: the direct `CE_INSPECT` evidence export. It neither creates a repair workflow nor changes root-owned project properties, reports, sheets, issue, calculation or provider paths.

> **Read with:** [W11 inspect/repair boundary](structural_w7_w11_interaction_cards.md), [direct export scope card](structural_direct_export_scope_card.md), [registry disposition](structural_registry_gap_dispositions.md) and [whole-job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Current-source facts below are limited to [InspectCommands.cs:17–88](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:17>) and its inspected field helpers. They are not runtime, file-persistence or acceptance proof.

## Observed route and its boundary

| Current source observation | Planning consequence |
|---|---|
| `CE_INSPECT` is a modal command. Its source first obtains command context/preflight, then uses the native selection prompt “Select entities to inspect” ([lines 17–34](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:17>)). A non-OK or empty selection writes “No entities selected” and returns. | It stays a direct command/prompt route. This card proposes no mandatory window, wizard or repair surface. Preflight side effects and native selection behavior remain untested. |
| Selected entities are opened `ForRead`; current records include type, handle, object identity, layer, linetype, colour, visibility and, where available, space/extents ([lines 38–54](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:38>), [91–143](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:91>)). Type helpers may add drawing properties such as block attributes/dynamic properties, text, table cells, polyline geometry, hatch or dimension fields. | The export is evidence about selected drawing objects. It is not a statement that the objects are current, structurally adequate, adopted into a calculation or safe to repair. A helper’s absent field is **Unknown/unavailable**, not a replacement value. |
| Current output path is a whole-second timestamped `CE_INSPECT_*.json` in the drawing folder, falling back to Desktop when that folder is blank/missing ([lines 56–75](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:56>)). `File.WriteAllText` has no existence guard. The JSON includes drawing path, export time, **successfully added record count** and entity records; that count is not proven to equal the original native selection. | The source does **not** establish a user-selected destination, collision policy, atomic file write, readable-result proof or privacy-safe sharing. Same-second/retry collision is a current risk, not a user chooser. Planner records must never reproduce an inspected drawing path or content. |
| Per-field helper exceptions are swallowed in several places; the outer command catches an exception through `Fail` ([lines 77–88](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/InspectCommands.cs:77>)). | A successful-looking command message is not enough to call every entity/field complete or the file persisted. The Explorer launch catch follows the file write, so Explorer failure does not itself reverse a written file. Future evidence needs original-selection versus successfully-recorded identity/count and artifact readback. |

## Proposed ordinary direct interaction

The following is a **Proposed** review contract, not a claim that the current direct command has these controls.

| Step | Drafter action | Proposed visible result and limit |
|---|---|---|
| **1. Start and select local evidence** | Type `CE_INSPECT`, then select only the local entities to inspect through the native selection prompt. | Transient status names original selected identity, type, drawing/layout/space where known, and count. Xref, protected or unsupported identities are shown as such; no nearby entity is added and no object is edited. |
| **2. Review evidence scope** | Before accepting the evidence export, inspect **Selected**, **Unavailable/field omitted**, **Excluded/protected**, and **Needs review** rows. | Each row preserves its identity and reason. A missing property, helper exception or unrecognised object remains Unknown; it does not become a design assumption, a repair instruction or an engineering conclusion. |
| **3. Confirm one evidence export** | Confirm the selected scope once, understanding that the current source names a timestamped JSON destination rather than offering one. | The planned receipt distinguishes selected count, fields actually recorded where later readback proves them, omissions, output path/state and any failure. It says **evidence export only**: no calculation, source adoption, project record, drawing repair, revision or issue is changed. |
| **4. Inspect result before sharing or retrying** | In future acceptance, open/read the produced artifact and compare its identity/omission receipt with the selected scope. | Keep **written/readable**, **unwritten**, and **partial/unknown** distinct. Before a retry, inspect the named target path and any artifact already present; do not repeat a scope merely because the command reported failure. |

## Cancel, save/reopen and manual boundary

| Event | Source fact or Proposed outcome |
|---|---|
| Native selection Cancel / empty selection | **Source-observed:** returns before the JSON-writing block. The proposed receipt records No selection and creates no new proposed evidence receipt. This does not prove no external preflight/native side effect. |
| Cancel before a proposed confirmation | **Proposed:** remove transient selected-scope review only; do not write a new evidence artifact, alter object data, adopt evidence or create a repair plan. |
| Changed/deleted selected object while review is pending | **Proposed:** show Before / Current / Pending identity evidence, mark only the affected row Needs review, and require a fresh selection or explicit removal. Do not silently inspect a replacement with a similar appearance. |
| Same-second/retry target collision | **Proposed:** preserve the prior JSON and show its target/state before a new write. Park/Cancel, or use a separately reviewed unique-name policy; do not claim a current filename chooser or quietly replace it. |
| Partial/unknown output | **Proposed:** retain original selected and successfully-recorded identities/counts, observed omissions and target-path state as an evidence receipt. Re-open/read the actual target before retrying; a missing field is not proof the object was absent. |
| Drawing save/reopen | **Bounded source observation:** inspected body opens selected entities for read; it also writes an external JSON. Future acceptance separately proves drawing non-mutation, artifact existence/readability and no project/issue/revision side effect. The untraced preflight remains Unknown. |
| Manual/pinned information | **Proposed:** retain it as selected evidence/status if present; never convert it into a governing structural decision, revise it, or use it to auto-repair another object. |

## Fictional example and representative acceptance

On a synthetic Level 1 drawing, a drafter selects one ordinary local beam label, one manual note and one protected reference item. The transient scope shows the two inspectable identities, the protected exclusion, and any field that cannot be read. After one confirmation, the artifact is opened and its receipt is compared with the selected identities. The manual note remains manual evidence; neither the beam nor the note gains an engineering status. If the artifact is missing or partial, the drafter inspects the target first, then starts a new reviewed selection rather than duplicating an uncertain export.

Future AutoCAD acceptance should use a synthetic drawing to inspect native selection Cancel, a mixed selected/unavailable/protected scope, actual JSON output location/readability, original-selection versus successfully-recorded count, same-second target collision preserving prior JSON, omitted helper fields, target-file state before retry, Explorer-failure separation, drawing save/reopen, and absence of repair/project/issue/calculation side effects. This requires real artifact inspection; no current plan or source read is a test.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, provider/corpus access or client-project scan occurred.


