# Review: PR 2084 `claude/trust04-b1318-source-number-never-reused` (BUG-1318, CDSOURCE never gives out a number twice)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:34 PC clock. **Head reviewed:** `7cfb9b69` (one commit on `cf059dcf`, the installed Civil 3.0.90, confirmed as its parent). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **Erase ROOF DRAIN 3 and place another ROOF DRAIN: it is now ROOF DRAIN 4, not 3 again.** CE already writes down the highest number it has given out each time a source is placed; CDSOURCE's naming now reads that note as well as the sources still on the drawing.
2. **Nothing new is written by the naming step,** no figure changes, and one U after placing still takes the number back (the note is written in the same step as the source).
3. **One gap:** a source name with a digit or a sign in its words (for example "A/C UNIT" or "2-WAY VALVE") never gets that note written, so for those names the old behaviour stays. Worth fixing or listing.

**Verdict: GO** for the robot on copies, small items below.

---

# Findings (file and line at `7cfb9b69` unless stated)

1. **Correct for ordinary names, by reading.** Placing a source calls `SourceTagService.SetTag` (installed `SourcePlacementService.cs:1059`, `1190`, `1355`, `1506`), which calls `AdvanceSequenceHighWaterForAssignedTag` (installed `SourceTagService.cs:442-466`): the family is `SourceFamilies.CategoryOf(tag)` ("ROOF DRAIN 3" gives "ROOF DRAIN"), the number after it is stored if higher. The new `ReadStoredHighWater` (`SourceTagService.cs:246-260`) looks up `GetTagCategory(name)`, the same `CategoryOf`, so "ROOF DRAIN" finds what "ROOF DRAIN 3" stored. `GenericSourceTypes.NextNumberedName` (`Rules/GenericSourceTypes.cs:73-78`) starts from the stored number and still counts live tags above it.
2. **Reads only.** `ReadSequenceHighWater` (installed `SourceTagService.cs:242-293`) opens every dictionary for read and returns 0 when nothing is stored; the naming step's transaction is open-close. No Undo step added.
3. **Undo.** The stored number is written in the placing transaction, so U after placing ROOF DRAIN 3 takes the note back too and the next one is 3 again, which is right.
4. **Small: names with a digit or a sign.** `CategoryOf` keeps only the letters and spaces before the first other character (installed `SourceFamilies.cs`, `CategoryOf`). For "A/C UNIT 3" the family is "A", the rest does not read as a number, so no note is written on placing and the fix does nothing for that name; reading "A/C UNIT" looks up family "A", which could hold another family's number and make CDSOURCE skip numbers (never a repeat). For a name starting with a digit ("100 RISER 2") the family is the whole tag and nothing is stored. Either key the generic name's note by the normalised name itself, or list it as known.
5. **Small: one more failure path.** Only `InvalidOperationException` from the stored note is caught (line 255-259); any other error there now stops the naming step, which used to read no note at all. Catching all non-fatal errors with the same log line would keep CDSOURCE as robust as before.
6. **Tests.** `Trust04B1318SourceNumberTests`: the numbering rule cases are real calls (stored 3 with tags 1 and 2 gives 4; no stored number unchanged; a live tag above the stored one still counts); the wiring is a text search. Missing: that the key the naming step reads equals the key placing writes, for a name of several words, which is the whole fix (`SourceFamilies.CategoryOf("ROOF DRAIN") == SourceFamilies.CategoryOf("ROOF DRAIN 3")`). Add it, with the digit and sign cases from item 4 showing what happens.
7. **No PENDING_TESTS row** for 2084 yet. The bug's own steps are the case: ROOF DRAIN 1, 2, 3; erase 3; CDSOURCE ROOF DRAIN gives 4. Add: U straight after placing 4 then CDSOURCE gives 4 again; a copy of an older drawing whose sources were placed before the note existed numbers as today.

# What I did not check

1. No build or test run; the lane's 243 of 243 and broken twin not re-run.
2. Which of the four `SetTag` calls CDSOURCE's generic route uses (all four advance the note, so it does not change the answer).
3. Copied sources (COPY of a tagged source keeps its tag): a separate fault, not this bug.
