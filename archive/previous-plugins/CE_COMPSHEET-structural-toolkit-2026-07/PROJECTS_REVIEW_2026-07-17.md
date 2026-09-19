# Projects Folder Computation Review (17 July 2026)

Source: `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects`
Scale: ~2,050+ jobs, 2020–2026, 276k files / 344 GB. Mostly residential (Melbourne bayside /
inner-east), plus schools/childcare/rec centres. 2025+ organised into builder accounts
(Carter Grange, Inform, MJS, Centrum…).

## What a real CE computation package is (the thing the toolkit must produce)

- **One CE-branded, single-page Excel printout per member**, merged into one
  `NN-NN_Computations.pdf` deliverable (2026 splits STR + CVL).
- Beam sheet (from `01_BEAM DESIGN.xlsm`): CE logo header + Page/Project No./Date/Designer
  boxes; span diagram with loads and reactions; reaction/moment table (G, Q, G+Q, ultimate);
  loading breakdown (kPa × width → kN/m per Roof/Wall/Floor/Other + self-weight + point
  loads); deflection check; bending/shear capacity with k1 and combinations; adopted member.
- Footing sheet (from `02_FOOTINGS.xlsm`): loads, bearing pressure and eccentricity, section
  diagram, yellow "ADOPT 500×500×600 DEEP PAD FOOTING" outcome box.
- Comps organised by revision folder (`REV P1 DH`) with discipline subfolders:
  `01 FRAMING, 02 SLAB AND FOOTINGS, 03 SPACEGASS, 04 INDUCTA, 05 BASEMENT, 06 STK`
  plus a `MEMBER SCHEDULE.pdf`. Revised members get a prime mark (`FB10'`).
- Production mark series: FB (floor beam), RB (roof beam), L (lintel), PB, GL, LRB,
  TH/PF/EB/IB (footings).

## Tools actually in use on jobs

| Tool | Evidence | Role |
|---|---|---|
| In-house Excel suite | every job; 27k spreadsheet files | member design → per-member PDF |
| SPACE GASS | 1,165 `.sg` | portal frames / steel analysis (~15–20% of jobs) |
| Inducta RCB/SLAB/RAPT | 1,400+ `.rstx/.slbx` | RC buildings, suspended slabs, PT |
| **Structural Toolkit v5.43** | 3,675 `.mem` | commercial steel/timber member design (benchmark for our output) |
| CE Beam Designer `.cebeam` | **ZERO files** | not yet in production — Phase 0 lands before first real use |

Also: Tim's `.ce_struc` Sheet Manager (drawing/sheet issue management) is already live on
2026 jobs — the drawing side is automated; the computation side is still 100% legacy.

## Consequences for the Toolkit plan

1. **Comp-sheet v2 (Phase 1) must clone the production single-page format** — validate by
   side-by-side against a real member PDF (e.g. I25-02 `01 FRAMING\FB1.pdf`).
2. **Mark generator** must support the production series (FB/RB/L/PB/GL/LRB/TH/PF/EB/IB) and
   the prime-mark revision convention (`FB10'`). → backlog.
3. **Package assembly**: merged deliverable needs discipline grouping + MEMBER SCHEDULE page
   (app's master PDF is close; needs the grouping). → backlog.
4. **Benchmark targets**: golden-value comparisons should include Structural Toolkit and
   Inducta outputs where available on real jobs, not just hand calcs.
5. Positioning confirmed: replace the Excel suite + STK member design; interoperate with
   (not replace) SPACE GASS and Inducta.

## Process observations (for Tim — not engineering judgements)

- **Stale shared templates**: civil calc spreadsheets dated 2014–2019 are copied verbatim into
  current jobs (`PIT SCHEDULE.xls` 2014, `ORIFICE.xlsx` 2016, `BOYDS METHOD.xls` 2018);
  "version 7" / "_CORRECTED" filenames show manual version control of the calc suite. The
  toolkit's single-source-of-truth model directly fixes this.
- **~45–55% of job folders lack a merged Computations PDF** (many keep loose per-member PDFs;
  some quote/dead jobs have none — worth a firm-process check, not a toolkit issue).
- **OneDrive collision litter**: "conflicted copy" DWGs, `.bak`, `_recover` files across years.
- **Password-protected Structural Toolkit files** — continuity risk if the author leaves.
- **`XX_CHINA` folder on 2026 jobs** — full project sets (incl. client emails/fee docs) sit in
  the same tree being shared for offshore drafting; worth a deliberate data-handling decision.
- Four different project-folder templates across 2020→2026; comps sub-organisation is ad hoc
  per engineer.
