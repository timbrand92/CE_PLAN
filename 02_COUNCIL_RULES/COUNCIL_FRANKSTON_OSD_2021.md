# Frankston — Guidelines for On-Site Stormwater Detention

**15 September 2026.** Source: *Guidelines for On-Site Stormwater Detention*, Frankston City Council, last
updated **September 2021**. Seven pages, and the most directly useful council document so far — because it gives
a **formula**, not just requirements.

---

## 1. The orifice formula — and it checks out

Frankston publishes the orifice size **directly**:

```
d = 21.9 × √[ PSD / √H ]   mm

d   = orifice diameter (mm)
PSD = permissible site discharge (L/s)
H   = height from TOP WATER LEVEL to the CENTRE of the orifice (m)
```

**I checked this against the standard orifice equation** CE already uses (`Q = Cd·A·√(2gh)` with `Cd = 0.6`).
Rearranged to solve for diameter, with Q in L/s and h in metres, the constant works out at **21.89**. Frankston's
21.9 is the same equation, solved for `d` instead of for `Q`.

**Why that matters practically.** CE's orifice spreadsheet works by **trial and error** — you put in a trial
diameter, it gives a discharge, you compare it with the PSD and adjust ("Using diameter of 57 mm … COMPARE Qo =
4.2 l/s < 4.27 l/s … Adopt 57 mm"). Frankston's form gives **the answer in one step**. Same physics, no guessing.

**And `H` is top water level to orifice centre — which is exactly what the TWL solver computes.** So the chain
closes with nothing missing: detention volume → TWL → H → orifice diameter.

## 2. Standards edition — Frankston says 2018, Kingston says 2021

> *"All site drainage must be designed generally in accordance with Australian Standard **AS3500.3:2018**"*

Kingston's 2025 document names **2021**. Frankston's 2021 document names **2018**.

**So the standard edition is a per-council value, not a global one.** Tim's ruling (work to the edition CE holds,
which is 2018) is *exactly right for Frankston* and differs from Kingston only. That is a much smaller gap than it
looked this morning.

## 3. The detention requirement, in one sentence

> *"Provision of a stormwater detention system with a volume capable of retarding the **10 year ARI (10% AEP)**
> flow from the developed site back to a **5 year ARI (20% AEP)** pre-development value."*

Note Frankston writes **both notations side by side** — the only council so far to do so, and a sensible model
for how the plugin should display storms while councils are mid-conversion.

Where no planning permit is required but impervious area still increases significantly (boarding houses, some
medical), Council issues a **PSD at the time of the stormwater discharge point request**, and the design is
approved by the building surveyor rather than Council.

## 4. Storage rules

**Below ground** (the default — *"site storage is generally to be provided below ground"*):
- Maximum water level **at least 300 mm below habitable floor levels**
- Ponding from blockages must be at a **visible and readily accessible** location
- Clear of tree protection zones
- Storage pipes: **rubber ring joints**, **minimum 250 mm cover**

**Above ground** — only in common property (car parks) where everything else is excluded:
- Must not be hazardous; must not compromise building foundations
- **Ponding depth not greater than 150 mm**

**Rainwater tanks** — Frankston's own formulation:
- Minimum **2,000 L**, **plumbed in for re-use** (laundry, toilet, irrigation)
- Fitted with a **discharge control orifice**
- **Only up to one third of each tank's volume** may count as detention
- **Tanks may contribute no more than 50% of the total required detention volume**
- Council **may reduce** the credit in proportion to the roof area actually directed to the tank

That last line is a real design trap: a tank credited at a third of its volume can still be cut back if not enough
roof drains to it.

## 5. Orifice pit arrangement

- At the **lowest point** of the detention system, between storage and the Council network, and **within the
  property**
- **Orifice at the bottom of a baffle wall**, located **centrally** in the pit
- A **multi-cell system** may be accepted in some cases

Note this differs from Boroondara (single chamber, plate at the pipe face) and from Monash (standard drawing
D10A/B). **Three councils, three orifice pit arrangements.**

## 6. Pumps — discouraged

> *"Pump systems are discouraged and generally not supported by Frankston Council … due to their increased
> maintenance and failure considerations."*

- **Prior Council approval required**
- **Must not discharge to the road kerb** — must connect to a **pit** within Council's network
- Council notes a pump usually means the site falls away from the road frontage, so any surcharge would affect
  neighbours

## 7. Overland flows

> If no suitable overland flow path or drainage system is available, the on-site detention system must be
> designed to **detain the 100 year ARI (1% AEP) storm on-site**.

That is a large jump in required storage, triggered by the *absence* of a flow path — so whether a flow path
exists is a design-defining question, not a detail.

## 8. What this adds

1. **A direct orifice formula**, verified against the physics — replaces trial and error.
2. **Confirmation that the standards edition is per council** — 2018 here, 2021 at Kingston.
3. **A fourth freeboard**: 300 mm from maximum water level to habitable floor. (Now: Tim's 150 mm water-to-pit-lid,
   Kingston's 300/150 flood overlay, Bayside's 300 mm to NFPL, Frankston's 300 mm water-to-floor.)
4. **Tank detention rules differ per council** and are formulated differently each time:
   | | Tank detention limit |
   |---|---|
   | Kingston | 500 L per 2,000 L tank; 1,000 L for tanks ≥ 2,500 L |
   | **Frankston** | **⅓ of each tank, and ≤ 50% of total detention** |
   | Monash | ≤ 40% of OSD above ground; orifice at ⅔ tank height |
5. **Pumps need Council approval and may not discharge to kerb.**

## 9. Questions

1. **Does CE use Frankston's direct orifice formula, or the trial-and-error spreadsheet?** They give the same
   answer; the formula is one step.
2. **The "no overland flow path → detain 1% AEP" rule** — has that been triggered on a Frankston job, and is it
   being checked early? It changes the storage volume dramatically.
3. **Council may reduce tank credit in proportion to roof area directed** — is that being pre-empted in design,
   or discovered at assessment?
