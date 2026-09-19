# CDIMPORTXCIVIL — Handoff prompt for a fresh chat (2026-07-03)

> Paste everything below the line into a new chat to continue. Tim is frustrated —
> the import makes small gains each round but is still "faster to draw from scratch."
> Stop making incremental plumbing fixes; step back and question the whole approach.

---

You are taking over the CDIMPORTXCIVIL (Xcivil consultant-drawing import) quality work in
`C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage`. Tim is a civil engineer, not a coder — explain
in AutoCAD terms, and he does all testing in AutoCAD.

## READ THIS FIRST — the honest state

Over four rounds we fixed real data-plumbing bugs (pit-registration persistence, self-pipe at the
JSON layer, cross-re-import pipe accumulation, geometric dedup, rainwater-tank recognition). Each
round improved the numbers slightly. **But the imported drawing is still unusable** — Tim's exact
words: "extremely rough, faster for me to draw from scratch." We have been treating symptoms one
at a time. **Do not just add a round 5 of the same. First re-examine whether the import
architecture can ever produce a draftsperson-quality result from this consultant's Civil 3D data,
or whether the strategy needs to change** (e.g. import ONLY the schedule + pit positions and
re-draw pipes natively with CE's own tools, rather than copying consultant geometry).

## Ground truth from Tim's latest verified run (2026-07-03 16:44, round-4 code CONFIRMED loaded)

- Import log: `%APPDATA%\TIM_CE_CADTOOLS\logs\xcdimport\26612_XCivil_CDIMPORTXCIVIL_DEBUG_20260703_164500.log`
  — contains `pipe-dedup:` lines, so round-4 genuinely ran (bundle DLL hash `5a417a1e…` == the
  round-4 build). NOTE a suspicious dedup log artifact: lines read
  `DISCARDED duplicate handle=ABA42 (kept ABA42)` — dropped handle == kept handle, and `dia=0`
  (wall-pair pipes deduped before diameter resolution). Investigate whether dedup is running too
  early / on the wrong objects.
- DesignCheck CSV (`DesignCheck_W26-32_CVL TEST_20260703_1645.csv`): STILL ~45 orphaned pipes
  (most with blank endpoints; IO1-6/OF2-12 as one-ended), 12 floating source-tag pits, and the
  circular dependency `P5 → P4 → P3 → P2 → P1 → P1 [cycle]` (self-pipe STILL present at the graph
  level). Pass F Schedule Drift is now OK (BUG-058 registration fix IS working).
- Pit_Schedule.csv: single set P1-P6 + X01 (NOT doubled — accumulation fix working), but junk
  inlet rows remain ("s", blank FROM, P1 listing an inlet "FROM P1" at 450/18.15, "OUTLET SMALLER
  THAN INLET" on P2).
- Screenshots (Tim's): pipes are single blue bars now (dedup helped) BUT: pipes overshoot / don't
  terminate at the 35CONT pit outline; "FANU…" leader labels render MIRRORED/backwards; spot-level
  texts (P18.974 family) scattered; pit blocks are the yellow grate square with pipes not meeting
  it; placement does NOT sit on the architectural xref.

## THE 15 ISSUES TIM KEEPS LISTING — with honest current status

1. **Pipes inserting on top of one another** — PARTIAL. Round-4 dedup removed the byte-identical
   duplicates, but near-coincident copies and the multi-view geometry issue remain. Still visible.
2. **Pipes not terminating on the pit outline (35CONT line)** — OPEN (BUG-065). Not started.
3. **Rainwater tanks / DP downpipes / risers & droppers not handled** — PARTIAL. RWT→WT recognition
   added (round 4). DP recognition already existed; the DN100 downpipes still fail endpoint
   resolution (blank-ended). Risers/droppers not modelled.
4. **X01 inserting rotated incorrectly** — OPEN (BUG-062). Root cause known: rotation guessed from a
   2-point centroid polyline direction, not the real block insertion angle.
5. **Council stub not inserted at all** — OPEN (BUG-063). It IS scanned (zero-length riser at P1)
   but has no resolvable destination; no "existing infrastructure" concept.
6. **Existing council pipes not shown** — OPEN (BUG-063). Existing/EX layers are deliberately
   excluded as "not new CE geometry"; Tim wants them shown (as existing).
7. **Multi-segment pipes drawn as individual segments with ILs everywhere** — PARTIAL/OPEN. Not a
   polyline-split bug; it's the Civil 3D plan/profile/section multi-view geometry producing multiple
   short "pipes". Dedup reduces but does not eliminate.
8. **No AI feature checking the final imported copy against the consultant markup** — OPEN (feature,
   never built). This is the natural capstone once the data is trustworthy.
9. **"Propose fixes" shows nothing in a window** — OPEN (BUG-064). Must at least say "0 fixable — N
   skipped because…" instead of silently doing nothing.
10. **Some IOs placed as downpipes** — OPEN. Likely tag-category misclassification (IO vs DP) or
    block-name mapping; verify `InferImportedSourceTag` / `ResolveImportedSourceBlockName`.
11. **Pit labels & cover levels strewn everywhere / on top of things** — OPEN (BUG-066). Junction
    de-confliction (v2) is insufficient on the real drawing.
12. **Mis-aligned double pipes** — PARTIAL. Round-4 dedup targets these; some remain (see #1/#7).
13. **Detention pipes not found/placed as detention** — OPEN. `BuildImportedPipeData` hardcodes
    `DetentionTwinPipes = false`; detention recognition exists in `InferPipeType` but placement as a
    detention twin run is not wired. Tim confirms twin detention pipes DO occur (his only <1m
    parallel case).
14. **Placement doesn't align with the architectural xref** — OPEN (BUG-068). **Tim's ruling: snap
    to where the arch xref sits — drainage is drawn ON TOP of the arch plan, pits go where they are
    in real life, NO pick-point prompt.** This is arguably the MOST IMPORTANT one and the design
    brief is set. Investigate how Tim's CVL drawings are set up (arch xref origin/rotation) vs
    Mike's XCivil coordinates, and anchor the import to that.
15. **Pit schedule completely different / messed up** — PARTIAL. Downstream of the connectivity
    problems (#1,#5,#7,#13) + junk inlet rows. Re-audit `PitScheduleBuilder` after connectivity is
    fixed; known residual: renders "FROM P1" for a pipe whose other end is blank.

Confirmed WORKING (don't re-fix): Abort/Replace prompt; IO/OF ProjectData registration persists
(Pass F OK); re-import no longer doubles pits or accumulates pipes across runs; schedule shows a
single set of pits.

## Tim's rulings (already decided — don't re-ask)

- **Placement:** snap to the architectural xref, no pick-points (issue #14).
- **Twin pipes:** real parallel pipes <1m apart occur ONLY as detention twins (issue #13).
- **Quality bar:** the output must look like Tim's own drafting, or the import isn't worth having.

## Build / deploy discipline (a HARD RULE now — a race already invalidated one test)

- Deploy = `dotnet build Modules/Drainage/CE_CVL_SUITE.csproj -c Debug -f net10.0-windows` (auto-
  copies to `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\...\Modern\`) — ONLY when Tim
  says AutoCAD is closed.
- **Every other build/test MUST pass `-p:SkipDevBundle=true`** — see `CE_ACAD_PLUGIN/CLAUDE.md`
  "HARD RULE — bundle deploys". A parallel session without the fixes clobbered the bundle one minute
  before a field test and invalidated it.
- After deploying, byte-verify: SHA256 of the bundle DLL must equal the just-built bin DLL.
- Confirm the code Tim tested is yours: the import log must contain `pipe-dedup` lines and the
  expected `Import batch id`.
- net48 test-host `Acdbmgd.dll` failures are environmental (no AC2022-24 on the box).

## Where things live

- Code: `Modules/Drainage/Services/Xcivil*.cs` (scan `XcivilEntityScanner`, pipeline
  `XcivilImportService*.cs`, recognition `XcivilLayerRecognition.cs`, dedup/tagging
  `XcivilNetworkFilterService.cs`, registration `XcivilSourceTagPitRegistrationService.cs`,
  cleanup/idempotency `XcivilImportReportService.cs` + `XcivilImportIdempotencyService.cs`,
  pit/pipe insertion `XcivilPitInsertionService.cs` / `XcivilPipeInsertionService.cs`).
- Tests: `Modules/Drainage.Tests/Services/Xcivil*Tests.cs` (follow existing conventions; NUnit;
  AutoCAD-coupled bits gated via `AcadTestHost`).
- Bug tracker: `C:\Lisp Files\BUG_CARPARK.md` — BUG-058/059/060 (fixed-in-code), BUG-062..069 (open,
  with root causes + Tim's rulings). Read it first.
- Regression log: `CE_ACAD_PLUGIN/REGRESSION_LOG.md` (newest first — rounds 3/4 detail).
- Checklist: `CE_ACAD_PLUGIN/docs/TIM_CHECKLIST.md`. Plan board: `docs/SMARTIFY_PLAN.md`.
- Real data: MAIN drawing `...\W26-32_Lot 58 Axis Boulevard, Officer South\W26-32_CVL.dwg`
  (its `W26-32_CVL TEST.dxf` is the test-import target but is full of untracked ghosts from earlier
  runs — for a clean test, import into a FRESH SAVEAS of the real CVL dwg, not the TEST file).
  Consultant package: `...\Engineering\Markups\From Mike\2026-06-24_Design from Mike\` (26612_XCivil.dwg,
  26612_CIVIL.pdf, Pit_Schedule.csv).

## Discipline for this work (from the repo's plugin-work rules)

Every change = code + REGRESSION_LOG entry + tests (unit for pure logic, manual AutoCAD checklist for
the rest) + BUG_CARPARK status update. Every bug starts with a failing test. Write-capable features
stay behind preview→Apply→single-undo. Never invent engineering constants. Verify builds on both
TFMs before handing Tim a deploy.

## Suggested FIRST move (don't just dive into fixes)

Ask Tim whether the goal is "faithfully copy the consultant's drawing" or "extract the design
(schedule + pit positions + connectivity) and RE-DRAW it with CE's native pipe/pit tools so it looks
like his own work." The second path sidesteps most of issues #1/#2/#7/#11/#12 (they're all
consultant-geometry-copy artifacts) and directly serves the "faster to draw from scratch" complaint.
Placement (#14, arch-xref snap) and recognition (#3/#10/#13) matter either way. Get that strategic
decision from Tim before writing more code.
