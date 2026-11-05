FOR TIM
1. **My mistakes first:** oversized reads were truncated and needed narrower reads; the brief's theme path needed its Modules/Drainage prefix. Read-only wasted effort; no code or drawing changed.
2. **Verdict: FIX FIRST.** Both earlier defects remain in #2023: omission text misses the visible header when findings exist, and XREF schedules bypass it.
3. **Exact locations:** Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:872 (header), :242 (notice call bypassed by XREF return at :209).
4. **Read:** PR, full five-file diff, earlier #2019 review, Settings, tests, banner bindings and both loading paths.
5. **Built: NO. Tested: NO executable tests; 0 run.** Author's reported net48 build and 40 passes were not rerun.
6. **NOT proven:** real-window appearance, long-list clipping, drawing behaviour, three build lanes or full Civil suite. No AutoCAD, robot, installation or live-bundle build.
7. **Next:** author fixes both paths and adds integration checks; PR remains draft and unchanged.

---

1. **Identity and scope.** JOB B2-2, reviewed 5 November 2026, Melbourne time. PR #2023, head `ad68a77326c4f35f4b612c3681edc892d220be92`, branch `claude/b-1274-rebuilt-on-rel-20261112a`. Every code line below refers to this head. Read `gh pr view 2023`, `gh pr diff 2023` and `C:\CE_PLAN\areas\CODEX_REVIEW_PR2019_04NOV.md`. This is an independent source review, not implementation or release acceptance.

2. **P2 — Earlier header finding: NOT FIXED. Exact changed line: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:872`.**

   When `PreFlightHasIssues` is true, the new code only prepends `PreFlightDetailText`; it leaves `PreFlightHeadline` untouched. `RunPreFlightCheck` runs first (:241), assigning the headline and issue flag at :3007–3009. `ProjectDataSanityService.cs:262` checks excluded pits and adds informational findings for pits with IncludeInSchedule=false. Thus the reported six excluded plastic pits themselves take this branch, even without an unrelated finding.

   `Modules/Drainage/Dialogs/PitScheduleDialog.xaml:110` binds the visible header to PreFlightHeadline; :111 puts detail in its tooltip. Detail is also visible on Source (:198), but the omission explanation is not in the promised persistent header. The same defect as #2019's line 818 remains, now at :870–872.

   Correction: retain existing findings and place a compact omission count/reason in the visible header whenever omissions exist. Regression: six excluded plastic pits plus an unrelated issue must show both the omission summary and access to the other findings; OFF must give the exact original header and detail. Verify the real bindings, not only the string helper.

3. **P2 — Earlier Drainage XREF finding: NOT FIXED. Exact changed line: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:242`.**

   The sole ApplyLeftOutNotice call remains on the current-drawing path. XREF mode calls LoadFromSelectedXrefs at :207 and returns at :209 before the notice call. XREF row generation still filters pits at :720, but its banner at :681–687 is generic and never calls the notice builder.

   Example: select a ready XREF with three plastic pits excluded from scheduling and no eligible pits. It produces no pit rows but says only that one read-only drawing is selected; it never explains the three omissions. This also leaves the all-pits-left-out case broken for XREF sources.

   Correction: build the notice from selected source snapshots only, label sources where needed, retain the conflict message at :661–664 and direct edits to the source drawing. Cover all omitted, mixed included/omitted, no selected sources and OFF; do not count host or unselected-source pits. No XREF write is needed.

4. **Settings default, wording and OFF: PASS BY SOURCE INSPECTION, not runtime proof.**

   `Modules/Drainage/Models/UserSettings.cs:2703–2704` declares JSON key `pitScheduleSaysWhatItLeavesOut` with initializer true. The two requested wording strings are present at :2710–2717: `pitScheduleLeftOutPlasticWording` and `pitScheduleLeftOutSwitchedOffWording`. A third string for To be removed is added at :2720–2723. Production consumes all three at `PitScheduleViewModel.Data.cs:894–899`.

   `Modules/Drainage/Rules/PitScheduleLeftOutNotice.cs:39` returns empty when disabled; Data.cs:867–868 then returns before modifying any banner property. RunPreFlightCheck still runs first. The eligibility refactor at Data.cs:852–856 preserves the prior conjunction for non-null pits: included, not To be removed, and permitted by the plastic/manual rule. Therefore OFF preserves the previous banner path and scheduling eligibility by inspection. No executable before/after banner comparison was performed.

   `Modules/Drainage.Tests/Rules/PitScheduleLeftOutNoticeTests.cs:168` contains `Switch_ShipsOn_AndIsPinnedThroughBothStartUpReads`. It tests a new PitSettings, missing/empty Pit JSON, a tolerant-recovery input, defaults for all wording strings, and explicit false through both DeserializeSettings and DeserializeSettingsTolerant. This is a real default-read test, not a source-text assertion. Read, not executed. The new test file contains 16 [Test] methods; the PR's 40-pass claim is not a claim that this file contains 40 tests. No dedicated Settings-window row is added in this diff; a user-facing checkbox was not demonstrated.

5. **Edge-case search and remaining proof gaps.**

   No number: the helper counts a null or blank ID and ListPits renders `(no number)` (:135); the test at :130 covers a null number. Multiple unnamed pits retain their count. Singular/plural uses group size via `{pitWord}` and `{isAre}` at helper :92–98. All omitted host pits still generate a notice because the call occurs before row construction and does not depend on a non-empty row list; finding 2 still prevents its header display when excluded-pit findings exist. All omitted XREF pits reproduce finding 3.

   Long list: helper :105–140 compresses consecutive numbers but leaves non-consecutive lists unbounded. For example P1, P3, P5 and hundreds more remain a full comma list. Data.cs:876 assigns the entire notice to the headline when no other findings exist. The Source headline at PitScheduleDialog.xaml:186 wraps without a height cap, while its detail at :198–200 is capped at 110 and ellipsised. This retains the earlier layout risk, especially for plastic pits with IncludeInSchedule=true and manual scheduling=false. No window was rendered, so clipping is NOT proven and is not a third confirmed defect. Require off-screen dark/light real-window renders at 1080p scale 1 with a long non-consecutive list. Use a bounded reading/list area for the full details and a compact header.

   The rebuild now names To be removed pits using the same eligibility rule as the schedule; that is an improvement over #2019. No additional independently proven edge-case defect is claimed beyond the two integration failures above.

6. **Drawing and shared-code safety: PASS BY DIFF INSPECTION.**

   Exactly five changed files: the notice helper, its tests, UserSettings.cs, PitScheduleViewModel.Data.cs and REGRESSION_LOG.md. No CE_SHARED change. Added production code reads pit/settings values and assigns display strings/flags; it adds no entity edit, save, transaction, layer unlock or drawing-write call. The eligibility refactor is equivalent to the parent predicate. Runtime drawing invariance is NOT proven; this is not certification of all pre-existing schedule commands. Reviewer changed no product source or protected file.

7. **PR hygiene: PASS.**

   GitHub lists one commit. `git rev-list --parents -n 1 ad68a773` shows exactly one parent, `7cc4d30640362cd830971fe254dc1f24bc496164`, equal to fetched `origin/claude/rel-20261112a`. Thus this is one normal commit directly on the stated release base. Title begins `B-1274:`; PR is draft against `claude/rel-20261112a`. `REGRESSION_LOG.md:1` contains the B-1274 entry, prepended with the existing content preserved. Its claim that the banner now says which pits are omitted is too broad until findings 2 and 3 are fixed. `git diff --check ad68a773^ ad68a773` passes.

8. **Validation limits and design context.**

   Read the plan map, Area L, relevant UX rulings/design-pack schedule reference, workshop header references and CivilEditorShellTheme. No new window or image was authored. No build, Civil-suite run, render or AutoCAD operation was performed: source evidence already establishes FIX FIRST. The author's net48 zero-error build and 40 net10 passes are author-reported only; net8, all three lanes together, the full-suite failure-name baseline and real-window proof were not independently established. No engineering calculation or Australian Standard was changed or assessed.

9. **Workspace and saving.**

   Fetched origin first in the code repository and fetched CE_PLAN before writing. Created own clean worktree `C:\CE_WORK\build\codex-review-pr2023-b2-2`, branch `codex/review-pr2023-b2-2`, from origin/master; fetched there and MERGED origin/master (Already up to date). Inspected PR objects directly without merging the PR into this review branch. No uncommitted work existed in this new worktree, so no WIP takeover commit was needed. Other chats' uncommitted main-checkout and CE_PLAN files were left untouched. Only this requested report is saved; no reviewer source REGRESSION_LOG change is appropriate to a review-only job. Worktree cleaned with `git clean -fdXq` at completion. No push, PR merge, close or retarget, AutoCAD, robot or live-bundle operation.

10. **Handoff: DONE — review complete, FIX FIRST.** PR #2023; reviewed branch tip `ad68a77326c4f35f4b612c3681edc892d220be92`. Reviewer executable tests: 0 run, 0 passes claimed. Built: no. Installed: no. NOT proven: runtime behaviour and appearance. Author owns the two corrections and their integration/visual proof. The review can be superseded by a new review of a corrected head; it does not authorise release.
