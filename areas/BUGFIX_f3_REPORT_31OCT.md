# BUGFIX f3 report: BUG-505, the "check the scale" warning now shows on the X-Civil import window (31 Oct 2026)

## FOR TIM

1. **Answer first:** draft PR #1926 (B-112). When you import an X-Civil drawing, the "Pit and pipe schedule" page of the import window now opens with the scale warning at the top. Before, that sentence was only printed on the command line, which the window covers, so you never saw it.
2. **What you will see:** on a drawing with no units set, the banner above the pit and pipe rows reads "This drawing has no units set; CE read it as millimetres." On a drawing whose units disagree with its object sizes it reads "CHECK THE SCALE: ..." with the full explanation. The banner wraps, so a long sentence is fine. Nothing is blocked. You still press Import to drawing or Close as before.
3. **What did not change:** the scale itself. CE still guesses the scale from object sizes exactly as today. Whether the drawing's UNITS or the size guess should win is still the open question with you (CE 04 is asking). No window layout change and no new button.
4. **Switch:** `xcivilImport.scaleNoteOnReviewPage`, ships ON. Setting it to false gives back the two old banner sentences exactly. It has no row on the Settings page (the neighbouring no-units note has none either).
5. **Status:** built and unit-tested only. Nobody has opened this in AutoCAD. BUG-505 is NOT fixed until a Codex look passes. I did not touch BUG_CARPARK.md.
6. **What a Codex look must do (robot case N96 / C96):**
   1. **Drawing:** a copy of a unitless millimetre X-Civil drawing, imported into a drawing already tagged Civil (the earlier V1 retry was blocked by an untagged target).
   2. **Types:** CDIMPORTXCIVIL, Choose DWG (the copy), Read source.
   3. **Checks:** on the "Pit and pipe schedule" page the banner text equals "This drawing has no units set; CE read it as millimetres." Take a screenshot. Then press Close so nothing is imported.
   4. **Switch-off control:** set `xcivilImport.scaleNoteOnReviewPage` to false in `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, repeat. The banner reads "Schedule read. Review the pit and pipe rows." or "Check the schedule before accepting the import."
   5. **Reach:** run 39 was BLOCKED at the file dialog (driver dialog-path fault); the memory note says a v2 dialog path exists. Not proven.
   6. **A Codex look is needed:** a drafter must see the banner; a machine cannot accept a window (rule 5.7).

## Mistakes of my own, first

1. **Inline script hang:** one long shell command with an empty Python call hung for two minutes and my first test file write failed on a quoting error. Cost: a few minutes; no code was lost. I redid the edits with the file tools.
2. **First test run failed to build:** the 0-byte CE_TRANSFORM_2027.arx placeholder (known from the C-62 report) was missing in the new worktree, so the first run stopped at a file-copy error. I created the empty untracked placeholder inside the worktree and re-ran.
3. **Real-files listing differs (see section below):** it is Tim's live AutoCAD, not my tests, but I could not prove that beyond timing.

## What is NOT proven

1. Nothing was seen in AutoCAD. The banner text, wrapping and look are untested in a real window.
2. The full Civil suite was not run (the job's rule for this run: focused classes only, one test project per command, never the full suite).
3. The LandXML import window route was not changed (the task names X-Civil only); it already reads its units from the file.
4. Manager tests were not run (forbidden); Structural was not touched.

## Technical detail

1. **Start point and base:** origin/claude/rel-20261102a (Civil 3.0.88, 3fbb9da5). Branch `claude/b112-bug505-scale-note-on-page`, commit f0b98291. No open Civil draft PR touched these files (searched `LinkCommands.ImportXcivil`).
2. **Fault re-confirmed on the start point:** `Services/XcivilImportService.cs` put the sentence in `preflightSummary.Lines` and on the command line only; `Commands/LinkCommands.ImportXcivil.cs` built the page status from `ScheduleSourceDegraded` and the rows' Check state only.
3. **Change:**
   1. new `Rules/ImportReviewStatusRule.cs`: `Status(degraded, anyCheckRows, unitsNote, switchOn)` returns (status, needsAttention). A note with the switch ON leads (the old attention sentence follows on a new line if it also applies); otherwise the two old strings.
   2. `Services/XcivilImportPreflightService.cs`: `XcivilPreflightSummary.UnitsNote`.
   3. `Services/XcivilImportService.cs`: sets `UnitsNote` where it already inserts the sentence.
   4. `Commands/LinkCommands.ImportXcivil.cs`: the window route calls the rule, switch read as `?.ScaleNoteOnReviewPage ?? true`.
   5. `Models/UserSettings.cs`: `ScaleNoteOnReviewPage`, "Default: on."
   6. `REGRESSION_LOG.md` entry at the top.
   7. The existing banner `ScheduleStatus` in `Dialogs/CivilImportWindow.xaml` already wraps; XAML not edited. Note `CivilImportWindowViewModel.ShowSchedule` shows the passed status on this page; its top-level `_status` fixed strings are unchanged.
4. **Tests:** new `Bug505ScaleNoteOnReviewPageTests` (unitless gives the note with attention on; millimetre source with a metre guess gives CHECK THE SCALE; both together; switch OFF gives exactly the two old strings; default ON through `DeserializeSettings` and `DeserializeSettingsTolerant`; typed false turns off only itself; source guards on the wiring and no drawing write). Run: net10, filter on that class plus `Bug505NoUnitsNoteTests`: 19 passed, 0 failed (count not zero). Neighbours (`Bug877`, `C78NewSwitchDefaults`, `XcivilImportPreflight`, `XcivilSourceUnits`, `CivilImportWindow`): 70 passed, 0 failed. Drainage net48 Release build: 0 errors. Every test command named one test project (.csproj) and a --filter; isolation variables printed before each run (all under `C:\CE_WORK\scratch\f3`); -m:2, below-normal priority, build slot count 0 each time. The C75-style switch-defaults pin sits inside the new test class rather than a new `C79` file.
5. **Real-files compare (names, sizes, times only):** before listing 16:48 Melbourne (33,391 lines), after 16:53 (33,397 lines). Listings covered `%APPDATA%\TIM_CE_CADTOOLS` (including CE_Admin\outbox and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`, `CE_SUITE`; only `TIM_CE_CADTOOLS` and `CE_SUITE_MANAGER` exist with files. Changed or new in between: `CD_Settings.json` (15,268 to 15,302 bytes, last write 16:51:57), `CD_RecentValues.json` (time only), `ledger\suggestions.jsonl`, the CE_Admin machine, session and usage-outbox files, the CVL and STRUC logs, runtime diagnostics, telemetry outbox, and `CE_SUITE_MANAGER_MENU.cuix`. **Cause I can see:** Tim's own AutoCAD (`acad.exe`, started 4:52:03 pm, with an earlier session closing at 16:51:57) was running, and the usage files are timestamped to its sessions. **What I can say:** my tests only deserialise JSON text in memory and read source files, and the test process's TEMP, logs and Structural root were all under my scratch folder. I cannot prove from the listing alone that none of the changed files came from my run, so this is flagged, not claimed clean. I stopped nothing, since I started no AutoCAD, Codex or accoreconsole.
6. **C: free space:** 47.1 GB at 16:43, 46.0 GB at 16:53 after cleanup (a net 1.1 GB drop; the clean removed the worktree's build output, but the other lanes and Tim's AutoCAD wrote at the same time).
7. **Cleanup:** `git clean -fdXq` and `git worktree remove --force` done in the same minute as the push (16:53). The worktree is deregistered, but an empty `C:\CE_WORK\build\f3\Modules\Drainage` folder remains because a stray shell holds it open ("Device or resource busy"); it holds no files and can be removed once that shell closes. Scratch `C:\CE_WORK\scratch\f3` removed after this report.
8. **Finished:** Sat 31 Oct 2026, 16:56 Melbourne.
