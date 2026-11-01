# Opus pre-review, backlog group r6 (Structural markup, notes and schedules): PRs #1572, #1579, #1560, #1011, #1013

Written Sunday 1 November 2026, 13:30 Melbourne, by an independent read-only Opus reviewer (Team) for CE 05, at CE 00's and CE 01's request. The group is item 5 ("r6") in `areas\DRAFT_BACKLOG_TRIAGE_01NOV.md`; this file is named R5 as the brief asked.
Release line checked: Structural `claude/rel-20261026s` at 204dfad2 (Structural 1.0.125, S-45), confirmed with `git ls-remote` at the time of review. No later Structural release branch exists on GitHub.
Heads reviewed: #1572 2829c47a, #1579 d7299d1e, #1560 0aed87a3, #1011 ba61da8b, #1013 42a0f493. All five are open DRAFTs. The first three heads are the same heads the October reviews saw, so none of the fixes those reviews asked for has been pushed.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the code on the S-45 line, the carpark entries and the older Opus reviews (`REVIEW_PILE_B7_24OCT.md` for #1560 and #1572, `REVIEW_PILE_B8_24OCT.md` for #1579). I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.

## FOR TIM

1. **#1572, "Preview drawing updates" really previews (BUG-972): CHANGE-NEEDED (one line), Structural area + smoke.** Today the button writes revision B into your closed drawings before you see anything. Now a list opens with Apply and Cancel. The palette's list opens without being tied to AutoCAD, so it may hide behind AutoCAD. The October review asked for the one-line fix; it was never pushed.
2. **#1579, CEMARKUPUNDO refuses in the wrong drawing (BUG-984): KEEP-WITH-NOTE, Structural area + smoke.** Run markup in A.dwg, switch to B.dwg, CEMARKUPUNDO: CE now says "run it in A.dwg, nothing was undone" instead of undoing B's last step. Code is right. One comment and the log wrongly say CE waits for the undo to finish; it does not (wording only).
3. **#1560, a damaged notes file is not wiped by the next note (BUG-976): CHANGE-NEEDED, Structural area + smoke.** The file is now safe. But in the Notes browser your typed note just vanishes with no message, and the carpark asks for "a plain message". The October review asked for that message box; it was never added.
4. **#1011, Refresh blanks the row of an erased brace or pier (BUG-498): KEEP-WITH-NOTE, Structural area + smoke.** Four braces, erase one, STRSCHEDREFRESH: three rows and one blank row, not four. The rebase onto S-45 needs a small hand-merge in the schedule code (keep both pieces).
5. **#1013, C1/C2 on a mark with two sizes (BUG-501): CHANGE-NEEDED, Structural area + smoke.** For C2 it works: CE names the two sizes and asks. For C1 it does not ask, because C1 has no size question. C1 silently draws your Settings C1 size (89 SHS out of the box) while the message says "CE asks". In the bug's own example, the first floor still gets 89 SHS.
6. **Merging:** all five are on old bases. Against S-45 each clashes in the change log only (keep both), except #1011, which also clashes in the schedule code (two pieces added side by side, keep both). None touches the Settings list (UserSettings.cs). #1011 and #1008 (next group) now merge cleanly together.
7. **Nobody has opened any of the five in AutoCAD.** All are built and unit-tested by their authors only; I re-ran nothing. All five bugs stay OPEN. No test touched your settings files. #1560's test writes to the CE log unless the scratch log folder is set, which its author says was set.
8. **One new bug to file (not mine to file):** the shared project tags file has the same fault as #1560. If it cannot be read, the next tag save wipes every other job's tags. The October review asked for a carpark entry; I found none.

---

## DETAIL

### Group facts

1. **Bases:** #1572, #1579 and #1560 sit on `claude/rel-20261022s2` (S-41, 2c9a9694), 119 commits behind S-45. #1011 and #1013 sit on `claude/rel-20261009t` (c822a8ec), 295 behind. #1560 has two commits (fix plus a log wording commit); the others one each. Nothing is stacked on anything else.
2. **No author report exists for any of the five.** The reports named in the triage (`FB_TEAM_BATCH6`, `FB_TEAM_BATCH10`, `MAX_BUILD_D`) only mention these PRs as "already has a fix PR, not re-tested". I judged from the PR text, the diff, the carpark and the older reviews.
3. **Settings:** none of the five adds a Settings value or touches `UserSettings.cs`, so there is no default to pin and no defaults test is owed. None hard-codes an engineering value (R-00).
4. **Protected files:** none of `LinkService.Persistence.cs`, `ProjectDataService.Persistence.cs` or `RulebookEngine.cs` is touched. The carpark marks BUG-972, BUG-976 and BUG-984 as "Protected: yes" (sheet sync, notes store, markup undo); I read those lines with that care.
5. **Merge-tree against S-45 (204dfad2):** #1572, #1579, #1560, #1013: only `REGRESSION_LOG.md` (keep both). #1011: `REGRESSION_LOG.md` and `Modules/Structural/Services/ScheduleService.cs`. The code clash is two insertions at the same spot: S-45 added the Bored Pier row-record helpers (`BuildAlignedMap`, `RecordPierRowLinks`, `TryReplaceScheduleMapInPlace`, S-45 lines 651 to 680) right where #1011 adds `FirstLeftoverRow`. Keep both; no logic overlaps.
6. **Pairwise merge-tree inside the group and with #1008 (r7):** every pair clashes only in `REGRESSION_LOG.md`, except that #1011 also clashes in `ScheduleService.cs` with #1572, #1579 and #1560 (the same S-41 insertion as point 5, nothing new). #1008 + #1011 merge cleanly in the code. So the "r6 before r7" order is safe but not required.
7. **Suggested order on S-45:** #1579, #1011, #1572 (after fix), #1560 (after fix), #1013 (after fix). Code files never overlap between these five, so the order only matters for the change log.

### #1572 @ 2829c47a, BUG-972: "Preview drawing updates" previews first and asks before writing. CHANGE-NEEDED, Structural area + smoke

1. **What changes for the drafter:**
   1. **CESHEETSCLASSIC window button** (`CeSheetsManagerWindow.xaml.cs` lines 516 to 525 in the PR): builds a read-only list from the sheet list (`CeSheetsUpdateService.BuildUpdatePreview`, `CeSheetsUpdateService.cs` line 95), shows it in the existing sync preview window, and runs `UpdateAllDrawings` only after Apply. Cancel writes nothing and says so on the status line.
   2. **Sheets palette button** (`SheetsPanel.xaml.cs` lines 183 to 195): shows the existing `BuildSyncPreview` first; a preview blocked by the pre-checks goes straight on to `SyncManifest`, which writes nothing and shows the blockers as before.
   3. **This is what the carpark asks for** ("only lists what would change; nothing is written or saved until a separate Apply"). I checked on S-45 that the preview uses the same helpers as the write (`ResolveDrawingRevision`, `BuildSharedPropertyUpdates`, `BuildTabRenames`, all still present), so the list matches what Apply writes.
2. **Settings:** none, and none is needed: the old behaviour (write without showing) is the bug.
3. **No-hard-blocks:** the new window is the confirm the bug asks for, not a block. Cancel leaves everything as it was.
4. **Fix needed (from B7, still not pushed):** `SheetsPanel.xaml.cs` line 189 calls `previewWindow.ShowDialog()` with no owner. Use `AutoCadWindowHostHelper.ShowPaletteModalDialog(previewWindow, ...)` as the CESHEETSCLASSIC window already does at S-45 line 431 for its other dialog. Without it the list can open behind AutoCAD and the drafter thinks AutoCAD has frozen.
5. **Native protection / REDO:** the write path is unchanged (`RunOnWritableDrawing`). A drawing open in AutoCAD is flagged in the list; Apply then does what it did before for open drawings. No U or REDO involved.
6. **LOW:** `BuildUpdatePreview` repeats the per-drawing loop of `UpdateOneDrawing` rather than sharing it (design rule 1). Today they agree; if someone later changes one loop, the preview could drift from the write. A comment pointing each at the other would do.
7. **Tests:** `CeSheetsUpdatePreviewTests`, 5 cases, in a temp folder (`Path.GetTempPath()`), no settings or log touched. The key case checks the DWG bytes and saved time are unchanged after a preview. RED = does not compile on the old code (the preview did not exist), which proves the method is new, not that the button changed; the button change is covered by a source-text check only.
8. **Not proven:** net48 not built; not seen in AutoCAD; window wording ("Apply Sync" on an Update Drawings action) needs a Codex look.
9. **Robot (CE 02) scenario, copy only:** job copy with a closed `B.dwg` at REVISION A, managed in the sheet list. Change the row to B. Press Preview drawing updates in CESHEETSCLASSIC: list shows REVISION B. Cancel. Read `B.dwg` SHA-256 and REVISION: unchanged, still A. Press again, Apply: REVISION B. Repeat from the Sheets palette button, and check the list window comes up in front of AutoCAD.
10. **Verdict: CHANGE-NEEDED.** Exact fix: line 189 to `AutoCadWindowHostHelper.ShowPaletteModalDialog`. Then KEEP, Structural area + smoke, plus a Codex window look.

### #1579 @ d7299d1e, BUG-984: CEMARKUPUNDO only undoes a step in the drawing it was run in. KEEP-WITH-NOTE, Structural area + smoke

1. **What changes for the drafter:** each markup batch now records the drawing it ran in (`MarkupAIWorkflowService.cs` line 182, stored on `ExecutionBatchResult.DrawingPath`). CEMARKUPUNDO in another drawing prints "The last markup step was run in A.dwg. Switch to that drawing and run CEMARKUPUNDO there. Nothing was undone." (lines 211 to 224, 245). The batch is now taken off CE's list only after the U was sent (line 255), not before. An older batch with no drawing recorded is not refused. This matches the carpark's expected behaviour.
2. **Settings:** none, none needed.
3. **No-hard-blocks:** the refusal leaves both drawings exactly as they were and tells the drafter where to go. It protects drawing B from losing work. Not a hard block.
4. **REDO-safety:** the guard adds no command, no transaction and no system-variable write. The U is still the last thing CE sends (`MarkupAIExecutionService.UndoLastGroup`, S-45 line 220, `_.U` queued). After it, CE saves its plan list, which is a side file, not the drawing; same as before. REDO is respected.
5. **Note (from B8, still not pushed, wording only):** the comment at line 241, the test name `TheStepIsOnlyTakenOffTheHistoryAfterAutoCadHasUndoneIt...` and the change-log line say the step is taken off "once AutoCAD has undone it". Not true: the U is queued and runs when the command ends. Reword to "after the U is sent". No code change. The carpark's "only after the undo actually happened" is therefore met as far as CE can know, not literally.
6. **LOW, new here:** the check compares full drawing paths. If the drafter does a SAVEAS between CEMARKUPRUN and CEMARKUPUNDO, the drawing's name changes and CE refuses in the same drawing, naming the old file. Safe direction (nothing undone), mildly confusing.
7. **Native protection:** unchanged; U is AutoCAD's own.
8. **Tests:** `MarkupUndoDrawingGuardTests`, 5 cases, pure logic plus one source-order check. No files written outside the build folder. RED = does not compile on the old code. The order test only proves the lines are in that order.
9. **Not proven:** net48 not built; not seen in AutoCAD.
10. **Robot scenario, copies only:** open A.dwg and B.dwg. CEMARKUPRUN one native NOTE in A. Switch to B, draw a LINE. CEMARKUPUNDO: the refusal line naming A.dwg; B's line still there; A's note still there. Switch to A, CEMARKUPUNDO: the note goes. Then REDO in A: the note comes back.
11. **Verdict: KEEP-WITH-NOTE** (reword the comment, test name and log line before or while merging). Structural area + smoke.

### #1560 @ 0aed87a3, BUG-976: an unreadable notes file is never overwritten by the next new note. CHANGE-NEEDED, Structural area + smoke

1. **What changes for the drafter:** `SharedNotesManager` remembers a notes file whose read failed (lines 1014, 1049, 1121) and refuses to save over it (lines 1019, 1060, 1134) until a later read succeeds. Both the own-notes route and the other-user route are covered. The file is safe: that part matches the carpark.
2. **What does not match the carpark:** the carpark says "adding a note refuses with a plain message". The PR adds no message.
   1. **Notes browser** (`NotesBrowserDialog.xaml.cs` line 1061 on S-45): when `AddNote` returns false, nothing happens. The drafter types a note, clicks OK, and it is gone with no word. The PR body admits this ("Window owed").
   2. **Notes palette** (`NotesPanel.xaml.cs` lines 869 to 886 on S-45): already shows "The project note could not be saved to shared storage. Check the log for details." That is acceptable but does not say why.
3. **Fix needed (from B7, still not pushed):** in `NotesBrowserDialog.xaml.cs` add the else-branch at line 1061 with a message, for example: "Note not saved. The notes file could not be read, so saving now would wipe your earlier notes. Your note text is below so you can copy it: …". The same silence applies to the two `UpdateNote` calls in that window (edit, resolve). This is a window change, so it needs a Codex look.
4. **Settings:** none, none needed.
5. **No-hard-blocks:** refusing to wipe a whole notes file is correct, not a block on drawing work. But a refusal with no message is the kind R-27 forbids in spirit: the drafter cannot act on what they are not told.
6. **Native protection / REDO:** no drawing write. Not applicable.
7. **LOW:** when the save is refused, `AddImageForUser` may already have copied a picture into the images folder; it is left there unused.
8. **Separate bug, still unfiled:** `LoadProjectTagsData` / `SaveProjectTagsForGroup` in the same file wipe the shared tags file the same way. I found no carpark entry for it. CE 05 should file it.
9. **Tests:** `SharedNotesManagerDamagedFileTests`, 3 cases, in a temp folder. A new constructor takes the user name so no AutoCAD is needed. The author says the damaged-file and repaired-file tests fail with the guard taken out (real RED, not just a compile failure). The tests create `new Logger()`, which writes to the real Structural log folder unless the log redirect is set; the author says a scratch log folder was used and your `CS_Settings.json` and live logs were unchanged. I could not verify that.
10. **Not proven:** net48 not built; not seen in AutoCAD; the OneDrive "held for a moment" case is only simulated by broken text.
11. **Robot scenario, copies only, isolated data folder:** write a `notes_data.json` with two notes and a cut-off end. Open the Notes browser, add "S15 THIRD": a plain message appears, and the file's bytes are unchanged. Repeat from the Notes palette. Repair the file, add again: saved, earlier notes still there.
12. **Verdict: CHANGE-NEEDED.** Exact fix: the message box in point 3. Then KEEP, Structural area + smoke, plus a Codex window look.

### #1011 @ ba61da8b, BUG-498: STRSCHEDREFRESH removes erased braces and piers from the schedule. KEEP-WITH-NOTE, Structural area + smoke

1. **What changes for the drafter:** after Refresh rewrites the bracing or bored pier rows, every row below them is blanked (`ScheduleService.cs` lines 596, 618 to 622, 649 to 653), exactly as the tie-down schedule already does (S-45 lines 629 to 634). Four braces, erase one, Refresh: three filled rows and one blank row. The table is not shortened. This is the carpark's "smallest fix" and stops the schedule overstating bracing.
2. **Settings:** none stated, none needed: the old behaviour is the fault.
3. **No-hard-blocks:** none added.
4. **Write-back check:** blanked rows have a blank handle, so `SyncBracingTable` skips them (S-45 line 730). On S-45 the Bored Pier sync now reads its own row record first; `RecordPierRowLinks` pads that record with blanks for spare rows (S-45 line 665), so the blanked rows are skipped too. Nothing is written back to the drawing from a blank row.
5. **Native protection:** not changed. Note, existing before this PR: Refresh opens the table for writing with no locked-layer check (PR line 293). A schedule on a locked layer will fail with AutoCAD's own error, not a plain CE line. Not this PR's fault.
6. **Merge note:** the rebase onto S-45 needs the hand-merge described in Group facts 5 (keep both insertions). Re-run the schedule tests after it, because the S-45 pier code it sits beside is new since the PR was written.
7. **Tests:** `Bug498ScheduleRefreshLeftoverRowsTests`, 3 cases: two check the row arithmetic, one checks both methods call it (source text). RED = does not compile. They do not prove a table is blanked; only AutoCAD will. No files written; no settings touched.
8. **Not proven:** net48 not built; not seen in AutoCAD; not tested on S-45 code.
9. **Robot scenario, copy only, with #1008 in:** four AB braces, STRSCHEDCREATE, erase one, STRSCHEDREFRESH, pick the bracing schedule: three filled rows, the fourth blank. Same with four bored piers, including a 3-column pier table (Settings switch for the table without Layer and Handle on). Then STRSCHEDSYNC: no brace or pier changes.
10. **Verdict: KEEP-WITH-NOTE** (hand-merge on rebase, re-run the schedule tests). Structural area + smoke.

### #1013 @ 42a0f493, BUG-501: C1/C2 ask which size when the schedule lists the mark with two sizes. CHANGE-NEEDED, Structural area + smoke

1. **What the PR does:** when the imported member schedule lists the mark with more than one size (`MemberScheduleService.DistinctSizesForCode`), the command prints "The schedule lists C1 with more than one size (89 SHS, 75 SHS), so CE asks which one to draw here." and drops the schedule row (`SupportBlockCommands.cs` lines 242 to 252).
2. **The fault:** the fallback only asks for C2. Line 262 asks the size question only when `cfg.RequiresVisibilitySelection` is true, and only C2 has that (line 68: C1 is built without it; S-45 lines 69 to 70). So for C1:
   1. CE prints "CE asks which one to draw here" and then asks nothing.
   2. It draws the Settings C1 size (`Supports.C1Size`, out of the box 89 SHS).
   3. In the bug's own example (C1 = 89 SHS ground floor, 75 SHS first floor) the first floor still gets 89 SHS, now with a message that is untrue. The change log entry (point 2, point 5 "the usual size choice") claims C1 asks too.
3. **Fix needed:** for C1 (and any type without a size question) when the schedule gives more than one size, ask a short question offering the schedule's sizes as keywords, with the Settings C1 size as the default, for example "C1 size [89SHS/75SHS] <89 SHS>:". Esc cancels as usual. Correct the log entry. Add a test that C1 with two sizes reaches a question.
4. **C2 part is right**, with one note: the C2 question offers the Settings C2 list, so a schedule size not in that list (for example 75 SHS) cannot be picked; the message at least names it.
5. **Settings:** none added. No engineering value hard-coded; the fallback uses the existing Settings sizes.
6. **No-hard-blocks:** none.
7. **Native protection:** unchanged (the locked-layer stop before the size step stays).
8. **Carpark fit:** the carpark also asks to "say which floor the size came from". The PR says honestly that the saved schedule copy keeps no floor, so that part is not done. Leave BUG-501 open for the floor part.
9. **Tests:** `Bug501MarkWithTwoSizesTests`, 3 cases: two on the size list, one source-text check that the words "more than one size" are in the command. RED = does not compile. Nothing tests that a question is asked, which is how the C1 gap got through.
10. **Robot scenario, copy only:** XCLMTXT a CSV with C1 twice (89 SHS, 75 SHS) and C2 twice (100 SHS, 125 SHS). Type C1: a size question offering both. Type C2: the C2 list after the message. Then a CSV with C1 once: the old "size from the schedule" line and no question.
11. **Verdict: CHANGE-NEEDED** (point 3). Then Structural area + smoke.

### What I did NOT check

1. **No build and no test run.** Pass counts and RED-before claims come from the PR text. No PR says net48 was built.
2. **Nothing opened in AutoCAD.** Every item needs its robot scenario; #1572 and #1560 also need a Codex window look.
3. **Real %APPDATA%:** I could not confirm what the authors' test runs wrote; I can only say the test code writes nothing to settings, and #1560's tests write to the CE log unless redirected.
