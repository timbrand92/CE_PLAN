# B-099 step 2 (y2): Structural test runs on the Civil line no longer write the real CE folders

Job: CE 01 Build, key y2, build number B-099, Tim item 153 ("6yes"). Written Sat 31 Oct 2026, about 15:00 Melbourne.
PR: **#1922** (draft) against `claude/rel-20261102a`, branch `claude/b099-struc-test-redirect`, commit 7a3238a7.

## FOR TIM

1. **Done:** the old Structural copy on the Civil branch now sends its test-run log files to a throw-away folder, the same as your installed Structural already does. In AutoCAD nothing changes: the logs go exactly where they went before.
2. **New safety check:** every test run now compares your real CE files (settings, usage and fault reports, logs, session files) before and after. If a run creates or changes one, it says so and names the file. If AutoCAD is open at the time it says "inconclusive" instead, because an open AutoCAD writes those files itself every few seconds.
3. **Proof it works:** with AutoCAD closed I ran the Structural tests that used to write your real log (41 tests, all passed). I listed all 33,287 files in your CE folders before and after: 0 differences. A planted test file was also reported correctly.
4. **One thing to know:** a failed check is printed loudly with the file name, but the overall test command still ends "OK". So the check is read from the output, not from pass or fail. I noted this in the log.
5. **I added a bit more than asked:** four more Structural log writers had the same hole (the command log, the Excel text log, the health check read and the support bundle read). Same tiny change, no AutoCAD difference.
6. **What you need to do:** nothing. No AutoCAD test is needed. The PR is a draft; CE 02 and an Opus review should look at it before it merges.

---

## ANSWER FIRST (technical)

1. **PR number:** #1922 (draft, base `claude/rel-20261102a`).
2. **What a drafter sees differently:** nothing. With `CE_LOG_DIR_OVERRIDE` unset (AutoCAD, always) every path is byte-for-byte as before. No Settings switch (task and BUG-348 item 6 reasoning: a test-only redirect, no drafting behaviour).
3. **Fault re-check first:** installed Structural line `origin/claude/rel-20261026s` (204dfad2): already safe, `LogFolderRedirect` is used in Logger.cs:34, LoggingService.cs:112, CommandHistoryService.cs:82, XclmTxtService.cs:2809, ExcelMTextService.cs:2775, HealthCheckService.cs:78 (commits e8e9631f, c3d4897a, 26321e13). On `origin/claude/rel-20261102a` (3fbb9da5): `git grep LogFolderRedirect -- Modules/Structural` returned nothing, so the fault was there and is now fixed in the PR.
4. **Clashes seen:** #1884 (B-062, draft, same base) touches `Modules/Structural.Tests/TestIsolation/*`, the two `ZzRealSettingsFileGuard.cs` files and REGRESSION_LOG.md. It does not touch any file I edited, except REGRESSION_LOG.md (keep both on conflict). No open PR touches Logger.cs, LoggingService.cs, CommandHistoryService.cs or XclmTxtService.cs. I did not build on #1884's branch because it covers none of these files. #1884 stays needed for `CS_Settings.json`; this PR does not replace it.

## Mistakes of my own first

1. **First guard design crashed the test host.** I used an NUnit assembly action and threw Inconclusive from its AfterTest; the host died ("Test Run Aborted") with AutoCAD open. Found in the first run, replaced by a global SetUpFixture. No real file was touched.
2. **A second version "failed" silently in the summary.** I only noticed from the output text that the teardown failure never changes the exit code (exit 0). That limit is real and is in the REGRESSION_LOG entry; I did not find a way to make this adapter fail the run from a suite teardown.
3. **Shell slips, no cost:** `sed` ate backslashes in a csproj edit and in my run script (known trap, memory `bash-heredoc-mangles-backslashes`); reverted and redone with PowerShell file edits. The first `dotnet` start failed because the tool PATH lacks dotnet.
4. **My first "after" listing showed real files changed** (the Structural log and structured log moved at 14:52). That was AutoCAD (acad.exe started 14:37, gone by 14:52:56), not my tests: my scratch override folder held 370 KB and 520 KB of the logs my runs wrote, and my test processes had all ended before 14:51. I did not rely on that: I re-ran with no AutoCAD process at all and got 0 differences.

## What is NOT proven

1. **No AutoCAD look.** Nothing changes in a drawing; none needed.
2. **No "before the fix" control run.** I did not run the old code to watch it write the real log, because that would write Tim's real files. The proof is the guarded Clean run on the fixed code plus the source guard (`EveryStructuralFileThatBuildsALogFolderUnderAppData_GoesThroughTheSeam`), and the planted-file control for the watch itself.
3. **Manager.Tests never run** (standing rule), only compiled with the linked watch file. The watch's behaviour in that project is unverified; the file is identical and the same global fixture pattern ran in Structural.Tests and Drainage.Tests.
4. **Drainage.Tests: only 4 tests run** (control and proof). Not the full suite, by instruction. Full-suite runs with the watch are untested here.
5. **net48 test execution:** compiled only (Structural and Structural.Tests, 0 errors); not run.
6. **The Inconclusive path** was seen (AutoCAD open) in three runs and the Clean path once (AutoCAD closed). The Changed path was seen only against a scratch folder by a temporary hook that is not in the commit.
7. **Other writers outside the four folders** named in step 1 section 1.4 (GripRouteService, CivilJobTimeSettings fall-back, the corpus folder) are not redirected and not watched. Park as an idea if wanted.

## Check for CE 02: how to prove a test run wrote nothing into the real folders

1. **Close AutoCAD** (the watch cannot decide while any `acad` or `accoreconsole` runs).
2. List names, sizes and last-write times (no contents) of `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and `logs`), `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_CADTOOLS` (including `CE_Admin`), `%APPDATA%\CE_SUITE` and `%LOCALAPPDATA%\CE_SUITE_MANAGER`, before and after the run, and diff them. The scripts I used were `list_real.ps1` style (Get-ChildItem -Recurse -File, name|length|LastWriteTime), kept in scratch and removed.
3. Run one project with a filter that includes `ZzRealFolderGuard`, for example `dotnet test Modules\Structural.Tests\CE_STRUC_SUITE.Tests.csproj -f net10.0-windows -p:SkipDevBundle=true -nr:false --disable-build-servers --filter "FullyQualifiedName~ZzRealFolderGuard|FullyQualifiedName~<your classes>"`, with AutoCAD 2027 on PATH.
4. Read the output. Right = no "TearDown failed for test fixture RealFolderGuardSetup" and `ZzRealFolderGuard_RunLeavesRealFilesUntouched` not skipped. A skip or an "AutoCAD was running" teardown line means inconclusive. A "this test run changed the real CE files" line names the file.
5. Print and check `CE_LOG_DIR_OVERRIDE`, `CE_STRUC_SUITE_APPDATA_ROOT`, `TEMP` and `TMP` are scratch folders before every run (the guard tests `TheWholeTestRunHasATemporaryLogFolder_NeverUnderTheRealAppData` fail if the log override points into the real %APPDATA%).

## Technical detail

1. **Product files (Modules/Structural/Services):** new `LogFolderRedirect.cs` (copied from rel-20261026s); `Logger.cs` (ce_struc_suite.log), `LoggingService.cs` (new `ResolveLogDir()` used by `Initialize`), `CommandHistoryService.cs` (`BuildLogPath` now `internal`), `XclmTxtService.cs`, `StructuralCommandLogger.cs` (override wins, otherwise the settings-folder path as before), `ExcelMTextService.cs`, `HealthCheckService.cs`, `SupportBundleService.cs` (read paths).
2. **Test files:** `Modules/Structural.Tests/TestLogFolderModuleInit.cs` and `TestLogFolderGuardTests.cs` (copied from the Structural line; the DesignCore.Tests line of the init-file check removed because that project's file does not exist on this line); `Modules/TestSupport/RealFolderWatch.cs` linked from `CE_CVL_SUITE.Tests.csproj`, `CE_SUITE_MANAGER.Tests.csproj` and `CE_STRUC_SUITE.Tests.csproj`.
3. **Watched (names, sizes, last-write only):** CD_Settings.json, CS_Settings.json, manager-switches.json, ce-blocks-settings.xml, install_salt.bin, both session files, every file in outbox\machines, today's `outbox\usage` and `outbox\failures` day folders (both admin roots), ce_struc_suite.log, XclmTxt folder, today's files in the TIM_CE_CADTOOLS, CE_CVL_SUITE and CE_SUITE_MANAGER log folders, crash_trace.log and the top level of `CE_CADTOOLS\CE_Admin`.
4. **Why a SetUpFixture and not an assembly action:** an exception from an action's AfterTest kills the test host; the fixture reports through NUnit. A global fixture runs next to Drainage.Tests' existing global `SettingsIsolationSetup` (checked with a temporary probe test, removed).
5. **Runs:** all net10, one `.csproj` per command with `--filter`, below-normal priority, scratch folders under `C:\CE_WORK\scratch\y2` printed before each run (Manager tests never run): Structural.Tests 5, 23, 41 passed (last run with AutoCAD closed: guard Clean); Drainage.Tests 4 passed; Manager.Tests build 0 errors; Structural net48 0 errors; Structural.Tests net48 0 errors.
6. **Not run:** the full suites (instructed), a Release net10 build of the whole solution.

## Real-folder listings (names, sizes, last-write; no contents)

**Before the first dotnet test (14:39, AutoCAD open since 14:37):**
1. `%APPDATA%\TIM_CE_CADTOOLS`: 29,446 files, newest 14:39:19.
2. `%APPDATA%\CE_STRUC_SUITE`: 2,500 files, newest 14:37:41 (ce_struc_suite.log).
3. `%APPDATA%\CE_CVL_SUITE`: 301 files, newest 14:39:22.
4. `%APPDATA%\CE_CADTOOLS`: 1,022 files, newest 14:39:23.
5. `%LOCALAPPDATA%\CE_SUITE_MANAGER`: 2 files, newest 14:37:39 (crash_trace.log).
6. `CD_Settings.json` 15,270 bytes, 4 Oct 08:22:30. `CS_Settings.json` 35,613 bytes, 30 Oct 19:54:14. `ce_struc_suite.log` 3,706,176 bytes, 31 Oct 14:37:41. `CE_SUITE\manager-switches.json` absent.

**After my last test of the first batch (14:52), AutoCAD closed in between:** 33,287 files (was 33,271). 34 paths differed, all of the kinds an open AutoCAD writes (usage outbox 15, sessions, machines, logs). `CD_Settings.json`, `CS_Settings.json` and `manager-switches.json` unchanged. The Structural log and structured log moved between 14:37 and 14:52:03, with AutoCAD alive (see mistake 4); I could not attribute those by listing alone.

**Clean run (AutoCAD closed, none running before or after):** before 33,287 files, after 33,287 files, **0 differences**; 41 tests passed, `ZzRealFolderGuard_RunLeavesRealFilesUntouched` ran and passed, no teardown message. `CS_Settings.json` still 35,613 bytes, 30 Oct 19:54:14; `CD_Settings.json` still 4 Oct 08:22:30.

## Housekeeping

1. Worktree `C:\CE_WORK\build\y2` and scratch `C:\CE_WORK\scratch\y2` removed at the end (see the last line of the job summary for any exception). The worktree held a 0-byte placeholder `CE_TRANSFORM_2027.arx` under an ignored `bin` folder, removed with it.
2. Not edited: BUG_CARPARK.md, DESK_LOG.md, any real settings or log file, CE_SHARED.
3. Not pushed to #1884's branch; nothing closed, retargeted or merged.
