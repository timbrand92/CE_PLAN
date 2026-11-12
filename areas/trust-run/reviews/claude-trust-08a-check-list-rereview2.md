# Re-review 2: PR 2051 `claude/trust-08a-check-list` (step 8 slice A, the read-only Check this drawing list), moved after its GO

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:21 PC clock. Read only. **Head reviewed:** `b9bed2e8` (one commit since `58111dd4`, the head given GO in `reviews\claude-trust-08a-check-list-rereview.md`). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The one small fix asked for before Codex's look is done: a pit whose stored number is really CE's own internal code no longer shows that code in its reason; the list says "CE's record holds no number for this pit, but its label reads P3".
2. Lists of nearby pits no longer show placeholders or the same number twice ("each numbered P1").
3. The GO still holds.

**Verdict: GO** (unchanged) for the robot on copies and Codex's look. GO means fit for testing on copies, never to merge or install.

---

## What changed since the GO

1. **Stand-in code in a reason: FIXED.** `WithoutStandInCode` (`Rules\CheckThisDrawingListRule.cs` 269-282) rewrites the reader's "CE's record says X but ..." when step 6's one rule (`UnknownNotGuessRule.PitNumberIsUnknown`) says X is the stand-in for this pit; a real stored number (P8) or a size is left as it is. It is applied to the notes of a pit row's Unknown values (398-399). The new test builds the made-up drawing the last review described (record holds the code, label shows P3), runs it through the real reader, confirms the reader's note does quote the code, and checks no output line contains it.
2. **Bracketed lists:** a list whose items have no number is dropped; one number is not said twice (242-256). Tested.

## New problems

None found. Small: the rewrite is applied only to Unknown values' notes; if the reader ever puts the same "CE's record says <code>" note on a Proposed value, it would pass through. The reader's current reasons and the made-up case did not show that.

## What I did not check

1. Built nothing and ran no test.
2. Nothing in AutoCAD.
3. No client name, street, suburb or job number in the diff (checked).
