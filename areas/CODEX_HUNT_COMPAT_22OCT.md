1. **ANSWER FIRST — HIGH 1 / MEDIUM 2 / LOW 0.** Three additional faults, all VERIFIED-BY-READING. No AutoCAD reproduction was performed. Earlier audit findings are excluded.

2. **Most important: Structural stops starting in a second AutoCAD process.** Open two separate AutoCAD windows under the same Windows sign-in, including different AutoCAD years. Structural starts in the first but skips its normal startup in the second, incorrectly saying another copy is active in that same AutoCAD session. Its ribbon and background drawing services are not started there.

3. **The other two:** Manager can mistake Structural's helper library for the suite and hide Load Now; Civil keeps saying its pipe-object file is unavailable after a successful late load. Each has a repeatable test below for the AI test lane.

4. **What changed.** Only this findings file. No plugin edits, branches, builds, tests, AutoCAD, installations or sub-agents. Civil + Manager's 9 November delivery remains the priority; Manager administrator work remains parked. These findings do not authorise new drafting hard blocks or engineering defaults.

---

1. **Scope and source identity.** Independent compatibility hunt for desk plan/03, brief dated 22 October; completed 23 October 2026, Melbourne. Read Git objects after fetching origin in C:\Lisp Files\CE_ACAD_PLUGIN. Civil/Manager head: origin/claude/rel-20261022m, 40ee0a36f7960145743954b39859eb6c3af92869. Structural head: origin/claude/rel-20261022s2, 2c9a96942a024888a5ab520600f2d5025de83036. These are the nominated 3.0.70 / 1.1.70 / 1.0.121 sources; this hunt did not inspect installed DLL bytes.

2. **Prior work excluded.** Consulted AUDIT_C58_C60_S40_S41_2026-10-22.md and CODEX_AUDIT_CIVIL_22OCT.md, CODEX_AUDIT_STRUCTURAL_22OCT.md and CODEX_AUDIT_GATE_22OCT.md before the hunt. Also checked CODEX_HUNT_MANAGER_22OCT.md and relevant older hunt/bug matches. Not recounted: separate Civil/Manager activation permitting CE_SHARED mismatch; installer/approval gaps; missing old-year pipe enablers; stale Structural in the Civil branch; About's missing shared-file health; CEHEALTH's missing NotLoaded branch; outcome logging and double-click faults.

3. **Evidence meaning.** VERIFIED-BY-READING means the stated control flow is present at the pinned head and produces the stated result under the explicit fixture conditions. All deterministic tests below are NOT RUN. No finding is marked fixed or accepted. Speculation about actual Autodesk loader order, installed hashes or an unobserved crash is not counted as a defect.

4. **Test ownership.** The later AI tester prepares disposable profiles and synthetic drawings, records the actual AutoCAD year/update and process, and preserves ordinary trust controls. The fixture preparation below is a future test instruction, not work performed by this hunt. No client drawing or live settings file is required.

---

1. **COMPAT-01 — HIGH — a second AutoCAD process is refused Structural startup. VERIFIED-BY-READING.**

   **File:line:** Structural head, Modules/Structural/Plugin.cs:76, :125, :133, :142, :178, :187, :190, :203, :451, :455, :467.

   **What happens in AutoCAD:** A drafter keeps the current job open in AutoCAD 2027 and opens a separate AutoCAD 2024 or 2027 process to check another drawing. The second process misses Structural's startup services and CE STRUC ribbon. Restarting only that second process while the first remains open repeats the problem.

   **Exact failure scenario:** RuntimeMutexName is the fixed name Local\CE_STRUC_SUITE.PluginRuntime. TryAcquireRuntimeMutex treats createdNew=false as a duplicate runtime, disposes its handle and returns false. Initialize then sets IsLoaded=false and returns before settings, drawing monitors, autosave, CETOOLS and ribbon initialisation. There is no process identifier or AutoCAD-year boundary in the name.

   **Why this is proved:** Local\ scopes a named Windows mutex to the Windows login/session namespace, not to one acad.exe. Two processes in that session therefore address the same object. This is documented by [Microsoft's Mutex contract](https://learn.microsoft.com/en-us/dotnet/api/system.threading.mutex?view=net-10.0). The code's warning incorrectly describes the scope as this AutoCAD session. This finding does not claim every Structural command disappears: command registration and later lazy initialisation are separate from the startup code that is skipped.

   **DETERMINISTIC TEST — fixture:** Two genuinely separate full AutoCAD processes under one Windows sign-in, matching accepted Structural lane in each, fresh profiles without a preloaded CE CUIX, synthetic blank mm drawings. Use two 2027 processes first, so any 2022/2024 dependency problem cannot mask the guard. Confirm distinct process IDs. Keep process A running throughout B's first test.

   **Typed steps:** In A, NETLOAD the Structural Modern DLL and let startup finish. In B, NETLOAD that same release's Modern DLL and return to the command prompt. Capture B's command history and ribbon. Close A normally, close B, then start B alone and repeat. Repeat the two-process case with A=2027 and B=2024 using Legacy in B; 2022 and 2026 are further year controls when available.

   **Assertion:** Both independent processes must complete Structural startup. Current B is predicted to print "[CE_STRUC_SUITE] Another plugin runtime is already active in this AutoCAD session. Restart AutoCAD before loading a new build so background services do not stack." B must instead reach its normal "[CE_STRUC_SUITE] ... loaded." banner and create the CE STRUC tab. The B-alone control must pass these checks. Do not use CE_VERSION alone as proof of successful initialisation: it lists assemblies, not completed startup.

   **Correction direction:** Keep duplicate-instance protection within a single AutoCAD process, for example with a process-scoped name. Do not remove protection against two copies inside one process, and do not introduce a new cross-process drafting prohibition. This also explains why a headless test can miss the fault: IsCoreConsole returns at :113 before the mutex path.

2. **COMPAT-02 — MEDIUM — Manager mistakes a Structural dependency for a loaded suite and removes the recovery action. VERIFIED-BY-READING.**

   **File:line:** Civil/Manager head, Modules/Manager/Services/CePluginRegistryService.cs:306, :309, :518, :529, :537; Modules/Manager/Services/CePluginDescriptor.cs:173, :187, :199; Modules/Manager/UI/ViewModels/PluginManagerWindowViewModel.cs:159, :188; Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:126, :152. Structural helper identity comes from Modules/Structural.DesignCore/CE_STRUC_SUITE.DesignCore.csproj:1 and its project filename; Structural references it at Modules/Structural/CE_STRUC_SUITE.csproj:174.

   **What happens in AutoCAD:** The Structural program is absent from the session, but one of its helper libraries remains loaded after diagnosis or an incomplete load. CEMANAGER labels Structural LOADED and offers its commands, while hiding Load Now. CESTRUC is unavailable. This is distinct from the earlier CEHEALTH defect: here the discovery result itself is incorrectly Loaded.

   **Exact failure scenario:** IsAssemblyLoaded uses assembly.GetName().Name.StartsWith(pluginId), with no boundary or identity check. CE_STRUC_SUITE.DesignCore therefore satisfies CE_STRUC_SUITE even though it contains no Structural AutoCAD command entry point. ResolveStatus returns Loaded before checking the startup flag. CanLoadNow requires NotLoaded, and TryNetLoad independently refuses Loaded. The exact-name loaded-evidence code elsewhere does not repair that descriptor: the window takes StatusLabel and CanLoadNow from it.

   **DETERMINISTIC TEST — fixture:** Disposable AutoCAD 2027 profile with the nominated Civil/Manager pair and Structural bundle present on disk, automatic bundle loading suppressed for this test, fresh blank drawing. Manually load Civil then Manager, leaving Structural's main DLL unloaded. Its manifest stays enabled so a genuinely unloaded suite should offer Load Now. All files remain in trusted fixture locations.

   **Typed steps:** Type CE_VERSION: assert Structural Suite says Not loaded. Type CESTRUC: assert Unknown command. Type CEMANAGER and select CE Structural Suite: record NOT LOADED and Load Now, then close the window. NETLOAD only Contents/Win64/Modern/CE_STRUC_SUITE.DesignCore.dll. Reopen CEMANAGER and select the same row; run CE_VERSION and CESTRUC again.

   **Assertion:** Loading only the helper must leave Structural NOT LOADED and Load Now visible. Current source predicts the module list changes to LOADED and Load Now disappears, while CE_VERSION still says Not loaded and CESTRUC is still unknown. The Running now detail can remain unknown; do not incorrectly assert that every independent version field changes. Finally NETLOAD the actual Structural main DLL as a positive control: commands should then exist and LOADED becomes appropriate. Repeat with Legacy in 2024 and Net8 in 2026.

   **Related failed-start case:** COMPAT-01 leaves the main Structural assembly present but Plugin.IsLoaded=false. Manager still reports Loaded because it never reads startup completion. Exact assembly matching fixes the helper confusion; truthful readiness also needs an explicit startup result. This related case is not counted twice.

   **Correction direction:** Match the main assembly identity exactly, or validate explicitly supported alternate names, then keep assembly presence separate from successful suite startup. This concerns existing loading/status behaviour, not parked administrator development.

3. **COMPAT-03 — MEDIUM — recovering the native pipe enabler does not recover Civil in the same session. VERIFIED-BY-READING.**

   **File:line:** Civil head, Modules/Drainage/Services/NativeObjects/CeCvlObjectsBridge.cs:78, :86, :90, :93, :97, :129, :200, :299; Modules/Drainage/Commands/NativePipeObjectCommands.cs:42, :49, :51; Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeOnOpenService.cs:53; Modules/Drainage.NativeObjects2027/CeCvlObjectsApi.cpp:149.

   **What happens in AutoCAD:** Civil checks for the pipe-object file while it is unavailable. The file is subsequently loaded successfully, but Civil still refuses pipe-object commands as though it were missing. The drafter must restart AutoCAD; simply correcting the load in the current session does not restore the feature.

   **Exact failure scenario:** The first DllNotFoundException, EntryPointNotFoundException or BadImageFormatException stores _available=false. Every subsequent IsAvailable immediately returns that cached value. No reset, retry or module-loaded notification updates it. Recognition, editing and splitting checks also consult that cached state. The correct enabler at this head returns API version 4, satisfying RequiredApiVersion=4, but the second query never reaches it.

   **DETERMINISTIC TEST — fixture:** Disposable AutoCAD 2027 profile, automatic fixture loading suppressed, blank mm drawing, nominated Civil Modern DLL and dependencies in a trusted scratch location. Initially hold CE_CVL_OBJECTS_2027.dbx outside all probe/load locations. Use isolated settings with options.pipeObjectUpgrade="On"; otherwise the separate colleague hold prevents this test reaching IsAvailable. Do not change the colleague default in a delivered package.

   **Typed steps:** NETLOAD Civil. Type CDPIPEOBJ and capture "[CE] CDPIPEOBJ needs the CE pipe object enabler (AutoCAD 2027 only). Nothing was drawn." Confirm the CE log contains "[C7] CE_CVL_OBJECTS_2027.dbx is not loaded; one-object pipes are unavailable in this AutoCAD." Restore the exact accepted DBX to the trusted fixture location; type ARX, Load and select it. Record successful native loading. ARX's Load option accepts an ObjectARX/DBX file, as documented in [Autodesk's ARX command reference](https://help.autodesk.com/cloudhelp/2022/ENU/AutoCAD-Core/files/GUID-477DDABE-C3D3-47A2-B481-60401C50492F.htm).

   **Assertion:** Type CDPIPEOBJ again. Once the valid DBX has loaded, the command must reach "First point of the pipe object:"; press Esc there, so no pipe is created. Current source predicts the same missing-enabler refusal instead. Positive control: restart the disposable session, load the DBX before Civil, then CDPIPEOBJ must reach that first-point prompt. If native loading itself fails, classify the fixture as blocked, not a reproduction of this cache defect.

   **Scope limit and correction direction:** The ordinary automatic startup order was not measured, so this report does not claim it always hits the cache. Missing/late native loading is the explicit scenario. Retry a negative availability result after a successful load or at an explicit recovery action. Preserve API-version checks; do not try loading a 2027 DBX into 2022–2026. The missing old-year enabler remains the earlier audit's finding.

---

1. **Managed years — checked configuration, not a runtime pass.** Civil and Manager manifests route R24.1–R24.9 to Legacy, R25.0–R25.9 to Net8, and R26.0 onward to Modern. Structural uses the same first two ranges and caps Modern at R26.9. References: Installer/PackageContents.xml:18/:78/:138; Modules/Manager/Installer/PackageContents.xml:11/:34/:57; Structural Modules/Structural/Installer/PackageContents.xml:16/:72/:128. No overlapping lane within those manifests was found for 2022–2027.

2. **2026 runtime nuance.** AutoCAD 2026 through Update 1.1 uses .NET 8; Update 1.2 onward uses .NET 10. Autodesk says the update changes the runtime without changing its APIs, and existing add-ins should continue unless affected by runtime breaking changes. Thus a folder named Net8 is not, by itself, a defect on patched 2026. Test both patch levels; do not load the 2027 API/native lane merely because the host runtime is now .NET 10. Sources: [Autodesk compatibility guide](https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Customization/files/GUID-A6C680F2-DE2E-418A-A182-E4884073338A.htm), Autodesk Developer Blog article titled "Autodesk Desktop Products 2025/2026: .NET 10 Updates" (24 July 2026).

3. **CE_SHARED and coexistence.** Shared/CE_SHARED/CE_SHARED.csproj:15 fixes AssemblyVersion at 1.1.0.0. Manager's packaging target requires approved Civil hashes for each lane, copies that approved CE_SHARED over its locally built copy and checks the result (Modules/Manager/CE_SUITE_MANAGER.csproj:179/:207). This supports the byte-identical rule but does not prove installed hashes. Structural's nominated standalone head defaults EnableUnifiedHostAdapters=false and removes the adapter source/reference paths; release packaging rejects true (Modules/Structural/CE_STRUC_SUITE.csproj:7/:161/:164/:331). Do not use the stale Structural project in the Civil branch to assess this pair. Actual Civil-first/Manager-first and Structural-first/Civil-first native runs remain owed.

4. **Native years.** Civil grip ARX and pipe DBX manifest entries are restricted to R26.0–R26.9 (Installer/PackageContents.xml:199/:207). Structural's CE_STRUC_NATIVE_2027.arx is in its Modern block at :184. A 2024 enabler project exists but explicitly says it is not staged (Modules/Drainage.NativeObjects2024/CE_CVL_OBJECTS_2024.vcxproj:5). Existing native-pipe drawings on older years remain covered by the prior release-gate audit; no new count is assigned here.

5. **Reflection and older binding — unproven risks, not additional findings.** Civil Settings bridge discovery validates a unique public static factory, parameters and return type before invoking it (Modules/Manager/Services/CeCivilSettingsBridgeSession.cs:460). The Project/Sheets bridge likewise validates its signature (:527 in CeProjectSheetsBridgeSession.cs). No concrete overload-selection defect was found there. Structural still directly references AdWindows for net48 (its csproj:128), while CE_SHARED excludes legacy ribbon consumers to avoid the documented-in-source 2022 binding concern. Without artifact metadata and a real 2022 load, a Structural binding failure is SUSPECTED, not proved. Later check: fresh 2022 profile, NETLOAD the nominated Legacy Structural DLL, require normal loaded banner and CE STRUC tab; capture the exact missing assembly identity if it fails. A successful 2024 test does not settle that 2022 check.

6. **What remains untested.** Every native scenario, actual payload hashes/assembly references, trust-policy behaviour, 2022–2024 API execution, 2026 patch-level behaviour and visible windows. No builds or tests were run. Only this report is to be committed by name in C:\CE_PLAN; source repositories remain read-only. Undo for the authored deliverable is a subsequent revert of its report-only commit.

7. **Save/push handoff — blocked.** Report-only commit fcdac825 was refused by the pre-push leak scanner: an official Autodesk article URL matched its key-shaped text pattern. The citation was replaced with the article title/date in report-only correction 126943e3. During that correction another chat committed f35a3922; an attempted amendment caught that intervening commit. Its exact original commit was restored before the correction was saved. No other file content was altered. The scanner examines historical added lines, so the first report commit still prevents pushing despite the corrected current file. Resolving that requires coordinated repair of unpublished history; this hunt has not rebased or rewritten the other chat's restored commit, and has not bypassed the hook.

---

1. **Summary.** Three new source-proven faults: Structural's guard wrongly spans separate AutoCAD processes; Manager counts a helper library as the loaded suite and hides Load Now; Civil caches a failed native-enabler lookup for the whole session. Each has an isolated, deterministic AutoCAD test and a positive control. Shared-file pairing and missing old-year enablers remain with earlier audits. The year ranges are present, but no runtime compatibility pass is claimed. No code changed, no build or test ran, and no bug was marked fixed.
