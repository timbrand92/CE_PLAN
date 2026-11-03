# Opus pre-review FILL-LONG: PRs #1433 (BUG-767), #1421 (BUG-768) and #1432 (BUG-773 position half)

Written Monday 2 November 2026, 02:45 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request (queue filler 6).
Heads reviewed: #1433 805e5492, #1421 6177130e, #1432 846c5485. All three are DRAFT and OPEN on GitHub, base `claude/rel-20261018d` (70a4e24f), 0 behind it.
Current release tip checked: `claude/rel-20261108a` at cf059dcf (Civil 3.0.90, C-79b1), confirmed with `git ls-remote`.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the PRs, the code on the tip, the carpark entries, the earlier review-lane entries 1249, 1256 and 1259, and areas\CODEX_TESTS_BD07_24OCT.md and areas\LOOKBRIEF_LANEB_PART3_02NOV.md. I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only. I found no ruling about these three bugs in C:\CE_PLAN\decisions, so the carpark "Expected behaviour" lines are the yardstick.

## FOR TIM

1. **These three are not waiting fixes. They are already in your AutoCAD build, and have been since 19 October.** All three were merged into the C-45 release train that night (Civil 3.0.56). Every later train still has them, including today's. The GitHub pages were never closed, so they showed up wrongly as "open, needs review". CE 05 should close them as "already shipped". They should not be merged again.
2. **#1433, the long section frame now takes in the short existing-pipe stub at each end (BUG-767): KEEP-WITH-NOTE, Civil area + smoke.** Example at 1:100: a 20 m route with an existing pipe at both end pits. Before, the frame was 20.00 m wide. The 1.2 m stub and its cut mark ran 1.32 m into the header column on the left, and 1.32 m past the frame on the right. Now the frame is 22.64 m wide and both stubs sit inside it. Note: the tip of the cut mark now touches the frame line exactly, with no gap.
3. **#1421, a 600 x 600 pit counts as 600 mm wide, not 1800, when CE places boundary marks on the long section (BUG-768): KEEP-WITH-NOTE, Civil area + smoke.** Example: a fence crosses the pipe 0.5 m from the centre of a 600 pit. Before, the mark was dropped. Now it is drawn. Two side effects you should know about:
   1. Boundary marks beyond an end pit move about 0.6 m further out.
   2. A detention tank now counts its full plan length (2.55 m for a 1200 tank, up from 1.8 m), so a boundary within 1.275 m of a tank's centre is now dropped. That second change goes beyond the bug entry; it came from an earlier review.
4. **#1432, CDRG puts the raingarden at the true centre of its area (BUG-773, position half): KEEP-WITH-NOTE, Civil area + smoke.** Example: a 10 x 10 m raingarden drawn with many points along its bottom edge. Before, CE recorded its centre 3.46 m too low, near the bottom edge. Now it is dead centre. You see this on the "RG1" plan label, which since 29 October is placed at that centre point. The other half of BUG-773 is still not fixed. That is the rare "saved raingarden project record changed after preparation" refusal.
5. **Settings:** each has its own on/off switch in the Civil Settings window, under the fixes groups. All three are ON. Turning one OFF gives back the old drawing exactly, as far as I can read.
6. **Merging:** nothing to do. Merging any of the three into today's train changes nothing, because the train already has all three. On 19 October the three clashed only in the Settings list and the change log, and both clashes were resolved by keeping both entries.
7. **Nobody has seen any of the three in AutoCAD.** All three bugs stay OPEN. #1433 cannot be looked at yet, because no test drawing has an existing pipe leaving the end pit of a route. The 2 November look brief already says this. No test touched your real settings file.
8. **Carpark fix for CE 05:** the three entries say "installed in Civil 3.0.70". They actually shipped from 3.0.56 (C-45, 19 October). That does not change any test result.

---

## DETAIL

### Group facts

1. **Already merged.** The train merge commits are 3cdb672e (#1433), 7f3b99f3 (#1421) and cf18d4ef (#1432), all on 19 Oct 2026 about 02:31 Melbourne. They are in `claude/rel-20261019a` (C-45, Civil 3.0.56) and in every later train. `git merge-tree` of each head against the tip cf059dcf gives tree 42e2f670, which is the tip's own tree, so all three are already fully contained. Later commits on the tip build on them: Settings window rows and save tests (Bj33 and Bj34), BD07 raingarden tests (c6f550c6, e14ece59, 6a4790f9), and the RG1 plan label (35401224, 29 Oct).
2. **Earlier reviews.** Review-lane entries 1259 (#1433, MERGE, one LOW), 1256 (#1421, MERGE-WITH-FIXES) and 1249 (#1432, MERGE-WITH-FIXES) reviewed the first commits. The fix commits 805e5492, 6177130e and 846c5485 asked for a re-review that never happened before the train took them. This review is that re-review, made against the shipped code.
3. **Protected files.** None of the three touches LinkService.Persistence.cs, ProjectDataService.Persistence.cs or RulebookEngine.cs.
4. **Real settings.** Every test that reaches `SettingsService.Current` runs under `Modules/Drainage.Tests/SettingsIsolationSetup.cs`. Since 3 Oct 2026 that has sent the settings folder to the test run's own temporary folder (`SettingsService.ResolveSettingsFolder`, SettingsService.cs about line 52). No test in the three PRs writes a settings file. The later Bj33 and Bj34 save tests use a temporary copy (`WithCopy`).

### PR #1433, BUG-767: the long section frame takes in the existing-pipe stub

1. **What changes for the drafter.**
   1. CDPROFILE, and the older long-section tab, draw a 1.20 m stub of existing pipe past the first pit, and past the last pit, wherever an existing pipe joins there (`AddEndpointExistingPipeCut`, LongitudinalSectionService.cs about line 1626). A cut mark is drawn at the stub's end, reaching 120 drawing units further (`AddPipeCutSymbol`, about line 1648).
   2. The frame used to start at the first pit and stop at the last pit. Now `ResolveMinimumDisplayedChainage` and `ResolveMaximumDisplayedChainage` (about lines 1816 to 1855) widen it by the stub plus the cut mark, `PipeStubWithCutSymbolM` (about line 1813). The table lines, datum line and right-hand frame line all follow the frame (`rightX`, about line 1308).
   3. **Worked example at 1:100 horizontal.** The drawing factor is 1000 units per metre (`GetHorizontalModelFactor`, about line 1880). The route runs P1 at ch 0.00 to P2 at ch 20.00, with an existing pipe at both ends.
      1. **Before:** the frame was 20,000 units wide. The left stub ran 1,200 units into the 9,500-unit header column, and the cut mark ran another 120. On the right, both ran 1,320 units past the frame line.
      2. **After:** the frame starts at ch -1.32 and ends at ch 21.32, so it is 22,640 units wide. P1 sits 1,320 units right of the header line. Both stubs and cut marks are inside the frame.
      3. **Other scales:** at 1:200 the cut mark is 0.24 m, so each end widens by 1.44 m (720 units). At 1:500 it is 0.60 m, so each end widens by 1.80 m (360 units).
   4. It matches the carpark "Expected behaviour" ("The frame widens by the stub length when an existing pipe is drawn"), plus the cut mark, which is better.
   5. **Look notes, not faults:**
      1. The outer tip of the cut mark lands exactly on the frame line, with no clear gap.
      2. The ground line still starts at the first pit and stops at the last pit (`BuildExistingSurfacePolyline`, about line 1690), so there is now 1.32 m of frame at each end with a datum line but no ground line.
      3. The end pits' table values have more room on the outside (`leftBoundaryX`/`rightBoundaryX`, about line 1441), so their text may sit slightly differently.
2. **Switch.** `linking.longSectionFrameIncludesPipeStubs`, ON (UserSettings.cs about line 905 on the tip). It is pinned by `TheSwitchIsOnByDefault` and by the later Bj33 save tests. It is not pinned by a test that loads a settings file missing the key. The model default is true, so the normal JSON reader keeps it ON, but nothing tests that for this key. OFF: both helpers skip the new lines, and the cut-mark size is only used when ON, so the old frame comes back exactly. No engineering value is hard-coded: 1.20 m and 120 units are the existing drawing conventions the stub already used.
3. **No hard blocks.** No new stop, refusal or window.
4. **Protection and Redo.** It draws inside the existing section-drawing transaction, on the same layers as before. No new transaction, no event hook, no layer unlocked.
5. **Merge.** It touches the same UserSettings.cs spot as #1432 (both inserted after `PitLabelMaxDistanceMm`), and the top of REGRESSION_LOG.md. `git merge-tree` of 805e5492 with 846c5485 conflicts in both files, and of 805e5492 with 6177130e in REGRESSION_LOG.md only. Both were already resolved by keeping both entries at the C-45 train. No program function is shared with #1421 or #1432.
6. **Tests.** `LongSectionFrameStubTests` has six tests. The log says "written with the change, not run red first". Reading the code, the left and right tests would fail on the base: the old code gives 0.0 and 20.0, and the test helpers do not exist there, so it would not compile. `TheDrawingPassesItsHorizontalFactor_ToTheFrame` is a text check on the source code. It cannot prove the drawing.
7. **Not proven.** Nobody has seen it in AutoCAD; net48 was not built by the author; the frame against boundary marks and the ground line near the ends was never seen. **Robot (CE 02) scenario,** which needs fixture F-LS1 (not yet made):
   1. Make a copy of a drawing where the route's first pit has an existing pipe leaving to the left and the last pit has one to the right.
   2. Run CDPROFILE at 1:100 and draw the section.
   3. Read the frame's left and right line X, the two pit X positions and the stub end X.
   4. Expected: each pit sits 1,320 units inside the frame; the stub ends 120 units inside; no stub line has X less than the header line.
   5. Repeat with the switch OFF. Expected: the frame starts at the first pit again.
   6. **Codex look:** the end of the frame, cut mark against frame line, and the missing ground line in the end strip.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke (long sections).** The note: already shipped; close the PR, do not re-merge.

### PR #1421, BUG-768: a 600 x 600 pit is 600 mm wide in the long section evidence

1. **What changes for the drafter.**
   1. There is one new rule, `ProfilePitWidthRule.LargestWidthMm(PitData)` (Rules/ProfilePitWidthRule.cs, lines 22 to 31). Both profile readers use it: `ProfileRouteReviewService.ResolvePitWidth` (about line 868) and `LongitudinalSectionViewModel.ResolvePitWidthMm` (about line 1895).
   2. The 900 mm pump-station radius now counts only when `PitScheduleBuilder.IsSpsPit` is true, meaning the pit type contains "SPS" or "PUMP" (PitScheduleBuilder.cs about line 736).
   3. The pit width does not draw the pit. It decides where boundary marks go:
      1. **Between pits,** a boundary crossing within half a pit width of a pit centre is dropped (`LongSectionBoundaryProjector`, Helpers/LongSectionBoundaryProjector.cs lines 81 to 84).
      2. **Beyond an end pit,** the mark is placed at "distance from the pit centre minus half the width", and only up to 2.0 m (LongitudinalSectionViewModel.cs about lines 1490 to 1502, `EndpointBoundaryInclusionDistanceM` = 2.0).
   4. **Worked example.** A route ends at a 600 x 600 grated pit P1 at ch 0.00, and a fence runs straight across the pipe line beyond it.
      1. **Fence 0.5 m from P1's centre:** before, 0.5 - 0.9 is below zero, so the mark was dropped. Now 0.5 - 0.3 = 0.2, so a mark is drawn at ch -0.20.
      2. **Fence 1.5 m away:** before, the mark was at ch -0.60. Now it is at ch -1.20.
      3. **Fence 2.5 m away:** before, the mark was at ch -1.60. Now 2.2 m is past the 2.0 m reach, so the mark is dropped. A fence 2.3 to 2.9 m from a small end pit used to show and now does not.
      4. **Between pits:** a fence crossing a 20 m pipe 0.5 m from a 600 pit used to be dropped (inside 0.9 m). Now it is drawn at ch 0.50.
   5. **Detention tank (beyond the carpark entry, from review 1256):** with the switch ON, the width is also the larger of the plan-size rule, `PitOutline.PlanSize`. A 1200 detention tank now counts 2,550 mm, up from 1,800, so boundary crossings within 1.275 m of its centre are now dropped (before, 0.9 m). That is the real outline, so it is correct, but it is a second visible change hidden behind the same switch name ("counts a pump station's radius only..."). The switch label does not say it also changes tanks.
   6. It matches the carpark "Expected behaviour" ("Count the pump-station radius only on pump-station pits").
2. **Switch.** `linking.profilePitWidthCountsSpsRadiusOnlyOnPumpStations`, ON (UserSettings.cs about line 1322 on the tip). It is pinned by `SwitchOnByDefault` and Bj33. There is no missing-key load test, as for #1433. OFF: `RadiusCounts` returns true for every pit and the plan-size step is skipped, which equals the old `ProfileRouteReviewService` rule. The older tab's rule differs only for a pit whose X or Y width is unreadable (not a number). The old `Math.Max` carried that through and fell back to 450 mm; the new one ignores it and still counts the radius. That is unlikely on a real job and I did not prove it. No new engineering value is hard-coded: 900 mm stays the pit record's own default, and the 2.0 m reach is unchanged.
3. **No hard blocks.** No new stop. One knock-on effect: the pit width is part of a saved route review's fingerprint (`NodeFingerprintPart`, ProfileRouteReviewService.cs about line 1098). A route reviewed before this build, or before the switch is flipped, now reads "Stale" and needs re-reviewing in the Profiles window. That is existing behaviour, and the PR's log already says so. I did not check whether "Stale" stops drawing or only warns.
4. **Protection and Redo.** Read-only rule; it writes nothing to the drawing.
5. **Merge.** Clean against #1433 and #1432 except REGRESSION_LOG.md. #1421 and #1433 work on the same long section, but in different functions (pit width for boundary marks against frame width), so they do not share a function. Combined effect: a boundary mark beyond an end pit with an existing pipe can now sit inside the 1.32 m widened strip, which is fine. If it is further out, the frame already widens to reach boundary marks.
6. **Tests.** `ProfilePitWidthRuleTests` has seven tests on the tip. The log says the pure rule passed from the start and the source-text guard failed first; review 1256's fix was red because it did not compile. Reading the code, the 600-pit tests could not have run on the base (the class did not exist), and the old readers gave 1800. No test drives the boundary-mark placement itself with a 600 pit (the 0.5 m and 2.5 m cases above). That is the gap.
7. **Not proven.** Not seen in AutoCAD; net48 not built by the author; BUG_PROOF_LANES_31OCT records that case R28 does not cover it. **Robot scenario:**
   1. On a copy, draw two 600 x 600 pits 20 m apart.
   2. Draw a fence line crossing the pipe 0.5 m from the first pit's centre, and a second fence 1.5 m beyond the last pit.
   3. Run CDPROFILE.
   4. Expected: a boundary mark at ch 0.50 and one at ch 21.20 (20 + 1.2).
   5. Flip the switch OFF and redraw. Expected: no mark near ch 0.50, and the end mark at ch 20.60.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke (long sections).** Notes:
   1. Already shipped; close the PR.
   2. The detention-tank widening is behind a switch whose name and Settings wording speak only of pump stations. Either reword the Settings line, or add a carpark line so Tim knows a tank's boundary marks can also move. Not urgent.

### PR #1432, BUG-773 position half: CDRG records the true centre of the raingarden's area

1. **What changes for the drafter.**
   1. `RaingardenPlacementPlan.TryCreate` (Services/RaingardenPlacementPlan.cs about lines 133 to 139) now replaces the corner average with `TryAreaCentre`, the standard centre-of-area formula. It works from the first corner so survey coordinates keep their precision (about lines 172 to 216; the C-45 finalizer later split it into a coordinates-only copy for the net48 lane).
   2. The point is stored as the raingarden's Position in the project record (`AddExactProjectRow`, about line 242).
   3. Since 29 Oct (35401224), the "RG1" plan label is drawn there too: `SourceTagService.AppendLabelText(... plan.Centroid ...)`, SourcePlacementService.cs about line 958. The GIO block is not moved; it still goes where the drafter picks.
   4. **Worked example.** A 10 x 10 m raingarden outline drawn with 11 points along its bottom edge and 2 along the top, 13 points in all.
      1. **Before:** the corner average is X = 65/13 = 5.00 m and Y = 20/13 = 1.54 m from the bottom-left corner. RG1 sat 3.46 m below the true centre, about 1.5 m above the bottom edge.
      2. **After:** RG1 sits at (5.00, 5.00).
      3. **The BD07 L-shaped test (20 m2):** before 2.67 m, 2.67 m; after 2.20 m, 2.20 m.
      4. A plain rectangle drawn with four corners is unchanged.
   5. It matches the carpark "Expected behaviour" ("the stored position is the true centre of the area"). A double-clicked repeated point no longer pulls the centre, because a repeated point adds no area.
   6. **Look note:** for a strongly U-shaped or crescent raingarden, the true centre of the area can fall outside the planting, in the notch. RG1 would then sit outside the hatch. The old corner average could do the same. Worth one Codex look; not a fault.
2. **Switch.** `linking.raingardenPositionIsAreaCentre`, ON (UserSettings.cs about line 1011 on the tip). It is pinned by `TheSwitchIsOnByDefault`, Bj34 and `RaingardenLabelTests` line 49. There is no missing-key load test. OFF: `centroid` stays the corner average, exactly as before. If the area is too small to use (`TryAreaCentre` false), it falls back to the corner average even when ON. No engineering value is hard-coded.
3. **No hard blocks.** No new stop. The exact-number comparison that can refuse a good raingarden ("The saved raingarden project record changed after preparation", `RequireExactProjectRow` about lines 255 to 268) is untouched and still compares Position exactly. The area centre is no more or less likely to trip it than the corner average. That half of BUG-773 stays open, as the PR says.
4. **Protection and Redo.** No new drawing write. The RG1 label was added later and skips a locked or Xref GUIDELINES layer without unlocking it (SourcePlacementService.cs about lines 944 to 950).
5. **Merge.** Same UserSettings.cs insertion spot as #1433 (conflict, already resolved by keeping both) and REGRESSION_LOG.md. No shared function with #1433 or #1421.
6. **Tests.**
   1. `RaingardenAreaCentreTests` has seven tests. `ThePlanStoresTheAreaCentre` would fail on the base: Y would be 1.54. The survey-coordinate test was red before 846c5485, as the PR comment states.
   2. `TheOlderCornerAverageWasOffCentre` works out its own average and never calls CE, so it proves nothing about the product. It is harmless.
   3. Better proof exists: CODEX_TESTS_BD07_24OCT ran the BD07 L-shape tests on the unfixed parent 70a4e24f. Both failed with 2666.67 mm instead of 2200 mm, and pass on the fix.
7. **Not proven.** Not seen in AutoCAD; BUG_PROOF_LANES_31OCT lists no case for BUG-773. **Robot scenario:**
   1. On a copy in a metre drawing, run CDRG and pick a 10 x 10 m outline with many points along one edge (or select such a polyline).
   2. Read the RG1 text insertion point and the saved raingarden Position.
   3. Expected: both at the square's centre, within 1 mm.
   4. Repeat with an L shape. Expected: 2.20 m, 2.20 m from the outside corner for the BD07 shape.
   5. Switch OFF. Expected: the corner average returns.
   6. **Codex look:** RG1 on a U-shaped garden.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke (CDRG).** The note: already shipped; close the PR. The exact-compare half of BUG-773 is still open and needs its own fix and its own net48 test.
