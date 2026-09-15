# Frankston — Guidelines for Subdivisional, Multi-Dwelling & Industrial Developments

**15 September 2026.** Source: Frankston City Council, 129 pages, **last updated 20/12/2005**.

**This is the document the other two Frankston files point at.** The OSD Guidelines say *"refer to Council's
Development Guidelines for details on estimation of runoff"* and again for soakage sizing — this is it. Section 5
Stormwater Drainage is the part that governs CE's work.

**Caveat on age:** 2005, so twenty years old and predating ARR 2019. It is still the referenced document in
Frankston's own 2021 OSD Guidelines, so it is current by reference even though its content is not.

---

## 1. Runoff coefficients by development type

| Development | C |
|---|---|
| Residential subdivisions (not incl. road reserves) | **0.4** |
| Residential allotments **> 500 m²** | **0.4** |
| Residential allotments **< 500 m²** | **0.6** |
| Industrial & commercial, **and flats/units** | **0.8** |
| Rural, including parks and reserves | **0.3** |

**Note flats and units are grouped with industrial at 0.8**, not with residential. On a multi-unit job — which is
most of CE's work — that is the coefficient, and it is double the 0.4 used for a house on a large block.

## 2. Recurrence interval by development type

| | |
|---|---|
| Residential subdivisions | **1 in 5 years** |
| Industrial / commercial & flats/units | **1 in 10 years** |
| Designated floodways / overland flow paths | **1 in 100 years** |
| Undrainable depressions | **1 in 100 years** |

## 3. Time of concentration — and it differs sharply from Kingston

| | Frankston |
|---|---|
| Residential subdivisions (generally) | **7 minutes** |
| Low density subdivisions | **9 minutes** |
| **Industrial / commercial & multi dwelling** | **3 minutes** to head of line, or computed |
| From road to first pit | **3 minutes** |

**Compare Kingston:** 5 minutes residential, 7 minutes industrial/commercial.

So the two councils not only use different numbers, they run in **opposite directions** — Kingston gives
industrial the *longer* time, Frankston gives it the *shortest*. A shorter time means a heavier rainfall
intensity and a bigger flow, so Frankston's 3 minutes for multi-dwelling is markedly more conservative.

**This is the strongest argument yet for holding time of concentration per council and per development type**
rather than as one office default. Getting it from memory would be very easy to get wrong.

## 4. Pipe capacity — the equations named

**Colebrook-White**, roughness `k`:
- precast concrete **0.6**
- smooth (non-profiled) UPVC **0.015**

**Manning's**, roughness `n`:
- precast concrete **0.013**
- UPVC **0.009**

**Flow velocities:**
- minimum, pipe running **half full or more**: **0.7 m/s**
- minimum, pipe running **less than half full**: **1.0 m/s**
- maximum, to prevent scouring: **6.0 m/s**

CE's library holds a `Mannings Formula_SWS` spreadsheet, so Manning's is already in use. **The velocity limits are
a direct check the plugin can run** on every pipe once it holds diameter, grade and flow.

## 5. Minimum pipe sizes and cover

- **300 mm minimum** for pipes under road pavements, or where a line picks up surface runoff from a street

**Minimum cover:**

| Location | Cover (mm) |
|---|---|
| Not subject to vehicle loading, without pavement | **500** |
| Subject to vehicle loading, other than roads, without pavement | **500** |
| …with reinforced concrete pavement, heavy vehicles | **100** below underside of pavement |
| …with brick or un-reinforced concrete, light vehicles | **75** below underside |
| Roads, sealed | **600** |
| Roads, unsealed | **> 600** |
| Construction equipment loading or embankment | **500** |

**Approved pipe types:** reinforced concrete RRJ · fibre-reinforced concrete RRJ · **sewer grade UPVC under
150 mm diameter**. Class 2 subject to cover and loading.

## 6. Overland flow and cut-off drains

- Overland flow paths designed for **1 in 100 year ARI**
- Lots exposed to flow from adjacent undeveloped land get an open earth **"V" drain, 2.0 m wide × 400 mm deep**
  at centre, shaped, topsoiled and seeded, with silt traps at intervals
- **"V" drains deeper than 1000 mm must be piped for their full length** with grated catch pits
- Major system designed so a 1 in 100 year storm will not flow over private property except through a designated
  floodway, nor build up to flood a floor
- Must comply with **ResCode Element 12b Major Stormwater Flows**

## 7. Computation presentation rules

- Catchment plans show **sub-catchment areas in hectares** and collection points by **pit number**, consistent
  with the computation sheets
- **Every pit and end wall — including those demolished, reconstructed or altered — has a pit number appearing in
  the pit schedule**, with remarks
- Computations include discharge from **external catchments passing through** the site
- The **hydraulic grade line is plotted on the drainage longitudinal section**
- Car park drainage computed by **Rational Formula or ILSAX**

The HGL-on-the-long-section requirement is worth noting: CE already draws long sections, so this is an addition
to an existing drawing rather than a new one.

## 8. What this adds to the picture

1. **Frankston's runoff coefficients and recurrence intervals are published** — unlike Bayside and Monash, which
   issue values on request. So Frankston is a council the plugin can compute for without an email.
2. **Time of concentration is per council AND per development type, and the councils disagree in direction.**
3. **Velocity limits (0.7 / 1.0 / 6.0 m/s) are a ready-made pipe check.**
4. **Flats and units take C = 0.8**, grouped with industrial.
5. **Minimum cover is a table, not a single number** — it depends on loading and pavement type.

## 9. Questions

1. **Is CE using Frankston's 3-minute time of concentration on multi-dwelling jobs?** It is much shorter than
   Kingston's, and a short time means a bigger flow. If 5 or 7 minutes is being used out of habit, the design
   would be *less* conservative than Frankston asks for.
2. **C = 0.8 for flats and units** — is that what CE applies on Frankston multi-unit jobs?
3. **This document is from 2005 and predates ARR 2019**, yet Frankston's 2021 OSD Guidelines still point to it.
   Has Council confirmed it is current, or is there a newer edition not published at this address?
4. **Are the minimum velocities being checked** on CE designs today, or only capacity?
