# Fix round for the Opus audit findings (HIGH 1 + MEDIUM 3), Thu 22 to Fri 23 Oct 2026 (Melbourne)

Job: desk plan/03, Team (Sonnet 5.5), headless. Input: `areas\AUDIT_C58_C60_S40_S41_2026-10-22.md`. Four small DRAFT PRs, each with a test, a REGRESSION_LOG entry and a PR comment. Nothing closed or deleted, no bug marked fixed, no AutoCAD, Codex or accoreconsole started, no installed bundle, ProgramData or Tim settings file touched, no `--no-verify`.

## ANSWER FIRST

1. **PR #1523 (HIGH 1, outcome line).** Base `claude/rel-20261022m` @ `40ee0a36` (Civil 3.0.70), new head `95eafe45`. Tests added 5 (CommandOutcomeLineTests, red before: they did not compile without the new flag). Civil net10: 19,159 run, 19,139 pass, 1 red (BackTest_GlenEira24115, known). net48 0 errors.
2. **PR #1525 (MEDIUM 2, CDCHECKIGNORE switch first).** Base `40ee0a36`, new head `98c41c9d`. Tests added 2 (CheckIgnoreSwitchFirstTests, source pins that prove the order). Civil net10: 19,156 run, 1 red (the same known one). net48 0 errors.
3. **PR #1529 (MEDIUM 3, existing 18HIDDEN / 9HIDDEN2 kept).** Base `claude/rel-20261022s2` @ `2c9a9694` (Structural 1.0.121), new head `7bf04976`. Tests added 2 (ExistingHiddenLayerKeptTests: default names and renamed names). Structural net10: 4,687 run, 0 fail (the test host hangs after printing results, killed by timeout, as earlier reports say). Structural net48 not built (one shared helper, no new API).
4. **PR #1532 (MEDIUM 4, BUG-861 instrumentation).** Base `40ee0a36`, new head `aca3a793`. Tests added 7 (PickHandlerProbeTests). Civil net10: 19,161 run, 2 red: the known one and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (16 s timeout under machine load; passes alone, 8 of 8 with the probe tests). net48 0 errors. Instrumentation only: no fix is claimed.
5. **Desk tool:** `C:\CE_PLAN\desk_jobs\log_outcomes.ps1` now reads `Command outcome: <CMD> refused N ms` as REFUSED (README line updated). Dry run on a made-up log (refused 1, completed 2 incl. PIT, cancelled 1): CDCHECKIGNORE shown refused, PIT worked 1 and cancelled 1.
6. **Not run in AutoCAD.** Built and unit-tested only. All four need Opus review; none is installed.

## What each PR does, in AutoCAD words

1. **#1523 outcome line.** A PIT, CD or DP run that placed something and ended with Esc now logs "completed" instead of "cancelled"; "cancelled" only when nothing was placed; CDCHECKIGNORE's "Nothing was changed" endings log "refused". Mechanism: a small in-memory flag the commands set where they already report (the shared "item placed" step in `PlacementContinuationService`, and each refusal in `CheckIgnoreCommand`); not a text match. Other commands that refuse can call the same one line. Structural's own CEMEMBER records were not changed.
2. **#1525 CDCHECKIGNORE.** With the switch OFF it says so and returns before any project-record read or save. With the switch ON the record is brought up to date only at the moment an Ignore or Un-ignore is written (Esc at any question saves nothing).
3. **#1529 hidden layers.** CEMEMBER and SBEAM leave an existing layer exactly as it is (linetype, colour, lineweight); a missing layer is still created. Side effect: a CE-made 18HIDDEN once created Continuous is no longer upgraded to HIDDEN automatically.
4. **#1532 instrumentation.** With debug logging ON, one `[PickProbe]` line per CE handler on a pick (grip probe, pick-first observer, Inspector refresh, ownership highlight, QA refresh): open transactions before and after, drawing changes while it ran, whether the REDO window was open. Capped at 400 lines. Undo state read from outside with the driver's `getvar UNDOMARKS` and `UNDOCTL` (no typed LISP; the managed API exposes no undo controller).

## Facts and hazards

1. **Merge conflict to expect:** #1523 and #1525 both edit the top of `CheckIgnoreCommand.IgnoreFinding` (the refused-flag lines and the switch-first reorder); `REGRESSION_LOG.md` conflicts as usual. Merge one, resolve the other.
2. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` was held ("Device or resource busy") by another job from 23:22 onward and never freed, so I could not write it. I waited about 8 minutes once, then built in my own worktrees under `C:\ce-fx` with fresh TEMP and log folders. I did not delete the lock (not mine).
3. **Structural.Tests restore:** needs `dotnet restore` with `-p:EnableUnifiedHostAdapters=true` first (the test project builds Structural as "Hosted"); otherwise NETSDK1004.
4. **Mistake, owned:** I ran a bare `python3` probe once by habit; it hung and I stopped it. Nothing was written by it.
5. **Not tested:** anything in AutoCAD; Structural net48; Manager; the Installer tests; red-before proof by running the old code (reds are by construction for #1523 and #1529; #1525 and #1532 pins check text that the old code does not have).
6. **Settings files:** none touched (no setting is read or written by these changes except the existing `checks.allowIgnoreFinding` read).
7. **Four words:** built and unit-tested. Not installed. Nobody has opened any of it in AutoCAD.

## Hygiene

1. Worktrees `C:\ce-fx\w1` to `w4` removed at the end (branches stay on origin for the PRs). Scripts and logs already in `C:\ce-fx` from an earlier job were left alone.
2. `DESK_LOG.md` and `BUG_CARPARK.md` not edited.

## Summary

Four draft PRs: #1523 outcome line (completed after an Esc-ended placing run, refused for refusals; watcher updated), #1525 CDCHECKIGNORE reads its switch before any save, #1529 CEMEMBER/SBEAM never change an existing hidden layer, #1532 BUG-861 debug-only probe lines. 16 tests added; Civil net10 about 19,160 run (only known reds plus one load-timing PDF test), Structural 4,687 pass. Nothing run in AutoCAD.
