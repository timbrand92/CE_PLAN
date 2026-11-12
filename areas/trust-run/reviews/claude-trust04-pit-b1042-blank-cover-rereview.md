# Re-review: PR 2052 `claude/trust04-pit-b1042-blank-cover` (BUG-1042: a blank cover level warns instead of blocking New Pit and Edit Pit)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:41 PC clock. Read only. **Head reviewed:** `6b1865f6` (one review-fix commit on `acd1a526`, which was reviewed at 03:20; base `cf059dcf`). **Read against:** `reviews\claude-trust04-pit-b1042-blank-cover.md` (two FIX FIRST items) and the diff `acd1a526..6b1865f6`. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Both small faults from the last review are fixed: placing a pit with no cover level no longer asks where the cover text goes when there is nothing to write (it says so in one line instead), and clearing a cover level in Edit Pit now removes the cover text rather than leaving an empty, invisible one tied to the pit.
2. A blank cover still stays blank everywhere (record, plan text, Pit Schedule), never 0.000.
3. The tests check the new "is there anything to write" rule for real and the two command changes by reading the code; the robot's PIT and Edit Pit cases are the real proof.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier FIX FIRST items

1. **PIT asked for a cover text corner it would not use: FIXED.** `Commands\PitCommand.cs` (branch 532-563): the corner question now runs only when `PitAnnotationTextFormatter.HasCoverText(...)` is true; otherwise one line, "[CE] No cover text placed: there is nothing to write in it yet (no cover level, invert or notes). Add one later in Edit Pit." `HasCoverText` takes the same six values from the window that the cover text itself is made from (`CreatePitCoverText`, branch 768-779), so the question and the text cannot disagree. Edit Pit's create branch is inside the same new test (see 2).
2. **Edit Pit left an empty cover text: FIXED.** `Commands\PitEditCommand.cs` (branch 1447-1456): when there is nothing to write, the existing cover text is erased, as the "no cover text" branch already did; the create branch (1459-1487) and update branch (1488-1500) are reached only when there is text, so no corner is asked for and no empty text is kept. One U brings the text back (same Edit Pit step).

## New since the last review

1. Nothing else changed in product code. The new rule is a thin wrapper on the existing formatter (`Services\PitAnnotationTextFormatter.cs`, branch 39-50).
2. **Tests:** `Drainage.Tests\Services\Trust04B1042CoverTextTests.cs` runs `HasCoverText` for real (blank everything, then each single line); the two command changes are text searches. They fail on `acd1a526` (the function does not exist; the guards are not in the text).

## Worth knowing (from the last review, unchanged)

1. A hand-typed edit inside the cover text itself is lost when the cover level is cleared; it was already overwritten with nothing before, so no worse.
2. The multi-pit edit's own "The accepted pit cover text is empty." stop (`PitEditCommand.Batch.cs` 889-893) is untouched; one robot case on it still worth running.
3. The warning words ("No cover level yet ...") and the new line are DRAFT wording for Tim.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. Whether a locked layer under the cover text stops the Edit Pit erase (the erase helper is the existing one, not changed here).
