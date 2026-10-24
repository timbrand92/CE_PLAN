1. **ANSWER FIRST — Team fix batch 11, 24 Oct 2026 (Melbourne).** One of five fixed (as a draft PR), two already covered by Codex PR #1719, two skipped as protected Installer code. Nothing closed, deleted or marked FIXED. Not opened in AutoCAD.

2. **BUG-1065 (failed first install leaves the loading file): SKIPPED.** The cause is in `Installer/SafeBundleInstaller.cs` (protected). Codex FA04 already routed it in draft PR #1714 (head `fe99515f`). I confirmed by reading that the clean-up error is still swallowed on the base. I commented on #1714. Needs the Installer owner. Options are in `CODEX_FIXAUDIT_FA04_23OCT.md` item 4.

3. **BUG-1066 (backup path forgotten when restore fails): SKIPPED.** Same protected file and the same PR #1714. The fixture test Codex proposed is in `CODEX_FIXAUDIT_FA04_23OCT.md` item 7.

4. **BUG-1067 (eight pipe-label tests pass without checking): NOT DUPLICATED.** Codex draft PR #1719 (head `b6d3d692`, branch `cx4/fa05-rd09-tests`) turns them into honest "UNVERIFIED" skips with guard tests. Full Civil net10 there: 19,540 passed, 0 failed. I commented on #1719. The real saved-entity check is still owed (native fixture).

5. **BUG-1068 (pipe-to-pit ownership tests): NOT DUPLICATED.** Same PR #1719. Same remainder: a native P3/P5/P9 fixture is still owed.

6. **BUG-1069 (drawing-close checks look in a retired folder): FIXED IN DRAFT PR [#1766](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1766).**
   1. **Base and head:** base `claude/rel-20261023s` at `e6d597c0` (Structural 1.0.122, needed because only that branch has `ForgetDrawing`; the Civil base `...23m` still says `Invalidate`). Branch `fb/b11-bug1069-teardown-guards`, head `d5f3c84d7505315f5b635882dce119d9c2d3187b`. Codex FA05 skipped this one as Structural scope; no existing PR covered it.
   2. **Change:** two checks moved into `Modules/Structural.Tests/Services/FoundationMonitorDetachGuardTests.cs`. They read the real Structural source, fail if it is missing, look at Detach only (Attach also calls ForgetDrawing), and need the clear inside the lock and before `ForgetDrawing`. The two old cases were removed from Civil `TeardownCrashGuardTests`. REGRESSION_LOG entry at the top. No production, Shared or Settings change.
   3. **Tests:** new class 3 of 3 pass. Mutation: lock removed from Detach in a disposable edit gave 1 of 3 failing (restored afterwards). Before: the old pair were skipped (that is the bug). Structural net10 in 14 chunks (Sbeam classes excluded as the recipe says): 5,444 passed, 0 failed. Civil `TeardownCrashGuardTests` net10: 5 of 5 pass.
   4. **Real-AutoCAD check:** open two synthetic drawings A and B, each with a CE footing driver. In A, MOVE the driver 100 mm, then CLOSE and answer No. Right looks like: B stays responsive, its footing is unchanged, and the CE log has no Monitor.OnIdle failure for A. Not run by me.

7. **What I did NOT test.** AutoCAD (an acad process was already running on the PC; I did not touch it), accoreconsole, net48 and net8 lanes, the Sbeam classes, Manager and Installer suites, a full Civil suite, the whole-solution build. The Structural run is by class-name chunks, so 5,444 is not the full suite total. Settings files, bundles and ProgramData were not touched. C: free space was 15.9 GB before building.

8. **Housekeeping.** Worktree `C:\ce-fx\b11w` removed after the push; scratch scripts `b11*` and `t_b11` removed. Window pictures that the Structural test run regenerates were reverted and not committed.
