# Review: draft PR 2052, `claude/trust04-pit-b1042-blank-cover` (BUG-1042: a blank cover level warns instead of blocking New Pit and Edit Pit)

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:20 PC clock. Read only: nothing built, installed or merged by this lane.
**What was read:** PR 2052's description; its two commits `ca4d12a4` and `acd1a526` on base `cf059dcf` (confirmed by ancestry); the BUG-1042 carpark entry only; the readiness rule; how New Pit and Edit Pit turn the window's cover level into the record and the plan text; the Pit Schedule's cover cell; `PENDING_TESTS.md` row 10.

---

# FOR TIM

1. **It does what the bug asks and only that:** New Pit and Edit Pit no longer grey out Continue placement or Save when the cover level is blank; the window warns instead and still points at the cover box; every other check (number, type, sizes, an invert that is not a number, rotation, offset) still blocks first. A blank cover stays blank in CE's record, the Pit Schedule shows a blank cell, and the plan's cover text gets no CL line. Never 0.000, by reading.
2. **Two small oddities it makes reachable for the first time:** placing a pit with a blank cover still asks you to click where the cover text goes, then places nothing (when the cover text would be empty); and clearing a typed cover level in Edit Pit leaves an empty, invisible text object tied to the pit when CL was its only line.
3. **Verdict: FIX FIRST** (two small items). Built yes (lane, net48 and net10 0 errors). Tested unit only (lane: Pit filter 4,206 of 4,214 passed, 8 skipped; broken twin 7 of 79 fail). Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Does it fix what the bug says?** Yes. The block is removed from `FirstBlocker` and replaced by a warning in `Evaluate` (`PitStartReadiness.cs` 89-98): `CanStart` true, attention colour, the cover box named. Both New Pit and Edit Pit use this one rule for their button (`PitViewModel` `PlaceCommand`), so both are covered.
2. **Nothing else?** The only product file is `PitStartReadiness.cs`. One display side effect: the early return at line 91 also hides the "Detention mode is active" and "SPS mode is active" notes (lines 100-105) while the cover is blank. Harmless; worth knowing.
3. **Blank stays Unknown, never 0.000 (by reading):**
   1. Record: New Pit copies the window's text as typed (`PitCommand.cs` 842); Edit Pit the same (`PitEditCommand.cs` 1809). `PitData.CoverLevel` is text, so blank stays blank. The cover's source tag is left empty for a blank level (`CoverLevelSourceService.cs` 41).
   2. Plan text: `PitAnnotationTextFormatter.FormatCoverText` adds the CL line only when the level is not blank (`PitAnnotationTextFormatter.cs` 28-29).
   3. Pit Schedule: the cover cell is empty for a blank level (`PitScheduleBuilder.cs` 43).
   4. The rule book reads an unreadable cover as not known (`RulebookEngine.cs` 226).
4. **Do the tests fail without the change? Yes,** checked assertion by assertion against the base rule: `MissingCoverLevel_IsNamed_ButDoesNotBlock` (base: `CanStart` false), the second half of `MissingCoverLevel_NeverHidesARealBlocker` (base names the cover first, not the invert), `PlaceCommand_CoverLevelEmpty_CanStillPlace` and the badge test (base: button disabled), and the two window tests (base: button disabled). The first half of `NeverHidesARealBlocker` passes on the base too (the width blocks first either way); that is a guard, not a fail-first test, and is fine.

## 2. FIX FIRST

1. **New Pit asks for a cover text it will not place.** With "add cover text" on, PIT asks for the cover text corner (`PitCommand.cs` 532-543) and only then finds there is nothing to write: `CreatePitCoverText` returns nothing for an empty text (`PitCommand.cs` 763-773). Before this PR a blank cover could not reach this point. Skip the question when `FormatCoverText` would be empty (no plastic pit, no text above or below, no invert, no cover). Edit Pit's "create cover text" branch has the same question (`PitEditCommand.cs` 1453-1481).
2. **Clearing a cover level in Edit Pit leaves an empty text on the plan.** When the pit already has a cover text, Edit Pit turns "add cover text" on at open (`PitEditCommand.cs` 205-207). Clear the level and Save (now allowed): the update branch (1484-1496) sets the text's contents to nothing (`UpdateCoverTextContents`, 1502-1525) and keeps it as the pit's cover text: an invisible object. When the new contents are empty, erase it as the "no cover text" branch does (1447-1451).

## 3. Worth knowing

1. **The warning's words** ("No cover level yet ...") read oddly after a drafter has just cleared a real level in Edit Pit. The wording is marked DRAFT for Tim.
2. **A cover typed as something that is not a number** is still not checked, before and after this PR. Not this bug.
3. **The multi-pit edit has its own path** that stops with "The accepted pit cover text is empty." when it is asked to add a cover text with nothing in it (`PitEditCommand.Batch.cs` 889-893). It does not use the readiness rule and is not changed here; one robot case on it would settle whether a blank cover can reach it.
4. **Remembered values:** a blank cover is remembered as blank (`PitViewModel.cs` 1238), so with "propose last cover level" on, the next pit opens blank. Consistent with the bug.
5. **No off switch** (card TRUST-04 section 2). **No client name, job number, street or suburb** in the diff.

## 4. Not checked

1. Not built or run by me. Nothing seen in AutoCAD.
2. Whether the long section, the calculators and CDDESIGN read a blank cover as "not known" (the PR lists these as not read either).
