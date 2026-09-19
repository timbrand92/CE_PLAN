# CV-04 — CDAGI atomic creation with CE-shipped AG_LINE; CDFW through the one source backbone

**Authority:** `docs/CARDS/CV-04_SURFACE_DRAINAGE.md` — approved CV4-2 (one surface-drainage backbone
sharing CV-03 identity, preview and connection rules; "CDFW and DP cannot drift"), CV4-3 (real asset
types, not fake pits), CV4-8 (`CDFW` uses stable `FW` identities, non-recycled numbering and the shared
placement/overlap preview), CV4-14 (`CDAGI` ships its approved line type with CE, removes Timothy's
personal template dependency, previews open/closed geometry and stores the actual entity — not copied
coordinates in remarks), CV4-15 (each compound applied atomically with one Undo); `docs/CLEAN_SLATE_REBUILD.md`
§6.10 rules 1, 3, 5, 11, 12; AGENTS.md native protection rule. Same route as the built CDSTRIP card
(`CV-04_CDSTRIP_ATOMIC_CREATION_CARD.md`) and the shared `AtomicDrawingChangeRunner`.
**Classification:** Modify — two existing commands keep their names, prompts, layers, colours and records;
their write route changes. No new command, no engineering rule, no threshold, no provider access.
**Built by:** Claude, branch `claude/ce-autocad-civil-90-percent-db893b` (own branch on top of the verified
integration head `1522bbdb`; Codex's CDSTRIP / survey / calculation / linked-text files untouched).
**Status:** Built (managed evidence, AutoCAD 2027 / net10 compile and tests). Not Native Accepted.

## Drawing outcome (what Tim sees)

**CDAGI.** Same picks as before (first vertex, `Next AGI vertex [Close/Undo] or Enter to finish`), but the
picks are rubber-banded on screen only. After Enter or `Close` the whole drain is previewed as an open or
closed outline in the AGI DRAIN colour with `Place this AGI drain? [Accept/Cancel] <Accept>`. Accept writes
the AGI DRAIN layer (if absent), the AG_LINE linetype (loaded from CE's own `Assets\Linetypes\CE_CIVIL.lin`
when the drawing lacks it), the polyline and the AGI record in ONE transaction — one `U` removes the drain
and its inspector record together. Escape or Cancel at any prompt leaves no layer, no linetype, no polyline
and no record. A locked AGI DRAIN layer, or an AG_LINE that is neither in the drawing nor installed with CE,
refuses before the first pick. Tim's personal A1 template path is no longer read by CDAGI. Snapping the last
pick back onto the first vertex still closes the drain; a closed drain with fewer than three distinct
vertices is refused instead of being drawn degenerate. The record's remarks now read
`AGI drain (n vertices, open|closed)` — the polyline handle is the link to the geometry; coordinates are no
longer copied into text.

**CDFW.** A floor waste is now placed exactly like a downpipe: drag the FLOOR WASTE block with the live
landing preview (the same one-transaction compound that DP / IO / OF / FO / GIO use), get the next stable
`FW<n>` tag (never recycled), its label, connection point and ownership record in one Undo step; a refused
landing places nothing. A missing `FLOOR WASTE.dwg` (and no definition in the drawing) refuses before the
first pick. The floor waste is no longer written as a fake pit row (`PitType = "FW"`); existing drawings
with such rows keep reading them.

## How it is wired (one code path)

- `AgiCommand.cs` — prompts, transient rubber band, plan preview, Accept (`CommandPreFlightForDeferredApply`
  like CDSTRIP; picks admitted to host-world XY / Z = 0 through `WorldPlanPoint.ToHostWorldPlan`).
- `AgiCommand.Plan.cs` — pure `TryBuildPlan` (≥ 2 vertices; snap-close within 1 mm drops the duplicate
  vertex; closed needs ≥ 3 distinct), `ComputeCentroid` (unchanged average rule), `BuildRemarks`,
  `AllocateNextAgiTag(pits)` (highest AGI-N + 1, never recycled), `ResolveAcceptAnswer`.
- `AgiCommand.Preview.cs` — `AgiDrainTransientPreview` over the new shared `Services/TransientDrawableSet`
  (transients only; the CDSTRIP preview was left as Codex integrated it).
- `AgiCommand.Apply.cs` — `AtomicDrawingChangeRunner` lifecycle: revalidate (active document, fingerprint,
  REFEDIT, locked layer, current space not an Xref record) → resources inside the transaction (Civil discipline
  approval, `LayerService.EnsureLayerInTransactionAllowingLinetypeLoad`) → polyline → AGI registration through
  the shared snapshot seams (unchanged record shape: `PitType "AGI"`, `IncludeInSchedule false`, centroid
  position, entity handle) → exact readback (layer, closed flag, vertex count and coordinates, world normal,
  snapshot JSON) → `CommitDrawingChange` → publish once (adopt snapshot, inspector, draw order).
- `Assets/Linetypes/CE_CIVIL.lin` (new, shipped via the csproj `Assets\Linetypes\**\*` include and the
  existing bundle Assets copy) — `AG_LINE` with the exact elements read from Tim's CE A1 template
  `CE_A1_C01 - VERTICAL.dwg` on 13 September 2026 (dash 0.5, gap 0.4 carrying "AG" STANDARD S=.25 X=-.25
  Y=-.1, gap 0.35). Nothing invented.
- `LayerService.EnsureLinetype` — tries the CE-shipped file (`ResolveShippedLinetypeFile`,
  `TryLoadLinetypeFromShippedFile`) after acad.lin / acadiso.lin and BEFORE the personal template drawing;
  the template fallback is kept for other linetypes (hide/redirect before retirement).
- `FloorWasteCommand.cs` — read-only definition check, then the same `SourcePlacementService.Place(... "FW" ...)`
  call DP / IO / OF / FO / GIO make (DOWNPIPES layer as before); the command only words the result.
  `SourceBlockInsertCommands.cs` is untouched.

## Decisions banked (not invented)

- AG_LINE pattern = the template's stored elements, byte-for-byte in .lin syntax; any change must come from
  a reviewed template, never from code.
- "Closed needs ≥ 3 distinct vertices" is geometric validity, not an engineering rule.
- FW rows are no longer written as pits (CV4-3). The inspector's `"FW"` display case remains for older rows.
- No relink-all after CDAGI (the old route's `RelinkAllPipeEndpoints` was a hidden second write after the
  record; CDSTRIP's atomic route already dropped it).

## Automated evidence (work PC, AutoCAD 2027 / net10, 13 September 2026)

`AgiFloorWasteAtomicSourceTests` (16): open/closed/snap-close plans, degenerate and short refusals, remarks
without coordinates, tag allocation, accept rule, shipped .lin exact pattern + csproj include, LayerService
order guard, CDAGI no-template/atomic-runner guard, CDFW backbone guard + `SourceFamilies` FW entry.
Receipts: `claude-agi-fw-drainage-net48.log`, `claude-agi-fw-drainage-net8.log`,
`claude-agi-fw-civil-full-net10.trx` under `C:\Autodesk\CERef\Colleague-20260913\verification\`
(numbers in the master status). Not native polyline / transient / linetype-load / Undo evidence.

## AutoCAD acceptance (joins the consolidated batch)

1. `CDAGI`, three picks, Enter → outline preview, Accept → polyline on AGI DRAIN with AG_LINE showing the
   "AG" text; CDINSPECTOR shows `AGI1`; one `U` removes the polyline and the inspector record together.
2. `CDAGI`, Escape at the preview in a drawing that had no AGI DRAIN layer and no AG_LINE → `LAYER` and
   `LINETYPE` dialogs show neither was created; `PURGE` lists nothing new.
3. `CDAGI` with `Close` on a rectangle → closed polyline; snap the last pick onto the first vertex → same.
4. Lock AGI DRAIN → `CDAGI` refuses before any pick. Rename `CE_CIVIL.lin` in the installed bundle on a
   drawing without AG_LINE → refuses before any pick, naming the file.
5. `CDFW` → drag preview like DP, next `FW<n>` tag, label and connection point; one `U` removes all of it;
   Escape while dragging places nothing; a drawing whose FLOOR WASTE.dwg is unavailable refuses up front.
