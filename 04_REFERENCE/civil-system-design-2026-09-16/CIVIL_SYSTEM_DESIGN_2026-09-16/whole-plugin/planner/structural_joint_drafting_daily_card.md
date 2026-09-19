# Structural joint-drafting daily card

**Planning-only companion.** This covers direct CJ, SSC and CJSS drawing utilities. They remain drafting annotations/linework; a joint label or layer does not prove reinforcement, structural adequacy, construction instruction approval or issued status.

## Current source observation and planning status

| Route | Named current source observation | Required planning treatment |
|---|---|---|
| CJ / SSC | Each saves system variables, prepares an output layer, prompts start/end points, creates a line, then resolves/optionally prompts label side and creates text. Current source can have a line created before label creation later fails/cancels, forces a quick save after success, then restores system variables/saves settings. [Commands](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:81>), [route](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/JointDraftingService.cs:18>). | **Modify proposal.** Preserve familiar point prompts and CJ/SSC visual distinction, but do not call a partially created line a complete joint or allow the utility to force an unreviewed drawing save. |
| CJSS | Ensures both output layers, lets the user select lines/polylines/text/MText, swaps eligible selected entities between those layers and swaps text tokens, commits one transaction, reports counts, then forces quick save. [Swap](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/JointDraftingService.cs:110>). | **Modify proposal.** It needs selected-scope preview/counts and a truthful skipped/partial receipt. It cannot sweep nearby joint-like content or claim all selected geometry remains semantically consistent after a text/layer swap. |

## Direct native drafting sequence — proposed

| Step | Drafter action | Transient preview / output boundary |
|---|---|---|
| **1. Start the familiar route** | Type CJ or SSC. Native-style prompts collect two explicit local points. The active drawing/layout/view and selected CJ/SSC type appear in a brief command-line status. | The prompt does not infer a joint from a crossing, hatch, nearby label, Xref or prior setting. Protected/foreign content retains native protection. |
| **2. See the complete local result before commit** | A lightweight live preview shows the proposed joint line, label token, text side/orientation and target local layer. Where side is ambiguous, retain an explicit mirror choice. | The confirming native placement click is the proposed one-operation receipt for line **and** label together; it does not add a second modal confirmation. Cancel/Escape discards the preview. Current source's line-before-label ordering is an observed partial-output risk, not the target contract. |
| **3. Edit a selected joint later** | Select an explicit recognised CJ/SSC compound. Native edit/MOVE keeps the line and its linked label relationship visible; a direct manual label move remains presentation. | A user-supplied label/type edit remains a drawing operation and does not grant engineering approval; changed construction/engineering intent stays with its authorised owner before adoption. A copied joint receives a fresh local identity; it does not carry a new construction decision to another location by implication. |
| **4. Swap only reviewed entities (CJSS)** | Select intended recognised joint line/text entities. The transient preview lists CJ→SSC, SSC→CJ and skipped selections separately, showing line/text identity and any label-token change. | The one explicit selected-swap confirmation alters only previewed eligible entities. Cancel leaves all selected layers/text unchanged. A skipped entity remains visible in the receipt; no bulk retry over an uncertain mixed result. |
| **5. Finish without hidden issue action** | Native Undo is the ordinary recovery action. Saving remains the drafter's decision. | Current ForceQuickSave is source evidence, not an approved target. A later saved/reopened drawing state is separate from Applied-in-open-drawing receipt. |

## Revision, manual and partial boundary

| Situation | Proposed outcome |
|---|---|
| Point/label ambiguity | Show both candidate sides and retain deliberate manual choice. Do not use proximity as confirmation. |
| Label creation fails after a line was placed in current route | Target reports **Partial** only if readback finds line without label; offers Inspect / Undo selected result, never silently calls it a completed joint. |
| CJSS selection contains ordinary text or line | It is skipped unless it is an explicitly recognised eligible joint entity. The result lists the reason. |
| Existing manual label position | Retain the accepted manual presentation. A new pending auto-placement suggestion requires review but does not reset it. |
| Save/reopen | Future proof reads line, label, explicit relation, layer/type, manual position and receipt separately. A displayed CJ/SSC token alone is insufficient. |

## Fictitious daily drawing example

On a synthetic local slab plan, the drafter types CJ, chooses two local points and sees the full line/label preview. They mirror the label to avoid another mark and confirm native placement once for one joint compound. They then select two recognised joints for CJSS; the preview shows one CJ→SSC, one SSC→CJ and an unrelated line skipped. Cancel leaves all three unchanged. They rerun `CJSS`, confirm the same selected swap once, then Undo it; no automatic save happens.

## Future representative acceptance (not performed)

1. Place CJ and SSC with clear and ambiguous label side; inspect line/label identity, output layer/type, manual label move, Cancel and one Undo.
2. Cause a label creation failure in a synthetic drawing; confirm the receipt identifies a partial line and offers only safe inspect/Undo, not a completed joint.
3. Use CJSS with eligible lines/text, ordinary local objects, Xref and protected entities; inspect preview counts, skipped reasons, text/layer changes, Cancel, partial result and save/reopen.
4. Confirm no joint action forces a drawing save and no joint label becomes an engineering/issue conclusion.

## Links and limits

- This is a direct utility proposal because the current approved cards do not provide a complete joint-drafting sequence. It introduces no design values or construction specification.
- Source has not been run. Native visual output, protections, direct cancellation, Undo, quick-save behavior and save/reopen require future AutoCAD evidence.



