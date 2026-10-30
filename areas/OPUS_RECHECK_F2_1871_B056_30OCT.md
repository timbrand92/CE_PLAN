# Opus re-check F2: PR #1871 (B-056b, BUG-1255, Excel export on AutoCAD 2027)

Independent read-only re-check, Fri 30 Oct 2026, about 21:15 Melbourne. Reviewed head `0b8698eb` (was `9a1f4e64`) against base `f5dd72a0` (`claude/rel-20261030a`, C-77). Earlier review: `OPUS_PREREVIEW_F_1871_B056_30OCT.md`. Built and unit-tested only. Nobody has opened it in AutoCAD.

## FOR TIM

1. **Verdict: RE-CHECK OK WITH NOTE.** All four fixes are in and right. It is safe to join the C-78 addendum, merged as the whole PR.
2. **What changed since the first review.** Another firm's add-on asking for a different version of the Excel part now gets nothing from CE. CDCALC and STRUCEXPORTCSV now say only "Excel export could not start on this AutoCAD." Pit Schedule still says "Use Export CSV", because it has that button.
3. **A mistake to own, from this same job.** Its Structural test run (19:44 to 19:48) is the run that rewrote your Structural settings file at 19:47 (BUG-1257). The fix itself does not write your settings; the test set-up did. The job's report does not mention it.
4. **The 7 failed Structural tests are old, not from this fix.** The same 7 fail in another job's run that has none of this fix (#1875's worktree), and the files they look for do not exist on the base either.
5. **NOT proven.** The full AutoCAD 2027 window, a CDCALC save, a STRUCEXPORTCSV save, Excel opening the file, AutoCAD 2022 to 2026. Only the console version of AutoCAD 2027 saved a Pit Schedule workbook.
6. **What the robot must run on the installed C-78 build, AutoCAD 2027, two sessions.** Pit Schedule Export Excel with the switch on (file saves, sheets "Pit Schedule" and "Checking"); the same with the switch off (no file, the old failure, no "could not start" line); CDCALC Export XLSX (file saves, no error box). Then one Codex look that opens a saved file in Excel.

---

## DETAIL

### Method

1. **Git.** One fetch of `fb/bug1255-closedxml-autocad-2027` and `claude/rel-20261102a` (the brief named only the first; I needed the C-78 head object too). It wrote FETCH_HEAD and moved the two remote-tracking names; no branch, worktree or repository file changed. The other PR heads were already in the shared object store. Merge checks used `git merge-tree --write-tree`, which writes loose objects only.
2. **Read.** `git diff f5dd72a0 0b8698eb` and `git show 0b8698eb:<file>` for every changed file; the author's logs and probe outputs in `C:\ce-fx\b056` (NOT the `iso` folder); the author's worktree `C:\ce-fx\c88a` (status only: clean at `0b8698eb`); the installed bundles' library version lists (`*.deps.json`, read only); `C:\CE_PLAN` (carpark, desk log, pipeline state, C-78 finalizer report).
3. **Not done.** Built nothing, ran no test, opened no AutoCAD, read no settings file.

### 1. Does the version check close the wrong-copy risk?

1. **Yes.** `Shared/ExcelBinding/ExcelLibraryBinding.cs:127`: CE's own file is now handed back only when `PickIndex(name, new[] { AssemblyName.GetAssemblyName(own) }, true) == 0`, i.e. same name, same publisher token and same major.minor as the request (`PickIndex`, lines 39-57).
2. **Trace, another plug-in asks for ClosedXML 0.104 (or DocumentFormat.OpenXml 3.x) on AutoCAD 2025 or 2026.**
   1. Step (a), line 105-111: nothing already loaded of the same major.minor, so no.
   2. Step (b), lines 112-121: AutoCAD's copy by name; not the same major.minor (or none), so no.
   3. Step (c), line 127: CE's 0.102.3 file is not 0.104, so null (line 129). The other plug-in's own fall-back then gets its turn. Closed.
3. **Trace, same version (0.102.x) from any plug-in.** Step (a) or (b) gives the copy already in the session, else step (c) gives CE's copy. That is the intended behaviour. A request for a higher patch of the same major.minor (say 0.102.5) is stepped down to 0.102.3 or 0.102.2; that is the same deliberate rule CE uses for itself, low risk.
4. **CE's own Excel parts are never refused by the new check.** What CE ships matches exactly what its chain asks for (read from `C:\ce-fx\b056\ce\CE_CVL_SUITE.deps.json` lines 37-213, and from the installed Structural `Modern` and `Net8` lanes): ClosedXML 0.102.3 asks for DocumentFormat.OpenXml 2.16.0.0, ExcelNumberFormat 1.1.0.0, SixLabors.Fonts 1.0.0.0, XLParser 1.5.2.0; XLParser asks for Irony 1.0.11.0; CE ships exactly those. AutoCAD 2027's ClosedXML 0.102.2 asks for ExcelNumberFormat 1.1.0.0 and was served from CE's folder after the check (probe `run_A1\A1.log` 20:35:54.958, `run_B1\B1.log` 20:37:05.886).
5. **AutoCAD 2025 and 2026 (Net8 lane).** Handler compiled in. Expected: CE's own chain loads as before (versions match); other add-ons are no longer handed a wrong version. Not run; neither AutoCAD is installed here.
6. **AutoCAD 2022 to 2024 (Legacy lane).** `#if NET` at lines 80 and 94: `Register` is empty; nothing changes. The author reports both net48 compiles 0 errors (not re-checked by me; I built nothing).
7. **Every step is guarded.** A bad file in step (c) throws inside the outer try (lines 102-135) and returns null with one log line; `_busy` (lines 95, 100-101, 136) stops the handler calling itself.

### 2. Messages (file and line, at `0b8698eb`)

1. **CDCALC.** `Modules/Drainage/ViewModels/CalculationsV2ViewModel.cs:861-866`: with the switch on and a library-load fault, a box titled "CDCALC Export" says "Excel export could not start on this AutoCAD." (`Rules.ExcelPartRule.CouldNotStartPlainLine`, `Modules/Drainage/Rules/ExcelPartRule.cs:27`, text at `ExcelLibraryBinding.cs:32`). Any other fault keeps the old box "The XLSX file could not be created." (lines 867-873). No CSV mentioned; CDCALC has no CSV export (no "csv" in that file).
2. **STRUCEXPORTCSV.** `Modules/Structural/Services/ExportService.cs:24-28` rethrows with `ExcelCouldNotStartLine` (line 32): "Excel export could not start on this AutoCAD." The command line shows `[STRUCEXPORTCSV] Error: Excel export could not start on this AutoCAD.` (`Modules/Structural/Services/AsyncCommandService.cs:79`). The "CSV" in the command name is the command's own name, not advice.
3. **Pit Schedule.** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:142-147`, status line "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows." (`ExcelLibraryBinding.cs:28-29`). Correct: Export CSV exists (`PitScheduleViewModel.Schedule.cs:46`, button `PitScheduleViewModel.cs:284`).
4. **Plain English.** Yes, all three. Pinned by `Modules/Drainage.Tests/Services/Bug1255ExcelPartTests.cs` (`CdcalcAndStructural_NeverPointAtAnExportCsvThatIsNotThere`) and `Modules/Structural.Tests/Services/Bug1255ExcelPartTests.cs:68-76`.
5. **Switch off, Pit Schedule (unchanged, pre-review note d).** `PitScheduleViewModel.Schedule.cs:148` still lets a library fault escape the button when the switch is off. That is what the corrected N41c expects.

### 3. The Structural half

1. **Files.** `Modules/Structural/CE_STRUC_SUITE.csproj` (links the shared file, line 205), `Modules/Structural/Models/UserSettings.cs` (one property, about line 421), `Modules/Structural/Services/CeToolsInitializer.cs` (registers the handler, lines 49-51), `Modules/Structural/Services/ExportService.cs` (plain line, switch read, never-inlined writer), `Modules/Structural.Tests/Services/Bug1255ExcelPartTests.cs`.
2. **Do the PR's tests write Tim's real settings?** No. The Structural tests deserialise JSON text in memory (lines 35-53) and read source files (lines 55-84); none calls `SettingsService`, `Initialize`, `Save` or `ExcelPartSwitchOn`. The Civil tests use `SettingsService.DeserializeSettings` on text only.
3. **But the job's own Structural full run did hit the real file (the 19:47 incident).** Evidence:
   1. `C:\CE_PLAN\areas\BUG_PIPELINE_STATE.md` line 8 names job `c92a` as #1871's; `BUG_CARPARK.md` line 17498 (BUG-1257) says build job c92a ran the full Structural suite without the redirect and Tim's `CS_Settings.json` changed at 19:47:55.
   2. `C:\ce-fx\b056\sfull.run.txt`: slot free 19:44:08; `sfull.txt` ends 19:48 with "Failed 7, Passed 1281, Skipped 5, Total 1293". The run's scratch folder `C:\ce-fx\b056\t_sfull` (last change 19:48:15) has no `appdata_root` folder, so the Structural settings were not redirected there.
   3. The redirect line in `C:\ce-fx\b056\test.ps1` (line 7, `CE_STRUC_SUITE_APPDATA_ROOT`) is in a file last saved at 19:57, after the incident. No later Structural full run exists for this job, so "isolation is set now" is true of the script, but the 7-failure figure comes from the unisolated run.
   4. Cause class: test set-up (BUG-1257), not this PR's product code. The job report and the REGRESSION_LOG entry do not mention it; they should (rule 2.8).
4. **Switch key.** `Excel.UseAutoCadLoadedClosedXml`, added inside the existing Structural `ExcelSettings` group, `= true`, doc "Default: on." No Structural guard test checks the doc (the documented-default guard scans Civil only); the doc is present by eye.
5. **"Tim's saved values preserved."** Yes. It is a new key in an existing group. Loading keeps every saved value in that group (`LastFolder`, learned phrases, schedule switches); only the missing key takes its default ON (`TheSwitch_ReadsAsTyped_AndChangesNothingElse` pins a neighbour keeping its value). Structural writes its settings file back at every start-up (`Modules/Structural/Services/SettingsService.cs`, `Initialize`: `PersistSettings(_current)`), so the key will appear in Tim's file as `true` on first start; nothing else is changed by this PR. (The two Rebar flags noted in BUG-1257 are a separate question already with CE 04.)

### 4. The 7 failed Structural tests

1. **Not caused by this PR.** Names: `AutoCadWriter_OwnsExactlyOneTransactionAndCommit`, `CommitFolder_IsExactUnhostedScope`, `SpecialWriter_MapsPickedSupportsToTheFinalBeamEnds` (all `Stage3B2bWriterBoundaryTests.cs`), `B5RoutesCommand4WhileCommand5RemainsLegacy`, `BextEvidenceReaderIsSelectedOnlyExactLabelAndReadOnly`, `SpecialCaptureFactoryAssemblesOnlyTheNoWritePromptFlow`, `SpecialInitialPromptSessionIsReadOnlyAndUnrouted` (all `BeamCommandSelectedSourceReaderBoundaryTests.cs`).
2. **Why they fail on the base too.** Both test files exist unchanged on base `f5dd72a0` (last touched by `51de5328`). The four source files they open (`AutoCadBeamSpecialAtomicWriter.cs`, `BeamExtensionAutoCadEvidenceReader.cs`, `BeamSpecialCommandAutoCadCaptureFactory.cs`, `BeamSpecialCommandAutoCadPromptSession.cs`) are absent from `f5dd72a0`, `0b8698eb` and `91963bd0` alike; the other two expect a Commit-folder file list and a beam route the base does not have. The PR touches no file under `ConnectedDesign` or `Commands`.
3. **Measured, not just reasoned.** `C:\ce-fx\c79c_scratch\solution_run1.log` (job c79c, #1875, a different base with none of #1871) shows the same 7 failing by name in its net10 run ("Failed 7, Passed 1273"). Not on the identical base, but with no Excel code at all.
4. **REGRESSION_LOG.** No entry on the base names these 7. They should be logged as a known Structural red (a separate carpark item, not this PR's).

### 5. Is the Civil/Manager content separable for C-78?

1. **Take the whole PR, do not cherry-pick Civil files.** Civil's test `TheLibraryHandling_IsOneSharedSourceFile_LinkedIntoBothProducts` (Civil `Bug1255ExcelPartTests.cs`, last test) reads `Modules/Structural/CE_STRUC_SUITE.csproj` and would fail if the Structural csproj line were left out.
2. **Files C-78 takes (all 15):** Civil: `CE_CVL_SUITE.csproj`, `Models/UserSettings.cs`, `PluginInitialization.cs`, `Rules/ExcelPartRule.cs`, `Services/CalculationExportPackage.cs`, `ViewModels/CalculationsV2ViewModel.cs`, `ViewModels/PitScheduleViewModel.Schedule.cs`, Civil test file; shared `Shared/ExcelBinding/ExcelLibraryBinding.cs`; Structural (rides along, not shipped): csproj, `Models/UserSettings.cs`, `Services/CeToolsInitializer.cs`, `Services/ExportService.cs`, Structural test file; `REGRESSION_LOG.md`.
3. **No Structural-only dependency in the shared file.** It uses only `System`, `System.IO`, `System.Linq`, `System.Reflection`, `System.Runtime.Loader` (lines 1-8). Civil links it at `CE_CVL_SUITE.csproj:162`. CE_SHARED and Manager are untouched (`git diff --stat f5dd72a0 0b8698eb -- Shared/CE_SHARED Modules/Manager` is empty), so the CE_SHARED one-identity rule is unaffected.
4. **Side effect worth one line in the card.** The handler is session-wide. Once Civil ships it, an installed Structural that lacks it may also get its STRUCEXPORTCSV Excel parts served on AutoCAD 2027 when Civil is loaded (Civil's folder holds the same versions). Untested; probably helpful, but it is a Structural behaviour change arriving through a Civil train.
5. **C-78 class.** The finalizer graded C-78 AREA because it has "no loader ... change". #1871 adds a session-wide library-loading handler at Civil start-up (`PluginInitialization.cs:59-62`). My reading: that is a loader-type change, so the desk should re-check the class and include a plain start-up smoke (AutoCAD opens, CE ribbon loads, one Civil command) in the addendum re-test. The desk decides; I have not changed anything.

### 6. Clashes (merge-tree)

1. **With C-78 head `91963bd0`:** one conflict, `REGRESSION_LOG.md` lines 1-64 of the merged file (both add entries at the top; keep both). `Modules/Drainage/Models/UserSettings.cs` (both add switches) merges clean.
2. **#1870 `3a152ada`:** clean (already inside C-78).
3. **#1873 `ba299320`, #1876 `d30041c4`, #1878 `f0500eda`, #1875 `1a6c332b`:** `REGRESSION_LOG.md` only.
4. **#1877 `b9842f28`:** `REGRESSION_LOG.md` only. It also edits `UserSettings.cs` (Linking group) and `CalculationExportPackage.cs` (about lines 505-545, the WSUD section), far from #1871's line 134 change; both merge clean.
5. **#1868 `38c3f825` and #1874 `1b8b4af1`:** pairwise, `UserSettings.cs` conflicts at merged lines 1447-1489 and 3011-3035 respectively, plus `REGRESSION_LOG.md`. Those hunks are not #1871's lines (#1871 adds near 138 and 3308); they come from those PRs sitting on older bases.
6. **#1869 `bdec2fd1` and #1872 `336bc513`:** pairwise conflicts in `RulebookEngineTests.cs`, `CouncilSweepParityTests.cs`, `KingstonStormFrequencyTests.cs` plus `REGRESSION_LOG.md`, none of them files #1871 touches: base differences only.
7. **Not checked:** a merged C-78 plus #1871 tree has not been built or tested by anyone. The addendum must run the full Civil suite on the merged tree.

### 7. Small things (not blockers)

1. **Start-of-file mark removed.** `CalculationsV2ViewModel.cs` lost its invisible UTF-8 start mark in `c137e78a` (base and C-78 have it). The compiler still reads it as UTF-8 and the Civil suite passed, so it is harmless, but it is an unrelated whole-file change; restoring it is tidy.
2. **Stale text.** The first REGRESSION_LOG entry still says "OFF = no handler" and lists "Use Export CSV" for CDCALC and Structural (superseded by the follow-up entry's item 3). The Civil test file's summary still says "the copy that loads first in a session wins", which the probe disproved.
3. **Hash typo.** The report gives SHA256 "C349E9F7...BAB8B1E"; the probed `C:\ce-fx\b056\ce\CE_CVL_SUITE.dll` hashes to `c349e9f7...cdab8b1e`. I could not compare it with the Release build output, which is no longer on disk.
4. **What the probe's "off" runs really were.** `C:\ce-fx\b056\probe\Probe.cs:50` sets the once-per-session flag before CE loads, so in A0 and B0 the handler was never registered; the settings switch itself was not set to false. Same effect by the code (line 104), but N41c is the first time the real switch-off path is exercised.
5. **Probe re-run confirmed.** Logs 20:34 to 20:37: A0 and B0 FAIL with the 0x80131040 refusal; A1 and B1 PASS. I read both saved workbooks: `run_A1\A1.xlsx` and `run_B1\B1.xlsx` hold sheets "Pit Schedule" and "Checking". In A1 and B1 CE's own start-up had already registered the handler (flag True after load), so the real start-up registration was used.
6. **Tested tree vs committed tree.** The Civil full run ended 20:08; the code commit is 20:33. The author says the working tree had no other change; I could not verify that, only that the worktree is clean at `0b8698eb` now.

### 8. NOT proven, and the scenario to run

1. **Not proven:** full AutoCAD 2027 window (acad.exe); the Pit Schedule button itself (the probe called the writer directly); CDCALC Export XLSX save; STRUCEXPORTCSV save; the CE log line `[BUG-1255] Excel part: CE asked for ...`; the plain lines on screen; Excel opening the file; AutoCAD 2022 to 2026; the merged C-78 tree.
2. **Robot, installed C-78 build, AutoCAD 2027, copies only, two separate sessions:**
   1. **N41, switch on (default).** Open a copy of the H3 fixture, type `PITSCHEDULE`, press Export Excel, save to `C:\CE_TEST\BUG1255\Pit_Schedule.xlsx`. Right looks like: save box opens; file exists with sheets "Pit Schedule" and "Checking"; status line "Excel export complete — sheet 1 the schedule, sheet 2 the checking sheet."; one CE log line starting `[BUG-1255] Excel part: CE asked for ClosedXML 0.102.3; using the copy`.
   2. **N41c, switch off.** Before launch set `excel.useAutoCadLoadedClosedXml` to `false` in the Civil settings file of the TEST profile (never Tim's own file). Same steps. Right looks like: save box opens, no file saved, the old failure appears, and NO "Excel export could not start" line. Set it back to `true` afterwards.
   3. **CDCALC.** `CDCALC`, preview a package, Export XLSX, save to `C:\CE_TEST\BUG1255\CDCALC.xlsx`. Right looks like: file exists, no error box.
   4. **Start-up smoke (loader change).** AutoCAD opens, the CE ribbon loads, one ordinary Civil command runs.
   5. **Codex look.** Open `Pit_Schedule.xlsx` in Excel: two sheets, readable rows.
   6. **Structural (later, its own train):** `STRUCEXPORTCSV` to `C:\CE_TEST\BUG1255\structural_schedule.xlsx`, first in a fresh session, then N41, to cover "Structural registered the handler first".
3. BUG-1255 stays OPEN until N41 and N41c pass in two sessions on the installed build (Claude-accepted rule), plus the Codex look.

### 9. Verdict

1. **RE-CHECK OK WITH NOTE.** Safe to merge into the C-78 addendum, as the whole PR.
2. **The note:**
   1. Record in BUG-1257 and the job record that c92a's own Structural full run (19:44 to 19:48) is the 19:47 rewrite, and that its 7-failure figure came from that unisolated run.
   2. The desk to re-check C-78's AREA class (session-wide library-loading change at start-up) and add the start-up smoke.
   3. Run the full Civil suite on the merged C-78 plus #1871 tree; resolve `REGRESSION_LOG.md` by keeping both top entries.
   4. Log the 7 known Structural reds as their own carpark item.
   5. Optional tidy: restore the start-of-file mark in `CalculationsV2ViewModel.cs`; fix the stale lines in the first REGRESSION_LOG entry and the test summary.
   6. Still open from the first review: note (d), Pit Schedule switch-off keeping the old generic line, and note (e), the first-product-registers rule in the card.
