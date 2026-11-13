# Review: PR 2107 `claude/trust04-b1342-csv-export-guard` (BUG-1342: Pit Schedule Export CSV when the file is open in Excel), head `320dcdcb`

**Reviewer:** trust-review helper. **Written:** Fri 13 Nov 2026, 23:48 PC clock. **Base:** `cf059dcf` (installed Civil 3.0.90); one commit on top. `PitScheduleViewModel.Schedule.cs` and `RelayCommand.cs` are byte-identical between `cf059dcf` and the trial build on Tim's PC (`9714ffdd`, Civil 3.0.90.2). Draft, auto-merge off. Read only: no build, no test run, no AutoCAD. **Lane that owns the branch:** trust-safety-fixes (its 12:55 line: built, 911 of 911 unit tests, broken twin 1 of 3 fails).

**Chosen because:** the bug entry calls it a possible unhandled program error (the crash category). By reading, it is not a crash today (section 1); it is a misleading line.

**Verdict: GO** (fit for the robot test on copies). The fault is real and the change closes it for the failures it names, on the one route Export CSV has. Two small fixes before Codex reads the words or the branch merges; neither stops the robot test.

---

# FOR TIM

1. **The fault is real, but it was never a crash.** Export CSV with the file still open in Excel fails. Today CE's own window safety net catches it, so AutoCAD carries on. You get "rendering error, see CE log" on the command line, hidden behind the open window, and nothing in the window itself.
2. **What you see now:** the window stays open and its bottom line says "CSV not saved: the file is open in another program (for example Excel). Close it and export again." A read-only folder gets "CE cannot write to that folder". A normal export is exactly as before.
3. **One wording fix needed:** the "open in Excel" words are also shown for a full disk or a network drive that has dropped out. They should only show when the file really is open somewhere else.
4. **Same window, same problem, not fixed here:** Import CSV and Compare CSV read the file with no guard either. "Export, edit in Excel, import back with Excel still open" is an everyday sequence and would likely give the same hidden "rendering error". Flagged for a separate fix.

---

# Findings (file and line at `320dcdcb` unless marked `9714ffdd`)

## 1. Is the fault real in the installed code, and by which path

1. **Confirmed by reading, five steps deep.** `Commands/PitScheduleCommand.cs` (`9714ffdd`) 47 to 48 opens the window through `DialogService.ShowDialog`. The Export CSV button is `ExportCsvCommand = new RelayCommand(_ => ExportCsv())` (`ViewModels/PitScheduleViewModel.cs` 284). `RelayCommand.Execute` has no catch (`RelayCommand.cs` 47 to 50). `ExportCsv` opens the file with `new StreamWriter(dialog.FileName)` and nothing around it (`PitScheduleViewModel.Schedule.cs` `9714ffdd` 72 to 73). A file held open by Excel makes that open fail.
2. **What the drafter sees today.** The failure rises to the window's message loop. `DialogService.ShowDialog` (`Services/DialogService.cs` `9714ffdd` 33 to 35) has hooked CE's one window crash catcher (BLK-013, 185 to 204). It logs, prints "[CE] <window> rendering error — see CE log for details." on the command line, and marks the fault handled "so it cannot end the AutoCAD session". So: no crash, the window stays open, its status line keeps whatever it said before, and the only message is misleading and behind the window. The bug entry's "effect not seen, possible unhandled error" can be narrowed to this.

## 2. Does the fix close it on every path

1. **Export CSV has one route,** and the write is now inside a guard (74 to 84). An I/O failure, a "not allowed" failure or a security failure sets the window's status line and returns. "CSV export complete." (86) is reached only on success, as before.
2. **Any other kind of failure** (for example an unusual path the save dialog lets through) still goes to the crash catcher, as today. Rare; acceptable.

## 3. Nothing written on Cancel/Escape; locked layers and Xrefs

1. **Cancel at the save dialog** returns before any file is opened (69 to 70), unchanged.
2. **The drawing is not written.** With the Settings value `linking.pitScheduleExportWritesNothing` at its default (ON, `Rules/PitScheduleExportRule.cs` 13 to 21), the export saves nothing into the drawing before or after (BUG-1198). The change adds nothing drawn and no record write.
3. **Locked layers and Xrefs:** not involved; the export only writes an outside file.

## 4. One code path per behaviour

1. **One route, one rule** for the CSV words (`CsvExportFailedLine`, 90 to 97), called by the product and by the tests. Good.
2. **Two wordings in one window for the same failure.** Export Excel, two buttons along, already catches the same case and says "The Excel export could not be saved. See CE log." (172). Small; see fix item 3 (optional).

## 5. Settings and hard-coded values

1. **No new setting, no engineering value.** Nothing to add to Settings.

## 6. Wording the drafter sees

1. **Plain English, no software words,** and it says what to do next. The window footer drops CE's "[CE] " tag (`SetStatus`, `PitScheduleViewModel.cs` 990 to 998), so it reads cleanly.
2. **Not true for every cause it is shown for.** Every I/O failure gets "the file is open in another program (for example Excel)" (94 to 95): also a full disk, a network or OneDrive folder that has dropped out, or a path too long. A file marked read-only (not the folder) gets "CE cannot write to that folder" (92 to 93). The fallback "The reason is in the CE log." (96) can never be reached from Export CSV, because all three caught kinds map to the first two lines. See fix item 1.

## 7. Tests

1. **Two of three are real:** they call the shipped words function and would fail without it (it does not exist on the base).
2. **The third is a text search** (`Trust04B1342CsvExportTests.cs` 27 to 35): it proves the catch line is in the file, not that a real open-in-Excel failure lands in it. The bug entry's own test asks for "a path held open by another stream". That needs no AutoCAD. See fix item 2.
3. **Only AutoCAD can prove (robot, copies only):** (a) hold the CSV open (Excel, or a PowerShell file handle opened with no sharing, which needs no Excel), Export CSV to the same name: the status line names the open file, the window still works, no "rendering error" line; (b) release it, export again: "CSV export complete." and the file is complete; (c) a read-only folder: the folder line; (d) broken twin: the same (a) on Civil 3.0.90.2 gives the "rendering error" line and no status change.

## 8. Risk to normal use

1. **Very low.** The success path is the same writer, the same rows and the same final line. Only the failure path changes.

---

# Before Codex looks or the branch merges (neither stops the robot test)

1. **`PitScheduleViewModel.Schedule.cs` 90 to 97: make the words true for each cause.** Use the Excel line only for a sharing or lock violation (the failure's `HResult` low word 32 or 33). A read-only file or folder: "CSV not saved: CE cannot write to that file or folder. Choose another place and export again." Anything else: "CSV not saved: " plus Windows' own reason (for example "There is not enough space on the disk."), not the Excel line.
2. **`PitScheduleViewModel.Schedule.cs` 74 to 84 and the test file: test the real failure.** Move the guarded write into a small internal method that takes the path and the rows and returns the failure line or nothing. Test it against a file held open with no sharing (expects the Excel line) and a read-only file (expects the folder line). This is the bug entry's own "Test that catches it", and it would also prove fix 1.
3. **Optional, controller's call: one wording rule for both export buttons.** Export Excel (172) could use the same words function, so the same failure reads the same way in one window.

# Worth knowing

1. **Sister fault, same window (for the controller to file):** Import CSV and Compare CSV read the file with `File.ReadAllText` and no guard (`PitScheduleViewModel.Filters.cs` 652, called from `ImportCsv` and `CompareCsv` in `PitScheduleViewModel.Schedule.cs` 389 and 730). If Excel's hold on the file blocks the read (likely, not proven), the drafter gets the same hidden "rendering error".
2. **Sister fault, design check window (for the controller to file):** its Export CSV (`DesignCheckDashboardViewModel.cs` `9714ffdd` 624 to 648) catches every failure and only writes the CE log. The drafter is told nothing on failure, and nothing on success either.
3. **A failure part-way through writing** (disk full, network drop) leaves a part-written file, and any earlier CSV of that name has already been emptied, because the writer empties the file when it opens it. Same as today; "CSV not saved" is still broadly true.

# Could not verify

1. The build and the 911 tests (no build or test run, by rule).
2. That Excel's hold on an open CSV blocks a read as well as a write (bears on worth-knowing item 1 only).
3. The window's own title string as the crash catcher prints it (it reads the window's title at run time).
