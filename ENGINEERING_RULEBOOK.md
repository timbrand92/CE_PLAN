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
7. **Detention geometry rules** — freeboard 150 mm below cover; max orifice = 2·baffle−1; head = baffle−d/2. `DetentionSystemViewModel.cs:601,773,632,655`.
   - **TWL = obvert of highest pipe — SUPERSEDED as an absolute, 15 September 2026 (TWL-01).** It remains the
     **default CE offers and names**, but it is no longer applied on its own. Tim: *"the TWL could be something
     other than the obvert of the highest detention pipe… we had a trench grate which was a higher level"*.
     CDTWL must list every candidate level with its source and **use nothing until Tim picks one**. The chosen
     level is the baffle crest, and `TWL − orifice IL` is the head that sizes the orifice.
     See `decisions/DECISIONS_LOG_DRAWING_INTELLIGENCE.md`, 2026-09-15 evening.
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

---

### Settings-first rule and the rulings of 2026-09-04

**R-00 (Tim, 4 Sept 2026, verbatim): "all of the engineering values and decisions must be part of the settings page so engineers can update system wide, same for council values, nothing should be hardcoded."** Every value in this rulebook is a seed for the Settings page: office standard, reasoned project override, council matrix as editable data. Any constant still in code is a migration item for C4 (#30), not a confirmed value.

| # | Ruling | Value / rule |
|---|---|---|
| R-01 | Maximum (scour) velocity per material, house rule | UPVC 3.0, concrete 6.0, metal 4.0, unknown 6.0 m/s. One table read by CDEDIT and auto-design (closes B3, BUG-080, gap D1). |
| R-02 | Minimum self-cleansing velocity | 0.6 m/s |
| R-03 | Minimum grade | AS/NZS 3500 per-diameter ladder governs; project "too-flat 1:200" is a drafting warning only (closes C4) |
| R-04 | Minimum cover | Setting: office standard seeded **450 mm**, project override with reason, council profile wins when present (Frankston 250) (closes B8, C6) |
| R-05 | Orifice plate | **Rounding part SUPERSEDED 25 Sep 2026 (Tim, CR-A3): round DOWN to the whole mm, never below the council minimum; `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`. Co = 0.6 confirmed (CR-A2).** Was: Snap up to the next standard plate, never below the council minimum; exact calculated size stays visible. Co = 0.6 (closes D9) |
| R-06 | Detention pipe house rules | Preferred maximum run 40 m; diameters 225 to 600; TWL at obvert of highest pipe; 150 mm freeboard below cover (closes C7, C8) |
| R-07 | Default pipe diameter | **100 mm**; per-type defaults read from the data model (pipe-type catalogue), never a constant (closes C13) |
| R-08 | Pit drop | 20 mm default, project-adjustable; lowest incoming pipe governs; main outlet only (closes C10) |
| R-09 | Twin detention pipes | One detention asset with two barrels: one schedule row, one storage volume, two drawn pipes; barrel count is a setting (default 1). Retires the hard-coded OFF. |
| R-10 | Reuse credit against detention, council has no recorded rule | Ask on every job (Needs confirmation until the engineer picks a credit basis); each answer recorded as a learning example; engineer may promote a company default on Settings. Known council formulas (Manningham, Kingston, Bayside) apply without asking. |
| R-11 | Reuse-only site, no formal detention | Carry the Melbourne Water STORM result with provenance; CE never recalculates it. |
| R-12 | One tank doing reuse and detention | One asset, two separately linked volumes (reuse below outlet, detention air space above), each with provenance (CIV-END-06). |
| R-13 | Charged downpipe system to a tank | Minimum head 300 mm house rule; Settings value with project override; charged-pipe check warns below it. |
| R-14 | Wet-well minimum (closes D7) | **No fixed floor; wet-well storage is calculated per job.** Settings review threshold (seed 3 m³) flags a small well for engineer review, never blocks. Evidence: PR #50, 10 jobs, median nominated storage 5.085 m³, smallest 0.82 m³ (24-26 small-pump). |
| R-15 | Which volume "minimum" means | Storage from pump-stop level to top working level (the office calculation bracket). Gross vessel volume and above-start reserve are separate labelled quantities. |
| R-16 | Stormwater pump arrangement | Two pumps, duty + standby, alternating (all 10 evidence jobs). |
| R-17 | Drawn pump-station master detail | Stormwater Pump Station (SPS) Detail, `Standard Details\Civil\CE Civil PUMP STATION Detail.pdf`. Small-pump pit, FRP/circular supplier layouts, groundwater and sewer stations are separate workflows. |
| R-18 | Orifice head (closes B11) | One definition everywhere: TWL down to the orifice centreline. Retires baffle−d/2, plate-height and caller-supplied variants. |
| R-19 | Masonry wall pairing gap (closes C12, Structural) | 350 mm confirmed as the widest face-to-face gap paired into one wall (band 70–350 mm). Settings value. |
| UI-01 | Flip scope | Flip applies to pipe labels, pit centreline text and source labels only; not pit IL labels, not pit marks. |
| UI-02 | Grip shapes (D8) | Four distinct grip shapes, no icons: square = move pipe end, triangle along pipe = slide label, diamond = offset label, circle = flip label side. |
| UI-03 | **SUPERSEDED 26 Sep 2026 by UX-MODE-01 (job mode: From markup / Design from scratch, per job; decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md).** Drafter / Engineer modes | Ribbon toggle, mode recorded in the drawing. Drafter mode hides catchment coefficients and PSD; Engineer mode shows and requires them. Issue from Drafter mode allowed with a recorded warning. |
| EV-01..EV-08 | Civil portfolio evidence rules | Confirmed 2026-09-04; full text on #25 (approval-to-be-confirmed after any post-approval change; four values kept separate; separate tank volumes; engineer confirms catchments; separate authority gates; issued Xref state remembered; highlight-together test; read-only first slice). |
| R-20 | Drawing vs calc rounding | **Orifice direction SUPERSEDED 25 Sep 2026 (Tim, CR-A3): orifice rounds DOWN to the whole mm; storage and member rules unchanged.** Was: Storage may round up within 0.02 m³; orifice rounds up to next whole mm, never above council max; members sum exactly to total. |
| R-21 | Tank allocation and STORM credit | STORM treatment volume = drawn reuse compartment; detention air-space never counts; "max 4,000 L tank" = reuse capacity. User override with recorded reason allowed. |
| R-22 | Local tank orifices | Own check at own head; local flows sum ≤ whole-site PSD; copied sizes flagged. |
| R-23 | Basement pump groundwater exclusion | Tanked basement; only ramp, AGI behind tanking and rain-fed floor wastes enter the SPS; note + geotech/waterproofing reference; "groundwater excluded" tick; missing reference **warns** at issue (R-27). |
| R-24 | AS/NZS 3500.3 edition | Current edition as one Settings value (2021 today); old jobs keep their issued edition; other years flagged. |
| R-25 | Council provisional vs nominated | Council-provided PSD/storage governs when issued; calculator shown alongside; OSD4W settings from the council profile. |
| R-26 | Template residue QA | Issue **warns** when job number / address / date mismatch the project record; odd note values flagged; warning recorded (R-27). |
| R-27 | No hard blocks (Tim verbatim: nothing hard-coded, nothing restricts users unless really serious) | Every check failure = warn + record + continue. Hard blocks only for items Tim lists as really serious (none listed yet). |
| R-27 list | "Really serious" hard blocks | Only two: deleting spine identities; pushing an update to colleagues on a failed build. Everything else warns + records. |
| R-28 | Annotation offsets (closes C11 / P-01) | At DIMSCALE: label text 70, invert text inward 200, saw-cut/CJ label 200, text mask 70 mm. Settings values. |
| R-29 | Step-iron note (closes P-05) | **Depth SUPERSEDED: 900 mm, office-wide (STEP-02, Tim 15 Sep, "LET'S DO OVER 900 DEEP"; confirmed 25 Sep, CR-A5). Note wording unchanged.** Was: 24 mm diameter galvanised MS step irons in pits deeper than 1000 mm; note text and depth are Settings values. |
| EV-05a | Completion checklist (P-06) | Per-job checklist on the project record; step names are a Settings list Tim fills later. |
| CP-01..CP-08 | Council profile data rulings | On #25 (4 Sept): Kingston residential-only; Glen Eira PSD 10-yr; Darebin C 0.4 / floor 0.8, Tc 10; Whitehorse Assumed; Manningham 40 outlet / 25 tank; Yarra Ranges council guide with 10/20/100 site case; Maribyrnong 20-yr, C 0.4 / 0.75; all 219 unsourced fields kept, tagged Assumed, warn on use. |

Source for each: CE house rule, Tim, 2026-09-04, revisable with an AS/NZS citation. Recorded on GitHub issues #25 and #30 (R-10 to R-19 and UI-01/02 answered the same afternoon in the plan-keeper chat; pump evidence PR #50).

Parked, awaiting Tim: none on the Civil side as of 4 Sept evening. D6 closed by R-10 to R-13; D7 closed by R-14 to R-17. P-01, P-05 closed (R-28, R-29); P-06 = EV-05a. Structural C9, D4, D5 parked to S1 (#33).

### Falls & grades
- Grade labels show the **actual achieved grade**, exact, **no MIN./MAX. suffix**, every mode 🔒 (`MathHelper.cs:156`).
- Achieved grade = round(L ÷ |fall|); auto-calc rounds inverts so effective grade is **at-or-steeper** than requested 🔒.
- Default minimum grade **1 in 100** 🔒 office default (`AdvancedSettingsViewModel.cs:236`).
- Upstream change → **if a fall is already set, hold it and re-base downstream; else apply standard/min grade for the DN** 🔒 BUG-073.
- Diameter **increase** → keep the **same small invert drop**, NOT obvert/soffit matching 🔒 BUG-076/077.
- Downstream drop = detect the upstream pit's drop and continue it; else the project default, **20 mm** unless the project setting says otherwise 🔒 2026-09-04 (R-08; supersedes the old 5 mm default). Lowest incoming pipe governs the outlet; with two outlets the rule applies to the main outlet only 🔒 2026-09-04.

### Pipe sizing & hydraulics
- Self-cleansing min velocity **0.6 m/s** 🔒 2026-09-04 (R-02).
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

---

## Speed and reliability framework (Tim, 28 Sep 2026: "I WANT PRODUCTIVITY, SPEED AND RELAIBILITY TO BE THE MAIN FRAMEWORK OF THIS PLUGIN")

Applies to every CE change, Claude and Codex. Born from BUG-189 (AutoCAD slow after CE interaction, recovers on waiting).

1. **Drafting never waits on CE.** Ordinary AutoCAD work (LINE, SPLINE, pan, zoom, grips) must feel the same with CE loaded as without it.
2. **Never re-read the whole drawing because one thing changed.** Event handlers (object changed/added/erased, command ended, selection changed, idle) update only the objects that changed. A full model-space scan is allowed only on drawing open, an explicit repair or audit command, or a recorded fallback that logs why it ran.
3. **Time budgets.** Any single CE handler: under 10 ms typical, never over 50 ms. Idle work is split into slices of 20 ms or less per idle tick. Work over budget logs a `[PERF]` line.
4. **Nothing piles up.** Every queue, cache or pending list has a clear owner that empties it, a size cap and a `[PERF-SUMMARY]` count. Every event subscription (`+=`) has a matching removal, and no handler can be added twice.
5. **Measure before and after.** Every speed fix ships with the before and after timings from the `[PERF]` log (Civil log `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`), and an automated guard against the regression.
6. **Functionality is kept.** A speed fix may change when and how much CE re-reads, never what the drawing ends up showing. Keep the full rebuild as a safety net for rare cases (Undo across many objects, a repair command), with its use logged.
7. **Logging is cheap and quiet.** Always-on logging goes through the queued background writer. No line every second; state changes and summaries only.
8. **Reliability.** No background thread touches the drawing or the ribbon (API guardrail 5). A failure in a CE handler must never stop AutoCAD's own command. Warn and record (R-27).
9. **Productivity.** Fewer clicks and prompts for the same output. Every command is judged by the UI cockpit test: used 30 times a day.

---

## Autodesk API guardrails (carried from the retired global rule file, 19 Sep 2026)


Source: https://blog.autodesk.io/guardrails-for-using-ai-in-autodesk-plugin-development/
Full original: `C:\Autodesk\ADN-Samples\autodesk-ai-guardrails-copilot-instructions.txt`.
Adopted for all CE plugin work on 2026-09-15. Applies to every chat, Claude and Codex.

## 1. No speculation about Autodesk internals
Autodesk.* APIs are closed-source. Only the documented contract is authoritative. Never claim
to know internal algorithms, caching, threading, storage or COM/native details. Never say
"definitely the root cause" without diagnostic proof. Never assume behaviour is the same
across AutoCAD versions (CE targets 2027 net10; 2022-24 net48 is unpromised).

## 2. Diagnose before hypothesising
Before proposing a fix for an AutoCAD-side bug, have: exact error text, stack trace, product
version, .NET runtime, and execution context (active document? transaction open? document
locked? UI thread? command running?). If any is missing, ask Tim for it or get it from the
CE log first. Then hypotheses, labelled as hypotheses.

## 3. Separate facts from guesses in every report
Documented fact / observed in log / hypothesis / assumption. Write "the log shows…",
"based on the docs…", "I have not verified…". Avoid "internally AutoCAD does X".

## 4. Execution context and transaction safety
Database writes need an open transaction and a document lock. Wrong context gives
eLockViolation, silent no-ops or drawing corruption. Verify context before any write. Prefer
`StartOpenCloseTransaction` for reads outside commands. Regen after geometry changes.

## 5. Threading
Autodesk APIs are not thread-safe. No background threads or async touching the drawing or
the ribbon. UI-bound calls on the main thread only. Stability beats performance.

## 6. Change safety
Minimal, isolated changes. Test in a throwaway drawing first. No broad refactor of
Autodesk-touching code without a reason Tim has agreed. Every AutoCAD-coupled change ships
with a REGRESSION_LOG entry and a manual checklist (see plugin-work.md).

## 7. Admit gaps
If the docs do not cover it and the log does not show it, say "insufficient information"
and propose the probe that would settle it (accoreconsole probe, Snoop, MgdDbg).

## 8. Read the .NET wrapper before guessing (added 10 Oct 2026)
AutoCAD's .NET layer (acdbmgd, acmgd, accoremgd, AdWindows, AcWindows) is decompiled, read-only, at
`C:\Tools\AcadDecomp\2027\` (and `2026\`, from the 25.1 reference copies). ObjectARX help is unpacked at
`C:\Tools\ArxDocs\`. Never copy that code into a repo; never commit it. Search it with Git Bash grep (paths pass
260 characters). Most calls go straight into native code: the wrapper shows what .NET does, not what AutoCAD
does inside, so guardrail 1 still applies to everything past the wrapper.

Facts read from the 2027 wrapper (managed side only):
1. **After Commit or Abort, .NET checks nothing.** An object from `GetObject` keeps its pointer and
   `IsDisposed` stays false; every property read passes straight to native code. What native code then does
   was measured: see 8 and 9 below. Copy Handle, Name and points out before Commit.
2. **`Transaction.AddNewlyCreatedDBObject` always hands ownership to the transaction** (AutoDelete false),
   whatever `add` says. `Dispose()` on that object then deletes nothing; it only empties the wrapper. Any later
   read through that wrapper hands a null pointer to native code (measured: AutoCAD dies, see 10).
   `OpenCloseTransaction` differs: `add=false` leaves .NET owning it, and `Dispose()` then deletes it.
3. **`BlockReference.Name` opens the block definition on every read**, but measured cheap (~3 ms per 2,000
   plain blocks). The real cost is CE's own effective-name routine on DYNAMIC blocks (a separate transaction per
   block: ~110 ms per 2,000 CE pits vs ~29 ms with a cache per definition id) and reading
   `DynamicBlockReferencePropertyCollection` (~270 ms per 2,000). Cache per definition id in any whole-drawing loop.
4. **`Database.SaveAs(name, version)` (two-argument form) accepts only R14 to 2018 DWG formats**; older
   ones return an error. 2027 still writes the 2018 format (`DwgVersion.Current` = `Newest` = AC1032), so
   `Current` is always safe.
5. **2026 to 2027 public API** for DatabaseServices, EditorInput and ApplicationServices: no types added or
   removed. The one real change: `Database` gained `Equals(db1, db2)` and `GetHashCode()` based on its runtime
   id. A `Dictionary<Database, …>` now keys on that id in 2027 and on the wrapper pointer in 2026.
6. **`CommandEnded` and `DocumentToBeDestroyed` are plain relays** of the native notifications. Whether the
   drawing is locked inside them, and whether `DocumentToBeDestroyed` comes after "Save changes?", is not
   documented; measured in 14 below.
7. **The headless `/isolate` switch failed on Tim's PC** ("Can't find 'TempDirectory' registry value"): the
   AutoCAD profile "Tim" had no TempDirectory value. FIXED 10 Oct 2026 03:34 on Tim's word ("do what you need
   to"): added `HKCU\Software\Autodesk\AutoCAD\R26.0\ACAD-A101:409\Profiles\Tim\General Configuration\TempDirectory`
   = `C:\Users\TimothyBrand\AppData\Local\Temp` (copied from the Unnamed profile). Undo: delete that one value.

MEASURED in AutoCAD 2027 accoreconsole, 10 Oct 2026, 24 tests, evidence in
`C:\Tools\AcadProbe\runs\20261010-033521\` (probe source `C:\Tools\AcadProbe\src\Probe.cs`). Core console only;
the full AutoCAD window was not tested and may differ.
8. **Reading after Commit/Abort/Dispose of the transaction silently returns the real values** (Handle, Name,
   Position, GetPoint3dAt, all transaction kinds). No error. It works today but is undocumented: keep copying
   values out before Commit.
9. **Writing to an object after its transaction ended kills AutoCAD** (process gone, no .NET exception to
   catch). Same for **writing to an object open only for read**. Never write unless `IsWriteEnabled`.
10. **Reading an object after `Dispose()`** (transaction-owned new object) **kills AutoCAD** (access
    violation, 0xC0000005). Dispose-then-Abort and Dispose-then-Commit are both safe: no double delete; Commit
    keeps the object in the drawing.
11. **Locked layers:** `GetObject(id, ForWrite, false, forceOpenOnLockedLayer: true)` opens for write and the
    edit commits (the layer stays locked). `ForRead` + force, then `UpgradeOpen()`, is refused with
    eOnLockedLayer (both transaction kinds). Plain `ForWrite` is refused with eOnLockedLayer. CE's native
    protection rule (AGENTS.md) still decides whether CE may ever use the force flag.
12. **`Database.Insert(name, sourceDb, true)` onto an existing block name REDEFINES it in place**: same
    ObjectId, contents replaced. The 4-argument overload and `WblockCloneObjects(..., Replace)` behave the same.
13. **`SaveAs` back over a side database's own file** works when it was read with `OpenForReadAndAllShare`,
    with or without `CloseInput(true)` (tiny test drawing; for big drawings call `CloseInput(true)` first, as
    the rest of the file may still be read lazily). With `OpenForReadAndReadShare` or `...WriteNoShare` it fails
    with eFilerError and leaves the file untouched.
14. **Events:** inside `CommandEnded` the drawing is still write-locked by the ending command and writing
    worked. Inside `DocumentToBeDestroyed` `LockMode()` says Write and `IsApplicationContext` is true, but
    **writing there killed AutoCAD**: never write in DocumentToBeDestroyed. In the console it fired after the
    "discard changes?" answer; the full-AutoCAD "Save changes?" order is still unverified.
15. **Ribbon (read in AcWindows 2027):** on every selection change AutoCAD hides every visible tab marked
    `IsContextualTab` that its own CUIX rules did not ask for. `RibbonControl.ShowContextualTab` sets that
    mark, which is why CE's tab was hidden again (Test Day 5-09) and needs the Idle watchdog in
    `CeContextualTabController`. Just before hiding, AutoCAD raises the public
    `RibbonServices.RibbonPaletteSet.ContextualTabDisplayed`; its `e.HiddenTabs` is the very list it then
    hides, so removing CE's tab from it keeps the tab up without an Idle watchdog (read, not yet tried).
16. **2024 (net48 lane) has the same transaction, dispose and equality logic** (read from the 24.1 copy,
    not run); 2027 only adds `GC.KeepAlive` calls and the Database Equals/GetHashCode pair. A dictionary keyed
    by Database and fetching a disposed-then-reused id were measured safe in 2027 (tests G1, D7).
    Full write-up with the plugin audits: `04_REFERENCE\AUTOCAD_API_DECOMPILE_FINDINGS_2026-10-10.md`.
17. **REDO (measured, core console, 10 Oct 06:25):** REDO survives only if nothing in between ends it. Killers
    with NO command running: any `StartTransaction` (even read-only, aborted or empty), `SetCurrentView` (even the
    same view; sets VIEWBACKSTATUS 0 to 1), `SetSystemVariable` (even the same value), any write, and any command
    at all (even an empty one). Safe: `StartOpenCloseTransaction` reads, `Regen`, `UpdateScreen`,
    `SetImpliedSelection`, `LockDocument`. So CE code on Idle, events and palettes must read with
    `StartOpenCloseTransaction` only. Details: `areas\AUTOCAD_API_DECOMPILE_TESTING_ANSWERS_2026-10-10.md`.
18. Lookup helper: `bash C:\Tools\AcadDecomp\tools\acad-error.sh eLockViolation` (or a number) gives the
    error's number and the ObjectARX functions documented to return it.

---

## Plugin work: every change has three deliverables (carried from the retired global rule file, 19 Sep 2026)


> Extends `collaboration.md` and `testing.md`. Applies to ALL CE plugin work
> (CE_CVL_SUITE, CE_STRUC_SUITE, CE_StrucPlus, CE_SUITE_MANAGER, CE_SHARED).
> Tim made this rule explicit on 2026-05-15.

## The rule (MANDATORY)

Every plugin change — bug fix, feature addition, refactor, dialog rewrite,
service extension — has THREE deliverables:

1. **Code change** (the obvious one)
2. **Documentation update** (REGRESSION_LOG.md + relevant tracker files)
3. **Test coverage** (unit tests for pure logic, manual checklist for the rest)

If you skip 2 or 3, the change is not done — even if the code compiles and runs.

> **Note, 20 Nov 2026 (Tim: "Rest agreed" on `areas\rules.md`):** since `C:\TimOS\RULES.md` 4.5 (rev 2) the AI does the
> testing. The "manual checklist" below is written for the robot and the Codex look in real AutoCAD, and for Tim only
> where engineering judgement is needed. The rule itself is unchanged.

## Documentation update — what to write

### REGRESSION_LOG.md (project root or `<project>/REGRESSION_LOG.md`)

One entry per change, following the existing template:

```
### {BUG-XXX | PARK-XXX | FEATURE} — Short description (YYYY-MM-DD)
- **Symptom:** what Tim sees in AutoCAD (described in AutoCAD terms, not code terms)
- **Root cause:** why it happened in code
- **Fix:** files changed + one-line summary
- **Test:** test class/method name OR "manual only — see checklist below"
- **Date fixed:** YYYY-MM-DD
- **What Tim should test in AutoCAD:**
  1. Step
  2. Step
  3. Expected outcome
- **Still at risk:** related code that could re-introduce this
```

For features (not bugs), use the same template but the "Symptom" section
describes the GAP the feature fills.

### PARKING_LOT.md

For every PARK-XXX touched: update the master table status emoji AND the
detail section status line. Stale statuses are the worst-case mess across
sessions. Move COMPLETED items to the Completed table at the bottom — don't
leave them in the active list.

### BUG_CARPARK.md (root of the workspace)

For every BUG-XXX touched: update the status row in the table at the top AND
the detail section's `**Status:**` line. Same rule about completed items.

### V2_1_PLAN.md (or current-version plan)

When a phase or sub-item is built or shipped, mark it ✅. When deferred to a
later phase, note that explicitly. The plan is the navigation map — keep it
honest.

### CHANGELOG.md

For user-visible changes only. One line per change, grouped under the version
heading.

## Test coverage — what to write

### Pure logic → unit tests (NUnit, NO AutoCAD runtime)

If the change has any logic that doesn't directly call Autodesk.* APIs,
write a unit test. Examples: formula calculations, string formatting, data
model defaults, validation rules, predicate functions.

Tests live in `<Project>.Tests/...` mirroring `<Project>/...` structure.

Test naming: `MethodName_ScenarioCondition_ExpectedResult`.

Example: `BuildLidRemarksLayout_StepIronsAndCustom_ReturnsSingleLineInlined`.

### AutoCAD-coupled logic → manual checklist

For code that calls Autodesk.* APIs (block insertion, GetPoint, transactions,
reactors), full automation isn't possible. The deliverable is a **manual test
checklist in the REGRESSION_LOG entry** ("What Tim should test in AutoCAD")
with specific steps and expected outcomes.

Tim does the manual tests; you write the script he follows.

### When a change has both → write both

Pure-logic helper plus AutoCAD wrapper? Unit-test the helper, manual-test the
wrapper. The unit test catches regressions when you refactor; the manual test
catches AutoCAD-specific issues.

## The "what specifically" rule

Manual checklists are useless if they say "test that PIT works". Write them
the way Tim writes them himself:

✅ "open an existing pipe with a 375mm diameter and check the Edit Pipe
dialog shows 375mm pre-filled"

❌ "test the pipe editing functionality"

Include edge cases Tim might not think to check ("also try a pipe with no
diameter set", "also try a pipe whose Properties dialog was opened then
cancelled").

## When NOT to skip docs

Don't skip when:
- "It's a quick fix" — quick fixes are the highest-regression-risk changes
- "It's just adding a property" — properties become public surface area
- "It's just a dialog change" — Tim relies on the dialog every day
- "The build is green" — green builds say nothing about correctness

Skip only when:
- The change is a one-off doc edit (no code touched)
- The change is purely cosmetic and observable visually in one second

## Cross-session integrity

Tim works across multiple Claude sessions. The docs are the only memory
between sessions. If you fix something and don't document it, the next
session won't know — and will likely break it again chasing a related
symptom. Treat the docs as paid-in-advance technical debt.

## Pre-commit / pre-deploy sanity check

Before any plugin deploy round:
1. Did I add a REGRESSION_LOG entry for every code change?
2. Did I update PARKING_LOT / BUG_CARPARK statuses?
3. Did I write or update tests where the logic is testable?
4. Does the build show 0 errors on both TFMs (net48 + net10.0-windows)?
5. Do the test filters I added pass?

If any answer is "no", finish that step before sending Tim the deploy
PowerShell.

---

## R-LEARN — The evidence model is never finished (Tim, 19 September 2026)

Tim's words: *"will the corpus/data/evidence model continue to be updated from what were working on and anything that is learnt from? that should be a hard rule and constantly evolving"*.

1. **Every job worked on feeds the evidence.** When a chat reads a real drawing, a council document, a markup or a correction Tim makes, the lesson is recorded the same reply: the anonymised rule or pattern in this repository (a council file, an area file, this rulebook), the identifying evidence in the local-only store `C:\CE_DrawingIntelligence\` (the CEMARKUP corpus is `10_Plugin_CEMARKUP_Corpus\`; the programme's own folders are as its README says).
2. **The evidence model (EV-03) is the mechanism**, not a one-off: objects, relationships, drafting scenes and correction history keep being added as projects are worked. The project queue in `03_DRAWING_INTELLIGENCE\CIVIL_KNOWLEDGE_PROJECT_QUEUE.md` is the order; a project used for work is a candidate for the queue.
3. **A correction from Tim is evidence.** When he says a value, a placement or a label is wrong, the corrected rule goes into the rulebook or the council file with his words and the date, and the case goes into the corpus so the plugin can be tested against it.
4. **DATA-01 still holds.** Client names and addresses never enter a repository; the corpus grows on disk, the lessons grow in git.
5. **A session that learnt something and recorded nothing has not finished.**
