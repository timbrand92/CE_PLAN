# BUGFIX ff1993b report, 4 Nov 2026 (Melbourne): fix-first for draft PR #1993 (B-165, BUG-1092)

## FOR TIM

1. **Result: STOPPED. Nothing pushed, nothing changed.** The fix needs a step my rules forbid, so I did not guess.
2. **The problem in plain words:** #1992 and #1993 both add a new Settings group called "validation". Separately each is fine. Merged together, the plugin will not build.
3. **The fix the reviewer asked for:** put #1993's red-row switch inside #1992's group and delete #1993's own group. That is a few lines. But #1992's group does not exist on #1993's branch, so #1993 has to be rebuilt on top of #1992.
4. **Why I stopped:** getting #1992's group onto #1993's branch needs a rebase (force-push) or a merge of #1992 into it. This job forbids both: one normal commit, no force-push, no merge.
5. **One-line question for CE 01 or Tim:** "May I merge the #1992 branch (`claude/w1092d`, 0aa753f7) into #1993's branch (`claude/w1092c-design-warn-red`) as one normal merge commit, then move the switch?" Recommendation: yes. The only cost is that #1993's page on GitHub also shows #1992's changes until #1992 is merged first, which is the planned order anyway.
6. **My own mistakes:** none that changed anything. I lost a few minutes because `gh` and `git` are not on the PowerShell PATH; they work from Bash.
7. **What is NOT proven:** nothing was built or tested by me. Nobody has opened #1993 in AutoCAD. BUG-1092 stays OPEN.
8. **Robot case that would prove the fix** (in the style of N31_dp_time), to be written once the fix is made. Case `ff1993_validation_group`: it reads the settings file and drives the Edit Pipe window. Step 1: with both PRs built together, load the plugin (this proves the build). Step 2: type a pipe 6 mm uphill, check the Design Warnings row bullet is red. Step 3 (switch-off control): set `validation.errorRowsShowRed` to false before launch, repeat, check the row is amber. Step 4: confirm `validation.shallowFallStatesFigure` is still read ON from the same group (shows the two switches share one group).

---

## Technical detail

1. **Confirmed on the PR head 2e3d74a4:** `Modules/Drainage/Models/UserSettings.cs:187-189` adds `public ValidationDisplaySettings Validation` with JSON key `validation`. On #1992 (0aa753f7) `:223-225` adds `public ValidationSettings Validation` with the same key. The two sit in different places, so git merges them without conflict, and the build then has two members named `Validation`.
2. **Stray comment confirmed:** in #1993 the new class `ValidationDisplaySettings` was inserted between the `/// Grade settings` summary and `GradeSettings` (diff hunk at old line 1679), so that comment sits on the wrong class.
3. **Why I could not do the minimal fix alone:** `ValidationSettings` exists only on `claude/w1092d`. Without it on the #1993 branch, moving `ErrorRowsShowRed` into it does not compile. Copying the class text into #1993 would make the same duplicate-member failure again when #1992 merges. A rebase needs a force-push; a merge is ruled out by the job text.
4. **The change to make once allowed:** merge `claude/w1092d` into the #1993 branch; add `ErrorRowsShowRed` (JSON `errorRowsShowRed`, default true, "Default: on.") to `ValidationSettings`; delete `ValidationDisplaySettings` and the `Validation` property at `:187-189`; fix the `Grade settings` comment position; reword the REGRESSION_LOG line 3 ("`ValidationSettings.ErrorRowsShowRed`, group `validation`" is already the wording). `ValidationErrorRowConverter.IsSwitchOn` and `Bug1092DesignWarningsErrorRowRedTests.cs` already read `Validation.ErrorRowsShowRed`, so they should compile unchanged. The new-switch-defaults test must pin both switches through both start-up reads.
5. **Build/test:** not run. No dotnet command was started, so the isolation listings (Rule 1) were not needed: no test ran, nothing could write to `%APPDATA%`.
6. **Disk:** worktree created, then removed with no build; C: free space unchanged (58 GB free at start). Local branch `ff1993b-fix` and scratch folder removed. No remote branch touched.
7. **CE_SHARED:** untouched.
