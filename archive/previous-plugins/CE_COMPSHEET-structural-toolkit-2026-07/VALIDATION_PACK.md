# CE Beam Designer — Engineering Validation Pack

**Release:** Phase 0 (Australian Standards compliance) · **Date:** 17 July 2026
**Prepared by:** development (T. Brand + Claude Code) · **For review by:** _____________________ (CPEng)

---

## For the reviewing engineer — how to use this

Tim (the developer) is not an engineer. This pack exists so that ONE of the firm's qualified
engineers can confirm the software's calculations are correct **before it is used to produce
issued computations.** Every worked example below is reproduced by the software's automated
test suite (test name given), so if you confirm the hand calc, you are confirming the code.

You are asked to:
1. Check each worked example against your own judgement / a hand calc.
2. Initial each section's sign-off box.
3. Answer the **open questions** in Section 7 (data provenance we could not confirm from the office library).
4. Note any check you consider missing for the firm's typical work.

Estimated time: ~45 minutes. Nothing here is used on a real job until this page is signed.

---

## 1. Standards basis

| Item | Edition used | Source (office library) |
|---|---|---|
| Load combinations | **AS/NZS 1170.0:2002** (incl. Amdt 1–5) | Australian Standards\...\AS 1170.0-2002(+A5).pdf |
| Wind actions (calculator) | AS/NZS 1170.2 | (calculator only — see §6 note) |
| Steel members | **AS 4100:2020** | Australian Standards\Steel\...\AS4100-2020.pdf |
| Timber members | **AS 1720.1:2010** (incl. Amdt 1–3) | Australian Standards\...\1720.1-2010(+A3).pdf |
| Concrete footings | **AS 3600:2018** (incl. Amdt 1) | Australian Standards\AS3600-2018.pdf |
| Steel section capacities | ASI Design Capacity Tables (Grade 300/300PLUS) | WSP...\ASI publications\DCTv1.pdf + OneSteel HRSSP |

All capacity/load factors are now stored as data tagged with the clause they come from, and the
governing combination is printed on each member's output.

---

## 2. Load combinations (AS/NZS 1170.0 Cl 4.2.2) — the headline fix

**What changed:** the app previously designed everything for a non-standard **1.25G + 1.5Q** and
treated wind as live load, so it **never checked wind uplift**. It now evaluates the full Cl 4.2.2
strength set and reports which one governs:

| Combination | Clause | Purpose |
|---|---|---|
| 1.35G | 4.2.2(a) | permanent only |
| 1.2G + 1.5Q | 4.2.2(b) | permanent + imposed |
| 1.2G + 1.5ψlQ | 4.2.2(c) | long-term imposed (ψl = 0.4 residential) |
| 1.2G + Wu + ψcQ | 4.2.2(d) | permanent + wind + imposed (ψc = 0.4 residential) |
| **0.9G + Wu** | 4.2.2(e) | **wind uplift / reversal — previously never checked** |
| G + Eu + ψEQ | 4.2.2(f) | earthquake (ψE = 0.3 residential) |

ψ factors from Table 4.1 (residential/domestic floors: ψs 0.7, ψl 0.4, ψc 0.4, ψE 0.3; "all
other roofs": ψl = ψc = ψE = 0).

### Worked example 2A — gravity (test: `As1170EnvelopeTests` case a)
Simply supported beam, span L = 4.0 m, floor. G = 5 kN/m, Q = 3 kN/m.
- 1.35G → w = 6.75 kN/m → M* = wL²/8 = 6.75 × 16 / 8 = **13.5 kN·m**
- 1.2G + 1.5Q → w = 6.0 + 4.5 = 10.5 kN/m → M* = 10.5 × 16 / 8 = **21.0 kN·m ← governs**
- **App result: M\* = 21.0 kN·m, "Governing: 1.2G + 1.5Q".** (Old app gave 21.5 kN·m under 1.25G.)

### Worked example 2B — wind uplift (test: `As1170EnvelopeTests` case b)
Light roof beam, span 4.0 m. G = 1 kN/m (down). Wind uplift W = −4 kN/m (up).
- 0.9G + Wu → w = 0.9 × 1 − 4 = −3.1 kN/m → M* = −3.1 × 16 / 8 = **−6.2 kN·m (net uplift)**
- **App result: minimum envelope −6.2 kN·m, "Governing uplift: 0.9G + Wu".** A timber member that
  passed under gravity may now fail this — that is the point of the fix.

> ☐ Engineer sign-off (§2 load combinations): __________________  date ________

---

## 3. Timber design (AS 1720.1:2010) — slenderness fix

**What changed:** the beam slenderness coefficient S1 used a non-standard formula (Lay·d/b²) that
made members wildly over-conservative. It now uses the code equations, and every load combination
is checked with its **duration-of-load factor k1** (Table 2.3): permanent 0.57, floor-imposed
0.80 (5 months), wind/earthquake 1.00 (5 s).

### Worked example 3A — slenderness (test: `TimberDesignEngineTests` S1 case)
240 × 45 MGP10, discrete restraints to the compression edge at Lay = 3.0 m.
- Eq 3.2(4): S1 = 1.25 (d/b) √(Lay/d) = 1.25 × (240/45) × √(3000/240) = 1.25 × 5.333 × 3.536 = **23.57**
- ρb·S1 = 0.75 × 23.57 = 17.68 → k12 = 1.5 − 0.05 × 17.68 = **0.616** (Cl 3.2.4)
- (Old code gave S1 = 355 → k12 ≈ 0.003, i.e. ~nil capacity — clearly wrong.)

> **Open item for you (§7 Q3):** the timber database stores ρb = **0.73** for MGP10; AS 1720.1
> Table 3.1 lists **0.75**. 0.73 gives slightly *higher* k12 (slightly unconservative). Please
> confirm the intended source before we change it (Appendix E gives r-dependent values).

> ☐ Engineer sign-off (§3 timber): __________________  date ________

---

## 4. Steel design (AS 4100:2020)

**What changed:** (1) the member moment-capacity table was validated against the current ASI DCT;
(2) a **web shear check (Cl 5.11)** was added — previously steel shear could never fail.

### 4A — Bending capacity data validated
The app interpolates φMb from a per-section table vs effective length. Spot-checks against the
ASI DCT (Grade 300, αm = 1.0) match to the published figures — e.g. 610UB125: φMs = 927 kN·m,
φMb at le 2/4/6/8 m = 872 / 675 / 492 / 367 kN·m (app reads identical). Full 16-section check is
automated in `SteelCapacityGoldenValueTests`. One conservative outlier flagged: 150PFC at
le = 6 m app reads 11.4 vs DCT 13.0 (app is safe-side).

### 4B — Web shear (Cl 5.11: φVv = φ·αv·0.6·fyw·Aw, φ = 0.90) — test: `SteelCapacityGoldenValueTests`
Previously steel shear could never fail (capacity was set to infinity). Now checked, with the
web-area convention **Aw = d·tw** (overall depth × web thickness) — confirmed as the convention
that reproduces the published ASI φVv values (all 16 sampled sections within 0.5%).
- **250UB25.7**: d = 248 mm, tw = 5.0 mm, fyw = 320 MPa → Aw = 1240 mm²
  → φVv = 0.9 × 0.6 × 320 × 1240 / 1000 = **214 kN** (published DCT φVv = 214 kN ✓)
- Web slenderness check `dp/tw ≤ 82/√(fyw/250)` (dp = d − 2tf) determines whether the full
  yield capacity or a buckling-reduced value applies; all sampled hot-rolled sections are stocky.
- A short span with a heavy point load producing V* > φVv now fails / is rejected in auto-design
  (test: `DesignSimpleBeam_HighShearShortSpan_RejectsSectionsBelowPhiVv`). Some short
  heavily-loaded beams will now auto-select a heavier section than the old build — that is the
  safety fix working.

> **Limitation for you (§6):** only rolled UB/UC/PFC sections carry tabulated web data (51 of
> ~330 in the library). Compound / plate / welded (WB/WC/TFB) sections report shear as **"not
> evaluated" with a warning** rather than passing silently — the engineer must verify shear by
> hand for those until their web data is added.

> ☐ Engineer sign-off (§4 steel): __________________  date ________

---

## 5. Footing design (AS 3600:2018)

**What changed:** minimum reinforcement updated from the superseded 1.4/fy rule to Cl 8.1.6.1(2);
**one-way (beam) shear and punching shear** now checked; ultimate load N* = max(1.2G+1.5Q, 1.35G).
Soil bearing remains an unfactored G+Q vs allowable-pressure check (geotechnical practice).

### Worked example 5A — minimum flexural steel (test: `PadFootingDesignEngineTests`)
Pad, 500 mm thick, per metre width, f'c = 25 MPa, d = D − 85 = 415 mm.
- f'ct.f = 0.6√f'c = 0.6 × 5 = 3.0 MPa (Cl 3.1.1.3)
- Ast,min = 0.20 (D/d)² (f'ct.f/fsy) b d = 0.20 × (500/415)² × (3.0/500) × 1000 × 415
  = 0.20 × 1.452 × 0.006 × 1000 × 415 = **723 mm²/m** (app: 722.9 mm²/m ✓)

### Worked example 5B — punching shear (Cl 9.3.3)
fcv = 0.17(1 + 2/βh)√f'c ≤ 0.34√f'c; Vuo = u·dom·fcv; φ = 0.70. The app computes the critical
perimeter u at dom/2 from the column face and fails the footing (or grows its depth) when
N* > φVuo. Pass/fail golden cases in the test suite (pass 170/1753 kN; fail 912/425 kN).

> **Open item for you (§7 Q2):** the *combined* footing uses a stud-capacity lookup table
> (DS/TS/P2/P3 vs span) whose origin we could not trace. Values left unchanged and flagged in code.

> ☐ Engineer sign-off (§5 footings): __________________  date ________

---

## 6. Notes / limitations (state of Phase 0)

- **Wind pressure calculator** (AS 1170.2) is single-surface (one Cpe/Cpi at a time) — the full
  directional/area-reduction procedure is a Phase 4 item. It now applies loads as W (signed), so
  uplift flows into combination (e). Engineer to set the wind pressures.
- **External angle lintels** use the manufacturer/office safe-load table on an unfactored (G+Q)
  basis — this matches the original spreadsheet; see §7 Q1.
- **Continuous beams**: analysis is three-moment (Clapeyron); see the regression log for the
  current member-sizing basis.
- **Steel shear coverage**: only rolled UB/UC/PFC sections (51 of ~330) have tabulated web data
  and get an automatic shear check; compound/plate/welded sections report shear "not evaluated"
  and need a manual check.
- Auto-designed member sizes are **suggestions pending engineer-confirmed loading** and are
  labelled as such.

---

## 7. Open questions — engineer's answers required

| # | Question | Answer |
|---|---|---|
| Q1 | External angle lintel safe-load table — original source, and is it current? | |
| Q2 | Combined-footing stud capacity table (DS/TS/P2/P3) — source? | |
| Q3 | Timber ρb for MGP10: use 0.73 (current DB) or 0.75 (Table 3.1)? | |
| Q4 | Firm policy: confirm deflection limits (Floor L/600 G, L/300 Q, L/250 G+Q; Roof L/500, L/250, L/200; Cantilever L/400, L/200, L/150). | |
| Q5 | Any check you consider missing for the firm's typical residential/light-commercial work? | |

---

## 8. Overall release sign-off

I have reviewed the worked examples in Sections 2–5 and the limitations in Section 6, and I
authorise / do not authorise use of CE Beam Designer (Phase 0 build) for issued computations,
subject to the notes above.

Name: ____________________  CPEng/RPEng No.: ____________  Signature: ____________  Date: ________
