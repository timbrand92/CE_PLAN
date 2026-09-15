# CE's own design guidebook, turned into rules the plugin can hold

**15 September 2026.** Source: `CIVIL AND DRAINAGE DESIGN GUIDEBOOK`, Version 1, 2024 (33 pages), CE's internal
guide. Tim supplied it against Q3. It answers Q3, Q4 and Q5 and a good deal more.

This is the **Settings-first seed**: everything below belongs on the Settings page as a council profile or a
design default, never hard-coded (R-27). Nothing here is built yet.

---

## 1. Questions it closes

**Q3 — is the Boyds Kingston variant per-council?** Yes, and it is bigger than that. CE uses **three** ways of
getting PSD/OSD, and which one applies is a property of the council:

| Route | Councils |
|---|---|
| **Council supplies PSD + OSD** (email site area and impervious area) | Bayside, Monash, Boroondara, Banyule, Brimbank, Greater Dandenong, Manningham |
| **Boyd's method** | Kingston, Frankston, Glen Eira, Mornington Peninsula, Casey, Maribyrnong, Moonee Valley, Port Phillip, Stonnington, Whitehorse |
| **Swinburne method (OSD4W software) only** | Darebin, Maroondah, Yarra Ranges, (Manningham) |

Kingston's separate workbook exists because **its pre-development coefficient is fixed at 0.4 regardless of actual
imperviousness, with Tc = 5 min for lots under 1000 m²** — council rules, not a different method.

**Q4 — why is `CALCULATIONS - DETENTION` only on 187 jobs?** Because **detention is not always required.**
Single dwellings usually have none and no planning permit. Detention applies to multi-unit, commercial and
industrial — and the Planning Permit and LPOD document say which.

**Q5 — is PSD always from the council?** No — it is one of the three routes above, and which one is the
council's rule.

---

## 2. Design rules the plugin can CHECK (this is the valuable part)

These are stated as hard design rules in CE's own guide, and every one is determinable from the drawing:

### Pit size by depth — a lookup, not a judgement

| Pit size | Max depth |
|---|---|
| 350 × 350 | 450 |
| 450 × 450 | 600 |
| 600 × 600 | 900 |
| 600 × 900 | 1200 — **step irons required** |
| 900 × 900 | over 1200 |

The plugin knows every pit's size and depth. **It can flag an undersized pit, and it can add step irons where the
rule says they are required**, instead of someone checking a table.

### The overflow rule — this is exactly the TWL check

> *"Proposed overflow of the detention system should be lower than any of the Pit cover levels in the site."*

**That is the warning the TWL solver already produces.** It was built this morning from first principles and it
turns out to be CE's own stated rule, written down. It should cite this line when it fires.

### Other checkable rules

- **Minimum 1:100 fall** for gravity pipes.
- **Minimum 1:200** for detention pipes 225 dia. and greater (Darebin, Banyule, Manningham, Maroondah).
- **Pipes must have adequate cover** — AS/NZS 3500.3 §6.2.5; gradients §6.3.4. Frankston: **min 250 mm**.
- **No detention pipes under dwellings or garages.** Exception: under decking where the LPD is at the rear.
- **Orifice pit: 100 mm minimum clear** between pit cover and the top of the baffle wall, for overflow in extreme
  events. The baffle wall height IS the head for orifice sizing.
- **Pipes under dwellings must be sleeved** (the "other councils" group).

### Layout considerations the plugin could surface

LPD point of connection · site slope · tree protection zones · neighbouring footings near the boundary · existing
sewer ties · paved areas · landscape/proposed trees · courtyards and turntables.

---

## 3. Council profile seed — what Settings needs to hold

| Council | PSD route | Coefficients / ARI | Min orifice | Underground detention | Special |
|---|---|---|---|---|---|
| **Kingston** | Boyd's (council gives PSD) | pre-dev C **0.4** fixed; Tc 5 min < 1000 m² | — | — | Tank: 500 L per 2000 L offset without orifice; **> 2500 L needs an orifice**, min 1000 L detention, justified by connected roof area |
| **Glen Eira** | Boyd's | **C 0.35, 1 in 5 ARI, 5 min** | — | — | — |
| **Frankston** | Boyd's | **C 0.35, 1 in 5 ARI, 5 min** | — | — | **All pipes min 250 mm cover**; driveway cross-section |
| **Mornington Peninsula** | Boyd's, council coefficients | LPOD gives pre/post C | **65 mm** | **min 50 %** | Orifice pit MP244, driveway MP303, tank MP245 |
| **Bayside** | Council supplies | — | — | ≥ 50 % (good practice) | — |
| **Monash** | Council supplies | — | **65 mm** | **min 60 %** | Std DWG D10A; fees on 2nd amendment |
| **Boroondara** | Council supplies | — | — | **ALL underground — no tank detention** | **Single-chamber orifice pit, plate at the discharge pipe face** (SD999) — unlike every other council |
| **Darebin** | OSD4W only | pre **0.4** / post **0.8**, zone Melbourne; **storage 1 in 10 ARI, PSD 1 in 5** | — | ≥ 50 % | 1:200 for ≥ 225; DS14, DS8 |
| **Banyule** | OSD4W / council | Tc + Tso by email | — | ≥ 50 % | 1:200 for ≥ 225 |
| **Whitehorse** | Boyd's | — | **90 mm** | — | **Orifice only required above 12 L/s** |
| **Manningham** | OSD4W / council | Tc + Tso by email | — | — | **Reuse dispensation = 0.25 × SSR × (roof connected ÷ total site impervious)** |
| **Maroondah** | OSD4W | **return period varies with site slope** — rear-sloping may need 1 in 20 ARI | — | — | Detention proportioned by roof vs impervious area |
| **Others** (Yarra, Melbourne, Stonnington, Moonee Valley, Port Phillip, Merri-bek, Maribyrnong, Hobsons Bay, Greater Dandenong, Yarra Ranges) | — | — | — | — | **Most need no detention**; pipes under dwellings sleeved |

**Boroondara is the one to be careful of.** Its orifice pit is a *different shape* — one chamber with a plate at
the pipe face, not two chambers with a baffle. Any orifice detail the plugin draws must know that.

---

## 4. What this changes about the earlier plan

1. **The council profile needs more than numbers.** It needs the PSD *route* (council-supplied / Boyd's / OSD4W),
   because that decides which workbook is filled and whether a value is even calculable in-house.
2. **`CALCULATIONS - DETENTION` missing is not a fault.** The plugin should ask whether detention is required —
   from the Planning Permit and LPOD — rather than assume.
3. **Minimum orifice diameter is a council value** (65 mm Monash and Mornington, 90 mm Whitehorse) and it
   constrains the achievable baffle height, which constrains pipe diameter. That chain should be checked, not
   discovered late.
4. **The guidebook says the current practice is to mark up A1 plans BY HAND at 1:100**, after a "CIVIL SETUP".
   That is the workflow CDDESIGN would replace, and it is why a front door matters.

## 5. Questions this raises

1. **Is Version 1 (2024) still current**, and should the plugin cite the guidebook version it is working to?
2. The guide says PSD/OSD emails go to named council addresses — **should the plugin draft that enquiry** with the
   site and impervious areas filled in from the drawing?
3. **Pump and soakage systems are explicitly out of scope** of the guidebook, but `COMPUTATIONS - PUMP` exists on
   241 jobs. Where do the pump rules live?
4. Several councils say **"design as per the council checklist"** — are those checklists held anywhere the plugin
   could read and tick off?
