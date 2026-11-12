# Review: draft PR 2049, `claude/trust-06-guesses-removed` (trust plan step 6, card TRUST-06: Unknown instead of made-up values)

**Reviewer:** lane trust-review (sixth run), Fri 13 Nov 2026, 01:22 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO would be evidence for testing on copies, never acceptance.
**What was read:** PR 2049's description; `git diff faa4d7d5...origin/claude/trust-06-guesses-removed` at head `68032c9b` (one own commit `ae4ef5a6` plus two merges of step 5; 14 files). The real parent is `faa4d7d5`, which is still the head of step 5 (PR 2045), the one I re-reviewed in the fifth run, so step 5 and step 1 under it are undisturbed. Checked against card `TRUST-06_GUESSES_REMOVED_CARD_DRAFT_2026-11-12.md`, my card review `reviews\card-TRUST-06.md`, `CODE_FACTS_13NOV.md` section A, `TRUST_PROBES_13NOV.md` section 4 and the robot steps in `PENDING_TESTS.md` ("Trust plan step 6"). Code outside the diff read on the branch itself (`git show`), file and line below.

---

# FOR TIM

1. **With the new "Show Unknown" switch off (as it ships), nothing changes on a millimetre job; with it on, most made-up 100 / UPVC / lid / pit type / pit number values become blank, and in a metre drawing CE stops looking 2 km for a pit's label.**
2. **One place that adds pipes to CE's record still writes a made-up 100 with the switch on, although the pull request says it is covered,** and a pit with no label or no size would go into the placed Pit Schedule under a meaningless internal code, "0 x 0" and a blank lid.
3. **Several tests check rules that the real code never uses,** so they would stay green even if the shipped behaviour were wrong.

**Verdict: FIX FIRST** (four items in section 2). Built yes (by its lane). Tested: unit tests only, by its lane (22,303 ran, 22,271 passed, 32 skipped, 0 failed; not re-run here). Installed no. Accepted no. Every fill-in here is engineering judgement: only Tim's word settles what each should be.

---

## 1. What the brief asked, answered

1. **Switch OFF: is today's behaviour provably kept?** By reading, YES for every changed line on a millimetre or no-units drawing; I traced each one (pit number, plastic rule, lid, pit type, material, size text, guessed-100 drop, label reach, restore distance, Edit Pipe, the step 5 counts). The proof in tests is per rule, not per path: `SwitchOff_GivesTheOldFillInsExactly` (test file line 33) would fail if a rule's OFF answer changed, but the wiring is pinned only by source text ("this call is present"), so for example `AddLabel = !numberUnknown` (`ProjectDataService.Recovery.cs` 159) could be changed to always off without a red test. Robot case 1 in `PENDING_TESTS.md` (the millimetre job, nothing differs) is the real proof and is the right first case.
2. **But the shipped defaults DO change metre drawings.** The second switch, "reaches follow the drawing's units", ships ON. In a metre drawing that changes the pit-label reach, CDUPGRADE's level-text reach, the restore-by-position distance and the size read from a line's drawn width (0.225 now reads 225, it read 0). That is the intended fix and the PR says so, but the PR title's "switch OFF" is true only of the Unknown switch.
3. **Every fill-in in CODE_FACTS section A, covered or listed:**
   1. 100 and UPVC on reading: covered in the record update (`ProjectDataService.Recovery.cs` 173-185, 398-428), CDSYNC and CDUPGRADE (`LinkCommands.cs` 1094-1096, 2200-2210). **NOT covered in the relink step, which the PR claims** (section 2, item 1).
   2. Lid from the opener's Settings: covered in the record update (`Recovery.cs` 126-134); CDUPGRADE's "Class A" covered (`LinkCommands.cs` 2101).
   3. Pit type: covered (`LinkService.PitOutline.cs` 425; `Recovery.cs` 144).
   4. Next-free pit number: covered in both readers (`Recovery.cs` 113-118; `LinkCommands.cs` 2065-2070).
   5. A blank pit number stored as the internal object code: deliberately kept (PR default (d)); see section 3, item 1.
   6. Edit Pipe's 100 and UPVC: covered; the window opens blank (`PipeEditCommand.Update.cs` 25-33). Pressing OK with the size still blank is refused with "The diameter is not a number." (same file 285-288): no crash, nothing made up, but the words could say "Type the pipe size."
   7. Edit Pit's Class C: listed "not covered", with a reason.
   8. CDPROPAGATE's 225: listed "not covered", with a reason.
   9. Cloning and the pipe split's 100 (`LinkService.Split.cs` 1883): listed "not covered".
   10. The Pit Schedule writing the drawn size back on opening, and its "0 x 0": listed "not covered".
4. **Is Unknown really stored as blank or marked, and does it survive save and reopen?** Pipe size, material, lid and pit type: stored blank, YES. Pit number: stored as the symbol's internal code (not blank), and the "this is Unknown" check (`UnknownNotGuessRule.PitNumberIsUnknown`, rule file 117) is called by no shipped code, only by tests. Survives save and reopen: the test (`AnUnknownSavedInTheRecord_ReopensAsTheSameUnknown`, line 233) is a plain JSON round trip, not CE's own save path; I searched the record's load and update code for anything that refills a blank size, material, lid or type and found none (only scoring, the Inspector's "Missing diameter" warning, and restore-from-snapshot of the drafter's own values). Robot case 6 is the real proof.
5. **Reaches now Settings values in millimetres, converted, including the pit width:** YES for +2000 (record update `Recovery.cs` 343-344, CDUPGRADE `LinkCommands.cs` 1978-1979), +2500 (`LinkCommands.cs` 2021-2022) and 200 (`Recovery.cs` 836, the one restore path the record update uses). The pit width is added in millimetres and converted together with the reach; the scan's widths are real millimetres through the BUG-317 reader (`Recovery.cs` 246-249, `LinkCommands.cs` 1316-1320), so the sum is right. 50 already unit-safe, now a Settings value. Two older overloads still use 200 unconverted (`Recovery.cs` 868, and the three-argument `ProjectDataRecoveryGuardService.RestorePitUserData` 105-106); no shipped code calls either, so tidy only.
6. **A drawing with units not set is not silently treated as millimetres:** NOT MET, and honestly listed (PR "not covered" 10). Such a drawing still reaches about 2 km if it is really in metres. The existing note (`LinkService.PitOutline.cs` 74-100) fires only when both coordinates are six digits or more (survey coordinates) and only from pipe-end searches (`LinkService.Geometry.cs` 1226, `LinkService.NewPipeEnds.cs` 29, `LinkService.PitOutline.cs` 724), never from the label reach. See section 3, item 2.
7. **Drawn width converted to millimetres before matching a size:** YES (`UnknownNotGuessRule.cs` 59-77: convert, then match within 0.5 mm, else Unknown with the switch on). With the units switch off and the Unknown switch on, a metre width is matched raw and reads Unknown: acceptable. Except the relink step (section 2, item 1), which still uses the raw width.
8. **What the downstream tools do with a blank (from CODE_FACTS A, not run):** Pit Schedule window "?" for a blank size (`PitScheduleViewModel.cs` 1353, 1511) and a blank cell for a blank lid; Inspector "Missing diameter" / "Missing material" (`InspectorPaletteService.cs` 3370-3374); CDRULES and the size check say Unknown with a reason; the long section refuses with a plain reason for a blank size. Quiet substitutes remain: the pipe flow calculator (last size or 300), the detention pipe volume (pipe left out), the design dashboard and the long section for a blank material (a Settings value or a fixed roughness), and plan labels (" DIA. ... PIPE"). The PR lists these and says they must be settled before the switch is turned on for anyone. No crash is known; none was run.
9. **Does step 5's "CE updated its record" line still tell the truth with step 6 on?** Mostly. Step 6 stops step 5 noting guesses only where it stops making them (`Recovery.cs` 136-139, 178-185), which is right. But the relink step's 100 (section 2, item 1) is neither prevented nor counted (step 5 counts fill-ins only in `Recovery.cs`), so with the switch on the line would say "1 pipe added" while a made-up 100 sits in the record. Also worth knowing: the line says "pipes added" without "size Unknown".
10. **Nothing existing weakened:** no existing test edited or removed (the only test file in the diff is new); BUG-698's "recorded size first" call kept and pinned; the step 5 count lines are gated, not removed.

## 2. FIX FIRST

1. **The relink step still makes up 100, and reads the drawn width unit-blind, with the switch on, although the PR says this step is covered.**
   1. `LinkService.RepairAudit.Linking.cs` 215-216: `if (diameter <= 0) diameter = Math.Max(100.0, pline.ConstantWidth);`, written at 231. Only the material on line 232 goes through the new rule.
   2. This step adds a record row for a pipe line that has CE's link but no row. It runs from CDSYNC's pipe-end step (`UpdatePipeEndpointsFromProjectData`), from every pipe geometry change (`LinkService.Geometry.cs` 245), and is the likely way a pipe registered by CDLINKDANGLINGPIPES gets its row (that command writes the link with size 0, `LinkService.RepairAudit.Relink.cs` 294). A metre line 0.225 wide also becomes 100 here, so the "drawn width follows the units" claim is not true on this path either.
   3. Fix: size through the same rule as the record update (drawn width converted and matched, nothing known = blank with the switch on, 100 with it off), a source pin on this file, and a robot case: switch on, CDLINKDANGLINGPIPES on a plain line, then CDSYNC: size blank, not 100.
2. **Several tests check rule functions that no shipped code calls, so they prove nothing about what ships.**
   1. `UnknownNotGuessRule.ReachInDrawingUnits` (rule 133) is used only by tests. The shipped reaches go through `ProjectDataService.TrustReachInDrawingUnits` and `LinkService.ReachMmToDrawingUnits`. So `AReach_IsTheSameRealDistance...` (test 156) and card case 3, `ALabelOneAndAHalfMetresAway...` (test 165), would stay green if the shipped label reach were still 2 km.
   2. `PickPipeSizeMm` (rule 32) is used only by tests, so `ARecordedOrDrawnSize_IsNeverReplaced` (test 49) does not test the shipped path, where the guess flag is worked out separately in each reader (`Recovery.cs` 401-405, 421-427; `LinkCommands.cs` 2203-2210).
   3. The broken twin (test 60) checks a hand-written lambda against a predicate; it shows the predicate catches "100", not that the shipped code cannot write it. `PENDING_TESTS.md` case 7 calls this "already proven without AutoCAD".
   4. Fix: point these tests at the functions the code calls (or remove the unused ones), and make the twin the real size text with the switch ignored. Name what the tests prove.
3. **With the switch on, pits with no label, or with no readable size, would go into the placed Pit Schedule under a meaningless code. Not disclosed.**
   1. Plastic rule now only for a known size (`UnknownNotGuessRule.cs` 93-99), and the record update schedules every pit that is not plastic (`Recovery.cs` 162, `IncludeInSchedule = !isPlastic`). Today a pit whose size cannot be read (0 x 0) counts as plastic and is left out; with the switch on it goes in.
   2. Its row would print the internal code as the pit number (the number is the symbol's code, section 1 item 4), "0 x 0" (CODE_FACTS A8) and a blank lid. A labelled-size pit with no label (600, not plastic) prints its code too. The placed table is on the council print (card review finding 5).
   3. Fix: say it in the PR and change log, add a robot case, and keep code-numbered rows off the placed table (or warn before placing, never block) before the switch is turned on for anyone.
4. **With the switch on, CDUPGRADE's merge blanks a size the record already holds.**
   1. `LinkCommands.cs` 1094-1096 passes the scan's size text to `UpgradeMergePipeRow.Build`, which overwrites the existing row's size unconditionally (`Rules\UpgradeMergePipeRow.cs` 33). When the line has no drawn width and its link holds no size, the scan's size is Unknown, so a size typed into the record (for example 150) becomes blank. Today the same path writes 100 over it.
   2. Step 6's promise is Unknown only where nothing is known. Fix: when the scan's size is Unknown, keep the record's size; a test each way.

## 3. Before the Unknown switch is turned on for anyone (not blocking a robot run on copies)

1. **The pit number held as the symbol's code (default (d)).** The "number Unknown" mark is recognised by nothing that ships (windows, schedule, labels and the step 5 line all show the code). It depends on number = the symbol's current code: a pit symbol given a new code (re-inserted, or copied into another drawing) leaves the old code looking like a real number. And the label switch stays off after the drafter types a real number (`Recovery.cs` 159; restore puts it back, 953), so the drafter must also turn the label on. A stored "number Unknown" flag would be steadier.
2. **Units not set:** reuse the existing "pit drawn much smaller than its real size" check (`DrawingAreaUnits.PitDrawnSmallerThanUnitsSay`, C6-17) or the survey-coordinate note in the record update, and say once in plain words that distances are read as millimetres. Card review finding 3; plan case 3.
3. **The quiet substitutes in section 1 item 8** (flow calculator, detention volume, dashboard and long section material, plan label wording) and Edit Pit's Class C offer.
4. **Settings page rows:** neither switch nor the four reaches is on the Settings page yet ("window work still to come", change log item 4); the card's section 4 puts them there (R-00).
5. **The office pipe size list used for matching is the opener's own Settings** (`ProjectDataService.UnknownNotGuess.cs` 37-39), so two PCs with different lists can read the same line differently. Belongs with TRUST-03.

## 4. Worth knowing

1. In a metre drawing with the default switches, a line drawn with a thin display width (say 0.05) now records "50" where it recorded "0". Same as a millimetre drawing today.
2. `PENDING_TESTS.md` case 2 expects "step 5's line has no 'Guessed' sentence"; with item 2.1 unfixed that case passes on CDSYNC even though the relink path can still write 100. Add the CDLINKDANGLINGPIPES case.
3. No client name, job number, street or suburb in the diff, tests or change log.

## 5. Not checked

1. Did not build or run tests; counts are the lane's.
2. Nothing run in AutoCAD: no reading of a real or made-up drawing with either switch, no metre copy, no save and reopen, no window seen.
3. A pipe object given size 0 by CDSYNC with the switch on (whether its walls draw at zero width); the X-Civil import's own 100 and "Class A" fills (outside CODE_FACTS A and the card).
4. AutoCAD 2022 to 2024 (net48 compiles by the lane's word).
