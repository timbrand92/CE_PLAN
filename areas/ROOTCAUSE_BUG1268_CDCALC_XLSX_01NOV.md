# ROOT CAUSE: BUG-1268, CDCALC "Export to XLSX" closes the Save As window and writes no file

Read-only root-cause job rc1 (Opus, Team), Sun 1 Nov 2026, Melbourne time. Written at CE 05's brief for CE 00.
Code read: `origin/claude/rel-20261102a` at 3fbb9da5 (installed Civil 3.0.88). Nothing built, run, changed or pushed.
Evidence read: the BUG-1268 entry, the K1 brief `_CODEX_RUNNER\verifyK1_c88_full.txt`, the Codex report
`_TEST_COPIES_20260923\CODEX_VERIFY_K1_20261101_1400.md`, its evidence folder (shots, logs_end, exports), the Codex
session transcript for that run (`.codex\sessions\2026\11\01\rollout-2026-11-01T13-59-45-...jsonl`, read only), and the
Windows "recent Save As files" list for .xlsx (registry, read only).

## FOR TIM

1. **The cause, in one sentence:** the CDCALC Save As window came back WITHOUT a confirmed save, and CDCALC treats that exactly like Cancel: it closes quietly, writes nothing, shows nothing and logs nothing. The writer itself never ran, so it is not the Excel part (#1871) failing.
2. **How sure:** about 75 per cent that the Save As window returned "not saved" (four separate readings agree, see DETAIL 1). I am about 95 per cent sure of the design fault that hides it. CDCALC is the only Excel export in Civil that never says "saved" and never checks that the file is really on disk. Pit Schedule says "Excel export complete". I could NOT prove why Windows returned "not saved" after the Save click (DETAIL 7).
3. **What a drafter sees:** presses Export to XLSX, types a name, presses Save, and the window closes. No message, no file. The same silent result happens if they press Cancel, so a drafter can never tell a saved export from a lost one.
4. **The smallest safe fix:** after the Save As window, CDCALC (a) writes one CE log line for every outcome (cancelled, saved with its size, failed); (b) checks the file is really on disk and not empty, and shows a plain error naming the folder if it is not; (c) shows "XLSX saved: <name> in <folder>" in the window's status line, like Pit Schedule; (d) opens the Save As window in the same default folder Pit Schedule uses (the job's Civil folder, else the drawing's folder), not wherever Windows last saved something.
5. **Settings switch:** yes for (b) to (d), because the drafter sees something new (a status line, an error box, a different starting folder). Proposed `excel.confirmCalcXlsxSaved`, ON by default. OFF brings back today's silent behaviour. Part (a), the log lines, needs no switch: nothing changes on screen.
6. **What the robot must prove:** the Claude robot cannot do it, because it refuses Export buttons and never drives a Save box. So it is a Codex look (K1-02b). Export to XLSX, type the full path, press Save, then show four things: the file is on disk, is not empty and opens with its sheets; the status line names it; the CE log has the "saved" line. Then press Cancel and show there is no file, no error box, and a "cancelled" log line. Then a deliberately bad folder must give the plain error box, never silence.
7. **No AutoCAD work for you yet.** First the fix with its switch, then the Codex look, then the ledger.

## DETAIL

### 1. Why I say the Save As window came back "not saved" (the evidence)

1. **The code can only be silent in one place.** After the Save As window closes, `ExportToXlsx` has exactly four outcomes. (a) The window returns "not OK" and the code returns at `CalculationsV2ViewModel.cs:846` with no message and no log line. (b) The package changed while the window was open: a warning box, logged as WARN through `DialogService.ShowWarning` (`DialogService.cs:286-290`). (c) The write fails: an error box, logged as ERROR at `CalculationsV2ViewModel.cs:864` or `:869` (`DialogService.ShowError` also logs, `DialogService.cs:277-281`). (d) The write succeeds: the file exists at the chosen path, with no message.
2. **The CE log rules out (b) and (c).** `logs_end\CE_CVL_SUITE\CE_CVL_SUITE.log` from 14:04:48 (CDCALC opens) to 14:05:34.450 ("Command outcome: CDCALC completed 46034 ms") holds no WARN or ERROR line, and no line containing "xlsx" or "CDCALC Export". WARN and ERROR lines do reach this file: it holds 572 of them from other commands.
3. **The disk rules out (d) at the typed path.** The Codex screenshot of the box (shot K1-C3, and the full uncropped frame in the transcript) shows the File name box holding exactly `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\K1_20261101_1400\exports\K1_CDCALC.xlsx`, with single backslashes and the folder existing. That `exports` folder holds only `K1_Pit_Schedule_ON.xlsx` (14:04), `K1_open_copy.xlsx`, `driver_calls.txt` and `savercheck.txt`.
4. **Windows' own "recent Save As files" list for .xlsx has no K1_CDCALC.xlsx.** The registry key `ComDlg32\OpenSavePidlMRU\xlsx` was read only. Its newest entry is `K1_Pit_Schedule_ON.xlsx`, the Pit Schedule save at 14:04 in the same session. The list also holds `L1_calc_XLSX.xlsx`, the CDCALC Export to XLSX that DID work in the Codex L1 look on 18 Oct (Civil 3.0.54, 10,233 bytes, still on disk). So a confirmed CDCALC Save adds its file to this list, and the 14:05 one did not. This points to the box closing without a confirmed Save. (Caveat: I believe Windows adds the entry when Save is confirmed, not when the file appears, but I have not proved that on this PC.)
5. **The timing agrees.** In the Codex transcript, the Pit Schedule "click Save, then read the screen" step took 4.17 seconds: AutoCAD was busy writing the workbook. The identical CDCALC step (click Save at the same box coordinates [1024,682], then read the screen) took 0.70 seconds, and the window was already free. A three-section workbook with column auto-fit does not write in well under a second inside AutoCAD. Most likely nothing was written.
6. **So the reading is (a): the window returned "not OK"** and line 846 returned in silence. That is the only path consistent with no log line, no file, no recent-file entry and a fast return.

### 2. The failing path, step by step (installed code, 3fbb9da5)

1. **Button:** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:1317`, "Export to XLSX", bound to `ExportXlsxCommand` and enabled only when a package is previewed.
2. **Command:** `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs:402` wires `ExportXlsxCommand` to `ExportToXlsx`. The plain `RelayCommand` (`ViewModels/RelayCommand.cs`) catches nothing.
3. **Save As window:** `CalculationsV2ViewModel.cs:839-845` creates `Microsoft.Win32.SaveFileDialog` with filter "Excel Workbook (*.xlsx)|*.xlsx", FileName = `SuggestedXlsxFileName` (it read "CalcReport.xlsx" on this drawing), `DefaultExt` ".xlsx", `AddExtension` true. There is **no InitialDirectory**, so Windows opens it wherever acad.exe last saved something. On 1 Nov that was the `exports` folder, which is why the box opened there.
4. **Silent return:** `CalculationsV2ViewModel.cs:846`, `if (dialog.ShowDialog() != true) return;`. No log line, no status line.
5. **Package re-check:** `:848-854`, a warning box (logged) if the preview went stale.
6. **Write:** `:857-874` calls `CalculationExportPackage.SaveXlsx(dialog.FileName)` (`Services/CalculationExportPackage.cs:136-194`). The work is synchronous on the window's own thread: `new XLWorkbook()`, one sheet per section, `AdjustToContents()` at `:151` and `:190`, and `workbook.SaveAs(filePath)` at `:192`. It does not run in the background, does not change the name, does not use a relative path, and swallows no exception.
7. **After a successful write:** nothing. No status line, no log line, and no check that the file exists.

### 3. The working path (Pit Schedule Export Excel)

1. `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:110` `ExportExcel()`.
2. `:126-132` creates the same `Microsoft.Win32.SaveFileDialog`, but with **`InitialDirectory = GetDefaultCivilFolder()`** (`PitScheduleViewModel.Filters.cs:438`: the job's Civil folder, else the drawing's folder, else Documents). On 1 Nov the box opened in the evidence `copies` folder, which holds the drawing copy.
3. `:134` has the same silent return on "not OK".
4. `:139` `SaveExcelWorkbook` (`:160-166`, `workbook.SaveAs` at `:164`), then **`:140` a status line "Excel export complete — sheet 1 the schedule, sheet 2 the checking sheet."**
5. `:142-152` has the same two catches (BUG-1255 plain line, general failure), each logged.

### 4. The exact difference

1. **Feedback after Save:** Pit Schedule writes a status line on success (`:140`). CDCALC writes nothing (`CalculationsV2ViewModel.cs:857-860`). This is why the K1-02 failure is silent, and why nobody can tell "cancelled" from "saved somewhere else" from "saved".
2. **Starting folder:** Pit Schedule sets `InitialDirectory` (`:131`). CDCALC does not (`:839-845`), so its box opens in an unpredictable folder: Windows' last-used folder for acad.exe, which on a drafter's PC can be another job's folder.
3. **Filter list:** Pit Schedule offers "Excel Workbook" and "All Files". CDCALC offers "Excel Workbook" only. This makes no difference to a typed full path ending in .xlsx.
4. **The Excel part (#1871, BUG-1255):** identical in both. Both catch a library-load fault, log it and show a plain line. The CE log shows the library was already bound at 14:04:25 by the Pit Schedule export (`[BUG-1255] Excel part: CE asked for ClosedXML 0.102.3.0; using the copy in this AutoCAD session (0.102.2.0 ...)`), so CDCALC had nothing left to load. #1871's change to CDCALC (commits 96b87f73 and c137e78a) only added the first catch block and a no-inlining mark on `SaveXlsx`. It cannot produce silence: every new branch logs and shows a box. The net48 build compiles the binding out entirely (`ExcelLibraryBinding.cs`, `#if NET`), and a load fault there still reaches the logged general catch.

### 5. The checklist from the brief, item by item

1. **Swallowed exception or empty catch:** none on this path. Both catches log and show a box; the WPF crash catcher also logs (`DialogService.cs:185-200`).
2. **Dialog result or path dropped:** the result is the only silent exit (line 846). The path is passed straight through (line 859).
3. **Relative path or wrong working folder:** no. The path is the dialog's absolute result. The missing `InitialDirectory` only changes where the box OPENS, which matters to a drafter who types only a name, not to the Codex run, which typed a full path.
4. **Writer runs only when the Excel library resolves:** no silent case. A load failure is caught, logged and shown.
5. **Save on a background task never awaited:** no. The save is synchronous.
6. **File name or extension changed:** no. `AddExtension` keeps `K1_CDCALC.xlsx`.
7. **No-hard-block warning never shown:** the only "warning" path (stale package) logs and shows a box. What is missing is not a hidden warning but any outcome message at all.

### 6. Where the file was supposed to land, and where else I looked

1. **Supposed to land:** `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\K1_20261101_1400\exports\K1_CDCALC.xlsx` (typed in full, seen in the box). It is absent.
2. **The folder the box opened in:** the same `exports` folder (Windows' last-used folder). Absent there.
3. **Pit Schedule's default folder (the drawing copy folder):** `...\K1_20261101_1400\copies`. It holds only the two drawing copies.
4. **Other candidates searched read-only for `K1_CDCALC*` and `CalcReport*.xlsx`:** the whole `_TEST_COPIES_20260923` tree, Documents, Desktop, Downloads, OneDrive, the AutoCAD 2027 programme folder (acad.exe's working folder), `%APPDATA%\Autodesk`, VirtualStore, `C:\CE_WORK`, `C:\ce-fx`, `_CODEX_RUNNER`, `_ACAD_DRIVER`, plus a whole-of-C: name search. Result: see line 6.5.
5. **Search result:** no file named `K1_CDCALC*` anywhere on C:. A whole-drive `dir /s /b /a-d C:\K1_CDCALC*` finished with "file not found" (exit 1, no lines) at about 15:00 on 1 Nov. The file was not written somewhere else; it was never written. D: (USB) was not searched.

### 7. What I could not verify

1. **Why the Save As window returned "not saved" after a Save click** that landed on the Save button (the box frame in the transcript shows Save at the clicked spot). The CDCALC box had opened partly off the right edge of the captured area (Cancel and the close X are cut off; the Pit Schedule box was fully in view). That may have something to do with a click that closed the box without confirming it, but I cannot prove it read-only. No CE code calls Close or Cancel on the box.
2. **Whether Windows adds the recent-file entry at the moment Save is confirmed** (my reading) or only once the file exists. If it is the latter, the registry reading only repeats "no file". The timing and the CE log still point the same way.
3. **The CE log writer drops lines only under load** (`DroppedLineCount`). A lost ERROR line in a quiet half-minute is very unlikely but not disproved.
4. **I did not reproduce anything:** no AutoCAD, no build, no test run (as briefed).

### 8. Candidates ranked, with the cheapest check for each

1. **About 75 per cent. The Save As window returned "not OK" and line 846 returned in silence.** Cheapest check: with the log-line part of the fix in place (no switch needed), one Codex re-run of K1-02 shows "cancelled" or "saved" in the CE log. With no build at all: a Codex re-run that presses Enter in the File name box instead of clicking Save, then reads the recent-files registry key and the folder.
2. **About 10 per cent. The write ran and succeeded, but the file was later removed.** Contradicted by the fast return and the empty whole-drive search (line 6.5 rules out "written to another folder"). Cheapest check: the K1-02b re-run with the "saved" log line.
3. **About 10 per cent. The write threw, but its ERROR line never reached the log** and the error box never showed (C4 shows none). Cheapest check: the same re-run with the fix's log lines, plus a CE log line count before and after.
4. **About 5 per cent. Something not seen in the code** (for example a second CDCALC window or view-model). Cheapest check: the only `ExportXlsxCommand` binding in the repo is `CalculationsV2Dialog.xaml:1317`, and the profile-only constructor's no-op command (`CalculationsV2ViewModel.cs:436`) cannot open a Save box. Already checked; kept only for completeness.

### 9. The smallest fix, and the switch

1. **Always, with no switch (log lines only):** in `ExportToXlsx`, log `CDCALC: XLSX export cancelled at the Save As window` on the line-846 path, `CDCALC: XLSX saved <file name> (<bytes> bytes)` after a write, and keep the two failure lines. No drawing or screen change. File-name-only wording: never the folder, following the FaultReportTextScrub privacy rule for job paths.
2. **Behind `excel.confirmCalcXlsxSaved` (Civil settings, ON by default; OFF gives exactly today's behaviour):**
   (a) after `SaveXlsx` returns, check `File.Exists(path)` and length above 0. If either fails, show `DialogService.ShowError("The XLSX file was not created in <folder>. Nothing was saved.", "CDCALC Export")`.
   (b) on success, set the window's existing status line to "XLSX saved: <name> in <folder>".
   (c) set `InitialDirectory` to the same default folder as Pit Schedule, using the one shared helper (design rule 1: one code path). That means moving `GetDefaultCivilFolder` from `PitScheduleViewModel.Filters.cs:438` into a small shared service that both exports call, rather than copying it.
3. **Pattern:** the switch follows `ExcelPartRule.IsOn()`, read live, with a missing settings file reading ON (R-27). The `REGRESSION_LOG.md` entry names BUG-1268.

### 10. The unit guard that would catch it

1. **The seam:** put the Save As window behind a small "ask for a save path" seam, as `CalculationExportPackage` already has `ForceComputationsSheetFailureForTest`. Then `ExportToXlsx` runs headless with a stub that returns OK plus a path, or Cancel.
2. **Guard 1, cancelled:** the stub returns Cancel. A "cancelled" log line is written, no file appears and no box shows.
3. **Guard 2, write leaves no file:** the stub returns OK and a path, and the write is forced to leave no file. With the switch ON an error box is captured (a DialogService capture seam) and an error log line written. With the switch OFF, today's silence. This is the guard the bug entry asks for: a failed write shows a plain message rather than closing silently.
4. **Guard 3, success:** the stub returns OK and a temp path. The file exists, opens with one sheet per selected section (the existing `SaveXlsx_WritesOneSheetPerSelectedSection...` test already covers the content), and the status line names the file.
5. **Source guard:** every `ShowDialog() != true` return inside a Civil export method is followed by a log call. This is a text scan like the existing `Bug1255ExcelPartTests` scans. It catches the next silent export.
6. **net48 and net10:** both lanes run these tests. They need no AutoCAD.

### 11. The case that proves it (a Codex look; the Claude robot cannot)

1. **Why Codex:** the robot's press list refuses every "*Export*" button (`acad_driver_v3.allowlist.json` never_buttons), and its `dialog-path` verb never drives a Save box (`acad_driver_witness_v2.ps1`, Get-V2DialogPathProblem). So K1-02b is a Codex look, like K1.
2. **K1-02b steps:** D2 type "CDCALC" with -ExpectWindow "Creative Engineering | Calculations". Then Print, Sections and export, Preview package, Export to XLSX. Write the folder the box opened in (with the switch ON it must be the job's Civil folder or the drawing folder; never save a capture showing it). Click File name, Ctrl+A, type `<evidence>\exports\K1_CDCALC.xlsx`, and press **Enter**. Then a second run that clicks Save with the box fully on screen.
3. **Checks:** K1-SIZE on the path (exists, above 0 bytes); K1-SHEETS-XML on it (one sheet per ticked section); the window status line reads "XLSX saved: K1_CDCALC.xlsx in ..."; the CE log has exactly one `CDCALC: XLSX saved K1_CDCALC.xlsx` line; and `OpenSavePidlMRU\xlsx` now lists K1_CDCALC.xlsx.
4. **Cancel control:** Export to XLSX again, press Cancel. No new file, no box, one "cancelled" log line.
5. **Broken variant (rule 13.3 condition 2):** type a path in a folder that does not exist, or that is read-only, inside the evidence folder. With the switch ON a plain error box must appear and an ERROR log line be written. Never silence. With the switch OFF (only with a GO flag), today's behaviour.
6. **Acceptance:** this is something a drafter must SEE (a status line, a box), so a Codex look is needed. The file and log parts can be Claude-accepted only under RULES 13.3 (two sessions, fails on 3.0.88, reviewed against this entry).

### 12. Risks

1. **The starting-folder change** points the box at a real job folder on Tim's PC. That is intended (Pit Schedule already does it), but the Codex brief must keep its rule never to accept or capture the folder it opened in.
2. **The success line names the folder,** which can hold a job address. Keep it to the window's status line, never in the CE log or a fault report.
3. **The file-exists check** must not run on a slow network folder in a way that hangs the window. Check once, with no retry loop.
4. **If candidate 1 is right and the box really returned "not OK" after a real Save click,** the fix makes that visible (a "cancelled" log line) but does not stop it happening. If K1-02b then shows "cancelled" after a confirmed Save, a second job must look at the Save As window's owner and position (it opened partly off-capture), not at the Excel part.
