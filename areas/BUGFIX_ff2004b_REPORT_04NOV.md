# BUGFIX ff2004b: fix first for draft PR #2004 (B-185, BUG-1018), written Thu 5 Nov 2026 Melbourne

## FOR TIM

1. **Built and unit-tested only.** Nobody has opened this in AutoCAD. BUG-1018 stays open.
2. **What a drafter will see differently:** a start-up script that loads the pipe object enabler and runs CDPIPEOBJ straight away used to be told "needs the CE pipe object enabler" if it ran within one second of Civil's last look. Now the first look of every new command is a fresh look, so it works at once. Inside one command (a loop over 50 pipes) Civil still looks once.
3. **My own mistakes first:** (a) `gh`, `git` and `dotnet` were not on the shell path; I found them under Program Files. (b) My first two test runs failed on my own run script (a path with a space, then the empty placeholder file in the wrong folder). No effect on the code. About four minutes lost.
4. **Switch:** the PR's existing `options.pipeObjectEnablerRetryWhenNotLoaded`, Default: on. Unchanged, no new switch. With it OFF the first answer is kept for the session, exactly as before (a test pins that, including after a new command starts).
5. **What is NOT proven:** that .NET really looks for the DLL again after a first "not found". Only AutoCAD 2027 shows that. Also not proven: that the command-start handler fires for every drawing, including a drawing Civil has not registered (see technical item 3).
6. **Robot case that proves it:** `B185_enabler_late_load`, extended. It types CDPIPEOBJ with the enabler not loaded and reads the "needs the CE pipe object enabler" line. Then in the SAME type string, in one go, it types ARX, Load, the .dbx path and CDPIPEOBJ again, with no pause, and checks the line is gone (this is the new one-second case). Control: `options.pipeObjectEnablerRetryWhenNotLoaded` false in the settings file before launch; repeat; the line must stay.
7. **One thing I noticed and could not clear:** one file in the real `CE_CADTOOLS` folder changed during my run (item 4 of the technical part). I believe it is the running Manager's heartbeat file, not my run.

---

## Technical detail

1. **Ruling used:** `C:\CE_PLAN\areas\RULING_CODEX_VS_OPUS_SIX_PRS_05NOV.md`, block for PR 2004: CODEX RIGHT, one fix-first commit. Fault confirmed first on the PR head 6dce9df9: `CeCvlObjectsBridge.cs` `IsAvailable`, `if (now - _lastProbeMs < RetryIntervalMs) return false;` (about line 125). The PR's own test moved the clock 1,001 ms so it never saw this.
2. **Commit d964a1f9 on `w1018-nocache-notloaded`** (the PR's own branch, one normal commit, no force-push, no retarget, no merge, no new PR; PR #2004 still draft against `claude/rel-20261102a`):
   1. `CeCvlObjectsBridge.NewCommandStarting()` (new, memory only): when the last answer was "not loaded", forgets the last-look time. A loaded answer and an old-version answer are untouched.
   2. `LinkService.Reactors.cs` `OnCommandWillStart`: one call to it, at the top beside the existing BUG-317 cache clear, before any drawing lookup.
   3. `Bug1018EnablerRetryTests.cs`: three new tests (new command at 0 ms looks again; 50 pipes in that command look once; switch OFF still keeps the first answer after a new command).
   4. `REGRESSION_LOG.md`: the B-185 entry moved to the top (as both reviewers asked) with item 7 for this fix.
3. **Open point:** `OnCommandWillStart` is the existing per-document handler attached in `LinkService.cs` near line 1594. I did not check whether it is attached for a drawing that never reaches that registration. If a script runs in such a drawing, the old one-second wait still applies there. A robot run of the case above would show it.
4. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP and TMP were set to `C:\CE_WORK\scratch\ff2004b\...` before the test and the build. No Structural test ran (so no CE_STRUC_SUITE_APPDATA_ROOT); no Manager test ran. Listings of `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` before and after are in `C:\CE_WORK\scratch\ff2004b\listing_before.txt` and `listing_after.txt` (37,000 lines; the scratch folder is removed after the push, so the diff is quoted here). One difference only: `CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json`, 228 bytes both times, last-write 2026-11-04 18:53:28 UTC before, 18:58:28 UTC after (exactly five minutes apart). I ran no Manager code and my Civil tests write only to the temp folder, so I read it as the live Manager session heartbeat from Tim's open AutoCAD, but I did not prove that. Nothing else changed.
5. **Build and test:** command printed and run from `C:\CE_WORK\scratch\ff2004b\run.ps1` (one project, `--filter FullyQualifiedName~Bug1018EnablerRetryTests`, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, net10.0-windows Release, AutoCAD refs from the C62 assembly report, AutoCAD 2027 on PATH, below-normal priority, empty placeholder `CE_TRANSFORM_2027.arx`). Result: **Passed 12, Failed 0, Skipped 0, Total 12** (not zero). net48 compile of the test project (which builds the Civil net48 target): **0 errors**. Below-27 GB disk and slot checks passed (about 66 GB free at the start).
6. **Not touched:** CE_SHARED, Manager, other settings, Tim's settings files, installed bundles, ProgramData. No AutoCAD, Codex or accoreconsole was started. No bug marked fixed; BUG_CARPARK.md and DESK_LOG.md not edited.
7. **Untested:** anything in AutoCAD; the real enabler load order; the Settings window (this switch still has no row, as in the PR).
8. **Undo:** revert commit d964a1f9 on the branch.
