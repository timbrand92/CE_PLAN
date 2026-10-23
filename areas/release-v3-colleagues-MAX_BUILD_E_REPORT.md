# Max build E report: the small Opus review fixes for train C-63 (23 and 24 Oct 2026, Melbourne)

Builder: Claude Sonnet 5.5, Max meter. Built and unit-tested only. Not installed. Nobody has opened any of this in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, CE_SHARED not touched, nothing deployed, AutoCAD and Codex not started, Tim's settings and installed bundles not touched. All pushes were normal pushes to each PR's own branch (no force, no rebase).

## ANSWER FIRST

1. **Four PRs now carry their review fix, pushed:** #1692, #1682, #1665, #1650. Each has a test that was red before the fix (or does not compile without it) and green after, a `REGRESSION_LOG.md` entry, and a full Civil net10 run in the thousands.
2. **Two PRs needed no code from me:** #1648 (its newer commit `dddd45a6` is already on GitHub and is the PR head, so nothing was missing and nothing was recreated) and #1664 (review A's verdict is "Tim's answer, not code": the unknown-material roughness is his call).
3. **Test totals, all Civil net10, Debug, `-p:SkipDevBundle=true -nr:false --disable-build-servers`:** 19,559 / 19,563 / 19,555 / 19,472 total. In every run exactly 2 failed and they are the same two: `FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure` in `SourceAtomicCoordinatorDependencyTests`. They read the compiled Release code, so a Debug build fails them (Opus review A saw the same two). I did not run a Release build, so I did not prove they pass in Release on these heads.
4. **Not done by me (listed below):** Manager and net48 builds, the Installer suite for #1648, anything in AutoCAD.

## Per PR

1. **#1692 (CDNEWDWG, BUG-969 follow-up): done. New head `c0706e5e9bc31f50e2b88368b74f4c76e485b6e1` on `fb/max-c-newdwg`.**
   1. **Fix:** the folder the window opens on is now covered. `NewJobDrawingCommand` hands the window the record only if it was read (`JobRecordService.TryLoad`), otherwise nothing; `NewJobDrawingRecordSource` treats "nothing handed in" as "not read yet", so its first look reads and flags a failed read and reads it again later. In AutoCAD terms: a locked or still-downloading job record in the drawing's own job folder now shows the "could not read it just now" line instead of a silent blank REF NO.
   2. **Tests:** three new in `Bug969FailedReadRecoveryTests` (locked starting record flagged then read after release; starting folder with no file is blank, not a failure, not read twice; the command no longer uses the blank-on-failure reader). Red before: 3 failed, 14 passed (17 in the class). Green after. Full Civil net10: 19,559 total, 19,535 passed, 22 skipped, 2 failed (the two Debug-only ones).
   3. **Left alone (the review said neither blocks):** a failed read is retried on each preview refresh; Create with a failed read still makes the sheet with blank details (the preview says so).
2. **#1682 (Edit Pit rename, BUG-664): done. New head `19f02107844622b48430354bf82f02f991c3404b` on `fb/fb06-pit-rename-pipe-notes`.**
   1. **Fix:** each pipe's note is read and rewritten inside its own guard, so one unreadable note is skipped and counted and the other pipes still rename. Edit Pit now says so on the command line ("n pipe(s) have a note CE could not read ... run CDREPAIR before placing a new pit with the old number"), and also says a plain line if the whole note rename fails. Still one transaction and one Undo step, no relink, protected pipes still refused.
   2. **Tests:** three new in `PitRenameOwnershipTests` (a damaged note among four pipes leaves the others renamed and is counted; a logging failure cannot stop the count; source guard for the per-pipe guard and the two command-line lines). They do not compile on the base because `Guarded` and `PipeOutcome` are new, so I did not run a separate red; that is the "before". Full Civil net10: 19,563 total, 19,539 passed, 22 skipped, 2 failed (the two Debug-only ones).
   3. **Not covered:** the writer itself needs a real drawing, so the Codex FX-06 check still owns that. The follow-up the review logged (one route for CDRENUMBER and the record's "same pit, new number") is not built.
3. **#1665 (wording): done. New head `24b09bd92753f00e0c03755e583167037d0b2cc6` on `fb/max-wording-1`.**
   1. **Fix:** the CDREPAIR ribbon label (`command-registry.json`) and toolbar display name (`ce_toolbar_layout.json`) now say "Repair Centre". One small addition beyond the review's two lines: the tooltip in the same registry entry said "repair center", so I changed that word too (same spelling fault, same entry). No command, icon, group or position changed.
   2. **Tests:** one new in `Bug943RepairCentreWordsTests`. Red before: 1 failed, 4 passed (filter Bug943). Green after. Full Civil net10: 19,555 total, 19,531 passed, 22 skipped, 2 failed (the two Debug-only ones). The ribbon and registry guard tests passed.
   3. **Not done:** the "Approved 0" strip wording the review mentioned as optional.
4. **#1650 (BUG-875 and BUG-802): done. New head `4f66d54007e27b3eb1ca6ae04ead01f744ec3ba1` on `cx2/bug-875-ignore-inputs`.**
   1. **Fix:** an ignore saved before the row carried a rule value now comes back as "P7 changed since you ignored this" instead of the untrue "the rule value for P7 changed". A really different saved value still says the rule value changed. The existing regression entry gained item 8 (this fix, plus the review's note that "Show where" now frames the pit as well as the pipe).
   2. **Tests:** two new in `Bug875IgnoredInputChangesTests`. Red before: 1 failed, 20 passed (the second new case is the control). Full Civil net10: 19,472 total, 19,448 passed, 22 skipped, 2 failed (the two Debug-only ones).
   3. **Not changed by me:** the PR still targets `claude/rel-20261023l`; retargeting to the C-63 branch is the train assembler's job (I did not retarget). The review's "Show where" statement is from its code reading; I did not drive it.
5. **#1648 (BUG-886): nothing to apply.** `gh pr view 1648` shows the head is `dddd45a65b96222efbd5294932c5abb81dbbeaf7` ("BUG-886: retain unknown-office warnings in durable install results"), already on GitHub and on `origin/cx2/bug-886-office-approval`. Its change is three files (`Installer/CeInstallerApplication.cs`, one test, the log). I did not recreate anything. **Still owed before merge, per the review:** run the Installer suite (exclude `RetiredRivalDeployRoutes` and `StructuralPreparation`, which run live deploy scripts on Tim's PC). I did not run it: it is not code I changed and the live-script risk is Tim's PC.
6. **#1664 (BUG-868): nothing to apply.** Review A marks it MERGE-WITH-FIXES only because settling "a pipe with no recorded material sizes as rough as concrete (0.013)" is Tim's call (RULES 4.5). No code fault. Needs his word on Monday; until then it cannot be Codex-accepted. If he picks "refuse" or "roughest" that is a follow-up PR.

## What was NOT done or NOT tested

1. **Nothing was opened in AutoCAD.** None of the four fixes is Codex-accepted or Tim-accepted. Real AutoCAD checks remain as written in each log entry.
2. **Builds:** Civil net10 Debug only. I did not build net48, net8, Release, or the Manager or Installer projects. Because nothing touched Manager or Installer code, this is expected, but it is not proven by me.
3. **The two Debug-only reds** (above) were not shown to pass in Release.
4. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` existed (dated 20:24 on 23 Oct, locked by something, "Device or resource busy" on read), so I could not take it as the C-62 assembler did. No other build was running that I could see (only idle dotnet servers and AutoCAD). I ran my builds one at a time and did not touch the lock file.
5. **#1682 had no separate red run** (the new tests cannot compile on the base).
6. **Free space:** 13 to 14 GB before every build (the stop line was 12 GB). I removed each worktree right after its push to keep it that way.

## Hygiene

1. **Private worktrees:** `C:\ce-mx2\n`, `\p`, `\w`, `\c`, each removed after its push, local branches deleted. No other `C:\ce-*` folder touched. The folder `C:\ce-mx2` holds only my own build logs and is removed at the end.
2. **Untracked build placeholder:** each worktree had an empty `CE_TRANSFORM_2027.arx` (the native file a fresh worktree lacks, same as the C-62 assembler); it was inside the removed worktrees and ignored by git.
3. **Not edited:** `DESK_LOG.md`, `QUEUE.md`, `BUG_CARPARK.md`, the local clone `C:\Lisp Files\CE_ACAD_PLUGIN`.

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted or Codex-accepted.**
