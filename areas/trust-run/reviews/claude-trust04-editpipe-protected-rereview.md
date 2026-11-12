# Re-review: PR 2056 `claude/trust04-editpipe-protected` (TRUST-04 queue item 7: Edit Pipe Save refuses a locked-layer or Xref pipe or label)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:42 PC clock. Read only. **Head reviewed:** `40e891f0` (one review-fix commit on `f3dc3a86`, which was reviewed at 04:12; base `cf059dcf`, ancestor checked). **Read against:** `reviews\claude-trust04-editpipe-protected.md` (GO with two small items) and the diff `f3dc3a86..40e891f0`. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Both small items are fixed: Edit Pipe's Save now also checks the double-line border of older pipes, a detention pipe's twin barrels and the labels of the other half of a broken pipe before writing anything.
2. The refusal now ends "Save was not applied." instead of "Nothing was changed.", which was untrue after Move arrow.
3. Nothing is unlocked or worked round; the check still only reads.

**Verdict: GO** for the robot and Codex on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier small items

1. **Not everything Save rewrites was checked: FIXED.** `Commands\PipeEditCommand.Protection.cs` (branch 29-45) adds the pipe's double-line border (`context.MlineId`), the twin barrels (`LinkService.TwinDisplayChildIds`, new, `Services\LinkService.PipeMoveHelpers.cs` 1289-1309, read in an open-close transaction from the same handle list the twin clean-up erases) and each label of the other half (`GetAttachmentIdsForPipe(partner)`), the same as the batch editor. All are added to the list the existing read-only check walks before anything is written.
2. **"Nothing was changed." could be untrue: FIXED.** `SingleSaveRefusedLine` now ends "Save was not applied." (branch 103-107), true whether or not Move arrow ran first.

## Small (cosmetic, not blocking)

1. **The new helper's description was put under the old one:** `LinkService.PipeMoveHelpers.cs` 1280-1288 now has two description blocks on `TwinDisplayChildIds`, and `TwinDisplayChildHandles` (1311) lost its own. No effect on behaviour; move the old block back down.
2. The primary barrel handle may be the pipe itself, so the pipe can be checked twice. Harmless.

## Tests

`Drainage.Tests\Commands\Trust04EditPipeProtectedSaveTests.cs`: the words function is real; the three new targets are pinned by searching the source text. Nothing drives a locked border, barrel or partner label through the real command; the robot's locked-layer cases on copies are the proof.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD, including a detention pipe with a barrel on a locked layer.
3. No client name, street, suburb or job number in the diff (checked).
