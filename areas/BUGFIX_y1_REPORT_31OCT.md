# B-099 step 1 (y1): which code writes Tim's real log, settings, sessions and outbox during a test run

Job: CE 01 Build, key y1, build number B-099, Tim item 153 ("6yes", voice batch 2), follow-up to B-062 / PR #1884 / BUG-1257.
Written Sat 31 Oct 2026, 14:15 Melbourne. Read-only job: no code changed, no build, no test, no PR.
Lines read: Civil/Manager `origin/claude/rel-20261102a` (head 3fbb9da5, Civil 3.0.88 / Manager 1.1.88) and Structural
`origin/claude/rel-20261026s` (head 204dfad2, Structural 1.0.125).

## ANSWER FIRST

1. **PR number:** none. This was step 1, read-only.
2. **Structural (the installed line): ALREADY FIXED.** Every Structural writer into the logs, settings, sessions and
   outbox folders already sends a test run's files to a temporary folder. The fixing commits are e8e9631f (3 Oct, logs,
   BUG-348 item 6), c3d4897a (3 Oct, admin telemetry tree including outbox and sessions, install salt and old data
   folders) and 26321e13 (1 Oct, settings, BUG-294). A source guard on that line already fails if a new unredirected
   AppData path appears.
3. **Civil and Manager (rel-20261102a): no unredirected writer found** in those four folders. Every one honours
   `CE_LOG_DIR_OVERRIDE`.
4. **The real hole is the old Structural copy on the Civil line.** `Modules/Structural` on rel-20261102a is the
   2 July 2026 snapshot (last change to Logger.cs: 3a147be1, 2 Jul). It is in the solution, so its tests get built and
   run from Civil-line worktrees. None of the three fixes above are on that line. That copy writes Tim's real Structural
   log, his real `TIM_CE_CADTOOLS\logs` Structural log and (without #1884) his real `CS_Settings.json`.
5. **#1884 was written against that old copy**, so its "still exposed" list is true for the Civil line and false for
   the Structural line. CE 01's check was right.
6. **The class that writes usage, failure and machine files** is `AdminTelemetryService`: Civil
   `Modules/Drainage/Services/AdminTelemetryService.cs`, through the shared `CeTelemetryStore`, and Structural
   `Modules/Structural/Services/AdminTelemetryService.cs`, through `StructuralAppDataPaths.AdminTelemetryRoot()`. Both
   redirect. No test on either line calls them in a way that writes.
7. **What a drafter will see differently:** nothing. This is about test runs only.
8. **Robot case:** none applies. Nothing changes in a drawing. The proof is the run-end guard in section 3 below, with
   its own planted-file control.

## Mistakes of my own first

1. None that cost anything. One near miss: I almost reported `SupportBundleService` as "no override on the Structural
   line". The file does not exist on rel-20261026s at all; it exists only in the old copy on the Civil line, and there
   it only reads the logs and writes the support zip to the Desktop.
2. My real-folder listing was taken while AutoCAD was open (acad.exe started 14:01:00). The live log, the sessions file
   and the outbox were changing as I read. That was AutoCAD, not me: this job ran no test and wrote nothing outside
   `C:\CE_WORK\scratch\y1` and this report.

## What is NOT proven

1. No test was run. Every finding comes from reading code at the two named heads.
2. Whether the Civil bundle ships the old `CE_STRUC_SUITE.dll`. I believe Structural ships only from the Structural line
   but did not check the Civil packaging.
3. That no test reaches the four adjacent writers listed in section 1.4. I checked the four folders the task named, and
   only listed the rest.
4. Manager tests were not run (standing rule). On reading, Manager's writers and its test module initializer both
   redirect, but nobody has proved that with a run.

## Real-folder listing (names, sizes, times only; read at 14:10 on 31 Oct; no test was run, so there is no "after")

1. `%APPDATA%\TIM_CE_CADTOOLS`: 29,422 files, newest 14:05:24 (CD_RecentValues.json).
2. `%APPDATA%\CE_STRUC_SUITE`: 2,500 files, newest 14:09:44 (ce_struc_suite.log).
3. `%APPDATA%\CE_CVL_SUITE`: 301 files, newest 14:05:25 (ce_cvl_structured_20261031.log).
4. `%APPDATA%\CE_CADTOOLS`: 1,022 files, newest 14:10:07 (CE_SUITE_MANAGER.json).
5. `TIM_CE_CADTOOLS\CD_Settings.json`: 15,270 bytes, 4 Oct 08:22:30.
6. `CE_STRUC_SUITE\CS_Settings.json`: 35,613 bytes, 30 Oct 19:54:14.
7. `CE_STRUC_SUITE\logs\ce_struc_suite.log`: 3,699,136 bytes, 31 Oct 14:09:44.
8. `CE_SUITE\manager-switches.json`: absent.
9. `outbox\usage`: 25,795 files, newest 14:04:43. `outbox\failures`: 1,980 files, newest 01:28:41.
   `outbox\machines`: 2 files, newest 14:02:11 (the Structural one). `CE_Admin\sessions`: 3 files, newest 14:01:06.
10. `TIM_CE_CADTOOLS\logs`: 268 files, newest 14:00:15 (ce_struc_structured_20261031.log).

---

## FOR TIM

1. **What you asked:** make sure a test run can never write into your real CE log, settings or the "outbox" folder
   (the folder the Manager collects usage and fault reports from).
2. **Structural, the version you have installed: already safe.** Three fixes from 1 and 3 October already send a test
   run's log, settings and reports to a throw-away folder. Nothing to build there.
3. **Civil and Manager: already safe** for the same four folders.
4. **The leak:** the Civil branch still carries an old copy of Structural from 2 July. When a session runs the
   Structural tests from that branch, they write into your real Structural log. Without PR #1884 they can also
   re-save your real Structural settings file. That is very likely how the 30 Oct 19:47 run touched your settings.
5. **My recommendation:** copy the three October fixes into that old Structural copy on the Civil branch. That is four
   small files, and AutoCAD behaves the same afterwards. Also add one end-of-run check that fails if a test run
   creates or changes any of your real files.
6. **What you need to do:** nothing now. No AutoCAD test is needed, because nothing changes in a drawing.

---

## Technical detail

### 1. Every writer, per line

"Redirects" means the path goes through `LogFolderRedirect` (module), `CeTestFolderRedirect` (CE_SHARED) or, for
Structural settings, `CE_STRUC_SUITE_APPDATA_ROOT`. No writer below uses TEMP/TMP for a real-folder path. TEMP/TMP only
moves the test projects' own scratch folders (built with `Path.GetTempPath()`) and the CDCHECKDWG last-resort fall-back.

#### 1.1 Civil/Manager line, rel-20261102a: Civil (Drainage)

1. **Outbox usage, failures, machines; sessions:** `Modules/Drainage/Services/AdminTelemetryService.cs:112-115` (Root,
   OutboxRoot, SessionsRoot, SessionPath from Store). Writes at :180 (failures), :204 (machines, hashed name), :207
   (deletes an old real-named machine file), :406 (usage, queued) and :457 (sessions\CE_CVL_SUITE.json). Store is
   `Shared/CE_SHARED/Services/CeTelemetryStore.cs:60-71`: Root = `CeTestFolderRedirect.ResolveSubfolder(...TIM_CE_CADTOOLS\CE_Admin, "admin-telemetry")`.
   **Redirects** (CE_LOG_DIR_OVERRIDE).
2. **Settings `TIM_CE_CADTOOLS\CD_Settings.json`:** `Modules/Drainage/Services/SettingsService.cs:51-56`. **Redirects**
   ("settings" subfolder).
3. **Logs `CE_CVL_SUITE\logs` (CE log):** `LoggingService.cs:69-70`. **Redirects.**
4. **Logs `CE_CVL_SUITE\logs` (Serilog structured log):** `PluginInitialization.cs:69-71`. **Redirects.**
5. **Logs `CE_CVL_SUITE\logs` (CDRULES listing):** `Commands/RulesCommand.cs:274-275`. **Redirects.**
6. **Logs `CE_CVL_SUITE\logs` (CDCHECK list):** `Commands/SpineCheckCommand.cs:636-640`. **Redirects.**
7. **Logs `TIM_CE_CADTOOLS\logs\checkdwg`:** `Commands/CheckDwgCommand.cs:133-134`. **Redirects.**
8. **Logs `TIM_CE_CADTOOLS\logs\xcdimport`:** `Commands/LinkCommands.ImportXcivil.Corpus.cs:648-650` and
   `Services/XcivilImportReportService.cs:27-29`. **Redirects.**
9. **Ribbon click log `CE_CVL_SUITE\logs`:** `Shared/CE_SHARED/Services/RibbonBuilder.cs:718-721`. **Redirects**
   ("ribbon-clicks").
10. **Install salt `TIM_CE_CADTOOLS\install_salt.bin`:** `Shared/CE_SHARED/Services/CePiiHash.cs:108-112`. **Redirects.**
11. **CE_SHARED admin root `CE_CADTOOLS\CE_Admin`** (window places and anything through `CeAppDataPaths`):
    `Shared/CE_SHARED/Services/CeAppDataPaths.cs:18-22`. **Redirects.**
12. Other Civil `CE_CVL_SUITE` writers (telemetry\outbox.jsonl `TelemetryQueueService.cs:74-78`, ledger
    `SuggestionLedgerService.cs:77-84`, feedback `FeedbackService.cs:35-39`, repair receipts
    `ExactStoredLinkRepairReceiptService.cs:69-73`, spine rollback `Spine/SpineRollbackStore.cs:40-44`, identity.json
    `InstallIdentityService.cs:51-53`, last_version.txt `WhatsNewVersionGate.cs:28-31`). **All redirect.**

#### 1.2 Civil/Manager line: Manager

1. **Manager outbox, sessions (`CE_CADTOOLS\CE_Admin\outbox`, `\sessions`):** `Modules/Manager/Services/CeAdminStorageService.cs:25-36`
   (GetLocalRoot returns the "ce-admin" test folder when the override is set, before any folder move), :79-80, :111
   (machines), :148 (usage), :153 (failures). **Redirects.**
2. **Plugin outbox drain (`TIM_CE_CADTOOLS\CE_Admin\outbox`, which moves and deletes files):** `CeAdminStorageService.cs:202-207`.
   **Redirects** ("admin-telemetry", the same name the store uses). The switch is off by default.
3. **Crash trace `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`:** `CeAdminTelemetryService.cs:24-28`, written at
   :154-163. **Redirects.**
4. **Logs `CE_SUITE_MANAGER\logs`:** `CommandOutcomeInfoLog.cs:12-14`. **Redirects.**
5. **Settings `CE_SUITE\manager-switches.json`:** `CeOneGlanceStatus.cs:310-319`. **Redirects.**
6. **Settings `Creative Engineering\CE Suite Manager\ce-blocks-settings.xml`:** `CeBlocksSettings.cs:37-41`. **Redirects.**
7. Menu folder `CeSuiteManagerMenuService.cs:135-138` and support folder `CeSupportBundleService.cs:295-298`. **Redirect.**
   `CommandOutcomeSetting.cs:31` only reads Civil's settings, through the same "settings" redirect.
8. The other Manager AppData uses (`CeDiagnosticsService`, `CePluginRegistryService`, `CeUpdateStagingService`,
   `CeFinishUpdatePlanner`, `CePluginInstallerService`) scan or install the AutoCAD bundle folders. They are not
   log/settings/sessions/outbox writers.

#### 1.3 Civil/Manager line: the OLD Structural copy (2 July snapshot), unredirected

`Modules/Structural` on this line has no `LogFolderRedirect.cs` and no `StructuralAppDataPaths.cs`, and
`Structural.Tests` has no `TestLogFolderModuleInit` and no `CeStrucTmpRootSetUp`. Commits e8e9631f, c3d4897a and
26321e13 are all NOT ancestors of rel-20261102a. Writers:

1. **`CE_STRUC_SUITE\logs\ce_struc_suite.log`:** `Modules/Structural/Services/Logger.cs:30-37`. **No override.**
   Reached by tests: `new Logger()` in CsvLoggerTests, CsvLoggerMidnightTests, IdleTimeTrackingTests, SessionMergerTests
   (+1).
2. **`TIM_CE_CADTOOLS\logs\ce_struc_structured_*.log`:** `LoggingService.cs:69-71`. **No override.** Reached by
   `LoggingServiceThroughputTests` (`LoggingService.Initialize()` at :41).
3. **`TIM_CE_CADTOOLS\logs\ce_struc_commands_yyyymmdd.log`:** `CommandHistoryService.cs:72-77`. **No override.** No
   test calls it.
4. **`CE_STRUC_SUITE\Logs\XclmTxt`:** `XclmTxtService.cs:2733`. **No override.**
5. **`CE_STRUC_SUITE\CS_Settings.json`:** `SettingsService.cs:194-199` and `:684-691` **honour
   CE_STRUC_SUITE_APPDATA_ROOT**. But only two fixtures on this line set it. `new SettingsManager()` in four test files
   reaches it with the real folder unless #1884's `RealAppDataIsolationSetup` is merged.
6. **Outbox and sessions:** `AdminTelemetryService.cs:98-101` goes through CE_SHARED `CeTelemetryStore`, so it **does
   follow CE_LOG_DIR_OVERRIDE**. No test on this line writes through it; StructuralTelemetryPrivacyGuardTests only reads
   the source. It would land in the real outbox only if CE_LOG_DIR_OVERRIDE were unset and a test reached it.
7. **Reads only, plus other folders:** `HealthCheckService.cs:79` (reads the log), `SupportBundleService.cs:23-29`
   (reads `CE_STRUC_SUITE\logs` and `outbox\failures`, zips to the Desktop at :34-36), `LegacyToolCommon.cs:257`,
   `ExcelMTextService.cs:1460, 2471`, `NotesBrowserDialog.xaml.cs:165`, `SettingsDialog.xaml.cs:102`, and the
   `TIM_CETOOLS` fallbacks in `ChecklistPanel.xaml.cs:48`, `MainPalette.xaml.cs:1319, 2053`, `NotesPanel.xaml.cs:47`.
   **No override.**

#### 1.4 Civil line: adjacent unredirected AppData writers (outside the four folders; listed, not in scope)

1. `Modules/Drainage/Services/GripRouteService.cs:22-25` with `Save` at :47-52 writes `%APPDATA%\CE_CVL_SUITE\<grip route file>`.
2. `CivilJobTimeSettings.cs:187-189`: the fall-back data folder `%APPDATA%\CE_CVL_SUITE`. `EnsureDataFolders` at :196-197
   creates `Time Logs\users` and `Time Logs\weekly exports` there when no office folder is found.
3. `Commands/LinkCommands.ImportXcivil.Corpus.cs:44-51`: a Debug build (which is what tests use) creates
   `C:\Lisp Files\CE_CVL_SUITE\corpus`, and Release creates `%APPDATA%\CE_CVL_SUITE\corpus`.
4. `PipeAttachmentGlyphTrial.cs:38-40` only reads.

#### 1.5 Structural line, rel-20261026s (installed Structural 1.0.125): every writer redirects

1. **Outbox usage, failures, machines; sessions:** `Modules/Structural/Services/AdminTelemetryService.cs:89-93`
   (Root = `StructuralAppDataPaths.AdminTelemetryRoot()`, `StructuralAppDataPaths.cs:28-31`,
   `ResolveSubfolder(...TIM_CE_CADTOOLS\CE_Admin, "admin-telemetry")`). Writes at :188 (machines), :189 (deletes the
   old real-named file), :214 (failures), :435 (usage, through `StructuralTelemetryWriteQueue.cs:73-77` with the
   redirected outboxRoot passed in) and the session file via :502-507. **Redirects.**
2. **`CE_STRUC_SUITE\logs\ce_struc_suite.log`:** `Logger.cs:30-38`. **Redirects** (`LogFolderRedirect.Resolve`).
3. **`TIM_CE_CADTOOLS\logs\ce_struc_structured_*.log`:** `LoggingService.cs:112-114`. **Redirects.**
4. **`TIM_CE_CADTOOLS\logs\ce_struc_commands_*.log`:** `CommandHistoryService.cs:79-87`. **Redirects.**
5. **`CE_STRUC_SUITE\Logs\XclmTxt`:** `XclmTxtService.cs:2808-2813`. **Redirects.**
6. **Health check log read:** `HealthCheckService.cs:78-80`. **Redirects** (reads only).
7. **`CE_STRUC_SUITE\CS_Settings.json`:** `SettingsService.cs:289-295` and `:962-971` honour
   **CE_STRUC_SUITE_APPDATA_ROOT**. The whole test assembly sets it in `Modules/Structural.Tests/CeStrucTmpRootSetUp.cs`
   (26321e13), which also fails at the end if settings resolved into the real folder.
8. **Install salt, old data folders, recovery snapshots:** `StructuralAppDataPaths.cs:16-52`. **Redirects.**
9. `CommandOutcomeSetting.cs:31` reads only, through the "settings" redirect. `LegacyEnvironmentAuditService.cs:274`
   reads the AutoCAD support folders only.
10. **Test side:** `Modules/Structural.Tests/TestLogFolderModuleInit.cs:30-38` sets CE_LOG_DIR_OVERRIDE before any
    test (e8e9631f). `TestHygieneAppDataGuardTests.cs:149` is a source guard that fails on any new Structural,
    DesignCore or CE_SHARED AppData path that skips a seam (with a named allow-list).
11. **Remaining candidate:** `CuiMenuGeneratorService.cs:1442` (`%LOCALAPPDATA%\CE_STRUC_SUITE` as a CUI folder
    candidate). It is outside the four folders. I did not check whether it is on the guard's allow-list.
12. **`SupportBundleService` does not exist on this line.**

### 2. Smallest change so each one honours the override

1. **Structural line:** none. ALREADY FIXED by e8e9631f (`Modules/Structural/Services/LogFolderRedirect.cs`, Logger.cs:33,
   LoggingService.cs:112, CommandHistoryService.cs:81), c3d4897a (`StructuralAppDataPaths.cs`, AdminTelemetryService.cs:89)
   and 26321e13 (`CeStrucTmpRootSetUp.cs`).
2. **Civil and Manager:** none for the four folders.
3. **Old Structural copy on the Civil line (recommended step 2, B-099):** port the product half of e8e9631f.
   1. Add `Modules/Structural/Services/LogFolderRedirect.cs` (copy from rel-20261026s).
   2. Wrap the folder in `LogFolderRedirect.Resolve(...)` at `Logger.cs:33`, `LoggingService.cs:69`,
      `CommandHistoryService.cs:73` and `XclmTxtService.cs:2733`. Optionally do the same for the two read paths in
      `SupportBundleService.cs:23-29`.
   3. Add `Modules/Structural.Tests/TestLogFolderModuleInit.cs` from rel-20261026s.
   4. Merge #1884 (it adds the CE_STRUC_SUITE_APPDATA_ROOT set-up for that copy's settings).
   5. In AutoCAD the variable is never set, so the paths are byte-for-byte as now. Like BUG-348 item 6, this needs no
      Settings switch: it changes no drafting behaviour and only acts when a test process sets the variable. Say so in
      the PR so the R-00/R-27 reviewer sees the reasoning.
4. **Simpler alternative (not recommended on its own):** a brief rule that Structural tests are run only from the
   Structural line. It relies on every future session reading the rule.
5. **Out of scope, park as an idea if wanted:** route GripRouteService, the CivilJobTimeSettings fall-back and the
   corpus folder (section 1.4) through `LogFolderRedirect.ResolveSubfolder`.

### 3. Extending the guard so it FAILS when a test run creates or changes a real file

#1884's guards watch one settings file per project. I recommend replacing the three copied `Reading`/`Compare` classes
with ONE test-only source file, linked into Drainage.Tests, Manager.Tests and Structural.Tests (Compile Include with a
Link; not CE_SHARED, which must not change). The changes:

1. **When it runs:** baseline in a `[ModuleInitializer]`. Check in the assembly-level `[SetUpFixture]`
   `[OneTimeTearDown]`, not a "Zz" fixture: NUnit name order is not a promise, and a `--filter` run skips the Zz test
   but still runs the set-up fixture.
2. **What it records:** existence, length and last-write time only, never contents. Files watched (under `%APPDATA%`
   unless marked):
   1. `TIM_CE_CADTOOLS\CD_Settings.json`
   2. `CE_STRUC_SUITE\CS_Settings.json`
   3. `CE_SUITE\manager-switches.json`
   4. `Creative Engineering\CE Suite Manager\ce-blocks-settings.xml`
   5. `TIM_CE_CADTOOLS\install_salt.bin`
   6. `TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json` and `...\CE_STRUC_SUITE.json`
   7. Every file in `TIM_CE_CADTOOLS\CE_Admin\outbox\machines\`
   8. Today's date folder only in `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\yyyy-MM-dd\` and `...\failures\yyyy-MM-dd\`
      (count plus newest name). The full trees hold 25,795 and 1,980 files, too many to list each run.
   9. `CE_STRUC_SUITE\logs\ce_struc_suite.log`
   10. `TIM_CE_CADTOOLS\logs\ce_struc_structured_<today>.log` and `ce_struc_commands_<today>.log`
   11. Today's files in `CE_CVL_SUITE\logs\`
   12. `CE_SUITE_MANAGER\logs\` (today)
   13. `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`
   14. `CE_CADTOOLS\CE_Admin\` top level (Manager's own store)
3. **When to fail:** any watched file created, deleted, longer, or with a new last-write time fails the run, naming
   the file.
4. **The AutoCAD exception, wider than #1884's:** #1884 goes Inconclusive only if AutoCAD STARTED during the run. An
   AutoCAD already open writes these logs and the usage outbox every few seconds; today the real log moved at 14:09
   with acad.exe open since 14:01. The guard must go Inconclusive whenever any `acad` or `accoreconsole` process is
   alive at the end, or started during the run. Otherwise every robot-hour run is a false failure. The settings files
   can keep #1884's narrower rule, because AutoCAD saves them only at start and on Save.
5. **Positive control (the switch-off style proof):** a unit test points the watch at a temporary folder, takes a
   baseline, writes one file there, and asserts the watch reports CREATED. A second write must report "changed". It
   never touches the real folders.
6. **Proof name:** `ZzRealFolderGuard_RunLeavesRealFilesUntouched` (one per project), with control
   `RealFolderWatch_ReportsAPlantedFile`.

### 4. Risks

1. **CE_SHARED:** no change needed or proposed. On the Civil line, Civil and Manager build the same
   `Shared/CE_SHARED` folder, so they stay byte-identical. The Structural line carries its own 13-file CE_SHARED, a
   different and older copy. That is a separate existing load-order matter and this work must not touch it.
2. **Manager:** the plugin-outbox drain MOVES and DELETES files (`CeAdminStorageService.cs:202-207`, :295). It is
   redirected and off by default, but a Manager test that turned the drain on with the override unset would empty
   Tim's real outbox. Keep the "never run Manager tests" rule until a guarded run has proved the module initializer.
3. **Porting into the old Structural copy** edits Structural product files on the Civil line. If that copy ever
   ships, the change is invisible in AutoCAD (variable unset), but it needs the same review as any product change.
4. **A machine-wide CE_LOG_DIR_OVERRIDE** set by hand in Windows would silently send a live AutoCAD's logs and outbox
   to that folder. This has been true since 3 Oct for Civil, Manager and Structural; it is not new.
5. **Guard false alarms:** with AutoCAD open the guard can only report Inconclusive. On a robot-heavy PC it proves
   most while AutoCAD is closed, so a nightly guarded run should be timed for when the robot is idle.

### Housekeeping

1. No worktree was created: the code was read with `git grep` and `git show` against the remote refs.
2. Scratch: `C:\CE_WORK\scratch\y1\list_real.ps1` (the metadata listing), removed at the end of the job.
3. Not edited: BUG_CARPARK.md, DESK_LOG.md, any repo file, any real settings or log file.
