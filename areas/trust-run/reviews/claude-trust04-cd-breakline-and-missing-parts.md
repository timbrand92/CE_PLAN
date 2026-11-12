# Review: PR 2059 `claude/trust04-cd-breakline-and-missing-parts` (TRUST-04 queue item 9, BUG-1281 and BUG-1282: CD uses the "Continues to another plan?" answer and names parts it could not place)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:12 PC clock. **Head reviewed:** `f9d14b49` (one own commit; base `cf059dcf` confirmed). Against the BUG-1281 and BUG-1282 entries in `BUG_CARPARK.md`. Read by a helper reader; the level-text finding re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Answering No (or Esc) to "Continues to another plan?" now really leaves no breakline, as you would expect.
2. But that pipe end is left with no level text, and CE records the text as hidden, which is the opposite of what the PR and its AutoCAD checklist say.
3. The new line naming parts CD could not place works for quick mode only, and CE's record still says those parts exist.

**Verdict: FIX FIRST.** GO would mean fit for testing on copies, never merge or install.

---

## FIX FIRST

1. **After No or Esc, the pipe end has no level text and is recorded as hidden.** For a new first half with the breakline option ticked, CD marks the last end's level text hidden before the pipe is drawn (`Commands\CdCommand.cs` 685-691, passed in at 731-732, read by me), so that text is never made, and the hidden mark is stored on the pipe (helper: `PipeCreationService.cs` 494-497, 1142). The new gate (`CdCommand.cs` 1184-1203) only skips the breakline steps. Result after No: no breakline (right), no level text at that end, Edit Pipe shows it hidden, and nothing is printed. This contradicts the code comment "No (or Esc) now leaves a normal pipe end: ... level text kept" (`CdCommand.Breakline.cs` 43-44, read by me), the test name `OnlyAPlacedBreakline_HidesAndErasesTheLevelTextAtThatEnd`, and the change log's AutoCAD checklist ("level text at that end is still there"), which will fail. Fix: on No or Esc, clear the hidden mark and draw the level text (or ask before the pipe is drawn); then make the comment, test and checklist true. A test must drive the real hidden-mark path.
2. **Keep BUG-1282 open for what is not done.** The builder says this too. Done: a quick-mode line names a missing pipe label, level text or arrow (`CdCommand.cs` 757-759). Not done: CE's record still says those parts exist (helper: `CdCommand.Schedule.cs` 91, 98, 100-101), which the bug's expected result includes; labels placed by hand (not quick mode) get no line when they fail (`CdCommand.cs` 798-809).
3. **Small wording fault.** In quick mode with a callout label, Esc at "Snap callout arrow to pipe" gives "The reason is in the CE log" although the reason was the Esc.

## Fixed and sound

1. **BUG-1281 itself:** No or Esc places no breakline symbol, records no pairing point and prints no "run CD again" line (`CdCommand.Breakline.cs` 42-49). The answer is used downstream: the next CD offers to continue only when it finds a pipe with a pairing point and no partner (helper: `LinkService.RepairAudit.InvertPropagation.cs` 2491), so with none recorded nothing is offered.
2. **Words:** plain; no internal codes.

## Does the test fail without the change, through the real code path?

Only by not compiling plus source-text checks. The missing-parts rule is tested as a pure helper; nothing forces a failed level text through the real pipe creator, which the bug entry asks for.

## Does it do only what the bugs need?

Yes; nothing extra.

## What I did not check

1. Built nothing, ran nothing.
2. Nothing in AutoCAD.
3. The continuation-half path (a breakline at the first end) in the same depth.
