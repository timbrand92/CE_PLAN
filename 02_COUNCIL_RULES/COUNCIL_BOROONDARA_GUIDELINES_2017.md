# Boroondara — Stormwater Drainage and Build-Over Easement Guidelines (January 2017)

**15 September 2026.** Source: City of Boroondara, *Stormwater Drainage and Build-Over Easement Guidelines*,
**January 2017**, 35 pages. Adopted 17 January 2017; the printed review date of 17 January 2018 has passed.
Supplied by Tim.

**This is the document behind the web page** written up in `COUNCIL_BOROONDARA_OSD.md` — and it publishes
the values that page does not.

---

## 1. Correction — an earlier statement is superseded

`COUNCIL_BOROONDARA_OSD.md` §1 says Boroondara *"publishes no values — Council issues the PSD and the
volume"*, and lists `psdAri`, `storageAri`, `perviousC`, `imperviousC` and `tcMinutes` as *"not published
here… unverified"*.

**That was right about the web page and wrong about the council.** This document publishes all of them, plus
the calculation method and two charts. **That statement is superseded, 15 September 2026.** Everything else
in that file stands and is confirmed here.

Both things remain true at once: Council *"will endeavour to provide an assessment of the permissible site
discharge and on-site detention storage volumes when responding to Legal Point of Discharge applications"* —
**and** it publishes how those numbers are derived.

## 2. Checked against CE's stored Boroondara profile

| CE holds | Boroondara January 2017 | |
|---|---|---|
| `psdAri: 5` | *"For determining permissible discharge: **1 in 5 years**"* | ✅ now sourced |
| `storageAri: 10` | *"For determining OSD volume: **1 in 10 years**"* | ✅ now sourced |
| `standardDrawings: ["SD999"]` | Appendix B is **SD999 Revision J, 01.06.2013** | ✅ revision confirmed |
| warning: *"single-chamber orifice pit with an orifice plate… NOT the standard two-chamber baffle pit"* | *"**Boroondara does not support the use of weir pits.** The standard control pit is designed to overflow at surface in order to alert property owners to problems with the system"* | ✅ exactly — now with Council's reason |
| `minUndergroundPct: 100` | storage is *"storage pits and pipes upstream of a control pit"* | ✅ consistent |
| `calibrationNote`: *"blended single-lot C ~0.65"* | *"The combined runoff coefficient used for post-development conditions is to be based on proposed land use **or 0.65 whichever is greater**"* | ✅ 0.65 is a real council floor, not a calibration artefact |
| **`tcMinutes: 5`** | *"For all locations: **Tc = 15 minutes** and Tcs = 6 minutes"* | ❌ **should be 15** |
| **`tsoMinutes`** unset | **Tcs = 6 minutes** | ❌ should be 6 |
| **`psdMethod: council-provided`** | the method is the **Swinburne Method** (Appendix C); Council *also* supplies the values | ⚠ both true — the method is not recorded |
| `perviousC: 0.35` / `imperviousC: 0.9` | Boroondara uses **combined site** coefficients, not surface ones | ⚠ wrong shape for this council |

**Tc = 15 minutes is the longest of any council read**, and it is flat across the whole municipality — *"has
been adopted for any locality within the municipality **for consistency reasons**"*.

| Council | Time of concentration |
|---|---|
| Frankston | 3 (multi-dwelling) / 7 / 9 |
| Kingston | 5 / 7 |
| Maroondah, Yarra | 5 – 12 by lot size |
| Darebin | 10 |
| **Boroondara** | **15, every site** |

## 3. The coefficients — a fifth council putting 0.35 on the whole site

> *"The City of Boroondara defines pre-existing conditions as the site conditions that were present **before
> any urban development**. This corresponds to sparsely developed land with a **combined runoff coefficient
> equal to 0.35**. The permissible site discharge must be based on this value and **is not influenced by the
> actual (existing) site coverage**."*

| Parameter | Boroondara |
|---|---|
| Pre-existing combined C | **0.35**, regardless of what is on the site |
| Pre-existing % impervious | **35%**, regardless of site conditions |
| Post-development combined C | **proposed land use, or 0.65, whichever is greater** |
| Tc / Tcs | **15 / 6 minutes**, every site |
| PSD / SSR | 1 in 5 / 1 in 10 ARI |
| Rainfall | Australian Rainfall and Runoff |
| Method | **Swinburne** (Appendix C) |

**This is the fifth council to use 0.35 as a whole-site figure** — with Banyule, Maroondah, Darebin and
Frankston — and the first to state outright that it is **not** a surface coefficient and **not** related to
what is actually on the ground.

`FINDING_PERVIOUS_C_SPLIT.md` holds, and now with five councils behind it: **0.35 is a site number, 0.30 is
the soft-ground number, and CE has the site number sitting in the soft-ground field.**

## 4. When detention is required — a fourth different threshold

| Development | OSD required |
|---|---|
| New commercial or residential on a lot **under 300 m²** | **No** — *"difficult to achieve OSD requirements on small block"* |
| New single residential, **under 80%** impermeable coverage | **No** — *"provision OSD is preferred but not required"* |
| New single residential, **over 80%** impermeable coverage | **Yes** |
| New commercial, or residential with **2 or more dwellings** | **Yes — mandatory** |

**Boroondara 80% · Yarra 70% · Banyule 65%** (35% for a carpark). Four councils, four thresholds — and
Boroondara is the only one that also excuses detention below a **lot size**.

## 5. A rule no other council has: how far you must extend an outfall

Table 3-2 sets the *"reasonable length of drain required"* before Council accepts that an outfall cannot be
built:

| Development | To kerb | To easement |
|---|---|---|
| Lot under 300 m², or new single residential | **15 m** | **60 m** |
| Residential, 2 dwellings | 30 m | 60 m |
| Residential, 3–6 dwellings | 60 m | 100 m |
| Residential, more than 6 dwellings | **100 m** | **150 m** |
| Industrial / commercial, lot under 1000 m² | 30 m | 60 m |
| Industrial / commercial, lot over 1000 m² | **100 m** | **150 m** |

To deviate, the applicant must **demonstrate to Council** that it cannot be done for engineering or
environmental reasons. Nothing in CE's data holds a rule of this kind, and it decides whether a job carries
an outfall drain at all — which is a cost and scope question, not a detail.

## 6. SD999 Revision J — the control pit in full

**This is the detail CE must draw on a Boroondara job.** Read from the drawing in Appendix B (01.06.2013).

**Pit size by depth to invert:**

| Depth | Internal size | |
|---|---|---|
| To 900 | **600 × 600** | |
| To 1200 | **900 × 600** | **step irons required** |
| Over 1200 | **900 × 900** | **step irons required** |

**Step irons over 900 deep** — matching Tim's own ruling and Maroondah's table. **A third independent
source**, so the office rule can be promoted from assumption to sourced.

**Orifice plate:**
1. Plate size = the **greater of 300 × 300 mm or 3 × the orifice diameter**
2. Plate thickness **minimum 6 mm** — stainless steel, galvanised or zinc-coated steel
3. Fixed by construction adhesive **plus 4 × Ø10 × 100 mm stainless steel vandal-proof shear-head masonry
   anchors**, or alternatively cup-head bolts permanently fixed with ChemSet or equivalent.
   **Hexagonal-head nut/bolt hardware is not accepted.**

**Trash mesh:**
4. **Maximesh RH3030** or equivalent expanded steel mesh, galvanised or zinc coated
5. Affixed to **40 × 40 × 5 mm equal angle** by at least **2 × 10 mm** galvanised / zinc / stainless nut and
   bolt, bolts welded in place so they are retained on the angle
6. Angle sections **minimum 300 mm long**, fixed to the pit walls
7. **Where the orifice exceeds 105 mm**, mesh length is derived from a **minimum 50 × orifice area**
   calculation
8. Pit cover **heavy duty grated type** if in common property or a trafficable area
9. **Pit walls and base minimum 125 mm thick, Fc25 MPa concrete**
10. Where the pit is wider than 600 mm, a **40 × 40 × 5 equal angle welded across the full width of the mesh**
11. **Mesh perforations oriented with the long dimension horizontal and in the direction of stormwater flow**

**Geometry:** inlet invert = **outlet invert + 50 mm** · **300 mm sump** · **25 mm weep holes** · L minimum
700 · an alternative side-outlet arrangement is drawn with 100 minimum / 900 maximum dimensions.

**So the sump and the weep holes are Council's own detail** — 300 deep, 25 mm — which answers half of open
question **C10**. What remains is whether **CE's** Boroondara detail draws them, since Council photographs
both at inspection and calls the photographs mandatory.

**CE's existing record is confirmed exactly.** `ORIFICE_STANDARD_DETAILS_PLAN.md` describes the Boroondara
variant as *"single-plate, min 6 mm stainless, maximesh screen, chemset anchors, ref SD999 Rev J"* — every
element of that checks out against the drawing, **including the revision letter**.

## 7. Easements and building over — nothing else read covers this

- A drainage easement is typically **1.8 m to 3.0 m** wide; floodway easements much wider
- **Implied easements** (Water Act 1989, s.148): where a Council drain crosses a property with no easement
  on title, *"no structure can be built, or any filling placed, **within one metre laterally** of any works
  of the Relevant Authority without permission"* — the same protection as a registered easement. Many
  *"Health Act"* drains in Boroondara are in exactly this position.
- Build-over criteria: must not interfere with the asset or **place additional load** on it; access kept
  along the alignment; **generally a minimum 1 m clearance around any access pit**; access to the stormwater
  connection maintained at all times; no obstruction to overland flow or flood levels
- **Dial Before You Dig** is the check when the owner does not know whether a Council asset is there

**This matters for the drawing.** A Council drain with no easement on title still carries a **one-metre
no-build zone either side**. A plan showing only registered easements is not showing the whole restriction.

## 8. Groundwater and sub-surface drains

> *"Council is **not required to accept this water** into its drainage systems."*

Sub-surface drains behind basements and retaining walls keep running long after the rain stops. Council
records *"almost continuous outflow from kerb outlets connected to sub-surface drains"* — a public nuisance
and a safety hazard. Conditions for acceptance are in the Appendix A factsheet, which in this file is **a
scanned image with no readable text** and would need reading visually.

Where no viable alternative exists, **Council will require an outfall drain constructed to the property
boundary**.

**Basements now stand at six councils, six answers** — see open question **C1**.

## 9. Overland flow

The existing network's design standard is a **1 in 5 year** event. A municipality-wide Stormwater Catchment
Analysis up to **1 in 100** was under way when this was written. Until it is published Council identifies
risk from available information, and **developers must read the topography themselves** — DELWP LandVic
contours at 1 m intervals are named as the source.

## 10. Questions

1. **Boroondara uses a time of concentration of 15 minutes on every site**, deliberately, for consistency.
   We have 5 minutes recorded for them. Fifteen is the longest of any council, and a longer time means a
   lighter rainfall and a smaller flow. Have Boroondara jobs been designed at 5?
2. **Their post-development coefficient has a floor of 0.65** — the proposed land use figure or 0.65,
   whichever is bigger. Is that floor being applied?
3. **The outfall-length table decides whether a job has to build an outfall drain at all** — 15 m to a kerb
   for a small lot, up to 150 m to an easement for more than six dwellings. Nothing in our data holds a rule
   like it. Is it being checked at the start of a Boroondara job?
4. **Does our Boroondara detail draw the 300 mm sump and the 25 mm weep holes**, and the mesh fixed to
   40 × 40 × 5 angle? Council's own drawing has them, and photographs them at inspection.
5. **A Council drain with no easement on title still has a one-metre no-build zone either side.** Are those
   drains being shown on our plans, or only the registered easements?
