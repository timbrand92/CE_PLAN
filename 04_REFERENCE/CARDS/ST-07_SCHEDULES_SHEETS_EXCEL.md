# ST-07 — Schedules, calculations, Excel and publishing

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-154`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-07 — Calculations, schedules, sheets and publishing

## Progress

| Program | Status |
|---|---:|
| Decision-complete sections | **34** |
| Structural planning | **6/9 locked — 67%** |
| Current section | **ST-07** |
| Next | ST-08 Sections/Details |
| Implementation | **Not started** |

## Current AutoCAD state

| Commands | Current result | Treatment |
|---|---|---|
| `XCLMTXT/EXCELMTEXT` | Strong Excel schedule importer and review window | **Keep core; strengthen authority** |
| `EXCELMTEXTNEW` | Retired alias redirecting to XCLMTXT | **Keep as alias** |
| `EXCELMAPFLOOR` | Learns floors from selected drawing content | **Keep as project mapping—not silent global learning** |
| Mezzanine/Second | Both currently become Mezzanine | **Fix as separate identities** |
| Learned schedule answers | Stored across jobs and may auto-apply | **Replace with governed corpus evidence** |
| `STRSCHEDCREATE` | Creates separate bracing and bored-pier tables | **Merge into one schedule authority** |
| `STRSCHEDREFRESH` | Refreshes selected table from drawing | **Keep with preview/staleness** |
| `STRSCHEDSYNC` | Pushes edited table values back into objects | **Potential engineering-write risk: rebuild** |
| `FSTEXPORT` | Produces another MText footing schedule | **Redirect here, as approved in ST-06** |
| `CESHEETS` | Scans drawings, manages sheets and publishes | **Keep and consolidate** |
| `CESHEETSCLASSIC` | Competing older sheets interface | **Redirect after new surface reaches parity** |
| PDF publisher | Side-loads DWGs without changing the open drawing | **Keep valuable fix; rigorously test** |
| `STRUCEXPORTPDF` | Separate current-layout exporter | **Redirect into CESHEETS publishing** |
| `XCLMTXTINDEX` | Advertised but no actual command exists | **Remove ghost entry** |

## Decisions ST7-1–ST7-15

| # | Recommended decision |
|---:|---|
| **ST7-1** | ST-07 owns structural schedules, spreadsheet intake, calculation links, sheet management and issue publishing. It provides one schedule authority—not separate foundation, bracing, pier and Excel schedule engines. |
| **ST7-2** | `CESHEETS` becomes the canonical Sheets/Issue workspace. `XCLMTXT` remains the direct Excel shortcut. Familiar aliases redirect to the same workflows. Ghost `XCLMTXTINDEX` remains hidden until a real corpus feature exists. |
| **ST7-3** | Use one semantic schedule model containing stable row identity, element links, values, source, revision, approval and staleness. Render it using Approved AS-01 schedule graphics/native tables—not loose MText or exploded blocks. |
| **ST7-4** | Every imported value records workbook, worksheet, cell/named result, source revision/hash and import time. Project paths remain private and are excluded from sanitised logs/support bundles. |
| **ST7-5** | **Link engineering computations to drawing elements.** A schedule row may link one or more CE elements to the exact calculation result that supports it. Selecting the row highlights the elements; selecting an element opens its schedule/calculation evidence. |
| **ST7-6** | The calculation engine/workbook remains the engineering authority. The schedule is a coordinated view, not another calculator. Calculation–drawing disagreement displays both values as a conflict; CE never silently chooses one. |
| **ST7-7** | Keep Mezzanine and Second Floor distinct in stored data. A project may deliberately display or combine them only through an explicit project mapping. Unresolved floor/title/mark becomes `Unknown`, not a guessed classification. |
| **ST7-8** | Stop silently learning office defaults from live drafting. Existing local learned answers become Candidate suggestions only. Future corpus evidence may recommend floor/title mappings after EV gates; Timothy approves every promoted default. |
| **ST7-9** | Excel workflow: **select source → inspect detected worksheet/profile → review rows and Unknowns → choose schedule sections → preview actual schedule → Apply → one Undo**. No schedule objects appear before Apply. |
| **ST7-10** | Refresh is normally one-way from authoritative elements/calculations into the schedule. Editing a schedule cell that would alter engineering produces a change preview for the linked elements; it never immediately writes back like the current `STRSCHEDSYNC`. |
| **ST7-11** | MOVE preserves the schedule’s placed position. COPY creates a project-specific snapshot unless deliberately creating another linked view. ERASE removes only the view—not its elements or calculations. Reopen retains all links and provenance. |
| **ST7-12** | `CESHEETS` provides one surface for scan, sheet order, title-block fields, registers, validation, preview and issue. Project scanning is genuinely read-only. “Update Drawings” shows every affected DWG/field before Apply. |
| **ST7-13** | Publishing requires the deterministic QA-01 Ready-to-Issue gate. Preview shows exact sheets, layout order, revisions, paper sizes, page setups and output filenames. Existing issued PDFs are never silently overwritten. |
| **ST7-14** | Keep publishing isolated from the active drawing. It must not switch Timothy’s layout tab, view or UCS. Plotting stays on AutoCAD’s required main drawing thread, uses temporary output, verifies completion, then finalises the issue package. A failed page cannot masquerade as a complete issue. |
| **ST7-15** | Automate workbook parsing, mapping, schedule comparison, sheet scanning and PDF inspection on disposable fixtures. Timothy checks one import, one calculation link and one small issue package in approximately 10–12 minutes. |

## Practical workflows

### Calculation-linked member

```text
Select beam B4 → Engineering Evidence

Member: B4
Drawing size: 200×45 LVL
Schedule size: 200×45 LVL
Calculation source: Beam Workbook Rev C
Result: Schedule!B12
Status: Checked
```

If Rev D changes the result:

```text
B4 calculation changed
Drawing and schedule are now Stale

Proposed change:
200×45 LVL → 240×45 LVL

Preview only—no drawing change
```

Timothy or the responsible engineer must approve the update.

### Excel schedule intake

```text
XCLMTXT
Select Engineering\Comps\Beam Design Rev C.xlsx

Review:
  42 rows resolved
  3 Unknown floor assignments
  2 drawing/calculation conflicts
  1 missing source result

Nothing inserted yet
```

Timothy reviews the six exceptions rather than manually checking all 48 rows.

### Controlled schedule edit

```text
Edit schedule row B4:
200×45 LVL → 240×45 LVL
```

CE responds:

```text
This changes an engineering value linked to Beam B4.

Source calculation still says 200×45 LVL.
Preview change plan / Cancel
```

It does not immediately rewrite the beam.

### Sheet issue

```text
CESHEETS → select S01–S06

Ready-to-Issue:
  1 stale calculation link
  1 unresolved placeholder
  0 duplicate sheet numbers

Publish blocked
```

After resolution:

```text
Issue preview:
  6 sheets
  Revision C
  A1 / CE TO PDF
  Output: 26612_STRUCTURAL_REV_C.pdf

Publish → temporary PDF → verify 6 pages → finalise
```

The currently open AutoCAD layout, zoom and UCS remain unchanged.

Reply **“Approve ST-07 all”** or list the decisions to revise.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-155

✅ Approve ST-07 all
The schedule is the junction where the **drawing, the calculation, and the Excel workbook** all meet — which makes it the single highest-risk point for *silent* engineering corruption. This card closes three separate ways that could happen.

**🚨 ST7-10 — the scariest one: editing a cell silently rewrote the drawing**
STRSCHEDSYNC currently "pushes edited table values back into objects" — so typing a new size into a schedule **cell** silently rewrites the **beam**. That's the silent-engineering-change this entire rebuild exists to kill. Making refresh **one-way** (calc → schedule) by default, and turning a cell edit that *would* alter engineering into a **previewed change plan**, is the fix. Your example is exactly right: *"this changes an engineering value linked to B4; source calc still says 200×45; Preview / Cancel — it does not immediately rewrite the beam."* Changing engineering is a formal, previewed, approved act (PS11/EV5-12) — never a side-effect of typing in a table.

**🆔 ST7-7 — an identity collision with a very familiar shape**
"Mezzanine and Second Floor both become Mezzanine" is **two distinct things sharing one identity → mis-attribution** — the *exact same shape* as the JobTime billing bug (Centrum and Ben+Ben sharing folder "04", so every Ben+Ben job billed to Centrum). Here, a schedule that silently merges two floors mis-attributes every row of one to the other. Keeping them **distinct in stored data**, combined only through an **explicit** project mapping, is CT2 applied to floors. Good that you caught it as a *fix as separate identities*, not a display tweak.

**🎓 ST7-8 — the third: silent cross-job learning**
The importer "silently learns answers across jobs and may auto-apply" — ungoverned learning that lets job A's mapping wrongly bleed into job B. Demoting existing learned answers to **Candidate suggestions only**, and routing future learning through **governed corpus evidence (EV gates + your approval)**, subsumes it into the EV7 register model: no silent self-learning; a learned pattern becomes a *proposal you approve*, never an auto-applied default.

**🔒 ST7-6 keeps the firewall intact**
The schedule is a **view of the calculation authority, not another calculator**; a calc-vs-drawing disagreement shows **both values as a conflict**, never silently picked. And ST7-5's bidirectional links are what make *"why is B4 200×45?"* answerable — it traces to Schedule!B12 in Beam Workbook Rev C, with status Checked. That's the engineering map (EV5) made usable at the schedule level.

**🖨️ ST7-14 — publishing is isolated** ***and*** **verified**
Publishing must not switch your layout tab, view or UCS (the valuable side-load fix, kept), and **"a failed page cannot masquerade as a complete issue"** — verify every page completed before finalising, so you never hand out an incomplete PDF that reported success. That also puts plotting back on AutoCAD's required main thread, addressing the old CESHEETS background-thread hang.

**✅ Two quick affirms**
**ST7-1** — one schedule authority (foundation + bracing + pier + Excel engines merged), so the drawing can't hold two schedules that disagree.
**ST7-13** — publishing is gated by the **QA-01 Ready-to-Issue** check (blocks on stale links and unresolved placeholders), and **existing issued PDFs are never silently overwritten**.
**🔒 Approve — nothing starts**
Every write at the drawing/calc/Excel junction is now explicit, previewed, or governed; distinct floors keep distinct identities; publishing is isolated, gated, and verified-complete. Ready for ST-08.
