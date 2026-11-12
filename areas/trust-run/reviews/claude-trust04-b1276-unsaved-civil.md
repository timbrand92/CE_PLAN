# Review: draft PR 2042, `claude/trust04-b1276-unsaved-civil` (BUG-1276 Civil, card TRUST-04 Civil item 1)

**Reviewer:** lane trust-review (fourth run), Fri 13 Nov 2026, 00:00 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff cf059dcf...origin/claude/trust04-b1276-unsaved-civil` at head `c8044744` (one commit, 8 files), PR 2042's description, my earlier review `reviews\claude-b1276-unsaved-civil.md`, Tim's decision 223 (`decisions\2026-10-29_TIM_ANSWERS.md`), card TRUST-04 as it stands now. I compared the lifted code with the original B-220 branch (`git diff 7cc4d306...origin/claude/b1276-unsaved-civil`), file by file: identical.

---

# FOR TIM

1. **It now sits on the Civil build you have installed, and the real job's number and street are gone from it.** It never saves your drawing and writes nothing beside it.
2. **The two on-screen faults from the last review are still there.** A line "CE: backup copy not made (non-DWG drawing)" can appear after a save even with the new reminder and copies switched off, in software words; and when AutoCAD's own automatic save is off, CE keeps no copies and says nothing on screen.
3. **The second one is the 4 November situation again:** no automatic-save files, so no copies, and nobody told.

**Verdict: FIX FIRST** (two items, both from the last review). Built yes. Tested unit only (by its lane: 22,249 ran, 22,215 passed, 32 skipped, 2 failed; the lane checked both failures also fail on `cf059dcf` unchanged; not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items, one by one

1. **Lift onto the installed build: FIXED.** The branch is one commit on `cf059dcf` (PR base `claude/rel-20261108a` = `cf059dcf`). The four B-220 commits are squashed into it, and the code matches B-220 line for line (my file-by-file comparison of the two changes: no difference).
2. **Real job number and street in the tests: FIXED in this branch.** The sample drawing is now "SampleJob" in "99-001". I searched this branch's whole change and its commit message for the old job number and street name: no hit. The old branch #2035 still carries them (the lane reported it; RULES 11.3 is the controller's call).
3. **The "backup copy not made" line ignores the switches and uses software words: NOT FIXED.**
   1. `Services/DrawingBackupService.cs` 322 prints "CE: backup copy not made (reason)." whenever CE's existing after-save copy is skipped. It checks neither new switch, so with the reminder and copies both off a drafter still gets a line that was never there before. The PR and change log say both switches off gives today's behaviour; this line breaks that.
   2. The reasons come straight from `DrawingSafetyService.cs` (at `cf059dcf`, 142 to 247): "document disposed", "database inaccessible", "database missing", ".sv$ autosave drawing", "non-DWG drawing", "drawing path unavailable".
   3. Fix: print it only when the reminder or the copies are switched on (as Structural does), and put each reason in drafting words, for example "this is AutoCAD's automatic-save copy of a drawing, not the drawing itself" or "this drawing is a template".
4. **CE never says on screen when it cannot keep copies: NOT FIXED.**
   1. When AutoCAD's automatic save is off ("SAVETIME 0", `Services/UnsavedWorkPlanner.cs` 197) or no automatic-save file ever appears, the copy is skipped and only written to the CE log (`DrawingBackupService.cs` 634, `LogSkipOnChange` 705 to 712) and to the status-bar tooltip. The PR says so itself: "Skipped (one log line)".
   2. BUG-1276 records that no automatic-save files existed on 4 Nov. In those conditions this fix would keep no copies and the drafter would believe it was.
   3. Fix: one plain line per session when copies cannot be kept, for example "CE cannot keep copies of unsaved work: AutoCAD's automatic save is off (OPTIONS, Open and Save tab, Automatic save)." The reminder still runs, so the drafter is still told to save.

## 2. What the brief asked me to confirm

1. **Plain words only:** the reminder line "CE: not saved for 25 min. CE never saves; type QSAVE to save." and the status text "Not saved for 25 min" are plain. The skipped-backup line is not (item 1.3).
2. **Silent when switched off:** with both new switches off there is no timer, no read of the changed flag or the automatic save time, and the status text and tooltip are as before (`DrawingBackupService.cs` 369, 436, 820). One exception: the line at 322 (item 1.3).
3. **Says on screen when it cannot keep copies:** no (item 1.4).
4. **No real job number, street or suburb in tests or change log:** confirmed for this branch's change, its tests, its REGRESSION_LOG entry and its commit message.
5. **CE never saves the drawing:** confirmed. The change contains no save, save-as, Wblock, document lock or transaction; a source-text test fails the build if the service ever does (`UnsavedWorkPlannerTests.cs`, `TheService_NeverSavesWblocksLocksOrStartsATransaction_AndWritesOneSystemVariable`). The one AutoCAD option it can change (the automatic save time) is behind `matchAutoCadSaveTime`, which ships off, and waits while a Redo is open.
6. **Nothing written beside or over the drawing:** confirmed. Copies go to the CE settings folder, `AutoSaveBackups\CE_CVL_SUITE\<drawing name>_<code>` (`DrawingBackupService.cs` 865 to 874), written first under a temporary name in that same folder and then renamed. AutoCAD's own automatic-save file is only read. Note: the existing Settings value `backupRoot` (empty by default) moves that folder wherever an office points it.

## 3. Worth knowing (not blocking)

1. **Card TRUST-04 is only half corrected.** Decision 3 now records Tim's decision 223, but robot case 4 (card line 59) still expects "no file written". It should expect one copy in the backup folder per interval and nothing written to the drawing.
2. **The PR calls the lift "code identical to the reviewed branch"** without saying that review was FIX FIRST and two of its code items are still open. True, but it reads as if the review were cleared (RULES 6.2).
3. **Still open from the last review, not blocking a trial on Tim's PC:** copies land in the Civil or the Structural folder depending on which suite started first (item 6); twelve copies of a large automatic-save file per drawing is about 1 GB, not measured (item 9); the background copy writes its results without the lock (item 7, tidy only).
4. **The lane found a small risk of its own:** a second AutoCAD session with a drawing of the same file name writes its automatic-save file to the same folder, and CE cannot tell the two apart. Reasonable to note and leave.

## 4. Not checked

1. Did not build or run tests; the counts are the lane's.
2. Nothing seen in AutoCAD: the automatic-save file name and folder on 2027, whether AutoCAD's automatic save leaves the changed flag alone, the status text as drawn, the copy time.
3. Why Tim's PC had no automatic-save files on 4 Nov (still unexplained).
4. AutoCAD 2022 to 2024.
