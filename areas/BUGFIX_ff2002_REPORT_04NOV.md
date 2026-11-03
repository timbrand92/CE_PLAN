# ff2002: FIX-FIRST for draft PR #2002 (B-183, BUG-879), 4 Nov 2026

## FOR TIM

1. **What you will see differently (once built into AutoCAD):** with "hand-placed labels stay" on, a pipe label you slide with CE's grip stays put when you run Tidy labels. If you then turn `ceMovesMarkHandPlaced` off, that label is released again and Tidy moves it. A label you moved with AutoCAD's own MOVE stays held either way.
2. **CDANNOTATIONEDIT, Move with the same point twice (0 mm), or Rotate by 0 degrees:** no longer marks the label. Tidy still moves it.
3. **A pit cover text moved with CDANNOTATIONEDIT** is now marked, the same as the pit flip grip.
4. **My own mistakes:** my first two test runs failed on my own run script (dotnet not on PATH, then a path with a space) and my first new test used a class that is not visible to the tests. About 40 minutes lost; nothing reached the PR.
5. **NOT proven:** nothing was opened in AutoCAD. Built and unit-tested only. BUG-879 stays OPEN. The new tests for C1 and C3 partly read the code text (the same weakness the review called C7); the rule-level ones (held or released by switch, 0 mm transform) are real result checks.
6. **Not done, as ordered:** C5 (pit cover text has no Reset) needs your yes or no: "Once you flip a pit's cover text by hand, should there be a Reset on the pit text grip menu to give it back to Tidy labels?" Recommendation: yes, but as its own small job. C6 (legacy pit upgrade drops the mark) and C7 (more result-level tests) were not in the four FIX FIRST items, so not touched.
7. **Robot case to prove it:** `N879_ce_move_marks` in the N31_dp_time style. Case A (switch ON): type a CE grip Slide on a pipe description that overlaps another label, then CDTIDYLABELS; check the command line says "Placed by hand 1" and the label position is unchanged. Control (switch OFF, set before AutoCAD starts, reopen the same drawing): CDTIDYLABELS; check "Placed by hand 0" and the label moved clear. Case B: CDANNOTATIONEDIT, Move, pick the same point twice, then CDTIDYLABELS; check Tidy moves it. Case C: CDANNOTATIONEDIT, Move on a pit cover text onto another text, then CDTIDYLABELS; check it stays.

---

## Technical detail

1. **PR / commit:** #2002, branch `claude/w879-hand-placed`, one additional normal commit `fddbd2e7` on top of `229f354a`. No force-push, no retarget, no new PR. Leak scan clean.
2. **C1:** new `PipeAttachment.PlacedByCeMove` (omitted while false). CE's own routes write it instead of `PlacedByHand` (`LinkService.PipeAttachmentActions.cs`, `LinkService.cs` UpdateAttachmentFromEntity). Reset Position clears both. Readers (3 sites in `LinkService.TextClashTidyUp.cs`) use the new `HandPlacedLabelRule.HeldInTidy(byHand, byCeMove, staySetting, ceSwitch)`. Carried in `LinkService.SegmentAnalysis.cs` and both `LinkService.Split.cs` copies.
3. **C2:** `HandPlacedLabelRule.IsNoChangeTransform(matrix.ToArray())` (1e-6 drawing units, same tolerance as the grip route's HasMeaningfulPositionChange); `AnnotationEditCommand.ApplyTransform` returns false before any write when the transform is identity.
4. **C3:** `UpdateAttachmentFromEntity` marks the pit through new `LinkService.MarkPitCoverTextPlacedByHand(db, pitHandle)`; `TryMovePitCoverText` now shares the same one rule (`MarkPitCoverTextPlacedByHand(PitData)`).
5. **C4:** `Bug284LockedLayerChangeTests` marker changed to `private static bool ApplyTransform(`, all assertions kept.
6. **Switch:** unchanged, `linking.ceMovesMarkHandPlaced`, ships ON, "Default: on.", both start-up reads still pinned. Switch OFF now also releases CE-move marks already stored.
7. **REGRESSION_LOG.md:** line 3a added to the #2002 entry.
8. **Tests:** `dotnet test` of `CE_CVL_SUITE.Tests` net10.0-windows only, filter `FullyQualifiedName~Bug879|FullyQualifiedName~Bug284LockedLayerChangeTests`: 76 passed, 0 failed, 0 skipped. net48 build of the test project: 0 errors (297 warnings). Flags `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, AutoCAD refs per the C62 report. Not run: the full Civil suite (Codex's 2 failures: one was C4, now fixed; the other, a screenshot file lock, is untouched and unknown).
9. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP set to `C:\CE_WORK\scratch\ff2002\...`. Listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` before and after: 36,805 files each, no difference in name, size or last-write time. Files: `C:\CE_WORK\scratch\ff2002\appdata_before.txt` and `appdata_after.txt` (removed with the scratch folder; the comparison result is stated here). No Manager tests. No AutoCAD started.
10. **Files touched (12):** `Commands/AnnotationEditCommand.cs`, `Rules/HandPlacedLabelRule.cs`, `Services/LinkService.cs`, `.PipeAttachmentActions.cs`, `.PitCoverText.cs`, `.SegmentAnalysis.cs`, `.Split.cs`, `.State.cs`, `.TextClashTidyUp.cs`, two test files, `REGRESSION_LOG.md`. CE_SHARED untouched.
11. **Open PRs on the same files:** #599 and #469 touch `AnnotationEditCommand.cs` (as the review noted); not read. Whoever merges second resolves `ExecuteMove`/`ApplyTransform`.
