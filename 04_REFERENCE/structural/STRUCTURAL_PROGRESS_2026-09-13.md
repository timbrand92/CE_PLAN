# Structural progress reconciliation — 13 September 2026

## Result at a glance

This is a bounded source reconciliation, not a new code audit or an AutoCAD acceptance. It compares the 135 approved numbered decisions in ST-01 through ST-09 with the evidence visible at:

- current colleague integration `codex/first-colleague-integration` at `0ea4e9bfdc4cb2d63ab9149b676759ffd752e05c`;
- frozen Structural comparison source `405b180ecc745b37f4f0dd3e16462c2c6934b5a7`;
- isolated read-only Structural projector `d716329806855a9093ee9b5d16ebe677a5c53e30`.

The strict completed-item count is a **verified lower bound**, not total actual completion. A Partial item has useful source, review or test evidence, but at least one approved requirement is missing, contradicted, dormant, disconnected or not proven. No arbitrary percentage is assigned to Partial items.

| Structural area | Approved items | Complete | Partial | Unverified | Verified complete-item lower bound | Actual capability completion |
|---|---:|---:|---:|---:|---:|---|
| Framing — ST-01 + ST-02 | 30 | 0 | 29 | 1 | **0/30 = 0%** | Unmeasured; substantial beam/support reuse exists |
| Foundations — ST-06 | 15 | 0 | 13 | 2 | **0/15 = 0%** | Unmeasured; active legacy engines exist |
| Drafting — ST-03 + ST-04 + ST-05 | 45 | 0 | 37 | 8 | **0/45 = 0%** | Unmeasured; many active drafting commands exist |
| Sections & Details — ST-08 | 15 | 0 | 8 | 7 | **0/15 = 0%** | Unmeasured; proven geometry engines exist |
| Schedules & Sheets — ST-07 | 15 | 1 | 12 | 2 | **1/15 = 6.67%** | Unmeasured beyond the one complete managed publishing item |
| Job Coordination — ST-09 | 15 | 0 | 11 | 4 | **0/15 = 0%** | Unmeasured; timer/ledger and legacy tools exist |
| **Whole Structural** | **135** | **1** | **110** | **24** | **1/135 = 0.74%** | **Unmeasured; 0.74% is only the strict verified lower bound** |

The 0% rows do **not** mean that no working code exists. They mean no whole numbered decision in those areas was proven across every source and managed-route clause of its approved card during this bounded review. Native AutoCAD acceptance is a separate Finalised gate.

## Built, connected, finalised and colleague package

| Measure | Current reconciled statement |
|---|---|
| Structural Built | **0.74% verified lower bound** by complete approved items; 110 more items have partial evidence and 24 are unverified. A reliable total percentage is not yet established. |
| Structural Connected | **0.74% verified lower bound**: ST7-14 has a reviewed, integrated managed Issue path. ST7-13 remains Partial because the current QA7 result is advisory and Issue remains available when QA is Unknown. ST7-12 remains Partial because closed-drawing Apply and native document-event acceptance remain open. Other working commands are legacy, dormant, disconnected or not checked against the complete approved decision. |
| Structural Finalised | **0% verified lower bound**. There is no consolidated Tim AutoCAD acceptance, signing, deployment and colleague-machine acceptance for this 135-item scope. |
| Final Structural colleague package | **Unmeasured.** No approved package denominator or weighting formula exists yet, and the package is not signed, deployed or accepted. |

## Fixed denominator and exact calculation

Each approved card contains 15 numbered decisions. The area denominator is therefore:

```text
Framing             ST1-1..ST1-15 + ST2-1..ST2-15 = 30
Foundations         ST6-1..ST6-15                  = 15
Drafting            ST3-1..ST3-15 + ST4-1..ST4-15
                    + ST5-1..ST5-15                = 45
Sections & Details  ST8-1..ST8-15                  = 15
Schedules & Sheets  ST7-1..ST7-15                  = 15
Job Coordination    ST9-1..ST9-15                  = 15
                                                     ---
Whole Structural                                      135

Strict completed-item lower bound = 1 / 135 × 100 = 0.740...% = 0.74%
Unresolved item count                 = 110 Partial + 24 Unverified = 134
```

The later banked idea `ST1-I1` is excluded because it is explicitly outside the approved implementation scope pending Tim's examples.

## Exact item evidence classification

Legend:

- **Complete** — reviewed source is integrated with the required managed product route and covers the exact approved item; native acceptance is still reported separately.
- **Partial** — reusable evidence exists, but the exact approved item is not complete.
- **Unverified** — this bounded review found no adequate reviewed evidence for the exact item, or found only an old route without enough evidence to credit the approved behaviour.

| Card | Complete | Partial | Unverified |
|---|---|---|---|
| ST-01 | — | ST1-1, ST1-2, ST1-3, ST1-4, ST1-5, ST1-6, ST1-7, ST1-8, ST1-9, ST1-10, ST1-11, ST1-12, ST1-13, ST1-14, ST1-15 | — |
| ST-02 | — | ST2-1, ST2-2, ST2-3, ST2-4, ST2-5, ST2-7, ST2-8, ST2-9, ST2-10, ST2-11, ST2-12, ST2-13, ST2-14, ST2-15 | ST2-6 |
| ST-03 | — | ST3-2, ST3-3, ST3-4, ST3-5, ST3-6, ST3-7, ST3-8, ST3-9, ST3-10, ST3-11, ST3-12, ST3-13, ST3-15 | ST3-1, ST3-14 |
| ST-04 | — | ST4-3, ST4-4, ST4-5, ST4-6, ST4-7, ST4-8, ST4-9, ST4-10, ST4-11, ST4-12, ST4-14, ST4-15 | ST4-1, ST4-2, ST4-13 |
| ST-05 | — | ST5-2, ST5-3, ST5-4, ST5-5, ST5-6, ST5-7, ST5-8, ST5-10, ST5-11, ST5-12, ST5-14, ST5-15 | ST5-1, ST5-9, ST5-13 |
| ST-06 | — | ST6-2, ST6-3, ST6-4, ST6-5, ST6-6, ST6-7, ST6-8, ST6-9, ST6-10, ST6-11, ST6-12, ST6-13, ST6-15 | ST6-1, ST6-14 |
| ST-07 | ST7-14 | ST7-1, ST7-2, ST7-3, ST7-4, ST7-7, ST7-8, ST7-9, ST7-10, ST7-11, ST7-12, ST7-13, ST7-15 | ST7-5, ST7-6 |
| ST-08 | — | ST8-1, ST8-2, ST8-3, ST8-4, ST8-5, ST8-8, ST8-11, ST8-15 | ST8-6, ST8-7, ST8-9, ST8-10, ST8-12, ST8-13, ST8-14 |
| ST-09 | — | ST9-2, ST9-3, ST9-5, ST9-6, ST9-7, ST9-9, ST9-10, ST9-11, ST9-13, ST9-14, ST9-15 | ST9-1, ST9-4, ST9-8, ST9-12 |

Classification totals check: `1 Complete + 110 Partial + 24 Unverified = 135`.

## Area evidence and remaining obligations

| Area | Reusable evidence already present | Why the remaining items are not Complete |
|---|---|---|
| Framing | Reviewed dormant beam adapter through `dbd4fffb`, integrated as `51de5328`; reported root 81/81 managed lifecycle/prompt checks. Existing beam planners, side/offset/trim services, link graph, support placement engines and related tests remain at `405b180e`. ST-RDY-03 at `d7163298` adds a tested read-only shared-record projector. | Public commands `1/2` still use the legacy route; the reviewed adapter is dormant. ST-RDY-04 proves its session locator is not a permanent engineering identity. Shared-support movement, beam/support/group COPY mapping, orphan handling, exact reader-to-projector conversion, Undo and save/reopen remain unqualified. The newer `a17075dd` delta is excluded. |
| Foundations | `FoundationService`, registry/monitor, screw-pile/stump services, foundation models, rebar services and existing commands provide reusable geometry and data paths. | No bounded reviewed package proves the approved explicit host, Unknown provenance, compound ownership, safe adoption, fresh COPY identity, scoped erase/regeneration and approved assets together. `STR` and `BWT` remain registered, and `FSTEXPORT` still calls the foundation service at `0ea4e9bf`, contrary to part of ST6-14. |
| Drafting | Existing `DimensionCommands`, `SectionMarkCommands`, `CeTextCommands/CeTextService`, `HatchCommands`, native Xref services and command-specific tests show substantial legacy drafting capability. | No bounded reviewed integration maps the full approved common annotation/text/hatch backbones, approved assets, plotted scale, ownership, protected-content refusal, Cancel/Undo and state restoration. Existing command presence is not proof of the approved consolidated workflow. |
| Sections & Details | Existing SBEAM/RC/column/detail drawing engines and section catalogue tests are reusable. The accepted dormant SBEAM selection slice was reported with 76/76 managed checks; stale copied-member evidence was safely refused in 10 focused checks. | Member/calculation authority, compound detail identity, COPY disambiguation, governed assets and edit lifecycle are not connected. Placeholder commands such as `PORTAL`, `TRUSS`, `PURLINS`, `BOLTS`, `GUSSETS`, `LIGS`, `COLTIES`, `WALLREO` and `BSSLAB` are still registered at `0ea4e9bf`, so ST8-15 is only Partial. No native detail acceptance exists. |
| Schedules & Sheets | The shared Project/Sheets producer and Manager consumer are reviewed and integrated. The full Issue chain at `50572182` shares selected-sheet review, publishing coordination, completion reporting and durable history; managed integration receipts report 103/103 Issue, 11/11 Manager lifecycle and 7/7 page-harness checks. ST7-14 has direct source guards in `CeSheetsPdfPublishAttempt`, `CeSheetsPdfPublishFinalizationService` and `CeSheetsActiveDocViewGuard`; matching tests prove same-directory CE temporary output, no-overwrite finalisation, incomplete-page failure, captured main-thread separation and exact layout/UCS/view/DBMOD restoration. The implementation card also records 112/112 checks on each managed runtime lane. | ST7-13 is Partial: `CeSheetsIssueCoordinator.SummarizeAutomaticQa` explicitly says Issue remains available when QA7 is Unknown, and `CeSheetsIssueAutomaticQaEvidenceTests` proves that Structural drawings without the Civil contributor remain Unknown. That does not prove the approved deterministic QA-01 block on stale Structural links or unresolved placeholders. The structural semantic schedule, exact member/footing/calculation links, authority-conflict display, Excel review flow and safe engineering write-back also remain incomplete or unverified. Native plotting, events, file locks, Undo and reopen remain Finalised evidence, not managed-source completion. |
| Job Coordination | Existing Bluebeam parser, markup models/UI, checklist, notes and timer/report code are reusable. JobTime integrity recovery is integrated. At `0ea4e9bf`, stable Project identity and the R1 append-only ledger/projection are integrated; reported focused root checks are 80/80. | The timer is not yet connected to the new ledger. R2 is held because idle monotonic start evidence was synthesized at the wrong boundary. One Manager Coordination workspace, exact markup alignment/apply/targeted Undo, one QA checklist authority, conflict-safe notes and final report allocation remain unfinished. Legacy unsafe markup routes still exist, including direct provider/Python worker code. |

## Evidence lanes kept separate

| Evidence lane | What is established | What is not established |
|---|---|---|
| Source | Reusable legacy engines exist in all six areas; newer bounded source exists for dormant beams, Project/Sheets/Issue and JobTime. | Presence of a command/file does not establish the approved complete workflow. This was not an exhaustive clause-by-clause code audit. |
| Independent/review evidence | Dormant beam range through `dbd4fffb`, shared Project/Sheets/Issue packages and JobTime R1 have recorded review/integration evidence. | The newer beam closure `a17075dd`, full ST-03/04/05/06/08 migrations and JobTime R2 are not cleared here. |
| Connected managed route | ST7-14 is credited. Project/Sheets/Issue is hosted through the shared Structural/Manager route; ST7-12 and ST7-13 remain Partial for the exact gaps above. | Beam projector remains isolated; dormant beam adapter is not the public command route; JobTime R1 does not drive the production timer; other areas retain legacy paths. |
| Native AutoCAD acceptance | Historical behaviour and some prior candidate checks are useful context. | No current representative 135-item Structural acceptance batch, signing, deployment or colleague-machine acceptance exists. Therefore Finalised remains a verified 0% lower bound. |

## Immediate reusable sequence

1. Finish the nominated permanent Structural identity and bounded native reader-to-projector seam; do not mint identity as a read side effect.
2. Qualify the ST-RDY-01 beam/support COPY, MOVE, ERASE, Undo and save/reopen drawing as the first Framing slice.
3. Reconcile each remaining area in bounded approved-card batches, beginning with shared dependencies: assets/styles/scale for Drafting, host identity for Foundations, member provenance for Sections/Schedules, and the single Manager authority for Job Coordination.
4. Credit an item only when every clause of that numbered decision has reviewed source evidence; credit Finalised only after Tim's consolidated AutoCAD check and applicable release gates.

Work reported after this evidence cutoff, including an in-progress pure captured-link/identity conversion, earns no area or release credit until its exact source, review and integration receipt are recorded. Native behaviour, shared-spine ownership and deployment authority are unchanged.

## Honest limits

- The nine cards' own historical `Implementation: not started` labels were not used as zero evidence; actual source was inspected.
- Test totals prove the named guarded behaviour only. They are not converted into percentage completion.
- Partial items are not treated as 50%, and no midpoint estimate is invented.
- The completed-item method is deliberately strict and therefore understates working source. It is a lower bound suitable for repeatable updates; a later clause-level audit can promote exact items without changing the 135-item denominator.
- No client corpus, external service, build, test, deployment or AutoCAD operation was used for this reconciliation.
