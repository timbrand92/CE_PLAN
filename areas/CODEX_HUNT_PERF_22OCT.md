**ANSWER FIRST — independent performance hunt, 22 October brief; reviewed 23 October 2026, Melbourne**

1. **Counts: HIGH 0 / MEDIUM 3 / LOW 1.** Four new findings, all verified-by-reading. No AutoCAD timing or reproduction was run. Severity reflects the proven unnecessary work, not an invented number of seconds.

2. **Most important: CE compares every pit with every remembered pit before some commands even ask for a point.** With 2,000 pits in a 10,000-entity survey, one ordinary record refresh visits four million pit pairs, even when every pit already has its correct identity. Repeating the command repeats the work.

3. **Two other routes grow the same way.** Tidy Labels compares distant survey text against every selected pipe area. Moving a group of pits repeatedly searches every pit's remembered labels. Closing drawings also leaves a small record-refresh cache behind.

4. **Next action belongs to the AI test lane.** Run the synthetic checks below before changing behaviour. No engineering setting, hard block, installation or Manager administrator work is proposed. Civil + Manager remain the 9 November release scope.

---

1. **Evidence boundary.** Source repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. After `git fetch origin`, read Git objects only. Civil + Manager: `origin/claude/rel-20261022m`, `40ee0a36f7960145743954b39859eb6c3af92869`. Structural: `origin/claude/rel-20261022s2`, `2c9a96942a024888a5ab520600f2d5025de83036`. These are the brief's installed-version targets; this hunt did not inspect live DLLs. Every source line below belongs to its nominated commit.

2. **Prior work excluded.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Do not recount disabled Ignore's sync/write, Tidy's writing initialisation, its wrong-space/reach defects, the uninstalled double-click scan, missing Checks progress, outcome-log semantics or the unresolved REDO problem. Findings here identify different internal costs, not those already reported behaviours.

3. **Method and limits.** Read startup, selection, document lifecycle, Idle, cache, logging and command call paths. No build, test, AutoCAD, installation, branch, sub-agent or code edit. Only this findings file is authored. Tests below are NOT RUN and require synthetic copies in a later authorised test session. A code-proven loop is not a measured freeze. No claim is made about Autodesk's undocumented internals.

4. **Test measurement convention.** Use AutoCAD 2027 with the nominated three modules, then repeat affected Civil routes on a supported older lane when available. Use World UCS, INSUNITS 4, unlocked model-space entities and unique synthetic IDs. Count actual production-loop work with a debugger/profiler; do not substitute a hand-written model of the algorithm. Disable breakpoints before collecting elapsed-time logs. The suggested work-count limits are regression criteria for these fixtures, not engineering limits or grounds to refuse a drafter's command.

**Numbered findings**

1. **PERF-01 — MEDIUM — a normal pit-record restore is quadratic even when identities are intact. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProjectDataRecoveryGuardService.cs:100`, `:117`, `:126`, `:140`, `:169`, `:178`; `Services/ProjectDataService.cs:254`, `:638`, `:660`; `Services/ProjectDataService.Recovery.cs:794`; `Commands/SpoonDrainCommand.cs:39`.

   **What happens in AutoCAD:** On a large drainage survey, asking to start a spoon drain makes CE do an all-pits comparison before showing the first point prompt. Nothing needs to be damaged or missing. A drafter who cancels and tries again pays the same cost again.

   **Exact failure scenario:** `CDSPOONDRAIN` calls `InitServicesFull`, which calls forced `SyncWithDrawing`. The snapshot puts EVERY pit into `Unmatched`, including those indexed by identity and handle. Restore looks up identity and handle, but still calls `AddPositionMatches` for every pit with coordinates. That method enumerates the entire unchanged `Unmatched` list. Consumed entries are skipped inside the loop; they are not removed from the list.

   **Proven work:** P valid, uniquely identified pits produce P squared candidate visits. For P = 2,000, that is 4,000,000 visits and 2,001,000 distance/square-root calculations when each restore consumes its matching snapshot in order. No short-circuit for the successful identity lookup, spatial lookup or time slicing exists here. This runs synchronously before `ed.GetPoint`, not on a background worker. The earlier Ignore finding did not identify this algorithm.

   **DETERMINISTIC TEST — fixture:** Saved synthetic drawing with 2,000 genuine CE pit roots P0001–P2000, each with two valid reciprocal text attachments and matching saved project records; 4,000 unrelated survey TEXT entities make exactly 10,000 model-space entities. Space pit centres on a 20 m grid; all positions, handles, IDs, cover/invert values and user fields agree between drawing and record. No pipes, duplicate IDs, stale handles or nearby pit pairs. Close Inspector to isolate the command route.

   **Typed steps:** Open the fixture and let startup settle. Type `CDSPOONDRAIN`; at `Specify first spoon drain point:` press Esc. Repeat once without editing the drawing. Measure each invocation of the production restore separately. Count entry into the candidate-loop body at line 171 and distance calculation at line 178, without mixing in other synchronisation work.

   **Assertion:** Both runs reach `Specify first spoon drain point:` and then `CDSPOONDRAIN command cancelled.`; all pit fields and entity coordinates remain equal to their baseline. The CE log identifies `[PitRestore] Restored user-set pit data from pre-sync snapshot (2000 pits)` and the `ProjectDataService.EnsureDrawingDataCurrent.RestoreSnapshots` phase. The current implementation predicts 4,000,000/2,001,000 loop/distance counts PER restore. A corrected spatial search should examine only nearby candidates on this separated fixture, with candidate work growing approximately twofold, not fourfold, when repeating with 1,000 versus 2,000 pits. Preserve a separate co-located weak-default recovery fixture to prove the repair still chooses the right saved values.

   **Correction direction:** Index position candidates once per restore, while preserving the existing identity/position priority and consumed-entry rules. Simply discarding all position candidates after an identity match could change recovery behaviour; this report does not authorise that shortcut.

2. **PERF-02 — MEDIUM — the single Tidy scan still compares survey objects against every pipe area. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/LinkService.TextClashTidyUp.cs:142`, `:159`, `:191`, `:330`, `:679`, `:684`, `:703`, `:717`, `:733`, `:747`; `Commands/TidyLabelsCommand.cs:57`, `:92`, `:154`.

   **What happens in AutoCAD:** Tidy Labels on All pipes can spend most of its preview checking survey notes nowhere near any pipe. Accepting the moves repeats the calculation. Having only one database walk does not make the complete operation linear.

   **Exact failure scenario:** One search rectangle is collected per pipe. `ScanNearby` opens model-space entities, gets their extents, and executes `windows.Any(broadBox.Clashes)` for each supported entity. A distant TEXT object fails every rectangle test. N distant survey notes and P pipes therefore require N times P rectangle tests before tidy planning starts. No limit bounds that rejected-object work.

   **Further cost in the same operation:** The shared scan stores flat lists. Each pipe's `TidyScan.Filter` walks every retained text and pipe, rather than just nearby entries; applying moves also uses `Text.FindIndex` per attachment. The 1,000-obstacle guard limits accepted local obstacles, not these distant comparisons. Preview and apply are synchronous, separate passes. This is distinct from the previously audited wrong-space and missing-destination-obstacle defects.

   **DETERMINISTIC TEST — fixture:** A valid synthetic model drawing with 500 separated, CE-linked two-vertex pipe roots and one registered, readable DIA MTEXT label per pipe; no other visible pipe components in this fixture. Add 9,000 survey TEXT objects, all more than 100 m outside the union of the pipe search rectangles: exactly 10,000 entities. Every pipe has a non-null search rectangle. Labels begin clear, no layer is locked and no nearby-obstacle limit is reached. Use isolated test Settings with TidyLabelsEnabled ON and pit-cover tidying OFF.

   **Typed steps:** Type `CDTIDYLABELS`, `All`. Count calls to the `broadBox.Clashes` predicate at line 747 only for the 9,000 named survey texts. Repeat on a fresh fixture with 250 pipes/labels and the same 9,000 survey texts. For apply coverage, use an additional fixture with one deliberately clashing label; run All, then Yes.

   **Assertion:** The clear fixture prints `No CE label needs to move.` and leaves all text positions unchanged. Its CE log contains `[PERF] CDTIDYLABELS count:` with `500 picked pipe(s)`. Current code predicts exactly 4,500,000 distant-text rectangle comparisons, versus 2,250,000 for 250 pipes. A corrected broad spatial filter must not retest every distant text against all 500 areas; those texts should be rejected once or through a bounded spatial lookup. In the apply fixture, assert `[PERF] CDTIDYLABELS apply:`, unchanged survey text, and no new final label overlap. Timing alone is supplementary; the counted predicate proves the repeated work.

   **Correction direction:** Build a spatial lookup for search areas and retained obstacles, plus a handle-to-text-entry lookup. Retain local obstacle completeness and same-command refresh of moved label positions. Do not reduce cost by silently omitting obstacles or imposing another hard block.

3. **PERF-03 — MEDIUM — moving each pit searches every pit's label memory, twice on the ordinary MOVE route. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/LinkService.PipeMoveHelpers.cs:229`, `:270`, `:423`; `Services/LinkService.PitMoves.cs:235`; `Services/LinkService.SourceMoves.cs:268`, `:272`, `:273`, `:302`; `Services/LinkService.Reactors.cs:1136`.

   **What happens in AutoCAD:** Moving a group of pits makes label-following work grow disproportionately. Even if the labels already moved correctly, CE searches all remembered labels again to clean up each individual pit's entries. A second MOVE after the first has warmed the memory is a particularly clear case.

   **Exact failure scenario:** `DisplacementCache` is a per-drawing dictionary whose keys combine pit and attachment handles. After processing one pit's attachments, `MovePitAttachments` filters ALL dictionary keys by that pit's prefix. Native MOVE reconciliation loops over moved pits and calls this helper through both `MoveLinkedPipes` and `MovePitLabelsAfterExternalCommand`. The per-command already-followed guard skips attachment movement on the second call, but does not skip the dictionary-wide prune below the loop.

   **Proven work:** With P moved pits and A total remembered attachments, pruning is O(P times A), even when no attachment was deleted. With 1,000 pits, two labels each and a warm 2,000-entry dictionary, the cited two-call route performs 4,000,000 prefix checks per MOVE. Additional passes elsewhere would add work; they cannot remove this lower bound. Moving just one pit is O(A), not constant in the size of that pit's own label family.

   **DETERMINISTIC TEST — fixture:** 1,000 genuine CE pits P0001–P1000 on a 20 m grid, each with exactly two unlocked reciprocal text attachments; no connected pipes. Add 7,000 plain survey entities for a total of 10,000. All pit roots share a dedicated synthetic layer `PERF_PITS`; the texts are on another layer. Ordinary native MOVE linking enabled; Inspector closed.

   **Typed steps:** Use `QSELECT`, object type Block Reference, Layer Equals `PERF_PITS`, entire drawing. Type `MOVE`, use the selected pits, base `0,0`, second point `1000,0`. Let CE finish. This first move primes the label memory. Repeat the same selection and MOVE by another `1000,0`. On the second move, count the predicate at line 424 and record the helper caller stacks.

   **Assertion:** Every pit and its two labels advances exactly 1,000 mm on the second move; survey entities remain fixed. The CE log contains the per-pit `[PitMove] ... label and cover text followed` summaries. Current code predicts 2,000 helper calls and 4,000,000 prefix evaluations on the specified route, despite zero stale entries. The repaired path should examine only each pit's own two entries, or prune the drawing once per command. One `U` must restore the complete second move, including labels. Also test removing one label before MOVE: the optimisation must still retire that pit's stale entry.

   **Correction direction:** Store attachment displacement under a pit key, or perform one drawing-wide stale-entry pass after the batch. Keep the existing movement and already-followed rules. The dictionary IS removed on document teardown at `LinkService.cs:1685`; this finding is repeated work, not a claimed leak in that dictionary.

4. **PERF-04 — LOW — the record-refresh cache retains closed drawing wrappers for the whole session. VERIFIED-BY-READING; retained byte size and noticeable slowdown UNMEASURED.**

   **File:line:** `Modules/Drainage/Services/ProjectDataService.cs:80`, `:238`, `:599`, `:698`; teardown comparison `Services/LinkService.cs:1638`, `:1683`.

   **What happens in AutoCAD:** Each drawing that has gone through a full CE record refresh leaves an entry in memory after closing. A drafter opening many surveys over a long session accumulates entries that cannot help any open drawing. This is a small proven lifetime leak; it is not evidence that the entire native DWG remains in memory.

   **Exact failure scenario:** `_ensureVersionByDb` is a static `Dictionary<Database, long>`. The refresh writes a Database key and a version. A repository-wide search finds declaration, creation, lookup and assignment, but no removal, clear, replacement-to-null or close subscription for this field. Even the test-only Reset explicitly leaves it alone. LinkService's close cleanup removes its own states, displacement cache and schedule index, but cannot clear this private field.

   **DETERMINISTIC TEST — fixture:** Fresh AutoCAD process with one untouched blank drawing kept open and 20 distinct saved synthetic copies of a 10,000-entity Civil fixture. Attach a read-only debugger; inspect `ProjectDataService._ensureVersionByDb` in Watch without dereferencing native properties of closed keys. This field currently has no shipped command-line diagnostic; do not pretend one exists.

   **Typed steps:** For each copy, `OPEN`, type `CDSPOONDRAIN`, Esc at `Specify first spoon drain point:`, then `CLOSE` and discard any prompted changes. Return to the untouched blank after every close. Record the dictionary Count and which managed keys were inserted for that copy. Repeat for all 20 copies; a managed collection may be requested after the run for the retention check.

   **Assertion:** Each command reaches the first-point prompt and prints `CDSPOONDRAIN command cancelled.` The debugger Watch window must show zero keys belonging to closed copies after their closes. Current code leaves all inserted closed-copy keys reachable from the static dictionary, independent of collection. Count may exceed 20 if the host supplies additional unequal wrappers; that additional growth is suspected, not required to prove this leak. Do not use process working-set size alone as the oracle.

   **Correction direction:** Give this cache explicit document-close cleanup using the project's established database-identity policy. Test simultaneous open drawings and switching as well as close/reopen. Do not dispose AutoCAD-owned Database wrappers to remove a managed cache entry.

**Other scoped paths and limitations — not additional findings**

1. **Startup together.** Read Civil `PluginInitialization`, Manager `Plugin`, and Structural `Plugin` startup paths at their respective heads. Manager update staging waits on a pool thread; its 15-second delay is not a 15-second UI sleep. Structural performs synchronous settings/assets/corpus-cache work before its loaded banner (`Plugin.cs:151` onward); corpus refresh itself is scheduled through `Task.Run`. Cold combined startup time, file sizes and network delays were not measured. This reading does not establish a new combined-startup defect or certify startup speed.

2. **Selection and Idle.** Civil selection coalesces events into an Idle pass; compound-selection expansion is passed false. Ownership highlighting only resolves a single selected family. Structural's foundation queue has a time budget and document-close cleanup. These controls do not prove that every called routine is bounded. Civil's pit hover still walks cached pit positions on every PointMonitor event (`PitHoverService.cs:150`); that is linear, and no noticeable delay was proved, so it is not inflated into a counted quadratic finding.

3. **Logging.** Civil ordinary logging uses the shared background writer; Structural performance-detail output also queues work. The MOVE route above emits per-pit/per-attachment informational lines, but this report does not claim an unbounded flood or lost logs without queue measurements. Structural runtime diagnostics still has synchronous JSON file writes (`RuntimeDiagnosticsService.cs:1059`, `:1072`), with snapshot throttling. Their real cost is unmeasured, so no additional slowdown is asserted.

4. **Delivery boundary.** No source fix, unit test or native test was performed, and no issue is marked fixed or accepted. This report is the only authored repository file. No PR is needed for this read-only brief. The automated leak-scan hook must remain enabled when saving and pushing the report.

**Summary — under 100 words**

1. **Summary.** Four new findings: three MEDIUM quadratic-work defects and one LOW cache-lifetime leak. Normal pit restoration compares all pit pairs; Tidy compares distant survey text with every pipe area; grouped pit moves repeatedly prune the whole label cache. Record-refresh keys survive drawing close. Exact call paths and synthetic native test steps are supplied. No elapsed delay, freeze or retained native drawing size is claimed. No build, test, AutoCAD run or code change occurred. Startup, selection and logging were traced, but their unmeasured costs were not padded into extra findings.
