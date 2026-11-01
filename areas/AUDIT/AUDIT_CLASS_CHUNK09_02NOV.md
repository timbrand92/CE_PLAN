# Carpark audit, chunk 9 of 21: entries 481 to 540

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, Team, read-only. Only this file was written. Nothing was built, tested, installed or opened in AutoCAD.

---

## FOR TIM

1. **Counts (60 entries):** ALREADY-FIXED 16, INSTALLED-WAITING-PROOF 29, UNCLEAR 7, NEEDS-TIM 6, HAS-DRAFT 1, CLOSED-OR-WONT-FIX 1, FIXABLE-NOW 0, DUPLICATE 0.
2. **No entry in this chunk is FIXABLE-NOW.** Everything open is either already built and waiting for an AutoCAD check, or needs your ruling or a repro first.
3. **Five most pilot-critical open items (none is a fix to build):** BUG-163 (CDWT crash, not reproduced, one AutoCAD experiment named), BUG-073 (New Pipe preview blank on 29 Oct), BUG-158 (council computations sheet, Codex was blocked, needs a drawing with a council set), BUG-160 (typed bottom level on a dragged pipe end), BUG-053 (crash on a roof drawing with xrefs).
4. **Your rulings needed (six):** BUG-061 (close as gone?), BUG-063 (how existing council pipes are drawn), BUG-068 (anchor to the architectural xref: which one and how), BUG-080 (AS/NZS pipe velocity limits), BUG-056 (how a run meets an existing council line), BUG-001 (what Copy Rotate and Move Rotate should now do).
5. **Not verified:** pull requests could not be searched (the `gh` tool is not on this machine's path), so PR numbers come only from the carpark text and from merge commits found in git.

---

## How to read this

1. **Pilot-critical** means: if the entry is still open, a colleague in the pilot could hit it. A fixed entry is marked "no".
2. **Line used:** `origin/claude/rel-20261102a` (Civil and Manager, last commit 31 Oct 03:46) and `origin/claude/rel-20261026s` (Structural).
3. **INSTALLED-WAITING-PROOF** means the fix is in code on the live line and the carpark says it is installed or banked, but no robot and Codex pass (or Tim) has accepted it.
4. **Order** follows the file's heading order, not the bug number.

---

## The list

481. BUG-176 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #346 merged (7c0538f2) and the pass-18 wording fix #656 merged; Codex pass 18 was blocked by a different refusal, so the inlet landing is unproven.
482. BUG-175 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 49ea9be0 (PR #179) makes Edit Pipe decide the pipe type once; carpark says installed in 3.0.70, never tested by robot or Codex.
483. BUG-174 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 4e4d9cd4 (PR #177) removes the [CE] tag from questions; installed 3.0.70, no robot or Codex result.
484. BUG-173 | HAS-DRAFT | pilot-critical no | Pit one-page PR #184 (ready for review) and pipe one-page PR #180; 29 Oct triage says the New Pit window still has large empty areas.
485. BUG-170 | ALREADY-FIXED | pilot-critical no | What's New fix 4465e22d is on the live line, 26 of 26 tests passed on 28 Sep; never installed and Tim has not seen it, so it still needs his look.
486. BUG-169 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED, Codex-accepted pass 18; RC restore fbe20071 and layer fix 8d382ec0 are on the Structural line; the RC Undo part is BUG-215.
487. BUG-168 | ALREADY-FIXED | pilot-critical no | Tim confirmed CDGRIPDIAG Off in AutoCAD on 24 Sep and keyword fix 05000fb4 (PR #155) is on the live line; the 2024 check is still open.
488. BUG-167 | ALREADY-FIXED | pilot-critical no | Commit d6bea373 (PR #364) swaps the hanging zip step; carpark status still says OPEN until a real installer build finishes, which I did not see.
489. BUG-166 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #107 (a2f56f43) plus e4d690a5 are on the line and installed in 3.0.70; it cannot be proven without AutoCAD and no Codex or robot pass is recorded.
490. BUG-165 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 74285871 (PR #92) stops old date-style build numbers outranking Version 3; the check is a unit test, nothing for Tim to see in AutoCAD.
491. BUG-164 | ALREADY-FIXED | pilot-critical no | PR #90 (aeb03763) stops the close-down crash, Codex pass 17 B5 accepted it on 29 Sep; a different crash on closing one drawing is BUG-224.
492. BUG-163 | UNCLEAR | pilot-critical yes | Tim could not reproduce it on 24 Sep; the carpark names one live AutoCAD experiment (point the Standard Details folder at a master with the tank plan block renamed) that nobody has run.
493. BUG-162 | ALREADY-FIXED | pilot-critical no | Test-only fix, PR #93 merged (7627ed39).
494. BUG-161 | ALREADY-FIXED | pilot-critical no | PR #87 merged (b02f3ec7); nothing installed in AutoCAD is missing from master.
495. BUG-160 | INSTALLED-WAITING-PROOF | pilot-critical yes | Part 1 PR #354 and the Keep or Automatic window (91a08ce0) are on the line; installed in 3.0.70, not yet driven in AutoCAD.
496. BUG-158 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 842b2490 (PR #347) warns instead of dropping the council sheet; Codex pass 18 was blocked, it needs a drawing with a council set.
497. BUG-058 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d77f8d2b is on the line, and a Codex run on 8 Oct reports "source-tag pits registered 45"; nobody has written a pass for it.
498. BUG-059 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d48f8d5b is on the line; Codex run W25 (8 Oct) shows the doubling gone (63 pipes down to 53); needs a closing ruling.
499. BUG-060 | INSTALLED-WAITING-PROOF | pilot-critical no | Guard d77f8d2b is on the line; the P8 to P8 leftover was a zero-length pipe, and BUG-440 (PR #814) now skips such pipes.
500. BUG-061 | NEEDS-TIM | pilot-critical no | Codex W29 (8 Oct) found it not reproduced on that job and says close it only when Tim confirms; Tim to say if it is gone.
501. BUG-062 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 61eff37e (PR #365) makes the imported pit use its real block rotation; installed 3.0.70, untested.
502. BUG-063 | NEEDS-TIM | pilot-critical no | Tim must say how existing council pipes and the council stub should be drawn and layered in an import.
503. BUG-064 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit f42798c6 (PR #366) makes "Propose fixes for all" always report; the result uses a message box, so Codex was to judge the wording.
504. BUG-065 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit b42766ab (PR #368) trims imported pipes to the pit outline; Tim's 29 Sep ruling (keep imported levels, flag suspect ones) is a separate queue item A6.
505. BUG-066 | UNCLEAR | pilot-critical no | Needs Tim's screenshot to set the quality bar, and a re-look now that the doubled pipes are gone (BUG-059).
506. BUG-067 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0a79865a (PR #363) is on the line; Tim approved "Unknown" for the FROM column on 29 Sep; not driven in AutoCAD.
507. BUG-068 | NEEDS-TIM | pilot-critical no | Tim ruled "snap to the architectural xref" on 3 Jul but how to find that xref in his drawings (origin, rotation, scale) and how Mike's coordinates relate needs his example; no commit found.
508. BUG-069 | UNCLEAR | pilot-critical no | PR #369 was HELD because the real cause was never found; needs a Codex reproduction on the original drawing type first.
509. BUG-070 | INSTALLED-WAITING-PROOF | pilot-critical no | Batch commit ad285577 (BUG-070 to 078) is on the line; carpark says installed, awaiting Tim's AutoCAD confirm.
510. BUG-071 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; window sizing, a look-and-feel check in AutoCAD.
511. BUG-072 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; pit P-number label on resize, awaiting Tim's confirm.
512. BUG-073 | UNCLEAR | pilot-critical yes | Batch ad285577 is in, but Tim's 29 Oct screenshot (Civil 3.0.85) shows the New Pipe preview with no pipe drawn; the cause is not known and it is parked under BUG-1230.
513. BUG-074 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; its tests skip on the dev box, awaiting Tim's AutoCAD confirm.
514. BUG-075 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch; Codex ran a pass on 27 Oct per the 29 Oct triage, which still needs a reviewer to compare it with this entry.
515. BUG-076 | INSTALLED-WAITING-PROOF | pilot-critical no | Commits ad285577 and 509dc431 are on the line, installed in 3.0.70, queued for a Codex pass.
516. BUG-077 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; the 5 mm pit drop carries down the run, awaiting Tim's confirm.
517. BUG-078 | INSTALLED-WAITING-PROOF | pilot-critical no | Same batch commit ad285577; above and below toggle in CDEDIT, awaiting Tim's confirm.
518. BUG-079 | INSTALLED-WAITING-PROOF | pilot-critical no | Rounds 1 to 8 landed as c940e457 (PR #370); needs a visual check of all 8 drag directions and a slab with falls.
519. BUG-080 | NEEDS-TIM | pilot-critical no | Tim must supply the AS/NZS 3500 or AS 2200 maximum velocity for UPVC (the code holds 3.0 and 6.0 m/s as unverified guesses); the carpark says do not tidy it until then.
520. BUG-056 | NEEDS-TIM | pilot-critical no | Four engineering questions are open: invert-to-invert or obvert match at the council connection, the drop across it, how detention pipes are held, and how the connection is marked.
521. BUG-057 | UNCLEAR | pilot-critical no | Tim said some proposed fixes are wrong but no example was ever captured; need the pit or pipe, the proposed value and the correct value.
522. BUG-053 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix was deployed as v2.1.11 on 24 Jun and has guard tests; I did not find a commit naming it on the live line, and it has not been run on the roof drawing with xrefs.
523. BUG-054 | UNCLEAR | pilot-critical no | Not diagnosed; the deciding test (does it repro with the CE bundle disabled) and the question whether the edited objects are CE or structural were never answered.
524. BUG-051 | ALREADY-FIXED | pilot-critical no | Carpark says FIXED on 15 Jun (publishing moved to the main thread, 18 of 18 tests); no commit naming it was found on either live line, and Tim has not confirmed.
525. BUG-049 | UNCLEAR | pilot-critical no | CEADS still exists on the Structural line, but no commit or test result says the open-window crash was fixed.
526. BUG-001 | NEEDS-TIM | pilot-critical no | C alias is fixed and confirmed; Copy Rotate and Move Rotate are with Tim, and the clash with Structural's own "C" command was never ruled on.
527. BUG-002 | ALREADY-FIXED | pilot-critical no | Tim confirmed "works for now" on 13 May; a rare 10 per cent residual case is parked without a repro.
528. BUG-003 | INSTALLED-WAITING-PROOF | pilot-critical no | 29 Sep triage found the orifice pit detail generator in code, installed in 3.0.13; queued for a Codex check that I did not find a result for.
529. BUG-004 | ALREADY-FIXED | pilot-critical no | Tim confirmed T2 on 20 May (the command is CDMANAGER).
530. BUG-005 | ALREADY-FIXED | pilot-critical no | Checklist T21 passed on 8 May.
531. BUG-006 | ALREADY-FIXED | pilot-critical no | Checklist T20 passed on 8 May.
532. BUG-008 | ALREADY-FIXED | pilot-critical no | Tim confirmed 13 May; ledger item F-229 may ask to remove the 90 per cent rule, which would need a re-test.
533. BUG-009 | ALREADY-FIXED | pilot-critical no | Checklist T17 passed on 20 May.
534. BUG-007 | CLOSED-OR-WONT-FIX | pilot-critical no | Umbrella record for the 8 May batch, closed on Tim's yes (decision 178, 31 Oct); entry kept.
535. BUG-010 | ALREADY-FIXED | pilot-critical no | CDCALC opened on three recorded runs and Tim re-confirmed T1 on 20 May.
536. BUG-011 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0bda3751 and PR #367 lock callout left-justify per direction (Tim's BUG-128 ruling); Codex or Tim has not confirmed on west callouts.
537. BUG-012 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 0bda3751 (PR #367) stops the FALL text patch dragging both texts to the origin; a drawing already holding a damaged FALL SYMBOL must be purged first.
538. BUG-013 | ALREADY-FIXED | pilot-critical no | Serilog pin fixed in e4546f6b on 13 May; the entry is a permanent reminder, nothing to test.
539. BUG-014 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark names commit 13fc5acb (before the monorepo import); no commit naming it was found by search, and it has had no robot or Codex pass.
540. BUG-015 | INSTALLED-WAITING-PROOF | pilot-critical no | Same pre-import fix (grade text always shows "1 IN N"); no commit naming it was found by search, no robot or Codex pass.

---

## What I could not verify

1. **Pull requests:** `gh` is not available here, so PR states (open, merged, closed) were not checked. PR numbers are from the carpark or from merge commits in git history.
2. **Installed build:** I did not read the installed DLL. "Installed" is the carpark's own wording (Civil 3.0.70 / Manager 1.1.70, reconciled 23 Oct), not something I confirmed.
3. **Newer results:** the ledger (`ledger.json`) is keyed by robot case, not by BUG number, so I could not match robot results to these entries. Codex and robot passes after 23 Oct may exist that I did not see.
4. **Missing commits:** git search by BUG number found nothing for BUG-051, 053, 054, 049, 014, 015, 163, 169 (live Civil line only; 169 was found on the Structural line), 056, 061, 063, 066, 068, 069 and 080. For the old fixes that may only mean the commit message does not use the number.
5. **Not read:** other carpark entries and area files that may mention these bugs later (for example BUG-1230, BUG-440, BUG-215, BUG-224) were only followed when named in the entry.
