# REGRESSION LOG — CE Beam Designer / CE Structural Toolkit

One entry per change. Never mark an entry CONFIRMED until Tim has verified it in the app.

---

### CEFRAME-S9 — TRUE SECOND-ORDER (P-delta) ANALYSIS — the SPACE GASS replacement core (2026-07-17)
- **Status: ENGINE-ONLY (UI wiring is S10) — the headline capability of Phase 4.2**
- **Symptom (gap):** the engine could only do first-order analysis: when a loaded frame
  leans, the axial loads acting through that lean create EXTRA moments (P-delta) that
  first-order analysis ignores. SPACE GASS always runs portals second-order and AS 4100
  effectively requires it — this stage is the reason Phase 4 exists.
- **Fix:** new `SecondOrderAnalysisEngine` (`Analyse` + `AnalyseCombination`): members
  internally subdivided (S8), then iterate solve → member axial forces → tangent
  stiffness Ke + Kg(N) → re-solve until the axial distribution settles (tolerance
  max(1e-3 kN, 1e-4 relative), cap 30 with a named near-instability error). Results are
  mapped back to the user's model — displacements, reactions, per-member end forces AND
  21-station diagrams that show the P-δ moment growth between nodes (station arrays are
  ramp-corrected to the tangent-exact end forces; the residual is second-order small at
  ≥4 subdivisions). Results carry `SecondOrderIterations` and `ElasticCriticalLoadFactor`
  (λc). **Safety gate:** λc ≤ 1 (loads beyond elastic buckling) is ALWAYS reported as
  UNSTABLE with λc in the message — never as a numeric result, even though the indefinite
  tangent can technically still be solved.
- **Test:** `FrameSecondOrderTests` vs the EXACT beam-column closed forms (Timoshenko &
  Gere — the solutions behind the industry-standard AISC benchmark cases):
  cantilever δ = H/(Pk)(tan kL − kL) and M = (H/k)tan kL at P/Pcr = 0.36 (1.56×
  amplification) within 0.2 %; SS beam-column M_mid = (w/k²)(sec u − 1) = 71.6 kN·m
  (linear 45) and δ = 26.6 mm (linear 16.9) within 0.5 %; axial TENSION stiffens below
  linear; P > Pcr refuses with λc ≈ 0.914 named; negligible axial = linear to 1e-6;
  tension-only braced panel through the combination path composes (slack warnings
  survive). Full suite **701 passed / 0 failed**.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:** nothing yet — S10 adds the analysis-type selector
  and results display. The engine capability is complete and validated.
- **Still at risk:** λc is the linearised estimate (standard practice, stated for the
  validation pack); UI policy (ULS second-order / SLS linear default, λc warning
  thresholds F5) lands in S10; SPACE GASS second-order benchmark comparison is S11
  (needs Tim's exports).

### CEFRAME-S8 — Second-order foundations: geometric stiffness, internal subdivision, elastic buckling factor λc (2026-07-17)
- **Status: ENGINE-ONLY (nothing visible in the app until S9/S10 wire the second-order
  analysis and results display)**
- **Symptom (gap):** Phase 4.2 begins. The engine had no concept of geometric
  (load-dependent) stiffness, so it could not do second-order analysis or tell how far a
  frame is from elastic instability — the core of what SPACE GASS does for portals.
- **Fix (three new files under `Services/Calculation/Frame/`):**
  - `GeometricStiffnessBuilder` — standard consistent 12×12 geometric matrix Kg(N):
    compression softens transverse stiffness, tension stiffens. Flexural buckling only
    (member lateral-torsional buckling stays a 4.3 design check via φMb, as planned).
  - `FrameSubdivider` — invisibly splits each member into sub-elements (default 4,
    T3-approved) so buckling BETWEEN the user's nodes (P-δ) is captured; loads re-mapped
    per segment, releases land on the outermost sub-ends, truss/tension-only members not
    subdivided. The user's model is never modified.
  - `FrameBuckling` — the elastic critical load factor λc by bisection on the tangent
    stiffness losing positive definiteness (new `LinearAlgebraSolver.IsPositiveDefinite`).
    λc answers "by what factor would the loads have to grow before the frame elastically
    buckles" — the plan's frame-stability health number (warn thresholds land in S10).
- **Test:** `FrameBucklingTests` vs Euler closed forms Pcr = π²EI/(kL)²:
  the pinned column CONVERGENCE TABLE (1 sub-element +21.6 %, 2 ≈ +0.75 %, 4 < 0.1 % —
  proving the default), weak axis governs when both planes are pin-held (validates the
  out-of-plane Kg block), fixed-free = Euler/4, fixed-fixed = 4×Euler, tension never
  buckles (clean null), portal sway factor positive + monotone with column stiffness.
  Full suite **695 passed / 0 failed**.
  A first-cut lesson worth recording: for a VERTICAL member, twist is global Ry and
  global Rx clamps weak-axis bending — the test supports originally had these swapped
  and produced honest mechanisms/mode-mixups, all explained and fixed in comments.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:** nothing yet — no user-visible surface until S9/S10.
- **Still at risk:** λc uses the linearised (first-order axial) distribution — standard
  practice, stated in the validation pack; Kg is Bernoulli (no shear-flexible Kg
  refinement) — inside benchmark tolerance, documented.

### CEFRAME-S6 — Tension-only bracing works (G1) + combinations analysed directly (G2) (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom:** (1) G1 — the engine's own header advertised tension-only bracing but none
  existed: a rod brace resisted compression like a strut, so braced-bay forces were wrong.
  (2) G2 — combination results were built by adding up scaled per-case results, which is
  invalid once anything nonlinear (tension-only) exists, and could never produce
  moment/shear DIAGRAMS for combinations (end values only).
- **Fix:** (1) `FrameMember.IsTensionOnly` + iteration: solve → members that came out
  shortened go slack → re-solve until the set settles (cap 20 with a named error).
  Slack members keep a deliberate 1e-8 residual stiffness rather than full removal — a
  gravity-only X-braced panel is then correctly "no sway, braces at zero force" instead of
  a spurious instability. Slack members report exact zeros + a warning naming them.
  (2) `AnalyseCombination(model, combo)` analyses each combination DIRECTLY as a factored
  load set (self-weight scales with the G factor; loads cloned, never mutated);
  `AnalyseAllCombinations` uses it for every combination; the superposition code is
  deleted. Combinations now carry full station arrays for the first time.
- **Test:** `FrameTensionOnlyTests` — X-braced pin-jointed panel: sway right (taut diagonal
  +12.5 kN = P·5/4 by hand statics, slack one exactly zero + warning), sway left (roles
  swap — proves re-activation), two-way baseline with the **flexibility-method indeterminate
  split** (+5.1630/−7.3370 kN — engine matched the hand calc to 8 digits), direct-combination
  = factored case sums for linear models WITH real station arrays, `0.9G + Wu` on the braced
  panel equals a manually pre-factored load set, self-weight × 1.35G. Full suite
  **687 passed / 0 failed**.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Structure tab: X-braced panel (two crossed diagonals set to Truss), tick "tension
     only" on both when the UI exposes it (S10) — until then this is engine-level only.
  2. What you CAN check tonight: combination results in the results panel now show full
     moment/shear diagrams (previously combinations had end values only — diagrams were
     blank or per-case only).
  3. Everything else must analyse identically to the previous build (no tension-only
     members exist in old models — the flag defaults off).
- **Still at risk:** UI checkbox for tension-only + combination-picker refresh are S10;
  a slack-brace warning currently lives in the results Warnings list, which the UI may not
  display yet (S10 exposes it).

### CEFRAME-S5 — Self-weight (G4), partial/trapezoidal loads (G5), per-case member forces fixed (G14) (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom:** (1) G4 — the frame never included member self-weight; real SPACE GASS jobs
  do (BM1's case list shows "(SW)"). (2) G5 — only full-length uniform line loads existed;
  wind pressure zones need partial-length and trapezoidal loads. (3) **G14 (found this
  stage):** a member carrying loads in MORE THAN ONE load case (say a G load and a Q load)
  got member forces and diagrams computed against ALL its loads at once, whatever case was
  being analysed — the per-case member shear/moment diagrams were polluted by the other
  cases (support reactions were correct, which hid it; combinations then double-counted
  through superposition).
- **Root cause:** (3) force extraction read `model.Loads` (all cases) instead of the
  analysed case's load list.
- **Fix:** (1) `FrameModel.IncludeSelfWeight` — when on, each member's Weight_kgm becomes a
  G-case line load (w = kg/m × 9.80665/1000), generated at analysis time, never written
  into the model's load list. **Default OFF until the Structure tab exposes the toggle
  (S10)** so saved models keep bit-identical results while Tim is mid-testing; the firm
  default for new models becomes ON when the UI lands (plan F3). (2) `FrameLoad` gains
  `StartPosition_fraction`/`EndPosition_fraction`/`EndMagnitude` (defaults = the old
  full-length uniform); fixed-end forces by 3-point Gauss integration of the exact
  point-load kernels (mathematically exact for linear intensity — no long closed forms to
  mistranscribe); station arrays extended with the matching segment integrals.
  (3) the analysed load list (case-filtered + synthetic self-weight) flows through to
  member-force extraction.
- **Test:** `FramePartialLoadTests` — half-span UDL on SS beam (22.5/7.5 + stations);
  half-span UDL on fixed-fixed beam vs kernel-integral hand calc (13wL/32, 11wL²/192…);
  triangular load (R_A = total/3, midspan 27); default-UDL backward-compat pin;
  self-weight opt-in/off-by-default/G-only/no-mutation; **G14 per-case member forces**
  (G 30 kN vs Q 15 kN shear on the same member); partial trapezoid crossing a
  double-pinned member (8.5/9.5). Full suite 681 passed / 0 failed.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Nothing new is VISIBLE yet — self-weight has no checkbox and partial loads have no
     input fields until S10. What matters tonight: existing models must analyse
     identically to the previous build (all defaults preserve old behaviour).
  2. One behaviour DID change (the G14 fix): if a member carries BOTH a dead (G) and a
     live (Q) load, the per-case moment/shear DIAGRAMS for that member are now smaller
     than the previous build showed (each case now shows only its own loads). The
     combination envelope totals are what they always should have been.
- **Still at risk:** UI wiring for self-weight + partial loads is S10's job; the 3D load
  glyphs don't draw partial extents yet (cosmetic, S10).

### CEFRAME-S4 — Frame members can now deform in shear (Timoshenko), matching SPACE GASS practice (2026-07-17)
- **Status: AWAITING TIM'S TEST (near-invisible until members carry shear areas)**
- **Symptom (gap):** the frame engine treated every member as rigid in shear
  (Euler-Bernoulli bending only). SPACE GASS models built from its section library carry
  shear areas, so its deflections include shear deformation — a small systematic mismatch
  (worst on short, deep members) that would poison the S7 benchmark comparison.
- **Fix:** `FrameMember` gains `Ay_mm2`/`Az_mm2` shear areas (default **0 = rigid in shear
  = exactly the old behaviour**, so existing models, files and results are untouched);
  `StiffnessMatrixBuilder` uses the standard shear-deformable (Timoshenko) element terms
  Φ = 12EI/(G·As·L²). Known, documented limitation: fixed-end forces for member POINT loads
  remain the rigid-shear formulas (UDL fixed-end forces are exact by symmetry either way);
  revisit only if S7 benchmark deltas on point-loaded members exceed tolerance.
- **Test:** `FrameShearDeformationTests` — Ay=0 matrix identical to Euler; huge-Ay converges
  to Euler; cantilever δ = PL³/3EI + PL/GAs; SS midspan δ = PL³/48EI + PL/4GAs;
  fixed-fixed UDL end moments unchanged (wL²/12); propped-cantilever **indeterminate
  redistribution** with shear flexibility matches a full flexibility-method hand calc
  (R_B = 22.556, M_A = 37.22 — derivation in the test comment); serialization round-trip +
  legacy-file default. Full suite 673 passed / 0 failed.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Open any saved frame model and re-analyse: every number must be IDENTICAL to the
     previous build (shear areas default to 0 = rigid = old behaviour).
  2. There is no UI field for shear areas yet (S10 decides whether to expose them) — nothing
     else visible to check. This stage exists so the SPACE GASS benchmarks can be
     apples-to-apples.
- **Still at risk:** point-load fixed-end forces are rigid-shear (documented above);
  section-library shear areas are populated per-benchmark in S7, not app-wide yet.

### AS3600-A2-SHEAR — ks fitment trigger + two more A2 corrections in RC beam shear (2026-07-17)
- **Status: ENGINE-ONLY (RC beam engine not yet wired to the app — nothing visible to test);
  closes the "ks not implemented" follow-up left open by the AS3600-A2 entry below.**
- **Symptom:** With the design basis moved to AS 3600:2018 Amendment 2, the RC beam shear
  engine had implemented only the half of A2 that RAISES capacity (kv ceiling 0.10 → 0.15)
  and kept three rules from the superseded base-2018 text — all three on the unconservative
  side under A2:
  1. **Missing ks on the "do I need stirrups?" trigger.** A2 Cl 8.2.1.6(1) requires fitments
     where V* > **ks**·φ·Vuc with ks = 1.0 (D ≤ 300), (1000−D)/700 (300 < D < 650), 0.5
     (D ≥ 650). We tested V* > φVuc with no ks — for a 300×600 beam that waived stirrups up
     to 70.8 kN where A2 requires them from **40.4 kN**. Compounds with the kv uplift:
     bigger unreinforced capacity AND a trigger that was too lax.
  2. **Web-crushing limit 11% high.** A2 rewrote Cl 8.2.3.3: Vu.max = 0.55·[**0.9**·f'c·bv·dv·
     cotθv/(1+cot²θv)] — the 0.9 on f'c is new in A2 and we didn't have it (300×600/f'c 32:
     1220 kN → 1098 kN).
  3. **Fitment spacing for deep beams.** A2 replaced Cl 8.3.2.2: max longitudinal spacing is
     min(0.5D, 300) at ANY depth; the base-2018 "600 mm for D > 1.2 m" branch we implemented
     is gone (its V* ≤ Vu.min relaxation to min(0.75D, 500) is deliberately not taken —
     conservative).
  All three verified from RENDERED page images of `Australian Standards\Concrete\
  3600-2018-amen2.pdf` (pp. 6–8, 10–11, 13) — text extraction drops the ≤/≥ signs in
  these files, so images were the source of truth.
- **Correction to the defect report:** Cl 8.2.1.6(3) (D ≥ 750 → fitments always required)
  was reported missing but was already implemented and tested; only ks and the two audit
  findings above were real.
- **Audit of the rest of A2's Cl 8.2 rewrite against RcbShear (as requested):**
  - Cl 8.2.4.3 kv re-base by the earlier session: **confirmed correct** against the A2 page.
  - Cl 8.2.1.7 Asv.min: equation unchanged by A2 (first sentence only) — ours stands.
  - Cl 8.2.5.2 Vus: untouched by A2 — ours stands.
  - Table 2.2.2: A2 amends only row (d) (columns) + a transfer note — bending φ(kuo)
    0.65–0.85, Class L 0.65, shear 0.75/0.70 all stand on the A2 basis.
  - Cl 8.2.4.1: simplified method now ALSO barred where torsion is present, general method
    primary — module is torsion-free by scope; doc comments updated, no calc change.
  - Cl 8.2.3.2: critical section moved do → dv from support face — we conservatively use the
    support-centreline maximum; comment updated.
  - Cl 8.6.1/8.6.2.2 (crack control): A2 restructures wording only; the Tables 8.6.2.2(A)/(B)
    values and the max(A,B) + 0.8·fsy rule are unchanged — RcbCrackControl stands.
  - **A2 Cl 8.2.7 ΔFtds — primitives NOW IMPLEMENTED (same day, follow-up to this entry):**
    `RcbShear.DeltaFtds_kN` (= 0.5·(V* + φVuc)·cotθv with the half-term capped at V*,
    Pv = 0 — the cap applies BEFORE the cot multiplication, verified from the rendered A2
    p.11) and `RcbShear.AnchorageSteelForDeltaFtds_mm2` (= ΔFtds/fsy), 4 golden tests.
    The ASSEMBLY (comparing required anchorage area against bottom steel continued to
    each support, comp-sheet line) is assigned to the Opus Stages-6–8 chat — written into
    `docs/CHAT_PROMPTS/OPUS_PHASE2_RCB_STAGES6-8.md` step 4a so Opus consumes the tested
    primitives and never re-derives the formula. Validation pack note still due Stage 10.
- **Fix:** `Services/Design/Concrete/RcbShear.cs` — new `Ks(D)` + trigger uses ks·φVuc
  (rational-calculation ks = 1.0 concession NOT taken — conservative); `VuMax_kN` gains the
  0.9; `MaxFitmentSpacing_mm` = min(0.5D, 300); result record exposes `Ks` for the comp
  sheet; clause references and doc comments moved to the A2 numbering.
- **Test:** `RcbShearTests` — new `Ks_MatchesAmendment2Clause8216` (all three branches + both
  boundary continuities), `Check_NoFitments_KsReducedTrigger_RequiresFitmentsWellBelowPhiVuc`
  (the defect case: V* = 50 < φVuc = 70.8 but > 40.4 → fitments now required, was waived),
  `Check_ShallowMember_KsIsOne_TriggerIsFullPhiVuc`, `Check_650Member_KsHalf_…`,
  below-trigger case, plus recomputed Vu.max/spacing goldens. Hand calcs in comments.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:** nothing yet (engine not wired). When Stages 6–8 land:
  a 300×600 RC beam with V* ≈ 50 kN must call up fitments; the comp sheet's web-crush line
  reads the A2 (lower) Vu.max.
- **Still at risk:** the Cl 8.2.7 ΔFtds gap above (parked to Stage 6/10, in the plan);
  footing engines are UNAFFECTED by ks/Vu.max/spacing (they use their own one-way/punching
  paths with no fitments and no web-crushing check).

---

### CEFRAME-S3 — Truss members were secretly rigid (G13), nodal loads on wrong DOFs (G8), named mechanism diagnostics (G9) (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom:** (1) **G13 (found this stage — significant):** members set to type "Truss" were
  actually analysed as RIGID-JOINTED frame members. The pin releases truss members rely on
  create a spin-freely mode inside the release maths, the release step hit that singularity
  and SILENTLY gave up — leaving the member fully rigid. Triangulated shapes hid it (small
  moments), but truss axial forces were slightly wrong and member moments were non-zero.
  The same silent give-up applied to a user releasing torsion (or sliding) at BOTH ends of
  any member. (2) G8 — nodal loads entered with a "Local" direction landed on wrong degrees
  of freedom: a Local-direction nodal FORCE always acted vertically regardless of axis, and
  a Local-direction nodal MOMENT corrupted the NEXT node's forces (phantom 5 kN force proven
  in S0) or crashed at the last node. (3) G9 — an unstable model produced one generic
  "matrix is singular" message with no clue where the problem was.
- **Root cause:** (1) same-DOF releases at both ends (axial/shear/torsion) make the released
  sub-matrix singular; `CondenseWithReleases` returned the UNcondensed matrix on singularity.
  (2) the nodal-load DOF switch added the rotation offset twice for Local directions and
  defaulted Local forces to Uy. (3) no zero-stiffness detection existed.
- **Fix:** (1) release-pair rule: a same-DOF release pair keeps the start release and drops
  the end duplicate (one released end already transmits zero force — statically identical,
  no mechanism); patterns that still cannot condense now FAIL with the member named, never
  silently rigidify. (2) unified nodal-load mapping: Local directions on nodal loads act as
  their global equivalents. (3) zero-stiffness DOFs with no load are AUTO-RESTRAINED with a
  warning naming the node (standard practice — pin-jointed truss node rotations); a LOADED
  zero-stiffness DOF fails with "node X direction Y" named. New `Warnings` list on results.
- **Test:** `TrussTriangle_PinJointedStaticsExact_MomentsExactlyZero` (hand statics: diagonal
  −5√13/3 = −6.009 kN, tie +10/3 kN, moments exactly zero),
  `NodalForce_LocalX_MapsToGlobalX`, both G8 tests unskipped,
  `DoublePinnedMember_Udl_BehavesSimplySupported`,
  `Diagnostics_UnloadedFloatingNode_AutoRestrainedWithWarning`,
  `Diagnostics_LoadedFloatingNode_FailsNamingNodeAndDof`,
  `Diagnostics_TorsionReleasedMember_TipTorque_NamesLooseRx`.
  **Full suite 662 passed / 0 skipped / 0 failed — every defect test from S0 is now
  unskipped and green.**
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Structure tab: make a triangle of three members, set all three to type "Truss", pin one
     bottom corner, roller the other, load the top corner downward. Analyse: every member
     must show ZERO end moments, and axial forces only. Before the fix small moments appeared.
  2. Set an ordinary member's end releases so the SAME thing is released at both ends
     (e.g. torsion Rx both ends). The analysis must either work (load has another path) or
     stop with a message NAMING the member/node — never crash, never silently ignore.
  3. Enter a nodal load and pick a "Local" direction: LocalX must act along global X (not
     vertically). A Local-direction nodal moment must twist the model the same as the
     matching Global direction — and never error out at the last node.
  4. Delete a member so part of the model floats loose WITHOUT load on it: analysis should
     still run (check for a warning naming the loose node). Put a load on the loose part:
     analysis must stop and tell you which node and direction is unsupported.
- **Still at risk:** truss/pin-heavy models that "worked" before may now report slightly
  DIFFERENT (correct) axial forces and exactly-zero moments — expected. Models that
  previously analysed despite a load on an unstiffened DOF will now refuse with a message —
  that is the fix working.

### CEFRAME-S2 — Frame diagrams rebuilt on one sign convention (G6) + pinned-end member loads distributed correctly (G11) (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom:** (1) G6 — the bending-moment/shear DIAGRAM drawn along a frame member in the
  Structure tab was wrong for any member whose ends carry moment (portal columns and beams,
  fixed-ended beams): the diagram used the end value with the wrong sign (portal beam midspan
  showed 65.8 instead of 24.2 kN·m), and point loads pushed the diagram the wrong way past the
  load. There were also NO diagrams at all for weak-axis bending, torsion was not reported
  along the member, and the axial diagram used a wrong interpolation. (2) G11 — a member with
  a pinned end (end release) carrying a distributed load spread that load as if both ends were
  rigidly fixed: a propped-cantilever arrangement returned the simply-supported reactions
  (30/30 instead of 37.5/22.5) — wrong reactions AND wrong moments for pinned-end rafters.
- **Root cause:** (1) `ComputeIntermediateForces` mixed two sign conventions (raw joint-applied
  end moments vs internal bending moments) and carried the load sign twice for point loads.
  (2) The equivalent nodal loads for member loads were never condensed for end releases —
  the load vector must transfer through the same static condensation as the stiffness
  (p̃ᵣ = pᵣ − Kᵣ꜀·K꜀꜀⁻¹·p꜀; hand-verified to reproduce the propped-cantilever textbook values).
- **Fix:** new `Services/Calculation/Frame/FrameStationForces.cs` computes end forces AND
  21-station arrays for ALL six internal actions (N, Vy, Vz, Mx, My, Mz) from start-side
  free-body statics in ONE documented convention (N tension+, Mz sagging+); the old
  `ComputeIntermediateForces` deleted. `StiffnessMatrixBuilder.CondenseWithReleases` now
  returns the fem condenser alongside the condensed stiffness; the engine applies it in load
  assembly and force recovery. **Deliberate visible convention change:** member END moments in
  the results table now print in the internal convention — hogging reads NEGATIVE (previously
  the raw joint-applied sign, which read hogging as positive at the start end). End values and
  diagram values can no longer disagree by construction.
- **Test:** `StationArrays_SimpleBeamUdl_QuarterPointExact`, `StationArrays_SimpleBeamPointLoad_Exact`
  (unskipped), `PinnedPortal_BeamUdl_MidspanStationMoment` (unskipped),
  `PinnedPortal_BeamUdl_KneeMomentContinuityAcrossMembers` (new — frame-aware joint proof),
  `SignConvention_FixedFixedUdl_HoggingEndsNegativeSaggingMidPositive` (new),
  `SignConvention_AxialUdl_TensionStationsLinear` (new), `ProppedCantilever_Udl_ViaEndRelease`
  (unskipped, G11), weak-axis station asserts added to the GlobalZ cantilever test.
  Full suite 654 passed / 2 skipped (G8, S3) / 0 failed.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Structure tab, simply supported beam with a UDL: the moment diagram should be a clean
     parabola, peak at midspan = wL²/8 (e.g. 10 kN/m on 6 m → 45.0). This worked before and
     must still work.
  2. Portal frame with UDL on the beam: the beam's moment diagram must now show the classic
     portal shape — hogging humps at the knees, sagging belly in the middle — and the value at
     the knee must MATCH the column-top value shown for the column. Before the fix the beam
     diagram was one knee-moment too high everywhere (65.8 vs 24.2 at midspan on the test frame).
  3. Beam with a point load: the moment diagram must peak AT the load and come back down to ~0
     at the far support. Before the fix it kept climbing past the load.
  4. Member results table: end moments for a fixed-ended or portal member now show hogging as
     NEGATIVE numbers. A sign flip vs the previous build in that table is EXPECTED, not a bug.
     Magnitudes must be unchanged.
  5. Pinned-end member (set an end release Rz on one end) with a UDL: the reactions must be
     uneven (5/8 and 3/8 of the load, heavier at the fixed end), not 50/50 as before.
- **Still at risk:** the 3D moment diagram may draw on the opposite side of some members than
  the previous build (values were wrong before; the drawing side follows the corrected signs).
  Superposed COMBINATION results still carry end forces only (no station arrays) — scheduled
  under S6's per-combination direct analysis. Remaining known defect G8 (Local-direction nodal
  moments) is Skip-tagged for S3.

### RCB-STAGE7 — RC beam wired into the app (first time it is visible) (2026-07-17)
- **Symptom (gap):** the RC beam engine and model existed but there was no way to create,
  edit, see or cascade a concrete beam in the app — no toolbar button, no input screen, and
  every element-type switch (delete, duplicate, cascade, takeoff, API) silently ignored the
  new type. Stage 7 wires it all up.
- **Fix:**
  - New input screen: `Views/RcbInputView.xaml(.cs)` + `ViewModels/RcbDesignViewModel.cs`
    (PadFooting pattern: observable mirrors, 300 ms debounced recalc, SaveToModel → engine →
    show result). A successful design raises `BeamAnalysisCompleted` so downstream beams update.
  - `BeamProject.ReinforcedConcreteBeams` + `AllElements` (already added Stage 6); toolbar
    "+ RC Beam" button and **Ctrl+7**; Input + Output `DataTemplate`s in `MainWindow.xaml`.
  - `MainWindowViewModel`: Add / Delete / Duplicate / Insert / Copy-Loads / Paste-Loads all
    handle the RC beam; **cascade both ways** — `LoadCascadeService.GetCaseReactions` (RC beam
    as a load SOURCE) and `UpdateTargetCascadeLoads` (RC beam as a load TARGET).
  - **Marks (T3):** `BeamMarkGenerator.GenerateRcbMark` numbers concrete beams **EB1/IB1…**
    by role, project-wide, never floor-prefixed and never reusing framing marks. "Relabel all
    marks" (Ctrl+Shift+R) renumbers them by role; the old floor+type relabel is bypassed for
    concrete so it can never produce "RBRC1".
  - **Takeoff (T4):** an RC beam produces one row under a new **"Concrete"** category carrying
    concrete volume (m³) and reinforcement mass (kg); the timber/steel weight totals are left
    untouched.
  - `ApiRequestHandler`: element count, span and material ("Concrete") for the RC beam.
- **Test:** RED-then-green cascade test (`GetCaseReactions_ReinforcedConcreteBeam` fails with
  silent zeros before wiring, passes after); `TakeoffServiceTests` concrete-row test (300×600×6 m
  → 1.08 m³ + reo mass, no timber/steel pollution); RC beam added to `ProjectFileRoundTripTests`.
  **Full suite: 707 passed / 0 failed.** No existing test broken.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app (FIRST time RC beams are visible):**
  1. Toolbar → **+ RC Beam** (or **Ctrl+7**). A new beam **EB1** appears, selected, with the
     RC Beam input screen showing.
  2. Set 300 × 600, span 6000, f'c 32, add a UDL G = 8 kPa (width 1.0) and Q = 3 kPa (width 1.0).
     After ~⅓ s the ADOPT box should fill in with a size + bar callout like
     **"300 x 600 RC BEAM - n-N.. B, 2-N12 T, N.. -.."**, Status **PASS**, self-weight ≈ 4.32 kN/m,
     governing "1.2G + 1.5Q".
  3. Change the **role** dropdown to Internal → press **Ctrl+Shift+R** (Relabel) → the mark
     becomes **IB1**. Add another edge beam → it becomes **EB1**.
  4. **Uplift:** set the deflection category to Roof, replace the loads with G = 1 kPa and a
     **Wind −12 kPa** UDL → a reversal/top-steel line should appear in the checks and the
     governing uplift combination should mention "Wu".
  5. **Mesh:** set Bar type = Trench mesh on a short beam (say 3 m, G = 5) → the callout reads
     like **"3L12TM B…"** and an amber Class-L warning appears; the pass margin is tighter than
     with N-bars (φ = 0.65).
  6. **Cascade:** link an RC beam's reaction onto a simple beam (source) and drop a simple
     beam's reaction onto an RC beam (target) — loads should flow both ways.
  7. **Delete / Duplicate** an RC beam — both should work and renumber sensibly.
  8. Save the project, reopen it → the RC beam and its inputs should all come back.
- **Still at risk / v1 limitations (documented, not bugs):**
  - Changing the role does **not** auto-renumber the mark on the spot — use Relabel (Ctrl+Shift+R).
  - **Templates** ("Save as template") are still beam-only; RC beams are not template-able yet.
  - The takeoff reo mass counts **main bars only** (fitments excluded) — a stated estimate.
  - The comp-sheet PDF page for RC beams lands in Stage 8 (next); until then an RC beam prints
    a header-only page in the master PDF.
- **Status:** AWAITING TIM'S TEST

---

### RCB-STAGE6 — RC beam model + design engine (still not visible in the app) (2026-07-17)
- **Symptom (gap):** Stages 1–5 built the AS 3600:2018 concrete calculation engines, but nothing
  used them — there was no "concrete beam" object in the app and no code that ran the engines in
  the right order. Stage 6 adds the beam itself and the engine that drives the whole design.
  **Still nothing to click on**: the RC beam type does not appear in the app until Stage 7 wires
  the UI, so the deliverable here is again the test suite.
- **Root cause:** n/a (planned feature build — RCB plan §12 Stage 6).
- **Fix:** three new files plus two one-line registrations:
  - `Models/Beams/ReinforcedConcreteBeam.cs` — the beam (span, section b×D, T/L flange, f'c,
    cover, exposure, bar/mesh choice, EB/IB mark role per decision T3, loads). Section size is
    user-fixed and never auto-grown (decision T5).
  - `Models/Results/RcbResult.cs` — one `RcbCheckResult {ClauseRef, Demand, Capacity, Ratio,
    Passes, Detail}` per check, plus adopted bars, callout, development lengths and warnings.
    The comp sheet will PRINT these; it never recomputes.
  - `Services/Design/Concrete/RcbDesignEngine.cs` (+ `.Selection.cs`, `.Checks.cs`) — the
    orchestrator: builds a throwaway `SimpleBeam` to reuse the existing analysis engine, adds
    self-weight, then walks the bar palette until every check passes (bending ±, shear, min
    steel, deflection, crack control) and writes back in one block.
  - `BeamProject.ReinforcedConcreteBeams` + `AllElements`; `MemberType.ConcreteRcb` (appended —
    the enum is serialized by integer).
- **Two integration bugs found and fixed while building this (both would have shipped silently):**
  1. **Sagging moment sign.** The brief said to use `AnalysisResults.MaxMomentUltimate` as the
     sagging demand. That field is the signed moment of largest ABSOLUTE size, so on a beam
     dominated by wind uplift it is NEGATIVE. Steel gets away with `Math.Abs()` on it because a
     steel section is symmetric — the same section resists bending either way. **Concrete is
     not**: the bottom bars and the top bars are different steel. Using it would have designed
     the bottom bars against a moment that never actually acts downwards. The engine now takes
     each face's own true peak from `CombinationEnvelopes` (an existing, already-tested seam).
  2. **Effective depth d.** `FlexuralAnalysisResult.EffectiveDepth_mm` is the tension-FORCE
     centroid across every bar layer, so when the neutral axis sits above the top bars those
     bars count as tension and drag d down (490 mm instead of the true 557 mm on the test
     beam) — which would understate minimum steel and shear depth. The engine now uses the
     geometric centroid of the bottom steel for d, and two layers average as intended.
- **A2 follow-up (commit `2d02c78`):** after Amendment 2 landed in the shear engine, the
  engine gained (a) the **shear-anchorage check** — the shear field's longitudinal tension
  ΔFtds (A2 Cl 8.2.7) must be anchored by the bottom bars continued to the support
  (Cl 8.2.8.1); v1 rule is that all bottom bars run to supports, so the check compares the
  required fully-developed area against the full bottom Ast, and a shortfall fails the design;
  and (b) **fitment-trigger surfacing** — ks and the ks·φVuc trigger (A2 Cl 8.2.1.6(1)) are
  now in `RcbResult` (a beam can pass the shear ratio yet still legally require fitments; the
  trigger roughly halves for D ≥ 650). Both assemble golden-tested `RcbShear` primitives — no
  new engineering formula. +4 tests.
- **Test:** `RcbDesignEngineTests` (25) — an end-to-end hand-calc golden (300×600, f'c 32,
  6 m, G 8 + Q 3 kN/m → self-weight 4.32 kN/m, M* 86.78 kN·m governed by "1.2G + 1.5Q",
  V* 57.85 kN), self-weight idempotence (Design() three times → identical), the uplift
  flipped-section check, an explicit sign-convention regression pin, Class L mesh, and the
  T5 "never grow the section" failure path. Plus RCB added to `ProjectFileRoundTripTests`.
  **Suite green: 0 failed.** No existing test modified.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:** nothing yet — Stage 6 has no user-visible surface. The
  RC beam appears at Stage 7.
- **Still at risk / parked (needs a decision before release):**
  - **T/L (flanged) serviceability** uses the rectangular WEB only for Ief, Mcr and crack
    control — the engines have no flanged cracked-section. This is conservative in both
    directions (more deflection, higher steel stress), and every affected beam prints a
    warning saying so. Proper flanged serviceability was never specified (plan §6).
  - **Cover defaults**: only the two values the firm actually approved are shipped — A1 = 25 mm,
    B1 = 40 mm (plan E2). A2/B2 seed from the conservative B1 value and raise a warning.
    AS 3600 Table 4.10.3.2 was NOT transcribed (it also varies with f'c and was not verified
    against the firm's PDF this session).
  - **Incremental deflection** (the part after brittle finishes go on) is computed and reported
    but carries NO pass/fail — the firm has not agreed a limit (plan E4 still open).
  - **Self-weight on T/L sections** adds the flange overhang rectangle as instructed. If the
    slab load is also entered as a UDL this double-counts the flange — the self-weight line is
    shown read-only in the loading breakdown so it is visible.
  - The design basis moved to **AS 3600:2018 Amendment 2** under a parallel session (see that
    session's entry) — RCB inherits it automatically through `As3600`/`RcbShear`.
- **Status:** ENGINE-ONLY (no app test possible yet) — Stages 7–8 pending.

---

### CEFRAME-S1 — Frame engine: column axis-system fix (G12) + analysis no longer rewrites the model (G7) (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom:** (1) G12 — in the Structure tab, any frame with columns under a sideways load
  (wind/sway) reported the up/down pair of support reactions BACKWARDS, and the reaction set
  failed the basic "reactions balance the loads" statics check (proven by the S0 suite:
  residual exactly 2× the applied overturning moment). Symmetric gravity-only models were
  unaffected, which is why it was never noticed. (2) G7 — running an analysis permanently
  rewrote truss members' end connections inside the model file: switch a Truss member back
  to Beam and it silently kept pinned ends forever.
- **Root cause:** (1) `CoordinateTransform.BuildRotationMatrix` gave columns drawn
  bottom-to-top a mirror-image (left-handed) local coordinate system — det(R) = −1 — so
  force/moment couplings through those members were inconsistent with statics. Bottom-to-top
  is how columns are normally drawn, so every portal model was exposed. (2)
  `FrameModel.ApplyTrussReleases()` wrote Pin() into the members during every analysis.
- **Fix:** vertical members now get a proper right-handed axis system that also MATCHES the
  3D view's own axis convention (`Frame3DSceneBuilder.MemberLocalAxes`) — previously the
  picture and the analysis disagreed about what a "LocalY/LocalZ" load direction meant on a
  column. The engine now computes member lengths and truss end releases per-analysis without
  writing anything into the model (`ApplyTrussReleases` deleted;
  `StiffnessMatrixBuilder.ApplyEndReleases` takes explicit releases;
  `BuildLocalStiffnessMatrix` gained an explicit-length overload).
- **Test:** `PinnedPortal_LateralAtKnee_VerticalCoupleAndGlobalEquilibrium_G12`,
  `FixedPortal_Lateral_GlobalMomentEquilibrium_G12`,
  `Analyse_TrussMembers_DoesNotPermanentlyMutateReleases` (all unskipped and passing);
  full suite 638 passed / 5 skipped (S2/S3 items) / 0 failed.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Structure tab: build a small portal (two columns, one beam, pin the two bases), put a
     sideways point load at a top corner, analyse. The two vertical reactions must be equal
     and opposite, with the UPWARD one under the column FURTHER from the pushing load
     (the frame "leans onto" the far leg). Before this fix they were swapped.
  2. Same model: total upward minus downward reactions = 0, and the two horizontal reactions
     each ≈ half the applied load, opposing it.
  3. Gravity-only check (should be UNCHANGED by this fix): UDL on the beam → both vertical
     reactions equal, sum = total load. Compare to the previous build if convenient —
     symmetric gravity numbers must not move.
  4. Truss check: set a member's Type to Truss, analyse, then set it back to Beam and
     re-analyse. It must behave as a rigid (moment-carrying) member again. Before the fix it
     stayed pin-ended forever.
  5. 3D view: confirm member load arrows drawn on COLUMNS with Local directions point the
     same way the results imply (picture and analysis now use the same convention).
- **Still at risk:** any saved `.cebeam` model whose column results were previously viewed
  under sway load will show DIFFERENT (now correct) reactions — that is the fix working, not
  a regression. Remaining known frame defects (G6 diagrams, G8 Local nodal moments, G11
  released-end member loads) are Skip-tagged in the suite and scheduled for S2/S3.

### AS3600-A2 — Design basis moved to AS 3600:2018 Amendment 2: shear cap kv 0.10 → 0.15 (2026-07-17)
- **Status: AWAITING TIM'S TEST**
- **Symptom (gap):** The concrete shear code was written to the base 2018 print of AS 3600
  (equivalently Amendment 1). **Amendment 2 (2021) rewrote Cl 8.2.4.3** and raised the
  ceiling on `kv` for members without fitments from **0.10 to 0.15**. The app was therefore
  designing footings and RC beams to a superseded edition and **understating one-way shear
  strength by up to 33%** — i.e. it was calling for bigger footings than the current code
  requires. The `200/(1000 + 1.3·dv)` formula and θv = 36° are UNCHANGED by A2; only the cap moved.
  Verified verbatim off the rendered amendment page (`Australian Standards\Concrete\3600-2018-amen2.pdf` p.10).
- **Root cause:** `As3600.KvNoFitmentsMax` was `0.10`, cited to the pre-amendment
  Cl 8.2.4.3(a). Every clause reference in the shear path pointed at the un-amended 2018 clause.
- **Fix:**
  - `Services/Design/Concrete/As3600.cs` — `KvNoFitmentsMax` 0.10 → **0.15**, cited to
    "AS 3600:2018 Amdt 2 Cl 8.2.4.3(1)"; new `As3600.Edition` constant
    (`"AS 3600:2018 (Amdt 2, 2021)"`) as the auditable design basis; class + `KvSimplifiedNoFitments` docs rewritten.
  - `Services/Design/PadFootingDesignEngine.cs` — stale "≤ 0.10" comments corrected (2 places).
  - `Services/Design/Concrete/RcbShear.cs` — clause refs → Amdt 2 Cl 8.2.4.3(1)/(2).
    `KvWithMinFitments` stays **0.15** (A2 did not change the with-fitments rule).
  - `Models/Project/DesignSettings.cs` — new `ConcreteDesignCode` property, defaulted to
    `As3600.Edition`, so the printed output can state the basis alongside the steel/timber codes.
- **Test:** `As3600Tests` (`ClauseConstants_KvCapAndEdition_FollowAmendment2`,
  `KvNoFitments_TypicalMember_IsNotCappedAtTheOldPoint10`, `KvNoFitments_ShallowMember_CappedAt015`,
  `KvNoFitments_AtTheCapCrossover_SwitchesFromCapToFormula`), plus recomputed goldens in
  `PadFootingDesignEngineTests`, `CombinedFootingDesignEngineTests`, `RcbShearTests`.
  All 117 concrete/footing tests pass.
- **Date:** 2026-07-17
- **What Tim should test in the app — READ THIS FIRST:**
  **This change makes footings come out SMALLER, and that is the correct, intended result.**
  The concrete's shear strength goes up by as much as a third, so:
  - a footing that FAILED shear in the last build may now PASS unchanged;
  - auto-design may now pick a **smaller or shallower footing** than the previous build did
    for the identical inputs.
  Do not treat a smaller footing as a bug — the old numbers were based on a superseded edition
  of the standard. Steps:
  1. Open a pad footing you designed with the previous build and re-run it. Expect the shear
     result to be the same or better, and the footing to be the same size or smaller. Nothing
     should get bigger. **If anything gets bigger, that IS a bug — report it.**
  2. Check the one-way shear line. On a 2000 x 2000 x 600 footing with a 200 x 200 column,
     f'c 25, G 100 / Q 50, the shear capacity should now read about **405 kN** (it was 324 kN).
  3. Check a thin one. Same footing but 300 deep with G 400 / Q 300 should still **FAIL** shear,
     but now at about **227 kN** capacity instead of 151 kN. It must still fail — if it now
     passes, report it.
  4. Combined footing, 1200 x 1200 x 500 on a 90 x 90 stud, G 80 / Q 40: shear capacity should
     now read about **211 kN** (was 157 kN).
  5. Combined footing, 600 x 600 support, 250 deep, G 250 / Q 170, bearing 100: the previous
     build grew this footing past 2150 mm to get shear to pass. It should now **stop at
     2150 mm** — the bearing-governed size. This is the size reduction, visible.
  6. Anything that is NOT concrete shear must be untouched: steel, timber, the Structure tab,
     bearing pressures, punching shear and minimum steel should all read exactly as before.
- **Still at risk / follow-ups NOT done here (deliberately out of scope):**
  - **Cl 8.2.1.6 `ks` (A2) is not implemented.** A2 makes the "do I need fitments?" threshold
    `ks`-dependent (ks = 1.0 for D ≤ 300; (1000−D)/700 for 300 < D < 650; 0.5 for D ≥ 650).
    `RcbShear.Check` still triggers on `V* > φVuc` with **no ks**, so for any beam deeper than
    300 mm it **under-reports when fitments are required** — e.g. the 300x600 test beam's
    trigger should fall from 70.8 kN to ~40.4 kN (ks = 0.571). This is unconservative and it
    compounds with the kv uplift above. **The footing engines model no fitment trigger at all**,
    so ks changes no footing number today — but that silence is a bigger assumption now that A2
    lets footings pass at higher utilisation. Needs the exemption text in A2 Cl 8.2.1.6 checked
    against the actual amendment before implementing.
  - Other A2 Cl 8.2 changes not assessed in code: rewritten Vu.max (Cl 8.2.3.3), Cl 8.2.7 ΔFtds,
    the bar on the simplified method where torsion is present, and the general method becoming primary.
  - **Coverage lost:** `CombinedFootingDesignEngine`'s one-way-shear grow loop no longer has a
    direct test. Under A2 no realistic square footing fails one-way shear at its bearing size
    before punching governs (swept support 450–1200 mm, depth 200–400 mm, bearing 50–300 kPa,
    loads to 1000 kN: one-way never exceeds capacity by more than ~4.6%, and every case that
    still grows has punching already at 90%+). The loop may now be close to dead code — worth a
    decision rather than a contrived knife-edge test.

### CEFRAME-S0 — Frame engine characterisation suite: 4 defects confirmed, 1 new one found (2026-07-17)
- **Symptom (gap):** The 3D frame engine (Structure tab) had 35 tests but none checked it
  against hand-derived textbook answers for portal frames, torsion, end-release loading or
  moment equilibrium. Phase 4.1 S0 adds that closed-form golden suite BEFORE changing any
  engine code, per the approved plan (`docs/CE_FRAME_PHASE41_42_PLAN.md`).
- **Root cause:** n/a (characterisation stage) — but the suite CONFIRMED defects G6/G7/G8
  from the plan's gap list and FOUND ONE NEW ONE (G11):
  - **G6 (worse than planned):** the bending-moment diagram values along a member are wrong
    for ANY member whose end carries a moment (portal columns, portal beams, fixed-ended
    beams) — sign-convention mismatch between end forces and the diagram accumulation
    (measured: portal beam midspan 65.76 instead of 24.23 kN·m). Point loads additionally
    flip sign in the diagram (56 vs 16 kN·m). End forces and reactions are CORRECT — the
    defect is in the diagram/station values only.
  - **G7:** analysing a model permanently rewrites truss members' end releases.
  - **G8:** nodal moments entered with a Local direction corrupt the load vector (a 5 kN·m
    torque at an interior node showed up as a phantom 5 kN horizontal force; at the last
    node it crashes the analysis). Global-direction nodal moments are correct.
  - **G11 (NEW):** a member with a pinned end (end release) carrying a distributed load
    distributes that load as if both ends were rigid — the propped-cantilever test returned
    the simply-supported reactions (30/30 instead of 37.5/22.5) and no fixed-end moment.
    Real-world impact: a portal rafter with a pinned end under gravity/wind load gets wrong
    reactions and moments. Fix scheduled in S2.
  - **G12 (NEW — the most serious finding):** columns drawn bottom-to-top get a
    **mirror-image local coordinate system** (the maths equivalent of a left-hand glove on
    a right hand). Consequence, PROVEN by the suite: under a sideways (sway/wind) load the
    up/down pair of base reactions comes out BACKWARDS, and the engine's reactions fail the
    most basic statics check — they don't balance the applied overturning moment (residual
    exactly 2× the applied moment). Vertical-only symmetric loading hides it, which is why
    it survived until now. **This affects results the CURRENT shipped Structure tab shows
    for any frame with columns under lateral load** — it is a latent v1.0 defect, not a
    regression. Base shears and member bending moments happen to remain correct in the
    cases tested; the vertical reactions under sway are wrong. Fix scheduled in S1
    (one contained function — the vertical-member axis convention), with a check that the
    3D view still draws sections correctly afterwards.
  - Also verified as CORRECT (not defects): global force+moment equilibrium, transforms,
    3D torsion path (grillage exact to 6 significant figures), fixed-end forces to rigid
    ends, static-condensation stiffness, axial-flexibility effects (hand-verified to 6
    decimals), Global nodal moments, weak-axis bending.
- **Fix:** no engine code touched in S0 (by design). New files:
  `tests/.../FrameTestModels.cs`, `FrameClosedFormPortalTests.cs`,
  `FrameClosedFormMemberTests.cs` — 18 tests: 12 pass against the unchanged engine, 6 are
  Skip-tagged with the measured wrong values and the stage that will fix them (S1/S2/S3).
- **Test:** `FrameClosedFormPortalTests` + `FrameClosedFormMemberTests` (hand calcs in
  comments — flexibility-method derivations for the portal thrust cases).
- **Date:** 2026-07-17
- **What Tim should test in the app:** Nothing yet — this stage adds tests only; no app
  behaviour changed. BUT be aware until S2 lands: **the moment DIAGRAM drawn along a frame
  member in the Structure tab is currently wrong whenever the member's ends carry moment**
  (portal frames, fixed beams). The member END values and reactions shown are correct.
- **Still at risk:** the six Skip-tagged tests are the checklist for S1–S3; none may stay
  skipped past their stage.

### RCB-STAGES1–5 — RC beam calculation engine (pure math, not yet visible in the app) (2026-07-17)
- **Symptom (gap):** The app had no concrete-beam calculations at all. Stages 1–5 of the
  approved RCB plan (`docs/RCB_PHASE2_PLAN.md` §12) build the complete AS 3600:2018
  calculation core. **Nothing is wired to the UI yet** — no new element type appears in
  the app until Stages 6–8, so there is nothing visual to test; the deliverable at this
  point is the test suite itself.
- **Root cause:** n/a (planned feature build).
- **Fix:** five new engine files under `Services/Design/Concrete/` + additions to
  `As3600.cs`, every formula transcribed from the firm's AS 3600-2018 PDF this session:
  - `RcbFlexure.cs` (Stage 1 + 5): rectangular AND flanged (T/L) bending strength by
    strain compatibility with bisection neutral-axis solve (the legacy sheet's "bunny"
    macro, made deterministic); φ from kuo per Table 2.2.2 incl. Class L mesh = 0.65;
    ductility kuo ≤ 0.36; effective flange width Cl 8.8.2; flanged αb (verified from a
    RENDERED page image because text extraction scrambles those two equations).
  - `RcbShear.cs` (Stage 2): 2018 kv method both paths (0.15 with min fitments /
    size-effect formula without), Vus, web-crushing cap Vu.max, Asv.min, fitment
    triggers (V* > φVuc, D ≥ 750) and spacing caps (Cl 8.3.2.2), **φ = 0.75/0.70 split
    per Table 2.2.2(e)** with web crushing always on 0.70.
  - `RcbServiceability.cs` (Stage 3): Ec Table 3.1.2; shrinkage strain Table 3.1.7.2
    (interpolated); σcs shrinkage-restraint stress; Mcr.t; **Ief by the 2018 Bischoff
    formula** + Ief.max caps; kcs = 2 − 1.2·Asc/Ast ≥ 0.8; deflection-from-integral with
    Ec·Ief (same convention as the steel engine); Cl 8.5.4 span/depth with its
    applicability limits documented.
  - `RcbCrackControl.cs` (Stage 4): Cl 8.6.1 geometric rules + Tables 8.6.2.2(A)/(B)
    steel-stress limits (wmax 0.2/0.3/0.4 columns) capped at 0.8·fsy.
  - `RcbDetailing.cs` + `RcbBarSelector.cs` (Stage 4): bar areas/fitting (min clear
    spacing is a FIRM-PRACTICE default — Cl 8.1.9 sets no number), development length
    Cl 13.1.2.2, side-face reo Cl 8.6.4, slenderness Cl 8.9.2, and a deterministic
    N-bar + trench-mesh (Class L) selection palette.
- **Test:** 119 new golden-value tests with hand calcs in comments across
  `RcbFlexureTests`, `RcbShearTests`, `RcbServiceabilityTests`, `RcbCrackControlTests`,
  `RcbDetailingTests`, `RcbBarSelectorTests`, `RcbFlangedTests`.
  **Suite: 598/598 green** (461 baseline + 18 Stage 0 + 119 stages 1–5); zero existing
  tests modified.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:** nothing yet — no user-visible change exists until
  Stage 6–8 wire the RCB element type into the UI. The Stage 0 footing sanity check
  (previous entry) still stands.
- **Still at risk:** the engines are unconsumed until Stage 6 — integration mistakes
  (units, sign conventions between analysis envelopes and these engines) are the next
  risk zone and get their own integration goldens then. Trench-mesh fsy is 500 (current
  D500L); the legacy sheet used 450 — an expected benchmark difference (plan §9 ledger).
- **Status:** ENGINE-ONLY (no app test possible yet); benchmarks vs legacy sheets and
  the engineer validation pack land at Stage 10.

---

### RCB-STAGE0 — Shared AS 3600 helper extracted from the footing checks (2026-07-17)
- **Symptom (gap):** The AS 3600 concrete formulas (minimum steel, shear depth, kv, Vuc)
  lived inside the footing checks with footing-only values baked in (85 mm cover, 500 MPa
  steel). The new RC Beam module (Phase 2) needs the same formulas with beam values, so
  they were moved to a shared helper both can use. **This is a tidy-up, not a calculation
  change — every footing number should come out identical.**
- **Root cause:** n/a (planned refactor, RCB plan Stage 0 — `docs/RCB_PHASE2_PLAN.md`).
- **Fix:** new `Services/Design/Concrete/As3600.cs` (clause formulas, parameterised;
  includes the verified Table 2.2.2(e) shear φ split 0.75-with-fitments / 0.70-without —
  footings keep using 0.70, the correct no-fitments branch);
  `Services/Design/PadFootingDesignEngine.cs` (`As3600FootingChecks`) now delegates to it
  with its footing values bound — its public surface and results are unchanged.
- **Test:** new `As3600Tests` (18 golden hand-calc tests, incl. one pinning that the kv
  0.10 bound is a ceiling — the legacy v7 sheet inverted it). All 461 pre-existing tests
  untouched and green: **479/479 total.**
- **Date fixed:** 2026-07-17
- **What Tim should test in the app** (quick sanity that footings are unchanged):
  1. Open any existing project with a pad footing → the footing's size, bearing pressure,
     min-steel figure and the one-way/punching shear PASS/NG results should be **exactly
     the same numbers as before this change**.
  2. Same for a combined footing (support type DS/TS/P2/P3 and size unchanged).
  3. If you saved a PDF from before the change, re-export and compare the footing page —
     identical numbers.
- **Still at risk:** none expected — behaviour-preserving by design; the footing golden
  tests (722.9 mm²/m min steel etc.) pin the old numbers. Future RCB stages build on the
  new helper without touching the footing engines again.
- **Status:** AWAITING TIM'S TEST

---

### WP8-BUG — Pad footing eccentricity unit bug (kN·m added to kN·mm) (2026-07-17)
- **Symptom:** When a pad footing had a **horizontal (sideways) load** or an applied moment
  **Mh** entered, the eccentricity `e` shown came out tiny/near-zero, so the bearing pressure
  effectively ignored the sideways push. Footings with only straight-down loads were fine (that
  is why it went unnoticed).
- **Root cause:** In the eccentricity calc the sideways moment was left in kN·m but was added to
  a vertical-load moment already converted to kN·mm — a units mismatch that made the sideways
  contribution **1000× too small**.
- **Fix:** `Services/Design/PadFootingDesignEngine.cs` — all overturning moments are now formed in
  kN·m and converted to mm once, at the eccentricity step (`e = |width/2 − (Mv+Mh)/Pv × 1000|`).
- **Test:** `PadFootingDesignEngineTests` — `Design_HorizontalLoad_EccentricityInMillimetres_NotMetres`
  (golden: 100 kN vertical + 10 kN horizontal at 0.6 m → e = 60 mm, q = 444.4 kPa) and
  `Design_AppliedMomentMh_MatchesHandCalcEccentricity` (Mh 4.5 kN·m → e = 45 mm). Existing
  vertical-load / Mv tests still pass unchanged.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Open/create a pad footing with only straight-down loads (no horizontal force, no Mh) → the
     eccentricity `e` should still read 0 — no change here.
  2. Add a Horizontal Force of 10 kN, footing depth 600, vertical load about 100 kN → `e` should
     now read about **60 mm** (before the fix it read about 0.06 mm — basically nothing).
  3. Clear that and instead type an applied moment Mh of 4.5 kN·m → `e` should read about **45 mm**.
  4. Confirm the bearing pressure `q` rises as `e` rises.
- **Still at risk:** the straight-down (Mv) path was already correct and is still covered by tests;
  the combined footing uses a separate engine and is unaffected.
- **Status:** AWAITING TIM'S TEST

---

### WP8-BUG — Project load duplicated default lists (spans, preferred grades) (2026-07-17)
- **Symptom:** Found while adding the whole-project save→load test. Saving a project and reopening
  it **appended** the model's built-in defaults in front of the saved values: a 2-span continuous
  beam reloaded with 4 spans `[4800, 4800, <saved>, <saved>]`, and the Settings "preferred timber
  grades / steel types" lists doubled up on every reopen.
- **Root cause:** `ProjectFileService` deserialised with Newtonsoft's default handling, which
  **adds to** a pre-populated collection rather than replacing it. Several models seed defaults
  (`ContinuousBeam.Spans_mm`, `ContinuousBeam.SupportTypes`, `DesignSettings.PreferredTimberGrades`,
  `DesignSettings.PreferredSteelTypes`), so those got the saved items tacked on the end.
- **Fix:** `Services/Export/ProjectFileService.cs` — set `ObjectCreationHandling = Replace` so a
  loaded project's collections replace the defaults instead of appending to them.
- **Test:** `ProjectFileRoundTripTests.SaveThenLoad_PreservesElementsLoadsAndSettings` — asserts a
  2-span continuous beam reloads with exactly `[4000, 4000]` (would have been 4 items before the fix).
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Create a project with a 2-span continuous beam (spans e.g. 4000 + 4000), a couple of simple
     beams with loads, save it, close it, and reopen it.
  2. The continuous beam should still show exactly **2** spans (before the fix it would show 4,
     starting with 4800, 4800).
  3. Open Settings after reopening → the preferred timber-grade and steel-type lists should be the
     same as you saved, **not** doubled up.
- **Still at risk:** any future model that seeds a default list is now handled correctly by the
  Replace setting; no per-model change needed.
- **Status:** AWAITING TIM'S TEST

---

### WP8 — PDF report labels reconciled with the new load combinations (2026-07-17)
- **Symptom:** The exported PDF (and the on-page reaction / moment tables) still printed the old
  fixed **"1.25G+1.5Q"** heading even though the app now designs to the standard AS/NZS 1170.0
  combinations. Separately, pad-footing pages stamped the **overall** pass/fail on a line labelled
  **"Bearing"**, so a footing that actually failed in **shear** looked like a bearing failure, and
  the one-way / punching shear checks were not shown at all.
- **Root cause:** the labels were hard-coded strings from before the load-combination rewrite; the
  footing page reused the "Bearing" line for the overall verdict and never printed the shear checks.
- **Fix:** `Services/Export/PdfReportService.cs`, `PdfReportService.ContinuousBeams.cs`,
  `PdfReportService.Footings.cs` — new `UltimateCombinationLabel(...)` prints the governing
  combination reported by the analysis (e.g. "1.2G + 1.5Q", "1.35G", "0.9G + Wu"), falling back to
  "ULS". Cantilever ultimate reactions now use the enveloped value instead of a hand-rolled
  1.25G+1.5Q. Pad-footing pages now show a **STRENGTH CHECKS** table (one-way + punching shear with
  demand/capacity/ratio) plus an overall **"Result: PASS/*NG*"** line; the "Bearing:" line now
  reflects the bearing check only. Existing visual style kept.
- **Test:** `PdfReportServiceTests` — `UltimateCombinationLabel_*` (governing combo / "ULS"
  fallback) and a render smoke test for a project whose beams carry non-standard governing combos.
  (Full PDF text extraction is impractical — QuestPDF compresses the text stream — so the label
  seam every composer routes through is asserted instead.)
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Design a beam with dead + live load, Export → PDF: the ultimate reaction row and moment column
     should read **"1.2G + 1.5Q"**, not "1.25G+1.5Q".
  2. Delete the live load → those labels should switch to **"1.35G"**.
  3. Add a wind uplift load → the label should be able to read **"0.9G + Wu"**.
  4. Export a pad footing sized so it fails in shear → the footing page should now list separate
     one-way and punching shear lines and an overall **"Result: *NG*"** (not just a "Bearing" line).
- **Still at risk:** the footing and external-angle engines keep their own design bases deliberately;
  the printed label follows whatever governing combination the engine reports.
- **Status:** AWAITING TIM'S TEST

---

### WP8 — Continuous-beam design: "temporary" adapter investigated, resolved (no calc change) (2026-07-17)
- **Gap filled:** Continuous-beam member sizing was done by an inline block in the ViewModel that
  the comments flagged as "temporary" — it reused the simple-beam design engine on the continuous
  results and had no test.
- **Investigation outcome:** the continuous analysis **already** produces the correct design
  envelope for a single prismatic member — the worst of the span sagging and the internal-support
  hogging moment, the worst shear, and the governing (longest) span's deflection — and the
  simple-beam design engine already consumes exactly those. **No calculation change was needed.**
  The untested inline adapter was extracted into a proper, tested service.
- **Fix:** new `Services/Design/ContinuousBeamDesignService.cs` (pure `BuildSimpleBeamDesignInput`
  adapter); `ViewModels/ContinuousBeamDesignViewModel.cs` now calls it instead of building the
  throwaway objects inline.
- **Test:** new `ContinuousBeamDesignServiceTests` (3 tests) proving the continuous envelope is
  carried into the design input — including that support **hogging** is not lost to span sagging
  and the **longest** span drives the deflection limit.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Open/create a 2-span continuous beam with a UDL → it should pick the **same** member as
     before (this was a tidy-up, not a calculation change).
  2. Make one span much longer than the other → the deflection check should reference the longer
     span.
  3. Switch the material between timber and steel → it should still size a member.
- **Still at risk:** none in the calculation — continuous design still relies on the shared
  simple-beam engines by design.
- **Status:** AWAITING TIM'S TEST

---

### PHASE0-A1 — Data-driven AS/NZS 1170.0 load combinations + wind/seismic as first-class load cases (2026-07-17)
- **Symptom:** The app designed every beam with a non-standard 1.25G+1.5Q combination, treated
  wind/seismic loads as live load Q, and NEVER checked the 0.9G+Wu wind-uplift case — a beam
  holding a roof down in an uplift wind event was never verified for it.
- **Root cause:** Combinations were hard-coded scalars (1.25/1.5) scattered through the analysis
  engines; LoadType only knew DeadG/LiveQ; ComputeWindPressure took Math.Abs of Cfig so uplift
  lost its sign; TimberMember.ComputeS1 used a non-standard formula (Lay·d/b²) instead of
  AS 1720.1 Eq 3.2(4).
- **Fix:** New `Models/Loads/LoadCombination.cs` (immutable combination record + PsiFactors
  presets + the six Cl 4.2.2 combinations + Table 2.3 k1 map). `LoadCombinationService` rewritten
  data-driven. LoadType gains WindW/SeismicE (appended — old files still load). Simple/cantilever/
  continuous engines accumulate separate G/Q/W/E envelopes and envelope all six combinations
  (new MinMomentUltimate_kNm + GoverningCombination/GoverningUpliftCombination + per-combination
  envelopes). Wind pressure keeps the sign of Cfig. Timber design checks every combination with
  duration-matched k1 and uses Eq 3.2(4)/(5)/(7) slenderness incl. the uplift (bottom-edge
  compression) case. Steel design consumes the new envelope and checks |M−| at an uplift
  effective length (new SimpleBeam.UpliftEffectiveLength_m, default full span). Cascade now
  propagates reactions per case (G→G, Q→Q, W→W, E→E — uplift flows as negative W). Frame engine
  ULS list replaced with the same six combos. DesignSettings: firm deflection limits
  (Floor 600/300/250, Roof 500/250/200, Cantilever 400/200/150), MaxUtilisation 0.95, tributary
  width 0.6 m, LoadingCode "AS/NZS 1170.0:2002".
- **Test:** `As1170EnvelopeTests`, `CascadePropagationTests`, `LoadTypeSerializationTests`,
  new S1/k1 tests in `TimberDesignEngineTests`, rewritten `LoadCombinationServiceTests`;
  updated superseded 1.25 expectations. 361/361 passing.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Simple beam, 4 m span, Floor: G=5 kN/m + Q=3 kN/m → Output tab must show M* = 21.0 kN.m
     and "Governing Combo: 1.2G + 1.5Q" (was 21.75 under the old 1.25 factor).
  2. Same beam, delete the Q load → governing combo must switch to "1.35G".
  3. Add a Wind (W) UDL of −4 kN/m to a beam with G=1 kN/m (use the W type in the load-type
     dropdown — new W and E entries) → the envelope must go negative (uplift) and the governing
     combo must read "0.9G + Wu"; a timber member that passed gravity may now fail — that is
     correct behaviour.
  4. Wind/Seismic calculator: enter Cpe=−0.9, Cpi=+0.2 (roof suction) → the created wind UDL
     must arrive NEGATIVE, not positive.
  5. Link a child beam carrying wind onto a parent (cascade) → the parent must receive a
     separate negative W point load, not a bigger Q load.
  6. Open an OLD .cebeam file saved before this change → all loads must still show their
     G/Q types correctly.
  7. Timber: a 240x45 MGP10 with restraints at 3.0 m — capacity should INCREASE vs the old
     build (old S1 formula was wildly conservative: k12 ≈ 0.003 vs correct 0.616).
  8. Deflection limits changed to firm policy (Floor L/600 G, L/300 Q, L/250 G+Q etc.) —
     members near the old limits may change pass/fail status.
- **Still at risk:** PDF report labels still say "1.25G+1.5Q" (PdfReportService is owned by the
  report work package — reconcile under WP8). Footing engines still use the legacy 1.25 helper
  deliberately (their own work package). External angle keeps its serviceability basis
  deliberately. Beam sketch skips drawing negative (uplift) loads — rendering only, numbers
  correct.
- **QUESTION FOR A FIRM ENGINEER — timber ρb database values vs AS 1720.1 Table 3.1
  (seasoned):** MGP10 database 0.73 vs standard 0.75 (**slightly unconservative** — higher
  k12); MGP15 0.94 vs 0.91 and F17 1.07/1.08 vs 0.98 and F27 1.17 vs 1.08 (all conservative).
  Values NOT changed — confirm the intended source (Appendix E r-dependent values vs Table 3.1)
  before correcting. Tracked for WP8/validation pack.
- **Status:** AWAITING TIM'S TEST

---

### PHASE0-A3 — Steel web shear check added + capacity data locked to ASI DCT (2026-07-17)
- **Symptom:** Steel beams were never checked for shear — a short, heavily-loaded steel beam
  (e.g. a transfer beam or a lintel under a pier) could pass in the app while being
  shear-governed in reality.
- **Root cause:** `SteelDesignEngine` hard-set `ShearCapacity_kN = double.MaxValue` in two
  places, so shear could never fail.
- **Fix:** `Models/Members/SteelSection.cs` gained web geometry (d, tw, tf, fyw) + `ComputePhiVv()`
  per AS 4100 Cl 5.11 (φVv = 0.9·αv·0.6·fyw·Aw, Aw = d·tw, slender-web αv reduction).
  `SteelSections.json` given web data for all 51 rolled UB/UC/PFC sections in the ASI extract.
  `SteelDesignEngine.cs` now computes real φVv and rejects sections failing shear in auto-design.
  Sections with no tabulated web data (compound/plate/welded, ~280) report shear "not evaluated"
  with a warning — NOT a silent pass. NEW golden-value suite `SteelCapacityGoldenValueTests`
  locks the app's φMb table AND φVv to published ASI DCT values (Grade 300) for 16 sections.
- **Test:** `SteelCapacityGoldenValueTests` (φMb 64 cases + φVv 16, ±3%), extended
  `SteelDesignEngineTests` (shear-governed rejection + hand calc). 456/456 passing.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Create a SHORT steel beam (say 1.5 m span) with a big central point load (say 300 kN).
     Auto-design should now pick a heavier section than the old build (shear now governs) — this
     is correct.
  2. A normal-length beam should pick the same section as before (bending/deflection still
     govern) — the change only bites when shear matters.
  3. Pick a compound section (e.g. "150 x 75 PFC + 100 x 100 x 6 EA") — the output should show a
     shear WARNING ("not evaluated"), telling the engineer to check shear by hand.
  4. Golden data: the app's steel capacities now match the ASI Design Capacity Tables — no
     action, just confidence.
- **Still at risk:** only rolled UB/UC/PFC have web data (51 of ~330 sections); the rest need
  web data added before their shear can be auto-checked (backlog).
- **Status:** AWAITING TIM'S TEST + ENGINEER REVIEW

---

### PHASE0-A6 — PDF report omitted continuous beams and footings (2026-07-17)
- **Symptom:** The exported PDF design report (the legal calc record) silently left out
  continuous beams, pad footings and combined footings — only simple beams, cantilevers and
  external angles were printed, even though all six types are designed in the project.
- **Root cause:** `PdfReportService.GenerateMasterPdf` collected only three of the six element
  lists from the project.
- **Fix:** `Services/Export/PdfReportService.cs` + new partials `PdfReportService.ContinuousBeams.cs`,
  `PdfReportService.Footings.cs`. All six element types now get report pages; facesheet
  schedule renamed "Element Schedule" and shows real PASS/NG status for every type.
- **Test:** `PdfReportServiceTests` (7 tests: element collection, ordering, full-render smoke
  tests). 281/281 passing after change.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Open a project containing at least one continuous beam, one pad footing and one combined
     footing (plus a simple beam).
  2. Export → Export PDF Report.
  3. Check the facesheet "Element Schedule" lists every element with a PASS/NG status —
     no "-" for footings.
  4. Check each continuous beam has its own page: spans, loads, support reactions, moment
     summary, checks.
  5. Check each footing has its own page: loads, bearing check with ratio, adopted size.
  6. Edge case: export a project with a footing that has NO design result yet — must not crash.
- **Still at risk:** combination labels on the PDF still show the old "1.25G+1.5Q" wording
  until PHASE0-A1 lands and the labels are reconciled (tracked under WP8).
- **Status:** AWAITING TIM'S TEST

---

### FEATURE — 3D Structure tab visual upgrade (2026-07-17)
- **Gap filled:** Tim asked for the 3D modelling to be "better visually and more refined". The
  old view drew plain single-colour tubes with no supports/loads/results visualisation.
- **Fix:** `Views/Controls/Frame3DSceneBuilder.cs` split into 5 files (core, glyphs, results,
  math, theme) + reworked `Frame3DView.xaml`. Members colour-coded by type and batched for
  speed; support glyphs (cube=fixed, cone=pinned); crimson load arrows incl. UDL rows;
  deflected-shape overlay with scale slider; force-colour mode (moment / axial) with legend;
  three-point lighting, ground grid, isometric camera with zoom-extents.
- **Test:** `Frame3DSceneMathTests` (21 tests on the pure math). Rendering itself is
  visual-only — Tim verifies.
- **Date:** 2026-07-17
- **What Tim should test in the app (Structure tab):**
  1. Load/create a portal frame (Quick Setup → Portal Frame), add a UDL, run analysis.
  2. Check members are coloured by type (columns slate, rafters light-blue) and supports show
     as cones/cubes at the base.
  3. Check load arrows point the right way and UDLs show as arrow rows.
  4. Tick "Deflected" — a translucent green deflected shape should overlay; drag the scale
     slider and confirm it exaggerates.
  5. Switch Force Colour to Moment |M| and Axial N — members recolour, legend updates
     (axial is blue=compression / red=tension — CONFIRM the legend reads correctly).
  6. NOTE: the old "Deformed" radio is now a "Deflected" checkbox that works in any mode;
     force diagram colours changed to blue-white-red.
  7. Spin/zoom a ~50-member model — should stay smooth.
- **Still at risk:** none in calc engines (view-only change). If the Structure tab misbehaves,
  the calc results are unaffected.
- **Status:** AWAITING TIM'S TEST

---

### PHASE0-A7 — Footing engines: AS 3600:2018 minimum steel + shear checks added (2026-07-17)
- **Symptom:** Pad/combined footing design used a superseded minimum-steel rule (1.4/fy),
  never checked one-way (beam) shear or punching shear, and factored loads with the
  non-standard 1.25G+1.5Q. A heavily loaded pad could pass on bearing alone while failing
  in punching — unsafe.
- **Root cause:** engine replicated the old 02_FOOTINGS.xlsm logic only.
- **Fix:** `Services/Design/PadFootingDesignEngine.cs` + `CombinedFootingDesignEngine.cs`
  rewritten with shared `As3600FootingChecks`: min steel Cl 8.1.6.1(2) (αb=0.20,
  f'ct.f=0.6√f'c), one-way shear Cl 8.2.4.3 (kv ≤ 0.10, φ=0.70) at d from column face both
  directions, punching Cl 9.3.3 (fcv=0.17(1+2/βh)√f'c ≤ 0.34√f'c, φ=0.70),
  N* = max(1.2G+1.5Q, 1.35G). Soil bearing stays unfactored G+Q vs allowable (geotech
  practice, unchanged). New footing inputs: f'c (default 25 MPa), column/support size
  (default 90 mm timber post). Auto-design grows depth for punching, plan for bearing/one-way.
- **Test:** PadFootingDesignEngineTests (27) + NEW CombinedFootingDesignEngineTests (17),
  hand-calc golden values in comments. 44/44 green.
- **Date fixed:** 2026-07-17
- **What Tim should test in the app:**
  1. Open/create a pad footing with a decent column load (say G=80 kN, Q=60 kN, 100 kPa soil).
  2. Output should now show THREE checks: bearing, one-way shear, punching shear — each with
     demand/capacity/ratio.
  3. Auto-design: confirm it picks a bigger/deeper footing than before for heavy loads
     (the new shear checks can govern — sizes may increase vs old projects; this is correct).
  4. Edge: set f'c to 32 and confirm capacities increase; set column size 300×300 and confirm
     punching capacity increases.
  5. Combined footing: same checks appear; punching failure reports NG rather than growing
     (depth is user input there).
- **Still at risk / open questions:**
  - Combined footing stud capacity table source UNVERIFIED — **QUESTION: where did the
    DS/TS/P2/P3 stud table (e.g. DS@2700=24.61 kN) come from? Needs a firm engineer.**
  - Pre-existing pad eccentricity UNIT BUG (kN·m added to kN·mm when horizontal load/moment
    entered) — NOT fixed here, tracked under WP8.
  - PDF footing pages still stamp the overall verdict on the "Bearing" line — label
    reconciliation under WP8.
- **Status:** AWAITING TIM'S TEST + ENGINEER REVIEW of new checks

---

### PHASE0-A5 — External angle "ultimate vs serviceability" discrepancy RESOLVED as documentation error (2026-07-17)
- **Symptom:** Code header and User Guide §8 claimed external angle design uses ultimate
  1.25G+1.5Q, but the engine compares unfactored (G+Q) against the angle capacity table.
- **Root cause investigation:** The source spreadsheet (SHEET_EXTERNAL_DUMP.txt rows 97-122)
  computes w* = (Total G + Total Q) × span and compares against a "w* allowable" HLOOKUP —
  the angle table is an ALLOWABLE (safe working load) table with the safety factor already
  embedded. The app replicates the spreadsheet correctly; the comments/guide were wrong.
- **Fix:** No calculation change. Documentation/comments to be corrected and the table basis
  stated on the PDF output (tracked under WP8). The table's original source (manufacturer /
  firm derivation) still needs Tim's confirmation — **QUESTION FOR TIM: where did the external
  angle safe-load table come from, and is it still current?**
- **Status:** NEEDS TIM'S ANSWER on table provenance

---
