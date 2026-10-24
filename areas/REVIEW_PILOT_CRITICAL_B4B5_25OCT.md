# Independent review: pilot-critical batch 4 and batch 5 PRs, Sun 25 Oct 2026

Reviewer: Opus 5.5, independent (did not build these). Method as `REVIEW_PILOT_CRITICAL_B2B3_24OCT.md`. Base `origin/claude/rel-20261025o` at `2c805a39` (Civil 3.0.75 / Manager 1.1.75). Every PR read at its live head from gh at 09:07, not from its text. All eleven are single commits sitting straight on the base, all still OPEN and draft.

## ANSWER FIRST

1. **Counts:** MERGE 11, MERGE-WITH-FIXES 0, HOLD 0, REJECT 0 (eleven PRs: five from batch 4, six from batch 5).
2. **C-66 candidates, ranked by value (live heads read from gh at 09:07):**
   1. **#1778** `ef77892c`, BUG-1137 (DATA LOSS, AutoCAD 2022 to 2024): one downpipe in a COPY no longer stops every copied pit getting its own number and schedule row.
   2. **#1775** `336ecd4d`, BUG-1168 (time lost to the office): the job-time folder is looked for again at each start, not fixed on the first one.
   3. **#1773** `3056e661`, BUG-1188 (WRONG ANSWER): a LandXML pipe with no grade no longer prints "AT 1 IN 100".
   4. **#1770** `67e50f68`, BUG-1101 (WRONG ANSWER): CDCALC Catchments opens empty at the office Tc, not with a made-up 500 m2 at 15 minutes.
   5. **#1772** `a2fa4e3a`, BUG-1097 (missing check): the Charged System tab warns when the available head is under the 300 mm minimum.
   6. **#1769** `ce1f54c5`, BUG-1179 (WRONG ANSWER on the status): a damaged office approval file no longer shows "CE is current."
   7. **#1771** `f3f38c24`, BUG-1090 (say Unknown): CDRULES and the computations sheet say the hydraulic grade line was not calculated. **Needs Tim's yes first (question 1).**
   8. **#1776** `39af7748`, BUG-1202 (daily tool): the weekly time export no longer holds up AutoCAD's start.
   9. **#1777** `874f0e61`, BUG-1151 (daily tool, 2022 to 2024): moving a pit names the CE pipe objects that stayed behind.
   10. **#1774** `b3c788a9`, BUG-1180 (wording): Drawing Repair no longer says "Nothing has been changed" after a repair.
   11. **#1768** `a3a472b2`, BUG-1215 (wording): the Feedback Help page describes the real Send report button.
3. **Safe for C-66 without Tim:** ten of the eleven (all except #1771). **#1771 needs Tim's word** only because its sentence prints on every computations sheet that goes to council.
4. **Tim's questions (two):**
   1. **#1771, the sentence printed on every computations sheet:** "Hydraulic grade line and pit losses: not calculated by CE. Each pipe is checked full-bore on its own grade only; where the council asks for a hydraulic grade line, check it separately."
      - **Recommendation:** yes, print it. Without it a Frankston, Banyule or Whitehorse reviewer can read the sheet as a full hydraulic check.
      - **On a job:** every OSD computations sheet gains this one line at the end of BASIS OF DESIGN, for every council.
      - **If Tim wants it shorter:** drop the middle sentence ("Each pipe is checked full-bore on its own grade only"). The sheet itself shows no pipe checks, so a reviewer may ask where that check is.
   2. **#1772, which head the 300 mm minimum (R-13) means:**
      - **As built:** the warning uses the head typed in "Available head (m)", as the audit example does.
      - **The alternative:** the head left after the pipe losses.
      - **Recommendation:** keep it as built. It is a warning only and never blocks.
      - **On a job:** typing 0.25 m warns "Available head 250 mm is under the 300 mm minimum for a charged system (R-13)." The flow results still show.
5. **Protected files:** checked on the combined tree against the base. All eleven leave CE_SHARED, the Installer, signing, deploy, version and PackageContents files untouched.
6. **No new hard block (R-27):** every change warns or says a line and carries on.
7. **Switch rule:**
   - **Six new switches:** all six guard a bug fix and ship ON, which is correct. They are `detention.catchmentsStartBlank`, `detention.chargedMinHeadWarning`, `xcivilImport.importedPipeNoInventedGrade`, `jobTime.detectDataFolderEachStart`, `jobTime.weeklyExportInBackground` and `linking.copyContinuesWhenDownpipeCannotFollow`.
   - **Tested defaults:** each PR tests that a new file and an older settings file load its switch ON.
   - **Settings rows:** none has a Settings page row (R-00 home still owed, same as the C-61 to C-65 switches; window lane).
   - **Without a switch:** five PRs have none, which is accepted. Four only make a sentence true or say what already happened (#1768, #1769, #1774, #1777). In #1771, switching off would only bring back the silence.
8. **Report claims checked (RULES 6.1):**
   - **Test counts, all correct but one:** 3, 7, 8, 3, 7, 8, 6, 5 and 6 tests match. The test file of #1774 adds 1 test.
   - **The one wrong count:** #1776 has **12** test cases, not the 13 the batch 5 report and the PR's log entry say. Cosmetic.
   - **Heads, base and files:** all match the reports.

## Checks I ran

1. **Combined tree:** base plus all eleven PRs merged locally in `C:\ce-rv\b` (private worktree, removed at the end). Nothing was pushed.
   - **Clashes between the eleven:** `REGRESSION_LOG.md` in every pair (keep both sides).
   - **One real text clash:** `UserSettings.cs` between **#1770 and #1772**. Both add a switch at exactly the same spot, straight after `defaultTcMinutes`. Keep both blocks; I did that and both switches are present.
   - **Files touched twice (product code):**
     - `UserSettings.cs`: #1770, #1772, #1773, #1775, #1776 and #1778.
     - `JobTimeUserSettings` (inside that same file): #1775 and #1776, which merged by themselves.
     - **No other product file is touched twice.**
2. **Builds and tests:** two `dotnet test` runs, Release, net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, with the C-62 reference paths and the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, private worktree only). The shared build lock was taken each time. C: had 17 GB free. No bundle written, nothing deployed.
   - **Manager:** 28 of 28 pass. That covers Bug1179 (7), DrawingRepairViewModelTests and the release-status and approval classes.
   - **Civil, focused:** 1,397 of 1,397 pass. That covers every new class plus the classes the PRs edited or lean on: CDCALC window, catchments, persistence, computations sheet, C4 golden sheets, rulebook, settings, new-switch defaults, job time, X-Civil, LandXML, unloaded pipe objects, pit moves, clones.
   - **New classes alone, counted one by one:** FeedbackHelpWording 3, Bug1101 8, Bug1090 3, Bug1097 7, Bug1188 8, Bug1168 6, Bug1202 12, Bug1151 5, Bug1137 6. All pass.
3. **Full suites: NOT run** (only the focused classes). net48 not built or run by me; the builders report a net48 compile with 0 errors for each PR.
4. **RED (each test fails without its fix):** checked by reading, as before.
   - **#1768 and #1774:** fail on the base text. The base Help line still says "separate from sending" and "Save report"; the base banner still says "Nothing has been changed".
   - **The other nine:** call members that do not exist on the base, so they do not compile there. That is a weaker proof than a failing run.
   - **Where the old behaviour is pinned by switch OFF:** #1770, #1772, #1773, #1775 and #1776 each have a switch-OFF case that shows the old behaviour still runs on the old path.
   - **#1777 and #1778:** proven only by the pure rule and a source guard that the real path calls the rule. The real 2022 to 2024 path is not exercised by any test (see "What I did NOT check").
5. **Conflicts with other open PRs:**
   - **Scope:** the repo has over 1,000 open PRs. I checked the newest 300. Of those, 62 touch a file these eleven touch.
   - **50 of the 62 are already contained in the base** (nothing ahead of it, still open). Examples: #1748, #1647, #1655, #1757, #1758, #1760, #1763 to #1765. The desk may want to close them as done; I did not touch them.
   - **The other 12:** I trial-merged each onto the base and onto the combined tree. **None gains a new clash from batch 4 or 5.**
   - **#1534:** clashes with the base on its own, in files these eleven do not touch.

## One item per PR

1. **#1778 BUG-1137 (HIGH, DATA LOSS): one downpipe in a COPY no longer cancels the clean-up for every pit and pipe. Verdict MERGE. Safe for C-66.**
   - **Cause is real:**
     - **The shared write:** in `LinkService.Utilities.cs` the downpipe ("source") copies go through the same transaction as the pits and pipes.
     - **What throws:** `RemapCloneSourceInTransaction` throws "Source COPY requires one exact AutoCAD placement map" when the 2027-only copy record (`ActualHandleMap` / `SourceFullHandleMap`) is missing or pairs wrongly.
     - **The result:** the throw kills the whole commit. On 2022 to 2024 the record never exists.
   - **The fix is the smallest safe one:**
     - **Same test, earlier:** `CloneSourceCopyRule.CanBeCompleted` makes exactly the same two `MapsExactly` checks the write makes first. A downpipe it rejects is a downpipe the write would have refused.
     - **Where it runs:** those downpipes are removed from the work before the transaction. The pits and pipes then go through the unchanged code.
     - **On 2027:** with a good record, nothing changes.
   - **Things I checked:**
     - **Joint-pit handling:** the "jointly copied pit" step and its readback both read the same (filtered) list, so a removed downpipe cannot trip them.
     - **Owned attachments:** they are collected from pipes only, so nothing owned by the removed downpipe is half-renamed.
   - **The downpipe copy:** it is left exactly as the base leaves it today (as AutoCAD copied it), so this is not a new state.
   - **Redo, locked layers:** less is written than before, inside the same command-end clean-up. Nothing writes between U and REDO. No layer is unlocked.
   - **Wording:** the line starts "[CE]" and is plain. "Check the copied downpipe on the drawing" is vague, but no better instruction exists on 2022 to 2024 (BUG-1209 stops direct re-placing there), so I accept it.
   - **Limits (as the PR says):**
     - **Still stopped:** a rotated or scaled COPY of a downpipe, and a locked downpipe label layer on 2027, still stop the whole write.
     - **MIRROR:** untouched.
     - **No proof in AutoCAD:** none of this is proven on a real 2022 to 2024 drawing.

2. **#1775 BUG-1168 (time not reaching the office): the job-time folder is looked for again at each start. Verdict MERGE. Safe for C-66.**
   - **Cause is real:** on the base, the `CivilJobTimeSettings.DataFolderPath` getter saved whatever `DetectDefaultDataFolder()` returned on the first call, including the local AppData fallback, for good.
   - **The fix:** `JobTimeDataFolderRule.Resolve`.
     - **A saved (chosen) folder always wins.**
     - **Nothing chosen:** CE looks once per AutoCAD session and does not save.
     - **Switch OFF:** the old save.
   - **Readers and writers:** I checked every one of the folder. All go through the getter, and no product code calls the setter.
   - **Threads:** the static per-session value is shared with #1776's background export. The race is harmless (both look up the same folder).
   - **Settings saves:** `SettingsService.SaveSettings` is locked, so a save from the background thread (switch OFF only) is safe.
   - **Tim's PC:** it already saves the OFFICE folder (`...Creative Engineering - Drafting\CE_CVL_SUITE`, read from `CD_Settings.json`), so nothing changes for Tim.
   - **Limits, for the desk:**
     - **Already stuck:** a colleague PC that already SAVED the local folder stays on it. At each colleague install, check `jobTime.dataFolderPath` in `CD_Settings.json`.
     - **Old time stays local:** time already logged locally is not moved.
     - **Split sessions:** a session started before OneDrive is ready still logs locally for that session.

3. **#1773 BUG-1188 (HIGH, WRONG ANSWER): a LandXML pipe with no grade is no longer labelled "AT 1 IN 100". Verdict MERGE. Safe for C-66.**
   - **Cause is real:** `XcivilLayerRecognition.BuildImportedPipeDisplayText` filled an empty grade with "100".
   - **The fix:** with no grade, the plain, suspended and detention labels (both builders) leave the grade clause off. A grade from the file is kept.
   - **Stored data agrees:** `BuildImportedPipeData` already stores such a pipe as grade mode "default" with `ShowGradeInText = false`. So the label and the stored data now agree, where before the first label and a later relabel disagreed.
   - **Also changes:** the X-Civil DWG import through the same builder (Mike's layer-name route). That is the same wrong answer, so it is in scope.
   - **Limit, worth a carpark line:** `XcivilLayerRecognition.cs` line ~603 still sets `gradeValue = "100"` for a `CI-STRM-DRAN-INVT-N` layer in the X-Civil DWG route. That is a second invented 1 in 100, not touched here.
   - **Not done (as the PR says):** a "grade missing" line in the import review window.

4. **#1770 BUG-1101 (WRONG ANSWER): CDCALC Catchments opens with no rows and the storm at the office Tc. Verdict MERGE. Safe for C-66.**
   - **Cause is real:** the constructor seeded "C1, 500 m2, C 0.9" and the duration index was fixed at 15 minutes.
   - **The fix:**
     - **Opening:** the window passes the switch, and the tab opens empty with the total "Unknown".
     - **Storm:** duration at the nearest rung to the office Tc (`RationalFlowService.OfficeDefaultTcMinutes`). Return period at the office storm (`detention.defaultPsdAriYears`).
     - **No-argument constructor:** still seeds the old row, so the 50 older tab tests stand.
   - **Checked: the storm return period is the right one.** CE already uses that same Settings value as the minor-flow storm (BUG-251, `RationalFlowService.PsdAriYears`, "the ONE place the minor flow ... read it"). With default Settings the storm is 1 in 5, as before.
   - **Existing tests edited:** seven older tests that read row one now add the row first. The PR says so, and each edit is one line.
   - **Limits:**
     - **Add still seeds:** clicking Add still gives a typed-in 500 m2 and C 0.9 row (BUG-544).
     - **Council storm:** not used when the tab opens (needs Tim, as the report says).
     - **Off-ladder Tc:** an office Tc that is not on the ladder rounds to the nearest rung (a Tc of 7 gives 5 min).

5. **#1772 BUG-1097 (missing check): the Charged System tab warns when the available head is under the minimum. Verdict MERGE (Tim question 2). Safe for C-66.**
   - **Cause is real:** `ChargedSystemCalcViewModel.Recalculate` never compared the head with `DesignStandards.ChargedMinHeadMm`.
   - **The fix:** one more warning, built from the same Settings value CDRULES prints for R-13. I checked it is the only reader, so there is one source.
   - **Warns, never blocks:** results still show.
   - **No false warning on blanks:** a blank or non-number head adds nothing new (the existing "must be numbers" line covers it).
   - **Wording:** plain. "(R-13)" is the same rule tag CDRULES shows.
   - **Not done (as the PR says):** the Settings box and project override (BUG-546), the CDRULES R-13 line, and Tim's question 2.

6. **#1769 BUG-1179 (WRONG ANSWER on the status): a damaged office approval file no longer shows "CE is current." Verdict MERGE. Safe for C-66 (Manager change: the Manager version needs its bump).**
   - **Cause is real:** `CeApprovedReleaseService.GetApprovedReleases` caught the bad file and left the module out. `ComputeHealth` then fell through to "CE is current." because the office folder was reachable.
   - **The fix:**
     - **The read:** records which plugin's file could not be read (a parse error, or a file that reads as nothing).
     - **The status:** names only modules installed on this PC, keeps the normal colour, and lets a valid update elsewhere still win first.
     - **The damaged file:** never touched (tested).
   - **Shared state:** the "unreadable" list is static state set on every read. Every product caller reads the same office root, and `Poll` reads it straight after its own read (arguments run left to right). The Manager tests that touch it are not run in parallel.
   - **Limit:** a file that is valid but empty (`{}`) still counts as "no approval", not "unreadable". That is a rare edge.

7. **#1771 BUG-1090 (say Unknown): CDRULES and the computations sheet say the hydraulic grade line was not calculated. Verdict MERGE. NOT for C-66 until Tim answers question 1.**
   - **Cause is real:** no hydraulic grade line, energy line or pit-loss code exists in Civil (I grepped). The "not evaluated here" list and BASIS OF DESIGN said nothing.
   - **The fix:**
     - **CDRULES:** one row added to `RulebookEngine.NotEvaluatedHere`, so CDRULES prints and saves it through the existing loop.
     - **The sheet:** one line at the end of BASIS OF DESIGN.
     - **Golden sheets:** the two golden sheets gain that line, said in the log.
   - **Cosmetic, optional:** the new constant was inserted between `NotEvaluatedHere` and its own doc comment. The list's comment now sits on the constant. No effect on behaviour.
   - **Limit:** it shows for every council. Raising it to a Warn needs a council-profile value that does not exist yet (R-00).

8. **#1776 BUG-1202 (daily tool): the weekly time export no longer holds up AutoCAD's start. Verdict MERGE. Safe for C-66.**
   - **Cause is real:** `CivilJobTimeService.Initialize` ran `CheckAndGenerateWeeklyExport` inline. The comment said "non-blocking" but it was not.
   - **The fix:**
     - **Background:** one background task, and errors go to the CE log.
     - **Fewer files opened:** a sheet whose month cannot hold the week is skipped. A name without a month is still read.
   - **Safe off AutoCAD's thread:** the export touches files and settings only, never AutoCAD.
     - **Logging:** the CE log only queues messages.
     - **Settings save:** it is locked.
   - **Recommended follow-up (not blocking):**
     - **New overlap:** the export now runs at the same time as drafting. The export's `File.ReadAllLines` skips a sheet on any read error, so if the time logger is appending to the current month's sheet at that exact moment, that person's rows are left out of that week's export.
     - **Why it stays out:** the marker is still written, so the export is not redone that week.
     - **How likely:** the window is milliseconds and the logger itself retries.
     - **The fix:** reuse the logger's 3-try `RetryFileOp` on the read.
   - **Not done (as the PR says):** remembering an empty "nothing to export" check.

9. **#1777 BUG-1151 (daily tool, 2022 to 2024): moving a pit names the CE pipe objects that stayed behind. Verdict MERGE. Safe for C-66.**
   - **Cause is real:** in `MoveLinkedPipes`, a pipe that `OpenPipeForShapeChange` cannot open was skipped with a bare `continue`.
   - **The fix:**
     - **Collecting:** a CE pipe object held as a proxy (the same `IsUnloadedCePipeObject` check as BUG-1138, now on the base) is noted, read only.
     - **Saying it:** the line is said once by `ReportPipesLeftOnLockedLayer`. I checked that all four pit and block move paths call it after `MoveLinkedPipes`.
     - **Other reasons:** any other reason a pipe cannot be opened is left as before.
   - **Wording:** starts "[CE]", names up to three pipes, says why, says what to do, and says "U undoes the move". Its advice matches the existing BUG-1138 line.
   - **Redo, locked layers:** no drawing write is added.
   - **Limit:** the real proxy case needs AutoCAD 2022 to 2024 without the add-on. Tim's PC cannot show it.

10. **#1774 BUG-1180 (wording): Drawing Repair's note is true before and after a repair. Verdict MERGE. Safe for C-66 (Manager).**
    - **Cause is real:** `ReadOnlyBanner` was fixed text: "Nothing has been changed. Inspect only looks."
    - **Now:** "Inspect only looks. Fix it changes the drawing." The button really is "Fix it" (`DrawingRepairPage.xaml`). Project QA's own note is untouched.

11. **#1768 BUG-1215 (wording): the Feedback Help page describes the real Send report button. Verdict MERGE. Safe for C-66.**
    - **Checked against the real dialog:** `FeedbackDialog.xaml` has only "Send report". `FeedbackCommand.ResultLine` really says "sent to the office feedback folder", or "Saved on this PC only ... Email this file", so the new Help text is true.
    - **No other copy of the old text:** none in shipped files. Only old design mock-ups under `docs/design` mention "Save report".

## Train

1. **One install, one payload (RULES 8.5):** the ten safe PRs together, plus #1771 once Tim says yes. Merge order does not matter.
   - **Keep both sides:** `REGRESSION_LOG.md` each time.
   - **Keep both blocks:** `UserSettings.cs` when #1770 and #1772 meet.
2. **New-switch defaults test for C-66:** pin these six ON: `detention.catchmentsStartBlank`, `detention.chargedMinHeadWarning`, `xcivilImport.importedPipeNoInventedGrade`, `jobTime.detectDataFolderEachStart`, `jobTime.weeklyExportInBackground`, `linking.copyContinuesWhenDownpipeCannotFollow`.
3. **Manager changes:** #1769 and #1774 change Manager code, so C-66 needs the Manager version bump as well as Civil's. CE_SHARED is unchanged, so no Shared sync is needed.

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing was opened in AutoCAD by me. Built and unit-tested only. Nobody has seen any of these eleven work in AutoCAD.
   - **Two need a 2022 to 2024 PC:** #1778 and #1777 can only be proven on AutoCAD 2022 to 2024 (and #1777 also needs a PC without the pipe add-on). Tim's PC (2027 with the add-on) shows no change for either.
2. **Full suites and net48:** the full Civil and Manager suites were not run on the combined tree. net48 was not built by me.
3. **RED:** proven by reading only. Nine of the eleven "fail on the base" only because they do not compile there. No deliberately broken variant was run.
4. **Conflicts:** checked only against the newest 300 of the 1,000+ open PRs, by trial merge (text clashes), not by meaning.
5. **The skipped bugs:** the bugs both reports skipped (BUG-901, 902, 903, 905, 907, 866, 1096, 1171, 1209, 1210, 1170, 648, 525) and the BUG-1173 document fix were not reviewed. BUG-1052/1053 (#1727, #1716) were not reviewed either.
