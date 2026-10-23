# Independent draft PR review — group 2 of 6 — 23 October 2026

1. **ANSWER FIRST — 0 HIGH, 1 MEDIUM, 1 LOW new findings.** The most important finding is a wrong recovery instruction: Checks tells the drafter to type CDCHECK after a failed check, but that command can skip the failed check and leaves the open Checks list unchanged.

2. **The other missed fault.** Manager now tells the drafter that a failure's reason is in the CE log, but Open Logs omits the folder containing that reason. The support ZIP can still collect it.

3. **Ten drafts reviewed.** Several objections in the earlier review are now out of date: the wording repair is pushed, the deliberately failing palette test is marked skipped, the guard-test clash is repaired, and the TWL and pit-refresh fixes now start ON. The pipe-material fix still starts OFF. Three drafts explicitly say they contain notes only; they do not claim a working fix.

4. **What this proves.** Both new findings are verified-by-reading, not reproduced in AutoCAD. No build, test, AutoCAD session, installation or sub-agent was run. The steps below are for a later AI tester on synthetic copies. Tim is not being asked to test. Only this findings file is authored.

---

1. **Scope and method.** Read RULES.md, ROUTER.md and CE_PLAN's start/map; reviewed the Git diffs against each PR's base and followed the affected callers. Source came from Git objects, not the checkout's unsaved files. This implements the desk plan/03 read-only brief; its explicit restrictions override the appended worktree/build/PR template. No code branch, source edit or PR action was made. Civil + Manager remains the 9 November colleague scope; Manager administrator development is parked.

2. **Earlier evidence and deduplication.** Consulted `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md` and all four named Opus reviews: `REVIEW_CODEX_PRS_A_2026-10-23.md`, `REVIEW_CODEX_PRS_B_2026-10-23.md`, `REVIEW_FIXWAVE2_A_2026-10-23.md`, `REVIEW_FIXWAVE2_B_2026-10-23.md`. The counts above exclude their existing faults, unresolved routing work and missing native validation. Those are discussed only to give the requested per-PR verdict.

3. **Reproducible selection.** Ran `gh pr list --state open --limit 200 --json number,title,headRefName,headRefOid,baseRefName,isDraft`. Of the 200 returned, 57 were drafts with a branch starting `fw2/`, `cx/`, `cx2/`, `fix/` or `b04/`. Sorted by PR number; distributed the remainder to the first groups: 10, 10, 10, 9, 9, 9. Group 2 is positions 11–20: #1534 through #1543. This follows the requested 200-result inventory; it does not assert that older open PRs outside that limit were enumerated. The inventory is frozen for this review.

4. **Pinned base and limits.** All ten bases are `claude/rel-20261022m`, fetched at `40ee0a36f7960145743954b39859eb6c3af92869`. The separately supplied Structural anchor is `2c9a96942a024888a5ab520600f2d5025de83036`. These are source anchors, not an independent reading of the live installed DLLs. Later Opus reports describe C-61; that does not change these PR-to-base comparisons. Line references below belong to the stated PR head. No combined merge, window render or binary inspection was performed.

5. **Pinned heads, in review order.** #1534 `cx/wording-c60` = `7410fd93520467272f23d7a65fd7f27b504ede18`; #1535 `cx/manager-support-c60` = `b7d77f17d95081aa65ee75c38b6572916fb79203`; #1536 `cx/guard-tests-c60` = `d463134aae07ccf03fc66ab88a4844f3783386cd`; #1537 `cx/eng-pipe-material-c60` = `c23b59c9d4e392a3c79b71e4ee03af513b75c74b`; #1538 `cx/eng-twl-units-c60` = `bf311924360ba24dbb882a56fe4f02fb45fbd650`.

6. **Remaining pinned heads.** #1539 `cx/fb01-c60` = `23db89404495d0f11691b0832a62e50be3e2ff97`; #1540 `cx/fb03-c60` = `50e5efa42c673118934d984de4e599c36aecd439`; #1541 `cx/fb02-c60` = `96ca953ab45bfd0ba7e470b9a487227aaa91ea01`; #1542 `cx/fb04-c60` = `0c5a40b6256ee4fe3d643d2f0732143f877e25ab`; #1543 `cx/fb07-c60` = `1bbf01f63ea4253e9021b3c151060b43a9401186`.

---

1. **F1 — MEDIUM — #1534: the prescribed retry can omit the failed rule check and never refreshes the open list. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/Checks/ChecksResult.cs:307`; the same instruction is in `Services/Checks/IgnoredChecks.cs:93`. Supporting paths: `Services/Checks/ChecksResultReader.cs:54`, `:174`; `Commands/SpineCheckCommand.cs:140`; `Models/UserSettings.cs:2826`; `Services/ChecksListPaletteService.cs:91`, `:114`. All are under `Modules/Drainage` at #1534's head.

   **What happens in AutoCAD:** A failed rule check says, “Run CDCHECK again.” The drafter follows it and gets a connection report, while the failed rule check may not run at all. The old failure stays in the open Checks window. This is actionable recovery wording, not a style objection.

   **Exact scenario and proof:** Checks is enabled, but the independent `checks.useSharedResult` switch is false, its model default. A rule-source exception produces a “CE could not read the rule findings” row. CDCHECK gathers connections and related checks; its only shared rule-reading path is `TypedAnswerLine`, which returns immediately when that switch is false. Neither branch reloads the palette. Even when the switch is true and the rule read succeeds, the visible list remains stale. The actual refresh path calls `CheckWithShared` and then `_viewModel.Load`.

   **DETERMINISTIC TEST — fixture:** Synthetic millimetre drawing with two CE pits P1/P2 and one connected pipe. Isolated settings: Checks command enabled, shared typed result false. A later native test harness must inject exactly one exception with message `GROUP02-RULE-READ` inside the rule-reading try block at `ChecksResultReader.Read`, before Evaluate. This is an explicit test fixture requirement, not a claim that an ordinary drawing reliably produces an I/O exception. No injection or test was performed here.

   **Typed steps:** Type `CDCHECKS`. Assert the window contains “CE could not read the rule findings. Run CDCHECK again.” and the CE log contains “Checks: the rule findings could not be read” plus the fixture marker. Remove the one-shot fault. Type `CDCHECK`, choose `All`, then Enter to finish its follow-up question. Record a harness counter at rule evaluation and the Checks window text. Finally click the window's **Check again** button as the control.

   **Assertion:** A successful prescribed retry must run the failed rule source and replace its failed row. Current code leaves the rule counter unchanged during CDCHECK and leaves the old row visible; Check again advances the counter and replaces it. Repeat with shared results true: CDCHECK can advance the counter but still does not replace the window's row. Fix the recovery instruction to the actual Checks refresh action, or implement that complete retry; preserve typed command aliases. Existing wording tests do not exercise the displayed instruction through both switch states.

2. **F2 — LOW — #1535: Open Logs omits Manager's own failure evidence. VERIFIED-BY-READING.**

   **File:line:** `Modules/Manager/Services/CeSupportBundleService.cs:250`; `CeManagerSupportWarnings.cs:24`, `:28`; `CeManagerStartupWords.cs:22`; `CeAdminTelemetryService.cs:24`, `:168`. Test omission: `Modules/Manager.Tests/Services/C60ManagerSupportTests.cs:126`.

   **What happens in AutoCAD:** Manager reports a broken ribbon part or switch file and says the reason is in the CE log. The drafter types CEMANAGERLOGS, but none of the opened folders contains that reason. Support must use a different route.

   **Exact scenario and proof:** Civil + Manager loaded, Structural absent, no log-folder override. The new warnings call `LogReason`, which appends to `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`. `LogFoldersToOpen` returns only `%APPDATA%\CE_CVL_SUITE\logs`. Loading Structural adds two roaming folders, still not the Manager trace folder. The new test pins these incomplete arrays. This is distinct from Opus's already-known omission of #1548's structured outcome log from the ZIP.

   **DETERMINISTIC TEST — fixture:** Disposable Windows test profile with Civil + Manager, no Structural, no log redirect. Before startup, put the deliberately incomplete JSON text `{"oneGlanceStatus":` in that profile's `%APPDATA%\CE_SUITE\manager-switches.json`. Never change Tim's settings.

   **Typed steps:** Start the candidate in that isolated profile and open a blank synthetic drawing. Capture the one-time command-line notice “The Manager switch file could not be read” and verify the trace contains “Manager switch file is broken or could not be read”. Type `CEMANAGERLOGS`, or click **CE Tools > Open Logs**. Record the Explorer window folder paths. As a control, type `CESUPPORT` and inspect the generated ZIP.

   **Assertion:** Open Logs must include the folder containing the actual Manager trace. Current code opens only the Civil folder, so this assertion fails. The ZIP should include `CE_SUITE_MANAGER/crash_trace.log` with the failure reason, demonstrating that the evidence was retained. Add the Manager trace location to log access and its path test. This is ordinary colleague support, not parked administrator development.

---

1. **#1534 — wording: agree that fixes and validation are required; disagree that the encoding repair is still unpushed.**

   Opus A reviewed `a93b1b1e`; the fetched head is `7410fd93`. The named corrupted arrow/operator/help strings have been repaired in Git. The version mapping uses known years and “not read” for unknown values; update wording does not start an installer. No engineering defaults change.

   The ignored-value concern now has concrete coverage: `IgnoredChecks.cs:201` maps the new Settings/pit-table phrases back to their old comparison forms; both equality and fingerprint construction use that normalisation. `UiAuditWordingGuardTests.cs` adds fixed legacy fingerprint expectations. I read these tests but did not execute them; this is not native acceptance.

   Agree that the existing About layout and final-head validation remain unproven here. Keep the earlier integration cautions with #1524, #1526, #1527 and #1528: especially retain #1524's read-only Ignore route while taking the wording. This review does not certify conflict-free merging. **New missed item: F1.** A display-text test cannot prove the instruction actually retries its failed check.

2. **#1535 — Manager support: agree with MERGE-WITH-FIXES, but the remaining reason has changed.**

   Opus A's deliberately red palette test is now explicitly `[Ignore]` at `C60ManagerSupportTests.cs:91`. Its protected production route remains unfixed, honestly recorded. Do not call that a working palette repair or repeat the old red-test objection.

   The added Civil grip/ribbon, Structural daily/command/runtime logs and latest coded office report follow the inspected writers. Existing scrubbing, private-file exclusion and 5 MB file cap remain. Failure notices defer until a drawing exists. No drawing writer or Shared source change was added. Source equality is not proof of binary equality.

   Agree with the earlier caution about several Explorer windows and the separate #1548 outcome-log ZIP gap. **New missed item: F2.** The review checked Civil/Structural paths but did not follow the new Manager warning to the file that stores its reason. Native delivery and current test results are not established by this read.

3. **#1536 — guard tests: agree that this is useful test-only work; disagree with the stale #1524 clash and the claim that every new Civil setting is covered.**

   The old quarantine assertion requiring `InitServicesFull` is removed. The Ignore contract now skips while that known writer remains and becomes active when #1524 removes it. The specific old coexistence objection is therefore repaired in the current source. No product code or defaults change.

   **Missed coverage limitation:** `Modules/Drainage.Tests/Services/C60AuditSourcePinGuardTests.cs:321` recognises only class names ending in `Settings`. #1537's switch is in `DesignStandards` (`UserSettings.cs:1684`, `:1830`), so that new key is invisible to the census. The broad assurance that every new setting without a documented default will fail is false. This is a test gap, not a separately counted AutoCAD fault.

   **Deterministic test to add, not run:** Feed `SettingsDeclarations` a synthetic `class DesignStandards` containing `[JsonProperty("networkUsesPipeMaterial")] public bool NetworkUsesPipeMaterial { get; set; } = false;` without a Default comment. Assert one declaration is returned and its default-documentation flag is false. Current parser returns none. Retain the existing FutureSettings control. The guard must also cover real engineering settings owners.

   Agree with Opus's limitations: regex guards are warnings rather than native proof; the Structural pin reads the Civil branch's older Structural copy, not S-41; the frozen legacy inventory needs deliberate maintenance. Keep this draft's coverage claim narrow until corrected.

4. **#1537 — pipe material: agree with HOLD and both existing MEDIUM concerns.**

   This head is unchanged from Opus B. `UserSettings.cs:1830` still defaults `NetworkUsesPipeMaterial` to false. The new UI row loads/saves/resets it, but a fresh colleague still gets the old material-blind sizing until it is enabled. Tests explicitly pin the OFF reset, so green tests would not resolve the default-policy fault.

   Material reaches both production NetworkLink construction paths, the redesign projection and the solve hash. The sizing helper reads the Settings roughness table and honours a supplied roughness override. Unknown/unrecognised material nevertheless becomes UPVC; Opus already identified that inconsistent and potentially optimistic answer. Do not add an unapproved blanket hard block under R-27 or quietly choose a new engineering value: expose Unknown and the required material correction.

   Agree that text matching on “Material:” is fragile and typed CDRUNSOLVE's zero catchment input is separate known work. Apply/Undo handlers are unchanged; that alone cannot certify redo behaviour. The final-head builds, native checks and current pictures were not validated here. #1555 depends on this work according to the fix-wave review. No additional runtime defect proven.

5. **#1538 — TWL units: disagree that the default still needs flipping; agree the Settings row and native evidence remain owed.**

   Opus B reviewed `9821c80c`. At `bf311924`, `UserSettings.cs:2231` defaults `TwlUsesDrawingUnits` to true, and both calls in `DetentionTwlService.cs:147`, `:160` also fall back to true. Explicit false remains possible. The PR title saying default OFF is stale.

   The collector converts recorded coordinate distance to millimetres before subtracting pit-wall millimetres. Levels stay metres and diameters stay millimetres. Arithmetic agrees: 20 m of full DN300 pipe holds about 1,414 L; two 600 mm square pits with 0.60 m stored depth add 432 L; a 19.4 m wall-to-wall pipe holds about 1,371 L. These are calculations, not executed tests.

   Unknown/unitless or mismatched recorded units retain the existing millimetre fallback. The overlap/sump issue is already recorded and excluded here. No Settings row is added by this PR. Both single-tank and multi-tank service routes are wired; no new runtime defect proven.

6. **#1539 — FB-01 anchor helper: agree with HOLD as an incomplete runtime fix.**

   The diff adds a pure helper, its tests and notes. No production caller uses `CalloutAnchorChoice`. Moving a straight pipe 5 m along itself leaves both old and current anchors on the pipe; the helper cannot distinguish them. Opus already identified this precise limitation.

   The tested predicate is useful only as one input to the owner's eventual command-movement decision. It cannot close BUG-668, prove a default or prove Undo/Redo. No additional finding counted; a native MOVE must exercise the final attachment writer, not just this helper.

7. **#1540 — FB-03 pit refresh: agree with the inspected write ordering; disagree with the obsolete “MERGE, switch OFF” description and an unconditional redo assurance.**

   Opus B reviewed `07010c09`. At `50e5efa4`, `PitMigrationSettings.cs:9` defaults `SkipCurrentPitBlockRedefine` ON, and `PitBlockMigrationService.cs:282` falls back to ON. Missing-key tests were updated; explicit false is preserved. The reviewed runtime behaviour has therefore changed.

   Hash/import uses the held master-file handle. The stamp write follows successful insertion in the same write transaction. The matching-stamp path returns before redefine; manual CDREFRESHBLOCKS remains forced, and legacy block migration still runs. The existing idle/lock/redo-deferral route is retained. This supports the implementation, but a read transaction's source shape does not establish AutoCAD's history behaviour.

   Agree with the existing caveats: a local BEDIT change can survive a matching master stamp, and there is no Settings row. **Native evidence still owed, not a new proven fault:** stamp a synthetic drawing, save/close/reopen it with ON; assert no refresh and DBMOD remains 0. Repeat with a pending REDO and verify it survives the automatic check. Type CDREFRESHBLOCKS and assert the explicit refresh still occurs. This review does not claim FX-03 passed or recommend returning a bug-fix default to OFF.

8. **#1541 — FB-02 split routing: agree that there is no deployable fix; disagree with REJECT/close on the stated “misleading fix claim” ground.**

   The entire change is a nine-line insertion into REGRESSION_LOG.md. Its first numbered item says **“Status: BLOCKED, documentation only”**, explicitly says BUG-690 remains, and says no code, test, default or drawing behaviour changed. The factual premise for Opus's MEDIUM objection is contradicted by the diff.

   Agree with the routing analysis: moving the far-end decision alone does not partition on-run records or remeasure chainage. Retain the draft as a truthful handoff to the protected-file owner; it must not count as closing BUG-690. No runtime defect introduced and no native pass claimed.

9. **#1542 — FB-04 Cancel routing: agree that the fix is absent; disagree with the same misleading-claim rejection.**

   The diff is notes only and explicitly says it is blocked with no runtime change. Its warning about `SetDrawingPath` as well as synchronisation is relevant: deleting just one sync call cannot prove Cancel is read-only.

   One routing citation needs care: the note points to CheckIgnoreCommand as an example of the read-only helper, but this draft's base still has that command's full initialisation; the corrected consumer belongs to #1524. The helper itself exists. Route the implementation using the combined source, not that example's old base.

   Retain as a draft handoff, not a completed repair. The later test must open Edit Pipe, cancel and compare DBMOD plus the next U/REDO behaviour; the older drawing-write fault is already audited and not counted again.

10. **#1543 — FB-07 split routing: agree that this contains no working fix; disagree with closing it because it supposedly claims one.**

    Both the log and `docs/verification/FB07_ROUTING.md:3` say BLOCKED/not implemented. The document gives arrow-versus-text ownership cases, inspection of every segment's bulge, true arc detection and the FB-02 dependency. It also explicitly says no tests or native acceptance occurred.

    Agree with Opus on the required geometry cases: testing only vertex 0 misses a later curved segment. The prescribed refusal preserves the newly placed pit and original pipe; it is not a new whole-command hard block. Keep the explicit handoff pending the protected owner. No new runtime fault or fix is introduced by these notes.

---

1. **Integration and evidence handoff.** Keep current heads distinct from Opus's earlier heads. Preserve all regression entries when the authorised assembler later combines work. Shared files such as UserSettings and Settings markup need combined verification; no actual merge simulation was run here. Engineering values must remain on Settings under R-00. Neither finding authorises new hard blocks under R-27.

2. **Delivery record.** Prepared on 23 October 2026, Melbourne time. The only authored path is `C:\CE_PLAN\areas\CODEX_PR_REVIEW_GROUP02_23OCT.md`. CE_PLAN was fetched and merged with `origin/main` using `git merge --no-edit`; no rebase. Stage/commit/push is restricted to this named report, with the normal leak-scan hook. Other working files are left alone. Builds: 0. Tests executed: 0. AutoCAD checks: 0. No installation or acceptance claim.

3. **Summary.** Ten drafts reviewed; two new faults found: Checks prescribes an incomplete retry, and Open Logs omits Manager's own failure trace. Five reviewed heads have moved beyond Opus's snapshots, so several old objections no longer apply. The pipe-material default remains wrong; helper-only and notes-only drafts remain unfinished. The settings census also misses DesignStandards. Native retry, support access, units and redo checks remain pending. No code, settings or drawing was changed.
