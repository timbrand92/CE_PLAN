# Codex second-opinion review cx_rv22

26 October 2026, Melbourne (AEDT). Live heads rechecked at about 22:18. Read-only review of BUG-861 diagnostics and TOOL-ARCH-01.

**ANSWER FIRST — FOR TIM**

1. **#1798 — MERGE-WITH-FIXES.** Move the diagnostic checks after the existing short wait that stops CE reacting twice to its own selection change. Add a test that catches this ordering mistake. Until then, I cannot sign off the unchanged-behaviour claim for the 3.0.80 diagnostic build.
2. **#1780 — HOLD.** Keep the trial unmerged, as you ruled. Adoption is not yet an open PR: the requested title search returned no results, including at the final recheck.
3. **Opus comparison — 1 agree, 1 disagree.** Disagree on approving #1798 unchanged. Agree on keeping #1780 out; this is agreement with Opus's recorded train exclusion, not a claim that I found an independent Opus architecture review.
4. **Most important finding.** Even with every switch OFF, the diagnostic code runs before a time-sensitive selection check. An event close to the 150 ms limit could take a different path. The ordering is verified by reading; an actual changed selection or lost REDO is suspected, not observed.
5. **What Tim must decide — nothing.** The correction belongs with the builder. Your architecture adoption decision already exists. Civil and Manager remain the 9 November release; Manager administrator work stays parked. Nobody needs to test this manually for this review.

---

**Method and limits**

1. **Verified-by-reading.** Read RULES, ROUTER, the plan map, the architecture adoption ruling, and the R2 review method. Fetched origin and read each live PR with `gh pr view NUMBER --json headRefOid,baseRefName,headRefName,state,isDraft,files` and `gh pr diff NUMBER`; followed calls with `git show`, `git diff` and `git grep`. No code checkout or branch was changed.
2. **Independent order.** Formed #1798 MERGE-WITH-FIXES and #1780 HOLD from code before opening their verdict material. Then read the C-70 list/finalizer report, review-lane entries and architecture trial report. The requested R2 method did not expose a verdict on either scoped PR.
3. **Evidence labels.** Verified-by-reading means source or document inspected, not executed. Suspected means a possible runtime consequence. Historical test counts are attributed to their report. I ran zero tests and zero builds, opened no AutoCAD, installed nothing and used no subagents. No claim about the currently installed DLLs is made.

**PR findings**

1. **PR #1798 — BUG-861 diagnostic switches.**

   **Head read — verified-by-reading.** `0e583f6495b44f9b3effb75c75606cf2cd146891`, branch `fb/bug861-diag-switches`, base `claude/rel-20261025r`, OPEN and draft. Matches the reference head in `TRAIN_C70_PR_LIST_2026-10-26.md` exactly; unchanged on recheck. Eleven changed files, 492 additions and one deletion. The PR baseline is `d8840a09`; the intended C-70 train also includes C-69 changes.

   **What changes in AutoCAD — verified-by-reading.** Fifteen hidden settings let the robot stop fourteen pieces of selection work, separately or together. For example, stopping the Inspector timer leaves the Inspector showing the previous pick. These are diagnostic controls, not a repair for REDO.

   **Claimed cause — not established.** The code contains the selection observer, Inspector refresh, highlight and other candidate paths described by the author. The PR does not identify which loses REDO. Its regression entry reports repeated first-pick failures on 3.0.78, but I did not reproduce those runs. Calling this a diagnostic rather than a fix is correct; BUG-861 must remain open.

   **OFF behaviour — verified-by-reading, with one exception to the equivalence claim.** Each `Skip` returns false before logging when its setting is false. Existing drawing calls remain in the same order; the sole deletion changes an expression-bodied contributed-page method into a block containing the same refresh call. The added code has no drawing write, transaction, command, system-variable access or event subscription.

   Settings are initialised in `PluginInitialization.cs` before the relevant active selection services subscribe. Normal startup therefore makes `RedoDiagSwitches.Source` an in-memory read, not a settings-file read on each pick. `SettingsService.Current` can initialise when called cold; the no-I/O conclusion relies on the verified startup order, not on the getter being inherently pure.

   **Finding F1 — verified ordering defect; suspected runtime effect.** `CivilSelectionObserver.cs:103` adds `LogSelectionSummary()` and the observer switch before the existing clock comparison at line 110. `RedoDiagSwitches.cs:122` enumerates fourteen components and creates a list even with everything OFF. The guard compares the current clock against `_lastWriteUtc`, with `EchoWindowMs = 150` at line 36. Extra work before that comparison can move an event across the boundary. An echo that previously returned can then queue another selection pass. This defeats the requested unchanged-path proof; it does not prove that this PR caused BUG-861 or that the boundary is crossed in practice.

   **Exact required fix F1.** In `Modules/Drainage/Services/CivilSelectionObserver.cs:103`, move the added summary and observer-switch block below the existing `EchoWindowMs` early return, retaining the original `_inEvent` and clock checks first. In `Modules/Drainage.Tests/Services/Bug861DiagSwitchesTests.cs:171`, add an ordering assertion over `OnImpliedSelectionChanged` requiring that clock check and return to precede both diagnostic calls. This assertion fails against the reviewed head. Keep it separate from the current checks that merely require a switch before selected drawing API names. Re-read the resulting diff before sign-off.

   **No literal byte identity.** Extra managed calls, allocations and settings fields mean the program and later saved settings text are not byte-identical. Apart from F1, reading supports the narrower intended claim: OFF adds no drawing operation, transaction, command or diagnostic log line. It does not prove the entire plugin writes nothing between U and REDO: that pre-existing failure is precisely what is being investigated.

   **Defaults and older settings — verified-by-reading.** All fifteen properties explicitly initialise to false in `Models/DiagSettings.cs:25` onwards. `UserSettings.cs:92` constructs `Diag`; `DiagSettings.cs:12` constructs `Redo`. Missing groups in an old file retain OFF. The strict reader uses replacement deserialisation (`SettingsService.cs:739`); the tolerant reader also restores missing/null groups (`:752` onwards). Null or unreadable diagnostic sources fall back to normal behaviour. Defaults match the C-70 list. These are robot settings, not engineering values requiring Settings-page rows.

   **What each ON switch writes — verified-by-reading.** None writes a drawing entity or drawing record. At a reached guarded site, ON emits `[REDO-DIAG] skipped <Component> (diag.redo.disable<Component>) at <fixed method text>` to the CE file log, then returns. The observer also emits the configured disabled-component summary when reached; it is not proof that every listed component ran. These keys all sit under `diag.redo` and all ship OFF:

   1. **disableSelectionObserver:** skips the observer and its downstream tab, Inspector and highlight notifications; logs `SelectionObserver` plus the summary.
   2. **disableRibbonContextTab:** skips the tab notification and returns `CeSelectionFamily.None`; logs `RibbonContextTab`. The observer records no active family; it does not actively hide a previously shown tab.
   3. **disablePaletteSelectionHandler:** skips the visible Inspector's selection handler before invalidation, first-pick logging and timer setup; logs `PaletteSelectionHandler`.
   4. **disablePaletteFirstPickLog:** suppresses the original first-pick state log and its UNDOMARKS/UNDOCTL reads; logs `PaletteFirstPickLog` instead. The skip line can occur repeatedly.
   5. **disablePaletteTimer:** prevents starting/resetting the 150 ms timer; prior invalidation and first-pick logging still happen; logs `PaletteTimer`.
   6. **disablePaletteRefresh:** returns before refresh, deferral and Idle scheduling in `RefreshAfterPick`; logs `PaletteRefresh`.
   7. **disableContributedPages:** suppresses contributed-page refresh; logs `ContributedPages`.
   8. **disableProjectDataSync:** suppresses `SetDrawingPath` and `EnsureDrawingDataCurrent` at this refresh site; logs `ProjectDataSync`. It neither prints nor writes the drawing path itself.
   9. **disablePaletteFirstScan:** suppresses discovery after the null-document exit; logs `PaletteFirstScan`.
   10. **disableOwnershipHighlight:** stops scheduling highlight refresh, including command-state notifications; logs `OwnershipHighlight` when reached.
   11. **disableTwinPickRedirect:** suppresses the redirect inside `OnSelectionAdded`; logs `TwinPickRedirect`. Observer resolution and `TryRedirectTwinAtIdle` remain separate redirect paths.
   12. **disableCompoundSelection:** skips the legacy selection-expansion handler; logs `CompoundSelection` if reached. Normal startup leaves that service inside `if (false)`, so this switch may produce no site log.
   13. **disableHoverServices:** stops the pit hover monitor after its existing diagnostics-enabled check; logs `HoverServices` once per session. Diagnostics-OFF sessions already skip this monitor.
   14. **disableProjectQaWait:** stops automatic Project QA Idle processing, leaving pending work waiting; logs `ProjectQaWait` once per session.
   15. **disableAllSelectionWork:** makes all fourteen component checks return disabled and the summary list them all. No separate drawing writer or `All` skip line; the same logging rules apply. It is not a universal switch for every selection-related action anywhere in CE.

   **Privacy and logging — verified-by-reading.** Every new production `where` argument is literal method text; remaining fields are enum names and fixed keys. No new message incorporates a drawing filename, client name, site address, selection data or exception text. `LoggingService.Info` goes through `Log` to unchanged `CeLogWriter.Write`; it does not echo to AutoCAD. The background writer adds time and level, then writes/forwards the log. This finding covers the new diagnostic messages, not every old CE message in the session.

   **REDO, locked layers, Xrefs and REFEDIT — verified-by-reading; runtime unproven.** The additions decide to skip and optionally log; they do not unlock layers, detach/bind Xrefs, bypass REFEDIT guards, start transactions or issue commands. Existing REDO deferral remains. These are satisfactory incremental safety checks subject to F1, not certification of a successful U → pick → REDO in AutoCAD.

   **Tests and counterfactual — verified-by-reading.** `Bug861DiagSwitchesTests` contains 35 expanded cases: seven ordinary tests, fourteen per-component log cases and fourteen wiring cases. Assertions cover OFF/no logging; empty-file and typed-key loading; individual helper decisions; the master key; summary contents; once-only hover/QA logs; unavailable settings; key coverage; and guards appearing before four named drawing-access tokens.

   Deleting a guard fails its wiring assertion; changing a default or decision fails its helper assertion. On the pre-feature base the tests cannot compile because the diagnostic types do not exist. These tests do not reproduce lost REDO, execute real drawing callbacks or prove unchanged timing. Helper-level independence also does not mean stopping an upstream component leaves all its downstream notifications running.

   After forming my verdict I read `C70NewSwitchDefaultsTests.cs` at finalizer commit `39bc2108`. It adds both-reader tests for older/empty/nested settings, typed values, invalid/null recovery and forbidden diagnostic source tokens. This strengthens settings coverage, but is not on PR head `0e583f64` and does not check F1. Opus reports 35 diagnostic cases and 25 finalizer cases passing; those are historical results, not mine.

   **Scope, R-00, R-27 and wording — verified-by-reading.** Shared/CE_SHARED unchanged. No installer, signing, update, bundle manifest, project or version file touched: no installer-triggered HOLD. No engineering value or drafting hard block added. The existing 150 ms delay is software timing, not an engineering setting. No new drafter-facing words; technical log names suit a robot diagnostic.

   **Finding F2 — conclusion overstates the evidence.** `REGRESSION_LOG.md:11` says the first passing switch names the culprit. The observer switch suppresses several downstream notifications; the palette-handler switch suppresses several further steps. A passing run localises a path, not a unique offending line. **Exact required wording fix:** replace that claim with “A passing switch narrows the suspect path; test its downstream components separately before naming a cause.” The C-70 list section 5.2 needs the same qualification when its owner updates robot instructions. No such file was changed here.

   **Train clashes — verified-by-reading.** C-70 contains only #1798. The architecture trial shares none of its files, keys or regression-log positions. Against C-69, `UserSettings.cs` and `InspectorPaletteService.cs` overlap at file level, but the C-69 speed-limit hunk is much later and uses different keys. Both histories prepend `REGRESSION_LOG.md`: keep both entries. The list records automatic code merges and a log conflict; I inspected relevant C-69 differences but did not perform a trial merge. #1706 overlaps the Inspector area and is expressly excluded from C-70; do not silently add it to this diagnostic review scope.

   **Verdict and installation — MERGE-WITH-FIXES.** Require F1 and F2. No new drawing writer was found, but I do not approve this exact head as proven behaviour-preserving for 3.0.80. After correction it is suitable for diagnostic validation, not a declaration that BUG-861 is fixed. No installation or runtime acceptance was performed.

   **Opus comparison.** Codex DISAGREES with the Opus verdict (Opus said KEEP / GO, Codex says MERGE-WITH-FIXES) because the OFF checks precede the 150 ms echo guard and the unique-cause conclusion is too strong. Source: `release-v3-colleagues-TRAIN_C70_FINALIZER_REPORT_2026-10-26.md`, items 5–7, and review-lane entry 1668. Opus's no-new-drawing-write analysis is supported; its unchanged-behaviour conclusion overlooks the time comparison.

2. **PR #1780 — TOOL-ARCH-01 trial baseline; adoption not yet a PR.**

   **Head read — verified-by-reading.** `55b6e067ae376a72504931154995fe46f2cd5feb`, branch `fb/tool-arch-01-trial`, base `claude/rel-20261025o`, OPEN and draft. Matches `release-v3-colleagues-TOOL_ARCH_01_REPORT.md` section 2.1. The C-70 list excludes it rather than supplying a competing reference head. Eight new files, all in the two architecture test folders. Search run twice: `gh pr list --repo timbrand92/CE_ACAD_PLUGIN --state open --search "TOOL-ARCH-01 adopt in:title"`; no result.

   **What changes in AutoCAD — verified-by-reading.** Nothing. The trial checks compiled plugin files outside AutoCAD for unwanted dependencies. For example, it can complain when Civil starts using Manager classes. Tim's 26 October ruling requires a separate adoption PR and explicitly keeps this trial unmerged.

   **Implemented rules — verified-by-reading.** Four approved boundaries exist: ARCH-01 Shared uses no Civil/Manager/Structural module; ARCH-02 Manager uses no Civil/Structural; ARCH-03 Civil uses no Manager/Structural; S-01 Structural uses no Civil/Manager/Shared. See `ArchitectureRulesTests.cs:41`, `:49`, `:57`, and `StructuralArchitectureTests.cs:91`. Namespace dependency checks are real assertions; they do not prove arbitrary behaviour or dependencies outside the namespaces/assemblies loaded.

   Additional experiments are ARCH-04 view-model drawing access; ARCH-05 services/models using UI types; ARCH-06 layer-lock setters and Xref detach/bind; ARCH-07 permitted network users and ARCH-07c's Cecil cross-check; ARCH-08 file writes by holders of UserSettings; ARCH-00 external-type visibility. Structural adds S-02 lock/Xref calls, S-03/S-03c network checks, and S-04 measurement. ARCH-04/05 are conventions assumed by the author, not Tim's four adopted rules.

   **Known failures — verified-by-reading of the historical report; not rerun today.** ARCH-04 has 10 hits, including five geometry/value-type false alarms. ARCH-05 has 36 hits on net10 and 35 on net48, classified as UI-opening services, layering drift or misplaced plain types. ARCH-08 has five report/export false alarms. S-02 reports LayerService and NativeCopyPasteXrefService. Reported totals: Civil 20 tests / 17 pass / 3 fail; Structural 5 / 4 pass / 1 fail. These remain ordinary failing assertions in the reviewed source, not quarantined known-failure cases.

   Those numbers describe the author's assemblies. Structural was measured separately on S-44 `3a3caac5`, not the Civil trial base. Do not call them fresh results for this head or today's installed build. Source and report agree about the deliberately red rules; the report admits some classifications used type names rather than caller-by-caller investigation.

   **Tests and counterfactual — verified-by-reading.** `ArchitectureFixture.MustHold` asserts an empty failure list. Canaries require a deliberately bad type to be named and reject an empty-selector “positive evaluation” failure. They cover lock setter, detach, network, file write and forbidden view-model dependency. Removing a deliberately bad reference makes its must-catch assertion fail. No direct canary is supplied for each adopted module rule; the namespace dependency mechanism is exercised by the view-model canary.

   The async canary deliberately asserts ArchUnitNET misses its network call; `CecilCrossCheckTests.cs:84` asserts Cecil finds it. This is a meaningful limitation represented in tests. Passing execution remains the author's reported evidence, not mine.

   **Tim's adoption ruling — partial baseline only.** Both projects target net48 and net10.0-windows as required. The four permanent rules exist, but copying the entire trial would also copy deliberately red experiments, contrary to “start green”. Adoption needs its own PR and regression entry; neither exists in this diff.

   **Cecil limitations — verified-by-reading.** Civil's `LayerLockAndXrefDetach_CallsSeenByCecil` at `CecilCrossCheckTests.cs:92` prints matches without asserting a permitted baseline. Structural's `S04_Measure` at `StructuralArchitectureTests.cs:120` also only prints lock-call count. These are measurements, not failure-enforcing guards. Network checks do assert allow-lists. Neither tool establishes whether IsLocked receives true or false, or which file a File.Write call targets. REFEDIT safety is not a rule in this trial. Keep those limits explicit during adoption.

   **Package, licence and shipping — verified-by-reading.** Only `CE_ARCH.Tests.csproj:18` and `CE_ARCH.Structural.Tests.csproj:17` add TngTech.ArchUnitNET and its NUnit extension, pinned to 0.13.4. The projects are not packable and are absent from `CE_ACAD_PLUGIN.slnx`; product projects do not reference them. References point from tests to products, so these packages do not flow into normal plugin bundles. No actual bundle was rebuilt or inspected.

   The upstream tagged licence was verified with `gh api repos/TNG/ArchUnitNET/license?ref=0.13.4`: Apache-2.0, [tagged licence](https://github.com/TNG/ArchUnitNET/blob/0.13.4/LICENSE). The trial report gives the same licence for both packages. This is not a fresh audit of every transitive package; retain applicable notices if redistributing test tooling.

   **Can a rule accidentally block build/release? — verified current separation; suspected future integration risk.** Compilation does not execute these NUnit assertions. The new projects are outside the solution; no changed build/release workflow invokes them. This PR introduces no current production-build gate. Explicitly running all trial tests returns failures by design; connecting that unfiltered run to a required release job would block it. That would be an integration mistake, not an AutoCAD drafting block. Keep the four green adopted rules distinct from measured known violations.

   **REDO, protection, switches and policy — verified-by-reading.** No runtime changes, drawing transaction, command, unlock, detach, REFEDIT bypass or settings migration. Bad canary methods are inspected, not executed by their tests; layer/database canaries use local fakes. No bug-fix switch is needed for a test-only trial. No engineering constant, drafter wording or runtime hard block added under R-00/R-27. CE_SHARED source/project unchanged. Installer, signed updates, release scripts and bundle manifests unchanged: no installer HOLD reason.

   **Clashes — verified-by-reading.** No overlap with #1798, no settings key and no REGRESSION_LOG insertion. The absent adoption PR cannot be checked for conflicts. Its future regression entry must retain other entries; no adoption implementation is inferred from a job name or Tim's ruling.

   **Verdict and exact disposition — HOLD.** Do not modify or merge this trial to satisfy adoption. In the new adoption PR retain ARCH-01/02/03 and S-01. Separate ARCH-04 (`ArchitectureRulesTests.cs:64`), ARCH-05 (`:72`), ARCH-08 (`:120`) and S-02 (`StructuralArchitectureTests.cs:97`) into explicitly non-gating exploration or reviewed baseline comparisons. Preserve Cecil's network read; turn the lock measurements at the lines above into reviewed checks if claiming permanent protection. Add the adoption regression entry and validate both frameworks in that builder's authorised work. These are requirements for future adoption, not edits or tests performed here.

   **Opus comparison.** Codex agrees with the Opus verdict. This means HOLD / do not merge the trial: C-70 Opus finalizer report section 7 item 5 explicitly says “#1780: do not merge”. GitHub reviews/comments are empty, and the trial report says an independent read was still owed. I found no standalone Opus verdict on all architecture rules; no broader agreement or disagreement is invented.

**Completion record**

1. **Only deliverable.** `C:\CE_PLAN\areas\CODEX_PR_REVIEW_cx_rv22.md`. No code, PR, branch, installation or settings mutation. Unrelated plan-folder changes were left alone. Save this report by its exact filename with normal fetch, merge and push; keep the leak-scan hook enabled.
2. **Still untested.** Actual first-pick REDO, the timing-boundary effect, real diagnostic log output, current architecture-rule outcomes and any future adoption build. All are outside this read-only brief.

