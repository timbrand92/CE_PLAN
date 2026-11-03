# ALREADY-DONE CHECK 04 of 10 (Mon 2 Nov 2026, Melbourne)

Read-only check by Sonnet. Nothing was built, tested or run in AutoCAD. Line checked: origin/claude/rel-20261102a (tip 3fbb9da5, last commit 31 Oct) after a git fetch. Method: for each PR I read the PR page (title, base, head, files), then tested whether the PR's last commit is already part of the release line (git merge-base --is-ancestor), then read the carpark.

## FOR TIM

1. **Counts:** 9 ALREADY-DONE (#370 to #377, #379), 1 NOT-DONE (#369). No PART-DONE, SUPERSEDED, DOCS-ONLY or CANNOT-CONFIRM.
2. **Can be closed now:** #370, #371, #372, #373, #374, #375, #376, #377, #379. Each one's final commit is already inside the release line, word for word, so merging would add nothing.
3. **Must stay open (or be redone):** #369 (mirrored text). It was HELD on 29 Sep because the builder never found what mirrors the imported labels. Nothing like it is on the line.
4. **Surprising:** the nine "open" PRs were landed on the line on 29 Sep without being merged, so GitHub still shows them open. That is why they look unfinished.
5. **Carpark:** only #370 (BUG-079) and #369 (BUG-069) name a carpark bug. The other PRs are plan items (CD-BRANCH-01, UX-EDIT-01/02/04, UX-SURV-03, UX-CMD-02) with no carpark entry to mark.
6. **Not proven:** this shows the code is on the line. None of it is proven in real AutoCAD by this check. BUG-079 still needs the Codex visual check of all 8 drag directions.

## PER PR

1. PR #369 | NOT-DONE | BUG-069 | Head fb9a6ae8 is NOT on the line; carpark says "PR #369 HELD, not banked" (29 Sep), and no TextReadabilityMath file or mirror-guard commit exists on the line.
2. PR #370 | ALREADY-DONE | BUG-079 | Head c940e457 is on the line: "Land BUG-079 FALL symbol rounds 1-8: FALL SYMBOL 2, arrow follows drag, flip for readability, cardinal snap" (29 Sep 2026). Stacked on #367.
3. PR #371 | ALREADY-DONE | none named (CDSLAB falls follow CDFALL; a loose end of BUG-079) | Head 899a6d85 is on the line: "CDSLAB falls follow CDFALL: one shared fall placement route..." (29 Sep 2026). Stacked on #370.
4. PR #372 | ALREADY-DONE | none (plan item CD-BRANCH-01 part 1) | Head 27f83f8d is on the line; part 1 file commit 71d20198 "CD-BRANCH-01 part 1: pipe ends anywhere, branches onto a main, pipe ends to the inside pit wall" (29 Sep 2026).
5. PR #373 | ALREADY-DONE | none (CD-BRANCH-01 part 2) | Head 533f13b6 is on the line; file commit 8e02ab1d "CD-BRANCH-01 part 2: show branch junctions in the Pit Schedule, long section marker and Inspector" (29 Sep 2026). Stacked on #372.
6. PR #374 | ALREADY-DONE | none (UX-EDIT-01) | Head d4f52fca is on the line: "UX-EDIT-01: erasing a connected pit says how many pipes now have a Not connected yet end" (29 Sep 2026).
7. PR #375 | ALREADY-DONE | none (UX-EDIT-04) | Head 9a32d7f4 is on the line; file commit 6f2ad64e "UX-EDIT-04: EXPLODE on a CE pit or pipe says what left the schedule" (29 Sep 2026). Stacked on #374.
8. PR #376 | ALREADY-DONE | none (UX-SURV-03) | Head 5c67c393 is on the line: "UX-SURV-03: CDSL shows the existing survey level, you type the proposed level" (29 Sep 2026).
9. PR #377 | ALREADY-DONE | none (UX-CMD-02) | Head 2b1dd39e is on the line: "UX-CMD-02: pipe size and grade follow the cursor while CD picks the route" (29 Sep 2026).
10. PR #379 | ALREADY-DONE | none (UX-EDIT-02) | Head 70f9bf98 is on the line; file commit 3adea8f7 "UX-EDIT-02: copied pits and pipes flagged Check levels until confirmed in Edit" (29 Sep 2026).

## CARPARK ENTRIES TO ANNOTATE

1. **BUG-079** (from #370, and #371 for the slab half): the Status line would read "fix already on the line, PR can be closed". Current last Status line, in short: "FIXED IN CODE — latest is ROUND 8 (2026-07-07): near-cardinal drags now SNAP to the exact cardinal... NOT deployed; awaiting Tim's AutoCAD confirm." The 29 Sep note above it says it "needs a Codex visual check of all 8 drag directions and a slab with falls". It must NOT be called FIXED.
2. **BUG-069 stays as it is.** Last Status: "OPEN — filed from screenshots; investigate after round-4 retest." Do not annotate it as done; add only that PR #369 is still open and held.
3. No other carpark entry names these PRs. A grep of BUG_CARPARK.md for the other PR numbers and plan IDs found no entry to annotate.

## WHAT I COULD NOT VERIFY

1. **No real AutoCAD behaviour was checked.** The proof is that the PR's commit is part of the release line's history, not that the fix works on a drawing.
2. **#369:** I looked for the same change under another name (git log for "mirror" and "readab", a search for the TextReadabilityMath helper, and the mirror flags in the text code). Only older Drainage and import mirror-clearing lines turned up, which BUG-069 says do not cover the imported labels. I could not find a different fix. Please treat "NOT-DONE" as "not found on the line".
3. **Carpark gap:** the UX and CD-BRANCH items have no carpark entry. I did not look through the other plan files for their status lines.
4. **Line tip:** git log showed the tip as 31 Oct, a day after the commit I expected. If CE 05 has pushed since my fetch, the result is unchanged because ancestry only grows.
5. **GitHub tooling:** gh was not on the default shell PATH. I added its install folder to PATH to run it. I changed nothing on GitHub.
