# Structural `MTS` and XCLMTXT writer/recovery supplement

> **Governing companions:** [whole-job journey and precedence](../19_JOB_JOURNEY_AND_REQUIREMENT_INDEX.md) · [evidence and acceptance boundary](../17_EVIDENCE_AND_ACCEPTANCE_BOUNDARIES.md) · [integrated synthetic walkthrough](../20_INTEGRATED_SYNTHETIC_JOB_WALKTHROUGH.md) · [Structural approved-card reconciliation](structural_approved_card_reconciliation.md) · [control-semantics supplement](structural_control_semantics_supplement.md) · [root checklist and drawing-save boundaries](../22_CHECKLIST_AND_DRAWING_SAVE_BOUNDARIES.md). Later approved requirements govern target behaviour. Source observations below are not runtime proof, completed implementation, a test result or Tim acceptance.

## Scope and key source findings

| Route | Current source side effect | Source-to-approved gap that must stay visible |
|---|---|---|
| `MTS` | A modal command applies `STANDARD` to broad text, attribute, MLeader and independent dimstyle scope in a single committed transaction, then makes it current; it attempts to erase every non-`STANDARD`, non-dependent, non-erased style and catches any erase exception. | The source route has no selected-object list, existing/proposed preview, confirmation or action-level result preview. No MTS-specific approved replacement was found in the records read; eligible-object scope and preview are a proposal pending an MTS review card. |
| XCLMTXT insert writer | A confirmed reviewed draft becomes floor-filtered rows, selected insertion points and one or more schedule placements. The legacy writer may continue after a per-section placement exception; because that section shares the outer transaction, it may already have created some entities before later work commits. | A successful return alone cannot be planned as proof that every requested schedule section was placed or that the structured member-schedule snapshot exactly matches placed geometry. Partial result/recovery must be a visible review state. |
| Post-insert member-schedule consumer | After the writer reports success, source stores a drawing-level NOD JSON snapshot and support insertion can use a matching code to pre-select visibility and bypass its normal size prompt. | This is current source automation, not approved authority to overwrite or hide manual member choice. The approved Structural direction preserves manual/member-first scope and requires consumer mismatch to be visible rather than quietly coordinated. |

## 1. `MTS` — present global conversion and target review door

### Exact current source path

| Step | Source evidence | Current source effect | What remains unknown or unapproved |
|---|---|---|---|
| Entry | [`LegacyPortCommands.cs:111–115`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:111>) | `MTS` is a modal command. It calls `DrawingSafetyService.CommandPreFlight` before drawing work. | Preflight’s runtime/nonnative protection outcome was not traced in this bounded pass; no claim is made about locked layers, REFEDIT or unsupported-object behaviour. |
| Standard text style | [`LegacyPortCommands.cs:126–151`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:126>) | Creates `STANDARD` if absent, then writes its font, text size, X scale and obliquing angle. These are text-style properties, not engineering dimensions or an approved font/standard decision in this plan. | No source preview shows the prior style values or tells the user that an existing `STANDARD` record will be altered. |
| Entity scope | [`LegacyPortCommands.cs:153–194`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:153>) | Iterates non-Xref block-table records and updates `DBText`, `MText`, attribute definitions/references and MLeaders whose style differs. There is no interactive object selection in this command body. | It does not establish what a user will see, whether all relevant entities are safe to convert, or whether manually authored annotation needs a retained exception. |
| Dimstyles and current style | [`LegacyPortCommands.cs:196–210`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:196>) | Updates independent dimstyles’ text-style reference and sets the drawing current text style. | No source preview or explicit consent is visible for the full dependent effect. The current command scope is broader than an “eligible text only” mental model. |
| Style cleanup and completion | [`LegacyPortCommands.cs:212–240`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/LegacyPortCommands.cs:212>) | Attempts to erase every non-`STANDARD`, non-dependent, non-erased style; there is no explicit unused-style test, and any erase exception is caught. Commits once, then reports aggregate entity/dimstyle/deleted-style counts. | Current source does not prove which styles will actually erase, undo granularity, Escape timing or save/reopen outcome. No preview means a user cannot inspect the prospective erasure set before drawing impact. |

### Proposed planning boundary — pending MTS review

The following is a **proposal** for an MTS review card, not an approved replacement: retain the familiar `MTS` access route while adding a visible review boundary rather than silently asserting that the legacy sweep is safe:

1. Read and list only the eligible scope, with **existing style → proposed style**, object/type count, dependent styles and any protected/foreign exclusions.
2. Offer **Preview → Apply → one action-level Undo**. Cancel or Escape during review leaves the drawing unchanged. A completed Apply is a drawing operation; closing a host window is not a rollback.
3. Handle style cleanup as a separately visible proposed consequence: show the exact candidate set and its actual reference/protection result; do not erase a style merely because it is non-standard. Current source’s best-effort erase is evidence of legacy behaviour, not target approval.
4. Preserve user-authored/manual exceptions and report them as retained or skipped. Do not quietly convert Xref/REFEDIT/locked/unsupported objects; native protections remain in force.
5. Do not force drawing save. It may draw on the general protection principle, but no MTS-specific preview/Undo/save rule is approved by that citation; this proposal needs its own review.

### Representative future acceptance scenarios

| Scenario | Expected target evidence; not a claim that it currently occurs |
|---|---|
| Mixed local text, MText, MLeader, attributes and an independent dimstyle | Preview identifies each eligible category and proposed result; explicit Apply changes only reviewed local scope; one Undo restores the complete operation if supported. |
| Existing `STANDARD` differs from source’s current values | Preview exposes the proposed record change and allows Cancel with no mutation. |
| Non-standard candidate is referenced, dependent, in an Xref, or cannot be erased | Preview classifies retained/skipped candidates and gives an actual reason; no silent deletion. |
| User presses Escape after preview, then saves/reopens | No drawing change after Escape. After Apply, save/reopen records the actual drawing result separately from source planning. |

## 2. XCLMTXT legacy writer — source-level insertion, partial result and recovery

### Entry, selection and transaction facts

| Stage | Exact source evidence | Present side effect / boundary |
|---|---|---|
| Floor-filtered reviewed rows | [`ExcelMTextService.cs:414–508`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:414>) | Builds rows from the reviewed preview, filters to requested floors, prepares display text and layout, and returns `false` before drawing work when selected rows/floors are empty. Audit-only returns without placement. This is source control flow, not a proof that the preview is engineering-approved. |
| Insertion points | [`ExcelMTextService.cs:510–520`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:510>) | Resolves insertion points before document lock; cancellation/failure in that resolver returns `false` before `CreateEntities`. Actual prompt/focus/Escape behaviour remains untested. |
| Drawing write | [`ExcelMTextService.cs:3324–3371`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:3324>) | Opens one transaction, ensures layers/text style, optionally looks for wipeout and schedule block assets, and falls back to text-only schedule placement when a schedule block cannot load. Asset fallback is current source, not approval to substitute an unsuitable detail/asset silently. |
| Per-section placement | [`ExcelMTextService.cs:3383–3478`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:3383>) | For each floor section, source may insert/configure a live schedule block or static frame, then places rows. A section exception is caught, logged, and source proceeds to later sections; no per-section rollback is visible, so entities created before that exception may remain in the outer transaction. |
| Commit | [`ExcelMTextService.cs:3481–3493`](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:3481>) | Adjusts draw order best-effort, then commits the outer transaction. Therefore source control flow can commit successfully placed sections and partial entities from a failed section after a prior section exception. |

### Source-level partial-result risk

This is an **observed control-flow risk**, not a runtime failure claim:

- `TryInsertPreviewRows` catches an exception for one floor section, writes that it was skipped, continues its loop, then commits at the end. It returns `true` unless a higher-level exception occurs. [ExcelMTextService.cs:3473–3492](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ExcelMTextService.cs:3473>).
- `XclmTxtService` interprets that `true` as insert complete, then **attempts** a member-schedule snapshot from all non-title marked `result.Rows`, not from verified placed section identities. The underlying writer is `void` and can return early or catch/log an error, while the caller can still print “snapshot saved.” [XclmTxtService.cs:250–267](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/XclmTxtService.cs:250>), [XclmTxtService.cs:293–315](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/XclmTxtService.cs:293>).
- If the writer returns `false`, source preserves the draft and tells the user to rerun XCLMTXT. [XclmTxtService.cs:284–290](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/XclmTxtService.cs:284>). That message does not establish whether a failed run left any earlier native entities; the source needs a visible placement receipt/recovery check before the target can claim atomicity.

### Required target result and recovery contract

| Condition | Required visible target state | Manual and independent-scope boundary |
|---|---|---|
| All requested sections placed | Show the requested floors/labels, actual placement identity/count and output type (live block or static geometry) before calling placement complete. Separately report schedule-snapshot state as **Persisted**, **Not persisted**, or **Unknown**; do not infer it from a command-line success message. | A placed schedule is not automatic authority to alter unrelated members, labels or manual presentation overrides. |
| One or more sections fail/skip | State **Partial — review placement**, classify every requested section as **Complete**, **Partial**, or **Absent**; separately show schedule-snapshot state as **Persisted**, **Not persisted**, or **Unknown**; list known placed entities/counts, location/asset error and proposed recovery. Do not show generic “insert complete,” silently write a full snapshot, or auto-repeat a missing floor. | User chooses keep known partial work, undo the known operation if supported, or review a specifically identified recovery action. A retry must first detect existing partial geometry and cannot automatically repeat a floor, because duplication is possible. Native Undo and idempotent retry are **Unknown** until AutoCAD evidence exists. |
| Block asset unavailable | Offer visible text-only alternative only if its appearance/suitability is confirmed; otherwise stop before drawing impact. The current legacy fallback does not supersede approved asset/provenance requirements. | Never substitute a similar named block/detail or invent asset values. |
| User cancels insertion point or confirmation | Retain the reviewed draft and leave drawing placement unchanged. | Draft Undo, drawing Undo and external log cleanup are separate. |
| Writer error after a partial database change | Preserve draft plus a factual operation receipt; reopen should identify the unresolved placement state rather than infer success/failure from a log filename. | No quiet deletion/recreation around protected objects; recovery must respect native AutoCAD protections. |

### Post-insert structured snapshot and consumer identity

| Item | Exact source fact | Planning consequence |
|---|---|---|
| Storage | `MemberScheduleService.WriteSchedule` is a `void` attempt to store `Code`, `Size`, `Type`, `Note` as JSON under one drawing-level NOD key, replacing the existing snapshot when it reaches its commit. [MemberScheduleService.cs:9–27](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/MemberScheduleService.cs:9>), [MemberScheduleService.cs:120–150](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/MemberScheduleService.cs:120>) | Present storage has no source/page/revision, placement identity, provenance, user override flag or per-section status in this read. `WriteSchedule` can return early when the NOD is absent and catches/logs exceptions internally; `TryPersistMemberSchedule` prints “snapshot saved” after calling it. That message is not persistence proof. It cannot be treated as an authoritative or complete graphical schedule record. |
| Consumer | Support insertion tests for an active snapshot and matching command code; a matching size sets visibility and skips the usual visibility selection prompt. [SupportBlockCommands.cs:204–222](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/SupportBlockCommands.cs:204>) | Current source can suppress a manual choice. The approved target must expose the schedule suggestion, preserve a manual choice/override, and flag a mismatch rather than silently converting existing support/member work. |
| Successful insert logging | Source writes a handoff log under the user application-data tree containing drawing/source/sheet/floor/options summary. [XclmTxtService.cs:2728–2776](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/XclmTxtService.cs:2728>) | Logs are support evidence, not authority and not a replacement for a drawing-level placement receipt. This planning pass did not open/read any project or client log. |

### Representative future acceptance scenarios

| Scenario | Required future evidence; no present test claim |
|---|---|
| Two requested floors, one forced placement/asset failure | The review result names Complete/Partial/Absent scope and separately reports snapshot Persisted/Not persisted/Unknown; a command-line “saved” message alone cannot decide it. The user can inspect drawing and persisted record before choosing recovery. |
| Successful schedule plus support insertion with matching code | Support command shows the schedule-derived size as a suggestion and allows manual selection/override; a manual selection stays visible after save/reopen. |
| Existing manual support plus later imported schedule revision | No automatic change to the existing support. A scoped mismatch is surfaced for review; unrelated members remain independent. |
| Cancel before location, after location preview, and after a partial error | Draft state, drawing state and any external diagnostic log are reported separately. No “complete” claim without verifying all requested placement output. |
| Save/reopen after a known completed synthetic insert | Source/sheet/floor basis, placement identities, NOD snapshot and actual on-drawing schedule are compared; placement Complete/Partial/Absent and snapshot Persisted/Not persisted/Unknown remain separate. An absent or mismatched item is never silently repaired. |

## Planning status and next useful work

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** no.

Next useful work is not another generic source list: reconcile the `MTS` preview/eligible-object target with its eventual owner, and design a source/placement/snapshot reconciliation receipt that reports Complete / Partial / Absent per requested section for XCLMTXT before changing the legacy writer. Both need synthetic AutoCAD acceptance evidence; neither is authorised for implementation by this planning supplement.





