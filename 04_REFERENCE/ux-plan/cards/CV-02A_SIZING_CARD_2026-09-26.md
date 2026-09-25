# CV-02A workflow card — pipe-size suggestions (advisory, never Apply)

**APPROVED — plan only (26 Sep 2026).** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Pipe-size suggestions
(CV-02A) and Structural timing — 26 Sep 00:08 2026" (UX-SIZE-01..03), read together with the July plan
`archive\plugin-docs-july-2026\workflows\CV-02A_ASSISTED_PIPE_SIZING_PLAN.md` (not approved then — this card
builds on it, corrected by the 26 Sep rulings) and `04_REFERENCE\CARDS\CV-02_HYDRAULIC_DESIGN.md` (the approved
hydraulic engine and rule values this advisory must not duplicate). The release-chat choice below closes the
mode question; other build details remain OPEN.

**Decision and implementation calls (26 Sep):** Tim: *"Engineer mode only (Recommended)"* — **Accept all**
appears only in Engineer mode. **IMPLEMENTATION CALLS, not Tim's words:** Unknown stays separate from **No size
works**; sizing-rule sign-off reuses the network-redesign sign-off pattern.

## 1. What Tim ruled, and what it corrects from July

1. **UX-SIZE-01 (where suggestions appear):** "Pipe window + Proposals" — one advisory line in the Pipe window
   while drawing or editing (never changes the pipe), and the whole-network review in Project Review >
   Proposals.
2. **UX-SIZE-02 (modes):** "Yes, tie them" — Draftsperson mode checks against the supplied design (`Matches` /
   `Different` / `Can't verify`); Engineer mode suggests sizes (`Keep` / `Upsize` / `Unknown` / `No size
   works`).
3. **UX-SIZE-03 (accept all):** "Accept all allowed" — after the preview, `Accept all` applies the clear
   suggestions in one Undo; Unknown and no-feasible-size pipes are never included and stay listed. **This
   supersedes the July plan's "visit every pipe first" gate** (July: `Accept all reviewed suggestions` is
   unavailable until every pipe, unchanged row, warning, Unknown and infeasible result has been visited).
4. **Unchanged from July, not re-asked:** no automatic downsizing (information note only); the numeric sizing
   rules still need engineer sign-off before production suggestions (July's CV-02A4 gate).
5. **Corrected premise carried from the discussion chat:** the earlier record that "CV-02's card file does not
   exist" (`areas/release-v3-colleagues.md` item 89, 24 Sep) is stale — item 176 (26 Sep 00:13) found all 37 July
   cards including `CV-02_HYDRAULIC_DESIGN.md` on `origin/master` at `docs/CARDS/`, now also copied into
   `C:\CE_PLAN\04_REFERENCE\CARDS\`. This card reads that copy directly; it does not restate HD1-15/HV1-15,
   only what changes for the advisory UI.

## 2. What works today — Keep / Modify / Missing

Read from `origin/master` at `bde0c9a9` in `C:\Lisp Files\CE_ACAD_PLUGIN` (26 Sep 2026). No client drawing,
client name or site address was opened.

1. **One advisory calculation path already exists — Keep, this card's engine.**
   `Modules/Drainage/Services/PipeFlowSizingAdvisorService.cs` (FEATURE 6, 2026-07-02) is already exactly the
   "advisory line" engine UX-SIZE-01 asks for: a pure, AutoCAD-free advisor that reads the CDEDIT suggestion
   strip's optional Q (design-flow) box, delegates entirely to `PipeSizingSolver.TrySize` (no formula
   duplicated), and returns one of `PipeFlowSizingVerdict.KeepDiameter`, `.Upsize` or `.Infeasible` against the
   pipe's **drawn** diameter — never proposing a smaller pipe than drawn (the no-downsizing rule, already
   built). This already matches Engineer mode's `Keep` / `Upsize` / `No size works` three of four outcomes.
2. **It is already wired into the Pipe window today — Keep.** `Modules/Drainage/Commands/PipeEditCommand.GradeSuggestion.cs`
   calls `PipeFlowSizingAdvisorService.Advise` and `Modules/Drainage/ViewModels/CdViewModel.GradeSuggestion.cs`
   (`SetFlowSizingSuggestion`, `BuildFlowSizingTooltip`) already surfaces the verdict and a tooltip in the
   CDEDIT/CD suggestion strip whenever Q is filled in — this is UX-SIZE-01's "one advisory line in the Pipe
   window while drawing or editing (never changes the pipe)" already built and already never writing the
   drawing. **Missing:** an explicit `Unknown` verdict distinct from `Infeasible` — today's three verdicts don't
   yet separate "no size works" from "can't tell" (see §3.4/OPEN 1).
3. **Engineer/Draftsperson as a per-job setting already exists — Keep, this card's mode switch.**
   `Modules/Drainage/Rules/CivilDesignWorkflow.cs` already defines `CivilDesignRoute.Engineer` /
   `.Draftsperson` / `.ContinueExisting` ("Card #45, Tim's three routes"), chosen at CDDESIGN start and read
   back by `CivilDesignWindowViewModel`. UX-SIZE-02's "tie them" reads naturally as: the job's already-chosen
   route decides which of the two CV-02A modes a drafter sees — this card does not need a second, separate
   mode picker.
4. **Whole-network review page — Missing.** There is no `PipeFlowSizingResult` consumer today outside the
   single-pipe CDEDIT/CD strip — no "Project Review > Proposals" surface exists yet for pipe sizing
   specifically. `Modules/Drainage/ViewModels/DesignCheckDashboardViewModel.cs` and
   `Dialogs/ProposalPreviewDialog.xaml.cs` already exist as the general "whole-plan preview, was/now list,
   accept" shell (the same one CDRUNSOLVE and the Fix-All dashboard use), so UX-SIZE-01's "Proposals" half is a
   new tab/page inside that existing family of views, not a new pattern.
5. **`Accept all` in the existing `ChangePlan`/`ProposalPreviewDialog` family — Modify.**
   `Modules/Drainage.Tests/Services/ProposalApplyServiceFixAllTests.cs` already proves a "fix all" plan applies
   as one transaction, one Undo, with no-op rows filtered by `EffectiveChanges`. UX-SIZE-03's rule — accept the
   clear suggestions, Unknown and no-feasible pipes never included and stay listed — is a filter on which rows
   are eligible for `Accept all`, built on this existing machinery, not a new apply path. It also **reverses**
   the July plan's stricter gate (§1.3 above): today's `ProposalPreviewViewModel` has no "every row must be
   visited first" gate at all, so this is actually the simpler of the two behaviours to build.
6. **Mode A (Draftsperson) "compare against the supplied design" — Missing.** Nothing today reads a named
   external plan/revision and compares it against the drawing (`Matches` / `Different` / `Can't verify`). The
   closest existing pattern is `UX-STRUC-11`/`ST-07`'s Excel-schedule-driven size change (a different
   discipline, same shape: an external authoritative document drives a comparison) and the D+F card's rating-
   report intake review (`04_REFERENCE\civil-D-F\DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md`, "one
   confirmation listing every value and its source"). This card's Draftsperson mode is new work following that
   same shape: a named document + revision, a source per value, `Cannot verify` when the document doesn't say.
7. **Numeric sizing rules still gated behind engineer sign-off — Keep, unchanged.** The July plan's production
   blockers stand exactly as written: `MaterialVelocityLimits` placeholder scour caps, full-bore-vs-part-full
   self-cleansing (CV-02 HD7, still "not verified"), incomplete council cover/class/loading rules, and DATA-01
   approved-job validation (still blocked). **What exists today for "sign-off" specifically:** nothing yet —
   there is no `RuleApproval`/engineer-sign-off record type in the codebase today; the closest built mechanism
   is `NetworkRedesignSignOffService` (a different feature, C-family network redesign) whose shape — binds a
   named person, time, and exact record hash — is the right pattern to reuse for CV-02A4's future rule-pack
   sign-off, not a proof that it already exists for pipe sizing.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Keep (Pipe window), Missing (Proposals).** Pipe window: unchanged, already fires whenever
   Q is filled in during CD/CDEDIT. Proposals: a new tab in Project Review, alongside the existing
   dashboard/Fix-All family.
2. **Prompts — Keep, unchanged.** No new command-line prompt; Q entry in the Pipe window is unchanged.
3. **Selection — Missing (Proposals only).** The whole-network review needs a network/run scope, the same
   connectivity walk CDRUNSOLVE already uses (`ProposalApplyService.WalkDownstreamRun`) rather than a new
   selection mechanism.
4. **Preview — Modify.** Pipe window: the existing tooltip/strip line stays a one-line advisory, extended with
   the mode split (§3 below) and, in Draftsperson mode, the `Matches`/`Different`/`Can't verify` wording.
   Proposals: the existing was/now `ProposalPreviewDialog` shell, extended with per-row `Keep`/`Upsize`/
   `Unknown`/`No size works` (Engineer) or `Matches`/`Different`/`Can't verify` (Draftsperson) and an `Accept
   all` that only ever selects clear (non-Unknown, feasible) rows, per UX-SIZE-03.
5. **Drawing output — Keep, unchanged principle.** The Pipe-window line **never** changes the pipe (explicit in
   UX-SIZE-01's own wording, and already true of today's advisory strip). Only an accepted Proposals-page
   `Accept all`/per-row accept writes the drawing, and only the diameter/label/schedule fields the July plan's
   result model already names — production Pass/Fail and Apply remain blocked exactly as July ruled (§1.4
   above); this card is the A1-A3 advisory layer only.
6. **Cancel — Keep, unchanged.** Closing the Proposals review or the Pipe window without accepting changes
   nothing, matching every other preview dialog in the app.
7. **Escape — Keep, unchanged.** No pending drawing state to discard.
8. **One Undo — Keep, unchanged mechanism.** `Accept all` (or a per-row accept subset) applies as one
   transaction through the existing `ChangePlan`/`ProposalApplyService.Apply` path.
9. **Save/reopen — Keep, unchanged.** No new persisted state beyond ordinary pipe/label/schedule data already
   covered by save/reopen.
10. **Where values come from (Settings/council) — Keep, unchanged.** `PipeSizingStandards`/
    `MaterialVelocityLimits` are already Settings-sourced per CV-02 HV1-15/R-00; this card adds no new number,
    and explicitly must not let a production-eligible request touch
    `PipeSizingStandards.CreateDefault`/`MaterialVelocityLimits.BuildStandards`'s known-placeholder values (July
    plan, "A1/A2 boundary" — carried forward unchanged).

## 4. Example drawings

1. **DWG-A or DWG-B (Civil):** a drawn network with at least one pipe that is oversized, one undersized for its
   Q, and one with no Q entered (exercises Keep/Upsize/no-suggestion in the Pipe window).
2. **A Draftsperson-mode variant** with a named supplied design document (synthetic, `NOT FOR DESIGN · NOT
   VERIFIED` watermark per the July plan) carrying one pipe that matches, one that differs and one it cannot
   speak to.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (extend existing tests, add focused new ones — proposed, not run for this card):**
   - Extend `PipeFlowSizingAdvisorService`'s existing test coverage with an explicit `Unknown` case, distinct
     from today's `Infeasible`, per OPEN 1 below.
   - A `ProposalPreviewViewModel`-family test proving `Accept all` selects only Keep/Upsize-eligible rows and
     leaves Unknown/no-feasible rows both excluded and still listed (UX-SIZE-03), mirroring the existing
     `ProposalApplyServiceFixAllTests` shape.
   - A `CivilDesignRoute`-driven test proving the Proposals page renders Engineer wording for
     `CivilDesignRoute.Engineer` jobs and Draftsperson wording for `.Draftsperson` jobs from the same
     underlying `PipeFlowSizingResult` data (UX-SIZE-02).
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A in an Engineer-route job. Draw/edit a pipe with Q filled in. **Right result:** one advisory
     line/tooltip, the pipe's own diameter unchanged.
   - Open Project Review > Proposals. **Right result:** every pipe listed (Keep/Upsize/Unknown/No size works),
     `Accept all` enabled only for the clear rows, Unknown and infeasible rows still shown but excluded.
   - Accept all, then Undo once. **Right result:** every accepted diameter/label/schedule change reverts
     together.
   - Repeat in a Draftsperson-route job with the supplied-design variant. **Right result:** `Matches` /
     `Different` / `Can't verify` wording, no size-changing suggestion offered.

## 6. Slices — smallest first

1. **Slice 1 — Unknown verdict.** Add an explicit `Unknown` outcome to `PipeFlowSizingAdvisorService` distinct
   from `Infeasible` (OPEN 1), with tests. No UI change.
2. **Slice 2 — Proposals page, Engineer mode, read-only.** Build the whole-network review tab reusing the
   `ProposalPreviewDialog`/`DesignCheckDashboardViewModel` shell, Engineer wording only, no Accept yet.
3. **Slice 3 — Accept all with the UX-SIZE-03 filter.** Wire `Accept all` to the existing `ChangePlan`/Apply
   path, selecting only clear rows, one Undo.
4. **Slice 4 — Draftsperson mode.** Add the supplied-design intake/comparison (`Matches`/`Different`/`Can't
   verify`), reusing the D+F card's "one confirmation, source per value" shape.
5. **Slice 5 — Pipe-window mode wording.** Switch the existing CDEDIT/CD advisory line's wording by
   `CivilDesignRoute` (Engineer vs Draftsperson phrasing) — cosmetic once Slices 1-4 exist.

## 7. OPEN questions, each with a recommended answer

1. **IMPLEMENTATION CALL — `Unknown` differs from `Infeasible`.** Today `PipeFlowSizingAdvisorService`
   only returns `Infeasible` for "no diameter carries this flow" and for missing/invalid input (no diameter, no
   length, no flow) — UX-SIZE-02 wants a genuine `Unknown` (can't tell) distinct from `No size works` (proven
   infeasible). *Recommended:* keep `Infeasible` for a proven no-size-works result (every catalogue diameter
   checked and rejected) and add `Unknown` specifically for missing/unverifiable input (no Q, no material, a
   scour cap still placeholder per July's A1/A2 boundary) — this mirrors CV-02 HD12/HD15's existing
   Pass/Advisory/Fail/Unknown/No-feasible-solution five-state pattern instead of inventing a sixth.
2. **OPEN — what exactly triggers Draftsperson's `Cannot verify` versus `Different`?** *Recommended:* `Cannot
   verify` when the supplied document doesn't state a value for that pipe at all (or the document/revision is
   stale/unresolved, per the July plan's staleness rule); `Different` only when the document states a value and
   the drawing disagrees with it — never inferred from a missing note.
3. **DECIDED — Accept all mode.** Tim: *"Engineer mode only (Recommended)"* (26 Sep). Draftsperson mode's
   rows are report-only (`Matches`/`Different`/`Cannot verify`) with no Accept all action.
4. **IMPLEMENTATION CALL — sizing-rule sign-off.** Nothing in
   the codebase today models a rule-pack approval record. *Recommended:* reuse the shape already built for
   `NetworkRedesignSignOffService` (named person, UTC time, exact record/rule hash) for a future
   `PipeSizingRuleApprovalService`, gated the same way DF's CDCALC "Issue" step already names a responsible
   engineer (`DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md` §2.9, UX-CALC-03) — this is a build note for
   CV-02A4, not something this advisory-only card needs to resolve now.
