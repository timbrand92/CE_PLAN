# CE Civil — ready to deploy, and what to test

**Written overnight 15–16 September 2026.** Everything below is built, builds clean on all three AutoCAD
lanes, and is **not installed**. Nothing has been deployed.

> **Nothing in this document deploys anything.** Claude did not deploy, because the rule is that only the
> session Tim has told *in that conversation* "AutoCAD is closed, deploy" may do it. These are the steps for
> Tim to run, and the list of what to check afterwards.

---

## 1. What this batch is

One payload, one tick-list — per Tim's ruling of 14 September: *"fix everything on the branch, ONE payload,
ONE consolidated tick-list; no one-fix-one-deploy."*

| Item | What it does, in drawing terms |
|---|---|
| **IFD-01** | A job now carries **its own rainfall**. New command **`CDRAINFALL`**. A job with none of its own is **told** it is using the office Melbourne curve instead of being given it silently. |
| **D2** | **Every figure says where it came from** — typed, from the rating report, measured from the drawing, required by the council, worked out from other figures, an office default, assumed, or not known. |
| **F1 + F2** | **CDCALC now produces the drainage computations sheet**, from one record shared with the plan block and the orifice detail, so they cannot disagree. |
| **BUG-156** | A network redesign no longer forgets the drawing's split answer, its recorded downpipe destinations, or its rainfall curve. |

### The engineering reason IFD-01 matters

The plugin shipped **one** block of rainfall coefficients — the office Melbourne / OSD4W zone — and used it
for **every job in every council**. Measured against a real issued CE computations sheet it reads:

| Storm duration | CE's sheet | Plugin | |
|---:|---:|---:|---|
| 5 min | 98.6 | 105.0 | **+6.5%** |
| 15 min | 60.1 | 64.6 | **+7.6%** |
| 30 min | 40.9 | 44.4 | **+8.6%** |

Systematic and growing with duration — a different curve, not rounding. A job the plugin sized carried about
**7–9% more storage than the one CE issued**. Conservative, but not what CE issued.

**Tim's ruling, 15 September: *"yes, hold the coefficients per job."*** That is what this builds.

---

## 2. Deploy — the exact steps

**Close AutoCAD first.** The deploy script refuses to run while `acad.exe` is alive, and a build without the
skip flag would overwrite the live bundle.

```bash
cd "C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-civil-handoff-75-percent-671a19"
```

**Step 1 — prove the deploy would remove nothing that is already live.** This must print *nothing at all*:

```bash
git diff --diff-filter=D --name-only 817d482c HEAD
```

If it prints a filename, **stop** — do not deploy, and say so.

**Step 2 — build the release bundle** (this script already carries every no-deploy flag itself):

```bash
pwsh -File Installer\build_installer.ps1
```

**Step 3 — install it** (as your normal user, **not** "Run as Administrator"):

```bash
pwsh -File Installer\Deploy-Local-AsAdmin.ps1
```

**Step 4 — read the output before believing it.** Two things must be true:

- the bundle DLL's **SHA256 equals the just-built bin DLL**; and
- the CE_SHARED line reads **`… 0 blocked, 0 skipped`**. Anything else means the CE plugins are on different
  CE_SHARED builds — that is not a clean deploy.

**Step 5 — confirm what actually landed:**

```bash
powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"
```

The version string ends in the commit it was built from. It should end in this batch's commit.

---

## 3. What to test in AutoCAD

Five sample coefficient files were produced for section A. They are **synthetic test files**, not engineering
data for a real job.

| File | What it is |
|---|---|
| `SAMPLE_1_same_as_office.txt` | The office Melbourne block itself — loading it should give **the same rainfall as the office curve**, and CE should say exactly that |
| `SAMPLE_2_lighter_place.txt` | A different location, about 18% lighter |
| `SAMPLE_3_with_ari_column.csv` | The same numbers with a storm-frequency column and a header row, comma separated |
| `SAMPLE_4_BROKEN_only_three_rows.txt` | **Broken on purpose** — three rows instead of seven |
| `SAMPLE_5_BROKEN_wrong_order.txt` | **Broken on purpose** — rows in the wrong order |

### A. `CDRAINFALL` — the rainfall a job is designed to

*(2027 and 2024 — both lanes)*

1. Open a drawing that already has CE drainage in it. Type **`CDRAINFALL`**.
   **Expect:** *"This job has no rainfall curve of its own, so CE is using the office Melbourne (office OSD4W
   zone) curve… it reads about 7 to 9 per cent high…"*, then a small table of intensities for a 1 in 10 year
   storm at 5, 10, 15, 30 and 60 minutes. **The 5 minute figure should be about 105 mm/hr.**
2. Answer **File**, choose `SAMPLE_2_lighter_place.txt`.
   **Expect:** it asks *"What location are these coefficients for?"* with the **file name as the default**.
   Press Enter.
3. **Expect:** *"Read 7 storm frequencies for SAMPLE_2_lighter_place"*, the 1-in-10 table (**5 min should now
   be about 86 mm/hr**), a line saying it is **about 18 per cent lighter than the office Melbourne curve, so
   the storage this job needs changes by about the same amount**, then *"Design this job to that rainfall?"*
4. Answer **No**. **Expect:** *"Nothing was changed."* Run `CDRAINFALL` again — it must **still** say the job
   has no curve of its own.
5. Run it again, this time answer **Yes**.
   **Expect:** *"This job is now designed to the … rainfall curve. Every calculation from here on says so."*
6. Run `CDRAINFALL` once more. **Expect:** *"Rainfall for this job uses the … curve, from the file
   SAMPLE_2_lighter_place.txt."* — and **no** warning.
7. **Save the drawing, close it, reopen it, run `CDRAINFALL`.** The job's curve must still be there.
8. Try `SAMPLE_1_same_as_office.txt`. **Expect:** it is accepted, and the difference line says it gives
   **the same rainfall as the office Melbourne curve**.
9. Try `SAMPLE_3_with_ari_column.csv`. **Expect:** accepted — the header row and the storm-frequency column
   are both handled.
10. Try `SAMPLE_4_BROKEN_only_three_rows.txt`. **Expect:** *"A rainfall block needs 7 rows… 3 rows of numbers
    found. Nothing has been stored."* Run `CDRAINFALL` again and confirm the **previous** curve is untouched.
11. Try `SAMPLE_5_BROKEN_wrong_order.txt`. **Expect:** it is refused for being **out of order**, and again
    nothing is stored.
12. **Clipboard route:** open one of the sample files, copy the seven rows, then `CDRAINFALL` → **Clipboard**.
    Same flow as above.
13. With nothing copied at all, `CDRAINFALL` → **Clipboard**. **Expect:** *"There is nothing copied at the
    moment…"* and nothing changed.
14. `CDRAINFALL` → **Clear** → **Yes**. **Expect:** back to the office-curve message.
15. `CDRAINFALL` → **Clear** on a job that has no curve of its own. **Expect:** *"…there is nothing to clear."*
16. `CDRAINFALL` → press **Enter** (the default is Leave). **Expect:** *"Nothing was changed."*
17. **Brand-new empty drawing, no CE records at all:** `CDRAINFALL` → File → a good file → Yes.
    **Expect:** *"…could not be recorded because this drawing has no CE records yet. Draw a pipe or a pit
    first…"* — not a crash, and not a silent failure.

### B. The rainfall actually changes the design

18. On a job with **no** curve of its own, run **`CDDESIGN`** through to the design.
    **Expect:** among the notes, *"This job has no rainfall curve of its own…"*.
19. Note the **storage required**. Now set the job's curve to `SAMPLE_2_lighter_place.txt` (18% lighter) with
    `CDRAINFALL`, and run `CDDESIGN` again.
    **Expect:** the **storage required goes DOWN**, by roughly the same proportion. If it does not move at
    all, the curve is not reaching the calculation — say so.
20. Set the curve back to `SAMPLE_1_same_as_office.txt` and run `CDDESIGN` again.
    **Expect:** the storage required returns to the **original** figure, and the "no rainfall curve" note is
    **gone**.

### C. The computations sheet (F1) — this is the new one

21. Open **`CDCALC`** on a job with a detention system. Fill it in as you normally would.
22. Press **Export PDF** (and again with **Export XLSX**).
    **Expect:** the export now **leads** with a **DRAINAGE COMPUTATIONS** sheet under a
    **CREATIVE ENGINEERING** heading. In the XLSX it is the first tab, named **Computations**.
23. Check the header carries: job number, site, **council**, engineer, revision, date, page, and an issue
    line. On a sheet you have not marked as issued it should read **`DRAFT — NOT FOR CONSTRUCTION`**.
24. Check the **BASIS OF DESIGN** block names the storm frequency, **which rainfall curve** is being used, and
    Boyd's method.
25. Check that **Permissible site discharge** and **Storage required** each carry **the council's name in
    brackets**.
26. Check the **STORAGE PROVIDED** block: in the pipe runs / in the pits / in tanks and anything else /
    **TOTAL STORAGE PROVIDED** — and that the total really is the three added up, in both litres and m³.
27. Check it then says either *"This meets the storage required"* or *"THIS IS SHORT… by N L"*. **Make it
    short on purpose** (reduce the pipes) and confirm it names **how much** is missing.
28. Check the **VOLUME OF PIPE** table (by diameter, smallest first) and the **VOLUME OF PIT** table.
29. Check the **ORIFICE** block. **Plate height will say "not known"** — that is correct and deliberate:
    CDCALC holds the head on the orifice, not the plate height, and CE will not invent one by working
    backwards. The **head**, the **diameter**, **Co** and the **flow** should all be there.
30. Check the sheet **ends** with **WHERE THESE FIGURES CAME FROM**.
31. On a job with **no** rainfall curve of its own, the header must carry
    **`THIS SHEET HAS FIGURES THAT ARE NOT SETTLED`**. Set a job curve and re-export — if nothing else is
    unsettled, that line should be **gone**.
32. Leave the council unset and export. **Expect:** the sheet still comes out, PSD reads **"not known"** —
    **never `0`** — and the last block names it as not established. **Nothing should be blocked.**

### D. BUG-156 — a redesign must not forget things

33. On one drawing: record a downpipe destination with **`CDDEST`**, answer the split-on-draw question, and
    set a rainfall curve with `CDRAINFALL`.
34. Run a **network redesign and apply it**.
35. **Expect, after the apply:** `CDDEST` still shows the recorded destination; the split question is **not**
    asked again; and `CDRAINFALL` still reports the job's own curve. Before this fix, all three were lost.

### E. Nothing that already worked has moved

36. Open a job you know well that has **no** rainfall curve set. Run its detention calculation.
    **Expect: exactly the same numbers as before this update.** Any movement at all on a job with no curve of
    its own is a fault — report it.
37. Run `CDTWL`, `CDDEST`, `CDDESIGN` and `CDCALC` once each and confirm they behave as they did.

### F. The 2024 lane

38. Repeat **A1–A6** and **E36** on **AutoCAD 2024**. The commands must load and run — 2022–2024 users are in
    scope.

---

## 4. What is NOT done, and is honest about it

- **Where new coefficient blocks come from** is still open. The Bureau publishes IFD data per location; the
  fitted 7 × 7 block is CE's own derivation from it, and **how that fit was produced is not recorded anywhere
  CE still has**. **No fitting method has been invented.** A block pasted by hand per job — exactly what the
  office spreadsheet already did — makes the plugin correct per job without needing that answer, so that is
  what was built. **This needs Tim.**
- **The plate height on the orifice** is not held by CDCALC, only the head. Recorded, not guessed.
- **The critical storm duration** is worked out by the sweep but is not carried through to the sheet's
  summary. Small change, not done tonight.
- **PSD provenance** reads "required by <council>" whenever a council is named on the job. That is the
  strongest honest claim the calculation window supports today; it does not yet prove the figure came from
  the council rulebook. That belongs with the council rulebook workstream (F4).
- **Two tank block names are still unreadable** — `A$C1cba1a13` and `A$C72c6940a`. Still needs Tim.
- **Structural packaging** still has no release script and its bundle carries no `CE_SHARED.dll`, so a joint
  Civil + Structural release from one commit is still blocked.

---

## 5. Evidence behind the claims above

- **Builds:** net48, net8.0-windows and net10.0-windows — **0 errors** on all three.
- **Tests:** full Drainage suite on net10. The **23 failures are byte-for-byte the same tests** that already
  fail at `326c1303`, measured by checking that commit out into a throwaway worktree and running the same
  suite there. **No new failure was introduced.**
- **The office curve's own numbers are unchanged**, proven by running the new code against the un-refactored
  service before changing it, at 1e-12 across all seven storm frequencies and nine durations, and by the
  existing characterisation test that pins the 6.5–8.6% gap against CE's real sheet.
- **DATA-01:** every test fixture is synthetic. No client name, address or job address appears anywhere.
