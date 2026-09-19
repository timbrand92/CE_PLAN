# CE_CVL_SUITE — Auto-Design Roadmap

**Status:** PLAN ONLY — not started. Created 2026-06-09.
**Goal (Tim's words):** *"Get it to a point where it designs and draws the project itself — we just do the setups."*
**Scope of v1:** single-lot / small-site residential stormwater (Melbourne metro).

> This is the navigation map for the auto-design initiative. It does not authorise any build —
> Phase 0 coding is gated on confirming the current AutoCAD-pending items (PL-072, R15/R15.2/R15.3).

---

## 1. The vision, as a ladder of autonomy

Like the levels of a self-driving car. The plugin moves the *decisions* — not just the drafting —
from the engineer's head into the tool, one rung at a time.

| Level | What it does | Today |
|---|---|---|
| L1 — Assists | Engineer designs; tool checks & warns | ✅ `DesignValidationService`, `CDDASHBOARD` |
| L2 — Suggests | "This run should be DN150 @ 1:100 — apply?" (one element) | 🎯 Phase 0–1 |
| L3 — Designs a run | Fixed pits → auto-size + auto-level a run | 🎯 Phase 2 |
| L4 — Designs the network | Pits + outfall → route, size, level the whole network | 🎯 Phase 3–5 |
| L5 — Designs the project | Setup only → lay out, route, size, level, draw, schedule | 🎯 Phase 6 |

**Interaction model: propose-and-approve per stage.** Each stage is a discrete command the engineer
reviews and approves in AutoCAD before the next runs. This is both the safety model (engineer signs
off) and the build model (each stage ships standalone value).

---

## 2. Where the plugin stands today (audit, 2026-06-09)

**The good news — ~70% of the foundations already exist and are pure/reusable:**

- **8 hydraulic engines, math-only, headless-callable:** Rational Method (Q=C·I·A/0.36, with an
  embedded Melbourne ARR IFD table), Manning's full-bore pipe flow, orifice discharge, detention
  storage (with an embedded *inverse* orifice solver), Boyd's critical-duration sweep, pump wet-well,
  charged-system (Hazen-Williams). — `ViewModels/*Calc*.cs`, `Services/DesignValidationService.cs`
- **Ground-RL-anywhere already solved:** `SurveyService.TryGetRlAtPoint()` does barycentric TIN
  interpolation; `ReadSurveyDwg()` reads survey DWGs headlessly via ACadSharp.
- **Headless drawing already works:** `PipeCreationService.CreatePipeWithAnnotations(PipeCreationParams)`
  draws a pipe + all annotations from explicit parameters with no prompts; `BlockService.InsertBlock()`
  drops pits at given XY.
- **Propose-and-approve already wired:** drawing a pipe in CD already runs `ValidatePipe()` and shows
  warnings before commit. We extend this exact pattern.
- **Clean persistence:** `ProjectData` as JSON in the DWG NOD via `IProjectDataRepository` /
  `ProjectDataService` — headless-writable as-is.

**The missing 30% — specific and nameable:**

1. **Inverse solvers** — today the validator *checks* a chosen pipe; the engine must *pick* the
   diameter/grade/invert (inverse of `ComputeFullBoreVelocity`). One inverse already exists (orifice
   diameter in `DetentionDesignViewModel`), proving the pattern.
2. **Design-input fields** — `PitData`/`PipeData` lack catchment area, runoff coefficient C, design
   flow Q, ARI/AEP, outfall, council code, design-stage. Numerics are stored as strings.
3. **Standards layering** — `DesignStandards` is 6 flat global scalars in `UserSettings`; needs a
   layered, project-scoped, diameter-aware profile.
4. **Network routing** — no graph to trace flow from each pit to the outfall.
5. **Survey auto-discovery** — `CDSURVEY` is a manual pick; needs folder scanning + silent load.
6. **A few headless extracts** — `PlacePitCore` optional prompt, a `PlaceSourceBlockCore` for
   DP/IO/OF/FO/TG, and active-document context for annotation clash detection.

---

## 3. The phased roadmap (L2 → L5)

Effort key: **S/M/L/XL**. Every solver phase carries a **mandatory round-trip test** — the solver's
own output, fed back through the existing `DesignValidationService.ValidatePipe`, must return zero
warnings before the engineer can approve.

### Phase 0 — Standards profile + design-inputs foundation `L`  (L2)
**Command:** `CDPROFILE-SETUP` (new) · `CDS` (changed → becomes the "office defaults" layer)
**Engineer sees:** point at a project folder → plugin auto-discovers the survey and shows the
resolved rulebook with each number's source labelled (e.g. *min grade 1:300 [AS/NZS], cover 600mm
[council]*). Nothing drawn yet.
**Reuses:** `DesignValidationService`, `DesignStandards`, `SettingsService` JSON pattern,
`SurveyService.ReadSurveyDwg`, `ProjectDataService`.
**New build:** 3-layer `StandardsProfile` (see §4); diameter-aware rules; `DesignInputs` model on
`ProjectData` (catchment, C, ARI, outfall, `DesignStage`); survey auto-discovery; thread the profile
through every existing `ValidatePipe` caller.
**Ships:** every existing check becomes council-aware and project-scoped instead of one global setting.

### Phase 1 — Inverse pipe-sizing solver `L`  (L2) ← the hardest piece, but pure logic
**Command:** `CDSIZE` (new, proposal-only)
**Engineer sees:** select one pipe (or type Q + length + the two ground RLs) → plugin proposes
diameter + grade + inverts with a one-line-per-rule explanation (*"DN150 @ 1:100 → 1.1 m/s OK,
0.65 m cover OK, carries 18 vs 12 L/s OK"*). Accept → writes back to that pipe.
**Reuses:** `ComputeFullBoreVelocity`, `GetManningsN`, Manning capacity math, `StandardsProfile`,
`TryGetRlAtPoint`.
**New build:** `PipeSizingSolver` (AutoCAD-free, the inverse of the validator); `InvertFromSlope`
helper; structured feasibility-reason reporting.
**Ships:** a "size this pipe for me" button usable on every job today, zero drawing-automation risk.

### Phase 2 — Catchment delineation + design flow `M`  (L3)
**Command:** `CDCATCH` (new, stage-gated)
**Engineer sees:** plugin **auto-reads the surface polygons off the drawing** (building footprint = roof,
driveway = paving, lot − built = grass — from the Site Plan / Roof Plan / civil xref) → computes weighted
C, pulls minor/major-storm intensity, proposes design flow Q per inlet, as a reviewable table the engineer
confirms/edits.
**Tim's requirement (2026-06-09):** the surface auto-read must be **accuracy-proven on real jobs FIRST**
(measure auto-read areas vs the known impervious/pervious in each job's calc sheets; show an accuracy %)
and must always offer a **manual override**. See `feedback_prove_accuracy_before_auto`. Reads DWG geometry
headlessly via ACadSharp (already bundled — see `SurveyService.ReadSurveyDwg` + the X-Civil importer for
the pattern + office layer conventions).
**Reuses:** Rational Method core + IFD table, WSUD impervious/pervious weighting, `SlabData`/
`RaingardenData` polygons, `StandardsProfile`.
**New build:** `CatchmentModel`; extract Rational + IFD into a pure `RationalFlowService`; two-storm
(minor pipe / major overland) wiring; advance `DesignStage` to CATCHMENTS_APPROVED.
**Ships:** automatic areas, weighted C and design flows off the drawing — kills the most error-prone
manual step.

### Phase 3 — Pit layout + pipe routing `XL`  (L4) ← weakest automation link
**Commands:** `CDLAYOUT` + `CDROUTE` (new, two stage-gates)
**Engineer sees:** ghosted pit markers proposed at TIN low points / direction changes (respecting max
spacing + building-footprint avoidance), then ghosted pipe connectivity toward the outfall. Drag/
re-parent → graph re-solves. Nothing real until approved.
**Reuses:** `TryGetRlAtPoint`, `SlabData` footprints, `LinkService` graph, `BlockService.InsertBlock`
(on approval only), `StandardsProfile`, `DesignInputs` outfall.
**New build:** pit-placement heuristic; graph-based flow-routing solver (the routing gap);
ghost-preview rendering + approve-to-materialise; downstream cumulative-Q accumulation.
**Ships:** an auto-proposed, engineer-adjusted pit-and-pipe skeleton materialised on the drawing.

### Phase 4 — Invert/grade network levelling `L`  (L4)
**Command:** `CDLEVEL` (new) · `CDSIZE` (generalised single-pipe → network walk)
**Engineer sees:** from the known outfall invert, plugin sweeps upstream applying the Phase-1 solver
to every segment at its cumulative Q, sets diameters/grades/inverts, applies junction-drop rules, and
presents the whole network as a schedule + ghosted invert labels.
**Reuses:** `PipeSizingSolver` + `InvertFromSlope` (Phase 1 applied per segment), the route graph,
`ValidatePipe` (final whole-network re-validation), `StandardsProfile`, `TryGetRlAtPoint`.
**New build:** ordered upstream sweep with junction rules; cross-tree cover reconciliation;
whole-network feasibility report; min-total-drop preference.
**Ships:** approve a topology → get a fully levelled, sized, compliant network ready to draw (L4).

### Phase 5 — On-site detention (OSD) sizing `M`  (L4)
**Command:** `CDOSD` (new, stage-gated)
**Engineer sees:** plugin computes PSD (pre-dev Q or council fixed rate), sweeps durations (Boyd's)
for the critical site storage, proposes a detention store + an orifice sized to hold discharge to PSD.
**Reuses:** `DetentionDesignViewModel` (V + storage-pipe table + inverse orifice), `BoydsCalcViewModel`
sweep, `OrificeCalcViewModel`, `RationalFlowService`, `WaterTankCommand`/`RaingardenData`.
**New build:** pure `DetentionSizingService` (extract the three detention ViewModels); effective head
from the Phase-4 inverts (not the current hardcoded 450 mm); OSD-trigger waiver; tank/reuse credit.
**Ships:** a complete OSD design (volume, vessel, orifice, head, compliance) from the site's own data.

### Phase 6 — Draw + schedule output `XL`  (L5) ← the summit
**Command:** `CDBUILD` (new, final approve) · `PITSCHEDULE` (auto-populated) · optional
`CDAUTODESIGN` master driver
**Engineer sees:** the approved + levelled + detained design drawn for real — pits, pipes with grade/
velocity text, OSD element, downpipe/floor-waste inlets, overland-flow path — plus auto pit schedule
and longitudinal section. Final review on real geometry.
**Reuses:** `CreatePipeWithAnnotations`, `BlockService.InsertBlock`/`SetDynamicProperty`/`SetAttribute`,
`XcivilPitInsertionService` pattern, `TextService` autoPlace, `LinkService`, `PITSCHEDULE`,
`LongitudinalSectionViewModel`.
**New build:** design-to-geometry translator; `PlaceSourceBlockCore` extraction; overland-flow path
generator; auto-schedule population; idempotent re-run; active-document context guard.
**Ships:** setup → drawn, annotated, scheduled, compliant single-lot design. Loop closed.

---

## 4. Standards profile design (the spine)

A **three-layer resolved profile**, loaded once per project at Phase 0, threaded as an explicit
parameter into every design/validation call (replacing today's global `SettingsService.Current`
singleton). Highest priority wins:

1. **CouncilOverride** (top) — sparse per-council DCP bundle, JSON read from the auto-discovered
   project folder (e.g. `<council>.dcp.json`). Only the rules that council mandates differently
   (min grade, cover, PSD method, design ARI, OSD trigger, freeboard).
2. **Base** (middle) — hardcoded **AS/NZS 3500.3 + ARR/Melbourne Water** constants (⚠ *not QUDM* —
   the jobs are Victorian): diameter-aware min grades, self-cleansing velocity 0.6 m/s, max velocity
   by material, cover categories (trafficable / landscaped / under-slab), max run length, pit spacing
   by diameter, junction drop, orifice Co=0.61, Manning's n, runoff C by surface. Versioned with a
   standard+revision tag.
3. **OfficeFallback** (bottom) — the existing `UserSettings.DesignStandards` (the 6 scalars Tim
   already tunes). Fills gaps + house-style.

**Resolution:** `Resolve(ruleId)` walks Council → Base → Office and returns the value **with metadata**
(source layer, standard, revision, council, overridable). Every number the engine uses is traceable
for the design audit trail; `ValidationWarning` carries the same `rule_id`. Rules are **diameter- and
context-aware lookups**, not flat scalars. Project-scoped (persisted in DWG NOD), so two open jobs keep
their own councils. **The DCP JSON schema must be locked before any council file is authored.**

---

## 5. Learn-from-history workstream (feeds the profile)

Tim's ~1,900-job archive (`reference_project_archive` memory) is mined — **read-only, local, nothing
uploaded** — to do three jobs:

1. **Seed the profile** — extract real, date-stamped numbers (pipe sizes vs catchment, grades, cover,
   PSD/SSR/OSD volumes, orifice sizes, council) into the Base/Office layers and per-council overrides.
   This is *interpretable rule-mining*, not a black box — an engineer can read and sign off every value.
2. **Back-test the engine** — once `CDSIZE`/`CDLEVEL`/`CDOSD` exist, re-run them on old approved jobs
   and compare to what council actually signed off. Reproducing past designs = trust.
3. **Regression benchmark** — stop future code changes from degrading design quality.

**Standards drift is handled, not feared:** every mined record is tagged with year + council; weight
recent jobs, segment by era, and chart how requirements changed over time.

**Extraction strategy (evidence-based):** anchor on the `Civil\` folder (100% present), read the
standard calc spreadsheets for the design numbers, pull geometry from the `APPROVED` DWG (inferring
the model like the X-Civil importer for pre-plugin drawings), tag with year + suburb→council. Crawl
with ACadSharp headlessly; recurse builder-umbrella folders; skip admin folders.

---

## 6. Biggest risks (carried from the audit)

1. **Engineering liability** — the plugin crosses from checking to proposing. A wrong roughness,
   tie-break, or diameter-ladder off-by-one floods a real site. **Mitigation: mandatory round-trip
   re-validation on every solver phase — never approve a design that doesn't re-validate clean.**
2. **Rainfall intensity is location-specific** — only Melbourne IFD is embedded. The profile must
   force an explicit intensity source and always show which IFD is in use.
3. **Re-threading the standards profile** through every existing `ValidatePipe` caller risks
   regressing daily-use CD/PipeEdit/Dashboard paths — and sits next to the recurring DBText
   double-click regression. Keep `DesignValidationService` logic untouched; do not touch
   `CompoundEditModeService` source-tag handling.
4. **Routing + pit placement is the weakest automation link** — practical/aesthetic judgement the
   engine can't see. Hard propose-and-approve with ghost geometry; never auto-commit topology.
5. **Outfall RL is a single load-bearing input** for the whole upstream solve — validate against the
   survey, force confirmation, re-flag downstream as stale if it changes.
6. **Build-stage idempotency** — `CDBUILD` re-runs must not duplicate geometry; build in the active
   document context only.

---

## 7. Recommended first slice

**The smallest end-to-end vertical slice that proves "forward validator becomes forward designer" on
ONE pipe, with the layered profile underneath:** a minimal Phase 0 (resolution chain + diameter-aware
grade/cover + survey auto-discovery, no full DesignInputs UI yet) feeding Phase 1's `CDSIZE` on a
single pipe. High value ("size this pipe for me" on every job today), almost entirely pure logic
(unit-testable with the mandatory round-trip test), reuses verified cores, and exercises the full
propose-and-approve loop on the simplest element — proving the architecture before the XL routing/
levelling/build phases.

**Immediate next step (read-only, not a build):** a content-extraction proof-of-concept on ~5
fully-approved archive jobs — open their `APPROVED` civil DWG + OSD/PSD calc spreadsheets and show
exactly what numbers can be pulled automatically. This simultaneously proves the learn-from-history
idea AND produces the seed data for Phase 0's rule tables.

---

## 8. The CE Design Guidebook IS the auto-design recipe (added 2026-06-09)

The CE Civil & Drainage Design Guidebook v1.3 (`reference_design_guidebook` memory) is the
**human-readable algorithm** the auto-designer automates — not just background. Every roadmap phase
maps to a guidebook section:

| Guidebook section | Auto-design stage |
|---|---|
| §5 Workflow | The overall propose-and-approve stage sequence |
| §6.1 Understand requirements | Phase 0 setup (project type, council, site, LPD) |
| §6.2 Computations (Boyd's / OSD4W / council-provided) + §7 Table 1 | Phase 2 catchment/flow + the **standards profile** / council selector |
| §6.3 Schematic design / mark-up | **Phase 3 pit & pipe LAYOUT heuristics** (rules below) |
| §6.3.3 Orifice pit · §6.3.4 Water tanks · §6.4 Pump · §6.5 Soakage | Phase 5 OSD + the system-type branch |
| §6.6 Drafting (OSD criteria table, pit schedule, details) | Phase 6 draw + schedule |
| §7 Council summaries | Per-council standards-profile overrides |

**The §6.3 placement rules are the Phase-3 layout brain — already written office policy, not invented:**
- Detention located **close to the LPD**, usually at the **lowest point** of the site.
- **Avoid:** Tree Protection Zones (SRZ cannot be penetrated; TPZ only hydro-excavated under arborist
  supervision); neighbour footings near the boundary (deep excavation undermines them); existing sewer
  ties (keep 1 m offset); paved areas; courtyards/turntables; respect the architectural intent.
- **Placement:** min **1:100** fall for gravity pipes; adequate cover; pit size must suit the pipe size;
  proposed **overflow lower than every pit cover level**; **NO detention pipes under dwellings/garages**
  (exception: rear LPD → under decking).
- **Pit size → max depth:** 350²→450 · 450²→600 · 600²→900 · 600×900→1200 (step irons) · 900²→1200+.

These become the constraint set for the auto-layout solver — the heuristics are office policy, not guesswork.

**Shared catalogue:** the standards profile (Phase 0) and the CDCALC **council selector** read ONE
council-parameter catalogue sourced from guidebook §7 + the validated archive numbers (PSD ≈ 9 L/s per
1000 m², Co = 0.6, blended C ≈ 0.65). **CDCALC is the first, smaller consumer of that catalogue; the
full auto-designer is the second** — so the CDCALC council-profile work is also the auto-design Phase-0
foundation. See `docs/CDCALC_UPGRADE_PLAN.md`.

---

## 9. Key design constraints (Tim, 2026-06-09)

**Cover levels come from FINISHED levels, NOT the survey.** The feature surveys CE receives are done
*before* construction — they are EXISTING ground, **reference only**. Pit cover levels relate to the
**finished surface**: FFL (finished floor level), FSL, landscaping, paving/driveway levels — set by the
architect/civil design. The auto-designer must source pit covers from the **proposed finished levels**
(architectural FFL/landscape/paving plan), not the survey TIN (`SurveyService.TryGetRlAtPoint` is
context/reference only). Reading finished levels off the proposed plan is an AutoCAD-coupled Phase-3 task
and must be **accuracy-proven first** (`feedback_prove_accuracy_before_auto`). *(Corrects an earlier wrong
"cover comes off the survey" statement.)*

**Pit SIZE/TYPE is driven by the pipes — not placed blindly.** Select the pit from: (a) the largest
connecting **pipe diameter**, (b) the **number of pipe connections** at the pit, (c) the **pipe lengths →
depth** (cover − invert). Use the guidebook pit-size → max-depth table (350²→450 · 450²→600 · 600²→900 ·
600×900→1200 [step irons] · 900²→1200+) and the rule "the pit must accommodate the proposed pipe sizes".
Buildable as a pure `PitSelector` (feeds Phase 3 layout). See `reference_cover_and_pit_rules`.

**Pit PLACEMENT learns from the 1,900-job archive — not hand-written rules alone (Tim, 2026-06-09).**
Two INTERPRETABLE approaches (NOT a black box): **(1) Pattern mining** — extract the office's actual
placement patterns (pits near the LPD + at low corners; detention under driveway/paving, never under
buildings; typical spacing, pits-per-lot, downpipe→pit→outfall chains) → office-grounded heuristics.
**(2) Case-based templates** — for a new site, retrieve the most SIMILAR past job (lot size/shape, LPD
position, dwelling count) and start from its real approved layout, then adapt. Optimise within for
cost/constructability. Requires extracting pit+pipe GEOMETRY from the archive DWGs via ACadSharp — a bigger
data job than the calc-sheet parameter mining; **feasibility-prove first** (`feedback_prove_accuracy_before_auto`),
always propose-and-approve. This is the marquee payoff of learn-from-history applied to Phase 3 (the weakest
automation link) — placement becomes "logical & efficient" because it mirrors what's been approved 1,900 times.
