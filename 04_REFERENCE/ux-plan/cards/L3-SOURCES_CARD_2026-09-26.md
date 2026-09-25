# L3-SOURCES workflow card — Level 3 proposal 2: downpipes and source placement

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Level 3 proposal 2:
downpipes and sources — 26 Sep 00:58 2026" (UX-L3-07..10), read together with UX-L3-01/02 (scope and build
order — this is build item (2), after L3-LEVELS) and `UX-SRC-05` (CDRG and DP placement, 26 Sep 00:24, "not
pipe dependent... placed prior to pipes connecting them"). **APPROVED-IN-PRINCIPLE** wherever Tim's own ruling
settles the point; only genuinely unsettled points are left OPEN.

## 1. What Tim ruled, and what it builds on

1. **UX-L3-07 (positions):** "Architect's DPs, else roof" — use the architect's downpipe symbols where present;
   otherwise propose from roof edges and gutters, learned from past jobs; each confirmed.
2. **UX-L3-08 (destination):** "Rating report, then nearest option shown" — from the rating report's catchment
   names; where a name doesn't say, the destination is Unknown with the likely tank/pit suggested from past
   jobs for the user to pick; never guessed silently.
3. **UX-L3-09 (numbering):** Tim, his own words: **"all option available"** — all three orders are offered as a
   choice in the preview: the learned office pattern, clockwise from the front left, and the order placed;
   renumber with one click. **Default pre-selection is explicitly not ruled** — Tim's own record says so; this
   card recommends the learned pattern (§7 OPEN 1).
4. **UX-L3-10 (preview):** "Ghost DPs + lines to destination" — ghost DP symbols with a thin line to the
   tank/pit and the catchment area; accept all or per DP; one Undo.
5. **Builds on:** `UX-SRC-05` — CDRG (raingarden/grated inlet) and DP are placed like pits: anywhere, **before**
   pipes exist; pipes drawn later connect to them (the existing auto-join, UX-PIPE-02b). This proposal
   populates that same placement, proposed rather than hand-picked.

## 2. What works today — Keep / Modify / Missing

Read from `origin/master` at `bde0c9a9` in `C:\Lisp Files\CE_ACAD_PLUGIN` (26 Sep 2026). No client drawing,
client name or site address was opened.

1. **DP/CDRG placement itself already exists — Keep, this card's write path.**
   `Modules/Drainage/Commands/SourceBlockInsertCommands.cs` already implements `DP` (`PlaceDownpipe`) and other
   tagged-source placement through one shared `PlaceTaggedSourceBlock` helper, and
   `Modules/Drainage/Services/SourcePlacementService.cs` already exists for source-placement logic including
   clash awareness. This proposal's Accept step reuses this exact placement path — it does not invent a second
   way to write a DP block.
2. **Reading an architect's DP symbols from a background/XREF — Missing.** No code today parses a background
   drawing for downpipe symbols. The nearest approved pattern is `UX-SITE-04` (25 Sep, "slab boundaries from
   the background": *"CE highlights closed outlines found in the architect's background as possible slabs;
   click to use; own pick or drawing still allowed"*) — the same shape (CE proposes from background geometry,
   confirmed, never silently trusted) is the right model for UX-L3-07's "architect's DPs where present," but
   the actual symbol-recognition logic is new work, not a reuse of existing code.
3. **Proposing a DP from roof edges/gutters when no architect symbol exists — Missing.** No roof-geometry
   downpipe rule exists in the codebase today (confirmed: no `RoofEdge`/`Gutter`/`DownpipeSuggest`-named
   service). This is genuinely new engineering content, to be seeded as a simple office rule (valley/low-point,
   maximum spacing) and then refined through corrections, per UX-LEARN-01 (§2.6 below) — it is not a case of
   wiring up something already built.
4. **Destination from the rating report's catchment names — Keep, the reader already exists.** PR #233 (D+F
   slice 1, `areas/release-v3-colleagues.md` item 136, 25 Sep) already built exactly this reader: CDCALC >
   Catchments > "Add from rating report..." finds the job folder, reads the Blue Factor/STORM report
   (`Modules/Drainage/Rules/StormReport.cs`, `BlueFactorReport.cs`), and opens one confirmation listing each
   catchment with its area **source** and **destination** in plain English — an unknown destination already
   stays Unknown, never guessed (`FigureProvenance.FromRatingReport`, `FigureSource.RatingReport`). UX-L3-08's
   "from the rating report's catchment names" is this same reader, consumed for DP destination instead of
   catchment area — a new consumer of an existing service, not a new report parser.
5. **"Likely tank/pit suggested from past jobs" when the name doesn't say — Missing (shared with every Level 3
   proposal).** Exactly the same read-back gap as L3-LEVELS §2.7: `SuggestionLedgerService` ("FEATURE 10 SEED")
   already records signals privately but nothing suggests from them yet (`UX-LEARN-01_CARD_2026-09-25.md`).
   This proposal's destination suggestion and its position/roof-rule learning (§2.3) both ride on that same
   still-unbuilt read-back path.
6. **Numbering — all three orders — Missing.** Nothing today exposes a chosen "DP numbering order." The
   drawing's current order is whatever a drafter placed (visible in `ProjectDataService`'s source records by
   placement sequence), which already gives UX-L3-09's third option ("the order placed") for free; "clockwise
   from the front left" and "the learned office pattern" are both new sequencing logic.
7. **Ghost DP symbols with a thin line to destination — Keep the renderer, Missing the content.** As in
   L3-LEVELS §2.4, `Modules/Drainage/Rules/EditGhostPlan.cs` already draws dashed ghost shapes —
   `GhostKind.Outline` (the DP symbol footprint), `GhostKind.Text` (its number/label) and `GhostKind.Leader`
   (already exactly "a thin line" — used today for a moved pit label's leader) — ruled by Tim 18 September
   2026. UX-L3-10's "ghost DP symbols with a thin line to the destination and the catchment area" is a new
   caller feeding this existing renderer three shapes per DP (symbol, line-to-destination, catchment-area
   outline), not a new drawing mechanism.
8. **Per-DP accept and one Undo — Modify.** Same gap as L3-LEVELS §2.5: `ProposalPreviewDialog`/
   `ProposalPreviewViewModel` already exist as the "was/now, whole-plan accept" shell CDRUNSOLVE uses, but have
   no per-row `IsSelected` toggle today. UX-L3-10's "accept all or per DP" needs that same per-row addition —
   one shared piece of work with L3-LEVELS §2.5, not two separate builds.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Missing.** No entry point exists yet for "propose downpipes and sources." Recommended
   placement is beside the existing `DP`/`CDRG` manual placement commands, or as a Level 3 Proposals entry
   consistent with however L3-LEVELS' equivalent question (OPEN 5 there) is answered — one consistent home for
   all four Level 3 proposals is preferable to four separate entry points (OPEN 4 below).
2. **Prompts — Missing.** New: pick/confirm the roof/architect background to read (if more than one XREF is
   loaded), matching `UX-SITE-04`'s existing background-pick pattern.
3. **Selection — Missing.** New: the catchment/roof area the proposal covers — likely the whole site by
   default, matching how CDCALC's rating-report intake already works at whole-job scope.
4. **Preview — Missing content, Keep renderer.** Ghost DP symbols (§2.7) plus a pit/DP/was-now-why list (§2.8),
   the same shape as L3-LEVELS' preview, with the addition of the three numbering-order choices and one-click
   renumber (UX-L3-09).
5. **Drawing output — Keep, unchanged mechanism.** Accepted DPs write through the existing
   `SourceBlockInsertCommands`/`SourcePlacementService` path (§2.1), each auto-joining to a later-drawn pipe
   exactly as `UX-SRC-05` already rules for a hand-placed DP.
6. **Cancel — Keep, unchanged principle.** Closing the review without accepting changes nothing, matching every
   other Level 3 preview.
7. **Escape — Keep, unchanged principle.** Cancels the pending proposal; no partial DP is left behind.
8. **One Undo — Modify.** Same as L3-LEVELS §3.8: an accepted subset (per-DP accept) still applies as one
   transaction, one Undo.
9. **Save/reopen — not applicable.** Accepted DPs are ordinary source-block data, already covered by existing
   save/reopen behaviour.
10. **Where values come from (Settings/council) — Missing (new Settings needed).** The roof-edge/gutter spacing
    rule (§2.3) and the recognised architect-symbol layer/block-name patterns (§2.2) are both new Settings
    values under R-00 ("nothing hard-coded") — this card must not bury either as a fixed constant in code.

## 4. Example drawings

1. **DWG-A (Civil) with an architect's background carrying DP symbols on a recognisable layer**, to exercise
   UX-L3-07's first branch, and **DWG-B with no architect DPs**, roof/gutter geometry only, to exercise the
   learned second branch.
2. **A variant rating report with one catchment name that clearly names its destination and one that doesn't**,
   to exercise UX-L3-08's Unknown-plus-suggestion path.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (proposed, not run for this card):**
   - A synthetic test proving the rating-report destination reader (§2.4) feeds an Unknown result, not a
     guessed pit, when a catchment name doesn't name a destination — extending the existing PR #233 test
     coverage rather than writing a parallel parser.
   - A `ProposalPreviewViewModel`-family test proving per-DP accept still yields one `ChangePlan` Apply (shared
     test shape with L3-LEVELS §5.1).
   - A numbering-order test proving all three orders (learned/clockwise/placed) produce a stable, repeatable
     sequence and that renumbering doesn't touch DPs the drafter has already accepted individually.
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A (architect DPs present). Run the proposal. **Right result:** ghost DPs appear at the
     architect's own symbol positions, each with a thin line to its proposed destination and catchment-area
     outline; each is confirmed, not silently placed.
   - Open DWG-B (no architect DPs). **Right result:** CE proposes from roof edges/gutters instead, clearly
     labelled as learned/advisory, not claimed as read from a document.
   - In the rating-report variant, inspect the catchment with no named destination. **Right result:** shown as
     Unknown with one suggested tank/pit from past jobs, never silently assigned.
   - Switch numbering order in the preview. **Right result:** all DP numbers update together in the ghost
     preview only; nothing is written until Accept.
   - Accept a subset, then Undo once. **Right result:** only the accepted DPs disappear; rejected ones were
     never drawn.

## 6. Slices — smallest first

1. **Slice 1 — destination from the rating report, Unknown-safe.** Wire PR #233's existing reader to a DP
   destination suggestion (UX-L3-08), reusing its Unknown/never-silent behaviour as-is. No geometry proposal
   yet.
2. **Slice 2 — architect DP symbol recognition.** Settings-configurable layer/block-name patterns (§3.10),
   confirmed per `UX-SITE-04`'s background-pick shape, proposing positions only where a symbol is found
   (UX-L3-07, first branch).
3. **Slice 3 — roof-edge/gutter fallback.** The seeded office spacing/low-point rule for sites with no architect
   DPs (UX-L3-07, second branch), feeding the same read-back learning path as Slice 2 once UX-LEARN-01 exists.
4. **Slice 4 — ghost preview, was/now/why list, per-DP accept.** Reuse `EditGhostPlan` and the extended
   `ProposalPreviewDialog` from L3-LEVELS Slice 3/4 (UX-L3-10) — shared UI work, not duplicated.
5. **Slice 5 — numbering choice and one-click renumber.** All three orders, default pre-selection per OPEN 1
   below (UX-L3-09).

## 7. OPEN questions, each with a recommended answer

1. **OPEN — default numbering pre-selection.** Tim's own ruling explicitly leaves this unruled ("Default
   pre-selection not ruled — this chat suggests the learned pattern"). *Recommended, as Tim's own record
   already suggests:* pre-select the learned office pattern, with clockwise-from-front-left and order-placed
   both one click away — needs Tim's yes, not assumed from silence.
2. **OPEN — what layer/block-name patterns count as "the architect's DP symbols"?** These vary office to
   office and job to job; nothing today recognises them. *Recommended:* a Settings-held, editable list of known
   patterns (seeded from real jobs, confirmed per pick, extended by correction over time) rather than one fixed
   guess — consistent with R-00 and with `UX-SITE-04`'s "click to use, own pick still allowed."
3. **OPEN — what exactly does "learned from past jobs" mean for a roof-edge/gutter DP position, absent any
   architect symbol?** No engineering rule exists today. *Recommended:* seed one simple office starting rule
   (a DP at each roof valley/low point, plus a maximum eaves-run spacing) so the proposal has something honest
   to show on day one, then let `UX-LEARN-01`'s correction-learning refine spacing/position over real jobs —
   never presented as a settled design rule while it's still a seed.
4. **OPEN — one shared Level 3 Proposals entry point, or a per-proposal button?** Not ruled by UX-L3-01/02
   (scope/order only). *Recommended:* one shared "Level 3 proposals" surface in Project Review, offering all
   four proposal types (levels, sources, detention, layout) as the build order is completed — consistent with
   UX-SIZE-01's own "Proposals" tab for pipe sizing, so drafters learn one place to look, not four. Needs Tim's
   yes, tracked the same way as L3-LEVELS OPEN 5.
5. **OPEN — does "the catchment area" ghost shown per DP (UX-L3-10) come from the rating report's stated
   catchment area, or a geometric estimate CE draws from the roof/site boundary?** *Recommended:* the rating
   report's stated area where a catchment name is matched (consistent with UX-L3-08 using the same report),
   falling back to a geometric roof-area estimate — clearly labelled as estimated, never silently presented as
   the report's own figure — only when no catchment name matches.
