# Re-review: draft PR 2049, `claude/trust-06-guesses-removed` (trust plan step 6, card TRUST-06), head `e7b9ccdc`

**Reviewer:** lane trust-review (seventh run), Fri 13 Nov 2026, 02:15 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO is evidence for testing on copies, never acceptance.
**What was read:** the one new commit `e7b9ccdc` (pushed 01:49, a fast-forward from `68032c9b`; 10 files), checked item by item against my review `reviews\claude-trust-06-guesses-removed.md`; `PENDING_TESTS.md` section "Trust plan step 6" on `main` at 02:15.

---

# FOR TIM

1. **All four faults from the last review are fixed in the code:** the relink step no longer makes up 100 with the switch on, a pit CE cannot identify is kept off the placed Pit Schedule (and listed in Check Current Drawing instead), CDUPGRADE no longer blanks a size the record holds, and the tests now go through the plugin's own code.
2. **With the "Show Unknown" switch off, as it ships, a millimetre job is still unchanged** by reading.
3. **One paperwork gap:** the change log says three new robot cases were added to the test list; they are not there yet.

**Verdict: GO** for the robot on copies, once `PENDING_TESTS.md` carries the three cases (section 2). Built yes (by its lane). Tested: unit tests only, by its lane (not re-run here). Installed no. Accepted no. Every fill-in is still engineering judgement that only Tim's word settles.

---

## 1. The last review's FIX FIRST items, one by one

1. **The relink step's made-up 100: FIXED.** `LinkService.RepairAudit.Linking.cs` 215-220 now takes the link's size, else the drawn width converted to millimetres (`DrawnWidthToSizeMm`), through `UnknownNotGuessRule.RelinkPipeSizeMm` (rule file 67-76): switch on, no usable width = 0, stored blank by `PipeSizeText` (line 235); switch off, the old "at least 100" exactly on a millimetre drawing. What it still makes up with the switch off is now counted for step 5's line (263-266). Worth knowing: with the switch off and the units switch on (the shipped pair), a metre line 0.225 wide now gets 225 here instead of 100: the intended units fix, and the change log says "both switches off" for "exactly the old rule".
2. **Tests that checked rules nothing called: FIXED.** `ReachInDrawingUnits` is now what the shipped reaches go through (`ProjectDataService.UnknownNotGuess.cs` 22-24; I compared it with the old `LinkService.ReachMmToDrawingUnits`: same sum for every unit, unitless included). `PickPipeSizeMm` is gone; `SizeIsGuess` is used by all three readers (`Recovery.cs` 400-401, 422-423; `LinkCommands.cs` 2207-2208). A new test fails if any rule function the tests check is not called by the plugin (`UnknownNotGuessTests.cs` 546-566). The broken twin is now the plugin's own size text with its switch ignored (test 94). The pit decisions are one function, `ForNewPit` (rule 160-177), which the record update calls (`Recovery.cs` 122-124).
3. **Pits CE cannot identify going into the placed Pit Schedule: FIXED.** With the switch on, a pit whose number is the internal code or whose size could not be read is left out of the schedule, in this drawing (`PitScheduleViewModel.Data.cs` 858-870) and in schedules read from attached drawings (`PitScheduleSourceSelectionService.cs` 56-58), and Check Current Drawing lists each one in plain words ("Pit left out of the Pit Schedule: its number is not known", `CurrentDrawingCheckService.cs` 501-523). Switch off: unchanged. Disclosed in the change log (item 2) with default (a) for Tim.
4. **CDUPGRADE's merge blanking a recorded size: FIXED.** `SizeForMerge` keeps the record's size when the scan's is blank (`LinkCommands.cs` 1095-1096; rule 93-94), tested both ways through the real merge (tests 283-303). Switch off: the old overwrite stands, as today.

## 2. Before the robot runs

1. **The three robot cases are not in `PENDING_TESTS.md`.** The change log (item 11) says they were added to the step 6 section: CDLINKDANGLINGPIPES then CDSYNC with the switch on (size blank, not 100); an unlabelled pit not in the placed Pit Schedule and listed in Check Current Drawing; CDUPGRADE keeping a recorded 150. The section on `main` at 02:15 has none of them (RULES 6.2: the claim is not yet true).
2. **Case 3 there is now out of date:** with the switch on the unlabelled pit is also left out of the schedule and listed by Check Current Drawing; and case 7 still says "already proven without AutoCAD" for a twin that proves the size text, not the walk.

## 3. Still open from the last review (section 3 there; before the switch is turned on for anyone, not blocking the robot)

1. **Units not set:** still read as millimetres without a word on this path; now stated plainly as default (c) in the change log.
2. **The pit number held as the internal code** (default (d)); the number label stays off after a real number is typed (change log item 9 says so).
3. **The quiet substitutes** (flow calculator, detention volume, plan label wording, Edit Pit's lid offer, CDPROPAGATE's 225): unchanged and listed.
4. **Settings page rows** for the two switches and four reaches: still window work.

## 4. Found in this round

1. **New attention items in Check Current Drawing** appear only with the switch on (`CurrentDrawingCheckService.cs` 478-523) and do not change step 1's opening-line counts (`FactsFrom` does not read attention items). Step 1's line is undisturbed.
2. **PRs 2050 and 2051 sit on the old head `68032c9b`;** neither carries these fixes until re-stacked. PR 2051's reader should use `PitNumberIsUnknown` too (see `reviews\claude-trust-08a-check-list.md`, item 2.3).
3. No client name, job number, street or suburb in the change.

## 5. Not checked

1. Did not build or run tests; counts are the lane's.
2. Nothing run in AutoCAD (switch on or off, metre copy, save and reopen, the schedule as placed).
3. Every rewritten test body; I read the test list, the called-function guard and the four tests named above.
