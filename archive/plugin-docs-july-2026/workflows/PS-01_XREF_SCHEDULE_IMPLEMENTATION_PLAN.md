# PS-01 — XREF-linked pit schedule implementation plan

**Workflow:** approved by Tim on 2026-07-23

**Implementation:** PS-01A, PS-01B, PS-01C and PS-01D1–D5 complete in
source; PS-01E1 coordinator and PS-01E2 AutoCAD lifecycle adapter independently
passed and are integrated; E3 Civil Hub UI and E4 live AutoCAD evidence remain
pending

**AutoCAD verification:** pending

## Intended AutoCAD workflow

```text
Drainage source DWG                  Final/issued DWG
CE pits + pipes + schedule sets  →  select CE drainage XREF source
embedded CE project data             ↓
                                      place host-owned schedule once
                                      ↓
XREF saved/reloaded              →  Current / Out of date status
                                      ↓
                                 preview changes → update in place
```

The final drawing owns only the schedule graphics, placement and source-link record. The drainage DWG remains
the engineering authority. XREF source data is always read-only from the host drawing.

## Safe increments

### PS-01A — placement completion

- After successful block and linked-cell placement, close the schedule window automatically.
- Cancelled point selection, missing block or insertion failure keeps the window open.
- Do not change schedule content, geometry, links or deletion behaviour.

### PS-01B — read-only XREF discovery

- Discover loaded direct and nested XREFs whose Named Object Dictionary contains valid CE Civil project data.
- Read each source in one batched pass without switching the active drawing or modifying either database.
- Record source path, durable drawing identity, data fingerprint, XREF chain and load state.
- Deduplicate repeated instances of the same source drawing by default.
- Unit-test source selection, nesting, deduplication, missing/unloaded states and corrupt/newer schemas.

This increment does not place or update any drawing objects.

**Implemented 2026-07-23:** one read-only XREF-graph pass now discovers direct and nested sources, reads each
loaded source database once, and reports Loaded, Unloaded, Missing, Unresolved, no CE data, corrupt data and
newer-schema states. Loaded sources are identified and deduplicated by AutoCAD's durable DWG fingerprint;
paths are retained only for display and for grouping unavailable rows. The canonical SHA-256 data fingerprint
ignores the DWG's file location and JSON object-property order. No command or UI consumes this result until
PS-01C.

### PS-01C — host-owned linked placement

- Add a **Schedule source** selector: Current drawing or selected CE drainage XREFs.
- Source-qualify every linked row/cell with drawing identity plus durable pit/pipe identity; local legacy cells
  continue to resolve as Current drawing.
- Store one host schedule-instance record containing source selection, sets, insertion point and fingerprint.
- Keep XREF-derived engineering cells read-only and provide **Open Source Drawing** for changes.
- Block duplicate displayed pit numbers across selected sources; do not silently rename engineering assets.

**Implemented 2026-07-23:** `PITSCHEDULE` now opens in the unchanged **Current drawing** mode by default and
adds a clearly labelled **Drainage XREFs** mode. Each selectable source shows its filename, path and truthful
readiness state. Selected source rows are qualified by the source DWG fingerprint and pit/pipe identity, are
read-only in both the grid and placed-cell edit path, and provide an explicit **Open** action for source changes.
Placement stores one JSON schedule-instance record on the host schedule block containing the source drawings,
fingerprints, selected sets, insertion point and row count. Placed external cells also retain their qualified
source identities and last placed value. Duplicate displayed pit numbers across selected source drawings clear
the preview and visibly block placement; no asset is silently renamed. The XREF databases are never opened for
write.

**PS-01C AutoCAD check:**

1. Open `PITSCHEDULE` in a normal Civil DWG and confirm **Current drawing** is selected and existing edit/place
   behaviour is unchanged.
2. In a final DWG, attach one loaded CE drainage DWG. Select **Drainage XREFs**, tick the source and confirm the
   grid identifies the source and cannot be edited.
3. Use **Open** and confirm the schedule window closes before the drainage source drawing opens.
4. Place the XREF schedule, save/reopen the final DWG and confirm the schedule graphics remain.
5. Attach the same source twice and confirm it is offered once.
6. Select two source DWGs that both contain `P1`; confirm the conflict names both sources and nothing is placed.
7. Select two non-conflicting sources, place once and confirm only the final DWG becomes dirty. Both drainage
   sources must remain unchanged.

### PS-01D — refresh, issue status and final-drawing checks

- detailed staging is recorded in
  `PS-01D_PLAN_SCHEDULE_DIFF_IMPLEMENTATION_PLAN.md`;
- XREF save/reload or fingerprint change marks the host schedule **Out of date**.
- **Update Schedule** previews added, removed and changed rows, then updates in place with one Undo.
- Missing or unloaded sources preserve the last placed graphics but show a prominent non-current status.
- `CDCHECKDWG` reports drainage XREF with no host schedule, stale source, missing/unloaded source, duplicate
  authoritative schedules and duplicate pit numbers.
- QA-01 consumes the same status before Ready to Issue; no separate schedule-only fingerprint is introduced.

## Compatibility and safety rules

- Never write to an XREF database from the host drawing.
- Never use file path alone as identity; paths can change.
- Never use a bare object handle across drawings; handles are only unique inside their source drawing.
- Preserve existing local schedules and the legacy `Pit Schedle` block migration path.
- Preserve the last known schedule if a source is temporarily unavailable; label it clearly rather than deleting it.
- No background refresh may mutate the drawing. Refresh detects; preview/apply performs the update.
- DATA-01 remains blocked and is unrelated to this drawing-local workflow.

## AutoCAD acceptance checklist

1. Place a normal current-drawing schedule; successful placement closes the WPF window once.
2. Cancel insertion-point selection; the window stays open and no schedule is added.
3. Attach one CE drainage XREF, select it as source and place the schedule in the final drawing.
4. Change a pit in the source, save/reload the XREF and confirm the host schedule becomes Out of date.
5. Preview and update; confirm the schedule stays at the same point and one Undo restores the prior schedule.
6. Unload, rename and reload the XREF; confirm truthful Missing/Unloaded recovery without silent deletion.
7. Attach the same source twice and confirm rows are not duplicated.
8. Attach two sources with the same pit number and confirm placement is blocked with a clear resolution message.
