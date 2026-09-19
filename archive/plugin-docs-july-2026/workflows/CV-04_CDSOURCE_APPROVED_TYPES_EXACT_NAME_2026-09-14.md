# CV-04 — CDSOURCE: approved types first, exact name, duplicates refused, one backbone, base-point guard

**Authority:** `docs/CARDS/CV-04_SURFACE_DRAINAGE.md` — approved CV4-12 (`CDSOURCE` keeps approved source
categories first; Custom is advanced; duplicate identifiers are blocked), CV4-13 (automatically prove that
`SOURCE.dwg` inserts at the picked point; the old 211 m offset becomes a permanent regression check), CV4-2 (one
backbone; sources cannot drift), CV4-3 (real asset types, not fake pits), CV4-15 (one atomic Apply, one Undo).
**Tim's rulings:** 13 September 2026 (late) — the type list is **Roof Drain, AC Unit, Overflow Pipe, Hot Water
Unit, Other**; 14 September 2026 — "source block is for parts of the stormwater drainage system that don't have a
regular block, in some cases random things related to certain jobs", so a generic source behaves like every other
source (it can sit on a pipe run and feed it, exactly like a downpipe) and the typed name stays essential.
**Classification:** Modify — same command, same block, same layer; the start of the command and its write route
change. No engineering value invented; the list is Tim's.
**Built by:** Claude, branch `claude/ce-autocad-civil-90-percent-db893b`.
**Status:** Built (managed evidence, AutoCAD 2027 / net10 compile and tests). Not Native Accepted.

## Drawing outcome (what Tim sees)

1. `CDSOURCE` asks `Source type [RoofDrain/ACUnit/OverflowPipe/HotWaterUnit/Other] <RoofDrain>`. `Other` asks for
   a typed name (spaces allowed, e.g. `GREASE TRAP`); names are stored upper-case like every tag.
2. A name already carried by another source is refused before any pick: "AC UNIT is already used by another source.
   Tags are never recycled; nothing was placed." The same check runs again inside the transaction.
3. The block is then placed exactly like a downpipe: drag with the live landing preview; a source on a pipe run cuts
   into that run so the schedule shows it feeding the line; a free-ground source stands alone; block, exact-name
   tag, label (the full name, e.g. `AC UNIT`, not just `AC`), connection point and ownership record are written in
   one transaction — one `U` removes all of it; Escape places nothing. No fake pit row is written (CV4-3).
4. Missing `SOURCE.dwg` (and no definition in the drawing) refuses before the type question.

## How it is wired (one code path)

- `Rules/GenericSourceTypes.cs` — Tim's list (keyword → name), `NameForKeyword`, `Normalise`. Pure.
- `Commands/SourceBlockGenericCommand.cs` — read-only definition check → type prompt (`ResolveSourceName`, pure) →
  `SourcePlacementService.IsTagInUse` (read-only) → `SourcePlacementService.Place(... "SOURCE" ..., exactTag: name)`.
- Backbone (additive, guard-safe): `SourcePlacementService.Place/CommitFreeStandingPlacement/
  PlaceThroughExistingLinkedOwner` gain an optional `exactTag`; one rule `ResolvePlacementTag` (next family number, or
  the exact name when no other block carries it) used by all three routes and by
  `LinkService.ApplyCompleteSourcePlacement` (optional `exactTag` parameter; the label text for an exact name is the
  name itself). `SourceTagService.FindTagOwnerHandle` is the one "who holds this tag" rule; `Retag` now delegates to
  it. Every existing dependency/atomicity guard (`SourceAtomicCoordinatorDependencyTests`,
  `SourcePlacementAtomicityTests`, `TrackedStraightPipeSplitTests`) still passes.
- CV4-13 guard: `GenericSourceAtomicPlacementTests.SourceDwg_InsertsAtThePickedPoint_TheOld211mOffsetStaysFixed`
  reads the shipped `Installer/source_blocks/SOURCE.dwg` offline (ACadSharp) and requires its geometry centre within
  1 m of the base point (it is ±175 mm today; the original defect was 211 000 mm).

## Decisions banked (not invented)

- The four approved types and "Other" are Tim's words; nothing else is offered.
- Exact-name labels show the whole name (the numbering-mode rule that collapses `DP1` to `DP` is for numbered
  families, not typed names).
- Duplicate refusal wording reuses the existing Retag sentence ("Tags are never recycled").

## Automated evidence (work PC, AutoCAD 2027 / net10, 14 September 2026)

`GenericSourceAtomicPlacementTests` (9: list + keywords, typed/approved resolution ×6, wiring guard, SOURCE.dwg
base-point guard). Focused run with every source backbone guard: 266/266. Receipts
`claude-cdsource-drainage-net48.log`, `claude-cdsource-drainage-net8.log`, `claude-cdsource-civil-full-net10.trx`
under `C:\Autodesk\CERef\Colleague-20260913\verification\` (numbers in the master status). Not native placement /
pipe-split / Undo evidence.

## AutoCAD acceptance (joins the consolidated batch)

1. `CDSOURCE` → Enter (Roof Drain) → drag onto free ground → Accept: SOURCE block on DOWNPIPES, label `ROOF DRAIN`;
   one `U` removes block, label and record.
2. `CDSOURCE` → `Other` → type `grease trap` → drop it on a pipe run → the run is split and the schedule shows
   `GREASE TRAP` feeding it; one `U` restores the single pipe.
3. `CDSOURCE` → `ACUnit` twice → the second is refused before any pick with the "never recycled" message.
4. Escape while dragging → nothing placed, no definition added (`PURGE`).
