# Review: PR 2063 `claude/trust04-b1313-close-tolerance-metres` (BUG-1313: CDRG and CDAGI close distances in the drawing's units)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `0c88fe55`, one own commit on `claude/rel-20261108a` = installed Civil `cf059dcf` (checked). **Against:** `BUG_CARPARK.md` BUG-1313. **Four states:** Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: 327 ran in the filtered set, 0 failed; broken twin 1 of 7 fails). Installed no. Accepted no.

---

## FOR TIM

1. In a metre drawing, a click within 1 metre of the first corner closed a raingarden or AG drain outline by itself; now it must be within 1 millimetre, as intended.
2. CDAGI's "which end is next to the outlet" no longer calls two ends up to a metre apart a tie. Millimetre drawings are unchanged to the last digit; drawings with no units set behave as before.
3. Fit for the robot on a metre copy.

**Verdict: GO** (fit for testing on copies, never to merge or install).

---

## Checked against BUG-1313 (by reading the code at `0c88fe55`)

1. **CDRG close distance:** `SourceBlockInsertCommands.cs` 506 now converts 1 mm with CE's one rule; the compare at 511 uses it. Millimetre drawing: 1.0, as before.
2. **CDAGI close distance:** the one production caller of `TryBuildPlan` passes the converted 1 mm (`AgiCommand.cs` 142-147); the new optional value defaults to the old 1.0 (`AgiCommand.Plan.cs` 108, 124), so every other caller (tests only, searched) is unchanged.
3. **CDAGI tie:** the two outlet distances are measured in drawing units (`AgiCommand.GradeDirection.cs` 101-113) and now turned into millimetres once before the 1 mm tie rule (119-123); the rule itself takes millimetres (31-39). Applied once, not twice.
4. **Millimetre drawings provably unchanged:** both conversions use exact factor 1.0 for millimetres; the "millimetre drawing is unchanged" test runs the real plan builder with the default 1.0.
5. **Units not set:** both conversions return the value as it stands (as before).
6. **The bug's "joins within 1 m of the outlet":** the only millimetre constants left in these files are the two handled here and the callout gap, which is already converted (`SourceBlockInsertCommands.cs` 685). No other 1-unit join distance found.
7. **Tests:** the real plan builder with a metre close distance (0.5 m does not close, 0.5 mm does) and a source guard for each of the four conversions.

## Worth knowing (not blocking)

1. **The tie conversion has a source guard only**, no behavioural case; acceptable for a one-line conversion.
2. **Not in this change:** the PR records that CDAGI's grade check treats the run length as millimetres (1 in N is 1000 times off in a metre drawing), left for after PR 2057. That fault is already filed as BUG-1052; the PR should name it.
3. **A second fix for the same CDAGI close already exists:** draft PR #2037 (`claude/w1054-agi-snap-tolerance`, BUG-1054, open), on another base, with a Settings switch (`surface.agiSnapClosureUsesDrawingUnits`, ON). This PR covers BUG-1054's case too: CDPERIMETER runs the same code (`AgiCommand.cs` 68-70), and the only close compare left in the CDAGI files at `cf059dcf` is the one fixed here (BUG-1054's other line numbers are from 3.0.72). For the controller: keep one, close BUG-1054 against it, and check the copied-drain paths #2037's note says still use the old raw distance (`LinkService.SurfaceDrainTags.cs`; I found no close compare there, not chased further).

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. The grade-check fault (BUG-1052) and PR #2037 beyond its description.
