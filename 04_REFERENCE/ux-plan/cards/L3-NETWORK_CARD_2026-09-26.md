# L3-NETWORK workflow card — Level 3 proposal 4: full network layout

**APPROVED — plan only (26 Sep 2026).** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Level 3 proposal 4:
full network layout — 26 Sep 01:01 2026" (UX-L3-15..18), plus UX-L3-19/20 (visual proposals and the approved
chooser sketch, shared with `L3-DETENTION_CARD_2026-09-26.md`). Read together with UX-L3-01/02 (scope and build
order — this is build item (4), **last**, after L3-LEVELS, L3-SOURCES and L3-DETENTION). Remaining build
details are OPEN. Tim: *"Say so, offer nothing (Recommended)"* before enough past jobs are learned.

## 1. What Tim ruled, and what it builds on

1. **UX-L3-15 (missing inputs):** "Propose, show gaps" — CE proposes with whatever inputs exist; missing
   inputs are listed; those parts stay Unknown until supplied.
2. **UX-L3-16 (routes), Tim's own words: "learn from previous drawings".** Pipe routes, pit positions and
   set-offs follow patterns learned from CE's previous drawings (`UX-LEARN-01`), **not** a fixed "building
   lines" or "shortest path" rule; footings, tree zones and easements are still avoided.
3. **UX-L3-17 (alternatives), Tim: "Always 2-3 side by side"** (the recommended "one + try another" was **not**
   taken) — "like the detention options."
4. **UX-L3-18 (existing work):** "Build around it" — drawn pipes and pits are kept; only what is missing is
   proposed; any change to existing work is shown separately and applied only if ticked.
5. **UX-L3-19/20 (visual proposals, chooser sketch approved) — shared with L3-DETENTION, not repeated here.**
   The chooser shows each option as a plan picture with key figures, side by side (three panels per the
   approved [`PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg`](../PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg)); the picked
   option is a full-size ghost in the real drawing; switching swaps the ghost; differences are highlighted;
   nothing is drawn until Accept; one Undo. UX-L3-19 names "the full design" explicitly alongside
   detention/storage, so this card uses the identical chooser, not a second one.
6. **Build order (UX-L3-02):** this proposal is deliberately last, "after L3-LEVELS, L3-SOURCES and
   L3-DETENTION" — by the time it runs, a job may already have hand-drawn or L3-proposed pits, sources and a
   sized detention system; UX-L3-18's "build around existing work" is what makes that safe.

## 2. What works today — Keep / Modify / Missing

Read from `origin/master` at `bde0c9a9` in `C:\Lisp Files\CE_ACAD_PLUGIN` (26 Sep 2026). No client drawing,
client name or site address was opened.

1. **No route/layout proposal engine exists at all — Missing, confirmed by direct search.** `git grep` across
   `origin/master` for `AutoRoute`, `RoutePlanner`, `PitPositionSuggest`, `LayoutProposal` and
   `NetworkLayoutService` returns nothing. `Modules/Drainage/Services/AutoDesignService.cs` (the closest
   existing "auto-design" orchestrator, also read for `L3-DETENTION_CARD_2026-09-26.md`) sizes flows, storage,
   orifice and **one** connection/detention pipe from a handful of numbers — it places no pits, proposes no
   route geometry, and returns one design, not several. This proposal is genuinely new engineering content, not
   a UI layer over something already built.
2. **The hydraulic engine every proposed route must still pass through — Keep.** Once a route/pit layout is
   proposed, it must still validate through `NetworkDesignService` (the one engine CV-02 HD2 requires, already
   used by CDCALC/CDEDIT/Inspector/CDRUNSOLVE and by `L3-LEVELS_CARD_2026-09-26.md`) — a proposed layout is not
   a real option until it is at least as hydraulically sound as any hand-drawn network, holding minimum cover
   and grade exactly as L3-LEVELS already does. This card does not add a second hydraulic path.
3. **Keeping existing drawn work untouched while proposing only what's missing — partial Keep, Missing the
   detection.** `UX-DI-02` (26 Sep 00:49, "AutoCAD's own commands") already keeps CE pipe data correct through
   ordinary AutoCAD TRIM/EXTEND/BREAK/JOIN edits, and `UX-SRC-05` already has DP/CDRG place like pits, before
   any pipe, with pipes drawn later auto-joining to them — both are examples of the same underlying principle
   UX-L3-18 wants (existing CE objects are never silently reworked). What's missing is the proposal-side logic:
   walking the drawing's current pits/pipes/sources, working out what a complete network would still need
   between them, and treating everything already drawn as fixed unless a specific change to it is separately
   flagged and ticked.
4. **Learning routes/positions/set-offs from past drawings — Missing (shared with every Level 3 proposal).**
   Same read-back gap as every other card in this batch: `SuggestionLedgerService` ("FEATURE 10 SEED") records
   signals but nothing reads them back yet (`UX-LEARN-01_CARD_2026-09-25.md`). UX-L3-16 explicitly rules out a
   fixed geometric rule ("not a fixed 'building lines' or 'shortest path' rule") in favour of this same
   still-unbuilt learning path — this card cannot invent a substitute fixed rule instead of waiting for it.
5. **Avoiding footings, tree zones and easements — Keep the individual checks, Missing the combined pass.**
   Identical position to `L3-DETENTION_CARD_2026-09-26.md` §2.7: `UX-CR-03` (easement band) and `UX-SITE-01`
   (TPZ/SRZ) already exist as separate, approved warnings; a footings/services clash check does not exist yet.
   L3-DETENTION's Slice 2 (combined clash pass) is the same piece of work this card needs for routes — **one
   clash engine, not two** (see OPEN 2).
6. **2-3 options side by side, plan-picture chooser, real-drawing ghost — Missing, shared build with
   L3-DETENTION.** Exactly the same UI gap: `EditGhostPlan`'s dashed-ghost renderer
   (`GhostKind.Outline`/`Text`/`Leader`, 18 Sep 2026 ruling) is the right mechanism for the real-drawing ghost
   half; the side-by-side plan-picture panel is new. UX-L3-19 explicitly asks for one shared chooser across
   detention/storage **and** full design — this card should consume L3-DETENTION's Slice 3 chooser component,
   not build a second one (see §6 Slice 1 below).
7. **Per-item accept and one Undo for a whole-layout proposal — Missing, same shape as every other Level 3
   card.** `ProposalPreviewDialog`/`ProposalPreviewViewModel` are the existing "was/now, whole-plan accept"
   shell; UX-L3-18's "any change to existing work shown separately and applied only if ticked" needs the same
   per-row accept extension already flagged in L3-LEVELS §2.5 and L3-SOURCES §2.8 — a third consumer of the
   same one piece of work, not a third build of it.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Missing.** Same shared Level 3 Proposals surface recommended in
   `L3-SOURCES_CARD_2026-09-26.md` OPEN 4, offered last among the four proposal types, consistent with
   UX-L3-02's build order.
2. **Prompts — Missing.** New: confirm which inputs are missing before proposing (site/boundary survey, an
   outlet/LPD, catchment/flow data) — UX-L3-15 requires these gaps to be **listed**, not silently assumed.
3. **Selection — not applicable.** Whole-site scope, matching the other Level 3 proposals.
4. **Preview — Missing, shared chooser.** Three (or two) option panels — plan picture, key figures (pipe
   length, pit count, cover/grade summary), a highlighted difference line — then the picked option as a
   full-size ghost over the real drawing (new pipes/pits only; existing drawn work renders as itself, not
   ghosted), switching swaps the ghost, per UX-L3-17/19/20. Any proposed **change** to an existing pit/pipe
   (as opposed to a new addition) is shown as its own separate, individually-tickable item in the same review,
   per UX-L3-18 — never bundled into "accept the whole layout."
5. **Drawing output — Missing new writer, Keep the underlying commands.** New pits/pipes write through the
   same existing placement commands every other Level 3 card already reuses (pit placement, pipe creation via
   `PipeCreationService`, source auto-join via `UX-SRC-05`'s existing mechanism) — this card orchestrates which
   pieces are needed and where, it does not add a new drawing-write path.
6. **Cancel — Keep, unchanged principle.** No drawing change; matches every other Level 3 card and the approved
   sketch's Cancel button.
7. **Escape — Keep, unchanged principle.** Closes the chooser without writing anything.
8. **One Undo — Missing, to be built to this shape.** Accepting one option (new pits/pipes plus any ticked
   changes to existing work) applies as one transaction, one Undo — the same requirement as every other Level 3
   card in this batch.
9. **Save/reopen — not applicable.** Accepted objects are ordinary drawing data, already covered.
10. **Where values come from (Settings/council) — Keep, unchanged.** Minimum cover, grade tables and clash
    distances (easement band, TPZ/SRZ) are already Settings/council values (R-00); this card introduces no new
    hard-coded geometry rule — route/set-off **patterns** come from learning (UX-L3-16), not a coded constant.

## 4. Example drawings

1. **DWG-A (Civil), boundary and outlet only, no pits/pipes drawn** — the "propose everything" case, exercising
   UX-L3-15's gap-listing when catchment/flow data is also missing.
2. **DWG-B (Civil), partially drawn** — some pits and pipes already placed (e.g. from a completed L3-SOURCES
   run), some of the network missing — exercising UX-L3-18's "build around existing work."
3. **A variant with one candidate route crossing a tree's TPZ/SRZ or the council easement band**, reusing the
   same clash scenario as `L3-DETENTION_CARD_2026-09-26.md` §4.2 rather than inventing a new one.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (proposed, not run for this card):**
   - A synthetic test proving a layout proposal over a **partially drawn** network never re-proposes or
     silently alters an already-drawn pit/pipe, only adds what's missing (UX-L3-18).
   - A test proving each of 2-3 proposed options independently passes `NetworkDesignService` feasibility
     (minimum cover, grade, no Fixed-level conflict) before being offered — an infeasible geometric option is
     never shown as if it were valid.
   - A shared clash-check test (reusing L3-DETENTION's Slice 2 engine) proving a route through a TPZ/SRZ or
     easement band is flagged, not silently routed through.
   - A `ProposalPreviewViewModel`-family test proving accept of new-work-plus-ticked-changes still yields one
     `ChangePlan` Apply (shared test shape with every other Level 3 card).
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A (empty site). Run the layout proposal. **Right result:** three option panels with plan pictures
     and key figures; missing inputs (if any) are listed plainly, not silently assumed.
   - Open DWG-B (partial network). **Right result:** existing pits/pipes are shown as themselves, not ghosted;
     only the missing pieces appear as ghost proposals; a suggested change to an existing pipe (if any) is its
     own separately-tickable item, not bundled into the whole-layout accept.
   - Open the clash variant. **Right result:** the option routed through the tree zone or easement band shows
     the same clash wording as the detention card's equivalent case.
   - Accept one option (with one ticked existing-work change), then Undo once. **Right result:** every new
     pit/pipe and the one ticked change revert together; nothing else on the drawing is touched.

## 6. Slices — smallest first

1. **Slice 1 — reuse the L3-DETENTION chooser, no new UI.** Confirm the plan-picture/real-drawing-ghost
   component built for `L3-DETENTION_CARD_2026-09-26.md` Slice 3 is genuinely shared, not duplicated, before any
   layout-specific work starts (UX-L3-19).
2. **Slice 2 — gap listing over an existing partial network.** Walk the drawing's current pits/pipes/sources
   and produce a plain list of what a complete network would still need, with Unknown for anything the
   available inputs can't determine (UX-L3-15). No route geometry proposed yet.
3. **Slice 3 — one learned route/layout option, feasibility-checked.** Wait until enough past jobs have been
   learned. Until then, say so and offer no layout. Validate a learned candidate through
   `NetworkDesignService` and the shared clash check (reusing L3-DETENTION Slice 2) before showing it.
4. **Slice 4 — 2-3 options side by side.** Extend Slice 3 to produce genuinely different candidate layouts, not
   the same one shown three times (UX-L3-17; see OPEN 3 on what varies between them).
5. **Slice 5 — build-around-existing-work with separately ticked changes.** The full UX-L3-18 behaviour: new
   work proposed, any change to existing work shown and applied only if separately ticked, one Undo for the
   accepted whole.

## 7. OPEN questions, each with a recommended answer

1. **DECIDED — insufficient learned examples.** Tim: *"Say so, offer nothing (Recommended)"* (26 Sep).
   State that too little has been learned and show no network layout option. Do not use a fixed geometric
   substitute rule or a guessed route.
2. **OPEN — should the combined footings/services/easement/tree-zone clash check be one shared engine across
   L3-DETENTION and L3-NETWORK, built once?** Both cards need the identical checks. *Recommended:* yes — build
   it once as part of L3-DETENTION's Slice 2 (it is needed there first, per the build order) and have this
   card's Slice 3 consume it directly, avoiding two clash engines that could quietly drift apart.
3. **OPEN — what actually varies between the "2-3 options" for a full layout, when nothing about the site
   forces a natural split the way detention archetypes do (tank vs pit vs pipe)?** *Recommended:* vary the
   learned route/set-off pattern itself — e.g. options drawn from different clusters of past similar jobs, or a
   shortest-total-length pattern versus a fewest-pits pattern — each independently feasibility-checked, rather
   than presenting cosmetic variations of the same route; needs Tim's confirmation once UX-LEARN-01 exists to
   show real learned alternatives, not synthetic ones.
4. **OPEN — how does a proposed new pipe reconcile with an already-placed source (from L3-SOURCES) or an
   already-sized detention system (from L3-DETENTION), if either was proposed but not yet Accepted in the same
   session?** *Recommended:* this proposal only ever reads the **current drawing state** — an un-accepted
   L3-SOURCES or L3-DETENTION proposal is not yet real and is invisible to it, exactly as any other pending,
   unaccepted change would be; a drafter who wants the layout proposal to see a source or detention system must
   accept that proposal first, consistent with the stated build order (levels, then sources, then detention,
   then layout).
