# BUGFIX w658 (B-180, BUG-658): no new PR opened, the fix is already built as draft PR #1972 (3 Nov 2026)

## FOR TIM

1. **Answer:** BUG-658 is already built. Draft PR #1972 (B-119) has the same fix on the same base (`claude/rel-20261102a`), opened 31 Oct. I opened nothing, so there is no duplicate to sort out.
2. **What you will see once #1972 is installed:** in Edit Pipe, change the downstream level and press Save. The "Recalculate downstream inverts?" question now comes after the edit has been saved. If the save is refused (for example the label layer is locked), no question appears and the false "[CDEDIT-CASCADE] Updated N pipes" line is never printed. One Undo takes back the edit and the cascade together.
3. **My mistake first:** I built my own copy of the fix (switch, code, tests) before I searched for an existing PR. I found #1972 only when I looked for a branch name. I threw my copy away unpushed. It cost about 30 minutes of work and nothing else.
4. **Not proven:** nobody has opened this in AutoCAD. I ran no build and no tests in this job, so I saw no test result. BUG-658 stays OPEN. #1972 is still a draft and needs the robot and Codex pass.
5. **Robot case to prove it (not written by me):** needs a pipe whose label layer is locked, then Edit Pipe, change the downstream (To) level, Save. It checks that the command line has no "[CDEDIT-CASCADE]" line and that the pipe record keeps the old level. The switch-off control sets `pipe.cascadeQuestionAfterEditCommits` to false and expects the old behaviour: the question is asked before the refusal.

---

## Technical detail

1. **Fault confirmed on base 3fbb9da5 (`origin/claude/rel-20261102a`):** `Commands/PipeEditCommand.Update.cs`, `UpdatePipeSchedule` ends by calling `PromptDownstreamCascadeIfInvertChanged(pipeData, toInvert, oldToInvertSnapshot)` (about line 1908 on base) while the coordinated transaction opened near line 506 is still open. The commit is about line 1090. The comment near 335 says questions come after it closes. So the fault was real on the base.
2. **Already built:** PR #1972, draft, mergeable, branch `claude/b119-bug-658-cascade-after-commit` (commits 556b3848 and 32fc1a44). Files: `Commands/PipeEditCommand.Update.cs`, `Models/UserSettings.cs`, new `Rules/CascadeAfterCommitRule.cs`, new `Bug658CascadeAfterCommitTests.cs`, `REGRESSION_LOG.md`. Switch `pipe.cascadeQuestionAfterEditCommits`, ON. It holds the question in `UpdatePipeSchedule` and asks it after the commit and the stale-marker removal. It skips a batch, a dry run, a refused commit and a commit that needs recovery, and it prints a plain line when the question is skipped for recovery. A failing cascade leaves the saved pipe saved.
3. **My own version, discarded:** the same shape (an `Action` held back and run after commit, switch `pipe.cascadeAskAfterCommit`). I compared it with #1972 and #1972 is the more complete one (it also covers the recovery notice), so I did not push mine.
4. **Not checked by me:** #1972's own tests and build, the "both start-up reads" pin, and the CE_SHARED-untouched claim (its diff list shows no CE_SHARED file). I read the diff only. Settings-file isolation did not matter: no test ran.
5. **Isolation listings (rule 1):** no `dotnet test` ran, so there is nothing to compare before and after. The real %APPDATA% files were not written by this job.
6. **Cleanup:** worktree `C:\CE_WORK\build\w658` removed after `git clean -fdXq`. Scratch folder `C:\CE_WORK\scratch\w658` was empty and was removed. C: free space is 69 GB and did not move meaningfully (no build ran). The local branch `claude/b180-bug658` (no commits, equals the base) was left in place.
7. **B-180:** unused. CE 01 may release it.
