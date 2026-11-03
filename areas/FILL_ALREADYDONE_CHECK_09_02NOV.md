# Already-done check 09 of 10: draft PRs #429, #432, #433, #434, #435, #437, #438, #439, #440, #441

Written Mon 2 Nov 2026 (Melbourne) by Sonnet (Team), read-only, for CE 05 / CE 00.
Lines read: Civil/Manager `origin/claude/rel-20261102a` (3fbb9da5, 31 Oct 2026) and Structural `origin/claude/rel-20261026s`, after `git fetch`.

---

## FOR TIM

1. **Counts:** ALREADY-DONE 10, PARTLY-DONE 0, SUPERSEDED 0, NOT-DONE 0, DOCS-ONLY 0, CANNOT-CONFIRM 0.
2. **Close now:** all ten (#429, #432, #433, #434, #435, #437, #438, #439, #440, #441). Every PR's last commit is already inside the release line, so nothing is lost by closing them.
3. **Proof used:** the PR's last commit is part of the line's history (git's "is this an ancestor" check). Nine are on the Civil/Manager line. #440 is the Structural one and is on the Structural line, not the Civil one.
4. **Surprising:** none of the ten PRs fixes a carpark bug of its own. They are build items (Design colours, During tab, Land use, pipe sizes, reo bars). So no carpark Status line needs "fix already on the line, PR can be closed" from this batch.
5. **Not proven:** this says the code is on the line. It does not say it works in AutoCAD. The ledger still decides that.
6. **Side effect to know:** to read the PR heads I ran `git fetch origin pull/N/head:refs/tmp/prN` for the ten PRs. That adds ten harmless local reference names (`refs/tmp/pr429` and so on) in the main checkout. No files, branches or the working tree changed.

---

## Per PR (oldest first)

1. PR #429 | ALREADY-DONE | none (body names BUG-243 only as "untouched") | 54a7f0d1 (30 Sep 2026) "Train C-1: merge PR #429 (claude/c4-des02-colours @ 9bb6e963)"; head 9bb6e963 is on the Civil line. Stacked on rel-20260929c.
2. PR #432 | ALREADY-DONE | none | 9a960212 (30 Sep 2026) "Train C-1: merge PR #432 (... @ afacecda)"; head afacecda is on the Civil line. Stacked on rel-20260929c. A later follow-up, BUG-259, is a separate open entry.
3. PR #433 | ALREADY-DONE | none of its own (body names BUG-156 as an existing rule, kept) | 0294d51b (1 Oct 2026) "Merge #433 (land use field) into rel-20261002b"; head 8272f6c9 is on the Civil line; the original change is 5cd95a07 (30 Sep 2026) "LAND-USE: one Land use per job". Stacked on claude/king5-storm (#427).
4. PR #434 | ALREADY-DONE | none | 4ce2c772 (30 Sep 2026) "Train C-1: merge PR #434 (... @ fca61838)"; head fca61838 is on the Civil line. Stacked on rel-20260929c.
5. PR #435 | ALREADY-DONE | none | 44e340f5 (30 Sep 2026) "Train C-1: merge PR #435 (... @ 239427f5)"; head 239427f5 is on the Civil line. Stacked on #434.
6. PR #437 | ALREADY-DONE | BUG-198 named in the body as a merge-order dependency, not fixed by this PR | d7e50cd8 (1 Oct 2026) merge of `origin/claude/c4-size-writer` into codex/w-pipesizes-fx; head d78a9251 is on the Civil line. Stacked on #435.
7. PR #438 | ALREADY-DONE | none | 71cd117b (30 Sep 2026) "Train C-1 final: merge PR #438 (Codex During tab window) (codex/w-during @ 019ab58f)"; head 019ab58f is on the Civil line. Stacked on #432.
8. PR #439 | ALREADY-DONE | none | 1adf46fb (1 Oct 2026) "Merge #439 (Codex Land use window) into rel-20261002b"; head a70ed17d is on the Civil line. Stacked on #433.
9. PR #440 | ALREADY-DONE (Structural line only) | none of its own; BUG-277 (grip-stretch live length) was raised from it | f6c19435 (3 Oct 2026) "Merge #440 head 57de7ee3 (S2-3 mass rounding) into #486"; head 57de7ee3 is on `rel-20261026s`, NOT on the Civil line (601 commits ahead of it, as expected for Structural); the main change is fecf76db (30 Sep 2026) "UX-BSMT-04/05, UX-FDN-04 (S4 slice 3): reo bar tool, bar marks and bar schedule; STR and BWT hidden". Base rel-20260929c-struc.
10. PR #441 | ALREADY-DONE | none | afe335c2 (1 Oct 2026) "Merge #441 (Codex pipe sizes window) into rel-20261002b"; head 9c679201 is on the Civil line. Stacked on #437.

---

## Carpark entries to annotate

1. **None to mark "fix already on the line, PR can be closed".** None of the ten PRs fixes a carpark bug of its own.
2. **Entries that only mention these PRs (leave as they are; each already says the fix is installed):**
   - **BUG-251** (follow-up to #433 Land use): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #433, #803; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
   - **BUG-252** (found by Opus review of #434): "OPEN (fix installed ... via PR #632; not yet tested ...)".
   - **BUG-253** (found by Opus review of #437): "OPEN (fix installed ... via PR #648; not yet tested ...)".
   - **BUG-255** (#437 sizing versus Edit Pipe strip): "OPEN (fix installed ... via PR #437, #470; not yet tested ...)".
   - **BUG-259** (CDDESIGN Confirm setup, #432): "OPEN (fix installed ... via PR #448; not yet tested ...)".
   - **BUG-277** (#440 grip-stretch): "OPEN (fix installed in Structural 1.0.121 via commit 060fbd6c; not yet tested ...)". The code change on the Structural line I found is 1bfeb1c6 (1 Oct 2026) "BUG-277: a reo bar's note and schedule row follow its extent line on a grip stretch (same Undo step)". I did not find a commit named 060fbd6c by that search (it exists in the repository). I did not check how the two relate.
   - **BUG-292** (#437 record order): "OPEN (fix installed ... via PR #437; not yet tested ...)".
   - **BUG-332, BUG-335, BUG-366** also mention #440 or #437 in passing.
3. **Suggested single note for the PR close-out, not a Status change:** "PR #NNN is already on the release line (merge commit above); close the PR."

---

## What I could not verify

1. **Whether any of this works in AutoCAD.** I read git history only. No build, no test, no AutoCAD, no robot.
2. **That later commits did not change the behaviour.** I proved each PR's commits are on the line. I did not diff the final code on the line against each PR to check nothing was edited or removed after the merge. The carpark shows later follow-ups (BUG-251, 252, 253, 255, 259, 277, 292), so the code has moved on.
3. **BUG-277 / commit 060fbd6c** not matched to 1bfeb1c6 (see above).
4. **PR bug numbers:** I used the PR titles and bodies (BUG-243, BUG-156, BUG-198 only). Searching all commit messages on a PR branch was too noisy (it pulled in the whole train), so I did not rely on it.
5. **GitHub state:** all ten showed OPEN on 2 Nov 2026. I did not close or comment on anything.
