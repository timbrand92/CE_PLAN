# Review: PR 2061 `claude/trust04-cdlpd-metres` (TRUST-04 queue item 11: CDLPD search distances in a metre drawing)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `7386e906`, one own commit on `claude/rel-20261108a` = installed Civil `cf059dcf` (checked). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. In a metre drawing CDLPD looked for the pipe end within 250 metres instead of 250 millimetres, so it could tie an LPD to a pipe anywhere on the plan; now it looks within 0.25 m.
2. Millimetre drawings behave exactly as before, to the last digit, and a drawing with no units set behaves as before (treated as millimetres).
3. Fit for the robot on a metre copy.

**Verdict: GO** (fit for testing on copies, never to merge or install).

---

## Checked and sound (by reading the code at `7386e906`)

1. **All four CDLPD distances go through the conversion:** pit search, other-block search, picked-point search and "pit within" (`Commands\LpdCommand.cs` 89, 105, 132, 187), through `LpdReach` (572-583), which calls CE's one millimetres-to-drawing-units rule, the same one every other reach uses (`Services\DrawingAreaUnits.cs` 105-109; `LinkService.PitOutline.cs` 66-67 calls the same).
2. **Applied once, not twice:** the two helpers take the distance as given and compare it with raw drawing distances, with no conversion of their own (installed `Services\LpdService.cs` 446-499 and 501-524). The pit positions `FindNearestPitHandle` compares against are drawing coordinates from CE's record, so a drawing-unit distance is the right one.
3. **Millimetre drawings provably unchanged:** the rule divides by exactly 1.0 for millimetres (`DrawingAreaUnits.cs` 87-96 and 107-108), so the value is the same to the bit; the test pins 250 to 250 for units code 4.
4. **Units not set:** the rule returns the value unchanged (as before), so a metre drawing with no units set still searches 250 "units" (250 m). The PR says so honestly.
5. **Message words unchanged and still right:** "No pipe end found within 2.5m of the selected block" is worked from the millimetre setting (line 107).
6. **Tests:** the conversion for millimetre, metre, centimetre and no-units codes, and a source guard that each of the four searches uses it and none passes the raw setting. Removing any one conversion fails the guard; a conversion that did nothing fails the metre case.

## Worth knowing (not blocking)

1. **A metre drawing with no units set is still searched as millimetres, silently.** CE's other reaches print one plain note per drawing when a units-not-set drawing looks like metres (`LinkService.PitOutline.cs` 69-80, `NoteIfUnitlessLooksLikeMetres`). CDLPD does not call it. Cheap to add; listed for the controller.
2. **Merge order:** PR 2058 (step 7) also changes `LpdCommand.cs` (8 lines near the start and near CDLPDRESET); expect a small text conflict, not a behaviour clash.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD (the PR's metre-copy steps are the robot's).
3. Other distances inside CDLPD that are not searches (note text height and placement); out of this bug's scope.
