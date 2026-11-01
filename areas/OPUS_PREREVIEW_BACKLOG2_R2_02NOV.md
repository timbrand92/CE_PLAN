# Opus pre-review, backlog second pass group r2: PRs #892, #989, #1047, #941 (Civil train, one Manager item)

Written Sunday 1 November 2026, 14:57 Melbourne (PC clock), by an independent read-only Opus reviewer for CE 05, from the brief in areas\DRAFT_BACKLOG_TRIAGE2_02NOV.md group 2.
Release tips checked with `git ls-remote`: `claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88, C-78) and its newest successor `claude/rel-20261112a` at ccaf0783 (C-79c finalizer). Every line number below marked "tip" is from ccaf0783.
Heads reviewed: #892 2b692f3c (two commits), #989 8f90b09e, #1047 65276f4d, #941 50213ba6. All four are DRAFT and all four are 1,500 to 1,800 commits behind the tip.
Nothing was built, tested, installed or opened in AutoCAD by this review. No author report exists for any of the four (searched areas\ for BUGFIX_*; none names these PRs), so I judged from the diffs, the PR's own REGRESSION_LOG entries, the carpark and decisions\. I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.

## FOR TIM

1. **#892, X-Civil import reads the drawing's UNITS: CHANGE-NEEDED, do not merge as it stands.** Three problems. (a) When the consultant drawing has no UNITS set, it stops and asks "metres or millimetres?" with Cancel as the Enter answer. Your answer on 29 Oct (decision 10) was the opposite: import it as millimetres and print one soft line, never a block. That soft line is already in the release. (b) "Trust a set UNITS over CE's size guess" is the question still waiting for your answer (voice batch 4, question 1). This PR builds a yes before you have said it. (c) Half of it is already in the release in another form: the LandXML millimetre fix (BUG-725) and the units check (BUG-505).
2. **What to keep from #892:** one new piece only. It warns when the drawing you import INTO is not in millimetres. For example, a job drawing set to metres gets pits that land 1000 times off. Rebuild that as a warning line on the import page, not a Cancel question. Then, if you answer yes to batch 4 question 1, build "UNITS decide" inside the existing BUG-505 check. That would be a later, FULL train.
3. **#989, the "Pipe is essentially flat" warning keeps its dash on the command line (BUG-563): KEEP-WITH-NOTE, Civil area + smoke.** Take only the two one-line wording changes and the BUG-563 test. The other half (BUG-560) is already in the release, so it must not go in twice. One wording note: the command line will show a short dash, "flat - no measurable fall". The window keeps the long dash.
4. **#1047, plastic pit "PP" not printed twice: KEEP, Civil area + smoke.** Example: you place a plastic pit, save, reopen, change its cover level, and the text read "PP / PP / CL 10.250". Now it reads PP once. Edit Pit already worked this way; this makes the record refresh match it. A pit already showing PP twice corrects itself the next time CE refreshes the record.
5. **#941, Manager fault reports no longer carry street names: KEEP, Manager area + smoke.** Nothing changes on screen. A fault report saved to the office IT folder now shows "[job 25-123]" where it used to show "...\25-123 Smith Street\Lot 4.dwg". It reuses the same cleaner as the support zip.
6. **Merging:** #989, #1047 and #941 each clash only in the change log (REGRESSION_LOG.md), plus the one #989 line already in the release. Keep both sides. No program code clashes. None of the four touches a protected file.
7. **Spares #931 and #1727:** the brief says they wait for #892. Since #892 should not go in, that order no longer holds. Each must instead be checked against the LandXML units fix already in the release (BUG-725).
8. **Nobody has opened any of the four in AutoCAD.** All are built and unit-tested only, by their authors, in October. BUG-563 stays OPEN. No test reads or writes your real settings (test runs use a temporary settings folder).

---

## DETAIL

### Group facts

1. **Bases.** #892 on `claude/rel-20261009g` (1,792 behind the tip), #989 on `rel-20261009o` (1,703 behind), #1047 on `rel-20261009r` (1,680 behind), #941 on `rel-20261009l` (1,752 behind). Each needs a net-diff cherry-pick, not a rebase of the whole old branch.
2. **merge-tree against the tip (ccaf0783), read-only.** Results are the same against 3fbb9da5.
   1. **#892:** content conflicts in `LinkCommands.ImportXcivil.cs`, `LandXmlParser.cs`, `UserSettings.cs`, `XcivilImportService.cs` and `REGRESSION_LOG.md`. These are real conflicts, not only the change log. The tip has rewritten the same code for BUG-505 and BUG-725.
   2. **#989:** conflicts in `CdCommand.cs` (the BUG-560 bind, already at tip `CdCommand.cs:64-68` with a different comment) and `REGRESSION_LOG.md`. `PipeEditCommand.Update.cs` auto-merges.
   3. **#1047:** `REGRESSION_LOG.md` only. `ProjectDataService.cs` auto-merges. Its two "private to internal" changes are already made on the tip (`ProjectDataService.cs:120`, `:1162`), so only the four-line PP skip lands.
   4. **#941:** `REGRESSION_LOG.md` only. `CeAdminTelemetryService.cs` auto-merges.
3. **Overlap inside the group.** Going by the file lists, the only file two of these PRs share is `REGRESSION_LOG.md`, where every PR adds at the top: keep all. `UserSettings.cs` is touched by #892 only. No stack: each PR is independent.
4. **Protected files.** None of `LinkService.Persistence.cs`, `ProjectDataService.Persistence.cs` or `RulebookEngine.cs` is touched. `CdCommand.cs` (redo-guarded) is touched by #989, but only in a message string once the bind hunk is dropped.
5. **%APPDATA%.** On these bases and on the tip, `SettingsService.ResolveSettingsFolder` (tip `SettingsService.cs:45-56`) sends a test run's settings to a temporary folder. No test in the four PRs writes to %APPDATA%. #892's LandXML tests write a temp XML to %TEMP% and delete it in TearDown.

### #892 HUNT2-C-01: X-Civil and LandXML imports read the UNITS

1. **What changes for the drafter (at the PR head):**
   1. **CDIMPORTXCIVIL, window route** (`LinkCommands.ImportXcivil.cs:121-188`): before anything is drawn, CE reads the source DWG's INSUNITS through a side database. If the source UNITS are not set, it asks `[MEtres/MIllimetres/Cancel] <Cancel>` (`:137`). If the job drawing is not millimetres, it asks `[Proceed/Cancel] <Cancel>` (`:147`), then the source question again if the source is also unset (`:170`). Enter or Esc = "cancelled. Nothing was drawn."
   2. **Scale** (`XcivilImportService.cs:322-337`, new `XcivilImportUnits.Decide`): a readable source UNITS overrides the size guess, and CE says so in one line.
   3. **CDIMPORTLANDXML** (`:442-465`): asks Proceed/Cancel when the job drawing is not millimetres. The parser (`LandXmlParser.cs`) no longer multiplies a file that states millimetres.
2. **Against the carpark and Tim's decisions:**
   1. **Conflicts with decision 10 of `decisions\2026-10-29_TIM_ANSWERS.md` (lines 52-55).** Tim's word: "yes" to "keep importing as millimetres and print one soft line 'This drawing has no units set; CE read it as millimetres.' A note, never a block." #892 instead stops and asks, with Cancel as the default, when the source UNITS are not set. That is the exact case the decision covers. The soft note is already on the tip: `XcivilSourceUnitsCheck.NoUnitsNote` (tip `XcivilSourceUnitsCheck.cs`), switch `xcivilImport.noUnitsNote` (tip `UserSettings.cs:4176`), shown on the review page by #1926 (`scaleNoteOnReviewPage`, `:4184`).
   2. **Builds an unanswered question.** "Should CE use a set UNITS and only guess when UNITS is not set?" is `QUESTIONS_FOR_MONDAY.md` item 95.1 (voice batch 4, 31 Oct). I found no answer in decisions\ up to `2026-11-01_TIM_TESTING_AND_DATA_PILOTS.md`. `areas\BUGFIX_z3_REPORT_31OCT.md:160` says "Do not build it before he answers", and the Opus pre-review V (#1922) praised #1922 for not building it. #892's `Decide` builds the "yes" answer.
   3. **Duplicates code already on the tip (design rule 1, one code path).** The tip already reads the source INSUNITS: `XcivilImportService.Pipeline.cs:111` `ReadSourceInsunits(string, List<string>)`, which returns -1 when unreadable. It also already compares that with the guess (`XcivilImportService.cs:328-333`, `XcivilSourceUnitsCheck.Evaluate`). #892 adds a second `ReadSourceInsunits(string)` overload that returns 0 when unreadable. That merges "could not be read" into "not set", which BUG-505 keeps apart.
   4. **The LandXML half is already on the tip.** BUG-725 `DecideFileScale` (tip `LandXmlParser.cs:503-532`) already keeps a stated-millimetre file at 1:1, and decides the guess once per file rather than pit by pit. #892's `DetectLinearUnit` change would reintroduce the old shape and conflict.
   5. **Partial against HUNT2-C-01 item 5** ("scales between them"). For a job drawing not in millimetres, #892 warns and asks but still places in millimetres; it never scales to the job drawing's units. Acceptable for CE (all CE job drawings are millimetres), but it is not what the hunt entry said.
3. **Settings switch.** `xcivilImport.readSourceUnits`, default ON (`UserSettings.cs:1698` at head).
   1. **Default against Tim's rulings:** ON builds an answer Tim has not given (above).
   2. **Pinned:** only by `new XcivilImportSettings()` plus a serialise (`XcivilImportUnitsTests.cs:170-176`). That is NOT through both start-up reads (loading a file with the key missing, and loading a file with the group missing).
   3. **OFF is not exactly the old behaviour.** `XcivilImportService.cs:327` reads the source DWG a second time whatever the switch says (`sourceInsunitsAlreadyRead ?? ReadSourceInsunits(sourcePath)`), and the `[SCALE]` debug line changes. The scale and the questions do revert.
   4. **No engineering value hard-coded.** 1000 and 1 are unit conversions.
4. **No hard blocks (R-27).** Three Cancel-default questions (`:137`, `:147`, `:170`, `:453`) where Tim ruled a note. The target-not-millimetres case is a genuine risk and deserves saying. It should be a line on the pre-flight/schedule page and in the report (the BUG-505 route), or at most a question whose Enter answer is Proceed.
5. **Native protection and REDO.** The questions come before any transaction, and Cancel returns before the idempotency guard, so nothing is written and there is no Undo step. The side-database read is `OpenForReadAndAllShare`, read-only. Locked layers, Xrefs and REFEDIT are not affected. No REDO concern.
6. **Tests.** 14 plus 6 (`XcivilImportUnitsTests`, `LandXmlUnitsTests`). The PR states "red first: did not compile, no rule existed". That proves the rule is new, not that a behaviour test failed on the old code. The LandXML tests need AutoCAD on PATH (`AcadTestHost.EnsureLoadedOrIgnore`). No tip run exists, and on the tip several of them would collide with BUG-725's own tests.
7. **NOT proven, and the AutoCAD scenario.** Nothing has been seen in AutoCAD. For the rebuilt piece, robot (CE 02) on copies:
   1. Set a job drawing copy to UNITS Metres, then CDIMPORTXCIVIL a millimetre X-Civil drawing. The review page and command line must say the job drawing is not in millimetres, and Continue still imports.
   2. A source with UNITS not set: the soft line "This drawing has no units set; CE read it as millimetres." appears and nothing asks.
   3. The existing BUG-505 robot case N96/N97 still passes.
8. **Verdict: CHANGE-NEEDED.**
   1. Do not cherry-pick #892.
   2. Close it, or park it, with this note: the LandXML half is superseded by BUG-725, and the unset-UNITS question is superseded by decision 10 and BUG-505.
   3. New small job: a "job drawing not in millimetres" warning line through `XcivilSourceUnitsCheck` and the review-page banner, for both CDIMPORTXCIVIL and CDIMPORTLANDXML. Behind a switch, ON, pinned through both start-up reads. Civil area + smoke.
   4. Only if Tim answers yes to batch 4 question 1: "a set UNITS decides the scale" inside `XcivilSourceUnitsCheck` and the existing `ReadSourceInsunits`. Switch ON. FULL train, because it is pilot-critical import scale.

### #989, BUG-563 half only: the command-line warning dash

1. **What changes for the drafter.** CD (`CdCommand.cs`, tip line 1096) and Edit Pipe (`PipeEditCommand.Update.cs`, tip line 635) print each design warning through the existing `CommandLineText.Plain` (tip `Services/CommandLineText.cs`, in use since BUG-377).
   1. **Before:** "Pipe is essentially flat  no measurable fall", with two spaces where the long dash should be.
   2. **After:** "Pipe is essentially flat - no measurable fall".
   3. The same applies to "Pipe flows uphill — ...", "... — risk of silting", "... — risk of sedimentation/scouring" and "... — consider adding an intermediate pit" (tip `DesignValidationService.cs:339-448`).
   4. The window text is unchanged.
2. **Carpark fit.** BUG-563 "Next step" asks for wording that matches the window, in plain English. It is met in substance: a readable dash instead of a gap. The brief's phrase "keeps its long dash" is not accurate. The command line gets a short " - ", because the long dash is what the command line cannot print. No Tim decision covers it.
3. **Settings switch.** None, and none needed: this is display-only text on the command line, with no engineering value. (The triage's open rule question to CE 00 about no-switch fixes still applies.)
4. **No hard blocks.** None added. The existing warning window (`PipeValidationWarningDialog`) is untouched.
5. **Native protection and REDO.** No drawing access in the kept half. The dropped half (the bind) is already on the tip as 2f3f4df6 (an ancestor of both 3fbb9da5 and ccaf0783, confirmed with `git merge-base --is-ancestor`).
6. **Keep-both merge.** Net-diff only:
   1. **Take:** the two `ed.WriteMessage` lines, `Modules/Drainage.Tests/Services/Bug563CommandLineWarningDashTests.cs`, and a trimmed REGRESSION_LOG entry (BUG-563 only).
   2. **Drop:** the `CdCommand.cs` bind hunk (the tip has it at `:64-68`) and `Bug560CdBindsRecordBeforePicksTests.cs`. The tip already has `Bug560CdBindsRecordTests.cs` testing the same thing; two would be a duplicate guard.
   3. This matches Codex group 10's "MERGE-WITH-FIXES" (`areas\CODEX_PR_REVIEW_GROUP10_24OCT.md:57-61`).
7. **Tests.**
   1. `TheFlatPipeWarning_ReadsWithADashOnTheCommandLine` calls `CommandLineText.Plain` directly, so it passed before the fix too. It proves the helper, not the wiring.
   2. `EveryCommandLineWarningLine_GoesThroughPlain` (a source-text guard on both files) is the real red-to-green. On the tip there is exactly one matching line in each file, so it will fail before and pass after.
   3. `ValidatePipe` reads `SettingsService.Current` (`UphillSwitchOn`, tip `DesignValidationService.cs:211-215`). Under the test run that is the temporary settings folder, not %APPDATA%. Not run on the tip by anyone.
8. **NOT proven, and the AutoCAD scenario.** Robot: CD between two pits, type equal invert levels at both ends. The command line must read "[CE] Warning: Pipe is essentially flat - no measurable fall". Then Edit Pipe on the same pipe, OK, and the same line appears. No Codex look needed.
9. **Verdict: KEEP-WITH-NOTE. Civil area + smoke.** The note: net-diff the BUG-563 half only, and correct the "long dash" wording in the log entry and in any card for Tim.

### #1047: plastic pit "PP" line is not saved as "text above"

1. **What changes for the drafter.**
   1. **Where:** when CE refreshes its project record from the drawing (`RefreshPitMetadataFromDrawing`, tip `ProjectDataService.cs:~881`), its cover-text reader (`TryParsePitCoverText`, tip `:1162`) now skips a line that is exactly "PP" (the new lines go just after tip `:1184`).
   2. **Before:** on a plastic pit, "PP" was saved as the drafter's Text above. The next rewrite (Edit Pit, level change) printed "PP\PPP\PCL ..." (PP twice), because the formatter adds PP for the plastic flag (`PitAnnotationTextFormatter.cs:23-27`).
   3. **After:** the refresh reader behaves the same as Edit Pit's reader, which already skipped PP (tip `PitEditCommand.cs:1981-1984`). "PP SPECIAL" is still kept.
   4. **A pit already carrying "PP" in Text above corrects itself** at the next refresh, because both PP lines are now skipped.
   5. Fits Tim's Batch 1 card 1.1, answer 2, 9 Oct (INT-074): "a plastic pit is labelled only by 'PP' in its cover-level text" (tip `PlasticPitCoverTextRule.cs:7`).
2. **Settings switch.** None. It is a reader fault that doubles CE's own wording, with no engineering value. (The rule question to CE 00 stands.)
3. **No hard blocks.** None.
4. **Native protection and REDO.** Reader only. It changes what is saved into CE's record, not the drawing. `ProjectDataService.cs` is not on the protected list (`ProjectDataService.Persistence.cs` is, and is untouched).
5. **Edge, NOT proven.** The skip does not look at the pit's plastic flag.
   1. If a NON-plastic pit has a drafter-typed lone "PP" line, the refresh now drops it from the record, and a later rewrite would lose it.
   2. If a pit's plastic flag was lost but its text still says PP, the PP disappears at the next rewrite.
   3. Edit Pit already behaves this way, so the two readers now agree. I judge it acceptable, but it is a change.
6. **Keep-both merge.** `REGRESSION_LOG.md` only. Clean otherwise.
7. **Tests.** `PlasticPitCoverTextRoundTripTests` (4).
   1. `ReadBack_PlasticCoverText_DoesNotKeepPpAsTextAbove`, `ReadBack_ThenRewrite_IsStable` and `ReadBack_PpOnlyText_StillCountsAsNothingToSave` all fail on the old reader (Text above "PP", "NOTE PP", and true instead of false), so they are real red-to-green.
   2. `ReadBack_PpInsideLongerLine_IsKept` passes before and after (a pin).
   3. Pure text: no drawing, no settings. Not run on the tip by anyone.
8. **NOT proven, and the AutoCAD scenario.** Robot on a copy:
   1. `PP`, place a plastic pit with a cover level. Save, close, reopen.
   2. Run any command that refreshes the record (CDCHECK or PITSCHEDULE).
   3. Double-click the pit, change the cover level, OK. The text must read "PP / CL x.xxx" once.
   4. Then `CDPITCOVERFLIP`: PP stays once.
   5. A Codex look at the text is worthwhile, because it is visual.
9. **Verdict: KEEP. Civil area + smoke.**

### #941: Manager failure reports cut drawing and job-folder paths (privacy audit A6)

1. **What changes.** `CeAdminTelemetryService.RecordFailure` is split into `BuildFailureEvent` plus the queue call (`CeAdminTelemetryService.cs`, tip `:110-143`). Message and Details now pass through `CeSupportBundleScrub.Scrub(text, UserName, MachineName)` (tip `CeSupportBundleScrub.cs:97`) instead of `CePiiScrub.ScrubHere`.
   1. **What that cleaner does:** drawing paths, bare job drawing names, job-folder files (pdf, xlsx ...) and folder paths become "[job 25-123]" or "[drawing path removed]".
   2. **What stays readable:** CE's own places (ProgramData, Program Files, ApplicationPlugins, "IT Admin", "CE Plugin Admin", CE folders under AppData).
   3. **Then:** the same login, PC name and profile scrub as before.
   4. **On screen:** nothing changes for the drafter. It affects only the JSON written to `<IT Admin>\CE Plugin Admin\failures\<date>` (`CeAdminStorageService.cs:151-153`).
   5. **Fit:** this is audit route A6 from `areas\release-v3-colleagues-AUDIT_LOG.md:14`: the zip was cleaned, but the failure report still carried folder and PDF paths. CE_SHARED is not changed.
2. **Settings switch.** None. A privacy protection, which the PR states. No engineering value.
3. **No hard blocks.** None.
4. **Native protection and REDO.** No drawing access.
5. **Things checked by reading:**
   1. **Stack traces stay readable.** A line in Details such as "in C:\...\Foo.cs:line 42" is not cut by `AnyFolderPath`. ".cs" is not in its file list, and the ":line" form does not satisfy its end condition. So build-machine source paths stay, which is fine (no client data).
   2. **Nothing else lost.** The previous login and PC-name scrub is still applied inside `Scrub` (`CePiiScrub.Scrub` with the profile folder), so nothing that was hidden before is now shown.
   3. **Callers unaffected.** `RecordFailure` keeps its exact signature, so its callers (`Plugin.cs`, `PluginManagerCommands.cs`, the two windows) are unaffected.
6. **Keep-both merge.** `REGRESSION_LOG.md` only.
7. **Tests.** `FailureReportPathScrubTests` (4) build the event without queuing it, so nothing is written to disk or to %APPDATA%.
   1. **The red-first claim is plausible but not checkable.** `BuildFailureEvent` did not exist before this commit, so "the two path tests failed" must mean an intermediate state. Swapping the scrub back would make those two fail ("Smith" kept), so I accept them as real guards.
   2. The other two are pins.
   3. Manager 692 of 692 was at the old base, not the tip.
8. **NOT proven, and the scenario.** A real Manager failure written to the office folder from a running AutoCAD. Robot or Codex:
   1. Point the IT Admin path at a scratch folder.
   2. Force a Manager failure whose message holds a job drawing path (for example an update staging failure on a copied path containing "25-123 Smith Street").
   3. Open the newest file under `failures\`: "Smith" absent, "[job 25-123]" present.
9. **Verdict: KEEP. Manager area + smoke.** Last in the group, as the brief says.

### Spares (not reviewed in depth; noted because #892's verdict changes their order)

1. **#931 (HUNT2-C-15) and #1727 (FA02 units):** the brief orders them "after #892", because they share `LandXmlParser.TryParse`, `ParseStruct` and `ParsePipe`. With #892 CHANGE-NEEDED, that order lapses.
2. **What each must be checked against instead:** BUG-725's `DecideFileScale` (tip `LandXmlParser.cs:503-532`), which already reads the file's stated unit for positions. #931's "size units" and #1727's "cover and invert levels in the stated unit" may each partly overlap it. I did not diff them.
