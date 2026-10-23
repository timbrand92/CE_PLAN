# RD20 — shared library audit — 24 October 2026 (Melbourne)

1. **ANSWER FIRST — 0 HIGH, 3 MEDIUM, 1 LOW.** Three findings are SURE from reading the code; one MEDIUM is UNSURE and needs the stated logging probe. None was tested in AutoCAD.

2. **Most important: opening another AutoCAD can create a false crash report.** CE mistakes the first, still-running session for one that failed to close. The office can investigate a crash that never happened; closing either session can also conceal the other session's later abnormal exit.

3. **Top three.** RD20-01: false crash records. RD20-02: loading Manager before Civil leaves CE Tools absent until a later status check. RD20-03: two AutoCAD sessions share an uncoordinated log writer and may overwrite evidence; this last outcome is suspected, not reproduced.

4. **Remaining finding.** With remembering window positions enabled, saving a position in the second AutoCAD can erase a different window position just saved in the first. No engineering values or drawing geometry are implicated by these findings.

---

1. **Scope and pins.** Git fetch completed. Civil/Manager reviewed at `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`; project versions are Civil 3.0.72 and Manager 1.1.72. Structural boundary checked at `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9`. These supersede the older refs in the opening brief. Installed binaries were not inspected. All Civil/Manager file:line references below refer to the pinned Git commit.

2. **Method.** Read RULES, ROUTER, the plan start/map and Manager area; searched BUG_CARPARK before tracing source; read the named 22 October audit and the Civil, Structural and gate CODEX_AUDIT reports. Used Git objects in detached worktree `C:\ce-cx\rd20`, without creating a branch. The worktree was clean and has been removed. Only this findings file was authored. No code edits, builds, tests, AutoCAD, installation or sub-agents.

3. **Known findings excluded.** BUG-522; BUG-528; BUG-828; BUG-850; BUG-853; BUG-887; BUG-958; BUG-1017; BUG-1028.

4. **Evidence terms.** SURE / verified-by-reading establishes the specified control flow and state loss. It does not mean native acceptance. UNSURE / suspected explicitly leaves the resulting runtime behaviour unproved. Every deterministic test below is a proposed test for the later AI tester, NOT RUN in this audit. Use disposable profiles and synthetic drawings; preserve and restore any test settings. Manager administrator development remains parked.

## Ranked findings

1. **RD20-01 — MEDIUM — SURE — a second AutoCAD is recorded as a crash of the first. Verified-by-reading.**

   **File:line:** `Shared/CE_SHARED/Services/CeTelemetryStore.cs:74`, `:100`; `Modules/Drainage/Services/AdminTelemetryService.cs:84`, `:126`, `:136`, `:159`, `:176`, `:437`, `:440`; startup caller `Modules/Drainage/PluginInitialization.cs:127`.

   **What the office sees:** a Critical failure record saying “The previous CE CVL session did not close cleanly.” The drafter merely opened another AutoCAD; the original session and its drawing are still working. This is a local diagnostic-record defect, not a claim that the parked office upload route works.

   **Exact failure:** the shared store gives every Civil process under the same Windows profile the same `sessions/CE_CVL_SUITE.json`. Startup reads that file and treats `CleanShutdown=false` as a crash, then writes its own false value. There is no process identity or live-owner check in the session model. Normal shutdown writes true to the same file. Thus A running -> B starts produces a false crash; B closes cleanly -> A later terminates abnormally can leave true behind and miss that abnormal exit.

   **DETERMINISTIC TEST — fixture and typed steps:** disposable Windows profile, the pinned Civil/Manager pair, no Structural, two separate AutoCAD processes A and B, each with an empty synthetic drawing. Pre-create the ordinary Manager data root so the known one-time folder migration does not confound this check. Start A; confirm its session JSON says `CleanShutdown=false`. Leave A open and start B. Type `CDDEBUG`, `Status` in both to establish that both Civil sessions are responding.

   **Assertion:** after B's diagnostic queue drains, no NEW failure JSON may have `Category="crash"`, `Severity="Critical"`, `IsCrashInference=true` and the quoted previous-session message while A is still alive. The source predicts exactly that false record. Capture the new failure file and its time; do not count historical failures. Quit both normally afterwards. A separate controlled abnormal-exit test is needed for the concealment consequence; it was not performed here.

   **Smallest fix:** give each session a unique owner record containing process identity and process start time. At startup, infer an abnormal exit only from an unclean record whose owner is no longer alive; shutdown may mark only its own record clean. Keep drafting available and keep this entirely outside the drawing database.

2. **RD20-02 — MEDIUM — SURE — Manager-first loading postpones CE Tools until an unrelated background check. Verified-by-reading.**

   **File:line:** `Modules/Manager/Services/CeUnifiedRibbonService.cs:61`, `:67`, `:156`, `:170`; `Shared/CE_SHARED/Services/CeRibbonRegistry.cs:23`; `Modules/Drainage/PluginInitialization.cs:253`; `Modules/Manager/Plugin.cs:143`, `:147`, `:160`, `:162`; `Modules/Manager/Services/CeReleaseStatusService.cs:200`, `:234`.

   **What a drafter sees:** CE Civil appears, but CE Tools, including its Manager, Version and Health buttons, is initially missing. Loading the same matching pair in the opposite order gives a different result. Typed Manager commands remain available.

   **Exact failure:** Manager's ribbon initialiser returns when the shared contributor list is empty, before hooking Idle. Civil registers later, but the registry sends no notification and Civil only queues its own tab. The independent CE Tools tab is built only through Manager's full build. Normal recovery waits for 15 seconds, completion of update staging, then a timer whose first poll is another 20 seconds later. A changed status finally requests the ribbon build. Slow staging extends this delay; the code provides no contributor-arrival wake-up. The future unified-host adapter has its own request, but that is not the ordinary standalone startup route.

   **DETERMINISTIC TEST — fixture and typed steps:** fresh AutoCAD 2027 test profile with a visible ribbon and automatic CE loading suppressed for this test only; use complete disposable copies of the matching pinned bundles. Type `NETLOAD` and select Manager's Modern DLL first, then `NETLOAD` Civil's Modern DLL. A debugger/test scheduler holds only Manager's queued background work before its status monitor starts; AutoCAD's UI and Idle keep running. Inspect the ribbon after Civil's log says `Standalone CE Civil ribbon built:`. Repeat in a fresh process with Civil loaded before Manager. Release the held background work at the end.

   **Assertion:** both orders must expose one tab with visible title `CE Tools` at the next ready Idle, with a `Version` button, without needing status polling. Current code reaches that state only in the Civil-first run. For the failing order, releasing the work and observing the first Changed event should cause CE Tools to appear. This checks the actual built ribbon, not just the contributor definitions.

   **Smallest fix:** always queue Manager's initial ribbon build, even with zero contributors, so its own Tools tab is independent. Notify Manager when a contributor is added, or use another bounded UI-thread scheduling mechanism for late contributors. Keep status-only refreshes separate from rebuilding Civil's tab.

3. **RD20-03 — MEDIUM — UNSURE — simultaneous AutoCAD sessions may overwrite the main Civil log. Shared-file construction verified-by-reading; lost-line outcome suspected.**

   **File:line:** `Shared/CE_SHARED/Services/CeLogWriter.cs:275`, `:283`, `:307`, `:360`; `Modules/Drainage/Services/LoggingService.cs:68`, `:92`; skipped-line counter `Shared/CE_SHARED/Services/CeLogWriter.cs:133`, `:162`.

   **What the office could see:** a support log that has lost part of the second AutoCAD's startup or command history, while CDDEBUG reports no skipped messages. That would undermine diagnosis of the kind of real-AutoCAD failure this hunt addresses.

   **Exact suspected scenario:** each process opens the same `CE_CVL_SUITE.log` through a long-lived append FileStream with `FileShare.ReadWrite`. There is no session suffix, interprocess lock or coordinated append/rotation protocol. The queue protects only one writer instance. A second writer can extend the file while the first still owns an earlier stream position. Whether the target runtime's append handling overwrites those bytes must be measured; this audit does not certify Windows/.NET behaviour from the constructor alone. The dropped counter counts queue overflow, not file-write failures or overwritten records.

   **DETERMINISTIC TEST — controlled fixture:** on each supported runtime, create two actual `CeLogWriter` instances A and B pointing at one temporary CE log. Set the size limit well above the test size. Use each writer's `forward` callback as acknowledgement after a WARN write has flushed. A writes `RD20-A0`; wait for acknowledgement. B writes `RD20-B0` plus 128 ASCII padding characters; wait. A writes `RD20-A1` plus 4096 ASCII padding characters; wait. Dispose both. Do not run simultaneous producers: this order deliberately tests stale positions without a timing race.

   **Assertion:** the resulting CE log contains all three complete markers exactly once. Both dropped-line counts should be recorded. If all markers survive on a runtime, the predicted overwrite is not confirmed there; do not turn this into a SURE finding without evidence.

   **AutoCAD confirmation:** use two disposable AutoCAD sessions sharing the same redirected log folder. Type `CDDEBUG`, `Status` in A, then B, and record both startup blocks. With A's writer temporarily frozen by the debugger after opening its handle, let B finish writing; resume A and type `CDDEBUG`, `Status` repeatedly until it has written more bytes than B's captured block. Assert that every captured B startup line still exists intact in the CE log. The controlled writer fixture above supplies the exact ordering check; the native check confirms the production caller reaches the same problem.

   **Smallest fix if confirmed:** use a separate file per AutoCAD process/session and have support collection include those files. Alternatively serialise append and rotation across processes, reopening/seeking under that lock on the background writer only. Do not move disk waits onto AutoCAD's drawing thread.

4. **RD20-04 — LOW — SURE — the second AutoCAD can erase a different window's newly saved position. Verified-by-reading; remembering is OFF by default.**

   **File:line:** `Shared/CE_SHARED/Services/CeWindowPlaceStore.cs:138`, `:147`, `:148`, `:149`, `:160`; `Modules/Drainage/Services/CeWindowPlacementHook.cs:154`, `:167`; `Modules/Drainage/Models/UserSettings.cs:2564`. Reachable Manager windows: `Modules/Manager/Commands/PluginManagerCommands.cs:32`, `:48`, `:50`; their XAML sets CenterScreen.

   **What a drafter sees:** after arranging Manager in one AutoCAD and About CE in another, Manager later opens back in its old position. The second action concerned a different window; it should not undo the first preference.

   **Exact failure:** both processes cache the entire shared `window-places.txt` once. Saving updates one entry in that process's old list, then replaces the whole file without re-reading or merging. A process-local lock cannot protect against the other process. This happens with sequential saves: it needs no simultaneous write race. The fixed `.tmp` name and delete-before-move also deserve recovery coverage, but no separate additional finding is counted for them.

   **DETERMINISTIC TEST — fixture and typed steps:** disposable profile with `windowPlacement.remember=true`, a single unchanged monitor layout, and an initial position file containing distinct rows for `CE_SUITE_MANAGER.UI.Dialogs.PluginManagerWindow` and `CE_SUITE_MANAGER.UI.Dialogs.CeVersionWindow`. Start AutoCAD A and B with the pair loaded. In both, type `CEMANAGER` and close it without moving, so both cache the initial file. In A, type `CEMANAGER`, drag it to a clearly different on-screen position and close. Record the Manager row from the saved file. In B, type `CE_VERSION`, drag About CE elsewhere and close. Read the file again, then restart A and type `CEMANAGER`.

   **Assertion:** B's save must retain A's exact Manager row while updating only the About row; the restarted Manager must open at A's saved position. Current code writes B's stale Manager row. Assert stored coordinates first and window position second, allowing only normal OS frame rounding. This avoids the separate existing editor-window placement problem.

   **Smallest fix:** under an interprocess lock, re-read the current file, apply only the changed window/layout entry, then atomically replace it using a unique temporary file. Do not merge a whole stale snapshot. Preserve the last good file and surface a failed save once.

## What was checked without a new finding, and what was not checked

1. **Shared identity and first-loaded copy.** Civil and Manager reference the same shared project at this pin. CE_SHARED retains assembly version 1.1.0.0. Manager's release packaging requires Civil's approved per-runtime shared file and checks its hash after copying (`Modules/Manager/CE_SUITE_MANAGER.csproj:175`, `:192`, `:210`, `:216`). No additional mismatched-copy defect beyond the excluded BUG numbers was proved. Actual installed hashes and which file AutoCAD loaded were not read.

2. **Structural boundary.** The separately pinned Structural project conditionally includes CE_SHARED only for future unified-host adapters. Ordinary packaging excludes it and checks that the standalone binary/dependency manifest has no shared-library reference. The older Structural project on the Civil branch was not treated as the installed Structural release.

3. **Registry, palette and threads.** Read the shared ribbon/Inspector registrations, command-registry loaders, ribbon dispatch/theme handling, contextual tabs, runtime paths, log writer, telemetry store and window-position store, with Civil/Manager caller checks. Registry paths are supplied from the calling module's assembly. The main shared log worker performs file work, not AutoCAD drawing calls. Manager marshals status-triggered ribbon requests through its UI dispatcher. No additional actual caller demonstrating a thread violation or a broken palette contract was established. Helper-only possibilities were not promoted to findings.

4. **Not checked.** No native load-order experiment, DLL hash comparison, malformed-package experiment, real log inspection, drawing edits, window pictures, Undo/Redo test, performance measurement or older-AutoCAD runtime test. No test described above ran. Engineering calculations, installer/update implementation changes and parked Manager administrator work were outside this task. These findings do not mark any bug fixed or any build accepted.

## Summary

1. **Summary — 78 words.** Four new items: three MEDIUM and one LOW, with no HIGH. The clearest fault records a still-running AutoCAD as a crashed previous session. Manager-first loading delays CE Tools until background status work runs. Concurrent log writers need a deterministic runtime probe before lost lines can be claimed. Window-position saves can overwrite another session's unrelated preference. Existing bugs were excluded. Only this report changed; the detached reading worktree was removed. No build, test, installation or AutoCAD session was run.
