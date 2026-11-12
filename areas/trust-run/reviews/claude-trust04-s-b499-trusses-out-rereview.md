# Re-review: PR 2047 `claude/trust04-s-b499-trusses-out` (BUG-499, roof trusses left out of wall bracing totals), moved after its GO

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:21 PC clock. Read only. **Head reviewed:** `f6b2ea12` (one commit since `4bb65787`, the head given GO in `reviews\claude-trust04-s-b499-trusses-out.md`; still on the installed Structural `8de95c34`). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The bracing panel's sums now know how many roof trusses (BT1, BT2 ...) each direction left out and their total length, but no window shows that yet, so on screen the length still disappears without a word.
2. The wall-line totals now leave trusses out by the same one rule as the direction totals, so the two can no longer disagree. That changes a total, but only as the bug says.
3. Whether trusses count toward wall bracing is still marked yours to decide, and the note beside the rule now names the layer BT1 draws on, "WALL BRACING TYPE BT1".

**Verdict: GO** (unchanged) for the robot and Codex on copies. GO means fit for testing on copies, never to merge or install.

---

## What changed since the GO, against the GO's three notes

1. **"The panel should say what it left out": HALF DONE.** Each direction now carries `RoofTrussesLeftOut` and `RoofTrussLengthLeftOutMm` (`Structural.DesignCore\BracingPanelCalculator.cs` 35-37, counted at 97-114), tested with a made-up set (2 trusses, 5.5 m one way; 1, 2.0 m the other). Nothing outside the tests reads them (checked by search), so the panel window does not show them; the change log says the window words are Codex's. Still owed before Tim is asked.
2. **"His question should carry the layer name": DONE** in the rule's note (55-56) and the change log ("BT1 draws on the layer 'WALL BRACING TYPE BT1', which suggests the office files them with wall bracing"; the hunt's "not wall bracing" was marked "I think"). Honest.
3. **"The wall-line engine still counts trusses (two rules)": FIXED.** `BracingWallLineTotals` filters with the same `IsRoofTruss` (`BracingWallLineTotals.cs` 32), and its agreement test now includes a BT1 brace, so the two totals cannot drift apart without a test failing. The wall-line grouping is used by the panel service (`Services\BracingPanelService.cs` 39, 47) but, per the change log, not shown in any window yet.

## Engineering figures

No length or angle is changed. The only totals changed are wall bracing totals, and only by leaving BT trusses out, which is the bug's rule; it stays a DRAFT default for Tim and is not a Setting (card section 2 against R-00 remains the controller's to settle, as noted at the GO).

## What I did not check

1. Built nothing and ran no test.
2. Nothing in AutoCAD.
3. No client name, street, suburb or job number in the diff (checked).
