# Release v3 colleagues — Audit run 1 report (Fri 9 Oct 2026)

Helper: CE_ACAD / release-v3-colleagues / audit / 01. Read-only. Code read with `git show` / `git grep` at the release commits only:
Civil 3.0.40 + Manager 1.1.40 = **1200744d** (rel-20261009e), Structural 1.0.110 = **9babe787** (rel-20261009f).
I also checked that none of the Civil/Manager files named in Audit A changed in C-27 (**319ba688**, rel-20261009g): all unchanged, so every Civil/Manager finding below applies to C-27 too.
No AutoCAD, no accoreconsole, no builds, no tests run. Every file:line below is at the release commit named.

---

## FOR TIM (read this part only)

1. **Privacy: one real blocker, two near-blockers.**
   - **Blocker:** the Manager's **"Send a fault report"** button (and the CEMANAGERDIAG command) writes the colleague's **real Windows login, real PC name, their user folder path and their OneDrive folder** into the **office IT folder**, in the folder name, the file name and the text. Nothing codes them. The button's hover text does say so, but every other CE report codes these names.
   - **Near-blocker:** the **support zip (CESUPPORT)** still carries **drawing names**: CE logs a drawing's name **without ".dwg"** each time a drawing is opened, goes idle or is switched to, and the zip cleaner only recognises names that end in ".dwg". Any zip a colleague sends will list the drawings they worked on for 14 days.
   - **Near-blocker:** the zip cleaner also lets **folder paths and PDF paths** through untouched apart from the user folder (for example a STORM rating report PDF path in the job folder).
2. **Also leaves the office, not on your list:** when a colleague confirms a pipe connection (CDCONFIRM, CDCHECK connect, junction, branch end, split) or signs off a CDDESIGN redesign, their **Windows login is written into the drawing itself**. Drawings go to clients and councils.
3. **Your call (not a code fault):** the Civil time log files sit in the office Drafting folder **named after each person's Windows login**, and the weekly export copied to the IT folder has a "By person" list of logins. The code says this follows your UX-TIME-04 ruling; I found no ruling that it must be the Windows login rather than a name the person types.
4. **Structural Undo/Redo: nothing found that writes between U and REDO** in my reading. The Idle work waits, the command-end work skips U/UNDO/REDO/MREDO. Two gaps: the safety test cannot see two kinds of code (shown in section B), and Codex has walked only C1, beam 1, CSREOBAR, FEDIT and BT1. **Correction to the brief:** Codex did **not** walk TS1 Undo/Redo (W39-03 placed TS1 but no U/REDO was asked).
5. **Settings: Structural rewrites CS_Settings.json at every AutoCAD start when it has new default rows** (Codex saw it at 06:00:39 today: 13 rows added, no value changed). Structural and Civil also save settings at start-up after every new version. None of this changes a value a person set.
6. **Recommendation:** fix item 1 (fault report) before colleagues get the release; fix item 1's zip gaps in the same small change. Items 2, 3, 5 can wait for your word.

---

## A. Privacy routes (ranked most likely first)

1. **"Send a fault report" / CEMANAGERDIAG writes real names to the office IT folder.**
   - **Where:** `Modules/Manager/Services/CeDiagnosticsService.cs:54-55` (text lines "Machine : <real PC name>", "User : <real login>"), `:95` (OneDriveCommercial path, which holds the user folder), `:99` (IT Admin path under C:\Users\<login>), `:279` (file name `<time>_<real login>.txt`), `:291` (folder named the real PC name), `:294` (write). Folder: `<IT Admin>\CE Diagnostics\<PC>\` or the Desktop when the office folder is missing.
   - **How a colleague triggers it:** CEMANAGER window, "Send a fault report" (`Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:227`, click handler `PluginManagerWindow.xaml.cs:726`), or typing CEMANAGERDIAG (`Modules/Manager/Commands/PluginManagerCommands.cs:89-99`). The Manager's own help page tells people to use it (`PluginManagerWindow.Help.cs:382`), so this will be used.
   - **Note:** the tooltip at xaml:227 discloses "this PC's name and your Windows name". I found no recorded Tim decision allowing real names here (searched C:\CE_PLAN for the button and service names).
   - **One-line fix:** pass the finished report through `CePiiScrub.ScrubHere` and name the folder and file with `CePiiHash` codes, as BUG-413 did for machine reports.

2. **Support zip: drawing names logged without ".dwg" pass the zip cleaner.**
   - **Cleaner:** `Modules/Manager/Services/CeSupportBundleScrub.cs:19-35` only cuts paths and bare names that end in a drawing type (dwg, dxf, dwt, dws, dwl, dwf, bak).
   - **Lines that escape:** `Modules/Drainage/Core/JobTime/JobTimeTracker.cs:155, 216, 323, 345` log `session.DrawingName`, which is the name with no extension (`JobTimeSession.cs:151`). `Modules/Drainage/Services/ProjectDataService.Mutations.cs:124, 181, 197, 261` and `ProjectDataService.KeptRecords.cs:140, 143` log the project file path, which is `CD_ProjectData_<drawing name>_<hash>.json` (`ProjectDataService.Persistence.cs:1339-1343`). The user folder part becomes %USERPROFILE%; the drawing name stays.
   - **How triggered:** opening, switching to, or leaving idle any drawing; then CESUPPORT. Every zip from the last 14 days of logs will contain them.
   - **One-line fix:** log the job number (or a short code) instead of `DrawingName` / `_projectFilePath`; belt and braces, add a rule to the zip cleaner that cuts `CD_ProjectData_<...>.json` names.

3. **Support zip: folder paths and non-drawing file paths pass the zip cleaner.**
   - **Lines:** `Modules/Drainage/Services/StormReportReader.cs:349` (rating-report PDF path in the job folder, on a read failure); `Commands/LinkCommands.ImportXcivil.Corpus.cs:422, 486, 546` (configured / PDF paths, Debug lines, always written); `Services/DrawingBackupService.cs:355` (backup folder named after the drawing, `:333-337`, on a listing failure).
   - **What leaks:** everything in the path after the user folder: OneDrive folder name, project folder, job folder name (job folders can hold a street name).
   - **One-line fix:** in `CeSupportBundleScrub`, treat any drive or server path (any extension, or a folder) like a drawing path: keep only the job number.

4. **Civil time logs and weekly export name people by Windows login (shared office folders).** By design per the code's UX-TIME-04 note; listed so Tim can rule.
   - **Where:** `Modules/Drainage/Services/CivilJobTimeSettings.cs:31, 35` (name defaults to the Windows login), `:103` (file `Time Logs\users\<login>_<yyyy-MM>.csv`), `:166-168` (folder = the office Drafting OneDrive folder when present); `JobTimeCsvLogger.cs:25` (columns include Address, Suburb, Drawing, Client, User); `JobTimeWeeklyExportService.cs:200-212` ("By person" list) and `:119-121` (copied to `<IT Admin>\CE Diagnostics\Time Logs\weekly exports`).
   - **How triggered:** automatically; any drawing session over a minute, and the weekly export runs at start-up (`CivilJobTimeService.cs:35`).
   - **Structural equivalent:** `Modules/Structural/Models/UserSettings.cs:236` (name defaults to the Windows login), used for shared notes, suggestions and time records. I did not trace Structural's time-log folder.
   - **One-line fix (if Tim wants it):** default the name to blank and ask once, or to the coded name, never `Environment.UserName`.

5. **Windows login written into the drawing file.**
   - **Where:** `Modules/Drainage/Services/LinkService.Spine.cs:567` (`Person` of a connection decision, stored in the drawing's spine record), called with `Environment.UserName` from `Commands/SpineCheckCommand.cs:389`, `SpineConfirmCommand.cs:86`, `SpineJunctionCommand.cs:83`, `CdCommand.BranchEnds.cs:188`, `Services/LinkService.Split.cs:87`. `Services/NetworkRedesignSignOffService.cs:32-33` (`staffIdentity` written into the drawing at CDDESIGN redesign apply).
   - **How triggered:** confirming any pipe connection; applying a redesign. The DWG then goes to a client or council.
   - **One-line fix:** store the coded name (`CePiiHash`) or the person's chosen display name.

6. **Manager failure reports uploaded to the office folder keep drawing and job paths.**
   - **Where:** `Modules/Manager/Services/CeAdminTelemetryService.cs:132-133` scrub only login, PC and user folder; then uploaded to `<IT Admin>\CE Plugin Admin\failures` (`CeAdminStorageService.cs:144-163`).
   - **How triggered:** a Manager error whose message holds a path. Low: the Manager rarely handles drawing paths.
   - **One-line fix:** use the zip cleaner (`CeSupportBundleScrub.Scrub`) here too.

7. **Civil and Structural machine reports carry drawing names, and Civil's failure report is not scrubbed at all.**
   - **Where:** Civil `Modules/Drainage/Services/AdminTelemetryService.cs:259` (status "Active drawing: <name>.dwg"; `CePiiScrub` does not remove drawing names), `:324, :403` (usage `DrawingName`), `:175-176` (failure Message and Details with no scrub), `:481` ("Recent acad.err: C:\Users\<login>\...\acad.err" in Details). Structural `Modules/Structural/Services/AdminTelemetryService.cs:307` (same "Active drawing"), `:364, :428` (DrawingName scrubbed for login only).
   - **Where it goes:** `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox` (`Shared/CE_SHARED/Services/CeTelemetryStore.cs:60-68`). The Manager uploads a different folder (`%APPDATA%\CE_CADTOOLS\CE_Admin`), so these stay on the PC, **except** the Manager's one-time move of the old folder (`CeAdminStorageService.cs:36-40`): if Civil or Structural wrote there before the Manager first ran on a new PC, that first batch is moved and uploaded. I could not establish the load order.
   - **One-line fix:** drop `DrawingName` and "Active drawing" from the reports and scrub Message/Details with the zip cleaner.

8. **Attribute values written to the Civil log (and so the zip).**
   - **Where:** `Modules/Drainage/Services/BlockService.cs:2301, 2447` (Debug "Set attribute '<tag>' = '<value>'"; Debug lines are always written).
   - **Risk:** only if a title-block attribute holding a client or address is set through these. I did not trace the callers.
   - **One-line fix:** log the tag only.

9. **File names on the PC that carry drawing names (beyond the known cdcheck- / cdrules-).** Not zipped; on the PC only.
   - `%APPDATA%\TIM_CE_CADTOOLS\projects\CD_ProjectData_<drawing>_<hash>.json` (`ProjectDataService.Persistence.cs:1339-1343`); `AutoSaveBackups\CE_CVL_SUITE\<drawing>_<digest>\` (`DrawingBackupService.cs:333-337`); `<source>_CDIMPORTXCIVIL_*.txt` and `_DEBUG_*.log` (`LinkCommands.ImportXcivil.cs:184, 192`); background-xref caches (`BackgroundXrefSnapshotCacheService.cs:28`); Structural command history lines with drawing names in `%APPDATA%\TIM_CE_CADTOOLS\logs` (`Modules/Structural/Services/CommandHistoryService.cs`).
   - **One-line fix:** name them by the existing hash only.

10. **Dormant: Structural's old support zip.** `Modules/Structural/Services/SupportBundleService.cs:150-152` writes the real PC name, real login and full drawing path, and copies logs, failure files and recovery snapshots raw. **No command reaches it in 1.0.110:** `Commands/DiagnosticsCommands.cs:45` has no command attribute and nothing calls it. **Fix:** delete it, or route it through the Manager's cleaned zip, before anyone re-wires it.

11. **Error and result boxes** show paths under the person's own user folder to that person (for example the fault report "Saved in:" box). Not a leak unless screenshotted. Lowest.

**Checked and clean:** the Manager zip codes login and PC name, cuts drawing paths and names ending in a drawing type, cleans entry names, leaves out the administrator's name book and is never uploaded (`CeSupportBundleService.cs:49-98, 136-164`); machine report file names are coded; feedback hashes the drawing and PC name (`FeedbackService.cs:141-142`); the Civil cloud telemetry queue holds fixed fields only and sends nothing unless two environment variables are set (`TelemetryQueueService.cs:31-34, 42-43`). The shared administrator list holds real logins by design and only after "Set up CE administrator" (`CeAdminPolicyService.cs:104-168`).

---

## B. Structural Undo/Redo (Stage 1)

1. **How the guard works (read at 9babe787).** `Modules/Structural/Services/RedoWindowGuard.cs` and `RedoWindowRegistry.cs`: after U, a real UNDO, REDO or MREDO the "redo window" is open in that drawing until the next command starts there. Automatic Idle or timer work asks `DeferWhileRedoOpen` and waits until the next command has finished. Settings "Wait after Undo (seconds)" defaults to 0 (= until the next command); Tim's live CS_Settings.json reads `"RedoHoldSeconds": 0`.

2. **The safety test.** `Modules/Structural.Tests/Services/RedoSafeCallGraphTests.cs` follows the compiled Structural + CE_SHARED code from every AutoCAD event hook, timer and AutoCAD-derived override, and flags transactions, system-variable sets, locks, header sets, writes and command starts. `RedoSafeReviewedHooks.baseline.txt` holds **28 reviewed hooks**. I read every reason; each is one of: asks the guard first (DrawingAutoSave Idle, FoundationMonitor Idle); skips U/UNDO/REDO/MREDO by name (BeamLink command end, FoundationMonitor command end, Dimension restore x3, ReoBarMonitor); only after the drafter's own command (job time at QSAVE/SAVE, text-anchor at TEXTEDIT/DDEDIT/MOVE, REVCLOUD restore x3, BeamLink follow on MOVE/STRETCH etc.); reads other drawing files as side databases (MainPalette, PaletteManager, SheetsPanel on drawing switch); light read only (Bracing panel x3); new drawing only (LinkMigration); jig previews; ribbon build. I spot-checked the Dimension restore (`DimensionCommands.cs:966-1004`: returns at U family before any write) and the Sheets side-database read (`CeSharedTitleMappingService.cs:238-260`): both match their reasons.

3. **Routes by your list.**
   - **Idle handlers:** DrawingAutoSave and FoundationMonitor wait (guarded). Status bar (`StatusBarIndicatorService.cs`), drawing-health scan (`MainPalette.xaml.cs:800-840`), settings warning (`SettingsService.LoadRecovery.cs:1211-1236`) touch no drawing in my reading. Ribbon build only creates buttons.
   - **CommandEnded / CommandWillStart:** all in the baseline; all skip U/UNDO/REDO/MREDO or fire only for named drafter commands.
   - **Deferred clean-ups:** the guard's own re-arm callbacks run only after the NEXT command finishes. Footing memory is forgotten after U in memory only.
   - **Autosave-time writes:** Structural's rolling backup waits (guarded). Job time is written only at QSAVE/SAVE/SAVEAS starts or ends (`Core/JobTime/JobTimeTracker.cs:464-490`). I can't say whether AutoCAD's own automatic save touches REDO; Codex never ran a U/REDO pair with automatic save on (see 4).
   - **Sheets palette Sync:** "Preview drawing updates" then "Update drawings" are buttons the drafter presses; a drafter's own edit ends REDO as normal. The automatic part (drawing switch) reads other drawing files only.
   - **C1 / TS1 / BT1 / R1 / beam / footing commands:** these are the drafter's own commands; nothing of theirs runs later on its own except the hooks above.
   - **Grips:** a click on a CE beam or footing grip queues one CE command started at the next Idle (`StructuralGripEditQueue.cs:99-143`, `FootingGripOverrule.cs:386-430`). Started by the drafter's click, so expected.

4. **What Codex HAS walked (U, wait 12 s, REDO), from the W39-W44 reports:**
   - **C1:** PASS W39-01 (1.0.109), W40-02 (1.0.109), W43-01 (1.0.110).
   - **Beam "1":** PASS W39-04 (1.0.109).
   - **BT1:** U and REDO echoes correct, W41-01 (1.0.109); the drawn truss was not fully seen (BLOCKED visual).
   - **CSREOBAR:** PASS W44-02 (1.0.110).
   - **FEDIT:** PASS W44-05 (1.0.110), size re-read 700x600 after REDO.
   - **Caveats on every walk:** automatic save was switched off (SAVETIME 0) for the whole run; beam linking was off ("Beam linking is switched off in Settings"; its default is off, `UserSettings.cs:431`, and Tim's file has `"LinkingEnabled": false`); no drawing was switched and no save was made between U and REDO.

5. **What Codex has NOT walked:**
   - **TS1** Undo/Redo (W39-03: "No U/REDO prescribed").
   - **R1** (W41-02, W44-01 stopped at object picks), **FSF** (no strip placed, W41-04, W44-03), **FPFC** (no U/REDO asked).
   - **Any grip edit** (beam or footing grip then U/REDO).
   - **Sheets "Update drawings"** then U/REDO; drawing switch A to B and back between U and REDO (palette refresh on switch).
   - **U then REDO with automatic save ON**, and U then QSAVE then REDO.
   - **Dimension commands** (restore hook), **REVCLOUD from CE's RC tool**, **bracing panel open** during U/REDO.
   - **Beam linking ON** (BeamLink command-end and follow hooks).
   - **"Wait after Undo" set above 0.**

6. **Blind spots of the safety test (my reading of the scanner, `RedoSafeCallGraphTests.cs:393-446`):**
   - **Async methods:** the body of an `async` method sits in a compiler-made step method reached only through .NET's own helper, which the scanner does not enter. So the two grip queues' `CommandAsync` starts are invisible to it (hence not in the baseline). Today both start only after a grip click. Any future automatic `async` path would pass the test unseen.
   - **Late-bound AutoCAD COM calls** (`dynamic`, e.g. `StartUndoMark` in `LegacyToolCommon.cs:440-500`, `CleanPipelineService.cs:668, 685`): invisible to the scanner. The ones I saw are inside drafter commands or the FST window.
   - **Delegates kept in a field and run later, reflection, code outside Structural and CE_SHARED:** stated by the test itself (`RedoSafeCallGraphTests.cs:28-29`).
   - **Open for write with a non-literal mode:** only a literal "ForWrite" is caught (`:382-389`).

7. **Verdict:** in my reading nothing in Structural 1.0.110 writes to the drawing between a U and the REDO. That is code reading plus five Codex walks, not proof in AutoCAD for the routes in 5.

---

## C. Settings and profile writes

1. **Structural: CS_Settings.json rewritten at every AutoCAD start when it gains new default rows.** `Modules/Structural/Services/SettingsService.cs:663-677` (start-up save, skipped when nothing changed), log line from `SettingsStartUpChange.cs:13-14`. **Seen today:** Codex W43-04, file 28,361 to 28,872 bytes at 06:00:39, 13 rows added, 0 values changed. **Not asked by the user.** Why: new versions add settings rows. Flag: start-up write.
2. **Structural: first start copies the old TIM_CE_CADTOOLS\CS_Settings.json into CE_STRUC_SUITE** (`SettingsService.cs:653-654`). Start-up, once.
3. **Structural: start-up save after every new version and when install paths change** (`Plugin.cs:152` then `InstallMetadataService.cs:83-118`, records the version shown and install paths). Flag: start-up write.
4. **Structural: start-up menu install** (`Plugin.cs:209, 216` then `WorkspaceMenuInstallerService.cs:76-78`): saves settings and writes CE's own CE STRUC menu file when the version or path changed. Main acad.cuix is deliberately not edited (`CuiMenuGeneratorService.cs:448-464`).
5. **Structural: diagnostics defaults** (`RuntimeDiagnosticsService.cs:104, 964-984`): saves only if that section is missing. Start-up, first run.
6. **Structural: start-up copy of blocks and DCL** into the shared assets folder, only files that are missing (`AssetDeployer.cs:36-68`, called `Plugin.cs:153`). Not a settings file; never overwrites.
7. **Structural: waffle hatch adds a folder to AutoCAD's support path for the command and puts it back** (`Commands/HatchCommands.cs:1218-1246`). Asked (hatch command). Risk: a crash mid-command could leave the extra path in the profile.
8. **Structural: OPENFIX admin command deletes AutoCAD's file-dialog registry keys for the current profile and sets FILEDIA / CMDDIA** (`AdminCommandService.cs:305-356`). Asked (admin command).
9. **Civil: first-run start-up save of CD_Settings.json** for the time-log folder (`CivilJobTimeSettings.cs:87-90`, reached from `CivilJobTimeService.cs:35` via the weekly-export check), which also creates `Time Logs` folders in the office Drafting folder (`:188-196`) and may write the weekly export to the office IT folder at start-up (`JobTimeWeeklyExportService.cs:45-50, 94, 121`). Flag: start-up write.
10. **Civil: start-up menu install after every new version** (`PluginInitialization.cs:498` then `WorkspaceMenuInstallerService.cs:110-112`, default on, `Models/UserSettings.cs:404`): saves CD_Settings.json and copies CE's own CE CVL menu file. acad.cuix deliberately not edited (`CuiMenuGeneratorService.cs:150`). Flag: start-up write.
11. **Civil: saves while working, not asked:** tip counters (`UsageTipService.cs:46`), faster-way advice counter (`FasterWayAdviceService.cs:43`), Start Here tour opened (`FirstRunTourService.cs:40`), draw-order settings tidied when first read (`LayerService.cs` `EnsureLayerOrderSettings`, saves at about lines 1128 and 1150 of that file).
12. **Civil: settings load does not write.** Migrations (pipe velocity, label height, LPD note, step irons) happen in memory only (`SettingsService.cs:145-200`); a routine save is skipped when nothing real changed (`:509-511`).
13. **Civil: registry write exists but is never called** (`OsnapService.cs:451-460, 516-521`, HKCU\SOFTWARE\TIM_CE_CADTOOLS; no caller of `SaveOsnapToEnvironment`).
14. **Manager:** start-up menu install of its own CE Manager menu (`Plugin.cs:106, 174`, `CeSuiteManagerMenuService.cs:473`); the administrator file only after "Set up CE administrator" (`CeAdminPolicyService.cs:104-168`).
15. **Codex's settings watch (W39 to W44):** CD_Settings.json and both CS_Settings.json files unchanged by every command walked; the only change was item 1 above at start-up.
16. **Observation, not checked:** Codex saw "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "...CE_SUITE_MANAGER_MENU:CE Manager" at start-up (W39). That reads like old workspace entries left in Tim's main menu file by earlier builds; since colleagues get Tim's exact setup, check before copying his profile.

---

## I did not check

1. Load order of Civil, Structural and Manager on a new PC (decides whether the first batch in item A7 reaches the office folder).
2. Whether any caller of `BlockService` attribute logging (A8) sets a title-block client or address attribute.
3. Structural's time-log folder and CSV columns (A4, Structural part).
4. Error and message boxes across all three modules, one by one (A11 is a sample).
5. Manager start-up writes beyond the menu install (C14), and `WhatsNewVersionGate` (`last_version.txt`).
6. AutoCAD's own behaviour: whether automatic save, a typed ZOOM or a drawing switch keeps REDO. Autodesk's internals are closed; only an AutoCAD walk can show it.
7. Any Civil Undo/Redo route (the controller owns that audit).
8. Anything in AutoCAD. No builds and no tests were run; the safety test's pass/fail on 9babe787 was not re-run by me.
9. Structural's LISP files and the CE.AutoCADLink / CE.Transform.Trial bundles.
