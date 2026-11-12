# Re-review: PR 2059 `claude/trust04-cd-breakline-and-missing-parts` (BUG-1281 and BUG-1282: CD uses the "Continues to another plan?" answer and names parts it could not place)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:41 PC clock. Read only. **Head reviewed:** `0218bca8` (one review-fix commit on `f9d14b49`, which was reviewed at 04:12; base `cf059dcf`). **Read against:** `reviews\claude-trust04-cd-breakline-and-missing-parts.md` (three FIX FIRST items), the diff `f9d14b49..0218bca8`, and the CD breakline code on the branch. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Fixed: answering No (or Esc) to "Continues to another plan?" now leaves a normal pipe end WITH its level text, and Edit Pipe shows that level as shown; answering Yes still places the breakline and takes the level text off that end, as before.
2. The "CE could not place its ..." line no longer blames the CE log when the real reason was your Esc.
3. Still open and said so: CE's record still lists parts CD could not place, and labels placed by hand get no line (BUG-1282 stays open).

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier FIX FIRST items

1. **No or Esc left no level text, recorded as hidden: FIXED (by reading).** `Commands\CdCommand.cs` (branch 685-690): a fresh first half no longer marks its last end's level text hidden before the pipe is drawn; only the continuation half's first end is still hidden up front, unchanged. So the pipe is drawn with both level texts (level texts are placed automatically, no question is asked, `PipeCreationService` has no picks), and:
   1. **No / Esc:** `PromptFirstHalfBreakline` returns false (`CdCommand.Breakline.cs` 45-49); nothing hides or erases the text; nothing is stored as hidden (the hidden marks live on the pipe's link data only, not in CE's record, and are written only by `SetInvertHiddenFlags`).
   2. **Yes:** the existing step after the breakline (`CdCommand.cs` branch 1183-1202) stores the end as hidden and erases that level text, with the sweep of any level text at the last vertex. This is the place-then-erase order CE used before the May 2026 "skip, do not erase" change (`docs\BREAKLINE_REDESIGN_BATCH4.md` section 6), which was made for tidiness; the erase steps were kept for exactly this.
   The comment, the test name and the change log's AutoCAD steps now match the code. The new test is still a text search (`Drainage.Tests\Commands\Trust04CdHonestOutcomeTests.cs`, `AFreshFirstHalf_KeepsItsEndLevelText_UntilTheBreaklineIsPlaced`), not a run through the real hidden-mark path; the robot's No and Yes cases in the change log are the real proof.
2. **Keep BUG-1282 open: DONE.** The change log item 4 says what is still open (record still lists missing parts; hand-placed labels get no line).
3. **"The reason is in the CE log" after an Esc: FIXED.** `Services\PipeCreationService.cs` (branch 120-124): "...CE did not place its <part> (a question was cancelled, or CE could not; the CE log says which). Add it by hand or redraw the pipe." Plain; true in both cases.

## Small (not blocking the robot)

1. On Yes, if the level text cannot be erased (for example its layer is locked), that end keeps a visible level text while marked hidden. Before this change the text was never made. Rare; the robot's Yes case on a normal copy will show the usual result.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: No, Esc and Yes with the breakline option ticked; Edit Pipe's shown/hidden after each.
3. The continuation half in the same depth (unchanged by this commit).
