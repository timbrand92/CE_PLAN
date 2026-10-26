# Codex second opinion: C-69 / PR #1791

1. **ANSWER FIRST — #1791: MERGE-WITH-FIXES.** Keep the seven existing distances, but fix the handling of an infinite distance and add a test that catches it before treating this change as ready.
2. **Opus comparison: 0 agree, 1 disagree.** Opus's C-69 finalizer said KEEP and GO. Codex requires the fixes below. This count covers #1791 only; the other ten PRs were checked for clashes, not given a fresh full review.
3. **Most important finding.** An invalid, infinitely large distance is accepted. In the strip-drain calculation it suppresses intermediate floor wastes; in LPD it removes the distance limit. Today's normal defaults are unchanged.
4. **Train clashes.** No additional conflicting pair found. All 55 pairs match section 4: every pair clashes at the top of the shared change log, and six named pairs also clash where Settings groups are inserted. Keeping every complete entry resolves those clashes.
5. **Tim's decision: none needed.** These are code and test corrections, not a request to change engineering distances. The seven Settings page boxes are still missing, as the train list already records; BUG-547 must remain open. Civil + Manager's 9 November release remains the scope; Manager administrator work stays parked.
6. **What was checked.** Read-only code and test review, completed 26 October 2026, Melbourne time. No build, test run, AutoCAD session or installation. Only this review file is authorised to change.

---

1. **PR #1791 — BUG-547 part 3: detailed review.**

   **Head read — verified-by-reading.** Live `gh pr view 1791 --json headRefOid,baseRefName,headRefName,state,isDraft,files` and `gh pr diff 1791`, repository `timbrand92/CE_ACAD_PLUGIN`: `c52b514d41b0ec3a25c9cd48f1cbeacf1b96db27`, branch `fb/r2fix-1161-bug547c`, OPEN, draft, base `claude/rel-20261025r`. It exactly matches section 1 item 10's reference head. Its merge-base with C-68 is `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.

   **What changes in AutoCAD — verified-by-reading.** The distances controlling strip-drain floor wastes, LPD searches, JOIN label ownership and SPS level-text clearance come from saved Settings. With the defaults, drawings behave as before. For example, changing strip-drain spacing from 12000 to 6000 mm lets the existing placement calculation put floor wastes closer together. No Settings window row is added.

   **Cause and scope — PASS, verified-by-reading.** The diff replaces the actual numeric inputs used by these calculations, not unrelated constants. It adds `ReachSettings`, its `UserSettings.Reaches` group and `CurrentReaches.Now`, changes the existing readers and LPD sentence, and removes the two dead declarations. Tests and two log entries complete the eleven-file diff. No unrelated product feature is added.

   **Seven defaults — PASS, verified-by-reading.** All are millimetres in the model. In the following source references, paths beginning `Models/`, `Commands/` or `Services/` are under `Modules/Drainage/`; test paths are written in full.

   1. **Strip-drain spacing:** `reaches.floorWasteSpacingMm = 12000`, `Models/ReachSettings.cs:14`, effective fallback at line 28. `Commands/StripDrainCommand.Plan.cs:109` reads it for both the early return and number of divisions. The removed constant was 12000.
   2. **LPD pit search:** `reaches.lpdPitSearchMm = 500`, model line 16, fallback line 29. `Commands/LpdCommand.cs:89` replaces the old 500 input.
   3. **LPD other-block search:** `reaches.lpdOtherBlockSearchMm = 2500`, model line 18, fallback line 30. `Commands/LpdCommand.cs:105` replaces the old 2500 input.
   4. **LPD picked-point search:** `reaches.lpdPickedPointSearchMm = 250`, model line 20, fallback line 31. `Commands/LpdCommand.cs:132` replaces the old 250 input.
   5. **LPD nearby-pit association:** `reaches.lpdPitWithinMm = 500`, model line 22, fallback line 32. Both `Commands/LpdCommand.cs:187` and `Services/LpdService.cs:156` replace the old 500 input with this same setting.
   6. **JOIN label reach:** `reaches.joinLabelReachMm = 2500`, model line 24, fallback line 33. `Services/LinkService.NetworkEdits.cs:26` changes the existing constant into a property; its caller at line 100 remains the existing units-aware comparison.
   7. **SPS wall clearance:** `reaches.spsWallClearanceMm = 200`, model line 26, fallback line 34. `Services/PipeAttachmentPlacementMath.cs:22` changes the constant into a property, used at line 58 after calculating the distance to leave the round wall.

   **Units — PASS for unchanged behaviour, verified-by-reading.** JOIN still calls `ReachMmToDrawingUnits(OrphanReownToleranceMm, InsunitsOf(db))`; 2500 mm therefore becomes 2.5 drawing units in a metre drawing. The underlying `DrawingAreaUnits.MillimetresToDrawingUnits` conversion is unchanged. LPD, strip-drain spacing and SPS still compare/add raw distances, retaining their pre-existing metre-drawing defect. This is not a claim that all four tools handle metres correctly, and it is not a new defect introduced by this PR.

   **LPD sentence — PASS for setting use, verified-by-reading.** `Commands/LpdCommand.cs:107` formats `CurrentReaches.Now.LpdOtherBlockSearchUsedMm / 1000.0`, with invariant formatting, into the existing plain sentence. At 2500 it still says “No pipe end found within 2.5m of the selected block.” There is no remaining literal `500` or `2.5m` in that command file. The two 500 mm settings are separate searches; the sentence correctly uses the other-block setting. Small fractional-metre values are rounded by `0.##`; this review has not exercised those messages in AutoCAD.

   **Deleted constant and setting — PASS, verified-by-reading.** Repository-wide `git grep` at the reviewed head finds no remaining production reference to `FLOOR_WASTE_MAX_SPACING_MM`, `trenchGrateLengthMm`, `TrenchGrateLengthMm` or `TrenchGrateLengthUsedMm`. The remaining mentions are the historical log and negative test assertions. At the fix commit's parent, the trench value had declarations and tests but no production reader; the floor-waste constant was already unused after the earlier settings move. The final source guard checks the deletions. The old log entry still describes the superseded dead key, but the newer entry explicitly records its removal.

   **Bad values — FAIL, verified-by-reading (finding F1).** `Models/ReachSettings.cs:36` is `value > 0 ? value : fallback`. Zero, negative values, NaN and negative infinity take the fallback. Positive infinity is greater than zero, so every effective distance accepts it. No finite-value check appears in the new group or adapter.

   **Consequence — verified-by-reading of calculations, not an AutoCAD reproduction.** In `StripDrainCommand.Plan.cs:110`, a finite length is less than infinity, so no intermediate floor wastes are planned. `LpdService.cs:423` accepts any finite nearest-pipe distance against infinity; line 445 similarly accepts any finite nearest-pit distance. JOIN's conversion preserves infinity, removing that reach limit too. `PipeAttachmentPlacementMath.cs:58` propagates infinity into the SPS offset. Actual rendering, JSON round-trip behaviour on every target framework and any resulting AutoCAD exception remain untested, not claimed as observed failures.

   **Settings switch/default/old file — PASS for this values-only change, verified-by-reading.** No new on/off bug-fix switch exists or is listed for #1791; this is seven adjustable figures with unchanged defaults, not a newly enabled alternative algorithm. `UserSettings.cs:204` to 206 initialises the group. Missing properties retain model defaults; `CurrentReaches.cs:8` supplies a new group if the current settings or group is null. The production tolerant loader restores missing sections and recovers unreadable members (`SettingsService.cs:752` onward). Zero/negative values are handled by the effective readers. Positive infinity is the F1 exception.

   **Tests at the PR head — PARTIAL, verified-by-reading; none run.** `Modules/Drainage.Tests/Services/ReachSettingsTests.cs` contains six cases, not the five described in the older log:

   1. **`Defaults_AreToday`, line 16:** asserts all seven effective defaults.
   2. **`TypedFigures_AreUsed`, line 29:** asserts changed strip spacing 9000, JOIN reach 1500 and pit-search reach 800. It covers only three of the seven effective readers.
   3. **`LpdMessage_BuildsItsDistanceFromTheSetting_AndNothingDeadIsLeft`, line 38:** checks source text for removal of “within 2.5m”, presence of the setting-based message expression, absence of the floor-waste constant and absence of the dead trench JSON key. Reinstating the old sentence or dead declarations makes these assertions fail by inspection. It does not execute a search or format a message with a custom value.
   4. **`BadFigures_FallBackToToday`, line 52:** two cases, 0 and -10, assert all seven fallbacks. It misses positive infinity.
   5. **`OldFileWithoutTheGroup_GetsToday`, line 69:** deserialises `{}` into `ReachSettings` and checks only JOIN 2500. Its name overstates coverage: it does not load `UserSettings` without the `reaches` group.

   **Test fails without the fix — result and limit, verified-by-reading.** Removing the new model makes the new tests fail to compile, which is not a behavioural RED run. The source assertions specifically detect reverting the message/deletion fixes. The suite would not detect reverting most command/service inputs to their old constants while leaving the model intact. The required new infinity case below would fail an assertion against this head and pass only once F1 is fixed; that is the missing direct regression check.

   **Later train tests — credited after comparison, verified-by-reading.** At finalizer commit `e7009af18232ff9add418834259524a127305d3b`, `Modules/Drainage.Tests/Services/C69NewSwitchDefaultsTests.cs` loads both `{}` and a C-68-style file through `DeserializeSettings` and `DeserializeSettingsTolerant`. It asserts all seven raw reach defaults, and another test checks all seven typed values survive both readers. This closes the full-file/default coverage gap for the assembled train. Those tests are not in #1791's own head; neither they nor the PR tests cover infinity or actual placement. The initial request for additional full-file default tests is therefore withdrawn for C-69; do not duplicate the finalizer's existing coverage.

   **REDO — PASS for the change's call graph, verified-by-reading; runtime unverified.** The additions read settings and do arithmetic; they add no drawing transaction, event handler, document lock or system-variable write. JOIN remains behind `ExternalMutationCommandPolicy.CanMergePipes` (JOIN/PEDIT only), and the surrounding reactor drops pending writes at history-command ends or while the redo window is open (`LinkService.Reactors.cs:631` to 637). The existing command-end transaction is unchanged. This does not certify the whole base's REDO behaviour: the train list records an earlier failed check of #1779, which this PR does not fix.

   **Locked layers, Xrefs and REFEDIT — PASS for no protection bypass, verified-by-reading.** No protection is removed and no unlock, detach or force-write is added. JOIN still checks both objects with `IsSpineWritable` before registering ownership (`LinkService.NetworkEdits.cs:116` onward); that helper rejects active REFEDIT, locked layers and external-reference owners/definitions (`LinkService.Spine.cs:735` onward). LPD retains `CommandPreFlight` at line 28. This is a scoped check of the changed paths, not an executed protected-object test of every existing command.

   **CE_SHARED, installer and signed updates — PASS, verified-by-reading.** The live eleven-file PR list and complete diff contain no Shared/CE_SHARED, installer, signing, update, deployment, bundle/version or project file. The HOLD condition for touching those files is not triggered. No files in those areas were changed by this review.

   **R-00 — PARTIAL, verified-by-reading.** The seven numbers now have editable saved settings and documented default seeds, but no Settings page rows. Searches of the window/dialog/view-model sources find no binding for these keys. The unchanged SPS search radius 2000, strip-drain width 100 and trench default length remain outside this slice. This is the explicitly listed incomplete migration, not delivery of the whole Settings-page requirement; keep BUG-547 open and retain the window-lane obligation. No new engineering default needs Tim's ruling to make this scoped correction.

   **R-27 and wording — PASS for the diff, verified-by-reading.** No new refusal, hard block or command deletion is added. The permitted hard-block cases remain deleting spine identities and distributing an update after a failed build; this PR adds neither. The LPD message uses ordinary AutoCAD terms: pipe end and selected block. The corrected fallback must continue using the standard value, not introduce a new refusal.

   **Train interaction — verified-by-reading and git merge-tree.** #1791 shares only `UserSettings.cs` and `REGRESSION_LOG.md` with the other train PRs. Its `reaches` group has a unique name and unique property names. The three Settings clashes involving #1791 are exactly the listed pairs with #1784, #1785 and #1789. Keep every group's complete documentation and declaration. Detailed whole-train results follow below.

   **Verdict and exact required fixes — MERGE-WITH-FIXES.**

   1. **F1, medium: reject non-finite distances.** In `Modules/Drainage/Models/ReachSettings.cs:36`, change the predicate to `!double.IsNaN(value) && !double.IsInfinity(value) && value > 0 ? value : fallback`. Keep the seven existing defaults. This form works with the existing target-framework range; it adds no engineering threshold or hard block.
   2. **F2, medium: pin that fallback.** In `Modules/Drainage.Tests/Services/ReachSettingsTests.cs:50`, add cases for `double.PositiveInfinity`, `double.NegativeInfinity` and `double.NaN` to `BadFigures_FallBackToToday`. All seven effective readers must equal their original defaults. Positive infinity must fail on `c52b514d` before F1; the other two protect existing fallback behaviour. Add a production-deserialiser case for a non-finite reach value and assert the effective value falls back while an unrelated valid setting survives. Run these later in the builder lane; no tests were run here.

   **Non-blocking test improvement — verified-by-reading gap.** At `ReachSettingsTests.cs:29`, extend the typed-value assertions to the remaining four effective readers, and add caller assertions covering each production use (including both nearby-pit reads). A later AutoCAD check must show changed strip spacing, the changed LPD distance/message, JOIN reach and SPS clearance actually taking effect, plus U then REDO. Existing source checks alone do not prove those drawing results.

   **Opus comparison — verified-by-reading.** The required R2 method file was read first; it also exposed the historical #1161 MERGE-WITH-FIXES verdict, so this was not a blind review of that predecessor. I recorded my independent current-head MERGE-WITH-FIXES assessment before opening the C-69 finalizer report. The finalizer's section 1.1 item 10 says #1791 KEEP, under an overall GO. Its later test additions are credited above. `git show e7009af1:Modules/Drainage/Models/ReachSettings.cs` confirms the same non-finite-value defect remains after finalizing.

   **Codex DISAGREES with the Opus verdict (Opus said KEEP/GO, Codex says MERGE-WITH-FIXES) because positive infinity bypasses every reach fallback and neither reviewed test set catches it.** KEEP/GO is the finalizer's wording for accepting the merged change; the older #1161 MERGE-WITH-FIXES verdict is not misrepresented as an approval of the new head.

2. **Whole C-69 train: overlap audit, not eleven full PR verdicts.**

   **Method — verified-by-reading/tool output.** Read all of list section 4 and section 6; fetched origin; read live metadata and `gh pr diff` for all eleven PRs. Compared file overlaps and Settings additions. Ran all 55 pairwise `git merge-tree --write-tree` combinations on the immutable heads. These create tree objects only: no worktree, branch, index or checked-out code change, and no commit in the code repository. The cumulative merge order was then assessed by reading the additive hunks, without creating temporary merge commits.

   **Live heads — verified-by-reading; all match their references.** All eleven were OPEN and draft, with base `claude/rel-20261025r`; all eleven merge-bases against C-68 equal `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`.

   1. **#1781:** `6b124d6ba79a2bf8abee559360edacb1efecd67e`.
   2. **#1782:** `a4ff2ea90d3a418a4843fcf8185f1c4a5114b97d`.
   3. **#1783:** `5396cf9c0115c9f5d6ec78f0a393854b6f8fac59`.
   4. **#1784:** `22c0f7ec32e8e9244bd3c8ec54a68c894a6e7cb3`.
   5. **#1785:** `30f221b8f6596c36ec70fb060a08aeab9f233f60`.
   6. **#1787:** `92ce817c530dab4b7081049bbe966e60952fd6cd`.
   7. **#1786:** `7794177784636e0ce1d694b540e7079a2dac4347`.
   8. **#1790:** `ee2cdf44ac65e3c6312cf6e4700b5cfb9fd489e9`.
   9. **#1789:** `b349b1b2dce2f37ceb67fc8a18f93ce6086a8ec6`.
   10. **#1791:** `c52b514d41b0ec3a25c9cd48f1cbeacf1b96db27`.
   11. **#1788:** `4b5cc0c53645a678eeb09570c763a3603ba55d98`.

   **Pairwise conflicts — verified-by-reading/tool output.** All 55 pairs return a content conflict in `REGRESSION_LOG.md`. Exactly six additionally conflict in `Modules/Drainage/Models/UserSettings.cs`: #1784/#1785, #1784/#1789, #1784/#1791, #1785/#1789, #1785/#1791 and #1789/#1791. There are no other product-file conflicts in these trials.

   **Settings meaning — verified-by-reading.** The colliding additions are distinct top-level groups: `pipeSpeedChecks`, `sharedValues`, `wsudTab`, `chargedTab`, `reaches`. Other additions are in `linking`, `options`, `surface.slabMinimumFalls` and `detention`. The two #1787 switches and #1790's `connectionPipe` belong under `detention`; none duplicates a #1791 key. Each complete group keeps its own summary/default note and initializer. No PR removes another PR's newly added key.

   **The deceptively close pair — verified-by-reading/tool output.** #1787 and #1790 both insert after `detention.boydsUsesHardGroundC`, but Git combines them correctly, preserving all three properties and their summaries. I inspected their resulting tree `47e047810ffc746df7da61ea9e6f8d9724ab5758`. Their `AutoDesignService.cs` edits also combine: #1787 changes orifice calculations near base lines 475 and 524; #1790 changes connection-pipe inputs near line 666. There is no new conflict to add to section 4.

   **Listed-order dry run — assessed by reading; not an executed combined build.** #1781 starts the train; #1782 and #1783 add independent settings/callers; #1784 adds its group; #1785 requires keeping both groups. #1787 and #1786 add distinct detention and surface settings. #1790 combines with #1787 as checked above. #1789 and #1791 each require keeping all accumulated top-level groups. #1788 changes Manager-only code. Every step after the first keeps the incoming log entries above all previously retained entries, with blank lines before headings. No shared Settings key or additional semantic conflict was found in this merge-order audit.

   **Cross-check against the existing finalizer tree — verified-by-reading.** At `e7009af1`, `UserSettings.cs:204` to 222 contains all five top-level groups with their individual documentation. Lines 2532 to 2549 retain `detention.connectionPipe` and both detention switches. This supports the keep-all resolution, without claiming I built or fully re-reviewed that combined tree.

   **Pairs missing from the list: none found.** The same-file inventory contains only `REGRESSION_LOG.md`, `UserSettings.cs` and `AutoDesignService.cs`, exactly the section 4 scope. A successful textual merge is not a runtime guarantee. No new suspected cross-PR defect is being presented as verified.

3. **Evidence limits and delivery.**

   **Verified-by-reading:** immutable PR source, tests, removed-symbol searches, seven defaults/callers, production settings reader, changed call-graph safety, live PR metadata, pairwise merge output, and the later Opus verdict/default tests. F1 and the missing non-finite test are confirmed from code, not merely suspected.

   **Not verified:** actual installation, AutoCAD output, REDO survival in a running session, rendered windows, builds, tests or a before/after failing test run. No test totals reported by other reviewers are presented as my results. No code repository file, PR or branch was edited; no subagent was used.

   **Only deliverable:** `C:\CE_PLAN\areas\CODEX_PR_REVIEW_cx_rv27.md`. Save this file by name, merge `origin/main` without rebasing, and push with the normal leak-scan hook. Existing unrelated CE_PLAN edits are outside this review and must remain untouched. Undo for this documentation-only change is a later commit reverting this one review file.
