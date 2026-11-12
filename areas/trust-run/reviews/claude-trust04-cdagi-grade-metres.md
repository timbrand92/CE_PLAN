# Review: PR 2075 `claude/trust04-cdagi-grade-metres` (CDAGI's grade check right in metre drawings)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 06:59 PC clock. **Head reviewed:** `3960801a` (one commit on PR 2057's head `311147d8`, confirmed; 2057 is cut from installed Civil `cf059dcf`). **Against:** what it claims and **BUG-1052** ("CDAGI and CDPERIMETER report a flat drain as meeting the minimum grade in a metre drawing"), which is the carpark entry for this fault; the PR does not name it. **Four states:** Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: 165 of 165 in its filter; broken twin 2 of 4 fail). Installed no. Accepted no.

---

## FOR TIM

1. In a drawing set to metres, CDAGI and CDPERIMETER worked out the drain's grade as if 12 m were 12 mm, so a drain far too flat could print "meets the office minimum". Now the length is turned into millimetres first and the grade is right.
2. Millimetre drawings are unchanged to the bit; a drawing with no units set reads as it does today (as millimetres).
3. A short run (under 1 m) in a metre drawing now gets its level questions instead of being skipped.

**Verdict: GO** for the robot on a metre copy (with PR 2057 in the same build). Two small items.

---

## Findings

1. **Fixes what BUG-1052 says: yes, by reading.** The run length goes through CE's one shared converter before the grade is worked out (`Modules\Drainage\Commands\AgiCommand.cs` 275-279, 333-334; `Services\DrawingAreaUnits.cs` 116-120). That one call is the only place the grade text gets its length, for both the plain grade line and the "towards the outlet" one (`AgiCommand.cs` 288; `AgiCommand.GradeDirection.cs` 48-64), and the "1 mm or less, skip" test now runs on millimetres, so a 0.5 m run is asked for its levels.
2. **CDPERIMETER is covered:** it is the same command code with its own tag prefix (`AgiCommand.cs` 68-70).
3. **Millimetre drawings unchanged:** the converter's factor for millimetres is 1. **Units not set:** no factor, the length is used as it stands, as today (the test `AUnitlessDrawing_KeepsTodaysReading`).
4. **Tests:** the bug's own example (10 m, 0.001 m fall, "1:10000 ... below") is not among them; the PR's example (12 m, 10.000 to 9.900, "1:120 ... below") is. The wiring test is a text search. Fine for a one-line change.

## Small items

1. **Name BUG-1052** in the PR and its log entry, so the carpark entry can carry the note (the PR says "finding recorded in the lane file at 03:53").
2. **Robot row 24** (`PENDING_TESTS.md`, safety lane list): add the bug's own two steps, the 10 m run with a 1 mm fall ("1:10000 ... below") and a 0.5 m run that must still ask for levels, and repeat with CDPERIMETER.

## Worth knowing

1. A metre drawing with units NOT set still reads as millimetres, silently (as CDLPD in PR 2061); CE's other reaches print a one-line note for a drawing whose coordinates look like metres.
2. PR 2063 (BUG-1313, close distance) also changes `AgiCommand.cs` on a different stack; expect a small merge conflict.

## What I did not check

1. Nothing run.
2. Other millimetre figures inside CDAGI outside the grade check and the close distance.
