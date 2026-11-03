# Already-done check 07 of 10 — old open draft PRs #405 to #416

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, Team, read-only. Civil/Manager line checked: `origin/claude/rel-20261102a` (tip 3fbb9da5, 31 Oct). Structural line checked: `origin/claude/rel-20261026s`. I ran `git fetch` first. I changed nothing except this file.

## FOR TIM

1. **Result:** all 10 PRs are ALREADY-DONE. The other verdicts have a count of 0: PARTLY-DONE, SUPERSEDED, NOT-DONE, DOCS-ONLY, CANNOT-CONFIRM.
2. **Close now:** #405, #406, #407, #409, #410, #411, #412, #413, #414 and #416. The exact last commit of each PR is already inside the release line. That is a git fact, so the same work is on the line.
3. **Nine are Civil/Manager, one is Structural.** #405 (notes and symbols) is on the Structural line, not the Civil line. Nine are on the Civil/Manager line.
4. **Surprising:** the carpark entry for BUG-224 still reads "OPEN... cause Unknown". The close-time fix (#412) has been on the line since 30 Sep. BUG-198, BUG-199, BUG-192, BUG-207, BUG-208, BUG-209 and BUG-214 are similar: the fix is on the line, but the carpark does not say so cleanly.
5. **Not proven:** none of this means a bug is fixed. Only robot plus Codex in real AutoCAD can do that. Several entries still carry a Codex FAIL from 30 Sep on the older build (BUG-198, BUG-199, BUG-192). Closing the PR does not close those bugs.
6. **Stacked PRs:** #413 sat on #403 and #414 sat on #393. Both of those lower PRs are also on the line (b1f528b0 and f498b772). Closing them loses nothing.

---

## PER-PR VERDICTS

Method on all ten: `gh pr view` for title, base, head and files. `git merge-base --is-ancestor <PR head> origin/claude/rel-20261102a` (or the Structural line for #405). Then I found the first merge commit that brought the head onto the line. The carpark was read from `C:\CE_PLAN\BUG_CARPARK.md`.

1. PR #405 | ALREADY-DONE | no BUG number (UX-NOTES-02..04, 07..11 and UX-SYM-02 workflow items) | The head 4bcc3da5 is on the Structural line `rel-20261026s`. It came in at 63bccfe9 (3 Oct 2026, "Merge #405 claude/s3-notes (4bcc3da5) into train S-8"). It is NOT on the Civil line, which is correct because it is Structural-only. The base was `rel-20261005t` and the head branch was `claude/s3-notes`.
2. PR #406 | ALREADY-DONE | no BUG number (L3-LEVELS engine, switched off) | The head ff2f3b1a is on the line. It came in at abb6470d (30 Sep 2026, "Train C-1: merge PR #406 (claude/l3-levels @ ff2f3b1a)").
3. PR #407 | ALREADY-DONE | BUG-198, BUG-199 | The head 9d308d44 is on the line. It came in at 7f40cd54 (30 Sep 2026, "Train C-1 final: merge PR #407 new head (claude/bug198-again @ 9d308d44)"). The change itself is 67ddfde8 (30 Sep, "Fix BUG-198 again... and BUG-199 open-ends level preview").
4. PR #409 | ALREADY-DONE | BUG-207 | The head 3868e1c9 is on the line. It came in at 71c34a7d (30 Sep 2026, "Train C-1: merge PR #409 (claude/bug207-sched @ 3868e1c9)"). The change is 0ffa1231 (30 Sep, "BUG-207: Edit Pit refreshes the drawn Pit Schedule straight away").
5. PR #410 | ALREADY-DONE | BUG-208 | The head 82abe627 is on the line. It came in at b790f15b (30 Sep 2026, "Train C-1: merge PR #410 (claude/bug208-grip @ 82abe627)"). The change started at bca7e15b ("BUG-208: dragging a pipe end off its pit no longer refuses the linked records").
6. PR #411 | ALREADY-DONE | BUG-209 | The head 17b88211 is on the line. It came in at 853e620d (30 Sep 2026, "Train C-1: merge PR #411 (claude/bug209-area @ 17b88211)"). The change is 17b88211 itself ("Fix BUG-209: CDCATCHMENT area converted from drawing units to m2 via INSUNITS").
7. PR #412 | ALREADY-DONE | BUG-224 | The head c3e3cc48 is on the line. It came in at ac17d308 (30 Sep 2026, "Train C-1: merge PR #412 (claude/bug224-close @ c3e3cc48)"). The change is c3e3cc48 ("Fix BUG-224: Civil no longer writes into a drawing that is closing"). A later test-only guard also went in: 50d95026 and merge 83e143b6 (7 Oct, PR #753).
8. PR #413 | ALREADY-DONE | none by number (C4 slice 2, storm frequency from the council profile) | The head 87744fa9 is on the line. It came in at b75482f7 (30 Sep 2026, "Train C-1: merge PR #413 (claude/c4-calc2 @ 87744fa9)"). It was stacked on #403 (b1f528b0), which is also on the line.
9. PR #414 | ALREADY-DONE | BUG-192 (v2); sits on #393 for BUG-203 | The head 1527039d is on the line. It came in at 7590508e (1 Oct 2026, "Train C-2 final: merge PR #414 BUG-192 v2 (claude/bug192-light @ 1527039d)"). It was stacked on #393, whose head f498b772 (BUG-203) is also on the line. The base branch was `claude/bug203-quiet`. It replaced the earlier #408.
10. PR #416 | ALREADY-DONE | BUG-214, BUG-216 | The head ae62eb2d is on the line. It came in at a01b2c91 (30 Sep 2026, "Train C-1: merge PR #416 (claude/bug214-216 @ ae62eb2d)"). The changes are 2dd5d47b (BUG-214) and f85c1f9e (BUG-216).

---

## CARPARK ENTRIES TO ANNOTATE

The proposed new Status wording for each is: "fix already on the line, PR can be closed". None of these may be called FIXED until robot plus Codex pass in real AutoCAD (RULES.md 13.3).

1. **BUG-198 (PR #407).** There is no `## BUG-198` heading; it sits in the X1 note at carpark line 6311. Last status in short: "OPEN... Codex 30 Sep pass18: STILL FAILING on installed Civil 3.0.15" (size-only Edit Pipe Save changed 1 IN 100 to 1 IN 99). The #407 head, a later fix for exactly that route, is on the line.
2. **BUG-199 (PR #407).** Also a note, at carpark line 6312. Last status in short: "OPEN... Codex 30 Sep pass18: PARTLY PASSED... STILL FAILING for a route with two open ends". #407 includes the open-ends level preview fix.
3. **BUG-207 (PR #409).** Last status: "FIXED — 15 Oct 2026, Codex-accepted for Structural 1.0.116 / AutoCAD 2027, original model-space one-Undo defect only." This is already ledger-accepted by name, so there is nothing to downgrade. Add one line: "Civil PR #409 head 3868e1c9 is on the line, PR can be closed".
4. **BUG-208 (PR #410).** Last status: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #410; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
5. **BUG-209 (PR #411).** Last status: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #411; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
6. **BUG-224 (PR #412).** Last status: "OPEN (30 Sep 2026, found by Codex sweep C1; cause Unknown; not reproduced; CE involvement Unknown)". This is stale. The diagnosis and fix c3e3cc48 are on the line, and 50d95026 added a guard over every Civil close handler.
7. **BUG-192 (PR #414).** Last status: "OPEN (tracked under BUG-256, BUG-558 and BUG-861; reconciled 23 Oct 2026)". Note the carpark line 5280 still says #414 "is NOT in the install", which is old. Annotate the entry for the v2 light-read fix.
8. **BUG-203 (stack parent of #414, not one of the ten).** Last status: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #393; not yet tested by robot or Codex; reconciled 23 Oct 2026)". I did not check #393's own state, only that its head is on the line.
9. **BUG-214 (PR #416).** Last status: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #416; not yet tested by robot or Codex; reconciled 23 Oct 2026)".
10. **BUG-216 (PR #416).** Last status: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #416; not yet tested by robot or Codex; reconciled 23 Oct 2026)".

PRs #405, #406 and #413 name no carpark BUG number, so there is no entry to annotate. (The carpark mentions #413 only in two unrelated follow-up bugs at lines 5763 and 5767.)

---

## WHAT I COULD NOT VERIFY

1. **Behaviour in AutoCAD.** I read git only. I built nothing, ran no test, opened no AutoCAD and did not run the robot. "Already done" means the same commits are on the line, not that the behaviour works on a drawing.
2. **Whether the line's code was later changed again.** I proved the PR head is an ancestor of the line. I did not diff later commits to see if the same files were rewritten after the merge.
3. **Carpark state for BUG-198 and BUG-199.** They have no own `## BUG-` heading in the carpark, so the Status lines above come from the X1 note. A fuller search for a later entry under another ID was not done.
4. **#393 and #403.** I confirmed their heads are on the line, since #414 and #413 were stacked on them. I did not review those PRs themselves.
5. **PR state on GitHub.** `gh pr view` showed all ten as OPEN at the time I ran it.
