# Manningham — On-Site Stormwater Detention Guidelines (March 2021) + OSD checklist

**15 September 2026.** Sources: Manningham City Council *On-Site Stormwater Detention Guidelines*, final
March 2021, v001.6, 34 pages; and the accompanying **OSD Guidelines Checklist** spreadsheet.

**The most drafting-specific council document found.** Where other councils give design parameters,
Manningham gives *drawing* rules — pipe spacing, cover under driveways, lid classes by location, fall
through a pit, boundary offsets. It reads almost like a specification for what CDCHECK should test.

**CE's stored Manningham profile is the best-populated in the file and nearly all of it checks out** — one
figure is wrong.

---

## 1. Checked against CE's stored Manningham profile

| CE holds | Manningham 2021 | |
|---|---|---|
| `psdMethod: council-provided` | *"The above parameters will be provided by Council as part of the planning permit"* | ✅ |
| `psdAri: 5` / `storageAri: 10` | PSD **20% AEP**, SSR **10% AEP** | ✅ |
| `orificeMinMm: 40` | *"Orifice outlets must be no less than **40 mm** in diameter"* | ✅ |
| warning: tank orifice min 25 mm | *"minimum of **25 mm** diameter orifice"* from each tank | ✅ |
| warning: head = top of baffle wall to centre of orifice | *"Head Height = Top of baffle wall to centre of orifice"* | ✅ |
| warning: in-situ baffle wall, **plates not accepted** | *"Provide in-situ baffle wall (**orifice plates will not be accepted**)"* | ✅ |
| warning: orifice to nearest standard pipe diameter ±2 mm | *"chose nearest standard pipe diameter available on the market **± 2 mm**"* | ✅ |
| warning: baffle 150 thick when depth > 1 m; 900×600 chambers when baffle < 1.2 m | checklist 10(c), 10(i)/(j) | ✅ |
| warning: 100 mm gap baffle-top to lid underside, 600 mm weir | checklist 10(l) | ✅ |
| warning: outlet pipe min 150 SN4 at 1:80 up to 1000 m² | checklist 10(g) | ✅ |
| warning: step irons when pit/storage deeper than 1 m | *"If a storage or pit is deeper than one metre, then appropriate step irons will be required"* | ✅ |
| warning: flood-prone → PSD/SSR at 1% AEP | *"Council may require the PSD and/or the SSR to be determined based on a 1% AEP event"* | ✅ |
| `reuseDispensation` formula and conditions | `DIV = 0.25 × SSR × (roof connected ÷ total impervious)`, reuse min 2000 L, 50 m² roof per dwelling, no dispensation for irrigation-only, tank max 3000 L | ✅ **exactly, word for word** |
| **warning: "Min pipe grade 1:200 for detention pipes 225 and greater"** | *"laid on a slope no flatter than **1 in 180**"* | ❌ **wrong — Manningham is 1:180** |
| `minUndergroundPct: 50` | no percentage published; above-ground tanks allowed only *"in combination with"* below-ground, and *"the majority of the volume within any rainwater tank"* must be for reuse | ⚠ a reasonable inference, not a stated value |

**The 1:200 error is instructive.** Darebin and Banyule both say 1:200, and that wording has been copied
onto Manningham, which says **1:180**. A pipe drawn at 1:200 on a Manningham job is flatter than Council
allows. It is a small number with a direct drawing consequence, and it is exactly the class of mistake that
holding each council's own value would prevent.

## 2. Two rules that land straight on work already in flight

**Twin pipes — a published spacing.**

> *"Dual pipes – **minimum 200 mm gap, measured externally**, between parallel pipes for pipe sizes up to
> 600 mm diameter. (For pipe sizes greater than 600 mm diameter, consult Council Engineers.)"*

This is a council rule for the exact thing the twin-barrel pipe object draws. It is a **clear external face
to external face** dimension, which also bears on the unresolved pipe-length convention question — the gap
is measured between outside faces, not centrelines.

**Second council confirming CE's top water level rule.**

> *"the **obvert of the pipe(s) at the upstream pit to be at or lower than the top of the baffle wall**"*

Darebin says the same. That is CE's rulebook item 7 (*TWL = obvert of highest pipe*) now confirmed by two
independent councils.

## 3. Drawing rules the plugin can check

| Rule | Value |
|---|---|
| OSD offset from **front** title boundary | **500 mm** |
| OSD offset from **side** title boundary | **300 mm** |
| Storage pipe grade | **no flatter than 1 in 180** |
| **Dual pipe gap, external face to external face** | **200 mm** (pipes up to 600 dia) |
| Cover, top of pipe to underside of driveway | **300 mm** — less needs added reinforcement or a higher pipe class |
| Storage pipe class | RCP or FRC **Class 2 minimum**; UPVC **SN4 sewer grade** (StormPRO, Blackmax, Enviro) |
| Pipes beneath slabs and pavements | **150 mm SN4 UPVC minimum** |
| Outlet pipe from the baffle pit | **150 mm minimum**, SN4, grade **1 in 80** up to a 1000 m² site |
| **Fall through a detention pit** | **10 mm minimum nominal** |
| Step irons + **SL81** reinforcement | pit or storage **deeper than 1 m** |
| Baffle wall thickness | **150 mm** where depth exceeds 1 m |
| Baffle chamber size | **900 × 600** where the baffle wall is under 1.2 m |
| Gap, top of baffle wall to underside of pit lid | **100 mm minimum**, weir **600 mm minimum width** |
| Trench grate draining to the detention side | top of grate **150 mm above** the top of the baffle wall |
| **Pit covers and grated covers** | must be **higher than the top of the baffle wall** to avoid surcharge |
| **AGI drains** | **bypass the OSD** into the outlet chamber — or, if connected in, **150 mm above the top of the baffle wall** |
| Footings near Council easement infrastructure | **300 mm minimum offset** |
| Inspection openings in a driveway | **200 × 200 Jenco steel covers** matched to the finished surface |
| No storage | **beneath dwellings** or **within Tree Protection Zones** |

**Pit lids by location** — a ready-made rule for choosing the lid:

| Where | Lid |
|---|---|
| Within a driveway | Class B Gatic / Grate, or Class C Terra Firma |
| Vehicle crossover and side entry | Class C Terra Firma, or within Gatic / Grate |
| Landscape areas | concrete lids, or Terra Firma Class B |
| Backyard | Class A Terra Firma, or Gatic / Grate |

That is exactly the kind of decision CDPIT could make from where the pit sits, instead of the drafter
remembering it.

**The AGI rule is worth noting** given the recent CDFW placement trouble, where four blocks sharing the tag
`AGI` caused a pipe to be excluded from the landing evidence. Manningham treats agricultural drains as a
separate system that bypasses the detention entirely — so an AGI run genuinely is not part of the OSD
network, and the plugin's model should reflect that rather than treating it as ordinary drainage.

## 4. Levels, water and pumps

**Maximum water level in the storage:**
- **300 mm below all habitable floor levels**
- **150 mm below other floor levels including garages**

Running comparison of the same rule:

| Council | Below habitable floor | Below garage floor |
|---|---|---|
| Darebin | **400 mm** | **200 mm** |
| **Manningham** | **300 mm** | **150 mm** |
| Banyule | 300 mm (and 300 below any grated inlet) | — |
| Frankston | 300 mm | — |

**Basement pumps — a precise rule, and different again:**

> *"Any basement pumps are to discharge **upstream of the baffle wall** with the **invert of the rising main
> at or above the top of the baffle wall**."*

So Manningham permits basement pumping into the detention system on stated terms, where **Darebin bans
basement seepage from the stormwater system altogether** and **Boroondara bans basement groundwater to
laneways, kerbs and channels**. Three councils, three different answers on the same question — this is the
open basement-pump item, and it turns out not to have one answer.

Otherwise *"Stormwater runoff is not to be discharged from the site by the use of pumps."* Separate
discharge points per lot are discouraged unless a central high point or space prevents a common one, and
need the Development Engineer's approval before submission.

**Rainwater tanks:** detention volume `DV = SSR × (roof connected to tank ÷ total site impervious)`,
calculated for the 10% storm. Tanks used **solely** for detention will not be considered where other
options exist; the **majority of any tank's volume must be for reuse**; **maximum tank size 3000 L** unless
Council approves. An underground system is still required for paved areas and any roof not connected to the
tank.

**Standards:** AS 3500.3-**2018** — the same edition as Frankston, and the one CE holds.

## 5. Questions

1. **Manningham's detention pipes must be no flatter than 1 in 180; we have 1 in 200 recorded for them.**
   1:200 is Darebin's and Banyule's number and it looks to have been copied across. A Manningham job drawn
   at 1:200 is flatter than Council allows. Have Manningham jobs been drawn at 1:200?
2. **They publish a twin-pipe spacing: 200 mm clear between the outside faces**, for pipes up to 600. Is
   that what CE draws twin barrels at today, and is it the same on every council, or does it vary?
3. **They pick the pit lid by where the pit is** — driveway, crossover, landscaping, backyard, each with a
   named class. Is that decision being made by the drafter each time? It looks like something the plugin
   could offer.
4. **AGI drains must bypass the detention system entirely** and go to the outlet chamber. Is that how we
   draw them, and should the plugin treat an AGI run as a separate system rather than part of the drainage
   network?
5. **Basements:** Manningham allows a basement pump into the detention if the rising main invert sits at or
   above the top of the baffle wall; Darebin forbids basement water in the stormwater system outright;
   Boroondara forbids it to kerbs and laneways. Which have we been working to?
