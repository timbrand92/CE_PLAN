# CE Civil Drawing Intelligence Brief — Connectivity, CDCHECK, Smart Commands, Shared Learning

**Status:** Approved workshop authority  
**Date:** 2026-08-31  
**Audience:** Codex / implementation sessions

## Purpose

Update the CE_ACAD_PLUGIN intelligence layer so the drainage system understands topology, connections, project context and learned drafting patterns reliably. This document is the Codex companion to the editor UI/UX brief.

Codex must inspect the existing repository and existing engineering contracts before implementation. Work additively where possible and do not infer class names/storage structures from this document.

## Core rules

1. Engineering/actual data and presentation are separate.
2. Connectivity/topology is independent from levels.
3. `Connected` does not mean `has an invert`.
4. Touching/termination can prove connectivity.
5. Proximity alone never proves connectivity.
6. Crossing alone is not a connection.
7. No nearest-wins.
8. Explicit user intent can override geometry where deliberately recorded.
9. Exact/proven changes should be fast; tolerance/ambiguous cases should ask.
10. Normal AutoCAD workflows stay familiar; CE-aware commands add network intelligence.

# Connection model

## Conceptual states

### Connected
Geometry or explicit user action proves the relationship.

### Possible Connection
Likely within defined drafting tolerance, but not proven. Highlight and ask.

### Unresolved
More than one valid candidate exists or CE cannot safely choose.

### Not Connected
No relationship exists (crossing, unrelated geometry, ignored candidate, etc.).

### Unconnected
A specific endpoint clearly has no current connection.

### Needs Review
A known relationship became stale/ambiguous and cannot be safely resolved automatically.

### Explicit Not Connected
User deliberately disconnected geometry that still visually touches. This explicit override prevents automatic reconnection until geometry materially changes or the user removes the override.

### Explicit Connection
User deliberately connected objects even though geometry did not independently prove it. Preserve the explicit relationship, but if geometry later becomes materially inconsistent, mark Needs Review rather than silently deleting it.

# Pipe → pipe connection criteria

A branch/incoming pipe endpoint is proven connected to a receiving pipe when the endpoint:

- terminates on/touches the receiving pipe centerline/polyline; or
- for MLINE-style pipes, terminates within the physical pipe corridor between its two outer lines.

The receiving main does not need to be split at that branch location.

A branch endpoint touching the middle of a continuous main pipe is a valid junction without a dedicated junction block.

A pipe visually crossing another pipe is not connected unless the relevant endpoint terminates at/in the valid receiving geometry.

A branch passing across an MLINE corridor is not connected if its endpoint continues past it.

## Tolerance

If an endpoint stops slightly short of a valid receiving object, within a carefully defined drafting tolerance, mark `Possible Connection`; never auto-connect by nearest object.

Prompt actions:

- `Connect & Fix Geometry` — default;
- `Connect Only` — record relationship without forcing drawing geometry;
- `Ignore` — remember this candidate so CE does not repeatedly prompt until geometry materially changes.

When connecting to an MLINE main, drawn branch geometry may terminate at the outer pipe edge/corridor according to drafting convention while the internal topology connects it to the logical main pipe. Do not distort the drawing just to satisfy topology.

# Pipe → pit connection criteria

A pipe endpoint is proven connected when it touches or terminates inside the pit footprint/boundary.

If it stops just short within tolerance: `Possible Connection`.

If more than one pit legitimately contains/owns the endpoint: `Unresolved`, highlight candidates and require user selection.

If endpoint is inside the pit footprint but approach side/direction looks unusual, record the connection first and separately flag the unusual geometry if required. Do not deny connectivity just because the entry side looks odd.

# Pipe endpoint → pipe endpoint

- Two exact coincident endpoints: automatically connected, while remaining separate CE pipe objects.
- Three or more exact coincident endpoints: automatically form a multi-pipe logical junction.
- Tolerance-only coincidence: confirmation required.
- Multiple branches at the same physical point on a main: merge into one logical junction/node rather than near-duplicate nodes.

# Geometry changes

## Proven move to a new receiving object

If a branch was connected to Main A and is moved so its endpoint now genuinely touches Main B:

- automatically drop A;
- automatically connect B;
- do not ask merely because the owner changed when new geometry is exact/proven.

Tolerance/proximity-only new candidates still require confirmation.

## Moved to nothing

If geometry now proves there is no connection, mark endpoint `Unconnected` automatically.

## Stale/ambiguous

Use `Needs Review` only when the post-edit situation is genuinely ambiguous/stale.

Do not interrupt normal drafting with full dialogs for Needs Review unless a later operation depends on the unresolved relationship.

# Explicit Disconnect

When user chooses to disconnect a proven connection:

- default `Disconnect & Fix Geometry` — create clear physical separation;
- optional `Disconnect Only` — keep geometry visually touching but record explicit Not Connected.

`Disconnect Only` must be visible in diagnostic/editor context because drawing appearance suggests a relationship that the topology intentionally rejects.

The explicit override wins over future geometry scans until material geometry change or user removal.

# Connection history

Keep lightweight connection-change history for traceability/debugging, hidden from ordinary day-to-day UI unless needed.

# Normal AutoCAD edits

Normal AutoCAD grip/STRETCH/MOVE remains familiar.

After editing a known CE object, perform lightweight local reassessment of only the affected object(s) and nearby connection candidates.

If the edit creates a Possible Connection, show a small non-blocking prompt while the user still understands the action:

`Connect & Fix Geometry / Connect Only / Ignore`

Do not run broad whole-drawing intelligence scans continuously.

# CDCHECK

Create/implement `CDCHECK` as the fast drainage/network health command.

Default scope: whole drawing. Optional scope: selected objects only.

Check at least:

- unconnected pipe ends;
- Possible Connections;
- Unresolved connections;
- Explicit Not Connected overrides;
- stale/Needs Review links;
- flow direction contradictions;
- missing ILs only where the actual pipe type/workflow requires them;
- duplicate/overlapping logical junctions;
- other blocking network integrity problems discovered from existing engineering contracts.

Do **not** assume every gravity pipe requires ILs. Review existing job patterns and existing plugin rules. Short/simple pipes can legitimately participate in topology without meaningful/displayed ILs.

## CDCHECK results UX contract

Expose results in a popup/results window with categories and counts, not command-line-only output.

Clicking an item zooms/highlights it.

Where appropriate offer direct resolution actions such as Connect, Disconnect, Resolve, Resolve Flow, Open PIPEEDIT, Open PITEDIT.

Finish with a plain summary such as `Network OK`, `3 items need review`, `1 blocking engineering issue`.

Distinguish blocking engineering issues from non-blocking drafting/presentation warnings.

# CE-aware drafting commands

These commands should feel like familiar AutoCAD commands, but maintain/reassess CE object identity and topology.

## CDTRIM

Ordinary AutoCAD geometry may be the trim boundary; only CE objects receive network/data updates. After trim, reassess the affected end. Exact result updates instantly; ambiguous/tolerance result asks.

## CDEXTEND

Ordinary geometry may be the boundary. Extending a CE branch to an exact valid receiver establishes connectivity automatically; tolerance-only result becomes Possible Connection.

## CDBREAK

Breaking a CE pipe produces two CE pipe objects, carries type/diameter/material/presentation appropriately, preserves surrounding connectivity, creates a logical pipe-to-pipe node rather than a pit, and only calculates intermediate engineering values where existing rules make them provable.

## CDJOIN

Join end-to-end CE pipes only when key engineering properties are compatible. Explain conflicts. Presentation differences do not block an otherwise engineering-valid join.

## CDMOVE — pits

Moving a pit should move the pit and stretch/adjust connected pipe ends to follow it while opposite pipe ends remain fixed. Block genuinely impossible geometry with practical resolution options; allow unusual-but-valid geometry with warning/review options.

## CDMOVE — pipes

Preserve proven endpoint connections where sensible reshaping can do so. If breakage is unavoidable, preview exactly which connections will disconnect and ask before committing.

## Normal COPY

Normal AutoCAD COPY remains usable. Copied CE objects get a new CE identity, never inherit the original network identity, and reassess topology from new geometry. A future CDCOPY may add specialist options.

# Simple pipes and topology

Short pipes such as downpipe → main line or AGI → pit are real CE drainage objects with pipe type, diameter, material and applicable grade/default behavior.

They may legitimately have no meaningful/displayed ILs for the final design reader. Do not manufacture fake ILs merely to make the graph look complete.

The network must still understand chains such as `DP1 → short pipe → main pipe → P7`.

# Pit/detail intelligence

The intelligence layer should know the CE standard details library and approved custom details, including selected detail identity, dimensions/rules, sump logic where applicable, Modified from Standard state, Custom Detail conversion and validation of pit dimensions/depth/detail compatibility.

Do not hard-code a generic sump assumption where detail-specific rules exist.

# Surface recognition

Surface context should support PITEDIT surface and lid-class suggestions.

Controlled company surface vocabulary initially includes Landscape, Footpath, Driveway, Road, Other.

Detection output: high confidence `Detected: Driveway`; lower confidence `Likely: Driveway — Confirm / Change`.

User confirmation/correction is training feedback. Lid Class recommendation is advisory; the user can edit actual lid class freely.

# Company-wide shared learning

Initial architecture may use OneDrive as the shared company knowledge/data store because project files already live there and the AutoCAD plugin runs locally.

Keep storage abstraction clean so this can later migrate to a central database/service.

Recommended pattern:

- local plugin runs inference/collection around current drawing;
- confirmed/corrected examples are serialized as small structured records;
- records sync to a shared company OneDrive intelligence area;
- project-specific context remains associated with the project;
- company model learns broader patterns from aggregated approved examples.

Do not continuously retrain a heavy model inside each DWG or each local C: drive installation.

## Model release control

The company-wide model may learn from confirmed/corrected examples, but a newly trained model must not silently change production behavior overnight.

Use a controlled lifecycle: collect examples → train/update candidate → validate against known jobs/test cases → approve/release → deploy versioned model → retain rollback.

# Project-specific intelligence

Each project should maintain its own contextual intelligence, including confirmed surfaces, roof catchments, explicit Connection / Not Connected overrides, project-specific pit/detail decisions, confirmed junctions/network topology and local exceptions.

Company intelligence provides broader learned knowledge; project context records the actual project truth.

# Roof/catchment intelligence

This belongs to the broader CE Civil Drawing Intelligence model, not PITEDIT.

Run deliberately through a dedicated workflow/command, not automatically every time a DWG opens.

Possible workflow:

- inspect architectural roof linework, closed polylines, hatches and known roof plans;
- propose catchment boundaries;
- allow user confirmation/adjustment;
- calculate roof/catchment area;
- link confirmed catchments to drainage network objects;
- support generation/coordination of a roof drainage plan where required.

The same confirmed catchment data should be reusable rather than redrafted separately for calculations and plan presentation.

# CDINTELLIGENCE

Plan a broader umbrella command such as `CDINTELLIGENCE` for project-wide intelligence tools: network intelligence/health, surfaces, roof catchments, learned project context, standard-detail intelligence and future civil drawing recognition workflows.

`CDCHECK` remains the fast specific network-health command.

# Editor support services needed by Claude/UI work

## Reversible preview

Provide a safe uncommitted preview pathway: preview appears in AutoCAD; Cancel restores exact starting state; newer input supersedes older preview/calculation; Save and Close commits once; mere UI interaction does not permanently write.

## Undo

One accepted editor/batch command should map cleanly to one AutoCAD Undo step.

## Show Where / Focus

Provide one callable highlight/zoom service that strongly highlights target CE object(s), can highlight a relevant connection/end point, supports Focus on Pit/Pipe and CDCHECK navigation, and does not permanently modify the drawing.

# Acceptance examples

1. Branch endpoint exactly touches main centerline → Connected.
2. Branch endpoint terminates within MLINE pipe corridor → Connected.
3. Branch crosses main but endpoint does not terminate there → Not Connected.
4. Branch stops a small tolerance short → Possible Connection prompt.
5. Endpoint inside pit footprint → Connected.
6. Endpoint valid for two overlapping pits → Unresolved; user chooses.
7. Three exact coincident pipe endpoints → one multi-pipe logical junction.
8. Moved branch exact-touches new main → auto-drop old main and connect new main.
9. Moved branch touches nothing → Unconnected.
10. Normal AutoCAD edit creates tolerance candidate → small non-blocking prompt.
11. Ignore candidate is remembered until material geometry change.
12. Disconnect Only visually touching objects remain explicitly Not Connected.
13. CDMOVE pit moves pit and follows connected pipe ends while opposite ends stay fixed.
14. CDBREAK creates two CE pipes and a logical node, not a fake pit.
15. Normal COPY gives new CE identity and reassesses connections.
16. CDCHECK identifies topology problems and jumps directly to each affected item.
17. Simple/short pipe can be fully connected in topology with no manufactured ILs.
18. Surface correction becomes learning feedback but does not immediately alter company production model.

# Implementation boundary

Do not redesign the UI in this task. Claude owns editor presentation/workflow according to `CE_CIVIL_EDITOR_UI_UX_BRIEF.md`.

Do not let UI convenience weaken topology rules. Where a UI needs a service, expose a clean service/contract and let the editor consume it.
