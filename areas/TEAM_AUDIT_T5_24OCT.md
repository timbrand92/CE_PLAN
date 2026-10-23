# TEAM AUDIT T5: release readiness for the 9 Nov colleague hand install (Sat 24 Oct 2026, Melbourne)

**Who and how.** Team Opus audit T5, desk plan/03, started 07:55 Melbourne by the PC clock. Read-only. I changed no code, built nothing, deployed nothing and did not start AutoCAD or Codex. This file is the only thing I wrote.

**What I read.**

1. **Code:** `origin/claude/rel-20261023m` at f7f7d551 (Civil 3.0.72 / Manager 1.1.72) and `origin/claude/rel-20261023s` at e6d597c0 (Structural 1.0.122). I read both in my own detached worktrees under `C:\ce-ta\`.
2. **The frozen candidate folder** `C:\ce_rc_scratch\c1058`. I read its file list and SHA-256 of the shared file only.
3. **The plan:** the colleague pack pages 02 and 06, the 9 Nov gap plan, recount 4 and the rollback guide.
4. **Known bugs:** `BUG_CARPARK.md` (to BUG-1087), the findings ledger, the Codex audits RD01 to RD22, the gate audit, and the Manager and compatibility hunts. A known problem is given by its number only.
5. **Three Opus sub-readers** traced the first start, Manager's background behaviour, and the per-year lanes. I re-read every finding below that is marked SURE myself before keeping it.

---

## ANSWER FIRST

1. **Counts.** I checked 30 must-be-true items. **6 MET, 14 NOT MET, 10 UNKNOWN.** I found **14 new findings**: 0 HIGH, 6 MEDIUM, 8 LOW. Nine are SURE (I traced them in the code) and five are UNSURE.
2. **Plain answer.** Copying the two folders into Max's own AutoCAD plug-ins folder needs no administrator rights. Nothing at start-up writes outside his own profile, apart from the shared office folders. That part of the route is sound.
   - What is not ready is everything around it.
   - **Never rehearsed:** the copy has never been done on a normal Windows login.
   - **Not sealed:** the package is not locked to the build that was tested.
   - **Unknowns about Max's PC:** his AutoCAD year, any old CE copies on it, and where his OneDrive puts the office folders.
3. **Top 3.**
   1. **An old CE copy in Max's all-users folder wins (NEW, MEDIUM, SURE).** Civil looks for its pit blocks in `C:\ProgramData\...\CE_CVL_SUITE.bundle` before it looks in Max's own new copy. If an old office install left Civil there, PIT and the fall symbols quietly insert the OLD blocks. Removing that copy needs an administrator.
   2. **The office folders may be somewhere else on Max's PC (NEW, MEDIUM, SURE in the code).** Manager also looks in OneDrive's own folder, but Civil looks only under `C:\Users\Max\Creative Engineering\`. If Max's OneDrive is laid out differently:
      - CDFEEDBACK saves on his PC only, so Tim never sees the reports.
      - CE Blocks shows a raw "Could not find a part of the path" message.
      - His job time never reaches the office.
   3. **The hand install has never been rehearsed (NOT MET), and the package is not sealed to the tested files (BUG-885).** Day one would be the first time it runs on a normal login.

---

## 1. Checklist: what must be true before Tim hands the package to Max

1. **The frozen candidate holds both bundles at the release numbers: MET.** In `C:\ce_rc_scratch\c1058`:
   - `CE_CVL_SUITE.bundle\PackageContents.xml` says AppVersion 3.0.72 (828 files, 159 MB).
   - `CE_SUITE_MANAGER.bundle\PackageContents.xml` says 1.1.72 (75 files).
2. **Civil and Manager carry the identical shared file in all three lanes: MET.** In c1058, `CE_SHARED.dll` has the same SHA-256 in both bundles:
   - Legacy: 81f7beb6...
   - Net8: bbc990d9...
   - Modern: d952709b...
3. **Every AutoCAD year from 2022 to 2027 is sent to a lane that exists: MET.**
   - **Manifests:** Civil `Installer/PackageContents.xml:18, 78, 138`; Manager `Modules/Manager/Installer/PackageContents.xml:11, 34, 57`.
   - **Routing:** R24.1–R24.9 goes to Legacy, R25.0–R25.9 to Net8, and R26.0–R27.0 to Modern.
   - **Folders:** all three lane folders are present in c1058.
4. **The hand copy needs no administrator rights: MET (by reading).**
   - **Where it goes:** the target is `%APPDATA%\Autodesk\ApplicationPlugins`.
   - **What start-up writes:** in a Release build, nothing at start-up writes to `C:\`, ProgramData, Program Files or HKLM. `BlockService.cs:117-121` searches `C:\Lisp Files` only in debug builds.
5. **A colleague can run the installer program himself: NOT MET.** `Installer/app.manifest:7` demands administrator rights (BUG-882), and there is no first-install route (BUG-883). The plan cuts this for 9 Nov.
6. **The delivered files are the tested files, sealed: NOT MET.** BUG-885. Recount 4 says the seal (#1649) is built but not installed.
7. **The hand install has been rehearsed twice on a standard Windows login: NOT MET.** Recount 4 section 6 says "no rehearsal recorded". The Windows Sandbox harness exists, but the Sandbox feature has not been switched on (`CODEX_BUILD_SANDBOX_INSTALL_22OCT.md`).
8. **Max's AutoCAD year is known: UNKNOWN.** Colleague pack page 06, question 2.
9. **Max's AutoCAD year has been driven with this build: UNKNOWN.**
   - **2027:** driven on Tim's PC.
   - **2022 to 2026:** I found no AutoCAD record on 3.0.72.
   - **Known gaps on the older lanes:** F-026 and RD21-01 to 06.
10. **No old CE bundle is in Max's ProgramData or Program Files plug-in folders: UNKNOWN.** Page 06, question 4. This matters more than the pack says (finding 1).
11. **Max's old July Structural (1.0.41) is dealt with: UNKNOWN.** Page 06, question 3. See finding 5.
12. **We know whether AutoCAD asks "Load / Always Load" for CE in `%APPDATA%`: UNKNOWN.**
    - The pack marks this [CHECK].
    - The installer sets SECURELOAD and installs WebView2 (`Installer/Program.cs:114-115`); a hand copy does neither.
    - What AutoCAD does is UNVERIFIED.
13. **Max's office folders sit where Civil looks for them: UNKNOWN.** See finding 2.
14. **Max's starting switches equal Tim's: NOT MET.** F-023: no approved colleague-defaults export exists. Copying Tim's file as it stands also carries his folder paths (finding 3).
15. **Nothing personal leaves Max's PC or lands in the office folder without him knowing: NOT MET.**
    - **Fine:** nothing goes to the internet. AI needs a key Max does not have, and the cloud heartbeat is queued but not sent (`TelemetryQueueService.cs:135-137`).
    - **Open:** the time logs and the weekly export with job addresses, written to the shared Drafting folder from his first start (BUG-492, Tim's call), and the diagnostics route (BUG-488).
16. **No automatic update can change Max's installed bundles: MET (by reading).**
    - **Nothing calls it:** the finish-update code has no caller (`CeFinishUpdatePlanner`).
    - **Staging is fenced:** it refuses any AutoCAD plug-in folder (`CeUpdateStagingService.cs:312-316`) and needs a signed release (`:279-285`).
17. **Update and Roll Back buttons are hidden from a colleague: NOT MET.** BUG-477, BUG-948, BUG-478. Page 02 tells Max not to press them.
18. **Rollback is written and rehearsed: NOT MET.** It is written (page 02 section 7, `ROLLBACK_GUIDE_2026-10-07.md`) but never rehearsed on a colleague-type login.
19. **The rollback backup covers every CE settings folder: NOT MET.** See finding 9.
20. **A colleague has an uninstall route: NOT MET.** BUG-888. The only route is renaming folders by hand.
21. **Manager ignores the `.backup` folders: MET (by reading).**
    - Every live scan looks only for names ending `.bundle` (`CePluginRegistryService.cs:41`, `CeHealthChecks.cs:63`, `CeDiagnosticsService.cs:121`).
    - Whether AutoCAD itself ignores them is UNVERIFIED.
22. **First start on a fresh profile gives a clean CE log: UNKNOWN.** Never run (gap plan 3.11).
23. **CEHEALTH and the version line tell the truth: NOT MET.**
    - CEHEALTH can call an unloaded Civil "OK" (MGR-01, in the carpark).
    - The status bar says "[Modern]" on 2025/2026 (finding 8).
24. **CDFEEDBACK reports reach Tim: UNKNOWN.** Page 06 question 11 (folder sharing), plus finding 2.
25. **The three engineering HIGHs are fixed or carry a warning: NOT MET.**
    - HIGH 1 is installed (#1530).
    - HIGH 2 is in C-63, not installed.
    - HIGH 3 has no PR (recount 4 section 6).
26. **At least 30 of the 40 daily-tool checks are accepted: NOT MET.** 1 of 40 (recount 4).
27. **The known-problems page is final: NOT MET.** Still the 22 Oct draft.
28. **Where the frozen release copy sits is decided: UNKNOWN.** Page 06 question 5 (that is publishing, so it is Tim's call).
29. **The old July install scripts are out of the IT Admin folder: UNKNOWN.** BUG-483, page 06 question 6.
30. **Tim's word "yes, hand it to Max": NOT MET.** Due Fri 6 Nov.

---

## 2. New findings, ranked (14)

1. **An old Civil bundle in the all-users folder supplies the pit blocks. MEDIUM, SURE.**
   - **File:** `Modules/Drainage/Services/BlockService.cs:101-108`. The block search order is ProgramData first, then Program Files, then the user's own `%APPDATA%` copy.
   - **What the drafter sees:** say Max once had Civil installed for all users by the old office installer, and the hand copy cannot remove that copy without an administrator. On a job, PIT drops the old office pit block and old fall symbols from that stale copy, not the 3.0.72 blocks. No warning appears; the pit just looks like last year's.
   - **Extra:** the fallback `assemblyDir\Blocks` (line 109) points at `Contents\Win64\<lane>\Blocks`, which never exists. A bundle copied anywhere else finds no blocks at all.
   - **Smallest fix:** search the running bundle's own `Contents\Blocks` first (`RuntimePathService.GetBundleRoot()`). Until then, an administrator checks and clears `C:\ProgramData\Autodesk\ApplicationPlugins` and `C:\Program Files\Autodesk\ApplicationPlugins` before 9 Nov.
   - **Related:** BUG-483 (stale ProgramData copies) is known; the block order is new.

2. **Civil and Manager look for the office folders in different places. MEDIUM, SURE in the code; Max's OneDrive layout UNSURE.**
   - **Where each looks:**
     - Manager checks the OneDrive folder variable first (`Modules/Manager/Services/CePluginInstallerService.cs:56-78`).
     - Civil and CE Blocks look only under `%USERPROFILE%\Creative Engineering\...`: `FeedbackService.cs:63`, `CivilJobTimeSettings.cs:134, 166-168`, `UserSettings.cs:1392, 1417`, `CeBlocksSettings.cs:29`.
   - **What Max sees,** if his folders arrived through "Add shortcut to My files" (under `OneDrive - ...`) instead of "Sync":
     - Manager works.
     - CDFEEDBACK says "saved on this PC" every time.
     - CE Blocks shows "palette files are unavailable: Could not find a part of the path 'C:\Users\...'" (`CeBlocksPaletteService.cs:24-27`).
     - CDNEWDWG cannot find the templates.
     - CDWT loses its tank window.
   - **Smallest fix:** one shared office-folder lookup used by both, and plain wording in CE Blocks. Before 9 Nov: look at where Max's OneDrive puts "Creative Engineering - Drafting".

3. **Settings save office folders as fixed full paths, so copying Tim's settings carries his paths. MEDIUM, SURE.**
   - **File:** `Modules/Drainage/Models/UserSettings.cs:1375, 1383, 1408`. Every value is written out (`SettingsService.cs:717`, no "skip defaults" option). So Tim's file holds `C:\Users\TimothyBrand\Creative Engineering\...\Standard Details\Civil`, the same for Drawings Templates, and `C:\Lisp Files\Computations`. The job-time folder is saved the same way (`CivilJobTimeSettings.cs:84-88`).
   - **What Max sees:** if the desk gives Max "your working switches" by copying Tim's settings file:
     - CDWT finds no tank master and silently drops to command-line questions.
     - CDNEWDWG finds no templates.
     - Max's time logs aim at Tim's profile path and fail.
   - **Smallest fix:** blank every folder path in the copy so each PC works out its own. Better: store paths relative to the office root. This sits next to F-023 (switch values) but is a separate fault.

4. **The job-time folder is fixed on the first start. MEDIUM, SURE.**
   - **File:** `Modules/Drainage/Services/CivilJobTimeSettings.cs:84-88`. The first folder found is saved for good.
   - **What happens:**
     - If OneDrive has not finished syncing "Creative Engineering - Drafting" when Max first opens AutoCAD on 9 Nov, his time goes to `%APPDATA%\CE_CVL_SUITE` from then on and never reaches the office.
     - If he only has read access to Drafting, every write fails into the log only (`JobTimeCsvLogger.cs:55-58`).
   - **Smallest fix:** save the folder only when a person picks it; otherwise detect it again at each start. Hand-install step: confirm OneDrive shows Drafting fully synced before the first AutoCAD start.

5. **Max's old July Structural may carry an older shared file with the same version number. MEDIUM, UNSURE.**
   - **History:** Structural shipped its own CE_SHARED, also labelled 1.1.0.0, from 23 Jul (commit 811d3457) until 25 Aug (commit 5ceb01d7; today's guard is `Modules/Structural/CE_STRUC_SUITE.csproj:159-162, 368-380`).
   - **The mismatch:** that old copy has 9 service files. Civil 3.0.72 needs `CeRuntimePaths` (`Modules/Drainage/Services/RuntimePathService.cs:15-16`), which the old copy lacks.
   - **What could happen:** if Max's July 1.0.41 is from that window and AutoCAD loads it first, Civil would break wherever it looks up its own files: help, linetypes, the config lists. The result would be "command failed" lines on the first job. Load order and "first copy wins" are UNVERIFIED AutoCAD/.NET behaviour.
   - **Smallest fix:** read the AppVersion and date of Max's Structural bundle before 9 Nov. If it holds a `CE_SHARED.dll`, switch it off or move it aside before the first start. This is not BUG-887, which is about Civil and Manager.

6. **Going back restores an old Manager that may stage updates by itself. MEDIUM, UNSURE.**
   - **The old code:** a Manager from before 22 Jul (`c5250a11`, `Modules/Manager/Services/CeApprovedReleaseService.cs:220-251`) waits 15 seconds after start, reads the office approval file without a signature check, and calls `InstallOrUpdate(available, null)`. On a "fresh install" that path writes to `C:\ProgramData\Autodesk\ApplicationPlugins` (old `CePluginInstallerService.cs:244-253`).
   - **What might happen:** after a rollback the old Manager may try to put 3.0.72 back by itself, or fail quietly on a standard login.
   - **Why UNSURE:** BUG-165 records the same loop on Tim's PC "observed to change nothing". Which Manager Max has today is not recorded.
   - **Smallest fix:** record Max's current Manager version before 9 Nov. If it is older than 22 Jul, the rollback steps restore the old Civil and Manager, then check ProgramData for a new CE folder after the next start.

7. **Civil's reports to Tim never arrive and pile up on Max's PC. LOW, SURE.**
   - **The two folders:**
     - Civil writes its admin records to `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox` (`Shared/CE_SHARED/Services/CeTelemetryStore.cs:60-65`).
     - Manager uploads only `%APPDATA%\CE_CADTOOLS\CE_Admin\outbox` (`Modules/Manager/Services/CeAdminStorageService.cs:33, 151`).
   - **Why they part:** Manager moves the old folder once (`:37-40`), and Civil then recreates it.
   - **Result:** Tim's admin view never shows Max's Civil failures. Files carrying drawing names (`AdminTelemetryService.cs:259, 403`) build up in his profile with no clean-up.
   - **Smallest fix:** point Civil at `CeAppDataPaths` (`CE_CADTOOLS`), or have Manager upload both folders.

8. **On AutoCAD 2025/2026 the status bar says "[Modern]". LOW, SURE.**
   - **File:** `Modules/Drainage/PluginInitialization.cs:28-33` and `Modules/Manager/Plugin.cs:27-31` use one test that is true for both Net8 and Net10.
   - **Example:** Max reads "CE CVL SUITE v3.0.72 [Modern]" over the phone, and Tim assumes 2027 when Max is on 2026. A 2027-only tool then looks like a fault.
   - **Smallest fix:** three labels (Legacy, Net8, Modern). Until then, ask Max for his AutoCAD year as well.

9. **The pack's backup step saves only 2 of the CE settings folders. LOW, SURE.**
   - **Page 02 step 4 copies:** `%APPDATA%\TIM_CE_CADTOOLS` and `%APPDATA%\CE_CVL_SUITE`.
   - **What 1.1.72 also writes:**
     - `%APPDATA%\CE_CADTOOLS` (Manager storage and menu, `CeAdminStorageService.cs:33`, `CeSuiteManagerMenuService.cs:137`)
     - `%APPDATA%\Creative Engineering\CE Suite Manager` (CE Blocks, `CeBlocksSettings.cs:35`)
     - `%APPDATA%\CE_SUITE_MANAGER\logs` (`CommandOutcomeInfoLog.cs:12`)
   - **Effect on rollback:** these stay behind. The CE Manager pull-down menu may also stay loaded with no commands behind it (UNSURE; whether AutoCAD remembers it is UNVERIFIED).
   - **Smallest fix:** add the three folders to step 4, and add "MENULOAD, unload CE_SUITE_MANAGER_MENU" to the rollback.

10. **CDWT skips its window without saying why. LOW, SURE.**
    - **File:** `Modules/Drainage/Commands/WaterTankCommand.cs:90-91`.
    - **What happens:** with the Standard Details folder missing (finding 2 or 3), the tank picture window never opens. The command line asks the old questions with no reason given.
    - **Smallest fix:** one line, "Tank pictures not shown: Standard Details folder not found at <path>."

11. **Leftover wording points at Tim's own folders. LOW, SURE.**
    - **CDSL:** tells the drafter to put a missing block in "C:\Lisp Files" (`SpotLevelCommand.cs:63`); Release builds never look there.
    - **CDHELP:** shows "C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE" (`CdHelpDialog.xaml.cs:41`).
    - **CDTRENCHGRATEAUDIT:** is fixed to `C:\Lisp Files\TRENCH GRATE.dwg` (`LinkCommands.cs:755`).
    - **Harmless:** the last-resort linetype drawing in Tim's profile (`LayerService.cs:262`). Every linetype CE asks for is in acad.lin or the shipped `CE_CIVIL.lin`.
    - **Smallest fix:** change the wording, and point the audit at the bundle's Blocks folder.

12. **Delivering the package as a downloaded zip can block a helper. LOW, UNSURE.**
    - **File:** `Modules/Drainage/Services/XcivilScheduleService.cs:247-276` runs `Tools\Extract-XcivilPdfSchedule.ps1` with RemoteSigned.
    - **What could happen:** if the bundle comes by email or Teams zip, Windows marks it as downloaded. The PDF pit-schedule part of CDIMPORTXCIVIL would then fail quietly. Whether a marked DLL loads on 2022–2024 is UNVERIFIED.
    - **Smallest fix:** copy from USB or the synced pilot folder, never a downloaded zip. Or Unblock the zip before extracting.

13. **The weekly time export can run during Max's AutoCAD start. LOW, UNSURE.**
    - **File:** `Modules/Drainage/Services/JobTimeWeeklyExportService.cs:26-55`. If the shared marker is more than 6 days old, Max's start reads every person's time log and writes the office export.
    - **Effect:** a slower first start (by how much is UNVERIFIED), and Max's AutoCAD becomes the one that publishes everyone's week. The privacy side is BUG-492 (Tim's call). The new part is that there is no switch to turn the timer off (`UserSettings.cs:258-287`).
    - **Smallest fix:** a `jobTime.enabled` switch, and the export on a background thread.

14. **A shared-file mismatch tells a colleague to "run the CE installer again". LOW, UNSURE.**
    - **File:** `Modules/Manager/Services/CeSharedCopyCheck.cs:33-35`, printed at `Plugin.cs:186`.
    - **What happens:** if an older CE plugin loads first, Max is told to run an installer he does not have.
    - **Smallest fix:** "ask your CE administrator" when the user is not the administrator. This sits in the BUG-522 family.

**Known problems met on the way (numbers only):** BUG-165, 240 (the code behind it is gone at this commit), 354, 402, 476, 477, 478, 483, 486, 487, 488, 492, 522, 528, 832, 834, 853, 882, 883, 884, 885, 886, 887, 888, 948, 1064, 1065, 1066; F-023, F-025, F-026; MGR-01, MGR-02, MGR-03; RD13-01, RD20-01, RD20-02, RD21-01 to 06; COMPAT-01 to 03.

---

## 3. Top ten risks, in plain English, with a real example

1. **The install has never been done on a normal login.**
   - **Example:** on 9 Nov, AutoCAD on Max's PC asks "Load / Always Load" for every CE file, or loads nothing. Nobody has seen which.
   - **Fix:** two rehearsals on a spare standard login before Fri 30 Oct.
2. **Old CE copies on Max's PC beat the new one.**
   - **Example:** a pit placed on his first job uses last year's block from an all-users copy he cannot delete. Or an old Structural's shared file loads first, and CDHELP or the linetype lookups fail.
   - **Fix:** an administrator looks at Max's ProgramData, Program Files and Structural folders the week before.
3. **Max's AutoCAD year is unknown.**
   - **Example:** if he is on 2024, nothing on this build has been driven in that year. Tim's one-piece pipes need the 2027-only object file, and downpipes cannot be placed straight on a pit (RD21-01).
4. **What Max gets may not be what was tested.**
   - **Example:** the packaging script rebuilds files instead of sealing the tested ones (BUG-885). The desk must copy the frozen c-folder and read every hash back.
5. **Max's office folders may sit somewhere else.**
   - **Example:** every CDFEEDBACK he sends says "saved on this PC", and Tim hears about no bugs in the first week.
6. **Max's settings will not match Tim's.**
   - **Example:** copying Tim's file gives Max Tim's folder paths, so CDWT loses its window. Not copying gives him factory switches, so tools Tim uses daily behave differently (F-023).
7. **Wrong engineering numbers on a drawing.**
   - **Example:** concrete pipes still sized as UPVC by the network solver (HIGH 2, not installed). The rainfall note still says the office curve reads high (HIGH 3, no PR).
8. **Privacy.**
   - **Example:** from his first start, Max's Windows login, job addresses and client names go into the shared Drafting time logs, and he cannot turn it off (BUG-492, Tim's call).
9. **Going back is untested and partial.**
   - **Example:** a rollback leaves three Manager folders and a dead menu behind (finding 9), may restore an old Manager that stages updates by itself (finding 6), and has no uninstall (BUG-888).
10. **Manager shows buttons Max must not press.**
    - **Example:** "CE Civil Suite X is ready to install - close AutoCAD, then ask your CE administrator" appears when Tim approves something newer. Updates & Rollback refuses him (BUG-948), and Roll Back is live (BUG-477).
    - **Related:** acceptance is 1 of 40 daily tools (recount 4).

---

## 4. What I did NOT check

1. **No live runs.** No AutoCAD session, install, rollback, build, test run or Sandbox run. Every finding is from reading.
2. **Installed bundles.** I did not read Tim's installed bundles, settings files or logs. One sub-reader listed the folder names in Tim's `%APPDATA%\Autodesk\ApplicationPlugins` (names only, no file opened, nothing changed), against the brief. Said here so it is on record.
3. **The candidate as a whole.** I did not compare c1058 with the installed bundle, and checked hashes for `CE_SHARED.dll` only.
4. **Autodesk behaviour, all UNVERIFIED.** Whether AutoCAD trusts `%APPDATA%\Autodesk\ApplicationPlugins` without a prompt, ignores `.backup` folders, or which of two same-named shared files loads first.
5. **Max's PC.** Nothing on it was seen: AutoCAD year, old CE copies, OneDrive layout, company Windows protection, network or roaming profile.
6. **The July Structural.** Its contents (1.0.41) were not read. Finding 5 rests on repository history only.
7. **Help pages and wording.** I did not review the Help pages or window wording beyond the lines quoted.

---

## Summary (under 100 words)

The hand copy into Max's own plug-ins folder needs no administrator, and nothing at start-up writes outside his profile except the office folders. Checklist: 6 MET, 14 NOT MET, 10 UNKNOWN. 14 new findings (0 HIGH, 6 MEDIUM, 8 LOW). Worst: an old all-users CE copy supplies the pit blocks first, and Civil looks for the office folders in only one place, so feedback and time logs may never reach Tim. The install is unrehearsed, the package is unsealed, and Max's AutoCAD year and old CE copies are unknown. Check Max's PC the week before.
