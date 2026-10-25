# Train C-66 finalizer report (Civil + Manager), Sun 25 Oct 2026 (real clock 10:12 to about 11:30 Melbourne)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Inputs read: `C:\TimOS\RULES.md`; the C-66 assembly report (in full); the C-66 PR list (in full); `REVIEW_PILOT_CRITICAL_B4B5_25OCT.md` (in full); the C-65 finalizer report (method and shape); `QUESTIONS_FOR_MONDAY.md`; `decisions\2026-10-20_TIM_ANSWERS.md` and `decisions\2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md` (newest decisions; no file in `decisions\` is dated after the C-66 list, and no answer in either touches a C-66 switch or #1771, #1756, #1767); the tail of the review-lane log. I used no helper subagents: I read every merged diff myself, made every verdict, every change, every build and every test run myself.

Built and unit-tested only. Not installed. Nobody has opened it in AutoCAD. No PR closed, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` and `BUG_CARPARK.md` not edited.

Installed line read first (read-only, `FileVersionInfo` from a .ps1 file, six DLLs, 10:12): Civil `3.0.75+2c805a39733ea4649b4273f1f425a37cda463046` in Legacy, Net8 and Modern (written 25 Oct 03:05 to 03:11); Manager `1.1.75+2c805a39733ea4649b4273f1f425a37cda463046` in Legacy, Net8 and Modern (25 Oct 03:18). That is train C-65, as briefed. Structural is not in this train.

## ANSWER FIRST

1. **GO at `777e001321668a6fb1aa1ffb564c5b5cacd20257`.**
2. **Mistakes first, plainly:**
   1. **My first Manager test run gave 5 false reds (my runner, not the code).** I handed the tests their temporary folder with forward slashes (`C:/fin66/...`); five Manager tests that guard "this test only touches the run's own temporary settings file" compare the path text and refused it. I switched the runner to normal Windows paths and re-ran: 1,002 total, 0 failed. Cost: about 2 minutes. The Civil net10 full run before it had used the same slashes and passed (0 failed); the log override still pointed inside its own temporary folder.
   2. **My first Civil bundle attempt stopped near its end (10:58) because my shell handed Windows PowerShell the PowerShell 7 module path**, so `Get-FileHash` was missing at `build_installer.ps1` line 224 (after all three Civil lanes had built with 0 errors; no release archive was written by that attempt). I set the Windows PowerShell module path in my runner and re-ran it. Cost: about 8 minutes. Same family as the C-65 finalizer's PATH slip: a lesson to add (lesson 13 below).
3. **Branch and final head:** `claude/rel-20261025p` @ `777e001321668a6fb1aa1ffb564c5b5cacd20257`, one normal fast-forward push from the assembler's `784640d5e912ae35d1e06076d7bfc8421c561fd7` (which matched `git ls-remote` at 10:12, exactly the assembly report). Base: installed C-65 `2c805a39` (Civil 3.0.75 / Manager 1.1.75). This train becomes Civil 3.0.76 / Manager 1.1.76 when the payload builder stamps it (I did not bump).
4. **What I changed: one commit, tests only, pushed:** `777e001321668a6fb1aa1ffb564c5b5cacd20257` adds `C66NewSwitchDefaultsTests` (3 tests) and its REGRESSION_LOG entry. No product code changed by me. Nothing reverted, nothing dropped.
5. **#1771, #1756 and #1767 (Tim's decision): all three LEFT OUT.** No recorded Tim answer exists after the C-66 list (25 Oct 09:30): `decisions\` newest file is 24 Oct; `QUESTIONS_FOR_MONDAY.md` item 9 (the #1771 sentence, asked 25 Oct 09:30) has no answer. Heads unchanged (live `git ls-remote`, 10:21): #1771 `f3f38c24`, #1756 `62a26660`, #1767 `9e1a9455`. I read all three diffs in full: #1767's contested case is still NOT on the safe side (an accidental detach of a stage drawing turns the red QA Fail into a yellow warning, switch ON); #1756 still has one switch for both the moved XREF (the bug) and the detached XREF (a daily-habit change). The four questions stay OPEN for Tim (section 7).
6. **#1706 (BUG-225, Pit tab Close button): NOT in this train and I did not take it in** (REDO-safety relevant; the C-63, C-64 and C-65 finalizers left it out).
7. **Settings defaults (judged against the merged code and Tim's answers, not the PR text):** six new switches, all guard a bug fix, all ON, all KEPT ON; nothing turned OFF by me; no existing default changed by the train. An older settings file (empty, and C-65-shaped) loads all six ON through the two start-up reads, a typed OFF is kept, and every earlier default is pinned again (`C66NewSwitchDefaultsTests` 3 of 3 on net10 and net48). `NewSettingsKeys_NeedADocumentedDefault` 1 of 1. Settings fit at 150 per cent: 5 of 5, tallest tab **670 px** on every screen. Each switch in section 3.
8. **Questions for Tim** (section 7, his format): (a) #1771 the computations-sheet sentence; (b) #1772 which head the 300 mm minimum means; (c) #1756 detached survey XREF; (d) #1767 stage drawing BIND versus detach; (e) 0.013 roughness, unchanged; (f) finer storm sweep, parked; (g) heartbeat destination (#1620, waiting); (h) the CDHELP web address; (i) #1776 retry follow-up (not a Tim question; listed).
9. **Manager (a real Manager release, small):** #1769 a damaged office approval file now gives "CE could not check the office approval for <plugin>, so it cannot say whether it is current. You can keep drafting. Please ask the office to check the approvals file." instead of "CE is current."; #1774 Drawing Repair's note reads "Inspect only looks. Fix it changes the drawing." **Official Manager release build: PASSED, the guard at exactly 75 files** ("Complete 75-file, three-lane release candidate verified.", 0 warnings, 0 errors), with CE_SHARED from a Civil bundle built in the same worktree by the unchanged `build_installer.ps1` (section 5). Manager net10 full: **1,002 total, 1,001 passed, 1 skipped, 0 failed**. Manager net48 built with 0 errors (solution build).
10. **Installer and signed-update safety: untouched.** `git diff --stat 2c805a39..HEAD -- Shared Installer Installer.Tests Modules/Manager/Installer` is **EMPTY**. No file named OfficialReleaseGate, SafeBundleInstaller, ReleaseAuthority, CE.Host or CE.AI.Core changed; no `.csproj`, `.props`, `.targets` or `.ps1` changed. **No command added or removed:** `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json` and every `PackageContents.xml` unchanged; CrossModuleGuard 6 of 6. #1768 changed only help text (`guide-content.js`, one line); HelpGuideVersion 2 of 2, FeedbackHelpWording 3 of 3. The Installer suite was NOT run (compiled only).
11. **Tests (Release, `C:\fin66\w`, final head):**
    1. **Whole solution: 0 errors, 909 warnings** (10:17 to 10:30, 13 m 09 s). Civil and Manager built for **net48, net8.0-windows and net10.0-windows**; `CE.TestHarness.Tests` built (net10.0-windows); `CE_CVL_SUITE_Installer` (net9.0) and `CE_CVL_SUITE_Installer.Tests` (net9.0-windows) **COMPILED, not run**.
    2. **Civil net10 full: 20,303 total, 20,271 passed, 32 skipped, 0 failed** (10:30 to 10:40). That is the assembler's 20,300 plus my 3; above the 20,245 floor.
    3. **Manager net10 full: 1,002 total, 1,001 passed, 1 skipped, 0 failed** (second run, see mistake 2.1). `Bug1179UnreadableApprovalStatusTests` 7 of 7, `DrawingRepairViewModelTests` 13 of 13.
    4. **Named net10 (one run, 115 tests, 0 failed, counted per class from the trx):** Settings fit 5 of 5 (670 px), `NewSettingsKeys_NeedADocumentedDefault` 1 of 1, **`RedoSafeCallGraphTests` 25 of 25 after all merges and my commit** (no DROP, no #1771, so no second run needed), CrossModuleGuard 6 of 6, HelpGuideVersion 2 of 2, C-61 to C-66 switch tests 3 of 3 each, FeedbackHelpWording 3, Bug1101 8, Bug1097 7, Bug1188 8, Bug1168 6, Bug1202 12, Bug1151 5, Bug1137 6 (each equals the reviewer's count), Glen Eira back-test (`AutoDesignBackTestTests`: both `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance` methods and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet`) 3 of 3.
    5. **Civil net48 focused (class filters joined by `|`, the assembler's list plus `C66NewSwitch`): 2,276 total, 2,103 passed, 122 skipped, 51 failed.** All 51 are `InvalidProgramException` from the reference-only AutoCAD DLL, and the failed-name list equals the assembler's list exactly (`diff` empty), which is the C-65 finalizer's 51 (its item 12.5: 17 known names, 17 `CdCreationPlanPointTests`, 17 in `Bug1194ClickedLegTests`, `Bug1190NestedSurveyBlockTransformTests`, `Rd09AnnotationPreparationTests`). **No red beyond those names; every class this train adds, and mine, passes on net48.**
12. **Tim's settings files: unchanged.** At 10:12 and 11:02: `TIM_CE_CADTOOLS\CD_Settings.json` ACD64E79A33B (15,270 bytes, 11 Mar 08:22), `TIM_CE_CADTOOLS\CS_Settings.json` 622A246F7D3B (351,713 bytes, 31 Mar 13:18), `CE_STRUC_SUITE\CS_Settings.json` 2972CE70C514 (35,259 bytes, 22 Oct 18:54), `CE_CVL_SUITE\settings.json` EFE307C4FC74 (672 bytes, 16 Sep 12:13): hash, size and date identical. The six installed DLLs read the same C-65 versions at 11:02 as at 10:12 (nothing deployed). AutoCAD (acad.exe) was running from my first read (pid 95304, started 10:04) and at the end (pid 104700, started 10:57: someone else restarted it during my run); a robot or Codex pass may have been using it; I never touched it.
13. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted, Codex-accepted or Claude-accepted.

## 1. Review of every merged PR (merge order)

All ten merges carry the reference head as second parent (the assembler checked; the heads and merge SHAs in its section 1 match the branch log I read). The assembler left nothing out. I read every merge diff myself in merge order.

### 1.1 Review asks against the merged head

The review (`REVIEW_PILOT_CRITICAL_B4B5_25OCT.md`) gave all eleven MERGE with **no MEDIUM or HIGH open ask** (I checked each item: none is a MERGE-WITH-FIXES, none asks for a change before merge). The only "fix" in the whole batch was the #1770 / #1772 settings clash: both blocks kept (1.3). What stays open is LOW and optional, listed per PR in section 4; none is a hard block under R-27.

1. **#1778 BUG-1137:** closed. Open as known: rotated or scaled COPY of a downpipe, and on 2027 a locked downpipe label layer, still stop the whole write; MIRROR untouched; nothing proven on a real 2022 to 2024 drawing; "Check the copied downpipe on the drawing" is vague (accepted). Plus one new LOW from my read (1.2.1).
2. **#1773 BUG-1188:** closed. Open: `XcivilLayerRecognition.cs:603` still sets `gradeValue = "100"` for a `CI-STRM-DRAN-INVT-N` layer in the X-Civil DWG route (a second invented 1 in 100; re-read on this head, still there; the desk files it); no "grade missing" line in the import review window.
3. **#1770 BUG-1101:** closed. Open: Add still seeds a typed 500 m2 / C 0.9 row (BUG-544); the council storm is not used when the tab opens; an off-ladder office Tc rounds to the nearest rung (7 gives 5 min).
4. **#1769 BUG-1179:** closed. Open: a valid but empty file (`{}`) counts as "no approval", not "unreadable".
5. **#1772 BUG-1097:** closed. Open: the Settings box and project override (BUG-546), the CDRULES R-13 line, Tim's question (b).
6. **#1775 BUG-1168:** closed. Open: a colleague PC that already SAVED the local job-time folder stays on it (check `jobTime.dataFolderPath` in `CD_Settings.json` at each colleague install); old local time is not moved; a session started before OneDrive is ready still logs locally for that session.
7. **#1776 BUG-1202:** closed. Open: an empty "nothing to export" check is not remembered; the export's file read has no retry (1.2.2, section 4). Cosmetic: the PR text says 13 tests; there are 12.
8. **#1777 BUG-1151:** closed. Open: the real proxy case needs AutoCAD 2022 to 2024 without the add-on.
9. **#1774 BUG-1180 and #1768 BUG-1215:** wording only, closed (1.4).

### 1.2 Full adversarial reads (my verdict in plain words)

1. **#1778 (one downpipe in a COPY no longer cancels the whole clean-up): KEEP.**
   1. **Same test as the write:** `CloneSourceCopyRule.CanBeCompleted` checks both maps are present and makes exactly the two `MapsExactly` checks `RemapCloneSourceInTransaction` makes first (placement map = `ActualHandleMap`, complete child map = `SourceFullHandleMap`; `LinkService.SpineClones.cs:24-27`). A missing placement map would have crashed the write anyway, so a downpipe the rule rejects is exactly one the write would refuse. The write's later checks (rotation, scale, locked or foreign) are not in the rule, which is the known "rotated or scaled COPY still stops the write" limit.
   2. **Filtered list everywhere after:** the removal (`work.Clones.RemoveAll`, `LinkService.Utilities.cs:230`) happens before `CloneMissingPitAttachments`, before the transaction, and the joint-pit step (`foreach sourceCandidate in work.Clones.Where(c => c.IsSource)`) and its readback (`eligibleWork.SelectMany(w => w.Clones).Where(c => c.IsSource)`) both read that same filtered list.
   3. **Owned attachments from pipes only:** `CollectMappedOwnedClones` skips pits and anything without pipe data; a downpipe candidate carries pit-link data only, so nothing it owns is half-renamed. `MapPitAttachmentClones` reads pits only.
   4. **2027 with a good copy record:** both checks pass, nothing is removed, nothing changes. Switch OFF: the block is skipped, the old all-or-nothing write runs.
   5. **No layer unlocked; nothing between U and REDO:** the change only removes items from an in-memory list inside the existing command-end clean-up; it adds no write. The one line starts "[CE]".
   6. **New LOW from my read (not a blocker):** the downpipe copy that is left out still joins the BUG-288 "relink pipes near the copies" scope (`appendedSourceHandles`, `LinkService.Utilities.cs:465-467`), so on 2022 to 2024 a pipe with an open end exactly where the copied downpipe landed may be linked to a downpipe whose own record still names the original pit. On the base that whole pass was abandoned. It only matters on 2022 to 2024 with a pipe end at the copy's spot; it needs the same 2022 to 2024 check as the rest of #1778. Next round.
2. **#1776 (weekly time export off AutoCAD's start-up thread): KEEP.**
   1. **Files and settings only:** `JobTimeWeeklyExportService` uses only `System.IO` (reads the monthly CSVs and the marker, writes the export, the marker and the office mirror); no AutoCAD object, document or editor is touched.
   2. **The CE log only queues:** `LoggingService.Info/Warning/Error` call `Log`, which only hands the line to the background writer; only `Diagnostic` echoes to the command line, and the export does not use it.
   3. **Settings save locked:** `SettingsService.SaveSettings` runs inside `lock (_lock)`. With #1775's switch ON (the default) the export never saves settings at all (the folder is only remembered for the session).
   4. **Errors to the CE log, never the drawing:** `JobTimeStartupExport.Run` wraps the work in try/catch and calls the CE-log error line.
   5. **Switch OFF:** `Run(false, ...)` calls the same guarded work inline and returns a finished task: the old start-up behaviour.
   6. **AutoCAD closed while the task still runs:** the task dies with AutoCAD. Worst case a half-written weekly export or marker file. Next start: a missing or unreadable marker means the export is made again and the file is overwritten, so it heals itself. No drawing and no settings file is touched in that window (default switches). Harmless.
3. **#1775 (job-time folder looked for again at each start): KEEP.**
   1. **Race with #1776's background export:** both threads go through the same getter; the per-session value is one string assigned at once; both would detect the same folder. Harmless.
   2. **A chosen folder always wins:** `JobTimeDataFolderRule.Resolve` returns the saved value first.
   3. **Switch OFF:** saves the first detected folder, exactly the old code.
   4. **No product code calls the setter:** searched; the only other writer is the settings folder-follow step (`SettingsService.FolderPaths.cs:67`), which only rewrites an already-saved path, as before.
4. **#1769 (Manager: damaged approval file no longer says "CE is current."): KEEP.**
   1. **The static list:** set on every read (also emptied when the folder does not exist), under a lock; `Poll` passes `GetApprovedReleases()` and then `UnreadableApprovals` as arguments of one call, and C# evaluates arguments left to right, so it reads the list straight after its own read.
   2. **The damaged file is never touched:** the read only catches and records; no write or move in the diff.
   3. **The status:** names only plugins installed on this PC (`p.IsInstalled`), keeps the normal colour (`CeStatusLevel.Ok`), and sits after every update, rollback and office-folder check, so a valid update elsewhere still wins first.
   4. **Wording:** plain: "CE could not check the office approval for Civil, so it cannot say whether it is current. You can keep drafting. Please ask the office to check the approvals file."
5. **#1770 and #1772 (the `UserSettings.cs` clash): KEEP both.**
   1. **Resolved block:** straight after `defaultTcMinutes`: `catchmentsStartBlank` (own summary ending "Default: on.", own `JsonProperty`, `= true`), a blank line, `chargedMinHeadWarning` (same), then `defaultPsdAriYears`. Every `JsonProperty` name in the file is unique within its class (checked by script); each of the six new names appears once.
   2. **The seven edited tests:** each edit only ADDS `AddCatchmentCommand.Execute(null)` before the old steps (no line removed, no assertion changed), so each still pins what it pinned.
   3. **Storm return period:** `NearestIndex(AriYears, Detention.DefaultPsdAriYears)`: the same Settings value `RationalFlowService.OfficeDefaultPsdAriYears` and so `PsdAriYears(...)` use for the minor-flow storm when the council states none. Default 5: the tab opens at 1 in 5, as before.
   4. **#1772:** warns only (results still show), from `DesignStandards.ChargedMinHeadMm` (the value CDRULES prints for R-13), silent when the head is blank or not a number, or when the minimum is not set.
6. **#1773 (no invented "AT 1 IN 100"): KEEP.** Plain, suspended and detention labels in `BuildImportedPipeDisplayText(type, ...)`, and the detention label with length in `BuildImportedPipeDisplayText(pipe)`, all drop the grade clause when the file gives no grade and the switch is ON; a grade from the file is kept. The stored data already agrees: `XcivilPipeInsertionService.BuildImportedPipeData` stores grade mode "default" and `ShowGradeInText = false` when the file has no grade text. Existing pipe and charged pipe wording unchanged.
7. **#1777 (moving a pit names the CE pipe objects left behind): KEEP.** No drawing write added (`NoteUnreadablePipeLeftBehind` opens for read and only remembers a name). All four pit and block move paths call `ReportPipesLeftOnLockedLayer` after `MoveLinkedPipes` (`LinkService.PitMoves.cs:52/66`, `LinkService.SourceMoves.cs:83/85` and `272/282`, `LinkService.cs:285/287`), and that report says the unreadable-pipe line first. The line starts "[CE]", names up to three pipes (then "and N more"), says why (the CE pipe add-on is not loaded), says what to do (move by hand or CDSYNC on a 2027 PC with the current suite), and ends "U undoes the move."

### 1.3 Merge hygiene

1. **REGRESSION_LOG.md:** all ten entries present, newest merge on top in merge order (#1768, #1774, #1777, #1776, #1775, #1772, #1769, #1770, #1773, #1778), my entry above them. Headings 1,428 on the base, 1,439 now (+10 PRs, +1 mine). Headings with no blank line before: 160 on the base and 160 now. No conflict markers.
2. **UserSettings.cs:** all six switches present with their own default and documentation line (1.2.5.1); the only file touched by more than one PR.
3. **Shared and Installer:** `git diff --stat 2c805a39..HEAD -- Shared Installer Installer.Tests Modules/Manager/Installer` prints nothing. Civil and Manager carry the same CE_SHARED as C-65.

### 1.4 The two wording PRs

1. **#1774:** `DrawingRepairViewModel.ReadOnlyBanner` changes from "Nothing has been changed. Inspect only looks." to "Inspect only looks. Fix it changes the drawing." One line.
2. **#1768:** the CDFEEDBACK row in `guide-content.js` now says Send report saves a copy on this PC and tries the office feedback folder in the same step, and to read the command line. One line. HelpGuideVersion 2 of 2.

### 1.5 The Tim-decision PRs (read in full at their live heads)

1. **#1771 `f3f38c24`:** one constant and one CDRULES "not evaluated here" row in `RulebookEngine.cs`, one `lines.Add` at the end of BASIS OF DESIGN in `ComputationsSheetV3.cs`, the two golden sheets gain the line. The sentence is exactly as briefed. No recorded Tim yes: **left out.**
2. **#1756 `62a26660`:** `SurveyXrefCurrencyRule` compares the approved XREF placement with now; a handle that no longer names a block reference (a DETACH) gives "... is no longer in this drawing" and the stored levels are held back, under the same one switch `survey.storedLevelsFollowXrefPosition` (ON). Not unsafe, but it changes an everyday habit and its switch cannot keep the moved-XREF fix while leaving the detach alone: **left out.**
3. **#1767 `9e1a9455`:** a source gone from the Xref list with no same-path entry becomes `goneMaybeBound`, and the QA state becomes Unknown (yellow) instead of Fail (red) when nothing else is wrong, switch `linking.pitScheduleBoundSourceFrozen` ON. An accidental detach gives the same yellow: **not on the safe side; left out.**

## 2. What Tim will see in AutoCAD (plain words, per merged PR)

1. **#1778:** on AutoCAD 2027 (Tim's PC): nothing changes. On 2022 to 2024: COPY a group with pits, pipes and a downpipe; the copied pits get their own numbers and Pit Schedule rows, the downpipe stays as AutoCAD copied it, and one line says "[CE] A downpipe copied with the pits could not be given its own link on this AutoCAD, so it was left as AutoCAD copied it. ..."
2. **#1773:** import a LandXML (or X-Civil DWG) pipe with no grade: the label reads "300 DIA. RCP PIPE", not "... AT 1 IN 100".
3. **#1770:** open CDCALC, Catchments tab: no rows, total "Unknown", storm at the office Tc (5 minutes by default) and 1 in 5. Click Add to start a row.
4. **#1769 (Manager):** only if the office approvals file is damaged: the CE status says CE could not check the office approval for Civil (or Manager) and to ask the office, instead of "CE is current."
5. **#1772:** CDCALC, Charged System tab: type 0.25 in Available head: the warnings list adds "Available head 250 mm is under the 300 mm minimum for a charged system (R-13)." The results still show.
6. **#1775:** nothing on Tim's PC (his folder is saved). On a new colleague PC whose OneDrive was still syncing at the first start: the next start finds the office folder.
7. **#1776:** AutoCAD no longer waits for the weekly time export while it opens. Nothing on screen.
8. **#1777:** on 2027 with the add-on: nothing. On 2022 to 2024 without it: move a pit; one line names the CE pipe objects that stayed where they were and ends "U undoes the move."
9. **#1774 (Manager):** Drawing Repair's note reads "Inspect only looks. Fix it changes the drawing."
10. **#1768:** CDHELP, Feedback page: describes the Send report button and tells you to read the command line.

## 3. Settings defaults (each judged on the merged code; old-file loading proven by `C66NewSwitchDefaultsTests` through `DeserializeSettings` and `DeserializeSettingsTolerant`)

1. **`detention.catchmentsStartBlank` (#1770): ON, kept ON.** Missing key loads ON. Changes what Tim sees: yes (the Catchments tab opens empty). The old behaviour is the bug: a total for a 500 m2 catchment nobody typed is a made-up answer (R-12, Unknown stays Unknown). Bug-fix switch, ships ON.
2. **`detention.chargedMinHeadWarning` (#1772): ON, kept ON.** Missing key loads ON. Changes what Tim sees: only a warning line when the typed head is under 300 mm. The old silence is the bug (CDRULES lists R-13 as a house rule, nothing checked it). Warning only (R-27). ON.
3. **`xcivilImport.importedPipeNoInventedGrade` (#1773): ON, kept ON.** Missing key loads ON. Changes what Tim sees: an imported pipe with no grade has no "AT 1 IN 100". The invented grade is the bug (wrong answer on a drawing). ON.
4. **`jobTime.detectDataFolderEachStart` (#1775): ON, kept ON.** Missing key loads ON. Changes nothing for Tim (his folder is saved). Saving the local fallback for good is the bug (time never reaches the office). ON.
5. **`jobTime.weeklyExportInBackground` (#1776): ON, kept ON.** Missing key loads ON. Changes nothing visible; AutoCAD starts without waiting. Blocking the start-up thread is the bug. ON.
6. **`linking.copyContinuesWhenDownpipeCannotFollow` (#1778): ON, kept ON.** Missing key loads ON. Nothing changes on 2027. The all-or-nothing loss is the bug (data loss on 2022 to 2024). ON.
7. **Earlier switches unchanged (pinned again by my test):** detention.twlUsesDrawingUnits ON, pits.skipCurrentPitBlockRedefine ON, linking.pitScheduleUsesPitFloor ON, checks.allowIgnoreFinding OFF, linking.propagateWritesSingleIlToItsOwnEnd ON, linking.escKeepsPlacedCalloutLinks ON, linking.scheduleRefreshKeepsTwinAndTrenchText ON, xcivilImport.importReviewRefusesChangedSource ON, linking.keepUnreadableDrawingRecord ON, linking.inlineSplitMovesDecisions ON, designStandards.networkUsesPipeMaterial ON, the ten C-64 switches ON, linking.shallowPitDepthMm 300, the eight C-65 switches ON, help.openWebFallback OFF, designStandards.manningsNNotRecognised 0.013.
8. **No new-behaviour-ON default whose old behaviour is not the bug:** none found, so no switch turned OFF. Tim's answers (20 and 24 Oct) say nothing about any of the six.
9. **Switches without a Settings page row (owed to the Codex window lane; I built none; the window is at its 670 px limit):** all six new ones (`detention.catchmentsStartBlank`, `detention.chargedMinHeadWarning`, `xcivilImport.importedPipeNoInventedGrade`, `jobTime.detectDataFolderEachStart`, `jobTime.weeklyExportInBackground`, `linking.copyContinuesWhenDownpipeCannotFollow`), plus the eight C-65 switches and `help.openWebFallback` (searched the Settings windows, view models and value catalogue: no row for any of them), and the C-61 to C-64 switches as listed by earlier finalizers.

## 4. LOW items left for the next round (none a hard block under R-27; what Tim loses)

1. **#1778:** rotated or scaled COPY of a downpipe and a locked downpipe label layer on 2027 still stop the whole write (those pits keep their original's number and no schedule row); MIRROR untouched; the left-out downpipe still joins the nearby-pipe relink (1.2.1.6); the "Check the copied downpipe" line is vague (no better instruction on 2022 to 2024).
2. **#1773:** `XcivilLayerRecognition.cs:603` still invents 1 in 100 for a `CI-STRM-DRAN-INVT-N` layer (a wrong label on that import route; the desk files it); no "grade missing" line in the import review.
3. **#1770:** Add still seeds 500 m2 / C 0.9 (BUG-544); council storm not used at open; off-ladder Tc rounds (7 gives 5 min).
4. **#1772:** the Settings box and project override (BUG-546) and the CDRULES R-13 line.
5. **#1769:** a `{}` approvals file still counts as "no approval" (status can read "CE is current." for that one edge).
6. **#1775:** colleague PCs that already saved the local folder stay on it (desk: check `jobTime.dataFolderPath` at each colleague install); old local time not moved; a session started before OneDrive is ready logs locally for that session.
7. **#1776:** the export's file read has no retry: if the time logger is appending to a monthly sheet at that exact millisecond, that person's rows are left out of that week's export (the marker is still written, so the week is not redone). The fix is to reuse the logger's 3-try `RetryFileOp`; **NOT written in this train** (it would be a new behaviour change with no failing test yet). An empty "nothing to export" check is not remembered.
8. **#1777:** nothing to change; only the 2022 to 2024 proof is owed.
9. **#1771 (not in the train), cosmetic:** its new constant sits between `NotEvaluatedHere` and that list's own doc comment.

## 5. Manager release build and bundle

1. **Civil bundle (only to supply the approved CE_SHARED):** the unchanged `Installer\build_installer.ps1`, run from `C:\fin66\w` by `C:\ce-fin\c66\civil_bundle.ps1` (second attempt, 10:58:56 to 11:00:33; first attempt see mistake 2.2): all three Civil lanes 0 errors, "Installer build complete.", exit 0. It also wrote its release archive `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20261025_110009_v2026.1025.1058` (left in place, as briefed; none of the earlier archives touched). **C: free: 13.65 GB at my first bundle attempt, 13.19 GB before the second, 12.45 GB after it, 12.45 GB before the Manager build, 13 GB (df) at 11:02.** Never under 12 GB. This bundle is NOT releasable (0-byte transform placeholder).
2. **Manager release build:** the exact dotnet command of `C:\ce_rc_scratch\p99_scripts\payload99_mgr_build.ps1` (the original not edited; copied into `C:\ce-fin\c66\mgr_build.ps1` with the worktree and bundle paths pointed at `C:\fin66\w`), 11:01:09 to 11:01:53: `-p:PrepareReleaseBundle=true -p:PublishReleaseCandidate=false -p:SkipItAdminPublish=true -p:SkipDevBundle=true`, `ApprovedCeSharedRoot` = that Civil bundle's Win64 folder with its three CE_SHARED hashes (Legacy B3F046F6..., Net8 8207B210..., Modern 2CA25074...). **"[CE_SUITE_MANAGER] Complete 75-file, three-lane release candidate verified."**, 0 warnings, 0 errors, exit 0; my own count of the prepared bundle: 75 files. The guard is `Modules/Manager/CE_SUITE_MANAGER.csproj:297` (exactly 75), unchanged; no Manager file added. Output only inside my worktree (`Modules\Manager\Installer\payload_build`), never the c1058 to c1062 candidate folders; removed with the worktree.
3. **CE_SHARED:** the new Civil and new Manager bundles carry byte-identical CE_SHARED in all three lanes. They differ from the INSTALLED C-65 copies only by the commit stamp inside the file (installed `1.1.0+inspector-contract.1.2c805a39...`, new `...777e0013...`, same size 650,752 bytes for Modern); the Shared source diff is empty. The payload builder stamps the release; it should again see one CE_SHARED for both halves.
4. **What Manager now does, in plain words (from the two REGRESSION_LOG entries and the diffs):** (1) if the office approvals file for a plugin is damaged, the CE status no longer says "CE is current."; it names the installed plugin it could not check, says you can keep drafting, and asks you to get the office to check the approvals file; the damaged file is left as it is; a real update elsewhere still shows first. (2) Drawing Repair's note now reads "Inspect only looks. Fix it changes the drawing." before and after a repair.

## 6. Do not mark FIXED (each needs a robot PASS plus a Codex PASS in AutoCAD on copies)

1. **BUG-1137 (#1778):** can only be proven on AutoCAD 2022 to 2024 (Tim's 2027 PC shows no change).
2. **BUG-1188 (#1773).**
3. **BUG-1101 (#1770).**
4. **BUG-1179 (#1769, Manager):** needs a copy of the office approvals folder with a damaged `approved.json`.
5. **BUG-1097 (#1772).**
6. **BUG-1168 (#1775).**
7. **BUG-1202 (#1776).**
8. **BUG-1151 (#1777):** can only be proven on AutoCAD 2022 to 2024 without the CE pipe add-on.
9. **BUG-1180 (#1774, Manager).**
10. **BUG-1215 (#1768).**
11. **BUG-1090:** not in this train (#1771 left out).

## 7. Questions for Tim (work hours; RULES 3.2; none turned into a decision)

1. **(a) The sentence on every council computations sheet (#1771, BUG-1090; QUESTIONS_FOR_MONDAY item 9). PR left OUT of C-66.**
   1. **Context:** CE does not calculate a hydraulic grade line or pit losses, and the computations sheet does not say so.
   2. **What I understand:** #1771 adds one line at the end of BASIS OF DESIGN on every sheet, and one row in CDRULES: "Hydraulic grade line and pit losses: not calculated by CE. Each pipe is checked full-bore on its own grade only; where the council asks for a hydraulic grade line, check it separately."
   3. **Recommendation: yes, print it** (the reviewer's view), because without it a council reviewer can read the sheet as a full hydraulic check. Shorter option: drop the middle sentence.
   4. **On a job:** (yes) every OSD computations sheet for Frankston, Banyule or Whitehorse carries the line; a reviewer asking for an HGL knows to look for a separate check. (no) the sheet stays as today and says nothing about it.
2. **(b) Which head the 300 mm charged-system minimum means (#1772, BUG-1097). PR IN the train, built as below.**
   1. **Context:** the CDCALC Charged System tab now warns when the head is under 300 mm (R-13).
   2. **What I understand:** it uses the head you type in "Available head (m)". The other reading is the head left after the pipe losses.
   3. **Recommendation: keep it as built,** because it is a warning only and never blocks.
   4. **On a job:** type 0.25 m: "Available head 250 mm is under the 300 mm minimum for a charged system (R-13)." and the results still show. With the other reading, a 0.45 m head that loses 0.20 m in the pipes would also warn.
3. **(c) Survey XREF detached after CDSURVEY approved it (#1756, BUG-1189; item 5). PR left OUT.**
   1. **Context:** the fix stops CE offering stored survey levels from an XREF that has moved, turned or been rescaled since you approved it.
   2. **What I understand:** the same check also fires when the XREF is DETACHED: CE says "the XREF is no longer in this drawing" and stops offering survey levels until it is back. Typed levels always work. One switch covers both.
   3. **Recommendation: keep it as built** (the reviewer's view), because a wrong level on a pit is worse than retyping one. I left it out only because it changes an everyday habit and needs your word.
   4. **On a job:** (keep) you detach the heavy survey XREF to speed up the drawing; New Pit stops offering survey levels until you reattach it. (warn only) the levels are still offered with a warning; if the XREF had moved before the detach, they could be wrong.
4. **(d) Stage drawings: a BIND versus an accidental detach (#1767, BUG-1149; item 6). PR left OUT.**
   1. **Context:** a Pit Schedule built from a stage drawing (Xref) cannot tell a deliberate BIND from an accidental detach.
   2. **What I understand:** with the PR, both give a yellow warning ("SOURCE NOT FOUND ... if you bound the Xref, the schedule is frozen as placed"), not a red QA Fail. Another source that is out of date or unloaded still fails.
   3. **Recommendation: keep the yellow warning** (the reviewer's view), because a red Fail on every normal BIND teaches drafters to ignore Fails. I left it out because today an accidental detach is a red Fail and the PR softens that.
   4. **On a job:** (yellow) you bind Stage 1 into the master and get one warning instead of a failed QA sheet, but an accidental detach also only warns. (red) the bind fails QA until the drafter confirms it was a bind.
5. **(e) Roughness for a pipe with no material (#1664, BUG-868, from C-63): unchanged, still BUILT, NOT ACCEPTED.** A pipe with no recorded material is sized with the Settings "not recognised" value 0.013 (as rough as concrete; errs safe). On a job: a 225 at 1 in 100 needing 50 L/s with no material typed is proposed one size up; typing UPVC brings the 225 back. My new test pins 0.013 again.
6. **(f) Finer storm sweep near the peak (#1656, BUG-904): parked.** A peak between two tested storms can read 2 to 3 per cent short with nothing said ("a 25 m3 tank could really need about 25.6 m3"). Recommendation: build the finer sweep in a later train.
7. **(g) Heartbeat on a PC with no approved-address record (#1620, BUG-990, WAITING; REVIEW_PILE_B10 item 6, as restated by the C-65 finalizer).** With #1620, http is always refused; https goes to any address when the PC has no record. On a job: a PC set up by hand with a mistyped address and no record sends its key there every morning. The reviewer recommends taking #1620 as it is for the 9 Nov pilot, then making the record compulsory. Not in this train.
8. **(h) The CDHELP web address (#1167, BUG-555).** CDHELP would open `https://help.creativeeng.com.au/...` only if `help.openWebFallback` is ON; it ships OFF. Is that the company's own address? Recommendation: leave it OFF until you confirm.
9. **(i) #1776 follow-up (not a Tim question; for the next round):** reuse the logger's 3-try retry on the weekly export's file read (section 4 item 7).

## 8. Left out and why

1. **#1771** (BUG-1090): needs Tim's yes on the sentence; none recorded.
2. **#1756** (BUG-1189) and **#1767** (BUG-1149): Tim's decision; contested case not shown safe (1.5).
3. **#1706** (BUG-225): REDO-safety relevant; not taken.
4. **WAITING, unchanged:** #1643, #1593, #1588, #1657, #1691, #1000, #1620, #1195, #1198 (no fix pushed).
5. **Reviewed earlier but not taken:** #1720 (four later commits never re-reviewed), #1047 (needs a carpark bug first), #1314 (plan item, paused).
6. **Shared, Installer and signing PRs (left out on purpose, untouched):** #992, #1649, #1652, #1234, #1235.
7. **Already in the base:** 233 open PRs whose heads are already contained (list section 7); none merged again; nothing closed (D6).
8. **Structural:** not in this train.

## 9. Not tested, risks, hygiene

1. **Not tested:** anything in AutoCAD or accoreconsole; any window or picture (the Catchments tab, the Charged System warning, the Manager status and Drawing Repair note were not looked at); the Installer suite (compiled only); Structural (compiled only); `CE.TestHarness.Tests` built, not run; a net8 test run; a real 2022 to 2024 drawing for #1778 and #1777; a damaged approvals file on a real office folder for #1769; the Civil bundle I built is NOT releasable (0-byte transform placeholder): it only supplied CE_SHARED.
2. **Risks:** the CDCALC Catchments tab now opens empty for everyone (intended); a colleague PC already stuck on the local job-time folder stays stuck until the desk checks it; on 2022 to 2024 a copied downpipe left as AutoCAD copied it may be picked up by the nearby-pipe relink (LOW, 1.2.1.6); the Settings window is at 670 px, so the next row on its tallest tab fails the fit test.
3. **Build lock** `C:\CE_PLAN\desk_jobs\build.lock`: free at 10:13; my runners took it for each step with my own process id and released it after; never deleted while held by another. Absent again at 11:03 (no lock file of mine left behind).
4. **Every dotnet command:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release, `_AcadRef48` CERef 24.3.0, `_AcadRefNet8` autocad-2026-ref, `_AcadRefNet10` AutoCAD 2027, `_AcadRef100` autocad-net8-ref, AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked, ignored bin folder), nine projects restored one by one first (all exit 0), the solution built with `-m:1` and the normal TEMP, test steps with their own TEMP and CE log folder inside it (`C:\fin66\t_<step>`), `VSTEST_CONNECTION_TIMEOUT=900`, Below Normal (set on the dotnet processes the runner saw start). The Manager release build and the Civil bundle used their scripts' own refs. Nothing deployed: nothing written under APPDATA.
5. **Lesson 13 for the next finalizer:** Windows PowerShell started from this bash inherits the PowerShell 7 module path and then cannot find `Get-FileHash`; set `PSModulePath` to the two Windows PowerShell module folders in the runner. And give test steps TEMP in Windows form (`C:\fin66\t_x`, backslashes): five Manager hygiene tests compare the path text.
6. **Removed at the end:** worktree `C:\fin66\w` (`git worktree remove --force`, clean at `777e0013`), its local branch `fin66`, my three temporary refs for #1771, #1756 and #1767, and the whole `C:\fin66` folder (test temps, the Civil and Manager payload folders). My scratch scripts and logs under `C:\ce-fin\c66` are removed after this report is pushed. The remote train branch stays. The SUPERSEDED archive stays. Main checkout: the same untracked items the C-65 finalizer noted (`.codex/`, `Modules/Structural.Tests/Models/BracingLengthSettingsTests.cs`, `release-v3-colleagues-TEAMLANE4_LOG.md`, `tmp/`, one odd-named folder): another session's, left alone. The job log `desk_jobs\train_c66_finalizer_job.log` was held open by the desk runner, so I did not write to it.

## Summary

GO at `777e001321668a6fb1aa1ffb564c5b5cacd20257` on `claude/rel-20261025p`. All ten merged PRs read in full; no ask open; #1771, #1756, #1767 and #1706 not taken (no Tim answer). One commit by me: `C66NewSwitchDefaultsTests` (six bug-fix switches ON). Solution 0 errors on net48, net8, net10; Civil net10 20,303, 0 failed; Manager 1,002, 0 failed; net48 focused the same 51 reference-only reds; REDO 25 of 25; Settings fit 670 px; Manager release guard 75 files. Shared and Installer untouched. Nothing tested in AutoCAD.
