# Maroondah — Engineering Development Design Guidelines

**15 September 2026.** Source: Maroondah City Council *Engineering Development Design Guidelines*, 48 pages
(rainfall data dated April 2013).

**The most complete council document of the twelve read.** It publishes its runoff coefficients, its times
of concentration, **its own rainfall intensity table**, its detention requirement matrix, its orifice
formula with a worked example, its pipe cover and grade tables, its pit size ladder with a step-iron
column, and its velocity limits. Nothing needs to be asked of Council.

**It also settles two arguments and exposes a copied value on five councils.**

---

## 1. It settles the orifice coefficient argument

> *"Cd = **0.6 (coefficient for round shaped pipe)**"*

Darebin publishes **1.0 for a circular outlet**. Maroondah publishes **0.6 for a round pipe**, explicitly,
with a worked example. Frankston's one-step formula has 0.6 inside its constant.

**So three councils sit at 0.6 and Darebin stands alone at 1.0.** CE's office ruling of 0.6 everywhere is
supported by the weight of the sources; Darebin is the exception to record, not the rule to follow.

**But the rounding conflicts with CE's ruling.** Maroondah's worked example computes **42 mm** and
*"therefore adopt 40Ø"* — it rounds **down** to the nearest commercially available size. Manningham says
*"nearest standard pipe diameter ±2 mm"* — also nearest. CE's open answer to Q18 was *snap to the standard
size **at or above** the minimum*. Snapping up passes more than the permitted discharge; snapping down
passes less. **Two councils round to nearest; CE's ruling rounds up.**

Maroondah's commercially available sizes: **32 · 40 · 50 · 65 · 80 · 90 · 100 · 150 Ø**, with **40 mm the
minimum for underground detention** and **20 mm the minimum for a rainwater tank orifice**.

## 2. It settles the pervious coefficient

> *"C = (0.9 × 35% Area + **0.3 × 65% Area**) / Area = 0.51"*

**A fourth council using 0.30 for pervious and 0.90 for impervious.** With Banyule, Darebin and Maroondah
all stating it plainly, and Frankston and Banyule both using ~0.35 as a *whole-site* figure, the reading in
`FINDING_PERVIOUS_C_SPLIT.md` holds: **0.30 is the pervious surface number; 0.35 is a site number.** CE's
`perviousC = 0.35` is the odd one out.

Maroondah also uses the **`preDevImperviousFractionCap`** idea that already exists as a field and is unused:
pre-development coverage is taken as **35%**, or the actual coverage if it is **less** (worked example at
25% gives C = 0.45).

## 3. The copied 1:200 grade — wrong on two councils, unverified on a third

The identical sentence *"min pipe grade 1:200 for detention pipes 225 and greater"* appears on **five**
councils in `council-profiles.json`:

| Council | Stored | Council's own words | |
|---|---|---|---|
| Darebin | 1:200 | *"no flatter than 1 in 200"* | ✅ |
| Banyule | 1:200 | *"no flatter than 1:200"* | ✅ |
| **Manningham** | 1:200 | *"no flatter than **1 in 180**"* | ❌ too flat |
| **Maroondah** | 1:200 | a **ladder by diameter** — see below | ❌ wrong shape |
| Knox | 1:200 | not read | ⚠ unverified |

**Maroondah's minimum detention grades are by pipe diameter:**

| Diameter | Minimum grade |
|---|---|
| 150 Ø | **1 in 150** |
| 225 – 450 Ø | **1 in 250** |
| 525 Ø or greater | **1 in 400** |

So Maroondah is *more* permissive than 1:200 on the common sizes and *steeper* on 150. A single stored
sentence cannot express it.

**This is the clearest evidence yet that free-text warnings are the wrong home for engineering values.** One
sentence was written once and copied to five councils; it is right on two, wrong on two, and nobody could
tell without reading five documents.

## 4. Checked against CE's stored Maroondah profile

| CE holds | Maroondah | |
|---|---|---|
| `psdMethod: swinburne` | *"Council will only accept detention calculations using the **Swinburne OSD Methodology**"*; OSD4 zones **Ringwood 5** flow / **Ringwood 10, 20 or 100** store | ✅ now sourced |
| `orificeCo: 0.6` | *"Cd = 0.6 (coefficient for round shaped pipe)"* | ✅ explicitly |
| `psdAri: 5` | PSD *"limited to a 5 year ARI"* | ✅ |
| `storageAri: 10` | *"must detain a minimum of 1 in 10 year storm event"* | ✅ |
| warning: *"return periods may vary with site slope (rear → 1 in 20)"* | true, but the real rule is a **four-case table** | ⚠ understated |
| **`orificeMinMm: 0.0`** | **40 mm** underground | ❌ |
| **`tankLocalOrificeMinMm`** unset | **20 mm** tank orifice | ❌ |
| **`perviousC: 0.35`** | **0.30** | ❌ |
| **`tcMinutes: 5`** | a **published table by lot size** | ❌ — and the field for it exists, empty |
| **`preDevImperviousFractionCap`** unset | **35%** | ❌ — field exists, empty |
| **warning grade 1:200** | ladder 1:150 / 1:250 / 1:400 | ❌ |

**Two fields already exist for exactly what Maroondah publishes and are empty on 21 of 22 councils:**

`tcMinutesByMinimumLotAreaM2` — Maroondah's table fits it directly:

| Average lot size | Tc |
|---|---|
| ≥ 4000 m² | 12 min |
| ≥ 750 m² | 9 |
| ≥ 500 m² | 8 |
| ≥ 350 m² | 7 |
| < 350 m² | 6 |
| High density unit developments | **5** |

`storageAriBySiteCase` — Maroondah's detention matrix fits it directly:

| Slope and LPD | Safe overland flow path? | Detain |
|---|---|---|
| Forward or side sloping, LPD in road reserve | yes | **1 in 10** |
| Forward or side sloping, LPD in road reserve | **no** | **1 in 100** |
| Rear or side sloping, LPD in rear/side easement | yes | **1 in 20** |
| Rear or side sloping, LPD in rear/side easement | **no** | **1 in 100** |

**So the model is less short of fields than it looked — some of the shape is already there and simply
unpopulated.**

## 5. Everything else it publishes

**Runoff coefficients for vacant land, by lot size, with two storm columns:**

| Land use | C (5 yr) | C (100 yr) |
|---|---|---|
| Major open space | 0.30 | 0.40 |
| Residential > 4000 m² | 0.40 | 0.50 |
| Residential > 750 m² | 0.60 | 0.75 |
| Residential > 500 m² | 0.70 | 0.85 |
| Residential > 350 m² | 0.80 | 1.0 |
| Residential < 350 m² | 0.90 | 1.0 |
| High density unit developments | 0.90 | 1.0 |
| Major road reserves | 0.80 | 1.0 |
| Commercial / industrial | 0.90 | 1.0 |

**Its own rainfall intensities** (Table 3, 5/10/20/100 year against Tc from 5 min to 1 hour) — the only
council to print an IFD table rather than sending you to the Bureau.

**PSD** is *"the equivalent of a 35% impervious site coverage, or the pre-developed discharge rate if it is
less"*.

**Uncontrolled runoff** — impervious area that cannot be captured is computed at **C = 0.9** for the storage
storm and **subtracted from the PSD**, and the reduced figure becomes the nominated PSD in OSD4. A precise,
computable rule that no other council states.

**Velocities:** half full or greater **0.75 m/s** · less than half full **1.00 m/s** · maximum **5.0 m/s**.
(Frankston 0.7 / 1.0 / 6.0; Banyule 1.0 – 6.0.)

**Minimum pipe grades:** 100 mm **1 in 100** · 150 mm **1 in 80** · all others set by the velocity limits.

**Cover — private drains:**

| Location | Cover | Min dia | Backfill |
|---|---|---|---|
| Garden areas | 300 mm | 100 mm | normal excavated material |
| Under driveways or buildings | 300 mm | 150 mm | compacted fine crushed rock |

**Cover — Council drains:**

| Location | Cover | Min dia | Material |
|---|---|---|---|
| Easement drain | 450 mm | 225 | RCP / UPVC / PP |
| Behind kerb | 500 (600*) | 300 | RCP / UPVC* / PP |
| Under road pavement | 500 mm | **375** | **Class 4 RCP** |
| Municipal reserve | 450 mm | 225 | RCP |

> *"Council does **not** accept Fibre Reinforced Concrete (FRC) or vitrified clay pipes."*

**Darebin and Manningham both explicitly accept FRC.** So acceptable pipe material is a per-council value
too, not only pipe class.

**Pits — with a step-iron column, to AS3500.3:2015 Table 7.5.2.1:**

| Depth to invert of outlet | Minimum internal | Step irons |
|---|---|---|
| < 600 | 450 × 450 | No |
| 600 – 900 | 600 × 600 | No |
| **900 – 1200** | 600 × 900 | **Yes** |
| > 1200 | 900 × 900 | **Yes** |

Council junction pits: < 1000 → 600 × 900, no step irons; > 1000 → 900 × 900, step irons.

**Step irons required above 900 deep** — which is exactly Tim's ruling (*"LET'S DO OVER 900 DEEP"*). **Office
rule now confirmed by a council document.** Banyule and Manningham both say 1 m; Maroondah says 900.

Also: **minimum 20 mm fall between inlet and outlet inverts** — which matches CE's own R-08 pit drop of
20 mm exactly. **No sumps in pits** (the opposite of Boroondara, which photographs the sump and weepholes).
Grated lids in trafficable areas must be **medium or heavy duty bike-safe** grates. A 450 × 450 surface
water pit is required at the low point of the backyard of every new dwelling.

**Trench grates:** minimum 150 × 150 internal, **300 × 300 where the driveway grade exceeds 1 in 20**,
outlet pipe minimum 150 mm, bike-safe grates.

**Baffle pit:** two chambers · weir wall **minimum 100 mm thick concrete with the orifice cast in** (steel
plates not preferred, tamper risk; if a two-chamber pit is impossible, a plate chem-set with tamper-proof
dyna bolts) · **minimum 50 mm high overflow over the weir wall for the full width** · **solid lid over the
outlet chamber, grated lid over the inlet chamber** · formal trash grate **25 × 25 mm maximum mesh** in the
inlet chamber · each chamber to AS3500.3:2015 minimums · **the construction plan must show the length of
detention pipe**.

> *"Council does **not** allow multi cell units or above ground storage on a driveway."*

Banyule, Manningham, Frankston and Darebin all accept multi-cell. Maroondah refuses it.

**Tanks:** 2000 L reuse maintained **in addition to** the detention volume · detention volume proportioned
to the roof area connected · **roof catchment hatched or coloured on the plan and its area in m² noted** ·
slow-release orifice connected directly to the overflow, tamper proof, **minimum 20 mm** · **only the volume
above the orifice counts** · charged downpipes and tank outlet **100 mm UPVC** · for subdivisions with no
building works, underground is preferred and tanks require a **Section 173 Agreement**.

**Basement car parks — a fourth distinct answer.** Where a pump serves a basement, detention must be
provided for the **1 in 100 year ARI for a minimum 60-minute duration** for the catchment entering the
basement, **in addition to** the normal detention — *"to protect the development against a worst case
scenario where the pump is out of order"*. Waived if a **fully automatic backup pump and generator** are
installed and inspected, or if automatic shut-off valves divert water out of the basement.

**Overland flow safety** (Melbourne Water): depth ≤ **0.35 m**, velocity ≤ **1.5 m/s**, depth × velocity ≤
**0.35 m²/s**. Every design must cater for the 1 in 100 event within the development.

**Freeboard above the 100-year flood level:** dwellings **300 mm**, outbuildings and garages **150 mm** —
identical to Banyule.

**Standards:** AS3500.3:**2015** (same as Banyule).

## 6. Questions

1. **The orifice rounding.** Maroondah works out 42 mm and adopts a 40 — it rounds **down** to the nearest
   size off the shelf, and Manningham says nearest ±2 mm. Our own answer was to round **up** to the next
   standard size at or above the minimum. Rounding up lets out more than the permitted flow. Which are we
   doing?
2. **The discharge coefficient question is now easier.** Maroondah states 0.6 for a round pipe, Frankston
   has 0.6 inside its formula, Darebin alone says 1.0. Is the answer simply *0.6 everywhere, with Darebin
   recorded as the exception*?
3. **Maroondah's detention grades are by pipe size** — 1 in 150 for a 150, 1 in 250 for 225 to 450, 1 in
   400 for 525 and up. We have a single 1:200 recorded for them, and the same sentence is on five councils
   where it is right for only two. Have Maroondah jobs been drawn at 1:200?
4. **Maroondah won't accept fibre reinforced concrete pipe**; Darebin and Manningham both will. Is pipe
   material being chosen per council today?
5. **They won't accept multi-cell units**, where four other councils will. Have we ever specified one on a
   Maroondah job?
6. **Basements again, and a fourth answer:** Maroondah wants an extra 1-in-100, 60-minute detention for the
   basement catchment on top of the normal detention, unless there's an automatic backup pump and
   generator. Is that being done?
7. **Step irons over 900 deep** — your own ruling — is confirmed by Maroondah's table. Banyule and
   Manningham say over 1 m. Do we hold 900 everywhere, or each council's own figure?
