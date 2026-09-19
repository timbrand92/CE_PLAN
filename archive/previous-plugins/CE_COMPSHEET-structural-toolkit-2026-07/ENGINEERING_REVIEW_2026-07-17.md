# CE Beam Designer — Engineering Review (17 July 2026)

Reviewed: `CE_BEAM_DESIGNER` v1.0 (WPF, .NET 9) against Australian Standards practice and the
firm's coding rules. Build status at review: **0 errors, 274/274 tests passing**.

**Overall verdict:** a genuinely impressive v1 — six element types, load cascade, 3D frame
analysis, PDF/Excel reporting, sensitivity analysis, wind/seismic calculators. The software
foundations are solid. But **the calculation engine is not yet up to scratch for issued
engineering work**: it uses a non-standard ultimate load combination, never checks wind uplift,
never checks steel shear, and its steel capacity data traces back to an AS 4100-1990-era
lookup table. These must be fixed before the app's output is relied on for jobs, and before
any new toolkit modules are built on top of it.

---

## A. CRITICAL — engineering correctness (fix before relying on output)

### A1. Ultimate load combination is 1.25G + 1.5Q, not the code's 1.2G + 1.5Q
- AS/NZS 1170.0 Cl 4.2.2 gives **1.2G + 1.5Q** (and 1.35G permanent-only).
- The steel, cantilever, continuous and footing paths all use **1.25G + 1.5Q**
  (`SimpleBeamAnalysisEngine.cs:266`, `ContinuousBeamAnalysisEngine.cs:63`,
  `LoadCombinationService.cs:21`). The timber path uses 1.2G + 1.5Q. So the app is
  *internally inconsistent* as well as non-standard.
- 1.25G is conservative (safe side) but ~4% heavier on dead load than code, and un-defendable
  in a calc-check. **Decision needed from Tim:** standardise on AS/NZS 1170.0 factors, or
  document 1.25G as a deliberate firm policy. Either way, factors must come from one
  data-driven combination table, not be scattered as literals through five engines.

### A2. No wind uplift check anywhere — genuine safety gap
- Wind loads from the AS 1170.2 calculator are injected as **live load Q**
  (`WindSeismicLoadService.CreateWindUdl:54`). Consequences:
  - Wind gets a 1.5 factor. Under AS/NZS 1170.0 the wind combination is **1.2G + Wu + ψc·Q**
    — Wu is already an ultimate action; factoring it 1.5 is wrong (over-conservative downward).
  - **The 0.9G + Wu uplift combination is never checked.** For light roofs (tin roof = 0.4 kPa
    in the firm's own DESIGN LOADING.docx) uplift regularly governs member size, connection
    design and end anchorage. A roof beam can pass this app and fail in a real storm.
  - Wind deflection gets mixed into the Q serviceability check with Q's limits.
- Seismic has the same treatment (injected as Q; no E combinations).

### A3. Steel shear is never checked
- `SteelDesignEngine` sets `ShearCapacity_kN = double.MaxValue` (lines 178, 227) — shear
  literally cannot fail. Short spans with heavy point loads (transfer beams, lintels under
  piers) can be shear-governed. AS 4100 Cl 5.11 (φVv = 0.9·0.6·fy·Aw) is a few lines of code.
  Web bearing/crippling at supports and point loads (Cl 5.13) is also absent.

### A4. Steel capacity data lineage is AS 4100-1990-era and unverified
- The source spreadsheet's steel sheet is headed **"Steel Beam Design: AS4100-1990"** and gets
  φMb by HLOOKUP against effective length from a capacity table (`SHEET_STEEL_DESIGN_DUMP.txt`).
- The app reproduces this: `SteelSection.GetCapacity` interpolates tabulated φMb vs le from
  `SteelSections.json` (345 KB). The settings dialog offers "AS4100-2020 / AS4100-1998", but
  nothing in the engine actually changes with that choice — the standard selection is cosmetic.
- If the JSON was transcribed from the old sheet, the tables may assume **Grade 250** steel
  (pre-300PLUS), old section ranges, and αm = 1.0 only. Nobody has validated the JSON against
  the current ASI/ONESTEEL Design Capacity Tables — which the firm holds as PDFs in
  `Steel Framing\`. **Action: golden-value validation** — sample ~15 sections/lengths from the
  published DCTs and assert the JSON matches; correct or re-derive from AS 4100-2020 first
  principles.

### A5. External angle module: guide says ultimate, code computes serviceability
- `ExternalAngleDesignEngine` computes w* = (G + Q) × span — an unfactored serviceability
  total (line 39) — while the code header and User Guide §8 both claim 1.25G + 1.5Q.
  One of them is wrong; if the capacity table is an ultimate-capacity table, the check is
  ~35% un-conservative. **Must be resolved against the source of the angle capacity table**
  (hardcoded at lines 136-165 rather than loaded from `ExternalAngles.json`).

### A6. PDF report omits continuous beams and footings
- `PdfReportService.GenerateMasterPdf:60` collects only SimpleBeams + Cantilevers +
  ExternalAngles. Continuous beams, pad footings and combined footings **do not appear in the
  issued PDF** even though they're designed in the project. The PDF is the legal design
  record — elements missing from it is a compliance defect, not a cosmetic one.

### A7. Footing design: minimum steel from a superseded rule; no shear checks
- `PadFootingDesignEngine` minimum reinforcement uses `1.4/fy` (line 130) — the pre-2009
  flexural minimum. AS 3600-2018 Cl 8.1.6.1 uses `αb·(D/d)²·(f'ct.f/fsy)`.
- No one-way (beam) shear check and no punching shear check is performed on the pad —
  pad footings under high column loads are frequently shear-governed.
- fsy=500, cover-to-centre 85 mm, γconc=24 kN/m³ hardcoded (lines 36-38).

### A8. Timber design — verify factors against AS 1720.1-2010
- k4 = 1.0 and k6 = 1.0 hardcoded (`TimberDesignEngine.cs:292-298`). Fine for seasoned timber
  outside northern Australia (i.e. Melbourne), but should be stated on the report and
  configurable.
- `TimberMember.ComputeS1 = La·d/b²` (`TimberMember.cs:37-41`) is a simplified slenderness
  coefficient. Verify against AS 1720.1-2010 Cl 3.2.3.2 for the restraint cases the app
  claims to cover (the firm holds AS 1720.1-2010 +A3 in the standards library).
- Confirm k1 is being applied per-combination (0.57 permanent / 0.8 medium-term etc.) —
  the 1.35G and 1.2G+1.5Q cases must use different k1 values.

### A9. Deflection limit defaults: code contradicts the User Guide
- Code defaults (`DesignSettings.cs:47-49`): Floor G/300 Q/360 G+Q/250; Roof G/300 Q/250
  G+Q/200; Cantilever G/150 Q/180 G+Q/125.
- User Guide §16 lists: Floor /600 /300 /250; Roof /500 /250 /200; Cantilever /400 /200 /150.
- Also `MaxUtilisation` default is 1.00 in code, 95% in the guide; default tributary width is
  1.0 m in code, 0.6 m in the guide. **Tim to confirm the firm's numbers; then code, guide and
  report must all say the same thing.**

---

## B. IMPORTANT — software quality (violates the firm's own coding rules)

1. **God files**: `MainWindowViewModel.cs` (1,403 lines), `BeamDesignViewModel.cs` (1,253),
   `Frame3DSceneBuilder.cs` (1,027), `PdfReportService.cs` (992) — rule caps files at 800.
2. **Global mutable static state**: `ServiceLocator` + static events (`SettingsChanged`,
   `BeamAnalysisCompleted`) create hidden coupling; hard to test, hard to trace cascade flow.
3. **Engines mutate their input models** (e.g. `PadFootingDesignEngine.Design` writes results
   into the footing object) — against the immutability rule; makes undo/redo and sensitivity
   analysis fragile.
4. **Engineering constants as magic numbers** scattered through engines (φ, k-factors, load
   factors, fsy, cover, air density, E). Two full capacity tables live in code instead of data
   (`ExternalAngleDesignEngine.cs:136-165`, `CombinedFootingDesignEngine.cs:173-188`).
5. **Silent failures**: empty `catch {}` in `ProjectFileService.cs:42`, `ApiServer.cs:75,153`;
   `ProjectFileService.Load` has no validation — a corrupted `.cebeam` throws raw at the user.
6. **API security**: REST API sets `Access-Control-Allow-Origin: *` and can bind to the LAN
   (`AllowRemote`) with **no authentication** on read/write project endpoints. Defaults are
   safe (off + localhost) but the unsafe path is one checkbox away.
7. **~50 lines of stream-of-consciousness comments** in the deflection-integral code
   (`SimpleBeamAnalysisEngine.cs:294-343`) around a load-bearing unit convention.

## C. TEST GAPS (274 passing tests ≠ validated engineering)

Existing tests verify statics against closed form (good) but nothing validates the *capacity
data* against published values. Missing entirely:
- `CombinedFootingDesignEngine` — **zero tests** for a shipping design module.
- `LoadCascadeService` (topological ordering, cycle detection) — headline feature, untested.
- Continuous-beam **design** (the VM reuses the simple-beam engine via a marked "temporary" hack
  — `ContinuousBeamDesignViewModel.cs:409,428`).
- `SensitivityAnalysisService`, `WindSeismicLookup`, `.cebeam` save/load round-trip, PDF content.
- Golden-value suites: steel φMb vs ASI DCT, timber φM vs AS 1720.1 hand calcs, footing vs
  hand calc. **This is the highest-value testing work available.**

## D. What is genuinely good (keep and build on)

- Clean separation of stateless analysis engines from design engines; pure static math is unit-testable.
- The 3D direct-stiffness frame engine (6 DOF, releases, tension-only braces) is a real asset — the seed of the "ETABS-lite" ambition.
- Load cascade with cycle detection is a differentiator no spreadsheet can do.
- Atomic save with versioned backups + revision history is exactly right for engineering records.
- Keyboard/d-pad Excel-muscle-memory workflow; auto mark generation; schedule/takeoff tabs.
- 274 fast tests and a green build — the culture is right, the coverage just needs to reach the design data.

## E. Recommended fix order (Phase 0 of the Toolkit plan)

1. A2 wind uplift + A1 load combinations (one data-driven combination engine, AS/NZS 1170.0 set).
2. A6 PDF report completeness.
3. A3 steel shear + A5 external angle resolution.
4. A4 steel table golden-value validation.
5. A7 footing minimum steel + shear checks.
6. A8 timber factor verification; A9 defaults reconciliation.
7. C test gaps alongside each fix (failing test → fix → pass, per firm rules).
8. B items opportunistically as the files are touched (split god VMs when Phase 1 refactor lands).
