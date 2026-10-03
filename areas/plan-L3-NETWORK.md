# plan-L3-NETWORK — implementation plan for "CE proposes the full network layout" (Level 3 proposal 4)

**Written:** Sun 4 Oct 2026, 04:30 Melbourne, by team lane build/03 (headless run 10). PLAN ONLY: no code was written.
**Card (read completely first):** `04_REFERENCE/ux-plan/cards/L3-NETWORK_CARD_2026-09-26.md` (APPROVED as plan, 26 Sep).
**Rulings it rests on:** UX-L3-15 ("Propose, show gaps"), UX-L3-16 (Tim: "learn from previous drawings", no fixed
building-line or shortest-path rule), UX-L3-17 (Tim: "Always 2-3 side by side"), UX-L3-18 ("Build around it"), UX-L3-19/20
(the shared chooser and its approved sketch `04_REFERENCE/ux-plan/PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg`), UX-L3-02
(this is build item 4, LAST, after levels, sources and detention), and Tim: *"Say so, offer nothing (Recommended)"* before
enough is learned (decisions file, "Release-chat L3 cards, open choices", 26 Sep 01:17). Job mode UX-MODE-01..04.
**Code read (read-only):** `origin/claude/rel-20261015e` (C-13 head dcd69fd4).

## 0. FOR THE CONTROLLER, in six lines

1. Nothing of this proposal is built, and its heart (a learned route) **cannot be built yet**: the only learning store
   (UX-LEARN-01, built 29 Sep, OFF) keeps one person's numbers about one window; it holds no layouts, and office-wide
   learning and past-job import do not exist (import is not allowed).
2. So, per Tim's ruling, the first release of this proposal says "Not enough has been learned to propose a layout" and
   offers nothing. What CAN be built first, and is useful on its own: the gap list (what the network still needs), the one
   shared clash check, and the "build around existing work" detection.
3. It depends on two pieces that do not exist yet and belong to L3-DETENTION: the side-by-side chooser (its slice 3) and
   the combined clash check (its slice 2). There is no `plan-L3-DETENTION.md`: write that first.
4. Build order: slices 1-2 now (after L3-LEVELS and L3-SOURCES are in); slices 3-6 wait for L3-DETENTION and for a
   learning slice that can hold layout patterns as numbers (section 2, slice 4).
5. **Tim must rule** what differs between the 2-3 options (card §7 Q3) before slice 5, and the "enough learned" bar.
6. Every option must pass the one hydraulic engine (`NetworkDesignService`) before it is shown: no second solver.

## 1. What already exists (checked on C-13)

1. **No layout engine.** No route, pit-position or layout proposal code exists (card §2.1, still true on C-13).
   `Services/AutoDesignService.cs` sizes flows, storage, orifice and one connection pipe; it places no pits and returns
   one design.
2. **The hydraulic authority:** `Services/NetworkDesignService.cs` (`Design(NetworkInputs)`, modes `SizeAndDesign` and
   `PreserveExistingSizes`, per-pipe `Feasible` + `COVER:` notes, `AllFeasible`). A second, July-era whole-network solver
   exists (`NetworkRedesignSolverService` / `NetworkRedesignPipelineService`, nodes with `FixedInvertM`, reached only from
   the Network Redesign hub page). **Do not use it as a second authority for this proposal**; if the controller wants it
   used instead, that is a design-rule-1 decision to make once, in writing.
3. **Finding what is missing:** `Services/CivilNetworkHealthService.cs` already reports `UnconnectedPit`,
   `DisconnectedPipe`, `MissingLevel`, `FlatOrBackfall`, `ShallowPitDepth`, `DuplicatePitId` (snapshot is Unknown when it
   cannot prove anything). The gap list starts from these.
4. **Site constraints:** `Services/XrefSiteGeometryService.cs` (offline background read: boundary, roof, driveways,
   `TpzZones`, `Easements` with width parsed from the text), `Services/TreeSiteConstraintService.cs` + `Commands/TpzCommand.cs`
   (tree zones placed in the drawing). Footings / services clash: **missing**.
5. **Write paths a layout would reuse:** pits through `Commands/PitCommand.cs` (PIT) placement, pipes through
   `Services/PipeCreationService.cs`, sources through `Services/SourcePlacementService.cs` (auto-join UX-SRC-05), all
   committed as one `ChangePlan` with `ProposalApplyService.Apply` (one transaction, one Undo).
6. **Ghosts:** `Rules/EditGhostPlan.cs` + `Services/TransientDrawableSet.cs`.
7. **Learning:** `Learning/LearningService.cs` (per person, numbers only, LOCAL AppData, "Not enough learned yet" under
   3 repeats, switch `learning.enabled` OFF). No store for layouts.
8. **Chooser:** only the approved sketch exists; no component.

## 2. Build order (one draft PR per slice; failing test first; REGRESSION_LOG entry; switch OFF throughout)

### Slice 1 — the gap list, no geometry (Claude; can start once L3-SOURCES slice 1 is merged)

1. **New** `Modules/Drainage/Services/Proposals/NetworkGapReader.cs` + `NetworkLayoutProposalModels.cs` (pure core,
   AutoCAD wrapper): walks this drawing's pits, pipes and sources (read-only record of THIS drawing: `TryPeekCurrent`),
   takes `CivilNetworkHealthService` findings, and lists in plain words what a complete network still needs: a source with
   no pipe, a pit with no path to the LPD, no LPD set, no outlet invert, a catchment with no destination, missing surface
   levels, missing background (boundary not readable). Each item: what, where (pit/source label), why it matters, and
   Unknown where the inputs cannot say (UX-L3-15).
2. **Existing work is fixed (UX-L3-18):** every drawn pit, pipe and source is listed as "kept as drawn"; nothing here
   proposes to change one.
3. **Output on the command line only in this slice** (hidden INTERNAL command `CDLAYOUTGAPS`, registered INTERNAL in the
   command registry so the BUG-375 drift guard stays green), plus the result object for the later window.
4. **Settings:** `UserSettings.NetworkLayoutProposal` (JSON `networkLayoutProposal`) = new
   `Models/NetworkLayoutProposalSettings.cs`, `enabled` false.
5. **Failing tests first** (`Drainage.Tests/Services/Proposals/NetworkGapReaderTests.cs`): an empty site lists "no
   pits, no pipes" plus the missing inputs; a partial network lists only the missing links; a fully connected network
   says "nothing missing"; a source without a pipe is listed once; Unknown health snapshot gives "could not be checked",
   never "nothing missing".

### Slice 2 — "not enough learned" state (Claude)

1. The proposal entry (when switched on) runs slice 1, then asks the layout learner (slice 4) for options. Until it can
   answer, it shows the gap list and exactly one line: "Not enough has been learned from past drawings to propose a
   layout yet. Nothing is drawn." (Tim's "Say so, offer nothing".)
2. No fixed geometric fallback of any kind (UX-L3-16). Guard test: with no learned data the result has zero options and
   the message; a source scan fails if a shortest-path or building-line router is added under `Services/Proposals/`.

### Slice 3 — consume the shared clash check and chooser (after L3-DETENTION slices 2 and 3)

1. **One clash engine (card §7 Q2, recommended yes):** L3-DETENTION slice 2 builds it (easement band, TPZ / SRZ, footings,
   services). This proposal calls it for every candidate pipe and pit; it does not add its own checks. Wording is the
   detention card's (same scenario, same words).
2. **One chooser (UX-L3-19):** the side-by-side panel built in L3-DETENTION slice 3 (plan picture, key figures, the
   difference line, Cancel, Accept). This slice only feeds it layout options. Confirm in review that no second chooser
   class appears (design rule 1).
3. **Failing tests first:** a candidate pipe through a TPZ is flagged with the shared wording; the chooser receives 2-3
   options with pipe length, pit count and cover/grade summary.

### Slice 4 — a learning slice that can hold layout patterns as numbers (Claude, needs a controller decision)

1. Tim's privacy rule for learning is "numbers only, on the person's own PC". Layout patterns can be kept as numbers
   without any drawing, client or path: set-off of a pipe from the building outline (mm), from the boundary (mm), pit
   spacing along a run (m), pit at each change of direction (yes/no as 1/0), preferred side of the building (as a count),
   depth at the top pit (mm). These are recorded when a drafter draws or edits a network by hand (through the existing
   `SuggestionLedgerService` feed, so the off switch is honoured by construction).
2. **New** feature keys in the existing `LearningService` (no second store): `layout.setOffFromBuildingMm`,
   `layout.setOffFromBoundaryMm`, `layout.pitSpacingM`, ... each with the existing `habitMinRepeats` bar.
3. **Decision needed (controller, then Tim if it touches privacy):** whether per-person learning is enough for a layout
   proposal, or office-wide learning (UX-LEARN-01 slice 3, not built) must come first. Recommended: per person first; the
   proposal says whose habits it used ("your own past drawings").
4. **Failing tests first:** recording a hand-drawn run stores only numbers; with the switch OFF nothing is recorded;
   fewer than the bar gives "Not enough learned yet".

### Slice 5 — 2-3 learned options, each feasibility-checked (Claude)

1. **New** `Services/Proposals/NetworkLayoutProposalEngine.cs`: from the gap list, the site constraints and the learned
   numbers, build candidate pit positions and pipe routes **only for what is missing**, joining to existing pits/sources.
2. Each candidate goes through `NetworkDesignService.Design` (sizes, inverts, cover) and the shared clash check; an
   infeasible candidate is never offered as valid (it is dropped, and the window says how many were dropped and why).
3. **What differs between options** (card §7 Q3): per Tim's ruling (section 5 item 1). Until he rules, slice 5 is not
   started.
4. **Failing tests first:** an option never moves or re-proposes a drawn pit or pipe; each offered option is feasible in
   `NetworkDesignService`; three options are genuinely different (not the same route three times); with only one
   feasible option the window shows one and says why there are not more.

### Slice 6 — changes to existing work, ticked separately; one Undo; switch-on (Claude + Codex)

1. A proposed change to an existing pit or pipe (rare: e.g. lowering an existing pit to reach) is a separate row,
   unticked, applied only if ticked (UX-L3-18). New work plus ticked changes = one `ChangePlan` = one Undo.
2. Job mode: Design from scratch = Accept all after preview; From markup = per-item accept, "differs from supplied design"
   on conflicts, extra drawn items listed "Not in markup".
3. Reads only the current drawing: an un-accepted sources or detention proposal is invisible to it (card §7 Q4,
   recommended answer).
4. Codex: window wiring per a `docs/workflows/L3-NETWORK_WINDOW_CONTRACT.md` Claude writes first. Switch-on only after
   section 6 passes.

## 3. Settings keys (all new, Civil user settings, `networkLayoutProposal.*`)

1. `enabled` — bool, false.
2. `optionCount` — 3 (UX-L3-17 "Always 2-3": show up to 3, at least 2 when two feasible ones exist). Not an engineering
   value; a display setting.
3. No geometric constants: set-offs and spacing come from learning (slice 4), never from a coded default (UX-L3-16).
   Clearances for easements and tree zones stay where they are (council / Settings, R-00).
4. Learning thresholds use the existing `learning.habitMinRepeats` unless Tim rules a separate bar (section 5 item 2).

## 4. Risks

1. **Building ahead of the learning store:** without slice 4 the proposal never shows an option. That is the ruling, but
   it means slices 3-6 deliver nothing visible for a long time: do not let a builder "fill in" with a geometric rule.
2. **Second chooser / second clash engine drift:** the biggest design-rule-1 risk; review must check one of each.
3. **Second hydraulic solver:** the July redesign solver must not become a second authority here.
4. **Wrong record:** read this drawing's record read-only (BUG-378 lesson).
5. **Performance:** 3 options x `NetworkDesignService` x clash checks on a 60-pit site; run off the command line with a
   progress line, and cancel cleanly on Escape. Measure on a synthetic 100-pit network before slice 5 merges.
6. **Privacy:** layout learning must stay numbers only; no coordinates of a real site are stored (store set-offs, not
   positions).

## 5. What Tim must rule (through the desk, one batch, when slice 5 is near)

1. **What differs between the 2-3 options** (card §7 Q3). *Recommended:* options built from different learned habits:
   "fewest pits", "shortest total pipe", and "your usual set-off from the building". Example: on a 4-lot site, option A
   has 9 pits and 82 m of pipe, option B has 12 pits and 64 m, option C follows your usual 1.0 m set-off from the house.
2. **How much must be learned before CE offers a layout** (the "enough learned" bar). *Recommended:* at least 5 of the
   drafter's own hand-drawn networks with the learning switch on. Example: a new starter sees "Not enough learned yet"
   until they have drawn five networks.
3. **Footings and services clash distances** (needed by L3-DETENTION slice 2 first): engineering values, Tim's.

## 6. What Codex must check in AutoCAD (copies only, `C:\Lisp Files\_TEST_COPIES_20260923`)

1. Switch OFF: nothing new on the ribbon or the command line; CDCHECK unchanged.
2. Slice 1, `CDLAYOUTGAPS` on DWG-A (boundary and outlet only): lists missing pits/pipes and missing inputs in plain
   words; on a fully drawn copy says "nothing missing"; draws nothing.
3. Slice 2, switch ON with learning OFF: the proposal shows the gap list and "Not enough has been learned ... Nothing is
   drawn."; no ghost appears.
4. Later slices (when built): DWG-B partial network: existing pits/pipes shown as themselves, only missing pieces ghosted;
   the clash variant (route through a TPZ) shows the detention card's clash wording; accept one option with one ticked
   change, then U once: all new work and that one change revert together.
5. Cancel and Escape at every step: "Cancelled - drawing unchanged.", no ghost left. Save, close, reopen: nothing
   proposal-only stored.

## 7. Not in this plan

1. L3-DETENTION (build item 3): it owns the chooser and the clash check; write `plan-L3-DETENTION.md` before slice 3 here.
2. Office-wide learning, promoting a learned habit to an office rule, any past-job import (not allowed).
3. Levels and sources (`plan-L3-LEVELS.md`, `plan-L3-SOURCES.md`).
