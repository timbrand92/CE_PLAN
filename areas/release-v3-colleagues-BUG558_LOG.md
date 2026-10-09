# CE_ACAD / release-v3-colleagues / build / 05 (bug558) - log

## ITEM 1 PUSHED (Sat 10 Oct, PC clock ~08:55): draft PR #1002, branch `claude/bug558-global-redo-guard`, head 1e868101, based on `claude/rel-20261009r` (Civil 3.0.45, contains the installed 3.0.44). Desk: build a candidate from that branch for the tester's run 10 repeat (exact steps are the last point of the REGRESSION_LOG entry in the PR). Built and unit-tested only (1299 green, net10 lane); nobody opened it in AutoCAD.

## Run 1 result (Sat 10 Oct, PC clock ~09:10)

1. **Item 1: PR #1002** (global REDO wait + open-close deferred link refresh), pushed first. Base `claude/rel-20261009r`.
2. **Item 2: PR #1004** (Project QA capture, Pit Schedule XREF discovery, XREF notice read open-close), stacked on #1002.
3. **Item 3: PR #1005** (`GetEffectiveBlockName`), stacked on #1002. A pinned test (`RedoSafeCallGraphTests.TheScan_FailsWhenANormalTransactionIsAddedToThePickPath`) and `PitScheduleStatusServiceTests.HostRecordReader_UsesOneReadOnlyModelSpacePass` need the normal `StartTransaction()` kept in these two methods, so they read open-close only while ANY REDO window is open (`RedoWindowGuard.IsOpenAnywhere()`), otherwise exactly as before.
4. **Item 4: PR #1007** (Manager menu: one try per session, no retry after a failure), base rel-r.
5. **Item 5:** a REGRESSION_LOG entry in each PR; the run 10 repeat steps are in #1002's entry (point 7).
6. All draft, all commented "needs Opus review". Tests: net10 lane, 1299 green on the related filters; Manager 2 green. net48/net8 compile only. **I ran the tests while acad.exe was open** (it stayed open for over an hour; source tests only, below-normal priority, 30 s each) - flagging it. Tests need `C:\Program Files\Autodesk\AutoCAD 2027` on PATH to be discovered in a worktree.
7. **Not proven:** that any of this fixes BUG-558. Item 2 and 3 are belt-and-braces behind the global wait. The unmeasured assumption stays: a transaction in Civil can destroy Structural's REDO.
8. Note for Opus review: `_lightIdleReads` is a private static flag (pinned tests match literal call text); a drawing that keeps a window open forever holds the other drawing's background refresh (the Settings hold time still releases it).
9. Worktree `C:\ce-b558` kept for the follow-up; clean with `git clean -fdXq` after the PRs merge.
