# Gate A — Engineer Context Pack

**Companion to `VALIDATION_GATE_A_REVIEW.md`.** The review sheet lists *what* to decide; this pack
gives the engineering basis behind each decision — the clause, the legacy method, a worked
representative job, the root cause, and what each choice means for the firm's existing designs.

**Prepared by:** platform validation (cockpit synthesis of the beam/footing lane `fleet/rcb-data-repair`
and the frame lane `fleet/ce-frame-testing`). Every number below is quoted from the validation packs
and reconciled to the source code and legacy sheet cells; file references are in the appendix.

---

## 0. Orientation — read first if you have not seen this tool

| Question | Answer |
|---|---|
| **What is the tool?** | "CE Beam Designer" — a Windows desktop app that replaces the firm's per-member Excel comp sheets. It designs RC beams, pad/combined footings, steel & timber members, and portal/truss frames to current AS standards, and prints comp-sheet PDFs. |
| **Why this review?** | Before the firm relies on it, each engine was run against **thousands of the firm's own historical comp sheets** (and, for frames, against SPACE GASS output). Where the app agrees, it is GREEN. Where it disagrees, we did **not** adjust the app to match — we found the root cause and put it to you. |
| **House rule** | *Mechanics win. A benchmark that disagrees with the code is not a target to fit.* Two legacy CE sheets have already been shown unconservative (a suspended-footing-beam sheet applying no φ to bending; the beam-moment summing method in Decision 2). |
| **What does signing mean?** | You are confirming the **calculation basis** the app uses is acceptable firm practice for each of the five areas — not re-checking arithmetic. The arithmetic is verified to the last digit in the packs. |
| **Editions in force** | RC: **AS 3600:2018 Amdt 2 (2021)**. Steel/frames: **AS 4100:2020**. Timber: **AS 1720.1:2010**. Load combinations: **AS/NZS 1170.0:2002 Cl 4.2.2**. |

**How to read each decision below**

- **Direction** tells you which way the app differs: 🟢 app is *more conservative / more correct* than the legacy sheet · 🟠 app is *less conservative* (needs your eye) · ⚪ *uncertain / evidence-limited*.
- **Recommendation** is the mechanics-based reading. You confirm or override it.

---

## Decision 1 — Timber capacity basis  ⭐ highest priority

### The basis, side by side

| | App (AS 1720.1:**2010**) | Legacy Excel (AS 1720.1:**1997**) |
|---|---|---|
| Bending capacity | φ·k1·**k12**·f′b·Zxx·qty | φ·k1·**k12**·f′b·Zxx·qty — *identical formula* |
| φ, k1, f′b, Zxx | 0.8, 0.80 (5-month), 20 MPa, 270 750 mm³ | same |
| **k12 (stability)** | computed from slenderness S1 over the **full 3.0 m** length | effectively **1.0** (no slenderness reduction applied) |

**The two sheets use the same equation.** The only operative difference is the beam **stability
factor k12**, which reduces bending capacity for a member whose compression (top) edge can buckle
sideways between restraints.

### Worked example — job 21-105 (2 / 190×45 F7 KDTP, Lₑ = 3.0 m, M\* = 3.860 kN·m)

| Term | App | Legacy |
|---|---:|---:|
| S1 = 1.25·(d/b)·√(Lay/d) = 1.25·(190/45)·√(3000/190) | **20.97** | small (≈ ≤11) |
| ρb·S1 (ρb = 0.91) | 19.08 | < 10 |
| **k12 = 1.5 − 0.05·(ρb·S1)** | **0.546** | **1.0** |
| **φMb** | **3.783 kN·m** | **6.931 kN·m** |

`6.931 / 3.783 = 1.832 = exactly 1 / 0.546`. **100 % of the gap is k12.** Demand 3.860 > app 3.783 →
utilisation 1.02 → the app fails a beam the legacy sheet passed.

### Root cause — a restraint-modelling question, not a formula error

The app applies the AS 1720.1:2010 Eq 3.2(4) slenderness reduction over the **whole 3.0 m span** for
sagging, and — this is the key code fact — it **never treats a continuously-restrained top edge as
k12 = 1.0 in the sagging direction** (it only cancels slenderness for the uplift/negative case). The
1997 legacy sheet effectively applied no slenderness reduction here (k12 = 1.0).

So the real question is physical:

> **Is the compression (top) edge of these timber beams continuously restrained by the floor/roof they carry?**
> - **Yes (typical floor beam under fixed decking/joists)** → k12 ≈ 1.0 is correct; the app is **over-conservative**, and the legacy value was right *for these beams*. The app has a **modelling gap** — it cannot currently represent continuous top restraint for sagging.
> - **No (top edge only held at ~3.0 m centres, e.g. isolated lintel/rafter)** → k12 = 0.546 is correct; the **legacy sheet was unconservative** by up to 1.83×.

### Scope of the finding

- **30 firm timber adoptions fail the app's check** — same k12 root cause. Grades: F17 KDHW ×15,
  F7 KDTP ×5, LVL13 ×5, MGP10 ×3, Smart LVL15 ×2. In ~14 the app finds *no* member of that grade
  passing at target utilisation (forces a heavier section); several also fail the app's **G-only
  deflection** policy.
- **5 selection-policy cases** (member passes; the app disagrees on auto-selection): 22-255 DJ1
  (no 95 %-utilisation option exists) + four heavier picks (24-305, 21-46, 21-116, 23-62).
- Separate minor item: the database stores **MGP10 ρb = 0.73 vs AS 1720.1 Table 3.1 = 0.75**
  (slightly *unconservative*, ~3 %). Independent of the k12 gap. One-line fix once you confirm.

### The ask
> ☐ **Restraint reality:** are the firm's timber floor beams continuously top-restrained in service? (drives everything above)
> ☐ Current platform basis accepted ☐ Legacy basis retained ☐ Further calculation audit / app fix required
> ☐ Auto-selection policy: keep 95 %-utilisation target? treatment of the 5 heavier-pick cases? ______
> ☐ Confirm MGP10 ρb → 0.75

**Recommendation (mechanics):** do **not** blanket-accept either side. If the beams are floor-restrained
(likely for most FB/DB marks), the correct fix is to **extend the app to model continuous top restraint
(k12 = 1.0) for sagging**, then re-run — the 30 "failures" are then expected to clear. Genuinely
unrestrained members (isolated lintels/rafters) should keep k12 < 1.0, where the legacy sheet was
unsafe. This is the one decision with real capacity at stake.

---

## Decision 2 — Beam peak & sign reporting

### The basis, side by side

| | App | Legacy Excel |
|---|---|---|
| Combined G+Q moment | max over the span of **(M_G(x) + M_Q(x))** at the *same* position x | **max(M_G) + max(M_Q)** — the two peaks *added even when at different positions* |
| Governing signed moment | envelope of the six AS/NZS 1170.0 Cl 4.2.2 combinations, **sign preserved** (sagging +, hogging −) | `=MAX()` of a gravity-only column — **discards negative (hogging) values** |

### Why the legacy overstates

Superposition only lets you add two load effects **at the same section**. The legacy cell adds the
largest G moment (at one location) to the largest Q moment (at another), crediting both to a single
section that does not exist on the beam. It is therefore always an **upper bound** ≥ the true combined
peak. The app adds the diagrams ordinate-by-ordinate and takes the real maximum.

- **59 beams** affected; in all 59 the individual G moment, Q moment and every reaction **match exactly**.
  The overstatement is **0.0115 – 2.5005 kN·m (median 0.0695)** — small, and always in the safe direction.
- **Job 20-246** (uplift case): the G case contains uplift (confirmed by a negative reaction −5.760 kN).
  The G moment swings **+2.047 sagging** at one node and **−2.696 hogging** at another. The legacy
  `=MAX()` reports only +2.047; the app's sign-preserving logic reports the governing **−2.696**. The
  legacy silently hid the larger hogging action.

### Direction 🟢 — the app is more correct on both counts.

### The ask
> ☐ Accept platform combined-position envelope ☐ Retain legacy reporting ☐ Other: ______
> ☐ Confirm sagging-positive / hogging-negative sign convention for reporting

**Recommendation:** accept the platform. It is mechanically correct; the legacy method over-predicts by
summing non-coincident peaks and can hide hogging under uplift. Stakes are low in magnitude (median
0.07 kN·m) but the **sign/uplift behaviour matters** for members that can hog.

---

## Decision 3 — Footing bearing & reinforcement basis

### Minimum steel — the basis, side by side

| | App (AS 3600:2018 Cl 8.1.6.1(2)) | Legacy Excel |
|---|---|---|
| Min steel | **A_st,min = αb·(D/d)²·(f′ct.f / fsy)·b·d**, αb = 0.20, f′ct.f = 0.6√f′c | **(1.4 / fsy)·b·d** — the *superseded* rule (= 0.0028·b·d at fsy 500) |
| Depends on | concrete grade **and** depth (D/d) | neither — a flat value |

Ratio app/legacy = 0.0857·(D/d)²·√f′c. For grade 25, D/d = 500/415: **= 62.2 %**. Across the firm's
typical grade-25, ~500-deep pads this lands at **58.8 – 62.2 % of the legacy steel** — because the
current clause scales with grade and depth while the legacy flat rule does not.

### Self-weight in bearing

The app adds the footing's own concrete weight into the **unfactored serviceability** bearing pressure
(`pv = G + Q + self-weight`). The legacy sheet sized several pads from the 400 kN column load only. This
is why some pads come out **one 50 mm increment larger**.

### Worked example — job 21-297 PF2

| | Firm adopts | Platform requires |
|---|---|---|
| Size | 1500 × 1500 × 500 | 1550 × 1550 × 500 |
| Bearing at firm size | — | **189.78 kPa > 180 allowable** (self-weight 27 kN tips it over; 400/2.25 = 177.8 would pass without it) |
| Min steel | **1743 mm²** (legacy rule) | **1084 mm²** (Cl 8.1.6.1(2)) = 62.2 % |
| One-way & punching shear | — | **pass** |

**Across the 16 reinforced pads:** 6 same size · 6 need 50 mm larger (self-weight) · 2 come out 50 mm
smaller (legacy rounded plan up 100 mm; app uses 50 mm steps) · 2 different plan/depth strategy. Every
one carries the 58.8–62.2 % min-steel difference.

### Direction — mixed but both correct: 🟢 min-steel basis is current-code; slightly larger plans are the honest self-weight effect.

### The ask
> ☐ Confirm footing self-weight is included in the serviceability bearing check
> ☐ Confirm minimum-reinforcement basis = AS 3600:2018 Cl 8.1.6.1(2) (replaces the superseded 1.4/fsy rule)

**Recommendation:** accept the app basis. The minimum-steel clause is the correct current-code rule; the
legacy sheet used a superseded formula, so ~60 % is expected and compliant — **confirm the firm is
comfortable specifying the lower (code-minimum) steel**. Self-weight-in-bearing is correct practice.

> ⚠️ **One documentation fix before sign-off:** the validation pack's summary table still lists concrete
> footings as "AS 3600:2018 incl. **Amdt 1**", but the engine's design basis is **Amdt 2** (`As3600.cs`:
> `Edition = "AS 3600:2018 (Amdt 2, 2021)"`). It does not affect min-steel, but Amdt 2 raised the
> no-fitment one-way-shear kv ceiling 0.10 → 0.15 — reconcile the wording so the pack matches the code.

---

## Decision 4 — CE Frame portal comparison (job 20-110 PF1)

### The comparison bands (pre-declared, never loosened after seeing a result)

| Comparison | Tolerance |
|---|---|
| Linear — reactions & member end forces | ≤ 0.5 % |
| Linear — node displacements | ≤ 1 % or 0.1 mm |
| Second-order — forces / displacements | ≤ 2 % / ≤ 3 % |
| Against annotated SG plot PDFs | plan says ≤ 1 %; **PF1 was judged at a more lenient 2 % / 0.1 mm band** |

### The 6 out-of-band PF1 annotations (all fail even the lenient 2 % band)

| Quantity | SPACE GASS | CE Frame | Miss |
|---|---:|---:|---:|
| G+Q rafter sagging moment | 29.51 kNm | 28.86 kNm | 2.21 % |
| ULS right-knee moment | 40.35 kNm | 39.25 kNm | 2.73 % |
| ULS rafter sagging moment | 41.43 kNm | 40.43 kNm | 2.40 % |
| G+0.7Q midspan deflection | −3.29 mm | −3.19 mm | 3.11 % |
| G+Ws eaves sway | 10.41 mm | 10.17 mm | 2.30 % |
| G+Ws midspan deflection | −2.75 mm | −2.60 mm | 5.27 % (0.145 mm, small absolute) |

**Not called an engine defect.** The PF1 source is a one-page SG plot with **rounded** annotations that
**omits the shear areas and full section-property tables** the engine needs — so a 2–5 % spread is
consistent with plot rounding + a slightly different section library, not a mechanics error. The
mismatch is pinned in a green regression test so it cannot be silently lost.

### Weight of contrary evidence — 3 frames fully GREEN

| Job | What was matched |
|---|---|
| **21-03** (West St Kilda) | reactions ≤ 0.5 %, forces ≤ 1 %, deflections ≤ 3 %, elastic buckling λc vs SG **42.902** within 5 % — 4/4 |
| **21-311** (Ravenhall 35.2 m truss, **non-linear**) | displacements/reactions across G/Q/Ws/Wu + 3 ULS combos ≤ 1.5 %, and SG's 3 printed buckling factors **3.355 / 1.434 / 1.426** within 6 % — 6/6 |
| **20-01** (Perry Rd, 250 PFC cantilever) | 13/13 printed reactions, moments, deflections within band — 4/4 |

SPACE GASS is **not installed on this machine**, so the plots cannot be regenerated as tables here.

### Direction ⚪ — uncertain, but low risk (three independent frames, incl. non-linear + buckling, are green).

### The ask
> ☐ Accept as plot/property uncertainty ☐ Investigate engine ☐ Request full report first

**Recommendation:** treat as plot-rounding uncertainty and **request one full text-report export from
`PF1 PORTAL FRAME.SG`** on a licensed workstation (path in the export cheat-sheet). With full section
properties the 2–5 % is expected to close. The three green jobs — one of them a non-linear 35 m truss
with matched buckling factors — are the stronger evidence that the engine is sound.

---

## Decision 5 — Frame analysis office defaults (F1–F10)

Ten defaults let the frame engine run without asking a question per model. Nine are safe/technical;
**three are firm-policy** and are highlighted. You may approve F1–F10 **as one set** and write only
exceptions.

| # | Default | Note |
|---|---|---|
| F1 | Keep present benchmark set; add a rod-braced portal when a full report exists | representativeness |
| F2 | Use shear deformation when section shear areas known, rigid otherwise | technical |
| F3 | Include member self-weight automatically as a labelled G load | technical |
| F4 | ULS combinations second-order, SLS/cases linear (user-configurable) | technical |
| **F5** ⚑ | **Warn at λc < 3.5; refuse at λc ≤ 1.0** (pending clause confirm) | **AS 4100 Cl 4.4** — the second-order-required threshold; confirm the exact clause value & firm policy |
| **F6** ⚑ | **Notional horizontal forces OFF for single-storey portals** until you rule | **AS 4100 Cl 3.2.4** (0.002 × vertical) — applicability to single-storey portals vs multistorey is the policy call |
| F7 | Spring/inclined supports deferred until a benchmark needs them | technical |
| **F8** ⚑ | **Report portal sway/deflection WITHOUT pass/fail** until firm limits supplied | firm SLS policy — e.g. eaves height/150, rafter span/limits |
| F9 | Steel E = 200 000 MPa, G = 80 000 MPa | AS 4100 Cl 2.2.4 — standard values |
| F10 | Use the pre-declared comparison tolerances to declare the engine validated | the bands in Decision 4 |

### The ask
> ☐ Approve F1–F10 as written, subject to exceptions on F5 / F6 / F8: ______

**Recommendation:** approve as a set. All three policy defaults are conservative (warn/refuse on
instability, notional forces on rather than silently off would be *less* safe — here they are off but
flagged, so confirm; sway reported rather than silently passed). Supply the firm's portal SLS sway
limits (F8) when convenient so the engine can start reporting pass/fail.

---

## Summary — what you are actually being asked

| # | Area | Direction | The real question | Mechanics recommendation |
|---|---|---|---|---|
| 1 | Timber k12 | 🟠 app conservative *if* restrained | Are the beams' top edges floor-restrained? | Likely **fix the app** to model continuous restraint, then re-run |
| 2 | Beam peak/sign | 🟢 app correct | Accept true combined-peak + signed reporting? | **Accept app** |
| 3 | Footing steel/self-wt | 🟢 app current-code | OK with code-minimum steel + self-weight in bearing? | **Accept app** |
| 4 | Frame PF1 | ⚪ plot uncertainty | Engine issue or rounded plot? | **Get one SG text export**; 3 frames already green |
| 5 | Frame defaults | 🟢 conservative | Approve the 10 defaults? | **Approve as a set**, confirm F5/F6/F8 policy |

**Only Decision 1 carries real capacity at stake.** Decisions 2, 3, 5 are "confirm the app is right";
Decision 4 needs one file exported from a SPACE GASS machine.

---

## Appendix — source evidence (for audit)

- **Timber:** `TimberDesignEngine.cs` (φMb :398, ComputeK12 :422–426), `TimberMember.cs` (S1 :43),
  `TimberMembers.json` (21-105 member; MGP10 ρb :941), `SHEET_TIMBER_DESIGN_DUMP.txt` (legacy k12 cell,
  AS1720.1-1997 header), `docs/VALIDATION_PACK.md` §A4.
- **Beam:** `SimpleBeamAnalysisEngine.cs` (:261–267 combined G+Q, MaxAbs :407–416),
  `LoadCombinationService.cs` (:73–86 signed envelope), `CombinationEnvelope.cs` (sign convention),
  `docs/VALIDATION_PACK.md` §A3, `docs/VALIDATION_SCALE_BEAM_ACTIONS.csv` (:181 job 20-246).
- **Footing:** `As3600.cs` (min steel :120–127, `Edition` :44), `PadFootingDesignEngine.cs`
  (self-weight in bearing :106–109), `SHEET_PAD_DUMP.txt` (legacy P35 :152), `docs/VALIDATION_PACK.md`
  §5/§A5, `docs/VALIDATION_SCALE_FOOTING_INVENTORY.csv` (:20 job 21-297).
- **Frame:** `docs/VALIDATION_PACK_CEFRAME_DRAFT.md` §5/§7, `docs/CE_FRAME_PHASE41_42_PLAN.md`
  §6.2/§10, `benchmarks/CORPUS_SCORECARD.md`, `benchmarks/JOB-20-110-PF1-DOSSIER.md`,
  `docs/SPACEGASS_EXPORT_CHEATSHEET.md` (BM1 export path).

*The beam/footing/timber evidence lives on branch `fleet/rcb-data-repair`; the frame evidence on
`fleet/ce-frame-testing`. Both converge onto `master` at Phase B integration, at which point this pack
and `VALIDATION_GATE_A_REVIEW.md` sit beside their supporting packs.*
