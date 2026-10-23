1. **ANSWER FIRST — 4 new findings: HIGH 0; MEDIUM 2; LOW 2.** All four are SURE by code reading; none was reproduced in AutoCAD during this audit.

2. **Most important:** if the office approval file cannot be read, CE can still tell the drafter **“CE is current.”** The office folder exists, but CE has not established whether the installed release is current.

3. **Top three:** the false current message; Drawing Repair still saying **“Nothing has been changed”** after changing the drawing; and **Disable on Restart** losing its pending restart notice during its own refresh. Fourth: a module's update history can include another module's notes.

---

1. **Audit basis and limits.** Independent read-only Manager windows and update UX audit, 24 October 2026, Melbourne date. Source: `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil 3.0.72 / Manager 1.1.72). Structural reference: `origin/claude/rel-20261023s`, commit `e6d597c0fbc25e78118760887a70810e0890c9a9`. The later, area-specific source instruction takes precedence over the older 22 October refs in the introductory brief. Git source was read in detached worktree `C:\ce-cx\rd13`. No branch, code edit, build, test, installation or AutoCAD session was created. Line references below belong to the pinned Manager/Civil commit and are relative to `C:\Lisp Files\CE_ACAD_PLUGIN`.

2. **Duplicate check.** Read `BUG_CARPARK.md`, `areas/AUDIT_C58_C60_S40_S41_2026-10-22.md`, and the Civil, Structural and gate `CODEX_AUDIT_*_22OCT.md` reports; searched the later CODEX audit reports for the proposed findings. Relevant known findings are excluded here: BUG-425, BUG-480, BUG-487, BUG-823, BUG-824, BUG-829, BUG-832, BUG-833, BUG-837, BUG-839, BUG-842, BUG-843, BUG-844, BUG-848, BUG-849, BUG-850, BUG-851, BUG-852, BUG-883, BUG-884, BUG-886, BUG-887, BUG-913, BUG-914, BUG-917, BUG-918, BUG-919, BUG-935, BUG-938, BUG-946, BUG-947, BUG-948, BUG-961, BUG-1017, BUG-1026, BUG-1027, BUG-1028, BUG-1029, BUG-1074, BUG-1085, BUG-1086, BUG-1087.

3. **How to read the tests.** These are deterministic acceptance tests to perform later in a disposable test profile and synthetic drawing. They were specified, not executed. “Current behaviour” below means the result proved by the source path, not a witnessed AutoCAD result. No client drawing, client name or site address is needed. None of the fixes proposes a new hard block or moving engineering values away from Settings.

1. **RD13-01 — MEDIUM — SURE — Failed approval read becomes “CE is current.”**

   **What Tim or a colleague sees:** CE gives an all-clear update message even though it could not read the office's approval for Civil. The colleague can believe the installed release is current and stop looking for an update.

   **File and line:** `Modules/Manager/Services/CeApprovedReleaseService.cs:46` and `:51`; `Modules/Manager/Services/CeReleaseStatusService.cs:127`, `:160` and `:223`; `Modules/Manager/Services/CeAdminTelemetryService.cs:173` and `:190`.

   **Verified by reading:** approval discovery catches a per-file read/parse failure, writes a diagnostic and omits that module from its returned list. The status calculation skips an installed module with no returned manifest. Its final check only asks whether the office folder exists; when it does, the fallback is `Level = Ok`, `Message = "CE is current."`. The polling caller passes folder existence and the surviving manifests, but no approval-read completeness flag. The diagnostic goes to the trace, not this status calculation. This finding is the incorrect colleague-facing result after the per-file error handling, with a reachable office folder; it does not require discovery to throw or the folder to be absent.

   **Exact failure scenario:** Civil and Manager are loaded, no update is staged, no rollback is pending, and no higher-priority status or waiting feedback exists. The office release directory remains reachable. Civil's existing `approved.json` contains malformed JSON. Other valid approvals, if present, match their installed versions. Civil is omitted from discovery and the status falls through to “CE is current.”

   **DETERMINISTIC TEST:** in an isolated profile, start with this healthy baseline and a valid Civil approval. Preserve the fixture approval, then replace only its contents with the single character `{`. Keep the office root and module directory present and readable. Type `CEMANAGER`, click **Refresh**, and allow the next status poll (up to 65 seconds). Inspect the CE ribbon status tooltip and the Manager trace at `CeAdminTelemetryService.TraceLogPath`. Assert that the trace contains `validation-rejection[approved-release-discovery[CE_CVL_SUITE]]` and `could not be read`. Acceptance: the tooltip must say that Civil's approval could not be checked and must not say `CE is current.` Current code predicts that misleading all-clear. Restore the fixture file and verify a subsequent poll clears the unknown state.

   **Smallest fix:** return discovery completeness/per-module failures with the valid manifests, carry that information into the status calculation, and show a plain “Could not check the office approval for Civil” state with a recovery instruction. Continue showing valid approvals and allow drafting.

2. **RD13-02 — MEDIUM — SURE — Drawing Repair says nothing changed after a successful repair.**

   **What Tim or a colleague sees:** after **Fix it** successfully changes stored drawing information, the same window still says **“Nothing has been changed. Inspect only looks.”** Its repair count and completion summary contradict this banner. The drafter cannot rely on the window to tell whether the drawing was changed.

   **File and line:** `Modules/Manager/UI/ViewModels/DrawingRepairViewModel.cs:184`, `:299` and `:312`; `Modules/Manager/UI/Pages/DrawingRepairPage.xaml:92`; `Modules/Drainage/Services/LinkService.RepairAudit.Apply.cs:128`, `:137` and `:158`.

   **Verified by reading:** the banner is an unconditional constant bound to a visible TextBlock. Fix calls the contributor, accepts an applied result, updates the summary and counts, and notifies the view, but the banner cannot change. The real Civil contributor is registered at `Modules/Drainage/PluginInitialization.cs:227`; its repair path writes the missing attachment owner, commits the drawing transaction and returns `Applied = true`. This is reachable production behaviour, not merely an unused view model.

   **Exact failure scenario:** a synthetic CE pipe has one MText label whose parent attachment list and unique stored identities prove ownership, but the label's own attachment-owner record is absent. All objects are editable, and there is no conflicting ownership, external reference or active reference edit. Inspect produces one eligible exact repair; Fix writes that owner record. The persistent banner continues claiming nothing has changed.

   **DETERMINISTIC TEST:** prepare that synthetic drawing using the ownership case represented by `Modules/Drainage.Tests/Services/ExactStoredLinkRepairPlanningServiceTests.cs:28` (`Plan_RestoresOnlyExactMissingPipeAttachmentOwner_WithoutChangingParentOrProject`), with real fixture handles replacing the test's synthetic handles. Type `CEMANAGER`, open **Drawing Repair**, select the Civil contributor under **Checks for**, click **Inspect drawing**, confirm the single missing-owner repair, then click **Fix it**. Assert the label owner record now matches its parent and the window reads `Items fixed: 1`. Acceptance: the window must no longer contain `Nothing has been changed`; it must clearly report that the repair changed the drawing. Source predicts the old banner remains.

   **Deterministic UI fixture:** the existing `Modules/Manager.Tests/UI/DrawingRepairViewModelTests.cs:57` already supplies an applied result with two repairs, runs Inspect and Fix, and asserts the completion summary. In a later test change, add the missing assertion that the banner no longer claims nothing changed. That assertion fails from the constant property without depending on AutoCAD timing. No test was changed or run here.

   **Smallest fix:** make the banner describe the current action/result, or change it to the timeless instruction “Inspect only looks. Fix it changes the drawing.” Keep the actual completion summary visible after apply, including any unconfirmed result.

3. **RD13-03 — LOW — SURE — Disable on Restart loses its pending-change explanation.**

   **What Tim or a colleague sees:** the drafter disables Civil for the next start, but the immediate refresh presents the normal loaded state without preserving an explanation that this start-up change is pending. The reversal button is a clue, but the main state does not explain that Civil is still running now and will not automatically start next time.

   **File and line:** `Modules/Manager/Services/CePluginRegistryService.cs:290`, `:384` and `:517`; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:559` and `:579`.

   **Verified by reading:** the successful setter writes the manifest and sets `descriptor.RestartRequired = true`. Its button handler immediately calls `LoadPlugins()`. Discovery constructs a new descriptor from the manifest, without restoring that pending flag. Status resolution returns `Loaded` first whenever the assembly is already in memory, even when start-up loading is now false. Reconstructing staged-update information does not reconstruct this separate start-up change. The manifest change itself succeeds; this finding concerns the discarded pending state, not failure to disable the start-up setting.

   **Exact failure scenario:** Civil is loaded normally, its start-up setting is enabled, and there is no staged update. A colleague clicks **Disable on Restart**. The same process keeps Civil loaded while the setting becomes disabled, and the rescan discards the flag intended to explain the difference.

   **DETERMINISTIC TEST:** in a disposable profile with that baseline, type `CEMANAGER`, open the **Module** page, select CE Civil Suite and click **Disable on Restart**. Wait for the automatic refresh. Assert `LoadOnAutoCADStartup` is false for the Civil main DLL entry while Civil remains loaded. Acceptance: persistent window text must explicitly say Civil is running now but will not automatically start next time; refresh and reopening Manager must preserve that explanation. Current code predicts `Loaded` without the pending explanation. Click **Enable on Restart** to restore the fixture and assert the pending disable message clears.

   **Smallest fix:** derive the displayed start-up state from both the loaded assembly and the saved start-up setting, or retain a separate pending start-up change across rescans. Keep this distinct from an update waiting to be installed.

4. **RD13-04 — LOW — SURE — View History can show another module's release notes.**

   **What Tim or a colleague sees:** the Civil history window can display Manager changes as if they belonged to Civil. A colleague checking whether a particular fix is in their Civil release can receive the wrong answer.

   **File and line:** `Modules/Manager/Services/CePluginInstallerService.cs:699`, `:706`, `:711`, `:720` and `:728`; `Modules/Manager/Services/CePluginRegistryService.cs:190`; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:706`, `:1275` and `:1333`.

   **Verified by reading:** for each available bundle, note discovery searches the bundle directory, its parent and its grandparent for every `*_Update_*.txt`. It parses all matches without checking the owning module. Those notes are copied onto the installed module's descriptor. **View History** renders that entire list in the selected module's window. A shared release directory is sufficient; no installation failure or malformed file is required.

   **Exact failure scenario:** a reachable office release directory contains a Civil bundle and both Civil and Manager update-note files beside it. Both file names match the wildcard. Selecting Civil's history picks up both bodies.

   **DETERMINISTIC TEST:** use an isolated office folder with one valid discoverable `AuditRelease\CE_CVL_SUITE.bundle`, matching the installed fixture version and with no competing Civil bundle. Beside it create `Civil_Update_20261023.txt` containing `Version 3.0.72` followed by `CIVIL-ONLY-NOTE`, and `Manager_Update_20261023.txt` containing `Version 1.1.72` followed by `MANAGER-ONLY-NOTE`. Type `CEMANAGER`, click **Refresh**, select Civil on **Module**, then click **View History**. Assert `CIVIL-ONLY-NOTE` is visible and `MANAGER-ONLY-NOTE` is absent. Current code predicts both. This test needs no staging or installation.

   **Smallest fix:** associate each notes file with its module through explicit release metadata or an exact module-specific naming rule. Do not import every matching notes file from shared ancestor directories.

1. **Coverage.** Read the Manager shell and button handlers, module/update status projection, first-install and update entry paths, command/history/older-version popups, Settings host and departure prompts, Help host, About, support routes, and embedded Survey Intake, Project Sheets, Project QA and Drawing Repair routes. Followed the four findings through the services that supply their state. Checked colleague/admin routing; administrator internals remain parked.

2. **What I did NOT check.** No real first installation, update, restart, drawing edit, command execution, network failure injection or support upload was performed. No builds, automated tests, screenshot rendering, dark/light visual inspection, display scaling, keyboard/accessibility exercise or off-screen window rendering was performed. The embedded Civil tools' engineering calculations and full Structural implementation were outside this Manager UX audit. Administrator workflows, updater deployment, binaries actually installed on the PC and code newer than the pinned refs were not validated. “Every window” was treated as a source-level route review, not proof that every runtime layout and state has been exercised. No suspected-only item is included in the four findings.

3. **Summary — 67 words.** Four new source-proven UX faults remain: a failed approval read can produce “CE is current”; Drawing Repair can deny changing a drawing after committing a repair; disabling start-up loses its pending explanation; and Civil history can import Manager notes. Two are MEDIUM and two LOW. Each has a concrete fixture, observable assertion and small fix. Runtime acceptance remains outstanding because this hunt was explicitly read-only.
