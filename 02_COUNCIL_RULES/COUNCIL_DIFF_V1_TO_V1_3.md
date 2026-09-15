# Every council page, guidebook v1 (2024) → v1.3 (Feb 2026)

**15 September 2026.** Requested after Glen Eira turned out to have changed calculation method, which made the
rest of my v1-based council notes untrustworthy. Both guidebooks were split into per-council sections, normalised
for whitespace and page furniture, and compared line by line.

**All 12 councils changed. Three changed their calculation method.** Wording-only changes ("Fees Applied" →
"Fees Apply", typos) are excluded below.

---

## 1. Calculation method changed — the dangerous three

Anything built from v1 would use the wrong method for these.

| Council | v1 (2024) | **v1.3 (Feb 2026)** |
|---|---|---|
| **Glen Eira** | Boyd's, C = 0.35, 1 in 5 ARI, 5 min | **OSD4W**, using the *actual* existing site impervious area as the pre-development condition |
| **Mornington Peninsula** | Boyd's, council coefficients | **OSD4W**, council coefficients, **1 in 2 ARI PSD · 1 in 10 ARI storage** |
| **Whitehorse** | *"Orifice required only for flowrates more than 12 L/s"* | **that rule is gone** — replaced by **1 in 5 ARI PSD · 1 in 10 ARI OSD** |

Whitehorse is the one to watch: a design rule was **removed**, not changed. A plugin carrying the v1 rule would
skip an orifice on a job under 12 L/s that now needs one.

## 2. New design requirements

| Council | Added in v1.3 |
|---|---|
| **Banyule** | **"Even for a single dwelling, if the total site impervious area is 65%, OSD is required."** A detention trigger that did not exist before, and it applies to single dwellings — the category that usually has none. |
| **Frankston** | Driveway pavement **min 125 mm thick, 1 in 30 crossfall**; **minimum 50% of detention underground** |
| **Kingston** | **Min 50 m² of roof area connected to the water tank** |
| **Glen Eira** | Entire detention may be in water tanks, or tanks combined with detention pipes |
| **Boroondara** | Baffle pit now needs **plan *and section* view** |
| **Darebin** | Outfall drain design; complete checklist for external works; **horizontal scale 1:250, vertical 1:25** |
| **Monash** | Drainage contribution in lieu of detention — now "mentioned in the planning permit, can be requested from council as required" |

Banyule's 65% rule is the most consequential: it changes *whether a job needs detention at all*.

## 3. Submission route changed

| Council | v1 | v1.3 |
|---|---|---|
| **Glen Eira** | Email; **no fees** | **Online portal; fees apply** |
| **Bayside** | Email — and v1 listed the **wrong address** (`mail@gleneira.vic.gov.au`); no fees | **Online portal; fees apply** |
| **Kingston** | Planning permit issue date | Planning permit issue date **and endorsed plans** |
| **Whitehorse** | broken email address | corrected |

## 4. New councils and regrouping

- **Cardinia Shire** added as a worked example for **growth-area councils**, designed to **EDCM** standards:
  MUSIC model, gross pollutant traps possible for industrial, post-development runoff volume reduction via reuse
  tanks, and a **professional registration number** required at submission.
- Growth-area group: **Hume · Melton · Wyndham · Whittlesea · Casey · Mitchell**.
- **Knox City** and **Brimbank** newly listed.
- The "other councils" list is regrouped by region: inner metropolitan (developed), metropolitan west,
  metropolitan east.

Note **Casey moved**: v1 listed it under councils accepting Boyd's; v1.3 puts it in the growth-area EDCM group.

## 5. RFI checklists — new, per council

Added for **Kingston, Glen Eira, Bayside, Monash, Frankston**. Mostly shared, with council-specific extras:

- **Kingston** also wants: council general notes; vehicle crossings/reinstated crossovers/pedestrian islands per
  endorsed plans; **all pits scheduled including plastic**; pump wet well impervious; soakage offsets.
- **Bayside** also wants: a note on plans for **owners' agreement under section 173** where drainage assets are
  shared; and **no subterranean water to kerb and channel from AGIs or basement strip drains**.
- **Frankston** also wants: pavement cross-section detail with crossfall.

## 6. What this means

1. **Do not build council data from v1.** Every page moved; three methods and one trigger changed.
2. **A job must record the guidebook version it was designed under.** Three method changes in about fifteen
   months is a fast-moving reference.
3. **Detention triggers are not just "multi-unit vs single dwelling" any more.** Banyule's 65% impervious rule
   means the plugin must ask the question per job, from the site figures, not from the project type.
4. **The council profile needs a "last checked against guidebook version" date**, so a stale profile is visible
   rather than silently wrong.

## 7. Questions

1. **Whitehorse's 12 L/s orifice exemption** — deliberately dropped, or moved somewhere I have not read?
2. **Casey moving** from Boyd's to the growth-area EDCM group — is that a genuine change in how CE designs
   there, or a reclassification?
3. Do **Bayside and Glen Eira fees** now apply to every job, or only some classes?
4. RFI checklists exist for five councils. **Are the rest coming**, and should the plugin treat the five shared
   items as a general pre-submission check for every council?
