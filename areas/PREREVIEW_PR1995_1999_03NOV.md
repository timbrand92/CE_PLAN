# Opus pre-review: draft PRs #1995 to #1999 (Civil, five bug fixes)

Written Monday 2 November 2026, about 8:30 pm Melbourne time, by a read-only Opus reviewer for CE 05 on the CE 00 order of 20:45 (deep queue to Tue 08:30).
Fetched `origin` first (8:2x pm). Heads reviewed: #1995 26afae19, #1996 6e3b64df, #1997 352a838b, #1998 6f5a80d9, #1999 3a6a0b80. All five sit directly on `claude/rel-20261102a` at 3fbb9da5, one commit each, none stacked.

**What I did:** read the five diffs (`gh pr diff`), the PR texts, and the base code each one calls. I ran read-only `git merge-tree` checks.
**Built:** nothing. **Tested:** nothing. **Opened in AutoCAD:** nothing. I did not read or write Tim's real settings files.
**NOT proven:** every claim below about behaviour comes from reading code. The PR authors' test counts are their own; I did not re-run them.

Output path note: the order named `C:\CE_PLANreas\...`. That folder does not exist; I read it as `C:\CE_PLAN\areas\` (a lost backslash) and wrote here.

---

## FOR TIM

1. **None of the five is in what you have installed.** Civil 3.0.89 (61fd6fbc) contains none of them, and neither do the next two candidate builds (3.0.90 at cf059dcf, and rel-20261110a). Checked with git, after a fresh fetch.
2. **#1995, LandXML levels in millimetres: FIX FIRST (one line, two minutes).** A millimetre file with cover 100200 now reads cover 100.20 m, not 100200. The fault: it also strips an invisible marker from the first line of the main settings file. That is an unrelated change in the file every PR touches. Put it back, then GO.
3. **#1996, New Pit and Edit Pit go on with a blank cover: GO.** The button stays live, the cover stays blank (never 0.000), one line says so. Side note for the bug list: CDCALC's detention storage silently leaves out a pit with a blank cover. That gap was already there, but more blank-cover pits will now reach it.
4. **#1997, New Pipe label no longer ends in "MIN.": GO.** "AT 1 IN 100 MIN." becomes "AT 1 IN 100", as you ruled on 26 Sep. One small clash with 3.0.89 in the settings file: keep both lines.
5. **#1998, Civil finds the office OneDrive folders like the Manager does: GO.** CDFEEDBACK, CDNEWDWG, CDWT and job time look in the OneDrive folder first. Two small follow-ups, written up below. Neither blocks.
6. **#1999, X-Civil PDF import reads every schedule page: GO.** A pit schedule over two sheets now brings in both sheets' pits. Not proven on a real multi-page PDF. The PDF reader still has its 45-second limit.
7. **One question waits for you (work hours, not now).** From #1995: a LandXML file that does not say its units is still read as metres, as before. Should it be "Unknown" instead? My recommendation: keep metres. Every file we have seen without units was in metres.
8. **Nobody has seen any of the five in AutoCAD.** No bug is fixed. The five clash with each other only in the change log (keep all), plus #1995 and #1999 in the settings file (keep both).

---

## THE SIX CHECKS, PER PR

The six checks from the order:
- switch ON by default
- OFF restores the old behaviour
- the default is tested through both start-up reads
- no CE_SHARED change
- no unlock of locked layers
- one normal commit, with a title that starts with the B-number

1. **#1995 B-172 BUG-1053:** all six pass, with one exception. The settings file loses its first-line marker (`Modules/Drainage/Models/UserSettings.cs` line 1, `-﻿using System;` / `+using System;`, a UTF-8 BOM removed).
2. **#1996 B-173 BUG-1042:** all six pass. The PR title starts with B-173, but the commit's own first line reads "BUG-1042: New Pit and Edit Pit go on when the cover level is blank" with no B-number. A merge commit will carry that line into history. Optional reword; not a blocker.
3. **#1997 B-174 BUG-027:** all six pass.
4. **#1998 B-176 BUG-1166:** all six pass. It adds a new plain source file `Shared/CE.OfficeFolders/OfficeFolderLookup.cs`. That is not the CE_SHARED project; it follows the `Shared/ExcelBinding` and `Shared/CE.Spine` pattern.
5. **#1999 B-177 BUG-900:** all six pass.

Nothing in any of the five touches a layer, an Xref, REFEDIT, a system variable, the view or a regen.

---

## DETAIL

### PR #1995, B-172 BUG-1053: LandXML cover, invert and sump levels converted to metres

1. **What changes for the drafter.** CDIMPORTLANDXML now reads the file's `Units` element. Millimetre, centimetre, feet and US-survey-feet levels are turned into metres before the believable-range check. Example: a file in millimetres, cover 100200 and invert 100000. Before, it showed "cover level 100200 m" and threw the invert away. Now it shows 100.20 and keeps the invert. A unit CE cannot convert (for example "inch" or "kilometer") gives Unknown levels plus a report line, and the import carries on (R-27). No Units element means metres, exactly as before.
2. **Code.** `Helpers/LandXmlParser.cs`:
   - `DecideLevelFactor` at lines 500-541 of the head.
   - The cover is converted in `ParseStruct` before `RoundCoverLevel`.
   - The invert is converted before `IsReasonableImportedLevel` (lines 305-313).
   - The sump range check uses the converted value (line 332), and the sump is converted before it is stored.

   Unknown unit: the cover and sump strings are blanked and the invert loop is skipped (`levelUnitUnknown ? Enumerable.Empty...`). That is correct and stops a 100.2 being read as metres.
3. **Consistent with the coordinate reading.** The existing `DecideFileScale` (base line 508) already trusts `Metric linearUnit` for positions. Levels now trust the same element, so the two cannot disagree on a Metric file. `DecideLevelFactor` also reads `Imperial`; `DecideFileScale` does not (it falls back to auto-detect there). That is acceptable: positions in feet were never supported.
4. **Switch.** `xcivilImport.landXmlLevelsConvertedToMetres`, ON. Both reads are pinned in `Switch_ShipsOn_ThroughBothStartUpReads`. OFF returns factor 1 at the top of `DecideLevelFactor`. `SwitchOff_RestoresTheOldReadingExactly` pins "100200.00" and no invert.
5. **FIX FIRST, the exact line.** `Modules/Drainage/Models/UserSettings.cs` line 1: the head drops the UTF-8 byte-order mark that the base file and 3.0.89 both carry. It is harmless to the build, but it is an unrelated whole-file change in the file all five PRs edit, and it will show on every later blame of that file. Restore the BOM (or let CE 05 restore it at merge), then GO.
6. **Small note (not blocking).** `FormatLevelMetres` (line 542-543) writes `"0.####"`, so a converted invert reads "IL 100" or "IL 99.85". A metre file keeps its own text ("IL 100.000"). The number read back is the same, so nothing on the drawing changes. Only the import's debug and evidence text differs. Optional: format `0.000`.
7. **Question for Tim (queue for work hours).** A file with no Units element is read as metres (PR body point 2). Recommendation: keep metres, because it is the old behaviour and nothing stated means nothing guessed. Do not turn this into a decision without Tim's word.
8. **Tests.** The fixture drives the real `LandXmlParser.TryParse` on temporary files (mm, m, feet, sump, unknown unit, no Units, switch off). That is real-caller coverage, not a pure-rule test.
9. **Not proven.** No real Civil 3D or 12d millimetre export was read. Nobody has run it in AutoCAD.
10. **Verdict: FIX FIRST** (line 1 BOM only). Everything else is GO.

### PR #1996, B-173 BUG-1042: New Pit and Edit Pit go on with a blank cover

1. **What changes.** PIT and PITEDIT no longer grey the button on a blank Cover level. The line reads "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out." Every other missing input still blocks.
2. **Code.**
   - `Rules/PitStartReadiness.cs` line 135: the block now needs `!i.BlankCoverWarnsOnly`.
   - Lines 92-95: the Attention line, placed after `FirstBlocker`, so a missing width still wins.
   - `ViewModels/PitViewModel.cs` line 392 feeds the switch, reading it each time the button is worked out.
   - No other blank-cover block exists in `PitCommand`, `PitEditCommand` or the Pit dialogs; I searched for one. `PitAnnotationTextFormatter` line 28 already leaves out the CL line when blank, so no "CL 0.000" text is drawn.
3. **Switch.** `pit.blankCoverIsWarningNotBlock`, ON. Both reads are pinned in `Bug1042BlankCoverWarnsTests.TheSwitch_ShipsOn_ThroughBothStartUpReads`, and typed false is pinned too. OFF gives back "Enter the cover level." exactly (`WithTheSwitchOff_TheOldBlockIsBack`).
4. **Older tests rewritten.** Three older tests that pinned the block now run with the switch OFF. The PR says so (REGRESSION_LOG point 5). `PitWindowPresentationTests` sets the switch without restoring it, but that fixture opens a fresh settings scope per test (`SettingsService.BeginTestScope` in `SetUp`, disposed in `TearDown`), so nothing leaks.
5. **Side risk for the carpark (not this PR's fault).** `ViewModels/DetentionCalcViewModel.cs` line 108 reads a blank cover as 0.0. With "use cover as TWL", the depth comes out negative, and lines 121-123 silently drop that pit from storage, with no warning line. That gap already existed for imported pits with blank covers. This PR makes blank-cover pits easier to create. Recommend a carpark entry: "CDCALC detention storage leaves out a blank-cover pit without saying so". (`DetentionSystemViewModel` is already guarded by `CoverLevelKnown`.)
6. **Open item the PR itself names.** The C-78 finalizer file does not list the new key yet. That is train work, not this PR's.
7. **Commit line.** The commit's first line lacks "B-173" (see the checks above). Optional reword.
8. **Verdict: GO.**

### PR #1997, B-174 BUG-027: New Pipe label no longer ends in "MIN."

1. **What changes.** New Pipe with the grade on Standard, only the first level typed and "I know one end" off: the label reads "AT 1 IN 100", not "AT 1 IN 100 MIN.". This matches Tim's UX-CPLAN-05 ruling of 26 Sep 2026, "Keep the May rule: no MIN."
2. **Code.** `Commands/CdCommand.Grade.cs` line 220 adds `&& !Rules.GradeLabelMinRule.IsOn(...)`. The fall-through returns `configured`, which `GetConfiguredDefaultGradeValue` has already stripped of any legacy " MIN." (base lines 382-392). It is the only place that adds the suffix; I searched the module.
3. **Switch.** `pipe.gradeLabelNeverMin`, ON. Pinned through both reads for `{}`, an empty pipe group and a pipe group with older keys. Typed false is checked against neighbouring pipe switches. Source guard: `TheOldMinLine_IsBehindTheSwitch`.
4. **Small wording note (not blocking).** The `Rules/GradeLabelMinRule.cs` comment (line 7) says a label "never ends in MIN. or MAX.". `FormatGradeForDisplay` still keeps a suffix if one arrives in the grade text (base lines 93-102). Only the one built-in path is closed. Suggested words: "the one-level New Pipe path no longer adds MIN.".
5. **Merge.** It clashes with 3.0.89 and with candidate 3.0.90 in `UserSettings.cs`, because `typedLevelRoundingNote` (BUG-685) was added at the same spot. Keep both properties.
6. **Verdict: GO.**

### PR #1998, B-176 BUG-1166: office OneDrive folders found in the Manager's order

1. **What changes.** Civil looks for "Creative Engineering - IT Admin" and "- Drafting" in this order:
   1. `%OneDriveCommercial%\<folder>`
   2. `%OneDriveCommercial%\Creative Engineering\<folder>`
   3. `Users\<you>\Creative Engineering\<folder>`

   Used by CDFEEDBACK, job-time export and its data folder, staged StructPlus blocks, and at settings load for Standard Details (CDWT) and Drawing Templates (CDNEWDWG).
2. **Same answer when nothing exists.** The old `TryGetItAdminRootFolder(string)` returned the profile path without checking that it exists. The new `OfficeFolderLookup.Resolve` returns the same path when no candidate exists, so an office-less PC behaves as before. A test run never reads the real OneDrive (`OfficeFolderLocator.OneDriveRoot` returns null while `LogFolderRedirect.Override` is set).
3. **Settings load.** `SettingsService.cs` line 110 calls `MoveOfficeFoldersOntoOneDrive` after `LoadSettings` and before the BUG-306 snapshot. The moved path is therefore treated as what the file holds, and is only written on a real save, the same as BUG-1167's `MoveOtherUsersFoldersOntoThisPc`. A folder that exists is never moved.
4. **Switch.** `linking.officeFolderFollowsOneDrive`, ON. Both reads are pinned in `TheSwitchHasADefault_OfOn_ThroughBothStartUpReads`, typed false too. OFF returns the old profile-only path (`OfficeFolderLocator.ItAdminRoot`, the `!followOneDrive` branch). Source guard: `EveryOfficeFolderLookup_GoesThroughTheOnePlace`.
5. **Follow-up A (LOW).** `Shared/CE.OfficeFolders/OfficeFolderLookup.cs` line 18 is `public static class`. Its sibling shared source `Shared/ExcelBinding/ExcelLibraryBinding.cs` is `internal`. Once the Manager links the same file (the PR suggests it will), two DLLs will both export a public `CE.OfficeFolders.OfficeFolderLookup`. Make it `internal`; tests reach it through InternalsVisibleTo as they do now.
6. **Follow-up B (LOW).** BUG-1167's sibling also moves `options.computationsFolder` (`SettingsService.FolderPaths.cs` line 64). The new move does not. If CDCALC computations are saved under the office Drafting folder, that path still will not follow OneDrive. Worth one line in the carpark entry.
7. **Design rule 1 note.** The old `TryGetItAdminRootFolder(string)` overloads stay, in `CivilJobTimeSettings.cs` line 132 and `FeedbackService.cs` line 57, now beside the new lookup. Remove them once nothing calls them.
8. **Not done here (the PR says so).** The Manager's own copy of the order, CE Blocks paths, and the fixed path line in `FeedbackDialog.xaml`.
9. **Merge.** Clean onto 3.0.89 and onto candidate 3.0.90. Clean against the other four PRs. It writes its change-log entry at the bottom of `REGRESSION_LOG.md`; the other four write at the top.
10. **Verdict: GO** (A and B can follow).

### PR #1999, B-177 BUG-900: X-Civil PDF import reads every schedule page

1. **What changes.** CDIMPORTXCIVIL with a PDF: every page titled PIT SCHEDULE and every page titled PIPE SCHEDULE is read. The rows join one list in page order, and repeats are read once. A titled page with no readable table becomes a warning line, and the import carries on.
2. **Code.**
   - `Services/XcivilScheduleService.cs` line 262 adds ` -AllPages` only with the switch ON.
   - In `Modules/tools/Extract-XcivilPdfSchedule.ps1`, the pit row reading moved into `Get-PitScheduleEntriesFromPage` (lines 514-669). The one-page mode calls it once and keeps the old "fail and exit" (it still writes `Success $false`).
   - I checked every variable the moved block set against its use further down the script: `$entries` is set at script level, and the pipe section re-assigns its own row variables before use. Nothing is lost in the old mode.
   - The title filter (`PIT SCHEDULE` match, then `continue`) still runs before a page is added to `$pitPages`, so plan sheets are not read.
3. **Switch.** `xcivilImport.pdfScheduleReadsAllPages`, ON. Pinned through both reads for three file shapes; typed false changes only itself (whole group compared). OFF passes no `-AllPages`, and the script's old path is pinned by text guards.
4. **Speed.** The 45-second limit (line 287, unchanged) still applies. The new mode caches each page's OCR (`$ocrCache`), so the pipe scan no longer reads each page a second time. It should be no slower than before, but that is not measured.
5. **Cosmetic (not blocking).** The `.ps1` line 526 lost a space (`$pitNoHeader    =$scheduleRows`). The function body is not indented.
6. **Not proven.** Nothing ran on a real multi-page X-Civil PDF, and Windows OCR is not unit-tested. Continuation sheets whose title OCRs as something other than "PIT SCHEDULE" are not detected; the PR says so.
7. **Merge.** Clashes with #1995 in `UserSettings.cs`: both add a key after `landXmlCircularDiameterFirst`. Keep both.
8. **Verdict: GO.**

---

## MERGE PICTURE (read-only `git merge-tree`)

1. **Against installed 3.0.89 (61fd6fbc) and candidate 3.0.90 (cf059dcf):**
   - #1998 merges clean.
   - #1995, #1996 and #1999 clash only in `REGRESSION_LOG.md`.
   - #1997 clashes in `REGRESSION_LOG.md` and in `UserSettings.cs` (the neighbouring BUG-685 key).
   - Keep both sides every time.
2. **Between the five:** every pair except those involving #1998 clashes in `REGRESSION_LOG.md`. #1995 and #1999 also clash in `UserSettings.cs` (same insertion point). Keep both.
3. **Already landed?** None of the five keys is in 61fd6fbc, cf059dcf or rel-20261110a, and the "MIN." line is still live in all three. Checked with `git grep`.

---

## SKIPPED, AND WHY

1. **Building and running tests:** not allowed by the order (read-only). Test counts quoted are the authors'.
2. **Opening AutoCAD or running the robot:** not allowed by the order.
3. **The C-78 finalizer key lists:** they belong to the next train finalizer, not these PRs. I only noted that #1996 names it.
4. **Structural line (rel-20261026s):** none of the five touches Structural, so I did not read it.
5. **The carpark and Tim's decisions files:** I relied on the rulings quoted in the PRs (UX-CPLAN-05 for #1997) and did not re-read the carpark entries. CE 05 should confirm the provisional bug numbers B-172 to B-177 against the carpark before merge.
