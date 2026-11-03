# Opus pre-review FILL UPHILL: PRs #1434 (BUG-681), #1435 (BUG-682), #1437 (BUG-683), CD Uphill box and same-plan break stack

Written Monday 2 November 2026, 13:21 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request (job 602, queue filler 6).
Release tip checked: `claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88, C-78). Newer train branches also exist: `rel-20261106a` 61fd6fbc (3.0.89, C-79a) and `rel-20261108a` cf059dcf (3.0.90, C-79b1).
Heads reviewed: #1434 b26a8ef3, #1435 28c1db7e, #1437 f5e5472a. All three are DRAFT and OPEN on GitHub. All are Civil only.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the PR descriptions, the diffs, the code around them on the release tip, the carpark entries (BUG-681, BUG-682, BUG-683) and `areas\PR_PILE_TRIAGE_2026-10-24.md`. I ran read-only `git fetch`, `git log`, `git show`, `git grep` and `git merge-tree` only.

## FOR TIM

1. **Most important: all three fixes are already in your installed CE, and have been since Civil 3.0.70 (20 October).** The PRs are old leftovers that were never closed. Nothing needs merging again. CE 05 should close them with a "shipped in C-50" note. The three bugs stay OPEN: no robot or Codex run has checked them yet.
2. **#1434, the Pit Schedule row follows your answer to CD's Uphill box (BUG-681): KEEP.** Example: you CD from P1 to P2 and type 10.00 then 10.50 by mistake. Answer Yes (flip) and the Pit Schedule now reads From P1 10.50 To P2 10.00, the same as the plan. Before, the schedule said the opposite of the plan. Answer No (rising main) and the row runs from the lower pit and names the discharge pit. Switch is ON.
3. **#1435, Cancel in the Uphill box puts back what it can (BUG-682): KEEP.** Example: you turn your own polyline into a pipe, then press Cancel in the Uphill box. Your polyline comes back, and the pipe's Pit Schedule row is removed. A pit CD made bigger is not put back by Cancel, but the message tells you to press U once, and that U does put it back. Each CD pipe is its own Undo step, so that one U only touches this pipe.
4. **#1437, a same-plan break asks the real length first (BUG-683): KEEP-WITH-NOTE.** Example: grade 1 in 100 from 20.00, 20 m drawn, real length 50 m. The far end now reads 19.50, not 19.80. **The note:** if you then press Esc when it asks for the two break points, CD keeps the unbroken 20 m pipe with levels worked over 50 m. That pipe falls 0.5 m over 20 m drawn (looks like 1 in 40 on the plan), and the message does not say so. This is a small follow-up, not a reason to pull the fix.
5. **Settings switches:** all three are ON, sit in Settings on the Fixes tab, and turning one OFF gives the old behaviour exactly. No council or design value is hard-coded.
6. **Order and merging:** the stack is #1434, then #1435, then #1437. All three are already inside the release, so a test merge against the tip changes nothing and clashes nowhere. One oddity: #1437 was built on an earlier copy of #1435, before #1435's review fixes. That no longer matters, because both went into the trains.
7. **Not proven:** nobody has opened any of this in AutoCAD. The tests check the sums and the order of the code, not the drawing. No test touched your real settings.
8. **What the robot should run:** the three AutoCAD checks under "Robot scenario" below (Uphill Yes, No and Cancel; Point Order; same-plan break 20 m drawn and 50 m real, plus Esc at the break points).

---

## DETAIL

### Group facts (apply to every PR below)

1. **Already shipped.** `git merge-base --is-ancestor` shows all three heads are inside `rel-20261102a` and `rel-20261108a`. Merge commits: 7d7f7f38 "Merge pull request #1434" and f477967e "Merge pull request #1435" (both 19 Oct 2026, 02:34), and 1b20cbfd "Merge PR #1437 (BUG-683 same-plan break real length, fix round) into C-50" (20 Oct 2026, 10:47). The carpark says "fix installed in Civil 3.0.70 / Manager 1.1.70" for all three. `PR_PILE_TRIAGE_2026-10-24.md` items 671, 672 and 674 already class them A (head inside the installed build). The brief's "no Opus pre-review" is also not quite right: the code carries fix rounds for earlier Opus reviews (#1434 LOW 1, #1435 MEDIUM, review 1271 LOW 2). I could not find those review files, so I reviewed the code from the start.
2. **Bases and the stack.** #1434 sits on `claude/rel-20261018d`. #1435 adds 60fcad04 and the fix round 28c1db7e on top of #1434. #1437 is based on 60fcad04, the **old** #1435 head, so #1437 alone does not carry #1435's fix round (the "forget the previous pipe's line" clear at `CdCommand.cs:337` and `EndsAfterAnswer`). Merged on its own, #1437 would have shipped #1435 without its fixes. In practice both went into C-50, and the release tip carries the fix round (checked: `CdCommand.cs:337` and `UphillDecisionScheduleRule.EndsAfterAnswer` are on the tip).
3. **Shared function.** All three PRs edit `CdCommand.ExecutePipeDrawing` (`Modules/Drainage/Commands/CdCommand.cs`). #1434 and #1435 both edit the same Uphill-box block (tip lines 858 to 990) and `ApplyUphillAnswerToScheduleRow` (`CdCommand.Schedule.cs:146-170`). #1437 edits the length step earlier in the same function (tip lines 440 to 453). All three add a key to the same place in `UserSettings.cs` `LinkingSettings` and an entry at the top of `REGRESSION_LOG.md`. They are stacked, so none of these clash.
4. **Merge-tree.** `git merge-tree --write-tree rel-20261102a <head>` returns the tip's own tree (b93851dc) for all three heads: no conflict, no change, because the code is already there.
5. **Recommendation for CE 05.** Close #1434, #1435 and #1437 as "shipped in C-50 (Civil 3.0.70); bugs stay OPEN until robot plus Codex". Do not merge them again. Any follow-up from this review goes in a new small PR on the current tip.

### #1434: BUG-681, the Pit Schedule row follows the Uphill answer

1. **What changes for the drafter.**
   1. **Yes (flip).** `CdCommand.cs` (tip ~945) calls `ApplyUphillAnswerToScheduleRow(..., risingMain: false, ...)` after `LinkService.FlipPipeInverts` and the label redraw. `FlipPipeInverts` keeps the row's From and To levels (it calls `UpdatePipeInvertsByHandle(handle, oldSecond, oldFirst)`, which is From, To). `UphillDecisionScheduleRule.AfterFlip` then swaps the pits and their stored identities but keeps the levels. Result: From P1 10.50, To P2 10.00. That matches the redrawn plan. Correct.
   2. **No (rising main).** `CdCommand.cs` (tip ~985) calls it with `risingMain: true` after the layer change. `AfterRisingMainConversion` swaps pits and levels, so the row runs from P1 10.00 to P2 10.50, and `TryResolveRisingMainDestination` (`CdCommand.Schedule.cs:217`) names the last-point pit, the higher end. Correct for a pump that lifts from P1 to P2.
   3. **Point Order mode (tip `CdCommand.cs:863-868`).** With the switch ON, CD no longer calls `FlipPipeInverts`. The stored levels stay with the points they were typed at, which matches the labels (they are not redrawn on this path). The row was already written From the higher end by `TryAddPipeToSchedule` (`CdCommand.Schedule.cs` flow test, first minus second greater than 0.0001), so it is already right. Correct.
   4. **Matches the carpark?** Yes, for the "after the answer" half. The other half ("ask the uphill question before anything is written") is plainly marked NOT done in the PR and in the regression log. That is honest. BUG-681 should say so when it is closed.
2. **Settings switch.** `linking.cdUphillAnswerUpdatesSchedule`, default true (tip `UserSettings.cs:901-902`). Read live from `SettingsService.Current` at each use. No start-up copy, so no "set before launch" trap. OFF: `ApplyUphillAnswerToScheduleRow` returns at `CdCommand.Schedule.cs:149`, and Point Order goes back to `FlipPipeInverts`. That is the old code exactly. **Defaults test:** the PR pins only `new LinkingSettings().CdUphillAnswerUpdatesSchedule == true`. It does not pin a settings file that lacks the key. Newtonsoft keeps the initialiser, so the answer is true, and a later PR (`Bj34SettingsPersistenceTests`, `Bj34CivilSettingsRowsTests`, on the tip) pins the Settings window round-trip. Good enough. No engineering value is hard-coded: the 0.0001 m figure is the existing "same level" tolerance, copied from `TryAddPipeToSchedule` on purpose so the two always agree.
3. **No hard blocks (R-27).** None added. The Uphill box is an old modal window, not changed here.
4. **Native protection and REDO.** The row write is a project-data change (`ProjectDataService.ApplyUphillDecisionToPipeRow`, `ProjectDataService.Mutations.cs:1499`), not a drawing change. No locked-layer or Xref route is touched. It is not a PROTECTED file. The writer does not honour the "manual override" flags the way `UpdatePipeInvertsByHandle` does. On a pipe created a moment earlier no override can be set, so this is safe.
5. **Merge.** See group facts 2 to 4.
6. **Tests.** `UphillDecisionScheduleRuleTests` (5 at this head): the pure swap rules and one source guard that reads `CdCommand.cs`. The rule class is new, so "red before" would only be a compile failure. The source guard would have failed before. Neither proves the drawing. No test reads or writes `%APPDATA%`: they build `new LinkingSettings()` and read source files only.
7. **Not proven.**
   1. Nothing is run in AutoCAD, and net48 was not built at the time.
   2. Other records that depend on which end is From were NOT swapped, for example the pit connection review records written by `CaptureAndReportConnectionReview` before the question. I could not verify whether Pit Schedule's inlet and outlet listing for P1 and P2 follows the swap.
   3. Point Order with the switch ON leaves the stored first level as the LOWER one at point 1. I did not trace whether Edit Pipe and CDPROPAGATE read that correctly when the flow runs against the drawing direction.
   4. At #1434's own head, a level pipe answered No would get no discharge pit. Fixed in #1435 (`EndsAfterAnswer`). Note that `IsUphillForWarning` (`CdCommand.cs:31`) is strictly "downstream higher", so a truly level pipe never reaches the box. That fix only matters for differences under 0.1 mm.
8. **Verdict: KEEP.** Train class: none needed, already shipped (C-50, Civil 3.0.70). If anything is re-trained: Civil area plus smoke.

### #1435: BUG-682, Cancel in the Uphill box puts back what it can

1. **What changes for the drafter.** Tip `CdCommand.cs:886-899`. After Cancel, CD still erases the new pipe, labels and arrow (`EraseCreatedPipeEntities`), and with the switch ON also:
   1. removes the pipe's row (`ProjectDataService.RemovePipe(pipeId.Handle)`);
   2. un-erases the drafter's own line (`RestoreErasedAdoptedLine`, `CdCommand.ExistingLine.cs`, added in the PR at about line 89);
   3. writes a plain message (`UphillDecisionScheduleRule.CancelMessage`) that says only what happened, and always ends "If CD enlarged or moved a pit for this pipe, press U once to put everything back as it was."

   The carpark asks "Cancel puts everything back". This does the row and the line. It does not do the pit size or position, twin barrels or a branch-junction record. It says so, and points to U. That meets the intent without a risky partial undo. I agree with that choice.
2. **Settings switch.** `linking.cdUphillCancelPutsBackWhatItCan`, default true (tip `UserSettings.cs:909-910`). OFF: the old two lines (`EraseCreatedPipeEntities` and "Pipe cancelled and erased.") run unchanged. The handle bookkeeping (`_erasedAdoptedLineHandle`) runs either way but changes nothing on screen. Pinned the same way as #1434 (constructor default in the PR, window round-trip in the later Bj34 tests).
3. **No hard blocks (R-27).** None added. The message is on the command line.
4. **Native protection, Undo and REDO (extra care, as asked).**
   1. **Locked layer:** `RestoreErasedAdoptedLine` opens the erased line for write and calls `Erase(false)`. On a locked layer AutoCAD throws, the code catches it, logs it and reports "could not be brought back ... press U once". No unlock and no bypass. Correct.
   2. **Wrong object:** it un-erases only if the handle resolves in the current drawing AND that object is erased (`!lineId.IsErased` returns false otherwise). The handle is cleared at the top of every `ExecutePipeDrawing` (tip line 337, the fix round) and in `TryGetRouteStart`. So the draw-first route cannot restore the previous pipe's line. The fix-round source guard pins that order.
   3. **Xref and REFEDIT:** the line is a line CD itself erased in the current drawing a moment earlier, so no foreign content is involved.
   4. **One U:** each CD pipe is its own command (the comment at tip `CdCommand.cs:206-213`, "Each pipe is its own command instance ... its own one-U step"). After a Cancel, CD does not continue to the next pipe (`success == false`). So one U undoes exactly this cancelled pipe, including any pit CD enlarged. The message is true.
   5. **REDO:** a U after Cancel returns the drawing to before CD (the line is present either way, because it was erased and then un-erased inside the same command). REDO replays erase and un-erase, so the line is still present. The schedule row has no row before or after, so U and REDO cannot leave a ghost row. I found no REDO hazard. This is from reading the code only: NOT run.
   6. **PROTECTED files:** none touched.
5. **Merge.** See group facts. This PR is where #1434's LOW fix (level pipe answered No) landed. `CdCommand.Schedule.cs:150` gains `!risingMain &&`, and the new `EndsAfterAnswer` returns the row unchanged so that the discharge pit is still written.
6. **Tests.** Four added: the message wording, a source guard on the Cancel branch (it takes a fixed 1,400-character window after the first `MessageBoxResult.Cancel`, which is brittle if the block grows), the level-pipe rule, and the "clear at the top" order guard. All are code-shape or pure-rule checks. None proves the drawing. No `%APPDATA%` use.
7. **Not proven.** Not run in AutoCAD. Whether the un-erased polyline keeps its draw order (it should, as AutoCAD keeps the sort table entry for an erased object) is NOT checked. Connection review records are removed with the row, according to the fix-round log entry (item 7b). I did not read `RemovePipe` line by line.
8. **Verdict: KEEP.** Train class: none needed (shipped C-50). If re-trained: Civil area plus smoke.

### #1437: BUG-683, a same-plan break asks the real length first

1. **What changes for the drafter.** Tip `CdCommand.cs:440-453`. For a same-plan break with a route of two or more points, and units CE can trust (`!lengthHeld`), CD asks "Real total pipe length (m) <drawn>:" straight after the route. It then uses that length for the worked level (tip line 522, `CalculateInvertDrop(distanceMeters, ...)`), the grade text (`BuildGradeValue`, line 611), the pipe text (`BuildPipeText`, line 618) and the design checks (`LengthM = distanceMeters`, line 1066). The break step reuses the answer (`CdCommand.SamePlanBreak.Atomic.cs`, `completion.RealLengthM.HasValue`) and does not ask twice. Esc at the new question draws nothing. That is exactly the carpark's first option ("ask for the real length before working out the level").
2. **Settings switch.** `linking.cdSamePlanRealLengthFirst`, default true (tip `UserSettings.cs:917-918`). OFF: `AsksRealLengthFirst` is false, `RealLengthM` stays empty, and the break step asks after the break points as before. That is the old order exactly. Pinned the same way as the other two. No engineering value hard-coded. The offered default is the drawn length through `RouteLengthMillimetres`, which already uses the drawing's units. That is consistent with the BUG-296 rule in the break step.
3. **No hard blocks (R-27).** None. The new question is a command-line prompt with Enter for the drawn length, not a refusal.
4. **Native protection and REDO.** No drawing write is added. The new question comes before anything is drawn. No PROTECTED file.
5. **Merge.** See group facts 2 (built on the old #1435 head) and 4.
6. **Tests.** `SamePlanLevelLengthTests` (4): the ask-first decision, the cases that do not ask, 19.50 over 50 m against 19.80 over 20 m (plain arithmetic through `RulebookCalculations.ApplyCalculatedInverts`), and a source guard that the question comes before the auto-calc line. The fix round moved the guards to the shared `TestPaths` helper. Pure and source checks only. No `%APPDATA%` use.
7. **Not proven, and the note.**
   1. **The note (new, small, engineering-result):** after the ask-first question, the break step can still end with "the unbroken pipe was kept". That happens on Esc at the two break points (`PromptTwoBreakPoints`), on break points less than 100 mm apart, or on a cancelled label placement (`CdCommand.SamePlanBreak.Atomic.cs`, the three `return`s before `ApplyPreparedSamePlanReplacement`). The kept pipe is drawn 20 m with levels and a grade text worked over the real 50 m. On the plan it looks like 0.5 m of fall over 20 m. Before this PR, the kept pipe was self-consistent over the drawn length. **Suggested follow-up (new carpark item, Civil area plus smoke):** when the break is abandoned after ask-first, add to the message "levels and grade were worked over the real length X m; no break symbol was placed". Or re-work the levels over the drawn length. That choice is Tim's.
   2. The pipe text length now shows the real length (the regression log says "check it reads right"). Not seen.
   3. Typed (not auto-calculated) levels on a same-plan break also take their grade text from the real length. That is right in principle. Not seen.
   4. Units-held drawings keep the old order (asked after the levels). The bug remains there, but auto-calc is already held on those drawings (tip lines 476 to 492).
   5. Not run in AutoCAD. The carpark's run 36 says the robot could not reach the same-plan break tick (blocked at "More..." on the New Pipe window).
8. **Verdict: KEEP-WITH-NOTE** (the abandoned-break case in 7.1). Train class: none needed (shipped C-50). The follow-up, if built: Civil area plus smoke.

### Robot scenario (CE 02) and Codex look

1. **Uphill Yes:** a copy drawing with two pits P1 and P2. CD from P1 to P2, IL 10.00 at P1, 10.50 at P2. Uphill box: Yes. Read PITSCHEDULE: the row says From P1 10.50, To P2 10.00, matching the plan text. Also read the inlet and outlet listing for P1 and P2 (group item not proven).
2. **Uphill No:** U, then repeat and answer No. The row says From P1 10.00, To P2 10.50. The pipe text reads RISING MAIN TO P2 (unless P2 is a pump station).
3. **Uphill Cancel:** draw a plain polyline P1 to P2 on an unlocked layer. CD, Existing line, pick it, same levels. Uphill box: Cancel. The polyline is back, there is no CE pipe or label, PITSCHEDULE has no row, and the command line shows the new message. Press U once: any pit CD enlarged is back to its old size. Press REDO: the drawing is unchanged from after the Cancel (polyline present, no row).
4. **Point Order:** set Flow by pick order, CD with 10.00 then 10.50. The plan text stays as typed, the message says "labels stay where you typed them", and the row runs From P2. Open Edit Pipe on it: both levels show at the right ends.
5. **Same-plan break:** CD, tick Same-plan break, Auto-calc, upstream 20.00, 1 in 100. Pick a 20 m route, type 50 at "Real total pipe length", pick two break points. The far end reads 19.50, and nothing asks for the length twice. Repeat and press Esc at the real length question: nothing is drawn. Repeat and press Esc at the break points: record what the kept pipe and its message say (the note in #1437 item 7.1).
6. **Codex look:** only steps 3 and 5 need eyes on the drawing (the restored polyline in its old draw order, and the kept pipe after an abandoned break).

### Verdict summary

1. **#1434: KEEP.** Already shipped in C-50 (Civil 3.0.70). Close the PR.
2. **#1435: KEEP.** Already shipped in C-50. Close the PR. Undo and REDO read as safe; NOT run.
3. **#1437: KEEP-WITH-NOTE.** Already shipped in C-50. Close the PR. Carpark a follow-up for the abandoned-break message (#1437 item 7.1).
