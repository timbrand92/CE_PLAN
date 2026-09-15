# Yarra — Drainage Design Guidelines + Drainage Design Checklist

**15 September 2026.** Sources: City of Yarra *Drainage Design Guidelines (DDG)*, 26 pages, published
**July 2026**; and *Drainage Design Checklist for Single and Other Type Developments*, 4 pages, **June
2026**. The two most recent council documents read.

**Written to `C:\CE_PLAN\02_COUNCIL_RULES` only** — per START_HERE, council rules live here and nowhere
else, so no branch can carry a stale copy.

---

## 1. It settles the orifice coefficient for good

> *"Cd = **0.6 (coefficient of round shaped pipe)**"*

That is **word for word the same phrase Maroondah uses**. Counting the sources now:

| Council | Discharge coefficient for a round orifice |
|---|---|
| **Yarra** | **0.6** |
| Maroondah | **0.6** ("coefficient for round shaped pipe") |
| Frankston | **0.6**, inside its `d = 21.9√[PSD/√H]` constant |
| Manningham | 0.6 implied (standard equation, no alternative given) |
| **Darebin** | **1.0 for circular**, 0.6 for square or rectangular |

**Four councils at 0.6, Darebin alone at 1.0.** CE's office ruling of 0.6 everywhere is the right default;
Darebin is the exception to record, not a reason to change. *(Open question A2 can be closed on Tim's word.)*

## 2. The councils share a template — and that changes how this should be built

Yarra's checklist repeats **Manningham's wording exactly** in several places:

- *"Minimum 10mm nominal fall through detention pit shown"*
- *"If IOs in driveway, the 200X200 Jenco steel covers to match finished surface of the driveway"*
- *"Pit covers or grated covers must be higher than the top of the baffle wall to avoid surcharge"*
- the storage-pipe material clause, naming *Storm Pro, BlackMax, Enviro or equivalent*

And Yarra's time-of-concentration table is **identical to Maroondah's**, number for number:

| Total lot size | Tc |
|---|---|
| ≥ 4000 m² | 12 min |
| ≥ 750 m² | 9 |
| ≥ 500 m² | 8 |
| ≥ 350 m² | 7 |
| < 350 m² | 6 |
| Multi-storey / high density | **5** |

**So these councils are not each inventing their rules — several share a base text and vary it.** That is
worth building for: a **shared default set that a council inherits and overrides**, rather than 22
independent records each filled in by hand. It also explains how the wrong 1:200 grade spread across five
councils in CE's data — the same copying habit, but without the checking.

**Where Yarra and Manningham differ is as telling as where they agree** — Manningham requires UPVC storage
pipe at **SN4** minimum, Yarra at **SN8**.

## 3. Yarra's own numbers

**Minor system design capacity, by development type:**

| | AEP | ARI |
|---|---|---|
| Residential | 20% | 1 in 5 |
| Commercial | 10% | 1 in 10 |
| **Industrial** | **5%** | **1 in 20** |
| **Major commercial** | **5%** | **1 in 20** |

Major system: **1% AEP (1 in 100)** unless Council approves otherwise.

**Detention:**
- PSD at **20% AEP**, SSR at **10% AEP**
- PSD limited to *"the equivalent of a **70% impervious site coverage**, or the pre-developed discharge rate
  if it is less"*
- **No detention required at all** for an extension or a new single dwelling **if the proposed impervious
  area is under 70% of the site**
- Where no safe overland flow path exists, or flows above pipe capacity could affect the development or
  neighbours, **detain the 1% AEP instead**
- Rational method `Q = C·A·I₂₀ / 3600`, with **rainfall from the BoM 2016 IFDs**
- Uncontrolled runoff: **PSD adjusted = PSD − Q of the uncaptured area** (same rule as Maroondah)
- Separate detention systems must have storage and discharge **directly proportional to the catchment
  feeding each**

**Compare the impervious threshold across councils** — it is not one number:

| Council | Detention triggered above |
|---|---|
| Banyule | **65%** impervious (single dwelling) · 35% (carpark) |
| **Yarra** | **70%** impervious |
| Maroondah | PSD set at the equivalent of **35%** coverage |
| Yarra PSD basis | equivalent of **70%** coverage |

**Software:** *"Council will only accept detention calculation using the **Swinburne OSD Method**. A computer
program such as **InSite Water** (or equivalent package) must be used."* — the first council to name InSite
rather than OSD4.

**Pipe grades and velocities** (identical to Maroondah):
- 100 mm diameter → **1 in 100** · 150 mm diameter → **1 in 80**
- minimum **0.75 m/s** running half full or more · **1.00 m/s** running less than half full

## 4. Pipe, cover and connection rules

**Private pipe in the road reserve:**

| Connection | Min cover | Min size | Material | Class |
|---|---|---|---|---|
| To kerb | **50 mm** | ø100 | galvanised steel CHS, UPVC | 250 steel grade; SN6/8/10 |
| To kerb | 50 mm | 150 × 100 | galvanised steel RHS | 250 steel grade |
| Direct to pipe or pit | **500 mm** | ø150 | UPVC, RCP | SN8/10; Class 4 or 6 |

**Public (outfall) pipe:** behind kerb and under road pavement — **500 mm cover, 375 mm minimum diameter,
RCP Class 4 or 6**.

**Galvanised steel pipe is required** where the vertical clearance from the surface to the top of the LPD
pipe is **less than 600 mm**.

**Connecting to Council's system:**
- Council's pipe must be **three times larger** than the incoming pipe — a 100 mm private pipe needs a
  300 mm Council pipe *(the same 3× rule Manningham uses)*
- Council pipe in a road reserve: **minimum 300 mm**; under road pavement: **minimum 375 mm**
- An existing Council pit must be **at least 600 × 900** or it must be **reconstructed**
- **No direct connection to brick drains** or similarly fragile materials
- Kerb connection: a **surcharge pit inside the property boundary** before the pipe exits, positioned so
  water surcharges towards the road; **at least 200 mm outside the splay of a vehicle crossing**
- Laneway surface discharge: pipe **flush with the boundary**, invert **150 mm above** the laneway surface

**Outlet pipe to the LPD:** minimum **100 mm at 1:80** (kerb openings excepted).

## 5. Drafting rules the plugin could check

| Rule | Value |
|---|---|
| **Pipe lengths must match the manufacturer's lengths**, *"to avoid small pipe sections adjacent to pit"* | — |
| Fall through a detention pit | **10 mm minimum nominal** |
| Pit covers and grated covers | **higher than the top of the baffle wall** |
| Storage pipe class | RCP or FRC **Class 2 minimum**; UPVC **SN8** sewer grade (Storm Pro, BlackMax, Enviro) |
| Storage pipe under a trafficable area | class and grade certified by an engineer for the imposed load |
| Plans | **north point and a revision table**; A1 at **1:100** |
| **Two summary tables required** | PSD · SSR · total storage volume — and — total area · pre-development impervious · post-development impervious |
| Pit schedule | **required** |
| Long section of the LPD connection | cover levels, invert, vertical and horizontal offsets from existing services, depth to surface, conduit size |
| Cross sections | of pipes, pits and utility crossings |
| Roof catchment to each tank | **shaded and labelled in m²** |
| Trees | every tree to be retained shown, including neighbours' and the road reserve |

**Pit lids by where the pit sits** — Yarra's version, and it differs from Manningham's:

| Where | Lid |
|---|---|
| Paved areas | **grated** |
| Grassed / landscaped | **concrete** |
| Crossovers | **Class C** |
| Driveways / front yard | **Class B** |
| Rear yard | **Class A** minimum |

**Two verbatim plan notes are required**, which is the second council after Mornington Peninsula to demand
exact wording:

> *"Minor drainage pipe (up to 150 mm diameter) excavation to be dug by handheld shovel under the canopy of
> any existing tree to be retained. Tree roots >30 mm diameter must not be severed."*

> *"All plumbing for re-use to comply with AS/NZS3500 Part 2."*

Plus a backfill notation: *20 mm nominal size class 2 fine crushed rock in 150 mm layers to 95% modified
compaction, AS1289-5.2.1*.

**The pipe-length rule matters for work in flight.** *"Pipe lengths to match manufacturer's pipe lengths, to
avoid small pipe sections adjacent to pit"* is a council requirement that bears directly on splitting a pipe
where a pit is placed — a split that leaves a short offcut beside a pit is exactly what Yarra is asking us
not to draw.

## 6. Groundwater and basements — a fifth answer, and the strictest

> *"Basements within **2 m of groundwater must be tanked** and **no groundwater to discharge to LPD**.
> Council does **not** accept the collection and transfer (i.e. pump systems) of groundwater to any of
> Council's public stormwater network. Any interacted groundwater must be kept from penetrating the
> sub-surface structures, **including the agricultural drains at the interface of the ground and the
> structure**."*

A geotechnical report with the groundwater table must be submitted, and an engineering design for the
basement to manage groundwater.

**Running total on the basement question — five councils, five answers:**

| Council | Basement water |
|---|---|
| **Yarra** | tank it if within 2 m of groundwater; **no pumping groundwater to the network at all**; agi drains at the interface must not let it in |
| Darebin | groundwater, fire tank water and seepage **must not** enter stormwater — trade waste to sewer, treat on site, or licensed disposal |
| Boroondara | basement groundwater must **not** drain to laneways, kerbs or channels |
| Manningham | basement pumps **may** discharge into the detention, with the rising main invert at or above the top of the baffle wall |
| Maroondah | an **extra** 1-in-100, 60-minute store for the basement catchment, unless an automatic backup pump and generator are installed |

**This is now the most divergent rule found.** Open question C1 stands, and it matters more with every
document.

## 7. Other

**Rainwater tanks:** minimum **2000 L for reuse**, dedicated to toilet flushing and irrigation, per VBA
guidelines. Below-ground tanks under traffic loading need a **Certificate of Compliance (design)**. Section
details required showing detention overflow levels, orifice arrangement and offtakes.

**Detention siting:** readily accessible for maintenance; **not under buildings or concrete slabs**; an
existing dwelling that stays must be **connected** to the system; on private land, ideally common property;
outside Tree Protection Zones, and non-destructive methods with an arborist if unavoidable.

**Multi-cell accepted**, with risers on all inspection openings and inlet/outlet sizes and inverts shown.

**Flooding:** check Yarra's flood mapping at the **year 2100 scenario** — the only council read that names a
climate scenario in its checklist.

**WSUD:** Blue Factor Report and MUSIC modelling.

**Standards:** the checklist asks for a pump pit detail *"in accordance with **Section 9 of AS3500.3**"*.
Section 9 is the **2003** numbering for pumps; the 2015 and 2018 editions put pumps at Section 8. Recorded
as an observation — it may be an old reference carried forward, and no edition year is named anywhere in
either document. **Not treated as a ruling on which edition Yarra wants.**

**The designer signs the checklist**, stating they are a qualified and experienced civil engineering
professional taking responsibility for compliance.

## 8. Questions

1. **The orifice coefficient can probably be closed now.** Yarra and Maroondah both state 0.6 for a round
   pipe in the same words, Frankston has 0.6 inside its formula, and Darebin alone says 1.0. Is the answer
   *0.6 everywhere, Darebin recorded as the exception*?
2. **Yarra requires pipe lengths to match the manufacturer's lengths**, so there are no short offcuts beside
   a pit. When the plugin splits a pipe at a new pit, should it be trying to land on real pipe lengths?
3. **Several councils share the same base text** — Yarra repeats Manningham's checklist lines word for word,
   and Yarra's time-of-concentration table is identical to Maroondah's. Should the plugin hold one shared
   default set that each council inherits and overrides, rather than 22 separate records? It would also stop
   the kind of copying error we found on the 1:200 grade.
4. **Detention is triggered above 70% hard surface at Yarra, 65% at Banyule.** Is that threshold being
   checked per council, or is detention assumed on every multi-unit job?
5. **Basements — now five councils and five different answers**, and Yarra is the strictest: no pumping
   groundwater to Council's network at all, and the agricultural drains at the building interface must be
   kept from letting it in. Which rule have we been working to?
