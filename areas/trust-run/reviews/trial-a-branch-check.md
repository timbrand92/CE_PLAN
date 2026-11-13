YES

# Trial A branch check: is commit 0f6caa40 safe to install on Tim's PC for testing on copies?

**Reviewer:** lane trust-review (sixteenth run). **Written:** Fri 13 Nov 2026, 11:46 PC clock. **Judged:** commit `0f6caa40` on the LOCAL branch `trial-a-build-13nov` (worktree `C:\CE_WORK\build\wtA13`, clean, HEAD `0f6caa40`), as the coordinator asked at about 11:40. Also checked: the pushed branch `origin/claude/trust-trial-a-bug1456` at `9714ffdd` (step two). Read only: git and source reading, two values read from Tim's settings file; no build, no install, no AutoCAD.

**Answer: YES, for testing on copies today, with the four install-owner notes in section 4.** It is exactly the installed Civil 3.0.90 plus the BUG-1456 cure (pull request 2073) plus a two-line version change. Nothing in the shared part, Manager, Structural, Settings defaults or the ribbon changes.

---

# FOR TIM

1. **On screen, nothing changes.** Same ribbon, same windows, same words. The status bar still reads "v3.0.90" (it shows three numbers); only its date changes to today's.
2. **What you can no longer hit:** running Help (CDHELP) or Settings (CDS) as the first thing in a second drawing can no longer copy the first job's pits and pipes into it. This is the mix-up the robot saw six times on your installed version.
3. **The one risk left:** a drawing that was already saved with another job's pits and pipes before tonight is not found or repaired by this fix. Reading the code says it is safe, but it has only been proven in AutoCAD's core console so far. The robot's real-AutoCAD repeat today is what proves it.

**Verdict: GO** (YES above) for installing `0f6caa40` on Tim's PC for testing on copies, under the runbook.

---

# Findings

## 1. Each claim checked

1. **`0f6caa40` has one parent, `9573b97a`.** TRUE (`git rev-list --parents -n1 0f6caa40`).
2. **`git diff 9573b97a 0f6caa40` is exactly two lines.** TRUE. `Installer/PackageContents.xml` line 13: `AppVersion="3.0.90"` becomes `"3.0.90.1"`. `Modules/Drainage/CE_CVL_SUITE.csproj` line 18: `<Version>3.0.90</Version>` becomes `3.0.90.1`. Nothing else.
3. **`cf059dcf` to `9573b97a` is pull request 2073 at `1a28c3b3` and nothing else.** TRUE. `9573b97a` merges `cf059dcf` and `1a28c3b3`. Its file tree is `7ee076ba`, the same tree as `1a28c3b3`. `1a28c3b3`'s only parent is `cf059dcf`. So the step equals the reviewed 2073 head, byte for byte. That head was reviewed GO at 05:53 (`claude-bug-1456-record-own-drawing.md`) and passed `CEPROOFCROSSDRAWING` in the core console.
4. **Nothing under `Shared\` changed.** TRUE for `0f6caa40`, and for `9714ffdd` too. In both, the changed files are only under `Modules/Drainage`, `Modules/Drainage.Tests`, `Modules/Drainage.HeadlessProof` (the core-console proof tool, not shipped), `REGRESSION_LOG.md`, `tools/headless-proof/README.md`, plus the two version lines. Nothing under `Shared`, `CE.AI.Core`, `Modules/Manager`, `Modules/Structural` or `Installer` apart from the one `AppVersion` attribute. **So Manager does not need rebuilding.**
5. **No Settings default, ribbon or command output changed.** TRUE by reading the whole product diff (`cf059dcf` to `9573b97a`):
   - No file under `Models/` and no settings asset.
   - No ribbon or menu file.
   - No added `WriteMessage`, message box or prompt.
   - The only removed lines are "CDS" and "CDHELP" from the end-of-command write list (`LinkService.cs:64`).
   - What is added is checks, plus one log line when a write is refused.
   - The closed-drawing half reads the existing BUG-1225 switch `ReopenedDrawingLoadsItsOwnRecord` (default ON, `UserSettings.cs:725`). It is not in Tim's settings file, so the default applies.
6. **No installer behaviour changed.** Only the `AppVersion` text in the Civil manifest (section 2).

## 2. Does `AppVersion="3.0.90.1"` change how AutoCAD loads the bundle, or what Manager's update check does?

1. **AutoCAD loading:** the `<Components>` blocks (which DLL loads for which AutoCAD year) are unchanged. `AppVersion` is a description field. Not tested here: AutoCAD's own loader is not in CE's code.
2. **Civil itself:** the one place that reads `AppVersion` at run time is the workspace menu installer (`WorkspaceMenuInstallerService.cs:264-296`). It uses the version to decide whether to reinstall the CE menu and rewrite `lastWorkspaceMenuVersionInstalled` in the settings file. It runs only in the AutoCAD 2022 to 2024 build (`PluginInitialization.cs:249-251`, `:516-520` under `#if NET48`; `StandaloneCivilRibbonService.cs:21-44` the same). **On Tim's AutoCAD 2027 it does not run,** so the version change does not rewrite his settings file or reload his menus. (His file holds `"3.0.0|toolbar-v4|..."` there, untouched since an older version, which fits.)
3. **Manager's update check:**
   - Manager reads Civil's `AppVersion` (`CePluginRegistryService.cs:452`) and compares versions as numbers (`CePluginInstallerService.CompareVersions`, `System.Version`). So 3.0.90.1 counts as newer than 3.0.90.
   - **An ordinary approval is never staged over a newer installed build:** `IsNewerBuild` returns false when the installed version is higher (`CePluginInstallerService.cs:200-213`).
   - The "New version approved" status appears only when the approval is higher than what is installed (`CeReleaseStatusService.cs:131`).
   - A go-back is staged only if the office pressed Roll Back Release (`IsRollbackTarget`, `CeApprovedReleaseService.cs:470-474`, status "Rolled Back").
   - **So the bump protects the trial:** Manager will not re-stage 3.0.90 over it. With the version left at 3.0.90, Manager would have fallen back to comparing DLL dates.
   - **Not read:** the office's current approval file. If it already approves a Civil version above 3.0.90.1, or is set to Rolled Back, Manager would act on that exactly as it would on 3.0.90 today. That is nothing new.
4. **Where the trial shows its version:**
   - Manager's list reads "3.0.90.1" (the `+commit` suffix is dropped, `CeRunningVersion.cs`).
   - The CE log reads the full assembly version (`LoggingService.cs:108`).
   - **The Civil status bar shows three numbers only, so it still reads "v3.0.90"** (`PluginInitialization.cs:720`), with the build date. The Feedback window does the same (`FeedbackViewModel.cs:118`).
   - Civil's office telemetry reports 3.0.90.1.

## 3. Keeping the INSTALLED `CE_SHARED.dll` and `CE.AI.Core.dll` in the Civil trial bundle

**No risk seen in the code:**

1. **Same source:** neither library's source changes between `cf059dcf` and `0f6caa40` (section 1 item 4).
2. **Same identity:**
   - `CE_SHARED`'s version is pinned in its own project: `Version 1.1.0`, `AssemblyVersion 1.1.0.0`, `InformationalVersion 1.1.0+inspector-contract.1` (`Shared/CE_SHARED/CE_SHARED.csproj:14-17`). It does not follow Civil's 3.0.90.1. So the trial Civil DLL asks for exactly the same `CE_SHARED` the installed one asks for.
   - `CE.AI.Core` sets no version of its own, so it is the same on both builds.
3. **One identity on the PC:** keeping the installed copies keeps Civil and Manager on byte-identical shared files (memory rule: "first loaded wins").

One check for the install owner: confirm the Civil bundle's installed `CE_SHARED.dll` has the same SHA-256 as Manager's before the install. The plan assumes this; I did not hash the bundles.

## 4. Notes for the install owner (none blocks the YES)

1. **Only proof so far:** the core-console check on the 2073 tree. Runbook 4.4 (the six seen sequences plus the tab switch, each twice, in real AutoCAD on copies) is the proof. Until it passes, State A is not earned.
2. **Telling the trial apart:** use the SHA-256 and the DLL's product-version string, or the CE log. The status bar alone shows "v3.0.90" (date aside).
3. **Step two (`9714ffdd`, adds 2083):**
   - Tree equals `8a6decef`. Its one commit after the reviewed `522e5502` changes only the core-console check (`CrossDrawingChecks.cs`), so the product code is the reviewed GO code.
   - It needs its own version commit if it is built.
   - Its `CEPROOFCROSSCHANGE` and `CEPROOFCROSSDRAWING` PASSes were on `8a6decef` (09:10) and on `e938d0d4`. Per the runbook, it joins only after 2073 passes in real AutoCAD.
4. **Tim's settings files:** the version change itself writes nothing to them on AutoCAD 2027 (section 2 item 2). Runbook 6.2's byte-identical check stays the test for everything else the robot does.

# What I did not check

1. No build, no hash of any bundle, no run of the payload process. I did not read the build lane's payload list (which files it copies) or the installer it uses.
2. AutoCAD's own handling of a four-part `AppVersion` (outside CE's code).
3. The office's current approval file (Manager's approved Civil version and rollout status).
4. Whether the installed `CE_SHARED.dll` in the Civil and Manager bundles are byte-identical today.
