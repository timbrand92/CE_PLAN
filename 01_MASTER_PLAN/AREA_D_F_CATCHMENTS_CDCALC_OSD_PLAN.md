# Areas D + F — Catchments, CDCALC and OSD/detention design

**Read-only planning pass, 15 September 2026.** No production source was written for this document. It is the
*"CE Civil V3 - Plan - Catchments, CDCALC & OSD"* pass the master calls for (`V3_0_PLAN.md` §11).

**The master's current gate for this area, quoted:**

> | Calculations/catchments | Approved/closed | Existing foundations | Guided v3 workflow incomplete |
> | **Provenance and Apply-to-drawing review** |

**Tim's ruling that frames the whole thing, 15 September 2026:** CDCALC should produce the computations sheet —
*"yes it should, that's been the plan the whole time."* And: *"I want to do all the computations in the plugin."*

---

## 0. The single most useful finding

**Far more of this is already built than the "Planned" label suggests, and the missing piece is smaller and
different from what it looks like.**

CDCALC already computes the whole chain, and already has an export that is **computations-sheet shaped**:

| Already built | Where |
|---|---|
| Rational method (ARI, Tc, intensity, Q) | `RationalFlowService`, `RationalMethodViewModel` |
| Boyd's storage sizing → the volume required | `DetentionSizingService.SizeBoyds` |
| Orifice sizing → diameter from head | `OrificeSizer.Size`, `OrificeCalcViewModel` |
| Pipe flow / Manning's, pipe sizing | `Hydraulics`, `PipeSizingSolver`, `PipeFlowSizingAdvisorService` |
| Charged systems, pumps, soakage | `ChargedSystemCalcViewModel`, `PumpSizingService`, `SoakageSizingService` |
| Storage from what is actually drawn | `DetentionTwlService` + `DetentionBranchCollector` (built today) |
| The ON SITE DETENTION CRITERIA block on the sheet | `OnSiteDetentionCriteriaService` |
| The orifice pit detail | `OrificePitDetailGenerator` + `OrificeStandardDetailDrafter` |
| **A PDF/XLSX export carrying job number, address, page, engineer, revision, date, PSD, TWL, head, orifice, volume required, total storage, rational method and catchment areas** | **`CalculationExportPackage`**, reachable from CDCALC's Export PDF / Export XLSX buttons |

**So "CDCALC should produce the computations sheet" is not a new build. It is a finishing job on
`CalculationExportPackage`.** That reframes area F entirely.

---

## 1. What areas D and F actually are

- **D — Catchments, roof/impervious areas, flow paths and CDCALC.** Where the *areas* come from.
- **F — OSD/detention design, orifice sizing and storage calculations.** What is done with them, and what is
  issued.

They are one chain and should be planned as one: **areas in → design → storage → orifice → the sheet and the
drawing out.**

---

## 2. What the evidence says CE actually does

Measured read-only on 15 September 2026 across real office files. Nothing client-identifying is recorded.

### From 194 STORM Rating Reports

- CE's rating reports carry the **site area**, every **catchment** with its own impervious area, and each
  catchment's treatment. Read reliably: site area 98.8%, council 100%, rating 99.4%, rows 98.1%.
- **Treatments used across 701 rows: Rainwater Tank, None, Buffer Strip. Nothing else.** No raingardens, no
  swales, no porous paving in the entire history.
- The tank/no-tank split is what decides **which roof is detained**, and therefore the required volume and the
  top water level.

### From 61 real drainage computations sheets

- They state **PSD**, **SSR** (the required storage), the **pipes-and-pits vs tanks split**, the pipe and pit
  sub-totals, and every **orifice** with its plate height and head.
- **`head = plate height − d/2` on 43 of 43 orifices — 100%.** This confirms `ENGINEERING_RULEBOOK.md` item 7
  against CE's own output.
- The sheets write **`Co 0.6`** and **`g 9.8`** in full. That is CE's practice, recorded; it does **not** close
  the council coefficient question in `OPEN_QUESTIONS.md`, which is about what councils publish.
- The sheet's own shape: a header (job number, date, initials, address, revision), then PSD/SSR with the council
  named, then the detention split, then a pipe volume table by diameter, a pit volume table, and an orifice
  page per detention system.

### The lesson both sweeps taught, which belongs in this plan

**A folder or a filename is not evidence of what a document is.** 34 of 194 "STORM reports" were tank
specification sheets and supplier documents; **138 of 199 "computations" files were structural**, not drainage.
Any reader in this area must make the document say what it is before taking a number from it.

---

## 3. The shape D+F should take

```text
      STORM report  ──┐
      (site + catchment areas,          ┌──────────────┐
       which roof is treated)           │              │
                      ├──── areas ────► │              │
      The drawing    ─┘                 │    CDCALC    │
      (what is actually drawn:          │              │
       pipes, pits, tanks, levels)      │  computes    │
                      ├─ storage ─────► │  everything  │
      Council rules   ┘                 │              │
      (PSD, coefficients, freeboard)    └──────┬───────┘
                                               │
                     ┌─────────────────────────┼─────────────────────────┐
                     ▼                         ▼                         ▼
          The computations sheet      The OSD criteria block     The orifice pit detail
          (issued to council)         (on the plan)              (on the plan)
                     └──────────── all three from ONE record ───────────┘
```

**The rule that makes it worth doing:** the three outputs are generated from one computed record, so the sheet,
the plan block and the detail **cannot disagree**. Today they are three separately-produced things, and CE's own
history contains jobs where the totals did not add up — which is exactly Tim's ruling T-02 on tank volumes
(*"the plugin must make them impossible"*) applied to the whole OSD design.

---

## 4. The gaps, in the order they should be closed

Each is sized against what already exists, not from zero.

### D1 — Where the catchment areas come from *(small; most of it is built)*

Today CDCALC's catchments are typed. The STORM report holds them and is now readable
(`Rules/StormReport.cs`, `Services/StormReportReader.cs`, built today; CDDESIGN already offers site and
impervious area from it under Tim's rulings STORM-01..04).

**Gap:** CDCALC itself does not offer them; only CDDESIGN does. And a catchment's area is not yet attached to
the downpipes that drain it (`Rules/SourceDestinations` records where each downpipe goes, but nothing divides a
catchment's area across them).

**Decision needed (D-Q1):** should CDCALC offer catchments from the STORM report the same way CDDESIGN now
offers the site area — same offer/choose behaviour, same provenance?

### D2 — Provenance on every area *(this is the master's named gate)*

The master's next gate for this workstream is **"Provenance and Apply-to-drawing review."** Every area in CDCALC
should say where it came from: **typed**, **from the STORM report**, or **measured from the drawing** — and
Unknown must stay Unknown. The distinction already exists elsewhere in V3 (Unknown / Assumed / Pinned / Display
Override) and in `CivilDesignState.ImperviousReadFromXref`; it is not yet general.

### F1 — Finish the computations sheet *(medium; the export exists)*

`CalculationExportPackage` already captures the right figures and exports PDF and XLSX. To become **the**
computations sheet it needs:

1. **CE's own layout and wording**, matched against a real sheet (header block, PSD/SSR with the council named,
   the detention split, the pipe and pit volume tables, an orifice page per system).
2. **The council named beside PSD and SSR**, as CE writes it.
3. **The pipe and pit volume tables** — CDTWL already collects exactly this from the drawing
   (`DetentionBranchCollector` returns every pipe run and pit with its dimensions); nothing joins it to the export.
4. **Revision and issue state**, since councils require the sheet submitted and signed.

**Decision needed (F-Q1):** does the plugin's sheet have to *look like* CE's current sheet, or may it be a clean
V3 sheet carrying the same figures? That changes the size of this item substantially.

### F2 — One record behind the three outputs *(medium)*

The sheet, the OSD criteria block and the orifice pit detail should read from one computed record. Two of the
three already exist as generators; the join does not.

### F3 — Storage designed vs storage drawn *(small; both halves exist)*

CDTWL computes the storage actually in the drawing. The computations sheet states what was designed. Comparing
them catches a design that has moved since it was issued. **Nothing in CE can see that today.**

### F4 — Council rules feeding the calculation *(gated elsewhere)*

PSD, coefficients and freeboard should come from the council rulebook, not be typed. This is already an active
workstream with its own gate (Council rulebook (CR) in the master) and **eight decisions gating it**. D+F should
consume it, not duplicate it.

---

## 4A. D-Q2 answered — how CE's calculations are actually done

Tim, 15 September 2026: *"figure out how the calculations are done so we can design using this."* Derived
read-only from **59 genuine drainage computations sheets**.

### The chain, in CE's own words

```text
council PSD  ──►  Qp (restricted outflow)
                                            Smax = V1 (1 - Qp/Ip)
catchment C, A  ──► Ip = C·I·A/360  ──► V1 = Ip·T  ──►  swept over storm durations
                        ▲                                       │
                rainfall intensity I                            ▼
                                            SSR = the HIGHEST Smax
                                            critical duration = where it occurs
                                                        │
                storage provided = pipes + pits + tanks  ◄──── must meet SSR
                                                        │
                orifice: Qo = Co·Ao·√(2gh),  h = plate height − d/2,  adopt when Qo < PSD
```

Quoted from a sheet: *"Storage requirement is highest value of Smax calculated in the table below"*,
*"Critical storm duration is the storm duration when Smax occurs"*, *"Continue table until a clear Smax is
calculated"*.

### How often each element appears, across 59 sheets

| Element | Sheets |
|---|---:|
| detention / storage | 57 / 51 |
| orifice, with `Co` and plate height | 44 / 41 / 41 |
| PSD (permissible site discharge) | 42 |
| Volume of Pit / Volume of Pipe tables | 33 / 32 |
| Boyd's method | 28 |
| Tc, intensity, coefficient | 28 / 26 / 28 |
| SSR | 21 |
| pump | 13 |
| ARI written out | 4 |

`Volume/m` for a pipe is **π·d²/4**; pit storage is plan area × depth.

### What this confirms about the plugin

- **The formula matches.** The sheet writes `Smax = V1(1 − Qp/Ip)`; `DetentionSizingService` computes
  `V1 − Qp·T`. Since `V1 = Ip·T`, these are **algebraically identical**, and both reproduce the sheet's own
  first row (3645 − 1800 = 1845 L). Pinned in `BoydsMatchesCeSheetTests`.
- **The convention matches:** `Q(L/s) = C·I(mm/hr)·A(ha)/0.36` reproduces the sheet's Ip column.
- **The sweep is wider:** the plugin sweeps 5–180 min, CE's sheet stopped at 30 once Smax was clearly falling.
  The plugin is the more thorough of the two.

### ⚠ The one real discrepancy — the rainfall intensity

Measured against this sheet, the plugin's 1-in-10-year intensity is **systematically HIGH**, growing with
duration:

| Duration | CE's sheet | Plugin | Difference |
|---:|---:|---:|---:|
| 5 min | 98.6 | 105.0 | **+6.5%** |
| 15 min | 60.1 | 64.6 | **+7.6%** |
| 30 min | 40.9 | 44.4 | **+8.6%** |

*Documented fact:* the plugin ships **one** curve — the office Melbourne / OSD4W polynomial
(`Assets/Config/ifd-melbourne.json`).
*Documented fact:* CE's STORM reports name a **Rainfall Station per job**, and 40 distinct councils appear
across the 194 reports read.
*Hypothesis, not established:* this sheet was designed to a different station's curve.

**Consequence either way:** a job the plugin sizes carries roughly **7–9% more storage** than the one CE
issued. That direction is conservative, not unsafe — but it is not what CE issued, and **it has to be settled
before CDCALC designs unattended under D-Q1.** The difference is pinned by a characterisation test so it cannot
drift silently.

**New decision for Tim — D-Q3: is the plugin's single Melbourne curve right for every job, or must the
intensity come from the job's rainfall station?** The STORM report already names the station, so CE can read
it; what is missing is a curve per station.

## 5. What should NOT be built

- **Do not wire the computations-sheet reader into CDCALC as an input.** CDCALC computes these figures itself;
  reading its own past output back in would be reading yesterday's answer instead of working it out.
  `Rules/ComputationsSheet.cs` (built today) is **evidence and legacy-job reading only** — it earned its place
  by confirming the rulebook's head formula on 43 of 43 orifices, and it can read a job drawn before the
  plugin. It must not become an input path.
- **Do not learn engineering rules from old jobs automatically.** The master is explicit: *"do not learn from
  unreconciled old jobs."*
- **Do not duplicate the council rulebook work.** F4 consumes it.

---

## 6. Decisions this pass could not make — for Tim

| # | Question | Why it cannot be settled here |
|---|---|---|
| **D-Q1** | Should CDCALC offer catchment areas from the STORM report, the way CDDESIGN now offers the site area? | A behaviour change to the window Tim uses most. |
| **D-Q2** | Should a catchment's area be divided across the downpipes assigned to it, so connected roof area is a sum? | Needs Tim's view on whether per-downpipe areas are worth the bookkeeping; he already said roof area comes *"per catchment from the ESD report"* and the rest is *"an easy calc"*. |
| **F-Q1** | Must the plugin's computations sheet match CE's current layout, or may it be a clean V3 sheet with the same figures? | Decides whether F1 is a formatting job or a design job. |
| **F-Q2** | Should the sheet be issued from CDCALC directly, or through the Issue/QA workflow (area L)? | Councils require it submitted and signed. |
| **D-Q3** | Is the single Melbourne IFD curve right for every job, or must intensity come from the job's rainfall station? | **NEW, from the D-Q2 derivation.** The plugin reads 7-9% high against a real issued sheet. Must be settled before CDCALC designs unattended. |
| **F-Q3** | When the storage drawn disagrees with the storage on the issued sheet, what should CE do — warn, or refuse to issue? | R-27 says warn; but an issued sheet is a different weight of document. |

---

## 7. Suggested order

1. **D2 provenance** — it is the master's own named gate, and everything else is safer once every figure says
   where it came from.
2. **F1 the computations sheet** — the thing Tim has wanted all along, and mostly a finishing job.
3. **F2 one record behind the three outputs** — makes them unable to disagree.
4. **D1 catchments from the report into CDCALC** — after D2, so the provenance is already there to carry.
5. **F3 designed vs drawn** — cheap once F1 exists.
6. **F4 council rules into the calculation** — follows the CR workstream's own gates.

---

## 8. What this pass did and did not do

- **Did:** read the master and quoted its gate; surveyed the existing calculation stack; measured real office
  evidence read-only; recorded what is already built against what the "Planned" label implies.
- **Did not:** write production source, change any behaviour, or decide anything in §6.
- **DATA-01:** no client name, address or job address is recorded here.
