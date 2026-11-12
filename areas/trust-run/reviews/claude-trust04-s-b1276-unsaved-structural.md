# Review: draft PR 2048, `claude/trust04-s-b1276-unsaved-structural` (BUG-1276 Structural half, card TRUST-04, Tim's decision 223)

**Reviewer:** lane trust-review (sixth run), Fri 13 Nov 2026, 01:25 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** PR 2048's description; `git diff 8de95c34...origin/claude/trust04-s-b1276-unsaved-structural` at head `2b5f9004` (one commit, 11 files; PR base `claude/trust04-base-struc-1.0.126` = `8de95c34`, installed Structural 1.0.126, confirmed). Checked against my earlier review `reviews\claude-b1276-unsaved-structural.md` (of the original branch, PR 2034), the Civil re-review `reviews\claude-trust04-b1276-unsaved-civil.md`, Tim's decision 223 in `decisions\2026-10-29_TIM_ANSWERS.md` ("c" = the reminder and timed copies) and `PENDING_TESTS.md` section "TRUST-04 core safety fixes", row 5.

---

# FOR TIM

1. **It now sits on the Structural build you have installed, and the real job's number and street are gone from it.** It never saves your drawing and writes nothing beside it; copies go only to CE's backup folder.
2. **The two on-screen faults from the last review are still there:** when AutoCAD's own automatic save is off, CE keeps no copies and says nothing on screen; and the "backup copy not made" line still gives its reason in software words.
3. **The first is the 4 November situation again:** no automatic-save files, so no copies, and nobody told.

**Verdict: FIX FIRST** (three small items in section 2, two of them from the last review). Built yes (by its lane). Tested: unit tests only, by its lane (437 of 437 with the filter `UnsavedWork|AutoSave|CleanSaves|Settings`; wiring-guard twin 1 of 47 failed as it should); not re-run here. Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Plain words only:** the reminder line "CE: not saved for 25 min. CE never saves; type QSAVE to save." (`Services\UnsavedWorkPlanner.cs` 113-114) and the status text "Not saved for 25 min" are plain. The "backup copy not made (reason)" line is not (section 2, item 2).
2. **Silent when switched off:** YES. With both new switches off, start-up returns before any timer, read or write (`Services\DrawingAutoSaveService.UnsavedWork.cs` 28-31); the status text, tooltip line and status-bar suffix return nothing without the timer (560-605); the "backup copy not made" line is printed only while the reminder switch is on (491-505).
3. **Says on screen when it cannot keep copies:** NO (section 2, item 1).
4. **No real job identifiers in tests or the change log:** the real job's number and street from the original branch are gone. I checked every quoted name in the old test file's sample lines against this branch's whole change and commit message, by script, without printing them: none remain; "SampleJob" and "99-001" are plainly made up. One leftover: test file line 435 still uses a job-number-shaped folder name, which the last review asked to make obviously made up (section 2, item 3). The change log entries carry no identifiers.
5. **CE never saves the drawing itself:** confirmed by reading. No save, save-as, Wblock, document lock or transaction in the new code; the source-text test `NewServiceCode_NeverSavesWblocksLocksOrStartsATransaction_AndWritesOneSystemVariable` (test file 455-459) fails the build if one is added. The one AutoCAD option it can change (SAVETIME) is behind `MatchAutoCadSaveTime`, which ships off, never inside a command (100-129).
6. **Nothing written beside or over the drawing:** confirmed. Copies go to `<CE settings folder>\AutoSaveBackups\CE_STRUC_SUITE\<drawing name>_<code>` (`DrawingAutoSaveService.cs` 1333-1341), first under a temporary name in that same folder, then renamed; AutoCAD's automatic-save file is only read. As for Civil, the existing Settings value "Backup folder" (empty by default) moves that folder wherever someone points it.
7. **The Settings rows, for a look by eye (Codex):** `UI\Dialogs\CeSettingsDialog.xaml` 570-585, in the AutoSave group:
   1. Tick "Remind me when a drawing has not been saved".
   2. Box "Remind me when not saved for (minutes)".
   3. Tick "Keep copies of unsaved work (your drawing is never touched)".
   4. Box "Every (minutes)": vague on its own; "Copy unsaved work every (minutes)" (the wording the settings-recovery list already uses, `SettingsService.LoadRecovery.cs` 1379) would read better.
   5. Tick "Set AutoCAD's automatic save to match (changes an AutoCAD option)".
   6. Box "Unsaved copies to keep".
   7. Not on the page (settings file only): seconds a file must settle (10) and seconds between checks (30). Fine for now; R-00 says every value has a row eventually.

## 2. FIX FIRST

1. **CE still never says on screen when it cannot keep copies.** NOT FIXED from the last review (item 2).
   1. When AutoCAD's automatic save is off ("SAVETIME 0", `UnsavedWorkPlanner.cs` 197), no automatic-save file appears (210), or SAVEFILEPATH is blank (`UnsavedWork.cs` 435: Structural then finds no files at all, where Civil falls back to the Windows temporary folder), the skip goes only to the CE log and the status-bar tooltip (`LogUnsavedSkip`, 398-410; tooltip 574-586).
   2. BUG-1276 records no automatic-save files on 4 Nov, so this is the likely case, not a corner case. The drafter would believe copies were being kept.
   3. Fix: one plain line per session, for example "CE cannot keep copies of unsaved work: AutoCAD's automatic save is off (OPTIONS, Open and Save tab, Automatic save)." Same fix as Civil PR 2042, so the two halves say the same thing.
2. **The "backup copy not made" line still gives software words.** NOT FIXED from the last review (item 3).
   1. `DrawingAutoSaveService.cs` 1180 passes `DrawingSafetyService`'s internal reason straight to "CE: backup copy not made (reason)." (`UnsavedWork.cs` 501). Reasons include "document disposed", "database inaccessible", "database unavailable", ".sv$ autosave drawing", "non-DWG drawing" (`DrawingSafetyService.cs` 127-254).
   2. Because the reminder ships ON, this line now appears by default where nothing was said before, including for an ordinary save of a standard details drawing or a template ("standard details drawing", "template drawing").
   3. Fix: drafting words for each reason, and decide (DRAFT default) whether a standard details drawing or template needs a line at all.
3. **Test file line 435: a job-number-shaped folder name.** Make it obviously made up, as the last review asked (RULES 11). Small.

## 3. Worth knowing (not blocking)

1. **Card TRUST-04 robot case 4** still expects "no file written" (see the Civil re-review); it should expect one copy in the backup folder per interval and nothing written to the drawing.
2. **Still open from the last review, not blocking a trial on copies:** copies land in the Civil or the Structural folder depending on which suite started first (one folder would be easier after a crash); Structural's check does not skip template drawings and Civil's does; the SAVETIME change has no Redo guard here (switch ships off, start-up only).
3. **The PR's "code identical" line** is true (the lane compared it with B-221), but B-221's review was FIX FIRST and two of its items are still open, as section 2 shows. Same note as for the Civil half.
4. **Wiring guard added** (`TheReminder_IsWiredIn_AtStartIdleAndTheStatusText`, test 491): removing the start-up call turns it red (lane's twin, 1 of 47). Good.

## 4. Not checked

1. Did not build or run tests; counts are the lane's.
2. Nothing seen in AutoCAD: the automatic-save file name and folder on 2027, whether AutoCAD's automatic save leaves the changed flag alone, the status text and Settings rows as drawn, the copy time.
3. Why Tim's PC had no automatic-save files on 4 Nov (still unexplained).
4. AutoCAD 2022 to 2024.
