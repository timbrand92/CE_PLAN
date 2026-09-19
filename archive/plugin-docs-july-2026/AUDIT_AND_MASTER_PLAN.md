> ⚠ **PARTIALLY SUPERSEDED** — The phased plan here has been superseded by `docs/V2_1_PLAN.md` (active) and `docs/V2_FIX_PLAN.md`. Architecture findings and audit section remain useful reference material.

# CE_CVL_SUITE — Full Audit & Master Implementation Plan

**Date**: 2026-05-01
**Version**: 1.1.0
**Author**: Audit performed by Claude (Opus 4.6/4.7)
**Status**: Awaiting approval to begin Phase 1

---

## Document Purpose

This is the master plan for CE_CVL_SUITE. It contains:

1. **Build & Test Status** — current state of net48 and net10 builds and the test suite
2. **Full Audit Findings** — every issue found across architecture, code quality, security, testing, and build
3. **End-User Impact Statement** — plain-English statement of what the user will see (or not see) for each change
4. **Phased Implementation Plan** — every fix, refactor, and feature broken into independently-shippable phases
5. **Compound Entity Phases** — the existing COMPOUND_ENTITY_PLAN.md merged in as later phases

Each phase is independently shippable. Each phase can be paused, rolled back, or reordered without breaking the others.

---

## 1. Build & Test Status (verified 2026-05-01)

### Net48 (AutoCAD 2023/2024 legacy)

**Status**: BUILD SUCCEEDED after clean
**Output**: `CE_CVL_SUITE\bin\Debug\net48\CE_CVL_SUITE_20260501_101811.dll`
**Errors**: 0
**Warnings**: 1 unique (CS0414 — `LabelStyleDialogViewModel._isDirty` assigned but never used)
**Note**: A stale `obj/Debug/net48` folder caused initial build failure with `CS2001` errors for missing `*.g.cs` files. After deleting `obj/Debug/net48` and rebuilding, the build is clean. This is a transient WPF temp-project glitch, not a real build error.

### Net10 (AutoCAD 2026/2027 modern)

**Status**: BUILD SUCCEEDED
**Output**: `CE_CVL_SUITE\bin\Debug\net10.0-windows\CE_CVL_SUITE_20260501_101742.dll`
**Errors**: 0
**Warnings**: 4 unique
- 1× CS0414 — `LabelStyleDialogViewModel._isDirty` (same as net48)
- 3× MSB3277 — `Microsoft.VisualBasic` (10.0 vs 10.1) and `System.Drawing` (4.0 vs 10.0) version conflicts in CE_SHARED. Caused by AutoCAD reference DLLs being built against .NET 8. Benign at runtime (AutoCAD provides correct assemblies).

### Test Suite

**Framework**: NUnit 3.14.0
**Total Tests**: 134
**Passed**: 108
**Skipped**: 26 (GeometryHelperTests — gracefully skip when AutoCAD 2022 is not installed at expected path)
**Failed**: 0
**Total Time**: 2.84 seconds

All running tests pass. No flaky tests. No tests with assertion-free bodies. Test project only targets net48; net10-only code paths (`CeGeometryCleanupService.cs`) are not exercised by tests.

---

## 2. Full Audit Findings

### 2.1 Architecture Issues

#### God Objects (single files exceeding sustainable size limits)

| File | Lines | Concern |
|------|-------|---------|
| LinkService.cs (+ 2 partials) | ~10,500 | Owns linking, reactors, auto-save, hitbox detection, pipe splitting, invert flipping, detention visuals, external-command handling |
| LinkCommands.ImportXcivil.cs | 7,936 | Entire XCivil import pipeline as a single partial command class |
| PitScheduleViewModel.cs | 4,343 | Schedule generation + export + sorting + filtering + depth calc + undo snapshots |
| XcivilEntityScanner.cs | 4,053 | Entity recognition + layer parsing + schedule extraction |
| ProjectDataService.cs | 3,868 | Serialization + CRUD + schedule sets + drawing sync (48+ public methods) |
| XcivilImportService.cs | 3,122 | Import orchestration |
| LinkCommands.cs | 2,537 | PITDELETE, CDSYNC, CDREBUILD, CDUPGRADE, CDAUDIT, CDDEBUG, more |
| PipeEditCommand.cs | 2,287 | Selection, context extraction, dialog orchestration, annotation rewriting |

#### Zero interfaces, zero dependency injection

Every single service in the project is a `public static class`. There are zero interfaces. Every call is a direct static invocation. Result: services cannot be mocked, ViewModels using services cannot be tested without AutoCAD, and 95% of the code has zero test coverage purely because the architecture forbids testing.

#### Repeated initialization boilerplate (40+ locations)

Every command method begins with:
```csharp
LoggingService.Initialize();
SettingsService.Initialize();
ThemeService.Initialize();
ProjectDataService.MarkDrawingActive(doc.Database);
```

#### MVVM violations (ViewModels reaching into AutoCAD API)

- DetentionCalcViewModel.cs:63,88
- DesignCheckDashboardViewModel.cs:126,163
- CalculationsWindowViewModel.cs:49

#### Duplicated utilities

- `NormalizeAngle` — defined in PitCommand.cs:500 AND GeometryHelper.cs:205
- `TryParseDouble` — defined in PitCommand.cs:509, AdvancedSettingsViewModel.cs:311, PitScheduleViewModel.cs (multiple), PitViewModel.cs:732
- `FindNearestSegment` — defined twice in CdCommand.cs (lines 1369, 1396)

### 2.2 Bugs (Code Quality)

#### Critical bugs

**B-CRIT-1: GetEntity use-after-transaction** — `DrawingService.cs:679`
Method opens a transaction, gets entity via `GetObject`, commits the transaction, then returns the entity. After commit, entity is undefined and may throw on any property access. Time bomb.

**B-CRIT-2: AdminTelemetryService unguarded file writes** — `AdminTelemetryService.cs:412-423`
`File.WriteAllText` calls with no try/catch, called from AutoCAD event handlers. A locked file or full disk throws an unhandled exception inside the AutoCAD event dispatcher and may crash the session.

**B-CRIT-3: Invalid JSON in toolbar config** — `Assets/Config/ce_toolbar_layout.json:36, 50`
Missing commas. Will fail to parse at runtime.

#### High-severity bugs

**B-HI-1: MdiActiveDocument null dereference (dozens of locations)**
Pattern `Document doc = Application.DocumentManager.MdiActiveDocument; Editor ed = doc.Editor;` without null check. AutoCAD returns null during startup, document switches, last-document-close.

**B-HI-2: PipeOverruleService.RegisterXDataApp** — `PipeOverruleService.cs:124`
Plugin init crash if no document is open at load time.

**B-HI-3: MathHelper.FormatGrade banker's rounding** — `MathHelper.cs:32`
`Math.Round(grade)` uses banker's rounding (round-to-even) by default. `1 in 50.5` rounds to `1 in 50` instead of expected `1 in 51`.

**B-HI-4: CdViewModel culture-insensitive parsing** — `CdViewModel.cs:955, 988, 1011, 1220`
`double.TryParse(FirstInvert, out double first)` without `CultureInfo.InvariantCulture`. Breaks on non-English locales (comma decimal separator).

**B-HI-5: PipeDrawableOverrule singleton thread-unsafe** — `PipeOverruleService.cs:52-57`
Broken double-check-locking without `volatile`.

**B-HI-6: LinkService.Persistence inconsistent null guards** — `LinkService.Persistence.cs:408, 450`
`ReadAttachmentOwner` and `ReadPitAttachmentOwner` don't null-check `ent` parameter while every other read helper does.

**B-HI-7: SettingsService.Current mutated in-place** — `CalculationsWindowViewModel.cs:59`
Direct mutation of static settings object outside the settings lock. Data race in multi-document mode.

**B-HI-8: AdminTelemetryService non-thread-safe collections** — `AdminTelemetryService.cs:82-84`
`HashSet<Document>` and `Dictionary<string, CommandState>` accessed from event handlers with no lock.

#### Medium-severity bugs

**B-MED-1: Thread.Sleep inside lock** — `ProjectDataService.cs:231-232`
100ms sleep in retry loop while holding `_lock`. Up to 300ms main-thread starvation.

**B-MED-2: Bare catch blocks (numerous locations)**
LoggingService.cs:51, CuiMenuGeneratorService.cs:412, DrawingBackupService.cs:203, LinkService.cs:5407 (commits transaction in catch — dangerous), ExportEntitiesCommand.cs:298/304/314/348.

**B-MED-3: DeterminePositionalSide always returns "FIRST"** — `PipeCreationService.cs:500-503`
Method ignores parameters and always returns `"FIRST"`. Either dead-code stub or removed-logic bug.

**B-MED-4: Hardcoded version string** — `LoggingService.cs:47`
Logs `v1.0.0` but project version is `1.1.0`.

**B-MED-5: Duplicated constant** — `LinkDictName` defined in both LinkService.cs:24 AND LinkCommands.cs:46.

**B-MED-6: Mutable static import path state** — `XcivilImportService.cs:35-37`
`LastImportSourcePath`, `LastImportPdfPath`, `LastImportPdfResolutionMode` are public mutable statics. Multi-document mode will clobber.

**B-MED-7: ExcelInteropService dynamic usage** — `ExcelInteropService.cs:15, 49`
Heavy use of `dynamic` — typo becomes runtime exception.

**B-MED-8: Hardcoded paths**
- CdHelpDialog.xaml.cs:34 — `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE`
- CalculationsWindowViewModel.cs:40 — `C:\Lisp Files\Computations`
- UserSettings.cs:247 — `C:\Lisp Files\Computations` (default)

### 2.3 Security Findings

#### Medium severity

**S-MED-1: Installer grants Modify to Users on plugin directory** — `Deploy-Local-AsAdmin.ps1:45`
Combined with SECURELOAD=1 (lines 52-57), allows any local user to inject DLLs that AutoCAD loads for everyone.

**S-MED-2: Process.Start with dev-machine fallback** — `LinkCommands.ImportXcivil.cs:1336`
Hardcoded `C:\Lisp Files\CE_CVL_SUITE\tools` fallback path with `-ExecutionPolicy Bypass`.

**S-MED-3: XXE in LandXML parser** — `LandXmlParser.cs:59`
`XDocument.Load(xmlPath)` without explicit DTD prohibition.

**S-MED-4: Installer scheduled task with HIGHEST from writable path** — `Installer/Program.cs:142-143`
Uses `Environment.ProcessPath` rather than installed path.

#### Low severity

**S-LO-1: No path-traversal validation on export paths** — ExportEntitiesCommand.cs:57-59
**S-LO-2: Exception messages shown to users** — 50+ locations leak internal paths/details
**S-LO-3: Temp files never cleaned up** — LinkCommands.ImportXcivil.cs:259-272
**S-LO-4: Block files loaded from world-writable paths** — BlockService.cs:58 (warns but proceeds)
**S-LO-5: Help URLs unvalidated** — CdHelpService.cs:131
**S-LO-6: Excel COM via dynamic** — ExcelInteropService.cs:100-109

#### What is good

- Zero hardcoded secrets, API keys, credentials
- Safe JSON deserialization defaults (no TypeNameHandling)
- No network calls from plugin
- Registry access scoped to HKCU only
- Telemetry stays local

### 2.4 Test Coverage

| Area | Files | Tested | Coverage |
|------|-------|--------|----------|
| Services | 55 | 0 | **0%** |
| Commands | 25 | 0 | **0%** |
| Models | 20 | 0 | **0%** |
| ViewModels | 29 | 6 | **~21%** |
| Helpers | 6 | 2 | **~33%** |
| Total | 152 | 8 | **~5%** |

#### Most critical untested code (testable WITHOUT AutoCAD)

1. **PipeTruthLogic.cs** — Pure static logic, regex parsing, conflict resolution, drainage model correctness depends on this
2. **XcivilLayerRecognition.cs** — Layer/block name classification driving the import pipeline
3. **LandXmlParser.cs** — XML parsing
4. **XcivilImportPatterns.cs** — 12+ regex patterns
5. **PitIdComparer.cs** — Natural sort comparator
6. **CommandRegistryService.cs** — JSON loading

### 2.5 Build & Configuration Issues

#### Critical

**C-CRIT-1: tmp_accore_isolate/ tracked in git (4.6 GB, 28,495 files)**
Git object store is 1.06 GB. Repo is enormous because of this.

**C-CRIT-2: ce_toolbar_layout.json is invalid JSON**
Missing commas at lines 36 and 50.

#### High

**C-HI-1: Installer/payload.zip tracked in git** (5.6 MB build artifact)
**C-HI-2: No CI/CD at all** — no GitHub Actions, Azure Pipelines, or build server config
**C-HI-3: Test project only targets net48** — net10 code paths never tested
**C-HI-4: Solution platform mismatch** — `.sln` says AnyCPU, projects target x64

#### Medium

- Test packages 1-2 major versions behind (NUnit 3.14 → 4.5, Test.Sdk 17.9 → 18.5)
- No .editorconfig, no global.json, no Directory.Build.props
- Installer/Snapshots/ contains tracked compiled DLL
- Installer EXE targets net9.0 (end-of-support May 2026 — this month)
- MSB3277 assembly version conflict warnings on net10
- corpus/ gitignore commented out (line 17)

#### Low

- Newtonsoft.Json 13.0.3 → 13.0.4 minor update available
- Installer project not in solution

---

## 3. End-User Impact Statement

**This is the critical question Tim asked: "Will any of these changes hurt how the end user uses the program?"**

The answer is: **NO end-user functionality will be lost or degraded by any of these changes**. Every change is one of three categories:

### Category A: Invisible to user (pure internal fixes)

Bug fixes, refactors, security hardening, test additions, build cleanup. The user sees the same dialogs, the same commands, the same behavior. The plugin just becomes more reliable, faster, and less likely to crash.

### Category B: Visibly better (bugs the user has been hitting)

Things they've probably wondered "why does this glitch?" — culture-insensitive parsing, wrong grade rounding, occasional unexplained AutoCAD crashes. These get fixed and the user's experience improves with no learning required.

### Category C: New functionality added (compound entity behavior)

Entirely additive. Default behavior (single-click selects compound, drag moves the whole pit/pipe) matches what the user already wishes the plugin did. Old commands (CDMOVE, CDMOVEALL, PITDELETE) keep working — they just get a hint that native MOVE/DELETE now works too. Users can disable the new behavior with a settings toggle if needed.

### Per-phase end-user impact (detailed)

| Phase | What changes for the user | What stays the same |
|-------|--------------------------|---------------------|
| **Phase 1** (Critical bug fixes) | Plugin no longer crashes during startup, on locked telemetry files, or under non-English locales. Grades round correctly on drawings. | Every command, dialog, button, and workflow. |
| **Phase 2** (Repo & build hygiene) | Nothing visible. | Everything. |
| **Phase 3** (Security hardening) | Installer asks for admin once, sets safer permissions. Block files in untrusted paths now skip with a warning instead of silently loading. | Every command and workflow. |
| **Phase 4** (Architectural refactoring) | Nothing visible. Plugin loads slightly faster (init boilerplate centralized). | Every command, dialog, and feature. |
| **Phase 5** (Test coverage) | Nothing visible. Bugs in core math/parsing get caught before reaching users. | Everything. |
| **Phase 6** (Compound move) | Click any pit sub-entity → MOVE → whole pit moves. Click any pipe sub-entity → MOVE → whole pipe + MLINE + text moves. CDMOVE/CDMOVEALL still work. | All other commands. Drawings still work without the plugin. |
| **Phase 7** (Compound select + delete) | Click pit label → entire pit highlights. DELETE pipe text → prompted "delete whole pipe? yes/no". | Same. |
| **Phase 8** (Sub-entity edit mode) | Double-click a label/text → can drag it independently. ESC returns to compound mode. | Single-click is now compound select; double-click is the new escape hatch. |
| **Phase 9** (Grips, vertices, context menu) | Right-click a pit/pipe → context menu with Edit, Add Vertex, Inspect, etc. CDMOVE/CDMOVEALL/PITDELETE show "tip: native MOVE works now" but still function. | All commands still work. |
| **Phase 10** (Bounding boxes + tag integration) | CE objects show a faint dashed bounding box (non-printing). Tagged entities now move with their parent. | Print output unchanged (boxes don't plot). |

### Settings safety net

Every behavior change in Phases 6-10 is gated by `CompoundBehaviorEnabled` (default: true). If anything goes wrong, users can flip the toggle in CDS settings and the plugin reverts to current pre-compound behavior.

### Drawing portability guarantee

All compound behavior is implemented via overrules. The DWG file format never changes. A drawing made with the new plugin can be opened in:
- AutoCAD without the plugin → all entities display as standard polylines/blocks/MText (current behavior)
- An older version of CE_CVL_SUITE → works identically to today
- The new plugin → compound behavior activates

No user is ever locked out of their data.

---

## 4. Phased Implementation Plan

Each phase is independent and shippable. The order is recommended (Phase 1 first as it fixes crashes), but phases can be reordered.

### Phase 1 — Critical Stability Fixes (BLOCKER PRIORITY)

**Why first**: Fixes bugs that cause crashes, data corruption, or wrong drawings.
**End-user impact**: Plugin becomes more reliable. No visible UI changes.
**Estimated effort**: 1 day.
**Risk**: Very low. Each fix is isolated and small.

| ID | Fix | File | Lines |
|----|-----|------|-------|
| 1.1 | Fix `ce_toolbar_layout.json` invalid JSON | `Assets/Config/ce_toolbar_layout.json` | 36, 50 |
| 1.2 | Remove `GetEntity` use-after-transaction OR scope it inside transaction | `Services/DrawingService.cs` | 679 |
| 1.3 | Wrap `AdminTelemetryService.WriteJson` / `WriteTimestampedJson` in try/catch | `Services/AdminTelemetryService.cs` | 412-423 |
| 1.4 | Add `MdiActiveDocument` null-guard pattern to all service entry points (helper method) | `Services/*.cs` | many |
| 1.5 | Fix `MathHelper.FormatGrade` to use `MidpointRounding.AwayFromZero` | `Helpers/MathHelper.cs` | 32 |
| 1.6 | Fix `CdViewModel` `double.TryParse` to use `CultureInfo.InvariantCulture` | `ViewModels/CdViewModel.cs` | 955, 988, 1011, 1220 |
| 1.7 | Fix `PipeDrawableOverrule` singleton — eager init via `static readonly` | `Services/PipeOverruleService.cs` | 52-57 |
| 1.8 | Fix `LinkService.Persistence` null guards | `Services/LinkService.Persistence.cs` | 408, 450 |
| 1.9 | Fix `LoggingService` version string to read from assembly | `Services/LoggingService.cs` | 47 |

**Verification**: All existing tests still pass. Manual smoke test of CD, PIT, CDIMPORTXCIVIL.

---

### Phase 2 — Repository & Build Hygiene

**Why**: Repository is 1.06 GB because of tracked AutoCAD binaries. Build is fragile (the net48 stale-obj issue we just hit).
**End-user impact**: None. Pure dev-side improvement.
**Estimated effort**: Half a day.
**Risk**: Low. Affects git history (recommend coordination with any clones).

| ID | Fix | Notes |
|----|-----|-------|
| 2.1 | Untrack `tmp_accore_isolate/` and add to `.gitignore` | Use `git rm -r --cached`. History rewrite (filter-repo) optional for size reduction. |
| 2.2 | Untrack `Installer/payload.zip` and `Installer/Snapshots/` | Add to `.gitignore`. |
| 2.3 | Add `.editorconfig` with project-wide formatting rules | New file at repo root. |
| 2.4 | Add `Directory.Build.props` with shared MSBuild properties | New file at repo root. Eliminates duplication across csproj files. |
| 2.5 | Add `global.json` pinning .NET SDK | New file at repo root. Pin to `10.0.107` (current). |
| 2.6 | Fix solution platform configurations from AnyCPU to x64 | Edit `CE_CVL_SUITE.sln`. |
| 2.7 | Add Installer project to solution | Edit `CE_CVL_SUITE.sln`. |
| 2.8 | Remove unused `_isDirty` field | `ViewModels/LabelStyleDialogViewModel.cs:17` (eliminates CS0414). |
| 2.9 | Update `Newtonsoft.Json` 13.0.3 → 13.0.4 (minor patch) | `CE_CVL_SUITE.csproj`. |
| 2.10 | Update test project: NUnit 3.14 → 4.5, Test.Sdk 17.9 → 18.5, NUnit3TestAdapter 4.5 → 6.2 | Required minor test code adjustments for NUnit 4. |
| 2.11 | Add coverlet.collector to test project for coverage reporting | Test project. |
| 2.12 | Add basic GitHub Actions workflow: build + test on PR | New file `.github/workflows/ci.yml`. Optional but valuable. |
| 2.13 | Bump Installer EXE target from net9.0 to net10.0 (net9 EOL May 2026) | `Installer/Installer.csproj`. |

**Verification**: Both builds clean, all 108 tests pass, repo size drops to <100 MB.

---

### Phase 3 — Security Hardening

**Why**: Installer can be exploited by any local user to inject DLLs into AutoCAD for all users.
**End-user impact**: Installer is more secure. Existing installs continue to work; users running the new installer will get safer permissions.
**Estimated effort**: 1 day.
**Risk**: Medium — installer changes always need careful testing.

| ID | Fix | File |
|----|-----|------|
| 3.1 | Fix `Deploy-Local-AsAdmin.ps1` ACL: grant Users only Read+Execute, not Modify | `Installer/Deploy-Local-AsAdmin.ps1:45` |
| 3.2 | Document SECURELOAD recommendation, default to value 2 (most restrictive) | `Installer/Deploy-Local-AsAdmin.ps1:52-57` |
| 3.3 | Remove dev-machine path fallback `C:\Lisp Files\CE_CVL_SUITE\tools` | `Commands/LinkCommands.ImportXcivil.cs:1336` |
| 3.4 | Validate PowerShell script path is within trusted plugin directory before launch | Same file |
| 3.5 | Change `-ExecutionPolicy Bypass` to `-ExecutionPolicy RemoteSigned` | Same file |
| 3.6 | Add XML hardening to LandXML parser: `XmlReaderSettings { DtdProcessing = Prohibit, XmlResolver = null }` | `Helpers/LandXmlParser.cs:59` and `Installer/Program.cs:242` |
| 3.7 | Use installed path (not `Environment.ProcessPath`) in scheduled-task creation | `Installer/Program.cs:142-143` |
| 3.8 | Reject UNC and `..` paths in CDEXPORTENTITIES | `Commands/ExportEntitiesCommand.cs:57-59` |
| 3.9 | Validate help URLs are HTTPS + expected domain | `Services/CdHelpService.cs:131` |
| 3.10 | Either skip block files in world-writable paths or prompt user | `Services/BlockService.cs:58, 130` |
| 3.11 | Replace user-facing exception messages with friendly text + log full detail | All `WriteMessage($"... {ex.Message}")` patterns (50+ sites) |

**Verification**: Manual installer run on clean VM. Check ACLs after install. Run all import/export commands.

---

### Phase 4 — Architectural Foundation Refactoring

**Why**: This is what makes everything else (testing, compound entity, future features) actually possible. Current static-class architecture blocks every other improvement.
**End-user impact**: None. Plugin loads marginally faster (no init boilerplate duplication).
**Estimated effort**: 2-3 weeks. **This is the largest phase.**
**Risk**: High. Touches everything. Must be staged carefully.

#### 4.1 — Base command class (eliminates init boilerplate)

Create `Commands/CdCommandBase.cs` with `CdCommandBase.Execute(Action<Document, Editor> body)`. Each command becomes:
```csharp
[CommandMethod("CD")]
public void CivilDrainage() => CdCommandBase.Execute(_civilDrainageHandler);
```
Eliminates 40+ duplicated init lines. No behavior change.

#### 4.2 — Service interfaces for top 6 services

Introduce interfaces (not full DI container — too invasive):
- `IProjectDataRepository` — for `ProjectDataService`
- `ISettingsProvider` — for `SettingsService`
- `ILinkService` — for `LinkService` core operations
- `IDrawingService` — for `DrawingService`
- `ILoggingService` — for `LoggingService`
- `ICommandRegistry` — for `CommandRegistryService`

Static classes implement the interface. ViewModels and command handlers depend on the interface. Default singleton wiring keeps current call sites working.

#### 4.3 — Consolidate duplicated utilities

- Remove `NormalizeAngle` from PitCommand.cs:500. Use `GeometryHelper.NormalizeAngle`.
- Remove all local `TryParseDouble` copies. Add `MathHelper.TryParseInvariantDouble`.
- Remove duplicated `FindNearestSegment` from CdCommand.cs.
- Remove duplicated `LinkDictName` constant from LinkCommands.cs:46. Use `LinkService.LinkDictName`.

#### 4.4 — Move inner model classes from LinkCommands.cs to dedicated files

Extract `LabelEntry`, `TextEntry`, `PitScanInfo`, `PipeScanInfo`, `ImportBlockSummary` from `LinkCommands.cs:49-99` into `Models/Import/*.cs`.

#### 4.5 — Decompose LinkService (the big one)

Split `LinkService` into focused services. Order matters:

1. **`LinkConstants.cs`** — All `*_DICT`, `*_KEY` string constants.
2. **`LinkPersistenceService.cs`** — `ReadPitLinkData`, `ReadPipeLinkData`, `ReadAttachmentOwner`, `ReadPitAttachmentOwner` (current `LinkService.Persistence.cs`).
3. **`LinkRegistrationService.cs`** — `RegisterPipe`, `RegisterPit`, `RegisterAttachment` (current `LinkService.Registration.cs`).
4. **`LinkReactorService.cs`** — `OnObjectModified`, `OnObjectErased`, `OnCommandEnded`.
5. **`LinkAutoSaveService.cs`** — auto-save coordination.
6. **`LinkExternalCommandService.cs`** — COPY/MOVE/etc handling.
7. **`LinkPitPipeService.cs`** — pit-to-pipe endpoint resolution and stretching.
8. **`LinkSplitService.cs`** — inline pipe splitting.
9. **`DocStateRegistry.cs`** — explicit per-document state with factory.

`LinkService.cs` becomes a thin facade that delegates. Existing call sites continue to work while we migrate.

#### 4.6 — Decompose ProjectDataService

Split into:
- `ProjectDataRepository` — CRUD operations on PitData/PipeData
- `ProjectDataPersistence` — JSON file I/O and lock management
- `ProjectDataSync` — drawing-sync logic
- `ProjectScheduleSetService` — schedule set management

#### 4.7 — Move PitScheduleViewModel business logic to services

Extract from `PitScheduleViewModel.cs` into:
- `PitScheduleBuilder` — row construction, depth calculation, auto-remarks
- `PitScheduleExportService` — export to drawing (currently embedded in VM)
- `PitScheduleSnapshotService` — undo snapshots

`PitScheduleViewModel` shrinks from 4,343 lines to ~800-1,000.

#### 4.8 — Remove ViewModel direct AutoCAD calls

Replace direct `Application.DocumentManager.MdiActiveDocument` calls in:
- `DetentionCalcViewModel.cs:63,88`
- `DesignCheckDashboardViewModel.cs:126,163`
- `CalculationsWindowViewModel.cs:49`

Inject the new service interfaces instead.

#### 4.9 — Deprecate or fix DeterminePositionalSide

Either delete the dead-code parameters or restore the geometry detection. Investigate git history first.

**Verification per sub-step**: All 108 tests pass after each sub-step. Manual smoke tests of CD, PIT, CDLINK, CDIMPORTXCIVIL.

---

### Phase 5 — Test Coverage Expansion

**Why**: 5% coverage. Phase 4 made things testable; now actually test them.
**End-user impact**: None. Internal stability improvement.
**Estimated effort**: 1-2 weeks.
**Risk**: Low. Tests cannot break production.

| ID | Add tests for | File | Why |
|----|---------------|------|-----|
| 5.1 | `PipeTruthLogic` (all methods) | `Tests/Services/PipeTruthLogicTests.cs` | Highest business risk — drives all pipe display |
| 5.2 | `XcivilImportPatterns` (12+ regex) | `Tests/Helpers/XcivilImportPatternsTests.cs` | Trivially testable, drives import |
| 5.3 | `XcivilLayerRecognition` | `Tests/Services/XcivilLayerRecognitionTests.cs` | Drives import classification |
| 5.4 | `LandXmlParser` | `Tests/Helpers/LandXmlParserTests.cs` | XML parsing with sample files |
| 5.5 | `PitIdComparer` | `Tests/Helpers/PitIdComparerTests.cs` | Sort logic |
| 5.6 | `CommandRegistryService` | `Tests/Services/CommandRegistryServiceTests.cs` | JSON loading |
| 5.7 | `PitScheduleBuilder` (extracted in Phase 4) | `Tests/Services/PitScheduleBuilderTests.cs` | Schedule generation |
| 5.8 | `LinkPersistenceService` (mocked DB) | `Tests/Services/LinkPersistenceServiceTests.cs` | Now testable post-Phase-4 |
| 5.9 | Add multi-target to test project (net48 + net10) | `Tests/CE_CVL_SUITE.Tests.csproj` | Cover net10-only code |
| 5.10 | Add NSubstitute for mocking interfaces | Test project | Required for Phase 4 services |

**Goal**: Reach 30-40% line coverage on Services layer. 80% coverage is unrealistic for AutoCAD-coupled code, but pure-logic services should approach 90%.

---

### Phase 6 — Compound Move Propagation (from COMPOUND_ENTITY_PLAN.md)

**Source**: `COMPOUND_ENTITY_PLAN.md` Phase 1.
**End-user impact**: Click any pit sub-entity → MOVE → entire pit moves. Click any pipe sub-entity → MOVE → entire pipe + MLINE + text moves. Connected pipes still stretch correctly. CDMOVE/CDMOVEALL still work.
**Estimated effort**: 2-3 weeks.
**Risk**: Medium — touches transform pipeline, but isolated by overrule pattern.

#### New files

- `Services/CompoundResolver.cs` — Maps any entity → compound root + siblings (O(1) via existing extension dictionary reads).
- `Services/CompoundTransformOverrule.cs` — `TransformOverrule` propagating transforms across compound siblings.

#### Modified files

- `PluginInitialization.cs` — Register/unregister `CompoundTransformOverrule` alongside existing overrules.
- `Models/UserSettings.cs` and `Services/SettingsService.cs` — Add `CompoundBehaviorEnabled` toggle (default: true).

#### Key design decisions

- **TransformOverrule over reactor** — Intercepts BEFORE commit, so all siblings move in same transaction (no visual lag).
- **Existing LinkService reactors stay active** — They handle pit-pipe connectivity (endpoint stretching). CompoundTransformOverrule handles compound-internal movement. Both needed, no duplication.
- **Re-entrancy guard** — `[ThreadStatic] static bool _isTransforming` in try/finally prevents infinite recursion.
- **Safety toggle** — `CompoundBehaviorEnabled` setting lets users disable.

#### Verification

1. Open existing drawing with pits/pipes
2. Click pit label → MOVE → pit block + cover text move together
3. Click pipe invert text → MOVE → polyline + MLINE + all text + arrow move together
4. Click pit block → MOVE → labels move, connected pipes stretch at endpoints only
5. UNDO reverses all entities correctly
6. Save, close, reopen WITHOUT plugin → all entities display correctly
7. Toggle `CompoundBehaviorEnabled = false` → entities revert to individual behavior

---

### Phase 7 — Compound Selection + Compound Delete

**Source**: `COMPOUND_ENTITY_PLAN.md` Phase 2.
**End-user impact**: Click pit label → entire pit highlights. DELETE pipe text → prompted "delete entire pipe?". Window-select includes all sub-entities.
**Estimated effort**: 1-2 weeks.
**Risk**: Low — additive behavior.

#### New file

- `Services/CompoundSelectionService.cs` — Hooks `Editor.SelectionAdded` event.

#### Modified files

- `PluginInitialization.cs` — Initialize `CompoundSelectionService`.
- `Services/LinkReactorService.cs` (post Phase 4 split) — Compound-delete prompts in `ProcessPendingErasures`.

#### Verification

1. Click pit label → entire pit highlights (block + label + cover text)
2. Window-select across pipes → all pipe sub-entities included
3. DELETE pipe text → prompted "Delete entire compound? [Yes/No/Sub-entity only]"
4. DELETE pit block → all attachments auto-deleted
5. Save/reopen without plugin → drawing intact

---

### Phase 8 — Sub-Entity Editing Mode (Double-Click)

**Source**: `COMPOUND_ENTITY_PLAN.md` Phase 3.
**End-user impact**: Double-click a label/text → can drag it independently. ESC returns to compound mode. Per-sub-entity offsets preserved across compound moves.
**Estimated effort**: 1-2 weeks.
**Risk**: Low.

#### New file

- `Services/CompoundEditModeService.cs` — Hooks `Document.BeginDoubleClick`.

#### Modified files

- `Services/LinkConstants.cs` — Add `PIPE_ATTACHMENT_OFFSET` key (analogous to existing `PIT_ATTACHMENT_OFFSET`).
- `Services/CompoundTransformOverrule.cs` — Apply stored offsets when propagating transforms.

#### Interaction model

| Action | Behavior |
|--------|----------|
| Single click | Select entire compound |
| MOVE after single click | Move entire compound |
| Double-click sub-entity | Enter sub-entity edit mode — only that entity selected |
| ESC from sub-entity edit | Return to compound mode |

#### Verification

1. Double-click pit cover text → only cover text selected, can drag independently
2. Move cover text → offset stored
3. Single-click pit → MOVE → cover text moves with pit, maintaining stored offset
4. Double-click pipe invert text → reposition independently, offset preserved on pipe moves

---

### Phase 9 — Grips, Vertex Insertion, Context Menu

**Source**: `COMPOUND_ENTITY_PLAN.md` Phase 4.
**End-user impact**: Unified compound grips. Drag midpoint of pipe segment → new vertex inserted (text follows). Right-click context menu. CDMOVE/CDMOVEALL/PITDELETE display tip pointing to native MOVE/DELETE but still work.
**Estimated effort**: 2-3 weeks.
**Risk**: Medium — grip behavior is tricky to get right.

#### New files

- `Services/CompoundGripOverrule.cs` — `GripOverrule` for unified pit/pipe grips.
- `Services/ContextMenuService.cs` — `ContextMenuExtension` on `Editor`.

#### Modified files

- `Commands/CdMoveCommands.cs` — Add deprecation tip messages.
- `Assets/Config/command-registry.json` — Update command descriptions.
- `PluginInitialization.cs` — Register new services.

#### Context menu items

- "Edit Pit..." / "Edit Pipe..." → existing dialogs
- "Edit Sub-Entity" → enter double-click edit mode
- "Add Vertex" → vertex insertion mode
- "Select All Connected" → pit + all connected pipes
- "Inspect" → Inspector palette

#### Verification

1. Click pit → center grip + edge grips visible. Drag → moves whole pit.
2. Click pipe → vertex grips on polyline only.
3. Drag pipe segment midpoint → new vertex inserted. MLINE updates. Text recomputes parametric position.
4. Right-click pit → context menu with Edit Pit / Edit Sub-Entity / Inspect / Select All Connected.
5. Run CDMOVE → tip displayed: "Tip: native MOVE works now — compound behavior is automatic."

---

### Phase 10 — Bounding Boxes + Tag Integration

**Source**: `COMPOUND_ENTITY_PLAN.md` Phase 5.
**End-user impact**: All CE compound objects show a faint dashed bounding box (color 251, non-printing, only visible in plugin). Tagged objects move with their parent.
**Estimated effort**: 1-2 weeks.
**Risk**: Low.

#### Bounding boxes — implementation: Option A (DrawableOverrule rendering)

- Extend `PipeDrawableOverrule` pattern to render bounding box via `WorldDraw`
- No extra entities in drawing — box drawn at display time
- Without plugin: no box visible (clean fallback)
- Skip box if it matches block outline exactly (e.g. simple rectangular pit)

#### Tag integration

When `CDTAG` creates a tag, register the tag entities as compound attachments via `LinkRegistrationService.RegisterAttachment`. `CompoundResolver` includes them in compound set automatically.

#### Modified files

- `Services/PipeOverruleService.cs` (or new `Services/BoundingBoxOverrule.cs`) — Bounding box rendering.
- `Commands/TagCommand.cs` — Register tag as compound attachment on creation.
- `Services/LinkRegistrationService.cs` — Ensure tag registration uses existing attachment pattern.

#### Verification

1. Open drawing → CE pits/pipes show dashed gray bounding box
2. Print preview → boxes do not appear in plot output
3. Tag a pit → tag text/leader move with the pit
4. Save/reopen without plugin → drawing intact, no bounding boxes visible

---

## 5. Phase Dependency Graph

```
Phase 1 (critical fixes)  ─┐
Phase 2 (build hygiene)   ─┼── any order, all independent
Phase 3 (security)        ─┘
                           │
Phase 4 (refactoring) ─────┘ (best with 1+2+3 done first)
                           │
Phase 5 (test expansion) ──┘ (requires Phase 4 interfaces)
                           │
Phase 6 (compound move) ───┤
Phase 7 (compound select) ─┤ (each requires previous compound phase)
Phase 8 (sub-entity edit) ─┤
Phase 9 (grips + menu)    ─┤
Phase 10 (bounds + tags)  ─┘
```

Phases 1-3 are independent and can be done in parallel. Phase 4 should come before 5 (test expansion needs interfaces). Phases 6-10 are sequential per the COMPOUND_ENTITY_PLAN design.

---

## 6. Total Effort Estimate

| Phase | Effort |
|-------|--------|
| 1 — Critical fixes | 1 day |
| 2 — Build hygiene | 0.5 day |
| 3 — Security | 1 day |
| 4 — Architecture | 2-3 weeks |
| 5 — Test coverage | 1-2 weeks |
| 6 — Compound move | 2-3 weeks |
| 7 — Compound select | 1-2 weeks |
| 8 — Sub-entity edit | 1-2 weeks |
| 9 — Grips + menu | 2-3 weeks |
| 10 — Bounds + tags | 1-2 weeks |
| **Total** | **~3-4 months elapsed** |

Phases 1-3 can ship as a v1.1.1 patch within a week. Phase 4 is the long internal-cleanup phase. Phases 6-10 each ship as a minor version (v1.2, v1.3, etc.) with the new compound functionality.

---

## 7. Rollback Plan

Each phase is independently reversible:

- **Phases 1-3**: Standard git revert. No data format changes.
- **Phase 4**: Static-class facades remain wired to interfaces. If a service refactor breaks something, that one service can be reverted while keeping the others.
- **Phases 6-10**: All gated by `CompoundBehaviorEnabled = false` toggle. Users can disable compound behavior immediately. Drawings remain compatible.

---

## 8. Approval Checklist

Before starting Phase 1, confirm:

- [ ] Plan reviewed and accepted
- [ ] Branch strategy agreed (feature branches per phase, or main-only?)
- [ ] Versioning agreed (v1.1.1 for Phase 1-3, v1.2 onward for compound features?)
- [ ] User communication plan for Phase 6+ (changelog notes, settings toggle awareness)
- [ ] Rollback procedure documented and tested

---

**End of plan. Awaiting go-ahead to begin Phase 1.**
