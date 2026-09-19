# IDEAS BACKLOG — refined & routed (TIMS IDEAS)

TIMS IDEAS turns raw inbox lines into clear, grouped concepts and routes each to the owning worker
when it's ready. Statuses: 🌱 refined · 🎯 ready · 🚚 routed (now in a worker's lane) · ✅ done.

---

## Theme — CDEDIT / invert editing UX  *(lane: DRAINAGE)*

### 🚚 Editable downstream inverts + per-pit drop control
- **What Tim wants:** in an existing drawing, changing a pipe's invert already pops a WPF that
  previews the recalculated inverts down the run. Make that preview **editable** — type over any
  downstream invert directly in the pop-up — AND add a single **"pit drop"** box: one number that
  sets the fall between the inlet IL and the outlet IL at each pit along the run, applied down the
  chain automatically.
- **Why it helps:** matches how you actually design — set a standard drop across a whole run in one
  number, override the odd pit, without leaving the dialog. Faster + more control + fewer clicks.
- **Lane:** DRAINAGE — `CDEDIT` / PipeEdit invert-preview WPF + the downstream propagation service.
- **✅ Answers from Tim (2026-07-06) — no longer held:**
  1. "Pit drop" box **defaults to 20mm**, override as needed.
  2. Drop applies at **every pit** down the run.
  3. A **per-pit typed value always wins** over the global drop; global fills only untouched pits.
  4. Downstream-invert preview grid is **fully editable**.
- **Priority:** medium–high (flagship, everyday command).
- **Status:** 🚚 routed + ✅ spec locked → DRAINAGE builds it (`docs/CHAT_PROMPTS/2-DRAINAGE.md`). Next Drainage run picks it up.

---

## Theme — Consultant import (CDIMPORTXCIVIL)  *(lane: IMPORT)*

### 🚚 Long-section generator — auto-draw pipe longitudinal sections
- **What Tim wants:** from an imported/edited pipe network + inverts, auto-draw the longitudinal
  sections (long-sections) for each run, using `CE Civil LONG SECTION EXAMPLES.dxf` as the template
  (H:V scale ratios, pit references, IL/GL bands).
- **Why it helps:** long-sections are drawn by hand today — a big time-saver, and pairs naturally
  with the Xcivil import (the import already holds the network + levels needed to draw them).
- **Lane:** IMPORT — new generator that consumes the imported network model.
- **Note:** sizeable new feature (a new draw command), not a small tweak — flagged to Tim.
- **Priority:** medium–high (recurring manual drafting task).
- **Status:** 🚚 routed → IMPORT (`docs/CHAT_PROMPTS/1-IMPORT.md`).

### 🚚 Council-aware standard-notes library
- **What Tim wants:** today only a "KINGSTON COUNCIL NOTES" set exists. Add a notes set **per
  council** so the import / notes auto-drop picks the right one for the job (this job = **Cardinia
  Shire**).
- **Why it helps:** every council has its own required drainage notes; auto-dropping the correct
  set removes a manual swap-and-check step per job.
- **Lane:** IMPORT (notes auto-drop) with DRAINAGE input on which command drops them.
- **Open item for the worker to park (needs Tim):** the actual **Cardinia Shire note text** — the
  worker can build the per-council selection mechanism, but Tim/council must supply the note content.
- **Priority:** medium (per-job, but the mechanism is reusable for every future council).
- **Status:** 🚚 routed → IMPORT. Mechanism buildable now; note text parked for Tim.

### 🚚 CDSLAB from Mike's imported pavement/slab outlines
- **What Tim wants:** the Xcivil import should turn Mike's pavement/slab outlines (XHatch layers
  `-PAVE OUTLINE` / `-PAVE CONCRT LIGHT DUTY`) into **CE slab boundaries**, so `CDSLAB` (fall
  design), `CDJOINT` (SC grid) and `CDCJ` run on his imported extents instead of Tim retracing them
  — likely via the existing `CDSLABIMPORT` hook.
- **Why it helps:** removes manual retracing of pavement extents before slab/joint design; feeds the
  P6 pavement workflow straight off the consultant drawing.
- **Lane:** IMPORT (extract outlines → CE slab boundaries) → consumed by DRAINAGE `CDSLAB`/`CDJOINT`/`CDCJ`.
- **Priority:** medium–high (unblocks pavement design directly from the import).
- **Status:** 🚚 routed → IMPORT (via `CDSLABIMPORT`). Routes onward to P6 pavement.

---

## Theme — Standard details library  *(lane: IMPORT / PLATFORM)*

### 🌱 Standardise the CE civil standard-details library
- **What Tim wants:** the `…/Standard Details/Civil/*.dxf` library is anonymous-block heavy (`A$C…`),
  has inconsistent layers, and is "all over the place". Convert it to **clean named blocks on
  consistent CE layers** so the import can pull details reliably.
- **Why it helps:** reliable, named, consistently-layered details are a prerequisite for auto-dropping
  details during import — anonymous blocks and stray layers can't be matched or placed predictably.
- **Lane:** IMPORT (why it's wanted) / PLATFORM (asset-library curation, independent of command code).
- **Held — needs Tim before routing (scoping):**
  1. **In-place vs copies?** Default is clean copies (never mutate the originals) — confirm that's OK.
  2. **Priority set:** which detail categories should be standardised first (the ones this job / the
     import needs most), rather than the whole library at once?
- **Priority:** medium (foundational, but large — worth scoping before a worker starts).
- **Status:** 🌱 refined, held for Tim's scoping answers above.

---

## Backlog — awaiting refinement
_(none — new inbox items land here after the next TIMS IDEAS run)_
