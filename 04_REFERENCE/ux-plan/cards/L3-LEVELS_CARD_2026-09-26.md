# L3-LEVELS workflow card — Level 3 proposal 1: levels and grades for a drawn network

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Level 3 proposal 1:
levels for a drawn network — 26 Sep 00:55 2026" (UX-L3-03..06), read together with "Level 3: Civil design
proposals — 26 Sep 00:52 2026" (UX-L3-01, UX-L3-02) which sets this as build order item (1) of four, and
`decisions/2026-09-23_HOLD_GRADE_HOLD_LEVELS.md` (Hold grade / hold levels, 23 Sep 2026), which this proposal
builds on. **APPROVED-IN-PRINCIPLE** wherever Tim's own ruling settles the point (marked below); only genuinely
unsettled points are left OPEN.

## 1. What Tim ruled, and what it builds on

1. **UX-L3-01 (scope):** all four Level 3 proposal types are wanted; each shows a preview first, accepts or
   adjusts per item, one Undo; learns from past jobs and corrections (`UX-LEARN-01`); never silently changes an
   engineering rule; Unknown is never guessed.
2. **UX-L3-02 (build order):** "Levels, sources, detention, layout" — this card is build item (1), and is the
   only one of the four with no other Level 3 dependency, since it builds directly on two things that already
   exist and are approved: Hold grade / hold levels (23 Sep) and Solve Run.
3. **UX-L3-03 (start):** "Fit between both ends" — hold the outlet/LPD invert and minimum cover at the top
   pits; fit grades between; if impossible, say where and by how much.
4. **UX-L3-04 (hand-typed levels):** "Keep them fixed" — treated as fixed controls; flagged if they make the
   network impossible.
5. **UX-L3-05 (preview):** "Ghost labels + was/now list" — ghost invert labels on the plan plus a
   pit/was/now/why list; accept all or per pit; one Undo.
6. **UX-L3-06 (no solution):** "Show shortfall + options" — CE states the shortfall at the worst pit and offers
   flatter grades (if allowed), a charged system, a pump, or reduced cover with a reason; the user chooses; CE
   never forces one.

## 2. What works today — Keep / Modify / Missing

Read from `origin/master` at `bde0c9a9` in `C:\Lisp Files\CE_ACAD_PLUGIN` (26 Sep 2026). No client drawing,
client name or site address was opened.

1. **CDRUNSOLVE ("Solve Run") already does most of the mechanics for one run — Keep, and this card's engine.**
   `Modules/Drainage/Commands/RunSolveCommand.cs` already: picks a start pit; resolves the run's downstream end
   in priority order — (1) the LPD-designated pit if the drawing has one (`ProposalApplyService.FindLpdPit`),
   (2) a pit the user picks, defaulting to the network's natural end; walks the connected pipes
   (`ProposalApplyService.WalkDownstreamRun`); excludes existing/council pipes at the boundary
   (`TryTrimAtExistingPipe`); calls the one shared `NetworkDesignService.Design` (the same engine CDCALC,
   CDEDIT and Inspector use, per CV-02 HD2); builds a `ChangePlan` (`ProposalApplyService.BuildRunSolvePlan`);
   shows `ProposalPreviewDialog`; and applies via `ProposalApplyService.Apply` only on explicit confirmation,
   as one AutoCAD transaction (one Undo). This is UX-L3-03's engine, already built and already the one CV-02
   HD2/HD9 hydraulic authority — L3-LEVELS does not add a second solver.
2. **Minimum cover and Fixed-level feasibility already exist in `NetworkDesignService` — Keep.**
   `Modules/Drainage/Services/NetworkDesignService.cs` already checks obvert cover against
   `standards.MinCoverMm` at both ends of every pipe (lines ~360-475) and marks a pipe `Feasible: false` with a
   `COVER:` note when cover fails; `FixedDownstreamInvert` already anchors a solve to a held invert
   (consistent with CV-02 HD9, "Fixed levels always win → No feasible solution, never move survey"). This is
   the same engine UX-L3-03's "hold the outlet/LPD invert and minimum cover at the top pits" needs — it is not
   new hydraulics.
3. **Hand-typed levels as fixed controls — Keep the mechanism, Modify its reach.** `decisions\2026-09-23_HOLD_GRADE_HOLD_LEVELS.md`
   already rules that nothing typed by hand is silently kept or overwritten — every automatic number is shown
   for confirmation against what was typed, in a preview window (the existing CDPROPAGATE / Pipe Edit "Cascade
   Preview"). That is a **per-move** behaviour (one pipe end moves, downstream pipes are recalculated). UX-L3-04
   asks for the same "typed level always wins, flagged if it breaks the network" principle applied across a
   **whole run solve**, which is new: CDRUNSOLVE today has no concept of "this pit's level is Designed and may
   move" versus "this pit's level is Fixed/manual and must not move" — it only ever holds the two ends
   (start/LPD anchor) and lets every pit in between move. **Missing.**
4. **Ghost invert labels — Keep the mechanism, Missing the content.** `Modules/Drainage/Rules/EditGhostPlan.cs`
   already draws dashed "ghost" shapes over the real drawing — `GhostKind.Outline`, `GhostKind.Text` and
   `GhostKind.Leader` — ruled by Tim on 18 September 2026 ("ghost on top": leave the real drawing alone, draw
   the proposal over it). Today it is used only for pit-resize preview (BUG-151,
   `Modules/Drainage.Tests/Rules/EditGhostPlanTests.cs`). UX-L3-05's "ghost invert labels on the plan" reuses
   exactly this mechanism (`GhostKind.Text` at each pit, `GhostKind.Leader` if a label needs to move clear of
   the pit) — the ghost renderer is a Keep; feeding it invert-label content from a whole-run solve is new.
5. **Pit/was/now/why list and per-pit accept — Modify.** `ProposalPreviewViewModel.cs`
   (`Modules/Drainage/ViewModels/`) already renders `ProposalChangeRow` items with an `IsNoOp` flag and a
   plan-wide `CanApply`, and `ProposalPreviewDialog` is already the "was/now" review window CDRUNSOLVE opens
   today — but it is **whole-plan accept or Cancel only**: there is no per-row `IsSelected` toggle in the
   current view model. UX-L3-05's "accept all or per pit" needs a per-row checkbox added to this existing
   dialog, not a new window.
6. **No-feasible-solution reporting — Modify.** `NetworkDesignService` already returns `Feasible: false` with a
   plain-English `COVER:`/grade note per pipe (§2.2 above) and `AllFeasible` at the plan level, but it stops at
   "this pipe/pit fails" — it does not today identify the single **worst** pit across a run, state the
   shortfall **by how much** (e.g. "62 mm short of minimum cover" or "1:140 needed, 1:97 available"), or offer
   the four named options (flatter grade if allowed, charged system, pump, reduced cover with a reason). Those
   are new, built on the existing per-pipe `Feasible`/note data, not a new hydraulic path.
7. **Learning from past jobs and corrections — Missing (shared with every Level 3 proposal).** Per
   `UX-LEARN-01_CARD_2026-09-25.md`, `SuggestionLedgerService` ("FEATURE 10 SEED") already records the right
   signals privately (e.g. `SuggestionLedgerService.RecordPlanCreated`/`RecordPlanCancelled`, already called by
   `RunSolveCommand` for CDRUNSOLVE) but nothing reads them back into a suggestion yet. UX-L3-01's "learned from
   past jobs and corrections" for this proposal rides on that same still-unbuilt read-back path — this card
   does not duplicate it.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Modify.** Today: CDRUNSOLVE is a typed/ribbon command a drafter runs explicitly per run
   (start pit → end pit). Intended: the same trigger point, offered as a Level 3 proposal — either the same
   CDRUNSOLVE entry point extended to hold Fixed pits, or a clearly related "Design levels for this network"
   entry beside it (OPEN 5 below). No new hydraulics either way.
2. **Prompts — Keep, unchanged.** Start pit pick, then end pit pick/Enter for natural end, exactly as
   CDRUNSOLVE does today.
3. **Selection — Modify.** Today CDRUNSOLVE only ever treats the two ends (start, LPD/chosen end) as fixed.
   Intended: any pit carrying a hand-typed (manual/Fixed) level anywhere in the run is also held, per UX-L3-04.
4. **Preview — Modify.** Today: one "was/now" `ProposalPreviewDialog` list, whole-plan Apply/Cancel only, no
   ghost graphics on the plan itself. Intended: the same dialog gains a pit/was/now/why column and a per-row
   accept checkbox (§2.5), and the drawing itself shows ghost invert labels at each affected pit while the
   dialog is open (§2.4), so the drafter can see the change on the plan and read the reason together.
5. **Drawing output — Keep, unchanged mechanism.** Accepted changes write through the existing
   `ProposalApplyService.Apply` → `ChangePlanApplyResult`, exactly as CDRUNSOLVE does today — real invert
   labels, not ghosts, only appear once accepted.
6. **Cancel — Keep, unchanged.** Cancel/close leaves the drawing untouched (`ed.WriteMessage("...Cancelled —
   drawing unchanged.")` today); ghost graphics are cleared.
7. **Escape — Keep, unchanged.** Escape during pit selection cancels the pick, as today.
8. **One Undo — Modify.** Today, one accepted CDRUNSOLVE plan is one Undo covering every changed invert.
   Intended: the same holds when only some pits are accepted (per-pit accept, §2.5) — the applied subset is
   still one transaction, one Undo, not one Undo per pit.
9. **Save/reopen — not applicable.** No new persisted state; accepted inverts are ordinary pit/pipe data,
   already covered by existing save/reopen behaviour.
10. **Where values come from (Settings/council) — Keep, unchanged.** Minimum cover, the grade table and the LPD
    identifier are already Settings/council values (`SettingsService.Current.DesignStandards`,
    `PipeSizingStandards`, per CV-02 HV2/HV8/R-00) — this card adds no new hard-coded number. The "flatter
    grade (if allowed)" option in UX-L3-06 reads whichever grade table already applies (office baseline or
    council override); CE does not invent a flatter grade the table forbids.

## 4. Example drawings

1. **DWG-A or DWG-B (Civil), in `C:\Lisp Files\_TEST_COPIES_20260923`:** a drawn network with a clear LPD and
   at least one branch with more than two pits, so "worst pit" and "was/now per pit" are both exercised.
2. **A variant with one hand-typed (manual) level partway down a run**, to exercise UX-L3-04's fixed-control
   flag, and **a variant where the outlet invert and top-pit minimum cover cannot both be met**, to exercise
   UX-L3-06's shortfall-and-options path.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (extend existing tests, add focused new ones — proposed, not run for this card):**
   - Extend `NetworkDesignServiceTests` with a case that has a manually-flagged fixed pit mid-run and asserts
     it is held while other pits move, and a case with no feasible solution that asserts the worst pit and the
     numeric shortfall are both identifiable from the result.
   - A synthetic `EditGhostPlan`-style test proving invert-label ghost content matches the plan's was/now rows.
   - A `ProposalPreviewViewModel` test proving a partial per-row acceptance still produces exactly one
     `ChangePlan` Apply (one Undo), mirroring the existing `ProposalApplyServiceFixAllTests` pattern.
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A. Run the levels proposal on a multi-pit branch. **Right result:** ghost invert labels appear at
     every pit CE proposes to change, with a was/now/why list beside them; accepting all applies every change
     as one Undo.
   - Repeat, but reject one pit in the list. **Right result:** only the accepted pits change on Undo-back-check
     (Undo once removes exactly the accepted subset, nothing more).
   - Open the hand-typed-level variant. **Right result:** the typed pit is shown as a fixed control and is
     never proposed a new level; if it makes the network impossible, CE says so plainly, not silently.
   - Open the no-solution variant. **Right result:** CE names the worst pit and the exact shortfall (e.g. "P6:
     43 mm short of minimum cover"), and offers the four named options without forcing one.
   - Press Escape mid-pick. **Right result:** unchanged from today's CDRUNSOLVE Escape behaviour.

## 6. Slices — smallest first

1. **Slice 1 — fixed-control pits inside a run solve.** Extend `NetworkDesignService`/`BuildRunInputs` so a pit
   flagged manual/Fixed anywhere in the walked run is held (not just the two ends), and is flagged in the
   result if it makes the run infeasible (UX-L3-03 + UX-L3-04). No UI change yet.
2. **Slice 2 — worst-pit shortfall reporting.** Add "which pit, by how much" to the existing infeasible-result
   data, and the four named options text (flatter grade if allowed / charged system / pump / reduced cover
   with a reason) as plain informational text only — no new commands (UX-L3-06).
3. **Slice 3 — was/now/why list + per-pit accept in `ProposalPreviewDialog`.** Add the pit column, the why
   text, and a per-row checkbox that still applies as one transaction (UX-L3-05, second half).
4. **Slice 4 — ghost invert labels on the plan.** Feed the run-solve was/now rows into `EditGhostPlan`
   (`GhostKind.Text`/`Leader`) so the drafter sees the proposal on the drawing while the list is open
   (UX-L3-05, first half).
5. **Slice 5 — entry point and wording.** Settle OPEN 5 below and wire the chosen entry point; this is
   presentation only once Slices 1-4 exist.

## 7. OPEN questions, each with a recommended answer

1. **OPEN — what exactly counts as a "top pit" whose minimum cover is held, when a run branches?** UX-L3-03's
   wording ("hold the outlet/LPD invert and minimum cover at the top pits") reads naturally for one straight
   run (CDRUNSOLVE's existing shape); it is less obvious for a branching network. *Recommended:* run the
   existing CDRUNSOLVE engine once per branch feeding the same LPD/outlet (each branch's own topological start
   pits are its "top pits"), and present every branch's was/now rows together in one combined review — this
   reuses the existing single-run engine rather than building a new whole-network solver, consistent with
   UX-L3-02 putting this proposal first because it "builds on Solve Run."
2. **OPEN — does "impossible" mean only a Fixed-level conflict (CV-02 HD9), or also a grade-table/cover
   breach with no Fixed conflict?** *Recommended:* both — reuse `NetworkDesignService`'s existing `Feasible`
   flag and cover/grade notes as the single source of "impossible," exactly as CDCALC/CDEDIT/Inspector already
   do (HD2's "one engine" rule), rather than defining a second, narrower feasibility test just for this
   proposal.
3. **OPEN — which stored provenance marks a level as "hand-typed" for UX-L3-04's fixed-control rule?**
   *Recommended:* the same `Designed`/manual-vs-derived provenance CV-02 HD5 already defines for design flow,
   applied to invert/cover levels — a level entered directly (Pit dialog, or a Pit Schedule edit under
   UX-SCHED-01b) is Fixed; a level CE last calculated is not, until the drafter locks it.
4. **OPEN — does this proposal replace or sit beside the existing per-move Hold grade / Hold levels
   behaviour (23 Sep)?** *Recommended:* sit beside it. Hold grade/Hold levels stays the automatic behaviour
   when a drafter drags one pipe end; L3-LEVELS is a separate, explicit, on-demand whole-run design action
   (like CDRUNSOLVE today) that a drafter chooses to run — the two never fire on the same edit at the same
   time, so there is no conflict to arbitrate.
5. **OPEN — ribbon/menu entry point: extend CDRUNSOLVE itself, or add a new command beside it?** Not covered
   by UX-L3-02/03 (build order only, not UI placement). *Recommended:* extend CDRUNSOLVE — it is already the
   Solve Run Inverts button on the Review panel (UX-RIBBON-02, "keep all three"), already does the walk/solve/
   preview/apply mechanics, and Tim's own UX-L3-02 language ("building on Solve Run") reads as one capability
   growing, not two buttons for the same job. Needs Tim's yes before Slice 5.
