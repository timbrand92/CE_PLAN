# ALREADY-DONE CHECK 01 — ten oldest open draft PRs (Mon 2 Nov 2026, Melbourne)

Read-only check by Sonnet (Team) for CE 05. Nothing was built, tested, installed or run. Only this file was written. Nothing was pushed. Git was used read-only (fetch, log, grep, ancestry checks). To get the PR heads I fetched each one into a local reference named `refs/prchk/<n>` in the CE_ACAD_PLUGIN repo. These are labels only, with no change to any branch or file. Delete them if you want a tidy repo.

Lines checked: Civil/Manager `origin/claude/rel-20261102a` (3fbb9da5) and Structural `origin/claude/rel-20261026s` (204dfad2, Structural 1.0.125).

---

## FOR TIM

1. **Counts:** 2 ALREADY-DONE, 2 PARTLY-DONE, 4 NOT-DONE, 2 DOCS-ONLY, 0 SUPERSEDED, 0 CANNOT-CONFIRM.
2. **Can be closed now:** #22 (Civil batch editor and look-and-feel update) and #56 (Civil Level 2 audits and identities). Both are fully inside the Civil/Manager line.
3. **Docs-only, closable if you accept the doc is no longer needed:** #13 (Stage B calculation inventory) and #69 (Level 3 plan). Neither changes any command. Their text is not on the Civil/Manager line.
4. **Surprising:** #12 (pipe lines swallowed into the title block, job CG2618) is already on the Structural line but is NOT on the Civil/Manager line. The two lines split on 26 Jul 2026. Closing #12 on the old triage note ("ancestor of installed Structural 1.0.122") would leave Civil colleagues without that guard.
5. **Not on either line:** #19 (project status ribbon button and icons), #23 (one-step Undo for batch edits), #73 (live beam support feedback) and #88 (CDMOVETEST probe). #2 (consultant import redraw) is half on the line: the fall-symbol fixes are in, the redraw import is not.
6. **No bug entries need the "fix already on the line" note.** Neither PR that can be closed names a carpark BUG number. Nothing here is FIXED. That word needs robot plus Codex in real AutoCAD.

---

## ONE LINE PER PR

1. PR #2 | PARTLY-DONE | BUG-079 (CDFALL; the PR commits also use old numbers BUG-069 to 094) | The CDFALL half is on the Civil line as c940e457 (29 Sep 2026, "Land BUG-079 FALL symbol rounds 1-8"), but the redraw-and-extract import (pit-to-pit pipes, coordinate detector, boundary, surface and pavement import) is not on the line.
2. PR #12 | PARTLY-DONE | none (CG2618 is not in the carpark) | On the Structural line (head d0241168 is an ancestor of rel-20261026s; guard first added by 2c2d49e2, 28 Jul 2026), but absent on the Civil/Manager line (no RefEditGuard.cs, no guard in MlineService.cs).
3. PR #13 | DOCS-ONLY | none | One new document, `docs/DRAINAGE_STAGE_B_CONSUMER_INVENTORY.md`; it is on the Structural line, absent on the Civil/Manager line.
4. PR #19 | NOT-DONE | none | Stacked on `codex/project-control-p0c-integration` (13 commits including the P0A to P0C chain); there is no ProjectControl file anywhere on the Civil/Manager line or the Structural line.
5. PR #22 | ALREADY-DONE | none | Head 173fc2ed is an ancestor of the line; it came in through a198937b (31 Aug 2026, "Merge Civil v3 UI with current field fixes"); the PR sits on #20's branch `claude/ce-civil-acad-ui-ux-5sgyqy`.
6. PR #23 | NOT-DONE | none | `CivilUndoBracketService.cs` is absent and no Civil code calls StartUndoMark or EndUndoMark; the PR itself says it has no consumer.
7. PR #56 | ALREADY-DONE | none | Head a0451a6f is an ancestor of the line; it came in through ba28fd4c (7 Sep 2026, "Combine deployment 96e7d76a with native CE transforms"); the PR sits on `claude/c1-shared-spine`.
8. PR #69 | DOCS-ONLY | none | Plan text for the Level 3 roadmap (`docs/LEVEL3_ALL_MODULES_ROADMAP.md` and links); that file is on neither line, and the plan now lives in C:\CE_PLAN.
9. PR #73 | NOT-DONE | none | `BeamSupportFeedback.cs` is on neither line, and the PR's own text says the old-master command file must not be merged as it stands.
10. PR #88 | NOT-DONE | BUG-162 mentioned only in passing | `MoveTestCommand.cs` is on neither line, and the only mention of CDMOVETEST is PipeGripMoveTests; COLLEAGUE_READINESS_29OCT line 114 says "Only a probe exists" for E-HOLD-01.

---

## CARPARK ENTRIES TO ANNOTATE

1. **None.** The only two PRs that can be closed (#22, #56) name no BUG number in their title, body or commits.
2. **BUG-162 (PR #88):** do not annotate from this PR. Its Status line already reads "FIXED — 2026-09-23 (test only: PR #93 merged ...)". That was a stale test check, not the CDMOVETEST work. The PR only says it found BUG-162 while testing.
3. **BUG-079 (PR #2):** the CDFALL half is on the line (c940e457), but that is a code-landing fact, not a PR closure. #2 stays open for the redraw half.

---

## WHAT I COULD NOT VERIFY

1. **Behaviour under other names for #19, #23, #73 and #88.** I searched both lines by file name and by key words (ProjectControl, StartUndoMark, UndoBracket, SupportFeedback, CDMOVETEST). A different design under other words could have slipped past. I did not read the whole line.
2. **#2 is large (56 commits, about 100 files).** I confirmed the CDFALL half by a commit on the line. For the redraw half I only checked that the main new files (XcivilPipeGeometryPlanner, XcivilCoordinateSystemDetector, XcivilLandXmlSanity, XcivilBoundaryExtraction, the similarity registration, SurfaceImport, PavementImport) are absent. The plan card CV-07 line 51 (CV7-6) records the "extract then redraw" decision, but I found no code for it on the line. I did not map every old BUG number in the PR (069 to 094) to its carpark entry. Several old IDs were reused for other bugs, so a name match is not safe.
3. **#12 on the Structural line was confirmed by ancestry only.** I did not run the guard. I did not check whether the Civil team deliberately left it out. The 24 Oct triage (PR_PILE_TRIAGE) called #12 "class A" against the Structural line only.
4. **The Civil/Manager line was fetched at 3fbb9da5 on 2 Nov.** The line moves, so re-run the ancestry check before closing.
5. **Not tested in AutoCAD:** nothing here. These are git facts, not drawing results.
