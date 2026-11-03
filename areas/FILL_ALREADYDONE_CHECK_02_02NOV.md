# Already-done check 02: old draft PRs #230, #349 to #358 (Mon 2 Nov 2026, Melbourne)

Checked by Sonnet (Team), read-only. Civil/Manager line: origin/claude/rel-20261102a (tip 3fbb9da5 after fetch). Structural line: origin/claude/rel-20261026s.

## FOR TIM

1. **Counts:** 8 ALREADY-DONE (#349, #350, #351, #354, #355, #356, #357, #358), 2 SUPERSEDED (#230, #352), 0 NOT-DONE, 0 PARTLY-DONE, 0 DOCS-ONLY, 0 CANNOT-CONFIRM.
2. **Can be closed now:** all ten. Eight are already on the release line, so merging would add nothing. Two were replaced by a different design.
3. **Surprise:** #352 (BUG-160) would do the wrong thing today. It keeps your typed level silently. Your 23 Sep ruling says nothing typed is silently kept or overwritten. The line instead asks "Keep your level or use automatic" (approved 29 Sep). Do not merge it.
4. **BUG-160 is still OPEN** in the carpark, and closing #352 does not change that. Only the old PR is dead. The fix on the line has not passed robot plus Codex yet.
5. **BUG-189 and BUG-190:** the carpark already reads FIXED for both (Codex-accepted). Closing their PRs changes nothing there.
6. **Not proven:** this was a read of the history only. I built nothing, ran no tests and opened no AutoCAD.

## One line per PR

1. PR #230 | SUPERSEDED | none (UX-STD-03 is a ruling, not a BUG number) | Your 25 Sep "Never, you save" ruling was built differently: eab4b3ab (2026-09-25, "UX-STD-03: Civil never saves the drawing") removed the auto-save, and the guard `Civil_NeverSavesTheDrawing_AfterItsCommands` replaced #230's guard; #230's own `NoSideEffectDrawingSaveTests` file is not on the line, and its head 2ae8864f is not an ancestor. It was an audit and guard PR with no production change, based on master.
2. PR #349 | ALREADY-DONE | BUG-189 | Head c4555ab7 is an ancestor of the line ("BUG-189: add always-on perf timing for CE hot paths (measurement only)"). Based on master; #350 sits on it.
3. PR #350 | ALREADY-DONE | BUG-189 | Head 4b3922e8 is an ancestor, with 09e15a4a (2026-09-28, "Fix BUG-189: stop re-reading the whole drawing after every CE edit") and release e03d383d (Civil 3.0.11). It sits on #349.
4. PR #351 | ALREADY-DONE (Structural line) | BUG-189 | Head a4ad7ecc is an ancestor of origin/claude/rel-20261026s; f8e8193c (2026-09-28, "Fix BUG-189 (Structural part): stop periodic full drawing re-scans") and 95190bae (Structural 1.0.82). Based on claude/struc-d1-prep. It is not on the Civil/Manager line, which is right because it is Structural-only.
5. PR #352 | SUPERSEDED | BUG-160 | Head 425702d3 is not an ancestor. Replaced by #354 (flag tracks real edits) plus 91a08ce0 (2026-09-29, "typed bottom level on a grade-held pipe asks Keep or Automatic at drag end") and 83aab821 (2026-10-02, split pipe), following Tim's 29 Sep approval of the pick window. #352's silent-keep rule was parked by Opus review (28 Sep) and by the 23 Sep ruling.
6. PR #354 | ALREADY-DONE | BUG-160 (part 1 only) | Head 576db45e is an ancestor; b33e0305 "Fix BUG-160: Pipe Edit invert typed flag now tracks real user edits". Part 2 is also on the line (91a08ce0), but the bug is not accepted yet.
7. PR #355 | ALREADY-DONE | none (CDRENUMBER-OUTLET-01 has no carpark entry; the commit labels it BUG-160 loosely) | Head 9276c156 is an ancestor ("CDRENUMBER-OUTLET-01: relabel and make outlet keywords crash-safe"), with 538ace30 (2026-09-28, "CDRENUMBER asks for the main outlet instead of stopping").
8. PR #356 | ALREADY-DONE | BUG-189 | Head f033e3d3 is an ancestor ("Fix BUG-189 round 2 review blockers"), with 62401133 (schedule-cell refresh no longer scans every entity). It sits on #350.
9. PR #357 | ALREADY-DONE | BUG-190 | Head 5c845164 is an ancestor ("Fix BUG-190 review blockers"), with 284e8f19 "flush pending project data before Ctrl+S writes the file" and release a152c7c9 (Civil 3.0.12). Its diff carries the round 2 files, so it sits on #356. Codex pass 17 Q4 passed Ctrl+S and close/reopen on 29 Sep.
10. PR #358 | ALREADY-DONE | BUG-189 | Head 517a847c is an ancestor ("BUG-189 SPEED ROUND 3 fixups"), with bc07a553 and a152c7c9 (Civil 3.0.12). Based on claude/rel-20260928-speed, so it sits on the earlier BUG-189 rounds. Rounds 4 (82862286, 33bcf8c7) and 1c8cfc52 are also on the line.

## Carpark entries to annotate

Add the note "fix already on the line, PR can be closed" to these Status lines. Annotate only, and do not change the verdict word.

1. **BUG-189** (PRs #349, #350, #351, #356, #358). Current last Status line: "FIXED — 2026-09-30 (Tim's word 29 Sep plus Codex pass 18 timing; reconciled 23 Oct 2026)". The PRs are redundant. The status stays as the ledger set it.
2. **BUG-190** (PR #357). Current last Status line: "FIXED — 2026-09-29 (Codex-accepted, pass 17 Q4; reconciled 23 Oct 2026)". Same note.
3. **BUG-160** (PRs #352 superseded, #354 already done). Current last Status line: "OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #354, #391; not yet tested by robot or Codex; reconciled 23 Oct 2026)". Add "PR #352 superseded and PR #354 already on the line, both can be closed". Status stays OPEN, because the ledger has not accepted it by name.
4. **UX-STD-03 and CDRENUMBER-OUTLET-01** have no BUG entry in the carpark (checked by search), so nothing to annotate there.

## What I could not verify

1. **Nothing was built, tested or opened in AutoCAD.** "Already done" means the same commits or an equivalent are on the line. It does not mean accepted.
2. **Dates:** I confirmed dates only for eab4b3ab, 09e15a4a, 538ace30, f8e8193c, 91a08ce0 and 83aab821. The others are named by sha and subject.
3. **#230:** I found only the Civil replacement guard. Whether any Manager or Structural no-save guard exists elsewhere on the line, I did not confirm. #230's own Manager test is not on the line.
4. **#352:** I did not read the current body of `ApplyGradeLockToInverts` line by line. The verdict rests on the commit history, the carpark text and the 23 Sep ruling.
5. **PR state on GitHub:** `gh pr view` was used for the base, head, files and description only. I did not check review comments or whether anyone has already closed these PRs.
