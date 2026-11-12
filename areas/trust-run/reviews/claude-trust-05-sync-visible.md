# Review: draft PR 2045, `claude/trust-05-sync-visible` (step 5, the record update made visible, card TRUST-05)

**Reviewer:** lane trust-review (fourth run), Fri 13 Nov 2026, 00:00 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** the step-5 change only, `git diff 00c3baf5 696af42f` (head of PR 2045; step 1 is underneath at `00c3baf5`, the installed `cf059dcf` under that), the full new test file, the methods it changes and the callers named below, card `04_REFERENCE\ux-plan\cards\TRUST-05_SYNC_MADE_VISIBLE_CARD_DRAFT_2026-11-12.md`, my card review `reviews\card-TRUST-05.md`, `CODE_FACTS_13NOV.md`, and the step-5 rows in `PENDING_TESTS.md`. Line numbers are at `696af42f`.

---

# FOR TIM

1. **CDGRAPH, CDDIAG and the dashboard now leave the drawing and CE's record alone.** That half is built carefully and proven as far as code can prove it.
2. **The new line "CE updated its record: ..." is sometimes wrong.** It can say a pipe material or lid was guessed when CE had put your own value back, say a pipe is "joined to a different pit" when it is now joined to nothing, and leave out pipe joins the Pit Schedule just changed.
3. **A wrong count on that line is a "wrong value shown as fact", one of your four stop faults,** so the counting must be fixed before the robot runs it on copies.

**Verdict: FIX FIRST** (seven items). Built yes. Tested unit only (by its lane: whole Civil test project, Release, 22,264 ran, 22,232 passed, 32 skipped, 0 failed at `696af42f`; not re-run here). Installed no. Accepted no.

---

## 1. Checked and sound

1. **One door for the tools that only read.** CDGRAPH (`Commands/LinkCommands.cs` 470), CDDIAG (`DiagnosticsCommand.cs`), its window's Refresh (`ViewModels/DiagnosticsViewModel.cs` 72), CDDASHBOARD (`DashboardCommands.cs` 32) and CDRECOVERINVERTS (`LinkCommands.cs` 2227) all go through `PrepareRecordForReadOnlyTool` (`Services/ProjectDataService.ReadOnlyTools.cs` 42).
2. **The save on the way in is gone.** With the switch on, the door binds with `BindToDrawingForRightClick` (`ProjectDataService.Mutations.cs` 252), which never saves the previous drawing's record and never saves this one. The two immediate saves that `SetDrawingPath` made (Mutations.cs 182 and 185) and CDGRAPH's "mark as Civil" are no longer reached. Then it runs step 1's read-only check (`CurrentDrawingCheckService.ReadForOpenLine`).
3. **Switch off really is today's behaviour.** I compared each tool's old calls at `cf059dcf` with `RunLegacyUpdateForReadOnlyTool` (ReadOnlyTools.cs 80 to 102): CDGRAPH mark + attach + full update; health routine full update; CDDIAG, its Refresh and CDDASHBOARD attach + update-if-changed; CDRECOVERINVERTS attach + full update. Identical, call for call.
4. **The counting design is the right one.** The record is pictured before and after the update (`ProjectDataService.cs` 630 and 725) and compared row by row, paired by drawing object, with a pit that kept its number on a new symbol counted as "matched again" (`Rules/RecordUpdateSummaryRule.cs` 86 to 123). Any other changed value of a pit or pipe still shows as "other details updated", so pit and pipe changes cannot pass silently.
5. **Silent when nothing changed.** No picture is taken when the update is skipped as already current (ProjectDataService.cs 620 to 624), and `Line` returns nothing when no row changed, even if a guess was counted (RecordUpdateSummaryRule.cs 170).
6. **The new line never promises Undo,** and a test bans "undo", "sync", "handle" and other software words from it.
7. **Held updates are handled right.** For CDRUNSOLVE and CDPROPAGATE the line waits for Yes and is dropped on Cancel (`ProjectDataService.RecordWriteHold.cs` 82 and 104), matching the record being put back.
8. **The compiled-plugin walk** from CDGRAPH, CDDIAG, CDDASHBOARD and the health routine, switch on, reaches no drawing write, and a broken copy that calls the update again is caught. The start-of-command check is left out of the walk on purpose (it may ask "is this a Civil drawing?"); the lane lists that.
9. **CE Health claim checked.** Civil's `RunHealthCheck` has no command; Manager's CEHEALTH (`Modules/Manager/Commands/PluginManagerCommands.cs` 213) never calls Civil's record update.
10. **Step 1 is not disturbed.** No step-1 file is changed by step 5. The pipe conversion and pit symbol update on opening do not call the record update, so they add no new line at opening (but see section 3, item 2, for the Inspector).
11. **The first pushed head `f23b9530` broke an existing pin** (`Rules/RecoveredPipeSizeWiringTests.cs` 28, the BUG-698 size order). `696af42f`, now on the PR, puts that call back exactly as it was and works the guess out after it. Correct.

## 2. FIX FIRST

1. **Guesses said that are not in the record.**
   1. The guess counts are added where a pit or pipe row is first built (`ProjectDataService.Recovery.cs` 116, 117, 166, 167): every rebuilt pipe counts "material guessed" and every rebuilt pit "lid guessed".
   2. Straight after, the same update puts the drafter's own values back from the picture it took first (`ProjectDataService.cs` 685 to 687; pits Recovery.cs 837 onward, lid, levels, remarks; pipes 965 onward, size, material, levels). The guess count is never taken back.
   3. Example: erase pit P3 by mistake and press U, or redraw it. CE drops P3's two pipes from its record (`RemovePipesForPitId`, ProjectDataService.cs 340), finds them again on the pipe layer, rebuilds them with UPVC, then restores their real material. The line still ends "Guessed, not read from the drawing: 2 pipe materials, 1 lid class."
   4. Fix: count guesses from the record after the update (a row whose final value is still the made-up one), not where rows are built. Add a unit case that runs the real sequence: build, restore, count.
2. **Words that say the opposite of what happened.**
   1. "Cover level read from the drawing" is counted for any change of a pit's cover level (RecordUpdateSummaryRule.cs 128), including a cover level wiped blank. The read-back sets blank when the pit's attached text has no "CL " line (`ProjectDataService.cs` 994 with 1236 to 1245, and 1217 to 1226).
   2. "Pipe joined to a different pit" is counted for any change of a pipe's ends (RecordUpdateSummaryRule.cs 117), including an end emptied (`UpdatePipeEndpointsByHandle`, Mutations.cs 1479 to 1488 writes a blank) and a first join. "Pit invert level changed" also covers an invert wiped.
   3. Example: erase a pit. By my reading the line would say "1 pit removed, 2 pipes joined to different pits", but those two pipes now join no pit. `PENDING_TESTS.md` step 5 case 5 expects "1 pit removed and its pipes removed"; the update re-adds the pipes in the same run because their lines are still drawn, so the robot would see neither.
   4. Fix: separate "filled in", "changed" and "cleared" for cover levels, pit inverts and pipe levels, and "joined", "joined to a different pit" and "no longer joined" for pipe ends. Then settle case 5's expected line from the code.
3. **Pipe joins changed just outside the counted window are missed.**
   1. `LinkService.UpdatePipeEndpointsFromProjectData` writes pipes' From and To into the record (`LinkService.RepairAudit.Linking.cs` 83 onward, through Mutations.cs 1468).
   2. It runs outside the counted update in four places: the Pit Schedule relink, just before the update (`ViewModels/PitScheduleViewModel.Data.cs` 996 to 999); the schedule's "Restore hidden schedule links", with no update at all (2939 to 2940); CDSYNC, just after the update (`LinkCommands.cs` 189 to 190); and the X-Civil import.
   3. The card names the Pit Schedule relink as a window that must show the line (section 1, item 5). There the line printed a moment later leaves out every pipe the relink re-joined: a short count presented as the whole story.
   4. Fix: count across the whole relink-then-update sequence in those callers, one line for the lot.
4. **Only pits and pipes are compared.**
   1. The update also drops a pit's chosen outlet pipe when its pit or pipe object is gone (`ProjectDataService.cs` 343 to 357 and 367 to 391) and restores or marks orphaned the hand-made schedule rows (Recovery.cs 620 to 671). Both change and save the record.
   2. Neither is in the before and after picture, so when one of them is the only change the line is silent. A drafter's outlet choice disappearing without a word is "CE changing its record without telling".
   3. Fix: add both lists to the picture, with their own words (for example "1 pit's outlet choice removed, its pipe is gone").
5. **Stand-in pit numbers from the internal code are not counted as guesses.** A pit with a blank number is given the drawing's internal code as its number (`NormalizeProjectData`, Mutations.cs 2006). Inside the update that shows only as "pit with other details updated"; when it happens as the record is loaded it shows nothing at all, and the next save writes it. My card review (finding 1) named this exact line. Count it with the other guesses.
6. **The Pit Schedule's own write-back is "not covered" instead of a default.** The REGRESSION_LOG entry (item 13a) and the PR say opening the Pit Schedule writes a drawn pipe size into the record and gets no line. The step's promise is "when any tool updates the record, one line says so", so either count it (one picture before and after the write-back is enough) or move it into the defaults list, worded for Tim, and into the card.
7. **Two owed saves can still land at the end of a read-only tool.**
   1. A record CE kept for this drawing from an earlier switch away (Mutations.cs 199 to 202), and an old per-PC record being moved into the drawing for the first time (`ProjectDataService.Persistence.cs` 268 to 273), are both marked to save and written by the command-end hook (`LinkService.Reactors.cs` 2047 onward) when the read-only command ends.
   2. The second is started by the read-only tool's own bind: on an old job whose record only lives on this PC, running CDGRAPH first writes that record into the drawing and AutoCAD will then ask "save changes?" on close. The compiled-plugin walk cannot see a write made from the command-end hook.
   3. Fix: in the read-only bind, leave the per-PC record unmarked (read it, do not schedule the move), or list it as a default for Tim. Either way, robot case 1 must take its "before" reading after one ordinary command, so an owed save from earlier work does not fail the case for a reason outside the tool.

## 3. Worth knowing (not blocking)

1. **CDSYNC and CDREBUILD still say "One U undoes it."** (`LinkCommands.cs` 125 and 222). The card itself calls that promise unproven (section 2, item 3) but also says CDSYNC and CDREBUILD are not changed. They will now print it right beside the new line. Controller to settle: drop the four words until probe P2, or record it as a default.
2. **The Inspector runs the update when a drawing opens with the Inspector shown** (its first look at a drawing, `InspectorPaletteService.cs` 565 to 567). That was a silent write on opening before this step; now it prints "CE updated its record: ..." (no tool name) next to step 1's opening line, and the two can disagree ("needs checking, 2 lines not in the CE record", then "2 pipes added"). True and useful, but step 1 and step 5 robot cases should each be run with the Inspector shown and hidden. It also bears on Tim's decision B5 (nothing changes on open).
3. **Speed not measured.** Every full update now turns every pit and pipe into text twice to compare them, even with the line switched off. Time it on the largest test job in probe P1.
4. **An update that fails part-way prints nothing.** The line is said only at the very end (ProjectDataService.cs 725), not in a "finally", so a record partly changed before an error gets no line. Rare.
5. **The unit "broken twin" for the count is made by hand** (a summary set to 2), so it proves the check, not the counter. The real proof is robot case 7 on a copy.
6. **A redrawn pipe reads "1 pipe removed, 1 pipe added",** not "re-attached". That is true of the record (the old object is gone) and it correctly shows the new pipe's guessed size.
7. **Card review findings 5 and 6** (when a line prints; older builds keep updating silently): finding 5 is taken as default (h), listed. Finding 6 is not mentioned in the change log; it belongs in the card.

## 4. Not checked

1. Did not build or run tests; the counts above are the lane's.
2. Nothing opened in AutoCAD: the record unchanged after each read-only tool, the changed counter, the moment and place each line appears, the U behaviour (probe P2), AutoCAD 2022 to 2024.
3. Items 1 to 3 of section 2 are code reading; a unit case on the real sequence, or the robot, would confirm each.
4. The dashboard's own buttons and the CDDIAG window beyond Refresh (the lane also did not trace them).
5. CDRECOVERINVERTS on a record that still lists erased pipes (it now skips the update that used to remove them): read only as far as its "not found in the drawing, skipped" check (`LinkCommands.cs` 2268).
