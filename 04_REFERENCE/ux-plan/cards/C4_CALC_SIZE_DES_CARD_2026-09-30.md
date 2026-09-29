# C4 card - Design and calculations: UX-CALC-01..03, UX-SIZE-01..03, UX-DES-02/03 (30 Sep 2026)

**Status: card only.** Nothing here is built, Codex-tested, installed or Tim-accepted. Written by Opus (queue section 4
item 0, Opus list 5: C4 cards). Code read from `origin/claude/rel-20260929c` at `a6e0cc87` (Civil 3.0.15), read-only.
No client drawing, name or address was opened. Every engineering value below: **Needs Tim's engineering acceptance.**

## 1. Authority (the plan answers these; build to them)

1. **UX-CALC-01:** "Yes, fix it there (Recommended)": report value and your value side by side, yours marked manual; an
   unproved downpipe stays Unknown; the whole set confirmed once. (`decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` 192-195)
2. **UX-CALC-02:** "You pick, one U (Recommended)": pick the existing block/detail or a point for a new one; preview every
   change; one U takes it all back, including the saved calculation record; never overwrite an unpicked detail. (197-202)
3. **UX-CALC-03:** "Anyone, names the engineer (Recommended)": any CE user issues but picks the responsible engineer, who
   prints on the sheet; who pressed Issue and when is recorded; DRAFT - NOT FOR CONSTRUCTION until issued. (204-213)
4. **UX-CALC-04 carried:** drawn-vs-issued storage compares unrounded figures with the last issued revision, warns, no
   percentage allowance; rainfall stays on CDRAINFALL's paste/file route. (222-226) Full route:
   `04_REFERENCE/civil-D-F/DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md` sections 2, 5, 6.
5. **UX-SIZE-01..03:** Pipe window advisory line (never changes the pipe) + whole network in Project Review > Proposals;
   modes tied; Accept all applies clear rows in one U, Unknown and no-size-works never included and stay listed; no
   automatic downsizing; numeric sizing rules need engineer sign-off (CV-02A4). (906-915) Refined by UX-MODE-01/04
   (1511-1531): Accept all belongs to **Design from scratch**; **From markup** shows every suggestion, marked
   "differs from supplied design", accepted one at a time. Card: `cards/CV-02A_SIZING_CARD_2026-09-26.md`.
6. **UX-DES-02:** "Fixed CE colours (Recommended)": roof blue, driveway orange, paving purple, garden grey, unknown amber,
   every job, preview only. (586-587) Exact colours: approved mockup `docs/design/V3_UI/mockups/17-cdsetup.html` 467-472
   (roof #4f7fbf, driveway #c98a34, other paving #8f6fbf, pervious #6f7a6a, needs tracing/unknown #e2a83a).
7. **UX-DES-03:** "During (Recommended)": a part-drawn, unchanged job opens Design on During. (588) During = "what has
   changed since the design was agreed"; nothing changed = one line (`docs/design/V3_UI/windows/17_CDSETUP.md` 170, 276).
8. **Standing:** CV-02 HD5/HV13: every design flow has a source, no default flow, missing flow = Unknown
   (`04_REFERENCE/CARDS/CV-02_HYDRAULIC_DESIGN.md` 49, 94). R-00 settings-first, R-27 warn and record
   (`ENGINEERING_RULEBOOK.md` 231, 265-266). Ruling B: Codex builds windows, Claude builds behaviour
   (`decisions/2026-09-16_TEST_DAY_RESULTS.md` 188).

## 2. Per ID: what exists, classification, what the drafter does

1. **UX-CALC-01 - Modify.** Exists (slice 1, PR #233): CDCALC > Catchments > `Add from rating report...` reads the Blue
   Factor/STORM report and confirms ONE catchment (`Rules/CatchmentReportIntake.cs`,
   `ViewModels/CatchmentReportPickViewModel.cs`, `Dialogs/CatchmentReportPickDialog.xaml`); rows carry Source/Destination;
   typed rows say "Typed in". Job rainfall curve now feeds Rational Method (#278, `RationalMethodViewModel.cs`).
   Missing: the whole set in one review, side-by-side report/your value, confirm once.
   - **Clicks/sees:** same button opens one review listing every catchment: name, report area m2, "Your value" (typing
     marks the row **manual**, report value stays beside it), surface and runoff coefficient with source, destination
     (Unknown when unproved), and at the top the rainfall curve in use (job curve, or office fallback named and amber).
   - **Buttons:** `Confirm all` / `Cancel`. Esc = Cancel. No prompt, no selection, no drawing write (rows go into CDCALC;
     the draft saves through today's close guard). Save/reopen keeps manual, report and Unknown labels.
2. **UX-CALC-02 - Rebuild the Apply route; Keep the engines.** Exists: footer `Insert Criteria Block` ->
   `OnSiteDetentionCriteriaService.InsertCriteriaBlock` (point prompt then three separate transactions, built from
   `DetentionSystemSummary`, not the one record: breaks design rule 1). The one record exists
   (`Rules/ComputationsRecord.cs`, `Services/ComputationsRecordBuilder.cs`) but only feeds the sheet. Orifice pit detail
   generators exist (`Services/OrificePitDetailGenerator*.cs`, `OrificePitDetailLiveMapper.cs`, `OrificePitDetailDwgWriter.cs`)
   and are not called from CDCALC. Missing: pick target, preview, one Undo, detail from the same record.
   - **Clicks/sees:** Detention tab `Apply to drawing...` -> window hides -> command line "Pick the criteria block to
     replace or [New]:", then the same for the orifice pit detail -> before/after preview (ghost at the pick, list of
     every changed value, system, units, source, warnings) -> `Apply` / `Cancel`.
   - **Protection:** a locked-layer, Xref or REFEDIT pick is refused with a plain reason (native protection rule).
   - **Undo/Esc:** Esc at any pick or the preview writes nothing. Apply = one transaction and one Undo mark, including the
     saved calculation record. Any input, system, council or drawing change makes the preview stale; Apply re-previews.
   - **Save/reopen:** the drawing keeps which record revision each block/detail came from.
   - `Insert Criteria Block` stays until Apply passes Codex, then is hidden (never removed first; AGENTS review gate).
3. **UX-CALC-03 - Missing (Issue); Keep the sheet.** Exists: `Rules/ComputationsSheetV3.cs` prints
   "DRAFT - NOT FOR CONSTRUCTION" when `IssueState` is empty, and `ComputationsRecordBuilder.cs` 64 always sets it
   empty; Engineer/Revision/Date are typed sheet details; Approve with `ApprovedByEntry` (UX-CALC-APPROVE-01) exists;
   PDF/XLSX via `Services/CalculationExportPackage.cs`. Missing: Issue step, issue record, drawn-vs-issued warning.
   - **Clicks/sees:** Print tab `Issue...` -> one-page window: responsible engineer (pick, required to issue), revision,
     date (Melbourne), a warning band per system if drawn storage differs from the last issued figure (both m3 and the
     difference, the drawing items behind it), `Issue` / `Cancel`. Issue never refused by the warning (R-27).
   - **Output:** sheet shows the engineer, revision, date and FOR CONSTRUCTION wording; the record stores who pressed
     Issue (Windows user) and when, engineer, revision, reviewed sources, issued storage per system. PDF/XLSX export
     follow. One Undo removes the issue record; exported files are reported as not undone.
   - **Also Modify:** `Rules/ComputationsRecord.cs` 51 turns an unknown ARI into 10 years; must stay Unknown (DF card 2.6).
4. **UX-SIZE-01 - Keep (Pipe window) + Missing (Proposals).** The line exists: `Services/PipeFlowSizingAdvisorService.cs`
   via `Commands/PipeEditCommand.GradeSuggestion.cs`, `Commands/CdCommand.GradeSuggestion.cs`,
   `ViewModels/CdViewModel.GradeSuggestion.cs`; it never writes the pipe. `ViewModels/ProjectReviewProposalsViewModel.cs`
   has no pipe-size rows. Add a "Pipe sizes" group: every resolved pipe (`Services/EngineeringPipeResolver.cs`,
   `DesignFlowLitresPerSecond` + `DesignFlowSource`), sized by `PipeSizingSolver` only (no second formula).
5. **UX-SIZE-02 - Modify.** Verdicts are `KeepDiameter / Upsize / Infeasible` (`PipeFlowSizingAdvisorService.cs` 249-259);
   missing input also returns Infeasible. Add **Unknown** (no sourced flow, no material, placeholder limit) distinct
   from **No size works** (every catalogue size checked and failed; CV-02A card 7.1). Read the job mode from
   `CivilProjectStartDraft.JobMode`: Design from scratch words = Keep / Upsize / Unknown / No size works; From markup
   adds Matches / Different / Can't verify and "differs from supplied design". No downsizing: a smaller size is an
   information note only.
6. **UX-SIZE-03 - Missing, built on Keep.** `Accept all` = one `ChangePlan` through `ProposalApplyService.Apply` (one
   transaction, one Undo, proven by `ProposalApplyServiceFixAllTests`). Filter: Upsize rows only (Keep rows change
   nothing); Unknown and No size works never included, still listed. Shown only in Design-from-scratch jobs; From-markup
   rows accept one at a time. Writes diameter, label and schedule fields only. Cancel/Esc/close = nothing written.
7. **UX-DES-02 - Modify + Missing.** One colour map today: `Services/SurfaceOverlayPlanService.cs` `ColoursFor` (ACI:
   roof 151, driveway 8/9, slab 30, garden 92, unknown 6), drawn as transients by `SurfaceOverlayTransientService.cs`
   for the Drawing check palette. Change that ONE map to the approved RGB colours (design rule 1: one path; "Other
   paving" = `ExternalInfillSlab`), with a legend. Design (`Dialogs/CivilDesignWindow.xaml`, tab "Areas and route") has
   only two typed area boxes and no overlay: add `Show over drawing` using the same evidence
   (`CurrentDrawingCheckService` surface map) and the same transient service. Preview only: nothing written, nothing
   to Undo; hidden on close, Esc or document switch.
8. **UX-DES-03 - Missing.** Design tabs today: Start / Setup / Areas and route / Results; no During, no agreed-design
   record to compare against. Build: a pure opening rule (no agreed design -> Start; agreed design exists -> During)
   and a During tab listing changes since the design was agreed (outlet/LPD point and invert, area totals, council
   profile values; each row with `Show`), or the one line "Nothing has changed since the design was agreed."
   The agreed record is saved when the design is confirmed (17_CDSETUP.md 227); reopen returns to the right moment.
   Re-run calculations / Update drawing previews and Finish are later (not C4).

## 3. Settings values used (R-00; each shown with its tag, Unknown stays Unknown)

1. Pipe sizing: `PipeSizingStandards`, `MaterialVelocityLimits` (scour caps are placeholders, CV-02A card 2.7), HV4
   self-cleansing baseline, HV12 90% capacity warning. **Needs Tim's engineering acceptance.**
2. Calculations: job rainfall curve and the named office fallback curve, orifice discharge coefficient (Settings since
   #278), runoff coefficient per surface, council PSD/SSR/storage fields with CR-D1 Assumed/source tags.
   **Needs Tim's engineering acceptance.**
3. Drawn-vs-issued: no tolerance value exists or is to be added (ruling 222-223); display rounding only.
4. Responsible-engineer names: see open question 1. Colours (DES-02) are Tim's fixed presentation choice, not Settings.

## 4. Window contract for Codex (Claude supplies view-models; no XAML in Claude's PRs)

1. **Catchment review** (replaces the one-row pick): rows `Name, ReportAreaM2, YourAreaM2, IsManual, Surface,
   RunoffC, RunoffSource, Destination, IsDestinationUnknown`; header `RainfallCurveLine`, `RainfallIsFallback`;
   `ConfirmAllCommand`, `CancelCommand`. One page, no scroll for 10 rows; manual and Unknown styled (UI emphasis rule).
2. **Apply preview:** reuse `ProposalPreviewDialog` was/now list; add `TargetLine` ("Replaces block at ..." / "New
   at ..."), `IsStale`, `ApplyCommand`, `CancelCommand`.
3. **Issue window:** `Engineers` (list) + `SelectedEngineer` (required), `Revision`, `IssueDate`, `StorageWarnings`
   (system, issued m3, drawn m3, difference), `IssueCommand`, `CancelCommand`. Enter never issues by accident.
4. **Proposals "Pipe sizes" group:** rows `PipeName, DrawnMm, SuggestedMm, Verdict, Why, DiffersFromSupplied`;
   `CanAcceptAll`, `AcceptAllCommand`, per-row `AcceptCommand`; count line "3 to upsize, 2 Unknown, 1 no size works".
5. **Design:** tabs Start / During; `OpeningMoment`; During `Changes` rows (`Text, ShowCommand`) or `NothingChangedLine`;
   `Show over drawing` toggle and a five-swatch legend matching the approved hex values.
6. **Pipe window line:** existing strip; text from `SizingAdviceLine` (mode-aware); no layout change.

## 5. Build order and builder split

1. **B1 DES-02 (Sonnet):** single colour map + legend + Design `Show over drawing` behaviour.
2. **B2 DES-03 (Sonnet builder, Opus review - touches ProjectDataService/persistence):** agreed-design record, pure
   change comparer, opening rule, During view-model.
3. **B3 SIZE-02 Unknown verdict (Opus builder - Sizing path).** Tests first, no UI.
4. **B4 SIZE-01/03 network review + Accept-all filter (Opus builder - Sizing, ProposalApply).**
5. **B5 SIZE mode wording, Pipe-window line and Proposals row view-model (Sonnet; Opus review with B4).**
6. **B6 CALC-02 Apply to drawing (Opus builder - Detention, Orifice, Undo):** criteria block and orifice detail both
   from `DrainageComputationsRecord`; one transaction; record save inside it. DF slice 3.
7. **B7 CALC-03 Issue (Sonnet for the issue record/window VM; Opus builder for the storage comparison and the ARI fix
   in `ComputationsRecord.cs`).** DF slice 4.
8. **B8 CALC-01 whole-set intake with manual overrides (Opus builder - Rational Method inputs).** DF slice 5.
9. Codex builds the six windows after each VM lands; every builder runs net48 and net10 with `-p:SkipDevBundle=true`.

## 6. Guards (automated) and Codex steps

1. **Unit tests:** Unknown vs No size works (missing Q, missing material, placeholder cap, proven fail); Accept-all
   filter excludes Unknown/No size works and keeps them listed; Accept all absent in From-markup; no downsizing row;
   catchment review: manual value never relabelled report, unproved destination Unknown, one confirm adds all rows,
   Cancel adds none; one record feeds sheet, criteria block values and detail values (same numbers); stale preview
   refused; unknown ARI prints "not known"; issue record fields; storage warning with both figures and no tolerance;
   opening rule (none -> Start, agreed -> During); comparer "nothing changed"; colour map equals the five approved hex.
2. **Example drawings:** DWG-A, DWG-B, DWG-S in `C:\Lisp Files\_TEST_COPIES_20260923` (DF card 4.2-4.4) plus a
   synthetic From-markup variant watermarked NOT FOR DESIGN (CV-02A card 4.2). Copies only.
3. **Codex (2027 and 2024), screenshots + exact steps:** (a) DWG-A: CDCALC > Add from rating report, fix one area, see
   "manual" beside the report value, Confirm all, save, reopen, labels kept. (b) DWG-A: Apply to drawing, pick the
   existing criteria block, preview, Apply, one U restores block, detail and record; Esc at each pick changes nothing;
   locked-layer pick refused. (c) DWG-B: issue rev A naming an engineer, stretch a detention pipe, Issue again: warning
   shows both m3, issue still allowed. (d) DWG-S: Unknown/"source unverified", office rainfall named, DRAFT until issued.
   (e) Proposals > Pipe sizes on DWG-A: Accept all, one U reverts every diameter/label/schedule change; Unknown rows
   listed, not changed. (f) From-markup job: no Accept all, "differs from supplied design" shown, nothing changes until
   a row is accepted. (g) Design: Show over drawing colours match the legend; close hides them; part-drawn unchanged job
   opens on During with the one line.
4. **Tim only:** the engineering values in section 3 and the sizing-rule sign-off; nothing else needs him.

## 7. Opus-review triggers

1. Any diff under the risk-check paths (queue 219-221): Calculation, Detention, Orifice, Rational, Sizing, Undo,
   Persistence, ProjectDataService. All of B3, B4, B6, B7, B8 and B2.
2. Any change to a figure the sheet, block or detail prints, to Accept-all eligibility, or to the transaction/Undo shape.
3. Any builder wanting a new constant: stop, it goes on the Settings page with a tag (R-00).

## 8. Open questions (plan silent or contradictory only; one line each)

1. **Where the Issue window's engineer list comes from** (checked rulings 204-213 and 758, DF card 2.9/6.5,
   `structural/cards/STRUC-REGISTER-ISSUE_CARD_2026-09-26.md` 96): recommend an office list of engineer names on the
   Settings page, shared with Structural issue, plus a typed name marked "typed".
2. **Sizing Accept all vs the CV-02A4 sign-off gate** (rulings 911 vs 914-915; CV-02A card 3.5 vs slice 3):
   recommend build it but ship the Pipe sizes group behind a Settings switch, off until Tim signs the sizing rule
   values; the Pipe-window line stays on, marked Assumed where a placeholder is used.
3. **From markup: Can't verify vs Different** (CV-02A card OPEN 2; UX-DES-01 card deferred reading supplied figures):
   recommend Different only where the supplied design states a size; everything else Can't verify, never inferred.
4. **When Design opens on Finish** (17_CDSETUP.md 119 says "nothing changed and being issued"; ruling 588 says During
   for part-drawn unchanged): recommend Start with no agreed design, During whenever one exists, Finish only by its tab.
