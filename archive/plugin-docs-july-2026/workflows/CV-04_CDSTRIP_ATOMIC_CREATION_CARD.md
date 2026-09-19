# CV-04 — CDSTRIP atomic creation: implementation card

**Status (2026-09-13, branch `codex/claude-civil-continuation`):** **Built** — `StripDrainCommand.cs`
(prompts, transient rubber band, plan preview, Accept), `StripDrainCommand.Plan.cs` (pure plan with the
unchanged corner/end/spacing/two-way rules), `StripDrainCommand.Preview.cs` (transients only),
`StripDrainCommand.Apply.cs` (one caller transaction: layer, FLOOR WASTE definition import if absent,
TIM LEADER scale, MLINE, floor wastes, high-point lines, leaders, SD registration through the shared
snapshot seams, exact readback, `CommitDrawingChange`, publish once) and `Services/StripDrainCreationLifecycle.cs`
(AutoCAD-free runner: Refused / CommitUnknown / CommittedRecoveryRequired / Committed). §4's
"missing seams" were satisfied by existing seams at this base (`LayerService.EnsureLayerInTransaction`,
`ProjectDataService` snapshot write/readback, `SourceTagService.AllocateNextTag(db, tr, …)`) plus one
visibility change (`BlockService.AppendAttributesFromDefinition` private → internal, no behaviour change).
Not Connected-verified natively. Not Native Accepted. Historical planning text follows.
**Reconciled 2026-09-13 against `97cc3511`** (published `codex/first-colleague-integration`): the only
CDSTRIP source difference from the `master` copy this card was written against is the plan-point
admission (`AdmitEditorPlanPoint` / `ToPromptBasePoint` via `CE.Shared.Coordinates.WorldPlanPoint`),
which resolves picks to active host-world XY with Z=0 after nested transforms. §1 "Point handling" and
§3.1 step 1 must keep that helper; nothing else in §2 changed. Transient preview helpers now exist at
this base (`SurfaceOverlayTransientService`, `SlabFlowOverlayService`) and are the reuse candidates for
§3.1 step 3. The shared caller-transaction seams in §4 are still absent at this base and remain a
Control Room request. The reserved Survey Intake / CDSTRIP build itself has not started.
**Authority:** `docs/CARDS/CV-04_SURFACE_DRAINAGE.md` (approved CV4-4, CV4-5, CV4-7, CV4-15);
`docs/CLEAN_SLATE_REBUILD.md` §6.10 rules 1, 2, 3, 5, 6, 11, 12; AGENTS.md native protection rule.
**Written:** 2026-09-13, on this machine's `master` (`0006eb31`), **not** on the frozen integration
head `0ea4e9bf…`. That head, its review base `9357a1bd…`, the integration checkout under
`C:\Lisp Files\CE_ACAD_PLUGIN`, `BUG_CARPARK.md`, `CIVIL_REMAINING_WORLD_PLAN_POINTS_2026-09-10.md`
and `FIRST_COLLEAGUE_ISSUE_2026-09-07.md` do not exist on this machine and are not on `origin`.
Everything in §2 (current route) was read from `master`'s `Modules/Drainage/Commands/StripDrainCommand.cs`
and must be re-confirmed against the frozen head before coding.

This card banks the approved slice as implementation-ready instructions. It invents no engineering
decision: every geometry number and rule below is the existing code's behaviour, retained.

---

## 1. What stays exactly the same (drawing appearance and engineering)

| Item | Kept behaviour (source: current command) |
|---|---|
| Command | `CDSTRIP`, modal, same ribbon/typed entry |
| Prompts | Justification `[Top/Center/Bottom] <Center>`; first point; `Next point [Close/Undo] or Enter to finish` |
| MLINE | `DRAINAGE` mline style if present else current style; scale 100 (100 mm wide); chosen justification; layer `STRIP DRAIN` (ACI 10, CONTINUOUS); Z = 0; open by default; `Close` keyword welds the loop (native `IsClosed`, then appended closing segment if the flag does not take) |
| Vertex `Undo` | Removes the last picked point and its rubber-band segment; `Undo` at one point cancels |
| Floor wastes (FW) | `FLOOR WASTE` block, rotation 0, scale 1, layer `STRIP DRAIN`, at every vertex and at ≤ 12 000 mm centres along each straight run |
| Corner FW rule (CV4-5) | Corner FW sits exactly on the strip centreline intersection for every justification (`ComputeCornerCenterlinePoint`; corner inset 0) |
| End FW rule | Open-run first/last FW pulled 50 mm tangentially inward, any justification (`ApplyVertexInset`) |
| Centreline shift | Top → right perpendicular × 50 mm; Bottom → left × 50 mm; Center → none (`ComputeCenterlineShift`) |
| High-point line | Polyline across the strip body at the midpoint of every FW-to-FW run on the same segment (`EmitHighPointLine`) |
| Fall arrows (CV4-7 two-way default) | Native `Leader` with `TIM LEADER` dimstyle, 600 mm shaft, 200 mm perpendicular offset off the body side; two arrows (¼ toward first FW, ¾ toward second FW) per run; one centred arrow when the run is shorter than 1 300 mm (`EmitFallArrowsForRun`) |
| Arrow direction lock | Shaft parallel to the MLINE segment, never the FW-to-FW diagonal; FW membership by projection within 200 mm (`EmitFallArrowsForSegment`) |
| Registration | Legacy record consumers unchanged: `PitData` with `PitType = "STRIPDRAIN"`, `LidType = "Strip Drain"`, `IncludeInSchedule = false`, `Id = SD<n>` from `SourceTagService.AllocateNextTag(db, tr, "SD")`, `EntityHandle` = MLINE handle, `Position` = first vertex, `CustomRemarks = "Strip drain (<n> vertices)"` |
| Point handling | UCS pick → `DrawingService.TransformToWorld` once; host-world XY kept; Z forced to 0 for the strip's own output only. Never re-levels or flattens picked source, Xref or block geometry |
| Post-commit | `LayerService.ApplyConfiguredDrawOrderForCommand()` and the summary message |

Out of scope, per the task: one-way mode, tank/AGI/FW standalone rebuilds, surface-asset schema
migration (CV4-3), numbering redesign, project-rule controls for the 50 mm / 12 m values (CV4-6),
grips, slab editor, and any formula change.

## 2. Current route (defect being fixed) — as read on `master`

`PlaceStripDrain()` performs **at least five independent committed transactions** plus nested
service commits, so a failure part-way leaves a half-made strip and several Undo steps:

| Step | Where | Committed write |
|---|---|---|
| Pre-prompt | `LayerService.EnsureLayer("STRIP DRAIN")` | Layer created before the user has picked anything; residue on Cancel |
| Rubber-band | `CommitTempSegment` / `EraseTempSegment(s)` | A real `Line` is appended and committed per pick, then erased — each is its own Undo step and leaves erased-entity residue |
| 3 | `CreateStripDrainMline` | Own transaction, commits MLINE |
| 4 | `TryPlaceFloorWaste` → `BlockService.InsertBlock` | Each FW: `EnsureBlockDefinition` (own transaction, may import/reload/patch the definition) + insert transaction; inserts into **model space** regardless of current space; failures are logged and swallowed (`return false`) |
| 5 | `PlaceFallArrows` | `EnsureLeaderDimstyle` (1–2 own transactions, may WBLOCK-clone `TIM LEADER` from Tim's personal template path and rewrite its `Dimscale`/`Dimasz`) then one transaction for lines + leaders; per-entity failures swallowed |
| 6 | `RegisterStripDrain` | Handle read transaction, `SetDrawingPath` (may save/reload project JSON), tag allocation transaction, `AddPit` (in-memory + deferred save) |

Consequences today: Escape after the MLINE commits leaves the MLINE; a missing `FLOOR WASTE.dwg`
yields a strip with zero FWs and zero arrows but a "placed" message; a registration failure leaves
drawn geometry with no record; native Undo needs many steps.

## 3. Expected behaviour after the slice (CV4-15 "one compound, one Undo")

### 3.1 Phases

1. **Collect** (no permanent writes)
   - Justification prompt; vertex loop with `Close` / `Undo` / Enter, identical wording.
   - Rubber-band segments drawn with the shared **transient** preview helper (whatever the frozen
     head provides; `TransientManager`-based). Osnap to the last point is kept by `UseBasePoint`.
     No `Line` is appended to the database.
2. **Prepare** (read-only against the database)
   - Compute the full accepted geometry with the existing pure functions: vertex FW points,
     intermediate FW points, per-segment runs, high-point lines, arrow centres and directions.
   - Resolve resources **without creating them**: `DRAINAGE` mline style id or current style;
     `FLOOR WASTE` file path via `BlockService.GetBlockFilePath` and whether the definition already
     exists; `STRIP DRAIN` layer existence and lock state (`LayerService.IsLayerLocked`); `TIM LEADER`
     dimstyle presence; current space id and whether it is a locked layout/REFEDIT session.
   - Produce a `StripDrainPlan` (immutable): geometry + resource verdicts + guard results.
3. **Preview** (transient only)
   - Draw the MLINE outline, FW markers, high-point lines and arrows as transients.
   - Prompt `Accept/Cancel <Accept>`. Cancel or Escape clears transients and exits; nothing in the
     database, project data or block table changed.
4. **Revalidate** on Accept
   - Same `Document` and `Database` as at collect time (`doc.Database` reference and `doc.IsActive`).
   - Current space unchanged; not in REFEDIT (`db.Filer`/`RefEditing` check the frozen head uses);
     `STRIP DRAIN` still unlocked or absent; definitions and styles still as planned.
   - Any change → message and abort; nothing written.
5. **Commit** in one caller-owned transaction
   - Order inside the single `Transaction tr`: ensure layer (create only if absent; never unlock),
     ensure `FLOOR WASTE` definition (create only if absent, via the shared seam that accepts `tr`),
     ensure `TIM LEADER` (no template import in this slice: if absent, the leaders use the current
     dimstyle as today, recorded in the plan as a warning, not a failure), append MLINE, append every
     FW `BlockReference` with attributes, append high-point lines, append leaders, allocate `SD` tag,
     build `PitData`, register through the caller-transaction seam.
   - **Readback** before commit: every staged `ObjectId` must be non-null and readable; FW count and
     arrow count must equal the plan.
   - Any exception, null id or readback mismatch → `tr.Abort()` (or `Dispose` without `Commit`),
     in-memory project record removed, message names the failed step. No partial success message.
   - `tr.Commit()` exactly once.
6. **Publish** after confirmed commit only
   - Project-data save/refresh, `ApplyConfiguredDrawOrderForCommand`, caches, summary message.

### 3.2 Cancel / Escape / Undo matrix

| Where the user cancels | Result |
|---|---|
| Justification prompt | Exit; no writes, no layer, no transients |
| First point | Exit; no writes |
| Any later point (Escape) | Transients cleared; no writes |
| `Undo` at 1 point | Exit as today ("CDSTRIP cancelled"); no writes |
| Fewer than 2 points at Enter | Exit; no writes |
| Preview prompt Cancel/Escape | Transients cleared; no writes, no layer, no block definition, no dimstyle change |
| Native `U` after Accept | **One** step removes MLINE, all FWs, lines, leaders and (if the shared seam stores it in-drawing) the registration; layer/definition created in the same transaction go with it |

### 3.3 Resources and residue rules

- Layer, block definition and dimstyle are created **only inside the commit transaction**. The
  preview must not create them.
- Block definitions are immutable masters (rule 3): this slice must not reload or patch `FLOOR WASTE`
  when it already exists. If `EnsureBlockDefinition` on the frozen head still reloads/patches, the
  slice uses the transaction-accepting seam instead and notes the deviation.
- Missing `FLOOR WASTE.dwg` **and** no in-drawing definition = missing resource = whole attempt
  fails at prepare time with a clear message (today it silently places zero FWs).
- The personal template path for `TIM LEADER` is not a dependency of this slice (CV4-14 principle);
  absence degrades the arrowhead style only, and is reported.

### 3.4 Protection guards (native protection rule)

- `STRIP DRAIN` layer locked → refuse with message; never unlock.
- Current space is a locked layout viewport, a REFEDIT session or an Xref block table record →
  refuse; never explode/detach/bypass.
- Output always goes to the **current space** (`db.CurrentSpaceId`), not model space, unless the
  frozen head's shared insert seam already fixes model space by design; that difference must be
  recorded, not silently changed.
- Cached authority fallback is not allowed: a stale project-data cache is not a substitute for the
  live drawing.

## 4. Shared seams required (return to Control Room if absent at the frozen head)

Verified **absent on this machine's `master`**; unknown at the frozen head:

| Seam | Required signature | Reason |
|---|---|---|
| Block insert inside caller transaction | `ObjectId BlockService.InsertBlock(Transaction tr, BlockTableRecord space, string blockName, Point3d worldPosition, double rotation, double scale, string layerName)` | Today's overload opens its own transaction and targets model space; cannot be rolled back with the strip |
| Definition ensure inside caller transaction, no mutation | `ObjectId BlockService.EnsureBlockDefinition(Transaction tr, Database db, string blockName, bool createIfMissing)` | Today's overload commits, may reload/patch the master (rule 3), and cannot be part of one Undo |
| Layer ensure inside caller transaction | `ObjectId LayerService.EnsureLayer(Transaction tr, Database db, string name, short color, string linetype)` | Layer must be created in the same Undo step and never before Accept |
| Registration inside caller transaction | `void ProjectDataService.AddPit(PitData pit, Database db, Transaction tr)` + a `RemovePit`/rollback counterpart, preserving drawing-qualified ownership and unknown JSON fields | Today's `AddPit` mutates in-memory state with a deferred save; a later abort leaves a phantom `SD` record |
| Transient preview | The frozen head's existing transient helper (name unknown here) accepting `IEnumerable<Entity>` and exposing `Clear()` | Rubber-band segments and the accept-preview must not be database writes |

If the frozen head already has equivalents (the task says to reuse "existing transient preview and
shared caller-transaction helpers"), consume them; the table is the fallback request only.

## 5. Tests (must fail when the defect exists — rule 11)

Split the command into a pure orchestrator over injected ports so the orchestration runs without
AutoCAD:

```
interface IStripDrainWriter   // implemented by the AutoCAD partial; faked in tests
  Stage(MlineSpec)  → Token     Stage(FwSpec) → Token   Stage(LineSpec) → Token   Stage(LeaderSpec) → Token
  Register(PitData) → Token     Readback(Token) → bool
  Commit()          Abort()
```

| Test | Injected condition | Must assert |
|---|---|---|
| Open L-shape, Center | none | MLINE 3 vertices open; FW at each vertex with 50 mm end inset; corner FW at intersection; arrows per existing math; `Commit` called once, `Abort` never |
| Closed rectangle, Top | `Close` keyword | 4 corner FWs on centreline intersections; closing run gets its own arrows; `IsClosed` requested |
| 25 m straight run | none | 1 intermediate FW at 12.5 m; two runs; 4 arrows; 2 high-point lines |
| Failure after earlier child staged | second FW `Stage` throws | `Abort` called; `Commit` never; `Register` never; message names FW step |
| Missing FW definition | `GetBlockFilePath` null and definition absent | Prepare fails; no `Stage` at all; no preview shown |
| Readback mismatch | `Readback` false for one leader | `Abort`; no publish |
| Registration failure | `Register` throws | `Abort`; no drawn output survives; no publish |
| Cancel at each prompt | justification / first point / nth point / preview | Zero writer calls; transients cleared |
| Locked layer | `IsLayerLocked` true | Refuse at prepare; no writes |
| Document changed between preview and Accept | database identity differs | Refuse; no writes |
| Existing `StripDrainInsetTests` | unchanged | still green; they cover the geometry maths, not orchestration |

What cannot be proven outside AutoCAD: real `Mline.IsClosed` behaviour, transient rendering,
native Undo grouping, REFEDIT detection, and the `TIM LEADER` arrowhead appearance. Those stay on
Tim's checklist (§6).

## 6. Tim's AutoCAD acceptance checklist (about five minutes)

1. `CDSTRIP`, Center, three points in an L, Enter. Preview shows strip, FWs, lines and arrows;
   Accept. Then `U` once: everything vanishes together, including the `SD` record in the inspector.
2. Repeat, but press Escape at the preview: no strip, no floor wastes, no `STRIP DRAIN` layer created
   in a drawing that did not have it, and `PURGE` shows no new `FLOOR WASTE` definition.
3. `CDSTRIP`, Top, rectangle with `Close`: corner FWs sit on the strip centreline at all four bends.
4. Lock `STRIP DRAIN`, run `CDSTRIP`: command refuses with a message; nothing drawn; layer still locked.
5. Temporarily rename `FLOOR WASTE.dwg` in the block path on a test drawing with no definition:
   command refuses at prepare, draws nothing.

## 7. Delivery state

- Part A code: **not started on this branch** — the mandated base (frozen head `0ea4e9bf`) is not
  reachable from this machine and the shared seams in §4 are absent on `master`, so a build here
  would be on a mismatched checkout, which the task forbids.
- This card is the banked implementation instruction set for whoever holds the frozen head.
