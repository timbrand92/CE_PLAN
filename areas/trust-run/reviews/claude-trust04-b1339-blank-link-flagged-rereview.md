# Re-read: PR 2066 `claude/trust04-b1339-blank-link-flagged` (BUG-1339, head moved after GO)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:03 PC clock. **Head read:** `d846f1ed` (one commit since the GO at `1ff10de2`: "blank-link entries get distinct names so Ignore on one never hides another"). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The small fix from the last review is done: two saved pits or pipes with no drawing object and no number now get different names in Check Current Drawing, so ignoring one no longer hides the other.
2. Still read only.

**Verdict: the GO holds** (robot on copies). One small thing worth knowing.

---

## What changed

1. **Entry names** (`Modules\Drainage\Services\CurrentDrawingCheckService.cs`, `FindingLinkPart`): a record with a drawing object keeps its object number in the name, as before; one with none uses its own permanent CE identity ("NOLINK-" plus its key); one with neither uses its place in the list ("NOLINK-ROW" plus a count shared by pipes and pits). A test was added.

## Worth knowing

1. **The last fallback can move.** A record with no drawing object AND no permanent identity is named by its place in the list. If an earlier such record is removed or the list order changes, the names shift, and an Ignore given to one can then land on another. That is the fault just fixed, in a rarer form (older records without an identity). Saying so in the item, or giving such records an identity when CE next writes them, would close it.

## What I did not check

1. Nothing run.
2. How many real records lack both an object and an identity.
