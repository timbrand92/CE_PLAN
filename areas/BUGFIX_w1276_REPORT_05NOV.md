# BUG-1276 report (w1276, B-1276): NO PR opened, needs Tim's word

Thu 5 Nov 2026 (Melbourne). Structural base `origin/claude/rel-20261026s` after `git fetch`. Sonnet 5.5 job.

## FOR TIM

1. **Answer:** I did not build anything. The missing backups are not a fault in the timer; CE has no timer any more. That was your own ruling.
2. **Your ruling (25 Sep, clicked in the release chat, decisions\2026-09-23_V3_COLLEAGUE_RELEASE.md line 368):** "AutoCAD's own + reminder": CE never saves, AutoCAD's own automatic save writes the recovery copy, CE keeps a copy after each of YOUR saves, and CE adds a quiet "Not saved for N min" note on the status bar. "No CE writes, no Undo impact."
3. **What happened on 4 Nov:** you saved at 14:42:17, CE copied that file once, and you did not save again. The copy is of the saved file, so the 2 h 40 min of edits after it were never in any CE backup. The reading (job 594) reached the same answer.
4. **The reminder you chose was never built.** I searched the Structural code on the line: the status bar shows "autosave: pending" and nothing about minutes. That is the real gap, and it is small and safe.
5. **Why I stopped:** the task asks for a backup of UNSAVED edits every interval. To copy unsaved edits CE would have to write the open drawing's in-memory state to a file on a timer. That is exactly the "CE writes" you ruled out on 25 Sep, and it touches the Undo/REDO rules and Xref content. Only the CLEAN command was overruled on 5 Nov (B-178), not the timer. Nobody has reproduced a fault, so I will not undo a clicked ruling on a reading.
6. **One question for you:** "Do you now want CE to write a timed backup copy of unsaved edits (overruling your 25 Sep choice), or build the reminder you chose then: a status-bar line 'Not saved for 25 min' that turns amber and warns once in the command line?" My recommendation: the reminder first (no drawing writes, REDO-safe), because it would have told you at 15:07 on Wednesday.
7. **Mistakes of mine:** none that cost anything. I ran no build, no test and no AutoCAD.
8. **NOT proven:** nobody has reproduced missed backups; I did not read your logs or backup files; which Structural build was loaded on 4 Nov is not established; the 12-minute Xref backups were not explained.

## Technical detail

1. **Idle handler (`DrawingAutoSaveService.cs` about 1054 to 1137):** `HasPendingWork` is true only when `PendingBackup` or text-anchor work is queued. `Dirty` alone is not counted, so the idle line reads 0.0 ms. The comment at about 1112 to 1118 records the UX-STD-03 removal. `ShouldRunAutoSave` (about 1183) is unused.
2. **`PendingBackup` is set only** by a manual QSAVE/SAVE/SAVEAS ending or `TrySaveNow`. The copy is `File.Copy(drawingPath, backupPath)` at about line 1292: bytes on disk only.
3. **Skip reasons checked:** command active, document lock, read-only, Xref active, DBMOD all do not gate the live backup. A recovery (`.sv$`/`.ac$`) path drops that one backup with a log line only (reading section 5.2: "say so once in plain words" is also unmet there).
4. **Civil copy is separate** (`Modules/Drainage/Services/DrawingBackupService.cs`), not shared. Tim's single file was in `CE_CVL_SUITE`, so Civil wrote it. CE_SHARED untouched; nothing changed in any repo.
5. **Possible small fix once Tim answers (reminder option):** one switch, ON by default, Settings minutes value (R-00), status text plus one command-line warning per drawing per threshold, no writes. Unit test feeds a dirty state older than the threshold and expects the warning. With the switch OFF the old text returns exactly.
6. **Required listings (rule 1):** no test was run, so no variables were set and the %APPDATA% folders were not listed; nothing of mine could have written there.
7. **Disk and worktree:** no worktree or scratch folder created by me; C: 62 GB free, unchanged.

## Robot case (proposed, for the reminder option)

`B1276_unsaved_reminder`: type `CLEAN` is not needed; open a copy, draw one LINE, wait past the Settings minutes, read the status-bar text and command line: expect "Not saved for N min". Switch-off control: set the switch OFF before launch, repeat, expect no such text.
