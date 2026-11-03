# Already-done check 06 of 10 — PRs #394 to #404 (Mon 2 Nov 2026, Melbourne)

Read-only check by Claude Sonnet (Team). Nothing built, tested, installed or run in AutoCAD. Compared against Civil/Manager line `origin/claude/rel-20261102a` (tip 3fbb9da5, 31 Oct) and Structural line `origin/claude/rel-20261026s` (tip 204dfad2).

## FOR TIM

1. **Counts:** ALREADY-DONE 8, DOCS-ONLY 1, NOT-DONE 0, SUPERSEDED 0, PARTLY-DONE 0, CANNOT-CONFIRM 1.
2. **Can be closed now (the change is already on the line):** #394, #396, #398, #400, #401, #403, #404, #402 (Structural line), and #395 (documents only, also on the line). That is nine of ten.
3. **Not closed yet, one:** #397. Its own head is a "revert" step, so GitHub does not see it as merged. Its real content (the job tag setting and unit tag rules) is on the Structural line under other commit ids, and #402 says "merge this one, not #397". I am fairly sure it can be closed too, but I list it as cannot-confirm because I did not diff every line.
4. **Surprise 1:** eight of the ten PRs show as "open draft" on GitHub but were merged into the release train on 30 Sep 2026 (the "Train C-1" and "S-8" merges). Nobody closed the PRs afterwards.
5. **Surprise 2:** #400 pinned the rule "OF and FO share one symbol". Your own hand check H12 (29 Oct) says FO should read FO. That is open as a carpark entry (the FO/OF symbol one, around line 17383). So #400 is done, but the design it pinned is being questioned by you.
6. **Nothing here is FIXED.** Only BUG-205 is named by any of these PRs, and it stays OPEN until robot plus Codex pass it in AutoCAD.

---

## One line per PR

1. PR #394 | ALREADY-DONE | none named | merged into the train as 55e3a099 "Train C-1: merge PR #394", 30 Sep 2026; head fddc3931 is an ancestor of the Civil line and CeOneGlanceStatus.cs is still present. (Base claude/rel-20260929c.)
2. PR #395 | DOCS-ONLY | none named | card and log only; merged as 3cec59d7 "Train C-1: merge PR #395", 30 Sep 2026; head 0ba2db35 is an ancestor of the line and the card file is present. (Base claude/rel-20260929c.)
3. PR #396 | ALREADY-DONE | none named | merged as 7ffdbe7d "Train C-1: merge PR #396 (claude/l1-learn @ 0f1a0c81)", 30 Sep 2026; head is an ancestor and LearningService.cs is present.
4. PR #397 | CANNOT-CONFIRM | none named | head 8aa589a5 is a revert commit and is not an ancestor of either line, but its content commits (eed9c3a0, ef87a23a, 8d0797e8, 29 Sep) are on the Structural line and the unit files exist there; I did not line-diff, so I am not calling it done. It is the base slice that #402 contains. (Base claude/rel-20260929c-struc.)
5. PR #398 | ALREADY-DONE | none named | merged as c2b2d13a "Train C-1 final: merge PR #398 new head (claude/c1-undo @ 6a90fad8)", 30 Sep 2026; head is an ancestor and CdCommandLineSpecRules.cs is present.
6. PR #400 | ALREADY-DONE | none named | tests and card only, no product change; merged as 45fce0e5 "Train C-1: merge PR #400", 30 Sep 2026; SourceTypeRulingsTests.cs is present. See surprise 2 above.
7. PR #401 | ALREADY-DONE | none named | merged as 7ccf1e46 "Train C-1 final: merge PR #401 new head (claude/pipe-autojoin @ 48b5de0c)", 30 Sep 2026; head is an ancestor and PipeEndJoinRules.cs is present.
8. PR #402 | ALREADY-DONE | none named | merged as 90ee2a2c "Merge #402 claude/s2-unit-copy (4ae2ac13) into train S-8"; head 4ae2ac13 is an ancestor of the Structural line (not of the Civil line, which is the wrong line for it) and UnitCopyService.cs, UnitCopyCommands.cs are present. (Base claude/rel-20261005t; stacked on #397.)
9. PR #403 | ALREADY-DONE | none named | merged as 1ab3efa8 "Train C-1: merge PR #403 (claude/c4-calc @ b1f528b0)", 30 Sep 2026; head is an ancestor and CriteriaBlockRows.cs is present.
10. PR #404 | ALREADY-DONE | BUG-205 (also touches BUG-223) | merged as 5218134b "Train C-1: merge PR #404 (claude/bug205-uphill @ 5b45f760)", 30 Sep 2026; fix commit 5b45f760 "Fix BUG-205: Use level direction no longer makes an uphill pipe between two open ends" is an ancestor of the line.

## Carpark entries to annotate (Status would read "fix already on the line, PR can be closed")

1. **BUG-205** (PR #404). Current last Status line: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #404; not yet tested by robot or Codex; reconciled 23 Oct 2026)". Stays OPEN. Add only "PR #404 is merged on the line (5218134b), PR can be closed".
2. **BUG-223** (related, only half covered by #404). Current last Status line: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #404, #422; not yet tested by robot or Codex; reconciled 23 Oct 2026)". #404 only fixed the draw-first path; the CDEDIT half is b99851bd (#422). Annotate only that #404 can be closed; BUG-223 stays OPEN.
3. No carpark entry names #394, #395, #396, #397, #398, #400, #401, #402 or #403 (I searched for "PR #n" and "#n"). Nothing to annotate for them.

## What I could not verify

1. **#397:** did not line-diff its slice-one files against the Structural line, and its head is not an ancestor, so I left it as cannot-confirm.
2. **Files still present is not the same as behaviour unchanged.** I checked that one distinctive file per PR still exists on the line and that the PR head is an ancestor. I did not read later commits to see whether another change reworked them. I did see two revert-style commits on the line (da6d24de and 09a0e66b, both about the plan grade-check marker #805), which do not touch these PRs.
3. **GitHub state:** I read PR titles, bases, heads and files with gh. I did not check whether #394 to #404 have review comments or later pushes after the 30 Sep heads (the heads I used are the ones GitHub reports today).
4. **Nothing was tested in AutoCAD.** Being on the line says only that the code was merged. It says nothing about whether it works on a drawing.
