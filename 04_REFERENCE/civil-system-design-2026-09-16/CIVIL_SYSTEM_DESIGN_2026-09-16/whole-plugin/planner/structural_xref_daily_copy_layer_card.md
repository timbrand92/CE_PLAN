# Structural Xref copy and reference-layer daily card

**Planning-only daily companion.** This is a reviewable end-user proposal for the retained CXREF, PXREF and XRL routes. It records source observations separately from the governing approved requirement in [ST-05](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>). It is not evidence that any route is Built, Tested, Installed or Tim-accepted.

## Authority and current-source boundary

| Route | Approved daily result | Named source observation | Planning status |
|---|---|---|---|
| CXREF → PXREF | Preserve selected reference attachment/**overlay** kind, path type, insertion, scale, rotation, Xclip, layer overrides and units. The target drafter chooses **Original coordinates** or **Pick location**, sees the unit check and preview, and a missing path blocks safely. Source DWGs and their internal layers are never edited. | CXREF asks for one BlockReference, rejects a non-Xref, captures path, insertion, XYZ scale, rotation, Xref-layer state and Xclip, then writes a local clipboard. PXREF resolves a path, calls AttachXref, creates the reference at the captured insertion and applies stored layer states/Xclip. It has no observed Pick-location, unit-check, overlay-preservation or pre-apply preview route. [Legacy commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:32>), [copy](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeCopyPasteXrefService.cs:58>), [paste](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeCopyPasteXrefService.cs:111>). | **Modify proposal.** The approved ST-05 outcome governs; current source is evidence only. |
| XRL | First report the selected/reference scope and target layer, highlight only reference instances, then confirm the reviewed drawing change with one drawing Undo. Never alter an Xref source drawing or its internal layers. | Current XRL reads settings/stats, ensures the target layer, iterates Xref BlockReference objects in layout records, assigns their host-drawing layer, and commits in one Undo-mark scope. It has source cancellation/progress for large batches, but no observed candidate preview/highlight or per-reference confirmation. [Layer service](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/NativeXrefLayerService.cs:24>). | **Modify proposal.** Reference-only scope is observed; preview/confirmation is proposed. |
| XRLFAST, XRLSILENT, XRLINFO, XRLCONFIG | Retain discoverability only after the normal visible route has the reviewed preview/receipt. Expert or fast shortcuts cannot bypass the approved scope, protection or receipt. | They call fast/silent/info/settings variants of the same services. [Legacy commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:20>). Visibility/discovery is a registry observation, not runtime proof. | **Unknown transition decision.** No retirement or silent bypass is proposed here. |

## Daily coordinated-plan sequence — proposed target

A drafter has an approved coordination drawing open and needs the same consultant reference in a second drawing. The scenario names no client, path or engineering value.

| Step | What the drafter sees and does | Main / More action and result |
|---|---|---|
| **1. Select the reference** | **Main: Copy reference** highlights the selected Xref instance and shows reference name, attachment or overlay, source/path status, insertion, scale, rotation, Xclip, host-drawing layer overrides and units. It labels every value **Current source**. A local block, nested content, locked/Xref-internal object or unresolved identity is refused without a substitute. | **Copy** records a pending reference packet only. **Cancel/Escape** leaves the source drawing and any prior packet unchanged. The packet is not a drawing edit or engineering adoption. |
| **2. Open the target drawing** | Activate the intended target drawing before **Paste reference**. The route identifies the actual active target drawing and source packet, then revalidates that target immediately before Apply. An evidence/document override cannot retarget a pending paste. It compares stored source units with target units and flags **Unknown** where the comparison cannot be established. | **Original coordinates** and **Pick location** are visible alternatives. Pick location must show the new insertion before Apply; it never implies a scale or rotation change. **Cancel/Escape** makes no target reference. |
| **3. Review the complete preview** | The large preview shows source-versus-target identity, attachment/overlay kind, path type, insertion/scale/rotation, Xclip boundary, each layer override, units result and any missing path. It states whether the original target drawing has changed since the packet was copied. | **Apply reference** is enabled only when a valid path and required unit decision are present. A missing path remains **Missing** and blocks Apply; it cannot be silently relocated, attached from a nearby file or approximated. |
| **4. Commit and receipt** | After Apply, the result identifies the created target reference, chosen placement mode, the fields carried forward and the result of each post-placement item separately: reference placed, layer overrides applied, Xclip applied. It labels this **Applied in open drawing**, not saved. | **Applied** receipt reports the verified-in-open-drawing components separately: reference placed, overrides applied and Xclip applied. It does not require a save. **DWG saved** is a later, separate state that needs save/reopen evidence before it can be reported. Undo is one target-drawing action when implemented. If any applied component is Partial/Unknown, the receipt says so and **Review / inspect** comes before retry; no blind second paste creates a duplicate. |
| **5. Move only host-drawing reference instances (XRL)** | **Main: Reference layer** first shows existing target layer/configuration and the candidate *reference instances* in the active host drawing. It highlights candidates but excludes Xref source DWG content and ordinary/nested non-reference drawing objects. | **Apply selected scope** presents count and target layer, then makes one reviewed host-drawing layer change. **Cancel/Escape** at preview changes nothing. The source service's early target-layer setup and direct batch commit are observations, not the proposed cancellation contract. |
| **6. Review later change** | On reopen, select the target reference and compare its receipt against current path/load state, placement mode, Xclip and overrides. A changed path, clip, override or target reference identity becomes **Needs review**; it does not overwrite the previous receipt. | **More: Inspect reference** is read-only. **Replace/re-paste** is a new proposed review packet, not automatic refresh. A reference-layer move does not change the source file or recreate the reference. |

## Boundaries and retained manual choices

| Situation | Proposed outcome |
|---|---|
| Source reference is an overlay | Show overlay as a required preserved property. Current PXREF always calls AttachXref, so it does not prove this approved requirement is implemented. |
| Original-coordinate packet copied before source changes | Display packet revision/time and current source identity. A difference requires review before target Apply; newer is only a candidate. |
| Drafter deliberately chooses Pick location | Bind the pending placement to the selected target point and retain Original coordinates as an alternate. Neither choice changes scale/rotation/unit values by implication. |
| One post-placement action has uncertain outcome | Separate **placed**, **overrides**, and **Xclip** receipts. Inspect existing target reference and collision state before any retry. |
| Existing manual target-layer choice | Preserve it until the drafter confirms the XRL scope. Candidate membership is based on explicit reference identity, never proximity to Xref graphics. |
| Protected/foreign content | Native locked-layer, Xref, REFEDIT and unsupported-object protections remain. This card supplies no bypass. |

## Fictitious before/after review example

**Before:** Plan A contains one selected overlay reference with a visible crop and host-drawing layer overrides. Plan B has no corresponding reference.

**Preview:** CXREF identifies the selected reference. In Plan B, the Paste review shows the packet, a unit comparison, both placement choices and the crop/override list. The drafter selects **Pick location**, sees the proposed reference in the target plan and finds its path Missing. Apply remains unavailable; Cancel creates nothing.

**After a later valid-path review:** the drafter applies once and sees separate receipts for placed reference, overrides and crop. A subsequent **Reference layer** review highlights only the target drawing's reference instance; Cancel leaves it on its existing host layer. An accepted Apply changes only that reference instance's host-drawing layer and offers one Undo.

## Future representative acceptance (not performed)

1. Copy an attachment and an overlay separately; verify the target preview and receipt distinguish their type, path mode, insertion, scale, rotation, Xclip, overrides and units.
2. In a second drawing choose Original coordinates, then repeat with Pick location; Cancel each preview and confirm no target reference was created.
3. Attempt a missing path and confirm the target blocks without a nearby-file substitution; reopen after a partial post-placement result and inspect before retry.
4. Run the ordinary Reference-layer review with one Xref reference, ordinary local geometry and protected content; only the explicit reference candidate may be changed, with one Undo.

## Links and limits

- [ST-05 full decision](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>) is the canonical authority for ST5-11–12; [approved reconciliation](structural_approved_card_reconciliation.md) preserves the compressed cross-family rule.
- [W2 workflow family](structural_workflow_cards.md) remains the master Structural entry. This card adds ordinary user interaction; it does not replace root-owned project/settings/issue contracts.
- Source-side file writing, AutoCAD native Xref attachment behavior, visual output, Cancel/Undo/save/reopen and failure outcomes need future runtime evidence. No runtime test was performed.


