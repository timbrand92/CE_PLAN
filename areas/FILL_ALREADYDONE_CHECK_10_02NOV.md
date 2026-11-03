# ALREADY-DONE CHECK 10 of 10 (Mon 2 Nov 2026, Melbourne time)

Read-only check by Sonnet. Nothing changed except this file. Nothing built, tested or opened in AutoCAD.
Release line checked: origin/claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88 / Manager 1.1.88, 31 Oct 2026), after a fresh git fetch.

## FOR TIM

1. **Counts:** 10 of 10 PRs are ALREADY-DONE. None is partly done, superseded, not done, docs-only or unconfirmed.
2. **Close now:** #442, #443, #444, #448, #450, #452, #453, #454, #458, #460. Each PR's exact last commit is already inside the release line, and each has a "Merge #N" commit (or a "Train C-2 final: merge PR #N" commit) dated 1 Oct 2026.
3. **Surprising 1:** #453, #454 and #460 say their base is master, but the work is on the line anyway (merged through the rel-20261002b train).
4. **Surprising 2:** BUG-260 is still worded "OPEN (1 Oct 04:20) - diagnose from the installed build; Opus". That is stale. Its fixes (PR #444 and #454) are on the line. BUG-256 is also worded differently from the rest (see the annotate list).
5. **What this does NOT say:** none of these bugs is FIXED. "Already on the line" means the code is there. The robot plus Codex in real AutoCAD still decide FIXED (RULES.md 13.3).
6. **PR #442 caution:** its own text says it does NOT fix what Codex saw in VERIFYC1 V3.01 (the CLOSE step in U). That part was AutoCAD's own and the lost REDO is BUG-256. Closing the PR does not close that observation.

## PER PR (oldest first)

1. PR #442 | ALREADY-DONE | BUG-257 | head 0e52afc3 is on the line; merged by ae33d561 (1 Oct 2026, "Train C-2 final: merge PR #442 BUG-257").
2. PR #443 | ALREADY-DONE | BUG-258 (also named BUG-236 and BUG-248) | head 0f0feb1b is on the line; merged by f166b235 (1 Oct 2026, "Train C-2 final: merge PR #443 BUG-258").
3. PR #444 | ALREADY-DONE | BUG-261, BUG-260 | head 37b98b94 is on the line; merged by e9b4cd85 (1 Oct 2026, "Train C-2 final: merge PR #444 BUG-261/260"); fix commit 7bad3dfb.
4. PR #448 | ALREADY-DONE | BUG-259 | head 87d91ab2 is on the line; merged by 2e1690c0 (1 Oct 2026, "Merge #448 (BUG-259 confirm outlet) into rel-20261002b").
5. PR #450 | ALREADY-DONE | BUG-266 | head 146e2bf3 is on the line; merged by 15b2e00d (1 Oct 2026, "Merge #450 (BUG-266 far copy) into rel-20261002b").
6. PR #452 | ALREADY-DONE | BUG-256 | head 2ebc7565 is on the line; merged by c4c54f79 (1 Oct 2026, "Merge #452 (BUG-256 REDO gate, head 2ebc7565) into rel-20261002b").
7. PR #453 | ALREADY-DONE | BUG-270 | head a4c48912 is on the line; merged by 95c3f212 (1 Oct 2026, "Merge #453 (BUG-270 reach units) into rel-20261002b").
8. PR #454 | ALREADY-DONE | BUG-260, BUG-262 | head 181d69cb is on the line; merged by bbec3912 (1 Oct 2026, "Merge #454 (BUG-260/262) into rel-20261002b").
9. PR #458 | ALREADY-DONE | BUG-269 | head dfed4d03 is on the line; merged by b7fc3dc8 (1 Oct 2026, "Merge #458 (BUG-269 array cleanup) into rel-20261002b").
10. PR #460 | ALREADY-DONE | BUG-267, BUG-268 | head 9020c48a is on the line; merged by 3a86dc5f (1 Oct 2026, "Merge #460 (BUG-267/268) into rel-20261002b").

How each was proved: for every PR, `git merge-base --is-ancestor <PR head sha> origin/claude/rel-20261102a` answered yes, and `git log --grep "BUG-NNN"` found the PR's own commits plus a merge commit on the line. #453, #454 and #460 target master and are stacked on nothing; #442, #443, #444 target rel-20261001a; #448, #450, #452 and #458 target rel-20261002a. None is stacked on another open PR.

## CARPARK ENTRIES TO ANNOTATE ("fix already on the line, PR can be closed")

Current last Status line is quoted in short. Never write FIXED.

1. **BUG-256** (PR #452): "OPEN (general case passed Codex W35; residual REDO cases tracked as BUG-558 and BUG-861; reconciled 23 Oct 2026)". Different wording from the others; the PR is on the line, so only the "PR can be closed" note is needed.
2. **BUG-257** (PR #442): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #442; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
3. **BUG-258** (PR #443): "OPEN (fix installed in Civil 3.0.70 ... via PR #443; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
4. **BUG-259** (PR #448): "OPEN (fix installed in Civil 3.0.70 ... via PR #448; not yet tested ...)".
5. **BUG-260** (PRs #444 and #454): "OPEN (1 Oct 04:20) - diagnose from the installed build; Opus." Stale: it does not mention either PR.
6. **BUG-261** (PR #444): "OPEN (fix installed in Civil 3.0.70 ... via PR #444; not yet tested ...)".
7. **BUG-262** (PR #454): "OPEN (fix installed in Civil 3.0.70 ... via PR #454; not yet tested ...)".
8. **BUG-266** (PR #450): "OPEN (fix installed in Civil 3.0.70 ... via PR #450; not yet tested ...)".
9. **BUG-267** (PRs #443 and #460): "OPEN (fix installed in Civil 3.0.70 ... via PR #443, #460; not yet tested ...)".
10. **BUG-268** (PRs #444 and #460): "OPEN (fix installed in Civil 3.0.70 ... via PR #444, #460; not yet tested ...)".
11. **BUG-269** (PR #458): "OPEN (fix installed in Civil 3.0.70 ... via PR #458; not yet tested ...)".
12. **BUG-270** (PR #453): "OPEN (fix installed in Civil 3.0.70 ... via PR #453; not yet tested ...)".
13. **BUG-236 and BUG-248** (older IDs of BUG-258 in PR #443): both say "OPEN (fix installed ... via PR #426; not yet tested ...)". They also gained a second fix through PR #443; add a note only if CE 05 wants them linked.

## WHAT I COULD NOT VERIFY

1. **Behaviour in AutoCAD:** I did not run anything. "On the line" means the code is there, not that it works. Every one of these bugs is still untested by the robot and Codex.
2. **Later edits:** I confirmed each PR's last commit is on the line. I did not check that nothing after 1 Oct changed or removed those changes. For #442 the BUG-224 close-time-write work was touched again on 7 Oct (commits 50d95026, e8ef3a93), which I only noted, not read.
3. **#442 V3.01 question:** the PR itself says the Codex V3.01 observation is not fixed by it. I did not check what BUG-558 or BUG-861 hold.
4. **BUG-260 and BUG-262 text:** I checked the carpark Status lines only, not whether every symptom listed in BUG-260 (V1.01, V2.01, V5.01) is covered by #444 and #454.
5. **gh and git:** the shell had no gh or git on PATH at first; I added their folders for this session only. No write command was run.
