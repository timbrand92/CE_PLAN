# Review: PR 2064 `claude/trust-09-cancel-writes-nothing` (trust queue item 7: "a cancelled command writes nothing")

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:02 to 05:40 PC clock. **Head reviewed:** `d64e9a72`, one own commit on `claude/trust-proof-checks` at `03af5393` (which sits on step 6, step 5, step 1 and installed Civil `cf059dcf`; `cf059dcf` is an ancestor, checked). **Read against:** the PR text, `EVIDENCE_STALE_BUGS.md`, `TRUST_PROBES_13NOV.md`, `EVIDENCE_CROSS_DRAWING.md` and `BUG_CARPARK.md` BUG-1456 (added during this review, at the controller's request). **Four states:** Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: 22,329 ran, 0 failed; the headless check TRUST-CANCEL-01 is written, not run). Installed no. Accepted no.

---

## FOR TIM

1. The idea is right and most of it is sound: with the new switch on, Help and CD Settings stop writing one job's pits and pipes into another drawing, and opening a tool and closing its window with Cancel or the X writes nothing.
2. But the switch is off, so the job mix-up the robot SAW tonight (BUG-1456, 6 of 11 tries) is still there as shipped; and pressing Esc at a prompt goes down a path this change mostly does not touch, so "PIT, then Esc: nothing is written" is not yet true in every case.
3. No accepted change is lost, by my reading, but with the switch on one hidden update now lands in your NEXT command's Undo step after an Esc.

**Verdict: FIX FIRST** (five items). GO would mean fit for testing on copies, never to merge or install.

---

## The seen job mix-up (BUG-1456), sequence by sequence

**How the fault works on the installed build (by reading, matches what was seen):** CDHELP and CDS are on CE's list of 16 commands whose end writes CE's record even with nothing waiting (`Services\LinkService.cs` 61-80; `Services\LinkService.Reactors.cs` 2047-2087). Neither attaches the record to the drawing first (`Commands\CdCommand.cs` 1558-1581). The end-of-command write asks for "the drawing this command ran in" and, with nothing waiting, writes the record CE holds in memory into it (`Services\ProjectDataService.Persistence.cs` 459-475), because the drawing finder returns the drawing it was handed whenever that drawing is open, whatever drawing the record belongs to (`Services\ProjectDataService.Recovery.cs` 1096-1114).

**With the switch ON, as written (by reading, not run):** the 16 commands no longer force that write. At their end the record is written only when a save is really waiting for THIS drawing (`LinkService.Reactors.cs` 2057-2070), and "waiting for this drawing" means a save aimed at this drawing or a record kept for it (`ProjectDataService.Persistence.cs` 426-440). So:

1. **Sequence 1 (work in job A, open older job B, CDHELP first, B became A's 11 pits and 49 pipes): stopped,** provided nothing has aimed a save at B while A's record was in memory (see "doors left open" below). Behind the switch: with the switch OFF it happens exactly as seen.
2. **Sequence 1 repeat R1: stopped** (same path). Switch OFF: remains.
3. **Sequence 2 (a blank drawing gained A's job, changed counter 0 to 1): stopped;** nothing is written, so the counter stays 0. Switch OFF: remains.
4. **Sequence 2 repeat R2: stopped.** Switch OFF: remains.
5. **R3, CDS alone: stopped** (CDS is on the same list). Switch OFF: remains.
6. **C3, the other order (A became the second job's 2 pits and 46 pipes): stopped.** Switch OFF: remains.
7. **Sequence 3 (back to A, no fault) and the controls (a circle then U; cancelled PIT and CD):** with the switch on nothing is written at all, not even the harmless path and format refresh the robot saw.
8. **So the whole protection for BUG-1456 sits behind an off-by-default switch** that also carries the riskier parts of this change (the Civil mark, the held update, see FIX FIRST 2 and 3). As shipped, a colleague or Tim gets no protection.

**Doors left open, switch on or off (by reading):**

1. **The end-of-command write was one way in; the door itself has no check.** `FlushPendingSave(drawing)` with nothing waiting still writes the record in memory into the drawing it is handed (`Persistence.cs` 459-475), and `SaveProjectData(drawing)` still aims the record in memory at the drawing it is handed (`Persistence.cs` 316-354). Neither asks whether the record in memory is that drawing's own; CE already has the question (`TryPeekCurrent`, `ProjectDataService.cs` 162-176). About 25 places call `FlushPendingSave(drawing)` directly. I checked two that bind first (Inspector "use plan label", `InspectorPaletteService.cs` 3187-3197; linked text edits, `LinkService.LinkedTextEdits.cs` 59). I did not trace the rest.
2. **After one wrong write the mix-up keeps itself going:** every write sets "the record's drawing" to the drawing just written (`Persistence.cs` 602), so CE then treats B as the record's own.
3. **A failed wrong write leaves a save aimed at B waiting** (`Persistence.cs` 1476 keeps it waiting), so even with the switch on, CDHELP's end in B would then write A's record into B.

## FIX FIRST

1. **Take BUG-1456's fix out from behind the switch.** It is a seen HIGH data fault on the installed build, and the cure never stops a correct write. Suggested (DRAFT default for Tim, R-00 allows a protection with no switch because it is never right to write one job into another): (a) CDHELP and CDS come off the list of 16 always (they change nothing in CE's record: the Settings window does not call the record at all, searched `Dialogs\AdvancedSettings*` and `ViewModels\AdvancedSettings*`; Help opens a page); (b) the record writer refuses, with a log line, to write when the record in memory is not the target drawing's own (the check belongs in `PerformPendingSaveLocked` before line 601, so every caller is covered, not only the command end). Add the robot's two-drawing sequences as a check with a deliberately faulty version (today's writer) that must be noticed.
2. **Esc does not reach the code that drops an owed "Civil" mark, so the mark leaks into the next command.** AutoCAD ends a CE command through its "cancelled" event when Esc is pressed at a prompt (CE's own notes: `CommandOutcomeLogService.cs` 85-86, "AutoCAD reports every Esc as a cancel"; the BUG-874 change log, "AutoCAD ends that CD through its 'cancelled' event"). The cancelled and failed handlers never call the end-of-command write (`LinkService.Reactors.cs` 1427-1441, 1655-1659), and the owed mark is dropped only there (`Reactors.cs` 2081-2086, the one call of `DropOwedActiveMark`). So on a drawing with no mark yet (a new drawing, the first CE tool used in it): PIT, Esc, then any command that adds anything (a LINE) has CE write its whole record and the Civil mark at the end of that LINE, inside the LINE's Undo step (`ProjectDataService.CancelWritesNothing.cs` 173-200 counts "added anything" from AutoCAD's next free object number, which the LINE moves). Meanwhile CE treats that drawing as Civil (`Persistence.cs` 666-668). Fix: drop an owed mark at the cancelled and failed ends too (and when the switch is turned off while one is owed: the drop is behind the switch at `Reactors.cs` 2084), and add a case that goes through the cancelled path.
3. **With the switch on, an update that really changed something no longer writes when it finishes; after Esc it waits for your next command.** While CE's record update runs, a save it asks for now waits (`Persistence.cs` 359-368); when the update ends, a "nothing changed" save is dropped, but a "something changed" save is only left waiting (`CancelWritesNothing.cs` 77-96), never written there. Today it is written at once, inside the running command (PIT runs its update before its first question, `Commands\PitCommand.cs` 111 then 115). After a window Cancel the command's end writes it, same step, fine. After Esc (the cancelled event, no end-of-command write) it is written at the end of whatever you do next, so one U then takes back your next edit and CE's hidden update together: the exact fault the end-of-command write was built to stop (its own note, `Reactors.cs` 2049-2053). The same applies to a record kept for a drawing and brought back on attach (`Mutations.cs` 203-208; the attach save that wrote it is now skipped, 188-189). Fix: when the update ends and its save is kept, write it then under the old "write now or wait" rule, so only the changed-nothing case differs from today.
4. **The proof does not touch the paths that matter.** The unit tests are truth tables of the new rule and text searches of the source; the "deliberately faulty version" there is the rule's own switch-off answer, not a faulty build (`Drainage.Tests\Services\CancelWritesNothingTests.cs` 56-101). TRUST-CANCEL-01 (`Drainage.HeadlessProof\TrustChecks.cs`, new block) drives real code but: it calls the end-of-command routine directly, which Esc never reaches; it runs on a drawing whose record is already attached (so `SetDrawingPath` returns early, `Mutations.cs` 163-172, and the attach is never exercised) and which already has the mark (so the owed mark is never exercised); it runs CDHELP on the SAME drawing, so BUG-1456 is not covered; and nothing checks that a real change is still written and still one U. Add: the cancelled path, a second drawing, a drawing with no mark, and one positive case (a real change written once, one U takes it back).
5. **The words claim more than the build does.** The PR's FOR TIM says "Help and CD Settings can never write one job's pits and pipes into another drawing" and "PIT, then Esc: nothing is written". Both are true only with the switch on, only by the end-of-command route, and the second not after Esc on an unmarked drawing (item 2). Say so plainly until items 1 and 2 are fixed.

## Smaller (fix with the above, not blocking alone)

1. `PIPEINFO` and `CDCALCOLD` are on the list of 16 but no Civil command has those names (searched `*.cs` and `*.json`); harmless, but the PR and the test call them commands.
2. "Added anything" is read from AutoCAD's next free object number. I believe a preview whose objects are thrown away still moves it; if so, a cancelled preview in an unmarked drawing would still write the mark. Not checked.
3. If a command runs another command inside itself that adds nothing, the inner command's end drops the owed mark, and a pit placed later by the outer command is written without the mark. Harmless in practice: a stored record counts as Civil content on its own (`Persistence.cs` 688-691).
4. With the switch on, every update now turns the whole record into text twice (`CancelWritesNothing.cs` 68, 85). Not measured on the 200-pit made-up job.

---

## What each of the 16 listed commands does now (switch on, by reading)

1. **CD, PIT, Edit Pit (PITEDIT), Edit Pipe (PIPEEDIT), CDLPD, CDLPDRESET, CDTAG, CDUPGRADE, CDPIPEOVERRIDE, CDPIPEOVERRIDECLEAR, CDMA:** at their end the record is written only if a save is waiting for their drawing. Every real change I followed leaves one (below). A window closed with Cancel or the X with nothing changed: nothing written. Esc at a prompt: their end-of-command write never ran (before or after); what changes is the attach, the mark and the update.
2. **CDCALC:** writes its own draft straight into the drawing in its own transaction (`Services\CalculationWorkspacePersistenceService.cs` 82-106), untouched; its end now writes nothing extra.
3. **CDS and CDHELP:** nothing is written at their end (BUG-1456 stopped, switch on only).
4. **PIPEINFO, CDCALCOLD:** no such commands (smaller item 1).

## Could an accepted change now be lost? (switch on, by reading)

1. **Every real change I followed goes through a record call that leaves a save waiting, which the end still writes:** CD's schedule rows and its uphill answer (`Commands\CdCommand.Schedule.cs` 76-122, 146-170, through `AddPipe` and `ApplyUphillDecisionToPipeRow`); CDUPGRADE (`Commands\LinkCommands.cs` 1040-1105, `AddPit`, `AddPipe`, then the update); CDLPD's pipe ends (`Commands\LpdCommand.cs` 214-226, `UpdatePipeEndpointsByHandle`); Edit Pipe and Edit Pit hold their writes until accepted and keep the save waiting (`ProjectDataService.RecordWriteHold`), Edit Pit also writes at once (`PitEditCommand.cs` 437, 1907).
2. **The changed-nothing drop compares the same text the save stores** (`CancelWritesNothing.cs` 85 against `Persistence.cs` 1449), and a save already waiting before the update is never dropped (`CancelWritesNothing.cs` 65, 87). The tidy-up done inside the save (`NormalizeProjectData`, `Persistence.cs` 314) runs before the compare, so a tidy-up difference counts as a change: safe direction.
3. **Attaching no longer saves, but the drawing being left is still written whenever a save is waiting for it** (`Mutations.cs` 183-185), and a record kept for a drawing still comes back waiting (`Mutations.cs` 203-208).
4. **Not lost, but moved:** FIX FIRST 3.
5. **Not traced:** every branch of CDMA, CDTAG, CDLPDRESET, the two pipe override commands and PIT's placement branches; record edits made by changing a pit or pipe object fetched from the live record without a save call (the getters hand back the live object, `ProjectDataService.Queries.cs` 29-60; the three direct list replacements I found are not in the 16, `CdJointCommand.cs` 134, `SlabCommand.cs` 1843, `LinkService.Utilities.cs` 429).

## The four defaults the builder listed

1. **Switch off:** right while items 1 to 4 are open; but item 1 should not wait for the switch.
2. **An older-format record is not brought up to date by merely attaching it:** safe. CE reads older formats and brings them up to date in memory; the drawing keeps the older text until a real change, which an older CE on a colleague's PC also reads. Worth knowing: tools that read the stored text directly (the reader, the opening line) see the older format until then.
3. **The "Civil" mark dropped for a command that added nothing:** safe in itself (a drawing with a stored record counts as Civil anyway, `Persistence.cs` 688-691), but see FIX FIRST 2: on Esc it is not dropped.
4. **"Changed nothing" judged on the whole record's text:** safe direction (any difference keeps the save). Cost not measured.

## Switch OFF equals today (by reading)

Every new branch returns the installed answer with the switch off: the housekeeping scope (`CancelWritesNothing.cs` 51-52), the held save (`Persistence.cs` 361), the drawing being left (`Mutations.cs` 183-185), the end-of-command decision (`Reactors.cs` 2058-2070, same decision, the old catch moved inside a try with a `finally` that does nothing with the switch off), the mark (`CancelWritesNothing.cs` 119-120), the update compare (`CancelWritesNothing.cs` 62-63, 82-83) and the "is this drawing Civil" answer (no mark is ever owed with the switch off). One exception: a mark owed while the switch was on stays owed if the switch is then turned off (smaller, inside FIX FIRST 2).

## Nothing existing weakened

No existing test, check or baseline file is changed (the diff adds one test file and one headless check; `C7-HOLD-01` stays last in `ProofCommands.cs`). The lane reports the full Civil test project green; I did not re-run it.

## PRs 2053 and 2055

1. **Neither sits on this PR.** Both are cut from `cf059dcf` (heads unchanged since their last reviews: 2053 `9ffbeccb`, 2055 `2629343d`).
2. **2055 complements it, always on:** it moves CDSL's, CDWT's and the source tools' update after the first pick and binds without saving (`Commands\SpotLevelCommand.cs`, `WaterTankCommand.cs`, `SourceBlockInsertCommands.cs`). It does not duplicate this PR; its own FIX FIRST list stands (`reviews\claude-trust04-cancel-cdtg-cdsl-cdwt.md`).
3. **2053 is tests only** and reads CD's method text; the CD end-of-command write it found is cured here only with the switch on. Point its guard at the end-of-command rule, or mark it superseded once this is fixed.
4. Expect a REGRESSION_LOG.md conflict only.

## What I did not check

1. Built nothing and ran no test; all counts are the lane's.
2. Nothing in AutoCAD: Esc, window Cancel, the Undo grouping, two drawings, an unmarked drawing, save and reopen.
3. Whether a thrown-away preview moves AutoCAD's next free object number (smaller item 2).
4. The other ~23 direct callers of `FlushPendingSave(drawing)` for whether each binds first.
5. Every branch of the 16 commands (see "Not traced").
