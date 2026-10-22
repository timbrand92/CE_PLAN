# CODEX independent colleague release-gate audit — 22 October 2026

1. **ANSWER FIRST — BLOCKER for Monday 9 November: YES.** Max cannot use the nominated release as a normal first-time installer on a PC without administrator rights. The installer requires elevation and a separately prepared activation request. Approved updates also retain the approving PC's folder path. The packaging script still rebuilds files instead of sealing the exact verified candidate.

2. **Release decision: HOLD colleague delivery.** Close findings 1–4 before handing over the installer. Resolve or demonstrate the conditional checks below against the actual release files and a separate Windows account. This is a source audit, not a failed installation observed on Max's PC.

3. **Good news.** The two new finish-update classes cannot start an install: no production caller, launcher, timer or file-copy action was found. Manager owns the new About command in Civil + Manager. The signed-package verifier checks the trusted public key and package contents.

4. **What must happen next.** The release team needs a working first-install route, portable approvals, proof that the installer contains the accepted files, and the clean-PC rehearsal below. Manager administrator development remains parked; this audit does not authorise restarting it. A documented assisted handover can address a delivery gap only if it is actually rehearsed under Max's restrictions.

---

1. **Scope and evidence.** Read-only review of `C:\Lisp Files\CE_ACAD_PLUGIN`, pinned to `origin/claude/rel-20261022m` at `40ee0a36f7960145743954b39859eb6c3af92869`. Read-only `git ls-remote` matched that local remote-tracking commit. Civil and Manager manifests say 3.0.70 and 1.1.70. All source line references below refer to this commit, not the main checkout's working files.

2. **Method and limits.** Read Git objects, source call sites, manifests and packaging rules; compared manifest command names. Read RULES, ROUTER, the CE plan, relevant release records and both requested memory notes. No build, test, installer, AutoCAD session, executable payload inspection or sub-agent was run. No live settings were read or changed. Installed versions and actual Defender behaviour were not independently verified. The sole authored file is this report; no bug-register or code edits.

3. **Evidence labels.** VERIFIED-BY-READING means the specified control flow or configuration is present in the pinned source. SUSPECTED means the resulting PC behaviour still needs the stated check. Every proposed test below is NOT RUN. Severity describes release impact; conditional findings are not claims that Max already experienced a failure.

## Numbered findings

1. **BLOCKER — Installer requires Windows administrator rights. VERIFIED-BY-READING.**

   **File:line:** `Installer/app.manifest:7`; `Installer/CE_CVL_SUITE_Installer.csproj:13`; `Modules/Manager/Services/CePluginInstallerService.cs:45`.

   **For Tim:** Max is asked for an administrator login before the installer can help him, even though a fresh bundle is intended for his own user folder. CE administrator status is separate from Windows elevation.

   **Clean-PC scenario:** Standard Windows user, no administrator credentials, Civil + Manager absent. Windows refuses to start the elevated installer. Supplying another person's administrator account also changes the account used by the installer's office-folder discovery; that needs explicit handling.

   **Manual check:** On the disposable standard-user PC, launch the final installer normally and decline elevation. Acceptance: the authorised first-install route installs both bundles into the intended colleague profile without needing that colleague to hold Windows administrator rights. Record the Windows account, target folders and result. Do not weaken Defender or run AutoCAD elevated as a workaround.

2. **BLOCKER — No normal first-install entry point; preparing an update does not finish it. VERIFIED-BY-READING.**

   **File:line:** `Installer/Program.cs:13`, `:21`; `Installer/CeInstallerApplication.cs:77`, `:84`, `:253`; `Installer/CE_CVL_SUITE_Installer.csproj:20`; `Modules/Manager/Services/CePluginInstallerService.cs:242`; `Modules/Manager/Services/CeInstallWords.cs:12`.

   **For Tim:** Double-clicking the installer does not install its bundled files. It expects an update record and several folder arguments. A PC with no Manager cannot use Manager to create that record first.

   **Clean-PC scenario:** Max receives the EXE alone. No arguments produce usage exit 64; `--install` and `--update` are explicitly retired. The embedded ZIP extraction code is inside `#if false`. Both old PowerShell install scripts exit 20. Once Manager exists, Get update ready stages files and tells a colleague to ask the CE administrator; it does not activate them. The wording is honest, but the handover still lacks an executable first-install procedure.

   **Deterministic check:** In an isolated release harness, call the actual entry point with no arguments and with `--install`; confirm the current usage result and zero bundle changes. Then rehearse the proposed replacement/assisted route from no CE files at all, with both Civil and Manager reaching their expected versions. A helper that merely prepares command text does not close this finding.

3. **BLOCKER — Shared approval records contain one PC's absolute paths. VERIFIED-BY-READING.**

   **File:line:** `Modules/Manager/Services/CeApprovedReleaseService.cs:46`, `:107`, `:108`, `:122`, `:751`, `:761`; `Modules/Manager/Services/CePluginInstallerService.cs:54`.

   **For Tim:** An update approved on your PC points back to your PC's user folder. Max can sync the very same files and still be told the update is outside the allowed office folder.

   **Clean-PC scenario:** Approval writes `Path.GetFullPath(AvailableBundleFolder)` into shared `approved.json`. Reading that file does not translate its paths to the current user's office root. Verification compares the stored path against Max's own root and refuses it. Rollback paths have the same portability problem. This affects the existing colleague update path even while new administrator work is parked.

   **Deterministic test:** Prepare one authentic signed package under two distinct synthetic user roots, A and B. Create approval using A; copy the unchanged approval and identical package to B; make B the current office root. `BuildAvailablePlugin` must resolve B's package while preserving every approved hash. Current code rejects A's path. Repeat for rollback. Do not copy real user paths into test evidence.

4. **BLOCKER — Installer packaging is not tied to the exact accepted candidate. VERIFIED-BY-READING; final EXE bytes UNVERIFIED.**

   **File:line:** `Installer/build_installer.ps1:185`, `:199`, `:215`, `:235`, `:323`, `:332`; `Installer/ReleaseAuthorityPackaging.cs:379`, `:397`; `Installer/CE_CVL_SUITE_Installer.csproj:36`, `:81`.

   **For Tim:** The release can be tested with one set of files and packaged with freshly rebuilt replacements. That is the payload 85 failure mode, and the named script still permits it.

   **Clean-PC scenario:** The script clears its payload directory, builds all managed lanes, rebuilds the 2027 grip ARX and object DBX, then ZIPs the new tree. Its checks compare against those new builds, not an immutable accepted candidate supplied to the script. The separate release-authority packaging route does bind a candidate hash, but this script does not use that route to seal its embedded ZIP. Its publish command also omits `PrepareOfficialRelease=true` and does not check `$LASTEXITCODE` immediately before archiving available publish output.

   **Existing record:** `C:\CE_PLAN\areas\release-v3-colleagues-DESK_CONTINUITY_RECORD.md:156` and `release-v3-colleagues-DESK_LOG.md:207` record the payload 85 native-byte mismatch. Those records corroborate the risk; this audit did not inspect that old EXE or the final 3.0.70 EXE.

   **Deterministic release check:** Read the final published EXE's embedded ZIP without executing it. Compare its complete relative file list, lengths and SHA-256 values against the frozen accepted candidate, including every DLL, ARX, DBX, manifest and asset. Require zero missing, extra or changed files. Verify the enrolled public key and signed release evidence independently. No rebuilding after the candidate is accepted. Deliberately change one fixture native file and require packaging to refuse it.

5. **HIGH — Older-than-approved refusal can be bypassed by an explicit empty or stale argument; unknown approval is silent. VERIFIED-BY-READING.**

   **File:line:** `Installer/CeOfficeApproval.cs:25`, `:30`, `:74`; `Installer/SafeBundleInstaller.cs:268`, `:803`, `:815`.

   **For Tim:** The normal known-approval check is present, but a launcher can supply its own lower approval number—or an empty one—and prevent the installer checking the office record. A missing approval does not itself produce the promised warning.

   **Clean-PC scenario:** A valid old signed stage is activated with `--approved-version=` while the office file approves a newer release. The explicit flag wins; blank approval disables the floor. With no office sync, unreadable approval or a canary record, the floor is also unknown. The separate downgrade warning only compares against an existing installed version; a fresh PC has none.

   **Deterministic test:** Office approval 3.0.70, valid signed stage 3.0.69: test omitted flag, empty flag and `--approved-version=3.0.68`. All must refuse a known below-approved release before cutover. Separately test missing, unreadable and canary approval: if the intended ruling permits installation when approval is unknown, require a clear warning saying it could not be checked. Do not label unknown as approved. The ordinary no-override known-floor branch already refuses correctly by reading.

6. **HIGH — Separate activation does not enforce Civil/Manager shared-file compatibility. VERIFIED-BY-READING.**

   **File:line:** `Shared/CE_SHARED/CE_SHARED.csproj:15`; `Modules/Manager/CE_SUITE_MANAGER.csproj:179`, `:207`; `Installer/SafeBundleInstaller.cs:252`, `:281`, `:442`; `Modules/Manager/Services/CeApprovedReleaseService.cs:138`.

   **For Tim:** Installing only one half of a release can leave Civil and Manager using different copies of a file they both need. Depending on which loads first, the ribbon or commands can fail.

   **Clean-PC scenario:** Civil and Manager initially match. A later Civil-only activation succeeds while an older Manager remains. The installer checks the candidate's signed files and command clashes, but does not compare CE_SHARED against the other enabled bundle or activate a pair as one operation. Pair approval is useful, but is not paired installation. A second install failing or Defender blocking one half leaves the mismatch.

   **Deterministic test:** Use two authorised fixture releases with different CE_SHARED content but the same assembly identity. Install the old pair, then attempt only the new Civil activation. Acceptance: refuse incompatible pairing or complete/recover the pair before allowing normal restart. For the real release, compare Civil and Manager CE_SHARED hashes separately in Legacy, Net8 and Modern; then check both startup orders. The Manager packaging hash guards are a positive control, not proof of installed pairing.

7. **HIGH, CONDITIONAL — Structural in this Civil branch is not the separately approved Structural release. VERIFIED-BY-READING.**

   **File:line:** `Modules/Structural/Installer/PackageContents.xml:12`, `:22`; `Modules/Structural/Commands/AdminCommands.cs:22`; `Modules/Structural/CE_STRUC_SUITE.csproj:147`; `Modules/Manager/Commands/PluginManagerCommands.cs:30`; `Installer/SafeBundleInstaller.cs:479`.

   **For Tim:** Do not build or ship Structural from this Civil release branch. It still claims the About command that now belongs to Manager.

   **Clean-PC scenario:** Installing all three suites from this one source line introduces a duplicate `CE_VERSION`. Static manifest comparison found no Civil/Manager overlap, no Civil/Structural overlap, and Manager/Structural overlap at `CE_VERSION`; compiled Structural also declares it. The installer should refuse that enabled command clash. Manual copying would bypass that protection. This branch's Structural also references CE_SHARED, unlike the separately released Structural described in the supplied memory note.

   **Manual check:** Deliver Civil + Manager only for Max. If checking coexistence, identify the exact separately approved Structural artifact and source commit; inspect its actual manifest, command declarations and assembly references. Require a single Manager-owned `CE_VERSION`, then open both suites together. Do not infer that the installed Structural is defective from this stale copy, and do not merge the two source lines as an audit fix.

8. **HIGH, RELEASE-EVIDENCE GAP — Exact agreement with Tim's switches is not established. SUSPECTED divergence; defaults VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/SettingsService.cs:51`, `:82`, `:160`, `:308`, `:749`; `Modules/Drainage/ViewModels/Shell/CeEditorShellStateStore.cs:40`; `Modules/Manager/Services/CeOneGlanceStatus.cs:254`, `:271`, `:335`.

   **For Tim:** A fresh PC gets the program's starting values. That does not prove it gets every switch you currently use. The one-page pipe workshop default is correctly on.

   **Clean-PC scenario:** Missing Civil `CD_Settings.json` uses `new UserSettings()` and marks old-value migration done. Missing keys retain their model defaults; null settings sections are restored, and damaged values follow the recovery path. Manager's missing `manager-switches.json` makes its switches off, including the short staging-folder switch. The files are separate. No live Tim settings comparison was permitted by this Git-only audit, so an actual mismatch is not claimed.

   **Deterministic release check:** Compare a sanitised export of Tim's behaviour-affecting values with first-run effective values for this exact candidate. Include Civil editor flags, drawing behaviour and Manager switches; exclude recents, window positions and personal paths. Record every difference and its ruling. Use an empty profile, a file missing one key, a null section, a malformed value and an older file. Verify migration occurs once and a later deliberate value persists after restart. Copying Tim's whole settings file is not the answer.

9. **MEDIUM — Long staging paths remain the clean-profile default. SUSPECTED runtime failure; path construction VERIFIED-BY-READING.**

   **File:line:** `Modules/Manager/Services/CeUpdateStagingService.cs:109`, `:374`; `Modules/Manager/Services/CeOneGlanceStatus.cs:245`, `:302`, `:341`; `Modules/Manager/Services/CeAdminStorageService.cs:32`, `:49`.

   **For Tim:** A colleague with a longer Windows profile path may be unable to prepare an update on older AutoCAD, although it works on your PC.

   **Clean-PC scenario:** A fresh Manager profile uses the 77-character release folder, not the available 25-character alternative. The user profile, CE admin staging hierarchy, bundle name and deep asset paths add to it. Actual failure depends on the runtime and Windows path configuration; it was not reproduced.

   **Deterministic/manual check:** On AutoCAD 2022 and 2024, use a standard-user profile whose resulting deepest candidate path exceeds 260 characters with the default switches. Stage the unchanged signed package. Require success, preserved full hashes and readable status, or a clear preflight refusal before partial staging. Repeat with a denied/locked destination and confirm a retry works after access is restored.

10. **HIGH — Rollback handles caught errors, but abrupt termination has no demonstrated recovery route; no uninstall operation is exposed. VERIFIED-BY-READING, recovery outcome UNTESTED.**

   **File:line:** `Installer/SafeBundleInstaller.cs:314`, `:334`, `:340`, `:351`; `Installer/CeInstallerApplication.cs:120`, `:253`; `Modules/Manager/Services/CeOneGlanceStatus.cs:236`.

   **For Tim:** A normal install failure has a backup and a restore attempt. A power cut or terminated installer between moving the old folder away and putting the new one in place can leave CE absent on restart. The installer has no uninstall or backup-restore command for a colleague to run.

   **Clean-PC scenario:** After the old target is renamed to `.retiring-...`, the process dies before the incoming folder becomes the live target. The catch block never runs. The attempt record says Started; there is no recovery dispatch in the inspected entry point. Backups survive outside scan folders, but are not a user recovery procedure. Roll Back Approved Release is hidden by default and is not an uninstaller.

   **Deterministic/manual check:** On a disposable PC only, stop a controlled installer process at the boundary immediately after the live rename, then terminate it. Restart the prescribed recovery route and verify the old or new complete pair is restored by hashes, with drawings/settings intact. Separately inject an ordinary caught copy/record error and verify restoration. Rehearse a documented uninstall that removes only the intended CE registrations/bundles, preserves user data and leaves no enabled duplicate; do not treat manually guessing which folders to delete as a handover procedure.

11. **MEDIUM — Denied first-run settings-folder creation silently falls back to defaults. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/SettingsService.cs:79`, `:93`; `Modules/Drainage/Services/LoggingService.cs:68`, `:83`, `:98`; `Modules/Manager/Services/CeAdminStorageService.cs:32`, `:51`; `Modules/Manager/Plugin.cs:97`.

   **For Tim:** If corporate controls prevent CE creating its settings folder, Civil can continue with starting values without showing the colleague why preferences are not being remembered. Its log may also be unavailable.

   **Clean-PC scenario:** Deny creation of `%APPDATA%\TIM_CE_CADTOOLS` before first launch. The outer initialisation catch logs the error, selects defaults and marks itself initialised; it does not use the normal unreadable-file warning path. Separately denied log-folder creation is swallowed. Existing-file read failures have stronger retry/protection logic and should not be confused with this first-directory case.

   **Manual check:** Deny creation of only those synthetic profile subfolders, open Civil Settings, change one harmless display preference, close and reopen. Require a visible explanation when persistence fails and preservation of any existing settings. Restore access and confirm saving works. Verify logs under `%APPDATA%\CE_CVL_SUITE\logs` and Manager local state under `%APPDATA%\CE_CADTOOLS\CE_Admin`; failure of logging must not stop commands.

12. **HIGH, ENVIRONMENT GATE — Corporate Windows trust is not proven by CE's signed-package check. SUSPECTED deployment refusal.**

   **File:line:** `Shared/CE.Release/OfficialReleaseGate.cs:724`, `:829`; `Installer/CE_CVL_SUITE_Installer.csproj:9`, `:33`; `Installer/build_installer.ps1:332`; `Installer/app.manifest:7`.

   **For Tim:** A release can pass CE's own authenticity check and still be stopped by the company's Windows protection. That must be checked using the actual delivered installer and files.

   **Clean-PC scenario:** The corporate policy refuses the downloaded EXE or an ARX/DBX/DLL under a user profile. The code verifies an RSA-PSS package signature against an embedded public key; that is separate from Windows executable signing and corporate allow-list policy. No executable-signing step was found in the inspected installer build script. This does not establish that the final distributed EXE is unsigned, because external signing was outside this audit.

   **Manual check:** Corporate IT runs its normal signature/publisher and Defender/application-control checks on the final downloaded delivery, retaining download markings. Rehearse first install and update with policy unchanged. Collect the actual refusal/event if blocked. No private release key, developer SDK, Tim's Azure credentials or Tim's Windows account should be needed on the colleague PC. The installer is self-contained; its build-machine SDK paths are not colleague runtime requirements.

13. **HIGH, COMPATIBILITY GATE — Three managed lanes do not prove that an existing native pipe drawing works in every year. SUSPECTED colleague limitation; lane scope VERIFIED-BY-READING.**

   **File:line:** `Installer/PackageContents.xml:18`, `:78`, `:138`, `:199`, `:207`; `Modules/Manager/Installer/PackageContents.xml:11`, `:34`, `:57`; `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs:7`, `:18`, `:55`.

   **For Tim:** Civil and Manager have loading entries for all requested years, but the shipped native grip/object entries are restricted to 2027. A drawing containing a one-piece CE pipe from your PC needs its own older-AutoCAD check.

   **Clean-PC scenario:** AutoCAD 2022/2023/2024 uses Legacy (.NET Framework 4.8); 2025/2026 uses Net8; 2027 uses Modern (.NET 10). No gaps were found in those managed manifest ranges. The grip ARX and object DBX entries only cover R26.x. The upgrade gate explicitly documents a narrow, previously approved colleague hold: Automatic allows new conversions only for the test-bed account, pending older-version enabler proof. It does not stop opening already-converted objects. This is an explicit exception in source, not evidence that all colleague settings should differ.

   **Manual check:** In every promised year, open a synthetic drawing with an existing native CE pipe plus an ordinary CE pipe. Inspect visibility, properties, intended editing, save/reopen and undo; record any proxy/enabler limitation. In a new drawing, confirm the approved upgrade policy for the colleague account. Do not force the switch on to claim parity. If the current brief supersedes the old narrow hold, resolve that release decision explicitly and prove the enabler first.

14. **LOW — About reports an internal AutoCAD number and cannot establish shared-file health. VERIFIED-BY-READING; layout UNVIEWED.**

   **File:line:** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs:34`, `:39`; `Modules/Manager/Services/CeVersionReport.cs:46`, `:84`, `:95`, `:113`; `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:5`.

   **For Tim:** About works without Structural in its code path, but the AutoCAD row shows a number such as 26.0 instead of the familiar year. If reading the version fails it says 2022+, which looks like a result rather than an unknown value.

   **Clean-PC scenario:** Max sends the About information for support. It lists loaded Civil, Structural and Manager assemblies and detects multiple matches; absent Structural correctly says Not loaded. It shows assembly version to three components and paths on hover, but does not show CE_SHARED identity/content or the source commit. A healthy-looking About window cannot prove that the paired shared files match. Fixed dimensions and long conflict messages still need visual inspection.

   **Manual check:** Open `CE_VERSION` with Civil + Manager only, then with the separately approved Structural. Check five rows, loaded versions, path tooltips, dark/light appearance and 100%/150% scaling. Verify the AutoCAD year and compare module/hash evidence separately. Confirm Close and Escape work. No window was rendered or accepted in this audit.

## Confirmed controls and scope cautions

1. **Finish-update groundwork is inactive.** Repository-wide C# reference searches for `CeFinishUpdatePlanner` and `CeFinishUpdateStartRule` found only their declarations outside tests. `CeFinishUpdatePlanner.cs:36` returns text after read-only existence/path checks; `CeFinishUpdateStartRule.cs:27` returns a decision from supplied values. There is no static startup action. `update.finishWhenAutoCadCloses` is only a named constant here. Neither PR #1508 nor #1515 creates an automatic installation route. Existing startup update work stages candidates; the old live-copy/restart methods are excluded by `#if false`.

2. **Signed updates fail closed on package authenticity.** `OfficialReleaseGate.cs:724`, `:830`, `:883` checks configured public trust, the signature and actual bundle content. `SafeBundleInstaller.cs:252`, `:277`, `:321`, `:342` verifies signed evidence, staged hashes, a second closed-AutoCAD check and installed hashes. The private signer belongs only in release-authority work; colleague verification uses the embedded public key. This is a positive source finding, not a claim that a particular published artifact passed.

3. **Folders and permissions.** First-install targets are per-user roaming ApplicationPlugins; stage/log/state paths are also per-user. Activation accepts the recorded target and can write ProgramData or Program Files if such a target is supplied and permissions permit; it is not restricted to the fresh per-user destination. Existing ProgramData bundles win Manager discovery (`CePluginRegistryService.cs:56`, `:337`). The installer scans ProgramData, roaming and local ApplicationPlugins for conflicts (`SafeBundleInstaller.cs:749`); a Program Files plugin location is absent from that list. Check any corporate machine-wide deployment separately; do not silently create a second user copy beside it.

4. **Office files are a real dependency; Azure is not the update fallback.** `CePluginInstallerService.cs:54`, `:99`, `:233` resolves this user's synced office folder, returns no builds when it is absent and rejects the old Azure source route. Missing office sync must be visible in the handover. Civil's personal-template linetype fallback remains at `LayerService.cs:262`, but `:603` tries the shipped `CE_CIVIL.lin` first. The mere presence of Tim's fallback path is not proof of a broken fresh install: check shipped custom linetypes and blocks without that fallback folder.

5. **Do not confuse this source line with the live filesystem.** The manifest versions were read from Git. The actual bundle contents, candidate signatures, full Tim/default comparison, office access, machine-wide policies and exact current Structural binary remain outside this read-only result. The supplied Structural isolation memory applies to its separate release line, not automatically to the Structural sources found here.

## Clean-PC dry-run checklist — 22 steps, all pending

1. **Freeze the delivery.** Record Civil/Manager source commits, final EXE and package hashes, exact partner Structural artifact if used, and the approved behaviour-switch comparison. Use synthetic drawings only.
2. **Prepare a disposable colleague profile.** Standard user, different account and profile path, no Tim folders/settings/developer tools/private keys. Keep corporate Defender and normal download handling enabled.
3. **Check the actual publisher.** Have corporate IT verify the final downloaded executable and native/managed files under its ordinary policy. Record any refusal; do not disable protections.
4. **Inspect embedded contents.** Compare the EXE's embedded bundle and complete file inventory against the frozen accepted candidate. Require identical hashes, including ARX/DBX files.
5. **Prove first installation.** Follow the documented route from no CE files. No developer command knowledge or colleague administrator credentials should be required. Both bundles must arrive in the intended user profile.
6. **Check install locations.** Inspect roaming/local ApplicationPlugins and any corporate ProgramData/Program Files location. Require one intended enabled owner per product and no accidental install into a helper administrator's profile.
7. **Check signed tamper rejection.** On a disposable copy, alter one package byte or remove its signature. Require refusal before live files change; then return to the original untouched delivery.
8. **Check the approved floor.** Attempt a valid older signed build with known newer approval, including empty/stale override arguments. Require refusal. Missing/unreadable approval must produce the agreed explicit warning behaviour.
9. **Check portable approvals.** Approve under synthetic account A, consume the same shared approval and bytes under account B with a different root. Require successful local resolution without changing the approved hashes.
10. **Check office access.** Start without office sync, then with the correct folder available and fully downloaded. Manager must explain absence and recover after Refresh; no Azure/private-key fallback.
11. **Check all six AutoCAD years.** Repeat startup on 2022, 2023, 2024, 2025, 2026 and 2027. Inspect actual loaded DLL paths and expected Legacy/Net8/Modern lane. Record failures per year, not one result for all six.
12. **Check the shared pair.** Hash CE_SHARED in Civil and Manager lane by lane. Require equality. Test a deliberately mismatched older partner in a disposable setup and demand a safe refusal/recovery route.
13. **Check About.** Run `CE_VERSION` with Civil + Manager only. Require correct loaded versions, Structural Not loaded, usable path tooltips, Close/Escape and readable 100%/150% dark/light layout.
14. **Check first-run preferences.** With no settings files, open Civil Settings, New Pipe, Edit Pipe and Manager. Compare all approved behaviour defaults against the sanitised Tim baseline and record explicit exceptions.
15. **Check migration and persistence.** Test missing keys, null sections, invalid values and an older settings file separately. Save one changed preference, restart twice, and confirm it remains while any migration occurs only once.
16. **Check denied/locked folders.** Deny only synthetic settings/log/staging subfolders, then restore access. Require a visible settings warning, no command crash, preserved original files and a successful retry.
17. **Check long paths.** On 2022 and 2024, use a long profile path and default Manager switches. Stage the full signed package and verify all files/hashes or a clear safe preflight refusal.
18. **Check office-free drafting assets.** In a blank synthetic drawing, create representative drainage objects and custom linetypes/blocks without Tim's fallback template path. Require complete expected graphics.
19. **Check old/new drawing compatibility.** In each year, open ordinary pipes and existing native CE pipes from the approved synthetic fixture. Inspect, edit as supported, save/reopen and undo. Record enabler/proxy limits and the approved upgrade hold.
20. **Check update completion and interruption.** Prepare an update, leave AutoCAD open and require activation refusal. Close it and use the actual completion route. Rehearse a caught install failure and termination at the retirement boundary; restore a complete matching pair by hashes.
21. **Check optional coexistence.** Use only the separately approved Structural artifact. Require one Manager-owned `CE_VERSION`, no shared-file conflict, and working Civil/Structural commands in both startup orders. Never ship Structural from this Civil branch as a substitute.
22. **Check uninstall and return to service.** Follow the documented assisted/user uninstall and rollback procedure. Preserve drawings and settings, leave no duplicate enabled bundle, reinstall the exact accepted pair, and verify About plus one Civil operation again.

## Summary — under 100 words

Four confirmed delivery blockers remain: administrator-only launch, no ordinary first-install route, approvals tied to another PC's absolute paths, and packaging that rebuilds instead of sealing the accepted candidate. The new finish-update planners are inactive. Signed-package checks and managed year ranges are present, but pairing, crash recovery, defaults, corporate trust and existing native drawings still need clean-PC evidence. Structural in this Civil branch must not substitute for its separately approved release. No builds, tests, installs or AutoCAD checks were run. Hold the 9 November handover until the blockers and relevant checklist gates pass.
