# Bug hunt: Manager, installer, admin, update route and settings, 19 Oct 2026

Helper: Team usage governor, desk plan/03, headless job "HUNT: Manager, installer, admin, update route and settings transfer" (Opus, read-only). Written Mon 19 Oct 2026 about 16:10 Melbourne. The file name keeps the date the job was planned (12 Oct).

**This was a read-only audit.** Nothing was built, installed, run or opened in AutoCAD. Draft IDs only (HUNT-MI-xx). **The controller files the BUG numbers.**

**What was read**
1. **Civil and Manager:** the installed line, `origin/claude/rel-20261019a` at `21462f9c` (Civil 3.0.56 / Manager 1.1.56). This is the newest release branch.
2. **Structural:** `origin/claude/rel-20261017s` at `9a8e5d4e` (Structural 1.0.118, which contains 1.0.115).
3. **Never master.** Both lines were read in private worktrees under `C:\ce-hunt\`, removed at the end.
4. **Read first:** `ENGINEERING_RULEBOOK.md`, `BUG_CARPARK.md`, the 9 Oct Manager hunt (`HUNT_MANAGER_2026-10-09.md`, filed as BUG-476 to 487), AUDIT 01 (BUG-488 to 494), the second source audit (BUG-425, S2-001 to S2-025) and HUNT3_CROSS. Nothing below repeats those unless it says how a fix left a gap.
5. **Method:** four Opus readers split the work: update route and installer, admin and privacy, settings, and ribbon and start-up. I re-read every HIGH finding myself, plus the ribbon, admin and Reset Defaults ones. Those are marked "re-checked".

---

## Read this first (for Tim): the 10 worst

1. **An update got ready by Manager can never be installed.** The CE installer checks the update folder for exactly three signed files. Manager always leaves a fourth, its own receipt, in that folder. So the installer stops every time with "must contain exactly its record, signature and defined summary". (HUNT-MI-01, HIGH, re-checked.)
2. **The installer also refuses Civil 3.0.56 itself, and Manager on any PC that has Civil 3.0.56.** Civil 3.0.56 ships the 2027 pipe-object file (a `.dbx`). The installer only knows `.dll` and `.arx` files, so it blocks with "Unsupported command-owner module type". (HUNT-MI-02, HIGH, re-checked.)
3. **Civil quietly puts a maximum pipe velocity of 3.0 m/s (or less) back to 6.0 at every AutoCAD start.** An engineer who sets 3.0 for a council job gets checks run at 6.0, so a pipe at 4 m/s gets no warning. The same kind of rule raises SC and CJ joint label heights under 200 mm to 250. (HUNT-MI-03, HIGH, re-checked.)
4. **Structural "Reset Defaults" wipes every Structural setting in one click.** It sits beside Cancel and asks no question. It also wipes the lists that have no page: SBEAM favourites, wall types, mark prefixes, schedule rules. It then re-imports years-old values from the old registry. (HUNT-MI-04, HIGH, re-checked.)
5. **If Civil cannot read its settings file at start-up, the next ordinary save writes standard values over it.** Drawing one pipe is enough. A locked file is the realistic trigger: a second AutoCAD or a virus scan. Nothing on screen warns the engineer. (HUNT-MI-05, HIGH, the trigger is "I think".)
6. **Clicking a CE ribbon button while another command is waiting types the CE command name into that command.** For example, at TEXT's "Enter text:" prompt, clicking Pipe places the word "CD" in the drawing. AutoCAD's own buttons cancel first; CE's do not. (HUNT-MI-06, MEDIUM, re-checked.)
7. **A colleague can still take the administrator role from Tim.** This happens if Tim's first "Set up CE administrator" was saved on his PC only (office folder unreachable at that moment). His button then disappears and "run it again" is impossible. The first colleague to click Yes writes the shared list. (HUNT-MI-07, MEDIUM-HIGH, re-checked.)
8. **"Reset Civil" on the CEMANAGER Settings page also resets values that page does not show.** These include the engineer's own LPD note, the templates folder and the confirmed pipe-to-pit clearances. Apply then saves them. (HUNT-MI-08, MEDIUM-HIGH.)
9. **Civil writes its main settings file straight over itself.** There is no safe temporary copy, unlike Manager, Structural and Civil's own remembered-values file. A power cut or crash mid-save leaves a broken file, and HUNT-MI-05 then replaces it with standard values. (HUNT-MI-09, MEDIUM, re-checked.)
10. **The Civil and Manager pair can still be split by an update.** If Civil's update fails to get ready, Manager's update is got ready anyway. The status line never looks at Manager at all. (HUNT-MI-10, MEDIUM.)

**What it means for colleague install day:** items 1 and 2 together mean the Manager update route cannot finish anything today. Colleagues must be installed and updated by the deploy chat's route until both are fixed. Items 3, 5, 8 and 9 can change or lose a colleague's settings without a word.

---

## Update route and installer

1. **HUNT-MI-01 (HIGH, CONFIRMED, re-checked). The installer refuses every update that Manager gets ready.**
   - **Where:** `Modules/Manager/Services/CeUpdateStagingService.cs:104` (receipt name `ce-update-stage.json`), `:349-351` and `:399` (receipt, `ce-release.json`, `.sig` and `-summary.json` all written into one folder), `:425` (that folder moved into place). `Installer/SafeBundleInstaller.cs:240-249` calls the release check with no package root. `Shared/CE.Release/OfficialReleaseGate.cs:732-735` then uses the receipt's folder, and `:1943-1957` demands exactly three files.
   - **Trigger:** CEMANAGER > Get update ready (or the start-up background staging), close AutoCAD, run `CE_CVL_SUITE_Installer --activate-staged --stage-record=<that ce-update-stage.json>`.
   - **Wrong:** exit code 20, Blocked: "The signed package root must contain exactly its record, signature and defined summary." **Right:** the staged bundle installs.
   - **Fix idea:** keep the receipt one folder up from the three signed files, or give the gate an explicit package root that holds only those three. Do not loosen the shared gate without a decision.
   - **Unit test RED:** yes, and one already exists. `Installer.Tests/InstallerApplicationTests.cs:22-37` builds exactly this layout (receipt beside the three files in `staging\`), and `:49` `Run_ActivateStaged_InstallsAndWritesCompletedResultRecord` expects Installed. It should be red now. It also expects channel "Tim Test", so it is worth checking whether anyone runs it (see BUG-247). Not run here, because it is Tim's work hours.

2. **HUNT-MI-02 (HIGH, CONFIRMED, re-checked). The installer refuses Civil 3.0.56, and refuses Manager on a PC with Civil 3.0.56, because of the `.dbx` pipe-object file.**
   - **Where:** `Installer/SafeBundleInstaller.cs:509-543` (`ReadManifestOwner` accepts `.dll` and `.arx`, everything else throws). `Installer/PackageContents.xml:208` lists `./Contents/Win64/Modern/CE_CVL_OBJECTS_2027.dbx`. `SafeBundleInstaller.cs:446-459` runs the same read over every other installed CE bundle, so a Manager update trips on the installed Civil too.
   - **Trigger:** activate any staged Civil 3.0.56, or a Manager stage on a PC that already has Civil 3.0.56.
   - **Wrong:** Blocked, "Command ownership could not be proved: Unsupported command-owner module type in PackageContents.xml: ./Contents/Win64/Modern/CE_CVL_OBJECTS_2027.dbx". **Right:** a `.dbx` with no commands is accepted like a command-free `.arx`. The release gate itself already allows it (`OfficialReleaseGate.cs:1419-1429`).
   - **Fix idea:** treat `.dbx` the same as `.arx` (allowed when its ComponentEntry declares no Command).
   - **Unit test RED:** yes, a `SafeBundleInstallerTests` case with a `.dbx` ComponentEntry.

3. **HUNT-MI-10 (MEDIUM, CONFIRMED). The Civil and Manager pair can still be split: a failed Civil stage is ignored, and the status line never looks at Manager.**
   - **Where:** `Modules/Manager/Services/CeApprovedReleaseService.cs:602-606`: `install(available, plugin); stagedIds.Add(...)` throws the result away. Yet the comment at `:532-533` says "if Civil's install fails, Manager is never run" (true only on the roll-back path, `:584-585`). The pair warning at `:608` then stays quiet, because Civil was added to the staged list. Separately, `CeReleaseStatusService.cs:224` and `PluginManagerWindow.xaml.cs:628` use `CePluginRegistryService.DiscoverAll()`, which leaves Manager out (`CePluginRegistryService.cs:52-54`). Only the background stager adds Manager (`CeApprovedReleaseService.cs:503`).
   - **Trigger:** approve a matching Civil and Manager pair. Civil's stage fails ("candidate bytes changed" while OneDrive is still syncing, long path, disk full). Or approve a Manager-only build.
   - **Wrong:** Manager is staged alone with no warning. With a Manager-only approval the ribbon says "CE is current.", and Get update ready on Civil prepares Civil only. **Right:** skip Manager and say so when Civil fails; show Manager on the status line.
   - **Overlap:** BUG-425 S2-002 (the channel cannot stage Manager) and S2-016 (failure not recorded). This is the ignored-result route those did not name, and it contradicts the code's own comment.
   - **Fix idea:** check `result.Outcome` and skip the partner on failure; add `DiscoverManager()` to the status list.
   - **Unit test RED:** yes. `StageManagedUpdates` with an install delegate that returns Fail for CE_CVL_SUITE: assert Manager's install is never called.

4. **HUNT-MI-11 (MEDIUM, CONFIRMED). One error in a normal update step silently turns off the status dot and report upload for the whole session.**
   - **Where:** `Modules/Manager/Plugin.cs:140-161`. Staging, then `CeReleaseStatusMonitor.Start()`, then `TryUploadOutbox` all share one try block, in that order. `CeApprovedReleaseService.cs:604` calls `install(...)` with no try, unlike the roll-back branch at `:584-585`.
   - **Trigger:** any file-copy or hash exception during normal staging (for example while OneDrive is still bringing the office copy down).
   - **Wrong:** the status dot stays "Checking CE status…" all session, and waiting reports are not sent. If Manager loaded before Civil and Structural, the unified ribbon is never rebuilt either, because the monitor's change event is the only later trigger. **Right:** each step runs on its own.
   - **Fix idea:** separate try blocks; wrap `:604` the way `:584` is wrapped; start the monitor before staging.
   - **Unit test RED:** yes. `StageManagedUpdates` with a throwing install delegate should return notes, not throw.

5. **HUNT-MI-12 (MEDIUM, PLAUSIBLE). The installer will install any old stage left on disk: there is no check against the current approval and no downgrade guard.**
   - **Where:** `Installer/SafeBundleInstaller.cs:133-329` checks the signature, file fingerprints and command ownership only. It never reads `approved.json` or compares versions. Old stages are never removed (S2-017).
   - **Trigger:** someone points the installer at a 3.0.55 stage, or at one the office has since rolled back.
   - **Wrong:** a superseded build is installed. **Right:** refuse anything that is not the current approved identity for this PC, or at least warn on an older version.
   - **Fix idea:** pass the expected content fingerprint from the current approval.
   - **Unit test RED:** yes, `SafeBundleInstallerTests`.

6. **HUNT-MI-13 (LOW-MEDIUM, CONFIRMED). Approving the same version twice throws away the real "go back to" version.**
   - **Where:** `CeApprovedReleaseService.cs:100` and `:119-128` copy the Rollback fields from the previous record even when that record is the same version.
   - **Trigger:** canary-approve 3.0.57, then Approve Release (not Promote to All) for 3.0.57.
   - **Wrong:** the roll-back version becomes 3.0.57, so 3.0.56 is lost as the way back. **Right:** keep the earlier record's Rollback fields when the version is unchanged. (Roll Back is behind a switch now, which lowers the severity.)
   - **Unit test RED:** yes, after a small test seam on `TryApprove`.

7. **HUNT-MI-14 (LOW, CONFIRMED). The admin dashboard's "devices behind" is wrong for Structural.**
   - **Where:** Structural `Modules/Structural/Services/AdminTelemetryService.cs:165-180` sends "v1.0.118" (`VersionInfoService.cs:90` adds the "v"). Manager `CeAdminAnalyticsService.cs:46-48` and `:156-158` compare it with `IsNewerVersion`, which falls back to text order.
   - **Trigger:** approve Structural 1.0.119.
   - **Wrong:** "v1.0.118" sorts above "1.0.119" as text, so 0 devices behind. A stale "1.0.1.0" install record (BUG-575) always counts as behind. **Right:** compare the numbers.
   - **Fix idea:** strip a leading "v" and any "+…" before comparing.
   - **Unit test RED:** yes.

8. **HUNT-MI-15 (LOW, CONFIRMED). "Restart AutoCAD to use 3.0.100" will not appear when going from 3.0.99 to 3.0.100.**
   - **Where:** `CeOneGlanceStatus.cs:134-135` compares the installed version with the running DLL's version, which carries "+commit" (`PluginManagerWindowViewModel.cs:308-311`). That falls back to text order (the known S2-018 fallback; this is a concrete trigger).
   - **Fix idea:** strip "+…" inside `CompareVersions`. The page is behind its switch.
   - **Unit test RED:** yes. `CompareVersions("3.0.100", "3.0.99+abc") > 0`.

9. **HUNT-MI-16 (LOW, PLAUSIBLE). Read-only synced files can leave old folders behind and stop "Disable/Enable on Restart" working.**
   - **Where:** `CeUpdateStagingService.cs:607` and `:784-798` copy keeping the read-only flag. `SafeBundleInstaller.cs:328` and `:640-658` delete the retiring folder with errors ignored.
   - **Trigger:** colleagues with read-only rights on the office library, if OneDrive marks those files read-only (not verified).
   - **Fix idea:** clear the read-only flag after each copy.
   - **Unit test RED:** yes.

---

## Settings save and load

1. **HUNT-MI-03 (HIGH, CONFIRMED, re-checked). Civil changes the engineer's maximum pipe velocity and joint label heights at every start.**
   - **Where:** `Modules/Drainage/Services/SettingsService.cs:145-152`: `if (MaximumPipeVelocity > 0.0 && MaximumPipeVelocity <= 3.0) MaximumPipeVelocity = 6.0;`. The same file at `:157-170` turns any SC or CJ label font height under 200 into 250. These are range tests on every load, not a one-time migration. The Settings page accepts any velocity above 0 (`AdvancedSettingsViewModel.cs:1427`), so a 3.0 saves, then comes back as 6.0 at the next start. The only notice is a log line.
   - **Trigger:** CDS > Maximum pipe velocity 3.0 > Save > restart AutoCAD > run a design check (or reopen CDS).
   - **Wrong:** the checks use 6.0 m/s, CDS now shows 6.0, and a 4 m/s pipe gets no high-velocity warning. **Right:** 3.0 stays 3.0. The old-default move should run once, behind a "migrated" flag, as Structural does with `MigrationSettings`.
   - **Also:** the step-iron rule at `:200-210` / `:874-881` moves exactly 1000 mm to 900 mm at every load, so an engineer cannot deliberately choose 1000. That one is lower risk; it matches Tim's CR-A5 ruling except for this case.
   - **Fix idea:** one-time migration flag, and one command-line line when a value is moved.
   - **Unit test RED:** yes. Use `SettingsService.BeginTestScope` plus `ReloadFromDiskForTest` on a file with `maximumPipeVelocity: 3.0`, and assert 3.0.

2. **HUNT-MI-04 (HIGH, CONFIRMED, re-checked). Structural "Reset Defaults" wipes the whole settings file in one click.**
   - **Where:** Structural `Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml:18` (the button beside Cancel). `CeSettingsDialog.xaml.cs:459-462`: `SaveAndClose(new UserSettings());`, written at once by `SettingsService.Replace` (`SettingsService.cs:108-121`). A kept copy is made only after an unclean load. Because the migration flags are new as well, `EnsureDefaultsAndMigrate` (`:510-520`) re-runs the old `TIM_CETOOLS` registry import and the old `xrl_settings.json` import.
   - **Trigger:** CESETTINGS > Reset Defaults (one misclick).
   - **Wrong:** every Structural setting is gone, including tables with no page: SBEAM favourites and recents, Excel schedule rules, wall types, mark prefixes, line styles, the bearer span table, pinned commands and MarkupAI paths. Old registry values may come back. **Right:** an "are you sure", a kept copy, and a reset limited to what the window shows, keeping the migration flags.
   - **Unit test RED:** partly. The reset logic would need to come out of the window code first.

3. **HUNT-MI-05 (HIGH, code path CONFIRMED, trigger PLAUSIBLE). An unreadable Civil settings file is replaced by standard values at the next ordinary save.**
   - **Where:** `SettingsService.cs:235-240`: a read failure goes to `ProtectUnreadableOriginal` (`:472-482`), with no read retry (Structural retries three times).
     - If the copy-aside works, saves are not held, so the next routine save (`AddRecentDiameter` `:912-925` into `SaveSettings` `:512`) writes standard values.
     - If the copy-aside fails, `TryReplaceAndSave` (`:522-561`) still writes them and lifts the hold (`:545`).
     - `LoadWarningMessage` and `RoutineSavesHeld` are shown nowhere outside `SettingsService.cs`, so CDS and CEMANAGER give no warning.
   - **Trigger:** `CD_Settings.json` is locked at AutoCAD start (a second AutoCAD saving, or antivirus). The engineer then draws one pipe, or changes the theme in CEMANAGER Settings and clicks Apply.
   - **Wrong:** the whole file becomes standard values; in the copy-failed case there is no backup at all. **Right:** do what Structural's `LoadRecovery.cs:157-170` / `:941-953` does: retry the read, refuse to write over a file it never opened, and say so.
   - **Unit test RED:** yes. Open the file with `FileShare.None`, call `ReloadFromDiskForTest`, then `TryReplaceAndSave`, and assert it is refused and the bytes are unchanged.

4. **HUNT-MI-08 (MEDIUM-HIGH, CONFIRMED). "Reset Civil" in CEMANAGER resets values the page does not show.**
   - **Where:** the button is at `Modules/Drainage/Dialogs/CivilSettingsView.xaml:197-200`; `ExecuteResetCivil` is in `AdvancedSettingsViewModel.cs:1045-1105`; the save candidate writes every field (`:1512-1606`).
   - **Not on that page but reset:** `DrawingTemplatesFolder`, `DsLpdStandardNote`, `FitClearanceSource`, `FitClearancesConfirmed = false`, the four pipe-to-pit clearances, `ImportedLevelToleranceMm`, `PitCatchMarginMm`, `ScheduleRowsPerSheet`, `RedoHoldSeconds`, the downpipe words, `PipeObjectUpgrade` and `DsPipeSizeProposalsEnabled`.
   - **Trigger:** CEMANAGER > Settings > Civil > Reset Civil > Apply.
   - **Wrong:** the engineer's own LPD note, the templates folder and the confirmed clearance source are wiped unseen; the page only says "Unsaved changes". **Right:** reset only what the page shows, or list every value that will change before Apply.
   - **Unit test RED:** yes, `AdvancedSettingsViewModel` with a fake writer.

5. **HUNT-MI-09 (MEDIUM, CONFIRMED, re-checked). Civil writes its main settings file in place.**
   - **Where:** `SettingsService.cs:608-620`: `File.WriteAllText(_settingsFilePath, json);`. Compare `SettingsService.RememberedValues.cs:118-140` (temporary file, replace, retry), Manager's `CeJsonService.cs:38-81`, and Structural.
   - **Trigger:** power cut, crash, disk full or an antivirus lock during any save.
   - **Wrong:** a half-written file. The next start copies the broken file aside and runs on standard values, then HUNT-MI-05 overwrites it. **Right:** temporary file, flush, swap.
   - **Unit test RED:** not easily; a source guard against `File.WriteAllText(_settingsFilePath` would show it.

6. **HUNT-MI-17 (MEDIUM, CONFIRMED). The CEMANAGER Settings page can undo a change just saved in CDS.**
   - **Where:** `CeCivilSettingsBridge.cs:20` builds a view that takes one snapshot (`AdvancedSettingsViewModel.cs:1174`). The Manager window does not block other work (`PluginManagerCommands.cs:42`). `Apply` (`:1259`) writes every snapshot value over a fresh copy (`:1512`).
   - **Trigger:** open CEMANAGER > Settings > Civil, leave it open. Type CDS, change Minimum cover depth, Save. Back in CEMANAGER, change the theme and click Apply.
   - **Wrong:** the cover depth goes back to the old value without a word. **Right:** apply only the fields changed in that page, as the newer fields already do with `_changes[...]`.
   - **Unit test RED:** yes, two view-model copies on one test file.

7. **HUNT-MI-18 (MEDIUM, CONFIRMED). Structural: a second AutoCAD's routine save reverts a change made in the first.**
   - **Where:** Structural `SettingsService.cs:122-137` and `:919-931` write the whole in-memory copy. `WriteSettingsFileProtected` (`LoadRecovery.cs:955+`) carries over only unknown keys. Only SBEAM merges (`CommitSbeamPickerPreferenceDelta`).
   - **Trigger:** two AutoCADs open. In A, CESETTINGS, change the beam text offset, Save. In B (opened earlier), run any command that saves a "last used" value.
   - **Wrong:** A's change is gone after the next restart. **Right:** routine saves merge only their own field, as SBEAM does.
   - **Unit test RED:** yes.

8. **HUNT-MI-19 (LOW-MEDIUM, CONFIRMED). Structural CESETTINGS ignores a mistyped number and closes as if it saved.**
   - **Where:** `CeSettingsDialog.xaml.cs:257-270` (`if (double.TryParse(...))` assigns only on success), `TrySaveDouble` `:585-592`, and `IntOr`/`DoubleOr` `:563-582` (silent clamps; backup copies 0 becomes 1).
   - **Trigger:** type "1,200" or "1O0" (letter O) in a beam offset box, Save.
   - **Wrong:** the old value stays, with no message. **Right:** refuse and name the box, as Civil does.
   - **Unit test RED:** no (the parsing is in the window code).

9. **HUNT-MI-20 (LOW, CONFIRMED). The CE Blocks settings file falls back to defaults on any read error, then saves them.**
   - **Where:** `Modules/Manager/Services/CeBlocksSettings.cs:39-58` (any error gives defaults), `:73-85` (delete, then move: a crash between leaves no file), `:45-47` (a blank path stays blank). `SettingsWorkspacePage.xaml.cs:32-43` loads then saves.
   - **Wrong:** the recent blocks list is lost, and a cleared box gives an empty palette path. **Right:** refuse to save after a failed read; use the same swap as `CeJsonService`.
   - **Unit test RED:** yes.

10. **Smaller settings notes (LOW, not counted).**
    - **Newer keys dropped:** Civil has no carry-over of keys it does not know. An older Civil saving after a roll-back drops newer settings; Structural already fixed this (BUG-303).
    - **Start-up fallback:** `SettingsService.cs:93-98`: if start-up throws after the file loaded, memory goes to standard values while still pointing at the real file (PLAUSIBLE).

11. **Settings transfer (Move My Settings, M-SET-01): not in the installed line.** PRs #424/#425 (`claude/manager-settings-move-de`) are not merged into `rel-20261019a` (checked with git). There is no import or export of settings anywhere in either line, so there is nothing to hunt there. This is the plan's known state, not a bug.

---

## Admin Dashboard, fault reports and privacy

1. **HUNT-MI-07 (MEDIUM-HIGH, CONFIRMED, re-checked). The BUG-476 fix still lets a colleague take the administrator role.**
   - **Where:** `Modules/Manager/Services/CeAdminPolicyService.cs`.
     - `:47-50` uses the shared list if it exists, otherwise this PC's.
     - `:55` sets `hasPolicyFile` if either file exists.
     - `:62-69` offers set-up only when neither exists.
     - `:122-127` refuses set-up when either exists ("A CE administrator is already set up…").
     - `:164-167` tells Tim to "Run Set up CE administrator again once it is reachable".
   - **Trigger:** Tim sets up while the office folder is unreachable, so the list is saved on his PC only. His set-up button is then hidden, and set-up refuses, so he cannot "run it again". Any colleague then opens CEMANAGER: their PC sees no file, the button shows, and one Yes writes the SHARED list with their name. From then on Tim's PC reads the shared list and he is not an administrator.
   - **Second route (PLAUSIBLE):** a colleague's OneDrive has synced the IT Admin folder but not yet `CE Plugin Admin\policies`.
   - **Right:** a local-only list is promoted to the shared file when the folder becomes reachable. Set-up is never offered on a PC that can see the office folder but not its policies folder.
   - **Unit test RED:** yes. Seed with only the local file, then a colleague seeds the shared file; `GetPolicySnapshot(..., "tim")` gives not-admin.
   - **Status today:** BUG-476 says Codex saw the shared list on 10 Oct, so on Tim's PC this route needs the shared file to be lost or not synced. It matters for any second office or a re-set-up.

2. **HUNT-MI-21 (MEDIUM, CONFIRMED). Nobody can add a second administrator or repair the list, but every refusal says "ask an administrator to add you (Manager, Policies tab)".**
   - **Where:** `CeAdminPolicyService.cs:124`, `PluginAdminWindow.xaml.cs:159`. `PluginAdminWindow.xaml:262-280` (the Policies tab has text and the set-up button only). Nothing writes `admin-users.json` except set-up.
   - **Matching faults:**
     - `"users"` in lower case reads as an empty list, because the reader is case-sensitive.
     - `"CE\\tim"` never matches `Environment.UserName`, which has no domain part.
     - A leading space never matches, because entries are not trimmed (`:57`).
   - **Right:** an "Add administrator" action for an existing administrator; trim entries and drop any "DOMAIN\" part before comparing.
   - **Unit test RED:** yes. `GetPolicySnapshot` with `["CE\\tim"]` for user "tim".

3. **HUNT-MI-22 (MEDIUM, CONFIRMED). One half-copied report file blanks the whole Admin Dashboard.**
   - **Where:** `Modules/Manager/Services/CeAdminAnalyticsService.cs:208-227`. The heartbeat, usage and failure loaders call `CeJsonService.Load` (which throws, `CeJsonService.cs:91-104`) with no catch per file. `PluginAdminWindow.xaml.cs:65-80` catches the whole refresh and shows "Could not refresh."
   - **Trigger:** any one file under `CE Plugin Admin\machines`, `usage` or `failures` is 0 bytes, cut short, or held by OneDrive. Uploads are plain copies into OneDrive (`CeAdminStorageService.cs:190`). This will happen often with many PCs.
   - **Right:** skip that one file and show the rest (the per-file rule S2-006 applied to approvals, not to these three folders).
   - **Also (PLAUSIBLE, performance):** each refresh reads every report ever uploaded from every PC, and nothing deletes them, so the dashboard keeps getting slower.
   - **Unit test RED:** yes. `LoadDashboard` with a 0-byte `usage\x.json` throws.

4. **HUNT-MI-23 (MEDIUM; no catch CONFIRMED, AutoCAD's response PLAUSIBLE). Two Admin Dashboard buttons have no error catch.**
   - **Where:** `PluginAdminWindow.xaml.cs:182-192` ("Create bundle", which writes to the Desktop through `CeSupportBundleService.cs:101-109`) and `:329-344` ("Mark as Investigated", which writes to the office folder through `CeAdminAcknowledgmentService.cs:41-43` and throws after 5 retries). Manager has no catch-all for window errors.
   - **Trigger:** Desktop blocked by Windows Controlled Folder Access, or a full OneDrive. Or the office folder read-only or held by OneDrive.
   - **Wrong:** an unhandled error inside AutoCAD (not seen what AutoCAD does). **Right:** one plain message. Different buttons from BUG-485.
   - **Unit test RED:** no; a source guard is possible.

5. **HUNT-MI-24 (LOW, CONFIRMED). If the privacy code file cannot be saved, the coded names use a fixed salt written in the source.**
   - **Where:** `Shared/CE_SHARED/Services/CePiiHash.cs:128-135`, `"CE_SUITE_PIIv1_ephemeral_salt"`. Structural has the same pattern, `StructuralPiiHash.cs:53`.
   - **Trigger:** `%APPDATA%\TIM_CE_CADTOOLS` cannot be written.
   - **Wrong:** anyone with the code can turn a staff list into the same codes, and every such PC gives identical codes. **Right:** random bytes held in memory for that session.

6. **HUNT-MI-25 (LOW, CONFIRMED for the cleaner). The support-zip cleaner leaves client names in anything under AppData or Temp.**
   - **Where:** `Modules/Manager/Services/CeSupportBundleScrub.cs:53`, `:67-75` and `:89-90` exempt any path containing `\AppData\` or `\Temp\` as "CE's own place". `.sv$` and `.ac$` are not in the drawing types (`:19`).
   - **Input:** `C:\Users\x\AppData\Local\Temp\25-123 Smith St Lot 4 - C01.pdf`, or an autosave `...\Temp\Smith St Lot 4_1_1_8394.sv$`.
   - **Wrong:** comes out with "Smith St Lot 4" kept. **Right:** `[job 25-123]`.
   - **Overlap:** a gap left by the BUG-489 fix, not the original finding.
   - **Unit test RED:** yes.

7. **HUNT-MI-26 (LOW, PLAUSIBLE timing). The background upload can send a half-written temporary file and lose that report.**
   - **Where:** `Plugin.cs:140-155` (upload about 15 s after start), `CeAdminStorageService.cs:170-192` (copies and deletes every file, including `*.tmp`), and `CeJsonService.cs:43-57` (writes `name.json.<id>.tmp`, then moves it).
   - **Wrong:** junk `.tmp` files in the office folder, and the local move then fails, so that usage or heartbeat record is lost silently. **Right:** upload `*.json` only.
   - **Unit test RED:** yes.

8. **HUNT-MI-27 (LOW, PLAUSIBLE). Offline, an online-only admin list makes Tim "not administrator" with a "damaged" message.**
   - **Where:** `CeAdminPolicyService.cs:77-79`. `File.Exists` is true but the read fails, so the message says the list is damaged when it is only not downloaded.

---

## Ribbon, command registry and start-up

**Command-name check first (clean):**
1. **No duplicate command names across Civil, Manager and Structural.** Every `[CommandMethod]` was matched against the three `command-registry.json` files, the three `PackageContents.xml` command lists and every ribbon definition.
2. **Every registry entry exists.** All 11 Manager and 139 Civil entries exist. Structural's hidden XCLMTXTINDEX, BMT2TXT and BTXT2MT do not, but they are already listed as ghost entries in `docs/CARDS`.

**Findings:**

1. **HUNT-MI-06 (MEDIUM, CONFIRMED, re-checked). A CE ribbon click during another command types the command name into that command.**
   - **Where:** `Shared/CE_SHARED/Services/RibbonBuilder.cs:695`: `doc.SendStringToExecute(cmd + "\n", true, false, true);` with no cancel in front. Manager's own toolbar macros do cancel first (`CeSuiteManagerMenuService.cs:393`, `"^C^C" + commandName`).
   - **Trigger:** start TEXT. At "Enter text:", click any CE ribbon button (Civil, Structural or CE Tools; all share this handler).
   - **Wrong:** "CD" or "CEMANAGER" goes into the running prompt; with TEXT it becomes text on the drawing. At a point prompt it gives "invalid point" and the CE command never starts. **Right:** the running command is cancelled, then the CE command starts, as AutoCAD's own buttons do.
   - **Fix idea:** send two cancels before the name when a command is active (CMDACTIVE not 0).
   - **Unit test RED:** yes, after pulling the string-building into a small method.
   - **Confidence:** the missing cancel is CONFIRMED. How AutoCAD feeds the text to the prompt is standard behaviour, not watched here.

2. **HUNT-MI-28 (MEDIUM, CONFIRMED). Manager's ribbon rebuild overwrites the Civil tab and ignores "Show the old CE tabs".**
   - **Where:** `Modules/Manager/Services/CeUnifiedRibbonService.cs:127-133` rebuilds every registered tab. Civil's `StandaloneCivilRibbonService.cs:142-146` builds the same tab (`CE_CVL_SUITE_TAB`) honouring `ShowClassicCeTabs`. `RibbonBuilder.cs:60` clears panels first. Both run in a normal three-bundle install.
   - **Trigger:** AutoCAD 2025 or later, Settings > Show the old CE tabs ON, restart.
   - **Wrong:** the classic layout appears, then is replaced. The whole Civil tab is torn down and rebuilt at every status-dot change, about 35 s after start and later, while the drafter works. **Right:** one owner builds the tab, and the setting sticks.
   - **Unit test RED:** no; a source guard is possible.

3. **HUNT-MI-29 (LOW-MEDIUM; manifest edit CONFIRMED, proxy result PLAUSIBLE). "Disable on Restart" for Civil also turns off the 2027 pipe-object file and the native grips.**
   - **Where:** `Modules/Manager/Services/CePluginRegistryService.cs:251-256` sets `LoadOnAutoCADStartup` on every ComponentEntry, including `CE_CVL_OBJECTS_2027.dbx` and `CE_CVL_NATIVE_GRIP_2027.arx` (and Structural's `CE_STRUC_NATIVE_2027.arx`).
   - **Trigger:** CEMANAGER > Civil > Disable on Restart, restart AutoCAD 2027, open a drawing with CE pipe objects.
   - **Wrong:** the pipes come in as proxy objects, against Tim's ruling that the object file works "with or without the CE ribbon". **Right:** change only the `CE_CVL_SUITE.dll` entries.
   - **Unit test RED:** yes, on a temporary copy of Civil's manifest.

4. **HUNT-MI-30 (LOW, CONFIRMED). Ribbon buttons call commands from a module that may not be installed.**
   - **Examples:**
     - CE Tools > Version runs CE_VERSION (`CeToolsRibbonDefinitionService.cs:18`), which exists only in Structural (`AdminCommands.cs:22`).
     - Structural's Ask CE runs CDASK, which exists only in Civil.
     - CE Blocks runs CEBLOCKS, which exists only in Manager.
   - **Trigger:** a Civil and Manager PC without Structural; click CE Tools > Version.
   - **Wrong:** "Unknown command CE_VERSION". **Right:** hide the button when its owner is not loaded, or move CE_VERSION into Manager.
   - **Unit test RED:** yes, a cross-module guard.

5. **HUNT-MI-31 (LOW, CONFIRMED). The ribbon click log grows for ever and records drawing names.**
   - **Where:** `RibbonBuilder.cs:705-716` appends to `%APPDATA%\CE_CVL_SUITE\logs\ribbon-clicks.log` on every click, with the drawing file name, and never trims it. Related to BUG-491, but a different file.

6. **Possible contributors to BUG-164 "sometimes a crash message on close" (PLAUSIBLE, not counted).**
   - `Plugin.Terminate` (`Plugin.cs:256-263`) calls four shutdown steps with no try around each, so one failure skips the rest during AutoCAD close.
   - `CeAdminTelemetryService` reads `Application.Version` (`:255`) from the start-up background thread (`Plugin.cs:159`).
   - The status monitor can start after Stop if AutoCAD closes inside the first 15 s. It was followed and does not touch AutoCAD, so it is low risk.

7. **Other small notes (LOW, not counted).**
   - Start-up warnings are only logged when AutoCAD starts on the Start tab with no drawing (`Plugin.cs:164-173`).
   - "Load Now" sends NETLOAD as typed text, which may open a file dialog when FILEDIA is 1 (PLAUSIBLE).
   - A bad line-style setting can leave the whole CE Structural tab empty (PLAUSIBLE).

---

## Licence and seat checks

1. **No licence or seat check exists** in Manager, the installer, CE_SHARED or CE.Cloud on the installed line (searched for licence/license/seat). Nothing to hunt. If colleagues are told CE checks seats, that sentence is untrue.

---

## Known bugs re-checked on this line (not counted)

1. **BUG-477 Roll Back:** now hidden behind the `ShowRollBack` switch (`PluginAdminWindow.xaml.cs:23`). The fix is in the code; not seen in AutoCAD by me.
2. **BUG-481 MENUBAR:** now only set when the `ForceMenuBarSetting` switch is on (`CeSuiteManagerMenuService.cs:831`, `CeOneGlanceStatus.cs:239`).
3. **BUG-478 wording:** colleagues are now told to ask the administrator (`1db45965`, `c5190ad1`). But HUNT-MI-01 and 02 mean even the administrator's installer route cannot finish an update today.

## Checked and fine (one line each)

1. **The installer's folder swap:** sibling folders on one drive, a unique roll-back name per run, the old bundle put back on failure, and two AutoCAD-running checks.
2. **Release check and file lists:** an empty list, duplicate paths, ".." paths, linked folders and missing keys all fail closed. Path comparisons ignore case.
3. **Stage lookup on the Manager side:** pinned to the approved version, fingerprint and target, so a stale stage is never shown after a newer approval.
4. **Canary list:** uses the real PC name or this PC's own code; typed names are trimmed.
5. **AutoCAD version lanes:** 2022-24, 2025-26 and 2027 are correct in all three PackageContents files.
6. **A damaged admin list:** fails closed (nobody is administrator), never everyone.
7. **Report dates:** ISO format, safe on Australian date settings. Report file names carry unique ids, so two PCs cannot collide.
8. **Manager's own JSON save:** temporary file, replace with backup, retry.
9. **Civil Settings number boxes:** use the invariant number format with a plain error. CDS Cancel, Escape and X never save.
10. **Structural file safety:** named lock, swap, read retry, a refused save after an unopened start, and unknown-key carry-over.
11. **Manager menu file:** written to `%APPDATA%\CE_CADTOOLS\CE_SUITE_MANAGER`, not AutoCAD's support folders.
12. **Ribbon rebuild requests from the timer:** handed back to AutoCAD's own thread.
13. **Manager does not call CE.Cloud.**

## Not checked

1. **Nothing was run:** no unit tests (HUNT-MI-01's existing test should be red; run it after 5:30 pm), no installer, no AutoCAD.
2. **OneDrive behaviour:** whether Files On-Demand marks synced files read-only or as linked folders (HUNT-MI-16; the installer refuses linked folders).
3. **AutoCAD's response** to an unhandled error from a CE window (HUNT-MI-23).
4. **Colleagues' PCs:** their office-folder rights, OneDrive state and Desktop location.
5. **The deploy chat's own install script** (the real colleague route today): not read.

---

## Summary

Read-only hunt of Manager 1.1.56 / Civil 3.0.56 (`rel-20261019a`, `21462f9c`) and Structural 1.0.118 (`rel-20261017s`, `9a8e5d4e`). It found 31 draft findings (HUNT-MI-01 to 31): 5 HIGH, 13 MEDIUM or MEDIUM-HIGH, and 13 LOW or LOW-MEDIUM.

The two most serious, both re-checked by hand, are on the update route. The installer refuses every update Manager gets ready, because Manager leaves its receipt beside the three signed files and the release check wants exactly three. The installer also refuses Civil 3.0.56, and Manager on any PC with Civil 3.0.56, because it does not know the new `.dbx` pipe-object file. So the Manager update route cannot finish anything today, and an existing installer unit test should already be red.

The next group is settings data safety:
1. Civil resets a stored 3.0 m/s maximum velocity to 6.0 and joint label heights to 250 at every start.
2. Structural Reset Defaults wipes everything in one click.
3. Civil writes its settings file in place, and replaces it with standard values after an unreadable start.
4. The CEMANAGER Settings page resets hidden Civil values and can undo a CDS save.

The admin fix (BUG-476) still has a takeover route through a local-only list, and there is no way to add an administrator. CE ribbon buttons do not cancel a running command, so a click at a TEXT prompt can put the command name on the drawing.

The command registry is clean: no duplicate or missing command names. No licence or seat checks exist, and Move My Settings is not in the installed line. No BUG numbers were filed. The controller should file these, starting with HUNT-MI-01, 02, 03, 04 and 05.
