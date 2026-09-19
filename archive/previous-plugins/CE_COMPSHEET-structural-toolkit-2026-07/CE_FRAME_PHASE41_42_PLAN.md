# Phase 4 — CE Frame, Stages 4.1 + 4.2: analysis-core hardening + second-order (P-delta)

**Status: DRAFT — awaiting Tim's approval (decision queue §11). No engine code until approved.**
(Prepared 17 July 2026, Phase-4 Fable session. **This run covers 4.1 and 4.2 ONLY** — hard stop
after 4.2 per the kickoff; 4.3 (AS 4100 member design) is sketched in §12 for direction only and
is gated on Tim's Phase-0 app testing.)

In plain English: the app already has a 3D "Structure tab" that can analyse a frame the way
SPACE GASS does — you draw columns and beams, put loads on, and it works out the forces. Stage
4.1 is about **proving that engine gets the same answers as SPACE GASS** on real firm jobs, and
fixing the gaps we found in it. Stage 4.2 adds the **"second-order" analysis** — when a frame
leans sideways under load, the weight on top of the leaning columns pushes it further sideways;
first-pass analysis ignores that extra push, second-order analysis includes it. SPACE GASS always
runs portals this way, and the steel standard effectively requires it, so without it we can't
claim to replace SPACE GASS for portal frames.

---

## 1. Verified starting point (checked this session, 17 Jul 2026)

- **App builds clean** (`dotnet build` src project: 0 errors, verified this session).
- **The test suite currently does NOT compile** — `tests/CE_BEAM_DESIGNER.Tests/RcbFlexureTests.cs`
  references `RcbFlexure`/`SteelLayer`, which don't exist yet. That is the **parallel RCB Fable
  session mid-TDD-cycle** (failing test written, implementation pending — its Stage 0 `As3600.cs`
  IS present in src). Not our lane, not touched. Consequence: CE Frame cannot run `dotnet test`
  until the RCB session completes its red→green cycle (§13 risk R1).
- The frame engine files read end-to-end this session: `FrameAnalysisEngine.cs` (670 lines),
  `StiffnessMatrixBuilder.cs`, `CoordinateTransform.cs`, `LinearAlgebraSolver.cs`,
  `Models/Frame/*`, `FrameAnalysisTests.cs` (35 xUnit tests, closed-form based).
- Unit conversions in the stiffness builder verified dimensionally correct (E·A/1000 → kN,
  E·I/1e9 → kN·m²) — kN/m/MPa convention is consistent.
- What the engine already does correctly (keep, don't rewrite): 6-DOF direct stiffness, 12×12
  member matrices, static condensation for end releases, row/col-elimination supports,
  Cholesky-with-Gaussian-fallback solver, per-case analysis + AS/NZS 1170.0 combination
  superposition (Phase-0 data-driven set), equilibrium-verified reactions.
- **1,166 `.sg` files confirmed** under `Creative Engineering - Projects\` (search run this
  session). SPACE GASS templates confirmed at
  `Creative Engineering - Engineering\Spacegass Templates\` (incl.
  `Warehouse Portal Frames\35-42m Portal frame - Template.SG`).
- **Benchmark artefact goldmine found:** job `2020\20-110_31 Cairnes Grove, Bentleigh` has
  `PF1 PORTAL FRAME.SG` **plus printed SPACE GASS output PDFs per load case** (`PF1 G.pdf`,
  `PF1 Q.pdf`, `PF1 WIND.pdf`, `PF1 REACT.pdf`, `PF1 MOMENT.pdf`, `PF1 DEFL.pdf`,
  `PF1 ULTIMATE.pdf`). Read this session: SPACE GASS 12.25, a pinned-base residential portal
  (300 PFC columns / 250×150×9 RHS rafter), annotated values e.g. knee moments −12.16 kN·m and
  midspan +29.51 kN·m under (SW) G+Q, 14.94 mm sway under Wu. These annotations are usable
  spot-checks; the proper benchmark needs the tabular report export (§6.3).

## 2. Scope

### In scope — Stage 4.1 (analysis-core hardening)
| # | Capability | Basis |
|---|---|---|
| 1 | Analytical golden-value suite (closed-form portals, 3D checks) run against the engine **before any change** | textbook/Kleinlogel closed forms |
| 2 | Fix the §4 gap list: tension-only braces, per-combination analysis, shear deformation, self-weight, partial/trapezoidal loads, station forces both axes, model mutation, nodal-moment DOF defect, mechanism diagnostics | structural mechanics |
| 3 | SPACE GASS benchmark suite: 5 real firm frames, linear static, pre-declared tolerances | §6 benchmark set |
| 4 | Documented sign-convention + units reference for member forces (4.3 will consume this) | — |

### In scope — Stage 4.2 (second-order)
| # | Capability | Basis |
|---|---|---|
| 5 | True second-order (P-Δ + P-δ) analysis via geometric stiffness + internal member subdivision, iterative | §5 recommendation |
| 6 | Elastic critical load factor λc per combination (bisection on tangent-stiffness definiteness), reported + low-stability warning | AS 4100 Cl 4.4 context (clause text verified at build) |
| 7 | Combination policy: ULS analysed second-order as factored load sets (no superposition), SLS linear (configurable) | AS 4100 Cl 4.4; nonlinearity breaks superposition |
| 8 | Second-order validation: Euler columns, closed-form beam-columns, AISC-style benchmark cases, SPACE GASS second-order re-runs | §7 |
| 9 | Minimal UI surface: analysis-type selector, λc/convergence display, tension-only member flag — **no Frame3D visual regression** | — |

### Out of scope (documented, NOT in this run)
- **Stage 4.3 member design** (φMb/αc/Cl 8.3/8.4) — **hard stop before this**; gated on Tim's
  Phase-0 app testing (§12).
- Wind/seismic load generation (4.4), diaphragms/building assembly (4.5).
- Dynamic analysis, plates/shells, material non-linearity, large-displacement/catenary (our
  second-order = small-displacement with geometric stiffness — same class as SPACE GASS's
  standard second-order static).
- Warping torsion (St Venant GJ/L only — same simplification as SPACE GASS frame elements),
  spring supports and inclined supports (revisit only if a chosen benchmark model needs them —
  decision point in S7, §10 F7), support settlement.

## 3. What we build on

- `FrameAnalysisEngine.Analyse(model, loads)` — per-case linear solve, stays the core.
- `LoadCombination.StandardULS` — already delegates to the Phase-0 data-driven AS/NZS 1170.0
  set (`As1170LoadCombinations.Strength`); frame combination *names/factors* therefore inherit
  any Phase-0 fix automatically.
- `FrameAnalysisTests` — 35 closed-form xUnit tests; the golden-value style to extend.
- Structure tab / `Frame3D*` views — recently visually upgraded; treat as read-only surface,
  add only the §2-item-9 controls.

## 4. Engine gap list (each verified by reading the code this session; each becomes a TDD work item)

| # | Gap (file:line) | What it means in practice | Fix |
|---|---|---|---|
| G1 | Tension-only braces documented in the engine header (`FrameAnalysisEngine.cs:15`) but **no iteration exists in the body**; `Brace` type has no tension-only flag | A rod brace currently pushes as well as pulls — wrong forces in braced bays | `IsTensionOnly` on member; iterate: solve → deactivate compressed braces → re-solve until membership stable (cap ~20 iterations, oscillation guard) |
| G2 | `AnalyseAllCombinations` superposes case results (`FrameAnalysisEngine.cs:153-186`) | Valid only while everything is linear; wrong with tension-only members, meaningless for second-order | Add direct path: build factored load set per combination, analyse it as one case. Superposition retained only for pure-linear models (fast path) |
| G3 | No shear deformation (Euler-Bernoulli only) | SPACE GASS section-library members carry shear areas, so its deflections include shear deformation — a small systematic mismatch vs us, worst on stocky members | Timoshenko Φ-modified stiffness terms; optional `Ay_mm2`/`Az_mm2` on `FrameMember` (0 = rigid shear = current behaviour, so existing tests/files unaffected) |
| G4 | No member self-weight auto-load (`Weight_kgm` exists but unused) | Real .sg jobs include self-weight (BM1's case list literally shows "(SW) G+Q") | Opt-in auto UDL (Weight_kgm × g) into the G case, shown as its own labelled line |
| G5 | Member loads: full-length uniform UDL + single point only (`ComputeFixedEndForces`) | Wind pressures produce partial/trapezoidal line loads on columns/rafters | Add partial UDL (start/end fractions) + trapezoidal; closed-form FEMs, golden-tested |
| G6 | Station forces only in-plane (N, Vy, Mz); `ComputeIntermediateForces` (`FrameAnalysisEngine.cs:454-528`) contains a dead first computation that is then overwritten, and no Vz/My stations exist | Bending diagrams about the weak axis (out-of-plane wind on columns) simply don't exist; the in-plane values need verification; 4.3 needs both-axis M* along members | Rewrite station extraction cleanly from end forces + statics for BOTH axes; golden tests vs closed form at every station |
| G7 | Engine mutates its input: `UpdateMemberLengths` + `ApplyTrussReleases` write into the model (`FrameAnalysisEngine.cs:45-47`, `FrameModel.cs:53-60`); truss releases are **permanent** — a member switched from Truss back to Beam silently keeps pinned ends | Hidden state corruption + violates the firm immutability rule | Compute lengths/effective releases per-analysis without writing to the model |
| G8 | Nodal **moment** loads with a `Local*` direction land on the wrong DOF: direction maps to 3/4/5 then `+= 3` again → e.g. LocalX moment writes to offset 6 = the **next node's Ux** (`FrameAnalysisEngine.cs:204-218`) | Latent wrong-answer defect (UI may only offer Global today, but the API path exists) | Fix mapping + regression test for every direction/type combination |
| G9 | Singular matrix → one generic "check for mechanisms" message | A modelling mistake gives no clue which node/DOF is loose | Zero-pivot diagnostics naming node + DOF ("Node N7 Rz unrestrained — add support or fix a release chain") |
| G10 | Dense solver O(n³) | Fine for portal scale (≲ 300 DOF solves in ms); would crawl on `Building.SG`-scale models | Document limit + friendly node-count warning; banded/skyline solver deferred until a real need |
| G11 | **(found by S0, 2026-07-17)** Members with end releases carrying member loads use un-condensed fixed-end forces — the load vector is not condensed with the stiffness | A pinned-end rafter under UDL gets simply-supported reactions instead of the correct release-consistent distribution (propped-cantilever test: 30/30 vs 37.5/22.5) | Condense the FEM vector alongside K (fem_r − Krc·Kcc⁻¹·fem_c) and use the same in force recovery — S2 |
| G12 | **(found by S0, 2026-07-17 — most serious)** `CoordinateTransform.BuildRotationMatrix` builds a **left-handed** local triad for vertical members pointing UP (x=(0,1,0), y=(1,0,0), z=(0,0,+1) → x×y = −z, det R = −1); downward + inclined members are right-handed | Under sway load the vertical base-reaction couple flips sign and the engine's reaction set **violates global moment equilibrium** (measured ΣMz residual = −80 on a 40 kN·m overturning case — resisting couple became aggravating). Every portal with base→top columns is affected; symmetric gravity cases hide it | Fix the vertical special case to a right-handed triad (z = x×y = −global Z for both up and down members); check Frame3D drawing + column Iy/Iz orientation assumptions for convention dependence — S1 |

House rule reminder baked into every item: **if a benchmark disagrees with the mechanics, the
mechanics win** — two legacy CE artefacts have already been proven unconservative
(`docs/E11_ENGINEER_NOTE.md`); nothing gets "tuned to match".

## 5. The 4.2 decision: true second-order vs AS 4100 Cl 4.4 moment amplification

**Recommendation: implement TRUE second-order analysis (geometric stiffness, iterative), not the
Cl 4.4 δb/δs moment-amplification method, as the engine's analysis. Reasons:**

1. **The amplification method is the hand-calculation workaround, with applicability limits.**
   AS 4100 Cl 4.4 permits moment amplification as an *alternative* to second-order analysis, and
   cuts off when amplification grows too large (commonly cited δ > 1.4 → second-order analysis
   required — **exact clause text to be verified against the firm's AS4100-2020.pdf at build**,
   per the house rule). A tool that silently switches methods at a threshold is fragile;
   second-order analysis is valid across our whole scope.
2. **δb/δs classification is genuinely ambiguous for portals.** The method wants members sorted
   into "braced" and "sway", with λc for the sway amplifier — for a gable portal with inclined
   rafters this classification is the classic pain point. True second-order sidesteps it.
3. **Benchmark alignment.** SPACE GASS portal runs at the firm are second-order static analyses.
   Matching their numbers within tight tolerance requires the same analysis class.
4. **We need the buckling machinery anyway.** The amplifier's δs needs λc (elastic buckling load
   factor), which needs stability analysis regardless. We compute λc as a by-product and report
   it as a frame-stability health number.
5. **Cost is modest.** Standard 12×12 consistent geometric stiffness Kg(N) per member assembled
   from member axial force; iterate (K_e + Kg)·D = F, typically 2–5 cycles for well-behaved
   frames. Builds directly on the existing assembly/solve pipeline.
6. **4.3 plugs in cleanly.** Member design consumes M*, N* straight from a second-order
   analysis — no amplification bookkeeping in the design layer.

Cl 4.4 amplification is NOT implemented in this run; a hand-computed amplification cross-check
appears in the 4.2 validation suite (§7 V4) as a reasonableness band, which also documents the
relationship for the reviewing engineer.

**Mechanics of the implementation:**
- **P-Δ (storey sway)** is captured by Kg at the nodes. **P-δ (curvature between nodes)** needs
  intermediate nodes: each member is **auto-subdivided internally** (default 4 sub-elements,
  configurable) into analysis-only elements, invisible to the user; results are mapped back to
  the user's member (stations, end forces). Subdivision adequacy is *proven* in tests: pinned
  Euler column λc error vs sub-element count (1 element ≈ +21%, 2 ≈ +0.8%, 4 ≈ +0.05% — the
  test asserts the convergence table).
- **Iteration**: linear solve → member axial forces N → assemble Kg(N) → re-solve → repeat until
  max nodal displacement change < 1e-4 relative (and axial change < 1e-3), cap 20 iterations.
- **Instability**: non-positive-definite tangent or diverging displacements → clean result
  ("combination 1.2G+1.5Q: frame elastically unstable, λc ≈ 0.8 — increase member sizes or add
  bracing"), never a crash, never a silent wrong answer.
- **λc per combination**: bisection on the load factor at which (K_e + λ·Kg(N₁)) loses positive
  definiteness (Cholesky failure as the detector — the solver already reports it), N₁ from the
  first-order axial distribution. Linearised-buckling estimate; reported to 2 s.f. with a
  low-stability warning threshold (§10 F5).
- **Superposition is off** for second-order: every ULS combination analysed directly as a
  factored load set (depends on G2). SLS default linear (§10 F4).
- New result metadata: analysis type, iteration count, λc, and per-member second-order/first-
  order moment ratio (an engineer-friendly "how much did P-delta matter here" number).

## 6. Benchmark set + data-collection procedure (Stage 4.1, linear; re-used in 4.2)

### 6.1 Proposed frames (final pick = engineer/Tim confirm, §10 F1)
| ID | Model | Why this one |
|---|---|---|
| BM1 | `2020\20-110_...Bentleigh\...\PF1 PORTAL FRAME.SG` | Residential pinned-base PFC/RHS portal; **already has per-case SPACE GASS output PDFs** in the comps folder (secondary spot-checks in hand) |
| BM2 | `Spacegass Templates\Warehouse Portal Frames\35-42m Portal frame - Template.SG` | The firm's warehouse UB portal template — the archetypal SPACE GASS use case |
| BM3 | `2020\20-108_...Brooklyn\...\R1 PORTAL FRAME.SG` | Commercial job portal |
| BM4 | `2024\24-134_...Brighton\...\upper portal.SG` (+ `lower portal.SG`) | Recent (2024) practice, current SPACE GASS version |
| BM5 | A braced bay with tension-only rods — engineer to nominate (none identifiable by filename) | Exercises G1 tension-only iteration. Fallback: add rod bracing to BM2 in SPACE GASS and export both states |

Spare: `2020\20-113_...Armadale\...\RB2 PORTAL FRAME.SG`.

### 6.2 Pre-declared tolerances (agreed BEFORE comparison — no post-hoc loosening)
| Comparison | Tolerance |
|---|---|
| Internal equilibrium (every analysis, every test) | ΣReactions = ΣApplied within 1e-6 relative |
| Engine vs closed form (analytical goldens) | 1e-6 relative (the cubic element is exact for these cases) |
| Engine vs SPACE GASS **linear**: reactions + member end forces | ≤ 0.5 % |
| Engine vs SPACE GASS **linear**: node displacements | ≤ 1 % or 0.1 mm, whichever greater (settings matched — esp. shear deformation §4 G3) |
| Engine vs SPACE GASS **second-order**: forces / displacements | ≤ 2 % / ≤ 3 % (different iteration schemes) |
| Engine vs BM1's existing annotated diagram PDFs | ≤ 1 % of annotated value |

Any residual outside tolerance = investigation with a written finding (standard/mechanics wins;
difference documented, never fitted).

### 6.3 What Tim (or a nominated engineer) does — once, ~10 min per model
For each chosen model, in SPACE GASS: open the `.sg` → note version → run **linear static** →
export/print the tabular report (node displacements, support reactions, member end forces, for
each primitive load case G/Q/Wu/…) → save as PDF/text into `CE_COMPSHEET\benchmarks\<job>\` →
re-run as **second-order static** for the ULS combinations → export the same tables → also
record the analysis settings page (shear deformation on/off, self-weight case, section list).
A click-by-click cheat sheet will be written when the plan is approved (T2). Claude then
transcribes the tables into test data (JSON, with a provenance header naming file/date/version)
— the same pattern as the RCB plan's Inducta benchmark.

## 7. Test plan

**TDD throughout** — failing golden test → code → green; hand calc in the test comment
(`SteelCapacityGoldenValueTests` pattern). All frame tests stay in `FrameAnalysisTests`-adjacent
new files (`Frame*Tests.cs`), mirroring src structure.

**Stage 4.1 suites:**
1. `FrameClosedFormGoldenTests` — run against the UNCHANGED engine first (characterisation):
   pinned/fixed-base portal under UDL + lateral (Kleinlogel/textbook closed forms — firm library
   `Steel Framing\Portal Frames`), 3D grid with torsion coupling, inclined-member transformation,
   station-force values at quarter points, sign-convention pinning tests. Expected to expose G6/G8.
2. `FrameLoadingTests` — partial/trapezoidal FEM goldens, self-weight, nodal moment mapping (G8).
3. `FrameTensionOnlyTests` — braced frame: compression rod sheds to zero, tension rod carries;
   iteration terminates; oscillation guard; per-combination path equals superposition for a
   pure-linear model (G2 consistency proof).
4. `FrameShearDeformationTests` — Timoshenko vs Euler-Bernoulli closed forms; Ay=0 reproduces
   current results exactly (backward compatibility).
5. `SpaceGassBenchmarkTests` — the §6 suite, tolerance-asserted, data-driven from the
   transcription JSONs.

**Stage 4.2 suites:**
- V1 `FrameBucklingTests` — Euler columns (pin-pin, cantilever, fixed-fixed): λc vs
  π²EI/(kL)² including the subdivision convergence table.
- V2/V3 `FrameSecondOrderGoldenTests` — closed-form beam-columns: cantilever with axial + tip
  lateral, SS beam-column with axial + UDL (exact tan/secant amplification solutions — the same
  problems published as the industry-standard AISC benchmark Cases 1/2; we derive exact targets
  from the closed forms and cite both).
- V4 amplification sanity: sway portal second-order moments vs 1/(1−1/λc)-amplified first-order
  (documented ±5 % band — a cross-method reasonableness check, not a fit).
- V5 `SpaceGassSecondOrderBenchmarkTests` — §6 frames re-run second-order in SPACE GASS.
- Negatives: load above critical → clean instability report; axial TENSION stiffens the member
  (sign test); non-convergence surfaces as a named error, never a silent partial answer.

**Regression:** the full existing suite stays green after every stage (blocked today by R1 —
see §13; gate applies from the moment the suite compiles again). `.cebeam` round-trip tests for
every new field (old files load with safe defaults).

## 8. Integration surface (deliberately tiny in this run)

| File | Change |
|---|---|
| `Models/Frame/FrameMember.cs` | `Ay_mm2`, `Az_mm2`, `IsTensionOnly` (Brace), optional per-member subdivision override |
| `Models/Frame/FrameModel.cs` | analysis settings (type, self-weight on/off, SLS policy); no more mutation-by-engine |
| `Services/Calculation/Frame/` | new `GeometricStiffnessBuilder.cs`, `SecondOrderAnalysisEngine.cs`, `FrameStationForces.cs` (G6 rewrite), `FrameSubdivider.cs` — each < 800 lines, engine files stay focused |
| `ViewModels/FrameModelViewModel.cs` | analysis-type selector, λc/convergence/iteration display, tension-only checkbox |
| Structure tab XAML | the above controls only — **Frame3D visuals untouched** |
| `.cebeam` serialization | new optional fields, default-safe (round-trip tested) |

## 9. Deliverables checklist (per house rules)

- Code + tests per §7, every stage TDD.
- `REGRESSION_LOG.md` entry per stage with a plain-English "what Tim should test in the app"
  checklist.
- `docs/VALIDATION_PACK.md` gains a **"CE Frame — analysis engine (Stages 4.1/4.2)"** section at
  the end of the run: worked examples (one portal hand calc, one buckling, one P-delta), the
  SPACE GASS comparison table, limitations, sign-off box + the §10 questions — same format as
  the existing pack.
- Final report to Tim: results, what 4.3 needs from his Phase-0 testing (§12), then **STOP**.

## 10. Open engineering questions (for the firm engineer — pre-answered with safe defaults)

| # | Question | Default until answered |
|---|---|---|
| F1 | Confirm/replace the §6.1 benchmark set — are BM1–BM4 representative of the portal work you'd trust as a yardstick, and which braced-bay job should be BM5? | Use BM1–BM4 as listed; BM5 fallback = rod-braced variant of BM2 |
| F2 | Shear deformation: include when section shear areas are known (matches SPACE GASS), rigid otherwise? | Yes — Ay/Az used when present, 0 = rigid (deflections slightly conservative either way at portal proportions) |
| F3 | Self-weight: auto-include as a labelled G line per member? | ON by default, printed in the load list (matches firm SPACE GASS practice, e.g. BM1's "(SW)" cases) |
| F4 | Analysis policy: ULS combinations second-order, SLS linear? | Yes (matches common practice + SPACE GASS portal workflow); both configurable, choice printed on output |
| F5 | λc warning threshold: warn when the elastic buckling load factor of any ULS combination is low. AS 4100 Cl 4.4's second-order-required threshold (believed δ > 1.4 territory) to be verified verbatim at build | Warn at λc < 3.5, hard "unstable" report at λc ≤ 1.0; thresholds data-driven, clause-tagged |
| F6 | Notional horizontal forces (AS 4100 Cl 3.2.4, 0.002 × vertical — applicability to single-storey portals vs multistorey to be verified verbatim at build): auto-generate as an optional load feature? | Implement as opt-in auto-load, OFF for single-storey portals until the engineer rules; clause text verified at build |
| F7 | Spring/inclined supports: none of the engine today; include only if a chosen benchmark model uses them? | Defer unless a benchmark needs them (decision lands in S7) |
| F8 | SLS sway/deflection limits for portals (e.g. eaves height/150, rafter span/limits — firm policy?) | Report deflections WITHOUT pass/fail against limits in this run; limits become a 4.3+ question |
| F9 | E = 200 000 MPa, G = 80 000 MPa per AS 4100 Cl 2.2.4 as the fixed steel elastic constants? | Yes (already the engine defaults; printed on output) |
| F10 | Tolerances in §6.2 acceptable as the acceptance criteria for "analysis engine validated"? | As tabled |

## 11. Decision queue — Tim must answer before build starts

| # | Decision |
|---|---|
| T1 | Approve this plan + build order (§14), including the true-second-order recommendation (§5) |
| T2 | Benchmark exports (§6.3): will you do the SPACE GASS report exports with the cheat sheet, or nominate a firm engineer? (~10 min per model, 5–6 models; needs a machine with SPACE GASS) |
| T3 | OK to auto-subdivide members internally for second-order (invisible analysis nodes, default 4 — proven by the convergence test)? |
| T4 | UI scope confirm: only the §8 additions this run; Structure-tab 3D visuals untouched |
| T5 | Coordination: the test suite is currently RED from the parallel RCB session's in-progress TDD cycle (§1). Please have that session finish its red→green cycle (or park its test file) — CE Frame build cannot start its TDD loop until `dotnet test` compiles. Also see R1: this workspace has **no git** — strongly recommend `git init` + a first commit before two sessions keep editing one tree |

## 12. What Stage 4.3 will need from Tim's Phase-0 testing (the gate after this run)

4.3 (member design) builds directly on Phase-0 work that is code-complete but **untested by Tim
in the app** (every `REGRESSION_LOG.md` entry: AWAITING TIM'S TEST). Before 4.3 can start, Tim's
in-app testing must confirm, as a minimum:
1. **PHASE0-A1** — the AS/NZS 1170.0 combination engine + governing-combination labels + the
   0.9G + Wu uplift envelope (4.3 designs members against these envelopes).
2. **PHASE0-A3/A4** — the steel φMb capacity tables (ASI DCT golden-validated) and the φVv web
   shear check (4.3 reuses both verbatim).
3. Steel **section library properties** (A, Iy, Iz, J, Z) — frame members already consume these;
   4.3 trusts them for capacity.
Sketch of 4.3 itself (direction only, NOT designed in this run): per-member Ns/Ms section
capacity, Cl 6 compression (αc, λn, kf), Cl 5 moment (reusing validated φMb + αm), Cl 8.3/8.4
combined actions in/out-of-plane, Cl 4.6/5.6.3 effective lengths, one-click check/auto-size —
consuming N*, M*, stations straight from the 4.2 second-order results.

## 13. Risks / watch-outs

- **R1 — shared working tree, no version control.** Two Fable sessions (RCB + CE Frame) edit one
  un-versioned tree; the suite is red from the RCB session's mid-cycle test right now. One bad
  overwrite is unrecoverable. Mitigation: T5 (git init + finish/park the red cycle); lanes are
  file-disjoint (Frame vs Concrete) except `FrameModelViewModel`/XAML seams, which RCB doesn't
  touch.
- **R2 — benchmark availability.** If SPACE GASS exports stall (license/machine access), 4.1
  proceeds on the analytical suite + BM1's existing PDFs, and the SPACE GASS comparison lands
  when exports arrive — validation isn't skipped, only re-ordered.
- **R3 — settings mismatch masquerading as error.** Shear deformation, self-weight case
  membership and section property sources must be recorded per benchmark run (§6.3) or deltas
  are meaningless.
- **R4 — Frame3D regression.** The scene builder is a 1,027-line god file; we add UI beside it,
  not inside it.
- **R5 — file-format compatibility.** Every new model field optional with safe default;
  round-trip tests mandatory (existing `.cebeam` files must load unchanged).
- **R6 — solver scale.** Subdivision ×4 multiplies DOFs; portal scale stays trivial, but the
  node-count guard (G10) protects against someone loading a building-scale model.

## 14. Build order (each stage: failing tests → code → green → REGRESSION_LOG entry)

| Stage | Deliverable | Key tests |
|---|---|---|
| S0 | Closed-form characterisation suite vs UNCHANGED engine; sign-convention doc | `FrameClosedFormGoldenTests` (expected to expose G6/G8) |
| S1 | G7 immutability + truss-release fix | truss→beam round-trip keeps user releases; results unchanged elsewhere |
| S2 | G6 station-force rewrite, both axes + G11 release-consistent equivalent loads | station goldens at 21 points, both axes; propped-cantilever-via-release golden |
| S3 | G8 nodal-moment mapping fix + G9 mechanism diagnostics | direction/type matrix; named-DOF singularity messages |
| S4 | G3 shear deformation (Ay/Az, default rigid) | Timoshenko goldens; Ay=0 byte-identical to current |
| S5 | G4 self-weight + G5 partial/trapezoidal loads | FEM goldens; labelled G line |
| S6 | G1 tension-only + G2 per-combination direct path | `FrameTensionOnlyTests`; linear-model equivalence proof |
| S7 | SPACE GASS linear benchmark harness + transcriptions (needs T2 exports) | `SpaceGassBenchmarkTests` within §6.2 tolerances → **4.1 exit** |
| S8 | Geometric stiffness + subdivision + λc bisection | `FrameBucklingTests` convergence table |
| S9 | Iterative second-order solve + instability handling + result metadata | `FrameSecondOrderGoldenTests` (closed forms, AISC-style cases) |
| S10 | Combination policy + minimal UI + serialization | round-trip; UI smoke; V4 amplification sanity |
| S11 | SPACE GASS second-order benchmarks + VALIDATION_PACK §CE Frame + log sweep | `SpaceGassSecondOrderBenchmarkTests` → **4.2 exit → HARD STOP, report to Tim** |

Shape: S0–S6 are pure engine work (engineering risk front-loaded, no SPACE GASS dependency);
S7 needs Tim's exports (T2) and can slide later in the order without blocking S8–S9; S10–S11
close out. Nothing merges red; every stage independently shippable to the test suite.
