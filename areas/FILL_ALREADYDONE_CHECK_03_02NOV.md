# Already-done check 03 of 10: open draft PRs #359 to #368 (Mon 2 Nov 2026)

Checked read-only against origin/claude/rel-20261102a (tip 3fbb9da5, fetched 2 Nov 2026). Nothing was built, tested or run in AutoCAD. Nothing was changed except this file.

## FOR TIM

1. **Counts:** 10 ALREADY-DONE. 0 PARTLY-DONE, 0 SUPERSEDED, 0 NOT-DONE, 0 DOCS-ONLY, 0 CANNOT-CONFIRM.
2. **Closable now:** all ten (#359 to #368). The exact last commit of each PR is already part of the release line, so merging any of them would add nothing.
3. **Surprising:** every one of these PRs was merged by way of a release branch in the 29 Sep combine, but the PR pages stayed open. The carpark entries for BUG-191, 067, 062, 064, 065, 011 and 012 already say "fix installed in Civil 3.0.70 via PR #...", so they are consistent.
4. **Still not proven in AutoCAD:** "already on the line" means the code is there. It does not mean the fix works. Seven of the entries still read OPEN "not yet tested by robot or Codex". Nothing here is FIXED by this check.
5. **Odd one:** BUG-167 (the zip hang) still has an old "OPEN" Status line that says the fix was only built on 29 Sep. The code is on the line now.

## One line per PR

1. PR #359 | ALREADY-DONE | BUG-191 | PR head bb472399 (28 Sep, "Fix BUG-191: Inspector Use plan label routes through a real command") is on the line; the CDUSEPLANLABEL command file is still there at the tip.
2. PR #360 | ALREADY-DONE | BUG-189 (round 4) | PR head 33bcf8c7 is on the line together with 82862286 (29 Sep, "BUG-189 speed round 4 - stop the open-time 49-pipe flush freeze"); the upgrade-suppression code is still at the tip. Its base was master, not a release branch.
3. PR #361 | ALREADY-DONE | BUG-186 (reopened) | PR head 677dd6a5 (29 Sep, "Fix BUG-186 REOPENED: grade choice survives Detention + Existing/New") is on the line; the remembered-grade fields are still at the tip. Version commit b90d7eb1 names it.
4. PR #362 | ALREADY-DONE | BUG-193 | PR head 1ecac975 (29 Sep, "Fix BUG-193: typed Pit Schedule SIZE now resizes the real pit") is on the line; the size-edit planner is still at the tip. The carpark already shows this one FIXED by Codex.
5. PR #363 | ALREADY-DONE | BUG-067 | PR head 0a79865a (29 Sep, "Fix BUG-067: Pit Schedule FROM column never silently blank or guessed") is on the line. It sat on top of #362 (base was the BUG-193 branch).
6. PR #364 | ALREADY-DONE | BUG-167 | PR head d6bea373 (29 Sep, "Fix BUG-167: replace hanging Compress-Archive with ZipFile.CreateFromDirectory") is on the line; the new zip helper is still in build_installer.ps1. Its base was master.
7. PR #365 | ALREADY-DONE | BUG-062 | PR head 61eff37e (29 Sep, "Fix BUG-062: imported pits use the real source block's rotation") is on the line; the scanner file is still there.
8. PR #366 | ALREADY-DONE | BUG-064 | PR head f42798c6 (29 Sep, "Fix BUG-064: Propose fixes for all always reports a plain grouped result") is on the line; the summary file is still at the tip.
9. PR #367 | ALREADY-DONE | BUG-011, BUG-012 | PR head 0bda3751 (29 Sep, "Fix BUG-012: FALL text patch no longer drags both texts to the origin; lock BUG-011 callout left-justify") is on the line. The PR itself says BUG-011 was already fixed by BUG-128.
10. PR #368 | ALREADY-DONE | BUG-065 | PR head b42766ab (29 Sep, "Fix BUG-065: imported pipes stop on the pit outline using CD's one outline rule") is on the line; the outline snap is still used in the pipe import file.

## Carpark entries to annotate ("fix already on the line, PR can be closed")

Current last Status line quoted in short. None is changed to FIXED by this check.

1. **BUG-191** (PR #359): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #359; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
2. **BUG-189** (PR #360, round 4 only): "FIXED — 2026-09-30 (Tim's word 29 Sep plus Codex pass 18 timing; reconciled 23 Oct 2026)". Only the PR note is needed. The status already stands.
3. **BUG-186** (PR #361): "IN PROGRESS (28 Sep 2026: found already fixed in source ... commit 73c7d402 ... Not yet Tim-confirmed in AutoCAD ...)". It does not yet mention #361, the reopened-case fix.
4. **BUG-193** (PR #362): "FIXED — 2026-09-30 (Codex-accepted, pass 18, ordinary pit only; P6 900 x 900 case not tested; reconciled 23 Oct 2026)". Only the PR note is needed.
5. **BUG-067** (PR #363): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #363; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
6. **BUG-167** (PR #364): "OPEN. It must be fixed or understood before the Tuesday colleague package is built." (the note above it says built 29 Sep as PR #364, to be exercised by the install build). This is the stalest line.
7. **BUG-062** (PR #365): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #365; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
8. **BUG-064** (PR #366): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #366; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
9. **BUG-011** (PR #367): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #367; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
10. **BUG-012** (PR #367): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #367; not yet tested by robot or Codex; reconciled 23 Oct 2026)"
11. **BUG-065** (PR #368): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #368; not yet tested by robot or Codex; reconciled 23 Oct 2026)"

## What I could not verify

1. **Works in AutoCAD:** I read git history only. No build, no test, no robot, no AutoCAD. "On the line" is not "fixed".
2. **Later rewrites:** I confirmed one distinctive name from each PR still exists at the tip, but I did not read the code to see whether later commits changed the behaviour. For #360, later commits (for example 2 Oct and 4 Oct changes to the pipe upgrade code) touch the same area. For #365 and #367 my name search found nothing, because those PRs only added test files with those names. I relied on the head commit being on the line and the scanner and text-justification source still being there.
3. **BUG-186 and #361:** I did not confirm that the BUG-186 carpark entry (the line that quotes commit 73c7d402) describes the same fault as the reopened Detention case in #361. The commit proof for #361 itself stands.
4. **Other BUG numbers:** I did not look for BUG numbers a PR might name only in its REGRESSION_LOG entry. I took them from the PR titles, descriptions and carpark.
5. **Tools:** gh was not on the shell PATH, so I called it by full path in Program Files. The PR list order and the "open" state came from gh pr view on each number. I did not re-run the full open-PR list.
