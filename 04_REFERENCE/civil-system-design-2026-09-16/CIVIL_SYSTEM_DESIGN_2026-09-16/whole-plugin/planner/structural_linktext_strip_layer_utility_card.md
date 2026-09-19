# Structural text-link and strip-layer utility card

**Planning-only.** This is a narrow W11 companion for two direct Administration/System routes: `STRUCLINKTEXT` and `STRIPLAYERSMERGE`. It does not create a new text editor, layer policy, foundation design rule, repair host or shared settings workflow.

> **Read with:** [text/tag daily card](structural_text_tag_daily_card.md), [W11 inspect/repair boundary](structural_w7_w11_interaction_cards.md), [source command/window ledger](structural_source_command_window_ledger.md) and [whole-job journey](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md). Source facts are limited to [UtilityCommands.cs:147–181](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/UtilityCommands.cs:147>), [LinkService.cs:17–39](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/LinkService.cs:17>) and [CeTextService.cs:496–501](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:496>), [4220–4317](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:4220>). They are not runtime, Undo, persistence or acceptance proof.

## `STRUCLINKTEXT` — direct two-pick presentation relation

| Current source observation | Planning consequence |
|---|---|
| The command preflights, prompts for a parent entity, then requires a DBText or MText entity. Cancel at either selection returns before the transaction ([UtilityCommands.cs:147–175](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/UtilityCommands.cs:147>)). The parent prompt wording mentions block/line/polyline but source does not enforce a parent class. | Retain a direct command/native two-pick flow, with no mandatory setup window. A draft must show actual picked parent and label identities and reject/park any unsupported/protected relationship through native protections; a nearby object never supplies a parent. |
| After both picks, source creates a new uniquely named AutoCAD Group containing the two identities and commits immediately ([LinkService.cs:17–39](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/LinkService.cs:17>)). The current command supplies no source-observed preview, group receipt or post-pick Cancel. | The current effect is a drawing grouping relation. It does not establish an engineering parent, schedule relation, source adoption, calculation link or authorisation to modify either object. Group persistence, native transform effect and Undo behavior stay Unknown until future AutoCAD qualification. |

### Proposed ordinary use

1. Type `STRUCLINKTEXT`; pick one explicit eligible local parent, then one DBText/MText label. Existing native prompts and transient drawing emphasis are sufficient; no extra modal window is proposed.
2. Before a **Proposed** confirmation, show parent identity/type, text identity/content/type, current drawing/layout/space and **presentation link only**. The drafter may Park, choose a different explicit identity, or Cancel. Manual label location is retained; the link does not move/reformat the label.
3. A proposed receipt distinguishes **linked**, **not linked**, **unsupported/protected**, **partial/unknown** and the generated relation identity where later implementation exposes it. A requested change to an engineering designation token remains a separately reviewed value edit under the text card, never an effect of linking.
4. Copy, parent erase, text erase, native transform, Undo and save/reopen require future acceptance against the actual native group result. The plan cannot claim that the group makes objects move together, creates a fresh copy relation, or survives every native command merely because source comments describe an intended native setting.

**Fictitious drawing:** On a synthetic framing layout, the drafter selects a local beam line and its existing manually positioned DBText label. The transient result says “presentation link only”; Cancel leaves them unlinked. On confirmation, both retain their locations and the drawing gains only a reviewed grouping relation. A later designation edit is reviewed separately; it does not silently alter a beam record.

## `STRIPLAYERSMERGE` — source-observed immediate migration, Proposed review gate

| Current source observation | Planning consequence |
|---|---|
| The direct command immediately calls `MergeStripFootingLayersNow`; its body has no selection, prompt, preview or Cancel ([UtilityCommands.cs:177–181](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/UtilityCommands.cs:177>)). | Keep it out of ordinary daily discovery while its reviewed target is pending. Direct declaration is not approval to expose an irreversible-looking layer migration as a routine action. |
| Source first ensures/sets the canonical strip-footing layer, then scans non-Xref block-table records. It moves entities on source-defined alias layers to the canonical layer; entity failures are caught and processing continues ([CeTextService.cs:4220–4273](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:4220>)). | Current behavior can mutate drawing layer state before any visible count/selection. It does not prove protected-object behavior, complete scope, or a clean all-or-nothing outcome. Source-defined aliases are not reproduced here as a new office layer policy. |
| It later tries to erase alias layers, skipping dependent, erased, locked and current aliases; erase failures are counted, then the transaction commits. Counts appear only in a debug call ([CeTextService.cs:4276–4317](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:4276>)). | Treat result as potentially partial: moved, not moved, alias erased, alias retained/skipped and unknown must remain separate. Source does not establish a user-facing receipt, rollback, external-reference safety beyond its own BTR skip, or an Undo boundary. |

### Proposed expert review interaction

1. Start from controlled review discovery, not a routine drafting shortcut. Inspect source-defined canonical/alias scope, non-Xref block-table-record scope, candidate entity count, candidate alias-layer count, protected/skipped conditions, current-layer implication and any source-defined exclusions. This does not create a new layer naming policy.
2. Preview **Move**, **Cannot move**, **Alias erase candidate**, **Alias retained/skipped**, **Unknown** and **No change** rows by actual identity/count. The action must not infer that a matching-looking layer is safe, alter Xref/REFEDIT/locked/dependent content, or change foundation engineering.
3. A **Proposed** explicit confirmation may apply one reviewed scope and returns a factual moved/retained/erased/failed/unknown receipt. Cancel before confirmation removes the preview only. The current source’s immediate mutation is an observation, not approval of this target sequence.
4. If any mutation is partial or receipt is uncertain, Park and inspect the affected local drawing state before any retry. Do not rerun a broad merge automatically, delete retained aliases by inference, or claim drawing Undo/save/reopen will restore external/native state. Root-owned layer presentation policy and future native acceptance decide whether this route is retained, modified, hidden or retired.

**Fictitious drawing:** On a synthetic local foundation draft, the expert review shows four alias-layer entities: two movable, one on a locked layer, one in an unsupported scope. The proposed preview keeps the latter two visibly retained and names one alias that cannot be erased because it is current. The drafter Cancels; no proposed mutation occurs. In a later reviewed run, one accepted scope returns moved/retained/unknown counts, so it is Parked for local inspection rather than run again.

## Future representative acceptance

Use synthetic drawings only to inspect: two-pick Cancel before/after parent selection; explicit parent/text identity; the produced group’s real behavior across MOVE/COPY/erase/Undo/save/reopen; text Manual position preservation; immediate legacy layer-merge state before its proposed gate; candidate scope across local/non-Xref records; locked/dependent/current/unsupported exclusions; partial move/erase receipt; Cancel; retry after readback; and no calculation/issue/source-adoption side effect. Open the real drawing state and result artifacts before calling any route Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, provider/corpus access or client-project scan occurred.
