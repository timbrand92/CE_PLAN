# Council rules — what CE now holds, what the plugin can read, and the gap between them

**15 September 2026.** Tim's instruction: *"make sure all these documents and information is included in
V3 plan and the plugin reads, understands them and CE based design and drafting is working with this
context."*

This is the specification for that. It names every document read, states what each contributes, sets out
**exactly which rules the plugin has nowhere to put**, and lists the decisions still needed from Tim.

**Nothing here is built.** This is the plan entry the V3 plan points at.

---

## 1. The documents, and what kind of council each is

| Council | Document | Date | Publishes values? |
|---|---|---|---|
| **Kingston** | Part A Stormwater Drainage, Issue 5 | 2025 | **Yes** — full table |
| **Frankston** | Guidelines for On-Site Stormwater Detention | Sep 2021 | **Yes** — plus a direct orifice formula |
| **Frankston** | Guidelines for Subdivisional, Multi-Dwelling & Industrial Developments | 2005 | **Yes** — C, ARI and Tc by development type |
| **Frankston** | WSUD Guidelines | 2021 | supporting |
| **Darebin** | Legal Point of Discharge Guidelines + OSD checklist | **Jun 2025** | **Yes** — the fullest set |
| **Banyule** | Stormwater Drainage Requirements for New Developments | Sep 2019 | **Yes** — plus the OSD4 zone settings |
| **Manningham** | On-Site Stormwater Detention Guidelines + checklist | Mar 2021 | Council issues PSD/SSR; **publishes the drafting rules** |
| **Boroondara** | Stormwater detention system (council web page) | live | **No** — Council issues PSD and volume |
| **Monash** | Engineering plan checklist + CASBE fact sheet | — | **No** — Council issues values |
| **Bayside** | Developer Drainage Design Policy | 2026 | **No** — Council issues values |
| **Maroondah** | Engineering Development Design Guidelines | (rainfall 2013) | **Yes** — the fullest of all, including its own rainfall intensity table |
| **Mornington Peninsula** | Checklist for Development Engineering Plan Approval | — | **No** — *compute it yourself to ARR* |
| **Whitehorse** | Checklist for Submission of Engineering Civil Plans | 2019–20 | **No** — *compute it yourself to ARR* |

### Finding 1 — there are THREE kinds of council, not two

The plugin's data model assumes a council either has values or uses a named method. The documents show
three distinct postures, and the third has no representation at all:

| Posture | Councils | What the plugin must do |
|---|---|---|
| **Published** | Kingston, Frankston, Darebin, Banyule | read the stored values |
| **Issued on request** | Bayside, Monash, Boroondara, Manningham | **produce the enquiry**, then hold Council's answer against the job |
| **Compute to ARR** | **Mornington Peninsula, Whitehorse** | compute site-specific values and **show the working** |

Boroondara names the five figures the enquiry needs — **site coverage, total site area, roof area, paved
area, landscaped area** — and all five are measurable from the drawing. That is a small, high-value feature:
*produce the council enquiry from the plan.*

## 2. What the plugin can hold today

`CouncilProfile` (`Modules/Drainage/Models/CouncilProfileModels.cs`) has 25 engineering fields:

`psdMethod` · `orificeCo` · `orificeMinMm` · `tankLocalOrificeMinMm` · `minCoverMm` · `psdAri` ·
`storageAri` · `storageAriBySiteCase` · `siteCase` · `perviousC` · `imperviousC` · `preDevCFixed` ·
`preDevCFormula` · `preDevImperviousFractionCap` · `postDevCFixed` · `postDevCMode` · `tcMinutes` ·
`tcMinutesByMinimumLotAreaM2` · `tsoMinutes` · `minUndergroundPct` · `reuseDispensation` ·
`standardDrawings` · `warnings` · `calibrationNote` · `scope` / `editionStatus`

Each field carries **provenance** (`Status` = Sourced / Assumed / OfficeRule, a source locator and a note).
That mechanism is sound and is what made this audit possible — it should be kept and extended, not
replaced.

`warnings` is a free-text list. **Most of what these documents say is currently going into it, which means
the plugin can print it but cannot check it.** That is the core of the gap.

## 3. The gap — rules with nowhere to live

Grouped by what they would let the plugin do.

### A. Values that vary by development type (four councils)

`tcMinutes`, `preDevCFixed`, `postDevCFixed`, `psdAri` and `storageAri` are single values. They are not.

| | Frankston | Kingston | Darebin | Banyule |
|---|---|---|---|---|
| Tc residential | 7 (low density 9) | 5 | 10 | *ask Council* |
| Tc industrial / commercial / multi-dwelling | **3** | 7 | 10 | *ask Council* |
| Pre-dev C | 0.4 / 0.6 / 0.8 by type | 0.4 fixed | res **0.4**, comm **0.6** | **0.35** site |
| Post-dev C | — | — | res **≥0.8**, comm **≥0.90** | 0.9 / 0.3 by surface |
| Storm | res subdivision 1 in 5; industrial & flats 1 in 10 | — | 1 in 5 / 1 in 10 | 1 in 5 / 1 in 10 |

**Needed:** these five become keyed by development type. Frankston's Tc runs the *opposite* way to
Kingston's, so an office default is wrong in both directions.

### B. Pipe and drafting rules — nothing exists for any of these

| Rule | Councils | Values seen |
|---|---|---|
| **Minimum OSD storage grade** | Darebin, Banyule, **Manningham** | 1:200 · 1:200 · **1:180** |
| Minimum outlet grade | Darebin, Manningham | 1:100 · 1:80 (≤1000 m²) |
| **Twin pipe clear gap** | Manningham | **200 mm external face to face**, ≤600 dia |
| Velocity limits | Frankston, Banyule | 0.7 / 1.0 / 6.0 · 1.0–6.0 |
| Manning's n | Frankston, Banyule | 0.013 / 0.009 · 0.013 / 0.011 |
| Colebrook-White k | Frankston | 0.6 concrete / 0.015 UPVC |
| **Minimum cover — a TABLE, not one number** | Frankston, Darebin, Banyule, Manningham, Mornington | see below |
| Minimum pipe size by location | Frankston, Darebin, Banyule | under road 300 · road reserve 225 · easement 225 · under slab 150 |
| **Minimum pipe class** | **Mornington Class 3** · Darebin, Banyule, Manningham **Class 2** | |
| Max pit spacing | Darebin | 30 m |
| **Max pipe a pit may accept** | Banyule | 300 into 600×600, 600 above |
| Pit size by depth | Darebin, Banyule | two different ladders |
| Step irons | Banyule, Manningham, CE | **deeper than 1 m** (all three agree) |
| Fall through a pit | Banyule, Manningham | 50 mm · **10 mm** |
| Direction change at a pit | Banyule | ≤45° preferred, never >90° |
| Boundary offsets | Manningham | 500 front / 300 side |
| Pit lid class by location | Manningham | driveway / crossover / landscape / backyard |

`minCoverMm` is a single number. Every council publishes a table:

| | no vehicle loading | driveway | road reserve | sealed road |
|---|---|---|---|---|
| Frankston | 500 | 75–100 under pavement | — | 600 |
| Darebin | 300 | — | 450 | 600 |
| Banyule | — | 300 | 450 | 600 |
| Manningham | — | **300** | — | — |

### C. Freeboard — one field cannot hold this

There are now **nine distinct freeboard rules**, each with a different *from* and *to*. They are not
alternatives; on one job several apply at once.

| From | To | mm | Council |
|---|---|---|---|
| Top water level | pit lid | **150** | CE office rule |
| Ponding / top water level | habitable floor | **400** | Darebin |
| Ponding / top water level | garage floor | **200** | Darebin |
| Max water level | habitable floor | **300** | Manningham, Frankston, Banyule |
| Max water level | other floors incl. garage | **150** | Manningham |
| Top water level | any grated inlet | **300** | Banyule |
| Water level in a pit | — | **300** | Banyule |
| Hydraulic grade line | finished surface | **300** | Banyule |
| Finished floor | 1% AEP flood level | **300** dwellings / **150** outbuildings | Banyule, Kingston, Darebin |
| Top of baffle wall | underside of pit lid | **100** | Darebin, Manningham |

**Needed:** a list of `(from, to, millimetres)` rules per council, not a number. This is also the honest
resolution of the earlier TWL question — Tim's ruling that *floor level does not set the TWL* stands; these
are **checks the TWL must pass**, which is a different thing.

### D. Orifice — the councils genuinely disagree

| | Boroondara | Darebin | Banyule | Manningham | Frankston |
|---|---|---|---|---|---|
| Hardware | **plate required** | **plate refused — pipe only** | plate or multi-cell | **plate refused — in-situ wall** | — |
| Chamber | **single** | double | double (+ multi-cell) | double | double |
| Minimum size | — | **30 mm** | **40 mm** | **40 mm** | — |
| Trash grate | yes (photographed) | yes | required under 90 mm | yes | — |
| Discharge coefficient | — | **0.6 square / 1.0 circular** | — | — | 0.6 (inside `d = 21.9√[PSD/√H]`) |
| Sizing | — | — | — | **nearest market pipe dia ±2 mm** | direct formula |

CE stores **one** `orificeCo` of 0.6 for every council. **Darebin publishes 1.0 for a round orifice**, which
for the same permitted flow gives a hole about 29% smaller in diameter.

**Needed:** `orificeHardware` (plate / pipe / either), `orificeChamber` (single / double / multi-cell),
`orificeCoByShape`, `trashGrateRequiredBelowMm`, and the existing `orificeMinMm` populated — it is **0 for
Darebin and Banyule**, both of which publish a minimum.

### E. Tanks — five councils, five incompatible rules

| Council | Tanks as detention |
|---|---|
| Kingston | 500 L per 2,000 L tank; 1,000 L for tanks ≥ 2,500 L |
| Frankston | ⅓ of each tank, and **≤ 50% of total** detention |
| Monash | ≤ 40% above ground; orifice at ⅔ tank height |
| **Boroondara** | **none — all detention below ground** |
| **Banyule** | **none — above-ground tanks not approved for site storage** |
| Darebin | conditional; detention **in addition to** 2,000 L retention; **25% reduction** for apartments at full site coverage with a ≥10,000 L reuse tank |
| Manningham | tank max 3,000 L; majority of volume must be reuse; `DIV = 0.25 × SSR × (roof connected ÷ total impervious)`; min 2,000 L reuse and 50 m² roof per dwelling; **no dispensation for irrigation-only** |

`reuseDispensation` is free text and `minUndergroundPct` is a single percentage. Manningham's formula fits;
none of the others do.

### F. Triggers, storms and site cases

- **Banyule:** OSD required above **65%** impervious (single dwelling) and **35%** (carpark); design storm
  steps from 1 in 10 to **1 in 20 if the site falls to the rear** — `storageAriBySiteCase` already exists
  and is unused for Banyule
- **Frankston:** no overland flow path → **detain the 1% AEP on site**
- **Darebin, Manningham, Banyule:** flood-prone or upstream of known flooding → PSD and/or SSR at **1% AEP**
- **Banyule:** soakage pit may continue only if **all five** conditions hold

### G. Things the drawing must carry

Pit schedule required by Frankston, Mornington, Darebin, Banyule — **not** Whitehorse. HGL on the long
section: Frankston always, Mornington where necessary, Banyule from the obvert of the Council drain and
300 mm below finished surface, Whitehorse with calculations and plots. Mornington requires **verbatim plan
notes**. Whitehorse sets **contour intervals by site flatness** (0.1 m flat / 0.2 m otherwise, 10 m past the
boundary). Darebin requires **north up the page**, 1:100 or 1:200, each unit's drainage independent with a
single common connection. Several require the **designer named and registered** on the plan.

### H. Standards edition — a per-council value

| Council | Names |
|---|---|
| Darebin (2025) | AS3500.3:**2025** |
| Kingston (2025) | **2021** |
| Frankston (2021), **Manningham (2021)** | **2018** |
| Banyule (2019) | **2015** |
| Boroondara | unstated |

CE holds **2018**. Tim's ruling — work to the edition CE holds — is right for Frankston and Manningham, and
differs elsewhere. The plugin should **record the edition each council names and show it on the job**, so
the difference is visible rather than assumed.

## 4. Errors found in the shipped council data

Every one was found by reading a council's own document against the stored value.

| Council | Field | Stored | Should be | Source |
|---|---|---|---|---|
| **Banyule** | `minUndergroundPct` | 50 | **100** | *"Rainwater tanks above ground will not be approved for site storage"* |
| **Banyule** | `orificeMinMm` | 0 | **40** | *"Outlets must not be less than 40mm"* |
| **Banyule** | `preDevCFixed` | 0 | **0.35** | *"Pre-developed site 0.35 regardless of pre-existing impervious surfaces"* |
| **Banyule** | `tcMinutes` | 5 | *(none — ask Council)* | *"Tc & Tso to be requested from Council"* |
| **Darebin** | `orificeMinMm` | 0 | **30** | *"Orifice outlets must be no less than 30mm"* |
| **Darebin** | warnings | — | add **orifice plates not accepted** | §9.5(d) — held for Manningham, missing here |
| **Manningham** | warning grade | 1:200 | **1:180** | *"no flatter than 1 in 180"* |
| **Maroondah** | warning grade | 1:200 | **a ladder by diameter** — 1:150 / 1:250 / 1:400 | Table 6 |
| **Maroondah** | `orificeMinMm` | 0 | **40** (tank orifice **20**) | *"40Ø is the minimum orifice size acceptable"* |
| **Maroondah** | `perviousC` | 0.35 | **0.30** | `C = (0.9 × 35% + 0.3 × 65%)/Area` |
| **Maroondah** | `tcMinutes` | 5 | **a published table by lot size** | Table 2 |
| **Maroondah** | `preDevImperviousFractionCap` | unset | **0.35** | *"if the pre-developed site coverage is less than 35% then this lesser value should be used"* |
| 18 of 22 councils | `preDevCFormula` text | says 0.3 | computed from 0.35 | the shown working contradicts the answer |

### The copied sentence — the clearest proof that free text is the wrong home

The identical string *"min pipe grade 1:200 for detention pipes 225 and greater"* is stored against **five**
councils. It is **correct for two** (Darebin, Banyule), **wrong for two** (Manningham publishes 1:180;
Maroondah publishes a ladder by diameter), and **unverified for one** (Knox). It was written once and
copied, and no one could tell without reading five council documents.

### Fields that already exist and are empty on 21 of 22 councils

Maroondah publishes tables that fit two existing fields exactly — so the model is **less short than it
looked**, and part of step 4 is population rather than extension:

- `tcMinutesByMinimumLotAreaM2` — Maroondah's Tc by average lot size (12 / 9 / 8 / 7 / 6, high-density 5)
- `storageAriBySiteCase` — Maroondah's four-case detention matrix (slope × safe overland flow path → 10 /
  20 / 100 year), and Banyule's rear-fall step from 1 in 10 to 1 in 20
- `preDevImperviousFractionCap` — Maroondah's 35% coverage cap
- `tankLocalOrificeMinMm` — Maroondah's 20 mm tank orifice, Manningham's 25 mm
- `orificeMinMm` — **zero for 16 of 22 councils**, including Darebin (30), Banyule (40) and Maroondah (40),
  all of which publish a minimum

**`minUndergroundPct` was already wrong for Boroondara and fixed** (audit item D1). Finding the identical
error at Banyule means it is a pattern, not a typo. **The whole file should be swept**, not corrected one
council at a time as documents arrive.

## 5. What must be built, in order

1. **Sweep the existing file** for the known error patterns — above-ground storage bans, missing orifice
   minimums, values in the wrong field. Data only; provenance updated; no model change.
2. **Correct the `preDevCFormula` evidence text** so the shown working matches the computed answer.
   *(Blocked on the pervious-C ruling — §6.)*
3. **Extend the model** with the fields in §3, each with provenance, each on the Settings page — nothing
   hard-coded, per the settings-first rule.
4. **Populate** from the documents read here, marking every value Sourced with its document and clause.
5. **Make the checks real** — the rules in §3B and §3C become CDCHECK warnings against the drawing (never
   blocks, per R-27): grade flatter than the council minimum, velocity outside the band, cover short, pipe
   too big for its pit, twin gap under 200, water level too close to a floor, orifice under the minimum.
6. **Council enquiry pack** — produce Boroondara's five figures, and Banyule's and Manningham's equivalents,
   from the drawing.
7. **Show the council on the job** — which council, which document, which edition, which values are Sourced
   and which are Assumed. The provenance already exists; it needs surfacing.

## 6. Decisions needed from Tim before parts of this can be built

| # | Decision | Blocks |
|---|---|---|
| 1 | **Pervious runoff coefficient — 0.30 or 0.35**, or both for different purposes? Two councils label 0.30 as the pervious *surface* value and 0.35 as a *whole-site pre-development* value | step 2, and every flow |
| 2 | **Orifice discharge coefficient** — Maroondah states **0.6 for a round pipe**, Frankston has 0.6 inside its formula, **Darebin alone says 1.0**. Is the answer 0.6 everywhere with Darebin recorded as the exception? | step 3 |
| 2b | **Orifice rounding** — Maroondah's worked example computes 42 mm and adopts **40Ø** (rounds *down* to the nearest size off the shelf); Manningham says *nearest ±2 mm*. CE's Q18 answer was to snap **up** to the next standard size at or above the minimum, which passes more than the permitted flow | step 5 |
| 3 | **Standards edition** — record per council and show it, or continue working to the 2018 copy CE holds throughout? | step 3 |
| 4 | **Twin pipe gap** — is 200 mm clear between outside faces what CE draws, and is it council-specific? | step 5 |
| 5 | **Basement pumps** — Manningham allows one into the detention on terms, Darebin forbids basement water in stormwater, Boroondara forbids it to kerbs. Which has CE been working to? | step 4 |
| 6 | **Pit lid by location** (Manningham) — should the plugin choose it? | step 5 |
| 7 | **AGI drains** — Manningham requires them to bypass the detention entirely. Should the plugin treat an AGI run as a separate system? | step 5 |
| 8 | **Whitehorse 90 mm orifice** — unverified and more than double every other council. Is there a source? | step 1 |

## 7. Where the evidence lives

Every council document read is written up in `docs/workflows/COUNCIL_*.md`. Cross-cutting findings are in
`FINDING_PERVIOUS_C_SPLIT.md`.

**One housekeeping item:** every stored council value cites
`docs/evidence/COUNCIL_PROFILE_EVIDENCE_2026-09.md` for its provenance. That file exists on other branches
but **not on this one or the live line**, so the citations do not resolve where the data actually ships. It
should be brought across.
