# CE Structural Engineering Toolkit — Master Plan

**Status: DRAFT — awaiting Tim's sign-off. No build work starts until the decision queue at
the bottom is answered.** (17 July 2026)

## 1. The vision

One desktop application — the **CE Structural Toolkit** — that replaces the firm's scattered
Excel design spreadsheets with a single smart computation environment:

- **Smart comp sheet** — what CE Beam Designer already is, generalised: every design module
  produces a CE-branded computation sheet (matching `COMPUTATION SHEET.docx`) with clause
  references, and feeds the project-wide schedule and load cascade.
- **RCB** — reinforced concrete beam design to AS 3600-2018.
- **SLB** — slab design (one-way, two-way, flat slab basics) to AS 3600-2018.
- **CE Frame — in-house 3D frame analysis + design ("the SPACE GASS replacement")** — grow the
  existing 3D direct-stiffness frame engine into the analysis tool the firm currently uses
  SPACE GASS for: portal frames and steel frames, with member design to AS 4100 built in, plus
  gravity load rundown and wind/seismic auto-loading. **Decision (Tim, 17 Jul 2026): build this
  capability in-house rather than only interoperate with SPACE GASS.**
- Everything to **current Australian Standards**: AS/NZS 1170.0/.1/.2-2021/.4-2007,
  AS 3600-2018 (+A2), AS 4100-2020, AS 1720.1-2010, AS 2870-2011, AS 3700-2018 — all of which
  the firm holds in `Australian Standards\`.

**Honest scoping on the SPACE GASS decision:** SPACE GASS is a mature commercial product —
second-order (P-delta) and dynamic analysis, full AS 4100/AS 3600/AS 4600 member design, plate
elements, decades of validation. We are **not** achieving full parity, and presenting it as a
single "work package" would be dishonest. What IS achievable and what the firm actually uses it
for on residential / light-commercial jobs is the target: **portal frames and steel frames** —
linear + **second-order (P-delta) analysis** (essential for portal frames), AS 4100 member
capacity (compression, bending, combined actions, effective lengths), wind/seismic auto-loading
(Phase 1 combinations already done), section libraries, and a comp-sheet report. This is a
**multi-stage build in its own right** (see Phase 4), not a quick add. It supersedes the earlier
"export to SPACE GASS rather than compete" position. A file-link/export to SPACE GASS may still
be added later as a checking cross-reference, but is no longer the primary goal.

> **Fable recommendation:** the frame analysis + AS 4100 member design work (P-delta, elastic
> buckling / effective-length, combined-action interaction per Cl 8.4) is genuinely hard
> engineering reasoning — one of the three places (with the RCB module and the pre-production
> peer-review pass) where running the design/spec work in a **Claude Fable** chat is worth it.

## 2. What we already have (asset survey, 17 Jul 2026)

**The app** (`CE_COMPSHEET\CE_BEAM_DESIGNER`): .NET 9 WPF, MVVM, ~28,500 lines, 274 passing
tests. Six element types, load cascade, 3D frame engine, PDF/CSV/XLSX export, REST API,
sensitivity analysis, wind/seismic calculators. See `ENGINEERING_REVIEW_2026-07-17.md` for the
compliance defects that must be fixed first.

**The engineering library** (`Creative Engineering - Engineering\`):
- `01 - Design Spreadsheets\` — 35 curated spreadsheets = the module backlog (§5).
- `Australian Standards\` — 2,490 files incl. current editions of every standard we need.
- Section/capacity data sources: ASI/ONESTEEL Design Capacity Tables (PDF), AS 1684 span table
  supplements, CMAA lintel tables, Bondek/Condeck manuals, RAMSET anchor calculators.
- Firm templates: `COMPUTATION SHEET.docx` (calc page format), `DESIGN LOADING.docx` (default
  dead loads — tiled roof 0.9 kPa, tin roof 0.4 kPa, residential floor 0.5 kPa…),
  `Facesheet.doc` (report cover).
- Reference suites for cross-checking: WSP spreadsheets (COL_AS3600, Load Rundown, Earthquake
  Analysis Static AS1170.4-2007, PT/RC section design), JT/Design Tools legacy suites.

## 3. Architecture

**One app, pluggable modules — not one app per spreadsheet.**

```
CE_TOOLKIT/
├── src/
│   ├── CE.Engineering.Core/          ← NEW class library, zero WPF references
│   │   ├── Units/                    (mm, m, kPa, kN — one conversion layer)
│   │   ├── Loads/                    (actions, AS/NZS 1170.0 combination engine — DATA-DRIVEN)
│   │   ├── Materials/                (steel grades, timber grades, concrete f'c, masonry)
│   │   ├── Sections/                 (steel/timber/RC section properties + capacity data)
│   │   ├── Analysis/                 (beam engines, 3D frame engine — moved from the app)
│   │   └── Design/                   (one folder per module: Steel, Timber, RCB, SLB, …)
│   ├── CE.Engineering.Standards/     ← versioned standards data as JSON: load factors,
│   │                                    φ factors, k-factors, deflection limits, min-steel
│   │                                    rules — each tagged with its edition (AS3600-2018 etc.)
│   ├── CE.Toolkit.App/               ← the WPF shell (evolved CE_BEAM_DESIGNER)
│   └── CE.Toolkit.Reporting/         ← comp-sheet PDF engine (QuestPDF)
└── tests/
    ├── CE.Engineering.Core.Tests/
    └── CE.Engineering.GoldenValues/  ← validation vs published tables & old spreadsheets
```

Key rules carried from the review:
- **No hardcoded engineering constants.** Every φ, k, load factor, limit lives in
  `CE.Engineering.Standards` JSON, tagged by standard edition, surfaced on the printed calc.
- **Immutable calc pipeline**: input model → engine → new result object. Engines never write
  into their inputs (fixes undo/sensitivity fragility, satisfies the firm's coding rules).
- **Kill `ServiceLocator`** in favour of constructor injection; split the two god ViewModels.
- Every module ships with: unit tests, a golden-value suite (module output vs the legacy
  spreadsheet + a hand calc), and a comp-sheet report template.

**Validation strategy (how we trust a module):** run the legacy spreadsheet and the new module
on the same 5–10 benchmark jobs; results must match or the difference must be explained by a
standard-edition change and signed off by Tim. The sheet dumps in `CE_COMPSHEET\` are the
start of this harness.

## 4. Phased roadmap

### Phase 0 — Make the current app trustworthy (BLOCKING, do first)
Fix the review's Section A items: AS/NZS 1170.0 combination engine (incl. **0.9G + Wu uplift**),
steel shear, PDF report completeness, steel table golden-value validation vs ASI DCT, footing
min-steel + shear, timber factor verification, defaults reconciliation, plus the zero-coverage
test gaps (combined footing, cascade). *Everything later builds on this engine.*

### Phase 1 — Core refactor + smart comp sheet v2
Extract `CE.Engineering.Core` + `CE.Engineering.Standards` from the app (behaviour-preserving —
the 274 tests plus new golden values are the safety net). Rebuild the PDF as a true CE
computation sheet: firm header block (Project No/Address/Engineer/Date/Page), clause references
printed beside every check, standards editions stated. Load the firm's default loads library
from `DESIGN LOADING.docx` data.

Per `PROJECTS_REVIEW_2026-07-17.md`, the output must clone the PRODUCTION single-page
per-member format (see a real `FB1.pdf`), support the production mark series
(FB/RB/L/PB/GL/LRB/TH/PF/EB/IB) with prime-mark revisions (`FB10'`), and assemble the merged
`NN-NN_Computations.pdf` with discipline grouping + MEMBER SCHEDULE page.

### Phase 2 — RCB: Reinforced Concrete Beam module (AS 3600-2018)
Port/replace `Reinforced Concrete Beam.xls`, `04_SUSPENDED BEAM.xls`, `SUSPENDED FOOTING BEAM
version 7.xlsm`. Scope: rectangular + flanged sections; flexure (ku, φMuo, min steel
Cl 8.1.6.1); shear to Cl 8.2 (2018 method); deflection (kcs long-term multiplier, deemed-to-
comply and refined); crack control; development lengths Cl 13.1; bar scheduling into the
takeoff. Reuses the existing beam analysis engines and cascade unchanged.

### Phase 3 — SLB: Slab module (AS 3600-2018)
Port/replace `03_SLAB DESIGN_CORRECTED.xls`, `1WAY_RC_SLAB.xls`, `Slab 2-Way.xls`,
`Punching Shear.xls`. Scope: one-way and two-way slabs by the simplified coefficient methods
(Cl 6.10), deemed-to-comply span/depth deflection, punching shear at columns (Cl 9.3),
detailing minimums. Optionally Bondek/composite slab as a variant (BondekV3 data exists).

### Phase 4 — CE Frame: in-house frame analysis + design (the SPACE GASS replacement)
**Decision (Tim, 17 Jul 2026): build the analysis in-house, not just interoperate.** Grow the
Structure tab into the tool the firm currently uses SPACE GASS for on residential /
light-commercial jobs. This is a multi-stage build, not one work package — staged so each stage
is independently useful and validated against real `.sg` benchmark jobs (the firm has 1,165):

- **4.1 Analysis core hardening** — the existing linear direct-stiffness engine gets a proper
  test/validation suite against SPACE GASS results on benchmark portal frames; fix any gaps in
  releases, supports, tension-only braces.
- **4.2 Second-order (P-delta) analysis** — essential for portal-frame steel design; SPACE GASS
  does this and AS 4100 requires it (or moment amplification). Without it we can't claim to
  replace SPACE GASS for portals. *(Fable-grade work.)*
- **4.3 AS 4100 member design in the frame** — take member forces → compression capacity
  (Cl 6), bending capacity (Cl 5, already have the tables), **combined actions** (Cl 8.3/8.4),
  effective lengths, one-click member check/auto-size for every frame member. *(Fable-grade work.)*
- **4.4 Load generation** — full AS/NZS 1170.2-2021 wind procedure (current calculator is
  single-surface), AS 1170.4 equivalent-static seismic with storey distribution, gravity **load
  rundown** floor-by-floor (replaces the `Load Rundown` spreadsheets), applied to the frame.
- **4.5 Building assembly + reporting** — floor levels, rigid-diaphragm distribution to frames,
  results flowing into the comp-sheet report; optional SPACE GASS text-format export as an
  independent cross-check.

Reality check: full SPACE GASS parity (dynamic analysis, plate/shell elements, non-linear) is
NOT in scope. Target = portal frames + steel frames for the firm's typical jobs. Each stage
ships and is validated before the next.

### Phase 4b — Drawing markup module (Tim's request, 17 Jul 2026)
Import architectural reference drawings (PDF/image) as a scaled 1:100 underlay; the user
hand-draws beam/column/wall markup directly over the drawing; the program builds the entire
structural model from the markup (floors, spans, supports measured off the drawing scale).
The model then WAITS for load input from the firm's engineers, but immediately offers
**suggested member sizes** driven by tributary-area loading patterns (default loads from the
firm's DESIGN LOADING library) and the load on each beam — clearly labelled as suggestions
pending engineer-confirmed loading. Builds directly on Phase 4's building model; the 3D
modeller and load-rundown engine are prerequisites. Design sketch to be written up before
build.

### Phase 5 — Module backlog from the spreadsheet library (prioritise with Tim)
Steel column (AS 4100 members in compression + combined actions) · Footings v2 (AS 2870 raft,
eccentric, screw piles) · Retaining walls (AS 4678; sleeper, masonry, surcharge) · Soldier
piles (Brom's, Ivey-Hawkins — feeds WALLAP workflow) · Masonry (AS 3700/AS 4773 walls +
lintels) · Composite beam (AS 2327) · Stud walls · Swimming pools · Wind Design sheet
replacement · Civil/hydraulic sheets (separate CVL toolkit — out of structural scope).

Each Phase-5 module follows the same recipe: golden values from the legacy sheet → Core engine
→ input view → comp sheet → schedule integration. Once Phase 1 lands, a typical module is
weeks, not months.

## 5. Module backlog mapped from `01 - Design Spreadsheets`

| Legacy spreadsheet | Toolkit module | Standard | Phase |
|---|---|---|---|
| 01_BEAM DESIGN.xlsm | ✅ shipped (Beam Designer) — needs Phase 0 fixes | AS 4100 / AS 1720.1 | 0 |
| 00_Wind Design.xls | Wind loading engine | AS/NZS 1170.2-2021 | 4 |
| Reinforced Concrete Beam.xls / 04_SUSPENDED BEAM.xls | **RCB** | AS 3600-2018 | 2 |
| 03_SLAB DESIGN_CORRECTED.xls / Slab 2-Way / 1WAY_RC_SLAB / Punching Shear | **SLB** | AS 3600-2018 | 3 |
| Steel Column Design.xls / COL_AS3600_09.xlsm | Column module (steel + RC) | AS 4100 / AS 3600 | 5 |
| 02_FOOTINGS.xlsm / Raft footing xlsm | Footings v2 | AS 2870-2011 / AS 3600 | 5 |
| Retaining Walls.xlsm + variants | Retaining walls | AS 4678-2002 | 5 |
| Brom's / Ivey-Hawkins soldier pile sheets | Retention module | AS 2159 / AS 4678 | 5 |
| Masonry AS3700.xls + lintel sheets | Masonry module | AS 3700-2018 | 5 |
| Composite Beam Design.xlsx | Composite beam | AS 2327 | 5 |
| Studwall.xlsm | Stud wall | AS 1684 / AS 4600 | 5 |
| Load Rundown (WSP) / Load Take Downs.xls | Load rundown | AS/NZS 1170.1 | 4.4 |
| Earthquake Analysis Static (WSP) | Seismic engine | AS 1170.4-2007 | 4.4 |
| SPACE GASS portal/steel frames (1,165 `.sg`) + SPACEGASS PORTAL FRAME PROCEDURE.docx | **CE Frame** (in-house analysis + AS 4100 design) | AS 4100-2020 | 4 |

## 6. Decision queue — Tim must answer before build starts

1. **Load factors**: adopt AS/NZS 1170.0 exactly (1.2G+1.5Q etc. — recommended), or keep
   1.25G+1.5Q as deliberate firm conservatism? (Affects every module.)
2. **Deflection limits**: confirm the firm's table (guide says Floor /600 G, /300 Q, /250 G+Q —
   code currently disagrees).
3. **Steel capacity data**: re-derive from AS 4100-2020 first principles (recommended — enables
   αm, any le, future sections) vs re-transcribe current ASI DCT tables (faster, tables-only)?
4. **Module priority**: is RCB before SLB right? (Plan assumes RCB → SLB → building modeller.)
5. **ETABS-lite ambition**: agree the low-rise scope above (frames + diaphragms + equivalent
   static), with SPACE GASS export for anything heavier?
6. **One app**: agree the single-shell CE Toolkit (recommended) vs separate apps per module?
7. **Phase 0 go-ahead**: GIVEN 2026-07-17 (Tim: "go with your recommendations on all of them").

## 7. Engineering sign-off governance (updated 17 Jul 2026)

Tim is a software developer, not an engineer (his words: "I am not an engineer so you will
need to manage that side of things"). Division of responsibility:

- **Claude manages engineering rigor**: every calculation traceable to a standard clause
  (printed on the output), constants data-driven and edition-tagged, golden-value tests
  against published capacity tables and legacy spreadsheet benchmarks, and a
  **VALIDATION_PACK.md** of worked examples with hand-calc derivations per release.
- **The firm's engineers hold the release gate**: any release that changes calculation output
  must be reviewed by one of Creative Engineering's qualified engineers against the validation
  pack before the app is used on real jobs. The validation pack is designed to make that
  review take under an hour. Tim's role is coordination and software QA — his approval is a
  build gate, not an engineering sign-off.
- The app itself states its basis: standards editions, combination set, and "suggestions
  pending engineer review" labelling wherever auto-design proposes a member.
