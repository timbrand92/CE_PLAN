1. **ANSWER FIRST — six new findings: HIGH 1 / MEDIUM 4 / LOW 1.** Independent diagnostics and logging audit, completed 26 October 2026, Melbourne. The requested filename retains 24OCT. All six are SURE, verified-by-reading; none has been reproduced in AutoCAD by this audit.

2. **Most important — a fault-report folder can stop Structural starting properly.** If Windows refuses to create that folder, Structural abandons the remaining start-up work, including linked-beam monitoring, footing monitoring and automatic backups. A support feature must not stop drafting services.

3. **Second — CEHEALTH can overlook a damaged Civil installation.** A missing or damaged installation description makes Civil disappear from its checks. With the other checks passing, it can still print “All checks passed”.

4. **Third — Civil can lose log entries without telling support.** A read-only main log discards new lines without the skipped-message notice. Asking to clear it still prints “log cleared”, although the old contents remain.

5. **Other findings and next step.** Support collection drops oversized rotated Civil logs and never collects Manager's new command-outcome log. Three daily log streams have no retention limit. The later AI tester should use the synthetic cases below; Tim is not being asked to test. Structural is separate from the Civil + Manager handover on 9 November. Manager administrator work remains parked.

---

1. **Scope and source identity.** Read RULES.md, ROUTER.md, START_HERE.md, the plan map and Area M. Searched BUG_CARPARK.md before source inspection and again against each candidate. Read the supplied C58/C60/S40/S41 audit and the Civil, Gate and Structural CODEX_AUDIT reports dated 22 October. Used Git objects after fetching origin, with a detached, clean worktree at `C:\ce-cx\rd24`; that worktree was removed after inspection. No branch or code commit was created.

2. **Pinned versions.** Civil/Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, Civil 3.0.72 / Manager 1.1.72. Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9`, source version 1.0.122. Structural files were read with `git show` at that separate ref, not taken from the Civil branch. These are audited source identities, not a claim about the binaries currently running on Tim's PC.

3. **Evidence and severity.** SURE means the specified control flow is proved from these sources. It does not mean an AutoCAD test passed. HIGH means a diagnostic fault prevents core services starting; MEDIUM means misleading health or missing support evidence; LOW means cumulative log storage growth. Every DETERMINISTIC TEST below is proposed and NOT RUN. Use disposable profiles, synthetic drawings and copies of the pinned packages; never alter Tim's installation or live logs for these cases.

4. **Known findings excluded from the new count.** BUG-228, BUG-442, BUG-484, BUG-789, BUG-796, BUG-820, BUG-853, BUG-862, BUG-937, BUG-946, BUG-1026, BUG-1027, BUG-1076, BUG-1168, BUG-1180, BUG-1205, BUG-1207, BUG-1210.

**Numbered findings — ranked**

1. **RD24-01 — HIGH — SURE — diagnostics-folder creation aborts Structural start-up. Verified-by-reading.**

   **File:line:** Structural `Modules/Structural/Services/RuntimeDiagnosticsService.cs:103`, `:106`, `:107`; `Modules/Structural/Plugin.cs:141`, `:172`, `:179`, `:187`, `:299`, `:306`. The earlier main-log initialiser has the same unguarded directory operation at `Modules/Structural/Services/LoggingService.cs:135`.

   **What a drafter sees:** Structural prints a load error and does not finish starting its normal services because it cannot create a folder used only for recording diagnostics. Existing linked objects then lack the normal start-up monitoring, and scheduled backup initialisation has not been reached. This is a real drafting consequence of a logging failure, not just a missing support file.

   **Exact failure scenario:** Settings and the ordinary log folder are writable, but `%APPDATA%\CE_STRUC_SUITE\Logs\RuntimeDiagnostics` is absent and its parent denies creation of subfolders. `Directory.CreateDirectory` throws before subscriptions and before `_initialized` becomes true. There is no local catch. `Plugin.Initialize` catches it only around the entire start-up sequence, sets `IsLoaded=false` and skips beam-link reactors, footing monitoring, autosave and ribbon initialisation. The diagnostics-enabled setting does not guard directory creation. No assertion is made that all typed commands become unavailable: some commands can initialise their own dependencies.

   **Smallest fix:** Contain log-directory failures inside the two logging initialisers. Continue service/event initialisation with file logging unavailable, remember the failure and give one plain warning on the AutoCAD thread. Do not let an optional log directory abort the plugin, including when diagnostics are switched off.

   **DETERMINISTIC TEST — fixture:** Disposable Windows profile with a previously valid Structural settings file, writable `TIM_CE_CADTOOLS\logs`, and a pre-created `CE_STRUC_SUITE\Logs` parent. Leave `RuntimeDiagnostics` absent and deny only creation of that child. Use an empty millimetre drawing. An ordinary file named `RuntimeDiagnostics` in that parent is an alternative deterministic directory-collision fixture.

   **Steps and assertions:** Start a fresh AutoCAD session with the pinned Structural package and open the synthetic drawing. Capture the command-line start-up text; type `CE_HELP`, then close Help. Current source predicts `[CE_STRUC_SUITE] Load error:` mentioning the denied/colliding directory, with no normal final version-loaded line. After the fix, require the normal version-loaded line and a warning that diagnostics cannot be recorded, with no suite load error. A host probe must also read `_initializationCompleted=true` and confirm the beam, footing and backup initialisers were reached. Repeat with DiagnosticsEnabled=false; it must still start. Restore the fixture permissions and repeat as the control.

2. **RD24-02 — MEDIUM — SURE — CEHEALTH silently omits a bundle with a missing or unreadable manifest. Verified-by-reading.**

   **File:line:** `Modules/Manager/Services/CePluginRegistryService.cs:45`, `:46`, `:61`, `:349`, `:350`, `:352`; `Modules/Manager/Commands/PluginManagerCommands.cs:214`, `:217`, `:250`, `:275`; `Modules/Manager/Services/CeHealthChecks.cs:35`.

   **What a drafter sees:** Civil will not load after an incomplete copy or damaged installation file, but the health command can say everything passed. It does not identify the damaged Civil folder or tell the colleague which installation needs attention.

   **Exact failure scenario:** One `CE_CVL_SUITE.bundle` exists in a scanned plugin root, its DLL is present, but `PackageContents.xml` is missing or contains invalid XML. `ParseBundle` returns null; discovery skips it without a diagnostic. An office-build descriptor, if added later, is uninstalled and skipped by CEHEALTH. The Civil/Manager pair check receives null and also produces no line. Duplicate detection only reports more than one folder, so this single damaged folder creates no issue. With a healthy Manager and a reachable office folder, the final issue count can remain zero. This is the unreadable-installation case, not an ordinary recognised-but-not-loaded plugin.

   **Smallest fix:** Preserve a failed-discovery result containing the bundle identity/path and reason. Have CEHEALTH count and print it while continuing the remaining checks. Do not equate “could not read this installation” with “not installed”.

   **DETERMINISTIC TEST — fixture:** Disposable profile with a healthy Civil/Manager pair, no duplicates or other installed plugins, and a reachable office IT folder. First confirm baseline `CEHEALTH` reports both tools without issues. Close that test AutoCAD and replace only the copied Civil `PackageContents.xml` with the literal text `<broken`.

   **Steps and assertions:** Restart, open an empty synthetic drawing, type `CEHEALTH`. Require an issue naming `CE_CVL_SUITE.bundle` and its unreadable installation description; the ending must not be `All checks passed.` Current source omits Civil and can print that ending. Repeat with the manifest absent, then restore the original and verify baseline again. A source-level fixture should also assert discovery returns a failed-installation record instead of losing the folder.

3. **RD24-03 — MEDIUM — SURE — Civil hides disk-write failures and confirms a failed Clear as successful. Verified-by-reading.**

   **File:line:** `Shared/CE_SHARED/Services/CeLogWriter.cs:133`, `:159`, `:275`, `:293`, `:307`, `:328`; `Modules/Drainage/Services/LoggingService.cs:45`, `:92`, `:323`; `Modules/Drainage/Commands/LinkCommands.cs:849`, `:851`, `:855`, `:859`.

   **What a drafter or support sees:** The command line identifies the usual main log as though it is usable, but new work is missing from that file. “CDDEBUG log cleared” can be false. Support may inspect old lines and believe they cover the attempted reproduction.

   **Exact failure scenario:** The log directory exists and is writable, but `CE_CVL_SUITE.log` itself is read-only before AutoCAD starts. Writer construction succeeds because opening the file happens on the background thread. Each append failure is swallowed and the dequeued entry is lost. `DroppedLineCount` only counts queue overflow, not disk failures, so CDDEBUG Status has no skipped-line warning for this case. Clear enqueues a request with no result; its later `WriteAllText` failure is swallowed, although the command already printed success. A separate structured log may retain duplicate messages: this finding concerns the main file and the false status/clear confirmation, not a claim that every logging destination loses them.

   **Smallest fix:** Track file-open/write/flush/clear failures separately from queue overflow, expose the last failure and successful-write state to CDDEBUG, and confirm Clear only after the writer acknowledges success. Keep drawing work independent of logging. Emit one plain warning rather than a warning on every dropped line.

   **DETERMINISTIC TEST — fixture:** Disposable Civil profile, existing main log containing `RD24_KEEP`, with only that file read-only. Keep the directory and settings writable. Record its bytes before launch.

   **Steps and assertions:** Start AutoCAD; type `CDDEBUG`, `Status`, then `CDDEBUG`, `Clear`. After the writer has processed the request, read the file and command-line transcript. Current source retains `RD24_KEEP`, adds no new main-log entries, gives no disk-failure notice and prints `CDDEBUG log cleared.` Require an explicit file-write/clear failure and no success claim. Remove the read-only attribute, repeat Status/Clear and verify actual clearing and subsequent new entries. The later pure writer test must wait for queue completion, not use an arbitrary sleep, and distinguish disk failures from queue overflow.

4. **RD24-04 — MEDIUM — SURE — support collection rejects the Civil logs that normal rotation produces. Verified-by-reading.**

   **File:line:** `Shared/CE_SHARED/Services/CeLogWriter.cs:40`, `:43`, `:49`, `:287`, `:348`, `:367`, `:378`; `Modules/Manager/Services/CeSupportBundleService.cs:24`, `:145`, `:199`, `:200`.

   **What the office sees:** A colleague makes the requested support zip after a busy diagnostic session. The useful earlier Civil history remains on their PC but is absent from the zip. Its notes say “bigger than 5 MB”, requiring another collection round.

   **Exact failure scenario:** Civil rotates at 5,242,880 bytes, checking size only every 500 written lines; an ordinary rotated `.log.1` or `.log.2` can therefore exceed that threshold. CESUPPORT accepts those filenames but rejects any file larger than exactly the same threshold. Thus correctly rotated recent logs are commonly excluded. Exactly-at-threshold files are accepted; the claim is not that every possible rotated file is rejected. Duplicate structured logs can help, but their seven-file retention does not guarantee recovery of all history in a primary log accumulated over a longer period.

   **Smallest fix:** Keep the size protection, but include a bounded, scrubbed tail from recognised oversized logs and state clearly how much was omitted. Do not silently raise the limit without bounding zip size or read the entire large file merely to trim it afterwards.

   **DETERMINISTIC TEST — fixture:** Synthetic profile with a recent `CE_CVL_SUITE.log.1` of exactly 5,242,881 ASCII bytes, ending with a complete `RD24_ROTATED_ERROR` line. Main and structured logs contain no copy of that marker. This represents a valid rotation overshoot; make its last-write date today so age filtering cannot explain exclusion.

   **Steps and assertions:** In the disposable AutoCAD session type `CESUPPORT`, open the generated zip and its `WHAT_IS_IN_THIS_ZIP.txt`. Current source excludes the rotated file and lists `bigger than 5 MB`. Require a bounded text entry containing `RD24_ROTATED_ERROR` and an explicit truncation note. Repeat at exactly 5,242,880 bytes as the boundary control; that file is currently accepted.

5. **RD24-05 — MEDIUM — SURE — Manager's new command-outcome log is absent from the support zip. Verified-by-reading.**

   **File:line:** `Modules/Manager/Services/CommandOutcomeLogService.cs:15`; `Modules/Manager/Services/CommandOutcomeInfoLog.cs:11`, `:12`, `:26`; `Modules/Manager/Services/CeSupportBundleService.cs:36`, `:42`, `:121`, `:130`, `:145`.

   **What the office sees:** The colleague runs Health or About, then sends CESUPPORT. The zip cannot show Manager's recorded outcome for those commands, even though the log exists locally. Its notes do not name this missing stream.

   **Exact failure scenario:** Manager writes `ce_manager_structured_YYYYMMDD.log` into roaming `%APPDATA%\CE_SUITE_MANAGER\logs`. The collection list instead includes the top level of local `%LOCALAPPDATA%\CE_SUITE_MANAGER`, used for other traces. It neither visits the roaming log folder nor allows the Manager outcome filename in `PluginLogName`. The redirected test path is also missed: the writer uses `manager-outcomes`, while the collector visits only the redirect root and `crash-trace`. Both the folder and name filter need correction. This finding is restricted to the new Manager outcome stream.

   **Smallest fix:** Add the actual roaming Manager log folder and redirected `manager-outcomes` folder to the explicit collection list; allow its exact daily filename pattern. Apply the existing age, size and privacy handling. Retain the local trace folder as well.

   **DETERMINISTIC TEST — fixture:** Disposable Civil/Manager profile with command-outcome logging ON and writable logs; otherwise normal installation.

   **Steps and assertions:** Type `CEHEALTH`, then `CE_VERSION`, close About, then type `CESUPPORT`. First read the real Manager daily log and establish that it contains the two `Command outcome:` lines. Open the zip and notes. Require those already-written lines in the scrubbed Manager log entry, or an explicit reason that this named stream was left out. Current source includes neither. Do not use the CESUPPORT command's own outcome as the assertion: that line is written after its zip is created. Repeat with the existing log-directory override on an isolated test profile.

6. **RD24-06 — LOW — SURE — Manager outcomes and two Structural diagnostic streams accumulate without a retention limit. Verified-by-reading.**

   **File:line:** Manager `Modules/Manager/Services/CommandOutcomeInfoLog.cs:20`, `:26`; Structural `Modules/Structural/Services/RuntimeDiagnosticsService.cs:106`, `:1071`, `:1072`; `Modules/Structural/Services/StructuralCommandLogger.cs:48`, `:59`, `:67`. Live Structural callers include `Modules/Structural/Services/CommandExecutionService.cs:111` and `Modules/Structural/Commands/SupportBlockCommands.cs:187`.

   **What the office sees:** Daily files keep accumulating in user profiles, and a busy day's file has no application-defined size limit. Over months this consumes storage and makes some files too large for the current support collector. No current disk-full incident or growth rate is claimed.

   **Exact failure scenario:** Each writer appends to a date-named file with no rotation, age pruning or total-size pruning. New dates change the filename but never retire old files. Searches of the production consumers and retention code found no cleaner for these three streams. Civil's main writer does have rotation, and Structural's separate Serilog stream does retain seven files; those protections do not cover these writers. Job-time records and other business records are outside this finding.

   **Smallest fix:** Give these diagnostic streams a finite retention policy covering both file size and file age, using the existing bounded-writer pattern where appropriate. Proposed test policy: rotate at 5 MiB, retain two rotated copies per daily stream, and retire diagnostic days older than 14 days. These are proposed operational limits, not an engineering ruling or an assertion about an existing Setting. Never prune unrelated files in the parent folder.

   **DETERMINISTIC TEST — fixture:** For each stream on a disposable profile, seed yesterday's file, a file dated 30 days ago containing `RD24_OLD`, and today's file at 6 MiB. Put `RD24_KEEP.txt` beside them as an unrelated-file control. Keep diagnostics ON for Structural.

   **Steps and assertions:** Start the appropriate pinned packages. Type `CEHEALTH` to append a Manager outcome; type `CESETTINGS`, close it, then `C1` and Esc at its first placement prompt to exercise Structural runtime and command logging. Verify each target stream received a new line. Current source keeps the 30-day-old file and appends to the oversized current file. For the proposed fix, require the old diagnostic file removed, yesterday's and unrelated control retained, and today's active file rotated below 5 MiB with no more than two backups. Repeat the fixture across three starts to verify the bound persists. Do not change the PC clock or use real logs.

**What I did NOT check**

1. **No execution or acceptance.** No build, unit test, AutoCAD launch, drawing open, installation, deployment or sub-agent. No live log, live settings or installed DLL inspection. No item is fixed, Tim-accepted or Codex-accepted. The proposed tests need the pinned release, followed by the eventual fixed candidate.

2. **Host and office behaviour.** No measurement of disk growth, write latency, Windows policy on a colleague PC, crash durability, native event ordering, multi-process rotation, older AutoCAD behaviour, actual window appearance or Undo/Redo. Failure scenarios involving permissions are explicit fixtures, not claims that a colleague's default AppData folder is normally unwritable.

3. **Repair limits.** Read Repair Center dispatch/status, CDDEBUG, CDDIAG, the Manager repair-result presentation and selected repair/triage reporting paths. Did not exhaustively validate every repair algorithm, engineering decision or entity-count claim. Known findings are identified above by BUG number only. No additional repair defect is asserted from an unproved host assumption.

4. **Changes and parked work.** The sole authored repository file is this report. BUG_CARPARK.md, DESK_LOG.md, QUEUE.md and all code are untouched. Other sessions' uncommitted plan files were not staged. No Manager administrator development, installer work or release decision is authorised by this audit. Undo for this deliverable is a normal revert of its report-only commit.

**Summary — under 100 words**

1. **Summary.** Six new source-proven findings: one HIGH, four MEDIUM and one LOW. Structural can abandon start-up because its diagnostics folder cannot be created. CEHEALTH can omit a damaged installation. Civil hides main-log write failures and falsely confirms clearing. Support collection rejects oversized rotated Civil history and misses Manager's outcome stream. Three daily diagnostic streams have no retention limit. Every finding includes a smallest fix and a synthetic reproduction case. No tests or AutoCAD checks ran; only this report was changed.
