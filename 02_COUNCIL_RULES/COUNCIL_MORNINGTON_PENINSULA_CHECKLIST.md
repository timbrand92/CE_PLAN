# Mornington Peninsula Shire — Checklist for Development Engineering Plan Approval

**15 September 2026.** Source: Mornington Peninsula Shire, *Checklist for Development Engineering Plan
Approval*, 4 pages, undated. Must be **fully completed and submitted with the plans** for approval.

**What kind of document this is.** A submission checklist, like Monash's — not a design criteria document.
It does not publish runoff coefficients, times of concentration or recurrence intervals. **It asks the
designer to state them.** That is itself the finding, and it points somewhere new.

---

## 1. The big difference: Mornington points at ARR and BoM, not at a council table

| Item | What the Shire asks |
|---|---|
| 4.2 | *"What return periods have been used for storage?"* — **a blank to fill in**, not a value Council sets |
| 4.3 | *"Are site-specific calculations of runoff coefficients in accordance with **Australian Rainfall and Runoff**?"* |
| 4.4 | *"Are design rainfall intensity values in accordance with **Bureau of Meteorology** values for the development location?"* |

**Every council read so far publishes its own table** — Kingston, Frankston and CE's guidebook all give C
values and times of concentration by development type. **Mornington does the opposite: it hands the
designer back to the national standard and the BoM rainfall data for that exact location, and asks them to
show their working.**

Practically, this is the first council that would accept a properly computed, site-specific coefficient
rather than a lookup. It also means "site-specific" and "in accordance with ARR" are the words the
computation has to be able to answer to.

**The Tc trap noted at Frankston does not apply here** — there is no Mornington Tc to get wrong. The risk
is the reverse one: submitting a Kingston-style table value where the Shire expects a calculation.

## 2. Detention — critical storm duration must be shown

| | |
|---|---|
| 5.2 | *"Has **critical storm duration** been identified for detention volume calculations?"* |
| 5.3 | *"Are **levels at ends of in-ground detention storage** adequate to detain required volumes?"* |
| 5.4 | Orifice pits to Shire standard drawings **MP244-1** and **MP244-2** |

5.2 is a real requirement, not a formality: it is not enough to state a storage volume, the submission must
say **which storm duration was critical** and therefore governed the volume.

5.3 is the TWL check in the Shire's own words — *levels at the ends of the storage*, i.e. the detention
pipe run has to be shown to actually hold the volume at the levels drawn. That is exactly what CDTWL
computes (pits + pipes + tank below the TWL), so this is a council asking in writing for the number the
plugin already produces.

## 3. Pipe and pit materials — a stricter minimum than Frankston

| | Mornington | Frankston |
|---|---|---|
| Concrete pipe | **minimum Class 3** rubber ring joint RCP | Class 2, subject to cover and loading |
| UPVC | **Sewer class** | Sewer grade, under 150 mm dia. |

**So the minimum concrete pipe class is a per-council value**, the same way the Australian Standard edition
turned out to be. Class 2 is acceptable at Frankston and would be refused here.

Shire standard drawings called up by number:

| Element | Drawing |
|---|---|
| Pit lids | **MP232** or **MP236** |
| Pit grates | **MP220** and **MP238** |
| Orifice pits | **MP244-1**, **MP244-2** |
| Pipe backfill under road pavement | **MP601** |
| Vehicle crossings | MP301 / MP302 / MP303 |
| Driveway grades | MP307 (with AS2890.1) |

## 4. Plan notes the Shire requires verbatim

These are notations that **must appear on the drawing**:

1. *"All works to be carried out in accordance with the current Mornington Peninsula Shire specifications
   and standard drawings and to the satisfaction of the Construction and Asset Protection Team."*
2. Where the Planning Permit requires a Construction Management Plan: *"A Construction Management Plan
   (CMP) must be submitted to, and approved by Council 15 business days prior to the commencement of any
   works on site and all works must be carried out in accordance with this CMP."*
3. (2.3) The plans must **nominate the Consulting Engineer to be contacted** if there is a discrepancy on
   the drawings.

**This is the first council-specific plan note found in writing**, and it is exactly the kind of thing a
drawing template should carry per council rather than a drafter remembering it.

## 5. Other requirements worth holding

- **4.1** Drainage computations provided **and approved by a qualified engineer**
- **4.5** Design caters for **all external catchments**
- **4.7** Hydraulic grade lines shown **where necessary** (Frankston: always, on the long section)
- **4.9** Location **and invert level** of the existing stormwater pit or pipe **confirmed on site**, with
  a **"confirmation method"** to be stated
- **4.17** A **stormwater pit schedule** with the appropriate pit types and correct sizes on the drawings
- **4.19** All services identified and located (Dial Before You Dig)
- **4.11 / 4.12** Outfall through another property needs an easement, or written permission from the
  adjoining owner, and Melbourne Water consent where affected
- **7.1 / 7.2** Soakage pits need a **percolation test report** by a qualified engineer or geotechnical
  consultant, and the design must follow that report

The submitting engineer signs the checklist and gives their **Professional Engineers Registration Number**.

## 6. What this adds to the picture

1. **Not every council publishes values.** Mornington sends you to ARR and the BoM for that location. The
   plugin's council profile therefore needs a third state: *published table* / *issued on request* /
   **"compute it yourself to ARR"**.
2. **Minimum concrete pipe class is per council** — Class 3 here, Class 2 at Frankston.
3. **Critical storm duration is a stated deliverable**, not just the volume.
4. **Council standard drawing numbers are the accepted details** — MP232 / MP236 lids, MP220 / MP238
   grates, MP244 orifice pits. CE's own standard details may not be what this Shire accepts.
5. **A verbatim plan note is required**, plus a CMP note when the permit calls for one.
6. **Pit schedule required again** — now four councils in a row.

## 7. Questions

1. **Has CE done Mornington Peninsula jobs?** This Shire will not accept a table of runoff coefficients —
   it asks for them to be calculated for the site to Australian Rainfall and Runoff, with rainfall taken
   from the Bureau of Meteorology for that exact location. That is a different way of working from
   Kingston and Frankston, and worth knowing before a job lands rather than at assessment.
2. **Concrete pipes here must be Class 3 as a minimum.** Frankston allows Class 2 depending on cover and
   loading. Is pipe class something being set per job now, or is one class used everywhere out of habit?
3. **The Shire wants its own pit lids, grates and orifice pits** (their drawings MP232, MP236, MP220,
   MP238, MP244). Does CE draw Council's standard detail on these jobs, or CE's own detail? If it varies
   by council, the detail sheet needs to know which council the job is in.
4. **The submission has to say which storm duration was the critical one** for the detention volume — not
   just the volume itself. Is that being stated on CE's computations today?
5. **The invert level of the existing Council pit must be confirmed on site**, and the checklist asks *how*
   it was confirmed. Is that survey, a site visit with a staff, or Council records? Whatever the answer,
   it is a line the drawing should carry.
