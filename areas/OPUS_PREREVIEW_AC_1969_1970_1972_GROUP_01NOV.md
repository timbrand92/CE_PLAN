<!-- verdict lines for the b1 lane -->

1. #1969 comma-decimal levels (BUG-1164): KEEP-WITH-NOTE, Civil area + smoke. On a PC set to a European region, a level typed 18,14 in Edit Pipe is now saved as 18.14, so the schedule and CDAUDIT no l
2. #1970 "level not saved" line (BUG-1157): KEEP-WITH-NOTE, FULL (it touches a protected file). The code is safe and silent unless the level write fails. But the case the bug describes, a pipe with a 
3. #1972 downstream question after the save (BUG-658): CHANGE-NEEDED (small), FULL. The "Recalculate downstream pipe inverts?" box now comes after the pipe change is saved, which is right. The fault: 
   1. #1969 x #1972: `Modules/Drainage/Models/UserSettings.cs` conflicts. Both add a switch straight after `EditPipeReverseArrowReadsDrawnEnds` (about line 1464). Keep both blocks, one after the other
   1. One real clash: #1970 x #1947 (BUG-685, typed-level note), `UserSettings.cs` about line 1477. Both add a switch straight after `SuggestedLevelNeverFlatterThanGrade`. Keep both blocks.
5. Merge. See group fact 3.1 (UserSettings.cs with #1972, keep both).
5. Merge. UserSettings.cs with #1969 (keep both); REGRESSION_LOG.md with #1970. Update.cs auto-merges with #1969, #1970 and #1947.
1. #1969 BUG-1164: KEEP-WITH-NOTE, Civil area + smoke.
2. #1970 BUG-1157: KEEP-WITH-NOTE, FULL (protected `LinkService.Persistence.cs`); fix two wording lines in its REGRESSION_LOG entry; carpark steps need rewriting.
3. #1972 BUG-658: CHANGE-NEEDED, FULL; print one command-line line when the downstream question is skipped after a save that needs reopening (Update.cs about line 1263).

---

# Opus pre-review AC: PRs #1969, #1970, #1972 (B-119, Civil, job n5, before C-79b1)

Written Sunday 1 November 2026, 00:15 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Release tip checked: claude/rel-20261102a at 3fbb9da5 (Civil). All three PRs are Civil only (Modules/Drainage); none touches Structural or CE_SHARED.
Heads reviewed: #1969 1d411b28, #1970 b3e76c82, #1972 556b3848. Each is one commit straight on 3fbb9da5 (0 behind the tip).
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the code around them, the carpark entries and the author's report (areas\BUGFIX_n5_REPORT_31OCT.md), and ran read-only `git fetch` and `git merge-tree` only.

## FOR TIM

1. **#1969 comma-decimal levels (BUG-1164): KEEP-WITH-NOTE, Civil area + smoke.** On a PC set to a European region, a level typed 18,14 in Edit Pipe is now saved as 18.14, so the schedule and CDAUDIT no longer read it as 1814. On your Australian PC nothing changes. Old drawings that already hold "18,14" are not repaired.
2. **#1970 "level not saved" line (BUG-1157): KEEP-WITH-NOTE, FULL (it touches a protected file).** The code is safe and silent unless the level write fails. But the case the bug describes, a pipe with a damaged CE record, cannot reach this line: Edit Pipe already refuses to open such a pipe. So the robot cannot show it, and the change log's AutoCAD step cannot be done. Accept it on the code reading; do not spend robot time on it.
3. **#1972 downstream question after the save (BUG-658): CHANGE-NEEDED (small), FULL.** The "Recalculate downstream pipe inverts?" box now comes after the pipe change is saved, which is right. The fault: in one rare case (the save went in but CE says "the drawing needs to be reopened"), the box is now skipped and only the log says so. Your downstream pipes would then keep their old levels with nothing on screen. Fix: one command-line line saying the downstream levels were not recalculated.
4. **No question for you.** The author asked whether a failed downstream recalculation should undo the pipe change. I checked: the recalculation already puts itself back when it fails, so keeping the edited pipe saved is safe and follows the warn-never-block rule. Nothing to decide.
5. **None of the three has been opened in AutoCAD.** All are built and unit-tested only. All three bugs stay OPEN.
6. **Merging is easy.** Two places need both entries kept in the Settings list (UserSettings.cs): #1969 with #1972, and #1970 with #1947 (BUG-685). The rest is the top of the change log (REGRESSION_LOG.md) only.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases.** All three branch from 3fbb9da5, the current tip, one commit each. None has been tested together with the others or with the rest of C-79b1; the train's run is the proof.
2. **Merge against the tip (read-only `git merge-tree`).** Each of the three merges onto 3fbb9da5 with no conflict at all.
3. **Merge between the three.**
   1. **#1969 x #1972:** `Modules/Drainage/Models/UserSettings.cs` conflicts. Both add a switch straight after `EditPipeReverseArrowReadsDrawnEnds` (about line 1464). Keep both blocks, one after the other. Plus REGRESSION_LOG.md.
   2. **#1969 x #1970 and #1970 x #1972:** REGRESSION_LOG.md only.
   3. **`PipeEditCommand.Update.cs` auto-merges in all three pairs.** #1969 edits about lines 1775 to 1784, #1970 about 1880 to 1891, #1972 about 352, 526 to 549, 1243 to 1266 and 1952 to 1957. I checked pairs one at a time; I did not merge all three at once.
4. **Merge against the other open PRs on rel-20261102a (54 others, checked pairwise).**
   1. **One real clash: #1970 x #1947 (BUG-685, typed-level note), `UserSettings.cs` about line 1477.** Both add a switch straight after `SuggestedLevelNeverFlatterThanGrade`. Keep both blocks.
   2. **#1947 also edits `PipeEditCommand.Update.cs`** (about lines 419 to 447, the worked-out level note). It auto-merges with all three and does not change the text these PRs store.
   3. **#1892 (BUG-1141) also edits `LinkService.Persistence.cs`** (around line 834, the pit-record scan). It merges cleanly with #1970.
   4. Everything else is REGRESSION_LOG.md only or clean.
5. **Defaults test.** The tip has C75 to C78 `NewSwitchDefaultsTests`, no C79 yet. Each PR pins its own switch ON through both start-up reads (`SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`) for `{}`, a pipe group without the key and an unrelated group, plus "typed false changes only itself" and "declared once, written true". **The finaliser should add all three keys to the C-79 defaults class:** `pipe.editPipeStoresLevelsWithDecimalPoint`, `pipe.editPipeLevelWriteSaysWhenNotSaved`, `pipe.cascadeQuestionAfterEditCommits`. None has a Settings page row; decision 126 already puts settings-file-only switches on the planned "Switches" tab, so no new question.
6. **Engineering values (R-00).** None of the three adds an engineering figure. The only numbers are a 1e-9 "same number" tolerance in #1969 and the nine-decimal fallback format; neither belongs in Settings.
7. **Test isolation (from the author's report, not checked by me).** The author redirected TEMP, TMP, the CE log folder and the Structural settings root to `C:\CE_WORK\scratch\n5`. The new tests only read settings text from strings and read source files. But the author's before/after listing found `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` grew 134 bytes at 21:57:27, one minute after their last test and seven seconds before a robot AutoCAD started. They could not prove it was not their run. I could not verify either way. This is the same pattern as the S review (#1891, #1896, #1897); CE 05 should match it against the robot's own settings-set log for 31 Oct 21:57.
8. **Tests ran on net10 only, focused classes** (author: 15 + 75, 26, and 15 + 75 passed; net48 compile 0 errors on all three). The full Civil suite was not run. I did not run anything.

---

### #1969 BUG-1164: Edit Pipe stores a typed level with a full stop on a comma-decimal PC

1. **What changes for the drafter.**
   1. **On an Australian-region PC: nothing.** `EditPipeStoredLevelTextRule.StoredText` (Rules\EditPipeStoredLevelTextRule.cs line 26 onward) keeps any text a full-stop reader already understands exactly as typed (line 31), so "18.14" and "18.140" are stored unchanged. A comma level such as "18,14" is never accepted by the window there in the first place (`PipeEditCommand.cs` line 531, `TryParseDouble`: full stop first, then the PC's own region, no thousands marks).
   2. **On a comma-region PC:** "18,14" is stored on the pipe (`StorePipeInverts`) and in the schedule as "18.14"; "18,10" as "18.10" (digits kept); "-0,5" as "-0.5" (`PipeEditCommand.Update.cs` lines 1775 to 1784).
   3. **Knock-on, good:** the same stored text feeds `ResolveSaveFlow`, the schedule row and the downstream cascade question. Before, the cascade's own invariant read of "18,14" failed, so the cascade question was silently never asked on a comma PC. It now is.
   4. **Not changed:** the level text drawn on the plan still shows what was typed ("18,14"), because `firstInvertText` still goes to `CreateInvertWithZoom` and `ComposeLinkedInvertPlanWording` (Update.cs about lines 797 and 820). That is the carpark's intent ("store the parsed number").
   5. **Matches the carpark?** Yes. The carpark asks "store the parsed number, written with a '.' decimal point". Tim's decision 6 (29 Oct, "a figure typed with a comma (630,5) is refused") was about a different reader (#1788) and does not conflict: this PR does not change what the window accepts.
2. **Settings switch.** `pipe.editPipeStoresLevelsWithDecimalPoint`, ON (UserSettings.cs line 1472 on the branch). Ships ON because it fixes a fault, as the earlier switches do. Pinned through both start-up reads in `Bug1164CommaLevelStoredTests`. **OFF restores the old behaviour exactly:** with `switchOn` false the rule returns the trimmed typed text (rule line 29), which is what the old line did. A missing settings group reads ON (`IsOn(null)`).
3. **No hard blocks.** None. No new message, window or stop.
4. **Protection and REDO.** No new write, transaction or system variable; the same two values go to the same two places, only the characters differ. No layer, Xref or REFEDIT path touched. No protected file.
5. **Merge.** See group fact 3.1 (UserSettings.cs with #1972, keep both).
6. **Tests.**
   1. **Do they fail before and pass after?** The rule tests call a new class, so they cannot pass before. The meaningful one is `OnACommaPc_TheLevelTheWindowReadIsStoredWithAFullStop`: it sets the test's culture to `de-DE`, calls Edit Pipe's real `TryParseDouble` by reflection, then the rule. Good.
   2. **The link to the save is a source-text guard only** (`TheSwitchIsReadAtTheSavePoint...`: the rule is called twice in Update.cs). No test runs `UpdatePipeSchedule` itself.
   3. **%APPDATA%:** the test class writes nothing; see group fact 7.
7. **Not proven.**
   1. Nobody has run it on a comma-region PC, in or out of AutoCAD.
   2. **Not checked by me:** the same full-stop-or-region reader is in `PitEditCommand.cs` line 2002 and `PitCommand.Orientation.cs` line 478. Whether those commands also store the typed text is outside this PR. If they do, it is the same fault and wants its own carpark line.
   3. **Robot (CE 02):** skip unless the robot can start AutoCAD under a comma-decimal Windows region. If it can: Edit Pipe, type 18,14 in the downstream level box, Save, then CDAUDIT. Right: the pipe and schedule show 18.14, no 1814. Control on an Australian PC: type 18.14, Save; stored text is exactly "18.14". **Codex look:** not needed.
8. **Verdict: KEEP-WITH-NOTE. Train class: Civil area + smoke.** Note: writer-side only (old drawings holding "18,14" are not repaired, CDAUDIT's reader is unchanged), and the Pit Edit check in 7.2 is open.

---

### #1970 BUG-1157: Edit Pipe says so when it could not write the level onto the pipe itself

1. **What changes for the drafter.**
   1. **Ordinary pipe: nothing.**
   2. **When the level write onto the pipe really fails:** one command-line line (and the same line in the CE log): "[CE] Warning: the level was not saved on pipe P3-P4 itself. The schedule and plan show the new level, but if its level text is deleted CE will go back to the old one. Check the pipe and run Edit Pipe on it again." (Rules\EditPipeLevelWriteRule.cs lines 21 to 25; printed at Update.cs lines 1880 to 1891.) The save carries on.
   3. **Matches the carpark?** Partly, and honestly said. The carpark asks "return saved / not saved and print 'not saved'". That is built. But see point 7.1: the carpark's own example (a pipe with a damaged record) cannot reach this line.
2. **Settings switch.** `pipe.editPipeLevelWriteSaysWhenNotSaved`, ON (UserSettings.cs line 1484 on the branch). Pinned through both start-up reads in `Bug1157LevelWriteNotSavedTests`. **OFF restores the old behaviour exactly:** the write is the same code, the old `StorePipeInverts(..., bool)` now just calls `TryStorePipeInverts` and ignores the answer (LinkService.Persistence.cs about line 246), and with the switch off nothing is printed. No engineering value hard-coded.
3. **No hard blocks.** None. A line only; no rollback, no refusal (the author left "should a failed write also stop the save?" open, which is correct under R-27).
4. **Protection, REDO and the PROTECTED file (`LinkService.Persistence.cs`).** I read every changed line with care.
   1. **The write itself is unchanged.** Same `ReadPipeLinkData`, same `ResolveStoredInvertWrite`, same `WritePipeLinkData`, same `tr.Commit()`, same log line. Only `return` values were added (lines 256 to 311 on the branch).
   2. **Every other caller is unchanged.** New Pipe, Xcivil import, linked text edits and CDLINK still call the void method. The author's test checks three of those files do not call the new method.
   3. **Locked layers:** still never unlocked. `GetOrCreateLinkDictionary` skips a locked layer and says so in its own line (BUG-254, about line 1027).
   4. **Gap, not a regression:** when `GetOrCreateLinkDictionary` returns nothing (locked layer, a converted pipe with no record store at about line 1069, or any AutoCAD refusal at lines 1098 and 1103), `WriteXrecordString` returns quietly (about line 1301) and `TryStorePipeInverts` still answers **true** ("written"). So the new line does not fire on those paths. The locked-layer path already has its own line; the other two stay as quiet as before (log only). The doc comment and REGRESSION_LOG point 3 say false is returned when "AutoCAD refused it"; that overstates it.
   5. **REDO:** no new write, no new transaction. Safe.
5. **Merge.** REGRESSION_LOG.md with the other two; UserSettings.cs with #1947 (keep both). Merges cleanly with #1892, the other open PR in this protected file.
6. **Tests.**
   1. `ShouldReport` and the line wording are real logic tests; they cannot pass before (new class).
   2. Everything about the write and the Edit Pipe call is **source-text guards** (exact strings in the method body and their order). They prove the code shape, not that a failed write prints the line. No test makes a write fail.
   3. **%APPDATA%:** the class writes nothing; see group fact 7.
7. **Not proven.**
   1. **The carpark's AutoCAD step cannot be done (read from the code, not run).** Opening Edit Pipe on a pipe reads its record through `RequireExactPipeTextAttachmentsInCallerTransaction` (LinkService.Registration.cs line 1919 onward, which calls `ReadPipeLinkData`). A damaged record throws there, and `PipeEditCommand.DataCollection.cs` lines 267 to 281 turn that into a refusal ("PIPE-EDIT-WHY-01"). So Edit Pipe never reaches Save on such a pipe. The line can only fire if the pipe is erased or the record goes bad between opening the window and pressing Save, or AutoCAD throws during the write.
   2. **Robot (CE 02):** do not build a damaged-record case for this; it will be refused at open, not at Save. Run only the control: an ordinary pipe, Edit Pipe, change the downstream level, Save. Right: no "level was not saved" line, and the level is stored (CDAUDIT agrees with the schedule). **Codex look:** not needed.
8. **Verdict: KEEP-WITH-NOTE. Train class: FULL** (protected file `LinkService.Persistence.cs`). Notes for the finaliser:
   1. **Correct two wording lines in the PR's REGRESSION_LOG entry** (wording only, no code): point 3, drop "or AutoCAD refused it" or say "or AutoCAD refused the write itself"; point 9, say the damaged-record step is refused at open, so this line is accepted on the code reading.
   2. **Carpark:** BUG-1157 can be accepted by code review plus the control run; its "Steps to confirm" need rewriting.
   3. **Follow-up, low:** make `WritePipeLinkData` report when it wrote nothing, so the two quiet paths in 4.4 also say so. That is a further protected-file change and belongs in its own PR, not this one.

---

### #1972 BUG-658: the downstream-recalculation question and cascade come after the Edit Pipe change is accepted

1. **What changes for the drafter.**
   1. **Ordinary save with a changed downstream level:** the pipe change is saved first, then the "Recalculate downstream pipe inverts?" box, the preview and the "[CDEDIT-CASCADE] Updated N pipes" line. Behind the box the drawing already shows the new level. Then the arrow or label "move to segment" prompts, then the design-warning panel, in that order (Update.cs lines 1243 to 1266, then 1268 onward).
   2. **Refused save (for example a locked label layer):** the save throws inside the open change, the change is rolled back, and the post-commit block is never reached, so no box and no "Updated" line. I checked that there is no `return` between `UpdatePipeSchedule` (line 541) and the commit (about line 1105); the only exits are the two `throw`s at lines 575 and 938, which roll back.
   3. **Not asked, as before:** Edit 2+ pipes (the batch owns the change), the dry-run preview picture, a reversed pipe direction.
   4. **Matches the carpark?** Yes: "ask and apply after the edit commits, inside the same command (one Undo)".
2. **Settings switch.** `pipe.cascadeQuestionAfterEditCommits`, ON (UserSettings.cs line 1474 on the branch). Pinned through both start-up reads in `Bug658CascadeAfterCommitTests`. **OFF restores the old behaviour exactly:** the hook is null (lines 526 to 536), so `UpdatePipeSchedule` calls `PromptDownstreamCascadeIfInvertChanged` inline (line 1957) as before, and `cascadeQuestionDeferred` stays false so the post-commit block does nothing. The switch is read when Edit Pipe saves. No engineering value hard-coded.
3. **No hard blocks.** None added. The cascade's own preview and refusals are unchanged.
4. **Protection and REDO.**
   1. The cascade is the same `PromptDownstreamCascadeIfInvertChanged` and `ApplyPropagationPlan` code, with its own transaction, as CDPROPAGATE uses. Locked layers, Xrefs and REFEDIT are treated exactly as in today's cascade. Nothing is unlocked.
   2. **The behaviour change the author flagged ("if the cascade throws, the pipe stays saved"):** `ApplyPropagationPlan` (LinkService.RepairAudit.InvertPropagation.cs lines 768 to 1031) already catches its own drawing failure, rolls its drawing change back and puts the schedule record back (`RestoreRecordAfterFailedCascade`), and says "Nothing was changed". So the new catch (Update.cs lines 1252 to 1260) only catches a throw while building the plan or showing a window. Keeping the edited pipe saved there is safe and follows R-27. No question for Tim.
   3. **One-Undo:** the post-commit cascade sits where the existing placement prompts already sit, which the code says are "part of this single CDEDIT command and therefore one AutoCAD Undo step". Read from the code, not seen.
   4. No protected file touched.
5. **Merge.** UserSettings.cs with #1969 (keep both); REGRESSION_LOG.md with #1970. Update.cs auto-merges with #1969, #1970 and #1947.
6. **Tests.** `ShouldAskAfterCommit` and the other cascade decisions are real logic tests. Everything about the order is source-text guards (the post-commit block after the commit, after the "could not confirm" stop and the stale-marker step, before the placement prompts; one inline and one post-commit call). They prove the code shape, not what AutoCAD shows. The existing cascade guards (`C8BatchNoCascadeQuestionTests` and three others) pass per the author. %APPDATA%: the class writes nothing; see group fact 7.
7. **The fault (CHANGE-NEEDED).**
   1. **Where:** Update.cs lines 1246 to 1266. When the save committed but `coordinatedUpdateRecoveryRequired` is true, `ShouldAskAfterCommit` is false and the `else` branch writes only a log line (line 1263, `LoggingService.Diagnostic`).
   2. **What the drafter sees:** "[CE] The pipe edit was saved, but linked-object refresh needs the drawing to be reopened." (line 1234). Nothing says the downstream levels were not recalculated.
   3. **Why it matters:** with the switch OFF (the old order) the cascade ran inside the change and was saved with it, so this is a new quiet path. The edited pipe arrives at the downstream pit at its new level while the pipes below keep the old ones, and nothing on screen says so. Rare (only when CE cannot publish its link changes after a good save), but it is exactly the "silently" that R-27 rules out.
   4. **Fix, exactly:** in that `else` branch also print one command-line line, for example `ed.WriteMessage("\n[CE] The downstream levels were not recalculated. Reopen the drawing, then run CDPROPAGATE from pit " + deferredCascadePipe?.To + " if they need to follow.");` and keep the log line. Better still, only when the downstream level actually changed (the same old-versus-new test `PromptDownstreamCascadeIfInvertChanged` makes at its start), so it is not printed for a save that would not have asked. Add one source guard that the `else` branch writes to the command line.
   5. **Not changed by the fix:** the commit-outcome-unknown path returns earlier (line 1228) with its own "Reopen and inspect" refusal, which already tells the drafter to check the drawing. That is acceptable as it is.
8. **Not proven.**
   1. Nobody has watched the new order in AutoCAD: the box on top of an already-changed drawing, the "Updated N pipes" line, and one U undoing both.
   2. **Robot (CE 02), three cases (the author's names):**
      1. **`N5_658_cascade_after_save`:** pipes P1 to P2 to P3 with levels; Edit Pipe on P1, change its downstream level by 50 mm, Save. Right: the Yes/No box appears with P1's new level already drawn; Yes, then Apply in the preview; one "[CDEDIT-CASCADE] Updated N pipes" line naming every pipe below P1; then U once brings back P1, P2 and P3 together.
      2. **`N5_658_locked_label`:** lock the layer P1's label text sits on, repeat. Right: the save is refused, no Yes/No box, no "Updated" line, P2 and P3 unchanged.
      3. **`N5_658_locked_label_off`:** set `pipe.cascadeQuestionAfterEditCommits` false **before** AutoCAD starts (settings are read at start), repeat case 2. Right: the old order (box before the refusal).
   3. **Codex look:** yes, one look at case 1, because it is the order of a window and a drawing change: screenshot with the box up and the new level visible behind it.
9. **Verdict: CHANGE-NEEDED (the one line in 7.4). Train class: FULL** (changes the order of a transaction, a window and the cascade in Edit Pipe).

---

## Verdict summary

1. **#1969 BUG-1164:** KEEP-WITH-NOTE, Civil area + smoke.
2. **#1970 BUG-1157:** KEEP-WITH-NOTE, FULL (protected `LinkService.Persistence.cs`); fix two wording lines in its REGRESSION_LOG entry; carpark steps need rewriting.
3. **#1972 BUG-658:** CHANGE-NEEDED, FULL; print one command-line line when the downstream question is skipped after a save that needs reopening (Update.cs about line 1263).
