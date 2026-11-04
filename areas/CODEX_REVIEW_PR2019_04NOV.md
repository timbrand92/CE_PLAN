# CODEX REVIEW — PR #2019 / B-1274

FOR TIM
1. **My mistakes first:** two read-only searches used the wrong path syntax; corrected. Some oversized read output was truncated and the relevant code was read again. No drawing or code changed.
2. **Verdict: FIX FIRST.** The reported six excluded pits still leave the header saying only “Drawing check: ... data issues”; their explanation is in Source-tab detail/hover text.
3. **Second gap:** Drainage XREF schedules bypass the notice altogether, including a source with every pit left out.
4. **Read:** PR, diff, bug entry, author report, Settings, banner bindings and both schedule loading paths.
5. **Built: NO. Tested: NO executable tests (0 run).** This was an independent source review; the author's passing counts were not rerun.
6. **NOT proven:** real window appearance, long-list clipping, dark/light pictures, drawing behaviour, all three build lanes or the full Civil suite. No AutoCAD, robot, install or live-bundle build.
7. **Result:** return to author for the two corrections below; PR stays draft and unchanged.

---

1. **Review identity and scope.** Reviewed 5 November 2026, 00:40 Melbourne time. The requested output filename retains 04NOV. PR #2019 tip: `efaaf4d13a03f7ca666f7d9f4a3c8dff3a027f45`; branch `claude/b-1274-pit-schedule-says-what-it-leaves-out`. All source line references below refer to this tip, not a later branch version.

2. **P2 — Put the omission summary in the visible header even when other findings exist. Exact changed location: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:818` (branch at 818–821).**

   The original bug has six plastic pits with `IncludeInSchedule=false`. `ProjectDataSanityService.cs:267–274` adds a finding for every such pit, and `RunPreFlightCheck` sets `PreFlightHasIssues=true`. Consequently the new branch only prepends `PreFlightDetailText`; it never updates `PreFlightHeadline` for this case. The header under the window title binds its Text to `PreFlightHeadline`, while detail is its ToolTip (`Dialogs/PitScheduleDialog.xaml:110–111`). Thus the author's stated header result cannot occur for the reported case. The detail IS also visible on Source (`:198–202`); it is not an entirely hidden status property, but it is not the promised header message visible across tabs.

   Correct by retaining the existing findings while showing a compact omission count/reason in the header whenever omissions exist. Add a view-model/binding regression using six excluded plastic pits plus an unrelated data issue, and verify the header still says what was left out. Repeat with the switch OFF and compare both header and detail against the original output exactly.

3. **P2 — Apply the notice to the selected XREF sources too. Exact changed location: `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:230`.**

   The only call to `ApplyLeftOutNotice` is after the current-drawing read. At `:199–203`, XREF mode calls `LoadFromSelectedXrefs` and returns before reaching it. `AppendExternalSourceRows` still filters those source pits through `EligibleScheduledPits`, but `LoadFromSelectedXrefs` ends with its generic XREF headline/detail and no omission notice. Example: select a ready drainage XREF containing three excluded plastic pits and no eligible pits. The rows are empty, yet the notice never says that all three pits were left out. This is the all-pits-left-out edge case missing from the integration.

   Build the explanation from the selected source snapshots, identify the source where needed, preserve the existing source-conflict warning, and direct editing to the source drawing. Add tests for all omitted, mixed included/omitted, no selected sources and switch OFF. Do not count unrelated host pits or unselected XREFs.

4. **Requested checks that pass by inspection.**

   `Models/UserSettings.cs:951–971` contains the JSON switch with initializer `true` and both serialised wording strings. `BuildLeftOutNotice` consumes those fields. The helper immediately returns empty when disabled; `ApplyLeftOutNotice` then returns without changing banner fields. Therefore OFF preserves the pre-existing banner path by inspection; there is no executed full-banner comparison in this review or in the new tests.

   `Drainage.Tests/Rules/PitScheduleLeftOutNoticeTests.cs` contains 13 tests, including `Switch_ShipsOn_AndIsPinnedThroughTheStartUpRead`: it checks a new PitSettings, deserialises `{}` and `{"pit":{}}`, checks wording defaults and preserves explicit false. The switch is read through the startup deserialiser, not merely checked as source text. These tests were READ, not run. Settings-window discoverability/editing was not demonstrated by this change.

   The five changed files are the notice helper, its tests, UserSettings, PitScheduleViewModel.Data and REGRESSION_LOG. No `Shared/CE_SHARED` file changes. The added production lines only read pit/settings values and assign display strings/flags; no new drawing write, transaction, entity edit or save call. This is source evidence only, not runtime drawing-invariance proof.

   GitHub lists exactly one commit. `git rev-list --parents -n 1` confirms one parent (`650c0c19b4f69b5aebb778fdcc168a6a8269e6ea`), matching fetched origin/master at review time. The PR title starts `B-1274:`; it is draft against master. REGRESSION_LOG has the B-1274 entry at line 1. `git diff --check` reported no whitespace errors.

5. **Edge cases inspected and proof gaps.**

   A null/blank pit number is counted and displayed as `(no number)`; multiple unnamed pits retain their count. Singular/plural use the group count (`pit/pits`, `is/are`). No pits, null input, or all eligible pits yield no notice. All excluded current-drawing pits yield a helper notice without depending on scheduled row count. These conclusions follow the source and existing helper assertions; they are not new executed test results.

   Long consecutive numbers compress into a range, but a long non-consecutive list is unbounded. The detail TextBlock is capped at 110 and ellipsised; the header is single-line and ellipsised. In the no-existing-findings branch (`Data.cs:825`), the entire notice is also assigned to the Source tab's wrapping headline, which has no height cap. A large list of plastic pits with IncludeInSchedule=true but manual scheduling=false can take this branch if their other data is sound. That presents a layout risk: the headline can grow beyond the fixed Source panel. No rendered window was produced, so actual clipping is NOT proven and is not asserted as an observed defect. Require real-window off-screen dark/light checks with a long non-consecutive list, not just the compressed P3-to-P8 example.

6. **Author claims versus this review.** The author reports 13 new tests, 584 neighbouring tests and successful net48/net10 builds. Those are author-reported results only. No net8 result, full-suite failure-name comparison, or real-window pictures were supplied in the PR diff. This review did not build or execute tests because it is a review-only job and the source already establishes the two correction requests. No new implementation, regression entry or PR update was made by this reviewer.

7. **Workspace and safety.** Fetched origin first in both repositories. Created own clean worktree `C:\CE_WORK\build\codex-review-pr2019-n2`, own branch `codex/review-pr2019-n2`, from origin/master; fetched again and merged origin/master (already up to date). Reviewed the PR tip with `git show`/`gh pr diff` without switching or pushing its branch. No uncommitted work existed in this new worktree, so no WIP takeover commit was needed. Other chats' uncommitted files in the main code checkout and CE_PLAN were not taken over or staged. Only this report is saved. The worktree is cleaned with `git clean -fdXq` on completion. No prohibited source files edited, no CE_SHARED change, no PR merge/close/retarget/push.

8. **Handoff.** DONE: review complete; FIX FIRST for PR #2019 at `efaaf4d13a03f7ca666f7d9f4a3c8dff3a027f45`. Reviewer tests: 0 run, 0 passing claimed. Built: no. Installed: no. Accepted: no. The author owns the corrections and missing integration/visual proof.
