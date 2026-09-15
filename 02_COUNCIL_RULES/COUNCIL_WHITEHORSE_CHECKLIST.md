# Whitehorse — Checklist for Submission of Engineering Civil Plans (2019–2020)

**15 September 2026.** Source: Whitehorse City Council, *Checklist for Submission of Engineering Civil
Plans*, **one page**, 2019–2020.

**Set expectations first: this document contains no design parameters.** No runoff coefficients, no time of
concentration, no orifice rules, no pipe classes, no storm frequencies. It is purely a list of what must
appear on the drawing, plus who must sign it.

So it **cannot verify any of CE's stored Whitehorse numbers** — see §3.

---

## 1. What it asks for on the plans

**Survey information:**

| | |
|---|---|
| Property boundaries · street names · **north point** | |
| Levels to **AHD**, benchmark indicated on the plan | |
| **Existing and design contours at 0.1 m for flat sites, 0.2 m on other sites** | extending **10 m into adjoining properties** |
| Boundary levels · site features (trees, depressions) | |
| Drainage easements **within the property and on adjoining properties** | |
| Approved **Legal Point of Discharge** identified | |
| **Overland flow paths** identified for flood-prone sites | |
| Services in the **public footway** — exact location and depth where connecting to a Council drain or pit | |
| For a new pipeline in the roadway — depth and location of services in the roadway | |

**The contour rule is the first of its kind found.** Every other council asks for contours; Whitehorse is
the only one to make the interval depend on how flat the site is, and to say how far beyond the boundary
they must run.

**Design information:**

| | |
|---|---|
| Final development layout · drainage layout with **pipe sizes, grades and levels** | |
| Proposed **finished floor, garage and ground surface levels** to AHD | garage called out separately |
| **Location, levels, dimensions AND volume** of the on-site detention | |
| Full hydrologic and hydraulic calculations **as per Australian Rainfall and Runoff** | |
| Full hydrologic and hydraulic calculations **for the on-site detention system** | |
| **Hydraulic grade line analysis — calculations and long-section plots** for pipelines requiring analysis | |
| Tree Protection Zones on the civil plans where a Planning Permit is required | |
| Evidence of submission to **Land Victoria** to register new drainage easements | |
| Scale **1:100 or 1:200** · 2 sets of plans · 1 set of calculations | |

**Who signs:**

- **Designer's name, qualifications and contact details on the plans**
- Plans prepared by a suitably qualified professional engineer; *"Council may require all plans to be
  prepared by a civil engineer who is included in the **National Professional Engineers Register**"*
- The OSD design must be **certified by a registered consulting engineer** on the Engineers Australia NPER
  or approved equivalent

## 2. Where Whitehorse sits among the councils

**It points at ARR rather than publishing values** — the same posture as Mornington Peninsula. That makes
two councils that expect the calculation to be done to the national standard and shown, rather than looked
up from a council table.

**It is the first council read that does not ask for a pit schedule.** Frankston, Mornington, Darebin and
Banyule all require one; Whitehorse asks for pipe sizes, grades and levels on the layout instead.

**It wants the detention volume written on the plan**, not only in the computations — alongside location,
levels and dimensions.

## 3. What this does NOT tell us — and what stays unverified

CE's stored Whitehorse profile holds:

| Field | Stored | Status after this document |
|---|---|---|
| `psdMethod` | `boyds` | **unverified** — and this checklist asks for calculations *"as per Australian Rainfall and Runoff"*, which is not the same posture as a nominated Boyd's method |
| `orificeMinMm` | **90.0** | **unverified** |
| `psdAri` / `storageAri` | 5 / 10 | unverified (the stored warning says the same, but neither is in this document) |
| `perviousC` / `tcMinutes` | 0.35 / 5 | unverified |
| `minUndergroundPct` | 0 | unverified |

**The 90 mm minimum orifice is worth flagging on its own.** It is by far the largest of any council:

| Council | Smallest orifice |
|---|---|
| Darebin | 30 mm |
| Banyule | 40 mm |
| Manningham | 40 mm |
| **Whitehorse** | **90 mm** |

A 90 mm hole passes roughly five times the flow of a 40 mm one at the same head. If that figure is right it
changes Whitehorse designs profoundly — the orifice can rarely be the thing limiting discharge, and the
stored warning hints at exactly that (*"baffle height limitations may apply"*). If it is wrong, every
Whitehorse orifice is being drawn too large. **It needs a Whitehorse source document, and this is not it.**

## 4. Questions

1. **Where did Whitehorse's 90 mm minimum orifice come from?** It is more than twice any other council's
   minimum, and a 90 mm hole passes about five times the flow of a 40 mm one. If it is right it shapes
   every Whitehorse job; if it is a typo it has been shaping them wrongly. Is there a Whitehorse guideline
   or a council letter on a past job that says it?
2. **This checklist asks for the calculations to be done to Australian Rainfall and Runoff**, the same as
   Mornington Peninsula — but we have Whitehorse recorded as a Boyd's-method council. Do you know which
   Whitehorse actually wants?
3. **They want contours at 0.1 m on flat sites and 0.2 m elsewhere, running 10 m past the boundary.** Is
   that what our survey drawings carry, or would a Whitehorse job need the survey re-drawn?
4. **The detention volume has to be written on the plan itself**, not just in the calculations. Is that
   on our drawings today?
