# Council design criteria — what the clause requires, and how much of it the drawing already knows

**15 September 2026.** Tim answered Q3 (*"is the Boyds Kingston variant per-council?"*) with a council's own
drainage requirements clause. It answers more than Q3, so it is recorded here in full rather than buried.

## 1. The clause

> Calculations shall be based on the most current version of **Australian Rainfall and Runoff (ARR)**, with
> **Rational method, OSD4 or Boyds method** being accepted as an alternative **at Council's discretion**, and
> designed to cater for the following criteria:
> - **20% AEP** storm event **with** a provision of piped overflow connected to the kerb and channel or Council
>   drainage system, **or**
> - **10% AEP** storm event **without** a piped overflow but with an acceptable overland flow path.
> - **1% AEP** capacity at trapped low points.
> - Soakwell and infiltration trench systems design calculation must comply with *"Water Sensitive Urban Design:
>   Engineering Procedures, Melbourne Water, 2005"*, with Council's requirements taking precedence where any
>   contradictions occur.

## 2. What this settles

**Q3 is answered, but not the way I framed it.** It is not that Kingston uses a different *Boyds*. It is that
**the method itself is a council choice** — Rational, OSD4 or Boyds, at that council's discretion. So the workbook
the plugin fills is chosen by the council profile, and a job for one council may legitimately use a different
method from the same job next door.

The existing `CouncilProfile` already has `psdMethod` (defaulting to `"boyds"`), so the shape is right. What it is
missing is everything else in this clause.

## 3. The part that matters most — the drawing already knows the answer

**The 20% / 10% choice is not a preference. It is decided by a fact about the drawing:**

| Condition | Design storm |
|---|---|
| A piped overflow **is** connected to kerb and channel or the Council drain | **20% AEP** |
| No piped overflow, but an acceptable overland flow path | **10% AEP** |

**The plugin can see which of those is true.** It knows whether an overflow pipe exists and where it discharges —
that is exactly what the LPD (legal point of discharge) and the network links record. So it should **pick the
right design storm itself and say which one it used and why**, rather than the engineer remembering the rule and
setting a number by hand. Getting this wrong is a whole-design error, not a detail.

**"1% AEP capacity at trapped low points"** is the same kind of thing. A trapped low point is a low point with no
overland escape — determinable from the drawing plus the surface. The plugin can *find* them, and check that
capacity, instead of relying on someone spotting them.

That turns this clause from a thing to remember into a thing to check.

## 4. What the council profile needs added

| Field | Why | Today |
|---|---|---|
| Accepted methods (Rational / OSD4 / Boyds) | Council's discretion — more than one may be allowed | `psdMethod` holds one; no "what is accepted" list |
| ARR version | *"most current version"* changes over time and dates every computation | absent |
| Design storm **with** piped overflow | 20% AEP here | `psdAri = 5` approximates it |
| Design storm **without** piped overflow | 10% AEP here | `storageAri = 10` approximates it |
| Trapped low point capacity | 1% AEP | absent |
| Soakwell / infiltration standard | WSUD Melbourne Water 2005, council overrides | absent |

**One real modernisation issue.** The model is written in **ARI** (`psdAri`, `storageAri` — 5 year, 10 year) while
the clause and current ARR are written in **AEP** (20%, 10%, 1%). They are near-equivalents, not identities, and
mixing the two conventions in one profile is how the wrong storm gets used quietly. The profile should carry
**AEP**, as councils and ARR now state it, with ARI shown only where an old workbook needs it.

## 5. Still open on this clause

1. **Is the accepted-method list per council, or is it always "any of the three at discretion"?** It changes
   whether the profile stores one method or a list with a default.
2. **Which ARR version is CE working to today** — and should a job record the version it was designed under, so a
   later reviewer knows?
3. **"Acceptable overland flow path"** is a judgement. Should the plugin ask the engineer to confirm one exists
   before it uses the 10% AEP case, and record that confirmation?
4. **Do all your councils use this same 20/10/1 structure**, or do the numbers vary? If they vary, they are
   straightforward Settings values; if the *structure* varies, the profile needs to be more general.
