# Kingston — Civil Design Requirements Part A, Issue 5 (2025)

**15 September 2026.** Source: *Civil Design Requirements for Developers — Part A: Integrated Stormwater
Management*, City of Kingston, **Issue 5, 2025**. The clause Tim quoted earlier is from this document.

The office also holds **Issue 3 (June 2013)**. This is the first council document read in full, and it is a
complete, checkable specification — far more than the guidebook summary carries.

---

## 1. It settles the standards question outright

> *"All private drainage shall be designed in accordance with **AS/NZS 3500.3: 2021** Plumbing and drainage,
> Part 3: Stormwater Drainage."*

**A council names the edition, by year.** That closes STD-02: CE must hold **AS/NZS 3500.3:2021**, because
Kingston requires compliance with that edition specifically — not "the latest", and not the 2018 copy the office
has, and certainly not the 2003 copies sitting in `Civil Stuff`.

This also means the guidebook's clause numbers (§6.2.5 cover, §6.3.4 gradients, Section 8 pumps), which I verified
today as correct for **2018**, must be **re-checked against 2021** before the plugin prints any of them.

## 2. Permissible site discharge — more detail than the guidebook has

**Residential**
- **20% AEP** (formerly 1 in 5 ARI)
- **C = 0.4 regardless of existing site imperviousness**
- **Tc = 5 minutes** for lots under 1000 m²; designer determines the critical storm duration above that
- Store the difference between the C = 0.4 discharge and post-development discharge at 20% AEP

**Industrial and commercial** — *this is not in the guidebook at all*
- **10% AEP** (formerly 1 in 10 ARI)
- **C = the lower of** existing site imperviousness (where C < 0.7) **or C = 0.7** — the cap exists because of
  limited capacity in Council's system
- **Tc = 7 minutes** for lots under 1000 m²
- Alternatively the designer may investigate Council's downstream network capacity (to where the pipe is at
  least 600 mm) and put that to Council

So **the design storm depends on the development type**, not just the council. A residential job and an industrial
job on the same street use different storms and different coefficients.

## 3. Rainwater tanks — exact numbers

- **Minimum 2,000 L per dwelling**, connected to a **minimum 50 m² of roof area**, unless otherwise approved.
- Detention contribution from tanks serving a **separate individual dwelling**:
  - **500 L of storage for each 2,000 L tank**, or
  - **1,000 L for tanks of 2,500 L or greater**
- **Not applicable where combined tanks are proposed**, such as apartment buildings.

That last exclusion matters: the offset is per-dwelling, and a shared tank in an apartment block gets none.

## 4. Soakwells

- Base **minimum 500 mm above the groundwater table**, confirmed by measurement
- Outside edge **at least 2 m from building foundations and property boundaries**
- Permeability (saturated hydraulic conductivity) test by a qualified geotechnical engineer — **no exceptions**

## 5. Flood management — all 1% AEP

**Freeboard above designated flood levels, in a Special Building Overlay:**

| Building type | Minimum freeboard |
|---|---|
| Main buildings / extensions | **300 mm** |
| Outbuilding / garage | **150 mm** |

- Site levels must provide a **1% AEP flow path around all dwellings and garages**. Where that cannot be achieved,
  the design must **detain the 1% AEP flows from the upstream catchment**.
- **Basement entrances**: pavement level **minimum 100 mm above the 1% AEP flows along the adjacent roadway**; the
  apex at the top of the ramp is set to achieve that where the footpath cannot.
- **No sub-surface water** — groundwater, seepage or perched water — into the stormwater system.
- **Flood safety criteria**: max depth **0.35 m**, max velocity **1.5 m/s**, max depth × velocity **0.35 m²/s**.

**Note the freeboard numbers.** Tim's LEVEL-01 ruling set the *detention* freeboard at 150 mm standard. These
300/150 numbers are a different thing — freeboard above a *flood level* in an overlay. Both exist; they must not
be conflated in Settings.

## 6. Connections

- Private connection to an existing Council pit: **minimum 150 mm above the base/invert of the pit**
- Connections into Council pipes: the Council pipe must be **225 mm diameter or larger**
- Opening Permit required for all connections to Council assets, per **S501** (kerb and channel) or **S503**
  (Council drain)
- **No private drainage within easements** unless Council specifically requests it

## 7. How impervious area is counted — a real calculation rule

> Impervious = all surfaces that are not vegetated soil; and **grey surfaces (gravel, Lilydale toppings or
> similar) and porous paving counted at × 0.5**, allowing for an assumed 50% perviousness.

The plugin measures areas from the drawing, so it must apply the **0.5 factor** to grey and porous surfaces
rather than counting them as fully impervious or fully pervious. This directly changes the discharge calculation.

## 8. What must be shown on the drawing — a checkable list

North point · layout plan showing all dwellings, garages and drainage alignments (existing **and** proposed) ·
**pit numbers and pit schedule** · pavement makeup · Kingston construction notes · details of all detention
systems, tanks, soakwells or pump systems · **finished floor levels of all dwellings and garages** · tree
protection zones · rainwater tank locations · raingardens and other treatment measures · **percentage of
impervious area** · engineer's contact details · easements and Council assets.

**And a consistency requirement worth building a check on:** every one of those — floor levels, TPZ, tank
locations, raingardens — must be **consistent with the endorsed architectural and landscape plans**, or the plans
may need re-endorsement by Planning. That is a drawing-against-drawing comparison the plugin is well placed to
make.

## 9. What this changes

1. **Buy AS/NZS 3500.3:2021.** A council now requires it by year.
2. **Design storm depends on development type**, not only council. The council profile needs residential and
   industrial/commercial cases with different AEP, C and Tc.
3. **The 0.5 factor for grey and porous surfaces** must be in the area measurement, not applied by hand.
4. **Two different freeboards exist** — detention (150 mm, Tim's ruling) and flood overlay (300/150 mm). Separate
   Settings values.
5. **The "consistent with endorsed plans" rule** is checkable and currently manual.

## 10. Questions

1. **Issue 3 (2013) vs Issue 5 (2025)** — worth diffing, as the guidebook was written somewhere between them?
2. **Tc = 7 minutes for industrial/commercial** is not in CE's guidebook. Is it being applied today?
3. The **C = 0.7 cap** for industrial/commercial likewise — is that in the Boyd's workbook, or applied by hand?
4. Does CE currently apply the **0.5 factor** to gravel and porous paving when measuring impervious area?
