# Darebin — Legal Point of Discharge Guidelines (June 2025) + OSD checklist

**15 September 2026.** Sources: City of Darebin *Legal Point of Discharge Guidelines*, **June 2025**,
31 pages (revision 02, 19/06/2025 — "Updated all document"); and the *Stormwater Detailed Plan
Certification / OSD checklist*, which is an appendix of the same guidelines.

**The richest council document read so far, and the most useful.** It publishes the design parameters, the
formulas, the pit sizes, the cover table and the pump rules — and it settles several values that CE's own
council data had recorded as *unknown*.

> **Note on the evidence trail.** CE's council data cites `docs/evidence/COUNCIL_PROFILE_EVIDENCE_2026-09.md`
> for every stored value. That file (980 lines) exists on other branches but **is not on this branch or the
> live line**, so the "where did this number come from" links do not resolve where the data actually ships.
> Its Darebin section was built from council letters in CE's job folders (D01, an amended LPD for job
> 24-283 dated 2025-02-06; D02, the checklist appendix) — not from these published guidelines.

---

## 1. What this document settles that CE had recorded as unknown

The evidence review marked seven Darebin fields UNSOURCED. **The published guidelines source four of them
and conflict with two.**

| Field | CE holds | Was | Darebin June 2025 says | |
|---|---|---|---|---|
| `psdMethod` | `swinburne` | UNSOURCED | §9.3 *"Darebin Engineering Department uses **OSD4** computer program… provided the design is based on the **Swinburne method**"* | ✅ now sourced |
| `minUndergroundPct` | `50` | UNSOURCED | §9.1 *"Underground pits and pipes must form **at least 50%** of the detention storage"* | ✅ now sourced |
| `orificeMinMm` | `0.0` | UNSOURCED | §9.5(d) *"Orifice outlets must be **no less than 30 mm** in diameter and must be preceded by a **trash grate**"* | ❌ **should be 30** |
| `orificeCo` | `0.6` | office rule | §9.5(d) *"Cd… is **0.6 for a square or rectangular outlet and 1.0 for a circular outlet**"* | ❌ **conflict — see §4** |
| `perviousC` / `imperviousC` | `0.35` / `0.9` | UNSOURCED | §10.3 *"a runoff coefficient of **0.90 for impervious areas and 0.30 for pervious areas**"* (stated for the pump case) | ⚠ see §5 |
| `preDevCFormula` | "…Melbourne rainfall zone" | UNSOURCED | §9.2 confirms 0.4 and the rational method; the **rainfall zone is still not named** | ⚠ still unsourced |

Three earlier conflicts have already been corrected in the live data and now read right: `tcMinutes` 10,
`preDevCFixed` 0.4, `postDevCMode` floor, `tsoMinutes` 5.

## 2. The design parameters, published in full

**And they differ by development type — CE stores only the residential pair.**

| | Residential | Commercial / Industrial |
|---|---|---|
| Pre-development weighted C | **0.4** | **0.6** |
| Post-development weighted C | **minimum 0.8** | **minimum 0.90** |
| Time of concentration `tc` | **10 minutes** | **10 minutes** |
| Time from site to outlet `tso` | **5 minutes** | **5 minutes** |
| Storage ARI | **1 in 10** | 1 in 10 |
| PSD ARI | **1 in 5** | 1 in 5 |

**`tc` = 10 minutes is the longest found yet** — Kingston 5 / 7, Frankston 3 / 7 / 9, Darebin 10 for
everything. A longer time means a lighter rainfall intensity and a smaller flow, so Darebin is the *least*
conservative on this one number and Frankston's 3 minutes the most. Four councils, four different answers,
and no two agree — the case for holding `tc` per council is now settled by evidence rather than argued.

**Rational method, stated:** `Q = CIA / 360` (m³/s), A in hectares. PSD is the discharge the site would
generate at an **average runoff coefficient of 0.4**, on a **5-year ARI** storm.

**AS3500.3:2025 is named** (§5.0 and §6.0). Running total on the standards edition: Kingston **2021**,
Frankston **2018**, Boroondara **unstated**, Darebin **2025**. CE holds 2018.

## 3. Rules the plugin can check directly

These are all measurable from what the drawing already holds:

| Rule | Value |
|---|---|
| OSD storage pipes laid no flatter than | **1 in 200** |
| Outlet pipes, minimum grade | **1 in 100** |
| **Obvert of the storage pipe at the upstream pit** | **at or below the top of the baffle wall** |
| Maximum distance between pits | **30 m** |
| Pipes in a drainage easement | **≥ 225 mm** |
| Pipes longitudinal in road reserve | **≥ 225 mm** |
| Pipes under road pavement | **≥ 300 mm** |
| Single dwelling outlet | **≥ 100 mm** |
| Under-slab drain | **≥ 150 mm SN8** |
| Multi-unit common drain | **≥ 150 mm** |
| **100 mm or 150 mm pipe may NOT be used for OSD** | and **no detention beneath the slab** |
| Kerb outlet connection | **≤ 100 mm**, invert **10 mm above** the kerb invert |
| Connection to a Council pipe | **top third of the pipe**, per DS14 |
| Connection larger than **⅓ the Council drain diameter** | **a new junction pit is required** |
| Property connection invert | **above the obvert of the pit outlet** (no backflow) |
| Concrete / FRC pipe class | **minimum Class 2** RRJ |

**The obvert-at-or-below-baffle-top rule is the important one.** CE's own rulebook item 7 reads *"TWL =
obvert of highest pipe"*. Darebin states the same relationship from the other direction, in a council
document. **That is CE's TWL convention independently confirmed**, and it is what CDTWL computes.

### Pit sizes by depth — a published ladder

| Pit | Depth | Minimum size |
|---|---|---|
| Junction | up to 0.6 m | **450 × 450** |
| Junction | 0.6 – 0.9 m | **600 × 600** |
| Junction | greater than 0.9 m | **900 × 600** |
| Side entry | up to 1.2 m | **600 × 900** |
| Side entry | greater than 1.2 m | **900 × 900** |

Worth putting beside Tim's step-iron ruling (*step irons for all pits 600 × 900 or larger and/or deeper
than 1000 mm*): Darebin's ladder reaches 900 × 600 at 0.9 m deep, so on a Darebin job a pit is usually at
step-iron size before it is at step-iron depth.

### Minimum cover — a third different table

| Application | Cover | Min pipe dia | Class |
|---|---|---|---|
| Not subject to vehicle loading | **300 mm** | 225 | 2 |
| Within road reserve, not in road formation | **450 mm** | 225 | 2 |
| In sealed roadway | **600 mm** | 300 | 2 |

Frankston's equivalent "no vehicle loading" figure is **500 mm**; Darebin's is **300 mm**. Sealed roadway
agrees at 600 mm.

### Pipe materials

Concrete and FRC to AS 1342, minimum Class 2 RRJ. UPVC sewer quality or heavy-duty stormwater within the
property; Class SH sewer grade in the road reserve. OSD storage polyethylene: **Caliber (formerly RibLoc)
or Blackmax (Iplex)**. *"**Stormpro** pipe can be accepted for internal OSD drainage whereas **RCP** will be
required for outfall drainage."*

CE's drawings already carry `225 DIA. StormPRO PIPE AT 1 IN 200 – 12.5m DETENTION`. **That wording matches
Darebin's rules exactly** — StormPRO for internal OSD, at the minimum 1 in 200.

## 4. The orifice — three findings, one of them a conflict

**(a) Orifice plates are refused outright.** *"Orifice plates are not accepted, **only orifice pipes**."*

This is the opposite of Boroondara, which **requires** a plate and photographs its diameter at inspection.
Two neighbouring councils, opposite hardware. CE already records this rule on **Manningham**
(*"orifice PLATES will not be accepted"*) — **but not on Darebin**, where it is equally explicit.

**(b) Minimum 30 mm, with a trash grate in front.** CE stores `orificeMinMm = 0.0` for Darebin.

**(c) The discharge coefficient conflicts with CE's office rule.**

> *"Cd = coefficient of discharge is **0.6 for a square or rectangular outlet and 1.0 for a circular
> outlet**."*

CE applies **Cd = 0.6 everywhere** (Tim's ruling R-05). Frankston's one-step formula `d = 21.9√[PSD/√H]`
also has 0.6 baked into its constant. Darebin's own table says a **circular** outlet takes **1.0**.

**What the difference is worth:** the orifice area is inversely proportional to Cd, so the diameter scales
as `1/√Cd`. For the same permitted discharge and the same head, **CE's 0.6 gives a hole about 29% larger in
diameter than Darebin's own 1.0 would.** On a 60 mm orifice that is roughly 60 mm versus 46 mm.

**Hypothesis, not established:** Darebin requires an orifice **pipe**, not a plate. A short pipe running
full discharges more freely than a sharp-edged plate of the same bore, so a higher coefficient is
physically reasonable — though 1.0 is at the very top of the plausible range. I have not verified this
against a hydraulics reference and it should not be treated as settled.

**Other orifice rules:** the pit is to be a **double-chamber** pit so high flows can escape; **multicell
pits are acceptable**; the **orifice invert sits level with the pit floor**; the restricting device must
take **all** impervious runoff from the site; storage and flow control must be **outside Council
easements**; Council **does not accept an orifice on a rainwater tank** as the whole-site restrictor.

## 5. The pervious runoff coefficient — Darebin states 0.30

§10.3, for the pump case: *"applying a runoff coefficient of **0.90 for impervious areas and 0.30 for
pervious areas**."*

That is directly relevant to the split recorded in `FINDING_PERVIOUS_C_SPLIT.md`. Two observations, both
factual:

- CE's `PumpSizingService` uses exactly **0.30 pervious / 0.90 impervious** — **it matches Darebin's
  published pump rule precisely.**
- CE's `AutoDesignService` uses **0.35**, and the council records store **0.35**.

Confusingly, §9.2's rational-method example gives `C = 0.35` for the PSD calculation while the surrounding
text says PSD assumes an average coefficient of 0.4. So Darebin's own document uses 0.4, 0.35 and 0.30 in
three places for three purposes. **This does not resolve Tim's outstanding question — it shows that the
answer may legitimately depend on which calculation is being done**, which is worth knowing before the
value is set once on the Settings page.

## 6. Storage, tanks and levels

**Storage:** underground pipes must be **completely sealed** and accessible for maintenance; flows above
10% AEP must be able to **overflow and escape the site** without damaging buildings or neighbours. Storage
pipes must not sit **beneath a habitable building** (from the checklist).

**Rainwater tanks** — accepted only on demonstration, with detail design and calculations:
- tank **fully enclosed with an orifice**, controlled outflow from the airspace, per **Darebin DS37**
- detention volume must be **in addition to** the minimum **2,000 L** retention volume
- cross-section required showing tank dimensions, volume, inlet and overflow heights, the orifice and the
  reuse connection
- the 100 mm tank outlet must carry a **30 mm orifice** so the system is not closed
- **a 25% reduction in required detention** may be considered for apartments at full site coverage with a
  **minimum 10,000 L reuse tank**

That makes **five councils, five different tank rules** — Kingston per-tank litres, Frankston ⅓ and ≤50%,
Monash ≤40% above ground, Boroondara none at all, Darebin conditional with a 25% dispensation.

**Baffle wall height / ponding level** (§9.5(c), *"According to AS3500.3 & Council requirements"*):
- **400 mm below all habitable floor levels**
- **200 mm below garage floor levels**

**Floor levels** (§9.6, per DELWP flood guidelines):
- habitable floors **300 mm above the 1% AEP flood level**
- all floors **at least 300 mm above the water surface level of any above-ground storage**
- floors adjacent to an overland flow path **600 mm above the lowest corner of the property**
- **flood gates are not accepted**

**Overflow** must pass the **5% AEP (1 in 20)** event, for higher storms or a blocked orifice. Above-ground
paved storage: **depth not to exceed 200 mm**, positioned clear of pedestrian access, surcharge directed
away from dwellings and garages.

> **Relevant to an earlier ruling.** The TWL plan records Tim's correction that *floor level has nothing to
> do with the TWL* — CE's TWL is the baffle crest, with 150 mm freeboard to the pit lid. **Darebin's rule
> is a separate, additional check**: the same ponding level must also sit 400 mm below habitable floors and
> 200 mm below garage floors. It does not change what sets the TWL; it adds a council test the TWL has to
> pass. Recorded as fact — no change made.

## 7. Pumps — the most detailed pump rules found

Pumps are refused for general drainage, as a substitute for gravity, where they would serve multiple
properties, for common property in multi-dwelling developments, or for overland flow paths. Allowed only
for **basement ramp runoff in multistorey apartment buildings** (ramp surface water only), and for a
**single dwelling** in exceptional circumstances as an interim measure.

Where allowed:

- **two pumps**; the secondary pump alone must handle the **1% AEP** discharge
- **battery backup for 3 hours** continuous running, with warning lights when in use
- **control panel with failure warning lights**, in a prominent accessible position
- **minimum wet well storage 3 m³**, grated lid for visual inspection
- designed by a qualified civil/hydraulic engineer; certified by a registered plumber and building surveyor
- PSD by **OSD4W**; SSR using **0.90 impervious / 0.30 pervious**

**Basement seepage:** groundwater, fire tank water and basement seepage **must not be discharged into the
stormwater system** — trade waste agreement to sewer, on-site treatment/reuse, or licensed off-site
disposal. This is the clearest answer yet to the open basement-pump question raised at Monash, and it
matches Boroondara's bar on basement groundwater to laneways, kerbs and channels.

## 8. Drawing and submission requirements

North up the page · AHD levels · benchmarks · scale 1:100 or 1:200 · 3 copies A3 or A1, or email.

Shown on the plans: lot dimensions and easements with assets, existing crossings and footpath, existing
side entry pits in the road reserve, existing drainage inside the boundary, service authority fixtures,
natural surface contours, **all proposed floor levels**, pipe sizes / types / inverts / gradients, pit
sizes and types (**DS8, DS8-LW**), **DS14**, downpipe locations and connections.

- **Each unit's drainage must be independent, with a single connection to the common system** — a layout
  rule the plugin could check.
- Pavement grades **max 1 in 8, min 1 in 200**; crossfalls **max 1 in 20, min 1 in 80**; disability access
  **max 1 in 14**.
- **Charged systems are not supported** for surface runoff to the LPD — gravity only.
- **Council will not approve systems draining against the natural grade** except where there is no
  alternative.
- *"Council's drainage data is conceptual and for advisory purposes only… It is the responsibility of the
  Engineer or Developer to locate and verify all levels through a detailed survey."*
- Design **downstream to upstream**.
- The certification is **signed** by the designer, with a **VBA or Engineers Australia registration
  number**, certifying they (or a reliable third party) **confirmed the depth and offset of the LPD on
  site**.

## 9. Questions

1. **Darebin says the discharge coefficient for a round orifice is 1.0, not the 0.6 we use everywhere.**
   For the same permitted flow that makes the hole about 29% smaller — roughly 46 mm where we would draw
   60 mm. Frankston's published formula has 0.6 built into it, so the two councils genuinely disagree.
   Do we follow each council's own figure, or is 0.6 the value we stand behind and justify?
2. **Darebin will not accept an orifice plate — the restrictor must be an orifice pipe**, and it must be at
   least 30 mm with a trash grate in front. We already record the no-plates rule against Manningham but not
   against Darebin. Is that because Darebin jobs have been drawn with a pipe anyway, or has a plate detail
   gone out on a Darebin job?
3. **Their smallest allowed orifice is 30 mm.** Have we ever had a job where the sum came out below that?
   If so, what was done — a bigger hole and less detention, or more storage?
4. **Commercial and industrial jobs in Darebin use 0.6 before and 0.90 after**, not the residential 0.4 and
   0.8 we hold. Have we done commercial work in Darebin, and were those figures used?
5. **Darebin's ponding level must sit 400 mm below habitable floors and 200 mm below garage floors.** That
   sits alongside our own 150 mm from water to pit lid, not instead of it. Is the 400 mm one being checked
   on Darebin jobs today?
6. **The June 2025 guidelines name AS3500.3:2025.** We work to the 2018 copy we hold. Kingston says 2021,
   Frankston 2018, Darebin 2025. Should the plugin simply record which edition each council names and show
   it on the job, so the difference is visible rather than assumed?
7. **The evidence file that every stored council value points to is not on this branch.** It exists
   elsewhere in the repository. Do you want it brought across, so that clicking through from a number to
   "where it came from" actually lands somewhere?
