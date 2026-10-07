# plan-L3-LEVELS — implementation plan for "CE proposes levels" (Level 3 proposal 1)

**Written:** Sun 4 Oct 2026, 04:10 Melbourne, by team lane build/03 (headless run 10). PLAN ONLY: no code was written.
**Card (read completely first):** `04_REFERENCE/ux-plan/cards/L3-LEVELS_CARD_2026-09-26.md` (APPROVED as plan, 26 Sep).
**Rulings it rests on:** UX-L3-01..06; "Top of every branch (Recommended)" (decisions file, "Release-chat L3 cards, open
choices", 26 Sep 01:17); Hold grade / hold levels (`decisions/2026-09-23_HOLD_GRADE_HOLD_LEVELS.md`); job mode UX-MODE-01..04.
**Code read (read-only):** `origin/claude/rel-20261015e` (C-13 head dcd69fd4: installed line Civil 3.0.27 + C-13).

## 0. FOR THE CONTROLLER, in five lines

1. The engine is **already built** (PR #406, 30 Sep, Opus MERGE-WITH-FIXES, in the release line, switched OFF, called by
   no command). What is left is wiring it to the drawing: read real pits and pipes, open the window, draw ghost labels,
   write the ticked changes as one Undo.
2. Build order below: 4 slices, smallest first. Slices 1 and 2 are Claude (behaviour); slice 3 is Codex's window
   (ruling B) against the existing contract `docs/workflows/L3-LEVELS_WINDOW_CONTRACT.md`; slice 4 is the switch-on.
3. **One engineering value needs Tim before switch-on:** steepest grade "1 in 20" is Assumed (no ruling anywhere).
4. **One code-owner call (not Tim's):** the engine does its own level arithmetic beside `NetworkDesignService`. Decide
   before slice 2 whether the final check of the accepted levels also runs through `NetworkDesignService` (recommended,
   CV-02 HD2 "one engine"), so the two can never disagree silently.
5. Nothing here can be tested in AutoCAD by a builder: Codex drives section 6 on copies.

## 1. What already exists (checked on C-13, file by file)

1. **Engine:** `Modules/Drainage/Services/Proposals/LevelsProposalEngine.cs`, `LevelsProposalModels.cs`,
   `LevelsProposalSelection.cs`. Pure (no AutoCAD). Input `LevelsProposalRequest` (pits with `SurfaceLevelM`, `LevelM`,
   `LevelProvenance` Unknown / Calculated / StaffEntered / Fixed / DisplayOverride; pipes with From/To, length, size,
   `IsGravity`, `HeldGradeN`, stored end levels; outlet id and level; rules; job mode). Output `LevelsProposalResult`
   (per pit Was / Now / Cover / Why / tick rules, `WorstShortfall` with four options, `AcceptAllAllowed`, values used).
   `LevelsProposalSelection.Select(result, tickedPitIds)` turns ticks into pipe-end changes, refusing a tick that alone
   would leave a pipe flat or uphill and naming the pit to tick as well.
2. **Tests:** `Modules/Drainage.Tests/Services/Proposals/LevelsProposalEngineTests.cs` (30 tests, including 300 random
   tree networks with no uphill pipe).
3. **Settings:** `UserSettings.LevelsProposal` (JSON `levelsProposal`) = `LevelsProposalSettings`: `enabled` (false),
   `steepestGradeN` (20), `steepestGradeSource` ("Assumed - office value to confirm"), `steepestGradeConfirmed` (false).
   Minimum cover (R-04), grade ladder (R-03) and pit drop (R-08) come from `Rules/RulebookValues` (not duplicated).
4. **Window contract for Codex:** `docs/workflows/L3-LEVELS_WINDOW_CONTRACT.md` (entry, one row per pit, tick rules,
   Accept all only in Design from scratch, shortfall panel, footer, ghost labels, accept, cancel, rounding).
5. **The command to extend:** `Commands/RunSolveCommand.cs` (CDRUNSOLVE): start pit, end pit or Enter, LPD found by
   `ProposalApplyService.FindLpdPit`, run walked by `WalkDownstreamRun`, existing/council pipes trimmed
   (`TryTrimAtExistingPipe`), today it calls `NetworkDesignService.Design`, builds a `ChangePlan`
   (`BuildRunSolvePlan`), shows `ProposalPreviewDialog`, applies with `ProposalApplyService.Apply` (one transaction).
6. **Where "typed by hand" is stored today:** pipe ends carry `FromInvertOverrideActive` / `ToInvertOverrideActive`
   (`Models/PitData.cs`, the pipe record; read the same way by `LinkService.RepairAudit.InvertPropagation.ReadPinnedPipeEnds`
   for Hold levels). Pipe grade mode is `GradeMode` ("default" or custom) with `CustomGrade`. Pits have no level
   provenance flag of their own (`BottomLevelTypedSeen` is a pit-depth marker, not an invert).
7. **Job mode:** `Rules/CivilDesignWorkflow.cs` `CivilJobMode` (NotChosen / From markup / Design from scratch), saved
   in `CivilProjectStartDraft.JobMode`, read with `CivilProjectStartDraftStorage.Read` + `ParseSavedJobMode` (the same
   way `ProjectReviewPipeSizesViewModel.Drawing.ReadJobMode` does).
8. **Ghost renderer:** `Rules/EditGhostPlan.cs` (`GhostKind.Outline / Text / Leader`) describes ghosts; drawing them on
   screen goes through `Services/TransientDrawableSet.cs` (as `StripDrainCommand.Preview` and `SlabCommand` do).
   `EditGhostPlan` is today only produced for the pit-resize preview.

## 2. Build order (one draft PR per slice; failing test first; REGRESSION_LOG entry; switch stays OFF)

### Slice 1 — read the real run into the engine's request (Claude, no window)

1. **New file** `Modules/Drainage/Services/Proposals/LevelsProposalDrawingReader.cs`: from the pits and pipes CDRUNSOLVE
   already walked (and the ProjectData record of THIS drawing: use the read-only `TryPeekCurrent(db, ...)` /
   `TryReadProjectWithoutChanging` pattern from BUG-378, never `ProjectDataService.Current` blind) build a
   `LevelsProposalRequest`. Pure mapping function with an AutoCAD-free core (`BuildRequest(pits, pipes, outlet, rulebook,
   settings, jobMode)`), plus a thin AutoCAD wrapper.
2. **Provenance mapping (the open code question, card §7 Q3; recommended answer applied):**
   1. Pipe end with `FromInvertOverrideActive` / `ToInvertOverrideActive` true → that end's pit level is `StaffEntered`.
   2. LPD / outlet / survey or council datum → `Fixed`.
   3. Existing or council pipe at the boundary (already trimmed by CDRUNSOLVE) → its end level `Fixed`.
   4. Label display override → `DisplayOverride` (never read as a level).
   5. A level CE calculated → `Calculated`. No evidence → `Unknown` (never guessed).
   6. Pipe `GradeMode` custom with a readable `CustomGrade` → `HeldGradeN`; unreadable → no held grade, plus a Note.
3. **Failing tests first** (`Drainage.Tests/Services/Proposals/LevelsProposalDrawingReaderTests.cs`): each mapping above
   one test; a pipe with no size gives `DiameterMm = null`; a missing surface gives `SurfaceLevelM = null`; the request of
   a 3-branch run has every branch top pit present; a record of ANOTHER drawing is never read (BUG-378 lesson).
4. **Risk:** the pit's "level" in the engine is the outlet invert of the pipe leaving it; the reader must take it from
   that pipe's From/To end by drawn direction, never swap ends (contract item 7). Test the reversed-drawn pipe case.

### Slice 2 — CDRUNSOLVE route and one-Undo write (Claude, no window yet: command line only)

1. **Edit** `Commands/RunSolveCommand.cs`: when `SettingsService.Current.LevelsProposal.Enabled` is true, after the run
   is walked call the slice 1 reader, then `LevelsProposalEngine`. With the switch OFF the command is byte-for-byte
   today's (guard test).
2. **New** `ProposalApplyService.BuildLevelsPlan(LevelsSelectionResult, ...)` in `ProposalApplyService.PlanBuilders.cs`:
   converts `PipeEndLevelChange` (`IsDrawnFromEnd` true = FromInvert) into the existing `ChangePlan`, so the write is the
   existing `ProposalApplyService.Apply` = one transaction, one Undo. No new writer.
3. **One-engine check (code-owner call, §0 item 4):** before Apply, run the accepted levels through
   `NetworkDesignService` in `PreserveExistingSizes` mode and refuse (plain message) if it reports a cover or grade
   failure the engine did not. Recommended; if the controller rules against, record why.
4. **Interim UI:** until Codex's window exists, show the result in the existing `ProposalPreviewDialog` (whole-plan
   accept) with the Why text in the Reason column. Not shipped: the switch stays OFF.
5. **Failing tests first:** switch OFF = old path (source guard + behaviour on a fake run); `BuildLevelsPlan` writes the
   From/To end exactly as asked for a pipe drawn uphill-to-downhill and downhill-to-uphill; a partial tick gives exactly
   one `ChangePlan` (mirrors `ProposalApplyServiceFixAllTests`); the one-engine check refuses a planted disagreement.
6. **Command-line words:** "Cancelled - drawing unchanged." (plain hyphen, no em dash: BUG-377 guard).

### Slice 3 — the levels window and ghost labels (Codex, ruling B)

1. Codex builds the window from `docs/workflows/L3-LEVELS_WINDOW_CONTRACT.md` (one row per pit, ticks, shortfall panel,
   footer with values used and "Needs Tim's engineering acceptance").
2. Claude adds `EditGhostPlan.ForLevels(result, tickedPitIds)` (pure, `GhostKind.Text` at each ticked Proposed pit,
   `GhostKind.Leader` when the label sits off the pit) and the transient draw/clear around the window through
   `TransientDrawableSet`. Failing test first: ghosts equal the ticked Proposed rows; unticking removes one; Cancel clears
   all (`Drainage.Tests/Rules/EditGhostPlanTests.cs` extended).
3. Settings page: the steepest grade must be on the Civil Settings page with its "Assumed" tag before switch-on
   (contract item 9; R-00). Codex places it; Claude adds the Settings binding test.

### Slice 4 — switch-on (controller, after Codex PASS and Tim's value)

1. Only after: section 6 passes in AutoCAD, Tim has answered section 5 item 1, and the full Civil suite is at baseline.
2. Change `LevelsProposalSettings.Enabled` default (or the office switch, if the controller prefers office-level),
   REGRESSION_LOG entry, What's New line.

## 3. Settings keys (all under the Civil user settings file)

1. `levelsProposal.enabled` — bool, default false. Exists.
2. `levelsProposal.steepestGradeN` — "1 in N", default 20, **Assumed**. Exists. Needs Tim (section 5).
3. `levelsProposal.steepestGradeSource` / `levelsProposal.steepestGradeConfirmed` — exist; confirmed flips Assumed off.
4. No new key is needed for slices 1-3. Minimum cover, grade ladder and pit drop stay in the rulebook (R-03/R-04/R-08).

## 4. Risks

1. **Two level calculators.** The engine and `NetworkDesignService` could give different inverts for the same run. Slice
   2 item 3 closes it; without it a drafter could accept levels CDCALC then calls short.
2. **Wrong record.** Reading `ProjectDataService.Current` at the wrong moment gave BUG-378 (first open read the previous
   drawing's pipes). Slice 1 must read this drawing's record read-only.
3. **Pit level has no provenance flag.** A level typed in the Pit window or Pit Schedule that is not a pipe-end override
   reads as Calculated and could be moved. Mitigation: the Why column says "CE worked this out" and every row needs a
   tick in From-markup mode; Tim's provenance question (section 5 item 2) settles it.
4. **Loops and junctions.** The engine never pre-ticks pits joined by a loop pipe; the reader must still give loop pipes
   (do not drop them) or the shortfall may be missed. Test a loop.
5. **Open PR edits UserSettings.cs** (several PRs touch that file): slice 3 Settings work conflicts; merge in one train.
6. **Defender:** no long inline PowerShell in any probe (root CLAUDE.md).

## 5. What Tim must rule (engineering only; ask through the desk, one batch)

1. **Steepest grade CE may propose:** 1 in 20 is Assumed. *Recommended:* confirm 1 in 20 for stormwater gravity pipes
   (example: a 30 m pipe between two fixed levels 2 m apart needs 1 in 15; CE would propose 1 in 20 and show the extra
   0.5 m as a drop at the lower pit for the drafter to decide).
2. **A level typed in the Pit window (not a pipe end override): fixed or movable?** *Recommended:* fixed (StaffEntered),
   same as UX-L3-04 "Keep them fixed" (example: P4's invert typed as 21.35 from a survey sketch is never moved; if it
   breaks the run CE says so). This needs a small new pit flag in slice 1; without it the level would be movable.
3. Nothing else: the card's other open points are decided or are code calls.

## 6. What Codex must check in AutoCAD (copies only, on `C:\Lisp Files\_TEST_COPIES_20260923` DWG-A / DWG-B)

1. Switch OFF: CDRUNSOLVE on a 4-pit run behaves exactly as the installed version (same rows, same Apply).
2. Switch ON, Design from scratch: run on a branch with 3+ pits. Ghost invert labels at every changed pit, the list
   Pit / Was / Now / Cover / Why, Accept all available; Accept; one U removes every change.
3. Untick one middle pit that would leave a pipe uphill: the "also tick P5" line shows; nothing is written for it.
4. Job mode From markup: no Accept all; a conflicting row reads "differs from supplied design".
5. Hand-typed end level (Edit Pipe override) mid-run: shown "Kept as typed", never moved.
6. Impossible run (outlet too high for cover at the top pit): worst pit and shortfall in mm first, four options, none
   chosen, nothing written until a choice.
7. Escape during the pit pick, and Cancel in the window: "Cancelled - drawing unchanged.", no ghost left on screen.
8. Save, close, reopen: accepted levels stay; no ghost or proposal data left in the drawing.
9. After Accept, CDCALC on the same run shows no cover or grade failure the window did not show (one-engine check).

## 7. Not in this plan

1. The other three Level 3 proposals (see `plan-L3-SOURCES.md`, `plan-L3-NETWORK.md`; L3-DETENTION has no plan file yet).
2. The shared "Level 3 proposals" entry in Project Review (card L3-SOURCES §7 Q4, still OPEN): CDRUNSOLVE is the entry
   for levels by the implementation call.
3. Learning (UX-LEARN-01) for levels: the card needs none for this proposal's first build.

## 8. Build/04 run 20 notes (Wed 7 Oct 2026)

1. **Slice 3, Claude's half, built (draft PR #750):** `EditGhostPlan.ForLevels(result, tickedPitIds, pitPositions, textHeightMm, decimals)`: one dashed new-level label per ticked pit that Accept would really change (it asks `LevelsProposalSelection`, so a tick Accept would leave out has no ghost). The transient draw and clear (`TransientDrawableSet`) waits for Codex's window.
2. Already built since this plan was written: slice 1 (#679), slice 2 (#691), the check-these-levels entry (#697), a Pit-window level is never moved (#724, INT-059 item 23), steepest pipe a Settings value with no limit and a warning above 1 in 10 (#722, INT-059 item 4). The "1 in 20" text in section 0 item 3 and section 5 item 1 is superseded by INT-059.
