# XCLMTXT Command: Comprehensive Review and Improvement Plan

## 1. Executive Summary

XCLMTXT is an exception-first Excel-to-AutoCAD schedule import workflow implemented across approximately 3,500 lines of C# code. It loads structural member schedules from Excel, applies corpus-based inference to assign floors and detect issues, presents a review dialog for user resolution, then inserts the finalized schedules into the drawing.

This plan catalogs 35 verified findings across three categories (backend bugs, UI/UX bugs, and usability improvements) and organizes them into prioritized implementation phases with clear dependencies and sequencing.

---

## 2. Architecture Overview

### File Map

| File | Role | Lines |
|------|------|-------|
| Services/XclmTxtService.cs | Main orchestration | ~2344 |
| UI/Dialogs/XclmTxtDialog.xaml | WPF main dialog layout | ~409 |
| UI/Dialogs/XclmTxtDialog.xaml.cs | Dialog code-behind | ~900+ |
| UI/Dialogs/XclmTxtAdvancedEditDialog.xaml | Flat row editor layout | ~179 |
| Models/XclmTxtModels.cs | All data models | ~188 |
| Services/XclmTxtCorpusIndexService.cs | Background corpus indexing | -- |
| Services/XclmTxtPdfTextExtractionService.cs | PDF evidence extraction | -- |
| Commands/ExcelMTextCommands.cs | AutoCAD command registration | -- |

---

## 3. Findings Inventory

### 3.1 Backend Bugs and Issues (P0-P2)

#### FINDING-01: Swallowed exceptions throughout XclmTxtService.cs
- **Severity**: P1 (Correctness / Debuggability)
- **Location**: XclmTxtService.cs -- 12 bare catch blocks (lines ~1994, 2014, 2093, 2148, 2178, 2237, 2270, 2282, 2294, 2309, 2321)
- **Problem**: Every catch block uses bare catch with no logging. Failures in session load/save, path resolution, file enumeration, and hashing are completely silent.
- **Impact**: When things go wrong (corrupted session files, permission issues on network drives, malformed paths), users see no error and get mysterious behavior instead.
- **Fix**: Introduce a lightweight diagnostic logger. Replace bare catches with catch (Exception ex) then log with context.

#### FINDING-02: Duplicated CloneRows/CloneIssues methods
- **Severity**: P2 (Maintainability)
- **Location**: XclmTxtService.cs lines 2184/2243 AND XclmTxtDialog.xaml.cs lines 895/903
- **Problem**: Identical static methods defined in two separate classes.
- **Fix**: Move to a shared static helper class or extension methods. Remove duplicates.

#### FINDING-03: ReloadRows and ReloadRowsForSheet are near-duplicates
- **Severity**: P2 (Maintainability)
- **Location**: XclmTxtService.cs lines 121-147 (local functions in Run)
- **Problem**: Two local functions with 95% identical code.
- **Fix**: Merge into a single ReloadRows(string path, string sheetName, ExcelMTextRunOptions opts) where sheetName defaults to null.

#### FINDING-04: AnalyzeRows re-normalizes already-normalized rows
- **Severity**: P3 (Performance)
- **Location**: XclmTxtService.cs lines 149-170
- **Problem**: Clones rows and re-runs full normalization pipeline. May be intentional for post-edit re-analysis.
- **Fix**: Extract NormalizePipeline(rows, profile, projectJob) as a named method.

#### FINDING-05: DetermineJobProfile always defaults to Residential
- **Severity**: P2 (Correctness)
- **Location**: XclmTxtService.cs lines 1433-1459
- **Problem**: Final fallback (line 1458) returns Residential unconditionally. The multi-floor check (1455-1456) is a dead branch since it returns the same default.
- **Impact**: All ambiguous projects get Residential treatment, biasing schedule grouping and corpus matching.
- **Fix**: Return XclmTxtJobProfile.Unknown as the final default.

#### FINDING-06: ValidateInsert return semantics are confusing
- **Severity**: P3 (Readability)
- **Location**: XclmTxtService.cs lines 172-177
- **Problem**: Returns empty string on success, warning string on failure. Counterintuitive.
- **Fix**: Rename to GetInsertWarning. Return null on success, warning text on failure.

#### FINDING-07: FindSourceCandidates recursive enumeration on network drives
- **Severity**: P1 (Reliability)
- **Location**: XclmTxtService.cs line 2307
- **Problem**: Directory.EnumerateFiles with AllDirectories on SharePoint/OneDrive can hang.
- **Fix**: Add CancellationToken, max depth limit (4 levels), timeout (5 seconds). Use manual recursion.

#### FINDING-08: Session path resolution is overly complex
- **Severity**: P2 (Maintainability)
- **Location**: 5 methods: ResolvePreferredSessionPath, ResolveProjectSessionPath, ResolveFallbackSessionPath, SaveSessionWithFallback, SaveSessionForCurrentState
- **Fix**: Consolidate into a SessionPathResolver class with a single Resolve method.

#### FINDING-09: SHA1 used for content hashing
- **Severity**: P3 (Standards compliance)
- **Location**: XclmTxtService.cs lines 2327-2334, ComputeSha1
- **Fix**: Replace with SHA256. Rename to ComputeHash.

#### FINDING-10: No CancellationToken support for long operations
- **Severity**: P1 (Responsiveness)
- **Location**: FindSourceCandidates, corpus refresh, PDF extraction
- **Fix**: Thread CancellationToken through Run, BuildAnalysis, FindSourceCandidates. Wire to dialog cancel.

#### FINDING-11: AutoApplyHighConfidenceFloorSuggestions triggers full re-analysis
- **Severity**: P3 (Performance)
- **Location**: XclmTxtService.cs lines 115-116
- **Fix**: Acceptable for now. Low priority.

#### FINDING-12: BuildAnalysis is a 200-line monolithic method
- **Severity**: P2 (Maintainability)
- **Location**: XclmTxtService.cs lines 682-882
- **Fix**: Decompose into DetectIssues, BuildCorpusIndices, GenerateProposals, ScoreConfidence.

---

### 3.2 UI/UX Bugs (P0-P2)

#### FINDING-13: Dialog title says XCLMTXT
- **Severity**: P2 (Discoverability)
- **Location**: XclmTxtDialog.xaml line 4, hero header line 119
- **Fix**: Change Title to "Schedule Import Review -- XCLMTXT".

#### FINDING-14: No loading/progress indicators
- **Severity**: P1 (Responsiveness)
- **Location**: All event handlers in XclmTxtDialog.xaml.cs
- **Fix**: Add status overlay. Wrap long operations in Task.Run with Dispatcher.Invoke.

#### FINDING-15: 8 floor/row buttons in a single WrapPanel
- **Severity**: P2 (Usability)
- **Location**: XclmTxtDialog.xaml lines 361-369
- **Fix**: Replace 6 floor buttons with ComboBox + single Set Floor button. Separate Include/Exclude.

#### FINDING-16: Bottom button bar is cluttered (8 buttons)
- **Severity**: P2 (Usability)
- **Location**: XclmTxtDialog.xaml lines 166-175
- **Fix**: Group with visual separators. Left: operational. Right: action buttons.

#### FINDING-17: SchedulesGrid uses CurrentCellChanged
- **Severity**: P3 (Performance)
- **Location**: XclmTxtDialog.xaml line 269
- **Fix**: Replace with SelectionChanged event.

#### FINDING-18: Issues grid rows can become excessively tall
- **Severity**: P2 (Usability)
- **Location**: XclmTxtDialog.xaml lines 381-402
- **Fix**: Set MaxHeight on TextBlock elements with TextTrimming and tooltip for full text.

#### FINDING-19: Affected Rows panel has hard-coded Height=170
- **Severity**: P3 (Layout)
- **Location**: XclmTxtDialog.xaml line 343
- **Fix**: Replace with MaxHeight=250 and MinHeight=100.

#### FINDING-20: No keyboard shortcuts
- **Severity**: P2 (Accessibility)
- **Fix**: Add access keys and InputBindings for common operations.

#### FINDING-21: DataGrid cells show raw enum integer values
- **Severity**: P1 (Correctness -- visual)
- **Location**: XclmTxtDialog.xaml lines 379-380
- **Fix**: Add IValueConverter implementations for Severity and Kind enums.

#### FINDING-22: Use Selected button label is ambiguous
- **Severity**: P3 (Clarity)
- **Location**: XclmTxtDialog.xaml line 259
- **Fix**: Rename to "Toggle Selected" or "Include/Exclude Selected".

#### FINDING-23: No confirmation before Insert
- **Severity**: P2 (Safety)
- **Fix**: Add MessageBox confirmation before proceeding.

#### FINDING-24: Advanced Edit hides main window unsafely
- **Severity**: P2 (Reliability)
- **Location**: XclmTxtDialog.xaml.cs lines 388-405
- **Fix**: Use Owner = this on Advanced Edit dialog instead of hide/show pattern.

#### FINDING-25: No undo capability
- **Severity**: P2 (Usability)
- **Fix**: Implement snapshot-based undo stack. Max depth 20.

#### FINDING-26: AdvancedEditDialog DockPanel ordering bug (CONFIRMED)
- **Severity**: P1 (Layout Bug)
- **Location**: XclmTxtAdvancedEditDialog.xaml lines 141-178
- **Problem**: DataGrid Border (line 141, no DockPanel.Dock) is placed before bottom bar Border (line 161, DockPanel.Dock=Bottom). In WPF DockPanel, children are processed in order. The DataGrid consumes all remaining space, squeezing or hiding the bottom bar.
- **Fix**: Move the bottom bar Border BEFORE the DataGrid Border in the XAML.

#### FINDING-27: No tooltips or help text
- **Severity**: P2 (Discoverability)
- **Fix**: Add ToolTip properties to all interactive controls.

---

### 3.3 Usability Improvements (P3-P4)

| Finding | Description | Priority |
|---------|-------------|----------|
| 28 | Add onboarding panel for first-time users | P4 |
| 29 | Group related actions into collapsible sections | P3 |
| 30 | Add color-coded severity indicators | P2 |
| 31 | Add row count badges to schedule proposals | P3 |
| 32 | Add search/filter to issues grid | P3 |
| 33 | Add diff view after applying fixes | P4 |
| 34 | Make confidence score visual | P3 |
| 35 | Add drag-and-drop reordering | P4 |

---

## 4. Implementation Phases

### Phase 1: Critical Fixes (Sprint 1, approx 3-5 days)

| Finding | Description | Effort | Risk |
|---------|-------------|--------|------|
| 26 | AdvancedEdit DockPanel ordering bug | 15 min | None |
| 21 | Raw enum values in issues grid | 1 hr | None |
| 01 | Swallowed exceptions -- add diagnostic logging | 3 hr | Low |
| 05 | DetermineJobProfile always defaults to Residential | 30 min | Medium |
| 07 | FindSourceCandidates network drive hang | 2 hr | Low |

Dependencies: None. All items are independent.

### Phase 2: UI Quality (Sprint 2, approx 3-5 days)

| Finding | Description | Effort | Risk |
|---------|-------------|--------|------|
| 13 | Dialog title | 10 min | None |
| 14 | Loading/progress indicators | 4 hr | Medium |
| 15 | Floor buttons consolidation | 2 hr | None |
| 16 | Bottom button bar grouping | 1 hr | None |
| 22 | Use Selected label | 10 min | None |
| 23 | Confirmation before insert | 30 min | None |
| 27 | Tooltips | 1 hr | None |
| 30 | Color-coded severity | 1 hr | None |

Dependencies: FINDING-14 (async) should be done before FINDING-10 (CancellationToken).

### Phase 3: Architecture Cleanup (Sprint 3, approx 5-7 days)

| Finding | Description | Effort | Risk |
|---------|-------------|--------|------|
| 02 | Deduplicate CloneRows/CloneIssues | 30 min | None |
| 03 | Merge ReloadRows/ReloadRowsForSheet | 30 min | None |
| 04 | Extract NormalizePipeline method | 1 hr | Low |
| 06 | ValidateInsert return semantics | 30 min | Low |
| 08 | Consolidate session path resolution | 3 hr | Medium |
| 09 | SHA1 to SHA256 | 15 min | Low |
| 10 | CancellationToken support | 4 hr | Medium |
| 12 | Decompose BuildAnalysis | 3 hr | Medium |

Dependencies: FINDING-14 (async) should precede FINDING-10 (cancellation).

### Phase 4: UX Enhancements (Sprint 4+, approx 5-10 days)

| Finding | Description | Effort | Risk |
|---------|-------------|--------|------|
| 17 | CurrentCellChanged to SelectionChanged | 15 min | None |
| 18 | Issues grid row height management | 1 hr | None |
| 19 | Affected Rows adaptive height | 30 min | None |
| 20 | Keyboard shortcuts | 2 hr | None |
| 24 | Advanced Edit window management | 1 hr | Low |
| 25 | Undo stack | 4 hr | Medium |
| 29 | Collapsible sections | 2 hr | Low |
| 32 | Issues grid search/filter | 3 hr | Low |
| 34 | Visual confidence bar | 1 hr | None |

### Phase 5: Nice-to-Have (Backlog)

| Finding | Description | Effort |
|---------|-------------|--------|
| 11 | Incremental re-analysis optimization | 4 hr |
| 28 | Onboarding panel | 3 hr |
| 31 | Row count badges | 1 hr |
| 33 | Diff view after fixes | 4 hr |
| 35 | Drag-and-drop reordering | 8 hr |

---

## 5. Key Technical Decisions

### 5.1 Logging Strategy
- Use a simple file-based logger writing to %LOCALAPPDATA%/CE_STRUC/logs/xclmtxt.log
- Also echo warnings/errors to the AutoCAD Editor.WriteMessage
- Log rotation: keep last 5 files, 1MB each
- Do NOT use a heavy logging framework -- keep it to a single static class

### 5.2 Async Pattern
- WPF operations must use Dispatcher.InvokeAsync for UI updates from background threads
- AutoCAD document operations must stay on the main thread (AutoCAD COM threading model)
- Use Task.Run only for CPU-bound work (corpus refresh, file enumeration)
- Never await inside an AutoCAD transaction

### 5.3 Undo Stack Design
- Snapshot-based (not command-based) for simplicity
- Store (List of ExcelPreviewRow, List of ReviewIssue) tuples
- Max depth: 20 snapshots
- Snapshot before: Apply Fix, Exclude Rows, floor assignment, Advanced Edit return

### 5.4 Value Converters for Enum Display
- Create XclmTxtSeverityConverter : IValueConverter (maps enum to string and to brush for color coding)
- Create XclmTxtIssueKindConverter : IValueConverter (maps to user-friendly labels)
- Register as StaticResources in the dialog ResourceDictionary

---

## 6. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Async changes break AutoCAD threading | Medium | High | Test all async paths in AutoCAD 2024+. Keep document operations synchronous. |
| DetermineJobProfile default change breaks existing workflows | Medium | Medium | Add telemetry logging before changing. Monitor for Unknown profile frequency. |
| Session fingerprint invalidation (SHA256 change) | Certain | Low | Sessions naturally expire and will be regenerated. |
| DockPanel fix changes Advanced Edit layout | Low | Low | The fix is definitively correct per WPF DockPanel semantics. |

---

## 7. Testing Strategy

### Unit Tests (new)
- DetermineJobProfile -- test all branches including new Unknown default
- ValidateInsert -- test return value semantics after rename
- BuildAnalysis decomposed methods -- test each phase independently
- CloneRows / CloneIssues -- verify deep clone behavior
- ComputeHash -- verify SHA256 output format

### Manual Integration Tests
- Load Excel from local drive, SharePoint, and deep network path (FINDING-07)
- Resume from corrupted session file (FINDING-01)
- Verify Advanced Edit bottom bar is visible (FINDING-26)
- Verify severity/kind display as text not integers (FINDING-21)
- Verify loading indicator during corpus refresh (FINDING-14)
- Verify undo after Apply Fix and Exclude Rows (FINDING-25)

---

## 8. Files Requiring Modification (by phase)

### Phase 1
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtAdvancedEditDialog.xaml -- DockPanel fix
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml -- enum display converters
- CE_STRUC_SUITE/Services/XclmTxtService.cs -- logging, DetermineJobProfile, FindSourceCandidates

### Phase 2
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml -- title, buttons, tooltips, severity colors
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml.cs -- async wrappers, insert confirmation

### Phase 3
- CE_STRUC_SUITE/Services/XclmTxtService.cs -- refactoring (dedup, consolidation, decomposition)
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml.cs -- remove duplicate CloneRows/CloneIssues
- New file: Helpers/XclmTxtCloneHelper.cs or similar

### Phase 4
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml -- keyboard shortcuts, layout fixes
- CE_STRUC_SUITE/UI/Dialogs/XclmTxtDialog.xaml.cs -- undo stack, selection fixes
