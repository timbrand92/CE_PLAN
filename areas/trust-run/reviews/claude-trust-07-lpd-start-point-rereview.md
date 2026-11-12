# Re-review: PR 2058 `claude/trust-07-lpd-start-point` (trust plan step 7, the LPD as the one stored start point)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `772b221d` (one review-fix commit on `6a899344`). **Against:** `reviews\claude-trust-07-lpd-start-point.md` (three FIX FIRST items). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Your "yes, this LPD is the start point" now goes stale on any change to the LPD, its pipe or the pits it starts from and stops at, and CE asks again.
2. On a job with more than one LPD nothing is asked; one line says the order is worked out as before. The long section says one line when its LPD is not confirmed.
3. All three earlier faults are fixed; fit for the robot.

**Verdict: GO** for the robot on copies (never to merge or install). Two small notes.

---

## Earlier FIX FIRST items

1. **A changed pipe still counted as confirmed: fixed.** A one-way mark of the LPD record's values, its pipe's two drawn ends, the start pit and where a run stops (pits by their permanent name, never their number) is kept beside the yes and compared (`Services\LpdStartPointService.cs` 98, 123-137, 196; `Rules\LpdStartPointRule.cs` 135-151, 188-201). A re-joined, stretched or reversed pipe, or an LPD set again with another pit, now gives "needs checking". The pipe-end fallback is gone; the yes is matched by the LPD's own name only (`LpdStartPointRule.cs` 175-181). The test with a re-joined pipe uses the first draft's rule as the faulty version, which says yes there. The Save As fingerprint question is now a robot case, as it should be.
2. **Two LPDs asked about and then unused: fixed.** With anything but exactly one LPD nothing is asked and one plain line is printed (`LpdStartPointService.cs` 388-393; `LpdStartPointRule.cs` 115-116, 124-126); the solver calls its pit-name find "not confirmed" only with one LPD or none and none confirmed (`LpdStartPointRule.cs` 132-133; `Commands\RunSolveCommand.cs` 266).
3. **The long section's use of the stored LPD: fixed in the words and given a line.** The change log now says the installed long section already stops at the stored LPD, confirmed or not; it asks nothing and prints "CE: LPD not confirmed. The long section still stops at the LPD stored in this drawing." when its one LPD is not confirmed (`Commands\ProfileCommands.cs` 51; `LpdStartPointService.cs` 474-500). Listed as a DRAFT default.

## Small notes

1. **An LPD record that holds no LPD gets the wrong line.** The "exactly one" test treats zero LPDs in a readable record like "more than one" (`LpdStartPointRule.cs` 124-126), so a newer-form set left empty would print "more than one LPD in this drawing". Rare; say "no LPD" for zero.
2. **The mark rounds drawn ends to 0.001 drawing units** (`LpdStartPointService.cs` 139-140). If CE ever rewrites a pipe end with a tiny difference that crosses a rounding edge, the yes goes stale and CE asks again. Safe direction; worth one robot look after CDSYNC on a confirmed job.

## Still standing from the last review

1. The evidence lane's core-console run of installed 3.0.90 against a copy holding the new item (both record forms).
2. `cases\TRUST-07.md` H10 to H15 and H29 describe "confirmed" inside a record; the controller's note says step 7's robot cases were added to `PENDING_TESTS.md` after the last review, which I did not re-read.

## Worth knowing

1. **Merge order with PR 2061** (CDLPD metres): both change `Commands\LpdCommand.cs`; expect a small text conflict.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: the question, the store, Undo, Save As.
3. Every line of the new tests beyond their names and the faulty-version cases.
