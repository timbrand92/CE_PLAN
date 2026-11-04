## FOR TIM
1. **GO — PR #2014 passes this read-only code review.** A saved 225 mm pipe is shown in words, with its levels, instead of internal drawing identifiers.
2. **Opus checks:** there are no FIX FIRST items for #2014; its separate Opus review also says GO. The supplied Civil OFF review concerns #2015–#2019.
3. **Switch:** ON by default; OFF restores the original text. The UTF-8 marker is kept, and this change does not write to drawing objects or CE_SHARED.
4. **Limit:** saved outlet nominations containing only internal keys show “Saved value cannot be shown here.” Their keys stay hidden.
5. **Proof:** source review only. No build, tests, pictures or AutoCAD run in this job. BUG-925 stays OPEN.
6. **Reviewed tip:** 041c964262fbcbee55be18558eef50e593565bec. No blocking file/line finding.

---

## Review record — Job 17, 5 November 2026 (Melbourne)

1. **Scope and sources.** Read `gh pr view 2014` and `gh pr diff 2014` for `timbrand92/CE_ACAD_PLUGIN`; reviewed all five changed files against `origin/claude/rel-20261102a`. Read `BUGFIX_w925_REPORT_04NOV.md`, `REVIEW_CIVIL_OFF_SLICES_04NOV.md`, `REVIEW_2012_2014_04NOV.md`, and BUG-925 in `BUG_CARPARK.md:12761`. The requested output retains the 04NOV filename; this review was performed on 5 November.

2. **Revision and isolation.** PR remains OPEN/DRAFT at `041c964262fbcbee55be18558eef50e593565bec`, the same revision reviewed by Opus. Fetched origin. Created clean code worktree `C:\CE_WORK\codex\review-pr2014-job17`, branch `codex/review-pr2014-job17`, from origin/master `650c0c19`; merged origin/master (already current), then fast-forwarded to the exact PR head for inspection. No rebase. No local work existed in this new worktree to commit as WIP. Other sessions' untracked code and active plan/runner files were not taken over or committed. Report authored in a separate clean plan worktree. The task-specific read-only instruction takes precedence over the generic implementation/build/PR-publication checklist: no product edit, regression-log edit, build, install, merge of a PR, or ready-for-review change.

## Opus findings checked individually

1. **FIX FIRST inventory — none for #2014.** `REVIEW_2012_2014_04NOV.md`, section “#2014”, item 9 says GO. Its UTF-8 FIX FIRST findings belong to #2012 and #2013. `REVIEW_CIVIL_OFF_SLICES_04NOV.md` covers only #2015–#2019; none of those command/upgrade fixes belongs to this display-only diff. There is therefore no outstanding #2014 Opus fix to mark fixed.

2. **Words and hidden identifiers — confirmed.** `Modules/Drainage/ViewModels/SavedRuleInputDisplay.cs:18` defines the permitted fields; lines 23–31 give diameter, invert, cover and pit-size units. Lines 60–76 omit unrecognised properties, including Id, EntityHandle, SpineKey, FromSpineKey and ToSpineKey. Line 63 prevents a nested object in a recognised scalar field bypassing that filter. Actual saved pipe shapes match `Rules/RulebookEngine.cs:174`; actual candidate pipes match `Rules/RulebookEvaluator.cs:70`. Evidence is read, never replaced or recalculated (`CouncilSourceViewModel.cs:76`, `:88`).

3. **Default ON — confirmed by source.** `Modules/Drainage/Models/UserSettings.cs:185` creates ChecksSettings; `:3823` declares JSON name `savedSourceValuesInWords`; `:3824` initialises true. `CouncilSourceViewModel.cs:70` also treats a missing group as ON. Both settings readers instantiate UserSettings with ObjectCreationHandling.Replace (`Services/SettingsService.cs:771`, `:784`); neither substitutes false for this missing property. The new tests at `Modules/Drainage.Tests/ViewModels/Bug925SavedSourceValuesTests.cs:134` cover missing settings and older groups through both readers. Explicit false is asserted through the strict reader only; tolerant-reader false/recovery is not separately tested in this PR.

4. **OFF restores old behaviour — confirmed by complete diff comparison.** At `CouncilSourceViewModel.cs:64` the old live-window explanation is the false branch. At `:78`, OFF constructs the same indexed original labels; at `:88`, it concatenates the same original Label, UsedValueJson, Origin and Note; at `:90`, both original empty/nonempty status messages are retained exactly. Source resolution delegates and saved BasisDetails remain unchanged. The setting is sampled when the window is created, so reopen the window after changing it; the builder's prescribed restart also does this. The test at `Bug925SavedSourceValuesTests.cs:116` checks raw data and the empty status, but is not itself exhaustive equality coverage of every string. The exhaustive conclusion here comes from the branch comparison, not a test run.

5. **CE_SHARED and drawing protections — confirmed for this diff.** Only UserSettings, CouncilSourceViewModel, the new formatter, its tests and REGRESSION_LOG change. No CE_SHARED, command, transaction, layer unlock, Xref traversal/edit or REFEDIT edit is added. No protected file from the brief was edited by this job. This establishes the safety of the added code, not a fresh audit of every existing council-source service.

6. **UTF-8 BOM — confirmed.** `Modules/Drainage/Models/UserSettings.cs:1` starts with bytes `EF BB BF` at the reviewed head. Base line 1 also retains the BOM, and the PR diff does not modify it. The BOM removal affecting the neighbouring drafts is absent here.

7. **net48 syntax — compatible by inspection.** `SavedRuleInputDisplay.cs:1` and `CouncilSourceViewModel.cs:1` are wrapped in NET10_0_OR_GREATER. The file-scoped namespace, tuple map and “is not” pattern in the formatter are therefore not compiled for net48. The only new production code seen by net48 is the ordinary bool auto-property, attribute and comments in UserSettings. No new framework API or reference is required there. This is not an independently repeated compile result.

8. **Live-window wording scope — still present, nonblocking.** `CouncilSourceViewModel.cs:64` changes the default explanation used by the live council-source window too. Saved mode overwrites BasisDetails at line 87. The warning that council requirements may have changed is retained; OFF restores the old wording. The builder's “only saved-source window” description is slightly too narrow.

9. **Unknown-field fallback — still present, nonblocking limitation.** `SavedRuleInputDisplay.cs:76` returns “Saved value cannot be shown here.” when nothing recognised remains. This is concrete for a nonempty main-outlet nomination: `RulebookEvaluator.cs:77` saves Key/Value spine-key pairs; neither is permitted. This deliberately avoids exposing internal keys, but does not provide a human-readable outlet identity. Candidate pipes are different: their From, To, Diameter and inverts ARE recognised, so the normal candidate-pipe list is not wholly lost. No lookup of today's drawing is introduced to reconstruct historical identities.

## Verification and remaining proof

1. **Completed:** full PR diff and relevant callers/settings readers inspected; changed-file inventory and BOM checked; `git diff --check origin/claude/rel-20261102a...HEAD` passed; PR tip re-read before reporting. All original regression-log content remains untouched.
2. **Tests this job:** 0 run, 0 builds. The builder reports 16/16 net10 tests and net48 compilation with 0 errors; these are explicitly not independent results. No focused project was needed to resolve this source-only review, so no build worktree or ignored build outputs were created.
3. **Visual proof remains:** no real-window rendering or AutoCAD inspection; no dark/light screenshots produced. Existing source-viewer layout is unchanged by the PR. The older draft's two picture tests are absent, as the BUGFIX report states. Before visual acceptance, use the report's synthetic 225 mm UPVC pipe case and verify both ON and OFF, long candidate lists, and the outlet-nomination fallback. No test is assigned to Tim by this review.
4. **Settings discoverability:** no Settings-window row is supplied for this JSON switch; the BUGFIX report discloses this. ON-by-default and the OFF code path are present; a clickable Settings control is not proven or claimed.
5. **Final verdict:** GO for code review at the named tip, with no blocking file/line finding. Not built, installed or Codex-accepted by this job. BUG-925 remains OPEN.