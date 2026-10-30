# BUG-1255 fix report: Export Excel on AutoCAD 2027 (job B-056, Fri 30 Oct 2026, finished about 17:10 Melbourne)

## FOR TIM

1. **The answer.** Draft PR **#1871** (base `claude/rel-20261030a`, branch `fb/bug1255-closedxml-autocad-2027`). On AutoCAD 2027, Pit Schedule Export Excel and CDCALC Export XLSX should open the save box and save again. Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1255 stays open.

2. **What a drafter will see differently.** Click Export Excel in the Pit Schedule window: the Windows save box opens and the status line reads "Excel export complete". Before, there was no save box and a "rendering error". If Excel still cannot start for some other reason, the line reads "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows." Structural STRUCEXPORTCSV (which saves a .xlsx) gets the same fix in its own commit in the same PR.

3. **Mistakes of my own, first.**
   1. The worktree held an earlier attempt's unsaved edits to five existing files. My hard reset (as the desk note told me) threw those edits away. The new files survived and I rebuilt the rest in about 30 minutes. Cost: 30 minutes, no lost evidence.
   2. My first fix design was wrong. I built it to load AutoCAD's Excel copy early at start-up. The real-AutoCAD probe showed that does nothing, so I rebuilt it (final design below). The probe caught it, nothing shipped.
   3. About 25 minutes went on setting up (bash had no PowerShell on its path, so my first wait-for-a-free-build-slot ran as no wait at all). No build ran more than one at a time beyond the two-slot limit; I checked the count before every build after that.

4. **The desk note was wrong on one point, and the cause is a bit different.** The note said "whichever copy loads first in a session wins". In a real AutoCAD 2027 console session CE's copy is refused whichever loads first. I tried both orders (section 2 below). So it is not load order. Why the same export worked on 14 Oct is **not established**.

5. **What is NOT proven.**
   1. Nobody has driven it in the full AutoCAD window. The probe ran in the console version of AutoCAD 2027 (accoreconsole), not acad.exe.
   2. CDCALC's workbook and Structural's workbooks were not saved in the probe. Only the Pit Schedule workbook was. Both use the same library, so very likely fine, not proven.
   3. The one-line CE log message was not seen (the console session writes no CE log I could find). The robot case below checks it.
   4. Sheets register Excel export and the member-catalogue palette get the library fix (it is process-wide) but not the plain line.
   5. AutoCAD 2025 and 2026 are not installed here. AutoCAD 2022 to 2024 are untouched by design.

6. **Robot case that proves it, with a switch-off control: `N41_excel_export` (and control `N41c_excel_export_off`).**
   1. `N41`: open the H3 fixture (a drawing with schedule rows), type `PITSCHEDULE`, press Export Excel, type `C:\CE_TEST\BUG1255\Pit_Schedule.xlsx` into the save box and press Save. Check: the file exists and holds sheets "Pit Schedule" and "Checking"; the window status line reads "Excel export complete — sheet 1 the schedule, sheet 2 the checking sheet."; the CE log holds one line starting `[BUG-1255] Excel part: CE asked for ClosedXML 0.102.3; using the copy`. Repeat in a second AutoCAD session for the two-session rule.
   2. `N41c`: before launch set `excel.useAutoCadLoadedClosedXml` to false in the settings file (the switch is read at launch), type the same steps. Check: no file, status line reads "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows." and no "rendering error" on the command line. Turn the switch back on after.
   3. Add CDCALC: `CDCALC`, Export XLSX, same path style; check the file exists and no error box.

---

## 1. Technical detail

1. **Change (3 files of logic).** `Shared/ExcelBinding/ExcelLibraryBinding.cs` (one source file linked into Civil and Structural, CE_SHARED untouched). `Register(ownFolder, isOn, log)` runs once per session from `PluginInitialization.Initialize` and `CeToolsInitializer.Initialize` (process flag `CE.ExcelBinding`; the second call is a no-op). It adds `AssemblyLoadContext.Default.Resolving`. For ClosedXML, DocumentFormat.OpenXml, SixLabors.Fonts, ExcelNumberFormat, XLParser and Irony it returns, in order: (a) a copy of the same family (same token, same major.minor) already loaded; (b) AutoCAD's own copy asked for by name with no version, if same family; (c) CE's own copy from the CE folder (needed for the three libraries AutoCAD does not ship, because AutoCAD's ClosedXML asks for them from AutoCAD's folder where .NET never looks beside CE's DLL). `#if NET` only; AutoCAD 2022 to 2024 (net48) compile it out.
2. **Switch** `excel.useAutoCadLoadedClosedXml`, `UserSettings.Excel` (new `ExcelSettings` group, `Modules/Drainage/Models/UserSettings.cs`), "Default: on." Structural: `Excel.UseAutoCadLoadedClosedXml` in the existing `ExcelSettings`. Switch OFF = handler returns nothing and the plain line is not caught, as before. It is not on the Settings page (the neighbouring `pitScheduleExcel` switch is not either).
3. **Plain line.** `ExcelPartRule.CouldNotStartLine` (Civil), `ExportService.ExcelCouldNotStartLine` (Structural), exactly "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows." Pit Schedule: `ExportExcel` now calls `SaveExcelWorkbook` (never inlined) inside the try, with catch filters `when (IsOn() && IsLibraryLoadFault(ex))` and `when (IsOn() || !IsLibraryLoadFault(ex))`. CDCALC: `SaveXlsx` marked never-inlined, a new filtered catch in `CalculationsV2ViewModel.ExportToXlsx`. Structural: `ExportCsv` wraps `ExportScheduleXlsx` (never inlined) and rethrows with the plain line, original fault kept inside.
4. **Cause of "rendering error" at line 113:** the method held an `XLWorkbook` local, so .NET loaded ClosedXML on entry, outside the try. Confirmed by the design pass; my change moves it.
5. **Tests.** Civil `Bug1255ExcelPartTests` plus neighbours (84 in the focused run, count not 0). Structural 8 of 8. Civil full net10 Debug: 21,531 total, 21,496 passed, 32 skipped, 3 failed: one was mine (`NewSettingsKeys_NeedADocumentedDefault`, the new group's doc lacked "Default:"; fixed and re-run green); the other two (`FinalLandingProducerCollapsesOnlyItsOwnFreeEndRun...`, `RefusedNativeCallbackInvalidatesTheManagedSession...`) are IL-shape tests that fail in Debug and pass in Release (re-run in Release with the new tests and the PDF page tests: 29 of 29). net48 compile Release: Civil 0 errors, Structural 0 errors (refs from the C62 report). I did not run the guard tests against the unfixed code (the failing twin is the probe controls below) and did not run the full Structural suite.
6. **Left out:** `Sheets register` and `XlsxMemberCatalogueProvider` plain lines; Settings page row; an Option C (private load context) or D2 (own writer) follow-on if a `[BUG-1255] Excel part: ... failed` line ever appears.

## 2. Probe evidence (accoreconsole 2027, R26.0, .NET 10.0.12, isolated profile, copies only)

Probe: `C:\ce-fx\b056\probe` (a throwaway DLL, reflection only, no ClosedXML reference), CE Civil (my build, 3.0.87+fix) copied to `C:\ce-fx\b056\ce`. Each run is its own accoreconsole process (`/isolate`, a copy of the template drawing). Nothing under Tim's profile, bundles, logs or settings was touched (I searched Tim's CE log folder for BUG-1255 lines: none). A full acad.exe (started 16:08) was open the whole time; the console runs are separate processes.

1. **Control A0, AutoCAD's own ClosedXML loaded first, CE binding switched off:** FAIL. `FileLoadException: Could not load file or assembly 'ClosedXML, Version=0.102.3.0 ... The located assembly's manifest definition does not match the assembly reference (0x80131040)`, inner failure loading CE's own `ClosedXML.dll`. This is the exact signature of the 30 Oct 08:13 log.
2. **Control B0, CE first, binding switched off:** FAIL, same text. So CE's copy cannot load first either: the desk's "whichever loads first wins" is not what happens.
3. **A1, AutoCAD's copy first, binding on:** PASS. The save returned, an .xlsx of 8,011 bytes was written; ClosedXML 0.102.2 (AutoCAD's), DocumentFormat.OpenXml 2.16.0.0 and SixLabors.Fonts 1.0.0.0 (AutoCAD's), ExcelNumberFormat 1.1.0.0 (from CE's folder).
4. **B1, CE first, binding on:** PASS, same loaded set; a later request for ClosedXML 0.102.2 by name was served by AutoCAD's 0.102.2.
5. **File content check:** the saved workbook has sheets "Pit Schedule" and "Checking" (workbook.xml read). I did not open it in Excel.
6. **Candidates the desk asked about:** A (build the Modern lane against 0.102.2) was NOT probed: it needs a different build and cannot have a switch; kept as the fallback. B (resolve handler) is the shipped route and works in both orders. C (private load context) was not built. **A first attempt at B (preload AutoCAD's copy, no handler) FAILED in the probe**, so a preload alone is not a fix.
7. **Side finding:** loading CE's DLL into the console session ran CE's own `Initialize` (the process flag was already set after the load), which is why the controls had to set the flag before loading CE.
8. **Manager question (who loaded 0.102.2 first on 30 Oct):** not probed. Unknown.
9. **Could not prove:** acad.exe behaviour (the full AutoCAD may differ from the console in what it puts on the trusted list); CDCALC and Structural saves; the CE log line; Excel opening the file.

## 3. Files

`Shared/ExcelBinding/ExcelLibraryBinding.cs` (new), `Modules/Drainage/Rules/ExcelPartRule.cs` (new), `Modules/Drainage/Models/UserSettings.cs`, `PluginInitialization.cs`, `CE_CVL_SUITE.csproj`, `Services/CalculationExportPackage.cs`, `ViewModels/CalculationsV2ViewModel.cs`, `ViewModels/PitScheduleViewModel.Schedule.cs`, `Modules/Structural/{CE_STRUC_SUITE.csproj, Models/UserSettings.cs, Services/CeToolsInitializer.cs, Services/ExportService.cs}`, two `Bug1255ExcelPartTests.cs`, `REGRESSION_LOG.md`. Cleanup: bin/obj removed with `git clean -fdXq` in `C:\ce-fx\c88a` only. Probe folder `C:\ce-fx\b056` left for the reviewer.


---

# FOLLOW-UP (B-056b, Fri 30 Oct 2026, about 20:45 Melbourne): four fixes to draft PR #1871 from the Opus pre-review

## FOR TIM

1. **The answer.** Draft PR **#1871** now carries the four fixes (branch head `0b8698eb`, two new commits, normal push). Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1255 stays open.

2. **What a drafter will see differently.**
   1. **Pit Schedule Export Excel, CDCALC Export XLSX, STRUCEXPORTCSV:** the same as before this follow-up (the save box opens and the .xlsx saves on AutoCAD 2027).
   2. **If Excel still cannot start:** CDCALC's box and the Structural command line now say only "Excel export could not start on this AutoCAD." Neither has an Export CSV button, so the old "Use Export CSV" pointed at nothing. Pit Schedule keeps its sentence with Export CSV, because it does have that button.
   3. **Another firm's add-on on AutoCAD 2025 or 2026** is no longer handed CE's Excel part when it asks for a different version of it. Nothing changes on screen for a drafter.

3. **Mistakes of my own, first.**
   1. My editing script stripped an invisible start-of-file mark from `UserSettings.cs`. I caught it in the diff and put it back before committing. No cost.
   2. My first test run failed at once: a Release build needs an empty placeholder file for the 2027 transform part, which the Debug builds already had. Cost: one wasted slot wait (about 15 minutes).
   3. The earlier worktree `C:\ce-fx\b056` was not a git folder (only the probe and logs); the real worktree is `C:\ce-fx\c88a`. I used that.

4. **The probe re-run answers your fourth item.** The earlier probe ran a 16:38 build. I rebuilt the Civil lane from the branch (Release, net10) and re-ran the AutoCAD 2027 console probe, both load orders, isolated profile, copies only. Result: with the fix both orders PASS (the Pit Schedule workbook saved, 8,011 bytes, sheets "Pit Schedule" and "Checking" read from the file); with the switch off both orders FAIL, as before. The probed DLL is byte-identical to the Release DLL built from the branch code (SHA256 `C349E9F7...BAB8B1E`). One honest gap: the build's own version stamp reads `3.0.87+9a1f4e64`, because I built before committing; the code in it is the committed `c137e78a` (the working tree had no other change).

5. **What is NOT proven.**
   1. The full AutoCAD 2027 window (acad.exe). The probe is the console version, and it called the Pit Schedule writer by reflection, not the button.
   2. CDCALC Export XLSX and Structural STRUCEXPORTCSV were still not saved in the probe. The Structural test run covers the wording, not a real save.
   3. The new plain sentences were not seen on screen.
   4. The new step (c) check was exercised only by the probe's Pit Schedule save (the one library from CE's folder, ExcelNumberFormat, was still served after the check). AutoCAD 2025 and 2026 are not installed here.
   5. Excel opening the file. I read the sheet list only.
   6. Pre-review note (d), Pit Schedule with the switch off keeping the old generic line, and note (e), the first-product-registers rule, are NOT done (not in the four). Note (e) belongs in the card.

6. **Robot case, corrected: `N41_excel_export` with control `N41c_excel_export_off`.**
   1. `N41` is unchanged from section 6.1 above, plus: `CDCALC`, preview a package, Export XLSX, type `C:\CE_TEST\BUG1255\CDCALC.xlsx`; check the file exists and no error box. And in a Structural copy drawing `STRUCEXPORTCSV`, save to `C:\CE_TEST\BUG1255\structural_schedule.xlsx`; check the file exists and no `[STRUCEXPORTCSV] Error:` line. Run Structural first in a fresh session, then Pit Schedule, to cover "Structural registered the handler first".
   2. **`N41c` must be rewritten before it runs** (the pre-review is right, my first wording was wrong): with `excel.useAutoCadLoadedClosedXml` false before launch, the code does NOT show the plain sentence. It lets the library fault through, so expect: no file saved, the save box opens, then the old failure ("rendering error" or the library's own text), and no "Excel export could not start" line. That is the "fails when broken" control.

---

## Technical detail (follow-up)

1. **Fix 1.** `Shared/ExcelBinding/ExcelLibraryBinding.cs`, step (c) of `Resolve`: `File.Exists(own) && PickIndex(name, new[] { AssemblyName.GetAssemblyName(own) }, true) == 0`. Same name, same publisher token, same major.minor as the request, else null. One shared file, so Civil and Structural get it together. CE_SHARED untouched (`git diff --stat` shows no `Shared/CE_SHARED`). Risk to watch: if AutoCAD's ClosedXML ever asks for a library at a major.minor CE does not ship, step (c) now returns nothing and the export fails with the plain line; the probe shows ExcelNumberFormat 1.1 is fine on 2027.
2. **Fix 2.** `UserSettings.cs` comment on `ExcelSettings` now says the switch lives only in the settings file. No Settings row added (as instructed).
3. **Fix 3.** New `ExcelLibraryBinding.ExcelCouldNotStartPlainLine` and `ExcelPartRule.CouldNotStartPlainLine`, used by `CalculationsV2ViewModel` (CDCALC). `ExportService.ExcelCouldNotStartLine` (Structural) is now the plain sentence. Pit Schedule's `ExcelPartRule.CouldNotStartLine` is unchanged.
4. **Tests.** New Civil tests: `CdcalcAndStructural_NeverPointAtAnExportCsvThatIsNotThere` (the exact sentence, no "CSV" in it, CDCALC source uses the plain line and not the CSV line, Pit Schedule keeps the CSV line), `CesOwnCopy_IsOnlyHandedToARequestForTheVersionCeShips` (PickIndex: 1.1 and 1.1.5 accepted, 2.0 refused, another publisher refused; source guard on the step (c) expression), `TheSettingsComment_DoesNotClaimASettingsPageRow`. Structural: the plain line pinned exactly and without "CSV". Switch-off behaviour is unchanged by this follow-up (the handler returns before step (c) when the switch is off); no new test of that beyond the existing `SwitchOff_HandsBackNothing`.
5. **Results, Release, one top-level dotnet command at a time, below-normal priority.**
   1. Civil focused (`Bug1255ExcelPartTests` and `C60AuditSourcePinGuardTests`): 71 total, 68 passed, 3 skipped, 0 failed.
   2. Structural `Bug1255ExcelPartTests`: 8 of 8.
   3. Civil full suite net10 Release: **21,534 total, 21,502 passed, 32 skipped, 0 failed** (16 m 29 s; count not zero; the PDF page test passed in the run).
   4. Structural full suite net10 Release: 1,293 total, 1,281 passed, 5 skipped, **7 failed**. All 7 are source-reading guards that open files that are not in this tree (`AutoCadBeamSpecialAtomicWriter.cs`, `BeamExtensionAutoCadEvidenceReader.cs`, `BeamSpecialCommandAutoCadCaptureFactory.cs`, `BeamSpecialCommandAutoCadPromptSession.cs`) or compare file lists in `ConnectedDesign/Commit` and the beam command route (`AutoCadWriter_OwnsExactlyOneTransactionAndCommit`, `CommitFolder_IsExactUnhostedScope`, `SpecialWriter_MapsPickedSupportsToTheFinalBeamEnds`, `B5RoutesCommand4WhileCommand5RemainsLegacy`, `BextEvidenceReaderIsSelectedOnlyExactLabelAndReadOnly`, `SpecialCaptureFactoryAssemblesOnlyTheNoWritePromptFlow`, `SpecialInitialPromptSessionIsReadOnlyAndUnrouted`). `git ls-files` finds none of those four files at all, and none of the tests touches Excel. I did NOT run them on the base to compare by name, so "pre-existing" is my reading of the cause, not a measured comparison.
   5. net48 Release compile: Civil 0 errors, Structural 0 errors (refs as in the C62 report).
6. **Probe:** `C:\ce-fx\b056\run_A0, run_A1, run_B0, run_B1` (20:34 to 20:37), CE copy in `C:\ce-fx\b056\ce`. The probe's own "sheets:" log line is blank (its pattern); I read `xl/workbook.xml` from `A1.xlsx` and `B1.xlsx` directly. The isolated profile folder `C:\ce-fx\b056\iso` was kept and never copied into any repo.
7. **Files:** `Shared/ExcelBinding/ExcelLibraryBinding.cs`, `Modules/Drainage/{Rules/ExcelPartRule.cs, ViewModels/CalculationsV2ViewModel.cs, Models/UserSettings.cs}`, `Modules/Structural/Services/ExportService.cs`, the two `Bug1255ExcelPartTests.cs`, `REGRESSION_LOG.md`.
