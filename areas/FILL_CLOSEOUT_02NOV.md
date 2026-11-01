# Close-as-done check: draft PRs the Opus reviews say are already on the line

Written Monday 2 November 2026, Melbourne time, by a read-only Sonnet queue filler for CE 05, at CE 00's request.
Line checked: `origin/claude/rel-20261102a` (tip 3fbb9da5, after a `git fetch`). Structural PRs were checked against `origin/claude/rel-20261026s`.

## FOR TIM

1. **Five Civil and Manager drafts can be closed now: #1229, #1217, #1230, #1215 and #1233.** Each fix has been on the Civil/Manager line since 9 October under another name. I confirmed every proof commit is on the line.
2. **One Structural draft, #1261, can also be closed.** Its fix is already in the Structural line (confirmed). It is not on the Civil/Manager line, which is a separate line.
3. **Two drafts are half done: #989 and #892.** In #989 only the BUG-560 half is on the line, so keep the BUG-563 half. #892 is mostly replaced by an earlier fix and by Tim's own ruling of 29 October. The review says close it or park it.
4. **None of these bugs is FIXED.** The fix is in the code, but nobody has seen it work in real AutoCAD. Each carpark entry should read "fix already on the line, PR can be closed", and each should go to the robot.
5. **I closed nothing and edited no carpark entry.** I cannot, and the brief said not to.
6. **I made ten follow-on jobs (701 to 710).** Each checks 10 more old draft PRs, oldest first, 100 PRs in all. They are in `C:\CE_PLAN\desk_jobs\team_queue`.

---

## What was read, checked and NOT proven

1. **Read:** all ten Opus backlog reviews (R1 to R8 of 1 Nov, R1 and R2 of 2 Nov) and the carpark Status lines.
2. **Checked by me:** for each proof commit I ran `git show` (date and subject) and `git merge-base --is-ancestor` against the line. The PR title, draft state and creation date came from `gh pr view`.
3. **Not checked by me:** I did not diff each PR against the proof commit line by line. That "same behaviour" judgement is the Opus reviewers' and I am relaying it. Nothing was built, tested or opened in AutoCAD.
4. **Not proven:** none of these fixes is proven in real AutoCAD.
5. **The reviews' own tip:** most reviews said the tip was `rel-20261112a` (the C-79c finalizer). That branch holds the same proof commits, so the 1102a check below is the stricter one.
6. **Search note:** `git log --grep=BUG-NNN` finds nothing for BUG-509, 511, 512, 513, 514 and 484. The proof commits carry other IDs (HUNT2-C-xx, HUNT-M-09, "R-00 item 15"). I found them from the Opus reviews and the carpark IDs they quote.

## PRs the reviews say are already done

1. **#1229, LandXML pit floor level and made-up sizes (BUG-513, BUG-512): ALREADY-DONE.** Draft, opened 10 Oct. Proof: **ae64971a** (9 Oct, "HUNT2-C-08/09: LandXML placeholders marked and listed; sump level not the invert"), on the line (confirmed). The line's version also has a Settings switch (`landXmlSumpLevelAsInvert`) that #1229 lacks. Review: OPUS_PREREVIEW_BACKLOG_R3_01NOV.md. One gap that stays in BUG-512 is noted in that review (the carpark's expected result is "the size stays Unknown"); it should be read before BUG-512 is closed.
2. **#1217, CDDESIGN detention pipe follows the Settings run and size range (BUG-511): ALREADY-DONE.** Draft, opened 10 Oct. Proof: **6ae16dde** (9 Oct, "R-00 item 15: CDDESIGN detention pipe limits read the Settings figures CDRULES checks"), on the line (confirmed). Review: OPUS_PREREVIEW_BACKLOG_R4_01NOV.md. It has its own test file.
3. **#1230, CDRULES "Velocity uses Assumed roughness" only when really assumed (BUG-514): ALREADY-DONE.** Draft, opened 10 Oct. Proof: **499b97c8** (9 Oct, "HUNT2-C-10: Assumed roughness warning only when unconfirmed"), on the line (confirmed). Review: OPUS_PREREVIEW_BACKLOG_R4_01NOV.md.
4. **#1215, CDDESIGN summary prints the council's own C (BUG-509): ALREADY-DONE.** Draft, opened 10 Oct. Proof: **9793b9e7** (9 Oct, "HUNT2-C-05: summary prints the before-development C used (one chooser)"), on the line (confirmed). Review: OPUS_PREREVIEW_BACKLOG_R6_01NOV.md. It would clash in program code (DesignProposalReport.cs), not only in the change log.
5. **#1233, CEHEALTH Manager line and second-copy warning (BUG-484): ALREADY-DONE.** Draft, opened 10 Oct. Proof: **5a344c73** (9 Oct, "HUNT-M-09: CEHEALTH checks Manager, the Civil/Manager pair and duplicate installs"), on the line (confirmed). The line's version also prints the "matching pair" line that #1233 lacks. Review: OPUS_PREREVIEW_BACKLOG_R8_01NOV.md.
6. **#1261, C2/SC2 column picker says "press 1 to 9" (BUG-576): ALREADY-DONE on the Structural line only.** PR base is `rel-20261009y`. Proof: **b2e56d16** ("Fix column picker keyboard range instruction"), an ancestor of `rel-20261026s` (confirmed), and it came in through merge e9d5bcf9, also an ancestor of 26s (confirmed). It is not an ancestor of `rel-20261102a`, which is expected because that line is Civil and Manager. Review: OPUS_PREREVIEW_BACKLOG_R2_01NOV.md. The carpark already says "fix installed in Structural 1.0.121 via PR #1261".
7. **#989, CD binds CE's record before the picks (BUG-560) plus the "flat" warning dash (BUG-563): PARTLY-DONE.** Draft, opened 9 Oct. The BUG-560 half is on the line as **2f3f4df6** (11 Oct, "BUG-560: CD makes CE's record this drawing's before picking, so a second-opened drawing finds its pits"), on the line (confirmed). The line also already has `Bug560CdBindsRecordTests.cs`. Do NOT close #989: the BUG-563 half (two one-line wording changes plus its test) is still wanted. Review: OPUS_PREREVIEW_BACKLOG2_R2_02NOV.md says to drop the bind hunk and the duplicate test and keep the rest.
8. **#892, X-Civil and LandXML imports read the UNITS (HUNT2-C-01): SUPERSEDED.** Draft, opened 8 Oct. The LandXML half is replaced by **2ed82768** (BUG-725, "LandXML import uses one position scale per file"), on the line (confirmed). The unset-UNITS half goes against Tim's answer of 29 Oct (decision 10: import as millimetres, print one soft line, never a block) and BUG-505. The review calls it CHANGE-NEEDED, do not merge as it stands, and offers "close it, or park it". I list it here because the review says the PR's two halves are both overtaken. The wording "close" is the review's recommendation, not my own check. Review: OPUS_PREREVIEW_BACKLOG2_R2_02NOV.md.

## PRs a quick read might wrongly take as done

1. **#1886, pier schedule SYNC (BUG-1183): NOT-DONE.** Review R1 of 2 Nov says it is "already on the Structural line". It means the PR is built on top of the line and merges cleanly. The PR is still open on base `rel-20261026s`, and `git log` on that line finds no commit naming BUG-1183. Do not close it.
2. **#1233's neighbour #1691 and the other KEEP and CHANGE-NEEDED reviews:** none of the other reviewed PRs is reported done. R1 of 1 Nov says explicitly that none of #987, #1423, #1805, #1593 and #1588 is on the line.

## Carpark entries to annotate

I did not edit the carpark. Proposed Status wording for each, in Tim's terms: **"fix already on the line, PR can be closed"**, plus the proof commit, and "not yet seen in AutoCAD". Current last Status lines are quoted so nobody overwrites a stronger line.

1. **BUG-511** (CDDESIGN detention pipe limits), PR #1217, proof 6ae16dde. Current: "OPEN (found by reading code; not seen in AutoCAD yet)".
2. **BUG-512** (LandXML made-up sizes), PR #1229, proof ae64971a. Current: "OPEN (found by reading code; not seen in AutoCAD yet)". Note the open "stays Unknown" gap.
3. **BUG-513** (LandXML sump level taken as invert), PR #1229, proof ae64971a. Current: "OPEN (found by reading code; not seen in AutoCAD yet)".
4. **BUG-514** (Assumed roughness warning), PR #1230, proof 499b97c8. Current: "OPEN (found by reading code; not seen in AutoCAD yet)".
5. **BUG-509** (council's own C in the summary), PR #1215, proof 9793b9e7. Current: "OPEN (found by reading code; not seen in AutoCAD yet)".
6. **BUG-484** (CEHEALTH Manager line and second copy), PR #1233, proof 5a344c73. Current: "OPEN (found by reading code; not seen in AutoCAD yet)".
7. **BUG-576** (column picker "1 to 9"), PR #1261, proof b2e56d16 on the Structural line. Current: "OPEN (fix installed in Structural 1.0.121 via PR #1261; not yet tested by robot or Codex)". This one already says the fix is in. Add only "PR #1261 can be closed".
8. **BUG-560** (CD binds record before picks), PR #989 half only, proof 2f3f4df6. Do not say "PR can be closed". Its carpark entry has Claude driver notes (10 Oct, not reproduced with typed centres). Say only "bind half on the line; #989 keeps the BUG-563 half".
9. **BUG-563** (flat-pipe warning dash): no change. It stays OPEN and its fix is still in #989.
10. **BUG-725 and BUG-505** (units) relate to #892. I did not read their full entries, so I propose no wording. BUG-505 already reads "fix installed; still fails in real AutoCAD (Codex V3b-04 FAIL 21 Oct, V8-01 DIFFERENT 22 Oct)", so it must not be softened.

## Robot checks the reviews already wrote for these fixes

1. **BUG-511:** run CDDESIGN on a detention job, then with `designStandards.detentionMaxRunM` at 30 and diameters 300 to 450 in test settings. Expect a pipe of 300 to 450 mm and 30 m or less (R4 review, item 7).
2. **BUG-514:** CDRULES on UPVC pipes with the roughness confirmed. Read the saved findings file, not the 20-row command line. Expect no "Assumed roughness" rows (R4 review, item 7).
3. **BUG-484:** CEHEALTH on a test login, then with a second copy of the Civil bundle. Expect the Manager line, the "matching pair" line and one "installed in two places" warning (R8 review, item 8).
4. **BUG-509, 512, 513 and 576:** scenarios are in the R6, R3 and R2 reviews. I did not copy them across.

## Follow-on jobs

1. **Ten jobs, 701 to 710,** in `C:\CE_PLAN\desk_jobs\team_queue` (named `7NN_alreadydone_checkNN.txt`). Each is Sonnet, read-only, and checks 10 draft PRs.
2. **Which PRs:** the 100 oldest open drafts, taken from `gh pr list --state open --limit 2000`. There are 1,575 open PRs and 1,564 are drafts. The 100 run from #2 (3 July) to #460 (1 October). Non-draft PRs (#1, #3, #43, #47, #55, #57 and others) were skipped because the brief said draft PRs.
3. **Overlap:** none of the 100 is in the Opus backlog reviews, so no PR is checked twice.
4. **Each job writes one file:** `C:\CE_PLAN\areas\FILL_ALREADYDONE_CHECK_NN_02NOV.md`. None of those names exists yet.
5. **Safety paragraph:** copied word for word from the earlier audit chunk jobs, with the same read-only limits. Each job ends with "Final message: one line, file path and verdict counts".
6. **A mistake of mine, now undone:** I first wrote a list of open PRs to `C:\ce-fx` and then deleted that one file by its exact name. I used a scratch folder `C:\ce-fx\fill7`, which I also removed once empty. Nothing else in `C:\ce-fx` was touched.
7. **Tool note:** `gh` is not on the plain tool PATH. I ran it by its full path (`C:\Program Files\GitHub CLI\gh.exe`) from Git Bash, because it needs `git` on the path. The new job texts do not say this, so a worker may hit the same snag.
