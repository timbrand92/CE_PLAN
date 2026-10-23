# Max build F: the MERGE-WITH-FIXES items from the Opus review of the cx4 and batch 4 PRs (Sat 24 Oct 2026, Melbourne)

Builder: Sonnet 5.5 on the Max meter. Source of the fixes: `C:\CE_PLAN\areas\REVIEW_CX4_AND_BATCH4_24OCT.md`. Base of every PR: `origin/claude/rel-20261023m` @ `f7f7d551`. Nothing deployed, AutoCAD and Codex not started, no PR closed, no branch deleted, no force-push, no rebase of an existing PR branch, CE_SHARED, Settings and installed bundles untouched. Private worktrees were under `C:\ce-mx3` (all removed at the end, nothing else under `C:\ce-*` touched).

## ANSWER FIRST

1. **#1717 (FB-25, BUG-812): fixed and pushed.** The copied-pump-pit line and the "could not read every pump pit block" line now print once per drawing per session, not on every Pit Schedule reload. New head on the PR's own branch `fb/fb25-schedule-order-pump`: `676874b54645f83aa8b838856ffc54b876a5c413` (was `cedc590e`). 4 new tests (the review fix; they do not compile on the base). Civil net10 full suite: **19,563 total, 19,541 passed, 22 skipped, 0 failed.**
2. **#1720 (FA01, RD03-03/06/07/11): fixed and pushed.** This is the other MERGE-WITH-FIXES in the report. "Apply to drawing" in Label Styles no longer asks the Civil / Structural question on the command line while the window is open. It uses a new check with the same read-only, REFEDIT and paper-space refusals, and an untagged or Structural drawing gets one plain line and nothing is changed. New head on `cx4/fa01-inspection`: `e596d42673b51da99b91223a05043e9a266b1a34` (was `50fd12eb`).
   1. **The branch moved while I worked.** Another session pushed `1b40fd11` (a one-test fix) between my fetches. My first full run failed that one test (`EachSharedBlocker_HighlightsItsOnlyInput_WithoutChangingDraft("CoverLevel")`), which `1b40fd11` already fixes. I rebased my single unpushed commit on top of it (normal push, no force), kept both sides of the `REGRESSION_LOG.md` clash, and re-ran.
   2. **Tests:** 3 new tests, 1 existing test updated (it looked for the old call name). Civil net10 full suite after the rebase: **19,580 total, 19,557 passed, 22 skipped, 1 failed.** The one failure was `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (took 16 s while the machine was busy); it **passed on its own re-run** (1 of 1). The C-62 report also saw this test as load-sensitive. So: 0 real failures, one timing flake not re-proved in a second full run.
   3. **Also done:** the review's note for the log (Save no longer needs a selected style; an empty list stays empty on reopening) is in the regression entry. The review said the full Civil suite was still owed for this PR; that is now the run above.
3. **#1716 (FA02, units): done as a new draft PR #1727, #1716 untouched.** Branch `fb/max-1716-rebased` (head `0dc93743293406bec8a7b5b053945881cfb98990`) = `rel-20261023m` + #1707 head + #1708 head + the #1716 commit + one review-fix commit. It was simple enough: four LandXML conflicts, all in `LandXmlParser.cs`, plus the log. Civil net10 full suite: **19,597 total, 19,575 passed, 22 skipped, 0 failed.** Details in section 3.
4. **Not done / not tested:** nothing opened in AutoCAD (all three are built and unit-tested only, not Codex-accepted, not Claude-accepted, not Tim-accepted). net48 and net8 not built by me (net10 Civil test project only). Manager tests not run (no Manager file touched). The LandXML `elevationUnit` question is still open (section 3.5). No bug marked FIXED.

---

## Per PR

1. **#1717, BUG-812, `fb/fb25-schedule-order-pump`, new head `676874b5`.**
   1. **What was wrong (review item 4.3):** `WithCrossDisciplinePumpPits` runs on every Pit Schedule reload, so a drawing with one copied pump pit repeated "[CE] Pit Schedule: a second pump pit block is labelled ..." again and again.
   2. **Fix, exactly as the review asked:** each screen line is remembered per drawing (the drawing's fingerprint plus the line, which names the pit) and printed once per session. A different copied pump pit still reports once; a different drawing reports once. The "could not read every pump pit block" line is covered the same way. File: `Modules/Drainage/Services/PumpPitScheduleReader.cs`.
   3. **Tests:** four new in `Bug812ScheduleOrderAndPumpPitTests`: six reloads print once; another pit and another drawing still report once each; the read-failed line prints once; a source guard that every screen line goes through the filter. The class now has 15 tests, all pass. `REGRESSION_LOG.md`: item 6 added to the BUG-812 entry.
   4. **Not tested:** a real copied CE_PUMP_PIT block in AutoCAD. A drafter who fixes the copy and then makes another copy with the same label in the same session will not see the line a second time (once per session, as the review asked).
2. **#1720, `cx4/fa01-inspection`, new head `e596d426`.**
   1. **Fix:** `DrawingDisciplineService.EnsureCivilAllowedWithoutPrompt` (same decision as the existing one, never asks, one plain line for an untagged or Structural drawing, wakes Civil on allow), `DrawingSafetyService.CommandPreFlightWithoutPrompt` (same core checks), and the Label Styles Apply button calls it. `DrawingDisciplineService.cs` and `DrawingSafetyService.cs` are Civil (Modules/Drainage) files, not CE_SHARED, installer or Settings; the Codex brief listed some files as protected for Codex, which does not apply to this builder, but the desk should know two shared Civil services were edited.
   2. **Tests (Rd03OfficeEditorTests):** Apply uses the no-question check; the no-question method contains no prompt call and still refuses untagged and Structural; the new pre-flight keeps the shared core checks (read-only, REFEDIT, paper space). One existing test updated. Focused Rd03 run: 32 of 32 passed. Full suite as in the answer block.
   3. **Not tested:** the actual command line in AutoCAD with the Label Styles window open on an untagged drawing, a Structural drawing, a read-only drawing, REFEDIT and a layout.
3. **#1716 replaced by #1727 (`fb/max-1716-rebased`), head `0dc93743`.**
   1. **How:** new branch from `origin/claude/rel-20261023m`, merged `fb/fb16-landxml-import` (#1707) and `fb/fb17-landxml-scale-grade-rim` (#1708) at their current heads (`f9eebcfb`, `2ed82768`), cherry-picked the one #1716 commit (`8b95539a`). Resolved the four `LandXmlParser.cs` conflicts by keeping #1708's single file scale (`DecideFileScale`) and adding the level unit on top: the report-line list gets both markers, the unit decision keeps the file scale and then reads the level unit, `ParseStruct` takes both. Levels are converted to metres first, then #1708's cover rounding runs (the order the review asked for). `REGRESSION_LOG.md`: kept every side.
   2. **Review fault 2 (file with no Units line):** decided as the review recommended: levels stay Unknown and the import report says why. New test `Rd04_03_FileWithNoUnitsElementAtAll_KeepsLevelsUnknownAndExplains`. Note for Tim: an old export with no Units line now imports blank cover and invert levels.
   3. **Review fault 3 (design rule 1):** the two copy-a-drain calls in `LinkService.SurfaceDrainTags.cs` now pass the drawing's own units. New source-guard test in `Rd04AgiDrawingUnitsTests`.
   4. **Extra test:** conversion happens before rounding (a millimetre file's 100234.56 reads as cover 100.23).
   5. **Review item 6 (LandXML 1.2 separate vertical unit): NOT checked.** I tried to fetch the schema and the connection was reset. My own recollection is that the 1.2 Metric element has a linear unit and a separate diameter unit but no elevation unit, but I did not verify it; the regression entry says it was not checked. Level conversion uses the linear unit only.
   6. **Merge order for the desk:** #1727 contains the #1707 and #1708 commits. Merge #1727 INSTEAD of #1716 (after, or together with, #1707 and #1708; git will see the shared commits as already merged). Do not merge #1716 as well. #1716 is left open and unchanged.
   7. **Tests:** focused 152 of 152 passed, then the Civil net10 full suite 19,597 total, 19,575 passed, 22 skipped, 0 failed. Draft PR: https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1727
   8. **Not tested:** a real metre and a real millimetre drawing in CDAGI and CDPERIMETER, a copied open drain in a metre drawing, and a real 12d or Civil 3D LandXML with and without a Units line, all in AutoCAD.

## Other PRs in the report

1. **MERGE verdicts (#1711, #1712, #1713, #1719):** nothing to fix, untouched.
2. **HOLD (#1718, #1721):** need their own build and tests from their builders, not a code fix; untouched.
3. **REJECT (#1714, #1715):** nothing to merge; untouched.

## What I did NOT do or test

1. Nothing opened in AutoCAD; no Codex pass; no net48 or net8 build; no Manager test run.
2. I did not rebuild any PR with its fix removed. The new tests either do not compile on the old code (new method names) or assert text the old code did not have; I did not run the old code to see them red.
3. The full Civil run for #1720 hit one slow-PDF timing flake that passed alone; I did not run the full suite a second time.
4. One other builder's lock file `C:\CE_PLAN\desk_jobs\build.lock` was already held and unreadable, and many other `dotnet` processes were running, so my builds ran beside them (the lock is advisory in the existing scripts). Tests may have been slower than normal.
5. I did not edit `DESK_LOG.md`, `QUEUE.md` or `BUG_CARPARK.md`.
