# Already-done check 05 of 10 (Mon 2 Nov 2026, Melbourne)

Read-only check by Sonnet (Team) for CE 05 / CE 00. Line checked: origin/claude/rel-20261102a (newest commit 3fbb9da5, 31 Oct 2026, Civil 3.0.88 / Manager 1.1.88). Fetched first. Nothing built, nothing tested, AutoCAD not opened, no repo file changed.

## FOR TIM

1. **Answer:** all ten PRs (#380, #381, #383, #384, #387, #388, #389, #390, #391, #393) are ALREADY-DONE. Their exact final commits are already inside the release line, so there is nothing left to merge.
2. **Counts:** ALREADY-DONE 10. PARTLY-DONE 0. SUPERSEDED 0. NOT-DONE 0. DOCS-ONLY 0. CANNOT-CONFIRM 0.
3. **Can be closed now:** all ten. Closing them loses no work.
4. **Surprise:** it was not a similar-title match. Each PR's last commit is a direct ancestor of the line (git says so), and the main new file from each PR is on the line.
5. **What this does NOT mean:** "already on the line" is not "fixed". None of these bugs becomes FIXED from this check. Only the ledger can do that (robot plus Codex in real AutoCAD, RULES.md 13.3).
6. **One catch on #384:** it also carried a BUG-192 (Redo) evidence-logging change only. BUG-192 itself is still open and is tracked elsewhere (PR #414 and the BUG-256 / 558 / 861 entries).

---

## Per PR

How I decided: for each PR I read the PR page, then asked git whether the PR's last commit is part of the release line (it is, for all ten), then confirmed the main new file exists on the line and found the merge commit. The 30 Sep "Train C-1" merges name the PR number directly.

1. PR #380 | ALREADY-DONE | BUG-194 | Last commit 381405f1 (29 Sep, "Fix BUG-194: CE Pipe/Source contextual tabs follow CE ownership, not object type") is on the line; ContextualTabOwnershipRule.cs present; version commit 4f959f0f (Civil 3.0.14) names it. Base was rel-20260929a.
2. PR #381 | ALREADY-DONE | BUG-189 (speed side only; PERF-DISCIPLINE-01) | Last commit 90afeb96 is on the line; the same change is also there as 1c8cfc52 (29 Sep, "PERF-DISCIPLINE-01: Civil stays quiet in drawings with no Civil content (BUG-189 speed)"); CivilQuietMode.cs present. Base was rel-20260929a.
3. PR #383 | ALREADY-DONE | none (UX-RESUME-01, not a carpark bug) | Commit 31bf7515 (29 Sep, "UX-RESUME-01: next pipe starts from the last size and type used in that job") is on the line, arrived through the x1-cd-levels-fixes merge be2971ab; LastPipeChoiceRules.cs present. Base was rel-20260929b.
4. PR #384 | ALREADY-DONE | BUG-198, BUG-199, BUG-193, BUG-192 (evidence only) | Commit 89ad7fc2 (29 Sep, "Fix BUG-198/199/193 from Codex X1 ... BUG-192 post-undo write evidence") is on the line (merge be2971ab; Civil 3.0.15 version commit a6e0cc87). Later follow-ups also on the line: 67ddfde8 (BUG-198 again, BUG-199 preview), 1ecac975 (BUG-193 resizes the real pit). Base was rel-20260929b.
5. PR #387 | ALREADY-DONE | BUG-200, BUG-201 | Last commit c39be4e6 on the line; merged as 92def2c4 (30 Sep, "Train C-1: merge PR #387 (claude/bug200-201 @ c39be4e6)"). Base was rel-20260929c.
6. PR #388 | ALREADY-DONE | BUG-197 | Last commit 7c14d713 on the line; merged as 2fee86a1 (30 Sep, "Train C-1: merge PR #388"). A later fix "Train fix B" 093167ca (locked main labels) also names it. Base was rel-20260929c.
7. PR #389 | ALREADY-DONE | none (A6 imported-level review, not a carpark bug number) | Last commit 5a7aeea6 on the line; merged as 057a5f6a (30 Sep, "Train C-1 final: merge PR #389 new head"); ImportedLevelReviewService.cs present. Base was rel-20260929c.
8. PR #390 | ALREADY-DONE | none (UX-MSG-01..03, the hidden CE bell) | Last commit 5cff544c on the line; merged as 28a002dc (30 Sep, "Train C-1: merge PR #390"); CeMessageCentre.cs present. Base was rel-20260929c.
9. PR #391 | ALREADY-DONE | BUG-160 (part 2) | Last commit 8c6db2bf on the line; merged as 5649277a (30 Sep, "Train C-1: merge PR #391"); original build commit 91a08ce0. Base was rel-20260929c.
10. PR #393 | ALREADY-DONE | BUG-203 | Last commit f498b772 on the line; merged as d2910389 (30 Sep, "Train C-1: merge PR #393"). Base was rel-20260929c.

None is stacked on another PR. #387, #388, #389, #390, #391, #393 shared one base branch (rel-20260929c); #383 and #384 shared rel-20260929b; #380 and #381 shared rel-20260929a. All three base branches are themselves part of the line.

---

## Carpark entries to annotate

Wording to add to each Status line: "fix already on the line, PR can be closed". Current last Status line quoted in short. None of these may be called FIXED by this check.

1. **BUG-160** (PR #391): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #354, #391; not yet tested by robot or Codex; reconciled 23 Oct 2026)". Add: PR #391 can be closed.
2. **BUG-194** (PR #380): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #380; not yet tested by robot or Codex; reconciled 23 Oct 2026)". Add: PR #380 can be closed.
3. **BUG-203** (PR #393): "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #393; not yet tested by robot or Codex; reconciled 23 Oct 2026)". Add: PR #393 can be closed.
4. **BUG-197** (PR #388): sits in the group entry "BUG-195 .. BUG-201". Item text ends: "built, draft PR #388 ... Not tested in AutoCAD." The group Status line reads "OPEN (tidy 29 Oct 2026: ... group entry for BUG-195 to 201 ...)". Add: PR #388 can be closed.
5. **BUG-198** (PR #384): same group entry. Item text: "fix already on the live line - commit 89ad7fc2 ... Codex 30 Sep pass18: STILL FAILING on installed Civil 3.0.15". Add: PR #384 can be closed (the 30 Sep failure was a different route, answered by 67ddfde8).
6. **BUG-199** (PR #384): same group entry. Item text: "Codex 30 Sep pass18: PARTLY PASSED ... STILL FAILING for a route with two open ends". Add: PR #384 can be closed.
7. **BUG-200** (PR #387): same group entry. Item text: "built, draft PR #387 ... Codex 30 Sep pass18: not specifically tested". Add: PR #387 can be closed.
8. **BUG-201** (PR #387): same group entry. Item text: "STILL PRESENT on installed Civil 3.0.15 ... The fix (PR #387) is not installed". Add: fix is on the line since 30 Sep (92def2c4), PR #387 can be closed.
9. **BUG-193** (PR #384): already "FIXED — 2026-09-30 (Codex-accepted, pass 18, ordinary pit only; P6 900 x 900 case not tested; ...)". No wording change needed; the PR can simply be closed.
10. **BUG-189** (PR #381, speed side): already "FIXED — 2026-09-30 (Tim's word 29 Sep plus Codex pass 18 timing; ...)". No change needed.
11. **BUG-192** (PR #384, evidence part only): "OPEN (tracked under BUG-256, BUG-558 and BUG-861; reconciled 23 Oct 2026)". Do NOT write "fix already on the line"; #384 only added evidence logging. Leave as it is.

PRs with no carpark bug to annotate: #383, #389, #390 (they belong to UX-RESUME-01, A6 and UX-MSG, not a BUG number).

---

## What I could not verify

1. **Behaviour in AutoCAD:** nothing was run. "On the line" only proves the code is there.
2. **Later removal:** I confirmed each PR's main file is still on the line and the PR commit is an ancestor. I did not diff every changed line against today's line, so a later rewrite of part of a PR is not ruled out (the BUG-198 follow-up shows that happens).
3. **PR #381 and #383 and #384** reached the line through merge branches rather than a merge commit with the PR number; ancestry is proven, but the "Train" log does not name them.
4. **Carpark BUG-197..201** have no separate entries, only the group entry, so the "Status line" quoted is the item text plus the group status.
5. **Tools:** `gh` was not on the shell PATH; I ran it by its full path (C:\Program Files\GitHub CLI\gh.exe). Draft status of each PR was read from the PR page, all open.
