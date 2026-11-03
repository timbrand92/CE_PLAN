# Opus pre-review: draft PRs from jobs 300 to 307 as one group (#1995 to #1999) (Tue 3 Nov 2026, early morning, Melbourne)

Read-only drafting job for CE 05, on the CE 00 order of Mon 2 Nov 20:45 (queue job 310). Written by Opus. Nothing built, nothing tested, nothing installed, AutoCAD not opened.

## FOR TIM

1. **Verdict:** all five are ready to go into a build (GO). None needs a code change first. Two carry a note CE 05 should act on: #1998 fixes only the Civil half of BUG-1166, and #1999's "warning" for an unreadable page lands in the import's debug lines, not where a drafter would see it.
2. **Two jobs opened no pull request, so they are skipped:** BUG-1052 (CDAGI metre grade, fix only on a local branch) and BUG-396 (double-click opens Pit Schedule, stopped for a command card).
3. **None of the five is in what you have installed** (Civil 3.0.89), nor in the next two candidate builds (3.0.90 and b2). They only reach AutoCAD once a later build takes them in.
4. **What each does on the drawing:** a New Pipe label with one level typed reads "AT 1 IN 100", not "AT 1 IN 100 MIN."; New Pit and Edit Pit let you Place or Save with the cover level blank (it stays blank, never 0.000); a millimetre LandXML file's cover 100200 comes in as 100.2; CDFEEDBACK, job time, Standard Details and Drawing Templates find the office folders on a OneDrive shortcut; a PDF pit or pipe schedule over several sheets is read in full.
5. **Every one has an off switch** that puts things back exactly as they were. All five ship ON.
6. **Not proven:** nobody has opened any of these in AutoCAD. The PDF change has never been run on a real multi-page schedule; the OneDrive change has not been tried on Max's PC, which the bug entry asks for before 9 Nov.
7. **Nothing new for you to decide.** BUG-027 follows your ruling of 26 Sep ("Keep the May rule: no MIN.").
8. **Nothing for you to do tonight.** CE 05 merges in the order below and records the two notes.

---

## What I did

1. **Read:** `C:\TimOS\RULES.md`; the reference review `areas\OPUS_PREREVIEW_1989_1993_02NOV.md`; the robot case drafts for this same group (`areas\ROBOT_CASE_DRAFTS_W1052_W900_02NOV.md`, header and skipped list), which is how I matched jobs 300 to 307 to PRs; the reports `BUGFIX_w1042_REPORT_03NOV.md` (in full) and `BUGFIX_w1166_REPORT_03NOV.md` (the scope and isolation parts); the carpark entries for BUG-027 and BUG-1166; the five PR diffs against `origin/claude/rel-20261102a`; the surrounding code: `BuildGradeValue` and `GetConfiguredDefaultGradeValue` (#1997), `PitStartReadinessRule` and the cover-level readers (#1996), `LandXmlParser.ParseStruct` and `DecideFileScale` (#1995), `SettingsService.LoadFromDisk` and the Manager's `GetItAdminPath` (#1998), the whole page-reading part of `Extract-XcivilPdfSchedule.ps1` and where `XcivilScheduleService` puts its log (#1999); the settings-read lines of each new test file.
2. **Fetched first:** `git fetch origin` at the start, then each PR head with `git fetch origin pull/N/head` (this made five local remote-tracking names `origin/pr/1995` to `origin/pr/1999`; no branch, nothing pushed). PR list confirmed with `gh pr list` by its full path.
3. **Merge check:** `git merge-tree` of each PR into 3.0.90 and into b2, and of the PRs against each other. **Own slip:** for the first pass (each PR into the two builds) I used the newer form, which stores its trial result as loose objects in the local git store. It moves no branch and changes no file, but strictly it is a write. The pair-by-pair check used the old form, which writes nothing.
4. **Built:** nothing. **Tested:** nothing (I read the tests, I did not run them). **Installed:** nothing. **Opened AutoCAD:** no.

## Where the five sit (the build question)

1. **PR heads:** #1995 = 26afae19, #1996 = 6e3b64df, #1997 = 352a838b, #1998 = 6f5a80d9, #1999 = 3a6a0b80. Each is one commit on top of `origin/claude/rel-20261102a` = 3fbb9da5 (Civil 3.0.88). All are open drafts.
2. **In installed 3.0.89 (61fd6fbc):** none of the five (`git merge-base --is-ancestor` false for all five heads).
3. **In candidate b1 = 3.0.90 (`rel-20261108a`, cf059dcf):** none. **In b2 (`rel-20261110a`, now aa3b92ac, not the d4ce878e of last night's review):** none. The old BUG-027 line (`configured + " MIN."`) is still present in all three builds, so no copy of that fix came in another way. The robot drafts job searched the three builds for every new switch name and found none; I did not repeat that search.
4. **Consequence:** like last night's group, these were written and unit-tested against 3.0.88, not 3.0.89.

## Per PR

### #1997 (B-174, BUG-027): a New Pipe label no longer ends in "MIN.". Verdict: GO

1. **Does what the ruling says, nothing more:** yes. The one remaining path that added " MIN." (Default grade, one level typed, "I know one end" off) now returns the bare grade when the switch is ON. Labels worked out from two levels never had MIN. and are untouched. The default grade from Settings is already stripped of any old " MIN." text before this point, so nothing slips through.
2. **Slightly wider than the PR name:** the line covers Default Minimum as well as Default Standard (whichever default is active), not Standard alone. That matches the ruling ("no MIN." anywhere), so no change asked; the log wording just undersells it.
3. **OFF gives the old behaviour exactly:** yes; the old line runs unchanged when `pipe.gradeLabelNeverMin` is false. The stored grade on the pipe (its hidden data) follows the label, "1 IN 100" instead of "1 IN 100 MIN."; nothing I found reads "MIN." back to decide anything (only the grade readers, which strip it).
4. **Switch through both start-up reads:** yes, `{}` and `{"pipe":{}}` through `DeserializeSettings` and `DeserializeSettingsTolerant`, typed false reads false, plus a source guard (read, not run by me). The two changed `GradeAutoCalcTests` set the switch on the live settings and put it back in `finally`.
5. **CE_SHARED:** none. **Locked layer / Xref:** no new drawing write; label text only. **Hard-coded engineering value (R-00):** none. **REDO:** text choice only, safe.
6. **Merge note:** "keep both" overlap with 3.0.90 in `UserSettings.cs` (BUG-685's setting sits at the same spot) and in `REGRESSION_LOG.md`.
7. **Not proven:** the drawn label. Robot case W1027 (drafted, not run) is what proves it.
8. **The one sentence for Tim:** "A pipe drawn with only its first level typed now reads 'AT 1 IN 100', never 'AT 1 IN 100 MIN.'."

### #1996 (B-173, BUG-1042): New Pit and Edit Pit go on with a blank cover level. Verdict: GO

1. **Does what the carpark says:** yes. The one "Enter the cover level." stop is skipped when the switch is ON; every other stop (pit number, type, widths, SPS radius, invert not a number, rotation, offset) still comes first. The line under the window then reads "The cover level is blank: it is saved blank (Unknown) and nothing that needs it is worked out." in the attention colour.
2. **Never 0.000:** the cover is stored as the typed text (blank). I checked the places that read a pit's cover: they all try to read a number and skip when they cannot. Blank covers already arrive today from imports, so this adds no new kind of pit to the drawing.
3. **Small note, no change asked:** a detention pit with a blank cover shows the blank-cover line instead of the "Detention mode is active" note (only one line fits). Acceptable; the blank cover matters more.
4. **OFF gives the old behaviour exactly:** yes; same words, same field highlighted, button grey. Five older tests that pinned the old stop now run with the switch OFF, which is right.
5. **Switch through both start-up reads:** yes, four file shapes plus typed false (read, not run).
6. **CE_SHARED:** none. **Locked layer / Xref:** the save path itself is unchanged. **R-00:** none. **REDO:** no new write.
7. **Merge note:** `REGRESSION_LOG.md` only against 3.0.90. The report warns `PitViewModel.cs` is touched by other older drafts (#705, #715, #724, #734); expect a "keep both" on that one line if those land first.
8. **Not proven:** the window line on screen, and Edit Pit's Save (the robot cannot press it). The pit window's depth estimate and the setup advisor were not driven with a blank cover. Needs the Codex look in the robot drafts file.
9. **The one sentence for Tim:** "In PIT you can leave Cover level blank and still press Place; the pit is placed with no cover level, never 0.000."

### #1995 (B-172, BUG-1053): LandXML levels converted to metres. Verdict: GO

1. **Does what the carpark says:** yes. The file's own unit (its Units element) converts the cover, every invert and the sump to metres **before** the "is this a believable level" check, so a millimetre file's 100200 now reads 100.2 instead of being thrown out as 100 km. Millimetres, centimetres, feet and US survey feet are handled; a file with no unit stated is read as metres, as before (nothing guessed).
2. **A unit CE cannot convert** (say inches or kilometres): those pit's levels come in Unknown, with a line "levels are Unknown: the file names a length unit CE cannot convert to metres: type the levels with PITEDIT." in the import report, and the import carries on (R-27). That line is added to the report's filter, so it does reach the report.
3. **Small note, no change asked:** pit positions are still scaled by the older rule, which only knows metres and millimetres. A feet or centimetre file now gets right levels but positions guessed as before. Australian files are metres or millimetres, so this is theory only.
4. **Stray change, fix when merging:** the PR strips the invisible marker at the very start of `UserSettings.cs` (first line shows `-﻿using System;` / `+using System;`). It does no harm to the build, but it is not part of the fix. Put it back when merging so the file's history stays clean.
5. **OFF gives the old behaviour exactly:** yes. OFF returns factor 1, so nothing is converted and no level is made Unknown; I traced the reordered invert check and it rejects exactly what the old one did.
6. **Switch through both start-up reads:** yes, both reads, typed false (read, not run).
7. **CE_SHARED:** none. **Locked layer / Xref:** reading only. **R-00:** the unit factors are fixed unit definitions, not engineering values. **REDO:** reading only.
8. **Merge note:** a real "keep both" overlap with #1999: both add their setting at the same place (after `landXmlCircularDiameterFirst`). Keep both lines. Plus `REGRESSION_LOG.md`.
9. **Not proven:** a real millimetre LandXML file imported in AutoCAD. The robot cannot pick a file in the file box, so this is a Codex step.
10. **The one sentence for Tim:** "A LandXML file saved in millimetres now brings its pit covers and inverts in as metres (100200 reads 100.2) instead of dropping them."

### #1998 (B-176, BUG-1166): Civil finds the office OneDrive folders in the Manager's order. Verdict: GO, Civil half only (BUG-1166 stays open for the Manager half)

1. **Does what it says for Civil:** yes. One small shared file (`Shared\CE.OfficeFolders\OfficeFolderLookup.cs`, linked into Civil by one line) gives the order: the OneDrive folder first, then OneDrive's "Creative Engineering" folder, then the plain `Users\<you>\Creative Engineering` path. I checked it against the Manager's `GetItAdminPath`: same three places, same order. CDFEEDBACK, job time, CDWT's Standard Details, CDNEWDWG's Drawing Templates and the staged blocks now ask it.
2. **What it does not do (the report says so plainly):** the carpark asks for "one shared office-folder lookup used by both, and plain wording in CE Blocks". The Manager still has its own copy of the order, and CE Blocks (`CeBlocksSettings.cs`, Manager code) still looks only under the profile. So on Max's PC, if his folders are a OneDrive shortcut, CDFEEDBACK should now reach the office but CE Blocks will still say its palette files are unavailable. **CE 05: keep BUG-1166 OPEN and queue a Manager job** (link the shared file, point CE Blocks at it, plain wording). The carpark's "look at Max's real layout before 9 Nov" is also still not done.
3. **One behaviour to know, no change asked:** at start-up, a Settings folder written as the plain profile path that does not exist on this PC is swapped in memory for the OneDrive one (a folder that exists is never moved). The start-up snapshot is taken after the swap, so a routine save does not write it. But the next time anything real is saved in Settings, the OneDrive path is written into `CD_Settings.json`. After that, turning the switch OFF does not bring the old path back for that user. Harmless (it is that PC's own settings file), but the "OFF = exactly old" claim holds only until a Settings save.
4. **OFF gives the old behaviour exactly (before any save):** yes. OFF returns the plain profile path, same as the old code, which also did not check the folder exists.
5. **Tests stay off the real share:** the OneDrive lookup returns nothing while a test run's log redirect is set, mirroring the Manager. Good.
6. **Switch through both start-up reads:** yes (read, not run).
7. **CE_SHARED:** not touched. The new file is under `Shared\` but is a plain source file linked by Civil only, not part of the CE_SHARED project; Structural and the Manager do not compile it yet. **Locked layer / Xref:** no drawing work. **R-00:** none. **REDO:** none.
8. **Merge note:** merges cleanly into 3.0.90 and b2 with nothing to resolve (its change-log entry went at the bottom of `REGRESSION_LOG.md`, the others at the top; harmless).
9. **Seen while reading, not part of this PR:** `LayerService.cs` line 262 still has `C:\Users\TimothyBrand\...` written into the code for the linetype template drawing. On any other PC that path does not exist. Worth a carpark check by CE 05 (I did not search whether it already has an entry).
10. **Not proven:** a real PC with the folders only on a OneDrive shortcut. The robot cannot change which folders exist; Codex step or Max's PC.
11. **The one sentence for Tim:** "On a PC where the office folders came in as a OneDrive shortcut, CDFEEDBACK reports, job time and the template folders now find them; CE Blocks does not yet."

### #1999 (B-177, BUG-900): X-Civil PDF import reads every schedule page. Verdict: GO, with one wording correction

1. **Does what it says:** yes. With the switch ON the reading script is run with one extra word (`-AllPages`). Every page titled PIT SCHEDULE is read and the rows joined in page order; the same for every page titled PIPE SCHEDULE. A pit number seen twice (a sheet repeated in the package) is read once; a pipe row is read once by from, to, size and length. Each page is OCR'd once and reused for the pipe scan, so it is no slower than before for the pit part.
2. **One reading path:** the per-page pit reading was moved into one function used both ON and OFF. I read the whole function: it ends in the same two failure points as before, and the OFF caller writes the same "failed" result and stops exactly as the old code did. I found no stray output inside the function that could spoil its answer (a common PowerShell trap).
3. **Wording correction (CE 05, not code):** the PR, the setting's description and the change log say an unreadable titled page is "a warning in the import report". In the code it is a line in the script's log, which CE copies into the import's debug lines as "PDF schedule OCR: warning: pit-schedule-page-no-table page=3 (...)". I did not find it in the drafter-facing report. Either correct the wording or add the line to the report in a later job. Not a blocker: the import still carries on (R-27) and nothing wrong is drawn.
4. **Small note, no change asked:** if one pit is listed twice with different sizes on two sheets (an old and a revised sheet in one package), the first sheet wins and the second is only logged. Rare; worth one line in the robot or Codex notes.
5. **OFF gives the old behaviour exactly:** yes; no extra word is passed, and the script without it takes the old one-best-page route for pits and the old best-page route for pipes.
6. **Switch through both start-up reads:** yes, three file shapes, typed false, and a check that ON adds " -AllPages" and OFF adds nothing (read, not run).
7. **CE_SHARED:** none. **Locked layer / Xref:** reading only; nothing drawn. **R-00:** none. **REDO:** reading only.
8. **Merge note:** "keep both" with #1995 in `UserSettings.cs` (same spot), plus `REGRESSION_LOG.md`.
9. **Not proven, and the biggest gap in this group:** the changed script has never been run on a real multi-page PDF schedule (the tests check the settings and the command line, and read the script's text). It needs a Codex run on a real two-sheet schedule before anyone calls BUG-900 fixed.
10. **The one sentence for Tim:** "CDIMPORTXCIVIL now reads every sheet of a pit or pipe schedule PDF, so pits on the continuation sheet keep their sizes and levels."

## Points that apply to the whole group

1. **All five rest on Civil 3.0.88, not 3.0.89.** Each merges into 3.0.90 and b2 apart from routine "keep both" overlaps: `REGRESSION_LOG.md` in four of them, `UserSettings.cs` for #1997 (with BUG-685 in 3.0.90), and `UserSettings.cs` between #1995 and #1999. No pair clashes in product code.
2. **Order suggestion for the train:** #1995 then #1999 (resolve their one shared spot), then #1996, #1997, #1998 in any order. Keep every settings block.
3. **Real-file listings:** the robot drafts job and the w1042 report say Tim's real `CD_Settings.json` came back dated 4 Oct (15,270 bytes) during these runs; the w1166 report saw live-AutoCAD files change too. Each says it cannot prove the writer. I did not check (read-only job, and I do not open Tim's settings). CE 01 should look before any merge, as the drafts file already asks.
4. **None marked FIXED,** correctly. All five bugs stay OPEN until the ledger accepts them by name.

## Skipped, and why

1. **BUG-1052 (job 301, CDAGI metre grade):** no PR. `gh pr list` found none and no branch for it exists on origin (confirmed again tonight).
2. **BUG-396 (job 306, double-click opens Pit Schedule):** no PR; the job stopped for a command card. The older BUG-396 PRs (#674 to #747) are other items.
3. **Jobs 300 to 307 are eight numbers but only seven bugs have reports;** I found no eighth job, same as the robot drafts job.
4. **#1994 (B-168, BUG-1273)** sits next to these numbers but comes from another job group; not reviewed here.
5. **Did not build or run any test** (read-only order). Every "yes" about tests above is from reading the test files, not running them.
6. **Did not read every line of each test file,** nor the reports for w027, w1053 and w900 in full.
7. **Did not check the installed DLL's version string;** "Civil 3.0.89 = 61fd6fbc" is the order's word.
8. **Output path:** the order named `C:\CE_PLANreas\...`, which does not exist; read as `C:\CE_PLAN\areas\` (the backslash-a was lost). Written there. Not committed or pushed (CE 05 pushes).
