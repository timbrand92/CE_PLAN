# Guidebook v1.3 (Feb 2026) — what changed, and what it corrects in my earlier notes

**15 September 2026.** Tim supplied `CIVIL AND DRAINAGE DESIGN GUIDEBOOK v1.3`, dated 05/02/2026 — 53 pages
against v1's 33.

**This supersedes `CE_DESIGN_GUIDEBOOK_RULESET.md`, which was written from v1 (2024).** That document is left in
place for its structure, but where the two disagree, v1.3 wins. One of my council entries was already wrong.

Its own change log:
- 22/11/2024 — council fees and submissions for Glen Eira and Bayside
- 20/01/2026 — **RFI checklists · pump systems design · soakage system design · general thumb rules**
- 05/02/2026 — general amendments to all sections

---

## 1. A correction to my earlier note — Glen Eira changed method

| | v1 (2024) | **v1.3 (2026)** |
|---|---|---|
| Glen Eira | Boyd's method, C = 0.35, 1 in 5 ARI, 5 min | **OSD4W**, with the *actual* existing site impervious area as the pre-development condition |

That is a different calculation route for a council CE works in often. It is exactly the kind of thing Tim meant
by *"some stuff is old, some is good now"*, and it is the reason the plugin must record **which version of the
guidebook a job was designed under**.

Glen Eira also now says the **entire detention may be in water tanks**, or tanks combined with detention pipes.

## 2. New: RFI checklists — the most useful list in the book

v1.3 adds, per council, a list of what councils actually come back and ask for. **This is the list of reasons
drawings get rejected**, and most of it is checkable from the drawing before submission:

| RFI item | The plugin can check it |
|---|---|
| Roof hatch for the area going into the water tank, with a legend in m² per dwelling | ✔ knows roof areas and which tank they feed |
| Overland flow path arrows and legend | ✔ can tell whether they exist |
| Pipes and pits at least **1 m away from the splay** | ✔ knows pit and pipe positions and the splay |
| Spot levels at corners and near drainage pits | ✔ knows where pits are and whether levels are shown |
| Water tank size and dimensions shown | ✔ |
| All pipes to be sewer quality | ✔ |
| All pipes under the garage **150 dia uPVC SN8** | ✔ knows which pipes pass under the building |
| **Inspection openings at every change of direction** | ✔ knows every bend and every IO |
| All pits scheduled, **including plastic pits** | ✔ compares the drawing against the schedule |
| Crossover width · permeable paving detail · council general notes | ✔ presence check |
| Minimum offsets from boundaries and structures for soakage | ✔ |
| Pump wet well impervious, no groundwater | ✖ a note, not geometry |

**A "ready to submit?" check against this list is probably the single highest-value thing the plugin could do**
for drafting time, because every item here currently costs a round trip with the council when it is missed.

## 3. New: pump systems (§6.4) — previously out of scope

Designed to **AS3500.3 Section 8**.

| | |
|---|---|
| In-ground pump systems | **1 in 10 ARI** storage — where an overland flow path exists or overflow can be provided |
| Basement pump systems | **1 in 100 ARI** where habitable areas could flood; car park may take the 1 in 100 if habitable space stays dry |
| Minimum wet well volume | **3 m³** per AS3500.3 |
| Pump flow rate | **must not exceed the permissible site discharge** in normal operation |
| Placement | accessible for maintenance — driveway or common car park; rising main and discharge sump also accessible and on the overland flow path |

The spreadsheet's inputs are all drawing facts: total site area, impervious and pervious areas, runoff
coefficients, discharge invert level, inlet level at pump pit, top working level, static rise, rising main length
and size, pump pit cover level. **The plugin can measure or hold every one of them.**

## 4. New: soakage systems (§6.5) — previously out of scope

Only in sandy soils, and governed by saturated hydraulic conductivity, the groundwater table, available space for
offsets from boundaries / council assets / footings, and an overland flow path. Needs a geotechnical assessment.
Sizing follows Melbourne Water's *WSUD Engineering Procedures: Stormwater*, with a storm-duration table checking
storage provided against storage required for **1 in 100 ARI**.

## 5. New: general thumb rules (§7.1.18) — all checkable

- **Minimum pipe slope 1 in 100**
- **Minimum underground pipe diameter 100**
- Minimum pipe quality: sewer quality / **SN8** for most applications — trafficable areas, and 100–300 mm cover
- **Minimum 300 mm head between the top of the gutter and the top of the water tank** for charged systems
- Class of grates and lids to suit the load

**Minimum pit depth by pipe size** (300 mm cover, STORMPRO detention pipe):

| Pipe | Min pit depth | | Pipe | Min pit depth |
|---|---|---|---|---|
| 150 | 459 mm | | 525 | 862 mm |
| 225 | 543 mm | | 600 | 939 mm |
| 300 | 622 mm | | 750 | 1083 mm |
| 375 | 701 mm | | 900 | 1236 mm |
| 450 | 781 mm | | | |

This sits **alongside** the pit-size-by-max-depth table (unchanged in v1.3), and the two work together: the pipe
sets a minimum depth, the depth sets a minimum pit size.

## 6. New: growth-area councils

v1.3 adds **Cardinia, Hume, Melton, Wyndham, Whittlesea, Casey, Mitchell** as a group ("similar to councils in
growth areas"), and regroups the rest by region — inner metropolitan, metropolitan west, metropolitan east. There
is also a **council map** (§7.1.1), which answers how CE finds the right council's rules.

## 7. What still stands from my earlier questions

**Unchanged and still needing Tim:**
- **Step irons**: the guidebook still ties them to the 600 × 900 pit size; the Civil Design Checklist still says
  deeper than 1000 mm. v1.3 did not resolve this.
- **AS/NZS 3500.3 edition**: still cited without a year, and the copies in Civil Stuff are the 2003 edition.
  v1.3 adds AS3500.3 **Section 8** for pumps, so the edition matters more now, not less.

**Now answered by v1.3:**
- *Where do the pump rules live?* → §6.4, added Jan 2026.
- *Soakage?* → §6.5.
- *Is there a council index?* → yes, the council map at §7.1.1.
- *Are council checklists held anywhere readable?* → yes, and better than I hoped: **RFI checklists per council**.

## 8. New questions from v1.3

1. **Which other councils changed method between v1 and v1.3?** I only spotted Glen Eira because I had read v1
   first. A full v1 → v1.3 diff of the council pages would be worth doing before any council data is built in.
2. **Should a job record the guidebook version it was designed under?** Glen Eira proves designs age.
3. The RFI checklists appear for Kingston, Glen Eira, Bayside, Monash and others — **is the set complete**, or
   are they being added council by council as RFIs come in?
4. **Pump: "the engineer determines the effective catchment"** — is that judgement, or is there a rule the plugin
   could offer as a starting point?

---

## 9. Addendum, 29 Oct 2026 (stage 1 audit; full detail in `areas/GUIDEBOOK_V1_3_VS_CE_AUDIT_2026-10-29.md`)

What the 53-page PDF (every page rendered, every picture looked at) adds to or corrects in the notes above:

1. **Version header.** The cover says 1.3; every page header says "Version 1.2". Same file, dated 5 Feb 2026.
2. **Minimum pit depth table is derivable.** Every figure (459 to 1236) equals 300 mm cover plus the pipe's outside diameter minus its wall (outside minus inside diameter, halved), from the StormPro table on page 18. CE can calculate it from pipe data instead of holding a list.
3. **Cover table is printed in full** (page 19, AS/NZS 3500.3 Table 6.2.5, "finished surface to top of pipe"): plastics 100 / 300 / 450 / 100 or 75 under pavement / 600 / 750.
4. **The 1:200 detention grade is council-specific** in v1.3 (Darebin, Banyule, Manningham, Maroondah, pages 41 to 45); the general thumb rule is 1 in 100 (page 48). Manningham's own 2021 checklist says 1 in 180.
5. **The book contradicts itself:** Casey (Boyd's in Table 1 on page 9, EDCM growth-area on page 46); Banyule (council-provided in Table 1, OSD4W on page 42); Manningham in two Table 1 groups; pervious C 0.3 in the text but 0.35 in the Boyd's sheet; "no detention pipes under garages" versus "pipes under the garage 150 UPVC SN8"; the Banyule "65%" has a blank symbol (Banyule's 2019 document says over 65%).
6. **Rainfall in the book's sheets** (BOM, per site) is 5 to 8 per cent higher than CE's fixed Melbourne curve; CE's curve is 4 to 6 per cent higher than the OSD4W Melbourne zone the company prints. Numbers in the audit.
7. **The book names no maximum or minimum pipe speed and no roughness** (searched). The 8 Oct Settings plan line "orifice only above 12 L/s; 1:200 for 225 and greater" was from v1 and is stale.
8. **Pump sheet method (page 24):** one 2-hour 1-in-10 storm, 30 minutes pumped, wet well = shortfall or 1 per cent of the catchment (m3 per 100 m2), pervious 0.3 and impervious 0.9, 3 m3 stated as the Standard's minimum.
9. **Soakage sheet (pages 26 to 27):** soil factor 0.5 / 1 / 2, set-backs 1 / 2 / 2 / 4 / 5 m by soil, 1-in-100 storm sweep, minimum 100 mm/h for Kingston, Frankston, Mornington.
10. **Industrial rule (page 8):** detention only if the existing outlet stub carries less than the 1 in 10 flow; find the 1 in 100 overland path.
