# BUGFIX w900 report (B-177, BUG-900), 3 Nov 2026

## FOR TIM

1. **My own mistakes first:**
   - **AutoCAD settings folders:** my before and after listings of the CE settings folders in your AutoCAD data area differ. Files changed at 06:19 to 06:22 am Melbourne on 3 Nov (CD_RecentValues.json, suggestions.jsonl, the session and machine files for Civil, Structural and Manager, and the Civil and Structural logs). No AutoCAD was running. The first two changes happened while I was only compiling, before any test code ran. The burst at 06:22:17 (all three suites at once, each "started and shut down clean" within a millisecond) looks like another job's test start-up, but I cannot prove it was not mine. I ran only the focused test sets below, with my own scratch folders set for temp and logs. Rule 1 says to stop and say so first: I had already finished my tests, so I stopped running anything and am telling you now. Nothing of yours was edited by me on purpose. Please have someone check whether another job was running at 06:22.
   - **Wasted runs:** two of my test-runner attempts failed before running anything (wrong program path, then a quoting slip). No cost beyond minutes.
2. **What you will see differently:** import an X-Civil PDF whose pit schedule runs over two or more sheets (each sheet titled PIT SCHEDULE). CE now reads the pit sizes and levels from every sheet, not just one. The pipe schedule is also read from every sheet, instead of only the last one. A sheet titled PIT SCHEDULE or PIPE SCHEDULE with no readable table is noted as a warning in the import report and the import carries on.
3. **Settings switch:** `xcivilImport.pdfScheduleReadsAllPages`, on by default. Off gives back the old one-sheet reading exactly. CE reads settings at AutoCAD start, so set it before launching.
4. **What is NOT proven:**
   - Nobody has run this on a multi-page PDF or opened it in AutoCAD. The page reading needs Windows text recognition and a real PDF, so no unit test covers it. Only the switch, the command line and the script's shape are tested.
   - A continuation sheet that does not read as "PIT SCHEDULE" at the top is not detected and gets no warning.
   - BUG-900 is not fixed until a real multi-page PDF is imported.
5. **Robot case that would prove it (name it N40_xcivil_pdf_pages):**
   - **Needs:** a PDF with the pit schedule split over two sheets (no such sample exists in the repo that I found; a Codex brief or you must supply one) and its DWG.
   - **Types:** CDIMPORTXCIVIL, pick the DWG and the PDF, finish the import, then open the import report.
   - **Checks (switch ON):** the report has a line `pit-schedule-page-read page=1 rows=N` and `page=2 rows=M`, and `pit-schedule-total-rows=` equal to N+M. Pits on sheet 2 carry sizes and levels.
   - **Control (switch OFF):** set `xcivilImport.pdfScheduleReadsAllPages` to false before launch, repeat: no `page-read` lines, and pits on the other sheet come in without sizes and levels, as today.

## Technical detail

1. **Pull request:** draft #1999, base `claude/rel-20261102a` (not stacked), branch `claude/w900-xcivil-pdf-all-pages`, commit 3a6a0b80. One commit.
2. **ALREADY FIXED check:** 61fd6fbc is not in the base. At the base the fault is present: pit selection `if ($headerScore -le $bestHeaderScore) { continue }` keeps one `$scheduleRows`; pipe loop `$pipeScheduleEntries = $currentPipeEntries` replaces the list on each page (`Modules/tools/Extract-XcivilPdfSchedule.ps1`, lines 480 and 819 before the change).
3. **Files:** `Modules/tools/Extract-XcivilPdfSchedule.ps1` (new `-AllPages` switch; pit-row reading moved into one function used by both modes; page collection, de-duplication, warnings, OCR cache), `Modules/Drainage/Rules/XcivilPdfSchedulePagesRule.cs` (new), `Modules/Drainage/Services/XcivilScheduleService.cs` (passes ` -AllPages` when on), `Modules/Drainage/Models/UserSettings.cs` (the switch, "Default: on."), `Modules/Drainage.Tests/Services/B177XcivilPdfAllPagesTests.cs` (new), `REGRESSION_LOG.md`. CE_SHARED untouched. No window change, so no Codex brief.
4. **Design notes:** with the switch off the script path is the old one (old selection lines kept, a failed page still writes its failure result and exits). Row numbers run on across pages so the C# pairing by order still works. A pit named twice and a repeated pipe row are kept once. The pipe scan reuses the OCR of each page.
5. **Tests (net10.0-windows, Release, one project, filtered, isolated scratch TEMP/TMP/CE_LOG_DIR_OVERRIDE):** B177 filter 8 of 8 passed; related filter (script path, C78 new-switch defaults, PDF schedule sanity, path helper) 89 of 89 passed; both counts above zero. The switch is pinned through `DeserializeSettings` and `DeserializeSettingsTolerant`. The script parses with the PowerShell parser (0 errors). net48 compile of `CE_CVL_SUITE.csproj`: 0 errors. Manager tests not run. The full commands used are in `C:\CE_WORK\scratch\w900\*.ps1` (scratch, removed at cleanup).
6. **Settings-folder listings (rule 1):** before `the before listing (36412 lines), after (36414 lines); the changed lines are listed in point 1 of the FOR TIM block (14 changed or new files, none a settings file of yours: CD_RecentValues, the suggestions ledger, session and machine heartbeats, logs).
7. **C: free space:** 28.2 GB before the first build; after build output was cleared (git clean -fdXq), the worktree removed and the scratch folder removed, 28.6 GB (about 0.5 GB released). The two full listings were removed with the scratch folder; the changed lines are in point 1.
