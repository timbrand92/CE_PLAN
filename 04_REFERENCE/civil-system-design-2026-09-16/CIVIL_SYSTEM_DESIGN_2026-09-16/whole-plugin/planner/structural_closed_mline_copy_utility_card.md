# Structural closed-Mline and copy-multiple daily card

**Planning-only companion.** This closes a concrete ordinary-production gap for direct CML, COPYM and CEMCOPY routes. It preserves their current source observations and the ST-05 utility boundary; it does not establish a drawing result, native Mline semantics, working Help/ribbon route, Built, Tested, Installed or Tim-accepted state.

## Evidence and authority

| Route | Current named-source observation | Approved / planning consequence |
|---|---|---|
| CML | The command dispatches CeTextService.Run("CML"). That branch ensures or creates a CLOSED-ENDS Mline style, makes it the drawing/current CML style, then queues native MLINE. The style-setting transaction precedes the native placement. [Declaration](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/CeTextCommands.cs:85>), [dispatch](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:693>), [style/queue](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:1320>). | [ST-05](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>) governs safe Structural drawing utilities, but contains no detailed approved first-use CML sequence. Preserve the direct route as review-pending; the native handoff, transient status and optional-inspection contract below is **Proposed**, not an approved geometry rule. |
| COPYM / CEMCOPY | Both dispatch the C helper. It accepts an implied selection if one exists or passes control to native COPY; it sets the native `COPYMODE` system variable to `1` and attempts to restore the prior setting afterwards; source here does not establish the resulting native copy behavior. The fallback queues native COPY after an exception. [Declarations](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/CeTextCommands.cs:87>), [copy helper](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/CeTextService.cs:1766>). | Keep the familiar aliases for review. They remain a native copy aid, not proof that a copied element retains member/detail/engineering relationships. Existing approved compound copy rules continue to govern beams, details, labels and schedules. |

## Proposed everyday sequence — retain direct native drafting

`CML`, `COPYM` and `CEMCOPY` remain direct familiar command aliases. They do not open a compulsory review window, wizard or setup page. A shared inspector may show optional detail after a command, but it is not required to start, place or copy ordinary local drafting.

| Step | Direct drafter action | Transient status / optional detail |
|---|---|---|
| **1. Start CML** | Type `CML` or use its existing direct discovery route. The command prepares the `CLOSED-ENDS` Mline style then hands straight to native `MLINE`, preserving native point prompts. | A short command-line status names the active style and current layer. It does not infer a design purpose, width, depth, layer or engineering identity. Optional **Inspect drawing utility** can show current/previous style state if the user opens it. |
| **2. Place or cancel native geometry** | Use normal native Mline points and native Cancel/Escape. `CML` supplies a CLOSED-ENDS style only; it does not add a Close keyword or require a closed polyline/Mline loop. | If a transient preview/status is available, it shows selected points and style only. The observed source sets the current style before queuing Mline with no observed rollback, so Cancel cannot be reported as restoring every drawing setting without future readback. |
| **3. Copy normally** | Type `COPYM`/`CEMCOPY` with an implied selection, or use native COPY selection when none is implied. Native prompts remain the ordinary production route. | A brief status can name explicit versus native-prompt selection. The helper's `COPYMODE=1` attempt is source behavior only. Optional inspector detail is for an uncertain copy result, not a required pre-copy gate. |
| **4. Only where an owned relationship is relevant** | Copying a beam, detail, label, schedule view or footing uses its own already-approved relationship rule at the relevant command/card. An ordinary local object follows native COPY. | The utility itself neither invents a relationship nor suppresses an approved owned-copy choice. A copy whose native outcome is uncertain is **Unknown/Partial** until inspected; retry needs verified absence or safe resume. |
| **5. Inspect later if needed** | Use native Undo/save/reopen normally. Open the optional inspector only to review style state, original/copy identity, manual placement or a partial receipt. | Applied-in-open-drawing and later saved/reopened evidence are separate future AutoCAD checks. No automatic save occurs. |
## Manual, revision and partial boundaries

| Event | Proposed treatment |
|---|---|
| Existing closed-Mline style already present | Show it as a drawing asset; do not overwrite its properties or call it an Approved office standard merely because its name matches. |
| Mline is proposed in an Xref/locked/foreign context | Retain native refusal/protection. No unlock, detach, explode, clone or alternate local geometry is supplied. |
| A current style is changed but native Mline is later cancelled | Treat geometry and drawing-setting states as separate. The current source establishes only that style setup occurs first; actual AutoCAD effect/reversal is unverified. |
| Copying an object with a manual position | Retain the manual presentation on the eligible copied view/object only where its own approved card says so. A generic COPY helper cannot reset or propagate other manual positions. |
| Copying existing detail versus creating a new detail | Existing detail COPY uses the approved same-member/new-member/independent-detail choice. First detail for a copied member binds the selected copied member or Manual; this utility does not reopen that decision. |

## Fictitious before/after

On a synthetic local drawing, the drafter types `CML`. A short command-line status names the CLOSED-ENDS style and native Mline starts immediately. They Cancel and later use optional inspection to check geometry and style state separately.

They then select one ordinary local object and use COPYM. A brief status identifies the implied selection and states that it carries no newly inferred member/detail relation. After the native command, the drafter checks the result. If an existing linked detail was copied, the next review presents the already-approved detail-copy choice; if it was only a generic local object, it remains an independent copy.

## Future representative acceptance (not performed)

1. Start CML where a closed style is absent and again where it already exists; Cancel before and during native placement, then inspect Mline geometry and current style separately.
2. Place one local Mline, Undo once, save/reopen, and confirm the actual native visual result before claiming its caps/style/scale behavior.
3. Run COPYM with implied selection and with no selection; cancel and inspect for a new object, then copy a member with a linked detail and verify its governed copy-choice door appears.
4. Repeat against Xref/locked/REFEDIT content and confirm native protections remain intact.

## Links and limits

- [ST-05](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-05_HATCHING_UTILITIES_XREFS.md>) remains authority for utility safety; [registry-gap disposition](structural_registry_gap_dispositions.md) retains CML for review rather than promotion.
- [Text/tag daily card](structural_text_tag_daily_card.md) owns annotation relationships; [section/detail daily card](structural_section_mark_daily_card.md) and [standard-detail card](structural_standard_detail_library_daily_card.md) own their copy semantics.
- No Mline dimensions, structural purpose, asset default, layer default or engineering value is proposed. Runtime native behavior, ribbon/Help visibility, Undo and save/reopen are not tested.



