# ALREADY-DONE CHECK 08 of 10: old draft PRs #417 to #427 (Mon 2 Nov 2026, Melbourne time)

Read only. Written by Sonnet (Team) for CE 05 / CE 00. Nothing was built, tested, pushed or opened in AutoCAD. Line checked: `origin/claude/rel-20261102a` at 3fbb9da5, after `git fetch`.

## FOR TIM

1. **Counts:** 8 ALREADY-DONE (#417, #419, #420, #421, #422, #423, #426, #427), 2 NOT-DONE (#424, #425), 0 of the other verdicts.
2. **Close now:** #417, #419, #420, #421, #422, #423, #426 and #427. Each one's exact last commit is already on the release line, and each was merged into a Civil train on 30 Sep or 1 Oct. Closing them loses nothing.
3. **Do NOT close:** #424 and #425 (Move My Settings, M-SET-01). Nothing from them is on the line: the folder `tools/CE_AcadSettings` does not exist there and the command `CESETTINGSMOVE` appears nowhere in its history. Closing them would lose the only copy of that work.
4. **Surprise:** #422 fixes only part of BUG-223. The carpark says BUG-223 stays OPEN (the re-link path is BUG-244, pit-to-open-end is BUG-245). The PR can close; the bug stays open.
5. **Not proven:** these are "the code is on the line" findings only. No robot run and no Codex run in AutoCAD is claimed. No bug here is FIXED; the ledger has not accepted any of them by name.
6. **Why it matters:** these 8 PRs are still shown as open drafts, so they look like unmerged work when they are not.

## PER PR (one line each)

1. PR #417 | ALREADY-DONE | BUG-210, BUG-217 | Head 7905e4c8 is on the line; merged by 68ab6098 (30 Sep 2026, "Train C-1: merge PR #417"), with the fixes 06aaf868 (BUG-210) and 3ed1def2 (BUG-217). Base was claude/rel-20260929c.
2. PR #419 | ALREADY-DONE | BUG-212 | Head 6e2aeda4 is on the line; merged by c9d6d18e (30 Sep 2026, "Train C-1: merge PR #419"), fix 8527a2b5 "Fix BUG-212: Place schedule gives an older pit its permanent identity".
3. PR #420 | ALREADY-DONE | BUG-233 | Head cd18a9eb is on the line; merged by e9931c3b (30 Sep 2026, "Train C-1: merge PR #420"). Stacked on #413 (also reachable from the line).
4. PR #421 | ALREADY-DONE | BUG-230 | Head af8b4fa9 is on the line; merged by 5e1328b9 (30 Sep 2026, "Train C-1 final: merge PR #421"), fix 2ac8999a. Stacked on #411 (BUG-209).
5. PR #422 | ALREADY-DONE | BUG-223 (part) | Head 0bd0502a is on the line; merged by 651b2656 (30 Sep 2026, "Train C-1: merge PR #422"), fix b99851bd. Stacked on #404. Only the CDEDIT two-open-ends half of BUG-223 is in this PR.
6. PR #423 | ALREADY-DONE | BUG-232 | Head 7a906c50 is on the line; merged by eefd70e1 (30 Sep 2026, "Train C-1: merge PR #423"), fix 89ad7a0e. Stacked on #409.
7. PR #424 | NOT-DONE | M-SET-01 (no BUG number) | Head a2e232af is not on the line; 75 of its commits are missing, and `tools/CE_AcadSettings` has 0 files on the line.
8. PR #425 | NOT-DONE | M-SET-01 (no BUG number) | Head e319b6ea is not on the line; 72 commits missing, `CESETTINGSMOVE` is in no commit on the line. Stacked on #424.
9. PR #426 | ALREADY-DONE | BUG-236 | Head d2c90661 is on the line; merged by 864a0631 (30 Sep 2026, "Train C-1: merge PR #426"), fix 16862241. Stacked on #417. Related later fix 4ce19d82 (1 Oct, BUG-258, OOPS brings the PD text back).
10. PR #427 | ALREADY-DONE | none named (Kingston storm frequency, Tim's 30 Sep ruling "5 years, with source") | Head a153b63c is on the line; merged by 0b49837c (1 Oct 2026, "Merge #427 (KING-5 Kingston storm) into rel-20261002b"). Stacked on #420.

## Carpark entries to annotate

For these, the Status line could read "fix already on the line, PR can be closed". Each quote is the current Status line, shortened. None is FIXED.

1. **BUG-210** (#417): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #417; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
2. **BUG-217** (#417): same wording, via PR #417.
3. **BUG-212** (#419): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #419; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
4. **BUG-233** (#420): same wording, via PR #420.
5. **BUG-230** (#421): same wording, via PR #421.
6. **BUG-223** (#422): "OPEN (fix installed in ... via PR #404, #422; ...)". Add that the PR is only part of the bug; BUG-244 and BUG-245 are still open. The bug stays OPEN.
7. **BUG-232** (#423): same wording, via PR #423.
8. **BUG-236** (#426): same wording, via PR #426.

Not for annotation: #427 has no BUG number. #424 and #425 have no carpark BUG entry of their own; M-SET-01 is tracked in `areas/manager.md`, which still says "built, draft PRs, not merged", and that is correct.

## What I could not verify

1. **Which PRs were merged on GitHub itself.** I proved the commits are on the line by git, not by GitHub's "merged" flag. They are open drafts on GitHub, which matches the train merges having been done by hand.
2. **Whether the code still behaves the same today.** Later commits may have changed these files. I checked that the PR heads are ancestors of the line, not that no later change altered the behaviour.
3. **Anything about behaviour in AutoCAD.** None of this was run. No robot or Codex pass was looked up for these bugs.
4. **#424 and #425 under another name.** I searched the line's history for the command name, the folder and "Move My Settings". Nothing turned up. A rewrite under a different name that avoids all three is not ruled out, but is very unlikely. `areas/release-v3-colleagues-HUNT_MANAGER_INSTALL_2026-10-12.md` also said it was not merged on 12 Oct.
5. **The tool's PATH did not have `gh` or `git`.** I used `C:\Program Files\GitHub CLI` and the Git Bash `git`. `git fetch origin` reported no errors.
