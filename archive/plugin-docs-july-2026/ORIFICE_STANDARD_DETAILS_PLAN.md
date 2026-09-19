# Orifice Standard Details — Auto-Drafter Plan

**Date:** 2026-06-09
**Status:** PLAN — approved approach. Supersedes from-scratch OrificeDetailGenerator for production output.
**Related files:**
- Source DWG: `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Standard Details\Civil\CE Civil ORIFICE PITS Details.dwg`
- From-scratch generator (keep as fallback/preview): `CE_CVL_SUITE/Services/OrificeDetailGenerator.cs`
- ACadSharp reader pattern: `CE_CVL_SUITE/Services/ExternalDwgReaderService.cs`

---

## 1. What the DWG file contains (the catalogue)

The source DWG has **all geometry in model space** (no paper-space layouts to worry about). There are
roughly 12,500 entities. The key structures for the auto-drafter are:

| Template / variant | Description | When to use |
|--------------------|-------------|-------------|
| `*U420` / `A$Ca61e3e22` | The live dynamic-block template. 57 entities, 8 `AttributeDefinition` placeholders (`CL xx.xx`, `TWL xx.xx`, `IL xx.xx`, `xx.xx` ×5), orifice dia hardcoded as `50 DIA. ORIFICE` in MText. This is the **primary target**. | Every job — populate and insert |
| `ORIFICE PIT` (named, 93 entities) | Older generic template, P--- label, 75 DIA orifice, 360 HIGH baffle, 300 DIA outlet. Steel-plate variant. | Fallback if `*U420` is unavailable |
| `ORIFICE PIT P1` (named, 91 entities) | Steel-plate orifice, 1200 wide chamber, 32 DIA canonical, many completed-job copies (A$Cxxxxxxxx) in model space. | Narrow-chamber steel-plate jobs |
| Completed-job blocks (`A$Cxxxxxxxx`, ~30 blocks) | One block per past job with real RL values. Useful as **examples** to learn from, not as templates. | Reference only |
| Bayside City Council variant | Class B dual-lid cover, Bayside Council compliance text. | Bayside projects |
| Boroondara SD999 variant | Single-plate, min 6 mm stainless, maximesh screen, chemset anchors, ref SD999 Rev J. | Boroondara projects |
| Glen Eira variant | Class A cover, Glen Eira Council compliance text. | Glen Eira projects |
| Knox SD S118.1 variant | Class B cover, Knox Council ref S118.1, 100 DIA pipes. | Knox projects |
| Manningham variant | Baffle-wall, Manningham Council requirements text. | Manningham projects |
| Mornington Peninsula MP244 | Class B cover, ref MPS standard drawing MP244, detention-pipe inlet variant. | MPS projects |
| Generic council-compliance (SD 128 / SD 1001) | Large-chamber 1300 wide, 525 DIA inlet, step irons per SD 1001. Class C covers. | Large-development generic |

---

## 2. The variable fields — what changes per job

These are the only fields that differ between jobs. Everything else (linework, hatching, dimensions,
title block) is fixed office standard.

| Field | Where it lives in the DWG | Engine that provides the value | Format in completed copies |
|-------|--------------------------|-------------------------------|---------------------------|
| **CL** — cover level | `AttributeDefinition "CL xx.xx"` in `*U420`; plain `TextEntity` in completed copies | Network leveller (design CL from FFL or landscape) | `CL 33.65` |
| **TWL** — top water level | `AttributeDefinition "TWL xx.xx"` | OSD detention solver (TWL = design storage RL) | `TWL 33.42` |
| **IL** — outlet invert | `AttributeDefinition "IL xx.xx"` (primary); additional plain-text ILs for each pipe | Network leveller (outlet IL from grade + pipe dia) | `IL 32.75` |
| **Further RLs** (×3–4) | Additional `AttributeDefinition "xx.xx"` placeholders | Network leveller (base slab, pipe crowns, inlet ILs) | `7.13`, `16.66`, etc. |
| **Orifice diameter** | MText inside the baffle note — `50 DIA. ORIFICE` in template | `OrificeSizer.Size(psd, head, co, ladder)` → `.DiameterMm` | `56 DIA. ORIFICE` |
| **Baffle height** | Same MText as orifice dia — `(YYY HIGH)` | Computed: `TWL - outlet IL`, rounded to nearest 10 mm | `(545 HIGH)`, `(720 HIGH)` |
| **Pit label** (Pxx) | `TextEntity "ORIFICE PIT P--- DETAIL"` | Pit label from the CE network (P1, P2, …) | `ORIFICE PIT P1 DETAIL` |
| **Inlet pipe diameter** | Leader callout `TextEntity "150 DIA. INLET PIPE"` | Pipe sizing engine (upstream pipe DN) | `375 DIA. INLET PIPE` |
| **Outlet pipe diameter** | Leader callout `TextEntity "100 DIA. OUTLET PIPE"` | Pipe sizing engine (outlet pipe DN) | `150 DIA. OUTLET PIPE` |
| **Cover type** | `TextEntity "COVER (      ) INSTALLED …"` — blank in brackets | Cover schedule (Class A/B/C from council profile + location) | `COVER (CLASS B) INSTALLED …` |
| **Council compliance note** | MText block near the base — varies by variant (see table above) | Council code from project settings | Replaced wholesale per council |

---

## 3. The approach — populate the office standard, not redraw from scratch

### Why "populate" beats "redraw"

The current `OrificeDetailGenerator.cs` draws from scratch: it emits Lines, LwPolylines, DimensionLinear
entities computed to match the office look. The problem is every pixel of linework must be maintained
separately from the master standard detail. When the office updates its standard (new cover class,
different hatch, updated council note), the generator drifts out of sync.

The new approach: **copy the master DWG, open the copy, find the `*U420` block, change only the
variable fields listed above, and save.** The linework is the office standard — unchanged. The result
is indistinguishable from a detail Tim draws by hand.

### Step-by-step production flow

```
Job inputs (from CE_CVL_SUITE ProjectData + auto-design results)
    │
    ├─ Council code          ──────────────────────────────┐
    ├─ Pit label (Pxx)       ──────────────────────────────┤
    ├─ OrificeSizer result   → orifice dia (mm)            │
    ├─ Network leveller      → TWL, CL, outlet IL, ILs     ├──► OrificeStandardDetailDrafter
    ├─ Pipe sizing engine    → inlet DN, outlet DN          │        (new service)
    └─ Cover schedule        → cover class                  │
                                                            │
FILE COPY of master DWG ─────────────────────────────────►─┘
    │  (ACadSharp read-only on original,
    │   all edits on temp copy)
    ▼
Locate *U420 block reference in model space
    │
    ├─ Overwrite AttributeDefinition values (CL, TWL, IL, xx.xx ×N)
    ├─ Text-replace in MText: "50 DIA. ORIFICE" → "56 DIA. ORIFICE"
    ├─ Text-replace in MText: "(50 HIGH)" → "(545 HIGH)"
    ├─ Text-replace pit label TextEntity: "P---" → "P1"
    ├─ Text-replace inlet/outlet callouts
    ├─ Text-replace cover blank
    └─ Swap council compliance MText block (if council != generic)
    │
    ▼
Save populated DWG/DXF to job folder
Insert into the CE drawing sheet (or export as standalone detail sheet)
```

### Where each value comes from

| Value needed | Source today | Notes |
|---|---|---|
| Orifice diameter (mm) | `OrificeSizer.Size(psd, head, co)` → `OrificeSizingResult.DiameterMm` | Already exists, tested |
| TWL | `DetentionDesignViewModel` → `DetentionResult.Twl` | Already exists |
| Outlet IL | `NetworkLevellerService` (Phase 2 auto-design) | Planned Phase 2 |
| CL | Finished surface RL above pit (FFL or landscape) | From survey TIN + FFL input |
| Baffle height | `TWL - outlet_IL`, rounded to 10 mm | Pure math |
| Inlet / outlet DN | `PipeData.DiameterMm` from upstream/downstream pipe | Already in CE model |
| Pit label | `PitData.Label` | Already in CE model |
| Cover class | `CouncilProfileService.GetCoverClass(council, location)` | Planned Phase 3 |
| Council compliance note | `CouncilProfileService.GetOrificeNote(council)` | Planned Phase 3 |

---

## 4. What the new service does (spec for the coder)

**New file:** `CE_CVL_SUITE/Services/OrificeStandardDetailDrafter.cs`

```csharp
public static class OrificeStandardDetailDrafter
{
    // sourceDwgPath  = read-only original master DWG path
    // destPath       = where to write the populated copy
    // inputs         = all the job values (orifice dia, RLs, labels, etc.)
    // Returns: true on success, or an error message on failure
    public static (bool Ok, string? Error) PopulateDetail(
        string sourceDwgPath,
        string destPath,
        OrificeDetailInputs inputs);
}
```

**Inside `PopulateDetail`:**

1. `File.Copy(sourceDwgPath, destPath, overwrite: true)` — never touches original.
2. Open `destPath` with `CadDocument.Load(destPath)` (ACadSharp read/write).
3. Find the `*U420` block definition in `doc.BlockRecords`.
4. For each `AttributeDefinition` entity in that block: match by `Tag` string (e.g. `"CL XX.XX"`) and replace `DefaultValue`.
5. For `MText` entities in the block: regex-replace `\d+ DIA\. ORIFICE` → `{inputs.OrificeDiameterMm} DIA. ORIFICE`, and `\(\d+ HIGH\)` → `({baffleHeightMm} HIGH)`.
6. Locate the `Insert` entity in model space that references this block; update any attached `AttributeEntity` values to match (these are the instance-level overrides AutoCAD reads, not the definition defaults).
7. Council note swap: find the MText entity by text content match (starts with `"TO "` or contains `"COUNCIL"` or `"SD999"`) and replace its `Value` with the council-specific string from `CouncilProfileService`.
8. Save: `new DwgWriter(destPath, doc).Write()`.

**Fallback:** If `*U420` is not found (e.g. the master DWG has been updated and the block renamed), log the error and fall back to `OrificeDetailGenerator.cs` (the from-scratch path). This guarantees the auto-drafter never silently fails — it always produces output.

---

## 5. From-scratch generator — kept as fallback / preview

`OrificeDetailGenerator.cs` is **not deleted**. It serves two purposes:

1. **Live preview** inside AutoCAD while a job is being designed — fast, no file I/O, renders
   directly into model space so Tim can see the detail update as he changes numbers.
2. **Emergency fallback** if the master DWG file is missing, corrupt, or the `*U420` block
   cannot be found.

The two approaches produce visually identical output; the standard-detail approach produces
output that is literally the office master (guaranteed to pass council submission).

---

## 6. ACadSharp write capability — known constraints

ACadSharp 3.4.29 reads all tested CE DWGs reliably. Write capability is more limited:

| Operation | ACadSharp support | Risk level |
|-----------|------------------|-----------|
| Change `AttributeDefinition.DefaultValue` (text) | Supported | Low |
| Change `AttributeEntity.Value` on an Insert | Supported | Low |
| Change `MText.Value` (text substitution) | Supported | Low |
| Change `TextEntity.Value` | Supported | Low |
| Add / remove entities from a block | Supported | Medium — test carefully |
| Round-trip complex DWG with dynamic blocks, hatches, splines | Partially supported — parse warnings are non-fatal, geometry is preserved | Medium |
| Save as DXF instead of DWG | Fully supported — safe fallback | Low |

**Recommendation:** target DXF output first (`CadDocument.SaveAs(destPath + ".dxf", ACadVersion.AC1032)`)
— it is unambiguously reliable. DWG round-trip works but adds risk with AutoCAD's proprietary
extensions (the 236 non-fatal parse warnings in the source file). AutoCAD opens DXF files without
issue for final submission. Upgrade to DWG output after Tim validates the DXF round-trip.

---

## 7. Build order

| Phase | What gets built | Dependency |
|-------|----------------|-----------|
| Now (available) | `OrificeStandardDetailDrafter.PopulateDetail()` — text-field population only, DXF output | `OrificeSizer` + `OrificeDetailInputs` already exist |
| Phase 2 (auto-design) | Wire TWL and outlet IL from `NetworkLevellerService` | Phase 2 auto-design |
| Phase 3 (council profiles) | Council compliance note swap via `CouncilProfileService` | Phase 3 council profiles |
| Phase 4 (full pipeline) | `CDAUTODRAFT` command — one command, full output | Phase 2 + 3 complete |

---

## 8. The broader opportunity — other standard-detail DWGs

The same "populate the office standard" approach unlocks the rest of the standard-detail library.
Each DWG in the same folder represents weeks of past effort that can be reused automatically:

| File | What it unlocks | Variable fields |
|------|----------------|----------------|
| `CE Civil LONG SECTION EXAMPLES.dwg` | Longitudinal section profile sheet | Pipe invert levels, pipe sizes, pit depths, chainage labels |
| `CE Civil SOAKAGE PITS - INFILTRATION Details.dwg` | Soakage pit details for infiltration OSD | Pit dimensions, base RL, infiltration area note |
| `CE Civil WATER TANKS - PUMP STATIONS Details.dwg` | Above-ground / underground tank details, pump station | Tank volume, pump model, inflow / outflow pipe sizes |
| `CE Civil RAINGARDENS - SWALES - BUFFER STRIPS Details.dwg` | Raingarden / swale construction details | Basin dimensions, media depth, overflow RL |
| `CE Civil KINGSTON COUNCIL NOTES.dwg` | Kingston-specific council notes | Fixed text — insert as-is, no population needed |

The orifice pit drafter is the **proof of concept for the whole library**. Once the pattern is
established (copy → open with ACadSharp → find variable entities → overwrite text → save), every
other standard detail follows the same code path with different field mappings.

Long-section drafting is the highest-value next target: a complete longitudinal section is currently
a 1–2 hour manual drafting task per job. Auto-populating the long-section template from the
network leveller output would eliminate that entirely.

---

## 9. Summary

- All orifice pit detail geometry lives in **model space** of the master DWG. No paper-space
  enumeration needed.
- The `*U420` / `A$Ca61e3e22` block is the production template. It has 8 `AttributeDefinition`
  entities (the editable fields) plus MText with the orifice dia and baffle height embedded.
- Only **10 text fields** change per job. All linework, hatching, dimensions, and boilerplate notes
  are fixed.
- The new `OrificeStandardDetailDrafter` service copies the master, opens the copy with ACadSharp,
  edits those 10 fields, and saves as DXF (upgrading to DWG after validation).
- The from-scratch `OrificeDetailGenerator` is retained as a fast preview renderer and emergency
  fallback.
- Council variants are handled by swapping one MText block — no separate DWG per council needed.
- The same approach applies to every other standard detail in the library, with long-section drafting
  as the highest-value next target.
