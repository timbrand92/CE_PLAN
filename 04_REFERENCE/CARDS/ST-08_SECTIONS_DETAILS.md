# ST-08 — Structural sections and details

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-158`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-08 — Structural Sections and Standard Details

## Current AutoCAD state

| Tool | Current behaviour | Decision direction |
|---|---|---|
| `SBEAM` | Working steel sections/elevations; useful geometry and tests | **Keep core, improve workflow** |
| `RCBEAM` | Draws eight RC configurations through two dialogs | **Rebuild prompts and preview** |
| `RCRECTCOL` | Working rectangular RC column section | **Keep and link** |
| `RCCIRCCOL` | Working circular RC column section | **Keep and link** |
| Section output | Mostly loose entities with limited tags | **Rebuild as one managed detail** |
| Layers/hatches | Several values are hard-coded | **Use AS-01 catalogue** |
| Standard details | Separate files/palettes, manually inserted | **Bring into governed library** |
| 20 Phase 2/3 commands | Registered placeholders that do nothing | **Hide until properly designed** |

## Decisions AI recommends

### ST8-1 — Scope

ST-08 owns:

- Steel and RC cross-sections/elevations.
- Column sections.
- Reinforcement shown inside those proven sections.
- Approved CE standard-detail insertion.

It does **not** size members, design reinforcement or invent connections.

**Recommendation: Approve.**

---

### ST8-2 — Familiar commands retained

Keep:

- `SBEAM`
- `RCBEAM`
- `RCRECTCOL`
- `RCCIRCCOL`

Also provide one searchable **Sections & Details** browser in CE Manager. Existing commands remain fast shortcuts.

**Recommendation: Approve.**

---

### ST8-3 — Start from the actual drawing element

Where possible, select the member first.

Example:

```text
SBEAM
Select member: B4
CE finds:
• Mark: B4
• Size: 200 PFC
• Calculation: Beam Workbook Rev C
• Status: Checked
```

Manual creation remains possible, but unverified entries are labelled **Manual**, not assumed approved.

**Recommendation: Approve.**

---

### ST8-4 — `SBEAM` AutoCAD workflow

```text
Select member or choose Manual
        ↓
Choose section / elevation view
        ↓
Confirm size, scale and orientation
        ↓
Live preview of all lines, hatch, label and dimensions
        ↓
Pick position
        ↓
Apply as one detail
```

Preserve the proven steel geometry and break-line options.

**Recommendation: Approve.**

---

### ST8-5 — RC workflow becomes visual

Replace `RCBEAM`’s two blind dialogs with one visual preview:

- Beam dimensions.
- Slab position.
- Cover.
- Bars.
- Ligature arrangement.
- Label and dimensions.

The existing eight geometry types stay available, but receive meaningful visual names after comparison against the standards template and corpus.

**Recommendation: Approve.**

---

### ST8-6 — Drawing does not become a calculator

The detail displays values from:

1. Approved linked computation.
2. Checked schedule data.
3. Explicit user-entered design data.

If the computation says 300×500 and the drawing says 300×450, CE displays the conflict. It never silently chooses one.

**Recommendation: Approve.**

---

### ST8-7 — Engineering computation links

Each managed section can link back to:

```text
Drawing member ↔ section detail ↔ schedule row ↔ calculation revision
```

Selecting the section can answer:

- Which member does this represent?
- Where did its size and reinforcement come from?
- Is the computation current?
- Is it Proposed, Checked or Approved?

A changed computation marks the detail **Stale** and prepares a preview—it does not redraw automatically.

**Recommendation: Approve.**

---

### ST8-8 — Correct section graphics

Lock the existing structural conventions:

- Visible outline: continuous line.
- Geometry behind: hidden line.
- Hidden steel web: two lines where required.
- Flange orientation changes as one coordinated section.
- SHS/RHS/CHS show inner walls.
- Timber remains solid unless the approved standard says otherwise.
- RC ligatures use the approved 135° hook/cog graphic.

**Recommendation: Approve.**

---

### ST8-9 — One compound detail

A section becomes one managed assembly:

```text
Outline + hidden lines + hatch + bars + ligatures
+ dimensions + label + source link
```

`MOVE`, `ROTATE` and `ERASE` affect the complete detail. No stranded hatch, dimensions or labels.

The native AutoCAD linework remains visible and plot-compatible, but CE manages its relationships.

**Recommendation: Approve.**

---

### ST8-10 — COPY and EDIT behaviour

- **MOVE:** carries the entire detail.
- **EDIT:** changes parameters through a preview.
- **ERASE:** deletes the detail only—not its plan member or computation.
- **COPY:** creates a fresh detail identity and asks:

```text
Same member — another linked view
New member — select its source
Independent detail — remove engineering link
```

A copy never silently shares the wrong member identity.

**Recommendation: Approve.**

---

### ST8-11 — Clean cancel and Undo

Before Apply, cancelling leaves nothing behind.

After Apply:

- One command.
- One Undo.
- No hidden records.
- No forced `QSAVE`.
- Previous layer, snaps, UCS and view restored.

**Recommendation: Approve.**

---

### ST8-12 — AS-01 controls appearance

All approved:

- Layers.
- Linetypes.
- Hatches.
- Text/dimension styles.
- Section marks.
- Detail titles.

come from the AS-01 standards catalogue.

The master DWG/DXF remains read-only. A missing approved asset blocks placement—CE does not draw an approximation.

**Recommendation: Approve.**

---

### ST8-13 — Standard-details workflow

```text
Open Sections & Details
        ↓
Search: “steel beam connection”
        ↓
See Approved / Candidate status and actual preview
        ↓
Select approved version
        ↓
Place fixed project copy
        ↓
Complete highlighted project-specific fields
```

The drawing records the detail source and version. Later master changes never silently alter an issued project.

**Recommendation: Approve.**

---

### ST8-14 — Corpus assistance later

The corpus may later suggest:

- Which approved detail normally accompanies this situation.
- Common section orientation.
- Typical annotation position.
- Whether another sheet normally carries the detail.

It may **not** determine member size, reinforcement or connection engineering from frequency.

Example:

> “Projects with this beam/wall arrangement commonly use approved Detail S12. Preview?”

That remains a suggestion until explicitly selected.

**Recommendation: Approve.**

---

### ST8-15 — Hide the 20 fake commands and minimise testing

Hide the currently empty commands—including `PORTAL`, `TRUSS`, `PURLINS`, `BOLTS`, `GUSSETS`, `LIGS`, `COLTIES`, `WALLREO` and `BSSLAB`.

Each returns only after its own evidence-backed Tool card.

Automated checks will cover section families, rotations, UCS, scales, COPY/MOVE/ERASE, calculation links and reopen persistence.

Timothy’s final AutoCAD check should be limited to approximately:

1. One steel cross-section.
2. One steel elevation.
3. One RC beam.
4. One rectangular or circular column.
5. One approved standard detail.
6. One calculation-change/stale preview.

Target: **under 12 minutes**, with no cursor or drafting lag.

**Recommendation: Approve.**

## Proposed outcome

ST-08 keeps the proven section-drawing engines, but makes each output a traceable, editable detail connected to its real member and computation. Standard details come from approved CE assets, and unfinished placeholder commands disappear until genuinely designed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-159

✅ Approve ST-08 all — and it closes an early loop
🔚 ST8-15 — the 20 fake commands, finally handled
PORTAL, TRUSS, PURLINS, BOLTS, GUSSETS, LIGS, COLTIES, WALLREO, BSSLAB — these were one of the very first things the audit surfaced (§6.3, Round 1): commands staff can type that just print "not yet implemented." Hiding them until each earns its own evidence-backed Tool card is that Round-1 ruling landing in a card. Satisfying to watch a founding finding close cleanly — they're not deleted (the designs may return), just removed from reach until they're real.

📐 ST8-8 — locks the section conventions and resolves a rulebook contradiction
The SHS/RHS/CHS inner-wall rule flip-flopped in the mining: 18 June said "outer extent solid only," 17 July reversed it to "hollow sections also draw the two inner-wall lines." ST8-8 adopts the later ruling ("SHS/RHS/CHS show inner walls") — good, that's the resolution, not a re-opening. Alongside it: the 135° ligature hook/cog, the continuous-vs-hidden linetypes, the hidden web as two lines, and the coordinated flange orientation (flip all flanges as one, never one solid + one dashed). These are the locked structural drafting standards, now pinned to a card instead of scattered across the spec history.

👁️ ST8-5 — RCBEAM's two blind dialogs become one visual preview
Configuring an RC beam (dimensions, cover, bars, ligature) through two dialogs without seeing the result is exactly how you get a wrong section you don't notice until it's placed. One live visual preview fixes that, and naming the eight geometry types meaningfully (via the template + corpus) makes them selectable instead of cryptic.

🔒 ST8-6 + ST8-14 hold the firewall
The detail is a view, not a calculator: computation says 300×500, drawing says 300×450 → both shown as a conflict, never silently picked.
The corpus may suggest which detail, common orientation, typical annotation position — but never member size, reinforcement, or connection engineering from frequency. Your example ("projects with this arrangement commonly use Detail S12 — preview?") is a drafting suggestion, correctly bounded to a preview-until-selected.
🎯 ST8-10 — the COPY disambiguation is a good touch
A copied section could legitimately be another view of the same member, a new member, or an independent detail — three different meanings. So CE asks rather than guessing, because guessing the member identity wrong is a real error. "A copy never silently shares the wrong member identity" — exactly the CV20/ST1-14 copy-safety, made explicit where the intent is genuinely ambiguous.

✅ Three quick affirms
ST8-9 — the detail is native, plottable linework and CE manages its relationships, so it stays visible/editable/plot-compatible while nothing gets stranded on MOVE/ERASE. The right balance (not a proprietary object that won't plot).
ST8-3 — start from the member; the section auto-populates from its linked calc (B4 → 200 PFC → Beam Workbook Rev C → Checked). Manual entries are labelled Manual, not assumed Approved.
ST8-12 — a missing approved asset blocks placement; CE never draws an approximation (the screw-pile lesson, applied to sections).
🔒 Approve — nothing starts
Proven section engines kept, each output now a traceable editable detail linked to its real member and calc, standard details from the governed catalogue as fixed project copies, and the placeholder commands gone until genuinely designed. That's 7 of 9 structural cards locked — ready for the next.
