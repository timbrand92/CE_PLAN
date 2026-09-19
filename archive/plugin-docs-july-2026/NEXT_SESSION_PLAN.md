# NEXT SESSION PLAN — Confidence-Matrix Hardening + STRUC Smartify

**Purpose:** the execution plan for a parallel Claude session, agreed with Tim 2026-07-03.
Tim is testing TIM_CHECKLIST.md Parts 1–6 in the original session; THIS plan runs elsewhere.
**Repo:** `C:\Lisp Files\CE_ACAD_PLUGIN` (the monorepo — all work happens HERE, not the old repos).

> **Session start ritual:** read `CLAUDE.md`, `REGRESSION_LOG.md` (top entries), `docs/SMARTIFY_PLAN.md`,
> `docs/CONFIDENCE_MATRIX.md`, and this file. Memory has the program state. Follow the house discipline:
> every fix = failing test → fix → REGRESSION_LOG entry → "what Tim should test" checklist. Build/test
> with `-p:SkipDevBundle=true` when AutoCAD may be open. Commit+push per landed item. Update the matrix
> rating for every row fixed (it's a living document).

---

## ⚠️ Standing constraints (do not violate)

1. **Tim's old repos are read-only.** All fixes go into the monorepo modules.
2. **CeSheets\* files in `Modules\Structural` are OFF-LIMITS** until Tim commits his in-progress
   sheet-tool work in the standalone STRUC repo and it's synced (TIM_CHECKLIST Part 5). Touching
   them now creates a fork. Affected: `CeSheetsWindow*`, `CeSheetsScannerService`, `CeSheetsUpdateService`,
   `CeTitleBlockWriter`, `CeSheetsModels`, and their tests.
3. Write-capable features stay behind preview→confirm→apply→single-undo. Engineering constants are
   never invented — unknowns ship flagged.
4. Deploys to Tim's live bundle only when he says AutoCAD is closed (and only the CVL bundle carries
   monorepo code today).
5. Coordinate with the ORIGINAL session: if Tim reports test failures there, fixes for those take
   priority over this plan's queue (he may relay them to this session).

---

# PART A — Confidence-Matrix hardening (fix the 🟠/🔴, protect the 🟢)

Source: `docs/CONFIDENCE_MATRIX.md` (in this repo). Work the tiers in order. Every fix re-rates its row.

## Phase A1 — Tier 1: crash-class & data-loss (do first)

| # | Item | Where (monorepo paths) | Shape of fix |
|---|---|---|---|
| A1.1 | **Handler-guard sweep** — unguarded event handlers, the fatal `e0434352h` class (STRUC BUG-001..004 pattern) | `Modules\Structural\Commands\SupportBlockCommands.cs` (~624–637), `UI\...\RCBeamPickerDialog.xaml.cs` (:82/:95/:110), `RCMemberDialog.xaml.cs` (~297–311), `SteelSectionPickerDialog.xaml.cs` (:63/:84/:96/:106), `MarkupWindow.xaml.cs` (:58), `MarkupWindowHost.cs` (:41), `UiCommands.cs` (:57) | Wrap each lambda/handler body in the house try/catch+log pattern (find STRUC's existing guarded-handler precedent and mirror). Add a source-scanning guard test (the CrossModuleGuardTests style) that fails on unguarded `+=` lambda handlers in the swept files, so the class can't regress. |
| A1.2 | **LoggingService silent no-op** — locked AppData turns ALL STRUC logging off silently | `Modules\Structural\Services\LoggingService.cs` (Initialize + Shutdown null-reset) | Guard Initialize; surface degraded state; unit tests. |
| A1.3 | **JobTime data integrity** (billing data!) — TimeEntryFileService stale-snapshot save race deletes fresh rows; SessionMerger silent row loss + MAX-not-SUM collapse; CsvLogger lossy rewrite | `Modules\Structural\Services\TimeEntry*/SessionMerger*/CsvLogger*` | Failing tests reproducing each loss first (pure logic — very testable), then fix. This is the highest-value data fix in the suite. |
| A1.4 | **IdleDetector tick-wrap** — the known "5-min idle never fires" field bug; signed/unsigned mix | `Modules\Structural\Services\IdleDetector.cs:41` | One-liner + regression test. |
| A1.5 | **CDEDIT BUG-116** — pit remark duplicated onto inlet line (open since 2026-05-12) + `PipeEditCommand.GradeText.cs:101` TODO | `Modules\Drainage\Commands\PipeEditCommand.GradeText.cs` | Reproduce in a pure test if possible; fix; flagship-command care (CDEDIT now also hosts the strips — regression-test those paths too). |

## Phase A2 — Tier 2: foundations Mission Control / AI sit on

| # | Item | Where | Notes |
|---|---|---|---|
| A2.1 | **AdminTelemetryService** — failure reporter can itself throw; heartbeat/session writes not atomic (fleet reads torn JSON); outbox unpruned | `Modules\Structural\Services\AdminTelemetryService.cs` (+ the CVL copy `Modules\Drainage\Services\AdminTelemetryService.cs` — fix BOTH or unify) | Atomic write pattern already exists in `TelemetryQueueService` (built 2026-07-02) — reuse it. Consider pointing both legacy services' shapes at the new fleet pipeline where trivial; do not rebuild Mission Control here. |
| A2.2 | **AssetDeployer never-overwrite** — `if (!File.Exists(dest))` means updated blocks/DCL never redeploy on version change | `Modules\Structural\Services\AssetDeployer.cs` | Version/timestamp-aware overwrite + tests. This silently breaks the update channel — matters before any pilot. |
| A2.3 | **Quarantine legacy MarkupAI HTTP lane + delete dead PyAutocad lane** — `MarkupAIChatService` (per-request HttpClient, sync-over-async on WPF thread), `VisionParser` blocking 5 min no-cancel, `MarkupAIPyAutocadWorkerService` unreachable + pipe deadlock, `MarkupPdfPageRenderService` zero callers | `Modules\Structural\Services\MarkupAI*` | CE.AI.Core supersedes all of it. Delete the dead code paths (git preserves history); route anything still reachable behind a clear "superseded by CE Assistant" message. Do NOT delete `MarkupIntentItem`/`CommandPlan` model shapes (reference schemas per docs/MARKUP_UPGRADE_NOTES.md). |
| A2.4 | **CVL perf pair** — PIT PERF-003 NOD-lock save stall ("PIT IS NOT UPDATED") + PITSCHEDULE opening lag (per-pipe transaction explosion) | `Modules\Drainage` PIT save path + `PitScheduleViewModel` load | Profile-guided; the matrix names the mechanisms. Perf fixes need before/after numbers in the log entry. |

## Phase A3 — Tier 3 + the v1.0 quality gate

| # | Item | Notes |
|---|---|---|
| A3.1 | **🔴 fix-or-hide sweep (v1.0 gate)** — every 🔴 command either fixed or hidden from the registry/ribbon | Matrix lists them (CVL 8, STRUC 4 drawing + 5 subsystem). Hiding = registry `hidden: true` + log entry; fixing = normal bug workflow. Decide per row by effort; record the decision in the matrix. |
| A3.2 | STRSCHEDCREATE: preflight + try/catch + `ToWcs` (tables land wrong under rotated UCS) | `Modules\Structural` |
| A3.3 | SL wiring: registry/toolbar say `SL`, code registers `CDSL` — dead toolbar button | `Modules\Drainage` registry or command rename — one line either way; check which Tim expects (default: register both). |
| A3.4 | Registry hygiene sweep both suites: STRUC ghosts (`C`, `BMT2TXT`, `BTXT2MT`, `XCLMTXTINDEX`), unregistered live commands (`JOBTIMERDEBUG`, `JOBTIMEREDIT`, `CEMARKUPDWGEXPORT`, `P1`, `RD`), CVL 18 off-registry, PIPEPITLINK/UNLINK deprecation, CDLABELSTYLE contradiction | Mechanical + guard test extension (duplicate scanner already exists — extend to ghost detection: registry entries with no code + code with no registry). |
| A3.5 | CDSOURCE base-point offset (suspected off-origin SOURCE.dwg) · CDSLABEDIT crash on open (PL-064) — fix or formally retire behind CDSLABEREGEN | `Modules\Drainage` |

## Phase A4 — close the loop
- Re-rate every touched row in `docs/CONFIDENCE_MATRIX.md` (with date + commit ref).
- Update SMARTIFY_PLAN update-log + CHANGELOG (user-visible items only).
- Produce a "what Tim should test" consolidated checklist for the hardening round (append to TIM_CHECKLIST as Part 7).

---

# PART B — Smartify the STRUC commands (the drainage recipe, structural engines)

**The pattern is proven and paid for:** pure advisor service → `CeSuggestionStrip` in the existing
dialog → [Use] fills fields → OK stays the only write path → ledger records accept/reject → apply-
machinery for write features. `CE.AI.Core`, the strip control, ChangePlan/preview/apply, and the
ledger are all suite-agnostic and already referenced by `Modules\Structural`'s project graph
(CE_SHARED; add CE.AI.Core reference when the panel tools arrive).

## Phase B0 — the study (do FIRST, mirrors the drainage studies)
Read-only recon of `Modules\Structural` + `Modules\Structural.DesignCore` (the pure "offline support
brain", 107 tests — the STRUC equivalent of PitSelector/PipeSizingSolver):
1. Map every dialog-driven command (RCBeam/SteelSection/RCMember pickers, SBEAM, BEXT/BTX, AB/BB,
   rebar family, ML, STRSCHEDCREATE…) → which have engine-computable suggestions vs need Tim's rules.
2. Map DesignCore's public API: what can it PROPOSE (member sizes? capacities? spacing?) vs only CHECK.
3. Identify the STRUC equivalents of: design review (whole-model validation aggregate), data sanity
   (schedule readiness), and the highest-value "invert arithmetic" style time-sink per Tim's daily use.
4. Note AUTO-DESIGN prior art (`docs/` in the module + master plan §18) — absorb, don't duplicate.
5. Output: a ranked strip shortlist + a Tim-questions list (house rules not in code), appended to this doc.

## Phase B1 — first strips (read-only, exactly the drainage v1 shape)
- Top 2–3 dialogs from B0 get advisors + strips. Candidate expectation (validate in B0):
  **beam/section picker suggestion** (DesignCore proposes a section from span/load context) and
  **STRSCHEDCREATE pre-flight** (reuse the pre-flight formatter pattern).
- IMPORTANT INTERLOCK: A1.1 hardens the exact dialogs B1 touches (RCBeamPickerDialog etc.) —
  **sequence A1.1 before B1 on any shared dialog.**
- Each advisor: pure, delegating to DesignCore/existing engines only, NUnit-tested, fail-soft strip.

## Phase B2 — STRUC panel tools (read-only)
- `get_struc_model` (STRUC's whole-model context — mirror `get_project_network`),
  `review_struc_design` (aggregate DesignCore checks — mirror `review_design`).
- Register in the CE Assistant panel (it's in the unified plugin; on STRUC-only machines the panel
  arrives with unification — note this dependency honestly).

## Phase B3 — write features (gated exactly like drainage's)
- Whatever B0 ranks as the STRUC `CDRUNSOLVE` equivalent, through ChangePlan/preview/apply. GATED on
  Tim's in-AutoCAD confirmation, on a copy, always.

## Phase B4 — ledger + evals
- Ledger events for every STRUC strip (feature ids `struc_*`).
- Extend the eval golden set with STRUC cases once B2 tools exist.

---

## Suggested execution order for the parallel session
1. A1 (crash/data-loss) — highest value, unblocks B1's dialogs.
2. B0 study (can run concurrently with A1 — read-only).
3. A2 + B1 in parallel (different files).
4. A3 sweep + B2.
5. A4 close-out + B3/B4 as gated finales.

## What only Tim can give this plan (collect as he surfaces from testing)
- CeSheets commit (unblocks those files) · scour caps (drainage sizing asserts) · any STRUC house
  rules the B0 study surfaces (expect: section preferences, cover/spacing conventions, load defaults)
  · rulings already pending (ribbon layout, Copy Rotate.lsp, CEHEALTH).
