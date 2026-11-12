# Re-review: draft PR 2045, `claude/trust-05-sync-visible` (step 5, the record update made visible, card TRUST-05)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:59 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** the review-fix commit only, `git diff e220ece0 faa4d7d5` (8 files; `e220ece0` is the merge of step 1's fixes into this branch), the whole of `Rules/RecordUpdateSummaryRule.cs` at the head, the counting code in `Services/ProjectDataService.ReadOnlyTools.cs`, the update method in `Services/ProjectDataService.cs` (602-724), the new tests in `RecordUpdateSummaryTests.cs`, my earlier review `reviews\claude-trust-05-sync-visible.md`, and the record model at `C:\CE_WORK\scratch\audit_civil` (cf059dcf). Line numbers are at `faa4d7d5`.

---

# FOR TIM

1. **The count on the line "CE updated its record: ..." now comes from CE's record compared before and after,** including whether a guessed value is really still there at the end. A value CE put back from your own drawing is no longer called a guess.
2. **The words now match what happened:** "no longer joined" for a pipe that lost its pit, "cleared" for a level wiped, and pipe joins made by the Pit Schedule and CDSYNC are in the same line.
3. **Two things are left for you as defaults, plainly worded:** opening the Pit Schedule still writes a pipe size with no line, and a save CE already owed a drawing can still land after a read-only tool.

**Verdict: GO** for the robot on copies. Not a merge or install decision. Built yes (lane: net48 and net10). Tested unit only (lane: whole Civil test project, Release, 22,277 ran, 22,245 passed, 32 skipped, 0 failed; not re-run here). Installed no. Accepted no.

---

## 1. The brief's question: does the new count compare CE's stored data before and after? YES.

1. One picture of CE's record (pits, pipes, each pit's chosen outlet pipe, the hand-made schedule rows) is taken when a count begins (`CountRecordChanges`, `ProjectDataService.ReadOnlyTools.cs` 117) and another when it ends (`ReportRecordUpdate`, 170). The line's numbers are the difference between the two (`RecordUpdateSummaryRule.Diff`). Two pictures of different drawings are never compared (183).
2. The pictures are of the record CE holds in memory, which is what CE writes into the drawing. They are not read back from the saved drawing.
3. **Guesses are now decided from the record at the end** (`CountGuesses`, `RecordUpdateSummaryRule.cs` 244-269, called at `ReadOnlyTools.cs` 197). Where the update makes a value up it only notes the row and the value (`ProjectDataService.Recovery.cs` 130-131, 170-171). At the end a noted value counts only if that row still holds exactly it and did not hold it before (`StillThere`, 271-288). So my earlier example (erase a pit, press U, the pipes rebuilt with UPVC and then given back their real material) no longer says "2 pipe materials guessed".
4. **Real changes are no longer missed in the places named:** the Pit Schedule relink (`PitScheduleViewModel.Data.cs` 998), its "Restore hidden schedule links" (2944) and CDSYNC (`LinkCommands.cs` 190) each open one count around the re-join and the update together; a count opened inside another adds to it. A count also reports if the update ends by an error part-way (the update's own count is a `using` at `ProjectDataService.cs` 631).

## 2. The last review's FIX FIRST items

1. **Guesses that are not in the record: FIXED** (1.3 above).
2. **Words that say the opposite: FIXED.** Each value is now "filled", "changed" or "cleared", and each pipe end "joined", "joined to something different" or "no longer joined" (`CountValue`, 203-213; words 318-329). A pipe end stored as "-" counts as no owner (`Owner`, 366-370).
3. **Pipe joins changed just outside the update: FIXED** for the Pit Schedule relink, its restore and CDSYNC (1.4). The X-Civil import's own re-join is not covered and is listed (change log item 13 (a)).
4. **Only pits and pipes compared: FIXED.** A pit's chosen outlet pipe removed or added, and hand-made schedule rows losing, finding, put back or removed, are in the picture with their own words (`Diff`, 169-188).
5. **Stand-in pit numbers: FIXED** inside a count: a pit whose number ends up equal to its own drawing code, and was not before, is a guess (`CountGuesses`, 259-267; the code is the block's handle, as `NormalizeProjectData` sets it at cf059dcf `ProjectDataService.Mutations.cs` 2005-2006). When it happens as the record is loaded there is still no line; listed (13 (d)).
6. **The Pit Schedule's own write-back: TAKEN AS A DEFAULT for Tim** (change log item 12 (i)), worded plainly. Allowed by the last review.
7. **Owed saves after a read-only tool: TAKEN AS A DEFAULT for Tim** (12 (j)), with the robot instruction to take its "before" reading after one ordinary command. Allowed by the last review.

## 3. Worth knowing (not blocking)

1. **The "real sequence" test acts the sequence out by hand** (`TheRealSequence_Build_Restore_Count_AValuePutBackIsNotCalledAGuess`): it edits a record to look like the update's steps rather than running CE's update. It proves the counting rule, not that the update notes each value where the test assumes. A source pin checks the four noting calls are in place (`TheUpdate_NotesEachMadeUpValueWithTheRowItWentOn`). Robot case 7 on a copy is the real proof.
2. **One over-count is still possible:** a pipe whose drawing object was replaced (so it comes back with a new code) and whose real material happens to equal the made-up one would be called a guess, because there is no "before" row with that code to compare. Rare, and it errs towards saying too much.
3. **Pit lid and pipe size or material changes** still show only as "pit (or pipe) with other details updated". Not silent, but vague.
4. **CDSYNC and CDREBUILD still print "One U undoes it."** (`LinkCommands.cs` 125 and 226), now beside the new line that deliberately makes no such promise. Left for the controller, as the lane says.
5. **Step 1 and step 5 read a "-" pipe end differently** (step 1's check: linked; step 5: no owner). See the step 1 re-review.
6. **Speed not measured:** every count turns every pit and pipe into text twice, and counts now also run around CDSYNC and the Pit Schedule relink. Time it on the largest test job.

## 4. Not checked

1. Did not build or run tests; the counts are the lane's.
2. Nothing opened in AutoCAD: the line after Edit Pit, PIT, a moved cover text, the Pit Schedule and CDSYNC; what one U does after an update; the record unchanged after each read-only tool.
3. Record lists outside the picture (slabs, raingardens, spoon drains, downpipe destinations, review approvals): I checked the update method replaces only the slab list (`ProjectDataService.cs` 708-711, read from the drawing's own store); I did not trace every other caller that changes those lists.
4. AutoCAD 2022 to 2024 (compiles per the lane; not run).
