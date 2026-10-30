# Opus pre-review F: PR #1871 (B-056, BUG-1255, Excel export on AutoCAD 2027)

Independent read-only review, Fri 30 Oct 2026, about 17:35 Melbourne. Reviewed head `9a1f4e64` against base `f5dd72a0` (`claude/rel-20261030a`, the C-77 line, Civil 3.0.87). Built and unit-tested only. Nobody has opened it in AutoCAD.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE.** The fix is sound, it is ON by default, and it is safe to join the C-78 addendum, ideally after two small fixes the desk can make before it joins (items 4 and 5).
2. **What it does on the drawing side.** On AutoCAD 2027, Pit Schedule "Export Excel", CDCALC "Export XLSX" and Structural STRUCEXPORTCSV should open the save box and save the .xlsx again, by borrowing the Excel-writing part AutoCAD 2027 already carries.
3. **Proven so far.** In the console version of AutoCAD 2027 the Pit Schedule workbook saved in both load orders, and failed with the fix switched off. I opened the saved file's contents myself: it holds the sheets "Pit Schedule" and "Checking".
4. **Fix 1, small.** If an Excel export fails for another plug-in (not CE) on AutoCAD 2025 or 2026, CE can hand that plug-in CE's own Excel part even when it is the wrong version. Example: another firm's add-on wanting a newer Excel part could break. One extra check closes it.
5. **Fix 2, wording.** The code says the switch is on the Settings page. It is not; it lives only in the settings file. Also, CDCALC and STRUCEXPORTCSV have no "Export CSV" button, so the message "Use Export CSV" points the drafter at nothing there.
6. **NOT proven, and the test that proves it.** Nobody has used the full AutoCAD 2027 window, CDCALC or Structural export, AutoCAD 2022 to 2024, or opened the file in Excel. The robot must run N41 and N41c (Pit Schedule, switch on then off), CDCALC Export XLSX and STRUCEXPORTCSV on the installed build, in two AutoCAD sessions. **Correct N41c first:** as written it expects the plain message with the switch off, but the code only shows that message with the switch on, so N41c would fail by design.

---

## DETAIL

### Method, and one thing to own

1. **What I read.** `gh pr view 1871`, then `git diff f5dd72a0 9a1f4e64` and `git show 9a1f4e64:<file>` for every changed file. Only these two commits on top of the base: `96b87f73` (Civil) and `9a1f4e64` (Structural), both 16:59 Melbourne.
2. **My own git step.** I ran one `git fetch origin` of the two branch names to get the head commit. It downloaded objects and wrote FETCH_HEAD; it changed no branch, no worktree and no repository file. Strictly that is a write to the git store, so I am stating it.
3. **Evidence folder.** I read the author's logs in `C:\ce-fx\b056` (probe runs `run_A0`, `run_B0`, `run_A1`, `run_B1`; test logs `civilfull.txt`, `civil2.txt`, `civil3.txt`, `civilrel.txt`, `civil48.txt`, `struc1.txt`, `struc2.txt`, `struc48.txt`). I built nothing, ran no test and opened no AutoCAD.
4. **Housekeeping note.** `C:\ce-fx\b056\iso\Local` holds AutoCAD log files whose names carry real job names and addresses (from the isolated profile). That folder is local-only; it must never be copied into a repo, and the desk should clean it up when the review is done.

### Question 1: does the handler or switch do what the report says, and is it ON by default?

1. **Yes, the handler does what the report says.** `Shared/ExcelBinding/ExcelLibraryBinding.cs:75-89` registers once per AutoCAD session (process flag `CE.ExcelBinding`, line 80) a handler on the default load space (line 82). For the six Excel libraries only (list at lines 22-25, check at line 97) it returns, in order: (a) an already-loaded copy of the same family, line 101-107; (b) AutoCAD's own copy asked for by name with no version, if the same family, lines 109-118; (c) CE's own file from CE's folder, lines 121-123. "Same family" means same name, same publisher token and same major.minor version (`PickIndex`, lines 36-54).
2. **The probe matches the claim.** `C:\ce-fx\b056\run_A0\A0.log` and `run_B0\B0.log`: switch off, both orders FAIL with `FileLoadException ... ClosedXML, Version=0.102.3.0 ... 0x80131040`. `run_A1\A1.log` and `run_B1\B1.log`: handler on, both PASS; ClosedXML 0.102.2, DocumentFormat.OpenXml 2.16.0.0 and SixLabors.Fonts 1.0.0.0 from the AutoCAD 2027 folder, ExcelNumberFormat 1.1.0.0 from CE's folder (step c). The probe called `SaveExcelWorkbook` (the Pit Schedule writer) by reflection, not the button.
3. **The saved file is real.** I read `xl/workbook.xml` from `C:\ce-fx\b056\run_A1\A1.xlsx` (8,011 bytes): sheets "Pit Schedule" and "Checking". The probe's own "sheets:" line printed blank; the file itself is right.
4. **ON by default: yes, in both products.**
   1. Civil group: `Modules/Drainage/Models/UserSettings.cs:139-143`, `[JsonProperty("excel")] ... = new ExcelSettings()`, doc line 140 "Default: on".
   2. Civil switch: same file lines 3308-3318, `[JsonProperty("useAutoCadLoadedClosedXml")] public bool UseAutoCadLoadedClosedXml { get; set; } = true;`, doc line 3315 "Default: on."
   3. Structural switch: `Modules/Structural/Models/UserSettings.cs:409` (`class ExcelSettings`), doc line 419 "Default: on.", property line 421 `= true`.
   4. A missing file, group or settings fault reads ON: `Modules/Drainage/Rules/ExcelPartRule.cs:14` and `:17-21`; `Modules/Structural/Services/ExportService.cs:36-40`. Tested through both start-up reads in `Modules/Drainage.Tests/Services/Bug1255ExcelPartTests.cs` (cases `{}`, `{"excel":{}}`, typed true and false).
5. **The documented-default test.** `NewSettingsKeys_NeedADocumentedDefault` is at `Modules/Drainage.Tests/Services/C60AuditSourcePinGuardTests.cs:154`. It scans Civil sources only, so it covers the Civil key, not Structural's (Structural's doc does say "Default: on." at line 419).
6. **Settings-first: partly met.** Not hard-coded, behind a switch, default ON, warns and never blocks (R-27). But the switch is NOT on the Settings page: a drafter must edit the settings file. There is precedent for settings-file-only keys (`UserSettings.cs:1024` says a page row needs Tim's layout decision). **Finding:** the class doc at `UserSettings.cs:3308` says "Shown on the Settings page as 'Use the Excel part AutoCAD already has'". That is untrue; correct the comment or add the row.
7. **Two small wording inaccuracies.**
   1. `REGRESSION_LOG.md` item 4 says "OFF = no handler". The handler is still registered with the switch off (`Register` never reads the switch); it returns nothing each time (line 101). Same effect, different wording.
   2. The report's N41c says "the switch is read at launch". The code reads it at every refused load (line 101), but once the Excel part has loaded in a session, changing the switch does nothing until AutoCAD restarts. Setting it before launch, as N41c says, is the right test step.
8. **Cross-product note.** Only the first product to start registers the handler (line 80). If Structural starts first, Structural's switch and Structural's folder govern the handler for Civil too, and Civil's switch then only controls Civil's message. Harmless while both default ON; worth one line in the card.

### Question 2: could it load the wrong copy, or throw, in the other hosts?

1. **Legacy lane (net48, AutoCAD 2022 to 2024): handler compiled out.** `#if NET` at lines 77 and 91 (the `NET` symbol is not defined for net48). `Register` is empty there. Civil net48 Release built 0 errors (`C:\ce-fx\b056\civil48.txt`), Structural net48 0 errors (`struc48.txt`).
2. **Legacy lane behaviour change, small.** The new catch filters do compile on net48. With the switch ON, a library load fault in Pit Schedule now shows the plain line instead of escaping. That is an improvement, not a risk.
3. **Net8 lane (AutoCAD 2025 and 2026): handler compiled in, never run.** Neither AutoCAD is installed here. Reading the code: when AutoCAD does not ship ClosedXML, step (b) fails inside its own try (line 118) and step (c) hands back CE's own copy, which is the same file CE used before. The `_busy` guard (lines 92, 97-98, 131) stops the handler calling itself. Expected outcome: same as today. Not proven.
4. **Wrong-copy risk found (Fix 1 in FOR TIM).** Step (c), lines 121-123, returns CE's own file with NO family or version check. This handler runs for every plug-in in the AutoCAD session, and before any other plug-in's own fall-back resolver gets its turn. So on AutoCAD 2025 or 2026, a different add-on asking for, say, ClosedXML 0.104 or DocumentFormat.OpenXml 3.x could be handed CE's older copy and fail later inside that add-on. On 2027 the same request mostly fails anyway, as AutoCAD's own copy holds the name. Likelihood low; cost of the fix tiny: before line 123, read the file's name (`AssemblyName.GetAssemblyName(own)`) and return it only if `PickIndex(name, new[] { thatName }, true) == 0`.
5. **Version step-down is deliberate and guarded.** CE is built against 0.102.3 and runs on AutoCAD's 0.102.2 (same major.minor). If a method is missing in 0.102.2, the fault is a library-load fault, which `IsLibraryLoadFault` (lines 57-66) recognises, so Civil shows the plain line and Structural rethrows it with the plain line. Pit Schedule was probed; CDCALC and Structural writers use more of ClosedXML and were not.
6. **Every new path is guarded.** `Register` has try/catch (lines 78-87); `Resolve` has try/catch/finally and returns nothing on any fault (lines 99-131); the logger is wrapped (`Safe`, lines 144-148); the switch reads are wrapped. Nothing new can throw out into AutoCAD.
7. **One path deliberately does NOT fall back gracefully.** Pit Schedule with the switch OFF: the second catch at `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:148` has the filter `IsOn() || !IsLibraryLoadFault(ex)`, so a library fault with the switch OFF escapes the button uncaught, which is the old "rendering error". The author meant "OFF = as before". It is nearly as before, except the save box now opens first (before, the fault fired before the box). I would rather OFF keep the old generic line "The Excel export could not be saved. See CE log." (drop the filter on line 148). That is a judgement call, not a blocker.
8. **CDCALC is safe either way.** `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs:861` adds a filtered catch before the existing catch-all at line 867, so nothing can escape.
9. **Structural.** `Modules/Structural/Services/ExportService.cs:20-28` rethrows a library fault as the plain line; the command runner prints it as `[STRUCEXPORTCSV] Error: ...` (`Modules/Structural/Services/AsyncCommandService.cs:74-79`). The writer runs on a background thread; the handler's guard is per-thread and its log set is locked, so that is fine.
10. **Wording finding (Fix 2 in FOR TIM).** The plain line says "Use Export CSV, it saves the same rows." Pit Schedule has Export CSV (`PitScheduleViewModel.Schedule.cs:46`). CDCALC has no CSV export (no "csv" in `CalculationsV2ViewModel.cs`), and STRUCEXPORTCSV is itself the command that saves the .xlsx, with no CSV alternative. For those two the advice leads nowhere; suggest "Use Export PDF" for CDCALC and a plain "Excel export could not start on this AutoCAD." for Structural.

### Question 3: Structural's change, shared files and CE_SHARED identity

1. **Same shared source file, not CE_SHARED.** Both products link `Shared/ExcelBinding/ExcelLibraryBinding.cs` as a compiled-in file: `Modules/Drainage/CE_CVL_SUITE.csproj:162`, `Modules/Structural/CE_STRUC_SUITE.csproj:205`. The class is `internal`, so each product carries its own private copy; no name clash between the two DLLs.
2. **CE_SHARED untouched.** `git diff --stat f5dd72a0 9a1f4e64 -- Shared/CE_SHARED Modules/Manager` is empty. `Shared/CE_SHARED/CE_SHARED.csproj` and `Modules/Manager/CE_SUITE_MANAGER.csproj` do not include the new file. So the Civil plus Manager one-identity rule is kept, provided the C-78 addendum ships the same CE_SHARED bytes as C-77 for both (check the hash at install, as usual).
3. **Manager.** Manager does not use ClosedXML and does not call `Register`. Its own fall-back resolver (`Modules/Manager/Plugin.cs:58`) is now second in line for the six Excel library names only.

### Question 4: the three failed tests in the Civil full Debug run

1. **The run.** `C:\ce-fx\b056\civilfull.txt`: Failed 3, Passed 21,496, Skipped 32, Total 21,531 (net10 Debug). Names match the report.
2. **`NewSettingsKeys_NeedADocumentedDefault`: related, fixed properly.** The fix added "Default: on" to the docs (lines 140 and 3315) with explicit initialisers (lines 143 and 3318). The test file and its exemption list `C60LegacySettingsKeys.txt` are unchanged in the PR, so it was not fixed by exempting the key. The re-run: `civil3.txt` (16:56, after the full run) ran 70 tests including that test's class (its skipped siblings in the same class are named in the log) with only the two IL failures, so the test passed. A passing test is not printed by name, so this is inferred from the log, not seen by name.
3. **`FinalLandingProducerCollapsesOnlyItsOwnFreeEndRun...` and `RefusedNativeCallbackInvalidatesTheManagedSession...`: unrelated.** Both are in `Modules/Drainage.Tests/Services/SourceAtomicCoordinatorDependencyTests.cs` (lines 279 and 422), read compiled instructions of `SourcePlacementService`, a file this PR does not touch, and are recorded as failing in Debug in earlier entries (`REGRESSION_LOG.md` lines 5449 and 9190; line 9190 says the second fails the same way on an older base). `civil3.txt` shows the Debug failure `Expected: dup But was: stloc.s`.
4. **Release re-run.** `civilrel.txt`: 29 of 29 passed in Release. I could not tell from the log whether those 29 include the two IL tests; the report says they do. Not verified by me.
5. **Structural.** `struc1.txt` 7 of 8 (one of the author's own new guards failed first), `struc2.txt` 8 of 8 after. The full Structural suite was not run.
6. **Gaps in the tests.** The unit tests cover the pure decision (`PickIndex`), the fault recogniser, the switch reads and the source shape. Nothing unit-tests the live handler steps (b) and (c); only the console probe exercises them.

### Question 5: what is NOT proven

1. **Full AutoCAD 2027 window (acad.exe).** Only the console version was probed. The full program may load things differently.
2. **The installed bundle.** The probe used a hand-copied build from 16:38; the commits are 16:59. I could not confirm the probed DLL is byte-for-byte the committed code (the 16:38 build came after the last structural code edit, `ed.sh` at 16:36, but the doc-text fix came later).
3. **CDCALC Export XLSX and Structural STRUCEXPORTCSV.** Not saved in the probe. Same library, more of it used.
4. **The CE log line** `[BUG-1255] Excel part: CE asked for ClosedXML ...`. Not seen anywhere.
5. **The plain message on screen** (Pit Schedule status line, CDCALC box, Structural command line). Not seen.
6. **AutoCAD 2022 to 2024 (net48) and 2025 to 2026 (net8).** Not run. 2022 to 2024 have the handler compiled out; 2025 to 2026 have it compiled in and untested.
7. **Excel opening the file.** Not done. I read the workbook's sheet list only.
8. **Why it worked on 14 Oct.** Unknown. Who loaded AutoCAD's 0.102.2 first on 30 Oct: unknown.

### What the robot (or Tim) must run to prove it

1. **N41, Pit Schedule, switch ON (default), AutoCAD 2027, installed build, on a copy of the H3 fixture.** Type `PITSCHEDULE`, press Export Excel, save to `C:\CE_TEST\BUG1255\Pit_Schedule.xlsx`. Right looks like: the save box opens; the file exists with sheets "Pit Schedule" and "Checking"; the status line reads "Excel export complete — sheet 1 the schedule, sheet 2 the checking sheet."; the CE log has one line starting `[BUG-1255] Excel part: CE asked for ClosedXML 0.102.3; using the copy`. Repeat in a second AutoCAD session.
2. **N41c, same steps with `excel.useAutoCadLoadedClosedXml` set to false in the Civil settings file before launch.** Right looks like (today's code): no file saved, and the old failure (the save box opens, then the export fails with the old error, not the plain message). Turn the switch back on afterwards. This is the "fails when broken" control for the Claude-accepted rule.
   1. **The author's N41c is wrong and must be corrected before it runs.** The fix report (`C:\CE_PLAN\areas\release-v3-colleagues-BUG1255_FIX_REPORT.md`, section FOR TIM item 6.2) expects, with the switch OFF, the status line "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows." and no "rendering error". The code does the opposite: the plain-message catch at `PitScheduleViewModel.Schedule.cs:142` runs only when `ExcelPartRule.IsOn()` is true, and the catch at line 148 lets a library fault through when the switch is off. The report's own technical section 1.2 says so ("the plain line is not caught"). As written, N41c would record a FAIL against a correct build.
   2. **If the desk takes my note (d)** (switch OFF keeps the old generic catch), N41c's expected line becomes "The Excel export could not be saved. See CE log." and no "rendering error". Either way, the case must be rewritten to match whichever code ships.
3. **CDCALC.** `CDCALC`, preview a package, Export XLSX, save to `C:\CE_TEST\BUG1255\CDCALC.xlsx`. Right looks like: the file exists, no error box.
4. **Structural.** In a Structural copy drawing, `STRUCEXPORTCSV`, save to `C:\CE_TEST\BUG1255\structural_schedule.xlsx`. Right looks like: the file exists, no `[STRUCEXPORTCSV] Error:` line.
5. **Order check.** Run step 4 first in a fresh session, then step 1, to cover "Structural registered the handler first".
6. **Open one saved file in Excel** (a Codex look), since the content has only been read as text.
7. **If a 2022 to 2024 machine is available:** Pit Schedule Export Excel once, to show nothing changed there.

### Question 6: verdict

1. **KEEP-WITH-NOTE.**
2. **The note:** (a) add the family and version check to step (c) at `ExcelLibraryBinding.cs:121-123` so CE never hands another plug-in a different-version Excel part; (b) correct the "Shown on the Settings page" comment at `Modules/Drainage/Models/UserSettings.cs:3308`, or add the row with Tim's layout decision; (c) change the "Use Export CSV" advice for CDCALC and Structural; (d) consider letting switch-OFF Pit Schedule keep the old generic line (`PitScheduleViewModel.Schedule.cs:148`) instead of escaping; (e) record in the card that the first product to start owns the handler; (f) rewrite robot case N41c's expected result to match the code (see "What the robot must run", item 2.1).
3. **Safe to join the C-78 addendum: yes.** It touches no CE_SHARED, Manager or drawing-writing code, compiles out on 2022 to 2024, and every new path falls back to nothing. Best joined with (a) to (c) done first, as each is a few lines; if the desk joins it unchanged, the step (c) risk is low and limited to other vendors' plug-ins on AutoCAD 2025 or 2026. BUG-1255 stays open until N41 and N41c pass in two sessions on the installed build.
