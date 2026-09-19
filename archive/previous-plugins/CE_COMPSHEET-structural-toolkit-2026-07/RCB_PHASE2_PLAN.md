# Phase 2 — RCB: Reinforced Concrete Beam module (AS 3600:2018)

**Status: APPROVED by Tim 17 Jul 2026 (T1–T5 answered — see §11). Build in progress,
starting Stage 0.** (Prepared and approved 17 July 2026, Phase-2 Fable session.)

Replaces the legacy `Reinforced Concrete Beam.xls`, `04_SUSPENDED BEAM.xls` and
`SUSPENDED FOOTING BEAM version 7.xlsm` with a new **RCB element type** in CE Beam Designer,
designed to AS 3600:2018 with every check clause-referenced on the printed comp sheet.

In plain English: today the app can design timber and steel beams and concrete footings.
After Phase 2 it will also design **concrete beams** — you type in the beam size and loads
(exactly like a simple beam today), and the app works out the reinforcement bars ("3-N20
bottom bars, N10 stirrups at 200"), checks bending, shear, deflection and cracking against
the concrete standard, and prints a CE comp-sheet page for it.

---

## 1. Verified starting point (this session, 17 Jul 2026)

- Build green, **461/461 tests pass** (re-run and confirmed this session).
- Phase 0 changes are still **AWAITING TIM'S TEST** per `REGRESSION_LOG.md` — flagged
  separately; does not block writing this plan, but should be closed before an RCB release.
- All three legacy spreadsheets located, opened read-only (macros disabled) and dumped to
  `SHEET_RCB_DUMP.txt`, `SHEET_SUSPENDED_BEAM_DUMP.txt`,
  `SHEET_SUSPENDED_FOOTING_BEAM_DUMP.txt` in `CE_COMPSHEET\` (the existing dump
  convention) — full findings in §8.
- The key AS 3600-2018 formulas in §6 were **verified against the firm's PDF this
  session** (Table 2.2.2 φ values incl. the 0.75/0.70 shear split; Cl 8.1.6.1 flanged αb
  cases; Cl 8.2.4.3 simplified kv/θv and its preconditions; Cl 8.5.3.1 Ief (Bischoff
  form) + σcs; Cl 8.5.3.2 kcs; Cl 8.5.4 span/depth incl. its applicability limits).
- Inducta files exist in volume on real jobs (40+ `.rcbx` found before the search cap).
  `.rcbx` is a proprietary binary — the usable benchmark artefact is Inducta's **printed
  report PDF** from a job's `04 INDUCTA` comps folder (Tim to nominate one; see §9).
- The firm holds AS 3600-2018 (`Australian Standards\AS3600-2018.pdf`) **and** Amendment 2
  (`Australian Standards\Concrete\3600-2018-amen2.pdf`) — the amendment question is real
  and is Open Question E1 (§10).

## 2. What we build on (from the code maps made this session)

**Analysis layer (consumed unchanged, as the master plan requires):**
- `SimpleBeamAnalysisEngine` / `ContinuousBeamAnalysisEngine` produce per-case results
  (G, Q, W, E separately) at 21 stations plus the full AS/NZS 1170.0 Cl 4.2.2 ultimate
  envelopes with governing-combination labels ("1.2G + 1.5Q", "0.9G + Wu", …).
- Service-level moments per case exist (`MomentG[]`, `MomentQ[]`), so the RCB module can
  form the ψs·Q / ψl·Q service combinations itself by linear scaling. **No long-term
  (creep/shrinkage) deflection machinery exists — the RCB module adds it** (kcs method).
- Deflections are delivered as virtual-work integrals (kN·m³); the steel engine's
  conversion hard-codes E = 200 000 MPa. RCB needs its own conversion with Ec·Ief.
- **Self-weight is NOT auto-added for beams** anywhere in the app. The RCB module must add
  concrete self-weight itself (b×D×24 kN/m³ as a G UDL) — significant for concrete.

**Design layer:** engines follow one pattern — `Design(model)` reads `model.AnalysisResults`,
computes on locals, returns a fresh result object, and writes back to the model in a single
deliberate block (see `PadFootingDesignEngine`). RCB follows the same pattern.

**Reusable AS 3600 helper:** `As3600FootingChecks` (internal static, in
`Services/Design/PadFootingDesignEngine.cs`) already implements f'ct.f = 0.6√f'c, min
flexural steel Cl 8.1.6.1(2), dv = max(0.72D, 0.9d), the **no-fitments** kv, and punching
shear. It is footing-tuned (85 mm cover baked in, no bending φ, no fitments path).
**Plan: extract a shared `As3600` helper** (parameterised by cover/d, adding the
with-fitments kv = 0.15 path, θv, stress-block parameters, Ec) and have
`As3600FootingChecks` delegate to it — behaviour-preserving, existing footing tests are
the safety net.

**Integration surface:** there is no element-type enum — each type is a concrete class with
its own `List<T>` on `BeamProject`, unioned by `AllElements` (the master seam: schedule,
takeoff, PDF, API, sidebar all iterate it). Serialization is non-polymorphic
(`TypeNameHandling.None`) so a new concrete list serialises with no converter work.
The full must-touch file list is in §7.

## 3. Scope

### In scope (Phase 2)
| # | Capability | AS 3600:2018 basis |
|---|---|---|
| 1 | Rectangular + flanged (T/L) section flexure, singly/doubly reinforced | Cl 8.1 |
| 2 | Capacity reduction φ as a function of kuo; ductility limit kuo ≤ 0.36 | Table 2.2.2, Cl 8.1.5 |
| 3 | Minimum + maximum flexural steel | Cl 8.1.6.1 |
| 4 | Shear with fitments (2018 method): Vuc + Vus, Vu.max web-crushing cap | Cl 8.2 |
| 5 | Minimum shear reinforcement + fitment spacing rules | Cl 8.2.1.7, detailing clauses |
| 6 | Deflection: deemed-to-comply span/depth (quick path) AND calculated Ief + kcs | Cl 8.5.4, Cl 8.5.3 |
| 7 | Crack control (deemed-to-comply: spacing + steel-stress limits) | Cl 8.6.1 |
| 8 | Development length Lsy.t reported for adopted bars | Cl 13.1.2 |
| 9 | Bar selection (auto-design) or bar checking (user-specified bars) | — |
| 10 | Bar callout into schedule ("3-N20 B + 2-N16 T, N10-200 EW") + comp-sheet page | — |
| 11 | Load cascade participation (source and target), per-case G/Q/W/E reactions | — |
| 12 | Wind uplift / moment reversal (envelope MinMoment → top-steel check) | Cl 8.1 + 1170.0 4.2.2(e) |

**Span configurations (per Tim's T2 answer):**
- **Increment A — single span** (pin/pin — the dominant residential case and what
  `Reinforced Concrete Beam.xls` does): build stages 0–8. **Ships and validates on its
  own** before continuous work starts.
- **Increment B — 2–3-span continuous**: build stage 9, consuming
  `ContinuousBeamAnalysisResults` directly (it retains per-span arrays and support
  moments; the existing `ContinuousBeamDesignService` adapter collapses to one prismatic
  member and is NOT suitable for RC, which needs different top/bottom steel per region).
  If Increment A reveals scope creep, A still ships and B becomes Phase 2.1.

### Out of scope (documented, revisit later)
- Torsion (Cl 8.3) — rare in the firm's residential beams; flagged NG-with-warning if the
  user's geometry implies it (edge beams supporting one-sided slabs get a report note).
- Full automated bar curtailment along the span (21-station resolution is too coarse);
  v1 prints Lsy.t + standard detailing notes instead.
- Prestress/PT, fire design, fatigue, strut-and-tie (deep beams get a span/depth guard:
  a/d < 1.5 → "outside beam theory — strut-and-tie required, not covered" warning).
- Soil-supported footing beams on continuous soil springs (beam-on-elastic-foundation).
  The legacy "SUSPENDED footing beam" spans pier-to-pier and IS covered (it is an RC beam
  with soil/wall loads); a raft-style stiffened-slab beam is not. (Open Question E8.)

## 4. Data model (new files, immutable-result pattern)

`Models/Beams/ReinforcedConcreteBeam.cs` — `class ReinforcedConcreteBeam : StructuralElement`
(`ElementTypeCode = "RC"` internally; **marks per Tim's T3 answer:** `MarkRole` property =
EdgeBeam ("EB", default) / InternalBeam ("IB"), user-selectable per beam, feeding
`BeamMarkGenerator` — never FB/RB/L/LRB/GL/PB, which are framing marks):
- **Geometry:** `Span_mm`, `SectionShape` (Rectangular/TFlange/LFlange), `WebWidth_mm` (bw),
  `Depth_mm` (D), `FlangeThickness_mm` (Ds), `FlangeWidthMode` (AutoCl882/Manual),
  `FlangeWidth_mm` (bef when manual), support widths (for shear critical section),
  `LeftConnection`/`RightConnection` (reuse existing enums), `DeflectionCategory`.
- **Materials:** `Fc_MPa` (dropdown 20/25/32/40/50/65), `ExposureClass` (A1/A2/B1/B2),
  `Cover_mm` (defaulted from exposure per Table 4.10.3.2 data, user-overridable),
  `AggregateSize_mm` (default 20).
- **Reinforcement:** `DesignMode` (AutoDesign / CheckSpecifiedBars); when checking:
  `BottomBars` / `TopBars` (`BarGroup`: count, diameter, layers), `Fitments`
  (diameter, legs, spacing). `IncludeSelfWeight` (default true).
  **Reinforcement class matters:** the legacy suspended-footing-beam sheet designs with
  **trench mesh (3L12TM etc. — Class L steel)**, and the firm's EB-mark footing beams adopt
  it on real jobs. The model therefore supports `ReinforcementKind` = D500N bars **or**
  trench mesh (L-wire sizes from the legacy lookup), and the engine applies the Class L
  consequences automatically: φ bending capped at 0.65 (Table 2.2.2(b)(ii)) and the
  standard's restrictions on Class L use (Open Question E10).
- **Loads:** `List<UdlLoad>` + `List<PointLoad>` — identical surface to `SimpleBeam`, so
  the analysis engines and cascade wiring work unchanged.
- **Results:** `AnalysisResults?` + `RcbResult?` (footing-style rich result object).

`Models/Results/RcbResult.cs` — immutable-in-practice result: per-check
`RcbCheckResult { ClauseRef, Demand, Capacity, Ratio, Passes, Detail }` for flexure (+ve
and −ve), shear, min/max steel, deflection (short/long/total vs limits), crack control,
plus `AdoptedBars` (bottom/top/fitments), `BarCalloutText`, `Lsy_t per bar size`,
`GoverningCombination`, `SizeDescription` ("300×600 RC BEAM — 3-N20 B, 2-N16 T, N10-200"),
`Passes`, `Warnings[]` (torsion note, deep-beam note, side-face reo for D ≥ 750).

**Standards data (data-driven, edition-tagged, per master-plan rule):**
`Resources/Databases/As3600Rcb.json` — loaded by a small `ConcreteStandardsService`
following the existing `TryLoadDatabase` pattern in `App.xaml.cs`:
- Concrete grades: f'c → Ec (Table 3.1.2), f'ct.f rule, α2/γ stress-block parameters rule.
- Reinforcement: D500N bar table (db, area, mass/m), fitment sizes, standard spacings.
- φ factors (Table 2.2.2) **with edition tag** ("AS3600-2018+A1") — φbending(kuo) Class N,
  0.65 Class L, φshear 0.75 (conforming fitments) / 0.70 (otherwise, and web crushing).
- Crack-control steel-stress tables 8.6.1(A) (by bar diameter) and 8.6.1(B) (by spacing).
- Cover-by-exposure defaults (Table 4.10.3.2 for f'c/exposure combinations).
- Design shrinkage strain εcs default for Melbourne (Cl 3.1.7; Open Question E5).

## 5. Engine design (all pure/static core, orchestrated by one engine)

To respect the 800-line file cap and keep every formula unit-testable in isolation:

```
Services/Design/Concrete/
├── As3600.cs                  ← shared constants/formulas (extracted from As3600FootingChecks)
├── RcbFlexure.cs              ← stress block, ku, Muo, φ(kuo), min/max steel, T/L logic
├── RcbShear.cs                ← kv, θv, Vuc, Vus, Vu.max, Asv.min, spacing rules
├── RcbServiceability.cs       ← Ec, Igross/Icr, Mcr (incl. shrinkage σcs), Ief, kcs,
│                                 deflection from integrals, span/depth deemed-to-comply
├── RcbCrackControl.cs         ← Cl 8.6.1 deemed-to-comply checks
├── RcbDetailing.cs            ← bar fitting (cover/spacing/layers), Lsy.t, callout text
├── RcbBarSelector.cs          ← auto-design search over the bar palette
└── RcbDesignEngine.cs         ← orchestrator: model → analysis adapter → checks → RcbResult
```

`RcbDesignEngine.Design(ReinforcedConcreteBeam beam)`:
1. Build the analysis input: construct the throwaway `SimpleBeam` (or use
   `ContinuousBeamAnalysisEngine` in Stage 2) from the RCB's span/loads, **adding the
   self-weight G UDL** (bw×D×24 kN/m³; flanged: web + flange rectangle) when
   `IncludeSelfWeight` — with a guard note on the input view so users don't double-enter it.
2. Run the existing analysis engine → per-case arrays + ultimate envelopes.
3. Run checks (below), auto-designing bars first if `DesignMode = AutoDesign`
   (auto-design changes Ast which changes nothing in analysis — section size is fixed by
   the user, so ONE analysis pass suffices; self-weight depends only on b×D).
4. Return a fresh `RcbResult`; single write-back block sets `beam.RcbResult`,
   `beam.SelectedMember` (for the schedule string) — same discipline as the footing engine.

**Section positions used:** M*max (+ve) at its station with T-flange action; M*min (−ve,
uplift/hogging) checked with rectangular-web action and top steel; V* taken at the support
face station or conservatively the support-centreline maximum (per-station `ShearUltimate[]`
exists for simple beams); Ief evaluated with Ms at midspan (Cl 8.5.3 short-term service
combination), per-span for continuous.

## 6. The clause-by-clause engineering (formulas as implemented)

Every formula below is re-verified **verbatim against the firm's AS 3600-2018 PDF during
the build stage that implements it** (the Phase-0 WP5 discipline), and each lands with a
hand-calc golden test. Symbols: b = compression-face width, bw = web, D = overall depth,
d = effective depth to tension-steel centroid, do = depth to outermost tension layer.

**Flexure (Cl 8.1):**
- Stress block (Cl 8.1.3): α2 = 0.85 − 0.0015·f'c ≥ 0.67; γ = 0.97 − 0.0025·f'c ≥ 0.67;
  εcu = 0.003.
- Singly reinforced equilibrium: dn = Ast·fsy / (α2·f'c·γ·b); ku = dn/d;
  Muo = Ast·fsy·(d − γ·dn/2).
- Doubly reinforced: strain-compatibility check on Asc (εsc = 0.003(dn−dsc)/dn vs
  fsy/Es, Es = 200 000); iterate dn.
- Flanged (Cl 8.8.2): bef = bw + 0.2a (T) / bw + 0.1a (L), a = distance between points of
  zero moment (single span: a = L), capped by available slab width; if γ·dn ≤ Ds the
  section computes as a rectangle of width bef, else flange-overhang + web decomposition.
  Hogging (flange in tension): rectangular web bw.
- φ (Table 2.2.2, **verified in the firm's PDF**): Class N: φ = 1.24 − 13·kuo/12, bounded
  0.65–0.85 (= 0.85 at kuo ≤ 0.36). Class L (trench mesh): φ = 0.65 flat.
- Ductility (Cl 8.1.5): kuo ≤ 0.36 enforced — auto-design adds compression steel or fails
  the section with a "deepen the beam" message rather than accepting a brittle section.
- Min steel (Cl 8.1.6.1, verified): Ast.min = αb·(D/d)²·(f'ct.f/fsy)·bw·d; αb = 0.20
  rectangular; flanged αb has two verified cases (web in tension / flange in tension —
  formulas in the firm's PDF p.111; exact transcription at build since the PDF equation
  layout needs care); f'ct.f = 0.6√f'c (Cl 3.1.1.3). *Reuses the extracted `As3600`
  helper (§2).*

**Shear (Cl 8.2, 2018 method, simplified Cl 8.2.4.3 — formulas verified in the firm's PDF):**
- dv = max(0.72·D, 0.9·d); bv = bw.
- Vuc = kv·bv·dv·√f'c, √f'c ≤ 8.0 MPa.
- **[UPDATED 17 Jul 2026 — design basis moved to AMENDMENT 2 (E1 answered); A2 pages
  verified as rendered images]:**
- kv = 0.15 and θv = 36° **with** at least minimum fitments (A2 Cl 8.2.4.3(2));
  kv = 200/(1000 + 1.3·dv) **≤ 0.15** without (A2 Cl 8.2.4.3(1) — A2 raised the ceiling
  from 0.10). **Simplified-method preconditions become code guards** (A2 Cl 8.2.4.1):
  non-prestressed, no axial tension, **no torsion** (A2 addition), fsy ≤ 500 MPa,
  f'c ≤ 65 MPa, aggregate ≥ 10 mm.
- Vus = (Asv/s)·fsy.f·dv·cot θv (vertical fitments, Cl 8.2.5.2 unchanged by A2);
  Vu = Vuc + Vus.
- Web-crushing cap (A2 Cl 8.2.3.3(1), clause rewritten): Vu ≤ Vu.max =
  0.55·[**0.9**·f'c·bv·dv·cotθv/(1 + cot²θv)] (≈ 0.235·f'c·bv·dv at θv = 36°; the 0.9 is
  new in A2) — a hard fail that no amount of stirrups fixes.
- Asv.min/s = 0.08·√f'c·bv/fsy.f (Cl 8.2.1.7, equation unchanged by A2). Fitments are
  mandatory where **V* > ks·φ·Vuc** (A2 Cl 8.2.1.6(1): ks = 1.0 for D ≤ 300;
  (1000 − D)/700 for 300 < D < 650; 0.5 for D ≥ 650 — the rational-calculation ks = 1.0
  concession is NOT taken) or **D ≥ 750** (8.2.1.6(3)).
- Fitment spacing (A2 Cl 8.3.2.2): min(0.5·D, 300) at any depth (the V* ≤ Vu.min
  relaxation to min(0.75·D, 500) is NOT taken — conservative); first fitment ≤ 50 mm from
  the support face (Cl 8.3.2.3).
- A2 Cl 8.2.7 ΔFtds (additional longitudinal tension from shear truss action, feeding the
  Cl 8.2.8 anchorage-at-support requirement): **engine primitives implemented + golden-
  tested** (`RcbShear.DeltaFtds_kN` — half-term 0.5·(V* + φVuc) capped at V*, then ×cotθv;
  `AnchorageSteelForDeltaFtds_mm2`). **Assembly (compare vs bottom steel continued to the
  support + comp-sheet line) = Opus Stage 6 step 4a** per the handoff prompt; validation
  pack worked example due Stage 10.
- **φ shear (Table 2.2.2(e), verified in the firm's PDF): 0.75 where Class N fitments
  meeting Cl 8.2.1.7 are provided; 0.70 otherwise; and always 0.70 for the web-crushing
  (Vu.max) limit.** The kickoff's blanket φ = 0.70 was a conservative simplification —
  we implement the standard's split. (`As3600FootingChecks`' 0.70 stays correct: footings
  have no fitments.)

**Deflection (Cl 8.5):**
- Quick path — deemed-to-conform span/depth (Cl 8.5.4, verified):
  Lef/d ≤ [k1·(Δ/Lef)·bef·Ec / (k2·Fd.ef)]^(1/3); Fd.ef = (1.0 + kcs)·g + (ψs + kcs·ψl)·q
  (total) or kcs·g + (ψs + kcs·ψl)·q (incremental); k1 = Ief/(bef·d³) and k2 (5/384 SS,
  continuous values) per the clause's closed forms. **Applicability guards (verified):
  uniform section, fully propped, UDL only, and q ≤ g** — outside them the engine uses the
  calculated path only.
- Calculated path (Cl 8.5.3, the default on the comp sheet — **formulas verified in the
  firm's PDF this session**):
  - Ec per Table 3.1.2 (data), Ig gross, Icr cracked-transformed (modular ratio n = Es/Ec).
    (Legacy sheets plug f'c straight into the Ec formula instead of fcmi/table values —
    a known conservative difference to explain in benchmarks.)
  - Mcr.t = Z·(f'ct.f − σcs) ≥ 0 with σcs = [(2.5·pw − 0.8·pcw)/(1 + 50·pw)]·Es·εcs
    (verified, Cl 8.5.3.1); εcs per Cl 3.1.7 (Open Question E5).
  - **Ief = Icr / [1 − (1 − Icr/Ig)·(Mcr.t/Ms*)²] ≤ Ief.max** (verified — 2018 uses this
    Bischoff form; the legacy Bondek sheet uses Branson's cubic, an expected explainable
    benchmark difference). Ief.max = Ig (p ≥ 0.005) or 0.6·Ig (p < 0.005); Ms* from the
    short-term service combination. The clause's closed-form alternative Eq 8.5.3.1(2)/(3)
    is available as a cross-check in tests.
  - Short-term δs from the existing deflection integrals with Ec·Ief, load = g + ψs·q
    (integrals are linear in load: δ(g + ψ·q) = δG + ψ·δQ).
  - Long-term extra: δl = kcs·δsus with load g + ψl·q and kcs = 2 − 1.2·(Asc/Ast) ≥ 0.8
    (Cl 8.5.3.2). Total = δs + δl vs the firm's limits (Open Question E4).
- ψs/ψl from the existing `PsiFactors` presets (Floors 0.7/0.4, Roofs 0.7/0).

**Crack control (Cl 8.6.1, deemed-to-comply):** min steel per 8.1.6.1; bar spacing ≤ 300 mm
c/c near the tension face; ≤ 100 mm from side/soffit to nearest bar; steel stress σs under
service loads (cracked-section analysis, short-term combo) ≤ the larger of Table 8.6.1(A)
(by db) and 8.6.1(B) (by spacing) limits — both tables shipped as data.

**Development (Cl 13.1.2.2):** Lsy.tb = 0.5·k1·k3·fsy·db/(k2·√f'c) ≥ 0.058·fsy·k1·db;
k1 = 1.3 horizontal bar with ≥ 300 mm concrete below else 1.0; k2 = (132 − db)/100;
k3 = 1 − 0.15(cd − db)/db ∈ [0.7, 1.0]. Printed per adopted bar size with standard
curtailment notes (bottom bars: ≥ 50% to supports + cog rule guidance).

**Bar fitting (detailing):** min clear spacing max(25 mm, db, agg + 5 mm — verified at
build); layers stack with 25 mm clear; d recomputed from actual bar layout (not assumed);
side-face reinforcement note for D ≥ 750 (Cl 8.6.3 area rule extracted at build).

**Auto-design search (`RcbBarSelector`):** section b×D is user-fixed. Bottom steel: smallest
palette combination (preferring fewer/larger bars, single layer) with Ast ≥ max(Ast.req
for M*+, Ast.min) that fits the width and passes crack control; top steel likewise for
M*− (uplift/hogging) or 2 hanger bars minimum; fitments: smallest diameter/widest spacing
meeting V*, Asv.min and spacing caps. Fail states name the binding constraint ("ku > 0.36 —
increase D or add compression steel"; "Vu.max exceeded — increase bw or D").

## 7. Integration plan (exact must-touch list from the code map)

| File | Change |
|---|---|
| `Models/Project/BeamProject.cs` | `List<ReinforcedConcreteBeam> RcbBeams` + `.Concat` in `AllElements` (lights up schedule/takeoff/PDF/API/sidebar) |
| `ViewModels/MainWindowViewModel.cs` | Add command; cases in Delete, Duplicate ×2, InsertBeamAtPosition ×2, UpdateTargetCascadeLoads, Copy/Paste loads, templates |
| `MainWindow.xaml` | Toolbar button, Ctrl+7 gesture, Input + Output DataTemplates |
| `Services/Cascade/LoadCascadeService.cs` | `GetCaseReactions` case (RCB as load source — per-case G/Q/W/E reactions already exist on `AnalysisResults`). **Watch-out: this switch defaults to silent zeros — an explicit test asserts RCB reactions flow.** |
| `Services/Export/PdfReportService.cs` + new `PdfReportService.Rcb.cs` partial | `ComposeBeamPage`/`GetScheduleMemberText`/`GetOverallPassStatus` cases + the RCB page composer |
| `Services/MarkGeneration/BeamMarkGenerator.cs` | Prefix case (mark series — Tim decision T3) |
| `Models/Schedule/TakeoffEntry.cs` | RCB case (span + new "Concrete" material category) |
| `Services/Api/ApiRequestHandler.cs` | `element_counts` + `GetSpan`/`GetMaterial` cases |
| `App.xaml.cs` + `ServiceLocator` | Load `As3600Rcb.json` via new `ConcreteStandardsService` |
| Tests: `PdfReportServiceTests` (six→seven types), `ProjectFileRoundTripTests` (+RCB), `LoadCascadeService` tests (+RCB reactions) | as listed |

New files: the §5 engine set, `Models/Beams/ReinforcedConcreteBeam.cs`,
`Models/Results/RcbResult.cs`, `Views/RcbInputView.xaml(.cs)`,
`ViewModels/RcbDesignViewModel.cs` (PadFooting VM pattern: `[ObservableProperty]` mirrors,
debounced recalculate, `SaveToModel()` → engine → apply), `Resources/Databases/As3600Rcb.json`,
`tests/…/Rcb*Tests.cs`.

**Comp-sheet page (production format per `PROJECTS_REVIEW_2026-07-17.md`):** CE header
block; section diagram values (b×D, cover, bars); loading breakdown; reaction/moment table
(G, Q, G+Q, ultimate + governing combination label); STRENGTH CHECKS table (flexure ±,
shear, min steel — demand/capacity/ratio/clause); SERVICEABILITY table (deflections vs
limits, crack control, σs); development lengths; yellow ADOPT box with the bar callout.

## 8. What the legacy spreadsheets actually do (dumped + analysed this session)

| Sheet | Edition | Checks | Notable |
|---|---|---|---|
| `Reinforced Concrete Beam.xls` | **AS 3600-2001** (labelled in-sheet) | Bending (strain-compatibility, macro-solved neutral axis), old β1β2β3 Vuc shear, min/max steel | φ = 0.8 bending / 0.7 shear; γ = 0.85 − 0.007(f'c − 28); do hardcoded 0.8h; rectangular only; **no deflection, no crack control** |
| `04_SUSPENDED BEAM.xls` (CONTCONBEAM/SSCONCBEAM sheets) | AS 3600-2001 era | Flexure (quadratic ω method), dual min-steel (1.4/fsy vs 0.22-rule), 2001 Vuc, deemed-to-comply span/depth with kcs | **1.25G + 1.5Q combo**; load-takedown table (Roof/Wall/Slab/Floor kPa × width) + auto self-weight — the input UX to preserve; outputs trench-mesh callouts ("3L12TM TOP") |
| `SUSPENDED FOOTING BEAM version 7.xlsm` | **AS 3600-2018** (kv method, α2/γ, ku ≤ 0.36, 1.2G+1.5Q) | Flexure, min steel, ductility, kv shear + web crush | **TWO verified unconservative defects** (confirmed from the sheet's cells, 17 Jul 2026 — see `docs/E11_ENGINEER_NOTE.md`): (1) bending applies **no φ** — sheet is mesh-only (Class L, φ = 0.65) so it permits **+54%** moment vs code; (2) **kv cap inverted** — `MAX(kv, 0.1)` where Cl 8.2.4.3 requires kv ≤ 0.10 → **Vuc overstated ~33%** on every beam (shear φ 0.7 itself is applied correctly). Also: fsy 450 (mesh); d = D − cover − 18 hardcoded; no deflection/crack checks |

Consequences already folded into this plan: the load-takedown input style (§7 comp-sheet
+ input view), trench-mesh/Class L support (§4, E10), and the benchmark-difference
ledger below. None of the three sheets checks crack control and only one does
(deemed-to-comply) deflection — the RCB module's serviceability checks are **new
capability**, so benchmark comparisons there lean on the textbook example and Inducta.

## 9. Test & validation plan (how this earns engineer sign-off)

1. **TDD throughout** — every formula lands as failing golden test → code → green; hand
   calc in the test comment (the `PadFootingDesignEngineTests` pattern). Target suites:
   `RcbFlexureTests`, `RcbShearTests`, `RcbServiceabilityTests`, `RcbCrackControlTests`,
   `RcbDetailingTests`, `RcbBarSelectorTests`, `RcbDesignEngineTests` (integration),
   plus the §7 regression updates. Existing 461 stay green after every stage.
2. **Benchmark A — legacy spreadsheets:** 3–5 sections run through each legacy sheet
   (dumps in `CE_COMPSHEET\`) and reproduced as golden tests, with a pre-declared
   difference ledger: 1.25G vs 1.2G combos; 2001 γ stress block vs 2018 α2/γ; φ = 0.8
   flat vs φ(kuo); 2001 β-method Vuc vs 2018 kv; dual min-steel vs Cl 8.1.6.1(2); Ec via
   f'c vs Table 3.1.2; the v7 sheet's missing bending φ (+54% for its Class L mesh); and
   the v7 sheet's inverted kv cap (`MAX(kv, 0.1)` vs the code's kv ≤ 0.10 → its Vuc reads
   ~33% high — our lower shear capacities against this sheet are CORRECT and must never be
   "tuned to match"). Every residual delta must land on one of these named ledger lines or
   be investigated as a bug.
3. **Benchmark B — Inducta:** Tim nominates one real job with a clean RC beam in its
   `04 INDUCTA` comps PDF; we reproduce its inputs and compare φMuo/Vu/deflection.
4. **Benchmark C — published worked example:** one textbook example (Warner/Foster
   *Concrete Structures* or the firm's HB 71 concrete handbook, office library) reproduced
   end-to-end as a golden test.
5. **VALIDATION_PACK.md gets a new §"RC Beams (AS 3600:2018)"** in the existing worked-
   example + sign-off-box format: one flexure hand calc, one shear, one deflection, one
   crack control, the benchmark comparison table, limitations, and the E-questions below.
6. Every stage adds its REGRESSION_LOG entry with a "what Tim should test in the app"
   checklist; PARKING_LOT/plan docs updated per the plugin-work rules.

## 10. Open engineering questions (for the firm engineer — pre-answered with safe defaults)

| # | Question | Default until answered |
|---|---|---|
| E1 | ~~Design basis: 2018(+A1) or +A2-2021?~~ **ANSWERED 17 Jul 2026: AMENDMENT 2.** Implemented: kv ceiling 0.15 (`As3600.Edition` = "AS 3600:2018 (Amdt 2, 2021)"), ks fitment trigger, A2 Vu.max (0.9 factor), A2 spacing rule. Table 2.2.2 rows (b)/(e) confirmed unamended by A2 → φ values stand | Done — see REGRESSION_LOG entries AS3600-A2 + AS3600-A2-SHEAR |
| E2 | Exposure class + cover defaults for typical suspended residential beams (internal / external) | A1 internal 25 mm, B1 external 40 mm, user-editable |
| E3 | Preferred bar palette + fitment sizes/spacings (N12–N32? N10/N12 fitments, 100–300 spacing?) | N12–N32 main, N10/N12 fitments, spacings 100–300 step 25 |
| E4 | RC deflection limits: adopt Table 2.3.2 (total Δ/Lef ≤ 1/250; incremental 1/500 where masonry) or firm table? | Table 2.3.2 values |
| E5 | Design shrinkage strain εcs for Melbourne (Cl 3.1.7) for Mcr/σcs | Clause default for the region, stated on output |
| E6 | May kcs take the Asc benefit (kcs = 2 − 1.2 Asc/Ast) or fix kcs = 2.0? | Take the benefit (it is the code formula) |
| E7 | T-beam flange: claim slab flange automatically when the user says a slab is present, or rectangular-only unless explicitly set? | Explicit user opt-in per beam |
| E8 | Suspended footing beam usage: confirm pier-to-pier suspended beams are the use case (soil-spring/raft beams stay out of scope) | As stated |
| E9 | Side-face reinforcement policy for D ≥ 750 (auto-add to callout or warning only?) | Warning + note on comp sheet |
| E10 | Trench mesh (Class L) in suspended/footing beams: the legacy sheet + real EB marks use 3L12TM etc. AS 3600 restricts Class L use and caps φ at 0.65 — confirm where the firm permits mesh vs requiring N-bars | Support both; apply Class L φ = 0.65 + the standard's restrictions; print the class on the comp sheet |
| E11 | The v7 footing-beam sheet has two verified unconservative defects (no φ on bending → +54% for Class L mesh; inverted kv cap → Vuc +33%) — see `docs/E11_ENGINEER_NOTE.md`. Any recent jobs designed on it worth a spot re-check? (Saved example sat at 14% utilisation — defects only bite near capacity.) | Tim escalating to a firm engineer now (17 Jul 2026); module supersedes the sheet |
| E12 | Mark series confirm (10 seconds): concrete beams marked **EB** (edge) / **IB** (internal) under "02 SLAB AND FOOTINGS" — inferred from 2024–2026 job filename/folder patterns. Correct? | Implemented as user-selectable EB/IB, default EB |

## 11. Decision queue — ANSWERED by Tim, 17 Jul 2026

| # | Decision | Answer |
|---|---|---|
| T1 | Approve this plan + build order (§12) | **APPROVED.** Tim independently cross-checked the §6 claims against the Phase-0 verbatim AS 3600 extraction (shear φ 0.75/0.70, Class L φ 0.65, αb 0.20) — all confirmed. The φ split does NOT invalidate Phase-0 footing work (footings have no fitments → 0.70 was the right branch). |
| T2 | Continuous spans | **YES, Stage 9 stays in this phase — but as a separate releasable increment.** Stages 0–8 (single span) ship and validate on their own first; if scope creeps, single-span ships and continuous becomes Phase 2.1. Never hold single-span hostage. |
| T3 | Mark prefix | **EB / IB, user-selectable per beam, default EB. Do NOT invent "RCB", do NOT reuse FB/RB/L/LRB/GL/PB (those are FRAMING steel/timber marks).** Evidence: real 2024–2026 jobs file concrete members under "02 SLAB AND FOOTINGS" as EB (edge beam, 96 occurrences) and IB (internal beam). Inferred from filename/folder patterns, not stated policy → 10-second engineer confirm added as E12 (§10). |
| T4 | Bar schedule depth | **CONFIRMED as recommended:** callout string in schedule + takeoff row carrying concrete volume + reo mass. Full bar-mark/cut-length schedule = later phase. Matches production comp sheets (ADOPT callout box, no bar schedule). |
| T5 | Auto-grow depth | **CONFIRMED: no auto-grow.** Concrete beam sizes are architecturally fixed; fail with the named governing constraint. (Footings legitimately differ — a pad can grow freely.) |

E11 update: Tim is escalating the v7 no-φ defect to a firm engineer now (not deferred to
module validation). The module still supersedes the sheet as planned.

## 12. Build order (each stage: failing tests → code → green → log entry)

| Stage | Deliverable | Key tests |
|---|---|---|
| 0 ✅ | `As3600` shared-helper extraction; footing engines delegate (done 17 Jul 2026 — 479/479 green, +18 `As3600Tests` goldens, REGRESSION_LOG "RCB-STAGE0") | existing footing tests unchanged ✓ |
| 1 ✅ | `RcbFlexure` (rect, singly/doubly, φ/kuo, min/max steel) — done 17 Jul, 498/498 | golden hand calcs incl. φ interpolation edge (kuo just over 0.36) ✓ |
| 2 ✅ | `RcbShear` (kv both paths, Vus, Vu.max, Asv.min) — done 17 Jul, 517/517 | golden hand calcs; no-fitment vs fitment paths; Vu.max hard-fail ✓ |
| 3 ✅ | `RcbServiceability` (Ec, Icr, Mcr+σcs, Ief, kcs, integrals, span/depth) — done 17 Jul, 549/549 | golden hand calcs; cracked vs uncracked; p < 0.005 cap ✓ |
| 4 ✅ | `RcbCrackControl` + `RcbDetailing` + `RcbBarSelector` — done 17 Jul, 587/587 | table lookups; bar-fitting geometry; selector picks documented result ✓ |
| 5 ✅ | Flanged (T/L) flexure + bef — done 17 Jul, **598/598**; flanged αb verified from rendered PDF image | flange-in-compression goldens + rectangular-equivalence ✓ (flange-in-tension = rectangular web path by design) |
| 6 ✅ | `ReinforcedConcreteBeam` model + `RcbResult` + `RcbDesignEngine` (+ `.Selection`/`.Checks` partials) + self-weight + analysis adapter — done 17 Jul, suite green; `BeamProject.RcbBeams` is named `ReinforcedConcreteBeams`; `MemberType.ConcreteRcb` appended. Two integration bugs caught (sagging-moment sign; effective depth d) — see REGRESSION_LOG "RCB-STAGE6". Parked: flanged serviceability (web-only, conservative + warned), cover E2 (only A1/B1 shipped), incremental-deflection limit E4 | `RcbDesignEngineTests` (21) incl. hand-calc golden, self-weight idempotence, uplift flipped section, sign-convention pin; RCB added to `ProjectFileRoundTripTests` ✓ |
| 7 | UI (view + VM), integration switches (§7), cascade wiring | cascade reaction test; PDF 7-type tests; API |
| 8 | Comp-sheet page + schedule/takeoff | render smoke + label seam tests |
| 9 | Stage 2 continuous spans | per-region steel goldens vs continuous results |
| 10 | Benchmarks A/B/C + VALIDATION_PACK §RCB + docs sweep | benchmark suite |

Estimated shape: stages 0–5 are pure engine work (the bulk of the engineering risk,
front-loaded); 6–8 are wiring; 9–10 close out. Each stage is independently shippable to
the test suite; nothing merges red.

**Model split (Tim, 17 Jul 2026):** stages 0–5 were built in the Fable chat (done,
598/598). **Stages 6–8 are handed to an Opus chat — launch prompt:
`docs/CHAT_PROMPTS/OPUS_PHASE2_RCB_STAGES6-8.md`.** Stages 9–10 return to a Fable chat.

## 13. Risks / watch-outs (flagged now, tracked in the log)

- **Cascade silent zeros** — the `GetCaseReactions` switch returns zeros for unknown types
  with no compile error; an explicit test guards RCB (§7).
- **Self-weight double-count** — users of the legacy sheets type self-weight manually; the
  input view labels the auto self-weight line and shows it in the loading breakdown.
- **Legacy-benchmark differences are expected** (2018 vs 2009-era methods); the validation
  pack explains each one against the clause change so the engineer sees WHY, not just a delta.
- **Phase 0 still awaits Tim's in-app testing** (whole REGRESSION_LOG). RCB release rides
  on the Phase-0-validated combination engine — those tests should be closed first.
- **A2 amendment question (E1)** changes φ values; data-driven φ means switching editions
  later is a data + revalidation change, not a code change.
