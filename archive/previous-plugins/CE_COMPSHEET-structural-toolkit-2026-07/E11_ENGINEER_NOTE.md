# E11 — corrected + quantified note for a firm engineer

> **Tim: this supersedes the earlier draft.** If you already sent the first version, send this one
> — it **withdraws one of the two findings** and replaces the open-ended question with actual
> numbers. I haven't sent anything anywhere.

---

**Subject: Correction + findings — SUSPENDED FOOTING BEAM version 7.xlsm (please read, ~5 min)**

Hi [name],

Following up on my earlier note about the suspended footing beam spreadsheet. **I got one of the
two findings wrong, and I've since checked every job that used the sheet.** Corrected position
below.

## 1. WITHDRAWN — the shear/kv finding was my error

I said the sheet's `kv` overstates shear by ~33%, citing Cl 8.2.4.3 `kv ≤ 0.10`.

**That is the 2018+A1 text. Amendment 2 (2021) rewrote Clause 8.2 and raised the cap to 0.15:**

> "(a) For Asv/s < Asv.min/s then kv = 200/(1000 + 1.3dv) ≤ **0.15** … 8.2.4.3(1)"

The sheet computes kv ≈ 0.133, which sits **below** the A2 cap — so **the sheet's shear is correct
under Amendment 2** for the beam depths it's used on. I checked all 53 real beams: under A2 the
worst shear ratio is **0.97 — nothing fails in shear.** My apologies for the noise.

(The sheet's `MAX(formula, 0.10)` logic is still structurally wrong — it treats 0.10 as a floor —
but that only bites outside 256 mm < dv < 769 mm, and by ≤8%. Not worth chasing.)

## 2. STANDS — the bending check applies no φ, and 8 real beams are over the limit

**Cell A49:** `=IF(D48>=D44, "REINFORCEMENT IS SATISFACTORY", …)` compares **Mu** directly to
**M\***. AS 3600 requires **φMu ≥ M\***. This is unaffected by Amendment 2 — A2 changes only row (d)
of Table 2.2.2 (bending with axial compression); **every bending φ, including Class L 0.65, is
unchanged**. Every beam on this sheet is trench mesh → **Class L → φ = 0.65** (Table 2.2.2(b)(ii)).

Note the sheet **does** apply φ = 0.7 to shear (I47/I48) — so φ wasn't overlooked as a concept, it
just seems to have been missed on the bending line.

### What I found across every job

I read all 103 copies of the sheet in the Projects folder (2020–2026), read-only, and recomputed
each beam with φ = 0.65 applied. Excluding 45 unfilled template copies and 5 revision duplicates,
**53 unique designed beams**:

| | |
|---|---|
| Bending ratio M\*/(0.65·Mu) — median | **0.80** (healthy headroom) |
| Beams **over** 1.0 | **8** |
| Of those, materially over | **1** |
| Failing in shear (A2 basis) | **0** |

**The 8 beams over code bending capacity:**

| Ratio | Mark | Eng | Job |
|---|---|---|---|
| **1.381** | IB2 | D.H | **24-244_5 Rogers Street, Mentone** |
| 1.080 | EB2 | D.H | 24-330_13 Connel Road, Oakleigh |
| 1.030 | IB2 | D.H | 25-33_5 Augusta Drive, Drouin |
| 1.029 | EB3 | D.H | 26-25_2 Pacific Boulevard, Beaumaris |
| 1.018 | IB2 | D.H | 01_Carter Grange |
| 1.014 | EX.FOOTING | D.H | 25-66_22 Nambour Drive, Mooroolbark |
| 1.005 | EB1 | D.H | 24-180_15 Broadway, Elwood |
| 1.003 | IB2 | D.H | 01_Carter Grange |

**Seven of the eight are within 8% of the line** — arguably inside the noise of the sheet's own
simplified Mu formula, and the kind of thing you'd resolve by looking at the actual beam.
**One is not: Rogers Street IB2 at 1.38 — 38% over.** That's the one I'd look at first.

## 3. The edition question — it changes the answer, and only you can settle it

The firm's library holds **both** AS 3600:2018(+A1) and **Amendment 2 (2021)**. Which one our
certified work runs to isn't something the standard can tell me — it's an NCC/practice question.
It matters here:

| Basis | Beams over the limit |
|---|---|
| 2018 + **A2** (current amendment) | **8** (all bending) |
| 2018 + A1 (superseded) | **27** (mostly shear) |

I've worked to **A2** above on the grounds that it's the current published amendment and it's in
our own library — but please confirm, because it's the difference between 8 and 27.

## 4. Caveats — please read before acting on the list

- Job numbers are **folder-derived**. Cell E2 is unreliable (45 files have a date in it, and one
  job number appears across 9 folders).
- **I have not verified these are the as-built designs.** A beam may have been superseded, resized,
  or had fitments added outside this sheet. **This is a population to review, not a defect list.**
- Nine beams share identical inputs across nine projects — one reused standard design, replicated.
- Separately: **the blank template ships in a code-failing state** on its own default inputs
  (300×500, 3 m, 3L12TM). Worth fixing at source regardless.

## 5. What I'm asking

1. Confirm the φ reading (5 min in the sheet) and the edition (A1 vs A2).
2. Decide whether **Rogers Street IB2**, and then the other seven, warrant a re-check. That's an
   engineering and commercial call — it's yours, not mine.
3. Say whether the sheet should be flagged/pulled meanwhile — it's still in
   `01 - Design Spreadsheets` where it can be copied into a new job today.

Full per-beam data (inputs, Mu, M\*, ratios, file paths) is in a CSV I can send.

The replacement RC beam module applies φ correctly for both reinforcement classes and is
validated against worked examples — but it's months away, so it doesn't help with anything
designed between now and then.

Thanks — and sorry again for the false alarm on the shear.

Tim

---

## OPEN DEFECT — A2 Cl 8.2.1.6 `ks` fitment trigger NOT implemented (logged 17 Jul 2026)

Found while re-basing our code to Amendment 2. **Unconservative, and it compounds with the kv
uplift we just applied.** Verbatim A2 text (Cl 8.2.1.6, title and text replaced):

> "Transverse reinforcement shall be provided in all regions for any of the following cases:
> (a) V* − γp Pv > ks·φ·Vuc … 8.2.1.6(1)
> where (i) D ≤ 300 mm, ks = 1.0; or (ii) 300 mm < D < 650 mm, ks = (1000 − D)/700; or
> (iii) D ≥ 650 mm, ks = 0.5 … (b) T* > 0.25φTcr … (c) The overall depth of the beam or
> one-way slab is D ≥ 750 mm.
> Irrespective of the above, where it is shown by rational calculation satisfying conditions of
> equilibrium and compatibility that a shear failure of the structural component under
> consideration will not cause collapse of the structure, ks may be taken as 1.0."

- **RCB beams — clear-cut, must fix.** `RcbShear.Check` triggers fitments on `V* > φVuc` with no
  ks. For a 300×600 beam ks = 0.571 → trigger should be ~40.4 kN, not 70.8 kN. Under-reports
  when fitments are required for **any D > 300**. Also missing case (c): D ≥ 750 always requires
  fitments. **Owner: the RCB Fable chat (engine formulas).**
- **Footings — needs the engineer (new question E12).** The footing engines model **no
  fitment-required trigger at all**. We use Cl 8.2 (a beam clause) for footing shear capacity, so
  consistency suggests Cl 8.2.1.6 applies too — which would mean a 500-deep pad needs fitments
  once V* > 0.714·φVuc. That would be a significant change to standard residential practice,
  which makes me doubt the reading. The "rational calculation / will not cause collapse → ks = 1.0"
  escape may be exactly what covers a soil-supported pad. **This is an interpretation call, not a
  lookup — E12 for the firm engineer.**

## Notes for Tim (not part of the note)

- **Why the correction matters:** the first note's Finding 2 was right against A1 and wrong
  against A2. Sending the correction promptly is worth more than looking consistent — an engineer
  who spots the error themselves will discount the bending finding too, and the bending finding is
  the real one.
- **The bending finding got stronger, not weaker.** It's no longer "a sheet has a defect" — it's
  "8 named beams are over the line, here they are, one by 38%."
- **Our own footing engine** uses the A1 kv ≤ 0.10 → it under-predicts shear capacity by up to 33%.
  That's conservative (our footings come out bigger than needed), not unsafe. Fix is pending the
  edition answer — tracked in `REGRESSION_LOG.md`.
- **Feed the edition answer to both Fable chats.** The RCB plan's shear stage (Stage 2) is written
  to the A1 basis and must be re-based if we're on A2. A2 also now bars the simplified shear method
  where torsion is present, and moves the general method to primary.
