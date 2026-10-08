# Bug hunt: Manager and the colleague install, 9 Oct 2026

Helper: CE_ACAD / release-v3-colleagues / hunt_mgr / run 1 (MAX account, Opus, read-only). Started 08:40, written 08:54 (PC clock, Melbourne). Nothing was built, installed or run in AutoCAD. Every finding is from reading code, the office folder and the installed files on Tim's PC. **Draft IDs only (HUNT-M-xx). The controller files them in BUG_CARPARK.md.**

---

## Read this first (for Tim)

1. **Biggest risk on colleague install day: anyone can make themselves the CE administrator.** There is no administrator list anywhere yet, not even on your PC. Every colleague's CE Manager window shows an "Admin Dashboard" button that offers to make them the office administrator. The first person to click Yes takes the role for the whole office, and you lose it. Fix before colleagues install: you set yourself up first (HUNT-M-01).
2. **"Use the approved installer" does not exist for a colleague.** Every update message ends with it, but nothing a colleague can click runs it. Updates through Manager can never finish (HUNT-M-03).
3. **The status line will say a Structural update is approved when it is not.** An April approval of Structural "1.0.117.0001" counts as newer than today's 1.0.110 (HUNT-M-04).
4. **Manager switches AutoCAD's classic menu bar back on at every start.** So DAY1's sentence "CE never edits your AutoCAD profile" is not safe to give colleagues (HUNT-M-06).
5. **The office folder still holds the old install files and old builds** (Civil 2.1.14, Structural 1.0.41, Manager 1.0.0). "Install-All-CE-Plugins.ps1" needs administrator rights and ends with "Future updates install automatically", which is untrue (HUNT-M-08).

---

## What was read

1. **Installed now (read from the program files at 08:50):** Civil 3.0.41+660487d1, Manager 1.1.41+660487d1 (installed 08:37 to 08:38 today), Structural 1.0.110+9babe787. **The job named 3.0.40 / 1.1.40 (1200744d) as installed: that is out of date by about 15 minutes.** I compared the two: Manager and installer code at 660487d1 is the same as at 1200744d except the version stamps, so every Manager finding below applies to what is installed now and to the next build (rel-20261009g).
2. **Code read:** all of `Modules/Manager` (services, windows, commands), `Installer/` (the closed-AutoCAD installer: `Program.cs`, `CeInstallerApplication.cs`, `SafeBundleInstaller.cs`, the two retired PowerShell files), and Civil's What's New files.
3. **Office folder read (read only):** the install scripts in `Creative Engineering - IT Admin` and its sub-folders, the bundle versions there, `CE Plugin Admin\releases\*\approved.json` and the policies folder. Tim's own `%APPDATA%` CE folders: admin list and staging folder (lengths and counts only).
4. **Skipped as already in BUG_CARPARK.md:** everything in BUG-425 (source audit 2: S2-001 to S2-025), BUG-441, BUG-452, BUG-455 and BUG-170. Those still true at 1.1.41 are listed at the end.

---

## The 15 findings, most valuable first

1. **HUNT-M-01 (HIGH). No administrator list exists, so the first colleague to click "Admin Dashboard" becomes the office administrator and Tim is locked out.**
   - **What a colleague meets:** the CE Manager window (CEMANAGER) shows an "Admin Dashboard" button. Clicking it asks "Set up CE administrator - make this Windows account the office administrator?". Yes writes their Windows name into the shared office folder as THE administrator.
   - **The drive shows (08:50):** `CE Plugin Admin\policies\admin-users.json` does not exist in the office folder, and `%APPDATA%\CE_CADTOOLS\CE_Admin\policies\admin-users.json` does not exist on Tim's PC either.
   - **The code shows:** with no list anywhere, every PC gets "needs setup" and the button (`CeAdminPolicyService.cs:55-69`, `PluginManagerWindow.xaml.cs:60-61` and `:796-818`). When the office folder can be reached, the seed writes the SHARED list (`CeAdminPolicyService.cs:138-149`). Once a shared list exists it wins over any list on Tim's PC (`:47-50`), so Tim is no longer an administrator and his button disappears. There is no "add administrator" control anywhere in Manager (searched), yet three messages tell people to "ask an existing administrator to add you (Manager, Policies tab)" (`CeAdminPolicyService.cs:124-125`, `PluginAdminWindow.xaml.cs:157-158`, `PluginManagerCommands.cs:142-144`). Getting Tim back would mean editing the office file by hand.
   - **What the new administrator can then do:** Approve, Roll Back, Canary and Promote to All (HUNT-M-02).
   - **I think:** a colleague may not be able to write to the office folder (it depends on their SharePoint rights, which I cannot see). If they cannot, the seed falls back to "administrator on this PC only" (`:158-169`), whose message is jargon ("other machines are not protected from the fallback yet").
   - **Cure:** Tim runs "Set up CE administrator" on his own PC first, with the office folder synced, and checks the shared file exists. Team: hide the button on any PC whose user is not already known, and build a real "add an administrator" control or reword the three messages.
   - **Test (Codex, on a test Windows account, never Tim's):** open CEMANAGER and check whether "Admin Dashboard" shows. After Tim seeds, check it is gone for the test account.

2. **HUNT-M-02 (MEDIUM). Roll Back is still offered, live, with no switch to hide it.**
   - **What an administrator meets:** CEMANAGERADMIN > Updates tab > "Roll Back Approved Release" is a normal working button (`PluginAdminWindow.xaml:236-239`, handler `PluginAdminWindow.xaml.cs:216-246`). It asks "are you sure", then writes a "Rolled Back" record that every PC acts on at its next start (`CeApprovedReleaseService.cs:394-441`, `:498-611`).
   - **Why it matters:** DAY1 gap 3 and BUG-441 say do not offer it until one PC proves the installer accepts an older version. The job brief says it must not be offered. The only protection is the administrator list, and there is none yet (HUNT-M-01). Its messages also end "then needs AutoCAD closed and the approved installer run", which a colleague cannot do (HUNT-M-03).
   - **Cure:** a Settings switch "Show Roll Back" defaulting OFF, button hidden while off (R-27: hide, do not block).
   - **Test:** open CEMANAGERADMIN > Updates and check the Roll Back button is not there.

3. **HUNT-M-03 (HIGH for the update channel). "Close AutoCAD, then use the approved installer" cannot be done by a colleague.**
   - **What a colleague meets:** after "Get update ready", and on the status line, CE says "ready to install - close AutoCAD, then use the approved installer" or "run the CE installer to finish it" (`CeReleaseStatusService.cs:70,79,116,134`, `CePluginDescriptor.cs:309,315`, `PluginManagerWindow.xaml.cs:616,673,682`).
   - **The code shows:** the only installer that finishes a staged update is `CE_CVL_SUITE_Installer.exe`, and it runs only when given four folder paths on its command line (`CeInstallerApplication.cs:82-89`). Double-clicked, it stops with "No installer operation was supplied." Nothing in Manager starts it (searched: no caller anywhere in the repo besides its tests). The two PowerShell files in `Installer/` are retired and exit with "RETIRED ... cannot install CE".
   - **What happens on a job:** the update is copied into `%APPDATA%\CE_CADTOOLS\CE_Admin\update-staging` and sits there for ever. The amber status stays. The office install scripts (HUNT-M-08) install whatever bundle sits in the office folder, not the staged copy.
   - **Cure (Team, needs Tim's word on the route):** either a "Finish update" step that starts the installer with the right folders after AutoCAD closes, or reword every message to name the real route (the deploy chat's install script) until then.
   - **Test:** approve a test build, click Get update ready, close AutoCAD, and follow the on-screen words exactly. Record where they fail.

4. **HUNT-M-04 (MEDIUM). An April Structural approval makes CE say a newer Structural is approved, and the button then refuses in jargon.**
   - **The drive shows:** `CE Plugin Admin\releases\CE_STRUC_SUITE\approved.json` approves "1.0.117.0001" (28 Apr 2026), with no signed-content fingerprint in it. Installed Structural is 1.0.110.
   - **The code shows:** the version compare reads 1.0.117 as newer than 1.0.110 (`CePluginInstallerService.cs:148-162`; the BUG-165 guard only catches year-style numbers). The status line does not check the approval is valid before saying "New version approved: CE Structural Suite 1.0.117.0001 - in CE Suite Manager click Get update ready ..." (`CeReleaseStatusService.cs:119-135`). Get update ready then fails with "This approval predates exact signed-content verification. Approve the candidate again." (`CeApprovedReleaseService.cs:690-691`).
   - **I think:** every PC with Structural and the office folder synced shows this amber line on the 2025 to 2027 ribbon (it is not drawn on 2022 to 2024). I have not seen the ribbon myself.
   - **Cure:** the administrator removes or replaces the April Structural approval (office file; Tim's call). Team: count only approvals that pass the signed check, and say "this approval is out of date, ask the office" in plain words.
   - **Test:** open CEMANAGER on a PC with Structural 1.0.110 and read the status line and the Structural row.

5. **HUNT-M-05 (MEDIUM). The status line says "CE is current." when the office folder cannot be reached at all.**
   - **The code shows:** when the office folder is missing, no approvals are read (`CeApprovedReleaseService.cs:33`) and the status falls through to "CE is current." (`CeReleaseStatusService.cs:138`). CEHEALTH does warn about the folder; the status line does not.
   - **What happens on a job:** a colleague working at home without OneDrive, or whose office folder synced under a different name (Manager only looks in two places, `CePluginInstallerService.cs:46-71`), sees a green "current" for months while the office has moved on.
   - **Cure:** say "CE cannot see the office folder, so it cannot tell if you are up to date" instead.
   - **Test:** rename the office folder on a test account, restart, read the status line.

6. **HUNT-M-06 (MEDIUM). Manager turns AutoCAD's classic menu bar on, and loads its own menu, at every AutoCAD start.**
   - **The code shows:** at start-up Manager loads `CE_SUITE_MANAGER_MENU.cuix` into AutoCAD (`Plugin.cs:172-175` to `CeSuiteManagerMenuService.cs:765-791`), reloads every menu, and sets MENUBAR to 1 whenever it is not 1 (`:794-799`). The generated menu also carries "CE Manager" toolbars marked to show (`:572-576`).
   - **What a colleague meets:** someone who turned the menu bar off finds it back on at every start. **I think** the loaded menu is also what keeps the "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" start-up line (BUG-435) in the profile, and whether the toolbars appear depends on their workspace (not seen).
   - **So:** DAY1's "CE never edits your AutoCAD profile or acad.cuix on its own" is not safe to tell colleagues while this runs.
   - **Cure:** stop changing MENUBAR (Settings switch, default OFF), and decide whether the old Manager menu is needed at all now the ribbon exists.
   - **Test:** set MENUBAR to 0, restart AutoCAD, type MENUBAR and read the value.

7. **HUNT-M-07 (MEDIUM). CESUPPORT says the zip "has not been sent anywhere", but on Tim's PC the Desktop is inside OneDrive.**
   - **The drive shows:** Tim's Desktop is `...\OneDrive - Creative Engineering\Desktop`, and the "CE Support" folder is there.
   - **The code shows:** the zip goes to the Desktop "CE Support" folder (`CeSupportBundleService.cs:53-55`), and the message and the notes inside say "Support file saved on this PC ... It has not been sent anywhere" (`:93-96`, `:170`).
   - **What happens:** the zip is copied to Microsoft's OneDrive cloud for that user as soon as it is made. It stays in the company account and is scrubbed, so this is a truth problem more than a leak, but the sentence is untrue. Colleagues with the office's OneDrive setup will likely be the same (not checked on their PCs).
   - **Cure:** save to a local CE folder (for example `%LOCALAPPDATA%\CE Support`) and open it, or say "saved to your Desktop (OneDrive may copy it to your account)".
   - **Test:** run CESUPPORT and check the folder it names against where OneDrive syncs.

8. **HUNT-M-08 (MEDIUM). The install files in the office folder install old builds, need administrator rights and promise automatic updates.**
   - **The drive shows (read only):** `Install-All-CE-Plugins.ps1` in the office folder root installs Manager, Structural and Civil into `C:\ProgramData\Autodesk\ApplicationPlugins` and asks for administrator rights (lines 26-36). It ends "Future updates install automatically when you open AutoCAD." (line 150). `CE SUITE MANAGER\Install-CESuiteManager.ps1` also asks for administrator rights and writes ProgramData (lines 19-32), and says "Future CE plugin updates will install automatically ... no action required." (lines 94-95). The bundles beside them are Civil 2.1.14, Structural 1.0.41 and Manager 1.0.0. The Civil script installs per user instead (`%APPDATA%`).
   - **What a colleague meets:** a PC with no administrator rights cannot install Manager this way at all. A pilot colleague who later runs "Install-All" gets old copies in ProgramData beside their 3.0 copies in `%APPDATA%`. Manager prefers the ProgramData copy when it lists tools (`CePluginRegistryService.cs:56-58`), so it would report the old version. **I think** AutoCAD would then load both copies (not tested).
   - **Also:** the Civil and Install-All scripts write `install-metadata.json` with the real Windows name and computer name into the bundle (lines 88-97 and 111-120), at a place Manager never reads (`Contents\config\install-metadata.json`, `CePluginRegistryService.cs:395`).
   - **Plan text is wrong:** `areas/release-v3-colleagues.md` line 187 says these scripts copy into the user's plugin folder; for Manager and Install-All they copy into ProgramData.
   - **Already known, not counted:** delete-then-copy with no backup and no AutoCAD check (area file line 232, ROLLBACK_GUIDE line 212).
   - **Cure (Tim's call, it is publishing):** move the old scripts and builds into an "OLD - do not use" sub-folder, and put one plain "how to install" note beside the real pilot package.
   - **Test:** list the office folder root and check no runnable install script remains there.

9. **HUNT-M-09 (MEDIUM). CEHEALTH says "All checks passed" without checking Manager, the Civil and Manager pair, or two copies of one tool.**
   - **The code shows:** CEHEALTH walks the tool list, which leaves Manager out on purpose (`CePluginRegistryService.cs:52-54`), so Manager never gets a line (W45's output shows no Manager line). It never compares the Civil and Manager versions, although they must ship the same shared file (memory rule "CE_SHARED is one assembly identity"; INT-069 item 11). It keeps only the first copy of each tool it finds (`:56-58`), so a second copy is never reported (`PluginManagerCommands.cs:176-222`).
   - **What happens on a job:** a colleague with Civil 3.0.41 and an older Manager gets "All checks passed" while the shared file may be the wrong one.
   - **Cure:** add a Manager line, a "Civil and Manager are a matching pair" line, and a "two copies found" warning.
   - **Test:** CEHEALTH on Tim's PC shows a Manager line and a pair line.

10. **HUNT-M-10 (MEDIUM, not proven in AutoCAD). Refresh and "Send waiting reports" copy into the office folder with nothing to catch an error.**
    - **The code shows:** the Manager window's Refresh and "Send waiting reports" buttons, and the admin window's Refresh and "Upload pending" buttons, call the office-folder copy directly with no error catch (`PluginManagerWindow.xaml.cs:502-508`, `:760-764`; `PluginAdminWindow.xaml.cs:137-142`, `:165-167`). The copy loop stops on the first failure (`CeAdminStorageService.cs:159-163`).
    - **When it bites:** a colleague whose office folder is read-only for them, or a file OneDrive is holding. **I think** the error then escapes the window and AutoCAD shows its own error box or closes (AutoCAD's handling is closed to us; not proven). CEMANAGERREFRESH does catch it but prints the raw Windows error, which carries the login folder.
    - **Cure:** catch, keep the reports waiting, and say "Could not reach the office folder; reports will wait on this PC."
    - **Test (Codex, test account with a read-only office folder):** click Refresh in CEMANAGER and record what appears.

11. **HUNT-M-11 (MEDIUM, I think). On AutoCAD 2022 to 2024, getting an update ready may fail on long folder names.**
    - **The code shows:** the staged copy goes to `%APPDATA%\CE_CADTOOLS\CE_Admin\update-staging\<tool>\<version>\<77-character fingerprint folder>\<tool>.bundle\...` (`CeUpdateStagingService.cs:328-363`).
    - **The drive shows:** on Tim's PC 96 staged files already have paths over 260 characters (longest about 272), with a 12-letter Windows name. Structural's deepest file inside the bundle is 112 characters long.
    - **I think:** the 2022 to 2024 lane runs on the older .NET inside AutoCAD, where paths over 260 characters may fail unless Windows long paths are switched on. I have not proven it; a longer Windows name makes it worse.
    - **Cure:** a much shorter staging folder (for example a 12-character fingerprint) and a test with a 30-character user name.
    - **Test (Codex, AutoCAD 2024 test copy):** approve a test build, click Get update ready, read the result.

12. **HUNT-M-12 (LOW). Colleagues' status line will carry Tim's "feedback notes waiting" count, and it never clears.**
    - **The code shows:** the count reads `%USERPROFILE%\Creative Engineering\Creative Engineering - IT Admin\CE Diagnostics\feedback` on any PC (`CeFeedbackInboxService.cs:20-49`); the comment assumes a colleague's PC has no such folder, but it does whenever the office folder is synced there. Nothing ever calls "mark as seen" (`:86`, no caller; REGRESSION_LOG already says so).
    - **The drive shows:** 4 feedback notes there today, so the line would read "4 feedback notes waiting." on every such PC, for ever.
    - **Cure:** show the count only to the administrator, and wire "mark as seen".

13. **HUNT-M-13 (LOW). The "Send waiting reports" hover text is no longer true.**
    - **The words (`PluginManagerWindow.xaml:226`):** "... and any support zip files (copies of the CE log folders). Each carries your Windows name and this PC's name ...".
    - **The code shows:** support zips found waiting are now deleted, never sent (`CeAdminStorageService.cs:152-157`), and the reports carry coded names (`CeAdminTelemetryService.cs:92-93,125-126,223-224`).
    - **Cure:** reword to what is sent now.

14. **HUNT-M-14 (LOW). A tool not yet on the PC is got ready for `C:\ProgramData`, which needs administrator rights.**
    - **The code shows:** for a tool that is not installed, the target is `C:\ProgramData\Autodesk\ApplicationPlugins\<tool>.bundle` (`CePluginInstallerService.cs:214-218`, `CePluginRegistryService.cs:146-148`, `PluginManagerWindow.xaml.cs:870-874`). Tim moved installs to the per-user folder on 12 Jun because ProgramData needed administrator rights and AutoCAD 2027 did not pick it up (comment kept in `Installer/Program.cs:363-372`).
    - **Cure:** use `%APPDATA%\Autodesk\ApplicationPlugins` for a first install too.

15. **HUNT-M-15 (LOW). Raw program words on the command line and in the fault report box.**
    - **At AutoCAD start:** "[CE_SUITE_MANAGER] Telemetry initialization failed: <Windows error>", "... Workspace menu initialization failed: ..." (`Plugin.cs:101,110,123`); "[CEMANAGER] Workspace menu install skipped: Application.LoadPartialMenu returned false." or "prepare-output: <error>" (`CeSuiteManagerMenuService.cs:139,149,272,788`). Every colleague's start-up text also lists "CEMANAGERADMIN - Open the administrator dashboard" (`Plugin.cs:164`).
    - **Fault report:** when saving fails it says it could not save "in the office IT folder or on this PC" (`PluginManagerWindow.xaml.cs:746-748`), but it only ever tries one place: the office folder whenever it exists (`CeDiagnosticsService.cs:285-289`). Offline it says "Fault report sent" when it was only written to the local OneDrive copy.
    - **Cure:** plain sentences with a next step, and drop the administrator line from colleagues' start-up text.

---

## Checked and fine

1. **The closed-AutoCAD installer itself is careful.** It refuses while acad or accoreconsole runs, checks the signed release and every file fingerprint, keeps a rollback copy outside AutoCAD's plugin folders, swaps whole folders and puts the old one back if anything fails (`SafeBundleInstaller.cs:139-365`). It never deletes the live folder first.
2. **No network calls from Manager.** No web or socket use outside the dead Azure files (already S2-025). The AutoCAD AI hook (`CeMcpServerService.cs`) is an empty placeholder.
3. **CESUPPORT contents.** Only CE's own log names, the last 14 days, under 5 MB, drawing paths cut to job numbers, login and PC name coded, the administrator's name book never included (`CeSupportBundleService.cs:100-165`). Matches W45.
4. **What's New heading.** At 1200744d it still said "CE Civil — Version 3.0.1"; PR #830 (in the installed 3.0.41) makes it read the installed version. Built, not seen.
5. **Old machine-wide Manager on Tim's PC** (`C:\ProgramData\...\CE_SUITE_MANAGER.bundle`) has its start-up file renamed `.DISABLED-duplicate-appdata-wins`, so Manager and the installer both ignore it.

## Already in BUG_CARPARK.md and still true at Manager 1.1.41 (not counted)

1. **S2-009 (BUG-425): CEMANAGERDIAG / "Send a fault report"** still writes the real Windows name and computer name into the office folder (`CeDiagnosticsService.cs:54-55,279,291`).
2. **S2-016 / S2-017 (BUG-425):** a failed background staging is not recorded; staged copies are never removed (108 MB of old copies in Tim's staging folder today).
3. **S2-007 (BUG-425):** "Starts with AutoCAD" rewrites the installed tool's own start-up file (`CePluginRegistryService.cs:241-279`).
4. **BUG-435:** the three start-up lines (see HUNT-M-06 for the Manager part of the cause, as I read it).

## Not checked

1. **Nothing was run.** No AutoCAD, no installer, no Manager window. All findings are from source and the drive.
2. **Settings transfer:** I found no settings transfer feature in Manager or the installer (searched). If it lives elsewhere (the deploy chat's install script), it was not read.
3. **Colleagues' PCs:** their OneDrive setup, their rights on the office folder and their Desktop location are not visible from here.
4. **The deploy chat's pilot install script** (the real colleague route) is not in the repo or the office folder root, so it was not read.
5. **Civil and Structural code**, CE.ReleaseAuthority signing, and native ARX were out of scope.

*End of report.*
