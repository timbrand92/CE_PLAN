# BUGFIX w1166 report, 3 Nov 2026 (Melbourne): BUG-1166 office-folder lookup

**Build number:** B-176 (provisional). **Draft PR:** #1998, base `claude/rel-20261102a`, branch `w1166/bug-1166-office-folder`, one commit `6f5a80d9`.

## FOR TIM

1. **First, a flag you asked for:** some real files in your AutoCAD data folders changed while my tests ran (listed in section 5). I do not think my run wrote them. They are plugin telemetry and logs from a live AutoCAD session (including the Structural and Manager plugins, which my tests never load), and a CDCHECK result file at 6:08 am. My tests wrote their logs into my own scratch folder (14 files there). I cannot prove it from the files alone, so treat it as "probably another job's AutoCAD run, not proven".
2. **What a drafter sees differently:** on a PC where the office folders came in as "Add shortcut to My files" (they sit under "OneDrive - ..."), CDFEEDBACK now reaches the office folder (no more "saved on this PC" every time), CDNEWDWG finds the templates, CDWT shows the tank pictures, and job time finds its data folder. On a PC where the folders are in the plain Users\Creative Engineering place, nothing changes.
3. **A folder you typed in Settings that exists is never moved.** Only a folder that is missing on this PC but present on OneDrive is switched.
4. **Switch:** `linking.officeFolderFollowsOneDrive`, on by default. Off gives the old behaviour exactly.
5. **My own mistakes:** (a) I wrote the new shared file through the shell and it mangled the backslashes; the first test build failed on it; fixed and rebuilt (a wasted build, about 3 minutes). (b) I first listed your AutoSave folder including client drawing names into a scratch file; the report does not include those names.
6. **NOT proven:** nobody has opened this in AutoCAD. Not marked fixed. I have not seen Max's real OneDrive layout (the carpark says to look before 9 Nov). The Manager and CE Blocks are not changed (see section 3).
7. **Robot case that would prove it (not built or run):** `N47_office_folder_onedrive`, in the style of N31_dp_time. On a test profile whose Users\Creative Engineering folders do not exist but `%OneDriveCommercial%\Creative Engineering - Drafting\Standard Details\Civil` does, it starts AutoCAD, types `CDWT` and checks the command line does NOT print the old tank questions and the CE log holds the line `[BUG-1166] options.standardDetailsCivilFolder was not on this PC; using the office folder on OneDrive`. Switch-off control: set `linking.officeFolderFollowsOneDrive` to false before launch (settings are read at start), repeat, and check the log line is absent and the old questions appear.

---

## 1. Fault confirmed on `origin/claude/rel-20261102a` (3fbb9da5), before building

1. Manager: `Modules/Manager/Services/CePluginInstallerService.cs` `GetItAdminPath` (lines 56-78) tries OneDriveCommercial first.
2. Civil, profile only: `FeedbackService.cs:63`, `CivilJobTimeSettings.cs:138` and `:170-172`, `UserSettings.cs:1888` and `:1913`, `BlockService.cs:97`.
3. Not already fixed: no OneDriveCommercial use anywhere in Civil.

## 2. Change (Civil only, one commit)

1. `Shared/CE.OfficeFolders/OfficeFolderLookup.cs`: the one place (plain source file, linked into Civil by one line in `CE_CVL_SUITE.csproj`). CE_SHARED is untouched (separate project, no file in it changed).
2. `Services/OfficeFolderLocator.cs` (Civil adaptor and switch read); test runs never read the real %OneDriveCommercial%.
3. Callers: `FeedbackService`, `CivilJobTimeSettings` (IT Admin root, data-folder detection), `BlockService` (StructPlus), and `SettingsService.MoveOfficeFoldersOntoOneDrive` at load (Standard Details, Drawing Templates, saved job-time folder).
4. `UserSettings.cs`: switch, doc says "Default: on."
5. `REGRESSION_LOG.md` entry; test file `Bug1166OfficeFolderOrderTests` (14 tests): order, found under OneDrive, parent form, OneDrive beats plain path, nothing exists gives the profile path, switch off equals old, settings move and keep rules, default on through BOTH `DeserializeSettings` and `DeserializeSettingsTolerant`, source guards.
6. Not read-write touching anything else: no write, command, regen, view or system variable added (R-27, BUG-861 rule).

## 3. Not done, and why

1. Manager still has its own copy of the order; it can link the shared file in a Manager PR (one csproj line). Batch said Civil only, and Manager tests must not be run.
2. CE Blocks (`CeBlocksSettings.cs:33`, `CeBlocksPaletteService.cs`) and its wording are Manager code: untouched.
3. `FeedbackDialog.xaml:143` shows a fixed path line: a window change, Codex-owned, not touched (one small window change would be needed; no brief written because the code fix stands without it).
4. `Creative Engineering - Drafting` also exists in Structural (`CeInstallPaths.cs`): out of scope.

## 4. Build and test

1. Net10 focused run, one test project, filter on Bug1166, Bug1167, Bug1168, C78NewSwitchDefaults, FeedbackService, CivilJobTime: **57 passed, 0 failed, 57 total** (count not 0, AutoCAD 2027 on PATH).
2. Net48 build of the test project (compiles Civil net48): 0 errors, 297 warnings.
3. Every command had `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, one project, with `--filter`; slot count was 0 before each. Not run: the full suite, Manager tests.
4. Isolation: TEMP, TMP, CE_LOG_DIR_OVERRIDE set to `C:\CE_WORK\scratch\w1166\...`, echoed before each run.

## 5. Real-folder listings (rule 1)

Before: 32,993 files outside AutoSaveBackups (full before-listing saved at `C:\CE_WORK\scratch\w1166\appdata_before.csv`, then removed with the scratch folder; client drawing names are in AutoSaveBackups, so that folder is excluded here). After: 32,999. Files changed or new, 18, all names listed:

1. `TIM_CE_CADTOOLS\CD_RecentValues.json` (6:07:20)
2. `TIM_CE_CADTOOLS\CE_Admin\outbox\machines\` CVL and STRUC files (2)
3. `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\` four usage files (UTC 19:06 to 19:08, that is 6:06 to 6:08 am Melbourne)
4. `TIM_CE_CADTOOLS\CE_Admin\sessions\` CVL and STRUC (2)
5. `TIM_CE_CADTOOLS\logs\ce_struc_structured_20261103.log`
6. `CE_STRUC_SUITE\logs\ce_struc_suite.log` and `RuntimeDiagnostics\runtime_snapshot.json`
7. `CE_CVL_SUITE\ledger\suggestions.jsonl`, `logs\cdcheck-...-20261102-190847.txt` (6:08:47), `logs\ce_cvl_structured_20261103.log`, `logs\CE_CVL_SUITE.log`
8. `CE_CADTOOLS\CE_Admin\outbox\machines\` Manager file and `sessions\CE_SUITE_MANAGER.json`

Why I think these are not mine: they need AutoCAD with all three plugins loaded (a CDCHECK result, Structural and Manager sessions), which a Drainage unit-test run does not do, and the isolation folder received the test logs. Overlap in time with my run is real (6:06 to 6:09), so "not proven".

## 6. Cleanup

Worktree `C:\CE_WORK\build\w1166` cleaned with `git clean -fdXq`, removed, and scratch removed after this report was pushed. The branch stays (D6: nothing deleted).
