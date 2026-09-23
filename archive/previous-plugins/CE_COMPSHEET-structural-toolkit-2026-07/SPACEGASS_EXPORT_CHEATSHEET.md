# SPACE GASS benchmark exports — Tim's cheat sheet (T2, approved 17 Jul 2026)

**Goal:** for each benchmark frame below, produce the SPACE GASS *tabular results* (numbers,
not just diagrams) so the CE Frame engine can be validated against them. Budget ~10 minutes
per model once you've done the first one.

**Where to save everything:** `C:\Lisp Files\CE_COMPSHEET\benchmarks\<short-name>\`
(e.g. `benchmarks\BM1-20-110-PF1\`). Anything you save there gets committed to git as
validation evidence.

> Menu names below are from SPACE GASS 12.x and may differ slightly in newer versions.
> If a menu isn't where I say, the thing to aim for is unambiguous: **a printed/exported
> report containing the tables "Node displacements", "Reactions" and "Member forces",
> per load case.** Any path that gets those tables into a PDF or text file is fine.

---

## The models

| ID | File |
|---|---|
| BM1 | `Creative Engineering - Projects\2020\20-110_[address withheld]\Engineering\Comps\PF1 PORTAL FRAME.SG` |
| BM2 | `Creative Engineering - Engineering\Spacegass Templates\Warehouse Portal Frames\35-42m Portal frame - Template.SG` |
| BM3 | `Creative Engineering - Projects\2020\20-108_[address withheld]\Engineering\Comps\R1 PORTAL FRAME.SG` |
| BM4 | `Creative Engineering - Projects\2024\24-134_[address withheld]\Engineering\Comps\spacegass\upper portal.SG` (and `lower portal.SG` if quick) |
| BM5 | A braced bay with tension-only rods — ask a firm engineer to nominate one, or skip and tell me; fallback is planned |

**Work on a COPY.** Copy each `.sg` into its `benchmarks\` folder first and open the copy —
never re-save over a job file.

## Per model — the steps

1. **Open the copy in SPACE GASS.** Note the SPACE GASS version number (title bar or
   Help > About) — write it in a `notes.txt` in the folder.

2. **Capture the analysis settings.** Open the static analysis dialog
   (usually `Analyse` or `Analysis > Static Analysis`). Screenshot the whole dialog
   (Win+Shift+S) — I need to see every option as it was run, especially anything
   mentioning *shear deformation / shear areas* and which *load cases* are ticked.
   Save as `settings-linear.png`.

3. **Run a LINEAR static analysis** (the plain "Static analysis" option — not the
   non-linear one) on all load cases.

4. **Export the results tables.** Look under `Output`, `Reports` or `File > Print` for a
   report writer. Tick (at minimum):
   - Node displacements
   - Reactions
   - Member forces (end forces per member)
   - plus the input echo if offered: node coordinates, member list/sections, loads
   Print/export to PDF or text file → save as `linear-report.pdf` (or `.txt`).
   **Per load case** if the report asks (G, Q, wind cases…) — "all load cases" in one
   report is fine too.

5. **Run the SECOND-ORDER analysis.** In the same analysis dialog choose the non-linear /
   second-order static option (SPACE GASS calls it *Non-linear static analysis*; tick
   axial/P-delta effects if it asks — screenshot the dialog again → `settings-2ndorder.png`).
   Run it on the ULTIMATE combination load cases (the combination cases in the model,
   e.g. the ones named like "1.2G+1.5Q" or numbered combos).

6. **Export the same tables again** → `secondorder-report.pdf`.

7. **Drop the files in the folder and tell me.** For each model I need:
   `the .sg copy · notes.txt (version) · settings-linear.png · linear-report.pdf ·
   settings-2ndorder.png · secondorder-report.pdf`

## If something fights you

- **No license / dongle busy:** stop — tell me which models you got through; partial is fine.
- **Model won't analyse (errors):** screenshot the error, skip the model, tell me — we'll
  swap in the spare (`2020\20-113_[address withheld]\...\RB2 PORTAL FRAME.SG`).
- **Can't find a report writer:** the datasheet grids (Nodes/Members/Reactions views) can
  usually be copied to clipboard → paste into Excel → save as `linear-report.xlsx`. Equally
  usable for me.
- **Not sure an option matters:** screenshot it rather than deciding — screenshots are cheap.

## Why each piece matters (so nothing feels like busywork)

- **Tabular numbers** — the diagram PDFs already in job folders (like BM1's) only annotate
  a few peak values; the tables give every node/member to full precision for the tolerance
  tests (forces within 0.5%, deflections within 1%).
- **Settings screenshots** — if SPACE GASS ran with shear deformation on and we compare
  against our engine with it off, we'd chase a phantom 2–5% "error". The screenshot lets me
  match settings instead of guessing (plan §6, risk R3).
- **The version number** — goes into the validation pack so the firm engineer knows exactly
  what the benchmark was.
