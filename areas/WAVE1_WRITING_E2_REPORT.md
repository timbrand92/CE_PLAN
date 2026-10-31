# Wave 1 case writing, job E2: Edit Pipe batch editor, Recalculate downstream, blank end level (Sat 31 Oct 2026)

Writer: Opus case writer E2, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Nothing was run: no AutoCAD, no driver, no build, no test; only the offline `validate` and `check_ids`. No existing case, setup, driver or settings file was edited. Nothing committed or pushed.

## FOR TIM

1. **Answer:** 3 of my 4 bugs now have a robot case (BUG-324, BUG-652, BUG-653). BUG-339 has none: it needs the Apply button in the multi-pipe Edit window, which the robot is not allowed to press. It goes to a Codex look.
2. **BUG-324 (case W324):** pick the old P4 -> P3 pipe plus a fresh pipe, type CDEDIT. CE must leave the old pipe out by name and open the editor for the other one, not refuse both.
3. **BUG-652 and BUG-653 (one case, W652):** four new pits A-B-C-D in empty ground. Lower the pipe into pit B from 18.40 to 18.20 and answer Yes to "Recalculate downstream".
4. **What must be true:** the pipe leaving B starts at 18.15, not 18.20 (B's 50 mm drop kept). The next pipe, with its far level left blank, is skipped and named, not given a level of -0.10.
5. **Twins (must fail):** W324_BROKEN, W652_BROKEN (pit-drop switch off), W653_BROKEN. Each one fails on a check, not on a stuck step.
6. **Not proven by these cases:** the Apply button of the multi-pipe Edit window (BUG-324's write and all of BUG-339), and CDPROPAGATE (BUG-653's other route).
7. **Fault found in older drafts:** N65 and N66 expect "Edit 2 Pipes" for the old P4 -> P3 pipe plus one other. On a fresh test drawing CE leaves that pipe out, so both will fail at their first step.
8. **Checks:** `validate` 35 files, 0 invalid. `check_ids`: every control id is known. No "print", no street name, no level that disagrees with the arithmetic.
9. **Nobody has run them.** Every number is worked out from the installed code (3fbb9da5, Civil 3.0.88), except the old-pipe fact, which was seen on today's 13:22 run.
10. **Your action:** none. The desk gives them to the Opus review, then the robot.
11. **Robot time:** W652 is long, about 15 to 20 minutes per pass (4 pits and 3 pipes), so allow about 2 hours for W652 with its two twins over two passes. W324 is about 5 minutes per pass.
12. **Files:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\` W324_batch_leaves_out_older_pipe, W324_BROKEN, W652_recalc_keeps_pit_drop_skips_blank_end, W652_BROKEN, W653_BROKEN.

---

## DETAIL

### 1. BUG-324: batch editor refused every pipe because one was older

1. **Case and twin:** `W324` (`W324_batch_leaves_out_older_pipe.case.txt`), twin `W324_BROKEN`.
2. **What it does, in drafting words:** draws one new 225 pipe with CD from 150000,-90000 to 170000,-90000 at 18.000 / 17.800 (20 m, 1 in 100). Selects it together with the fixture's pipe P4 -> P3 (handle 10A98D) and types CDEDIT. Reads the window that opens, then closes it without pressing anything inside it.
3. **Must be true at the end:**
   1. The command line says `[CE] 2 pipes selected - opening the batch editor.`
   2. Then `[CE] Pipe P4 -> P3 was left out of the batch and not changed: it was drawn with an older version of CE and its label is not recorded yet; ...` and `Opening the batch editor for the other pipe.`
   3. Neither the old `The pipe batch was refused` line nor `The batch editor was not opened` appears.
   4. The window is titled `Creative Engineering | Edit Pipe` (not "Edit 1 Pipes") and holds `Apply to Selected` and `Carry downstream`. That is how the batch editor is told apart from the single Edit Pipe, which has the same title.
   5. After closing it: every IL text and the object count are unchanged, no CE window is open, and the drawing file is unchanged.
4. **Where the words come from (3fbb9da5):**
   1. `Commands/HubCommands.cs` 288: the "2 pipes selected" line (`Describe` 398-401).
   2. `Commands/PipeEditCommand.Batch.cs` 70-86: an unreadable pipe is left out, not refused. Lines 137-138 write the left-out line before the window opens.
   3. `Rules/PipeBatchReadRule.cs` 39-40: title "Edit Pipe" for one pipe. Lines 51-63: the left-out line. Lines 128-133: the older-drawing reason.
   4. `Rules/PitMoveLockedPipeRule.cs` 67-72: the name "P4 -> P3".
   5. `Dialogs/BatchEditWorkshopDialog.xaml` 349 (`Carry downstream`) and 388 (`Apply to Selected`). `BatchEditWorkshopDialog.xaml.cs` 43: the title prefix.
5. **Seen, not derived:** 10A98D is an older pipe on 3.0.88. Transcript `session_20261031_131450.log` line 201 (31 Oct 13:22, fresh copy CLDV31315241_B1) shows CDEDIT asking "This pipe was drawn with an older version of CE ...". The same left-out line, with the name "Pipe P4 -> P3", was written on 4 Oct (`session_20261003_235951.log` line 1157). The Edit Pipe dump `Creative_Engineering_Edit_Pipe_032356.json` shows the header "Flow: P4 → P3" and the levels 17.40 / 17.30.
6. **Derived, never seen on 3.0.88:** the full left-out line today. Also that the v3 dump of the batch editor shows `Apply to Selected` and `Carry downstream` (taken from the XAML; the runner has never dumped this window).
7. **Arithmetic:** fall 18.000 - 17.800 = 0.200 over 20 m is 1 in 100, the brief's limit. With no pit at either end it is 20 m long.
8. **What the twin breaks:** one check. It expects the old line `The pipe batch was refused` to be on the command line. It must FAIL on `history has "The pipe batch was refused"`.
9. **What a Codex look must see:** after the allow-list change, or by hand, tick a field in the one-pipe batch, press Apply to Selected, and check that only the fresh pipe changes and P4 -> P3 keeps 17.40 / 17.30.

### 2. BUG-652 and BUG-653: one case, W652

1. **Case and twins:** `W652` (`W652_recalc_keeps_pit_drop_skips_blank_end.case.txt`, PROVES_BUGS BUG-652, BUG-653). Twins: `W652_BROKEN` (BUG-652) and `W653_BROKEN` (BUG-653).
2. **Why one case:** one Recalculate run walks across pit B (BUG-652) and then reaches the blank-ended pipe (BUG-653). Both bugs are in the same walk, so one drawing proves both honestly. Each bug still has its own twin.
3. **What it does, in drafting words:**
   1. Types four pits with PIT, each with cover 19.000: A at 150000,-70000; B at 160000,-70000; C at 170000,-70000; D at 170000,-60000.
   2. Draws three pipes with CD, pit to pit, 225 mm, Standard grade, main pipe text off: A->B at 18.500 / 18.400; B->C at 18.350 / 18.250; C->D at 18.200 with its downstream box cleared (left blank).
   3. Selects A->B, types CDEDIT, sets 18.500 / 18.200 and presses Save.
   4. Answers Yes to "Recalculate downstream inverts?" and presses Apply in Cascade Preview.
4. **Must be true at the end:**
   1. The command line has `[CDEDIT-CASCADE] Updated 1 pipes and 1 pits from ` and `(IL 18.20). Min grade: 1:`.
   2. It has `[CDEDIT-CASCADE] Warning: Skipping pipe ` and ` - it has no level at one end. Fill the level in and run this again to carry the change past it.`
   3. It has neither "Cancelled." nor "nothing to cascade".
   4. Among the objects the case drew: exactly one text `IL 18.15`, exactly one `IL 18.05`, none `IL 18.10`, and no IL text below zero.
   5. The CE log has `IL=18.20 pipes=1 pits=1`. No CE window is open and the drawing file is unchanged.
5. **Where the words and numbers come from (3fbb9da5, `Services/LinkService.RepairAudit.InvertPropagation.cs` unless named):**
   1. Lines 222-229: a blank end takes no part in a pit drop.
   2. Lines 233-245: the edited pipe counts at its level from before the save.
   3. Lines 257-258: the switch `linking.cascadeKeepsPitDrop` (`Models/UserSettings.cs` 884-885, default on).
   4. Lines 309-318: the BUG-653 skip and its words.
   5. Lines 375-432: the BUG-652 drop rule.
   6. Line 30: levels are written as `0.00` (2 decimals).
   7. Line 1039: the "Updated" line. Line 1040: the CE log line.
   8. `CommandLineText.cs` 19-36: the arrow is written as "->" on the command line.
   9. `Commands/PipeEditCommand.Update.cs`: 1974-1978 the Recalculate box; 1986-1989 the anchor is the edited pipe's downstream pit, with the old level; 1998-2006 the preview, then the lines.
   10. `Rules/PipeStartReadiness.cs` 106-109 and 141-152, with `pipe.blankInvertIsWarningNotBlock` (`UserSettings.cs` 1450-1451, default on): a blank level is saved as Unknown, not refused.
6. **Arithmetic (all derived):**
   1. Each pipe is 10 m centre to centre, about 9.55 m wall to wall (225 mm into each pit). A fall of 0.100 is about 1 in 96, steeper than 1 in 100. Standard grade never opens the Grade mismatch window.
   2. Edited pipe A->B: 18.400 becomes 18.200, so the anchor at pit B is 18.20.
   3. Drop at B before the save: 18.400 - 18.350 = 0.050.
   4. B->C new start: 18.20 - 0.05 = 18.15. Its own fall of 0.100 is kept, so the new end is 18.05. Pit C becomes 18.05.
   5. C->D has a blank end, so it is skipped and keeps 18.200. That leaves exactly one `IL 18.05`.
   6. The old cascade gives B->C 18.20 / 18.10. It reads C->D as 18.20 / 0.00, so it writes 18.10 / -0.10: two `IL 18.10` texts and one below zero.
   7. Grade in the "Min grade" line: 9.55 / 0.10 is about 96. Not asserted exactly, because the wall-to-wall length is not measured.
   8. Typed texts keep 3 decimals (`IL 18.200`); cascade texts have 2. The regex `IL 18\.20(?!\d)` therefore never matches `IL 18.200`.
7. **What the twins break:**
   1. `W652_BROKEN`: one SETTING line turns `linking.cascadeKeepsPitDrop` false. This is the switch that brings back the old no-drop cascade. B->C reads 18.20 / 18.10, so the case FAILS on `count $il15 = 1`, `count $il05 = 1` and `count $il10 = 0`. The BUG-653 checks still pass.
   2. `W653_BROKEN`: one check changed. It expects one IL text below zero (the old RL 0.00 reading). It must FAIL on `count $ilneg = 1`.
8. **Not proven, and what a Codex look must see:**
   1. **CDPROPAGATE is not driven.** It asks for the anchor pit by an entity pick, and a typed pick on a pit outline has no proven route. A Codex look should run CDPROPAGATE on a copy, pick a pit whose arriving pipe has one blank level, and check the "Skipping pipe" line and that no pit is lifted. The skip is the same code for both directions.
   2. **Unconfirmed steps:** that an empty `ui2-set` clears the downstream box (the N33 cases rely on it too). The dump `$np3` is recorded so a reviewer can see it. Also that `ui-dump "Cascade Preview"` reads anything (recorded only, `-Optional`).
   3. **Not covered:** the junction rule (BUG-655) and the hand-typed-level refusal (BUG-654).
9. **Settings and leftovers:** both settings are pinned at their defaults by SETTING lines (the guard puts the file back), so the case runs in its own guarded AutoCAD start. New Pipe does not recall the last pipe on this PC (paper review section 2 item 2). The pipe size is set to 225, the job size SETUP-R47v relies on.

### 3. BUG-339: batch Apply failed on an older drawing's Pit Schedule cell (NO CASE)

1. **Why no robot case:** the failure and the fix both happen at Apply in the multi-pipe Edit window. `Apply to Selected` is on no driver press list. The v2 list has no entry for "Edit * Pipes". The one-pipe batch window does match v2's `*Edit Pipe*` entry, but its press list has only Save pipe and close, Cancel, Close, OK and Inspect.
2. **Fixture:** it also needs a schedule cell from an older drawing; whether DRV1_B1 has one is not known.
3. **Goes to:** a Codex look on a copy. Select the bug's two pipes (or 10A98D after one single CDEDIT with Yes, plus 109E23), tick Design grade, Apply, answer No to recalculate. Check that the write happens and that the log has no "An affected schedule cell cannot be resolved" line.
4. **Alternative:** the reviewed allow-list change already written out in N65's header, item 3.

### 4. Faults noticed in existing cases (names only, not edited)

1. **`drafts_next40_b_30oct\N65_one_grade_only_these_pipes` and `N66_one_grade_carry_downstream_u` (and their twins):** both pick 10A98D with one other pipe on a fresh DRV1_B1 and expect `-ExpectWindow "Edit 2 Pipes"`. 10A98D is an older pipe there (seen 31 Oct 13:22), so CE leaves it out and opens "Edit Pipe". The step will fail before any check. R20 avoids this by editing 10A98D on its own first and answering Y.
2. **R11 / R11v87:** these assert "Updated 4 pipes and 3 pits from P3" and a whole-set string. They pass on 3.0.83 with the BUG-652 fix in, but nothing in them says which text is the pipe leaving P3. So they do not prove the pit drop, and P3 is a junction (BUG-655 rule). W652 is the proof for BUG-652; R11 is not.

### 5. Checks run (all offline)

1. **validate:** `case_runner.ps1 validate ...\drafts_wave1_31oct`: `35 file(s) checked, 0 invalid` (my 5 files: W324 38 steps / 17 checks; W652 and both twins 103 steps / 22 checks).
2. **check_ids:** `check_ids.ps1 -Folders drafts_wave1_31oct`: `RESULT: every control id is known`.
3. **Word and number check:**
   1. No "print" in any of my files (the word "printed" was replaced).
   2. The only 17.8 literal is 17.800 on W324's 20 m pipe at 1 in 100, which matches the arithmetic.
   3. No street, client or job address: made-up coordinates only.
4. **Written only:** the five case files above and this report.
