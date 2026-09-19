# Stage D Current-Drawing Boundary — Independent Audit Handoff

> ## ⚠ STATUS — READ THIS FIRST (updated 2026-08-03, after the audit was written)
>
> **§2 / B1 is CLOSED. Do not action it.** Between the audit and this note, the Control Room
> committed `177e539 "Complete Stage D current-drawing pit-on-pipe boundary"` on
> `codex/drainage-redesign-spec`. `MinimumSpanLength = 5.0` no longer exists. It was replaced by
> `PitOnPipeClearSpanService.LeavesPositiveClearSpans(...)` driven by `TryProposedPitHalfExtent`
> and `TryEndpointPitHalfExtent` for both ends, with extents projected along the pipe axis via
> `TryProjectedHalfExtent` (so rotation is handled), and `IsTooShortForTwoSpans` is now set from
> `!hasPositiveClearSpans` at reader line 290. That is the fix §2 specified, with ruling 1 applied.
> Wiring `IsTooShortForTwoSpans` also gives that flag its first production producer, which closes
> part of **N6**.
>
> **The B1 fix is now VERIFIED.** Read-only re-audit 2026-08-03 against
> `codex/drainage-redesign-spec` @ `177e539` (working tree still dirty at the time). All three
> open questions closed — see **§10** for the evidence. One **new latent defect of the same
> class** was found in the fix (**B2**, SPS/pump pits) — see §10. B2 cannot occur today because
> `PitOnPipeProposedPitDraft` is not constructed anywhere in production; it goes live the moment
> Stage G wires PIT/PP.
>
> **Every line reference in this document is stale.** The audit was taken against base
> `ed3f13d9` plus its uncommitted working tree. Files have since grown — the geometry guard moved
> from line 714 to 919. Treat all `file:line` references as *approximate locators*: search for the
> named method or constant, do not jump to the number.
>
> **Still live and unaffected by the B1 fix:** §3 (Tim's three rulings — rulings 2 and 3 have not
> been actioned), §4 (both IL proofs recorded sound), §5 (N1–N11 and the four test-suite
> corrections, less the part of N6 noted above), §6 (do-not-touch list and the re-baseline hazard),
> §7 (spec sentence still wrong), §9 (Tim's AutoCAD checklist).
>
> **Verdict as it now stands:** the FAIL in §1 was against B1 alone. B1 is closed and verified,
> so the slice reads as **PASS WITH NON-BLOCKING NOTES** — now including **B2** (§10), which is
> latent rather than live and so does not restore the FAIL.
>
> Everything below this block is the audit exactly as written on 2026-08-03. It has not been edited.

**To:** Codex Control Room, owner of `codex/drainage-redesign-spec`
**From:** independent read-only safety reviewer (Claude), branch `claude/drainage-stage-d-audit-c30934`
**Date:** 2026-08-03
**Audited tree:** `C:\Lisp Files\CE_ACAD_PLUGIN\.codex\worktrees\drainage-redesign-spec`, base commit `ed3f13d9662e6dcc3e5546fc549e032d75175284`, including the uncommitted Stage D working-tree changes as found.

Nothing in that worktree was edited, built, run, reset, stashed or cleaned. No AutoCAD session, bundle, package or `ApplicationPlugins` path was touched. This document is written on a separate branch and must be carried across to you — it is not present on `codex/drainage-redesign-spec`.

**Scope audited:** 4 modified + 10 untracked Stage D files (production and tests), `docs/DRAINAGE_CD_PIT_REDESIGN_SPEC.md`, root `AGENTS.md` / `CLAUDE.md`. No nested agent docs exist under `Modules/`. Corpus and git history were deliberately not inspected.

---

## 1. Verdict

**FAIL** — one blocking finding (B1).

The read-only boundary itself passes and passes convincingly. What fails is a civil-engineering outcome: the geometry gate returns `PreviewReady` for a split point that is physically inside an existing pit.

### What passes

- No `OpenMode.ForWrite`, `UpgradeOpen`, `Commit`, `Erase`, `SetAt`, `LockDocument`, reflection or dynamic dispatch anywhere in the reader.
- Both `using Transaction` scopes abort by disposal; neither commits.
- No `Entity`, `ObjectId`, `Transaction`, `Database` or `Document` escapes either transaction. `PitOnPipeCurrentDrawingCapture` holds only strings, decimals and `FrozenList<T>`. `MultiPlanValidationContext` and `MultiPlanNetworkDocument` are pure POCOs, so nothing AutoCAD-bound survives `TryEngineeringContext`'s transaction.
- `FrozenList<T>` is a genuine private-array copy; `PitOnPipeCollections.FreezeBounded` returns `ReadOnlyCollection<T>`. No lazy enumerable retains drawing state — every `OrderBy`/`Select` is materialised inside the call that creates it.
- XREF, foreign, read-only and locked-layer content is refused before any planning. XREF pipes are structurally unreachable (model-space-only scan).
- REFEDIT is proved inactive four times across the orchestration and fails closed on any non-string system-variable value.
- The frozen ProjectData graph is proven non-aliasing under full nested mutation.
- The two named high-risk IL proofs are sound — see §4.

---

## 2. Blocking finding

### B1 — Critical — split-point span guard is 5 mm and ignores every pit footprint

**Files:**
`Modules/Drainage/Services/PitOnPipeCurrentDrawingCaptureReader.cs:33` — `private const double MinimumSpanLength = 5.0;`
`Modules/Drainage/Services/PitOnPipeCurrentDrawingCaptureReader.cs:769-776` — the guard.

**Mechanism.**

CE drainage drawings are in millimetres. This is not inferred — it is stated in source at `Modules/Drainage/Services/PipeGeometryHelper.cs:58-68` ("this project's drawings are in MILLIMETRES") and corroborated by `TryReadMatchingMline` requiring `Math.Abs(mline.Scale) == row.Diameter` (`PitOnPipeCurrentDrawingCaptureReader.cs:956-961`) against `MlineService.CreateMline`, which writes the diameter in mm straight into `mline.Scale` (`Modules/Drainage/Services/MlineService.cs:44-50`, clamp comment "clamping to 75 mm").

Therefore `MinimumSpanLength = 5.0` is **5 mm**.

The pipe polyline runs **pit centre to pit centre** — `PitData.Position` is the pit's AutoCAD insertion point and pipe length is the straight distance between two `Position` arrays (`PipeGeometryHelper.cs:76-90`). So "5 mm from the end of the polyline" means 5 mm from the *centre* of the neighbouring pit, i.e. deep inside its body.

The proposed pit's `XWidthMillimetres`, `YWidthMillimetres`, `RotationRadians` and `SpsRadiusMillimetres` are read into the draft and written to the ledger (`PitOnPipePreviewPlanner.cs:623-639`) but are never compared against the available span. The two existing endpoint pits' footprints are never read for extent at all — `TryReadEndpoint` (`:855-917`) captures the block reference for evidence only.

**Visible AutoCAD / signed-drawing consequence.**

Existing run: PIT A — 12 m pipe — PIT B, both 600 × 600. Place a new 900 × 900 junction pit 200 mm short of PIT B.

| | |
|---|---|
| Distance to end of polyline | 200 mm |
| CE's test | 200 ≥ 5 → passes |
| CE reports | `PreviewReady`, `UsesTwoSeparatePipeRecords = true`, full topology-split ledger |
| New pit centre vs PIT B wall | 100 mm **inside** PIT B |
| The two pits | physically overlapping |
| "Second pipe" length, face to face | 200 − 450 − 300 = **−550 mm** |

CE states it has previewed two pipe records joined through a new pit. One is minus half a metre long and the two pits are on top of each other. Nothing in the ledger says so, and the effective-length row still reads 12 000 → 12 000 (finding N1).

**Required correction — Tim's ruling applied.**

`MinimumSpanLength` is deleted, not re-tuned. `TryFreezeStraightGeometry` takes the proposed pit draft and, for each side of the split, computes:

```
clear span = centre-to-centre distance
           − (new pit half-extent along the pipe axis, with RotationRadians applied)
           − (existing endpoint pit half-extent along the pipe axis)
```

and refuses when that value is **≤ 0** on either side. Per §3 ruling 1, a positive clear span is sufficient — do not add a minimum band.

Worked check against the example: at 200 mm → 200 − 450 − 300 = −550 → refuse. At 800 mm → 800 − 450 − 300 = +50 → allow.

**The one place this can quietly go wrong.** The reader currently has no path to an endpoint pit's footprint. Where a neighbouring pit's extent cannot be proved, set `capture.IsTooShortForTwoSpans = true` and let the existing planner gate at `PitOnPipePreviewPlanner.cs:545` block. Do **not** default an unknown extent to zero — that silently reintroduces B1.

**Tests required.**

In `Modules/Drainage.Tests/StageD/Pit/PitOnPipeCurrentDrawingPreviewAdapterTests.cs`:

1. 12 000 mm span, split 200 mm from `start`, 900 mm draft pit, 600 mm endpoint pits → `IsReady == false`, reason names the pit footprint.
2. Same geometry, split at 800 mm → `IsReady == true`.
3. Boundary: clear span exactly 0 → refuse; exactly +1 mm → allow.
4. Rotated pit: 900 × 450 draft at 45° → the rotated extent along the pipe axis is used, not the nominal X width.
5. Endpoint pit extent unprovable → `IsTooShortForTwoSpans` set and planner blocks.

---

## 3. Engineering rulings from Tim (authoritative — 2026-08-03)

These are settled. Implement them as written; do not re-open.

| # | Question | Ruling | Consequence to implement |
|---|---|---|---|
| 1 | Minimum clear span at a new pit | **Positive only** — refuse only when the pits touch or overlap | Clear span > 0 as specified in B1. No minimum band, no warning threshold. CE will preview a 50 mm clear span and that is deliberate — CE guarantees the geometry is possible; buildability stays the engineer's judgement at the drawing. An amber band under some width is an additive change for later, not part of this fix. |
| 2 | Conflict wording | **"On plan / In record"** | Replace `"Program decision="` / `"Engineer Override="` in `PitOnPipePreviewPlanner.cs:524-528`. Rename the carrier properties if you prefer, but the *displayed* words must name where each number lives. Update `PitOnPipePreviewPlannerTests.ConflictingManualEvidence_NeedsReviewAndPreservesBothSides` accordingly. |
| 3 | Compatibility-mode fallback | **(b) proceed with a visible Needs Review note** | Do not refuse, do not stay silent. Carry the resolution status onto the capture and raise a Needs Review finding when `EngineeringPipeResolutionStatus.Compatibility` was used. |

---

## 4. The two named high-risk proofs — both sound

Recorded so you do not have to re-derive this.

### TryEngineeringContext cached-delegate lane

`ValidateExactTryEngineeringContextCachedDelegateLanes`, `PitOnPipeCurrentDrawingReadContractTests.cs:23865`.

Independently seals: caller name + declaring type + attributes + signature blob; raw-IL SHA-256 of the whole body; 199 instructions ending at 526; **both** exception regions (finally 33/466/499 and catch 21/488/509 resolving to `System.Exception` by namespace and name); separate `<>9__10_0` / `<>9__10_1` cache fields with distinct field-signature blobs and `FieldAttributes` 22; distinct `<TryEngineeringContext>b__10_0` / `b__10_1` predicates with exact definition signatures; `Func\`2` constructor MemberRef blob `2002011C18` with `TypeSpecification` parent, resolved in **System.Runtime**; `Enumerable.Select` / `Enumerable.Where` MethodSpecs in **System.Linq** with exact generic arguments (`MultiPlanValidationIssue`+`String` / `String`) and exact module token `0x2300000c`; dup/brtrue/pop topology at 383-387 and 419-423 with branch targets pinned to 409 and 445. Proof gates start empty and are asserted `!= 0` before any predicate returns true. Negative synthetic probes cover foreign MVID, other caller, offset+1, cross-lane token, cross-lane cache field, cross-lane Func ctor, cross-lane MethodSpec, and `ldvirtftn` impersonating `ldftn`. No expected value is derived from the candidate.

**One structural note, not a defect.** `RawIlHash(callerBody)` is checked at `:23913`, *before* the lane-specific checks at `:23996-24141`. Every IL-byte hostile therefore terminates at "complete body/instruction inventory drifted", so the dup/brtrue/pop assertions at `:24108-24124` are proved only redundantly by the body hash and cannot be reached independently by any hostile in this suite. The test's own expected diagnostics declare this honestly, so it is not hidden — but if you want the topology rule independently exercised, move the body-hash check after the lane validation, as the BuildIntegrity lane already does.

### BuildIntegrity conflict-list lane

`ValidateExactBuildIntegrityFreshConflictListLane`, `PitOnPipeCurrentDrawingReadContractTests.cs:24192`.

Independently proves every point on the brief: a fresh `List<PitOnPipeEvidenceConflict>` is constructed at IL_0000 with exactly one `stloc`; a stack-producer walk shows the local is consumed at exactly offsets 6, 35 and 71 and nowhere else, with no `Dup`, `starg*`, `stfld`, `stsfld`, `stobj`, `stind*`, `stelem*` or address-of anywhere in the body, so the list neither escapes nor is borrowed; a full `MethodDefinitions` sweep proves `helperReferenceCallers.SequenceEqual([BuildIntegrity])`, i.e. only `BuildIntegrity` references the helper; the helper receives that exact local at both approved call sites (offsets 30 and 59); the helper contains exactly one `newobj` and one `callvirt` with a pinned 7-edge inventory; `ldarg_0` at offset 33 is proved to be the `Add` receiver by stack-producer walk; the `Add` target is `ICollection\`1<PitOnPipeEvidenceConflict>.Add` in **System.Collections** with MemberRef blob `2001011300` and TypeSpec blob `1512831501128F98`; the single constructed conflict at offset 53 is proved to be the value passed to `Add`; and the same local feeds the immutable `PitOnPipeIntegrityEvidence` constructor at offset 72. Body hashes are checked **after** the escape analysis, so the specific "conflict list was borrowed, escaped, or consumed through an unknown argument" diagnostic is genuinely reachable — verified by the one `RejectWithExactDiagnostic` case.

---

## 5. Non-blocking findings, in the order they should be fixed

| # | Sev | File / line | Summary |
|---|---|---|---|
| N1 | High | `PitOnPipePreviewPlanner.cs:853-854`, `:866-880` | The `EffectiveLength` retain row emits `Proposed = Current`, and `Current` is the **pre-split** whole-pipe centre-line length from `pipe.Length` (`Reader:1271-1275`). A reviewer sees "24 000 → 24 000" for a pipe being cut in two. Deferring the new lengths to Redesign is contract-correct; echoing the old length in the *Proposed* column is not. Emit an explicit "Not determined in Preview; Redesign resolves" token for length-bearing retain rows. |
| N2 | Medium | `Reader:1334-1352` | A protected invert with **both** values empty manufactures a self-equal `<missing>`/`<missing>` conflict (the guard at `:1338` demands both non-empty to suppress), which the planner then rejects at `PitOnPipePreviewPlanner.cs:503-509` as "incomplete or invalid" — a corruption-flavoured hard block for a pipe whose only fault is a stale override flag. Return early when both are empty. Untested today: the adapter tests cover empty-engineer-value at `:377` but not both-empty. |
| N3 | Medium | `Reader:405-419`, `:620-631` | Compatibility-mode fallback is silent. `UseCompatibilityContext` returns `true` with a synthetic empty document; `EngineeringPipeResolver.ResolveByHandle` takes the legacy path (`EngineeringPipeResolver.cs:26-27`) setting `IssueCodes = ["CV01J_COMPATIBILITY_MODE"]` and `IsCompatibilityMode = true`; `CanUseForEngineering` accepts it (`EngineeringPipeSnapshot.cs:48-51`); none of it reaches the capture. Fix per ruling 3. |
| N4 | Medium | `PitOnPipeCurrentDrawingPreviewAdapter.cs:36-90` | The two reads run back-to-back on one thread with only `ReferenceEquals` checks between them. They prove reader determinism, not concurrency safety, and cannot catch an edit between preview and accept. Record this in the spec so Stage G does not mistake the double read for the staleness guard — the Apply-time re-freeze is still required. |
| N5 | Medium | `Reader:573-643`, `:668-706`, `:1055-1192` | Model space is walked three times per capture, six times per preview. `TryFindCandidate` never breaks early; `IsReferencedSecondary` has no counter of its own and performs a full bounded Xrecord read **plus a full Newtonsoft deserialize of PIPE_LINK for every polyline in the drawing**. On a 2 000-pipe job that is ~4 000 deserializations per preview. Not a correctness fault; it will decide whether the Stage G command is usable. Cache `{handle → link}` in a single pass. |
| N6 | Medium | `Reader:1307-1325` | `BuildIntegrity` only ever populates `Conflicts`. `IsStale`, `HasDuplicateIdentity`, `HasAmbiguousIdentity`, `HasMissingOwner`, `HasMissingEndpoint`, `HasBrokenLinks`, `HasBrokenAttachments` and all five geometry flags keep their `false` defaults — the reader blocks earlier with a text reason instead. Consequently `PitOnPipePreviewStatus.RepairHandoff` (`Planner:162-170`) and every geometry gate (`Planner:540-554`) are **unreachable from AutoCAD** and exercised only by hand-built test captures. Fail-safe, but the spec's claim that broken links route to Repair is not true of the production path. Either wire the producer or record the gap. |
| N7 | Low | `Adapter:159-172` | `IsReady` conflates `Blocked` with `NeedsReview`. A `NeedsReview` result carries a complete valid ledger plus both sides of the conflict — exactly what the contract wants shown — yet is indistinguishable from a hard block to any consumer reading `IsReady`. Surface `Preview.Status` on the result before Stage G wires a UI. |
| N8 | Low | `Adapter:227-231` | Each provisional identity's `completeBeforeState` is the UTF-8 of `{identity, currentExists:false}` — derived from the identity string it is meant to prove absent, so it proves nothing about the drawing. Mitigated: `TryResolvePipeRow:842-843` independently refuses a proposed pit ID already present in ProjectData. Nothing checks for an existing pit *drawing object* at the proposed point. |
| N9 | Low | `Reader:31`, `:769`, `:1585-1586` | `PointTolerance = 0.001` is 1 µm. Fine for an osnap-Nearest pick; a typed or rounded coordinate fails and surfaces as the misleading "Exactly one local canonical CE pipe must cross the proposed pit point." |
| N10 | Low | `Reader:1340-1343` | Conflict comparison is `StringComparison.Ordinal` while the rest of the reader uses `Same()` (trim + `OrdinalIgnoreCase`, `:1627`). `"100.250"` vs `"100.250 "` becomes a spurious Needs Review. |
| N11 | Low | `Planner:524-528` | Superseded by ruling 2 — fix as part of that change. |

### Test-suite corrections (no production change; do these last, in the same re-baseline)

- `PitOnPipeCurrentDrawingReadContractTests.cs:1436-1464` — 9 of the 11 BuildIntegrity hostiles assert only `Does.Contain("BuildIntegrity").Or.Contain("AddProtectedInvertConflict")`. Every diagnostic in that lane contains one of those names, so the matcher cannot distinguish which rule fired. Convert all nine to `RejectWithExactDiagnostic`.
- `PitOnPipeCurrentDrawingReadContractTests.cs:1676-1686` — the control text claims the dup/branch topology rule but the asserted diagnostic is the generic body-inventory message. Either reorder per §4 or restate the control text honestly.
- `ReplaceAllAscii(hostile, "<>9__10_0", …)` rewrites a deduplicated string-heap entry, so it mutates every field of that name in the assembly at once. Over-broad by construction; the exact-diagnostic assertion still pins which validator answers, so this is a note, not a fix.
- `PitOnPipeTrustedBoundaryContractTests.Adapter_HasExactDirectReaderAndPlannerEdges` and `Adapter_OrchestrationOrder_IsExact` are **source-text substring counts** on net48 (compiled-metadata-bound only on net8+). Commented-out or string-literal occurrences would satisfy them.

---

## 6. Files that must not be touched

`Modules/Drainage/Services/PitOnPipeCurrentDrawingJsonSnapshotSerializer.cs` — property order **is** the V1 drawing-revision contract. Any edit invalidates every recorded `DrawingRevision`, every golden JSON test and every provisional-identity hash.

`Modules/Drainage/Services/MultiPlanNetworkJsonContractValidator.cs` — the hardening is sound (bounded per-property array counts, exact schema-version gate, LINQ removed from the hot path). Its one behaviour change — rejecting any schema that is neither `1.0` nor current, where previously any non-legacy string was treated as current — is a correct tightening and is covered by `BlankUnknownFutureOrCaseVariantSchema_IsRejected`.

`Modules/Drainage/Services/LinkService.PitOnPipeReadOnly.cs` and `Modules/Drainage/Engineering/Pit/PitOnPipePreviewContracts.cs` — no findings against either.

### Re-baseline hazard — read before your first edit

The 59 000-line proof suite hard-codes metadata tokens (`0x001e77` TryEngineeringContext, `0x001e88` BuildIntegrity, `0x001e89` AddProtectedInvertConflict, `0x0054dd`/`0x0054de` the lambdas, plus field, MemberRef, TypeSpec and MethodSpec tokens), raw IL offsets, Roslyn-generated names (`<>9__10_0`, `<TryEngineeringContext>b__10_0`), raw-IL SHA-256s, and per-TFM boundary-snapshot hashes.

**Any** production edit anywhere in the Drainage assembly shifts MethodDef/MemberRef row order and invalidates all of it. The suite fails closed, which is correct — but plan for one large re-baselining pass, and batch your production changes so you do it once rather than four times. A green net10 run does not imply green net48/net8: the boundary-snapshot hashes are per-TFM.

---

## 7. Build, test and commit status

- **Safe to build and test:** yes. Nothing in this slice touches a drawing writer, ProjectData writer, installer or bundle. Use `-p:SkipDevBundle=true` on every `dotnet build` and `dotnet test`, per the root `AGENTS.md` bundle-deploy hard rule. Do not deploy from this or any parallel session.
- **Safe to commit:** yes, as an isolated preview-only slice. Nothing here can reach a signed drawing.
- **Not safe to advertise as Stage D pit-on-existing-pipe complete**, and **not safe to wire into a command or UI**, until B1 is closed.
- **Spec correction owed:** `docs/DRAINAGE_CD_PIT_REDESIGN_SPEC.md`, "Current implementation checkpoint — 2026-08-01". The Stage D paragraph claims the planner "previews the two resulting pipe records joined through the new pit". Qualify it: no span length, IL, grade or arrow is previewed for either resulting span (deferred to Redesign by contract), and the Repair-handoff lane has no production producer (N6).

---

## 8. Recommended order of work

1. **B1** — geometry clear-span guard. The only finding that can put a wrong engineering outcome in front of Tim.
2. **N2**, then **N3** (ruling 3). Both change what the engineer is told; both are one-branch fixes.
3. **N1**, **N11/ruling 2**, **N7** together — ledger wording, conflict wording, result surface.
4. **N6** plus the §7 spec correction — decide whether to wire the reader to the planner's dormant gates or record them as pending.
5. **N5** — single-pass model-space read. Do this before Stage G wires a command, not after.
6. §5 test-suite corrections, folded into the same re-baseline.

---

## 9. What Tim should test in AutoCAD once B1 lands

He cannot test any of this until the preview is wired to a command, so this is the checklist to hand him at Stage G — not now.

1. Draw a 12 m pipe between two 600 × 600 pits.
2. Try to place a 900 × 900 pit **200 mm** from one end → expect a refusal whose wording names the pit footprint, not a generic "cannot find one pipe".
3. Place the same pit at **800 mm** from that end → expect a preview.
4. Place it at the **midpoint** → expect a preview.
5. Repeat 2–4 with the pit **rotated 45°** — this is where the "extent along the pipe axis" maths earns its keep. A 900 × 450 pit at 45° presents a different width to the pipe than it does square-on.
6. Edge cases worth including: a pit placed so its wall exactly touches the neighbouring pit's wall (clear span 0 → expect refusal, per ruling 1); a pipe with no PIPE_LINK record; a pipe on a locked layer; a pipe inside an XREF (expect refusal in every case).
7. On a drawing with no CV-01J multi-plan record → expect a preview **with** a visible Needs Review note about legacy identity (ruling 3), not a silent success.

---

## 10. B1 verification — added 2026-08-03

Read-only re-audit of `codex/drainage-redesign-spec` @ `177e539`, working tree still dirty (5
modified files) at the time. Nothing was edited, built or run. Everything in §§1–9 above predates
this section.

### 10.1 The fix as built

`MinimumSpanLength = 5.0` is gone. In its place:

- `Modules/Drainage/Engineering/Pit/PitOnPipeClearSpanService.cs` — new AutoCAD-free service,
  explicitly documented as working in drawing millimetres.
  - `TryProjectedHalfExtent(w, h, footprintRotation, pipeAxisRotation, out halfExtent)` returns
    `0.5 × (|cos θ| × w + |sin θ| × h)` where `θ = pipeAxisRotation − footprintRotation`. This is
    the correct support function for an oriented rectangle projected onto the pipe axis.
  - `LeavesPositiveClearSpans(startToSplit, splitToEnd, proposedHalf, startHalf, endHalf)`
    requires `startToSplit − proposedHalf − startHalf > 0` **and**
    `splitToEnd − proposedHalf − endHalf > 0`, strict.
- Reader call site: `hasPositiveClearSpans` is computed once, and the capture carries
  `IsTooShortForTwoSpans = !hasPositiveClearSpans`. The planner then blocks with the reworded
  finding *"The new pit footprint must leave a positive clear pipe span to each endpoint pit."*
  (the old "pipe is too short" wording would have been wrong for the overlap case).

Distances are `start.DistanceTo(splitPoint)` and `splitPoint.DistanceTo(end)`. These equal the
along-axis distances because `TryFreezeStraightGeometry` has already proved the pipe is a straight
two-vertex polyline and the split point lies on it within `PointTolerance`.

### 10.2 The three open questions — all closed

| Question from §2 | Result | Evidence |
|---|---|---|
| Fail-closed when a neighbouring pit's extent cannot be read | **PASS** | `TryReadEndpoint` initialises `halfExtentAlongPipe = double.NaN` *before* the (deliberately discarded) `TryEndpointPitHalfExtent` call; that helper also sets `NaN` before every failure return; `LeavesPositiveClearSpans` rejects non-finite input. `hasPositiveClearSpans` also short-circuits on `TryProposedPitHalfExtent` failure. Unknown extent therefore refuses, never defaults to zero. |
| Exactly-zero boundary | **PASS** | Strict `> 0.0` on both sides. `ClearSpan_RejectsOverlapAndAllowsPositiveGap` pins it to the millimetre: `750.0` against `450 + 300` (clear span exactly 0) → `False`; `751.0` → `True`. |
| Rotated-extent arithmetic | **PASS** | Formula verified by hand. `ClearSpan_ProjectsRotatedFootprintAlongPipeAxis` asserts a 900 × 450 pit at 45° to the pipe gives `477.2970773009196` (= `0.70710678 × 675`), and separately asserts the result is **not** `450.0`, which catches a regression to the nominal half-width. |

§2's five listed tests remain the right *integration* tests; three of them are now covered at
service level by `ClearSpan_*` in `PitOnPipeCurrentDrawingPreviewAdapterTests`.

### 10.3 B2 — NEW — Medium (latent) — SPS/pump pits are measured by the wrong dimension

**Files:** `PitOnPipeCurrentDrawingCaptureReader.cs` — `TryEffectivePitFootprint` vs
`TryProposedPitHalfExtent`.

The two footprint helpers disagree about round pits.

- **Existing endpoint pits** — `TryEffectivePitFootprint` detects a circular pit
  (`PitType` containing `SPS` or `PUMP`, or `Id` containing `SPS`) and overrides the footprint with
  `width = height = SpsRadius × 2`.
- **The proposed new pit** — `TryProposedPitHalfExtent` reads only `XWidthMillimetres`,
  `YWidthMillimetres` and the detention widths. It **never reads `SpsRadiusMillimetres`**, even
  though the draft carries it and `ValidateScope` requires it to be positive.

So `SpsRadius` is authoritative for a round pit on one side of the comparison and ignored on the
other. Place a new SPS or pump pit on an existing pipe and its footprint is taken from X/Y width;
wherever `2 × radius` exceeds that, the new pit is measured smaller than it is, the clear span is
overstated, and an overlapping pit passes. That is the B1 failure mode, narrowed to SPS/pump pits.

**Not live today.** `new PitOnPipeProposedPitDraft(` appears nowhere in production — the draft is
constructed only by tests until Stage G wires PIT/PP. B2 becomes live at that moment.

**Correction.** Give `TryProposedPitHalfExtent` the same circular branch as
`TryEffectivePitFootprint`, driven by `SpsRadiusMillimetres`. Better: extract one shared footprint
resolver used by both sides so they cannot drift again — the drift is the actual defect.

**Tests required.** Proposed SPS pit whose `2 × SpsRadiusMillimetres` exceeds `XWidthMillimetres`,
placed at a distance that is clear on X/Y width but overlapping on radius → expect refusal. Plus a
parity test asserting both helpers return the same half-extent for the same physical pit.

### 10.4 Why B2 was not caught, and the coverage gap behind it

`TryProposedPitHalfExtent`, `TryEffectivePitFootprint`, `TryEndpointPitHalfExtent` and
`TryPipeAxisRotation` have **no test coverage at all**. The three new `ClearSpan_*` tests exercise
`PitOnPipeClearSpanService` directly — the arithmetic is well covered, but nothing tests the code
that decides *which numbers to feed it*, which is exactly where B2 lives.

All four are pure static methods with no AutoCAD dependency, and the same test file already reaches
private reader methods by reflection via its `InvokeReader<T>` helper (used for
`BlockAttributeCountIsWithinLimit`, `RefEditStateAllowsPreview`, `TryScheduleSortKeyOwnsPipe`).
They are testable today.

### 10.5 Two smaller notes

- **Detention asymmetry (Low).** On the proposed side, if only one detention dimension is positive
  the other is left at zero, which makes `TryProjectedHalfExtent` fail and blocks the preview —
  fail-closed, so safe, but a detention pit with no Y width blocks entirely. On the existing side
  the missing dimension falls back to `XWidth`/`YWidth` instead. Same drift as B2; the shared
  resolver fixes both.
- **Shape detection is string sniffing (Low).** Pit shape is decided by searching `PitType` for
  `DETENTION`/`SPS`/`PUMP` and `Id` for `SPS`. A round pit whose type text does not contain those
  tokens is silently treated as rectangular.

### 10.6 Revised state of the fix queue

B1 is closed. §8's order now reads: **B2** first (before Stage G wires PIT/PP, since that is when
it goes live), then N2, N3 (ruling 3), then N1 / ruling 2 / N7, then N6 and the spec correction,
then N5, then the §5 and §10.4 test gaps folded into one re-baseline.

---

*End of handoff. This document lives on `master`; the audit branch that carried it has been merged
and deleted. Line references throughout §§1–9 are against `codex/drainage-redesign-spec` @
`ed3f13d9` plus its then-uncommitted working tree, and §10 against `177e539` — treat every
`file:line` as an approximate locator and search for the named method, not the number.*
