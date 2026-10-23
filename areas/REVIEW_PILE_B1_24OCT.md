# Opus review of the best unreviewed PRs, batch 1 (Sat 24 Oct 2026, about 04:40 to 05:10 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 1 to 10, then the class C items no Opus review had looked at against the installed code (#1635 and #397).

I read the code at each PR's exact head, not the PR text. I compared each one with the installed Civil 3.0.72 / Manager 1.1.72 line (`claude/rel-20261023m` @ f7f7d551) and with the assembled C-63 train (`claude/rel-20261024m` @ 28987b73). Read-only: nothing built, tested, merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts (12 PRs reviewed):**
   1. **Class E, items 1 to 10:** MERGE 6, MERGE-WITH-FIXES 4, HOLD 0, REJECT 0.
   2. **Class C extras:** #1635 MERGE (one optional tiny fix). #397 REJECT.

2. **Top faults found:**
   1. **#397 would quietly rip out shipped Structural code.** Its branch is now only a 30 Sep "revert" commit. It merges with no conflict into installed Structural 1.0.122 and removes 648 lines across 11 files (the unit copy tools). The old "MERGE" verdict no longer fits what the branch holds. Do not merge. Closing it is Tim's call.
   2. **#1643 (CDPROPAGATE levels) clashes with the C-63 train.** C-63 already rewrote the exact line that works out the "Min grade" report. Merged as it stands, the report half of the fix is lost or will not build.
   3. **#1597 (CDSPINEUPGRADE) would hide the real undo file.** When nothing needs a new identity, Apply now writes an empty rollback file. CE always picks the newest rollback file, so Rollback would find the empty one and could no longer undo the original upgrade.
   4. **#1593 (CDTWL low lid) fixes only half the places that look at lids.** The warning now sees the low lid. But the solver's ceiling, the "first thing water would come out of" pick-list row and the message "the water would come up out of pit X first" still ignore it and can name the wrong pit.
   5. **#1626 (network redesign levels) trusts the record's pipe direction.** On an older pipe whose record runs the other way, the "before" levels would show swapped.

3. **Safe to merge today, into a new train after C-63 (call it C-64, Civil + Manager), in this order:** #1672, #1642, #1569, #1565, #1578, #1627, #1635. Then the four MERGE-WITH-FIXES PRs once their fixes are pushed: #1643, #1597, #1593 (after #1635), #1626.

4. **Two things to know before the train is built:**
   1. **Every one of the twelve clashes on `REGRESSION_LOG.md`.** That is the usual end-of-file log clash, settled by keeping both entries.
   2. **#1642, #1643 and #1627 each add a Settings switch at the same spot in the settings file.** Expect three small clashes there, settled by keeping all three switches.

5. **Rules checks across the batch:**
   1. **Redo (U then REDO):** nothing writes between a U and its REDO. #1565 and #1642 only read; the others write only when the drafter runs the command.
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. #1627 improves things: a copy of a long section on a locked layer is no longer rewritten.
   3. **Switches:** the three new bug-fix switches (#1642, #1643, #1627) start ON, and an older settings file gets ON. Each has a test.
   4. **CE_SHARED, installer, signed-update files:** none touched. #1672 changes Manager wording only.
   5. **Hard-coded engineering values:** none new. #1643 uses the two-decimal level format, which is Tim's locked format and already a constant.
   6. **Hard blocks:** none new. #1643 makes the existing CDPROPAGATE "flat pipe" block catch more cases, which is the point of the fix.
   7. **C-63 list:** none of these bugs is already fixed in C-63. Only #1643 has a real code clash with it.

## One item per PR

1. **#1642 BUG-988 (Civil): a drawing's own empty CE record now beats an old record file on the PC.** Head 3d6c2b88.
   1. **Cause real?** Yes. When CE opens a drawing, it uses the drawing's own record only if that record holds at least one pit, pipe or manual row. Otherwise it falls back to an old record file kept on that PC. So a job whose last pit and pipe were deleted could reopen with a colleague's old rainfall and numbering choices.
   2. **Fix does only that?** Yes. One small rule, read before the PC file is looked at, plus a Settings switch (`linking.drawingRecordBeatsPcFile`, ON). A drawing with no CE record at all still brings an older drawing forward from the PC file, as before.
   3. **Test fails without it?** Yes. A RED commit (ca542897) put the old order in the rule first, and the rule test fails on that.
   4. **Risk:** low. One case changes on purpose: a drawing whose record is empty while a PC file holds settings only. That is exactly the bug. Clashes only on the log and the settings file.
   5. **Verdict: MERGE. Train C-64.**

2. **#1672 BUG-918 (Manager): stop promising that an update will finish by itself.** Head 8b3a1e09.
   1. **Cause real?** Yes. The message said "It will finish when every AutoCAD window on this PC is closed", but nothing in Manager starts the installer. Nothing calls this rule in the installed code either, so no drafter sees the message today. This fixes it before it is wired in.
   2. **Fix does only that?** Yes. One sentence changed: "Close every AutoCAD window on this PC, then ask your CE administrator to finish the update." It does not overlap #1534, which changes the planner messages, not this one.
   3. **Test fails without it?** Yes. The test checks the exact new wording.
   4. **Risk:** none. No installer or signed-update file touched.
   5. **Verdict: MERGE. Train C-64.** Drafters will see no difference until the finish-update step is wired in.

3. **#1569 BUG-1008 (Civil): double-clicking a Remarks cell in the Pit Schedule opens it for typing.** Head 23f1289a.
   1. **Cause real?** Yes. The REMARKS column has a typing box. But CE finds which value a cell edits from its heading, and the heading REMARKS was missing from that list, so every double-click said "This cell cannot be edited." The same gap made Restore and Delete Cell skip Remarks.
   2. **Fix does only that?** Yes. One line adds REMARKS to the list, next to DEPTH and OVERRIDE REASON.
   3. **Test fails without it?** Yes. It also checks every editable column in the window, so the next new column cannot fall into the same gap.
   4. **Risk:** low. A typed remark now becomes a schedule override, shown in italics, like the other override cells. I did not check what happens when a detention pit's remarks are rebuilt over a typed one.
   5. **Verdict: MERGE. Train C-64.**

4. **#1565 BUG-1003 (Civil): CEFIND finds P1A, C2 and the pipes between them.** Head 51a01fcc.
   1. **Cause real?** Yes. CEFIND only knew a pit when it was P followed by digits, so "P1A" and an office-style "C2" came back "not in this drawing".
   2. **Fix does only that?** Yes. P + digits + letters now counts as a pit. Anything else is matched against the pits this drawing's record actually holds, ignoring capitals. Pipes between two such pits work too ("C2-C3").
   3. **Test fails without it?** Yes. "P1A" is the case that fails on the old code.
   4. **Risk:** low. It only reads, through the same read-only lookup as before, so nothing is written and REDO is safe. One small gap: a pit named like a source tag (for example a pit called "WT1") still finds the source tag first. I would not hold the PR for it.
   5. **Verdict: MERGE. Train C-64.**

5. **#1643 BUG-982 (Civil): CDPROPAGATE judges the levels it really writes, to two decimals.** Head 18c6393e.
   1. **Cause real?** Yes. CDPROPAGATE writes inverts as two-decimal text, but it judged the fall on the unrounded numbers. A 1 m pipe overridden to 1 in 300 previewed as OK (10.0033 against 10.000) and was then saved flat (10.00 and 10.00), while the command line still said "Min grade: 1:300".
   2. **Fix does only that?** Yes, but it collides with the C-63 train. C-63 (BUG-796, commit aaaa7ff4) replaced the same "Min grade" lines with a shared one-in-N helper fed the unrounded kept levels. A plain merge either clashes or drops this fix's report half.
   3. **Test fails without it?** Yes, from a RED commit (aad8542e). Its source check looks for the old line text, so it will fail once rebased on C-63 until it is updated.
   4. **Fixes needed (small):**
      1. **Rebase onto C-63.** Feed the C-63 helper the written levels: `PropagationGrade.OneInN(row.LengthMm, PipeUpdate.Written(effectiveUp), PipeUpdate.Written(effectiveDown))`.
      2. **Update the source check** to look for that line.
      3. **Reword the flat-pipe tip in the preview.** It says "cascade blocked unless an override grade is set on this pipe", but in this bug the override is already set. Say instead that the fall is under 10 mm once the levels are written to two decimals, so a steeper grade is needed. Example: a 1 m pipe needs at least 1 in 100.
      4. **Use `PropagationPlan.FormatIl` for the rounding** instead of a second copy of "0.00", so there is one rounding rule.
   5. **Verdict: MERGE-WITH-FIXES. Train C-64 (after C-63 is in).**

6. **#1597 BUG-1024 (Civil): CDSPINEUPGRADE Apply brings a rebuilt CE record back in step.** Head a11a1bef.
   1. **Cause real?** Yes. Apply stopped with "Nothing to write" whenever no object needed a new identity. That happened even when the CE record had lost the identities the drawing objects still carry, for example after a record rebuild.
   2. **Fix does only that?** Mostly. It now checks the record on a copy and, if the record is behind, runs the normal Apply. But the normal Apply always saves a rollback file first, and here that file has no entries. CE's Rollback always takes the newest rollback file for the drawing, so the empty file hides the earlier real one. The drafter loses the undo of the original upgrade.
   3. **Test fails without it?** Only because the new check did not exist before. Nothing tests the "Nothing to write" path itself.
   4. **Fixes needed (small):**
      1. **Do not save a rollback file when it has no entries.** The message can then say "no new identities, so no rollback file was needed".
      2. **Add a source check** that the "Nothing to write" message is only reached when the record is in step.
   5. **Verdict: MERGE-WITH-FIXES. Train C-64.**

7. **#1593 BUG-1021 (Civil): CDTWL checks the lid of a pit whose floor level is unknown.** Head 7884b0cf.
   1. **Cause real?** Yes. A pit with no floor level (and no pipe giving one) is left out of the storage sum, and it was dropped completely. Its low lid was never checked, so a water level above that lid got no warning.
   2. **Fix does only that?** Yes, but only part of it. The pit is kept in a "lid only" list, which adds no litres. That list now feeds the command's "lowest lid" figure and the freeboard warning. Still not fed: the solver's ceiling (it still caps at a higher lid), the pick-list row "the lid of X, the first thing water would come out of", and "Even filled to the lowest lid ... come up out of X first", which can name the wrong pit.
   3. **Test fails without it?** Yes in effect: the freeboard test needs the low lid to be seen.
   4. **Fixes needed (small):**
      1. **Feed the lid-only pits to the other three places:** the pit-name lookup, the "first thing water would come out of" row and the solver's lid ceiling.
      2. **Rebase onto installed.** There is a small real clash in `DetentionBranchCollector.cs` with the installed BUG-970 and BUG-871 changes.
      3. **Merge #1635 first**, because it touches the same two files.
   5. **Verdict: MERGE-WITH-FIXES. Train C-64.**

8. **#1578 BUG-1012 (Civil): the long section reads the closing side of a closed boundary.** Head 409feaf5.
   1. **Cause real?** Yes. Only corner-to-next-corner sides of a boundary polyline were read. On a closed boundary, the side from the last corner back to the first was missed, so a pipe crossing it got no boundary mark.
   2. **Fix does only that?** Yes, for all three kinds of polyline. A closed shape whose last corner already sits on its first adds no zero-length side, because the existing length check drops it.
   3. **Test fails without it?** Only because the new helper did not exist before. The helper's own tests are sound.
   4. **Risk:** low. Arcs in a boundary are still read as straight sides, as before.
   5. **Verdict: MERGE. Train C-64.**

9. **#1626 BUG-998 (Civil): before levels are set, each pipe in network redesign keeps its own levels.** Head d6ac68ce.
   1. **Cause real?** Yes. A pipe's "before" levels were taken from its two pits' floor levels. A pipe arriving 30 mm above the pit floor showed the wrong level and was then called "changed after the preview", which held up Apply.
   2. **Fix does only that?** Yes. The pipe's own end levels are carried through, and a pipe without them falls back to the pit floors as before.
   3. **Test fails without it?** Yes, from a RED commit (a190c19e).
   4. **Fixes needed (small):**
      1. **Match each level to its pit.** The fix assumes the record's "from" end is the upstream pit of the redesign connection. An older record can run the other way. Swap the two levels when the record's From names the connection's downstream pit, and fall back to the pit floors when neither pit matches.
      2. **Use the pipe limit (4,000), not the pit limit (2,000), for the new list.**
   5. **Verdict: MERGE-WITH-FIXES. Train C-64.**

10. **#1627 BUG-997 (Civil): Update Existing changes only the older long section you picked.** Head 3acc9b20.
    1. **Cause real?** Yes. A copied long section shares its drawing block with the original. Update Existing erased and redrew that shared block, so every copy changed too, including a copy kept as the older view or sitting on a locked layer.
    2. **Fix does only that?** Yes. When the block is shared, the picked section first gets its own new block (a unique CE long-section name), and only that block is redrawn. The copies and their shared block are untouched. It all happens in the one change, so a single U undoes it. The existing locked-layer checks still run first. A Settings switch (`linking.longSectionUpdateKeepsCopies`, ON) gives the old behaviour when set OFF.
    3. **Test fails without it?** Yes, from a RED commit (a0664f31). The source check proves the new block is made before anything is erased.
    4. **Risk:** low. Each separated section adds one block name to the drawing.
    5. **Verdict: MERGE. Train C-64.**

11. **#1635 BUG-1032 (Civil, class C): CDTWL pick list wording.** Head a5751512. Until now it had only a Codex review.
    1. **Cause real?** Yes. A new pipe whose record name is still its drawing handle showed as "pipe 10B03B" in the list. The usual-rule row said "pipe pipe". A level above the lowest lid read as a minus "below".
    2. **Fix does only that?** Yes. The wording only: the pipe is named by its two pits, "pipe" is said once, and "ABOVE the lowest lid (water would come out)" is used.
    3. **Test fails without it?** Yes, all three.
    4. **Optional tiny fix:** a level less than half a millimetre above the lid can print "-0 mm below". Treat that as "0 mm below".
    5. **Verdict: MERGE. Train C-64, before #1593.** It merges onto both installed and C-63 with only the log clash.

12. **#397 `claude/s2-unit` (Structural, class C): REJECT.** Head 8aa589a5.
    1. **What it holds now:** a single 30 Sep commit, "Revert UX-UNIT-01/03 slice 2 ... after Opus DO-NOT-MERGE". The branch is 1,101 commits behind installed Structural (`e6d597c0`).
    2. **What a merge would do:** slice 2 is now inside installed Structural 1.0.122. The revert merges with no conflict and removes 648 lines across 11 files, including the unit copy command, its plan, the schedule headings and the Excel text services.
    3. **Verdict: REJECT. No train.** The triage's "Opus MERGE at this head" does not match what the branch does today. Closing it is Tim's call. I closed nothing.

## What I did NOT check

1. **No build and no test run.** "Test fails without it" comes from reading the code and the RED commits, not from running anything. GitHub shows no automated checks on any of these twelve branches.
2. **Nothing was opened in AutoCAD.** Every Civil item still needs its AutoCAD check, especially #1627 (a copied long section stays as it was), #1569 (typing in Remarks) and #1643 (the flat-pipe block in the preview).
3. **The whole C-64 set together.** I dry-ran each PR on its own onto installed and onto C-63, not all twelve stacked. The settings-file and log clashes are expected, not proven.
4. **Whether the three new switches show on the CE Settings page.** Each says "Not in Design Standards". I did not check the page.
5. **#1626's "changed after the preview" check itself.** I relied on the PR's test for it, and did not read the ticket code end to end.
6. **#1569:** whether a detention pit's rebuilt remarks write over a typed remark.
7. **Class C PRs already reviewed by Opus** (#1534, #1711, #1712, #1713, #1717, #1719, #1720): not re-reviewed. Class E items 11 to 30: not reached in this batch.
8. **The carpark:** not edited. No bug was marked FIXED.
