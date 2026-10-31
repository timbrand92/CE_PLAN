# Wave 1 case writing, job E4 (group E: design flow only, batch Design grade, CD Uphill box Cancel)

Written by an Opus case writer on Team, Sat 31 Oct 2026 about 14:35 PC clock. Brief: `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Installed build read: Civil 3.0.88+3fbb9da5 (code read with `git show 3fbb9da5:...` from `C:\Lisp Files\CE_ACAD_PLUGIN`). Nothing was run in AutoCAD; no existing file was edited; nothing committed.

## Answer first

1. **Cases written: 0 of 4.** None of my four bugs can be proved by the robot today, so I wrote no case and no twin.
2. **BUG-687 (Edit Pipe, change only Q, Save): blocked by one unknown box name.** The Q (design flow) box has never been seen by the robot, so its name "C2.FlowLps" fails the known-id check. One probe run fixes it, then the case is ready to write (sketch in item 1 below).
3. **BUG-688 and BUG-689 (batch Design grade): blocked by the driver.** The batch window "Creative Engineering | Edit 2 Pipes" and its "Apply to Selected" button are on no robot press list (v2 has only "*Edit Pipe*"; v3 refuses the word Apply). There is no typed route. Codex look, or a driver allow-list change by its owner.
4. **BUG-682 (CD, Cancel in the Uphill box): blocked by the driver, and only reachable with a setting off.** The box "Uphill Pipe Warning" is not on the v2 message-box list (the only entry is "Recalculate downstream inverts"), and it only opens when Settings "draw the route first" (CdDrawFirst) is off. Codex look, or a driver allow-list change.
5. **Folder checks are clean:** validate 32 files, 0 invalid; check_ids "every control id is known". None of the 32 are mine.
6. **Two things Tim or Codex should know before calling these FIXED.** BUG-682's fix does NOT put back an enlarged or moved pit: it removes the schedule row, brings the drafter's line back and tells the drafter to press U once. BUG-689's warning names the re-graded pipe leaving the pit, not P1->P2 as the bug entry expected, and it only appears when a pit drop is set.
7. **Next step I recommend:** one probe run (ui-dump of Edit Pipe on DRV1_B1 pipe 10A98D) to learn the Q box name, then I or the next writer writes W687 and W687_BROKEN in about 20 minutes.
8. **What is NOT tested:** everything in this report is read from code. Nothing here was seen in AutoCAD.

## Per bug

1. **BUG-687, Edit Pipe: change only the design flow (Q), Save.**
   1. **Case and twin:** none written. Planned ids W687_edit_pipe_q_only_saves and W687_BROKEN.
   2. **Why not written:** the Q box has no name of its own in the window markup (`Dialogs/CdDialog.xaml:536-538` and `Dialogs/PipeEditWorkshopDialog.xaml:175`, a TextBox bound to FlowLps). CE gives it the id "C2." plus the binding name (`Dialogs/WorkshopEditorFocus.cs:75`), so it should read "C2.FlowLps", but that id is in no UI map, no probe report and no past step (`check_ids.ps1` would report it unknown). The robot's Edit Pipe map (`_ACAD_DRIVER\ui_map\w2_edit_pipe.txt`) does not show a Q box at all, so it may also sit in a part of the window that is hidden until "Set my own" grade or the Levels and Flow tab is shown. Unknown: I have not verified where it shows.
   3. **What the case would do (drafter's words):** on DRV1_B1 select pipe P3 (10A98D), type CDEDIT, answer Y, type 25 in the Q box only, press Save. Then CDEDIT on the same pipe again and read the Q box: it must say 25. Twin: type the same Q as already saved (so nothing changed); "No changes detected - pipe unchanged." must then appear and the check fails.
   4. **Words the case would check, from code at 3fbb9da5:** the old failure line "No changes detected - pipe unchanged." (`Commands/PipeEditCommand.cs:220`) must NOT appear; the fix is `DesignFlowChanged` (`Commands/PipeEditCommand.cs:313-320`, called at :434), a change counts when it differs by more than 0.005 L/s; the Q is written at `Commands/PipeEditCommand.Update.cs:1865-1866` and shown again on open at `Update.cs:32-33` with format "0.##" (25 reads "25").
   5. **Derived, never seen:** whether the Save of a Q-only change also passes the Grade mismatch window (it should, as the levels are untouched).
   6. **Arithmetic:** none (no levels change).
   7. **What a Codex look must see if the robot cannot:** select one pipe, CDEDIT, change only Q, Save: no "No changes detected" line; reopen Edit Pipe: Q shows the new value.
   8. **What unblocks it:** a probe run that does `ui-dump "Edit Pipe"` with the window on the Levels and Flow tab or with "Set my own" grade on, so the Q box id lands in a runner report.

2. **BUG-688, batch Design grade, a held end whose level text is switched off.**
   1. **Case and twin:** none written.
   2. **Why not:** the batch editor's title is "Creative Engineering | " plus "Edit N Pipes" (`Dialogs/BatchEditWorkshopDialog.xaml.cs:44`, `ViewModels/Shell/CeBatchEditViewModel.cs:73, 93`), and its button is "Apply to Selected" (`Dialogs/BatchEditWorkshopDialog.xaml:388`). The v2 press list (`acad_driver_witness_v2.allowlist.json`) has "*Edit Pipe*", which does not match "Edit 2 Pipes"; the v3 list never presses "Apply". The batch Design grade has no typed (command-line) route (no keyword prompt in `PipeEditCommand.Batch*.cs`). Matches the 30 Oct finding "Edit 2 Pipes not pressable".
   3. **The fix, from code:** `Commands/PipeEditCommand.Batch.cs:1534-1548`: when the held end's level text is switched off, CE marks it Hidden (present but not drawn), so Apply no longer refuses with "Working the downstream invert out automatically needs an Upstream value." (`Commands/PipeEditCommand.Update.cs:235`) and the batch is not rolled back.
   4. **What a Codex look must see:** two pipes with known downstream levels; on one, switch its upstream IL text off in Edit Pipe and Save. Select both, open the batch editor, Design grade 1 in 100, Apply to Selected. Right: both pipes get their new levels, no "needs an Upstream value" line, and no new IL text appears at the end that was switched off.

3. **BUG-689, batch Design grade that works out an upstream level: a pipe outside the batch arrives lower.**
   1. **Case and twin:** none written. Same driver block as BUG-688.
   2. **The fix, from code:** `BuildOutsideArrivalClashWarnings` (`Commands/PipeEditCommand.Batch.Cascade.cs:665-692`), added at :705-709. It only runs when a pit drop is set (`:696-697`, `HasPitDrop` from `:727`). The words come from `BuildNextPipeClashWarning` (`:145-160`): "    Warning — <pit>: <re-graded pipe> starts <n> mm above the new pit outlet — it would need lowering." The command-line copy starts "[CE] " and writes the arrow as "->" (`:167-168`).
   3. **Arithmetic (the bug's own example):** P2->P3 holds its downstream 9.00; 1 in 100 over 30 m is a 0.30 m fall, so upstream 9.00 + 0.30 = 9.30. P1->P2 arrives at P2 at 9.20. With a pit drop of d mm the required outlet is 9.20 - d/1000, so the warning reads 100 + d mm (100 mm with a drop of 0; 120 mm with a drop of 20). I have not read which pit-drop value the robot's settings hold.
   4. **Difference from the bug entry, for Tim:** the entry expects the warning to name P1->P2. The code names the pipe leaving the pit (P2->P3) and the pit (P2), not the arriving pipe. Whether that meets "the usual back-fall warning" is Tim's word (wording), not mine.
   5. **What a Codex look must see:** the set-up above with a pit drop set; select only P2->P3; batch Design grade 1 in 100; the preview and the command line show the warning for P2 with the figure above; Apply still works (a warning, never a block).

4. **BUG-682, CD: Cancel in the Uphill box.**
   1. **Case and twin:** none written.
   2. **Why not (two blocks):**
      1. **The box only opens with "draw the route first" off.** The box is skipped when CD has draw-first authority (`Commands/CdCommand.cs:356, 853`); the robot's usual CD (points typed first, then New Pipe) takes the draw-first route and asks a command-line question instead (case R31). The switch is Settings `CdDrawFirst` (`Models/UserSettings.cs:1999`, class OptionSettings at :1728). A SETTING line could turn it off, but see the next point.
      2. **The robot may not answer this box.** It is a plain Windows message box titled "Uphill Pipe Warning" with Yes, No and Cancel (`Commands/CdCommand.cs:876-884`). `msgbox-answer` answers only boxes in the allow-list section message_boxes, which holds one entry, "CE ? Recalculate downstream inverts?" (`acad_driver_witness_v2.allowlist.json:118-120`). Adding an entry is the driver owner's job, not a writer's.
   3. **The fix, from code:** `Commands/CdCommand.cs:886-900`, switch `CdUphillCancelPutsBackWhatItCan` (default on, `Models/UserSettings.cs:910`, Linking section). Cancel erases the pipe items, removes the schedule row (`ProjectDataService.RemovePipe`), brings back the drafter's own line, and prints "[CE] " plus `CancelMessage` (`Rules/UphillDecisionScheduleRule.cs:23-31`): "Pipe cancelled: the pipe, its labels and its Pit Schedule row were removed." then, when a line was adopted, " Your own line is back." (or the could-not line), then " If CD enlarged or moved a pit for this pipe, press U once to put everything back as it was." The switch-off (old) line is "[CE] Pipe cancelled and erased." (`:899`), which is what a twin would assert against.
   4. **What the fix does NOT do (for Tim):** an enlarged or moved pit is not put back by Cancel; CE tells the drafter to press U. Twin barrels: not checked in this read (`EraseCreatedPipeEntities` not read). So a pass would prove the schedule row, the line and the words, not "Cancel puts everything back" as the entry's expected line says.
   5. **What a Codex look must see:** Settings: "draw the route first" off. Draw a plain polyline between two pits, CD on it as an existing line, type upstream 10.00, downstream 10.50, Uphill box, Cancel. Right: the full "[CE] Pipe cancelled: ..." line, the polyline is back, no new Pit Schedule row, no pipe items left. Put the setting back after.
   6. **What unblocks a robot case:** an allow-list entry for title "Uphill Pipe Warning", buttons Yes, No, Cancel, answers Cancel only, text like "*flows uphill or is level*" (words from `CdCommand.cs:877-878`), plus a SETTING line for CdDrawFirst false.

## Could not write, and faults noticed

1. **Could not write:** all four, for the reasons above (one unknown box name, two driver press lists).
2. **Fault noticed (name only, nothing edited):** `C:\CE_PLAN\areas\BUG_PROOF_LANES_31OCT.md` item 141 points BUG-682 at case R31. R31 never reaches the Uphill box (it uses the draw-first command-line question), as R31's own REVIEWED_AGAINST line and the Codex review cx_cr17 already say. R31 should not be counted toward BUG-682.
3. **Fault noticed:** the BUG-682 carpark entry still quotes "Pipe cancelled and erased" as the symptom; with the fix on, the line is now the longer "Pipe cancelled: ..." sentence. Any future case must assert the new words, not the old.
4. **Fault noticed:** none in existing cases or set-ups that I read (R31, R11v87, R11_BROKENv87).
