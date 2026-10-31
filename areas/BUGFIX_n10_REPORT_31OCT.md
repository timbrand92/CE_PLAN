# BUGFIX n10 REPORT: batch 10, tidy labels after a pit MOVE (B-124), 31 Oct 2026

## FOR TIM

1. **Answer:** two draft PRs are open, both built and unit-tested only. Nobody has opened either in AutoCAD, and no bug is marked fixed.
   - **PR #1975** (BUG-1253 and BUG-1034, one fix): after you MOVE a pit, or press Apply in Tidy labels, an invert text no longer ends up lying across the blue strip of its own pipe.
   - **PR #1976** (BUG-1161): a pipe label with kept wording, such as "APPROX.", keeps that wording when you move, flip or grip the label. It is stacked on #1975.
2. **What you will see differently:** MOVE a pit by 2 m. The upper-left IL text used to sit on the blue strip. Now CE moves it to the nearest spot clear of the strip. A text already beside the strip is left alone, even beside a sloping pipe. A text you placed by hand is left alone with no message. If a text has no clear spot it stays where it is and is listed. Nothing is blocked.
3. **My mistakes, first:**
   1. My first test run failed on a missing 0-byte native placeholder file and cost one wasted compile (about 8 minutes).
   2. I waited about 35 minutes for C: to rise above 27 GB before building. It stood at 26.3 to 26.7 GB and recovered by itself. I deleted nothing.
   3. The real-folder compare shows changes. They come from an AutoCAD session on another lane, not from my tests. Details in the technical part, item 6.
4. **Not proven:** I never saw the overlap in a running AutoCAD. I found the cause by reading the code and modelling the fault in a unit test. Please read the "Not proven" list in the technical part before trusting either PR.
5. **Two bugs I skipped:** none. All three had the fault on the 102a line (Civil 3.0.88).
6. **Question for you:** none. BUG-1034's note says "needs a drafting judgement" (is a text on the pipe ever intended?). Your own expected-behaviour line says the text should be beside the pipe, so I built that. If you want a text "in from the pipe end" to sit on the pipe, set the switch to false.

---

## TECHNICAL DETAIL

1. **Line and base:** `origin/claude/rel-20261102a` (Civil 3.0.88, `3fbb9da5`). Worktree `C:\CE_WORK\build\n10`. Build number B-124.
2. **PR #1975**, branch `claude/b124-n10-bug1253-pit-move-label-strip`, base `claude/rel-20261102a`, commit `85ed7a3a`.
3. **PR #1976**, branch `claude/b124-n10-bug1161-moved-label-keeps-wording`, base the #1975 branch, commit `d9f58c22`. It is stacked because both PRs edit `UserSettings.cs` and `REGRESSION_LOG.md`. Merge #1975 first.
4. **Confirmed on the 102a line (file and line):**
   1. **BUG-1253 and BUG-1034, same root.** `Services/LinkService.TextClashTidyUp.cs`, `TidyOnePipe`: the pipe, its mline strip and its own texts go into `ownIds` (lines 273 to 286). `TidyScan.Filter` skips `ownIds` (line 687) and own pipes (line 704), so the own strip was never an obstacle. A text on its own strip was never a clash. A slide spot that lay on the strip was accepted. `LabelPlacementRule.Spots` keeps the same offset for "in from the pipe end (n)" and never asks about the strip. The after-MOVE tidy is always on at 102a. There is no switch until #1875 lands, so "whether it is on for colleagues" is answered: yes, always.
   2. **BUG-1161.** `Services/LinkService.SegmentAnalysis.cs`, `BuildAttachmentData` (lines 259 to 280): it copies display mode, custom text, linked text and the placement fields from `previous`, but not `LinkedDisplayPrefix` or `LinkedDisplaySuffix`. `LinkService.Split.cs` `CarrySplitIdentity` (lines 2627 and 2628) does copy them. The move (`PipeAttachmentActions.cs:334`), grip (`PipeAttachmentGrip.cs:941`) and hand-MOVE (`ExternalAttachmentMoves.cs:151`) routes all pass `previous`.
5. **Changes:**
   1. **#1975.**
      - New `Rules/OwnPipeStripClearRule.cs`: the switch, plus the pure text-rectangle versus strip test (separating-axis).
      - `Rules/LabelPlacementRule.cs`: `PipeSegment.OwnStrip` and `BoxTouchesPipe(TidyBox, PipeSegment)`.
      - `Rules/TextClashTidyUpRule.cs`: `TidyBox.Oriented`, and a non-movable text ignores the own strip.
      - `Services/LinkService.TextClashTidyUp.cs`: reads the switch, measures each DBText or MText on an unattached transformed copy (`TryReadOrientedTextRect`), and adds the own-strip segments to `pipeObstacles` for the two ordinary plans (not the branch-host plan).
      - Switch `linking.tidyKeepsLabelsOffOwnPipeStrip` in `Models/UserSettings.cs`, documented "Default: on."
   2. **#1976.**
      - New `Rules/MovedLabelKeptWordingRule.cs`.
      - `BuildAttachmentData` carries both fields.
      - Switch `linking.movedLabelKeepsKeptWording`, ON.
   3. **Why the true rectangle, not the box:** the box CE keeps for a turned text is axis-aligned. Beside a 45 degree pipe it is far bigger than the text and would have called ordinary labels a clash, pushing them out a lane. A unit test proves the difference.
   4. **Shared files:** `UserSettings.cs` and `REGRESSION_LOG.md`, in both PRs. CE_SHARED is unchanged. Open draft #1875 (B-025, `fb/bug816-tidy-setting-row`) edits `TidyOnePipe`'s signature and adds a neighbouring switch in the same two shared files. Only those two files conflict textually. Keep both sides.
6. **Tests (Civil net10, `CE_CVL_SUITE.Tests.csproj`, one project per command, `--filter`, `-m:2`, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD 2027 on PATH):**
   1. Focused run: **155 passed, 0 failed** (34 new B124N10 tests, plus the Tidy, Bug141, LabelPlacement, BranchHost, TidyLeaderOut, TidyRearrange, PitTextTidy and TidyLabelsGate classes).
   2. C75 and C76 switch-default classes: **63 passed, 0 failed.**
   3. Drainage **net48 Release compile: 0 errors** (`_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`).
   4. **Full suite NOT run** (batch rule). C77 and C78 switch-default classes NOT run, because they write a test folder I did not read through.
   5. The new switch-default tests pass through both `DeserializeSettings` and `DeserializeSettingsTolerant`: empty file, a linking group without the key, typed false, typed true.
   6. **Real-folder compare:** listings (names, sizes, times, no contents) are in `C:\CE_WORK\evidence\n10\real_before.txt` (33,624 lines, taken 23:06) and `real_after.txt` (33,669 lines, taken after my last test). 81 lines differ. They are `CD_RecentValues.json` (23:38), `CD_Settings.json` (size 15404 to 15270, last-write set to 4 Oct), the CE_Admin outbox usage, machines and sessions files, the CE_CVL_SUITE, CE_STRUC_SUITE and CE_CADTOOLS logs, the cdcheck log of 23:39 and `suggestions.jsonl`.
      - **I judge these are not mine.** The real CE log lines in the window are AutoCAD work ("Project data loaded from DWG: 11 pits, 49 pipes", Inspector picks, a CDCHECKDWG run). An `acad.exe` started at 23:54:12 and was still writing at 23:58.
      - My scratch redirect folder `C:\CE_WORK\scratch\n10\logs` stayed empty, and no line in the real log mentions the tests.
      - **`CD_Settings.json` changed.** It is the one real settings file in the list, and someone restored an older copy (its last-write is 4 Oct). My tests do not write settings. Check that the restore is the robot's doing.
      - I did not stop, because I could find no evidence my run wrote any of them. Say so if you disagree.
7. **Not proven:**
   1. No AutoCAD run. The overlap was never seen by me.
   2. The invert text is assumed to be a DBText or MText. If it is a block attribute, an MLeader or another type, the fix does nothing for it (no rectangle, no own-strip clash), which is the old behaviour. I did not check what type the G5 invert texts are.
   3. `GetTransformedCopy` plus `GeometricExtents` on an unattached copy is the measuring method. It compiles and the sums are tested, but it has never run on a real text.
   4. The strip's width is taken as the pipe diameter (the same figure the other-pipe test uses). If the drawn mline is wider than that, a text can still touch the drawn strip.
   5. BUG-1161's visible effect is UNSURE. A later refresh might re-learn the wording from the text. The fix is harmless but may change nothing you can see.
   6. The Settings page has no row for either switch, like C-75 to C-78.
8. **Robot cases, with switch-off controls:**
   1. **N10_pit_move_strip / C10** (BUG-1253 and BUG-1034).
      - Open the G5 copy (pit P3 with two upper pipe ends).
      - Before launch, set `linking.tidyKeepsLabelsOffOwnPipeStrip` true for N10 and false for C10.
      - Type MOVE, pick P3, base 0,0, destination 0,2000.
      - Read the upper-left IL text of P3: its rectangle against the upper-left pipe centreline.
      - N10 passes if the distance from the text to the pipe centreline is more than half the pipe diameter, so the text is off the strip.
      - C10 should show the old overlap: distance less than half the diameter. If C10 never overlaps, the case does not prove the fix.
      - A Codex picture is still needed for "label clear of the strip".
   2. **N11_label_wording / C11** (BUG-1161).
      - Give a pipe label the wording "APPROX." (CDTEXTSEG or the label's own wording edit), then flip it with the label grip.
      - Read the pipe's saved record for that label: `LinkedDisplayPrefix` is still "APPROX. ".
      - N11 has `linking.movedLabelKeepsKeptWording` true. C11 has it false and the prefix is gone.
      - Needs the two-session check from the 24 Oct amendment before Claude-accepted.
9. **Cleanup and space:** `git clean -fdXq` and `git worktree remove` done for `C:\CE_WORK\build\n10`. That path no longer exists. C: free went from 46.40 GB to 46.86 GB (+0.46 GB) with the cleanup. It was 27.0 GB at the start of the job. The rise to 46 GB came from other lanes, not from me. The scratch folder `C:\CE_WORK\scratch\n10` is removed after this push. The two real-folder listings are kept in `C:\CE_WORK\evidence\n10` (about 12 MB, under `C:\CE_WORK`, not the root of C:).
10. **Branches and PRs are never closed, retargeted or deleted by me.** No force-push. BUG_CARPARK.md and DESK_LOG.md not edited.
