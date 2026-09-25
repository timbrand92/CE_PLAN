# CV-06 — linked longitudinal profile atomic writer

**Status:** Connected managed implementation; native AutoCAD acceptance pending.

## Approved boundary

- One frozen Ready review owns the exact route, ordered pit/pipe identities, known levels, actual centreline lengths, established grade/flow projections, datum, whole-number scales, vertical exaggeration, insertion point, optional display evidence and network revision.
- Create writes one linked profile block and its complete metadata in the caller's transaction.
- Update replaces only the exact reviewed linked profile. A moved insert, changed definition/child, stale network, changed pipe geometry, changed display evidence, locked layer, Xref/REFEDIT content or unsupported target refuses before the first drawing write.
- The existing `ComposeSectionGeometry` method remains the only drawing formula. The strict writer projects the frozen evidence into its existing input rows; it does not recalculate grades, flows, levels or route choices.
- Missing/invalid/non-finite evidence remains **Unknown** and cannot be written as zero. A real reviewed `0.00` level remains valid.
- Missing approved profile layers may be created only inside the same caller transaction after all protection checks. When the pit marker definition is absent, its exact layer 0 and Standard text-style dependencies must already be local and writable. No layer write occurs before that transaction.
- The project-data cache is not changed. The caller commits for one AutoCAD Undo or aborts the whole transaction on any exception.

## Current public path

`CDPROFILE` now selects the starting CE pit and opens the dedicated **Longitudinal Review** page in Calculations V2. **Preview New** and **Preview Update** capture one immutable receipt through `ProfileRouteEvidenceCaptureService`; **Apply** consumes that receipt, recaptures the current drawing evidence and calls `LongitudinalSectionService.ApplyReviewedSectionInTransaction` in the adapter-owned transaction. Only an Applied result commits. The older public `InsertSection` / `UpdateExistingSection` methods remain available internally, but this reviewed page does not use them as a second writer path. No new command was introduced.

## Automated evidence

- Pure authority tests cover true zero, Unknown levels, incomplete pipe evidence, exact datum/scale representation, external cuts and unchanged node count.
- Metadata round-trip tests cover route identities, revision, scales, exaggeration and review/target fingerprints.
- Transaction-boundary checks prove the strict method has no nested transaction, commit or pre-transaction `EnsureLayers` call, and preflights before layer creation or old-profile erase.

## Native AutoCAD acceptance still required

Create and update a representative straight and curved route through `CDPROFILE`, then verify Preview parity, one Undo, Cancel/no-write, stale network/curve/target refusal, locked layer, Xref, REFEDIT and save/reopen metadata. This native check qualifies the connected route; it is not evidence for a second legacy writer path.
