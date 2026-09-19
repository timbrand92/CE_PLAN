# CE Civil Editor Workshop Context / Start Here

**Updated:** 2026-08-31  
**Repository:** `timbrand92/CE_ACAD_PLUGIN`

This file is the handoff/index for future ChatGPT, Claude and Codex sessions working on the CE Civil drainage editors and Drawing Intelligence model.

## Version 3 release control

[V3_0_PLAN.md](./V3_0_PLAN.md) is the mandatory master Version 3 framework. Every new chat, context
compaction and handoff must read it first and resume its first incomplete gate. The workshop briefs below remain
the detailed behaviour authorities for their respective intelligence and UI responsibilities.

## Read these first

1. [`CE_CIVIL_EDITOR_UI_UX_BRIEF.md`](./CE_CIVIL_EDITOR_UI_UX_BRIEF.md) — approved UI/UX contract for CDEDIT, PIPEEDIT and PITEDIT.
2. [`CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md`](./CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md) — approved Codex/implementation contract for connectivity, CDCHECK, smart civil commands, shared learning, surfaces and roof/catchment intelligence.
3. PR #20 — `UI-04: shared Civil editor shell — slice 1 infrastructure` — useful additive shell infrastructure, but it predates the finished workshop decisions above and must be adapted rather than adopted literally.

## Authority order

For the editor refit, use this order when documents conflict:

1. The two approved workshop briefs above.
2. Existing approved engineering rules / network contracts already in the repo.
3. PR #20 shell infrastructure and visual evidence.
4. Current shipped UI behavior, except where the workshop brief explicitly changes it.

The UI/UX brief changes presentation/workflow only. It must not silently redesign engineering rules.

## Critical concepts to preserve

- Engineering/actual values and drawing presentation are separate but always considered together.
- CDEDIT is the main editing doorway.
- CE-controlled text never opens raw AutoCAD text edit; it resolves to the owning editor and relevant field.
- Simple Pipe / Simple Pipe + Arrow remain important real workflows and must not be removed.
- Connectivity is independent from whether ILs exist or are displayed.
- No nearest-wins; crossings are not connections.
- Pipe endpoints touching/terminating in valid main-pipe corridors or pit footprints can prove connectivity.
- CDCHECK is the fast drainage/network health checker.
- CDINTELLIGENCE is the future broader project intelligence umbrella.
- ML may learn from corrections but production model updates require controlled validation/release.

## Visual direction

The approved direction is a medium-width, vertically stacked Windows-style editor with:

- identity header;
- Engineering;
- Connections;
- Presentation;
- Schedule where relevant;
- minimal status chips;
- contextual Was/Now only when changed;
- a single `Preview — changes not saved` banner when needed;
- `Save and Close` / `Cancel` rather than a heavy Apply/Update/OK workflow.

A visual mockup was approved during the workshop. If a future session needs a fresh visual, regenerate against the UI/UX brief rather than relying on generic shell defaults.

## Work split

### Claude

Owns the editor presentation/workflow refit:

- CDEDIT routing and batch UX;
- PIPEEDIT layout and presentation controls;
- PITEDIT layout and presentation controls;
- wording, hierarchy and visual shell adoption;
- safe preview UI behavior;
- double-click/navigation behavior.

### Codex

Owns the intelligence/implementation layer:

- topology and connection criteria;
- local connection reassessment;
- CDCHECK;
- CDTRIM/CDEXTEND/CDMOVE/CDBREAK/CDJOIN;
- explicit connection overrides;
- surface intelligence and shared learning data architecture;
- standard-detail intelligence;
- roof/catchment intelligence;
- reversible preview/Undo/highlight services required by the editors.

## Important implementation warning

Do not let Claude independently invent network behavior and do not let Codex independently redesign the editor UX. The two briefs intentionally separate responsibility while sharing the same engineering-vs-presentation contract.
