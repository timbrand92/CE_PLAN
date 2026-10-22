**ANSWER FIRST — Manager independent hunt, 22 October 2026 brief**

1. **Counts: HIGH 0 / MEDIUM 3 / LOW 0.** Three additional findings, all verified-by-reading. None has been reproduced in AutoCAD during this hunt. Existing audit findings are excluded.

2. **Most important: CE Health can say Civil is OK when Civil has not loaded.** A colleague whose Civil commands are unavailable can get an OK line from the command intended to diagnose that problem. With the other checks satisfied, it even says “All checks passed.”

3. **The other two:** a damaged prepared update cannot be repaired by clicking Get update ready again; the prominent Updates & Rollback ribbon button refuses an ordinary colleague instead of opening their existing Updates page.

4. **Scope respected.** No build, tests, AutoCAD, installation, code edit, branch or sub-agent. Administrator development remains parked. This report is the only authored file. The proposed checks are for a later AI test session, not for Tim to perform.

---

**Evidence and limits**

1. **Pinned source.** Read Git objects in C:\Lisp Files\CE_ACAD_PLUGIN after git fetch origin. Civil/Manager: origin/claude/rel-20261022m at 40ee0a36f7960145743954b39859eb6c3af92869, source versions 3.0.70 / 1.1.70. Structural coexistence reference: origin/claude/rel-20261022s2 at 2c9a96942a024888a5ab520600f2d5025de83036. All source file:line references below use the Civil/Manager head unless stated otherwise. Live installed bytes and private settings were not inspected.

2. **Prior work excluded.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md and the available CODEX_AUDIT_CIVIL_22OCT.md, CODEX_AUDIT_STRUCTURAL_22OCT.md and CODEX_AUDIT_GATE_22OCT.md. Also checked the relevant older Manager/install hunt and bug headings. First-install elevation/entry-point gaps, absolute approval paths, package rebuilding, pairing, crash recovery, long default staging paths and About limitations remain with their existing reports.

3. **Meaning of verified.** The active branch and its result follow from the specified source. This does not claim a native run. Environmental causes such as a deployment fault or a lost staged file are fixture conditions, not claims about a particular colleague's PC. Every deterministic test below is NOT RUN. Use disposable profiles, synthetic drawings and authorised fixture packages; retain normal signature verification.

4. **Review boundary.** This checks colleague-facing loading, diagnosis and update preparation. It does not propose engineering values or additional drafting hard blocks. The 9 November Civil + Manager delivery and parked administrator work remain as instructed. Report completed 23 October 2026, shortly after midnight Melbourne time; filename retains the requested 22OCT brief date.

**Numbered findings**

1. **MGR-01 — MEDIUM — CE Health reports an installed but unloaded Civil as OK. VERIFIED-BY-READING.**

   **File:line:** Modules/Manager/Commands/PluginManagerCommands.cs:184, :191, :201, :206, :211, :243; Modules/Manager/Services/CePluginRegistryService.cs:517; Modules/Manager/Services/CeHealthChecks.cs:31.

   **What happens in AutoCAD:** Civil's files can be present but its commands unavailable. CE_VERSION correctly says Civil Suite “Not loaded”, while CEHEALTH prints “[OK]    CE Civil Suite v3.0.70”. The colleague receives contradictory advice about the same session.

   **Exact failure scenario:** Civil has an existing main DLL, startup enabled in its manifest, no pending stage and no restart flag, but no Civil assembly loaded. ResolveStatus returns NotLoaded. RunHealthCheck handles missing DLLs, restart, Disabled, and Loaded-with-zero-command-count. It has no NotLoaded branch, so that state falls into the unconditional OK branch. The later pair check compares files on disk; it cannot repair the missing load diagnosis.

   **Why the final result can also be wrong:** with matching Civil/Manager shared files, no duplicate bundles and a reachable office folder, none of the other checks increments issues. The final line is then “[CEHEALTH] All checks passed.” On a genuinely office-free profile the office-folder warning still appears, but Civil is still incorrectly marked OK.

   **DETERMINISTIC TEST — fixture:** disposable AutoCAD 2027 profile with the exact Civil 3.0.70 / Manager 1.1.70 pair in its user ApplicationPlugins folder, startup-enabled manifests, matching CE_SHARED files, no Structural, no approvals and no prepared updates. Arrange a fresh process with automatic application loading disabled: set APPAUTOLOAD to 0 in that disposable profile and restart. Manually NETLOAD only CE_SUITE_MANAGER.bundle/Contents/Win64/Modern/CE_SUITE_MANAGER.dll. Do not invoke a Civil command before the check.

   **Typed steps and assertions:** type CE_VERSION and assert Civil Suite reads “Not loaded”; close it. Type CEHEALTH and capture F2 command history. Required: a warning that Civil is not loaded, and no OK line for Civil. Source predicts the opposite. For the stronger final-line case, provide an empty reachable synthetic office folder at the path resolved by GetItAdminPath before launching; require the final result to count the missing Civil load, not say “All checks passed”. Without that folder, assert the Civil line separately from the expected office-folder warning.

   **Control and correction direction:** in a fresh equivalent run manually NETLOAD Civil too, confirm CE_VERSION lists 3.0.70, then repeat CEHEALTH. The OK Civil line is appropriate only in that control. Add an explicit NotLoaded warning; carry on with the remaining checks. Repeat later on the Legacy lane using its manifest-selected DLL. No AutoCAD internal loading failure is assumed by this test: the precondition is measured in CE_VERSION.

2. **MGR-02 — MEDIUM — a damaged prepared update permanently defeats ordinary retry for that candidate. VERIFIED-BY-READING.**

   **File:line:** Modules/Manager/Services/CeUpdateStagingService.cs:370, :374, :399, :401, :414, :417, :430; Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:666, :688; Modules/Manager/Services/CePluginInstallerService.cs:242.

   **What happens in AutoCAD:** after an update has been prepared, one missing file in that local copy makes it unusable. Clicking Get update ready again copies the good office files, then discards that fresh copy and fails because the old damaged folder is still there. Restarting AutoCAD reaches the same failure. The drafter has no recovery action in this route.

   **Exact failure scenario:** the approved source and signed evidence remain intact; only one file is removed from the local staged candidate. The destination name is determined by content hash and target-path hash, so the unchanged approved candidate always returns to the same destination. If that folder exists, IsValidStage rejects it and Stage throws “An existing staged release has conflicting identity evidence.” Its catch deletes only the new preparation folder. It neither quarantines the damaged destination nor selects a new destination for the verified replacement.

   **Safety distinction:** rejecting the damaged copy is correct. The defect is the absence of a supported recovery route for preparing a new, independently verified copy. Nothing here recommends accepting changed bytes or weakening OfficialReleaseGate.

   **DETERMINISTIC TEST — fixture:** disposable colleague profile with an older installed Civil/Manager pair and an authorised, correctly signed newer pair available under that profile's synthetic office folder. Use two different numeric releases, with every approval path resolved locally so the already-known cross-PC path defect is not involved. Stage Civil successfully and retain its receipt and original installed-file hashes. Close AutoCAD. In this disposable fixture only, remove one PNG listed in the stage receipt from the staged Civil bundle; preserve the receipt, source package and installed bundle.

   **Typed/click steps:** restart AutoCAD, type CEMANAGER, select CE Civil Suite, open Updates, click Review update, then Get update ready. Dismiss the failure and repeat that pair of clicks once. The background startup attempt may also fail first; it does not alter the deterministic collision.

   **Assertions:** both attempts currently print “[CEMANAGER] Install/Update failed for CE_CVL_SUITE:” followed by “Update staging failed: An existing staged release has conflicting identity evidence.” No usable new stage is produced, although the source remains verified. Acceptance: an explicit retry/recovery action produces a complete verified stage from the intact source, preserves the bad copy as appropriate for diagnosis, and leaves installed hashes unchanged. The window must then offer “What's ready” for the new valid copy.

   **Why green unit tests miss the product failure:** Modules/Manager.Tests/Services/CeUpdateStagingServiceTests.cs:135, Stage_RepeatingCandidateAfterStagedBytesChanged_FailsClosed, explicitly expects this refusal. Keep that rejection coverage; add a separate recovery test through the supported retry action. The existing test proves rejection, not that a colleague can recover.

3. **MGR-03 — MEDIUM — the colleague's Updates & Rollback ribbon button opens an administrator-only route. VERIFIED-BY-READING.**

   **File:line:** Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26; Modules/Manager/Commands/PluginManagerCommands.cs:91, :139, :148; Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:161, :191; Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:590.

   **What happens in AutoCAD:** an ordinary colleague clicks CE Tools > Updates & Rollback to see the approved update. No update window opens. The command line instead says their Windows account is not set up as a CE administrator and suggests administrator setup. The normal Manager window already has a colleague-accessible Updates page.

   **Exact failure scenario:** Civil + Manager loaded, current user not a CE administrator. The ribbon definition always includes CEMANAGERUPDATES with the general-purpose label and tooltip “Review approved releases, staged updates and rollback status.” Its handler calls ShowAdminWindow("Updates"), whose non-admin branch prints the refusal and returns. It never routes to PluginManagerWindow's tabUpdates. This is a misplaced colleague doorway, not a request to reopen parked administrator development.

   **DETERMINISTIC TEST — fixture:** fresh disposable colleague profile, Civil + Manager only, a synthetic existing administrator policy naming a different test account, current user excluded. This avoids the separate first-administrator setup issue. Start with a blank metric drawing and all ordinary commands idle; no approved update is needed merely to open the page.

   **Click/typed steps:** click CE Tools, then Updates & Rollback. Capture the command line and open-window titles. Required: the normal CE Suite Manager Updates page opens, or the ribbon clearly offers only an appropriately labelled administrator function. Current source predicts no window and “[CEMANAGER] This Windows account is not set up as a CE administrator.” Type CEMANAGER and click Updates as a control: that colleague page is available.

   **Additional assertions and correction direction:** the click must not offer or grant an administrator role merely to inspect updates; drawings and settings stay unchanged. Route the colleague-facing button to the existing Updates page, or expose the existing Admin function only as such. Keep existing typed aliases. Repeat the typed CEMANAGERUPDATES comparison on Legacy; the CE Tools ribbon itself is a modern-lane test.

**Coverage and discarded candidates — not additional findings**

1. **Finish-update groundwork:** CeFinishUpdatePlanner.Plan and CeFinishUpdateStartRule.Decide have no production caller found by repository-wide C# searches. Their text/decision output cannot start an installer. Startup calls StageManagedUpdates; this stages files only. The old live-copy implementation remains inside #if false. This confirms earlier coverage, rather than counting the inactive groundwork as a new failure.

2. **Installer and release gate:** the active stage path verifies pinned office evidence through CeApprovedReleaseService.TryVerifyOneDriveReleaseFolder at :751/:774, then stages through CePluginInstallerService:242. The external installer calls OfficialReleaseGate.Verify at Installer/SafeBundleInstaller.cs:252 and verifies candidate files, process closure and command ownership before cutover. The staged receipt is explicitly allowed at :260; command-free DBX files are handled at :546. Previously reported defects in the older versions of these branches are not repeated. No end-to-end activation was exercised.

3. **CE_VERSION:** Manager owns the command at PluginManagerCommands.cs:30 and builds rows from loaded assemblies in CeVersionReport.cs:54. At the separate Structural head, AdminCommands.cs no longer declares CE_VERSION. About's internal AutoCAD number, missing shared-file/commit evidence and unviewed layout were already audited; no additional proved About defect is counted.

4. **Known Manager warning omission:** the ribbon monitor leaves Manager out of DiscoverAll, while the background stager explicitly adds it. The older Manager/install hunt already records this under HUNT-MI-10 / BUG-832. It is excluded from this count, including its corresponding missing approval/stage evidence in the Manager-self row.

5. **Rejected false lead:** CeOneGlanceStatus.cs:124/:130 contains a promise that a prepared update switches on next restart. Searches found its OneGlanceLines/IsOneGlanceEnabled outputs only in the view model, with no current window binding. It is therefore not counted as a drafter-visible fault. The active preparation receipt correctly directs the user to finish installation separately.

6. **Clean-profile limits:** office-folder dependence, missing administrator rights, first-install entry points and default switches remain covered by CODEX_AUDIT_GATE_22OCT.md. No Tim-specific folder was treated as necessary merely because an old fallback path exists. No settings migration, native load, window appearance, scale/DPI behaviour or actual package signature was tested here.

**Summary — under 100 words**

1. **Summary.** Three additional MEDIUM findings: CE Health labels unloaded Civil as OK; a damaged prepared update cannot recover through retry; and the colleague update ribbon button sends them to an administrator-only command. The source proves these paths, but native tests remain pending. Finish-update groundwork is inactive, About ownership is correct at the nominated heads, and previously audited installer and Manager-warning gaps are excluded. Only this findings file was authored; no code, drawing, settings, build or installation was changed.

