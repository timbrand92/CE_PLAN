# Structural daily reinforcement placement — RBL/RBC compound card

**Planning checkpoint:** 2026-09-17T01:03:26.2228938+10:00. This is the underdescribed daily drafting group found by comparing the broad W6 reinforcement row with the approved [ST-06 Foundations and rebar card](C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-06_FOUNDATIONS_REBAR.md) decisions ST6-2, ST6-4, ST6-13 and ST6-14. It deepens the retained **RBL** and **RBC** routes only. `CE_REBARLINE` and `CE_REBARCIRCLE` remain source-observed companion identities; this card does not independently classify their ordinary discovery state. It does not redesign foundations, calculation, schedules, steel-detail libraries or unapproved command identities.

> **Read with:** [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md) W6-B, [approved reconciliation](structural_approved_card_reconciliation.md) ST-06 boundary, [workflow cards](structural_workflow_cards.md) W6, and [dependent-draft review card](structural_dependent_draft_review_card.md). Current dialog/source observations are not runtime proof. Main/More placement below is a proposal where ST-06 did not decide it.

## Scope and retained discovery

| Discovery surface | Retained daily route | Boundary |
|---|---|---|
| **Foundation workspace Main** | RBL line arrangement and RBC circular arrangement remain familiar, direct daily drafting routes under ST6-2. Entry may start with preselected eligible local geometry where that route supports it, or with the familiar command/alias. | Selection is explicit. A nearby slab edge, member, label or background object never becomes a host, source or relationship by proximity. |
| **More: reinforcement review** | Review provenance, Manual/Designed/Confirmed/Assumed/Unknown state, compound label position, source/revision, selected identity, copy/edit history and recovery receipt. | More does not create a second reinforcement library or select a bar/spacing value for the user. |
| **Transition/hidden routes** | `STR` and `BWT` are approved for removal from ordinary command registration under ST6-14. Current source sharing does not decide a daily discovery state for the named `CE_STIRRUP` or `CE_BARWEIGHT` identities. | Do not expose a speculative replacement or silently route a familiar action to a different engineering behavior. |

## Main daily placement sequence

| Step | RBL — line arrangement | RBC — circular arrangement | Output boundary |
|---|---|---|---|
| **1. Start and identify scope** | Show selected local geometry, if any, plus drawing/view/level and source/Manual/Unknown state. If the user draws a path, show the exact proposed path. | Show selected local geometry, if any, plus the exact picked centre and drawing/view/level. | The route never turns background/Xref/REFEDIT/locked/unsupported content into editable local geometry. Unknown relationship stays Unknown. |
| **2. Enter/review explicit information** | Show user-entered bar identity, spacing, zone, orientation and any route-specific label text with provenance beside every available field. | Show user-entered bar identity, count, zone, orientation and the picked radius. The UI states clearly that the radius is the **bar-centre radius**. | No field is filled from historical popularity, a mark, nearby text or a silent zero. Missing information remains Unknown with an honest warning. |
| **3. Inspect one compound preview** | Preview line, end ticks, orientation, exact final label and proposed label position as one compound. | Preview circular arrangement, bar-centre radius, orientation, exact final label and proposed label position as one compound. | Preview identifies selected driver/path, layer/state where available, Manual/pinned presentation and any missing/protected condition. It is not an engineering adequacy result. |
| **4. Apply one selected result** | Apply creates one editable reinforcement compound: geometry + graphics/ticks + owned label + recorded selected/provenance state. | Apply creates one editable reinforcement compound: arrangement graphics + owned label + recorded selected/provenance state. | One accepted compound is one future Undo target. It neither creates a schedule row nor changes an unrelated host, detail or calculation. |
| **5. Repeat or finish** | Continue only by an explicit next local selection/path; Esc ends the pending placement sequence. | Continue only by an explicit next local centre/selection; Esc ends the pending placement sequence. | Esc before Apply has no proposed output. Whether current runtime follows this is a future AutoCAD evidence gate. |

## Everyday edit, Move and COPY behavior

| User action | Proposed visible result | Preservation rule |
|---|---|---|
| **Select existing reinforcement compound** | Header names stable compound identity, drawing/view/level, driver/path or picked centre, source/revision, field provenance and manual label position. | A visible label alone is not the compound. No nearest-text or nearby-host recovery. |
| **Move compound** | Preview geometry and owned label travelling together. Show any affected selected relationship as review information. | The approved RBL behavior is that MOVE carries graphics and label. It does not move a host, foundation compound, schedule view, calculation or an unrelated mark. |
| **Move/format label presentation** | Main exposes owned-label placement and ordinary presentation formatting; More exposes source/provenance comparison. | Moving/formatting the owned label does not disconnect it. A deliberate manual position remains Manual/pinned and is not reset by a future saved default. |
| **Request to edit engineering designation tokens** | If the displayed label token would change bar identity, spacing, count, zone or orientation, show old label, embedded basis/provenance and proposed text. Actions: **Review value edit**, **Keep drawing-text mismatch for review**, or **Cancel**. | A text edit never silently changes embedded reinforcement basis or falsely remains synchronized. A reviewed value edit needs its own source/Manual/Unknown state and output receipt; mismatch remains visible until resolved. |
| **COPY compound** | Preview source and fresh target identities plus explicit destination drawing/view/level. | COPY creates an **independent reinforcement item**. It does not duplicate host relationship, engineering approval, source basis or a complete schedule claim. |
| **Edit this only / Edit together** | Edit this only is available for the selected compound/owned label only. Edit together appears only after preview names each confirmed selected relation and exact proposed change. | Edit this only is non-sticky and leaves any discrepancy for later QA. Edit together never reaches a similar-looking line/circle, copied compound or nearby foundation by inference. |

## Cancel, partial, revision and reopen contract

| Situation | Proposed truthful outcome |
|---|---|
| Cancel/Esc before Apply | No new reinforcement compound. Existing compounds and manual positions remain unchanged. |
| Cancel after a current direct route has committed | Do not promise rollback. Read/review the actual compound/output state before any recovery; native Undo is a separate future proof. |
| Geometry is placed but owned label/provenance receipt fails | Report **Partial** with geometry identity, label state and source/provenance state separately. Do not repeat the route blindly or reconstruct a label from nearby text. |
| Source/selected driver changes while preview is open | Mark the pending draft Needs review and disable Apply for that stale draft. Show Before/Current/Pending comparison; Park, Discard or Cancel affects only that un-applied draft. |
| Saved setting/default changes | Show as future-default context only. It does not change a confirmed source basis, reset a manual label position or make a compound Needs review by itself. |
| Save/reopen | Future proof must separately read back compound identity, graphics, owned label, provenance/manual state and selected driver/path/centre. A visible result is not sufficient persistence proof. |

## Fictional before/after drawing example

On a synthetic local slab/detail view, a drafter selects one local path for RBL and leaves one entered field explicitly Manual with its reason. The preview shows the line, end ticks and final label; Cancel leaves the drawing unchanged. On the next run, Apply creates the one compound. The drafter moves it, then moves its label deliberately; both remain one owned compound with the manual position retained.

In the same view, the drafter starts RBC from an explicit centre and enters the required information. The preview calls the picked radius **bar-centre radius**, shows the final label and is accepted once. Copy it to another selected local position: the copy has a fresh independent identity. A protected Xref circle and a nearby unowned label remain excluded. Change a source while another RBC preview is open: Apply is disabled and the draft can be Parked, Discarded or Cancelled. No structural value is inferred at any point.

## Future representative acceptance

In AutoCAD, use a synthetic local drawing to verify RBL and RBC: discover from the Foundation workspace/familiar alias, select/draw explicitly, inspect all provenance fields, preview, Cancel, Apply once, Move, label-edit, COPY, one accepted Undo, stale-preview handling, saved-default/manual-position separation, protected-content exclusion and save/reopen. Confirm `STR`/`BWT` are not ordinary daily routes only when their owner implements the approved transition. These are future checks, not a test result.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD, process, deployment, issue action or client scan occurred.
## `WALLSTRS` bounded status — no ordinary daily sequence

This is a named-source clarification for the declaration-only identity, not a redesign or new workflow card. [ReinforcementDetailCommands.cs:16–24](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ReinforcementDetailCommands.cs:16>) routes `WALLSTRS` to `Pending("WALLSTRS")`. The invoked method only obtains an active editor and writes a “Phase 2 (not yet implemented)” message; it has no source-observed selection, field entry, preview, drawing entity, asset use, result receipt, calculation, persistence or Undo action. Runtime behavior remains untested.

ST-06 does not name `WALLSTRS` in the exact reinforcement decisions reviewed here. ST-08 approves hiding its named empty-placeholder group until each has an evidence-backed Tool card; the sampled ST-08 enumeration names `LIGS`, `COLTIES` and `WALLREO`, but not `WALLSTRS`. That establishes an owner-review boundary for this actual stub; it does **not** silently retire `WALLSTRS`, make it discoverable, or approve a replacement.

| Current fact | Required owner review before any ordinary route |
|---|---|
| The direct declaration can currently reach only the message path in the named source. | Decide the scoped treatment of this stub under the approved placeholder policy. Do not add a ribbon/palette/Help promotion, asset, assumed wall-reinforcement rule or drawing approximation. A future evidence-backed card would need an actual normal sequence, scope/selection, engineering authority, preview/output, native protections, Cancel/Escape/Undo/save-reopen, manual/revision handling and synthetic AutoCAD acceptance. |
## `LIGS`, `COLTIES` and `WALLREO` — explicitly approved placeholder treatment

The same named source class routes `LIGS`, `COLTIES` and `WALLREO` to the message-only `Pending(...)` body ([ReinforcementDetailCommands.cs:13–24](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/ReinforcementDetailCommands.cs:13>)). Unlike `WALLSTRS`, [ST-08 §ST8-15](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-08_SECTIONS_DETAILS.md:290>) expressly names these three in its approved empty-placeholder hide list.

| Current source/configuration evidence | Approved planning disposition |
|---|---|
| The current configured manifest describes Phase 2 functions and marks the entries visible; source execution only writes the pending message. Neither is a working drawing route or an approval of the described engineering function. | **Hide from ordinary discovery until each earns its own evidence-backed Tool card.** This is neither deletion nor a new replacement: retain identity/migration evidence and do not add a daily sequence, asset, engineering default, approximation or promotion. Any later return requires its own approved scope, ordinary prompts/selection/preview/output, protections, Cancel/Escape/Undo/save-reopen, authority/manual-revision contract and AutoCAD acceptance. |