# Banyule — Stormwater Drainage Requirements for New Developments (30 Sep 2019)

**15 September 2026.** Source: Banyule City Council, *Stormwater Drainage Requirements for New
Developments*, 24 pages, effective **30 September 2019** (TRIM CD16353).

Publishes its parameters in full, like Darebin. **Five of CE's stored Banyule values check out; four are
wrong**, including one of the same class as the Boroondara error that was already caught and fixed.

---

## 1. Checked against CE's stored Banyule profile

| CE holds | Banyule 2019 | |
|---|---|---|
| `psdMethod: swinburne` | §10.1 *"Council will **only** accept detention calculations using the **Swinburne OSD Methodology**… a computer based program such as **OSD4**"* | ✅ now sourced |
| `psdAri: 5` | §10 *"The PSD is based on a **20% AEP** storm"* (= 1 in 5) | ✅ |
| `storageAri: 10` | §10 *"The SSR is based on a **10% AEP** storm"* | ✅ |
| `imperviousC: 0.9` | §9 / §10 **0.90** impervious | ✅ |
| warning *"OSD required if site impervious ≥65% even for a single dwelling"* | §7 — **>65%** for every single-dwelling case | ✅ exactly |
| warning *"min pipe grade 1:200 for detention pipes 225 and greater"* | §10.2.2 — pipes *"no flatter than **1:200**"*, *"below ground pipes (**minimum 225mm** diameter)"* | ✅ exactly |
| **`minUndergroundPct: 50`** | §10.2.2 *"The site storage is required to be provided **below ground**… **Rainwater tanks above ground will not be approved** for site storage requirements."* | ❌ **should be 100** |
| **`orificeMinMm: 0.0`** | §10.2.3 *"Outlets must not be less than **40mm** in diameter"* | ❌ **should be 40** |
| **`preDevCFixed: 0.0`** | §10 *"Pre-developed site **0.35 regardless of pre-existing impervious surfaces**"* | ❌ **should be 0.35** |
| **`perviousC: 0.35`** | §9 and §10 — pervious is **0.30** | ❌ **see §4** |
| `tcMinutes: 5` | §10 *"**Tc & Tso to be requested from Council**"* — Banyule publishes no fixed value | ⚠ an assumption, not a council value |
| `standardDrawings: []` | Council Standard Drawings referenced throughout but not numbered in this document | — |

**`minUndergroundPct` is the same defect that was found and fixed for Boroondara** (`COUNCIL_PROFILE_AUDIT.md`
item D1: stored 0, should be 100). Banyule bars above-ground tanks just as plainly, and its field still
reads 50 — because nobody had read the source. That makes **two of the councils that ban above-ground
storage**, and it is worth checking the rest of the file for the same pattern rather than one at a time.

## 2. The parameters, published

**General runoff coefficients (§9, stated as minimums):**

| Surface / use | C |
|---|---|
| Grassed / landscaped (pervious) | **0.30** |
| Road pavement and other paved (impervious) | **0.90** |
| Residential allotments | **0.65** |
| Commercial and industrial areas | **0.85** |

**OSD coefficients (§10):**
- **Pre-developed site: 0.35**, *regardless of pre-existing impervious surfaces*
- **Post-developed: 0.90 impervious / 0.30 pervious**
- PSD calculated on a **site coefficient of 0.35** (§7 note 1)

**Storms:** PSD on **20% AEP** (1 in 5) · SSR on **10% AEP** (1 in 10) · outfall drainage **10% AEP** ·
low-point sites and overland flow **1% AEP** · **OSD design minimum 10% AEP, but 5% AEP (1 in 20) if the
site falls to the rear**.

That rear-fall trigger is a real design-defining condition, and it is the same kind of rule CE already
records for Maroondah (*return period varies with site slope — rear-sloping may need 1 in 20 ARI*). It is
not recorded for Banyule.

**Rainfall:** *"Use local **IFD charts for Heidelberg**."* In OSD4: *"Zone-ARI flow" = **Heidelberg 5**,
"Zone-ARI store" = **Heidelberg 10, 20 or 100**, "Storage type" = pipe or tank.* That is the actual
software setting, named — the most directly usable instruction any council has given.

**Tc and Tso must be obtained from Council** before plans are submitted, along with the catchment area for
any outfall drainage.

## 3. Rules the plugin can check directly

| Rule | Value |
|---|---|
| Self-cleansing velocity | **1.0 – 6.0 m/s** |
| Manning's n | **0.013** RC · **0.011** UPVC |
| Freeboard **within pits** | **minimum 300 mm** |
| **Top water level of the storage** | **≥ 300 mm below all finished floor levels**, and **≥ 300 mm below any grated inlet** taking surface flow |
| Flow control pit | **≥ 300 mm below all FFLs** |
| Detention pipes | **≥ 225 mm**, grade **no flatter than 1:200**, length shown on the plan |
| Detention pipe cover | **450 mm** in easement · **300 mm** under driveway and elsewhere (or AS/NZS 3500.3:2015 Cl 6.2.5, whichever is greater) |
| Outfall pipe minimum | **300 mm** under roadways · **225 mm** longitudinal to road |
| Outfall grade | **minimum 1 in 100**, and **diameter may never reduce downstream** |
| Pits required | at **every** change of direction **and** change of grade |
| Direction change at a pit | **≤ 45° wherever possible, never > 90°** |
| Fall through a pit | **≥ 50 mm**, with a chase, for dry weather flow |
| **Step irons** | **where pit depth exceeds 1 m** |
| Anchor blocks | where pipe grade is steeper than **1 in 10** |
| Cover, general | **450 mm** in easements · **600 mm** under road pavement and road reserve |
| House drain into a Council drain | **< 300 mm: not direct — a pit is required**; ≥ 300 mm via approved saddle |
| Kerb deflectors | where kerb grade exceeds **1 in 6** |
| Surface-water drains through gratings | **minimum 150 mm** |
| Material life expectancy | **not less than 100 years** |
| **Hydraulic grade line** | calculated **from the obvert of the existing Council drain**, plotted on the long section, and **≥ 300 mm below finished surface level** |

**Pit size by depth to invert of outlet** — and it also caps the pipe:

| Depth | Minimum pit | Max pipe |
|---|---|---|
| ≤ 900 | 600 × 600 | **300** |
| > 900 – ≤ 1200 | 600 × 900 | **600** |
| > 1200 | 900 × 900 | **600** |

Minimum size is AS/NZS 3500.3:2015 **Table 7.5.2.1** or the Council drawing, **whichever is larger**.

Two things stand out. **The maximum pipe a pit may take is a rule CE does not hold at all** — a 375 into a
600 × 600 pit would be refused here. And **step irons where the pit is deeper than 1 m** matches Tim's own
ruling (*step irons for pits 600 × 900 or larger and/or deeper than 1000 mm*) — **an office rule now
confirmed in a council document.**

## 4. Pervious C — a second council says 0.30, and the likely explanation

This is the strongest evidence yet on the open question in `FINDING_PERVIOUS_C_SPLIT.md`.

Banyule states **three different coefficients for three different jobs**, and labels each:

- **0.30 — pervious surface** (grass, landscaping)
- **0.90 — impervious surface**
- **0.35 — the whole site, pre-development**, regardless of what is actually there

Darebin does the same thing: **0.30 pervious / 0.90 impervious** for the pump SSR, **0.4** as the
pre-development site figure, and 0.35 in its rational-method example.

**So two independent councils both use 0.30 for a pervious surface and 0.35 as a site-wide figure.** CE's
council records store `perviousC = 0.35` — which looks like **a pre-development site coefficient filed
into the pervious-surface field**. That would also explain why CE's pump sizing (0.30) and Boyd's
calculator (0.3) disagree with the automatic design (0.35): the 0.30 sites are using it as a surface
coefficient, which is what it is.

**This is a hypothesis with two councils behind it, not a ruling.** It still needs Tim's call, but it now
has a specific shape: *0.35 is probably not the pervious number; it is probably the pre-development site
number, and the two have been conflated.*

Note also that Banyule's own `preDevCFixed` should be **0.35** and CE stores **0** — so the value may
simply have been put in the wrong field for this council.

## 5. Orifice and detention chamber

- **Two-chambered baffle pit with a slow-release orifice in the weir wall** — CE's standard arrangement,
  and the opposite of Boroondara's single chamber
- **Outlets must not be less than 40 mm**; anything **under 90 mm** needs an approved **trash grate**
  (Maxi Mesh RH 3030 or equivalent)
- Where an orifice control is used, a **bypass in the form of a 100 mm thick concrete baffle wall** is
  required in case the orifice or grate blocks
- Orifice pits need a **grated lid** so the orifice and grate can be inspected for blockage
- **All** runoff from the development must route through the flow control pit
- **Multi-cell (SMC or equivalent) accepted**, but with no bypass built in, a pit upstream must be
  **designated a surcharge pit**, ≥ 300 mm below all FFLs, and manufacturer charts submitted
- Storage must be **free draining and watertight**, accessible from **both ends via pits**, and designed so
  nobody has to enter a confined space

Running total on the smallest orifice: **Darebin 30 mm · Banyule 40 mm · Manningham 40 mm** (already in
CE's data). CE stores **no minimum** for either Darebin or Banyule.

## 6. When OSD is triggered

| Development | Trigger |
|---|---|
| Extension to existing single dwelling | total impervious **> 65%** |
| New single dwelling (with or without an existing one) | impervious **> 65%** |
| Multi-dwelling (any), commercial, mixed use | **always** |
| **Carpark construction** | impervious **> 35%** |

*"Generally, there should be no net increase in stormwater run-off."* An existing dwelling that stays must
be **connected to the OSD system**, and to any new outfall drain.

**Soakage pits** may continue only if **all five** hold: single dwelling · impervious increase **≤ 10%** ·
site **≤ 1500 m²** · pit **≥ 4 m from the boundary** · assessed by a chartered civil engineer as still
performing with spare capacity, with the report submitted.

## 7. Flooding, pumps and handover

**Freeboard above the 1% AEP flood level:** dwellings/buildings **300 mm**, outbuildings/garages **150 mm**.
No obstruction to overland flow — fencing must pass flood water, natural surface levels retained; otherwise
**TUFLOW modelling** of pre- and post-development conditions is required.

**Pumps** (Cl 8 of AS/NZS 3500.3:2015): single dwellings only, or multi-dwelling if the land is landlocked
with no easement. **Two pumps alternating**; both sized for the **1% ARI** storm if flood prone; wet well
sized for **1% ARI** runoff; **3 hours battery backup**; control panel with warning lights; grated lid;
designed and checked by a chartered civil engineer; **must pump to a discharge pit and then gravity feed**
to the point of connection. A pump may also need an OSD system alongside it, so the site discharge is
controlled by something other than the pump capacity.

**Handover:** 12-month defects liability, then **CCTV to WSA 05-2008**, one file per pipe length, annotated
plan, coded defects — *"Push rod camera footage… will not be accepted."*

## 8. Standards edition — a fifth answer

Banyule names **AS/NZS 3500.3:2015** (Cl 7.10 OSD, Cl 6.2.5 cover, Cl 8 pumps, Table 7.5.2.1 pit sizes),
and **ARR 2016 or latest** in one place and **ARR 2019 or latest** in another.

| Council | Names |
|---|---|
| Darebin (2025) | AS3500.3:**2025** |
| Kingston (2025) | **2021** |
| Frankston (2021) | **2018** |
| **Banyule (2019)** | **2015** |
| Boroondara | unstated |
| Mornington Peninsula | ARR and BoM, no edition |

Useful corroboration: Banyule cites **Cl 6.2.5 for cover** and **Cl 8 for pumps** in the 2015 edition — the
same clause numbers verified earlier against the 2018 edition. So those clause numbers are stable across
2015 and 2018, and it is only the 2003 edition that numbers them differently.

## 9. Questions

1. **Banyule will not accept an above-ground tank as detention — all storage must be below ground.** Our
   records say only 50% needs to be underground for Banyule. That is the same mistake we already found and
   fixed for Boroondara. Should I check every council in the file for it, rather than finding them one at a
   time as documents come in?
2. **Their smallest orifice is 40 mm, and anything under 90 mm needs a trash grate in front.** We hold no
   minimum for Banyule at all. Darebin's is 30 mm. Has a job ever gone out with a hole smaller than the
   council's minimum?
3. **A pit has a maximum pipe it can take** — 300 into a 600 × 600, 600 into anything bigger. We do not hold
   that rule for any council. Is that something worth warning on when a pipe is too big for the pit it
   enters?
4. **Banyule's top water level must sit 300 mm below every floor level and 300 mm below any grated inlet.**
   Our own rule is 150 mm from water to pit lid. Both would be checked on a Banyule job — is the 300 being
   applied today?
5. **Tc and Tso have to be asked of Council before plans go in.** We hold 5 minutes for Banyule as an
   assumption. Do we have Council's figures on a past Banyule job we could read off instead?
6. **Their OSD design storm steps up from 1 in 10 to 1 in 20 if the site falls to the rear.** Is that being
   picked up, or would a rear-falling Banyule site get designed to 1 in 10 by default?
