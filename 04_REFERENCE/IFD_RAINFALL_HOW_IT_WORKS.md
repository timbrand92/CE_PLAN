# Rainfall intensity — how it actually works at CE, and what the plugin should do

**15 September 2026.** Tim: *"yes, hold the coefficients per job. but I am not 100% sure how things work so you
are going to have to get an understanding yourself."* This is that understanding, worked out read-only from
CE's own spreadsheet and the plugin's own data. Nothing here is guessed; where something could not be
established it says so.

---

## 1. The one-paragraph version

Rainfall intensity is not a single number or a lookup table. For any given **location**, CE holds a block of
**seven coefficients for each of seven storm frequencies**, and intensity is computed from them with one
formula. Those coefficients come from outside CE — from the Bureau's IFD data for that location — and were
pasted into a spreadsheet by hand, once per location. **The plugin currently hard-codes one location's block
and applies it to every job**, which is why it reads 7–9% high against a real issued sheet.

---

## 2. The formula

```text
I(mm/hr) = exp( A + B·ln(T) + C·ln(T)² + D·ln(T)³ + E·ln(T)⁴ + F·ln(T)⁵ + G·ln(T)⁶ )
```

- **T is the storm duration in HOURS** (not minutes — a real trap).
- **A…G** are the seven coefficients.
- There is **one set of seven per ARI**, and CE uses seven ARIs: **1, 2, 5, 10, 20, 50 and 100 years**.
- So a location is described by a **7 × 7 block of numbers**. Nothing else.

This is a curve *fitted* to the Bureau's published intensities, not the Bureau's own equation. It exists so a
spreadsheet can produce an intensity for any duration rather than only the durations the Bureau tabulates.

---

## 3. How CE has actually been doing it

From `Creative Engineering - Engineering\Civil Spreadsheets\RS_Rain Intensity Spreadsheet.xlsx`, read
read-only. Its own on-sheet instructions:

> *"To import into excel:
> 1: Copy the table into Note Pad and Save the file as a .txt file
> 2: Open excel and open the .txt file
> 3: Select 'delimited' then press next, then select 'tab' and 'comma', then press finish"*

and a cell labelled **"Paste Coefficient Values Below"**, with columns **A B C D E F G**, an **"ARI in years"**
input, a **"Time (min)"** input and an **Intensity (mm/h)** output.

So the workflow was:

1. Fetch the IFD data for the site's location from the Bureau.
2. Save it as a text file named for the location.
3. Open it in Excel, delimited.
4. Paste the 7 × 7 coefficient block into the sheet.
5. Read intensity out for whatever ARI and duration the design needs.

**The evidence that it really was per location:** the workbook still contains the formula

```text
C9 = [1]!'!MORN!R2C2:R8C8'
```

— an external reference to a named 7 × 7 range called **`MORN`** (Mornington), and the link resolves to
**`C:\Users\RS2\Desktop\MORN.txt`**, a text file on a former colleague's desktop. `RS2` is the same `RS_` that
prefixes the spreadsheet's own filename.

**Those per-location text files are gone.** That is why the workbook is full of `#REF!` errors, and why only one
location's numbers survive anywhere — the ones already extracted into the plugin.

---

## 4. What the plugin has today

`Modules/Drainage/Assets/Config/ifd-melbourne.json` holds **exactly one** such block:

- `"name": "Melbourne"`, described as the office OSD4W Melbourne zone;
- seven curves, ARIs 1 / 2 / 5 / 10 / 20 / 50 / 100;
- seven coefficients each — the same 7 × 7 shape the spreadsheet referenced;
- the same formula, with duration in hours.

`RationalFlowService.GetIntensity(ari, durationMin)` evaluates it. **It takes no location argument**, so every
job in every council gets the Melbourne curve.

A legacy coarse lookup table is kept in the same file for reference and is explicitly *not* on the hot path.

---

## 5. Why this matters — measured, not asserted

Against a **real CE computations sheet** (1 in 10 year), the plugin's intensities are systematically high:

| Duration | CE's sheet | Plugin | |
|---:|---:|---:|---|
| 5 min | 98.6 | 105.0 | +6.5% |
| 15 min | 60.1 | 64.6 | +7.6% |
| 30 min | 40.9 | 44.4 | +8.6% |

Systematic and growing with duration — the signature of a **different curve**, not rounding. Everything
downstream rests on intensity, so a job the plugin sizes carries roughly **7–9% more storage** than the one CE
issued. Conservative, but not what CE issued.

---

## 6. Why "read the station from the report" cannot work any more

Tim's earlier D-Q3 ruling was *"rainfall station per job, read it from the storm report."* That was right for
the tool CE used then: a **STORM Rating Report names a `Rainfall Station`**, and CE's parser reads it on 100%
of genuine ones.

**CE now uses Blue Factor (Tim, 15 Sep: *"we use blue factor from now onwards"*), and a Blue Factor report
names a municipality, not a rainfall station.** So on every new job the station is simply not in the report.

Nor can it be recovered from CE's own files: the spreadsheet is a paste-target, not a library, and the
per-location text files are lost.

---

## 7. What to build — Tim's ruling

**Tim, 15 September 2026: *"hold the coefficients per job."*** That matches how the office already worked, and
it is the only option that survives §6.

The shape:

- A job carries its **own 7 × 7 coefficient block**, stored on the drawing with the rest of the project record.
- CE **asks once per job** and remembers it. Pasting the block should be as close as possible to what the
  engineer already does with the spreadsheet — a paste of seven rows of seven numbers.
- **Provenance is part of it:** which location the block is for, and where it came from, stored beside it —
  because the whole point of area D's gate is that a figure says where it came from.
- **A job with no block of its own must not silently fall back to Melbourne.** It should say which curve it is
  using. Falling back quietly is precisely the fault this document exists to fix.
- The shipped Melbourne block stays as the **office default for jobs in that zone**, named as such rather than
  as "the" curve.

### Open, and needing an answer from outside CE's own files

- **Where do new coefficient blocks come from now?** The Bureau publishes IFD data per location; the 7 × 7
  fitted block is CE's own derivation from it, and *how that fit was produced is not recorded anywhere CE
  still has.* Either that fitting step has to be reproduced, or CE obtains blocks another way. **This is the
  one genuine unknown**, and it should not be guessed at.
- Until it is settled, a job can still carry a block **pasted by hand**, exactly as the spreadsheet did — which
  is enough to make the plugin correct per job without solving the fitting question first.

---

## 8. What this document did not establish

- How CE originally fitted the seven coefficients to the Bureau's published data.
- Whether the "OSD4W Melbourne zone" block is appropriate for any council other than the one it came from.
- Whether the Bureau's current IFD data would give the same coefficients as whenever this block was made.

All three are recorded as unknowns rather than filled in.
