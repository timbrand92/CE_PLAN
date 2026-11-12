# Re-read: PR 2068 `claude/trust-b1362-abs-keeps-brace` (BUG-1362, head moved after GO)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:03 PC clock. **Head read:** `e22522d3` (one commit since the GO at `9c457445`: "the flip step is inside the same guard as the erase"). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. One of the two small items from the last review is done: if CE cannot set the new brace's flip, the new brace is taken back out and the older one stays, exactly as when the erase fails.
2. Nothing else changed.

**Verdict: the GO holds** (robot on copies).

---

## What changed

1. **The flip step moved inside the guard** (`Modules\Structural\Services\BracingService.cs` 2186-2227): flip, then erase of the older brace, in one try; any failure takes the new brace back out and returns "not done", so the drawing is as it was. Read and confirmed.
2. **Test:** a check of the order of the guard, the flip, the erase and the catch in the code text (`Bug1362AbsKeepsTheOldBraceTests.cs`). The other small item from the last review (a real-code check with a deliberately faulty twin) is still not done; it was optional.

## What I did not check

1. Nothing run.
