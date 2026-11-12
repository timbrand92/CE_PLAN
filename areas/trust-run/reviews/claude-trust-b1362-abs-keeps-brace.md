# Review: PR 2068 `claude/trust-b1362-abs-keeps-brace` (BUG-1362: ABS keeps the older brace until the new one is drawn)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:38 PC clock. Read only. **Head reviewed:** `9c457445`, one own commit on the installed Structural `8de95c34` (ancestor, checked). **Read against:** the BUG-1362 carpark entry and its 04:19 note; the installed code at `C:\CE_WORK\scratch\audit_struc` (both callers of the convert step, the brace insert, the layer helper). **Four states:** Built yes (lane: net10, net8, net48 clean). Tested unit only (lane: 86 bracing tests). Installed no. Accepted no.

---

## FOR TIM

1. ABS now draws the new brace first and only then rubs out the older one, so if the new BRACING block cannot be drawn the older brace stays exactly where it was and "It was left as it was" is finally true.
2. Nothing is unlocked or worked round, the words on the command line are unchanged, and one U still takes the whole switch back.
3. The tests read the order of the steps in the code; they do not draw a brace. The robot's two cases on a copy (BRACING block missing; BRACING block present) are the real proof.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Findings

1. **Fixes what the bug says (by reading).** In `ConvertLegacyToNew` (`Modules\Structural\Services\BracingService.cs`, branch lines 2169-2230) the insert now comes first (2172) and the older brace is erased last (2203-2211). When the BRACING block is missing, `InsertBracingBlock` returns "failed" inside its own uncommitted transaction (installed 1665-1674), so nothing at all is added, and the convert step returns false at 2186-2187 before any erase. ABS then prints its unchanged "Could not convert one older bracing block. It was left as it was." (`Commands\BracingCommands.cs` 496-499), which is now true.
2. **If the older brace cannot be erased, the new one is taken back out** (2212-2227), so the wall neither loses nor doubles a brace in that case. On ABS this path is rare: a locked source or target layer is refused earlier with BUG-583's plain line (`BracingCommands.cs` 458-482). On AB NORMALIZE (`Services\BracingDiagnosticsService.cs` 220-257), which has no locked-layer check, a locked old-brace layer used to throw an unhandled error after the old brace was already gone; now it is counted as skipped. Better than before.
3. **An insert that throws** (any AutoCAD error inside `InsertBracingBlock`) now leaves the older brace in place; before, the brace was already erased. Better than before. ABS has no catch of its own, so the drafter still sees AutoCAD's error box in that case (pre-existing, BUG-583 family).
4. **Nothing unlocked, thawed or bypassed.** The layer helper keeps an existing layer's lock, freeze, on/off and colour (`BracingService.cs` 1601-1607, installed). No new layer, lock or Xref code.
5. **One U.** ABS runs inside one AutoCAD command; every transaction inside it is undone by one U. No Undo grouping changed.
6. **Only what the bug needs.** One method reordered; the length-unknown path (R-27) still returns before any write (2157-2162).
7. **Tests: they fail without the change, but by reading the code text, not through the real code path.** Three of the four (`Structural.Tests\Commands\Bug1362AbsKeepsTheOldBraceTests.cs`) check the order of `InsertBracingBlock(`, `.Erase()` and the catch inside the method text; on the installed text the erase comes first, so they fail (I checked by reading; I did not run them). The fourth passes on both. A reordering can be undone in ways these checks do not see (for example an erase added through a helper). `Modules\Structural.HeadlessProof` exists on the installed commit, so a real-code check is possible.

## Small (fix when next touched, not blocking the robot)

1. **Add a headless or robot check with a deliberately faulty version:** older brace plus no BRACING block, assert the older brace is still in the drawing; older brace plus BRACING present, assert one new brace, no old one, and one U brings the old one back.
2. **The flip step sits between draw and erase, outside the guard** (2189-2200). If opening the new brace there ever throws (AB NORMALIZE onto a locked target layer, which that command does not check), both braces stay and the command stops with an error: doubled, never lost. Moving the flip inside the guard, or checking the target layer in AB NORMALIZE, closes it.
3. If both the erase and the take-back fail (2223-2226), the line still says "left as it was" while a new brace was added. Very unlikely.

## Worth knowing

1. BUG-1366 (ABS on a layout tab or inside REFEDIT) is untouched and stays open, as the change log says.
2. No client name, street, suburb or job number in the diff.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: the missing-block case, the one-U case, a dynamic BRACING block's flip.
3. Whether any other command converts older braces outside `ConvertLegacyToNew` (I found only the two callers above by search).
