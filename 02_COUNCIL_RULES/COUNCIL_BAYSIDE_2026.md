# Bayside — Developer Drainage Design Policy 2026

**15 September 2026.** Source: *Developer Drainage Design Policy*, Bayside City Council, **adopted 17 February
2026**, review 2030. Second council document read in full.

**Important: this is the POLICY, not the numbers.** It states repeatedly that design parameters live in a
separate document — *Council's Developer Drainage Design Guideline 2026* / *Stormwater Drainage Design
Guideline*:

> *"Refer to Council's Stormwater Drainage Design Guideline for design parameters and calculations of permissible
> discharge flow and onsite detention volume."*

**That guideline is the one CE actually needs, and it is not this file.** Worth chasing — see the questions.

---

## 1. The finding that matters most

> *"For the sake of clarity, **single dwelling (single house) developments are currently not required to comply
> with Onsite Detention (OSD) requirements.**"*

Bayside exempts single houses from detention **outright**, and says so in those words.

**Compare Banyule**, from CE's own guidebook v1.3:

> *"Even for single dwelling, if the total site impervious area is 65%, OSD is required."*

So on the question *"does this single house need detention?"* two neighbouring councils give **opposite answers**,
and one of them depends on a measured area. This is the clearest case yet that **whether detention is required at
all is a per-council rule the plugin must hold** — it cannot be inferred from the project type.

## 2. Design standards Bayside works to

| System | Storm |
|---|---|
| Council's primary system (pits and pipes) | **20% AEP** |
| Industrial or commercial areas | **may be 10% AEP** |
| Critical assets (state highway crossings, sea outfalls) | higher again |
| Secondary system (overland flow) | up to **1% AEP** |

Private drainage: *Developer Drainage Design Guidelines 2026*, the building construction code, and
**AS/NZS 3500.3** — **no edition year given**, unlike Kingston which names 2021.

## 3. Floor levels and freeboard

- Council or Melbourne Water may issue a **Nominal Flood Protection Level (NFPL)** — the minimum floor level —
  where the site is in a flood management overlay or has significant flood risk.
- Minimum floor level = the 1% AEP flood level **plus freeboard**.
- **Freeboard: 300 mm minimum to all habitable buildings.**
- The freeboard **may be reduced or may not apply** to: a non-habitable building (garage, carport, shed), an
  unenclosed floor area, or an **extension to an existing building under 20 m²**.
- Buildings should sit on the highest available ground, and the building outline should be **outside the extent
  of 1% AEP flood flows**.

**Three freeboard numbers are now in play and they are different things:**

| | Value | What it is |
|---|---|---|
| Detention freeboard (Tim's ruling) | 150 mm, adjustable | water level to pit lid |
| Kingston flood overlay | 300 mm main / 150 mm outbuilding | above designated flood level |
| **Bayside flood** | **300 mm habitable**, reducible for non-habitable | above the NFPL |

They must be separate Settings values. Conflating them would be a real error.

## 4. Overland flow

- Overflow should be **directed to the front of the lot and discharged into the road** wherever possible.
- Where the site falls to the **back or side**, the developer must consider mitigation to reduce overflow risk to
  the property and neighbours up to 1% AEP.
- Existing drainage features within a property — easements, overland flow paths, open drains — **must be
  preserved and kept clear**.
- Council does **not** maintain the secondary system; landowners keep flow paths clear.

## 5. Subterranean water — stricter than most

- **Discharge of subterranean water to Council's kerb and channel is prohibited.**
- Groundwater from basements, retaining walls and subsoil drains must be **retained and reused on site** as far
  as practicable.
- Where the site has a stormwater reuse system, subterranean water is **filtered and connected into it**, not to
  the stormwater network.
- The private subterranean system must be **signed off by a registered engineer** and given to Council for
  record.
- Discharge to Council's underground system only where capacity exists; otherwise the developer **funds and
  builds an outfall drain** to a point Council nominates.

This matches the RFI item CE already records for Bayside — *"no subterranean water to kerb and channel from AGIs
or basement strip drains"* — and now has the policy behind it.

## 6. Basements

- All entry points protected; entry should have a **continuous apex or crest at the NFPL or higher**.
- Runoff entering a basement collected and disposed of for a **1% AEP** event, with an overflow or emergency
  system considered.
- **Full waterproof (tanked) design** where the groundwater table is shallow or there are known groundwater,
  perched water or surface flooding issues.

## 7. What this changes

1. **"Does this job need detention?" is a council question**, and the answers genuinely conflict — Bayside
   exempts single houses, Banyule catches them at 65% impervious.
2. **A third freeboard definition.** Three now, all different, all needing their own Settings value.
3. **Bayside's real numbers are in a document CE does not appear to hold** — the *Developer Drainage Design
   Guideline 2026*.
4. **Bayside names AS/NZS 3500.3 without a year**, where Kingston names 2021. So the plugin cannot assume a
   single edition applies everywhere; edition is per council too.

## 8. Questions

1. **Does CE hold Bayside's *Developer Drainage Design Guideline 2026*?** This policy points to it for every
   actual number — permissible discharge, site storage. Without it, Bayside jobs are being designed from the
   emailed values only.
2. **CE's guidebook says Bayside supplies PSD and SSR by email** on request. This 2026 policy instead points to a
   published guideline. **Has that changed — are the numbers now published rather than emailed?**
3. **The under-20 m² extension exemption** from freeboard — is CE applying that today?
4. **Bayside adopted this on 17 February 2026.** CE's guidebook v1.3 is dated 5 February 2026 — twelve days
   earlier, so it cannot reflect this policy. Worth a check of whether anything else in the Bayside entry is now
   out of date.
