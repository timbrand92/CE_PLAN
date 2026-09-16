# Civil surface, Properties, discovery and file-helper audit

FOR TIM

All 33 Civil window/control names are mapped. Survey storage must not be confused with approved use of that survey; the new survey finding needs that distinction. Properties and export recovery descriptions match the inspected source.

---

Clock: 2026-09-16 13:39:25 UTC / 23:39:25 Sydney. Planning/source only; no client evidence, installed files, runtime, build, git or AutoCAD operations.

## Findings

| ID / severity | Evidence | Required correction |
|---|---|---|
| CIVS-01 / medium | Civil surface supplement survey sanity row and final gap table calls nonblocking storage a CV7 activation conflict. CdSurveyCommand.cs:149–193 proves sanity then StoreSurvey, not complete downstream activation. | Say candidate-storage-to-activation boundary is unproved in this command. Trace consumer/approval/quality gates before declaring unsafe adoption. Storing suspect candidates can be legitimate; review-before-governing-use remains binding. |
| CIVS-02 / low clarification | SlabCommand.cs:440–480 commits new boundary; existing-boundary path also commits layer reassignment before later prompts. | Keep both visible in cancellation contract: new geometry versus changed layer on an existing boundary. Neither is proven restored by a later dialog Cancel. |

## Actual checks

- Parsed Civil ledger XAML basenames: 33 distinct, all present in new map. Names are not action completeness, native visibility or current installation proof. Configuration/reset controls and code-created consumers remain explicit gaps.
- Survey direct read CdSurveyCommand125–193 confirms combined-source metadata, failed-transform spot-only path, nonblocking sanity and store. Did not trace consumer in this delta; do not certify safety or unsafety of later adoption.
- SlabCommand109–137 confirms user-facing FSL default0.0 text;440–480 confirms early geometry/layer commits. This does not independently verify every slab import scan/regeneration line cited by planner. Canonical Unknown requirement remains target. Native protections/Undo remain unknown.
- Exact44b2 CePropsDialog20–81 and CeDrawingPropertiesService38–88,110–219 substantiate drawing-first blank filling, manifest default-on/sync-off, dialog acceptance only, drawing-memory write before manifest, matching-DWG all-sheet revision/date and optional project sync. Root12 correctly separates ordinary properties from verified issue history and partial save effects.
- Root discovery direct reads CommandPaletteWindow35–104,177–213 and CommandsPanel164–189,294–355 substantiate expert-inclusive visible search/ranking/cap12, queued command on close, saved personal pins cap24 and recents cap16, missing/hidden favourite omission. Queue/recent is not completed command evidence. Escape/loss handlers and registry policy were not newly reread here; remaining native qualification stands.
- CloudFileHelper139–200 confirms shared .tmp path, write/delete/move ordering, retries and eventual exception. Root22 correctly rejects implied atomicity/concurrent safety/remote-sync proof. No helper executed.
- Actual correction read-back closes MR-01 date freshness and MR-02 empty fallback qualification. SURF-01 last-row group omission and SURF-03 timer count gate corrected; planner reports §B correction, but its exact line was not independently captured by the final filtered output in this delta, so SURF-02 closure remains a small read-back item.

## Remaining coverage

Civil count map does not close all field/action semantics. Keep the identified settings/reset scopes, survey activation consumer, source import replacement/Undo and native slab geometry as separate evidence needs. CEPROPS and discovery source gaps are materially narrowed by these bounded contracts; neither becomes installed acceptance. Whole-plugin completion and final morning pack remain open.
