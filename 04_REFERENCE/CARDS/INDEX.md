# CE workflow-card index

**6 September 2026 — all-module drafting scope included:** [production plan](../DRAWING_PRODUCTION_PLAN.md) and [44-item register](../DRAFTING_DELIVERY_REGISTER.md) record Tim's approval to add the audit and expand delivery detail. These map to existing canonical cards; **39 remains the approved card count**. No DP/audit ID is a new approved command card. Current local source-access clearance and reported evidence coverage are recorded in the production plan; historical DATA-01 history/provider restrictions remain scoped to those operations, not an automatic prohibition on newly cleared local read-only work.

**Structural Level 3 planning extension — 5 September 2026:** [plan and pending questions](../STRUCTURAL_LEVEL3_PLAN.md).
Tim authorised planning/publication. SL3-0–6 are proposed delivery slices, **not new approved command cards**;
the existing card count and ST-01–09 approvals are unchanged. New engineering/design workflows need their own review.

**Planning status:** 39 cards approved · 39/39 durable records complete · P0 started (`CT-01A/B/C/D/E`,
TH-01, `RS-01A1/A2/B1/B2/C1/C2` and `PD-01A/B` complete) · product-command implementation active; see the table below ·
AutoCAD acceptance partial and exact-build-specific; no overall verification percentage asserted

**2026-09-04:** [GitHub #24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24) is the live delivery summary.
[V3_0_PLAN.md](../V3_0_PLAN.md) maps C0–C6 without replacing these canonical cards.
[Tim's D1–D10 rulings](../PLAN_RECONCILIATION_2026-09-04.md) are approved, including **D9: DWG geometry remains the model**.
Historical implementation cells retain cited evidence; this docs pass does not newly accept any workflow.

This is the durable planning index for the clean-slate rebuild. Approval means the AutoCAD workflow has
been decided; it does **not** mean code exists, tests passed, AutoCAD was checked or a release occurred.

## Canonical card IDs

The durable records remain authoritative. Their older file/work-card IDs map to the canonical IDs below.

All canonical IDs use `AREA-NN`. Legacy work-card/file IDs remain searchable history, not competing IDs.

| Legacy/review label | Canonical card ID | Durable record |
|---|---|---|
| `SH`, `SH-01/02` | `SH-01` | [Product shell, health and recovery](../workflows/SH-01_PRODUCT_SHELL_REVIEW.md) |
| `F`, `FND-01` | `FND-01` | [Foundation quality gates](../workflows/FND-01_FOUNDATION_REVIEW.md) |
| `CT`, `FND-001` | `CT-01` | [Command truth](../workflows/FND-001_COMMAND_TRUTH_REVIEW.md) |
| `TH`, `FND-002/003` | `TH-01` | [Trustworthy test evidence](../workflows/FND-002_003_TEST_EVIDENCE_REVIEW.md) |
| `RS`, `FND-004` | `RS-01` | [Release safety](../workflows/FND-004_RELEASE_SAFETY_REVIEW.md) |
| `PD`, `FND-005/006` | `PD-01` | [Performance and diagnostics](../workflows/FND-005_006_PERFORMANCE_DIAGNOSTICS_REVIEW.md) |
| `TF`, `SH-05` | `TF-01` | [Shared Move/Copy Rotate](../workflows/SH-05_SHARED_TRANSFORM_REVIEW.md) |

Do not create a second card using a legacy ID. For example, `FND-001` resolves to `CT-01`.

## Gate 0 — privacy

**DATA-01 is failed/blocked.** The 2026-07-22 history-aware audit found 141 current corpus files,
142 historical corpus paths and 163 historical corpus objects. Identifier-bearing snapshot filenames remain
reachable through 65 local/remote refs. Current-file renaming is insufficient: a deliberate history rewrite
or an approved history-access restriction is mandatory before broad AI/corpus access.

See [DATA-01](DATA-01_CORPUS_PRIVACY.md). No history rewrite is authorised by this record pass.

## Approved planning cards

| Area | Card | Planning record | Implementation | AutoCAD |
|---|---|---|---|---|
| Foundation | `SH-01` | Complete | SH-01R1/R2 modern Civil, Structural and Tools ribbon source complete | Not verified |
| Foundation | `FND-01` | Complete | Not started | Not verified |
| Foundation | `CT-01` | Complete | CT-01A/B/C/D/E evidence, approved owners + Manager and first Civil central-register tools complete; remaining tool/surface migration pending | Not required for command inventory |
| Foundation | `TH-01` | Complete | Test-only package, strict runner and Staff release exclusion complete; first scenario evidence pending | Not verified |
| Foundation | `RS-01` | Complete | RS-01A1/A2/B1/B2/C1/C2 safe staged cutover + build defaults + signed gate complete; key enrolment/package mint pending | Not verified |
| Foundation | `PD-01` | Complete | PD-01A/B shared classifier + Manager run/PID/heartbeat/managed-crash ledger complete; performance/log/support/native-artifact work pending | Not verified |
| Shared | `TF-01` | Complete | Not started | Not verified |
| Shared | [`SH-04`](SH-04_SETTINGS_STANDARDS.md) | Complete | Not started | Not verified |
| AI | [`AI-01`](AI-01_ASK_CE_MCP_AUTOMATION.md) | Complete | Not started | Not verified |
| Data | [`DATA-01`](DATA-01_CORPUS_PRIVACY.md) | Complete; Gate 0 failed | Blocked | Not verified |
| Assets | [`AS-01`](AS-01_STANDARDS_ASSET_CATALOGUE.md) | Complete | Not started | Not verified |
| Civil | [`CV-01`](CV-01_DRAINAGE_NETWORK.md) | Complete | CV-01E1/E2/E3/E4, CV-01G1/G2/G3 and CV-01H1–H4 independently PASS; H5A/B1 PASS `89d4bf9` / `ab372dc`; final H5B2 PASS `dc9e971`; H5B3 PASS `e827290`; joined source re-audit PASS `34d5e3c`; H5C–H5E pending | Not verified |
| Civil | [`CV-01J`](CV-01J_MULTI_LEVEL_CONTINUATIONS.md) | Complete; Tim approved 2026-07-24 | J1/J2/J3 safety and storage PASS; J3C–J3F source complete; J5A mapping authority and J5B1 passive DWG reader independently PASS; integrated command/lock/full-shape guards PASS `422e9e0`; J5B2 two-DWG writer independently PASS `89a46f5`, integrated `7c628e8`; live proof pending | Not verified |
| Civil | [`CV-02`](CV-02_HYDRAULIC_DESIGN.md) | Complete | CV-02A advisory visual approved; A1–A3 queued, production Pass/Apply blocked | Not verified |
| Civil | [`CV-03`](CV-03_SOURCE_BLOCKS.md) | Complete | Not started | Not verified |
| Civil | [`CV-04`](CV-04_SURFACE_DRAINAGE.md) | Complete | Not started | Not verified |
| Civil | [`CV-05`](CV-05_SLAB_SITE_LAYOUT.md) | Complete | Not started | Not verified |
| Civil | [`CV-06`](CV-06_REVIEW_CALCULATION.md) | Complete | Not started | Not verified |
| Civil | [`CV-07`](CV-07_SURVEY_IMPORT.md) | Complete | Not started | Not verified |
| Civil | [`CV-08`](CV-08_REPAIR_MIGRATION.md) | Complete | Not started | Not verified |
| Civil | [`PS-01`](PS-01_PIT_SCHEDULES.md) | Complete + XREF addendum | PS-01A/B/C + PS-01D1–D5 and PS-01E1/E2 read-only watcher complete; E3 UI and E4 live evidence pending; PS-01F1 visual awaits Tim approval | Not verified |
| QA | [`QA-01`](QA-01_READY_TO_ISSUE.md) | Complete | Not started | Not verified |
| Structural | [`ST-01`](ST-01_BEAMS_LINKS.md) | Complete | Not started | Not verified |
| Structural | [`ST-02`](ST-02_SUPPORTS_BRACING_JOISTS.md) | Complete | Not started | Not verified |
| Structural | [`ST-03`](ST-03_ANNOTATION_DIMENSIONS.md) | Complete | Not started | Not verified |
| Structural | [`ST-04`](ST-04_TEXT_PLACEMENT.md) | Complete | Not started | Not verified |
| Structural | [`ST-05`](ST-05_HATCHING_UTILITIES_XREFS.md) | Complete | Not started | Not verified |
| Structural | [`ST-06`](ST-06_FOUNDATIONS_REBAR.md) | Complete | Not started | Not verified |
| Structural | [`ST-07`](ST-07_SCHEDULES_SHEETS_EXCEL.md) | Complete | Not started | Not verified |
| Structural | [`ST-08`](ST-08_SECTIONS_DETAILS.md) | Complete | Not started | Not verified |
| Structural | [`ST-09`](ST-09_MARKUP_CHECKLIST_NOTES_TIME.md) | Complete | Not started | Not verified |
| Evidence | [`EV-01`](EV-01_SCOPE.md) | Complete | Not started | Not verified |
| Evidence | [`EV-02`](EV-02_ACCEPTANCE_GATES.md) | Complete | Not started | Not verified |
| Evidence | [`EV-03`](EV-03_EVIDENCE_MODEL.md) | Complete | Not started | Not verified |
| Evidence | [`EV-04`](EV-04_PATTERN_ATLAS.md) | Complete | Not started | Not verified |
| Evidence | [`EV-05`](EV-05_ENGINEERING_CONTEXT_MAP.md) | Complete | Not started | Not verified |
| Evidence | [`EV-06`](EV-06_GOLD_BENCHMARK.md) | Complete | Not started | Not verified |
| Evidence | [`EV-07`](EV-07_AUTOMATION_REGISTER.md) | Complete | Not started | Not verified |
| Planning | [`PC-01`](PC-01_PLANNING_RECORD.md) | Complete | Document pass complete | Not applicable |

**Branch-aware Structural note:** Stage 3 source and the signed 1.0.44
Tim-Test package are independently audited on isolated branch `e661ba6`.
They are not merged into this Civil branch, staged, activated or deployed.
The `ST-01`–`ST-09` rows above continue to show the per-card migration state.

## Command coverage

The current three registry inputs are mapped in [COMMAND_TO_CARD_COVERAGE.md](COMMAND_TO_CARD_COVERAGE.md).
Any `Unmapped` or contradictory row is `Hidden + Review Pending` until reconciled under `CT-01`.

## Record-completion status

**39 of 39 records are complete (100%).** The five previously-blocked records — `SH-04`, `CV-01`, `CV-02`,
`PS-01`, `QA-01` — were recovered on 2026-07-22 from the planning review chat that originally produced them:
each holds the source card Tim posted **plus** the assistant approval, preserved verbatim, **not** reconstructed
from summaries or code.

Only the headless `CT-01A/B/C` command evidence/owner cleanup, `TH-01` test separation/strict runner and
`RS-01A1/A2/B1/B2/C1/C2` release-safety identity, staging, recorded cutover, legacy-route retirement, safe build
defaults and signed gate have entered implementation; no AutoCAD command behaviour or live
bundle has changed. **DATA-01 Gate 0 remains
failed/blocked** (see the privacy section above) —
a deliberate history rewrite or an approved history-access restriction is mandatory before broad AI/corpus access.
