# 📖 CE Engineering Rulebook — DRAFT for Tim's mark-up

> **Status: DRAFT v0.1 (2026-07-17).** This is the consolidation of every engineering rule we could
> recover — from what **you have already ruled** and from what **the code currently does**. It is the
> single artefact the rebuild hangs off: eventually the tools AND the AI read from here, and nothing
> re-implements a rule (design rule #1 + #2).
>
> ⚠️ **Nothing here is authoritative until you confirm it.** It was mined by automated readers; treat
> every value as "claimed, pending Tim." Sources are cited so anything can be checked.

### How to mark this up
Against any row, write: **✅** (correct) · **✏️ actually it's X** · **❓** (need to think) · **⛔** (I never ruled this — it's a guess).
Start with **§B** — that's where the code disagrees with decisions you already made.

### Provenance legend
🔒 **locked** = your dated ruling · 🟡 **stated once** = asserted somewhere, not locked · ⚪ **implied** =
a code default (often citing a standard) you never confirmed · 🎲 **magic** = an unsourced number nobody can justify.

---

## A. The good news — your rulebook mostly already exists

The mining found your rules living in **four tiers**, none of which the software can read:

| Tier | Where | Example |
|---|---|---|
| 1 · Your direct answers | `ENGINEER_QUESTIONS_PENDING.md`, `CHANGELOG.md` "House rules" | Pre-dev C 0.35 *(STANDING HOLD)*, Kingston 1-in-5, Class C lids |
| 2 · Rulings buried in bug threads | `BUG_CARPARK.md`, `REGRESSION_LOG.md`, `PARKING_LOT.md` | *BUG-027: "NO MIN./MAX. suffix anywhere"* |
| 3 · De-facto rulebook docs | `COUNCIL_PROFILE_AUDIT.md`, `CE_STRUC_DRAFTING_STANDARD.md`, `DETAIL_SELECTOR_SPEC.md` | 15-council numeric matrix; structural layer/mark standard |
| 4 · Rules living only in code | `PipeSizingModels.cs`, `MaterialVelocityLimits.cs`, `council-profiles.json` | The magic numbers in §C |

**The job is consolidation + correction, not authoring from scratch.** You've done most of it already.

---

## B. ⚠️ WHERE THE CODE DISAGREES WITH YOU — start here

Each of these is a place the software does something **different from a decision you already made**, or
**different from itself** in two tools. Every one is a candidate "the tool isn't right." Confirm the
right answer and it becomes a one-place fix.

> ### ✅ RESOLVED — Tim's rulings (2026-07-17)
> | # | Ruling | → Fix |
> |---|--------|-------|
> | **B1** Kingston | **1-in-5 is final** | profile `psdAri` 2 → 5 for Kingston |
> | **B2** Pervious C | **0.35** | correct the 0.30 default + stale CDCALC test |
> | **B6** Gravity | **9.81 everywhere** | correct the 9.8 site |
> | **B5** Grade label | **Show the ACHIEVED grade**, not the typed value | make `CD` match `CDEDIT` (consistent with BUG-027 "actual grade exact"); the typed value is never displayed |
> | **B7** Orifice Co | **0.6** | standardise the 0.61 sites → 0.6 |
> | **B8** Min cover | **Per council** (honour each profile; Frankston 250) | cover check reads the council profile, not a global 600 |
> | **B9** Corner floor-waste | **0/25/50 mm inset** (per justification) | retire the "no inset / centreline" code path |
>
> ⚠️ These are **rulings, not fixes yet.** Each becomes a focused build session that ends by being
> **driven in AutoCAD** (rule 12) — deliberately NOT coded from this planning chat.

| # | Your ruling / intent | What the code actually does | Where | Why it bites |
|---|---|---|---|---|
| **B1** | **Kingston = 1-in-5** (20% AEP) 🔒 2026-06-11 | Profile audit + calibration built toward **1-in-2** (`psdAri=2`) | `ENGINEER_QUESTIONS_PENDING.md:23` vs `COUNCIL_PROFILE_AUDIT.md:17,91` | Real council, **14 jobs** — sizes detention wrong |
| **B2** | **Pervious C = 0.35** 🔒 STANDING HOLD | Detention default `0.30`; a CDCALC test expects `0.3` | `ENGINEER_QUESTIONS_PENDING.md:14` vs `DetentionDesignViewModel.cs:19`, `CDCALC_UPGRADE_PLAN.md:70` | Feeds every flow → every pipe/orifice/tank |
| **B3** | One max (scour) velocity per material | **UPVC held to 3.0 m/s in CDEDIT but 6.0 in auto-design** (BUG-080) | `MaterialVelocityLimits.cs:24` vs `PipeSizingModels.cs:106` | Auto-design returns a *smaller* pipe than CDEDIT for the same flow |
| **B4** | **No " MIN."/" MAX." suffix, ever** 🔒 BUG-027 | Now correct — but 4 earlier code states + **pre-2026-05-21 drawings/XData carry the reverse** | `REGRESSION_LOG.md:6050` | Old drawings still show the suffix you removed |
| **B5** | A pipe's grade label should be one thing | **`CD` writes the grade you typed; `CDEDIT` overwrites it with the grade the inverts achieved** — and only one ever adds " MIN." | `CdCommand.Grade.cs:191` vs `PipeEditCommand.GradeText.cs:140` | Same pipe, two labels, depending on which command touched it last |
| **B6** | One value for gravity | **g = 9.8 in auto-design, 9.81 in the drawn OSD block** | `Hydraulics.cs:33` vs `DetentionSystemViewModel.cs:16` | Two live orifice paths give different diameters |
| **B7** | One orifice coefficient | **Co = 0.6 (live sizing) vs 0.61 (calc dialogs)** | `council-profiles.json` vs `OrificeCalcViewModel.cs:18` | Advisory dialog disagrees with what's drawn |
| **B8** | Min cover per council where stated | **600 mm hard-coded for all** — Frankston's *own profile* says 250 mm, ignored | `PipeSizingModels.cs:27` vs `council-profiles.json:145` | Council rule silently overridden |
| **B9** | Corner Floor Waste position (one rule) | **Two "locked" rules disagree:** "no inset, on the centreline" (2026-06-04) vs per-justify inset 0/25/50 mm (BUG-028) | `REGRESSION_LOG.md:1468` vs `:6094` | CDSTRIP corners drawn to whichever rule a given code path used |
| **B10** | Hollow steel = **draw inner walls** 🔒 2026-07-17 | Reverses June's "hollow = outer only"; old tests/drawings still encode outer-only | `CE_STRUC_SUITE/REGRESSION_LOG.md:144` | Section details differ by when they were drawn |
| **B11** | One definition of orifice "head" | **Four engines define head differently** (baffle−d/2 · plate height · user head · caller-supplied) | `DetentionSystemViewModel.cs:655` +3 | Orifice sizing not reproducible across tools |

➡️ **B1, B2 and B3 change drawn/sized output on real jobs — treat as the top of the fix queue.**

---

## C. 🎲 Numbers in the code you never approved (ranked by drawn-output impact)

Every one moves geometry or sizing and traces to *nobody* — not a standard, not a ruling:

1. **Scour velocity caps** — UPVC 3.0 / concrete 6.0 / metal 4.0 / unknown 6.0 m/s. Self-labelled *"TIM TO CONFIRM"*. Drives auto-sizing. `MaterialVelocityLimits.cs:37-40`. **#1.**
2. **Pervious runoff C 0.35** (code) vs 0.30 (guidebook) — feeds every flow. `AutoDesignService.cs:53`.
3. **Gravity 9.8 vs 9.81** (see B6).
4. **Project "too-flat" grade 1:200** — global, overrides the AS3500 per-DN ladder. `UserSettings.cs:478`.
5. **Min self-cleansing velocity 0.6 m/s.** `MaterialVelocityLimits.cs:43`.
6. **Min cover 600 mm** — every council (see B8).
7. **Detention geometry rules** — TWL = obvert of highest pipe; freeboard 150 mm below cover; max orifice = 2·baffle−1; head = baffle−d/2. `DetentionSystemViewModel.cs:601,773,632,655`.
8. **Detention pipe: preferred max length 40 m; diameters 225–600.** `AutoDesignService.cs:63,73`.
9. **Column-vs-pad threshold 4000 mm span** (structural). `SupportPlacementEngine.cs:42`.
10. **Min outlet drop 20 mm; default pit drop 5 mm.** `UserSettings.cs:203,220`.
11. **Annotation offsets** — text 70, invert inward 200, SC/CJ 200, mask 70 mm. `UserSettings.cs:313,316,562,210`.
12. **Wall masonry gap widened to 350 mm** — self-flagged *"NOT doc-derived, needs Tim's sign-off"*. `WallPairingService.cs:22`.
13. **Network default diameter 225 mm** for every link type. `network-catalogue.json:61`.

---

## D. ❓ Genuine gaps — the 10 answers that unblock the most tools

Ranked by how many tools/bugs each one frees. One line each is enough.

1. **AS/NZS max scour velocities per material** (UPVC, RC, steel…)? → unblocks BUG-080, CDEDIT, the whole pipe sizer, and flips `AreScourLimitsVerified`. *(You already chose "advisory-only until this lands.")*
2. **Confirm the office pipe-sizing standards** as house rules: min grade by DN (the AS3500 table), 600 mm cover vs council, 0.6 m/s self-cleansing? → unblocks CDSIZE / CDLEVEL / CDCALC / auto-design.
3. **CDJOINT: saw-cut spacing per slab type + where CJ vs SC go** (AS 3600/NCC)? → unblocks CDJOINT/CDCJ/CDSC (currently frozen).
4. **How do R1 / FJ1 / P1 / RJSET place & behave?** → unblocks the whole rafter/joist marker family (build is held).
5. **Define SDS / SDS1 / STS1 / SC1 / SC2 switch behaviour** (type swap, label carry, re-anchor)? → unblocks all five support-switch commands.
6. **Reuse / no-detention tank sizing method** (STORM, SDA, or rule-of-thumb)? → unblocks the reuse OSD branch (unbuildable today).
7. **Pump branch:** duty-selection rule, is there a 3 m³ wet-well floor, which template is canonical? → unblocks pump/SPS design.
8. **Confirm Kingston `psdAri = 5` is now final everywhere** (reverse the 1-in-2 setting)? → the single biggest accuracy item (14 jobs).
9. **Orifice: Co = 0.6 or 0.61, and snap up to the next standard plate ≥ council minimum, or hold the exact minimum?** → unblocks orifice sizing for 4 councils.
10. **Corner Floor Waste — final word:** on the centreline (no inset) or the 0/25/50 inset? *(and confirm hollow-section inner-wall rule)* → unblocks CDSTRIP + the section detailer.

*Also open (lower leverage): twin detention-pipe modelling is hard-coded off; council coverage (Port Phillip, Stonnington, Yarra Ranges, Maribyrnong, Moonee Valley); a CDCALC bug that silently checks failed-parse pipes as 225 mm.*

---

## E. ✅ Your confirmed rulings (locked) — the settled core

These carry your lock language or a dated confirmation. Listed so the rulebook is complete; skim for anything mis-recorded.

### Falls & grades
- Grade labels show the **actual achieved grade**, exact, **no MIN./MAX. suffix**, every mode 🔒 (`MathHelper.cs:156`).
- Achieved grade = round(L ÷ |fall|); auto-calc rounds inverts so effective grade is **at-or-steeper** than requested 🔒.
- Default minimum grade **1 in 100** 🔒 office default (`AdvancedSettingsViewModel.cs:236`).
- Upstream change → **if a fall is already set, hold it and re-base downstream; else apply standard/min grade for the DN** 🔒 BUG-073.
- Diameter **increase** → keep the **same small invert drop**, NOT obvert/soffit matching 🔒 BUG-076/077.
- Downstream drop = detect the upstream pit's drop and continue it; else default (5 mm), auto-applied/editable 🔒.

### Pipe sizing & hydraulics
- Self-cleansing min velocity **0.6 m/s** ⚪ (unconfirmed — see D2).
- Standard diameter ladder 100…750 mm ⚪ (AS).
- Charged-pipe label = `{dia} DIA. {material} CHARGED TO {destination}` (material from dialog) 🔒.
- Real parallel pipes < ~1 m apart exist **only** as detention twin pipes 🔒 BUG-059.
- Manning's n by material 🔒/⚪ (AS3500).

### Pits & covers
- Default lid class **C** 🔒 house rule.
- 350×350 plastic pits allowed only at depth ≤ 0.45 m **and** pipes ≤ 100 mm 🔒.
- Pit sump labelling council-dependent 🟡.
- Trench grate (TG) does **not** appear in PITSCHEDULE 🔒.
- Riser tags from `R` pool, Droppers from `D` pool; `DP` reserved for downpipes 🔒 BUG-036.

### Joints
- CDJOINT builds a saw-cut (SC) grid on a closed CDSLAB boundary; origin at a **corner (SW) vertex**, lines **flush to the boundary** both ends 🔒 PL-059/060. *(spacing-per-slab-type rules = gap D3.)*
- CDCJ = construction joint on layer `SLAB CJ`; CDSC = sawcut on `SLAB SC` 🟡.

### Detention / WSUD
- **Pre-dev C 0.35 (Kingston 0.4) — STANDING HOLD, no change without explicit confirmation** 🔒.
- Impervious C 0.90; Tc 5 min for lots < 1000 m² 🔒 office.
- Storage = Boyd's full duration sweep, worst case (no routed-Tc even on large lots) 🔒 Q7.
- Orifice head from pit geometry (TWL − orifice IL); **0.45 m first-pass fallback**; TWL = orifice IL + head 🔒.
- SSR may sit **+12–19% above** office storage (never under) — "same-or-safer" is acceptable 🟡.
- Closed-polygon roof convention: **yes, only on jobs where the roof drives the design** 🔒.

### Councils (numeric — see the matrix in §F)
Kingston 1-in-5 / C 0.4 · Glen Eira ≥50% underground · Manningham orifice 40 mm · Boroondara 100% underground · Monash 65 mm/≥60% · Mornington 1-in-2/65 mm/50% · Whitehorse 90 mm · Casey 50 mm · Frankston 1-in-5/50% — all 🔒 or council-fact.

### Schedules
- Pit-schedule rows auto-sort on open 🔒 BUG-008.
- Ground-beam marks (GB/GL) group under **Ground** floor, not First 🔒.
- Per-cell override schema = 13 tracked columns; `DELETE` token = intentional blank 🟡 (`PER_CELL_OVERRIDES.md`).

### Annotation / presentation
- Strip-drain fall arrow = **Multileader** (arrow at each Floor Waste, text upstream) on `25DIMS`, style "TIM LEADER TYPE" 🔒 BUG-029.
- Fall symbol (CDFALL): arrow follows drag bearing; flip = readability only; text parallel, FALL above / grade below, left-justified at tail, always readable; cardinal snap ~±3° 🔒 *(built, awaiting AutoCAD confirm)*.
- Level Mark = one block `RL LEVEL.dwg` on `25TEXT`; RL/FFL/SSL/NGL differ only by prefix; scale follows DIMSCALE 🔒.
- Detail geometry drawn at true size × (DIMSCALE ÷ 20) 🔒.
- Leaders MLR/MLL: dogleg 300 + landing 125, scaled by DIMSCALE 🔒.

### Structural
- Beam commands 1/2/3(BDL)/4/5/8 by layer/role; retire 1A/2A/4A 🟡 spec.
- Beam end pulled back **100 mm** short of support; min beam length 50 mm; cardinal snap ±5° 🔒 2026-06-10.
- Supports centred within the **~90 mm** stud-wall line pair 🔒.
- Member-mark grammar `[LEVEL][FAMILY][number][letter][(O)|(U)]`; families catalogued 🔒 2026-06-10/11.
- SC and RL are **annotations, not members** (exclude from support logic) 🔒.
- Bored pier: at cut = green(3) solid; below = yellow(2) HIDDEN 🔒.
- Layer-prefix number = text height ×10 (25→2.5 mm); 35TEXT=3.0, 50TEXT=3.5, 70TEXT=5.0 🔒.
- Section elevations: Continuous (visible) + HIDDEN (behind) only; hidden web = two lines; flange toggle flips all together; SHS/RHS/CHS + timber = outer solid only **except hollow now also draws inner walls** 🔒 2026-07-17 *(see B10)*.
- RC ligature corners bend ~135° (hook/cog), not a straight "+" 🔒 2026-06-18.
- AB bracing capped 2700 mm; BB/BT1 **not** capped 🔒.
- STR + BWT commands deleted permanently 🔒. 20 not-yet-built stub commands **hidden**, not shown as "Phase 2/3" 🔒 2026-07-17.

### Rounding & units
- Invert levels: **2 dp / nearest 10 mm** ("0.00") 🔒 locked format.
- Drawing-text grade always **integer denominator** (no decimal grades) 🔒.
- AI suggestion values strip to **2 dp** (not 3) 🔒 BUG-070.
- All drainage geometry in **mm** ⚪.
- Rounding mode AwayFromZero ⚪ (**note:** conflicts with banker's-rounding sites — a §B-class drift to check).

---

## F. 🏛️ Council matrix (the densest already-written rulebook)

From `council-profiles.json` + `COUNCIL_PROFILE_AUDIT.md`. ⚠️ = disagrees with a Tim ruling (see §B).

| Council | PSD ARI | Min orifice | % underground | Pre-dev C | Notes |
|---|---|---|---|---|---|
| Kingston | **1-in-5** ⚠️(code 2) | — | — | 0.4 | Boyd's KINGSTON xls authoritative; reuse 500 L / 2000 L |
| Glen Eira | — | — | ≥50 (soft) | — | |
| Manningham | — | 40 mm (RWT 25) | — | — | head = baffle-top→orifice-centre; in-situ baffle, no plates; reuse 0.25·SSR·(roof/imperv) |
| Boroondara | — | — | 100 | — | all detention underground; single-chamber plate |
| Monash | — | 65 mm | ≥60 | — | |
| Mornington Pen. | 1-in-2 | 65 mm | 50 | — | storage 1-in-10 |
| Whitehorse | — | 90 mm | — | — | |
| Casey | — | 50 mm | — | — | own Boyd's; bespoke orifice formula d=21.9√(PSD/√H) |
| Frankston | 1-in-5 | — | 50 | — | profile says **250 mm cover** — ignored by code (B8) |
| Darebin | — | — | — | 0.4 pre / 0.8 post | fixed post-dev C should floor weighted C |
| Bayside | — | — | ~50 (good practice) | — | |
| *(all others)* | 5 | 0 | 0 | 0 | **Co 0.6, imperv C 0.9, Tc 5, storage ARI 10 identical for all — arguably should vary** |

**To confirm/add:** Port Phillip, Stonnington, Yarra Ranges, Maribyrnong, Moonee Valley.

---

## G. Source map (provenance)

- **Tier 1 (your answers):** `docs/ENGINEER_QUESTIONS_PENDING.md`, `ENGINEER_QUESTIONS_FOR_REVIEW.md`, `CHANGELOG.md:57`.
- **Tier 2 (buried rulings):** `BUG_CARPARK.md`, `CE_CVL_SUITE/REGRESSION_LOG.md`, `PARKING_LOT.md`, `CE_STRUC_SUITE/REGRESSION_LOG.md`.
- **Tier 3 (de-facto rulebook):** `COUNCIL_PROFILE_AUDIT.md`, `DETAIL_SELECTOR_SPEC.md`, `ORIFICE_STANDARD_DETAILS_PLAN.md`, `AUTO_DESIGN_CALIBRATION_REPORT.md`, `EVIDENCE_REPLICATION.md`, `GOLD_STANDARD_DRAWINGS_SPEC.md`, `PER_CELL_OVERRIDES.md`, `CE_STRUC_DRAFTING_STANDARD.md`, `BEAM_SYSTEM_SPEC.md`, `SBEAM_RCBEAM_FIX_SPEC.md`, `V2_0_CHANGES.md`.
- **Tier 4 (code):** `PipeSizingModels.cs`, `MaterialVelocityLimits.cs`, `MathHelper.cs`, `JointModels.cs`, `council-profiles.json`, `DetentionSystemViewModel.cs`, `SupportPlacementEngine.cs`, `MinedDefaults.cs`.

> **Next:** Tim marks up §B (disagreements) and §D (the 10 questions) → confirmed rows become the seed
> of the real machine-readable rulebook the tools + AI will read.
