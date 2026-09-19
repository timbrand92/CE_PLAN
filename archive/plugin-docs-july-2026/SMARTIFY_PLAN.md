# SMARTIFY PLAN — the living build plan

**What this is:** the single tracking page for making the CE plugin's commands smart — drafting AND
design. Updated live as pieces land. (Program-level context: `AI_PROGRAM_MASTER_PLAN.md`.)

**Last updated:** 2026-07-02 23:30 — **🏁 PROGRAM COMPLETE: 6 waves, 59 commits, 3,252 tests green
(Drainage 3049/0 · CE.AI.Core 14/0 · Harness 55/0 incl. LIVE eval 12/12 · DesignCore 107/0 ·
Worker 27/0), ALL DEPLOYED to Tim's AutoCAD 2027 (byte-verified).** The autonomous runway is fully
flown — all three plugins + CE.AI.Core + CE.Cloud in one solution (target shape §16.2 complete),
Stage-1 safe slice built (guards, module contract, CE.Host skeleton — never deployed).
**Everything that remains needs Tim:** (1) THE test session (checklist below; CDRUNSOLVE /
fix-all / markup-apply on a COPY), (2) the 15-min Cloudflare deploy (`docs/PILOT_ROLLOUT.md`),
(3) commit the STRUC sheet work + CSM fix in the old repos → sync, (4) the decision list (ribbon
layout, CEHEALTH owner, ~~Copy Rotate.lsp canon~~ DECIDED 2026-07-03, scour caps when ready,
remaining questions).
Then: Stage-1 H1-H3 build-out, pilot, v1.0.

---

## The vision (one paragraph)

An AI that has learned how Tim draws and designs, embedded invisibly in the plugin. Every tedious
step — invert arithmetic, sizing checks, schedule QA, design review — gets a "smart" assist: the AI
gathers the drawing context, runs **the plugin's own calibrated engines** (AS3500 grade tables,
velocity calcs, validation rules), and proposes values with plain-English reasoning. Tim reviews and
applies. Every accept/reject teaches it. The boring 60–80% compresses; the engineer stays in charge.

## The pattern (every smartified command works this way)

```
open the dialog you already use (CDEDIT, PIT, …)
   → a ✨ suggestion strip is ALREADY computed (your engine, milliseconds, no AI call)
   → glance → click [Use] → fields fill → you press OK as always
```

**STRATEGY (Tim, 2026-07-02): INLINE-FIRST.** The daily workflow lives inside the existing
commands/dialogs — no chatbot required. The deterministic proposals (grades, inverts, pit sizes,
levels) are pure engine code and run locally with zero AI calls. The CE Assistant panel remains for
what genuinely needs language: design-review reports, explanations, and (later) markup upgrade.

**Hard rules:** LLM never computes engineering numbers. Suggestion strips only fill form fields —
the dialog's existing OK button remains the single write path. Fail-soft: no suggestion computable →
the dialog behaves exactly as today.

---

## Status board

| # | Feature | What it does | Status |
|---|---------|--------------|--------|
| 0 | **AI pipeline + CE Assistant panel** | The engine: secure Claude access, tool-calling, dockable chat panel, `get_selection` | ✅ **DONE** — confirmed in AutoCAD 2027 |
| 1 | **Smartify pipe inverts & grades** | Select pipe → proposes AS3500-compliant grade + inverts anchored on pit levels, velocity + cover checked | 🧪 BUILT — 20/20 tests green; awaiting combined AutoCAD test session |
| 2 | **Whole-network context** (`get_project_network`) | AI can see ALL pits + pipes (levels, sizes, connectivity) — the foundation for every design-wide feature | 🧪 BUILT + wired into panel |
| 3 | **AI QA Manager** (`review_design`) | "Review my design" → runs the validation engine across every pipe, returns a prioritised issues report (reverse falls, flat grades, velocity, cover) with plain-English fixes | 🧪 BUILT + wired — 8 tests green |
| 4 | **Schedule / data sanity sweep** (`check_project_data`) | Catches missing levels, duplicate IDs, orphan pipes, naming inconsistencies before drawings go out | 🧪 BUILT + wired — 12 tests green |
| 5 | **Smartify pit setup** | Select pit → proposes plan size (from connected pipes + depth, per the CE Design Guidebook tables), step irons, cover/invert levels from survey + pipes, and flags inconsistencies | 🧪 BUILT + wired — 18 tests; Tim's 3 rulings encoded (Class C, 350×350, council sump) |
| 6 | **Pipe sizing from flow** | Optional "Q = __ L/s" box on the CDEDIT strip: empty = today's grade-only; filled = your solver verifies/upsizes the diameter ("DN225 → suggest DN300: exceeds capacity"). Never proposes downsizing. Q persists on the pipe. | 🧪 BUILT — 60 tests; **scour flagged "unconfirmed" until Tim rules** |
| 7 | **Ingest management** | Study DONE. Slice 1 (survey intake sanity) + slice 2a (post-import auto-QA) + slice 2b (pre-flight gate) + slice 4 (CDCHECKDWG) + slice 5 (PDF schedule ingest sanity) + slice 6 (smartify: path hardening, AI vision extraction fallback, package-aware pickup) + slice 7 (Import Quality v2: forensic-evidence bug fixes) + slice 8 (Import fixes round 3: ship-the-extractor + honest vision failures) | ✅ **ALL SLICES BUILT — feature complete**, now **smartified against Tim's REAL 26612 consultant package (2026-07-03)**. Prior slices: `SurveyIntakeSanityService` (21 tests), POST-IMPORT QA (11 tests), pre-flight Yes/No gate (`XcivilImportPreflightService`, 19 tests), `CDCHECKDWG` (`ConsultantDwgCheckService`, 20 tests), `PdfScheduleSanityService` (40 tests) — all as before, 2026-07-02. Slice 6 (2026-07-03, evidence-driven against the real package (5 pit rows, all empty pitId, 0 pipe rows — the consultant's table format defeats the deterministic pit-ID column parser)): (1) **path hardening** — `XcivilPdfSchedulePathHelper.NormalizeFullPath` canonicalizes both the PDF and temp-JSON paths to full long-form backslash paths before invoking Extract-XcivilPdfSchedule.ps1, working around the script's WinRT `StorageFile.GetFileFromPathAsync` call rejecting non-canonical path forms (root cause is script-internal, not touched per the no-new-build-script rule; the plugin now never *hands* the script a bad-form path) — 9 tests. (2) **AI vision schedule extraction fallback** — `XcivilScheduleDegradedDetector` (degraded = no-document/no-success/zero-rows/>50% empty-pitId/>50% sanity-dropped, 16 tests) triggers a pre-consent Yes/No prompt; on Yes, `XcivilVisionScheduleExtractionService` renders PDF pages via the existing `MarkupPdfImageRenderer` (net8/net10 only, net48 message-only per the established `#if NET8_0_OR_GREATER` precedent) and runs a one-shot vision call (mirrors `MarkupAnalysisService`/`CeAiEndpointResolver`); `XcivilVisionScheduleParser` maps the response into the exact `ImportedPitScheduleDocument` shape (fenced/dirty/invalid JSON tolerated, 18 tests) and every row still passes through the SAME `IsReasonableImportedPitScheduleEntry` + `PdfScheduleSanityService` validation as a PDF-OCR row — the model never bypasses validation. Threading: `XcivilVisionFallbackOrchestrator` runs the call on a background `Task.Run`, blocks the CDIMPORTXCIVIL command thread with a bounded (60s) poll loop, and writes all editor progress lines from the calling thread only (never from the background continuation) — documented as the chosen "acceptable design" given the whole pipeline is already synchronous with no existing async boundary; ledger via `TelemetryEvent.EventTypeXcivilVisionExtraction` (counts only). (3) **package-aware pickup** — `XcivilPackageLocatorService` auto-locates the XCivil DWG/PDF/LandXML/comps-DOCX when Tim picks a package FOLDER instead of a bare DWG, tolerant of the real package's double-nested `Seperate Files\Seperate Files\...` / `Single File\Single File\...` shape; LandXML is parsed ONLY as a Structs/Pipes cross-check count, never as an import source (15 tests); picking a bare DWG is untouched. 58 new tests total, all green on net48 + net10.0-windows; full suite 3179 passed / 0 failed / 13 skipped. **Slice 7 — Import Quality v2 (2026-07-03), forensic before/after DXF diff of Tim's REAL import run (W26-32, Mike's 26612 package) found five defects + a systemic annotation problem — see REGRESSION_LOG.md BUG-3..7+FEATURE for full root-cause detail:** (1) **idempotency guard** — `XcivilImportIdempotencyService` detects a prior XCivil import via batch-tagged `PitData.Remarks` and prompts "Previous Xcivil import detected — Replace/Abort?" before the existing (previously silent) cleanup-and-reimport runs; proved the duplication was a missing-guard problem, not a single-run double-insert (only one command registration, no internal double-loop found). (2) **IO/OF pit registration** — `XcivilSourceTagPitRegistrationService` closes the gap where source-tag blocks (IO1-6, OF1-12) were drawn and pipes even resolved `From`/`To` to their tag string, but no `PitData` row ever existed for that id; now registers a lightweight (non-schedule) pit row for every tag a pipe actually references, and loudly reports any id that resolves to nothing. (3) **self-pipe forbidden** — `SelfPipeGuard` (prevention, at endpoint resolution) + `SelfPipeRepairService` (safety net, final integrity pass) — a pipe's two endpoints can never resolve to the same pit id; the far endpoint takes the next-nearest distinct pit or stays unresolved. (4) **junk filter** — `XcivilLayerRecognition.LooksLikeNonDrainageJunkLayer` excludes consultant dimension/guideline/defpoints/general-annotation layers from ever being copied as AGI/supplemental geometry, with counted per-layer reporting. (5) **mirror normalisation** — every raw `DBText` creation site in the shared `TextService` now explicitly clears `IsMirroredInX`/`IsMirroredInY` as a defensive guard (no clone-from-source path was found anywhere in the import pipeline, but nothing previously *guaranteed* that stays true). (6) **junction de-confliction** — `XcivilJunctionDeconflictionService` reuses the existing `pipeTextLayoutMode "auto"` lane-fan-out concept (`QuickModeService.ANNOTATION_LANE_SPACING`) to consolidate identical-value IL texts and fan out distinct ones at a shared pit, and to stagger pipe labels along their own runs at busy junctions — no new layout engine. 93 new tests always-green + 18 gracefully-skipped-without-local-AutoCAD (new `AcadTestHost` shared helper, same pattern as `GeometryHelperTests`), 0 failing on net48 or net10.0-windows; full suite net10.0-windows 3286 passed / 0 failed / 13 skipped of 3299. **Re-measure note:** the real 26612 PDF's deterministic extraction quality (5 rows/0 usable pitId) should be re-verified by Tim after this change, alongside a first live AI-vision-fallback run, to see the actual improvement; and Slice 7's fixes should be re-verified against a genuinely fresh import of the SAME package to confirm the forensic defects are gone end-to-end. **Slice 8 — Import fixes round 3 (2026-07-03), from Tim's REAL 12:57 run log — two field-proven bugs that data-starved the import while the log claimed success (see REGRESSION_LOG.md BUG-A+BUG-B 2026-07-03):** (A) **extractor never shipped** — `Extract-XcivilPdfSchedule.ps1` was staged into the build OUTPUT (`$(OutputPath)Tools\`) but `DeployToDevBundle`/`CopyToBundleOutput` never copied `Tools\` into any bundle, so EVERY deployed install ever hit "helper script not found ()"; both targets now carry `Tools\`, the probe list covers bundle+dev layouts (`XcivilScheduleService.BuildScriptPathCandidates`, unit-testable), and every probed path logs FOUND/missing. (B) **silent 0-row vision apply** — a vision parse that succeeded with 0 pit AND 0 pipe rows was applied as the schedule source under "Applied"; now treated exactly like a failed extraction (honest "both lanes failed" status), `MarkupPdfImageRenderer` gained a grid-sampled blank-capture detector (in-process WebView2 renders can silently paint nothing inside AutoCAD — all-blank renders now FAIL loudly instead of feeding the model empty images), the whole vision pass writes a per-step debug trail (render outcomes, images sent, response length, parse outcome + excerpt), `XcivilVisionScheduleParser` records pages-sent evidence so `PdfScheduleSanityService`'s empty-document check covers vision docs, that sanity check's page-count regex now also matches the PS1 lane's real `pdf-pages=N` format (it had NEVER matched it), and stray bare "OF"/"IO" labels no longer inflate the unresolved-registration count (`SkippedBareTagIds`). Round-3 test filter 100/100; full suite 3319 passed / 0 failed / 13 skipped (net10.0-windows), net48 0 errors; `Tools\Extract-XcivilPdfSchedule.ps1` byte-verified in both TFMs' build output. First real deploy must confirm `Tools\` lands in the installed bundle. |
| 8 | **One-click APPLY** for proposals | Turn accepted proposals into drawing edits — every apply goes preview → your explicit Apply click → one transaction → single undo | 🧪 BUILT-GATED — `Models/ChangePlan.cs` + `Services/ProposalApplyService.cs` + `Dialogs/ProposalPreviewDialog` built; apply reuses `LinkService.ApplyPropagationPlan` (the same write core CDPROPAGATE/CDEDIT's cascade prompt use) so applied edits are indistinguishable from a hand-applied CDEDIT save. 41 tests green on both TFMs, full suite no new failures. **2026-07-03: mm-vs-m units bug found and FIXED before Apply was ever confirmed safe** — `PipeGeometryHelper.TryComputePipeLengthM` was returning raw millimetre pit-position deltas mislabelled as metres, so dashboard-fix plans (which build on the same `ChangePlan`/preview/Apply pipeline as this row) proposed absurd multi-metre invert jumps; caught pre-Apply in the preview by Tim, root-caused and fixed (see REGRESSION_LOG 2026-07-03). Needs Tim's in-AutoCAD confirmation, including a fresh preview re-check of this fix, before daily use |
| 9 | **Whole-run solve** (`CDRUNSOLVE`) | Select a run → `NetworkDesignService` solves all inverts/grades → preview table of every change → Apply once → single undo | 🧪 BUILT-GATED — `Commands/RunSolveCommand.cs`. Pick start pit → pure downstream walk over ProjectData connectivity (`ProposalApplyService.WalkDownstreamRun`, no AutoCAD pick-set needed) → `NetworkDesignService.Design` on the run (downstream-most pit's current invert = fixed anchor) → `ChangePlan` (5mm tolerance filtered) → same preview/apply as #8. Registered in command-registry.json. **2026-07-03 BUG-1 fixed** — CDLPD-designated anchors with NO `PitData` record (e.g. STUB, the council connection point) now resolve their anchor IL from the terminal pipe's own stored `ToInvert` when no pit record exists (or a pit record exists but its invert is blank); `RunSolveCommand.EnsureAnchorPitSynthesized` supplies the terminal pipe's real drawn endpoint position so the last link's length stays accurate; clear error now names BOTH failed sources when neither resolves. 4 new tests, see REGRESSION_LOG 2026-07-03. Pending Tim's re-test confirmation |
| 10 | **Feedback loop** (accept/reject → corpus) | Every decision recorded, suggestions get more "Tim-like". Seed: LOCAL privacy-safe ledger (strip shown/used/committed events, numbers only — no drawing/client data) — syncs to CE Cloud later | 🧪 SEEDED — `SuggestionLedgerService` (29 tests) records shown/used/committed/cancelled for all 3 strips (pipe_grade, pit_setup, cd_drawfirst) to `%APPDATA%\CE_CVL_SUITE\ledger\suggestions.jsonl`; corpus/analysis/CE Cloud sync still 📋 PLANNED |
| 11 | **Markup upgrade** | Take an engineer's redline markups and upgrade them into proper drafted elements — the AI reads the markup, plans the CAD work, Tim approves | 🧪 FULL SLICE BUILT-GATED — vision lane (slice 1, `get_markup_image`) + structured findings (slice 2, `MarkupFinding`/`MarkupAnalysisService`/`MarkupFindingParser`/`MarkupFindingsFormatter`) + (slice 3, 2026-07-02) `MarkupToChangePlanService` maps ACTIONABLE `dimension_change` findings with an unambiguously-resolved pipe/pit target to a `ChangePlan` — DN/grade/invert numbers all engine-derived via `PipeGradeAdvisorService`/`DesignValidationService`/`MathHelper.TryParseGrade`, never trusted raw from the model; everything else (add/delete/move/text_note/unclear, ambiguous targets, pit cover, absurd values) excluded with a specific reason, never silently dropped. CE Assistant panel: "Analyse markups" now also shows a **"Review N proposed changes…"** button routing through the SAME `ProposalPreviewDialog` → `ProposalApplyService.Apply` → single-transaction/single-undo path as #8/#9 — no new write mechanism. 23 new tests (pure, no AutoCAD), full suite no new failures on both TFMs. Needs Tim's in-AutoCAD confirmation on a COPY before daily use (see REGRESSION_LOG) |
| 13 | **✨ Inline suggestions in CDEDIT** | Pipe-edit dialog opens with the proposed grade/inverts already computed — one click [Use] fills the fields; OK applies as always. No AI call. | 🧪 BUILT — strip in both CDEDIT layouts, 12 tests |
| 14 | **✨ Inline suggestions in PIT dialog** | Editing a pit shows suggested plan size, step irons, cover/invert levels (survey + pipes) — [Use] fills the form. No AI call. Place mode + SPS/detention/plastic unchanged. | 🧪 BUILT — 26 tests |
| 15 | **Schedule pre-flight check** | PITSCHEDULE dialog shows data issues (missing levels, duplicates, orphans) BEFORE the schedule generates — informational, never blocks | 🧪 BUILT — 13 tests |
| 16 | **Design dashboard ← QA engine** | `CDDASHBOARD` now includes the whole-network design review (severity-first issues + skipped-with-reason) in the existing grid — one command, no chatbot | 🧪 BUILT — 6 tests |
| 17 | **Suggestion-strip unification pass** | One shared component + style for every ✨ strip across dialogs (professional consistency) | 🧪 BUILT — `Controls/CeSuggestionStrip.xaml` now used by CDEDIT (both layouts) + PITEDIT; PITSCHEDULE pre-flight kept as an Expander (informational-only, no [Use]/proposal — judgement call, see REGRESSION_LOG) |
| 18 | **Suggest-while-drawing (pipes)** | Superseded: draw-first CD (#20) covers the create case; live strip recompute on diameter change = follow-on slice | ✅ ABSORBED — live recompute delivered as #20 slice 2 (see row 20), 2026-07-02 |
| 19 | **CDCALC prefill** | PipeFlows tab: slope (from inverts) + roughness (from material) prefill on pipe pick — fills blanks only, never overwrites typed values | 🧪 BUILT — 22 tests (17 service + 5 VM); cover-page job/address prefill deferred (needs Tim's folder convention) |
| 20 | **Draw-first CD** | Draw the pipe run BEFORE the options dialog — dialog opens with the grade/invert suggestion already computed from the picked run. Behind Advanced-Settings toggle `cdDrawFirst` (default OFF until Tim tests). Tim's idea, 2026-07-02 | 🧪 BUILT — 10 tests (slice 1) + **slice 2: LIVE strip recompute on Diameter/Material change** (absorbs #18) — `GradeSuggestionContext` stashed once (no AutoCAD calls on recompute), same `FlowSizingRecomputeRequested` wire as the #6 Q box, ledger dedup so recompute doesn't spam `strip_shown`, 24 new tests (2026-07-02, see REGRESSION_LOG). **2026-07-03 BUG-2 fixed** — the auto-apply-on-open feature (built same day) silently produced no fill when `BuildSuggestionContext` threw (no try/catch — violated the file's own fail-soft contract, could abort the whole CD command) or when neither endpoint resolved to a pit; `ApplyCreateGradeSuggestion` now wraps context-building in try/catch and surfaces a SPECIFIC loud reason ("No auto-fill: could not resolve a pit at either end of the drawn run…", etc.) instead of a generic message or a silent command abort. **Enhancement also landed 2026-07-03**: strip tooltip now names both endpoint pits' CL/IL/depth, the AS3500 min grade used, and cover status ("US pit P3: CL 18.90 / IL 17.01 (depth 1.89m); DS pit P4: ...; AS3500 min grade 1:300 for DN225; cover OK both ends") — same code path for CDEDIT and draw-first. 6 new tests, see REGRESSION_LOG 2026-07-03. Pending Tim's re-test confirmation. 4 refinement questions still open (pick sequence, toggle default, batch, ghost preview) |
| 12 | **Fleet data — every install reports back** | Telemetry from ALL users: versions, command usage, crashes, AI accept/reject → Mission Control + learning loop. Privacy: engineering metadata only, structurally enforced client AND server side | 🧪 BACKBONE BUILT — `POST /v1/telemetry` + `GET /v1/fleet` (`CE.Cloud/worker/src/worker.js`, seat-token auth, server-side field/shape validation, KV-optional storage), `InstallIdentityService`/`TelemetryEvent`/`TelemetryQueueService` (`Modules/Drainage/Services/`, 35 tests) + one heartbeat wired at plugin startup. **Mission Control fleet page now exists at `GET /fleet`** (dark-theme HTML dashboard, seat-token login, 60s auto-refresh, per-install version/AutoCAD release/TFM/last-seen/usage-crash-AI counts; aggregation capped at 200 installs × latest 50 events each) — see `CE.Cloud/worker/README.md` "Mission Control fleet view". **Activates when Tim deploys CE Cloud + sets `CE_CLOUD_URL`/`CE_CLOUD_AUTH`, and binds `TELEMETRY_KV`** — until then the outbox queues locally forever, harmless, and `/fleet` shows the KV-unbound empty state. See REGRESSION_LOG.md 2026-07-02 entries |
| 21 | **STRUC into the monorepo** | Structural suite imported side-by-side as `Modules/Structural` — snapshot of the pushed branch; Tim's in-progress sheet work stays in the old repo until committed | 🧪 DONE — 4 projects, builds green, 567 tests |
| 23 | **Suite Manager into the monorepo** | `Modules/Manager` — snapshot of committed master; **target shape §16.2 structurally complete** (all 3 plugins + CE.AI.Core + CE.Cloud in one solution). Module-ized for the unified host (`CeManagerModule` + guard shim, mirrors Drainage) and net48 RibbonBuilder bug FIXED (`#if !NET48` guard) — MONOREPO_NOTE.md | ✅ DONE — net48 + net10 both build 0 errors; net8.0-windows added, known env gap (no true AC2025/2026 ref DLLs, matches Drainage's CS1705 failure) |
| 24 | **Markup PDF/image input lane** | Per Tim's ruling (markups = PDF redlines + DWG clouds): "Analyse markups" gains a pick-a-file path — PDF pages/images → vision — alongside screen capture | 🧪 BUILT-GATED — new "From file…" button (`CeAssistantControl`) next to "Analyse markups"; `MarkupFileImageLoader` routes PNG/JPG (downscale+re-encode reusing `MarkupImageCapture`'s caps) and PDF (net8/net10 only, `MarkupPdfImageRenderer` — offscreen WebView2, `#page=N` navigation + `CapturePreviewAsync`, first 5 pages, byte-identical-capture end-of-document detection, truncation note when the cap is hit); net48 (AutoCAD 2022-2024) shows a clear "PDF support requires AutoCAD 2025 or later — convert to PNG/JPG" message (`#if NET8_0_OR_GREATER`, same precedent as `HelpGuideWindow`/CDHELP). Multi-page PDFs go into ONE vision call (`CeChatMessage.UserWithImages` already supported a list). `MarkupAnalysisService.AnalyzeImagesAsync` added, sharing the same parser/formatter/ChangePlan/Review-changes path as screen capture. Ledger: `sourceIsFile` recorded as an existing numeric field on `markup_analysis` (no schema change — `SuggestionLedgerValues` is numbers-only by design). 15 tests (net10; 14 on net48 — PDF path differs), full suite no new failures — see REGRESSION_LOG. Needs Tim's in-AutoCAD confirmation |
| 25 | **Dashboard fix-all batch apply** | "Propose fixes for ALL solvable issues" → one combined ChangePlan → one preview → one Apply (drafting-speed priority per Tim) | 🧪 BUILT-GATED — `ProposalApplyService.BuildDashboardFixAllPlan` merges every currently-VISIBLE (filtered) fixable issue's single-pipe plan (SAME builder the single-issue path uses) into one `ChangePlan`; same-entity-field conflicting proposals EXCLUDE both with a warning, identical duplicates keep one; dashboard's new "⚒ Propose fixes for all…" button → ONE `ProposalPreviewDialog` → ONE `ProposalApplyService.Apply` → one undo group; command-line echo `"[CE] Fix-all: N changes applied across M pipes; K issues skipped"`. 9 new tests (pure, no AutoCAD), full suite no new failures. **2026-07-03: mm-vs-m units bug found and FIXED** — `BuildDashboardFixAllPlan` calls the same `BuildDashboardFixPlanForPipe` builder as the single-issue path (row 8), which was feeding `PipeGeometryHelper`'s un-converted millimetre pit-position deltas into the grade advisor as if they were metres, producing absurd multi-metre invert proposals across the whole batch; root-caused and fixed at `PipeGeometryHelper.TryComputePipeLengthM` (see REGRESSION_LOG 2026-07-03), 4 new regression tests added. Needs Tim's in-AutoCAD confirmation on a COPY before daily use, including a fresh preview re-check of this fix (see REGRESSION_LOG) |
| 26 | **Unified host — Stage 1, steps 3-4 (CE.Host hosts all three + one ribbon)** | Per `docs/UNIFIED_HOST_STUDY.md` §H2/§H3: `CE.Host` now references and hosts ALL THREE modules (`CeManagerModule → CeCvlModule → CeStrucModule`, Manager-first per the study), one deterministic `Application.Idle` hop drives every module's `InitializeUi` in the same order, and Manager's `InitializeUi` triggers `CeUnifiedRibbonService.RequestRebuild()` so the unified ribbon builds AFTER every contributor is registered (fixes the study's documented "early-returns if no contributors yet" wrinkle). Drainage's own CUIX auto-install gained the same hosted-mode suppression guard Structural already had. Added a pure `CeDuplicateCommandScanner` (CE_SHARED) + CE.Host startup report logging every duplicate `[CommandMethod]` name (CEHEALTH/CESUPPORT) — report only, no runtime dedupe surgery (Tim's ruling still pending) | 🧪 BUILT (flag-inert, harness-only) — 27 new tests green on net48+net10 (13 scanner + 7 module-order/marker + 6 CUIX-suppression + 1 ribbon-timing). `PluginInitialization.cs`/`Plugin.cs`/`CeManagerModule.cs` diffs are only guard/seam additions, grep-verified. `CE.Host` still has zero deploy targets. net48+net10 solution-wide: 0 errors; net8.0-windows: same pre-existing 17-error env gap (no true AC2025/2026 ref DLLs) all three modules already had individually. Drainage.Tests: net10 3080/0 clean, net48 92 pre-existing `Acdbmgd.dll`-stale-copy failures (environmental, none in new tests). See REGRESSION_LOG — hosted boot itself is GATED on Tim's interactive AutoCAD test |
| 22 | **AI eval harness** | Master plan §15.4 — a golden question/answer set that proves the AI's answers stay correct, so a Claude model upgrade can be trusted instead of guessed at. `CE.AI.Harness --eval`/`--eval-dry`/`--eval-verbose` runs 12 seed cases (deepest/shallowest pit, depth/pipe-count/diameter numeric checks, network connectivity, read-only guardrail refusals, no-invented-numbers) against the demo network tool, prints a PASS/FAIL table + token usage, non-zero exit on failure | ✅ DONE — live pass reached clean 12/12; 3 failing cases fixed (2 numeric extraction regexes tightened, 2 guardrail regexes broadened) — see REGRESSION_LOG.md 2026-07-02 "AI eval harness: 3 failing live cases fixed"; 55 tests |
| 27 | **Unified bundle package — built, never installed; cutover checklist ready** | Step 5 of the unification (`docs/UNIFIED_HOST_STUDY.md` §16.3): `CE.Host/Installer/PackageContents.xml` (modeled on Drainage's exactly, 3 lanes × 3 module `ComponentEntry`s, full command lists) + `CE.Host.csproj`'s new opt-in-only `BuildUnifiedBundle` MSBuild target tree (`dotnet msbuild CE.Host\CE.Host.csproj /t:BuildUnifiedBundle /p:Configuration=Release`) that packages Legacy(net48)/Net8(tolerated-fail)/Modern(net10) lanes into `CE.Host\payload_build\CE_ACAD_PLUGIN.bundle\` — DLLs, merged Assets, versioned PackageContents.xml. `docs/CUTOVER_CHECKLIST.md` (new) is the full step 5→6 playbook | 🧪 BUILT — payload verified (31 DLLs/lane, PackageContents.xml version-synced). **2026-07-03 UPDATE:** Copy Rotate.lsp canon DECIDED (`C:\Lisp Files\Copy Rotate.lsp` v2.2) — Drainage's and Structural's copies synced to it (byte-identical, diff-verified; Structural's had DIVERGED, missing the COPYMODE=0 fix), so `DetectUnifiedAssetCollisions` no longer hardcodes a Copy-Rotate exclusion — it's now a general SHA256 content-aware check (any same-relative-path file with IDENTICAL content merges fine; only genuine content differences fail the build). `Assets\Config\command-registry.json` and `ce_toolbar_layout.json` still collide across all three modules (genuinely different per-module files, hardcoded non-namespaced runtime paths) and now correctly fail `DetectUnifiedAssetCollisions` for real (verified by running the target standalone) — this is a separate, still-open design gap (spawned as its own follow-up task), NOT resolved by the Copy Rotate fix. See REGRESSION_LOG 2026-07-03 |

**Legend:** ✅ done · 🔨 building now · 📐 being designed · 📋 planned · 🔒 gated (needs Tim's green light)

---

## Batch 1 (read-only, building in parallel now)

Features **1–4** + the design study for **5**. All read-only: they propose and explain, never edit.
Each ships with unit tests on its pure logic. Integration (wiring all tools into the panel + one
deploy) happens once, at the end, followed by **one combined AutoCAD test session**.

### THE combined test session (one deploy, then this — inline features first, they're the point)

**Inline (the daily drivers — no chatbot):**
1. **CDEDIT** on a linked pipe → suggestion strip already shows proposed grade/inverts →
   **[Use]** fills the fields → OK applies normally. Also: a pipe with missing pit levels → strip
   shows "no suggestion" reason, dialog otherwise normal.
2. **Edit an existing pit** (with connected pipes) → strip shows suggested size / step irons /
   CL / IL with sources → **[Use]** fills → Place/OK as normal. Place a NEW pit → dialog unchanged.
   An SPS or plastic pit → no strip.
3. **PITSCHEDULE** → pre-flight line at top (amber + details if data issues; muted if clean);
   generation itself unchanged.
4. **CDDASHBOARD** → design-review section in the grid: reverse falls/flat grades severity-first,
   skipped pipes listed with reasons; double-click navigates.
5. **Draw-first CD:** Advanced Settings → tick "Draw pipe run before options dialog (CD)" → run
   `CD` → pick the run FIRST → dialog opens with the strip already populated → OK draws it.
   Then: Esc at first pick = clean exit; cancel dialog after picking = nothing drawn.
   Toggle OFF → CD behaves exactly as it always has.

**Panel (the language stuff):**
6. `CDASK` → "review my design", "check my project data", "describe my network", select something →
   "what's selected?" — answers stream in, nothing edits the drawing.

**Invariants throughout:** drawing only ever changes via your own OK/Place buttons; AutoCAD never
freezes; every strip/pre-flight failure mode is silent-graceful, never an error dialog.

---

## Tim's strategic rulings — 2026-07-02 evening

- **Scour caps: LEAVE FLAGGED** — placeholders stay "unconfirmed" until Tim checks references.
- **Markups = BOTH PDF redline prints AND DWG clouds/text** → feature 24 (file-input vision lane) queued.
- **Rollout: 1–2 pilot colleagues SOON** → CE Cloud deploy is Tim's next real task; runbook at
  `docs/PILOT_ROLLOUT.md`; telemetry + /fleet ready and waiting.
- **North star: DRAFTING SPEED FOR TIM first** → prioritise apply-mechanism depth (fix-all batch
  apply #25, draw-first polish) over other threads.

## Questions for Tim — round 2 (from the flow/ingest studies, 2026-07-02)

**Blocking one thing each; everything else proceeds:**
8. **Scour velocity caps** (blocks #6 asserting compliance): confirm the placeholder max velocities in
   `MaterialVelocityLimits` — UPVC 3.0 / concrete 6.0 / metal 4.0 m/s. Until confirmed, sizing
   suggestions flag "scour unconfirmed" and never assert.
9. **Where does design flow (Q) come from in your real workflow** — typed per pipe, or per-pit inlet
   flows accumulated downstream? Which ARI governs pipe sizing (council PSD 1:5)?
10. **Survey junk you actually see** — typo'd RLs? dimension text mistaken for levels? mm-vs-m files?
    (Tolerances: is a 0.10 m spot-vs-TIN delta "wrong"?) A sample survey XREF + raw 3D DWG would make
    a great regression fixture.
11. **Xcivil import: gate or inform?** Should a pre-flight summary let you Cancel BEFORE pits are
    inserted (import mutates heavily), or stay informational like the schedule pre-flight?
12. **Vision governance:** OK to send consultant PDF schedule pages to the Claude API when the
    deterministic extractor fails? (Different lane from telemetry; needs its own ruling.)
13. **Office folder/filename convention** for job number + address (unlocks CDCALC cover-page prefill).

## Questions for Tim (house rules the code doesn't know — answers sharpen feature 5+)

1. **Lid class default conflict** — ✅ **ANSWERED (Tim, 2026-07-02): surface use per Australian
   Standards; Class C is typical.** → Encode: office default = Class C everywhere (fix `PitSelector`'s
   unknown-surface default from B → C to match the dialog).
2. **Grated vs solid** — is there a rule (e.g. solid for junction pits, grated at sags)? None in code.
3. **Pit invert vs sump** — ✅ **ANSWERED (Tim, 2026-07-02): depends on council.** → Encode later as a
   council-profile field (CouncilProfileService is OSD/PSD-only today); until then proposals keep the
   explicit "no sump allowance — council-dependent" label.
4. **350×350 plastic pits** — ✅ **ANSWERED (Tim, 2026-07-02): the guidebook comment is right** —
   allowed when depth ≤0.45 m AND all pipes ≤100 mm. → **The code is wrong** (never allows it with
   pipes connected): fix `PitSelector` + its tests to match the confirmed rule.
5. **600×900 orientation** — which way does the long axis face (along the outlet pipe?)?
6. **Cover level source** — is the survey/TIN RL always the right cover proposal, or are there offsets
   (kerb inlets, pits set low in swales)?
7. **Pit numbering** — flag non-sequential/upstream-downstream ordering, or is any unique P{n} fine?

## Known gaps / notes

- **Material scour velocity limits are placeholders** in `MaterialVelocityLimits.cs` ("TIM TO
  CONFIRM") — proposals flag this rather than assert scour compliance. Tim to confirm real limits.
- **Dormant engine discovered:** `PitSelector.cs` — the CE Design Guidebook pit-sizing tables, coded
  and fully unit-tested, but with **zero production callers** until now. Feature 5 is its first
  consumer. (Also: its doc comment and code disagree on 350×350 eligibility — see question 4.)
- **CE Cloud proxy** built (`CE.Cloud/worker/`) but not yet deployed — parked until team rollout.
  Dev machines use the `ANTHROPIC_API_KEY` env var meanwhile.
- **STRUC suite** not yet in the monorepo — smartify lands on drainage first; the pattern (and
  `CE.AI.Core`) is suite-agnostic by design.

## Update log

- **2026-07-03 (latest)** — **Part-2R retest fixes: CDRUNSOLVE anchor-without-pit-record (BUG-1) +
  draw-first CD silent no-fill (BUG-2) + deepened context tooltip (enhancement).** Runsolve lane
  scope only (`RunSolveCommand`/`ProposalApplyService.PlanBuilders`,
  `CdCommand.GradeSuggestion`/`CdViewModel.GradeSuggestion`/`PipeEditCommand` context assembly,
  advisors, tests) — did not touch any `Xcivil*` file (concurrent Import Quality v2 crew's scope).
  **BUG-1** — `ProposalApplyService.BuildRunInputs` only resolved the anchor's IL via
  `pitsById.TryGetValue`; when the LPD-designated anchor (e.g. STUB, the council connection point)
  has NO `PitData` record at all, that failed with "The run's downstream-most pit could not be
  resolved" even though the terminal pipe's own stored `ToInvert` carried the real connection
  invert. Fix: try the pit's `InvertLevel` first, fall back to the terminal pipe's `ToInvert`;
  `RunSolveCommand.EnsureAnchorPitSynthesized` (new) supplies the anchor's real drawn position from
  the terminal pipe's polyline so the last link's length calc still works; clear error now names
  BOTH failed sources when neither resolves. 4 new tests. **BUG-2** — `CdCommand.GradeSuggestion.cs`'s
  `ApplyCreateGradeSuggestion` had no try/catch around `BuildSuggestionContext` despite the file's
  own "must never throw out of CivilDrainage()" contract — an exception there (survey payload,
  pit-resolution edge case) propagated to the outer command handler and silently aborted the whole
  CD command with a generic error, which read exactly like "no auto fill, no explanation". Fixed
  with a try/catch plus a new `out string failureReason` on `BuildSuggestionContext` naming the
  SPECIFIC cause (too few points / zero length / neither endpoint resolved to a pit) instead of a
  generic fallback message. **Enhancement** — `GradeSuggestionContext` gained `UpstreamPitId`/
  `DownstreamPitId` (wired in both the draw-first and CDEDIT context builders); the strip tooltip
  now shows both endpoint pits' cover level, invert level, depth, the actual AS3500 min-grade ratio
  used, and cover pass/fail per end — "US pit P3: CL 18.90 / IL 17.01 (depth 1.89m); DS pit P4: CL
  18.72 / IL 16.84 (depth 1.88m); AS3500 min grade 1:300 for DN225; cover OK both ends". No new
  hydraulics — pure wiring of numbers `PipeGradeAdvisorService` already computes. 6 new tests.
  net48 + net10.0-windows build 0 errors (full solution had pre-existing/concurrent-crew-in-flight
  compile breaks in `CopyRotateCommands.cs`/`TextService.cs`/`XcivilImportService.cs` at the start
  of this session — confirmed unrelated via isolated stash test, resolved by the other crew before
  this session's final verification build). Full suite: 3079 passed / 112 failed (109 pre-existing
  `Acdbmgd.dll`-not-found environmental failures + 3 unrelated concurrent-crew command-count/
  watchdog-timing failures, none touching runsolve/grade-suggestion code) / 73 skipped / 3264 total.
  All `BuildRunInputs_*`/`CdCommandGradeSuggestionTests`/`CdViewModelGradeSuggestionTests` suites
  green on both TFMs. See REGRESSION_LOG.md for the full three entries; `docs/TIM_CHECKLIST.md`
  Part-2R rows updated.
- **2026-07-03** — **BUG-CDASK-HANG: CDASK "review my design" stuck "processing" 10-15 min,
  no recovery (Tim's urgent report) — three watchdogs + a Stop button.** Root cause confirmed:
  every tool call is marshaled onto AutoCAD's application thread via
  `ICadExecutor.RunAsync`/`Application.DocumentManager.ExecuteInApplicationContext`
  (`Modules/Drainage/AI/AutoCadExecutor.cs`), and that API has NO bound on when — or whether — the
  callback runs if AutoCAD is mid-command or sitting in a modal dialog; the conversation's `await`
  then hangs forever with `IsBusy` never clearing. Belt-and-braces fix, four independent layers:
  (1) **Tool-call watchdog** — `CE.AI.Core/Agent/ClaudeConversation.cs` gained
  `RunToolWithWatchdogAsync` plus two new `CeConversationOptions`
  (`ToolStartTimeout` = 30s, `ToolCompletionTimeout` = 120s): if the executor callback hasn't
  STARTED within 30s, or has started but not FINISHED within 120s, the tool call faults with a new
  `CeAiCadBusyException` ("AutoCAD is busy — finish the active command/dialog and try again"),
  converted to an `is_error` tool_result exactly like any other tool failure — the model/panel
  recovers gracefully. Uses `Task.WhenAny` + timers, never blocks a thread, never cancels the
  underlying AutoCAD-side task (abandoned, not torn down — cancelling
  `ExecuteInApplicationContext` mid-flight isn't supported). (2) **SSE inactivity bound** —
  `CE.AI.Core/AnthropicChatClient.cs`'s `ParseSseAsync` now bounds each `ReadLineAsync` via a new
  `ReadLineWithInactivityBoundAsync` helper (90s default, `SseInactivityTimeout`): a connection that
  goes quiet mid-stream (no more lines, socket never closes) now throws `CeAiConnectionException`
  instead of sitting idle for the rest of the existing 10-minute `RequestTimeout`, and the existing
  retry/backoff machinery picks it up. (3) **Overall-request watchdog** —
  `Modules/Drainage/Controls/CeAssistantRequestWatchdog.cs` (new, pure/WPF-free, unit-tested): owns
  the in-flight `CancellationTokenSource` + a 5-minute last-resort timer as one unit, so literally
  any hang — known or not-yet-found — self-cancels within 5 minutes and shows "⚠ Timed out —
  cancelled. AutoCAD may have been busy; try again." `IsBusy` is now cleared through ONE shared tail
  (`CeAssistantControl.FinishRequest`) for every outcome (success/cancel/watchdog-timeout/error), so
  the panel can never get stuck busy. (4) **Stop button** — the Send button becomes "Stop" (XAML
  `DataTrigger` on `IsBusy`) while a request is in flight; clicking it calls
  `CeAssistantRequestWatchdog.Stop()` (same CTS the watchdog and the request itself observe), so
  Tim is never locked out of his own panel. Numbers-only timeout counters
  (`CE.AI.Core/CeAiTimeoutLedger.cs`, new): `ToolWatchdogFireCount`, `SseInactivityFireCount`,
  `OverallRequestTimeoutCount`. 17 new tests: 5 tool-watchdog cases in
  `CE.AI.Core.Tests/ClaudeConversationTests.cs` (never-starts, starts-but-never-finishes, normal-fast
  unaffected, ledger increments), 4 SSE-inactivity cases in
  `CE.AI.Core.Tests/AnthropicChatClientTests.cs` (stalls-immediately, stalls-after-partial-prefix,
  normal-fast unaffected, ledger increments) using a new `FakeHttpMessageHandler.EnqueueStallingSse`
  stream, 10 in `Modules/Drainage.Tests/Controls/CeAssistantRequestWatchdogTests.cs` (start/stop/
  watchdog-fire/finish-prevents-late-cancel/reuse-after-stop/reject-non-positive-timeout). CE.AI.Core
  29/29 (was 21/21 — 8 new). `Modules/Drainage/Commands/XcivilImportService.cs`,
  `CopyRotateCommands.cs`, `TextService.cs`, `ProposalApplyService.PlanBuilders.cs` had unrelated
  pre-existing/concurrent-crew compile breaks at the time of this change (confirmed zero errors or
  warnings in every file this change touched, on both net48 and net10.0-windows) — Drainage.Tests
  could not be run end-to-end as a result; the new Drainage-side tests are ready to run once that
  lands. Did not touch any `Xcivil*` file, `RunSolve`, `CdCommand.GradeSuggestion`, or
  `PipeEditCommand`-context file (other crews' scope). See REGRESSION_LOG.md for the full entry and
  Tim's AutoCAD test checklist; `docs/TIM_CHECKLIST.md` Part-2R row updated.
- **2026-07-03** — **CDASK progress feedback + draw-first CD field pre-fill (Tim live-test
  feedback, 2026-07-03)**: two UX fixes. (1) `CE.AI.Core/Agent/ClaudeConversation.cs` gained a new
  additive `ToolActivity` event (`ToolActivityPhase.Thinking/Started/Finished`, tool name, elapsed)
  fired around each model turn and each tool round-trip, so long silent gaps during tool-heavy Asks
  (e.g. `review_design` on a 49-pipe network) now show live status instead of going quiet.
  `Modules/Drainage/Controls/CeAssistantStatusMapper.cs` (new, pure/static) maps events to
  plain-English phrases ("Thinking…", "Reading your selection…", "Reviewing the whole design…",
  "Checking project data…", "Reading the network…", "Looking at the drawing…",
  "Sizing/checking the pipe…", "Checking the pit…", generic "Running {tool}…" fallback);
  `CeAssistantControl`/`CeAssistantViewModel` gained `BusyStatusText`, updated via the control's
  Dispatcher (same discipline as streamed deltas) and shown as a muted italic line under the busy
  indicator, replacing the old fixed "CE Assistant is thinking…" string. (2) Draw-first CD
  (`CdCommand.GradeSuggestion.cs`) now auto-applies a feasible grade/invert suggestion into the
  dialog's bound fields the moment it's first computed (dialog not shown yet, fields still empty),
  reusing `CdViewModel.ApplySuggestionCommand` — the exact same logic the strip's [Use] button
  runs — via a new `autoApply` parameter on `ApplyCreateGradeOrFlowSuggestion` (true only for the
  initial call; every later live-recompute while the dialog is open, e.g. the user editing
  Diameter/Material, passes `autoApply:false` so in-progress edits are never overwritten). The
  strip stays visible with a new prepended note (`CdViewModel.AutoFilledFromDrawnRunNote` =
  "Auto-filled from drawn run — review before OK.") on its reason/tooltip via
  `AnnotateSuggestionAsAutoFilled`. CDEDIT is untouched (this method lives entirely in CdCommand's
  draw-first-only path; `PipeEditCommand.GradeSuggestion.cs` is the separate CDEDIT caller and was
  not modified). Ledger: reuses the existing `strip_used`/`cd_drawfirst` event unchanged — the
  ledger schema is deliberately numbers-only (no free-text source field), so no schema change was
  needed or made. 20 new tests total: 7 in `CE.AI.Core.Tests/ClaudeConversationTests.cs` (event
  sequence: Thinking-only, Thinking→Started→Finished, elapsed reported, unknown-tool still brackets
  Started/Finished, multiple tools in one turn, handler-throws doesn't break the conversation,
  no-subscriber is a no-op), 6 in `Modules/Drainage.Tests/Controls/CeAssistantStatusMapperTests.cs`,
  4 in `Modules/Drainage.Tests/Controls/CeAssistantViewModelStatusTests.cs`, 5 in
  `Modules/Drainage.Tests/Commands/CdCommandGradeSuggestionTests.cs` (draw-first+feasible→fields
  populated, live-recompute leaves user edits alone, infeasible/no-context→fields untouched), 4 in
  `Modules/Drainage.Tests/ViewModels/CdViewModelGradeSuggestionTests.cs`
  (`AnnotateSuggestionAsAutoFilled` note/no-op/no-double-prefix). CE.AI.Core.Tests 21/21 (was
  14/14 — 7 new). Drainage full suite net48: 98 failing (all pre-existing `Acdbmgd.dll`-load
  environment-gap failures documented in the repo's own CLAUDE.md, none in any file touched by this
  change — confirmed by name-diffing the failure list and running the 4 touched/new test classes in
  isolation: 78/78 green). net48 + net10.0-windows build 0 errors for `CE.AI.Core`, the Drainage
  plugin, and both test projects. See REGRESSION_LOG.md for the two entries and Tim's AutoCAD test
  checklists. Concurrency note: did not touch `DesignReviewService`, `ProposalApplyService*`,
  `PipeGeometryHelper`, or `DesignCheckDashboard*` (another agent's in-flight units-bug fix).
- **2026-07-02 (latest)** — **Feature 26 follow-up (Structural module-ized for the unified
  host)**: mirrors what was just done for Drainage — `Modules/Structural/CeStrucModule.cs` (new,
  Structural's `ICeModule`, delegates verbatim to `Plugin.Initialize()`/`.Terminate()`;
  `InitializeUi` is a documented no-op because `Plugin.Initialize()` has no internal
  headless/idle-deferred split to hook, unlike Drainage's `PluginInitialization` — whole body runs
  from `InitializeCore`), 2-line guard shim in `Modules/Structural/Plugin.cs`
  (`if (CeUnifiedHostGuard.IsHostActive) return;` atop `Initialize()`/`Terminate()`, no `using`
  changes needed), plus two hosted-mode suppression guards at the exact call sites study §H3 names
  (`RibbonCommandHubService.Initialize()` — it races Manager's `CeUnifiedRibbonService` on the same
  tab id — and `WorkspaceMenuInstallerService.EnsureInstalledAndLoaded(...)`'s CUIX auto-install;
  `CeRibbonRegistry.Register(...)` stays unguarded since that's how the unified ribbon gets STRUC's
  content). Added `net8.0-windows` to STRUC's `TargetFrameworks` per master plan §16.4, with a new
  `_AcadRefNet8` discovery block mirroring Drainage's; STRUC has no WPF-UI/WebView2 packages and
  its Serilog pin was already TFM-unconditional, so no package-condition split was needed (checked
  and documented, not skipped). **net8.0-windows fails to build on this machine with the identical
  known gap Drainage has** — no true AutoCAD 2025/2026 net8 ref DLLs, `_AcadRefNet8` falls back to
  sibling-repo AC2027/net10 DLLs, producing `CS1705` System.Runtime version-conflict errors on the
  same 5 Autodesk reference assemblies Drainage's own net8.0-windows build fails on (verified by
  building Drainage's net8 target on this machine first, for comparison). net48 and net10.0-windows
  both build 0 errors. 3 new tests (`Modules/Structural.Tests/Services/CeUnifiedHostGuardShimTests.cs`
  — guard-default-false, `Activate()` proof, `CeStrucModule` structure check), green on both TFMs;
  full Structural suite net48 351/10/107 (468 total, same 10 pre-existing geometry-helper failures,
  no new ones) and net10.0-windows 463/0/5 (468 total) — no regressions vs the 465-total baseline.
  Drainage full suite re-confirmed green (3056/0/13, 3069 total) and `CrossModuleGuardTests`
  (9/9) unaffected — `CE.Host`/`Modules/Manager`/`Shared/CE_SHARED`/`Modules/Drainage` were not
  touched (concurrency boundary with the parallel Manager module-ization session). See
  REGRESSION_LOG.md.
- **2026-07-02 (latest)** — **Feature 26 follow-up (Suite Manager module-ized for the unified
  host)**: `Modules/Manager/CeManagerModule.cs` (new, Manager's `ICeModule`, delegates verbatim to
  `Plugin.Initialize()`/`.Terminate()` — mirrors `CeCvlModule.cs`; Core/Ui split not applied, no
  existing seam in Manager's `Initialize()` body, documented as follow-up in MONOREPO_NOTE.md),
  2-line guard shim in `Modules/Manager/Plugin.cs` + two INTERIM SAFETY MINIMA (Autodesk.* resolver
  exclusion, headless/core-console early-return — explicitly a partial port of Tim's uncommitted
  CSM fix, provenance-commented, supersede plan in MONOREPO_NOTE.md). **Fixed the row-23 net48
  bug**: `CeUnifiedRibbonService.cs`'s RibbonBuilder-dependent body wrapped in `#if !NET48` with a
  no-op + log-line net48 branch — Manager now builds **0 errors on both net48 and net10.0-windows**
  (previously net48 failed with 7x CS0103). Added `net8.0-windows` to Manager's TargetFrameworks
  (§16.4 unification set) — confirmed same known env gap as Drainage (CS1705, no true AC2025/2026
  ref DLLs on this box). 7 new tests (`Modules/Drainage.Tests/Services/ManagerModuleShimTests.cs`,
  source-scanning style — no `CE_SUITE_MANAGER` compile dependency, `Modules/Manager.Tests` judged
  too heavy for this slice) green on both TFMs; full Drainage.Tests suite 3056/0/13 (was 3049/0/13
  — no regressions). Structural and Drainage unaffected/untouched. See REGRESSION_LOG.md.
- **2026-07-02** — **Feature 26 BUILT (Unified host — Stage 1 slice)**: per
  `docs/UNIFIED_HOST_STUDY.md`'s "smallest safe first slice" recommendation —
  `Modules/Drainage.Tests/Services/CrossModuleGuardTests.cs` (duplicate-command +
  dependency-pin guard tests, source-scanning style, 5 tests), `Shared/CE_SHARED/Contracts/ICeModule.cs`
  + `Shared/CE_SHARED/Services/CeUnifiedHostGuard.cs` (module contract + dual-host guard, static
  flag + AppDomain data slot for cross-CE_SHARED-copy visibility), `Modules/Drainage/CeCvlModule.cs`
  (Drainage's `ICeModule`, delegates verbatim to unmodified `PluginInitialization`), a 2-line guard
  shim in `Modules/Drainage/PluginInitialization.cs` (grep-verified — nothing else changed), and a
  new never-deployed `CE.Host` project (`CE.Host/CE.Host.csproj` + `Plugin.cs`) hosting ONLY
  Drainage in this slice (`AssemblyResolve` with `Autodesk.*` exclusion, core-console detection,
  log-only crash net, `Local\CE_ACAD_PLUGIN.PluginRuntime` mutex, guard activation before module
  load, idle-deferred UI init). 9 new tests (`CeUnifiedHostGuardTests` proves the guard defaults
  inactive), all green on net48 + net10.0-windows; Drainage full suite 3049/0/13 (3062 total, one
  pre-existing WebView2-timing flake cleared on retry) — no new failures. CE.Host builds net48 +
  net10.0-windows 0 errors (net8.0-windows blocked by the same pre-existing environment gap
  Drainage itself has — no AutoCAD 2025/2026 reference DLLs on this machine). Structural +
  Manager builds unaffected (same pre-existing net48 RibbonBuilder gap on Manager, documented in
  row 23, untouched by this slice). See REGRESSION_LOG.md.
- **2026-07-02** — **Features 8 + 9 BUILT-GATED**: `Models/ChangePlan.cs` (immutable
  `PlannedChange`/`ChangePlan` records), `Services/ProposalApplyService.cs` (pure plan builders
  from `NetworkDesignService`/`PipeGradeAdvisorService` output + apply via
  `LinkService.ApplyPropagationPlan` — the same write core CDPROPAGATE/CDEDIT's cascade prompt
  already use, one transaction/one undo group), `ViewModels/ProposalPreviewViewModel.cs` +
  `Dialogs/ProposalPreviewDialog.xaml(.cs)` (shared preview surface, mirrors
  `PropagationPreviewDialog`'s conventions), `Commands/RunSolveCommand.cs` (`CDRUNSOLVE` — pick
  start pit → pure downstream walk over ProjectData connectivity → solve → preview → apply),
  dashboard "Propose fix…" hook in `DesignCheckDashboardViewModel`/`DesignCheckDashboardDialog`,
  two new ledger events (`plan_created`/`plan_applied`/`plan_cancelled`) for `run_solve` and
  `dashboard_fix`. 41 new tests (`ProposalApplyServiceTests`, `ChangePlanTests`,
  `ProposalPreviewViewModelTests`), all green on both TFMs; full suite net10.0-windows
  2887/0/13 (2900 total) — no new failures vs baseline. Both features need Tim's in-AutoCAD
  confirmation before daily use — see REGRESSION_LOG.md checklist.
- **2026-07-02 (later)** — **Features 17 + 10-seed BUILT**: shared `CeSuggestionStrip` control now
  used by CDEDIT (both layouts) and PITEDIT — PitScheduleDialog's pre-flight expander deliberately
  kept as-is (no [Use]/proposal to unify). `SuggestionLedgerService` seeds the feature-10 learning
  loop with a local, privacy-safe JSONL ledger (shown/used/committed/cancelled, numbers/codes only)
  for all three strips (pipe_grade, pit_setup, cd_drawfirst). 29 new tests, all green on both TFMs;
  full suite net10.0-windows 2708/0/13 (2721 total) — no new failures vs baseline. See
  REGRESSION_LOG.md for full detail.
- **2026-07-02 16:20** — **Feature 1 BUILT**: `PipeGradeAdvisorService` (pure, 20/20 tests) +
  `smartify_selected_pipe` tool, registered in the panel. Reuses CDEDIT's own pit-resolution and the
  solver's 1:N grade convention. Board expanded per Tim: feature 7 scope confirmed (survey + Xcivil/PDF
  + consultant-drawing checks), feature 11 added (markup upgrade — STRUC MarkupAI prior art), feature 12
  added (fleet telemetry from all installs — needs CE Cloud deploy).
- **2026-07-02 15:55** — Plan created. Features 1–4 dispatched to parallel build crews; feature 5
  design study dispatched. Feature 0 (pipeline + panel) confirmed working in AutoCAD 2027 earlier today.
