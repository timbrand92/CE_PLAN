# Re-review 2: PR 2048 `claude/trust04-s-b1276-unsaved-structural` (BUG-1276 Structural: not-saved reminder and timed copies)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:42 PC clock. Read only. **Head reviewed:** `4370d7b7` (one review-fix commit on `7999b80a`, which was re-reviewed at 02:16; base `8de95c34`, ancestor checked). **Read against:** `reviews\claude-trust04-s-b1276-unsaved-structural-rereview.md` (one FIX FIRST item) and the diff `7999b80a..4370d7b7`. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Fixed: saving a standard details drawing or a template no longer prints anything about backup copies, and a temporary or recovery copy now says "this is a temporary or recovery copy, not the drawing itself" instead of the untrue "CE could not read the drawing file".
2. Leaving standard details and templates silent is a DRAFT default for you to confirm.
3. A new test reads every reason CE's safety check can give and fails if any falls back to the catch-all words, so a future reason cannot slip through silently.

**Verdict: GO** for the robot and Codex on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier FIX FIRST item

1. **Four Structural reasons fell through to "CE could not read the drawing file": FIXED.**
   1. Temporary recovery, temporary workspace and automatic-save workspace drawings now read "this is a temporary or recovery copy, not the drawing itself" (`Services\UnsavedWorkPlanner.cs`, branch 156-157). "autosave workspace drawing" does not end in "autosave drawing", so it is not caught by the earlier automatic-save line (148); checked.
   2. Standard details and templates print no line at all (`UnsavedWorkPlanner.BackupSkipIsSilent`, branch 166-175; the caller returns before printing, `Services\DrawingAutoSaveService.UnsavedWork.cs` 518-520). The words for them stay in the planner (152-153, 158-159), unused by the line.
   3. Every reason the safety check assigns (`Services\DrawingSafetyService.cs` 127-254 and 419-445: document and database states, path unavailable, the two automatic-save names, non-DWG, the three temporary kinds, standard details, template) now has its own words or is silent. The new test `EveryReasonTheSafetyCheckCanGive_HasItsOwnWords_OrNoLine` (`Structural.Tests\Services\UnsavedWorkPlannerTests.cs`) reads them from the real source and runs the real planner on each: a good guard, and it fails on `7999b80a` for the four reasons.

## Unchanged and still sound

1. CE never saves the drawing; copies go only to the shared CE backup folder; silent with both switches off (`UnsavedWork.cs` 513-517).

## Worth knowing

1. A drafter working long in a template now gets neither copies nor a line saying so. Templates are office reference drawings, so this is likely right; part of the same DRAFT default.
2. The Settings row "Every (minutes)" is still the old words (earlier review, for Codex's look).
3. No client name, street, suburb or job number in the change.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
