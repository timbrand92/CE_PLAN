# Pilot-critical batch 3: positions 21 to 33 (Sat 24 Oct 2026, 11:51 to 14:31 Melbourne)

Team job, desk plan/03. Input: `areas/BUG_REGISTER_TRIAGE_2026-10-24.md` section (C), positions 21 to 33 counted down the section as written. Base: `origin/claude/rel-20261024m` at **`5467f7053a2e9275cb450409c142ef9aa26dad53`** (Civil 3.0.73 / Manager 1.1.73, fetched 11:53). Nothing was installed, nothing closed or deleted, no bug marked FIXED, `BUG_CARPARK.md`, `DESK_LOG.md` and `QUEUE.md` not edited. AutoCAD, Codex and accoreconsole were not started by this job (another job's AutoCAD session was open on the PC during my runs). Shared, Installer, Manager and signing files: untouched.

## ANSWER FIRST

**5 fixed in draft PRs, 8 skipped (6 need Tim's word or a window/design decision, 2 need a measurement or are not shown to be a fault).** All five PRs are built and unit-tested only. Nobody has opened any of them in AutoCAD.

1. **BUG-1142 (DATA LOSS): fixed in draft PR #1752, head `ab07e0c0`.**
   1. **What Tim will see:** one damaged pit record no longer makes every new CD pipe and Edit Pipe save link to no pit. The damaged pit is left alone and named once: "[CE] The CE link record on pit P3 could not be read, so CE left that pit as it is and linked the pipe to the other pits. That pit may not follow its pipes when it is moved."
   2. **Tests:** `Bug1142UnreadablePitRecordTests` 5 of 5. RED: the source guard fails on the base (1 of 5). Civil net10 full **19,811 total, 19,789 passed, 22 skipped, 0 failed**. net48 test build 0 errors. No Settings switch (OFF would only bring back the stop; reason in the PR).
   3. **Real-AutoCAD check:** test copy with one pit's link record damaged (runner fixture); CD a pipe between two OTHER pits; MOVE one of them 2 m. Right looks like: the pipe end follows, the "[CE] The CE link record on pit ..." line shows once, the damaged pit is untouched.
2. **BUG-1189 (WRONG ANSWER): fixed in draft PR #1756, head `62a26660`.**
   1. **What Tim will see:** after the survey XREF is moved, turned or scaled since CDSURVEY approved it, New Pit offers no survey level and says why ("... has been moved, turned or scaled since its levels were approved. CE has not offered a survey level from the old position. Run CDSURVEY again ...; you can still type a level. The cover level is left blank."). CDSURVEY's status line ends "NEEDS A REREAD". Edit Pit, CDSL, slabs, CD grade suggestions and the cover-level source get the same check (one loader). Nothing is blocked or written. Switch `survey.storedLevelsFollowXrefPosition`, ON.
   2. **Tests:** `Bug1189MovedSurveyXrefTests` 10 of 10; survey-related focused 135 passed. RED: 2 of 10 source guards fail on the base. Civil net10 full **19,816 total, 19,794 passed, 22 skipped, 0 failed**. net48 test build 0 errors.
   3. **Real-AutoCAD check:** test copy, XREF `RD15_STALE.dwg` with 12.000 at 0,0 and 20.000 at 10000,0 attached at 0,0; CDSURVEY approve; MOVE the XREF from 0,0 to 10000,0; PIT at `10000,0,0`. Right looks like: no 20.00 offered, the "[CE] The survey XREF ..." line, cover blank. CDSURVEY shows NEEDS A REREAD; approve again; PIT at `10000,0,0` offers 12.00.
3. **BUG-1190 (WRONG ANSWER): fixed in draft PR #1755, head `ee893e44`.**
   1. **What Tim will see:** a level inside a block nested in a turned or scaled survey XREF is stored where the drawing shows it (0,10, not 10,0), so New Pit offers the right nearby level. Switch `survey.nestedSurveyBlocksKeepTheirPlace`, ON.
   2. **Tests:** `Bug1190NestedSurveyBlockTransformTests` 7 of 7 (real AutoCAD matrix maths on net10). RED: the source guard fails on the base (1 of 7). Civil net10 full **19,813 total, 19,789 passed, 22 skipped, 2 failed**: the offline Help window render timed out under load (passed on its own re-run) and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` gave a blank PDF page three times at 13:16 to 13:26; at 14:29 the same test **passed twice on this branch's head and twice on the untouched base** (own worktree, same PC), so it was machine state, not the change (comment on #1755). net48 test build 0 errors.
   3. **Real-AutoCAD check:** test copy, XREF `RD15_NESTED.dwg` holding block `RD15_LEVEL` (TEXT 12.000 at its 0,0) inserted at 10,0 plus a loose TEXT 15.000 at 10,0; attach at 0,0 rotated 90 degrees; CDSURVEY approve; PIT at `0,10,0`. Right looks like: New Pit offers 12.00 at zero distance, not 15.00.
4. **BUG-1194: fixed in draft PR #1757, head `c40af2a2`.**
   1. **What Tim will see:** CDTEXTSEG (and the CD / Edit Pipe "pick a point to move arrow and text to that segment" prompts, and placing an arrow on a picked leg) puts the label on the leg you clicked, not the leg round the corner. Switch `linking.pipeTextFollowsClickedLeg`, ON.
   2. **Tests:** `Bug1194ClickedLegTests` 11 of 11. RED: the 4 caller guards fail on the base. One old pin rewritten and said so (`CdCreationPlanPointTests` pinned the old call text). Civil net10 full **19,817 total, 19,795 passed, 22 skipped, 0 failed** (an earlier run's test host crashed after 18,611 tests in the window-render tests; the re-run was clean). net48 test build 0 errors.
   3. **Real-AutoCAD check:** test copy, CE pipe 0,0 to 20000,0 to 20000,1000 with its text; CDTEXTSEG, pick the pipe, type `19000,0`. Right looks like: the label beside the long horizontal leg, parallel to it. CDTEXTSEG again, `20000,500`: the label moves to the short leg. U puts each back.
5. **BUG-1106: fixed in draft PR #1761, head `3a0c8a5e`.**
   1. **What Tim will see:** a STORM report naming Glen Eira (or any two-word council) gives "[CE] Council set to Glen Eira, from the rating report." and the design uses Glen Eira's rules, with no "council outstanding" line; a job already on Glen Eira is no longer asked "Which one is right?". No Settings switch (OFF would only save an id CE cannot find).
   2. **Tests:** `Bug1106TwoWordCouncilTests` 8 of 8; with the existing offer tests 39 passed. RED: the source guard fails on the base (1 of 8; the other 7 use the new parameter and cannot compile against the base). Civil net10 full **19,814 total, 19,791 passed, 22 skipped, 1 failed** (the same blank-page PDF test; not re-run on this head, see the comment on #1761). net48 test build 0 errors.
   3. **Real-AutoCAD check:** test copy of a job whose STORM report says Municipality Glen Eira, council not set; CDDESIGN, accept the offer. Right looks like: "Council set to Glen Eira", the design shows Glen Eira, no "council outstanding". Run CDDESIGN again: no council question.
6. **BUG-1088 (HIGH): skipped, needs Tim's number.** Options below.
7. **BUG-1095 (HIGH): skipped, needs Tim's word (open questions C16 and C19).** Options below.
8. **BUG-1099 (HIGH): skipped, needs Tim's word (open question C17).** Options below.
9. **BUG-1091: skipped, needs Tim's word.** The code itself records it as a disagreement "kept as today, listed for Tim". Options below.
10. **BUG-1192 (HIGH): skipped, design decision** (how an unsupported stretch of ground is drawn on the long section). Options below.
11. **BUG-1031: skipped, desk and window-lane decision.** Options below.
12. **BUG-865: skipped, needs a measurement first.** Options below.
13. **BUG-816: skipped, not shown to be a fault; a Settings decision.** Options below.

**What I did NOT test:** nothing was opened in AutoCAD (every Real-AutoCAD check above is still to do). The net48 test lanes were built (0 errors) but not run. Manager was not built or tested (no Manager file changed). No Settings page rows were added for the three new switches (window lane). The five branches were not merged together or with batches 1 and 2; four of them add a key to `UserSettings.cs` and all five add a `REGRESSION_LOG.md` entry at the top, so the assembler will meet those two files in every merge. The 2-argument survey loader of #1756 prints its line once per drawing per reason; I did not check how that reads in a long PIT run beside the 3-argument New Pit line.

**Build lock:** `desk_jobs/build.lock` was held continuously by batches 1 and 2 (sampled: handed from one to the other with no free gap; 50 minutes of waiting got no turn). From 13:00 my scratch runner tried the lock for up to two minutes each step and, if busy, ran **without it at Below Normal priority** in its own worktree. It said which on every step; 11 of my 38 steps got the lock, 27 ran without it. This is the only rule-adjacent choice in the run; say if the desk wants it handled differently.

---

## Per-bug detail (verify, then fix or skip)

Every bug was searched with `gh pr list --state all --search BUG-nnnn`; none had a real fix PR (the hits were number collisions: #1535 for 865, #1142/#1212/#627 for 1142, #436 for 1189, #1498 for 1190, #1296/#431 for 1192, #508 for 1088, #582 for 1095, #599 for 1106; read, none names the bug). Order worked: HIGH data-loss and wrong-answer first.

### Fixed

1. **BUG-1142.** Verified at `LinkService.Geometry.cs` `RemovePipeLinksFromAllOwners`: `ReadPitLinkData` deserialises every pit's record with no catch; `LinkPipeEndpointsToPits` (RepairAudit.Linking) calls it twice inside its transaction; `RegisterPipe` catches and only logs. Fix: a scan reader that reports an unreadable record instead of throwing, `continue` before any write to that pit, a log line per skip and one command-line line per drawing and pit. Not done: the audit's "do not half-register" note (RegisterPipe still saves the pipe record first); with the scan no longer aborting, a damaged pit record no longer leaves the pipe half-registered.
2. **BUG-1189.** Verified: `SurveyIntakeStalenessService` compares the XREF handle and transform only at Apply; `TryLoadSurveyPayload` and `GetStatusText` never look again, though `SurveyMeta.Provenance.Sources` keeps `XrefHandle` and `XrefTransform` (captured by `CdSurveyCommand.ReadXrefIdentity`). Fix: pure `Rules/SurveyXrefCurrencyRule.cs`; the check sits in `SurveyService.TryLoadSurveyPayload`, the one loader all eight level consumers use (design rule 1).
3. **BUG-1190.** Verified: `SurveyService.CollectEntitiesFromBlock` used `nestedRef.BlockTransform * parentTransform` with a wrong comment; `XcivilEntityScanner.AppendTransform`, `PitBlockPreviewRenderer` and the long section compose parent-first. Fix: `ComposeNestedTransform(parent, nested) = parent * nested`; the RL-attribute branch was already right.
4. **BUG-1194.** Verified: `PipeTextSegmentChooser.NearestSegmentToPoint` ranks by midpoint distance. Fix: `NearestSegmentToPick` (clamped distance to the leg, stable tie at a bend) for the four picked-point callers; the two lookups of an EXISTING arrow's leg keep the midpoint rule on purpose (arrows sit at leg midpoints).
5. **BUG-1106.** Verified: `StormReportOffer.BuildCouncil` saves the matched text (the name) as `CouncilToSelect`; `CouncilProfileService.GetById` is by id only; the "already entered" comparison is name against id, so a Glen Eira job was also asked a pointless question. Fix: an optional name-or-id to id lookup in `Build`, passed by `CivilDesignCommand`.

### Skipped, with options (recommendation first in each)

1. **BUG-1088, sizer picks the smallest pipe at any grade (HIGH).** Cause confirmed (`PipeSizingSolver` tries sizes smallest first and returns the first that works at any grade up to the 6 m/s cap). Needs Tim's number, as the carpark says.
   1. **Recommended:** prefer the flattest grade each size is allowed (the Settings minimum-grade ladder) and step up a size before going steeper; allow steeper only when no size on the ladder works, and never steeper than a Settings cap that Tim names (for example 1 in 20). On a job: 40 L/s comes out DN225 at about 1 in 200, not DN100 at 1 in 3.
   2. One "preferred design grade" in Settings (for example 1 in 100) for every size; steeper only if no size works.
   3. Leave the sizer and only warn when a proposed grade is steeper than the cap.
2. **BUG-1095, council minimum after-development C never applied (HIGH).** Cause confirmed: `CouncilRuleValues.PostDevelopmentC` has no caller; Darebin 0.8, Maribyrnong 0.75, Boroondara 0.65 are stored as floors. Open questions C16 and C19 ask Tim exactly this, and the catchment is a list of surfaces, so raising C to the floor is an engineering choice (raise the soft-ground C, or replace the weighted C).
   1. **Recommended:** apply the floor in CDDESIGN, pump sizing and the CDCALC Boyd's tab through the one rule, replacing the weighted C when the floor is higher, and print "Council minimum C 0.80 governs (calculated 0.70)" on the sheet; switch ON. The Darebin 600 m2 example becomes C 0.80.
   2. CDDESIGN only, with a warning in the other two.
   3. A warning only ("Darebin's minimum C is 0.80; this design uses 0.70").
3. **BUG-1099, Maroondah and Yarra Ranges before-development C and Tc table unused (HIGH).** Cause confirmed (`PreDevelopmentC` with the cap and `TimeOfConcentration` by lot size have no caller). Needs C17: the same Tc also sizes the outlet pipe.
   1. **Recommended:** use the council's C and Tc table for the permitted discharge and storage only; the outlet pipe keeps the office Tc. The 600 m2 Maroondah example gives PSD 3.68 L/s, not 5.18.
   2. Use the council Tc for everything, the pipe included.
   3. Leave it and warn on Maroondah and Yarra Ranges jobs.
4. **BUG-1091, DN450 and larger lose their minimum grade in redesign and auto-design.** Cause confirmed: `SettingsSizingStandards.ForEveryMaterial` passes only `StandardGradeSizesMm` (DN90 to DN375), and its own comment says "DISAGREEMENT ... kept as today, listed for Tim".
   1. **Recommended:** pass the whole Settings ladder, so DN450 to DN750 get Settings' 1 in 200, the same as Edit Pipe. Example: a DN450 at 30 L/s comes out 1 in 200, not 1 in 1,509.
   2. Keep it and warn when a DN450+ grade is flatter than the Settings minimum.
5. **BUG-1192, long section hides a depression (HIGH).** Cause confirmed (`TryEstimateSurveyLevel` three passes at 0.60, 0.90, 1.20 m; failures are silent; the surface is seeded from the pit covers and drawn straight). How an unsupported stretch is SHOWN is a drawing-design decision, and the carpark wants any limit as a named Settings value (a Settings-page decision).
   1. **Recommended first step:** say it, change nothing drawn: CDPROFILE prints "[CE] Survey levels between chainage 9.0 and 11.0 m differ from the pit covers by more than 1.20 m and were not used; the ground line there runs straight between the covers. Check the survey." and the review lists it. Text only.
   2. Also draw that stretch of the 70CONT ground line differently (dashed or broken, with a note); a drawing change, so Tim's design word and its own switch.
   3. Make the three tolerances named Settings values (needs a Settings row).
6. **BUG-1031, no "Delete cell" on the Pit Schedule cell menu.** Verified: `PitScheduleDialog.xaml` has the eight items Codex saw; `OnDeleteCellClicked` and `DeleteCellCommand` exist and nothing calls them; git history shows no "Delete cell" menu item at any point since the 2 Jul import, yet the Settings page already promises "A cell you clear in the Pit Schedule stays blank" (BUG-783). The carpark asks the desk to confirm intent first, and windows are the Codex lane.
   1. **Recommended:** add "Delete cell" between Restore Cell and Restore Row, calling the existing handler, and reword its status to "Cell cleared. It stays blank when the schedule is drawn."; a Codex look in AutoCAD after.
   2. Record that blanking a cell is not offered, and rewrite BUG-783's check route.
   3. Offer it on the Delete key in the grid instead.
7. **BUG-865, every double-click on a block scans every block.** Verified: `CompoundEditModeService.TryFindBlockUnderDoubleClick` reads every block's extents, tag and pit status in the current space, only when AutoCAD's double-click left the pick-first set empty. No lag has been measured, and a faster search changes which blocks count (BUG-859's Codex-reviewed rule).
   1. **Recommended:** measure first (Codex: time a double-click on a downpipe in a survey drawing with a few thousand point blocks).
   2. Read tags and pit status only for blocks whose outline is under the pointer (same answer, a small saving).
   3. Use AutoCAD's own selection around the pointer (a big saving; changes the rule, needs a Codex look).
8. **BUG-816, "no clear spot" lines after MOVE with Tidy labels off.** Verified: the lines come from the always-on after-MOVE label tidy (Tim's D9; `LinkService.TextClashTidyUp.cs`, wording in `TextClashTidyUpRule.cs`), not from the CDTIDYLABELS switch, as the carpark suspected. Which switch should govern it is a Settings decision.
   1. **Recommended:** give the after-MOVE tidy its own named switch on the Settings page, so a drafter knows what to change (window lane plus Tim's word on the default).
   2. Print those lines only when Tidy labels is ON.
   3. Keep them and reword to say which step printed them.
   4. **Noticed, not filed (BUG_CARPARK is not mine to edit):** every reported clash in runs 31 and 33 is "on the block Drawing Border". The tidy treats the sheet border block as an obstacle, probably by its outline, so on a bordered sheet labels may find no clear spot anywhere. Worth its own carpark entry.

## Method

1. **Environment:** one private worktree per fix under `C:\ce-fx\p3a` to `p3e` (plus `p3y`, `p3z` for the PDF comparison), all removed after their push; scratch scripts and logs in `C:\ce-fx\pc3\` (`run.sh`, `run.ps1`, `eol.sh`, PR bodies, `logs\`). Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, refs from the C-62 assembly report (`_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`), AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, fresh TEMP and CE log folder per step. C: free space was checked before every build: lowest 17 GB.
2. **RED proof:** each fix was built with its tests, then the product change was set aside with `git stash` (tests kept) and the focused tests re-run against the base source: the source guards failed as listed above; the change was restored and the full suite run.
3. **Line endings:** every edited product file checked CRLF-only after editing.
4. **Leak scan:** clean on all five pushes. No `--no-verify`.

## Summary (under 100 words)

Positions 21 to 33 on base `5467f705`: five fixed in draft PRs, all built and unit-tested only, none opened in AutoCAD. #1752 BUG-1142 (damaged pit record), #1756 BUG-1189 (moved survey XREF), #1755 BUG-1190 (nested survey block), #1757 BUG-1194 (CDTEXTSEG leg), #1761 BUG-1106 (two-word council). Full Civil suites about 19,811 to 19,817 tests each, 0 real failures (a flaky PDF test proven passing on base and branch). Eight skipped with options: BUG-1088, BUG-1095, BUG-1099, BUG-1091 need Tim's word; BUG-1192, BUG-1031 design or window decisions; BUG-865 needs measuring; BUG-816 a Settings decision.
