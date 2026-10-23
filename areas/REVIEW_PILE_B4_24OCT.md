# Opus review of the PR pile, batch 4 (class E, positions 31 to 42), Sat 24 Oct 2026

Headless job, desk plan/03, Team (Opus 5.5). Started 05:14 Melbourne time. Read only: no build, no test run, no AutoCAD, nothing pushed to a PR branch, nothing merged, closed or labelled. My own copy of the repo was `C:\ce-tr\b4rev.git` (borrows objects from the local clone, which was only read).

Input: `areas/PR_PILE_TRIAGE_2026-10-24.md`, class E, items 31 to 42: #1167, #1207, #1212, #1215, #1216, #1217, #1219, #1221, #1225, #1229, #1230, #1231. None has a `REVIEW_*.md` entry, so none was skipped.

Compared against: installed Civil 3.0.72 / Manager 1.1.72 = `claude/rel-20261023m` f7f7d551; installed Structural 1.0.122 = `claude/rel-20261023s` e6d597c0; planned C-63 = `claude/rel-20261024m` 28987b73; S-43 = PRs #1695 to #1699.

## ANSWER FIRST

1. **Counts:** 0 MERGE, 3 MERGE-WITH-FIXES, 1 HOLD, 8 REJECT.
   1. **MERGE-WITH-FIXES:** #1167, #1225 (Civil, next Civil train C-64), #1212 (Structural, after #1142, next Structural train S-44).
   2. **HOLD:** #1207.
   3. **REJECT, already done another way in the installed code:** #1215, #1216, #1217, #1219, #1221, #1229, #1230, #1231. These can be closed (Tim's call; I closed nothing).

2. **The triage report was wrong about these 12:** it says "not reviewed". In fact all 12 already have an Opus verdict in `release-v3-colleagues-REVIEWLANE_LOG.md`: round 10 on 12 Oct (entries 972 to 978) and round 11 on 20 Oct (#1167, #1212). The triage report missed this log for older PRs. This report gives verdicts on the current heads and says where they differ from the earlier ones.

3. **Top faults:**
   1. **Eight of twelve are stale (two weeks old).** The installed code already fixed the same bugs through the HUNT fixes of 9 to 10 Oct. Merging them now would undo or duplicate installed work.
   2. **#1221 would break the build.** Its text merges cleanly except the log, but it adds the two SPS label height settings a second time. Installed code already has them, so CE would not compile.
   3. **#1207 only half works.** Its switch makes CE read lintel tolerances from inside the drawing, but nothing ever writes them there. Switch it ON and a job's own lintel tolerances quietly vanish. The "schedule places" half is not connected to anything.
   4. **#1225 (privacy) still leaks part of a drawing name with spaces.** "Smith House Stage 2.dwg could not be opened" goes to the office report as "Smith House Stage [drawing name removed] could not be opened". I tested the pattern myself.

4. **Safe to merge today, as is:** none. Closest is **#1167**: one small wording fix, and two keep-both conflicts in the Settings file and the log.

5. **Nothing here touches** installer or signed-update files or CE_SHARED. No new hard block. No change to an automatic (idle or start-up) path that writes to the drawing, so nothing writes between a U and its REDO.

---

## Per PR

1. **#1167 @ f2669fa9 (BUG-555 + BUG-491 A8, Civil, privacy): MERGE-WITH-FIXES, train C-64.**
   1. **Cause real:** yes, still in installed code. `CdHelpService.OpenContextHelp` opens the command's web address in a browser whenever the local guide is missing (`HelpLauncher.cs` step 2). Also `BlockService.cs` lines 2329 and 2475 write every attribute's text to the log (pit names, title-block addresses). The log goes into the support zip.
   2. **Fix does only that:** yes. New Settings group `help.openWebFallback`, default OFF, so no browser opens. The fix is ON by default, because OFF is the privacy-safe side. The log now keeps the tag and the length only. Other log lines with values are dynamic-property numbers, not drawing words.
   3. **Test fails without it:** the rule test covers new code; the source guard fails on the old log line. Neither proves the CDHELP wiring.
   4. **Fixes:** (a) LOW, carried from round 11 and still open: the line "The CE help guide is missing" also shows when the guide exists but both ways of opening it failed. Say "could not be opened" when `File.Exists(guidePath)` is true. (b) Merge conflict in `Modules/Drainage/Models/UserSettings.cs`: two new settings groups side by side, keep both. Log conflict: keep both.
   5. **C-63:** no clash beyond the same two keep-both conflicts.
   6. **Tim's word still needed** on whether the help web address is the company's own (round 11 note). Not a merge blocker, because the switch stays OFF.

2. **#1207 @ 074cd368 (BUG-548, Structural, stacked on #1024): HOLD.**
   1. **Cause real:** yes. The lintel tolerances are read from a per-PC side file named after the drawing path (`LintelProposalService.cs` line 92 in 1.0.122). A colleague or a Save As loses them.
   2. **Fix does what it says:** no, only half. `JobRecordStorage.WriteLintelRules` and `WriteSchedulePlaces` have no caller. `ReadSchedulePlaces` has no caller either. With `JobRecord.LintelAndScheduleInDrawing` ON, CE reads only the drawing, finds nothing, and drops the job's side-file tolerances without a word.
   3. **On the drawing:** a job with its own lintel tolerance goes back to the office value when the switch is ON.
   4. **Why HOLD, not a fix list:** (a) its base #1024 (BUG-496 option a) is unreviewed and not installed. (b) Tim's choice on where the job record lives (TIM_BATCH_QUESTIONS_STRUC_LANES_2026-10-10 item 15) has no recorded answer that I could find. (c) It needs the writer side and one migration: copy side-file values into the drawing on first read when ON.
   5. **I disagree with round 10**, which rated this PR plain MERGE. It did not note that the writer is missing.
   6. **Redo safety and protection:** the read uses an open-close transaction with no lock (REDO-safe). The write is uncalled, so nothing to judge.

3. **#1212 @ 55f22a3f (BUG-534 slice 2, Structural, stacked on #1142): MERGE-WITH-FIXES, after #1142, train S-44.**
   1. **Cause real:** yes. Founding notes and wind class lines cite AS 2870 and AS 4055 with no edition. RC member warnings cite AS 3600 with no edition (#1142 part).
   2. **Round 11 MEDIUM is cured:** the BUG-504 clash is resolved in 55f22a3f. It keeps AskYesOrCancel, Esc ends as CANCELLED, and adds `classCameFromCeSuggestion = true` only on the accepted branch. Merged onto 1.0.122, only the log conflicts. With S-43, #1696 also touches `RCMemberDialog.xaml.cs` but merges cleanly.
   3. **Preview matches output:** CSSOIL's preview and CSNOTES's written note both go through `FoundingNoteWithEdition`, so they agree. The switch `StandardEditions.NameEditionOnNotes` starts OFF. It is a wording option, not a bug fix, so OFF is fine.
   4. **Fixes:**
      1. **MEDIUM, in the #1142 part this stack brings:** `StandardEditionsSettings.As3600` defaults from `StandardsService.ActiveConcreteEdition`. But it is an ordinary saved property, so the first Settings save writes "2018" into CS_Settings.json. If CE's concrete standard ever moves on, the warnings keep citing 2018: a second copy (design rule 1). Fix: make As3600 a read-only property returning `StandardsService.ActiveConcreteEdition`, with `[JsonIgnore]`, and keep the tie test.
      2. **LOW:** neither the editions nor the switch have a box on CESETTINGS. Tim can only test by editing the settings file. Add the rows, or say so in the AutoCAD step.
   5. **Hard-coded engineering values:** none added. The editions only name a source.

4. **#1215 @ 86991a3b (BUG-509, Civil): REJECT, superseded.** Installed 3.0.72 already prints the before-development C the discharge used, through one chooser: HUNT2-C-05, 9793b9e7, `DesignProposalReport.PreDevCText`. The PR conflicts on that line and would add a third copy of the C rule (round 10's MEDIUM). It also reads the site area from a different field than the discharge. Close.

5. **#1216 @ d6af41f3 (BUG-515, Civil, Boyd's tab): REJECT, superseded.** Installed code already warns when the longest storm governs, always on: HUNT2-C-11, 6ab18018, `StormStillRisingSentence`. The PR would put that warning behind a switch that starts OFF, which breaks the "bug-fix switch starts ON" rule. Close.

6. **#1217 @ a6c2dfb0 (BUG-511, Civil, CDDESIGN detention pipe): REJECT, superseded.** Installed code reads the Settings run limit and size range through `Rules.DetentionPipeLimitsRule`: R-00 item 15, 6ae16dde. Every changed line conflicts. Close.

7. **#1219 @ 1e877e4b (BUG-465 item 11, Civil, SPS numbering): REJECT, superseded.** Installed code numbers from the numbers in use, with no switch: HUNT-C-11, cbe41302. The lane already ruled it OUT (log entries 973 and 1471). One open question for Tim stays: gap-fill (installed: SPS1 + SPS3 gives SPS2) or never re-use. Close.

8. **#1221 @ 7aeacc6b (BUG-465 item 9, Civil, SPS label heights): REJECT, superseded, and unsafe to merge.** Installed code already has `pit.spsLabelHeightSingleMm` and `...NumberedMm` and `GetSpsLabelHeight`: HUNT-C-08/09, ee2d9e4d. Git reports only a log conflict, but the merge adds the same two properties to `PitSettings` again, so the Civil build would fail. Round 10 rated this MERGE, before the HUNT fix landed. Close.

9. **#1225 @ e7793d29 (BUG-552, Civil, privacy): MERGE-WITH-FIXES, train C-64.**
   1. **Cause real:** yes, still in installed code. `AdminTelemetryService.RecordFailure` copies the message and the full error text, and the "Active drawing" status line writes the file name on every drawing switch (lines 175, 176, 259, 324). All of this goes to the office IT folder.
   2. **Round 10 HIGH is cured on this head:** the status line now shows "[job 25-123]" or no name, and folder paths and other job files are removed. Only the log conflicts with 3.0.72 and C-63.
   3. **Tests:** 17 pure-text tests, which fail without the new file.
   4. **Fixes:**
      1. **MEDIUM:** a bare drawing name with spaces and no job number keeps its leading words. I ran the PR's own patterns. "Smith House Stage 2.dwg could not be opened" became "Smith House Stage [drawing name removed] could not be opened". "Lot 4 Smith St.DWG unreadable" became "Lot 4 Smith [drawing name removed] unreadable". Fix: when `BareName` matches, also remove the words back to the start of the line or the last quote, colon or bracket. Add those two sentences as tests.
      2. **LOW:** add a source guard that `RecordFailure` and the heartbeat pass through `FaultReportTextScrub`. Today no test fails if the wiring is undone.
   5. **CE_SHARED:** untouched. It uses the existing `CePiiScrub`. Manager's matching rule (`CeSupportBundleScrub`) may have the same spaces gap; I did not test it.

10. **#1229 @ cb71824f (BUG-513 + BUG-512, Civil, LandXML import): REJECT, superseded.** Installed code already has HUNT2-C-08/09, ae64971a: the floor level is not an invert, placeholders are marked, and the one-pass invert loop is in. Later BUG-605/604/602 work then changed the same file again. Round 11 already said close it. Its child #1241 needs cherry-picking onto the installed line, not this base.

11. **#1230 @ a656036a (BUG-514, Civil, CDRULES roughness warning): REJECT, superseded.** It is line for line the same as installed HUNT2-C-10, 499b97c8, which also has its own test (`AssumedRoughnessWarningTests`). The only conflict is the comment. Close.

12. **#1231 @ 5a61f9d0 (BUG-481, Manager menu bar): REJECT, superseded.** Installed HUNT-M-06, 342baa37, goes further: by default Manager never changes MENUBAR unless `forceMenuBar` is set. The PR's opposite switch (`leaveMenuBarAlone`, OFF = keep forcing) would undo that. Close. The Structural side is still open as BUG-566: `CuiMenuGeneratorService.cs` line 1419 in 1.0.122 still sets MENUBAR to 1, unchecked, on every menu load.

---

## Trains

1. **C-64 (Civil/Manager, after C-63), with fixes first:** #1167 (one LOW plus keep-both conflicts), #1225 (MEDIUM then LOW).
2. **S-44 (Structural, after S-43):** #1142 first, with its As3600 MEDIUM above, then #1212.
3. **Out (close when Tim allows):** #1215, #1216, #1217, #1219, #1221, #1229, #1230, #1231.
4. **Held:** #1207, until #1024 is reviewed and Tim answers where the job record lives.

## What I did NOT check

1. **No build and no test run.** "Tests fail without the fix" is judged by reading. The #1221 compile break is from reading two property lists, not from a build.
2. **Nothing was driven in AutoCAD.** No CDHELP, CSSOIL, CSNOTES or lintel run.
3. **Merges were dry runs only** (`git merge-tree`) onto 3.0.72, C-63 and 1.0.122, plus S-43 #1696 for #1212. I did not dry-run onto an S-43 train branch, because none exists yet.
4. **#1024 and #1142 (the bases of #1207 and #1212) were not reviewed in full.** I read only the parts their stacks carry into the installed line.
5. **The #1225 pattern test used my own sample sentences.** Bash dropped a backslash, so my UNC (network path) case was not a fair test; the PR's own UNC test covers it. Manager's `CeSupportBundleScrub` was not tested.
6. **Tim's answer on BUG-496:** I searched CE_PLAN and found none. An answer given only in a chat would not show.
7. **I did not edit the carpark, QUEUE or DESK_LOG,** and I did not post PR comments.
