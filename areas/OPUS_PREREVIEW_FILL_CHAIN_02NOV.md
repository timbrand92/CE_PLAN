# Opus pre-review FILL CHAIN: PRs #1562 (BUG-874), #1567 (BUG-963), #1570 (BUG-965), #1558 (BUG-877)

Written Monday 2 November 2026 by an independent read-only Opus reviewer for CE 05 (queue filler 6, job 603, at CE 00's request).
Release tip checked: `claude/rel-20261108a` at cf059dcf (Civil 3.0.90, C-79b1), the newest release branch on GitHub at the time of review.
Heads reviewed: #1562 f119d8e7, #1567 111b8e0a, #1570 92e83fa5, #1558 98006988. All four are DRAFT and OPEN on GitHub, base `claude/rel-20261022m`.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code, the PR descriptions, the carpark entries, the C-62 assembly and finalizer reports, and ran read-only `git fetch`, `git log`, `git diff` and `git merge-tree` only.

## FOR TIM

1. **The big finding: all four fixes are already in your plugin.** They were merged into the C-62 release on 23 October (Civil 3.0.72) and are in every release since, including today's 3.0.90. The four PRs were only left open by mistake on GitHub. This review checks fixes you already have; it does not hold anything back.
2. **#1562, Esc after a CD pipe keeps its callout linked (BUG-874): KEEP-WITH-NOTE, FULL.** Example: you place a pipe with a callout, press Esc at "pick the next pipe", then ERASE the pipe. The callout now goes with it. Before, it stayed behind. Note: if you press Esc partway through the SECOND pipe (for example at a length question), the first pipe's callout can still lose its link. That is a smaller, rarer case.
3. **#1567, CDPROPAGATE puts the right level in a pipe's only IL text (BUG-963): KEEP-WITH-NOTE, Civil area + smoke.** Example: upstream IL hidden, you propagate 9.50 at the downstream pit, and the text now reads "IL 9.50", not "IL 9.60". Note: on an old drawing where CE cannot tell which end that one text belongs to, the whole pipe is now skipped. It keeps its old level and is named in the "could not be updated" line.
4. **#1570, Pit Schedule Refresh keeps "2/375" and the trench grate "3000" (BUG-965): KEEP, Civil area + smoke.** Refresh now writes exactly what the Pit Schedule window shows. A pump pit stays blank instead of "0 x 0". Ordinary and detention pit sizes do not change.
5. **#1558, import review page will not draw the wrong file (BUG-877): KEEP-WITH-NOTE, Civil area + smoke.** Example: you read A.xml, pick B.xml on the review page, and click Read source. CE now draws nothing and tells you to run the command again. Note: the bug entry asked for CE to read B straight away. That part is not done, so you have to run the command a second time.
6. **Merging:** nothing left to merge. Each branch is already fully inside today's release. Merging any of them again changes nothing (I checked this). They only ever clashed in the Settings list and the change log, and that was fixed on 23 October by keeping both entries.
7. **Nobody has opened any of the four in AutoCAD.** All four are built and unit-tested only. All four bugs stay OPEN in the carpark, which is correct. No test touched your real settings.
8. **One housekeeping action for CE 05 or CE 00:** close the four draft PRs with a comment like "merged in C-62 (6f7845ca, 5f2dd188, 1cc11762, 0db7b4e2)". That stops them coming back into review queues. Then put the four AutoCAD checks below on the robot list.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Can each PR be separated from the shared history? Yes, cleanly.** Each branch is: the old base `claude/rel-20261022m`, then a merge of `origin/claude/rel-20261023l` (that merge is the "about 6,600 lines" GitHub shows), then exactly two own commits: the fix and a one-line "Default: on" doc fix.
   1. **#1562:** cda22fb9 then f119d8e7, 8 files, +148 / -4.
   2. **#1567:** 14006793 then 111b8e0a, 5 files, +126 / -4.
   3. **#1570:** c732d63e then 92e83fa5, 4 files, +110 / -3.
   4. **#1558:** 91d8c39d then 98006988, 5 files, +137 / -0.
   All of the above was read with `git diff origin/claude/rel-20261023l...origin/fw2/<branch>`.
2. **Already merged.** Each head is an ancestor of the release tip: `git merge-base --is-ancestor` says YES for all four. The C-62 assembly report (`areas/release-v3-colleagues-TRAIN_C62_ASSEMBLY_REPORT_2026-10-23.md` lines 37 to 40) records plain `--no-ff` merges at the exact heads: #1558 0db7b4e2, #1570 1cc11762, #1567 5f2dd188, #1562 6f7845ca. The first version carrying them is Civil 3.0.72 (f7f7d551, C-62). A `git merge-tree` of each head into the tip gives the tip's own tree (42e2f670), so merging again is a no-op.
3. **Still unchanged on the tip.** The four fix sites are still there on cf059dcf:
   1. `LinkService.Reactors.cs:1432` and `:1567`
   2. `LinkService.RepairAudit.InvertPropagation.cs:1116` (the file has later, unrelated commits for BUG-527, BUG-811 and BUG-1040)
   3. `ScheduleLinkService.cs:2005`, `:2024` and `:2030`
   4. `LinkCommands.ImportXcivil.cs:180` and `:442`
   The four named test files are also still on the tip.
4. **Switch defaults, both start-up reads.** None of the four PRs pins its own default through both start-up reads. Each has only a `new XxxSettings()` test. The C-62 finalizer added `Modules/Drainage.Tests/Services/C62NewSwitchDefaultsTests.cs` on the train. It loads `{}` and a C-61-style file through both `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`, asserts all four switches are ON, and asserts a typed `false` is kept. That fully covers question 2 for all four. All four ship ON. They are bug fixes where the old behaviour is the bug, which matches the finalizer's "ON, KEPT ON" for each (finalizer report lines 13 to 16). None of the four has a row in the Settings window, so turning one OFF means editing CD_Settings.json before AutoCAD starts.
5. **Real %APPDATA%.** No test in the four PRs saves settings. #1570's fixture changes `SettingsService.Current.Linking.ScheduleRefreshKeepsTwinAndTrenchText` in memory and restores it in TearDown. In a test run `SettingsService.Current` reads from the run's temporary folder through `CE_LOG_DIR_OVERRIDE` (`SettingsService.cs` lines 45 to 50 on the #1570 head), not from `%APPDATA%\TIM_CE_CADTOOLS`. The other three only read source files or call pure rules.
6. **Do the tests fail before and pass after?** None of them can be run "before" as written. Each calls a new rule or method that did not exist (`CancelledPlacementRegistrationRule`, `SingleIlTextEndRule`, `RefreshedPitSizeText` / `RefreshedDiameterText`, `ImportReviewSourceGuard`), so before the fix they fail to compile. That counts as a fail, but it is not a red-then-green check of drawing behaviour. The source-pin tests (#1562's handler-order test, #1567's writer test, #1558's "both commands ask the guard") would fail on the old code. I did not run anything. The C-62 finalizer reports the named tests 37 of 37 green and `RedoSafeCallGraphTests` 25 of 25 after #1562.
7. **Protected files.** No PR touches `LinkService.Persistence.cs`, `ProjectDataService.Persistence.cs` or `RulebookEngine.cs`. #1562 changes `LinkService.Reactors.cs` (the command-end and cancel handlers, treated as protected by the carpark lane note). #1567 changes `LinkService.RepairAudit.InvertPropagation.cs` (the carpark says "Protected: yes"). Both were read line by line below.

### #1562, BUG-874: Esc after a placed CD pipe with a callout keeps the callout linked

1. **What changes for the drafter.**
   1. **The scenario:** CD, place a pipe with a callout, press Esc at the next pipe's point prompt. The callout's queued link to its pipe is now written at AutoCAD's "command cancelled" moment, the same way a normal command end writes it. So ERASE or MOVE on that pipe takes the callout along.
   2. **The code:** `OnCommandCancelled` now passes `cancelled: true` (`LinkService.Reactors.cs:1425`). `HandleCommandInterrupted` captures `resumedFromEditor` (`:1542`) before it clears the resume flag. It then calls `ProcessDeferredAttachmentRegistrations` only when the new pure rule allows it (`:1558` to `:1568`; rule in `Rules/CancelledPlacementRegistrationRule.cs`).
   3. **Matches the carpark?** Yes for the main case: "The link is written for every item placed before the Esc". I traced why it works. In CD the next pipe's points are picked (`CdCommand.cs:386`) BEFORE linking is suspended (`:413`), and the first pipe left `ResumeOnNextCommandEnd` set (`:1196`). Esc at that pick therefore reaches the cancel handler with the flag still set. `SuspendRuntimeLinking` and `ClearPendingState` (`LinkService.Cache.cs:822`) never empty the registration queue, so the first pipe's link is still waiting.
2. **Settings switch.** `linking.escKeepsPlacedCalloutLinks`, `UserSettings.cs:481`, default ON, documented "Default: on". The read site falls back to ON. Both start-up reads are pinned by C62NewSwitchDefaultsTests (group fact 4). OFF makes the rule return false, so the queue is cleared exactly as before. That restores the old behaviour exactly. No engineering value is involved (R-00 not engaged).
3. **No hard blocks (R-27).** None added. It is a silent write; nothing stops or asks.
4. **Native protection and REDO.**
   1. **REDO guard:** the rule refuses at U, UNDO, REDO and MREDO, and whenever REDO is still available (`RedoWindowGuard.IsOpen`). It also refuses on a FAILED command; only a cancelled one may write. That is stricter than the normal command-end write at `LinkService.Reactors.cs:777` to `:785`, which checks only the history command, not the REDO window.
   2. **Baseline:** the REDO baseline gains 5 lines under BOTH handlers (`RedoSafeReviewedHooks.baseline.txt`). The note there honestly explains that the static scan cannot see the cancelled-only flag.
   3. **Locked layers:** the write is the same `ProcessDeferredAttachmentRegistrations` (`LinkService.PipeUpdates.cs:47`) the normal end uses. A pipe or callout that no longer exists is skipped. Any error is caught and logged. The same locked-layer and Xref behaviour as a normal CD end applies; nothing is unlocked or bypassed.
   4. **NOT proven, the heart of the "needs Opus review" note:** that a write made inside AutoCAD's CommandCancelled event joins the CD command's own Undo step, so that one U takes pipe, callout and link back together. It also assumes Esc inside a .NET prompt actually raises CommandCancelled for CD and not CommandEnded. The bug's own reference assumes this (carpark BUG-874, "Reactors.cs:1420"), and it is the same pattern the COPY-Multiple Esc path already relies on (`:1580` onward). The code reasoning is sound, but only AutoCAD can prove it. The log line "callout registrations written inside the cancelled command" is the evidence to look for.
5. **Merge and stack.** No stack. It clashed with #1567 in `UserSettings.cs`: both add a property at the top of `LinkingSettings`. `git merge-tree` of the two heads shows that conflict. C-62 resolved it by keeping both (assembly report section 6). It clashes with the other three in `REGRESSION_LOG.md`, resolved by keeping every entry. No function is shared with the other three PRs. Already merged (group fact 2).
6. **Tests.** 8 tests in `Bug874CancelledPlacementRegistrationTests.cs`: the rule's truth table, the switch, and a source pin that the write comes before the queue is cleared and only the cancel handler passes the flag. Two older guard tests were updated on purpose: `LinkServiceCommandPerformanceContractTests.cs:380` now allows exactly one guarded write, and `NativeEditCommandEndRoutingPolicyTests.cs:457`. The finalizer already noted the "failed handler never passes the flag" pin reads only 500 characters. It is weak but harmless, since the whole-method test still guards it.
7. **Notes (not blockers).**
   1. **Gap:** Esc during the SECOND pipe's own prompts, after linking is suspended but before that pipe exists, still loses the first pipe's link. Examples are the detention required-length question or a same-plan break prompt. CD's `finally` then calls `ResumeRuntimeLinking` (`CdCommand.cs:1202`), which clears the resume flag, so `resumedFromEditor` is false at the cancel. That is narrower than the reported bug and worth a carpark line.
   2. **Stale comment:** the old comment just above the new block still says "an in-memory discard only; it opens no transaction". That is no longer true when the rule allows the write.
   3. **Extra work at Esc:** the write runs `RebuildRuntimeCaches` in its `finally` (`LinkService.PipeUpdates.cs:123`) inside the cancel, the same as a normal end. On a big drawing Esc may take as long as finishing CD normally. Not measured.
8. **Robot scenario (CE 02), each on a fresh mm drawing copy.**
   1. **Main case:** CD route-first with Callout label, P1 to P2, Esc at the next-pipe point. Check the log for "callout registrations written inside the cancelled command". ERASE the pipe: the callout is gone.
   2. **Undo and REDO:** U once: pipe, callout and link all come back. REDO: both gone again. Then U and MOVE the pipe: the callout arrow follows.
   3. **Two pipes:** place two pipes, Esc at the third, ERASE the first: its callout goes.
   4. **Nothing placed:** Esc at the very first point: no change, no log line.
   5. **The gap:** a detention pipe as the second pipe, Esc at the required-length question. Record whether pipe 1's callout is still linked; today's code says no.
   6. **Switch OFF:** set OFF before AutoCAD starts; scenario 1 leaves the callout behind.
   **Codex look:** scenario 2 (one U takes all three).
9. **Verdict: KEEP-WITH-NOTE.** Notes: carpark the second-pipe gap and refresh the stale comment. Train class if it were new: FULL, because it runs on every cancelled command in every drawing and writes at a cancel event. Already shipping since 3.0.72.

### #1567, BUG-963: CDPROPAGATE writes a pipe's only remaining IL text with its own end's level

1. **What changes for the drafter.** In `UpdateIlAnnotationsForPipe` (`LinkService.RepairAudit.InvertPropagation.cs`, new block at about `:992` to `:1013`), a pipe with exactly ONE "IL" text now reads which end that text belongs to (first-point or last-point; `Rules/SingleIlTextEndRule.cs`) and writes that end's level. Before, it always wrote the first end's level. With the upstream IL hidden, the text beside the downstream pit now reads "IL 9.50" not "IL 9.60". This matches the carpark's expected behaviour exactly. Pipes with two texts use the same code as before (the `else` branch is the old two lines word for word).
2. **Settings switch.** `linking.propagateWritesSingleIlToItsOwnEnd`, `UserSettings.cs:482`, ON, "Default: on", falls back to ON, pinned through both reads by C62NewSwitchDefaultsTests. OFF goes through the `else` branch, which is the old code exactly. No engineering value is involved.
3. **No hard blocks (R-27): one behaviour to note.** When the one text records no end (an older drawing), the method returns false. The caller (`:799` to `:805`) then skips the WHOLE pipe: no new level in the text, the pipe record or the schedule. It adds the pipe to the list in "N pipe(s) could not be updated and still show their old levels ... Check those pipes before you issue the drawing" (about `:905`).
   1. **Why I do not count it as a hard block:** it is per pipe, nothing stops, and the pipe is named.
   2. **Two things differ from the PR's wording.** The switch note (`UserSettings.cs` doc lines) says the text "is left alone", but in fact the pipe's level is not changed either, so the rest of the cascade goes ahead around a pipe left at its old level. And the log line still blames "most often a locked layer" (`:803`), which the finalizer already flagged. That wording is in the log only; the line Tim reads at the command line is plain.
   3. **Not counted:** how many real drawings have single IL texts with no recorded end.
4. **Native protection and REDO.** The write still goes through the BUG-657 all-or-nothing gate. `CanWriteIlAttachment` opens the text for write first, so a locked layer still refuses the pipe without half-writing it. No new transaction and no new event hook. CDPROPAGATE is an ordinary user command, so REDO is not affected. This is a protected file; the change is confined to choosing which value goes into the one text.
5. **Merge and stack.** It clashed with #1562 in `UserSettings.cs` (top of `LinkingSettings`) and with all the others in `REGRESSION_LOG.md`. Both were resolved in C-62 by keeping both. No function is shared with the other three. Already merged.
6. **Tests.** 6 tests in `Bug963SingleIlTextEndTests.cs`: the rule for each end, either clue being enough, an unknown end never guessed, the switch, and a source pin on the writer. The drawing write itself is not driven (needs AutoCAD), as the PR says. The source pin reads a fixed 4,200 characters of the method; later edits on the train have not broken it (the file is on the tip with the pin).
7. **Robot scenario (CE 02).**
   1. P1 to P2, 10 m, IL 10.00 / 9.90; Edit Pipe, hide the first IL; CDPROPAGATE from P2 with 9.50: the text beside P2 reads IL 9.50, and the schedule agrees.
   2. Both ILs shown: both change as before.
   3. Hide the LAST IL: the text beside P1 gets P1's level.
   4. An older drawing whose single IL text predates end-recording (if the robot has one): the pipe is named in the "could not be updated" line.
   5. U after each: one U restores text, record and schedule.
8. **Verdict: KEEP-WITH-NOTE.** Notes: correct the switch note so it says the whole pipe is skipped, not just the text. Replace "most often a locked layer" with the real reason when the end is unknown. Consider the nearer-pit position as a second clue so older drawings are not skipped. Train class: Civil area + smoke. Already shipping since 3.0.72.

### #1570, BUG-965: Pit Schedule Refresh keeps the twin "2/" prefix and the trench grate length

1. **What changes for the drafter.** Refresh of a placed Pit Schedule now builds the pit-size cell with `PitScheduleBuilder.BuildPitSize`, the window's own text (`ScheduleLinkService.cs:2005`, new helpers at about `:2624` to `:2637`). The diameter cells use `PitScheduleBuilder.FormatScheduleDiameter` with the twin flag (`:2024`, `:2030`).
   1. **Result:** twin detention stays "2/375", a trench grate shows "3000", and a pump pit ("PUMP STATION") is blank.
   2. **Unchanged sizes:** I compared old `BuildPitSizeText` (`:2639`) with `BuildPitSize` (`PitScheduleBuilder.cs:49`). They are character for character the same for ordinary and detention pits, so those cells do not change.
   3. **Matches the carpark?** Yes, exactly ("keeps exactly what the Pit Schedule window shows").
   4. **Wider than Refresh, and better for it:** the same `BuildCellText` feeds the cell-edit checks when the table is MOVEd, gripped or typed into (`:217`, `:245`, `:271`). A MOVEd table's "3000" or "2/375" cell now matches what CE would draw, instead of looking hand-edited. A typed bad diameter is now put back to "2/375" rather than "375".
2. **Settings switch.** `linking.scheduleRefreshKeepsTwinAndTrenchText`, `UserSettings.cs:698`, ON, "Default: on", both read sites fall back to ON, pinned through both reads by C62NewSwitchDefaultsTests. OFF returns `BuildPitSizeText(pit)` and `FormatScheduleDiameter(FormatDiameter(d), false)`. `FormatDiameter` (`:3613`) never returns null and always trims, so with OFF the text is exactly the old text. No engineering value is hard-coded; the trench grate length is the pit's own recorded `TgLengthMm`.
3. **No hard blocks (R-27).** None.
4. **Native protection and REDO.** It only changes the TEXT chosen. Locked layers, cells copied from other drawings (`EditedCellMayChangeRecord`) and overrides are all checked earlier and unchanged. No new write path.
5. **Merge and stack.** The property sits further down `LinkingSettings` (`:698`), so it did not clash with #1562 or #1567 there. It clashes only in `REGRESSION_LOG.md`. No shared function. Already merged.
6. **Tests.** 7 tests in `Bug965ScheduleRefreshTwinTrenchTests.cs`, including a switch-OFF test pinning "375" and "300 x 300". The fixture is `internal sealed`, which is common in this test project (74 such classes on the tip). It restores the in-memory switch in TearDown and writes no file.
7. **Small, not this PR's fault.** The window's pipe text goes through `GetPipeDiameterDisplay(pipe, db)` (`PitScheduleBuilder.cs:1121`), which knows the drawing. Refresh uses the plain record number. They should only differ on odd unit cases. Not checked.
8. **Robot scenario (CE 02).**
   1. Place a schedule with a twin 375 detention pipe, a trench grate (TgLengthMm 3000, 300 x 300), an ordinary 600 x 600 pit, a detention pit and a pump pit.
   2. Press Refresh: "2/375", "3000", "600 x 600", the detention two-line size and a blank pump pit all stay.
   3. MOVE the whole table: no cell changes and no "put back" message.
   4. Type "2/450" in a diameter cell: it goes back to "2/375" with the not-a-number line.
   5. Switch OFF before start-up: Refresh gives "375" and "300 x 300".
9. **Verdict: KEEP.** Train class: Civil area + smoke. Already shipping since 3.0.72.

### #1558, BUG-877: import review page no longer draws the first file after another is chosen

1. **What changes for the drafter.** In CDIMPORTXCIVIL (`LinkCommands.ImportXcivil.cs:179`) and CDIMPORTLANDXML (`:438`), when the review page closes with Continue, CE compares the file now chosen in the window with the file it actually read: `windowSourcePath` (`:76`) or `xmlPath`. If they differ (ignoring case and a trailing slash), CE prints "you chose a different file (B.xml) after CE had read A.xml. Nothing was drawn ... Run CDIMPORTLANDXML again" and returns false at the pre-flight gate, so nothing is drawn.
   1. **Matches the carpark?** Half. The bug's expected behaviour is "A source change starts a fresh read; acceptance is bound to the file that was reviewed." The second half is done: acceptance is bound to the reviewed file. The first half is not done: CE refuses instead of reading B. The PR says so plainly ("Not re-reading B in the same window (needs a read loop)").
2. **Settings switch.** `xcivilImport.importReviewRefusesChangedSource`, `UserSettings.cs:2712`, ON, "Default: on", both read sites fall back to ON, pinned through both reads by C62NewSwitchDefaultsTests. OFF makes the guard return false at once, so the old path (draw the first file) is exact. No engineering value is involved.
3. **No hard blocks (R-27).** This IS a stop. I judge it acceptable as it stands. The only alternative today is drawing the wrong file, which is worse. It is a command-line message, not a modal box, and the drawing is untouched because the gate is before any write, as `ImportXcivil.cs:158` to `:161` and `:221` say. But it costs the drafter a second run. The proper end state is the fresh read the carpark asks for, and that should be carparked as a follow-up so this stop does not become permanent.
4. **Native protection and REDO.** It stops before anything is written, so there are no locked-layer or REDO effects. Xcivil "Replace previous import" is asked before the review. The deletion happens inside `XcivilImportService` after the gate, so "your drawing has not been changed" holds. I read the comments and the order of calls; I did not trace the deletion into `XcivilImportService` itself.
5. **Merge and stack.** The property is in `XcivilImportSettings` (`:2712`), so there is no clash there. It clashes only in `REGRESSION_LOG.md`. No shared function. Already merged.
6. **Tests.** 7 tests in `Bug877ImportReviewSourceGuardTests.cs`: refuse on a different file, accept the same file in any case or with a trailing slash, switch OFF, no path never refuses, message wording, switch default, and a source pin that both commands ask the guard. The guard is a new class, so the tests could not run before (compile fail).
7. **Unchecked.** The C-62 finalizer asked whether "Import aborted at pre-flight gate" prints as well as the new line, so the drafter would read two messages. Not checked in AutoCAD.
8. **Robot scenario (CE 02).**
   1. CDIMPORTLANDXML: pick A.xml, Continue; on the review page choose B.xml, click Read source. Nothing drawn, one message naming both files, and no second "aborted" line (record if there is).
   2. The same with CDIMPORTXCIVIL and two DWGs.
   3. Read A and click Import without changing the file: imports as before.
   4. Pick "A.XML" in a different case for the same file: imports.
   5. Switch OFF before start-up: the old behaviour (A drawn).
9. **Verdict: KEEP-WITH-NOTE.** Note: carpark the fresh-read half of BUG-877 (read the newly chosen file in the same window) so the refusal is temporary. Train class: Civil area + smoke. Already shipping since 3.0.72.

### What is NOT proven (all four)

1. **AutoCAD:** none of the four has been driven in AutoCAD by anyone: no robot PASS, no Codex PASS, no Tim test. That holds although they have been installed since Civil 3.0.72. The carpark entries are correctly still OPEN. The audit chunk files that call them "ALREADY-FIXED" (`areas/AUDIT/AUDIT_CLASS_CHUNK14_02NOV.md` items 45 and 48, `AUDIT_CLASS_CHUNK16_02NOV.md` items 13 and 15) mean "merged", not FIXED under the ledger rule.
2. **#1562 one-U grouping:** that a write at AutoCAD's cancel event joins CD's Undo step, and that Esc in CD raises the cancel event at all. Both are reasoned from the code, not seen.
3. **#1567 old drawings:** how many older drawings have single IL texts with no recorded end, and so would now have the pipe skipped.
4. **Tests not run:** I ran no tests. The pass counts quoted come from the PR descriptions and the C-62 finalizer.
