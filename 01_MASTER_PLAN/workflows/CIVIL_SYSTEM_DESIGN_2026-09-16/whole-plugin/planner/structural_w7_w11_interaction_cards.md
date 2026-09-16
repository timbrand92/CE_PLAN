# Structural W7–W11 interaction cards — proposed review detail

> **Read with:** [Structural workflow cards](structural_workflow_cards.md) · [approved Structural decisions](structural_approved_card_reconciliation.md) · [W2–W6 interaction cards](structural_w2_w6_interaction_cards.md) · [XCLMTXT/MTS recovery supplement](structural_mts_xcl_writer_recovery_supplement.md) · [evidence-program contract](evidence_program_interface_authority_contract.md) · [repair/migration authority](../07_QA_REPAIR_AND_MIGRATION.md) · [issue handoff](../23_CHANGE_ALLOCATION_AND_ISSUE_HANDOFF.md). This is planning-only. **Main/More** placement and every target interaction are proposals unless an approved card explicitly says otherwise; source routes remain observations, not runtime proof.

## W7 — annotations, levels, sections, hatches and text

### W7-A. Native dimensions and leaders remain direct drawing tools

**Grouped routes:** `AD`, `LD`, `Q`, `QD`, `RD`, `MLL`, `MLR`, `DSET`, `DSET1`, `DUP`.

| Proposed job sequence | Selection / source / visible outcome |
|---|---|
| **Main: native dimension or leader** | Preselect eligible local geometry or run the familiar alias. `AD`/`LD` retain native associative dimensions; `Q`/`QD` retain their familiar native leader flow. The visible header names current drawing/view, selected object and CE style/paper-scale basis, without changing the native prompt order. |
| **Main: arc dimension** | `RD` current source asks Length/Radius/Diameter **before dispatching native selection** ([DimensionCommands.cs:120](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:120>)–[:147](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/DimensionCommands.cs:147>)) and can save the remembered type before a later selection/placement Cancel. A later Cancel is therefore not a rollback of all remembered settings. Target preview still refuses unsupported/broken geometry and never substitutes an approximate label. |
| **Main: MLeader** | `MLL`/`MLR` current source prompts arrow point then note text ([MLeaderCommands.cs:36](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/MLeaderCommands.cs:36>)–[:58](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/MLeaderCommands.cs:58>)). Proposed preview shows arrow, landing and text together; F flips side before placement. |
| **More: dimension repair** | `DSET`/`DSET1`/`DUP` are a controlled expert proposal: select dimensions/leaders → show existing/proposed style and scale → preview count/scope → Apply → one Undo. They never convert a whole drawing accidentally or force save. Source presently has direct selection/commit routes; approved ST3-12 governs the target. |

**Lifecycle.** Escape in the native prompt leaves no new annotation. Accepted result has one Undo target and restores previous layer/style/snaps. A deliberate user move stays presentation-only and is not snapped back. Locked/Xref/REFEDIT/unsupported content stays protected. Save/reopen proves native association and manual position separately; source/current behavior cannot be assumed from command declaration.

### W7-B. Levels, section marks, breaklines and hatches are reviewable compounds

**Grouped routes:** `FFL`, `RL`, `SSL`, `NGL`, `LM`, `LMU`, `SM`/`SECTION`, `BL`, `H2A`, familiar hatch aliases.

| Main/More action | Proposed selection, preview and output |
|---|---|
| **Main: level mark** | Choose a level type, then trusted source or Manual. Current source exposes type/side/value prompts ([LevelMarkCommands.cs:39](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:39>)–[:176](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LevelMarkCommands.cs:176>)). Preview marker, tail, label, type, source and value as one compound. No source becomes Manual/Unknown, never a numeric placeholder. |
| **More: update recognised marks** | `LMU` is restricted to recognised CE level compounds. Preview selected marks, new value/source, affected references and any conflict; Apply once. It never treats nearby general TEXT/MTEXT as a level mark. |
| **Main: section mark** | Confirm identifier/sheet reference; pick cut start/end; preview full line, both bubbles and hatch/view direction; choose side with cursor/F; Apply. Current source has start/end/direction/identifier/sheet prompts ([SectionMarkCommands.cs:45](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SectionMarkCommands.cs:45>)–[:93](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SectionMarkCommands.cs:93>)); the compound preview is approved target behavior. |
| **Main: breakline** | Pick first/second endpoint; preview one clean polyline in current model/paper space and UCS, sized from plotted scale. Current route supplies the two picks ([BreaklineCommands.cs:36](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BreaklineCommands.cs:36>)–[:46](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/BreaklineCommands.cs:46>)); no new zigzag size is set here. |
| **More: hatch** | Select local boundary/objects or internal points; preview complete hatch properties and plotted scale. `H2A` must prove a replacement before erasing its old hatch; unresolved/protected boundaries remain untouched. Current hatch source has object/point selection branches ([HatchCommands.cs:720](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:720>)–[:758](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/HatchCommands.cs:758>)). |

**Copy/edit/revision.** A moved level/section compound moves its owned pieces; copy creates fresh internal identity while preserving visible section identifier and flags duplicate reference for confirmation. A changed source appears beside Manual/pinned information as Needs review; it does not overwrite an entered value. Cancel before Apply creates no compound. If compound geometry places but relationship/reference receipt fails, state Partial and do not duplicate it on retry.

### W7-C. Text/tag aliases use one visible placement contract

**Grouped routes:** `18L/R`, `25L/R/T/B`, `EBT`/`EBB`, `IBT`/`IBB`, `BEBT`/`BEBB`, `THL`/`THR`, `PFL`/`PFR`, `BPL`/`BPR`, `R2LTXT`.

| Proposed review behavior | Required visible result |
|---|---|
| **Main: familiar text alias** | Select reference where applicable, enter text, view full prefix result, preview, use F/R/Tab, then click. The alias selects a preset role/prefix/layer/plotted height/justification/preferred side/rotation, without double-prefixing or inventing designation. |
| **Main: owned versus independent text** | Beam/support/foundation label shows explicit parent identity; generic note says Independent. A nearby object never creates ownership. MOVE retains deliberate label position; COPY gives an owned label fresh identity with copied parent; ERASE label does not erase parent. |
| **More: conversion** | `R2LTXT` is limited to recognised eligible text. Preview selected count, content/rotation/position/ownership, then Apply one Undo. It never becomes a broad text-style conversion. |
| **More: asset/status** | Approved CE native TEXT/MTEXT styles/assets may place; candidate/unknown asset is Preview-only. Footing rectangles/trim geometry stay W5, and copy helper behavior stays shared-owner—not a text shortcut. |

**Fictitious drawing:** place a native associative dimension, a left MLeader and a Manual level; use F on one preview; create a section mark then copy it and resolve the duplicate reference; preview a hatch replacement and Cancel; place a prefixed beam tag and independently move it; preview a recognised-only R2LTXT conversion and Undo the accepted result.

## W8 — schedule import, reconciliation and pending edits

### W8-A. Import source is a review draft, never authority by itself

**Grouped routes:** `XCLMTXT`, `EXCELMTEXT`, `EXCELMAPFLOOR`, `EXCELMAPFLOORAREA`, `XCLMTXT` advanced edit, `STRSCHEDCREATE`, `STRSCHEDREFRESH`, `STRSCHEDSYNC`.

| Stage | Proposed user-visible sequence |
|---|---|
| **Main: select source and mapping** | Select document/sheet/floor mapping; show source identity, sheet, rows/Unknowns, mapping profile, selected floors and draft warnings. A discovered workbook value is Candidate until the user reviews it. `XCLMTXTINDEX` remains hidden because it is an unqualified ghost, not an expert route. |
| **Main: reconcile rows** | Compare imported candidate against linked member/schedule row: source revision, row identity, current manual/presentation override and mismatch reason. Actions are Keep existing, stage a reviewed update, mark Unknown, or leave independent. A manual row/presentation change is never silently overwritten. |
| **Main: preview placement** | Show selected floors, insertion point(s), output type and every requested section before Apply. The legacy source can prepare rows and return before drawing work if selected floors are empty ([ExcelMTextService.cs:414](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:414>)–[:520](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:520>)); target preview is still a review door, not proof of engineering approval. |
| **More: pending edits** | A staged imported engineering-cell change shows exact linked element, current/proposed value/source, downstream schedule/detail impact and Update/Discard/Cancel. It does not write back from schedule to engineering authority automatically. |
| **More: refresh/sync** | Refresh identifies consumed source/revision and each manual row/presentation exception; Sync previews the exact affected records. Neither command is an issue/publish action. |

**Cancel/reopen.** Cancel leaves the imported draft and drawing placement distinct. Save/reopen reads source/sheet/floor basis, staged changes, manual exceptions and placed schedule identities separately. A changed source while a draft is open makes that draft stale and requires renewed review; it does not apply an old plan.

### W8-B. Writer receipts keep placement, snapshot and support suggestion separate

**Grouped routes:** XCLMTXT writer, structured member-schedule snapshot, schedule-based support suggestion, schedule COPY/MOVE/ERASE.

| Outcome | Required review result |
|---|---|
| **Complete placement** | Every requested section is listed Complete with placement identity/output type. Snapshot state is separately Persisted/Not persisted/Unknown. Source return/log success alone is not either receipt. |
| **Partial writer result** | Per section show Complete/Partial/Absent, known placed geometry/count, source/asset/insertion problem and snapshot state. Existing source can catch per-section failure, continue and commit outer work; that is a source-risk, not a runtime failure claim. |
| **Recovery/retry** | Keep partial work, use supported Undo if proved, or review a specifically identified recovery. A retry first detects existing geometry; it never automatically repeats a possibly partial floor. |
| **Schedule-driven support** | A matching schedule value is displayed as a suggestion. The user can choose a manual support value/override, which stays visible through save/reopen. No existing support changes merely because an imported row changed. |
| **MOVE/COPY/ERASE schedule view** | MOVE changes view placement only. COPY produces a project-specific snapshot unless the user deliberately requests another linked view. ERASE removes the view only; it never deletes authoritative member data. |

**Fictitious drawing:** import a two-floor synthetic list, leave one row Manual, preview both floors, Cancel at first insertion point, then accept a run where one section has a placement fault. Inspect Complete/Partial/Absent and snapshot state separately; do not auto-retry; place one support with a manual override; copy a schedule view as a snapshot and erase only that view.

## W9 — markup evidence and drawing-intelligence proposals

**Grouped routes:** `CEMARKUP`, `CEMARKUPPARSE`, `CEMARKUPPLAN`, `CEMARKUPPREVIEW`, `CEMARKUPREGISTER`, `CEMARKUPRUN`, `CEMARKUPUNDO`, `CEMARKUPVIEW`, Atlas/context/benchmark/register surfaces.

| Proposed review sequence | Visible state and boundary |
|---|---|
| **Main: choose evidence** | Show source document/page, extraction mode, scope and transmission/provider state before parsing. Prescribed review order is Bluebeam FDF/XML, then local PDF text/geometry, then approved visual interpretation. No corpus/provider action is authorised by this card. |
| **Main: select and align proposal** | Select page item; show type/intent/confidence/source text/overlay and exact drawing/layout. Require at least two alignment points before a drawing proposal can be reviewed. Unknown sheet, scale, rotation or revision blocks Apply for that item. |
| **Main: decide each proposal** | Actions are Keep as evidence, Approve proposed drawing action, Reject, Mark Needs clarification, or Cancel. Candidate wall/support/load-path/engineering text remains a proposal; it cannot establish analysis, bearing, connection, load or adequacy. |
| **More: stale plan and receipts** | Plan names source revision, selected drawing/layout, action scope and preconditions. If any change makes the plan stale, disable Apply and return it to review. An applied action group must report each intended action as Complete/Partial/Absent with drawing/result receipt; Undo is scoped to the accepted group only if actual implementation proves it. |
| **More: Atlas/context/register** | Atlas may offer up to two placement alternatives and respects manual position. Context Map shows units/provenance/status/dependencies. Benchmark/Register classifies evidence gaps, not design truth. None may overwrite original source, manually pinned decision or governing calculation. |

**Cancel/save/reopen.** Cancel closes preview/plans without a drawing action. Persist review decision, evidence identity, alignment state, proposal state and action receipt separately; a changed source or drawing causes Needs review, not a quiet rerun. Root owns whole-suite implementation; this Structural card protects the handoff.

**Fictitious drawing:** use a synthetic marked page with a clear beam-note candidate, an uncertain size and a conflicting page revision. Align with two points, approve only the clear candidate into a proposed action group, alter the drawing before Apply and observe stale-plan review, then reopen with all three decisions and no inferred structural calculation.

## W10 — Structural interface to shared sheets, issue and publication

**Grouped routes:** Structural handoff to `CeSheetsWindow`, manager/sync/validation/publish, issue preview and history. These are root-owned; no competing sheet/issue window or command design is created here.

| Structural-side handoff | Proposed reviewable contract |
|---|---|
| **Main: select Structural content for issue review** | Show drawing/layout/sheet identity, relevant Structural records/source revisions, manual presentation choices and unresolved finding status. Structural selection is distinct from final shared issue membership. |
| **Main: review included versus revised** | The shared issue view separately shows all included outputs and the subset receiving new revision/date. A selected unchanged Structural sheet remains included without receiving a new revision. |
| **More: preview and failure** | Preview the real proposed artifact and exact output grouping/order before publish. Cancel preserves draft intent. Partial files are Partial, not issue completion; retry must not advance a revision again. History-save failure is separate from plot/output failure. |
| **Revision handoff** | Independent Structural presentation edit preserves its relationship/mismatch state but does not falsely mark a calculation changed. A changed selected source/revision requires renewed review of only affected handoff scope. |

**Fictitious drawing:** select two Structural sheets where one is revised and one only included; preview the set, cancel; re-open, produce an artificial partial output and confirm no issue/history completion or second revision occurs. This is a root-interface acceptance scenario, not a duplicate root workflow.

## W11 — inspect, repair, export and migration with exact scope

### W11-A. Inspect and repair only the reviewed object set

**Grouped routes:** `CEINSPECT`, `CERECOVERY`, `CEPROPS`, `CLEAN`, `FASTSAVE`, `BEAMLINKMIGRATE`, `BEAMLINKDEBUG`, CEADMIN/CEDEBUG diagnostics.

| Action | Proposed scope/preview/retry contract |
|---|---|
| **Main: Inspect** | Read-only findings list selected drawing/view/object identity, condition, source/relationship uncertainty and protected status. No green badge means engineering checked. |
| **Main: Repair reviewed finding** | Inspect → exact before/after proposal → select only permissible reviewed fixes → Apply same current plan → concise Complete/Partial/Absent receipt. A stale/replaced/cancelled/already-used plan cannot Apply again. Ambiguous link stays unresolved; repair never uses nearby geometry. |
| **More: recovery snapshot** | Name each incomplete command snapshot and let user Retain/Clear that named snapshot. Recovery never replays drawing changes or treats snapshot data as an accepted structural decision. |
| **More: utility cleanup/save** | FASTSAVE saves only. CLEAN remains audit → counted/selectable repair preview → Apply → one Undo and does not force save. **CEPROPS is a separately editable drawing-property surface**, not merely diagnostics: its Save/drawing-summary and optional manifest, matching-DWG sheet revision or sync actions follow the [root12 property contract](../12_SHEET_STRUCTURE_ACTION_CONTRACT.md) and require their own truthful result/readback. CEADMIN/CEDEBUG diagnostics remain factual inspection, not repair/issue proof. |
| **More: beam link migration** | Hidden expert route scans and previews exact selected legacy links, uncertain relationships and protected exclusions. Accept only reviewed migration; no support link is created by proximity. |

**Cancel/retry.** Cancel/Escape removes proposal only. If an accepted repair makes one object change but another fails, receipt names each state and retry starts with a new inspection/readback of failed/unknown scope; it never repeats complete mutations. Save/reopen confirms corrected identities/relationships and unresolved records separately.

### W11-B. Export and approved migration stay separate from issue and generic repair

**Grouped routes:** `CEEXPORT*`, `STRUCEXPORTPDF`, drawing-note/report/block/XLSX/PDF exports, separately approved older-drawing migration.

| Action | Proposed end-user outcome |
|---|---|
| **Main: direct export** | Use the [route-specific direct-export companion](structural_direct_export_scope_card.md): `STRUCEXPORTCSV` is actual XLSX Bracing/Bored Pier, `STRUCEXPORTBLOCKS` is deployed-library DWG copy, `STRUCEXPORTPDF` is current-layout output, and `CEEXPORTNOTES` is drawing-wide NoteStorage Markdown/HTML with image omission. Do not apply a generic selected-object scope to every route. Each factual receipt remains non-issue/non-revision/non-calculation evidence and requires artifact inspection in future acceptance. |
| **More: export failure/retry** | Report selected items, completed files, failed/unwritten outputs and destination collision separately. Before retry, inspect every partial target file and collision state; a Failed/Unwritten label alone is not proof that no usable or partial file exists. Retry only reviewed failed/unwritten selected outputs and do not overwrite a successful output or leak drawing/client material into planner/log. |
| **Approved migration (owner-reserved)** | Keep generic repair separate from the approved existing-job open and pipe open/edit migration trigger. It requires reader/enabler/support preparation first, one dated backup per drawing, visible conversion count and backup line, preservation of user geometry/labels/stable identity, and truthful unavailable result. This card does not alter that owner or invent another upgrade trigger. |
| **MTS legacy text conversion** | Current source does a broad direct conversion/cleanup; the [MTS supplement](structural_mts_xcl_writer_recovery_supplement.md) records it. A selected-scope Preview → Apply target is a proposal pending a dedicated MTS review, not an approved substitute for current behavior. |

**Fictitious drawing:** inspect one explicit legacy beam link and one nearby unlinked support; preview and reject migration, then accept one exact allowed link in a later run; Undo if supported and reopen. Export a synthetic note/PDF to a chosen empty folder and inspect the artifact without issuing it. Open a synthetic older drawing only through its approved migration owner and confirm one backup/count receipt, not a generic repair replay.

## Reclassified presentation details and next planner work

**Recommendation:** retain direct familiar actions in Main; move global conversion, all-systems regeneration, migration, diagnostics and destructive/retry actions into More with scope, preview and receipt visible before Apply. The formerly labelled Tim-only items are **Proposed owner presentation choices**: W9 stale-state banner/card badge, W8 partial-section floor/status sort, and W11 receipt expansion. [Choice-authority review](structural_choice_authority_review.md) preserves them without elevating them to an engineering decision. The underlying approval/identity/manual/native-protection rules do not depend on those choices.

No code, runtime, build, AutoCAD, corpus/client, process, deployment or issue action was performed. This card does not claim W7–W11 implementation or acceptance.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed.

| 2026-09-17T00:20:27.7793462+10:00 | Proposed | structural_w7_w11_interaction_cards.md | Added W7–W11 detailed interaction cards with grouped routes, exact approval companions, source/selection/preview/Main-More/Cancel-Undo/manual-revision/partial contracts and synthetic acceptance scenarios. |



