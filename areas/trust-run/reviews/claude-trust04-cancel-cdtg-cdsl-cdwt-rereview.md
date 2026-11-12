# Re-review: PR 2055 `claude/trust04-cancel-cdtg-cdsl-cdwt` (BUG-1285: Esc at the first question of CDTG, CDSL or CDWT)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:10 PC clock. **Head reviewed:** `0627df45` (one review-fix commit on `2629343d`; fast-forward, base `cf059dcf` unchanged). **Against:** `reviews\claude-trust04-cancel-cdtg-cdsl-cdwt.md` (three FIX FIRST items). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Spot level no longer touches CE's stored pit and pipe levels at all, whether you place one or press Esc.
2. Trench grate, spot level and water tank now mark the drawing as Civil only once something is really placed, so Esc at the first question leaves the drawing unchanged.
3. Water tank writes any earlier unsaved CE changes for the drawing before its window opens, as it did before, and the CE log says so.

**Verdict: GO** for the robot on copies (never to merge or install).

---

## Earlier FIX FIRST items

1. **CDSL ran the whole update after the pick: fixed.** The update is gone; CDSL binds the record without writing and never calls the update (`Commands\SpotLevelCommand.cs` 41-45; the lines that ran it after the pick are removed). The test now pins "CDSL has no record update anywhere" instead of the old after-the-pick case.
2. **The Civil mark before the first question: fixed in all three.** CDTG sets it after the grate is inserted (`SourceBlockInsertCommands.cs` 272, after the "cancelled" return at 266-270); CDSL after the spot level block is placed (`SpotLevelCommand.cs` 150); CDWT only when the tank change committed (`WaterTankCommand.cs` 256-257). The test's list of writers that must not run before the first question now includes the mark.
3. **CDWT dropped a record CE kept for the drawing: fixed.** After the bind, a save waiting for this drawing (a kept record or a plain waiting save) is written before the tank window opens, with a log line (`WaterTankCommand.cs` 62-69). The write is guarded by "waiting for this drawing" and comes after the bind, so the record written is this drawing's own. Worth knowing: when earlier work is waiting, Cancel in the tank window still leaves that earlier write (as before this PR, and said in the change log).

## Still open (said plainly in the PR)

1. **CDTG still runs the update just before its outlet question** (`SourceBlockInsertCommands.cs` 244-245), so Esc at the outlet pick still updates the record. BUG-1285 stays open for that part.
2. The source tools' identity fill and the end-of-command write are left to PR 2064 (its own FIX FIRST list applies).

## With PR 2064

No clash: with 2064's switch on, the mark these three now set after placing is either already there or goes in with the record at the command's end. No shared files apart from REGRESSION_LOG.md.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. The 2022 to 2024 build.
