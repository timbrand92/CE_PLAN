# CE CVL SUITE — Architecture Upgrade Plan
## Session handoff — last updated 2026-05-08

This document is the single source of truth for the multi-phase architecture upgrade.
Start every new session by reading this file and `REGRESSION_LOG.md`.

---

## Why this upgrade exists

Three fundamental problems were identified:

1. **Annotations are compound entities** — pipe text, inverts, and arrows were bundled with
   the pipe and rebuilt from scratch on every PIPEEDIT OK click. This caused 5-second freezes
   and AutoCAD crashes on busy drawings.

2. **The drawing is the data model** — ProjectData (the schedule data store) was a secondary
   copy of what the drawing contains. They drifted out of sync.

3. **Pit-to-pipe ownership is inferred at runtime** — the plugin re-snapped pipe endpoints to
   pits via geometry on every operation instead of storing ownership explicitly, making pit
   moves, pipe stretching, and schedule accuracy fragile.

---

## Phase status

| Phase | What | Status |
|-------|------|--------|
| Phase 1 | Annotation system rebuild | **DONE — tested in AutoCAD** |
| Phase 2 | ProjectData as source of truth + explicit pit ownership | **DONE — Tracks A and B confirmed in AutoCAD (2026-05-07)** |
| Phase 3 | Network intelligence (flow tracing, validation, profile) | **DONE — confirmed in AutoCAD (2026-05-08)** |
| Phase 4 | JSON catalogue + trench grate + raingarden | **DONE — Tracks A+B+C confirmed in AutoCAD (2026-05-07)** |
| Phase 5 | Survey integration (cover level suggestion/checking) | **DONE — all tracks confirmed in AutoCAD (2026-05-08)** |
| Phase 6 | Slab and hardstand fall design (CDFALL fix, CDSLAB, CDSPOON) | In progress — design confirmed 2026-05-08 |
| Phase 7 | Slab joint auto-placement (CJ/SSC — AS 3600 / NCC) | Not started — prerequisite: Phase 6 complete |

**Rule: do not start the next phase until Tim confirms the previous one tested in AutoCAD.**

---

## Phase 1 — Annotation system rebuild — DONE

### What was built

- `Models/PipeAnnotationHandles.cs` — new model storing the four annotation handles
  (pipe text, first invert, second invert, arrow) plus per-pipe side and offset values.
  Replaces the old `List<PipeAttachment>` T-value approach.

- `Models/AnnotationOffsetSettings` — global defaults (PipeTextOffsetMm=200,
  InvertOffsetMm=150, ArrowOffsetMm=200, DefaultSide=Top) loaded from settings JSON.
  Changing these only affects new pipes; existing per-pipe offsets are not altered.

- `TextService.UpdateAnnotationContent(ObjectId, string)` — in-place MText content
  update. Returns false if entity is gone, so caller falls through to recreate-only-
  when-missing.

- `PipeEditCommand.cs` — PIPEEDIT OK no longer deletes and recreates annotations.
  It calls `UpdateAnnotationContent` for each label. Only erases labels when Tim
  explicitly turns them off in the dialog.

- `CE_CVL_SUITE.Tests/Services/AnnotationSystemTests.cs` — model-level tests plus
  AutoCAD-skip guards for live-entity tests.

### What Tim confirmed working in AutoCAD

- PIPEEDIT no longer causes 5-second freeze (BUG-049)
- Annotations stay in place and update text content only on PIPEEDIT OK

### Parking lot items from Phase 1

- **BUG-047 (Class D pit persisting)** — was flagged before Phase 1 ended.
  Not in REGRESSION_LOG. Confirm status with Tim at next session start.
- **Detention pit rotating on CDEDIT** — reported during Group 1/2 testing.
  Not yet investigated. Add to next-session parking lot.

---

## Phase 2 — ProjectData as source of truth + explicit pit ownership

### Why this matters (in AutoCAD terms)

**Current behaviour:** when Tim draws a pipe between two pits, the drawing entity
is created first. ProjectData is updated afterwards. If AutoCAD crashes between
those two steps, the data is lost. Also, every PIPEEDIT re-snaps the pipe's From/To
pit ownership by geometry — if two pits are close together, it can silently reassign
which pit owns the pipe.

**After Phase 2:** ProjectData is written first. Drawing entities are the visual
output of what ProjectData says. Pit ownership is written once at pipe creation
and never re-snapped unless Tim explicitly changes it.

### Current state of the codebase (found during research 2026-05-06)

**`CdCommand.cs` (1651 lines):**
- Calls `PipeCreationService.CreatePipeWithAnnotations()` to create drawing entity
- THEN calls `ProjectDataService.AddPipe(pipeData)` — write is AFTER entity creation
- `PipeData.From` / `PipeData.To` are set from geometry snap in `TryAddPipeToSchedule()`
  (pit ID strings, resolved by `TryResolvePitId`)
- No explicit pit ID captured at the moment Tim snaps to the pit block

**`PitCommand.cs` (507 lines):**
- Calls `BlockService.InsertBlock()` to create pit block
- Calls `LinkService.RegisterPit()` to register in link system
- THEN calls `ProjectDataService.AddPit(BuildPitData(...))` — write is AFTER entity creation

**`PipeEditCommand.cs` (~1150 lines):**
- `UpdatePipeFromViewModel()` updates drawing entities (lines 656–858) THEN calls
  `UpdatePipeSchedule()` (line 861) to write to ProjectData
- `UpdatePipeSchedule()` has the BUG-041 ownership-preservation guard (confirmed working)
- No separate `FromPitId`/`ToPitId` fields — pit IDs live in `PipeData.From`/`PipeData.To`

**`ProjectDataService.Instance.cs` (56 lines):**
- Has `AddPit(PitData)`, `AddPipe(PipeData)`, `UpdatePipeEndpointsByHandle(handle, from, to)`
- No general `UpdatePipe()` method — updates are field-specific

**`PipeData` model:**
- `From` and `To` fields hold pit ID strings (e.g. "P3", "P5")
- These ARE the pit ownership fields — no need to add separate `FromPitId`/`ToPitId`
- Phase 2 goal: populate `From`/`To` at creation time from the snapped block, not
  from geometry snap after the fact

**`LinkService.Registration.cs`:**
- `RegisterPipe()` does NOT call `ProjectDataService.AddPipe()` — they are separate
- `LinkPipeEndpointsToPits()` does runtime geometry snap — this is what Phase 2 replaces

### What changes in Phase 2

#### Track A — ProjectData written before drawing entities — **DONE (2026-05-06, confirmed in AutoCAD)**

**`CdCommand.cs`:** `TryAddPipeToSchedule` moved to immediately after entity creation
(right after `pipeId = creation.PipeId`). Previously called after
`LayerService.ApplyConfiguredDrawOrderForCommand()` — i.e., last. Now called first,
before any interactive annotation prompts.

**`PitCommand.cs`:** `ProjectDataService.SetDrawingPath` + `AddPit` moved to immediately
after the `ConfigurePitBlock` try-catch succeeds. Previously called after the optional
label and cover-text prompts (at the end of the method).

**`PipeEditCommand.UpdatePipeFromViewModel()`:** `UpdatePipeSchedule` call moved to before
`OsnapService.SetDrawingMode()` — i.e., before any drawing entity is touched. Previously
called at the very end of the method after all annotation updates. The duplicate
end-of-method call was removed.

Build: green (0 errors, 4 pre-existing warnings). Tests: 397/397 pass.

#### Track B — Pit ownership captured at creation, not by re-snap — **DONE (2026-05-07, confirmed in AutoCAD)**

**`CdCommand.cs`:**
- At the moment Tim snaps to a pit block (point pick), read the pit ID from the
  snapped block's XData / link data at that instant
- Store as `pipeData.From` (first endpoint) and `pipeData.To` (last endpoint)
- Write these into `PipeLinkData` immediately via `LinkService.RegisterPipe()`
- `TryResolvePitId()` geometry snap becomes a FALLBACK only (when no explicit ID found)
- Net visible effect: From/To in PITSCHEDULE always correct, even for short pipes
  between adjacent pits

#### Track C — Invert propagation (stretch goal for Phase 2, or Phase 3)

After saving a new invert in PIPEEDIT, ask:
"Recalculate downstream inverts at current grade? [Yes/No]"
If Yes, walk the connected pipe network downstream and update each invert.
This depends on Track B ownership being explicit first.

**Hold this track until Tracks A and B are confirmed in AutoCAD.**

### Files that will change in Phase 2

| File | Track | Change summary |
|------|-------|----------------|
| `Commands/CdCommand.cs` | A + B | Write to ProjectData before entity creation; capture pit ID at snap time |
| `Commands/PitCommand.cs` | A | Write to ProjectData before block insertion |
| `Commands/PipeEditCommand.cs` | A | ProjectData write before drawing entity update |
| `Services/ProjectDataService.*.cs` | A | Add `UpdatePipeHandleByScheduleId` if missing |
| `Services/LinkService.Registration.cs` | B | `RegisterPipe` stores explicit `FromPitId`/`ToPitId` when available |

### Tests to add (Phase 2)

- `ProjectDataFirstTests.CdCommand_PipeDataWrittenBeforeEntityCreation` (integration)
- `ProjectDataFirstTests.PitCommand_PitDataWrittenBeforeBlockInserted` (integration)
- `OwnershipTests.RegisterPipe_WithExplicitPitIds_StoresOwnership`
- `OwnershipTests.RegisterPipe_NoExplicitIds_FallsBackToGeometrySnap`

### What Tim tests in AutoCAD after Phase 2

1. Draw a pipe between P3 and P5 using CD
2. Open PITSCHEDULE — confirm pipe shows From=P3, To=P5
3. PIPEEDIT that pipe, change the diameter, click OK
4. Open PITSCHEDULE again — confirm From/To are still P3 and P5 (not re-snapped)
5. Draw two pits very close together (say 300mm apart), draw a pipe between them
6. PITSCHEDULE — confirm correct pit IDs assigned to the pipe (not swapped by proximity)
7. Close and reopen the drawing — confirm all data intact

---

## Phase 3 — Network intelligence

*Validation wiring done (2026-05-07). Awaiting AutoCAD confirmation.*

### Flow path tracing (CDTRACE command)
- Click a pit → everything upstream highlights
- Uses `From`/`To` ownership from Phase 2 — no geometry snapping
- Click again or Escape to clear

### Real-time design validation (CDAUDIT / inline) — **WIRING DONE (2026-05-07)**
- After every PIPEEDIT save, warns immediately:
  - Grade too flat (< 1:100 configurable)
  - Cover depth below minimum (< 600mm configurable)
  - Reverse fall (pipe flows uphill)
  - Velocity out of range
- Rules loaded from `DesignStandards` in user settings JSON (Tim can edit)
- `Services/DesignValidationService.cs` — **DONE** (35 tests)
- `Models/DesignValidationModels.cs` — **DONE** (ValidationWarning, PipeValidationInput, ValidationSeverity)
- `Models/UserSettings.cs` — **DONE** (added MinimumVelocityMs=0.6, ReverseFallToleranceMm=5.0 to DesignStandards)
- `Commands/PipeEditCommand.cs` — **DONE** wiring after `UpdatePipeSchedule`; builds `PipeValidationInput` from vm values in scope; pumped pipes (material contains "RISING"/"CHARGED") skip grade checks; warnings printed as `[CE] Warning: …` on command line
- `CE_CVL_SUITE.Tests/Services/AnnotationSystemTests.cs` — **DONE** 6 new tests added (2 pure: Top/Bottom position constants; 4 AutoCAD-category: above/below with and without mask)
- Total tests: 444 (0 failures, net48 + net10.0-windows)
- **Not yet confirmed in AutoCAD — gate for CDTRACE and network-aware CDPROFILE**

### CDPROFILE network-aware
- Tim picks outlet pit → profile traces upstream automatically using Phase 2 ownership
- No manual pipe selection order needed

---

## Phase 4 — JSON catalogue + trench grate

*Tracks A and B complete. Confirmed in AutoCAD (2026-05-07).*

### Track A — network-catalogue.json + CatalogueService — DONE

- `Assets/Config/network-catalogue.json` — 6 node types + 5 link types. Tim can add new
  structure types by editing this file without any code changes.
- `Models/NetworkCatalogueModels.cs` — `NodeEntry` (id, label, blockName, defaultLayer,
  showInPitDialog, scheduleColumns) and `LinkEntry` (id, label, defaultDiameterMm, isGravity).
- `Services/CatalogueService.cs` — loads and caches the JSON; falls back to hardcoded defaults
  if the file is missing or malformed; `internal Reset()/LoadFromJson()` for test isolation.
- `ViewModels/PitViewModel.cs` — pit type dropdown now populated from `CatalogueService.GetNodes()`
  (filtered to `ShowInPitDialog = true`). TG excluded from PIT dialog.
- `Services/SettingsService.GetStandardMaterials()` — now populated from `CatalogueService.GetLinks()`.
- `CE_CVL_SUITE.Tests/Services/CatalogueServiceTests.cs` — 15 tests (valid JSON, malformed JSON,
  missing file fallback, default content assertions, reload behaviour).

### Track B — trench grate as first-class network node — DONE

- `Models/PitData.cs` — added `TgLengthMm` (double) and `TgGrateStyle` (string, default "Standard").
- `Services/PitScheduleBuilder.cs` — added `IsTrenchGrate(pit)` helper; `BuildPitSize` returns
  the TG length string (e.g. "1500") instead of "W x H" when pit type is TG.
- `Commands/SourceBlockInsertCommands.cs` — TG command now:
  - Calls `ProjectDataService.AddPit()` with `PitType="TG"`, `TgLengthMm`, `TgGrateStyle="Standard"`,
    `LidType="Standard"`, `IncludeInSchedule=false` (TG does NOT appear in PITSCHEDULE — Tim confirmed),
    `EntityHandle`, `Position`.
  - Calls `LinkService.RegisterPit(blockId)` so CDTRACE and CDPROFILE see TG as a structure.
  - Keeps existing `RegisterSourceBlock(blockId)` for hitbox and pipe-splitting behaviour.
- TG does NOT appear in PITSCHEDULE (`IncludeInSchedule = false` confirmed by Tim).
- `CE_CVL_SUITE.Tests/Services/TrenchGrateTests.cs` — 14 tests (including explicit IncludeInSchedule=false assertion).
- BUG-060 and BUG-061 (TG layer colour) confirmed already correct in existing code — absorbed.

### Track C — CDTG rename + CDRG raingarden command + GIO command — DONE (2026-05-07)

- `Commands/SourceBlockInsertCommands.cs` — TG command renamed to CDTG (old TG still works as alias).
  New CDRG command:
  - Freeform polyline with C=Close / U=Undo keywords (minimum 2 points to close).
  - Polyline on layer `50CONT`, colour 3 (green), linetype CONTINUOUS.
  - SOLID hatch on layer `HATCH113`, colour index 113, associative to the polyline.
  - Prompts for GIO block insertion point after polyline is closed; inserts from `C:\Lisp Files\GIO.dwg`.
  - Registers as network node: `PitType="RAINGARDEN"`, `IncludeInSchedule=false`.
- `Services/LayerService.cs` — added `LAYER_RAINGARDEN`, `COLOR_RAINGARDEN=3`,
  `LINETYPE_RAINGARDEN`, `LAYER_RAINGARDEN_HATCH`, `COLOR_RAINGARDEN_HATCH=113`. Both layers added
  to `EnsureStandardLayers()`.
- `Services/BlockService.cs` — added `BLOCK_GIO = "GIO"` constant.
- `Assets/Config/network-catalogue.json` — added RAINGARDEN node (`showInPitDialog: false`).
- `Assets/Config/command-registry.json` — CDTG entry replaces TG; CDRG entry added; TG kept as hidden alias.
- `Assets/Config/ce_toolbar_layout.json` — CDTG and CDRG added; old TG entry replaced.
- New `GIO` command in `SourceBlockInsertCommands.cs` — tagged source block (GIO1, GIO2…) on
  layer `50CONT`, same auto-tag/hitbox/pipe-split pipeline as DP/IO/OF/FO.
- `PlaceTaggedSourceBlock` updated with optional layer/color/linetype overrides for GIO.
- `Assets/Config/command-registry.json` and `ce_toolbar_layout.json` — GIO entry added.
- `CE_CVL_SUITE.Tests/Services/RaingardenTests.cs` — 8 tests (catalogue, PitData JSON round-trip,
  schedule exclusion, IsDetentionPit/IsTrenchGrate exclusion).
- **Confirmed in AutoCAD (2026-05-07):** All 9 test items confirmed ✅.
  Note: CDRG rubber-band preview (live line drawing) deferred as PARK-020.

---

## Phase 5 — Survey integration

*In progress — Tracks A, B, C confirmed in AutoCAD 2026-05-08. Track D in progress.*

### Track A — TIN interpolation engine — **DONE (2026-05-08, confirmed in AutoCAD)**

- `Models/SurveyData.cs` — `SurveyPoint`, `SurveyTinTriangle`, `SurveyMeta`, `SurveyPayload`,
  `SurveyReadResult`, `SimilarityTransform` (4-parameter 2D Helmert transform struct).
- `Services/SurveyService.cs` — barycentric TIN interpolation (`TryInterpolateFromTin`),
  nearest spot level fallback (`TryNearestSpotLevel`), combined lookup (`TryGetRlAtPoint`),
  RL label parser (`TryParseRl` — decimal, 0–500 range, must contain decimal point).
- 14 unit tests in `SurveyServiceTests.cs`.

### Track B — CDSURVEY two-source loading — **DONE (2026-05-08, confirmed in AutoCAD)**

Two-step CDSURVEY command:
1. Click the 2D survey XREF already in the drawing. Block transform applied automatically so all
   spot level coordinates come out in drawing WCS regardless of how the XREF was scaled, rotated
   or moved.
2. (If XREF is flattened / no Face3D data) Pick the raw 3D survey DWG. Plugin reads TIN triangles
   via ACadSharp, matches RL text labels common to both sources, solves the 2D Helmert similarity
   transform, and applies it to the TIN so triangles land in drawing WCS.
   
Real-world result: scale 854×, rotation −28.86° correctly recovered from a client project.
Survey data persisted in drawing NOD — survives close/reopen.

- `Commands/CdSurveyCommand.cs` — completely rewritten with two-step flow.
- `Services/SurveyService.cs` — added XREF reading via AutoCAD API (`ReadSurveyFromXref`,
  `CollectEntitiesFromBlock`, `TryCollectFace`, `TryCollectRlText`); transform section
  (`TryDeriveTransformFromSpotLevels`, `MatchSpotLevelsByRl`, `TrySolveSimilarityTransform`,
  `ComputeRmsResidual`, `ApplyTransformToTriangles`); NOD persistence (`StoreSurvey`,
  `TryLoadSurveyPayload`, `LoadSurveyMeta`, `GetStatusText`).
- 17 new unit tests (MatchSpotLevelsByRl, TrySolveSimilarityTransform with identity/translation/
  scale/rotation/combined cases, ApplyTransformToTriangles, TryDeriveTransformFromSpotLevels E2E).

### Track C — PIT dialog ground RL suggestion — **DONE (2026-05-08, confirmed in AutoCAD)**

- `Commands/PitCommand.cs` — insertion point picked BEFORE dialog opens; if Design mode and
  survey loaded, `TryGetRlAtPoint` is called at the insertion point; result pre-fills
  `SurveyRl` on the ViewModel.
- `ViewModels/PitViewModel.cs` — added `SurveyRl`, `SurveyRlNote`, `HasSurveyRl` (computed),
  `UseRlCommand` (copies SurveyRl → CoverLevel).
- `Dialogs/PitDialog.xaml` — "Survey RL" row (italic, secondary colour) with "Use RL" button,
  visible only when `HasSurveyRl` is true.

### Track D — CDS settings: workflow mode + cover level tolerance — **DONE (2026-05-08, confirmed in AutoCAD)**

SURVEY section added to the Advanced Settings dialog (CDS command):
- **Workflow Mode** dropdown: Design (pre-fills cover level with Use RL button) / Markup (RL shown as passive info, no button)
- **Cover Level Tolerance** field (mm, default 100): pits outside this tolerance to be flagged by CDAUDIT
- Settings persist across AutoCAD sessions (saved to user settings JSON)

Files changed:
- `ViewModels/AdvancedSettingsViewModel.cs` — SurveyWorkflowMode, SurveyRlToleranceMm, SurveyWorkflowModeOptions; wired into LoadSettings / TrySaveSettings / ExecuteReset
- `Dialogs/AdvancedSettingsDialog.xaml` — SURVEY GroupBox added; window height 560→660

### Cover level checker (future — Phase 5 wrap-up or Phase 6 prerequisite)

- CDAUDIT sub-check: compare each pit's stored cover level vs nearest survey RL
- Flag pits where difference exceeds `RlToleranceMm` from settings

---

## Phase 6 — Slab and hardstand fall design

*Design confirmed 2026-05-08. Not yet started in code.*

### Background — design decisions confirmed with Tim

- **Fall symbol:** existing "FALL SYMBOL" dynamic block. Attributes: `FALL` (label) and `FALL_GRADE` (e.g. "1:80"). Dynamic properties: `Angle1` (rotation), `Distance1` (shaft length 920mm, fixed), `Flip state1` (flip for text readability).
- **Control point input:** Tim types finished surface RL at each point. Survey RL from Phase 5 available as a shortcut ("Use RL" button).
- **Surface geometry:** TIN (triangulated irregular network) from control points — handles multi-slope slabs. Not a single plane.
- **Survey dependency:** CDSLAB works standalone. Warning issued if no survey loaded.
- **Spoon drains (CDSPOON):** included in Phase 6. Closed polyline drawn by user during command. Spoon drain areas become "island" holes in CDSLAB hatch — no overlap.
- **Hatch layers:** CDSLAB → `"HATCH 21"` colour 21 (same as CE_STRUC_SUITE 21H). CDSPOON → `"HATCH 35"` colour 35.
- **Slab and spoon boundary layer:** `"SLAB PERIMETER"` colour 2 (yellow).
- **CJ/SSC joints:** deferred to Phase 7.

### Track 0 — Fix CDFALL

**What is broken:**
1. `Angle1` fed raw values 0–360°. When it exceeds ~180° the text in the block ("FALL" / grade) appears upside down.
2. Grade format prompt says "1 IN 80" — block attribute holds "1:80" (colon notation).

**Fix:**
- Constrain `Angle1` to `[0, π]`. For angles in `[π, 2π)` subtract π and set `Flip state1 = 1.0` (flipped). For the lower half set `Flip state1 = 0.0`.
- Change prompt hint from `"1 IN 80"` → `"1:80"`.

**Files:** `Commands/FallCommand.cs` only.

### Track A — SlabData model + SlabService (TIN engine)

**New files:**
- `Models/SlabData.cs`
  - `SlabControlPoint` record: `X`, `Y`, `Fsl` (finished surface level RL), `Source` (Manual / Survey)
  - `SlabData` record: `Handle`, `Name`, `SurfaceType` (Concrete / Pavers / Asphalt / Other), `ControlPoints`, `DrainageNodeHandles`, `FallSymbolHandles`, `SpotLevelHandles`, `SpoonDrainHandles`
- `Services/SlabService.cs`
  - `Triangulate(IReadOnlyList<SlabControlPoint>)` → list of TIN triangles
  - `ComputeFallForTriangle(triangle)` → fall direction vector + grade ratio (e.g. "1:82")
  - `FindLowestPoint(triangles)` → lowest point on the TIN surface
  - `CheckDrainsToNode(lowestPt, drainageHandles, toleranceMm)` → bool + nearest node
  - `StoreSlab(db, slabData)` / `TryLoadSlabs(db)` — NOD persistence (same pattern as SurveyService)
- `CE_CVL_SUITE.Tests/Services/SlabServiceTests.cs` — TDD first

**Surface type minimum falls (loaded from DesignStandards settings, Tim can override):**

| Surface type | Minimum fall |
|---|---|
| Concrete | 1:100 |
| Pavers | 1:50 |
| Asphalt | 1:67 |
| Other | 1:100 |

### Track B — CDSLAB command

**New files:** `Commands/SlabCommand.cs`, `ViewModels/SlabViewModel.cs`, `Dialogs/SlabDialog.xaml` + `.xaml.cs`

**Workflow Tim sees in AutoCAD:**
1. Type `CDSLAB`
2. If no survey loaded: `[CE] No survey loaded — run CDSURVEY first for ground RL suggestions. Press Enter to continue.`
3. `Select slab boundary polyline (or N to draw new):` — select closed polyline, or N to draw one
4. `Pick control point 1 (Enter when done, min. 3):` — click point. If survey loaded: `Survey RL: 25.340 — press S to use, or type value:`. Enter RL.
5. Repeat for each control point. Enter to finish.
6. Dialog opens: name, surface type, min fall (auto-filled), nominate drainage pit(s)
7. Click OK — TIN calculated, fall symbols + spot levels placed, drainage check runs, results on command line

**Layers used:**
- Slab boundary polyline: `SLAB PERIMETER`, colour 2
- Fall symbols: `25CONT` (existing, same as CDFALL)
- Spot levels: `25DIMS` (existing, same as SL command)
- Slab hatch: `HATCH 21`, colour 21, sent to back
- CDSPOON islands automatically excluded from slab hatch at OK time

### Track C — CDSPOON command

**New file:** `Commands/SpoonCommand.cs` (or added to `SourceBlockInsertCommands.cs`)

**What Tim does:**
1. Type `CDSPOON`
2. `Pick spoon drain outline points (C to close, U to undo):` — freeform closed polyline, minimum 3 points
3. `C` closes and places the spoon drain

**What the plugin creates:**
- Closed polyline on `SLAB PERIMETER`, colour 2 (yellow), linetype CONTINUOUS
- SOLID hatch on `HATCH 35`, colour 35, associative to the polyline, sent to back

**Integration with CDSLAB:** any CDSPOON polylines detected inside a slab boundary at CDSLAB dialog OK time are automatically registered as `SlabData.SpoonDrainHandles` and used as island boundaries for the slab hatch.

### Track D — Drainage validation

After fall symbols placed, runs automatically:
- Finds the slab's lowest control point
- Searches `ProjectData` for pits / TGs / raingardens within `RlToleranceMm` (from CDS settings, default 2000mm) of the low point
- Prints result: `[CE] Slab "Driveway" — low point drains to P3 (fall 1:82) ✓`
- Or: `[CE] Warning: Slab low point — no drainage node within 2000mm`
- Plugs into `DesignValidationService` from Phase 3

### Track E — Reactor (deferred)

Grip-edit a slab control point → recalculate TIN → update fall symbols and spot levels in place.
Same reactor pattern as pipe annotation reactor from Phase 1.
**Hold until Tracks A–D confirmed in AutoCAD.**

### New layer constants to add to LayerService

```
LAYER_SLAB_PERIMETER = "SLAB PERIMETER"   colour 2 (yellow)
LAYER_SLAB_HATCH     = "HATCH 21"          colour 21
LAYER_SPOON_HATCH    = "HATCH 35"          colour 35
```

### What Tim tests in AutoCAD (Track 0 — CDFALL fix)

1. Type `CDFALL`, pick insertion point, pick direction point to the RIGHT → arrow points right, "FALL" text readable (not upside down)
2. Repeat pointing UP → readable
3. Repeat pointing DOWN-LEFT → readable (this was the failing case before)
4. The grade prompt now shows "e.g. 1:80" — type "1:100", confirm attribute shows "1:100"
5. Check all four quadrant directions produce readable text

### What Tim tests in AutoCAD (Tracks A–D)

1. Type `CDSLAB`, draw or select a rectangular slab boundary
2. Pick 4 corner control points, type RLs with one corner 50mm higher than the rest
3. At dialog: name "Test Slab", surface Concrete, nominate P3 as drainage pit
4. Click OK — confirm fall symbol appears pointing toward the low corner, spot levels at each corner, grade is approximately correct
5. Type `CDSPOON` within the slab, draw a small closed polyline — confirm yellow outline + colour 35 hatch
6. Run CDSLAB again on the same slab, confirm hatch has a hole where the spoon drain is
7. Check command line reports drainage check result

---

## Phase 7 — Slab joint auto-placement (CJ/SSC)

*Not started. Prerequisite: Phase 6 complete and confirmed in AutoCAD.*

### Engineering intent

After CDSLAB and CDSPOON define the slab geometry, Phase 7 auto-places construction joints (CJ) and saw-cut joints (SSC) according to AS 3600 and NCC rules, making logical decisions about where concrete is most likely to crack.

### Key rules (AS 3600 / NCC)

- Construction joints (CJ): maximum 30m apart, at end of each pour
- Saw-cut joints (SSC): typically 3–6m apart for suspended slabs on ground; panel dimensions should not exceed L/D ratios in AS 3600 Sect. 9
- Joints run through or adjacent to re-entrant corners — highest cracking risk, must be addressed first
- Joints align with pit openings, TG edges, and spoon drain edges — these are natural discontinuities
- No "T-junction" joint intersections where avoidable — cross-shaped or "+" intersections are preferred

### Standalone in CE_CVL_SUITE — no CE_STRUC_SUITE dependency

CJ and SSC geometry will be recreated within CE_CVL_SUITE. This means:
- No runtime dependency on CE_STRUC_SUITE being loaded
- CE_CVL_SUITE owns the CJ/SSC line style, layer, and linetype logic for slab joints
- A new `ConcretePanelService` in `Services/ConcretePanelService.cs` holds all placement logic

### New service — ConcretePanelService

Inputs: `SlabData` (boundary, control points, spoon drain handles, pit/TG handles from `ProjectData`)

Outputs: list of `JointLine` (start pt, end pt, joint type = CJ or SSC)

Logic sequence:
1. Detect re-entrant corners in the slab boundary polyline
2. Radiate a joint from each re-entrant corner bisecting the interior angle
3. Snap joints to nearest pit / TG / spoon drain edges where within tolerance
4. Fill remaining interior with parallel SSC lines at configured spacing
5. Add CJ lines to divide any panel whose longest dimension exceeds 30m

### New CDJOINT command

- Runs `ConcretePanelService` on a selected slab (picked from `SlabData`)
- Previews proposed joint lines
- Places accepted lines on correct layers: CJ on `"CONSTRUCTION JOINT"`, SSC on `"SAW CUT"`
- Colours and linetypes to match CE drawing standards (details TBD at Phase 7 design)

### Settings

New section in CDS Advanced Settings:
- Max CJ spacing (default 30000mm)
- Max SSC spacing (default 4500mm)
- Re-entrant corner joint tolerance (default 500mm snap to nearest discontinuity)

---

## Mandatory rules for all phases

- **Pre-flight before editing** — summarise files+changes per track, wait for explicit go-ahead
- **One phase at a time** — do not start Phase N+1 until Tim confirms Phase N tested in AutoCAD
- **AutoCAD terms** — explain every change in terms of what Tim will see, not code terms
- **Test checklist after every change** — specific steps to verify in AutoCAD
- **Never create new build scripts** — use `Installer\build_installer.ps1` and `Deploy-Local-AsAdmin.ps1`
- **Never modify** — `bin/`, `obj/`, `corpus/`, `Installer/payload_build/`, `temp/accore/`
- **Bug workflow** — write failing test → fix → verify passes → add REGRESSION_LOG entry
- **No mutations** — create new objects, never modify in-place

---

## Build and test commands

```powershell
# Full build (both targets)
pwsh -File Installer\build_installer.ps1

# Deploy to AutoCAD for testing (AutoCAD must be closed, run as admin)
pwsh -File Installer\Deploy-Local-AsAdmin.ps1

# Run tests
dotnet test CE_CVL_SUITE.Tests\CE_CVL_SUITE.Tests.csproj
```

---

## Current test count (as of 2026-05-08 — Phase 5 Tracks A–C)

559 tests, all passing (net48 + net10.0-windows, 0 failures).

---

## Session 2026-05-07 — CDEDIT command wiring

### What changed
- `HubCommands.cs` — CDEDIT now calls `PipeEditCommand.EditPipe()` and `PitEditCommand.EditPit()`
  directly (inline) instead of via `SendStringToExecute`. This means pressing Enter after a CDEDIT
  correctly repeats CDEDIT (not PIPEEDIT or PITEDIT).
- `PipeEditCommand.cs` — command registration restored to PIPEEDIT (was incorrectly renamed to
  CDEDIT in a prior session, which created a duplicate registration that prevented PIT and
  PITSCHEDULE from loading).
- `PitScheduleBuilder.cs` — inlet/outlet fallback fixed: terminal downstream pits no longer shown
  as having an OUTLET when all connected pipes flow into them.
- `CdCommand.cs` — user-facing tip updated from "use PIPEEDIT" to "use CDEDIT".
- Build and deploy: must always run `build_installer.ps1` THEN `Deploy-Local-AsAdmin.ps1`.
  Running only the deploy script pushes stale payload_build content.

### Confirmed working in AutoCAD (2026-05-07)
- CDEDIT → click pipe → pipe edit dialog ✓
- CDEDIT → click pit → pit edit dialog ✓
- PIT → pit placement dialog ✓
- PITSCHEDULE → schedule dialog ✓
- P2 inlet/outlet direction ✓ (pending full test of schedule)

---

## Session 2026-05-07 — Phase 2 Track B: explicit pit ownership

### What changed
- `Services/LinkService.State.cs` — added `ExplicitFromPitId` and `ExplicitToPitId` fields to
  the private `PipeLinkData` class. These store the pit IDs written at pipe creation time and
  survive the geometry re-snap that runs afterwards.
- `Services/LinkService.Registration.cs` — new `SetExplicitPipeOwnership(pipeId, from, to)`
  public method. Writes explicit IDs into the pipe's XRecord then immediately re-runs
  `LinkPipeEndpointsToPits` so ProjectData reflects the correct owners before the command ends.
- `Services/LinkService.RepairAudit.Linking.cs` — new `ApplyExplicitPitOwnership` helper called
  inside `LinkPipeEndpointsToPits` after the geometry scan. If explicit IDs are present they
  override whatever the geometry scan found. New `BuildOwnerFromPitId` helper resolves a pit ID
  string to a full `OwnerMatch` (with real ObjectId if the pit is still in ProjectData).
- `Commands/CdCommand.cs` — after `TryAddPipeToSchedule` writes to ProjectData, calls
  `SetExplicitPipeOwnership` with the `startPitId`/`endPitId` strings captured at snap time.
- `CE_CVL_SUITE.Tests/Services/OwnershipTests.cs` — new test file (TDD RED then GREEN). Contains
  one runnable API-existence test and five [Ignore] integration tests for manual AutoCAD
  verification.

### Confirmed working in AutoCAD (2026-05-07)
- Draw pipe P3→P5, open PITSCHEDULE — From=P3, To=P5 ✓
- PIPEEDIT that pipe, change diameter — From/To still P3, P5 (no re-snap) ✓
- Two pits 300mm apart, draw pipe between them — correct IDs (not swapped by proximity) ✓
- Close and reopen drawing — all data intact ✓

---

## Parking lot (carry forward to next session)

Full detail for all items is in **`docs/PARKING_LOT.md`**. Summary:

| ID | Item | Priority | Safe now? |
|----|------|----------|-----------|
| PARK-001 | BUG-047 Class D pit persisting | P1 Bug | ✅ |
| PARK-002 | Detention pit rotates on CDEDIT | P1 Bug | ✅ |
| PARK-003 | NOD lock messages flooding command line | P1 Bug | ✅ |
| PARK-004 | PITSCHEDULE inlet/outlet full test | P2 Correctness | ✅ (test first) |
| PARK-005 | Pit label / cover text reactors | P2 Correctness | ✅ (investigate first) |
| PARK-006 | Grade label auto-detect (1 IN 100 vs MIN.) | P2 Correctness | ✅ |
| PARK-007 | CDS setting for invert mask offset | P2 Correctness | ✅ |
| PARK-008 | Max pipe run length warning (80 m) | P3 Enhancement | ✅ |
| PARK-009 | Rising main enhancements (v2) | P3 Enhancement | ✅ (design first) |
| PARK-010 | Track C — invert propagation cascade | P3 Enhancement | ✅ (design first) |
| PARK-011 | Flat grade / velocity warnings as popup | P3 Enhancement | ⚠ After Phase 3 |
| PARK-012 | Per-invert above/below flip button | P3 Enhancement | ⚠ After Phase 3 |
| PARK-006-X | CDIMPORTXCIVIL full testing | P4 Deferred | ❌ Not now |

Full detail for every item is in **`docs/PARKING_LOT.md`**.
- **Silence NOD lock diagnostic from command line** — `[CD-DEBUG] Save deferred: NOD lock held`
  floods the command window during active selections. Change `LoggingService.Diagnostic` for this
  specific message to log-file-only output. The retry logic (BUG-071/072) is unaffected.
  Safe 5-minute fix once Phase 3 is confirmed in AutoCAD.

---

## Session 2026-05-07 — Phase 3: validation wiring into CDEDIT

### What changed
- `Commands/PipeEditCommand.cs` — in `UpdatePipeFromViewModel`, immediately after `UpdatePipeSchedule()`,
  builds a `PipeValidationInput` from the values already in scope (diameter, material, inverts, pipe
  length) and calls `DesignValidationService.ValidatePipe()`. Each returned warning is printed to the
  AutoCAD command line as `[CE] Warning: …`. Pumped pipes (material contains "RISING" or "CHARGED")
  set `IsGravityPipe = false` so grade and reverse-fall checks are skipped. Simple-pipe-only mode
  also skips validation (no invert data present). No new using statements needed.
- `CE_CVL_SUITE.Tests/Services/AnnotationSystemTests.cs` — 6 new tests added:
  - 2 pure unit tests: `InvertText_TopPosition_PlacesAnnotationAbovePipe` (confirms DefaultSide="Top")
    and `InvertText_BottomPosition_IsOppositeOfDefault` (confirms "Top"/"Bottom" are distinct keys)
  - 4 `[Category("AutoCAD")]` integration tests documenting expected mask/position behaviour for above
    and below invert positions with and without background fill

### Build result
- 0 errors, 10 pre-existing warnings (unchanged)
- 444 tests total, 0 failures (net48 + net10.0-windows)

### Awaiting AutoCAD confirmation
- Must confirm before starting CDTRACE or network-aware CDPROFILE
