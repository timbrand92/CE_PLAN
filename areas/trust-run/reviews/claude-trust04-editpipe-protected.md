# Review: PR 2056 `claude/trust04-editpipe-protected` (TRUST-04 queue item 7: Edit Pipe Save refuses a locked-layer or Xref pipe or label)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:12 PC clock. **Head reviewed:** `f3dc3a86` (one own commit; base `cf059dcf` confirmed). Read by a helper reader; the check order, the list of objects checked and the double-line border gap re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Edit Pipe's Save now checks the pipe, every label tied to it and the other half of a broken pipe before anything is written, and refuses in plain words if one is on a locked layer or inside an Xref. Nothing is unlocked or worked round.
2. It still misses a few things Save also rewrites: the double-line border of older-style pipes, the labels of the other half, and a detention pipe's twin barrels. On those, AutoCAD's own locked-layer error comes back, as today.
3. "Nothing was changed" is not always true: if you used Move arrow in the window first, the arrow has already moved.

**Verdict: GO** for the robot on copies, with the two small items below fixed before Codex reads the words. GO means fit for testing on copies, never merge or install.

---

## Findings (most serious first)

1. **The check runs before anything is written, and only reads.** `Commands\PipeEditCommand.cs` 225-233: the protection check comes after the "nothing changed" exit and before the held record is accepted (235) and the edit is applied (237-239). The check opens everything for read in an open-close transaction, so it adds no Undo step (`PipeEditCommand.Protection.cs` 17-58). On refusal the held record goes back as it was (`PipeEditCommand.cs` 281). Nothing is unlocked, detached, cloned or exploded.
2. **Small fix 1: it does not cover everything Save writes.** Checked: the pipe, its attachments list (labels, level texts, flow arrow) and the other half (`PipeEditCommand.Protection.cs` 22-31). Not checked, though Save rewrites them: the older pipes' double-line border, deleted and redrawn (`PipeEditCommand.Update.cs` 662-665, checked by me); the detention twin barrels (`Update.cs` 674); the other half's own labels (helper: `Update.cs` 586 and 950). The batch editor already checks the other half's labels (`PipeEditCommand.SizeWrite.cs` 350-351). Not worse than today, but the refusal promise is not whole. Add them to the list, as the batch editor does.
3. **Small fix 2: "Nothing was changed." can be untrue.** Every refusal ends "Nothing was changed." (`PipeEditCommand.Protection.cs`, the refusal line). By the helper's reading, Move arrow inside the window (`PipeEditCommand.cs` 170-174) and the label capture for older pipes (112-115) write before Save is pressed. Say "Save was not applied" or name what was already done.
4. **The words are plain.** For example "A label of this pipe is on locked layer ... (unlock it, or leave it out, then run the edit again). Nothing was changed." The layer is named; no internal code is shown. Two rough edges: "leave it out" is the batch editor's phrase and makes little sense for one pipe; the arrow and the level texts are all "a label", so only the layer name says which.
5. **Batch Save with one protected pipe among several: not changed by this PR.** The batch check runs inside the write transaction before anything is written and throws on the first protected pipe or label, naming the pipe by its display name, so the whole set rolls back and none is saved (`PipeEditCommand.SizeWrite.cs` 318-353). How that message reaches the screen was not traced.
6. **Frozen or off layers are not refused.** The protection rule does not ask for it and AutoCAD allows those writes.
7. **Inside a block or Xref:** a pipe inside a block cannot be picked (top-level picks only); a label inside an Xref is caught by its owner or its Xref layer. A layout-space pipe stays allowed, on purpose (the batch editor refuses it: one difference to note).

## Does the test fail without the change, through the real code path?

Partly. The tests would fail on `cf059dcf` because the new functions do not exist there. The words function is real product code. The "check before write" order is pinned by reading the source text (`Trust04EditPipeProtectedSaveTests.cs` 46-61), and nothing drives a locked layer through the real command. That needs the robot.

## Does it do only what the item needs?

Yes, with one stricter side effect: a display-only label change on a protected pipe is now refused too. Safe direction.

## What I did not check

1. Built nothing, ran nothing; counts are the lane's.
2. Whether a write inside `ApplyPipeEdit` that hits AutoCAD's locked-layer error rolls back the whole edit or leaves part written.
3. The downstream carry and label tidy after Save; the twin-barrel layers.
4. Nothing in AutoCAD.
