# Boroondara — Stormwater detention system (Council's own page)

**15 September 2026.** Source: City of Boroondara, *Stormwater detention system* page (live web page, not a
PDF guideline). Read because CE's council profile already carries Boroondara rules that had never been
checked against Council's own words.

**Why this one matters more than a new council:** it is the first source read that lets CE's **existing**
stored rules be verified rather than extended. Three of them check out exactly.

---

## 1. Verified against CE's stored Boroondara profile

`Modules/Drainage/Assets/Config/council-profiles.json` already holds a Boroondara entry. Council's page
confirms it:

| CE holds | Council's page says | |
|---|---|---|
| `psdMethod: council-provided` | *"We will respond within 10 working days and confirm your: detention volume storage requirement, permissible site discharge"* | ✅ |
| `minUndergroundPct: 100` | *"**Above-ground water tanks must not be used for stormwater detention.**"* | ✅ |
| `standardDrawings: ["SD999"]` | *"Your proposed control pit must comply with the **Standard Drawing SD999** – onsite detention control pit details"* | ✅ |
| warning: Certificate of Title required | *"your Certificate of Title, which you can get through the Landata website"* | ✅ |

**The `minUndergroundPct` correction has already been applied** — `COUNCIL_PROFILE_AUDIT.md` item D1 flagged
it as `0` when it should be `100`, and the live file now reads `100`. Council's own page independently
confirms the fix was right.

### One stored warning is understated

CE's warning says *"Email **site area and impervious area** to council to obtain PSD and SSR parameters"*.
Council actually asks for **five figures**:

- site coverage
- total site area
- roof area
- paved areas
- landscaped area

**All five are measurable from the drawing.** That turns the pre-application enquiry from a hand-written
email into something the plugin can assemble — and it is the same five numbers the runoff calculation needs
anyway. Worth correcting the warning text, and worth considering as a small feature: *produce the Boroondara
enquiry figures from the drawing.*

### Not stated on the page

`psdAri: 5`, `storageAri: 10`, `perviousC`, `imperviousC: 0.9`, `tcMinutes: 5` are **not** published here —
consistent with Council supplying the PSD and the storage volume itself. So those values in CE's profile
come from somewhere else (guidebook / cheat sheet) and remain unverified against Council.

## 2. What is new

**Above-ground tanks are barred outright.** Now four councils, four different tank rules, and this is the
only flat refusal:

| Council | Tanks as detention |
|---|---|
| Kingston | 500 L per 2,000 L tank; 1,000 L for tanks ≥ 2,500 L |
| Frankston | ⅓ of each tank, and ≤ 50% of total detention |
| Monash | ≤ 40% of OSD above ground; orifice at ⅔ tank height |
| **Boroondara** | **None. All detention below ground.** |

**Basement groundwater.** *"Groundwater from a basement, or excavation works more than 1.2 m in height, must
not be drained into laneways, kerbs and channels."* Relevant to the open Monash basement-pump question.

**AS/NZS 3500.3 with no edition named** — Kingston says 2021, Frankston says 2018, Boroondara says neither.
So the edition is per council *and sometimes unstated*, which supports working to the edition CE holds.

**A site survey confirming levels of existing services** within or near the site is a stated design
requirement, as are **trees and tree protection zones** and **easements** shown on the plan.

## 3. The built orifice is physically inspected

After construction, Council inspects and requires photographs:

- inside the control pit showing the **trash grate and orifice plate**
- a close-up of the **orifice plate**
- **the diameter of the orifice plate measured against a ruler**
- a close-up of the **sump and weepholes**

*"These photos are mandatory."*

**So the orifice diameter drawn is the diameter someone will hold a ruler against.** That is a strong
argument for the orifice size being a real buildable number rather than a computed decimal — and it means
the control pit detail must show a **sump and weepholes**, not just the plate.

## 4. Process and cost (for the job programme, not the design)

- Pre-application enquiry answered in **10 working days**
- Design assessment **4 to 6 weeks**, fee **$318.20** (1–4 units) / **$743.20** (5–9) / **$955.50** (10+)
- Inspection fee **$168.50**; a failed inspection means changes, a new request and another fee
- Cannot build until the approval certificate is issued

The 10-working-day wait for the PSD is the item that affects CE's programme: the design cannot be finished
until Council answers, so the enquiry wants sending early.

## 5. Questions

1. **Does CE's orifice pit detail for Boroondara jobs show a sump and weepholes?** Council photographs both
   at inspection and calls the photos mandatory. If the detail does not show them, the builder may not
   build them, and the inspection fails after the concrete is poured.
2. **The orifice plate diameter gets measured with a ruler on site.** Is the diameter being rounded to
   something that can actually be drilled and measured, or is a computed decimal going onto the drawing?
3. **Council wants five figures to give the PSD** — site coverage, total site area, roof area, paved area,
   landscaped area. All five could be measured off the drawing automatically. Is that enquiry being written
   by hand today, and would having the plugin produce the figures save real time?
4. **Boroondara allows no tanks at all as detention.** Has a job ever been designed with a tank counted,
   and caught at assessment?
