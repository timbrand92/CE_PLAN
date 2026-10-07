# plan-L3-SOURCES — implementation plan for "CE proposes downpipes and sources" (Level 3 proposal 2)

**Written:** Sun 4 Oct 2026, 04:20 Melbourne, by team lane build/03 (headless run 10). PLAN ONLY: no code was written.
**Card (read completely first):** `04_REFERENCE/ux-plan/cards/L3-SOURCES_CARD_2026-09-26.md` (APPROVED as plan, 26 Sep).
**Rulings it rests on:** UX-L3-01/02 (scope; build item 2, after L3-LEVELS), UX-L3-07..10, UX-SRC-05 (DP and CDRG are
placed like pits, before pipes), UX-SITE-04 (background shapes are offered, clicked to use, never silently trusted),
UX-LEARN-01, job mode UX-MODE-01..04. Implementation call (not Tim's words): numbering defaults to the learned pattern.
**Code read (read-only):** `origin/claude/rel-20261015e` (C-13 head dcd69fd4).

## 0. FOR THE CONTROLLER, in five lines

1. Nothing of the proposal itself is built. The pieces it stands on are: DP placement (one backbone), the rating-report
   reader, the offline background (xref) reader with roof outlines, the ghost renderer, and the learning base
   (switched off, per person, numbers only).
2. Build order: 6 slices, smallest first, each behind one switch `sourcesProposal.enabled` (default OFF). Slices 1-3 and
   5 are Claude (behaviour, no window); slice 4 is Codex's window (ruling B) against a contract file Claude writes first.
3. **Start only after L3-LEVELS slice 2 is merged** (build order UX-L3-02, and both share the one-Undo plan writer).
4. **Two values need Tim before switch-on** (section 5): the roof-edge downpipe spacing, and which architect layer / block
   names count as "a downpipe symbol" (seed list).
5. "Learned" positions and numbering need the learning base switched on and enough history; until then the proposal says
   "Not enough learned yet" for those parts (as the learning base already does) and offers the clockwise and placed
   numbering only.

## 1. What already exists (checked on C-13)

1. **DP placement, the one write path:** `Commands/SourceBlockInsertCommands.cs` `DP` (`PlaceDownpipe`) and `CDRG`, through
   `PlaceTaggedSourceBlock`, all going through `Services/SourcePlacementService.cs` ("the ONE backbone every source type
   goes through": next stable tag, pick, assess the landing, write block + tag + label + connection point, register, split
   the pipe it sits on, relink, report). It already allocates the next free DP number.
2. **Rating report reader (PR #233):** `Rules/StormReport.cs`, `Rules/BlueFactorReport.cs`, `Rules/CatchmentReportIntake.cs`
   (each catchment's area as `TracedFigure.FromRatingReport` and its destination as `StormTreatment` = RainwaterTank /
   None (straight to the LPD) / BufferStrip / Unknown; `DestinationIsUnknown`). Today used by CDCALC > Catchments >
   "Add from rating report". **Note:** the report names a *kind* of destination (a tank), not a drawn tank or pit: matching
   it to one drawn object is new.
3. **Background reader:** `Services/XrefSiteGeometryService.cs` reads the job's xref base file offline (ACadSharp, no
   AutoCAD): boundary, `RoofPolygons` with `IsRoofReadable` / `RoofReadability` ("roof is bimodal by architect
   convention": never use roof figures when not readable), driveways, TPZ zones, easements. It does **not** read block
   symbols. Job folder: `JobFolderLookupService.FindJobFolder`.
4. **Ghosts:** `Rules/EditGhostPlan.cs` (`GhostKind.Outline / Text / Leader`) drawn through `Services/TransientDrawableSet.cs`.
5. **Learning base (UX-LEARN-01 slices 1+2, PR 396):** `Learning/LearningService.cs` (`GetSuggestion(feature, situation)`,
   answer "Not enough learned yet" until `habitMinRepeats` (3) repeats; numbers only, per person, LOCAL AppData;
   switch `learning.enabled` default OFF). Office-wide learning and past-job import are NOT built (no corpus import is
   allowed: `C:\CE_DrawingIntelligence` is off limits).
6. **Per-row ticks and one Undo:** the L3-LEVELS engine has its own `LevelsProposalSelection`; the shared
   `ProposalPreviewDialog` / `ProposalPreviewViewModel` is still whole-plan accept only (no per-row tick). The write is
   `ProposalApplyService.Apply(ChangePlan)` = one transaction.
7. **Job mode:** `CivilJobMode` in `Rules/CivilDesignWorkflow.cs`, saved in `CivilProjectStartDraft.JobMode`.

## 2. Build order (one draft PR per slice; failing test first; REGRESSION_LOG entry; switch OFF throughout)

### Slice 1 — the proposal model and engine skeleton, destinations only (Claude)

1. **New folder files** `Modules/Drainage/Services/Proposals/SourcesProposalModels.cs` and `SourcesProposalEngine.cs`
   (pure, no AutoCAD; same shape as the levels engine): input = candidate DP positions (empty in this slice), drawn tanks /
   pits / LPD with their kinds, rating-report catchments; output = one row per DP: position, proposed number, destination
   (drawn object id or Unknown), destination reason, catchment name and area with its source, tick rules, job-mode flags
   (`AcceptAllAllowed` only in Design from scratch; `DiffersFromSuppliedDesign`; `NotInMarkup`).
2. **Destination rule (UX-L3-08):** report says RainwaterTank and the drawing has exactly one tank → that tank, reason
   "rating report: <catchment> to tank". More than one tank, or BufferStrip, or Unknown → destination Unknown, with the
   suggestion from `LearningService.GetSuggestion("sources.destination", ...)` shown only as a suggestion; with learning
   OFF or not enough learned, the row says "Unknown - pick the tank or pit" and is never pre-ticked. `None` → the LPD.
3. **Settings:** `UserSettings.SourcesProposal` (JSON `sourcesProposal`) = new `Models/SourcesProposalSettings.cs` with
   `enabled` false (more keys in slices 2, 3 and 5).
4. **Failing tests first** (`Drainage.Tests/Services/Proposals/SourcesProposalEngineTests.cs`): one-tank match; two tanks
   → Unknown, not pre-ticked; BufferStrip → Unknown; None → LPD; report missing → every destination Unknown with
   "no rating report found"; Unknown never becomes a number or a guessed id (extend the #233 test data, no new parser).

### Slice 2 — architect DP symbols from the background (Claude)

1. **New** `Services/BackgroundDownpipeSymbolReader.cs` (offline ACadSharp, beside `XrefSiteGeometryService`, NOT inside
   it: that file feeds Project QA and xref compare; keep its outputs unchanged): lists block inserts and circles on layers
   or with block names matching the Settings patterns, in true millimetres, with the matched pattern as the reason.
2. **Settings keys** (R-00, nothing hard-coded): `sourcesProposal.architectDpLayerPatterns` (list of text, wildcard),
   `sourcesProposal.architectDpBlockPatterns` (list), both seeded (section 5 item 2) and editable on the Settings page.
3. **Prompt (UX-SITE-04 shape):** if more than one xref is attached, ask which background to read; the found symbols are
   offered, never silently used; the drafter can still pick their own points.
4. **Failing tests first:** a synthetic DXF/DWG fixture (no client drawing) with DP blocks on a matching layer, a
   non-matching layer and a near-duplicate; only the matching ones are returned; a unit-scaled (metre) xref returns
   millimetres; an unreadable file gives a plain "could not read the background" result, never an exception.

### Slice 3 — roof-edge fallback (Claude)

1. When no architect symbol is found: from `XrefSiteGeometry.RoofPolygons` **only when `IsRoofReadable`** (otherwise
   say "Roof outline could not be read - pick downpipe points yourself" and propose nothing), propose a DP at each roof
   low corner / valley and along each eaves run at no more than the spacing value.
2. **Settings key:** `sourcesProposal.maxEavesRunSpacingM` (default from Tim, section 5 item 1; until then marked
   Assumed exactly like `levelsProposal.steepestGradeN`, with `...Source` and `...Confirmed` keys).
3. Each roof-rule DP row says "Roof rule (office starting rule), not read from a document"; when learning has enough
   corrections, `LearningService` adjusts spacing as a suggestion only (never a rule change).
4. **Failing tests first:** a rectangle roof 20 m x 10 m with a 12 m spacing gives the expected corner and mid-run points;
   `IsRoofReadable = false` proposes nothing and says why; a roof outside the title boundary is ignored.

### Slice 4 — the window, ghosts and per-DP ticks (Codex window + Claude ghosts and selection)

1. **Claude first writes** `docs/workflows/L3-SOURCES_WINDOW_CONTRACT.md` (same format as the levels contract): one row
   per DP (number, position source, destination, catchment, why), tick rules, Accept all only in Design from scratch,
   the three numbering choices, Unknown wording, cancel wording.
2. **Claude:** `EditGhostPlan.ForSources(result, ticked)` = per DP an Outline (symbol footprint), a Text (number), a Leader
   (thin line to the destination) and an Outline (catchment area: the report's area where a name matches; otherwise a
   roof-area estimate labelled "estimated", card §7 Q5); `SourcesProposalSelection.Select` (one change set, one Undo).
3. **Codex:** the window, from the contract.
4. **Failing tests first:** ghosts equal ticked rows; renumbering changes only ghost numbers, never a written DP;
   a partial tick gives one change set.

### Slice 5 — accept writes through the one backbone; numbering choice (Claude)

1. **Write:** each accepted DP goes through `SourcePlacementService` (the backbone), inside ONE transaction for the whole
   accepted set (one Undo). This needs a batch entry on the backbone (`PlaceMany`) that shares its per-source steps; it
   must not copy them (design rule 1). Risk: the backbone today runs one pick at a time with its own transaction; the batch
   entry is the riskiest change in this plan: Opus review required.
2. **Numbering (UX-L3-09, "all option available"):** three orders in the window: learned office pattern (pre-selected by
   the implementation call; when not enough is learned it says so and the window pre-selects "clockwise from front left"),
   clockwise from front left (front = the site boundary edge nearest the street frontage; if no frontage is known, the
   window asks the drafter to click the front), and order placed. One click renumbers the ghosts only.
3. **Settings key:** `sourcesProposal.defaultNumberingOrder` ("Learned" / "Clockwise" / "Placed"), default "Learned".
4. **Failing tests first:** each order gives a stable, repeatable sequence; already-drawn DP numbers are never reused;
   accepted DPs auto-join to a pipe drawn later exactly as a hand-placed DP (UX-SRC-05, reuse the existing auto-join tests).

### Slice 6 — entry point and switch-on (controller)

1. Entry: one shared "Level 3 proposals" place (card §7 Q4, OPEN) or beside DP/CDRG on the ribbon. Recommended: wait for
   Tim's answer (section 5 item 3); until then a typed command `CDPROPOSESOURCES`, hidden, registered INTERNAL in the
   command registry (BUG-375 drift guard).
2. Switch-on only after section 6 passes and section 5 items 1-2 are answered.

## 3. Settings keys (all new, Civil user settings, `sourcesProposal.*`)

1. `enabled` — bool, false.
2. `architectDpLayerPatterns`, `architectDpBlockPatterns` — text lists, seeded, editable (slice 2).
3. `maxEavesRunSpacingM` + `maxEavesRunSpacingSource` + `maxEavesRunSpacingConfirmed` — Assumed until Tim (slice 3).
4. `defaultNumberingOrder` — "Learned" (slice 5).
5. Learning keys are the existing `learning.*` (no new ones).

## 4. Risks

1. **Batch placement through the backbone** (slice 5): one transaction for many DPs, each of which may split a pipe and
   relink. A mid-batch failure must roll back everything (test it) and never leave half the DPs.
2. **Destination over-reach:** the report says "tank", not which tank. Never match by name similarity alone; more than one
   candidate = Unknown.
3. **Roof outlines are bimodal** (`IsRoofReadable`): never use roof figures when unreadable (the reader's own rule).
4. **Background symbol false positives:** an architect's stormwater pit or a column can sit on a "DP" layer. Every found
   symbol is a proposal row, unticked in From-markup mode, and the reason names the matched pattern.
5. **Units:** xref in metres vs drawing in millimetres; the reader already returns true mm; test both.
6. **UserSettings.cs** is edited by several open PRs: merge in one train.
7. **No client drawing in tests:** fixtures are synthetic; never copy from `C:\CE_DrawingIntelligence`.

## 5. What Tim must rule (engineering only; through the desk, one batch)

1. **Roof-edge downpipe spacing:** *Recommended:* a downpipe at every roof low corner and valley, and no eaves run longer
   than 12 m between downpipes (an office starting value, refined by corrections). Example: a 30 m straight gutter gets
   3 downpipes. This is an engineering value: Assumed until he answers.
2. **Which architect symbols count as downpipes (seed list):** *Recommended:* layers containing "DP", "DOWNPIPE" or
   "RWDP" and blocks named like "DP*", "*DOWNPIPE*", offered one by one, never trusted silently. Example: a block "DP100"
   on layer "A-PLUMB-DP" is offered; a circle on "A-COLUMN" is not.
3. **Where the proposals live** (card §7 Q4, OPEN, also the levels card's question): *Recommended:* one "Level 3
   proposals" place in Project Review offering levels, sources, detention and layout. Example: a drafter opens Project
   Review > Proposals and sees "Downpipes and sources: 14 proposed" beside "Levels".
4. **The catchment ghost** (card §7 Q5): *Recommended:* the report's area when the name matches, otherwise a roof-area
   estimate labelled "estimated". Engineering-light; can be taken as recommended if he does not answer.

## 6. What Codex must check in AutoCAD (copies only, `C:\Lisp Files\_TEST_COPIES_20260923`)

1. Switch OFF: DP, CDRG and the Sources window behave exactly as installed.
2. DWG with an architect background carrying DP symbols: ghost DPs at the symbol positions, each with a thin line to its
   destination and a catchment outline; nothing is written before Accept.
3. DWG with no architect DPs but a readable roof: roof-rule DPs labelled "Roof rule (office starting rule)"; with an
   unreadable roof, the window says so and proposes nothing.
4. Rating report with one catchment to a tank (one tank drawn) and one Unknown: the first row names the tank; the second
   reads "Unknown - pick the tank or pit", not ticked.
5. Switch numbering order: only ghost numbers change.
6. Accept a subset, then U once: only the accepted DPs disappear; no split pipe is left split.
7. Draw a pipe to an accepted DP afterwards: it joins, as for a hand-placed DP.
8. Cancel and Escape: "Cancelled - drawing unchanged.", no ghost left.
9. Save, close, reopen: accepted DPs are ordinary DPs; nothing proposal-only is stored.

## 7. Not in this plan

1. Office-wide learning and promoting a learned value to an office rule (UX-LEARN-01 slices 3-4).
2. L3-DETENTION (build item 3) and L3-NETWORK (item 4, `plan-L3-NETWORK.md`).
3. Any import of past jobs (not allowed).

## 8. Build/04 run 20 notes (Wed 7 Oct 2026) - for the controller and the desk

1. **Slice 4, Claude's half, built (draft PR #751, stacked on #706):** `SourcesProposalSelection` (ticks to one change set), `EditGhostPlan.ForSources` (dashed symbol outline, number above, thin line to the tank or pit), and `docs/workflows/L3-SOURCES_WINDOW_CONTRACT.md` for Codex.
2. **Question for Tim (small, engineering-light), with a recommendation:** a ticked downpipe whose tank or pit is Unknown - may Accept place it anyway? *Recommended (built):* no. Accept leaves it out and says "Downpipe 2: not placed. Pick its tank or pit first." so an Unknown is never written quietly. Example: 14 downpipes proposed, 2 with no tank matched: 12 go in, the window names the 2 and the drafter picks their tanks, then ticks them again.
3. **Gap, card section 7 Q5 (the catchment ghost):** the model holds a catchment's name and area, not its shape, so the ghost cannot draw the catchment outline yet. *Recommended:* a roof-rule downpipe carries the index of the roof outline it came from, an architect-symbol downpipe takes the nearest roof outline, and the outline is labelled with the report's area when the name matches, else "estimated". Needs a small field on `DownpipeCandidate` in slice 5; not built.
