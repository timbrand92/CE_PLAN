# TOOL-ARCH-01 report: ArchUnitNET trial as a build guard (Sun 25 Oct 2026, Melbourne 20:20 to 20:55)

Built and run by robot only. Nothing was opened in AutoCAD (none of this touches AutoCAD). Nothing is installed, merged, closed or deleted. Four words: **built and tested (as a test tool). Not installed. Not Tim-accepted. Not Codex-accepted.**

## ANSWER FIRST — FOR TIM

1. **Recommendation: adopt it for SOME rules, not as a blanket guard.** Use it for the "who is allowed to talk to whom" rules, which it does cheaply and reliably (CE_SHARED depends on no module, Manager never uses Civil, Civil never uses Manager or Structural, Structural uses none of them). Do **not** make it the guard for "no hidden download" or "never unlock a layer" on its own, because it has a blind spot for code written the modern async way (point 3).

2. **What it caught.** On today's code:
   1. **Passed, and the pass is trustworthy:** the four module-independence rules above. Civil, Manager and CE_SHARED never touch each other the wrong way, and Structural uses none of them. That is the same thing the Structural build already checks by searching the file for the word "CE_SHARED"; this is a sturdier way to say it.
   2. **One thing worth a human look: Structural's `LayerService`.** It copies a saved or standard "locked/unlocked" setting onto a layer (`LayerService.cs` lines 480 and 535). If a drafter has locked a layer and the standard says "unlocked", this can silently unlock it, which our native protection rule forbids. I have **not** confirmed it is a fault: I did not read who calls it or whether they check first. Treat it as a question for the Structural lane, not a bug. `NativeCopyPasteXrefService` also sets the lock, but it puts back the state it captured, so I count it a false alarm. The nearest bug entry is BUG-618 (CXREF copy), which names that file; no entry covers `LayerService`.
   3. **Civil never unlocks a layer or detaches an Xref.** Both ways of reading the code agree (zero hits).
   4. **Outbound network calls:** only four Civil types make them (the CE Cloud seat check, telemetry, the AI off-PC gate and the assistant panel) and two Structural types (the AI markup chat and vision reader). No surprise caller. The off-PC audit (BUG-551, BUG-557) and the telemetry HTTPS gap (BUG-990) already name these.
   5. **Layering drift, not faults:** 5 Civil view-model types open the drawing database themselves, and 10 Civil services or models depend on window-side types. There is **no written Tim or council rule** for this layering that I could find, so I report it as drift, not as a fault, and no bug id exists for it.

3. **What it cannot see.**
   1. **Code inside `async` methods.** It missed 2 of the 4 network callers (`CeAiOffPcGate`, `CeAssistantControl`). A new download tucked into an async method would sail through. This is the usual way modern code is written, so it matters.
   2. **The value being set.** It sees "this type sets a layer's lock", not whether it locks or unlocks.
   3. **Which file is written.** My "only the settings service writes the settings file" rule can only say "types that hold settings and write a file". It raised 5 false alarms (all report or CSV writers) and it would not have caught BUG-831 (the in-place settings save), because the settings service is the one type it exempts.
   4. **Words inside strings and comments**, anything about what a drawing looks like, and code in assemblies I did not load (the AI library).

4. **What it costs.**
   1. **Machine:** about 12 seconds per test run (3 to 6 seconds to read the compiled code, under 1 second for all the rules), about 400 MB of memory during the run. It works on both net48 and net10 with the same answers (one rule shows 35 hits on net48 and 36 on net10; that is one extra helper type that exists only in the net10 build).
   2. **Download:** about 0.8 MB of packages, all from nuget.org, Apache-2.0.
   3. **People:** each "allow-list" rule (network, file writes) needs someone to keep the list in step with the code. A rule left red trains people to ignore red; rules must start green.

5. **Mistake of mine, first:** my first run reported "failed" on six rules that were really mine being wrong (the rule matched nothing, and ArchUnitNET itself refused to call that a pass, which is a good safety). My first "does the rule really catch a bad case" test also passed for the wrong reason. Both fixed before any result below was recorded.

6. **Next step (your call, not urgent):** if you agree, the desk takes the four module rules plus a small Cecil-based read of the network and layer-lock rules into a permanent test project. That needs a REGRESSION_LOG entry and goes through a train. Nothing from this trial is merged: the draft PR is #1780, "TOOL-ARCH-01 trial: do not merge".

---

Everything below is detail for the desk; nothing here needs Tim.

## 1. Packages (exact)

1. **TngTech.ArchUnitNET 0.13.4**, licence Apache-2.0, nupkg 386,280 bytes. Newest stable on nuget.org on 25 Oct 2026 (only the old `ArchUnitNET` id carries a 2.4.0-alpha; the maintained id is `TngTech.ArchUnitNET`).
2. **TngTech.ArchUnitNET.NUnit 0.13.4**, Apache-2.0, 38,125 bytes (NUnit extension; our test projects use NUnit 3.14.0, the extension asks for NUnit 3.13.2 or newer, no clash).
3. **Pulled in by them:** CycleDetection 2.0.0 (83,171 bytes), JetBrains.Annotations 2026.2.0 (230,439 bytes), System.ValueTuple 4.6.2 for net48 only (86,474 bytes). Mono.Cecil 0.11.6 and Newtonsoft.Json 13.0.4 were already in our cache. New download total 824,489 bytes.
4. **Test stack copied from Drainage.Tests:** Microsoft.NET.Test.Sdk 17.9.0, NUnit 3.14.0, NUnit3TestAdapter 4.5.0. No other package added.

## 2. What was built and where

1. **Branch `fb/tool-arch-01-trial`**, commit `55b6e067ae376a72504931154995fe46f2cd5feb`, normal push, based on `origin/claude/rel-20261025o` = `2c805a39733ea4649b4273f1f425a37cda463046` ("Civil 3.0.75 / Manager 1.1.75 (C-65)"). **Draft PR #1780** against `claude/rel-20261025o`.
2. **New projects, not in `CE_ACAD_PLUGIN.slnx`, nothing references them:** `Modules/Arch.Tests/CE_ARCH.Tests.csproj` (Civil, Manager, CE_SHARED) and `Modules/Arch.Tests.Structural/CE_ARCH.Structural.Tests.csproj`. Frameworks net48 and net10.0-windows (net8.0-windows not built, nothing needed it). CE_SHARED and the shipped plug-in projects are unchanged.
3. **Structural was measured on its own base** `origin/claude/rel-20261025s` = `3a3caac5db7687f1b5d1a6e09571976c52b2b05a` ("Structural 1.0.124 (S-44)"), in a second private worktree. The same two files are committed on the Civil trial branch; on that base the Structural project would build but was not run there.
4. **Build rules kept:** every command `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD refs from the C-62 report, one dotnet at a time, foreground, no new build/deploy/versioning script. Nothing deployed.
5. **Files:** `ArchitectureFixture.cs` (loads once, prints every violation), `ArchitectureRulesTests.cs` (the rules), `ArchitectureCanaryTests.cs` (proves a rule can fail), `CecilCrossCheckTests.cs` (reads the same files with Mono.Cecil), `ArchitectureMeasureTests.cs`.

## 3. Rules, whether it can say them, and what they found (Civil + Manager + CE_SHARED, net10 and net48 alike unless stated)

1. **ARCH-01 CE_SHARED depends on no module.** Expressible. **PASS** (0 hits).
2. **ARCH-02 Manager does not use Civil or Structural.** Expressible. **PASS**. (Manager's own comments say it keeps copies on purpose.)
3. **ARCH-03 Civil does not use Manager or Structural.** Expressible. **PASS**. Civil and Structural independence, the other direction, is S-01 below.
4. **ARCH-04 View-models do not use drawing-database types (MVVM boundary).** Expressible, but **no written rule exists**; I assumed the convention. **10 hits, 5 types:**
   1. **Real layering drift (no bug id):** `DetentionCalcViewModel`, `DetentionSystemViewModel`, `LongitudinalSectionViewModel`, `PitScheduleViewModel` (each holds `Database`, `Transaction`/`TransactionManager`, `ObjectId` and similar), `PropagationPreviewViewModel` (holds a `Database`).
   2. **False alarm (5 hits):** nested value types inside the above that only hold `Point2d` or `AttachmentPoint`. A sensible rule would ban `Database`, `Transaction`, `ObjectId`, `DBObject`, `Entity`, not geometry structs.
5. **ARCH-05 Services and models do not use window, control or view-model types.** Expressible; again **no written rule**. **36 hits** (35 on net48), sorted by reading the names of the types they depend on, not by opening each file:
   1. **9 false alarms (their job is to open windows; they just sit in the Services folder):** `CeAssistantPaletteService`, `ChecksListPaletteService`, `CivilHubService`, `DialogService`, `DrawingCheckPaletteService`, `HelpLauncher`, `InspectorPaletteService`, `WindowHelpKeyBinding`, `CivilHelpHost+AutoCadAdapter` (net10 only).
   2. **10 real layering drift, no bug id:** `CalculationExportPackage`, `ComputationsRecordBuilder`, `CivilAutomation+State`, `LinkService` (uses `PitViewModel`), `NetworkRedesignApplyCoordinator`, `PipeSizeWriteService` (uses `CdViewModel`), `ProfileRouteEvidenceCaptureService`, `DesignImpactPreviewService`, `FeedbackService`, `Models.DesignImpactPreviewState`.
   3. **17 misplaced, not faults:** plain row, summary or policy types that live in the ViewModels folder but are used by engines (for example `LongitudinalNodeRow`, `PitScheduleRow`, `DetentionSystemSummary`, `ProjectReviewObjectNames`, `SettingsValueCatalog`); the fix is to move the type, not to change behaviour.
6. **ARCH-06 No type sets a layer's lock or detaches/binds an Xref.** Expressible only as "calls the setter", **cannot see the argument** (lock vs unlock). Civil, Manager, CE_SHARED: **PASS (0 hits)**, and the Cecil read agrees (0). Structural **S-02: 2 hits**, see section 5.
7. **ARCH-07 System.Net only in an allow-list.** Expressible; **but ArchUnitNET alone is wrong here** (blind spot, section 4). Raw run with no allow-list: 2 hits (`CeAiSeatGrantService`, `TelemetryQueueService`). The Cecil read finds 4 (adds `CeAiOffPcGate`, `CeAssistantControl`, both inside async code). With the four as an allow-list, ARCH-07 (ArchUnitNET) and ARCH-07c (Cecil) both pass. Grounding: BUG-551 and BUG-557 (off-PC audit) and BUG-990 (telemetry HTTPS gap, OPEN) mention these types; I did not re-verify those entries' details.
8. **ARCH-08 Only the settings service writes the settings files.** **Not expressible as stated** (it cannot see the file path). Approximation "a type that holds `UserSettings` and calls `File.WriteAll*/Replace/Move` must be a `SettingsService` part": **5 hits, all false alarms**: `CheckDwgCommand`, `LinkCommands` (xcivil import reports), `RulesCommand`, `SpineCheckCommand` (CSV and text reports), `DesignCheckDashboardViewModel` (a save-as export). Useless as a guard.
9. **Candidate not written:** "no hard-coded values" and "protected files" are not about who-calls-whom; ArchUnitNET has nothing to say about them. Design rule 4 ("reactors never read DBObjects") is expressible as a call rule, but the repo already has `RedoSafeCallGraphTests` doing a baseline call-graph check, so I did not duplicate it.
10. **ARCH-00 sanity:** 264 Civil services types are seen depending on Autodesk database or geometry types, proving the tool does see types outside the loaded DLLs (without this, ARCH-04, 06, 07 could pass for the wrong reason).

## 4. Findings about the tool itself

1. **Async blind spot (the big one).** The compiler moves the body of an `async` method or async lambda into a hidden class. ArchUnitNET leaves hidden classes out of its model and drops their dependencies. Proven on a deliberate bad type (`CanaryAsyncDownloader`, recorded as a test that must keep passing until the tool is fixed) and on the real code (2 of 4 network callers missed). A non-capturing ordinary lambda canary was caught, so the gap is async state machines, not every lambda; I did not test other lambda shapes.
2. **Mono.Cecil fixes it.** Cecil ships inside ArchUnitNET and is already used by our tests (`Mono.Cecil` in Drainage.Tests and Manager.Tests). A 40-line scan of every method body, including hidden classes, found all 4. A canary proves Cecil sees the async canary.
3. **Safety feature I liked:** if a rule's selector matches nothing, ArchUnitNET fails the rule with "requires positive evaluation" instead of passing silently. That caught my own typos.
4. **Rule shape matters.** The "calls any of these methods" form took **75 seconds** for one rule; the same rule written as a custom condition took 0.13 seconds. The "depends on types in namespace X" form is fast (5 to 100 ms) and does see types in assemblies that are not loaded.
5. **The ready-made `NotDependOnAny(Types()...)` form does not see Autodesk or System.Net types** (they are not in the loaded model); the `NotDependOnAnyTypesThat()` form does.

## 5. Structural (base S-44, net10 and net48 alike)

1. **S-01 Structural uses no Civil, Manager or CE_SHARED:** **PASS**. The csproj already enforces "no CE_SHARED reference in the standalone DLL" by running a PowerShell byte search after every build (`ValidateStandaloneBinaryIndependence`). It needs `powershell` on PATH, which this tool environment lacks (first build failed with exit 9009 until I added it); an ArchUnitNET rule needs no PowerShell.
2. **S-02 no layer-lock setter or Xref detach: 2 hits.** `LayerService` (lines 480 and 535, writes `IsLocked` from a snapshot or from the CE standard: **a possible real fault against the native protection rule, unconfirmed, needs the Structural lane to read callers**) and `NativeCopyPasteXrefService` (line 346, restores captured state: false alarm for "unlock", but inside the Xref copy flow that BUG-618 is about). Cecil read agrees: the same 2 types.
3. **S-03 network allow-list:** **PASS** with `MarkupAIChatService` and `MarkupAIVisionParser` allowed; ArchUnitNET and Cecil agree there (no async hole in Structural's two callers).

## 6. Measurements

1. **Restore** 7 s. **First build** of Civil, Manager and CE_SHARED for net48 and net10 plus the project: 1 min 52 s (it stopped on my own compile errors after those built); incremental builds 6 to 9 s.
2. **Read the compiled code:** Civil + Manager + CE_SHARED 3,399 types (net10) and 3,358 (net48): **5.1 to 6.0 s on net10, 4.6 s on net48**. Structural alone 1,699 types: **4.4 s net10, 3.3 s net48**.
3. **Run all rules after loading:** under 1 second (individual rules 5 to 300 ms). **Whole test run** 10.4 s (net10) and 10.4 s (net48) for 20 tests, 7 s for Structural's 5.
4. **Memory:** about 423 MB (net10) and 402 MB (net48) of managed heap held after loading Civil, Manager and CE_SHARED.
5. **Both runtimes:** works on net48 (CLR 4.0.30319) and net10.0.12 with the same pass and fail pattern. Test counts: Civil half 20 tests, 17 pass, 3 fail by design (ARCH-04, 05, 08); Structural half 5 tests, 4 pass, 1 fails (S-02).

## 7. Not done, not tested, caveats

1. **Rules ARCH-04, 05, 08 and S-02 are left red on purpose** so raw hits can be classified; a permanent version would pin a baseline or fix the source first.
2. **No REGRESSION_LOG entry** (trial, nothing shipped; adoption needs one). `DESK_LOG.md` and `BUG_CARPARK.md` not edited, no bug added (nothing here is a confirmed bug).
3. **Disk floor:** the Structural incremental build ran at 9.99 GB free (about 10 MB under the 10 GB floor); every other build was at or above 10 GB. Waited about 17 minutes at the start for space.
4. **Classification of ARCH-04 and ARCH-05 hits is by the names of the types involved, not by reading each file.** ARCH-04 bug check was a grep of BUG_CARPARK for the type names.
5. **Not tested:** net8.0-windows; the unified-host build of Structural (`EnableUnifiedHostAdapters`); the `CE.AI.Core` library (not loaded, so network and settings use inside it is invisible to this trial); anything in AutoCAD.
6. **Cleanup:** both private worktrees and my scratch folder under `C:\ce-fx` removed after the push (only my own folders, no wildcard); the remote branch and PR stay for the desk's read.
7. **Independent read still owed:** the desk plans an Opus read of the rules before any adoption.

## Summary

ArchUnitNET 0.13.4 works on net48 and net10, costs about 12 s and 400 MB per run, and reliably guards module independence. It misses code inside async methods (2 of 4 network callers), cannot see lock values or file paths, and its layering rules expose drift with no written convention. One unconfirmed concern: Structural `LayerService` sets layer lock state. Recommend: adopt for some rules, with a Cecil read for network and lock rules. Draft PR #1780.
